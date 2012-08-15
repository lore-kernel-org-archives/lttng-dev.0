From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH] wfqueue: expand API,
	simplify implementation, small performance boost
Date: Wed, 15 Aug 2012 08:52:10 -0400
Message-ID: <20120815125209.GA11737__44401.3163833462$1345035168$gmane$org@Krystal>
References: <20120812145000.GA32747@Krystal>
	<CACvQF52366ewREnRrDgi+xUBVQ6_ifWjoDv==nHik8FbCnMugA@mail.gmail.com>
	<20120813201219.GA27637@Krystal>
	<CACvQF51tWXaTdm9jCC=0S2XA+BdzJmR0W2sFVZAuVVZiWX8jAA@mail.gmail.com>
	<20120814222724.GA9751@Krystal>
	<CACvQF51LxhB+H8X9MqmDTS4xmGUyttTMNk66=NLvqsBkw00qXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T1d51-0007js-Tl
	for lttng-dev@lists.lttng.org; Wed, 15 Aug 2012 08:52:11 -0400
Content-Disposition: inline
In-Reply-To: <CACvQF51LxhB+H8X9MqmDTS4xmGUyttTMNk66=NLvqsBkw00qXg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <eag0628@gmail.com>
Cc: lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (eag0628@gmail.com) wrote:
> On Wed, Aug 15, 2012 at 6:27 AM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > * Lai Jiangshan (eag0628@gmail.com) wrote:
> >> On Tue, Aug 14, 2012 at 4:12 AM, Mathieu Desnoyers
> >> <mathieu.desnoyers@efficios.com> wrote:
> > [...]
> >> >> >  /*
> >> >> > + * ___cds_wfq_first_blocking: get first node of a queue, without dequeuing.
> >> >> > + *
> >> >> > + * Mutual exclusion with "dequeue" and "splice" operations must be ensured
> >> >> > + * by the caller.
> >> >> > + */
> >> >> > +static inline struct cds_wfq_node *
> >> >> > +___cds_wfq_first_blocking(struct cds_wfq_queue *q)
> >> >> > +{
> >> >> > +       if (_cds_wfq_empty(q))
> >> >> > +               return NULL;
> >> >> > +       return ___cds_wfq_node_sync_next(&q->head);
> >> >> > +}
> >> >> > +
> >> >> > +/*
> >> >> > + * ___cds_wfq_next_blocking: get next node of a queue, without dequeuing.
> >> >> > + *
> >> >> > + * Mutual exclusion with "dequeue" and "splice" operations must be ensured
> >> >> > + * by the caller.
> >> >> > + */
> >> >> > +static inline struct cds_wfq_node *
> >> >> > +___cds_wfq_next_blocking(struct cds_wfq_queue *q, struct cds_wfq_node *node)
> >> >> > +{
> >> >> > +       if (CMM_LOAD_SHARED(q->tail) == node)
> >> >> > +               return NULL;
> >> >> > +       return ___cds_wfq_node_sync_next(node);
> >> >> > +}
> >> >>
> >> >>
> >> >> The same BUG as you told me.
> >> >> If q has only one node just enqueued by other thread.
> >> >> but if q->head.next is seen, ___cds_wfq_first_blocking() returns a node,
> >> >> And the update of q->tail is not seen, it is still &q->head,
> >> >> ___cds_wfq_node_sync_next(node) will be loop for every if there is no
> >> >> other enqueue.
> >> >
> >> > Good catch ! :-)
> >> >
> >> >>
> >> >>
> >> >>
> >> >> static inline struct cds_wfq_node *
> >> >> ___cds_wfq_first_blocking(struct cds_wfq_queue *q)
> >> >> {
> >> >> +        struct cds_wfq_node *ret.
> >> >>        if (_cds_wfq_empty(q))
> >> >>                return NULL;
> >> >>       ret = ___cds_wfq_node_sync_next(&q->head);
> >> >> +      cmm_smp_rmb();
> >> >> +      return ret;
> >> >> }
> >> >
> >> > However, I think we should add the rmb at the beginning of
> >> > ___cds_wfq_next_blocking(), so it applies at each "next" call.
> >> > Otherwise, I think we could end up in a situation where we wait for a
> >> > NULL next forever in the second of two consecutive
> >> > ___cds_wfq_next_blocking() calls. I therefore propose:
> >>
> >> How this can happen(wait for a NULL next forever in the second ...)?
> >>
> >> A rmb is enough to leave the state(simgle node && q->tail == &q->head).
> >> "CMM_LOAD_SHARED(q->tail) == node" will be true in the loop except this state.
> >
> > You are indeed right, but I now realise there is a small thing we need
> > to change. I tried a couple of scenarios to convince myself of it, and
> > here are my conclusions:
> >
> > - In all cases (except for the first node), comparing q->tail with node
> >   ensures that we never go beyond the tail. Except for the first node
> >   (q->head), we always perform this comparison, so at no point can we
> >   reach the nodes through "next" pointers that would be beyond the
> >   q->tail node.
> >
> > - In the case of the first node, we do the comparison with
> >
> >          CMM_LOAD_SHARED(q->head.next) == NULL
> >                 && CMM_LOAD_SHARED(q->tail) == &q->head;
> >
> >   in no particular order (checking if empty) before we move to the
> >   first node with ___cds_wfq_node_sync_next(&q->head).
> >   The reason why the first node is different from all the others is
> >   because we don't use "CMM_LOAD_SHARED(q->tail) == &q->head" alone
> >   to distinguish between an empty queue and a queue that contains
> >   nodes: we first check for NULL q->head.next, AFAIU for performance
> >   reasons: whenever possible, we don't want to read the q->tail pointer
> >   because it is being heavily updated by the enqueuer.
> 
> Is it false sharing?
> Access to q->head.next and access to q->tail have the same performance
> because they are in the same cache line.

Yes! you are right! And a quick benchmark confirms it:

with head and tail on same cache line:

SUMMARY /home/compudj/doc/userspace-rcu/tests/.libs/lt-test_urcu_wfq testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    100833595 nr_dequeues     88647134 successful enqueues 100833595 successful dequeues     88646898 end_dequeues 12186697 nr_ops 189480729

with a 256 bytes padding between head and tail, keeping the mutex on the
"head" cache line:

SUMMARY /home/compudj/doc/userspace-rcu/tests/.libs/lt-test_urcu_wfq testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    228992829 nr_dequeues    228921791 successful enqueues 228992829 successful dequeues    228921367 end_dequeues 71462 nr_ops 457914620

enqueue: 127% speedup
dequeue: 158% speedup

That is indeed a _really_ huge difference. However, to get this, we
would have to increase the size of struct cds_wfq_queue beyond its
current size, which would break API compatibility. Any idea on how to
best do this without causing incompatibility would be welcome.

Thanks!

Mathieu


> 
> >
> > So assuming the goal beyond the CMM_LOAD_SHARED(q->head.next) == NULL
> > check in the empty queue check is for performance of dequeue vs enqueue,
> > I think it would be appropriate to do a similar optimisation for the
> > ___cds_wfq_next_blocking() case: first check the next pointer of the
> > current node to see if it is NULL. If not, then we know we can fetch the
> > next pointer without comparing our position to the tail (performance
> > optimisation). However, if we do that, we'll need a cmm_smp_rmb() at
> > each ___cds_wfq_next_blocking() invocation.
> >
> > Here is the resulting code:
> >
> > /*
> >  * ___cds_wfq_first_blocking: get first node of a queue, without dequeuing.
> >  *
> >  * Mutual exclusion with "dequeue" and "splice" operations must be ensured
> >  * by the caller.
> >  */
> > static inline struct cds_wfq_node *
> > ___cds_wfq_first_blocking(struct cds_wfq_queue *q)
> > {
> >         if (_cds_wfq_empty(q))
> >                 return NULL;
> >         return ___cds_wfq_node_sync_next(&q->head);
> > }
> >
> > /*
> >  * ___cds_wfq_next_blocking: get next node of a queue, without dequeuing.
> >  *
> >  * Mutual exclusion with "dequeue" and "splice" operations must be ensured
> >  * by the caller.
> >  */
> > static inline struct cds_wfq_node *
> > ___cds_wfq_next_blocking(struct cds_wfq_queue *q, struct cds_wfq_node *node)
> > {
> >         struct cds_wfq_node *next;
> >
> >         if ((next = CMM_LOAD_SHARED(node->next)) != NULL)
> >                 return next;
> >         /* Load node->next before q->tail */
> >         cmm_smp_rmb();
> >         if (CMM_LOAD_SHARED(q->tail) == node)
> >                 return NULL;
> >         return ___cds_wfq_node_sync_next(node);
> > }
> >
> > Is my understanding correct ?
> >
> > Thanks,
> >
> > Mathieu
> >
> > --
> > Mathieu Desnoyers
> > Operating System Efficiency R&D Consultant
> > EfficiOS Inc.
> > http://www.efficios.com

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
