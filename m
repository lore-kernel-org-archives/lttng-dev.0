From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 12/28] Collate handling of
	LTTNG_ENABLE_EVENT_WITH_FILTER
Date: Thu,  7 Nov 2013 12:21:36 +0200
Message-ID: <1383819703-6793-3-git-send-email-jp_ikaheimonen__18855.8365604424$1383819826$gmane$org@mentor.com>
References: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMit-0007Uv-A1
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:00 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMin-0006D9-Rs from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:21:53 -0800
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

Because the handling of LTTNG_ENABLE_EVENT_WITH_EXCLUSION can
now handle commands of type LTTNG_ENABLE_EVENT_WITH_FILTER,
there's no reason to have the same code appear twice.

Remove the code for LTTNG_ENABLE_EVENT_WITH_FILTER and use the
same code as is used for LTTNG_ENABLE_EVENT_WITH_EXCLUSION.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng-sessiond/main.c | 41 +----------------------------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index ab7d49b..7194fd5 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -2931,6 +2931,7 @@ skip_domain:
 	}
 	case LTTNG_ENABLE_EVENT:
 	case LTTNG_ENABLE_EVENT_WITH_EXCLUSION:
+	case LTTNG_ENABLE_EVENT_WITH_FILTER:
 	{
 		struct lttng_event_exclusion *exclusion = NULL;
 		struct lttng_filter_bytecode *bytecode = NULL;
@@ -3320,46 +3321,6 @@ skip_domain:
 				cmd_ctx->lsm->u.reg.path, cdata);
 		break;
 	}
-	case LTTNG_ENABLE_EVENT_WITH_FILTER:
-	{
-		struct lttng_filter_bytecode *bytecode;
-
-		if (cmd_ctx->lsm->u.enable.bytecode_len > LTTNG_FILTER_MAX_LEN) {
-			ret = LTTNG_ERR_FILTER_INVAL;
-			goto error;
-		}
-		if (cmd_ctx->lsm->u.enable.bytecode_len == 0) {
-			ret = LTTNG_ERR_FILTER_INVAL;
-			goto error;
-		}
-		bytecode = zmalloc(cmd_ctx->lsm->u.enable.bytecode_len);
-		if (!bytecode) {
-			ret = LTTNG_ERR_FILTER_NOMEM;
-			goto error;
-		}
-		/* Receive var. len. data */
-		DBG("Receiving var len data from client ...");
-		ret = lttcomm_recv_unix_sock(sock, bytecode,
-				cmd_ctx->lsm->u.enable.bytecode_len);
-		if (ret <= 0) {
-			DBG("Nothing recv() from client var len data... continuing");
-			*sock_error = 1;
-			ret = LTTNG_ERR_FILTER_INVAL;
-			goto error;
-		}
-
-		if (bytecode->len + sizeof(*bytecode)
-				!= cmd_ctx->lsm->u.enable.bytecode_len) {
-			free(bytecode);
-			ret = LTTNG_ERR_FILTER_INVAL;
-			goto error;
-		}
-
-		ret = cmd_enable_event(cmd_ctx->session, &cmd_ctx->lsm->domain,
-				cmd_ctx->lsm->u.enable.channel_name,
-				&cmd_ctx->lsm->u.enable.event, bytecode, NULL, kernel_poll_pipe[1]);
-		break;
-	}
 	case LTTNG_DATA_PENDING:
 	{
 		ret = cmd_data_pending(cmd_ctx->session);
-- 
1.8.1.2
