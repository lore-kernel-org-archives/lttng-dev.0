From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC URCU PATCH] wfqueue: ABI v1,
	simplify	implementation, 2.3x to 2.6x performance boost
Date: Fri, 7 Sep 2012 09:03:25 -0400
Message-ID: <20120907130325.GA22377__24506.89209295$1347023035$gmane$org@Krystal>
References: <20120815213107.GB17224@Krystal> <5032054D.7050508@cn.fujitsu.com>
	<20120820131642.GA551@Krystal> <50330371.6060401@cn.fujitsu.com>
	<50357FF8.9060704@cn.fujitsu.com> <20120906134346.GE3630@Krystal>
	<504968CC.4090101@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T9yDW-0007Oz-Gb
	for lttng-dev@lists.lttng.org; Fri, 07 Sep 2012 09:03:26 -0400
Content-Disposition: inline
In-Reply-To: <504968CC.4090101@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> On 09/06/2012 09:43 PM, Mathieu Desnoyers wrote:
> > * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> >> ping
> > 
> > we discussed a "batch" design offline. Do you think you would have time
> > to spin a patch implementing it ?
> > 
> 
> I prefer separated enqueue_struct dequeue_struct a little, so I'm
> waiting for you.
> 
> DEADLOCK!

Hahaha :-)

OK, I'm planning to discuss this with Paul next week, to get a 3rd
opinion. I don't want to make choices too quickly for APIs. So
meanwhile, let's try to sum up the possible solutions, those I recall
are:

1) The current API, with a single struct cds_wfqueue for enqueue and
   dequeue, with false-sharing between enqueue and dequeue, but on the
   plus side it provides a compact structure to put on the stack.

2) An API with cache-aligned fields of struct cds_wfqueue for enqueue
   and dequeue. Removes false-sharing, but requires a larger structure
   when extracted onto the stack with our new splice operation.

3) An API with two different queue representations: a "queue" and a
   "batch". The "queue" is bullet (2) above, and when we splice elements
   onto the stack, we put them in a "batch", described by bullet (1)
   above.

4) An API that takes separate enqueue/dequeue structures: it would allow
   the caller to decide the memory layout of those structures. We
   could possibly provide macros helpers for the common cases. E.g.

struct cds_enq {
        struct cds_wfq_node *tail;
};
struct cds_deq {
        struct cds_wfq_node head;
        pthread_mutex_t lock;
};
#define DEFINE_CDS_Q_ON_STACK(q)                                    \
        struct wfenqueue __cds_wfqenqueue_##q = { NULL };           \
        struct wfdequeue __cds_wfqdequeue_##q =                     \
                        { { NULL }, PTHREAD_MUTEX_INITIALIZER, }

/* For queue head/tail in data */
#define DEFINE_CDS_Q(q)                                             \
        struct cds_enq __cds_enq_##q                                \
                __attribute__((aligned((CAA_CACHE_LINE_SIZE))))     \
                        = { NULL };                                 \
        struct cds_deq __cds_deq_##q                                \
                 __attribute__((aligned((CAA_CACHE_LINE_SIZE))))    \
                        = { { NULL }, PTHREAD_MUTEX_INITIALIZER, }

And for dynamic allocation, then the user could specify the alignment
they want for their allocated memory (not sure it is worth it to do
helpers for that).

#define CDS_Q(q)        __cds_enq_##q, __cds_deq_##q

Then, when those structures would be passed to enqueue/dequeue:

static DEFINE_CDS_Q(myqueue);

void fct(void) {
   ...
   cds_wfq_enqueue(CDS_Q(myqueue), somenode);
}

Thoughts ?

Thanks,

Mathieu

> 
> thanks,
> Lai

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
