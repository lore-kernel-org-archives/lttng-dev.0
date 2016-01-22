From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH urcu 00/01]
	Introduce-rcu_barrier_finalize()
Date: Fri, 22 Jan 2016 09:49:30 -0800
Message-ID: <20160122174930.GJ3818__45084.1493592181$1453485196$gmane$org@linux.vnet.ibm.com>
References: <1453483323-7596-1-git-send-email-jeremie.galarneau@efficios.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <paulmck@linux.vnet.ibm.com>) id 1aMfq2-0002QG-Ab
 for lttng-dev@lists.lttng.org; Fri, 22 Jan 2016 12:49:37 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 22 Jan 2016 10:49:28 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 60D4E3E4003B
 for <lttng-dev@lists.lttng.org>; Fri, 22 Jan 2016 10:49:26 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u0MHnQNX27852846
 for <lttng-dev@lists.lttng.org>; Fri, 22 Jan 2016 10:49:26 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0MHnOm5015157
 for <lttng-dev@lists.lttng.org>; Fri, 22 Jan 2016 10:49:25 -0700
Content-Disposition: inline
In-Reply-To: <1453483323-7596-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Fri, Jan 22, 2016 at 12:22:02PM -0500, J=E9r=E9mie Galarneau wrote:
> Following a prior discussion on this mailing list [1], I am proposing
> the introduction of rcu_barrier_finalize() in liburcu.
> =

> *** Use Case ***
> =

> As pointed out in the e-mail thread, some applications are nesting
> liburcu data structures or, as part of their design, composing objects
> which use liburcu data structures (e.g. lttng-tools daemons).
> =

> When such objects or data structures are destroyed, it is likely that
> their 'call_rcu' callbacks will, in turn, enqueue new 'call_rcu' work
> items.
> =

> This leads to a "chaining" phenomenon where 'call_rcu' callbacks are
> added to the 'call_rcu' queue by callbacks being processed.
> =

> The implication of this chaining is that the rcu_barrier() mechanism
> cannot be relied on to empty the 'call_rcu' queue. More specifically,
> an application calling rcu_barrier() on exit may spuriously leak
> memory since any unprocessed reclamation callback euqueued after the
> barrier will result in a leak.
> =

> Of course, one could argue that it would be possible to refactor
> applications to separate object tear down from memory
> reclamation. However, the guarantee that an object is unreachable when
> its 'call_rcu' callback is invoked (during a grace period) becomes
> very useful to safely tear down its internal state (and release other
> resources) in cases where an explicit reference counting mechanism
> isn't being used.

Just a design/architecture-level observation at the moment...

The point is that some callbacks register other callbacks, which
themselves might register other callbacks.  You want to wait until
the full chain of callbacks instigated by any previous call_rcu()
has completed.

This maps onto the RCU API.  When registering a callback that might
itself register a callback, you need to do something sort of like
rcu_read_lock(), but if this is down the chain, this new rcu_read_lock()
must block anyone blocked by the rcu_read_lock() at the head of the
chain.  When such a callback completes, you need to do something sort
of like rcu_read_unlock().  Then you wait using something kind of like
synchronize_rcu(), followed by rcu_barrier() to handle callbacks being
preempted just after they do the final rcu_read_unlock().

If each callback spawns at most one callback (which is the only case
that I am aware of in real life), you just do the rcu_read_lock()-like
thing before posting the first callback in the chain.  You wait to do
the rcu_read_unlock()-like thing until the final callback executes.
If callbacks can spawn multiple callbacks, then some adjustments are
needed.  This might be a reference counter, or it might be an
SRCU-like design where the first srcu_read_lock() returns an index
that is passed to subsequent srcu_read_lock() and srcu_read_lock()
calls on that chain.

Why is this important?  Because it allows you to draw on design
techniques from multiple RCU implementations to avoid your starvation
case.  This approach can also substitute a wait-wakeup approach for
your polling loop.

Or am I missing your point?

							Thanx, Paul

> *** Implementation limitations ***
> =

> The proposed implementation of rcu_barrier_finalize() is
> straightforward, basically invoking rcu_barrier() until all queues are
> observed to be empty. The call_rcu_mutex is released between each
> iteration to ensure the application can fork() without deadlocking.
> This ensures that all queues are empty on return, which in my use
> case, is a crude way of ensuring all work enqueued by the work
> enqueued prior to the rcu_barrier() has been processed.
> =

> This design may cause rcu_barrier_finalize() to never return if the
> application can chain an unbounded amount of callbacks.
> =

> It could be improved by ensuring that all queues have been observed to
> be empty at least once (and skipping them during the next iterations),
> therefore guaranteeing that all chained work has been executed, but
> foregoing the guarantee that all queues are empty on return (makes no
> difference in my use case).
> =

> An alternative guarantee that could be offered would consist in
> ensuring that all callbacks _and_ whichever callbacks they may
> enqueue, are processed, but nothing more. I don't have a use-case for
> this, but it may come in handy to someone (please speak up!). However,
> since the implementation I have in mind does somewhat increase the
> overall complexity of the solution, I am not sure it is worth
> it. (Thoughts ?)
> =

> [1] https://lists.lttng.org/pipermail/lttng-dev/2015-December/025356.html
> =

> J=E9r=E9mie Galarneau (1):
>   Introduce rcu_barrier_finalize()
> =

>  doc/rcu-api.md       | 23 ++++++++++++++++++++---
>  urcu-call-rcu-impl.h | 36 ++++++++++++++++++++++++++++++++++++
>  urcu-call-rcu.h      |  1 +
>  3 files changed, 57 insertions(+), 3 deletions(-)
> =

> -- =

> 2.6.4
> =
