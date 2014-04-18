From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH liburcu] Fix pthread_atfork() behaviour
Date: Fri, 18 Apr 2014 16:09:55 +0000 (UTC)
Message-ID: <1326569833.4069.1397837395986.JavaMail.zimbra__23546.1868033328$1397837479$gmane$org@efficios.com>
References: <534BE34D.6040304@cohodata.com>
 <1310479684.3385.1397737200900.JavaMail.zimbra@efficios.com>
 <1108103948.3414.1397738599127.JavaMail.zimbra@efficios.com>
 <268671333.3430.1397740359887.JavaMail.zimbra@efficios.com>
 <534FFE1F.7010607@cohodata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WbBMZ-0001pi-Ki
 for lttng-dev@lists.lttng.org; Fri, 18 Apr 2014 12:10:09 -0400
In-Reply-To: <534FFE1F.7010607@cohodata.com>
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
> Sent: Thursday, April 17, 2014 12:15:27 PM
> Subject: Re: [lttng-dev] [PATCH liburcu] Fix pthread_atfork() behaviour
> 
> Mathieu Desnoyers wrote:
> 
[...]
> >>>> After fork() the child process has no pthreads but the one that called
> >>>> fork(). Unfortunately call_rcu_after_fork_child() does not update URCU's
> >>>> thread registry to reflect this -- if fork() is called with any threads
> >>>> registered with URCU then the child process will inherit a corrupted
> >>>> registry containing a linked list through per-thread TLS state which is
> >>>> no longer valid allocated memory.
> >>> You appear to be using the mb/memb URCU flavor.
> >>>
> >>> If we look at URCU README file:
> >>> Firstly, your use-case seems to be only supported by the urcu-bp
> >>> flavor, and explicitly unsupported by other flavors. If you want
> >>> to do this with other urcu flavors, you need to explicitly
> >>> unregister all your other RCU threads before doing the fork().
> 
> Well I should have read the manual it is true :) But even if I had, it
> is very hard to ensure that all threads de-register themselves in a
> large codebase. They would all need to be signalled to do so -- what a
> pita, almost impossible to do safely given the constraints of signal
> handler activities and usage of pthread_atfork I would say.
> 
> Basically I will have to switch to bp flavour or carry this patch.
> Actually de-registering and re-registering every thread is really
> untenable. So I strongly urge to consider giving the callers of this
> atfork() mechanism a break on this one. ;)

I'm perfectly fine with adding a nicer way to handle pthread atfork in
RCU flavors besides urcu-bp. I just wanted to share with you the current
state of what is supported, so we can agree that this would come as a new
feature into master, and eventually be released in a urcu 0.9. Since it's a
new feature, there won't be any associated bug entry, nor backports to 0.7
and 0.8 stable branches.

> 
> >>> Also, if we want to eventually support this in the other flavors,
> >>> we would need to implement the flavor-specific teardown within each
> >>> flavor implementation rather than in the call_rcu implementation.
> 
> Yup.

This would probably be similar to the rcu_bp_*fork*() family of functions.
Basically, the pre/post fork functions would now become implemented for
each urcu flavor. We'd have to think about how we want to handle relationship
between the RCU pre/post fork handlers, and the call_rcu-specific pre/post
fork handler, whether the order in which they are executed matters, and
whether it still makes sense to expose a call_rcu pre/post fork handler
when this handler could simply be called from within the RCU flavor
pre/post fork handler. This would simplify handling of handler call order,
but we have to think about API migration very carefully so we don't break
existing users needlessly.

> 
> >>> Moreover, as stated in the README file, call_rcu() pre/post fork
> >>> handlers don't behave well with glibc's pthread_atfork(), due to
> >>> assumptions done within the glibc memory allocator.
> 
> Noted. :)
> 
> >>>> A second problem is that although call_rcu threads are paused across
> >>>> fork(), the handshaking PAUSED flag is not cleared when their execution
> >>>> resumes. Hence a second fork() invocation in the original parent process
> >>>> will not spin-wait for call_rcu threads to quiesce (as the atfork
> >>>> handler will observe all PAUSED flags already set). Patch 2 fixes this
> >>>> with the appropriate clearing handshake on resume, post-fork.
> >>> I'd be very interested to see a test-case for this problem against
> >>> the urcu-bp flavor. I think you have indeed caught a real bug here.
> >>>
> >>>> Please feel free to modify or rewrite these patches, or solve the
> >>>> described problems in a different way, as you see fit! Cc me on replies
> >>>> as I am not a subscriber to this list.
> >>> Could you provide a small test-case that we could add to the call_rcu
> >>> regression (double fork) under tests/regression to make sure this
> >>> behavior
> >>> is covered in the future ? A small refactoring of test_urcu_fork.c to
> >>> extend it should do the trick.
> >> I'm currently doing the test_urcu_fork.c refactoring, and testing your
> >> patch for call_rcu and double-fork. (letting you know so we don't
> >> duplicate the effort)
> >
> > Your fix for the call_rcu handling of double-fork is merged into master,
> > stable-0.7, stable-0.8 branches.
> >
> > I modified test_urcu_fork.c in master so it tests a sequence of 10 forks,
> > 3 children deep (recursively). It seems to be solid with your patch.
> > Without,
> > it hangs very quickly.
> >
> > I opened this bug tracker entry for this bug:
> >
> > http://bugs.lttng.org/issues/786
> >
> > Thanks!
> 
> Thanks for this one!
> 
> By the way, I also have a valgrind failure on rcu_barrier() due to
> uninitialised variable/field condition.futex. It gets decremented and
> passed to futex() syscall, but never actually initialised to zero in the
> first place. I believe. I haven't yet rolled a patch for that one but
> I'm sure you don't need one from me anyhow :) However I will send a
> separate email/patch to the list for this issue very soon unless you
> tell me that is not necessary.

Urgh, yes. That's a very nice catch!! I'm preparing a fix right away.
It will be tracked by: http://bugs.lttng.org/issues/787

Thanks!

Mathieu

> 
>   Regards,
>   Keir
> 
> > Mathieu
> >
> >> Thanks,
> >>
> >> Mathieu
> >>
> >>> Thanks!
> >>>
> >>> Mathieu
> >>>
> >>>>    Regards,
> >>>>    Keir Fraser
> >>>>
> >>>> _______________________________________________
> >>>> lttng-dev mailing list
> >>>> lttng-dev@lists.lttng.org
> >>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>>>
> >>> --
> >>> Mathieu Desnoyers
> >>> EfficiOS Inc.
> >>> http://www.efficios.com
> >>>
> >>> _______________________________________________
> >>> lttng-dev mailing list
> >>> lttng-dev@lists.lttng.org
> >>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> http://www.efficios.com
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>
> >
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
