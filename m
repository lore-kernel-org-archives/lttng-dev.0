From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH lttng-tools] Add wrappers for pipe
Date: Mon, 13 May 2013 16:27:16 -0400
Message-ID: <1368476836-13803-1-git-send-email-dgoulet__33047.1452129588$1368476883$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UbzLE-0001Qu-Lp
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 16:27:28 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is to help use pipes in a way where partial read/write and EINTR
are handled in one single call site.

Two new files are created, pipe.c/.h which are part of libcommon. The
open, close, read_close, write_close, read and write calls are
implemented using a custom lttng_pipe data structure and protected by
operation's mutex. A destroy function is also available to cleanup
memory once done with a pipe.

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/common/Makefile.am |    3 +-
 src/common/pipe.c      |  362 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/common/pipe.h      |   76 ++++++++++
 3 files changed, 440 insertions(+), 1 deletion(-)
 create mode 100644 src/common/pipe.c
 create mode 100644 src/common/pipe.h

diff --git a/src/common/Makefile.am b/src/common/Makefile.am
index f2ea40a..6ba6c2b 100644
--- a/src/common/Makefile.am
+++ b/src/common/Makefile.am
@@ -13,7 +13,8 @@ noinst_HEADERS = lttng-kernel.h defaults.h macros.h error.h futex.h \
 noinst_LTLIBRARIES = libcommon.la
 
 libcommon_la_SOURCES = error.h error.c utils.c utils.h runas.c runas.h \
-                       common.h futex.c futex.h uri.c uri.h defaults.c
+                       common.h futex.c futex.h uri.c uri.h defaults.c \
+                       pipe.c pipe.h
 libcommon_la_LIBADD = -luuid
 
 # Consumer library
diff --git a/src/common/pipe.c b/src/common/pipe.c
new file mode 100644
index 0000000..713db97
--- /dev/null
+++ b/src/common/pipe.c
@@ -0,0 +1,362 @@
+/*
+ * Copyright (C) 2013 - David Goulet <dgoulet@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License, version 2 only, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 51
+ * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include <common/common.h>
+
+#include "pipe.h"
+
+/*
+ * Lock read side of a pipe.
+ */
+static void lock_read_side(struct lttng_pipe *pipe)
+{
+	pthread_mutex_lock(&pipe->read_mutex);
+}
+
+/*
+ * Unlock read side of a pipe.
+ */
+static void unlock_read_side(struct lttng_pipe *pipe)
+{
+	pthread_mutex_unlock(&pipe->read_mutex);
+}
+
+/*
+ * Lock write side of a pipe.
+ */
+static void lock_write_side(struct lttng_pipe *pipe)
+{
+	pthread_mutex_lock(&pipe->write_mutex);
+}
+
+/*
+ * Unlock write side of a pipe.
+ */
+static void unlock_write_side(struct lttng_pipe *pipe)
+{
+	pthread_mutex_unlock(&pipe->write_mutex);
+}
+
+/*
+ * Internal function. Close read side of pipe WITHOUT locking the mutex.
+ *
+ * Return 0 on success else a negative errno from close(2).
+ */
+static int _pipe_read_close(struct lttng_pipe *pipe)
+{
+	int ret, ret_val = 0;
+
+	assert(pipe);
+
+	if (!lttng_pipe_is_read_open(pipe)) {
+		goto end;
+	}
+
+	do {
+		ret = close(pipe->fd[0]);
+	} while (ret < 0 && errno == EINTR);
+	if (ret < 0) {
+		PERROR("close lttng read pipe");
+		ret_val = -errno;
+	}
+	pipe->r_state = LTTNG_PIPE_STATE_CLOSED;
+
+end:
+	return ret_val;
+}
+
+/*
+ * Internal function. Close write side of pipe WITHOUT locking the mutex.
+ *
+ * Return 0 on success else a negative errno from close(2).
+ */
+static int _pipe_write_close(struct lttng_pipe *pipe)
+{
+	int ret, ret_val = 0;
+
+	assert(pipe);
+
+	if (!lttng_pipe_is_write_open(pipe)) {
+		goto end;
+	}
+
+	do {
+		ret = close(pipe->fd[1]);
+	} while (ret < 0 && errno == EINTR);
+	if (ret < 0) {
+		PERROR("close lttng write pipe");
+		ret_val = -errno;
+	}
+	pipe->w_state = LTTNG_PIPE_STATE_CLOSED;
+
+end:
+	return ret_val;
+}
+
+
+/*
+ * Open a new lttng pipe and set flags using fcntl().
+ *
+ * Return a newly allocated lttng pipe on success or else NULL.
+ */
+struct lttng_pipe *lttng_pipe_open(int flags)
+{
+	int ret;
+	struct lttng_pipe *p;
+
+	p = zmalloc(sizeof(*p));
+	if (!p) {
+		PERROR("zmalloc pipe open");
+		goto error;
+	}
+
+	ret = pipe(p->fd);
+	if (ret < 0) {
+		PERROR("lttng pipe");
+		goto error;
+	}
+
+	if (flags) {
+		int i;
+
+		for (i = 0; i < 2; i++) {
+			ret = fcntl(p->fd[i], F_SETFD, flags);
+			if (ret < 0) {
+				PERROR("fcntl lttng pipe %d", flags);
+				goto error;
+			}
+		}
+	}
+
+	pthread_mutex_init(&p->read_mutex, NULL);
+	pthread_mutex_init(&p->write_mutex, NULL);
+	p->r_state = LTTNG_PIPE_STATE_OPENED;
+	p->w_state = LTTNG_PIPE_STATE_OPENED;
+	p->flags = flags;
+
+	return p;
+
+error:
+	lttng_pipe_destroy(p);
+	return NULL;
+}
+
+/*
+ * Close read side of a lttng pipe.
+ *
+ * Return 0 on success else a negative value.
+ */
+int lttng_pipe_read_close(struct lttng_pipe *pipe)
+{
+	int ret;
+
+	assert(pipe);
+
+	/* Handle read side first. */
+	lock_read_side(pipe);
+	ret = _pipe_read_close(pipe);
+	unlock_read_side(pipe);
+
+	return ret;
+}
+
+/*
+ * Close write side of a lttng pipe.
+ *
+ * Return 0 on success else a negative value.
+ */
+int lttng_pipe_write_close(struct lttng_pipe *pipe)
+{
+	int ret;
+
+	assert(pipe);
+
+	lock_write_side(pipe);
+	ret = _pipe_write_close(pipe);
+	unlock_write_side(pipe);
+
+	return ret;
+}
+
+/*
+ * Close both read and write side of a lttng pipe.
+ *
+ * Return 0 on success else a negative value.
+ */
+int lttng_pipe_close(struct lttng_pipe *pipe)
+{
+	int ret, ret_val = 0;
+
+	assert(pipe);
+
+	ret = lttng_pipe_read_close(pipe);
+	if (ret < 0) {
+		ret_val = ret;
+	}
+
+	ret = lttng_pipe_write_close(pipe);
+	if (ret < 0) {
+		ret_val = ret;
+	}
+
+	return ret_val;
+}
+
+/*
+ * Close and destroy a lttng pipe object. Finally, pipe is freed.
+ */
+void lttng_pipe_destroy(struct lttng_pipe *pipe)
+{
+	int ret;
+
+	if (!pipe) {
+		return;
+	}
+
+	/*
+	 * Destroy should *never* be called with a locked mutex. These must always
+	 * succeed so we unlock them after the close pipe below.
+	 */
+	ret = pthread_mutex_trylock(&pipe->read_mutex);
+	assert(!ret);
+	ret = pthread_mutex_trylock(&pipe->write_mutex);
+	assert(!ret);
+
+	/* Close pipes WITHOUT trying to lock the pipes. */
+	(void) _pipe_read_close(pipe);
+	(void) _pipe_write_close(pipe);
+
+	unlock_read_side(pipe);
+	unlock_write_side(pipe);
+
+	(void) pthread_mutex_destroy(&pipe->read_mutex);
+	(void) pthread_mutex_destroy(&pipe->write_mutex);
+
+	free(pipe);
+}
+
+/*
+ * Read on a lttng pipe and put the data in buf of at least size count.
+ *
+ * Return 0 on success or else a negative errno message from read(2).
+ */
+ssize_t lttng_pipe_read(struct lttng_pipe *pipe, void *buf, size_t count)
+{
+	ssize_t ret, read_len, read_left, index;
+
+	assert(pipe);
+	assert(buf);
+
+	lock_read_side(pipe);
+
+	if (!lttng_pipe_is_read_open(pipe)) {
+		ret = -EBADF;
+		goto error;
+	}
+
+	read_left = count;
+	index = 0;
+	do {
+		read_len = read(pipe->fd[0], buf + index, read_left);
+		if (read_len < 0) {
+			ret = -errno;
+			if (errno == EINTR) {
+				/* Read again. */
+				continue;
+			} else if (errno == EAGAIN || errno == EWOULDBLOCK) {
+				/*
+				 * Return the number of bytes read up to this point if any.
+				 */
+				if (index) {
+					ret = index;
+				}
+				goto error;
+			} else {
+				PERROR("lttng pipe read");
+				goto error;
+			}
+		}
+		read_left -= read_len;
+		index += read_len;
+	} while (read_left > 0);
+
+	/* Everything went fine. */
+	ret = index;
+
+error:
+	unlock_read_side(pipe);
+	return ret;
+}
+
+/*
+ * Write on a lttng pipe using the data in buf and size of count.
+ *
+ * Return 0 on success or else a negative errno message from write(2).
+ */
+ssize_t lttng_pipe_write(struct lttng_pipe *pipe, const void *buf,
+		size_t count)
+{
+	ssize_t ret, write_len, write_left, index;
+
+	assert(pipe);
+	assert(buf);
+
+	lock_write_side(pipe);
+
+	if (!lttng_pipe_is_write_open(pipe)) {
+		ret = -EBADF;
+		goto error;
+	}
+
+	write_left = count;
+	index = 0;
+	do {
+		write_len = write(pipe->fd[1], buf + index, write_left);
+		if (write_len < 0) {
+			ret = -errno;
+			if (errno == EINTR) {
+				/* Read again. */
+				continue;
+			} else if (errno == EAGAIN || errno == EWOULDBLOCK) {
+				/*
+				 * Return the number of bytes read up to this point if any.
+				 */
+				if (index) {
+					ret = index;
+				}
+				goto error;
+			} else {
+				PERROR("lttng pipe write");
+				goto error;
+			}
+		}
+		write_left -= write_len;
+		index += write_len;
+	} while (write_left > 0);
+
+	/* Everything went fine. */
+	ret = index;
+
+error:
+	unlock_write_side(pipe);
+	return ret;
+}
diff --git a/src/common/pipe.h b/src/common/pipe.h
new file mode 100644
index 0000000..acd05d8
--- /dev/null
+++ b/src/common/pipe.h
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) 2013 - David Goulet <dgoulet@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License, version 2 only, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 51
+ * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef LTTNG_PIPE_H
+#define LTTNG_PIPE_H
+
+#include <pthread.h>
+
+enum lttng_pipe_state {
+	LTTNG_PIPE_STATE_OPENED = 1,
+	LTTNG_PIPE_STATE_CLOSED = 2,
+};
+
+struct lttng_pipe {
+	/* Read: 0, Write: 1. */
+	int fd[2];
+	/*
+	 * Flags of the pipe once opened. pipe(2) specifies either O_NONBLOCK or
+	 * O_CLOEXEC can be used. Flags are set using fcntl(2) call.
+	 */
+	int flags;
+
+	/*
+	 * These states are protected by the operation mutex below.
+	 */
+	enum lttng_pipe_state r_state;
+	enum lttng_pipe_state w_state;
+
+	/* Held for each read(2) operation. */
+	pthread_mutex_t read_mutex;
+	/* Held for each write(2) operation. */
+	pthread_mutex_t write_mutex;
+};
+
+/*
+ * Return 1 if read side is open else 0.
+ */
+static inline int lttng_pipe_is_read_open(struct lttng_pipe *pipe)
+{
+	return pipe->r_state == LTTNG_PIPE_STATE_OPENED ? 1 : 0;
+}
+
+/*
+ * Return 1 if write side is open else 0.
+ */
+static inline int lttng_pipe_is_write_open(struct lttng_pipe *pipe)
+{
+	return pipe->w_state == LTTNG_PIPE_STATE_OPENED ? 1 : 0;
+}
+
+struct lttng_pipe *lttng_pipe_open(int flags);
+int lttng_pipe_write_close(struct lttng_pipe *pipe);
+int lttng_pipe_read_close(struct lttng_pipe *pipe);
+/* Close both side of pipe. */
+int lttng_pipe_close(struct lttng_pipe *pipe);
+void lttng_pipe_destroy(struct lttng_pipe *pipe);
+
+ssize_t lttng_pipe_read(struct lttng_pipe *pipe, void *buf, size_t count);
+ssize_t lttng_pipe_write(struct lttng_pipe *pipe, const void *buf,
+		size_t count);
+
+#endif /* LTTNG_PIPE_H */
-- 
1.7.10.4
