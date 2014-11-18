From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 1/2] Fix: iterate manually over each
	live trace to add to catch errors
Date: Tue, 18 Nov 2014 12:52:31 -0500
Message-ID: <1416333152-12536-1-git-send-email-jdesfossez__22347.5810992115$1416333234$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1XqmxH-0001dF-BH
 for lttng-dev@lists.lttng.org; Tue, 18 Nov 2014 12:52:46 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Instead of using g_hash_table_foreach, we now control the iteration over
the hash table, so we can handle properly the errors.
For now, if there is an error for any trace, we consider this a fatal
issue and exit.

We could allow the process to continue and only skip the problematic
traces, but we will wait until this becomes a real use-case.

Fixes: #827

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/lttng-live/lttng-live-comm.c | 72 ++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 19 deletions(-)

diff --git a/formats/lttng-live/lttng-live-comm.c b/formats/lttng-live/lttng-live-comm.c
index e473181..cbbeef2 100644
--- a/formats/lttng-live/lttng-live-comm.c
+++ b/formats/lttng-live/lttng-live-comm.c
@@ -70,7 +70,7 @@
 
 static void ctf_live_packet_seek(struct bt_stream_pos *stream_pos,
 		size_t index, int whence);
-static void add_traces(gpointer key, gpointer value, gpointer user_data);
+static int add_traces(struct lttng_live_ctx *ctx);
 static int del_traces(gpointer key, gpointer value, gpointer user_data);
 static int get_new_metadata(struct lttng_live_ctx *ctx,
 		struct lttng_live_viewer_stream *viewer_stream,
@@ -709,11 +709,14 @@ retry:
 		if (rp.flags & LTTNG_VIEWER_FLAG_NEW_STREAM) {
 			printf_verbose("get_data_packet: new streams needed\n");
 			ret = ask_new_streams(ctx);
-			if (ret < 0)
+			if (ret < 0) {
 				goto error;
-			else if (ret > 0)
-				g_hash_table_foreach(ctx->session->ctf_traces,
-						add_traces, ctx->bt_ctx);
+			} else if (ret > 0) {
+				ret = add_traces(ctx);
+				if (ret < 0) {
+					goto error;
+				}
+			}
 		}
 		if (rp.flags & (LTTNG_VIEWER_FLAG_NEW_METADATA
 				| LTTNG_VIEWER_FLAG_NEW_STREAM)) {
@@ -1031,11 +1034,14 @@ retry:
 		if (rp->flags & LTTNG_VIEWER_FLAG_NEW_STREAM) {
 			printf_verbose("get_next_index: need new streams\n");
 			ret = ask_new_streams(ctx);
-			if (ret < 0)
+			if (ret < 0) {
 				goto error;
-			else if (ret > 0)
-				g_hash_table_foreach(ctx->session->ctf_traces,
-						add_traces, ctx->bt_ctx);
+			} else if (ret > 0) {
+				ret = add_traces(ctx);
+				if (ret < 0) {
+					goto error;
+				}
+			}
 		}
 		break;
 	case LTTNG_VIEWER_INDEX_RETRY:
@@ -1360,15 +1366,14 @@ int del_traces(gpointer key, gpointer value, gpointer user_data)
 }
 
 static
-void add_traces(gpointer key, gpointer value, gpointer user_data)
+int add_one_trace(struct lttng_live_ctx *ctx,
+		struct lttng_live_ctf_trace *trace)
 {
 	int i, ret;
-	struct bt_context *bt_ctx = user_data;
-	struct lttng_live_ctf_trace *trace = value;
+	struct bt_context *bt_ctx = ctx->bt_ctx;
 	struct lttng_live_viewer_stream *stream;
 	struct bt_mmap_stream *new_mmap_stream;
 	struct bt_mmap_stream_list mmap_list;
-	struct lttng_live_ctx *ctx = NULL;
 	struct bt_trace_descriptor *td;
 	struct bt_trace_handle *handle;
 
@@ -1381,14 +1386,15 @@ void add_traces(gpointer key, gpointer value, gpointer user_data)
 	 * times the same traces.
 	 * If a trace is already in the context, we just skip this function.
 	 */
-	if (trace->in_use)
-		return;
+	if (trace->in_use) {
+		ret = 0;
+		goto end;
+	}
 
 	BT_INIT_LIST_HEAD(&mmap_list.head);
 
 	for (i = 0; i < trace->streams->len; i++) {
 		stream = g_ptr_array_index(trace->streams, i);
-		ctx = stream->session->ctx;
 
 		if (!stream->metadata_flag) {
 			new_mmap_stream = zmalloc(sizeof(struct bt_mmap_stream));
@@ -1424,6 +1430,7 @@ void add_traces(gpointer key, gpointer value, gpointer user_data)
 
 	if (!trace->metadata_fp) {
 		fprintf(stderr, "[error] No metadata stream opened\n");
+		ret = -1;
 		goto end_free;
 	}
 
@@ -1431,6 +1438,7 @@ void add_traces(gpointer key, gpointer value, gpointer user_data)
 			ctf_live_packet_seek, &mmap_list, trace->metadata_fp);
 	if (ret < 0) {
 		fprintf(stderr, "[error] Error adding trace\n");
+		ret = -1;
 		goto end_free;
 	}
 	trace->metadata_stream->metadata_len = 0;
@@ -1452,7 +1460,31 @@ void add_traces(gpointer key, gpointer value, gpointer user_data)
 end_free:
 	bt_context_put(bt_ctx);
 end:
-	return;
+	return ret;
+}
+
+static
+int add_traces(struct lttng_live_ctx *ctx)
+{
+	int ret;
+	struct lttng_live_ctf_trace *trace;
+	GHashTableIter it;
+	gpointer key;
+	gpointer value;
+
+	g_hash_table_iter_init(&it, ctx->session->ctf_traces);
+	while (g_hash_table_iter_next(&it, &key, &value)) {
+		trace = (struct lttng_live_ctf_trace *) value;
+		ret = add_one_trace(ctx, trace);
+		if (ret < 0) {
+			goto end;
+		}
+	}
+
+	ret = 0;
+
+end:
+	return ret;
 }
 
 /*
@@ -1661,8 +1693,10 @@ int lttng_live_read(struct lttng_live_ctx *ctx)
 			}
 		}
 
-		g_hash_table_foreach(ctx->session->ctf_traces, add_traces,
-				ctx->bt_ctx);
+		ret = add_traces(ctx);
+		if (ret < 0) {
+			goto end_free;
+		}
 
 		begin_pos.type = BT_SEEK_BEGIN;
 		iter = bt_ctf_iter_create(ctx->bt_ctx, &begin_pos, NULL);
-- 
1.9.1
