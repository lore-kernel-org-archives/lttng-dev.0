From: Keir Fraser <keir@cohodata.com>
Subject: Re: [PATCH liburcu] Fix pthread_atfork() behaviour
Date: Thu, 17 Apr 2014 17:15:27 +0100
Message-ID: <534FFE1F.7010607__43489.7205479958$1397753561$gmane$org@cohodata.com>
References: <534BE34D.6040304@cohodata.com>
 <1310479684.3385.1397737200900.JavaMail.zimbra@efficios.com>
 <1108103948.3414.1397738599127.JavaMail.zimbra@efficios.com>
 <268671333.3430.1397740359887.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f182.google.com ([74.125.82.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <keir@cohodata.com>) id 1WaoyM-00029s-R1
 for lttng-dev@lists.lttng.org; Thu, 17 Apr 2014 12:15:38 -0400
Received: by mail-we0-f182.google.com with SMTP id p61so634363wes.41
 for <lttng-dev@lists.lttng.org>; Thu, 17 Apr 2014 09:15:28 -0700 (PDT)
In-Reply-To: <268671333.3430.1397740359887.JavaMail.zimbra@efficios.com>
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

>>>>
>>>> In the process of integrating liburcu into a multi-threaded codebase
>>>> with fork()s I found a couple of problems with liburcu that I could not
>>>> work around without fixing the library. Hence I present the two required
>>>> fixes here (as attachments, sorry!) with some background info about them.
>>> This is interesting!
>>>
>>> An initial question: Which URCU flavor are you using ?

memb.

>>>> After fork() the child process has no pthreads but the one that called
>>>> fork(). Unfortunately call_rcu_after_fork_child() does not update URCU's
>>>> thread registry to reflect this -- if fork() is called with any threads
>>>> registered with URCU then the child process will inherit a corrupted
>>>> registry containing a linked list through per-thread TLS state which is
>>>> no longer valid allocated memory.
>>> You appear to be using the mb/memb URCU flavor.
>>>
>>> If we look at URCU README file:
>>> Firstly, your use-case seems to be only supported by the urcu-bp
>>> flavor, and explicitly unsupported by other flavors. If you want
>>> to do this with other urcu flavors, you need to explicitly
>>> unregister all your other RCU threads before doing the fork().

Well I should have read the manual it is true :) But even if I had, it 
is very hard to ensure that all threads de-register themselves in a 
large codebase. They would all need to be signalled to do so -- what a 
pita, almost impossible to do safely given the constraints of signal 
handler activities and usage of pthread_atfork I would say.

Basically I will have to switch to bp flavour or carry this patch. 
Actually de-registering and re-registering every thread is really 
untenable. So I strongly urge to consider giving the callers of this 
atfork() mechanism a break on this one. ;)

>>> Also, if we want to eventually support this in the other flavors,
>>> we would need to implement the flavor-specific teardown within each
>>> flavor implementation rather than in the call_rcu implementation.

Yup.

>>> Moreover, as stated in the README file, call_rcu() pre/post fork
>>> handlers don't behave well with glibc's pthread_atfork(), due to
>>> assumptions done within the glibc memory allocator.

Noted. :)

>>>> A second problem is that although call_rcu threads are paused across
>>>> fork(), the handshaking PAUSED flag is not cleared when their execution
>>>> resumes. Hence a second fork() invocation in the original parent process
>>>> will not spin-wait for call_rcu threads to quiesce (as the atfork
>>>> handler will observe all PAUSED flags already set). Patch 2 fixes this
>>>> with the appropriate clearing handshake on resume, post-fork.
>>> I'd be very interested to see a test-case for this problem against
>>> the urcu-bp flavor. I think you have indeed caught a real bug here.
>>>
>>>> Please feel free to modify or rewrite these patches, or solve the
>>>> described problems in a different way, as you see fit! Cc me on replies
>>>> as I am not a subscriber to this list.
>>> Could you provide a small test-case that we could add to the call_rcu
>>> regression (double fork) under tests/regression to make sure this behavior
>>> is covered in the future ? A small refactoring of test_urcu_fork.c to
>>> extend it should do the trick.
>> I'm currently doing the test_urcu_fork.c refactoring, and testing your
>> patch for call_rcu and double-fork. (letting you know so we don't
>> duplicate the effort)
>
> Your fix for the call_rcu handling of double-fork is merged into master,
> stable-0.7, stable-0.8 branches.
>
> I modified test_urcu_fork.c in master so it tests a sequence of 10 forks,
> 3 children deep (recursively). It seems to be solid with your patch. Without,
> it hangs very quickly.
>
> I opened this bug tracker entry for this bug:
>
> http://bugs.lttng.org/issues/786
>
> Thanks!

Thanks for this one!

By the way, I also have a valgrind failure on rcu_barrier() due to 
uninitialised variable/field condition.futex. It gets decremented and 
passed to futex() syscall, but never actually initialised to zero in the 
first place. I believe. I haven't yet rolled a patch for that one but 
I'm sure you don't need one from me anyhow :) However I will send a 
separate email/patch to the list for this issue very soon unless you 
tell me that is not necessary.

  Regards,
  Keir

> Mathieu
>
>> Thanks,
>>
>> Mathieu
>>
>>> Thanks!
>>>
>>> Mathieu
>>>
>>>>    Regards,
>>>>    Keir Fraser
>>>>
>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>
>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> http://www.efficios.com
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
