From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [urcu commit] wfcqueue: clarify locking usage
Date: Fri, 12 Oct 2012 10:35:39 -0400
Message-ID: <20121012143539.GA17214__32091.544828336$1350052571$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TMgKz-0003Yh-RO
	for lttng-dev@lists.lttng.org; Fri, 12 Oct 2012 10:35:41 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>, paulmck@linux.vnet.ibm.com
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

commit 1fe734e1914993dfa395e2b81e5c9ee0115cc56c
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Oct 12 10:33:20 2012 -0400

    wfcqueue: clarify locking usage
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
index 2c8c447..2ca9eeb 100644
--- a/urcu/static/wfcqueue.h
+++ b/urcu/static/wfcqueue.h
@@ -59,6 +59,10 @@ extern "C" {
  *
  * For convenience, cds_wfcq_dequeue_blocking() and
  * cds_wfcq_splice_blocking() hold the dequeue lock.
+ *
+ * Besides locking, mutual exclusion of dequeue, splice and iteration
+ * can be ensured by performing all of those operations from a single
+ * thread, without requiring any lock.
  */
 
 #define WFCQ_ADAPT_ATTEMPTS		10	/* Retry if being set */
@@ -192,7 +196,8 @@ ___cds_wfcq_node_sync_next(struct cds_wfcq_node *node)
  *
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
- * Should be called with cds_wfcq_dequeue_lock() held.
+ * Dequeue/splice/iteration mutual exclusion should be ensured by the
+ * caller.
  *
  * Used by for-like iteration macros in urcu/wfqueue.h:
  * __cds_wfcq_for_each_blocking()
@@ -217,7 +222,8 @@ ___cds_wfcq_first_blocking(struct cds_wfcq_head *head,
  *
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
- * Should be called with cds_wfcq_dequeue_lock() held.
+ * Dequeue/splice/iteration mutual exclusion should be ensured by the
+ * caller.
  *
  * Used by for-like iteration macros in urcu/wfqueue.h:
  * __cds_wfcq_for_each_blocking()
@@ -259,7 +265,8 @@ ___cds_wfcq_next_blocking(struct cds_wfcq_head *head,
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
  * It is valid to reuse and free a dequeued node immediately.
- * Should be called with cds_wfcq_dequeue_lock() held.
+ * Dequeue/splice/iteration mutual exclusion should be ensured by the
+ * caller.
  */
 static inline struct cds_wfcq_node *
 ___cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
@@ -308,7 +315,8 @@ ___cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
  *
  * Dequeue all nodes from src_q.
  * dest_q must be already initialized.
- * Should be called with cds_wfcq_dequeue_lock() held on src_q.
+ * Dequeue/splice/iteration mutual exclusion for src_q should be ensured
+ * by the caller.
  */
 static inline void
 ___cds_wfcq_splice_blocking(
@@ -345,7 +353,7 @@ ___cds_wfcq_splice_blocking(
  *
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
- * Mutual exlusion with (and only with) cds_wfcq_splice_blocking is
+ * Mutual exlusion with cds_wfcq_splice_blocking and dequeue lock is
  * ensured.
  * It is valid to reuse and free a dequeued node immediately.
  */
@@ -368,7 +376,7 @@ _cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
  * dest_q must be already initialized.
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
- * Mutual exlusion with (and only with) cds_wfcq_dequeue_blocking is
+ * Mutual exlusion with cds_wfcq_dequeue_blocking and dequeue lock is
  * ensured.
  */
 static inline void
diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
index b13aa7b..ba2f2ed 100644
--- a/urcu/wfcqueue.h
+++ b/urcu/wfcqueue.h
@@ -102,6 +102,10 @@ struct cds_wfcq_tail {
  *
  * For convenience, cds_wfcq_dequeue_blocking() and
  * cds_wfcq_splice_blocking() hold the dequeue lock.
+ *
+ * Besides locking, mutual exclusion of dequeue, splice and iteration
+ * can be ensured by performing all of those operations from a single
+ * thread, without requiring any lock.
  */
 
 /*
@@ -151,7 +155,8 @@ extern void cds_wfcq_enqueue(struct cds_wfcq_head *head,
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
  * It is valid to reuse and free a dequeued node immediately.
- * Mutual exlusion with dequeuers is ensured internally.
+ * Mutual exlusion with cds_wfcq_dequeue_blocking and dequeue lock is
+ * ensured.
  */
 extern struct cds_wfcq_node *cds_wfcq_dequeue_blocking(
 		struct cds_wfcq_head *head,
@@ -164,7 +169,8 @@ extern struct cds_wfcq_node *cds_wfcq_dequeue_blocking(
  * dest_q must be already initialized.
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
- * Mutual exlusion with dequeuers is ensured internally.
+ * Mutual exlusion with cds_wfcq_dequeue_blocking and dequeue lock is
+ * ensured.
  */
 extern void cds_wfcq_splice_blocking(
 		struct cds_wfcq_head *dest_q_head,
@@ -178,7 +184,8 @@ extern void cds_wfcq_splice_blocking(
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
  * It is valid to reuse and free a dequeued node immediately.
- * Should be called with cds_wfcq_dequeue_lock() held.
+ * Dequeue/splice/iteration mutual exclusion should be ensured by the
+ * caller.
  */
 extern struct cds_wfcq_node *__cds_wfcq_dequeue_blocking(
 		struct cds_wfcq_head *head,
@@ -191,7 +198,8 @@ extern struct cds_wfcq_node *__cds_wfcq_dequeue_blocking(
  * dest_q must be already initialized.
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
- * Should be called with cds_wfcq_dequeue_lock() held.
+ * Dequeue/splice/iteration mutual exclusion for src_q should be ensured
+ * by the caller.
  */
 extern void __cds_wfcq_splice_blocking(
 		struct cds_wfcq_head *dest_q_head,
@@ -204,7 +212,8 @@ extern void __cds_wfcq_splice_blocking(
  *
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
- * Should be called with cds_wfcq_dequeue_lock() held.
+ * Dequeue/splice/iteration mutual exclusion should be ensured by the
+ * caller.
  *
  * Used by for-like iteration macros:
  * __cds_wfcq_for_each_blocking()
@@ -219,7 +228,8 @@ extern struct cds_wfcq_node *__cds_wfcq_first_blocking(
  *
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
- * Should be called with cds_wfcq_dequeue_lock() held.
+ * Dequeue/splice/iteration mutual exclusion should be ensured by the
+ * caller.
  *
  * Used by for-like iteration macros:
  * __cds_wfcq_for_each_blocking()
@@ -241,7 +251,8 @@ extern struct cds_wfcq_node *__cds_wfcq_next_blocking(
  *
  * Content written into each node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
- * Should be called with cds_wfcq_dequeue_lock() held.
+ * Dequeue/splice/iteration mutual exclusion should be ensured by the
+ * caller.
  */
 #define __cds_wfcq_for_each_blocking(head, tail, node)		\
 	for (node = __cds_wfcq_first_blocking(head, tail);	\
@@ -259,7 +270,8 @@ extern struct cds_wfcq_node *__cds_wfcq_next_blocking(
  *
  * Content written into each node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
- * Should be called with cds_wfcq_dequeue_lock() held.
+ * Dequeue/splice/iteration mutual exclusion should be ensured by the
+ * caller.
  */
 #define __cds_wfcq_for_each_blocking_safe(head, tail, node, n)		       \
 	for (node = __cds_wfcq_first_blocking(head, tail),		       \

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
