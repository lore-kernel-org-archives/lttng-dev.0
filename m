From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: Userspace RCU: workqueue with batching, cheap wakeup,
 and work stealing
Date: Fri, 24 Oct 2014 09:45:59 +0800
Message-ID: <5449AF57.2040507__10517.6386693076$1414115030$gmane$org@cn.fujitsu.com>
References: <836028170.11148.1413630118955.JavaMail.zimbra@efficios.com>
 <1521253780.11371.1413666790992.JavaMail.zimbra@efficios.com>
 <54478D8E.1080608@cn.fujitsu.com>
 <1569300159.298.1413976834389.JavaMail.zimbra@efficios.com>
 <54488392.2030008@cn.fujitsu.com>
 <1961985429.339.1414069564156.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <laijs@cn.fujitsu.com>) id 1XhTu9-0005Wd-8O
 for lttng-dev@lists.lttng.org; Thu, 23 Oct 2014 21:43:04 -0400
In-Reply-To: <1961985429.339.1414069564156.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, lttng-dev <lttng-dev@lists.lttng.org>, Ben Maurer <bmaurer@fb.com>, Yannick Brosseau <scientist@fb.com>
List-Id: lttng-dev@lists.lttng.org

On 10/23/2014 09:06 PM, Mathieu Desnoyers wrote:
> ----- Original Message -----
>> From: "Lai Jiangshan" <laijs@cn.fujitsu.com>
>> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
>> Cc: "Ben Maurer" <bmaurer@fb.com>, "lttng-dev" <lttng-dev@lists.lttng.org>, "Yannick Brosseau" <scientist@fb.com>,
>> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Stephen Hemminger" <stephen@networkplumber.org>
>> Sent: Thursday, October 23, 2014 12:26:58 AM
>> Subject: Re: Userspace RCU: workqueue with batching, cheap wakeup, and work stealing
>>
>> Hi, Mathieu
> 
> Hi Lai,
> 
>>
>> In the code, how this problem be solved?
>> "All the tasks may continue stealing works without any progress."
> 
> Good point. It is not. I see two possible solutions for this:
> 
> 1) We break the circular chain of siblings at the list head.
>    It has the downside that work could accumulate at the first
>    worker of the list, or
> 2) Whenever we grab work (either from the global queue or from
>    a sibling), we could dequeue one element and keep it to ourself,
>    out of reach of siblings. This would ensure progress, since
>    worker stealing work would always keep one work element to itself,
>    which would therefore ensure progress.
> 
> I personally prefer (2), since it has fewer downsides.
> 
>>
>> Why ___urcu_steal_work() needs cds_wfcq_dequeue_lock()?
> 
> This lock is to protect operations on the sibling workqueue.
> Here are the various actors touching it:
> 
> - The worker attempting to steal from the sibling (with splice-from),
> - The sibling itself, in urcu_dequeue_work(), with a dequeue
>   operation,
> 
> Looking at the wfcq synchronization table:
> 
>  * Synchronization table:
>  *
>  * External synchronization techniques described in the API below is
>  * required between pairs marked with "X". No external synchronization
>  * required between pairs marked with "-".
>  *
>  * Legend:
>  * [1] cds_wfcq_enqueue
>  * [2] __cds_wfcq_splice (destination queue)
>  * [3] __cds_wfcq_dequeue
>  * [4] __cds_wfcq_splice (source queue)
>  * [5] __cds_wfcq_first
>  * [6] __cds_wfcq_next
>  *
>  *     [1] [2] [3] [4] [5] [6]
>  * [1]  -   -   -   -   -   -
>  * [2]  -   -   -   -   -   -
>  * [3]  -   -   X   X   X   X
>  * [4]  -   -   X   -   X   X
>  * [5]  -   -   X   X   -   -
>  * [6]  -   -   X   X   -   -
> 
> We need a mutex between splice-from and dequeue since they
> are executed by different threads. I can replace this with
> a call to cds_wfcq_splice_blocking() instead, which takes the
> lock internally. That would be neater.
> 
>>
>> It is not a good idea for a worker to call synchronize_rcu() (in
>> urcu_accept_work()).
>> A new work may be coming soon.
> 
> The reason why the worker calls synchronize_rcu() there is to protect
> the waitqueue lfstack "pop" operation from ABA. It matches the RCU
> read-side critical sections encompassing urcu_dequeue_wake_single().
> 
> Another way to achieve this would be to grab a mutex across calls to
> urcu_dequeue_wake_single(), but unfortunately this call needs to be
> done by the dispatcher thread, and I'm trying to keep a low-latency
> bias in favor of the dispatcher here. In this case, it is done at the
> expense of overhead in the worker when the worker is about to busy-wait
> and eventually block, so I thought the tradeoff was not so bad.

"single worker pattern" does be a frequent use-case.
you can image the lag and jitter in this case.


How about a mutex&rcu protected idle-workers?

idle-worker is wokenup via rcu-protected scheme.
and dequeued&requeued (in urcu_accept_work() or urcu_worker_unregister()) via mutex-protected scheme.

> 
> Thoughts ?
> 
> Thanks for the feedback!
> 
> Mathieu
> 
>>
>> thanks,
>> Lai
>>
> 
