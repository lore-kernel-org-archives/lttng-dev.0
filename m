From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 26/28] Detect and report exclusion
	option errors
Date: Thu,  7 Nov 2013 12:22:05 +0200
Message-ID: <1383819727-6843-7-git-send-email-jp_ikaheimonen__45015.9069071107$1383820132$gmane$org@mentor.com>
References: <1383819727-6843-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjM-0007ex-Gw
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:29 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMjH-0006Fu-2X from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:23 -0800
In-Reply-To: <1383819727-6843-1-git-send-email-jp_ikaheimonen@mentor.com>
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

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng/commands/enable_events.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index 90ecdda..7009df7 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -465,6 +465,12 @@ static int enable_events(char *session_name)
 		goto error;
 	}
 
+	if (opt_kernel && opt_exclude) {
+		ERR("Event name exclusions are not yet implemented for kernel events");
+		ret = CMD_ERROR;
+		goto error;
+	}
+
 	channel_name = opt_channel_name;
 
 	handle = lttng_create_handle(session_name, &dom);
@@ -682,6 +688,11 @@ static int enable_events(char *session_name)
 			}
 
 			if (opt_exclude) {
+				if (opt_event_type != LTTNG_EVENT_ALL && opt_event_type != LTTNG_EVENT_TRACEPOINT) {
+					ERR("Exclusion option can only be used with tracepoint events");
+					ret = CMD_ERROR;
+					goto error;
+				}
 				/* Free previously allocated items */
 				if (exclusion_list != NULL) {
 					while (exclusion_count--) {
-- 
1.8.1.2
