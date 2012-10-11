From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC] re-document rculfstack and even rename it
Date: Thu, 11 Oct 2012 14:22:55 -0400
Message-ID: <20121011182255.GA19783__42670.6359758557$1349979810$gmane$org@Krystal>
References: <50752928.3050006@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TMNPM-0001fV-KH
	for lttng-dev@lists.lttng.org; Thu, 11 Oct 2012 14:22:56 -0400
Content-Disposition: inline
In-Reply-To: <50752928.3050006@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> rculfstack is not really require RCU-only.
> 
> 1) cds_lfs_push_rcu() don't need any lock, don't need RCU nor other locks.

Good point ! I even documented this peculiarness in the
comment at the top of _cds_lfs_push_rcu().

> 2) cds_lfs_pop_rcu() don't only one of the following synchronization(not only RCU):
> 	A) use rcu_read_lock() to protect cds_lfs_pop_rcu() and use synchronize_rcu()
>            or call_rcu() to free the popped node. (current comments said we need this
>            synchronization, and thus we named this struct with rcu prefix. But actually,
> 	   the followings are OK, and are more popular/friendly)
> 	B) use mutexs/locks to protect cds_lfs_pop_rcu(), we can free to free/modify the
> 	   popped node any time, we don't need any synchronization when free them.
> 	C) only ONE thread can call cds_lfs_pop_rcu(). (multi-providers-single customer)
> 	D) others, like read-write locks.
> 
> I consider B) and C) are more popular. In linux kernel,
> kernel/task_work.c uses a hybird ways of B) and C).
> 
> I suggest to rename it, Or document B) and C) at least.

Yes, agreed! Do you suggest we introduce a "lfstack", and slowly
deprecate rculfstack ?

We could then document the various ways to protect "pop", and also
implement a "splice" operation while we are there.

Thoughts ?

Thanks,

Mathieu

> 
> Thanks,
> Lai
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
