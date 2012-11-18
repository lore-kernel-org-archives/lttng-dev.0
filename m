From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] wfcqueue: enqueue and splice return queue state
Date: Sun, 18 Nov 2012 10:40:41 -0500
Message-ID: <20121118154041.GA29968__21658.0807268203$1353253285$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Ta6zD-0002md-Eu
	for lttng-dev@lists.lttng.org; Sun, 18 Nov 2012 10:40:43 -0500
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

enqueue can return whether the queue was empty or not prior to enqueue.

splice can return this information about destination queue too, but
there are more cases to handle, because we don't touch the destination
queue if the source queue was empty, and in the nonblocking case, we
return that we would need to block on the source queue.

The destination queue state is sampled atomically with enqueue/splice to
destination operations.

Knowing this state is useful when "ownership" on a batch of queue items
can be assigned to those enqueuing the first items, e.g. to implement
wait/wakeup schemes.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
---
diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
index 8733771..b386950 100644
--- a/urcu/static/wfcqueue.h
+++ b/urcu/static/wfcqueue.h
@@ -128,7 +128,7 @@ static inline void _cds_wfcq_dequeue_unlock(struct cds_wfcq_head *head,
 	assert(!ret);
 }
 
-static inline void ___cds_wfcq_append(struct cds_wfcq_head *head,
+static inline bool ___cds_wfcq_append(struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *new_head,
 		struct cds_wfcq_node *new_tail)
@@ -152,6 +152,11 @@ static inline void ___cds_wfcq_append(struct cds_wfcq_head *head,
 	 * perspective.
 	 */
 	CMM_STORE_SHARED(old_tail->next, new_head);
+	/*
+	 * Return false if queue was empty prior to adding the node,
+	 * else return true.
+	 */
+	return old_tail != &head->node;
 }
 
 /*
@@ -159,12 +164,15 @@ static inline void ___cds_wfcq_append(struct cds_wfcq_head *head,
  *
  * Issues a full memory barrier before enqueue. No mutual exclusion is
  * required.
+ *
+ * Returns false if the queue was empty prior to adding the node.
+ * Returns true otherwise.
  */
-static inline void _cds_wfcq_enqueue(struct cds_wfcq_head *head,
+static inline bool _cds_wfcq_enqueue(struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *new_tail)
 {
-	___cds_wfcq_append(head, tail, new_tail, new_tail);
+	return ___cds_wfcq_append(head, tail, new_tail, new_tail);
 }
 
 /*
@@ -373,7 +381,7 @@ ___cds_wfcq_dequeue_nonblocking(struct cds_wfcq_head *head,
 	return ___cds_wfcq_dequeue(head, tail, 0);
 }
 
-static inline int
+static inline enum cds_wfcq_ret
 ___cds_wfcq_splice(
 		struct cds_wfcq_head *dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
@@ -384,11 +392,11 @@ ___cds_wfcq_splice(
 	struct cds_wfcq_node *head, *tail;
 
 	if (_cds_wfcq_empty(src_q_head, src_q_tail))
-		return 0;
+		return CDS_WFCQ_RET_SRC_EMPTY;
 
 	head = ___cds_wfcq_node_sync_next(&src_q_head->node, blocking);
 	if (head == CDS_WFCQ_WOULDBLOCK)
-		return -1;
+		return CDS_WFCQ_RET_WOULDBLOCK;
 	_cds_wfcq_node_init(&src_q_head->node);
 
 	/*
@@ -403,8 +411,10 @@ ___cds_wfcq_splice(
 	 * Append the spliced content of src_q into dest_q. Does not
 	 * require mutual exclusion on dest_q (wait-free).
 	 */
-	___cds_wfcq_append(dest_q_head, dest_q_tail, head, tail);
-	return 0;
+	if (___cds_wfcq_append(dest_q_head, dest_q_tail, head, tail))
+		return CDS_WFCQ_RET_DEST_NON_EMPTY;
+	else
+		return CDS_WFCQ_RET_DEST_EMPTY;
 }
 
 
@@ -415,25 +425,27 @@ ___cds_wfcq_splice(
  * dest_q must be already initialized.
  * Dequeue/splice/iteration mutual exclusion for src_q should be ensured
  * by the caller.
+ * Returns enum cds_wfcq_ret which indicates the state of the src or
+ * dest queue. Never returns CDS_WFCQ_RET_WOULDBLOCK.
  */
-static inline void
+static inline enum cds_wfcq_ret
 ___cds_wfcq_splice_blocking(
 		struct cds_wfcq_head *dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
 		struct cds_wfcq_head *src_q_head,
 		struct cds_wfcq_tail *src_q_tail)
 {
-	(void) ___cds_wfcq_splice(dest_q_head, dest_q_tail,
+	return ___cds_wfcq_splice(dest_q_head, dest_q_tail,
 		src_q_head, src_q_tail, 1);
 }
 
 /*
  * __cds_wfcq_splice_nonblocking: enqueue all src_q nodes at the end of dest_q.
  *
- * Same as __cds_wfcq_splice_blocking, but returns nonzero if it needs to
- * block.
+ * Same as __cds_wfcq_splice_blocking, but returns
+ * CDS_WFCQ_RET_WOULDBLOCK if it needs to block.
  */
-static inline int
+static inline enum cds_wfcq_ret
 ___cds_wfcq_splice_nonblocking(
 		struct cds_wfcq_head *dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
@@ -474,18 +486,23 @@ _cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
  * consistent, but no other memory ordering is ensured.
  * Mutual exlusion with cds_wfcq_dequeue_blocking and dequeue lock is
  * ensured.
+ * Returns enum cds_wfcq_ret which indicates the state of the src or
+ * dest queue. Never returns CDS_WFCQ_RET_WOULDBLOCK.
  */
-static inline void
+static inline enum cds_wfcq_ret
 _cds_wfcq_splice_blocking(
 		struct cds_wfcq_head *dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
 		struct cds_wfcq_head *src_q_head,
 		struct cds_wfcq_tail *src_q_tail)
 {
+	enum cds_wfcq_ret ret;
+
 	_cds_wfcq_dequeue_lock(src_q_head, src_q_tail);
-	___cds_wfcq_splice_blocking(dest_q_head, dest_q_tail,
+	ret = ___cds_wfcq_splice_blocking(dest_q_head, dest_q_tail,
 			src_q_head, src_q_tail);
 	_cds_wfcq_dequeue_unlock(src_q_head, src_q_tail);
+	return ret;
 }
 
 #ifdef __cplusplus
diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
index fe2862e..ddf6b87 100644
--- a/urcu/wfcqueue.h
+++ b/urcu/wfcqueue.h
@@ -45,6 +45,13 @@ extern "C" {
 
 #define CDS_WFCQ_WOULDBLOCK	((void *) -1UL)
 
+enum cds_wfcq_ret {
+	CDS_WFCQ_RET_WOULDBLOCK = 	-1,
+	CDS_WFCQ_RET_DEST_EMPTY =	0,
+	CDS_WFCQ_RET_DEST_NON_EMPTY =	1,
+	CDS_WFCQ_RET_SRC_EMPTY = 	2,
+};
+
 struct cds_wfcq_node {
 	struct cds_wfcq_node *next;
 };
@@ -156,8 +163,11 @@ extern void cds_wfcq_dequeue_unlock(struct cds_wfcq_head *head,
  *
  * Issues a full memory barrier before enqueue. No mutual exclusion is
  * required.
+ *
+ * Returns false if the queue was empty prior to adding the node.
+ * Returns true otherwise.
  */
-extern void cds_wfcq_enqueue(struct cds_wfcq_head *head,
+extern bool cds_wfcq_enqueue(struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *node);
 
@@ -183,8 +193,11 @@ extern struct cds_wfcq_node *cds_wfcq_dequeue_blocking(
  * consistent, but no other memory ordering is ensured.
  * Mutual exlusion with cds_wfcq_dequeue_blocking and dequeue lock is
  * ensured.
+ *
+ * Returns enum cds_wfcq_ret which indicates the state of the src or
+ * dest queue. Cannot block.
  */
-extern void cds_wfcq_splice_blocking(
+extern enum cds_wfcq_ret cds_wfcq_splice_blocking(
 		struct cds_wfcq_head *dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
 		struct cds_wfcq_head *src_q_head,
@@ -222,8 +235,11 @@ extern struct cds_wfcq_node *__cds_wfcq_dequeue_nonblocking(
  * consistent, but no other memory ordering is ensured.
  * Dequeue/splice/iteration mutual exclusion for src_q should be ensured
  * by the caller.
+ *
+ * Returns enum cds_wfcq_ret which indicates the state of the src or
+ * dest queue. Cannot block.
  */
-extern void __cds_wfcq_splice_blocking(
+extern enum cds_wfcq_ret __cds_wfcq_splice_blocking(
 		struct cds_wfcq_head *dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
 		struct cds_wfcq_head *src_q_head,
@@ -232,10 +248,10 @@ extern void __cds_wfcq_splice_blocking(
 /*
  * __cds_wfcq_splice_nonblocking: enqueue all src_q nodes at the end of dest_q.
  *
- * Same as __cds_wfcq_splice_blocking, but returns nonzero if it needs to
- * block.
+ * Same as __cds_wfcq_splice_blocking, but returns
+ * CDS_WFCQ_RET_WOULDBLOCK if it needs to block.
  */
-extern int __cds_wfcq_splice_nonblocking(
+extern enum cds_wfcq_ret __cds_wfcq_splice_nonblocking(
 		struct cds_wfcq_head *dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
 		struct cds_wfcq_head *src_q_head,
diff --git a/wfcqueue.c b/wfcqueue.c
index 90b810e..207df95 100644
--- a/wfcqueue.c
+++ b/wfcqueue.c
@@ -47,11 +47,11 @@ bool cds_wfcq_empty(struct cds_wfcq_head *head,
 	return _cds_wfcq_empty(head, tail);
 }
 
-void cds_wfcq_enqueue(struct cds_wfcq_head *head,
+bool cds_wfcq_enqueue(struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *node)
 {
-	_cds_wfcq_enqueue(head, tail, node);
+	return _cds_wfcq_enqueue(head, tail, node);
 }
 
 void cds_wfcq_dequeue_lock(struct cds_wfcq_head *head,
@@ -73,13 +73,13 @@ struct cds_wfcq_node *cds_wfcq_dequeue_blocking(
 	return _cds_wfcq_dequeue_blocking(head, tail);
 }
 
-void cds_wfcq_splice_blocking(
+enum cds_wfcq_ret cds_wfcq_splice_blocking(
 		struct cds_wfcq_head *dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
 		struct cds_wfcq_head *src_q_head,
 		struct cds_wfcq_tail *src_q_tail)
 {
-	_cds_wfcq_splice_blocking(dest_q_head, dest_q_tail,
+	return _cds_wfcq_splice_blocking(dest_q_head, dest_q_tail,
 				src_q_head, src_q_tail);
 }
 
@@ -97,17 +97,17 @@ struct cds_wfcq_node *__cds_wfcq_dequeue_nonblocking(
 	return ___cds_wfcq_dequeue_nonblocking(head, tail);
 }
 
-void __cds_wfcq_splice_blocking(
+enum cds_wfcq_ret __cds_wfcq_splice_blocking(
 		struct cds_wfcq_head *dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
 		struct cds_wfcq_head *src_q_head,
 		struct cds_wfcq_tail *src_q_tail)
 {
-	___cds_wfcq_splice_blocking(dest_q_head, dest_q_tail,
+	return ___cds_wfcq_splice_blocking(dest_q_head, dest_q_tail,
 				src_q_head, src_q_tail);
 }
 
-int __cds_wfcq_splice_nonblocking(
+enum cds_wfcq_ret __cds_wfcq_splice_nonblocking(
 		struct cds_wfcq_head *dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
 		struct cds_wfcq_head *src_q_head,
-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
