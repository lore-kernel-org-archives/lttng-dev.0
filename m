From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 03/28] Add exclusion data to
	cmd_enable_event
Date: Thu,  7 Nov 2013 12:18:52 +0200
Message-ID: <1383819532-6512-1-git-send-email-jp_ikaheimonen__12099.5126119398$1383819605$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMgS-0006sw-Rw
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:19:29 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMgN-0005vP-Da from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:19:23 -0800
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

Add exclusion data to the prototype of cmd_enable_event().

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng-sessiond/cmd.c  | 8 +++++---
 src/bin/lttng-sessiond/cmd.h  | 4 +++-
 src/bin/lttng-sessiond/main.c | 4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 082e345..dca4859 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -1306,7 +1306,9 @@ error:
  */
 int cmd_enable_event(struct ltt_session *session, struct lttng_domain *domain,
 		char *channel_name, struct lttng_event *event,
-		struct lttng_filter_bytecode *filter, int wpipe)
+		struct lttng_filter_bytecode *filter,
+		struct lttng_event_exclusion *exclusion,
+		int wpipe)
 {
 	int ret, channel_created = 0;
 	struct lttng_channel *attr;
@@ -1448,7 +1450,7 @@ int cmd_enable_event(struct ltt_session *session, struct lttng_domain *domain,
 		tmp_dom.type = LTTNG_DOMAIN_UST;
 
 		ret = cmd_enable_event(session, &tmp_dom, DEFAULT_JUL_CHANNEL_NAME,
-				&uevent, NULL, wpipe);
+				&uevent, NULL, NULL, wpipe);
 		if (ret != LTTNG_OK && ret != LTTNG_ERR_UST_EVENT_ENABLED) {
 			goto error;
 		}
@@ -1660,7 +1662,7 @@ int cmd_enable_event_all(struct ltt_session *session,
 		tmp_dom.type = LTTNG_DOMAIN_UST;
 
 		ret = cmd_enable_event(session, &tmp_dom, DEFAULT_JUL_CHANNEL_NAME,
-				&uevent, NULL, wpipe);
+				&uevent, NULL, NULL, wpipe);
 		if (ret != LTTNG_OK && ret != LTTNG_ERR_UST_EVENT_ENABLED) {
 			goto error;
 		}
diff --git a/src/bin/lttng-sessiond/cmd.h b/src/bin/lttng-sessiond/cmd.h
index 6502a58..b5264f7 100644
--- a/src/bin/lttng-sessiond/cmd.h
+++ b/src/bin/lttng-sessiond/cmd.h
@@ -53,7 +53,9 @@ int cmd_set_filter(struct ltt_session *session, int domain,
 		struct lttng_filter_bytecode *bytecode);
 int cmd_enable_event(struct ltt_session *session, struct lttng_domain *domain,
 		char *channel_name, struct lttng_event *event,
-		struct lttng_filter_bytecode *filter, int wpipe);
+		struct lttng_filter_bytecode *filter,
+		struct lttng_event_exclusion *exclusion,
+		int wpipe);
 int cmd_enable_event_all(struct ltt_session *session,
 		struct lttng_domain *domain, char *channel_name, int event_type,
 		struct lttng_filter_bytecode *filter, int wpipe);
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 35007b7..71e1a9b 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -2933,7 +2933,7 @@ skip_domain:
 	{
 		ret = cmd_enable_event(cmd_ctx->session, &cmd_ctx->lsm->domain,
 				cmd_ctx->lsm->u.enable.channel_name,
-				&cmd_ctx->lsm->u.enable.event, NULL, kernel_poll_pipe[1]);
+				&cmd_ctx->lsm->u.enable.event, NULL, NULL, kernel_poll_pipe[1]);
 		break;
 	}
 	case LTTNG_ENABLE_ALL_EVENT:
@@ -3294,7 +3294,7 @@ skip_domain:
 
 		ret = cmd_enable_event(cmd_ctx->session, &cmd_ctx->lsm->domain,
 				cmd_ctx->lsm->u.enable.channel_name,
-				&cmd_ctx->lsm->u.enable.event, bytecode, kernel_poll_pipe[1]);
+				&cmd_ctx->lsm->u.enable.event, bytecode, NULL, kernel_poll_pipe[1]);
 		break;
 	}
 	case LTTNG_DATA_PENDING:
-- 
1.8.1.2
