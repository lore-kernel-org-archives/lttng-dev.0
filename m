From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 5/7] Namespace the struct format
Date: Fri, 15 Feb 2013 12:22:54 -0500
Message-ID: <1360948976-14999-5-git-send-email-jdesfossez__47978.2849936329$1360949053$gmane$org@efficios.com>
References: <1360948976-14999-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1U6P0C-0003wM-87
	for lttng-dev@lists.lttng.org; Fri, 15 Feb 2013 12:23:12 -0500
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

This struct is exposed in the public API, we need to namespace it.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 converter/babeltrace.c                     |    4 ++--
 formats/bt-dummy/bt-dummy.c                |    2 +-
 formats/ctf-text/ctf-text.c                |    2 +-
 formats/ctf/ctf.c                          |    2 +-
 include/babeltrace/format.h                |    8 ++++----
 include/babeltrace/trace-handle-internal.h |    2 +-
 include/babeltrace/types.h                 |    2 +-
 lib/context.c                              |    2 +-
 lib/registry.c                             |    6 +++---
 9 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index ef5016e..20ded00 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -68,7 +68,7 @@ static char *opt_input_format, *opt_output_format;
 static GPtrArray *opt_input_paths;
 static char *opt_output_path;
 
-static struct format *fmt_read;
+static struct bt_format *fmt_read;
 
 static
 void strlower(char *str)
@@ -555,7 +555,7 @@ error_iter:
 int main(int argc, char **argv)
 {
 	int ret, partial_error = 0, open_success = 0;
-	struct format *fmt_write;
+	struct bt_format *fmt_write;
 	struct bt_trace_descriptor *td_write;
 	struct bt_context *ctx;
 	int i;
diff --git a/formats/bt-dummy/bt-dummy.c b/formats/bt-dummy/bt-dummy.c
index f0ce913..9fde1c9 100644
--- a/formats/bt-dummy/bt-dummy.c
+++ b/formats/bt-dummy/bt-dummy.c
@@ -68,7 +68,7 @@ int bt_dummy_close_trace(struct bt_trace_descriptor *td)
 }
 
 static
-struct format bt_dummy_format = {
+struct bt_format bt_dummy_format = {
 	.open_trace = bt_dummy_open_trace,
 	.close_trace = bt_dummy_close_trace,
 };
diff --git a/formats/ctf-text/ctf-text.c b/formats/ctf-text/ctf-text.c
index 7188658..cd69125 100644
--- a/formats/ctf-text/ctf-text.c
+++ b/formats/ctf-text/ctf-text.c
@@ -106,7 +106,7 @@ rw_dispatch write_dispatch_table[] = {
 };
 
 static
-struct format ctf_text_format = {
+struct bt_format ctf_text_format = {
 	.open_trace = ctf_text_open_trace,
 	.close_trace = ctf_text_close_trace,
 };
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 3bd1cc1..aea12a1 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -129,7 +129,7 @@ rw_dispatch write_dispatch_table[] = {
 };
 
 static
-struct format ctf_format = {
+struct bt_format ctf_format = {
 	.open_trace = ctf_open_trace,
 	.open_mmap_trace = ctf_open_mmap_trace,
 	.close_trace = ctf_close_trace,
diff --git a/include/babeltrace/format.h b/include/babeltrace/format.h
index 8d4ac4b..f1f8763 100644
--- a/include/babeltrace/format.h
+++ b/include/babeltrace/format.h
@@ -58,7 +58,7 @@ struct bt_mmap_stream_list {
 	struct bt_list_head head;
 };
 
-struct format {
+struct bt_format {
 	bt_intern_str name;
 
 	struct bt_trace_descriptor *(*open_trace)(const char *path, int flags,
@@ -82,10 +82,10 @@ struct format {
 	int (*convert_index_timestamp)(struct bt_trace_descriptor *descriptor);
 };
 
-extern struct format *bt_lookup_format(bt_intern_str qname);
+extern struct bt_format *bt_lookup_format(bt_intern_str qname);
 extern void bt_fprintf_format_list(FILE *fp);
-extern int bt_register_format(struct format *format);
-extern void bt_unregister_format(struct format *format);
+extern int bt_register_format(struct bt_format *format);
+extern void bt_unregister_format(struct bt_format *format);
 
 #ifdef __cplusplus
 }
diff --git a/include/babeltrace/trace-handle-internal.h b/include/babeltrace/trace-handle-internal.h
index f7e2b8a..5e9c1c6 100644
--- a/include/babeltrace/trace-handle-internal.h
+++ b/include/babeltrace/trace-handle-internal.h
@@ -44,7 +44,7 @@
 struct bt_trace_handle {
 	int id;
 	struct bt_trace_descriptor *td;
-	struct format *format;
+	struct bt_format *format;
 	char path[PATH_MAX];
 	uint64_t real_timestamp_begin;
 	uint64_t real_timestamp_end;
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index 310a269..093ef0c 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -44,7 +44,7 @@
 
 struct ctf_stream_definition;
 struct bt_stream_pos;
-struct format;
+struct bt_format;
 struct definition;
 struct ctf_clock;
 
diff --git a/lib/context.c b/lib/context.c
index 0040972..209cfde 100644
--- a/lib/context.c
+++ b/lib/context.c
@@ -73,7 +73,7 @@ int bt_context_add_trace(struct bt_context *ctx, const char *path,
 		FILE *metadata)
 {
 	struct bt_trace_descriptor *td;
-	struct format *fmt;
+	struct bt_format *fmt;
 	struct bt_trace_handle *handle;
 	int ret, closeret;
 
diff --git a/lib/registry.c b/lib/registry.c
index 28af184..bdce0c6 100644
--- a/lib/registry.c
+++ b/lib/registry.c
@@ -67,7 +67,7 @@ void format_refcount_dec(void)
 		format_cleanup();
 }
 
-struct format *bt_lookup_format(bt_intern_str name)
+struct bt_format *bt_lookup_format(bt_intern_str name)
 {
 	if (!init_done)
 		return NULL;
@@ -103,7 +103,7 @@ void bt_fprintf_format_list(FILE *fp)
 	fprintf(fp, ".\n");
 }
 
-int bt_register_format(struct format *format)
+int bt_register_format(struct bt_format *format)
 {
 	if (!format)
 		return -EINVAL;
@@ -121,7 +121,7 @@ int bt_register_format(struct format *format)
 	return 0;
 }
 
-void bt_unregister_format(struct format *format)
+void bt_unregister_format(struct bt_format *format)
 {
 	assert(bt_lookup_format(format->name));
 	g_hash_table_remove(format_registry,
-- 
1.7.10.4
