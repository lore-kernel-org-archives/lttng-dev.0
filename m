From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Python tracef() jams the interpreter on registration
Date: Thu, 27 Nov 2014 16:55:00 -0500
Message-ID: <CAC6yHM7nYKqFJzUFtU=LchhKCHip5_HEROaD60JeHtpfPtUB4Q__28318.1633604274$1417125377$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1988019994=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.giraldeau@gmail.com>) id 1Xu71m-0002TI-Bt
 for lttng-dev@lists.lttng.org; Thu, 27 Nov 2014 16:55:11 -0500
Received: by mail-qa0-f48.google.com with SMTP id v10so3745698qac.7
 for <lttng-dev@lists.lttng.org>; Thu, 27 Nov 2014 13:55:00 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1988019994==
Content-Type: multipart/alternative; boundary=001a11399f4c2836fa0508de326d

--001a11399f4c2836fa0508de326d
Content-Type: text/plain; charset=UTF-8

I did a prototype of UST instrumentation to record all function
entry/return of Python programs (works with CPython >= 3).

http://git.dorsal.polymtl.ca/~fgiraldeau?p=python-profile-ust.git;a=summary

Here is an example of the trace:

$ ./go.sh
...
[16:50:17.443042690] (+0.000053969) berta python:call: { cpu_id = 6 }, {
co_name = "<module>" }
[16:50:17.443056837] (+0.000014147) berta python:call: { cpu_id = 6 }, {
co_name = "cafe" }

It works when only the event python:call is enabled. When all events are
enabled (lttng enable-event -a -u), then the python program hangs on a call
to futex wait. It does not respond to CTRL-C signal, and must be killed.
Here is the full stack trace in GDB, showing that it seems related to the
registration of tracef() probe. Below that, there is the lttng-sessiond
log. I reproduced the problem with lttng 2.5x stable and the git master.
Any idea about what can go wrong?

Thanks,

Francis

==========

Program received signal SIGSTOP, Stopped (signal).
0x00007ffff7bcaf2c in __lll_lock_wait () from
/lib/x86_64-linux-gnu/libpthread.so.0
(gdb) bt
#0  0x00007ffff7bcaf2c in __lll_lock_wait () from
/lib/x86_64-linux-gnu/libpthread.so.0
#1  0x00007ffff7bc6657 in _L_lock_909 () from
/lib/x86_64-linux-gnu/libpthread.so.0
#2  0x00007ffff7bc6480 in pthread_mutex_lock () from
/lib/x86_64-linux-gnu/libpthread.so.0
#3  0x00007ffff6102aec in ust_lock_nocheck () at lttng-ust-comm.c:150
#4  0x00007ffff61083a5 in lttng_probe_register (
    desc=0x7ffff633e9c0 <__probe_desc___lttng_ust_tracef>) at
lttng-probes.c:204
#5  0x00007ffff60fc301 in __lttng_events_init__lttng_ust_tracef ()
    at ../include/lttng/ust-tracepoint-event.h:797
#6  0x00007ffff7dea13a in call_init (l=<optimized out>, argc=argc@entry=2,
    argv=argv@entry=0x7fffffffdcf8, env=env@entry=0x7fffffffdd10) at
dl-init.c:78
#7  0x00007ffff7dea223 in call_init (env=<optimized out>, argv=<optimized
out>,
    argc=<optimized out>, l=<optimized out>) at dl-init.c:36
#8  _dl_init (main_map=main_map@entry=0xafa730, argc=2,
argv=0x7fffffffdcf8, env=0x7fffffffdd10)
    at dl-init.c:126
#9  0x00007ffff7deec70 in dl_open_worker (a=a@entry=0x7fffffffc1f8) at
dl-open.c:577
#10 0x00007ffff7de9ff4 in _dl_catch_error (objname=objname@entry
=0x7fffffffc1e8,
    errstring=errstring@entry=0x7fffffffc1f0, mallocedp=mallocedp@entry
=0x7fffffffc1e0,
    operate=operate@entry=0x7ffff7dee9a0 <dl_open_worker>, args=args@entry
=0x7fffffffc1f8)
    at dl-error.c:187
#11 0x00007ffff7dee3bb in _dl_open (
    file=0x7ffff6593f50 "./build/lib.linux-x86_64-3.4/
lttngProfile.cpython-34m.so",
    mode=-2147483646, caller_dlopen=<optimized out>, nsid=-2, argc=2,
argv=0x7fffffffdcf8,
    env=0x7fffffffdd10) at dl-open.c:661
#12 0x00007ffff75f302b in dlopen_doit (a=a@entry=0x7fffffffc410) at
dlopen.c:66
#13 0x00007ffff7de9ff4 in _dl_catch_error (objname=0xadd910,
errstring=0xadd918, mallocedp=0xadd908,
    operate=0x7ffff75f2fd0 <dlopen_doit>, args=0x7fffffffc410) at
dl-error.c:187
#14 0x00007ffff75f362d in _dlerror_run (operate=operate@entry=0x7ffff75f2fd0
<dlopen_doit>,
    args=args@entry=0x7fffffffc410) at dlerror.c:163
#15 0x00007ffff75f30c1 in __dlopen (file=<optimized out>, mode=<optimized
out>) at dlopen.c:87
#16 0x000000000050fa6e in _PyImport_GetDynLoadFunc ()
#17 0x0000000000580f2d in ?? ()
#18 0x000000000057b98a in PyEval_EvalFrameEx ()
#19 0x000000000057d3d3 in PyEval_EvalCodeEx ()
#20 0x000000000057bfaa in PyEval_EvalFrameEx ()
#21 0x000000000057d3d3 in PyEval_EvalCodeEx ()
#22 0x000000000057e0eb in ?? ()
#23 0x000000000043810a in PyObject_Call ()
#24 0x0000000000579616 in PyEval_EvalFrameEx ()
#25 0x000000000057d3d3 in PyEval_EvalCodeEx ()
#26 0x000000000057bfaa in PyEval_EvalFrameEx ()
#27 0x000000000057c0db in PyEval_EvalFrameEx ()
#28 0x000000000057c0db in PyEval_EvalFrameEx ()
#29 0x000000000057c0db in PyEval_EvalFrameEx ()
#30 0x000000000057d3d3 in PyEval_EvalCodeEx ()
#31 0x000000000057df80 in ?? ()
#32 0x000000000043810a in PyObject_Call ()
#33 0x000000000050c06b in _PyObject_CallMethodIdObjArgs ()
#34 0x00000000004bbda1 in PyImport_ImportModuleLevelObject ()
#35 0x00000000005fa00b in ?? ()
#36 0x000000000043810a in PyObject_Call ()
#37 0x00000000004367b8 in ?? ()
#38 0x0000000000578de9 in PyEval_EvalFrameEx ()
#39 0x000000000057d3d3 in PyEval_EvalCodeEx ()
#40 0x000000000060ba83 in PyRun_FileExFlags ()
#41 0x000000000060bc85 in PyRun_SimpleFileExFlags ()
#42 0x000000000060d3ac in Py_Main ()
#43 0x000000000041ec0d in main ()
(gdb)

DEBUG1 - 16:56:11.529554 [21776/21781]: UST registration received with
pid:21853 ppid:21833 uid:1000 gid:1000 sock:23 name:python3 (version 6.0)
(in thread_registration_apps() at main.c:2084)
DEBUG1 - 16:56:11.529580 [21776/21781]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:105)
DEBUG1 - 16:56:11.529597 [21776/21781]: Accepting application registration
(in thread_registration_apps() at main.c:1976)
DEBUG1 - 16:56:11.529601 [21776/21780]: Futex n to 1 wait done (in
futex_nto1_wait() at futex.c:91)
DEBUG1 - 16:56:11.529631 [21776/21780]: Futex n to 1 prepare done (in
futex_nto1_prepare() at futex.c:76)
DEBUG1 - 16:56:11.529640 [21776/21780]: Dispatching UST registration
pid:21853 ppid:21833 uid:1000 gid:1000 sock:23 name:python3 (version 6.0)
(in thread_dispatch_ust_registration() at main.c:1750)
DEBUG1 - 16:56:11.529619 [21776/21781]: UST registration received with
pid:21853 ppid:21833 uid:1000 gid:1000 sock:30 name:python3 (version 6.0)
(in thread_registration_apps() at main.c:2084)
DEBUG1 - 16:56:11.529662 [21776/21781]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:105)
DEBUG1 - 16:56:11.529669 [21776/21781]: Accepting application registration
(in thread_registration_apps() at main.c:1976)
DEBUG3 - 16:56:11.529676 [21776/21780]: UST app creating application for
socket 23 (in ust_app_create() at ust-app.c:2938)
DEBUG3 - 16:56:11.529690 [21776/21780]: Created hashtable size 4 at
0x7fbf0c000a10 of type 2 (in lttng_ht_new() at hashtable.c:128)
DEBUG3 - 16:56:11.529708 [21776/21780]: Created hashtable size 4 at
0x7fbf0c001150 of type 1 (in lttng_ht_new() at hashtable.c:128)
DEBUG1 - 16:56:11.529721 [21776/21780]: Dispatching UST registration
pid:21853 ppid:21833 uid:1000 gid:1000 sock:30 name:python3 (version 6.0)
(in thread_dispatch_ust_registration() at main.c:1750)
DEBUG3 - 16:56:11.529728 [21776/21780]: UST app notify socket 30 is set (in
thread_dispatch_ust_registration() at main.c:1807)
DEBUG1 - 16:56:11.529740 [21776/21780]: App registered with pid:21853
ppid:21833 uid:1000 gid:1000 sock:23 name:python3 notify_sock:30 (version
6.0) (in ust_app_add() at ust-app.c:3026)
DEBUG2 - 16:56:11.529784 [21776/21780]: UST app global update for app sock
23 for session id 0 (in ust_app_global_update() at ust-app.c:4263)
DEBUG2 - 16:56:11.529809 [21776/21780]: UST app pid: 21853 session id 0 not
found, creating it (in create_ust_app_session() at ust-app.c:1847)
DEBUG3 - 16:56:11.529812 [21776/21783]: UST thread notify added sock 30 to
pollset (in ust_thread_manage_notify() at ust-thread.c:138)
DEBUG3 - 16:56:11.529836 [21776/21783]: [ust-thread] Manage notify polling
on 3 fds (in ust_thread_manage_notify() at ust-thread.c:69)
DEBUG3 - 16:56:11.529826 [21776/21780]: Created hashtable size 4 at
0x7fbf0c002970 of type 0 (in lttng_ht_new() at hashtable.c:128)
DEBUG2 - 16:56:11.529859 [21776/21780]: Shadow copy of session handle -1
(in shadow_copy_session() at ust-app.c:1603)
DEBUG2 - 16:56:11.529877 [21776/21780]: Channel channel0 not found on
shadow session copy, creating it (in shadow_copy_session() at
ust-app.c:1653)
DEBUG3 - 16:56:11.529884 [21776/21780]: Created hashtable size 4 at
0x7fbf0c0032f0 of type 1 (in lttng_ht_new() at hashtable.c:128)
DEBUG3 - 16:56:11.529891 [21776/21780]: Created hashtable size 4 at
0x7fbf0c003a30 of type 0 (in lttng_ht_new() at hashtable.c:128)
DEBUG3 - 16:56:11.529897 [21776/21780]: UST app channel channel0 allocated
(in alloc_ust_app_channel() at ust-app.c:883)
DEBUG2 - 16:56:11.529906 [21776/21780]: UST app shadow copy of channel
channel0 started (in shadow_copy_channel() at ust-app.c:1530)
DEBUG2 - 16:56:11.529914 [21776/21780]: UST event * not found on shadow
copy channel (in shadow_copy_channel() at ust-app.c:1570)
DEBUG3 - 16:56:11.529929 [21776/21780]: UST app event * allocated (in
alloc_ust_app_event() at ust-app.c:939)
DEBUG3 - 16:56:11.529937 [21776/21780]: UST app shadow copy of channel
channel0 done (in shadow_copy_channel() at ust-app.c:1580)
DEBUG3 - 16:56:11.529944 [21776/21780]: Buffer registry per UID find id: 0,
ABI: 64, uid: 1000 (in buffer_reg_uid_find() at buffer-registry.c:196)
DEBUG3 - 16:56:11.529953 [21776/21780]: Created hashtable size 4 at
0x7fbf0c004580 of type 2 (in lttng_ht_new() at hashtable.c:128)
DEBUG3 - 16:56:11.529960 [21776/21780]: Buffer registry per UID created id:
0, ABI: 64, uid: 1000, domain: 2 (in buffer_reg_uid_create() at
buffer-registry.c:145)
DEBUG3 - 16:56:11.529967 [21776/21780]: Buffer registry per UID adding to
global registry with id: 0 (in buffer_reg_uid_add() at
buffer-registry.c:167)
DEBUG3 - 16:56:11.529975 [21776/21780]: Created hashtable size 4 at
0x7fbf0c004d60 of type 2 (in lttng_ht_new() at hashtable.c:128)
DEBUG3 - 16:56:11.530013 [21776/21780]: Append to metadata: "typealias
integer { size = 8; align = 8; signed = false; } := uint8_t;
typealias integer { size = 16; align = 8; signed = false; } := uint16_t;
typealias integer { size = 32; align = 8; signed = false; } := uint32_t;
typealias integer { size = 64; align = 8; signed = false; } := uint64_t;
typealias integer { size = 64; align = 8; signed = false; } := unsigned
long;
typealias integer { size = 5; align = 1; signed = false; } := uint5_t;
typealias integer { size = 27; align = 1; signed = false; } := uint27_t;

trace {
major = 1;
minor = 8;
uuid = "54b830c0-b308-416b-98b8-a1dbd24a5c6c";
byte_order = le;
packet.header := struct {
uint32_t magic;
uint8_t  uuid[16];
uint32_t stream_id;
};
};

" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.530114 [21776/21780]: Append to metadata: "env {
hostname = "berta";
domain = "ust";
tracer_name = "lttng-ust";
tracer_major = 2;
tracer_minor = 6;
" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.530164 [21776/21780]: Append to metadata: "};

" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.530176 [21776/21780]: Append to metadata: "clock {
name = monotonic;
" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.530214 [21776/21780]: Append to metadata: " uuid =
"929f2bc9-1726-4628-a617-66b2a2d84c0b";
" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.530235 [21776/21780]: Append to metadata: " description =
"Monotonic Clock";
freq = 1000000000; /* Frequency, in Hz */
/* clock value offset from Epoch is: offset * (1/freq) */
offset = 1409415126878138691;
};

" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.530272 [21776/21780]: Append to metadata: "typealias
integer {
size = 27; align = 1; signed = false;
map = clock.monotonic.value;
} := uint27_clock_monotonic_t;

typealias integer {
size = 32; align = 8; signed = false;
map = clock.monotonic.value;
} := uint32_clock_monotonic_t;

typealias integer {
size = 64; align = 8; signed = false;
map = clock.monotonic.value;
} := uint64_clock_monotonic_t;

" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.530337 [21776/21780]: Append to metadata: "struct
packet_context {
uint64_clock_monotonic_t timestamp_begin;
uint64_clock_monotonic_t timestamp_end;
uint64_t content_size;
uint64_t packet_size;
unsigned long events_discarded;
uint32_t cpu_id;
};

" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.530387 [21776/21780]: Append to metadata: "struct
event_header_compact {
enum : uint5_t { compact = 0 ... 30, extended = 31 } id;
variant <id> {
struct {
uint27_clock_monotonic_t timestamp;
} compact;
struct {
uint32_t id;
uint64_clock_monotonic_t timestamp;
} extended;
} v;
} align(8);

struct event_header_large {
enum : uint16_t { compact = 0 ... 65534, extended = 65535 } id;
variant <id> {
struct {
uint32_clock_monotonic_t timestamp;
} compact;
struct {
uint32_t id;
uint64_clock_monotonic_t timestamp;
} extended;
} v;
} align(8);

" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.530549 [21776/21780]: UST app buffer registry per UID
created successfully (in setup_buffer_reg_uid() at ust-app.c:1809)
DEBUG2 - 16:56:11.530608 [21776/21780]: UST app session created
successfully with handle 1 (in create_ust_app_session() at ust-app.c:1915)
DEBUG1 - 16:56:11.530626 [21776/21780]: UST app creating channel channel0
with per UID buffers (in create_channel_per_uid() at ust-app.c:2508)
DEBUG3 - 16:56:11.530635 [21776/21780]: Buffer registry per UID find id: 0,
ABI: 64, uid: 1000 (in buffer_reg_uid_find() at buffer-registry.c:196)
DEBUG2 - 16:56:11.530642 [21776/21780]: UST app creating buffer registry
channel for channel0 (in create_buffer_reg_channel() at ust-app.c:2361)
DEBUG3 - 16:56:11.530649 [21776/21780]: Buffer registry channel create with
key: 0 (in buffer_reg_channel_create() at buffer-registry.c:327)
DEBUG3 - 16:56:11.530658 [21776/21780]: Created hashtable size 4 at
0x7fbf0c0055b0 of type 0 (in lttng_ht_new() at hashtable.c:128)
DEBUG2 - 16:56:11.530671 [21776/21780]: Asking UST consumer for channel (in
ask_channel_creation() at ust-consumer.c:119)
DEBUG3 - 16:56:11.530682 [21776/21780]: mkdir() recursive
/home/francis/lttng-traces/auto-20141127-165611/ust/uid/1000/64-bit with
mode 504 for uid 1000 and gid 1000 (in run_as_mkdir_recursive() at
runas.c:309)
DEBUG1 - 16:56:11.530691 [21776/21780]: Using run_as_clone (in run_as() at
runas.c:292)
DEBUG3 - 16:56:11.531579 [21776/21780]: UST registry channel finding key 0
(in ust_registry_channel_find() at ust-registry.c:490)
DEBUG2 - 16:56:11.557620 [21776/21780]: UST ask channel 1 successfully done
with 8 stream(s) (in ask_channel_creation() at ust-consumer.c:196)
DEBUG2 - 16:56:11.557724 [21776/21780]: UST app stream 1 received
successfully (in ust_consumer_get_channel() at ust-consumer.c:312)
DEBUG2 - 16:56:11.557754 [21776/21780]: UST app stream 2 received
successfully (in ust_consumer_get_channel() at ust-consumer.c:312)
DEBUG2 - 16:56:11.557776 [21776/21780]: UST app stream 3 received
successfully (in ust_consumer_get_channel() at ust-consumer.c:312)
DEBUG2 - 16:56:11.557796 [21776/21780]: UST app stream 4 received
successfully (in ust_consumer_get_channel() at ust-consumer.c:312)
DEBUG2 - 16:56:11.557816 [21776/21780]: UST app stream 5 received
successfully (in ust_consumer_get_channel() at ust-consumer.c:312)
DEBUG2 - 16:56:11.557838 [21776/21780]: UST app stream 6 received
successfully (in ust_consumer_get_channel() at ust-consumer.c:312)
DEBUG2 - 16:56:11.557853 [21776/21780]: UST app stream 7 received
successfully (in ust_consumer_get_channel() at ust-consumer.c:312)
DEBUG2 - 16:56:11.557867 [21776/21780]: UST app stream 8 received
successfully (in ust_consumer_get_channel() at ust-consumer.c:312)
DEBUG3 - 16:56:11.557882 [21776/21780]: UST app consumer has no more stream
available (in ust_consumer_get_channel() at ust-consumer.c:295)
DEBUG2 - 16:56:11.557893 [21776/21780]: UST app setup buffer registry
channel for channel0 (in setup_buffer_reg_channel() at ust-app.c:2409)
DEBUG2 - 16:56:11.557902 [21776/21780]: UST app setup buffer registry
stream (in setup_buffer_reg_streams() at ust-app.c:2316)
DEBUG3 - 16:56:11.557910 [21776/21780]: Buffer registry creating stream (in
buffer_reg_stream_create() at buffer-registry.c:357)
DEBUG3 - 16:56:11.557920 [21776/21780]: Buffer registry creating stream (in
buffer_reg_stream_create() at buffer-registry.c:357)
DEBUG3 - 16:56:11.557927 [21776/21780]: Buffer registry creating stream (in
buffer_reg_stream_create() at buffer-registry.c:357)
DEBUG3 - 16:56:11.557935 [21776/21780]: Buffer registry creating stream (in
buffer_reg_stream_create() at buffer-registry.c:357)
DEBUG3 - 16:56:11.557944 [21776/21780]: Buffer registry creating stream (in
buffer_reg_stream_create() at buffer-registry.c:357)
DEBUG3 - 16:56:11.557951 [21776/21780]: Buffer registry creating stream (in
buffer_reg_stream_create() at buffer-registry.c:357)
DEBUG3 - 16:56:11.557959 [21776/21780]: Buffer registry creating stream (in
buffer_reg_stream_create() at buffer-registry.c:357)
DEBUG3 - 16:56:11.557968 [21776/21780]: Buffer registry creating stream (in
buffer_reg_stream_create() at buffer-registry.c:357)
DEBUG1 - 16:56:11.557976 [21776/21780]: UST app sending buffer registry
channel to ust sock 23 (in send_channel_uid_to_ust() at ust-app.c:2445)
DEBUG2 - 16:56:11.557988 [21776/21780]: UST app send channel to sock 23 pid
21853 (name: channel0, key: 0) (in ust_consumer_send_channel_to_ust() at
ust-consumer.c:416)
DEBUG2 - 16:56:11.558248 [21776/21780]: UST consumer send stream to app 23
(in ust_consumer_send_stream_to_ust() at ust-consumer.c:381)
DEBUG2 - 16:56:11.558342 [21776/21780]: UST consumer send stream to app 23
(in ust_consumer_send_stream_to_ust() at ust-consumer.c:381)
DEBUG2 - 16:56:11.558400 [21776/21780]: UST consumer send stream to app 23
(in ust_consumer_send_stream_to_ust() at ust-consumer.c:381)
DEBUG2 - 16:56:11.558449 [21776/21780]: UST consumer send stream to app 23
(in ust_consumer_send_stream_to_ust() at ust-consumer.c:381)
DEBUG2 - 16:56:11.558487 [21776/21780]: UST consumer send stream to app 23
(in ust_consumer_send_stream_to_ust() at ust-consumer.c:381)
DEBUG2 - 16:56:11.558529 [21776/21780]: UST consumer send stream to app 23
(in ust_consumer_send_stream_to_ust() at ust-consumer.c:381)
DEBUG2 - 16:56:11.558567 [21776/21780]: UST consumer send stream to app 23
(in ust_consumer_send_stream_to_ust() at ust-consumer.c:381)
DEBUG2 - 16:56:11.558604 [21776/21780]: UST consumer send stream to app 23
(in ust_consumer_send_stream_to_ust() at ust-consumer.c:381)
DEBUG2 - 16:56:11.558672 [21776/21780]: UST app event * created
successfully for pid:21853 (in create_ust_event() at ust-app.c:1429)
DEBUG2 - 16:56:11.558703 [21776/21780]: UST app event * enabled
successfully for app (pid: 21853) (in enable_ust_event() at ust-app.c:1341)
DEBUG1 - 16:56:11.558713 [21776/21780]: Starting tracing for ust app pid
21853 (in ust_app_start_trace() at ust-app.c:3832)
DEBUG3 - 16:56:11.558723 [21776/21780]: mkdir() recursive
/home/francis/lttng-traces/auto-20141127-165611 with mode 504 for uid 1000
and gid 1000 (in run_as_mkdir_recursive() at runas.c:309)
DEBUG1 - 16:56:11.558733 [21776/21780]: Using run_as_clone (in run_as() at
runas.c:292)
DEBUG3 - 16:56:11.559632 [21776/21780]: Buffer registry per UID find id: 0,
ABI: 64, uid: 1000 (in buffer_reg_uid_find() at buffer-registry.c:196)
DEBUG3 - 16:56:11.559663 [21776/21780]: Created hashtable size 4 at
0x7fbf0c008ed0 of type 1 (in lttng_ht_new() at hashtable.c:128)
DEBUG3 - 16:56:11.559676 [21776/21780]: Created hashtable size 4 at
0x7fbf0c009800 of type 0 (in lttng_ht_new() at hashtable.c:128)
DEBUG3 - 16:56:11.559684 [21776/21780]: UST app channel metadata allocated
(in alloc_ust_app_channel() at ust-app.c:883)
DEBUG2 - 16:56:11.559696 [21776/21780]: Asking UST consumer for channel (in
ask_channel_creation() at ust-consumer.c:119)
DEBUG3 - 16:56:11.559710 [21776/21780]: mkdir() recursive
/home/francis/lttng-traces/auto-20141127-165611/ust/uid/1000/64-bit with
mode 504 for uid 1000 and gid 1000 (in run_as_mkdir_recursive() at
runas.c:309)
DEBUG1 - 16:56:11.559720 [21776/21780]: Using run_as_clone (in run_as() at
runas.c:292)
DEBUG2 - 16:56:11.561817 [21776/21780]: UST ask channel 2 successfully done
with 1 stream(s) (in ask_channel_creation() at ust-consumer.c:196)
DEBUG2 - 16:56:11.561860 [21776/21780]: Consumer setup metadata channel key
2 (in consumer_setup_metadata() at consumer.c:1206)
DEBUG2 - 16:56:11.561916 [21776/21780]: UST metadata with key 2 created for
app pid 21853 (in create_ust_app_metadata() at ust-app.c:2890)
DEBUG3 - 16:56:11.561932 [21776/21780]: UST app deleting channel metadata
(in delete_ust_app_channel() at ust-app.c:375)
DEBUG3 - 16:56:11.562035 [21776/21777]: [ht-thread] Polling on 2 fds. (in
thread_ht_cleanup() at ht-cleanup.c:65)
DEBUG3 - 16:56:11.562066 [21776/21777]: [ht-thread] Polling on 2 fds. (in
thread_ht_cleanup() at ht-cleanup.c:65)
DEBUG3 - 16:56:11.562051 [21776/21783]: UST app receiving notify from sock
30 (in ust_app_recv_notify() at ust-app.c:4820)
DEBUG2 - 16:56:11.562103 [21776/21783]: UST app ustctl register channel
received (in ust_app_recv_notify() at ust-app.c:4873)
DEBUG3 - 16:56:11.562118 [21776/21783]: Buffer registry per UID find id: 0,
ABI: 64, uid: 1000 (in buffer_reg_uid_find() at buffer-registry.c:196)
DEBUG3 - 16:56:11.562131 [21776/21783]: UST registry channel finding key 0
(in ust_registry_channel_find() at ust-registry.c:490)
DEBUG3 - 16:56:11.562159 [21776/21783]: Append to metadata: "stream {
id = 0;
event.header := struct event_header_compact;
packet.context := struct packet_context;
" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.562194 [21776/21783]: Append to metadata: "};

" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.562209 [21776/21783]: UST app replying to register
channel key 0 with id 0, type: 1, ret: 0 (in reply_ust_register_channel()
at ust-app.c:4686)
DEBUG3 - 16:56:11.562223 [21776/21783]: [ust-thread] Manage notify polling
on 3 fds (in ust_thread_manage_notify() at ust-thread.c:69)
DEBUG3 - 16:56:11.562265 [21776/21783]: UST app receiving notify from sock
30 (in ust_app_recv_notify() at ust-app.c:4820)
DEBUG2 - 16:56:11.562278 [21776/21783]: UST app ustctl register event
received (in ust_app_recv_notify() at ust-app.c:4840)
DEBUG3 - 16:56:11.562296 [21776/21783]: Buffer registry per UID find id: 0,
ABI: 64, uid: 1000 (in buffer_reg_uid_find() at buffer-registry.c:196)
DEBUG3 - 16:56:11.562306 [21776/21783]: UST registry channel finding key 0
(in ust_registry_channel_find() at ust-registry.c:490)
DEBUG3 - 16:56:11.562314 [21776/21783]: UST registry creating event with
event: ust_baddr_statedump:soinfo, sig: struct lttng_session *, session,
void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime, id: 0,
chan_objd: 2, sess_objd: 1, chan_id: 0 (in ust_registry_create_event() at
ust-registry.c:299)
DEBUG3 - 16:56:11.562326 [21776/21783]: Append to metadata: "event {
name = "ust_baddr_statedump:soinfo";
id = 0;
stream_id = 0;
" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.562360 [21776/21783]: Append to metadata: " loglevel = 13;
" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.562378 [21776/21783]: Append to metadata: " fields :=
struct {
" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.562397 [21776/21783]: Append to metadata: " integer {
size = 64; align = 8; signed = 0; encoding = none; base = 16; } _baddr;
" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.562418 [21776/21783]: Append to metadata: " string
_sopath;
" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.562439 [21776/21783]: Append to metadata: " integer {
size = 64; align = 8; signed = 1; encoding = none; base = 10; } _size;
" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.562460 [21776/21783]: Append to metadata: " integer {
size = 64; align = 8; signed = 1; encoding = none; base = 10; } _mtime;
" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.562480 [21776/21783]: Append to metadata: " };
};

" (in lttng_metadata_printf() at ust-metadata.c:152)
DEBUG3 - 16:56:11.562508 [21776/21783]: UST registry event
ust_baddr_statedump:soinfo with id 0 added successfully (in
add_event_ust_registry() at ust-app.c:4801)
DEBUG3 - 16:56:11.562518 [21776/21783]: [ust-thread] Manage notify polling
on 3 fds (in ust_thread_manage_notify() at ust-thread.c:69)
DEBUG2 - 16:56:11.562570 [21776/21780]: UST trace started for app pid 21853
(in ust_app_global_update() at ust-app.c:4337)
DEBUG1 - 16:56:11.562633 [21776/21780]: Woken up but nothing in the UST
command queue (in thread_dispatch_ust_registration() at main.c:1738)
DEBUG1 - 16:56:11.562645 [21776/21780]: Futex n to 1 wait done (in
futex_nto1_wait() at futex.c:91)
DEBUG1 - 16:56:11.562656 [21776/21780]: Futex n to 1 prepare done (in
futex_nto1_prepare() at futex.c:76)
DEBUG1 - 16:56:11.562667 [21776/21780]: Woken up but nothing in the UST
command queue (in thread_dispatch_ust_registration() at main.c:1738)
DEBUG1 - 16:56:11.562648 [21776/21782]: Apps with sock 23 added to poll set
(in thread_manage_apps() at main.c:1520)
DEBUG1 - 16:56:11.562703 [21776/21782]: Apps thread polling on 3 fds (in
thread_manage_apps() at main.c:1459)

--001a11399f4c2836fa0508de326d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I did a prototype of UST instrumentation to record al=
l function entry/return of Python programs (works with CPython &gt;=3D 3).=
=C2=A0</div><div><br></div><div><a href=3D"http://git.dorsal.polymtl.ca/~fg=
iraldeau?p=3Dpython-profile-ust.git;a=3Dsummary">http://git.dorsal.polymtl.=
ca/~fgiraldeau?p=3Dpython-profile-ust.git;a=3Dsummary</a><br></div><div><br=
></div><div><div>Here is an example of the trace:<br></div></div><div><br><=
/div><div>$ ./go.sh</div><div>...</div><div><div><div>[16:50:17.443042690] =
(+0.000053969) berta python:call: { cpu_id =3D 6 }, { co_name =3D &quot;&lt=
;module&gt;&quot; }</div><div>[16:50:17.443056837] (+0.000014147) berta pyt=
hon:call: { cpu_id =3D 6 }, { co_name =3D &quot;cafe&quot; }</div></div></d=
iv><div><br></div><div>It works when only the event python:call is enabled.=
 When all events are enabled (lttng enable-event -a -u), then the python pr=
ogram hangs on a call to futex wait. It does not respond to CTRL-C signal, =
and must be killed. Here is the full stack trace in GDB, showing that it se=
ems related to the registration of tracef() probe. Below that, there is the=
 lttng-sessiond log. I reproduced the problem with lttng 2.5x stable and th=
e git master. Any idea about what can go wrong?=C2=A0</div><div><br></div><=
div>Thanks,</div><div><br></div><div>Francis</div><div><br></div><div>=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div><br></div><div>Program received signa=
l SIGSTOP, Stopped (signal).</div><div>0x00007ffff7bcaf2c in __lll_lock_wai=
t () from /lib/x86_64-linux-gnu/libpthread.so.0</div><div>(gdb) bt</div><di=
v>#0 =C2=A00x00007ffff7bcaf2c in __lll_lock_wait () from /lib/x86_64-linux-=
gnu/libpthread.so.0</div><div>#1 =C2=A00x00007ffff7bc6657 in _L_lock_909 ()=
 from /lib/x86_64-linux-gnu/libpthread.so.0</div><div>#2 =C2=A00x00007ffff7=
bc6480 in pthread_mutex_lock () from /lib/x86_64-linux-gnu/libpthread.so.0<=
/div><div>#3 =C2=A00x00007ffff6102aec in ust_lock_nocheck () at lttng-ust-c=
omm.c:150</div><div>#4 =C2=A00x00007ffff61083a5 in lttng_probe_register (</=
div><div>=C2=A0 =C2=A0 desc=3D0x7ffff633e9c0 &lt;__probe_desc___lttng_ust_t=
racef&gt;) at lttng-probes.c:204</div><div>#5 =C2=A00x00007ffff60fc301 in _=
_lttng_events_init__lttng_ust_tracef ()</div><div>=C2=A0 =C2=A0 at ../inclu=
de/lttng/ust-tracepoint-event.h:797</div><div>#6 =C2=A00x00007ffff7dea13a i=
n call_init (l=3D&lt;optimized out&gt;, argc=3Dargc@entry=3D2,=C2=A0</div><=
div>=C2=A0 =C2=A0 argv=3Dargv@entry=3D0x7fffffffdcf8, env=3Denv@entry=3D0x7=
fffffffdd10) at dl-init.c:78</div><div>#7 =C2=A00x00007ffff7dea223 in call_=
init (env=3D&lt;optimized out&gt;, argv=3D&lt;optimized out&gt;,=C2=A0</div=
><div>=C2=A0 =C2=A0 argc=3D&lt;optimized out&gt;, l=3D&lt;optimized out&gt;=
) at dl-init.c:36</div><div>#8 =C2=A0_dl_init (main_map=3Dmain_map@entry=3D=
0xafa730, argc=3D2, argv=3D0x7fffffffdcf8, env=3D0x7fffffffdd10)</div><div>=
=C2=A0 =C2=A0 at dl-init.c:126</div><div>#9 =C2=A00x00007ffff7deec70 in dl_=
open_worker (a=3Da@entry=3D0x7fffffffc1f8) at dl-open.c:577</div><div>#10 0=
x00007ffff7de9ff4 in _dl_catch_error (objname=3Dobjname@entry=3D0x7fffffffc=
1e8,=C2=A0</div><div>=C2=A0 =C2=A0 errstring=3Derrstring@entry=3D0x7fffffff=
c1f0, mallocedp=3Dmallocedp@entry=3D0x7fffffffc1e0,=C2=A0</div><div>=C2=A0 =
=C2=A0 operate=3Doperate@entry=3D0x7ffff7dee9a0 &lt;dl_open_worker&gt;, arg=
s=3Dargs@entry=3D0x7fffffffc1f8)</div><div>=C2=A0 =C2=A0 at dl-error.c:187<=
/div><div>#11 0x00007ffff7dee3bb in _dl_open (</div><div>=C2=A0 =C2=A0 file=
=3D0x7ffff6593f50 &quot;./build/lib.linux-x86_64-3.4/<a href=3D"http://lttn=
gProfile.cpython-34m.so">lttngProfile.cpython-34m.so</a>&quot;,=C2=A0</div>=
<div>=C2=A0 =C2=A0 mode=3D-2147483646, caller_dlopen=3D&lt;optimized out&gt=
;, nsid=3D-2, argc=3D2, argv=3D0x7fffffffdcf8,=C2=A0</div><div>=C2=A0 =C2=
=A0 env=3D0x7fffffffdd10) at dl-open.c:661</div><div>#12 0x00007ffff75f302b=
 in dlopen_doit (a=3Da@entry=3D0x7fffffffc410) at dlopen.c:66</div><div>#13=
 0x00007ffff7de9ff4 in _dl_catch_error (objname=3D0xadd910, errstring=3D0xa=
dd918, mallocedp=3D0xadd908,=C2=A0</div><div>=C2=A0 =C2=A0 operate=3D0x7fff=
f75f2fd0 &lt;dlopen_doit&gt;, args=3D0x7fffffffc410) at dl-error.c:187</div=
><div>#14 0x00007ffff75f362d in _dlerror_run (operate=3Doperate@entry=3D0x7=
ffff75f2fd0 &lt;dlopen_doit&gt;,=C2=A0</div><div>=C2=A0 =C2=A0 args=3Dargs@=
entry=3D0x7fffffffc410) at dlerror.c:163</div><div>#15 0x00007ffff75f30c1 i=
n __dlopen (file=3D&lt;optimized out&gt;, mode=3D&lt;optimized out&gt;) at =
dlopen.c:87</div><div>#16 0x000000000050fa6e in _PyImport_GetDynLoadFunc ()=
</div><div>#17 0x0000000000580f2d in ?? ()</div><div>#18 0x000000000057b98a=
 in PyEval_EvalFrameEx ()</div><div>#19 0x000000000057d3d3 in PyEval_EvalCo=
deEx ()</div><div>#20 0x000000000057bfaa in PyEval_EvalFrameEx ()</div><div=
>#21 0x000000000057d3d3 in PyEval_EvalCodeEx ()</div><div>#22 0x00000000005=
7e0eb in ?? ()</div><div>#23 0x000000000043810a in PyObject_Call ()</div><d=
iv>#24 0x0000000000579616 in PyEval_EvalFrameEx ()</div><div>#25 0x00000000=
0057d3d3 in PyEval_EvalCodeEx ()</div><div>#26 0x000000000057bfaa in PyEval=
_EvalFrameEx ()</div><div>#27 0x000000000057c0db in PyEval_EvalFrameEx ()</=
div><div>#28 0x000000000057c0db in PyEval_EvalFrameEx ()</div><div>#29 0x00=
0000000057c0db in PyEval_EvalFrameEx ()</div><div>#30 0x000000000057d3d3 in=
 PyEval_EvalCodeEx ()</div><div>#31 0x000000000057df80 in ?? ()</div><div>#=
32 0x000000000043810a in PyObject_Call ()</div><div>#33 0x000000000050c06b =
in _PyObject_CallMethodIdObjArgs ()</div><div>#34 0x00000000004bbda1 in PyI=
mport_ImportModuleLevelObject ()</div><div>#35 0x00000000005fa00b in ?? ()<=
/div><div>#36 0x000000000043810a in PyObject_Call ()</div><div>#37 0x000000=
00004367b8 in ?? ()</div><div>#38 0x0000000000578de9 in PyEval_EvalFrameEx =
()</div><div>#39 0x000000000057d3d3 in PyEval_EvalCodeEx ()</div><div>#40 0=
x000000000060ba83 in PyRun_FileExFlags ()</div><div>#41 0x000000000060bc85 =
in PyRun_SimpleFileExFlags ()</div><div>#42 0x000000000060d3ac in Py_Main (=
)</div><div>#43 0x000000000041ec0d in main ()</div><div>(gdb)=C2=A0</div><d=
iv><br></div><div><div>DEBUG1 - 16:56:11.529554 [21776/21781]: UST registra=
tion received with pid:21853 ppid:21833 uid:1000 gid:1000 sock:23 name:pyth=
on3 (version 6.0) (in thread_registration_apps() at main.c:2084)</div><div>=
DEBUG1 - 16:56:11.529580 [21776/21781]: Futex n to 1 wake done (in futex_nt=
o1_wake() at futex.c:105)</div><div>DEBUG1 - 16:56:11.529597 [21776/21781]:=
 Accepting application registration (in thread_registration_apps() at main.=
c:1976)</div><div>DEBUG1 - 16:56:11.529601 [21776/21780]: Futex n to 1 wait=
 done (in futex_nto1_wait() at futex.c:91)</div><div>DEBUG1 - 16:56:11.5296=
31 [21776/21780]: Futex n to 1 prepare done (in futex_nto1_prepare() at fut=
ex.c:76)</div><div>DEBUG1 - 16:56:11.529640 [21776/21780]: Dispatching UST =
registration pid:21853 ppid:21833 uid:1000 gid:1000 sock:23 name:python3 (v=
ersion 6.0) (in thread_dispatch_ust_registration() at main.c:1750)</div><di=
v>DEBUG1 - 16:56:11.529619 [21776/21781]: UST registration received with pi=
d:21853 ppid:21833 uid:1000 gid:1000 sock:30 name:python3 (version 6.0) (in=
 thread_registration_apps() at main.c:2084)</div><div>DEBUG1 - 16:56:11.529=
662 [21776/21781]: Futex n to 1 wake done (in futex_nto1_wake() at futex.c:=
105)</div><div>DEBUG1 - 16:56:11.529669 [21776/21781]: Accepting applicatio=
n registration (in thread_registration_apps() at main.c:1976)</div><div>DEB=
UG3 - 16:56:11.529676 [21776/21780]: UST app creating application for socke=
t 23 (in ust_app_create() at ust-app.c:2938)</div><div>DEBUG3 - 16:56:11.52=
9690 [21776/21780]: Created hashtable size 4 at 0x7fbf0c000a10 of type 2 (i=
n lttng_ht_new() at hashtable.c:128)</div><div>DEBUG3 - 16:56:11.529708 [21=
776/21780]: Created hashtable size 4 at 0x7fbf0c001150 of type 1 (in lttng_=
ht_new() at hashtable.c:128)</div><div>DEBUG1 - 16:56:11.529721 [21776/2178=
0]: Dispatching UST registration pid:21853 ppid:21833 uid:1000 gid:1000 soc=
k:30 name:python3 (version 6.0) (in thread_dispatch_ust_registration() at m=
ain.c:1750)</div><div>DEBUG3 - 16:56:11.529728 [21776/21780]: UST app notif=
y socket 30 is set (in thread_dispatch_ust_registration() at main.c:1807)</=
div><div>DEBUG1 - 16:56:11.529740 [21776/21780]: App registered with pid:21=
853 ppid:21833 uid:1000 gid:1000 sock:23 name:python3 notify_sock:30 (versi=
on 6.0) (in ust_app_add() at ust-app.c:3026)</div><div>DEBUG2 - 16:56:11.52=
9784 [21776/21780]: UST app global update for app sock 23 for session id 0 =
(in ust_app_global_update() at ust-app.c:4263)</div><div>DEBUG2 - 16:56:11.=
529809 [21776/21780]: UST app pid: 21853 session id 0 not found, creating i=
t (in create_ust_app_session() at ust-app.c:1847)</div><div>DEBUG3 - 16:56:=
11.529812 [21776/21783]: UST thread notify added sock 30 to pollset (in ust=
_thread_manage_notify() at ust-thread.c:138)</div><div>DEBUG3 - 16:56:11.52=
9836 [21776/21783]: [ust-thread] Manage notify polling on 3 fds (in ust_thr=
ead_manage_notify() at ust-thread.c:69)</div><div>DEBUG3 - 16:56:11.529826 =
[21776/21780]: Created hashtable size 4 at 0x7fbf0c002970 of type 0 (in ltt=
ng_ht_new() at hashtable.c:128)</div><div>DEBUG2 - 16:56:11.529859 [21776/2=
1780]: Shadow copy of session handle -1 (in shadow_copy_session() at ust-ap=
p.c:1603)</div><div>DEBUG2 - 16:56:11.529877 [21776/21780]: Channel channel=
0 not found on shadow session copy, creating it (in shadow_copy_session() a=
t ust-app.c:1653)</div><div>DEBUG3 - 16:56:11.529884 [21776/21780]: Created=
 hashtable size 4 at 0x7fbf0c0032f0 of type 1 (in lttng_ht_new() at hashtab=
le.c:128)</div><div>DEBUG3 - 16:56:11.529891 [21776/21780]: Created hashtab=
le size 4 at 0x7fbf0c003a30 of type 0 (in lttng_ht_new() at hashtable.c:128=
)</div><div>DEBUG3 - 16:56:11.529897 [21776/21780]: UST app channel channel=
0 allocated (in alloc_ust_app_channel() at ust-app.c:883)</div><div>DEBUG2 =
- 16:56:11.529906 [21776/21780]: UST app shadow copy of channel channel0 st=
arted (in shadow_copy_channel() at ust-app.c:1530)</div><div>DEBUG2 - 16:56=
:11.529914 [21776/21780]: UST event * not found on shadow copy channel (in =
shadow_copy_channel() at ust-app.c:1570)</div><div>DEBUG3 - 16:56:11.529929=
 [21776/21780]: UST app event * allocated (in alloc_ust_app_event() at ust-=
app.c:939)</div><div>DEBUG3 - 16:56:11.529937 [21776/21780]: UST app shadow=
 copy of channel channel0 done (in shadow_copy_channel() at ust-app.c:1580)=
</div><div>DEBUG3 - 16:56:11.529944 [21776/21780]: Buffer registry per UID =
find id: 0, ABI: 64, uid: 1000 (in buffer_reg_uid_find() at buffer-registry=
.c:196)</div><div>DEBUG3 - 16:56:11.529953 [21776/21780]: Created hashtable=
 size 4 at 0x7fbf0c004580 of type 2 (in lttng_ht_new() at hashtable.c:128)<=
/div><div>DEBUG3 - 16:56:11.529960 [21776/21780]: Buffer registry per UID c=
reated id: 0, ABI: 64, uid: 1000, domain: 2 (in buffer_reg_uid_create() at =
buffer-registry.c:145)</div><div>DEBUG3 - 16:56:11.529967 [21776/21780]: Bu=
ffer registry per UID adding to global registry with id: 0 (in buffer_reg_u=
id_add() at buffer-registry.c:167)</div><div>DEBUG3 - 16:56:11.529975 [2177=
6/21780]: Created hashtable size 4 at 0x7fbf0c004d60 of type 2 (in lttng_ht=
_new() at hashtable.c:128)</div><div>DEBUG3 - 16:56:11.530013 [21776/21780]=
: Append to metadata: &quot;typealias integer { size =3D 8; align =3D 8; si=
gned =3D false; } :=3D uint8_t;</div><div>typealias integer { size =3D 16; =
align =3D 8; signed =3D false; } :=3D uint16_t;</div><div>typealias integer=
 { size =3D 32; align =3D 8; signed =3D false; } :=3D uint32_t;</div><div>t=
ypealias integer { size =3D 64; align =3D 8; signed =3D false; } :=3D uint6=
4_t;</div><div>typealias integer { size =3D 64; align =3D 8; signed =3D fal=
se; } :=3D unsigned long;</div><div>typealias integer { size =3D 5; align =
=3D 1; signed =3D false; } :=3D uint5_t;</div><div>typealias integer { size=
 =3D 27; align =3D 1; signed =3D false; } :=3D uint27_t;</div><div><br></di=
v><div>trace {</div><div><span class=3D"" style=3D"white-space:pre">	</span=
>major =3D 1;</div><div><span class=3D"" style=3D"white-space:pre">	</span>=
minor =3D 8;</div><div><span class=3D"" style=3D"white-space:pre">	</span>u=
uid =3D &quot;54b830c0-b308-416b-98b8-a1dbd24a5c6c&quot;;</div><div><span c=
lass=3D"" style=3D"white-space:pre">	</span>byte_order =3D le;</div><div><s=
pan class=3D"" style=3D"white-space:pre">	</span>packet.header :=3D struct =
{</div><div><span class=3D"" style=3D"white-space:pre">		</span>uint32_t ma=
gic;</div><div><span class=3D"" style=3D"white-space:pre">		</span>uint8_t =
=C2=A0uuid[16];</div><div><span class=3D"" style=3D"white-space:pre">		</sp=
an>uint32_t stream_id;</div><div><span class=3D"" style=3D"white-space:pre"=
>	</span>};</div><div>};</div><div><br></div><div>&quot; (in lttng_metadata=
_printf() at ust-metadata.c:152)</div><div>DEBUG3 - 16:56:11.530114 [21776/=
21780]: Append to metadata: &quot;env {</div><div><span class=3D"" style=3D=
"white-space:pre">	</span>hostname =3D &quot;berta&quot;;</div><div><span c=
lass=3D"" style=3D"white-space:pre">	</span>domain =3D &quot;ust&quot;;</di=
v><div><span class=3D"" style=3D"white-space:pre">	</span>tracer_name =3D &=
quot;lttng-ust&quot;;</div><div><span class=3D"" style=3D"white-space:pre">=
	</span>tracer_major =3D 2;</div><div><span class=3D"" style=3D"white-space=
:pre">	</span>tracer_minor =3D 6;</div><div>&quot; (in lttng_metadata_print=
f() at ust-metadata.c:152)</div><div>DEBUG3 - 16:56:11.530164 [21776/21780]=
: Append to metadata: &quot;};</div><div><br></div><div>&quot; (in lttng_me=
tadata_printf() at ust-metadata.c:152)</div><div>DEBUG3 - 16:56:11.530176 [=
21776/21780]: Append to metadata: &quot;clock {</div><div><span class=3D"" =
style=3D"white-space:pre">	</span>name =3D monotonic;</div><div>&quot; (in =
lttng_metadata_printf() at ust-metadata.c:152)</div><div>DEBUG3 - 16:56:11.=
530214 [21776/21780]: Append to metadata: &quot;<span class=3D"" style=3D"w=
hite-space:pre">	</span>uuid =3D &quot;929f2bc9-1726-4628-a617-66b2a2d84c0b=
&quot;;</div><div>&quot; (in lttng_metadata_printf() at ust-metadata.c:152)=
</div><div>DEBUG3 - 16:56:11.530235 [21776/21780]: Append to metadata: &quo=
t;<span class=3D"" style=3D"white-space:pre">	</span>description =3D &quot;=
Monotonic Clock&quot;;</div><div><span class=3D"" style=3D"white-space:pre"=
>	</span>freq =3D 1000000000; /* Frequency, in Hz */</div><div><span class=
=3D"" style=3D"white-space:pre">	</span>/* clock value offset from Epoch is=
: offset * (1/freq) */</div><div><span class=3D"" style=3D"white-space:pre"=
>	</span>offset =3D 1409415126878138691;</div><div>};</div><div><br></div><=
div>&quot; (in lttng_metadata_printf() at ust-metadata.c:152)</div><div>DEB=
UG3 - 16:56:11.530272 [21776/21780]: Append to metadata: &quot;typealias in=
teger {</div><div><span class=3D"" style=3D"white-space:pre">	</span>size =
=3D 27; align =3D 1; signed =3D false;</div><div><span class=3D"" style=3D"=
white-space:pre">	</span>map =3D clock.monotonic.value;</div><div>} :=3D ui=
nt27_clock_monotonic_t;</div><div><br></div><div>typealias integer {</div><=
div><span class=3D"" style=3D"white-space:pre">	</span>size =3D 32; align =
=3D 8; signed =3D false;</div><div><span class=3D"" style=3D"white-space:pr=
e">	</span>map =3D clock.monotonic.value;</div><div>} :=3D uint32_clock_mon=
otonic_t;</div><div><br></div><div>typealias integer {</div><div><span clas=
s=3D"" style=3D"white-space:pre">	</span>size =3D 64; align =3D 8; signed =
=3D false;</div><div><span class=3D"" style=3D"white-space:pre">	</span>map=
 =3D clock.monotonic.value;</div><div>} :=3D uint64_clock_monotonic_t;</div=
><div><br></div><div>&quot; (in lttng_metadata_printf() at ust-metadata.c:1=
52)</div><div>DEBUG3 - 16:56:11.530337 [21776/21780]: Append to metadata: &=
quot;struct packet_context {</div><div><span class=3D"" style=3D"white-spac=
e:pre">	</span>uint64_clock_monotonic_t timestamp_begin;</div><div><span cl=
ass=3D"" style=3D"white-space:pre">	</span>uint64_clock_monotonic_t timesta=
mp_end;</div><div><span class=3D"" style=3D"white-space:pre">	</span>uint64=
_t content_size;</div><div><span class=3D"" style=3D"white-space:pre">	</sp=
an>uint64_t packet_size;</div><div><span class=3D"" style=3D"white-space:pr=
e">	</span>unsigned long events_discarded;</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>uint32_t cpu_id;</div><div>};</div><div><br></=
div><div>&quot; (in lttng_metadata_printf() at ust-metadata.c:152)</div><di=
v>DEBUG3 - 16:56:11.530387 [21776/21780]: Append to metadata: &quot;struct =
event_header_compact {</div><div><span class=3D"" style=3D"white-space:pre"=
>	</span>enum : uint5_t { compact =3D 0 ... 30, extended =3D 31 } id;</div>=
<div><span class=3D"" style=3D"white-space:pre">	</span>variant &lt;id&gt; =
{</div><div><span class=3D"" style=3D"white-space:pre">		</span>struct {</d=
iv><div><span class=3D"" style=3D"white-space:pre">			</span>uint27_clock_m=
onotonic_t timestamp;</div><div><span class=3D"" style=3D"white-space:pre">=
		</span>} compact;</div><div><span class=3D"" style=3D"white-space:pre">		=
</span>struct {</div><div><span class=3D"" style=3D"white-space:pre">			</s=
pan>uint32_t id;</div><div><span class=3D"" style=3D"white-space:pre">			</=
span>uint64_clock_monotonic_t timestamp;</div><div><span class=3D"" style=
=3D"white-space:pre">		</span>} extended;</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>} v;</div><div>} align(8);</div><div><br></div=
><div>struct event_header_large {</div><div><span class=3D"" style=3D"white=
-space:pre">	</span>enum : uint16_t { compact =3D 0 ... 65534, extended =3D=
 65535 } id;</div><div><span class=3D"" style=3D"white-space:pre">	</span>v=
ariant &lt;id&gt; {</div><div><span class=3D"" style=3D"white-space:pre">		=
</span>struct {</div><div><span class=3D"" style=3D"white-space:pre">			</s=
pan>uint32_clock_monotonic_t timestamp;</div><div><span class=3D"" style=3D=
"white-space:pre">		</span>} compact;</div><div><span class=3D"" style=3D"w=
hite-space:pre">		</span>struct {</div><div><span class=3D"" style=3D"white=
-space:pre">			</span>uint32_t id;</div><div><span class=3D"" style=3D"whit=
e-space:pre">			</span>uint64_clock_monotonic_t timestamp;</div><div><span =
class=3D"" style=3D"white-space:pre">		</span>} extended;</div><div><span c=
lass=3D"" style=3D"white-space:pre">	</span>} v;</div><div>} align(8);</div=
><div><br></div><div>&quot; (in lttng_metadata_printf() at ust-metadata.c:1=
52)</div><div>DEBUG3 - 16:56:11.530549 [21776/21780]: UST app buffer regist=
ry per UID created successfully (in setup_buffer_reg_uid() at ust-app.c:180=
9)</div><div>DEBUG2 - 16:56:11.530608 [21776/21780]: UST app session create=
d successfully with handle 1 (in create_ust_app_session() at ust-app.c:1915=
)</div><div>DEBUG1 - 16:56:11.530626 [21776/21780]: UST app creating channe=
l channel0 with per UID buffers (in create_channel_per_uid() at ust-app.c:2=
508)</div><div>DEBUG3 - 16:56:11.530635 [21776/21780]: Buffer registry per =
UID find id: 0, ABI: 64, uid: 1000 (in buffer_reg_uid_find() at buffer-regi=
stry.c:196)</div><div>DEBUG2 - 16:56:11.530642 [21776/21780]: UST app creat=
ing buffer registry channel for channel0 (in create_buffer_reg_channel() at=
 ust-app.c:2361)</div><div>DEBUG3 - 16:56:11.530649 [21776/21780]: Buffer r=
egistry channel create with key: 0 (in buffer_reg_channel_create() at buffe=
r-registry.c:327)</div><div>DEBUG3 - 16:56:11.530658 [21776/21780]: Created=
 hashtable size 4 at 0x7fbf0c0055b0 of type 0 (in lttng_ht_new() at hashtab=
le.c:128)</div><div>DEBUG2 - 16:56:11.530671 [21776/21780]: Asking UST cons=
umer for channel (in ask_channel_creation() at ust-consumer.c:119)</div><di=
v>DEBUG3 - 16:56:11.530682 [21776/21780]: mkdir() recursive /home/francis/l=
ttng-traces/auto-20141127-165611/ust/uid/1000/64-bit with mode 504 for uid =
1000 and gid 1000 (in run_as_mkdir_recursive() at runas.c:309)</div><div>DE=
BUG1 - 16:56:11.530691 [21776/21780]: Using run_as_clone (in run_as() at ru=
nas.c:292)</div><div>DEBUG3 - 16:56:11.531579 [21776/21780]: UST registry c=
hannel finding key 0 (in ust_registry_channel_find() at ust-registry.c:490)=
</div><div>DEBUG2 - 16:56:11.557620 [21776/21780]: UST ask channel 1 succes=
sfully done with 8 stream(s) (in ask_channel_creation() at ust-consumer.c:1=
96)</div><div>DEBUG2 - 16:56:11.557724 [21776/21780]: UST app stream 1 rece=
ived successfully (in ust_consumer_get_channel() at ust-consumer.c:312)</di=
v><div>DEBUG2 - 16:56:11.557754 [21776/21780]: UST app stream 2 received su=
ccessfully (in ust_consumer_get_channel() at ust-consumer.c:312)</div><div>=
DEBUG2 - 16:56:11.557776 [21776/21780]: UST app stream 3 received successfu=
lly (in ust_consumer_get_channel() at ust-consumer.c:312)</div><div>DEBUG2 =
- 16:56:11.557796 [21776/21780]: UST app stream 4 received successfully (in=
 ust_consumer_get_channel() at ust-consumer.c:312)</div><div>DEBUG2 - 16:56=
:11.557816 [21776/21780]: UST app stream 5 received successfully (in ust_co=
nsumer_get_channel() at ust-consumer.c:312)</div><div>DEBUG2 - 16:56:11.557=
838 [21776/21780]: UST app stream 6 received successfully (in ust_consumer_=
get_channel() at ust-consumer.c:312)</div><div>DEBUG2 - 16:56:11.557853 [21=
776/21780]: UST app stream 7 received successfully (in ust_consumer_get_cha=
nnel() at ust-consumer.c:312)</div><div>DEBUG2 - 16:56:11.557867 [21776/217=
80]: UST app stream 8 received successfully (in ust_consumer_get_channel() =
at ust-consumer.c:312)</div><div>DEBUG3 - 16:56:11.557882 [21776/21780]: US=
T app consumer has no more stream available (in ust_consumer_get_channel() =
at ust-consumer.c:295)</div><div>DEBUG2 - 16:56:11.557893 [21776/21780]: US=
T app setup buffer registry channel for channel0 (in setup_buffer_reg_chann=
el() at ust-app.c:2409)</div><div>DEBUG2 - 16:56:11.557902 [21776/21780]: U=
ST app setup buffer registry stream (in setup_buffer_reg_streams() at ust-a=
pp.c:2316)</div><div>DEBUG3 - 16:56:11.557910 [21776/21780]: Buffer registr=
y creating stream (in buffer_reg_stream_create() at buffer-registry.c:357)<=
/div><div>DEBUG3 - 16:56:11.557920 [21776/21780]: Buffer registry creating =
stream (in buffer_reg_stream_create() at buffer-registry.c:357)</div><div>D=
EBUG3 - 16:56:11.557927 [21776/21780]: Buffer registry creating stream (in =
buffer_reg_stream_create() at buffer-registry.c:357)</div><div>DEBUG3 - 16:=
56:11.557935 [21776/21780]: Buffer registry creating stream (in buffer_reg_=
stream_create() at buffer-registry.c:357)</div><div>DEBUG3 - 16:56:11.55794=
4 [21776/21780]: Buffer registry creating stream (in buffer_reg_stream_crea=
te() at buffer-registry.c:357)</div><div>DEBUG3 - 16:56:11.557951 [21776/21=
780]: Buffer registry creating stream (in buffer_reg_stream_create() at buf=
fer-registry.c:357)</div><div>DEBUG3 - 16:56:11.557959 [21776/21780]: Buffe=
r registry creating stream (in buffer_reg_stream_create() at buffer-registr=
y.c:357)</div><div>DEBUG3 - 16:56:11.557968 [21776/21780]: Buffer registry =
creating stream (in buffer_reg_stream_create() at buffer-registry.c:357)</d=
iv><div>DEBUG1 - 16:56:11.557976 [21776/21780]: UST app sending buffer regi=
stry channel to ust sock 23 (in send_channel_uid_to_ust() at ust-app.c:2445=
)</div><div>DEBUG2 - 16:56:11.557988 [21776/21780]: UST app send channel to=
 sock 23 pid 21853 (name: channel0, key: 0) (in ust_consumer_send_channel_t=
o_ust() at ust-consumer.c:416)</div><div>DEBUG2 - 16:56:11.558248 [21776/21=
780]: UST consumer send stream to app 23 (in ust_consumer_send_stream_to_us=
t() at ust-consumer.c:381)</div><div>DEBUG2 - 16:56:11.558342 [21776/21780]=
: UST consumer send stream to app 23 (in ust_consumer_send_stream_to_ust() =
at ust-consumer.c:381)</div><div>DEBUG2 - 16:56:11.558400 [21776/21780]: US=
T consumer send stream to app 23 (in ust_consumer_send_stream_to_ust() at u=
st-consumer.c:381)</div><div>DEBUG2 - 16:56:11.558449 [21776/21780]: UST co=
nsumer send stream to app 23 (in ust_consumer_send_stream_to_ust() at ust-c=
onsumer.c:381)</div><div>DEBUG2 - 16:56:11.558487 [21776/21780]: UST consum=
er send stream to app 23 (in ust_consumer_send_stream_to_ust() at ust-consu=
mer.c:381)</div><div>DEBUG2 - 16:56:11.558529 [21776/21780]: UST consumer s=
end stream to app 23 (in ust_consumer_send_stream_to_ust() at ust-consumer.=
c:381)</div><div>DEBUG2 - 16:56:11.558567 [21776/21780]: UST consumer send =
stream to app 23 (in ust_consumer_send_stream_to_ust() at ust-consumer.c:38=
1)</div><div>DEBUG2 - 16:56:11.558604 [21776/21780]: UST consumer send stre=
am to app 23 (in ust_consumer_send_stream_to_ust() at ust-consumer.c:381)</=
div><div>DEBUG2 - 16:56:11.558672 [21776/21780]: UST app event * created su=
ccessfully for pid:21853 (in create_ust_event() at ust-app.c:1429)</div><di=
v>DEBUG2 - 16:56:11.558703 [21776/21780]: UST app event * enabled successfu=
lly for app (pid: 21853) (in enable_ust_event() at ust-app.c:1341)</div><di=
v>DEBUG1 - 16:56:11.558713 [21776/21780]: Starting tracing for ust app pid =
21853 (in ust_app_start_trace() at ust-app.c:3832)</div><div>DEBUG3 - 16:56=
:11.558723 [21776/21780]: mkdir() recursive /home/francis/lttng-traces/auto=
-20141127-165611 with mode 504 for uid 1000 and gid 1000 (in run_as_mkdir_r=
ecursive() at runas.c:309)</div><div>DEBUG1 - 16:56:11.558733 [21776/21780]=
: Using run_as_clone (in run_as() at runas.c:292)</div><div>DEBUG3 - 16:56:=
11.559632 [21776/21780]: Buffer registry per UID find id: 0, ABI: 64, uid: =
1000 (in buffer_reg_uid_find() at buffer-registry.c:196)</div><div>DEBUG3 -=
 16:56:11.559663 [21776/21780]: Created hashtable size 4 at 0x7fbf0c008ed0 =
of type 1 (in lttng_ht_new() at hashtable.c:128)</div><div>DEBUG3 - 16:56:1=
1.559676 [21776/21780]: Created hashtable size 4 at 0x7fbf0c009800 of type =
0 (in lttng_ht_new() at hashtable.c:128)</div><div>DEBUG3 - 16:56:11.559684=
 [21776/21780]: UST app channel metadata allocated (in alloc_ust_app_channe=
l() at ust-app.c:883)</div><div>DEBUG2 - 16:56:11.559696 [21776/21780]: Ask=
ing UST consumer for channel (in ask_channel_creation() at ust-consumer.c:1=
19)</div><div>DEBUG3 - 16:56:11.559710 [21776/21780]: mkdir() recursive /ho=
me/francis/lttng-traces/auto-20141127-165611/ust/uid/1000/64-bit with mode =
504 for uid 1000 and gid 1000 (in run_as_mkdir_recursive() at runas.c:309)<=
/div><div>DEBUG1 - 16:56:11.559720 [21776/21780]: Using run_as_clone (in ru=
n_as() at runas.c:292)</div><div>DEBUG2 - 16:56:11.561817 [21776/21780]: US=
T ask channel 2 successfully done with 1 stream(s) (in ask_channel_creation=
() at ust-consumer.c:196)</div><div>DEBUG2 - 16:56:11.561860 [21776/21780]:=
 Consumer setup metadata channel key 2 (in consumer_setup_metadata() at con=
sumer.c:1206)</div><div>DEBUG2 - 16:56:11.561916 [21776/21780]: UST metadat=
a with key 2 created for app pid 21853 (in create_ust_app_metadata() at ust=
-app.c:2890)</div><div>DEBUG3 - 16:56:11.561932 [21776/21780]: UST app dele=
ting channel metadata (in delete_ust_app_channel() at ust-app.c:375)</div><=
div>DEBUG3 - 16:56:11.562035 [21776/21777]: [ht-thread] Polling on 2 fds. (=
in thread_ht_cleanup() at ht-cleanup.c:65)</div><div>DEBUG3 - 16:56:11.5620=
66 [21776/21777]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup() at =
ht-cleanup.c:65)</div><div>DEBUG3 - 16:56:11.562051 [21776/21783]: UST app =
receiving notify from sock 30 (in ust_app_recv_notify() at ust-app.c:4820)<=
/div><div>DEBUG2 - 16:56:11.562103 [21776/21783]: UST app ustctl register c=
hannel received (in ust_app_recv_notify() at ust-app.c:4873)</div><div>DEBU=
G3 - 16:56:11.562118 [21776/21783]: Buffer registry per UID find id: 0, ABI=
: 64, uid: 1000 (in buffer_reg_uid_find() at buffer-registry.c:196)</div><d=
iv>DEBUG3 - 16:56:11.562131 [21776/21783]: UST registry channel finding key=
 0 (in ust_registry_channel_find() at ust-registry.c:490)</div><div>DEBUG3 =
- 16:56:11.562159 [21776/21783]: Append to metadata: &quot;stream {</div><d=
iv><span class=3D"" style=3D"white-space:pre">	</span>id =3D 0;</div><div><=
span class=3D"" style=3D"white-space:pre">	</span>event.header :=3D struct =
event_header_compact;</div><div><span class=3D"" style=3D"white-space:pre">=
	</span>packet.context :=3D struct packet_context;</div><div>&quot; (in ltt=
ng_metadata_printf() at ust-metadata.c:152)</div><div>DEBUG3 - 16:56:11.562=
194 [21776/21783]: Append to metadata: &quot;};</div><div><br></div><div>&q=
uot; (in lttng_metadata_printf() at ust-metadata.c:152)</div><div>DEBUG3 - =
16:56:11.562209 [21776/21783]: UST app replying to register channel key 0 w=
ith id 0, type: 1, ret: 0 (in reply_ust_register_channel() at ust-app.c:468=
6)</div><div>DEBUG3 - 16:56:11.562223 [21776/21783]: [ust-thread] Manage no=
tify polling on 3 fds (in ust_thread_manage_notify() at ust-thread.c:69)</d=
iv><div>DEBUG3 - 16:56:11.562265 [21776/21783]: UST app receiving notify fr=
om sock 30 (in ust_app_recv_notify() at ust-app.c:4820)</div><div>DEBUG2 - =
16:56:11.562278 [21776/21783]: UST app ustctl register event received (in u=
st_app_recv_notify() at ust-app.c:4840)</div><div>DEBUG3 - 16:56:11.562296 =
[21776/21783]: Buffer registry per UID find id: 0, ABI: 64, uid: 1000 (in b=
uffer_reg_uid_find() at buffer-registry.c:196)</div><div>DEBUG3 - 16:56:11.=
562306 [21776/21783]: UST registry channel finding key 0 (in ust_registry_c=
hannel_find() at ust-registry.c:490)</div><div>DEBUG3 - 16:56:11.562314 [21=
776/21783]: UST registry creating event with event: ust_baddr_statedump:soi=
nfo, sig: struct lttng_session *, session, void *, baddr, const char*, sopa=
th, int64_t, size, int64_t, mtime, id: 0, chan_objd: 2, sess_objd: 1, chan_=
id: 0 (in ust_registry_create_event() at ust-registry.c:299)</div><div>DEBU=
G3 - 16:56:11.562326 [21776/21783]: Append to metadata: &quot;event {</div>=
<div><span class=3D"" style=3D"white-space:pre">	</span>name =3D &quot;ust_=
baddr_statedump:soinfo&quot;;</div><div><span class=3D"" style=3D"white-spa=
ce:pre">	</span>id =3D 0;</div><div><span class=3D"" style=3D"white-space:p=
re">	</span>stream_id =3D 0;</div><div>&quot; (in lttng_metadata_printf() a=
t ust-metadata.c:152)</div><div>DEBUG3 - 16:56:11.562360 [21776/21783]: App=
end to metadata: &quot;<span class=3D"" style=3D"white-space:pre">	</span>l=
oglevel =3D 13;</div><div>&quot; (in lttng_metadata_printf() at ust-metadat=
a.c:152)</div><div>DEBUG3 - 16:56:11.562378 [21776/21783]: Append to metada=
ta: &quot;<span class=3D"" style=3D"white-space:pre">	</span>fields :=3D st=
ruct {</div><div>&quot; (in lttng_metadata_printf() at ust-metadata.c:152)<=
/div><div>DEBUG3 - 16:56:11.562397 [21776/21783]: Append to metadata: &quot=
;<span class=3D"" style=3D"white-space:pre">		</span>integer { size =3D 64;=
 align =3D 8; signed =3D 0; encoding =3D none; base =3D 16; } _baddr;</div>=
<div>&quot; (in lttng_metadata_printf() at ust-metadata.c:152)</div><div>DE=
BUG3 - 16:56:11.562418 [21776/21783]: Append to metadata: &quot;<span class=
=3D"" style=3D"white-space:pre">		</span>string _sopath;</div><div>&quot; (=
in lttng_metadata_printf() at ust-metadata.c:152)</div><div>DEBUG3 - 16:56:=
11.562439 [21776/21783]: Append to metadata: &quot;<span class=3D"" style=
=3D"white-space:pre">		</span>integer { size =3D 64; align =3D 8; signed =
=3D 1; encoding =3D none; base =3D 10; } _size;</div><div>&quot; (in lttng_=
metadata_printf() at ust-metadata.c:152)</div><div>DEBUG3 - 16:56:11.562460=
 [21776/21783]: Append to metadata: &quot;<span class=3D"" style=3D"white-s=
pace:pre">		</span>integer { size =3D 64; align =3D 8; signed =3D 1; encodi=
ng =3D none; base =3D 10; } _mtime;</div><div>&quot; (in lttng_metadata_pri=
ntf() at ust-metadata.c:152)</div><div>DEBUG3 - 16:56:11.562480 [21776/2178=
3]: Append to metadata: &quot;<span class=3D"" style=3D"white-space:pre">	<=
/span>};</div><div>};</div><div><br></div><div>&quot; (in lttng_metadata_pr=
intf() at ust-metadata.c:152)</div><div>DEBUG3 - 16:56:11.562508 [21776/217=
83]: UST registry event ust_baddr_statedump:soinfo with id 0 added successf=
ully (in add_event_ust_registry() at ust-app.c:4801)</div><div>DEBUG3 - 16:=
56:11.562518 [21776/21783]: [ust-thread] Manage notify polling on 3 fds (in=
 ust_thread_manage_notify() at ust-thread.c:69)</div><div>DEBUG2 - 16:56:11=
.562570 [21776/21780]: UST trace started for app pid 21853 (in ust_app_glob=
al_update() at ust-app.c:4337)</div><div>DEBUG1 - 16:56:11.562633 [21776/21=
780]: Woken up but nothing in the UST command queue (in thread_dispatch_ust=
_registration() at main.c:1738)</div><div>DEBUG1 - 16:56:11.562645 [21776/2=
1780]: Futex n to 1 wait done (in futex_nto1_wait() at futex.c:91)</div><di=
v>DEBUG1 - 16:56:11.562656 [21776/21780]: Futex n to 1 prepare done (in fut=
ex_nto1_prepare() at futex.c:76)</div><div>DEBUG1 - 16:56:11.562667 [21776/=
21780]: Woken up but nothing in the UST command queue (in thread_dispatch_u=
st_registration() at main.c:1738)</div><div>DEBUG1 - 16:56:11.562648 [21776=
/21782]: Apps with sock 23 added to poll set (in thread_manage_apps() at ma=
in.c:1520)</div><div>DEBUG1 - 16:56:11.562703 [21776/21782]: Apps thread po=
lling on 3 fds (in thread_manage_apps() at main.c:1459)</div></div><div><br=
></div></div>

--001a11399f4c2836fa0508de326d--


--===============1988019994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1988019994==--
