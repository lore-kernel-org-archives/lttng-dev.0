From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH liburcu] Fix pthread_atfork() behaviour
Date: Thu, 17 Apr 2014 12:43:19 +0000 (UTC)
Message-ID: <1108103948.3414.1397738599127.JavaMail.zimbra__11244.3772530698$1397738649$gmane$org@efficios.com>
References: <534BE34D.6040304@cohodata.com>
 <1310479684.3385.1397737200900.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Walf3-0000uG-MG
 for lttng-dev@lists.lttng.org; Thu, 17 Apr 2014 08:43:27 -0400
In-Reply-To: <1310479684.3385.1397737200900.JavaMail.zimbra@efficios.com>
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
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: "Keir Fraser" <keir@cohodata.com>
> Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Sent: Thursday, April 17, 2014 8:20:00 AM
> Subject: Re: [lttng-dev] [PATCH liburcu] Fix pthread_atfork() behaviour
> 
> ----- Original Message -----
> > From: "Keir Fraser" <keir@cohodata.com>
> > To: lttng-dev@lists.lttng.org
> > Sent: Monday, April 14, 2014 9:31:57 AM
> > Subject: [lttng-dev] [PATCH liburcu] Fix pthread_atfork() behaviour
> > 
> > In the process of integrating liburcu into a multi-threaded codebase
> > with fork()s I found a couple of problems with liburcu that I could not
> > work around without fixing the library. Hence I present the two required
> > fixes here (as attachments, sorry!) with some background info about them.
> 
> This is interesting!
> 
> An initial question: Which URCU flavor are you using ?
> 
> > 
> > After fork() the child process has no pthreads but the one that called
> > fork(). Unfortunately call_rcu_after_fork_child() does not update URCU's
> > thread registry to reflect this -- if fork() is called with any threads
> > registered with URCU then the child process will inherit a corrupted
> > registry containing a linked list through per-thread TLS state which is
> > no longer valid allocated memory.
> 
> You appear to be using the mb/memb URCU flavor.
> 
> If we look at URCU README file:
> 
> Interaction with fork()
> 
>         Special care must be taken for applications performing fork() without
>         any following exec(). This is caused by the fact that Linux only
>         clones
>         the thread calling fork(), and thus never replicates any of the other
>         parent thread into the child process. Most liburcu implementations
>         require that all registrations (as reader, defer_rcu and call_rcu
>         threads) should be released before a fork() is performed, except for
>         the
>         rather common scenario where fork() is immediately followed by exec()
>         in
>         the child process. The only implementation not subject to that rule
>         is
>         liburcu-bp, which is designed to handle fork() by calling
>         rcu_bp_before_fork, rcu_bp_after_fork_parent and
>         rcu_bp_after_fork_child.
> 
>         Applications that use call_rcu() and that fork() without
>         doing an immediate exec() must take special action.  The parent
>         must invoke call_rcu_before_fork() before the fork() and
>         call_rcu_after_fork_parent() after the fork().  The child
>         process must invoke call_rcu_after_fork_child().
>         Even though these three APIs are suitable for passing to
>         pthread_atfork(), use of pthread_atfork() is *STRONGLY
>         DISCOURAGED* for programs calling the glibc memory allocator
>         (malloc(), calloc(), free(), ...) within call_rcu callbacks.
>         This is due to limitations in the way glibc memory allocator
>         handles calls to the memory allocator from concurrent threads
>         while the pthread_atfork() handlers are executing.
>         Combining e.g.:
>         * call to free() from callbacks executed within call_rcu worker
>           threads,
>         * executing call_rcu atfork handlers within the glibc pthread
>           atfork mechanism,
>         will sometimes trigger interesting process hangs. This usually
>         hangs on a memory allocator lock within glibc.
> 
> 
> > Crash or hang soon after is the
> > result. Patch 1 therefore simply clears the registry list in the child
> > process. Caveats here are that (a) the calling thread cannot be
> > registered (it must unregister/re-register itself in the atfork
> > handlers); and (b) some flavours of URCU may have more complex
> > registries than a simple linked list and so this patch may not be
> > sufficient for those. I only tested the memb/mb flavour myself.
> 
> Firstly, your use-case seems to be only supported by the urcu-bp
> flavor, and explicitly unsupported by other flavors. If you want
> to do this with other urcu flavors, you need to explicitly
> unregister all your other RCU threads before doing the fork().
> 
> Also, if we want to eventually support this in the other flavors,
> we would need to implement the flavor-specific teardown within each
> flavor implementation rather than in the call_rcu implementation.
> 
> Moreover, as stated in the README file, call_rcu() pre/post fork
> handlers don't behave well with glibc's pthread_atfork(), due to
> assumptions done within the glibc memory allocator.
> 
> > 
> > A second problem is that although call_rcu threads are paused across
> > fork(), the handshaking PAUSED flag is not cleared when their execution
> > resumes. Hence a second fork() invocation in the original parent process
> > will not spin-wait for call_rcu threads to quiesce (as the atfork
> > handler will observe all PAUSED flags already set). Patch 2 fixes this
> > with the appropriate clearing handshake on resume, post-fork.
> 
> I'd be very interested to see a test-case for this problem against
> the urcu-bp flavor. I think you have indeed caught a real bug here.
> 
> > 
> > Please feel free to modify or rewrite these patches, or solve the
> > described problems in a different way, as you see fit! Cc me on replies
> > as I am not a subscriber to this list.
> 
> Could you provide a small test-case that we could add to the call_rcu
> regression (double fork) under tests/regression to make sure this behavior
> is covered in the future ? A small refactoring of test_urcu_fork.c to
> extend it should do the trick.

I'm currently doing the test_urcu_fork.c refactoring, and testing your
patch for call_rcu and double-fork. (letting you know so we don't
duplicate the effort)

Thanks,

Mathieu

> 
> Thanks!
> 
> Mathieu
> 
> > 
> >   Regards,
> >   Keir Fraser
> > 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
