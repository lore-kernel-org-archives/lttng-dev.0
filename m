From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-tools 3/3] Fix: consumerd: use packet
 sequence number for rotation position
Date: Tue,  5 Nov 2019 19:55:27 -0500
Message-ID: <20191106005527.7584-3-mathieu.desnoyers__16239.9200651393$1573001830$gmane$org@efficios.com>
References: <20191106005527.7584-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 4777PK3bhXz1RJp
 for <lttng-dev@lists.lttng.org>; Tue,  5 Nov 2019 19:55:31 -0500 (EST)
In-Reply-To: <20191106005527.7584-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Refer to "Fix: relayd: use packet sequence number for rotation position"
for context of this change.

This commit introduces the changes required in the consumerd.

Some notable points related to this commit:

- The per-stream rotation position within the consumerd is now the
  very start of the first packet to go into the next trace chunk,
  which makes consumerd consistent with the semantic of the relayd
  and of the rotate_at_seq_num field of the protocol between those two
  daemons.
- Internally, the rotate_position (per-stream) is now a 64-bit
  value rather than an unsigned long.
- The scheme to rotate a stream is changed to allow using the
  backward-compatible lttng_consumer_take_snapshot() rather than
  the newer lttng_consumer_get_produced_snapshot(), thus allowing
  backward compatibility of the implicit rotation on destroy with
  pre-2.10 lttng-modules.
- The rotate position used as pivot point for the rotation is
  based on the packet_seq_num of the last packet that has been
  send over the network by consumerd, incremented by the number of
  packets between the sampled produced_pos and the consumed_pos.
  In the worse case scenario where an overwrite mode ring buffer
  overwrites its contents enough to trigger a 4GB overflow on a
  32-bit producer since the last packet was sent (e.g. due to a
  slow network), the difference between produced_pos and
  consumed_pos will be lower that what would have been expected.
  However, because this pivot position is used as a lower bound,
  being smaller than the real value is fine: the data that would
  have been misplaced in the wrong trace chunk were actually
  overwritten, and will therefore never be consumed.

(limitations)
- When interacting with pre-2.8 lttng-modules, the packet sequence
  number is not available. The current approach is to send -1ULL as
  rotation position to the relayd, but it is probably not expected.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/consumer/consumer.c               | 142 ++++++++++---------
 src/common/consumer/consumer.h               |  15 +-
 src/common/kernel-consumer/kernel-consumer.c |   1 +
 3 files changed, 85 insertions(+), 73 deletions(-)

diff --git a/src/common/consumer/consumer.c b/src/common/consumer/consumer.c
index 09f0f098..3d764f92 100644
--- a/src/common/consumer/consumer.c
+++ b/src/common/consumer/consumer.c
@@ -603,6 +603,7 @@ struct lttng_consumer_stream *consumer_allocate_stream(uint64_t channel_key,
 	stream->endpoint_status = CONSUMER_ENDPOINT_ACTIVE;
 	stream->index_file = NULL;
 	stream->last_sequence_number = -1ULL;
+	stream->rotate_position = -1ULL;
 	pthread_mutex_init(&stream->lock, NULL);
 	pthread_mutex_init(&stream->metadata_timer_lock, NULL);
 
@@ -4081,7 +4082,7 @@ int lttng_consumer_rotate_channel(struct lttng_consumer_channel *channel,
 			ht->hash_fct(&channel->key, lttng_ht_seed),
 			ht->match_fct, &channel->key, &iter.iter,
 			stream, node_channel_id.node) {
-		unsigned long consumed_pos;
+		unsigned long produced_pos = 0, consumed_pos = 0;
 
 		health_code_update();
 
@@ -4094,65 +4095,77 @@ int lttng_consumer_rotate_channel(struct lttng_consumer_channel *channel,
 			rotating_to_new_chunk = false;
 		}
 
-		ret = lttng_consumer_sample_snapshot_positions(stream);
+		/*
+		 * Active flush; has no effect if the production position
+		 * is at a packet boundary.
+		 */
+		ret = consumer_flush_buffer(stream, 1);
 		if (ret < 0) {
-			ERR("Failed to sample snapshot position during channel rotation");
+			ERR("Failed to flush stream %" PRIu64 " during channel rotation",
+					stream->key);
 			goto end_unlock_stream;
 		}
 
-		ret = lttng_consumer_get_produced_snapshot(stream,
-				&stream->rotate_position);
-		if (ret < 0) {
-			ERR("Failed to sample produced position during channel rotation");
+		ret = lttng_consumer_take_snapshot(stream);
+		if (ret < 0 && ret != -ENODATA && ret != -EAGAIN) {
+			ERR("Failed to sample snapshot position during channel rotation");
 			goto end_unlock_stream;
 		}
+		if (!ret) {
+			ret = lttng_consumer_get_produced_snapshot(stream,
+					&produced_pos);
+			if (ret < 0) {
+				ERR("Failed to sample produced position during channel rotation");
+				goto end_unlock_stream;
+			}
 
-		lttng_consumer_get_consumed_snapshot(stream,
-				&consumed_pos);
-		if (consumed_pos == stream->rotate_position) {
+			ret = lttng_consumer_get_consumed_snapshot(stream,
+					&consumed_pos);
+			if (ret < 0) {
+				ERR("Failed to sample consumed position during channel rotation");
+				goto end_unlock_stream;
+			}
+		}
+		/*
+		 * Align produced position on the start-of-packet boundary of the first
+		 * packet going into the next trace chunk.
+		 */
+		produced_pos = ALIGN_FLOOR(produced_pos, stream->max_sb_size);
+		if (consumed_pos == produced_pos) {
 			stream->rotate_ready = true;
 		}
-
 		/*
-		 * Active flush; has no effect if the production position
-		 * is at a packet boundary.
+		 * The rotation position is based on the packet_seq_num of the
+		 * packet following the last packet that was consumed for this
+		 * stream, incremented by the offset between produced and
+		 * consumed positions. This rotation position is a lower bound
+		 * (inclusive) at which the next trace chunk starts. Since it
+		 * is a lower bound, it is OK if the packet_seq_num does not
+		 * correspond exactly to the same packet identified by the
+		 * consumed_pos, which can happen in overwrite mode.
 		 */
-		ret = consumer_flush_buffer(stream, 1);
-		if (ret < 0) {
-			ERR("Failed to flush stream %" PRIu64 " during channel rotation",
-					stream->key);
-			goto end_unlock_stream;
+		if (stream->sequence_number_unavailable) {
+			/*
+			 * For implicit rotation on destroy of stream
+			 * associated with pre-2.8 lttng-modules, which does
+			 * not implement packet sequence number.
+			 * TODO: this is not handled in the relayd.
+			 */
+			stream->rotate_position = -1ULL;
+		} else {
+			stream->rotate_position = stream->last_sequence_number + 1 +
+				((produced_pos - consumed_pos) / stream->max_sb_size);
 		}
 
 		if (!is_local_trace) {
 			/*
 			 * The relay daemon control protocol expects a rotation
 			 * position as "the sequence number of the first packet
-			 * _after_ the current trace chunk.
-			 *
-			 * At the moment when the positions of the buffers are
-			 * sampled, the production position does not necessarily
-			 * sit at a packet boundary. The 'active' flush
-			 * operation above will push the production position to
-			 * the next packet boundary _if_ it is not already
-			 * sitting at such a boundary.
-			 *
-			 * Assuming a current production position that is not
-			 * on the bound of a packet, the 'target' sequence
-			 * number is
-			 *   (consumed_pos / subbuffer_size) + 1
-			 * Note the '+ 1' to ensure the current packet is
-			 * part of the current trace chunk.
-			 *
-			 * However, if the production position is already at
-			 * a packet boundary, the '+ 1' is not necessary as the
-			 * last packet of the current chunk is already
-			 * 'complete'.
+			 * _after_ the current trace chunk".
 			 */
 			const struct relayd_stream_rotation_position position = {
 				.stream_id = stream->relayd_stream_id,
-				.rotate_at_seq_num = (stream->rotate_position / stream->max_sb_size) +
-					!!(stream->rotate_position % stream->max_sb_size),
+				.rotate_at_seq_num = stream->rotate_position,
 			};
 
 			ret = lttng_dynamic_array_add_element(
@@ -4215,44 +4228,37 @@ end:
  */
 int lttng_consumer_stream_is_rotate_ready(struct lttng_consumer_stream *stream)
 {
-	int ret;
-	unsigned long consumed_pos;
-
-	if (!stream->rotate_position && !stream->rotate_ready) {
-		ret = 0;
-		goto end;
-	}
-
 	if (stream->rotate_ready) {
-		ret = 1;
-		goto end;
+		return 1;
 	}
 
 	/*
-	 * If we don't have the rotate_ready flag, check the consumed position
-	 * to determine if we need to rotate.
+	 * If packet seq num is unavailable, it means we are interacting
+	 * with a pre-2.8 lttng-modules which does not implement the
+	 * sequence number. The only situation in which this is invoked in
+	 * this configuration is the implicit rotation on destroy, which
+	 * already uses a data pending check to wait for quiescence.
 	 */
-	ret = lttng_consumer_sample_snapshot_positions(stream);
-	if (ret < 0) {
-		ERR("Taking snapshot positions");
-		goto end;
+	if (stream->sequence_number_unavailable) {
+		return 1;
 	}
 
-	ret = lttng_consumer_get_consumed_snapshot(stream, &consumed_pos);
-	if (ret < 0) {
-		ERR("Consumed snapshot position");
-		goto end;
+	if (stream->rotate_position == -1ULL ||
+			stream->last_sequence_number == -1ULL) {
+		return 0;
 	}
 
-	/* Rotate position not reached yet (with check for overflow). */
-	if ((long) (consumed_pos - stream->rotate_position) < 0) {
-		ret = 0;
-		goto end;
+	/*
+	 * Rotate position not reached yet. The stream rotate position is
+	 * the position of the next packet belonging to the next trace chunk,
+	 * but consumerd considers rotation ready when reaching the last
+	 * packet of the current chunk, hence the "rotate_position - 1".
+	 */
+	if (stream->last_sequence_number >= stream->rotate_position - 1) {
+		return 1;
 	}
-	ret = 1;
 
-end:
-	return ret;
+	return 0;
 }
 
 /*
@@ -4260,7 +4266,7 @@ end:
  */
 void lttng_consumer_reset_stream_rotate_state(struct lttng_consumer_stream *stream)
 {
-	stream->rotate_position = 0;
+	stream->rotate_position = -1ULL;
 	stream->rotate_ready = false;
 }
 
diff --git a/src/common/consumer/consumer.h b/src/common/consumer/consumer.h
index 1aaddb5a..74de91b5 100644
--- a/src/common/consumer/consumer.h
+++ b/src/common/consumer/consumer.h
@@ -304,6 +304,11 @@ struct lttng_consumer_stream {
 	 */
 	bool quiescent;
 
+	/*
+	 * True if the sequence number is not available (lttng-modules < 2.8).
+	 */
+	bool sequence_number_unavailable;
+
 	/*
 	 * metadata_timer_lock protects flags waiting_on_metadata and
 	 * missed_metadata_flush.
@@ -438,12 +443,12 @@ struct lttng_consumer_stream {
 	pthread_mutex_t metadata_rdv_lock;
 
 	/*
-	 * rotate_position represents the position in the ring-buffer that has to
-	 * be flushed to disk to complete the ongoing rotation. When that position
-	 * is reached, this tracefile can be closed and a new one is created in
-	 * channel_read_only_attributes.path.
+	 * rotate_position represents the packet sequence number of the last
+	 * packet which belongs to the current trace chunk prior to the rotation.
+	 * When that position is reached, this tracefile can be closed and a
+	 * new one is created in channel_read_only_attributes.path.
 	 */
-	unsigned long rotate_position;
+	uint64_t rotate_position;
 
 	/*
 	 * Read-only copies of channel values. We cannot safely access the
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index 9fa92f6b..ca975527 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -1454,6 +1454,7 @@ int update_stream_stats(struct lttng_consumer_stream *stream)
 		if (ret == -ENOTTY) {
 			/* Command not implemented by lttng-modules. */
 			seq = -1ULL;
+			stream->sequence_number_unavailable = true;
 		} else {
 			PERROR("kernctl_get_sequence_number");
 			goto end;
-- 
2.17.1
