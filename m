From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 5/8] urcu-mb/signal/membarrier: move
	quiescent threads	to separate list
Date: Mon, 19 Nov 2012 10:16:53 -0500
Message-ID: <20121119151653.GA16248__46261.5047269084$1353338254$gmane$org@Krystal>
References: <1353169007-31389-1-git-send-email-mathieu.desnoyers@efficios.com>
	<1353169007-31389-6-git-send-email-mathieu.desnoyers@efficios.com>
	<50A9DCD2.7000009@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TaT5i-000535-RG
	for lttng-dev@lists.lttng.org; Mon, 19 Nov 2012 10:16:54 -0500
Content-Disposition: inline
In-Reply-To: <50A9DCD2.7000009@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu, Alan Stern <stern@rowland.harvard.edu>
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> On 11/18/2012 12:16 AM, Mathieu Desnoyers wrote:
> > Accelerate 2-phase grace period by not having to iterate twice on
> > threads not nested within a RCU read-side lock.
> 
> You almost gain nothing.
> The first wait_for_readers() waits none very likely.

I agree with you that the speedup will probably be small, but as we
start having more and more readers, most of which are outside of RCU
read-side critical sections, iterating only once, rather than twice, on
the list of readers seems to be a saving worth doing.

Actually, when I implemented grace periods based on list move/splicing,
it was my original intent to only touch threads as many times as we
needed to observe them become quiescent. The "move quiescent threads to
separate list" patches are completing that modification.

> 
> > @@ -341,7 +361,12 @@ void synchronize_rcu(void)
> >  	/*
> >  	 * Wait for readers to observe new parity or be quiescent.
> >  	 */
> > -	wait_for_readers();
> > +	wait_for_readers(&registry, NULL, &qsreaders);
> 
> wait_for_readers(&cur_snap_readers, NULL, &qsreaders);

Good catch, fixed in my dev branch.

Thanks!

Mathieu


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
