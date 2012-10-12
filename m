From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [RFC] re-document rculfstack and even rename it
Date: Fri, 12 Oct 2012 10:25:40 +0800
Message-ID: <50777FA4.9030902__31910.357802599$1350008638$gmane$org@cn.fujitsu.com>
References: <50752928.3050006@cn.fujitsu.com> <20121011182255.GA19783@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TMUuE-0005VZ-7G
	for lttng-dev@lists.lttng.org; Thu, 11 Oct 2012 22:23:20 -0400
In-Reply-To: <20121011182255.GA19783@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

On 10/12/2012 02:22 AM, Mathieu Desnoyers wrote:
> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
>> rculfstack is not really require RCU-only.
>>
>> 1) cds_lfs_push_rcu() don't need any lock, don't need RCU nor other locks.
> 
> Good point ! I even documented this peculiarness in the
> comment at the top of _cds_lfs_push_rcu().
> 
>> 2) cds_lfs_pop_rcu() don't only one of the following synchronization(not only RCU):
>> 	A) use rcu_read_lock() to protect cds_lfs_pop_rcu() and use synchronize_rcu()
>>            or call_rcu() to free the popped node. (current comments said we need this
>>            synchronization, and thus we named this struct with rcu prefix. But actually,
>> 	   the followings are OK, and are more popular/friendly)
>> 	B) use mutexs/locks to protect cds_lfs_pop_rcu(), we can free to free/modify the
>> 	   popped node any time, we don't need any synchronization when free them.
>> 	C) only ONE thread can call cds_lfs_pop_rcu(). (multi-providers-single customer)
>> 	D) others, like read-write locks.
>>
>> I consider B) and C) are more popular. In linux kernel,
>> kernel/task_work.c uses a hybird ways of B) and C).
>>
>> I suggest to rename it, Or document B) and C) at least.
> 
> Yes, agreed! Do you suggest we introduce a "lfstack", and slowly
> deprecate rculfstack ?
> 
> We could then document the various ways to protect "pop", and also
> implement a "splice" operation while we are there.
> 

Acked.

Thanks,
Lai
