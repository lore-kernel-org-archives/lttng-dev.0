From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Can't get any event output from the demo exe
Date: Mon, 16 Mar 2015 15:55:14 -0400
Message-ID: <55073522.6080006__16930.8860241019$1426535780$gmane$org@efficios.com>
References: <trinity-e73e3633-440b-429c-ad5e-bf48c3413989-1426531801924@3capp-gmx-bs44>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1YXb6g-0000Vf-4x
 for lttng-dev@lists.lttng.org; Mon, 16 Mar 2015 15:55:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CEE48340110
 for <lttng-dev@lists.lttng.org>; Mon, 16 Mar 2015 19:55:26 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 7cS5QK66DBxQ for <lttng-dev@lists.lttng.org>;
 Mon, 16 Mar 2015 19:55:26 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 272DA340232
 for <lttng-dev@lists.lttng.org>; Mon, 16 Mar 2015 19:55:26 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id pveqnTwAzsZi for <lttng-dev@lists.lttng.org>;
 Mon, 16 Mar 2015 19:55:26 +0000 (UTC)
Received: from [172.24.0.18] (cable-22.246.173-116.electronicbox.net
 [173.246.22.116])
 by mail.efficios.com (Postfix) with ESMTPSA id 8D5EA34022F
 for <lttng-dev@lists.lttng.org>; Mon, 16 Mar 2015 19:55:25 +0000 (UTC)
In-Reply-To: <trinity-e73e3633-440b-429c-ad5e-bf48c3413989-1426531801924@3capp-gmx-bs44>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Wolfgang,

See inline edit.

On 2015-03-16 02:50 PM, Wolfgang Rostek wrote:
> Hi group,
> I'm a bit frustrated not passing the hello world level.
> But I'm eager to get access to this nice tooling.
We'll make sure this happen :).

> For now I'm assuming problems in access rights or
> may be a 32/64bit library mismatch. Here my stackoverflow

On session creation you can use -o to specify an output PATH.

> post which wasn't responded. Hope I'll get a push here.
> thanks
> Wolfgang R.
> ========================================================
> LTTng at the very beginning
> just at step zero of using lttng but can't pass it. Hope a small hint 
> gives me a push.
> Trying the run the most simple demo of the distribution 
> lttng-ust/doc/examples/demo.

Okai so just to be sure I tested the demo and everything work as 
expected let's see what is missing on your side.
Did you build from source or you got binary from a package manager ?

> cat README
> ...
> The simplest command to trace the demo program are:
> lttng create
> lttng enable-event -u -a
> lttng start
> ./demo-trace
> lttng destroy
> That will create a trace in your $HOME/lttng-traces directory.
> ...
> Put my user lttng-sessiond in verbose mode and can talk to it. Here 
> the state when the demo-trace starts

What do you mean by talk to it?

> row@cobra7:/$ lttng list auto-20150313-091148
> Tracing session auto-20150313-091148: [active]
>     Trace path: /home/local/ESG_GMBH/row/lttng-traces/auto-20150313-091148
> === Domain: UST global ===
> Buffer type: per UID
> Channels:
> -------------
> - channel0: [enabled]
>     Attributes:
>       overwrite mode: 0
>       subbufers size: 131072
>       number of subbufers: 4
>       switch timer interval: 0
>       read timer interval: 0
>       output: mmap()
>     Events:
>       * (type: tracepoint) [enabled]

Looks fine so far.

> Executing the demo-trace shows no reaction in the daemon shell and no 
> output file created. Below the client log.
> I can't see any problem reported and don't know what to check next.

Are you sure you got nothing ? Try lttng view if you have babeltrace 
installed.
Also did you start the daemon in verbose mode ? Otherwise it is expected 
to have no output.

> thanks in advance for feedback
> Wolfgang R.
> row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo$ export 
> LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib

Any particuliar reason to do an export LD_LIBRARY_PATH?

> row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo$ ./demo-trace

If you want to have more time to test you might want to add a sleep() 
into the for loop in demo.c and put a higher loop threshold.
You will be able to test lttng list -u. Even if it looks like the events 
got registered, it is a good start to pinpoint the problem.
Also you can start the sessiond with -vvv for a more verbose mode as you 
probably know it.


Cheers!
> liblttng_ust_tracepoint[17268/17268]: just registered a tracepoints 
> section from 0xb754f780 and having 2 tracepoints (in 
> tracepoint_register_lib() at tracepoint.c:767)
> liblttng_ust_tracepoint[17268/17268]: registered tracepoint: 
> ust_baddr_statedump:soinfo (in tracepoint_register_lib() at 
> tracepoint.c:772)
> liblttng_ust_tracepoint[17268/17268]: registered tracepoint: 
> lttng_ust_tracef:event (in tracepoint_register_lib() at tracepoint.c:772)
> libust[17268/17268]: Provider "ust_baddr_statedump" accepted, version 
> 1.0 is compatible with LTTng UST provider version 1.0. (in 
> check_provider_version() at lttng-probes.c:174)
> libust[17268/17268]: adding probe ust_baddr_statedump containing 1 
> events to lazy registration list (in lttng_probe_register() at 
> lttng-probes.c:216)
> libust[17268/17268]: LTT : ltt ring buffer client 
> "relay-metadata-mmap" init
> (in lttng_ring_buffer_metadata_client_init() at 
> lttng-ring-buffer-metadata-client.h:330)
> libust[17268/17268]: LTT : ltt ring buffer client 
> "relay-overwrite-mmap" init
> (in lttng_ring_buffer_client_overwrite_init() at 
> lttng-ring-buffer-client.h:681)
> libust[17268/17268]: LTT : ltt ring buffer client 
> "relay-overwrite-rt-mmap" init
> (in lttng_ring_buffer_client_overwrite_rt_init() at 
> lttng-ring-buffer-client.h:681)
> libust[17268/17268]: LTT : ltt ring buffer client "relay-discard-mmap" 
> init
> (in lttng_ring_buffer_client_discard_init() at 
> lttng-ring-buffer-client.h:681)
> libust[17268/17268]: LTT : ltt ring buffer client 
> "relay-discard-rt-mmap" init
> (in lttng_ring_buffer_client_discard_rt_init() at 
> lttng-ring-buffer-client.h:681)
> libust[17268/17269]: Info: sessiond not accepting connections to 
> global apps socket (in ust_listener_thread() at lttng-ust-comm.c:1221)
> libust[17268/17269]: Waiting for global apps sessiond (in 
> wait_for_sessiond() at lttng-ust-comm.c:1132)
> libust[17268/17270]: Info: sessiond not accepting connections to local 
> apps socket (in ust_listener_thread() at lttng-ust-comm.c:1221)
> libust[17268/17270]: Waiting for local apps sessiond (in 
> wait_for_sessiond() at lttng-ust-comm.c:1132)
> libust[17268/17268]: Provider "lttng_ust_tracef" accepted, version 1.0 
> is compatible with LTTng UST provider version 1.0. (in 
> check_provider_version() at lttng-probes.c:174)
> libust[17268/17268]: just registered probe ust_baddr_statedump 
> containing 1 events (in lttng_lazy_probe_register() at lttng-probes.c:115)
> libust[17268/17268]: adding probe lttng_ust_tracef containing 1 events 
> to lazy registration list (in lttng_probe_register() at 
> lttng-probes.c:216)
> libust[17268/17268]: Provider "ust_tests_demo3" accepted, version 1.0 
> is compatible with LTTng UST provider version 1.0. (in 
> check_provider_version() at lttng-probes.c:174)
> libust[17268/17268]: just registered probe lttng_ust_tracef containing 
> 1 events (in lttng_lazy_probe_register() at lttng-probes.c:115)
> libust[17268/17268]: adding probe ust_tests_demo3 containing 1 events 
> to lazy registration list (in lttng_probe_register() at 
> lttng-probes.c:216)
> libust[17268/17268]: Provider "ust_tests_demo" accepted, version 1.0 
> is compatible with LTTng UST provider version 1.0. (in 
> check_provider_version() at lttng-probes.c:174)
> libust[17268/17268]: just registered probe ust_tests_demo3 containing 
> 1 events (in lttng_lazy_probe_register() at lttng-probes.c:115)
> libust[17268/17268]: adding probe ust_tests_demo containing 2 events 
> to lazy registration list (in lttng_probe_register() at 
> lttng-probes.c:216)
> libust[17268/17268]: Provider "ust_tests_demo2" accepted, version 1.0 
> is compatible with LTTng UST provider version 1.0. (in 
> check_provider_version() at lttng-probes.c:174)
> libust[17268/17268]: just registered probe ust_tests_demo containing 2 
> events (in lttng_lazy_probe_register() at lttng-probes.c:115)
> libust[17268/17268]: adding probe ust_tests_demo2 containing 1 events 
> to lazy registration list (in lttng_probe_register() at 
> lttng-probes.c:216)
> liblttng_ust_tracepoint[17268/17268]: just registered a tracepoints 
> section from 0x804b144 and having 4 tracepoints (in 
> tracepoint_register_lib() at tracepoint.c:767)
> liblttng_ust_tracepoint[17268/17268]: registered tracepoint: 
> ust_tests_demo:starting (in tracepoint_register_lib() at tracepoint.c:772)
> liblttng_ust_tracepoint[17268/17268]: registered tracepoint: 
> ust_tests_demo:done (in tracepoint_register_lib() at tracepoint.c:772)
> liblttng_ust_tracepoint[17268/17268]: registered tracepoint: 
> ust_tests_demo2:loop (in tracepoint_register_lib() at tracepoint.c:772)
> liblttng_ust_tracepoint[17268/17268]: registered tracepoint: 
> ust_tests_demo3:done (in tracepoint_register_lib() at tracepoint.c:772)
> Demo program starting.
> Tracing...  done.
> liblttng_ust_tracepoint[17268/17268]: just unregistered a tracepoints 
> section from 0x804b144 (in tracepoint_unregister_lib() at 
> tracepoint.c:797)
> libust[17268/17268]: Provider "ust_tests_demo2" accepted, version 1.0 
> is compatible with LTTng UST provider version 1.0. (in 
> check_provider_version() at lttng-probes.c:174)
> libust[17268/17268]: just unregistered probe ust_tests_demo2 (in 
> lttng_probe_unregister() at lttng-probes.c:245)
> libust[17268/17268]: Provider "ust_tests_demo" accepted, version 1.0 
> is compatible with LTTng UST provider version 1.0. (in 
> check_provider_version() at lttng-probes.c:174)
> libust[17268/17268]: just unregistered probe ust_tests_demo (in 
> lttng_probe_unregister() at lttng-probes.c:245)
> libust[17268/17268]: Provider "ust_tests_demo3" accepted, version 1.0 
> is compatible with LTTng UST provider version 1.0. (in 
> check_provider_version() at lttng-probes.c:174)
> libust[17268/17268]: just unregistered probe ust_tests_demo3 (in 
> lttng_probe_unregister() at lttng-probes.c:245)
> libust[17268/17268]: Provider "lttng_ust_tracef" accepted, version 1.0 
> is compatible with LTTng UST provider version 1.0. (in 
> check_provider_version() at lttng-probes.c:174)
> libust[17268/17268]: just unregistered probe lttng_ust_tracef (in 
> lttng_probe_unregister() at lttng-probes.c:245)
> libust[17268/17268]: LTT : ltt ring buffer client 
> "relay-discard-rt-mmap" exit
> (in lttng_ring_buffer_client_discard_rt_exit() at 
> lttng-ring-buffer-client.h:688)
> libust[17268/17268]: LTT : ltt ring buffer client "relay-discard-mmap" 
> exit
> (in lttng_ring_buffer_client_discard_exit() at 
> lttng-ring-buffer-client.h:688)
> libust[17268/17268]: LTT : ltt ring buffer client 
> "relay-overwrite-rt-mmap" exit
> (in lttng_ring_buffer_client_overwrite_rt_exit() at 
> lttng-ring-buffer-client.h:688)
> libust[17268/17268]: LTT : ltt ring buffer client 
> "relay-overwrite-mmap" exit
> (in lttng_ring_buffer_client_overwrite_exit() at 
> lttng-ring-buffer-client.h:688)
> libust[17268/17268]: LTT : ltt ring buffer client 
> "relay-metadata-mmap" exit
> (in lttng_ring_buffer_metadata_client_exit() at 
> lttng-ring-buffer-metadata-client.h:337)
> libust[17268/17268]: Provider "ust_baddr_statedump" accepted, version 
> 1.0 is compatible with LTTng UST provider version 1.0. (in 
> check_provider_version() at lttng-probes.c:174)
> libust[17268/17268]: just unregistered probe ust_baddr_statedump (in 
> lttng_probe_unregister() at lttng-probes.c:245)
> liblttng_ust_tracepoint[17268/17268]: just unregistered a tracepoints 
> section from 0xb754f780 (in tracepoint_unregister_lib() at 
> tracepoint.c:797)
> row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo$
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan R. Julien
Efficios
