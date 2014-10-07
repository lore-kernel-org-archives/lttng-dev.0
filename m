From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: sessiond and consumerd for 32 and 64 bit apps
Date: Tue, 7 Oct 2014 23:12:47 +0530
Message-ID: <CAM5kDqzYxyX+Hk=FwzvJdFNzzG+t9o7BuK5oPAN_vHBHpxWNPA__6463.82837226174$1412703898$gmane$org@mail.gmail.com>
References: <CAM5kDqxA5UyHOF=6T-ZzhX2GnJ6YmELthKUpPA75BXCm5ynTug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1758738224=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1XbYmj-0000Wm-B9
 for lttng-dev@lists.lttng.org; Tue, 07 Oct 2014 13:43:11 -0400
Received: by mail-wg0-f43.google.com with SMTP id m15so9989437wgh.14
 for <lttng-dev@lists.lttng.org>; Tue, 07 Oct 2014 10:42:47 -0700 (PDT)
In-Reply-To: <CAM5kDqxA5UyHOF=6T-ZzhX2GnJ6YmELthKUpPA75BXCm5ynTug@mail.gmail.com>
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

--===============1758738224==
Content-Type: multipart/alternative; boundary=001a11c24c4438f3e80504d8badb

--001a11c24c4438f3e80504d8badb
Content-Type: text/plain; charset=UTF-8

Hi,
To add more details to my query.
I want to trace both 32-bit and 64-bit apps.
For this i launched sessiond with 32 and 64 bit paramaters of consumerd.
(shown below)

i see that 64-bit app's are able to log whereas 32-bit app's are not
logging.

Below is the output with -vvv, can anyone help me to find the problem here.



mysystem   # find /usr/lib/ -name "*lttng*"

/usr/lib/liblttng-ust-cyg-profile-fast.so.0.0.0

/usr/lib/liblttng-ust-pthread-wrapper.so.0

/usr/lib/liblttng-ust-pthread-wrapper.so.0.0.0

/usr/lib/liblttng-ust-dl.so.0

/usr/lib/liblttng-ust-fork.so.0.0.0

/usr/lib/liblttng-ust-ctl.so.2.0.0

/usr/lib/liblttng-ust-tracepoint.so.0

/usr/lib/liblttng-ust-cyg-profile.so.0.0.0

/usr/lib/liblttng-ust-fork.so.0

/usr/lib/liblttng-ust-ctl.so.2

/usr/lib/liblttng-ust.so.0.0.0

/usr/lib/liblttng-ust-libc-wrapper.so.0

/usr/lib/liblttng-ust-cyg-profile.so.0

/usr/lib/liblttng-ust.so.0

/usr/lib/liblttng-ust-cyg-profile-fast.so.0

/usr/lib/liblttng-ust-dl.so.0.0.0

/usr/lib/liblttng-ust-libc-wrapper.so.0.0.0

/usr/lib/liblttng-ust-tracepoint.so.0.0.0

/usr/lib/liblttng-ctl.so.0

/usr/lib/liblttng-ctl.so.0.0.0

/usr/lib/lttng

/usr/lib/lttng/libexec/lttng-consumerd


mysystem   # find /usr/lib64/ -name "*lttng*"

/usr/lib64/liblttng-ust-cyg-profile-fast.so.0.0.0

/usr/lib64/liblttng-ust-pthread-wrapper.so.0

/usr/lib64/libbabeltrace-lttng-live.so.1.0.0

/usr/lib64/liblttng-ust-pthread-wrapper.so.0.0.0

/usr/lib64/libbabeltrace-lttng-live.so.1

/usr/lib64/liblttng-ust-dl.so.0

/usr/lib64/liblttng-ust-fork.so.0.0.0

/usr/lib64/liblttng-ust-ctl.so.2.0.0

/usr/lib64/liblttng-ust-tracepoint.so.0

/usr/lib64/liblttng-ust-cyg-profile.so.0.0.0

/usr/lib64/liblttng-ust-fork.so.0

/usr/lib64/liblttng-ust-ctl.so.2

/usr/lib64/liblttng-ctl.so.0

/usr/lib64/liblttng-ctl.so.0.0.0

/usr/lib64/liblttng-ust.so.0.0.0

/usr/lib64/liblttng-ust-libc-wrapper.so.0

/usr/lib64/liblttng-ust-cyg-profile.so.0

/usr/lib64/liblttng-ust.so.0

/usr/lib64/liblttng-ust-cyg-profile-fast.so.0

/usr/lib64/liblttng-ust-dl.so.0.0.0

/usr/lib64/lttng

/usr/lib64/lttng/libexec/lttng-consumerd

/usr/lib64/liblttng-ust-libc-wrapper.so.0.0.0

/usr/lib64/liblttng-ust-tracepoint.so.0.0.0

mysystem  #








mysystem # lttng-relayd -d

mysystem #

mysystem # lttng-sessiond --consumerd32-path
/usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/
--consumerd64-path /usr/lib64/lttng/libexec/lttng-consumerd
--consumerd64-libdir /usr/lib64/ -b --no-kernel -vvv

DEBUG3 [1203/1203]: Creating LTTng run directory: /var/run/lttng (in
create_lttng_rundir() at main.c:4301)

DEBUG2 [1203/1203]: Kernel consumer err path:
/var/run/lttng/kconsumerd/error (in main() at main.c:4642)

DEBUG2 [1203/1203]: Kernel consumer cmd path:
/var/run/lttng/kconsumerd/command (in main() at main.c:4644)

DEBUG1 [1203/1203]: Client socket path /var/run/lttng/client-lttng-sessiond
(in main() at main.c:4697)

DEBUG1 [1203/1203]: Application socket path /var/run/lttng/lttng-ust-sock-5
(in main() at main.c:4698)

DEBUG1 [1203/1203]: Application wait path /lttng-ust-wait-5 (in main() at
main.c:4699)

DEBUG1 [1203/1203]: LTTng run directory path: /var/run/lttng (in main() at
main.c:4700)

DEBUG2 [1203/1203]: UST consumer 32 bits err path:
/var/run/lttng/ustconsumerd32/error (in main() at main.c:4709)

DEBUG2 [1203/1203]: UST consumer 32 bits cmd path:
/var/run/lttng/ustconsumerd32/command (in main() at main.c:4711)

DEBUG2 [1203/1203]: UST consumer 64 bits err path:
/var/run/lttng/ustconsumerd64/error (in main() at main.c:4720)

DEBUG2 [1203/1203]: UST consumer 64 bits cmd path:
/var/run/lttng/ustconsumerd64/command (in main() at main.c:4722)

DEBUG3 [1203/1203]: Created hashtable size 4 at 0x6670a0 of type 1 (in
lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1203]: Created hashtable size 4 at 0x6674c0 of type 1 (in
lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1203]: Created hashtable size 4 at 0x667900 of type 1 (in
lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1203]: Created hashtable size 4 at 0x667d40 of type 1 (in
lttng_ht_new() at hashtable.c:127)

DEBUG2 [1203/1203]: Creating consumer directory: /var/run/lttng/kconsumerd
(in set_consumer_sockets() at main.c:4343)

Warning: No tracing group detected

DEBUG2 [1203/1203]: Creating consumer directory:
/var/run/lttng/ustconsumerd64 (in set_consumer_sockets() at main.c:4343)

DEBUG2 [1203/1203]: Creating consumer directory:
/var/run/lttng/ustconsumerd32 (in set_consumer_sockets() at main.c:4343)

DEBUG3 [1203/1203]: Session daemon client socket 8 and application socket 9
created (in init_daemon_socket() at main.c:4209)

DEBUG1 [1203/1203]: All permissions are set (in set_permissions() at
main.c:4289)

DEBUG3 [1203/1203]: Created hashtable size 4 at 0x66a180 of type 2 (in
lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1203]: Global buffer per UID registry initialized (in
buffer_reg_init_uid_registry() at buffer-registry.c:99)

DEBUG3 [1203/1203]: Created hashtable size 4 at 0x66a5c0 of type 2 (in
lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1203]: Global buffer per PID registry initialized (in
buffer_reg_init_pid_registry() at buffer-registry.c:220)

DEBUG1 [1203/1203]: epoll set max size is 825774 (in
compat_epoll_set_max_size() at compat-epoll.c:290)

DEBUG1 [1203/1203]: Command subsystem initialized (in cmd_init() at
cmd.c:3126)

DEBUG1 [1203/1203]: Pid 1203 written in file
/var/run/lttng/lttng-sessiond.pid (in utils_create_pid_file() at
utils.c:465)

DEBUG1 [1203/1203]: Pid 5345 written in file /var/run/lttng/jul.port (in
utils_create_pid_file() at utils.c:465)

DEBUG1 [1203/1203]: TCP inet operation timeout set to 216 sec (in
lttcomm_inet_init() at inet.c:529)

DEBUG1 [1203/1203]: Health check time delta in seconds set to 236 (in
health_init() at health.c:73)

DEBUG1 [1203/1204]: [ht-thread] startup. (in thread_ht_cleanup() at
ht-cleanup.c:36)

DEBUG1 [1203/1206]: [thread] Manage client started (in
thread_manage_clients() at main.c:3735)

DEBUG1 [1203/1205]: [thread] Manage health check started (in
thread_manage_health() at main.c:3549)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)

DEBUG1 [1203/1207]: [thread] Dispatch UST command started (in
thread_dispatch_ust_registration() at main.c:1577)

DEBUG1 [1203/1208]: [thread] Manage application registration started (in
thread_registration_apps() at main.c:1801)

DEBUG1 [1203/1207]: Futex n to 1 prepare done (in futex_nto1_prepare() at
futex.c:75)

DEBUG1 [1203/1207]: Woken up but nothing in the UST command queue (in
thread_dispatch_ust_registration() at main.c:1600)

DEBUG1 [1203/1209]: [thread] Manage application started (in
thread_manage_apps() at main.c:1291)

DEBUG1 [1203/1208]: Notifying applications of session daemon state: 1 (in
notify_ust_apps() at main.c:628)

DEBUG1 [1203/1210]: [ust-thread] Manage application notify command (in
ust_thread_manage_notify() at ust-thread.c:39)

DEBUG3 [1203/1210]: [ust-thread] Manage notify polling on 2 fds (in
ust_thread_manage_notify() at ust-thread.c:68)

DEBUG1 [1203/1211]: [jul-thread] Manage JUL application registration. (in
jul_thread_manage_registration() at jul-thread.c:258)

DEBUG1 [1203/1208]: Got the wait shm fd 19 (in get_wait_shm() at shm.c:115)

DEBUG3 [1203/1211]: URI string: tcp://localhost (in uri_parse() at
uri.c:291)

DEBUG1 [1203/1208]: Futex wait update active 1 (in futex_wait_update() at
futex.c:63)

DEBUG1 [1203/1208]: Accepting application registration (in
thread_registration_apps() at main.c:1838)

DEBUG1 [1203/1209]: Apps thread polling on 2 fds (in thread_manage_apps()
at main.c:1321)

DEBUG1 [1203/1205]: Health check ready (in thread_manage_health() at
main.c:3614)

DEBUG2 [1203/1211]: IP address resolved to 127.0.0.1 (in set_ip_address()
at uri.c:132)

DEBUG3 [1203/1211]: URI dtype: 1, proto: 1, host: localhost, subdir: ,
ctrl: 0, data: 0 (in uri_parse() at uri.c:505)

DEBUG1 [1203/1211]: [jul-thread] Listening on TCP port 5345 and socket 19
(in init_tcp_socket() at jul-thread.c:156)

DEBUG3 [1203/1211]: [jul-thread] Manage JUL polling on 2 fds (in
jul_thread_manage_registration() at jul-thread.c:286)

mysystem #

mysystem # lttng  --no-sessiond create mysession --live 200000 -U
net://localhost

DEBUG1 [1203/1206]: Wait for client response (in thread_manage_clients() at
main.c:3819)

DEBUG1 [1203/1206]: Receiving data from client ... (in
thread_manage_clients() at main.c:3864)

DEBUG1 [1203/1206]: Processing client command 30 (in process_client_msg()
at main.c:2637)

DEBUG1 [1203/1206]: Waiting for 2 URIs from client ... (in
process_client_msg() at main.c:3490)

DEBUG2 [1203/1206]: Trying to find session by name mysession (in
session_find_by_name() at session.c:169)

DEBUG3 [1203/1206]: Created hashtable size 4 at 0x7f2e9c007ef0 of type 1
(in lttng_ht_new() at hashtable.c:127)

DEBUG1 [1203/1206]: Tracing session mysession created with ID 0 by UID 0
GID 0 (in session_create() at session.c:276)

DEBUG2 [1203/1206]: Trying to find session by name mysession (in
session_find_by_name() at session.c:169)

DEBUG3 [1203/1206]: Created hashtable size 4 at 0x7f2e9c00d390 of type 1
(in lttng_ht_new() at hashtable.c:127)

DEBUG2 [1203/1206]: Setting network URI to consumer (in
add_uri_to_consumer() at cmd.c:435)

DEBUG3 [1203/1206]: Consumer control URI set with port 5342 (in
consumer_set_network_uri() at consumer.c:641)

DEBUG3 [1203/1206]: Consumer set network uri subdir path mysystem_node/ (in
consumer_set_network_uri() at consumer.c:701)

DEBUG2 [1203/1206]: Consumer subdir set to
mysystem_node//mysession-20141007-101236/ (in consumer_set_subdir() at
consumer.c:1059)

DEBUG3 [1203/1206]: Append domain trace name to subdir
mysystem_node//mysession-20141007-101236/ (in add_uri_to_consumer() at
cmd.c:477)

DEBUG2 [1203/1206]: Setting network URI to consumer (in
add_uri_to_consumer() at cmd.c:435)

DEBUG3 [1203/1206]: Consumer data URI set with port 5343 (in
consumer_set_network_uri() at consumer.c:656)

DEBUG1 [1203/1206]: Sending response (size: 16, retcode: Success) (in
thread_manage_clients() at main.c:3913)

DEBUG1 [1203/1206]: Clean command context structure (in clean_command_ctx()
at main.c:608)

DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)

Session mysession created.

Traces will be written in net://localhost

Live timer set to 200000 usec

mysystem #

mysystem #

mysystem #  lttng enable-channel mychannel --userspace --buffers-pid -s
mysession --tracefile-size 8388608 --tracefile-count 8

DEBUG1 [1203/1206]: Wait for client response (in thread_manage_clients() at
main.c:3819)

DEBUG1 [1203/1206]: Receiving data from client ... (in
thread_manage_clients() at main.c:3864)

DEBUG1 [1203/1206]: Nothing recv() from client... continuing (in
thread_manage_clients() at main.c:3868)

DEBUG1 [1203/1206]: Clean command context structure (in clean_command_ctx()
at main.c:608)

DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)

DEBUG1 [1203/1206]: Wait for client response (in thread_manage_clients() at
main.c:3819)

DEBUG1 [1203/1206]: Receiving data from client ... (in
thread_manage_clients() at main.c:3864)

DEBUG1 [1203/1206]: Processing client command 5 (in process_client_msg() at
main.c:2637)

DEBUG1 [1203/1206]: Getting session mysession by name (in
process_client_msg() at main.c:2716)

DEBUG2 [1203/1206]: Trying to find session by name mysession (in
session_find_by_name() at session.c:169)

DEBUG1 [1203/1206]: Creating UST session (in create_ust_session() at
main.c:2517)

DEBUG3 [1203/1206]: Created hashtable size 4 at 0x7f2e9c003e90 of type 0
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1206]: Created hashtable size 4 at 0x7f2e9c0042d0 of type 0
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1206]: Created hashtable size 4 at 0x7f2e9c0046f0 of type 1
(in lttng_ht_new() at hashtable.c:127)

DEBUG2 [1203/1206]: UST trace session create successful (in
trace_ust_create_session() at trace-ust.c:263)

DEBUG3 [1203/1206]: Copying tracing session consumer output in UST session
(in copy_session_consumer() at main.c:2466)

DEBUG3 [1203/1206]: Created hashtable size 4 at 0x7f2e9c004b10 of type 1
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1206]: Copy session consumer subdir
mysystem_node//mysession-20141007-101236//ust (in copy_session_consumer()
at main.c:2484)

DEBUG1 [1203/1206]: Spawning consumerd (in spawn_consumerd() at main.c:2158)

DEBUG2 [1203/1206]: Consumer pid 1214 (in start_consumerd() at main.c:2340)

DEBUG2 [1203/1206]: Spawning consumer control thread (in start_consumerd()
at main.c:2343)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG1 [1214/1214]: Using 64-bit UST consumer at:
/usr/lib64/lttng/libexec/lttng-consumerd (in spawn_consumerd() at
main.c:2235)

DEBUG1 [1203/1215]: [thread] Manage consumer started (in
thread_manage_consumer() at main.c:994)

DEBUG2 [1203/1215]: Receiving code from consumer err_sock (in
thread_manage_consumer() at main.c:1079)

Warning: No tracing group detected

DEBUG1 [1203/1215]: Consumer command socket ready (fd: 28 (in
thread_manage_consumer() at main.c:1113)

DEBUG1 [1203/1215]: Consumer metadata socket ready (fd: 29) (in
thread_manage_consumer() at main.c:1115)

DEBUG3 [1203/1206]: Consumer socket created (fd: 28) and added to output
(in consumer_create_socket() at consumer.c:301)

DEBUG1 [1203/1206]: Spawning consumerd (in spawn_consumerd() at main.c:2158)

DEBUG2 [1203/1206]: Consumer pid 1222 (in start_consumerd() at main.c:2340)

DEBUG2 [1203/1206]: Spawning consumer control thread (in start_consumerd()
at main.c:2343)

DEBUG1 [1222/1222]: Using 32-bit UST consumer at:
/usr/lib/lttng/libexec/lttng-consumerd (in spawn_consumerd() at main.c:2278)

DEBUG1 [1203/1223]: [thread] Manage consumer started (in
thread_manage_consumer() at main.c:994)

DEBUG2 [1203/1223]: Receiving code from consumer err_sock (in
thread_manage_consumer() at main.c:1079)

Warning: No tracing group detected

DEBUG1 [1203/1223]: Consumer command socket ready (fd: 32 (in
thread_manage_consumer() at main.c:1113)

DEBUG1 [1203/1223]: Consumer metadata socket ready (fd: 33) (in
thread_manage_consumer() at main.c:1115)

DEBUG3 [1203/1206]: Consumer socket created (fd: 32) and added to output
(in consumer_create_socket() at consumer.c:301)

DEBUG1 [1203/1206]: Setting relayd for session mysession (in
cmd_setup_relayd() at cmd.c:723)

DEBUG3 [1203/1206]: Relayd connect ... (in relayd_connect() at relayd.c:470)

DEBUG3 [1203/1206]: Creating relayd stream socket from URI (in
create_connect_relayd() at cmd.c:568)

DEBUG1 [1203/1206]: Relayd version check for major.minor 2.4 (in
relayd_version_check() at relayd.c:368)

DEBUG3 [1203/1206]: Relayd sending command 5 of size 32 (in send_command()
at relayd.c:80)

DEBUG3 [1203/1206]: Relayd waiting for reply of size 8 (in recv_reply() at
relayd.c:100)

DEBUG2 [1203/1206]: Relayd version is compatible, using protocol version
2.4 (in relayd_version_check() at relayd.c:416)

DEBUG1 [1203/1206]: Relayd create session (in relayd_create_session() at
relayd.c:181)

DEBUG3 [1203/1206]: Relayd sending command 2 of size 351 (in send_command()
at relayd.c:80)

DEBUG3 [1203/1206]: Relayd waiting for reply of size 12 (in recv_reply() at
relayd.c:100)

DEBUG1 [1203/1206]: Relayd session created with id 1 (in
relayd_create_session() at relayd.c:219)

DEBUG3 [1203/1206]: Sending relayd sock info to consumer on 32 (in
consumer_send_relayd_socket() at consumer.c:999)

DEBUG3 [1203/1206]: Sending relayd socket file descriptor to consumer (in
consumer_send_relayd_socket() at consumer.c:1005)

DEBUG2 [1203/1206]: Consumer relayd socket sent (in
consumer_send_relayd_socket() at consumer.c:1011)

DEBUG3 [1203/1206]: Relayd closing socket 34 (in relayd_close() at
relayd.c:501)

DEBUG3 [1203/1206]: Relayd connect ... (in relayd_connect() at relayd.c:470)

DEBUG3 [1203/1206]: Creating relayd data socket from URI (in
create_connect_relayd() at cmd.c:577)

DEBUG3 [1203/1206]: Sending relayd sock info to consumer on 32 (in
consumer_send_relayd_socket() at consumer.c:999)

DEBUG3 [1203/1206]: Sending relayd socket file descriptor to consumer (in
consumer_send_relayd_socket() at consumer.c:1005)

DEBUG2 [1203/1206]: Consumer relayd socket sent (in
consumer_send_relayd_socket() at consumer.c:1011)

DEBUG3 [1203/1206]: Relayd closing socket 34 (in relayd_close() at
relayd.c:501)

DEBUG3 [1203/1206]: Relayd connect ... (in relayd_connect() at relayd.c:470)

DEBUG3 [1203/1206]: Creating relayd stream socket from URI (in
create_connect_relayd() at cmd.c:568)

DEBUG1 [1203/1206]: Relayd version check for major.minor 2.4 (in
relayd_version_check() at relayd.c:368)

DEBUG3 [1203/1206]: Relayd sending command 5 of size 32 (in send_command()
at relayd.c:80)

DEBUG3 [1203/1206]: Relayd waiting for reply of size 8 (in recv_reply() at
relayd.c:100)

DEBUG2 [1203/1206]: Relayd version is compatible, using protocol version
2.4 (in relayd_version_check() at relayd.c:416)

DEBUG1 [1203/1206]: Relayd create session (in relayd_create_session() at
relayd.c:181)

DEBUG3 [1203/1206]: Relayd sending command 2 of size 351 (in send_command()
at relayd.c:80)

DEBUG3 [1203/1206]: Relayd waiting for reply of size 12 (in recv_reply() at
relayd.c:100)

DEBUG1 [1203/1206]: Relayd session created with id 2 (in
relayd_create_session() at relayd.c:219)

DEBUG3 [1203/1206]: Sending relayd sock info to consumer on 28 (in
consumer_send_relayd_socket() at consumer.c:999)

DEBUG3 [1203/1206]: Sending relayd socket file descriptor to consumer (in
consumer_send_relayd_socket() at consumer.c:1005)

DEBUG2 [1203/1206]: Consumer relayd socket sent (in
consumer_send_relayd_socket() at consumer.c:1011)

DEBUG3 [1203/1206]: Relayd closing socket 34 (in relayd_close() at
relayd.c:501)

DEBUG3 [1203/1206]: Relayd connect ... (in relayd_connect() at relayd.c:470)

DEBUG3 [1203/1206]: Creating relayd data socket from URI (in
create_connect_relayd() at cmd.c:577)

DEBUG3 [1203/1206]: Sending relayd sock info to consumer on 28 (in
consumer_send_relayd_socket() at consumer.c:999)

DEBUG3 [1203/1206]: Sending relayd socket file descriptor to consumer (in
consumer_send_relayd_socket() at consumer.c:1005)

DEBUG2 [1203/1206]: Consumer relayd socket sent (in
consumer_send_relayd_socket() at consumer.c:1011)

DEBUG3 [1203/1206]: Relayd closing socket 34 (in relayd_close() at
relayd.c:501)

DEBUG1 [1203/1206]: Enabling channel mychannel for session mysession (in
cmd_enable_channel() at cmd.c:911)

DEBUG2 [1203/1206]: Trace UST channel mychannel not found by name (in
trace_ust_find_channel_by_name() at trace-ust.c:162)

DEBUG3 [1203/1206]: Created hashtable size 4 at 0x7f2e9c005350 of type 0
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1206]: Created hashtable size 4 at 0x7f2e9c005720 of type 1
(in lttng_ht_new() at hashtable.c:127)

DEBUG2 [1203/1206]: Trace UST channel mychannel created (in
trace_ust_create_channel() at trace-ust.c:331)

DEBUG2 [1203/1206]: Channel mychannel is being created for UST with buffer
0 and id 0 (in channel_ust_create() at channel.c:348)

DEBUG2 [1203/1206]: UST app adding channel mychannel to UST domain for
session id 0 (in ust_app_create_channel_glb() at ust-app.c:3536)

DEBUG2 [1203/1206]: Channel mychannel created successfully (in
channel_ust_create() at channel.c:383)

DEBUG1 [1203/1206]: Sending response (size: 16, retcode: Success) (in
thread_manage_clients() at main.c:3913)

DEBUG1 [1203/1206]: Clean command context structure (in clean_command_ctx()
at main.c:608)

DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)

UST channel mychannel enabled for session mysession

mysystem #

mysystem #

mysystem #

mysystem # lttng enable-event --channel mychannel --userspace --all -s
mysession

DEBUG1 [1203/1206]: Wait for client response (in thread_manage_clients() at
main.c:3819)

DEBUG1 [1203/1206]: Receiving data from client ... (in
thread_manage_clients() at main.c:3864)

DEBUG1 [1203/1206]: Nothing recv() from client... continuing (in
thread_manage_clients() at main.c:3868)

DEBUG1 [1203/1206]: Clean command context structure (in clean_command_ctx()
at main.c:608)

DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)

DEBUG1 [1203/1206]: Wait for client response (in thread_manage_clients() at
main.c:3819)

DEBUG1 [1203/1206]: Receiving data from client ... (in
thread_manage_clients() at main.c:3864)

DEBUG1 [1203/1206]: Processing client command 6 (in process_client_msg() at
main.c:2637)

DEBUG1 [1203/1206]: Getting session mysession by name (in
process_client_msg() at main.c:2716)

DEBUG2 [1203/1206]: Trying to find session by name mysession (in
session_find_by_name() at session.c:169)

DEBUG3 [1203/1206]: Consumer socket created (fd: 28) and added to output
(in consumer_create_socket() at consumer.c:301)

DEBUG3 [1203/1206]: Consumer socket created (fd: 32) and added to output
(in consumer_create_socket() at consumer.c:301)

DEBUG1 [1203/1206]: Setting relayd for session mysession (in
cmd_setup_relayd() at cmd.c:723)

DEBUG2 [1203/1206]: Trace UST channel mychannel found by name (in
trace_ust_find_channel_by_name() at trace-ust.c:157)

DEBUG2 [1203/1206]: Trace UST event * NOT found (in trace_ust_find_event()
at trace-ust.c:198)

DEBUG2 [1203/1206]: Trace UST event *, loglevel (0,-1) created (in
trace_ust_create_event() at trace-ust.c:405)

DEBUG1 [1203/1206]: UST app creating event * for all apps for session id 0
(in ust_app_create_event_glb() at ust-app.c:3687)

DEBUG1 [1203/1206]: Event UST * created in channel mychannel (in
event_ust_enable_tracepoint() at event.c:469)

DEBUG1 [1203/1206]: Sending response (size: 16, retcode: Success) (in
thread_manage_clients() at main.c:3913)

DEBUG1 [1203/1206]: Clean command context structure (in clean_command_ctx()
at main.c:608)

DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)

All UST events are enabled in channel mychannel

mysystem #

mysystem #

mysystem #

mysystem # lttng -vvv start

DEBUG1 [1203/1206]: Wait for client response (in thread_manage_clients() at
main.c:3819)

DEBUG1 [1203/1206]: Receiving data from client ... (in
thread_manage_clients() at main.c:3864)

DEBUG1 [1203/1206]: Nothing recv() from client... continuing (in
thread_manage_clients() at main.c:3868)

DEBUG1 [1203/1206]: Clean command context structure (in clean_command_ctx()
at main.c:608)

DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)

DEBUG2 [1234/1234]: Config file path found: /home/root (in
get_session_name() at utils.c:62)

DEBUG1 [1234/1234]: Session name found: mysession (in get_session_name() at
utils.c:63)

DEBUG1 [1234/1234]: Starting tracing for session mysession (in
start_tracing() at commands/start.c:81)

DEBUG1 [1234/1234]: LSM cmd type : 16 (in send_session_msg() at
lttng-ctl.c:131)

DEBUG1 [1203/1206]: Wait for client response (in thread_manage_clients() at
main.c:3819)

DEBUG1 [1203/1206]: Receiving data from client ... (in
thread_manage_clients() at main.c:3864)

DEBUG1 [1203/1206]: Processing client command 16 (in process_client_msg()
at main.c:2637)

DEBUG1 [1203/1206]: Getting session mysession by name (in
process_client_msg() at main.c:2716)

DEBUG2 [1203/1206]: Trying to find session by name mysession (in
session_find_by_name() at session.c:169)

DEBUG1 [1203/1206]: Starting all UST traces (in ust_app_start_trace_all()
at ust-app.c:4034)

DEBUG1 [1203/1206]: Sending response (size: 16, retcode: Success) (in
thread_manage_clients() at main.c:3913)

DEBUG1 [1203/1206]: Clean command context structure (in clean_command_ctx()
at main.c:608)

DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)

Tracing started for session mysession

mysystem #

mysystem #

mysystem #




root      1194  0.0  0.0 420760  1068 ?        Ssl  10:12   0:00
lttng-relayd -d

root      1203  0.0  0.0 779704  1620 ?        Ssl  10:12   0:00
lttng-sessiond --consumerd32-path /usr/lib/lttng/libexec/lttng-consumerd
--consumerd32-libdir /usr/lib/ --consumerd64-path
/usr/lib64/lttng/libexec/lttng-consumerd --consumerd64-libdir /usr/lib64/
-b --no-kernel -vvv

root      1214  0.0  0.0 478212   948 ?        Sl   10:12   0:00
lttng-consumerd --quiet -u --consumerd-cmd-sock
/var/run/lttng/ustconsumerd64/command --consumerd-err-sock
/var/run/lttng/ustconsumerd64/error --group tracing

root      1222  0.0  0.0  63072   772 ?        Sl   10:12   0:00
lttng-consumerd --quiet -u --consumerd-cmd-sock
/var/run/lttng/ustconsumerd32/command --consumerd-err-sock
/var/run/lttng/ustconsumerd32/error --group tracing






mysystem # /usr/bin/logtrace_test    <<<<<<running a 32-bit app

DEBUG1 [1203/1208]: UST registration received with pid:1235 ppid:850 uid:0
gid:0 sock:25 name:logtrace_test (version 5.0) (in
thread_registration_apps() at main.c:1946)

DEBUG1 [1203/1208]: Futex n to 1 wake done (in futex_nto1_wake() at
futex.c:104)

DEBUG1 [1203/1208]: Accepting application registration (in
thread_registration_apps() at main.c:1838)

DEBUG1 [1203/1207]: Futex n to 1 wait done (in futex_nto1_wait() at
futex.c:90)

DEBUG1 [1203/1207]: Futex n to 1 prepare done (in futex_nto1_prepare() at
futex.c:75)

DEBUG1 [1203/1207]: Dispatching UST registration pid:1235 ppid:850 uid:0
gid:0 sock:25 name:logtrace_test (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1612)

DEBUG3 [1203/1207]: UST app creating application for socket 25 (in
ust_app_create() at ust-app.c:2848)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80000a10 of type 2
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80000e50 of type 1
(in lttng_ht_new() at hashtable.c:127)

DEBUG1 [1203/1208]: UST registration received with pid:1235 ppid:850 uid:0
gid:0 sock:34 name:logtrace_test (version 5.0) (in
thread_registration_apps() at main.c:1946)

DEBUG1 [1203/1207]: Woken up but nothing in the UST command queue (in
thread_dispatch_ust_registration() at main.c:1600)

DEBUG1 [1203/1207]: Futex n to 1 wait done (in futex_nto1_wait() at
futex.c:90)

DEBUG1 [1203/1207]: Futex n to 1 prepare done (in futex_nto1_prepare() at
futex.c:75)

DEBUG1 [1203/1207]: Dispatching UST registration pid:1235 ppid:850 uid:0
gid:0 sock:34 name:logtrace_test (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1612)

DEBUG3 [1203/1207]: UST app notify socket 34 is set (in
thread_dispatch_ust_registration() at main.c:1669)

DEBUG1 [1203/1207]: App registered with pid:1235 ppid:850 uid:0 gid:0
sock:25 name:logtrace_test notify_sock:34 (version 5.0) (in ust_app_add()
at ust-app.c:2936)

DEBUG1 [1203/1208]: Futex n to 1 wake done (in futex_nto1_wake() at
futex.c:104)

DEBUG1 [1203/1208]: Accepting application registration (in
thread_registration_apps() at main.c:1838)

DEBUG2 [1203/1207]: UST app global update for app sock 25 for session id 0
(in ust_app_global_update() at ust-app.c:4173)

DEBUG2 [1203/1207]: UST app pid: 1235 session id 0 not found, creating it
(in create_ust_app_session() at ust-app.c:1842)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80002370 of type 0
(in lttng_ht_new() at hashtable.c:127)

DEBUG2 [1203/1207]: Shadow copy of session handle -1 (in
shadow_copy_session() at ust-app.c:1598)

DEBUG2 [1203/1207]: Channel mychannel not found on shadow session copy,
creating it (in shadow_copy_session() at ust-app.c:1648)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e800029f0 of type 1
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80002e30 of type 0
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1207]: UST app channel mychannel allocated (in
alloc_ust_app_channel() at ust-app.c:882)

DEBUG2 [1203/1207]: UST app shadow copy of channel mychannel started (in
shadow_copy_channel() at ust-app.c:1525)

DEBUG2 [1203/1207]: UST event * not found on shadow copy channel (in
shadow_copy_channel() at ust-app.c:1565)

DEBUG3 [1203/1207]: UST app event * allocated (in alloc_ust_app_event() at
ust-app.c:938)

DEBUG3 [1203/1207]: UST app shadow copy of channel mychannel done (in
shadow_copy_channel() at ust-app.c:1575)

DEBUG3 [1203/1207]: Buffer registry per PID find id: 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80003660 of type 2
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1207]: Buffer registry per PID created with session id: 1 (in
buffer_reg_pid_create() at buffer-registry.c:262)

DEBUG3 [1203/1207]: Buffer registry per PID adding to global registry with
id: 1 (in buffer_reg_pid_add() at buffer-registry.c:281)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80003b40 of type 2
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1207]: Append to metadata: "typealias integer { size = 8;
align = 8; signed = false; } := uint8_t;

typealias integer { size = 16; align = 8; signed = false; } := uint16_t;

typealias integer { size = 32; align = 8; signed = false; } := uint32_t;

typealias integer { size = 64; align = 8; signed = false; } := uint64_t;

typealias integer { size = 32; align = 8; signed = false; } := unsigned
long;

typealias integer { size = 5; align = 1; signed = false; } := uint5_t;

typealias integer { size = 27; align = 1; signed = false; } := uint27_t;



trace {

        major = 1;

        minor = 8;

        uuid = "41ae6e13-c919-43b6-a5a8-76194517882b";

        byte_order = le;

        packet.header := struct {

                uint32_t magic;

                uint8_t  uuid[16];

                uint32_t stream_id;

        };

};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: UST thread notify added sock 34 to pollset (in
ust_thread_manage_notify() at ust-thread.c:137)

DEBUG3 [1203/1210]: [ust-thread] Manage notify polling on 3 fds (in
ust_thread_manage_notify() at ust-thread.c:68)

DEBUG3 [1203/1207]: Append to metadata: "env {

        hostname = "mysystem_node";

        domain = "ust";

        tracer_name = "lttng-ust";

        tracer_major = 2;

        tracer_minor = 4;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "       tracer_patchlevel = 1;

        vpid = 1235;

        procname = "logtrace_test";

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "clock {

        name = monotonic;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "       uuid =
"b1019e3b-fafd-4c41-bebc-c476fa343570";

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "       description = "Monotonic
Clock";

        freq = 1000000000; /* Frequency, in Hz */

        /* clock value offset from Epoch is: offset * (1/freq) */

        offset = 1412699639502362921;

};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "typealias integer {

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



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "struct packet_context {

        uint64_clock_monotonic_t timestamp_begin;

        uint64_clock_monotonic_t timestamp_end;

        uint64_t content_size;

        uint64_t packet_size;

        unsigned long events_discarded;

        uint32_t cpu_id;

};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "struct event_header_compact {

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



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: UST app buffer registry per PID created successfully
(in setup_buffer_reg_pid() at ust-app.c:1746)

DEBUG2 [1203/1207]: UST app session created successfully with handle 1 (in
create_ust_app_session() at ust-app.c:1910)

DEBUG1 [1203/1207]: UST app creating channel mychannel with per PID buffers
(in create_channel_per_pid() at ust-app.c:2512)

DEBUG3 [1203/1207]: Buffer registry per PID find id: 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80004000 of type 0
(in lttng_ht_new() at hashtable.c:127)

DEBUG2 [1203/1207]: Asking UST consumer for channel (in
ask_channel_creation() at ust-consumer.c:118)

DEBUG3 [1203/1207]: UST registry channel finding key 1 (in
ust_registry_channel_find() at ust-registry.c:489)

DEBUG2 [1203/1207]: UST ask channel 1 successfully done with 2 stream(s)
(in ask_channel_creation() at ust-consumer.c:195)

DEBUG2 [1203/1207]: UST app stream 1 received succesfully (in
ust_consumer_get_channel() at ust-consumer.c:311)

DEBUG2 [1203/1207]: UST app stream 2 received succesfully (in
ust_consumer_get_channel() at ust-consumer.c:311)

DEBUG3 [1203/1207]: UST app consumer has no more stream available (in
ust_consumer_get_channel() at ust-consumer.c:294)

DEBUG1 [1203/1207]: UST app sending channel mychannel to UST app sock 25
(in send_channel_pid_to_ust() at ust-app.c:1365)

DEBUG2 [1203/1207]: UST app send channel to sock 25 pid 1235 (name:
mychannel, key: 0) (in ust_consumer_send_channel_to_ust() at
ust-consumer.c:415)

DEBUG2 [1203/1207]: UST consumer send stream to app 25 (in
ust_consumer_send_stream_to_ust() at ust-consumer.c:380)

DEBUG2 [1203/1207]: UST consumer send stream to app 25 (in
ust_consumer_send_stream_to_ust() at ust-consumer.c:380)

DEBUG2 [1203/1207]: UST app event * created successfully for pid:1235 (in
create_ust_event() at ust-app.c:1428)

DEBUG1 [1203/1207]: Starting tracing for ust app pid 1235 (in
ust_app_start_trace() at ust-app.c:3742)

DEBUG3 [1203/1207]: Buffer registry per PID find id: 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80005dc0 of type 1
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80006060 of type 0
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1207]: UST app channel metadata allocated (in
alloc_ust_app_channel() at ust-app.c:882)

DEBUG2 [1203/1207]: Asking UST consumer for channel (in
ask_channel_creation() at ust-consumer.c:118)

DEBUG2 [1203/1207]: UST ask channel 2 successfully done with 1 stream(s)
(in ask_channel_creation() at ust-consumer.c:195)

DEBUG2 [1203/1207]: Consumer setup metadata channel key 2 (in
consumer_setup_metadata() at consumer.c:1205)

DEBUG2 [1203/1207]: UST metadata with key 2 created for app pid 1235 (in
create_ust_app_metadata() at ust-app.c:2800)

DEBUG3 [1203/1207]: UST app deleting channel metadata (in
delete_ust_app_channel() at ust-app.c:374)

DEBUG3 [1203/1207]: Buffer registry per PID find id: 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1207]: UST registry channel finding key 2 (in
ust_registry_channel_find() at ust-registry.c:489)

DEBUG3 [1203/1210]: UST app receiving notify from sock 34 (in
ust_app_recv_notify() at ust-app.c:4730)

DEBUG2 [1203/1210]: UST app ustctl register event received (in
ust_app_recv_notify() at ust-app.c:4750)

DEBUG3 [1203/1210]: Buffer registry per PID find id: 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1210]: UST registry channel finding key 1 (in
ust_registry_channel_find() at ust-registry.c:489)

DEBUG3 [1203/1210]: UST registry creating event with event:
ust_baddr_statedump:soinfo, sig: struct lttng_session *, session, void *,
baddr, const char*, sopath, int64_t, size, int64_t, mtime, id: 0,
chan_objd: 2, sess_objd: 1, chan_id: 0 (in ust_registry_create_event() at
ust-registry.c:298)

DEBUG3 [1203/1210]: Append to metadata: "event {

        name = "ust_baddr_statedump:soinfo";

        id = 0;

        stream_id = 0;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       loglevel = 13;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       fields := struct {

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
32; align = 8; signed = 0; encoding = none; base = 16; } _baddr;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               string _sopath;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
64; align = 8; signed = 1; encoding = none; base = 10; } _size;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
64; align = 8; signed = 1; encoding = none; base = 10; } _mtime;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       };

};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: UST registry event ust_baddr_statedump:soinfo with id 0
added successfully (in add_event_ust_registry() at ust-app.c:4711)

DEBUG3 [1203/1210]: [ust-thread] Manage notify polling on 3 fds (in
ust_thread_manage_notify() at ust-thread.c:68)

DEBUG3 [1203/1210]: UST app receiving notify from sock 34 (in
ust_app_recv_notify() at ust-app.c:4730)

DEBUG2 [1203/1210]: UST app ustctl register channel received (in
ust_app_recv_notify() at ust-app.c:4783)

DEBUG3 [1203/1210]: Buffer registry per PID find id: 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1210]: UST registry channel finding key 1 (in
ust_registry_channel_find() at ust-registry.c:489)

DEBUG3 [1203/1210]: Append to metadata: "stream {

        id = 0;

        event.header := struct event_header_compact;

        packet.context := struct packet_context;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: UST app replying to register channel key 1 with id 0,
type: 1, ret: 0 (in reply_ust_register_channel() at ust-app.c:4596)

DEBUG3 [1203/1210]: [ust-thread] Manage notify polling on 3 fds (in
ust_thread_manage_notify() at ust-thread.c:68)

DEBUG2 [1203/1207]: UST trace started for app pid 1235 (in
ust_app_global_update() at ust-app.c:4247)

DEBUG1 [1203/1207]: Woken up but nothing in the UST command queue (in
thread_dispatch_ust_registration() at main.c:1600)

DEBUG1 [1203/1209]: Apps with sock 25 added to poll set (in
thread_manage_apps() at main.c:1382)

DEBUG1 [1203/1209]: Apps thread polling on 3 fds (in thread_manage_apps()
at main.c:1321)

DEBUG3 [1203/1210]: UST app receiving notify from sock 34 (in
ust_app_recv_notify() at ust-app.c:4730)

DEBUG2 [1203/1210]: UST app ustctl register event received (in
ust_app_recv_notify() at ust-app.c:4750)

DEBUG3 [1203/1210]: Buffer registry per PID find id: 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1210]: UST registry channel finding key 1 (in
ust_registry_channel_find() at ust-registry.c:489)

DEBUG3 [1203/1210]: UST registry creating event with event:
example_provider:trace_test_tp_id1, sig: const char *, text, id: 0,
chan_objd: 2, sess_objd: 1, chan_id: 0 (in ust_registry_create_event() at
ust-registry.c:298)

DEBUG3 [1203/1210]: Append to metadata: "event {

        name = "example_provider:trace_test_tp_id1";

        id = 1;

        stream_id = 0;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       loglevel = 4;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       fields := struct {

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               string _message;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       };

};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: UST registry event example_provider:trace_test_tp_id1
with id 1 added successfully (in add_event_ust_registry() at ust-app.c:4711)

DEBUG3 [1203/1210]: [ust-thread] Manage notify polling on 3 fds (in
ust_thread_manage_notify() at ust-thread.c:68)

DEBUG3 [1203/1210]: UST app receiving notify from sock 34 (in
ust_app_recv_notify() at ust-app.c:4730)

DEBUG2 [1203/1210]: UST app ustctl register event received (in
ust_app_recv_notify() at ust-app.c:4750)

DEBUG3 [1203/1210]: Buffer registry per PID find id: 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1210]: UST registry channel finding key 1 (in
ust_registry_channel_find() at ust-registry.c:489)

DEBUG3 [1203/1210]: UST registry creating event with event:
example_provider:trace_test_tp_id2, sig: int, anint, int, netint, long *,
values, char *, text, size_t, textlen, double, doublearg, float, floatarg,
id: 0, chan_objd: 2, sess_objd: 1, chan_id: 0 (in
ust_registry_create_event() at ust-registry.c:298)

DEBUG3 [1203/1210]: Append to metadata: "event {

        name = "example_provider:trace_test_tp_id2";

        id = 2;

        stream_id = 0;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       loglevel = 3;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       fields := struct {

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
32; align = 8; signed = 1; encoding = none; base = 10; } _intfield;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
32; align = 8; signed = 1; encoding = none; base = 16; } _intfield2;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
32; align = 8; signed = 1; encoding = none; base = 10; } _longfield;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
32; align = 8; signed = 1; encoding = none; base = 10; byte_order = be; }
_netintfield;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
32; align = 8; signed = 1; encoding = none; base = 16; byte_order = be; }
_netintfieldhex;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
32; align = 8; signed = 1; encoding = none; base = 10; } _arrfield1[3];

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size = 8;
align = 8; signed = 1; encoding = UTF8; base = 10; } _arrfield2[10];

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
32; align = 8; signed = 0; encoding = none; base = 10; } __seqfield1_length;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size = 8;
align = 8; signed = 1; encoding = none; base = 10; } _seqfield1[
__seqfield1_length ];

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
32; align = 8; signed = 0; encoding = none; base = 10; } __seqfield2_length;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size = 8;
align = 8; signed = 1; encoding = UTF8; base = 10; } _seqfield2[
__seqfield2_length ];

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               string _stringfield;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               floating_point {
exp_dig = 8; mant_dig = 24; align = 8; } _floatfield;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               floating_point {
exp_dig = 11; mant_dig = 53; align = 8; } _doublefield;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       };

};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: UST registry event example_provider:trace_test_tp_id2
with id 2 added successfully (in add_event_ust_registry() at ust-app.c:4711)

DEBUG3 [1203/1210]: [ust-thread] Manage notify polling on 3 fds (in
ust_thread_manage_notify() at ust-thread.c:68)

mysystem # DEBUG1 [1203/1209]: PID 1235 unregistering with sock 25 (in
ust_app_unregister() at ust-app.c:2987)

DEBUG3 [1203/1209]: Buffer registry per PID find id: 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG2 [1203/1209]: Consumer push metadata to consumer socket 32 (in
consumer_push_metadata() at consumer.c:1239)

DEBUG3 [1203/1209]: Consumer pushing metadata on sock 32 of len 4251 (in
consumer_push_metadata() at consumer.c:1254)

DEBUG1 [1203/1210]: UST app notify socket unregister 34 (in
ust_app_notify_sock_unregister() at ust-app.c:4857)

DEBUG2 [1203/1210]: UST app find by notify sock 34 not found (in
find_app_by_notify_sock() at ust-app.c:1029)

DEBUG3 [1203/1210]: [ust-thread] Manage notify polling on 2 fds (in
ust_thread_manage_notify() at ust-thread.c:68)

DEBUG1 [1203/1223]: Metadata request received for session 0, key 2 (in
ust_consumer_metadata_request() at ust-consumer.c:461)

DEBUG3 [1203/1223]: Buffer registry per UID find id: 0, ABI: 32, uid: 0 (in
buffer_reg_uid_find() at buffer-registry.c:195)

DEBUG3 [1203/1223]: Buffer registry per PID find id: 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1223]: No metadata to push for metadata key 2 (in
ust_app_push_metadata() at ust-app.c:460)

DEBUG1 [1203/1223]: No metadata to push (in ust_app_push_metadata() at
ust-app.c:463)

DEBUG2 [1203/1223]: Consumer push metadata to consumer socket 33 (in
consumer_push_metadata() at consumer.c:1239)

DEBUG1 [1203/1223]: UST Consumer metadata pushed successfully (in
ust_consumer_metadata_request() at ust-consumer.c:496)

DEBUG2 [1203/1209]: Consumer close metadata channel key 2 (in
consumer_close_metadata() at consumer.c:1172)

DEBUG1 [1203/1209]: Apps thread polling on 2 fds (in thread_manage_apps()
at main.c:1321)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1244]: Call RCU deleting app PID 1235 (in delete_ust_app_rcu()
at ust-app.c:780)

DEBUG3 [1203/1244]: Buffer registry per PID find id: 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1244]: UST app deleting channel mychannel (in
delete_ust_app_channel() at ust-app.c:374)

DEBUG3 [1203/1244]: Buffer registry per PID find id: 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1244]: UST registry channel finding key 1 (in
ust_registry_channel_find() at ust-registry.c:489)

DEBUG3 [1203/1244]: Buffer registry per PID find id: 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1244]: Buffer registry per PID destroy with id: 1 (in
buffer_reg_pid_destroy() at buffer-registry.c:686)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG2 [1203/1244]: UST app pid 1235 deleted (in delete_ust_app() at
ust-app.c:765)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1244]: Buffer registry session destroy (in
buffer_reg_session_destroy() at buffer-registry.c:543)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)



mysystem #

mysystem # babeltrace /home/root/lttng-traces/     <<<<<<no traces found

mysystem #

mysystem #



mysystem #

mysystem # /logtrace_test64   <<<<<<<<<<running a 64-bit app

DEBUG1 [1203/1208]: UST registration received with pid:1250 ppid:850 uid:0
gid:0 sock:25 name:logtrace_test64 (version 5.0) (in
thread_registration_apps() at main.c:1946)

DEBUG1 [1203/1208]: Futex n to 1 wake done (in futex_nto1_wake() at
futex.c:104)

DEBUG1 [1203/1208]: Accepting application registration (in
thread_registration_apps() at main.c:1838)

DEBUG1 [1203/1207]: Futex n to 1 wait done (in futex_nto1_wait() at
futex.c:90)

DEBUG1 [1203/1207]: Futex n to 1 prepare done (in futex_nto1_prepare() at
futex.c:75)

DEBUG1 [1203/1207]: Dispatching UST registration pid:1250 ppid:850 uid:0
gid:0 sock:25 name:logtrace_test64 (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1612)

DEBUG3 [1203/1207]: UST app creating application for socket 25 (in
ust_app_create() at ust-app.c:2848)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e800028c0 of type 2
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80002c90 of type 1
(in lttng_ht_new() at hashtable.c:127)

DEBUG1 [1203/1207]: Woken up but nothing in the UST command queue (in
thread_dispatch_ust_registration() at main.c:1600)

DEBUG1 [1203/1208]: UST registration received with pid:1250 ppid:850 uid:0
gid:0 sock:34 name:logtrace_test64 (version 5.0) (in
thread_registration_apps() at main.c:1946)

DEBUG1 [1203/1208]: Futex n to 1 wake done (in futex_nto1_wake() at
futex.c:104)

DEBUG1 [1203/1208]: Accepting application registration (in
thread_registration_apps() at main.c:1838)

DEBUG1 [1203/1207]: Futex n to 1 wait done (in futex_nto1_wait() at
futex.c:90)

DEBUG1 [1203/1207]: Futex n to 1 prepare done (in futex_nto1_prepare() at
futex.c:75)

DEBUG1 [1203/1207]: Dispatching UST registration pid:1250 ppid:850 uid:0
gid:0 sock:34 name:logtrace_test64 (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1612)

DEBUG3 [1203/1207]: UST app notify socket 34 is set (in
thread_dispatch_ust_registration() at main.c:1669)

DEBUG1 [1203/1207]: App registered with pid:1250 ppid:850 uid:0 gid:0
sock:25 name:logtrace_test64 notify_sock:34 (version 5.0) (in ust_app_add()
at ust-app.c:2936)

DEBUG2 [1203/1207]: UST app global update for app sock 25 for session id 0
(in ust_app_global_update() at ust-app.c:4173)

DEBUG2 [1203/1207]: UST app pid: 1250 session id 0 not found, creating it
(in create_ust_app_session() at ust-app.c:1842)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e800030d0 of type 0
(in lttng_ht_new() at hashtable.c:127)

DEBUG2 [1203/1207]: Shadow copy of session handle -1 (in
shadow_copy_session() at ust-app.c:1598)

DEBUG2 [1203/1207]: Channel mychannel not found on shadow session copy,
creating it (in shadow_copy_session() at ust-app.c:1648)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80001c00 of type 1
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80002040 of type 0
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1207]: UST app channel mychannel allocated (in
alloc_ust_app_channel() at ust-app.c:882)

DEBUG2 [1203/1207]: UST app shadow copy of channel mychannel started (in
shadow_copy_channel() at ust-app.c:1525)

DEBUG2 [1203/1207]: UST event * not found on shadow copy channel (in
shadow_copy_channel() at ust-app.c:1565)

DEBUG3 [1203/1207]: UST app event * allocated (in alloc_ust_app_event() at
ust-app.c:938)

DEBUG3 [1203/1207]: UST app shadow copy of channel mychannel done (in
shadow_copy_channel() at ust-app.c:1575)

DEBUG3 [1203/1207]: Buffer registry per PID find id: 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80003a50 of type 2
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1207]: Buffer registry per PID created with session id: 2 (in
buffer_reg_pid_create() at buffer-registry.c:262)

DEBUG3 [1203/1207]: Buffer registry per PID adding to global registry with
id: 2 (in buffer_reg_pid_add() at buffer-registry.c:281)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80003f30 of type 2
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1210]: UST thread notify added sock 34 to pollset (in
ust_thread_manage_notify() at ust-thread.c:137)

DEBUG3 [1203/1210]: [ust-thread] Manage notify polling on 3 fds (in
ust_thread_manage_notify() at ust-thread.c:68)

DEBUG3 [1203/1207]: Append to metadata: "typealias integer { size = 8;
align = 8; signed = false; } := uint8_t;

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

        uuid = "ec211891-6c61-4af7-8ceb-29962469f700";

        byte_order = le;

        packet.header := struct {

                uint32_t magic;

                uint8_t  uuid[16];

                uint32_t stream_id;

        };

};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "env {

        hostname = "mysystem_node";

        domain = "ust";

        tracer_name = "lttng-ust";

        tracer_major = 2;

        tracer_minor = 4;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "       tracer_patchlevel = 1;

        vpid = 1250;

        procname = "logtrace_test64";

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "clock {

        name = monotonic;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "       uuid =
"b1019e3b-fafd-4c41-bebc-c476fa343570";

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "       description = "Monotonic
Clock";

        freq = 1000000000; /* Frequency, in Hz */

        /* clock value offset from Epoch is: offset * (1/freq) */

        offset = 1412699639502362921;

};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "typealias integer {

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



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "struct packet_context {

        uint64_clock_monotonic_t timestamp_begin;

        uint64_clock_monotonic_t timestamp_end;

        uint64_t content_size;

        uint64_t packet_size;

        unsigned long events_discarded;

        uint32_t cpu_id;

};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: Append to metadata: "struct event_header_compact {

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



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1207]: UST app buffer registry per PID created successfully
(in setup_buffer_reg_pid() at ust-app.c:1746)

DEBUG2 [1203/1207]: UST app session created successfully with handle 1 (in
create_ust_app_session() at ust-app.c:1910)

DEBUG1 [1203/1207]: UST app creating channel mychannel with per PID buffers
(in create_channel_per_pid() at ust-app.c:2512)

DEBUG3 [1203/1207]: Buffer registry per PID find id: 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80002460 of type 0
(in lttng_ht_new() at hashtable.c:127)

DEBUG2 [1203/1207]: Asking UST consumer for channel (in
ask_channel_creation() at ust-consumer.c:118)

DEBUG3 [1203/1207]: UST registry channel finding key 3 (in
ust_registry_channel_find() at ust-registry.c:489)

DEBUG2 [1203/1207]: UST ask channel 3 successfully done with 2 stream(s)
(in ask_channel_creation() at ust-consumer.c:195)

DEBUG2 [1203/1207]: UST app stream 1 received succesfully (in
ust_consumer_get_channel() at ust-consumer.c:311)

DEBUG2 [1203/1207]: UST app stream 2 received succesfully (in
ust_consumer_get_channel() at ust-consumer.c:311)

DEBUG3 [1203/1207]: UST app consumer has no more stream available (in
ust_consumer_get_channel() at ust-consumer.c:294)

DEBUG1 [1203/1207]: UST app sending channel mychannel to UST app sock 25
(in send_channel_pid_to_ust() at ust-app.c:1365)

DEBUG2 [1203/1207]: UST app send channel to sock 25 pid 1250 (name:
mychannel, key: 0) (in ust_consumer_send_channel_to_ust() at
ust-consumer.c:415)

DEBUG2 [1203/1207]: UST consumer send stream to app 25 (in
ust_consumer_send_stream_to_ust() at ust-consumer.c:380)

DEBUG2 [1203/1207]: UST consumer send stream to app 25 (in
ust_consumer_send_stream_to_ust() at ust-consumer.c:380)

DEBUG2 [1203/1207]: UST app event * created successfully for pid:1250 (in
create_ust_event() at ust-app.c:1428)

DEBUG1 [1203/1207]: Starting tracing for ust app pid 1250 (in
ust_app_start_trace() at ust-app.c:3742)

DEBUG3 [1203/1207]: Buffer registry per PID find id: 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80004a90 of type 1
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f2e80006680 of type 0
(in lttng_ht_new() at hashtable.c:127)

DEBUG3 [1203/1207]: UST app channel metadata allocated (in
alloc_ust_app_channel() at ust-app.c:882)

DEBUG2 [1203/1207]: Asking UST consumer for channel (in
ask_channel_creation() at ust-consumer.c:118)

DEBUG2 [1203/1207]: UST ask channel 4 successfully done with 1 stream(s)
(in ask_channel_creation() at ust-consumer.c:195)

DEBUG2 [1203/1207]: Consumer setup metadata channel key 4 (in
consumer_setup_metadata() at consumer.c:1205)

DEBUG2 [1203/1207]: UST metadata with key 4 created for app pid 1250 (in
create_ust_app_metadata() at ust-app.c:2800)

DEBUG3 [1203/1207]: UST app deleting channel metadata (in
delete_ust_app_channel() at ust-app.c:374)

DEBUG3 [1203/1207]: Buffer registry per PID find id: 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1207]: UST registry channel finding key 4 (in
ust_registry_channel_find() at ust-registry.c:489)

DEBUG3 [1203/1210]: UST app receiving notify from sock 34 (in
ust_app_recv_notify() at ust-app.c:4730)

DEBUG2 [1203/1210]: UST app ustctl register event received (in
ust_app_recv_notify() at ust-app.c:4750)

DEBUG3 [1203/1210]: Buffer registry per PID find id: 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1210]: UST registry channel finding key 3 (in
ust_registry_channel_find() at ust-registry.c:489)

DEBUG3 [1203/1210]: UST registry creating event with event:
ust_baddr_statedump:soinfo, sig: struct lttng_session *, session, void *,
baddr, const char*, sopath, int64_t, size, int64_t, mtime, id: 0,
chan_objd: 2, sess_objd: 1, chan_id: 0 (in ust_registry_create_event() at
ust-registry.c:298)

DEBUG3 [1203/1210]: Append to metadata: "event {

        name = "ust_baddr_statedump:soinfo";

        id = 0;

        stream_id = 0;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       loglevel = 13;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       fields := struct {

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
64; align = 8; signed = 0; encoding = none; base = 16; } _baddr;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               string _sopath;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
64; align = 8; signed = 1; encoding = none; base = 10; } _size;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
64; align = 8; signed = 1; encoding = none; base = 10; } _mtime;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       };

};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: UST registry event ust_baddr_statedump:soinfo with id 0
added successfully (in add_event_ust_registry() at ust-app.c:4711)

DEBUG3 [1203/1210]: [ust-thread] Manage notify polling on 3 fds (in
ust_thread_manage_notify() at ust-thread.c:68)

DEBUG3 [1203/1210]: UST app receiving notify from sock 34 (in
ust_app_recv_notify() at ust-app.c:4730)

DEBUG2 [1203/1210]: UST app ustctl register channel received (in
ust_app_recv_notify() at ust-app.c:4783)

DEBUG3 [1203/1210]: Buffer registry per PID find id: 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1210]: UST registry channel finding key 3 (in
ust_registry_channel_find() at ust-registry.c:489)

DEBUG3 [1203/1210]: Append to metadata: "stream {

        id = 0;

        event.header := struct event_header_compact;

        packet.context := struct packet_context;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: UST app replying to register channel key 3 with id 0,
type: 1, ret: 0 (in reply_ust_register_channel() at ust-app.c:4596)

DEBUG3 [1203/1210]: [ust-thread] Manage notify polling on 3 fds (in
ust_thread_manage_notify() at ust-thread.c:68)

DEBUG2 [1203/1207]: UST trace started for app pid 1250 (in
ust_app_global_update() at ust-app.c:4247)

DEBUG3 [1203/1210]: UST app receiving notify from sock 34 (in
ust_app_recv_notify() at ust-app.c:4730)

DEBUG2 [1203/1210]: UST app ustctl register event received (in
ust_app_recv_notify() at ust-app.c:4750)

DEBUG3 [1203/1210]: Buffer registry per PID find id: 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1210]: UST registry channel finding key 3 (in
ust_registry_channel_find() at ust-registry.c:489)

DEBUG3 [1203/1210]: UST registry creating event with event:
example_provider:trace_test_tp_id1, sig: const char *, text, id: 0,
chan_objd: 2, sess_objd: 1, chan_id: 0 (in ust_registry_create_event() at
ust-registry.c:298)

DEBUG3 [1203/1210]: Append to metadata: "event {

        name = "example_provider:trace_test_tp_id1";

        id = 1;

        stream_id = 0;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       loglevel = 4;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       fields := struct {

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               string _message;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       };

};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: UST registry event example_provider:trace_test_tp_id1
with id 1 added successfully (in add_event_ust_registry() at ust-app.c:4711)

DEBUG3 [1203/1210]: [ust-thread] Manage notify polling on 3 fds (in
ust_thread_manage_notify() at ust-thread.c:68)

DEBUG3 [1203/1210]: UST app receiving notify from sock 34 (in
ust_app_recv_notify() at ust-app.c:4730)

DEBUG2 [1203/1210]: UST app ustctl register event received (in
ust_app_recv_notify() at ust-app.c:4750)

DEBUG3 [1203/1210]: Buffer registry per PID find id: 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1210]: UST registry channel finding key 3 (in
ust_registry_channel_find() at ust-registry.c:489)

DEBUG3 [1203/1210]: UST registry creating event with event:
example_provider:trace_test_tp_id2, sig: int, anint, int, netint, long *,
values, char *, text, size_t, textlen, double, doublearg, float, floatarg,
id: 0, chan_objd: 2, sess_objd: 1, chan_id: 0 (in
ust_registry_create_event() at ust-registry.c:298)

DEBUG3 [1203/1210]: Append to metadata: "event {

        name = "example_provider:trace_test_tp_id2";

        id = 2;

        stream_id = 0;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       loglevel = 3;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       fields := struct {

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
32; align = 8; signed = 1; encoding = none; base = 10; } _intfield;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
32; align = 8; signed = 1; encoding = none; base = 16; } _intfield2;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
64; align = 8; signed = 1; encoding = none; base = 10; } _longfield;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
32; align = 8; signed = 1; encoding = none; base = 10; byte_order = be; }
_netintfield;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
32; align = 8; signed = 1; encoding = none; base = 16; byte_order = be; }
_netintfieldhex;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
64; align = 8; signed = 1; encoding = none; base = 10; } _arrfield1[3];

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size = 8;
align = 8; signed = 1; encoding = UTF8; base = 10; } _arrfield2[10];

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
64; align = 8; signed = 0; encoding = none; base = 10; } __seqfield1_length;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size = 8;
align = 8; signed = 1; encoding = none; base = 10; } _seqfield1[
__seqfield1_length ];

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size =
64; align = 8; signed = 0; encoding = none; base = 10; } __seqfield2_length;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               integer { size = 8;
align = 8; signed = 1; encoding = UTF8; base = 10; } _seqfield2[
__seqfield2_length ];

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               string _stringfield;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               floating_point {
exp_dig = 8; mant_dig = 24; align = 8; } _floatfield;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "               floating_point {
exp_dig = 11; mant_dig = 53; align = 8; } _doublefield;

" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: Append to metadata: "       };

};



" (in lttng_metadata_printf() at ust-metadata.c:151)

DEBUG3 [1203/1210]: UST registry event example_provider:trace_test_tp_id2
with id 2 added successfully (in add_event_ust_registry() at ust-app.c:4711)

DEBUG3 [1203/1210]: [ust-thread] Manage notify polling on 3 fds (in
ust_thread_manage_notify() at ust-thread.c:68)

DEBUG1 [1203/1215]: Metadata request received for session 0, key 4 (in
ust_consumer_metadata_request() at ust-consumer.c:461)

DEBUG3 [1203/1215]: Buffer registry per UID find id: 0, ABI: 64, uid: 0 (in
buffer_reg_uid_find() at buffer-registry.c:195)

DEBUG3 [1203/1215]: Buffer registry per PID find id: 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG2 [1203/1215]: Consumer push metadata to consumer socket 29 (in
consumer_push_metadata() at consumer.c:1239)

DEBUG3 [1203/1215]: Consumer pushing metadata on sock 29 of len 4253 (in
consumer_push_metadata() at consumer.c:1254)

DEBUG1 [1203/1215]: UST Consumer metadata pushed successfully (in
ust_consumer_metadata_request() at ust-consumer.c:496)

DEBUG1 [1203/1207]: Woken up but nothing in the UST command queue (in
thread_dispatch_ust_registration() at main.c:1600)

DEBUG1 [1203/1209]: Apps with sock 25 added to poll set (in
thread_manage_apps() at main.c:1382)

DEBUG1 [1203/1209]: Apps thread polling on 3 fds (in thread_manage_apps()
at main.c:1321)

DEBUG1 [1203/1215]: Metadata request received for session 0, key 4 (in
ust_consumer_metadata_request() at ust-consumer.c:461)

DEBUG3 [1203/1215]: Buffer registry per UID find id: 0, ABI: 64, uid: 0 (in
buffer_reg_uid_find() at buffer-registry.c:195)

DEBUG3 [1203/1215]: Buffer registry per PID find id: 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1215]: No metadata to push for metadata key 4 (in
ust_app_push_metadata() at ust-app.c:460)

DEBUG1 [1203/1215]: No metadata to push (in ust_app_push_metadata() at
ust-app.c:463)

DEBUG2 [1203/1215]: Consumer push metadata to consumer socket 29 (in
consumer_push_metadata() at consumer.c:1239)

DEBUG1 [1203/1215]: UST Consumer metadata pushed successfully (in
ust_consumer_metadata_request() at ust-consumer.c:496)

mysystem # DEBUG1 [1203/1209]: PID 1250 unregistering with sock 25 (in
ust_app_unregister() at ust-app.c:2987)

DEBUG3 [1203/1209]: Buffer registry per PID find id: 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1209]: No metadata to push for metadata key 4 (in
ust_app_push_metadata() at ust-app.c:460)

DEBUG2 [1203/1209]: Consumer close metadata channel key 4 (in
consumer_close_metadata() at consumer.c:1172)

DEBUG1 [1203/1210]: UST app notify socket unregister 34 (in
ust_app_notify_sock_unregister() at ust-app.c:4857)

DEBUG2 [1203/1210]: UST app find by notify sock 34 not found (in
find_app_by_notify_sock() at ust-app.c:1029)

DEBUG3 [1203/1210]: [ust-thread] Manage notify polling on 2 fds (in
ust_thread_manage_notify() at ust-thread.c:68)

DEBUG1 [1203/1209]: Apps thread polling on 2 fds (in thread_manage_apps()
at main.c:1321)

DEBUG3 [1203/1244]: Call RCU deleting app PID 1250 (in delete_ust_app_rcu()
at ust-app.c:780)

DEBUG3 [1203/1244]: Buffer registry per PID find id: 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1244]: UST app deleting channel mychannel (in
delete_ust_app_channel() at ust-app.c:374)

DEBUG3 [1203/1244]: Buffer registry per PID find id: 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1244]: UST registry channel finding key 3 (in
ust_registry_channel_find() at ust-registry.c:489)

DEBUG3 [1203/1244]: Buffer registry per PID find id: 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)

DEBUG3 [1203/1244]: Buffer registry per PID destroy with id: 2 (in
buffer_reg_pid_destroy() at buffer-registry.c:686)

DEBUG2 [1203/1244]: UST app pid 1250 deleted (in delete_ust_app() at
ust-app.c:765)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1244]: Buffer registry session destroy (in
buffer_reg_session_destroy() at buffer-registry.c:543)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)

DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup()
at ht-cleanup.c:64)



mysystem #

mysystem # babeltrace /home/root/lttng-traces/

[10:13:42.880173965] (+?.?????????) mysystem_node:logtrace_test64:1250
example_provider:trace_test_tp_id1: { cpu_id = 1 }, { message = "testing
evo trace..start" }

[10:13:42.880181626] (+0.000007661) mysystem_node:logtrace_test64:1250
example_provider:trace_test_tp_id2: { cpu_id = 1 }, { intfield = 0,
intfield2 = 0x0, longfield = 0, netintfield = 0, netintfieldhex = 0x0,
arrfield1 = [ [0] = 1, [1] = 2, [2] = 3 ], arrfield2 = "test",
_seqfield1_length = 4, seqfield1 = [ [0] = 116, [1] = 101, [2] = 115, [3] =
116 ], _seqfield2_length = 4, seqfield2 = "test", stringfield = "test",
floatfield = 2222.2, doublefield = 2 }

[10:13:42.880182470] (+0.000000844) mysystem_node:logtrace_test64:1250
example_provider:trace_test_tp_id2: { cpu_id = 1 }, { intfield = 1,
intfield2 = 0x1, longfield = 1, netintfield = 1, netintfieldhex = 0x1,
arrfield1 = [ [0] = 1, [1] = 2, [2] = 3 ], arrfield2 = "test",
_seqfield1_length = 4, seqfield1 = [ [0] = 116, [1] = 101, [2] = 115, [3] =
116 ], _seqfield2_length = 4, seqfield2 = "test", stringfield = "test",
floatfield = 2222.2, doublefield = 2 }

[10:13:42.880183000] (+0.000000530) mysystem_node:logtrace_test64:1250
example_provider:trace_test_tp_id2: { cpu_id = 1 }, { intfield = 2,
intfield2 = 0x2, longfield = 2, netintfield = 2, netintfieldhex = 0x2,
arrfield1 = [ [0] = 1, [1] = 2, [2] = 3 ], arrfield2 = "test",
_seqfield1_length = 4, seqfield1 = [ [0] = 116, [1] = 101, [2] = 115, [3] =
116 ], _seqfield2_length = 4, seqfield2 = "test", stringfield = "test",
floatfield = 2222.2, doublefield = 2 }

[10:13:42.880183588] (+0.000000588) mysystem_node:logtrace_test64:1250
example_provider:trace_test_tp_id1: { cpu_id = 1 }, { message = "testing
evo trace..end" }

mysystem #





On Tue, Oct 7, 2014 at 12:12 AM, Anand Neeli <anand.neeli@gmail.com> wrote:

> Hi All,
>
> I have a query running 32-bit and 64-bit apps.
> i'm starting lttng with following steps
>
> lttng-relayd -d
>
> lttng-sessiond --consumerd32-path /usr/lib/lttng/libexec/lttng-consumerd
> --consumerd32-libdir /usr/lib/ --consumerd64-path
> /usr/lib64/lttng/libexec/lttng-consumerd --consumerd64-libdir /usr/lib64/
> -b --no-kernel
>
> lttng -no-sessiond create mysession --live 200000 -U net://localhost
>
> lttng enable-channel mychannel --userspace --buffers-pid -s mysession
> --tracefile-size 8388608 --tracefile-count 8
>
> lttng  enable-event --channel mychannel --userspace --all -s mysession
>
>  lttng start
>
>
> My Queries:
> 1) Does this spawn consumerd for 32-bit and 64-bit separately?
>
> 2) i see that 2 consumerd process are launched. and the 64-bit one looks
> to be correct.
> root       975  0.0  0.0 404480   956 ?        Sl   11:01   0:00
> lttng-consumerd --quiet -u --consumerd-cmd-sock
> /var/run/lttng/ustconsumerd64/command --consumerd-err-sock
> /var/run/lttng/ustconsumerd64/error --group tracing
> root       983  0.0  0.0      0     0 ?        Z    11:01   0:00
> [lttng-consumerd] <defunct>
>
> 3) What libraries are required by sessiond to launch consumerd. So that i
> can copy only those libraries on to the target.
>
> 4) is there a way to launch sessiond so that it automatically consumes
> data from 32-bit and 64-bit apps.
>
>
> Thanks in advance,
> Anand Neeli
>
>
>
>
>
>

--001a11c24c4438f3e80504d8badb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>To add more details to my query.</div><div>I want =
to trace both 32-bit and 64-bit apps.</div><div>For this i launched session=
d with 32 and 64 bit paramaters of consumerd. (shown below)</div><div><br><=
/div><div>i see that 64-bit app&#39;s are able to log whereas 32-bit app&#3=
9;s are not logging.</div><div><br></div><div>Below is the output with -vvv=
, can anyone help me to find the problem here.</div><div><br><br></div><div=
><br></div><div><p class=3D"MsoNormal">mysystem=C2=A0<span style=3D"font-fa=
mily:Helvetica">=C2=A0=C2=A0# find /usr/lib/ -name &quot;*lttng*&quot;</spa=
n></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-cyg-profile-fast.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-pthread-wrapper.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-pthread-wrapper.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-dl.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-fork.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-ctl.so.2.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-tracepoint.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-cyg-profile.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-fork.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-ctl.so.2</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-libc-wrapper.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-cyg-profile.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-cyg-profile-fast.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-dl.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-libc-wrapper.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ust-tracepoint.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ctl.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/liblt=
tng-ctl.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/lttng=
</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib/lttng=
/libexec/lttng-consumerd</span></p>

<p class=3D"MsoNormal"><br></p>

<p class=3D"MsoNormal">mysystem=C2=A0<span style=3D"font-family:Helvetica">=
=C2=A0=C2=A0# find /usr/lib64/ -name &quot;*lttng*&quot;</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-cyg-profile-fast.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-pthread-wrapper.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
babeltrace-lttng-live.so.1.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-pthread-wrapper.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
babeltrace-lttng-live.so.1</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-dl.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-fork.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-ctl.so.2.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-tracepoint.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-cyg-profile.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-fork.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-ctl.so.2</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ctl.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ctl.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-libc-wrapper.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-cyg-profile.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-cyg-profile-fast.so.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-dl.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/ltt=
ng</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/ltt=
ng/libexec/lttng-consumerd</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-libc-wrapper.so.0.0.0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">/usr/lib64/lib=
lttng-ust-tracepoint.so.0.0.0</span></p>

<p class=3D"MsoNormal">mysystem=C2=A0<span style=3D"font-family:Helvetica">=
=C2=A0# </span></p>

<p class=3D"MsoNormal"><span style=3D"font-family:Helvetica">=C2=A0</span><=
/p>

<p class=3D"MsoNormal">=C2=A0</p><p class=3D"MsoNormal"><br></p><div><br></=
div><div><br></div>


















<p class=3D"MsoNormal">mysystem # lttng-relayd -d</p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # lttng-sessiond --consumerd32-path
/usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/
--consumerd64-path /usr/lib64/lttng/libexec/lttng-consumerd
--consumerd64-libdir /usr/lib64/ -b --no-kernel -vvv</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1203]: Creating LTTng run directory:
/var/run/lttng (in create_lttng_rundir() at main.c:4301)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1203]: Kernel consumer err path:
/var/run/lttng/kconsumerd/error (in main() at main.c:4642)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1203]: Kernel consumer cmd path:
/var/run/lttng/kconsumerd/command (in main() at main.c:4644)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1203]: Client socket path
/var/run/lttng/client-lttng-sessiond (in main() at main.c:4697)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1203]: Application socket path
/var/run/lttng/lttng-ust-sock-5 (in main() at main.c:4698)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1203]: Application wait path /lttng-ust=
-wait-5
(in main() at main.c:4699)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1203]: LTTng run directory path: /var/r=
un/lttng
(in main() at main.c:4700)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1203]: UST consumer 32 bits err path:
/var/run/lttng/ustconsumerd32/error (in main() at main.c:4709)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1203]: UST consumer 32 bits cmd path:
/var/run/lttng/ustconsumerd32/command (in main() at main.c:4711)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1203]: UST consumer 64 bits err path:
/var/run/lttng/ustconsumerd64/error (in main() at main.c:4720)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1203]: UST consumer 64 bits cmd path:
/var/run/lttng/ustconsumerd64/command (in main() at main.c:4722)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1203]: Created hashtable size 4 at 0x66=
70a0 of
type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1203]: Created hashtable size 4 at 0x66=
74c0 of
type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1203]: Created hashtable size 4 at 0x66=
7900 of
type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1203]: Created hashtable size 4 at 0x66=
7d40 of
type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1203]: Creating consumer directory:
/var/run/lttng/kconsumerd (in set_consumer_sockets() at main.c:4343)</p>

<p class=3D"MsoNormal">Warning: No tracing group detected</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1203]: Creating consumer directory:
/var/run/lttng/ustconsumerd64 (in set_consumer_sockets() at main.c:4343)</p=
>

<p class=3D"MsoNormal">DEBUG2 [1203/1203]: Creating consumer directory:
/var/run/lttng/ustconsumerd32 (in set_consumer_sockets() at main.c:4343)</p=
>

<p class=3D"MsoNormal">DEBUG3 [1203/1203]: Session daemon client socket 8 a=
nd
application socket 9 created (in init_daemon_socket() at main.c:4209)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1203]: All permissions are set (in
set_permissions() at main.c:4289)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1203]: Created hashtable size 4 at 0x66=
a180 of
type 2 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1203]: Global buffer per UID registry
initialized (in buffer_reg_init_uid_registry() at buffer-registry.c:99)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1203]: Created hashtable size 4 at 0x66=
a5c0 of
type 2 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1203]: Global buffer per PID registry
initialized (in buffer_reg_init_pid_registry() at buffer-registry.c:220)</p=
>

<p class=3D"MsoNormal">DEBUG1 [1203/1203]: epoll set max size is 825774 (in
compat_epoll_set_max_size() at compat-epoll.c:290)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1203]: Command subsystem initialized (i=
n
cmd_init() at cmd.c:3126)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1203]: Pid 1203 written in file
/var/run/lttng/lttng-sessiond.pid (in utils_create_pid_file() at utils.c:46=
5)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1203]: Pid 5345 written in file
/var/run/lttng/jul.port (in utils_create_pid_file() at utils.c:465)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1203]: TCP inet operation timeout set t=
o 216
sec (in lttcomm_inet_init() at inet.c:529)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1203]: Health check time delta in secon=
ds set
to 236 (in health_init() at health.c:73)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1204]: [ht-thread] startup. (in
thread_ht_cleanup() at ht-cleanup.c:36)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: [thread] Manage client started (=
in
thread_manage_clients() at main.c:3735)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1205]: [thread] Manage health check sta=
rted (in
thread_manage_health() at main.c:3549)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: [thread] Dispatch UST command st=
arted
(in thread_dispatch_ust_registration() at main.c:1577)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: [thread] Manage application regi=
stration
started (in thread_registration_apps() at main.c:1801)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Futex n to 1 prepare done (in
futex_nto1_prepare() at futex.c:75)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Woken up but nothing in the UST =
command
queue (in thread_dispatch_ust_registration() at main.c:1600)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1209]: [thread] Manage application star=
ted (in
thread_manage_apps() at main.c:1291)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: Notifying applications of sessio=
n daemon
state: 1 (in notify_ust_apps() at main.c:628)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1210]: [ust-thread] Manage application =
notify
command (in ust_thread_manage_notify() at ust-thread.c:39)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: [ust-thread] Manage notify polli=
ng on 2
fds (in ust_thread_manage_notify() at ust-thread.c:68)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1211]: [jul-thread] Manage JUL applicat=
ion
registration. (in jul_thread_manage_registration() at jul-thread.c:258)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: Got the wait shm fd 19 (in
get_wait_shm() at shm.c:115)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1211]: URI string: tcp://localhost (in
uri_parse() at uri.c:291)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: Futex wait update active 1 (in
futex_wait_update() at futex.c:63)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: Accepting application registrati=
on (in
thread_registration_apps() at main.c:1838)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1209]: Apps thread polling on 2 fds (in=
 thread_manage_apps()
at main.c:1321)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1205]: Health check ready (in
thread_manage_health() at main.c:3614)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1211]: IP address resolved to 127.0.0.1=
 (in
set_ip_address() at uri.c:132)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1211]: URI dtype: 1, proto: 1, host: lo=
calhost,
subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:505)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1211]: [jul-thread] Listening on TCP po=
rt 5345
and socket 19 (in init_tcp_socket() at jul-thread.c:156)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1211]: [jul-thread] Manage JUL polling =
on 2 fds
(in jul_thread_manage_registration() at jul-thread.c:286)</p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # lttng=C2=A0
--no-sessiond create mysession --live 200000 -U net://localhost</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Wait for client response (in
thread_manage_clients() at main.c:3819)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Receiving data from client ... (=
in
thread_manage_clients() at main.c:3864)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Processing client command 30 (in
process_client_msg() at main.c:2637)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Waiting for 2 URIs from client .=
.. (in
process_client_msg() at main.c:3490)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Trying to find session by name m=
ysession
(in session_find_by_name() at session.c:169)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Created hashtable size 4 at
0x7f2e9c007ef0 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Tracing session mysession create=
d with
ID 0 by UID 0 GID 0 (in session_create() at session.c:276)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Trying to find session by name m=
ysession
(in session_find_by_name() at session.c:169)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Created hashtable size 4 at
0x7f2e9c00d390 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Setting network URI to consumer =
(in
add_uri_to_consumer() at cmd.c:435)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Consumer control URI set with po=
rt 5342
(in consumer_set_network_uri() at consumer.c:641)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Consumer set network uri subdir =
path
mysystem_node/ (in consumer_set_network_uri() at consumer.c:701)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Consumer subdir set to
mysystem_node//mysession-20141007-101236/ (in consumer_set_subdir() at cons=
umer.c:1059)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Append domain trace name to subd=
ir
mysystem_node//mysession-20141007-101236/ (in add_uri_to_consumer() at
cmd.c:477)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Setting network URI to consumer =
(in
add_uri_to_consumer() at cmd.c:435)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Consumer data URI set with port =
5343 (in
consumer_set_network_uri() at consumer.c:656)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Sending response (size: 16, retc=
ode:
Success) (in thread_manage_clients() at main.c:3913)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Clean command context structure =
(in clean_command_ctx()
at main.c:608)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)</p>

<p class=3D"MsoNormal">Session mysession created.</p>

<p class=3D"MsoNormal">Traces will be written in net://localhost</p>

<p class=3D"MsoNormal">Live timer set to 200000 usec</p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem #=C2=A0 lttng
enable-channel mychannel --userspace --buffers-pid -s mysession
--tracefile-size 8388608 --tracefile-count 8</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Wait for client response (in
thread_manage_clients() at main.c:3819)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Receiving data from client ... (=
in
thread_manage_clients() at main.c:3864)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Nothing recv() from client... co=
ntinuing
(in thread_manage_clients() at main.c:3868)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Clean command context structure =
(in
clean_command_ctx() at main.c:608)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Wait for client response (in
thread_manage_clients() at main.c:3819)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Receiving data from client ... (=
in
thread_manage_clients() at main.c:3864)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Processing client command 5 (in
process_client_msg() at main.c:2637)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Getting session mysession by nam=
e (in
process_client_msg() at main.c:2716)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Trying to find session by name m=
ysession
(in session_find_by_name() at session.c:169)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Creating UST session (in
create_ust_session() at main.c:2517)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Created hashtable size 4 at
0x7f2e9c003e90 of type 0 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Created hashtable size 4 at
0x7f2e9c0042d0 of type 0 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Created hashtable size 4 at
0x7f2e9c0046f0 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: UST trace session create success=
ful (in
trace_ust_create_session() at trace-ust.c:263)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Copying tracing session consumer=
 output
in UST session (in copy_session_consumer() at main.c:2466)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Created hashtable size 4 at
0x7f2e9c004b10 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Copy session consumer subdir
mysystem_node//mysession-20141007-101236//ust (in copy_session_consumer() a=
t
main.c:2484)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Spawning consumerd (in spawn_con=
sumerd()
at main.c:2158)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Consumer pid 1214 (in start_cons=
umerd()
at main.c:2340)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Spawning consumer control thread=
 (in
start_consumerd() at main.c:2343)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG1 [1214/1214]: Using 64-bit UST consumer at:
/usr/lib64/lttng/libexec/lttng-consumerd (in spawn_consumerd() at main.c:22=
35)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1215]: [thread] Manage consumer started=
 (in
thread_manage_consumer() at main.c:994)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1215]: Receiving code from consumer err=
_sock
(in thread_manage_consumer() at main.c:1079)</p>

<p class=3D"MsoNormal">Warning: No tracing group detected</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1215]: Consumer command socket ready (f=
d: 28
(in thread_manage_consumer() at main.c:1113)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1215]: Consumer metadata socket ready (=
fd: 29)
(in thread_manage_consumer() at main.c:1115)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Consumer socket created (fd: 28)=
 and
added to output (in consumer_create_socket() at consumer.c:301)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Spawning consumerd (in spawn_con=
sumerd()
at main.c:2158)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Consumer pid 1222 (in start_cons=
umerd()
at main.c:2340)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Spawning consumer control thread=
 (in
start_consumerd() at main.c:2343)</p>

<p class=3D"MsoNormal">DEBUG1 [1222/1222]: Using 32-bit UST consumer at:
/usr/lib/lttng/libexec/lttng-consumerd (in spawn_consumerd() at main.c:2278=
)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1223]: [thread] Manage consumer started=
 (in
thread_manage_consumer() at main.c:994)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1223]: Receiving code from consumer err=
_sock
(in thread_manage_consumer() at main.c:1079)</p>

<p class=3D"MsoNormal">Warning: No tracing group detected</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1223]: Consumer command socket ready (f=
d: 32
(in thread_manage_consumer() at main.c:1113)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1223]: Consumer metadata socket ready (=
fd: 33)
(in thread_manage_consumer() at main.c:1115)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Consumer socket created (fd: 32)=
 and
added to output (in consumer_create_socket() at consumer.c:301)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Setting relayd for session myses=
sion (in
cmd_setup_relayd() at cmd.c:723)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd connect ... (in relayd_co=
nnect()
at relayd.c:470)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Creating relayd stream socket fr=
om URI
(in create_connect_relayd() at cmd.c:568)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Relayd version check for major.m=
inor 2.4
(in relayd_version_check() at relayd.c:368)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd sending command 5 of size=
 32 (in
send_command() at relayd.c:80)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd waiting for reply of size=
 8 (in
recv_reply() at relayd.c:100)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Relayd version is compatible, us=
ing
protocol version 2.4 (in relayd_version_check() at relayd.c:416)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Relayd create session (in
relayd_create_session() at relayd.c:181)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd sending command 2 of size=
 351 (in
send_command() at relayd.c:80)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd waiting for reply of size=
 12 (in
recv_reply() at relayd.c:100)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Relayd session created with id 1=
 (in
relayd_create_session() at relayd.c:219)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Sending relayd sock info to cons=
umer on
32 (in consumer_send_relayd_socket() at consumer.c:999)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Sending relayd socket file descr=
iptor to
consumer (in consumer_send_relayd_socket() at consumer.c:1005)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Consumer relayd socket sent (in
consumer_send_relayd_socket() at consumer.c:1011)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd closing socket 34 (in
relayd_close() at relayd.c:501)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd connect ... (in relayd_co=
nnect()
at relayd.c:470)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Creating relayd data socket from=
 URI (in
create_connect_relayd() at cmd.c:577)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Sending relayd sock info to cons=
umer on
32 (in consumer_send_relayd_socket() at consumer.c:999)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Sending relayd socket file descr=
iptor to
consumer (in consumer_send_relayd_socket() at consumer.c:1005)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Consumer relayd socket sent (in
consumer_send_relayd_socket() at consumer.c:1011)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd closing socket 34 (in
relayd_close() at relayd.c:501)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd connect ... (in relayd_co=
nnect()
at relayd.c:470)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Creating relayd stream socket fr=
om URI
(in create_connect_relayd() at cmd.c:568)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Relayd version check for major.m=
inor 2.4
(in relayd_version_check() at relayd.c:368)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd sending command 5 of size=
 32 (in
send_command() at relayd.c:80)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd waiting for reply of size=
 8 (in
recv_reply() at relayd.c:100)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Relayd version is compatible, us=
ing
protocol version 2.4 (in relayd_version_check() at relayd.c:416)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Relayd create session (in
relayd_create_session() at relayd.c:181)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd sending command 2 of size=
 351 (in
send_command() at relayd.c:80)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd waiting for reply of size=
 12 (in
recv_reply() at relayd.c:100)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Relayd session created with id 2=
 (in
relayd_create_session() at relayd.c:219)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Sending relayd sock info to cons=
umer on
28 (in consumer_send_relayd_socket() at consumer.c:999)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Sending relayd socket file descr=
iptor to
consumer (in consumer_send_relayd_socket() at consumer.c:1005)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Consumer relayd socket sent (in
consumer_send_relayd_socket() at consumer.c:1011)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd closing socket 34 (in
relayd_close() at relayd.c:501)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd connect ... (in relayd_co=
nnect()
at relayd.c:470)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Creating relayd data socket from=
 URI (in
create_connect_relayd() at cmd.c:577)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Sending relayd sock info to cons=
umer on
28 (in consumer_send_relayd_socket() at consumer.c:999)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Sending relayd socket file descr=
iptor to
consumer (in consumer_send_relayd_socket() at consumer.c:1005)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Consumer relayd socket sent (in
consumer_send_relayd_socket() at consumer.c:1011)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Relayd closing socket 34 (in
relayd_close() at relayd.c:501)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Enabling channel mychannel for s=
ession
mysession (in cmd_enable_channel() at cmd.c:911)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Trace UST channel mychannel not =
found by
name (in trace_ust_find_channel_by_name() at trace-ust.c:162)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Created hashtable size 4 at
0x7f2e9c005350 of type 0 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Created hashtable size 4 at
0x7f2e9c005720 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Trace UST channel mychannel crea=
ted (in
trace_ust_create_channel() at trace-ust.c:331)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Channel mychannel is being creat=
ed for
UST with buffer 0 and id 0 (in channel_ust_create() at channel.c:348)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: UST app adding channel mychannel=
 to UST
domain for session id 0 (in ust_app_create_channel_glb() at ust-app.c:3536)=
</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Channel mychannel created succes=
sfully
(in channel_ust_create() at channel.c:383)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Sending response (size: 16, retc=
ode:
Success) (in thread_manage_clients() at main.c:3913)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Clean command context structure =
(in
clean_command_ctx() at main.c:608)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)</p>

<p class=3D"MsoNormal">UST channel mychannel enabled for session mysession<=
/p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # lttng enable-event --channel mychannel
--userspace --all -s mysession</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Wait for client response (in
thread_manage_clients() at main.c:3819)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Receiving data from client ... (=
in
thread_manage_clients() at main.c:3864)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Nothing recv() from client... co=
ntinuing
(in thread_manage_clients() at main.c:3868)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Clean command context structure =
(in
clean_command_ctx() at main.c:608)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Wait for client response (in
thread_manage_clients() at main.c:3819)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Receiving data from client ... (=
in
thread_manage_clients() at main.c:3864)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Processing client command 6 (in
process_client_msg() at main.c:2637)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Getting session mysession by nam=
e (in
process_client_msg() at main.c:2716)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Trying to find session by name m=
ysession
(in session_find_by_name() at session.c:169)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Consumer socket created (fd: 28)=
 and
added to output (in consumer_create_socket() at consumer.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1206]: Consumer socket created (fd: 32)=
 and
added to output (in consumer_create_socket() at consumer.c:301)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Setting relayd for session myses=
sion (in
cmd_setup_relayd() at cmd.c:723)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Trace UST channel mychannel foun=
d by
name (in trace_ust_find_channel_by_name() at trace-ust.c:157)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Trace UST event * NOT found (in =
trace_ust_find_event()
at trace-ust.c:198)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Trace UST event *, loglevel (0,-=
1)
created (in trace_ust_create_event() at trace-ust.c:405)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: UST app creating event * for all=
 apps
for session id 0 (in ust_app_create_event_glb() at ust-app.c:3687)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Event UST * created in channel m=
ychannel
(in event_ust_enable_tracepoint() at event.c:469)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Sending response (size: 16, retc=
ode:
Success) (in thread_manage_clients() at main.c:3913)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Clean command context structure =
(in
clean_command_ctx() at main.c:608)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)</p>

<p class=3D"MsoNormal">All UST events are enabled in channel mychannel</p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # lttng -vvv start</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Wait for client response (in
thread_manage_clients() at main.c:3819)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Receiving data from client ... (=
in
thread_manage_clients() at main.c:3864)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Nothing recv() from client... co=
ntinuing
(in thread_manage_clients() at main.c:3868)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Clean command context structure =
(in
clean_command_ctx() at main.c:608)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)</p>

<p class=3D"MsoNormal">DEBUG2 [1234/1234]: Config file path found: /home/ro=
ot (in
get_session_name() at utils.c:62)</p>

<p class=3D"MsoNormal">DEBUG1 [1234/1234]: Session name found: mysession (i=
n
get_session_name() at utils.c:63)</p>

<p class=3D"MsoNormal">DEBUG1 [1234/1234]: Starting tracing for session mys=
ession
(in start_tracing() at commands/start.c:81)</p>

<p class=3D"MsoNormal">DEBUG1 [1234/1234]: LSM cmd type : 16 (in send_sessi=
on_msg()
at lttng-ctl.c:131)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Wait for client response (in
thread_manage_clients() at main.c:3819)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Receiving data from client ... (=
in
thread_manage_clients() at main.c:3864)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Processing client command 16 (in
process_client_msg() at main.c:2637)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Getting session mysession by nam=
e (in
process_client_msg() at main.c:2716)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1206]: Trying to find session by name m=
ysession
(in session_find_by_name() at session.c:169)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Starting all UST traces (in
ust_app_start_trace_all() at ust-app.c:4034)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Sending response (size: 16, retc=
ode:
Success) (in thread_manage_clients() at main.c:3913)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Clean command context structure =
(in
clean_command_ctx() at main.c:608)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1206]: Accepting client command ... (in
thread_manage_clients() at main.c:3777)</p>

<p class=3D"MsoNormal">Tracing started for session mysession</p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # </p><p class=3D"MsoNormal"><br></p><p cla=
ss=3D"MsoNormal"><br></p><p class=3D"MsoNormal"><br class=3D"">root =C2=A0 =
=C2=A0 =C2=A01194 =C2=A00.0 =C2=A00.0 420760 =C2=A01068 ? =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Ssl =C2=A010:12 =C2=A0 0:00 lttng-relayd -d</p><p class=3D"MsoNor=
mal">root =C2=A0 =C2=A0 =C2=A01203 =C2=A00.0 =C2=A00.0 779704 =C2=A01620 ? =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Ssl =C2=A010:12 =C2=A0 0:00 lttng-sessiond --con=
sumerd32-path /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /=
usr/lib/ --consumerd64-path /usr/lib64/lttng/libexec/lttng-consumerd --cons=
umerd64-libdir /usr/lib64/ -b --no-kernel -vvv</p><p class=3D"MsoNormal">ro=
ot =C2=A0 =C2=A0 =C2=A01214 =C2=A00.0 =C2=A00.0 478212 =C2=A0 948 ? =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Sl =C2=A0 10:12 =C2=A0 0:00 lttng-consumerd --quiet -u =
--consumerd-cmd-sock /var/run/lttng/ustconsumerd64/command --consumerd-err-=
sock /var/run/lttng/ustconsumerd64/error --group tracing</p><p class=3D"Mso=
Normal"></p><p class=3D"MsoNormal"></p><p></p><p class=3D"MsoNormal" style=
=3D"margin:0px;color:rgb(34,34,34);font-family:arial;font-size:small;font-s=
tyle:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;li=
ne-height:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;background-color:rgb(255,255,255)">root =C2=
=A0 =C2=A0 =C2=A01222 =C2=A00.0 =C2=A00.0 =C2=A063072 =C2=A0 772 ? =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Sl =C2=A0 10:12 =C2=A0 0:00 lttng-consumerd --quiet -u =
--consumerd-cmd-sock /var/run/lttng/ustconsumerd32/command --consumerd-err-=
sock /var/run/lttng/ustconsumerd32/error --group tracing</p>

<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal"><br></p><p class=3D"M=
soNormal"><br></p><p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal"><br=
></p><p class=3D"MsoNormal">mysystem # /usr/bin/logtrace_test =C2=A0 =C2=A0=
&lt;&lt;&lt;&lt;&lt;&lt;running a 32-bit app</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: UST registration received with p=
id:1235
ppid:850 uid:0 gid:0 sock:25 name:logtrace_test (version 5.0) (in
thread_registration_apps() at main.c:1946)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:104)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: Accepting application registrati=
on (in
thread_registration_apps() at main.c:1838)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Futex n to 1 wait done (in
futex_nto1_wait() at futex.c:90)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Futex n to 1 prepare done (in
futex_nto1_prepare() at futex.c:75)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Dispatching UST registration pid=
:1235
ppid:850 uid:0 gid:0 sock:25 name:logtrace_test (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1612)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app creating application for=
 socket
25 (in ust_app_create() at ust-app.c:2848)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80000a10 of type 2 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80000e50 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: UST registration received with p=
id:1235
ppid:850 uid:0 gid:0 sock:34 name:logtrace_test (version 5.0) (in
thread_registration_apps() at main.c:1946)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Woken up but nothing in the UST =
command
queue (in thread_dispatch_ust_registration() at main.c:1600)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Futex n to 1 wait done (in
futex_nto1_wait() at futex.c:90)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Futex n to 1 prepare done (in
futex_nto1_prepare() at futex.c:75)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Dispatching UST registration pid=
:1235
ppid:850 uid:0 gid:0 sock:34 name:logtrace_test (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1612)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app notify socket 34 is set =
(in
thread_dispatch_ust_registration() at main.c:1669)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: App registered with pid:1235 ppi=
d:850
uid:0 gid:0 sock:25 name:logtrace_test notify_sock:34 (version 5.0) (in
ust_app_add() at ust-app.c:2936)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: Futex n to 1 wake done (in futex=
_nto1_wake()
at futex.c:104)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: Accepting application registrati=
on (in
thread_registration_apps() at main.c:1838)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app global update for app so=
ck 25
for session id 0 (in ust_app_global_update() at ust-app.c:4173)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app pid: 1235 session id 0 n=
ot
found, creating it (in create_ust_app_session() at ust-app.c:1842)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80002370 of type 0 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: Shadow copy of session handle -1=
 (in
shadow_copy_session() at ust-app.c:1598)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: Channel mychannel not found on s=
hadow
session copy, creating it (in shadow_copy_session() at ust-app.c:1648)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at 0x7f=
2e800029f0
of type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80002e30 of type 0 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app channel mychannel alloca=
ted (in
alloc_ust_app_channel() at ust-app.c:882)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app shadow copy of channel m=
ychannel
started (in shadow_copy_channel() at ust-app.c:1525)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST event * not found on shadow =
copy
channel (in shadow_copy_channel() at ust-app.c:1565)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app event * allocated (in
alloc_ust_app_event() at ust-app.c:938)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app shadow copy of channel m=
ychannel
done (in shadow_copy_channel() at ust-app.c:1575)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Buffer registry per PID find id:=
 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80003660 of type 2 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Buffer registry per PID created =
with
session id: 1 (in buffer_reg_pid_create() at buffer-registry.c:262)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Buffer registry per PID adding t=
o global
registry with id: 1 (in buffer_reg_pid_add() at buffer-registry.c:281)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80003b40 of type 2 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;typeal=
ias
integer { size =3D 8; align =3D 8; signed =3D false; } :=3D uint8_t;</p>

<p class=3D"MsoNormal">typealias integer { size =3D 16; align =3D 8; signed=
 =3D false; }
:=3D uint16_t;</p>

<p class=3D"MsoNormal">typealias integer { size =3D 32; align =3D 8; signed=
 =3D false; }
:=3D uint32_t;</p>

<p class=3D"MsoNormal">typealias integer { size =3D 64; align =3D 8; signed=
 =3D false; }
:=3D uint64_t;</p>

<p class=3D"MsoNormal">typealias integer { size =3D 32; align =3D 8; signed=
 =3D false; }
:=3D unsigned long;</p>

<p class=3D"MsoNormal">typealias integer { size =3D 5; align =3D 1; signed =
=3D false; }
:=3D uint5_t;</p>

<p class=3D"MsoNormal">typealias integer { size =3D 27; align =3D 1; signed=
 =3D false; }
:=3D uint27_t;</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">trace {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 major =3D=
 1;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minor =3D=
 8;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uuid =3D
&quot;41ae6e13-c919-43b6-a5a8-76194517882b&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 byte_orde=
r =3D
le;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet.he=
ader
:=3D struct {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
uint32_t magic;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
uint8_t=C2=A0 uuid[16];</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
uint32_t stream_id;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };</p>

<p class=3D"MsoNormal">};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST thread notify added sock 34 =
to
pollset (in ust_thread_manage_notify() at ust-thread.c:137)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: [ust-thread] Manage notify polli=
ng on 3
fds (in ust_thread_manage_notify() at ust-thread.c:68)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;env {<=
/p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0hostname =
=3D &quot;mysystem_node&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 domain =
=3D
&quot;ust&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracer_na=
me =3D
&quot;lttng-ust&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracer_ma=
jor =3D
2;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracer_mi=
nor =3D
4;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracer_patchlevel =3D 1;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vpid =3D =
1235;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 procname =
=3D
&quot;logtrace_test&quot;;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;clock =
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D
monotonic;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uuid =3D
&quot;b1019e3b-fafd-4c41-bebc-c476fa343570&quot;;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description =3D &quot;Monotonic
Clock&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 freq =3D
1000000000; /* Frequency, in Hz */</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* clock =
value
offset from Epoch is: offset * (1/freq) */</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =
=3D
1412699639502362921;</p>

<p class=3D"MsoNormal">};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;typeal=
ias
integer {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D =
27;
align =3D 1; signed =3D false;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map =3D
clock.monotonic.value;</p>

<p class=3D"MsoNormal">} :=3D uint27_clock_monotonic_t;</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">typealias integer {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D =
32;
align =3D 8; signed =3D false;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map =3D
clock.monotonic.value;</p>

<p class=3D"MsoNormal">} :=3D uint32_clock_monotonic_t;</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">typealias integer {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D =
64;
align =3D 8; signed =3D false;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map =3D
clock.monotonic.value;</p>

<p class=3D"MsoNormal">} :=3D uint64_clock_monotonic_t;</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;struct
packet_context {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
uint64_clock_monotonic_t timestamp_begin;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
uint64_clock_monotonic_t timestamp_end;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t
content_size;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t
packet_size;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned =
long
events_discarded;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t
cpu_id;</p>

<p class=3D"MsoNormal">};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;struct
event_header_compact {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum : ui=
nt5_t
{ compact =3D 0 ... 30, extended =3D 31 } id;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variant
&lt;id&gt; {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
uint27_clock_monotonic_t timestamp;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
compact;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
uint32_t id;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0uint64_clock_monotonic_t
timestamp;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
extended;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } v;</p>

<p class=3D"MsoNormal">} align(8);</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">struct event_header_large {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum :
uint16_t { compact =3D 0 ... 65534, extended =3D 65535 } id;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variant
&lt;id&gt; {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
uint32_clock_monotonic_t timestamp;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
compact;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
uint32_t id;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
uint64_clock_monotonic_t timestamp;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } extended;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } v;</p>

<p class=3D"MsoNormal">} align(8);</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app buffer registry per PID =
created
successfully (in setup_buffer_reg_pid() at ust-app.c:1746)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app session created successf=
ully
with handle 1 (in create_ust_app_session() at ust-app.c:1910)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: UST app creating channel mychann=
el with
per PID buffers (in create_channel_per_pid() at ust-app.c:2512)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Buffer registry per PID find id:=
 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80004000 of type 0 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: Asking UST consumer for channel =
(in
ask_channel_creation() at ust-consumer.c:118)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST registry channel finding key=
 1 (in
ust_registry_channel_find() at ust-registry.c:489)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST ask channel 1 successfully d=
one with
2 stream(s) (in ask_channel_creation() at ust-consumer.c:195)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app stream 1 received succes=
fully
(in ust_consumer_get_channel() at ust-consumer.c:311)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app stream 2 received succes=
fully
(in ust_consumer_get_channel() at ust-consumer.c:311)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app consumer has no more str=
eam
available (in ust_consumer_get_channel() at ust-consumer.c:294)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: UST app sending channel mychanne=
l to UST
app sock 25 (in send_channel_pid_to_ust() at ust-app.c:1365)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app send channel to sock 25 =
pid 1235
(name: mychannel, key: 0) (in ust_consumer_send_channel_to_ust() at
ust-consumer.c:415)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST consumer send stream to app =
25 (in
ust_consumer_send_stream_to_ust() at ust-consumer.c:380)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST consumer send stream to app =
25 (in
ust_consumer_send_stream_to_ust() at ust-consumer.c:380)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app event * created successf=
ully for
pid:1235 (in create_ust_event() at ust-app.c:1428)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Starting tracing for ust app pid=
 1235
(in ust_app_start_trace() at ust-app.c:3742)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Buffer registry per PID find id:=
 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80005dc0 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80006060 of type 0 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app channel metadata allocat=
ed (in
alloc_ust_app_channel() at ust-app.c:882)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: Asking UST consumer for channel =
(in
ask_channel_creation() at ust-consumer.c:118)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST ask channel 2 successfully d=
one with
1 stream(s) (in ask_channel_creation() at ust-consumer.c:195)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: Consumer setup metadata channel =
key 2
(in consumer_setup_metadata() at consumer.c:1205)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST metadata with key 2 created =
for app
pid 1235 (in create_ust_app_metadata() at ust-app.c:2800)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app deleting channel metadat=
a (in
delete_ust_app_channel() at ust-app.c:374)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Buffer registry per PID find id:=
 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST registry channel finding key=
 2 (in
ust_registry_channel_find() at ust-registry.c:489)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST app receiving notify from so=
ck 34
(in ust_app_recv_notify() at ust-app.c:4730)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1210]: UST app ustctl register event re=
ceived
(in ust_app_recv_notify() at ust-app.c:4750)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Buffer registry per PID find id:=
 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry channel finding key=
 1 (in
ust_registry_channel_find() at ust-registry.c:489)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry creating event with=
 event:
ust_baddr_statedump:soinfo, sig: struct lttng_session *, session, void *,
baddr, const char*, sopath, int64_t, size, int64_t, mtime, id: 0, chan_objd=
: 2,
sess_objd: 1, chan_id: 0 (in ust_registry_create_event() at ust-registry.c:=
298)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;event =
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D
&quot;ust_baddr_statedump:soinfo&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id =3D 0;=
</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stream_id=
 =3D 0;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loglevel =3D 13;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fields :=3D struct {</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 32; align =3D 8;
signed =3D 0; encoding =3D none; base =3D 16; } _baddr;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 string _sopath;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 64; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 10; } _size;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 64; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 10; } _mtime;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };</p>

<p class=3D"MsoNormal">};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry event
ust_baddr_statedump:soinfo with id 0 added successfully (in
add_event_ust_registry() at ust-app.c:4711)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: [ust-thread] Manage notify polli=
ng on 3
fds (in ust_thread_manage_notify() at ust-thread.c:68)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST app receiving notify from so=
ck 34
(in ust_app_recv_notify() at ust-app.c:4730)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1210]: UST app ustctl register channel =
received
(in ust_app_recv_notify() at ust-app.c:4783)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Buffer registry per PID find id:=
 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry channel finding key=
 1 (in
ust_registry_channel_find() at ust-registry.c:489)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;stream=
 {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id =3D 0;=
</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event.hea=
der
:=3D struct event_header_compact;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet.co=
ntext
:=3D struct packet_context;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST app replying to register cha=
nnel key
1 with id 0, type: 1, ret: 0 (in reply_ust_register_channel() at
ust-app.c:4596)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: [ust-thread] Manage notify polli=
ng on 3
fds (in ust_thread_manage_notify() at ust-thread.c:68)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST trace started for app pid 12=
35 (in
ust_app_global_update() at ust-app.c:4247)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Woken up but nothing in the UST =
command
queue (in thread_dispatch_ust_registration() at main.c:1600)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1209]: Apps with sock 25 added to poll =
set (in
thread_manage_apps() at main.c:1382)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1209]: Apps thread polling on 3 fds (in
thread_manage_apps() at main.c:1321)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST app receiving notify from so=
ck 34
(in ust_app_recv_notify() at ust-app.c:4730)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1210]: UST app ustctl register event re=
ceived
(in ust_app_recv_notify() at ust-app.c:4750)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Buffer registry per PID find id:=
 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry channel finding key=
 1 (in
ust_registry_channel_find() at ust-registry.c:489)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry creating event with=
 event:
example_provider:trace_test_tp_id1, sig: const char *, text, id: 0, chan_ob=
jd:
2, sess_objd: 1, chan_id: 0 (in ust_registry_create_event() at
ust-registry.c:298)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;event =
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D
&quot;example_provider:trace_test_tp_id1&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0id =3D 1;=
</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stream_id=
 =3D 0;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loglevel =3D 4;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fields :=3D struct {</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 string _message;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };</p>

<p class=3D"MsoNormal">};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry event
example_provider:trace_test_tp_id1 with id 1 added successfully (in
add_event_ust_registry() at ust-app.c:4711)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: [ust-thread] Manage notify polli=
ng on 3
fds (in ust_thread_manage_notify() at ust-thread.c:68)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST app receiving notify from so=
ck 34
(in ust_app_recv_notify() at ust-app.c:4730)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1210]: UST app ustctl register event re=
ceived
(in ust_app_recv_notify() at ust-app.c:4750)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Buffer registry per PID find id:=
 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry channel finding key=
 1 (in
ust_registry_channel_find() at ust-registry.c:489)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry creating event with=
 event:
example_provider:trace_test_tp_id2, sig: int, anint, int, netint, long *,
values, char *, text, size_t, textlen, double, doublearg, float, floatarg, =
id:
0, chan_objd: 2, sess_objd: 1, chan_id: 0 (in ust_registry_create_event() a=
t
ust-registry.c:298)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;event =
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D
&quot;example_provider:trace_test_tp_id2&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id =3D 2;=
</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stream_id=
 =3D 0;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loglevel =3D 3;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fields :=3D struct {</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 32; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 10; } _intfield;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 32; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 16; } _intfield2;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 32; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 10; } _longfield;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 32; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 10; byte_order =3D be; } _netintf=
ield;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 32; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 16; byte_order =3D be; } _netintf=
ieldhex;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 32; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 10; } _arrfield1[3];</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 8; align =3D 8;
signed =3D 1; encoding =3D UTF8; base =3D 10; } _arrfield2[10];</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 32; align =3D 8;
signed =3D 0; encoding =3D none; base =3D 10; } __seqfield1_length;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 8; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 10; } _seqfield1[ __seqfield1_len=
gth ];</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 32; align =3D 8;
signed =3D 0; encoding =3D none; base =3D 10; } __seqfield2_length;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 8; align =3D 8;
signed =3D 1; encoding =3D UTF8; base =3D 10; } _seqfield2[ __seqfield2_len=
gth ];</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 string _stringfield;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 floating_point { exp_dig =3D 8;
mant_dig =3D 24; align =3D 8; } _floatfield;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 floating_point { exp_dig =3D 11;
mant_dig =3D 53; align =3D 8; } _doublefield;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };</p>

<p class=3D"MsoNormal">};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry event
example_provider:trace_test_tp_id2 with id 2 added successfully (in
add_event_ust_registry() at ust-app.c:4711)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: [ust-thread] Manage notify polli=
ng on 3
fds (in ust_thread_manage_notify() at ust-thread.c:68)</p>

<p class=3D"MsoNormal">mysystem # DEBUG1 [1203/1209]: PID 1235 unregisterin=
g with
sock 25 (in ust_app_unregister() at ust-app.c:2987)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1209]: Buffer registry per PID find id:=
 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1209]: Consumer push metadata to consum=
er
socket 32 (in consumer_push_metadata() at consumer.c:1239)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1209]: Consumer pushing metadata on soc=
k 32 of
len 4251 (in consumer_push_metadata() at consumer.c:1254)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1210]: UST app notify socket unregister=
 34 (in
ust_app_notify_sock_unregister() at ust-app.c:4857)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1210]: UST app find by notify sock 34 n=
ot found
(in find_app_by_notify_sock() at ust-app.c:1029)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: [ust-thread] Manage notify polli=
ng on 2
fds (in ust_thread_manage_notify() at ust-thread.c:68)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1223]: Metadata request received for se=
ssion 0,
key 2 (in ust_consumer_metadata_request() at ust-consumer.c:461)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1223]: Buffer registry per UID find id:=
 0, ABI:
32, uid: 0 (in buffer_reg_uid_find() at buffer-registry.c:195)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1223]: Buffer registry per PID find id:=
 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1223]: No metadata to push for metadata=
 key 2
(in ust_app_push_metadata() at ust-app.c:460)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1223]: No metadata to push (in
ust_app_push_metadata() at ust-app.c:463)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1223]: Consumer push metadata to consum=
er
socket 33 (in consumer_push_metadata() at consumer.c:1239)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1223]: UST Consumer metadata pushed
successfully (in ust_consumer_metadata_request() at ust-consumer.c:496)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1209]: Consumer close metadata channel =
key 2
(in consumer_close_metadata() at consumer.c:1172)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1209]: Apps thread polling on 2 fds (in
thread_manage_apps() at main.c:1321)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: Call RCU deleting app PID 1235 (=
in
delete_ust_app_rcu() at ust-app.c:780)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: Buffer registry per PID find id:=
 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: UST app deleting channel mychann=
el (in delete_ust_app_channel()
at ust-app.c:374)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: Buffer registry per PID find id:=
 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: UST registry channel finding key=
 1 (in
ust_registry_channel_find() at ust-registry.c:489)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: Buffer registry per PID find id:=
 1 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: Buffer registry per PID destroy =
with id:
1 (in buffer_reg_pid_destroy() at buffer-registry.c:686)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1244]: UST app pid 1235 deleted (in
delete_ust_app() at ust-app.c:765)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: Buffer registry session destroy =
(in
buffer_reg_session_destroy() at buffer-registry.c:543)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # babeltrace /home/root/lttng-traces/ =C2=
=A0 =C2=A0 &lt;&lt;&lt;&lt;&lt;&lt;no traces found</p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # /logtrace_test64 =C2=A0 &lt;&lt;&lt;&lt;&=
lt;&lt;&lt;&lt;&lt;&lt;running a 64-bit app</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: UST registration received with p=
id:1250
ppid:850 uid:0 gid:0 sock:25 name:logtrace_test64 (version 5.0) (in
thread_registration_apps() at main.c:1946)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: Futex n to 1 wake done (in futex=
_nto1_wake()
at futex.c:104)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: Accepting application registrati=
on (in
thread_registration_apps() at main.c:1838)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Futex n to 1 wait done (in
futex_nto1_wait() at futex.c:90)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Futex n to 1 prepare done (in
futex_nto1_prepare() at futex.c:75)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Dispatching UST registration pid=
:1250
ppid:850 uid:0 gid:0 sock:25 name:logtrace_test64 (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1612)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app creating application for=
 socket
25 (in ust_app_create() at ust-app.c:2848)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e800028c0 of type 2 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80002c90 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Woken up but nothing in the UST =
command
queue (in thread_dispatch_ust_registration() at main.c:1600)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: UST registration received with p=
id:1250
ppid:850 uid:0 gid:0 sock:34 name:logtrace_test64 (version 5.0) (in
thread_registration_apps() at main.c:1946)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:104)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1208]: Accepting application registrati=
on (in
thread_registration_apps() at main.c:1838)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Futex n to 1 wait done (in
futex_nto1_wait() at futex.c:90)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Futex n to 1 prepare done (in
futex_nto1_prepare() at futex.c:75)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Dispatching UST registration pid=
:1250
ppid:850 uid:0 gid:0 sock:34 name:logtrace_test64 (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1612)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app notify socket 34 is set =
(in
thread_dispatch_ust_registration() at main.c:1669)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: App registered with pid:1250 ppi=
d:850
uid:0 gid:0 sock:25 name:logtrace_test64 notify_sock:34 (version 5.0) (in
ust_app_add() at ust-app.c:2936)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app global update for app so=
ck 25
for session id 0 (in ust_app_global_update() at ust-app.c:4173)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app pid: 1250 session id 0 n=
ot
found, creating it (in create_ust_app_session() at ust-app.c:1842)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e800030d0 of type 0 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: Shadow copy of session handle -1=
 (in
shadow_copy_session() at ust-app.c:1598)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: Channel mychannel not found on s=
hadow
session copy, creating it (in shadow_copy_session() at ust-app.c:1648)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80001c00 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80002040 of type 0 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app channel mychannel alloca=
ted (in
alloc_ust_app_channel() at ust-app.c:882)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app shadow copy of channel m=
ychannel
started (in shadow_copy_channel() at ust-app.c:1525)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST event * not found on shadow =
copy
channel (in shadow_copy_channel() at ust-app.c:1565)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app event * allocated (in
alloc_ust_app_event() at ust-app.c:938)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app shadow copy of channel m=
ychannel
done (in shadow_copy_channel() at ust-app.c:1575)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Buffer registry per PID find id:=
 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80003a50 of type 2 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Buffer registry per PID created =
with
session id: 2 (in buffer_reg_pid_create() at buffer-registry.c:262)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Buffer registry per PID adding t=
o global
registry with id: 2 (in buffer_reg_pid_add() at buffer-registry.c:281)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80003f30 of type 2 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST thread notify added sock 34 =
to
pollset (in ust_thread_manage_notify() at ust-thread.c:137)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: [ust-thread] Manage notify polli=
ng on 3
fds (in ust_thread_manage_notify() at ust-thread.c:68)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;typeal=
ias
integer { size =3D 8; align =3D 8; signed =3D false; } :=3D uint8_t;</p>

<p class=3D"MsoNormal">typealias integer { size =3D 16; align =3D 8; signed=
 =3D false; }
:=3D uint16_t;</p>

<p class=3D"MsoNormal">typealias integer { size =3D 32; align =3D 8; signed=
 =3D false; }
:=3D uint32_t;</p>

<p class=3D"MsoNormal">typealias integer { size =3D 64; align =3D 8; signed=
 =3D false; }
:=3D uint64_t;</p>

<p class=3D"MsoNormal">typealias integer { size =3D 64; align =3D 8; signed=
 =3D false; }
:=3D unsigned long;</p>

<p class=3D"MsoNormal">typealias integer { size =3D 5; align =3D 1; signed =
=3D false; }
:=3D uint5_t;</p>

<p class=3D"MsoNormal">typealias integer { size =3D 27; align =3D 1; signed=
 =3D false; }
:=3D uint27_t;</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">trace {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 major =3D=
 1;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minor =3D=
 8;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uuid =3D
&quot;ec211891-6c61-4af7-8ceb-29962469f700&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 byte_orde=
r =3D
le;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet.he=
ader
:=3D struct {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
uint32_t magic;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
uint8_t=C2=A0 uuid[16];</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
uint32_t stream_id;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };</p>

<p class=3D"MsoNormal">};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;env {<=
/p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hostname =
=3D
&quot;mysystem_node&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 domain =
=3D
&quot;ust&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracer_na=
me =3D
&quot;lttng-ust&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracer_ma=
jor =3D
2;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracer_mi=
nor =3D
4;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracer_patchlevel =3D 1;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vpid =3D =
1250;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 procname =
=3D
&quot;logtrace_test64&quot;;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;clock =
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D
monotonic;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uuid =3D
&quot;b1019e3b-fafd-4c41-bebc-c476fa343570&quot;;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description =3D &quot;Monotonic
Clock&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 freq =3D
1000000000; /* Frequency, in Hz */</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* clock =
value
offset from Epoch is: offset * (1/freq) */</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =
=3D
1412699639502362921;</p>

<p class=3D"MsoNormal">};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;typeal=
ias
integer {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D =
27;
align =3D 1; signed =3D false;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map =3D
clock.monotonic.value;</p>

<p class=3D"MsoNormal">} :=3D uint27_clock_monotonic_t;</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">typealias integer {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D =
32;
align =3D 8; signed =3D false;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map =3D
clock.monotonic.value;</p>

<p class=3D"MsoNormal">} :=3D uint32_clock_monotonic_t;</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">typealias integer {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D =
64;
align =3D 8; signed =3D false;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map =3D
clock.monotonic.value;</p>

<p class=3D"MsoNormal">} :=3D uint64_clock_monotonic_t;</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;struct
packet_context {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_cl=
ock_monotonic_t
timestamp_begin;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
uint64_clock_monotonic_t timestamp_end;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t
content_size;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t
packet_size;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned =
long
events_discarded;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t
cpu_id;</p>

<p class=3D"MsoNormal">};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Append to metadata: &quot;struct
event_header_compact {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum : ui=
nt5_t
{ compact =3D 0 ... 30, extended =3D 31 } id;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variant
&lt;id&gt; {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
uint27_clock_monotonic_t timestamp;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
compact;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
uint32_t id;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
uint64_clock_monotonic_t timestamp;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
extended;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } v;</p>

<p class=3D"MsoNormal">} align(8);</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">struct event_header_large {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum :
uint16_t { compact =3D 0 ... 65534, extended =3D 65535 } id;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variant
&lt;id&gt; {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
uint32_clock_monotonic_t timestamp;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
compact;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0struct {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
uint32_t id;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
uint64_clock_monotonic_t timestamp;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
extended;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } v;</p>

<p class=3D"MsoNormal">} align(8);</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app buffer registry per PID =
created
successfully (in setup_buffer_reg_pid() at ust-app.c:1746)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app session created successf=
ully
with handle 1 (in create_ust_app_session() at ust-app.c:1910)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: UST app creating channel mychann=
el with
per PID buffers (in create_channel_per_pid() at ust-app.c:2512)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Buffer registry per PID find id:=
 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80002460 of type 0 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: Asking UST consumer for channel =
(in
ask_channel_creation() at ust-consumer.c:118)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST registry channel finding key=
 3 (in
ust_registry_channel_find() at ust-registry.c:489)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST ask channel 3 successfully d=
one with
2 stream(s) (in ask_channel_creation() at ust-consumer.c:195)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app stream 1 received succes=
fully
(in ust_consumer_get_channel() at ust-consumer.c:311)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app stream 2 received succes=
fully
(in ust_consumer_get_channel() at ust-consumer.c:311)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app consumer has no more str=
eam
available (in ust_consumer_get_channel() at ust-consumer.c:294)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: UST app sending channel mychanne=
l to UST
app sock 25 (in send_channel_pid_to_ust() at ust-app.c:1365)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app send channel to sock 25 =
pid 1250
(name: mychannel, key: 0) (in ust_consumer_send_channel_to_ust() at
ust-consumer.c:415)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST consumer send stream to app =
25 (in
ust_consumer_send_stream_to_ust() at ust-consumer.c:380)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST consumer send stream to app =
25 (in
ust_consumer_send_stream_to_ust() at ust-consumer.c:380)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST app event * created successf=
ully for
pid:1250 (in create_ust_event() at ust-app.c:1428)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Starting tracing for ust app pid=
 1250
(in ust_app_start_trace() at ust-app.c:3742)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Buffer registry per PID find id:=
 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80004a90 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Created hashtable size 4 at
0x7f2e80006680 of type 0 (in lttng_ht_new() at hashtable.c:127)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app channel metadata allocat=
ed (in
alloc_ust_app_channel() at ust-app.c:882)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: Asking UST consumer for channel =
(in
ask_channel_creation() at ust-consumer.c:118)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST ask channel 4 successfully d=
one with
1 stream(s) (in ask_channel_creation() at ust-consumer.c:195)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: Consumer setup metadata channel =
key 4
(in consumer_setup_metadata() at consumer.c:1205)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST metadata with key 4 created =
for app
pid 1250 (in create_ust_app_metadata() at ust-app.c:2800)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST app deleting channel metadat=
a (in
delete_ust_app_channel() at ust-app.c:374)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: Buffer registry per PID find id:=
 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1207]: UST registry channel finding key=
 4 (in
ust_registry_channel_find() at ust-registry.c:489)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST app receiving notify from so=
ck 34
(in ust_app_recv_notify() at ust-app.c:4730)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1210]: UST app ustctl register event re=
ceived
(in ust_app_recv_notify() at ust-app.c:4750)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Buffer registry per PID find id:=
 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry channel finding key=
 3 (in
ust_registry_channel_find() at ust-registry.c:489)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry creating event with=
 event:
ust_baddr_statedump:soinfo, sig: struct lttng_session *, session, void *,
baddr, const char*, sopath, int64_t, size, int64_t, mtime, id: 0, chan_objd=
: 2,
sess_objd: 1, chan_id: 0 (in ust_registry_create_event() at ust-registry.c:=
298)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;event =
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D
&quot;ust_baddr_statedump:soinfo&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id =3D 0;=
</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stream_id=
 =3D 0;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loglevel =3D 13;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fields :=3D struct {</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 64; align =3D 8;
signed =3D 0; encoding =3D none; base =3D 16; } _baddr;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 string _sopath;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 64; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 10; } _size;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 64; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 10; } _mtime;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };</p>

<p class=3D"MsoNormal">};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry event
ust_baddr_statedump:soinfo with id 0 added successfully (in
add_event_ust_registry() at ust-app.c:4711)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: [ust-thread] Manage notify polli=
ng on 3
fds (in ust_thread_manage_notify() at ust-thread.c:68)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST app receiving notify from so=
ck 34
(in ust_app_recv_notify() at ust-app.c:4730)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1210]: UST app ustctl register channel =
received
(in ust_app_recv_notify() at ust-app.c:4783)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Buffer registry per PID find id:=
 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry channel finding key=
 3 (in
ust_registry_channel_find() at ust-registry.c:489)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;stream=
 {</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id =3D 0;=
</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event.hea=
der :=3D struct
event_header_compact;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet.co=
ntext
:=3D struct packet_context;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST app replying to register cha=
nnel key
3 with id 0, type: 1, ret: 0 (in reply_ust_register_channel() at
ust-app.c:4596)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: [ust-thread] Manage notify polli=
ng on 3
fds (in ust_thread_manage_notify() at ust-thread.c:68)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1207]: UST trace started for app pid 12=
50 (in
ust_app_global_update() at ust-app.c:4247)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST app receiving notify from so=
ck 34
(in ust_app_recv_notify() at ust-app.c:4730)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1210]: UST app ustctl register event re=
ceived
(in ust_app_recv_notify() at ust-app.c:4750)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Buffer registry per PID find id:=
 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry channel finding key=
 3 (in
ust_registry_channel_find() at ust-registry.c:489)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry creating event with=
 event:
example_provider:trace_test_tp_id1, sig: const char *, text, id: 0, chan_ob=
jd:
2, sess_objd: 1, chan_id: 0 (in ust_registry_create_event() at
ust-registry.c:298)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;event =
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D
&quot;example_provider:trace_test_tp_id1&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id =3D 1;=
</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stream_id=
 =3D 0;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loglevel =3D 4;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fields :=3D struct {</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 string _message;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };</p>

<p class=3D"MsoNormal">};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry event
example_provider:trace_test_tp_id1 with id 1 added successfully (in
add_event_ust_registry() at ust-app.c:4711)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: [ust-thread] Manage notify polli=
ng on 3
fds (in ust_thread_manage_notify() at ust-thread.c:68)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST app receiving notify from so=
ck 34
(in ust_app_recv_notify() at ust-app.c:4730)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1210]: UST app ustctl register event re=
ceived
(in ust_app_recv_notify() at ust-app.c:4750)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Buffer registry per PID find id:=
 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry channel finding key=
 3 (in
ust_registry_channel_find() at ust-registry.c:489)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry creating event with=
 event:
example_provider:trace_test_tp_id2, sig: int, anint, int, netint, long *,
values, char *, text, size_t, textlen, double, doublearg, float, floatarg, =
id:
0, chan_objd: 2, sess_objd: 1, chan_id: 0 (in ust_registry_create_event() a=
t
ust-registry.c:298)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;event =
{</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D
&quot;example_provider:trace_test_tp_id2&quot;;</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id =3D 2;=
</p>

<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stream_id=
 =3D 0;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loglevel =3D 3;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fields :=3D struct {</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 32; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 10; } _intfield;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 32; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 16; } _intfield2;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 64; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 10; } _longfield;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 32; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 10; byte_order =3D be; } _netintf=
ield;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 32; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 16; byte_order =3D be; } _netintf=
ieldhex;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 64; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 10; } _arrfield1[3];</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 8; align =3D 8;
signed =3D 1; encoding =3D UTF8; base =3D 10; } _arrfield2[10];</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 64; align =3D 8;
signed =3D 0; encoding =3D none; base =3D 10; } __seqfield1_length;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 8; align =3D 8;
signed =3D 1; encoding =3D none; base =3D 10; } _seqfield1[ __seqfield1_len=
gth ];</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 64; align =3D 8;
signed =3D 0; encoding =3D none; base =3D 10; } __seqfield2_length;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integer { size =3D 8; align =3D 8;
signed =3D 1; encoding =3D UTF8; base =3D 10; } _seqfield2[ __seqfield2_len=
gth ];</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 string _stringfield;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 floating_point { exp_dig =3D 8;
mant_dig =3D 24; align =3D 8; } _floatfield;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 floating_point { exp_dig =3D 11;
mant_dig =3D 53; align =3D 8; } _doublefield;</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: Append to metadata: &quot;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };</p>

<p class=3D"MsoNormal">};</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">&quot; (in lttng_metadata_printf() at ust-metadata.c=
:151)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: UST registry event example_provi=
der:trace_test_tp_id2
with id 2 added successfully (in add_event_ust_registry() at ust-app.c:4711=
)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: [ust-thread] Manage notify polli=
ng on 3
fds (in ust_thread_manage_notify() at ust-thread.c:68)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1215]: Metadata request received for se=
ssion 0,
key 4 (in ust_consumer_metadata_request() at ust-consumer.c:461)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1215]: Buffer registry per UID find id:=
 0, ABI:
64, uid: 0 (in buffer_reg_uid_find() at buffer-registry.c:195)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1215]: Buffer registry per PID find id:=
 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1215]: Consumer push metadata to consum=
er
socket 29 (in consumer_push_metadata() at consumer.c:1239)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1215]: Consumer pushing metadata on soc=
k 29 of
len 4253 (in consumer_push_metadata() at consumer.c:1254)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1215]: UST Consumer metadata pushed
successfully (in ust_consumer_metadata_request() at ust-consumer.c:496)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1207]: Woken up but nothing in the UST =
command
queue (in thread_dispatch_ust_registration() at main.c:1600)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1209]: Apps with sock 25 added to poll =
set (in
thread_manage_apps() at main.c:1382)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1209]: Apps thread polling on 3 fds (in
thread_manage_apps() at main.c:1321)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1215]: Metadata request received for se=
ssion 0,
key 4 (in ust_consumer_metadata_request() at ust-consumer.c:461)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1215]: Buffer registry per UID find id:=
 0, ABI:
64, uid: 0 (in buffer_reg_uid_find() at buffer-registry.c:195)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1215]: Buffer registry per PID find id:=
 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1215]: No metadata to push for metadata=
 key 4
(in ust_app_push_metadata() at ust-app.c:460)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1215]: No metadata to push (in ust_app_=
push_metadata()
at ust-app.c:463)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1215]: Consumer push metadata to consum=
er
socket 29 (in consumer_push_metadata() at consumer.c:1239)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1215]: UST Consumer metadata pushed
successfully (in ust_consumer_metadata_request() at ust-consumer.c:496)</p>

<p class=3D"MsoNormal">mysystem # DEBUG1 [1203/1209]: PID 1250 unregisterin=
g with
sock 25 (in ust_app_unregister() at ust-app.c:2987)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1209]: Buffer registry per PID find id:=
 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1209]: No metadata to push for metadata=
 key 4
(in ust_app_push_metadata() at ust-app.c:460)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1209]: Consumer close metadata channel =
key 4
(in consumer_close_metadata() at consumer.c:1172)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1210]: UST app notify socket unregister=
 34 (in ust_app_notify_sock_unregister()
at ust-app.c:4857)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1210]: UST app find by notify sock 34 n=
ot found
(in find_app_by_notify_sock() at ust-app.c:1029)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1210]: [ust-thread] Manage notify polli=
ng on 2
fds (in ust_thread_manage_notify() at ust-thread.c:68)</p>

<p class=3D"MsoNormal">DEBUG1 [1203/1209]: Apps thread polling on 2 fds (in
thread_manage_apps() at main.c:1321)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: Call RCU deleting app PID 1250 (=
in
delete_ust_app_rcu() at ust-app.c:780)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: Buffer registry per PID find id:=
 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: UST app deleting channel mychann=
el (in
delete_ust_app_channel() at ust-app.c:374)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: Buffer registry per PID find id:=
 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: UST registry channel finding key=
 3 (in
ust_registry_channel_find() at ust-registry.c:489)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: Buffer registry per PID find id:=
 2 (in
buffer_reg_pid_find() at buffer-registry.c:301)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: Buffer registry per PID destroy =
with id:
2 (in buffer_reg_pid_destroy() at buffer-registry.c:686)</p>

<p class=3D"MsoNormal">DEBUG2 [1203/1244]: UST app pid 1250 deleted (in
delete_ust_app() at ust-app.c:765)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n thread_ht_cleanup()
at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1244]: Buffer registry session destroy =
(in
buffer_reg_session_destroy() at buffer-registry.c:543)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">DEBUG3 [1203/1204]: [ht-thread] Polling on 2 fds. (i=
n
thread_ht_cleanup() at ht-cleanup.c:64)</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">mysystem # babeltrace /home/root/lttng-traces/</p>

<p class=3D"MsoNormal">[10:13:42.880173965] (+?.?????????)
mysystem_node:logtrace_test64:1250 example_provider:trace_test_tp_id1: { cp=
u_id
=3D 1 }, { message =3D &quot;testing evo trace..start&quot; }</p>

<p class=3D"MsoNormal">[10:13:42.880181626] (+0.000007661)
mysystem_node:logtrace_test64:1250 example_provider:trace_test_tp_id2: { cp=
u_id
=3D 1 }, { intfield =3D 0, intfield2 =3D 0x0, longfield =3D 0, netintfield =
=3D 0,
netintfieldhex =3D 0x0, arrfield1 =3D [ [0] =3D 1, [1] =3D 2, [2] =3D 3 ], =
arrfield2 =3D
&quot;test&quot;, _seqfield1_length =3D 4, seqfield1 =3D [ [0] =3D 116, [1]=
 =3D 101,
[2] =3D 115, [3] =3D 116 ], _seqfield2_length =3D 4, seqfield2 =3D &quot;te=
st&quot;,
stringfield =3D &quot;test&quot;, floatfield =3D 2222.2, doublefield =3D 2 =
}</p>

<p class=3D"MsoNormal">[10:13:42.880182470] (+0.000000844) mysystem_node:lo=
gtrace_test64:1250
example_provider:trace_test_tp_id2: { cpu_id =3D 1 }, { intfield =3D 1, int=
field2 =3D
0x1, longfield =3D 1, netintfield =3D 1, netintfieldhex =3D 0x1, arrfield1 =
=3D [ [0] =3D
1, [1] =3D 2, [2] =3D 3 ], arrfield2 =3D &quot;test&quot;, _seqfield1_lengt=
h =3D 4,
seqfield1 =3D [ [0] =3D 116, [1] =3D 101, [2] =3D 115, [3] =3D 116 ], _seqf=
ield2_length =3D
4, seqfield2 =3D &quot;test&quot;, stringfield =3D &quot;test&quot;, floatf=
ield =3D
2222.2, doublefield =3D 2 }</p>

<p class=3D"MsoNormal">[10:13:42.880183000] (+0.000000530)
mysystem_node:logtrace_test64:1250 example_provider:trace_test_tp_id2: { cp=
u_id
=3D 1 }, { intfield =3D 2, intfield2 =3D 0x2, longfield =3D 2, netintfield =
=3D 2,
netintfieldhex =3D 0x2, arrfield1 =3D [ [0] =3D 1, [1] =3D 2, [2] =3D 3 ], =
arrfield2 =3D
&quot;test&quot;, _seqfield1_length =3D 4, seqfield1 =3D [ [0] =3D 116, [1]=
 =3D 101,
[2] =3D 115, [3] =3D 116 ], _seqfield2_length =3D 4, seqfield2 =3D &quot;te=
st&quot;,
stringfield =3D &quot;test&quot;, floatfield =3D 2222.2, doublefield =3D 2 =
}</p>

<p class=3D"MsoNormal">[10:13:42.880183588] (+0.000000588)
mysystem_node:logtrace_test64:1250 example_provider:trace_test_tp_id1: { cp=
u_id
=3D 1 }, { message =3D &quot;testing evo trace..end&quot; }</p>

<p class=3D"MsoNormal">mysystem # </p>

<p class=3D"MsoNormal">=C2=A0</p>

</div><div><br></div><div>







<p class=3D""><br></p></div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Tue, Oct 7, 2014 at 12:12 AM, Anand Neeli <span dir=3D"=
ltr">&lt;<a href=3D"mailto:anand.neeli@gmail.com" target=3D"_blank">anand.n=
eeli@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div=
 dir=3D"ltr">Hi All,<div><br></div><div>I have a query running 32-bit and 6=
4-bit apps.</div><div>i&#39;m starting lttng with following steps</div><div=
><br></div><div>lttng-relayd -d</div><div><br></div><div>lttng-sessiond --c=
onsumerd32-path /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir=
 /usr/lib/ --consumerd64-path /usr/lib64/lttng/libexec/lttng-consumerd --co=
nsumerd64-libdir /usr/lib64/ -b --no-kernel<br></div><div><br></div><div>lt=
tng -no-sessiond create mysession --live 200000 -U net://localhost<br></div=
><div><p>lttng enable-channel mychannel --userspace --buffers-pid -s mysess=
ion --tracefile-size 8388608 --tracefile-count 8</p><p>lttng=C2=A0 enable-e=
vent --channel mychannel --userspace --all -s mysession<br></p><p>











</p><p>







</p><p>lttng start</p><p><br></p><div>My Queries:</div><div>1) Does this sp=
awn consumerd for 32-bit and 64-bit separately?</div><div><br></div><div>2)=
 i see that 2 consumerd process are launched. and the 64-bit one looks to b=
e correct.</div><div><div>root =C2=A0 =C2=A0 =C2=A0 975 =C2=A00.0 =C2=A00.0=
 404480 =C2=A0 956 ? =C2=A0 =C2=A0 =C2=A0 =C2=A0Sl =C2=A0 11:01 =C2=A0 0:00=
 lttng-consumerd --quiet -u --consumerd-cmd-sock /var/run/lttng/ustconsumer=
d64/command --consumerd-err-sock /var/run/lttng/ustconsumerd64/error --grou=
p tracing</div><div>root =C2=A0 =C2=A0 =C2=A0 983 =C2=A00.0 =C2=A00.0 =C2=
=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 0 ? =C2=A0 =C2=A0 =C2=A0 =C2=A0Z =C2=A0 =
=C2=A011:01 =C2=A0 0:00 [lttng-consumerd] &lt;defunct&gt;</div></div><div><=
br></div><div>3) What libraries are required by sessiond to launch consumer=
d. So that i can copy only those libraries on to the target.</div><div><br>=
</div><div>4) is there a way to launch sessiond so that it automatically co=
nsumes data from 32-bit and 64-bit apps.</div><div><br></div><div><br></div=
><div>Thanks in advance,</div><div>Anand Neeli</div><div><br></div><div><br=
></div><p><br></p><p><br></p><p><br></p></div></div>
</blockquote></div><br></div>

--001a11c24c4438f3e80504d8badb--


--===============1758738224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1758738224==--
