From: Dror Granot <dror@reduxio.com>
Subject: Help needed in getting first ust event running
Date: Thu, 18 Apr 2013 18:55:05 +0300
Message-ID: <CAFw4v5-z8n-1C2_P89cugq3ayypby-CPr-N+SAxzcgOPEbwzTQ__17547.2800540321$1366300538$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0881015458=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dror@reduxio.com>) id 1USrB0-0004X4-Ur
	for lttng-dev@lists.lttng.org; Thu, 18 Apr 2013 11:55:11 -0400
Received: by mail-oa0-f47.google.com with SMTP id n9so2871102oag.20
	for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2013 08:55:05 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0881015458==
Content-Type: multipart/alternative; boundary=089e0158b6a048960604daa4a0b8

--089e0158b6a048960604daa4a0b8
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I'm trying to add a simple ust event to my project, but I keep getting
segmentation violation. I would really appreciate help in understanding
what am I'm doing wrong. I'm running Ubuntu 12.04LTS and got lttng from
git. I've ran the lttng with verbose but couldn't see anything valuable
there. I'm using dynamic linkage (but the problem occurs also in static)
and is as follows:

Program received signal SIGSEGV, Segmentation fault.
0x0000000000000000 in ?? ()
(gdb) where
#0  0x0000000000000000 in ?? ()
#1  0x000000000041b03f in __tracepoints__ptrs_init () at
/usr/local/include/lttng/tracepoint.h:349
#2  0x000000000043e95d in __libc_csu_init ()
#3  0x00007ffff71f1700 in __libc_start_main () from
/lib/x86_64-linux-gnu/libc.so.6
#4  0x00000000004039e9 in _start ()


increasing the debug level shows:

ibust[6455/6455]: LTT : ltt ring buffer client "relay-metadata-mmap" init
 (in lttng_ring_buffer_metadata_client_init() at
lttng-ring-buffer-metadata-client.h:313)
libust[6455/6455]: LTT : ltt ring buffer client "relay-overwrite-mmap" init
 (in lttng_ring_buffer_client_overwrite_init() at
lttng-ring-buffer-client.h:562)
libust[6455/6455]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap"
init
 (in lttng_ring_buffer_client_overwrite_rt_init() at
lttng-ring-buffer-client.h:562)
libust[6455/6455]: LTT : ltt ring buffer client "relay-discard-mmap" init
 (in lttng_ring_buffer_client_discard_init() at
lttng-ring-buffer-client.h:562)
libust[6455/6455]: LTT : ltt ring buffer client "relay-discard-rt-mmap" init
 (in lttng_ring_buffer_client_discard_rt_init() at
lttng-ring-buffer-client.h:562)
libust[6455/6457]: Info: sessiond not accepting connections to local apps
socket (in ust_listener_thread() at lttng-ust-comm.c:939)
libust[6455/6457]: Waiting for local apps sessiond (in wait_for_sessiond()
at lttng-ust-comm.c:849)
libust[6455/6456]: Message Received "Get Tracer Version", Handle "root" (0)
(in print_cmd() at lttng-ust-comm.c:216)
libust[6455/6456]: Return value: 0 (in handle_message() at
lttng-ust-comm.c:589)
libust[6455/6456]: message successfully sent (in send_reply() at
lttng-ust-comm.c:331)
libust[6455/6456]: Message Received "Registration Done", Handle "root" (0)
(in print_cmd() at lttng-ust-comm.c:216)
libust[6455/6456]: Return value: 0 (in handle_message() at
lttng-ust-comm.c:589)
libust[6455/6456]: message successfully sent (in send_reply() at
lttng-ust-comm.c:331)
libust[6455/6455]: adding probe tgtd_project containing 1 events to lazy
registration list (in lttng_probe_register() at lttng-probes.c:179)
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
libust[6455/6455]: LTT : ltt ring buffer client "relay-metadata-mmap" init
 (in lttng_ring_buffer_metadata_client_init() at
lttng-ring-buffer-metadata-client.h:313)
libust[6455/6455]: LTT : ltt ring buffer client "relay-overwrite-mmap" init
 (in lttng_ring_buffer_client_overwrite_init() at
lttng-ring-buffer-client.h:562)
libust[6455/6455]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap"
init
 (in lttng_ring_buffer_client_overwrite_rt_init() at
lttng-ring-buffer-client.h:562)
libust[6455/6455]: LTT : ltt ring buffer client "relay-discard-mmap" init
 (in lttng_ring_buffer_client_discard_init() at
lttng-ring-buffer-client.h:562)
libust[6455/6455]: LTT : ltt ring buffer client "relay-discard-rt-mmap" init
 (in lttng_ring_buffer_client_discard_rt_init() at
lttng-ring-buffer-client.h:562)
[New Thread 0x7ffff653a700 (LWP 6458)]
[New Thread 0x7ffff5d39700 (LWP 6459)]
libust[6455/6459]: Info: sessiond not accepting connections to local apps
socket (in ust_listener_thread() at lttng-ust-comm.c:939)
libust[6455/6459]: Waiting for local apps sessiond (in wait_for_sessiond()
at lttng-ust-comm.c:849)
libust[6455/6458]: Message Received "Get Tracer Version", Handle "root" (0)
(in print_cmd() at lttng-ust-comm.c:216)
libust[6455/6458]: Return value: 0 (in handle_message() at
lttng-ust-comm.c:589)
libust[6455/6458]: message successfully sent (in send_reply() at
lttng-ust-comm.c:331)
libust[6455/6458]: Message Received "Registration Done", Handle "root" (0)
(in print_cmd() at lttng-ust-comm.c:216)
libust[6455/6458]: Return value: 0 (in handle_message() at
lttng-ust-comm.c:589)
libust[6455/6458]: message successfully sent (in send_reply() at
lttng-ust-comm.c:331)
libust[6455/6455]: adding probe check_project containing 1 events to lazy
registration list (in lttng_probe_register() at lttng-probes.c:179)

and then it fails.
The segmentation violations seems to be due to the fact that the
tracepoint_register_lib is not initialized, but I don't understand what I'm
missing...

print tracepoint_dlopen
$1 = {liblttngust_handle = 0x7ffff7ff6030, tracepoint_register_lib = 0,
tracepoint_unregister_lib = 0, rcu_read_lock_sym_bp = 0,
rcu_read_unlock_sym_bp = 0,
  rcu_dereference_sym_bp = 0}

Thanks
Dror

--089e0158b6a048960604daa4a0b8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>I&#39;m trying to add a simple ust event to my pro=
ject, but I keep getting segmentation violation. I would really appreciate =
help in understanding what am I&#39;m doing wrong. I&#39;m running Ubuntu 1=
2.04LTS and got lttng from git. I&#39;ve ran the lttng with verbose but cou=
ldn&#39;t see anything valuable there. I&#39;m using dynamic linkage (but t=
he problem occurs also in static) and is as follows:</div>
<div><div><br></div><div>Program received signal SIGSEGV, Segmentation faul=
t.</div><div>0x0000000000000000 in ?? ()</div><div>(gdb) where</div><div>#0=
 =A00x0000000000000000 in ?? ()</div><div>#1 =A00x000000000041b03f in __tra=
cepoints__ptrs_init () at /usr/local/include/lttng/tracepoint.h:349</div>
<div>#2 =A00x000000000043e95d in __libc_csu_init ()</div><div>#3 =A00x00007=
ffff71f1700 in __libc_start_main () from /lib/x86_64-linux-gnu/libc.so.6</d=
iv><div>#4 =A00x00000000004039e9 in _start ()</div></div><div><br></div><di=
v>
<br></div><div style>increasing the debug level shows:</div><div style><br>=
</div><div style><div>ibust[6455/6455]: LTT : ltt ring buffer client &quot;=
relay-metadata-mmap&quot; init</div><div>=A0(in lttng_ring_buffer_metadata_=
client_init() at lttng-ring-buffer-metadata-client.h:313)</div>
<div>libust[6455/6455]: LTT : ltt ring buffer client &quot;relay-overwrite-=
mmap&quot; init</div><div>=A0(in lttng_ring_buffer_client_overwrite_init() =
at lttng-ring-buffer-client.h:562)</div><div>libust[6455/6455]: LTT : ltt r=
ing buffer client &quot;relay-overwrite-rt-mmap&quot; init</div>
<div>=A0(in lttng_ring_buffer_client_overwrite_rt_init() at lttng-ring-buff=
er-client.h:562)</div><div>libust[6455/6455]: LTT : ltt ring buffer client =
&quot;relay-discard-mmap&quot; init</div><div>=A0(in lttng_ring_buffer_clie=
nt_discard_init() at lttng-ring-buffer-client.h:562)</div>
<div>libust[6455/6455]: LTT : ltt ring buffer client &quot;relay-discard-rt=
-mmap&quot; init</div><div>=A0(in lttng_ring_buffer_client_discard_rt_init(=
) at lttng-ring-buffer-client.h:562)</div><div>libust[6455/6457]: Info: ses=
siond not accepting connections to local apps socket (in ust_listener_threa=
d() at lttng-ust-comm.c:939)</div>
<div>libust[6455/6457]: Waiting for local apps sessiond (in wait_for_sessio=
nd() at lttng-ust-comm.c:849)</div><div>libust[6455/6456]: Message Received=
 &quot;Get Tracer Version&quot;, Handle &quot;root&quot; (0) (in print_cmd(=
) at lttng-ust-comm.c:216)</div>
<div>libust[6455/6456]: Return value: 0 (in handle_message() at lttng-ust-c=
omm.c:589)</div><div>libust[6455/6456]: message successfully sent (in send_=
reply() at lttng-ust-comm.c:331)</div><div>libust[6455/6456]: Message Recei=
ved &quot;Registration Done&quot;, Handle &quot;root&quot; (0) (in print_cm=
d() at lttng-ust-comm.c:216)</div>
<div>libust[6455/6456]: Return value: 0 (in handle_message() at lttng-ust-c=
omm.c:589)</div><div>libust[6455/6456]: message successfully sent (in send_=
reply() at lttng-ust-comm.c:331)</div><div>libust[6455/6455]: adding probe =
tgtd_project containing 1 events to lazy registration list (in lttng_probe_=
register() at lttng-probes.c:179)</div>
<div>[Thread debugging using libthread_db enabled]</div><div>Using host lib=
thread_db library &quot;/lib/x86_64-linux-gnu/libthread_db.so.1&quot;.</div=
><div>libust[6455/6455]: LTT : ltt ring buffer client &quot;relay-metadata-=
mmap&quot; init</div>
<div>=A0(in lttng_ring_buffer_metadata_client_init() at lttng-ring-buffer-m=
etadata-client.h:313)</div><div>libust[6455/6455]: LTT : ltt ring buffer cl=
ient &quot;relay-overwrite-mmap&quot; init</div><div>=A0(in lttng_ring_buff=
er_client_overwrite_init() at lttng-ring-buffer-client.h:562)</div>
<div>libust[6455/6455]: LTT : ltt ring buffer client &quot;relay-overwrite-=
rt-mmap&quot; init</div><div>=A0(in lttng_ring_buffer_client_overwrite_rt_i=
nit() at lttng-ring-buffer-client.h:562)</div><div>libust[6455/6455]: LTT :=
 ltt ring buffer client &quot;relay-discard-mmap&quot; init</div>
<div>=A0(in lttng_ring_buffer_client_discard_init() at lttng-ring-buffer-cl=
ient.h:562)</div><div>libust[6455/6455]: LTT : ltt ring buffer client &quot=
;relay-discard-rt-mmap&quot; init</div><div>=A0(in lttng_ring_buffer_client=
_discard_rt_init() at lttng-ring-buffer-client.h:562)</div>
<div>[New Thread 0x7ffff653a700 (LWP 6458)]</div><div>[New Thread 0x7ffff5d=
39700 (LWP 6459)]</div><div>libust[6455/6459]: Info: sessiond not accepting=
 connections to local apps socket (in ust_listener_thread() at lttng-ust-co=
mm.c:939)</div>
<div>libust[6455/6459]: Waiting for local apps sessiond (in wait_for_sessio=
nd() at lttng-ust-comm.c:849)</div><div>libust[6455/6458]: Message Received=
 &quot;Get Tracer Version&quot;, Handle &quot;root&quot; (0) (in print_cmd(=
) at lttng-ust-comm.c:216)</div>
<div>libust[6455/6458]: Return value: 0 (in handle_message() at lttng-ust-c=
omm.c:589)</div><div>libust[6455/6458]: message successfully sent (in send_=
reply() at lttng-ust-comm.c:331)</div><div>libust[6455/6458]: Message Recei=
ved &quot;Registration Done&quot;, Handle &quot;root&quot; (0) (in print_cm=
d() at lttng-ust-comm.c:216)</div>
<div>libust[6455/6458]: Return value: 0 (in handle_message() at lttng-ust-c=
omm.c:589)</div><div>libust[6455/6458]: message successfully sent (in send_=
reply() at lttng-ust-comm.c:331)</div><div>libust[6455/6455]: adding probe =
check_project containing 1 events to lazy registration list (in lttng_probe=
_register() at lttng-probes.c:179)</div>
<div><br></div><div style>and then it fails.</div><div style>The=A0segmenta=
tion=A0violations=A0seems to be due to the fact that the tracepoint_registe=
r_lib is not initialized, but I don&#39;t understand what I&#39;m missing..=
.</div>
<div style><br></div><div style><div>print tracepoint_dlopen</div><div>$1 =
=3D {liblttngust_handle =3D 0x7ffff7ff6030, tracepoint_register_lib =3D 0, =
tracepoint_unregister_lib =3D 0, rcu_read_lock_sym_bp =3D 0, rcu_read_unloc=
k_sym_bp =3D 0,=A0</div>
<div>=A0 rcu_dereference_sym_bp =3D 0}</div><div><br></div></div></div><div=
 style>Thanks</div><div style>Dror</div></div>

--089e0158b6a048960604daa4a0b8--


--===============0881015458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0881015458==--
