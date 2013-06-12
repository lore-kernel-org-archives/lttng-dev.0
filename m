From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH urcu] Implement rcu_barrier()
Date: Wed, 12 Jun 2013 08:48:39 -0700
Message-ID: <20130612154839.GX5146__12302.2810476416$1371052265$gmane$org@linux.vnet.ibm.com>
References: <20130531153517.GA12809@Krystal>
	<20130605085928.GA3707@linux.vnet.ibm.com>
	<20130605133210.GA1428@Krystal>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1UmnIO-0001Mu-LP
	for lttng-dev@lists.lttng.org; Wed, 12 Jun 2013 11:49:12 -0400
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 12 Jun 2013 09:48:56 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C93DF3E4008C
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 09:48:31 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r5CFmho4137350
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 09:48:44 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id r5CFp4CD027999
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 09:51:05 -0600
Content-Disposition: inline
In-Reply-To: <20130605133210.GA1428@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu, Stephen Hemminger <shemminger@vyatta.com>
List-Id: lttng-dev@lists.lttng.org

On Wed, Jun 05, 2013 at 09:32:10AM -0400, Mathieu Desnoyers wrote:
> * Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> > On Fri, May 31, 2013 at 11:35:17AM -0400, Mathieu Desnoyers wrote:
> [...]
> > > +
> > > +	if (work_count != count)
> > > +		uatomic_sub(&completion.barrier_count, count - work_count);
> > 
> > If we have a subset, we could do the rcu_barrier() one piece at a time.
> > Another approach would be to pre-allocate the call_rcu_completion_work
> > structure within the call_rcu_data structure.  I strongly recommend the
> > latter -- though this will of course result in serializing concurrent
> > rcu_barrier() invocations.
> 
> The issue I see with these approaches is that they require holding the
> call_rcu_mutex while waiting for completion. If a call_rcu thread ever
> needs to take the call_rcu_mutex (possibly caused by use of call_rcu in
> a call_rcu handler), this call_rcu thread could deadlock against the
> barrier.
> 
> Doing rcu_barrier() piecewise requires holding the call_rcu_mutex
> against traversal of call_rcu_data_list, and preallocation of
> call_rcu_completion_work within call_rcu_data requires the
> call_rcu_mutex to protect against call_rcu_data teardown.
> 
> By the way, we already have, in call_rcu_data_init():
> 
>         crdp = malloc(sizeof(*crdp));
>         if (crdp == NULL)
>                 urcu_die(errno);
> 
> So one possibility would be to make rcu_barrier() kill the process if
> out of memory (although I'd hate to have to do this).

That would be ugly, agreed, but it might be the best approach.
Presumably running out of memory is rare.

							Thanx, Paul

> Any suggestions ?
> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
