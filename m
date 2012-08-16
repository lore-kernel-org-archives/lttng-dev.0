From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH] wfqueue: expand API,
	simplify implementation, small performance boost
Date: Thu, 16 Aug 2012 17:11:55 -0400
Message-ID: <20120816211155.GA3487__29233.7169558325$1345151539$gmane$org@Krystal>
References: <20120812145000.GA32747@Krystal>
	<CACvQF52366ewREnRrDgi+xUBVQ6_ifWjoDv==nHik8FbCnMugA@mail.gmail.com>
	<20120813201219.GA27637@Krystal>
	<CACvQF51tWXaTdm9jCC=0S2XA+BdzJmR0W2sFVZAuVVZiWX8jAA@mail.gmail.com>
	<20120814222724.GA9751@Krystal>
	<CACvQF51LxhB+H8X9MqmDTS4xmGUyttTMNk66=NLvqsBkw00qXg@mail.gmail.com>
	<20120815125209.GA11737@Krystal>
	<CACvQF52Z-wyz=LPOjZyJpfhHdF8cAtr8A5bWABM=3A95=q8Egg@mail.gmail.com>
	<CACvQF53D1u4FYcY9ab5J6XRi0E4Z+5mM++DgpVR+Vumqvr15wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T27MC-0005cO-QD
	for lttng-dev@lists.lttng.org; Thu, 16 Aug 2012 17:11:56 -0400
Content-Disposition: inline
In-Reply-To: <CACvQF53D1u4FYcY9ab5J6XRi0E4Z+5mM++DgpVR+Vumqvr15wQ@mail.gmail.com>
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
> We need the smallest patch at first, all other things left in disscussion.
> no free_each(), simple changes.

I guess you mean for_each().

If we limit ourself to the versions where the user is doing the locking,
I don't think there were any issues left.

In the version I provided (in the last series of 2 patches), I took care
of all issues that were raised in our email discussion.

I prefer to introduce these new API members all in one go, mainly because
I really don't want to add new API members (exposed through the public API)
and then remove them afterward when we notice that they expose too many
details. I think the current splice, dequeue, next, and first API
members allow any user to do the kind of use-case that call_rcu is
doing: this lets us achieve your original goal of not duplicating the
code everywhere.

If you still notice issues with __cds_wfq_for_each_blocking() and
__cds_wfq_for_each_blocking_safe() in the last patch, please let me
know,

Thanks !

Mathieu

> 
> thanks,
> Lai
> 
> On Thu, Aug 16, 2012 at 10:08 AM, Lai Jiangshan <eag0628@gmail.com> wrote:
> >>>
> >>> Is it false sharing?
> >>> Access to q->head.next and access to q->tail have the same performance
> >>> because they are in the same cache line.
> >>
> >> Yes! you are right! And a quick benchmark confirms it:
> >>
> >> with head and tail on same cache line:
> >>
> >> SUMMARY /home/compudj/doc/userspace-rcu/tests/.libs/lt-test_urcu_wfq testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    100833595 nr_dequeues     88647134 successful enqueues 100833595 successful dequeues     88646898 end_dequeues 12186697 nr_ops 189480729
> >>
> >> with a 256 bytes padding between head and tail, keeping the mutex on the
> >> "head" cache line:
> >>
> >> SUMMARY /home/compudj/doc/userspace-rcu/tests/.libs/lt-test_urcu_wfq testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    228992829 nr_dequeues    228921791 successful enqueues 228992829 successful dequeues    228921367 end_dequeues 71462 nr_ops 457914620
> >>
> >> enqueue: 127% speedup
> >> dequeue: 158% speedup
> >>
> >> That is indeed a _really_ huge difference. However, to get this, we
> >> would have to increase the size of struct cds_wfq_queue beyond its
> >> current size, which would break API compatibility. Any idea on how to
> >> best do this without causing incompatibility would be welcome.
> >>
> >
> > choice 1) two set of APIs?(cache-line-opt and none-cache-line-opt),
> > many users don't need the cache-line-opt.
> > choice 2) Just break the compatibility for NONE-LGPL. I think
> > NONE-LGPL-user of it is rare. And current version of urcu <1.0, I
> > don't like too much burden when <1.0.
> >
> >
> > thanks,
> > Lai

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
