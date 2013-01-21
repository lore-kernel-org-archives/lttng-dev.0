From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Coding blog: lockless queues
Date: Tue, 22 Jan 2013 09:29:49 +1030
Message-ID: <87ip6quopm.fsf__13884.1866086752$1358818242$gmane$org@rustcorp.com.au>
References: <20130110165942.GA5133@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ozlabs.org ([203.10.76.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <rusty@ozlabs.org>) id 1TxSgT-000892-Dn
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 20:29:53 -0500
In-Reply-To: <20130110165942.GA5133@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rp@svcs.cs.pdx.edu, lttng-dev@lists.lttng.org, Alan Stern <stern@rowland.harvard.edu>, Stephen Hemminger <shemminger@vyatta.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> Hi Rusty!
>
> I've stumbled on your blog post: http://rusty.ozlabs.org/?p=317
>
> and I find that you looked at the RCU lock-free queue implementation in
> the Userspace RCU project, but not at the wait-free concurrent queue
> implementation we have (wait-free enqueue, blocking dequeue), which does
> not require RCU at all and might be a much better fit for what you are
> trying to achieve.

Clearly, I stopped reading too early!  It's a very nice
implementation...

If I revisit this, I'll do a code review and post it on my blog.

Thanks!
Rusty.
