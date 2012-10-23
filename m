From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: urcu stack and queues updates and documentation
Date: Mon, 22 Oct 2012 22:12:02 -0400
Message-ID: <20121023021202.GB13737__40567.9957628765$1350958358$gmane$org@Krystal>
References: <20121014175332.GA2947@Krystal>
	<20121016213727.GL2385@linux.vnet.ibm.com>
	<20121017151946.GA14514@Krystal>
	<20121022174410.GT2518@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TQTyO-0000du-Fl
	for lttng-dev@lists.lttng.org; Mon, 22 Oct 2012 22:12:04 -0400
Content-Disposition: inline
In-Reply-To: <20121022174410.GT2518@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> On Wed, Oct 17, 2012 at 11:19:46AM -0400, Mathieu Desnoyers wrote:
> > * Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> > > On Sun, Oct 14, 2012 at 01:53:32PM -0400, Mathieu Desnoyers wrote:
> > > > Hi Paul!
> > > > 
> > > > I know you are currently looking at documentation of urcu data
> > > > structures. I did quite a bit of work in that area these past days. Here
> > > > is my plan:
> > > 
> > > Actually, I diverted to the atomic operations, given that the stack/queue
> > > API seems to be in flux.  ;-)
> > 
> > That sounds like a wise decision ;-)
> > 
> > > > 1) I would like to deprecate, at some point, rculfqueue, wfqueue, and
> > > >    rculfstack.
> > > > 
> > > > 2) For wfqueue, we replace it by wfcqueue, currently in the urcu master
> > > >    branch.
> > > > 
> > > > 3) For rculfstack, we replace it by lfstack available here (volatile
> > > >    branch):
> > > > 
> > > > git://git.dorsal.polymtl.ca/~compudj/userspace-rcu
> > > > branch: urcu/lfstack
> > > 
> > > I probably have to document them to have any chance of having an opinion,
> > > other than my usual advice to avoid disrupting users of the old interfaces.
> > 
> > My general plan is to leave the old interfaces in place, marking them as
> > "deprecated" by adding a __attribute__((deprecated("This interface is deprecated. Please refer to urcu/xxxqueue.h for its replacement."))).
> > Then we'll be able to drop the deprecated interfaces in a couple of
> > versions.
> 
> Fair enough.  Should enough users protest, we can of course leave them
> in place.

OK.

> 
> > > > 4) I did documentation improvements (and implemented pop_all as well as
> > > >    empty, and iterators) for wfstack here (volatile branch too):
> > > > 
> > > > git://git.dorsal.polymtl.ca/~compudj/userspace-rcu
> > > > branch: urcu/wfstack
> > > 
> > > I will be very happy to take advantage of this.  ;-)
> > 
> > I wonder how we should move forward with these ? I could pull the
> > urcu/wfstack, urcu/lfstack commits into master with your approval, and
> > mark rculfstack and wfqueue as deprecated. wfstack is simply extended. I
> > would wait a bit before deciding anything wrt rculfqueue. Thoughts ?
> 
> I would be in favor of pulling them in -- we can fix if need be.
> That said, I am not so sure that getting rid of wfqueue is a good idea,
> given your analysis below.

My analysis below is about rculfqueue, not wfqueue. I think you got both
of them mixed up.

> 
> > > > 5) The last one to look into would be rculfqueue. I'd really like to
> > > >    create a lfcqueue derived from wfcqueue if possible. It's the next
> > > >    item on my todo list this weekend.
> > > 
> > > The piece I am missing is ABA avoidance.  Or is this the approach
> > > that assumes a single dequeuer?
> > 
> > If we look at the big picture, the main difference between the "wf" and
> > "lf" approaches, both for stack and queue, is that "wf" requires
> > traversal to busy-wait when it sees the intermediate NULL pointer state.
> > This allows wait-free push/enqueue with xchg. The "lf" approach ensures
> > that a simple traversal can be done on the structures, at the expense of
> > requiring a cmpxchg on the enqueue/push.
> > 
> > Luckily, for stacks, the nature of stacks makes "push" ABA-proof (see
> > the documentation in the code), even if we use cmpxchg.
> > 
> > Unluckily, for queues, using cmpxchg on enqueue is ABA-prone. dequeue
> > is ABA-prone too. Moreover, we need to have existance guarantees, so an
> > enqueue does not attempt to do a cmpxchg on the next pointer of a node
> > that has already been dequeued and reallocated. So, one approach is to
> > always rely on RCU, and require the RCU read-side lock to be held around
> > enqueue, and around dequeue. Now, the question is: can we rely on other,
> > non-rcu techniques, to protect lfqueue against ABA and offer existance
> > guarantees ?
> > 
> > A single-dequeuer approach would unfortunately not be sufficient,
> > because enqueue is ABA-prone, and due to lack of existance guarantees
> > for the node we are about to append after: if we have multiple enqueuers
> > and a single dequeuer, one enqueue could suffer from ABA, and try to
> > touch reallocated memory, due to dequeue+reallocation of a node.
> > 
> > Even forcing single-enqueuer/single-dequeuer would not suffice: if,
> > between the moment we get the tail node we plan to append after, and the
> > moment we perform the cmpxchg to that node next pointer, the node is
> > dequeued and freed, we would be touching freed memory (corruption).
> > 
> > Therefore, that would require a single mutex on _both_ enqueue and
> > dequeue operations, which really defeats the purpose of a lock-free
> > queue.
> > 
> > So my current understanding is that we might have to stay with a RCU
> > lfcqueue, requiring RCU read-side lock to be held for enqueue and
> > dequeue, and requiring to wait for a grace period to elapse before
> > freeing the memory returned by dequeue. The benefit of using rculfcqueue
> > over wfcqueue is that traversal of the nodes, and dequeue, don't need to
> > busy-loop on NULL next pointers.
> > 
> > Thoughts ?
> 
> Heh! It would indeed seem that we didn't think through the conversion
> from wfqueue as thoroughly as we might have.  ;-)

The transition from wfqueue to wfcqueue does not pose any problem. It's
transition from rculfqueue that is the concern here.

Thanks,

Mathieu

> 
> 							Thanx, Paul
> 
> > Thanks!
> > 
> > Mathieu
> > 
> > > 
> > > 							Thanx, Paul
> > > 
> > > > Thoughts ?
> > > > 
> > > > Thanks,
> > > > 
> > > > Mathieu
> > > > 
> > > > -- 
> > > > Mathieu Desnoyers
> > > > Operating System Efficiency R&D Consultant
> > > > EfficiOS Inc.
> > > > http://www.efficios.com
> > > > 
> > > 
> > 
> > -- 
> > Mathieu Desnoyers
> > Operating System Efficiency R&D Consultant
> > EfficiOS Inc.
> > http://www.efficios.com
> > 
> 
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
