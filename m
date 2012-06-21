From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Some questions about Lttng
Date: Thu, 21 Jun 2012 08:45:32 -0400
Message-ID: <20120621124532.GA7255__45437.8129485578$1340282770$gmane$org@Krystal>
References: <20120619163655.GC6743@Krystal>
	<6539770C71C3814BB0BFC2DBEBD105087FC418@CORPUSMX30B.corp.emc.com>
	<20120620130338.GA25746@Krystal>
	<6539770C71C3814BB0BFC2DBEBD105087FC8FC@CORPUSMX30B.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1ShglT-0006YI-PP
	for lttng-dev@lists.lttng.org; Thu, 21 Jun 2012 08:45:36 -0400
Content-Disposition: inline
In-Reply-To: <6539770C71C3814BB0BFC2DBEBD105087FC8FC@CORPUSMX30B.corp.emc.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zheng.Chang@emc.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Zheng.Chang@emc.com (Zheng.Chang@emc.com) wrote:
> > -----Original Message-----
> > From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] 
[...]
> > > 8. What does disable-event command of lttng do? With the
> > > example(hello) provided by lttng-ust, I enabled all events with '-a
> > > -u' and then disabled them again.  I launched the example with gdb and
> > > dumped the tracepoint's structure and then found its state was active.
> > > It's supposed to be inactive here, right?
> >
> > Can you provide the detail of commands you launched, and the result of
> > gdb printout ? Please run "hello" with LTTNG_UST_DEBUG=1 env. var set.
> >
> > > BTW: I didn't see any trace generated here with view command.
> >
> > That is after the disable, right ?
> 
> Yes
> 
> > Also, did you do a lttng start at some point in your test ?
> 
> 
> Yes. Following three examples(A/B/C) provide the testing info for question 8:
> 
> Example A: None event 
> lttng create hello
> lttng list hello
> Tracing session hello: [active]
>     Trace path: /root/lttng-traces/hello-20120621-071913
> 	
> lttng start
> 
> gdb ./hello
> (gdb) file .libs/hello
> (gdb) set env LTTNG_UST_DEBUG=1
> (gdb) show env
> ...
> LTTNG_UST_DEBUG=1
> (gdb) br main
> Breakpoint 1 at 0x80489b9: file hello.c, line 84.
> (gdb) r
> Starting program: /root/project/lttng/lttng-ust-2.0.2/tests/hello/.libs/hello 
> [Thread debugging using libthread_db enabled]
> liblttng_ust_tracepoint[3341/3341]: just registered a tracepoints section from 0xb7fddd64 and having 1 tracepoints (in tracepoint_register_lib() at tracepoint.c:638)
> liblttng_ust_tracepoint[3341/3341]: registered tracepoint: lttng_ust:metadata (in tracepoint_register_lib() at tracepoint.c:643)
> libust[3341/3341]: just registered probe lttng_ust containing 1 events (in ltt_probe_register() at ltt-probes.c:109)
> libust[3341/3341]: Registered event probe "lttng_ust:metadata" with signature "const char *, str" (in ltt_probe_register() at ltt-probes.c:118)
> libust[3341/3341]: LTT : ltt ring buffer client init
>  (in ltt_ring_buffer_metadata_client_init() at ltt-ring-buffer-metadata-client.h:334)
> libust[3341/3341]: LTT : ltt ring buffer client init
>  (in ltt_ring_buffer_client_overwrite_init() at ltt-ring-buffer-client.h:584)
> libust[3341/3341]: LTT : ltt ring buffer client init
>  (in ltt_ring_buffer_client_discard_init() at ltt-ring-buffer-client.h:584)
> [New Thread 0xb7dddb70 (LWP 3344)]
> [New Thread 0xb75dcb70 (LWP 3345)]
> libust[3341/3344]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:699)
> libust[3341/3344]: Waiting for local apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:621)
> libust[3341/3344]: Linux kernels 2.6.33 to 3.0 (with the exception of stable versions) do not support FUTEX_WAKE on read-only memory mappings correctly. Please upgrade your kernel (fix is commit 9ea71503a8ed9184d2d0b8ccc4d269d05f7940ae in Linux kernel mainline). LTTng-UST will use polling mode fallback. (in wait_for_sessiond() at lttng-ust-comm.c:634)
> libust[3341/3344]: Error: futex: Bad address (in wait_for_sessiond() at lttng-ust-comm.c:636)
> libust[3341/3344]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:699)
> libust[3341/3345]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3341/3345]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3341/3345]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3341/3345]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3341/3341]: just registered probe ust_tests_hello containing 2 events (in ltt_probe_register() at ltt-probes.c:109)
> libust[3341/3341]: Registered event probe "ust_tests_hello:tptest" with signature "int, anint, int, netint, long *, values, char *, text, size_t, textlen, double, doublearg, float, floatarg" (in ltt_probe_register() at ltt-probes.c:118)
> libust[3341/3341]: Registered event probe "ust_tests_hello:tptest_sighandler" with signature "" (in ltt_probe_register() at ltt-probes.c:118)
> liblttng_ust_tracepoint[3341/3341]: just registered a tracepoints section from 0x804b6c4 and having 2 tracepoints (in tracepoint_register_lib() at tracepoint.c:638)
> liblttng_ust_tracepoint[3341/3341]: registered tracepoint: ust_tests_hello:tptest_sighandler (in tracepoint_register_lib() at tracepoint.c:643)
> liblttng_ust_tracepoint[3341/3341]: registered tracepoint: ust_tests_hello:tptest (in tracepoint_register_lib() at tracepoint.c:643)
> 
> Breakpoint 1, main (argc=1, argv=0xbffff754) at hello.c:84
> 84              if (argc == 2)
> Missing separate debuginfos, use: debuginfo-install glibc-2.12-1.47.el6_2.12.i686 libuuid-2.17.2-12.4.el6.i686
> (gdb) p __tracepoint_ust_tests_hello___tptest
> $1 = {name = 0x804a380 "ust_tests_hello:tptest", state = 0, probes = 0x0, tracepoint_provider_ref = 0x804b724, 
>   signature = 0x8049240 "int, anint, int, netint, long *, values, char *, text, size_t, textlen, double, doublearg, float, floatarg", padding = '\000' <repeats 15 times>}
> 
> Notice here the __tracepoint_ust_tests_hello___tptest.state and __tracepoint_ust_tests_hello___tptest.probes both are 0, which means no register and API tracepoint doesn't invoke probe.
>   
> Example B: enable event ust_tests_hello:tptest
> lttng create hello
> lttng enable-event ust_tests_hello:tptest -u
> lttng list hello
> Tracing session hello: [inactive]
>     Trace path: /root/lttng-traces/hello-20120621-073315
> 
> === Domain: UST global ===
> 
> Channels:
> -------------
> - channel0: [enabled]
> 
>     Attributes:
>       overwrite mode: 0
>       subbufers size: 4096
>       number of subbufers: 4
>       switch timer interval: 0
>       read timer interval: 200
>       output: mmap()
> 
>     Events:
>       ust_tests_hello:tptest (type: tracepoint) [enabled]
> lttng start
> gdb ./hello
> (gdb) file .libs/hello
> (gdb) set env LTTNG_UST_DEBUG=1
> (gdb) show env
> ...
> LTTNG_UST_DEBUG=1
> (gdb) br main
> Breakpoint 1 at 0x80489b9: file hello.c, line 84.
> (gdb) r
> Starting program: /root/project/lttng/lttng-ust-2.0.2/tests/hello/.libs/hello 
> [Thread debugging using libthread_db enabled]
> liblttng_ust_tracepoint[3365/3365]: just registered a tracepoints section from 0xb7fddd64 and having 1 tracepoints (in tracepoint_register_lib() at tracepoint.c:638)
> liblttng_ust_tracepoint[3365/3365]: registered tracepoint: lttng_ust:metadata (in tracepoint_register_lib() at tracepoint.c:643)
> libust[3365/3365]: just registered probe lttng_ust containing 1 events (in ltt_probe_register() at ltt-probes.c:109)
> libust[3365/3365]: Registered event probe "lttng_ust:metadata" with signature "const char *, str" (in ltt_probe_register() at ltt-probes.c:118)
> libust[3365/3365]: LTT : ltt ring buffer client init
>  (in ltt_ring_buffer_metadata_client_init() at ltt-ring-buffer-metadata-client.h:334)
> libust[3365/3365]: LTT : ltt ring buffer client init
>  (in ltt_ring_buffer_client_overwrite_init() at ltt-ring-buffer-client.h:584)
> libust[3365/3365]: LTT : ltt ring buffer client init
>  (in ltt_ring_buffer_client_discard_init() at ltt-ring-buffer-client.h:584)
> [New Thread 0xb7dddb70 (LWP 3368)]
> libust[3365/3368]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:699)
> [New Thread 0xb75dcb70 (LWP 3369)]
> libust[3365/3368]: Waiting for local apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:621)
> libust[3365/3368]: Linux kernels 2.6.33 to 3.0 (with the exception of stable versions) do not support FUTEX_WAKE on read-only memory mappings correctly. Please upgrade your kernel (fix is commit 9ea71503a8ed9184d2d0b8ccc4d269d05f7940ae in Linux kernel mainline). LTTng-UST will use polling mode fallback. (in wait_for_sessiond() at lttng-ust-comm.c:634)
> libust[3365/3368]: Error: futex: Bad address (in wait_for_sessiond() at lttng-ust-comm.c:636)
> libust[3365/3368]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:699)
> libust[3365/3369]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3365/3369]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3365/3369]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3365/3369]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3365/3369]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> liblttng_ust_tracepoint[3365/3369]: Registering probe to tracepoint lttng_ust:metadata (in __tracepoint_probe_register() at tracepoint.c:426)
> libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3365/3369]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3365/3369]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3365/3369]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3365/3369]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3365/3369]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3365/3369]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3365/3369]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3365/3369]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3365/3365]: just registered probe ust_tests_hello containing 2 events (in ltt_probe_register() at ltt-probes.c:109)
> libust[3365/3365]: Registered event probe "ust_tests_hello:tptest" with signature "int, anint, int, netint, long *, values, char *, text, size_t, textlen, double, doublearg, float, floatarg" (in ltt_probe_register() at ltt-probes.c:118)
> liblttng_ust_tracepoint[3365/3365]: Registering probe to tracepoint ust_tests_hello:tptest (in __tracepoint_probe_register() at tracepoint.c:426)
> libust[3365/3365]: Registered event probe "ust_tests_hello:tptest_sighandler" with signature "" (in ltt_probe_register() at ltt-probes.c:118)
> liblttng_ust_tracepoint[3365/3365]: just registered a tracepoints section from 0x804b6c4 and having 2 tracepoints (in tracepoint_register_lib() at tracepoint.c:638)
> liblttng_ust_tracepoint[3365/3365]: registered tracepoint: ust_tests_hello:tptest_sighandler (in tracepoint_register_lib() at tracepoint.c:643)
> liblttng_ust_tracepoint[3365/3365]: registered tracepoint: ust_tests_hello:tptest (in tracepoint_register_lib() at tracepoint.c:643)
> 
> Breakpoint 1, main (argc=1, argv=0xbffff754) at hello.c:84
> 84              if (argc == 2)
> Missing separate debuginfos, use: debuginfo-install glibc-2.12-1.47.el6_2.12.i686 libuuid-2.17.2-12.4.el6.i686
> (gdb) p __tracepoint_ust_tests_hello___tptest
> $1 = {name = 0x804a380 "ust_tests_hello:tptest", state = 1, probes = 0x804c258, tracepoint_provider_ref = 0x804b724, 
>   signature = 0x8049240 "int, anint, int, netint, long *, values, char *, text, size_t, textlen, double, doublearg, float, floatarg", padding = '\000' <repeats 15 times>}
> 
> We can see __tracepoint_ust_tests_hello___tptest.state and __tracepoint_ust_tests_hello___tptest.probes have been set, which means API tracepoint can invoke probe callback function and generate trace info.
> 
> Example C: enable event and then disable it
> lttng create hello
> Session hello created.
> Traces will be written in /root/lttng-traces/hello-20120621-074221
> lttng enable-event ust_tests_hello:tptest -u
> UST event ust_tests_hello:tptest created in channel channel0
> lttng disable-event ust_tests_hello:tptest -u
> UST event ust_tests_hello:tptest disabled in channel channel0 for session hello
> lttng list hello
> Tracing session hello: [inactive]
>     Trace path: /root/lttng-traces/hello-20120621-074221
> 
> === Domain: UST global ===
> 
> Channels:
> -------------
> - channel0: [enabled]
> 
>     Attributes:
>       overwrite mode: 0
>       subbufers size: 4096
>       number of subbufers: 4
>       switch timer interval: 0
>       read timer interval: 200
>       output: mmap()
> 
>     Events:
>       ust_tests_hello:tptest (type: tracepoint) [disabled]
> 
> lttng start
> gdb ./hello
> (gdb) file .libs/hello
> (gdb) set env LTTNG_UST_DEBUG=1
> (gdb) show env
> ...
> LTTNG_UST_DEBUG=1
> (gdb) br main
> Breakpoint 1 at 0x80489b9: file hello.c, line 84.
> (gdb) r
> Starting program: /root/project/lttng/lttng-ust-2.0.2/tests/hello/.libs/hello 
> [Thread debugging using libthread_db enabled]
> liblttng_ust_tracepoint[3384/3384]: just registered a tracepoints section from 0xb7fddd64 and having 1 tracepoints (in tracepoint_register_lib() at tracepoint.c:638)
> liblttng_ust_tracepoint[3384/3384]: registered tracepoint: lttng_ust:metadata (in tracepoint_register_lib() at tracepoint.c:643)
> libust[3384/3384]: just registered probe lttng_ust containing 1 events (in ltt_probe_register() at ltt-probes.c:109)
> libust[3384/3384]: Registered event probe "lttng_ust:metadata" with signature "const char *, str" (in ltt_probe_register() at ltt-probes.c:118)
> libust[3384/3384]: LTT : ltt ring buffer client init
>  (in ltt_ring_buffer_metadata_client_init() at ltt-ring-buffer-metadata-client.h:334)
> libust[3384/3384]: LTT : ltt ring buffer client init
>  (in ltt_ring_buffer_client_overwrite_init() at ltt-ring-buffer-client.h:584)
> libust[3384/3384]: LTT : ltt ring buffer client init
>  (in ltt_ring_buffer_client_discard_init() at ltt-ring-buffer-client.h:584)
> [New Thread 0xb7dddb70 (LWP 3387)]
> [New Thread 0xb75dcb70 (LWP 3388)]
> libust[3384/3387]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:699)
> libust[3384/3387]: Waiting for local apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:621)
> libust[3384/3387]: Linux kernels 2.6.33 to 3.0 (with the exception of stable versions) do not support FUTEX_WAKE on read-only memory mappings correctly. Please upgrade your kernel (fix is commit 9ea71503a8ed9184d2d0b8ccc4d269d05f7940ae in Linux kernel mainline). LTTng-UST will use polling mode fallback. (in wait_for_sessiond() at lttng-ust-comm.c:634)
> libust[3384/3387]: Error: futex: Bad address (in wait_for_sessiond() at lttng-ust-comm.c:636)
> libust[3384/3387]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:699)
> libust[3384/3388]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3384/3388]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3384/3388]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3384/3388]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3384/3388]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3384/3388]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> liblttng_ust_tracepoint[3384/3388]: Registering probe to tracepoint lttng_ust:metadata (in __tracepoint_probe_register() at tracepoint.c:426)
> libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3384/3388]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3384/3388]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3384/3388]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3384/3388]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3384/3388]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3384/3388]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3384/3388]: message received
>  (in ust_listener_thread() at lttng-ust-comm.c:766)
> libust[3384/3388]: message successfully sent (in send_reply() at lttng-ust-comm.c:202)
> libust[3384/3384]: just registered probe ust_tests_hello containing 2 events (in ltt_probe_register() at ltt-probes.c:109)
> libust[3384/3384]: Registered event probe "ust_tests_hello:tptest" with signature "int, anint, int, netint, long *, values, char *, text, size_t, textlen, double, doublearg, float, floatarg" (in ltt_probe_register() at ltt-probes.c:118)
> liblttng_ust_tracepoint[3384/3384]: Registering probe to tracepoint ust_tests_hello:tptest (in __tracepoint_probe_register() at tracepoint.c:426)
> libust[3384/3384]: Registered event probe "ust_tests_hello:tptest_sighandler" with signature "" (in ltt_probe_register() at ltt-probes.c:118)
> liblttng_ust_tracepoint[3384/3384]: just registered a tracepoints section from 0x804b6c4 and having 2 tracepoints (in tracepoint_register_lib() at tracepoint.c:638)
> liblttng_ust_tracepoint[3384/3384]: registered tracepoint: ust_tests_hello:tptest_sighandler (in tracepoint_register_lib() at tracepoint.c:643)
> liblttng_ust_tracepoint[3384/3384]: registered tracepoint: ust_tests_hello:tptest (in tracepoint_register_lib() at tracepoint.c:643)
> 
> Breakpoint 1, main (argc=1, argv=0xbffff754) at hello.c:84
> 84              if (argc == 2)
> Missing separate debuginfos, use: debuginfo-install glibc-2.12-1.47.el6_2.12.i686 libuuid-2.17.2-12.4.el6.i686
> (gdb) p __tracepoint_ust_tests_hello___tptest
> $1 = {name = 0x804a380 "ust_tests_hello:tptest", state = 1, probes = 0x804c258, tracepoint_provider_ref = 0x804b724, 
>   signature = 0x8049240 "int, anint, int, netint, long *, values, char *, text, size_t, textlen, double, doublearg, float, floatarg", padding = '\000' <repeats 15 times>}
> 
> Here __tracepoint_ust_tests_hello___tptest.state and __tracepoint_ust_tests_hello___tptest.probes have been set, which means probe callback function wiil be called by API tracepoint. But the event has been disabled, is this necessary to call into the probe again? If this behavior is normal, what's suppoed to do with disable-event command? 
> 
> Any misunderstanding please fix me. Thanks

disabling an event ends up calling, in the program:

lttng-ust-abi.c:lttng_event_cmd() with "LTTNG_UST_DISABLE", which calls
ltt_event_disable(). Looking at this function:

int ltt_event_disable(struct ltt_event *event)
{
        int old;

        if (event->chan == event->chan->session->metadata)
                return -EPERM;
        old = uatomic_xchg(&event->enabled, 0);
        if (!old)
                return -EEXIST;
        return 0;
}

shows us that disabling an event sets the "enabled" flag within the
event (struct ltt_event) to 0. This flag is tested in
include/lttng/ust-tracepoint-event.h:

#undef TRACEPOINT_EVENT_CLASS
#define TRACEPOINT_EVENT_CLASS(_provider, _name, _args, _fields)  \
static void __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args))\
[...]
        if (caa_unlikely(!CMM_ACCESS_ONCE(__chan->session->active))) \
                return; \
        if (caa_unlikely(!CMM_ACCESS_ONCE(__chan->enabled))) \
                return; \
        if (caa_unlikely(!CMM_ACCESS_ONCE(__event->enabled))) \
                return;

What you are looking at with the debugger are the tracepoint call sites,
which still have a handler connected to them when you disable the event.
So yes, in theory, we could lessen the overhead of the enable followed
by disable case and ensure that we disconnect the probe from the call
site, but diminishing the performance impact of this rare use-case has
not been high on my priority list so far.

Hoping that my explanation helps clarifying things,

Thanks,

Mathieu

> 
> Best Regards
> Zheng
> 
> 
> > Thanks,
> > Mathieu
> > 
> > Thanks all for your useful info!
> > 
> > Best regards
> > Zheng
> > 
> > > > _______________________________________________
> > > > lttng-dev mailing list
> > > > lttng-dev@lists.lttng.org
> > > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
> > 
> > > -- 
> > > Mathieu Desnoyers
> > > Operating System Efficiency R&D Consultant
> > > EfficiOS Inc.
> > > http://www.efficios.com
> > 
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
> 
> > -- 
> > Mathieu Desnoyers
> > Operating System Efficiency R&D Consultant
> > EfficiOS Inc.
> > http://www.efficios.com
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
