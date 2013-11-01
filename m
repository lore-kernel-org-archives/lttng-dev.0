From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH babeltrace v2] Introduce read_fit callback for
	format plugins
Date: Thu, 31 Oct 2013 23:49:23 -0400
Message-ID: <1383277763-21488-1-git-send-email-simon.marchi__14027.0773358226$1383277818$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.electronicbox.net ([96.127.255.82])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1Vc5jm-0007vE-AD
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 23:49:31 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The format plugins should implement this callback to tell whether they
are a good fit to read the given path or not. This allows to move
CTF-specific code from the core to ctf.c. This should be a step towards
having more than one input plugin.

The callback should return 1 if it wants to handle this path, 0 otherwise. It
should return -1 in case of catastrophic failure.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 converter/babeltrace.c      | 91 ++++++++++++++++++++++-----------------------
 formats/ctf/ctf.c           | 50 +++++++++++++++++++++++++
 include/babeltrace/format.h |  1 +
 3 files changed, 95 insertions(+), 47 deletions(-)

diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index d5a7040..d1a8aa3 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -416,7 +416,16 @@ end:
 	return ret;
 }
 
-static GPtrArray *traversed_paths = 0;
+/*
+ * Since nftw doesn't pass a user data pointer to its callbacks, we
+ * have to resort to global variables.
+ */
+struct traverse_trace_dir_args {
+	struct bt_format *format;
+	GPtrArray *paths;
+};
+
+static struct traverse_trace_dir_args traverse_trace_dir_args = {NULL, NULL};
 
 /*
  * traverse_trace_dir() is the callback function for File Tree Walk (nftw).
@@ -429,53 +438,32 @@ static GPtrArray *traversed_paths = 0;
 static int traverse_trace_dir(const char *fpath, const struct stat *sb,
 			int tflag, struct FTW *ftwbuf)
 {
-	int dirfd, metafd;
-	int closeret;
+	int ret;
+	struct traverse_trace_dir_args args = traverse_trace_dir_args;
 
-	if (tflag != FTW_D)
-		return 0;
+	assert(args.format != NULL);
+	assert(args.paths != NULL);
 
-	dirfd = open(fpath, 0);
-	if (dirfd < 0) {
-		fprintf(stderr, "[error] [Context] Unable to open trace "
-			"directory file descriptor.\n");
-		return 0;	/* partial error */
+	if (!args.format->read_fit) {
+		/* The plug-in needs to implement read_fit. */
+		return -1;
 	}
-	metafd = openat(dirfd, "metadata", O_RDONLY);
-	if (metafd < 0) {
-		closeret = close(dirfd);
-		if (closeret < 0) {
-			perror("close");
-			return -1;
-		}
-		/* No meta data, just return */
-		return 0;
-	} else {
-		int err_close = 0;
 
-		closeret = close(metafd);
-		if (closeret < 0) {
-			perror("close");
-			err_close = 1;
-		}
-		closeret = close(dirfd);
-		if (closeret < 0) {
-			perror("close");
-			err_close = 1;
-		}
-		if (err_close) {
-			return -1;
-		}
+	ret = args.format->read_fit(fpath, tflag == FTW_D);
 
-		/* Add path to the global list */
-		if (traversed_paths == NULL) {
-			fprintf(stderr, "[error] [Context] Invalid open path array.\n");	
-			return -1;
-		}
-		g_ptr_array_add(traversed_paths, g_string_new(fpath));
+	/*
+	 * If ret is negative (means error), we return directly. This will
+	 * interrupt the file tree walk. If ret is 0, the format is not interested
+	 * by the path, we also return directly.
+	 */
+
+	if (ret > 0) {
+		/* Format is interested. Add path to the global list */
+		g_ptr_array_add(args.paths, g_string_new(fpath));
+		ret = 0;
 	}
 
-	return 0;
+	return ret;
 }
 
 /*
@@ -499,15 +487,22 @@ int bt_context_add_traces_recursive(struct bt_context *ctx, const char *path,
 
 	/* Should lock traversed_paths mutex here if used in multithread */
 
-	traversed_paths = g_ptr_array_new();
+	struct bt_format *format = bt_lookup_format(g_quark_from_string(format_str));
+	if (!format) {
+		ret = -1;
+		goto error;
+	}
+
+	traverse_trace_dir_args.paths = g_ptr_array_new();
+	traverse_trace_dir_args.format = format;
 	ret = nftw(path, traverse_trace_dir, 10, 0);
 
 	/* Process the array if ntfw did not return a fatal error */
 	if (ret >= 0) {
 		int i;
 
-		for (i = 0; i < traversed_paths->len; i++) {
-			GString *trace_path = g_ptr_array_index(traversed_paths,
+		for (i = 0; i < traverse_trace_dir_args.paths->len; i++) {
+			GString *trace_path = g_ptr_array_index(traverse_trace_dir_args.paths,
 								i);
 			int trace_id = bt_context_add_trace(ctx,
 							    trace_path->str,
@@ -527,8 +522,8 @@ int bt_context_add_traces_recursive(struct bt_context *ctx, const char *path,
 		}
 	}
 
-	g_ptr_array_free(traversed_paths, TRUE);
-	traversed_paths = NULL;
+	g_ptr_array_free(traverse_trace_dir_args.paths, TRUE);
+	traverse_trace_dir_args.paths = NULL;
 
 	/* Should unlock traversed paths mutex here if used in multithread */
 
@@ -539,6 +534,8 @@ int bt_context_add_traces_recursive(struct bt_context *ctx, const char *path,
 		fprintf(stderr, "[error] Cannot open any trace for reading.\n\n");
 		ret = -ENOENT;		/* failure */
 	}
+
+error:
 	return ret;
 }
 
@@ -697,7 +694,7 @@ int main(int argc, char **argv)
 		}
 	}
 	fmt_read = bt_lookup_format(g_quark_from_static_string(opt_input_format));
-	if (!fmt_read || fmt_read->name != g_quark_from_static_string("ctf")) {
+	if (!fmt_read) {
 		fprintf(stderr, "[error] Format \"%s\" is not supported.\n\n",
 			opt_input_format);
 		partial_error = 1;
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 5fcfcdd..101eafb 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -111,6 +111,9 @@ static
 int ctf_convert_index_timestamp(struct bt_trace_descriptor *tdp);
 
 static
+int ctf_read_fit(const char *fpath, int is_dir);
+
+static
 rw_dispatch read_dispatch_table[] = {
 	[ CTF_TYPE_INTEGER ] = ctf_integer_read,
 	[ CTF_TYPE_FLOAT ] = ctf_float_read,
@@ -144,6 +147,7 @@ struct bt_format ctf_format = {
 	.timestamp_begin = ctf_timestamp_begin,
 	.timestamp_end = ctf_timestamp_end,
 	.convert_index_timestamp = ctf_convert_index_timestamp,
+	.read_fit = ctf_read_fit,
 };
 
 static
@@ -2095,6 +2099,52 @@ int ctf_convert_index_timestamp(struct bt_trace_descriptor *tdp)
 }
 
 static
+int ctf_read_fit(const char *fpath, int is_dir)
+{
+	int dirfd, metafd;
+	int closeret;
+
+	if (!is_dir)
+			return 0;
+
+	dirfd = open(fpath, 0);
+	if (dirfd < 0) {
+		fprintf(stderr, "[error] [Context] Unable to open trace "
+			"directory file descriptor.\n");
+		return 0;	/* partial error */
+	}
+	metafd = openat(dirfd, "metadata", O_RDONLY);
+	if (metafd < 0) {
+		closeret = close(dirfd);
+		if (closeret < 0) {
+			perror("close");
+			return -1;
+		}
+		/* No meta data, just return */
+		return 0;
+	} else {
+		int err_close = 0;
+
+		closeret = close(metafd);
+		if (closeret < 0) {
+			perror("close");
+			err_close = 1;
+		}
+		closeret = close(dirfd);
+		if (closeret < 0) {
+			perror("close");
+			err_close = 1;
+		}
+		if (err_close) {
+			return -1;
+		}
+	}
+
+	/* This path is interesting. */
+	return 1;
+}
+
+static
 int ctf_close_file_stream(struct ctf_file_stream *file_stream)
 {
 	int ret;
diff --git a/include/babeltrace/format.h b/include/babeltrace/format.h
index 07e854f..588c0ff 100644
--- a/include/babeltrace/format.h
+++ b/include/babeltrace/format.h
@@ -77,6 +77,7 @@ struct bt_format {
 	uint64_t (*timestamp_end)(struct bt_trace_descriptor *descriptor,
 			struct bt_trace_handle *handle, enum bt_clock_type type);
 	int (*convert_index_timestamp)(struct bt_trace_descriptor *descriptor);
+	int (*read_fit)(const char *path, int is_dir);
 };
 
 extern struct bt_format *bt_lookup_format(bt_intern_str qname);
-- 
1.8.3.2
