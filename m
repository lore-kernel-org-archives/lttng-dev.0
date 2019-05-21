From: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Subject: [lttng-ust RFC] Add setuid wrapper for per-UID buffers
Date: Tue, 21 May 2019 14:01:11 -0400
Message-ID: <20190521180111.29677-1-gabriel.pollo-guilbert__47822.5782908098$1558461784$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 457kBT6BDCz10M0
 for <lttng-dev@lists.lttng.org>; Tue, 21 May 2019 14:02:41 -0400 (EDT)
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

In case of a per-UID buffers, events following a setuid() call should be
fowarded to buffers of the new UID. In order to do so, we add a wrapper around
setuid() that unregister and re-register the application from the session
daemon.

Signed-off-by: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
---
 Makefile.am                     |  1 +
 configure.ac                    |  1 +
 include/lttng/ust.h             |  1 +
 liblttng-ust-setuid/Makefile.am | 10 +++++++
 liblttng-ust-setuid/ustsetuid.c | 48 +++++++++++++++++++++++++++++++++
 liblttng-ust/lttng-ust-comm.c   | 23 ++++++++++++++++
 6 files changed, 84 insertions(+)
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
diff --git a/include/lttng/ust.h b/include/lttng/ust.h
index 2779d7a7..37f15520 100644
--- a/include/lttng/ust.h
+++ b/include/lttng/ust.h
@@ -32,6 +32,7 @@ extern "C" {
 extern void ust_before_fork(sigset_t *save_sigset);
 extern void ust_after_fork_parent(sigset_t *restore_sigset);
 extern void ust_after_fork_child(sigset_t *restore_sigset);
+extern void ust_after_setuid();
 
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
index 00000000..f95e1896
--- /dev/null
+++ b/liblttng-ust-setuid/ustsetuid.c
@@ -0,0 +1,48 @@
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
+#include <lttng/ust-dlfcn.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+
+#include <lttng/ust.h>
+
+int setuid(uid_t uid) {
+	static int (*plibc_func)(uid_t) = NULL;
+	int retval;
+
+	if (plibc_func == NULL) {
+		plibc_func = dlsym(RTLD_NEXT, "setuid");
+		if (plibc_func == NULL) {
+			fprintf(stderr, "libustsetuid: unable to find \"setuid\" symbol\n");
+			errno = ENOSYS;
+			return -1;
+		}
+	}
+
+	retval = plibc_func(uid);
+	if(retval < 0) {
+		return retval;
+	}
+
+	ust_after_setuid();
+
+	return retval;
+}
diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 61dbb41b..5e55466e 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -2072,3 +2072,26 @@ void lttng_ust_sockinfo_session_enabled(void *owner)
 	struct sock_info *sock_info = owner;
 	sock_info->statedump_pending = 1;
 }
+
+void ust_after_setuid()
+{
+	/*
+	 * TODO: Don't re-register the application if in per-PID mode. That
+	 *       said, LTTng-UST isn't aware of the buffer types configured by
+	 *       LTTng-Tools.
+	 */
+
+	DBG("Unregistering the process");
+	lttng_ust_fixup_tls();
+	lttng_ust_exit();
+
+	sem_count = 2;
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
2.21.0
