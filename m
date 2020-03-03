From: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
Subject: [PATCH v4 lttng-ust 2/2] Introduce vtracelog
Date: Tue,  3 Mar 2020 18:10:31 -0500
Message-ID: <20200303231031.23708-2-maxime.roussinbelanger@gmail.com>
References: <20200303231031.23708-1-maxime.roussinbelanger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by lists.lttng.org (Postfix) with ESMTPS id 48XCRK6L81z13lx
 for <lttng-dev@lists.lttng.org>; Tue,  3 Mar 2020 18:10:37 -0500 (EST)
Received: by mail-qk1-x743.google.com with SMTP id m2so5240089qka.7
 for <lttng-dev@lists.lttng.org>; Tue, 03 Mar 2020 15:10:37 -0800 (PST)
In-Reply-To: <20200303231031.23708-1-maxime.roussinbelanger@gmail.com>
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
Changes in v4:
	* Use a static inline function to force compiler to inline 
	the vtracelog function call.
	* Fix styling issue.

doc/examples/demo-tracelog/Makefile | 14 ++++++++++++--
 doc/man/tracelog.3.txt              |  9 +++++----
 include/lttng/tracelog.h            |  7 +++++++
 liblttng-ust/tracelog.c             | 27 +++++++++++++++++++++------
 4 files changed, 45 insertions(+), 12 deletions(-)

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
index 65fc87ed..f6a297f4 100644
--- a/liblttng-ust/tracelog.c
+++ b/liblttng-ust/tracelog.c
@@ -30,24 +30,39 @@
 #include "lttng-ust-tracelog-provider.h"
 
 #define TRACELOG_CB(level) \
-	void _lttng_ust_tracelog_##level(const char *file, \
+	static inline __attribute__((always_inline)) \
+	void __lttng_ust_vtracelog_##level(const char *file, \
 			int line, const char *func, \
-			const char *fmt, ...) \
+			const char *fmt, va_list ap) \
 	{ \
-		va_list ap; \
 		char *msg; \
-		int len; \
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
+	void _lttng_ust_vtracelog_##level(const char *file, \
+			int line, const char *func, \
+			const char *fmt, va_list ap) \
+	{ \
+		__lttng_ust_vtracelog_##level(file, line, func, fmt, ap); \
+	} \
+	\
+	void _lttng_ust_tracelog_##level(const char *file, \
+			int line, const char *func, \
+			const char *fmt, ...) \
+	{ \
+		va_list ap; \
+		va_start(ap, fmt); \
+		__lttng_ust_vtracelog_##level(file, line, func, fmt, ap); \
 		va_end(ap); \
 	}
 
-- 
2.20.1
