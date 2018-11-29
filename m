From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 1/2] Revert stubbing of unix socket
 functions
Date: Thu, 29 Nov 2018 16:22:06 -0500
Message-ID: <20181129212207.8611-1-mjeanson__21212.1607423343$1543526444$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 435Vpj6PTnzvrm
 for <lttng-dev@lists.lttng.org>; Thu, 29 Nov 2018 16:22:21 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Instead of stubing useful unix socket functions to work around
Linux-only credential passing, ifdef the relevant parts like it was
already done for other functions.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac           |  3 --
 src/common/Makefile.am |  8 +---
 src/common/unix-stub.c | 86 ------------------------------------------
 src/common/unix.c      | 12 +++++-
 4 files changed, 11 insertions(+), 98 deletions(-)
 delete mode 100644 src/common/unix-stub.c

diff --git a/configure.ac b/configure.ac
index 69a9d776..bc92b5bd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -874,7 +874,6 @@ build_lib_consumer=no
 build_lib_hashtable=no
 build_lib_health=no
 build_lib_runas=no
-build_lib_unix=no
 build_lib_index=no
 build_lib_kernel_consumer=no
 build_lib_kernel_ctl=no
@@ -932,7 +931,6 @@ AS_IF([test x$enable_bin_lttng_sessiond != xno],
        build_lib_testpoint=yes
        build_lib_health=yes
        build_lib_runas=yes
-       build_lib_unix=yes
       ]
 )
 
@@ -1042,7 +1040,6 @@ AM_CONDITIONAL([BUILD_LIB_CONSUMER], [test x$build_lib_consumer = xyes])
 AM_CONDITIONAL([BUILD_LIB_HASHTABLE], [test x$build_lib_hashtable = xyes])
 AM_CONDITIONAL([BUILD_LIB_HEALTH], [test x$build_lib_health = xyes])
 AM_CONDITIONAL([BUILD_LIB_RUNAS], [test x$build_lib_runas = xyes])
-AM_CONDITIONAL([BUILD_LIB_UNIX], [test x$build_lib_unix = xyes])
 AM_CONDITIONAL([BUILD_LIB_INDEX], [test x$build_lib_index = xyes])
 AM_CONDITIONAL([BUILD_LIB_KERNEL_CONSUMER], [test x$build_lib_kernel_consumer = xyes])
 AM_CONDITIONAL([BUILD_LIB_KERNEL_CTL], [test x$build_lib_kernel_ctl = xyes])
diff --git a/src/common/Makefile.am b/src/common/Makefile.am
index b9d344b8..d754924d 100644
--- a/src/common/Makefile.am
+++ b/src/common/Makefile.am
@@ -17,7 +17,7 @@ libcommon_la_SOURCES = error.h error.c utils.c utils.h runas.h \
                        pipe.c pipe.h readwrite.c readwrite.h \
                        mi-lttng.h mi-lttng.c \
                        daemonize.c daemonize.h \
-                       unix.h \
+                       unix.c unix.h \
                        filter.c filter.h context.c context.h \
                        action.c notify.c condition.c buffer-usage.c \
                        session-consumed-size.c \
@@ -39,12 +39,6 @@ else
 libcommon_la_SOURCES += runas-stub.c
 endif
 
-if BUILD_LIB_UNIX
-libcommon_la_SOURCES += unix.c
-else
-libcommon_la_SOURCES += unix-stub.c
-endif
-
 if BUILD_LIB_COMPAT
 SUBDIRS += compat
 endif
diff --git a/src/common/unix-stub.c b/src/common/unix-stub.c
deleted file mode 100644
index 5cc62964..00000000
--- a/src/common/unix-stub.c
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- * Copyright (C) 2018 Francis Deslauriers <francis.deslauriers@efficios.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License, version 2 only, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc., 51
- * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifndef _UNIX_STUB_H
-#define _UNIX_STUB_H
-
-#include <stddef.h>
-#include <stdlib.h>
-#include <common/compat/socket.h>
-
-int lttcomm_create_unix_sock(const char *pathname)
-{
-	return -1;
-}
-int lttcomm_create_anon_unix_socketpair(int *fds)
-{
-	return -1;
-}
-int lttcomm_connect_unix_sock(const char *pathname)
-{
-	return -1;
-}
-int lttcomm_accept_unix_sock(int sock)
-{
-	return -1;
-}
-int lttcomm_listen_unix_sock(int sock)
-{
-	return -1;
-}
-int lttcomm_close_unix_sock(int sock)
-{
-	return -1;
-}
-ssize_t lttcomm_send_fds_unix_sock(int sock, const int *fds, size_t nb_fd)
-{
-	return -1;
-}
-ssize_t lttcomm_recv_fds_unix_sock(int sock, int *fds, size_t nb_fd)
-{
-	return -1;
-}
-ssize_t lttcomm_recv_unix_sock(int sock, void *buf, size_t len)
-{
-	return -1;
-}
-ssize_t lttcomm_recv_unix_sock_non_block(int sock, void *buf, size_t len)
-{
-	return -1;
-}
-ssize_t lttcomm_send_unix_sock(int sock, const void *buf, size_t len)
-{
-	return -1;
-}
-ssize_t lttcomm_send_unix_sock_non_block(int sock, const void *buf, size_t len)
-{
-	return -1;
-}
-ssize_t lttcomm_send_creds_unix_sock(int sock, void *buf, size_t len)
-{
-	return -1;
-}
-ssize_t lttcomm_recv_creds_unix_sock(int sock, void *buf, size_t len,
-		lttng_sock_cred *creds)
-{
-	return -1;
-}
-int lttcomm_setsockopt_creds_unix_sock(int sock)
-{
-	return -1;
-}
-#endif	/* _UNIX_STUB_H */
diff --git a/src/common/unix.c b/src/common/unix.c
index edca02ab..d37313c5 100644
--- a/src/common/unix.c
+++ b/src/common/unix.c
@@ -441,8 +441,14 @@ ssize_t lttcomm_recv_fds_unix_sock(int sock, int *fds, size_t nb_fd)
 	struct cmsghdr *cmsg;
 	size_t sizeof_fds = nb_fd * sizeof(int);
 
-	/* Account for the struct ucred cmsg in the buffer size */
-	char recv_buf[CMSG_SPACE(sizeof_fds) + CMSG_SPACE(sizeof(struct ucred))];
+#ifdef __linux__
+/* Account for the struct ucred cmsg in the buffer size */
+#define LTTNG_SOCK_RECV_FDS_BUF_SIZE CMSG_SPACE(sizeof_fds) + CMSG_SPACE(sizeof(struct ucred))
+#else
+#define LTTNG_SOCK_RECV_FDS_BUF_SIZE CMSG_SPACE(sizeof_fds)
+#endif /* __linux__ */
+
+	char recv_buf[LTTNG_SOCK_RECV_FDS_BUF_SIZE];
 	struct msghdr msg;
 	char dummy;
 
@@ -512,6 +518,7 @@ ssize_t lttcomm_recv_fds_unix_sock(int sock, int *fds, size_t nb_fd)
 			ret = sizeof_fds;
 			goto end;
 		}
+#ifdef __linux__
 		if (cmsg->cmsg_type == SCM_CREDENTIALS) {
 			/*
 			 * Expect credentials to be sent when expecting fds even
@@ -520,6 +527,7 @@ ssize_t lttcomm_recv_fds_unix_sock(int sock, int *fds, size_t nb_fd)
 			 */
 			ret = -1;
 		}
+#endif /* __linux__ */
 	}
 end:
 	return ret;
-- 
2.17.1
