From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: userspace rcu flavor improvements
Date: Mon, 19 Nov 2012 10:18:55 -0500
Message-ID: <20121119151855.GC16248__19441.0477452495$1353338452$gmane$org@Krystal>
References: <1353169007-31389-1-git-send-email-mathieu.desnoyers@efficios.com>
	<50A9E532.6000706@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TaT7g-00056G-JK
	for lttng-dev@lists.lttng.org; Mon, 19 Nov 2012 10:18:56 -0500
Content-Disposition: inline
In-Reply-To: <50A9E532.6000706@cn.fujitsu.com>
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
> > Here are a couple of improvements for all userspace RCU flavors. Many
> > thanks to Alan Stern for his suggestions.
> 
> 
> It makes urcu like SRCU. (sync_rcu = check zero + flip + check zero)

Good to know :)

> If I have time, I may port more SRCU code to urcu.

That will certainly be interesting.

Thanks!

Mathieu

> 
> > 
> > Patch 8/8 is only done for qsbr so far, and proposed as RFC. I'd like to
> > try and benchmark other approaches to concurrent grace periods too.
> > 
> > Feedback is welcome,
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > 
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
