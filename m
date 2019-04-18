From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools 09/18] Integrate serialized
 communication in lttng-ctl and sessiond
Date: Thu, 18 Apr 2019 12:18:41 -0400
Message-ID: <20190418161850.1536-10-ylamarre__904.513678845831$1555604480$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44lPS35r6Rz1Jmf
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 12:18:59 -0400 (EDT)
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
messages using lttng_channel.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 src/bin/lttng-sessiond/client.c          |  9 ++++++---
 src/common/sessiond-comm/sessiond-comm.h |  4 ++--
 src/lib/lttng-ctl/lttng-ctl.c            | 24 ++++--------------------
 3 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/src/bin/lttng-sessiond/client.c b/src/bin/lttng-sessiond/client.c
index a889529a..0e36e5ad 100644
--- a/src/bin/lttng-sessiond/client.c
+++ b/src/bin/lttng-sessiond/client.c
@@ -1182,10 +1182,13 @@ error_add_context:
 	}
 	case LTTNG_ENABLE_CHANNEL:
 	{
-		cmd_ctx->lsm->u.channel.chan.attr.extended.ptr =
-				(struct lttng_channel_extended *) &cmd_ctx->lsm->u.channel.extended;
+		struct lttng_channel channel;
+		struct lttng_channel_extended extended;
+		lttng_channel_extended_deserialize(&extended, &cmd_ctx->lsm->u.channel.extended);
+		lttng_channel_deserialize(&channel, &cmd_ctx->lsm->u.channel.chan);
+		channel.attr.extended.ptr = &extended;
 		ret = cmd_enable_channel(cmd_ctx->session, &cmd_ctx->lsm->domain,
-				&cmd_ctx->lsm->u.channel.chan,
+				&channel,
 				kernel_poll_pipe[1]);
 		break;
 	}
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 23e82c8a..d0905f9e 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -402,9 +402,9 @@ struct lttcomm_session_msg {
 		} LTTNG_PACKED disable;
 		/* Create channel */
 		struct {
-			struct lttng_channel chan LTTNG_PACKED;
+			struct lttng_channel_serialized chan;
 			/* struct lttng_channel_extended is already packed. */
-			struct lttng_channel_extended extended;
+			struct lttng_channel_extended_serialized extended;
 		} LTTNG_PACKED channel;
 		/* Context */
 		struct {
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index 165fef4d..789534c8 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -1527,34 +1527,18 @@ int lttng_enable_channel(struct lttng_handle *handle,
 	}
 
 	memset(&lsm, 0, sizeof(lsm));
-	memcpy(&lsm.u.channel.chan, in_chan, sizeof(lsm.u.channel.chan));
-	lsm.u.channel.chan.attr.extended.ptr = NULL;
-
 	if (!in_chan->attr.extended.ptr) {
-		struct lttng_channel *channel;
-		struct lttng_channel_extended *extended;
-
-		channel = lttng_channel_create(&handle->domain);
-		if (!channel) {
-			return -LTTNG_ERR_NOMEM;
-		}
-
-		/*
-		 * Create a new channel in order to use default extended
-		 * attribute values.
-		 */
-		extended = (struct lttng_channel_extended *)
-				channel->attr.extended.ptr;
-		memcpy(&lsm.u.channel.extended, extended, sizeof(*extended));
-		lttng_channel_destroy(channel);
+		init_serialized_extended_channel(&handle->domain, &lsm.u.channel.extended);
 	} else {
 		struct lttng_channel_extended *extended;
 
 		extended = (struct lttng_channel_extended *)
 				in_chan->attr.extended.ptr;
-		memcpy(&lsm.u.channel.extended, extended, sizeof(*extended));
+		lttng_channel_extended_serialize(&lsm.u.channel.extended, extended);
 	}
 
+	lttng_channel_serialize(&lsm.u.channel.chan, in_chan);
+
 	/*
 	 * Verify that the amount of memory required to create the requested
 	 * buffer is available on the system at the moment.
-- 
2.11.0
