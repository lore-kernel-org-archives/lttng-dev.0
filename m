From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/3] Fix: relayd: tracefile
 rotation: viewer opening missing index file
Date: Fri,  1 Nov 2019 16:23:03 -0400
Message-ID: <20191101202305.21496-1-mathieu.desnoyers__3322.71063686989$1572639816$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 474YXy2wKnzrTr
 for <lttng-dev@lists.lttng.org>; Fri,  1 Nov 2019 16:23:14 -0400 (EDT)
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

Moving the head position of the tracefile array when the data is
received opens a window where a viewer attaching to the session could
try to open a missing index file (which has not been received yet).

However, we want to bump the tail position as soon as we receive
data, because the prior tail is not valid anymore.

Solve this by introducing two head positions: the "read" head
and the "write" head. The "write" head is the position of the
newest data file (equivalent to the prior "head" position). We
also introduce a "read" head position, which is only moved
forward when the index is received.

The viewer now uses the "read" head position as upper bound, which
ensures it never attempts to open a non-existing index file.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/stream.c          |  4 +-
 src/bin/lttng-relayd/tracefile-array.c | 58 ++++++++++++++++----------
 src/bin/lttng-relayd/tracefile-array.h | 21 ++++++++--
 src/bin/lttng-relayd/viewer-stream.c   |  2 +-
 4 files changed, 58 insertions(+), 27 deletions(-)

diff --git a/src/bin/lttng-relayd/stream.c b/src/bin/lttng-relayd/stream.c
index 94698f8d..4d3d37a2 100644
--- a/src/bin/lttng-relayd/stream.c
+++ b/src/bin/lttng-relayd/stream.c
@@ -958,7 +958,7 @@ int stream_init_packet(struct relay_stream *stream, size_t packet_size,
 				stream->stream_handle,
 				stream->tracefile_size_current, packet_size,
 				stream->tracefile_current_index, new_file_index);
-		tracefile_array_file_rotate(stream->tfa);
+		tracefile_array_file_rotate(stream->tfa, TRACEFILE_ROTATE_WRITE);
 		stream->tracefile_current_index = new_file_index;
 
 		if (stream->stream_fd) {
@@ -1095,6 +1095,7 @@ int stream_update_index(struct relay_stream *stream, uint64_t net_seq_num,
 
 	ret = relay_index_try_flush(index);
 	if (ret == 0) {
+		tracefile_array_file_rotate(stream->tfa, TRACEFILE_ROTATE_READ);
 		tracefile_array_commit_seq(stream->tfa);
 		stream->index_received_seqcount++;
 		*flushed = true;
@@ -1188,6 +1189,7 @@ int stream_add_index(struct relay_stream *stream,
 	}
 	ret = relay_index_try_flush(index);
 	if (ret == 0) {
+		tracefile_array_file_rotate(stream->tfa, TRACEFILE_ROTATE_READ);
 		tracefile_array_commit_seq(stream->tfa);
 		stream->index_received_seqcount++;
 		stream->pos_after_last_complete_data_index += index->total_size;
diff --git a/src/bin/lttng-relayd/tracefile-array.c b/src/bin/lttng-relayd/tracefile-array.c
index 20b760c0..3d62317a 100644
--- a/src/bin/lttng-relayd/tracefile-array.c
+++ b/src/bin/lttng-relayd/tracefile-array.c
@@ -62,7 +62,8 @@ void tracefile_array_destroy(struct tracefile_array *tfa)
 	free(tfa);
 }
 
-void tracefile_array_file_rotate(struct tracefile_array *tfa)
+void tracefile_array_file_rotate(struct tracefile_array *tfa,
+		enum tracefile_rotate_type type)
 {
 	uint64_t *headp, *tailp;
 
@@ -70,24 +71,37 @@ void tracefile_array_file_rotate(struct tracefile_array *tfa)
 		/* Not in tracefile rotation mode. */
 		return;
 	}
-	/* Rotate to next file.  */
-	tfa->file_head = (tfa->file_head + 1) % tfa->count;
-	if (tfa->file_head == tfa->file_tail) {
-		/* Move tail. */
-		tfa->file_tail = (tfa->file_tail + 1) % tfa->count;
-	}
-	headp = &tfa->tf[tfa->file_head].seq_head;
-	tailp = &tfa->tf[tfa->file_head].seq_tail;
-	/*
-	 * If we overwrite a file with content, we need to push the tail
-	 * to the position following the content we are overwriting.
-	 */
-	if (*headp != -1ULL) {
-		tfa->seq_tail = tfa->tf[tfa->file_tail].seq_tail;
+	switch (type) {
+	case TRACEFILE_ROTATE_READ:
+		/*
+		 * Rotate read head to write head position, thus allowing
+		 * reader to consume the newly rotated head file.
+		 */
+		tfa->file_head_read = tfa->file_head_write;
+		break;
+	case TRACEFILE_ROTATE_WRITE:
+		/* Rotate write head to next file, pushing tail if needed.  */
+		tfa->file_head_write = (tfa->file_head_write + 1) % tfa->count;
+		if (tfa->file_head_write == tfa->file_tail) {
+			/* Move tail. */
+			tfa->file_tail = (tfa->file_tail + 1) % tfa->count;
+		}
+		headp = &tfa->tf[tfa->file_head_write].seq_head;
+		tailp = &tfa->tf[tfa->file_head_write].seq_tail;
+		/*
+		 * If we overwrite a file with content, we need to push the tail
+		 * to the position following the content we are overwriting.
+		 */
+		if (*headp != -1ULL) {
+			tfa->seq_tail = tfa->tf[tfa->file_tail].seq_tail;
+		}
+		/* Reset this file head/tail (overwrite). */
+		*headp = -1ULL;
+		*tailp = -1ULL;
+		break;
+	default:
+		abort();
 	}
-	/* Reset this file head/tail (overwrite). */
-	*headp = -1ULL;
-	*tailp = -1ULL;
 }
 
 void tracefile_array_commit_seq(struct tracefile_array *tfa)
@@ -104,8 +118,8 @@ void tracefile_array_commit_seq(struct tracefile_array *tfa)
 		/* Not in tracefile rotation mode. */
 		return;
 	}
-	headp = &tfa->tf[tfa->file_head].seq_head;
-	tailp = &tfa->tf[tfa->file_head].seq_tail;
+	headp = &tfa->tf[tfa->file_head_write].seq_head;
+	tailp = &tfa->tf[tfa->file_head_write].seq_tail;
 	/* Update head tracefile seq_head. */
 	*headp = tfa->seq_head;
 	/*
@@ -117,9 +131,9 @@ void tracefile_array_commit_seq(struct tracefile_array *tfa)
 	}
 }
 
-uint64_t tracefile_array_get_file_index_head(struct tracefile_array *tfa)
+uint64_t tracefile_array_get_read_file_index_head(struct tracefile_array *tfa)
 {
-	return tfa->file_head;
+	return tfa->file_head_read;
 }
 
 uint64_t tracefile_array_get_seq_head(struct tracefile_array *tfa)
diff --git a/src/bin/lttng-relayd/tracefile-array.h b/src/bin/lttng-relayd/tracefile-array.h
index 9158f4fe..04d9123d 100644
--- a/src/bin/lttng-relayd/tracefile-array.h
+++ b/src/bin/lttng-relayd/tracefile-array.h
@@ -29,15 +29,30 @@ struct tracefile {
 	uint64_t seq_tail;	/* Oldest seqcount. Inclusive. */
 };
 
+enum tracefile_rotate_type {
+	TRACEFILE_ROTATE_READ,
+	TRACEFILE_ROTATE_WRITE,
+};
+
 /*
  * Represents an array of trace files in a stream.
+ * head is the most recent file/trace packet.
+ * tail is the oldest file/trace packet.
+ *
+ * There are two heads: a "read" head and a "write" head. The "write" head is
+ * the position of the newest data file. The "read" head position is only moved
+ * forward when the index is received.
+ *
+ * The viewer uses the "read" head position as upper bound, which
+ * ensures it never attempts to open a non-existing index file.
  */
 struct tracefile_array {
 	struct tracefile *tf;
 	size_t count;
 
 	/* Current head/tail files. */
-	uint64_t file_head;
+	uint64_t file_head_read;
+	uint64_t file_head_write;
 	uint64_t file_tail;
 
 	/* Overall head/tail seq for the entire array. Inclusive. */
@@ -48,10 +63,10 @@ struct tracefile_array {
 struct tracefile_array *tracefile_array_create(size_t count);
 void tracefile_array_destroy(struct tracefile_array *tfa);
 
-void tracefile_array_file_rotate(struct tracefile_array *tfa);
+void tracefile_array_file_rotate(struct tracefile_array *tfa, enum tracefile_rotate_type type);
 void tracefile_array_commit_seq(struct tracefile_array *tfa);
 
-uint64_t tracefile_array_get_file_index_head(struct tracefile_array *tfa);
+uint64_t tracefile_array_get_read_file_index_head(struct tracefile_array *tfa);
 /* May return -1ULL in the case where we have not received any indexes yet. */
 uint64_t tracefile_array_get_seq_head(struct tracefile_array *tfa);
 
diff --git a/src/bin/lttng-relayd/viewer-stream.c b/src/bin/lttng-relayd/viewer-stream.c
index f41bbe1a..f3baf105 100644
--- a/src/bin/lttng-relayd/viewer-stream.c
+++ b/src/bin/lttng-relayd/viewer-stream.c
@@ -106,7 +106,7 @@ struct relay_viewer_stream *viewer_stream_create(struct relay_stream *stream,
 	}
 	case LTTNG_VIEWER_SEEK_LAST:
 		vstream->current_tracefile_id =
-			tracefile_array_get_file_index_head(stream->tfa);
+			tracefile_array_get_read_file_index_head(stream->tfa);
 		/*
 		 * We seek at the very end of each stream, awaiting for
 		 * a future packet to eventually come in.
-- 
2.17.1
