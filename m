From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [BABELTRACE PATCH v4] Add BT_SEEK_LAST type to
	bt_iter_pos
Date: Thu, 16 Aug 2012 21:30:36 -0400
Message-ID: <20120817013036.GB6294__37259.4289984137$1345167064$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T2BOY-0007W8-1C
	for lttng-dev@lists.lttng.org; Thu, 16 Aug 2012 21:30:38 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: francis.deslauriers@polymtl.ca, Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Inspired from patch by Francis Deslauriers and Julien Desfossez.

Comments are welcome. I left a FIXME as question.

Not tested.

Not-Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/include/babeltrace/iterator.h b/include/babeltrace/iterator.h
index aa6470e..98504a5 100644
--- a/include/babeltrace/iterator.h
+++ b/include/babeltrace/iterator.h
@@ -40,6 +40,15 @@ struct bt_saved_pos;
  *   is expressed in nanoseconds
  * - restore is a position saved with bt_iter_get_pos, it is used with
  *   BT_SEEK_RESTORE.
+ *
+ * Note about BT_SEEK_LAST: if many events happen to be at the last
+ * timestamp, it is implementation-defined which event will be the last,
+ * and the order of events with the same timestamp may not be the same
+ * as normal iteration on the trace. Therefore, it is recommended to
+ * only use BT_SEEK_LAST to get the timestamp of the last event(s) in
+ * the trace.
+ * FIXME: should we name it BT_SEEK_LAST_TIMESTAMP instead, if we ever
+ * want to keep BT_SEEK_LAST for the last event in iteration order ?
  */
 struct bt_iter_pos {
 	enum {
@@ -48,6 +57,7 @@ struct bt_iter_pos {
 		BT_SEEK_CUR,
 		BT_SEEK_BEGIN,
 		BT_SEEK_END,
+		BT_SEEK_LAST,
 	} type;
 	union {
 		uint64_t seek_time;
diff --git a/lib/iterator.c b/lib/iterator.c
index 2dbd77c..b305f16 100644
--- a/lib/iterator.c
+++ b/lib/iterator.c
@@ -103,6 +103,10 @@ void bt_iter_free_pos(struct bt_iter_pos *iter_pos)
  *
  * Return 0 if the seek succeded, EOF if we didn't find any packet
  * containing the timestamp, or a positive integer for error.
+ *
+ * TODO: this should be turned into a binary search! It is currently
+ * doing a linear search in the packets. This is a O(n) operation on a
+ * very frequent code path.
  */
 static int seek_file_stream_by_timestamp(struct ctf_file_stream *cfs,
 		uint64_t timestamp)
@@ -187,6 +191,148 @@ static int seek_ctf_trace_by_timestamp(struct ctf_trace *tin,
 	return found ? 0 : EOF;
 }
 
+/*
+ * Find timestamp of last event in the stream.
+ *
+ * Return value: 0 if OK, positive error value on error, EOF if no
+ * events were found.
+ */
+static int find_max_timestamp_ctf_file_stream(struct ctf_file_stream *cfs,
+		uint64_t *timestamp_end)
+{
+	int ret, count = 0, i;
+	uint64_t timestamp = 0;
+	struct ctf_stream_pos *stream_pos;
+
+	stream_pos = &cfs->pos;
+	/*
+	 * We start by the last packet, and iterate backwards until we
+	 * either find at least one event, or we reach the first packet
+	 * (some packets can be empty).
+	 */
+	for (i = stream_pos->packet_real_index->len - 1; i >= 0; i--) {
+		stream_pos->packet_seek(&stream_pos->parent, i, SEEK_SET);
+		count = 0;
+		/* read each event until we reach the end of the stream */
+		do {
+			ret = stream_read_event(cfs);
+			if (ret == 0) {
+				count++;
+				timestamp = cfs->parent.real_timestamp;
+			}
+		} while (ret == 0);
+
+		/* Error */
+		if (ret > 0)
+			goto end;
+		assert(ret == EOF);
+		if (count)
+			break;
+	}
+
+	if (count) {
+		*timestamp_end = timestamp;
+		ret = 0;
+	} else {
+		/* Return EOF if no events were found */
+		ret = EOF;
+	}
+end:
+	return ret;
+}
+
+/*
+ * Find the stream within a stream class that contains the event with
+ * the largest timestamp, and save that timestamp.
+ *
+ * Return 0 if OK, EOF if no events were found in the streams, or
+ * positive value on error.
+ */
+static int find_max_timestamp_ctf_stream_class(
+		struct ctf_stream_declaration *stream_class,
+		struct ctf_file_stream **cfsp,
+		uint64_t *max_timestamp)
+{
+	int ret = EOF, i;
+
+	for (i = 0; i < stream_class->streams->len; i++) {
+		struct ctf_stream_definition *stream;
+		struct ctf_file_stream *cfs;
+		uint64_t current_max_ts = 0;
+
+		stream = g_ptr_array_index(stream_class->streams, i);
+		if (!stream)
+			continue;
+		cfs = container_of(stream, struct ctf_file_stream, parent);
+		ret = find_max_timestamp_ctf_file_stream(cfs, &current_max_ts);
+		if (ret == EOF)
+			continue;
+		if (ret != 0)
+			break;
+		if (current_max_ts >= *max_timestamp) {
+			*max_timestamp = current_max_ts;
+			*cfsp = cfs;
+		}
+	}
+	assert(ret >= 0 || ret == EOF);
+	return ret;
+}
+
+/*
+ * seek_last_ctf_trace_collection: seek trace collection to last event.
+ *
+ * Return 0 if OK, EOF if no events were found, or positive error value
+ * on error.
+ */
+static int seek_last_ctf_trace_collection(struct trace_collection *tc,
+		struct ctf_file_stream **cfsp)
+{
+	int i, j, ret;
+	int found = 0;
+	uint64_t max_timestamp = 0;
+
+	if (!tc)
+		return 1;
+
+	/* For each trace in the trace_collection */
+	for (i = 0; i < tc->array->len; i++) {
+		struct ctf_trace *tin;
+		struct trace_descriptor *td_read;
+
+		td_read = g_ptr_array_index(tc->array, i);
+		if (!td_read)
+			continue;
+		tin = container_of(td_read, struct ctf_trace, parent);
+		/* For each stream_class in the trace */
+		for (j = 0; j < tin->streams->len; j++) {
+			struct ctf_stream_declaration *stream_class;
+
+			stream_class = g_ptr_array_index(tin->streams, j);
+			if (!stream_class)
+				continue;
+			ret = find_max_timestamp_ctf_stream_class(stream_class,
+					cfsp, &max_timestamp);
+			if (ret > 0)
+				goto end;
+			if (ret == 0)
+				found = 1;
+			assert(ret == EOF || ret == 0);
+		}
+	}
+	/*
+	 * Now we know in which file stream the last event is located,
+	 * and we know its timestamp.
+	 */
+	if (!found) {
+		ret = EOF;
+	} else {
+		ret = seek_file_stream_by_timestamp(*cfsp, max_timestamp);
+		assert(ret == 0);
+	}
+end:
+	return ret;
+}
+
 int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
 {
 	struct trace_collection *tc;
@@ -332,6 +478,25 @@ int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
 			}
 		}
 		break;
+	case BT_SEEK_LAST:
+	{
+		struct ctf_file_stream *cfs;
+
+		tc = iter->ctx->tc;
+		ret = seek_last_ctf_trace_collection(tc, &cfs);
+		if (ret != 0)
+			goto error;
+		/* remove all streams from the heap */
+		heap_free(iter->stream_heap);
+		/* Create a new empty heap */
+		ret = heap_init(iter->stream_heap, 0, stream_compare);
+		if (ret < 0)
+			goto error;
+		/* Insert the stream that contains the last event */
+		ret = heap_insert(iter->stream_heap, cfs);
+		if (ret)
+			goto error;
+	}
 	default:
 		/* not implemented */
 		return -EINVAL;
-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
