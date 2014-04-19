From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH liburcu] Fix pthread_atfork() behaviour
Date: Sat, 19 Apr 2014 19:37:04 +0000 (UTC)
Message-ID: <673327125.4326.1397936224002.JavaMail.zimbra__40010.4807493792$1397936302$gmane$org@efficios.com>
References: <534BE34D.6040304@cohodata.com>
 <1310479684.3385.1397737200900.JavaMail.zimbra@efficios.com>
 <1108103948.3414.1397738599127.JavaMail.zimbra@efficios.com>
 <268671333.3430.1397740359887.JavaMail.zimbra@efficios.com>
 <534FFE1F.7010607@cohodata.com>
 <1326569833.4069.1397837395986.JavaMail.zimbra@efficios.com>
 <5351641A.3020703@cohodata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Wbb4Y-0002HM-F9
 for lttng-dev@lists.lttng.org; Sat, 19 Apr 2014 15:37:16 -0400
In-Reply-To: <5351641A.3020703@cohodata.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Keir Fraser <keir@cohodata.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Keir Fraser" <keir@cohodata.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Sent: Friday, April 18, 2014 1:42:50 PM
> Subject: Re: [lttng-dev] [PATCH liburcu] Fix pthread_atfork() behaviour
> 
[...]
> 
> Worse, while reading the rcu_barrier() code I found a more subtle bug.
> rcu_barrier() can return as soon as completion.barrier_count==0, which
> frees the completion struct along with the rest of its stack frame. But
> its call_rcu callbacks may yet try to read and write completion.futex
> via the wake_up function.

Good catch! I think I've fixed this kind of problematic pattern elsewhere
already, but clearly rcu_barrier() slipped through.

> 
> The completion struct should be calloc()ed, reference-counted, and freed
> by the thread that decs the count to 0, imo. I will be cooking up a
> patch to do just that.

Yes, this should be a clean way to fix it.

> 
> There are other places in liburcu which protect a futex variable from
> premature freeing by the waiter polling a teardown flag, but I think
> refcounting is nicer :)

Makes sense to me,

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
