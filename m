From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Userspace RCU: workqueue with batching, cheap wakeup,
 and work stealing
Date: Fri, 24 Oct 2014 13:22:17 +0000 (UTC)
Message-ID: <1934266999.1214.1414156937264.JavaMail.zimbra__32041.9974196286$1414156997$gmane$org@efficios.com>
References: <836028170.11148.1413630118955.JavaMail.zimbra@efficios.com>
 <1521253780.11371.1413666790992.JavaMail.zimbra@efficios.com>
 <54478D8E.1080608@cn.fujitsu.com>
 <1569300159.298.1413976834389.JavaMail.zimbra@efficios.com>
 <54488392.2030008@cn.fujitsu.com>
 <1961985429.339.1414069564156.JavaMail.zimbra@efficios.com>
 <5449AF57.2040507@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Xhep2-0000nZ-9v
 for lttng-dev@lists.lttng.org; Fri, 24 Oct 2014 09:22:32 -0400
In-Reply-To: <5449AF57.2040507@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, lttng-dev <lttng-dev@lists.lttng.org>, Ben Maurer <bmaurer@fb.com>, Yannick Brosseau <scientist@fb.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Lai Jiangshan" <laijs@cn.fujitsu.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "Ben Maurer" <bmaurer@fb.com>, "lttng-dev" <lttng-dev@lists.lttng.org>, "Yannick Brosseau" <scientist@fb.com>,
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Stephen Hemminger" <stephen@networkplumber.org>
> Sent: Thursday, October 23, 2014 9:45:59 PM
> Subject: Re: Userspace RCU: workqueue with batching, cheap wakeup, and work stealing
> 
> On 10/23/2014 09:06 PM, Mathieu Desnoyers wrote:
> > ----- Original Message -----
> >> From: "Lai Jiangshan" <laijs@cn.fujitsu.com>
> >> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> >> Cc: "Ben Maurer" <bmaurer@fb.com>, "lttng-dev"
> >> <lttng-dev@lists.lttng.org>, "Yannick Brosseau" <scientist@fb.com>,
> >> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Stephen Hemminger"
> >> <stephen@networkplumber.org>
> >> Sent: Thursday, October 23, 2014 12:26:58 AM
> >> Subject: Re: Userspace RCU: workqueue with batching, cheap wakeup, and
> >> work stealing
> > 
[...]
> >>
> >> It is not a good idea for a worker to call synchronize_rcu() (in
> >> urcu_accept_work()).
> >> A new work may be coming soon.
> > 
> > The reason why the worker calls synchronize_rcu() there is to protect
> > the waitqueue lfstack "pop" operation from ABA. It matches the RCU
> > read-side critical sections encompassing urcu_dequeue_wake_single().
> > 
> > Another way to achieve this would be to grab a mutex across calls to
> > urcu_dequeue_wake_single(), but unfortunately this call needs to be
> > done by the dispatcher thread, and I'm trying to keep a low-latency
> > bias in favor of the dispatcher here. In this case, it is done at the
> > expense of overhead in the worker when the worker is about to busy-wait
> > and eventually block, so I thought the tradeoff was not so bad.
> 
> "single worker pattern" does be a frequent use-case.
> you can image the lag and jitter in this case.

I'd be happy to find a way to reduce unnecessary jitter, indeed.
However, we need to keep in mind that this is issued only when
the worker thread has no more work to do. And if there are few
registered RCU threads, synchronize_rcu() should be pretty quick,
especially now that multiple grace periods can run concurrently.

> 
> 
> How about a mutex&rcu protected idle-workers?
> 
> idle-worker is wokenup via rcu-protected scheme.
> and dequeued&requeued (in urcu_accept_work() or urcu_worker_unregister()) via
> mutex-protected scheme.

I'm not sure I understand your proposal. Can you give more
detail about the RCU protected scheme you refer to here,
along with how it is intended to interact with mutex ?

Note that if we use RCU read-side around lfstack pop, it
needs to be matched by a grace period between all other
"pop"/"pop all" and re-push to deal with ABA.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
