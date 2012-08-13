From: Lai Jiangshan <eag0628@gmail.com>
Subject: Re: [RFC PATCH] wfqueue: expand API,
 simplify implementation, small performance boost
Date: Mon, 13 Aug 2012 23:13:20 +0800
Message-ID: <CACvQF52366ewREnRrDgi+xUBVQ6_ifWjoDv==nHik8FbCnMugA__38361.5063540221$1344870841$gmane$org@mail.gmail.com>
References: <20120812145000.GA32747@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <eag0628@gmail.com>) id 1T0wKc-0003se-LN
	for lttng-dev@lists.lttng.org; Mon, 13 Aug 2012 11:13:27 -0400
Received: by qcsc21 with SMTP id c21so2746979qcs.35
	for <lttng-dev@lists.lttng.org>; Mon, 13 Aug 2012 08:13:21 -0700 (PDT)
In-Reply-To: <20120812145000.GA32747@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

On Sun, Aug 12, 2012 at 10:50 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> This work is derived from the patch from Lai Jiangshan submitted as
> "urcu: new wfqueue implementation"
> (http://lists.lttng.org/pipermail/lttng-dev/2012-August/018379.html)
>
> Its changelog:
>
>> Some guys would be surprised by this fact:
>> There are already TWO implementations of wfqueue in urcu.
>>
>> The first one is in urcu/static/wfqueue.h:
>> 1) enqueue: exchange the tail and then update previous->next
>> 2) dequeue: wait for first node's next pointer and them shift, a dummy node
>>       is introduced to avoid the queue->tail become NULL when shift.
>>
>> The second one shares some code with the first one, and the left code
>> are spreading in urcu-call-rcu-impl.h:
>> 1) enqueue: share with the first one
>> 2) no dequeue operation: and no shift, so it don't need dummy node,
>>       Although the dummy node is queued when initialization, but it is removed
>>       after the first dequeue_all operation in call_rcu_thread().
>>       call_rcu_data_free() forgets to handle the dummy node if it is not removed.
>> 3)dequeue_all: record the old head and tail, and queue->head become the special
>>       tail node.(atomic record the tail and change the tail).
>>
>> The second implementation's code are spreading, bad for review, and it is not
>> tested by tests/test_urcu_wfq.
>>
>> So we need a better implementation avoid the dummy node dancing and can service
>> both generic wfqueue APIs and dequeue_all API for call rcu.
>>
>> The new implementation:
>> 1) enqueue: share with the first one/original implementation.
>> 2) dequeue: shift when node count >= 2, cmpxchg when node count = 1.
>>       no dummy node, save memory.
>> 3) dequeue_all: simply set queue->head.next to NULL, xchg the tail
>>       and return the old head.next.
>>
>> More implementation details are in the code.
>> tests/test_urcu_wfq will be update in future for testing new APIs.
>
> The patch proposed by Lai brings a very interesting simplification to
> the single-node handling (which is kept here), and moves all queue
> handling code away from call_rcu implementation, back into the wfqueue
> code. This has the benefit to allow testing enhancements.
>
> I modified it so the API does not expose implementation details to the
> user (e.g. ___cds_wfq_node_sync_next). I added a "splice" operation and
> a for loop iterator which should allow wfqueue users to use the list
> very efficiently both from LGPL/GPL code and from non-LGPL-compatible
> code.
>
> Benchmarks performed on Intel(R) Core(TM) i7-3520M CPU @ 2.90GHz
> (dual-core, with hyperthreading)
>
> Benchmark invoked:
> test_urcu_wfq 2 2 10
>
> Only did 2 runs, but a small improvement seems to be clear for the
> dequeue speed:
>
> Before patch:
>
> testdur   10 nr_enqueuers   2 wdelay      0 nr_dequeuers   2 rdur      0 nr_enqueues    136251248 nr_dequeues     54694027 successful enqueues 136251248 successful dequeues     54693904 end_dequeues 81557344 nr_ops 190945275
> testdur   10 nr_enqueuers   2 wdelay      0 nr_dequeuers   2 rdur      0 nr_enqueues    137258881 nr_dequeues     54463340 successful enqueues 137258881 successful dequeues     54463238 end_dequeues 82795643 nr_ops 191722221
>
> After patch:
>
> testdur   10 nr_enqueuers   2 wdelay      0 nr_dequeuers   2 rdur      0 nr_enqueues    138589301 nr_dequeues     56911253 successful enqueues 138589301 successful dequeues     56910916 end_dequeues 81678385 nr_ops 195500554
> testdur   10 nr_enqueuers   2 wdelay      0 nr_dequeuers   2 rdur      0 nr_enqueues    139007622 nr_dequeues     57281502 successful enqueues 139007622 successful dequeues     57281348 end_dequeues 81726274 nr_ops 196289124
>
> Summary: Number of enqueues is slightly lower,

?!
I see the nr_enqueues and successful enqueues are both increased after
after patch.

> probably due to higher
> dequeue rate. Number of dequeue increased. Respective rate change is
> within 1% (slowdown) for enqueue, 2% (performance improvement) for
> dequeue. Overall number of operations (dequeue+enqueue) increased with
> the patch.
>
> We can verify that:
>    successful enqueues - successful dequeues = end_dequeues
>
> For all runs (ensures correctness: no lost node).
>
> CC: Lai Jiangshan <laijs@cn.fujitsu.com>
> CC: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
> index 13b24ff..5363fe0 100644
> --- a/urcu-call-rcu-impl.h
> +++ b/urcu-call-rcu-impl.h
> @@ -21,6 +21,7 @@
>   */
>
>  #define _GNU_SOURCE
> +#define _LGPL_SOURCE
>  #include <stdio.h>
>  #include <pthread.h>
>  #include <signal.h>
> @@ -220,10 +221,7 @@ static void call_rcu_wake_up(struct call_rcu_data *crdp)
>  static void *call_rcu_thread(void *arg)
>  {
>         unsigned long cbcount;
> -       struct cds_wfq_node *cbs;
> -       struct cds_wfq_node **cbs_tail;
> -       struct call_rcu_data *crdp = (struct call_rcu_data *)arg;
> -       struct rcu_head *rhp;
> +       struct call_rcu_data *crdp = (struct call_rcu_data *) arg;
>         int rt = !!(uatomic_read(&crdp->flags) & URCU_CALL_RCU_RT);
>         int ret;
>
> @@ -243,35 +241,29 @@ static void *call_rcu_thread(void *arg)
>                 cmm_smp_mb();
>         }
>         for (;;) {
> -               if (&crdp->cbs.head != _CMM_LOAD_SHARED(crdp->cbs.tail)) {
> -                       while ((cbs = _CMM_LOAD_SHARED(crdp->cbs.head)) == NULL)
> -                               poll(NULL, 0, 1);
> -                       _CMM_STORE_SHARED(crdp->cbs.head, NULL);
> -                       cbs_tail = (struct cds_wfq_node **)
> -                               uatomic_xchg(&crdp->cbs.tail, &crdp->cbs.head);
> +               struct cds_wfq_queue cbs_tmp;
> +               struct cds_wfq_node *cbs;
> +
> +               cds_wfq_init(&cbs_tmp);
> +               __cds_wfq_splice_blocking(&cbs_tmp, &crdp->cbs);
> +               if (!cds_wfq_empty(&cbs_tmp)) {
>                         synchronize_rcu();
>                         cbcount = 0;
> -                       do {
> -                               while (cbs->next == NULL &&
> -                                      &cbs->next != cbs_tail)
> -                                       poll(NULL, 0, 1);
> -                               if (cbs == &crdp->cbs.dummy) {
> -                                       cbs = cbs->next;
> -                                       continue;
> -                               }
> -                               rhp = (struct rcu_head *)cbs;
> -                               cbs = cbs->next;
> +                       __cds_wfq_for_each_blocking(&cbs_tmp, cbs) {
> +                               struct rcu_head *rhp;
> +
> +                               rhp = caa_container_of(cbs,
> +                                       struct rcu_head, next);
>                                 rhp->func(rhp);


cbs is freed hear, but it will be used in __cds_wfq_next_blocking().
Introduce __cds_wfq_for_each_blocking_safe() ?

>                                 cbcount++;
> -                       } while (cbs != NULL);
> +                       }
>                         uatomic_sub(&crdp->qlen, cbcount);
>                 }
>                 if (uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOP)
>                         break;
>                 rcu_thread_offline();
>                 if (!rt) {
> -                       if (&crdp->cbs.head
> -                           == _CMM_LOAD_SHARED(crdp->cbs.tail)) {
> +                       if (cds_wfq_empty(&crdp->cbs)) {
>                                 call_rcu_wait(crdp);
>                                 poll(NULL, 0, 10);
>                                 uatomic_dec(&crdp->futex);
> @@ -625,32 +617,32 @@ void call_rcu(struct rcu_head *head,
>   */
>  void call_rcu_data_free(struct call_rcu_data *crdp)
>  {
> -       struct cds_wfq_node *cbs;
> -       struct cds_wfq_node **cbs_tail;
> -       struct cds_wfq_node **cbs_endprev;
> -
>         if (crdp == NULL || crdp == default_call_rcu_data) {
>                 return;
>         }
> +
>         if ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0) {
>                 uatomic_or(&crdp->flags, URCU_CALL_RCU_STOP);
>                 wake_call_rcu_thread(crdp);
>                 while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0)
>                         poll(NULL, 0, 1);
>         }
> -       if (&crdp->cbs.head != _CMM_LOAD_SHARED(crdp->cbs.tail)) {
> -               while ((cbs = _CMM_LOAD_SHARED(crdp->cbs.head)) == NULL)
> -                       poll(NULL, 0, 1);
> -               _CMM_STORE_SHARED(crdp->cbs.head, NULL);
> -               cbs_tail = (struct cds_wfq_node **)
> -                       uatomic_xchg(&crdp->cbs.tail, &crdp->cbs.head);
> +
> +       if (!cds_wfq_empty(&crdp->cbs)) {
> +               struct cds_wfq_queue cbs_tmp;
> +
> +               cds_wfq_init(&cbs_tmp);
> +               __cds_wfq_splice_blocking(&cbs_tmp, &crdp->cbs);
> +
>                 /* Create default call rcu data if need be */
>                 (void) get_default_call_rcu_data();
> -               cbs_endprev = (struct cds_wfq_node **)
> -                       uatomic_xchg(&default_call_rcu_data, cbs_tail);
> -               *cbs_endprev = cbs;
> +
> +               __cds_wfq_splice_blocking(&default_call_rcu_data->cbs,
> +                                         &cbs_tmp);
> +

Too much code to me, cbs_tmp is not required here.


     /* Create default call rcu data if need be */
    (void) get_default_call_rcu_data();
+   __cds_wfq_splice_blocking(&default_call_rcu_data->cbs,&crdp->cbs);



>                 uatomic_add(&default_call_rcu_data->qlen,
>                             uatomic_read(&crdp->qlen));
> +
>                 wake_call_rcu_thread(default_call_rcu_data);
>         }
>
> diff --git a/urcu/static/wfqueue.h b/urcu/static/wfqueue.h
> index 636e1af..08d8d52 100644
> --- a/urcu/static/wfqueue.h
> +++ b/urcu/static/wfqueue.h
> @@ -9,7 +9,8 @@
>   * TO BE INCLUDED ONLY IN LGPL-COMPATIBLE CODE. See wfqueue.h for linking
>   * dynamically with the userspace rcu library.
>   *
> - * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright 2011-2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
>   *
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
> @@ -29,6 +30,7 @@
>  #include <pthread.h>
>  #include <assert.h>
>  #include <poll.h>
> +#include <stdbool.h>
>  #include <urcu/compiler.h>
>  #include <urcu/uatomic.h>
>
> @@ -38,11 +40,16 @@ extern "C" {
>
>  /*
>   * Queue with wait-free enqueue/blocking dequeue.
> - * This implementation adds a dummy head node when the queue is empty to ensure
> - * we can always update the queue locklessly.
>   *
>   * Inspired from half-wait-free/half-blocking queue implementation done by
>   * Paul E. McKenney.
> + *
> + * Caller must ensure mutual exclusion of queue update operations
> + * "dequeue" and "splice" source queue. Queue read operations "first"
> + * and "next" need to be protected against concurrent "dequeue" and
> + * "splice" (for source queue) by the caller. "enqueue", "splice"
> + * (destination queue), and "empty" are the only operations that can be
> + * used without any mutual exclusion.
>   */
>
>  #define WFQ_ADAPT_ATTEMPTS             10      /* Retry if being set */
> @@ -57,31 +64,51 @@ static inline void _cds_wfq_init(struct cds_wfq_queue *q)
>  {
>         int ret;
>
> -       _cds_wfq_node_init(&q->dummy);
>         /* Set queue head and tail */
> -       q->head = &q->dummy;
> -       q->tail = &q->dummy.next;
> +       _cds_wfq_node_init(&q->head);
> +       q->tail = &q->head;
>         ret = pthread_mutex_init(&q->lock, NULL);
>         assert(!ret);
>  }
>
> -static inline void _cds_wfq_enqueue(struct cds_wfq_queue *q,
> -                                   struct cds_wfq_node *node)
> +static inline bool _cds_wfq_empty(struct cds_wfq_queue *q)
> +{
> +       /*
> +        * Queue is empty if no node is pointed by q->head.next nor q->tail.
> +        */
> +       return CMM_LOAD_SHARED(q->head.next) == NULL
> +               && CMM_LOAD_SHARED(q->tail) == &q->head;
> +}
> +
> +static inline void ___cds_wfq_append(struct cds_wfq_queue *q,
> +               struct cds_wfq_node *new_head,
> +               struct cds_wfq_node *new_tail)
>  {
> -       struct cds_wfq_node **old_tail;
> +       struct cds_wfq_node *old_tail;
>
>         /*
> -        * uatomic_xchg() implicit memory barrier orders earlier stores to data
> -        * structure containing node and setting node->next to NULL before
> -        * publication.
> +        * Implicit memory barrier before uatomic_xchg() orders earlier
> +        * stores to data structure containing node and setting
> +        * node->next to NULL before publication.
>          */
> -       old_tail = uatomic_xchg(&q->tail, &node->next);
> +       old_tail = uatomic_xchg(&q->tail, new_tail);
> +
>         /*
> -        * At this point, dequeuers see a NULL old_tail->next, which indicates
> -        * that the queue is being appended to. The following store will append
> -        * "node" to the queue from a dequeuer perspective.
> +        * Implicit memory barrier after uatomic_xchg() orders store to
> +        * q->tail before store to old_tail->next.
> +        *
> +        * At this point, dequeuers see a NULL q->tail->next, which
> +        * indicates that the queue is being appended to. The following
> +        * store will append "node" to the queue from a dequeuer
> +        * perspective.
>          */
> -       CMM_STORE_SHARED(*old_tail, node);
> +       CMM_STORE_SHARED(old_tail->next, new_head);
> +}
> +
> +static inline void _cds_wfq_enqueue(struct cds_wfq_queue *q,
> +               struct cds_wfq_node *new_tail)
> +{
> +       ___cds_wfq_append(q, new_tail, new_tail);
>  }
>
>  /*
> @@ -100,14 +127,45 @@ ___cds_wfq_node_sync_next(struct cds_wfq_node *node)
>                 if (++attempt >= WFQ_ADAPT_ATTEMPTS) {
>                         poll(NULL, 0, WFQ_WAIT);        /* Wait for 10ms */
>                         attempt = 0;
> -               } else
> +               } else {
>                         caa_cpu_relax();
> +               }
>         }
>
>         return next;
>  }
>
>  /*
> + * ___cds_wfq_first_blocking: get first node of a queue, without dequeuing.
> + *
> + * Mutual exclusion with "dequeue" and "splice" operations must be ensured
> + * by the caller.
> + */
> +static inline struct cds_wfq_node *
> +___cds_wfq_first_blocking(struct cds_wfq_queue *q)
> +{
> +       if (_cds_wfq_empty(q))
> +               return NULL;
> +       return ___cds_wfq_node_sync_next(&q->head);
> +}
> +
> +/*
> + * ___cds_wfq_next_blocking: get next node of a queue, without dequeuing.
> + *
> + * Mutual exclusion with "dequeue" and "splice" operations must be ensured
> + * by the caller.
> + */
> +static inline struct cds_wfq_node *
> +___cds_wfq_next_blocking(struct cds_wfq_queue *q, struct cds_wfq_node *node)
> +{
> +       if (CMM_LOAD_SHARED(q->tail) == node)
> +               return NULL;
> +       return ___cds_wfq_node_sync_next(node);
> +}


The same BUG as you told me.
If q has only one node just enqueued by other thread.
but if q->head.next is seen, ___cds_wfq_first_blocking() returns a node,
And the update of q->tail is not seen, it is still &q->head,
___cds_wfq_node_sync_next(node) will be loop for every if there is no
other enqueue.



static inline struct cds_wfq_node *
___cds_wfq_first_blocking(struct cds_wfq_queue *q)
{
+        struct cds_wfq_node *ret.
       if (_cds_wfq_empty(q))
               return NULL;
      ret = ___cds_wfq_node_sync_next(&q->head);
+      cmm_smp_rmb();
+      return ret;
}


> +
> +/*
> + * ___cds_wfq_dequeue_blocking: dequeue a node from the queue.
> + *
>   * It is valid to reuse and free a dequeued node immediately.
>   *
>   * No need to go on a waitqueue here, as there is no possible state in which the
> @@ -120,42 +178,123 @@ ___cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
>  {
>         struct cds_wfq_node *node, *next;
>
> -       /*
> -        * Queue is empty if it only contains the dummy node.
> -        */
> -       if (q->head == &q->dummy && CMM_LOAD_SHARED(q->tail) == &q->dummy.next)
> +       if (_cds_wfq_empty(q))
>                 return NULL;
> -       node = q->head;
>
> -       next = ___cds_wfq_node_sync_next(node);
> +       node = ___cds_wfq_node_sync_next(&q->head);
> +
> +       if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
> +               /* Load node->next before q->tail */
> +               cmm_smp_rmb();
> +               if (CMM_LOAD_SHARED(q->tail) == node) {

I don't know why I added this "if" since it is likely true.
Could you remove the above 3 lines?
(I remember there is a mb() before uatomic_cmpxchg() which means
this mb() is before  the test in uatomic_cmpxchg())

> +                       /*
> +                        * @node is the only node in the queue.
> +                        * Try to move the tail to &q->head
> +                        */
> +                       _cds_wfq_node_init(&q->head);
> +                       if (uatomic_cmpxchg(&q->tail, node, &q->head) == node)
> +                               return node;
> +               }
> +               next = ___cds_wfq_node_sync_next(node);
> +       }
>
>         /*
>          * Move queue head forward.
>          */
> -       q->head = next;
> +       q->head.next = next;
> +
> +       return node;
> +}
> +
> +/*
> + * ___cds_wfq_splice_blocking: enqueue all src_q nodes at the end of dest_q.
> + *
> + * Dequeue all nodes from src_q.
> + * dest_q must be already initialized.
> + * caller ensures mutual exclusion of dequeue and splice operations on
> + * src_q.
> + */
> +static inline void
> +___cds_wfq_splice_blocking(struct cds_wfq_queue *dest_q,
> +               struct cds_wfq_queue *src_q)
> +{
> +       struct cds_wfq_node *head, *tail;
> +
> +       if (_cds_wfq_empty(src_q))
> +               return;
> +
> +       head = ___cds_wfq_node_sync_next(&src_q->head);
> +       _cds_wfq_node_init(&src_q->head);
> +
> +       /*
> +        * Memory barrier implied before uatomic_xchg() orders store to
> +        * src_q->head before store to src_q->tail. This is required by
> +        * concurrent enqueue on src_q, which exchanges the tail before
> +        * updating the previous tail's next pointer.
> +        */
> +       tail = uatomic_xchg(&src_q->tail, &src_q->head);
> +
>         /*
> -        * Requeue dummy node if we just dequeued it.
> +        * Append the spliced content of src_q into dest_q. Does not
> +        * require mutual exclusion on dest_q (wait-free).
>          */
> -       if (node == &q->dummy) {
> -               _cds_wfq_node_init(node);
> -               _cds_wfq_enqueue(q, node);
> -               return ___cds_wfq_dequeue_blocking(q);
> -       }
> -       return node;
> +       ___cds_wfq_append(dest_q, head, tail);
> +}
> +
> +/* Locking performed within cds_wfq calls. */
> +static inline struct cds_wfq_node *
> +_cds_wfq_first_blocking(struct cds_wfq_queue *q)
> +{
> +       struct cds_wfq_node *retval;
> +       int ret;
> +
> +       ret = pthread_mutex_lock(&q->lock);
> +       assert(!ret);
> +       retval = ___cds_wfq_first_blocking(q);
> +       ret = pthread_mutex_unlock(&q->lock);
> +       assert(!ret);
> +       return retval;
> +}
> +
> +static inline struct cds_wfq_node *
> +_cds_wfq_next_blocking(struct cds_wfq_queue *q, struct cds_wfq_node *node)
> +{
> +       struct cds_wfq_node *retval;
> +       int ret;
> +
> +       ret = pthread_mutex_lock(&q->lock);
> +       assert(!ret);
> +       retval = ___cds_wfq_next_blocking(q, node);
> +       ret = pthread_mutex_unlock(&q->lock);
> +       assert(!ret);
> +       return retval;
>  }

I reject these _cds_wfq_first_blocking(), _cds_wfq_next_blocking()
and cds_wfq_for_each_blocking(), because the claimed "Locking"
makes no sense:
1. It protects nothing in _cds_wfq_next_blocking().
2. There is no "Locking" in the loop body, @node is not dequeued,
it will be invalid if some other dequeue it,
and _cds_wfq_next_blocking() results BUG.

>
>  static inline struct cds_wfq_node *
>  _cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
>  {
> -       struct cds_wfq_node *retnode;
> +       struct cds_wfq_node *retval;
>         int ret;
>
>         ret = pthread_mutex_lock(&q->lock);
>         assert(!ret);
> -       retnode = ___cds_wfq_dequeue_blocking(q);
> +       retval = ___cds_wfq_dequeue_blocking(q);
>         ret = pthread_mutex_unlock(&q->lock);
>         assert(!ret);
> -       return retnode;
> +       return retval;
> +}
> +
> +static inline void
> +_cds_wfq_splice_blocking(struct cds_wfq_queue *dest_q,
> +               struct cds_wfq_queue *src_q)
> +{
> +       int ret;
> +
> +       ret = pthread_mutex_lock(&src_q->lock);
> +       assert(!ret);
> +       ___cds_wfq_splice_blocking(dest_q, src_q);
> +       ret = pthread_mutex_unlock(&src_q->lock);
> +       assert(!ret);
>  }
>
>  #ifdef __cplusplus
> diff --git a/urcu/wfqueue.h b/urcu/wfqueue.h
> index 03a73f1..d33d47a 100644
> --- a/urcu/wfqueue.h
> +++ b/urcu/wfqueue.h
> @@ -6,7 +6,8 @@
>   *
>   * Userspace RCU library - Queue with Wait-Free Enqueue/Blocking Dequeue
>   *
> - * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright 2011-2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
>   *
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
> @@ -25,6 +26,7 @@
>
>  #include <pthread.h>
>  #include <assert.h>
> +#include <stdbool.h>
>  #include <urcu/compiler.h>
>
>  #ifdef __cplusplus
> @@ -33,8 +35,6 @@ extern "C" {
>
>  /*
>   * Queue with wait-free enqueue/blocking dequeue.
> - * This implementation adds a dummy head node when the queue is empty to ensure
> - * we can always update the queue locklessly.
>   *
>   * Inspired from half-wait-free/half-blocking queue implementation done by
>   * Paul E. McKenney.
> @@ -45,8 +45,8 @@ struct cds_wfq_node {
>  };
>
>  struct cds_wfq_queue {
> -       struct cds_wfq_node *head, **tail;
> -       struct cds_wfq_node dummy;      /* Dummy node */
> +       struct cds_wfq_node head, *tail;
> +       struct cds_wfq_node padding;    /* unused */
>         pthread_mutex_t lock;
>  };

Why keep the padding?

>
> @@ -55,22 +55,90 @@ struct cds_wfq_queue {
>  #include <urcu/static/wfqueue.h>
>
>  #define cds_wfq_node_init              _cds_wfq_node_init
> -#define cds_wfq_init           _cds_wfq_init
> -#define cds_wfq_enqueue                _cds_wfq_enqueue
> -#define __cds_wfq_dequeue_blocking     ___cds_wfq_dequeue_blocking
> +#define cds_wfq_init                   _cds_wfq_init
> +#define cds_wfq_empty                  _cds_wfq_empty
> +#define cds_wfq_enqueue                        _cds_wfq_enqueue
> +
> +/* Locking performed within cds_wfq calls. */
>  #define cds_wfq_dequeue_blocking       _cds_wfq_dequeue_blocking
> +#define cds_wfq_splice_blocking                _cds_wfq_splice_blocking
> +#define cds_wfq_first_blocking         _cds_wfq_first_blocking
> +#define cds_wfq_next_blocking          _cds_wfq_next_blocking
> +
> +/* Locking ensured by caller */
> +#define __cds_wfq_dequeue_blocking     ___cds_wfq_dequeue_blocking
> +#define __cds_wfq_splice_blocking      ___cds_wfq_splice_blocking
> +#define __cds_wfq_first_blocking       ___cds_wfq_first_blocking
> +#define __cds_wfq_next_blocking                ___cds_wfq_next_blocking
>
>  #else /* !_LGPL_SOURCE */
>
>  extern void cds_wfq_node_init(struct cds_wfq_node *node);
>  extern void cds_wfq_init(struct cds_wfq_queue *q);
> +extern bool cds_wfq_empty(struct cds_wfq_queue *q);
>  extern void cds_wfq_enqueue(struct cds_wfq_queue *q, struct cds_wfq_node *node);
> -/* __cds_wfq_dequeue_blocking: caller ensures mutual exclusion between dequeues */
> -extern struct cds_wfq_node *__cds_wfq_dequeue_blocking(struct cds_wfq_queue *q);
> +
> +/* Locking performed within cds_wfq calls. */
>  extern struct cds_wfq_node *cds_wfq_dequeue_blocking(struct cds_wfq_queue *q);
> +extern void cds_wfq_splice_blocking(struct cds_wfq_queue *dest_q,
> +               struct cds_wfq_queue *src_q);
> +extern struct cds_wfq_node *cds_wfq_first_blocking(struct cds_wfq_queue *q);
> +extern struct cds_wfq_node *cds_wfq_next_blocking(struct cds_wfq_queue *q,
> +               struct cds_wfq_node *node);
> +
> +/*
> + * __cds_wfq_dequeue_blocking: caller ensures mutual exclusion of dequeue
> + * and splice operations.
> + */
> +extern struct cds_wfq_node *__cds_wfq_dequeue_blocking(struct cds_wfq_queue *q);
> +
> +/*
> + * __cds_wfq_splice_blocking: caller ensures mutual exclusion of dequeue and
> + * splice operations on src_q. dest_q must be already initialized.
> + */
> +extern void __cds_wfq_splice_blocking(struct cds_wfq_queue *dest_q,
> +               struct cds_wfq_queue *src_q);
> +
> +/*
> + * __cds_wfq_first_blocking: mutual exclusion with "dequeue" and
> + * "splice" operations must be ensured by the caller.
> + */
> +extern struct cds_wfq_node *__cds_wfq_first_blocking(struct cds_wfq_queue *q);
> +
> +/*
> + * __cds_wfq_next_blocking: mutual exclusion with "dequeue" and "splice"
> + * operations must be ensured by the caller.
> + */
> +extern struct cds_wfq_node *__cds_wfq_next_blocking(struct cds_wfq_queue *q,
> +               struct cds_wfq_node *node);
>
>  #endif /* !_LGPL_SOURCE */
>
> +/*
> + * cds_wfq_for_each_blocking: Iterate over all nodes in a queue, without
> + * dequeuing them.
> + *
> + * cds_wfq_for_each_blocking: mutual exclusion is performed within the
> + * cds_wfq calls.
> + */
> +#define cds_wfq_for_each_blocking(q, node)             \
> +       for (node = cds_wfq_first_blocking(q);          \
> +               node != NULL;                           \
> +               node = cds_wfq_next_blocking(q, node))
> +
> +/*
> + * __cds_wfq_for_each_blocking: Iterate over all nodes in a queue,
> + * without dequeuing them.
> + *
> + * Mutual exclusion with "dequeue" and "splice" operations must be
> + * ensured by the caller.
> + */
> +
> +#define __cds_wfq_for_each_blocking(q, node)           \
> +       for (node = __cds_wfq_first_blocking(q);        \
> +               node != NULL;                           \
> +               node = __cds_wfq_next_blocking(q, node))
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/wfqueue.c b/wfqueue.c
> index 3337171..cf3dae6 100644
> --- a/wfqueue.c
> +++ b/wfqueue.c
> @@ -3,7 +3,8 @@
>   *
>   * Userspace RCU library - Queue with Wait-Free Enqueue/Blocking Dequeue
>   *
> - * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright 2011-2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
>   *
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
> @@ -38,17 +39,56 @@ void cds_wfq_init(struct cds_wfq_queue *q)
>         _cds_wfq_init(q);
>  }
>
> +bool cds_wfq_empty(struct cds_wfq_queue *q)
> +{
> +       return _cds_wfq_empty(q);
> +}
> +
>  void cds_wfq_enqueue(struct cds_wfq_queue *q, struct cds_wfq_node *node)
>  {
>         _cds_wfq_enqueue(q, node);
>  }
>
> +struct cds_wfq_node *cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
> +{
> +       return _cds_wfq_dequeue_blocking(q);
> +}
> +
> +void cds_wfq_splice_blocking(struct cds_wfq_queue *dest_q,
> +               struct cds_wfq_queue *src_q)
> +{
> +       _cds_wfq_splice_blocking(dest_q, src_q);
> +}
> +
> +struct cds_wfq_node *cds_wfq_first_blocking(struct cds_wfq_queue *q)
> +{
> +       return _cds_wfq_first_blocking(q);
> +}
> +
> +struct cds_wfq_node *cds_wfq_next_blocking(struct cds_wfq_queue *q,
> +               struct cds_wfq_node *node)
> +{
> +       return _cds_wfq_next_blocking(q, node);
> +}
> +
>  struct cds_wfq_node *__cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
>  {
>         return ___cds_wfq_dequeue_blocking(q);
>  }
>
> -struct cds_wfq_node *cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
> +void __cds_wfq_splice_blocking(struct cds_wfq_queue *dest_q,
> +               struct cds_wfq_queue *src_q)
>  {
> -       return _cds_wfq_dequeue_blocking(q);
> +       ___cds_wfq_splice_blocking(dest_q, src_q);
> +}
> +
> +struct cds_wfq_node *__cds_wfq_first_blocking(struct cds_wfq_queue *q)
> +{
> +       return ___cds_wfq_first_blocking(q);
> +}
> +
> +struct cds_wfq_node *__cds_wfq_next_blocking(struct cds_wfq_queue *q,
> +               struct cds_wfq_node *node)
> +{
> +       return ___cds_wfq_next_blocking(q, node);
>  }
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com


Thanks,
Lai
