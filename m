From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC URCU PATCH] wfqueue: ABI v1,
	simplify implementation, 2.3x to	2.6x performance boost
Date: Wed, 15 Aug 2012 17:31:07 -0400
Message-ID: <20120815213107.GB17224__7244.8396510028$1345066301$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T1lBH-00039l-33
	for lttng-dev@lists.lttng.org; Wed, 15 Aug 2012 17:31:11 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

This work is derived from the patch from Lai Jiangshan submitted as
"urcu: new wfqueue implementation"
(http://lists.lttng.org/pipermail/lttng-dev/2012-August/018379.html)

Its changelog:

> Some guys would be surprised by this fact:
> There are already TWO implementations of wfqueue in urcu.
>
> The first one is in urcu/static/wfqueue.h:
> 1) enqueue: exchange the tail and then update previous->next
> 2) dequeue: wait for first node's next pointer and them shift, a dummy node
> 	is introduced to avoid the queue->tail become NULL when shift.
>
> The second one shares some code with the first one, and the left code
> are spreading in urcu-call-rcu-impl.h:
> 1) enqueue: share with the first one
> 2) no dequeue operation: and no shift, so it don't need dummy node,
> 	Although the dummy node is queued when initialization, but it is removed
> 	after the first dequeue_all operation in call_rcu_thread().
> 	call_rcu_data_free() forgets to handle the dummy node if it is not removed.
> 3)dequeue_all: record the old head and tail, and queue->head become the special
> 	tail node.(atomic record the tail and change the tail).
>
> The second implementation's code are spreading, bad for review, and it is not
> tested by tests/test_urcu_wfq.
>
> So we need a better implementation avoid the dummy node dancing and can service
> both generic wfqueue APIs and dequeue_all API for call rcu.
>
> The new implementation:
> 1) enqueue: share with the first one/original implementation.
> 2) dequeue: shift when node count >= 2, cmpxchg when node count = 1.
> 	no dummy node, save memory.
> 3) dequeue_all: simply set queue->head.next to NULL, xchg the tail
> 	and return the old head.next.
>
> More implementation details are in the code.
> tests/test_urcu_wfq will be update in future for testing new APIs.

The patch proposed by Lai brings a very interesting simplification to
the single-node handling (which is kept here), and moves all queue
handling code away from call_rcu implementation, back into the wfqueue
code. This has the benefit to allow testing enhancements.

I modified it so the API does not expose implementation details to the
user (e.g. ___cds_wfq_node_sync_next). I added a "splice" operation and
a for loop iterator which should allow wfqueue users to use the list
very efficiently both from LGPL/GPL code and from non-LGPL-compatible
code.

Benchmarks performed on Intel(R) Core(TM) i7-3520M CPU @ 2.90GHz
(dual-core, with hyperthreading)

Benchmark invoked:
for a in $(seq 1 10); do ./test_urcu_wfq 1 1 10 -a 0 -a 2; done

(using cpu number 0 and 2, which should correspond to two cores of my
Intel 2-core/hyperthread processor)

Before patch:

testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     97274297 nr_dequeues     80745742 successful enqueues     97274297 successful dequeues     80745321 end_dequeues 16528976 nr_ops    178020039
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     92300568 nr_dequeues     75019529 successful enqueues     92300568 successful dequeues     74973237 end_dequeues 17327331 nr_ops    167320097
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     93516443 nr_dequeues     75846726 successful enqueues     93516443 successful dequeues     75826578 end_dequeues 17689865 nr_ops    169363169
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     94160362 nr_dequeues     77967638 successful enqueues     94160362 successful dequeues     77967638 end_dequeues 16192724 nr_ops    172128000
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     97491956 nr_dequeues     81001191 successful enqueues     97491956 successful dequeues     81000247 end_dequeues 16491709 nr_ops    178493147
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     94101298 nr_dequeues     75650510 successful enqueues     94101298 successful dequeues     75649318 end_dequeues 18451980 nr_ops    169751808
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     94742803 nr_dequeues     75402105 successful enqueues     94742803 successful dequeues     75341859 end_dequeues 19400944 nr_ops    170144908
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     92198835 nr_dequeues     75037877 successful enqueues     92198835 successful dequeues     75027605 end_dequeues 17171230 nr_ops    167236712
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     94159560 nr_dequeues     77895972 successful enqueues     94159560 successful dequeues     77858442 end_dequeues 16301118 nr_ops    172055532
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     96059399 nr_dequeues     80115442 successful enqueues     96059399 successful dequeues     80066843 end_dequeues 15992556 nr_ops    176174841

After patch:

testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    221229322 nr_dequeues    210645491 successful enqueues    221229322 successful dequeues    210645088 end_dequeues 10584234 nr_ops    431874813
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    219803943 nr_dequeues    210377337 successful enqueues    219803943 successful dequeues    210368680 end_dequeues 9435263 nr_ops    430181280
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    237006358 nr_dequeues    237035340 successful enqueues    237006358 successful dequeues    236997050 end_dequeues 9308 nr_ops    474041698
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    235822443 nr_dequeues    235815942 successful enqueues    235822443 successful dequeues    235814020 end_dequeues 8423 nr_ops    471638385
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    235825567 nr_dequeues    235811803 successful enqueues    235825567 successful dequeues    235810526 end_dequeues 15041 nr_ops    471637370
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    221974953 nr_dequeues    210938190 successful enqueues    221974953 successful dequeues    210938190 end_dequeues 11036763 nr_ops    432913143
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    237994492 nr_dequeues    237938119 successful enqueues    237994492 successful dequeues    237930648 end_dequeues 63844 nr_ops    475932611
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    220634365 nr_dequeues    210491382 successful enqueues    220634365 successful dequeues    210490995 end_dequeues 10143370 nr_ops    431125747
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    237388065 nr_dequeues    237401251 successful enqueues    237388065 successful dequeues    237380295 end_dequeues 7770 nr_ops    474789316
testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    221201436 nr_dequeues    210831162 successful enqueues    221201436 successful dequeues    210831162 end_dequeues 10370274 nr_ops    432032598

Summary: Both enqueue and dequeue speed increase: around 2.3x speedup
for enqueue, and around 2.6x for dequeue.

We can verify that:
   successful enqueues - successful dequeues = end_dequeues

For all runs (ensures correctness: no lost node).

* Introduce wfqueue ABI v1 (false-sharing fix)

wfqueue v0 suffers from false-sharing between head and tail. By
cache-aligning head and tail, we get a significant speedup on
benchmarks. But in order to do that, we need to break the ABI to enlarge
struct cds_wfq_queue.

Provide a backward compatibility ABI for the old wfqueue by defining the
original symbols to the old implementation (which uses dummy node).
Programs compiled against old headers, which are not LGPL_SOURCE, will
still use the old implementation.

Any code compiled against the new header will directly use the new ABI.

This does not require any change in the way users call the API: the new
ABI symbols are simply defined with _1 suffix, and wrapped by
preprocessor macros.

Known limitation: users should *not* link together objects using the v0
and v1 APIs of wfqueue and exchange struct cds_wfq_queue structures
between the two. The only way to run into this corner-case would be to
combine objects compiled with different versions of the urcu/wfqueue.h
header.

CC: Lai Jiangshan <laijs@cn.fujitsu.com>
CC: Paul McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/Makefile.am b/Makefile.am
index 2396fcf..31052ef 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -53,7 +53,7 @@ lib_LTLIBRARIES = liburcu-common.la \
 # liburcu-common contains wait-free queues (needed by call_rcu) as well
 # as futex fallbacks.
 #
-liburcu_common_la_SOURCES = wfqueue.c wfstack.c $(COMPAT)
+liburcu_common_la_SOURCES = wfqueue.c wfqueue0.c wfstack.c $(COMPAT)
 
 liburcu_la_SOURCES = urcu.c urcu-pointer.c $(COMPAT)
 liburcu_la_LIBADD = liburcu-common.la
diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
index 13b24ff..d8537d0 100644
--- a/urcu-call-rcu-impl.h
+++ b/urcu-call-rcu-impl.h
@@ -21,6 +21,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <stdio.h>
 #include <pthread.h>
 #include <signal.h>
@@ -220,10 +221,7 @@ static void call_rcu_wake_up(struct call_rcu_data *crdp)
 static void *call_rcu_thread(void *arg)
 {
 	unsigned long cbcount;
-	struct cds_wfq_node *cbs;
-	struct cds_wfq_node **cbs_tail;
-	struct call_rcu_data *crdp = (struct call_rcu_data *)arg;
-	struct rcu_head *rhp;
+	struct call_rcu_data *crdp = (struct call_rcu_data *) arg;
 	int rt = !!(uatomic_read(&crdp->flags) & URCU_CALL_RCU_RT);
 	int ret;
 
@@ -243,35 +241,30 @@ static void *call_rcu_thread(void *arg)
 		cmm_smp_mb();
 	}
 	for (;;) {
-		if (&crdp->cbs.head != _CMM_LOAD_SHARED(crdp->cbs.tail)) {
-			while ((cbs = _CMM_LOAD_SHARED(crdp->cbs.head)) == NULL)
-				poll(NULL, 0, 1);
-			_CMM_STORE_SHARED(crdp->cbs.head, NULL);
-			cbs_tail = (struct cds_wfq_node **)
-				uatomic_xchg(&crdp->cbs.tail, &crdp->cbs.head);
+		struct cds_wfq_queue cbs_tmp;
+		struct cds_wfq_node *cbs, *tmp_cbs;
+
+		cds_wfq_init(&cbs_tmp);
+		__cds_wfq_splice_blocking(&cbs_tmp, &crdp->cbs);
+		if (!cds_wfq_empty(&cbs_tmp)) {
 			synchronize_rcu();
 			cbcount = 0;
-			do {
-				while (cbs->next == NULL &&
-				       &cbs->next != cbs_tail)
-				       	poll(NULL, 0, 1);
-				if (cbs == &crdp->cbs.dummy) {
-					cbs = cbs->next;
-					continue;
-				}
-				rhp = (struct rcu_head *)cbs;
-				cbs = cbs->next;
+			__cds_wfq_for_each_blocking_safe(&cbs_tmp,
+					cbs, tmp_cbs) {
+				struct rcu_head *rhp;
+
+				rhp = caa_container_of(cbs,
+					struct rcu_head, next);
 				rhp->func(rhp);
 				cbcount++;
-			} while (cbs != NULL);
+			}
 			uatomic_sub(&crdp->qlen, cbcount);
 		}
 		if (uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOP)
 			break;
 		rcu_thread_offline();
 		if (!rt) {
-			if (&crdp->cbs.head
-			    == _CMM_LOAD_SHARED(crdp->cbs.tail)) {
+			if (cds_wfq_empty(&crdp->cbs)) {
 				call_rcu_wait(crdp);
 				poll(NULL, 0, 10);
 				uatomic_dec(&crdp->futex);
@@ -625,32 +618,27 @@ void call_rcu(struct rcu_head *head,
  */
 void call_rcu_data_free(struct call_rcu_data *crdp)
 {
-	struct cds_wfq_node *cbs;
-	struct cds_wfq_node **cbs_tail;
-	struct cds_wfq_node **cbs_endprev;
-
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
 		/* Create default call rcu data if need be */
 		(void) get_default_call_rcu_data();
-		cbs_endprev = (struct cds_wfq_node **)
-			uatomic_xchg(&default_call_rcu_data, cbs_tail);
-		*cbs_endprev = cbs;
+
+		__cds_wfq_splice_blocking(&default_call_rcu_data->cbs,
+					&crdp->cbs);
+
 		uatomic_add(&default_call_rcu_data->qlen,
 			    uatomic_read(&crdp->qlen));
+
 		wake_call_rcu_thread(default_call_rcu_data);
 	}
 
diff --git a/urcu/static/wfqueue.h b/urcu/static/wfqueue.h
index 636e1af..52e452d 100644
--- a/urcu/static/wfqueue.h
+++ b/urcu/static/wfqueue.h
@@ -9,7 +9,8 @@
  * TO BE INCLUDED ONLY IN LGPL-COMPATIBLE CODE. See wfqueue.h for linking
  * dynamically with the userspace rcu library.
  *
- * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 
@@ -38,11 +40,16 @@ extern "C" {
 
 /*
  * Queue with wait-free enqueue/blocking dequeue.
- * This implementation adds a dummy head node when the queue is empty to ensure
- * we can always update the queue locklessly.
  *
  * Inspired from half-wait-free/half-blocking queue implementation done by
  * Paul E. McKenney.
+ *
+ * Caller must ensure mutual exclusion of queue update operations
+ * "dequeue" and "splice" source queue. Queue read operations "first"
+ * and "next" need to be protected against concurrent "dequeue" and
+ * "splice" (for source queue) by the caller. "enqueue", "splice"
+ * (destination queue), and "empty" are the only operations that can be
+ * used without any mutual exclusion.
  */
 
 #define WFQ_ADAPT_ATTEMPTS		10	/* Retry if being set */
@@ -57,31 +64,55 @@ static inline void _cds_wfq_init(struct cds_wfq_queue *q)
 {
 	int ret;
 
-	_cds_wfq_node_init(&q->dummy);
 	/* Set queue head and tail */
-	q->head = &q->dummy;
-	q->tail = &q->dummy.next;
-	ret = pthread_mutex_init(&q->lock, NULL);
+	_cds_wfq_node_init(&q->dequeue.head);
+	q->enqueue.tail = &q->dequeue.head;
+	ret = pthread_mutex_init(&q->dequeue.lock, NULL);
 	assert(!ret);
 }
 
-static inline void _cds_wfq_enqueue(struct cds_wfq_queue *q,
-				    struct cds_wfq_node *node)
+static inline bool _cds_wfq_empty(struct cds_wfq_queue *q)
 {
-	struct cds_wfq_node **old_tail;
+	/*
+	 * Queue is empty if no node is pointed by q->head.next nor
+	 * q->tail. Even though the q->tail check is sufficient to find
+	 * out of the queue is empty, we first check q->head.next as a
+	 * common case to ensure that dequeuers do not frequently access
+	 * enqueuer's q->tail cache line.
+	 */
+	return CMM_LOAD_SHARED(q->dequeue.head.next) == NULL
+		&& CMM_LOAD_SHARED(q->enqueue.tail) == &q->dequeue.head;
+}
+
+static inline void ___cds_wfq_append(struct cds_wfq_queue *q,
+		struct cds_wfq_node *new_head,
+		struct cds_wfq_node *new_tail)
+{
+	struct cds_wfq_node *old_tail;
 
 	/*
-	 * uatomic_xchg() implicit memory barrier orders earlier stores to data
-	 * structure containing node and setting node->next to NULL before
-	 * publication.
+	 * Implicit memory barrier before uatomic_xchg() orders earlier
+	 * stores to data structure containing node and setting
+	 * node->next to NULL before publication.
 	 */
-	old_tail = uatomic_xchg(&q->tail, &node->next);
+	old_tail = uatomic_xchg(&q->enqueue.tail, new_tail);
+
 	/*
-	 * At this point, dequeuers see a NULL old_tail->next, which indicates
-	 * that the queue is being appended to. The following store will append
-	 * "node" to the queue from a dequeuer perspective.
+	 * Implicit memory barrier after uatomic_xchg() orders store to
+	 * q->tail before store to old_tail->next.
+	 *
+	 * At this point, dequeuers see a NULL q->tail->next, which
+	 * indicates that the queue is being appended to. The following
+	 * store will append "node" to the queue from a dequeuer
+	 * perspective.
 	 */
-	CMM_STORE_SHARED(*old_tail, node);
+	CMM_STORE_SHARED(old_tail->next, new_head);
+}
+
+static inline void _cds_wfq_enqueue(struct cds_wfq_queue *q,
+		struct cds_wfq_node *new_tail)
+{
+	___cds_wfq_append(q, new_tail, new_tail);
 }
 
 /*
@@ -100,14 +131,68 @@ ___cds_wfq_node_sync_next(struct cds_wfq_node *node)
 		if (++attempt >= WFQ_ADAPT_ATTEMPTS) {
 			poll(NULL, 0, WFQ_WAIT);	/* Wait for 10ms */
 			attempt = 0;
-		} else
+		} else {
 			caa_cpu_relax();
+		}
 	}
 
 	return next;
 }
 
 /*
+ * ___cds_wfq_first_blocking: get first node of a queue, without dequeuing.
+ *
+ * Mutual exclusion with "dequeue" and "splice" operations must be ensured
+ * by the caller.
+ */
+static inline struct cds_wfq_node *
+___cds_wfq_first_blocking(struct cds_wfq_queue *q)
+{
+	struct cds_wfq_node *node;
+
+	if (_cds_wfq_empty(q))
+		return NULL;
+	node = ___cds_wfq_node_sync_next(&q->dequeue.head);
+	/* Load q->head.next before loading node's content */
+	cmm_smp_read_barrier_depends();
+	return node;
+}
+
+/*
+ * ___cds_wfq_next_blocking: get next node of a queue, without dequeuing.
+ *
+ * Mutual exclusion with "dequeue" and "splice" operations must be ensured
+ * by the caller.
+ */
+static inline struct cds_wfq_node *
+___cds_wfq_next_blocking(struct cds_wfq_queue *q, struct cds_wfq_node *node)
+{
+	struct cds_wfq_node *next;
+
+	/*
+	 * Even though the following q->tail check is sufficient to find
+	 * out if we reached the end of the queue, we first check
+	 * node->next as a common case to ensure that iteration on nodes
+	 * do not frequently access enqueuer's q->tail cache line.
+	 */
+	if ((next = CMM_LOAD_SHARED(node->next)) != NULL) {
+		/* Load node->next before loading next's content */
+		cmm_smp_read_barrier_depends();
+		return next;
+	}
+	/* Load node->next before q->tail */
+	cmm_smp_rmb();
+	if (CMM_LOAD_SHARED(q->enqueue.tail) == node)
+		return NULL;
+	next = ___cds_wfq_node_sync_next(node);
+	/* Load node->next before loading next's content */
+	cmm_smp_read_barrier_depends();
+	return next;
+}
+
+/*
+ * ___cds_wfq_dequeue_blocking: dequeue a node from the queue.
+ *
  * It is valid to reuse and free a dequeued node immediately.
  *
  * No need to go on a waitqueue here, as there is no possible state in which the
@@ -120,42 +205,104 @@ ___cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
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
+	node = ___cds_wfq_node_sync_next(&q->dequeue.head);
+
+	if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
+		/*
+		 * @node is probably the only node in the queue.
+		 * Try to move the tail to &q->head.
+		 * q->head.next is set to NULL here, and stays
+		 * NULL if the cmpxchg succeeds. Should the
+		 * cmpxchg fail due to a concurrent enqueue, the
+		 * q->head.next will be set to the next node.
+		 * The implicit memory barrier before
+		 * uatomic_cmpxchg() orders load node->next
+		 * before loading q->tail.
+		 * The implicit memory barrier before uatomic_cmpxchg
+		 * orders load q->head.next before loading node's
+		 * content.
+		 */
+		_cds_wfq_node_init(&q->dequeue.head);
+		if (uatomic_cmpxchg(&q->enqueue.tail, node,
+				&q->dequeue.head) == node)
+			return node;
+		next = ___cds_wfq_node_sync_next(node);
+	}
 
 	/*
 	 * Move queue head forward.
 	 */
-	q->head = next;
+	q->dequeue.head.next = next;
+
+	/* Load q->head.next before loading node's content */
+	cmm_smp_read_barrier_depends();
+	return node;
+}
+
+/*
+ * ___cds_wfq_splice_blocking: enqueue all src_q nodes at the end of dest_q.
+ *
+ * Dequeue all nodes from src_q.
+ * dest_q must be already initialized.
+ * caller ensures mutual exclusion of dequeue and splice operations on
+ * src_q.
+ */
+static inline void
+___cds_wfq_splice_blocking(struct cds_wfq_queue *dest_q,
+		struct cds_wfq_queue *src_q)
+{
+	struct cds_wfq_node *head, *tail;
+
+	if (_cds_wfq_empty(src_q))
+		return;
+
+	head = ___cds_wfq_node_sync_next(&src_q->dequeue.head);
+	_cds_wfq_node_init(&src_q->dequeue.head);
+
 	/*
-	 * Requeue dummy node if we just dequeued it.
+	 * Memory barrier implied before uatomic_xchg() orders store to
+	 * src_q->head before store to src_q->tail. This is required by
+	 * concurrent enqueue on src_q, which exchanges the tail before
+	 * updating the previous tail's next pointer.
 	 */
-	if (node == &q->dummy) {
-		_cds_wfq_node_init(node);
-		_cds_wfq_enqueue(q, node);
-		return ___cds_wfq_dequeue_blocking(q);
-	}
-	return node;
+	tail = uatomic_xchg(&src_q->enqueue.tail, &src_q->dequeue.head);
+
+	/*
+	 * Append the spliced content of src_q into dest_q. Does not
+	 * require mutual exclusion on dest_q (wait-free).
+	 */
+	___cds_wfq_append(dest_q, head, tail);
 }
 
+/* Locking performed within cds_wfq calls. */
 static inline struct cds_wfq_node *
 _cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
 {
-	struct cds_wfq_node *retnode;
+	struct cds_wfq_node *retval;
+	int ret;
+
+	ret = pthread_mutex_lock(&q->dequeue.lock);
+	assert(!ret);
+	retval = ___cds_wfq_dequeue_blocking(q);
+	ret = pthread_mutex_unlock(&q->dequeue.lock);
+	assert(!ret);
+	return retval;
+}
+
+static inline void
+_cds_wfq_splice_blocking(struct cds_wfq_queue *dest_q,
+		struct cds_wfq_queue *src_q)
+{
 	int ret;
 
-	ret = pthread_mutex_lock(&q->lock);
+	ret = pthread_mutex_lock(&src_q->dequeue.lock);
 	assert(!ret);
-	retnode = ___cds_wfq_dequeue_blocking(q);
-	ret = pthread_mutex_unlock(&q->lock);
+	___cds_wfq_splice_blocking(dest_q, src_q);
+	ret = pthread_mutex_unlock(&src_q->dequeue.lock);
 	assert(!ret);
-	return retnode;
 }
 
 #ifdef __cplusplus
diff --git a/urcu/wfqueue.h b/urcu/wfqueue.h
index 03a73f1..446c94c 100644
--- a/urcu/wfqueue.h
+++ b/urcu/wfqueue.h
@@ -6,7 +6,8 @@
  *
  * Userspace RCU library - Queue with Wait-Free Enqueue/Blocking Dequeue
  *
- * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright 2011-2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -25,7 +26,9 @@
 
 #include <pthread.h>
 #include <assert.h>
+#include <stdbool.h>
 #include <urcu/compiler.h>
+#include <urcu/arch.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -33,8 +36,6 @@ extern "C" {
 
 /*
  * Queue with wait-free enqueue/blocking dequeue.
- * This implementation adds a dummy head node when the queue is empty to ensure
- * we can always update the queue locklessly.
  *
  * Inspired from half-wait-free/half-blocking queue implementation done by
  * Paul E. McKenney.
@@ -45,9 +46,13 @@ struct cds_wfq_node {
 };
 
 struct cds_wfq_queue {
-	struct cds_wfq_node *head, **tail;
-	struct cds_wfq_node dummy;	/* Dummy node */
-	pthread_mutex_t lock;
+	struct {
+		struct cds_wfq_node head;
+		pthread_mutex_t lock;
+	} __attribute__((aligned((CAA_CACHE_LINE_SIZE)))) dequeue;
+	struct {
+		struct cds_wfq_node *tail;
+	} __attribute__((aligned((CAA_CACHE_LINE_SIZE)))) enqueue;
 };
 
 #ifdef _LGPL_SOURCE
@@ -55,22 +60,104 @@ struct cds_wfq_queue {
 #include <urcu/static/wfqueue.h>
 
 #define cds_wfq_node_init		_cds_wfq_node_init
-#define cds_wfq_init		_cds_wfq_init
-#define cds_wfq_enqueue		_cds_wfq_enqueue
-#define __cds_wfq_dequeue_blocking	___cds_wfq_dequeue_blocking
+#define cds_wfq_init			_cds_wfq_init
+#define cds_wfq_empty			_cds_wfq_empty
+#define cds_wfq_enqueue			_cds_wfq_enqueue
+
+/* Locking performed within cds_wfq calls. */
 #define cds_wfq_dequeue_blocking	_cds_wfq_dequeue_blocking
+#define cds_wfq_splice_blocking		_cds_wfq_splice_blocking
+#define cds_wfq_first_blocking		_cds_wfq_first_blocking
+#define cds_wfq_next_blocking		_cds_wfq_next_blocking
+
+/* Locking ensured by caller */
+#define __cds_wfq_dequeue_blocking	___cds_wfq_dequeue_blocking
+#define __cds_wfq_splice_blocking	___cds_wfq_splice_blocking
+#define __cds_wfq_first_blocking	___cds_wfq_first_blocking
+#define __cds_wfq_next_blocking		___cds_wfq_next_blocking
 
 #else /* !_LGPL_SOURCE */
 
-extern void cds_wfq_node_init(struct cds_wfq_node *node);
-extern void cds_wfq_init(struct cds_wfq_queue *q);
-extern void cds_wfq_enqueue(struct cds_wfq_queue *q, struct cds_wfq_node *node);
-/* __cds_wfq_dequeue_blocking: caller ensures mutual exclusion between dequeues */
-extern struct cds_wfq_node *__cds_wfq_dequeue_blocking(struct cds_wfq_queue *q);
-extern struct cds_wfq_node *cds_wfq_dequeue_blocking(struct cds_wfq_queue *q);
+extern void cds_wfq_node_init_1(struct cds_wfq_node *node);
+extern void cds_wfq_init_1(struct cds_wfq_queue *q);
+extern bool cds_wfq_empty_1(struct cds_wfq_queue *q);
+extern void cds_wfq_enqueue_1(struct cds_wfq_queue *q, struct cds_wfq_node *node);
+
+/* Locking performed within cds_wfq calls. */
+extern struct cds_wfq_node *cds_wfq_dequeue_blocking_1(struct cds_wfq_queue *q);
+extern void cds_wfq_splice_blocking_1(struct cds_wfq_queue *dest_q,
+		struct cds_wfq_queue *src_q);
+
+/*
+ * __cds_wfq_dequeue_blocking: caller ensures mutual exclusion of dequeue
+ * and splice operations.
+ */
+extern struct cds_wfq_node *__cds_wfq_dequeue_blocking_1(struct cds_wfq_queue *q);
+
+/*
+ * __cds_wfq_splice_blocking: caller ensures mutual exclusion of dequeue and
+ * splice operations on src_q. dest_q must be already initialized.
+ */
+extern void __cds_wfq_splice_blocking_1(struct cds_wfq_queue *dest_q,
+		struct cds_wfq_queue *src_q);
+
+/*
+ * __cds_wfq_first_blocking: mutual exclusion with "dequeue" and
+ * "splice" operations must be ensured by the caller.
+ */
+extern struct cds_wfq_node *__cds_wfq_first_blocking_1(struct cds_wfq_queue *q);
+
+/*
+ * __cds_wfq_next_blocking: mutual exclusion with "dequeue" and "splice"
+ * operations must be ensured by the caller.
+ */
+extern struct cds_wfq_node *__cds_wfq_next_blocking_1(struct cds_wfq_queue *q,
+		struct cds_wfq_node *node);
+
+#define cds_wfq_node_init		cds_wfq_node_init_1
+#define cds_wfq_init			cds_wfq_init_1
+#define cds_wfq_empty			cds_wfq_empty_1
+#define cds_wfq_enqueue			cds_wfq_enqueue_1
+
+/* Locking performed within cds_wfq calls. */
+#define cds_wfq_dequeue_blocking	cds_wfq_dequeue_blocking_1
+#define cds_wfq_splice_blocking		cds_wfq_splice_blocking_1
+#define cds_wfq_first_blocking		cds_wfq_first_blocking_1
+#define cds_wfq_next_blocking		cds_wfq_next_blocking_1
+
+/* Locking ensured by caller */
+#define __cds_wfq_dequeue_blocking	__cds_wfq_dequeue_blocking_1
+#define __cds_wfq_splice_blocking	__cds_wfq_splice_blocking_1
+#define __cds_wfq_first_blocking	__cds_wfq_first_blocking_1
+#define __cds_wfq_next_blocking		__cds_wfq_next_blocking_1
 
 #endif /* !_LGPL_SOURCE */
 
+/*
+ * __cds_wfq_for_each_blocking: Iterate over all nodes in a queue,
+ * without dequeuing them.
+ *
+ * Mutual exclusion with "dequeue" and "splice" operations must be
+ * ensured by the caller.
+ */
+#define __cds_wfq_for_each_blocking(q, node)		\
+	for (node = __cds_wfq_first_blocking(q);	\
+		node != NULL;				\
+		node = __cds_wfq_next_blocking(q, node))
+
+/*
+ * __cds_wfq_for_each_blocking_safe: Iterate over all nodes in a queue,
+ * without dequeuing them. Safe against deletion.
+ *
+ * Mutual exclusion with "dequeue" and "splice" operations must be
+ * ensured by the caller.
+ */
+#define __cds_wfq_for_each_blocking_safe(q, node, n)			       \
+	for (node = __cds_wfq_first_blocking(q),			       \
+			n = (node ? __cds_wfq_next_blocking(q, node) : NULL);  \
+		node != NULL;						       \
+		node = n, n = (node ? __cds_wfq_next_blocking(q, node) : NULL))
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/wfqueue.c b/wfqueue.c
index 3337171..b5fba7b 100644
--- a/wfqueue.c
+++ b/wfqueue.c
@@ -3,7 +3,8 @@
  *
  * Userspace RCU library - Queue with Wait-Free Enqueue/Blocking Dequeue
  *
- * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright 2011-2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -28,27 +29,55 @@
  * library wrappers to be used by non-LGPL compatible source code.
  */
 
-void cds_wfq_node_init(struct cds_wfq_node *node)
+void cds_wfq_node_init_1(struct cds_wfq_node *node)
 {
 	_cds_wfq_node_init(node);
 }
 
-void cds_wfq_init(struct cds_wfq_queue *q)
+void cds_wfq_init_1(struct cds_wfq_queue *q)
 {
 	_cds_wfq_init(q);
 }
 
-void cds_wfq_enqueue(struct cds_wfq_queue *q, struct cds_wfq_node *node)
+bool cds_wfq_empty_1(struct cds_wfq_queue *q)
+{
+	return _cds_wfq_empty(q);
+}
+
+void cds_wfq_enqueue_1(struct cds_wfq_queue *q, struct cds_wfq_node *node)
 {
 	_cds_wfq_enqueue(q, node);
 }
 
-struct cds_wfq_node *__cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
+struct cds_wfq_node *cds_wfq_dequeue_blocking_1(struct cds_wfq_queue *q)
+{
+	return _cds_wfq_dequeue_blocking(q);
+}
+
+void cds_wfq_splice_blocking_1(struct cds_wfq_queue *dest_q,
+		struct cds_wfq_queue *src_q)
+{
+	_cds_wfq_splice_blocking(dest_q, src_q);
+}
+
+struct cds_wfq_node *__cds_wfq_dequeue_blocking_1(struct cds_wfq_queue *q)
 {
 	return ___cds_wfq_dequeue_blocking(q);
 }
 
-struct cds_wfq_node *cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
+void __cds_wfq_splice_blocking_1(struct cds_wfq_queue *dest_q,
+		struct cds_wfq_queue *src_q)
 {
-	return _cds_wfq_dequeue_blocking(q);
+	___cds_wfq_splice_blocking(dest_q, src_q);
+}
+
+struct cds_wfq_node *__cds_wfq_first_blocking_1(struct cds_wfq_queue *q)
+{
+	return ___cds_wfq_first_blocking(q);
+}
+
+struct cds_wfq_node *__cds_wfq_next_blocking_1(struct cds_wfq_queue *q,
+		struct cds_wfq_node *node)
+{
+	return ___cds_wfq_next_blocking(q, node);
 }

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
