From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 03/24] Fix : Wrap variable with
	URCU_TLS for sizeof
Date: Mon, 27 Oct 2014 20:49:28 +0000
Message-ID: <1414442926-14381-4-git-send-email-c.briere__14928.3652114265$1414443199$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]
 helo=usmailout3.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEP-0007ni-7g
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:40 -0400
Received: from uscpsbgex4.samsung.com
 (u125.gpu85.samsung.co.kr [203.254.195.125]) by usmailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE4004KZF6H5N30@usmailout3.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:29 -0400 (EDT)
In-reply-to: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Content-language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "jeremie.galarneau@efficios.com" <jeremie.galarneau@efficios.com>, "dgoulet@efficios.com" <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "karim.yaghmour@opersys.com" <karim.yaghmour@opersys.com>
List-Id: lttng-dev@lists.lttng.org

From: Charles Briere <c.briere@samsung.com>

Signed-off-by: Charles Briere <c.briere@samsung.com>
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
2.1.2
