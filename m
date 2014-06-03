From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: [PATCH lttng-ust RFC] tracef: move _lttng_ust_tracef()
	definition to tracef.h
Date: Tue,  3 Jun 2014 10:03:55 +0200
Message-ID: <1401782635-32638-1-git-send-email-gerlando.falauto__8535.45206268809$1401782686$gmane$org@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=02319cc1ae=gerlando.falauto@keymile.com>)
 id 1WrjhT-0005gl-ME
 for lttng-dev@lists.lttng.org; Tue, 03 Jun 2014 04:04:06 -0400
Received: from frodo.de.keymile.net ([10.9.1.54]:58442
 helo=mailrelay.de.keymile.net)
 by mail-de.keymile.com with esmtp (Exim 4.76)
 (envelope-from <gerlando.falauto@keymile.com>) id 1WrjhM-00063U-1Y
 for lttng-dev@lists.lttng.org; Tue, 03 Jun 2014 10:03:56 +0200
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Gerlando Falauto <gerlando.falauto@keymile.com>
List-Id: lttng-dev@lists.lttng.org

With the current implementation, in order to use tracef() within your
application, you have to link it against liblttng-ust, because
_lttng_ust_tracef() is part of it.

So move _lttng_ust_tracef() to the header file in order to drop this
static awareness, allowing the application to be compiled with
-DTRACEPOINT_DEFINE and -DTRACEPOINT_PROBE_DYNAMIC_LINKAGE
without any static dependency to liblttng-ust.so
(you will need to LD_PRELOAD it in order for tracing to work though).

Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
---
 include/lttng/tracef.h | 18 ++++++++++++++++--
 liblttng-ust/tracef.c  | 16 ----------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/lttng/tracef.h b/include/lttng/tracef.h
index 7e8b59e..612c56a 100644
--- a/include/lttng/tracef.h
+++ b/include/lttng/tracef.h
@@ -29,8 +29,22 @@
 extern "C" {
 #endif
 
-extern
-void _lttng_ust_tracef(const char *fmt, ...);
+static inline void _lttng_ust_tracef(const char *fmt, ...)
+{
+	va_list ap;
+	char *msg;
+	int len;
+
+	va_start(ap, fmt);
+	len = vasprintf(&msg, fmt, ap);
+	/* len does not include the final \0 */
+	if (len < 0)
+		goto end;
+	__tracepoint_cb_lttng_ust_tracef___event(msg, len);
+	free(msg);
+end:
+	va_end(ap);
+}
 
 #define tracef(fmt, ...)						\
 	do {								\
diff --git a/liblttng-ust/tracef.c b/liblttng-ust/tracef.c
index 9ef063c..0c7ab17 100644
--- a/liblttng-ust/tracef.c
+++ b/liblttng-ust/tracef.c
@@ -28,19 +28,3 @@
 #define TRACEPOINT_DEFINE
 #include "lttng-ust-tracef-provider.h"
 
-void _lttng_ust_tracef(const char *fmt, ...)
-{
-	va_list ap;
-	char *msg;
-	int len;
-
-	va_start(ap, fmt);
-	len = vasprintf(&msg, fmt, ap);
-	/* len does not include the final \0 */
-	if (len < 0)
-		goto end;
-	__tracepoint_cb_lttng_ust_tracef___event(msg, len);
-	free(msg);
-end:
-	va_end(ap);
-}
-- 
1.8.0.1
