From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 11/28] Add handling of
	LTTNG_ENABLE_EVENT_WITH_EXCLUSION
Date: Thu,  7 Nov 2013 12:21:35 +0200
Message-ID: <1383819703-6793-2-git-send-email-jp_ikaheimonen__13244.0690220848$1383819802$gmane$org@mentor.com>
References: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMir-0007Uc-W5
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:00 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMim-0006D1-HB from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:21:52 -0800
In-Reply-To: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
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

Add handling of the command LTTNG_ENABLE_EVENT_WITH_EXCLUSION.
The handling of the command is the same as command LTTNG_ENABLE_EVENT,
as the new command is just an extension.

If the command data shows that exclusions and/or filter data will
be following the command structure, read those from the incoming
socket, then forward the filter and exclusion data to
cmd_enable_event().

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng-sessiond/main.c | 69 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 71e1a9b..ab7d49b 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -2930,10 +2930,73 @@ skip_domain:
 		break;
 	}
 	case LTTNG_ENABLE_EVENT:
+	case LTTNG_ENABLE_EVENT_WITH_EXCLUSION:
 	{
-		ret = cmd_enable_event(cmd_ctx->session, &cmd_ctx->lsm->domain,
-				cmd_ctx->lsm->u.enable.channel_name,
-				&cmd_ctx->lsm->u.enable.event, NULL, NULL, kernel_poll_pipe[1]);
+		struct lttng_event_exclusion *exclusion = NULL;
+		struct lttng_filter_bytecode *bytecode = NULL;
+
+		if (cmd_ctx->lsm->cmd_type == LTTNG_ENABLE_EVENT ||
+				(cmd_ctx->lsm->u.enable.exclusion_count == 0 && cmd_ctx->lsm->u.enable.bytecode_len == 0)) {
+			ret = cmd_enable_event(cmd_ctx->session, &cmd_ctx->lsm->domain,
+					cmd_ctx->lsm->u.enable.channel_name,
+					&cmd_ctx->lsm->u.enable.event, NULL, NULL, kernel_poll_pipe[1]);
+		} else {
+			if (cmd_ctx->lsm->u.enable.exclusion_count != 0) {
+				exclusion = zmalloc(sizeof(struct lttng_event_exclusion) +
+						cmd_ctx->lsm->u.enable.exclusion_count * LTTNG_SYMBOL_NAME_LEN);
+				if (!exclusion) {
+					ret = LTTNG_ERR_EXCLUSION_NOMEM;
+					goto error;
+				}
+				DBG("Receiving var len data from client ...");
+				exclusion->count = cmd_ctx->lsm->u.enable.exclusion_count;
+				ret = lttcomm_recv_unix_sock(sock, exclusion->names,
+						cmd_ctx->lsm->u.enable.exclusion_count * LTTNG_SYMBOL_NAME_LEN);
+				if (ret <= 0) {
+					DBG("Nothing recv() from client var len data... continuing");
+					*sock_error = 1;
+					ret = LTTNG_ERR_EXCLUSION_INVAL;
+					goto error;
+				}
+			}
+			if (cmd_ctx->lsm->u.enable.bytecode_len != 0) {
+				bytecode = zmalloc(cmd_ctx->lsm->u.enable.bytecode_len);
+				if (!bytecode) {
+					if (!exclusion)
+						free(exclusion);
+					ret = LTTNG_ERR_FILTER_NOMEM;
+					goto error;
+				}
+				/* Receive var. len. data */
+				DBG("Receiving var len data from client ...");
+				ret = lttcomm_recv_unix_sock(sock, bytecode,
+						cmd_ctx->lsm->u.enable.bytecode_len);
+				if (ret <= 0) {
+					DBG("Nothing recv() from client car len data... continuing");
+					*sock_error = 1;
+					if (!exclusion)
+						free(exclusion);
+					ret = LTTNG_ERR_FILTER_INVAL;
+					goto error;
+				}
+
+				if (bytecode->len + sizeof(*bytecode)
+						!= cmd_ctx->lsm->u.enable.bytecode_len) {
+					free(bytecode);
+					if (!exclusion)
+						free(exclusion);
+					ret = LTTNG_ERR_FILTER_INVAL;
+					goto error;
+				}
+			}
+
+			ret = cmd_enable_event(cmd_ctx->session,
+					&cmd_ctx->lsm->domain,
+					cmd_ctx->lsm->u.enable.channel_name,
+					&cmd_ctx->lsm->u.enable.event, bytecode,
+					exclusion,
+					kernel_poll_pipe[1]);
+		}
 		break;
 	}
 	case LTTNG_ENABLE_ALL_EVENT:
-- 
1.8.1.2
