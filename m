From: Anand Neeli <anand.neeli@gmail.com>
Subject: sessiond launch fails with "Error: XSD parsing failed"
Date: Tue, 24 Mar 2015 17:14:05 +0530
Message-ID: <CAM5kDqygRNrn7Wz4cWjbrGaqOM2nrFRp2+tVJO230h9PzVZS=Q__22551.262463867$1427197531$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1329739072=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f181.google.com ([74.125.82.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YaNFj-00068w-BD
 for lttng-dev@lists.lttng.org; Tue, 24 Mar 2015 07:44:17 -0400
Received: by weop45 with SMTP id p45so161091123weo.0
 for <lttng-dev@lists.lttng.org>; Tue, 24 Mar 2015 04:44:05 -0700 (PDT)
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

--===============1329739072==
Content-Type: multipart/alternative; boundary=047d7b86d6cac6f1330512074c13

--047d7b86d6cac6f1330512074c13
Content-Type: text/plain; charset=UTF-8

Hi All,
lttng sessiond launch is failing with following error.
can any please tell what could cause this?

root@user:/usr/sbin# lttng-sessiond --consumerd32-path
/usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/ -b
--no-kernel
Warning: No tracing group detected
I/O warning : failed to load external entity
"/usr/share/xml/lttng/session.xsd"
XML Error: Failed to locate the main schema resource at
'/usr/share/xml/lttng/session.xsd'.
Error: XSD parsing failed
Error: Session load failed: Invalid session configuration


here is the full log:

root@user:/usr/sbin# lttng-sessiond --consumerd32-path
/usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/ -b
--no-kernel -vvv

DEBUG3 - 11:25:59.917407 [3817/3817]: Creating LTTng run directory:
/var/run/lttng (in create_lttng_rundir() at main.c:4780)

DEBUG2 - 11:25:59.918861 [3817/3817]: Kernel consumer err path:
/var/run/lttng/kconsumerd/error (in main() at main.c:5172)

DEBUG2 - 11:25:59.919062 [3817/3817]: Kernel consumer cmd path:
/var/run/lttng/kconsumerd/command (in main() at main.c:5174)

DEBUG1 - 11:25:59.919368 [3817/3817]: Client socket path
/var/run/lttng/client-lttng-sessiond (in main() at main.c:5232)

DEBUG1 - 11:25:59.919603 [3817/3817]: Application socket path
/var/run/lttng/lttng-ust-sock-5 (in main() at main.c:5233)

DEBUG1 - 11:25:59.919782 [3817/3817]: Application wait path
/lttng-ust-wait-5 (in main() at main.c:5234)

DEBUG1 - 11:25:59.919917 [3817/3817]: LTTng run directory path:
/var/run/lttng (in main() at main.c:5235)

DEBUG2 - 11:25:59.920152 [3817/3817]: UST consumer 32 bits err path:
/var/run/lttng/ustconsumerd32/error (in main() at main.c:5244)

DEBUG2 - 11:25:59.920292 [3817/3817]: UST consumer 32 bits cmd path:
/var/run/lttng/ustconsumerd32/command (in main() at main.c:5246)

DEBUG2 - 11:25:59.920535 [3817/3817]: UST consumer 64 bits err path:
/var/run/lttng/ustconsumerd64/error (in main() at main.c:5255)

DEBUG2 - 11:25:59.920710 [3817/3817]: UST consumer 64 bits cmd path:
/var/run/lttng/ustconsumerd64/command (in main() at main.c:5257)

DEBUG3 - 11:25:59.921403 [3817/3817]: Created hashtable size 4 at
0x100900b8 of type 1 (in lttng_ht_new() at hashtable.c:127)

DEBUG3 - 11:25:59.922239 [3817/3817]: Created hashtable size 4 at
0x100903d0 of type 1 (in lttng_ht_new() at hashtable.c:127)

DEBUG3 - 11:25:59.922423 [3817/3817]: Created hashtable size 4 at
0x100906f8 of type 1 (in lttng_ht_new() at hashtable.c:127)

DEBUG3 - 11:25:59.922602 [3817/3817]: Created hashtable size 4 at
0x10090a20 of type 1 (in lttng_ht_new() at hashtable.c:127)

DEBUG2 - 11:25:59.922776 [3817/3817]: Creating consumer directory:
/var/run/lttng/kconsumerd (in set_consumer_sockets() at main.c:4822)

Warning: No tracing group detected

DEBUG2 - 11:25:59.930624 [3817/3817]: Creating consumer directory:
/var/run/lttng/ustconsumerd64 (in set_consumer_sockets() at main.c:4822)

DEBUG2 - 11:25:59.931652 [3817/3817]: Creating consumer directory:
/var/run/lttng/ustconsumerd32 (in set_consumer_sockets() at main.c:4822)

DEBUG3 - 11:25:59.933773 [3817/3817]: Session daemon client socket 9 and
application socket 10 created (in init_daemon_socket() at main.c:4688)

DEBUG1 - 11:25:59.934810 [3817/3817]: All permissions are set (in
set_permissions() at main.c:4768)

DEBUG3 - 11:25:59.935071 [3817/3817]: Created hashtable size 4 at
0x10092510 of type 2 (in lttng_ht_new() at hashtable.c:127)

DEBUG3 - 11:25:59.935227 [3817/3817]: Global buffer per UID registry
initialized (in buffer_reg_init_uid_registry() at buffer-registry.c:99)

DEBUG3 - 11:25:59.935504 [3817/3817]: Created hashtable size 4 at
0x10092838 of type 2 (in lttng_ht_new() at hashtable.c:127)

DEBUG3 - 11:25:59.935646 [3817/3817]: Global buffer per PID registry
initialized (in buffer_reg_init_pid_registry() at buffer-registry.c:220)

DEBUG1 - 11:25:59.935974 [3817/3817]: epoll set max size is 236120 (in
compat_epoll_set_max_size() at compat-epoll.c:289)

DEBUG1 - 11:25:59.936128 [3817/3817]: Command subsystem initialized (in
cmd_init() at cmd.c:3331)

DEBUG1 - 11:25:59.936555 [3817/3817]: Pid 3817 written in file
/var/run/lttng/lttng-sessiond.pid (in utils_create_pid_file() at
utils.c:482)

DEBUG1 - 11:25:59.936953 [3817/3817]: Pid 5345 written in file
/var/run/lttng/agent.port (in utils_create_pid_file() at utils.c:482)

DEBUG1 - 11:25:59.937223 [3817/3817]: TCP inet operation timeout set to 216
sec (in lttcomm_inet_init() at inet.c:548)

DEBUG1 - 11:25:59.937429 [3817/3817]: Health check time delta in seconds
set to 236 (in health_init() at health.c:73)

DEBUG1 - 11:25:59.937750 [3817/3818]: [ht-thread] startup. (in
thread_ht_cleanup() at ht-cleanup.c:36)

DEBUG1 - 11:25:59.937821 [3817/3819]: [thread] Manage health check started
(in thread_manage_health() at main.c:3805)

DEBUG1 - 11:25:59.938116 [3817/3822]: [thread] Manage application
registration started (in thread_registration_apps() at main.c:1967)

DEBUG1 - 11:25:59.938129 [3817/3820]: [thread] Manage client started (in
thread_manage_clients() at main.c:3996)

DEBUG3 - 11:25:59.939523 [3817/3818]: [ht-thread] Polling. (in
thread_ht_cleanup() at ht-cleanup.c:63)

DEBUG1 - 11:25:59.939762 [3817/3820]: Accepting client command ... (in
thread_manage_clients() at main.c:4043)

DEBUG1 - 11:25:59.940153 [3817/3822]: Notifying applications of session
daemon state: 1 (in notify_ust_apps() at main.c:759)

DEBUG1 - 11:25:59.938215 [3817/3823]: [thread] Manage application started
(in thread_manage_apps() at main.c:1445)

DEBUG1 - 11:25:59.940837 [3817/3823]: Apps thread polling (in
thread_manage_apps() at main.c:1475)

DEBUG1 - 11:25:59.938227 [3817/3821]: [thread] Dispatch UST command started
(in thread_dispatch_ust_registration() at main.c:1743)

DEBUG1 - 11:25:59.940734 [3817/3819]: Health check ready (in
thread_manage_health() at main.c:3870)

DEBUG1 - 11:25:59.940937 [3817/3821]: Futex n to 1 prepare done (in
futex_nto1_prepare() at futex.c:75)

DEBUG1 - 11:25:59.941056 [3817/3821]: Woken up but nothing in the UST
command queue (in thread_dispatch_ust_registration() at main.c:1766)

DEBUG1 - 11:25:59.941161 [3817/3826]: [load-session-thread] Load session
(in thread_load_session() at load-session-thread.c:91)

DEBUG1 - 11:25:59.940739 [3817/3822]: Got the wait shm fd 21 (in
get_wait_shm() at shm.c:115)

DEBUG1 - 11:25:59.942324 [3817/3822]: Futex wait update active 1 (in
futex_wait_update() at futex.c:63)

DEBUG1 - 11:25:59.942367 [3817/3822]: Accepting application registration
(in thread_registration_apps() at main.c:2004)

DEBUG1 - 11:25:59.940772 [3817/3824]: [ust-thread] Manage application
notify command (in ust_thread_manage_notify() at ust-thread.c:39)

DEBUG3 - 11:25:59.943390 [3817/3824]: [ust-thread] Manage notify polling
(in ust_thread_manage_notify() at ust-thread.c:67)

DEBUG1 - 11:25:59.941799 [3817/3825]: [agent-thread] Manage agent
application registration. (in agent_thread_manage_registration() at
agent-thread.c:282)

DEBUG3 - 11:25:59.943917 [3817/3825]: URI string: tcp://localhost (in
uri_parse() at uri.c:293)

DEBUG2 - 11:25:59.948001 [3817/3825]: IP address resolved to 127.0.0.1 (in
set_ip_address() at uri.c:134)

DEBUG3 - 11:25:59.948298 [3817/3825]: URI dtype: 1, proto: 1, host:
localhost, subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:507)

DEBUG1 - 11:25:59.948694 [3817/3825]: [agent-thread] Listening on TCP port
5345 and socket 25 (in init_tcp_socket() at agent-thread.c:165)

DEBUG3 - 11:25:59.949009 [3817/3825]: [agent-thread] Manage agent polling
(in agent_thread_manage_registration() at agent-thread.c:309)

I/O warning : failed to load external entity
"/usr/share/xml/lttng/session.xsd"

XML Error: Failed to locate the main schema resource at
'/usr/share/xml/lttng/session.xsd'.

Error: XSD parsing failed

Error: Session load failed: Invalid session configuration

root@fpc0:/usr/sbin# DEBUG1 - 11:26:04.495062 [3817/3822]: UST registration
received with pid:3064 ppid:1 uid:0 gid:0 sock:26 name:bcmd (version 5.0)
(in thread_registration_apps() at main.c:2117)

DEBUG1 - 11:26:04.495859 [3817/3822]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:104)

DEBUG1 - 11:26:04.496041 [3817/3822]: Accepting application registration
(in thread_registration_apps() at main.c:2004)

DEBUG1 - 11:26:04.496551 [3817/3822]: UST registration received with
pid:3067 ppid:1 uid:0 gid:0 sock:27 name:hwd-ptx-fpc (version 5.0) (in
thread_registration_apps() at main.c:2117)

DEBUG1 - 11:26:04.496676 [3817/3821]: Futex n to 1 wait done (in
futex_nto1_wait() at futex.c:90)

DEBUG1 - 11:26:04.497068 [3817/3821]: Futex n to 1 prepare done (in
futex_nto1_prepare() at futex.c:75)

DEBUG1 - 11:26:04.497271 [3817/3821]: Dispatching UST registration pid:3064
ppid:1 uid:0 gid:0 sock:26 name:bcmd (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1778)

DEBUG3 - 11:26:04.497556 [3817/3821]: UST app creating application for
socket 26 (in ust_app_create() at ust-app.c:2962)

DEBUG3 - 11:26:04.497900 [3817/3821]: Created hashtable size 4 at
0xb3f04170 of type 2 (in lttng_ht_new() at hashtable.c:127)

DEBUG3 - 11:26:04.498151 [3817/3821]: Created hashtable size 4 at
0xb3f03f80 of type 1 (in lttng_ht_new() at hashtable.c:127)

DEBUG1 - 11:26:04.498739 [3817/3821]: Dispatching UST registration pid:3067
ppid:1 uid:0 gid:0 sock:27 name:hwd-ptx-fpc (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1778)

DEBUG3 - 11:26:04.498991 [3817/3821]: UST app creating application for
socket 27 (in ust_app_create() at ust-app.c:2962)

DEBUG3 - 11:26:04.499203 [3817/3821]: Created hashtable size 4 at
0xb3f00a98 of type 2 (in lttng_ht_new() at hashtable.c:127)

DEBUG3 - 11:26:04.499437 [3817/3821]: Created hashtable size 4 at
0xb3f00d78 of type 1 (in lttng_ht_new() at hashtable.c:127)

DEBUG1 - 11:26:04.500628 [3817/3821]: Woken up but nothing in the UST
command queue (in thread_dispatch_ust_registration() at main.c:1766)

DEBUG1 - 11:26:04.496801 [3817/3822]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:104)

DEBUG1 - 11:26:04.504581 [3817/3822]: Accepting application registration
(in thread_registration_apps() at main.c:2004)

DEBUG1 - 11:26:04.505272 [3817/3822]: UST registration received with
pid:3065 ppid:1 uid:0 gid:0 sock:28 name:cproc (version 5.0) (in
thread_registration_apps() at main.c:2117)

DEBUG1 - 11:26:04.505601 [3817/3822]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:104)

DEBUG1 - 11:26:04.505762 [3817/3822]: Accepting application registration
(in thread_registration_apps() at main.c:2004)

DEBUG1 - 11:26:04.506260 [3817/3822]: UST registration received with
pid:3066 ppid:1 uid:0 gid:0 sock:29 name:dist (version 5.0) (in
thread_registration_apps() at main.c:2117)

DEBUG1 - 11:26:04.506511 [3817/3822]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:104)

DEBUG1 - 11:26:04.506633 [3817/3822]: Accepting application registration
(in thread_registration_apps() at main.c:2004)

DEBUG1 - 11:26:04.506957 [3817/3821]: Futex n to 1 wait done (in
futex_nto1_wait() at futex.c:90)

DEBUG1 - 11:26:04.507344 [3817/3821]: Futex n to 1 prepare done (in
futex_nto1_prepare() at futex.c:75)

DEBUG1 - 11:26:04.507868 [3817/3821]: Dispatching UST registration pid:3065
ppid:1 uid:0 gid:0 sock:28 name:cproc (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1778)

DEBUG3 - 11:26:04.508174 [3817/3821]: UST app creating application for
socket 28 (in ust_app_create() at ust-app.c:2962)

DEBUG3 - 11:26:04.508426 [3817/3821]: Created hashtable size 4 at
0xb3f01200 of type 2 (in lttng_ht_new() at hashtable.c:127)

DEBUG3 - 11:26:04.508659 [3817/3821]: Created hashtable size 4 at
0xb3f012d8 of type 1 (in lttng_ht_new() at hashtable.c:127)

DEBUG1 - 11:26:04.509367 [3817/3821]: Dispatching UST registration pid:3066
ppid:1 uid:0 gid:0 sock:29 name:dist (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1778)

DEBUG1 - 11:26:04.507053 [3817/3822]: UST registration received with
pid:3064 ppid:1 uid:0 gid:0 sock:30 name:bcmd (version 5.0) (in
thread_registration_apps() at main.c:2117)

DEBUG1 - 11:26:04.509865 [3817/3822]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:104)

DEBUG1 - 11:26:04.510063 [3817/3822]: Accepting application registration
(in thread_registration_apps() at main.c:2004)

DEBUG3 - 11:26:04.509634 [3817/3821]: UST app creating application for
socket 29 (in ust_app_create() at ust-app.c:2962)

DEBUG3 - 11:26:04.510472 [3817/3821]: Created hashtable size 4 at
0xb3f04720 of type 2 (in lttng_ht_new() at hashtable.c:127)

DEBUG1 - 11:26:04.510633 [3817/3822]: UST registration received with
pid:3603 ppid:1 uid:0 gid:0 sock:31 name:sproc (version 5.0) (in
thread_registration_apps() at main.c:2117)

DEBUG3 - 11:26:04.510869 [3817/3821]: Created hashtable size 4 at
0xb3f04a60 of type 1 (in lttng_ht_new() at hashtable.c:127)

DEBUG1 - 11:26:04.510937 [3817/3822]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:104)

DEBUG1 - 11:26:04.511545 [3817/3822]: Accepting application registration
(in thread_registration_apps() at main.c:2004)

DEBUG1 - 11:26:04.511743 [3817/3821]: Dispatching UST registration pid:3064
ppid:1 uid:0 gid:0 sock:30 name:bcmd (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1778)

DEBUG3 - 11:26:04.512018 [3817/3821]: UST app notify socket 30 is set (in
thread_dispatch_ust_registration() at main.c:1835)

DEBUG1 - 11:26:04.512018 [3817/3822]: UST registration received with
pid:3066 ppid:1 uid:0 gid:0 sock:32 name:dist (version 5.0) (in
thread_registration_apps() at main.c:2117)

DEBUG1 - 11:26:04.512328 [3817/3822]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:104)

DEBUG1 - 11:26:04.512459 [3817/3822]: Accepting application registration
(in thread_registration_apps() at main.c:2004)

DEBUG1 - 11:26:04.512800 [3817/3821]: App registered with pid:3064 ppid:1
uid:0 gid:0 sock:26 name:bcmd notify_sock:30 (version 5.0) (in
ust_app_add() at ust-app.c:3050)

DEBUG1 - 11:26:04.512880 [3817/3822]: UST registration received with
pid:3067 ppid:1 uid:0 gid:0 sock:33 name:hwd-ptx-fpc (version 5.0) (in
thread_registration_apps() at main.c:2117)

DEBUG1 - 11:26:04.513437 [3817/3822]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:104)

DEBUG1 - 11:26:04.513639 [3817/3822]: Accepting application registration
(in thread_registration_apps() at main.c:2004)

DEBUG1 - 11:26:04.514697 [3817/3822]: UST registration received with
pid:3065 ppid:1 uid:0 gid:0 sock:34 name:cproc (version 5.0) (in
thread_registration_apps() at main.c:2117)

DEBUG1 - 11:26:04.515051 [3817/3822]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:104)

DEBUG1 - 11:26:04.515197 [3817/3822]: Accepting application registration
(in thread_registration_apps() at main.c:2004)

DEBUG1 - 11:26:04.515625 [3817/3822]: UST registration received with
pid:3603 ppid:1 uid:0 gid:0 sock:35 name:sproc (version 5.0) (in
thread_registration_apps() at main.c:2117)

DEBUG1 - 11:26:04.515846 [3817/3822]: Futex n to 1 wake done (in
futex_nto1_wake() at futex.c:104)

DEBUG1 - 11:26:04.515965 [3817/3822]: Accepting application registration
(in thread_registration_apps() at main.c:2004)

DEBUG3 - 11:26:04.517407 [3817/3824]: [ust-thread] Manage notify return
from poll on 2 fds (in ust_thread_manage_notify() at ust-thread.c:74)

DEBUG3 - 11:26:04.517913 [3817/3824]: UST thread notify added sock 30 to
pollset (in ust_thread_manage_notify() at ust-thread.c:143)

DEBUG3 - 11:26:04.518106 [3817/3824]: [ust-thread] Manage notify polling
(in ust_thread_manage_notify() at ust-thread.c:67)

DEBUG1 - 11:26:04.519777 [3817/3821]: Dispatching UST registration pid:3603
ppid:1 uid:0 gid:0 sock:31 name:sproc (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1778)

DEBUG3 - 11:26:04.520156 [3817/3821]: UST app creating application for
socket 31 (in ust_app_create() at ust-app.c:2962)

DEBUG3 - 11:26:04.520747 [3817/3821]: Created hashtable size 4 at
0xb3f04ec8 of type 2 (in lttng_ht_new() at hashtable.c:127)

DEBUG3 - 11:26:04.521037 [3817/3821]: Created hashtable size 4 at
0xb3f051f0 of type 1 (in lttng_ht_new() at hashtable.c:127)

DEBUG1 - 11:26:04.521555 [3817/3821]: Dispatching UST registration pid:3066
ppid:1 uid:0 gid:0 sock:32 name:dist (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1778)

DEBUG3 - 11:26:04.521921 [3817/3821]: UST app notify socket 32 is set (in
thread_dispatch_ust_registration() at main.c:1835)

DEBUG1 - 11:26:04.522179 [3817/3821]: App registered with pid:3066 ppid:1
uid:0 gid:0 sock:29 name:dist notify_sock:32 (version 5.0) (in
ust_app_add() at ust-app.c:3050)

DEBUG1 - 11:26:04.522314 [3817/3823]: Apps thread return from poll on 2 fds
(in thread_manage_apps() at main.c:1482)

DEBUG1 - 11:26:04.522878 [3817/3823]: Apps with sock 26 added to poll set
(in thread_manage_apps() at main.c:1543)

DEBUG1 - 11:26:04.523137 [3817/3823]: Apps thread polling (in
thread_manage_apps() at main.c:1475)

DEBUG3 - 11:26:04.523723 [3817/3824]: [ust-thread] Manage notify return
from poll on 3 fds (in ust_thread_manage_notify() at ust-thread.c:74)

DEBUG3 - 11:26:04.524132 [3817/3824]: UST thread notify added sock 32 to
pollset (in ust_thread_manage_notify() at ust-thread.c:143)

DEBUG3 - 11:26:04.524304 [3817/3824]: [ust-thread] Manage notify polling
(in ust_thread_manage_notify() at ust-thread.c:67)

DEBUG1 - 11:26:04.525500 [3817/3821]: Dispatching UST registration pid:3067
ppid:1 uid:0 gid:0 sock:33 name:hwd-ptx-fpc (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1778)

DEBUG3 - 11:26:04.525964 [3817/3821]: UST app notify socket 33 is set (in
thread_dispatch_ust_registration() at main.c:1835)

DEBUG1 - 11:26:04.526186 [3817/3821]: App registered with pid:3067 ppid:1
uid:0 gid:0 sock:27 name:hwd-ptx-fpc notify_sock:33 (version 5.0) (in
ust_app_add() at ust-app.c:3050)

DEBUG1 - 11:26:04.528508 [3817/3823]: Apps thread return from poll on 3 fds
(in thread_manage_apps() at main.c:1482)

DEBUG3 - 11:26:04.529255 [3817/3824]: [ust-thread] Manage notify return
from poll on 4 fds (in ust_thread_manage_notify() at ust-thread.c:74)

DEBUG1 - 11:26:04.529379 [3817/3823]: Apps with sock 29 added to poll set
(in thread_manage_apps() at main.c:1543)

DEBUG1 - 11:26:04.529997 [3817/3823]: Apps thread polling (in
thread_manage_apps() at main.c:1475)

DEBUG3 - 11:26:04.529751 [3817/3824]: UST thread notify added sock 33 to
pollset (in ust_thread_manage_notify() at ust-thread.c:143)

DEBUG3 - 11:26:04.530527 [3817/3824]: [ust-thread] Manage notify polling
(in ust_thread_manage_notify() at ust-thread.c:67)

DEBUG1 - 11:26:04.531440 [3817/3821]: Dispatching UST registration pid:3065
ppid:1 uid:0 gid:0 sock:34 name:cproc (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1778)

DEBUG3 - 11:26:04.531871 [3817/3821]: UST app notify socket 34 is set (in
thread_dispatch_ust_registration() at main.c:1835)

DEBUG1 - 11:26:04.532133 [3817/3821]: App registered with pid:3065 ppid:1
uid:0 gid:0 sock:28 name:cproc notify_sock:34 (version 5.0) (in
ust_app_add() at ust-app.c:3050)

DEBUG3 - 11:26:04.533795 [3817/3824]: [ust-thread] Manage notify return
from poll on 5 fds (in ust_thread_manage_notify() at ust-thread.c:74)

DEBUG3 - 11:26:04.534239 [3817/3824]: UST thread notify added sock 34 to
pollset (in ust_thread_manage_notify() at ust-thread.c:143)

DEBUG3 - 11:26:04.534423 [3817/3824]: [ust-thread] Manage notify polling
(in ust_thread_manage_notify() at ust-thread.c:67)

DEBUG1 - 11:26:04.535142 [3817/3823]: Apps thread return from poll on 4 fds
(in thread_manage_apps() at main.c:1482)

DEBUG1 - 11:26:04.535576 [3817/3823]: Apps with sock 27 added to poll set
(in thread_manage_apps() at main.c:1543)

DEBUG1 - 11:26:04.535747 [3817/3823]: Apps thread polling (in
thread_manage_apps() at main.c:1475)

DEBUG1 - 11:26:04.536027 [3817/3823]: Apps thread return from poll on 5 fds
(in thread_manage_apps() at main.c:1482)

DEBUG1 - 11:26:04.535701 [3817/3821]: Dispatching UST registration pid:3603
ppid:1 uid:0 gid:0 sock:35 name:sproc (version 5.0) (in
thread_dispatch_ust_registration() at main.c:1778)

DEBUG1 - 11:26:04.536284 [3817/3823]: Apps with sock 28 added to poll set
(in thread_manage_apps() at main.c:1543)

DEBUG3 - 11:26:04.536356 [3817/3821]: UST app notify socket 35 is set (in
thread_dispatch_ust_registration() at main.c:1835)

DEBUG1 - 11:26:04.536458 [3817/3823]: Apps thread polling (in
thread_manage_apps() at main.c:1475)

DEBUG1 - 11:26:04.536628 [3817/3821]: App registered with pid:3603 ppid:1
uid:0 gid:0 sock:31 name:sproc notify_sock:35 (version 5.0) (in
ust_app_add() at ust-app.c:3050)

DEBUG3 - 11:26:04.538103 [3817/3824]: [ust-thread] Manage notify return
from poll on 6 fds (in ust_thread_manage_notify() at ust-thread.c:74)

DEBUG3 - 11:26:04.538661 [3817/3824]: UST thread notify added sock 35 to
pollset (in ust_thread_manage_notify() at ust-thread.c:143)

DEBUG3 - 11:26:04.538851 [3817/3824]: [ust-thread] Manage notify polling
(in ust_thread_manage_notify() at ust-thread.c:67)

DEBUG1 - 11:26:04.539966 [3817/3821]: Woken up but nothing in the UST
command queue (in thread_dispatch_ust_registration() at main.c:1766)

DEBUG1 - 11:26:04.540471 [3817/3823]: Apps thread return from poll on 6 fds
(in thread_manage_apps() at main.c:1482)

DEBUG1 - 11:26:04.540550 [3817/3821]: Futex n to 1 wait done (in
futex_nto1_wait() at futex.c:90)

DEBUG1 - 11:26:04.540984 [3817/3823]: Apps with sock 31 added to poll set
(in thread_manage_apps() at main.c:1543)

DEBUG1 - 11:26:04.541128 [3817/3821]: Futex n to 1 prepare done (in
futex_nto1_prepare() at futex.c:75)

DEBUG1 - 11:26:04.541412 [3817/3821]: Woken up but nothing in the UST
command queue (in thread_dispatch_ust_registration() at main.c:1766)

DEBUG1 - 11:26:04.541218 [3817/3823]: Apps thread polling (in
thread_manage_apps() at main.c:1475)

--047d7b86d6cac6f1330512074c13
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>lttng sessiond launch is failing with followin=
g error.</div><div>can any please tell what could cause this?<br><div><br><=
/div><div><div>root@user:/usr/sbin# lttng-sessiond --consumerd32-path /usr/=
lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/ -b --no-ke=
rnel =C2=A0 =C2=A0=C2=A0</div><div>Warning: No tracing group detected</div>=
<div>I/O warning : failed to load external entity &quot;/usr/share/xml/lttn=
g/session.xsd&quot;</div><div>XML Error: Failed to locate the main schema r=
esource at &#39;/usr/share/xml/lttng/session.xsd&#39;.</div><div>Error: XSD=
 parsing failed</div><div>Error: Session load failed: Invalid session confi=
guration</div></div><div><br></div><div><br></div><div>here is the full log=
:</div><div><br></div><div>







<p class=3D"">root@user:/usr/sbin# lttng-sessiond --consumerd32-path /usr/l=
ib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/ -b --no-ker=
nel -vvv</p>
<p class=3D"">DEBUG3 - 11:25:59.917407 [3817/3817]: Creating LTTng run dire=
ctory: /var/run/lttng (in create_lttng_rundir() at main.c:4780)</p>
<p class=3D"">DEBUG2 - 11:25:59.918861 [3817/3817]: Kernel consumer err pat=
h: /var/run/lttng/kconsumerd/error (in main() at main.c:5172)</p>
<p class=3D"">DEBUG2 - 11:25:59.919062 [3817/3817]: Kernel consumer cmd pat=
h: /var/run/lttng/kconsumerd/command (in main() at main.c:5174)</p>
<p class=3D"">DEBUG1 - 11:25:59.919368 [3817/3817]: Client socket path /var=
/run/lttng/client-lttng-sessiond (in main() at main.c:5232)</p>
<p class=3D"">DEBUG1 - 11:25:59.919603 [3817/3817]: Application socket path=
 /var/run/lttng/lttng-ust-sock-5 (in main() at main.c:5233)</p>
<p class=3D"">DEBUG1 - 11:25:59.919782 [3817/3817]: Application wait path /=
lttng-ust-wait-5 (in main() at main.c:5234)</p>
<p class=3D"">DEBUG1 - 11:25:59.919917 [3817/3817]: LTTng run directory pat=
h: /var/run/lttng (in main() at main.c:5235)</p>
<p class=3D"">DEBUG2 - 11:25:59.920152 [3817/3817]: UST consumer 32 bits er=
r path: /var/run/lttng/ustconsumerd32/error (in main() at main.c:5244)</p>
<p class=3D"">DEBUG2 - 11:25:59.920292 [3817/3817]: UST consumer 32 bits cm=
d path: /var/run/lttng/ustconsumerd32/command (in main() at main.c:5246)</p=
>
<p class=3D"">DEBUG2 - 11:25:59.920535 [3817/3817]: UST consumer 64 bits er=
r path: /var/run/lttng/ustconsumerd64/error (in main() at main.c:5255)</p>
<p class=3D"">DEBUG2 - 11:25:59.920710 [3817/3817]: UST consumer 64 bits cm=
d path: /var/run/lttng/ustconsumerd64/command (in main() at main.c:5257)</p=
>
<p class=3D"">DEBUG3 - 11:25:59.921403 [3817/3817]: Created hashtable size =
4 at 0x100900b8 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG3 - 11:25:59.922239 [3817/3817]: Created hashtable size =
4 at 0x100903d0 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG3 - 11:25:59.922423 [3817/3817]: Created hashtable size =
4 at 0x100906f8 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG3 - 11:25:59.922602 [3817/3817]: Created hashtable size =
4 at 0x10090a20 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG2 - 11:25:59.922776 [3817/3817]: Creating consumer direc=
tory: /var/run/lttng/kconsumerd (in set_consumer_sockets() at main.c:4822)<=
/p>
<p class=3D"">Warning: No tracing group detected</p>
<p class=3D"">DEBUG2 - 11:25:59.930624 [3817/3817]: Creating consumer direc=
tory: /var/run/lttng/ustconsumerd64 (in set_consumer_sockets() at main.c:48=
22)</p>
<p class=3D"">DEBUG2 - 11:25:59.931652 [3817/3817]: Creating consumer direc=
tory: /var/run/lttng/ustconsumerd32 (in set_consumer_sockets() at main.c:48=
22)</p>
<p class=3D"">DEBUG3 - 11:25:59.933773 [3817/3817]: Session daemon client s=
ocket 9 and application socket 10 created (in init_daemon_socket() at main.=
c:4688)</p>
<p class=3D"">DEBUG1 - 11:25:59.934810 [3817/3817]: All permissions are set=
 (in set_permissions() at main.c:4768)</p>
<p class=3D"">DEBUG3 - 11:25:59.935071 [3817/3817]: Created hashtable size =
4 at 0x10092510 of type 2 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG3 - 11:25:59.935227 [3817/3817]: Global buffer per UID r=
egistry initialized (in buffer_reg_init_uid_registry() at buffer-registry.c=
:99)</p>
<p class=3D"">DEBUG3 - 11:25:59.935504 [3817/3817]: Created hashtable size =
4 at 0x10092838 of type 2 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG3 - 11:25:59.935646 [3817/3817]: Global buffer per PID r=
egistry initialized (in buffer_reg_init_pid_registry() at buffer-registry.c=
:220)</p>
<p class=3D"">DEBUG1 - 11:25:59.935974 [3817/3817]: epoll set max size is 2=
36120 (in compat_epoll_set_max_size() at compat-epoll.c:289)</p>
<p class=3D"">DEBUG1 - 11:25:59.936128 [3817/3817]: Command subsystem initi=
alized (in cmd_init() at cmd.c:3331)</p>
<p class=3D"">DEBUG1 - 11:25:59.936555 [3817/3817]: Pid 3817 written in fil=
e /var/run/lttng/lttng-sessiond.pid (in utils_create_pid_file() at utils.c:=
482)</p>
<p class=3D"">DEBUG1 - 11:25:59.936953 [3817/3817]: Pid 5345 written in fil=
e /var/run/lttng/agent.port (in utils_create_pid_file() at utils.c:482)</p>
<p class=3D"">DEBUG1 - 11:25:59.937223 [3817/3817]: TCP inet operation time=
out set to 216 sec (in lttcomm_inet_init() at inet.c:548)</p>
<p class=3D"">DEBUG1 - 11:25:59.937429 [3817/3817]: Health check time delta=
 in seconds set to 236 (in health_init() at health.c:73)</p>
<p class=3D"">DEBUG1 - 11:25:59.937750 [3817/3818]: [ht-thread] startup. (i=
n thread_ht_cleanup() at ht-cleanup.c:36)</p>
<p class=3D"">DEBUG1 - 11:25:59.937821 [3817/3819]: [thread] Manage health =
check started (in thread_manage_health() at main.c:3805)</p>
<p class=3D"">DEBUG1 - 11:25:59.938116 [3817/3822]: [thread] Manage applica=
tion registration started (in thread_registration_apps() at main.c:1967)</p=
>
<p class=3D"">DEBUG1 - 11:25:59.938129 [3817/3820]: [thread] Manage client =
started (in thread_manage_clients() at main.c:3996)</p>
<p class=3D"">DEBUG3 - 11:25:59.939523 [3817/3818]: [ht-thread] Polling. (i=
n thread_ht_cleanup() at ht-cleanup.c:63)</p>
<p class=3D"">DEBUG1 - 11:25:59.939762 [3817/3820]: Accepting client comman=
d ... (in thread_manage_clients() at main.c:4043)</p>
<p class=3D"">DEBUG1 - 11:25:59.940153 [3817/3822]: Notifying applications =
of session daemon state: 1 (in notify_ust_apps() at main.c:759)</p>
<p class=3D"">DEBUG1 - 11:25:59.938215 [3817/3823]: [thread] Manage applica=
tion started (in thread_manage_apps() at main.c:1445)</p>
<p class=3D"">DEBUG1 - 11:25:59.940837 [3817/3823]: Apps thread polling (in=
 thread_manage_apps() at main.c:1475)</p>
<p class=3D"">DEBUG1 - 11:25:59.938227 [3817/3821]: [thread] Dispatch UST c=
ommand started (in thread_dispatch_ust_registration() at main.c:1743)</p>
<p class=3D"">DEBUG1 - 11:25:59.940734 [3817/3819]: Health check ready (in =
thread_manage_health() at main.c:3870)</p>
<p class=3D"">DEBUG1 - 11:25:59.940937 [3817/3821]: Futex n to 1 prepare do=
ne (in futex_nto1_prepare() at futex.c:75)</p>
<p class=3D"">DEBUG1 - 11:25:59.941056 [3817/3821]: Woken up but nothing in=
 the UST command queue (in thread_dispatch_ust_registration() at main.c:176=
6)</p>
<p class=3D"">DEBUG1 - 11:25:59.941161 [3817/3826]: [load-session-thread] L=
oad session (in thread_load_session() at load-session-thread.c:91)</p>
<p class=3D"">DEBUG1 - 11:25:59.940739 [3817/3822]: Got the wait shm fd 21 =
(in get_wait_shm() at shm.c:115)</p>
<p class=3D"">DEBUG1 - 11:25:59.942324 [3817/3822]: Futex wait update activ=
e 1 (in futex_wait_update() at futex.c:63)</p>
<p class=3D"">DEBUG1 - 11:25:59.942367 [3817/3822]: Accepting application r=
egistration (in thread_registration_apps() at main.c:2004)</p>
<p class=3D"">DEBUG1 - 11:25:59.940772 [3817/3824]: [ust-thread] Manage app=
lication notify command (in ust_thread_manage_notify() at ust-thread.c:39)<=
/p>
<p class=3D"">DEBUG3 - 11:25:59.943390 [3817/3824]: [ust-thread] Manage not=
ify polling (in ust_thread_manage_notify() at ust-thread.c:67)</p>
<p class=3D"">DEBUG1 - 11:25:59.941799 [3817/3825]: [agent-thread] Manage a=
gent application registration. (in agent_thread_manage_registration() at ag=
ent-thread.c:282)</p>
<p class=3D"">DEBUG3 - 11:25:59.943917 [3817/3825]: URI string: tcp://local=
host (in uri_parse() at uri.c:293)</p>
<p class=3D"">DEBUG2 - 11:25:59.948001 [3817/3825]: IP address resolved to =
127.0.0.1 (in set_ip_address() at uri.c:134)</p>
<p class=3D"">DEBUG3 - 11:25:59.948298 [3817/3825]: URI dtype: 1, proto: 1,=
 host: localhost, subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:507)<=
/p>
<p class=3D"">DEBUG1 - 11:25:59.948694 [3817/3825]: [agent-thread] Listenin=
g on TCP port 5345 and socket 25 (in init_tcp_socket() at agent-thread.c:16=
5)</p>
<p class=3D"">DEBUG3 - 11:25:59.949009 [3817/3825]: [agent-thread] Manage a=
gent polling (in agent_thread_manage_registration() at agent-thread.c:309)<=
/p>
<p class=3D"">I/O warning : failed to load external entity &quot;/usr/share=
/xml/lttng/session.xsd&quot;</p>
<p class=3D"">XML Error: Failed to locate the main schema resource at &#39;=
/usr/share/xml/lttng/session.xsd&#39;.</p>
<p class=3D"">Error: XSD parsing failed</p>
<p class=3D"">Error: Session load failed: Invalid session configuration</p>
<p class=3D"">root@fpc0:/usr/sbin# DEBUG1 - 11:26:04.495062 [3817/3822]: US=
T registration received with pid:3064 ppid:1 uid:0 gid:0 sock:26 name:bcmd =
(version 5.0) (in thread_registration_apps() at main.c:2117)</p>
<p class=3D"">DEBUG1 - 11:26:04.495859 [3817/3822]: Futex n to 1 wake done =
(in futex_nto1_wake() at futex.c:104)</p>
<p class=3D"">DEBUG1 - 11:26:04.496041 [3817/3822]: Accepting application r=
egistration (in thread_registration_apps() at main.c:2004)</p>
<p class=3D"">DEBUG1 - 11:26:04.496551 [3817/3822]: UST registration receiv=
ed with pid:3067 ppid:1 uid:0 gid:0 sock:27 name:hwd-ptx-fpc (version 5.0) =
(in thread_registration_apps() at main.c:2117)</p>
<p class=3D"">DEBUG1 - 11:26:04.496676 [3817/3821]: Futex n to 1 wait done =
(in futex_nto1_wait() at futex.c:90)</p>
<p class=3D"">DEBUG1 - 11:26:04.497068 [3817/3821]: Futex n to 1 prepare do=
ne (in futex_nto1_prepare() at futex.c:75)</p>
<p class=3D"">DEBUG1 - 11:26:04.497271 [3817/3821]: Dispatching UST registr=
ation pid:3064 ppid:1 uid:0 gid:0 sock:26 name:bcmd (version 5.0) (in threa=
d_dispatch_ust_registration() at main.c:1778)</p>
<p class=3D"">DEBUG3 - 11:26:04.497556 [3817/3821]: UST app creating applic=
ation for socket 26 (in ust_app_create() at ust-app.c:2962)</p>
<p class=3D"">DEBUG3 - 11:26:04.497900 [3817/3821]: Created hashtable size =
4 at 0xb3f04170 of type 2 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG3 - 11:26:04.498151 [3817/3821]: Created hashtable size =
4 at 0xb3f03f80 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG1 - 11:26:04.498739 [3817/3821]: Dispatching UST registr=
ation pid:3067 ppid:1 uid:0 gid:0 sock:27 name:hwd-ptx-fpc (version 5.0) (i=
n thread_dispatch_ust_registration() at main.c:1778)</p>
<p class=3D"">DEBUG3 - 11:26:04.498991 [3817/3821]: UST app creating applic=
ation for socket 27 (in ust_app_create() at ust-app.c:2962)</p>
<p class=3D"">DEBUG3 - 11:26:04.499203 [3817/3821]: Created hashtable size =
4 at 0xb3f00a98 of type 2 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG3 - 11:26:04.499437 [3817/3821]: Created hashtable size =
4 at 0xb3f00d78 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG1 - 11:26:04.500628 [3817/3821]: Woken up but nothing in=
 the UST command queue (in thread_dispatch_ust_registration() at main.c:176=
6)</p>
<p class=3D"">DEBUG1 - 11:26:04.496801 [3817/3822]: Futex n to 1 wake done =
(in futex_nto1_wake() at futex.c:104)</p>
<p class=3D"">DEBUG1 - 11:26:04.504581 [3817/3822]: Accepting application r=
egistration (in thread_registration_apps() at main.c:2004)</p>
<p class=3D"">DEBUG1 - 11:26:04.505272 [3817/3822]: UST registration receiv=
ed with pid:3065 ppid:1 uid:0 gid:0 sock:28 name:cproc (version 5.0) (in th=
read_registration_apps() at main.c:2117)</p>
<p class=3D"">DEBUG1 - 11:26:04.505601 [3817/3822]: Futex n to 1 wake done =
(in futex_nto1_wake() at futex.c:104)</p>
<p class=3D"">DEBUG1 - 11:26:04.505762 [3817/3822]: Accepting application r=
egistration (in thread_registration_apps() at main.c:2004)</p>
<p class=3D"">DEBUG1 - 11:26:04.506260 [3817/3822]: UST registration receiv=
ed with pid:3066 ppid:1 uid:0 gid:0 sock:29 name:dist (version 5.0) (in thr=
ead_registration_apps() at main.c:2117)</p>
<p class=3D"">DEBUG1 - 11:26:04.506511 [3817/3822]: Futex n to 1 wake done =
(in futex_nto1_wake() at futex.c:104)</p>
<p class=3D"">DEBUG1 - 11:26:04.506633 [3817/3822]: Accepting application r=
egistration (in thread_registration_apps() at main.c:2004)</p>
<p class=3D"">DEBUG1 - 11:26:04.506957 [3817/3821]: Futex n to 1 wait done =
(in futex_nto1_wait() at futex.c:90)</p>
<p class=3D"">DEBUG1 - 11:26:04.507344 [3817/3821]: Futex n to 1 prepare do=
ne (in futex_nto1_prepare() at futex.c:75)</p>
<p class=3D"">DEBUG1 - 11:26:04.507868 [3817/3821]: Dispatching UST registr=
ation pid:3065 ppid:1 uid:0 gid:0 sock:28 name:cproc (version 5.0) (in thre=
ad_dispatch_ust_registration() at main.c:1778)</p>
<p class=3D"">DEBUG3 - 11:26:04.508174 [3817/3821]: UST app creating applic=
ation for socket 28 (in ust_app_create() at ust-app.c:2962)</p>
<p class=3D"">DEBUG3 - 11:26:04.508426 [3817/3821]: Created hashtable size =
4 at 0xb3f01200 of type 2 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG3 - 11:26:04.508659 [3817/3821]: Created hashtable size =
4 at 0xb3f012d8 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG1 - 11:26:04.509367 [3817/3821]: Dispatching UST registr=
ation pid:3066 ppid:1 uid:0 gid:0 sock:29 name:dist (version 5.0) (in threa=
d_dispatch_ust_registration() at main.c:1778)</p>
<p class=3D"">DEBUG1 - 11:26:04.507053 [3817/3822]: UST registration receiv=
ed with pid:3064 ppid:1 uid:0 gid:0 sock:30 name:bcmd (version 5.0) (in thr=
ead_registration_apps() at main.c:2117)</p>
<p class=3D"">DEBUG1 - 11:26:04.509865 [3817/3822]: Futex n to 1 wake done =
(in futex_nto1_wake() at futex.c:104)</p>
<p class=3D"">DEBUG1 - 11:26:04.510063 [3817/3822]: Accepting application r=
egistration (in thread_registration_apps() at main.c:2004)</p>
<p class=3D"">DEBUG3 - 11:26:04.509634 [3817/3821]: UST app creating applic=
ation for socket 29 (in ust_app_create() at ust-app.c:2962)</p>
<p class=3D"">DEBUG3 - 11:26:04.510472 [3817/3821]: Created hashtable size =
4 at 0xb3f04720 of type 2 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG1 - 11:26:04.510633 [3817/3822]: UST registration receiv=
ed with pid:3603 ppid:1 uid:0 gid:0 sock:31 name:sproc (version 5.0) (in th=
read_registration_apps() at main.c:2117)</p>
<p class=3D"">DEBUG3 - 11:26:04.510869 [3817/3821]: Created hashtable size =
4 at 0xb3f04a60 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG1 - 11:26:04.510937 [3817/3822]: Futex n to 1 wake done =
(in futex_nto1_wake() at futex.c:104)</p>
<p class=3D"">DEBUG1 - 11:26:04.511545 [3817/3822]: Accepting application r=
egistration (in thread_registration_apps() at main.c:2004)</p>
<p class=3D"">DEBUG1 - 11:26:04.511743 [3817/3821]: Dispatching UST registr=
ation pid:3064 ppid:1 uid:0 gid:0 sock:30 name:bcmd (version 5.0) (in threa=
d_dispatch_ust_registration() at main.c:1778)</p>
<p class=3D"">DEBUG3 - 11:26:04.512018 [3817/3821]: UST app notify socket 3=
0 is set (in thread_dispatch_ust_registration() at main.c:1835)</p>
<p class=3D"">DEBUG1 - 11:26:04.512018 [3817/3822]: UST registration receiv=
ed with pid:3066 ppid:1 uid:0 gid:0 sock:32 name:dist (version 5.0) (in thr=
ead_registration_apps() at main.c:2117)</p>
<p class=3D"">DEBUG1 - 11:26:04.512328 [3817/3822]: Futex n to 1 wake done =
(in futex_nto1_wake() at futex.c:104)</p>
<p class=3D"">DEBUG1 - 11:26:04.512459 [3817/3822]: Accepting application r=
egistration (in thread_registration_apps() at main.c:2004)</p>
<p class=3D"">DEBUG1 - 11:26:04.512800 [3817/3821]: App registered with pid=
:3064 ppid:1 uid:0 gid:0 sock:26 name:bcmd notify_sock:30 (version 5.0) (in=
 ust_app_add() at ust-app.c:3050)</p>
<p class=3D"">DEBUG1 - 11:26:04.512880 [3817/3822]: UST registration receiv=
ed with pid:3067 ppid:1 uid:0 gid:0 sock:33 name:hwd-ptx-fpc (version 5.0) =
(in thread_registration_apps() at main.c:2117)</p>
<p class=3D"">DEBUG1 - 11:26:04.513437 [3817/3822]: Futex n to 1 wake done =
(in futex_nto1_wake() at futex.c:104)</p>
<p class=3D"">DEBUG1 - 11:26:04.513639 [3817/3822]: Accepting application r=
egistration (in thread_registration_apps() at main.c:2004)</p>
<p class=3D"">DEBUG1 - 11:26:04.514697 [3817/3822]: UST registration receiv=
ed with pid:3065 ppid:1 uid:0 gid:0 sock:34 name:cproc (version 5.0) (in th=
read_registration_apps() at main.c:2117)</p>
<p class=3D"">DEBUG1 - 11:26:04.515051 [3817/3822]: Futex n to 1 wake done =
(in futex_nto1_wake() at futex.c:104)</p>
<p class=3D"">DEBUG1 - 11:26:04.515197 [3817/3822]: Accepting application r=
egistration (in thread_registration_apps() at main.c:2004)</p>
<p class=3D"">DEBUG1 - 11:26:04.515625 [3817/3822]: UST registration receiv=
ed with pid:3603 ppid:1 uid:0 gid:0 sock:35 name:sproc (version 5.0) (in th=
read_registration_apps() at main.c:2117)</p>
<p class=3D"">DEBUG1 - 11:26:04.515846 [3817/3822]: Futex n to 1 wake done =
(in futex_nto1_wake() at futex.c:104)</p>
<p class=3D"">DEBUG1 - 11:26:04.515965 [3817/3822]: Accepting application r=
egistration (in thread_registration_apps() at main.c:2004)</p>
<p class=3D"">DEBUG3 - 11:26:04.517407 [3817/3824]: [ust-thread] Manage not=
ify return from poll on 2 fds (in ust_thread_manage_notify() at ust-thread.=
c:74)</p>
<p class=3D"">DEBUG3 - 11:26:04.517913 [3817/3824]: UST thread notify added=
 sock 30 to pollset (in ust_thread_manage_notify() at ust-thread.c:143)</p>
<p class=3D"">DEBUG3 - 11:26:04.518106 [3817/3824]: [ust-thread] Manage not=
ify polling (in ust_thread_manage_notify() at ust-thread.c:67)</p>
<p class=3D"">DEBUG1 - 11:26:04.519777 [3817/3821]: Dispatching UST registr=
ation pid:3603 ppid:1 uid:0 gid:0 sock:31 name:sproc (version 5.0) (in thre=
ad_dispatch_ust_registration() at main.c:1778)</p>
<p class=3D"">DEBUG3 - 11:26:04.520156 [3817/3821]: UST app creating applic=
ation for socket 31 (in ust_app_create() at ust-app.c:2962)</p>
<p class=3D"">DEBUG3 - 11:26:04.520747 [3817/3821]: Created hashtable size =
4 at 0xb3f04ec8 of type 2 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG3 - 11:26:04.521037 [3817/3821]: Created hashtable size =
4 at 0xb3f051f0 of type 1 (in lttng_ht_new() at hashtable.c:127)</p>
<p class=3D"">DEBUG1 - 11:26:04.521555 [3817/3821]: Dispatching UST registr=
ation pid:3066 ppid:1 uid:0 gid:0 sock:32 name:dist (version 5.0) (in threa=
d_dispatch_ust_registration() at main.c:1778)</p>
<p class=3D"">DEBUG3 - 11:26:04.521921 [3817/3821]: UST app notify socket 3=
2 is set (in thread_dispatch_ust_registration() at main.c:1835)</p>
<p class=3D"">DEBUG1 - 11:26:04.522179 [3817/3821]: App registered with pid=
:3066 ppid:1 uid:0 gid:0 sock:29 name:dist notify_sock:32 (version 5.0) (in=
 ust_app_add() at ust-app.c:3050)</p>
<p class=3D"">DEBUG1 - 11:26:04.522314 [3817/3823]: Apps thread return from=
 poll on 2 fds (in thread_manage_apps() at main.c:1482)</p>
<p class=3D"">DEBUG1 - 11:26:04.522878 [3817/3823]: Apps with sock 26 added=
 to poll set (in thread_manage_apps() at main.c:1543)</p>
<p class=3D"">DEBUG1 - 11:26:04.523137 [3817/3823]: Apps thread polling (in=
 thread_manage_apps() at main.c:1475)</p>
<p class=3D"">DEBUG3 - 11:26:04.523723 [3817/3824]: [ust-thread] Manage not=
ify return from poll on 3 fds (in ust_thread_manage_notify() at ust-thread.=
c:74)</p>
<p class=3D"">DEBUG3 - 11:26:04.524132 [3817/3824]: UST thread notify added=
 sock 32 to pollset (in ust_thread_manage_notify() at ust-thread.c:143)</p>
<p class=3D"">DEBUG3 - 11:26:04.524304 [3817/3824]: [ust-thread] Manage not=
ify polling (in ust_thread_manage_notify() at ust-thread.c:67)</p>
<p class=3D"">DEBUG1 - 11:26:04.525500 [3817/3821]: Dispatching UST registr=
ation pid:3067 ppid:1 uid:0 gid:0 sock:33 name:hwd-ptx-fpc (version 5.0) (i=
n thread_dispatch_ust_registration() at main.c:1778)</p>
<p class=3D"">DEBUG3 - 11:26:04.525964 [3817/3821]: UST app notify socket 3=
3 is set (in thread_dispatch_ust_registration() at main.c:1835)</p>
<p class=3D"">DEBUG1 - 11:26:04.526186 [3817/3821]: App registered with pid=
:3067 ppid:1 uid:0 gid:0 sock:27 name:hwd-ptx-fpc notify_sock:33 (version 5=
.0) (in ust_app_add() at ust-app.c:3050)</p>
<p class=3D"">DEBUG1 - 11:26:04.528508 [3817/3823]: Apps thread return from=
 poll on 3 fds (in thread_manage_apps() at main.c:1482)</p>
<p class=3D"">DEBUG3 - 11:26:04.529255 [3817/3824]: [ust-thread] Manage not=
ify return from poll on 4 fds (in ust_thread_manage_notify() at ust-thread.=
c:74)</p>
<p class=3D"">DEBUG1 - 11:26:04.529379 [3817/3823]: Apps with sock 29 added=
 to poll set (in thread_manage_apps() at main.c:1543)</p>
<p class=3D"">DEBUG1 - 11:26:04.529997 [3817/3823]: Apps thread polling (in=
 thread_manage_apps() at main.c:1475)</p>
<p class=3D"">DEBUG3 - 11:26:04.529751 [3817/3824]: UST thread notify added=
 sock 33 to pollset (in ust_thread_manage_notify() at ust-thread.c:143)</p>
<p class=3D"">DEBUG3 - 11:26:04.530527 [3817/3824]: [ust-thread] Manage not=
ify polling (in ust_thread_manage_notify() at ust-thread.c:67)</p>
<p class=3D"">DEBUG1 - 11:26:04.531440 [3817/3821]: Dispatching UST registr=
ation pid:3065 ppid:1 uid:0 gid:0 sock:34 name:cproc (version 5.0) (in thre=
ad_dispatch_ust_registration() at main.c:1778)</p>
<p class=3D"">DEBUG3 - 11:26:04.531871 [3817/3821]: UST app notify socket 3=
4 is set (in thread_dispatch_ust_registration() at main.c:1835)</p>
<p class=3D"">DEBUG1 - 11:26:04.532133 [3817/3821]: App registered with pid=
:3065 ppid:1 uid:0 gid:0 sock:28 name:cproc notify_sock:34 (version 5.0) (i=
n ust_app_add() at ust-app.c:3050)</p>
<p class=3D"">DEBUG3 - 11:26:04.533795 [3817/3824]: [ust-thread] Manage not=
ify return from poll on 5 fds (in ust_thread_manage_notify() at ust-thread.=
c:74)</p>
<p class=3D"">DEBUG3 - 11:26:04.534239 [3817/3824]: UST thread notify added=
 sock 34 to pollset (in ust_thread_manage_notify() at ust-thread.c:143)</p>
<p class=3D"">DEBUG3 - 11:26:04.534423 [3817/3824]: [ust-thread] Manage not=
ify polling (in ust_thread_manage_notify() at ust-thread.c:67)</p>
<p class=3D"">DEBUG1 - 11:26:04.535142 [3817/3823]: Apps thread return from=
 poll on 4 fds (in thread_manage_apps() at main.c:1482)</p>
<p class=3D"">DEBUG1 - 11:26:04.535576 [3817/3823]: Apps with sock 27 added=
 to poll set (in thread_manage_apps() at main.c:1543)</p>
<p class=3D"">DEBUG1 - 11:26:04.535747 [3817/3823]: Apps thread polling (in=
 thread_manage_apps() at main.c:1475)</p>
<p class=3D"">DEBUG1 - 11:26:04.536027 [3817/3823]: Apps thread return from=
 poll on 5 fds (in thread_manage_apps() at main.c:1482)</p>
<p class=3D"">DEBUG1 - 11:26:04.535701 [3817/3821]: Dispatching UST registr=
ation pid:3603 ppid:1 uid:0 gid:0 sock:35 name:sproc (version 5.0) (in thre=
ad_dispatch_ust_registration() at main.c:1778)</p>
<p class=3D"">DEBUG1 - 11:26:04.536284 [3817/3823]: Apps with sock 28 added=
 to poll set (in thread_manage_apps() at main.c:1543)</p>
<p class=3D"">DEBUG3 - 11:26:04.536356 [3817/3821]: UST app notify socket 3=
5 is set (in thread_dispatch_ust_registration() at main.c:1835)</p>
<p class=3D"">DEBUG1 - 11:26:04.536458 [3817/3823]: Apps thread polling (in=
 thread_manage_apps() at main.c:1475)</p>
<p class=3D"">DEBUG1 - 11:26:04.536628 [3817/3821]: App registered with pid=
:3603 ppid:1 uid:0 gid:0 sock:31 name:sproc notify_sock:35 (version 5.0) (i=
n ust_app_add() at ust-app.c:3050)</p>
<p class=3D"">DEBUG3 - 11:26:04.538103 [3817/3824]: [ust-thread] Manage not=
ify return from poll on 6 fds (in ust_thread_manage_notify() at ust-thread.=
c:74)</p>
<p class=3D"">DEBUG3 - 11:26:04.538661 [3817/3824]: UST thread notify added=
 sock 35 to pollset (in ust_thread_manage_notify() at ust-thread.c:143)</p>
<p class=3D"">DEBUG3 - 11:26:04.538851 [3817/3824]: [ust-thread] Manage not=
ify polling (in ust_thread_manage_notify() at ust-thread.c:67)</p>
<p class=3D"">DEBUG1 - 11:26:04.539966 [3817/3821]: Woken up but nothing in=
 the UST command queue (in thread_dispatch_ust_registration() at main.c:176=
6)</p>
<p class=3D"">DEBUG1 - 11:26:04.540471 [3817/3823]: Apps thread return from=
 poll on 6 fds (in thread_manage_apps() at main.c:1482)</p>
<p class=3D"">DEBUG1 - 11:26:04.540550 [3817/3821]: Futex n to 1 wait done =
(in futex_nto1_wait() at futex.c:90)</p>
<p class=3D"">DEBUG1 - 11:26:04.540984 [3817/3823]: Apps with sock 31 added=
 to poll set (in thread_manage_apps() at main.c:1543)</p>
<p class=3D"">DEBUG1 - 11:26:04.541128 [3817/3821]: Futex n to 1 prepare do=
ne (in futex_nto1_prepare() at futex.c:75)</p>
<p class=3D"">DEBUG1 - 11:26:04.541412 [3817/3821]: Woken up but nothing in=
 the UST command queue (in thread_dispatch_ust_registration() at main.c:176=
6)</p>
<p class=3D"">DEBUG1 - 11:26:04.541218 [3817/3823]: Apps thread polling (in=
 thread_manage_apps() at main.c:1475)</p>
<p class=3D""><br></p></div></div></div>

--047d7b86d6cac6f1330512074c13--


--===============1329739072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1329739072==--
