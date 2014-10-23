From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: Userspace RCU: workqueue with batching, cheap wakeup,
 and work stealing
Date: Thu, 23 Oct 2014 17:28:24 +0800
Message-ID: <5448CA38.2010801__14997.6892550059$1414056374$gmane$org@cn.fujitsu.com>
References: <836028170.11148.1413630118955.JavaMail.zimbra@efficios.com>
 <1521253780.11371.1413666790992.JavaMail.zimbra@efficios.com>
 <54478D8E.1080608@cn.fujitsu.com>
 <1569300159.298.1413976834389.JavaMail.zimbra@efficios.com>
 <54488392.2030008@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <laijs@cn.fujitsu.com>) id 1XhEeC-0000Gg-JV
 for lttng-dev@lists.lttng.org; Thu, 23 Oct 2014 05:25:36 -0400
In-Reply-To: <54488392.2030008@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ben Maurer <bmaurer@fb.com>, Yannick Brosseau <scientist@fb.com>
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu:

what happen when the wait_node is still queued when urcu_worker_unregister() is called?

On 10/23/2014 12:26 PM, Lai Jiangshan wrote:
>  Content preview:  Hi, Mathieu In the code, how this problem be solved? "All
>    the tasks may continue stealing works without any progress." Why ___urcu_steal_work()
>     needs cds_wfcq_dequeue_lock()? [...] 
>  
>  Content analysis details:   (1.3 points, 5.0 required)
>  
>   pts rule name              description
>  ---- ---------------------- --------------------------------------------------
>   1.3 RDNS_NONE              Delivered to internal network by a host with no rDNS
> X-Poly-FromMTA: (services.dorsal.polymtl.ca [132.207.72.61]) at Thu, 23 Oct 2014 04:24:22 +0000
> 
> Hi, Mathieu
> 
> In the code, how this problem be solved?
> "All the tasks may continue stealing works without any progress."

Can __urcu_wakeup_siblings() be moved to the end of the urcu_dequeue_work()?

> 
> Why ___urcu_steal_work() needs cds_wfcq_dequeue_lock()?
Sorry, it does need, it locks the source queue...
but we have cds_wfcq_splice_blocking() which wrap the locking and the splicing.

> 
> It is not a good idea for a worker to call synchronize_rcu() (in urcu_accept_work()).
> A new work may be coming soon.


I suggest to add a new API:
__cds_lfs_pop_if(stack, expect) {
	atomic {
		if the top == expect {
			pop it;
		}
	}
}

Then all the worker can only be woken up by urcu_adaptative_wake_up(),
rather than urcu_dequeue_wake_single().

workers dequeues itself when successfully urcu_accept_work() by using
__cds_lfs_pop_if().

Thanks,
Lai

> 
> thanks,
> Lai
> 
> On 10/22/2014 07:20 PM, Mathieu Desnoyers wrote:
>> Hi Lai,
>>
>> I pushed a few updates within the past days, including one
>> fixing this issue. The updated branch is available at:
>>
>> git://git.urcu.so/urcu.git
>> branch: urcu/workqueue-wakeup
>>
>> gitweb:
>> http://git.lttng.org/?p=userspace-rcu.git;a=shortlog;h=refs/heads/urcu/workqueue-wakeup
>>
>> Please let me know if you notice anything else,
>>
>> Thanks!
>>
>> Mathieu
>>
>> ----- Original Message -----
>>> From: "Lai Jiangshan" <laijs@cn.fujitsu.com>
>>> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
>>> Cc: "Ben Maurer" <bmaurer@fb.com>, "lttng-dev" <lttng-dev@lists.lttng.org>, "Yannick Brosseau" <scientist@fb.com>,
>>> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Stephen Hemminger" <stephen@networkplumber.org>
>>> Sent: Wednesday, October 22, 2014 6:57:18 AM
>>> Subject: Re: Userspace RCU: workqueue with batching, cheap wakeup, and work stealing
>>>
>>> Hi
>>>
>>> I just glance the code quickly...
>>>
>>> __urcu_steal_work() and __urcu_wakeup_siblings don't test
>>> if they visit the queue->sibling_head.
>>>
>>> All the tasks may continue stealing works without any progress.
>>>
>>> Thanks,
>>> Lai
>>>
>>> On 10/19/2014 05:13 AM, Mathieu Desnoyers wrote:
>>>> Hi,
>>>>
>>>> I have written an implementation of a workqueue based
>>>> on wfcqueue (fifo workqueue), wfstack (lifo wait queue)
>>>> including a work-stealing scheme. I think this could
>>>> scale very naturally to large workloads, and it skips
>>>> the overhead of sys_futex when wakees are already running.
>>>> Since the wakeup scheme is very lightweight when work
>>>> is ongoing, we use it extensively.
>>>>
>>>> It also makes extensive use of wfcqueue "splice" operation
>>>> to move work batch in bulk amongst queue and worker
>>>> threads. It is a O(1) operation which does not need to
>>>> touch the content of the queue.
>>>>
>>>> RCU is used to lookup the sibling worker threads for
>>>> work stealing and to wake the siblings of a thread
>>>> busy handling work.
>>>>
>>>> It's at:
>>>>
>>>> git://git.urcu.so/urcu.git
>>>> branch: urcu/workqueue-wakeup
>>>>
>>>> or gitweb of the top commit:
>>>> http://git.lttng.org/?p=userspace-rcu.git;a=commit;h=2c6a5414ed2ab44be24211d15a5d9f1f40dbfc74
>>>>
>>>> Note that this is work in progress, compile-tested only.
>>>> I also need to write extensive tests.
>>>>
>>>> Feedback is welcome,
>>>>
>>>> Thanks!
>>>>
>>>> Mathieu
>>>>
>>>
>>>
>>
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> .
> 
