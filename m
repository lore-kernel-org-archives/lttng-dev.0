From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Deaklock in liblttng-ust
Date: Mon, 17 Sep 2012 12:04:10 -0400
Message-ID: <20120917160409.GA14133__40697.0247895972$1347897894$gmane$org@Krystal>
References: <6539770C71C3814BB0BFC2DBEBD1050801062B20@CORPUSMX30B.corp.emc.com>
	<20120913113739.GA27777@Krystal> <5052AC26.5050904@emc.com>
	<20120917133324.GC4256@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TDdnw-0002pf-7n
	for lttng-dev@lists.lttng.org; Mon, 17 Sep 2012 12:04:12 -0400
Content-Disposition: inline
In-Reply-To: <20120917133324.GC4256@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: changz <zheng.chang@emc.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * changz (zheng.chang@emc.com) wrote:
> > On 9/13/2012 19:37 PM, Mathieu Desnoyers wrote:
> >> Re: [lttng-dev] Deaklock in liblttng-ust
> >>
> >> * Chang, Zheng (Zheng.Chang@emc.com) wrote:
> >> > Hi,
> >> >
> >> >
> >> >
> >> > I built a trace.so as a wrapper of lttng-ust, which predefines some
> >> > events and APIs based on lttng-ust.
> >> >
> >> > And here is demo application linked to this share library.
> >> >
> >> >
> >> >
> >> > Sometimes the demo hung at launch time. I did test with the demo and
> >> > easy-ust of lttng-ust on both IA32 and X64 and got the same result.
> >> >
> >> > Lttng-ust version is 2.02.
> >> >
> >> >
> >> >
> >> > I collect some debuging info with gdb here:
> >> >
> >> >
> >> >
> >> > Parent process:
> >> >
> >> >
> >> >
> >> > gdb) thread 3  (constructor of liblttng-ust.so)
> >> >
> >> > [Switching to thread 3 (Thread 0x7f91d5487950 (LWP 21901))]#0
> >> > 0x00007f91d82ad400 in wait () from /lib64/libpthread.so.0
> >> >
> >> > (gdb) bt
> >> >
> >> > #0  0x00007f91d82ad400 in wait () from /lib64/libpthread.so.0
> >> >
> >> > #1  0x00007f91d64a8c4b in wait_for_sessiond (sock_info=0x7f91d66cc640)
> >> > at lttng-ust-comm.c:481
> >> >
> >> > #2  0x00007f91d64a9545 in ust_listener_thread (arg=<value optimized
> >> > out>) at lttng-ust-comm.c:669
> >> >
> >> > #3  0x00007f91d82a5650 in start_thread () from /lib64/libpthread.so.0
> >> >
> >> > #4  0x00007f91d7b0315d in clone () from /lib64/libc.so.6
> >> >
> >> >
> >> >
> >> > (gdb) thread 5    (constructor of demo)
> >> >
> >> > [Switching to thread 5 (Thread 0x7f91d690e950 (LWP 21899))]#0
> >> > 0x00007f91d82ac344 in __lll_lock_wait () from /lib64/libpthread.so.0
> >> >
> >> > (gdb) bt
> >> >
> >> > #0  0x00007f91d82ac344 in __lll_lock_wait () from /lib64/libpthread.so.0
> >> >
> >> > #1  0x00007f91d82a72d0 in _L_lock_102 () from /lib64/libpthread.so.0
> >> >
> >> > #2  0x00007f91d82a6bbe in pthread_mutex_lock () from
> >> > /lib64/libpthread.so.0
> >> >
> >> > #3  0x00007f91d64abf8b in ltt_probe_register (desc=0x7f91d66d0ce0) at
> >> > ltt-probes.c:77
> >> >
> >> > #4  0x00007f91d66e0cfb in __lttng_events_init__sample_component () at
> >> > /usr/include/lttng/ust-tracepoint-event.h:550
> >> >
> >> > #5  0x00007f91d66e71b6 in __do_global_ctors_aux () from mytrace.so
> >> >
> >> > #6  0x00007f91d66e03c3 in _init () from mytrace.so
> >> >
> >> > #7  0x00007f91d66df3d4 in ?? () from mytrace.so
> >> >
> >> > #8  0x00007f91d94f78d8 in ?? () from /lib64/ld-linux-x86-64.so.2
> >> >
> >> > #9  0x00007f91d94f7a07 in ?? () from /lib64/ld-linux-x86-64.so.2
> >> >
> >> > #10 0x00007f91d94fbbde in ?? () from /lib64/ld-linux-x86-64.so.2
> >> >
> >> > #11 0x00007f91d94f7566 in ?? () from /lib64/ld-linux-x86-64.so.2
> >> >
> >> > #12 0x00007f91d94fb38b in ?? () from /lib64/ld-linux-x86-64.so.2
> >> >
> >> > #13 0x00007f91d84bbf9b in ?? () from /lib64/libdl.so.2
> >> >
> >> > #14 0x00007f91d94f7566 in ?? () from /lib64/ld-linux-x86-64.so.2
> >> >
> >> > #15 0x00007f91d84bc34c in ?? () from /lib64/libdl.so.2
> >> >
> >> > #16 0x00007f91d84bbf01 in dlopen () from /lib64/libdl.so.2
> >> >
> >> > ..............................................
> >> >
> >> > #24 0x00007f91d82a5650 in start_thread () from /lib64/libpthread.so.0
> >> >
> >> > #25 0x00007f91d7b0315d in clone () from /lib64/libc.so.6
> >> >
> >> >
> >> >
> >> > (gdb) p sessions_mutex
> >> >
> >> > $4 = {__data = {__lock = 2, __count = 0, __owner = 21901, __nusers = 1,
> >> > __kind = 0, __spins = 0, __list = {__prev = 0x0, __next = 0x0}},
> >> >
> >> >   __size = "\002\000\000\000\000\000\000\000\215U\000\000\001", '\0'
> >> > <repeats 26 times>, __align = 2}
> >> >
> >> >
> >> >
> >> > Child process:
> >> >
> >> >
> >> >
> >> > (gdb) info thread    (forked from 21901)
> >> >
> >> > * 1 Thread 0x7f91d5487950 (LWP 21902)  0x00007f91d82ac344 in
> >> > __lll_lock_wait () from /lib64/libpthread.so.0
> >> >
> >> > (gdb) bt
> >> >
> >> > #0  0x00007f91d82ac344 in __lll_lock_wait () from /lib64/libpthread.so.0
> >> >
> >> > #1  0x00007f91d82a72d0 in _L_lock_102 () from /lib64/libpthread.so.0
> >> >
> >> > #2  0x00007f91d82a6bbe in pthread_mutex_lock () from
> >> > /lib64/libpthread.so.0
> >> >
> >> > #3  0x00007f91d64abe58 in ltt_probe_unregister (desc=0x7f91d66d0ce0) at
> >> > ltt-probes.c:129
> >> >
> >> > #4  0x00007f91d66e0d10 in __lttng_events_exit__sample_component () at
> >> > /usr/include/lttng/ust-tracepoint-event.h:557
> >> >
> >> > #5  0x00007f91d66e07cf in __do_global_dtors_aux () from mytrace.so
> >> >
> >> > #6  0x00007f91d66cd664 in global_apps () from /usr/lib/liblttng-ust.so.0
> >> >
> >> > #7  0x00007f91d5479df0 in ?? ()
> >> >
> >> > #8  0x00007f91d66e71dd in _real_fini () from mytrace.so
> >> >
> >> > #9  0x00007f91d66e71d2 in _fini () from mytrace.so
> >> >
> >> > #10 0x00007f91d94f7f54 in ?? () from /lib64/ld-linux-x86-64.so.2
> >> >
> >> > #11 0x00007f91d7a652ed in exit () from /lib64/libc.so.6
> >> >
> >> > #12 0x00007f91d64a9207 in wait_for_sessiond (sock_info=0x7f91d66cc640)
> >> > at lttng-ust-comm.c:542
> >> >
> >> > #13 0x00007f91d64a9545 in ust_listener_thread (arg=<value optimized
> >> > out>) at lttng-ust-comm.c:669
> >> >
> >> > #14 0x00007f91d82a5650 in start_thread () from /lib64/libpthread.so.0
> >> >
> >> > #15 0x00007f91d7b0315d in clone () from /lib64/libc.so.6
> >> >
> >> > #16 0x0000000000000000 in ?? ()
> >> >
> >> > (gdb) p sessions_mutex
> >> >
> >> > $1 = {__data = {__lock = 2, __count = 0, __owner = 21901, __nusers = 1,
> >> > __kind = 0, __spins = 0, __list = {__prev = 0x0, __next = 0x0}},
> >> >
> >> >   __size = "\002\000\000\000\000\000\000\000\215U\000\000\001", '\0'
> >> > <repeats 26 times>, __align = 2}
> >> >
> >> >
> >> >
> >> > What happened seems like this:
> >> >
> >> >
> >> >
> >> > lttng_ust_init
> >> >
> >> >        |
> >> >
> >> >        |-> ust_listener_thread
> >> >
> >> >                                             |
> >> >
> >> >                                             |-> wait_for_sessiond
> >> >
> >> > |
> >> >
> >> > |->
> >> > ust_lock
> >> > (1)
> >> >
> >> > |->
> >> > get_map_shm
> >> >
> >> > |
> >> > |
> >> >
> >> > |
> >> > |-> get_wait_shm
> >> >
> >> > |
> >> > |
> >> >
> >> > |
> >> > |-> fork
> >> >
> >> > |
> >> > parent -> wait
> >> > (2)
> >> >
> >> > |
> >> > child  -> exit -> _fini -> __do_global_dtors_aux -> ...... ->
> >> > ltt_probe_unregister -> ust_lock            (3)
> >> >
> >> > |->
> >> > ust_unlock
> >> > (4)
> >> >
> >> >
> >> >
> >> > Deadlock happened at point (1) and (3). Parent waited for child's
> >> > termination and child waited for parent to release the lock.
> >> >
> >> >
> >> >
> >> > Reproduction conditions:
> >> >
> >> > -          First time to create share memory
> >> > (/dev/shm/lttng-ust-apps-wait* don't exist)
> >> >
> >> > -          Child process got delayed( I'm not quite sure with this, I
> >> > used gdb to hold child process for a while and it happened either)
> >> >
> >> >
> >> >
> >> > In normal case, child process didn't call _fini when it exited so that
> >> > no deadlock happened.
> >> >
> >> >
> >> >
> >> > Is this a known issue?
> >>
> >> Yes, see:
> >>
> >> commit 3b8b68e73ec9b2b3cf550048046d3f7f69050688
> >> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >> Date:   Wed Jun 13 04:26:34 2012 -0400
> >>
> >>     Fix: liblttng-ust-fork deadlock
> >>
> >>     * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> >>     > * Burton, Michael (mburton@ciena.com) wrote:
> >>     > > Mathieu,
> >>     > >
> >>     > > I think there is a deadlock scenario in UST, which has been  
> >> causing my p
> >>     >
> >>     > Good catch !
> >>     >
> >>     > >
> >>     > > sessiond is started as root:
> >>     > >     - creates global sockets ONLY
> >>     > >     - DOES NOT CREATE shm in $HOME/lttng-ust-wait-<uid>
> >>     > >
> >>     > > application linked against ust is run as root:
> >>     > >   - in lttng_ust_init constructor
> >>     > >   - ust_listener_thread  (local_apps)
> >>     > >     - fails to connect to local_apps in $HOME/.lttng (as expected)
> >>     > >     - prev_connect_failed=1
> >>     > >     - ust_unlock()
> >>     > >     - restart
> >>     > >     - wait_for_sessiond()
> >>     > >  -->  - ust_lock()
> >>     > >  |      - get_map_shm()
> >>     > >  |        - get_wait_shm()
> >>     > > DEADLOCK    - shm_open() FAILS (not created by sessiond when  
> >> run by root
> >>     > >  |            - fork() (trying to create shared memory itself)
> >>     > >  |              - ust_before_fork()
> >>     > >  ------------>    - ust_lock()
> >>     > >
> >>     > >
> >>     > > You should be able to create this with an empty main, with no
> >>     > > tracepoints.  As long as sessiond is started as root so
> >>     > > $HOME/lttng-ust-wait-<uid> is not created.  You can also make the
> >>     > > lttng-ust constructor (lttng_ust_init) wait forever and then  
> >> you'll be
> >>     > > able to see the deadlock in gdb without even leaving the
> >>     > > lttng_ust_init constructor.
> >>     >
> >>     > Ah, I see. This deadlock is caused by the interaction between
> >>     > [ liblttng-ust-fork ] and liblttng-ust (the fork override is
> >>     > performed by [ liblttng-ust-fork ]).
> >>
> >>     This can be reproduced easily with the in-tree tests: by removing the
> >>     lttng-ust-apps-wait* files belonging to the user in /dev/shm, running
> >>     the "tests/fork" test (with ./run) hangs. If we run "hello" first, and
> >>     then the fork test, it works fine.
> >>
> >>     Fixing this by keeping a nesting counter around the fork() call, so we
> >>     return immediately from the pre/post fork handlers if they are
> >>     overridden by liblttng-ust-fork.
> >>
> >>     Reported-by: Michael Burton <mburton@ciena.com>
> >>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >>
> > Mathieu,
> >
> > It's a little different from the issue of Michael.
> > In my case, the secondary ust_lock is blocked at the destructor of the  
> > demo library, which is triggerred by the exit of child process.
> >
> >         > #2  0x00007f91d82a6bbe in pthread_mutex_lock () from  
> > /lib64/libpthread.so.0
> >         > #3  0x00007f91d64abe58 in ltt_probe_unregister  
> > (desc=0x7f91d66d0ce0) at ltt-probes.c:129
> >
> > We can see ltt_probe_unregister calls ust_lock in the destructor.
> > And here is the setion .dtors of the demo library:
> >
> > objdump --section  .dtors -S mytrace.so
> > 0002fc98 <__DTOR_LIST__>:
> >    2fc98:       ff ff ff ff 00 00 00 00 40 f0 00 00 d0 f0 00 00  
> > ........@.......
> > 0002fca8 <__DTOR_END__>:
> >    2fca8:       00 00 00 00 ....
> > 0000f040 t __lttng_events_exit__lttng_ust <ltt_probe_unregister is  
> > called by this vector>
> > 0000f0d0 t __tracepoints__destroy
> >
> > The child process calls _fini when it calls API exit. It gets hung and  
> > meanwhile the parent is waiting for its termination.
> > I think the whole life-cycle of the process should be considered. The  
> > parent's waiting in critical region is dangerous.
> > Is it possible to refine the critical region with smaller fineness?
> >
> > What do you think?
> 
> Hrm, yes you're right. I'm looking into it.
> 
> The main issue is that get_wait_shm() bypass the fork() wrapper (with
> lttng_ust_nest_count), which is responsible for holding the UST mutex
> across fork(). Therefore, when exiting the context of the child process,
> we execute the destructor, which try to grab the UST mutex, which might
> be in pretty much any state.
> 
> Given that we don't want this process to try to register to
> lttng-sessiond (because this is internal to lttng-ust), we might want to
> let it skip the destructor execution. This would actually be the easiest
> way out.
> 
> Does the follow patch fix the issue for you ?
> 
> diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
> index be64acd..596fd7d 100644
> --- a/liblttng-ust/lttng-ust-comm.c
> +++ b/liblttng-ust/lttng-ust-comm.c
> @@ -616,9 +616,9 @@ int get_wait_shm(struct sock_info *sock_info, size_t mmap_size)
>  			ret = ftruncate(wait_shm_fd, mmap_size);
>  			if (ret) {
>  				PERROR("ftruncate");
> -				exit(EXIT_FAILURE);
> +				_exit(EXIT_FAILURE);
>  			}
> -			exit(EXIT_SUCCESS);
> +			_exit(EXIT_SUCCESS);
>  		}
>  		/*
>  		 * For local shm, we need to have rw access to accept

FYI, I'm pushing this commit into master, and will backport to
stable-2.0.

commit b0c1425d1dbdd356172125a2dde4af4602a17326
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Sep 17 12:01:14 2012 -0400

    Fix: get_wait_shm() ust mutex deadlock
    
    The main issue is that get_wait_shm() bypass the fork() wrapper (with
    lttng_ust_nest_count), which is responsible for holding the UST mutex
    across fork(). Therefore, when exiting the context of the child process,
    we execute the destructor, which try to grab the UST mutex, which might
    be in pretty much any state.
    
    Given that we don't want this process to try to register to
    lttng-sessiond (because this is internal to lttng-ust), we might want to
    let it skip the destructor execution. This would actually be the easiest
    way out.
    
    Reported-by: changz <zheng.chang@emc.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
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
