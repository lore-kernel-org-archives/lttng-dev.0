From: Santiago Font <sfont@teldat.com>
Subject: Re: LTTng-ust 2.4.0-rc2: no events when tracing busybox
Date: Thu, 13 Mar 2014 01:22:55 +0100
Message-ID: <5320FA5F.7050106__38675.7326931276$1394670517$gmane$org@teldat.com>
References: <531F55BB.6030203@teldat.com>
	<118991123.277.1394565002713.JavaMail.zimbra@efficios.com>
	<531F8A3A.4070102@teldat.com>
	<1754522823.2237.1394667413567.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.teldat.com ([195.53.62.69])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sfont@teldat.com>) id 1WNtQM-00055x-ST
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 20:23:10 -0400
In-Reply-To: <1754522823.2237.1394667413567.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

     Meanwhile, I've tried also the "demo" example (dynamic linkage) and 
discovered LDSO support was not enabled in my uClibc; after enabling it, 
"demo" is working as expected, but it makes no difference in busybox 
tracing issue.

     Here it goes:

root@OpenWrt:/# lttng create TEST
root@OpenWrt:/# lttng enable-channel MYCHAN -u --buffers-uid 
--subbuf-size 64k
root@OpenWrt:/# lttng add-context -u -t procname -c MYCHAN
root@OpenWrt:/# lttng enable-event -u -a -c MYCHAN
root@OpenWrt:/# lttng start

Session TEST created.
Traces will be written in /root/lttng-traces/TEST-19700101-000126
Warning: No tracing group detected
UST channel MYCHAN enabled for session TEST
UST context procname added to channel MYCHAN
All UST events are enabled in channel MYCHAN
Tracing started for session TEST

     root@OpenWrt:/# LTTNG_UST_DEBUG=1 /usr/sbin/telnetd -F

liblttng_ust_tracepoint[1806/1806]: just registered a tracepoints 
section from 0x48099d94 and having 1 tracepoints (in 
tracepoint_register_lib() at tracepoint.c:758)
liblttng_ust_tracepoint[1806/1806]: registered tracepoint: 
ust_baddr_statedump:soinfo (in tracepoint_register_lib() at 
tracepoint.c:763)
libust[1806/1806]: LTT : ltt ring buffer client "relay-metadata-mmap" init
  (in lttng_ring_buffer_metadata_client_init() at 
lttng-ring-buffer-metadata-client.h:330)
libust[1806/1806]: LTT : ltt ring buffer client "relay-overwrite-mmap" init
  (in lttng_ring_buffer_client_overwrite_init() at 
lttng-ring-buffer-client.h:670)
libust[1806/1806]: LTT : ltt ring buffer client 
"relay-overwrite-rt-mmap" init
  (in lttng_ring_buffer_client_overwrite_rt_init() at 
lttng-ring-buffer-client.h:670)
libust[1806/1806]: LTT : ltt ring buffer client "relay-discard-mmap" init
  (in lttng_ring_buffer_client_discard_init() at 
lttng-ring-buffer-client.h:670)
libust[1806/1806]: LTT : ltt ring buffer client "relay-discard-rt-mmap" init
  (in lttng_ring_buffer_client_discard_rt_init() at 
lttng-ring-buffer-client.h:670)
libust[1806/1808]: Info: sessiond not accepting connections to local 
apps socket (in ust_listener_thread() at lttng-ust-comm.c:1130)
libust[1806/1808]: Waiting for local apps sessiond (in 
wait_for_sessiond() at lttng-ust-comm.c:1041)
libust[1806/1807]: Message Received "Get Tracer Version" (65), Handle 
"root" (0) (in print_cmd() at lttng-ust-comm.c:287)
libust[1806/1807]: Return value: 0 (in handle_message() at 
lttng-ust-comm.c:743)
libust[1806/1807]: message successfully sent (in send_reply() at 
lttng-ust-comm.c:402)
libust[1806/1807]: Message Received "Create Session" (64), Handle "root" 
(0) (in print_cmd() at lttng-ust-comm.c:287)
libust[1806/1807]: Return value: 1 (in handle_message() at 
lttng-ust-comm.c:743)
libust[1806/1807]: message successfully sent (in send_reply() at 
lttng-ust-comm.c:402)
libust[1806/1807]: Message Received "Create Channel" (81), Handle 
"session" (1) (in print_cmd() at lttng-ust-comm.c:287)
libust[1806/1807]: channel data received (in handle_message() at 
lttng-ust-comm.c:639)
libust[1806/1807]: Return value: 2 (in handle_message() at 
lttng-ust-comm.c:743)
libust[1806/1807]: message successfully sent (in send_reply() at 
lttng-ust-comm.c:402)
libust[1806/1807]: Message Received "Create Stream" (96), Handle 
"channel" (2) (in print_cmd() at lttng-ust-comm.c:287)
libust[1806/1807]: Return value: 0 (in handle_message() at 
lttng-ust-comm.c:743)
libust[1806/1807]: message successfully sent (in send_reply() at 
lttng-ust-comm.c:402)
libust[1806/1807]: Message Received "Create Context" (112), Handle 
"channel" (2) (in print_cmd() at lttng-ust-comm.c:287)
libust[1806/1807]: Return value: 0 (in handle_message() at 
lttng-ust-comm.c:743)
libust[1806/1807]: message successfully sent (in send_reply() at 
lttng-ust-comm.c:402)
libust[1806/1807]: Message Received "Create Event" (97), Handle 
"channel" (2) (in print_cmd() at lttng-ust-comm.c:287)
libust[1806/1807]: Return value: 3 (in handle_message() at 
lttng-ust-comm.c:743)
libust[1806/1807]: message successfully sent (in send_reply() at 
lttng-ust-comm.c:402)
libust[1806/1807]: Message Received "Enable" (128), Handle "session" (1) 
(in print_cmd() at lttng-ust-comm.c:287)
libust[1806/1807]: just registered probe ust_baddr_statedump containing 
1 events (in lttng_lazy_probe_register() at lttng-probes.c:115)
libust[1806/1807]: Sent register event notification for name 
"ust_baddr_statedump:soinfo": ret_code 0, event_id 0
  (in ustcomm_register_event() at lttng-ust-comm.c:1021)
liblttng_ust_tracepoint[1806/1807]: Registering probe to tracepoint 
ust_baddr_statedump:soinfo (in __tracepoint_probe_register() at 
tracepoint.c:558)
libust[1806/1807]: Sent register channel notification: chan_id 0, 
header_type 1
  (in ustcomm_register_channel() at lttng-ust-comm.c:1128)
libust[1806/1807]: Return value: 0 (in handle_message() at 
lttng-ust-comm.c:743)
libust[1806/1807]: message successfully sent (in send_reply() at 
lttng-ust-comm.c:402)
libust[1806/1807]: Message Received "Wait for Quiescent State" (67), 
Handle "root" (0) (in print_cmd() at lttng-ust-comm.c:287)
libust[1806/1807]: Return value: 0 (in handle_message() at 
lttng-ust-comm.c:743)
libust[1806/1807]: message successfully sent (in send_reply() at 
lttng-ust-comm.c:402)
libust[1806/1806]: Error: Timed out waiting for lttng-sessiond (in 
lttng_ust_init() at lttng-ust-comm.c:1423)
libust[1806/1807]: Message Received "Registration Done" (68), Handle 
"root" (0) (in print_cmd() at lttng-ust-comm.c:287)
libust[1806/1807]: Return value: 0 (in handle_message() at 
lttng-ust-comm.c:743)
libust[1806/1807]: message successfully sent (in send_reply() at 
lttng-ust-comm.c:402)

Regards,

     Santi

On 13/03/14 00:36, Mathieu Desnoyers wrote:
> ----- Original Message -----
>> From: "Santiago Font" <sfont@teldat.com>
>> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
>> Cc: lttng-dev@lists.lttng.org
>> Sent: Tuesday, March 11, 2014 6:12:10 PM
>> Subject: Re: [lttng-dev]   LTTng-ust 2.4.0-rc2: no events when tracing busybox
>>
>> Hi,
>>
>>       As I mentioned, I'm building OpenWRT, therefore, part of the
>> integration of LTTng into Busybox is managed at OpenWRT package level,
>> but it is also true that you only need to add the dependency on
>> lttng-ust (Makefile.patch and Makefile, where you can see the Busybox
>> version being used). Adding the dependency directly into Busybox build
>> system should be easy too.
>>       Regarding the patch to add tracepoints to Busybox codebase, it is
>> an addition to the patches applied by OpenWRT (new patch
>> 904-telnetd_lttng_events.patch), but no black magic there neither:
>>             - add a couple of new files for LTTng tracepoints
>> definition/declaration: networking/telnetd_lttng_events.c and
>> networking/telnetd_lttng_events.h
>>             - add tracepoints calls to telnetd.c
>>             - add tracepoint provider to telnetd built: (Kbuild.src:
>> lib-$(CONFIG_TELNETD) += telnetd.o telnetd_lttng_events.o)
>>
>>       And that's all. If this is not the info you are asking for, let me
>> know.
> Can you provide the log when doing this:
>
> LTTNG_UST_DEBUG=1 /usr/sbin/telnetd -F
>
> Thanks,
>
> Mathieu
>
>>       Thanks,
>>
>>                    Santi
>>
>> On 11/03/14 20:10, Mathieu Desnoyers wrote:
>>> ----- Original Message -----
>>>> From: "Santiago Font" <sfont@teldat.com>
>>>> To: lttng-dev@lists.lttng.org
>>>> Sent: Tuesday, March 11, 2014 2:28:11 PM
>>>> Subject: [lttng-dev]   LTTng-ust 2.4.0-rc2: no events when tracing busybox
>>>>
>>>> Hi,
>>>>
>>>>        I have an embedded scenario (openwrt over Freescale) working with
>>>> LTTng:
>>>>
>>>>            lttng create TEST
>>>>            lttng enable-channel MYCHAN -u --buffers-uid --subbuf-size 64k
>>>>            lttng add-context -u -t procname -c MYCHAN
>>>>            lttng enable-event -u "*" -c MYCHAN
>>>>            lttng start
>>>>            /usr/sbin/sample &
>>>>            lttng stop
>>>>            lttng view
>>>>
>>>>                - Several ust_baddr_statedump:soinfo events
>>>>                - An example of the events I defined
>>>>               (See below for details: dump_1)
>>>>
>>>>        So far, so good.
>>>>
>>>>        Now, I'm trying to add my events to busybox to trace telnetd (very
>>>> same provider .c file and event definition .h file, changing only the
>>>> provider name).
>>>>        When I follow exactly the same steps but changing "/usr/sbin/sample
>>>> &" for "/usr/sbin/telnetd -F &", I get the ust_baddr_statedump:soinfo
>>>> events, but none of my events (see dump_2)
>>>>        I have tried with/without TRACEPOINT_PROBE_DYNAMIC_LINKAGE,
>>>> with/without LD_PRELOAD=liblttng-ust-fork.so, but not success.
>>>>        Taking a look to the symbols inside the binary (dump 3), all LTTng
>>>> stuff seems to be there.
>>>>
>>>>        LTTng (modules, tools, ust): 2.4.0
>>>>
>>>>        Any idea?
>>> Could you share with us your patch that adds your specific tracepoints
>>> into the busybox codebase, along with the specific links/version info
>>> needed for us to see how it integrate into the busybox build system ?
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>>>        Thank you,
>>>>
>>>>                  Santi
>>>>
>>>>
>>>>
>>>> ------- dump_1 ------------------
>>>>
>>>> [00:05:04.281094007] (+10.405305121) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x10000000, sopath =
>>>> "/usr/sbin/sample", size = 9176, mtime = 1394554355 }
>>>> [00:05:04.281173138] (+0.000079131) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x48018000, sopath =
>>>> "/lib/libdl-0.9.33.2.so", size = 12436, mtime = 1394229945 }
>>>> [00:05:04.281214310] (+0.000041172) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x4802C000, sopath =
>>>> "/usr/lib/liblttng-ust.so.0.0.0", size = 224696, mtime = 1394554355 }
>>>> [00:05:04.281239239] (+0.000024929) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x48074000, sopath =
>>>> "/lib/libgcc_s.so.1", size = 88200, mtime = 1394229944 }
>>>> [00:05:04.281271259] (+0.000032020) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x4809A000, sopath =
>>>> "/lib/libuClibc-0.9.33.2.so", size = 326616, mtime = 1394229945 }
>>>> [00:05:04.281303562] (+0.000032303) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x48000000, sopath =
>>>> "/lib/ld-uClibc-0.9.33.2.so", size = 29052, mtime = 1394229945 }
>>>> [00:05:04.281344714] (+0.000041152) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x480FF000, sopath =
>>>> "/usr/lib/liblttng-ust-tracepoint.so.0.0.0", size = 25276, mtime =
>>>> 1394554355 }
>>>> [00:05:04.281376996] (+0.000032282) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x4811E000, sopath =
>>>> "/lib/librt-0.9.33.2.so", size = 12404, mtime = 1394229945 }
>>>> [00:05:04.281416532] (+0.000039536) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x48132000, sopath =
>>>> "/usr/lib/liburcu-bp.so.1.0.0", size = 15388, mtime = 1394548454 }
>>>> [00:05:04.281456411] (+0.000039879) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x48146000, sopath =
>>>> "/usr/lib/liburcu-cds.so.1.0.0", size = 18216, mtime = 1394548454 }
>>>> [00:05:04.281489138] (+0.000032727) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x4815B000, sopath =
>>>> "/lib/libpthread-0.9.33.2.so", size = 70104, mtime = 1394229945 }
>>>> [00:05:04.281529501] (+0.000040363) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x4817F000, sopath =
>>>> "/usr/lib/liburcu-common.so.1.0.0", size = 3188, mtime = 1394548454 }
>>>> [00:05:04.282903966] (+0.001374465) OpenWrt busybox_telnetd2:info: {
>>>> cpu_id = 0 }, { procname = "sample" }, { msg = "Hello World" }
>>>> [00:05:04.282922512] (+0.000018546) OpenWrt busybox_telnetd2:session: {
>>>> cpu_id = 0 }, { procname = "sample" }, { msg = "Session", client =
>>>> "10.0.2.5", server = "10.0.2.4", session_pid = 0 }
>>>> [00:05:04.282929643] (+0.000007131) OpenWrt busybox_telnetd2:err: {
>>>> cpu_id = 0 }, { procname = "sample" }, { call = "arg1", msg = "arg2",
>>>> errno_val = 0 }
>>>>
>>>> ------- dump_2 ------------------
>>>> [00:14:16.375740554] (+11.778441605) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x10000000, sopath =
>>>> "/bin/busybox", size = 438834, mtime = 1394559555 }
>>>> [00:14:16.375818817] (+0.000078263) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x48018000, sopath =
>>>> "/lib/libcrypt-0.9.33.2.so", size = 20724, mtime = 1394229945 }
>>>> [00:14:16.375852150] (+0.000033333) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x4803F000, sopath =
>>>> "/lib/libdl-0.9.33.2.so", size = 12436, mtime = 1394229945 }
>>>> [00:14:16.375892474] (+0.000040324) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x48053000, sopath =
>>>> "/usr/lib/liblttng-ust.so.0.0.0", size = 224696, mtime = 1394554355 }
>>>> [00:14:16.375941827] (+0.000049353) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x4809B000, sopath =
>>>> "/lib/libm-0.9.33.2.so", size = 61540, mtime = 1394229945 }
>>>> [00:14:16.375967524] (+0.000025697) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x480BB000, sopath =
>>>> "/lib/libgcc_s.so.1", size = 88200, mtime = 1394229944 }
>>>> [00:14:16.375999484] (+0.000031960) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x480E1000, sopath =
>>>> "/lib/libuClibc-0.9.33.2.so", size = 326616, mtime = 1394229945 }
>>>> [00:14:16.376031585] (+0.000032101) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x48000000, sopath =
>>>> "/lib/ld-uClibc-0.9.33.2.so", size = 29052, mtime = 1394229945 }
>>>> [00:14:16.376072696] (+0.000041111) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x48146000, sopath =
>>>> "/usr/lib/liblttng-ust-tracepoint.so.0.0.0", size = 25276, mtime =
>>>> 1394554355 }
>>>> [00:14:16.376104938] (+0.000032242) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x48165000, sopath =
>>>> "/lib/librt-0.9.33.2.so", size = 12404, mtime = 1394229945 }
>>>> [00:14:16.376144635] (+0.000039697) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x48179000, sopath =
>>>> "/usr/lib/liburcu-bp.so.1.0.0", size = 15388, mtime = 1394548454 }
>>>> [00:14:16.376184373] (+0.000039738) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x4818D000, sopath =
>>>> "/usr/lib/liburcu-cds.so.1.0.0", size = 18216, mtime = 1394548454 }
>>>> [00:14:16.376217363] (+0.000032990) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x481A2000, sopath =
>>>> "/lib/libpthread-0.9.33.2.so", size = 70104, mtime = 1394229945 }
>>>> [00:14:16.376257908] (+0.000040545) OpenWrt ust_baddr_statedump:soinfo:
>>>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x481C6000, sopath =
>>>> "/usr/lib/liburcu-common.so.1.0.0", size = 3188, mtime = 1394548454 }
>>>>
>>>> ----- dump 3 ------------
>>>> nm ipkg-install/bin/busybox | grep 'tracepoint\|busybox_telnetd\|lttng'
>>>>
>>>> 1007b124 d __event_desc___busybox_telnetd
>>>> 1005f7d0 R __event_desc___busybox_telnetd_err
>>>> 1005fee4 R __event_desc___busybox_telnetd_info
>>>> 1005fea4 R __event_desc___busybox_telnetd_session
>>>> 1005f998 r __event_fields___busybox_telnetd___err
>>>> 1005f868 r __event_fields___busybox_telnetd___info
>>>> 1005ff24 r __event_fields___busybox_telnetd___session
>>>> 10016624 t __event_probe__busybox_telnetd___err
>>>> 100164a4 t __event_probe__busybox_telnetd___info
>>>> 10016878 t __event_probe__busybox_telnetd___session
>>>> 1007b134 d _format___busybox_telnetd___err
>>>> 1007b130 d _format___busybox_telnetd___info
>>>> 1007b138 d _format___busybox_telnetd___session
>>>>             w _loglevel___busybox_telnetd___err
>>>>             w _loglevel___busybox_telnetd___info
>>>>             w _loglevel___busybox_telnetd___session
>>>> 10016ca0 t __lttng_events_exit__busybox_telnetd
>>>> 10016c3c t __lttng_events_init__busybox_telnetd
>>>>             U lttng_probe_register
>>>>             U lttng_probe_unregister
>>>>             w _model_emf_uri___busybox_telnetd___err
>>>>             w _model_emf_uri___busybox_telnetd___info
>>>>             w _model_emf_uri___busybox_telnetd___session
>>>> 1007b13c d __probe_desc___busybox_telnetd
>>>> 1007c228 b __probe_register_refcount___busybox_telnetd
>>>> 1007b1ec A __start___tracepoints_ptrs
>>>> 1007b1f8 A __stop___tracepoints_ptrs
>>>> 1005fe70 R __tp_event_signature___busybox_telnetd___err
>>>> 1005f858 R __tp_event_signature___busybox_telnetd___info
>>>> 1005f810 R __tp_event_signature___busybox_telnetd___session
>>>> 1006ac80 r __tp_strtab_busybox_telnetd___err
>>>> 1006ac94 r __tp_strtab_busybox_telnetd___info
>>>> 1006ac68 r __tp_strtab_busybox_telnetd___session
>>>> 1007b180 D __tracepoint_busybox_telnetd___err
>>>> 1007b1c8 D __tracepoint_busybox_telnetd___info
>>>> 1007b1a4 D __tracepoint_busybox_telnetd___session
>>>> 1007c210 V tracepoint_dlopen
>>>> 100155e8 t __tracepoint__init_urcu_sym
>>>> 1007b250 S __tracepoint_provider_busybox_telnetd
>>>> 1007b1f0 d __tracepoint_ptr_busybox_telnetd___err
>>>> 1007b1f4 d __tracepoint_ptr_busybox_telnetd___info
>>>> 1007b1ec d __tracepoint_ptr_busybox_telnetd___session
>>>> 1007b248 V __tracepoint_ptrs_registered
>>>> 1007b24c V __tracepoint_registered
>>>> 10015708 t __tracepoints__destroy
>>>> 10016ba4 t __tracepoints__destroy
>>>> 10015684 t __tracepoints__init
>>>> 10016ac4 t __tracepoints__init
>>>> 10015868 t __tracepoints__ptrs_destroy
>>>> 100157a0 t __tracepoints__ptrs_init
>>>>
>>>>
>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>
>>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
