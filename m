From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [URCU PATCH 1/3] wfcqueue: implement
	concurrency-efficient	queue
Date: Mon, 8 Oct 2012 14:10:39 -0400
Message-ID: <20121008181039.GA4558__31700.0582501807$1349719879$gmane$org@Krystal>
References: <20121002141307.GA4057@Krystal> <20121002141444.GB4057@Krystal>
	<5072F57E.4020308@redhat.com> <20121008161544.GB30083@Krystal>
	<5073004B.2050400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TLHmr-0006Va-4r
	for lttng-dev@lists.lttng.org; Mon, 08 Oct 2012 14:10:41 -0400
Content-Disposition: inline
In-Reply-To: <5073004B.2050400@redhat.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> Il 08/10/2012 18:15, Mathieu Desnoyers ha scritto:
> > Hi Paolo,
> > 
> > We actually already have those, they are just not described in this
> > comment. I will fix this right away. By the way, you will notice the
> > wording:
> > 
> > + * Queue read operations "first" and "next", which are used by
> > + * "for_each" iterations, need to be protected against concurrent
> > + * "dequeue" and "splice" (for source queue) by the caller.
> > 
> > Being the only one iterating on a queue with local head/tail after a
> > splice operation is one way to provide mutual exclusion. Holding a lock
> > is not the only way to achieve mutual exclusion.
> 
> Uh, I was confused by the _blocking suffix.  But when used together with
> splice you know it is not blocking---only the splice will block.

Well, in this case, the "blocking" can be understood as busy-waiting
(and actual blocking that invokes the OS happens if busy-waiting for long
periods only).

for_each iteration can indeed busy-wait: ___cds_wfcq_first_blocking()
and ___cds_wfcq_next_blocking() can both call
___cds_wfcq_node_sync_next(), which busy-waits if it encounters a NULL
next pointer that is not located in the tail node.

Seen through the use-case of splice to local queue + for_each, here is
what happens:

- splice moves the content of the queue into a "local" queue. However,
  it does _not_ issue a ___cds_wfcq_node_sync_next() on each node: no
  traversal is performed.

- then, within the for_each iteration, we perform the
  ___cds_wfcq_node_sync_next() synchronization as we iterate on the
  local queue.

This ensures that the synchronization performed for each node is only
performed lazily, only when those nodes are actually traversed. This
approach has the advantage of increasing the locality of reference, and
also to diminish the odds that this synchronization actually needs to be
executed uselessly by postponing it to the point where it is actually
needed.

Does it make more sense ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
