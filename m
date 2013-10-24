From: simon.marchi@polymtl.ca
Subject: [PATCH babeltrace] Introduce shows_interest callback
	for format plugins
Date: Thu, 24 Oct 2013 11:19:27 -0400
Message-ID: <1382627967-32696-1-git-send-email-simon.marchi__33422.3310499967$1382628043$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.electronicbox.net ([96.127.255.83])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1VZMhC-0002o9-GZ
	for lttng-dev@lists.lttng.org; Thu, 24 Oct 2013 11:19:40 -0400
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

From: Simon Marchi <simon.marchi@polymtl.ca>

The format plugins should implement this callback to tell whether they
are interested (capable) in processing the given path or not. This
allows to move CTF-specific code from the core to ctf.c. This should
be a step towards having more than one input plugin.

The callback should return 1 if it wants to handle this path, 0 otherwise. It
also return 0 in case of catastrophic failure.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 converter/babeltrace.c      | 73 ++++++++++++++++++++-------------------------
 formats/ctf/ctf.c           | 50 +++++++++++++++++++++++++++++++
 include/babeltrace/format.h |  1 +
 3 files changed, 84 insertions(+), 40 deletions(-)


Hellooooo,

There is a little problem with babeltrace currently, which is that the
core of the converter contains CTF-specific code, in particular in the
recursive trace adding code. What the traverse_trace_dir function does
is simply tell whether a certain path looks like a CTF trace. The
solution I see is to move that code in the plugins by having a callback
through which the plugin can tell us if a given path is interesting for
him. I am notoriously bad at naming stuff, so I'd be happy if you found
a better clear name for the callback.

Thanks,

Simon

diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index d5a7040..7489f35 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -416,6 +416,11 @@ end:
 	return ret;
 }
 
+/*
+ * Oh noes! Since nftw doesn't pass a user data pointer to its callbacks, we
+ * have to resort to global variables.
+ */
+static struct bt_format *traverse_trace_dir_format = NULL;
 static GPtrArray *traversed_paths = 0;
 
 /*
@@ -429,53 +434,32 @@ static GPtrArray *traversed_paths = 0;
 static int traverse_trace_dir(const char *fpath, const struct stat *sb,
 			int tflag, struct FTW *ftwbuf)
 {
-	int dirfd, metafd;
-	int closeret;
+	int ret;
 
-	if (tflag != FTW_D)
-		return 0;
+	assert(traverse_trace_dir_format != NULL);
+	assert(traversed_paths != NULL);
 
-	dirfd = open(fpath, 0);
-	if (dirfd < 0) {
-		fprintf(stderr, "[error] [Context] Unable to open trace "
-			"directory file descriptor.\n");
-		return 0;	/* partial error */
+	if (!traverse_trace_dir_format->shows_interest) {
+		/* Mr plug-in, if you don't implement the shows_interest callback, how
+		 * should we know if you are interested in a path? */
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
+	ret = traverse_trace_dir_format->shows_interest(fpath, tflag == FTW_D);
 
-		/* Add path to the global list */
-		if (traversed_paths == NULL) {
-			fprintf(stderr, "[error] [Context] Invalid open path array.\n");	
-			return -1;
-		}
+	/*
+	 * If ret is negative (means error), we return directly. This will
+	 * interrupt the file tree walk. If ret is 0, the format is not interested
+	 * by the path, we also return directly.
+	 */
+
+	if (ret > 0) {
+		/* Format is interested. Add path to the global list */
 		g_ptr_array_add(traversed_paths, g_string_new(fpath));
+		ret = 0;
 	}
 
-	return 0;
+	return ret;
 }
 
 /*
@@ -499,7 +483,14 @@ int bt_context_add_traces_recursive(struct bt_context *ctx, const char *path,
 
 	/* Should lock traversed_paths mutex here if used in multithread */
 
+	struct bt_format *format = bt_lookup_format(g_quark_from_string(format_str));
+	if (!format) {
+		ret = -1;
+		goto error;
+	}
+
 	traversed_paths = g_ptr_array_new();
+	traverse_trace_dir_format = format;
 	ret = nftw(path, traverse_trace_dir, 10, 0);
 
 	/* Process the array if ntfw did not return a fatal error */
@@ -539,6 +530,8 @@ int bt_context_add_traces_recursive(struct bt_context *ctx, const char *path,
 		fprintf(stderr, "[error] Cannot open any trace for reading.\n\n");
 		ret = -ENOENT;		/* failure */
 	}
+
+error:
 	return ret;
 }
 
@@ -697,7 +690,7 @@ int main(int argc, char **argv)
 		}
 	}
 	fmt_read = bt_lookup_format(g_quark_from_static_string(opt_input_format));
-	if (!fmt_read || fmt_read->name != g_quark_from_static_string("ctf")) {
+	if (!fmt_read) {
 		fprintf(stderr, "[error] Format \"%s\" is not supported.\n\n",
 			opt_input_format);
 		partial_error = 1;
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 947b439..e6babc1 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -111,6 +111,9 @@ static
 int ctf_convert_index_timestamp(struct bt_trace_descriptor *tdp);
 
 static
+int ctf_shows_interest(const char *fpath, int is_dir);
+
+static
 rw_dispatch read_dispatch_table[] = {
 	[ CTF_TYPE_INTEGER ] = ctf_integer_read,
 	[ CTF_TYPE_FLOAT ] = ctf_float_read,
@@ -144,6 +147,7 @@ struct bt_format ctf_format = {
 	.timestamp_begin = ctf_timestamp_begin,
 	.timestamp_end = ctf_timestamp_end,
 	.convert_index_timestamp = ctf_convert_index_timestamp,
+	.shows_interest = ctf_shows_interest,
 };
 
 static
@@ -2095,6 +2099,52 @@ int ctf_convert_index_timestamp(struct bt_trace_descriptor *tdp)
 }
 
 static
+int ctf_shows_interest(const char *fpath, int is_dir)
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
index 07e854f..b039abc 100644
--- a/include/babeltrace/format.h
+++ b/include/babeltrace/format.h
@@ -77,6 +77,7 @@ struct bt_format {
 	uint64_t (*timestamp_end)(struct bt_trace_descriptor *descriptor,
 			struct bt_trace_handle *handle, enum bt_clock_type type);
 	int (*convert_index_timestamp)(struct bt_trace_descriptor *descriptor);
+	int (*shows_interest)(const char *path, int is_dir);
 };
 
 extern struct bt_format *bt_lookup_format(bt_intern_str qname);
-- 
1.8.3.2
