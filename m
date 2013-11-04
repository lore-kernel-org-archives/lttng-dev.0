From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Broken patch for a wrapping libdl
Date: Mon, 4 Nov 2013 11:55:10 -0500
Message-ID: <5277D16E.4080603__9795.5884681598$1383584211$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050706020308020106080800"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1VdNRO-0007ra-Dr
	for lttng-dev@lists.lttng.org; Mon, 04 Nov 2013 11:55:56 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--------------050706020308020106080800
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hello tracing arch-wizards,

I was working a bit on a trace with the cyg_profile stuff, and an issue
that would arise is when you dynamically lync a library, you don't have
it's name in the symbol tables of the executable, so you cannot nm it to
have something human readable in the callstack.

The easy solution is to wrap libdl, that way you get the handle of the
lib i dlopen, and from that you get the function name in dlsym, it also
handles seamlessly if a lib is closed, and another would replace the
addresses used.

The only problem is, it doesn't work and I don't have time to get it
working (in the short term).

I am posting this beginning idea to see if it generates any
interest/solutions.

Hope this works out,

Matthew

--------------050706020308020106080800
Content-Type: text/x-patch; name="0001-Add-libdl-wrapper.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-Add-libdl-wrapper.patch"

From 5c833f68b1e7007b7c5ee425d71bbae79067c695 Mon Sep 17 00:00:00 2001
From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Date: Mon, 4 Nov 2013 00:06:32 -0500
Subject: [PATCH] Add libdl wrapper

---
 liblttng-ust-libc-wrapper/Makefile.am    |   13 +++++-
 liblttng-ust-libc-wrapper/lttng-ust-dl.c |   51 ++++++++++++++++++++++
 liblttng-ust-libc-wrapper/run            |    2 +-
 liblttng-ust-libc-wrapper/ust_libc_dl.h  |   70 ++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 2 deletions(-)
 create mode 100644 liblttng-ust-libc-wrapper/lttng-ust-dl.c
 create mode 100644 liblttng-ust-libc-wrapper/ust_libc_dl.h

diff --git a/liblttng-ust-libc-wrapper/Makefile.am b/liblttng-ust-libc-wrapper/Makefile.am
index d402d53..2dffecd 100644
--- a/liblttng-ust-libc-wrapper/Makefile.am
+++ b/liblttng-ust-libc-wrapper/Makefile.am
@@ -2,7 +2,9 @@ AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
 AM_CFLAGS = -fno-strict-aliasing
 
 lib_LTLIBRARIES = liblttng-ust-libc-wrapper.la \
-  liblttng-ust-pthread-wrapper.la
+  liblttng-ust-pthread-wrapper.la \ 
+  liblttng-ust-libc-dl-wrapper.la 
+
 liblttng_ust_libc_wrapper_la_SOURCES = \
 	lttng-ust-malloc.c \
 	ust_libc.h
@@ -10,6 +12,13 @@ liblttng_ust_libc_wrapper_la_LIBADD = \
 	-L$(top_builddir)/liblttng-ust/.libs \
 	-llttng-ust
 
+liblttng_ust_libc_dl_wrapper_la_SOURCES = \
+	lttng-ust-dl.c \
+	ust_libc_dl.h
+liblttng_ust_libc_dl_wrapper_la_LIBADD = \
+	-L$(top_builddir)/liblttng-ust/.libs \
+	-llttng-ust
+
 liblttng_ust_pthread_wrapper_la_SOURCES = \
 	lttng-ust-pthread.c \
 	ust_pthread.h
@@ -20,10 +29,12 @@ liblttng_ust_pthread_wrapper_la_LIBADD = \
 if LTTNG_UST_BUILD_WITH_LIBDL
 liblttng_ust_libc_wrapper_la_LIBADD += -ldl
 liblttng_ust_pthread_wrapper_la_LIBADD += -ldl
+liblttng_ust_libc_dl_wrapper_la_LIBADD += -ldl
 endif
 if LTTNG_UST_BUILD_WITH_LIBC_DL
 liblttng_ust_libc_wrapper_la_LIBADD += -lc
 liblttng_ust_pthread_wrapper_la_LIBADD += -lc
+liblttng_ust_libc_dl_wrapper_la_LIBADD += -lc
 endif
 
 noinst_SCRIPTS = run
diff --git a/liblttng-ust-libc-wrapper/lttng-ust-dl.c b/liblttng-ust-libc-wrapper/lttng-ust-dl.c
new file mode 100644
index 0000000..637bbac
--- /dev/null
+++ b/liblttng-ust-libc-wrapper/lttng-ust-dl.c
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2009  Pierre-Marc Fournier
+ * Copyright (C) 2011  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
+#define TRACEPOINT_DEFINE
+#define TRACEPOINT_CREATE_PROBES
+#include "ust_libc_dl.h"
+
+extern void *__libc_dlopen (const char *, int);
+extern void *__libc_dlsym (void *, const char *);
+
+extern void *__libc_dlclose (void *);
+
+
+void *dlopen(const char *filename, int flag){
+	void* result = __libc_dlopen(filename, flag);
+	tracepoint(ust_libc, dlopen, filename, flag, result);
+	return result;
+}
+
+void *dlsym(void *handle, const char *symbol)
+{
+	void* result = __libc_dlsym(handle, symbol); 
+	tracepoint(ust_libc, dlsym, handle, symbol, result);
+	return result;
+}
+
+int dlclose(void *handle){
+	int result = __libc_dlclose(handle);
+	tracepoint(ust_libc, dlclose, handle, result);
+	return result;
+}
+
diff --git a/liblttng-ust-libc-wrapper/run b/liblttng-ust-libc-wrapper/run
index 80d4175..f5ea79b 100755
--- a/liblttng-ust-libc-wrapper/run
+++ b/liblttng-ust-libc-wrapper/run
@@ -1,3 +1,3 @@
 #!/bin/sh
 
-LD_VERBOSE=1 LD_PRELOAD=.libs/liblttng-ust-libc-wrapper.so ${*}
+LD_VERBOSE=1 LD_PRELOAD=".libs/liblttng-ust-libc-wrapper.so .libs/liblttng-ust-libc-dl-wrapper.so" ${*}
diff --git a/liblttng-ust-libc-wrapper/ust_libc_dl.h b/liblttng-ust-libc-wrapper/ust_libc_dl.h
new file mode 100644
index 0000000..387fb7f
--- /dev/null
+++ b/liblttng-ust-libc-wrapper/ust_libc_dl.h
@@ -0,0 +1,70 @@
+#undef TRACEPOINT_PROVIDER
+#define TRACEPOINT_PROVIDER ust_libc_dl
+
+#if !defined(_TRACEPOINT_UST_LIBC_DL_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
+#define _TRACEPOINT_UST_LIBC_DL_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Copyright (C) 2011  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
+#include <lttng/tracepoint.h>
+
+TRACEPOINT_EVENT(ust_libc, dlopen,
+	TP_ARGS( const char*, filename, int, flag,void *, opaque_handle),
+	TP_FIELDS(
+		ctf_string(filename, filename)
+		ctf_integer(int, flag, flag)
+		ctf_integer_hex(void *, opaque_handle, opaque_handle)
+	)
+)
+
+TRACEPOINT_EVENT(ust_libc, dlsym,
+	TP_ARGS(void *, opaque_handle, const char*, symbol, void*, result),
+	TP_FIELDS(
+		ctf_integer_hex(void *, opaque_handle, opaque_handle)
+		ctf_string(symbol, symbol)
+		ctf_integer_hex(void *, result, result)
+	)
+)
+
+TRACEPOINT_EVENT(ust_libc, dlclose,
+	TP_ARGS(void *, opaque_handle , int, result),
+	TP_FIELDS(
+		ctf_integer_hex(void *, opaque_handle, opaque_handle)
+		ctf_integer(int, result, result)
+	)
+)
+#endif /* _TRACEPOINT_UST_LIBC_DL_H */
+
+#undef TRACEPOINT_INCLUDE
+#define TRACEPOINT_INCLUDE "./ust_libc_dl.h"
+
+/* This part must be outside ifdef protection */
+#include <lttng/tracepoint-event.h>
+
+#ifdef __cplusplus
+}
+#endif
-- 
1.7.9.5


--------------050706020308020106080800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------050706020308020106080800--
