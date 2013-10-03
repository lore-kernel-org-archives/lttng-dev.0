From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [lttng-ust PATCH] Add a new preload library to protect
	UST FDs against application interference
Date: Thu,  3 Oct 2013 14:47:29 -0400
Message-ID: <1380826049-15264-1-git-send-email-yannick.brosseau__20223.6572084532$1380826149$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1VRnw3-0000sm-Tu
	for lttng-dev@lists.lttng.org; Thu, 03 Oct 2013 14:47:47 -0400
Received: by mail-ie0-f174.google.com with SMTP id u16so6513237iet.33
	for <lttng-dev@lists.lttng.org>; Thu, 03 Oct 2013 11:47:34 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

This library intercept the call to close from an application and will refuse
to close it unless the call come from UST directly. The main use case is to
keep UST active in daemons which close indiscriminately all the FDs in an
arbitrary range.

This commit also add the ustclose function which sets a per-thread flag to
force the closing of the FD in the event that the protecting library is
preloaded. UST should use this new ustclose anywhere it would call close
on a protected FDs.

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 Makefile.am                        |  3 ++-
 README                             |  5 ++++
 close/Makefile.am                  |  9 +++++++
 close/close.c                      | 30 +++++++++++++++++++++
 configure.ac                       |  2 ++
 include/lttng/ust.h                |  1 +
 include/ust_close.h                | 26 ++++++++++++++++++
 liblttng-ust-comm/lttng-ust-comm.c |  7 ++---
 liblttng-ust-fd/Makefile.am        | 16 +++++++++++
 liblttng-ust-fd/ustfd.c            | 55 ++++++++++++++++++++++++++++++++++++++
 liblttng-ust/Makefile.am           |  3 ++-
 liblttng-ust/lttng-ust-abi.c       |  3 ++-
 liblttng-ust/lttng-ust-comm.c      | 23 ++++++++++++++--
 libringbuffer/Makefile.am          |  3 ++-
 libringbuffer/shm.c                | 12 ++++-----
 libringbuffer/shm.h                |  5 ++--
 16 files changed, 186 insertions(+), 17 deletions(-)
 create mode 100644 close/Makefile.am
 create mode 100644 close/close.c
 create mode 100644 include/ust_close.h
 create mode 100644 liblttng-ust-fd/Makefile.am
 create mode 100644 liblttng-ust-fd/ustfd.c

diff --git a/Makefile.am b/Makefile.am
index dc88c46..63a67ae 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,9 +1,10 @@
 ACLOCAL_AMFLAGS = -I config
 
-SUBDIRS = . include snprintf libringbuffer liblttng-ust-comm \
+SUBDIRS = . include snprintf close libringbuffer liblttng-ust-comm \
 		liblttng-ust \
 		liblttng-ust-ctl \
 		liblttng-ust-fork \
+		liblttng-ust-fd \
 		liblttng-ust-libc-wrapper \
 		liblttng-ust-cyg-profile \
 		tools \
diff --git a/README b/README
index a2ff00b..17e127b 100644
--- a/README
+++ b/README
@@ -171,6 +171,11 @@ PACKAGE CONTENTS:
     calls in order to trace across these calls. It _has_ to be LD_PRELOAD'ed
     in order to hijack calls. In contrast, libust may be linked at build time.
 
+  - liblttng-ust-fd
+    A library that is LD_PRELOAD'ed that protects lttng-ust own file descriptors
+    from applications that do operations on random FDs. (Like daemons which
+    closes all FD in a range even if they where not opened.) 
+
   - liblttng-ust-ctl
     A library to control tracing in other processes. Used by lttng-tools.
 
diff --git a/close/Makefile.am b/close/Makefile.am
new file mode 100644
index 0000000..15fb2d9
--- /dev/null
+++ b/close/Makefile.am
@@ -0,0 +1,9 @@
+AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/libustcomm
+AM_CFLAGS = -fno-strict-aliasing
+
+noinst_LTLIBRARIES = libustclose.la
+libustclose_la_SOURCES = \
+	close.c 
+
+libustclose_la_LDFLAGS = -no-undefined -static
+libustclose_la_CFLAGS = -DUST_COMPONENT="lttng_ust_snprintf" -fPIC -fno-strict-aliasing
diff --git a/close/close.c b/close/close.c
new file mode 100644
index 0000000..9d5b607
--- /dev/null
+++ b/close/close.c
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2013 Yannick Brosseau <yannick.brosseau@gmail.com> 
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; version 2.1 of
+ * the License.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#include <unistd.h>
+
+__thread int ust_current_closing_fd = -1;
+
+/* ust close replacement which set the flag to allow the closing
+ * of a lttng-ust FD when we use the lttng-ust-fd fd protection 
+ * preload. Should be used anywhere in UST instead of the close call */
+int ustclose(int fd) {
+	ust_current_closing_fd = fd;
+	return close(fd);
+}
+
diff --git a/configure.ac b/configure.ac
index cc28205..893b600 100644
--- a/configure.ac
+++ b/configure.ac
@@ -277,11 +277,13 @@ AC_CONFIG_FILES([
 	include/Makefile
 	include/lttng/ust-version.h
 	snprintf/Makefile
+	close/Makefile
 	libringbuffer/Makefile
 	liblttng-ust-comm/Makefile
 	liblttng-ust/Makefile
 	liblttng-ust-ctl/Makefile
 	liblttng-ust-fork/Makefile
+	liblttng-ust-fd/Makefile
 	liblttng-ust-java/Makefile
 	liblttng-ust-libc-wrapper/Makefile
 	liblttng-ust-cyg-profile/Makefile
diff --git a/include/lttng/ust.h b/include/lttng/ust.h
index 2779d7a..c121dd3 100644
--- a/include/lttng/ust.h
+++ b/include/lttng/ust.h
@@ -32,6 +32,7 @@ extern "C" {
 extern void ust_before_fork(sigset_t *save_sigset);
 extern void ust_after_fork_parent(sigset_t *restore_sigset);
 extern void ust_after_fork_child(sigset_t *restore_sigset);
+extern int ust_is_my_fd(int fd);
 
 #ifdef __cplusplus 
 }
diff --git a/include/ust_close.h b/include/ust_close.h
new file mode 100644
index 0000000..42dcf83
--- /dev/null
+++ b/include/ust_close.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2013 Yannick Brosseau <yannick.brosseau@gmail.com> 
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; version 2.1 of
+ * the License.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#ifndef UST_CLOSE
+#define UST_CLOSE
+
+extern __thread int ust_current_closing_fd;
+
+extern int ustclose(int fd);
+
+#endif /* UST_CLOSE */
diff --git a/liblttng-ust-comm/lttng-ust-comm.c b/liblttng-ust-comm/lttng-ust-comm.c
index a31786a..d4673e3 100644
--- a/liblttng-ust-comm/lttng-ust-comm.c
+++ b/liblttng-ust-comm/lttng-ust-comm.c
@@ -37,6 +37,7 @@
 #include <lttng/ust-error.h>
 #include <lttng/ust-events.h>
 #include <usterr-signal-safe.h>
+#include "ust_close.h"
 
 #include "../liblttng-ust/compat.h"
 
@@ -138,7 +139,7 @@ error_fcntl:
 	{
 		int closeret;
 
-		closeret = close(fd);
+		closeret = ustclose(fd);
 		if (closeret)
 			PERROR("close");
 	}
@@ -208,7 +209,7 @@ error_close:
 	{
 		int closeret;
 
-		closeret = close(fd);
+		closeret = ustclose(fd);
 		if (closeret) {
 			PERROR("close");
 		}
@@ -244,7 +245,7 @@ int ustcomm_close_unix_sock(int sock)
 {
 	int ret;
 
-	ret = close(sock);
+	ret = ustclose(sock);
 	if (ret < 0) {
 		PERROR("close");
 		ret = -errno;
diff --git a/liblttng-ust-fd/Makefile.am b/liblttng-ust-fd/Makefile.am
new file mode 100644
index 0000000..ee21c84
--- /dev/null
+++ b/liblttng-ust-fd/Makefile.am
@@ -0,0 +1,16 @@
+AM_CPPFLAGS = -I$(top_srcdir)/include
+AM_CFLAGS = -fno-strict-aliasing
+
+lib_LTLIBRARIES = liblttng-ust-fd.la
+liblttng_ust_fd_la_SOURCES = ustfd.c
+liblttng_ust_fd_la_LIBADD = \
+	$(top_builddir)/liblttng-ust/liblttng-ust.la
+
+if LTTNG_UST_BUILD_WITH_LIBDL
+liblttng_ust_fd_la_LIBADD += -ldl
+endif
+if LTTNG_UST_BUILD_WITH_LIBC_DL
+liblttng_ust_fd_la_LIBADD += -lc
+endif
+
+libustfd_CFLAGS = -DUST_COMPONENT=liblttng-ust-fd -fno-strict-aliasing
diff --git a/liblttng-ust-fd/ustfd.c b/liblttng-ust-fd/ustfd.c
new file mode 100644
index 0000000..abf29d5
--- /dev/null
+++ b/liblttng-ust-fd/ustfd.c
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2013 Yannick Brosseau <yannick.brosseau@gmail.com> 
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; version 2.1 of
+ * the License.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#define _GNU_SOURCE
+#include <dlfcn.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <signal.h>
+#include <sched.h>
+#include <stdarg.h>
+#include "usterr.h"
+
+#include <lttng/ust.h>
+#include "ust_close.h"
+
+int close(int fd)
+{
+	static int (*plibc_func)(int) = NULL;
+	int retval = -1;
+
+	if (plibc_func == NULL) {
+		plibc_func = dlsym(RTLD_NEXT, "close");
+		if (plibc_func == NULL) {
+			fprintf(stderr, "libustfd: unable to find \"close\" symbol\n");
+			errno = ENOSYS;
+			return -1;
+		}
+	}
+	
+	if(!ust_is_my_fd(fd) || (fd == ust_current_closing_fd)) {
+		
+		retval = plibc_func(fd);
+		if (fd == ust_current_closing_fd) {
+			ust_current_closing_fd = -1;
+		}
+	}
+	return retval;
+
+}
+
diff --git a/liblttng-ust/Makefile.am b/liblttng-ust/Makefile.am
index f06571c..0da54f4 100644
--- a/liblttng-ust/Makefile.am
+++ b/liblttng-ust/Makefile.am
@@ -13,7 +13,8 @@ liblttng_ust_tracepoint_la_SOURCES = \
 	error.h
 liblttng_ust_tracepoint_la_LIBADD = \
 	-lurcu-bp \
-	$(top_builddir)/snprintf/libustsnprintf.la
+	$(top_builddir)/snprintf/libustsnprintf.la \
+	$(top_builddir)/close/libustclose.la
 liblttng_ust_tracepoint_la_LDFLAGS = -no-undefined -version-info $(LTTNG_UST_LIBRARY_VERSION)
 liblttng_ust_tracepoint_la_CFLAGS = -DUST_COMPONENT="liblttng_ust_tracepoint" -fno-strict-aliasing
 
diff --git a/liblttng-ust/lttng-ust-abi.c b/liblttng-ust/lttng-ust-abi.c
index a852aae..20da39e 100644
--- a/liblttng-ust/lttng-ust-abi.c
+++ b/liblttng-ust/lttng-ust-abi.c
@@ -50,6 +50,7 @@
 #include "lttng-tracer.h"
 #include "../libringbuffer/shm.h"
 #include "../libringbuffer/frontend_types.h"
+#include "ust_close.h"
 
 #define OBJ_NAME_LEN	16
 
@@ -528,7 +529,7 @@ invalid:
 	{
 		int close_ret;
 
-		close_ret = close(wakeup_fd);
+		close_ret = ustclose(wakeup_fd);
 		if (close_ret) {
 			PERROR("close");
 		}
diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 475110c..695949c 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -189,6 +189,25 @@ extern void lttng_ring_buffer_client_discard_rt_exit(void);
 extern void lttng_ring_buffer_metadata_client_exit(void);
 
 /*
+ * Returns true if the specified file description is one
+ * managed by UST. Used mainly by the preloaded lib which
+ * protected from interference from a misbehaving application 
+ */
+int ust_is_my_fd(int fd)
+{
+	if(fd == global_apps.socket) {
+		return 1;
+	} else if (fd == global_apps.notify_socket) {
+		return 1;
+	} else if (fd == local_apps.socket) {
+		return 1;
+	} else if (fd == local_apps.notify_socket) {
+		return 1;
+	}
+	return 0;
+}
+
+/*
  * Returns the HOME directory path. Caller MUST NOT free(3) the returned
  * pointer.
  */
@@ -816,7 +835,7 @@ end:
 	return wait_shm_fd;
 
 error_close:
-	ret = close(wait_shm_fd);
+	ret = ustclose(wait_shm_fd);
 	if (ret) {
 		PERROR("Error closing fd");
 	}
@@ -837,7 +856,7 @@ char *get_map_shm(struct sock_info *sock_info)
 	wait_shm_mmap = mmap(NULL, mmap_size, PROT_READ,
 		  MAP_SHARED, wait_shm_fd, 0);
 	/* close shm fd immediately after taking the mmap reference */
-	ret = close(wait_shm_fd);
+	ret = ustclose(wait_shm_fd);
 	if (ret) {
 		PERROR("Error closing fd");
 	}
diff --git a/libringbuffer/Makefile.am b/libringbuffer/Makefile.am
index 271c8be..7ec9201 100644
--- a/libringbuffer/Makefile.am
+++ b/libringbuffer/Makefile.am
@@ -15,6 +15,7 @@ libringbuffer_la_SOURCES = \
 
 libringbuffer_la_LIBADD = \
 	-lpthread \
-	-lrt
+	-lrt \
+	$(top_builddir)/close/libustclose.la
 
 libringbuffer_la_CFLAGS = -DUST_COMPONENT="libringbuffer" -fno-strict-aliasing
diff --git a/libringbuffer/shm.c b/libringbuffer/shm.c
index 995665a..0f624c3 100644
--- a/libringbuffer/shm.c
+++ b/libringbuffer/shm.c
@@ -200,7 +200,7 @@ error_ftruncate:
 error_shm_release:
 error_zero_file:
 error_sigmask_release:
-	ret = close(shmfd);
+	ret = ustclose(shmfd);
 	if (ret) {
 		PERROR("close");
 		assert(0);
@@ -215,7 +215,7 @@ error_shm_open:
 error_pthread_sigmask:
 error_fcntl:
 	for (i = 0; i < 2; i++) {
-		ret = close(waitfd[i]);
+		ret = ustclose(waitfd[i]);
 		if (ret) {
 			PERROR("close");
 			assert(0);
@@ -275,7 +275,7 @@ struct shm_object *_shm_object_table_alloc_mem(struct shm_object_table *table,
 
 error_fcntl:
 	for (i = 0; i < 2; i++) {
-		ret = close(waitfd[i]);
+		ret = ustclose(waitfd[i]);
 		if (ret) {
 			PERROR("close");
 			assert(0);
@@ -409,7 +409,7 @@ void shmp_object_destroy(struct shm_object *obj)
 			PERROR("umnmap");
 			assert(0);
 		}
-		ret = close(obj->shm_fd);
+		ret = ustclose(obj->shm_fd);
 		if (ret) {
 			PERROR("close");
 			assert(0);
@@ -417,7 +417,7 @@ void shmp_object_destroy(struct shm_object *obj)
 		for (i = 0; i < 2; i++) {
 			if (obj->wait_fd[i] < 0)
 				continue;
-			ret = close(obj->wait_fd[i]);
+			ret = ustclose(obj->wait_fd[i]);
 			if (ret) {
 				PERROR("close");
 				assert(0);
@@ -432,7 +432,7 @@ void shmp_object_destroy(struct shm_object *obj)
 		for (i = 0; i < 2; i++) {
 			if (obj->wait_fd[i] < 0)
 				continue;
-			ret = close(obj->wait_fd[i]);
+			ret = ustclose(obj->wait_fd[i]);
 			if (ret) {
 				PERROR("close");
 				assert(0);
diff --git a/libringbuffer/shm.h b/libringbuffer/shm.h
index 8d9d113..daef037 100644
--- a/libringbuffer/shm.h
+++ b/libringbuffer/shm.h
@@ -25,6 +25,7 @@
 #include <usterr-signal-safe.h>
 #include <urcu/compiler.h>
 #include "shm_types.h"
+#include "ust_close.h"
 
 /* channel_handle_create - for UST. */
 extern
@@ -153,7 +154,7 @@ int shm_close_wait_fd(struct lttng_ust_shm_handle *handle,
 	if (wait_fd < 0)
 		return -ENOENT;
 	obj->wait_fd[0] = -1;
-	ret = close(wait_fd);
+	ret = ustclose(wait_fd);
 	if (ret) {
 		ret = -errno;
 		return ret;
@@ -179,7 +180,7 @@ int shm_close_wakeup_fd(struct lttng_ust_shm_handle *handle,
 	if (wakeup_fd < 0)
 		return -ENOENT;
 	obj->wait_fd[1] = -1;
-	ret = close(wakeup_fd);
+	ret = ustclose(wakeup_fd);
 	if (ret) {
 		ret = -errno;
 		return ret;
-- 
1.8.4.rc3
