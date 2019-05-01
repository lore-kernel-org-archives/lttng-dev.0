From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools v2 16/20] Integrate serialized
 communication for lttng_event
Date: Wed,  1 May 2019 15:34:40 -0400
Message-ID: <20190501193444.17403-17-ylamarre__12866.0969830648$1556739644$gmane$org@efficios.com>
References: <20190501193444.17403-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44vTB82x3tz1Kc1
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2019 15:34:56 -0400 (EDT)
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
messages using lttng_event.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
1) Reworded commit title
2) Removed empty line prior variable declaration
3) Changed the awkward nested conditions by switch statements

 src/bin/lttng-sessiond/client.c          | 38 ++++++++++++++++++++++++++++----
 src/common/sessiond-comm/sessiond-comm.h |  4 ++--
 src/lib/lttng-ctl/lttng-ctl.c            | 21 ++++++++++++++----
 3 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/src/bin/lttng-sessiond/client.c b/src/bin/lttng-sessiond/client.c
index 45035418..3fb69cd9 100644
--- a/src/bin/lttng-sessiond/client.c
+++ b/src/bin/lttng-sessiond/client.c
@@ -1152,7 +1152,7 @@ error_add_context:
 	}
 	case LTTNG_DISABLE_EVENT:
 	{
-
+		struct lttng_event event;
 		/*
 		 * FIXME: handle filter; for now we just receive the filter's
 		 * bytecode along with the filter expression which are sent by
@@ -1179,10 +1179,24 @@ error_add_context:
 				count -= (size_t) ret;
 			}
 		}
-		/* FIXME: passing packed structure to non-packed pointer */
+		lttng_event_no_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
+		if (cmd_ctx->lsm->domain.type == LTTNG_DOMAIN_KERNEL) {
+			switch (event.type) {
+			case LTTNG_EVENT_PROBE:
+			case LTTNG_EVENT_FUNCTION:
+			case LTTNG_EVENT_USERSPACE_PROBE:
+				lttng_event_probe_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
+				break;
+			case LTTNG_EVENT_FUNCTION_ENTRY:
+				lttng_event_function_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
+				break;
+			default:
+				break;
+			}
+		}
 		ret = cmd_disable_event(cmd_ctx->session, cmd_ctx->lsm->domain.type,
 				cmd_ctx->lsm->u.disable.channel_name,
-				&cmd_ctx->lsm->u.disable.event);
+				&event);
 		break;
 	}
 	case LTTNG_ENABLE_CHANNEL:
@@ -1214,6 +1228,7 @@ error_add_context:
 	}
 	case LTTNG_ENABLE_EVENT:
 	{
+		struct lttng_event event;
 		struct lttng_event *ev = NULL;
 		struct lttng_event_exclusion *exclusion = NULL;
 		struct lttng_filter_bytecode *bytecode = NULL;
@@ -1316,7 +1331,22 @@ error_add_context:
 			}
 		}
 
-		ev = lttng_event_copy(&cmd_ctx->lsm->u.enable.event);
+		lttng_event_no_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
+		if (cmd_ctx->lsm->domain.type == LTTNG_DOMAIN_KERNEL) {
+			switch (event.type) {
+			case LTTNG_EVENT_PROBE:
+			case LTTNG_EVENT_FUNCTION:
+			case LTTNG_EVENT_USERSPACE_PROBE:
+				lttng_event_probe_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
+				break;
+			case LTTNG_EVENT_FUNCTION_ENTRY:
+				lttng_event_function_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
+				break;
+			default:
+				break;
+			}
+		}
+		ev = lttng_event_copy(&event);
 		if (!ev) {
 			DBG("Failed to copy event: %s",
 					cmd_ctx->lsm->u.enable.event.name);
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 955c35a8..21535eeb 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -370,7 +370,7 @@ struct lttcomm_session_msg {
 		/* Event data */
 		struct {
 			char channel_name[LTTNG_SYMBOL_NAME_LEN];
-			struct lttng_event event LTTNG_PACKED;
+			struct lttng_event_serialized event;
 			/* Length of following filter expression. */
 			uint32_t expression_len;
 			/* Length of following bytecode for filter. */
@@ -389,7 +389,7 @@ struct lttcomm_session_msg {
 		} LTTNG_PACKED enable;
 		struct {
 			char channel_name[LTTNG_SYMBOL_NAME_LEN];
-			struct lttng_event event LTTNG_PACKED;
+			struct lttng_event_serialized event;
 			/* Length of following filter expression. */
 			uint32_t expression_len;
 			/* Length of following bytecode for filter. */
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index f8ea6ca7..d4696954 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -1114,8 +1114,22 @@ int lttng_enable_event_with_exclusions(struct lttng_handle *handle,
 	}
 
 	lttng_ctl_copy_lttng_domain(&lsm.domain, &handle->domain);
-	/* FIXME: copying non-packed struct to packed struct. */
-	memcpy(&lsm.u.enable.event, ev, sizeof(lsm.u.enable.event));
+
+	lttng_event_no_attr_serialize(&lsm.u.enable.event, ev);
+	if (handle->domain.type == LTTNG_DOMAIN_KERNEL) {
+		switch (ev->type) {
+		case LTTNG_EVENT_PROBE:
+		case LTTNG_EVENT_FUNCTION:
+		case LTTNG_EVENT_USERSPACE_PROBE:
+			lttng_event_probe_attr_serialize(&lsm.u.enable.event, ev);
+			break;
+		case LTTNG_EVENT_FUNCTION_ENTRY:
+			lttng_event_function_attr_serialize(&lsm.u.enable.event, ev);
+			break;
+		default:
+			break;
+		}
+	}
 
 	lttng_ctl_copy_string(lsm.session.name, handle->session_name,
 			sizeof(lsm.session.name));
@@ -1308,8 +1322,7 @@ int lttng_disable_event_ext(struct lttng_handle *handle,
 	lsm.cmd_type = LTTNG_DISABLE_EVENT;
 
 	lttng_ctl_copy_lttng_domain(&lsm.domain, &handle->domain);
-	/* FIXME: copying non-packed struct to packed struct. */
-	memcpy(&lsm.u.disable.event, ev, sizeof(lsm.u.disable.event));
+	lttng_event_no_attr_serialize(&lsm.u.disable.event, ev);
 
 	lttng_ctl_copy_string(lsm.session.name, handle->session_name,
 			sizeof(lsm.session.name));
-- 
2.11.0
