From: Zifei Tong <soariez@gmail.com>
Subject: [PATCH lttng-tools 2/2] Add missing error message for
	lttcomm_return_code
Date: Tue, 25 Feb 2014 23:41:29 +0800
Message-ID: <1393342889-61215-2-git-send-email-soariez__48769.6640812375$1393342988$gmane$org@gmail.com>
References: <1393342889-61215-1-git-send-email-soariez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [60.191.2.238] (helo=Zifeis-MacBook-Pro.local)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zifei@Zifeis-MacBook-Pro.local>) id 1WIK8m-0000tk-Vg
	for lttng-dev@lists.lttng.org; Tue, 25 Feb 2014 10:41:58 -0500
In-Reply-To: <1393342889-61215-1-git-send-email-soariez@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Zifei Tong <soariez@gmail.com>
---
 src/common/sessiond-comm/sessiond-comm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/common/sessiond-comm/sessiond-comm.c b/src/common/sessiond-comm/sessiond-comm.c
index 65952b2..05483ff 100644
--- a/src/common/sessiond-comm/sessiond-comm.c
+++ b/src/common/sessiond-comm/sessiond-comm.c
@@ -67,6 +67,7 @@ static const char *lttcomm_readable_code[] = {
 	[ LTTCOMM_ERR_INDEX(LTTCOMM_CONSUMERD_ERROR_METADATA) ] = "Error with metadata",
 	[ LTTCOMM_ERR_INDEX(LTTCOMM_CONSUMERD_FATAL) ] = "Fatal error",
 	[ LTTCOMM_ERR_INDEX(LTTCOMM_CONSUMERD_RELAYD_FAIL) ] = "Error on remote relayd",
+	[ LTTCOMM_ERR_INDEX(LTTCOMM_CONSUMERD_CHANNEL_FAIL) ] = "Channel creation failed",
 
 	/* Last element */
 	[ LTTCOMM_ERR_INDEX(LTTCOMM_NR) ] = "Unknown error code"
-- 
1.8.3.4 (Apple Git-47)
