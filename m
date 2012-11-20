From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 06/16] wfcqueue: implement mutex-free splice
Date: Tue, 20 Nov 2012 14:40:19 -0500
Message-ID: <1353440429-19223-7-git-send-email-mathieu.desnoyers__23951.8039198176$1353440549$gmane$org@efficios.com>
References: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1TathM-0001MB-QI
	for lttng-dev@lists.lttng.org; Tue, 20 Nov 2012 14:41:32 -0500
In-Reply-To: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

A carefully crafted splice operation does not need to use an external
mutex to synchronize against other splice operations.

The trick is atomically exchange the head next pointer with
NULL. If the pointer we replaced was NULL, it means the queue was
possibly empty. If head next was not NULL, by setting head to NULL, we
ensure that concurrent splice operations are going to see an empty
queue, even if concurrent enqueue operations move tail further. This
means that as long as we are within splice, after setting head to NULL,
but before moving tail back to head, concurrent splice operations will
always see an empty queue, therefore acting as mutual exclusion.

If exchange returns a NULL head, we confirm that it was indeed empty by
checking if the tail pointer points to the head node, busy-waiting if
necessary.

Then the last step is to move the tail pointer to head. At that point,
enqueuers are going to start enqueuing at head again, and other splice
operations will be able to proceed.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 urcu/static/wfcqueue.h |   68 ++++++++++++++++++++++++++++++++++++------------
 urcu/wfcqueue.h        |   40 ++++++++++++++++++----------
 wfcqueue.c             |    2 +-
 3 files changed, 79 insertions(+), 31 deletions(-)

diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
index 8774c03..4b2de50 100644
--- a/urcu/static/wfcqueue.h
+++ b/urcu/static/wfcqueue.h
@@ -46,15 +46,30 @@ extern "C" {
  * half-wait-free/half-blocking queue implementation done by Paul E.
  * McKenney.
  *
- * Mutual exclusion of __cds_wfcq_* API
- *
- * Unless otherwise stated, the caller must ensure mutual exclusion of
- * queue update operations "dequeue" and "splice" (for source queue).
- * Queue read operations "first" and "next", which are used by
- * "for_each" iterations, need to be protected against concurrent
- * "dequeue" and "splice" (for source queue) by the caller.
- * "enqueue", "splice" (for destination queue), and "empty" are the only
- * operations that can be used without any mutual exclusion.
+ * Mutual exclusion of cds_wfcq_* / __cds_wfcq_* API
+ *
+ * Synchronization table:
+ *
+ * External synchronization techniques described in the API below is
+ * required between pairs marked with "X". No external synchronization
+ * required between pairs marked with "-".
+ *
+ * Legend:
+ * [1] cds_wfcq_enqueue
+ * [2] __cds_wfcq_splice (destination queue)
+ * [3] __cds_wfcq_dequeue
+ * [4] __cds_wfcq_splice (source queue)
+ * [5] __cds_wfcq_first
+ * [6] __cds_wfcq_next
+ *
+ *     [1] [2] [3] [4] [5] [6]
+ * [1]  -   -   -   -   -   -
+ * [2]  -   -   -   -   -   -
+ * [3]  -   -   X   X   X   X
+ * [4]  -   -   X   -   X   X
+ * [5]  -   -   X   X   -   -
+ * [6]  -   -   X   X   -   -
+ *
  * Mutual exclusion can be ensured by holding cds_wfcq_dequeue_lock().
  *
  * For convenience, cds_wfcq_dequeue_blocking() and
@@ -399,6 +414,16 @@ ___cds_wfcq_dequeue_nonblocking(struct cds_wfcq_head *head,
 	return ___cds_wfcq_dequeue(head, tail, 0);
 }
 
+/*
+ * __cds_wfcq_splice: enqueue all src_q nodes at the end of dest_q.
+ *
+ * Dequeue all nodes from src_q.
+ * dest_q must be already initialized.
+ * Mutual exclusion for src_q should be ensured by the caller as
+ * specified in the "Synchronisation table".
+ * Returns enum cds_wfcq_ret which indicates the state of the src or
+ * dest queue.
+ */
 static inline enum cds_wfcq_ret
 ___cds_wfcq_splice(
 		struct cds_wfcq_head *dest_q_head,
@@ -408,14 +433,26 @@ ___cds_wfcq_splice(
 		int blocking)
 {
 	struct cds_wfcq_node *head, *tail;
+	int attempt = 0;
 
 	if (_cds_wfcq_empty(src_q_head, src_q_tail))
 		return CDS_WFCQ_RET_SRC_EMPTY;
 
-	head = ___cds_wfcq_node_sync_next(&src_q_head->node, blocking);
-	if (head == CDS_WFCQ_WOULDBLOCK)
-		return CDS_WFCQ_RET_WOULDBLOCK;
-	_cds_wfcq_node_init(&src_q_head->node);
+	for (;;) {
+		head = uatomic_xchg(&src_q_head->node.next, NULL);
+		if (head)
+			break;	/* non-empty */
+		if (CMM_LOAD_SHARED(src_q_tail->p) == &src_q_head->node)
+			return CDS_WFCQ_RET_SRC_EMPTY;
+		if (!blocking)
+			return CDS_WFCQ_RET_WOULDBLOCK;
+		if (++attempt >= WFCQ_ADAPT_ATTEMPTS) {
+			poll(NULL, 0, WFCQ_WAIT);	/* Wait for 10ms */
+			attempt = 0;
+		} else {
+			caa_cpu_relax();
+		}
+	}
 
 	/*
 	 * Memory barrier implied before uatomic_xchg() orders store to
@@ -435,14 +472,13 @@ ___cds_wfcq_splice(
 		return CDS_WFCQ_RET_DEST_EMPTY;
 }
 
-
 /*
  * __cds_wfcq_splice_blocking: enqueue all src_q nodes at the end of dest_q.
  *
  * Dequeue all nodes from src_q.
  * dest_q must be already initialized.
- * Dequeue/splice/iteration mutual exclusion for src_q should be ensured
- * by the caller.
+ * Mutual exclusion for src_q should be ensured by the caller as
+ * specified in the "Synchronisation table".
  * Returns enum cds_wfcq_ret which indicates the state of the src or
  * dest queue. Never returns CDS_WFCQ_RET_WOULDBLOCK.
  */
diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
index ddf6b87..d9ec534 100644
--- a/urcu/wfcqueue.h
+++ b/urcu/wfcqueue.h
@@ -46,7 +46,7 @@ extern "C" {
 #define CDS_WFCQ_WOULDBLOCK	((void *) -1UL)
 
 enum cds_wfcq_ret {
-	CDS_WFCQ_RET_WOULDBLOCK = 	-1,
+	CDS_WFCQ_RET_WOULDBLOCK =	-1,
 	CDS_WFCQ_RET_DEST_EMPTY =	0,
 	CDS_WFCQ_RET_DEST_NON_EMPTY =	1,
 	CDS_WFCQ_RET_SRC_EMPTY = 	2,
@@ -110,13 +110,28 @@ struct cds_wfcq_tail {
 /*
  * Mutual exclusion of cds_wfcq_* / __cds_wfcq_* API
  *
- * Unless otherwise stated, the caller must ensure mutual exclusion of
- * queue update operations "dequeue" and "splice" (for source queue).
- * Queue read operations "first" and "next", which are used by
- * "for_each" iterations, need to be protected against concurrent
- * "dequeue" and "splice" (for source queue) by the caller.
- * "enqueue", "splice" (for destination queue), and "empty" are the only
- * operations that can be used without any mutual exclusion.
+ * Synchronization table:
+ *
+ * External synchronization techniques described in the API below is
+ * required between pairs marked with "X". No external synchronization
+ * required between pairs marked with "-".
+ *
+ * Legend:
+ * [1] cds_wfcq_enqueue
+ * [2] __cds_wfcq_splice (destination queue)
+ * [3] __cds_wfcq_dequeue
+ * [4] __cds_wfcq_splice (source queue)
+ * [5] __cds_wfcq_first
+ * [6] __cds_wfcq_next
+ *
+ *     [1] [2] [3] [4] [5] [6]
+ * [1]  -   -   -   -   -   -
+ * [2]  -   -   -   -   -   -
+ * [3]  -   -   X   X   X   X
+ * [4]  -   -   X   -   X   X
+ * [5]  -   -   X   X   -   -
+ * [6]  -   -   X   X   -   -
+ *
  * Mutual exclusion can be ensured by holding cds_wfcq_dequeue_lock().
  *
  * For convenience, cds_wfcq_dequeue_blocking() and
@@ -231,13 +246,10 @@ extern struct cds_wfcq_node *__cds_wfcq_dequeue_nonblocking(
  *
  * Dequeue all nodes from src_q.
  * dest_q must be already initialized.
- * Content written into the node before enqueue is guaranteed to be
- * consistent, but no other memory ordering is ensured.
- * Dequeue/splice/iteration mutual exclusion for src_q should be ensured
- * by the caller.
- *
+ * Mutual exclusion for src_q should be ensured by the caller as
+ * specified in the "Synchronisation table".
  * Returns enum cds_wfcq_ret which indicates the state of the src or
- * dest queue. Cannot block.
+ * dest queue. Never returns CDS_WFCQ_RET_WOULDBLOCK.
  */
 extern enum cds_wfcq_ret __cds_wfcq_splice_blocking(
 		struct cds_wfcq_head *dest_q_head,
diff --git a/wfcqueue.c b/wfcqueue.c
index 207df95..ab0eb93 100644
--- a/wfcqueue.c
+++ b/wfcqueue.c
@@ -1,7 +1,7 @@
 /*
  * wfcqueue.c
  *
- * Userspace RCU library - Concurrent queue with Wait-Free Enqueue/Blocking Dequeue
+ * Userspace RCU library - Concurrent Queue with Wait-Free Enqueue/Blocking Dequeue
  *
  * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  * Copyright 2011-2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
-- 
1.7.10.4
