From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH 7/9] Account the lost packets in
	snapshot mode
Date: Mon, 13 Jul 2015 11:28:07 -0400
Message-ID: <1436801289-17554-8-git-send-email-jdesfossez__39124.5774379515$1436801738$gmane$org@efficios.com>
References: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfeh-0008PZ-Uq
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:28:33 -0400
In-Reply-To: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

When working in flight-recorder, we cannot rely on the absolute sequence
number because we only extract the content of the ring buffer
periodically. Moreover, we don't want to account the lost packets at the
beginning or the end of the snapshot since the "holes" don't appear in
the resulting snapshot, so we make sure we only account lost packets
locate between extracted packets.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/common/kernel-consumer/kernel-consumer.c | 23 ++++++++++++++++++++++-
 src/common/ust-consumer/ust-consumer.c       | 23 ++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index 52ab2ef..66c40c2 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -118,7 +118,7 @@ int lttng_kconsumer_snapshot_channel(uint64_t key, char *path,
 		uint64_t relayd_id, uint64_t nb_packets_per_stream,
 		struct lttng_consumer_local_data *ctx)
 {
-	int ret;
+	int ret, first, lost;
 	unsigned long consumed_pos, produced_pos;
 	struct lttng_consumer_channel *channel;
 	struct lttng_consumer_stream *stream;
@@ -225,6 +225,8 @@ int lttng_kconsumer_snapshot_channel(uint64_t key, char *path,
 				produced_pos, nb_packets_per_stream,
 				stream->max_sb_size);
 
+		first = 1;
+		lost = 0;
 		while (consumed_pos < produced_pos) {
 			ssize_t read_len;
 			unsigned long len, padded_len;
@@ -242,6 +244,15 @@ int lttng_kconsumer_snapshot_channel(uint64_t key, char *path,
 				}
 				DBG("Kernel consumer get subbuf failed. Skipping it.");
 				consumed_pos += stream->max_sb_size;
+
+				/*
+				 * Start accounting lost packets only when we
+				 * already have extracted packets (to match the
+				 * content of the final snapshot).
+				 */
+				if (!first) {
+					lost++;
+				}
 				continue;
 			}
 
@@ -285,6 +296,16 @@ int lttng_kconsumer_snapshot_channel(uint64_t key, char *path,
 				goto end_unlock;
 			}
 			consumed_pos += stream->max_sb_size;
+
+			/*
+			 * Only account lost packets located between
+			 * succesfully extracted packets (do not account before
+			 * and after since they are not visible in the
+			 * resulting snapshot).
+			 */
+			stream->chan->lost_packets += lost;
+			lost = 0;
+			first = 0;
 		}
 
 		if (relayd_id == (uint64_t) -1ULL) {
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index d39f4e6..282580a 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -1001,7 +1001,7 @@ error:
 static int snapshot_channel(uint64_t key, char *path, uint64_t relayd_id,
 		uint64_t nb_packets_per_stream, struct lttng_consumer_local_data *ctx)
 {
-	int ret;
+	int ret, first, lost;
 	unsigned use_relayd = 0;
 	unsigned long consumed_pos, produced_pos;
 	struct lttng_consumer_channel *channel;
@@ -1089,6 +1089,8 @@ static int snapshot_channel(uint64_t key, char *path, uint64_t relayd_id,
 				produced_pos, nb_packets_per_stream,
 				stream->max_sb_size);
 
+		first = 1;
+		lost = 0;
 		while (consumed_pos < produced_pos) {
 			ssize_t read_len;
 			unsigned long len, padded_len;
@@ -1105,6 +1107,15 @@ static int snapshot_channel(uint64_t key, char *path, uint64_t relayd_id,
 				}
 				DBG("UST consumer get subbuf failed. Skipping it.");
 				consumed_pos += stream->max_sb_size;
+
+				/*
+				 * Start accounting lost packets only when we
+				 * already have extracted packets (to match the
+				 * content of the final snapshot).
+				 */
+				if (!first) {
+					lost++;
+				}
 				continue;
 			}
 
@@ -1140,6 +1151,16 @@ static int snapshot_channel(uint64_t key, char *path, uint64_t relayd_id,
 				goto error_close_stream;
 			}
 			consumed_pos += stream->max_sb_size;
+
+			/*
+			 * Only account lost packets located between
+			 * succesfully extracted packets (do not account before
+			 * and after since they are not visible in the
+			 * resulting snapshot).
+			 */
+			stream->chan->lost_packets += lost;
+			lost = 0;
+			first = 0;
 		}
 
 		/* Simply close the stream so we can use it on the next snapshot. */
-- 
1.9.1
