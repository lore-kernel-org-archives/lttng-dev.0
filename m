From: changz <zheng.chang@emc.com>
Subject: Re: Deaklock in liblttng-ust
Date: Fri, 14 Sep 2012 12:01:42 +0800
Message-ID: <5052AC26.5050904__35291.1002388739$1347596081$gmane$org@emc.com>
References: <6539770C71C3814BB0BFC2DBEBD1050801062B20@CORPUSMX30B.corp.emc.com>
	<20120913113739.GA27777@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1413158121=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hop-nat-141.emc.com ([168.159.213.141]
	helo=mexforward.lss.emc.com) by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Zheng.Chang@emc.com>) id 1TCNI8-0004qE-86
	for lttng-dev@lists.lttng.org; Fri, 14 Sep 2012 00:14:08 -0400
In-Reply-To: <20120913113739.GA27777@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1413158121==
Content-Type: multipart/alternative;
 boundary="------------020304050709030702050507"

This is a multi-part message in MIME format.
--------------020304050709030702050507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/2012 19:37 PM, Mathieu Desnoyers wrote:
> Re: [lttng-dev] Deaklock in liblttng-ust
>
> * Chang, Zheng (Zheng.Chang@emc.com) wrote:
> > Hi,
> >
> >
> >
> > I built a trace.so as a wrapper of lttng-ust, which predefines some
> > events and APIs based on lttng-ust.
> >
> > And here is demo application linked to this share library.
> >
> >
> >
> > Sometimes the demo hung at launch time. I did test with the demo and
> > easy-ust of lttng-ust on both IA32 and X64 and got the same result.
> >
> > Lttng-ust version is 2.02.
> >
> >
> >
> > I collect some debuging info with gdb here:
> >
> >
> >
> > Parent process:
> >
> >
> >
> > gdb) thread 3  (constructor of liblttng-ust.so)
> >
> > [Switching to thread 3 (Thread 0x7f91d5487950 (LWP 21901))]#0
> > 0x00007f91d82ad400 in wait () from /lib64/libpthread.so.0
> >
> > (gdb) bt
> >
> > #0  0x00007f91d82ad400 in wait () from /lib64/libpthread.so.0
> >
> > #1  0x00007f91d64a8c4b in wait_for_sessiond (sock_info=0x7f91d66cc640)
> > at lttng-ust-comm.c:481
> >
> > #2  0x00007f91d64a9545 in ust_listener_thread (arg=<value optimized
> > out>) at lttng-ust-comm.c:669
> >
> > #3  0x00007f91d82a5650 in start_thread () from /lib64/libpthread.so.0
> >
> > #4  0x00007f91d7b0315d in clone () from /lib64/libc.so.6
> >
> >
> >
> > (gdb) thread 5    (constructor of demo)
> >
> > [Switching to thread 5 (Thread 0x7f91d690e950 (LWP 21899))]#0
> > 0x00007f91d82ac344 in __lll_lock_wait () from /lib64/libpthread.so.0
> >
> > (gdb) bt
> >
> > #0  0x00007f91d82ac344 in __lll_lock_wait () from /lib64/libpthread.so.0
> >
> > #1  0x00007f91d82a72d0 in _L_lock_102 () from /lib64/libpthread.so.0
> >
> > #2  0x00007f91d82a6bbe in pthread_mutex_lock () from
> > /lib64/libpthread.so.0
> >
> > #3  0x00007f91d64abf8b in ltt_probe_register (desc=0x7f91d66d0ce0) at
> > ltt-probes.c:77
> >
> > #4  0x00007f91d66e0cfb in __lttng_events_init__sample_component () at
> > /usr/include/lttng/ust-tracepoint-event.h:550
> >
> > #5  0x00007f91d66e71b6 in __do_global_ctors_aux () from mytrace.so
> >
> > #6  0x00007f91d66e03c3 in _init () from mytrace.so
> >
> > #7  0x00007f91d66df3d4 in ?? () from mytrace.so
> >
> > #8  0x00007f91d94f78d8 in ?? () from /lib64/ld-linux-x86-64.so.2
> >
> > #9  0x00007f91d94f7a07 in ?? () from /lib64/ld-linux-x86-64.so.2
> >
> > #10 0x00007f91d94fbbde in ?? () from /lib64/ld-linux-x86-64.so.2
> >
> > #11 0x00007f91d94f7566 in ?? () from /lib64/ld-linux-x86-64.so.2
> >
> > #12 0x00007f91d94fb38b in ?? () from /lib64/ld-linux-x86-64.so.2
> >
> > #13 0x00007f91d84bbf9b in ?? () from /lib64/libdl.so.2
> >
> > #14 0x00007f91d94f7566 in ?? () from /lib64/ld-linux-x86-64.so.2
> >
> > #15 0x00007f91d84bc34c in ?? () from /lib64/libdl.so.2
> >
> > #16 0x00007f91d84bbf01 in dlopen () from /lib64/libdl.so.2
> >
> > ..............................................
> >
> > #24 0x00007f91d82a5650 in start_thread () from /lib64/libpthread.so.0
> >
> > #25 0x00007f91d7b0315d in clone () from /lib64/libc.so.6
> >
> >
> >
> > (gdb) p sessions_mutex
> >
> > $4 = {__data = {__lock = 2, __count = 0, __owner = 21901, __nusers = 1,
> > __kind = 0, __spins = 0, __list = {__prev = 0x0, __next = 0x0}},
> >
> >   __size = "\002\000\000\000\000\000\000\000\215U\000\000\001", '\0'
> > <repeats 26 times>, __align = 2}
> >
> >
> >
> > Child process:
> >
> >
> >
> > (gdb) info thread    (forked from 21901)
> >
> > * 1 Thread 0x7f91d5487950 (LWP 21902)  0x00007f91d82ac344 in
> > __lll_lock_wait () from /lib64/libpthread.so.0
> >
> > (gdb) bt
> >
> > #0  0x00007f91d82ac344 in __lll_lock_wait () from /lib64/libpthread.so.0
> >
> > #1  0x00007f91d82a72d0 in _L_lock_102 () from /lib64/libpthread.so.0
> >
> > #2  0x00007f91d82a6bbe in pthread_mutex_lock () from
> > /lib64/libpthread.so.0
> >
> > #3  0x00007f91d64abe58 in ltt_probe_unregister (desc=0x7f91d66d0ce0) at
> > ltt-probes.c:129
> >
> > #4  0x00007f91d66e0d10 in __lttng_events_exit__sample_component () at
> > /usr/include/lttng/ust-tracepoint-event.h:557
> >
> > #5  0x00007f91d66e07cf in __do_global_dtors_aux () from mytrace.so
> >
> > #6  0x00007f91d66cd664 in global_apps () from /usr/lib/liblttng-ust.so.0
> >
> > #7  0x00007f91d5479df0 in ?? ()
> >
> > #8  0x00007f91d66e71dd in _real_fini () from mytrace.so
> >
> > #9  0x00007f91d66e71d2 in _fini () from mytrace.so
> >
> > #10 0x00007f91d94f7f54 in ?? () from /lib64/ld-linux-x86-64.so.2
> >
> > #11 0x00007f91d7a652ed in exit () from /lib64/libc.so.6
> >
> > #12 0x00007f91d64a9207 in wait_for_sessiond (sock_info=0x7f91d66cc640)
> > at lttng-ust-comm.c:542
> >
> > #13 0x00007f91d64a9545 in ust_listener_thread (arg=<value optimized
> > out>) at lttng-ust-comm.c:669
> >
> > #14 0x00007f91d82a5650 in start_thread () from /lib64/libpthread.so.0
> >
> > #15 0x00007f91d7b0315d in clone () from /lib64/libc.so.6
> >
> > #16 0x0000000000000000 in ?? ()
> >
> > (gdb) p sessions_mutex
> >
> > $1 = {__data = {__lock = 2, __count = 0, __owner = 21901, __nusers = 1,
> > __kind = 0, __spins = 0, __list = {__prev = 0x0, __next = 0x0}},
> >
> >   __size = "\002\000\000\000\000\000\000\000\215U\000\000\001", '\0'
> > <repeats 26 times>, __align = 2}
> >
> >
> >
> > What happened seems like this:
> >
> >
> >
> > lttng_ust_init
> >
> >        |
> >
> >        |-> ust_listener_thread
> >
> >                                             |
> >
> >                                             |-> wait_for_sessiond
> >
> > |
> >
> > |->
> > ust_lock
> > (1)
> >
> > |->
> > get_map_shm
> >
> > |
> > |
> >
> > |
> > |-> get_wait_shm
> >
> > |
> > |
> >
> > |
> > |-> fork
> >
> > |
> > parent -> wait
> > (2)
> >
> > |
> > child  -> exit -> _fini -> __do_global_dtors_aux -> ...... ->
> > ltt_probe_unregister -> ust_lock            (3)
> >
> > |->
> > ust_unlock
> > (4)
> >
> >
> >
> > Deadlock happened at point (1) and (3). Parent waited for child's
> > termination and child waited for parent to release the lock.
> >
> >
> >
> > Reproduction conditions:
> >
> > -          First time to create share memory
> > (/dev/shm/lttng-ust-apps-wait* don't exist)
> >
> > -          Child process got delayed( I'm not quite sure with this, I
> > used gdb to hold child process for a while and it happened either)
> >
> >
> >
> > In normal case, child process didn't call _fini when it exited so that
> > no deadlock happened.
> >
> >
> >
> > Is this a known issue?
>
> Yes, see:
>
> commit 3b8b68e73ec9b2b3cf550048046d3f7f69050688
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Wed Jun 13 04:26:34 2012 -0400
>
>     Fix: liblttng-ust-fork deadlock
>
>     * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
>     > * Burton, Michael (mburton@ciena.com) wrote:
>     > > Mathieu,
>     > >
>     > > I think there is a deadlock scenario in UST, which has been 
> causing my p
>     >
>     > Good catch !
>     >
>     > >
>     > > sessiond is started as root:
>     > >     - creates global sockets ONLY
>     > >     - DOES NOT CREATE shm in $HOME/lttng-ust-wait-<uid>
>     > >
>     > > application linked against ust is run as root:
>     > >   - in lttng_ust_init constructor
>     > >   - ust_listener_thread  (local_apps)
>     > >     - fails to connect to local_apps in $HOME/.lttng (as expected)
>     > >     - prev_connect_failed=1
>     > >     - ust_unlock()
>     > >     - restart
>     > >     - wait_for_sessiond()
>     > >  -->  - ust_lock()
>     > >  |      - get_map_shm()
>     > >  |        - get_wait_shm()
>     > > DEADLOCK    - shm_open() FAILS (not created by sessiond when 
> run by root
>     > >  |            - fork() (trying to create shared memory itself)
>     > >  |              - ust_before_fork()
>     > >  ------------>    - ust_lock()
>     > >
>     > >
>     > > You should be able to create this with an empty main, with no
>     > > tracepoints.  As long as sessiond is started as root so
>     > > $HOME/lttng-ust-wait-<uid> is not created.  You can also make the
>     > > lttng-ust constructor (lttng_ust_init) wait forever and then 
> you'll be
>     > > able to see the deadlock in gdb without even leaving the
>     > > lttng_ust_init constructor.
>     >
>     > Ah, I see. This deadlock is caused by the interaction between
>     > [ liblttng-ust-fork ] and liblttng-ust (the fork override is
>     > performed by [ liblttng-ust-fork ]).
>
>     This can be reproduced easily with the in-tree tests: by removing the
>     lttng-ust-apps-wait* files belonging to the user in /dev/shm, running
>     the "tests/fork" test (with ./run) hangs. If we run "hello" first, and
>     then the fork test, it works fine.
>
>     Fixing this by keeping a nesting counter around the fork() call, so we
>     return immediately from the pre/post fork handlers if they are
>     overridden by liblttng-ust-fork.
>
>     Reported-by: Michael Burton <mburton@ciena.com>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
Mathieu,

It's a little different from the issue of Michael.
In my case, the secondary ust_lock is blocked at the destructor of the 
demo library, which is triggerred by the exit of child process.

         > #2  0x00007f91d82a6bbe in pthread_mutex_lock () from 
/lib64/libpthread.so.0
         > #3  0x00007f91d64abe58 in ltt_probe_unregister 
(desc=0x7f91d66d0ce0) at ltt-probes.c:129

We can see ltt_probe_unregister calls ust_lock in the destructor.
And here is the setion .dtors of the demo library:

objdump --section  .dtors -S mytrace.so
0002fc98 <__DTOR_LIST__>:
    2fc98:       ff ff ff ff 00 00 00 00 40 f0 00 00 d0 f0 00 00 
........@.......
0002fca8 <__DTOR_END__>:
    2fca8:       00 00 00 00 ....
0000f040 t __lttng_events_exit__lttng_ust <ltt_probe_unregister is 
called by this vector>
0000f0d0 t __tracepoints__destroy

The child process calls _fini when it calls API exit. It gets hung and 
meanwhile the parent is waiting for its termination.
I think the whole life-cycle of the process should be considered. The 
parent's waiting in critical region is dangerous.
Is it possible to refine the critical region with smaller fineness?

What do you think?

BR
-Zheng
>
>
> You should upgrade your lttng-ust to latest 2.0.x.
>
> Thanks,
>
> Mathieu
>
>
> >
> >
> >
> > Thanks
> >
> > -Zheng
> >
> >
> >
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
>



--------------020304050709030702050507
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 9/13/2012 19:37 PM, Mathieu
      Desnoyers wrote:<br>
    </div>
    <blockquote cite="mid:20120913113739.GA27777@Krystal" type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <meta name="Generator" content="MS Exchange Server version
        6.5.7655.1">
      <title>Re: [lttng-dev] Deaklock in liblttng-ust</title>
      <!-- Converted from text/plain format -->
      <p><font size="2">* Chang, Zheng (<a class="moz-txt-link-abbreviated" href="mailto:Zheng.Chang@emc.com">Zheng.Chang@emc.com</a>) wrote:<br>
          &gt; Hi,<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; I built a trace.so as a wrapper of lttng-ust, which
          predefines some<br>
          &gt; events and APIs based on lttng-ust.<br>
          &gt;<br>
          &gt; And here is demo application linked to this share
          library.<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; Sometimes the demo hung at launch time. I did test with
          the demo and<br>
          &gt; easy-ust of lttng-ust on both IA32 and X64 and got the
          same result.<br>
          &gt;<br>
          &gt; Lttng-ust version is 2.02.<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; I collect some debuging info with gdb here:<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; Parent process:<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; gdb) thread 3&nbsp; (constructor of liblttng-ust.so)<br>
          &gt;<br>
          &gt; [Switching to thread 3 (Thread 0x7f91d5487950 (LWP
          21901))]#0<br>
          &gt; 0x00007f91d82ad400 in wait () from /lib64/libpthread.so.0<br>
          &gt;<br>
          &gt; (gdb) bt<br>
          &gt;<br>
          &gt; #0&nbsp; 0x00007f91d82ad400 in wait () from
          /lib64/libpthread.so.0<br>
          &gt;<br>
          &gt; #1&nbsp; 0x00007f91d64a8c4b in wait_for_sessiond
          (sock_info=0x7f91d66cc640)<br>
          &gt; at lttng-ust-comm.c:481<br>
          &gt;<br>
          &gt; #2&nbsp; 0x00007f91d64a9545 in ust_listener_thread
          (arg=&lt;value optimized<br>
          &gt; out&gt;) at lttng-ust-comm.c:669<br>
          &gt;<br>
          &gt; #3&nbsp; 0x00007f91d82a5650 in start_thread () from
          /lib64/libpthread.so.0<br>
          &gt;<br>
          &gt; #4&nbsp; 0x00007f91d7b0315d in clone () from /lib64/libc.so.6<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; (gdb) thread 5&nbsp;&nbsp;&nbsp; (constructor of demo)<br>
          &gt;<br>
          &gt; [Switching to thread 5 (Thread 0x7f91d690e950 (LWP
          21899))]#0<br>
          &gt; 0x00007f91d82ac344 in __lll_lock_wait () from
          /lib64/libpthread.so.0<br>
          &gt;<br>
          &gt; (gdb) bt<br>
          &gt;<br>
          &gt; #0&nbsp; 0x00007f91d82ac344 in __lll_lock_wait () from
          /lib64/libpthread.so.0<br>
          &gt;<br>
          &gt; #1&nbsp; 0x00007f91d82a72d0 in _L_lock_102 () from
          /lib64/libpthread.so.0<br>
          &gt;<br>
          &gt; #2&nbsp; 0x00007f91d82a6bbe in pthread_mutex_lock () from<br>
          &gt; /lib64/libpthread.so.0<br>
          &gt;<br>
          &gt; #3&nbsp; 0x00007f91d64abf8b in ltt_probe_register
          (desc=0x7f91d66d0ce0) at<br>
          &gt; ltt-probes.c:77<br>
          &gt;<br>
          &gt; #4&nbsp; 0x00007f91d66e0cfb in
          __lttng_events_init__sample_component () at<br>
          &gt; /usr/include/lttng/ust-tracepoint-event.h:550<br>
          &gt;<br>
          &gt; #5&nbsp; 0x00007f91d66e71b6 in __do_global_ctors_aux () from
          mytrace.so<br>
          &gt;<br>
          &gt; #6&nbsp; 0x00007f91d66e03c3 in _init () from mytrace.so<br>
          &gt;<br>
          &gt; #7&nbsp; 0x00007f91d66df3d4 in ?? () from mytrace.so<br>
          &gt;<br>
          &gt; #8&nbsp; 0x00007f91d94f78d8 in ?? () from
          /lib64/ld-linux-x86-64.so.2<br>
          &gt;<br>
          &gt; #9&nbsp; 0x00007f91d94f7a07 in ?? () from
          /lib64/ld-linux-x86-64.so.2<br>
          &gt;<br>
          &gt; #10 0x00007f91d94fbbde in ?? () from
          /lib64/ld-linux-x86-64.so.2<br>
          &gt;<br>
          &gt; #11 0x00007f91d94f7566 in ?? () from
          /lib64/ld-linux-x86-64.so.2<br>
          &gt;<br>
          &gt; #12 0x00007f91d94fb38b in ?? () from
          /lib64/ld-linux-x86-64.so.2<br>
          &gt;<br>
          &gt; #13 0x00007f91d84bbf9b in ?? () from /lib64/libdl.so.2<br>
          &gt;<br>
          &gt; #14 0x00007f91d94f7566 in ?? () from
          /lib64/ld-linux-x86-64.so.2<br>
          &gt;<br>
          &gt; #15 0x00007f91d84bc34c in ?? () from /lib64/libdl.so.2<br>
          &gt;<br>
          &gt; #16 0x00007f91d84bbf01 in dlopen () from
          /lib64/libdl.so.2<br>
          &gt;<br>
          &gt; ..............................................<br>
          &gt;<br>
          &gt; #24 0x00007f91d82a5650 in start_thread () from
          /lib64/libpthread.so.0<br>
          &gt;<br>
          &gt; #25 0x00007f91d7b0315d in clone () from /lib64/libc.so.6<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; (gdb) p sessions_mutex<br>
          &gt;<br>
          &gt; $4 = {__data = {__lock = 2, __count = 0, __owner = 21901,
          __nusers = 1,<br>
          &gt; __kind = 0, __spins = 0, __list = {__prev = 0x0, __next =
          0x0}},<br>
          &gt;<br>
          &gt;&nbsp;&nbsp; __size =
          "\002\000\000\000\000\000\000\000\215U\000\000\001", '\0'<br>
          &gt; &lt;repeats 26 times&gt;, __align = 2}<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; Child process:<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; (gdb) info thread&nbsp;&nbsp;&nbsp; (forked from 21901)<br>
          &gt;<br>
          &gt; * 1 Thread 0x7f91d5487950 (LWP 21902)&nbsp; 0x00007f91d82ac344
          in<br>
          &gt; __lll_lock_wait () from /lib64/libpthread.so.0<br>
          &gt;<br>
          &gt; (gdb) bt<br>
          &gt;<br>
          &gt; #0&nbsp; 0x00007f91d82ac344 in __lll_lock_wait () from
          /lib64/libpthread.so.0<br>
          &gt;<br>
          &gt; #1&nbsp; 0x00007f91d82a72d0 in _L_lock_102 () from
          /lib64/libpthread.so.0<br>
          &gt;<br>
          &gt; #2&nbsp; 0x00007f91d82a6bbe in pthread_mutex_lock () from<br>
          &gt; /lib64/libpthread.so.0<br>
          &gt;<br>
          &gt; #3&nbsp; 0x00007f91d64abe58 in ltt_probe_unregister
          (desc=0x7f91d66d0ce0) at<br>
          &gt; ltt-probes.c:129<br>
          &gt;<br>
          &gt; #4&nbsp; 0x00007f91d66e0d10 in
          __lttng_events_exit__sample_component () at<br>
          &gt; /usr/include/lttng/ust-tracepoint-event.h:557<br>
          &gt;<br>
          &gt; #5&nbsp; 0x00007f91d66e07cf in __do_global_dtors_aux () from
          mytrace.so<br>
          &gt;<br>
          &gt; #6&nbsp; 0x00007f91d66cd664 in global_apps () from
          /usr/lib/liblttng-ust.so.0<br>
          &gt;<br>
          &gt; #7&nbsp; 0x00007f91d5479df0 in ?? ()<br>
          &gt;<br>
          &gt; #8&nbsp; 0x00007f91d66e71dd in _real_fini () from mytrace.so<br>
          &gt;<br>
          &gt; #9&nbsp; 0x00007f91d66e71d2 in _fini () from mytrace.so<br>
          &gt;<br>
          &gt; #10 0x00007f91d94f7f54 in ?? () from
          /lib64/ld-linux-x86-64.so.2<br>
          &gt;<br>
          &gt; #11 0x00007f91d7a652ed in exit () from /lib64/libc.so.6<br>
          &gt;<br>
          &gt; #12 0x00007f91d64a9207 in wait_for_sessiond
          (sock_info=0x7f91d66cc640)<br>
          &gt; at lttng-ust-comm.c:542<br>
          &gt;<br>
          &gt; #13 0x00007f91d64a9545 in ust_listener_thread
          (arg=&lt;value optimized<br>
          &gt; out&gt;) at lttng-ust-comm.c:669<br>
          &gt;<br>
          &gt; #14 0x00007f91d82a5650 in start_thread () from
          /lib64/libpthread.so.0<br>
          &gt;<br>
          &gt; #15 0x00007f91d7b0315d in clone () from /lib64/libc.so.6<br>
          &gt;<br>
          &gt; #16 0x0000000000000000 in ?? ()<br>
          &gt;<br>
          &gt; (gdb) p sessions_mutex<br>
          &gt;<br>
          &gt; $1 = {__data = {__lock = 2, __count = 0, __owner = 21901,
          __nusers = 1,<br>
          &gt; __kind = 0, __spins = 0, __list = {__prev = 0x0, __next =
          0x0}},<br>
          &gt;<br>
          &gt;&nbsp;&nbsp; __size =
          "\002\000\000\000\000\000\000\000\215U\000\000\001", '\0'<br>
          &gt; &lt;repeats 26 times&gt;, __align = 2}<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; What happened seems like this:<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; lttng_ust_init<br>
          &gt;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
          &gt;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |-&gt; ust_listener_thread<br>
          &gt;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
          &gt;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |-&gt;
          wait_for_sessiond<br>
          &gt;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          |<br>
          &gt;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          |-&gt;<br>
          &gt; ust_lock<br>
          &gt; (1)<br>
          &gt;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          |-&gt;<br>
          &gt; get_map_shm<br>
          &gt;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          |<br>
          &gt; |<br>
          &gt;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          |<br>
          &gt; |-&gt; get_wait_shm<br>
          &gt;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          |<br>
          &gt; |<br>
          &gt;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          |<br>
          &gt; |-&gt; fork<br>
          &gt;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          |<br>
          &gt; parent -&gt; wait<br>
          &gt; (2)<br>
          &gt;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          |<br>
          &gt; child&nbsp; -&gt; exit -&gt; _fini -&gt; __do_global_dtors_aux
          -&gt; ...... -&gt;<br>
          &gt; ltt_probe_unregister -&gt; ust_lock&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (3)<br>
          &gt;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          |-&gt;<br>
          &gt; ust_unlock<br>
          &gt; (4)<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; Deadlock happened at point (1) and (3). Parent waited for
          child's<br>
          &gt; termination and child waited for parent to release the
          lock.<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; Reproduction conditions:<br>
          &gt;<br>
          &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; First time to create share memory<br>
          &gt; (/dev/shm/lttng-ust-apps-wait* don't exist)<br>
          &gt;<br>
          &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Child process got delayed( I'm not quite sure
          with this, I<br>
          &gt; used gdb to hold child process for a while and it
          happened either)<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; In normal case, child process didn't call _fini when it
          exited so that<br>
          &gt; no deadlock happened.<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; Is this a known issue?<br>
          <br>
          Yes, see:<br>
          <br>
          commit 3b8b68e73ec9b2b3cf550048046d3f7f69050688<br>
          Author: Mathieu Desnoyers
          <a class="moz-txt-link-rfc2396E" href="mailto:mathieu.desnoyers@efficios.com">&lt;mathieu.desnoyers@efficios.com&gt;</a><br>
          Date:&nbsp;&nbsp; Wed Jun 13 04:26:34 2012 -0400<br>
          <br>
          &nbsp;&nbsp;&nbsp; Fix: liblttng-ust-fork deadlock<br>
          &nbsp;&nbsp;&nbsp;<br>
          &nbsp;&nbsp;&nbsp; * Mathieu Desnoyers (<a class="moz-txt-link-abbreviated" href="mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>)
          wrote:<br>
          &nbsp;&nbsp;&nbsp; &gt; * Burton, Michael (<a class="moz-txt-link-abbreviated" href="mailto:mburton@ciena.com">mburton@ciena.com</a>) wrote:<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt; Mathieu,<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt; I think there is a deadlock scenario in UST,
          which has been causing my p<br>
          &nbsp;&nbsp;&nbsp; &gt;<br>
          &nbsp;&nbsp;&nbsp; &gt; Good catch !<br>
          &nbsp;&nbsp;&nbsp; &gt;<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt; sessiond is started as root:<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; - creates global sockets ONLY<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; - DOES NOT CREATE shm in
          $HOME/lttng-ust-wait-&lt;uid&gt;<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt; application linked against ust is run as root:<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp;&nbsp; - in lttng_ust_init constructor<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp;&nbsp; - ust_listener_thread&nbsp; (local_apps)<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; - fails to connect to local_apps in
          $HOME/.lttng (as expected)<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; - prev_connect_failed=1<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; - ust_unlock()<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; - restart<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; - wait_for_sessiond()<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp; --&gt;&nbsp; - ust_lock()<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - get_map_shm()<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - get_wait_shm()<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt; DEADLOCK&nbsp;&nbsp;&nbsp; - shm_open() FAILS (not created by
          sessiond when run by root<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - fork() (trying to create shared
          memory itself)<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - ust_before_fork()<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;&nbsp; ------------&gt;&nbsp;&nbsp;&nbsp; - ust_lock()<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt;<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt; You should be able to create this with an empty
          main, with no<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt; tracepoints.&nbsp; As long as sessiond is started as
          root so<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt; $HOME/lttng-ust-wait-&lt;uid&gt; is not
          created.&nbsp; You can also make the<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt; lttng-ust constructor (lttng_ust_init) wait
          forever and then you'll be<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt; able to see the deadlock in gdb without even
          leaving the<br>
          &nbsp;&nbsp;&nbsp; &gt; &gt; lttng_ust_init constructor.<br>
          &nbsp;&nbsp;&nbsp; &gt;<br>
          &nbsp;&nbsp;&nbsp; &gt; Ah, I see. This deadlock is caused by the interaction
          between<br>
          &nbsp;&nbsp;&nbsp; &gt; [ liblttng-ust-fork ] and liblttng-ust (the fork
          override is<br>
          &nbsp;&nbsp;&nbsp; &gt; performed by [ liblttng-ust-fork ]).<br>
          &nbsp;&nbsp;&nbsp;<br>
          &nbsp;&nbsp;&nbsp; This can be reproduced easily with the in-tree tests: by
          removing the<br>
          &nbsp;&nbsp;&nbsp; lttng-ust-apps-wait* files belonging to the user in
          /dev/shm, running<br>
          &nbsp;&nbsp;&nbsp; the "tests/fork" test (with ./run) hangs. If we run
          "hello" first, and<br>
          &nbsp;&nbsp;&nbsp; then the fork test, it works fine.<br>
          &nbsp;&nbsp;&nbsp;<br>
          &nbsp;&nbsp;&nbsp; Fixing this by keeping a nesting counter around the fork()
          call, so we<br>
          &nbsp;&nbsp;&nbsp; return immediately from the pre/post fork handlers if they
          are<br>
          &nbsp;&nbsp;&nbsp; overridden by liblttng-ust-fork.<br>
          &nbsp;&nbsp;&nbsp;<br>
          &nbsp;&nbsp;&nbsp; Reported-by: Michael Burton <a class="moz-txt-link-rfc2396E" href="mailto:mburton@ciena.com">&lt;mburton@ciena.com&gt;</a><br>
          &nbsp;&nbsp;&nbsp; Signed-off-by: Mathieu Desnoyers
          <a class="moz-txt-link-rfc2396E" href="mailto:mathieu.desnoyers@efficios.com">&lt;mathieu.desnoyers@efficios.com&gt;</a><br>
          <br>
        </font></p>
    </blockquote>
    Mathieu,<br>
    <br>
    It's a little different from the issue of Michael.<br>
    In my case, the secondary ust_lock is blocked at the destructor of
    the demo library, which is triggerred by the exit of child process.<br>
    <font size="2"><br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &gt; #2&nbsp; 0x00007f91d82a6bbe in pthread_mutex_lock () from
      /lib64/libpthread.so.0<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &gt; #3&nbsp; 0x00007f91d64abe58 in ltt_probe_unregister
      (desc=0x7f91d66d0ce0) at ltt-probes.c:129</font><br>
    <br>
    We can see ltt_probe_unregister calls ust_lock in the destructor. <br>
    And here is the setion .dtors of the demo library:<br>
    <br>
    objdump --section&nbsp; .dtors -S mytrace.so<br>
    0002fc98 &lt;__DTOR_LIST__&gt;:<br>
    &nbsp;&nbsp; 2fc98:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ff ff ff ff 00 00 00 00 40 f0 00 00 d0 f0 00 00&nbsp;&nbsp;&nbsp;&nbsp;
    ........@.......<br>
    0002fca8 &lt;__DTOR_END__&gt;:<br>
    &nbsp;&nbsp; 2fca8:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 00 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    ....<br>
    0000f040 t __lttng_events_exit__lttng_ust&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &lt;ltt_probe_unregister is called by this vector&gt;<br>
    0000f0d0 t __tracepoints__destroy<br>
    <br>
    The child process calls _fini when it calls API exit. It gets hung
    and meanwhile the parent is waiting for its termination.<br>
    I think the whole life-cycle of the process should be considered.
    The parent's waiting in critical region is dangerous. <br>
    Is it possible to refine the critical region with smaller fineness?<br>
    <br>
    What do you think?<br>
    <br>
    BR<br>
    -Zheng<br>
    <blockquote cite="mid:20120913113739.GA27777@Krystal" type="cite">
      <p><font size="2">
          <br>
          You should upgrade your lttng-ust to latest 2.0.x.<br>
          <br>
          Thanks,<br>
          <br>
          Mathieu<br>
          <br>
          <br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          &gt; Thanks<br>
          &gt;<br>
          &gt; -Zheng<br>
          &gt;<br>
          &gt;&nbsp;<br>
          &gt;<br>
          <br>
          &gt; _______________________________________________<br>
          &gt; lttng-dev mailing list<br>
          &gt; <a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br>
          &gt; <a moz-do-not-send="true"
            href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
          <br>
          <br>
          --<br>
          Mathieu Desnoyers<br>
          Operating System Efficiency R&amp;D Consultant<br>
          EfficiOS Inc.<br>
          <a moz-do-not-send="true" href="http://www.efficios.com">http://www.efficios.com</a><br>
          <br>
        </font>
      </p>
    </blockquote>
    <br>
    <br>
  </body>
</html>

--------------020304050709030702050507--


--===============1413158121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1413158121==--
