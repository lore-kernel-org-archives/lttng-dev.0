From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC URCU PATCH] wfqueue: ABI v1,
	simplify	implementation, 2.3x to 2.6x performance boost
Date: Thu, 6 Sep 2012 09:43:46 -0400
Message-ID: <20120906134346.GE3630__44469.8357758627$1346939057$gmane$org@Krystal>
References: <20120815213107.GB17224@Krystal> <5032054D.7050508@cn.fujitsu.com>
	<20120820131642.GA551@Krystal> <50330371.6060401@cn.fujitsu.com>
	<50357FF8.9060704@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T9cN2-0004yI-2S
	for lttng-dev@lists.lttng.org; Thu, 06 Sep 2012 09:43:48 -0400
Content-Disposition: inline
In-Reply-To: <50357FF8.9060704@cn.fujitsu.com>
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
> ping

we discussed a "batch" design offline. Do you think you would have time
to spin a patch implementing it ?

Thanks,

Mathieu

> 
> On 08/21/2012 11:41 AM, Lai Jiangshan wrote:
> > On 08/20/2012 09:16 PM, Mathieu Desnoyers wrote:
> >> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> >>> On 08/16/2012 05:31 AM, Mathieu Desnoyers wrote:
> >>>> This work is derived from the patch from Lai Jiangshan submitted as
> >>>> "urcu: new wfqueue implementation"
> >>>> (http://lists.lttng.org/pipermail/lttng-dev/2012-August/018379.html)
> >>>>
> >>>
> >>
> >> Hi Lai,
> >>
> >>> Hi, Mathieu
> >>>
> >>> please add this part to your patch.
> >>>
> >>> Changes(item5 has alternative):
> >>>
> >>> 1) Reorder the head and the tail in struct cds_wfq_queue
> >>>    Reason: wfq is enqueue-preference
> >>
> >> Is this a technical improvement over the original order ? Both cache
> >> lines are aligned, so it should not matter which one comes first. So I'm
> >> not sure why we should favor one order vs the other.
> >>
> >>> 2) Reorder the code of ___cds_wfq_next_blocking()
> >>>    Reason: short code, better readability
> >>
> >> Yes, I agree with this change. Can you extract it into a separate patch ?
> >>
> >>>
> >>> 3) Add cds_wfq_dequeue_[un]lock
> >>>    Reason: the fields of struct cds_wfq_queue are not exposed to users of lib,
> >>> 	but some APIs needs to have this lock held. Add this locking function
> >>> 	to allow the users use such APIs
> >>
> >> I agree with this change too. You can put it into the same patch as (2).
> >>
> >>>
> >>> 4) Add cds_wfq_node_sync_next(), cds_wfq_dequeue_all_blocking()
> >>>    Reason: helper for for_each_*
> >>
> >> Points 4-5-6-7 will need more discussion.
> >>
> >> I don't like exposing "cds_wfq_node_sync_next()", which should remain an
> >> internal implementation detail not exposed to queue users.  The
> >> "get_first"/"get_next" API, as well as the dequeue, are providing an
> >> abstraction that hide the node synchronization, which makes it harder
> >> for the user to make mistakes. Given that the fast-path of
> >> cds_wfq_node_sync_next is just a pointer load and test, I don't think
> >> that skipping this the second time we iterate on the same queue would
> >> bring any significant performance improvement, but exposing sync_next
> >> adds in API complexity, which I would like to avoid.
> > 
> > If the name "cds_wfq_node_sync_next()" is bad and exposes the implementation,
> > we can rename it to "__cds_wfq_next_blocking_nocheck()" to hide the implementation.
> > 
> > "get_next_nocheck": get next node of a queue, the caller ensure that the next node is existed.
> > "get_next": get next node of a queue, it also finds out that whether the next node is existed or not.
> > 
> > Or just remove "cds_wfq_node_sync_next()", use "get_next" instead.
> > 
> >>
> >> About cds_wfq_dequeue_all_blocking(): the "cds_wfq_splice()" I
> >> introduced performs the same action as "cds_wfq_dequeue_all_blocking()",
> >> but ensures that we can splice lists multiple times (rather than only
> >> once), which is a very neat side-effect. Let's imagine a use-case like
> >> Tree RCU, where each CPU produce a queue of call_rcu callbacks, and we
> >> need to merge pairs of queues together recursively until we reach the
> >> tree root: by doing splice() at each level of the tree, we can combine
> >> the queues into a single queue without ever needing to do an iteration
> >> on each node: no node synchronization is needed until we actually need
> >> to traverse the queue at the root node level.
> >>
> >> The cost of exposing dequeue_all is that we need to expose sync_next
> >> (more complexity for the user). As you exposed in your earlier email,
> >> the gain we get by exposing dequeue_all separately from splice is that
> >> dequeue_all is 1 xchg() operation, while splice is 2 xchg() operations.
> >> However, given that this operation is typically amortized over many
> >> nodes makes performance optimization a less compelling argument than
> >> simplicity of use.
> > 
> > Reducing the temporary big struct is also my tempt.
> > 
> > ---
> > Related to "internal", see the bottom.
> > 
> >>
> >>>
> >>> 5) Add more for_each_*, which default semantic is dequeuing
> >>>    Reason: __cds_wfq_for_each_blocking_undequeue is enough for undequeuing loops
> >>> 	don't need to add more.
> >>> 	looping and dequeuing are the most probable use-cases.
> >>> 	dequeuing for_each_* make the queue like a pipe. make it act as a channel.(GO language)
> >>>    Alternative: rename these dequeuing __cds_wfq_for_each*() to __cds_wfq_dequeue_for_each*
> >>
> >> I notice, in the iterators you added, the presence of
> >> "cds_wfq_for_each_blocking_nobreak", and
> >> "cds_wfq_for_each_blocking_nobreak_internal", which document that this
> >> special flavor is needed for loops that do not have a "break" statement.
> >> That seems to be very much error-prone and counter-intuitive for users,
> >> and I would like to avoid that.
> > 
> > __cds_wfq_for_each_blocking_safe(remove-all) is also "no-break"(*), is it error-prone and ...?
> > 
> > So this is not a good reason to reject cds_wfq_for_each_blocking_nobreak(), if the user
> > don't know how to use it, he should use cds_wfq_for_each_blocking() (the version in my
> > patch which is dequeue()-based and we can break from the loop body)
> > 
> > __cds_wfq_for_each_blocking_safe() and cds_wfq_for_each_blocking_nobreak() are exactly the
> > same semantic in "remove-all" and "no-break". but cds_wfq_for_each_blocking_nobreak()
> > does NOT CORRUPT the queue.
> > 
> > So cds_wfq_for_each_blocking_nobreak() is yet another __cds_wfq_for_each_blocking_safe()
> > and it don't corrupt the queue, it is really safer than __cds_wfq_for_each_blocking_safe().
> > 
> > """"footnote: (*)
> > __cds_wfq_for_each_blocking_safe() should be used for "remove-none" or "remove-all"
> > We should use __cds_wfq_for_each_blocking_undequeue() instead of __cds_wfq_for_each_blocking_safe(remove-none)
> > """
> > 
> >>
> >> The "internal" flavor, along with "sync_next" are then used in the
> >> call_rcu code, since they are needed to get the best performance
> >> possible. I don't like to use special, internal APIs for call_rcu: the
> >> original motivation for refactoring the wfqueue code was testability,
> >> and I would really like to make sure that the APIs we use internally are
> >> also exposed to the outside world, mainly for testability, and also
> >> because if we need to directly access internal interfaces to have good
> >> performance, it means we did a poor job at exporting APIs that allow to
> >> do the same kind of highly-efficient use of the queue. Exposing an API
> >> with the "internal" keyword in it clearly discourages users from using
> >> it.
> > 
> > Related to "internal" see the bottom.
> > 
> >>
> >>
> >>>
> >>> 6) Remove __cds_wfq_for_each_blocking_safe
> >>>    Reason: its semantic is not clear, hard to define a well-defined semantic to it.
> >>> 	when we use it, we have to delete none or delete all nodes, even when we delete all nodes,
> >>> 	struct cds_wfq_queue still becomes stale while looping or after loop.
> >>
> >> The typical use-case I envision is:
> >>
> >> - enqueue many nodes to queue A
> >>
> >> - then, a dequeuer thread splice the content of queue A into its temporary
> >>   queue T (which head is local on its stack).
> >>
> >> - now, the thread is free to iterate on queue T, as many times as it
> >>   likes, and it does not need to change the structure of the queue while
> >>   iterating on it (read-only operation, without side-effect). The last
> >>   time it iterates on queue T, it needs to use the _safe iteration and
> >>   free the nodes.
> >>
> >> - after the nodes have been deleted, the queue T can be simply discarded
> >>   (if on stack, function return will do so; if dynamically allocated,
> >>   can be simply reinitialized to an empty queue, or freed).
> > 
> > My for_each_*() can do exactly the same thing in this use-case since we still
> > have splice() and cds_wfq_for_each_blocking_nobreak()(safer **_safe()). Doesn't it?
> > 
> > The memory represented a struct queue is big.(two cache line), something we need to
> > avoid to use it in the stack.(shorten the stack size or avoid to cost 2 or 3 additional cache line).
> > 
> > -----------a use case
> > All these local field are hot in the stack(and for some reason, it is not in the registers)
> > 	int count;
> > 	struct cds_wfq_queue tmp;
> > 	struct cds_wfq_node *node, *next;
> > 
> > It will use 4 cache line. Should we always recommend the users use splice()+tmp?
> > 
> >>
> >> As you certainly noticed, we can iterate both on a queue being
> >> concurrently enqueued to, and on a queue that has been spliced into.
> >> Being able to use iterators and dequeue on any queue (initial enqueue,
> >> or queue spliced to) is a feature: we can therefore postpone the
> >> "sync_next" synchronization to the moment where loop iteration is really
> >> needed (lazy synchronization), which keeps optimal locality of reference
> >> of synchronization vs node data access.
> >>
> >>>
> >>> 7) Rename old __cds_wfq_for_each_blocking() to __cds_wfq_for_each_blocking_undequeue()
> >>>    Reason: the default semantic of the other for_each_* is dequeuing.
> >>
> >> I'm not convinced that "__cds_wfq_for_each_blocking_nobreak",
> >> "__cds_wfq_for_each_blocking_nobreak_internal", and sync_next APIs are
> >> improvements over the API I propose. For call_rcu, this turns
> >>
> >> cds_wfq_enqueue()
> >> cds_wfq_splice_blocking()
> >> __cds_wfq_for_each_blocking_safe() for iteration
> >>
> >> into:
> >>
> >> cds_wfq_enqueue()
> >> __cds_wfq_dequeue_all_blocking()
> >> __cds_wfq_for_each_blocking_nobreak_internal() for iteration
> >>
> >> Maybe we could do some documentation improvement to
> >> "__cds_wfq_for_each_blocking(_safe)", __cds_wfq_first_blocking(),
> >> __cds_wfq_next_blocking() API members I proposed. Maybe I did not
> >> document them well enough ?
> >>
> > 
> > It does be not enough for __cds_wfq_for_each_blocking_safe().
> > 
> > I *STRONGLY OPPOSE* __cds_wfq_for_each_blocking_safe()(although it is suggested by me).
> > 
> > If you oppose the dequeue_all(), I agreed with this list:
> > 	Remove old __cds_wfq_for_each_blocking_safe()
> > 	Use manual splice()+get_first()+get_next() for call_rcu_thread().
> > 	Remove my proposed cds_wfq_for_each_blocking_nobreak()
> > 	Remove my proposed sync_next(), dequeue_all().
> > 	Keep dequeue-based for_each() (alternative: introduce it in future)
> > 
> > If you also agreed this list, could you please partially merge my patch to your patch
> > and send it for review to reduce the review cycle. (don't forget the other minimal fixes in my patch)
> > 
> > ==========
> > About internals:
> > 
> > I want to expose the for_each_*, I don't want to expose these helpers:
> > 	cds_wfq_node_sync_next()
> > 	cds_wfq_dequeue_all_blocking()
> > 	__cds_wfq_dequeue_all_blocking()
> > 	__cds_wfq_for_each_blocking_nobreak_internal()
> > (and I want to disallow the users use these helpers directly).
> > 
> > but the for_each_* use these helpers, so I have to declare it in the urcu/wfqueue.h,
> > and they become a part of ABI.
> > 
> > So these helpers become internal things, how to handle internal things
> > in a exposed *.h?
> > 
> > I found "__cds_list_del()" and "__tls_access_ ## name ()" are also
> > internals, and they are exposed. Are they exposed correctly?
> > 
> > In my view, exposed internals is OK, what we can do is disallowing
> > the users use it directly and ensuring the compatibility.
> > 
> > And we don't need to test exposed internals directly via testcases, because they are
> > internals, just like we don't need to test so much un-exposed internals.
> > When we test the exposed API, the internals will be also tested.
> > 
> > The call_rcu_thread() use the internal directly and can't be tested as you mentioned.
> > It is not totally true. call_rcu_thread() need to inject a "synchronize_rcu()"
> > to __cds_wfq_for_each_blocking_nobreak(), so I have to use
> > __cds_wfq_for_each_blocking_nobreak_internal().
> > Tests for __cds_wfq_for_each_blocking_nobreak() are enough for call_rcu_thread().
> > 
> > In one word, I don't agreed full of your disgust to the exposed internals,
> > but I agree to remove the ones introduced in my patch.
> > 
> > Thanks,
> > Lai
> > 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
