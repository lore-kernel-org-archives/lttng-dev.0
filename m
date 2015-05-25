From: Antoine Busque <abusque@efficios.com>
Subject: [PATCH lttng-ust] Rename helper providers and events
	for consistency
Date: Mon, 25 May 2015 19:17:09 -0400
Message-ID: <1432595829-17966-1-git-send-email-abusque__46622.2832714722$1432595914$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1Yx1ce-0000tS-Kf
 for lttng-dev@lists.lttng.org; Mon, 25 May 2015 19:17:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id F131C34016E
 for <lttng-dev@lists.lttng.org>; Mon, 25 May 2015 23:17:34 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This patch renders uniform the provider names of UST helpers by making
them all start with the "lttng_ust_" prefix. Also, the helper formerly
known as "ust_baddr" is now "lttng_ust_dl", and its "push" and "pop"
events are now "dlopen" and "dlclose", respectively. This is in line
with the other helpers, for which the name of the provider reflects
the name of the library, and the names of events correspond to those
of the traced functions.

Signed-off-by: Antoine Busque <abusque@efficios.com>
---
 liblttng-ust-dl/Makefile.am                   |   6 +-
 liblttng-ust-dl/lttng-ust-dl.c                | 111 ++++++++++++++++++++++++++
 liblttng-ust-dl/ust_baddr.c                   |  21 -----
 liblttng-ust-dl/ust_baddr.h                   |  66 ---------------
 liblttng-ust-dl/ust_dl.c                      |  21 +++++
 liblttng-ust-dl/ust_dl.h                      |  66 +++++++++++++++
 liblttng-ust-dl/ustdl.c                       | 111 --------------------------
 liblttng-ust-libc-wrapper/lttng-ust-malloc.c  |  21 +++--
 liblttng-ust-libc-wrapper/lttng-ust-pthread.c |   8 +-
 liblttng-ust-libc-wrapper/ust_libc.h          |  14 ++--
 liblttng-ust-libc-wrapper/ust_pthread.h       |  10 +--
 11 files changed, 231 insertions(+), 224 deletions(-)
 create mode 100644 liblttng-ust-dl/lttng-ust-dl.c
 delete mode 100644 liblttng-ust-dl/ust_baddr.c
 delete mode 100644 liblttng-ust-dl/ust_baddr.h
 create mode 100644 liblttng-ust-dl/ust_dl.c
 create mode 100644 liblttng-ust-dl/ust_dl.h
 delete mode 100644 liblttng-ust-dl/ustdl.c

diff --git a/liblttng-ust-dl/Makefile.am b/liblttng-ust-dl/Makefile.am
index b8ea2a3..049ac65 100644
--- a/liblttng-ust-dl/Makefile.am
+++ b/liblttng-ust-dl/Makefile.am
@@ -3,9 +3,9 @@ AM_CFLAGS = -fno-strict-aliasing
 
 lib_LTLIBRARIES = liblttng-ust-dl.la
 liblttng_ust_dl_la_SOURCES = \
-	ustdl.c \
-	ust_baddr.c \
-	ust_baddr.h
+	lttng-ust-dl.c \
+	ust_dl.c \
+	ust_dl.h
 liblttng_ust_dl_la_LIBADD = \
 	$(top_builddir)/liblttng-ust/liblttng-ust.la
 
diff --git a/liblttng-ust-dl/lttng-ust-dl.c b/liblttng-ust-dl/lttng-ust-dl.c
new file mode 100644
index 0000000..13d2b43
--- /dev/null
+++ b/liblttng-ust-dl/lttng-ust-dl.c
@@ -0,0 +1,111 @@
+/*
+ * Copyright (C) 2013  Paul Woegerer <paul.woegerer@mentor.com>
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
+#define _LGPL_SOURCE
+#define _GNU_SOURCE
+#include <lttng/ust-dlfcn.h>
+#include <inttypes.h>
+#include <link.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <signal.h>
+#include <sched.h>
+#include <stdarg.h>
+#include "usterr-signal-safe.h"
+
+#include <lttng/ust-compiler.h>
+#include <lttng/ust.h>
+
+#define TRACEPOINT_DEFINE
+#include "ust_dl.h"
+
+static void *(*__lttng_ust_plibc_dlopen)(const char *filename, int flag);
+static int (*__lttng_ust_plibc_dlclose)(void *handle);
+
+static
+void *_lttng_ust_dl_libc_dlopen(const char *filename, int flag)
+{
+	if (!__lttng_ust_plibc_dlopen) {
+		__lttng_ust_plibc_dlopen = dlsym(RTLD_NEXT, "dlopen");
+		if (__lttng_ust_plibc_dlopen == NULL) {
+			fprintf(stderr, "%s\n", dlerror());
+			return NULL;
+		}
+	}
+	return __lttng_ust_plibc_dlopen(filename, flag);
+}
+
+static
+int _lttng_ust_dl_libc_dlclose(void *handle)
+{
+	if (!__lttng_ust_plibc_dlclose) {
+		__lttng_ust_plibc_dlclose = dlsym(RTLD_NEXT, "dlclose");
+		if (__lttng_ust_plibc_dlclose == NULL) {
+			fprintf(stderr, "%s\n", dlerror());
+			return -1;
+		}
+	}
+	return __lttng_ust_plibc_dlclose(handle);
+}
+
+static
+void lttng_ust_dl_dlopen(void *so_base, const char *so_name)
+{
+	char resolved_path[PATH_MAX];
+	struct stat sostat;
+
+	if (!realpath(so_name, resolved_path)) {
+		ERR("could not resolve path '%s'", so_name);
+		return;
+	}
+
+	if (stat(resolved_path, &sostat)) {
+		ERR("could not access file status for %s", resolved_path);
+		return;
+	}
+
+	tracepoint(lttng_ust_dl, dlopen,
+		so_base, resolved_path, sostat.st_size, sostat.st_mtime);
+	return;
+}
+
+void *dlopen(const char *filename, int flag)
+{
+	void *handle = _lttng_ust_dl_libc_dlopen(filename, flag);
+	if (__tracepoint_ptrs_registered && handle) {
+		struct link_map *p = NULL;
+		if (dlinfo(handle, RTLD_DI_LINKMAP, &p) != -1 && p != NULL
+				&& p->l_addr != 0)
+			lttng_ust_dl_dlopen((void *) p->l_addr, p->l_name);
+	}
+	return handle;
+}
+
+int dlclose(void *handle)
+{
+	if (__tracepoint_ptrs_registered && handle) {
+		struct link_map *p = NULL;
+		if (dlinfo(handle, RTLD_DI_LINKMAP, &p) != -1 && p != NULL
+				&& p->l_addr != 0)
+			tracepoint(lttng_ust_dl, dlclose, (void *) p->l_addr);
+	}
+	return _lttng_ust_dl_libc_dlclose(handle);
+}
diff --git a/liblttng-ust-dl/ust_baddr.c b/liblttng-ust-dl/ust_baddr.c
deleted file mode 100644
index f5b95b0..0000000
--- a/liblttng-ust-dl/ust_baddr.c
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
- */
-
-#define _LGPL_SOURCE
-#define TRACEPOINT_CREATE_PROBES
-#include "ust_baddr.h"
diff --git a/liblttng-ust-dl/ust_baddr.h b/liblttng-ust-dl/ust_baddr.h
deleted file mode 100644
index 2c757f7..0000000
--- a/liblttng-ust-dl/ust_baddr.h
+++ /dev/null
@@ -1,66 +0,0 @@
-#undef TRACEPOINT_PROVIDER
-#define TRACEPOINT_PROVIDER ust_baddr
-
-#if !defined(_TRACEPOINT_UST_BADDR_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
-#define _TRACEPOINT_UST_BADDR_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-/*
- * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
- * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- */
-
-#include <stdint.h>
-#include <unistd.h>
-
-#define LTTNG_UST_BADDR_PROVIDER
-#include <lttng/tracepoint.h>
-
-TRACEPOINT_EVENT(ust_baddr, push,
-	TP_ARGS(void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime),
-	TP_FIELDS(
-		ctf_integer_hex(void *, baddr, baddr)
-		ctf_string(sopath, sopath)
-		ctf_integer(int64_t, size, size)
-		ctf_integer(int64_t, mtime, mtime)
-	)
-)
-
-TRACEPOINT_EVENT(ust_baddr, pop,
-	TP_ARGS(void *, baddr),
-	TP_FIELDS(
-		ctf_integer_hex(void *, baddr, baddr)
-	)
-)
-
-#endif /* _TRACEPOINT_UST_BADDR_H */
-
-#undef TRACEPOINT_INCLUDE
-#define TRACEPOINT_INCLUDE "./ust_baddr.h"
-
-/* This part must be outside ifdef protection */
-#include <lttng/tracepoint-event.h>
-
-#ifdef __cplusplus
-}
-#endif
diff --git a/liblttng-ust-dl/ust_dl.c b/liblttng-ust-dl/ust_dl.c
new file mode 100644
index 0000000..f24f1d2
--- /dev/null
+++ b/liblttng-ust-dl/ust_dl.c
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
+#define _LGPL_SOURCE
+#define TRACEPOINT_CREATE_PROBES
+#include "ust_dl.h"
diff --git a/liblttng-ust-dl/ust_dl.h b/liblttng-ust-dl/ust_dl.h
new file mode 100644
index 0000000..1080189
--- /dev/null
+++ b/liblttng-ust-dl/ust_dl.h
@@ -0,0 +1,66 @@
+#undef TRACEPOINT_PROVIDER
+#define TRACEPOINT_PROVIDER lttng_ust_dl
+
+#if !defined(_TRACEPOINT_UST_DL_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
+#define _TRACEPOINT_UST_DL_H
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
+#define LTTNG_UST_DL_PROVIDER
+#include <lttng/tracepoint.h>
+
+TRACEPOINT_EVENT(lttng_ust_dl, dlopen,
+	TP_ARGS(void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime),
+	TP_FIELDS(
+		ctf_integer_hex(void *, baddr, baddr)
+		ctf_string(sopath, sopath)
+		ctf_integer(int64_t, size, size)
+		ctf_integer(int64_t, mtime, mtime)
+	)
+)
+
+TRACEPOINT_EVENT(lttng_ust_dl, dlclose,
+	TP_ARGS(void *, baddr),
+	TP_FIELDS(
+		ctf_integer_hex(void *, baddr, baddr)
+	)
+)
+
+#endif /* _TRACEPOINT_UST_DL_H */
+
+#undef TRACEPOINT_INCLUDE
+#define TRACEPOINT_INCLUDE "./ust_dl.h"
+
+/* This part must be outside ifdef protection */
+#include <lttng/tracepoint-event.h>
+
+#ifdef __cplusplus
+}
+#endif
diff --git a/liblttng-ust-dl/ustdl.c b/liblttng-ust-dl/ustdl.c
deleted file mode 100644
index 1ef84c3..0000000
--- a/liblttng-ust-dl/ustdl.c
+++ /dev/null
@@ -1,111 +0,0 @@
-/*
- * Copyright (C) 2013  Paul Woegerer <paul.woegerer@mentor.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; version 2.1 of
- * the License.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
- */
-
-#define _LGPL_SOURCE
-#define _GNU_SOURCE
-#include <lttng/ust-dlfcn.h>
-#include <inttypes.h>
-#include <link.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <limits.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <signal.h>
-#include <sched.h>
-#include <stdarg.h>
-#include "usterr-signal-safe.h"
-
-#include <lttng/ust-compiler.h>
-#include <lttng/ust.h>
-
-#define TRACEPOINT_DEFINE
-#include "ust_baddr.h"
-
-static void *(*__lttng_ust_plibc_dlopen)(const char *filename, int flag);
-static int (*__lttng_ust_plibc_dlclose)(void *handle);
-
-static
-void *_lttng_ust_dl_libc_dlopen(const char *filename, int flag)
-{
-	if (!__lttng_ust_plibc_dlopen) {
-		__lttng_ust_plibc_dlopen = dlsym(RTLD_NEXT, "dlopen");
-		if (__lttng_ust_plibc_dlopen == NULL) {
-			fprintf(stderr, "%s\n", dlerror());
-			return NULL;
-		}
-	}
-	return __lttng_ust_plibc_dlopen(filename, flag);
-}
-
-static
-int _lttng_ust_dl_libc_dlclose(void *handle)
-{
-	if (!__lttng_ust_plibc_dlclose) {
-		__lttng_ust_plibc_dlclose = dlsym(RTLD_NEXT, "dlclose");
-		if (__lttng_ust_plibc_dlclose == NULL) {
-			fprintf(stderr, "%s\n", dlerror());
-			return -1;
-		}
-	}
-	return __lttng_ust_plibc_dlclose(handle);
-}
-
-static
-void lttng_ust_baddr_push(void *so_base, const char *so_name)
-{
-	char resolved_path[PATH_MAX];
-	struct stat sostat;
-
-	if (!realpath(so_name, resolved_path)) {
-		ERR("could not resolve path '%s'", so_name);
-		return;
-	}
-
-	if (stat(resolved_path, &sostat)) {
-		ERR("could not access file status for %s", resolved_path);
-		return;
-	}
-
-	tracepoint(ust_baddr, push,
-		so_base, resolved_path, sostat.st_size, sostat.st_mtime);
-	return;
-}
-
-void *dlopen(const char *filename, int flag)
-{
-	void *handle = _lttng_ust_dl_libc_dlopen(filename, flag);
-	if (__tracepoint_ptrs_registered && handle) {
-		struct link_map *p = NULL;
-		if (dlinfo(handle, RTLD_DI_LINKMAP, &p) != -1 && p != NULL
-				&& p->l_addr != 0)
-			lttng_ust_baddr_push((void *) p->l_addr, p->l_name);
-	}
-	return handle;
-}
-
-int dlclose(void *handle)
-{
-	if (__tracepoint_ptrs_registered && handle) {
-		struct link_map *p = NULL;
-		if (dlinfo(handle, RTLD_DI_LINKMAP, &p) != -1 && p != NULL
-				&& p->l_addr != 0)
-			tracepoint(ust_baddr, pop, (void *) p->l_addr);
-	}
-	return _lttng_ust_dl_libc_dlclose(handle);
-}
diff --git a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
index 14545c2..652dd5a 100644
--- a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
+++ b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
@@ -9,7 +9,7 @@
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
  * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
@@ -260,7 +260,8 @@ void *malloc(size_t size)
 	}
 	retval = cur_alloc.malloc(size);
 	if (URCU_TLS(malloc_nesting) == 1) {
-		tracepoint(ust_libc, malloc, size, retval, __builtin_return_address(0));
+		tracepoint(lttng_ust_libc, malloc,
+			size, retval, __builtin_return_address(0));
 	}
 	URCU_TLS(malloc_nesting)--;
 	return retval;
@@ -279,7 +280,8 @@ void free(void *ptr)
 	}
 
 	if (URCU_TLS(malloc_nesting) == 1) {
-		tracepoint(ust_libc, free, ptr, __builtin_return_address(0));
+		tracepoint(lttng_ust_libc, free,
+			ptr, __builtin_return_address(0));
 	}
 
 	if (cur_alloc.free == NULL) {
@@ -308,7 +310,8 @@ void *calloc(size_t nmemb, size_t size)
 	}
 	retval = cur_alloc.calloc(nmemb, size);
 	if (URCU_TLS(malloc_nesting) == 1) {
-		tracepoint(ust_libc, calloc, nmemb, size, retval, __builtin_return_address(0));
+		tracepoint(lttng_ust_libc, calloc,
+			nmemb, size, retval, __builtin_return_address(0));
 	}
 	URCU_TLS(malloc_nesting)--;
 	return retval;
@@ -360,7 +363,8 @@ void *realloc(void *ptr, size_t size)
 	retval = cur_alloc.realloc(ptr, size);
 end:
 	if (URCU_TLS(malloc_nesting) == 1) {
-		tracepoint(ust_libc, realloc, ptr, size, retval, __builtin_return_address(0));
+		tracepoint(lttng_ust_libc, realloc,
+			ptr, size, retval, __builtin_return_address(0));
 	}
 	URCU_TLS(malloc_nesting)--;
 	return retval;
@@ -380,7 +384,9 @@ void *memalign(size_t alignment, size_t size)
 	}
 	retval = cur_alloc.memalign(alignment, size);
 	if (URCU_TLS(malloc_nesting) == 1) {
-		tracepoint(ust_libc, memalign, alignment, size, retval, __builtin_return_address(0));
+		tracepoint(lttng_ust_libc, memalign,
+			alignment, size, retval,
+			__builtin_return_address(0));
 	}
 	URCU_TLS(malloc_nesting)--;
 	return retval;
@@ -400,7 +406,8 @@ int posix_memalign(void **memptr, size_t alignment, size_t size)
 	}
 	retval = cur_alloc.posix_memalign(memptr, alignment, size);
 	if (URCU_TLS(malloc_nesting) == 1) {
-		tracepoint(ust_libc, posix_memalign, *memptr, alignment, size,
+		tracepoint(lttng_ust_libc, posix_memalign,
+			*memptr, alignment, size,
 			retval, __builtin_return_address(0));
 	}
 	URCU_TLS(malloc_nesting)--;
diff --git a/liblttng-ust-libc-wrapper/lttng-ust-pthread.c b/liblttng-ust-libc-wrapper/lttng-ust-pthread.c
index 45789aa..97e3eb8 100644
--- a/liblttng-ust-libc-wrapper/lttng-ust-pthread.c
+++ b/liblttng-ust-libc-wrapper/lttng-ust-pthread.c
@@ -46,9 +46,9 @@ int pthread_mutex_lock(pthread_mutex_t *mutex)
 	}
 
 	thread_in_trace = 1;
-	tracepoint(ust_pthread, pthread_mutex_lock_req, mutex);
+	tracepoint(lttng_ust_pthread, pthread_mutex_lock_req, mutex);
 	retval = mutex_lock(mutex);
-	tracepoint(ust_pthread, pthread_mutex_lock_acq, mutex, retval);
+	tracepoint(lttng_ust_pthread, pthread_mutex_lock_acq, mutex, retval);
 	thread_in_trace = 0;
 	return retval;
 }
@@ -74,7 +74,7 @@ int pthread_mutex_trylock(pthread_mutex_t *mutex)
 
 	thread_in_trace = 1;
 	retval = mutex_trylock(mutex);
-	tracepoint(ust_pthread, pthread_mutex_trylock, mutex, retval);
+	tracepoint(lttng_ust_pthread, pthread_mutex_trylock, mutex, retval);
 	thread_in_trace = 0;
 	return retval;
 }
@@ -100,7 +100,7 @@ int pthread_mutex_unlock(pthread_mutex_t *mutex)
 
 	thread_in_trace = 1;
 	retval = mutex_unlock(mutex);
-	tracepoint(ust_pthread, pthread_mutex_unlock, mutex, retval);
+	tracepoint(lttng_ust_pthread, pthread_mutex_unlock, mutex, retval);
 	thread_in_trace = 0;
 	return retval;
 }
diff --git a/liblttng-ust-libc-wrapper/ust_libc.h b/liblttng-ust-libc-wrapper/ust_libc.h
index 222da2d..ab190e8 100644
--- a/liblttng-ust-libc-wrapper/ust_libc.h
+++ b/liblttng-ust-libc-wrapper/ust_libc.h
@@ -1,5 +1,5 @@
 #undef TRACEPOINT_PROVIDER
-#define TRACEPOINT_PROVIDER ust_libc
+#define TRACEPOINT_PROVIDER lttng_ust_libc
 
 #if !defined(_TRACEPOINT_UST_LIBC_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
 #define _TRACEPOINT_UST_LIBC_H
@@ -32,7 +32,7 @@ extern "C" {
 
 #include <lttng/tracepoint.h>
 
-TRACEPOINT_EVENT(ust_libc, malloc,
+TRACEPOINT_EVENT(lttng_ust_libc, malloc,
 	TP_ARGS(size_t, size, void *, ptr, void *, caller),
 	TP_FIELDS(
 		ctf_integer(size_t, size, size)
@@ -41,7 +41,7 @@ TRACEPOINT_EVENT(ust_libc, malloc,
 	)
 )
 
-TRACEPOINT_EVENT(ust_libc, free,
+TRACEPOINT_EVENT(lttng_ust_libc, free,
 	TP_ARGS(void *, ptr, void *, caller),
 	TP_FIELDS(
 		ctf_integer_hex(void *, ptr, ptr)
@@ -49,7 +49,7 @@ TRACEPOINT_EVENT(ust_libc, free,
 	)
 )
 
-TRACEPOINT_EVENT(ust_libc, calloc,
+TRACEPOINT_EVENT(lttng_ust_libc, calloc,
 	TP_ARGS(size_t, nmemb, size_t, size, void *, ptr, void *, caller),
 	TP_FIELDS(
 		ctf_integer(size_t, nmemb, nmemb)
@@ -59,7 +59,7 @@ TRACEPOINT_EVENT(ust_libc, calloc,
 	)
 )
 
-TRACEPOINT_EVENT(ust_libc, realloc,
+TRACEPOINT_EVENT(lttng_ust_libc, realloc,
 	TP_ARGS(void *, in_ptr, size_t, size, void *, ptr, void *, caller),
 	TP_FIELDS(
 		ctf_integer_hex(void *, in_ptr, in_ptr)
@@ -69,7 +69,7 @@ TRACEPOINT_EVENT(ust_libc, realloc,
 	)
 )
 
-TRACEPOINT_EVENT(ust_libc, memalign,
+TRACEPOINT_EVENT(lttng_ust_libc, memalign,
 	TP_ARGS(size_t, alignment, size_t, size, void *, ptr, void *, caller),
 	TP_FIELDS(
 		ctf_integer(size_t, alignment, alignment)
@@ -79,7 +79,7 @@ TRACEPOINT_EVENT(ust_libc, memalign,
 	)
 )
 
-TRACEPOINT_EVENT(ust_libc, posix_memalign,
+TRACEPOINT_EVENT(lttng_ust_libc, posix_memalign,
 	TP_ARGS(void *, out_ptr, size_t, alignment, size_t, size, int, result, void *, caller),
 	TP_FIELDS(
 		ctf_integer_hex(void *, out_ptr, out_ptr)
diff --git a/liblttng-ust-libc-wrapper/ust_pthread.h b/liblttng-ust-libc-wrapper/ust_pthread.h
index 7d35c3a..795cf9a 100644
--- a/liblttng-ust-libc-wrapper/ust_pthread.h
+++ b/liblttng-ust-libc-wrapper/ust_pthread.h
@@ -1,5 +1,5 @@
 #undef TRACEPOINT_PROVIDER
-#define TRACEPOINT_PROVIDER ust_pthread
+#define TRACEPOINT_PROVIDER lttng_ust_pthread
 
 #if !defined(_TRACEPOINT_UST_PTHREAD_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
 #define _TRACEPOINT_UST_PTHREAD_H
@@ -32,14 +32,14 @@ extern "C" {
 
 #include <lttng/tracepoint.h>
 
-TRACEPOINT_EVENT(ust_pthread, pthread_mutex_lock_req,
+TRACEPOINT_EVENT(lttng_ust_pthread, pthread_mutex_lock_req,
 	TP_ARGS(pthread_mutex_t *, mutex),
 	TP_FIELDS(
 		ctf_integer_hex(void *, mutex, mutex)
 	)
 )
 
-TRACEPOINT_EVENT(ust_pthread, pthread_mutex_lock_acq,
+TRACEPOINT_EVENT(lttng_ust_pthread, pthread_mutex_lock_acq,
 	TP_ARGS(pthread_mutex_t *, mutex, int, status),
 	TP_FIELDS(
 		ctf_integer_hex(void *, mutex, mutex)
@@ -47,7 +47,7 @@ TRACEPOINT_EVENT(ust_pthread, pthread_mutex_lock_acq,
 	)
 )
 
-TRACEPOINT_EVENT(ust_pthread, pthread_mutex_trylock,
+TRACEPOINT_EVENT(lttng_ust_pthread, pthread_mutex_trylock,
 	TP_ARGS(pthread_mutex_t *, mutex, int, status),
 	TP_FIELDS(
 		ctf_integer_hex(void *, mutex, mutex)
@@ -55,7 +55,7 @@ TRACEPOINT_EVENT(ust_pthread, pthread_mutex_trylock,
 	)
 )
 
-TRACEPOINT_EVENT(ust_pthread, pthread_mutex_unlock,
+TRACEPOINT_EVENT(lttng_ust_pthread, pthread_mutex_unlock,
 	TP_ARGS(pthread_mutex_t *, mutex, int, status),
 	TP_FIELDS(
 		ctf_integer_hex(void *, mutex, mutex)
-- 
2.4.1
