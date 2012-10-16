From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: urcu stack and queues updates and documentation
Date: Tue, 16 Oct 2012 14:37:27 -0700
Message-ID: <20121016213727.GL2385__6835.02214164964$1350423495$gmane$org@linux.vnet.ibm.com>
References: <20121014175332.GA2947@Krystal>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1TOEpY-00081M-1s
	for lttng-dev@lists.lttng.org; Tue, 16 Oct 2012 17:37:40 -0400
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 16 Oct 2012 15:37:33 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 7ACB61FF0044
	for <lttng-dev@lists.lttng.org>; Tue, 16 Oct 2012 15:37:23 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	q9GLbTsE233324
	for <lttng-dev@lists.lttng.org>; Tue, 16 Oct 2012 15:37:29 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id q9GLbS4Y012250
	for <lttng-dev@lists.lttng.org>; Tue, 16 Oct 2012 15:37:29 -0600
Content-Disposition: inline
In-Reply-To: <20121014175332.GA2947@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Sun, Oct 14, 2012 at 01:53:32PM -0400, Mathieu Desnoyers wrote:
> Hi Paul!
> 
> I know you are currently looking at documentation of urcu data
> structures. I did quite a bit of work in that area these past days. Here
> is my plan:

Actually, I diverted to the atomic operations, given that the stack/queue
API seems to be in flux.  ;-)

> 1) I would like to deprecate, at some point, rculfqueue, wfqueue, and
>    rculfstack.
> 
> 2) For wfqueue, we replace it by wfcqueue, currently in the urcu master
>    branch.
> 
> 3) For rculfstack, we replace it by lfstack available here (volatile
>    branch):
> 
> git://git.dorsal.polymtl.ca/~compudj/userspace-rcu
> branch: urcu/lfstack

I probably have to document them to have any chance of having an opinion,
other than my usual advice to avoid disrupting users of the old interfaces.

> 4) I did documentation improvements (and implemented pop_all as well as
>    empty, and iterators) for wfstack here (volatile branch too):
> 
> git://git.dorsal.polymtl.ca/~compudj/userspace-rcu
> branch: urcu/wfstack

I will be very happy to take advantage of this.  ;-)

> 5) The last one to look into would be rculfqueue. I'd really like to
>    create a lfcqueue derived from wfcqueue if possible. It's the next
>    item on my todo list this weekend.

The piece I am missing is ABA avoidance.  Or is this the approach
that assumes a single dequeuer?

							Thanx, Paul

> Thoughts ?
> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
> 
