From: Per Nilsson <per.e.nilsson@ericsson.com>
Subject: User space tracing
Date: Mon, 10 Sep 2012 09:32:31 +0200
Message-ID: <DE728318E75C3C48BBA6F3B0C02651542F1D9EC81B__11349.0502386869$1347287280$gmane$org@ESESSCMS0360.eemea.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0682009610=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailgw2.ericsson.se ([193.180.251.37])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <per.e.nilsson@ericsson.com>) id 1TAyU0-0002nr-F4
	for lttng-dev@lists.lttng.org; Mon, 10 Sep 2012 03:32:37 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0682009610==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DE728318E75C3C48BBA6F3B0C02651542F1D9EC81BESESSCMS0360e_"

--_000_DE728318E75C3C48BBA6F3B0C02651542F1D9EC81BESESSCMS0360e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
I am trying to get started with userspace tracing with LTTng, but I am havi=
ng a hard time to get it to work.
I'm using Ubunto 11.04, with kernel version: 2.6.38-8-generic.

I downloaded and compiled the following lttng software:

Userspace-rcu-0.7.4
Lttng-ust-2.0.5
Lttng-tools-2-0.4
Babeltrace-1.0.0-rc5

Maybe some one can tell me what is wrong.

// This is command line command I use to start the trace session.

per@per-VirtualBox:~$ sudo lttng create foo
[sudo] password for per:
Session foo created.
Traces will be written in /home/per/lttng-traces/foo-20120905-135905
per@per-VirtualBox:~$ sudo lttng enable-event -a -u
All UST events are enabled in channel channel0
per@per-VirtualBox:~$ sudo lttng start
Tracing started for session foo
per@per-VirtualBox:~$ sudo lttng stop
Tracing stopped for session foo
per@per-VirtualBox:~$ sudo ls /home/per/lttng-traces/foo-20120905-135905/us=
t
per@per-VirtualBox:~$ sudo babeltrace /home/per/lttng-traces/foo-20120905-1=
35905/ust
[error] Cannot open any trace for reading.

[error] opening trace "/home/per/lttng-traces/foo-20120905-135905/ust" for =
reading.

[error] none of the specified trace paths could be opened.

// This is the traces from the lttng-sessiond

per@per-VirtualBox:~$ sudo lttng-sessiond --verbose --verbose-consumer
DEBUG3: Creating LTTng run directory: /var/run/lttng [in create_lttng_rundi=
r() at main.c:4317]
DEBUG1: Client socket path /var/run/lttng/client-lttng-sessiond [in main() =
at main.c:4609]
DEBUG1: Application socket path /var/run/lttng/apps-lttng-sessiond [in main=
() at main.c:4610]
DEBUG1: LTTng run directory path: /var/run/lttng [in main() at main.c:4611]
DEBUG3: Created hashtable size 4 at 0x1d4e0a0 of type 1 [in lttng_ht_new() =
at hashtable.c:96]
DEBUG3: Created hashtable size 4 at 0x1d4e340 of type 1 [in lttng_ht_new() =
at hashtable.c:96]
FATAL: Module lttng_tracer not found.
Error: Unable to load module lttng-tracer
DEBUG1: Failed to open /proc/lttng [in init_kernel_tracer() at main.c:1871]
Error: Unable to remove module lttng-tracer
Warning: No kernel tracer available
DEBUG1: Signal handler set for SIGTERM, SIGPIPE and SIGINT [in set_signal_h=
andler() at main.c:4451]
Warning: No tracing group detected
DEBUG1: epoll set max size is 100188 [in compat_epoll_set_max_size() at com=
pat-epoll.c:224]
DEBUG1: Thread manage kernel started [in thread_manage_kernel() at main.c:8=
76]
DEBUG1: Updating kernel poll set [in update_kernel_poll() at main.c:748]
DEBUG1: Thread kernel polling on 2 fds [in thread_manage_kernel() at main.c=
:905]
DEBUG1: [thread] Manage application started [in thread_manage_apps() at mai=
n.c:1179]
DEBUG1: Apps thread polling on 2 fds [in thread_manage_apps() at main.c:120=
0]
DEBUG1: [thread] Manage application registration started [in thread_registr=
ation_apps() at main.c:1392]
DEBUG1: Notifying applications of session daemon state: 1 [in notify_ust_ap=
ps() at main.c:687]
DEBUG1: Got the wait shm fd 17 [in get_wait_shm() at shm.c:117]
DEBUG1: Futex wait update active 1 [in futex_wait_update() at futex.c:62]
DEBUG1: Accepting application registration [in thread_registration_apps() a=
t main.c:1423]
DEBUG1: [thread] Dispatch UST command started [in thread_dispatch_ust_regis=
tration() at main.c:1324]
DEBUG1: Futex n to 1 prepare done [in futex_nto1_prepare() at futex.c:73]
DEBUG1: Woken up but nothing in the UST command queue [in thread_dispatch_u=
st_registration() at main.c:1334]
DEBUG1: [thread] Manage client started [in thread_manage_clients() at main.=
c:3794]
DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:=
3826]
DEBUG1: Wait for client response [in thread_manage_clients() at main.c:3863=
]
DEBUG1: Receiving data from client ... [in thread_manage_clients() at main.=
c:3898]
DEBUG1: Nothing recv() from client... continuing [in thread_manage_clients(=
) at main.c:3902]
DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:5=
34]
DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:=
3826]
DEBUG1: Wait for client response [in thread_manage_clients() at main.c:3863=
]
DEBUG1: Receiving data from client ... [in thread_manage_clients() at main.=
c:3898]
DEBUG1: Processing client command 8 [in process_client_msg() at main.c:3309=
]
DEBUG3: mkdir() recursive /home/per/lttng-traces/foo-20120905-135905 with m=
ode 504 for uid 0 and gid 0 [in run_as_mkdir_recursive() at runas.c:339]
DEBUG1: Using run_as_clone [in run_as() at runas.c:323]
DEBUG1: Tracing session foo created in /home/per/lttng-traces/foo-20120905-=
135905 with ID 1 by UID 0 GID 0 [in session_create() at session.c:232]
DEBUG1: Sending response (size: 16, retcode: Success) [in thread_manage_cli=
ents() at main.c:3936]
DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:5=
34]
DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:=
3826]
DEBUG1: Wait for client response [in thread_manage_clients() at main.c:3863=
]
DEBUG1: Receiving data from client ... [in thread_manage_clients() at main.=
c:3898]
DEBUG1: Nothing recv() from client... continuing [in thread_manage_clients(=
) at main.c:3902]
DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:5=
34]
DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:=
3826]
DEBUG1: Wait for client response [in thread_manage_clients() at main.c:3863=
]
DEBUG1: Receiving data from client ... [in thread_manage_clients() at main.=
c:3898]
DEBUG1: Processing client command 6 [in process_client_msg() at main.c:3309=
]
DEBUG1: Getting session foo by name [in process_client_msg() at main.c:3364=
]
DEBUG1: Creating UST session [in create_ust_session() at main.c:1965]
DEBUG3: Created hashtable size 4 at 0x1d55840 of type 1 [in lttng_ht_new() =
at hashtable.c:96]
DEBUG3: Created hashtable size 4 at 0x1d55b00 of type 1 [in lttng_ht_new() =
at hashtable.c:96]
DEBUG3: Created hashtable size 4 at 0x1d55dc0 of type 0 [in lttng_ht_new() =
at hashtable.c:96]
DEBUG3: mkdir() recursive /home/per/lttng-traces/foo-20120905-135905/ust wi=
th mode 504 for uid 0 and gid 0 [in run_as_mkdir_recursive() at runas.c:339=
]
DEBUG1: Using run_as_clone [in run_as() at runas.c:323]
DEBUG1: Spawning consumerd [in spawn_consumerd() at main.c:1659]
DEBUG1: [thread] Manage consumer started [in thread_manage_consumer() at ma=
in.c:982]
DEBUG1: Using 64-bit UST consumer at: /usr/local/lib/lttng/libexec/lttng-co=
nsumerd [in spawn_consumerd() at main.c:1733]
DEBUG3: Created hashtable size 4 at 0x247d030 of type 1 [in lttng_ht_new() =
at hashtable.c:96]
DEBUG3: Created hashtable size 4 at 0x247d2f0 of type 1 [in lttng_ht_new() =
at hashtable.c:96]
DEBUG1: Connecting to error socket /var/run/lttng/ustconsumerd64/error [in =
main() at lttng-consumerd.c:349]
DEBUG1: Updating poll fd array [in consumer_update_poll_array() at consumer=
.c:521]
DEBUG1: polling on 1 fd [in lttng_consumer_thread_poll_fds() at consumer.c:=
1013]
DEBUG1: Creating command socket /var/run/lttng/ustconsumerd64/command [in l=
ttng_consumer_thread_receive_fds() at consumer.c:1160]
DEBUG1: Sending ready command to lttng-sessiond [in lttng_consumer_thread_r=
eceive_fds() at consumer.c:1173]
DEBUG1: consumer command socket ready [in thread_manage_consumer() at main.=
c:1062]
DEBUG3: Created hashtable size 4 at 0x1d57720 of type 0 [in lttng_ht_new() =
at hashtable.c:96]
DEBUG3: Created hashtable size 4 at 0x1d579e0 of type 1 [in lttng_ht_new() =
at hashtable.c:96]
DEBUG3: Created hashtable size 4 at 0x1d57f00 of type 1 [in lttng_ht_new() =
at hashtable.c:96]
DEBUG1: UST app creating event * for all apps for session id 1 [in ust_app_=
create_event_glb() at ust-app.c:1916]
DEBUG1: Event UST * created in channel channel0 [in event_ust_enable_tracep=
oint() at event.c:486]
DEBUG1: Sending response (size: 16, retcode: Success) [in thread_manage_cli=
ents() at main.c:3936]
DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:5=
34]
DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:=
3826]
DEBUG1: Connection on client_socket [in lttng_consumer_thread_receive_fds()=
 at consumer.c:1196]
DEBUG1: Wait for client response [in thread_manage_clients() at main.c:3863=
]
DEBUG1: Receiving data from client ... [in thread_manage_clients() at main.=
c:3898]
DEBUG1: Nothing recv() from client... continuing [in thread_manage_clients(=
) at main.c:3902]
DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:5=
34]
DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:=
3826]
DEBUG1: Wait for client response [in thread_manage_clients() at main.c:3863=
]
DEBUG1: Receiving data from client ... [in thread_manage_clients() at main.=
c:3898]
DEBUG1: Processing client command 16 [in process_client_msg() at main.c:330=
9]
DEBUG1: Getting session foo by name [in process_client_msg() at main.c:3364=
]
DEBUG1: Starting all UST traces [in ust_app_start_trace_all() at ust-app.c:=
2207]
DEBUG1: Sending response (size: 16, retcode: Success) [in thread_manage_cli=
ents() at main.c:3936]
DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:5=
34]
DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:=
3826]
DEBUG1: Wait for client response [in thread_manage_clients() at main.c:3863=
]
DEBUG1: Receiving data from client ... [in thread_manage_clients() at main.=
c:3898]
DEBUG1: Nothing recv() from client... continuing [in thread_manage_clients(=
) at main.c:3902]
DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:5=
34]
DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:=
3826]
DEBUG1: Wait for client response [in thread_manage_clients() at main.c:3863=
]
DEBUG1: Receiving data from client ... [in thread_manage_clients() at main.=
c:3898]
DEBUG1: Processing client command 17 [in process_client_msg() at main.c:330=
9]
DEBUG1: Getting session foo by name [in process_client_msg() at main.c:3364=
]
DEBUG1: Stopping all UST traces [in ust_app_stop_trace_all() at ust-app.c:2=
233]
DEBUG1: Sending response (size: 16, retcode: Success) [in thread_manage_cli=
ents() at main.c:3936]
DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:5=
34]
DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:=
3826]

// this is the traces from the small test application

per@per-VirtualBox:/usr/local/src/lttng-ust-2.0.5/doc/examples/gen-tp$ expo=
rt LTTNG_UST_DEBUG=3D1
per@per-VirtualBox:/usr/local/src/lttng-ust-2.0.5/doc/examples/gen-tp$ ./sa=
mple liblttng_ust_tracepoint[1748/1748]: just registered a tracepoints sect=
ion from 0x7f431694fc38 and having 1 tracepoints (in tracepoint_register_li=
b() at tracepoint.c:641)
liblttng_ust_tracepoint[1748/1748]: registered tracepoint: lttng_ust:metada=
ta (in tracepoint_register_lib() at tracepoint.c:646)
libust[1748/1748]: LTT : ltt ring buffer client init
 (in ltt_ring_buffer_metadata_client_init() at ltt-ring-buffer-metadata-cli=
ent.h:334)
libust[1748/1748]: LTT : ltt ring buffer client init
 (in ltt_ring_buffer_client_overwrite_init() at ltt-ring-buffer-client.h:58=
4)
libust[1748/1748]: LTT : ltt ring buffer client init
 (in ltt_ring_buffer_client_discard_init() at ltt-ring-buffer-client.h:584)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Waiting for local apps sessiond (in wait_for_sessiond() =
at lttng-ust-comm.c:638)
libust[1748/1750]: Linux kernels 2.6.33 to 3.0 (with the exception of stabl=
e versions) do not support FUTEX_WAKE on read-only memory mappings correctl=
y. Please upgrade your kernel (fix is commit 9ea71503a8ed9184d2d0b8ccc4d269=
d05f7940ae in Linux kernel mainline). LTTng-UST will use polling mode fallb=
ack. (in wait_for_sessiond() at lttng-ust-comm.c:651)
libust[1748/1750]: Error: futex: Bad address (in wait_for_sessiond() at ltt=
ng-ust-comm.c:653)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1748]: just registered probe sample_tracepoint containing 1 eve=
nts (in ltt_probe_register() at ltt-probes.c:109)
libust[1748/1748]: Registered event probe "sample_tracepoint:message" with =
signature "char *, text" (in ltt_probe_register() at ltt-probes.c:118)
liblttng_ust_tracepoint[1748/1748]: just registered a tracepoints section f=
rom 0x602138 and having 1 tracepoints (in tracepoint_register_lib() at trac=
epoint.c:641)
liblttng_ust_tracepoint[1748/1748]: registered tracepoint: sample_tracepoin=
t:message (in tracepoint_register_lib() at tracepoint.c:646)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1749]: Info: sessiond not accepting connections to global apps =
socket (in ust_listener_thread() at lttng-ust-comm.c:716)
libust[1748/1750]: Info: sessiond not accepting connections to local apps s=
ocket (in ust_listener_thread() at lttng-ust-comm.c:716)

BR
/Per Nilsson




--_000_DE728318E75C3C48BBA6F3B0C02651542F1D9EC81BESESSCMS0360e_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"2">
<div>Hi,</div>
<div>I am trying to get started with userspace tracing with LTTng, but I am=
 having a hard time to get it to work.</div>
<div>I'm using Ubunto 11.04, with kernel version: 2.6.38-8-generic.</div>
<div>&nbsp;</div>
<div>I downloaded and compiled the following lttng software:</div>
<div>&nbsp;</div>
<div>Userspace-rcu-0.7.4</div>
<div>Lttng-ust-2.0.5</div>
<div>Lttng-tools-2-0.4</div>
<div>Babeltrace-1.0.0-rc5</div>
<div>&nbsp;</div>
<div>Maybe some one can tell me what is wrong.</div>
<div>&nbsp;</div>
<div>// This is command line command I use to start the trace session.</div=
>
<div>&nbsp;</div>
<div>per@per-VirtualBox:~$ sudo lttng create foo</div>
<div>[sudo] password for per: </div>
<div>Session foo created.</div>
<div>Traces will be written in /home/per/lttng-traces/foo-20120905-135905</=
div>
<div>per@per-VirtualBox:~$ sudo lttng enable-event -a -u</div>
<div>All UST events are enabled in channel channel0</div>
<div>per@per-VirtualBox:~$ sudo lttng start</div>
<div>Tracing started for session foo</div>
<div>per@per-VirtualBox:~$ sudo lttng stop</div>
<div>Tracing stopped for session foo</div>
<div>per@per-VirtualBox:~$ sudo ls /home/per/lttng-traces/foo-20120905-1359=
05/ust</div>
<div>per@per-VirtualBox:~$ sudo babeltrace /home/per/lttng-traces/foo-20120=
905-135905/ust</div>
<div>[error] Cannot open any trace for reading.</div>
<div>&nbsp;</div>
<div>[error] opening trace &quot;/home/per/lttng-traces/foo-20120905-135905=
/ust&quot; for reading.</div>
<div>&nbsp;</div>
<div>[error] none of the specified trace paths could be opened.</div>
<div>&nbsp;</div>
<div>// This is the traces from the lttng-sessiond</div>
<div>&nbsp;</div>
<div>per@per-VirtualBox:~$ sudo lttng-sessiond --verbose --verbose-consumer=
</div>
<div>DEBUG3: Creating LTTng run directory: /var/run/lttng [in create_lttng_=
rundir() at main.c:4317]</div>
<div>DEBUG1: Client socket path /var/run/lttng/client-lttng-sessiond [in ma=
in() at main.c:4609]</div>
<div>DEBUG1: Application socket path /var/run/lttng/apps-lttng-sessiond [in=
 main() at main.c:4610]</div>
<div>DEBUG1: LTTng run directory path: /var/run/lttng [in main() at main.c:=
4611]</div>
<div>DEBUG3: Created hashtable size 4 at 0x1d4e0a0 of type 1 [in lttng_ht_n=
ew() at hashtable.c:96]</div>
<div>DEBUG3: Created hashtable size 4 at 0x1d4e340 of type 1 [in lttng_ht_n=
ew() at hashtable.c:96]</div>
<div>FATAL: Module lttng_tracer not found.</div>
<div>Error: Unable to load module lttng-tracer</div>
<div>DEBUG1: Failed to open /proc/lttng [in init_kernel_tracer() at main.c:=
1871]</div>
<div>Error: Unable to remove module lttng-tracer</div>
<div>Warning: No kernel tracer available</div>
<div>DEBUG1: Signal handler set for SIGTERM, SIGPIPE and SIGINT [in set_sig=
nal_handler() at main.c:4451]</div>
<div>Warning: No tracing group detected</div>
<div>DEBUG1: epoll set max size is 100188 [in compat_epoll_set_max_size() a=
t compat-epoll.c:224]</div>
<div>DEBUG1: Thread manage kernel started [in thread_manage_kernel() at mai=
n.c:876]</div>
<div>DEBUG1: Updating kernel poll set [in update_kernel_poll() at main.c:74=
8]</div>
<div>DEBUG1: Thread kernel polling on 2 fds [in thread_manage_kernel() at m=
ain.c:905]</div>
<div>DEBUG1: [thread] Manage application started [in thread_manage_apps() a=
t main.c:1179]</div>
<div>DEBUG1: Apps thread polling on 2 fds [in thread_manage_apps() at main.=
c:1200]</div>
<div>DEBUG1: [thread] Manage application registration started [in thread_re=
gistration_apps() at main.c:1392]</div>
<div>DEBUG1: Notifying applications of session daemon state: 1 [in notify_u=
st_apps() at main.c:687]</div>
<div>DEBUG1: Got the wait shm fd 17 [in get_wait_shm() at shm.c:117]</div>
<div>DEBUG1: Futex wait update active 1 [in futex_wait_update() at futex.c:=
62]</div>
<div>DEBUG1: Accepting application registration [in thread_registration_app=
s() at main.c:1423]</div>
<div>DEBUG1: [thread] Dispatch UST command started [in thread_dispatch_ust_=
registration() at main.c:1324]</div>
<div>DEBUG1: Futex n to 1 prepare done [in futex_nto1_prepare() at futex.c:=
73]</div>
<div>DEBUG1: Woken up but nothing in the UST command queue [in thread_dispa=
tch_ust_registration() at main.c:1334]</div>
<div>DEBUG1: [thread] Manage client started [in thread_manage_clients() at =
main.c:3794]</div>
<div>DEBUG1: Accepting client command ... [in thread_manage_clients() at ma=
in.c:3826]</div>
<div>DEBUG1: Wait for client response [in thread_manage_clients() at main.c=
:3863]</div>
<div>DEBUG1: Receiving data from client ... [in thread_manage_clients() at =
main.c:3898]</div>
<div>DEBUG1: Nothing recv() from client... continuing [in thread_manage_cli=
ents() at main.c:3902]</div>
<div>DEBUG1: Clean command context structure [in clean_command_ctx() at mai=
n.c:534]</div>
<div>DEBUG1: Accepting client command ... [in thread_manage_clients() at ma=
in.c:3826]</div>
<div>DEBUG1: Wait for client response [in thread_manage_clients() at main.c=
:3863]</div>
<div>DEBUG1: Receiving data from client ... [in thread_manage_clients() at =
main.c:3898]</div>
<div>DEBUG1: Processing client command 8 [in process_client_msg() at main.c=
:3309]</div>
<div>DEBUG3: mkdir() recursive /home/per/lttng-traces/foo-20120905-135905 w=
ith mode 504 for uid 0 and gid 0 [in run_as_mkdir_recursive() at runas.c:33=
9]</div>
<div>DEBUG1: Using run_as_clone [in run_as() at runas.c:323]</div>
<div>DEBUG1: Tracing session foo created in /home/per/lttng-traces/foo-2012=
0905-135905 with ID 1 by UID 0 GID 0 [in session_create() at session.c:232]=
</div>
<div>DEBUG1: Sending response (size: 16, retcode: Success) [in thread_manag=
e_clients() at main.c:3936]</div>
<div>DEBUG1: Clean command context structure [in clean_command_ctx() at mai=
n.c:534]</div>
<div>DEBUG1: Accepting client command ... [in thread_manage_clients() at ma=
in.c:3826]</div>
<div>DEBUG1: Wait for client response [in thread_manage_clients() at main.c=
:3863]</div>
<div>DEBUG1: Receiving data from client ... [in thread_manage_clients() at =
main.c:3898]</div>
<div>DEBUG1: Nothing recv() from client... continuing [in thread_manage_cli=
ents() at main.c:3902]</div>
<div>DEBUG1: Clean command context structure [in clean_command_ctx() at mai=
n.c:534]</div>
<div>DEBUG1: Accepting client command ... [in thread_manage_clients() at ma=
in.c:3826]</div>
<div>DEBUG1: Wait for client response [in thread_manage_clients() at main.c=
:3863]</div>
<div>DEBUG1: Receiving data from client ... [in thread_manage_clients() at =
main.c:3898]</div>
<div>DEBUG1: Processing client command 6 [in process_client_msg() at main.c=
:3309]</div>
<div>DEBUG1: Getting session foo by name [in process_client_msg() at main.c=
:3364]</div>
<div>DEBUG1: Creating UST session [in create_ust_session() at main.c:1965]<=
/div>
<div>DEBUG3: Created hashtable size 4 at 0x1d55840 of type 1 [in lttng_ht_n=
ew() at hashtable.c:96]</div>
<div>DEBUG3: Created hashtable size 4 at 0x1d55b00 of type 1 [in lttng_ht_n=
ew() at hashtable.c:96]</div>
<div>DEBUG3: Created hashtable size 4 at 0x1d55dc0 of type 0 [in lttng_ht_n=
ew() at hashtable.c:96]</div>
<div>DEBUG3: mkdir() recursive /home/per/lttng-traces/foo-20120905-135905/u=
st with mode 504 for uid 0 and gid 0 [in run_as_mkdir_recursive() at runas.=
c:339]</div>
<div>DEBUG1: Using run_as_clone [in run_as() at runas.c:323]</div>
<div>DEBUG1: Spawning consumerd [in spawn_consumerd() at main.c:1659]</div>
<div>DEBUG1: [thread] Manage consumer started [in thread_manage_consumer() =
at main.c:982]</div>
<div>DEBUG1: Using 64-bit UST consumer at: /usr/local/lib/lttng/libexec/ltt=
ng-consumerd [in spawn_consumerd() at main.c:1733]</div>
<div>DEBUG3: Created hashtable size 4 at 0x247d030 of type 1 [in lttng_ht_n=
ew() at hashtable.c:96]</div>
<div>DEBUG3: Created hashtable size 4 at 0x247d2f0 of type 1 [in lttng_ht_n=
ew() at hashtable.c:96]</div>
<div>DEBUG1: Connecting to error socket /var/run/lttng/ustconsumerd64/error=
 [in main() at lttng-consumerd.c:349]</div>
<div>DEBUG1: Updating poll fd array [in consumer_update_poll_array() at con=
sumer.c:521]</div>
<div>DEBUG1: polling on 1 fd [in lttng_consumer_thread_poll_fds() at consum=
er.c:1013]</div>
<div>DEBUG1: Creating command socket /var/run/lttng/ustconsumerd64/command =
[in lttng_consumer_thread_receive_fds() at consumer.c:1160]</div>
<div>DEBUG1: Sending ready command to lttng-sessiond [in lttng_consumer_thr=
ead_receive_fds() at consumer.c:1173]</div>
<div>DEBUG1: consumer command socket ready [in thread_manage_consumer() at =
main.c:1062]</div>
<div>DEBUG3: Created hashtable size 4 at 0x1d57720 of type 0 [in lttng_ht_n=
ew() at hashtable.c:96]</div>
<div>DEBUG3: Created hashtable size 4 at 0x1d579e0 of type 1 [in lttng_ht_n=
ew() at hashtable.c:96]</div>
<div>DEBUG3: Created hashtable size 4 at 0x1d57f00 of type 1 [in lttng_ht_n=
ew() at hashtable.c:96]</div>
<div>DEBUG1: UST app creating event * for all apps for session id 1 [in ust=
_app_create_event_glb() at ust-app.c:1916]</div>
<div>DEBUG1: Event UST * created in channel channel0 [in event_ust_enable_t=
racepoint() at event.c:486]</div>
<div>DEBUG1: Sending response (size: 16, retcode: Success) [in thread_manag=
e_clients() at main.c:3936]</div>
<div>DEBUG1: Clean command context structure [in clean_command_ctx() at mai=
n.c:534]</div>
<div>DEBUG1: Accepting client command ... [in thread_manage_clients() at ma=
in.c:3826]</div>
<div>DEBUG1: Connection on client_socket [in lttng_consumer_thread_receive_=
fds() at consumer.c:1196]</div>
<div>DEBUG1: Wait for client response [in thread_manage_clients() at main.c=
:3863]</div>
<div>DEBUG1: Receiving data from client ... [in thread_manage_clients() at =
main.c:3898]</div>
<div>DEBUG1: Nothing recv() from client... continuing [in thread_manage_cli=
ents() at main.c:3902]</div>
<div>DEBUG1: Clean command context structure [in clean_command_ctx() at mai=
n.c:534]</div>
<div>DEBUG1: Accepting client command ... [in thread_manage_clients() at ma=
in.c:3826]</div>
<div>DEBUG1: Wait for client response [in thread_manage_clients() at main.c=
:3863]</div>
<div>DEBUG1: Receiving data from client ... [in thread_manage_clients() at =
main.c:3898]</div>
<div>DEBUG1: Processing client command 16 [in process_client_msg() at main.=
c:3309]</div>
<div>DEBUG1: Getting session foo by name [in process_client_msg() at main.c=
:3364]</div>
<div>DEBUG1: Starting all UST traces [in ust_app_start_trace_all() at ust-a=
pp.c:2207]</div>
<div>DEBUG1: Sending response (size: 16, retcode: Success) [in thread_manag=
e_clients() at main.c:3936]</div>
<div>DEBUG1: Clean command context structure [in clean_command_ctx() at mai=
n.c:534]</div>
<div>DEBUG1: Accepting client command ... [in thread_manage_clients() at ma=
in.c:3826]</div>
<div>DEBUG1: Wait for client response [in thread_manage_clients() at main.c=
:3863]</div>
<div>DEBUG1: Receiving data from client ... [in thread_manage_clients() at =
main.c:3898]</div>
<div>DEBUG1: Nothing recv() from client... continuing [in thread_manage_cli=
ents() at main.c:3902]</div>
<div>DEBUG1: Clean command context structure [in clean_command_ctx() at mai=
n.c:534]</div>
<div>DEBUG1: Accepting client command ... [in thread_manage_clients() at ma=
in.c:3826]</div>
<div>DEBUG1: Wait for client response [in thread_manage_clients() at main.c=
:3863]</div>
<div>DEBUG1: Receiving data from client ... [in thread_manage_clients() at =
main.c:3898]</div>
<div>DEBUG1: Processing client command 17 [in process_client_msg() at main.=
c:3309]</div>
<div>DEBUG1: Getting session foo by name [in process_client_msg() at main.c=
:3364]</div>
<div>DEBUG1: Stopping all UST traces [in ust_app_stop_trace_all() at ust-ap=
p.c:2233]</div>
<div>DEBUG1: Sending response (size: 16, retcode: Success) [in thread_manag=
e_clients() at main.c:3936]</div>
<div>DEBUG1: Clean command context structure [in clean_command_ctx() at mai=
n.c:534]</div>
<div>DEBUG1: Accepting client command ... [in thread_manage_clients() at ma=
in.c:3826]</div>
<div>&nbsp;</div>
<div>// this is the traces from the small test application</div>
<div>&nbsp;</div>
<div>per@per-VirtualBox:/usr/local/src/lttng-ust-2.0.5/doc/examples/gen-tp$=
 export LTTNG_UST_DEBUG=3D1</div>
<div>per@per-VirtualBox:/usr/local/src/lttng-ust-2.0.5/doc/examples/gen-tp$=
 ./sample liblttng_ust_tracepoint[1748/1748]: just registered a tracepoints=
 section from 0x7f431694fc38 and having 1 tracepoints (in tracepoint_regist=
er_lib() at tracepoint.c:641)</div>
<div>liblttng_ust_tracepoint[1748/1748]: registered tracepoint: lttng_ust:m=
etadata (in tracepoint_register_lib() at tracepoint.c:646)</div>
<div>libust[1748/1748]: LTT : ltt ring buffer client init</div>
<div> (in ltt_ring_buffer_metadata_client_init() at ltt-ring-buffer-metadat=
a-client.h:334)</div>
<div>libust[1748/1748]: LTT : ltt ring buffer client init</div>
<div> (in ltt_ring_buffer_client_overwrite_init() at ltt-ring-buffer-client=
.h:584)</div>
<div>libust[1748/1748]: LTT : ltt ring buffer client init</div>
<div> (in ltt_ring_buffer_client_discard_init() at ltt-ring-buffer-client.h=
:584)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Waiting for local apps sessiond (in wait_for_sessio=
nd() at lttng-ust-comm.c:638)</div>
<div>libust[1748/1750]: Linux kernels 2.6.33 to 3.0 (with the exception of =
stable versions) do not support FUTEX_WAKE on read-only memory mappings cor=
rectly. Please upgrade your kernel (fix is commit 9ea71503a8ed9184d2d0b8ccc=
4d269d05f7940ae in Linux kernel
mainline). LTTng-UST will use polling mode fallback. (in wait_for_sessiond(=
) at lttng-ust-comm.c:651)</div>
<div>libust[1748/1750]: Error: futex: Bad address (in wait_for_sessiond() a=
t lttng-ust-comm.c:653)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1748]: just registered probe sample_tracepoint containing =
1 events (in ltt_probe_register() at ltt-probes.c:109)</div>
<div>libust[1748/1748]: Registered event probe &quot;sample_tracepoint:mess=
age&quot; with signature &quot;char *, text&quot; (in ltt_probe_register() =
at ltt-probes.c:118)</div>
<div>liblttng_ust_tracepoint[1748/1748]: just registered a tracepoints sect=
ion from 0x602138 and having 1 tracepoints (in tracepoint_register_lib() at=
 tracepoint.c:641)</div>
<div>liblttng_ust_tracepoint[1748/1748]: registered tracepoint: sample_trac=
epoint:message (in tracepoint_register_lib() at tracepoint.c:646)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps socket (in ust_listener_thread() at lttng-ust-comm.c:716)</div>
<div>&nbsp;</div>
<div>BR</div>
<div>/Per Nilsson</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_DE728318E75C3C48BBA6F3B0C02651542F1D9EC81BESESSCMS0360e_--


--===============0682009610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0682009610==--
