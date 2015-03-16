From: "Wolfgang Rostek" <wolfgang.rostek@gmx.de>
Subject: Can't get any event output from the demo exe
Date: Mon, 16 Mar 2015 19:50:02 +0100
Message-ID: <trinity-e73e3633-440b-429c-ad5e-bf48c3413989-1426531801924__1993.20543692938$1426531885$gmane$org@3capp-gmx-bs44>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0707558296=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.15.15])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wolfgang.rostek@gmx.de>) id 1YXa5Z-0000AI-8p
 for lttng-dev@lists.lttng.org; Mon, 16 Mar 2015 14:50:11 -0400
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

--===============0707558296==
Content-Type: text/html; charset=UTF-8

<html><head></head><body><div style="font-family: Verdana;font-size: 12.0px;"><div>
<div>Hi group,</div>

<div>&nbsp;</div>

<div>I&#39;m a bit frustrated not passing the hello world level.<br/>
But I&#39;m eager to get access to this nice tooling.</div>

<div>&nbsp;</div>

<div>For now I&#39;m assuming problems in access rights or<br/>
may be a 32/64bit library mismatch. Here my stackoverflow<br/>
post which wasn&#39;t responded. Hope I&#39;ll get a push here.</div>

<div>&nbsp;</div>

<div>thanks<br/>
Wolfgang R.</div>

<div>&nbsp;</div>

<div>========================================================</div>

<div>LTTng at the very beginning</div>

<div>&nbsp;</div>

<div>just at step zero of using lttng but can&#39;t pass it. Hope a small hint gives me a push.</div>

<div>Trying the run the most simple demo of the distribution lttng-ust/doc/examples/demo.</div>

<div>&nbsp;</div>

<div>cat README<br/>
...<br/>
The simplest command to trace the demo program are:<br/>
lttng create<br/>
lttng enable-event -u -a<br/>
lttng start<br/>
./demo-trace<br/>
lttng destroy<br/>
That will create a trace in your &#36;HOME/lttng-traces directory.<br/>
...</div>

<div>Put my user lttng-sessiond in verbose mode and can talk to it. Here the state when the demo-trace starts</div>

<div>row@cobra7:/&#36; lttng list auto-20150313-091148<br/>
Tracing session auto-20150313-091148: [active]<br/>
&nbsp;&nbsp;&nbsp; Trace path: /home/local/ESG_GMBH/row/lttng-traces/auto-20150313-091148</div>

<div>=== Domain: UST global ===</div>

<div>Buffer type: per UID</div>

<div>Channels:<br/>
-------------<br/>
- channel0: [enabled]</div>

<div>&nbsp;&nbsp;&nbsp; Attributes:<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; overwrite mode: 0<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; subbufers size: 131072<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; number of subbufers: 4<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch timer interval: 0<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read timer interval: 0<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output: mmap()</div>

<div>&nbsp;&nbsp;&nbsp; Events:<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (type: tracepoint) [enabled]</div>

<div>&nbsp;</div>

<div>Executing the demo-trace shows no reaction in the daemon shell and no output file created. Below the client log.</div>

<div>I can&#39;t see any problem reported and don&#39;t know what to check next.</div>

<div>&nbsp;</div>

<div>thanks in advance for feedback</div>

<div>Wolfgang R.</div>

<div>&nbsp;</div>

<div>row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo&#36; export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib</div>

<div>row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo&#36; ./demo-trace<br/>
liblttng_ust_tracepoint[17268/17268]: just registered a tracepoints section from 0xb754f780 and having 2 tracepoints (in tracepoint_register_lib() at tracepoint.c:767)<br/>
liblttng_ust_tracepoint[17268/17268]: registered tracepoint: ust_baddr_statedump:soinfo (in tracepoint_register_lib() at tracepoint.c:772)<br/>
liblttng_ust_tracepoint[17268/17268]: registered tracepoint: lttng_ust_tracef:event (in tracepoint_register_lib() at tracepoint.c:772)<br/>
libust[17268/17268]: Provider &quot;ust_baddr_statedump&quot; accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:174)<br/>
libust[17268/17268]: adding probe ust_baddr_statedump containing 1 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:216)<br/>
libust[17268/17268]: LTT : ltt ring buffer client &quot;relay-metadata-mmap&quot; init<br/>
(in lttng_ring_buffer_metadata_client_init() at lttng-ring-buffer-metadata-client.h:330)<br/>
libust[17268/17268]: LTT : ltt ring buffer client &quot;relay-overwrite-mmap&quot; init<br/>
(in lttng_ring_buffer_client_overwrite_init() at lttng-ring-buffer-client.h:681)<br/>
libust[17268/17268]: LTT : ltt ring buffer client &quot;relay-overwrite-rt-mmap&quot; init<br/>
(in lttng_ring_buffer_client_overwrite_rt_init() at lttng-ring-buffer-client.h:681)<br/>
libust[17268/17268]: LTT : ltt ring buffer client &quot;relay-discard-mmap&quot; init<br/>
(in lttng_ring_buffer_client_discard_init() at lttng-ring-buffer-client.h:681)<br/>
libust[17268/17268]: LTT : ltt ring buffer client &quot;relay-discard-rt-mmap&quot; init<br/>
(in lttng_ring_buffer_client_discard_rt_init() at lttng-ring-buffer-client.h:681)<br/>
libust[17268/17269]: Info: sessiond not accepting connections to global apps socket (in ust_listener_thread() at lttng-ust-comm.c:1221)<br/>
libust[17268/17269]: Waiting for global apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:1132)<br/>
libust[17268/17270]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:1221)<br/>
libust[17268/17270]: Waiting for local apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:1132)<br/>
libust[17268/17268]: Provider &quot;lttng_ust_tracef&quot; accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:174)<br/>
libust[17268/17268]: just registered probe ust_baddr_statedump containing 1 events (in lttng_lazy_probe_register() at lttng-probes.c:115)<br/>
libust[17268/17268]: adding probe lttng_ust_tracef containing 1 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:216)<br/>
libust[17268/17268]: Provider &quot;ust_tests_demo3&quot; accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:174)<br/>
libust[17268/17268]: just registered probe lttng_ust_tracef containing 1 events (in lttng_lazy_probe_register() at lttng-probes.c:115)<br/>
libust[17268/17268]: adding probe ust_tests_demo3 containing 1 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:216)<br/>
libust[17268/17268]: Provider &quot;ust_tests_demo&quot; accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:174)<br/>
libust[17268/17268]: just registered probe ust_tests_demo3 containing 1 events (in lttng_lazy_probe_register() at lttng-probes.c:115)<br/>
libust[17268/17268]: adding probe ust_tests_demo containing 2 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:216)<br/>
libust[17268/17268]: Provider &quot;ust_tests_demo2&quot; accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:174)<br/>
libust[17268/17268]: just registered probe ust_tests_demo containing 2 events (in lttng_lazy_probe_register() at lttng-probes.c:115)<br/>
libust[17268/17268]: adding probe ust_tests_demo2 containing 1 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:216)<br/>
liblttng_ust_tracepoint[17268/17268]: just registered a tracepoints section from 0x804b144 and having 4 tracepoints (in tracepoint_register_lib() at tracepoint.c:767)<br/>
liblttng_ust_tracepoint[17268/17268]: registered tracepoint: ust_tests_demo:starting (in tracepoint_register_lib() at tracepoint.c:772)<br/>
liblttng_ust_tracepoint[17268/17268]: registered tracepoint: ust_tests_demo:done (in tracepoint_register_lib() at tracepoint.c:772)<br/>
liblttng_ust_tracepoint[17268/17268]: registered tracepoint: ust_tests_demo2:loop (in tracepoint_register_lib() at tracepoint.c:772)<br/>
liblttng_ust_tracepoint[17268/17268]: registered tracepoint: ust_tests_demo3:done (in tracepoint_register_lib() at tracepoint.c:772)<br/>
Demo program starting.<br/>
Tracing...&nbsp; done.<br/>
liblttng_ust_tracepoint[17268/17268]: just unregistered a tracepoints section from 0x804b144 (in tracepoint_unregister_lib() at tracepoint.c:797)<br/>
libust[17268/17268]: Provider &quot;ust_tests_demo2&quot; accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:174)<br/>
libust[17268/17268]: just unregistered probe ust_tests_demo2 (in lttng_probe_unregister() at lttng-probes.c:245)<br/>
libust[17268/17268]: Provider &quot;ust_tests_demo&quot; accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:174)<br/>
libust[17268/17268]: just unregistered probe ust_tests_demo (in lttng_probe_unregister() at lttng-probes.c:245)<br/>
libust[17268/17268]: Provider &quot;ust_tests_demo3&quot; accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:174)<br/>
libust[17268/17268]: just unregistered probe ust_tests_demo3 (in lttng_probe_unregister() at lttng-probes.c:245)<br/>
libust[17268/17268]: Provider &quot;lttng_ust_tracef&quot; accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:174)<br/>
libust[17268/17268]: just unregistered probe lttng_ust_tracef (in lttng_probe_unregister() at lttng-probes.c:245)<br/>
libust[17268/17268]: LTT : ltt ring buffer client &quot;relay-discard-rt-mmap&quot; exit<br/>
(in lttng_ring_buffer_client_discard_rt_exit() at lttng-ring-buffer-client.h:688)<br/>
libust[17268/17268]: LTT : ltt ring buffer client &quot;relay-discard-mmap&quot; exit<br/>
(in lttng_ring_buffer_client_discard_exit() at lttng-ring-buffer-client.h:688)<br/>
libust[17268/17268]: LTT : ltt ring buffer client &quot;relay-overwrite-rt-mmap&quot; exit<br/>
(in lttng_ring_buffer_client_overwrite_rt_exit() at lttng-ring-buffer-client.h:688)<br/>
libust[17268/17268]: LTT : ltt ring buffer client &quot;relay-overwrite-mmap&quot; exit<br/>
(in lttng_ring_buffer_client_overwrite_exit() at lttng-ring-buffer-client.h:688)<br/>
libust[17268/17268]: LTT : ltt ring buffer client &quot;relay-metadata-mmap&quot; exit<br/>
(in lttng_ring_buffer_metadata_client_exit() at lttng-ring-buffer-metadata-client.h:337)<br/>
libust[17268/17268]: Provider &quot;ust_baddr_statedump&quot; accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:174)<br/>
libust[17268/17268]: just unregistered probe ust_baddr_statedump (in lttng_probe_unregister() at lttng-probes.c:245)<br/>
liblttng_ust_tracepoint[17268/17268]: just unregistered a tracepoints section from 0xb754f780 (in tracepoint_unregister_lib() at tracepoint.c:797)<br/>
row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo&#36;</div>
</div></div></body></html>


--===============0707558296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0707558296==--
