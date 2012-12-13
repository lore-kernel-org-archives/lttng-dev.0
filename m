From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: 'call_rcu' unstable?
Date: Thu, 13 Dec 2012 05:35:37 -0500
Message-ID: <20121213103537.GB8637__35045.8210720264$1355395582$gmane$org@Krystal>
References: <tencent_23D20B3D4C566CFC60D89D83@qq.com>
	<20121212145848.GA29236@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tj68h-0002qd-H6
	for lttng-dev@lists.lttng.org; Thu, 13 Dec 2012 05:35:39 -0500
Content-Disposition: inline
In-Reply-To: <20121212145848.GA29236@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: zs <84500316@qq.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * zs (84500316@qq.com) wrote:
> > thanks Mathieu Desnoyers for the patience.
> > 
> > >- Did you ensure that you issue rcu_register_thread() at thread start of
> > >  each of your threads ? And rcu_register_thread before returning from
> > >  each thread ?
> > Sure.
> > 
> > >- How is the list g_sslvpnctxlist[h] initialized ? 
> > Here, is the way:
> > I alloc and init 'g_sslvpnctxlist' in one process, and exec rcu_read_lock/unlock/call_rcu in another process(which create many rx/tx threads). 
> >         if (sslvpn_shm_alloc(&shm) == -1) {
> >                 syslog(LOG_ERR, "alloc share stats memory failed %s\n", strerror(errno));
> >                 exit(-1);
> >         }
> >         g_sslvpnctxlist = (void *)shm.addr;
> >         for (i = 0; i < sslvpn_max_users; i++)
> >                  CDS_INIT_LIST_HEAD(&g_sslvpnctxlist[i]);
> > It looks strange, that someone uses share-memory(created by mmap) to
> > hold the 'g_sslvpnctxlist' (+_+);
> > Later I will re-coding this part, not use share-memory. 
> 
> A couple of things to keep in mind:
> 
> - the shm lists need to be initialized before being passed to the other
>   process adding to them and deleting from them,
> - you need to be aware that a synchronize_rcu() (or call_rcu())
>   executing in the context of one process will not see the RCU read-side
>   locks of another process. So while it should theoretically be OK
>   to do cds_list_add_rcu() from one process and read data from another
>   process, both data read and use of call_rcu/synchronize_rcu need to be
>   performed within the same process, which might make reclaim more
>   complicated. But I understand that you allocate list node, add,
>   remove, and iterate all from the same process, and only initialize
>   the list head from a different process, so this should be good.
> > 
> > Are there concurrent
> > >  modifications of this list ? If yes, are they synchronized with a
> > >  mutex ?
> > I do not use mutex, because all the add/del are executing in one thread. 
> 
> Fair enough, as long as your list head init has been performed before
> your first "add".
> 
> > 
> > >- When your application is a state where the call_rcu worker thread
> > >  busy-waits on RCU read-side critical sections, it would be interesting
> > >  to know on what read-side critical section it is waiting. In order to
> > >  do so, from gdb attached to your process when it is hung:
> > >  - we'
> > 
> >   I did attach the process and check each thread, it says:
> > six threads block in 'msgrcv' IO, and one thread hangs in
> > 'update_counter_and_wait:uruc.c:247'
> 
> Hrm, interesting! I wonder what messages they are waiting on. This might
> be the root cause of the issue: a blocking msgrcv that waits for data
> that is not coming, and at least one of them would be holding the RCU
> read-side lock while waiting. This would in turn also stop progress from
> the call_rcu worker thread.
> 
> > 
> >   I do not have the chance to check the rcu_reader TLS values,
> >  because my customer will not allow the problem happlen again(I have
> >  replaced rcu_lock by pthread_mutex).
> 
> I understand.
> 
> > 
> >  I am trying to reproduce the problem in my testing workplace, if
> >  happens, I will give more.
> 
> OK, that would be helpful! But maybe finding out what messages those
> threads are waiting on might be enough. Is it expected by design that
> those threads wait for a long time on msgrcv ? Is the rcu read-side lock
> held across those msgrcv calls ?

One more question about the nature of your application: is it using a
"fork()" (or clone()) not followed by exec() ?

This design pattern is quite common in daemons using multi-process
worker threads, and it's very likely in your case since you are using
shared memory between processes. This has important impacts on the way
threads are handled (see the pthread_atfork(3) manpage). Given that URCU
keeps track of all reader threads, if any of those vanish at fork(), due
to Linux implementation limitations, they need to be cleared from the
urcu registry before a fork() not followed by exec().

For more info, please refer to the Userspace RCU README file, under
section "Interaction with fork()".

Especially the part:

"Most liburcu implementations require that all registrations (as reader,
defer_rcu and call_rcu threads) should be released before a fork() is
performed, except for the rather common scenario where fork() is
immediately followed by exec() in the child process."

So one possible explanation for the scenario you are observing is that
the parent process still has RCU readers registered while performing
fork(), and that the child process is unable to complete grace periods
due to this stale list entry.

One thing to keep in mind is that this commit:

commit 765f3eadad5647e6fa853414fc652670f9e00966
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Sat Sep 10 22:02:58 2011 -0700

    call_rcu: register work threads as rcu readers

makes all call_rcu worker threads register as RCU readers. Since the
default call_rcu thread is never cleaned up, it becomes hard for the
application to ensure fork() correctness.

Am I on the right track ?

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> > 
> > thanks .
> >    
> > 
> > 
> > 
> > ------------------ Original ------------------
> > From:  "Mathieu Desnoyers"<mathieu.desnoyers@efficios.com>;
> > Date:  Wed, Dec 12, 2012 10:41 AM
> > To:  "zs"<84500316@qq.com>; 
> > Cc:  "lttng-dev"<lttng-dev@lists.lttng.org>; 
> > Subject:  Re: [lttng-dev] 'call_rcu' unstable?
> > 
> > 
> > 
> > * zs (84500316@qq.com) wrote:
> > > Thanks , BUT ...
> > > I really check my code:
> > > 
> > > zs# find .|xargs grep rcu_read 
> > > 
> > > ./sslvpn_ctx.c: rcu_read_lock();
> > > ./sslvpn_ctx.c:                 rcu_read_unlock();
> > > ./sslvpn_ctx.c: rcu_read_unlock();
> > 
> > OK, in that case, continuing on the debugging checklist:
> > 
> > - Did you ensure that you issue rcu_register_thread() at thread start of
> >   each of your threads ? And rcu_register_thread before returning from
> >   each thread ?
> > - How is the list g_sslvpnctxlist[h] initialized ? Are there concurrent
> >   modifications of this list ? If yes, are they synchronized with a
> >   mutex ?
> > - When your application is a state where the call_rcu worker thread
> >   busy-waits on RCU read-side critical sections, it would be interesting
> >   to know on what read-side critical section it is waiting. In order to
> >   do so, from gdb attached to your process when it is hung:
> >   - we'd need to look at the urcu.c "registry" list. We'd need to figure
> >     out which list entries are keeping the busy-loop waiting.
> >   - then, we should look at each thread's "rcu_reader" TLS variable, to
> >     see its address and content.
> >   By comparing the content of the list and each active thread's
> >   rcu_reader TLS variable, we should be able to figure out what is
> >   keeping grace period to complete. If you can provide these dumps, it
> >   would let me help you digging further into your issue.
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > 
> > > 
> > > AND in sslvpn_ctx.c:
> > > void *sslvpn_lookup_ssl(unsigned long iip)
> > > {
> > >         struct sslvpn_ctx *ctx;
> > >         int h;
> > > 
> > >         h = get_hash(iip, 0);
> > > 
> > >         rcu_read_lock();
> > >         cds_list_for_each_entry_rcu(ctx, &g_sslvpnctxlist[h], cdlist) {
> > >                 if ((ctx->flags & SSL_CTX_ESTABLISHED) && ctx->iip && ctx->iip == iip) {
> > > 
> > >                         uatomic_add(&ctx->ssl_use, 1);
> > >                         rcu_read_unlock();
> > >                         return ctx;
> > >                 }
> > >         }
> > > 
> > >         rcu_read_unlock();
> > >         return NULL;
> > > }
> > > 
> > > By the way, *sslvpn_lookup_ssl* called by 6 threads for TX.
> > > the 7th thread only will call *call_rcu*:
> > > 
> > > int sslvpn_del_ctx(struct sslvpn_ctx *pctx)
> > > {
> > >         ...
> > >         cds_list_del_rcu(&ctx->cdlist);
> > >         ctx->flags |= SSL_CTX_DYING;
> > >         call_rcu(&ctx->rcu, func);
> > >         ...
> > > }
> > > 
> > > 
> > > 
> > > 
> > > 
> > > ------------------ Original ------------------
> > > From:  "Mathieu Desnoyers"<mathieu.desnoyers@efficios.com>;
> > > Date:  Wed, Dec 12, 2012 01:55 AM
> > > To:  "zs"<84500316@qq.com>; 
> > > Cc:  "lttng-dev"<lttng-dev@lists.lttng.org>; 
> > > Subject:  Re: [lttng-dev] 'call_rcu' unstable?
> > > 
> > > 
> > > 
> > > * zs (84500316@qq.com) wrote:
> > > > Hi list,
> > > > 
> > > > I found a big problem in my product, that use urcu 0.7.5. My program cost too mutch CPU in the funtion 'update_counter_and_wait:uruc.c:247', and I use gdb to see to *wait_loops*, it says -167777734. The CPU usage grows up from 1% to 100% in one day!
> > > > 
> > > > 
> > > > Here is the sample code to show how I use urcu library:
> > > > 
> > > > #include <urcu.h>
> > > > 
> > > > thread ()
> > > > {
> > > > rcu_register_thread();
> > > > 
> > > > for (;;) {
> > > > rcu_read_lock();
> > > > xxx
> > > > rcu_read_unlock();
> > > 
> > > Please triple-check that all your rcu_read_lock() and rcu_read_unlock()
> > > are balanced (no double-unlock, nor missing unlock for each lock taken).
> > > 
> > > The type of problem you get would happen in such a case.
> > > 
> > > Thanks,
> > > 
> > > Mathieu
> > > 
> > > > }
> > > > }
> > > > 
> > > > main()
> > > > {
> > > > rcu_init();
> > > >   pthread_create(, , , , thread);
> > > > 
> > > > rcu_register_thread();
> > > > for (;;)
> > > > {
> > > >  if (xxx)
> > > >    call_rcu();
> > > > }
> > > > 
> > > > }
> > > > _______________________________________________
> > > > lttng-dev mailing list
> > > > lttng-dev@lists.lttng.org
> > > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > > 
> > > -- 
> > > Mathieu Desnoyers
> > > Operating System Efficiency R&D Consultant
> > > EfficiOS Inc.
> > > http://www.efficios.com
> > -- 
> > Mathieu Desnoyers
> > Operating System Efficiency R&D Consultant
> > EfficiOS Inc.
> > http://www.efficios.com
> -- 
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
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
