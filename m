From: Per Nilsson <per.e.nilsson@ericsson.com>
Subject: Re: User space tracing
Date: Tue, 11 Sep 2012 12:47:02 +0200
Message-ID: <DE728318E75C3C48BBA6F3B0C02651542F1D9ED0D1__15191.4111375392$1347360474$gmane$org@ESESSCMS0360.eemea.ericsson.se>
References: <DE728318E75C3C48BBA6F3B0C02651542F1D9EC81B@ESESSCMS0360.eemea.ericsson.se>
	<450AE4BEC513614F96969DDA34F35934412F2D721C@EUSAACMS0701.eamcs.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0485017991=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailgw7.ericsson.se ([193.180.251.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <per.e.nilsson@ericsson.com>) id 1TBNzm-0007Gz-H2
	for lttng-dev@lists.lttng.org; Tue, 11 Sep 2012 06:47:07 -0400
In-Reply-To: <450AE4BEC513614F96969DDA34F35934412F2D721C@EUSAACMS0701.eamcs.ericsson.se>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Irina Guilman <irina.guilman@ericsson.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0485017991==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DE728318E75C3C48BBA6F3B0C02651542F1D9ED0D1ESESSCMS0360e_"

--_000_DE728318E75C3C48BBA6F3B0C02651542F1D9ED0D1ESESSCMS0360e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

The directory is empty. This is what I try to show in the following command=
 sequence below.

per@per-VirtualBox:~$ sudo ls /home/per/lttng-traces/foo-20120905-135905/us=
t
per@per-VirtualBox:~$ sudo babeltrace /home/per/lttng-traces/foo-20120905-1=
35905/ust
BR
/per


________________________________
From: Irina Guilman
Sent: den 10 september 2012 16:45
To: Per Nilsson; lttng-dev@lists.lttng.org
Subject: RE: User space tracing

Per,

You dont get traces at all, or you do get them but babeltrace fails to conv=
ert them?

If you open

/home/per/lttng-traces/foo-20120905-135905/ust/*/metadata

can you see your events?

________________________________
From: Per Nilsson [mailto:per.e.nilsson@ericsson.com]
Sent: September-10-12 3:33 AM
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] User space tracing

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
(in ltt_ring_buffer_metadata_client_init() at ltt-ring-buffer-metadata-clie=
nt.h:334)
libust[1748/1748]: LTT : ltt ring buffer client init
(in ltt_ring_buffer_client_overwrite_init() at ltt-ring-buffer-client.h:584=
)
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




--_000_DE728318E75C3C48BBA6F3B0C02651542F1D9ED0D1ESESSCMS0360e_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6002.18494" name=3DGENERATOR><!-- converted fr=
om rtf -->
<STYLE>.EmailQuote {
	PADDING-LEFT: 4pt; MARGIN-LEFT: 1pt; BORDER-LEFT: #800000 2px solid
}
</STYLE>
</HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D605504310-11092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2>Hi,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D605504310-11092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D605504310-11092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2>The directory is empty. This is what I try to show=
 in the=20
following command sequence below.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D605504310-11092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D605504310-11092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2>
<DIV>per@per-VirtualBox:~$ sudo ls=20
/home/per/lttng-traces/foo-20120905-135905/ust</DIV>
<DIV>per@per-VirtualBox:~$ sudo babeltrace=20
/home/per/lttng-traces/foo-20120905-135905/ust</DIV></FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D605504310-11092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2>BR</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D605504310-11092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2>/per</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><BR>&nbsp;</DIV>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> Irina Guilman <BR><B>Sent:</B> de=
n 10=20
september 2012 16:45<BR><B>To:</B> Per Nilsson;=20
lttng-dev@lists.lttng.org<BR><B>Subject:</B> RE: User space=20
tracing<BR></FONT><BR></DIV>
<DIV></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D524444214-10092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2>Per,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D524444214-10092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D524444214-10092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2>You dont get traces at all, or you do get them but=
=20
babeltrace fails to convert them?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D524444214-10092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D524444214-10092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2>If you open </FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D524444214-10092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN=20
class=3D524444214-10092012>/home/per/lttng-traces/foo-20120905-135905/ust/*=
/metadata</SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D524444214-10092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D524444214-10092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D524444214-10092012><FONT face=3DA=
rial=20
color=3D#0000ff size=3D2>can you see your=20
events?</FONT></SPAN></DIV></FONT></SPAN></DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> Per Nilsson=20
[mailto:per.e.nilsson@ericsson.com] <BR><B>Sent:</B> September-10-12 3:33=20
AM<BR><B>To:</B> lttng-dev@lists.lttng.org<BR><B>Subject:</B> [lttng-dev] U=
ser=20
space tracing<BR></FONT><BR></DIV>
<DIV></DIV><FONT face=3D"Arial, sans-serif" size=3D2>
<DIV>Hi,</DIV>
<DIV>I am trying to get started with userspace tracing with LTTng, but I am=
=20
having a hard time to get it to work.</DIV>
<DIV>I'm using Ubunto 11.04, with kernel version: 2.6.38-8-generic.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I downloaded and compiled the following lttng software:</DIV>
<DIV>&nbsp;</DIV>
<DIV>Userspace-rcu-0.7.4</DIV>
<DIV>Lttng-ust-2.0.5</DIV>
<DIV>Lttng-tools-2-0.4</DIV>
<DIV>Babeltrace-1.0.0-rc5</DIV>
<DIV>&nbsp;</DIV>
<DIV>Maybe some one can tell me what is wrong.</DIV>
<DIV>&nbsp;</DIV>
<DIV>// This is command line command I use to start the trace session.</DIV=
>
<DIV>&nbsp;</DIV>
<DIV>per@per-VirtualBox:~$ sudo lttng create foo</DIV>
<DIV>[sudo] password for per: </DIV>
<DIV>Session foo created.</DIV>
<DIV>Traces will be written in /home/per/lttng-traces/foo-20120905-135905</=
DIV>
<DIV>per@per-VirtualBox:~$ sudo lttng enable-event -a -u</DIV>
<DIV>All UST events are enabled in channel channel0</DIV>
<DIV>per@per-VirtualBox:~$ sudo lttng start</DIV>
<DIV>Tracing started for session foo</DIV>
<DIV>per@per-VirtualBox:~$ sudo lttng stop</DIV>
<DIV>Tracing stopped for session foo</DIV>
<DIV>per@per-VirtualBox:~$ sudo ls=20
/home/per/lttng-traces/foo-20120905-135905/ust</DIV>
<DIV>per@per-VirtualBox:~$ sudo babeltrace=20
/home/per/lttng-traces/foo-20120905-135905/ust</DIV>
<DIV>[error] Cannot open any trace for reading.</DIV>
<DIV>&nbsp;</DIV>
<DIV>[error] opening trace "/home/per/lttng-traces/foo-20120905-135905/ust"=
 for=20
reading.</DIV>
<DIV>&nbsp;</DIV>
<DIV>[error] none of the specified trace paths could be opened.</DIV>
<DIV>&nbsp;</DIV>
<DIV>// This is the traces from the lttng-sessiond</DIV>
<DIV>&nbsp;</DIV>
<DIV>per@per-VirtualBox:~$ sudo lttng-sessiond --verbose=20
--verbose-consumer</DIV>
<DIV>DEBUG3: Creating LTTng run directory: /var/run/lttng [in=20
create_lttng_rundir() at main.c:4317]</DIV>
<DIV>DEBUG1: Client socket path /var/run/lttng/client-lttng-sessiond [in ma=
in()=20
at main.c:4609]</DIV>
<DIV>DEBUG1: Application socket path /var/run/lttng/apps-lttng-sessiond [in=
=20
main() at main.c:4610]</DIV>
<DIV>DEBUG1: LTTng run directory path: /var/run/lttng [in main() at=20
main.c:4611]</DIV>
<DIV>DEBUG3: Created hashtable size 4 at 0x1d4e0a0 of type 1 [in lttng_ht_n=
ew()=20
at hashtable.c:96]</DIV>
<DIV>DEBUG3: Created hashtable size 4 at 0x1d4e340 of type 1 [in lttng_ht_n=
ew()=20
at hashtable.c:96]</DIV>
<DIV>FATAL: Module lttng_tracer not found.</DIV>
<DIV>Error: Unable to load module lttng-tracer</DIV>
<DIV>DEBUG1: Failed to open /proc/lttng [in init_kernel_tracer() at=20
main.c:1871]</DIV>
<DIV>Error: Unable to remove module lttng-tracer</DIV>
<DIV>Warning: No kernel tracer available</DIV>
<DIV>DEBUG1: Signal handler set for SIGTERM, SIGPIPE and SIGINT [in=20
set_signal_handler() at main.c:4451]</DIV>
<DIV>Warning: No tracing group detected</DIV>
<DIV>DEBUG1: epoll set max size is 100188 [in compat_epoll_set_max_size() a=
t=20
compat-epoll.c:224]</DIV>
<DIV>DEBUG1: Thread manage kernel started [in thread_manage_kernel() at=20
main.c:876]</DIV>
<DIV>DEBUG1: Updating kernel poll set [in update_kernel_poll() at=20
main.c:748]</DIV>
<DIV>DEBUG1: Thread kernel polling on 2 fds [in thread_manage_kernel() at=20
main.c:905]</DIV>
<DIV>DEBUG1: [thread] Manage application started [in thread_manage_apps() a=
t=20
main.c:1179]</DIV>
<DIV>DEBUG1: Apps thread polling on 2 fds [in thread_manage_apps() at=20
main.c:1200]</DIV>
<DIV>DEBUG1: [thread] Manage application registration started [in=20
thread_registration_apps() at main.c:1392]</DIV>
<DIV>DEBUG1: Notifying applications of session daemon state: 1 [in=20
notify_ust_apps() at main.c:687]</DIV>
<DIV>DEBUG1: Got the wait shm fd 17 [in get_wait_shm() at shm.c:117]</DIV>
<DIV>DEBUG1: Futex wait update active 1 [in futex_wait_update() at=20
futex.c:62]</DIV>
<DIV>DEBUG1: Accepting application registration [in thread_registration_app=
s()=20
at main.c:1423]</DIV>
<DIV>DEBUG1: [thread] Dispatch UST command started [in=20
thread_dispatch_ust_registration() at main.c:1324]</DIV>
<DIV>DEBUG1: Futex n to 1 prepare done [in futex_nto1_prepare() at=20
futex.c:73]</DIV>
<DIV>DEBUG1: Woken up but nothing in the UST command queue [in=20
thread_dispatch_ust_registration() at main.c:1334]</DIV>
<DIV>DEBUG1: [thread] Manage client started [in thread_manage_clients() at=
=20
main.c:3794]</DIV>
<DIV>DEBUG1: Accepting client command ... [in thread_manage_clients() at=20
main.c:3826]</DIV>
<DIV>DEBUG1: Wait for client response [in thread_manage_clients() at=20
main.c:3863]</DIV>
<DIV>DEBUG1: Receiving data from client ... [in thread_manage_clients() at=
=20
main.c:3898]</DIV>
<DIV>DEBUG1: Nothing recv() from client... continuing [in=20
thread_manage_clients() at main.c:3902]</DIV>
<DIV>DEBUG1: Clean command context structure [in clean_command_ctx() at=20
main.c:534]</DIV>
<DIV>DEBUG1: Accepting client command ... [in thread_manage_clients() at=20
main.c:3826]</DIV>
<DIV>DEBUG1: Wait for client response [in thread_manage_clients() at=20
main.c:3863]</DIV>
<DIV>DEBUG1: Receiving data from client ... [in thread_manage_clients() at=
=20
main.c:3898]</DIV>
<DIV>DEBUG1: Processing client command 8 [in process_client_msg() at=20
main.c:3309]</DIV>
<DIV>DEBUG3: mkdir() recursive /home/per/lttng-traces/foo-20120905-135905 w=
ith=20
mode 504 for uid 0 and gid 0 [in run_as_mkdir_recursive() at runas.c:339]</=
DIV>
<DIV>DEBUG1: Using run_as_clone [in run_as() at runas.c:323]</DIV>
<DIV>DEBUG1: Tracing session foo created in=20
/home/per/lttng-traces/foo-20120905-135905 with ID 1 by UID 0 GID 0 [in=20
session_create() at session.c:232]</DIV>
<DIV>DEBUG1: Sending response (size: 16, retcode: Success) [in=20
thread_manage_clients() at main.c:3936]</DIV>
<DIV>DEBUG1: Clean command context structure [in clean_command_ctx() at=20
main.c:534]</DIV>
<DIV>DEBUG1: Accepting client command ... [in thread_manage_clients() at=20
main.c:3826]</DIV>
<DIV>DEBUG1: Wait for client response [in thread_manage_clients() at=20
main.c:3863]</DIV>
<DIV>DEBUG1: Receiving data from client ... [in thread_manage_clients() at=
=20
main.c:3898]</DIV>
<DIV>DEBUG1: Nothing recv() from client... continuing [in=20
thread_manage_clients() at main.c:3902]</DIV>
<DIV>DEBUG1: Clean command context structure [in clean_command_ctx() at=20
main.c:534]</DIV>
<DIV>DEBUG1: Accepting client command ... [in thread_manage_clients() at=20
main.c:3826]</DIV>
<DIV>DEBUG1: Wait for client response [in thread_manage_clients() at=20
main.c:3863]</DIV>
<DIV>DEBUG1: Receiving data from client ... [in thread_manage_clients() at=
=20
main.c:3898]</DIV>
<DIV>DEBUG1: Processing client command 6 [in process_client_msg() at=20
main.c:3309]</DIV>
<DIV>DEBUG1: Getting session foo by name [in process_client_msg() at=20
main.c:3364]</DIV>
<DIV>DEBUG1: Creating UST session [in create_ust_session() at main.c:1965]<=
/DIV>
<DIV>DEBUG3: Created hashtable size 4 at 0x1d55840 of type 1 [in lttng_ht_n=
ew()=20
at hashtable.c:96]</DIV>
<DIV>DEBUG3: Created hashtable size 4 at 0x1d55b00 of type 1 [in lttng_ht_n=
ew()=20
at hashtable.c:96]</DIV>
<DIV>DEBUG3: Created hashtable size 4 at 0x1d55dc0 of type 0 [in lttng_ht_n=
ew()=20
at hashtable.c:96]</DIV>
<DIV>DEBUG3: mkdir() recursive /home/per/lttng-traces/foo-20120905-135905/u=
st=20
with mode 504 for uid 0 and gid 0 [in run_as_mkdir_recursive() at=20
runas.c:339]</DIV>
<DIV>DEBUG1: Using run_as_clone [in run_as() at runas.c:323]</DIV>
<DIV>DEBUG1: Spawning consumerd [in spawn_consumerd() at main.c:1659]</DIV>
<DIV>DEBUG1: [thread] Manage consumer started [in thread_manage_consumer() =
at=20
main.c:982]</DIV>
<DIV>DEBUG1: Using 64-bit UST consumer at:=20
/usr/local/lib/lttng/libexec/lttng-consumerd [in spawn_consumerd() at=20
main.c:1733]</DIV>
<DIV>DEBUG3: Created hashtable size 4 at 0x247d030 of type 1 [in lttng_ht_n=
ew()=20
at hashtable.c:96]</DIV>
<DIV>DEBUG3: Created hashtable size 4 at 0x247d2f0 of type 1 [in lttng_ht_n=
ew()=20
at hashtable.c:96]</DIV>
<DIV>DEBUG1: Connecting to error socket /var/run/lttng/ustconsumerd64/error=
 [in=20
main() at lttng-consumerd.c:349]</DIV>
<DIV>DEBUG1: Updating poll fd array [in consumer_update_poll_array() at=20
consumer.c:521]</DIV>
<DIV>DEBUG1: polling on 1 fd [in lttng_consumer_thread_poll_fds() at=20
consumer.c:1013]</DIV>
<DIV>DEBUG1: Creating command socket /var/run/lttng/ustconsumerd64/command =
[in=20
lttng_consumer_thread_receive_fds() at consumer.c:1160]</DIV>
<DIV>DEBUG1: Sending ready command to lttng-sessiond [in=20
lttng_consumer_thread_receive_fds() at consumer.c:1173]</DIV>
<DIV>DEBUG1: consumer command socket ready [in thread_manage_consumer() at=
=20
main.c:1062]</DIV>
<DIV>DEBUG3: Created hashtable size 4 at 0x1d57720 of type 0 [in lttng_ht_n=
ew()=20
at hashtable.c:96]</DIV>
<DIV>DEBUG3: Created hashtable size 4 at 0x1d579e0 of type 1 [in lttng_ht_n=
ew()=20
at hashtable.c:96]</DIV>
<DIV>DEBUG3: Created hashtable size 4 at 0x1d57f00 of type 1 [in lttng_ht_n=
ew()=20
at hashtable.c:96]</DIV>
<DIV>DEBUG1: UST app creating event * for all apps for session id 1 [in=20
ust_app_create_event_glb() at ust-app.c:1916]</DIV>
<DIV>DEBUG1: Event UST * created in channel channel0 [in=20
event_ust_enable_tracepoint() at event.c:486]</DIV>
<DIV>DEBUG1: Sending response (size: 16, retcode: Success) [in=20
thread_manage_clients() at main.c:3936]</DIV>
<DIV>DEBUG1: Clean command context structure [in clean_command_ctx() at=20
main.c:534]</DIV>
<DIV>DEBUG1: Accepting client command ... [in thread_manage_clients() at=20
main.c:3826]</DIV>
<DIV>DEBUG1: Connection on client_socket [in lttng_consumer_thread_receive_=
fds()=20
at consumer.c:1196]</DIV>
<DIV>DEBUG1: Wait for client response [in thread_manage_clients() at=20
main.c:3863]</DIV>
<DIV>DEBUG1: Receiving data from client ... [in thread_manage_clients() at=
=20
main.c:3898]</DIV>
<DIV>DEBUG1: Nothing recv() from client... continuing [in=20
thread_manage_clients() at main.c:3902]</DIV>
<DIV>DEBUG1: Clean command context structure [in clean_command_ctx() at=20
main.c:534]</DIV>
<DIV>DEBUG1: Accepting client command ... [in thread_manage_clients() at=20
main.c:3826]</DIV>
<DIV>DEBUG1: Wait for client response [in thread_manage_clients() at=20
main.c:3863]</DIV>
<DIV>DEBUG1: Receiving data from client ... [in thread_manage_clients() at=
=20
main.c:3898]</DIV>
<DIV>DEBUG1: Processing client command 16 [in process_client_msg() at=20
main.c:3309]</DIV>
<DIV>DEBUG1: Getting session foo by name [in process_client_msg() at=20
main.c:3364]</DIV>
<DIV>DEBUG1: Starting all UST traces [in ust_app_start_trace_all() at=20
ust-app.c:2207]</DIV>
<DIV>DEBUG1: Sending response (size: 16, retcode: Success) [in=20
thread_manage_clients() at main.c:3936]</DIV>
<DIV>DEBUG1: Clean command context structure [in clean_command_ctx() at=20
main.c:534]</DIV>
<DIV>DEBUG1: Accepting client command ... [in thread_manage_clients() at=20
main.c:3826]</DIV>
<DIV>DEBUG1: Wait for client response [in thread_manage_clients() at=20
main.c:3863]</DIV>
<DIV>DEBUG1: Receiving data from client ... [in thread_manage_clients() at=
=20
main.c:3898]</DIV>
<DIV>DEBUG1: Nothing recv() from client... continuing [in=20
thread_manage_clients() at main.c:3902]</DIV>
<DIV>DEBUG1: Clean command context structure [in clean_command_ctx() at=20
main.c:534]</DIV>
<DIV>DEBUG1: Accepting client command ... [in thread_manage_clients() at=20
main.c:3826]</DIV>
<DIV>DEBUG1: Wait for client response [in thread_manage_clients() at=20
main.c:3863]</DIV>
<DIV>DEBUG1: Receiving data from client ... [in thread_manage_clients() at=
=20
main.c:3898]</DIV>
<DIV>DEBUG1: Processing client command 17 [in process_client_msg() at=20
main.c:3309]</DIV>
<DIV>DEBUG1: Getting session foo by name [in process_client_msg() at=20
main.c:3364]</DIV>
<DIV>DEBUG1: Stopping all UST traces [in ust_app_stop_trace_all() at=20
ust-app.c:2233]</DIV>
<DIV>DEBUG1: Sending response (size: 16, retcode: Success) [in=20
thread_manage_clients() at main.c:3936]</DIV>
<DIV>DEBUG1: Clean command context structure [in clean_command_ctx() at=20
main.c:534]</DIV>
<DIV>DEBUG1: Accepting client command ... [in thread_manage_clients() at=20
main.c:3826]</DIV>
<DIV>&nbsp;</DIV>
<DIV>// this is the traces from the small test application</DIV>
<DIV>&nbsp;</DIV>
<DIV>per@per-VirtualBox:/usr/local/src/lttng-ust-2.0.5/doc/examples/gen-tp$=
=20
export LTTNG_UST_DEBUG=3D1</DIV>
<DIV>per@per-VirtualBox:/usr/local/src/lttng-ust-2.0.5/doc/examples/gen-tp$=
=20
./sample liblttng_ust_tracepoint[1748/1748]: just registered a tracepoints=
=20
section from 0x7f431694fc38 and having 1 tracepoints (in=20
tracepoint_register_lib() at tracepoint.c:641)</DIV>
<DIV>liblttng_ust_tracepoint[1748/1748]: registered tracepoint:=20
lttng_ust:metadata (in tracepoint_register_lib() at tracepoint.c:646)</DIV>
<DIV>libust[1748/1748]: LTT : ltt ring buffer client init</DIV>
<DIV>(in ltt_ring_buffer_metadata_client_init() at=20
ltt-ring-buffer-metadata-client.h:334)</DIV>
<DIV>libust[1748/1748]: LTT : ltt ring buffer client init</DIV>
<DIV>(in ltt_ring_buffer_client_overwrite_init() at=20
ltt-ring-buffer-client.h:584)</DIV>
<DIV>libust[1748/1748]: LTT : ltt ring buffer client init</DIV>
<DIV>(in ltt_ring_buffer_client_discard_init() at=20
ltt-ring-buffer-client.h:584)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Waiting for local apps sessiond (in wait_for_sessio=
nd()=20
at lttng-ust-comm.c:638)</DIV>
<DIV>libust[1748/1750]: Linux kernels 2.6.33 to 3.0 (with the exception of=
=20
stable versions) do not support FUTEX_WAKE on read-only memory mappings=20
correctly. Please upgrade your kernel (fix is commit=20
9ea71503a8ed9184d2d0b8ccc4d269d05f7940ae in Linux kernel mainline). LTTng-U=
ST=20
will use polling mode fallback. (in wait_for_sessiond() at=20
lttng-ust-comm.c:651)</DIV>
<DIV>libust[1748/1750]: Error: futex: Bad address (in wait_for_sessiond() a=
t=20
lttng-ust-comm.c:653)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1748]: just registered probe sample_tracepoint containing =
1=20
events (in ltt_probe_register() at ltt-probes.c:109)</DIV>
<DIV>libust[1748/1748]: Registered event probe "sample_tracepoint:message" =
with=20
signature "char *, text" (in ltt_probe_register() at ltt-probes.c:118)</DIV=
>
<DIV>liblttng_ust_tracepoint[1748/1748]: just registered a tracepoints sect=
ion=20
from 0x602138 and having 1 tracepoints (in tracepoint_register_lib() at=20
tracepoint.c:641)</DIV>
<DIV>liblttng_ust_tracepoint[1748/1748]: registered tracepoint:=20
sample_tracepoint:message (in tracepoint_register_lib() at=20
tracepoint.c:646)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1749]: Info: sessiond not accepting connections to global =
apps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>libust[1748/1750]: Info: sessiond not accepting connections to local a=
pps=20
socket (in ust_listener_thread() at lttng-ust-comm.c:716)</DIV>
<DIV>&nbsp;</DIV>
<DIV>BR</DIV>
<DIV>/Per Nilsson</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV></FONT></BODY></HTML>

--_000_DE728318E75C3C48BBA6F3B0C02651542F1D9ED0D1ESESSCMS0360e_--


--===============0485017991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0485017991==--
