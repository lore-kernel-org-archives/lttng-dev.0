From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC] Userspace RCU library internal error handling
Date: Thu, 21 Jun 2012 09:53:34 -0700
Message-ID: <20120621165334.GE2397__27416.8405369439$1340300766$gmane$org@linux.vnet.ibm.com>
References: <20120621164113.GA21197@Krystal>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1ShlRq-0000MR-6p
	for lttng-dev@lists.lttng.org; Thu, 21 Jun 2012 13:45:38 -0400
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 21 Jun 2012 11:45:29 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7EAB919D89F1
	for <lttng-dev@lists.lttng.org>; Thu, 21 Jun 2012 16:54:30 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	q5LGroCc170342
	for <lttng-dev@lists.lttng.org>; Thu, 21 Jun 2012 10:54:06 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id q5LGrZ9v015587
	for <lttng-dev@lists.lttng.org>; Thu, 21 Jun 2012 10:53:35 -0600
Content-Disposition: inline
In-Reply-To: <20120621164113.GA21197@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

On Thu, Jun 21, 2012 at 12:41:13PM -0400, Mathieu Desnoyers wrote:
> Hi,
> 
> Currently, liburcu calls "exit(-1)" upon internal consistency error.
> This is not pretty, and usually frowned upon in libraries.
> 
> One example of failure path where we use this is if pthread_mutex_lock()
> would happen to fail within synchronize_rcu(). Clearly, this should
> _never_ happen: it would typically be triggered only by memory
> corruption (or other terrible things like that). That being said, we
> clearly don't want to make "synchronize_rcu()" return errors like that
> to the application, because it would complexify the application error
> handling needlessly.
> 
> So instead of calling exit(-1), one possibility would be to do something
> like this:
> 
> #include <signal.h>
> #include <pthread.h>
> #include <stdio.h>
> 
> #define urcu_die(fmt, ...)                      \
>         do {    \
>                 fprintf(stderr, fmt, ##__VA_ARGS__);    \
>                 (void) pthread_kill(pthread_self(), SIGBUS);    \
>         } while (0)
> 
> and call urcu_die(); in those "unrecoverable error" cases, instead of
> calling exit(-1). Therefore, if an application chooses to trap those
> signals, it can, which is otherwise not possible with a direct call to
> exit().

This approach makes a lot of sense to me.

							Thanx, Paul
