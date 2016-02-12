From: Prashanth Raghavendra <prashanth.raghavendra@gmail.com>
Subject: lttng-sessiond stuck at "Accepting application
	registration"
Date: Fri, 12 Feb 2016 19:27:50 +0530
Message-ID: <CAEQ5q2Ec=Q-zcQXBx9QQ5oyDKEwxNgqVqiatdf=y79ubn6J7gg__9812.76411698691$1455294675$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0544024041=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prashanth.raghavendra@gmail.com>) id 1aUEEO-0000wz-Oe
 for lttng-dev@lists.lttng.org; Fri, 12 Feb 2016 08:57:59 -0500
Received: by mail-wm0-f45.google.com with SMTP id g62so20621656wme.0
 for <lttng-dev@lists.lttng.org>; Fri, 12 Feb 2016 05:57:56 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: aditya dogra <dogra.aditya@gmail.com>
List-Id: lttng-dev@lists.lttng.org

--===============0544024041==
Content-Type: multipart/alternative; boundary=001a114b7e0c89f08f052b930d16

--001a114b7e0c89f08f052b930d16
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Greetings,

We are trying to use lttng for tracing our application code (userspace).

Host OS:  WR5.0.1.13 Linux
Lttng-tools version 2.1.0, 32-bit  (lttng: ELF 32-bit LSB executable, Intel
80386)
Babeltrace version 1.0.0

Logged in as root.



When we start the lttng-sessiond, it gets stuck at "Accepting application
registration=E2=80=9D.

Linux(debug)# /isan/lib/lttng-sessiond -vvv --no-kernel
DEBUG3: Creating LTTng run directory: /var/run/lttng [in
create_lttng_rundir() at main.c:3683]
DEBUG2: Kernel consumer err path: /var/run/lttng/kconsumerd/error [in
main() at main.c:3931]
DEBUG2: Kernel consumer cmd path: /var/run/lttng/kconsumerd/command [in
main() at main.c:3933]
DEBUG1: Client socket path /var/run/lttng/client-lttng-sessiond [in main()
at main.c:3986]
DEBUG1: Application socket path /var/run/lttng/apps-lttng-sessiond [in
main() at main.c:3987]
DEBUG1: LTTng run directory path: /var/run/lttng [in main() at main.c:3988]
DEBUG2: UST consumer 32 bits err path: /var/run/lttng/ustconsumerd32/error
[in main() at main.c:3997]
DEBUG2: UST consumer 32 bits cmd path:
/var/run/lttng/ustconsumerd32/command [in main() at main.c:3999]
DEBUG2: UST consumer 64 bits err path: /var/run/lttng/ustconsumerd64/error
[in main() at main.c:4008]
DEBUG2: UST consumer 64 bits cmd path:
/var/run/lttng/ustconsumerd64/command [in main() at main.c:4010]
DEBUG3: Created hashtable size 4 at 0x88d7080 of type 1 [in lttng_ht_new()
at hashtable.c:96]
DEBUG3: Created hashtable size 4 at 0x88d7370 of type 1 [in lttng_ht_new()
at hashtable.c:96]
DEBUG2: Creating consumer directory: /var/run/lttng/kconsumerd [in
set_consumer_sockets() at main.c:3725]
DEBUG2: Creating consumer directory: /var/run/lttng/ustconsumerd64 [in
set_consumer_sockets() at main.c:3725]
DEBUG2: Creating consumer directory: /var/run/lttng/ustconsumerd32 [in
set_consumer_sockets() at main.c:3725]
DEBUG1: Signal handler set for SIGTERM, SIGPIPE and SIGINT [in
set_signal_handler() at main.c:3817]
DEBUG3: Session daemon client socket 8 and application socket 9 created [in
init_daemon_socket() at main.c:3587]
Warning: No tracing group detected
DEBUG1: epoll set max size is 3243642 [in compat_epoll_set_max_size() at
compat-epoll.c:224]
DEBUG1: Command subsystem initialized [in cmd_init() at cmd.c:2423]
DEBUG1: [thread] Manage health check started [in thread_manage_health() at
main.c:2944]
DEBUG1: [thread] Manage client started [in thread_manage_clients() at
main.c:3138]
DEBUG1: [thread] Dispatch UST command started [in
thread_dispatch_ust_registration() at main.c:1295]
DEBUG1: Futex n to 1 prepare done [in futex_nto1_prepare() at futex.c:75]
DEBUG1: Woken up but nothing in the UST command queue [in
thread_dispatch_ust_registration() at main.c:1305]
DEBUG1: [thread] Manage application registration started [in
thread_registration_apps() at main.c:1371]
DEBUG1: [thread] Manage application started [in thread_manage_apps() at
main.c:1101]
DEBUG1: Health check ready [in thread_manage_health() at main.c:2983]
DEBUG1: Accepting client command ... [in thread_manage_clients() at
main.c:3182]
DEBUG1: Notifying applications of session daemon state: 1 [in
notify_ust_apps() at main.c:496]
DEBUG1: Apps thread polling on 2 fds [in thread_manage_apps() at
main.c:1134]
DEBUG1: Got the wait shm fd 16 [in get_wait_shm() at shm.c:117]
DEBUG1: Futex wait update active 1 [in futex_wait_update() at futex.c:63]
DEBUG1: Accepting application registration [in thread_registration_apps()
at main.c:1406]  =3D=3D=3D=C3=A8 Remain struck here



Because of this, we suspect that the traces from our application are not
getting generated. And we get error when we run lttng view:
(lttng enable-event, start etc went through fine)

Linux(debug)# lttng stop
Waiting for data availability
Warning: Tracing already stopped for session auto-20160211-133851
Linux(debug)# lttng view
Trace directory: /home/

[error] Cannot open any trace for reading.

[error] opening trace =E2=80=9C/home/" for reading.

[error] none of the specified trace paths could be opened.



Please help us in fixing this issue.

Thank you.




Best Regards,

Prashanth Raghavendra
Aditya Dogra

--001a114b7e0c89f08f052b930d16
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Greetings,<br><br>We are trying to use lttng for tracing o=
ur application code (userspace).<br><br>Host OS:=C2=A0 WR5.0.1.13 Linux<br>=
Lttng-tools version 2.1.0, 32-bit=C2=A0 (lttng: ELF 32-bit LSB executable, =
Intel 80386)<br>Babeltrace version 1.0.0<br><br>Logged in as root.<br><br><=
br><br>When we start the lttng-sessiond, it gets stuck at &quot;Accepting a=
pplication registration=E2=80=9D.<br><br>Linux(debug)# /isan/lib/lttng-sess=
iond -vvv --no-kernel<br>DEBUG3: Creating LTTng run directory: /var/run/ltt=
ng [in create_lttng_rundir() at main.c:3683]<br>DEBUG2: Kernel consumer err=
 path: /var/run/lttng/kconsumerd/error [in main() at main.c:3931]<br>DEBUG2=
: Kernel consumer cmd path: /var/run/lttng/kconsumerd/command [in main() at=
 main.c:3933]<br>DEBUG1: Client socket path /var/run/lttng/client-lttng-ses=
siond [in main() at main.c:3986]<br>DEBUG1: Application socket path /var/ru=
n/lttng/apps-lttng-sessiond [in main() at main.c:3987]<br>DEBUG1: LTTng run=
 directory path: /var/run/lttng [in main() at main.c:3988]<br>DEBUG2: UST c=
onsumer 32 bits err path: /var/run/lttng/ustconsumerd32/error [in main() at=
 main.c:3997]<br>DEBUG2: UST consumer 32 bits cmd path: /var/run/lttng/ustc=
onsumerd32/command [in main() at main.c:3999]<br>DEBUG2: UST consumer 64 bi=
ts err path: /var/run/lttng/ustconsumerd64/error [in main() at main.c:4008]=
<br>DEBUG2: UST consumer 64 bits cmd path: /var/run/lttng/ustconsumerd64/co=
mmand [in main() at main.c:4010]<br>DEBUG3: Created hashtable size 4 at 0x8=
8d7080 of type 1 [in lttng_ht_new() at hashtable.c:96]<br>DEBUG3: Created h=
ashtable size 4 at 0x88d7370 of type 1 [in lttng_ht_new() at hashtable.c:96=
]<br>DEBUG2: Creating consumer directory: /var/run/lttng/kconsumerd [in set=
_consumer_sockets() at main.c:3725]<br>DEBUG2: Creating consumer directory:=
 /var/run/lttng/ustconsumerd64 [in set_consumer_sockets() at main.c:3725]<b=
r>DEBUG2: Creating consumer directory: /var/run/lttng/ustconsumerd32 [in se=
t_consumer_sockets() at main.c:3725]<br>DEBUG1: Signal handler set for SIGT=
ERM, SIGPIPE and SIGINT [in set_signal_handler() at main.c:3817]<br>DEBUG3:=
 Session daemon client socket 8 and application socket 9 created [in init_d=
aemon_socket() at main.c:3587]<br>Warning: No tracing group detected<br>DEB=
UG1: epoll set max size is 3243642 [in compat_epoll_set_max_size() at compa=
t-epoll.c:224]<br>DEBUG1: Command subsystem initialized [in cmd_init() at c=
md.c:2423]<br>DEBUG1: [thread] Manage health check started [in thread_manag=
e_health() at main.c:2944]<br>DEBUG1: [thread] Manage client started [in th=
read_manage_clients() at main.c:3138]<br>DEBUG1: [thread] Dispatch UST comm=
and started [in thread_dispatch_ust_registration() at main.c:1295]<br>DEBUG=
1: Futex n to 1 prepare done [in futex_nto1_prepare() at futex.c:75]<br>DEB=
UG1: Woken up but nothing in the UST command queue [in thread_dispatch_ust_=
registration() at main.c:1305]<br>DEBUG1: [thread] Manage application regis=
tration started [in thread_registration_apps() at main.c:1371]<br>DEBUG1: [=
thread] Manage application started [in thread_manage_apps() at main.c:1101]=
<br>DEBUG1: Health check ready [in thread_manage_health() at main.c:2983]<b=
r>DEBUG1: Accepting client command ... [in thread_manage_clients() at main.=
c:3182]<br>DEBUG1: Notifying applications of session daemon state: 1 [in no=
tify_ust_apps() at main.c:496]<br>DEBUG1: Apps thread polling on 2 fds [in =
thread_manage_apps() at main.c:1134]<br>DEBUG1: Got the wait shm fd 16 [in =
get_wait_shm() at shm.c:117]<br>DEBUG1: Futex wait update active 1 [in fute=
x_wait_update() at futex.c:63]<br>DEBUG1: Accepting application registratio=
n [in thread_registration_apps() at main.c:1406]=C2=A0 =3D=3D=3D=C3=A8 Rema=
in struck here<br>=C2=A0<br>=C2=A0<br><br>Because of this, we suspect that =
the traces from our application are not getting generated. And we get error=
 when we run lttng view:<br>(lttng enable-event, start etc went through fin=
e)<br><br>Linux(debug)# lttng stop<br>Waiting for data availability<br>Warn=
ing: Tracing already stopped for session auto-20160211-133851<br>Linux(debu=
g)# lttng view<br>Trace directory: /home/<br>=C2=A0<br>[error] Cannot open =
any trace for reading.<br>=C2=A0<br>[error] opening trace =E2=80=9C/home/&q=
uot; for reading.<br>=C2=A0<br>[error] none of the specified trace paths co=
uld be opened.<br>=C2=A0<br><br><br>Please help us in fixing this issue.<br=
><br>Thank you.<br><br><br><br><br>Best Regards,<br><br>Prashanth Raghavend=
ra<br>Aditya Dogra<br><br><br><br><br></div>

--001a114b7e0c89f08f052b930d16--


--===============0544024041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0544024041==--
