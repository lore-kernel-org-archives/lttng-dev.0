From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 3/7] Namespace the struct
	trace_descriptor
Date: Fri, 15 Feb 2013 12:22:52 -0500
Message-ID: <1360948976-14999-3-git-send-email-jdesfossez__48068.6986622915$1360949049$gmane$org@efficios.com>
References: <1360948976-14999-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1U6P0A-0003w5-Q8
	for lttng-dev@lists.lttng.org; Fri, 15 Feb 2013 12:23:11 -0500
In-Reply-To: <1360948976-14999-1-git-send-email-jdesfossez@efficios.com>
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

This struct is exposed in the public API so we need to namespace it.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 converter/babeltrace.c                     |    4 ++--
 formats/bt-dummy/bt-dummy.c                |    4 ++--
 formats/ctf-text/ctf-text.c                |    8 +++----
 formats/ctf/callbacks.c                    |    2 +-
 formats/ctf/ctf.c                          |   32 ++++++++++++++--------------
 formats/ctf/events.c                       |    2 +-
 include/babeltrace/babeltrace-internal.h   |    4 ++--
 include/babeltrace/ctf-ir/metadata.h       |    2 +-
 include/babeltrace/ctf-text/types.h        |    4 ++--
 include/babeltrace/format.h                |   18 ++++++++--------
 include/babeltrace/trace-collection.h      |    4 ++--
 include/babeltrace/trace-handle-internal.h |    2 +-
 lib/context.c                              |    2 +-
 lib/iterator.c                             |    8 +++----
 lib/trace-collection.c                     |    4 ++--
 15 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index b1f32c9..ef5016e 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -516,7 +516,7 @@ int bt_context_add_traces_recursive(struct bt_context *ctx, const char *path,
 	return ret;
 }
 
-int convert_trace(struct trace_descriptor *td_write,
+int convert_trace(struct bt_trace_descriptor *td_write,
 		  struct bt_context *ctx)
 {
 	struct bt_ctf_iter *iter;
@@ -556,7 +556,7 @@ int main(int argc, char **argv)
 {
 	int ret, partial_error = 0, open_success = 0;
 	struct format *fmt_write;
-	struct trace_descriptor *td_write;
+	struct bt_trace_descriptor *td_write;
 	struct bt_context *ctx;
 	int i;
 
diff --git a/formats/bt-dummy/bt-dummy.c b/formats/bt-dummy/bt-dummy.c
index 537e6bb..f0ce913 100644
--- a/formats/bt-dummy/bt-dummy.c
+++ b/formats/bt-dummy/bt-dummy.c
@@ -45,7 +45,7 @@ int bt_dummy_write_event(struct bt_stream_pos *ppos, struct ctf_stream_definitio
 }
 
 static
-struct trace_descriptor *bt_dummy_open_trace(const char *path, int flags,
+struct bt_trace_descriptor *bt_dummy_open_trace(const char *path, int flags,
 		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp)
 {
@@ -58,7 +58,7 @@ struct trace_descriptor *bt_dummy_open_trace(const char *path, int flags,
 }
 
 static
-int bt_dummy_close_trace(struct trace_descriptor *td)
+int bt_dummy_close_trace(struct bt_trace_descriptor *td)
 {
 	struct ctf_text_stream_pos *pos =
 		container_of(td, struct ctf_text_stream_pos,
diff --git a/formats/ctf-text/ctf-text.c b/formats/ctf-text/ctf-text.c
index 1f798b2..7188658 100644
--- a/formats/ctf-text/ctf-text.c
+++ b/formats/ctf-text/ctf-text.c
@@ -87,11 +87,11 @@ enum bt_loglevel {
 };
 
 static
-struct trace_descriptor *ctf_text_open_trace(const char *path, int flags,
+struct bt_trace_descriptor *ctf_text_open_trace(const char *path, int flags,
 		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp);
 static
-int ctf_text_close_trace(struct trace_descriptor *descriptor);
+int ctf_text_close_trace(struct bt_trace_descriptor *descriptor);
 
 static
 rw_dispatch write_dispatch_table[] = {
@@ -555,7 +555,7 @@ error:
 }
 
 static
-struct trace_descriptor *ctf_text_open_trace(const char *path, int flags,
+struct bt_trace_descriptor *ctf_text_open_trace(const char *path, int flags,
 		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp)
 {
@@ -592,7 +592,7 @@ error:
 }
 
 static
-int ctf_text_close_trace(struct trace_descriptor *td)
+int ctf_text_close_trace(struct bt_trace_descriptor *td)
 {
 	int ret;
 	struct ctf_text_stream_pos *pos =
diff --git a/formats/ctf/callbacks.c b/formats/ctf/callbacks.c
index 793f3d3..3595532 100644
--- a/formats/ctf/callbacks.c
+++ b/formats/ctf/callbacks.c
@@ -89,7 +89,7 @@ int bt_ctf_iter_add_callback(struct bt_ctf_iter *iter,
 	tc = iter->parent.ctx->tc;
 	for (i = 0; i < tc->array->len; i++) {
 		struct ctf_trace *tin;
-		struct trace_descriptor *td_read;
+		struct bt_trace_descriptor *td_read;
 
 		td_read = g_ptr_array_index(tc->array, i);
 		tin = container_of(td_read, struct ctf_trace, parent);
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index c6b148c..2411f7f 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -76,33 +76,33 @@ uint64_t opt_clock_offset;
 extern int yydebug;
 
 static
-struct trace_descriptor *ctf_open_trace(const char *path, int flags,
+struct bt_trace_descriptor *ctf_open_trace(const char *path, int flags,
 		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		FILE *metadata_fp);
 static
-struct trace_descriptor *ctf_open_mmap_trace(
+struct bt_trace_descriptor *ctf_open_mmap_trace(
 		struct mmap_stream_list *mmap_list,
 		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		FILE *metadata_fp);
 static
-void ctf_set_context(struct trace_descriptor *descriptor,
+void ctf_set_context(struct bt_trace_descriptor *descriptor,
 		struct bt_context *ctx);
 static
-void ctf_set_handle(struct trace_descriptor *descriptor,
+void ctf_set_handle(struct bt_trace_descriptor *descriptor,
 		struct bt_trace_handle *handle);
 
 static
-int ctf_close_trace(struct trace_descriptor *descriptor);
+int ctf_close_trace(struct bt_trace_descriptor *descriptor);
 static
-uint64_t ctf_timestamp_begin(struct trace_descriptor *descriptor,
+uint64_t ctf_timestamp_begin(struct bt_trace_descriptor *descriptor,
 		struct bt_trace_handle *handle, enum bt_clock_type type);
 static
-uint64_t ctf_timestamp_end(struct trace_descriptor *descriptor,
+uint64_t ctf_timestamp_end(struct bt_trace_descriptor *descriptor,
 		struct bt_trace_handle *handle, enum bt_clock_type type);
 static
-int ctf_convert_index_timestamp(struct trace_descriptor *tdp);
+int ctf_convert_index_timestamp(struct bt_trace_descriptor *tdp);
 
 static
 rw_dispatch read_dispatch_table[] = {
@@ -141,7 +141,7 @@ struct format ctf_format = {
 };
 
 static
-uint64_t ctf_timestamp_begin(struct trace_descriptor *descriptor,
+uint64_t ctf_timestamp_begin(struct bt_trace_descriptor *descriptor,
 		struct bt_trace_handle *handle, enum bt_clock_type type)
 {
 	struct ctf_trace *tin;
@@ -202,7 +202,7 @@ error:
 }
 
 static
-uint64_t ctf_timestamp_end(struct trace_descriptor *descriptor,
+uint64_t ctf_timestamp_end(struct bt_trace_descriptor *descriptor,
 		struct bt_trace_handle *handle, enum bt_clock_type type)
 {
 	struct ctf_trace *tin;
@@ -1695,7 +1695,7 @@ error:
  * since the index creation read it entirely.
  */
 static
-struct trace_descriptor *ctf_open_trace(const char *path, int flags,
+struct bt_trace_descriptor *ctf_open_trace(const char *path, int flags,
 		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp)
 {
@@ -1859,7 +1859,7 @@ error:
 }
 
 static
-struct trace_descriptor *ctf_open_mmap_trace(
+struct bt_trace_descriptor *ctf_open_mmap_trace(
 		struct mmap_stream_list *mmap_list,
 		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
@@ -1891,7 +1891,7 @@ error:
 }
 
 static
-int ctf_convert_index_timestamp(struct trace_descriptor *tdp)
+int ctf_convert_index_timestamp(struct bt_trace_descriptor *tdp)
 {
 	int i, j, k;
 	struct ctf_trace *td = container_of(tdp, struct ctf_trace, parent);
@@ -1959,7 +1959,7 @@ int ctf_close_file_stream(struct ctf_file_stream *file_stream)
 }
 
 static
-int ctf_close_trace(struct trace_descriptor *tdp)
+int ctf_close_trace(struct bt_trace_descriptor *tdp)
 {
 	struct ctf_trace *td = container_of(tdp, struct ctf_trace, parent);
 	int ret;
@@ -2000,7 +2000,7 @@ int ctf_close_trace(struct trace_descriptor *tdp)
 }
 
 static
-void ctf_set_context(struct trace_descriptor *descriptor,
+void ctf_set_context(struct bt_trace_descriptor *descriptor,
 		struct bt_context *ctx)
 {
 	struct ctf_trace *td = container_of(descriptor, struct ctf_trace,
@@ -2010,7 +2010,7 @@ void ctf_set_context(struct trace_descriptor *descriptor,
 }
 
 static
-void ctf_set_handle(struct trace_descriptor *descriptor,
+void ctf_set_handle(struct bt_trace_descriptor *descriptor,
 		struct bt_trace_handle *handle)
 {
 	struct ctf_trace *td = container_of(descriptor, struct ctf_trace,
diff --git a/formats/ctf/events.c b/formats/ctf/events.c
index ff0fcb3..d9460b1 100644
--- a/formats/ctf/events.c
+++ b/formats/ctf/events.c
@@ -613,7 +613,7 @@ int bt_ctf_get_event_decl_list(int handle_id, struct bt_context *ctx,
 		unsigned int *count)
 {
 	struct bt_trace_handle *handle;
-	struct trace_descriptor *td;
+	struct bt_trace_descriptor *td;
 	struct ctf_trace *tin;
 
 	if (!ctx || !list || !count)
diff --git a/include/babeltrace/babeltrace-internal.h b/include/babeltrace/babeltrace-internal.h
index 6b6fcec..6219b3a 100644
--- a/include/babeltrace/babeltrace-internal.h
+++ b/include/babeltrace/babeltrace-internal.h
@@ -50,9 +50,9 @@ extern int babeltrace_verbose, babeltrace_debug;
  */
 #define BT_HIDDEN __attribute__((visibility("hidden")))
 
-struct trace_descriptor;
+struct bt_trace_descriptor;
 struct trace_collection {
-	GPtrArray *array;	/* struct trace_descriptor */
+	GPtrArray *array;	/* struct bt_trace_descriptor */
 	GHashTable *clocks;	/* struct ctf_clock */
 
 	uint64_t single_clock_offset_avg;
diff --git a/include/babeltrace/ctf-ir/metadata.h b/include/babeltrace/ctf-ir/metadata.h
index b209993..04e8945 100644
--- a/include/babeltrace/ctf-ir/metadata.h
+++ b/include/babeltrace/ctf-ir/metadata.h
@@ -174,7 +174,7 @@ struct ctf_tracer_env {
 };
 
 struct ctf_trace {
-	struct trace_descriptor parent;
+	struct bt_trace_descriptor parent;
 	/* root scope */
 	struct declaration_scope *root_declaration_scope;
 
diff --git a/include/babeltrace/ctf-text/types.h b/include/babeltrace/ctf-text/types.h
index 8681f39..15c8333 100644
--- a/include/babeltrace/ctf-text/types.h
+++ b/include/babeltrace/ctf-text/types.h
@@ -37,11 +37,11 @@
 #include <babeltrace/format.h>
 
 /*
- * Inherit from both struct bt_stream_pos and struct trace_descriptor.
+ * Inherit from both struct bt_stream_pos and struct bt_trace_descriptor.
  */
 struct ctf_text_stream_pos {
 	struct bt_stream_pos parent;
-	struct trace_descriptor trace_descriptor;
+	struct bt_trace_descriptor trace_descriptor;
 	FILE *fp;		/* File pointer. NULL if unset. */
 	int depth;
 	int dummy;		/* disable output */
diff --git a/include/babeltrace/format.h b/include/babeltrace/format.h
index fa0e325..d0f9378 100644
--- a/include/babeltrace/format.h
+++ b/include/babeltrace/format.h
@@ -46,7 +46,7 @@ struct bt_context;
 struct bt_trace_handle;
 
 /* Parent trace descriptor */
-struct trace_descriptor {
+struct bt_trace_descriptor {
 };
 
 struct mmap_stream {
@@ -61,25 +61,25 @@ struct mmap_stream_list {
 struct format {
 	bt_intern_str name;
 
-	struct trace_descriptor *(*open_trace)(const char *path, int flags,
+	struct bt_trace_descriptor *(*open_trace)(const char *path, int flags,
 			void (*packet_seek)(struct bt_stream_pos *pos,
 				size_t index, int whence),
 			FILE *metadata_fp);
-	struct trace_descriptor *(*open_mmap_trace)(
+	struct bt_trace_descriptor *(*open_mmap_trace)(
 			struct mmap_stream_list *mmap_list,
 			void (*packet_seek)(struct bt_stream_pos *pos,
 				size_t index, int whence),
 			FILE *metadata_fp);
-	int (*close_trace)(struct trace_descriptor *descriptor);
-	void (*set_context)(struct trace_descriptor *descriptor,
+	int (*close_trace)(struct bt_trace_descriptor *descriptor);
+	void (*set_context)(struct bt_trace_descriptor *descriptor,
 			struct bt_context *ctx);
-	void (*set_handle)(struct trace_descriptor *descriptor,
+	void (*set_handle)(struct bt_trace_descriptor *descriptor,
 			struct bt_trace_handle *handle);
-	uint64_t (*timestamp_begin)(struct trace_descriptor *descriptor,
+	uint64_t (*timestamp_begin)(struct bt_trace_descriptor *descriptor,
 			struct bt_trace_handle *handle, enum bt_clock_type type);
-	uint64_t (*timestamp_end)(struct trace_descriptor *descriptor,
+	uint64_t (*timestamp_end)(struct bt_trace_descriptor *descriptor,
 			struct bt_trace_handle *handle, enum bt_clock_type type);
-	int (*convert_index_timestamp)(struct trace_descriptor *descriptor);
+	int (*convert_index_timestamp)(struct bt_trace_descriptor *descriptor);
 };
 
 extern struct format *bt_lookup_format(bt_intern_str qname);
diff --git a/include/babeltrace/trace-collection.h b/include/babeltrace/trace-collection.h
index e65654f..904a7d8 100644
--- a/include/babeltrace/trace-collection.h
+++ b/include/babeltrace/trace-collection.h
@@ -38,9 +38,9 @@ struct trace_collection;
 void bt_init_trace_collection(struct trace_collection *tc);
 void bt_finalize_trace_collection(struct trace_collection *tc);
 int bt_trace_collection_add(struct trace_collection *tc,
-			 struct trace_descriptor *td);
+			 struct bt_trace_descriptor *td);
 int bt_trace_collection_remove(struct trace_collection *tc,
-			 struct trace_descriptor *td);
+			 struct bt_trace_descriptor *td);
 
 #ifdef __cplusplus
 }
diff --git a/include/babeltrace/trace-handle-internal.h b/include/babeltrace/trace-handle-internal.h
index 2b5a5ae..f7e2b8a 100644
--- a/include/babeltrace/trace-handle-internal.h
+++ b/include/babeltrace/trace-handle-internal.h
@@ -43,7 +43,7 @@
  */
 struct bt_trace_handle {
 	int id;
-	struct trace_descriptor *td;
+	struct bt_trace_descriptor *td;
 	struct format *format;
 	char path[PATH_MAX];
 	uint64_t real_timestamp_begin;
diff --git a/lib/context.c b/lib/context.c
index 18e2e22..e6b60fa 100644
--- a/lib/context.c
+++ b/lib/context.c
@@ -72,7 +72,7 @@ int bt_context_add_trace(struct bt_context *ctx, const char *path,
 		struct mmap_stream_list *stream_list,
 		FILE *metadata)
 {
-	struct trace_descriptor *td;
+	struct bt_trace_descriptor *td;
 	struct format *fmt;
 	struct bt_trace_handle *handle;
 	int ret, closeret;
diff --git a/lib/iterator.c b/lib/iterator.c
index dc12a2f..4190e65 100644
--- a/lib/iterator.c
+++ b/lib/iterator.c
@@ -309,7 +309,7 @@ static int seek_last_ctf_trace_collection(struct trace_collection *tc,
 	/* For each trace in the trace_collection */
 	for (i = 0; i < tc->array->len; i++) {
 		struct ctf_trace *tin;
-		struct trace_descriptor *td_read;
+		struct bt_trace_descriptor *td_read;
 
 		td_read = g_ptr_array_index(tc->array, i);
 		if (!td_read)
@@ -421,7 +421,7 @@ int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
 		/* for each trace in the trace_collection */
 		for (i = 0; i < tc->array->len; i++) {
 			struct ctf_trace *tin;
-			struct trace_descriptor *td_read;
+			struct bt_trace_descriptor *td_read;
 
 			td_read = g_ptr_array_index(tc->array, i);
 			if (!td_read)
@@ -451,7 +451,7 @@ int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
 
 		for (i = 0; i < tc->array->len; i++) {
 			struct ctf_trace *tin;
-			struct trace_descriptor *td_read;
+			struct bt_trace_descriptor *td_read;
 			int stream_id;
 
 			td_read = g_ptr_array_index(tc->array, i);
@@ -675,7 +675,7 @@ int bt_iter_init(struct bt_iter *iter,
 
 	for (i = 0; i < ctx->tc->array->len; i++) {
 		struct ctf_trace *tin;
-		struct trace_descriptor *td_read;
+		struct bt_trace_descriptor *td_read;
 
 		td_read = g_ptr_array_index(ctx->tc->array, i);
 		if (!td_read)
diff --git a/lib/trace-collection.c b/lib/trace-collection.c
index fc06dcd..608a6e4 100644
--- a/lib/trace-collection.c
+++ b/lib/trace-collection.c
@@ -156,7 +156,7 @@ static void clock_add(gpointer key, gpointer value, gpointer user_data)
  * convert the index from cycles to real time.
  */
 int bt_trace_collection_add(struct trace_collection *tc,
-				struct trace_descriptor *td)
+				struct bt_trace_descriptor *td)
 {
 	struct ctf_trace *trace;
 
@@ -209,7 +209,7 @@ error:
 }
 
 int bt_trace_collection_remove(struct trace_collection *tc,
-			    struct trace_descriptor *td)
+			    struct bt_trace_descriptor *td)
 {
 	if (!tc || !td)
 		return -EINVAL;
-- 
1.7.10.4
