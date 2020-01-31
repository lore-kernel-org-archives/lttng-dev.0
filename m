From: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
Subject: [PATCH] Introduce vtracef
Date: Fri, 31 Jan 2020 16:55:01 -0500
Message-ID: <20200131215501.19536-1-maxime.roussinbelanger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by lists.lttng.org (Postfix) with ESMTPS id 488WH00CHMz24HZ
 for <lttng-dev@lists.lttng.org>; Fri, 31 Jan 2020 16:55:07 -0500 (EST)
Received: by mail-qv1-xf43.google.com with SMTP id s7so3992845qvn.8
 for <lttng-dev@lists.lttng.org>; Fri, 31 Jan 2020 13:55:07 -0800 (PST)
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
Cc: champagne.guillaume.c@gmail.com
List-Id: lttng-dev@lists.lttng.org

vtracef accepts a va_list argument to simplify tracing
functions which use a va_list

Here's an example from wpa_supplicant that I wanted to
trace:

void wpa_debug(int level, const char* fmt, ...) {

    va_list ap;
    va_start(ap, fmt);

    ...
    // The call I want to easily trace with vtracef
    vprintf(fmt, ap);

    ...
    va_end(ap);
}

wpa_debug is used a fair amount and it would be annoying to
replace all the wpa_debug calls with tracef.

With vtracef, it simplifies the find and replace effort by
only changing it at one place.

Signed-off-by: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
---
 include/lttng/tracef.h | 10 ++++++++++
 liblttng-ust/tracef.c  | 18 +++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/lttng/tracef.h b/include/lttng/tracef.h
index 0c59c9ae..e3a7587d 100644
--- a/include/lttng/tracef.h
+++ b/include/lttng/tracef.h
@@ -32,13 +32,23 @@ extern "C" {
 extern
 void _lttng_ust_tracef(const char *fmt, ...);
 
+extern
+void _lttng_ust_vtracef(const char *fmt, va_list ap);
+
 #define tracef(fmt, ...)						\
 	do {								\
 		LTTNG_STAP_PROBEV(tracepoint_lttng_ust_tracef, event, ## __VA_ARGS__); \
 		if (caa_unlikely(__tracepoint_lttng_ust_tracef___event.state)) \
 			_lttng_ust_tracef(fmt, ## __VA_ARGS__);		\
 	} while (0)
 
+#ifndef LTTNG_UST_HAVE_SDT_INTEGRATION
+#define vtracef(fmt, ap)						\
+	do {								\
+		if (caa_unlikely(__tracepoint_lttng_ust_tracef___event.state)) \
+			_lttng_ust_vtracef(fmt, ap);		\
+	} while (0)
+#endif
 #ifdef __cplusplus
 }
 #endif
diff --git a/liblttng-ust/tracef.c b/liblttng-ust/tracef.c
index ea98e43e..2a809eed 100644
--- a/liblttng-ust/tracef.c
+++ b/liblttng-ust/tracef.c
@@ -29,20 +29,24 @@
 #define TRACEPOINT_DEFINE
 #include "lttng-ust-tracef-provider.h"
 
-void _lttng_ust_tracef(const char *fmt, ...)
+void _lttng_ust_vtracef(const char *fmt, va_list ap)
 {
-	va_list ap;
 	char *msg;
-	int len;
-
-	va_start(ap, fmt);
-	len = vasprintf(&msg, fmt, ap);
+	const int len = vasprintf(&msg, fmt, ap);
 	/* len does not include the final \0 */
 	if (len < 0)
-		goto end;
+		return;
 	__tracepoint_cb_lttng_ust_tracef___event(msg, len,
 		LTTNG_UST_CALLER_IP());
 	free(msg);
+}
+
+void _lttng_ust_tracef(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	_lttng_ust_vtracef(fmt, ap);
 end:
 	va_end(ap);
 }
-- 
2.20.1
