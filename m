From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Add missing URCU_TLS access to
	error_log_time
Date: Fri,  7 Nov 2014 12:17:02 -0500
Message-ID: <1415380622-22533-1-git-send-email-christian.babeux__20706.7213058055$1415380692$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <christian.babeux@0x80.ca>) id 1XmnAA-0004yt-75
 for lttng-dev@lists.lttng.org; Fri, 07 Nov 2014 12:17:31 -0500
Received: by mail-qa0-f45.google.com with SMTP id dc16so2597042qab.18
 for <lttng-dev@lists.lttng.org>; Fri, 07 Nov 2014 09:17:24 -0800 (PST)
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

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/common/error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/error.c b/src/common/error.c
index 55d56e6..577070e 100644
--- a/src/common/error.c
+++ b/src/common/error.c
@@ -49,7 +49,7 @@ const char *log_add_time(void)
 	}
 
 	/* Format time in the TLS variable. */
-	ret = snprintf(URCU_TLS(error_log_time).str, sizeof(error_log_time.str),
+	ret = snprintf(URCU_TLS(error_log_time).str, sizeof(URCU_TLS(error_log_time).str),
 			"%02d:%02d:%02d.%06ld",
 			tm.tm_hour, tm.tm_min, tm.tm_sec, tp.tv_nsec);
 	if (ret < 0) {
-- 
2.1.1
