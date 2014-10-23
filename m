From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: Userspace RCU: workqueue with batching, cheap wakeup,
 and work stealing
Date: Thu, 23 Oct 2014 12:26:58 +0800
Message-ID: <54488392.2030008__20725.2751374201$1414038292$gmane$org@cn.fujitsu.com>
References: <836028170.11148.1413630118955.JavaMail.zimbra@efficios.com>
 <1521253780.11371.1413666790992.JavaMail.zimbra@efficios.com>
 <54478D8E.1080608@cn.fujitsu.com>
 <1569300159.298.1413976834389.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <laijs@cn.fujitsu.com>) id 1Xh9wY-00075A-1K
 for lttng-dev@lists.lttng.org; Thu, 23 Oct 2014 00:24:13 -0400
In-Reply-To: <1569300159.298.1413976834389.JavaMail.zimbra@efficios.com>
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

Hi, Mathieu

In the code, how this problem be solved?
"All the tasks may continue stealing works without any progress."

Why ___urcu_steal_work() needs cds_wfcq_dequeue_lock()?

It is not a good idea for a worker to call synchronize_rcu() (in urcu_accept_work()).
A new work may be coming soon.

thanks,
Lai

On 10/22/2014 07:20 PM, Mathieu Desnoyers wrote:
> Hi Lai,
> 
> I pushed a few updates within the past days, including one
> fixing this issue. The updated branch is available at:
> 
> git://git.urcu.so/urcu.git
> branch: urcu/workqueue-wakeup
> 
> gitweb:
> http://git.lttng.org/?p=userspace-rcu.git;a=shortlog;h=refs/heads/urcu/workqueue-wakeup
> 
> Please let me know if you notice anything else,
> 
> Thanks!
> 
> Mathieu
> 
> ----- Original Message -----
>> From: "Lai Jiangshan" <laijs@cn.fujitsu.com>
>> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
>> Cc: "Ben Maurer" <bmaurer@fb.com>, "lttng-dev" <lttng-dev@lists.lttng.org>, "Yannick Brosseau" <scientist@fb.com>,
>> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Stephen Hemminger" <stephen@networkplumber.org>
>> Sent: Wednesday, October 22, 2014 6:57:18 AM
>> Subject: Re: Userspace RCU: workqueue with batching, cheap wakeup, and work stealing
>>
>> Hi
>>
>> I just glance the code quickly...
>>
>> __urcu_steal_work() and __urcu_wakeup_siblings don't test
>> if they visit the queue->sibling_head.
>>
>> All the tasks may continue stealing works without any progress.
>>
>> Thanks,
>> Lai
>>
>> On 10/19/2014 05:13 AM, Mathieu Desnoyers wrote:
>>> Hi,
>>>
>>> I have written an implementation of a workqueue based
>>> on wfcqueue (fifo workqueue), wfstack (lifo wait queue)
>>> including a work-stealing scheme. I think this could
>>> scale very naturally to large workloads, and it skips
>>> the overhead of sys_futex when wakees are already running.
>>> Since the wakeup scheme is very lightweight when work
>>> is ongoing, we use it extensively.
>>>
>>> It also makes extensive use of wfcqueue "splice" operation
>>> to move work batch in bulk amongst queue and worker
>>> threads. It is a O(1) operation which does not need to
>>> touch the content of the queue.
>>>
>>> RCU is used to lookup the sibling worker threads for
>>> work stealing and to wake the siblings of a thread
>>> busy handling work.
>>>
>>> It's at:
>>>
>>> git://git.urcu.so/urcu.git
>>> branch: urcu/workqueue-wakeup
>>>
>>> or gitweb of the top commit:
>>> http://git.lttng.org/?p=userspace-rcu.git;a=commit;h=2c6a5414ed2ab44be24211d15a5d9f1f40dbfc74
>>>
>>> Note that this is work in progress, compile-tested only.
>>> I also need to write extensive tests.
>>>
>>> Feedback is welcome,
>>>
>>> Thanks!
>>>
>>> Mathieu
>>>
>>
>>
> 
