From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 14/18] namespace the collection
	functions
Date: Thu, 24 Jan 2013 16:21:46 -0500
Message-ID: <1359062510-7557-14-git-send-email-jdesfossez__48618.9240626574$1359064810$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFV-0008Fd-4o
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 16:22:17 -0500
In-Reply-To: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
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

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 include/babeltrace/trace-collection.h |    8 ++++----
 lib/context.c                         |    8 ++++----
 lib/trace-collection.c                |   10 +++++-----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/babeltrace/trace-collection.h b/include/babeltrace/trace-collection.h
index 2ac9ba6..e65654f 100644
--- a/include/babeltrace/trace-collection.h
+++ b/include/babeltrace/trace-collection.h
@@ -35,11 +35,11 @@ extern "C" {
 
 struct trace_collection;
 
-void init_trace_collection(struct trace_collection *tc);
-void finalize_trace_collection(struct trace_collection *tc);
-int trace_collection_add(struct trace_collection *tc,
+void bt_init_trace_collection(struct trace_collection *tc);
+void bt_finalize_trace_collection(struct trace_collection *tc);
+int bt_trace_collection_add(struct trace_collection *tc,
 			 struct trace_descriptor *td);
-int trace_collection_remove(struct trace_collection *tc,
+int bt_trace_collection_remove(struct trace_collection *tc,
 			 struct trace_descriptor *td);
 
 #ifdef __cplusplus
diff --git a/lib/context.c b/lib/context.c
index 5516e49..d067422 100644
--- a/lib/context.c
+++ b/lib/context.c
@@ -60,7 +60,7 @@ struct bt_context *bt_context_create(void)
 
 	ctx->current_iterator = NULL;
 	ctx->tc = g_new0(struct trace_collection, 1);
-	init_trace_collection(ctx->tc);
+	bt_init_trace_collection(ctx->tc);
 
 	return ctx;
 }
@@ -129,7 +129,7 @@ int bt_context_add_trace(struct bt_context *ctx, const char *path,
 	g_hash_table_insert(ctx->trace_handles,
 		(gpointer) (unsigned long) handle->id,
 		handle);
-	ret = trace_collection_add(ctx->tc, td);
+	ret = bt_trace_collection_add(ctx->tc, td);
 	if (ret != 0)
 		goto error;
 
@@ -167,7 +167,7 @@ int bt_context_remove_trace(struct bt_context *ctx, int handle_id)
 		return -ENOENT;
 
 	/* Remove from containers */
-	trace_collection_remove(ctx->tc, handle->td);
+	bt_trace_collection_remove(ctx->tc, handle->td);
 	/* Close the trace */
 	ret = handle->format->close_trace(handle->td);
 	if (ret) {
@@ -184,7 +184,7 @@ static
 void bt_context_destroy(struct bt_context *ctx)
 {
 	assert(ctx);
-	finalize_trace_collection(ctx->tc);
+	bt_finalize_trace_collection(ctx->tc);
 
 	/*
 	 * Remove all traces. The g_hash_table_destroy will call
diff --git a/lib/trace-collection.c b/lib/trace-collection.c
index 4f1379c..fc06dcd 100644
--- a/lib/trace-collection.c
+++ b/lib/trace-collection.c
@@ -155,7 +155,7 @@ static void clock_add(gpointer key, gpointer value, gpointer user_data)
  * correlate this trace with at least one other clock in the trace and
  * convert the index from cycles to real time.
  */
-int trace_collection_add(struct trace_collection *tc,
+int bt_trace_collection_add(struct trace_collection *tc,
 				struct trace_descriptor *td)
 {
 	struct ctf_trace *trace;
@@ -208,7 +208,7 @@ error:
 	return -EPERM;
 }
 
-int trace_collection_remove(struct trace_collection *tc,
+int bt_trace_collection_remove(struct trace_collection *tc,
 			    struct trace_descriptor *td)
 {
 	if (!tc || !td)
@@ -222,7 +222,7 @@ int trace_collection_remove(struct trace_collection *tc,
 
 }
 
-void init_trace_collection(struct trace_collection *tc)
+void bt_init_trace_collection(struct trace_collection *tc)
 {
 	assert(tc);
 	tc->array = g_ptr_array_new();
@@ -234,10 +234,10 @@ void init_trace_collection(struct trace_collection *tc)
 }
 
 /*
- * finalize_trace_collection() closes the opened traces for read
+ * bt_finalize_trace_collection() closes the opened traces for read
  * and free the memory allocated for trace collection
  */
-void finalize_trace_collection(struct trace_collection *tc)
+void bt_finalize_trace_collection(struct trace_collection *tc)
 {
 	assert(tc);
 	g_ptr_array_free(tc->array, TRUE);
-- 
1.7.10.4
