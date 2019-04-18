From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools 15/18] Integrate serialized
 communication in lttng-ctl and sessiond
Date: Thu, 18 Apr 2019 12:18:47 -0400
Message-ID: <20190418161850.1536-16-ylamarre__14475.3795628034$1555604690$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44lPS56znlz1Jnt
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 12:19:01 -0400 (EDT)
In-Reply-To: <20190418161850.1536-1-ylamarre@efficios.com>
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
 src/bin/lttng-sessiond/client.c          | 23 ++++++++++++++++++++---
 src/common/sessiond-comm/sessiond-comm.h |  4 ++--
 src/lib/lttng-ctl/lttng-ctl.c            | 14 ++++++++++----
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/src/bin/lttng-sessiond/client.c b/src/bin/lttng-sessiond/client.c
index 24e688c5..aed415ee 100644
--- a/src/bin/lttng-sessiond/client.c
+++ b/src/bin/lttng-sessiond/client.c
@@ -1150,6 +1150,7 @@ error_add_context:
 	case LTTNG_DISABLE_EVENT:
 	{
 
+		struct lttng_event event;
 		/*
 		 * FIXME: handle filter; for now we just receive the filter's
 		 * bytecode along with the filter expression which are sent by
@@ -1176,10 +1177,17 @@ error_add_context:
 				count -= (size_t) ret;
 			}
 		}
-		/* FIXME: passing packed structure to non-packed pointer */
+		lttng_event_no_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
+		if (cmd_ctx->lsm->domain.type == LTTNG_DOMAIN_KERNEL) {
+			if (event.type == LTTNG_EVENT_PROBE || event.type == LTTNG_EVENT_FUNCTION || event.type == LTTNG_EVENT_USERSPACE_PROBE) {
+				lttng_event_probe_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
+			} else if (event.type == LTTNG_EVENT_FUNCTION_ENTRY) {
+				lttng_event_function_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
+			}
+		}
 		ret = cmd_disable_event(cmd_ctx->session, cmd_ctx->lsm->domain.type,
 				cmd_ctx->lsm->u.disable.channel_name,
-				&cmd_ctx->lsm->u.disable.event);
+				&event);
 		break;
 	}
 	case LTTNG_ENABLE_CHANNEL:
@@ -1210,6 +1218,7 @@ error_add_context:
 	}
 	case LTTNG_ENABLE_EVENT:
 	{
+		struct lttng_event event;
 		struct lttng_event *ev = NULL;
 		struct lttng_event_exclusion *exclusion = NULL;
 		struct lttng_filter_bytecode *bytecode = NULL;
@@ -1312,7 +1321,15 @@ error_add_context:
 			}
 		}
 
-		ev = lttng_event_copy(&cmd_ctx->lsm->u.enable.event);
+		lttng_event_no_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
+		if (cmd_ctx->lsm->domain.type == LTTNG_DOMAIN_KERNEL) {
+			if (event.type == LTTNG_EVENT_PROBE || event.type == LTTNG_EVENT_FUNCTION || event.type == LTTNG_EVENT_USERSPACE_PROBE) {
+				lttng_event_probe_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
+			} else if (event.type == LTTNG_EVENT_FUNCTION_ENTRY) {
+				lttng_event_function_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
+			}
+		}
+		ev = lttng_event_copy(&event);
 		if (!ev) {
 			DBG("Failed to copy event: %s",
 					cmd_ctx->lsm->u.enable.event.name);
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 78b18185..4c2240a0 100644
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
index 686a98ef..a9adb5c2 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -1110,8 +1110,15 @@ int lttng_enable_event_with_exclusions(struct lttng_handle *handle,
 	}
 
 	lttng_ctl_copy_lttng_domain(&lsm.domain, &handle->domain);
-	/* FIXME: copying non-packed struct to packed struct. */
-	memcpy(&lsm.u.enable.event, ev, sizeof(lsm.u.enable.event));
+
+	lttng_event_no_attr_serialize(&lsm.u.enable.event, ev);
+	if (handle->domain.type == LTTNG_DOMAIN_KERNEL) {
+		if (ev->type == LTTNG_EVENT_PROBE || ev->type == LTTNG_EVENT_FUNCTION || ev->type == LTTNG_EVENT_USERSPACE_PROBE) {
+			lttng_event_probe_attr_serialize(&lsm.u.enable.event, ev);
+		} else if (ev->type == LTTNG_EVENT_FUNCTION_ENTRY) {
+			lttng_event_function_attr_serialize(&lsm.u.enable.event, ev);
+		}
+	}
 
 	lttng_ctl_copy_string(lsm.session.name, handle->session_name,
 			sizeof(lsm.session.name));
@@ -1310,8 +1317,7 @@ int lttng_disable_event_ext(struct lttng_handle *handle,
 	lsm.cmd_type = LTTNG_DISABLE_EVENT;
 
 	lttng_ctl_copy_lttng_domain(&lsm.domain, &handle->domain);
-	/* FIXME: copying non-packed struct to packed struct. */
-	memcpy(&lsm.u.disable.event, ev, sizeof(lsm.u.disable.event));
+	lttng_event_no_attr_serialize(&lsm.u.disable.event, ev);
 
 	lttng_ctl_copy_string(lsm.session.name, handle->session_name,
 			sizeof(lsm.session.name));
-- 
2.11.0
