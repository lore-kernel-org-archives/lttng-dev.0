From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-ust 1/3] Integrate base-address statedump
	into lttng-ust
Date: Thu, 28 Nov 2013 13:26:52 +0100
Message-ID: <1385641614-18806-2-git-send-email-paul_woegerer__12726.190503645$1385641721$gmane$org@mentor.com>
References: <1385641614-18806-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1Vm0gk-0001Ir-6f
	for lttng-dev@lists.lttng.org; Thu, 28 Nov 2013 07:27:25 -0500
In-Reply-To: <1385641614-18806-1-git-send-email-paul_woegerer@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 Makefile.am                                        |  3 +-
 liblttng-ust-baddr/Makefile.am                     | 18 +----
 liblttng-ust-baddr/lttng-ust-baddr.c               | 32 +--------
 liblttng-ust-baddr/lttng-ust-baddr.h               | 22 +++++++
 liblttng-ust-baddr/ust_baddr_statedump.h           |  2 +-
 liblttng-ust-dl/Makefile.am                        |  5 +-
 .../ust_baddr.c                                    |  0
 .../ust_baddr.h                                    |  0
 liblttng-ust-dl/ustdl.c                            | 76 ++++++----------------
 liblttng-ust/Makefile.am                           |  1 +
 liblttng-ust/lttng-ust-comm.c                      | 46 ++-----------
 11 files changed, 58 insertions(+), 147 deletions(-)
 create mode 100644 liblttng-ust-baddr/lttng-ust-baddr.h
 rename {liblttng-ust-baddr => liblttng-ust-dl}/ust_baddr.c (100%)
 rename {liblttng-ust-baddr => liblttng-ust-dl}/ust_baddr.h (100%)

diff --git a/Makefile.am b/Makefile.am
index 10b54cb..6fab956 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,10 +1,9 @@
 ACLOCAL_AMFLAGS = -I config
 
-SUBDIRS = . include snprintf libringbuffer liblttng-ust-comm \
+SUBDIRS = . include snprintf libringbuffer liblttng-ust-comm liblttng-ust-baddr \
 		liblttng-ust \
 		liblttng-ust-ctl \
 		liblttng-ust-fork \
-		liblttng-ust-baddr \
 		liblttng-ust-dl \
 		liblttng-ust-libc-wrapper \
 		liblttng-ust-cyg-profile \
diff --git a/liblttng-ust-baddr/Makefile.am b/liblttng-ust-baddr/Makefile.am
index 0d3cf28..57792f6 100644
--- a/liblttng-ust-baddr/Makefile.am
+++ b/liblttng-ust-baddr/Makefile.am
@@ -1,20 +1,8 @@
-AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
-AM_CFLAGS = -fno-strict-aliasing
+AM_CPPFLAGS = -I$(top_builddir)/include -I$(top_srcdir)/include
+
+noinst_LTLIBRARIES = liblttng-ust-baddr.la
 
-lib_LTLIBRARIES = liblttng-ust-baddr.la
 liblttng_ust_baddr_la_SOURCES = \
 	lttng-ust-baddr.c \
-	ust_baddr.c \
-	ust_baddr.h \
 	ust_baddr_statedump.c \
 	ust_baddr_statedump.h
-liblttng_ust_baddr_la_LIBADD = \
-	-L$(top_builddir)/liblttng-ust/.libs \
-	-llttng-ust
-
-if LTTNG_UST_BUILD_WITH_LIBDL
-liblttng_ust_baddr_la_LIBADD += -ldl
-endif
-if LTTNG_UST_BUILD_WITH_LIBC_DL
-liblttng_ust_baddr_la_LIBADD += -lc
-endif
diff --git a/liblttng-ust-baddr/lttng-ust-baddr.c b/liblttng-ust-baddr/lttng-ust-baddr.c
index a856965..8412233 100644
--- a/liblttng-ust-baddr/lttng-ust-baddr.c
+++ b/liblttng-ust-baddr/lttng-ust-baddr.c
@@ -22,7 +22,6 @@
 
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/stat.h>
 #include <unistd.h>
 #include <limits.h>
 #include <stdlib.h>
@@ -32,38 +31,11 @@
 #include <stdio.h>
 #include "usterr.h"
 
+#include "lttng-ust-baddr.h"
+
 #define TRACEPOINT_DEFINE
-#include "ust_baddr.h"
 #include "ust_baddr_statedump.h"
 
-int
-lttng_ust_push_baddr(void *so_base, const char *so_name)
-{
-	char resolved_path[PATH_MAX];
-	struct stat sostat;
-
-	if (!realpath(so_name, resolved_path)) {
-		ERR("could not resolve path '%s'", so_name);
-		return 0;
-	}
-
-	if (stat(resolved_path, &sostat)) {
-		ERR("could not access file status for %s", resolved_path);
-		return 0;
-	}
-
-	tracepoint(ust_baddr, push,
-		so_base, resolved_path, sostat.st_size, sostat.st_mtime);
-	return 0;
-}
-
-int
-lttng_ust_pop_baddr(void *so_base)
-{
-	tracepoint(ust_baddr, pop, so_base);
-	return 0;
-}
-
 static int
 extract_soinfo_events(struct dl_phdr_info *info, size_t size, void *data)
 {
diff --git a/liblttng-ust-baddr/lttng-ust-baddr.h b/liblttng-ust-baddr/lttng-ust-baddr.h
new file mode 100644
index 0000000..e72eb2c
--- /dev/null
+++ b/liblttng-ust-baddr/lttng-ust-baddr.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
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
+#include <lttng/ust-events.h>
+
+int
+lttng_ust_baddr_statedump(struct lttng_session *session);
diff --git a/liblttng-ust-baddr/ust_baddr_statedump.h b/liblttng-ust-baddr/ust_baddr_statedump.h
index 77a9af4..c509bd4 100644
--- a/liblttng-ust-baddr/ust_baddr_statedump.h
+++ b/liblttng-ust-baddr/ust_baddr_statedump.h
@@ -35,7 +35,7 @@ extern "C" {
 #include <lttng/ust-events.h>
 
 #define LTTNG_UST_BADDR_STATEDUMP_PROVIDER
-#include <lttng/tracepoint.h>
+#include <tracepoint.h>
 
 TRACEPOINT_EVENT(ust_baddr_statedump, soinfo,
 	TP_ARGS(struct lttng_session *, session, void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime),
diff --git a/liblttng-ust-dl/Makefile.am b/liblttng-ust-dl/Makefile.am
index c408fdd..352f145 100644
--- a/liblttng-ust-dl/Makefile.am
+++ b/liblttng-ust-dl/Makefile.am
@@ -2,7 +2,10 @@ AM_CPPFLAGS = -I$(top_srcdir)/include
 AM_CFLAGS = -fno-strict-aliasing
 
 lib_LTLIBRARIES = liblttng-ust-dl.la
-liblttng_ust_dl_la_SOURCES = ustdl.c
+liblttng_ust_dl_la_SOURCES = \
+	ustdl.c \
+	ust_baddr.c \
+	ust_baddr.h
 liblttng_ust_dl_la_LIBADD = \
 	$(top_builddir)/liblttng-ust/liblttng-ust.la
 
diff --git a/liblttng-ust-baddr/ust_baddr.c b/liblttng-ust-dl/ust_baddr.c
similarity index 100%
rename from liblttng-ust-baddr/ust_baddr.c
rename to liblttng-ust-dl/ust_baddr.c
diff --git a/liblttng-ust-baddr/ust_baddr.h b/liblttng-ust-dl/ust_baddr.h
similarity index 100%
rename from liblttng-ust-baddr/ust_baddr.h
rename to liblttng-ust-dl/ust_baddr.h
diff --git a/liblttng-ust-dl/ustdl.c b/liblttng-ust-dl/ustdl.c
index 8baf9ee..dbde8b7 100644
--- a/liblttng-ust-dl/ustdl.c
+++ b/liblttng-ust-dl/ustdl.c
@@ -22,6 +22,9 @@
 #include <link.h>
 #include <unistd.h>
 #include <stdio.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 #include <signal.h>
 #include <sched.h>
 #include <stdarg.h>
@@ -30,9 +33,11 @@
 #include <lttng/ust-compiler.h>
 #include <lttng/ust.h>
 
+#define TRACEPOINT_DEFINE
+#include "ust_baddr.h"
+
 static void *(*__lttng_ust_plibc_dlopen)(const char *filename, int flag);
 static int (*__lttng_ust_plibc_dlclose)(void *handle);
-static void *__lttng_ust_baddr_handle;
 
 static
 void *_lttng_ust_dl_libc_dlopen(const char *filename, int flag)
@@ -61,53 +66,24 @@ int _lttng_ust_dl_libc_dlclose(void *handle)
 }
 
 static
-void *lttng_ust_baddr_handle(void)
+void lttng_ust_baddr_push(void *so_base, const char *so_name)
 {
-	if (!__lttng_ust_baddr_handle) {
-		__lttng_ust_baddr_handle = _lttng_ust_dl_libc_dlopen(
-			"liblttng-ust-baddr.so.0", RTLD_NOW | RTLD_GLOBAL);
-		if (__lttng_ust_baddr_handle == NULL)
-			fprintf(stderr, "%s\n", dlerror());
-	}
-	return __lttng_ust_baddr_handle;
-}
+	char resolved_path[PATH_MAX];
+	struct stat sostat;
 
-static
-int lttng_ust_baddr_push(void *so_base, const char *so_name)
-{
-	static int
-	(*lttng_ust_baddr_push_fn)(void *so_base, const char *so_name);
-	if (!lttng_ust_baddr_push_fn) {
-		void *baddr_handle = lttng_ust_baddr_handle();
-		if (baddr_handle) {
-			lttng_ust_baddr_push_fn = dlsym(baddr_handle,
-				"lttng_ust_push_baddr");
-			if (lttng_ust_baddr_push_fn == NULL)
-				fprintf(stderr, "%s\n", dlerror());
-		}
-		if (!lttng_ust_baddr_push_fn)
-			return -1;
+	if (!realpath(so_name, resolved_path)) {
+		ERR("could not resolve path '%s'", so_name);
+		return;
 	}
-	return lttng_ust_baddr_push_fn(so_base, so_name);
-}
 
-static
-int lttng_ust_baddr_pop(void *so_base)
-{
-	static int
-	(*lttng_ust_baddr_pop_fn)(void *so_base);
-	if (!lttng_ust_baddr_pop_fn) {
-		void *baddr_handle = lttng_ust_baddr_handle();
-		if (baddr_handle) {
-			lttng_ust_baddr_pop_fn = dlsym(baddr_handle,
-				"lttng_ust_pop_baddr");
-			if (lttng_ust_baddr_pop_fn == NULL)
-				fprintf(stderr, "%s\n", dlerror());
-		}
-		if (!lttng_ust_baddr_pop_fn)
-			return -1;
+	if (stat(resolved_path, &sostat)) {
+		ERR("could not access file status for %s", resolved_path);
+		return;
 	}
-	return lttng_ust_baddr_pop_fn(so_base);
+
+	tracepoint(ust_baddr, push,
+		so_base, resolved_path, sostat.st_size, sostat.st_mtime);
+	return;
 }
 
 void *dlopen(const char *filename, int flag)
@@ -128,19 +104,7 @@ int dlclose(void *handle)
 		struct link_map *p = NULL;
 		if (dlinfo(handle, RTLD_DI_LINKMAP, &p) != -1 && p != NULL
 				&& p->l_addr != 0)
-			lttng_ust_baddr_pop((void *) p->l_addr);
+			tracepoint(ust_baddr, pop, (void *) p->l_addr);
 	}
 	return _lttng_ust_dl_libc_dlclose(handle);
 }
-
-static void __attribute__((destructor))
-lttng_ust_baddr_handle_fini(void);
-static void
-lttng_ust_baddr_handle_fini(void)
-{
-	if (__lttng_ust_baddr_handle) {
-		int ret = _lttng_ust_dl_libc_dlclose(__lttng_ust_baddr_handle);
-		if (ret)
-			fprintf(stderr, "%s\n", dlerror());
-	}
-}
diff --git a/liblttng-ust/Makefile.am b/liblttng-ust/Makefile.am
index a333313..f00fe45 100644
--- a/liblttng-ust/Makefile.am
+++ b/liblttng-ust/Makefile.am
@@ -69,6 +69,7 @@ liblttng_ust_la_LIBADD = \
 	-lurcu-cds \
 	$(top_builddir)/snprintf/libustsnprintf.la \
 	$(top_builddir)/liblttng-ust-comm/liblttng-ust-comm.la \
+	$(top_builddir)/liblttng-ust-baddr/liblttng-ust-baddr.la \
 	liblttng-ust-tracepoint.la \
 	liblttng-ust-runtime.la liblttng-ust-support.la
 
diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 77d8e3f..2d3766f 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -52,6 +52,7 @@
 #include "lttng-tracer-core.h"
 #include "compat.h"
 #include "../libringbuffer/tlsfixup.h"
+#include "../liblttng-ust-baddr/lttng-ust-baddr.h"
 
 /*
  * Has lttng ust comm constructor been called ?
@@ -183,7 +184,6 @@ static const char *cmd_name_mapping[] = {
 
 static const char *str_timeout;
 static int got_timeout_env;
-static void *ust_baddr_handle;
 
 extern void lttng_ring_buffer_client_overwrite_init(void);
 extern void lttng_ring_buffer_client_overwrite_rt_init(void);
@@ -243,39 +243,6 @@ void print_cmd(int cmd, int handle)
 }
 
 static
-void *lttng_ust_baddr_handle(void)
-{
-	if (!ust_baddr_handle) {
-		ust_baddr_handle = dlopen(
-			"liblttng-ust-baddr.so.0", RTLD_NOW | RTLD_GLOBAL);
-		if (ust_baddr_handle == NULL)
-			ERR("%s", dlerror());
-	}
-	return ust_baddr_handle;
-}
-
-static
-int lttng_ust_baddr_statedump(struct lttng_session *session)
-{
-	static
-	int (*lttng_ust_baddr_init_fn)(struct lttng_session *);
-
-	if (!lttng_ust_baddr_init_fn) {
-		void *baddr_handle = lttng_ust_baddr_handle();
-		if (baddr_handle) {
-			lttng_ust_baddr_init_fn = dlsym(baddr_handle,
-				"lttng_ust_baddr_statedump");
-			if (lttng_ust_baddr_init_fn == NULL)
-				ERR("%s", dlerror());
-		}
-		if (!lttng_ust_baddr_init_fn)
-			return -1;
-	}
-
-	return lttng_ust_baddr_init_fn(session);
-}
-
-static
 int setup_local_apps(void)
 {
 	const char *home_dir;
@@ -1247,8 +1214,9 @@ restart:
 			if (ret) {
 				ERR("Error handling message for %s socket", sock_info->name);
 			} else {
-				struct lttng_session *session =
-					sock_info->session_enabled;
+				struct lttng_session *session;
+
+				session = sock_info->session_enabled;
 				if (session) {
 					sock_info->session_enabled = NULL;
 					lttng_ust_baddr_statedump(session);
@@ -1489,12 +1457,6 @@ void __attribute__((destructor)) lttng_ust_exit(void)
 	 * cleanup the threads if there are stalled in a syscall.
 	 */
 	lttng_ust_cleanup(1);
-
-	if (ust_baddr_handle) {
-		int ret = dlclose(ust_baddr_handle);
-		if (ret)
-			ERR("%s", dlerror());
-	}
 }
 
 /*
-- 
1.8.4
