From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 01/28] Add exclusion data to
	enable-command
Date: Thu,  7 Nov 2013 12:17:32 +0200
Message-ID: <1383819452-6431-1-git-send-email-jp_ikaheimonen__2433.82444973594$1383819508$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMep-0006Un-A5
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:17:48 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMej-00055S-S7 from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:17:41 -0800
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Add a new command id for enabling events with exclusions.
Add the exclusion data to the enable-event command structure.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/common/sessiond-comm/sessiond-comm.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 229b91e..ed98248 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -81,7 +81,7 @@ enum lttcomm_sessiond_command {
 	LTTNG_ENABLE_CONSUMER               = 20,
 	LTTNG_SET_CONSUMER_URI              = 21,
 	LTTNG_ENABLE_EVENT_WITH_FILTER      = 22,
-	/* Unused */
+	LTTNG_ENABLE_EVENT_WITH_EXCLUSION   = 23,
 	LTTNG_DATA_PENDING                  = 24,
 	LTTNG_SNAPSHOT_ADD_OUTPUT           = 25,
 	LTTNG_SNAPSHOT_DEL_OUTPUT           = 26,
@@ -230,6 +230,14 @@ struct lttcomm_session_msg {
 			struct lttng_event event;
 			/* Length of following bytecode for filter. */
 			uint32_t bytecode_len;
+			/* exclusion data */
+			uint32_t exclusion_count;
+			/*
+			 * After this structure, the following variable-length
+			 * items are transmitted:
+			 * - char exclusion_names[LTTNG_SYMBOL_NAME_LEN][exclusion_count]
+			 * - unsigned char filter_bytecode[bytecode_len]
+			 */
 		} LTTNG_PACKED enable;
 		/* Create channel */
 		struct {
-- 
1.8.1.2
