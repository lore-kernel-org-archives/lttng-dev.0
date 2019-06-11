From: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Subject: [PATCH lttng-ust v3] Add setuid wrappers for per-UID
 buffers
Date: Tue, 11 Jun 2019 11:57:52 -0400
Message-ID: <20190611155751.29634-1-gabriel.pollo-guilbert__35158.8149483845$1560268754$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45NZRz30TFz1032
 for <lttng-dev@lists.lttng.org>; Tue, 11 Jun 2019 11:58:55 -0400 (EDT)
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
List-Id: lttng-dev@lists.lttng.org

In case of a per-UID buffer, events following a change of user ID should be
forwarded to buffers of the new UID. In order to do so, we add a wrapper around
setuid(3), setreuid(3) and setresuid(2) that unregister and re-register the
application from the session daemon.

While there exist some other functions such as seteuid(3) or setfsuid(2), we
don't need to add a wrapper for them since they do not edit the real user ID,
the actual ID returned by getuid(3) and used for creating the buffers.

Signed-off-by: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 Makefile.am                     |   1 +
 configure.ac                    |   1 +
 doc/man/lttng-ust.3.txt         |  19 ++++++
 include/lttng/ust.h             |   1 +
 liblttng-ust-setuid/Makefile.am |  10 +++
 liblttng-ust-setuid/ustsetuid.c | 105 ++++++++++++++++++++++++++++++++
 liblttng-ust/lttng-ust-comm.c   |  29 ++++++++-
 7 files changed, 164 insertions(+), 2 deletions(-)
 create mode 100644 liblttng-ust-setuid/Makefile.am
 create mode 100644 liblttng-ust-setuid/ustsetuid.c

diff --git a/Makefile.am b/Makefile.am
index 810761ca..e8812e59 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -5,6 +5,7 @@ SUBDIRS = . include snprintf libringbuffer liblttng-ust-comm \
 		liblttng-ust-ctl \
 		liblttng-ust-fd \
 		liblttng-ust-fork \
+		liblttng-ust-setuid \
 		liblttng-ust-libc-wrapper \
 		liblttng-ust-cyg-profile \
 		tools
diff --git a/configure.ac b/configure.ac
index 52fc3f68..95780dba 100644
--- a/configure.ac
+++ b/configure.ac
@@ -522,6 +522,7 @@ AC_CONFIG_FILES([
 	liblttng-ust/Makefile
 	liblttng-ust-ctl/Makefile
 	liblttng-ust-fork/Makefile
+	liblttng-ust-setuid/Makefile
 	liblttng-ust-dl/Makefile
 	liblttng-ust-fd/Makefile
 	liblttng-ust-java/Makefile
diff --git a/doc/man/lttng-ust.3.txt b/doc/man/lttng-ust.3.txt
index 5c9c9f5d..511ff210 100644
--- a/doc/man/lttng-ust.3.txt
+++ b/doc/man/lttng-ust.3.txt
@@ -744,6 +744,25 @@ library before you start the application. Typical use cases include
 daemons closing all file descriptors after man:fork(2), and buggy
 applications doing ``double-closes''.
 
---
v3:
	* fix some typos
	* added documentation concerning CAP_SETUID/SUID and LD_PRELOAD
---

+Using LTTng-UST with applications that change effective user ID
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+If LTTng traces your application using per-UID buffers (see the
+nloption:--buffers-uid option of man:lttng-enable-channel(1)) and changes
+the process's effective user ID with man:setuid(2), the library
+`liblttng-ust-setuid.so` needs to be preloaded before starting the
+application with the `LD_PRELOAD` environment variable (see man:ld.so(8)).
+This way, event records generated after the user ID change are forwarded to
+the correct buffer.
+
+This workaround requires that the tracing session be global (created by a
+root session daemon; see man:lttng-sessiond(1)) to avoid permission problems
+of a session daemon started by another user.
+
+That said, if your application has the `CAP_SETUID` capability or the SUID bit,
+the dynamic linker will ignore libraries in `LD_PRELOAD` if they aren't in the
+standard search directories and don't have the SUID bit too (see man:ld.so(8)).
+The install script of LTTng-UST will not set the SUID bit to
+`liblttng-ust-setuid.so` for security reason.
 
 Context information
 ~~~~~~~~~~~~~~~~~~~
diff --git a/include/lttng/ust.h b/include/lttng/ust.h
index 2779d7a7..5495e564 100644
--- a/include/lttng/ust.h
+++ b/include/lttng/ust.h
@@ -32,6 +32,7 @@ extern "C" {
 extern void ust_before_fork(sigset_t *save_sigset);
 extern void ust_after_fork_parent(sigset_t *restore_sigset);
 extern void ust_after_fork_child(sigset_t *restore_sigset);
+extern void ust_after_setuid(void);
 
 #ifdef __cplusplus 
 }
diff --git a/liblttng-ust-setuid/Makefile.am b/liblttng-ust-setuid/Makefile.am
new file mode 100644
index 00000000..df3cd622
--- /dev/null
+++ b/liblttng-ust-setuid/Makefile.am
@@ -0,0 +1,10 @@
+AM_CPPFLAGS = -I$(top_srcdir)/include
+AM_CFLAGS += -fno-strict-aliasing
+
+lib_LTLIBRARIES = liblttng-ust-setuid.la
+liblttng_ust_setuid_la_SOURCES = ustsetuid.c
+liblttng_ust_setuid_la_LIBADD = \
+	$(top_builddir)/liblttng-ust/liblttng-ust.la \
+	$(DL_LIBS)
+
+liblttng_ust_setuid_la_CFLAGS = -DUST_COMPONENT=liblttng-ust-setuid $(AM_CFLAGS)
diff --git a/liblttng-ust-setuid/ustsetuid.c b/liblttng-ust-setuid/ustsetuid.c
new file mode 100644
index 00000000..d221e8fb
--- /dev/null
+++ b/liblttng-ust-setuid/ustsetuid.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2019 Gabriel-Andrew Pollo-Guilbert
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
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <lttng/ust-dlfcn.h>
+#include <lttng/ust.h>
+
+int setuid(uid_t uid)
+{
+	static int (*plibc_func)(uid_t) = NULL;
+	int retval;
+	uid_t before_uid;
+
+	if (plibc_func == NULL) {
+		plibc_func = dlsym(RTLD_NEXT, __func__);
+		if (plibc_func == NULL) {
+			fprintf(stderr, "libustsetuid: unable to find \"%s\" symbol\n", __func__);
+			errno = ENOSYS;
+			return -1;
+		}
+	}
+
+	before_uid = getuid();
+
+	retval = plibc_func(uid);
+	if (retval < 0)
+		return retval;
+
+	if (before_uid != getuid())
+		ust_after_setuid();
+
+	return retval;
+}
+
+int setreuid(uid_t ruid, uid_t euid)
+{
+	static int (*plibc_func)(uid_t, uid_t) = NULL;
+	int retval;
+	uid_t before_uid;
+
+	if (plibc_func == NULL) {
+		plibc_func = dlsym(RTLD_NEXT, __func__);
+		if (plibc_func == NULL) {
+			fprintf(stderr, "libustsetuid: unable to find \"%s\" symbol\n", __func__);
+			errno = ENOSYS;
+			return -1;
+		}
+	}
+
+	before_uid = getuid();
+
+	retval = plibc_func(ruid, euid);
+	if (retval < 0)
+		return retval;
+
+	if (before_uid != getuid())
+		ust_after_setuid();
+
+	return retval;
+}
+
+int setresuid(uid_t ruid, uid_t euid, uid_t suid)
+{
+	static int (*plibc_func)(uid_t, uid_t, uid_t) = NULL;
+	int retval;
+	uid_t before_uid;
+
+	if (plibc_func == NULL) {
+		plibc_func = dlsym(RTLD_NEXT, __func__);
+		if (plibc_func == NULL) {
+			fprintf(stderr, "libustsetuid: unable to find \"%s\" symbol\n", __func__);
+			errno = ENOSYS;
+			return -1;
+		}
+	}
+
+	before_uid = getuid();
+
+	retval = plibc_func(ruid, euid, suid);
+	if (retval < 0)
+		return retval;
+
+	if (before_uid != getuid())
+		ust_after_setuid();
+
+	return retval;
+}
diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 61dbb41b..36c876a4 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -225,10 +225,12 @@ void ust_unlock(void)
  *   daemon problems).
  */
 static sem_t constructor_wait;
+
 /*
  * Doing this for both the global and local sessiond.
  */
-static int sem_count = { 2 };
+enum { LTTNG_UST_INIT_SEM_COUNT = 2 };
+static int sem_count = LTTNG_UST_INIT_SEM_COUNT;
 
 /*
  * Counting nesting within lttng-ust. Used to ensure that calling fork()
@@ -1922,7 +1924,7 @@ void lttng_ust_cleanup(int exiting)
 	exit_tracepoint();
 	if (!exiting) {
 		/* Reinitialize values for fork */
-		sem_count = 2;
+		sem_count = LTTNG_UST_INIT_SEM_COUNT;
 		lttng_ust_comm_should_quit = 0;
 		initialized = 0;
 	}
@@ -2072,3 +2074,26 @@ void lttng_ust_sockinfo_session_enabled(void *owner)
 	struct sock_info *sock_info = owner;
 	sock_info->statedump_pending = 1;
 }
+
+/*
+ * Re-register the application when changing user ID. This is especially
+ * important for per-UID buffers. It is not strictly needed for per-PID
+ * buffers, but a slight extra overhead when changing user ID is considered
+ * harmless for a relatively infrequent operation.
+ */
+void ust_after_setuid(void)
+{
+	DBG("Unregistering the process");
+	lttng_ust_fixup_tls();
+	lttng_ust_exit();
+
+	sem_count = LTTNG_UST_INIT_SEM_COUNT;
+	lttng_ust_comm_should_quit = 0;
+	initialized = 0;
+
+	global_apps.wait_shm_mmap = NULL;
+	local_apps.wait_shm_mmap = NULL;
+
+	DBG("Registering the process under new UID=%u", getuid());
+	lttng_ust_init();
+}
-- 
2.22.0
