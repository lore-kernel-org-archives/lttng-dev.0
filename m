From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC URCU PATCH] wfqueue: ABI v1,
	simplify implementation, 2.3x to 2.6x performance boost
Date: Mon, 20 Aug 2012 09:16:42 -0400
Message-ID: <20120820131642.GA551__29912.1337746785$1345468634$gmane$org@Krystal>
References: <20120815213107.GB17224@Krystal> <5032054D.7050508@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T3RqX-0002T6-Jh
	for lttng-dev@lists.lttng.org; Mon, 20 Aug 2012 09:16:45 -0400
Content-Disposition: inline
In-Reply-To: <5032054D.7050508@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> On 08/16/2012 05:31 AM, Mathieu Desnoyers wrote:
> > This work is derived from the patch from Lai Jiangshan submitted as
> > "urcu: new wfqueue implementation"
> > (http://lists.lttng.org/pipermail/lttng-dev/2012-August/018379.html)
> > 
> 

Hi Lai,

> Hi, Mathieu
> 
> please add this part to your patch.
> 
> Changes(item5 has alternative):
> 
> 1) Reorder the head and the tail in struct cds_wfq_queue
>    Reason: wfq is enqueue-preference

Is this a technical improvement over the original order ? Both cache
lines are aligned, so it should not matter which one comes first. So I'm
not sure why we should favor one order vs the other.

> 2) Reorder the code of ___cds_wfq_next_blocking()
>    Reason: short code, better readability

Yes, I agree with this change. Can you extract it into a separate patch ?

> 
> 3) Add cds_wfq_dequeue_[un]lock
>    Reason: the fields of struct cds_wfq_queue are not exposed to users of lib,
> 	but some APIs needs to have this lock held. Add this locking function
> 	to allow the users use such APIs

I agree with this change too. You can put it into the same patch as (2).

> 
> 4) Add cds_wfq_node_sync_next(), cds_wfq_dequeue_all_blocking()
>    Reason: helper for for_each_*

Points 4-5-6-7 will need more discussion.

I don't like exposing "cds_wfq_node_sync_next()", which should remain an
internal implementation detail not exposed to queue users.  The
"get_first"/"get_next" API, as well as the dequeue, are providing an
abstraction that hide the node synchronization, which makes it harder
for the user to make mistakes. Given that the fast-path of
cds_wfq_node_sync_next is just a pointer load and test, I don't think
that skipping this the second time we iterate on the same queue would
bring any significant performance improvement, but exposing sync_next
adds in API complexity, which I would like to avoid.

About cds_wfq_dequeue_all_blocking(): the "cds_wfq_splice()" I
introduced performs the same action as "cds_wfq_dequeue_all_blocking()",
but ensures that we can splice lists multiple times (rather than only
once), which is a very neat side-effect. Let's imagine a use-case like
Tree RCU, where each CPU produce a queue of call_rcu callbacks, and we
need to merge pairs of queues together recursively until we reach the
tree root: by doing splice() at each level of the tree, we can combine
the queues into a single queue without ever needing to do an iteration
on each node: no node synchronization is needed until we actually need
to traverse the queue at the root node level.

The cost of exposing dequeue_all is that we need to expose sync_next
(more complexity for the user). As you exposed in your earlier email,
the gain we get by exposing dequeue_all separately from splice is that
dequeue_all is 1 xchg() operation, while splice is 2 xchg() operations.
However, given that this operation is typically amortized over many
nodes makes performance optimization a less compelling argument than
simplicity of use.

> 
> 5) Add more for_each_*, which default semantic is dequeuing
>    Reason: __cds_wfq_for_each_blocking_undequeue is enough for undequeuing loops
> 	don't need to add more.
> 	looping and dequeuing are the most probable use-cases.
> 	dequeuing for_each_* make the queue like a pipe. make it act as a channel.(GO language)
>    Alternative: rename these dequeuing __cds_wfq_for_each*() to __cds_wfq_dequeue_for_each*

I notice, in the iterators you added, the presence of
"cds_wfq_for_each_blocking_nobreak", and
"cds_wfq_for_each_blocking_nobreak_internal", which document that this
special flavor is needed for loops that do not have a "break" statement.
That seems to be very much error-prone and counter-intuitive for users,
and I would like to avoid that.

The "internal" flavor, along with "sync_next" are then used in the
call_rcu code, since they are needed to get the best performance
possible. I don't like to use special, internal APIs for call_rcu: the
original motivation for refactoring the wfqueue code was testability,
and I would really like to make sure that the APIs we use internally are
also exposed to the outside world, mainly for testability, and also
because if we need to directly access internal interfaces to have good
performance, it means we did a poor job at exporting APIs that allow to
do the same kind of highly-efficient use of the queue. Exposing an API
with the "internal" keyword in it clearly discourages users from using
it.


> 
> 6) Remove __cds_wfq_for_each_blocking_safe
>    Reason: its semantic is not clear, hard to define a well-defined semantic to it.
> 	when we use it, we have to delete none or delete all nodes, even when we delete all nodes,
> 	struct cds_wfq_queue still becomes stale while looping or after loop.

The typical use-case I envision is:

- enqueue many nodes to queue A

- then, a dequeuer thread splice the content of queue A into its temporary
  queue T (which head is local on its stack).

- now, the thread is free to iterate on queue T, as many times as it
  likes, and it does not need to change the structure of the queue while
  iterating on it (read-only operation, without side-effect). The last
  time it iterates on queue T, it needs to use the _safe iteration and
  free the nodes.

- after the nodes have been deleted, the queue T can be simply discarded
  (if on stack, function return will do so; if dynamically allocated,
  can be simply reinitialized to an empty queue, or freed).

As you certainly noticed, we can iterate both on a queue being
concurrently enqueued to, and on a queue that has been spliced into.
Being able to use iterators and dequeue on any queue (initial enqueue,
or queue spliced to) is a feature: we can therefore postpone the
"sync_next" synchronization to the moment where loop iteration is really
needed (lazy synchronization), which keeps optimal locality of reference
of synchronization vs node data access.

> 
> 7) Rename old __cds_wfq_for_each_blocking() to __cds_wfq_for_each_blocking_undequeue()
>    Reason: the default semantic of the other for_each_* is dequeuing.

I'm not convinced that "__cds_wfq_for_each_blocking_nobreak",
"__cds_wfq_for_each_blocking_nobreak_internal", and sync_next APIs are
improvements over the API I propose. For call_rcu, this turns

cds_wfq_enqueue()
cds_wfq_splice_blocking()
__cds_wfq_for_each_blocking_safe() for iteration

into:

cds_wfq_enqueue()
__cds_wfq_dequeue_all_blocking()
__cds_wfq_for_each_blocking_nobreak_internal() for iteration

Maybe we could do some documentation improvement to
"__cds_wfq_for_each_blocking(_safe)", __cds_wfq_first_blocking(),
__cds_wfq_next_blocking() API members I proposed. Maybe I did not
document them well enough ?

Thanks,

Mathieu


> 
> 
> ---
>  urcu-call-rcu-impl.h  |   13 +---
>  urcu/static/wfqueue.h |  131 ++++++++++++++++++++++++++++--------------
>  urcu/wfqueue.h        |  154 ++++++++++++++++++++++++++++++++++++--------------
>  wfqueue.c             |   27 ++++++++
>  4 files changed, 233 insertions(+), 92 deletions(-)
> 
> diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
> index d8537d0..061c2d4 100644
> --- a/urcu-call-rcu-impl.h
> +++ b/urcu-call-rcu-impl.h
> @@ -241,16 +241,15 @@ static void *call_rcu_thread(void *arg)
>  		cmm_smp_mb();
>  	}
>  	for (;;) {
> -		struct cds_wfq_queue cbs_tmp;
> -		struct cds_wfq_node *cbs, *tmp_cbs;
> +		while (!cds_wfq_empty(&crdp->cbs)) {
> +			struct cds_wfq_node *cbs, *next, *tail;
>  
> -		cds_wfq_init(&cbs_tmp);
> -		__cds_wfq_splice_blocking(&cbs_tmp, &crdp->cbs);
> -		if (!cds_wfq_empty(&cbs_tmp)) {
> +			next = __cds_wfq_dequeue_all_blocking(&crdp->cbs, &tail);
>  			synchronize_rcu();
>  			cbcount = 0;
> -			__cds_wfq_for_each_blocking_safe(&cbs_tmp,
> -					cbs, tmp_cbs) {
> +
> +			__cds_wfq_for_each_blocking_nobreak_internal(
> +					next, cbs, next, tail) {
>  				struct rcu_head *rhp;
>  
>  				rhp = caa_container_of(cbs,
> diff --git a/urcu/static/wfqueue.h b/urcu/static/wfqueue.h
> index 52e452d..e5a01ec 100644
> --- a/urcu/static/wfqueue.h
> +++ b/urcu/static/wfqueue.h
> @@ -84,6 +84,22 @@ static inline bool _cds_wfq_empty(struct cds_wfq_queue *q)
>  		&& CMM_LOAD_SHARED(q->enqueue.tail) == &q->dequeue.head;
>  }
>  
> +static inline void _cds_wfq_dequeue_lock(struct cds_wfq_queue *q)
> +{
> +	int ret;
> +
> +	ret = pthread_mutex_lock(&q->dequeue.lock);
> +	assert(!ret);
> +}
> +
> +static inline void _cds_wfq_dequeue_unlock(struct cds_wfq_queue *q)
> +{
> +	int ret;
> +
> +	ret = pthread_mutex_unlock(&q->dequeue.lock);
> +	assert(!ret);
> +}
> +
>  static inline void ___cds_wfq_append(struct cds_wfq_queue *q,
>  		struct cds_wfq_node *new_head,
>  		struct cds_wfq_node *new_tail)
> @@ -139,30 +155,33 @@ ___cds_wfq_node_sync_next(struct cds_wfq_node *node)
>  	return next;
>  }
>  
> +static inline struct cds_wfq_node *
> +_cds_wfq_node_sync_next(struct cds_wfq_node *node)
> +{
> +	struct cds_wfq_node *next = ___cds_wfq_node_sync_next(node);
> +
> +	/* Load node->next before loading next's content */
> +	cmm_smp_read_barrier_depends();
> +	return next;
> +}
> +
>  /*
>   * ___cds_wfq_first_blocking: get first node of a queue, without dequeuing.
>   *
> - * Mutual exclusion with "dequeue" and "splice" operations must be ensured
> - * by the caller.
> + * Should be called with cds_wfq_dequeue_lock() held.
>   */
>  static inline struct cds_wfq_node *
>  ___cds_wfq_first_blocking(struct cds_wfq_queue *q)
>  {
> -	struct cds_wfq_node *node;
> -
>  	if (_cds_wfq_empty(q))
>  		return NULL;
> -	node = ___cds_wfq_node_sync_next(&q->dequeue.head);
> -	/* Load q->head.next before loading node's content */
> -	cmm_smp_read_barrier_depends();
> -	return node;
> +	return _cds_wfq_node_sync_next(&q->dequeue.head);
>  }
>  
>  /*
>   * ___cds_wfq_next_blocking: get next node of a queue, without dequeuing.
>   *
> - * Mutual exclusion with "dequeue" and "splice" operations must be ensured
> - * by the caller.
> + * Should be called with cds_wfq_dequeue_lock() held.
>   */
>  static inline struct cds_wfq_node *
>  ___cds_wfq_next_blocking(struct cds_wfq_queue *q, struct cds_wfq_node *node)
> @@ -175,16 +194,13 @@ ___cds_wfq_next_blocking(struct cds_wfq_queue *q, struct cds_wfq_node *node)
>  	 * node->next as a common case to ensure that iteration on nodes
>  	 * do not frequently access enqueuer's q->tail cache line.
>  	 */
> -	if ((next = CMM_LOAD_SHARED(node->next)) != NULL) {
> -		/* Load node->next before loading next's content */
> -		cmm_smp_read_barrier_depends();
> -		return next;
> +	if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
> +		/* Load node->next before q->tail */
> +		cmm_smp_rmb();
> +		if (CMM_LOAD_SHARED(q->enqueue.tail) == node)
> +			return NULL;
> +		next = ___cds_wfq_node_sync_next(node);
>  	}
> -	/* Load node->next before q->tail */
> -	cmm_smp_rmb();
> -	if (CMM_LOAD_SHARED(q->enqueue.tail) == node)
> -		return NULL;
> -	next = ___cds_wfq_node_sync_next(node);
>  	/* Load node->next before loading next's content */
>  	cmm_smp_read_barrier_depends();
>  	return next;
> @@ -199,6 +215,8 @@ ___cds_wfq_next_blocking(struct cds_wfq_queue *q, struct cds_wfq_node *node)
>   * list could cause dequeue to busy-loop needlessly while waiting for another
>   * thread to be scheduled. The queue appears empty until tail->next is set by
>   * enqueue.
> + *
> + * Should be called with cds_wfq_dequeue_lock() held.
>   */
>  static inline struct cds_wfq_node *
>  ___cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
> @@ -243,12 +261,41 @@ ___cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
>  }
>  
>  /*
> + * ___cds_wfq_dequeue_all_blocking: dequeue all nodes
> + *
> + * Dequeue all nodes from @q.
> + * Returns the head of the dequeued nodes which tail is saved in @ret_tail.
> + * Should be called with cds_wfq_dequeue_lock() held.
> + */
> +static inline struct cds_wfq_node *
> +___cds_wfq_dequeue_all_blocking(struct cds_wfq_queue *q,
> +		struct cds_wfq_node **ret_tail)
> +{
> +	struct cds_wfq_node *head;
> +
> +	if (_cds_wfq_empty(q))
> +		return NULL;
> +
> +	head = ___cds_wfq_node_sync_next(&q->dequeue.head);
> +	_cds_wfq_node_init(&q->dequeue.head);
> +
> +	/*
> +	 * Memory barrier implied before uatomic_xchg() orders store to
> +	 * q->dequeue.head before store to q->enqueue.tail. This is required
> +	 * by concurrent enqueue on q, which exchanges the tail before
> +	 * updating the previous tail's next pointer.
> +	 */
> +	*ret_tail = uatomic_xchg(&q->enqueue.tail, &q->dequeue.head);
> +
> +	return head;
> +}
> +
> +/*
>   * ___cds_wfq_splice_blocking: enqueue all src_q nodes at the end of dest_q.
>   *
>   * Dequeue all nodes from src_q.
>   * dest_q must be already initialized.
> - * caller ensures mutual exclusion of dequeue and splice operations on
> - * src_q.
> + * Should be called with cds_wfq_dequeue_lock() held.
>   */
>  static inline void
>  ___cds_wfq_splice_blocking(struct cds_wfq_queue *dest_q,
> @@ -256,20 +303,9 @@ ___cds_wfq_splice_blocking(struct cds_wfq_queue *dest_q,
>  {
>  	struct cds_wfq_node *head, *tail;
>  
> -	if (_cds_wfq_empty(src_q))
> +	if ((head = ___cds_wfq_dequeue_all_blocking(src_q, &tail)) == NULL)
>  		return;
>  
> -	head = ___cds_wfq_node_sync_next(&src_q->dequeue.head);
> -	_cds_wfq_node_init(&src_q->dequeue.head);
> -
> -	/*
> -	 * Memory barrier implied before uatomic_xchg() orders store to
> -	 * src_q->head before store to src_q->tail. This is required by
> -	 * concurrent enqueue on src_q, which exchanges the tail before
> -	 * updating the previous tail's next pointer.
> -	 */
> -	tail = uatomic_xchg(&src_q->enqueue.tail, &src_q->dequeue.head);
> -
>  	/*
>  	 * Append the spliced content of src_q into dest_q. Does not
>  	 * require mutual exclusion on dest_q (wait-free).
> @@ -282,27 +318,34 @@ static inline struct cds_wfq_node *
>  _cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
>  {
>  	struct cds_wfq_node *retval;
> -	int ret;
>  
> -	ret = pthread_mutex_lock(&q->dequeue.lock);
> -	assert(!ret);
> +	_cds_wfq_dequeue_lock(q);
>  	retval = ___cds_wfq_dequeue_blocking(q);
> -	ret = pthread_mutex_unlock(&q->dequeue.lock);
> -	assert(!ret);
> +	_cds_wfq_dequeue_unlock(q);
> +
>  	return retval;
>  }
>  
> +static inline struct cds_wfq_node *
> +_cds_wfq_dequeue_all_blocking(struct cds_wfq_queue *q,
> +		struct cds_wfq_node **ret_tail)
> +{
> +	struct cds_wfq_node *head;
> +
> +	_cds_wfq_dequeue_lock(q);
> +	head = _cds_wfq_dequeue_all_blocking(q, ret_tail);
> +	_cds_wfq_dequeue_unlock(q);
> +
> +	return head;
> +}
> +
>  static inline void
>  _cds_wfq_splice_blocking(struct cds_wfq_queue *dest_q,
>  		struct cds_wfq_queue *src_q)
>  {
> -	int ret;
> -
> -	ret = pthread_mutex_lock(&src_q->dequeue.lock);
> -	assert(!ret);
> +	_cds_wfq_dequeue_lock(src_q);
>  	___cds_wfq_splice_blocking(dest_q, src_q);
> -	ret = pthread_mutex_unlock(&src_q->dequeue.lock);
> -	assert(!ret);
> +	_cds_wfq_dequeue_unlock(src_q);
>  }
>  
>  #ifdef __cplusplus
> diff --git a/urcu/wfqueue.h b/urcu/wfqueue.h
> index 446c94c..a3627ac 100644
> --- a/urcu/wfqueue.h
> +++ b/urcu/wfqueue.h
> @@ -47,12 +47,12 @@ struct cds_wfq_node {
>  
>  struct cds_wfq_queue {
>  	struct {
> +		struct cds_wfq_node *tail;
> +	} __attribute__((aligned((CAA_CACHE_LINE_SIZE)))) enqueue;
> +	struct {
>  		struct cds_wfq_node head;
>  		pthread_mutex_t lock;
>  	} __attribute__((aligned((CAA_CACHE_LINE_SIZE)))) dequeue;
> -	struct {
> -		struct cds_wfq_node *tail;
> -	} __attribute__((aligned((CAA_CACHE_LINE_SIZE)))) enqueue;
>  };
>  
>  #ifdef _LGPL_SOURCE
> @@ -62,71 +62,97 @@ struct cds_wfq_queue {
>  #define cds_wfq_node_init		_cds_wfq_node_init
>  #define cds_wfq_init			_cds_wfq_init
>  #define cds_wfq_empty			_cds_wfq_empty
> +
> +/* Locking */
> +#define cds_wfq_dequeue_lock		_cds_wfq_dequeue_lock
> +#define cds_wfq_dequeue_unlock		_cds_wfq_dequeue_unlock
> +
>  #define cds_wfq_enqueue			_cds_wfq_enqueue
>  
> +/*
> + * Helpers for for_each_*:
> + * 	cds_wfq_node_sync_next()
> + * 	cds_wfq_dequeue_all_blocking()
> + * 	__cds_wfq_dequeue_all_blocking()
> + * 	__cds_wfq_first_blocking()
> + * 	__cds_wfq_next_blocking()
> + */
> +#define cds_wfq_node_sync_next		_cds_wfq_node_sync_next
> +
>  /* Locking performed within cds_wfq calls. */
>  #define cds_wfq_dequeue_blocking	_cds_wfq_dequeue_blocking
> +#define cds_wfq_dequeue_all_blocking	_cds_wfq_dequeue_all_blocking
>  #define cds_wfq_splice_blocking		_cds_wfq_splice_blocking
> -#define cds_wfq_first_blocking		_cds_wfq_first_blocking
> -#define cds_wfq_next_blocking		_cds_wfq_next_blocking
>  
> -/* Locking ensured by caller */
> +/* Locking ensured by caller(called with cds_wfq_dequeue_lock() held) */
>  #define __cds_wfq_dequeue_blocking	___cds_wfq_dequeue_blocking
> +#define __cds_wfq_dequeue_all_blocking	___cds_wfq_dequeue_all_blocking
>  #define __cds_wfq_splice_blocking	___cds_wfq_splice_blocking
>  #define __cds_wfq_first_blocking	___cds_wfq_first_blocking
>  #define __cds_wfq_next_blocking		___cds_wfq_next_blocking
>  
>  #else /* !_LGPL_SOURCE */
>  
> +/* !_LGPL_SOURCE wrappers */
> +
>  extern void cds_wfq_node_init_1(struct cds_wfq_node *node);
>  extern void cds_wfq_init_1(struct cds_wfq_queue *q);
>  extern bool cds_wfq_empty_1(struct cds_wfq_queue *q);
> +
> +extern void cds_wfq_dequeue_lock_1(struct cds_wfq_queue *q);
> +extern void cds_wfq_dequeue_unlock_1(struct cds_wfq_queue *q);
> +
>  extern void cds_wfq_enqueue_1(struct cds_wfq_queue *q, struct cds_wfq_node *node);
>  
> +extern struct cds_wfq_node *cds_wfq_node_sync_next_1(struct cds_wfq_node *node);
> +
>  /* Locking performed within cds_wfq calls. */
>  extern struct cds_wfq_node *cds_wfq_dequeue_blocking_1(struct cds_wfq_queue *q);
> +extern struct cds_wfq_node *cds_wfq_dequeue_all_blocking_1(struct cds_wfq_queue *q,
> +		struct cds_wfq_node **ret_tail);
>  extern void cds_wfq_splice_blocking_1(struct cds_wfq_queue *dest_q,
>  		struct cds_wfq_queue *src_q);
>  
> -/*
> - * __cds_wfq_dequeue_blocking: caller ensures mutual exclusion of dequeue
> - * and splice operations.
> - */
> +/* The following functions shouled be called with cds_wfq_dequeue_lock() held */
>  extern struct cds_wfq_node *__cds_wfq_dequeue_blocking_1(struct cds_wfq_queue *q);
> -
> -/*
> - * __cds_wfq_splice_blocking: caller ensures mutual exclusion of dequeue and
> - * splice operations on src_q. dest_q must be already initialized.
> - */
> +extern struct cds_wfq_node *__cds_wfq_dequeue_all_blocking_1(struct cds_wfq_queue *q,
> +		struct cds_wfq_node **ret_tail);
>  extern void __cds_wfq_splice_blocking_1(struct cds_wfq_queue *dest_q,
>  		struct cds_wfq_queue *src_q);
> -
> -/*
> - * __cds_wfq_first_blocking: mutual exclusion with "dequeue" and
> - * "splice" operations must be ensured by the caller.
> - */
>  extern struct cds_wfq_node *__cds_wfq_first_blocking_1(struct cds_wfq_queue *q);
> -
> -/*
> - * __cds_wfq_next_blocking: mutual exclusion with "dequeue" and "splice"
> - * operations must be ensured by the caller.
> - */
>  extern struct cds_wfq_node *__cds_wfq_next_blocking_1(struct cds_wfq_queue *q,
>  		struct cds_wfq_node *node);
>  
> +/* !_LGPL_SOURCE APIs */
> +
>  #define cds_wfq_node_init		cds_wfq_node_init_1
>  #define cds_wfq_init			cds_wfq_init_1
>  #define cds_wfq_empty			cds_wfq_empty_1
> +
> +/* Locking */
> +#define cds_wfq_dequeue_lock		cds_wfq_dequeue_lock_1
> +#define cds_wfq_dequeue_unlock		cds_wfq_dequeue_unlock_1
> +
>  #define cds_wfq_enqueue			cds_wfq_enqueue_1
>  
> +/*
> + * Helpers for for_each_*:
> + * 	cds_wfq_node_sync_next()
> + * 	cds_wfq_dequeue_all_blocking()
> + * 	__cds_wfq_dequeue_all_blocking()
> + * 	__cds_wfq_first_blocking()
> + * 	__cds_wfq_next_blocking()
> + */
> +#define cds_wfq_node_sync_next		cds_wfq_node_sync_next_1
> +
>  /* Locking performed within cds_wfq calls. */
>  #define cds_wfq_dequeue_blocking	cds_wfq_dequeue_blocking_1
> +#define cds_wfq_dequeue_all_blocking	cds_wfq_dequeue_all_blocking_1
>  #define cds_wfq_splice_blocking		cds_wfq_splice_blocking_1
> -#define cds_wfq_first_blocking		cds_wfq_first_blocking_1
> -#define cds_wfq_next_blocking		cds_wfq_next_blocking_1
>  
> -/* Locking ensured by caller */
> +/* Locking ensured by caller(called with cds_wfq_dequeue_lock() held) */
>  #define __cds_wfq_dequeue_blocking	__cds_wfq_dequeue_blocking_1
> +#define __cds_wfq_dequeue_all_blocking	__cds_wfq_dequeue_all_blocking_1
>  #define __cds_wfq_splice_blocking	__cds_wfq_splice_blocking_1
>  #define __cds_wfq_first_blocking	__cds_wfq_first_blocking_1
>  #define __cds_wfq_next_blocking		__cds_wfq_next_blocking_1
> @@ -134,29 +160,75 @@ extern struct cds_wfq_node *__cds_wfq_next_blocking_1(struct cds_wfq_queue *q,
>  #endif /* !_LGPL_SOURCE */
>  
>  /*
> - * __cds_wfq_for_each_blocking: Iterate over all nodes in a queue,
> + * for_each_* routines: Iterate over all nodes in a queue and dequeue
> + * the travlled nodes(except __cds_wfq_for_each_blocking_undequeue).
> + *
> + * All nodes which are un-dequeued && enqueued before the for_each_*
> + * will be travelled.
> + *
> + * Nodes which are enqueued after the for_each_* started MAY or may NOT
> + * be travelled.
> + */
> +
> +/*
> + * __cds_wfq_for_each_blocking_undequeue: Iterate over all nodes in a queue,
>   * without dequeuing them.
>   *
> - * Mutual exclusion with "dequeue" and "splice" operations must be
> - * ensured by the caller.
> + * Should be called with cds_wfq_dequeue_lock() held.
>   */
> -#define __cds_wfq_for_each_blocking(q, node)		\
> +#define __cds_wfq_for_each_blocking_undequeue(q, node)	\
>  	for (node = __cds_wfq_first_blocking(q);	\
>  		node != NULL;				\
>  		node = __cds_wfq_next_blocking(q, node))
>  
> +#define __cds_wfq_for_each_blocking_nobreak_internal(all, node, next, tail)		\
> +	for (node = all,								\
> +		next = ((node && node != tail) ? cds_wfq_node_sync_next(node) : NULL);	\
> +		node != NULL;								\
> +		node = next,								\
> +		next = ((node && node != tail) ? cds_wfq_node_sync_next(node) : NULL))
> +
>  /*
> - * __cds_wfq_for_each_blocking_safe: Iterate over all nodes in a queue,
> - * without dequeuing them. Safe against deletion.
> + * __cds_wfq_for_each_blocking_nobreak: Iterate over all nodes in a queue,
> + * and dequeue them.
>   *
> - * Mutual exclusion with "dequeue" and "splice" operations must be
> - * ensured by the caller.
> + * Should not use "break;" or other statement to leave the control flow
> + * from the loop body, otherwise it causes un-travelled nodes leak.
> + *
> + * Should be called with cds_wfq_dequeue_lock() held.
> + */
> +#define __cds_wfq_for_each_blocking_nobreak(q, node, next, tail)		\
> +	__cds_wfq_for_each_blocking_nobreak_internal(				\
> +		__cds_wfq_dequeue_all_blocking(q, &tail), node, next, tail)
> +
> +/*
> + * cds_wfq_for_each_blocking_nobreak: Iterate over all nodes in a queue,
> + * and dequeue them.
> + *
> + * Should not use "break;" or other statement to leave the control flow
> + * from the loop body, otherwise it causes un-travelled nodes leak.
> + */
> +#define cds_wfq_for_each_blocking_nobreak(q, node, next, tail)			\
> +	__cds_wfq_for_each_blocking_nobreak_internal(				\
> +		cds_wfq_dequeue_all_blocking(q, &tail), node, next, tail)
> +
> +/*
> + * __cds_wfq_for_each_blocking: Iterate over all nodes in a queue,
> + * and dequeue them.
> + *
> + * Should be called with cds_wfq_dequeue_lock() held.
> + */
> +#define __cds_wfq_for_each_blocking(q, node)					\
> +	for (node = __cds_wfq_dequeue_blocking(q); node;			\
> +		node = __cds_wfq_dequeue_blocking(q))
> +
> +/*
> + * cds_wfq_for_each_blocking: Iterate over all nodes in a queue,
> + * and dequeue them.
>   */
> -#define __cds_wfq_for_each_blocking_safe(q, node, n)			       \
> -	for (node = __cds_wfq_first_blocking(q),			       \
> -			n = (node ? __cds_wfq_next_blocking(q, node) : NULL);  \
> -		node != NULL;						       \
> -		node = n, n = (node ? __cds_wfq_next_blocking(q, node) : NULL))
> +#define cds_wfq_for_each_blocking(q, node)					\
> +	for (node = cds_wfq_dequeue_blocking(q); node;				\
> +		node = cds_wfq_dequeue_blocking(q))
>  
>  #ifdef __cplusplus
>  }
> diff --git a/wfqueue.c b/wfqueue.c
> index b5fba7b..eee1fd8 100644
> --- a/wfqueue.c
> +++ b/wfqueue.c
> @@ -44,16 +44,37 @@ bool cds_wfq_empty_1(struct cds_wfq_queue *q)
>  	return _cds_wfq_empty(q);
>  }
>  
> +void cds_wfq_dequeue_lock_1(struct cds_wfq_queue *q)
> +{
> +	cds_wfq_dequeue_lock(q);
> +}
> +
> +void cds_wfq_dequeue_unlock_1(struct cds_wfq_queue *q)
> +{
> +	cds_wfq_dequeue_unlock(q);
> +}
> +
>  void cds_wfq_enqueue_1(struct cds_wfq_queue *q, struct cds_wfq_node *node)
>  {
>  	_cds_wfq_enqueue(q, node);
>  }
>  
> +struct cds_wfq_node *cds_wfq_node_sync_next_1(struct cds_wfq_node *node)
> +{
> +	return _cds_wfq_node_sync_next(node);
> +}
> +
>  struct cds_wfq_node *cds_wfq_dequeue_blocking_1(struct cds_wfq_queue *q)
>  {
>  	return _cds_wfq_dequeue_blocking(q);
>  }
>  
> +struct cds_wfq_node *cds_wfq_dequeue_all_blocking_1(struct cds_wfq_queue *q,
> +		struct cds_wfq_node **ret_tail)
> +{
> +	return _cds_wfq_dequeue_all_blocking(q, ret_tail);
> +}
> +
>  void cds_wfq_splice_blocking_1(struct cds_wfq_queue *dest_q,
>  		struct cds_wfq_queue *src_q)
>  {
> @@ -65,6 +86,12 @@ struct cds_wfq_node *__cds_wfq_dequeue_blocking_1(struct cds_wfq_queue *q)
>  	return ___cds_wfq_dequeue_blocking(q);
>  }
>  
> +struct cds_wfq_node *__cds_wfq_dequeue_all_blocking_1(struct cds_wfq_queue *q,
> +		struct cds_wfq_node **ret_tail)
> +{
> +	return ___cds_wfq_dequeue_all_blocking(q, ret_tail);
> +}
> +
>  void __cds_wfq_splice_blocking_1(struct cds_wfq_queue *dest_q,
>  		struct cds_wfq_queue *src_q)
>  {

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
