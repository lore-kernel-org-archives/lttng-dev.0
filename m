From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-tools 1/3] Fix: relayd: use packet
 sequence number for rotation position
Date: Tue,  5 Nov 2019 19:55:25 -0500
Message-ID: <20191106005527.7584-1-mathieu.desnoyers__37159.7119419434$1573001848$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 4777PK3cxYz1RJq
 for <lttng-dev@lists.lttng.org>; Tue,  5 Nov 2019 19:55:31 -0500 (EST)
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

The "network" sequence number (net_seq_num) is a 64-bit sequence number
tagging each packet sent over the network. The net_seq_num increments
monotonically (+1) for each packet sent from consumer daemon to relay
daemon, on a per-stream basis. It is tagged by the consumer daemon when
sending a trace packet to the relay daemon.

The LTTng kernel and user-space ring buffer "consumed position"
(consumed_pos) and "produced position" (produced_pos) are free-running
counters counting the number of bytes consumed and produced so far by
each stream. Because those counters are updated atomically, they are
limited to a size of 32-bit on 32-bit architectures.

The "packet" sequence number (packet_seq_num) is a sequence number
found in the packet header starting from LTTng 2.8. It is a 64-bit
sequence number assigned by the lttng-modules and lttng-ust ring
buffers. It increments monotonically (+1) for each packet produced
within a given ring buffer (stream).

Using produced_pos as rotation position and comparing it to the
net_seq_num has a few issues:

1) It breaks on 32-bit producers after generating more than 4GB of
   data per stream, due to overflow. The net_seq_num is a 64-bit
   counter, which does not overflow, but the produced_pos overflows
   after 4GB on 32-bit architectures. This can lead to never-completing
   rotations.

2) It breaks scenarios where ring buffers are configured in
   overwrite mode, and streaming to a relay daemon. Indeed, when
   the ring buffer moves the consumed_pos ahead, actually overwriting
   data within the ring buffer, it introduces an offset between the
   produced_pos and the net_seq_num. Therefore, if producers are
   generating a low- (or no-) throughput in some streams, the
   rotation may never complete, even on 64-bit architectures.

The solution proposed for this issue is to use the packet_seq_num as
rotation position rather than the net_seq_num. It takes care of
the two problematic scenarios, since the counter is always 64-bit
(even on 32-bit architectures), and because the counter is managed
by the producer, which therefore tracks progress of the ring buffer
overwrites.

This commit introduces changes required at the relayd side. A
separate commit introduces the changes required in the consumerd.

In relayd, one major restriction is the fact that the packet_seq_num
is not sent over the data socket, only through the control socket
receiving the indexes.

Therefore, in order to figure out the pivot position for the data
socket for a given stream, the associated index first needs to be
received. At that point, the corresponding net_seq_num is known,
which provides the pivot position for the data stream. Given that
the data and index sockets provide no ordering guarantees with
respect to their arrival, we handle the fact that data might have
been saved to disk in the wrong (previous) trace chunk by moving
it to the next trace chunk when the pivot position is known.

In order to allow "jumps" in the sequence numbers produced by
overwrite mode buffers, try_rotate_stream_index(), which previously
asserted that each sequence number was received in sequence, now
uses the packet_seq_num pivot position as a lower (inclusive) bound.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/index.c  |  5 +++
 src/bin/lttng-relayd/main.c   |  3 ++
 src/bin/lttng-relayd/stream.c | 61 ++++++++++++++++++++++++++---------
 src/bin/lttng-relayd/stream.h | 18 +++++++++--
 src/common/relayd/relayd.h    |  2 +-
 5 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/src/bin/lttng-relayd/index.c b/src/bin/lttng-relayd/index.c
index 3cae94e8..bdbd1133 100644
--- a/src/bin/lttng-relayd/index.c
+++ b/src/bin/lttng-relayd/index.c
@@ -433,6 +433,11 @@ int relay_index_set_control_data(struct relay_index *index,
 	if (minor_version >= 8) {
 		index->index_data.stream_instance_id = htobe64(data->stream_instance_id);
 		index->index_data.packet_seq_num = htobe64(data->packet_seq_num);
+	} else {
+		uint64_t unset_value = -1ULL;
+
+		index->index_data.stream_instance_id = htobe64(unset_value);
+		index->index_data.packet_seq_num = htobe64(unset_value);
 	}
 
 	return relay_index_set_data(index, &index_data);
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 5f72c32a..09ba4e9d 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -2121,6 +2121,9 @@ static int relay_recv_index(const struct lttcomm_relayd_hdr *recv_hdr,
 		index_info.stream_instance_id =
 				be64toh(index_info.stream_instance_id);
 		index_info.packet_seq_num = be64toh(index_info.packet_seq_num);
+	} else {
+		index_info.stream_instance_id = -1ULL;
+		index_info.packet_seq_num = -1ULL;
 	}
 
 	stream = stream_get_by_id(index_info.relay_stream_id);
diff --git a/src/bin/lttng-relayd/stream.c b/src/bin/lttng-relayd/stream.c
index 9d753bd0..c5bf3759 100644
--- a/src/bin/lttng-relayd/stream.c
+++ b/src/bin/lttng-relayd/stream.c
@@ -369,18 +369,23 @@ static int try_rotate_stream_data(struct relay_stream *stream)
 	}
 
 	if (stream->prev_data_seq == -1ULL ||
-			stream->prev_data_seq + 1 < stream->ongoing_rotation.value.seq_num) {
+			stream->ongoing_rotation.value.prev_data_net_seq == -1ULL ||
+			stream->prev_data_seq <
+			stream->ongoing_rotation.value.prev_data_net_seq) {
 		/*
 		 * The next packet that will be written is not part of the next
 		 * chunk yet.
 		 */
-		DBG("Stream %" PRIu64 " not yet ready for rotation (rotate_at_seq_num = %" PRIu64
+		DBG("Stream %" PRIu64 " data not yet ready for rotation "
+				"(rotate_at_index_packet_seq_num = %" PRIu64
+				", rotate_at_prev_data_net_seq = %" PRIu64
 				", prev_data_seq = %" PRIu64 ")",
 				stream->stream_handle,
-				stream->ongoing_rotation.value.seq_num,
+				stream->ongoing_rotation.value.packet_seq_num,
+				stream->ongoing_rotation.value.prev_data_net_seq,
 				stream->prev_data_seq);
 		goto end;
-	} else if (stream->prev_data_seq > stream->ongoing_rotation.value.seq_num) {
+	} else if (stream->prev_data_seq > stream->ongoing_rotation.value.prev_data_net_seq) {
 		/*
 		 * prev_data_seq is checked here since indexes and rotation
 		 * commands are serialized with respect to each other.
@@ -478,23 +483,36 @@ static int try_rotate_stream_index(struct relay_stream *stream)
 		goto end;
 	}
 
-	if (stream->prev_index_seq == -1ULL ||
-			stream->prev_index_seq + 1 < stream->ongoing_rotation.value.seq_num) {
-		DBG("Stream %" PRIu64 " index not yet ready for rotation (rotate_at_seq_num = %" PRIu64 ", prev_index_seq = %" PRIu64 ")",
+	if (stream->received_packet_seq_num == -1ULL ||
+			stream->received_packet_seq_num + 1 <
+			stream->ongoing_rotation.value.packet_seq_num) {
+		DBG("Stream %" PRIu64 " index not yet ready for rotation "
+				"(rotate_at_packet_seq_num = %" PRIu64
+				", received_packet_seq_num = %" PRIu64 ")",
 				stream->stream_handle,
-				stream->ongoing_rotation.value.seq_num,
-				stream->prev_index_seq);
+				stream->ongoing_rotation.value.packet_seq_num,
+				stream->received_packet_seq_num);
 		goto end;
 	} else {
-		/* The next index belongs to the new trace chunk; rotate. */
-		assert(stream->prev_index_seq + 1 ==
-				stream->ongoing_rotation.value.seq_num);
+		/*
+		 * The next index belongs to the new trace chunk; rotate.
+		 * In overwrite mode, the packet seq num may jump over the
+		 * rotation position.
+		 */
+		assert(stream->received_packet_seq_num + 1 >=
+				stream->ongoing_rotation.value.packet_seq_num);
 		DBG("Rotating stream %" PRIu64 " index file",
 				stream->stream_handle);
 		ret = create_index_file(stream,
 				stream->ongoing_rotation.value.next_trace_chunk);
 		stream->ongoing_rotation.value.index_rotated = true;
 
+		/*
+		 * Set the rotation pivot position for the data, now that we have the
+		 * net_seq_num matching the packet_seq_num index pivot position.
+		 */
+		stream->ongoing_rotation.value.prev_data_net_seq =
+			stream->prev_index_seq;
 		if (stream->ongoing_rotation.value.data_rotated &&
 				stream->ongoing_rotation.value.index_rotated) {
 			/* Rotation completed; reset its state. */
@@ -569,6 +587,7 @@ struct relay_stream *stream_create(struct ctf_trace *trace,
 	stream->path_name = path_name;
 	stream->channel_name = channel_name;
 	stream->beacon_ts_end = -1ULL;
+	stream->received_packet_seq_num = -1ULL;
 	lttng_ht_node_init_u64(&stream->node, stream->stream_handle);
 	pthread_mutex_init(&stream->lock, NULL);
 	urcu_ref_init(&stream->ref);
@@ -799,7 +818,10 @@ int stream_set_pending_rotation(struct relay_stream *stream,
 {
 	int ret = 0;
 	const struct relay_stream_rotation rotation = {
-		.seq_num = rotation_sequence_number,
+		.data_rotated = false,
+		.index_rotated = false,
+		.packet_seq_num = rotation_sequence_number,
+		.prev_data_net_seq = -1ULL,
 		.next_trace_chunk = next_trace_chunk,
 	};
 
@@ -817,7 +839,8 @@ int stream_set_pending_rotation(struct relay_stream *stream,
 	}
 	LTTNG_OPTIONAL_SET(&stream->ongoing_rotation, rotation);
 
-	DBG("Setting pending rotation: stream_id = %" PRIu64 ", rotation_seq_num = %" PRIu64,
+	DBG("Setting pending rotation: stream_id = %" PRIu64
+			", rotate_at_packet_seq_num = %" PRIu64,
 			stream->stream_handle, rotation_sequence_number);
 	if (stream->is_metadata) {
 		/*
@@ -826,12 +849,12 @@ int stream_set_pending_rotation(struct relay_stream *stream,
 		stream->ongoing_rotation.value.index_rotated = true;
 		ret = stream_rotate_data_file(stream);
 	} else {
-		ret = try_rotate_stream_data(stream);
+		ret = try_rotate_stream_index(stream);
 		if (ret < 0) {
 			goto end;
 		}
 
-		ret = try_rotate_stream_index(stream);
+		ret = try_rotate_stream_data(stream);
 		if (ret < 0) {
 			goto end;
 		}
@@ -1119,6 +1142,7 @@ int stream_update_index(struct relay_stream *stream, uint64_t net_seq_num,
 		tracefile_array_file_rotate(stream->tfa, TRACEFILE_ROTATE_READ);
 		tracefile_array_commit_seq(stream->tfa);
 		stream->index_received_seqcount++;
+		stream->received_packet_seq_num = index->index_data.packet_seq_num;
 		*flushed = true;
 	} else if (ret > 0) {
 		index->total_size = total_size;
@@ -1215,11 +1239,16 @@ int stream_add_index(struct relay_stream *stream,
 		stream->index_received_seqcount++;
 		stream->pos_after_last_complete_data_index += index->total_size;
 		stream->prev_index_seq = index_info->net_seq_num;
+		stream->received_packet_seq_num = index_info->packet_seq_num;
 
 		ret = try_rotate_stream_index(stream);
 		if (ret < 0) {
 			goto end;
 		}
+		ret = try_rotate_stream_data(stream);
+		if (ret < 0) {
+			goto end;
+		}
 	} else if (ret > 0) {
 		/* no flush. */
 		ret = 0;
diff --git a/src/bin/lttng-relayd/stream.h b/src/bin/lttng-relayd/stream.h
index b8d14ecf..70c37765 100644
--- a/src/bin/lttng-relayd/stream.h
+++ b/src/bin/lttng-relayd/stream.h
@@ -44,10 +44,15 @@ struct relay_stream_rotation {
 	bool data_rotated;
 	bool index_rotated;
 	/*
-	 * Sequence number of the first packet of the new trace chunk to which
-	 * the stream is rotating.
+	 * Packet sequence number of the first packet of the new trace chunk to
+	 * which the stream is rotating.
 	 */
-	uint64_t seq_num;
+	uint64_t packet_seq_num;
+	/*
+	 * Monotonically increasing previous network sequence number of first
+	 * data packet of the new trace chunk to which the stream is rotating.
+	 */
+	uint64_t prev_data_net_seq;
 	struct lttng_trace_chunk *next_trace_chunk;
 };
 
@@ -111,6 +116,13 @@ struct relay_stream {
 	 */
 	uint64_t index_received_seqcount;
 
+	/*
+	 * Packet sequence number of the last received packet index.
+	 * Initialized to -1ULL. Only populated when interacting with
+	 * CTF_INDEX 1.1+.
+	 */
+	uint64_t received_packet_seq_num;
+
 	/*
 	 * Tracefile array is an index of the stream trace files,
 	 * indexed by position. It allows keeping track of the oldest
diff --git a/src/common/relayd/relayd.h b/src/common/relayd/relayd.h
index 5c536839..61829f7b 100644
--- a/src/common/relayd/relayd.h
+++ b/src/common/relayd/relayd.h
@@ -29,7 +29,7 @@
 struct relayd_stream_rotation_position {
 	uint64_t stream_id;
 	/*
-	 * Sequence number of the first packet belonging to the new
+	 * Packet sequence number of the first packet belonging to the new
 	 * "destination" trace chunk to which the stream is rotating.
 	 *
 	 * Ignored for metadata streams.
-- 
2.17.1
