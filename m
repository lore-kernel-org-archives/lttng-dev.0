From: Zifei Tong <soariez@gmail.com>
Subject: [PATCH lttng-tools 1/2] Fix: implicit conversion of
	enum types in consumer
Date: Tue, 25 Feb 2014 23:41:28 +0800
Message-ID: <1393342889-61215-1-git-send-email-soariez__38503.5652354874$1393343079$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [60.191.2.238] (helo=Zifeis-MacBook-Pro.local)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zifei@Zifeis-MacBook-Pro.local>) id 1WIK8n-0000tj-JX
	for lttng-dev@lists.lttng.org; Tue, 25 Feb 2014 10:42:01 -0500
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

Fix implicit conversions from enumeration type 'enum lttng_error_code'
to enumeration type 'enum lttcomm_return_code' found by clang.

Signed-off-by: Zifei Tong <soariez@gmail.com>
---
 src/common/kernel-consumer/kernel-consumer.c | 12 ++++++------
 src/common/ust-consumer/ust-consumer.c       |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index ab4f604..388ef11 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -561,7 +561,7 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 			 * happens while tearing down.
 			 */
 			ERR("Unable to find channel key %" PRIu64, msg.u.stream.channel_key);
-			ret_code = LTTNG_ERR_KERN_CHAN_NOT_FOUND;
+			ret_code = LTTCOMM_CONSUMERD_CHANNEL_FAIL;
 		}
 
 		health_code_update();
@@ -764,7 +764,7 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 			 */
 			ERR("Unable to find channel key %" PRIu64,
 					msg.u.sent_streams.channel_key);
-			ret_code = LTTNG_ERR_KERN_CHAN_NOT_FOUND;
+			ret_code = LTTCOMM_CONSUMERD_CHANNEL_FAIL;
 		}
 
 		health_code_update();
@@ -815,7 +815,7 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		relayd = consumer_find_relayd(index);
 		if (relayd == NULL) {
 			DBG("Unable to find relayd %" PRIu64, index);
-			ret_code = LTTNG_ERR_NO_CONSUMER;
+			ret_code = LTTCOMM_CONSUMERD_RELAYD_FAIL;
 		}
 
 		/*
@@ -874,7 +874,7 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 					msg.u.snapshot_channel.relayd_id, ctx);
 			if (ret < 0) {
 				ERR("Snapshot metadata failed");
-				ret_code = LTTNG_ERR_KERN_META_FAIL;
+				ret_code = LTTCOMM_CONSUMERD_ERROR_METADATA;
 			}
 		} else {
 			ret = lttng_kconsumer_snapshot_channel(msg.u.snapshot_channel.key,
@@ -884,7 +884,7 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 					ctx);
 			if (ret < 0) {
 				ERR("Snapshot channel failed");
-				ret_code = LTTNG_ERR_KERN_CHAN_FAIL;
+				ret_code = LTTCOMM_CONSUMERD_CHANNEL_FAIL;
 			}
 		}
 
@@ -905,7 +905,7 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		channel = consumer_find_channel(key);
 		if (!channel) {
 			ERR("Kernel consumer destroy channel %" PRIu64 " not found", key);
-			ret_code = LTTNG_ERR_KERN_CHAN_NOT_FOUND;
+			ret_code = LTTCOMM_CONSUMERD_CHANNEL_FAIL;
 		}
 
 		health_code_update();
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 0955e66..d19ce57 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -1145,7 +1145,7 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		relayd = consumer_find_relayd(index);
 		if (relayd == NULL) {
 			DBG("Unable to find relayd %" PRIu64, index);
-			ret_code = LTTNG_ERR_NO_CONSUMER;
+			ret_code = LTTCOMM_CONSUMERD_RELAYD_FAIL;
 		}
 
 		/*
@@ -1326,7 +1326,7 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		channel = consumer_find_channel(key);
 		if (!channel) {
 			ERR("UST consumer get channel key %" PRIu64 " not found", key);
-			ret_code = LTTNG_ERR_UST_CHAN_NOT_FOUND;
+			ret_code = LTTCOMM_CONSUMERD_CHANNEL_FAIL;
 			goto end_msg_sessiond;
 		}
 
@@ -1482,7 +1482,7 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 					ctx);
 			if (ret < 0) {
 				ERR("Snapshot metadata failed");
-				ret_code = LTTNG_ERR_UST_META_FAIL;
+				ret_code = LTTCOMM_CONSUMERD_ERROR_METADATA;
 			}
 		} else {
 			ret = snapshot_channel(msg.u.snapshot_channel.key,
@@ -1492,7 +1492,7 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 					ctx);
 			if (ret < 0) {
 				ERR("Snapshot channel failed");
-				ret_code = LTTNG_ERR_UST_CHAN_FAIL;
+				ret_code = LTTCOMM_CONSUMERD_CHANNEL_FAIL;
 			}
 		}
 
-- 
1.8.3.4 (Apple Git-47)
