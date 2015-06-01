From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] urcu: fix deprecation warning with new glibc
Date: Mon,  1 Jun 2015 15:16:30 +0200
Message-ID: <1433164590-9078-1-git-send-email-mkl__1629.30156006968$1433166952$gmane$org@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mkl@pengutronix.de>) id 1YzPa3-0006C3-U2
 for lttng-dev@lists.lttng.org; Mon, 01 Jun 2015 09:16:50 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: lttng-dev@lists.lttng.org

This patch fixes the following warning:

/usr/include/features.h:148:3: warning: #warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE" [-Wcpp]
 # warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE"

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 urcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/urcu.c b/urcu.c
index 1429f6dfbbd3..6f5b1e01ea04 100644
--- a/urcu.c
+++ b/urcu.c
@@ -26,6 +26,7 @@
 #define _BSD_SOURCE
 #define _GNU_SOURCE
 #define _LGPL_SOURCE
+#define _DEFAULT_SOURCE
 #include <stdio.h>
 #include <pthread.h>
 #include <signal.h>
-- 
2.1.4
