From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 3/3] Fix: relayd: file rotation and
	live read
Date: Thu,  3 Sep 2015 17:17:30 -0400
Message-ID: <1441315050-17271-3-git-send-email-mathieu.desnoyers__39209.0435409502$1441315379$gmane$org@efficios.com>
References: <1441315050-17271-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZXbtB-00065E-Ao
 for lttng-dev@lists.lttng.org; Thu, 03 Sep 2015 17:18:01 -0400
In-Reply-To: <1441315050-17271-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/Makefile.am       |   3 +-
 src/bin/lttng-relayd/live.c            |  89 +++++++-----------
 src/bin/lttng-relayd/main.c            |  39 ++++----
 src/bin/lttng-relayd/stream.c          |   8 ++
 src/bin/lttng-relayd/stream.h          |  22 +++--
 src/bin/lttng-relayd/tracefile-array.c | 159 +++++++++++++++++++++++++++++++++
 src/bin/lttng-relayd/tracefile-array.h |  63 +++++++++++++
 src/bin/lttng-relayd/viewer-stream.c   |  93 +++++++++----------
 src/bin/lttng-relayd/viewer-stream.h   |  11 ++-
 9 files changed, 349 insertions(+), 138 deletions(-)
 create mode 100644 src/bin/lttng-relayd/tracefile-array.c
 create mode 100644 src/bin/lttng-relayd/tracefile-array.h

diff --git a/src/bin/lttng-relayd/Makefile.am b/src/bin/lttng-relayd/Makefile.am
index 428f352..07eb732 100644
--- a/src/bin/lttng-relayd/Makefile.am
+++ b/src/bin/lttng-relayd/Makefile.am
@@ -19,7 +19,8 @@ lttng_relayd_SOURCES = main.c lttng-relayd.h utils.h utils.c cmd.h \
                        stream.c stream.h \
                        stream-fd.c stream-fd.h \
                        connection.c connection.h \
-                       viewer-session.c viewer-session.h
+                       viewer-session.c viewer-session.h \
+                       tracefile-array.c tracefile-array.h
 
 # link on liblttngctl for check if relayd is already alive.
 lttng_relayd_LDADD = -lrt -lurcu-common -lurcu \
diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index eb57421..7cb1d48 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -1130,7 +1130,7 @@ static int try_open_index(struct relay_viewer_stream *vstream,
 	/*
 	 * First time, we open the index file and at least one index is ready.
 	 */
-	if (rstream->total_index_received == 0) {
+	if (rstream->index_received_seqcount == 0) {
 		ret = -ENOENT;
 		goto end;
 	}
@@ -1172,14 +1172,14 @@ static int check_index_status(struct relay_viewer_stream *vstream,
 	int ret;
 
 	if (trace->session->connection_closed
-			&& rstream->total_index_received
-				== vstream->last_sent_index) {
+			&& rstream->index_received_seqcount
+				== vstream->index_sent_seqcount) {
 		/* Last index sent and session connection is closed. */
 		index->status = htobe32(LTTNG_VIEWER_INDEX_HUP);
 		goto hup;
 	} else if (rstream->beacon_ts_end != -1ULL &&
-			rstream->total_index_received
-				== vstream->last_sent_index) {
+			rstream->index_received_seqcount
+				== vstream->index_sent_seqcount) {
 		/*
 		 * We've received a synchronization beacon and the last index
 		 * available has been sent, the index for now is inactive.
@@ -1193,21 +1193,24 @@ static int check_index_status(struct relay_viewer_stream *vstream,
 		index->timestamp_end = htobe64(rstream->beacon_ts_end);
 		index->stream_id = htobe64(rstream->ctf_stream_id);
 		goto index_ready;
-	} else if (rstream->total_index_received <= vstream->last_sent_index) {
+	} else if (rstream->index_received_seqcount
+			== vstream->index_sent_seqcount) {
 		/*
-		 * This actually checks the case where recv == last_sent.
-		 * In this case, we have not received a beacon. Therefore, we
-		 * can only ask the client to retry later.
+		 * This checks whether received == sent seqcount. In
+		 * this case, we have not received a beacon. Therefore,
+		 * we can only ask the client to retry later.
 		 */
 		index->status = htobe32(LTTNG_VIEWER_INDEX_RETRY);
 		goto index_ready;
-	} else if (!viewer_stream_is_tracefile_seq_readable(vstream,
-			vstream->current_tracefile_seq)) {
+	} else if (!tracefile_array_seq_in_file(rstream->tfa,
+			vstream->current_tracefile_id,
+			vstream->index_sent_seqcount)) {
 		/*
-		 * The producer has overwritten our current file. We
-		 * need to rotate.
+		 * The next index we want to send cannot be read either
+		 * because we need to perform a rotation, or due to
+		 * the producer having overwritten its trace file.
 		 */
-		DBG("Viewer stream %" PRIu64 " rotation due to overwrite",
+		DBG("Viewer stream %" PRIu64 " rotation",
 				vstream->stream->stream_handle);
 		ret = viewer_stream_rotate(vstream);
 		if (ret < 0) {
@@ -1217,50 +1220,22 @@ static int check_index_status(struct relay_viewer_stream *vstream,
 			index->status = htobe32(LTTNG_VIEWER_INDEX_HUP);
 			goto hup;
 		}
-		assert(viewer_stream_is_tracefile_seq_readable(vstream,
-			vstream->current_tracefile_seq));
-		/* ret == 0 means successful so we continue. */
-		ret = 0;
-	} else {
-		ssize_t read_ret;
-		char tmp[1];
-
 		/*
-		 * Use EOF on current index file to find out when we
-		 * need to rotate.
+		 * If we have been pushed due to overwrite, it
+		 * necessarily means there is data that can be read in
+		 * the stream. If we rotated because we reached the end
+		 * of a tracefile, it means the following tracefile
+		 * needs to contain at least one index, else we would
+		 * have already returned LTTNG_VIEWER_INDEX_RETRY to the
+		 * viewer. The updated index_sent_seqcount needs to
+		 * point to a readable index entry now.
 		 */
-		read_ret = lttng_read(vstream->index_fd->fd, tmp, 1);
-		if (read_ret == 1) {
-			off_t seek_ret;
-
-			/* There is still data to read. Rewind position. */
-			seek_ret = lseek(vstream->index_fd->fd, -1, SEEK_CUR);
-			if (seek_ret < 0) {
-				ret = -1;
-				goto end;
-			}
-			ret = 0;
-		} else if (read_ret == 0) {
-			/* EOF. We need to rotate. */
-			DBG("Viewer stream %" PRIu64 " rotation due to EOF",
-					vstream->stream->stream_handle);
-			ret = viewer_stream_rotate(vstream);
-			if (ret < 0) {
-				goto end;
-			} else if (ret == 1) {
-				/* EOF across entire stream. */
-				index->status = htobe32(LTTNG_VIEWER_INDEX_HUP);
-				goto hup;
-			}
-			assert(viewer_stream_is_tracefile_seq_readable(vstream,
-				vstream->current_tracefile_seq));
-			/* ret == 0 means successful so we continue. */
-			ret = 0;
-		} else {
-			/* Error reading index. */
-			ret = -1;
-		}
+		assert(tracefile_array_seq_in_file(rstream->tfa,
+			vstream->current_tracefile_id,
+			vstream->index_sent_seqcount));
 	}
+	/* ret == 0 means successful so we continue. */
+	ret = 0;
 end:
 	return ret;
 
@@ -1409,7 +1384,7 @@ int viewer_get_next_index(struct relay_connection *conn)
 		goto send_reply;
 	} else {
 		viewer_index.status = htobe32(LTTNG_VIEWER_INDEX_OK);
-		vstream->last_sent_index++;
+		vstream->index_sent_seqcount++;
 	}
 
 	/*
@@ -1456,7 +1431,7 @@ send_reply:
 
 	if (vstream) {
 		DBG("Index %" PRIu64 " for stream %" PRIu64 " sent",
-				vstream->last_sent_index,
+				vstream->index_sent_seqcount,
 				vstream->stream->stream_handle);
 	}
 end:
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index adb044f..7b385b4 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -71,6 +71,7 @@
 #include "session.h"
 #include "stream.h"
 #include "connection.h"
+#include "tracefile-array.h"
 
 /* command line options */
 char *opt_output_path;
@@ -1890,7 +1891,7 @@ static int relay_recv_index(struct lttcomm_relayd_hdr *recv_hdr,
 		 * Only flag a stream inactive when it has already
 		 * received data and no indexes are in flight.
 		 */
-		if (stream->total_index_received > 0
+		if (stream->index_received_seqcount > 0
 				&& stream->indexes_in_flight == 0) {
 			stream->beacon_ts_end =
 				be64toh(index_info.timestamp_end);
@@ -1918,7 +1919,8 @@ static int relay_recv_index(struct lttcomm_relayd_hdr *recv_hdr,
 	}
 	ret = relay_index_try_flush(index);
 	if (ret == 0) {
-		stream->total_index_received++;
+		tracefile_array_commit_seq(stream->tfa);
+		stream->index_received_seqcount++;
 	} else if (ret > 0) {
 		/* no flush. */
 		ret = 0;
@@ -2091,7 +2093,7 @@ static int handle_index_data(struct relay_stream *stream, uint64_t net_seq_num,
 
 		fd = index_create_file(stream->path_name, stream->channel_name,
 			        -1, -1, stream->tracefile_size,
-				stream->current_tracefile_id);
+				tracefile_array_get_file_index_head(stream->tfa));
 		if (fd < 0) {
 			ret = -1;
 			/* Put self-ref for this index due to error. */
@@ -2120,7 +2122,8 @@ static int handle_index_data(struct relay_stream *stream, uint64_t net_seq_num,
 
 	ret = relay_index_try_flush(index);
 	if (ret == 0) {
-		stream->total_index_received++;
+		tracefile_array_commit_seq(stream->tfa);
+		stream->index_received_seqcount++;
 	} else if (ret > 0) {
 		/* No flush. */
 		ret = 0;
@@ -2204,35 +2207,23 @@ static int relay_process_data(struct relay_connection *conn)
 	if (stream->tracefile_size > 0 &&
 			(stream->tracefile_size_current + data_size) >
 			stream->tracefile_size) {
-		uint64_t new_id;
+		uint64_t old_id, new_id;
+
+		old_id = tracefile_array_get_file_index_head(stream->tfa);
+		tracefile_array_file_rotate(stream->tfa);
+
+		/* new_id is updated by utils_rotate_stream_file. */
+		new_id = old_id;
 
-		new_id = (stream->current_tracefile_id + 1) %
-			stream->tracefile_count;
-		/*
-		 * Move viewer oldest available data position forward if
-		 * we are overwriting a tracefile.
-		 */
-		if (new_id == stream->oldest_tracefile_id) {
-			stream->oldest_tracefile_id =
-				(stream->oldest_tracefile_id + 1) %
-				stream->tracefile_count;
-		}
 		ret = utils_rotate_stream_file(stream->path_name,
 				stream->channel_name, stream->tracefile_size,
 				stream->tracefile_count, -1,
 			        -1, stream->stream_fd->fd,
-				&stream->current_tracefile_id,
-				&stream->stream_fd->fd);
+				&new_id, &stream->stream_fd->fd);
 		if (ret < 0) {
 			ERR("Rotating stream output file");
 			goto end_stream_unlock;
 		}
-		stream->current_tracefile_seq++;
-		if (stream->current_tracefile_seq
-			- stream->oldest_tracefile_seq >=
-				stream->tracefile_count) {
-			stream->oldest_tracefile_seq++;
-		}
 		/*
 		 * Reset current size because we just performed a stream
 		 * rotation.
diff --git a/src/bin/lttng-relayd/stream.c b/src/bin/lttng-relayd/stream.c
index 9fd9dce..870b75a 100644
--- a/src/bin/lttng-relayd/stream.c
+++ b/src/bin/lttng-relayd/stream.c
@@ -137,6 +137,11 @@ struct relay_stream *stream_create(struct ctf_trace *trace,
 		ret = -1;
 		goto end;
 	}
+	stream->tfa = tracefile_array_create(stream->tracefile_count);
+	if (!stream->tfa) {
+		ret = -1;
+		goto end;
+	}
 	if (stream->tracefile_size) {
 		DBG("Tracefile %s/%s_0 created", stream->path_name, stream->channel_name);
 	} else {
@@ -241,6 +246,9 @@ static void stream_destroy(struct relay_stream *stream)
 	if (stream->indexes_ht) {
 		lttng_ht_destroy(stream->indexes_ht);
 	}
+	if (stream->tfa) {
+		tracefile_array_destroy(stream->tfa);
+	}
 	free(stream->path_name);
 	free(stream->channel_name);
 	free(stream);
diff --git a/src/bin/lttng-relayd/stream.h b/src/bin/lttng-relayd/stream.h
index 7e2b133..419111c 100644
--- a/src/bin/lttng-relayd/stream.h
+++ b/src/bin/lttng-relayd/stream.h
@@ -29,6 +29,7 @@
 
 #include "session.h"
 #include "stream-fd.h"
+#include "tracefile-array.h"
 
 /*
  * Represents a stream in the relay
@@ -67,15 +68,22 @@ struct relay_stream {
 	uint64_t tracefile_size;
 	uint64_t tracefile_size_current;
 	uint64_t tracefile_count;
-	uint64_t current_tracefile_id;
 
-	uint64_t current_tracefile_seq;	/* Free-running counter. */
-	uint64_t oldest_tracefile_seq;	/* Free-running counter. */
-
-	/* To inform the viewer up to where it can go back in time. */
-	uint64_t oldest_tracefile_id;
+	/*
+	 * Counts the number of received indexes. The "tag" associated
+	 * with an index is taken before incrementing this seqcount.
+	 * Therefore, the sequence tag associated with the last index
+	 * received is always index_received_seqcount - 1.
+	 */
+	uint64_t index_received_seqcount;
 
-	uint64_t total_index_received;
+	/*
+	 * Tracefile array is an index of the stream trace files,
+	 * indexed by position. It allows keeping track of the oldest
+	 * available indexes when overwriting trace files in tracefile
+	 * rotation. It is left NULL when tracefile rotation is unused.
+	 */
+	struct tracefile_array *tfa;
 
 	bool closed;	/* Stream is closed. */
 
diff --git a/src/bin/lttng-relayd/tracefile-array.c b/src/bin/lttng-relayd/tracefile-array.c
new file mode 100644
index 0000000..7ab1f8e
--- /dev/null
+++ b/src/bin/lttng-relayd/tracefile-array.c
@@ -0,0 +1,159 @@
+/*
+ * Copyright (C) 2015 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License, version 2 only, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 51
+ * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#define _GNU_SOURCE
+#define _LGPL_SOURCE
+#include <assert.h>
+#include <common/common.h>
+#include <common/utils.h>
+#include <common/defaults.h>
+
+#include "tracefile-array.h"
+
+struct tracefile_array *tracefile_array_create(size_t count)
+{
+	struct tracefile_array *tfa = NULL;
+	int i;
+
+	tfa = zmalloc(sizeof(*tfa));
+	if (!tfa) {
+		goto error;
+	}
+	tfa->tf = zmalloc(sizeof(*tfa->tf) * count);
+	if (!tfa->tf) {
+		goto error;
+	}
+	tfa->count = count;
+	for (i = 0; i < count; i++) {
+		tfa->tf[i].seq_head = -1ULL;
+		tfa->tf[i].seq_tail = -1ULL;
+	}
+	tfa->seq_head = -1ULL;
+	tfa->seq_tail = -1ULL;
+	return tfa;
+
+error:
+	if (tfa) {
+		free(tfa->tf);
+	}
+	free(tfa);
+	return NULL;
+}
+
+void tracefile_array_destroy(struct tracefile_array *tfa)
+{
+	if (!tfa) {
+		return;
+	}
+	free(tfa->tf);
+	free(tfa);
+}
+
+void tracefile_array_file_rotate(struct tracefile_array *tfa)
+{
+	uint64_t *headp, *tailp;
+
+	if (tfa->count <= 1) {
+		return;
+	}
+	/* Rotate to next file.  */
+	tfa->file_head = (tfa->file_head + 1) % tfa->count;
+	if (tfa->file_head == tfa->file_tail) {
+		/* Move tail. */
+		tfa->file_tail = (tfa->file_tail + 1) % tfa->count;
+	}
+	headp = &tfa->tf[tfa->file_head].seq_head;
+	tailp = &tfa->tf[tfa->file_head].seq_tail;
+	/*
+	 * If we overwrite a file with content, we need to push the tail
+	 * to the position following the content we are overwriting.
+	 */
+	if (*headp != -1ULL) {
+		tfa->seq_tail = tfa->tf[tfa->file_tail].seq_tail;
+	}
+	/* Reset this file head/tail (overwrite). */
+	*headp = -1ULL;
+	*tailp = -1ULL;
+}
+
+void tracefile_array_commit_seq(struct tracefile_array *tfa)
+{
+	uint64_t *headp, *tailp;
+
+	/* Increment overall head. */
+	tfa->seq_head++;
+	/* If we are committing our first index overall, set tail to 0. */
+	if (tfa->seq_tail == -1ULL) {
+		tfa->seq_tail = 0;
+	}
+	if (tfa->count <= 1) {
+		return;
+	}
+	headp = &tfa->tf[tfa->file_head].seq_head;
+	tailp = &tfa->tf[tfa->file_head].seq_tail;
+	/* Update head tracefile seq_head. */
+	*headp = tfa->seq_head;
+	/*
+	 * If we are committing our first index in this packet, set tail
+	 * to this index seq count.
+	 */
+	if (*tailp == -1ULL) {
+		*tailp = tfa->seq_head;
+	}
+}
+
+uint64_t tracefile_array_get_file_index_head(struct tracefile_array *tfa)
+{
+	return tfa->file_head;
+}
+
+uint64_t tracefile_array_get_seq_head(struct tracefile_array *tfa)
+{
+	return tfa->seq_head;
+}
+
+uint64_t tracefile_array_get_file_index_tail(struct tracefile_array *tfa)
+{
+	return tfa->file_tail;
+}
+
+uint64_t tracefile_array_get_seq_tail(struct tracefile_array *tfa)
+{
+	return tfa->seq_tail;
+}
+
+bool tracefile_array_seq_in_file(struct tracefile_array *tfa,
+		uint64_t file_index, uint64_t seq)
+{
+	if (tfa->count <= 1) {
+		/*
+		 * With a single file, we are guaranteed to have the
+		 * index in this file.
+		 */
+		return true;
+	}
+	assert(file_index < tfa->count);
+	if (seq == -1ULL) {
+		return false;
+	}
+	if (seq >= tfa->tf[file_index].seq_tail
+			&& seq <= tfa->tf[file_index].seq_head) {
+		return true;
+	} else {
+		return false;
+	}
+}
diff --git a/src/bin/lttng-relayd/tracefile-array.h b/src/bin/lttng-relayd/tracefile-array.h
new file mode 100644
index 0000000..c947078
--- /dev/null
+++ b/src/bin/lttng-relayd/tracefile-array.h
@@ -0,0 +1,63 @@
+#ifndef _TRACEFILE_ARRAY_H
+#define _TRACEFILE_ARRAY_H
+
+/*
+ * Copyright (C) 2015 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License, version 2 only, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 51
+ * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <limits.h>
+#include <inttypes.h>
+#include <pthread.h>
+#include <stdbool.h>
+
+struct tracefile {
+	/* Per-tracefile head/tail seq. */
+	uint64_t seq_head;	/* Newest seqcount. Inclusive. */
+	uint64_t seq_tail;	/* Oldest seqcount. Inclusive. */
+};
+
+/*
+ * Represents an array of trace files in a stream.
+ */
+struct tracefile_array {
+	struct tracefile *tf;
+	size_t count;
+
+	/* Current head/tail files. */
+	uint64_t file_head;
+	uint64_t file_tail;
+
+	/* Overall head/tail seq for the entire array. Inclusive. */
+	uint64_t seq_head;
+	uint64_t seq_tail;
+};
+
+struct tracefile_array *tracefile_array_create(size_t count);
+void tracefile_array_destroy(struct tracefile_array *tfa);
+
+void tracefile_array_file_rotate(struct tracefile_array *tfa);
+void tracefile_array_commit_seq(struct tracefile_array *tfa);
+
+uint64_t tracefile_array_get_file_index_head(struct tracefile_array *tfa);
+uint64_t tracefile_array_get_seq_head(struct tracefile_array *tfa);
+
+uint64_t tracefile_array_get_file_index_tail(struct tracefile_array *tfa);
+uint64_t tracefile_array_get_seq_tail(struct tracefile_array *tfa);
+
+bool tracefile_array_seq_in_file(struct tracefile_array *tfa,
+		uint64_t file_index, uint64_t seq);
+
+#endif /* _STREAM_H */
diff --git a/src/bin/lttng-relayd/viewer-stream.c b/src/bin/lttng-relayd/viewer-stream.c
index 1d02ee3..31b0257 100644
--- a/src/bin/lttng-relayd/viewer-stream.c
+++ b/src/bin/lttng-relayd/viewer-stream.c
@@ -63,29 +63,45 @@ struct relay_viewer_stream *viewer_stream_create(struct relay_stream *stream,
 		goto error;
 	}
 
+	if (!stream_get(stream)) {
+		ERR("Cannot get stream");
+		goto error;
+	}
+	vstream->stream = stream;
+
+	pthread_mutex_lock(&stream->lock);
+
+	if (stream->is_metadata && stream->trace->viewer_metadata_stream) {
+		ERR("Cannot attach viewer metadata stream to trace (busy).");
+		goto error_unlock;
+	}
+
 	switch (seek_t) {
 	case LTTNG_VIEWER_SEEK_BEGINNING:
-		vstream->current_tracefile_id = stream->oldest_tracefile_id;
+		vstream->current_tracefile_id =
+			tracefile_array_get_file_index_tail(stream->tfa);
+		vstream->index_sent_seqcount =
+			tracefile_array_get_seq_tail(stream->tfa);
 		break;
 	case LTTNG_VIEWER_SEEK_LAST:
-		vstream->current_tracefile_id = stream->current_tracefile_id;
+		vstream->current_tracefile_id =
+			tracefile_array_get_file_index_head(stream->tfa);
+		/*
+		 * We seek at the very end of each stream, awaiting for
+		 * a future packet to eventually come in.
+		 */
+		vstream->index_sent_seqcount =
+			tracefile_array_get_seq_head(stream->tfa) + 1;
 		break;
 	default:
-		goto error;
-	}
-	if (!stream_get(stream)) {
-		ERR("Cannot get stream");
-		goto error;
+		goto error_unlock;
 	}
-	vstream->stream = stream;
 
-	pthread_mutex_lock(&stream->lock);
 	/*
-	 * If we never received an index for the current stream, delay the opening
-	 * of the index, otherwise open it right now.
+	 * If we never received an index for the current stream, delay
+	 * the opening of the index, otherwise open it right now.
 	 */
-	if (vstream->current_tracefile_id == stream->current_tracefile_id
-			&& stream->total_index_received == 0) {
+	if (stream->index_received_seqcount == 0) {
 		vstream->index_fd = NULL;
 	} else {
 		int read_fd;
@@ -112,14 +128,12 @@ struct relay_viewer_stream *viewer_stream_create(struct relay_stream *stream,
 		if (lseek_ret < 0) {
 			goto error_unlock;
 		}
-		vstream->last_sent_index = stream->total_index_received;
 	}
-	pthread_mutex_unlock(&stream->lock);
-
 	if (stream->is_metadata) {
 		rcu_assign_pointer(stream->trace->viewer_metadata_stream,
 				vstream);
 	}
+	pthread_mutex_unlock(&stream->lock);
 
 	/* Globally visible after the add unique. */
 	lttng_ht_node_init_u64(&vstream->stream_n, stream->stream_handle);
@@ -227,26 +241,6 @@ void viewer_stream_put(struct relay_viewer_stream *vstream)
 }
 
 /*
- * Returns whether the current tracefile is readable. If not, it has
- * been overwritten.
- * Must be called with rstream lock held.
- */
-bool viewer_stream_is_tracefile_seq_readable(struct relay_viewer_stream *vstream,
-		 uint64_t seq)
-{
-	struct relay_stream *stream = vstream->stream;
-
-	if (seq >= stream->oldest_tracefile_seq
-			&& seq <= stream->current_tracefile_seq) {
-		/* seq is a readable file. */
-		return true;
-	} else {
-		/* seq is not readable. */
-		return false;
-	}
-}
-
-/*
  * Rotate a stream to the next tracefile.
  *
  * Must be called with the rstream lock held.
@@ -256,9 +250,11 @@ int viewer_stream_rotate(struct relay_viewer_stream *vstream)
 {
 	int ret;
 	struct relay_stream *stream = vstream->stream;
+	uint64_t new_id;
 
 	/* Detect the last tracefile to open. */
-	if (stream->total_index_received == vstream->last_sent_index
+	if (stream->index_received_seqcount
+			== vstream->index_sent_seqcount
 			&& stream->trace->session->connection_closed) {
 		ret = 1;
 		goto end;
@@ -270,17 +266,22 @@ int viewer_stream_rotate(struct relay_viewer_stream *vstream)
 		goto end;
 	}
 
-	if (!viewer_stream_is_tracefile_seq_readable(vstream,
-			vstream->current_tracefile_seq + 1)) {
-		vstream->current_tracefile_id =
-				stream->oldest_tracefile_id;
-		vstream->current_tracefile_seq =
-				stream->oldest_tracefile_seq;
+	/*
+	 * Try to move to the next file.
+	 */
+	new_id = (vstream->current_tracefile_id + 1)
+			% stream->tracefile_count;
+	if (tracefile_array_seq_in_file(stream->tfa, new_id,
+			vstream->index_sent_seqcount)) {
+		vstream->current_tracefile_id = new_id;
 	} else {
+		/*
+		 * We need to resync because we lag behind tail.
+		 */
 		vstream->current_tracefile_id =
-				(vstream->current_tracefile_id + 1)
-					% stream->tracefile_count;
-		vstream->current_tracefile_seq++;
+			tracefile_array_get_file_index_tail(stream->tfa);
+		vstream->index_sent_seqcount =
+			tracefile_array_get_seq_tail(stream->tfa);
 	}
 
 	if (vstream->index_fd) {
diff --git a/src/bin/lttng-relayd/viewer-stream.h b/src/bin/lttng-relayd/viewer-stream.h
index cc46db4..5dc135d 100644
--- a/src/bin/lttng-relayd/viewer-stream.h
+++ b/src/bin/lttng-relayd/viewer-stream.h
@@ -59,10 +59,15 @@ struct relay_viewer_stream {
 	char *channel_name;
 
 	uint64_t current_tracefile_id;
-	/* Free-running counter. */
-	uint64_t current_tracefile_seq;
 
-	uint64_t last_sent_index;
+	/*
+	 * Counts the number of sent indexes. The "tag" associated
+	 * with an index to send is the current index_received_seqcount,
+	 * because we increment index_received_seqcount after sending
+	 * each index. This index_received_seqcount counter can also be
+	 * updated when catching up with the producer.
+	 */
+	uint64_t index_sent_seqcount;
 
 	/* Indicates if this stream has been sent to a viewer client. */
 	bool sent_flag;
-- 
2.1.4
