From: "Wolfgang Rostek" <wolfgang.rostek@gmx.de>
Subject: Fw: Re:  Can't get any event output from the demo exe
Date: Tue, 17 Mar 2015 08:31:46 +0100
Message-ID: <trinity-c6f922e4-1df6-4643-b9f0-f17380c6f9ec-1426577506346__37956.8284297877$1426577597$gmane$org@3capp-gmx-bs43>
References: <trinity-e73e3633-440b-429c-ad5e-bf48c3413989-1426531801924@3capp-gmx-bs44>,
 <55073522.6080006@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1887556274=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.17.20])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wolfgang.rostek@gmx.de>) id 1YXlyi-00042o-A3
 for lttng-dev@lists.lttng.org; Tue, 17 Mar 2015 03:31:59 -0400
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

--===============1887556274==
Content-Type: text/html; charset=UTF-8

<html><head></head><body><div style="font-family: Verdana;font-size: 12.0px;"><div>
<div>Hi Jonathan,</div>

<div>&nbsp;</div>

<div>as I&#39;m struggling with the Internet style response I&#39;ll recap it here</div>

<div>&nbsp;</div>

<div>&gt; On session creation you can use -o to specify an output PATH.</div>

<div>Have tried to redirect to /tmp but no output there as well</div>

<div>&nbsp;</div>

<div>&gt; Did you build from source or you got binary from a package manager ?</div>

<div>yes, via git clone etc.</div>

<div>&nbsp;</div>

<div>&gt; What do you mean by talk to it?<br/>
I see daemon logs in response to the lttng commands. The exception is</div>

<div>that there is no reaction for the demo-trace run.</div>

<div>&nbsp;</div>

<div>&gt; Any particuliar reason to do an export LD_LIBRARY_PATH?<br/>
Ok, is no longer needed.</div>

<div>&nbsp;</div>

<div>I&#39;ve added the sleep but provider output is still like in my original post.</div>

<div>&nbsp;</div>

<div>Below the steps I run again. Is it possible to get more info from the</div>

<div>demo-trace provider? Is the marked line ok?</div>

<div>&nbsp;</div>

<div>thanks</div>

<div>Wolfgang R.</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div><font face="Arial, Helvetica"><font face="Courier New,Courier">row@cobra7:~&#36; lsb_release -sd<br/>
Ubuntu 14.04.1 LTS<br/>
<br/>
row@cobra7:~&#36; file /sbin/init<br/>
/sbin/init: ELF 32-bit LSB&nbsp;&nbsp;shared object, Intel 80386, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.24, BuildID[sha1]=c394677bccc720a3bb4f4c42a48e008ff33e39b1, stripped<br/>
=&gt; 32bit<br/>
<br/>
<br/>
row@cobra7:~&#36; lttng-sessiond -vvv<br/>
...<br/>
<br/>
row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo&#36; export LTTNG_UST_DEBUG=1<br/>
row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo&#36; lttng create<br/>
Session auto-20150317-075322 created.<br/>
Traces will be written in /home/local/ESG_GMBH/row/lttng-traces/auto-20150317-075322&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ####### not found<br/>
row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo&#36; lttng enable-event -u -a<br/>
All UST events are enabled in channel channel0<br/>
<br/>
row@cobra7:~&#36; ps -aux &#124; grep ltt<br/>
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4664&nbsp;&nbsp;0.0&nbsp;&nbsp;0.0&nbsp;&nbsp;84416&nbsp;&nbsp;3376 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ssl&nbsp;&nbsp;07:51&nbsp;&nbsp;&nbsp;0:00 lttng-sessiond<br/>
row&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4683&nbsp;&nbsp;0.0&nbsp;&nbsp;0.1&nbsp;&nbsp;76220 13788 pts/1&nbsp;&nbsp;&nbsp;&nbsp;Sl+&nbsp;&nbsp;07:52&nbsp;&nbsp;&nbsp;0:00 lttng-sessiond -vvv<br/>
row&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4709&nbsp;&nbsp;0.0&nbsp;&nbsp;0.0&nbsp;&nbsp;56096&nbsp;&nbsp;&nbsp;672 pts/1&nbsp;&nbsp;&nbsp;&nbsp;Sl+&nbsp;&nbsp;07:53&nbsp;&nbsp;&nbsp;0:00 lttng-consumerd --quiet -u --consumerd-cmd-sock /home/local/ESG_GMBH/row/.lttng/ustconsumerd32/command --consumerd-err-sock /home/local/ESG_GMBH/row/.lttng/ustconsumerd32/error --group tracing<br/>
<br/>
row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo&#36; lttng start<br/>
Tracing started for session auto-20150317-075322<br/>
<br/>
row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo&#36; ./demo-trace<br/>
liblttng_ust_tracepoint[5381/5381]: just registered a tracepoints section from 0xb7589780 and having 2 tracepoints (in tracepoint_register_lib() at tracepoint.c:767)<br/>
...<br/>
libust[5389/5390]: Info: sessiond not accepting connections to global apps socket (in ust_listener_thread() at lttng-ust-comm.c:1221)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#########&nbsp;&nbsp;is this OK ?<br/>
libust[5389/5390]: Waiting for global apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:1132)<br/>
libust[5389/5391]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:1221)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#########&nbsp;&nbsp;is this OK ?<br/>
libust[5389/5391]: Waiting for local apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:1132)<br/>
libust[5389/5389]: Provider &quot;lttng_ust_tracef&quot; accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-<br/>
...<br/>
<br/>
<br/>
row@cobra7:~&#36; lttng list&nbsp;&nbsp;-u<br/>
UST events:<br/>
-------------<br/>
None </font></font></div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;
<div name="quote" style="margin:10px 5px 5px 10px; padding: 10px 0 10px 10px; border-left:2px solid #C3D9E5; word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">
<div style="margin:0 0 10px 0;"><b>Gesendet:</b>&nbsp;Montag, 16. M&auml;rz 2015 um 20:55 Uhr<br/>
<b>Von:</b>&nbsp;&quot;Jonathan Rajotte Julien&quot; &lt;Jonathan.rajotte-julien@efficios.com&gt;<br/>
<b>An:</b>&nbsp;lttng-dev@lists.lttng.org<br/>
<b>Betreff:</b>&nbsp;Re: [lttng-dev] Can&#39;t get any event output from the demo exe</div>

<div name="quoted-content">Hi Wolfgang,<br/>
<br/>
See inline edit.<br/>
<br/>
On 2015-03-16 02:50 PM, Wolfgang Rostek wrote:<br/>
&gt; Hi group,<br/>
&gt; I&#39;m a bit frustrated not passing the hello world level.<br/>
&gt; But I&#39;m eager to get access to this nice tooling.<br/>
We&#39;ll make sure this happen :).<br/>
<br/>
&gt; For now I&#39;m assuming problems in access rights or<br/>
&gt; may be a 32/64bit library mismatch. Here my stackoverflow<br/>
<br/>
On session creation you can use -o to specify an output PATH.<br/>
<br/>
&gt; post which wasn&#39;t responded. Hope I&#39;ll get a push here.<br/>
&gt; thanks<br/>
&gt; Wolfgang R.<br/>
&gt; ========================================================<br/>
&gt; LTTng at the very beginning<br/>
&gt; just at step zero of using lttng but can&#39;t pass it. Hope a small hint<br/>
&gt; gives me a push.<br/>
&gt; Trying the run the most simple demo of the distribution<br/>
&gt; lttng-ust/doc/examples/demo.<br/>
<br/>
Okai so just to be sure I tested the demo and everything work as<br/>
expected let&#39;s see what is missing on your side.<br/>
Did you build from source or you got binary from a package manager ?<br/>
<br/>
&gt; cat README<br/>
&gt; ...<br/>
&gt; The simplest command to trace the demo program are:<br/>
&gt; lttng create<br/>
&gt; lttng enable-event -u -a<br/>
&gt; lttng start<br/>
&gt; ./demo-trace<br/>
&gt; lttng destroy<br/>
&gt; That will create a trace in your &#36;HOME/lttng-traces directory.<br/>
&gt; ...<br/>
&gt; Put my user lttng-sessiond in verbose mode and can talk to it. Here<br/>
&gt; the state when the demo-trace starts<br/>
<br/>
What do you mean by talk to it?<br/>
<br/>
&gt; row@cobra7:/&#36; lttng list auto-20150313-091148<br/>
&gt; Tracing session auto-20150313-091148: [active]<br/>
&gt; Trace path: /home/local/ESG_GMBH/row/lttng-traces/auto-20150313-091148<br/>
&gt; === Domain: UST global ===<br/>
&gt; Buffer type: per UID<br/>
&gt; Channels:<br/>
&gt; -------------<br/>
&gt; - channel0: [enabled]<br/>
&gt; Attributes:<br/>
&gt; overwrite mode: 0<br/>
&gt; subbufers size: 131072<br/>
&gt; number of subbufers: 4<br/>
&gt; switch timer interval: 0<br/>
&gt; read timer interval: 0<br/>
&gt; output: mmap()<br/>
&gt; Events:<br/>
&gt; * (type: tracepoint) [enabled]<br/>
<br/>
Looks fine so far.<br/>
<br/>
&gt; Executing the demo-trace shows no reaction in the daemon shell and no<br/>
&gt; output file created. Below the client log.<br/>
&gt; I can&#39;t see any problem reported and don&#39;t know what to check next.<br/>
<br/>
Are you sure you got nothing ? Try lttng view if you have babeltrace<br/>
installed.<br/>
Also did you start the daemon in verbose mode ? Otherwise it is expected<br/>
to have no output.<br/>
<br/>
&gt; thanks in advance for feedback<br/>
&gt; Wolfgang R.<br/>
&gt; row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo&#36; export<br/>
&gt; LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib<br/>
<br/>
Any particuliar reason to do an export LD_LIBRARY_PATH?<br/>
<br/>
&gt; row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo&#36; ./demo-trace<br/>
<br/>
If you want to have more time to test you might want to add a sleep()<br/>
into the for loop in demo.c and put a higher loop threshold.<br/>
You will be able to test lttng list -u. Even if it looks like the events<br/>
got registered, it is a good start to pinpoint the problem.<br/>
Also you can start the sessiond with -vvv for a more verbose mode as you<br/>
probably know it.<br/>
<br/>
<br/>
Cheers!<br/>
&gt; liblttng_ust_tracepoint[17268/17268]: just registered a tracepoints<br/>
&gt; section from 0xb754f780 and having 2 tracepoints (in<br/>
&gt; tracepoint_register_lib() at tracepoint.c:767)<br/>
&gt; liblttng_ust_tracepoint[17268/17268]: registered tracepoint:<br/>
&gt; ust_baddr_statedump:soinfo (in tracepoint_register_lib() at<br/>
&gt; tracepoint.c:772)<br/>
&gt; liblttng_ust_tracepoint[17268/17268]: registered tracepoint:<br/>
&gt; lttng_ust_tracef:event (in tracepoint_register_lib() at tracepoint.c:772)<br/>
&gt; libust[17268/17268]: Provider &quot;ust_baddr_statedump&quot; accepted, version<br/>
&gt; 1.0 is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; libust[17268/17268]: adding probe ust_baddr_statedump containing 1<br/>
&gt; events to lazy registration list (in lttng_probe_register() at<br/>
&gt; lttng-probes.c:216)<br/>
&gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &quot;relay-metadata-mmap&quot; init<br/>
&gt; (in lttng_ring_buffer_metadata_client_init() at<br/>
&gt; lttng-ring-buffer-metadata-client.h:330)<br/>
&gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &quot;relay-overwrite-mmap&quot; init<br/>
&gt; (in lttng_ring_buffer_client_overwrite_init() at<br/>
&gt; lttng-ring-buffer-client.h:681)<br/>
&gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &quot;relay-overwrite-rt-mmap&quot; init<br/>
&gt; (in lttng_ring_buffer_client_overwrite_rt_init() at<br/>
&gt; lttng-ring-buffer-client.h:681)<br/>
&gt; libust[17268/17268]: LTT : ltt ring buffer client &quot;relay-discard-mmap&quot;<br/>
&gt; init<br/>
&gt; (in lttng_ring_buffer_client_discard_init() at<br/>
&gt; lttng-ring-buffer-client.h:681)<br/>
&gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &quot;relay-discard-rt-mmap&quot; init<br/>
&gt; (in lttng_ring_buffer_client_discard_rt_init() at<br/>
&gt; lttng-ring-buffer-client.h:681)<br/>
&gt; libust[17268/17269]: Info: sessiond not accepting connections to<br/>
&gt; global apps socket (in ust_listener_thread() at lttng-ust-comm.c:1221)<br/>
&gt; libust[17268/17269]: Waiting for global apps sessiond (in<br/>
&gt; wait_for_sessiond() at lttng-ust-comm.c:1132)<br/>
&gt; libust[17268/17270]: Info: sessiond not accepting connections to local<br/>
&gt; apps socket (in ust_listener_thread() at lttng-ust-comm.c:1221)<br/>
&gt; libust[17268/17270]: Waiting for local apps sessiond (in<br/>
&gt; wait_for_sessiond() at lttng-ust-comm.c:1132)<br/>
&gt; libust[17268/17268]: Provider &quot;lttng_ust_tracef&quot; accepted, version 1.0<br/>
&gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; libust[17268/17268]: just registered probe ust_baddr_statedump<br/>
&gt; containing 1 events (in lttng_lazy_probe_register() at lttng-probes.c:115)<br/>
&gt; libust[17268/17268]: adding probe lttng_ust_tracef containing 1 events<br/>
&gt; to lazy registration list (in lttng_probe_register() at<br/>
&gt; lttng-probes.c:216)<br/>
&gt; libust[17268/17268]: Provider &quot;ust_tests_demo3&quot; accepted, version 1.0<br/>
&gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; libust[17268/17268]: just registered probe lttng_ust_tracef containing<br/>
&gt; 1 events (in lttng_lazy_probe_register() at lttng-probes.c:115)<br/>
&gt; libust[17268/17268]: adding probe ust_tests_demo3 containing 1 events<br/>
&gt; to lazy registration list (in lttng_probe_register() at<br/>
&gt; lttng-probes.c:216)<br/>
&gt; libust[17268/17268]: Provider &quot;ust_tests_demo&quot; accepted, version 1.0<br/>
&gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; libust[17268/17268]: just registered probe ust_tests_demo3 containing<br/>
&gt; 1 events (in lttng_lazy_probe_register() at lttng-probes.c:115)<br/>
&gt; libust[17268/17268]: adding probe ust_tests_demo containing 2 events<br/>
&gt; to lazy registration list (in lttng_probe_register() at<br/>
&gt; lttng-probes.c:216)<br/>
&gt; libust[17268/17268]: Provider &quot;ust_tests_demo2&quot; accepted, version 1.0<br/>
&gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; libust[17268/17268]: just registered probe ust_tests_demo containing 2<br/>
&gt; events (in lttng_lazy_probe_register() at lttng-probes.c:115)<br/>
&gt; libust[17268/17268]: adding probe ust_tests_demo2 containing 1 events<br/>
&gt; to lazy registration list (in lttng_probe_register() at<br/>
&gt; lttng-probes.c:216)<br/>
&gt; liblttng_ust_tracepoint[17268/17268]: just registered a tracepoints<br/>
&gt; section from 0x804b144 and having 4 tracepoints (in<br/>
&gt; tracepoint_register_lib() at tracepoint.c:767)<br/>
&gt; liblttng_ust_tracepoint[17268/17268]: registered tracepoint:<br/>
&gt; ust_tests_demo:starting (in tracepoint_register_lib() at tracepoint.c:772)<br/>
&gt; liblttng_ust_tracepoint[17268/17268]: registered tracepoint:<br/>
&gt; ust_tests_demo:done (in tracepoint_register_lib() at tracepoint.c:772)<br/>
&gt; liblttng_ust_tracepoint[17268/17268]: registered tracepoint:<br/>
&gt; ust_tests_demo2:loop (in tracepoint_register_lib() at tracepoint.c:772)<br/>
&gt; liblttng_ust_tracepoint[17268/17268]: registered tracepoint:<br/>
&gt; ust_tests_demo3:done (in tracepoint_register_lib() at tracepoint.c:772)<br/>
&gt; Demo program starting.<br/>
&gt; Tracing... done.<br/>
&gt; liblttng_ust_tracepoint[17268/17268]: just unregistered a tracepoints<br/>
&gt; section from 0x804b144 (in tracepoint_unregister_lib() at<br/>
&gt; tracepoint.c:797)<br/>
&gt; libust[17268/17268]: Provider &quot;ust_tests_demo2&quot; accepted, version 1.0<br/>
&gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; libust[17268/17268]: just unregistered probe ust_tests_demo2 (in<br/>
&gt; lttng_probe_unregister() at lttng-probes.c:245)<br/>
&gt; libust[17268/17268]: Provider &quot;ust_tests_demo&quot; accepted, version 1.0<br/>
&gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; libust[17268/17268]: just unregistered probe ust_tests_demo (in<br/>
&gt; lttng_probe_unregister() at lttng-probes.c:245)<br/>
&gt; libust[17268/17268]: Provider &quot;ust_tests_demo3&quot; accepted, version 1.0<br/>
&gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; libust[17268/17268]: just unregistered probe ust_tests_demo3 (in<br/>
&gt; lttng_probe_unregister() at lttng-probes.c:245)<br/>
&gt; libust[17268/17268]: Provider &quot;lttng_ust_tracef&quot; accepted, version 1.0<br/>
&gt; is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; libust[17268/17268]: just unregistered probe lttng_ust_tracef (in<br/>
&gt; lttng_probe_unregister() at lttng-probes.c:245)<br/>
&gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &quot;relay-discard-rt-mmap&quot; exit<br/>
&gt; (in lttng_ring_buffer_client_discard_rt_exit() at<br/>
&gt; lttng-ring-buffer-client.h:688)<br/>
&gt; libust[17268/17268]: LTT : ltt ring buffer client &quot;relay-discard-mmap&quot;<br/>
&gt; exit<br/>
&gt; (in lttng_ring_buffer_client_discard_exit() at<br/>
&gt; lttng-ring-buffer-client.h:688)<br/>
&gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &quot;relay-overwrite-rt-mmap&quot; exit<br/>
&gt; (in lttng_ring_buffer_client_overwrite_rt_exit() at<br/>
&gt; lttng-ring-buffer-client.h:688)<br/>
&gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &quot;relay-overwrite-mmap&quot; exit<br/>
&gt; (in lttng_ring_buffer_client_overwrite_exit() at<br/>
&gt; lttng-ring-buffer-client.h:688)<br/>
&gt; libust[17268/17268]: LTT : ltt ring buffer client<br/>
&gt; &quot;relay-metadata-mmap&quot; exit<br/>
&gt; (in lttng_ring_buffer_metadata_client_exit() at<br/>
&gt; lttng-ring-buffer-metadata-client.h:337)<br/>
&gt; libust[17268/17268]: Provider &quot;ust_baddr_statedump&quot; accepted, version<br/>
&gt; 1.0 is compatible with LTTng UST provider version 1.0. (in<br/>
&gt; check_provider_version() at lttng-probes.c:174)<br/>
&gt; libust[17268/17268]: just unregistered probe ust_baddr_statedump (in<br/>
&gt; lttng_probe_unregister() at lttng-probes.c:245)<br/>
&gt; liblttng_ust_tracepoint[17268/17268]: just unregistered a tracepoints<br/>
&gt; section from 0xb754f780 (in tracepoint_unregister_lib() at<br/>
&gt; tracepoint.c:797)<br/>
&gt; row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo&#36;<br/>
&gt;<br/>
&gt;<br/>
&gt; _______________________________________________<br/>
&gt; lttng-dev mailing list<br/>
&gt; lttng-dev@lists.lttng.org<br/>
&gt; <a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target="_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br/>
<br/>
--<br/>
Jonathan R. Julien<br/>
Efficios<br/>
<br/>
<br/>
_______________________________________________<br/>
lttng-dev mailing list<br/>
lttng-dev@lists.lttng.org<br/>
<a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target="_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a></div>
</div>
</div>
</div></div></body></html>


--===============1887556274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1887556274==--
