From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH] wfqueue: expand API,
	simplify implementation, small performance boost
Date: Tue, 14 Aug 2012 19:34:02 -0400
Message-ID: <20120814233402.GA14033__31448.2230846354$1344987292$gmane$org@Krystal>
References: <20120812145000.GA32747@Krystal>
	<CACvQF52366ewREnRrDgi+xUBVQ6_ifWjoDv==nHik8FbCnMugA@mail.gmail.com>
	<20120813201219.GA27637@Krystal>
	<CACvQF51tWXaTdm9jCC=0S2XA+BdzJmR0W2sFVZAuVVZiWX8jAA@mail.gmail.com>
	<20120814222724.GA9751@Krystal> <20120814230634.GA11255@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T1Qcd-0001Vj-QN
	for lttng-dev@lists.lttng.org; Tue, 14 Aug 2012 19:34:03 -0400
Content-Disposition: inline
In-Reply-To: <20120814230634.GA11255@Krystal>
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

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
[...]
> One more thing: I think we need to add cmm_smp_read_barrier_depends()
> before returning the node pointers in dequeue, first, and next
> operations. This memory barrier would match the implicit barrier in the
> enqueue ordering write to the prior tail's next pointer with writes to
> the node content that would have been performed beforehand by the
> caller.

Please note that the only reason why I propose to use
"cmm_smp_read_barrier_depends()" before returning nodes in dequeue,
first, and next functions rather than a full cmm_smp_mb() is because I
fail to see a case where an architecture would reorder a dependent store
before the load of the pointer.

I very well imagine a use-case where we have node N within the structure
X like the scenario below, where we write to X immediately after dequeue:

CPU 0                                      CPU 1
store X content
  (implicit full memory barrier
   implied before uatomic_xchg)
enqueue X->N
                                           dequeue X->N
                                           (which barrier here ?)
                                           write to X immediately.

If we assume that no reordering of a store that depends on loading a
pointer can arrive, then I think we should be good with only a
read_barrier_depends() on CPU 1. Otherwise, we might want to put a full
barrier there to ensure that we don't race with CPU 0 storing content to
X.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
