From: Lai Jiangshan <eag0628@gmail.com>
Subject: Re: [PATCH 2/2] urcu: new wfqueue implementation
Date: Mon, 13 Aug 2012 21:59:18 +0800
Message-ID: <CACvQF51dXcDJA0o2hcE0bAR_6LNQEA7r_Ypkj0r-E_3b6j5FCg__25524.4487002075$1344866399$gmane$org@mail.gmail.com>
References: <1344501986-23151-1-git-send-email-laijs@cn.fujitsu.com>
	<1344501986-23151-2-git-send-email-laijs@cn.fujitsu.com>
	<20120811131417.GA13886@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <eag0628@gmail.com>) id 1T0vAy-0003JE-5s
	for lttng-dev@lists.lttng.org; Mon, 13 Aug 2012 09:59:24 -0400
Received: by qafk30 with SMTP id k30so2590431qaf.14
	for <lttng-dev@lists.lttng.org>; Mon, 13 Aug 2012 06:59:18 -0700 (PDT)
In-Reply-To: <20120811131417.GA13886@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

On Sat, Aug 11, 2012 at 9:14 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
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
> Hi Lai,
>
> Some other style-related questions below,
>
>>
>>
>> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
>> ---
>>  urcu-call-rcu-impl.h  |   50 ++++++++++--------------
>>  urcu/static/wfqueue.h |  104 ++++++++++++++++++++++++++++++++++++------------
>>  urcu/wfqueue.h        |   25 ++++++++++--
>>  wfqueue.c             |   29 ++++++++++++++
>>  4 files changed, 149 insertions(+), 59 deletions(-)
>>
>> diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
>> index 13b24ff..dbfb410 100644
>> --- a/urcu-call-rcu-impl.h
>> +++ b/urcu-call-rcu-impl.h
>> @@ -221,7 +221,7 @@ static void *call_rcu_thread(void *arg)
>>  {
>>       unsigned long cbcount;
>>       struct cds_wfq_node *cbs;
>> -     struct cds_wfq_node **cbs_tail;
>> +     struct cds_wfq_node *cbs_tail;
>>       struct call_rcu_data *crdp = (struct call_rcu_data *)arg;
>>       struct rcu_head *rhp;
>>       int rt = !!(uatomic_read(&crdp->flags) & URCU_CALL_RCU_RT);
>> @@ -243,24 +243,18 @@ static void *call_rcu_thread(void *arg)
>>               cmm_smp_mb();
>>       }
>>       for (;;) {
>> -             if (&crdp->cbs.head != _CMM_LOAD_SHARED(crdp->cbs.tail)) {
>> -                     while ((cbs = _CMM_LOAD_SHARED(crdp->cbs.head)) == NULL)
>> -                             poll(NULL, 0, 1);
>> -                     _CMM_STORE_SHARED(crdp->cbs.head, NULL);
>> -                     cbs_tail = (struct cds_wfq_node **)
>> -                             uatomic_xchg(&crdp->cbs.tail, &crdp->cbs.head);
>> +             cbs = __cds_wfq_dequeue_all_blocking(&crdp->cbs, &cbs_tail);
>> +             if (cbs) {
>>                       synchronize_rcu();
>>                       cbcount = 0;
>>                       do {
>> -                             while (cbs->next == NULL &&
>> -                                    &cbs->next != cbs_tail)
>> -                                     poll(NULL, 0, 1);
>> -                             if (cbs == &crdp->cbs.dummy) {
>> -                                     cbs = cbs->next;
>> -                                     continue;
>> -                             }
>>                               rhp = (struct rcu_head *)cbs;
>> -                             cbs = cbs->next;
>> +
>> +                             if (cbs != cbs_tail)
>> +                                     cbs = __cds_wfq_node_sync_next(cbs);
>> +                             else
>> +                                     cbs = NULL;
>> +
>>                               rhp->func(rhp);
>>                               cbcount++;
>>                       } while (cbs != NULL);
>> @@ -270,8 +264,7 @@ static void *call_rcu_thread(void *arg)
>>                       break;
>>               rcu_thread_offline();
>>               if (!rt) {
>> -                     if (&crdp->cbs.head
>> -                         == _CMM_LOAD_SHARED(crdp->cbs.tail)) {
>> +                     if (cds_wfq_empty(&crdp->cbs)) {
>>                               call_rcu_wait(crdp);
>>                               poll(NULL, 0, 10);
>>                               uatomic_dec(&crdp->futex);
>> @@ -625,32 +618,31 @@ void call_rcu(struct rcu_head *head,
>>   */
>>  void call_rcu_data_free(struct call_rcu_data *crdp)
>>  {
>> -     struct cds_wfq_node *cbs;
>> -     struct cds_wfq_node **cbs_tail;
>> -     struct cds_wfq_node **cbs_endprev;
>> +     struct cds_wfq_node *head, *tail;
>>
>>       if (crdp == NULL || crdp == default_call_rcu_data) {
>>               return;
>>       }
>> +
>>       if ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0) {
>>               uatomic_or(&crdp->flags, URCU_CALL_RCU_STOP);
>>               wake_call_rcu_thread(crdp);
>>               while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0)
>>                       poll(NULL, 0, 1);
>>       }
>> -     if (&crdp->cbs.head != _CMM_LOAD_SHARED(crdp->cbs.tail)) {
>> -             while ((cbs = _CMM_LOAD_SHARED(crdp->cbs.head)) == NULL)
>> -                     poll(NULL, 0, 1);
>> -             _CMM_STORE_SHARED(crdp->cbs.head, NULL);
>> -             cbs_tail = (struct cds_wfq_node **)
>> -                     uatomic_xchg(&crdp->cbs.tail, &crdp->cbs.head);
>> +
>> +     if (!cds_wfq_empty(&crdp->cbs)) {
>> +             head = __cds_wfq_dequeue_all_blocking(&crdp->cbs, &tail);
>> +             assert(head);
>> +
>>               /* Create default call rcu data if need be */
>>               (void) get_default_call_rcu_data();
>> -             cbs_endprev = (struct cds_wfq_node **)
>> -                     uatomic_xchg(&default_call_rcu_data, cbs_tail);
>> -             *cbs_endprev = cbs;
>> +
>> +             __cds_wfq_append_list(&default_call_rcu_data->cbs, head, tail);
>> +
>>               uatomic_add(&default_call_rcu_data->qlen,
>>                           uatomic_read(&crdp->qlen));
>> +
>>               wake_call_rcu_thread(default_call_rcu_data);
>>       }
>>
>> diff --git a/urcu/static/wfqueue.h b/urcu/static/wfqueue.h
>> index 636e1af..15ea9fc 100644
>> --- a/urcu/static/wfqueue.h
>> +++ b/urcu/static/wfqueue.h
>> @@ -10,6 +10,7 @@
>>   * dynamically with the userspace rcu library.
>>   *
>>   * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> + * Copyright 2011-2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
>>   *
>>   * This library is free software; you can redistribute it and/or
>>   * modify it under the terms of the GNU Lesser General Public
>> @@ -29,6 +30,7 @@
>>  #include <pthread.h>
>>  #include <assert.h>
>>  #include <poll.h>
>> +#include <stdbool.h>
>>  #include <urcu/compiler.h>
>>  #include <urcu/uatomic.h>
>>
>> @@ -38,8 +40,6 @@ extern "C" {
>>
>>  /*
>>   * Queue with wait-free enqueue/blocking dequeue.
>> - * This implementation adds a dummy head node when the queue is empty to ensure
>> - * we can always update the queue locklessly.
>>   *
>>   * Inspired from half-wait-free/half-blocking queue implementation done by
>>   * Paul E. McKenney.
>> @@ -57,31 +57,43 @@ static inline void _cds_wfq_init(struct cds_wfq_queue *q)
>>  {
>>       int ret;
>>
>> -     _cds_wfq_node_init(&q->dummy);
>>       /* Set queue head and tail */
>> -     q->head = &q->dummy;
>> -     q->tail = &q->dummy.next;
>> +     _cds_wfq_node_init(&q->head);
>> +     q->tail = &q->head;
>>       ret = pthread_mutex_init(&q->lock, NULL);
>>       assert(!ret);
>>  }
>>
>> -static inline void _cds_wfq_enqueue(struct cds_wfq_queue *q,
>> -                                 struct cds_wfq_node *node)
>> +static inline bool _cds_wfq_empty(struct cds_wfq_queue *q)
>>  {
>> -     struct cds_wfq_node **old_tail;
>> +     /*
>> +      * Queue is empty if no node is pointed by q->head.next nor q->tail.
>> +      */
>> +     return q->head.next == NULL && CMM_LOAD_SHARED(q->tail) == &q->head;
>> +}
>>
>> +static inline void ___cds_wfq_append_list(struct cds_wfq_queue *q,
>> +             struct cds_wfq_node *head, struct cds_wfq_node *tail)
>> +{
>>       /*
>>        * uatomic_xchg() implicit memory barrier orders earlier stores to data
>>        * structure containing node and setting node->next to NULL before
>>        * publication.
>>        */
>> -     old_tail = uatomic_xchg(&q->tail, &node->next);
>> +     tail = uatomic_xchg(&q->tail, tail);
>
> I'd prefer to keep "old_tail" here, because it becomes clearer to anyone
> reviewing that uatomic_xchg() returns the old tail (and this extra
> clarity comes without any overhead).
>
>> +
>>       /*
>> -      * At this point, dequeuers see a NULL old_tail->next, which indicates
>> +      * At this point, dequeuers see a NULL tail->next, which indicates
>>        * that the queue is being appended to. The following store will append
>>        * "node" to the queue from a dequeuer perspective.
>>        */
>> -     CMM_STORE_SHARED(*old_tail, node);
>> +     CMM_STORE_SHARED(tail->next, head);
>> +}
>> +
>> +static inline void _cds_wfq_enqueue(struct cds_wfq_queue *q,
>> +                                 struct cds_wfq_node *node)
>> +{
>> +     ___cds_wfq_append_list(q, node, node);
>>  }
>
> Why not keep ___cds_wfq_append_list() merged into _cds_wfq_enqueue() ?
>
> This would keep the number of symbols exported minimal.
>
> So if I get it right, one "_" prefix is the "normally used" functions
> (exposed through the LGPL symbol API).
>
> The "__" prefix are somewhat more internal, but can also be used
> externally.
>
> Finally, the "___" prefix seem to be quite similar to the
> double-underscores.
>
> We might need more consistency, I'm not sure the triple-underscores are
> needed. Also, I'm not sure should export the double-underscore functions
> outside of LGPL use (in other words, maybe we should not expose them to
> !LGPL_SOURCE code). So we would emit the static inlines, but no symbols
> for those. This covers ___cds_wfq_node_sync_next(), and
> ___cds_wfq_dequeue_all_blocking (which requires the caller to use
> sync_next). Currently, all code that needs to fine-grained integration
> is within the userspace RCU tree, which defines LGPL_SOURCE.

The mean of _xfunction() is not defined by me, I guess it is a function
implemented in  urcu/static/ which don't care about LGPL_SOURCE.
(xfunction() is the same as _xfunction() but different wrapped-way
with LGPL_SOURCE or not)

__xfunction() (double-underscores) in my patch means "this function
will not call
 pthread_mutex_lock(&q->lock), it is caller's responsibility for
synchronization"
if xfunction() is already underscored, __xfunction() will become
triple-underscores.

>
>>
>>  /*
>> @@ -120,27 +132,46 @@ ___cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
>>  {
>>       struct cds_wfq_node *node, *next;
>>
>> -     /*
>> -      * Queue is empty if it only contains the dummy node.
>> -      */
>> -     if (q->head == &q->dummy && CMM_LOAD_SHARED(q->tail) == &q->dummy.next)
>> +     if (_cds_wfq_empty(q))
>>               return NULL;
>> -     node = q->head;
>>
>> -     next = ___cds_wfq_node_sync_next(node);
>> +     node = ___cds_wfq_node_sync_next(&q->head);
>> +
>> +     if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
>> +             if (CMM_LOAD_SHARED(q->tail) == node) {
>> +                     /*
>> +                      * @node is the only node in the queue.
>> +                      * Try to move the tail to &q->head
>> +                      */
>> +                     _cds_wfq_node_init(&q->head);
>> +                     if (uatomic_cmpxchg(&q->tail, node, &q->head) == node)
>> +                             return node;
>> +             }
>> +             next = ___cds_wfq_node_sync_next(node);
>> +     }
>>
>>       /*
>>        * Move queue head forward.
>>        */
>> -     q->head = next;
>> -     /*
>> -      * Requeue dummy node if we just dequeued it.
>> -      */
>> -     if (node == &q->dummy) {
>> -             _cds_wfq_node_init(node);
>> -             _cds_wfq_enqueue(q, node);
>> -             return ___cds_wfq_dequeue_blocking(q);
>> -     }
>> +     q->head.next = next;
>> +
>> +     return node;
>> +}
>> +
>> +/* dequeue all nodes, the nodes are not synchronized for the next pointer */
>> +static inline struct cds_wfq_node *
>> +___cds_wfq_dequeue_all_blocking(struct cds_wfq_queue *q,
>> +             struct cds_wfq_node **tail)
>> +{
>> +     struct cds_wfq_node *node;
>> +
>> +     if (_cds_wfq_empty(q))
>> +             return NULL;
>> +
>> +     node = ___cds_wfq_node_sync_next(&q->head);
>> +     _cds_wfq_node_init(&q->head);
>> +     *tail = uatomic_xchg(&q->tail, &q->head);
>> +
>>       return node;
>>  }
>>
>> @@ -158,6 +189,27 @@ _cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
>>       return retnode;
>>  }
>>
>> +static inline struct cds_wfq_node *
>> +_cds_wfq_dequeue_all_blocking(struct cds_wfq_queue *q,
>> +             struct cds_wfq_node **tail)
>> +{
>> +     struct cds_wfq_node *node, *next;
>> +     int ret;
>> +
>> +     ret = pthread_mutex_lock(&q->lock);
>> +     assert(!ret);
>> +     node = ___cds_wfq_dequeue_all_blocking(q, tail);
>> +     ret = pthread_mutex_unlock(&q->lock);
>> +     assert(!ret);
>
> So we take the queue lock on dequeue_all, but not on dequeue.

?!
dequeue operation still takes the lock, I didn't change _dequeue() function,
so it does not appear in the patch.

> It might
> be good to have a consistent behavior: either we lock dequeue and
> dequeue_all, or leave the lock entirely to the caller (and document it).

_dequeue() and _dequeue_all() take the queue lock.
___dequeue() and ___dequeue_all() don't.

thanks,
Lai
