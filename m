From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH v3 2/2] Implement base-address-state tracing
Date: Thu, 14 Nov 2013 19:39:49 +0100
Message-ID: <1384454389-456-1-git-send-email-paul_woegerer__43.4814057827637$1384454488$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1Vh1pf-00030Y-KE
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 13:40:06 -0500
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

Dump the base-address state (executable and shared objects) into session
on session-enable (per-session events).

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 include/lttng/ust-tracepoint-event.h     | 14 +++++++
 liblttng-ust-baddr/Makefile.am           |  4 +-
 liblttng-ust-baddr/lttng-ust-baddr.c     | 72 ++++++++++++++++++++++++++++++++
 liblttng-ust-baddr/ust_baddr_statedump.c | 21 ++++++++++
 liblttng-ust-baddr/ust_baddr_statedump.h | 60 ++++++++++++++++++++++++++
 liblttng-ust/lttng-events.c              |  2 +
 liblttng-ust/lttng-tracer-core.h         |  3 ++
 liblttng-ust/lttng-ust-comm.c            | 60 ++++++++++++++++++++++++++
 8 files changed, 235 insertions(+), 1 deletion(-)
 create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.c
 create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.h

diff --git a/include/lttng/ust-tracepoint-event.h b/include/lttng/ust-tracepoint-event.h
index bb3a05d..be58030 100644
--- a/include/lttng/ust-tracepoint-event.h
+++ b/include/lttng/ust-tracepoint-event.h
@@ -480,6 +480,18 @@ size_t __event_get_align__##_provider##___##_name(_TP_ARGS_PROTO(_args))      \
 #define TP_FIELDS(...) __VA_ARGS__
 
 /*
+ * For state dump, check that "session" argument (mandatory) matches the
+ * session this event belongs to. Ensures that we write state dump data only
+ * into the started session, not into all sessions.
+ */
+#undef _TP_SESSION_CHECK
+#ifdef TP_SESSION_CHECK
+#define _TP_SESSION_CHECK(session, csession)   (session == csession)
+#else /* TP_SESSION_CHECK */
+#define _TP_SESSION_CHECK(session, csession)   1
+#endif /* TP_SESSION_CHECK */
+
+/*
  * Using twice size for filter stack data to hold size and pointer for
  * each field (worse case). For integers, max size required is 64-bit.
  * Same for double-precision floats. Those fit within
@@ -506,6 +518,8 @@ void __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args))	      \
 									      \
 	if (0)								      \
 		(void) __dynamic_len_idx;	/* don't warn if unused */    \
+	if (!_TP_SESSION_CHECK(session, __chan->session))		      \
+		return;							      \
 	if (caa_unlikely(!CMM_ACCESS_ONCE(__chan->session->active)))	      \
 		return;							      \
 	if (caa_unlikely(!CMM_ACCESS_ONCE(__chan->enabled)))		      \
diff --git a/liblttng-ust-baddr/Makefile.am b/liblttng-ust-baddr/Makefile.am
index afa9489..0d3cf28 100644
--- a/liblttng-ust-baddr/Makefile.am
+++ b/liblttng-ust-baddr/Makefile.am
@@ -5,7 +5,9 @@ lib_LTLIBRARIES = liblttng-ust-baddr.la
 liblttng_ust_baddr_la_SOURCES = \
 	lttng-ust-baddr.c \
 	ust_baddr.c \
-	ust_baddr.h
+	ust_baddr.h \
+	ust_baddr_statedump.c \
+	ust_baddr_statedump.h
 liblttng_ust_baddr_la_LIBADD = \
 	-L$(top_builddir)/liblttng-ust/.libs \
 	-llttng-ust
diff --git a/liblttng-ust-baddr/lttng-ust-baddr.c b/liblttng-ust-baddr/lttng-ust-baddr.c
index f24a171..a856965 100644
--- a/liblttng-ust-baddr/lttng-ust-baddr.c
+++ b/liblttng-ust-baddr/lttng-ust-baddr.c
@@ -34,6 +34,7 @@
 
 #define TRACEPOINT_DEFINE
 #include "ust_baddr.h"
+#include "ust_baddr_statedump.h"
 
 int
 lttng_ust_push_baddr(void *so_base, const char *so_name)
@@ -62,3 +63,74 @@ lttng_ust_pop_baddr(void *so_base)
 	tracepoint(ust_baddr, pop, so_base);
 	return 0;
 }
+
+static int
+extract_soinfo_events(struct dl_phdr_info *info, size_t size, void *data)
+{
+	int j;
+	int num_loadable_segment = 0;
+
+	for (j = 0; j < info->dlpi_phnum; j++) {
+		char resolved_path[PATH_MAX];
+		struct stat sostat;
+		void *base_addr_ptr;
+
+		if (info->dlpi_phdr[j].p_type != PT_LOAD)
+			continue;
+
+		/* Calculate virtual memory address of the loadable segment */
+		base_addr_ptr = (void *) info->dlpi_addr
+			+ info->dlpi_phdr[j].p_vaddr;
+
+		num_loadable_segment += 1;
+		if ((info->dlpi_name == NULL || info->dlpi_name[0] == 0)
+				&& num_loadable_segment == 1) {
+			/*
+			 * If the iterated element is the executable itself we
+			 * have to use Dl_info to determine its full path
+			 */
+			Dl_info dl_info = { 0 };
+			if (!dladdr(base_addr_ptr, &dl_info))
+				return 0;
+			if (!realpath(dl_info.dli_fname, resolved_path))
+				return 0;
+		} else {
+			/*
+			 * For regular dl_phdr_info entries we have to check if
+			 * the path to the shared object really exists
+			 */
+			if (!realpath(info->dlpi_name, resolved_path)) {
+				/* Found vDSO, put the 'path' into brackets */
+				snprintf(resolved_path, PATH_MAX - 1, "[%s]",
+						info->dlpi_name);
+			}
+		}
+
+		if (stat(resolved_path, &sostat)) {
+			sostat.st_size = 0;
+			sostat.st_mtime = -1;
+		}
+
+		tracepoint(ust_baddr_statedump, soinfo,
+				(struct lttng_session *) data, base_addr_ptr,
+				resolved_path, sostat.st_size, sostat.st_mtime);
+
+		/*
+		 * We are only interested in the base address (lowest virtual
+		 * address associated with the memory image), skip the rest
+		 */
+		break;
+	}
+	return 0;
+}
+
+int
+lttng_ust_baddr_statedump(struct lttng_session *session)
+{
+	/*
+	 * Iterate through the list of currently loaded shared objects and
+	 * generate events for loadable segments using extract_soinfo_events
+	 */
+	dl_iterate_phdr(extract_soinfo_events, session);
+	return 0;
+}
diff --git a/liblttng-ust-baddr/ust_baddr_statedump.c b/liblttng-ust-baddr/ust_baddr_statedump.c
new file mode 100644
index 0000000..75f74ca
--- /dev/null
+++ b/liblttng-ust-baddr/ust_baddr_statedump.c
@@ -0,0 +1,21 @@
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
+#define TRACEPOINT_CREATE_PROBES
+#define TP_SESSION_CHECK
+#include "ust_baddr_statedump.h"
diff --git a/liblttng-ust-baddr/ust_baddr_statedump.h b/liblttng-ust-baddr/ust_baddr_statedump.h
new file mode 100644
index 0000000..77a9af4
--- /dev/null
+++ b/liblttng-ust-baddr/ust_baddr_statedump.h
@@ -0,0 +1,60 @@
+#undef TRACEPOINT_PROVIDER
+#define TRACEPOINT_PROVIDER ust_baddr_statedump
+
+#if !defined(_TRACEPOINT_UST_BADDR_STATEDUMP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
+#define _TRACEPOINT_UST_BADDR_STATEDUMP_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <stdint.h>
+#include <unistd.h>
+#include <lttng/ust-events.h>
+
+#define LTTNG_UST_BADDR_STATEDUMP_PROVIDER
+#include <lttng/tracepoint.h>
+
+TRACEPOINT_EVENT(ust_baddr_statedump, soinfo,
+	TP_ARGS(struct lttng_session *, session, void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime),
+	TP_FIELDS(
+		ctf_integer_hex(void *, baddr, baddr)
+		ctf_string(sopath, sopath)
+		ctf_integer(int64_t, size, size)
+		ctf_integer(int64_t, mtime, mtime)
+	)
+)
+
+#endif /* _TRACEPOINT_UST_BADDR_STATEDUMP_H */
+
+#undef TRACEPOINT_INCLUDE
+#define TRACEPOINT_INCLUDE "./ust_baddr_statedump.h"
+
+/* This part must be outside ifdef protection */
+#include <lttng/tracepoint-event.h>
+
+#ifdef __cplusplus
+}
+#endif
diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
index 26601a6..21e3639 100644
--- a/liblttng-ust/lttng-events.c
+++ b/liblttng-ust/lttng-events.c
@@ -293,6 +293,8 @@ int lttng_session_enable(struct lttng_session *session)
 	/* Set atomically the state to "active" */
 	CMM_ACCESS_ONCE(session->active) = 1;
 	CMM_ACCESS_ONCE(session->been_active) = 1;
+
+	lttng_ust_sockinfo_session_enabled(session->owner, session);
 end:
 	return ret;
 }
diff --git a/liblttng-ust/lttng-tracer-core.h b/liblttng-ust/lttng-tracer-core.h
index f643a7e..e7f549e 100644
--- a/liblttng-ust/lttng-tracer-core.h
+++ b/liblttng-ust/lttng-tracer-core.h
@@ -45,4 +45,7 @@ const char *lttng_ust_obj_get_name(int id);
 
 int lttng_get_notify_socket(void *owner);
 
+void lttng_ust_sockinfo_session_enabled(void *owner,
+		struct lttng_session *session_enabled);
+
 #endif /* _LTTNG_TRACER_CORE_H */
diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index a6e4ba3..6ef3006 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -34,6 +34,7 @@
 #include <time.h>
 #include <assert.h>
 #include <signal.h>
+#include <dlfcn.h>
 #include <urcu/uatomic.h>
 #include <urcu/futex.h>
 #include <urcu/compiler.h>
@@ -106,6 +107,7 @@ struct sock_info {
 
 	char wait_shm_path[PATH_MAX];
 	char *wait_shm_mmap;
+	struct lttng_session *session_enabled;
 };
 
 /* Socket from app (connect) to session daemon (listen) for communication */
@@ -122,6 +124,8 @@ struct sock_info global_apps = {
 	.notify_socket = -1,
 
 	.wait_shm_path = "/" LTTNG_UST_WAIT_FILENAME,
+
+	.session_enabled = NULL,
 };
 
 /* TODO: allow global_apps_sock_path override */
@@ -135,6 +139,8 @@ struct sock_info local_apps = {
 
 	.socket = -1,
 	.notify_socket = -1,
+
+	.session_enabled = NULL,
 };
 
 static int wait_poll_fallback;
@@ -176,6 +182,7 @@ static const char *cmd_name_mapping[] = {
 
 static const char *str_timeout;
 static int got_timeout_env;
+static void *ust_baddr_handle;
 
 extern void lttng_ring_buffer_client_overwrite_init(void);
 extern void lttng_ring_buffer_client_overwrite_rt_init(void);
@@ -235,6 +242,39 @@ void print_cmd(int cmd, int handle)
 }
 
 static
+void *lttng_ust_baddr_handle(void)
+{
+	if (!ust_baddr_handle) {
+		ust_baddr_handle = dlopen(
+			"liblttng-ust-baddr.so.0", RTLD_NOW | RTLD_GLOBAL);
+		if (ust_baddr_handle == NULL)
+			ERR("%s", dlerror());
+	}
+	return ust_baddr_handle;
+}
+
+static
+int lttng_ust_baddr_statedump(struct lttng_session *session)
+{
+	static
+	int (*lttng_ust_baddr_init_fn)(struct lttng_session *);
+
+	if (!lttng_ust_baddr_init_fn) {
+		void *baddr_handle = lttng_ust_baddr_handle();
+		if (baddr_handle) {
+			lttng_ust_baddr_init_fn = dlsym(baddr_handle,
+				"lttng_ust_baddr_statedump");
+			if (lttng_ust_baddr_init_fn == NULL)
+				ERR("%s", dlerror());
+		}
+		if (!lttng_ust_baddr_init_fn)
+			return -1;
+	}
+
+	return lttng_ust_baddr_init_fn(session);
+}
+
+static
 int setup_local_apps(void)
 {
 	const char *home_dir;
@@ -1143,6 +1183,13 @@ restart:
 			ret = handle_message(sock_info, sock, &lum);
 			if (ret) {
 				ERR("Error handling message for %s socket", sock_info->name);
+			} else {
+				struct lttng_session *session =
+					sock_info->session_enabled;
+				if (session) {
+					sock_info->session_enabled = NULL;
+					lttng_ust_baddr_statedump(session);
+				}
 			}
 			continue;
 		default:
@@ -1379,6 +1426,12 @@ void __attribute__((destructor)) lttng_ust_exit(void)
 	 * cleanup the threads if there are stalled in a syscall.
 	 */
 	lttng_ust_cleanup(1);
+
+	if (ust_baddr_handle) {
+		int ret = dlclose(ust_baddr_handle);
+		if (ret)
+			ERR("%s", dlerror());
+	}
 }
 
 /*
@@ -1456,3 +1509,10 @@ void ust_after_fork_child(sigset_t *restore_sigset)
 	ust_after_fork_common(restore_sigset);
 	lttng_ust_init();
 }
+
+void lttng_ust_sockinfo_session_enabled(void *owner,
+		struct lttng_session *session_enabled)
+{
+	struct sock_info *sock_info = owner;
+	sock_info->session_enabled = session_enabled;
+}
-- 
1.8.4.2
