From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Add wrappers for pipe
Date: Fri, 10 May 2013 13:26:22 -0400
Message-ID: <20130510172622.GA23648__22385.5365104557$1368206817$gmane$org@Krystal>
References: <1368202171-20158-1-git-send-email-dgoulet@efficios.com>
	<20130510163048.GA22988@Krystal> <518D2AE2.7030300@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Uar5M-0008CY-SR
	for lttng-dev@lists.lttng.org; Fri, 10 May 2013 13:26:24 -0400
Content-Disposition: inline
In-Reply-To: <518D2AE2.7030300@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> 
> 
> Mathieu Desnoyers:
> > * David Goulet (dgoulet@efficios.com) wrote:
> >> This is to help use pipes in a way where partial read/write and EINTR
> >> are handled in one single call site.
> >>
> >> Two new files are created, pipe.c/.h which are part of libcommon. The
> >> open, close, read and write calls are implemented using a custom
> >> lttng_pipe data structure and protected by operation's mutex. A destroy
> >> function is also available to cleanup memory once done with a pipe.
> >>
> >> Signed-off-by: David Goulet <dgoulet@efficios.com>
> >> ---
> >>  src/common/Makefile.am |    3 +-
> >>  src/common/pipe.c      |  252 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  src/common/pipe.h      |   62 ++++++++++++
> >>  3 files changed, 316 insertions(+), 1 deletion(-)
> >>  create mode 100644 src/common/pipe.c
> >>  create mode 100644 src/common/pipe.h
> >>
> >> diff --git a/src/common/Makefile.am b/src/common/Makefile.am
> >> index f2ea40a..6ba6c2b 100644
> >> --- a/src/common/Makefile.am
> >> +++ b/src/common/Makefile.am
> >> @@ -13,7 +13,8 @@ noinst_HEADERS = lttng-kernel.h defaults.h macros.h error.h futex.h \
> >>  noinst_LTLIBRARIES = libcommon.la
> >>  
> >>  libcommon_la_SOURCES = error.h error.c utils.c utils.h runas.c runas.h \
> >> -                       common.h futex.c futex.h uri.c uri.h defaults.c
> >> +                       common.h futex.c futex.h uri.c uri.h defaults.c \
> >> +                       pipe.c pipe.h
> >>  libcommon_la_LIBADD = -luuid
> >>  
> >>  # Consumer library
> >> diff --git a/src/common/pipe.c b/src/common/pipe.c
> >> new file mode 100644
> >> index 0000000..89853da
> >> --- /dev/null
> >> +++ b/src/common/pipe.c
> >> @@ -0,0 +1,252 @@
> >> +/*
> >> + * Copyright (C) 2013 - David Goulet <dgoulet@efficios.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify it
> >> + * under the terms of the GNU General Public License, version 2 only, as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful, but WITHOUT
> >> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> >> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> >> + * more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License along with
> >> + * this program; if not, write to the Free Software Foundation, Inc., 51
> >> + * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> >> + */
> >> +
> >> +#define _GNU_SOURCE
> >> +#include <assert.h>
> >> +#include <fcntl.h>
> >> +#include <unistd.h>
> >> +
> >> +#include <common/common.h>
> >> +
> >> +#include "pipe.h"
> >> +
> >> +/*
> >> + * Lock read side of a pipe.
> >> + */
> >> +static void lock_read_side(struct lttng_pipe *pipe)
> >> +{
> >> +	pthread_mutex_lock(&pipe->read_mutex);
> >> +}
> >> +
> >> +/*
> >> + * Unlock read side of a pipe.
> >> + */
> >> +static void unlock_read_side(struct lttng_pipe *pipe)
> >> +{
> >> +	pthread_mutex_unlock(&pipe->read_mutex);
> >> +}
> >> +
> >> +/*
> >> + * Lock write side of a pipe.
> >> + */
> >> +static void lock_write_side(struct lttng_pipe *pipe)
> >> +{
> >> +	pthread_mutex_lock(&pipe->write_mutex);
> >> +}
> >> +
> >> +/*
> >> + * Unlock write side of a pipe.
> >> + */
> >> +static void unlock_write_side(struct lttng_pipe *pipe)
> >> +{
> >> +	pthread_mutex_unlock(&pipe->write_mutex);
> >> +}
> >> +
> >> +/*
> >> + * Open a new lttng pipe and set flags using fcntl().
> >> + *
> >> + * Return a newly allocated lttng pipe on success or else NULL.
> >> + */
> >> +struct lttng_pipe *lttng_pipe_open(int flags)
> >> +{
> >> +	int ret;
> >> +	struct lttng_pipe *p;
> >> +
> >> +	p = zmalloc(sizeof(*p));
> >> +	if (!p) {
> >> +		PERROR("zmalloc pipe open");
> >> +		goto error;
> >> +	}
> >> +
> >> +	ret = pipe(p->fd);
> >> +	if (ret < 0) {
> >> +		PERROR("lttng pipe");
> >> +		goto error;
> >> +	}
> >> +
> >> +	if (flags) {
> >> +		int i;
> >> +
> >> +		for (i = 0; i < 2; i++) {
> >> +			ret = fcntl(p->fd[i], F_SETFD, flags);
> >> +			if (ret < 0) {
> >> +				PERROR("fcntl lttng pipe %d", flags);
> >> +				goto error;
> >> +			}
> >> +		}
> >> +	}
> >> +
> >> +	pthread_mutex_init(&p->read_mutex, NULL);
> >> +	pthread_mutex_init(&p->write_mutex, NULL);
> >> +	p->r_state = LTTNG_PIPE_STATE_OPENED;
> >> +	p->w_state = LTTNG_PIPE_STATE_OPENED;
> >> +	p->flags = flags;
> >> +
> >> +	return p;
> >> +
> >> +error:
> >> +	lttng_pipe_destroy(p);
> >> +	return NULL;
> >> +}
> >> +
> >> +/*
> >> + * Close both read and write side of a lttng pipe.
> >> + *
> >> + * Return 0 on success else a negative value.
> >> + */
> >> +int lttng_pipe_close(struct lttng_pipe *pipe)
> > 
> > we could split in pipe_close read vs write ?
> 
> Yup agreed. We have some case where we only close one side.
> 
> > 
> >> +{
> >> +	int ret, ret_val = 0;
> >> +
> >> +	assert(pipe);
> >> +
> >> +	/* Handle read side first. */
> >> +	lock_read_side(pipe);
> >> +	if (LTTNG_PIPE_IS_READ_OPEN(pipe)) {
> >> +		ret = close(pipe->fd[0]);
> >> +		if (ret < 0) {
> >> +			PERROR("close lttng read pipe");
> >> +			ret_val = ret;
> >> +		}
> >> +		pipe->r_state = LTTNG_PIPE_STATE_CLOSED;
> >> +	}
> >> +	unlock_read_side(pipe);
> >> +
> >> +	/* Handle write side. */
> >> +	lock_write_side(pipe);
> >> +	if (LTTNG_PIPE_IS_WRITE_OPEN(pipe)) {
> >> +		ret = close(pipe->fd[0]);
> >> +		if (ret < 0) {
> >> +			PERROR("close lttng write pipe");
> >> +			ret_val = ret;
> >> +		}
> >> +		pipe->w_state = LTTNG_PIPE_STATE_CLOSED;
> >> +	}
> >> +	unlock_write_side(pipe);
> >> +
> >> +	return ret_val;
> >> +}
> >> +
> >> +/*
> >> + * Close and destroy a lttng pipe object. Finally, pipe is freed.
> >> + */
> >> +void lttng_pipe_destroy(struct lttng_pipe *pipe)
> >> +{
> >> +	if (!pipe) {
> >> +		return;
> >> +	}
> >> +
> > 
> > we could add interesting asserts here:
> > 
> > if any of read/write lock is currently locked, fail with an assert. It
> > is incorrect to have a concurrent thread using the pipe while we destroy
> > it.
> 
> Makes sense.
> 
> > 
> > 
> > 
> >> +	/* If pipe is already closed or not opened, this returns gracefully. */
> >> +	(void) lttng_pipe_close(pipe);
> >> +
> >> +	(void) pthread_mutex_destroy(&pipe->read_mutex);
> >> +	(void) pthread_mutex_destroy(&pipe->write_mutex);
> >> +	free(pipe);
> >> +}
> >> +
> >> +/*
> >> + * Read on a lttng pipe and put the data in buf of at least size count.
> >> + *
> >> + * Return 0 on success or else a negative errno message from read(2).
> > 
> > I would prefer that we return similar return values to read(). We expect
> > "count - read_left" I guess.
> 
> Hmmmm on success "count" should be returned which is "index" here at the
> end of the loop.
> 
> > 
> >> + */
> >> +ssize_t lttng_pipe_read(struct lttng_pipe *pipe, void *buf, size_t count)
> >> +{
> >> +	ssize_t ret, read_len, read_left, index;
> >> +
> >> +	assert(pipe);
> >> +	assert(buf);
> >> +
> >> +	lock_read_side(pipe);
> >> +
> >> +	if (!LTTNG_PIPE_IS_READ_OPEN(pipe)) {
> >> +		ret = -EBADF;
> >> +		goto error;
> >> +	}
> >> +
> >> +	read_left = count;
> >> +	index = 0;
> >> +	do {
> >> +		read_len = read(pipe->fd[0], buf + index, read_left);
> >> +		if (read_len < 0) {
> >> +			switch (errno) {
> >> +			case EINTR:
> >> +				/* Read again. */
> >> +				continue;
> >> +			default:
> >> +				PERROR("lttng pipe read");
> >> +				ret = -errno;
> > 
> > If we already have been able to read a some bytes in the previous
> > passes, shouldn't we return that number of bytes instead ?
> 
> Don't think so. Let say we read 4 bytes out of 16 and the next read()
> fails with an error, the 12 remaining bytes won't be seen soon so we
> should definitely return an error because chances are the pipe is no
> longer usable for now.
> 
> For a non block pipe, EAGAIN/EWOULDBLOCK can be returned which does not
> mean an error so in that case we could return the number of bytes read
> up to this point and document that the caller have to expect a returned
> value less than "count" meaning EAGAIN ? (the other would be to add a
> "ret_value" to the call but in that case the ret_value will probably
> always be EAGAIN for non block pipe and with a positive returned value).

ideally, make the behavior as similar as read() as possible. so
returning a value of the number of bytes read so far would be fine.

Thanks,

Mathieu

> 
> > 
> >> +				goto error;
> >> +			}
> >> +		}
> >> +		read_left -= read_len;
> >> +		index += read_len;
> >> +	} while (read_left > 0);
> >> +
> >> +	/* Everything went fine. */
> >> +	ret = 0;
> >> +
> >> +error:
> >> +	unlock_read_side(pipe);
> >> +	return ret;
> >> +}
> >> +
> >> +/*
> >> + * Write on a lttng pipe using the data in buf and size of count.
> >> + *
> >> + * Return 0 on success or else a negative errno message from write(2).
> > 
> > Similar comments about ret values as read above.
> > 
> >> + */
> >> +ssize_t lttng_pipe_write(struct lttng_pipe *pipe, const void *buf,
> >> +		size_t count)
> >> +{
> >> +	ssize_t ret, write_len, write_left, index;
> >> +
> >> +	assert(pipe);
> >> +	assert(buf);
> >> +
> >> +	lock_write_side(pipe);
> >> +
> >> +	if (!LTTNG_PIPE_IS_WRITE_OPEN(pipe)) {
> >> +		ret = -EBADF;
> >> +		goto error;
> >> +	}
> >> +
> >> +	write_left = count;
> >> +	index = 0;
> >> +	do {
> >> +		write_len = write(pipe->fd[1], buf + index, write_left);
> >> +		if (write_len < 0) {
> >> +			switch (errno) {
> >> +			case EINTR:
> >> +				/* Write again. */
> >> +				continue;
> >> +			default:
> >> +				PERROR("lttng pipe write");
> >> +				ret = -errno;
> >> +				goto error;
> >> +			}
> >> +		}
> >> +		write_left -= write_len;
> >> +		index += write_len;
> >> +	} while (write_left > 0);
> >> +
> >> +	/* Everything went fine. */
> >> +	ret = 0;
> >> +
> >> +error:
> >> +	unlock_write_side(pipe);
> >> +	return ret;
> >> +}
> >> diff --git a/src/common/pipe.h b/src/common/pipe.h
> >> new file mode 100644
> >> index 0000000..fdff4cb
> >> --- /dev/null
> >> +++ b/src/common/pipe.h
> >> @@ -0,0 +1,62 @@
> >> +/*
> >> + * Copyright (C) 2013 - David Goulet <dgoulet@efficios.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify it
> >> + * under the terms of the GNU General Public License, version 2 only, as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful, but WITHOUT
> >> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> >> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> >> + * more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License along with
> >> + * this program; if not, write to the Free Software Foundation, Inc., 51
> >> + * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> >> + */
> >> +
> >> +#ifndef LTTNG_PIPE_H
> >> +#define LTTNG_PIPE_H
> >> +
> >> +#include <pthread.h>
> >> +
> >> +#define LTTNG_PIPE_IS_READ_OPEN(p) \
> >> +	(p->r_state == LTTNG_PIPE_STATE_OPENED ? 1 : 0)
> >> +#define LTTNG_PIPE_IS_WRITE_OPEN(p) \
> >> +	(p->w_state == LTTNG_PIPE_STATE_OPENED ? 1 : 0)
> > 
> > those two could be static inline. no need for macros.
> 
> With macros I can use CAPS :( ... No problem :P
> 
> Cheers!
> David
> 
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> >> +
> >> +enum lttng_pipe_state {
> >> +	LTTNG_PIPE_STATE_OPENED = 1,
> >> +	LTTNG_PIPE_STATE_CLOSED = 2,
> >> +};
> >> +
> >> +struct lttng_pipe {
> >> +	/* Read: 0, Write: 1. */
> >> +	int fd[2];
> >> +	/*
> >> +	 * Flags of the pipe once opened. pipe(2) specifies either O_NONBLOCK or
> >> +	 * O_CLOEXEC can be used. Flags are set using fcntl(2) call.
> >> +	 */
> >> +	int flags;
> >> +
> >> +	/*
> >> +	 * These states are protected by the operation mutex below.
> >> +	 */
> >> +	enum lttng_pipe_state r_state;
> >> +	enum lttng_pipe_state w_state;
> >> +
> >> +	/* Held for each read(2) operation. */
> >> +	pthread_mutex_t read_mutex;
> >> +	/* Held for each write(2) operation. */
> >> +	pthread_mutex_t write_mutex;
> >> +};
> >> +
> >> +struct lttng_pipe *lttng_pipe_open(int flags);
> >> +int lttng_pipe_close(struct lttng_pipe *pipe);
> >> +void lttng_pipe_destroy(struct lttng_pipe *pipe);
> >> +
> >> +ssize_t lttng_pipe_read(struct lttng_pipe *pipe, void *buf, size_t count);
> >> +ssize_t lttng_pipe_write(struct lttng_pipe *pipe, const void *buf,
> >> +		size_t count);
> >> +
> >> +#endif /* LTTNG_PIPE_H */
> >> -- 
> >> 1.7.10.4
> >>
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
