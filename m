From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: [RFC PATCH lttng-ust] Make lttng-ust aware of shared
	object base addresses (issue #474)
Date: Tue, 27 Aug 2013 11:55:17 +0200
Message-ID: <1950303.PcKNxt9HMm__20379.3858796873$1377597388$gmane$org@atv-pwoegere-l3.atv.mentorg.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart9263808.cvak8zojPc"
Content-Transfer-Encoding: 7Bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VEFzj-0008On-6w
	for lttng-dev@lists.lttng.org; Tue, 27 Aug 2013 05:55:32 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--nextPart9263808.cvak8zojPc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

...sorry, KMail was sending my draft without asking me first...

Hello,

To allow graphical trace viewers to provide features like address-to-symbol resolution or source lookup (address-to-lineinfo), information about the shared object base address mappings are required. These mappings are inherently time based and potentially change during the application runtime (dlopen, dlcose, dlopen, ...). It's even possible that at a later point in the program execution the same shared object gets mapped to a different base address (I saw that on ARM or PPC)

The patch set below provides an initial (prof-of-concept) implementation (based on the previous discussion on https://bugs.lttng.org/issues/474). It's a starting point for further discussions that will hopefully help me to provide an implementation that is good enough for upstream inclusion.

Applying the patch provides the following additional events for userspace tracing:

*) ust_baddr:push with TP_ARGS(void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime)
*) ust_baddr:pop with TP_ARGS(void *, baddr)

Tracepoints 'ust_baddr:push' and 'ust_baddr:pop' are emitted for every runtime object that makes use of tracing (i.e emits tracepoints/includes tracepoint.h). This is also true for shared objects that get loaded during application run time. Loading a shared object via dlopen will, for example, result in emitting:
[14:22:07.841547445] ust_baddr:push: { cpu_id = 4 }, { baddr = 0x7F8D13DFD000, sopath = "/path/to/plugin1.so", size = 21968, mtime = 1377519722 }
..likewise sometime later a corresponding dlclose in the program will result in emitting:
[14:22:07.841867307] ust_baddr:pop: { cpu_id = 4 }, { baddr = 0x7F8D13DFD000 }

*) ust_baddr:init with TP_ARGS(void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime)

In contrast, ust_baddr:init tracepoints are only emitted when a userspace application gets a "session enabled" sent by the sessiond (necessary if tracing starts in the middle of an already running application). In this case all the currently loaded shared objects are iterated and the base address mappings are recored as ust_baddr:init events with the same payload structure as ust_baddr:push. E.g.

[15:20:32.763114409]  ust_baddr:init: { cpu_id = 1 }, { baddr = 0x7F5BAC083000, sopath = "/lib64/libc-2.17.so", size = 1992089, mtime = 1359709982 }
[15:20:32.763118346]  ust_baddr:init: { cpu_id = 1 }, { baddr = 0x7F5BAEAF0000, sopath = "/lib64/ld-2.17.so", size = 163493, mtime = 1359709980 }
[15:20:32.763125921]  ust_baddr:init: { cpu_id = 1 }, { baddr = 0x7F5BAAE7C000, sopath = "/other/currently/loaded/shared-object.so.0.0.0", size = 58359, mtime = 1377516019 }
... and so on for all other currently loaded shared objects

I have attached sample traces to demonstrate how this looks in practice.


The known deficiencies of the current implementation are:

*) Currently there is no way to disable the mechanism. I don't like the idea of using an environment variable for that (doesn't allow to enable for already running applications). Having this controllable via lttng commands would be preferable. But maybe it's not a real issue. The events a comparably low-frequency.

*) For ust_baddr:init I had to hook into lttng_session_enable/ust_listener_thread. Ideally this hook should be provided as API functionality, controllable via lttng commands. For example:

   lttng on-session-enable shared_obj_state_dumper.so

The requirement of dumping state information on session_enable is generic enough that other instrumentations could also benefit from it (e.g. stack dump for liblttng-ust-cyg-profile/liblttng-ust-cyg-profile-fast).

--
Looking forward to your comments,
Paul

Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division

From 3fb50c1e8503963980f68223b4b810e792dfee66 Mon Sep 17 00:00:00 2001
From: Paul Woegerer <paul_woegerer@mentor.com>
Date: Thu, 22 Aug 2013 14:43:40 +0200
Subject: [PATCH 1/2] Basic support for base address tracing

---
 Makefile.am                          |  1 +
 configure.ac                         |  1 +
 include/lttng/tracepoint.h           | 50 ++++++++++++++++++++++++
 liblttng-ust-baddr/Makefile.am       | 17 ++++++++
 liblttng-ust-baddr/lttng-ust-baddr.c | 74 +++++++++++++++++++++++++++++++++++
 liblttng-ust-baddr/ust_baddr.h       | 76 ++++++++++++++++++++++++++++++++++++
 6 files changed, 219 insertions(+)
 create mode 100644 liblttng-ust-baddr/Makefile.am
 create mode 100644 liblttng-ust-baddr/lttng-ust-baddr.c
 create mode 100644 liblttng-ust-baddr/ust_baddr.h

diff --git a/Makefile.am b/Makefile.am
index dc88c46..f9fcbf3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -4,6 +4,7 @@ SUBDIRS = . include snprintf libringbuffer liblttng-ust-comm \
 		liblttng-ust \
 		liblttng-ust-ctl \
 		liblttng-ust-fork \
+		liblttng-ust-baddr \
 		liblttng-ust-libc-wrapper \
 		liblttng-ust-cyg-profile \
 		tools \
diff --git a/configure.ac b/configure.ac
index 94f8182..a29ac48 100644
--- a/configure.ac
+++ b/configure.ac
@@ -282,6 +282,7 @@ AC_CONFIG_FILES([
 	liblttng-ust/Makefile
 	liblttng-ust-ctl/Makefile
 	liblttng-ust-fork/Makefile
+	liblttng-ust-baddr/Makefile
 	liblttng-ust-java/Makefile
 	liblttng-ust-libc-wrapper/Makefile
 	liblttng-ust-cyg-profile/Makefile
diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
index b3b01cc..462ab52 100644
--- a/include/lttng/tracepoint.h
+++ b/include/lttng/tracepoint.h
@@ -219,6 +219,21 @@ struct tracepoint_dlopen {
 
 extern struct tracepoint_dlopen tracepoint_dlopen;
 
+#ifndef LTTNG_UST_BADDR_PROVIDER
+/*
+ * shared object base address handling (callbacks). Hidden visibility:
+ * shared across objects in a module/main executable.
+ */
+struct baddr_dlopen {
+	void *liblttngust_handle;
+
+	int (*push_baddr)(void *ctor_addr);
+	int (*pop_baddr)(void *ctor_addr);
+};
+
+extern struct baddr_dlopen baddr_dlopen;
+#endif
+
 #if defined(TRACEPOINT_DEFINE) || defined(TRACEPOINT_CREATE_PROBES)
 
 /*
@@ -232,6 +247,10 @@ int __tracepoint_ptrs_registered
 	__attribute__((weak, visibility("hidden")));
 struct tracepoint_dlopen tracepoint_dlopen
 	__attribute__((weak, visibility("hidden")));
+#ifndef LTTNG_UST_BADDR_PROVIDER
+struct baddr_dlopen baddr_dlopen
+	__attribute__((weak, visibility("hidden")));
+#endif
 
 #ifndef _LGPL_SOURCE
 static inline void lttng_ust_notrace
@@ -383,6 +402,24 @@ __tracepoints__ptrs_init(void)
 				__stop___tracepoints_ptrs -
 				__start___tracepoints_ptrs);
 	}
+#ifndef LTTNG_UST_BADDR_PROVIDER
+	if (!baddr_dlopen.liblttngust_handle)
+		baddr_dlopen.liblttngust_handle =
+			dlopen("liblttng-ust-baddr.so.0", RTLD_NOW | RTLD_GLOBAL);
+	if (!baddr_dlopen.liblttngust_handle)
+		return;
+	baddr_dlopen.push_baddr =
+		URCU_FORCE_CAST(int (*)(void *),
+				dlsym(baddr_dlopen.liblttngust_handle,
+					"push_baddr"));
+	baddr_dlopen.pop_baddr =
+		URCU_FORCE_CAST(int (*)(void *),
+				dlsym(baddr_dlopen.liblttngust_handle,
+					"pop_baddr"));
+	if (baddr_dlopen.push_baddr)
+		baddr_dlopen.push_baddr(
+				URCU_FORCE_CAST(void *, &__tracepoints__ptrs_init));
+#endif
 }
 
 static void lttng_ust_notrace __attribute__((destructor))
@@ -394,6 +431,19 @@ __tracepoints__ptrs_destroy(void)
 
 	if (--__tracepoint_ptrs_registered)
 		return;
+#ifndef LTTNG_UST_BADDR_PROVIDER
+	if (baddr_dlopen.pop_baddr)
+		baddr_dlopen.pop_baddr(
+				URCU_FORCE_CAST(void *, &__tracepoints__ptrs_init));
+	if (baddr_dlopen.liblttngust_handle) {
+		ret = dlclose(baddr_dlopen.liblttngust_handle);
+		if (ret) {
+			fprintf(stderr, "Error (%d) in dlclose\n", ret);
+			abort();
+		}
+		memset(&baddr_dlopen, 0, sizeof(baddr_dlopen));
+	}
+#endif
 	if (tracepoint_dlopen.tracepoint_unregister_lib)
 		tracepoint_dlopen.tracepoint_unregister_lib(__start___tracepoints_ptrs);
 	if (tracepoint_dlopen.liblttngust_handle && !__tracepoint_registered) {
diff --git a/liblttng-ust-baddr/Makefile.am b/liblttng-ust-baddr/Makefile.am
new file mode 100644
index 0000000..6fdfda1
--- /dev/null
+++ b/liblttng-ust-baddr/Makefile.am
@@ -0,0 +1,17 @@
+AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
+AM_CFLAGS = -fno-strict-aliasing
+
+lib_LTLIBRARIES = liblttng-ust-baddr.la
+liblttng_ust_baddr_la_SOURCES = \
+	lttng-ust-baddr.c \
+	ust_baddr.h
+liblttng_ust_baddr_la_LIBADD = \
+	-L$(top_builddir)/liblttng-ust/.libs \
+	-llttng-ust
+
+if LTTNG_UST_BUILD_WITH_LIBDL
+liblttng_ust_baddr_la_LIBADD += -ldl
+endif
+if LTTNG_UST_BUILD_WITH_LIBC_DL
+liblttng_ust_baddr_la_LIBADD += -lc
+endif
diff --git a/liblttng-ust-baddr/lttng-ust-baddr.c b/liblttng-ust-baddr/lttng-ust-baddr.c
new file mode 100644
index 0000000..bcfc9df
--- /dev/null
+++ b/liblttng-ust-baddr/lttng-ust-baddr.c
@@ -0,0 +1,74 @@
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
+#define _GNU_SOURCE
+#include <dlfcn.h>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include <errno.h>
+#include <stdint.h>
+#include <stddef.h>
+#include <stdio.h>
+#include "usterr.h"
+
+#define TRACEPOINT_DEFINE
+#define TRACEPOINT_CREATE_PROBES
+#include "ust_baddr.h"
+
+int push_baddr(void *ctor_addr)
+{
+	Dl_info info = { 0 };
+	if (!dladdr(ctor_addr, &info))
+	{
+		ERR("dladdr failed for addr %p", ctor_addr);
+		return 0;
+	}
+
+	char resolved_path[PATH_MAX];
+	if (!realpath(info.dli_fname, resolved_path))
+	{
+		ERR("could no resolve path %s", info.dli_fname);
+		return 0;
+	}
+
+	struct stat sostat;
+	if (stat(resolved_path, &sostat))
+	{
+		ERR("could no access file status for %s", resolved_path);
+		return 0;
+	}
+
+	tracepoint(ust_baddr, push, info.dli_fbase, resolved_path, sostat.st_size, sostat.st_mtime);
+	return 0;
+}
+
+int pop_baddr(void *ctor_addr)
+{
+	Dl_info info = { 0 };
+	if (!dladdr(ctor_addr, &info))
+	{
+		ERR("dladdr failed for addr %p", ctor_addr);
+		return 0;
+	}
+
+	tracepoint(ust_baddr, pop, info.dli_fbase);
+	return 0;
+}
diff --git a/liblttng-ust-baddr/ust_baddr.h b/liblttng-ust-baddr/ust_baddr.h
new file mode 100644
index 0000000..635c678
--- /dev/null
+++ b/liblttng-ust-baddr/ust_baddr.h
@@ -0,0 +1,76 @@
+#undef TRACEPOINT_PROVIDER
+#define TRACEPOINT_PROVIDER ust_baddr
+
+#if !defined(_TRACEPOINT_UST_BADDR_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
+#define _TRACEPOINT_UST_BADDR_H
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
+
+#define LTTNG_UST_BADDR_PROVIDER
+#include <lttng/tracepoint.h>
+
+TRACEPOINT_EVENT(ust_baddr, init,
+	TP_ARGS(void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime),
+	TP_FIELDS(
+		ctf_integer_hex(void *, baddr, baddr)
+		ctf_string(sopath, sopath)
+		ctf_integer(int64_t, size, size)
+		ctf_integer(int64_t, mtime, mtime)
+	)
+)
+
+TRACEPOINT_EVENT(ust_baddr, push,
+	TP_ARGS(void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime),
+	TP_FIELDS(
+		ctf_integer_hex(void *, baddr, baddr)
+		ctf_string(sopath, sopath)
+		ctf_integer(int64_t, size, size)
+		ctf_integer(int64_t, mtime, mtime)
+	)
+)
+
+TRACEPOINT_EVENT(ust_baddr, pop,
+	TP_ARGS(void *, baddr),
+	TP_FIELDS(
+		ctf_integer_hex(void *, baddr, baddr)
+	)
+)
+
+#endif /* _TRACEPOINT_UST_BADDR_H */
+
+#undef TRACEPOINT_INCLUDE
+#define TRACEPOINT_INCLUDE "./ust_baddr.h"
+
+/* This part must be outside ifdef protection */
+#include <lttng/tracepoint-event.h>
+
+#ifdef __cplusplus
+}
+#endif
-- 
1.8.3.4


From 80fc7d17ff6604d2ad7f989a2beaf50a376ad160 Mon Sep 17 00:00:00 2001
From: Paul Woegerer <paul_woegerer@mentor.com>
Date: Fri, 23 Aug 2013 16:32:53 +0200
Subject: [PATCH 2/2] Add base address state tracing on session enable

---
 liblttng-ust-baddr/lttng-ust-baddr.c | 32 ++++++++++++++++++++++++++++++++
 liblttng-ust/lttng-events.c          | 10 ++++++++++
 liblttng-ust/lttng-tracer-core.h     |  2 ++
 liblttng-ust/lttng-ust-comm.c        | 26 ++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/liblttng-ust-baddr/lttng-ust-baddr.c b/liblttng-ust-baddr/lttng-ust-baddr.c
index bcfc9df..389c0b5 100644
--- a/liblttng-ust-baddr/lttng-ust-baddr.c
+++ b/liblttng-ust-baddr/lttng-ust-baddr.c
@@ -18,6 +18,7 @@
 
 #define _GNU_SOURCE
 #include <dlfcn.h>
+#include <link.h>
 
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -72,3 +73,34 @@ int pop_baddr(void *ctor_addr)
 	tracepoint(ust_baddr, pop, info.dli_fbase);
 	return 0;
 }
+
+static
+int _dl_iterate_write_memregion(struct dl_phdr_info *info, size_t size, void *data)
+{
+	int j;
+	for (j = 0; j < info->dlpi_phnum; j++) {
+		if (info->dlpi_phdr[j].p_type == PT_LOAD) {
+			void *base_addr_ptr = info->dlpi_addr + info->dlpi_phdr[j].p_vaddr;
+
+			char resolved_path[PATH_MAX];
+			if (! realpath(info->dlpi_name, resolved_path))
+				return 0;
+
+			struct stat sostat;
+			if (stat(resolved_path, &sostat))
+				return 0;
+
+			tracepoint(ust_baddr, init, base_addr_ptr, resolved_path, sostat.st_size, sostat.st_mtime);
+			break;
+		}
+	}
+	return 0;
+}
+
+int init_baddr()
+{
+	DBG("--- DUMP BADDR STATE ---");
+	dl_iterate_phdr(_dl_iterate_write_memregion, NULL);
+	DBG("--- DUMP BADDR STATE --- DONE.");
+	return 0;
+}
diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
index 26601a6..0efab7d 100644
--- a/liblttng-ust/lttng-events.c
+++ b/liblttng-ust/lttng-events.c
@@ -86,6 +86,14 @@ void lttng_session_sync_enablers(struct lttng_session *session);
 static
 void lttng_enabler_destroy(struct lttng_enabler *enabler);
 
+static int _lttng_session_enabled_transition;
+int lttng_session_enabled_transition()
+{
+	int ret = _lttng_session_enabled_transition;
+	_lttng_session_enabled_transition = 0;
+	return ret;
+}
+
 /*
  * Called with ust lock held.
  */
@@ -293,6 +301,8 @@ int lttng_session_enable(struct lttng_session *session)
 	/* Set atomically the state to "active" */
 	CMM_ACCESS_ONCE(session->active) = 1;
 	CMM_ACCESS_ONCE(session->been_active) = 1;
+
+	_lttng_session_enabled_transition = 1;
 end:
 	return ret;
 }
diff --git a/liblttng-ust/lttng-tracer-core.h b/liblttng-ust/lttng-tracer-core.h
index f643a7e..86f8fb4 100644
--- a/liblttng-ust/lttng-tracer-core.h
+++ b/liblttng-ust/lttng-tracer-core.h
@@ -45,4 +45,6 @@ const char *lttng_ust_obj_get_name(int id);
 
 int lttng_get_notify_socket(void *owner);
 
+int lttng_session_enabled_transition();
+
 #endif /* _LTTNG_TRACER_CORE_H */
diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 475110c..d1aa75b 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -26,6 +26,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <dlfcn.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <errno.h>
@@ -234,6 +235,28 @@ void print_cmd(int cmd, int handle)
 		lttng_ust_obj_get_name(handle), handle);
 }
 
+static void* _lttng_ust_baddr_handle;
+static int lttng_ust_baddr_init()
+{
+	if (!_lttng_ust_baddr_handle) {
+		_lttng_ust_baddr_handle =
+			dlopen("liblttng-ust-baddr.so.0", RTLD_NOW | RTLD_GLOBAL);
+		if (!_lttng_ust_baddr_handle)
+			ERR("%s", dlerror());
+	}
+
+	if (!_lttng_ust_baddr_handle)
+		return 0;
+
+	static int (*lttng_ust_baddr_init_fn)();
+	if (!lttng_ust_baddr_init_fn)
+		lttng_ust_baddr_init_fn = (int (*)()) dlsym(_lttng_ust_baddr_handle, "init_baddr" );
+	if (lttng_ust_baddr_init_fn)
+		lttng_ust_baddr_init_fn();
+
+	return 0;
+}
+
 static
 int setup_local_apps(void)
 {
@@ -1085,6 +1108,9 @@ restart:
 			ret = handle_message(sock_info, sock, &lum);
 			if (ret) {
 				ERR("Error handling message for %s socket", sock_info->name);
+			} else {
+				if (lttng_session_enabled_transition())
+					lttng_ust_baddr_init();
 			}
 			continue;
 		default:
-- 
1.8.3.4


--nextPart9263808.cvak8zojPc
Content-Disposition: attachment;
	filename="so_tracing_test_with_ust_baddr.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8";
	name="so_tracing_test_with_ust_baddr.txt"

[11:37:17.878941447] (+?.?????????) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAE8ED000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase1.so.0.0.0", size = 22036, mtime = 1377519721 }
[11:37:17.878965938] (+0.000024491) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAE6EA000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild1.so.0.0.0", size = 27097, mtime = 1377519721 }
[11:37:17.878984874] (+0.000018936) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAE4E7000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild1-tracepoints.so.0.0.0", size = 35191, mtime = 1377519721 }
[11:37:17.879003301] (+0.000018427) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAE2E4000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libtest-tracepoints.so.0.0.0", size = 35295, mtime = 1377519721 }
[11:37:17.879021786] (+0.000018485) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAE0E1000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase1-tracepoints.so.0.0.0", size = 31692, mtime = 1377519721 }
[11:37:17.879039834] (+0.000018048) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BADEDE000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase2.so.0.0.0", size = 22653, mtime = 1377519722 }
[11:37:17.879046556] (+0.000006722) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BADCD9000, sopath = "/usr/lib64/libuuid.so.1.3.0", size = 19128, mtime = 1360231730 }
[11:37:17.879064400] (+0.000017844) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BADAD6000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild2.so.0.0.0", size = 21950, mtime = 1377519721 }
[11:37:17.879074710] (+0.000010310) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAD8D2000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0", size = 44806, mtime = 1377516019 }
[11:37:17.879092607] (+0.000017897) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAD6CF000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild2-tracepoints.so.0.0.0", size = 31742, mtime = 1377519721 }
[11:37:17.879110449] (+0.000017842) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAD4CC000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase2-tracepoints.so.0.0.0", size = 31692, mtime = 1377519721 }
[11:37:17.879119989] (+0.000009540) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAD285000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0", size = 1579601, mtime = 1377516019 }
[11:37:17.879129270] (+0.000009281) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAD06B000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0", size = 138480, mtime = 1377516018 }
[11:37:17.879134167] (+0.000004897) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BACE63000, sopath = "/lib64/librt-2.17.so", size = 42706, mtime = 1359709985 }
[11:37:17.879143425] (+0.000009258) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BACC5C000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0", size = 103290, mtime = 1377515999 }
[11:37:17.879152823] (+0.000009398) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BACA54000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0", size = 162562, mtime = 1377515999 }
[11:37:17.879161946] (+0.000009123) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAC850000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0", size = 86456, mtime = 1377515998 }
[11:37:17.879167217] (+0.000005271) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAC634000, sopath = "/lib64/libpthread-2.17.so", size = 131133, mtime = 1359709984 }
[11:37:17.879172131] (+0.000004914) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAC430000, sopath = "/lib64/libdl-2.17.so", size = 19016, mtime = 1359709982 }
[11:37:17.879177219] (+0.000005088) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAC083000, sopath = "/lib64/libc-2.17.so", size = 1992089, mtime = 1359709982 }
[11:37:17.879182235] (+0.000005016) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAEAF0000, sopath = "/lib64/ld-2.17.so", size = 163493, mtime = 1359709980 }
[11:37:17.879191739] (+0.000009504) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 2 }, { baddr = 0x7F5BAAE7C000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0", size = 58359, mtime = 1377516019 }
[11:37:17.901173974] (+0.021982235) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1724825000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase1.so.0.0.0", size = 22036, mtime = 1377519721 }
[11:37:17.901195147] (+0.000021173) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1724622000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild1.so.0.0.0", size = 27097, mtime = 1377519721 }
[11:37:17.901209868] (+0.000014721) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F172441F000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild1-tracepoints.so.0.0.0", size = 35191, mtime = 1377519721 }
[11:37:17.901224210] (+0.000014342) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F172421C000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libtest-tracepoints.so.0.0.0", size = 35295, mtime = 1377519721 }
[11:37:17.901239137] (+0.000014927) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1724019000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase1-tracepoints.so.0.0.0", size = 31692, mtime = 1377519721 }
[11:37:17.901253110] (+0.000013973) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1723E16000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase2.so.0.0.0", size = 22653, mtime = 1377519722 }
[11:37:17.901259400] (+0.000006290) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1723C11000, sopath = "/usr/lib64/libuuid.so.1.3.0", size = 19128, mtime = 1360231730 }
[11:37:17.901273220] (+0.000013820) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1723A0E000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild2.so.0.0.0", size = 21950, mtime = 1377519721 }
[11:37:17.901281008] (+0.000007788) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F172380A000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0", size = 44806, mtime = 1377516019 }
[11:37:17.901294874] (+0.000013866) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1723607000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild2-tracepoints.so.0.0.0", size = 31742, mtime = 1377519721 }
[11:37:17.901308560] (+0.000013686) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1723404000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase2-tracepoints.so.0.0.0", size = 31692, mtime = 1377519721 }
[11:37:17.901315774] (+0.000007214) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F17231BD000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0", size = 1579601, mtime = 1377516019 }
[11:37:17.901323170] (+0.000007396) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1722FA3000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0", size = 138480, mtime = 1377516018 }
[11:37:17.901327739] (+0.000004569) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1722D9B000, sopath = "/lib64/librt-2.17.so", size = 42706, mtime = 1359709985 }
[11:37:17.901334778] (+0.000007039) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1722B94000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0", size = 103290, mtime = 1377515999 }
[11:37:17.901341938] (+0.000007160) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F172298C000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0", size = 162562, mtime = 1377515999 }
[11:37:17.901349206] (+0.000007268) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1722788000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0", size = 86456, mtime = 1377515998 }
[11:37:17.901353799] (+0.000004593) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F172256C000, sopath = "/lib64/libpthread-2.17.so", size = 131133, mtime = 1359709984 }
[11:37:17.901358042] (+0.000004243) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1722368000, sopath = "/lib64/libdl-2.17.so", size = 19016, mtime = 1359709982 }
[11:37:17.901362715] (+0.000004673) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1721FBB000, sopath = "/lib64/libc-2.17.so", size = 1992089, mtime = 1359709982 }
[11:37:17.901366673] (+0.000003958) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1724A28000, sopath = "/lib64/ld-2.17.so", size = 163493, mtime = 1359709980 }
[11:37:17.901373316] (+0.000006643) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:init: { cpu_id = 6 }, { baddr = 0x7F1720DB4000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0", size = 58359, mtime = 1377516019 }
[11:37:17.901562199] (+0.000188883) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:push: { cpu_id = 7 }, { baddr = 0x7F172380A000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0", size = 44806, mtime = 1377516019 }
[11:37:17.901666229] (+0.000104030) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:push: { cpu_id = 7 }, { baddr = 0x7F1723A0E000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild2.so.0.0.0", size = 21950, mtime = 1377519721 }
[11:37:17.901692136] (+0.000025907) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:push: { cpu_id = 7 }, { baddr = 0x7F1723E16000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase2.so.0.0.0", size = 22653, mtime = 1377519722 }
[11:37:17.901928242] (+0.000236106) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:push: { cpu_id = 7 }, { baddr = 0x7F1724622000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild1.so.0.0.0", size = 27097, mtime = 1377519721 }
[11:37:17.901951464] (+0.000023222) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:push: { cpu_id = 7 }, { baddr = 0x7F1724825000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase1.so.0.0.0", size = 22036, mtime = 1377519721 }
[11:37:17.901976203] (+0.000024739) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:push: { cpu_id = 7 }, { baddr = 0x400000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/bin/so_tracing_test", size = 29714, mtime = 1377519722 }
[11:37:17.901979084] (+0.000002881) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_entry: { cpu_id = 7 }, { addr = 0x400E50, call_site = 0x7F1721FDCA15 }
[11:37:17.902011387] (+0.000032303) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 test:begin: { cpu_id = 7 }, { }
[11:37:17.902011895] (+0.000000508) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_entry: { cpu_id = 7 }, { addr = 0x401310, call_site = 0x400E7F }
[11:37:17.902014733] (+0.000002838) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 test:info: { cpu_id = 7 }, { msg = "inside test_extra" }
[11:37:17.902015729] (+0.000000996) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_exit: { cpu_id = 7 }, { addr = 0x401310, call_site = 0x400E7F }
[11:37:17.902017039] (+0.000001310) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_entry: { cpu_id = 7 }, { addr = 0x7F1724826180, call_site = 0x400E86 }
[11:37:17.902017508] (+0.000000469) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 base1:begin: { cpu_id = 7 }, { }
[11:37:17.902018533] (+0.000001025) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_entry: { cpu_id = 7 }, { addr = 0x7F17246235C0, call_site = 0x7F17248261B7 }
[11:37:17.902019058] (+0.000000525) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 child1:begin: { cpu_id = 7 }, { }
[11:37:17.902153313] (+0.000134255) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 child1:plugintest: { cpu_id = 7 }, { testnum = 2 }
[11:37:17.902167419] (+0.000014106) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 test:info: { cpu_id = 7 }, { msg = "before dlopen" }
[11:37:17.902283794] (+0.000116375) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:push: { cpu_id = 7 }, { baddr = 0x7F1720BB1000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/so_tracing_test/plugin1.so", size = 21968, mtime = 1377519722 }
[11:37:17.902285396] (+0.000001602) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 test:info: { cpu_id = 7 }, { msg = "after dlopen" }
[11:37:17.902305997] (+0.000020601) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_entry: { cpu_id = 7 }, { addr = 0x7F1720BB2180, call_site = 0x7F17246236B6 }
[11:37:17.902306873] (+0.000000876) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 test:info: { cpu_id = 7 }, { msg = "inside generate_answer" }
[11:37:17.902307773] (+0.000000900) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_exit: { cpu_id = 7 }, { addr = 0x7F1720BB2180, call_site = 0x7F17246236B6 }
[11:37:17.902325039] (+0.000017266) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:pop: { cpu_id = 7 }, { baddr = 0x7F1720BB1000 }
[11:37:17.902346625] (+0.000021586) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 child1:plugintest: { cpu_id = 7 }, { testnum = 1 }
[11:37:17.902448034] (+0.000101409) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:push: { cpu_id = 7 }, { baddr = 0x7F1720BB1000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/so_tracing_test/plugin1.so", size = 21968, mtime = 1377519722 }
[11:37:17.902449739] (+0.000001705) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 test:info: { cpu_id = 7 }, { msg = "after dlopen" }
[11:37:17.902468618] (+0.000018879) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_entry: { cpu_id = 7 }, { addr = 0x7F1720BB2180, call_site = 0x7F17246236B6 }
[11:37:17.902469574] (+0.000000956) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 test:info: { cpu_id = 7 }, { msg = "inside generate_answer" }
[11:37:17.902470653] (+0.000001079) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_exit: { cpu_id = 7 }, { addr = 0x7F1720BB2180, call_site = 0x7F17246236B6 }
[11:37:17.902483310] (+0.000012657) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:pop: { cpu_id = 7 }, { baddr = 0x7F1720BB1000 }
[11:37:17.902496756] (+0.000013446) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 child1:plugintest: { cpu_id = 7 }, { testnum = 0 }
[11:37:17.902603253] (+0.000106497) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:push: { cpu_id = 7 }, { baddr = 0x7F1720BB1000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/so_tracing_test/plugin1.so", size = 21968, mtime = 1377519722 }
[11:37:17.902604793] (+0.000001540) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 test:info: { cpu_id = 7 }, { msg = "after dlopen" }
[11:37:17.902623396] (+0.000018603) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_entry: { cpu_id = 7 }, { addr = 0x7F1720BB2180, call_site = 0x7F17246236B6 }
[11:37:17.902624229] (+0.000000833) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 test:info: { cpu_id = 7 }, { msg = "inside generate_answer" }
[11:37:17.902625136] (+0.000000907) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_exit: { cpu_id = 7 }, { addr = 0x7F1720BB2180, call_site = 0x7F17246236B6 }
[11:37:17.902636592] (+0.000011456) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 ust_baddr:pop: { cpu_id = 7 }, { baddr = 0x7F1720BB1000 }
[11:37:17.902650615] (+0.000014023) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 child1:end: { cpu_id = 7 }, { }
[11:37:17.902652199] (+0.000001584) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_exit: { cpu_id = 7 }, { addr = 0x7F17246235C0, call_site = 0x7F17248261B7 }
[11:37:17.902653057] (+0.000000858) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 base1:end: { cpu_id = 7 }, { }
[11:37:17.902653931] (+0.000000874) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_exit: { cpu_id = 7 }, { addr = 0x7F1724826180, call_site = 0x400E86 }
[11:37:18.639207944] (+0.736554013) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 test:info: { cpu_id = 3 }, { msg = "just sleeping..." }
[11:37:18.902789274] (+0.263581330) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_entry: { cpu_id = 7 }, { addr = 0x7F1723E172A0, call_site = 0x400EB3 }
[11:37:18.902798831] (+0.000009557) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 base2:begin: { cpu_id = 7 }, { }
[11:37:18.902953070] (+0.000154239) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_entry: { cpu_id = 7 }, { addr = 0x7F1723A0F100, call_site = 0x7F1723E172FA }
[11:37:18.902954288] (+0.000001218) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 child2:begin: { cpu_id = 7 }, { }
[11:37:18.902954765] (+0.000000477) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 child2:end: { cpu_id = 7 }, { }
[11:37:18.902955646] (+0.000000881) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_exit: { cpu_id = 7 }, { addr = 0x7F1723A0F100, call_site = 0x7F1723E172FA }
[11:37:18.902956339] (+0.000000693) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 base2:end: { cpu_id = 7 }, { }
[11:37:18.902956881] (+0.000000542) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21087 lttng_ust_cyg_profile:func_exit: { cpu_id = 7 }, { addr = 0x7F1723E172A0, call_site = 0x400EB3 }
[11:37:19.639371696] (+0.736414815) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 test:info: { cpu_id = 3 }, { msg = "just sleeping..." }
[11:37:20.639533354] (+1.000161658) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 test:info: { cpu_id = 3 }, { msg = "just sleeping..." }

--nextPart9263808.cvak8zojPc
Content-Disposition: attachment;
	filename="already_running_so_tracing_test_with_ust_baddr.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8";
	name="already_running_so_tracing_test_with_ust_baddr.txt"

[11:38:59.942012723] (+?.?????????) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA57082E000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase1.so.0.0.0", size = 22036, mtime = 1377519721 }
[11:38:59.942034624] (+0.000021901) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA57062B000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild1.so.0.0.0", size = 27097, mtime = 1377519721 }
[11:38:59.942049572] (+0.000014948) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA570428000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild1-tracepoints.so.0.0.0", size = 35191, mtime = 1377519721 }
[11:38:59.942064092] (+0.000014520) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA570225000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libtest-tracepoints.so.0.0.0", size = 35295, mtime = 1377519721 }
[11:38:59.942078283] (+0.000014191) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA570022000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase1-tracepoints.so.0.0.0", size = 31692, mtime = 1377519721 }
[11:38:59.942092063] (+0.000013780) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56FE1F000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase2.so.0.0.0", size = 22653, mtime = 1377519722 }
[11:38:59.942097671] (+0.000005608) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56FC1A000, sopath = "/usr/lib64/libuuid.so.1.3.0", size = 19128, mtime = 1360231730 }
[11:38:59.942111204] (+0.000013533) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56FA17000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild2.so.0.0.0", size = 21950, mtime = 1377519721 }
[11:38:59.942119261] (+0.000008057) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56F813000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0", size = 44806, mtime = 1377516019 }
[11:38:59.942133093] (+0.000013832) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56F610000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild2-tracepoints.so.0.0.0", size = 31742, mtime = 1377519721 }
[11:38:59.942146786] (+0.000013693) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56F40D000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase2-tracepoints.so.0.0.0", size = 31692, mtime = 1377519721 }
[11:38:59.942154233] (+0.000007447) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56F1C6000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0", size = 1579601, mtime = 1377516019 }
[11:38:59.942161421] (+0.000007188) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56EFAC000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0", size = 138480, mtime = 1377516018 }
[11:38:59.942165393] (+0.000003972) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56EDA4000, sopath = "/lib64/librt-2.17.so", size = 42706, mtime = 1359709985 }
[11:38:59.942172430] (+0.000007037) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56EB9D000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0", size = 103290, mtime = 1377515999 }
[11:38:59.942179675] (+0.000007245) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56E995000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0", size = 162562, mtime = 1377515999 }
[11:38:59.942186315] (+0.000006640) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56E791000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0", size = 86456, mtime = 1377515998 }
[11:38:59.942190284] (+0.000003969) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56E575000, sopath = "/lib64/libpthread-2.17.so", size = 131133, mtime = 1359709984 }
[11:38:59.942194113] (+0.000003829) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56E371000, sopath = "/lib64/libdl-2.17.so", size = 19016, mtime = 1359709982 }
[11:38:59.942198069] (+0.000003956) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56DFC4000, sopath = "/lib64/libc-2.17.so", size = 1992089, mtime = 1359709982 }
[11:38:59.942201890] (+0.000003821) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA570A31000, sopath = "/lib64/ld-2.17.so", size = 163493, mtime = 1359709980 }
[11:38:59.942209183] (+0.000007293) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 ust_baddr:init: { cpu_id = 7 }, { baddr = 0x7FA56CDBD000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0", size = 58359, mtime = 1377516019 }
[11:38:59.944758252] (+0.002549069) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAE8ED000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase1.so.0.0.0", size = 22036, mtime = 1377519721 }
[11:38:59.944780663] (+0.000022411) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAE6EA000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild1.so.0.0.0", size = 27097, mtime = 1377519721 }
[11:38:59.944798733] (+0.000018070) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAE4E7000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild1-tracepoints.so.0.0.0", size = 35191, mtime = 1377519721 }
[11:38:59.944816260] (+0.000017527) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAE2E4000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libtest-tracepoints.so.0.0.0", size = 35295, mtime = 1377519721 }
[11:38:59.944833700] (+0.000017440) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAE0E1000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase1-tracepoints.so.0.0.0", size = 31692, mtime = 1377519721 }
[11:38:59.944851021] (+0.000017321) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BADEDE000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase2.so.0.0.0", size = 22653, mtime = 1377519722 }
[11:38:59.944857030] (+0.000006009) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BADCD9000, sopath = "/usr/lib64/libuuid.so.1.3.0", size = 19128, mtime = 1360231730 }
[11:38:59.944874243] (+0.000017213) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BADAD6000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild2.so.0.0.0", size = 21950, mtime = 1377519721 }
[11:38:59.944883535] (+0.000009292) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAD8D2000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0", size = 44806, mtime = 1377516019 }
[11:38:59.944900948] (+0.000017413) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAD6CF000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libchild2-tracepoints.so.0.0.0", size = 31742, mtime = 1377519721 }
[11:38:59.944918164] (+0.000017216) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAD4CC000, sopath = "/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/so_tracing_test_install/lib64/libbase2-tracepoints.so.0.0.0", size = 31692, mtime = 1377519721 }
[11:38:59.944932915] (+0.000014751) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAD285000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0", size = 1579601, mtime = 1377516019 }
[11:38:59.944941979] (+0.000009064) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAD06B000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0", size = 138480, mtime = 1377516018 }
[11:38:59.944946665] (+0.000004686) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BACE63000, sopath = "/lib64/librt-2.17.so", size = 42706, mtime = 1359709985 }
[11:38:59.944955236] (+0.000008571) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BACC5C000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0", size = 103290, mtime = 1377515999 }
[11:38:59.944964204] (+0.000008968) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BACA54000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0", size = 162562, mtime = 1377515999 }
[11:38:59.944972886] (+0.000008682) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAC850000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0", size = 86456, mtime = 1377515998 }
[11:38:59.944977795] (+0.000004909) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAC634000, sopath = "/lib64/libpthread-2.17.so", size = 131133, mtime = 1359709984 }
[11:38:59.944982122] (+0.000004327) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAC430000, sopath = "/lib64/libdl-2.17.so", size = 19016, mtime = 1359709982 }
[11:38:59.944986926] (+0.000004804) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAC083000, sopath = "/lib64/libc-2.17.so", size = 1992089, mtime = 1359709982 }
[11:38:59.944991551] (+0.000004625) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAEAF0000, sopath = "/lib64/ld-2.17.so", size = 163493, mtime = 1359709980 }
[11:38:59.945000974] (+0.000009423) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 ust_baddr:init: { cpu_id = 3 }, { baddr = 0x7F5BAAE7C000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0", size = 58359, mtime = 1377516019 }
[11:38:59.971430621] (+0.026429647) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 test:info: { cpu_id = 4 }, { msg = "just sleeping..." }
[11:39:00.654035540] (+0.682604919) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 test:info: { cpu_id = 3 }, { msg = "just sleeping..." }
[11:39:00.971591006] (+0.317555466) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 test:info: { cpu_id = 4 }, { msg = "just sleeping..." }
[11:39:01.654196370] (+0.682605364) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 test:info: { cpu_id = 3 }, { msg = "just sleeping..." }
[11:39:01.971755438] (+0.317559068) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 test:info: { cpu_id = 4 }, { msg = "just sleeping..." }
[11:39:02.654356804] (+0.682601366) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 test:info: { cpu_id = 3 }, { msg = "just sleeping..." }
[11:39:02.971915525] (+0.317558721) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 test:info: { cpu_id = 4 }, { msg = "just sleeping..." }
[11:39:03.654513722] (+0.682598197) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:15592 test:info: { cpu_id = 3 }, { msg = "just sleeping..." }
[11:39:03.972104713] (+0.317590991) atv-pwoegere-l3.atv.mentorg.com:so_tracing_test:21143 test:info: { cpu_id = 4 }, { msg = "just sleeping..." }

--nextPart9263808.cvak8zojPc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--nextPart9263808.cvak8zojPc--
