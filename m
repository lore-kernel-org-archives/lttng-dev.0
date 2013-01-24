From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 13/18] namespace the heap functions
Date: Thu, 24 Jan 2013 16:21:45 -0500
Message-ID: <1359062510-7557-13-git-send-email-jdesfossez__17672.208013437$1359064787$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFU-0008F6-0p
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 16:22:16 -0500
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
 formats/ctf/iterator.c         |    2 +-
 include/babeltrace/prio_heap.h |   34 ++++++++++++-------------
 lib/iterator.c                 |   54 ++++++++++++++++++++--------------------
 lib/prio_heap/prio_heap.c      |   20 +++++++--------
 4 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/formats/ctf/iterator.c b/formats/ctf/iterator.c
index 0534d01..d2cd914 100644
--- a/formats/ctf/iterator.c
+++ b/formats/ctf/iterator.c
@@ -120,7 +120,7 @@ struct bt_ctf_event *bt_ctf_iter_read_event_flags(struct bt_ctf_iter *iter,
 	assert(iter);
 
 	ret = &iter->current_ctf_event;
-	file_stream = heap_maximum(iter->parent.stream_heap);
+	file_stream = bt_heap_maximum(iter->parent.stream_heap);
 	if (!file_stream) {
 		/* end of file for all streams */
 		goto stop;
diff --git a/include/babeltrace/prio_heap.h b/include/babeltrace/prio_heap.h
index 90aec8f..52de47c 100644
--- a/include/babeltrace/prio_heap.h
+++ b/include/babeltrace/prio_heap.h
@@ -47,38 +47,38 @@ void check_heap(const struct ptr_heap *heap)
 #endif
 
 /**
- * heap_maximum - return the largest element in the heap
+ * bt_heap_maximum - return the largest element in the heap
  * @heap: the heap to be operated on
  *
  * Returns the largest element in the heap, without performing any modification
  * to the heap structure. Returns NULL if the heap is empty.
  */
-static inline void *heap_maximum(const struct ptr_heap *heap)
+static inline void *bt_heap_maximum(const struct ptr_heap *heap)
 {
 	check_heap(heap);
 	return likely(heap->len) ? heap->ptrs[0] : NULL;
 }
 
 /**
- * heap_init - initialize the heap
+ * bt_heap_init - initialize the heap
  * @heap: the heap to initialize
  * @alloc_len: number of elements initially allocated
  * @gt: function to compare the elements
  *
  * Returns -ENOMEM if out of memory.
  */
-extern int heap_init(struct ptr_heap *heap,
+extern int bt_heap_init(struct ptr_heap *heap,
 		     size_t alloc_len,
 		     int gt(void *a, void *b));
 
 /**
- * heap_free - free the heap
+ * bt_heap_free - free the heap
  * @heap: the heap to free
  */
-extern void heap_free(struct ptr_heap *heap);
+extern void bt_heap_free(struct ptr_heap *heap);
 
 /**
- * heap_insert - insert an element into the heap
+ * bt_heap_insert - insert an element into the heap
  * @heap: the heap to be operated on
  * @p: the element to add
  *
@@ -86,19 +86,19 @@ extern void heap_free(struct ptr_heap *heap);
  *
  * Returns -ENOMEM if out of memory.
  */
-extern int heap_insert(struct ptr_heap *heap, void *p);
+extern int bt_heap_insert(struct ptr_heap *heap, void *p);
 
 /**
- * heap_remove - remove the largest element from the heap
+ * bt_heap_remove - remove the largest element from the heap
  * @heap: the heap to be operated on
  *
  * Returns the largest element in the heap. It removes this element from the
  * heap. Returns NULL if the heap is empty.
  */
-extern void *heap_remove(struct ptr_heap *heap);
+extern void *bt_heap_remove(struct ptr_heap *heap);
 
 /**
- * heap_cherrypick - remove a given element from the heap
+ * bt_heap_cherrypick - remove a given element from the heap
  * @heap: the heap to be operated on
  * @p: the element
  *
@@ -106,10 +106,10 @@ extern void *heap_remove(struct ptr_heap *heap);
  * return NULL. This algorithm has a complexity of O(n), which is higher than
  * O(log(n)) provided by the rest of this API.
  */
-extern void *heap_cherrypick(struct ptr_heap *heap, void *p);
+extern void *bt_heap_cherrypick(struct ptr_heap *heap, void *p);
 
 /**
- * heap_replace_max - replace the the largest element from the heap
+ * bt_heap_replace_max - replace the the largest element from the heap
  * @heap: the heap to be operated on
  * @p: the pointer to be inserted as topmost element replacement
  *
@@ -117,18 +117,18 @@ extern void *heap_cherrypick(struct ptr_heap *heap, void *p);
  * heap. The heap is rebalanced only once after the insertion. Returns NULL if
  * the heap is empty.
  *
- * This is the equivalent of calling heap_remove() and then heap_insert(), but
+ * This is the equivalent of calling bt_heap_remove() and then bt_heap_insert(), but
  * it only rebalances the heap once. It never allocates memory.
  */
-extern void *heap_replace_max(struct ptr_heap *heap, void *p);
+extern void *bt_heap_replace_max(struct ptr_heap *heap, void *p);
 
 /**
- * heap_copy - copy a heap
+ * bt_heap_copy - copy a heap
  * @dst: the destination heap (must be allocated)
  * @src: the source heap
  *
  * Returns -ENOMEM if out of memory.
  */
-extern int heap_copy(struct ptr_heap *dst, struct ptr_heap *src);
+extern int bt_heap_copy(struct ptr_heap *dst, struct ptr_heap *src);
 
 #endif /* _BABELTRACE_PRIO_HEAP_H */
diff --git a/lib/iterator.c b/lib/iterator.c
index 41a4602..dc12a2f 100644
--- a/lib/iterator.c
+++ b/lib/iterator.c
@@ -180,7 +180,7 @@ static int seek_ctf_trace_by_timestamp(struct ctf_trace *tin,
 			ret = seek_file_stream_by_timestamp(cfs, timestamp);
 			if (ret == 0) {
 				/* Add to heap */
-				ret = heap_insert(stream_heap, cfs);
+				ret = bt_heap_insert(stream_heap, cfs);
 				if (ret) {
 					/* Return positive error. */
 					return -ret;
@@ -358,8 +358,8 @@ int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
 		if (!iter_pos->u.restore)
 			return -EINVAL;
 
-		heap_free(iter->stream_heap);
-		ret = heap_init(iter->stream_heap, 0, stream_compare);
+		bt_heap_free(iter->stream_heap);
+		ret = bt_heap_init(iter->stream_heap, 0, stream_compare);
 		if (ret < 0)
 			goto error_heap_init;
 
@@ -404,7 +404,7 @@ int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
 			}
 
 			/* Add to heap */
-			ret = heap_insert(iter->stream_heap,
+			ret = bt_heap_insert(iter->stream_heap,
 					saved_pos->file_stream);
 			if (ret)
 				goto error;
@@ -413,8 +413,8 @@ int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
 	case BT_SEEK_TIME:
 		tc = iter->ctx->tc;
 
-		heap_free(iter->stream_heap);
-		ret = heap_init(iter->stream_heap, 0, stream_compare);
+		bt_heap_free(iter->stream_heap);
+		ret = bt_heap_init(iter->stream_heap, 0, stream_compare);
 		if (ret < 0)
 			goto error_heap_init;
 
@@ -444,8 +444,8 @@ int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
 		return 0;
 	case BT_SEEK_BEGIN:
 		tc = iter->ctx->tc;
-		heap_free(iter->stream_heap);
-		ret = heap_init(iter->stream_heap, 0, stream_compare);
+		bt_heap_free(iter->stream_heap);
+		ret = bt_heap_init(iter->stream_heap, 0, stream_compare);
 		if (ret < 0)
 			goto error_heap_init;
 
@@ -487,7 +487,7 @@ int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
 						/* Do not add EOF streams */
 						continue;
 					}
-					ret = heap_insert(iter->stream_heap, file_stream);
+					ret = bt_heap_insert(iter->stream_heap, file_stream);
 					if (ret)
 						goto error;
 				}
@@ -503,13 +503,13 @@ int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
 		if (ret != 0 || !cfs)
 			goto error;
 		/* remove all streams from the heap */
-		heap_free(iter->stream_heap);
+		bt_heap_free(iter->stream_heap);
 		/* Create a new empty heap */
-		ret = heap_init(iter->stream_heap, 0, stream_compare);
+		ret = bt_heap_init(iter->stream_heap, 0, stream_compare);
 		if (ret < 0)
 			goto error;
 		/* Insert the stream that contains the last event */
-		ret = heap_insert(iter->stream_heap, cfs);
+		ret = bt_heap_insert(iter->stream_heap, cfs);
 		if (ret)
 			goto error;
 		break;
@@ -522,10 +522,10 @@ int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
 	return 0;
 
 error:
-	heap_free(iter->stream_heap);
+	bt_heap_free(iter->stream_heap);
 error_heap_init:
-	if (heap_init(iter->stream_heap, 0, stream_compare) < 0) {
-		heap_free(iter->stream_heap);
+	if (bt_heap_init(iter->stream_heap, 0, stream_compare) < 0) {
+		bt_heap_free(iter->stream_heap);
 		g_free(iter->stream_heap);
 		iter->stream_heap = NULL;
 		ret = -ENOMEM;
@@ -555,12 +555,12 @@ struct bt_iter_pos *bt_iter_get_pos(struct bt_iter *iter)
 	if (!pos->u.restore->stream_saved_pos)
 		goto error;
 
-	ret = heap_copy(&iter_heap_copy, iter->stream_heap);
+	ret = bt_heap_copy(&iter_heap_copy, iter->stream_heap);
 	if (ret < 0)
 		goto error_heap;
 
 	/* iterate over each stream in the heap */
-	file_stream = heap_maximum(&iter_heap_copy);
+	file_stream = bt_heap_maximum(&iter_heap_copy);
 	while (file_stream != NULL) {
 		struct stream_saved_pos saved_pos;
 
@@ -584,12 +584,12 @@ struct bt_iter_pos *bt_iter_get_pos(struct bt_iter *iter)
 				saved_pos.current_real_timestamp);
 
 		/* remove the stream from the heap copy */
-		removed = heap_remove(&iter_heap_copy);
+		removed = bt_heap_remove(&iter_heap_copy);
 		assert(removed == file_stream);
 
-		file_stream = heap_maximum(&iter_heap_copy);
+		file_stream = bt_heap_maximum(&iter_heap_copy);
 	}
-	heap_free(&iter_heap_copy);
+	bt_heap_free(&iter_heap_copy);
 	return pos;
 
 error_heap:
@@ -669,7 +669,7 @@ int bt_iter_init(struct bt_iter *iter,
 	bt_context_get(ctx);
 	iter->ctx = ctx;
 
-	ret = heap_init(iter->stream_heap, 0, stream_compare);
+	ret = bt_heap_init(iter->stream_heap, 0, stream_compare);
 	if (ret < 0)
 		goto error_heap_init;
 
@@ -718,7 +718,7 @@ int bt_iter_init(struct bt_iter *iter,
 					goto error;
 				}
 				/* Add to heap */
-				ret = heap_insert(iter->stream_heap, file_stream);
+				ret = bt_heap_insert(iter->stream_heap, file_stream);
 				if (ret)
 					goto error;
 			}
@@ -729,7 +729,7 @@ int bt_iter_init(struct bt_iter *iter,
 	return 0;
 
 error:
-	heap_free(iter->stream_heap);
+	bt_heap_free(iter->stream_heap);
 error_heap_init:
 	g_free(iter->stream_heap);
 	iter->stream_heap = NULL;
@@ -760,7 +760,7 @@ void bt_iter_fini(struct bt_iter *iter)
 {
 	assert(iter);
 	if (iter->stream_heap) {
-		heap_free(iter->stream_heap);
+		bt_heap_free(iter->stream_heap);
 		g_free(iter->stream_heap);
 	}
 	iter->ctx->current_iterator = NULL;
@@ -782,7 +782,7 @@ int bt_iter_next(struct bt_iter *iter)
 	if (!iter)
 		return -EINVAL;
 
-	file_stream = heap_maximum(iter->stream_heap);
+	file_stream = bt_heap_maximum(iter->stream_heap);
 	if (!file_stream) {
 		/* end of file for all streams */
 		ret = 0;
@@ -791,7 +791,7 @@ int bt_iter_next(struct bt_iter *iter)
 
 	ret = stream_read_event(file_stream);
 	if (ret == EOF) {
-		removed = heap_remove(iter->stream_heap);
+		removed = bt_heap_remove(iter->stream_heap);
 		assert(removed == file_stream);
 		ret = 0;
 		goto end;
@@ -799,7 +799,7 @@ int bt_iter_next(struct bt_iter *iter)
 		goto end;
 	}
 	/* Reinsert the file stream into the heap, and rebalance. */
-	removed = heap_replace_max(iter->stream_heap, file_stream);
+	removed = bt_heap_replace_max(iter->stream_heap, file_stream);
 	assert(removed == file_stream);
 
 end:
diff --git a/lib/prio_heap/prio_heap.c b/lib/prio_heap/prio_heap.c
index 43b4e8a..8942a11 100644
--- a/lib/prio_heap/prio_heap.c
+++ b/lib/prio_heap/prio_heap.c
@@ -102,7 +102,7 @@ int heap_set_len(struct ptr_heap *heap, size_t new_len)
 	return 0;
 }
 
-int heap_init(struct ptr_heap *heap, size_t alloc_len,
+int bt_heap_init(struct ptr_heap *heap, size_t alloc_len,
 	      int gt(void *a, void *b))
 {
 	heap->ptrs = NULL;
@@ -111,12 +111,12 @@ int heap_init(struct ptr_heap *heap, size_t alloc_len,
 	heap->gt = gt;
 	/*
 	 * Minimum size allocated is 1 entry to ensure memory allocation
-	 * never fails within heap_replace_max.
+	 * never fails within bt_heap_replace_max.
 	 */
 	return heap_grow(heap, max_t(size_t, 1, alloc_len));
 }
 
-void heap_free(struct ptr_heap *heap)
+void bt_heap_free(struct ptr_heap *heap)
 {
 	free(heap->ptrs);
 }
@@ -147,7 +147,7 @@ static void heapify(struct ptr_heap *heap, size_t i)
 	check_heap(heap);
 }
 
-void *heap_replace_max(struct ptr_heap *heap, void *p)
+void *bt_heap_replace_max(struct ptr_heap *heap, void *p)
 {
 	void *res;
 
@@ -165,7 +165,7 @@ void *heap_replace_max(struct ptr_heap *heap, void *p)
 	return res;
 }
 
-int heap_insert(struct ptr_heap *heap, void *p)
+int bt_heap_insert(struct ptr_heap *heap, void *p)
 {
 	void **ptrs;
 	size_t pos;
@@ -186,7 +186,7 @@ int heap_insert(struct ptr_heap *heap, void *p)
 	return 0;
 }
 
-void *heap_remove(struct ptr_heap *heap)
+void *bt_heap_remove(struct ptr_heap *heap)
 {
 	switch (heap->len) {
 	case 0:
@@ -198,10 +198,10 @@ void *heap_remove(struct ptr_heap *heap)
 	/* Shrink, replace the current max by previous last entry and heapify */
 	heap_set_len(heap, heap->len - 1);
 	/* len changed. previous last entry is at heap->len */
-	return heap_replace_max(heap, heap->ptrs[heap->len]);
+	return bt_heap_replace_max(heap, heap->ptrs[heap->len]);
 }
 
-void *heap_cherrypick(struct ptr_heap *heap, void *p)
+void *bt_heap_cherrypick(struct ptr_heap *heap, void *p)
 {
 	size_t pos, len = heap->len;
 
@@ -223,11 +223,11 @@ found:
 	return p;
 }
 
-int heap_copy(struct ptr_heap *dst, struct ptr_heap *src)
+int bt_heap_copy(struct ptr_heap *dst, struct ptr_heap *src)
 {
 	int ret;
 
-	ret = heap_init(dst, src->alloc_len, src->gt);
+	ret = bt_heap_init(dst, src->alloc_len, src->gt);
 	if (ret < 0)
 		goto end;
 
-- 
1.7.10.4
