From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools v2 13/20] Integrate serialized
 communication for lttng_event_context
Date: Wed,  1 May 2019 15:34:37 -0400
Message-ID: <20190501193444.17403-14-ylamarre__16832.2386381746$1556739483$gmane$org@efficios.com>
References: <20190501193444.17403-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44vTB747nkz1Kbf
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2019 15:34:55 -0400 (EDT)
In-Reply-To: <20190501193444.17403-1-ylamarre@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

lttng-ctl and lttng-sessiond use serialized communication for
messages using lttng_event_context.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
Fixed coding style issue by adding an empty line between variable declaration
and code.

 include/lttng/event-internal.h           |  4 ++++
 src/bin/lttng-sessiond/client.c          | 17 ++++++++++-------
 src/common/sessiond-comm/sessiond-comm.h |  2 +-
 src/lib/lttng-ctl/lttng-ctl.c            | 12 +-----------
 4 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/include/lttng/event-internal.h b/include/lttng/event-internal.h
index 25a88448..09b4d232 100644
--- a/include/lttng/event-internal.h
+++ b/include/lttng/event-internal.h
@@ -57,4 +57,8 @@ struct lttng_event_extended {
 LTTNG_HIDDEN
 struct lttng_event *lttng_event_copy(const struct lttng_event *event);
 
+int lttng_event_context_serialize(struct lttng_event_context_serialized *dst, const struct lttng_event_context *src);
+int lttng_event_context_deserialize(struct lttng_event_context *dst, const struct lttng_event_context_serialized *src);
+int lttng_event_perf_counter_ctx_serialize(struct lttng_event_perf_counter_ctx_serialized *dst, const struct lttng_event_perf_counter_ctx *src);
+int lttng_event_perf_counter_ctx_deserialize(struct lttng_event_perf_counter_ctx *dst, const struct lttng_event_perf_counter_ctx_serialized *src);
 #endif /* LTTNG_EVENT_INTERNAL_H */
diff --git a/src/bin/lttng-sessiond/client.c b/src/bin/lttng-sessiond/client.c
index 614f19c7..45035418 100644
--- a/src/bin/lttng-sessiond/client.c
+++ b/src/bin/lttng-sessiond/client.c
@@ -1071,6 +1071,9 @@ skip_domain:
 	switch (cmd_ctx->lsm->cmd_type) {
 	case LTTNG_ADD_CONTEXT:
 	{
+		struct lttng_event_context evt_ctx;
+
+		lttng_event_context_deserialize(&evt_ctx, &cmd_ctx->lsm->u.context.ctx);
 		/*
 		 * An LTTNG_ADD_CONTEXT command might have a supplementary
 		 * payload if the context being added is an application context.
@@ -1097,7 +1100,7 @@ skip_domain:
 				ret = -LTTNG_ERR_NOMEM;
 				goto error;
 			}
-			cmd_ctx->lsm->u.context.ctx.u.app_ctx.provider_name =
+			evt_ctx.u.app_ctx.provider_name =
 					provider_name;
 
 			context_name = zmalloc(context_name_len + 1);
@@ -1105,7 +1108,7 @@ skip_domain:
 				ret = -LTTNG_ERR_NOMEM;
 				goto error_add_context;
 			}
-			cmd_ctx->lsm->u.context.ctx.u.app_ctx.ctx_name =
+			evt_ctx.u.app_ctx.ctx_name =
 					context_name;
 
 			ret = lttcomm_recv_unix_sock(sock, provider_name,
@@ -1128,14 +1131,14 @@ skip_domain:
 		ret = cmd_add_context(cmd_ctx->session,
 				cmd_ctx->lsm->domain.type,
 				cmd_ctx->lsm->u.context.channel_name,
-				&cmd_ctx->lsm->u.context.ctx,
+				&evt_ctx,
 				kernel_poll_pipe[1]);
 
-		cmd_ctx->lsm->u.context.ctx.u.app_ctx.provider_name = NULL;
-		cmd_ctx->lsm->u.context.ctx.u.app_ctx.ctx_name = NULL;
+		evt_ctx.u.app_ctx.provider_name = NULL;
+		evt_ctx.u.app_ctx.ctx_name = NULL;
 error_add_context:
-		free(cmd_ctx->lsm->u.context.ctx.u.app_ctx.provider_name);
-		free(cmd_ctx->lsm->u.context.ctx.u.app_ctx.ctx_name);
+		free(evt_ctx.u.app_ctx.provider_name);
+		free(evt_ctx.u.app_ctx.ctx_name);
 		if (ret < 0) {
 			goto error;
 		}
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 3455a4ea..955c35a8 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -410,7 +410,7 @@ struct lttcomm_session_msg {
 		/* Context */
 		struct {
 			char channel_name[LTTNG_SYMBOL_NAME_LEN];
-			struct lttng_event_context ctx LTTNG_PACKED;
+			struct lttng_event_context_serialized ctx;
 			uint32_t provider_name_len;
 			uint32_t context_name_len;
 		} LTTNG_PACKED context;
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index 15f66034..f8ea6ca7 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -821,17 +821,7 @@ int lttng_add_context(struct lttng_handle *handle,
 		memcpy(buf, provider_name, provider_len);
 		memcpy(buf + provider_len, ctx_name, ctx_len);
 	}
-	memcpy(&lsm.u.context.ctx, ctx, sizeof(struct lttng_event_context));
-
-	if (ctx->ctx == LTTNG_EVENT_CONTEXT_APP_CONTEXT) {
-		/*
-		 * Don't leak application addresses to the sessiond.
-		 * This is only necessary when ctx is for an app ctx otherwise
-		 * the values inside the union (type & config) are overwritten.
-		 */
-		lsm.u.context.ctx.u.app_ctx.provider_name = NULL;
-		lsm.u.context.ctx.u.app_ctx.ctx_name = NULL;
-	}
+	lttng_event_context_serialize(&lsm.u.context.ctx, ctx);
 
 	ret = lttng_ctl_ask_sessiond_varlen_no_cmd_header(&lsm, buf, len, NULL);
 end:
-- 
2.11.0
