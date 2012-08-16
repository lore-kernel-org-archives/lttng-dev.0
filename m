From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH] wfqueue: expand API,
	simplify implementation, small performance boost
Date: Thu, 16 Aug 2012 17:02:57 -0400
Message-ID: <20120816210257.GA3331__1663.65268310091$1345151003$gmane$org@Krystal>
References: <20120812145000.GA32747@Krystal>
	<CACvQF52366ewREnRrDgi+xUBVQ6_ifWjoDv==nHik8FbCnMugA@mail.gmail.com>
	<20120813201219.GA27637@Krystal>
	<CACvQF51tWXaTdm9jCC=0S2XA+BdzJmR0W2sFVZAuVVZiWX8jAA@mail.gmail.com>
	<20120814222724.GA9751@Krystal>
	<CACvQF51LxhB+H8X9MqmDTS4xmGUyttTMNk66=NLvqsBkw00qXg@mail.gmail.com>
	<20120815125209.GA11737@Krystal>
	<CACvQF52Z-wyz=LPOjZyJpfhHdF8cAtr8A5bWABM=3A95=q8Egg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T27DX-0005Xn-Bv
	for lttng-dev@lists.lttng.org; Thu, 16 Aug 2012 17:02:59 -0400
Content-Disposition: inline
In-Reply-To: <CACvQF52Z-wyz=LPOjZyJpfhHdF8cAtr8A5bWABM=3A95=q8Egg@mail.gmail.com>
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
> >>
> >> Is it false sharing?
> >> Access to q->head.next and access to q->tail have the same performance
> >> because they are in the same cache line.
> >
> > Yes! you are right! And a quick benchmark confirms it:
> >
> > with head and tail on same cache line:
> >
> > SUMMARY /home/compudj/doc/userspace-rcu/tests/.libs/lt-test_urcu_wfq testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    100833595 nr_dequeues     88647134 successful enqueues 100833595 successful dequeues     88646898 end_dequeues 12186697 nr_ops 189480729
> >
> > with a 256 bytes padding between head and tail, keeping the mutex on the
> > "head" cache line:
> >
> > SUMMARY /home/compudj/doc/userspace-rcu/tests/.libs/lt-test_urcu_wfq testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    228992829 nr_dequeues    228921791 successful enqueues 228992829 successful dequeues    228921367 end_dequeues 71462 nr_ops 457914620
> >
> > enqueue: 127% speedup
> > dequeue: 158% speedup
> >
> > That is indeed a _really_ huge difference. However, to get this, we
> > would have to increase the size of struct cds_wfq_queue beyond its
> > current size, which would break API compatibility. Any idea on how to
> > best do this without causing incompatibility would be welcome.
> >
> 
> choice 1) two set of APIs?(cache-line-opt and none-cache-line-opt),
> many users don't need the cache-line-opt.
> choice 2) Just break the compatibility for NONE-LGPL. I think
> NONE-LGPL-user of it is rare. And current version of urcu <1.0, I
> don't like too much burden when <1.0.

Hi Lai,

Keeping backward compatibility for a while, and gradually deprecating
APIs, is very important for userspace RCU in my opinion: failure to
provide this is the first thing that will discourage users from using
the library. It is also the first thing that will turn away package
maintainers, and distributions, from this project.

I sent 2 patches that implement a compatibility ABI and the new ABI in a
way that will let us continue development on wfqueue without having to
have legacy code in our way: I plan to move all the legacy ABI to
wfqueue0.c, and have a fresh start in terms of ABI for the new wfqueue.
That way, we can eventually remove the wfqueue v0 ABI when we decide to
bump the library version number (and break compatibility).

Feedback is welcome,

Thanks!

Mathieu


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
