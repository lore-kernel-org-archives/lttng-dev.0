From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: rculfstack bug
Date: Thu, 11 Oct 2012 09:31:01 +0800
Message-ID: <50762155.3080804__36630.0475820482$1349920226$gmane$org@cn.fujitsu.com>
References: <50754A57.1080104@cn.fujitsu.com> <20121010114215.GA11307@Krystal>
	<20121010150207.GB2495@linux.vnet.ibm.com>
	<20121010150751.GB20761@Krystal> <20121010175304.GA25511@Krystal>
	<20121010195007.GG2495@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TM7uH-0001UC-Bt
	for lttng-dev@lists.lttng.org; Wed, 10 Oct 2012 21:49:50 -0400
In-Reply-To: <20121010195007.GG2495@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: paulmck@linux.vnet.ibm.com
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On 10/11/2012 03:50 AM, Paul E. McKenney wrote:
> On Wed, Oct 10, 2012 at 01:53:04PM -0400, Mathieu Desnoyers wrote:
>> * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
>>> * Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
>>>> On Wed, Oct 10, 2012 at 07:42:15AM -0400, Mathieu Desnoyers wrote:
>>>>> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
>>>>>> test code:
>>>>>> ./tests/test_urcu_lfs 100 10 10
>>>>>>
>>>>>> bug produce rate > 60%
>>>>>>
>>>>>> {{{
>>>>>> I didn't see any bug when "./tests/test_urcu_lfs 10 10 10" Or "./tests/test_urcu_lfs 100 100 10"
>>>>>> But I just test it about 5 times
>>>>>> }}}
>>>>>>
>>>>>> 4cores*1threads: Intel(R) Core(TM) i5 CPU         760
>>>>>> RCU_MB (no time to test for other rcu type)
>>>>>> test commit: 768fba83676f49eb73fd1d8ad452016a84c5ec2a
>>>>>>
>>>>>> I didn't see any bug when "./tests/test_urcu_mb 10 100 10"
>>>>>>
>>>>>> Sorry, I tried, but I failed to find out the root cause currently.
>>>>>
>>>>> I think I managed to narrow down the issue:
>>>>>
>>>>> 1) the master branch does not reproduce it, but commit
>>>>>    768fba83676f49eb73fd1d8ad452016a84c5ec2a repdroduces it about 50% of the
>>>>>    time.
>>>>>
>>>>> 2) the main change between 768fba83676f49eb73fd1d8ad452016a84c5ec2a and
>>>>>    current master (f94061a3df4c9eab9ac869a19e4228de54771fcb) is call_rcu
>>>>>    moving to wfcqueue.
>>>>>
>>>>> 3) the bug always arise, for me, at the end of the 10 seconds.
>>>>>    However, it might be simply due to the fact that most of the memory
>>>>>    get freed at the end of program execution.
>>>>>
>>>>> 4) I've been able to get a backtrace, and it looks like we have some
>>>>>    call_rcu callback-invokation threads still working while
>>>>>    call_rcu_data_free() is invoked. In the backtrace, call_rcu_data_free()
>>>>>    is nicely waiting for the next thread to stop, and during that time,
>>>>>    two callback-invokation threads are invoking callbacks (and one of
>>>>>    them triggers the segfault).
>>>>
>>>> Do any of the callbacks reference __thread variables from some other
>>>> thread?  If so, those threads must refrain from exiting until after
>>>> such callbacks complete.
>>>
>>> The callback is a simple caa_container_of + free, usual stuff, nothing
>>> fancy.
>>
>> Here is the fix: the bug was in call rcu. It is not required for master,
>> because we fixed it while moving to wfcqueue.
>>
>> We were erroneously writing to the head field of the default
>> call_rcu_data rather than tail.
> 
> Ouch!!!  I have no idea why that would have passed my testing.  :-(

It's one of the reasons that I rewrite wfqueue and introduce delete_all()
(Mathieu uses splice instead) to replace open code of wfqueue in urcu-call-rcu-impl.h.

> 
>> I wonder if we should simply do a new release with call_rcu using
>> wfcqueue and tell people to upgrade, or if we should somehow create a
>> stable branch with this fix.
>>
>> Thoughts ?
> 
> Under what conditions does this bug appear?  It is necessary to not just
> use call_rcu(), but also to explicitly call call_rcu_data_free(), right?
> 
> My guess is that a stable branch would be good -- there will be other
> bugs, after all.  :-/
> 
> 							Thanx, Paul
> 
>> Thanks,
>>
>> Mathieu
>>
>> ---
>> diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
>> index 13b24ff..b205229 100644
>> --- a/urcu-call-rcu-impl.h
>> +++ b/urcu-call-rcu-impl.h
>> @@ -647,8 +647,9 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
>>  		/* Create default call rcu data if need be */
>>  		(void) get_default_call_rcu_data();
>>  		cbs_endprev = (struct cds_wfq_node **)
>> -			uatomic_xchg(&default_call_rcu_data, cbs_tail);
>> -		*cbs_endprev = cbs;
>> +			uatomic_xchg(&default_call_rcu_data->cbs.tail,
>> +					cbs_tail);
>> +		_CMM_STORE_SHARED(*cbs_endprev, cbs);
>>  		uatomic_add(&default_call_rcu_data->qlen,
>>  			    uatomic_read(&crdp->qlen));
>>  		wake_call_rcu_thread(default_call_rcu_data);
>>
>>
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>>>
>>>> 							Thanx, Paul
>>>>
>>>>> So I expect that commit 
>>>>>
>>>>> commit 5161f31e09ce33dd79afad8d08a2372fbf1c4fbe
>>>>> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>> Date:   Tue Sep 25 10:50:49 2012 -0500
>>>>>
>>>>>     call_rcu: use wfcqueue, eliminate false-sharing
>>>>>     
>>>>>     Eliminate false-sharing between call_rcu (enqueuer) and worker threads
>>>>>     on the queue head and tail.
>>>>>     

I think the changelog of this commit is too short.

Thanks,
Lai
