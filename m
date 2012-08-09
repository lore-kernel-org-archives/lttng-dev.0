From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [PATCH 2/2] urcu: new wfqueue implementation
Date: Thu, 9 Aug 2012 16:46:26 +0800
Message-ID: <1344501986-23151-2-git-send-email-laijs__23598.4248145998$1344502102$gmane$org@cn.fujitsu.com>
References: <1344501986-23151-1-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1SzOOG-0008Ih-1b
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 04:46:49 -0400
In-Reply-To: <1344501986-23151-1-git-send-email-laijs@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>
List-Id: lttng-dev@lists.lttng.org

Some guys would be surprised by this fact:
There are already TWO implementations of wfqueue in urcu.

The first one is in urcu/static/wfqueue.h:
1) enqueue: exchange the tail and then update previous->next
2) dequeue: wait for first node's next pointer and them shift, a dummy node
	is introduced to avoid the queue->tail become NULL when shift.

The second one shares some code with the first one, and the left code
are spreading in urcu-call-rcu-impl.h:
1) enqueue: share with the first one
2) no dequeue operation: and no shift, so it don't need dummy node,
	Although the dummy node is queued when initialization, but it is removed
	after the first dequeue_all operation in call_rcu_thread().
	call_rcu_data_free() forgets to handle the dummy node if it is not removed.
3)dequeue_all: record the old head and tail, and queue->head become the special
	tail node.(atomic record the tail and change the tail).

The second implementation's code are spreading, bad for review, and it is not
tested by tests/test_urcu_wfq.

So we need a better implementation avoid the dummy node dancing and can service
both generic wfqueue APIs and dequeue_all API for call rcu.

The new implementation:
1) enqueue: share with the first one/original implementation.
2) dequeue: shift when node count >= 2, cmpxchg when node count = 1.
	no dummy node, save memory.
3) dequeue_all: simply set queue->head.next to NULL, xchg the tail
	and return the old head.next.

More implementation details are in the code.
tests/test_urcu_wfq will be update in future for testing new APIs.


Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
---
 urcu-call-rcu-impl.h  |   50 ++++++++++--------------
 urcu/static/wfqueue.h |  104 ++++++++++++++++++++++++++++++++++++------------
 urcu/wfqueue.h        |   25 ++++++++++--
 wfqueue.c             |   29 ++++++++++++++
 4 files changed, 149 insertions(+), 59 deletions(-)

diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
index 13b24ff..dbfb410 100644
--- a/urcu-call-rcu-impl.h
+++ b/urcu-call-rcu-impl.h
@@ -221,7 +221,7 @@ static void *call_rcu_thread(void *arg)
 {
 	unsigned long cbcount;
 	struct cds_wfq_node *cbs;
-	struct cds_wfq_node **cbs_tail;
+	struct cds_wfq_node *cbs_tail;
 	struct call_rcu_data *crdp = (struct call_rcu_data *)arg;
 	struct rcu_head *rhp;
 	int rt = !!(uatomic_read(&crdp->flags) & URCU_CALL_RCU_RT);
@@ -243,24 +243,18 @@ static void *call_rcu_thread(void *arg)
 		cmm_smp_mb();
 	}
 	for (;;) {
-		if (&crdp->cbs.head != _CMM_LOAD_SHARED(crdp->cbs.tail)) {
-			while ((cbs = _CMM_LOAD_SHARED(crdp->cbs.head)) == NULL)
-				poll(NULL, 0, 1);
-			_CMM_STORE_SHARED(crdp->cbs.head, NULL);
-			cbs_tail = (struct cds_wfq_node **)
-				uatomic_xchg(&crdp->cbs.tail, &crdp->cbs.head);
+		cbs = __cds_wfq_dequeue_all_blocking(&crdp->cbs, &cbs_tail);
+		if (cbs) {
 			synchronize_rcu();
 			cbcount = 0;
 			do {
-				while (cbs->next == NULL &&
-				       &cbs->next != cbs_tail)
-				       	poll(NULL, 0, 1);
-				if (cbs == &crdp->cbs.dummy) {
-					cbs = cbs->next;
-					continue;
-				}
 				rhp = (struct rcu_head *)cbs;
-				cbs = cbs->next;
+
+				if (cbs != cbs_tail)
+					cbs = __cds_wfq_node_sync_next(cbs);
+				else
+					cbs = NULL;
+
 				rhp->func(rhp);
 				cbcount++;
 			} while (cbs != NULL);
@@ -270,8 +264,7 @@ static void *call_rcu_thread(void *arg)
 			break;
 		rcu_thread_offline();
 		if (!rt) {
-			if (&crdp->cbs.head
-			    == _CMM_LOAD_SHARED(crdp->cbs.tail)) {
+			if (cds_wfq_empty(&crdp->cbs)) {
 				call_rcu_wait(crdp);
 				poll(NULL, 0, 10);
 				uatomic_dec(&crdp->futex);
@@ -625,32 +618,31 @@ void call_rcu(struct rcu_head *head,
  */
 void call_rcu_data_free(struct call_rcu_data *crdp)
 {
-	struct cds_wfq_node *cbs;
-	struct cds_wfq_node **cbs_tail;
-	struct cds_wfq_node **cbs_endprev;
+	struct cds_wfq_node *head, *tail;
 
 	if (crdp == NULL || crdp == default_call_rcu_data) {
 		return;
 	}
+
 	if ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0) {
 		uatomic_or(&crdp->flags, URCU_CALL_RCU_STOP);
 		wake_call_rcu_thread(crdp);
 		while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0)
 			poll(NULL, 0, 1);
 	}
-	if (&crdp->cbs.head != _CMM_LOAD_SHARED(crdp->cbs.tail)) {
-		while ((cbs = _CMM_LOAD_SHARED(crdp->cbs.head)) == NULL)
-			poll(NULL, 0, 1);
-		_CMM_STORE_SHARED(crdp->cbs.head, NULL);
-		cbs_tail = (struct cds_wfq_node **)
-			uatomic_xchg(&crdp->cbs.tail, &crdp->cbs.head);
+
+	if (!cds_wfq_empty(&crdp->cbs)) {
+		head = __cds_wfq_dequeue_all_blocking(&crdp->cbs, &tail);
+		assert(head);
+
 		/* Create default call rcu data if need be */
 		(void) get_default_call_rcu_data();
-		cbs_endprev = (struct cds_wfq_node **)
-			uatomic_xchg(&default_call_rcu_data, cbs_tail);
-		*cbs_endprev = cbs;
+
+		__cds_wfq_append_list(&default_call_rcu_data->cbs, head, tail);
+
 		uatomic_add(&default_call_rcu_data->qlen,
 			    uatomic_read(&crdp->qlen));
+
 		wake_call_rcu_thread(default_call_rcu_data);
 	}
 
diff --git a/urcu/static/wfqueue.h b/urcu/static/wfqueue.h
index 636e1af..15ea9fc 100644
--- a/urcu/static/wfqueue.h
+++ b/urcu/static/wfqueue.h
@@ -10,6 +10,7 @@
  * dynamically with the userspace rcu library.
  *
  * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright 2011-2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -29,6 +30,7 @@
 #include <pthread.h>
 #include <assert.h>
 #include <poll.h>
+#include <stdbool.h>
 #include <urcu/compiler.h>
 #include <urcu/uatomic.h>
 
@@ -38,8 +40,6 @@ extern "C" {
 
 /*
  * Queue with wait-free enqueue/blocking dequeue.
- * This implementation adds a dummy head node when the queue is empty to ensure
- * we can always update the queue locklessly.
  *
  * Inspired from half-wait-free/half-blocking queue implementation done by
  * Paul E. McKenney.
@@ -57,31 +57,43 @@ static inline void _cds_wfq_init(struct cds_wfq_queue *q)
 {
 	int ret;
 
-	_cds_wfq_node_init(&q->dummy);
 	/* Set queue head and tail */
-	q->head = &q->dummy;
-	q->tail = &q->dummy.next;
+	_cds_wfq_node_init(&q->head);
+	q->tail = &q->head;
 	ret = pthread_mutex_init(&q->lock, NULL);
 	assert(!ret);
 }
 
-static inline void _cds_wfq_enqueue(struct cds_wfq_queue *q,
-				    struct cds_wfq_node *node)
+static inline bool _cds_wfq_empty(struct cds_wfq_queue *q)
 {
-	struct cds_wfq_node **old_tail;
+	/*
+	 * Queue is empty if no node is pointed by q->head.next nor q->tail.
+	 */
+	return q->head.next == NULL && CMM_LOAD_SHARED(q->tail) == &q->head;
+}
 
+static inline void ___cds_wfq_append_list(struct cds_wfq_queue *q,
+		struct cds_wfq_node *head, struct cds_wfq_node *tail)
+{
 	/*
 	 * uatomic_xchg() implicit memory barrier orders earlier stores to data
 	 * structure containing node and setting node->next to NULL before
 	 * publication.
 	 */
-	old_tail = uatomic_xchg(&q->tail, &node->next);
+	tail = uatomic_xchg(&q->tail, tail);
+
 	/*
-	 * At this point, dequeuers see a NULL old_tail->next, which indicates
+	 * At this point, dequeuers see a NULL tail->next, which indicates
 	 * that the queue is being appended to. The following store will append
 	 * "node" to the queue from a dequeuer perspective.
 	 */
-	CMM_STORE_SHARED(*old_tail, node);
+	CMM_STORE_SHARED(tail->next, head);
+}
+
+static inline void _cds_wfq_enqueue(struct cds_wfq_queue *q,
+				    struct cds_wfq_node *node)
+{
+	___cds_wfq_append_list(q, node, node);
 }
 
 /*
@@ -120,27 +132,46 @@ ___cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
 {
 	struct cds_wfq_node *node, *next;
 
-	/*
-	 * Queue is empty if it only contains the dummy node.
-	 */
-	if (q->head == &q->dummy && CMM_LOAD_SHARED(q->tail) == &q->dummy.next)
+	if (_cds_wfq_empty(q))
 		return NULL;
-	node = q->head;
 
-	next = ___cds_wfq_node_sync_next(node);
+	node = ___cds_wfq_node_sync_next(&q->head);
+
+	if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
+		if (CMM_LOAD_SHARED(q->tail) == node) {
+			/*
+			 * @node is the only node in the queue.
+			 * Try to move the tail to &q->head
+			 */
+			_cds_wfq_node_init(&q->head);
+			if (uatomic_cmpxchg(&q->tail, node, &q->head) == node)
+				return node;
+		}
+		next = ___cds_wfq_node_sync_next(node);
+	}
 
 	/*
 	 * Move queue head forward.
 	 */
-	q->head = next;
-	/*
-	 * Requeue dummy node if we just dequeued it.
-	 */
-	if (node == &q->dummy) {
-		_cds_wfq_node_init(node);
-		_cds_wfq_enqueue(q, node);
-		return ___cds_wfq_dequeue_blocking(q);
-	}
+	q->head.next = next;
+
+	return node;
+}
+
+/* dequeue all nodes, the nodes are not synchronized for the next pointer */
+static inline struct cds_wfq_node *
+___cds_wfq_dequeue_all_blocking(struct cds_wfq_queue *q,
+		struct cds_wfq_node **tail)
+{
+	struct cds_wfq_node *node;
+
+	if (_cds_wfq_empty(q))
+		return NULL;
+
+	node = ___cds_wfq_node_sync_next(&q->head);
+	_cds_wfq_node_init(&q->head);
+	*tail = uatomic_xchg(&q->tail, &q->head);
+
 	return node;
 }
 
@@ -158,6 +189,27 @@ _cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
 	return retnode;
 }
 
+static inline struct cds_wfq_node *
+_cds_wfq_dequeue_all_blocking(struct cds_wfq_queue *q,
+		struct cds_wfq_node **tail)
+{
+	struct cds_wfq_node *node, *next;
+	int ret;
+
+	ret = pthread_mutex_lock(&q->lock);
+	assert(!ret);
+	node = ___cds_wfq_dequeue_all_blocking(q, tail);
+	ret = pthread_mutex_unlock(&q->lock);
+	assert(!ret);
+
+	/* synchronize all nodes' next pointer */
+	next = node;
+	while (next != *tail)
+		next = ___cds_wfq_node_sync_next(next);
+
+	return node;
+}
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/urcu/wfqueue.h b/urcu/wfqueue.h
index 03a73f1..985f540 100644
--- a/urcu/wfqueue.h
+++ b/urcu/wfqueue.h
@@ -7,6 +7,7 @@
  * Userspace RCU library - Queue with Wait-Free Enqueue/Blocking Dequeue
  *
  * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright 2011-2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -25,6 +26,7 @@
 
 #include <pthread.h>
 #include <assert.h>
+#include <stdbool.h>
 #include <urcu/compiler.h>
 
 #ifdef __cplusplus
@@ -33,8 +35,6 @@ extern "C" {
 
 /*
  * Queue with wait-free enqueue/blocking dequeue.
- * This implementation adds a dummy head node when the queue is empty to ensure
- * we can always update the queue locklessly.
  *
  * Inspired from half-wait-free/half-blocking queue implementation done by
  * Paul E. McKenney.
@@ -45,8 +45,7 @@ struct cds_wfq_node {
 };
 
 struct cds_wfq_queue {
-	struct cds_wfq_node *head, **tail;
-	struct cds_wfq_node dummy;	/* Dummy node */
+	struct cds_wfq_node head, *tail;
 	pthread_mutex_t lock;
 };
 
@@ -56,18 +55,36 @@ struct cds_wfq_queue {
 
 #define cds_wfq_node_init		_cds_wfq_node_init
 #define cds_wfq_init		_cds_wfq_init
+#define cds_wfq_empty		_cds_wfq_empty
+#define __cds_wfq_append_list	___cds_wfq_append_list
 #define cds_wfq_enqueue		_cds_wfq_enqueue
 #define __cds_wfq_dequeue_blocking	___cds_wfq_dequeue_blocking
 #define cds_wfq_dequeue_blocking	_cds_wfq_dequeue_blocking
+#define __cds_wfq_node_sync_next	___cds_wfq_node_sync_next
+#define __cds_wfq_dequeue_all_blocking	___cds_wfq_dequeue_all_blocking
+#define cds_wfq_dequeue_all_blocking	_cds_wfq_dequeue_all_blocking
 
 #else /* !_LGPL_SOURCE */
 
 extern void cds_wfq_node_init(struct cds_wfq_node *node);
 extern void cds_wfq_init(struct cds_wfq_queue *q);
+extern bool cds_wfq_empty(struct cds_wfq_queue *q);
+/* __cds_wfq_append_list: caller ensures mutual exclusion between dequeues */
+extern void __cds_wfq_append_list(struct cds_wfq_queue *q,
+		struct cds_wfq_node *head, struct cds_wfq_node *tail);
 extern void cds_wfq_enqueue(struct cds_wfq_queue *q, struct cds_wfq_node *node);
 /* __cds_wfq_dequeue_blocking: caller ensures mutual exclusion between dequeues */
 extern struct cds_wfq_node *__cds_wfq_dequeue_blocking(struct cds_wfq_queue *q);
 extern struct cds_wfq_node *cds_wfq_dequeue_blocking(struct cds_wfq_queue *q);
+extern struct cds_wfq_node *__cds_wfq_node_sync_next(struct cds_wfq_node *node);
+/*
+ * __cds_wfq_dequeue_all_blocking: caller ensures mutual exclusion between
+ * dequeues, and need synchronize next pointer berfore use it.
+ */
+extern struct cds_wfq_node *__cds_wfq_dequeue_all_blocking(
+		struct cds_wfq_queue *q, struct cds_wfq_node **tail);
+extern struct cds_wfq_node *cds_wfq_dequeue_all_blocking(
+		struct cds_wfq_queue *q, struct cds_wfq_node **tail);
 
 #endif /* !_LGPL_SOURCE */
 
diff --git a/wfqueue.c b/wfqueue.c
index 3337171..28a7b58 100644
--- a/wfqueue.c
+++ b/wfqueue.c
@@ -4,6 +4,7 @@
  * Userspace RCU library - Queue with Wait-Free Enqueue/Blocking Dequeue
  *
  * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright 2011-2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -38,6 +39,17 @@ void cds_wfq_init(struct cds_wfq_queue *q)
 	_cds_wfq_init(q);
 }
 
+bool cds_wfq_empty(struct cds_wfq_queue *q)
+{
+	return _cds_wfq_empty(q);
+}
+
+void __cds_wfq_append_list(struct cds_wfq_queue *q,
+		struct cds_wfq_node *head, struct cds_wfq_node *tail)
+{
+	return ___cds_wfq_append_list(q, head, tail);
+}
+
 void cds_wfq_enqueue(struct cds_wfq_queue *q, struct cds_wfq_node *node)
 {
 	_cds_wfq_enqueue(q, node);
@@ -52,3 +64,20 @@ struct cds_wfq_node *cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
 {
 	return _cds_wfq_dequeue_blocking(q);
 }
+
+struct cds_wfq_node *__cds_wfq_node_sync_next(struct cds_wfq_node *node)
+{
+	return ___cds_wfq_node_sync_next(node);
+}
+
+struct cds_wfq_node *__cds_wfq_dequeue_all_blocking(
+		struct cds_wfq_queue *q, struct cds_wfq_node **tail)
+{
+	return ___cds_wfq_dequeue_all_blocking(q, tail);
+}
+
+struct cds_wfq_node *cds_wfq_dequeue_all_blocking(
+		struct cds_wfq_queue *q, struct cds_wfq_node **tail)
+{
+	return _cds_wfq_dequeue_all_blocking(q, tail);
+}
-- 
1.7.7
