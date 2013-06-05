From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH urcu] Implement rcu_barrier()
Date: Wed, 5 Jun 2013 09:32:10 -0400
Message-ID: <20130605133210.GA1428__26807.0623897531$1370439281$gmane$org@Krystal>
References: <20130531153517.GA12809@Krystal>
	<20130605085928.GA3707@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UkDox-0004Ic-Ee
	for lttng-dev@lists.lttng.org; Wed, 05 Jun 2013 09:32:11 -0400
Content-Disposition: inline
In-Reply-To: <20130605085928.GA3707@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu, Stephen Hemminger <shemminger@vyatta.com>
List-Id: lttng-dev@lists.lttng.org

* Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> On Fri, May 31, 2013 at 11:35:17AM -0400, Mathieu Desnoyers wrote:
[...]
> > +
> > +	if (work_count != count)
> > +		uatomic_sub(&completion.barrier_count, count - work_count);
> 
> If we have a subset, we could do the rcu_barrier() one piece at a time.
> Another approach would be to pre-allocate the call_rcu_completion_work
> structure within the call_rcu_data structure.  I strongly recommend the
> latter -- though this will of course result in serializing concurrent
> rcu_barrier() invocations.

The issue I see with these approaches is that they require holding the
call_rcu_mutex while waiting for completion. If a call_rcu thread ever
needs to take the call_rcu_mutex (possibly caused by use of call_rcu in
a call_rcu handler), this call_rcu thread could deadlock against the
barrier.

Doing rcu_barrier() piecewise requires holding the call_rcu_mutex
against traversal of call_rcu_data_list, and preallocation of
call_rcu_completion_work within call_rcu_data requires the
call_rcu_mutex to protect against call_rcu_data teardown.

By the way, we already have, in call_rcu_data_init():

        crdp = malloc(sizeof(*crdp));
        if (crdp == NULL)
                urcu_die(errno);

So one possibility would be to make rcu_barrier() kill the process if
out of memory (although I'd hate to have to do this).

Any suggestions ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
