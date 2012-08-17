From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC URCU PATCH] Introduce wfqueue v0
	ABI	compatibility
Date: Fri, 17 Aug 2012 00:09:47 -0400
Message-ID: <20120817040946.GA8382__37730.0580185421$1345176619$gmane$org@Krystal>
References: <20120815212806.GA17224@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T2Dsa-0000Hj-Pq
	for lttng-dev@lists.lttng.org; Fri, 17 Aug 2012 00:09:48 -0400
Content-Disposition: inline
In-Reply-To: <20120815212806.GA17224@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <eag0628@gmail.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

Hi Lai,

Here is a copy of the first patch I sent you (compatibility ABI).
Comments are welcome, but don't forget to take vacation! ;-)

Thanks,

Mathieu

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> Introduce wfqueue v0 ABI compatibility
>     
> Preparing for v1 ABI.
>     
> CC: Lai Jiangshan <laijs@cn.fujitsu.com>
> CC: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/wfqueue0.c b/wfqueue0.c
> new file mode 100644
> index 0000000..e928c0a
> --- /dev/null
> +++ b/wfqueue0.c
> @@ -0,0 +1,191 @@
> +/*
> + * wfqueue0.c
> + *
> + * Userspace RCU library - Queue with Wait-Free Enqueue/Blocking Dequeue
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
> +/* This file is provided for ABI backward compatibility with wfqueue v0. */
> +
> +#include <pthread.h>
> +#include <assert.h>
> +#include <poll.h>
> +#include <urcu/compiler.h>
> +#include <urcu/uatomic.h>
> +
> +/*
> + * Queue with wait-free enqueue/blocking dequeue.
> + * This implementation adds a dummy head node when the queue is empty to ensure
> + * we can always update the queue locklessly.
> + *
> + * Inspired from half-wait-free/half-blocking queue implementation done by
> + * Paul E. McKenney.
> + */
> +
> +struct cds_wfq_node {
> +	struct cds_wfq_node *next;
> +};
> +
> +struct cds_wfq_queue {
> +	struct cds_wfq_node *head, **tail;
> +	struct cds_wfq_node dummy;	/* Dummy node */
> +	pthread_mutex_t lock;
> +};
> +
> +#define WFQ_ADAPT_ATTEMPTS		10	/* Retry if being set */
> +#define WFQ_WAIT			10	/* Wait 10 ms if being set */
> +
> +static inline void _cds_wfq_node_init(struct cds_wfq_node *node)
> +{
> +	node->next = NULL;
> +}
> +
> +static inline void _cds_wfq_init(struct cds_wfq_queue *q)
> +{
> +	int ret;
> +
> +	_cds_wfq_node_init(&q->dummy);
> +	/* Set queue head and tail */
> +	q->head = &q->dummy;
> +	q->tail = &q->dummy.next;
> +	ret = pthread_mutex_init(&q->lock, NULL);
> +	assert(!ret);
> +}
> +
> +static inline void _cds_wfq_enqueue(struct cds_wfq_queue *q,
> +				    struct cds_wfq_node *node)
> +{
> +	struct cds_wfq_node **old_tail;
> +
> +	/*
> +	 * uatomic_xchg() implicit memory barrier orders earlier stores to data
> +	 * structure containing node and setting node->next to NULL before
> +	 * publication.
> +	 */
> +	old_tail = uatomic_xchg(&q->tail, &node->next);
> +	/*
> +	 * At this point, dequeuers see a NULL old_tail->next, which indicates
> +	 * that the queue is being appended to. The following store will append
> +	 * "node" to the queue from a dequeuer perspective.
> +	 */
> +	CMM_STORE_SHARED(*old_tail, node);
> +}
> +
> +/*
> + * Waiting for enqueuer to complete enqueue and return the next node
> + */
> +static inline struct cds_wfq_node *
> +___cds_wfq_node_sync_next(struct cds_wfq_node *node)
> +{
> +	struct cds_wfq_node *next;
> +	int attempt = 0;
> +
> +	/*
> +	 * Adaptative busy-looping waiting for enqueuer to complete enqueue.
> +	 */
> +	while ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
> +		if (++attempt >= WFQ_ADAPT_ATTEMPTS) {
> +			poll(NULL, 0, WFQ_WAIT);	/* Wait for 10ms */
> +			attempt = 0;
> +		} else
> +			caa_cpu_relax();
> +	}
> +
> +	return next;
> +}
> +
> +/*
> + * It is valid to reuse and free a dequeued node immediately.
> + *
> + * No need to go on a waitqueue here, as there is no possible state in which the
> + * list could cause dequeue to busy-loop needlessly while waiting for another
> + * thread to be scheduled. The queue appears empty until tail->next is set by
> + * enqueue.
> + */
> +static inline struct cds_wfq_node *
> +___cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
> +{
> +	struct cds_wfq_node *node, *next;
> +
> +	/*
> +	 * Queue is empty if it only contains the dummy node.
> +	 */
> +	if (q->head == &q->dummy && CMM_LOAD_SHARED(q->tail) == &q->dummy.next)
> +		return NULL;
> +	node = q->head;
> +
> +	next = ___cds_wfq_node_sync_next(node);
> +
> +	/*
> +	 * Move queue head forward.
> +	 */
> +	q->head = next;
> +	/*
> +	 * Requeue dummy node if we just dequeued it.
> +	 */
> +	if (node == &q->dummy) {
> +		_cds_wfq_node_init(node);
> +		_cds_wfq_enqueue(q, node);
> +		return ___cds_wfq_dequeue_blocking(q);
> +	}
> +	return node;
> +}
> +
> +static inline struct cds_wfq_node *
> +_cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
> +{
> +	struct cds_wfq_node *retnode;
> +	int ret;
> +
> +	ret = pthread_mutex_lock(&q->lock);
> +	assert(!ret);
> +	retnode = ___cds_wfq_dequeue_blocking(q);
> +	ret = pthread_mutex_unlock(&q->lock);
> +	assert(!ret);
> +	return retnode;
> +}
> +
> +/*
> + * library wrappers to be used by non-LGPL compatible source code.
> + */
> +
> +void cds_wfq_node_init(struct cds_wfq_node *node)
> +{
> +	_cds_wfq_node_init(node);
> +}
> +
> +void cds_wfq_init(struct cds_wfq_queue *q)
> +{
> +	_cds_wfq_init(q);
> +}
> +
> +void cds_wfq_enqueue(struct cds_wfq_queue *q, struct cds_wfq_node *node)
> +{
> +	_cds_wfq_enqueue(q, node);
> +}
> +
> +struct cds_wfq_node *cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
> +{
> +	return _cds_wfq_dequeue_blocking(q);
> +}
> +
> +struct cds_wfq_node *__cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
> +{
> +	return ___cds_wfq_dequeue_blocking(q);
> +}
> -- 
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
