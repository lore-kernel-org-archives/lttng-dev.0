From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: userspace rcu flavor improvements
Date: Mon, 19 Nov 2012 08:23:07 -0800
Message-ID: <20121119162307.GE2829__42876.9860569902$1353342296$gmane$org@linux.vnet.ibm.com>
References: <1353169007-31389-1-git-send-email-mathieu.desnoyers@efficios.com>
	<50A9E532.6000706@cn.fujitsu.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1TaU8h-0005ck-BL
	for lttng-dev@lists.lttng.org; Mon, 19 Nov 2012 11:24:03 -0500
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 19 Nov 2012 11:23:55 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 324216E8075
	for <lttng-dev@lists.lttng.org>; Mon, 19 Nov 2012 11:23:47 -0500 (EST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	qAJGNkZX192040
	for <lttng-dev@lists.lttng.org>; Mon, 19 Nov 2012 11:23:47 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id qAJGNc5o029231
	for <lttng-dev@lists.lttng.org>; Mon, 19 Nov 2012 09:23:39 -0700
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
Cc: Alan Stern <stern@rowland.harvard.edu>, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On Mon, Nov 19, 2012 at 03:52:18PM +0800, Lai Jiangshan wrote:
> On 11/18/2012 12:16 AM, Mathieu Desnoyers wrote:
> > Here are a couple of improvements for all userspace RCU flavors. Many
> > thanks to Alan Stern for his suggestions.
> 
> It makes urcu like SRCU. (sync_rcu = check zero + flip + check zero)
> If I have time, I may port more SRCU code to urcu.

I am sure that this is obvious to everyone, but I cannot help restating
it.  There is one important difference between user code and kernel code,
though.  In the kernel, we track by CPU, so one of SRCU's big jobs is
to track multiple tasks using the same CPU.  This opens the possibility
of preemption, which is one of the things that complicates SRCU's design.

In contrast, user-mode RCU tracks tasks without multiplexing.  This
allows simplifications that are similar to those that could be achieved
in the kernel if we were willing to disable preemption across the entire
SRCU read-side critical section.

So although I am all for user-mode RCU taking advantage of any technology
we have at hand, we do need to be careful to avoid needless complexity.

> > Patch 8/8 is only done for qsbr so far, and proposed as RFC. I'd like to
> > try and benchmark other approaches to concurrent grace periods too.

The concurrent grace periods are the big win, in my opinion.  ;-)

							Thanx, Paul

> > Feedback is welcome,
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > 
> 
