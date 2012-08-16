From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH v2] Add BT_SEEK_LAST type to
	bt_iter_pos
Date: Thu, 16 Aug 2012 17:48:07 -0400
Message-ID: <1345153687-15832-1-git-send-email-jdesfossez__4965.6413183131$1345153733$gmane$org@efficios.com>
References: <1345140842-21819-1-git-send-email-francis.deslauriers@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1T27vZ-0005rx-5O
	for lttng-dev@lists.lttng.org; Thu, 16 Aug 2012 17:48:29 -0400
In-Reply-To: <1345140842-21819-1-git-send-email-francis.deslauriers@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

From: Francis Deslauriers <francis.deslauriers@polymtl.ca>

Signed-off-by: Francis Deslauriers <francis.deslauriers@polymtl.ca>
Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 include/babeltrace/iterator.h |    1 +
 lib/iterator.c                |  207 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 208 insertions(+)

diff --git a/include/babeltrace/iterator.h b/include/babeltrace/iterator.h
index aa6470e..c8edbd1 100644
--- a/include/babeltrace/iterator.h
+++ b/include/babeltrace/iterator.h
@@ -48,6 +48,7 @@ struct bt_iter_pos {
 		BT_SEEK_CUR,
 		BT_SEEK_BEGIN,
 		BT_SEEK_END,
+		BT_SEEK_LAST
 	} type;
 	union {
 		uint64_t seek_time;
diff --git a/lib/iterator.c b/lib/iterator.c
index f5f413e..16b54bc 100644
--- a/lib/iterator.c
+++ b/lib/iterator.c
@@ -187,6 +187,193 @@ static int seek_ctf_trace_by_timestamp(struct ctf_trace *tin,
 	return found ? 0 : EOF;
 }
 
+int seek_last_element_ctf_file_stream(struct trace_collection *tc,
+		struct ctf_file_stream **cfs, int max_packet,
+		int max_stream_id, int max_stream_class_id,
+		int max_trace_descriptor_id, uint64_t max_timestamp)
+{
+	struct trace_descriptor *max_td_read;
+	struct ctf_trace *max_tin;
+	struct ctf_stream_declaration *max_stream_class;
+	struct ctf_stream_definition *max_stream;
+	struct ctf_stream_pos *max_stream_pos;
+	int ret;
+
+	if (!tc)
+		return -EINVAL;
+
+	/* get the targeted trace descriptor */
+	max_td_read = g_ptr_array_index(tc->array, max_trace_descriptor_id);
+	max_tin = container_of(max_td_read, struct ctf_trace, parent);
+
+	/* get targeted stream class */
+	max_stream_class = g_ptr_array_index(max_tin->streams,
+						max_stream_class_id);
+	/* get targeted stream */
+	max_stream = g_ptr_array_index(max_stream_class->streams,
+					max_stream_id);
+	*cfs = container_of(max_stream, struct ctf_file_stream, parent);
+	max_stream_pos = &(*cfs)->pos;
+
+	/* we seek to the last packet of the stream. */
+	max_stream_pos->packet_seek(&max_stream_pos->parent,
+			max_packet, SEEK_SET);
+	/*
+	 * iterate over all the event until we reach on that
+	 * his timestamp correspond with the max saved previously.
+	 */
+	do {
+		ret = stream_read_event(*cfs);
+	} while ((*cfs)->parent.real_timestamp != max_timestamp && ret == 0);
+
+	/* insert the stream in the heap */
+	return ret;
+}
+
+int find_last_event(struct ctf_file_stream *cfs, uint64_t *timestamp_end,
+		int *packet)
+{
+	struct ctf_stream_pos *stream_pos;
+	uint64_t tmp = 0;
+	int ret = 0;
+	int count = 0;
+	int event_read = 0;
+	int i;
+
+	if (!cfs)
+		return -EINVAL;
+
+	stream_pos = &cfs->pos;
+	/*
+	 * we start by the last packet as the current one.
+	 * If the current one is empty we go back one packet if possible.
+	 */
+	for (i = stream_pos->packet_real_index->len - 1; i >= 0; i--) {
+		stream_pos->packet_seek(&stream_pos->parent, i, SEEK_SET);
+		count = 0;
+		/* read each event until we reach the end of the packet */
+		do {
+			tmp = cfs->parent.real_timestamp;
+			ret = stream_read_event(cfs);
+			count++;
+		} while (ret == 0);
+
+		if (count > 1)
+			event_read = 1;
+		/*
+		 * Check if we have read at least one event before
+		 * reaching the end of file.
+		 */
+		if (ret == EOF && count > 1) {
+			*timestamp_end = tmp;
+			*packet = i;
+			break;
+		}
+		/* Error */
+		else if (ret > 0) {
+			return ret;
+		}
+	}
+
+	/* Check if we read at least one event on the stream */
+	if (!event_read) {
+		return 1;
+	}
+	return 0;
+}
+
+int find_max_timestamp_ctf_file_stream(
+		struct ctf_stream_declaration *stream_class, int *max_stream_id,
+		int *packet, uint64_t *max_timestamp, int *new_max)
+{
+	struct ctf_file_stream *cfs;
+	uint64_t savedtime;
+	int i;
+	int max_packet = 0;
+	int ret = 0;
+	int error = 1;
+
+	for (i = 0; i < stream_class->streams->len; i++) {
+		struct ctf_stream_definition *stream;
+
+		stream = g_ptr_array_index(stream_class->streams, i);
+		if (!stream)
+			continue;
+		cfs = container_of(stream, struct ctf_file_stream, parent);
+		ret = find_last_event(cfs, &savedtime, &max_packet);
+		/* Can return either EOF, 0, or error (> 0). */
+		if (ret == 0 && savedtime >= *max_timestamp) {
+			*new_max = 1;
+			*max_stream_id = i;
+			*packet = max_packet;
+			*max_timestamp = savedtime;
+		}
+		error = error & ret;
+	}
+
+	return error;
+}
+
+int seek_last_ctf_file_stream(struct trace_collection *tc,
+				struct ctf_file_stream **cfs)
+{
+	uint64_t max_timestamp = 0;
+	int i, j;
+	int ret;
+	int found = 0;
+	int new_max_found;
+	int max_packet;
+	int max_stream_id;
+	int max_stream_class_id;
+	int max_trace_descriptor_id;
+
+	if (!tc)
+		return -EINVAL;
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
+			/* For each file_stream in the stream_class */
+			new_max_found = 0;
+			ret = find_max_timestamp_ctf_file_stream(stream_class,
+					&max_stream_id, &max_packet,
+					&max_timestamp, &new_max_found);
+			if (!ret && new_max_found) {
+				found = 1;
+				max_trace_descriptor_id = i;
+				max_stream_class_id = j;
+			}
+		}
+	}
+	/*
+	 * Now we know in which trace, stream_class and stream is the
+	 * last event of the trace_collection.
+	 * We can seek to this targeted event.
+	 */
+	if (!found) {
+		ret = -1;
+	} else {
+		ret = seek_last_element_ctf_file_stream(tc, cfs, max_packet,
+				max_stream_id, max_stream_class_id,
+				max_trace_descriptor_id, max_timestamp);
+	}
+
+	return ret;
+}
+
 int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
 {
 	struct trace_collection *tc;
@@ -329,6 +516,26 @@ int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
 			}
 		}
 		break;
+	case BT_SEEK_LAST:
+	{
+		struct ctf_file_stream *cfs;
+
+		tc = iter->ctx->tc;
+		ret = seek_last_ctf_file_stream(tc, &cfs);
+		if (ret < 0)
+			goto error;
+
+		/* remove all stream from the heap*/
+		heap_free(iter->stream_heap);
+		/* Create a new empty heap*/
+		ret = heap_init(iter->stream_heap, 0, stream_compare);
+		if (ret < 0)
+			goto error;
+		/*Insert the stream that contains the last event.*/
+		heap_insert(iter->stream_heap, cfs);
+
+		return 0;
+	}
 	default:
 		/* not implemented */
 		return -EINVAL;
-- 
1.7.10.4
