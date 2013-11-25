From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: deadlock in ust baddr 2.4.0-rc1
Date: Mon, 25 Nov 2013 13:44:08 +0000 (UTC)
Message-ID: <1997349032.75116.1385387048686.JavaMail.zimbra__23191.3728792735$1385387102$gmane$org@efficios.com>
References: <1234203790.74752.1385280797186.JavaMail.zimbra@efficios.com>
	<529334EE.6060308@mentor.com> <52934111.9010403@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VkwSU-0000Yn-B5
	for lttng-dev@lists.lttng.org; Mon, 25 Nov 2013 08:44:19 -0500
In-Reply-To: <52934111.9010403@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <Paul_Woegerer@mentor.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Paul Woegerer" <Paul_Woegerer@mentor.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Monday, November 25, 2013 7:22:41 AM
> Subject: Re: [lttng-dev] deadlock in ust baddr 2.4.0-rc1
> 
> I found a very simple way to prevent the deadlock situation.
> 
> Here again the jul sample that reproduces the issue:
> 
> pwoegere@atv-pwoegere-l3:~/MGC/lttng2_stack_latest/lttng-ust/doc/examples/java-jul>
> ./run
> libust[2876/2877]: Error: Timed out waiting for lttng-sessiond (in
> lttng_ust_init() at lttng-ust-comm.c:1400)
> Nov 25, 2013 1:07:36 PM Hello main
> INFO: Hello World, the answer is 42
> Firing hello delay in 10 seconds...
> Nov 25, 2013 1:07:46 PM Hello main
> INFO: Hello World delayed...
> Cleaning Hello
> /home/pwoegere/MGC/lttng2_stack_latest/lttng-ust/doc/examples/java-jul
> 
> By using *LD_PRELOAD* we are able to make sure that the critical dlopen
> turns into a null operation (thus the locking gets prevented):
> 
> pwoegere@atv-pwoegere-l3:~/MGC/lttng2_stack_latest/lttng-ust/doc/examples/java-jul>
> *LD_PRELOAD=liblttng-ust-baddr.so.0 ./run*
> Nov 25, 2013 1:08:42 PM Hello main
> INFO: Hello World, the answer is 42
> Firing hello delay in 10 seconds...
> Nov 25, 2013 1:08:52 PM Hello main
> INFO: Hello World delayed...
> Cleaning Hello
> /home/pwoegere/MGC/lttng2_stack_latest/lttng-ust/doc/examples/java-jul
> 
> Do you want me to restructure the base-address-state tracing code to
> make the *LD_PRELOAD=liblttng-ust-baddr.so.0* approach the one and only
> way to use it ?

Yes, that sounds like the proper way to fix this issue.

Thanks,

Matheiu

> 
> Best,
> Paul
> 
> 
> On 11/25/2013 12:30 PM, Woegerer, Paul wrote:
> > Hi Mathieu,
> > Hi David,
> >
> > thanks for putting this together.
> > I'm now able to reproduce the problem and I'm investigating options to
> > circumvent the deadlock.
> >
> > I will keep you informed on any progress made.
> >
> > For the time being I will send a patch to prevent
> > lttng_ust_baddr_statedump if environment-variable
> > LTTNG_UST_WITHOUT_BADDR_STATEDUMP is set. This was already requested in
> > another context anyway. See:
> > http://lists.lttng.org/pipermail/lttng-dev/2013-November/021861.html
> >
> > --
> > Thanks,
> > Paul
> >
> >
> > On 11/24/2013 09:13 AM, Mathieu Desnoyers wrote:
> >> Hi Paul,
> >>
> >> We are facing a deadlock with the UST baddr feature in 2.4.0-rc1. Here is
> >> how to
> >> reproduce:
> >>
> >> Build UST ae5f44dbf46c87c1318fde8ab5b5a68048e5af08 by following
> >> doc/java-util-logging.txt
> >> Build tools 077df0b372f77833c1de2dd9f534dec9e75696de
> >>
> >> Install into system + run lttng-sessiond as user (there is an issue David
> >> is working
> >> on that prevents non-root applications to register to the root session
> >> daemon, so
> >> make sure sessiond is not run as root for now).
> >>
> >> run doc/examples/java-jul  ./run file (in UST)
> >>
> >> example output (all is OK, since no tracing is active):
> >>
> >> 24-Nov-2013 3:05:37 AM Hello main
> >> INFO: Hello World, the answer is 42
> >> Firing hello delay in 10 seconds...
> >> 24-Nov-2013 3:05:47 AM Hello main
> >> INFO: Hello World delayed...
> >> Cleaning Hello
> >>
> >> Then start JUL tracing with:
> >>
> >> lttng create
> >> lttng enable-event -j -a
> >> lttng start
> >>
> >> ./run
> >>
> >>
> >> libust[3438/3439]: Error: Timed out waiting for lttng-sessiond (in
> >> lttng_ust_init() at lttng-ust-comm.c:1397)
> >>
> >> even worse if:
> >>
> >> LTTNG_UST_REGISTER_TIMEOUT=-1 ./run
> >>
> >> The application deadlocks like this (on thread 2 in gdb):
> >>
> >>
> >> (gdb) bt full
> >> #0  __lll_lock_wait () at
> >> ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:136
> >> No locals.
> >> #1  0x00007f78ce4c2354 in _L_lock_997 () from
> >> /lib/x86_64-linux-gnu/libpthread.so.0
> >> No symbol table info available.
> >> #2  0x00007f78ce4c21b7 in __pthread_mutex_lock (mutex=0x7f78ceb0c948) at
> >> pthread_mutex_lock.c:82
> >>         ignore1 = <optimized out>
> >>         ignore2 = <optimized out>
> >>         ignore3 = <optimized out>
> >>         __PRETTY_FUNCTION__ = "__pthread_mutex_lock"
> >>         type = 3467692360
> >> #3  0x00007f78ce8fdadb in ?? () from /lib64/ld-linux-x86-64.so.2
> >> No symbol table info available.
> >> #4  0x00007f78ce0b1f66 in dlopen_doit (a=<optimized out>) at dlopen.c:67
> >>         args = 0x7f78c5903520
> >> #5  0x00007f78ce8f9bd6 in ?? () from /lib64/ld-linux-x86-64.so.2
> >> No symbol table info available.
> >> #6  0x00007f78ce0b22ec in _dlerror_run (operate=0x7f78ce0b1f00
> >> <dlopen_doit>, args=0x7f78c5903520) at dlerror.c:164
> >>         result = 0x1568b30
> >> #7  0x00007f78ce0b1ee1 in __dlopen (file=<optimized out>, mode=<optimized
> >> out>) at dlopen.c:88
> >>         args = {file = 0x7f78c69a7eb9 "liblttng-ust-baddr.so.0", mode =
> >>         258, new = 0x101010101010101, caller = 0x7f78c696d8a9}
> >> #8  0x00007f78c696d8a9 in lttng_ust_baddr_handle () at
> >> lttng-ust-comm.c:249
> >>         __func__ = "lttng_ust_baddr_handle"
> >> #9  0x00007f78c696d999 in lttng_ust_baddr_statedump (session=0x159ded0) at
> >> lttng-ust-comm.c:264
> >>         baddr_handle = 0xc69a7dd7
> >>         lttng_ust_baddr_init_fn = 0
> >>         __func__ = "lttng_ust_baddr_statedump"
> >> #10 0x00007f78c6971317 in ust_listener_thread (arg=0x7f78c6bbd000) at
> >> lttng-ust-comm.c:1254
> >>         session = 0x159ded0
> >>         len = 612
> >>         lum = {handle = 1, cmd = 128, padding = '\000' <repeats 31 times>,
> >>         u = {channel = {len = 0, type = LTTNG_UST_CHAN_PER_CPU,
> >>               padding = '\000' <repeats 287 times>, data = 0x7f78c5903d54
> >>               ""}, stream = {len = 0, stream_nr = 0,
> >>               padding = '\000' <repeats 287 times>}, event =
> >>               {instrumentation = LTTNG_UST_TRACEPOINT,
> >>               name = '\000' <repeats 255 times>, loglevel_type =
> >>               LTTNG_UST_LOGLEVEL_ALL, loglevel = 0,
> >>               padding = '\000' <repeats 15 times>, u = {padding = '\000'
> >>               <repeats 287 times>}}, context = {
> >>               ctx = LTTNG_UST_CONTEXT_VTID, padding = '\000' <repeats 15
> >>               times>, u = {padding = '\000' <repeats 287 times>}},
> >>             version = {major = 0, minor = 0, patchlevel = 0}, tracepoint =
> >>             {name = '\000' <repeats 255 times>, loglevel = 0,
> >>               padding = '\000' <repeats 15 times>}, filter = {data_size =
> >>               0, reloc_offset = 0, seqnum = 0}, exclusion = {
> >>               count = 0}, padding = '\000' <repeats 31 times>}}
> >>         sock_info = 0x7f78c6bbd000
> >>         sock = 15
> >>         ret = 0
> >>         prev_connect_failed = 0
> >>         has_waited = 0
> >>         timeout = -1
> >>         __func__ = "ust_listener_thread"
> >>         __PRETTY_FUNCTION__ = "ust_listener_thread"
> >> #11 0x00007f78ce4bfb50 in start_thread (arg=<optimized out>) at
> >> pthread_create.c:304
> >>         __res = <optimized out>
> >>         pd = 0x7f78c5904700
> >>         unwind_buf = {cancel_jmp_buf = {{jmp_buf = {140156687369984,
> >>         -4360901099104425548, 140156840281200, 140156687370688,
> >>                 140156840493120, 3, 4434775346229094836,
> >>                 4434756016842287540}, mask_was_saved = 0}}, priv = {pad =
> >>                 {0x0, 0x0, 0x0,
> >>               0x0}, data = {prev = 0x0, cleanup = 0x0, canceltype = 0}}}
> >>         not_first_call = <optimized out>
> >>         freesize = <optimized out>
> >>         __PRETTY_FUNCTION__ = "start_thread"
> >> #12 0x00007f78cde01a7d in clone () at
> >> ../sysdeps/unix/sysv/linux/x86_64/clone.S:112
> >>
> >>
> >> It is deadlocked on the constructor awaiting for semaphore completion. The
> >> mutex is probably the internal libc dynamic linker mutex held across
> >> constructor execution:
> >>
> >>
> >> #0  sem_wait () at ../nptl/sysdeps/unix/sysv/linux/x86_64/sem_wait.S:86
> >> No locals.
> >> #1  0x00007f78c6971eb6 in lttng_ust_init () at lttng-ust-comm.c:1404
> >>         constructor_timeout = {tv_sec = 140736647255400, tv_nsec = 5}
> >>         sig_all_blocked = {__val = {18446744067267100671,
> >>         18446744073709551615 <repeats 15 times>}}
> >>         orig_parent_mask = {__val = {4, 140156702215847, 1,
> >>         140156702215909, 140153372803072, 140156840282096, 0,
> >>         140156594940184,
> >>             140156840281472, 140156840281496, 3467478208, 140156840282096,
> >>             140156709124528, 140156707014326, 140156833869240,
> >>             140156840308736}}
> >>         thread_attr = {
> >>           __size =
> >>           "\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\000\020",
> >>           '\000' <repeats 37 times>,
> >>           __align = 0}
> >>         timeout_mode = -1
> >>         ret = 0
> >>         __PRETTY_FUNCTION__ = "lttng_ust_init"
> >>         __func__ = "lttng_ust_init"
> >> #2  0x00007f78ce8f9f80 in ?? () from /lib64/ld-linux-x86-64.so.2
> >> No symbol table info available.
> >> #3  0x00007f78ce8fa077 in ?? () from /lib64/ld-linux-x86-64.so.2
> >> No symbol table info available.
> >> #4  0x00007f78ce8fe363 in ?? () from /lib64/ld-linux-x86-64.so.2
> >> No symbol table info available.
> >> #5  0x00007f78ce8f9bd6 in ?? () from /lib64/ld-linux-x86-64.so.2
> >> No symbol table info available.
> >> #6  0x00007f78ce8fdb4a in ?? () from /lib64/ld-linux-x86-64.so.2
> >> No symbol table info available.
> >> #7  0x00007f78ce0b1f66 in dlopen_doit (a=<optimized out>) at dlopen.c:67
> >>         args = 0x7f78cead8b20
> >> #8  0x00007f78ce8f9bd6 in ?? () from /lib64/ld-linux-x86-64.so.2
> >> No symbol table info available.
> >> #9  0x00007f78ce0b22ec in _dlerror_run (operate=0x7f78ce0b1f00
> >> <dlopen_doit>, args=0x7f78cead8b20) at dlerror.c:164
> >>         result = 0x14e2630
> >> #10 0x00007f78ce0b1ee1 in __dlopen (file=<optimized out>, mode=<optimized
> >> out>) at dlopen.c:88
> >>         args = {file = 0x7f78c00eb5f0
> >>         "/home/compudj/git/lttng-ust/liblttng-ust-jul/.libs/liblttng-ust-jul-jni.so.0.0.0",
> >>         mode = 1,
> >>           new = 0x14ea800, caller = 0x7f78cd7abf9f}
> >> #11 0x00007f78cd7abf9f in os::dll_load(char const*, char*, int) ()
> >>    from /usr/lib/jvm/java-6-openjdk-amd64/jre/lib/amd64/server/libjvm.so
> >> No symbol table info available.
> >> #12 0x00007f78cd648f3f in JVM_LoadLibrary () from
> >> /usr/lib/jvm/java-6-openjdk-amd64/jre/lib/amd64/server/libjvm.so
> >> No symbol table info available.
> >> #13 0x00007f78cc3799f7 in
> >> Java_java_lang_ClassLoader_00024NativeLibrary_load ()
> >>    from /usr/lib/jvm/java-6-openjdk-amd64/jre/lib/amd64/libjava.so
> >> No symbol table info available.
> >> #14 0x00007f78c8939d68 in ?? ()
> >> No symbol table info available.
> >> #15 0x00007f78cead95d0 in ?? ()
> >> No symbol table info available.
> >> #16 0x00007f78c892e85a in ?? ()
> >> No symbol table info available.
> >> #17 0x00007f78cead9580 in ?? ()
> >> No symbol table info available.
> >> #18 0x0000000000000000 in ?? ()
> >> No symbol table info available.
> >>
> >> So it looks like calling dlopen() from within lttng-ust is tricky, because
> >> it
> >> introduces deadlocks with the dynamic linker.
> >>
> >> Thoughts ?
> >>
> >> Thanks,
> >>
> >> Mathieu
> >>
> >
> 
> 
> --
> Paul Woegerer, SW Development Engineer
> Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
> Mentor Graphics, Embedded Software Division
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
