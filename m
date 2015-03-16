From: "Wolfgang Rostek" <wolfgang.rostek@gmx.de>
Subject: Fw: Re:  Can't get any event output from the demo exe
Date: Mon, 16 Mar 2015 22:37:04 +0100
Message-ID: <trinity-20b4d7f8-34f5-4cb7-87e9-476f750de2a9-1426541824600__17983.4800809205$1426541890$gmane$org@3capp-gmx-bs08>
References: <trinity-e73e3633-440b-429c-ad5e-bf48c3413989-1426531801924@3capp-gmx-bs44>,
 <55073522.6080006@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0843517383=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.17.21])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wolfgang.rostek@gmx.de>) id 1YXchC-00012O-JT
 for lttng-dev@lists.lttng.org; Mon, 16 Mar 2015 17:37:13 -0400
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

--===============0843517383==
Content-Type: text/html; charset=UTF-8

<html><head></head><body><div style="font-family: Verdana;font-size: 12.0px;"><div>
<div>
<div>Hi Jonathan,</div>

<div>&nbsp;</div>

<div>thanks, that was quick. Hope formatting works as<br/>
I just see that Internet formatting can&#39;t be done<br/>
by this account. Have to do it by hand.</div>

<div>&nbsp;</div>

<div>I&#39;m no longer in the office so for more details<br/>
I&#39;ve to sit in front of the machine tomorrow.</div>

<div><br/>
But ok some more infos I can provide.</div>

<div>&nbsp;</div>

<div>see below</div>

<div>&nbsp;</div>

<div>thanks<br/>
Wolfgang R.</div>

<div><br/>
&gt; Hi Wolfgang,<br/>
&gt;<br/>
&gt; See inline edit.<br/>
&gt;<br/>
&gt; On 2015-03-16 02:50 PM, Wolfgang Rostek wrote:<br/>
&gt; &gt; Hi group,<br/>
&gt; &gt; I&#39;m a bit frustrated not passing the hello world level.<br/>
&gt; &gt; But I&#39;m eager to get access to this nice tooling.<br/>
&gt; We&#39;ll make sure this happen :).<br/>
fine</div>

<div>&nbsp;</div>

<div>&gt;<br/>
&gt; &gt; For now I&#39;m assuming problems in access rights or<br/>
&gt; &gt; may be a 32/64bit library mismatch. Here my stackoverflow<br/>
&gt;<br/>
&gt; On session creation you can use -o to specify an output PATH.<br/>
The path reported seemed ok and was pointing to the default<br/>
below &#36;HOME (see below). But no directory lltng-traces did appear.</div>

<div>&nbsp;</div>

<div>&gt;<br/>
&gt; &gt; post which wasn&#39;t responded. Hope I&#39;ll get a push here.<br/>
&gt; &gt; thanks<br/>
&gt; &gt; Wolfgang R.<br/>
&gt; &gt; ========================================================<br/>
&gt; &gt; LTTng at the very beginning<br/>
&gt; &gt; just at step zero of using lttng but can&#39;t pass it. Hope a small hint<br/>
&gt; &gt; gives me a push.<br/>
&gt; &gt; Trying the run the most simple demo of the distribution<br/>
&gt; &gt; lttng-ust/doc/examples/demo.<br/>
&gt;<br/>
&gt; Okai so just to be sure I tested the demo and everything work as<br/>
&gt; expected let&#39;s see what is missing on your side.<br/>
&gt; Did you build from source or you got binary from a package manager ?<br/>
I build from source and the demo directory creates the libs and the exe.</div>

<div>&nbsp;</div>

<div>&gt;<br/>
&gt; &gt; cat README<br/>
&gt; &gt; ...<br/>
&gt; &gt; The simplest command to trace the demo program are:<br/>
&gt; &gt; lttng create<br/>
&gt; &gt; lttng enable-event -u -a<br/>
&gt; &gt; lttng start<br/>
&gt; &gt; ./demo-trace<br/>
&gt; &gt; lttng destroy<br/>
&gt; &gt; That will create a trace in your &#36;HOME/lttng-traces directory.<br/>
&gt; &gt; ...<br/>
&gt; &gt; Put my user lttng-sessiond in verbose mode and can talk to it. Here<br/>
&gt; &gt; the state when the demo-trace starts<br/>
&gt;<br/>
&gt; What do you mean by talk to it?<br/>
When starting the sessiond under my user in foreground and verbose I can<br/>
see that it is tracing for the above commands. The exception is ./demo-trace<br/>
which doesn&#39;t show any reaction in the sessiond shell.</div>

<div>&nbsp;</div>

<div>&gt;<br/>
&gt; &gt; row@cobra7:/&#36; lttng list auto-20150313-091148<br/>
&gt; &gt; Tracing session auto-20150313-091148: [active]<br/>
&gt; &gt; Trace path: /home/local/ESG_GMBH/row/lttng-traces/auto-20150313-091148<br/>
&gt; &gt; === Domain: UST global ===<br/>
&gt; &gt; Buffer type: per UID<br/>
&gt; &gt; Channels:<br/>
&gt; &gt; -------------<br/>
&gt; &gt; - channel0: [enabled]<br/>
&gt; &gt; Attributes:<br/>
&gt; &gt; overwrite mode: 0<br/>
&gt; &gt; subbufers size: 131072<br/>
&gt; &gt; number of subbufers: 4<br/>
&gt; &gt; switch timer interval: 0<br/>
&gt; &gt; read timer interval: 0<br/>
&gt; &gt; output: mmap()<br/>
&gt; &gt; Events:<br/>
&gt; &gt; * (type: tracepoint) [enabled]<br/>
&gt; &gt;<br/>
&gt; Looks fine so far.<br/>
&gt;<br/>
&gt; &gt; Executing the demo-trace shows no reaction in the daemon shell and no<br/>
&gt; &gt; output file created. Below the client log.<br/>
&gt; &gt; I can&#39;t see any problem reported and don&#39;t know what to check next.<br/>
&gt; &gt;<br/>
&gt; Are you sure you got nothing ? Try lttng view if you have babeltrace<br/>
&gt; installed.<br/>
Hmm, will try it tomorrow. I thought I redirected output to /tmp for test but nothing<br/>
has been created there as well.</div>

<div>&nbsp;</div>

<div>&gt; Also did you start the daemon in verbose mode ? Otherwise it is expected<br/>
&gt; to have no output.<br/>
yes, see above</div>

<div>&nbsp;</div>

<div>&gt; &gt;<br/>
&gt; &gt; thanks in advance for feedback<br/>
&gt; &gt; Wolfgang R.<br/>
&gt; &gt; row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo&#36; export<br/>
&gt; &gt; LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib<br/>
&gt;<br/>
&gt; Any particuliar reason to do an export LD_LIBRARY_PATH?<br/>
Without this it didn&#39;t find the lttng .so lib. Don&#39;t have the details here.</div>

<div>&nbsp;</div>

<div>&gt;<br/>
&gt; &gt; row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo&#36; ./demo-trace<br/>
&gt; &gt;<br/>
&gt; If you want to have more time to test you might want to add a sleep()<br/>
&gt; into the for loop in demo.c and put a higher loop threshold.<br/>
I can try that.</div>

<div>&gt; You will be able to test lttng list -u. Even if it looks like the events<br/>
&gt; got registered, it is a good start to pinpoint the problem.<br/>
&gt; Also you can start the sessiond with -vvv for a more verbose mode as you<br/>
&gt; probably know it.<br/>
The only thing I saw was the warning for not being able for the demo<br/>
to open two sockets. But from what I&#39;ve read in the forum that might be<br/>
not mandatory.</div>

<div>...</div>

<div>Info: sessiond not accepting connections to local...</div>

<div>...</div>

<div>&nbsp;</div>

<div>I was wondering that in verbose mode the client was not able to pin point<br/>
to a problem. This was not verbose ;)</div>

<div><br/>
&gt;<br/>
&gt;<br/>
&gt; Cheers!<br/>
&gt; &gt; liblttng_ust_tracepoint[17268/17268]: just registered a tracepoints<br/>
&gt; &gt; section from 0xb754f780 and having 2 tracepoints (in<br/>
&gt; &gt; tracepoint_register_lib() at tracepoint.c:767)<br/>
&gt; &gt; liblttng_ust_tracepoint[17268/17268]: registered tracepoint:<br/>
&gt; &gt; ust_baddr_statedump:soinfo (in tracepoint_register_lib() at<br/>
&gt; &gt; tracepoint.c:772)<br/>
&gt; &gt; liblttng_ust_tracepoint[17268/17268]: registered tracepoint:<br/>
&gt; &gt; lttng_ust_tracef:event (in tracepoint_register_lib() at tracepoint.c:772)<br/>
&gt; &gt; libust[17268/17268]: Provider &quot;ust_baddr_statedump&quot; accepted, version<br/>
&gt; &gt; 1.0 is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; &gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; &gt; libust[17268/17268]: adding probe ust_baddr_statedump containing 1<br/>
&gt; &gt; events to lazy registration list (in lttng_probe_register() at<br/>
&gt; &gt; lttng-probes.c:216)<br/>
&gt; &gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &gt; &quot;relay-metadata-mmap&quot; init<br/>
&gt; &gt; (in lttng_ring_buffer_metadata_client_init() at<br/>
&gt; &gt; lttng-ring-buffer-metadata-client.h:330)<br/>
&gt; &gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &gt; &quot;relay-overwrite-mmap&quot; init<br/>
&gt; &gt; (in lttng_ring_buffer_client_overwrite_init() at<br/>
&gt; &gt; lttng-ring-buffer-client.h:681)<br/>
&gt; &gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &gt; &quot;relay-overwrite-rt-mmap&quot; init<br/>
&gt; &gt; (in lttng_ring_buffer_client_overwrite_rt_init() at<br/>
&gt; &gt; lttng-ring-buffer-client.h:681)<br/>
&gt; &gt; libust[17268/17268]: LTT : ltt ring buffer client &quot;relay-discard-mmap&quot;<br/>
&gt; &gt; init<br/>
&gt; &gt; (in lttng_ring_buffer_client_discard_init() at<br/>
&gt; &gt; lttng-ring-buffer-client.h:681)<br/>
&gt; &gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &gt; &quot;relay-discard-rt-mmap&quot; init<br/>
&gt; &gt; (in lttng_ring_buffer_client_discard_rt_init() at<br/>
&gt; &gt; lttng-ring-buffer-client.h:681)<br/>
&gt; &gt; libust[17268/17269]: Info: sessiond not accepting connections to<br/>
&gt; &gt; global apps socket (in ust_listener_thread() at lttng-ust-comm.c:1221)<br/>
&gt; &gt; libust[17268/17269]: Waiting for global apps sessiond (in<br/>
&gt; &gt; wait_for_sessiond() at lttng-ust-comm.c:1132)<br/>
&gt; &gt; libust[17268/17270]: Info: sessiond not accepting connections to local<br/>
&gt; &gt; apps socket (in ust_listener_thread() at lttng-ust-comm.c:1221)<br/>
&gt; &gt; libust[17268/17270]: Waiting for local apps sessiond (in<br/>
&gt; &gt; wait_for_sessiond() at lttng-ust-comm.c:1132)<br/>
&gt; &gt; libust[17268/17268]: Provider &quot;lttng_ust_tracef&quot; accepted, version 1.0<br/>
&gt; &gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; &gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; &gt; libust[17268/17268]: just registered probe ust_baddr_statedump<br/>
&gt; &gt; containing 1 events (in lttng_lazy_probe_register() at lttng-probes.c:115)<br/>
&gt; &gt; libust[17268/17268]: adding probe lttng_ust_tracef containing 1 events<br/>
&gt; &gt; to lazy registration list (in lttng_probe_register() at<br/>
&gt; &gt; lttng-probes.c:216)<br/>
&gt; &gt; libust[17268/17268]: Provider &quot;ust_tests_demo3&quot; accepted, version 1.0<br/>
&gt; &gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; &gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; &gt; libust[17268/17268]: just registered probe lttng_ust_tracef containing<br/>
&gt; &gt; 1 events (in lttng_lazy_probe_register() at lttng-probes.c:115)<br/>
&gt; &gt; libust[17268/17268]: adding probe ust_tests_demo3 containing 1 events<br/>
&gt; &gt; to lazy registration list (in lttng_probe_register() at<br/>
&gt; &gt; lttng-probes.c:216)<br/>
&gt; &gt; libust[17268/17268]: Provider &quot;ust_tests_demo&quot; accepted, version 1.0<br/>
&gt; &gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; &gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; &gt; libust[17268/17268]: just registered probe ust_tests_demo3 containing<br/>
&gt; &gt; 1 events (in lttng_lazy_probe_register() at lttng-probes.c:115)<br/>
&gt; &gt; libust[17268/17268]: adding probe ust_tests_demo containing 2 events<br/>
&gt; &gt; to lazy registration list (in lttng_probe_register() at<br/>
&gt; &gt; lttng-probes.c:216)<br/>
&gt; &gt; libust[17268/17268]: Provider &quot;ust_tests_demo2&quot; accepted, version 1.0<br/>
&gt; &gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; &gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; &gt; libust[17268/17268]: just registered probe ust_tests_demo containing 2<br/>
&gt; &gt; events (in lttng_lazy_probe_register() at lttng-probes.c:115)<br/>
&gt; &gt; libust[17268/17268]: adding probe ust_tests_demo2 containing 1 events<br/>
&gt; &gt; to lazy registration list (in lttng_probe_register() at<br/>
&gt; &gt; lttng-probes.c:216)<br/>
&gt; &gt; liblttng_ust_tracepoint[17268/17268]: just registered a tracepoints<br/>
&gt; &gt; section from 0x804b144 and having 4 tracepoints (in<br/>
&gt; &gt; tracepoint_register_lib() at tracepoint.c:767)<br/>
&gt; &gt; liblttng_ust_tracepoint[17268/17268]: registered tracepoint:<br/>
&gt; &gt; ust_tests_demo:starting (in tracepoint_register_lib() at tracepoint.c:772)<br/>
&gt; &gt; liblttng_ust_tracepoint[17268/17268]: registered tracepoint:<br/>
&gt; &gt; ust_tests_demo:done (in tracepoint_register_lib() at tracepoint.c:772)<br/>
&gt; &gt; liblttng_ust_tracepoint[17268/17268]: registered tracepoint:<br/>
&gt; &gt; ust_tests_demo2:loop (in tracepoint_register_lib() at tracepoint.c:772)<br/>
&gt; &gt; liblttng_ust_tracepoint[17268/17268]: registered tracepoint:<br/>
&gt; &gt; ust_tests_demo3:done (in tracepoint_register_lib() at tracepoint.c:772)<br/>
&gt; &gt; Demo program starting.<br/>
&gt; &gt; Tracing... done.<br/>
&gt; &gt; liblttng_ust_tracepoint[17268/17268]: just unregistered a tracepoints<br/>
&gt; &gt; section from 0x804b144 (in tracepoint_unregister_lib() at<br/>
&gt; &gt; tracepoint.c:797)<br/>
&gt; &gt; libust[17268/17268]: Provider &quot;ust_tests_demo2&quot; accepted, version 1.0<br/>
&gt; &gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; &gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; &gt; libust[17268/17268]: just unregistered probe ust_tests_demo2 (in<br/>
&gt; &gt; lttng_probe_unregister() at lttng-probes.c:245)<br/>
&gt; &gt; libust[17268/17268]: Provider &quot;ust_tests_demo&quot; accepted, version 1.0<br/>
&gt; &gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; &gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; &gt; libust[17268/17268]: just unregistered probe ust_tests_demo (in<br/>
&gt; &gt; lttng_probe_unregister() at lttng-probes.c:245)<br/>
&gt; &gt; libust[17268/17268]: Provider &quot;ust_tests_demo3&quot; accepted, version 1.0<br/>
&gt; &gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; &gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; &gt; libust[17268/17268]: just unregistered probe ust_tests_demo3 (in<br/>
&gt; &gt; lttng_probe_unregister() at lttng-probes.c:245)<br/>
&gt; &gt; libust[17268/17268]: Provider &quot;lttng_ust_tracef&quot; accepted, version 1.0<br/>
&gt; &gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; &gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; &gt; libust[17268/17268]: just unregistered probe lttng_ust_tracef (in<br/>
&gt; &gt; lttng_probe_unregister() at lttng-probes.c:245)<br/>
&gt; &gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &gt; &quot;relay-discard-rt-mmap&quot; exit<br/>
&gt; &gt; (in lttng_ring_buffer_client_discard_rt_exit() at<br/>
&gt; &gt; lttng-ring-buffer-client.h:688)<br/>
&gt; &gt; libust[17268/17268]: LTT : ltt ring buffer client &quot;relay-discard-mmap&quot;<br/>
&gt; &gt; exit<br/>
&gt; &gt; (in lttng_ring_buffer_client_discard_exit() at<br/>
&gt; &gt; lttng-ring-buffer-client.h:688)<br/>
&gt; &gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &gt; &quot;relay-overwrite-rt-mmap&quot; exit<br/>
&gt; &gt; (in lttng_ring_buffer_client_overwrite_rt_exit() at<br/>
&gt; &gt; lttng-ring-buffer-client.h:688)<br/>
&gt; &gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &gt; &quot;relay-overwrite-mmap&quot; exit<br/>
&gt; &gt; (in lttng_ring_buffer_client_overwrite_exit() at<br/>
&gt; &gt; lttng-ring-buffer-client.h:688)<br/>
&gt; &gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &gt; &quot;relay-metadata-mmap&quot; exit<br/>
&gt; &gt; (in lttng_ring_buffer_metadata_client_exit() at<br/>
&gt; &gt; lttng-ring-buffer-metadata-client.h:337)<br/>
&gt; &gt; libust[17268/17268]: Provider &quot;ust_baddr_statedump&quot; accepted, version<br/>
&gt; &gt; 1.0 is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; &gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; &gt; libust[17268/17268]: just unregistered probe ust_baddr_statedump (in<br/>
&gt; &gt; lttng_probe_unregister() at lttng-probes.c:245)<br/>
&gt; &gt; liblttng_ust_tracepoint[17268/17268]: just unregistered a tracepoints<br/>
&gt; &gt; section from 0xb754f780 (in tracepoint_unregister_lib() at<br/>
&gt; &gt; tracepoint.c:797)<br/>
&gt; &gt; row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo&#36;<br/>
&gt; &gt;<br/>
&gt;<br/>
&gt; _______________________________________________<br/>
&gt; lttng-dev mailing list<br/>
&gt; lttng-dev@lists.lttng.org<br/>
&gt; http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br/>
&gt;<br/>
&gt; --<br/>
&gt; Jonathan R. Julien<br/>
&gt; Efficios</div>
</div>
</div></div></body></html>


--===============0843517383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0843517383==--
