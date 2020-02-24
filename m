From: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
Subject: [PATCH v3 lttng-ust 2/2] Introduce vtracelog
Date: Mon, 24 Feb 2020 12:34:55 -0500
Message-ID: <20200224173455.15900-2-maxime.roussinbelanger@gmail.com>
References: <20200224173455.15900-1-maxime.roussinbelanger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by lists.lttng.org (Postfix) with ESMTPS id 48R8PR6LtHz13Jc
 for <lttng-dev@lists.lttng.org>; Mon, 24 Feb 2020 12:36:27 -0500 (EST)
Received: by mail-qk1-x744.google.com with SMTP id b7so9402820qkl.7
 for <lttng-dev@lists.lttng.org>; Mon, 24 Feb 2020 09:36:27 -0800 (PST)
In-Reply-To: <20200224173455.15900-1-maxime.roussinbelanger@gmail.com>
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

vtracelog works the same as vtracef, but takes a log level
as a parameter and has the same limitations.

Signed-off-by: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
---
Changes in v3:
	* Add this patch

doc/examples/demo-tracelog/Makefile         | 14 +++++-
 doc/examples/demo-tracelog/demo-vtracelog.c | 53 +++++++++++++++++++++
 doc/man/tracelog.3.txt                      |  9 ++--
 include/lttng/tracelog.h                    |  7 +++
 liblttng-ust/tracelog.c                     | 24 ++++++----
 5 files changed, 93 insertions(+), 14 deletions(-)
 create mode 100644 doc/examples/demo-tracelog/demo-vtracelog.c

diff --git a/doc/examples/demo-tracelog/Makefile b/doc/examples/demo-tracelog/Makefile
index 0d9a20aa..623979d3 100644
--- a/doc/examples/demo-tracelog/Makefile
+++ b/doc/examples/demo-tracelog/Makefile
@@ -20,18 +20,28 @@ LIBS = -ldl -llttng-ust	# On Linux
 LOCAL_CPPFLAGS += -I.
 AM_V_P := :
 
-all: demo-tracelog
+all: demo-tracelog demo-vtracelog
 
 demo-tracelog.o: demo-tracelog.c
 	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
 		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
 		$(CFLAGS) -c -o $@ $<
 
 demo-tracelog: demo-tracelog.o
 	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
 		$(CC) $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
 		-o $@ $< $(LIBS)
 
+demo-vtracelog.o: demo-vtracelog.c
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
+		$(CFLAGS) -c -o $@ $<
+
+demo-vtracelog: demo-vtracelog.o
+	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
+		$(CC) $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
+		-o $@ $< $(LIBS)
+
 .PHONY: clean
 clean:
-	rm -f *.o *.a demo-tracelog
+	rm -f *.o *.a demo-tracelog demo-vtracelog
diff --git a/doc/examples/demo-tracelog/demo-vtracelog.c b/doc/examples/demo-tracelog/demo-vtracelog.c
new file mode 100644
index 00000000..5e7f3884
--- /dev/null
+++ b/doc/examples/demo-tracelog/demo-vtracelog.c
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2020  Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
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
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include <lttng/tracelog.h>
+
+void print_debug(const char* msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+
+	vtracelog(TRACE_DEBUG, msg, ap);
+
+	va_end(ap);
+}
+
+int main(int argc, char **argv)
+{
+	int i;
+	int delay = 0;
+
+	if (argc == 2)
+		delay = atoi(argv[1]);
+
+	fprintf(stderr, "Demo program starting.\n");
+
+	sleep(delay);
+
+	fprintf(stderr, "Tracing... ");
+	for (i = 0; i < 5; i++) {
+		print_debug("Error condition %d", i);
+	}
+	fprintf(stderr, " done.\n");
+	return 0;
+}
diff --git a/doc/man/tracelog.3.txt b/doc/man/tracelog.3.txt
index 1281ce7c..5cf1953a 100644
--- a/doc/man/tracelog.3.txt
+++ b/doc/man/tracelog.3.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 
 [verse]
 #define *tracelog*('level', 'fmt', ...)
+#define *vtracelog*('level', 'fmt', 'va_list' ap)
 
 Link with `-llttng-ust`.
 
@@ -34,9 +35,9 @@ The available values for the 'level' parameter are:
 
 include::log-levels.txt[]
 
-To use `tracelog()`, include `<lttng/tracelog.h>` where you need it, and
-link your application with `liblttng-ust`. See the <<example,EXAMPLE>>
-section below for a complete usage example.
+To use `tracelog()` or `vtracelog()`, include `<lttng/tracelog.h>` where you
+need it, and link your application with `liblttng-ust`.
+See the <<example,EXAMPLE>> section below for a complete usage example.
 
 Once your application is instrumented with `tracelog()` calls and
 ready to run, use man:lttng-enable-event(1) to enable the
@@ -67,7 +68,7 @@ If you do not need to attach a specific log level to a `tracelog()`
 call, use man:tracef(3) instead.
 
 See also the <<limitations,LIMITATIONS>> section below for important
-limitations to consider when using `tracelog()`.
+limitations to consider when using `tracelog()` or `vtracelog()`.
 
 
 [[example]]
diff --git a/include/lttng/tracelog.h b/include/lttng/tracelog.h
index 4309d12e..7aa86809 100644
--- a/include/lttng/tracelog.h
+++ b/include/lttng/tracelog.h
@@ -59,6 +59,13 @@ TP_TRACELOG_CB_TEMPLATE(TRACE_DEBUG);
 				fmt, ## __VA_ARGS__); \
 	} while (0)
 
+#define vtracelog(level, fmt, ap)					\
+	do {								\
+		if (caa_unlikely(__tracepoint_lttng_ust_tracelog___##level.state)) \
+			_lttng_ust_tracelog_##level(__FILE__, __LINE__, __func__, \
+				fmt, ap); \
+	} while (0)
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/liblttng-ust/tracelog.c b/liblttng-ust/tracelog.c
index 65fc87ed..17546605 100644
--- a/liblttng-ust/tracelog.c
+++ b/liblttng-ust/tracelog.c
@@ -29,27 +29,35 @@
 #define TRACEPOINT_DEFINE
 #include "lttng-ust-tracelog-provider.h"
 
+
 #define TRACELOG_CB(level) \
-	void _lttng_ust_tracelog_##level(const char *file, \
+	void _lttng_ust_vtracelog_##level(const char *file, \
 			int line, const char *func, \
-			const char *fmt, ...) \
+			const char *fmt, va_list ap) \
 	{ \
-		va_list ap; \
-		char *msg; \
-		int len; \
+ 		char *msg; \
+		const int len = vasprintf(&msg, fmt, ap); \
 		\
-		va_start(ap, fmt); \
-		len = vasprintf(&msg, fmt, ap); \
 		/* len does not include the final \0 */ \
 		if (len < 0) \
 			goto end; \
 		__tracepoint_cb_lttng_ust_tracelog___##level(file, \
 			line, func, msg, len, \
 			LTTNG_UST_CALLER_IP()); \
 		free(msg); \
 	end: \
+		return; \
+	} \
+	\
+	void _lttng_ust_tracelog_##level(const char *file, \
+			int line, const char *func, \
+			const char *fmt, ...) \
+	{ \
+		va_list ap; \
+		va_start(ap, fmt); \
+		_lttng_ust_vtracelog_##level(file, line, func, fmt, ap); \
 		va_end(ap); \
-	}
+	} \
 
 TRACELOG_CB(TRACE_EMERG)
 TRACELOG_CB(TRACE_ALERT)
-- 
2.20.1
