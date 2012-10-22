From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] urcu wfcqueue: introduce nonblocking API
Date: Sun, 21 Oct 2012 22:30:49 -0400
Message-ID: <20121022023049.GA9653__8155.14302016727$1350873090$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TQ7n1-0006Ln-WF
	for lttng-dev@lists.lttng.org; Sun, 21 Oct 2012 22:30:52 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

Introduce nonblocking API in wfcqueue, allowing RT threads to try to
dequeue, splice, or iterate on spliced queues without blocking: the
caller needs to handle CDS_WFCQ_WOULDBLOCK return value (or nonzero
return value for splice).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Paul McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
---
diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
index 4a9003e..120a598 100644
--- a/urcu/static/wfcqueue.h
+++ b/urcu/static/wfcqueue.h
@@ -2,7 +2,7 @@
 #define _URCU_WFCQUEUE_STATIC_H
 
 /*
- * wfcqueue-static.h
+ * urcu/static/wfcqueue.h
  *
  * Userspace RCU library - Concurrent Queue with Wait-Free Enqueue/Blocking Dequeue
  *
@@ -171,7 +171,7 @@ static inline void _cds_wfcq_enqueue(struct cds_wfcq_head *head,
  * Waiting for enqueuer to complete enqueue and return the next node.
  */
 static inline struct cds_wfcq_node *
-___cds_wfcq_node_sync_next(struct cds_wfcq_node *node)
+___cds_wfcq_node_sync_next(struct cds_wfcq_node *node, int blocking)
 {
 	struct cds_wfcq_node *next;
 	int attempt = 0;
@@ -180,6 +180,8 @@ ___cds_wfcq_node_sync_next(struct cds_wfcq_node *node)
 	 * Adaptative busy-looping waiting for enqueuer to complete enqueue.
 	 */
 	while ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
+		if (!blocking)
+			return CDS_WFCQ_WOULDBLOCK;
 		if (++attempt >= WFCQ_ADAPT_ATTEMPTS) {
 			poll(NULL, 0, WFCQ_WAIT);	/* Wait for 10ms */
 			attempt = 0;
@@ -191,34 +193,23 @@ ___cds_wfcq_node_sync_next(struct cds_wfcq_node *node)
 	return next;
 }
 
-/*
- * __cds_wfcq_first_blocking: get first node of a queue, without dequeuing.
- *
- * Content written into the node before enqueue is guaranteed to be
- * consistent, but no other memory ordering is ensured.
- * Dequeue/splice/iteration mutual exclusion should be ensured by the
- * caller.
- *
- * Used by for-like iteration macros in urcu/wfqueue.h:
- * __cds_wfcq_for_each_blocking()
- * __cds_wfcq_for_each_blocking_safe()
- */
 static inline struct cds_wfcq_node *
-___cds_wfcq_first_blocking(struct cds_wfcq_head *head,
-		struct cds_wfcq_tail *tail)
+___cds_wfcq_first(struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail,
+		int blocking)
 {
 	struct cds_wfcq_node *node;
 
 	if (_cds_wfcq_empty(head, tail))
 		return NULL;
-	node = ___cds_wfcq_node_sync_next(&head->node);
+	node = ___cds_wfcq_node_sync_next(&head->node, blocking);
 	/* Load head->node.next before loading node's content */
 	cmm_smp_read_barrier_depends();
 	return node;
 }
 
 /*
- * __cds_wfcq_next_blocking: get next node of a queue, without dequeuing.
+ * __cds_wfcq_first_blocking: get first node of a queue, without dequeuing.
  *
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
@@ -230,9 +221,31 @@ ___cds_wfcq_first_blocking(struct cds_wfcq_head *head,
  * __cds_wfcq_for_each_blocking_safe()
  */
 static inline struct cds_wfcq_node *
-___cds_wfcq_next_blocking(struct cds_wfcq_head *head,
+___cds_wfcq_first_blocking(struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail)
+{
+	return ___cds_wfcq_first(head, tail, 1);
+}
+
+
+/*
+ * __cds_wfcq_first_nonblocking: get first node of a queue, without dequeuing.
+ *
+ * Same as __cds_wfcq_first_blocking, but returns CDS_WFCQ_WOULDBLOCK if
+ * it needs to block.
+ */
+static inline struct cds_wfcq_node *
+___cds_wfcq_first_nonblocking(struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail)
+{
+	return ___cds_wfcq_first(head, tail, 0);
+}
+
+static inline struct cds_wfcq_node *
+___cds_wfcq_next(struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail,
-		struct cds_wfcq_node *node)
+		struct cds_wfcq_node *node,
+		int blocking)
 {
 	struct cds_wfcq_node *next;
 
@@ -247,7 +260,7 @@ ___cds_wfcq_next_blocking(struct cds_wfcq_head *head,
 		cmm_smp_rmb();
 		if (CMM_LOAD_SHARED(tail->p) == node)
 			return NULL;
-		next = ___cds_wfcq_node_sync_next(node);
+		next = ___cds_wfcq_node_sync_next(node, blocking);
 	}
 	/* Load node->next before loading next's content */
 	cmm_smp_read_barrier_depends();
@@ -255,24 +268,50 @@ ___cds_wfcq_next_blocking(struct cds_wfcq_head *head,
 }
 
 /*
- * __cds_wfcq_dequeue_blocking: dequeue a node from the queue.
+ * __cds_wfcq_next_blocking: get next node of a queue, without dequeuing.
  *
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
- * It is valid to reuse and free a dequeued node immediately.
  * Dequeue/splice/iteration mutual exclusion should be ensured by the
  * caller.
+ *
+ * Used by for-like iteration macros in urcu/wfqueue.h:
+ * __cds_wfcq_for_each_blocking()
+ * __cds_wfcq_for_each_blocking_safe()
  */
 static inline struct cds_wfcq_node *
-___cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
-		struct cds_wfcq_tail *tail)
+___cds_wfcq_next_blocking(struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail,
+		struct cds_wfcq_node *node)
+{
+	return ___cds_wfcq_next(head, tail, node, 1);
+}
+
+/*
+ * __cds_wfcq_next_blocking: get next node of a queue, without dequeuing.
+ *
+ * Same as __cds_wfcq_next_blocking, but returns CDS_WFCQ_WOULDBLOCK if
+ * it needs to block.
+ */
+static inline struct cds_wfcq_node *
+___cds_wfcq_next_nonblocking(struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail,
+		struct cds_wfcq_node *node)
+{
+	return ___cds_wfcq_next(head, tail, node, 0);
+}
+
+static inline struct cds_wfcq_node *
+___cds_wfcq_dequeue(struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail,
+		int blocking)
 {
 	struct cds_wfcq_node *node, *next;
 
 	if (_cds_wfcq_empty(head, tail))
 		return NULL;
 
-	node = ___cds_wfcq_node_sync_next(&head->node);
+	node = ___cds_wfcq_node_sync_next(&head->node, blocking);
 
 	if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
 		/*
@@ -292,7 +331,7 @@ ___cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
 		_cds_wfcq_node_init(&head->node);
 		if (uatomic_cmpxchg(&tail->p, node, &head->node) == node)
 			return node;
-		next = ___cds_wfcq_node_sync_next(node);
+		next = ___cds_wfcq_node_sync_next(node, blocking);
 	}
 
 	/*
@@ -306,26 +345,50 @@ ___cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
 }
 
 /*
- * __cds_wfcq_splice_blocking: enqueue all src_q nodes at the end of dest_q.
+ * __cds_wfcq_dequeue_blocking: dequeue a node from the queue.
  *
- * Dequeue all nodes from src_q.
- * dest_q must be already initialized.
- * Dequeue/splice/iteration mutual exclusion for src_q should be ensured
- * by the caller.
+ * Content written into the node before enqueue is guaranteed to be
+ * consistent, but no other memory ordering is ensured.
+ * It is valid to reuse and free a dequeued node immediately.
+ * Dequeue/splice/iteration mutual exclusion should be ensured by the
+ * caller.
  */
-static inline void
-___cds_wfcq_splice_blocking(
+static inline struct cds_wfcq_node *
+___cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail)
+{
+	return ___cds_wfcq_dequeue(head, tail, 1);
+}
+
+/*
+ * __cds_wfcq_dequeue_nonblocking: dequeue a node from a wait-free queue.
+ *
+ * Same as __cds_wfcq_dequeue_blocking, but returns CDS_WFCQ_WOULDBLOCK
+ * if it needs to block.
+ */
+static inline struct cds_wfcq_node *
+___cds_wfcq_dequeue_nonblocking(struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail)
+{
+	return ___cds_wfcq_dequeue(head, tail, 0);
+}
+
+static inline int
+___cds_wfcq_splice(
 		struct cds_wfcq_head *dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
 		struct cds_wfcq_head *src_q_head,
-		struct cds_wfcq_tail *src_q_tail)
+		struct cds_wfcq_tail *src_q_tail,
+		int blocking)
 {
 	struct cds_wfcq_node *head, *tail;
 
 	if (_cds_wfcq_empty(src_q_head, src_q_tail))
-		return;
+		return 0;
 
-	head = ___cds_wfcq_node_sync_next(&src_q_head->node);
+	head = ___cds_wfcq_node_sync_next(&src_q_head->node, blocking);
+	if (head == CDS_WFCQ_WOULDBLOCK)
+		return -1;
 	_cds_wfcq_node_init(&src_q_head->node);
 
 	/*
@@ -341,6 +404,44 @@ ___cds_wfcq_splice_blocking(
 	 * require mutual exclusion on dest_q (wait-free).
 	 */
 	___cds_wfcq_append(dest_q_head, dest_q_tail, head, tail);
+	return 0;
+}
+
+
+/*
+ * __cds_wfcq_splice_blocking: enqueue all src_q nodes at the end of dest_q.
+ *
+ * Dequeue all nodes from src_q.
+ * dest_q must be already initialized.
+ * Dequeue/splice/iteration mutual exclusion for src_q should be ensured
+ * by the caller.
+ */
+static inline void
+___cds_wfcq_splice_blocking(
+		struct cds_wfcq_head *dest_q_head,
+		struct cds_wfcq_tail *dest_q_tail,
+		struct cds_wfcq_head *src_q_head,
+		struct cds_wfcq_tail *src_q_tail)
+{
+	(void) ___cds_wfcq_splice(dest_q_head, dest_q_tail,
+		src_q_head, src_q_tail, 1);
+}
+
+/*
+ * __cds_wfcq_splice_nonblocking: enqueue all src_q nodes at the end of dest_q.
+ *
+ * Same as __cds_wfcq_splice_blocking, but returns nonzero if it needs to
+ * block.
+ */
+static inline int
+___cds_wfcq_splice_nonblocking(
+		struct cds_wfcq_head *dest_q_head,
+		struct cds_wfcq_tail *dest_q_tail,
+		struct cds_wfcq_head *src_q_head,
+		struct cds_wfcq_tail *src_q_tail)
+{
+	return ___cds_wfcq_splice(dest_q_head, dest_q_tail,
+		src_q_head, src_q_tail, 0);
 }
 
 /*
diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
index ba2f2ed..fe2862e 100644
--- a/urcu/wfcqueue.h
+++ b/urcu/wfcqueue.h
@@ -2,7 +2,7 @@
 #define _URCU_WFCQUEUE_H
 
 /*
- * wfcqueue.h
+ * urcu/wfcqueue.h
  *
  * Userspace RCU library - Concurrent Queue with Wait-Free Enqueue/Blocking Dequeue
  *
@@ -43,6 +43,8 @@ extern "C" {
  * McKenney.
  */
 
+#define CDS_WFCQ_WOULDBLOCK	((void *) -1UL)
+
 struct cds_wfcq_node {
 	struct cds_wfcq_node *next;
 };
@@ -86,6 +88,16 @@ struct cds_wfcq_tail {
 #define __cds_wfcq_first_blocking	___cds_wfcq_first_blocking
 #define __cds_wfcq_next_blocking	___cds_wfcq_next_blocking
 
+/*
+ * Locking ensured by caller by holding cds_wfcq_dequeue_lock().
+ * Non-blocking: deque, first, next return CDS_WFCQ_WOULDBLOCK if they
+ * need to block. splice returns nonzero if it needs to block.
+ */
+#define __cds_wfcq_dequeue_nonblocking	___cds_wfcq_dequeue_nonblocking
+#define __cds_wfcq_splice_nonblocking	___cds_wfcq_splice_nonblocking
+#define __cds_wfcq_first_nonblocking	___cds_wfcq_first_nonblocking
+#define __cds_wfcq_next_nonblocking	___cds_wfcq_next_nonblocking
+
 #else /* !_LGPL_SOURCE */
 
 /*
@@ -179,7 +191,7 @@ extern void cds_wfcq_splice_blocking(
 		struct cds_wfcq_tail *src_q_tail);
 
 /*
- * __cds_wfcq_dequeue_blocking:
+ * __cds_wfcq_dequeue_blocking: dequeue a node from a wait-free queue.
  *
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
@@ -192,6 +204,16 @@ extern struct cds_wfcq_node *__cds_wfcq_dequeue_blocking(
 		struct cds_wfcq_tail *tail);
 
 /*
+ * __cds_wfcq_dequeue_nonblocking: dequeue a node from a wait-free queue.
+ *
+ * Same as __cds_wfcq_dequeue_blocking, but returns CDS_WFCQ_WOULDBLOCK
+ * if it needs to block.
+ */
+extern struct cds_wfcq_node *__cds_wfcq_dequeue_nonblocking(
+		struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail);
+
+/*
  * __cds_wfcq_splice_blocking: enqueue all src_q nodes at the end of dest_q.
  *
  * Dequeue all nodes from src_q.
@@ -208,6 +230,18 @@ extern void __cds_wfcq_splice_blocking(
 		struct cds_wfcq_tail *src_q_tail);
 
 /*
+ * __cds_wfcq_splice_nonblocking: enqueue all src_q nodes at the end of dest_q.
+ *
+ * Same as __cds_wfcq_splice_blocking, but returns nonzero if it needs to
+ * block.
+ */
+extern int __cds_wfcq_splice_nonblocking(
+		struct cds_wfcq_head *dest_q_head,
+		struct cds_wfcq_tail *dest_q_tail,
+		struct cds_wfcq_head *src_q_head,
+		struct cds_wfcq_tail *src_q_tail);
+
+/*
  * __cds_wfcq_first_blocking: get first node of a queue, without dequeuing.
  *
  * Content written into the node before enqueue is guaranteed to be
@@ -224,6 +258,16 @@ extern struct cds_wfcq_node *__cds_wfcq_first_blocking(
 		struct cds_wfcq_tail *tail);
 
 /*
+ * __cds_wfcq_first_nonblocking: get first node of a queue, without dequeuing.
+ *
+ * Same as __cds_wfcq_first_blocking, but returns CDS_WFCQ_WOULDBLOCK if
+ * it needs to block.
+ */
+extern struct cds_wfcq_node *__cds_wfcq_first_nonblocking(
+		struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail);
+
+/*
  * __cds_wfcq_next_blocking: get next node of a queue, without dequeuing.
  *
  * Content written into the node before enqueue is guaranteed to be
@@ -240,6 +284,17 @@ extern struct cds_wfcq_node *__cds_wfcq_next_blocking(
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *node);
 
+/*
+ * __cds_wfcq_next_blocking: get next node of a queue, without dequeuing.
+ *
+ * Same as __cds_wfcq_next_blocking, but returns CDS_WFCQ_WOULDBLOCK if
+ * it needs to block.
+ */
+extern struct cds_wfcq_node *__cds_wfcq_next_nonblocking(
+		struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail,
+		struct cds_wfcq_node *node);
+
 #endif /* !_LGPL_SOURCE */
 
 /*
diff --git a/wfcqueue.c b/wfcqueue.c
index 1fa27ac..3474ee0 100644
--- a/wfcqueue.c
+++ b/wfcqueue.c
@@ -90,6 +90,13 @@ struct cds_wfcq_node *__cds_wfcq_dequeue_blocking(
 	return ___cds_wfcq_dequeue_blocking(head, tail);
 }
 
+struct cds_wfcq_node *__cds_wfcq_dequeue_nonblocking(
+		struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail)
+{
+	return ___cds_wfcq_dequeue_nonblocking(head, tail);
+}
+
 void __cds_wfcq_splice_blocking(
 		struct cds_wfcq_head *dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
@@ -100,6 +107,16 @@ void __cds_wfcq_splice_blocking(
 				src_q_head, src_q_tail);
 }
 
+int __cds_wfcq_splice_nonblocking(
+		struct cds_wfcq_head *dest_q_head,
+		struct cds_wfcq_tail *dest_q_tail,
+		struct cds_wfcq_head *src_q_head,
+		struct cds_wfcq_tail *src_q_tail)
+{
+	return ___cds_wfcq_splice_nonblocking(dest_q_head, dest_q_tail,
+				src_q_head, src_q_tail);
+}
+
 struct cds_wfcq_node *__cds_wfcq_first_blocking(
 		struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail)
@@ -107,6 +124,13 @@ struct cds_wfcq_node *__cds_wfcq_first_blocking(
 	return ___cds_wfcq_first_blocking(head, tail);
 }
 
+struct cds_wfcq_node *__cds_wfcq_first_nonblocking(
+		struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail)
+{
+	return ___cds_wfcq_first_nonblocking(head, tail);
+}
+
 struct cds_wfcq_node *__cds_wfcq_next_blocking(
 		struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail,
@@ -114,3 +138,11 @@ struct cds_wfcq_node *__cds_wfcq_next_blocking(
 {
 	return ___cds_wfcq_next_blocking(head, tail, node);
 }
+
+struct cds_wfcq_node *__cds_wfcq_next_nonblocking(
+		struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail,
+		struct cds_wfcq_node *node)
+{
+	return ___cds_wfcq_next_nonblocking(head, tail, node);
+}

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
