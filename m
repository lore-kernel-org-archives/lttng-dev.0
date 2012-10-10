From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [URCU PATCH 1/3] wfcqueue:
 implement	concurrency-efficient queue
Date: Wed, 10 Oct 2012 10:56:53 +0800
Message-ID: <5074E3F5.3080005__24053.2407573939$1349837708$gmane$org@cn.fujitsu.com>
References: <20121002141307.GA4057@Krystal> <20121002141444.GB4057@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TLmRN-0006Va-Vn
	for lttng-dev@lists.lttng.org; Tue, 09 Oct 2012 22:54:36 -0400
In-Reply-To: <20121002141444.GB4057@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

On 10/02/2012 10:14 PM, Mathieu Desnoyers wrote:
> This new API simplify the wfqueue implementation, and brings a 2.3x to
> 2.6x performance boost due to the ability to eliminate false-sharing
> between enqueue and dequeue.
> 
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
>> 	is introduced to avoid the queue->tail become NULL when shift.
>>
>> The second one shares some code with the first one, and the left code
>> are spreading in urcu-call-rcu-impl.h:
>> 1) enqueue: share with the first one
>> 2) no dequeue operation: and no shift, so it don't need dummy node,
>> 	Although the dummy node is queued when initialization, but it is removed
>> 	after the first dequeue_all operation in call_rcu_thread().
>> 	call_rcu_data_free() forgets to handle the dummy node if it is not removed.
>> 3)dequeue_all: record the old head and tail, and queue->head become the special
>> 	tail node.(atomic record the tail and change the tail).
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
>> 	no dummy node, save memory.
>> 3) dequeue_all: simply set queue->head.next to NULL, xchg the tail
>> 	and return the old head.next.
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
> I also changed the API so the queue head and tail are now two separate
> structures: it allows the queue user to place these as they like, either
> on different cache lines (to eliminate false-sharing), or close one to
> another (on same cache-line) in case a queue is spliced onto the stack
> and not concurrently accessed.
> 
> Benchmarks performed on Intel(R) Core(TM) i7-3520M CPU @ 2.90GHz
> (dual-core, with hyperthreading)
> 
> Benchmark invoked:
> for a in $(seq 1 10); do ./test_urcu_wfq 1 1 10 -a 0 -a 2; done
> 
> (using cpu number 0 and 2, which should correspond to two cores of my
> Intel 2-core/hyperthread processor)
> 
> Before patch:
> 
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     97274297 nr_dequeues     80745742 successful enqueues     97274297 successful dequeues     80745321 end_dequeues 16528976 nr_ops    178020039
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     92300568 nr_dequeues     75019529 successful enqueues     92300568 successful dequeues     74973237 end_dequeues 17327331 nr_ops    167320097
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     93516443 nr_dequeues     75846726 successful enqueues     93516443 successful dequeues     75826578 end_dequeues 17689865 nr_ops    169363169
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     94160362 nr_dequeues     77967638 successful enqueues     94160362 successful dequeues     77967638 end_dequeues 16192724 nr_ops    172128000
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     97491956 nr_dequeues     81001191 successful enqueues     97491956 successful dequeues     81000247 end_dequeues 16491709 nr_ops    178493147
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     94101298 nr_dequeues     75650510 successful enqueues     94101298 successful dequeues     75649318 end_dequeues 18451980 nr_ops    169751808
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     94742803 nr_dequeues     75402105 successful enqueues     94742803 successful dequeues     75341859 end_dequeues 19400944 nr_ops    170144908
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     92198835 nr_dequeues     75037877 successful enqueues     92198835 successful dequeues     75027605 end_dequeues 17171230 nr_ops    167236712
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     94159560 nr_dequeues     77895972 successful enqueues     94159560 successful dequeues     77858442 end_dequeues 16301118 nr_ops    172055532
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues     96059399 nr_dequeues     80115442 successful enqueues     96059399 successful dequeues     80066843 end_dequeues 15992556 nr_ops    176174841
> 
> After patch:
> 
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    221229322 nr_dequeues    210645491 successful enqueues    221229322 successful dequeues    210645088 end_dequeues 10584234 nr_ops    431874813
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    219803943 nr_dequeues    210377337 successful enqueues    219803943 successful dequeues    210368680 end_dequeues 9435263 nr_ops    430181280
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    237006358 nr_dequeues    237035340 successful enqueues    237006358 successful dequeues    236997050 end_dequeues 9308 nr_ops    474041698
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    235822443 nr_dequeues    235815942 successful enqueues    235822443 successful dequeues    235814020 end_dequeues 8423 nr_ops    471638385
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    235825567 nr_dequeues    235811803 successful enqueues    235825567 successful dequeues    235810526 end_dequeues 15041 nr_ops    471637370
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    221974953 nr_dequeues    210938190 successful enqueues    221974953 successful dequeues    210938190 end_dequeues 11036763 nr_ops    432913143
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    237994492 nr_dequeues    237938119 successful enqueues    237994492 successful dequeues    237930648 end_dequeues 63844 nr_ops    475932611
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    220634365 nr_dequeues    210491382 successful enqueues    220634365 successful dequeues    210490995 end_dequeues 10143370 nr_ops    431125747
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    237388065 nr_dequeues    237401251 successful enqueues    237388065 successful dequeues    237380295 end_dequeues 7770 nr_ops    474789316
> testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    221201436 nr_dequeues    210831162 successful enqueues    221201436 successful dequeues    210831162 end_dequeues 10370274 nr_ops    432032598
> 
> Summary: Both enqueue and dequeue speed increase: around 2.3x speedup
> for enqueue, and around 2.6x for dequeue.
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
> diff --git a/Makefile.am b/Makefile.am
> index 2396fcf..ffdca9a 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -16,7 +16,7 @@ nobase_dist_include_HEADERS = urcu/compiler.h urcu/hlist.h urcu/list.h \
>  		urcu/uatomic/generic.h urcu/arch/generic.h urcu/wfstack.h \
>  		urcu/wfqueue.h urcu/rculfstack.h urcu/rculfqueue.h \
>  		urcu/ref.h urcu/cds.h urcu/urcu_ref.h urcu/urcu-futex.h \
> -		urcu/uatomic_arch.h urcu/rculfhash.h \
> +		urcu/uatomic_arch.h urcu/rculfhash.h urcu/wfcqueue.h \
>  		$(top_srcdir)/urcu/map/*.h \
>  		$(top_srcdir)/urcu/static/*.h \
>  		urcu/tls-compat.h
> @@ -53,7 +53,7 @@ lib_LTLIBRARIES = liburcu-common.la \
>  # liburcu-common contains wait-free queues (needed by call_rcu) as well
>  # as futex fallbacks.
>  #
> -liburcu_common_la_SOURCES = wfqueue.c wfstack.c $(COMPAT)
> +liburcu_common_la_SOURCES = wfqueue.c wfcqueue.c wfstack.c $(COMPAT)
>  
>  liburcu_la_SOURCES = urcu.c urcu-pointer.c $(COMPAT)
>  liburcu_la_LIBADD = liburcu-common.la
> diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
> new file mode 100644
> index 0000000..a989984
> --- /dev/null
> +++ b/urcu/static/wfcqueue.h
> @@ -0,0 +1,380 @@
> +#ifndef _URCU_WFCQUEUE_STATIC_H
> +#define _URCU_WFCQUEUE_STATIC_H
> +
> +/*
> + * wfcqueue-static.h
> + *
> + * Userspace RCU library - Concurrent Queue with Wait-Free Enqueue/Blocking Dequeue
> + *
> + * TO BE INCLUDED ONLY IN LGPL-COMPATIBLE CODE. See wfcqueue.h for linking
> + * dynamically with the userspace rcu library.
> + *
> + * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright 2011-2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +#include <pthread.h>
> +#include <assert.h>
> +#include <poll.h>
> +#include <stdbool.h>
> +#include <urcu/compiler.h>
> +#include <urcu/uatomic.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * Concurrent queue with wait-free enqueue/blocking dequeue.
> + *
> + * Inspired from half-wait-free/half-blocking queue implementation done by
> + * Paul E. McKenney.
> + *
> + * Mutual exclusion of __cds_wfcq_* API
> + *
> + * Unless otherwise stated, the caller must ensure mutual exclusion of
> + * queue update operations "dequeue" and "splice" (for source queue).
> + * Queue read operations "first" and "next" need to be protected against
> + * concurrent "dequeue" and "splice" (for source queue) by the caller.
> + * "enqueue", "splice" (for destination queue), and "empty" are the only
> + * operations that can be used without any mutual exclusion.
> + * Mutual exclusion can be ensured by holding cds_wfcq_dequeue_lock().
> + *
> + * For convenience, cds_wfcq_dequeue_blocking() and
> + * cds_wfcq_splice_blocking() hold the dequeue lock.
> + */
> +
> +#define WFCQ_ADAPT_ATTEMPTS		10	/* Retry if being set */
> +#define WFCQ_WAIT			10	/* Wait 10 ms if being set */
> +
> +/*
> + * cds_wfcq_node_init: initialize wait-free queue node.
> + */
> +static inline void _cds_wfcq_node_init(struct cds_wfcq_node *node)
> +{
> +	node->next = NULL;
> +}
> +
> +/*
> + * cds_wfcq_init: initialize wait-free queue.
> + */
> +static inline void _cds_wfcq_init(struct cds_wfcq_head *head,
> +		struct cds_wfcq_tail *tail)
> +{
> +	int ret;
> +
> +	/* Set queue head and tail */
> +	_cds_wfcq_node_init(&head->node);
> +	tail->p = &head->node;
> +	ret = pthread_mutex_init(&head->lock, NULL);
> +	assert(!ret);
> +}
> +
> +/*
> + * cds_wfcq_empty: return whether wait-free queue is empty.
> + *
> + * No memory barrier is issued. No mutual exclusion is required.
> + */
> +static inline bool _cds_wfcq_empty(struct cds_wfcq_head *head,
> +		struct cds_wfcq_tail *tail)
> +{
> +	/*
> +	 * Queue is empty if no node is pointed by head->node.next nor
> +	 * tail->p. Even though the tail->p check is sufficient to find
> +	 * out of the queue is empty, we first check head->node.next as a
> +	 * common case to ensure that dequeuers do not frequently access
> +	 * enqueuer's tail->p cache line.
> +	 */
> +	return CMM_LOAD_SHARED(head->node.next) == NULL
> +		&& CMM_LOAD_SHARED(tail->p) == &head->node;
> +}
> +
> +static inline void _cds_wfcq_dequeue_lock(struct cds_wfcq_head *head,
> +		struct cds_wfcq_tail *tail)
> +{
> +	int ret;
> +
> +	ret = pthread_mutex_lock(&head->lock);
> +	assert(!ret);
> +}
> +
> +static inline void _cds_wfcq_dequeue_unlock(struct cds_wfcq_head *head,
> +		struct cds_wfcq_tail *tail)
> +{
> +	int ret;
> +
> +	ret = pthread_mutex_unlock(&head->lock);
> +	assert(!ret);
> +}
> +
> +static inline void ___cds_wfcq_append(struct cds_wfcq_head *head,
> +		struct cds_wfcq_tail *tail,
> +		struct cds_wfcq_node *new_head,
> +		struct cds_wfcq_node *new_tail)
> +{
> +	struct cds_wfcq_node *old_tail;
> +
> +	/*
> +	 * Implicit memory barrier before uatomic_xchg() orders earlier
> +	 * stores to data structure containing node and setting
> +	 * node->next to NULL before publication.
> +	 */
> +	old_tail = uatomic_xchg(&tail->p, new_tail);
> +
> +	/*
> +	 * Implicit memory barrier after uatomic_xchg() orders store to
> +	 * q->tail before store to old_tail->next.
> +	 *
> +	 * At this point, dequeuers see a NULL tail->p->next, which
> +	 * indicates that the queue is being appended to. The following
> +	 * store will append "node" to the queue from a dequeuer
> +	 * perspective.
> +	 */
> +	CMM_STORE_SHARED(old_tail->next, new_head);
> +}
> +
> +/*
> + * cds_wfcq_enqueue: enqueue a node into a wait-free queue.
> + *
> + * Issues a full memory barrier before enqueue. No mutual exclusion is
> + * required.
> + */
> +static inline void _cds_wfcq_enqueue(struct cds_wfcq_head *head,
> +		struct cds_wfcq_tail *tail,
> +		struct cds_wfcq_node *new_tail)
> +{
> +	___cds_wfcq_append(head, tail, new_tail, new_tail);
> +}
> +
> +/*
> + * Waiting for enqueuer to complete enqueue and return the next node.
> + */
> +static inline struct cds_wfcq_node *
> +___cds_wfcq_node_sync_next(struct cds_wfcq_node *node)
> +{
> +	struct cds_wfcq_node *next;
> +	int attempt = 0;
> +
> +	/*
> +	 * Adaptative busy-looping waiting for enqueuer to complete enqueue.
> +	 */
> +	while ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
> +		if (++attempt >= WFCQ_ADAPT_ATTEMPTS) {
> +			poll(NULL, 0, WFCQ_WAIT);	/* Wait for 10ms */
> +			attempt = 0;
> +		} else {
> +			caa_cpu_relax();
> +		}
> +	}
> +
> +	return next;
> +}
> +
> +/*
> + * __cds_wfcq_first_blocking: get first node of a queue, without dequeuing.
> + *
> + * Content written into the node before enqueue is guaranteed to be
> + * consistent, but no other memory ordering is ensured.
> + * Should be called with cds_wfcq_dequeue_lock() held.
> + */
> +static inline struct cds_wfcq_node *
> +___cds_wfcq_first_blocking(struct cds_wfcq_head *head,
> +		struct cds_wfcq_tail *tail)
> +{
> +	struct cds_wfcq_node *node;
> +
> +	if (_cds_wfcq_empty(head, tail))
> +		return NULL;
> +	node = ___cds_wfcq_node_sync_next(&head->node);
> +	/* Load head->node.next before loading node's content */
> +	cmm_smp_read_barrier_depends();
> +	return node;
> +}
> +
> +/*
> + * __cds_wfcq_next_blocking: get next node of a queue, without dequeuing.
> + *
> + * Content written into the node before enqueue is guaranteed to be
> + * consistent, but no other memory ordering is ensured.
> + * Should be called with cds_wfcq_dequeue_lock() held.
> + */
> +static inline struct cds_wfcq_node *
> +___cds_wfcq_next_blocking(struct cds_wfcq_head *head,
> +		struct cds_wfcq_tail *tail,
> +		struct cds_wfcq_node *node)
> +{
> +	struct cds_wfcq_node *next;
> +
> +	/*
> +	 * Even though the following tail->p check is sufficient to find
> +	 * out if we reached the end of the queue, we first check
> +	 * node->next as a common case to ensure that iteration on nodes
> +	 * do not frequently access enqueuer's tail->p cache line.
> +	 */
> +	if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
> +		/* Load node->next before tail->p */
> +		cmm_smp_rmb();
> +		if (CMM_LOAD_SHARED(tail->p) == node)
> +			return NULL;
> +		next = ___cds_wfcq_node_sync_next(node);
> +	}
> +	/* Load node->next before loading next's content */
> +	cmm_smp_read_barrier_depends();
> +	return next;
> +}
> +
> +/*
> + * __cds_wfcq_dequeue_blocking: dequeue a node from the queue.
> + *
> + * No need to go on a waitqueue here, as there is no possible state in which the
> + * list could cause dequeue to busy-loop needlessly while waiting for another
> + * thread to be scheduled. The queue appears empty until tail->next is set by
> + * enqueue.
> + *
> + * Content written into the node before enqueue is guaranteed to be
> + * consistent, but no other memory ordering is ensured.
> + * It is valid to reuse and free a dequeued node immediately.
> + * Should be called with cds_wfcq_dequeue_lock() held.
> + */
> +static inline struct cds_wfcq_node *
> +___cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
> +		struct cds_wfcq_tail *tail)
> +{
> +	struct cds_wfcq_node *node, *next;
> +
> +	if (_cds_wfcq_empty(head, tail))
> +		return NULL;
> +
> +	node = ___cds_wfcq_node_sync_next(&head->node);
> +
> +	if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
> +		/*
> +		 * @node is probably the only node in the queue.
> +		 * Try to move the tail to &q->head.
> +		 * q->head.next is set to NULL here, and stays
> +		 * NULL if the cmpxchg succeeds. Should the
> +		 * cmpxchg fail due to a concurrent enqueue, the
> +		 * q->head.next will be set to the next node.
> +		 * The implicit memory barrier before
> +		 * uatomic_cmpxchg() orders load node->next
> +		 * before loading q->tail.
> +		 * The implicit memory barrier before uatomic_cmpxchg
> +		 * orders load q->head.next before loading node's
> +		 * content.
> +		 */
> +		_cds_wfcq_node_init(&head->node);
> +		if (uatomic_cmpxchg(&tail->p, node, &head->node) == node)
> +			return node;
> +		next = ___cds_wfcq_node_sync_next(node);
> +	}
> +
> +	/*
> +	 * Move queue head forward.
> +	 */
> +	head->node.next = next;
> +
> +	/* Load q->head.next before loading node's content */
> +	cmm_smp_read_barrier_depends();
> +	return node;
> +}
> +
> +/*
> + * __cds_wfcq_splice_blocking: enqueue all src_q nodes at the end of dest_q.
> + *
> + * Dequeue all nodes from src_q.
> + * dest_q must be already initialized.
> + * Should be called with cds_wfcq_dequeue_lock() held on src_q.
> + */
> +static inline void
> +___cds_wfcq_splice_blocking(
> +		struct cds_wfcq_head *dest_q_head,
> +		struct cds_wfcq_tail *dest_q_tail,
> +		struct cds_wfcq_head *src_q_head,
> +		struct cds_wfcq_tail *src_q_tail)
> +{
> +	struct cds_wfcq_node *head, *tail;
> +
> +	if (_cds_wfcq_empty(src_q_head, src_q_tail))
> +		return;
> +
> +	head = ___cds_wfcq_node_sync_next(&src_q_head->node);
> +	_cds_wfcq_node_init(&src_q_head->node);
> +
> +	/*
> +	 * Memory barrier implied before uatomic_xchg() orders store to
> +	 * src_q->head before store to src_q->tail. This is required by
> +	 * concurrent enqueue on src_q, which exchanges the tail before
> +	 * updating the previous tail's next pointer.
> +	 */
> +	tail = uatomic_xchg(&src_q_tail->p, &src_q_head->node);
> +
> +	/*
> +	 * Append the spliced content of src_q into dest_q. Does not
> +	 * require mutual exclusion on dest_q (wait-free).
> +	 */
> +	___cds_wfcq_append(dest_q_head, dest_q_tail, head, tail);
> +}
> +
> +/*
> + * cds_wfcq_dequeue_blocking: dequeue a node from a wait-free queue.
> + *
> + * Content written into the node before enqueue is guaranteed to be
> + * consistent, but no other memory ordering is ensured.
> + * Mutual exlusion with (and only with) cds_wfcq_splice_blocking is
> + * ensured.
> + * It is valid to reuse and free a dequeued node immediately.
> + */
> +static inline struct cds_wfcq_node *
> +_cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
> +		struct cds_wfcq_tail *tail)
> +{
> +	struct cds_wfcq_node *retval;
> +
> +	_cds_wfcq_dequeue_lock(head, tail);
> +	retval = ___cds_wfcq_dequeue_blocking(head, tail);
> +	_cds_wfcq_dequeue_unlock(head, tail);
> +	return retval;
> +}
> +
> +/*
> + * cds_wfcq_splice_blocking: enqueue all src_q nodes at the end of dest_q.
> + *
> + * Dequeue all nodes from src_q.
> + * dest_q must be already initialized.
> + * Content written into the node before enqueue is guaranteed to be
> + * consistent, but no other memory ordering is ensured.
> + * Mutual exlusion with (and only with) cds_wfcq_dequeue_blocking is
> + * ensured.
> + */
> +static inline void
> +_cds_wfcq_splice_blocking(
> +		struct cds_wfcq_head *dest_q_head,
> +		struct cds_wfcq_tail *dest_q_tail,
> +		struct cds_wfcq_head *src_q_head,
> +		struct cds_wfcq_tail *src_q_tail)
> +{
> +	_cds_wfcq_dequeue_lock(src_q_head, src_q_tail);
> +	___cds_wfcq_splice_blocking(dest_q_head, dest_q_tail,
> +			src_q_head, src_q_tail);
> +	_cds_wfcq_dequeue_unlock(src_q_head, src_q_tail);
> +}
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* _URCU_WFCQUEUE_STATIC_H */
> diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
> new file mode 100644
> index 0000000..5576cbf
> --- /dev/null
> +++ b/urcu/wfcqueue.h
> @@ -0,0 +1,263 @@
> +#ifndef _URCU_WFCQUEUE_H
> +#define _URCU_WFCQUEUE_H
> +
> +/*
> + * wfcqueue.h
> + *
> + * Userspace RCU library - Concurrent Queue with Wait-Free Enqueue/Blocking Dequeue
> + *
> + * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright 2011-2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +#include <pthread.h>
> +#include <assert.h>
> +#include <stdbool.h>
> +#include <urcu/compiler.h>
> +#include <urcu/arch.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * Concurrent queue with wait-free enqueue/blocking dequeue.
> + *
> + * Inspired from half-wait-free/half-blocking queue implementation done by
> + * Paul E. McKenney.
> + */
> +
> +struct cds_wfcq_node {
> +	struct cds_wfcq_node *next;
> +};
> +
> +/*
> + * Do not put head and tail on the same cache-line if concurrent
> + * enqueue/dequeue are expected from many CPUs. This eliminates
> + * false-sharing between enqueue and dequeue.
> + */
> +struct cds_wfcq_head {
> +	struct cds_wfcq_node node;
> +	pthread_mutex_t lock;
> +};
> +
> +struct cds_wfcq_tail {
> +	struct cds_wfcq_node *p;
> +};

Why use "p" here?

I don't see the commits in the public git-tree. Or you forgot to update the
tree and make "http" address happy.

Thanks,
Lai
