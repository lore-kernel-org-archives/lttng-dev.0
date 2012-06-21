From: <Zheng.Chang@emc.com>
Subject: Re: Some questions about Lttng
Date: Thu, 21 Jun 2012 00:59:20 -0400
Message-ID: <6539770C71C3814BB0BFC2DBEBD105087FC8FC__24927.1399960437$1340254814$gmane$org@CORPUSMX30B.corp.emc.com>
References: <20120619163655.GC6743@Krystal>
	<6539770C71C3814BB0BFC2DBEBD105087FC418@CORPUSMX30B.corp.emc.com>
	<20120620130338.GA25746@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hop-nat-141.emc.com ([168.159.213.141]
	helo=mexforward.lss.emc.com) by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Zheng.Chang@emc.com>) id 1ShZUg-0002lG-Ox
	for lttng-dev@lists.lttng.org; Thu, 21 Jun 2012 00:59:46 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20120620130338.GA25746@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

> -----Original Message-----
> From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] =

> Sent: Wednesday, June 20, 2012 21:04 PM
> To: Chang, Zheng
> Cc: francis.giraldeau@gmail.com; lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] Some questions about Lttng
>
> * Zheng.Chang@emc.com (Zheng.Chang@emc.com) wrote:
> > =

> > > -----Original Message-----
> > > From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] =

> > > Sent: Wednesday, June 20, 2012 0:37 AM
> > > To: Francis Giraldeau
> > > Cc: lttng-dev@lists.lttng.org
> > > Subject: Re: [lttng-dev] Some questions about Lttng
> > =

> > > * Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> > > > Le 2012-06-19 05:50, Zheng.Chang@emc.com a =E9crit :
> > > > >
> > > > > Hi folks,
> > > > >
> > > > >  =

> > > > >
> > > > > I'm studying how to use Lttng now. I built a kernel which version=
 is
> > > > > 2.6.38 and ran with lttng 2.0.
> > > > >
> > > > > I got some confused when I started to use it. Here are my questio=
ns:
> > > > >
> > > > >  =

> > > > >
> > > > > 1. I didn't see kernel patches for kernel 3.x. Does it mean kerne=
l 3.x
> > > > > support it already?
> > > > >
> > > > =

> > > > You don't need a kernel patch with lttng 2.0, only modules are requ=
ired.
> > > > It uses the tracepoints already present in the kernel, and trace sy=
stem
> > > > calls, and uses perf performance counters and kprobes.
> > > > =

> > > > > 2. I tried to do something like, dump the arguments of system cal=
l, or
> > > > > dump a backtrace in a specified function. But the output of lttng=
 is
> > > > > very limited. Is there a way to do that with lttng?
> > > > >
> > > > =

> > > > If system calls are enabled, arguments are supposed to be dumped (o=
ption
> > > > --syscall to lttng enable-event). If it's not the case, then are you
> > > > sure you are using lttng 2.0 and not 0.12? ;) Because the older ver=
sion
> > > > has a different behavior. One additional note: few system calls do =
not
> > > > have all their arguments decoded in lttng 2, but there are only a f=
ew.
> > =

> > > There is no backtrace dump feature in lttng 2.0.
> > =

> > > Arguments of system calls are almost all there on x86 32/64 and ARM.
> > > What architecture are you using ?
> > =

> > =

> > My tsetbed is x86 32bit and lttng's version is 2.0.1. You're right. I c=
an see the arguments now.
> > =

> > =

> > > > =

> > > > > 3. I looked into some UST examples and found here are three header
> > > > > files:  tracepoint.h, tracepoint-event.h and ust-tracepoint-event=
.h.
> > > > > They have some duplicated macro definitions like TRACEPOINT_EVENT.
> > > > >
> > > > =

> > > > The macros are quite complicated. Some includes files are included =
more
> > > > than once to generate various portion of the tracepoint code. So, my
> > > > advice here is to take a working example and adapt it to your needs.
> > =

> > > Good advice.
> > =

> > > > =

> > > > > And the examples includes all of these three header files despite=
 no
> > > > > conflict here. Could someone help to explain the intention?
> > > > >
> > > > > 4. Once I defined a tracepoint in my code, seems some initializat=
ions
> > > > > would register default probe into the hook point.  How to disable=
 the
> > > > > default probe and  register my self-defined probes?
> > > > >
> > > > =

> > > > You mean, call a custom function when tracepoint is executed? Maybe
> > > > somebody else has an answer, but AFAIK this is not possible. But you
> > > > could make a wrapper to your tracepoint and then call your addition=
al
> > > > function there.
> > =

> > > Yep, not possible. You'd have to wrap the tracepoint.
> > =

> > > > =

> > > > > 5. Does lttng-ust support dynamic traceing like kprobe?
> > > > >
> > > > =

> > > > AFAIK, the kernel tracer supports kprobe, but not UST. Maybe somebo=
dy
> > > > else can confirm/infirm the dynamic tracepoint feature in user-spac=
e?
> > =

> > > This is correct.
> > =

> > > Thanks,
> > =

> > > Mathieu
> > =

> > > > =

> > > > You can use a feature of GCC to regiter callback on function entry =
and
> > > > exit, but since it executes for all functions, then the overhead is=
 very
> > > > high. You can have a look here:
> > > > =

> > > > https://github.com/giraldeau/workload-kit/blob/master/ust/cyg.c
> > > > =

> > > > Cheers,
> > > > =

> > > > Francis
> > =

> > =

> > And here are some subsequent questions about lttng:
> > =

> > 6. Does lttng-ust support marker? Marker is easier to be compatible
> > with the APIs like printf if we don't care its performance issue.
>
> Not currently. We plan to implement a "tracepoint_printf" (or
> trace_printf, not sure yet) that will behave similarly to the Linux
> Kernel Markers (back in the early lttng 0.x days). This will definitely
> fulfill your use-case, but it's just not there yet.
>
> > 7. What's supposed to show with 'lttng list -u'? It's empty now. Is
> > that possible to show the events defined in an application?
>
> List of tracepoints in _currently running_ _registered_ applications
> only. An application registers when linked with liblttng-ust.
>
> > 8. What does disable-event command of lttng do? With the
> > example(hello) provided by lttng-ust, I enabled all events with '-a
> > -u' and then disabled them again.  I launched the example with gdb and
> > dumped the tracepoint's structure and then found its state was active.
> > It's supposed to be inactive here, right?
>
> Can you provide the detail of commands you launched, and the result of
> gdb printout ? Please run "hello" with LTTNG_UST_DEBUG=3D1 env. var set.
>
> > BTW: I didn't see any trace generated here with view command.
>
> That is after the disable, right ?

Yes

> Also, did you do a lttng start at some point in your test ?


Yes. Following three examples(A/B/C) provide the testing info for question =
8:

Example A: None event =

lttng create hello
lttng list hello
Tracing session hello: [active]
    Trace path: /root/lttng-traces/hello-20120621-071913
	=

lttng start

gdb ./hello
(gdb) file .libs/hello
(gdb) set env LTTNG_UST_DEBUG=3D1
(gdb) show env
...
LTTNG_UST_DEBUG=3D1
(gdb) br main
Breakpoint 1 at 0x80489b9: file hello.c, line 84.
(gdb) r
Starting program: /root/project/lttng/lttng-ust-2.0.2/tests/hello/.libs/hel=
lo =

[Thread debugging using libthread_db enabled]
liblttng_ust_tracepoint[3341/3341]: just registered a tracepoints section f=
rom 0xb7fddd64 and having 1 tracepoints (in tracepoint_register_lib() at tr=
acepoint.c:638)
liblttng_ust_tracepoint[3341/3341]: registered tracepoint: lttng_ust:metada=
ta (in tracepoint_register_lib() at tracepoint.c:643)
libust[3341/3341]: just registered probe lttng_ust containing 1 events (in =
ltt_probe_register() at ltt-probes.c:109)
libust[3341/3341]: Registered event probe "lttng_ust:metadata" with signatu=
re "const char *, str" (in ltt_probe_register() at ltt-probes.c:118)
libust[3341/3341]: LTT : ltt ring buffer client init
 (in ltt_ring_buffer_metadata_client_init() at ltt-ring-buffer-metadata-cli=
ent.h:334)
libust[3341/3341]: LTT : ltt ring buffer client init
 (in ltt_ring_buffer_client_overwrite_init() at ltt-ring-buffer-client.h:58=
4)
libust[3341/3341]: LTT : ltt ring buffer client init
 (in ltt_ring_buffer_client_discard_init() at ltt-ring-buffer-client.h:584)
[New Thread 0xb7dddb70 (LWP 3344)]
[New Thread 0xb75dcb70 (LWP 3345)]
libust[3341/3344]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:699)
libust[3341/3344]: Waiting for local apps sessiond (in wait_for_sessiond() =
at lttng-ust-comm.c:621)
libust[3341/3344]: Linux kernels 2.6.33 to 3.0 (with the exception of stabl=
e versions) do not support FUTEX_WAKE on read-only memory mappings correctl=
y. Please upgrade your kernel (fix is commit 9ea71503a8ed9184d2d0b8ccc4d269=
d05f7940ae in Linux kernel mainline). LTTng-UST will use polling mode fallb=
ack. (in wait_for_sessiond() at lttng-ust-comm.c:634)
libust[3341/3344]: Error: futex: Bad address (in wait_for_sessiond() at ltt=
ng-ust-comm.c:636)
libust[3341/3344]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:699)
libust[3341/3345]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3341/3345]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3341/3345]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3341/3345]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3341/3341]: just registered probe ust_tests_hello containing 2 event=
s (in ltt_probe_register() at ltt-probes.c:109)
libust[3341/3341]: Registered event probe "ust_tests_hello:tptest" with sig=
nature "int, anint, int, netint, long *, values, char *, text, size_t, text=
len, double, doublearg, float, floatarg" (in ltt_probe_register() at ltt-pr=
obes.c:118)
libust[3341/3341]: Registered event probe "ust_tests_hello:tptest_sighandle=
r" with signature "" (in ltt_probe_register() at ltt-probes.c:118)
liblttng_ust_tracepoint[3341/3341]: just registered a tracepoints section f=
rom 0x804b6c4 and having 2 tracepoints (in tracepoint_register_lib() at tra=
cepoint.c:638)
liblttng_ust_tracepoint[3341/3341]: registered tracepoint: ust_tests_hello:=
tptest_sighandler (in tracepoint_register_lib() at tracepoint.c:643)
liblttng_ust_tracepoint[3341/3341]: registered tracepoint: ust_tests_hello:=
tptest (in tracepoint_register_lib() at tracepoint.c:643)

Breakpoint 1, main (argc=3D1, argv=3D0xbffff754) at hello.c:84
84              if (argc =3D=3D 2)
Missing separate debuginfos, use: debuginfo-install glibc-2.12-1.47.el6_2.1=
2.i686 libuuid-2.17.2-12.4.el6.i686
(gdb) p __tracepoint_ust_tests_hello___tptest
$1 =3D {name =3D 0x804a380 "ust_tests_hello:tptest", state =3D 0, probes =
=3D 0x0, tracepoint_provider_ref =3D 0x804b724, =

  signature =3D 0x8049240 "int, anint, int, netint, long *, values, char *,=
 text, size_t, textlen, double, doublearg, float, floatarg", padding =3D '\=
000' <repeats 15 times>}

Notice here the __tracepoint_ust_tests_hello___tptest.state and __tracepoin=
t_ust_tests_hello___tptest.probes both are 0, which means no register and A=
PI tracepoint doesn't invoke probe.
  =

Example B: enable event ust_tests_hello:tptest
lttng create hello
lttng enable-event ust_tests_hello:tptest -u
lttng list hello
Tracing session hello: [inactive]
    Trace path: /root/lttng-traces/hello-20120621-073315

=3D=3D=3D Domain: UST global =3D=3D=3D

Channels:
-------------
- channel0: [enabled]

    Attributes:
      overwrite mode: 0
      subbufers size: 4096
      number of subbufers: 4
      switch timer interval: 0
      read timer interval: 200
      output: mmap()

    Events:
      ust_tests_hello:tptest (type: tracepoint) [enabled]
lttng start
gdb ./hello
(gdb) file .libs/hello
(gdb) set env LTTNG_UST_DEBUG=3D1
(gdb) show env
...
LTTNG_UST_DEBUG=3D1
(gdb) br main
Breakpoint 1 at 0x80489b9: file hello.c, line 84.
(gdb) r
Starting program: /root/project/lttng/lttng-ust-2.0.2/tests/hello/.libs/hel=
lo =

[Thread debugging using libthread_db enabled]
liblttng_ust_tracepoint[3365/3365]: just registered a tracepoints section f=
rom 0xb7fddd64 and having 1 tracepoints (in tracepoint_register_lib() at tr=
acepoint.c:638)
liblttng_ust_tracepoint[3365/3365]: registered tracepoint: lttng_ust:metada=
ta (in tracepoint_register_lib() at tracepoint.c:643)
libust[3365/3365]: just registered probe lttng_ust containing 1 events (in =
ltt_probe_register() at ltt-probes.c:109)
libust[3365/3365]: Registered event probe "lttng_ust:metadata" with signatu=
re "const char *, str" (in ltt_probe_register() at ltt-probes.c:118)
libust[3365/3365]: LTT : ltt ring buffer client init
 (in ltt_ring_buffer_metadata_client_init() at ltt-ring-buffer-metadata-cli=
ent.h:334)
libust[3365/3365]: LTT : ltt ring buffer client init
 (in ltt_ring_buffer_client_overwrite_init() at ltt-ring-buffer-client.h:58=
4)
libust[3365/3365]: LTT : ltt ring buffer client init
 (in ltt_ring_buffer_client_discard_init() at ltt-ring-buffer-client.h:584)
[New Thread 0xb7dddb70 (LWP 3368)]
libust[3365/3368]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:699)
[New Thread 0xb75dcb70 (LWP 3369)]
libust[3365/3368]: Waiting for local apps sessiond (in wait_for_sessiond() =
at lttng-ust-comm.c:621)
libust[3365/3368]: Linux kernels 2.6.33 to 3.0 (with the exception of stabl=
e versions) do not support FUTEX_WAKE on read-only memory mappings correctl=
y. Please upgrade your kernel (fix is commit 9ea71503a8ed9184d2d0b8ccc4d269=
d05f7940ae in Linux kernel mainline). LTTng-UST will use polling mode fallb=
ack. (in wait_for_sessiond() at lttng-ust-comm.c:634)
libust[3365/3368]: Error: futex: Bad address (in wait_for_sessiond() at ltt=
ng-ust-comm.c:636)
libust[3365/3368]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:699)
libust[3365/3369]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3365/3369]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3365/3369]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3365/3369]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3365/3369]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
liblttng_ust_tracepoint[3365/3369]: Registering probe to tracepoint lttng_u=
st:metadata (in __tracepoint_probe_register() at tracepoint.c:426)
libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3365/3369]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3365/3369]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3365/3369]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3365/3369]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3365/3369]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3365/3369]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3365/3369]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3365/3365]: just registered probe ust_tests_hello containing 2 event=
s (in ltt_probe_register() at ltt-probes.c:109)
libust[3365/3365]: Registered event probe "ust_tests_hello:tptest" with sig=
nature "int, anint, int, netint, long *, values, char *, text, size_t, text=
len, double, doublearg, float, floatarg" (in ltt_probe_register() at ltt-pr=
obes.c:118)
liblttng_ust_tracepoint[3365/3365]: Registering probe to tracepoint ust_tes=
ts_hello:tptest (in __tracepoint_probe_register() at tracepoint.c:426)
libust[3365/3365]: Registered event probe "ust_tests_hello:tptest_sighandle=
r" with signature "" (in ltt_probe_register() at ltt-probes.c:118)
liblttng_ust_tracepoint[3365/3365]: just registered a tracepoints section f=
rom 0x804b6c4 and having 2 tracepoints (in tracepoint_register_lib() at tra=
cepoint.c:638)
liblttng_ust_tracepoint[3365/3365]: registered tracepoint: ust_tests_hello:=
tptest_sighandler (in tracepoint_register_lib() at tracepoint.c:643)
liblttng_ust_tracepoint[3365/3365]: registered tracepoint: ust_tests_hello:=
tptest (in tracepoint_register_lib() at tracepoint.c:643)

Breakpoint 1, main (argc=3D1, argv=3D0xbffff754) at hello.c:84
84              if (argc =3D=3D 2)
Missing separate debuginfos, use: debuginfo-install glibc-2.12-1.47.el6_2.1=
2.i686 libuuid-2.17.2-12.4.el6.i686
(gdb) p __tracepoint_ust_tests_hello___tptest
$1 =3D {name =3D 0x804a380 "ust_tests_hello:tptest", state =3D 1, probes =
=3D 0x804c258, tracepoint_provider_ref =3D 0x804b724, =

  signature =3D 0x8049240 "int, anint, int, netint, long *, values, char *,=
 text, size_t, textlen, double, doublearg, float, floatarg", padding =3D '\=
000' <repeats 15 times>}

We can see __tracepoint_ust_tests_hello___tptest.state and __tracepoint_ust=
_tests_hello___tptest.probes have been set, which means API tracepoint can =
invoke probe callback function and generate trace info.

Example C: enable event and then disable it
lttng create hello
Session hello created.
Traces will be written in /root/lttng-traces/hello-20120621-074221
lttng enable-event ust_tests_hello:tptest -u
UST event ust_tests_hello:tptest created in channel channel0
lttng disable-event ust_tests_hello:tptest -u
UST event ust_tests_hello:tptest disabled in channel channel0 for session h=
ello
lttng list hello
Tracing session hello: [inactive]
    Trace path: /root/lttng-traces/hello-20120621-074221

=3D=3D=3D Domain: UST global =3D=3D=3D

Channels:
-------------
- channel0: [enabled]

    Attributes:
      overwrite mode: 0
      subbufers size: 4096
      number of subbufers: 4
      switch timer interval: 0
      read timer interval: 200
      output: mmap()

    Events:
      ust_tests_hello:tptest (type: tracepoint) [disabled]

lttng start
gdb ./hello
(gdb) file .libs/hello
(gdb) set env LTTNG_UST_DEBUG=3D1
(gdb) show env
...
LTTNG_UST_DEBUG=3D1
(gdb) br main
Breakpoint 1 at 0x80489b9: file hello.c, line 84.
(gdb) r
Starting program: /root/project/lttng/lttng-ust-2.0.2/tests/hello/.libs/hel=
lo =

[Thread debugging using libthread_db enabled]
liblttng_ust_tracepoint[3384/3384]: just registered a tracepoints section f=
rom 0xb7fddd64 and having 1 tracepoints (in tracepoint_register_lib() at tr=
acepoint.c:638)
liblttng_ust_tracepoint[3384/3384]: registered tracepoint: lttng_ust:metada=
ta (in tracepoint_register_lib() at tracepoint.c:643)
libust[3384/3384]: just registered probe lttng_ust containing 1 events (in =
ltt_probe_register() at ltt-probes.c:109)
libust[3384/3384]: Registered event probe "lttng_ust:metadata" with signatu=
re "const char *, str" (in ltt_probe_register() at ltt-probes.c:118)
libust[3384/3384]: LTT : ltt ring buffer client init
 (in ltt_ring_buffer_metadata_client_init() at ltt-ring-buffer-metadata-cli=
ent.h:334)
libust[3384/3384]: LTT : ltt ring buffer client init
 (in ltt_ring_buffer_client_overwrite_init() at ltt-ring-buffer-client.h:58=
4)
libust[3384/3384]: LTT : ltt ring buffer client init
 (in ltt_ring_buffer_client_discard_init() at ltt-ring-buffer-client.h:584)
[New Thread 0xb7dddb70 (LWP 3387)]
[New Thread 0xb75dcb70 (LWP 3388)]
libust[3384/3387]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:699)
libust[3384/3387]: Waiting for local apps sessiond (in wait_for_sessiond() =
at lttng-ust-comm.c:621)
libust[3384/3387]: Linux kernels 2.6.33 to 3.0 (with the exception of stabl=
e versions) do not support FUTEX_WAKE on read-only memory mappings correctl=
y. Please upgrade your kernel (fix is commit 9ea71503a8ed9184d2d0b8ccc4d269=
d05f7940ae in Linux kernel mainline). LTTng-UST will use polling mode fallb=
ack. (in wait_for_sessiond() at lttng-ust-comm.c:634)
libust[3384/3387]: Error: futex: Bad address (in wait_for_sessiond() at ltt=
ng-ust-comm.c:636)
libust[3384/3387]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:699)
libust[3384/3388]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3384/3388]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3384/3388]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3384/3388]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3384/3388]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3384/3388]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
liblttng_ust_tracepoint[3384/3388]: Registering probe to tracepoint lttng_u=
st:metadata (in __tracepoint_probe_register() at tracepoint.c:426)
libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3384/3388]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3384/3388]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3384/3388]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3384/3388]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3384/3388]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3384/3388]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3384/3388]: message received
 (in ust_listener_thread() at lttng-ust-comm.c:766)
libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-=
comm.c:202)
libust[3384/3384]: just registered probe ust_tests_hello containing 2 event=
s (in ltt_probe_register() at ltt-probes.c:109)
libust[3384/3384]: Registered event probe "ust_tests_hello:tptest" with sig=
nature "int, anint, int, netint, long *, values, char *, text, size_t, text=
len, double, doublearg, float, floatarg" (in ltt_probe_register() at ltt-pr=
obes.c:118)
liblttng_ust_tracepoint[3384/3384]: Registering probe to tracepoint ust_tes=
ts_hello:tptest (in __tracepoint_probe_register() at tracepoint.c:426)
libust[3384/3384]: Registered event probe "ust_tests_hello:tptest_sighandle=
r" with signature "" (in ltt_probe_register() at ltt-probes.c:118)
liblttng_ust_tracepoint[3384/3384]: just registered a tracepoints section f=
rom 0x804b6c4 and having 2 tracepoints (in tracepoint_register_lib() at tra=
cepoint.c:638)
liblttng_ust_tracepoint[3384/3384]: registered tracepoint: ust_tests_hello:=
tptest_sighandler (in tracepoint_register_lib() at tracepoint.c:643)
liblttng_ust_tracepoint[3384/3384]: registered tracepoint: ust_tests_hello:=
tptest (in tracepoint_register_lib() at tracepoint.c:643)

Breakpoint 1, main (argc=3D1, argv=3D0xbffff754) at hello.c:84
84              if (argc =3D=3D 2)
Missing separate debuginfos, use: debuginfo-install glibc-2.12-1.47.el6_2.1=
2.i686 libuuid-2.17.2-12.4.el6.i686
(gdb) p __tracepoint_ust_tests_hello___tptest
$1 =3D {name =3D 0x804a380 "ust_tests_hello:tptest", state =3D 1, probes =
=3D 0x804c258, tracepoint_provider_ref =3D 0x804b724, =

  signature =3D 0x8049240 "int, anint, int, netint, long *, values, char *,=
 text, size_t, textlen, double, doublearg, float, floatarg", padding =3D '\=
000' <repeats 15 times>}

Here __tracepoint_ust_tests_hello___tptest.state and __tracepoint_ust_tests=
_hello___tptest.probes have been set, which means probe callback function w=
iil be called by API tracepoint. But the event has been disabled, is this n=
ecessary to call into the probe again? If this behavior is normal, what's s=
uppoed to do with disable-event command? =


Any misunderstanding please fix me. Thanks

Best Regards
Zheng


> Thanks,
> Mathieu
> =

> Thanks all for your useful info!
> =

> Best regards
> Zheng
> =

> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =

> =

> > -- =

> > Mathieu Desnoyers
> > Operating System Efficiency R&D Consultant
> > EfficiOS Inc.
> > http://www.efficios.com
> =

> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =


> -- =

> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
