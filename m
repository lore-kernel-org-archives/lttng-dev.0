From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 2/2] Fix: handle packet_seek errors
Date: Tue, 18 Aug 2015 16:36:18 -0700
Message-ID: <1439940978-3953-2-git-send-email-mathieu.desnoyers__18972.8557751097$1439941068$gmane$org@efficios.com>
References: <1439940978-3953-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZRqQi-0001W9-JT
 for lttng-dev@lists.lttng.org; Tue, 18 Aug 2015 19:36:37 -0400
In-Reply-To: <1439940978-3953-1-git-send-email-mathieu.desnoyers@efficios.com>
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

This is needed to correctly handle SIGINT in live view mode. Without
handling this situation correctly, we can often see the following issue
upon SIGINT:

[error] Stream 18446744073709551615 is not declared in metadata.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 converter/babeltrace-log.c             |  3 ++-
 converter/babeltrace.c                 |  2 +-
 formats/bt-dummy/bt-dummy.c            |  2 +-
 formats/ctf-metadata/ctf-metadata.c    |  4 +--
 formats/ctf-text/ctf-text.c            |  4 +--
 formats/ctf/ctf.c                      | 47 +++++++++++++++++++---------------
 formats/ctf/ir/stream.c                |  5 +++-
 formats/lttng-live/lttng-live-comm.c   | 18 +++++++------
 formats/lttng-live/lttng-live-plugin.c |  2 +-
 include/babeltrace/context.h           |  2 +-
 include/babeltrace/ctf/types.h         | 15 ++++++-----
 include/babeltrace/format.h            |  4 +--
 lib/context.c                          |  2 +-
 13 files changed, 62 insertions(+), 48 deletions(-)

diff --git a/converter/babeltrace-log.c b/converter/babeltrace-log.c
index 5a8b26a..5677824 100644
--- a/converter/babeltrace-log.c
+++ b/converter/babeltrace-log.c
@@ -283,7 +283,8 @@ void trace_string(char *line, struct ctf_stream_pos *pos, size_t len)
 		if (!ctf_move_pos(&dummy, tlen * CHAR_BIT))
 			goto error;
 		if (ctf_pos_packet(&dummy)) {
-			ctf_pos_pad_packet(pos);
+			if (ctf_pos_pad_packet(pos))
+				goto error;
 			write_packet_header(pos, s_uuid);
 			write_packet_context(pos);
 			if (attempt++ == 1) {
diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index 0ceca0c..cb54eaf 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -496,7 +496,7 @@ static int traverse_trace_dir(const char *fpath, const struct stat *sb,
  */
 int bt_context_add_traces_recursive(struct bt_context *ctx, const char *path,
 		const char *format_str,
-		void (*packet_seek)(struct bt_stream_pos *pos,
+		int (*packet_seek)(struct bt_stream_pos *pos,
 			size_t offset, int whence))
 {
 	int ret = 0, trace_ids = 0;
diff --git a/formats/bt-dummy/bt-dummy.c b/formats/bt-dummy/bt-dummy.c
index 6192e88..17e2e33 100644
--- a/formats/bt-dummy/bt-dummy.c
+++ b/formats/bt-dummy/bt-dummy.c
@@ -46,7 +46,7 @@ int bt_dummy_write_event(struct bt_stream_pos *ppos, struct ctf_stream_definitio
 
 static
 struct bt_trace_descriptor *bt_dummy_open_trace(const char *path, int flags,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp)
 {
 	struct ctf_text_stream_pos *pos;
diff --git a/formats/ctf-metadata/ctf-metadata.c b/formats/ctf-metadata/ctf-metadata.c
index a5a74c3..cb10b9a 100644
--- a/formats/ctf-metadata/ctf-metadata.c
+++ b/formats/ctf-metadata/ctf-metadata.c
@@ -43,7 +43,7 @@
 
 static
 struct bt_trace_descriptor *ctf_metadata_open_trace(const char *path, int flags,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp);
 static
 int ctf_metadata_close_trace(struct bt_trace_descriptor *descriptor);
@@ -75,7 +75,7 @@ int ctf_metadata_trace_pre_handler(struct bt_stream_pos *ppos,
 
 static
 struct bt_trace_descriptor *ctf_metadata_open_trace(const char *path, int flags,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp)
 {
 	struct ctf_text_stream_pos *pos;
diff --git a/formats/ctf-text/ctf-text.c b/formats/ctf-text/ctf-text.c
index 2ba0823..1e2344b 100644
--- a/formats/ctf-text/ctf-text.c
+++ b/formats/ctf-text/ctf-text.c
@@ -88,7 +88,7 @@ enum bt_loglevel {
 
 static
 struct bt_trace_descriptor *ctf_text_open_trace(const char *path, int flags,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp);
 static
 int ctf_text_close_trace(struct bt_trace_descriptor *descriptor);
@@ -537,7 +537,7 @@ error:
 
 static
 struct bt_trace_descriptor *ctf_text_open_trace(const char *path, int flags,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp)
 {
 	struct ctf_text_stream_pos *pos;
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 5436c2a..c046e46 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -93,13 +93,13 @@ int babeltrace_ctf_console_output;
 
 static
 struct bt_trace_descriptor *ctf_open_trace(const char *path, int flags,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		FILE *metadata_fp);
 static
 struct bt_trace_descriptor *ctf_open_mmap_trace(
 		struct bt_mmap_stream_list *mmap_list,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		FILE *metadata_fp);
 static
@@ -472,7 +472,8 @@ int ctf_read_event(struct bt_stream_pos *ppos, struct ctf_stream_definition *str
 	if (unlikely(pos->offset == EOF))
 		return EOF;
 
-	ctf_pos_get_event(pos);
+	if (ctf_pos_get_event(pos))
+		return EOF;
 
 	/* save the current position as a restore point */
 	pos->last_offset = pos->offset;
@@ -853,7 +854,7 @@ void ctf_update_current_packet_index(struct ctf_stream_definition *stream,
  * for SEEK_CUR: go to next packet.
  * for SEEK_SET: go to packet numer (index).
  */
-void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
+int ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 {
 	struct ctf_stream_pos *pos =
 		container_of(stream_pos, struct ctf_stream_pos, parent);
@@ -868,7 +869,7 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 	case SEEK_SET:	/* Fall-through */
 		break;	/* OK */
 	default:
-		assert(0);
+		return -1;
 	}
 
 	if ((pos->prot & PROT_WRITE) && pos->content_size_loc)
@@ -880,7 +881,7 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 		if (ret) {
 			fprintf(stderr, "[error] Unable to unmap old base: %s.\n",
 				strerror(errno));
-			assert(0);
+			return -1;
 		}
 		pos->base_mma = NULL;
 	}
@@ -900,7 +901,7 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 			pos->cur_index = 0;
 			break;
 		default:
-			assert(0);
+			return -1;
 		}
 		pos->content_size = -1U;	/* Unknown at this point */
 		pos->packet_size = WRITE_PACKET_LEN;
@@ -914,7 +915,7 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 		case SEEK_CUR:
 		{
 			if (pos->offset == EOF) {
-				return;
+				return 0;
 			}
 			assert(pos->cur_index < pos->packet_index->len);
 			/* The reader will expect us to skip padding */
@@ -924,12 +925,12 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 		case SEEK_SET:
 			if (index >= pos->packet_index->len) {
 				pos->offset = EOF;
-				return;
+				return 0;
 			}
 			pos->cur_index = index;
 			break;
 		default:
-			assert(0);
+			return -1;
 		}
 
 		packet_index = &g_array_index(pos->packet_index,
@@ -946,7 +947,7 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 
 		if (pos->cur_index >= pos->packet_index->len) {
 			pos->offset = EOF;
-			return;
+			return 0;
 		}
 
 		/*
@@ -970,7 +971,7 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 		if (packet_index->data_offset == -1) {
 			ret = find_data_offset(pos, file_stream, packet_index);
 			if (ret < 0) {
-				return;
+				return -1;
 			}
 		}
 		pos->content_size = packet_index->content_size;
@@ -986,7 +987,7 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 			goto read_next_packet;
 		} else {
 			pos->offset = EOF;
-			return;
+			return 0;
 		}
 	}
 	/* map new base. Need mapping length from header. */
@@ -1011,6 +1012,7 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 		ret = generic_rw(&pos->parent, &file_stream->parent.stream_packet_context->p);
 		assert(!ret);
 	}
+	return 0;
 }
 
 static
@@ -1933,7 +1935,7 @@ error:
  */
 static
 int ctf_open_file_stream_read(struct ctf_trace *td, const char *path, int flags,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence))
 {
 	int ret, fd, closeret;
@@ -2074,7 +2076,7 @@ error:
 static
 int ctf_open_trace_read(struct ctf_trace *td,
 		const char *path, int flags,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp)
 {
 	struct ctf_scanner *scanner;
@@ -2190,7 +2192,7 @@ error:
  */
 static
 struct bt_trace_descriptor *ctf_open_trace(const char *path, int flags,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp)
 {
 	struct ctf_trace *td;
@@ -2253,7 +2255,7 @@ void ctf_init_mmap_pos(struct ctf_stream_pos *pos,
 static
 int prepare_mmap_stream_definition(struct ctf_trace *td,
 		struct ctf_file_stream *file_stream,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence))
 {
 	struct ctf_stream_declaration *stream;
@@ -2261,7 +2263,10 @@ int prepare_mmap_stream_definition(struct ctf_trace *td,
 	int ret;
 
 	/* Ask for the first packet to get the stream_id. */
-	packet_seek(&file_stream->pos.parent, 0, SEEK_SET);
+	ret = packet_seek(&file_stream->pos.parent, 0, SEEK_SET);
+	if (ret) {
+		goto end;
+	}
 	stream_id = file_stream->parent.stream_id;
 	if (stream_id >= td->streams->len) {
 		fprintf(stderr, "[error] Stream %" PRIu64 " is not declared "
@@ -2285,7 +2290,7 @@ end:
 static
 int ctf_open_mmap_stream_read(struct ctf_trace *td,
 		struct bt_mmap_stream *mmap_info,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence))
 {
 	int ret;
@@ -2328,7 +2333,7 @@ error_def:
 static
 int ctf_open_mmap_trace_read(struct ctf_trace *td,
 		struct bt_mmap_stream_list *mmap_list,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		FILE *metadata_fp)
 {
@@ -2370,7 +2375,7 @@ error:
 static
 struct bt_trace_descriptor *ctf_open_mmap_trace(
 		struct bt_mmap_stream_list *mmap_list,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		FILE *metadata_fp)
 {
diff --git a/formats/ctf/ir/stream.c b/formats/ctf/ir/stream.c
index 6a6a3a7..22a3cd6 100644
--- a/formats/ctf/ir/stream.c
+++ b/formats/ctf/ir/stream.c
@@ -733,7 +733,10 @@ int bt_ctf_stream_flush(struct bt_ctf_stream *stream)
 	}
 
 	/* mmap the next packet */
-	ctf_packet_seek(&stream->pos.parent, 0, SEEK_CUR);
+	ret = ctf_packet_seek(&stream->pos.parent, 0, SEEK_CUR);
+	if (ret) {
+		goto end;
+	}
 
 	ret = bt_ctf_field_serialize(stream->packet_header, &stream->pos);
 	if (ret) {
diff --git a/formats/lttng-live/lttng-live-comm.c b/formats/lttng-live/lttng-live-comm.c
index 8fa90cf..378d19e 100644
--- a/formats/lttng-live/lttng-live-comm.c
+++ b/formats/lttng-live/lttng-live-comm.c
@@ -68,7 +68,7 @@
 	((type) (a) > (type) (b) ? (type) (a) : (type) (b))
 #endif
 
-static void ctf_live_packet_seek(struct bt_stream_pos *stream_pos,
+static int ctf_live_packet_seek(struct bt_stream_pos *stream_pos,
 		size_t index, int whence);
 static int add_traces(struct lttng_live_ctx *ctx);
 static int del_traces(gpointer key, gpointer value, gpointer user_data);
@@ -1154,7 +1154,7 @@ end:
 }
 
 static
-void ctf_live_packet_seek(struct bt_stream_pos *stream_pos, size_t index,
+int ctf_live_packet_seek(struct bt_stream_pos *stream_pos, size_t index,
 		int whence)
 {
 	struct ctf_stream_pos *pos;
@@ -1173,7 +1173,7 @@ void ctf_live_packet_seek(struct bt_stream_pos *stream_pos, size_t index,
 	ret = handle_seek_position(index, whence, viewer_stream, pos,
 			file_stream);
 	if (ret != 0) {
-		return;
+		return -1;
 	}
 
 retry:
@@ -1215,7 +1215,7 @@ retry:
 			if (!lttng_live_should_quit()) {
 				fprintf(stderr, "[error] get_next_index failed\n");
 			}
-			return;
+			return -1;
 		}
 		printf_verbose("Index received : packet_size : %" PRIu64
 				", offset %" PRIu64 ", content_size %" PRIu64
@@ -1232,7 +1232,7 @@ retry:
 	 * stream id. We need to skip this packet for now.
 	 */
 	if (stream_id == -1ULL) {
-		return;
+		return 0;
 	}
 	/*
 	 * On the first time we receive an index, the stream_id needs to
@@ -1252,7 +1252,7 @@ retry:
 		file_stream->parent.stream_id = stream_id;
 		viewer_stream->ctf_stream_id = stream_id;
 
-		return;
+		return 0;
 	}
 
 	pos->packet_size = cur_index->packet_size;
@@ -1307,15 +1307,17 @@ retry:
 		pos->offset = EOF;
 		if (!lttng_live_should_quit()) {
 			fprintf(stderr, "[error] get_data_packet failed\n");
+			return -1;
+		} else {
+			return 0;
 		}
-		return;
 	}
 	viewer_stream->data_pending = 0;
 
 	read_packet_header(pos, file_stream);
 
 end:
-	return;
+	return 0;
 }
 
 int lttng_live_create_viewer_session(struct lttng_live_ctx *ctx)
diff --git a/formats/lttng-live/lttng-live-plugin.c b/formats/lttng-live/lttng-live-plugin.c
index 643129c..3fbcf0a 100644
--- a/formats/lttng-live/lttng-live-plugin.c
+++ b/formats/lttng-live/lttng-live-plugin.c
@@ -271,7 +271,7 @@ end_free:
 
 static
 struct bt_trace_descriptor *lttng_live_open_trace(const char *path, int flags,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp)
 {
 	struct ctf_text_stream_pos *pos;
diff --git a/include/babeltrace/context.h b/include/babeltrace/context.h
index b28df09..3ac15d5 100644
--- a/include/babeltrace/context.h
+++ b/include/babeltrace/context.h
@@ -82,7 +82,7 @@ struct bt_context *bt_context_create(void);
  */
 int bt_context_add_trace(struct bt_context *ctx, const char *path,
 		const char *format,
-		void (*packet_seek)(struct bt_stream_pos *pos,
+		int (*packet_seek)(struct bt_stream_pos *pos,
 			size_t index, int whence),
 		struct bt_mmap_stream_list *stream_list,
 		FILE *metadata);
diff --git a/include/babeltrace/ctf/types.h b/include/babeltrace/ctf/types.h
index c336632..abcde4c 100644
--- a/include/babeltrace/ctf/types.h
+++ b/include/babeltrace/ctf/types.h
@@ -83,7 +83,7 @@ struct ctf_stream_pos {
 	int64_t data_offset;	/* offset of data in current packet */
 	uint64_t cur_index;	/* current index in packet index */
 	uint64_t last_events_discarded;	/* last known amount of event discarded */
-	void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+	int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence); /* function called to switch packet */
 
 	int dummy;		/* dummy position, for length calculation */
@@ -126,7 +126,7 @@ int ctf_sequence_read(struct bt_stream_pos *pos, struct bt_definition *definitio
 BT_HIDDEN
 int ctf_sequence_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 
-void ctf_packet_seek(struct bt_stream_pos *pos, size_t index, int whence);
+int ctf_packet_seek(struct bt_stream_pos *pos, size_t index, int whence);
 
 int ctf_init_pos(struct ctf_stream_pos *pos, struct bt_trace_descriptor *trace,
 		int fd, int open_flags);
@@ -220,9 +220,9 @@ int ctf_pos_packet(struct ctf_stream_pos *dummy)
 }
 
 static inline
-void ctf_pos_pad_packet(struct ctf_stream_pos *pos)
+int ctf_pos_pad_packet(struct ctf_stream_pos *pos)
 {
-	ctf_packet_seek(&pos->parent, 0, SEEK_CUR);
+	return ctf_packet_seek(&pos->parent, 0, SEEK_CUR);
 }
 
 /*
@@ -230,16 +230,19 @@ void ctf_pos_pad_packet(struct ctf_stream_pos *pos)
  * the next packet if we are located at the end of the current packet.
  */
 static inline
-void ctf_pos_get_event(struct ctf_stream_pos *pos)
+int ctf_pos_get_event(struct ctf_stream_pos *pos)
 {
+	int ret = 0;
+
 	assert(pos->offset <= pos->content_size);
 	if (pos->offset == pos->content_size) {
 		printf_debug("ctf_packet_seek (before call): %" PRId64 "\n",
 			     pos->offset);
-		pos->packet_seek(&pos->parent, 0, SEEK_CUR);
+		ret = pos->packet_seek(&pos->parent, 0, SEEK_CUR);
 		printf_debug("ctf_packet_seek (after call): %" PRId64 "\n",
 			     pos->offset);
 	}
+	return ret;
 }
 
 void ctf_print_timestamp(FILE *fp, struct ctf_stream_definition *stream,
diff --git a/include/babeltrace/format.h b/include/babeltrace/format.h
index dea8e0e..dd52ce4 100644
--- a/include/babeltrace/format.h
+++ b/include/babeltrace/format.h
@@ -60,12 +60,12 @@ struct bt_format {
 	bt_intern_str name;
 
 	struct bt_trace_descriptor *(*open_trace)(const char *path, int flags,
-			void (*packet_seek)(struct bt_stream_pos *pos,
+			int (*packet_seek)(struct bt_stream_pos *pos,
 				size_t index, int whence),
 			FILE *metadata_fp);
 	struct bt_trace_descriptor *(*open_mmap_trace)(
 			struct bt_mmap_stream_list *mmap_list,
-			void (*packet_seek)(struct bt_stream_pos *pos,
+			int (*packet_seek)(struct bt_stream_pos *pos,
 				size_t index, int whence),
 			FILE *metadata_fp);
 	int (*close_trace)(struct bt_trace_descriptor *descriptor);
diff --git a/lib/context.c b/lib/context.c
index 45aab34..e54bc32 100644
--- a/lib/context.c
+++ b/lib/context.c
@@ -71,7 +71,7 @@ struct bt_context *bt_context_create(void)
 
 int bt_context_add_trace(struct bt_context *ctx, const char *path,
 		const char *format_name,
-		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
+		int (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		struct bt_mmap_stream_list *stream_list,
 		FILE *metadata)
-- 
2.1.4
