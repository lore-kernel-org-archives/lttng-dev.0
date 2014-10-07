From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: sessiond and consumerd for 32 and 64 bit apps
Date: Tue, 7 Oct 2014 19:23:47 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD5A23A749__6676.30494940585$1412709903$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XbaMU-000189-8x
 for lttng-dev@lists.lttng.org; Tue, 07 Oct 2014 15:24:00 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Anand Neeli <anand.neeli@gmail.com>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Tue, 7 Oct 2014 23:12:47 +0530
From: Anand Neeli <anand.neeli@gmail.com>

> To add more details to my query.
> I want to trace both 32-bit and 64-bit apps.
> For this i launched sessiond with 32 and 64 bit paramaters of consumerd.
> (shown below)
>
> i see that 64-bit app's are able to log whereas 32-bit app's are not logg=
ing.
>
> Below is the output with -vvv, can anyone help me to find the problem her=
e.
>
> mysystem   # find /usr/lib/ -name "*lttng*"
> /usr/lib/liblttng-ctl.so.0
> /usr/lib/liblttng-ctl.so.0.0.0
> /usr/lib/liblttng-ust.so.0
> /usr/lib/liblttng-ust.so.0.0.0
> /usr/lib/liblttng-ust-ctl.so.2
> /usr/lib/liblttng-ust-ctl.so.2.0.0
> /usr/lib/liblttng-ust-cyg-profile.so.0
> /usr/lib/liblttng-ust-cyg-profile.so.0.0.0
> /usr/lib/liblttng-ust-cyg-profile-fast.so.0
> /usr/lib/liblttng-ust-cyg-profile-fast.so.0.0.0
> /usr/lib/liblttng-ust-dl.so.0
> /usr/lib/liblttng-ust-dl.so.0.0.0
> /usr/lib/liblttng-ust-fork.so.0
> /usr/lib/liblttng-ust-fork.so.0.0.0
> /usr/lib/liblttng-ust-libc-wrapper.so.0
> /usr/lib/liblttng-ust-libc-wrapper.so.0.0.0
> /usr/lib/liblttng-ust-pthread-wrapper.so.0
> /usr/lib/liblttng-ust-pthread-wrapper.so.0.0.0
> /usr/lib/liblttng-ust-tracepoint.so.0
> /usr/lib/liblttng-ust-tracepoint.so.0.0.0
> /usr/lib/lttng
> /usr/lib/lttng/libexec/lttng-consumerd

> mysystem   # find /usr/lib64/ -name "*lttng*"
> /usr/lib64/libbabeltrace-lttng-live.so.1
> /usr/lib64/libbabeltrace-lttng-live.so.1.0.0
> /usr/lib64/liblttng-ctl.so.0
> /usr/lib64/liblttng-ctl.so.0.0.0
> /usr/lib64/liblttng-ust.so.0
> /usr/lib64/liblttng-ust.so.0.0.0
> /usr/lib64/liblttng-ust-ctl.so.2
> /usr/lib64/liblttng-ust-ctl.so.2.0.0
> /usr/lib64/liblttng-ust-cyg-profile.so.0
> /usr/lib64/liblttng-ust-cyg-profile.so.0.0.0
> /usr/lib64/liblttng-ust-cyg-profile-fast.so.0
> /usr/lib64/liblttng-ust-cyg-profile-fast.so.0.0.0
> /usr/lib64/liblttng-ust-dl.so.0
> /usr/lib64/liblttng-ust-dl.so.0.0.0
> /usr/lib64/liblttng-ust-fork.so.0
> /usr/lib64/liblttng-ust-fork.so.0.0.0
> /usr/lib64/liblttng-ust-libc-wrapper.so.0
> /usr/lib64/liblttng-ust-libc-wrapper.so.0.0.0
> /usr/lib64/liblttng-ust-pthread-wrapper.so.0
> /usr/lib64/liblttng-ust-pthread-wrapper.so.0.0.0
> /usr/lib64/liblttng-ust-tracepoint.so.0
> /usr/lib64/liblttng-ust-tracepoint.so.0.0.0
> /usr/lib64/lttng
> /usr/lib64/lttng/libexec/lttng-consumerd

   Presumably you also have 32- and 64-bit versions of userspace-rcu (libur=
cu*)?  There should also be two versions of libpopt.so, incidentally.

   Were the 32- and 64-bit compilations of lttng-tools cross-referenced?  T=
hat is to say, 32-bit lttng-tools should have been configured with the with=
-consumerd-only, with-consumerd64-libdir, and with-consumerd64-bin options,=
 while 64-bit lttng-tools should have been configured with the with-consume=
rd32-libdir and with-consumerd32-bin options.  This is important for lttng-=
relayd to be made correctly.

> mysystem # lttng-relayd -d
>
> mysystem # lttng-sessiond \
> --consumerd32-path /usr/lib/lttng/libexec/lttng-consumerd \
> --consumerd32-libdir /usr/lib/ \
> --consumerd64-path /usr/lib64/lttng/libexec/lttng-consumerd \
> --consumerd64-libdir /usr/lib64/ \
> -b --no-kernel -vvv
>
> [...]
> DEBUG2 [1203/1203]: UST consumer 32 bits err path: /var/run/lttng/ustcons=
umerd32/error (in main() at main.c:4709)
> DEBUG2 [1203/1203]: UST consumer 32 bits cmd path: /var/run/lttng/ustcons=
umerd32/command (in main() at main.c:4711)
> DEBUG2 [1203/1203]: UST consumer 64 bits err path: /var/run/lttng/ustcons=
umerd64/error (in main() at main.c:4720)
> DEBUG2 [1203/1203]: UST consumer 64 bits cmd path: /var/run/lttng/ustcons=
umerd64/command (in main() at main.c:4722)
> [...]
> Warning: No tracing group detected
> DEBUG2 [1203/1203]: Creating consumer directory: /var/run/lttng/ustconsum=
erd64 (in set_consumer_sockets() at main.c:4343)
> DEBUG2 [1203/1203]: Creating consumer directory: /var/run/lttng/ustconsum=
erd32 (in set_consumer_sockets() at main.c:4343)
> DEBUG3 [1203/1203]: Session daemon client socket 8 and application socket=
 9 created (in init_daemon_socket() at main.c:4209)
> [...]

> mysystem # lttng  --no-sessiond create mysession --live 200000 -U net://l=
ocalhost
> [...]
> Session mysession created.
> Traces will be written in net://localhost
> Live timer set to 200000 usec

> mysystem #  lttng enable-channel mychannel --userspace --buffers-pid -s m=
ysession --tracefile-size 8388608 --tracefile-count 8
> [...]
> DEBUG3 [1203/1206]: Copy session consumer subdir mysystem_node//mysession=
-20141007-101236//ust (in copy_session_consumer() at main.c:2484)
> DEBUG1 [1203/1206]: Spawning consumerd (in spawn_consumerd() at main.c:21=
58)
> DEBUG2 [1203/1206]: Consumer pid 1214 (in start_consumerd() at main.c:234=
0)
> DEBUG2 [1203/1206]: Spawning consumer control thread (in start_consumerd(=
) at main.c:2343)
> DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()=
 at ht-cleanup.c:64)
> DEBUG1 [1214/1214]: Using 64-bit UST consumer at: /usr/lib64/lttng/libexe=
c/lttng-consumerd (in spawn_consumerd() at main.c:2235)
> [...]
Warning: No tracing group detected
> DEBUG1 [1203/1215]: Consumer command socket ready (fd: 28 (in thread_mana=
ge_consumer() at main.c:1113)
> DEBUG1 [1203/1215]: Consumer metadata socket ready (fd: 29) (in thread_ma=
nage_consumer() at main.c:1115)
> DEBUG3 [1203/1206]: Consumer socket created (fd: 28) and added to output =
(in consumer_create_socket() at consumer.c:301)
> DEBUG1 [1203/1206]: Spawning consumerd (in spawn_consumerd() at main.c:21=
58)
> DEBUG2 [1203/1206]: Consumer pid 1222 (in start_consumerd() at main.c:234=
0)
> DEBUG2 [1203/1206]: Spawning consumer control thread (in start_consumerd(=
) at main.c:2343)
> DEBUG1 [1222/1222]: Using 32-bit UST consumer at: /usr/lib/lttng/libexec/=
lttng-consumerd (in spawn_consumerd() at main.c:2278)
> [...]
Warning: No tracing group detected
> DEBUG1 [1203/1223]: Consumer command socket ready (fd: 32 (in thread_mana=
ge_consumer() at main.c:1113)
> DEBUG1 [1203/1223]: Consumer metadata socket ready (fd: 33) (in thread_ma=
nage_consumer() at main.c:1115)
> DEBUG3 [1203/1206]: Consumer socket created (fd: 32) and added to output =
(in consumer_create_socket() at consumer.c:301)
> DEBUG1 [1203/1206]: Setting relayd for session mysession (in cmd_setup_re=
layd() at cmd.c:723)
> DEBUG3 [1203/1206]: Relayd connect ... (in relayd_connect() at relayd.c:4=
70)
> [...]
> DEBUG1 [1203/1206]: Relayd session created with id 1 (in relayd_create_se=
ssion() at relayd.c:219)
> DEBUG3 [1203/1206]: Sending relayd sock info to consumer on 32 (in consum=
er_send_relayd_socket() at consumer.c:999)
> DEBUG3 [1203/1206]: Sending relayd socket file descriptor to consumer (in=
 consumer_send_relayd_socket() at consumer.c:1005)
> DEBUG2 [1203/1206]: Consumer relayd socket sent (in consumer_send_relayd_=
socket() at consumer.c:1011)
> [...]
> DEBUG3 [1203/1206]: Sending relayd sock info to consumer on 32 (in consum=
er_send_relayd_socket() at consumer.c:999)
> DEBUG3 [1203/1206]: Sending relayd socket file descriptor to consumer (in=
 consumer_send_relayd_socket() at consumer.c:1005)
> DEBUG2 [1203/1206]: Consumer relayd socket sent (in consumer_send_relayd_=
socket() at consumer.c:1011)
> DEBUG3 [1203/1206]: Relayd closing socket 34 (in relayd_close() at relayd=
.c:501)
> DEBUG3 [1203/1206]: Relayd connect ... (in relayd_connect() at relayd.c:4=
70)
> [...]
> DEBUG3 [1203/1206]: Sending relayd sock info to consumer on 28 (in consum=
er_send_relayd_socket() at consumer.c:999)
> DEBUG3 [1203/1206]: Sending relayd socket file descriptor to consumer (in=
 consumer_send_relayd_socket() at consumer.c:1005)
> DEBUG2 [1203/1206]: Consumer relayd socket sent (in consumer_send_relayd_=
socket() at consumer.c:1011)
> [...]
> DEBUG3 [1203/1206]: Sending relayd sock info to consumer on 28 (in consum=
er_send_relayd_socket() at consumer.c:999)
> DEBUG3 [1203/1206]: Sending relayd socket file descriptor to consumer (in=
 consumer_send_relayd_socket() at consumer.c:1005)
> DEBUG2 [1203/1206]: Consumer relayd socket sent (in consumer_send_relayd_=
socket() at consumer.c:1011)
> [...]
> DEBUG2 [1203/1206]: Trace UST channel mychannel created (in trace_ust_cre=
ate_channel() at trace-ust.c:331)
> [...]
> UST channel mychannel enabled for session mysession

> mysystem # lttng enable-event --channel mychannel --userspace --all -s my=
session
> [...]
> DEBUG3 [1203/1206]: Consumer socket created (fd: 28) and added to output =
(in consumer_create_socket() at consumer.c:301)
> DEBUG3 [1203/1206]: Consumer socket created (fd: 32) and added to output =
(in consumer_create_socket() at consumer.c:301)
> DEBUG1 [1203/1206]: Setting relayd for session mysession (in cmd_setup_re=
layd() at cmd.c:723)
> [...]
> All UST events are enabled in channel mychannel

> mysystem # lttng -vvv start
> [...]
> Tracing started for session mysession
[...]
> mysystem # /usr/bin/logtrace_test    <<<<<<running a 32-bit app
> DEBUG1 [1203/1208]: UST registration received with pid:1235 ppid:850 uid:=
0 gid:0 sock:25 name:logtrace_test (version 5.0) (in thread_registration_ap=
ps() at main.c:1946)
> [...]
> DEBUG1 [1203/1208]: Accepting application registration (in thread_registr=
ation_apps() at main.c:1838)
> [...]
> DEBUG1 [1203/1207]: Dispatching UST registration pid:1235 ppid:850 uid:0 =
gid:0 sock:25 name:logtrace_test (version 5.0) (in thread_dispatch_ust_regi=
stration() at main.c:1612)
> DEBUG3 [1203/1207]: UST app creating application for socket 25 (in ust_ap=
p_create() at ust-app.c:2848)
> [...]
> DEBUG1 [1203/1208]: UST registration received with pid:1235 ppid:850 uid:=
0 gid:0 sock:34 name:logtrace_test (version 5.0) (in thread_registration_ap=
ps() at main.c:1946)
> [...]
> DEBUG1 [1203/1207]: Dispatching UST registration pid:1235 ppid:850 uid:0 =
gid:0 sock:34 name:logtrace_test (version 5.0) (in thread_dispatch_ust_regi=
stration() at main.c:1612)
> DEBUG3 [1203/1207]: UST app notify socket 34 is set (in thread_dispatch_u=
st_registration() at main.c:1669)
> DEBUG1 [1203/1207]: App registered with pid:1235 ppid:850 uid:0 gid:0 soc=
k:25 name:logtrace_test notify_sock:34 (version 5.0) (in ust_app_add() at u=
st-app.c:2936)
> [...]
> DEBUG1 [1203/1208]: Accepting application registration (in thread_registr=
ation_apps() at main.c:1838)
> DEBUG2 [1203/1207]: UST app global update for app sock 25 for session id =
0 (in ust_app_global_update() at ust-app.c:4173)
> [...]
> DEBUG3 [1203/1207]: UST app buffer registry per PID created successfully =
(in setup_buffer_reg_pid() at ust-app.c:1746)
> DEBUG2 [1203/1207]: UST app session created successfully with handle 1 (i=
n create_ust_app_session() at ust-app.c:1910)
> DEBUG1 [1203/1207]: UST app creating channel mychannel with per PID buffe=
rs (in create_channel_per_pid() at ust-app.c:2512)
>[...]
> DEBUG1 [1203/1207]: UST app sending channel mychannel to UST app sock 25 =
(in send_channel_pid_to_ust() at ust-app.c:1365)
> DEBUG2 [1203/1207]: UST app send channel to sock 25 pid 1235 (name: mycha=
nnel, key: 0) (in ust_consumer_send_channel_to_ust() at ust-consumer.c:415)
> DEBUG2 [1203/1207]: UST consumer send stream to app 25 (in ust_consumer_s=
end_stream_to_ust() at ust-consumer.c:380)
> DEBUG2 [1203/1207]: UST consumer send stream to app 25 (in ust_consumer_s=
end_stream_to_ust() at ust-consumer.c:380)
> DEBUG2 [1203/1207]: UST app event * created successfully for pid:1235 (in=
 create_ust_event() at ust-app.c:1428)
> DEBUG1 [1203/1207]: Starting tracing for ust app pid 1235 (in ust_app_sta=
rt_trace() at ust-app.c:3742)
>[...]
> DEBUG3 [1203/1210]: UST registry event ust_baddr_statedump:soinfo with id=
 0 added successfully (in add_event_ust_registry() at ust-app.c:4711)
> [...]
> DEBUG2 [1203/1207]: UST trace started for app pid 1235 (in ust_app_global=
_update() at ust-app.c:4247)
> [...]
> mysystem #
> DEBUG1 [1203/1209]: PID 1235 unregistering with sock 25 (in ust_app_unreg=
ister() at ust-app.c:2987)
> [...]
> DEBUG3 [1203/1244]: Call RCU deleting app PID 1235 (in delete_ust_app_rcu=
() at ust-app.c:780)
> [...]
> DEBUG2 [1203/1244]: UST app pid 1235 deleted (in delete_ust_app() at ust-=
app.c:765)

> mysystem # babeltrace /home/root/lttng-traces/     <<<<<<no traces found

> mysystem # /logtrace_test64   <<<<<<<<<<running a 64-bit app
> DEBUG1 [1203/1208]: UST registration received with pid:1250 ppid:850 uid:=
0 gid:0 sock:25 name:logtrace_test64 (version 5.0) (in thread_registration_=
apps() at main.c:1946)
> [...]
> DEBUG1 [1203/1208]: Accepting application registration (in thread_registr=
ation_apps() at main.c:1838)
> [...]
> DEBUG1 [1203/1207]: Dispatching UST registration pid:1250 ppid:850 uid:0 =
gid:0 sock:25 name:logtrace_test64 (version 5.0) (in thread_dispatch_ust_re=
gistration() at main.c:1612)
> DEBUG3 [1203/1207]: UST app creating application for socket 25 (in ust_ap=
p_create() at ust-app.c:2848)
> [...]
> DEBUG1 [1203/1208]: UST registration received with pid:1250 ppid:850 uid:=
0 gid:0 sock:34 name:logtrace_test64 (version 5.0) (in thread_registration_=
apps() at main.c:1946)
> [...]
> DEBUG1 [1203/1207]: Dispatching UST registration pid:1250 ppid:850 uid:0 =
gid:0 sock:34 name:logtrace_test64 (version 5.0) (in thread_dispatch_ust_re=
gistration() at main.c:1612)
> DEBUG3 [1203/1207]: UST app notify socket 34 is set (in thread_dispatch_u=
st_registration() at main.c:1669)
> DEBUG1 [1203/1207]: App registered with pid:1250 ppid:850 uid:0 gid:0 soc=
k:25 name:logtrace_test64 notify_sock:34 (version 5.0) (in ust_app_add() at=
 ust-app.c:2936)
> [...]
> DEBUG1 [1203/1207]: Starting tracing for ust app pid 1250 (in ust_app_sta=
rt_trace() at ust-app.c:3742)
> [...]
> DEBUG3 [1203/1210]: UST registry event ust_baddr_statedump:soinfo with id=
 0 added successfully (in add_event_ust_registry() at ust-app.c:4711)
> [...]
> DEBUG2 [1203/1207]: UST trace started for app pid 1250 (in ust_app_global=
_update() at ust-app.c:4247)
> [...]

> mysystem # babeltrace /home/root/lttng-traces/

> [10:13:42.880173965] (+?.?????????) mysystem_node:logtrace_test64:1250
> example_provider:trace_test_tp_id1: { cpu_id =3D 1 }, { message =3D "test=
ing
> evo trace..start" }
> [...]

   Wading through the log, it looks like everything should be working.  Are=
 you sure the 32-bit app produces events?  How was it compiled?  Does it ho=
ok up with the 32-bit lttng-ust as it should?

   There is a section on 32- and 64-bit mixed tracing in the LTTng Comprehe=
nsive User's Guide.  Would you like a copy of that?  It's only three pages.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
