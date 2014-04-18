From: Keir Fraser <keir@cohodata.com>
Subject: Re: [PATCH liburcu] Fix pthread_atfork() behaviour
Date: Fri, 18 Apr 2014 18:42:50 +0100
Message-ID: <5351641A.3020703__11537.2118809775$1397848118$gmane$org@cohodata.com>
References: <534BE34D.6040304@cohodata.com>
 <1310479684.3385.1397737200900.JavaMail.zimbra@efficios.com>
 <1108103948.3414.1397738599127.JavaMail.zimbra@efficios.com>
 <268671333.3430.1397740359887.JavaMail.zimbra@efficios.com>
 <534FFE1F.7010607@cohodata.com>
 <1326569833.4069.1397837395986.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <keir@cohodata.com>) id 1WbCoV-0002KJ-4j
 for lttng-dev@lists.lttng.org; Fri, 18 Apr 2014 13:43:02 -0400
Received: by mail-wi0-f169.google.com with SMTP id hm4so1280242wib.2
 for <lttng-dev@lists.lttng.org>; Fri, 18 Apr 2014 10:42:53 -0700 (PDT)
In-Reply-To: <1326569833.4069.1397837395986.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Mathieu Desnoyers wrote:
> ----- Original Message -----
>> From: "Keir Fraser"<keir@cohodata.com>
>> To: "Mathieu Desnoyers"<mathieu.desnoyers@efficios.com>
>> Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney"<paulmck@linux.vnet.ibm.com>
>> Sent: Thursday, April 17, 2014 12:15:27 PM
>> Subject: Re: [lttng-dev] [PATCH liburcu] Fix pthread_atfork() behaviour
>>
>> Mathieu Desnoyers wrote:
>>
>> Basically I will have to switch to bp flavour or carry this patch.
>> Actually de-registering and re-registering every thread is really
>> untenable. So I strongly urge to consider giving the callers of this
>> atfork() mechanism a break on this one. ;)
>
> I'm perfectly fine with adding a nicer way to handle pthread atfork in
> RCU flavors besides urcu-bp. I just wanted to share with you the current
> state of what is supported, so we can agree that this would come as a new
> feature into master, and eventually be released in a urcu 0.9. Since it's a
> new feature, there won't be any associated bug entry, nor backports to 0.7
> and 0.8 stable branches.

Okay, that makes sense, thanks.

>> By the way, I also have a valgrind failure on rcu_barrier() due to
>> uninitialised variable/field condition.futex. It gets decremented and
>> passed to futex() syscall, but never actually initialised to zero in the
>> first place. I believe. I haven't yet rolled a patch for that one but
>> I'm sure you don't need one from me anyhow :) However I will send a
>> separate email/patch to the list for this issue very soon unless you
>> tell me that is not necessary.
>
> Urgh, yes. That's a very nice catch!! I'm preparing a fix right away.
> It will be tracked by: http://bugs.lttng.org/issues/787

Worse, while reading the rcu_barrier() code I found a more subtle bug. 
rcu_barrier() can return as soon as completion.barrier_count==0, which 
frees the completion struct along with the rest of its stack frame. But 
its call_rcu callbacks may yet try to read and write completion.futex 
via the wake_up function.

The completion struct should be calloc()ed, reference-counted, and freed 
by the thread that decs the count to 0, imo. I will be cooking up a 
patch to do just that.

There are other places in liburcu which protect a futex variable from 
premature freeing by the waiter polling a teardown flag, but I think 
refcounting is nicer :)

  Regards,
  Keir

> Thanks!
>
> Mathieu
>
>>    Regards,
>>    Keir
>>
>>> Mathieu
>>>
>>>> Thanks,
>>>>
>>>> Mathieu
>>>>
>>>>> Thanks!
>>>>>
>>>>> Mathieu
>>>>>
>>>>>>     Regards,
>>>>>>     Keir Fraser
>>>>>>
>>>>>> _______________________________________________
>>>>>> lttng-dev mailing list
>>>>>> lttng-dev@lists.lttng.org
>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>>
>>>>> --
>>>>> Mathieu Desnoyers
>>>>> EfficiOS Inc.
>>>>> http://www.efficios.com
>>>>>
>>>>> _______________________________________________
>>>>> lttng-dev mailing list
>>>>> lttng-dev@lists.lttng.org
>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>
>>>> --
>>>> Mathieu Desnoyers
>>>> EfficiOS Inc.
>>>> http://www.efficios.com
>>>>
>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>
>
