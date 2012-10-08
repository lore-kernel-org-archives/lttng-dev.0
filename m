From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [URCU PATCH 1/3] wfcqueue: implement
	concurrency-efficient	queue
Date: Mon, 8 Oct 2012 12:15:44 -0400
Message-ID: <20121008161544.GB30083__25618.8596984886$1349712975$gmane$org@Krystal>
References: <20121002141307.GA4057@Krystal> <20121002141444.GB4057@Krystal>
	<5072F57E.4020308@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TLFze-0005Yw-7u
	for lttng-dev@lists.lttng.org; Mon, 08 Oct 2012 12:15:46 -0400
Content-Disposition: inline
In-Reply-To: <5072F57E.4020308@redhat.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> Il 02/10/2012 16:14, Mathieu Desnoyers ha scritto:
> > +/*
> > + * Concurrent queue with wait-free enqueue/blocking dequeue.
> > + *
> > + * Inspired from half-wait-free/half-blocking queue implementation done by
> > + * Paul E. McKenney.
> > + *
> > + * Mutual exclusion of __cds_wfcq_* API
> > + *
> > + * Unless otherwise stated, the caller must ensure mutual exclusion of
> > + * queue update operations "dequeue" and "splice" (for source queue).
> > + * Queue read operations "first" and "next" need to be protected against
> > + * concurrent "dequeue" and "splice" (for source queue) by the caller.
> > + * "enqueue", "splice" (for destination queue), and "empty" are the only
> > + * operations that can be used without any mutual exclusion.
> > + * Mutual exclusion can be ensured by holding cds_wfcq_dequeue_lock().
> > + *
> > + * For convenience, cds_wfcq_dequeue_blocking() and
> > + * cds_wfcq_splice_blocking() hold the dequeue lock.
> > + */
> 
> Hi,
> 
> can you add a for-like macro for iteration?  Iteration does not require
> holding the lock and assumes that you are the sole user of the data
> structure, which is useful together with splice.
> 
> Paolo

Hi Paolo,

We actually already have those, they are just not described in this
comment. I will fix this right away. By the way, you will notice the
wording:

+ * Queue read operations "first" and "next", which are used by
+ * "for_each" iterations, need to be protected against concurrent
+ * "dequeue" and "splice" (for source queue) by the caller.

Being the only one iterating on a queue with local head/tail after a
splice operation is one way to provide mutual exclusion. Holding a lock
is not the only way to achieve mutual exclusion.


commit f94061a3df4c9eab9ac869a19e4228de54771fcb
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Oct 8 12:11:30 2012 -0400

    wfcqueue documentation: hint at for_each iterators
    
    Reported-by: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
index a989984..944ee88 100644
--- a/urcu/static/wfcqueue.h
+++ b/urcu/static/wfcqueue.h
@@ -48,8 +48,9 @@ extern "C" {
  *
  * Unless otherwise stated, the caller must ensure mutual exclusion of
  * queue update operations "dequeue" and "splice" (for source queue).
- * Queue read operations "first" and "next" need to be protected against
- * concurrent "dequeue" and "splice" (for source queue) by the caller.
+ * Queue read operations "first" and "next", which are used by
+ * "for_each" iterations, need to be protected against concurrent
+ * "dequeue" and "splice" (for source queue) by the caller.
  * "enqueue", "splice" (for destination queue), and "empty" are the only
  * operations that can be used without any mutual exclusion.
  * Mutual exclusion can be ensured by holding cds_wfcq_dequeue_lock().
@@ -190,6 +191,10 @@ ___cds_wfcq_node_sync_next(struct cds_wfcq_node *node)
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
  * Should be called with cds_wfcq_dequeue_lock() held.
+ *
+ * Used by for-like iteration macros in urcu/wfqueue.h:
+ * __cds_wfcq_for_each_blocking()
+ * __cds_wfcq_for_each_blocking_safe()
  */
 static inline struct cds_wfcq_node *
 ___cds_wfcq_first_blocking(struct cds_wfcq_head *head,
@@ -211,6 +216,10 @@ ___cds_wfcq_first_blocking(struct cds_wfcq_head *head,
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
  * Should be called with cds_wfcq_dequeue_lock() held.
+ *
+ * Used by for-like iteration macros in urcu/wfqueue.h:
+ * __cds_wfcq_for_each_blocking()
+ * __cds_wfcq_for_each_blocking_safe()
  */
 static inline struct cds_wfcq_node *
 ___cds_wfcq_next_blocking(struct cds_wfcq_head *head,
diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
index 5576cbf..501120b 100644
--- a/urcu/wfcqueue.h
+++ b/urcu/wfcqueue.h
@@ -91,8 +91,9 @@ struct cds_wfcq_tail {
  *
  * Unless otherwise stated, the caller must ensure mutual exclusion of
  * queue update operations "dequeue" and "splice" (for source queue).
- * Queue read operations "first" and "next" need to be protected against
- * concurrent "dequeue" and "splice" (for source queue) by the caller.
+ * Queue read operations "first" and "next", which are used by
+ * "for_each" iterations, need to be protected against concurrent
+ * "dequeue" and "splice" (for source queue) by the caller.
  * "enqueue", "splice" (for destination queue), and "empty" are the only
  * operations that can be used without any mutual exclusion.
  * Mutual exclusion can be ensured by holding cds_wfcq_dequeue_lock().
@@ -202,6 +203,10 @@ extern void __cds_wfcq_splice_blocking(
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
  * Should be called with cds_wfcq_dequeue_lock() held.
+ *
+ * Used by for-like iteration macros:
+ * __cds_wfcq_for_each_blocking()
+ * __cds_wfcq_for_each_blocking_safe()
  */
 extern struct cds_wfcq_node *__cds_wfcq_first_blocking(
 		struct cds_wfcq_head *head,
@@ -213,6 +218,10 @@ extern struct cds_wfcq_node *__cds_wfcq_first_blocking(
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
  * Should be called with cds_wfcq_dequeue_lock() held.
+ *
+ * Used by for-like iteration macros:
+ * __cds_wfcq_for_each_blocking()
+ * __cds_wfcq_for_each_blocking_safe()
  */
 extern struct cds_wfcq_node *__cds_wfcq_next_blocking(
 		struct cds_wfcq_head *head,


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
