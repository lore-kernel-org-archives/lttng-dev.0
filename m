From: abhishekk@uurmi.com
Subject: Re: Lttng trace showing empty result while doing lttng
	view
Date: Tue, 04 Apr 2017 10:12:35 +0530
Message-ID: <8b71bd568a9b9794d88fb99604eaa0143c90f49c__47129.3269926265$1491280984$gmane$org@mail.uurmi.com>
References: <20170403152024.GA9081@psrcode-TP-X230>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3274418572172742890=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpout.netcore.co.in (sm23714.nsmailserv.com [202.162.237.14])
 by lists.lttng.org (Postfix) with ESMTPS id 3vxxDZ2DS2zq8
 for <lttng-dev@lists.lttng.org>; Tue,  4 Apr 2017 04:43:09 +0000 (UTC)
in-reply-to: <20170403152024.GA9081@psrcode-TP-X230>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>, abhishekk@uurmi.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============3274418572172742890==
Content-Type: multipart/alternative;
 boundary="=_0705aed48d3e236ea86effb0bef7850e"

--=_0705aed48d3e236ea86effb0bef7850e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,=0A> Not sure I understand which version of lttng-modules you are=0Ac=
urrently using.=0A Sorry that was typo, I meant version 2.10 of lttng ke=
rnel modules and=0Aversion 2.5 of lttng tools. Please find the modinfo r=
esult below.=0Api@raspberrypi-BKe28DDGW7:~ $ modinfo lttng-tracer=0Afile=
name:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /lib/modules/4.4.44-v7+/extra/=
lttng-tracer.ko=0Aversion:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.1=
0.0-pre=0Adescription:=C2=A0=C2=A0=C2=A0 LTTng Events=0Aauthor:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Mathieu Desnoyers =0Alicense:=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPL and additional rights=0Asrcv=
ersion:=C2=A0=C2=A0=C2=A0=C2=A0 93F12D7CDB1873B93DF8BE4=0Adepends:=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=0Alttng-lib-ring-buffer,lttng-kretp=
robes,lttng-clock,lttng-kprobes,lttng-statedump,lttng-ftrace=0Avermagic:=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.4.44-v7+ SMP mod_unload modversio=
ns ARMv7=0A=C2=A0=0A >Can you share with us the result of 'modinfo lttng=
-tracer'?=0A >Could you pastebinit (or equivalent) the log produced by t=
he=0Alttng-sessiond in=0A >verbose mode (lttng-sessiond -vvv).=0Aplease=
 find below.=0API@RASPBERRYPI-BKE28DDGW7:~ $ SUDO LTTNG-SESSIOND -VVV=0A=
DEBUG3 - 04:41:38.701706 [1086/1086]: Creating LTTng run directory:=0A/v=
ar/run/lttng (in create_lttng_rundir() at main.c:4690)=0ADEBUG2 - 04:41:=
38.701861 [1086/1086]: Kernel consumer err path:=0A/var/run/lttng/kconsu=
merd/error (in main() at main.c:5078)=0ADEBUG2 - 04:41:38.701880 [1086/1=
086]: Kernel consumer cmd path:=0A/var/run/lttng/kconsumerd/command (in=
 main() at main.c:5080)=0ADEBUG1 - 04:41:38.701933 [1086/1086]: Client s=
ocket path=0A/var/run/lttng/client-lttng-sessiond (in main() at main.c:5=
138)=0ADEBUG1 - 04:41:38.701951 [1086/1086]: Application socket path=0A/=
var/run/lttng/lttng-ust-sock-5 (in main() at main.c:5139)=0ADEBUG1 - 04:=
41:38.701966 [1086/1086]: Application wait path=0A/lttng-ust-wait-5 (in=
 main() at main.c:5140)=0ADEBUG1 - 04:41:38.701981 [1086/1086]: LTTng ru=
n directory path:=0A/var/run/lttng (in main() at main.c:5141)=0ADEBUG2 -=
 04:41:38.702014 [1086/1086]: UST consumer 32 bits err path:=0A/var/run/=
lttng/ustconsumerd32/error (in main() at main.c:5150)=0ADEBUG2 - 04:41:3=
8.702030 [1086/1086]: UST consumer 32 bits cmd path:=0A/var/run/lttng/us=
tconsumerd32/command (in main() at main.c:5152)=0ADEBUG2 - 04:41:38.7020=
64 [1086/1086]: UST consumer 64 bits err path:=0A/var/run/lttng/ustconsu=
merd64/error (in main() at main.c:5161)=0ADEBUG2 - 04:41:38.702079 [1086=
/1086]: UST consumer 64 bits cmd path:=0A/var/run/lttng/ustconsumerd64/c=
ommand (in main() at main.c:5163)=0ADEBUG3 - 04:41:38.702338 [1086/1086]=
: Created hashtable size 4 at=0A0x550de0a0 of type 1 (in lttng_ht_new()=
 at hashtable.c:127)=0ADEBUG3 - 04:41:38.702363 [1086/1086]: Created has=
htable size 4 at=0A0x550de320 of type 1 (in lttng_ht_new() at hashtable.=
c:127)=0ADEBUG3 - 04:41:38.702383 [1086/1086]: Created hashtable size 4=
 at=0A0x550de500 of type 1 (in lttng_ht_new() at hashtable.c:127)=0ADEBU=
G3 - 04:41:38.702640 [1086/1086]: Created hashtable size 4 at=0A0x550de7=
08 of type 1 (in lttng_ht_new() at hashtable.c:127)=0ADEBUG2 - 04:41:38.=
702661 [1086/1086]: Creating consumer directory:=0A/var/run/lttng/kconsu=
merd (in set_consumer_sockets() at main.c:4732)=0ADEBUG1 - 04:41:38.7558=
59 [1086/1086]: Modprobe successfully=0Alttng-tracer (in modprobe_lttng(=
) at modprobe.c:190)=0ADEBUG1 - 04:41:38.761092 [1086/1086]: Modprobe su=
ccessfully=0Alttng-lib-ring-buffer (in modprobe_lttng() at modprobe.c:19=
0)=0ADEBUG1 - 04:41:38.771345 [1086/1086]: Modprobe successfully=0Alttng=
-ring-buffer-client-discard (in modprobe_lttng() at=0Amodprobe.c:190)=0A=
DEBUG1 - 04:41:38.781390 [1086/1086]: Modprobe successfully=0Alttng-ring=
-buffer-client-overwrite (in modprobe_lttng() at=0Amodprobe.c:190)=0ADEB=
UG1 - 04:41:38.791401 [1086/1086]: Modprobe successfully=0Alttng-ring-bu=
ffer-metadata-client (in modprobe_lttng() at=0Amodprobe.c:190)=0ADEBUG1=
 - 04:41:38.801943 [1086/1086]: Modprobe successfully=0Alttng-ring-buffe=
r-client-mmap-discard (in modprobe_lttng() at=0Amodprobe.c:190)=0ADEBUG1=
 - 04:41:38.811961 [1086/1086]: Modprobe successfully=0Alttng-ring-buffe=
r-client-mmap-overwrite (in modprobe_lttng() at=0Amodprobe.c:190)=0ADEBU=
G1 - 04:41:38.821920 [1086/1086]: Modprobe successfully=0Alttng-ring-buf=
fer-metadata-mmap-client (in modprobe_lttng() at=0Amodprobe.c:190)=0ADEB=
UG1 - 04:41:38.829615 [1086/1086]: Modprobe successfully=0Alttng-types (=
in modprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:38.834756 [1086/=
1086]: Modprobe successfully=0Alttng-ftrace (in modprobe_lttng() at modp=
robe.c:190)=0ADEBUG1 - 04:41:38.839917 [1086/1086]: Modprobe successfull=
y=0Alttng-kprobes (in modprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:=
41:38.845104 [1086/1086]: Modprobe successfully=0Alttng-kretprobes (in m=
odprobe_lttng() at modprobe.c:190)=0ADEBUG2 - 04:41:38.845198 [1086/1086=
]: Kernel tracer version validated=0A(major version 2) (in kernel_valida=
te_version() at kernel.c:701)=0ADEBUG1 - 04:41:38.853708 [1086/1086]: Mo=
dprobe successfully=0Alttng-probe-asoc (in modprobe_lttng() at modprobe.=
c:190)=0ADEBUG1 - 04:41:38.862249 [1086/1086]: Modprobe successfully=0Al=
ttng-probe-block (in modprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:4=
1:38.870416 [1086/1086]: Modprobe successfully=0Alttng-probe-btrfs (in m=
odprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:38.878920 [1086/1086=
]: Modprobe successfully=0Alttng-probe-compaction (in modprobe_lttng() a=
t modprobe.c:190)=0ADEBUG1 - 04:41:38.884270 [1086/1086]: Modprobe succe=
ssfully=0Alttng-probe-ext3 (in modprobe_lttng() at modprobe.c:190)=0ADEB=
UG1 - 04:41:38.892863 [1086/1086]: Modprobe successfully=0Alttng-probe-e=
xt4 (in modprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:38.901249 [=
1086/1086]: Modprobe successfully=0Alttng-probe-gpio (in modprobe_lttng(=
) at modprobe.c:190)=0ADEBUG1 - 04:41:38.909818 [1086/1086]: Modprobe su=
ccessfully=0Alttng-probe-irq (in modprobe_lttng() at modprobe.c:190)=0AD=
EBUG1 - 04:41:38.915031 [1086/1086]: Modprobe successfully=0Alttng-probe=
-jbd (in modprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:38.923627=
 [1086/1086]: Modprobe successfully=0Alttng-probe-jbd2 (in modprobe_lttn=
g() at modprobe.c:190)=0ADEBUG1 - 04:41:38.931509 [1086/1086]: Modprobe=
 successfully=0Alttng-probe-kmem (in modprobe_lttng() at modprobe.c:190)=
=0ADEBUG1 - 04:41:38.936862 [1086/1086]: Modprobe successfully=0Alttng-p=
robe-kvm (in modprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:38.942=
096 [1086/1086]: Modprobe successfully=0Alttng-probe-kvm-x86 (in modprob=
e_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:38.947239 [1086/1086]: Mod=
probe successfully=0Alttng-probe-kvm-x86-mmu (in modprobe_lttng() at mod=
probe.c:190)=0ADEBUG1 - 04:41:38.952458 [1086/1086]: Modprobe successful=
ly=0Alttng-probe-lock (in modprobe_lttng() at modprobe.c:190)=0ADEBUG1 -=
 04:41:38.961008 [1086/1086]: Modprobe successfully=0Alttng-probe-module=
 (in modprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:38.969459 [108=
6/1086]: Modprobe successfully=0Alttng-probe-napi (in modprobe_lttng() a=
t modprobe.c:190)=0ADEBUG1 - 04:41:38.978036 [1086/1086]: Modprobe succe=
ssfully=0Alttng-probe-net (in modprobe_lttng() at modprobe.c:190)=0ADEBU=
G1 - 04:41:38.986109 [1086/1086]: Modprobe successfully=0Alttng-probe-po=
wer (in modprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:38.994188 [=
1086/1086]: Modprobe successfully=0Alttng-probe-printk (in modprobe_lttn=
g() at modprobe.c:190)=0ADEBUG1 - 04:41:39.216487 [1086/1086]: Modprobe=
 successfully=0Alttng-probe-random (in modprobe_lttng() at modprobe.c:19=
0)=0ADEBUG1 - 04:41:39.107144 [1086/1086]: Modprobe successfully=0Alttng=
-probe-rcu (in modprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:39.1=
92769 [1086/1086]: Modprobe successfully=0Alttng-probe-regmap (in modpro=
be_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:39.245820 [1086/1086]: Mo=
dprobe successfully=0Alttng-probe-regulator (in modprobe_lttng() at modp=
robe.c:190)=0ADEBUG1 - 04:41:39.297071 [1086/1086]: Modprobe successfull=
y=0Alttng-probe-rpm (in modprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 0=
4:41:39.377675 [1086/1086]: Modprobe successfully=0Alttng-probe-sched (i=
n modprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:39.458216 [1086/1=
086]: Modprobe successfully=0Alttng-probe-scsi (in modprobe_lttng() at m=
odprobe.c:190)=0ADEBUG1 - 04:41:39.543405 [1086/1086]: Modprobe successf=
ully=0Alttng-probe-signal (in modprobe_lttng() at modprobe.c:190)=0ADEBU=
G1 - 04:41:39.627664 [1086/1086]: Modprobe successfully=0Alttng-probe-sk=
b (in modprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:39.708022 [10=
86/1086]: Modprobe successfully=0Alttng-probe-sock (in modprobe_lttng()=
 at modprobe.c:190)=0ADEBUG1 - 04:41:39.787606 [1086/1086]: Modprobe suc=
cessfully=0Alttng-probe-statedump (in modprobe_lttng() at modprobe.c:190=
)=0ADEBUG1 - 04:41:39.868531 [1086/1086]: Modprobe successfully=0Alttng-=
probe-sunrpc (in modprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:39=
953995 [1086/1086]: Modprobe successfully=0Alttng-probe-timer (in modpr=
obe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:39.104008 [1086/1086]: M=
odprobe successfully=0Alttng-probe-udp (in modprobe_lttng() at modprobe.=
c:190)=0ADEBUG1 - 04:41:39.112143 [1086/1086]: Modprobe successfully=0Al=
ttng-probe-vmscan (in modprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:=
41:39.120207 [1086/1086]: Modprobe successfully=0Alttng-probe-v4l2 (in m=
odprobe_lttng() at modprobe.c:190)=0ADEBUG1 - 04:41:39.128172 [1086/1086=
]: Modprobe successfully=0Alttng-probe-workqueue (in modprobe_lttng() at=
 modprobe.c:190)=0ADEBUG1 - 04:41:39.136462 [1086/1086]: Modprobe succes=
sfully=0Alttng-probe-writeback (in modprobe_lttng() at modprobe.c:190)=
=0ADEBUG1 - 04:41:39.136534 [1086/1086]: Kernel tracer fd 7 (in=0Ainit_k=
ernel_tracer() at main.c:2535)=0ADEBUG2 - 04:41:39.136566 [1086/1086]: C=
reating consumer directory:=0A/var/run/lttng/ustconsumerd64 (in set_cons=
umer_sockets() at=0Amain.c:4732)=0ADEBUG2 - 04:41:39.136838 [1086/1086]:=
 Creating consumer directory:=0A/var/run/lttng/ustconsumerd32 (in set_co=
nsumer_sockets() at=0Amain.c:4732)=0ADEBUG3 - 04:41:39.137038 [1086/1086=
]: Session daemon client socket 10=0Aand application socket 11 created (=
in init_daemon_socket() at=0Amain.c:4598)=0ADEBUG1 - 04:41:39.137166 [10=
86/1086]: All permissions are set (in=0Aset_permissions() at main.c:4678=
)=0ADEBUG3 - 04:41:39.137228 [1086/1086]: Created hashtable size 4 at=0A=
0x550e0048 of type 2 (in lttng_ht_new() at hashtable.c:127)=0ADEBUG3 - 0=
4:41:39.137248 [1086/1086]: Global buffer per UID registry=0Ainitialized=
 (in buffer_reg_init_uid_registry() at=0Abuffer-registry.c:99)=0ADEBUG3=
 - 04:41:39.137267 [1086/1086]: Created hashtable size 4 at=0A0x550e0270=
 of type 2 (in lttng_ht_new() at hashtable.c:127)=0ADEBUG3 - 04:41:39.13=
7283 [1086/1086]: Global buffer per PID registry=0Ainitialized (in buffe=
r_reg_init_pid_registry() at=0Abuffer-registry.c:220)=0ADEBUG1 - 04:41:3=
9.137335 [1086/1086]: epoll set max size is 311472 (in=0Acompat_epoll_se=
t_max_size() at compat-epoll.c:290)=0ADEBUG1 - 04:41:39.137357 [1086/108=
6]: Command subsystem initialized=0A(in cmd_init() at cmd.c:3227)=0ADEBU=
G1 - 04:41:39.137456 [1086/1086]: Pid 1086 written in file=0A/var/run/lt=
tng/lttng-sessiond.pid (in utils_create_pid_file() at=0Autils.c:467)=0AD=
EBUG1 - 04:41:39.137549 [1086/1086]: Pid 5345 written in file=0A/var/run=
/lttng/jul.port (in utils_create_pid_file() at utils.c:467)=0ADEBUG1 - 0=
4:41:39.137620 [1086/1086]: TCP inet operation timeout set=0Ato 216 sec=
 (in lttcomm_inet_init() at inet.c:529)=0ADEBUG1 - 04:41:39.137643 [1086=
/1086]: Health check time delta in=0Aseconds set to 236 (in health_init(=
) at health.c:73)=0ADEBUG1 - 04:41:39.137844 [1086/1188]: [ht-thread] st=
artup. (in=0Athread_ht_cleanup() at ht-cleanup.c:36)=0ADEBUG1 - 04:41:39=
137916 [1086/1190]: [thread] Manage client started=0A(in thread_manage_=
clients() at main.c:3948)=0ADEBUG1 - 04:41:39.138137 [1086/1190]: Accept=
ing client command ... (in=0Athread_manage_clients() at main.c:3995)=0AD=
EBUG1 - 04:41:39.138253 [1086/1193]: [thread] Manage application=0Astart=
ed (in thread_manage_apps() at main.c:1425)=0ADEBUG1 - 04:41:39.138319 [=
1086/1194]: [ust-thread] Manage application=0Anotify command (in ust_thr=
ead_manage_notify() at ust-thread.c:39)=0ADEBUG1 - 04:41:39.138038 [1086=
/1191]: [thread] Dispatch UST command=0Astarted (in thread_dispatch_ust_=
registration() at main.c:1711)=0ADEBUG1 - 04:41:39.138788 [1086/1191]: F=
utex n to 1 prepare done (in=0Afutex_nto1_prepare() at futex.c:75)=0ADEB=
UG1 - 04:41:39.138968 [1086/1191]: Woken up but nothing in the UST=0Acom=
mand queue (in thread_dispatch_ust_registration() at main.c:1734)=0ADEBU=
G1 - 04:41:39.138185 [1086/1192]: [thread] Manage application=0Aregistra=
tion started (in thread_registration_apps() at main.c:1935)=0ADEBUG3 - 0=
4:41:39.138202 [1086/1188]: [ht-thread] Polling on 2 fds.=0A(in thread_h=
t_cleanup() at ht-cleanup.c:64)=0ADEBUG3 - 04:41:39.138566 [1086/1194]:=
 [ust-thread] Manage notify=0Apolling on 2 fds (in ust_thread_manage_not=
ify() at ust-thread.c:68)=0ADEBUG1 - 04:41:39.138586 [1086/1193]: Apps t=
hread polling on 2 fds (in=0Athread_manage_apps() at main.c:1455)=0ADEBU=
G1 - 04:41:39.138603 [1086/1195]: [jul-thread] Manage JUL=0Aapplication=
 registration. (in jul_thread_manage_registration() at=0Ajul-thread.c:26=
0)=0ADEBUG3 - 04:41:39.139593 [1086/1195]: URI string: tcp://localhost (=
in=0Auri_parse() at uri.c:293)=0ADEBUG1 - 04:41:39.139744 [1086/1192]: N=
otifying applications of=0Asession daemon state: 1 (in notify_ust_apps()=
 at main.c:756)=0ADEBUG1 - 04:41:39.140036 [1086/1192]: Got the wait shm=
 fd 26 (in=0Aget_wait_shm() at shm.c:115)=0ADEBUG1 - 04:41:39.140255 [10=
86/1192]: Futex wait update active 1 (in=0Afutex_wait_update() at futex.=
c:63)=0ADEBUG1 - 04:41:39.140442 [1086/1192]: Accepting application=0Are=
gistration (in thread_registration_apps() at main.c:1972)=0ADEBUG1 - 04:=
41:39.137859 [1086/1189]: [thread] Manage health check=0Astarted (in thr=
ead_manage_health() at main.c:3762)=0ADEBUG2 - 04:41:39.140418 [1086/119=
5]: IP address resolved to 127.0.0.1=0A(in set_ip_address() at uri.c:134=
)=0ADEBUG3 - 04:41:39.140884 [1086/1195]: URI dtype: 1, proto: 1, host:=
=0Alocalhost, subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:507)=
=0ADEBUG1 - 04:41:39.140941 [1086/1195]: [jul-thread] Listening on TCP=
=0Aport 5345 and socket 27 (in init_tcp_socket() at jul-thread.c:158)=0A=
DEBUG3 - 04:41:39.141006 [1086/1195]: [jul-thread] Manage JUL polling=0A=
on 2 fds (in jul_thread_manage_registration() at jul-thread.c:288)=0ADEB=
UG1 - 04:41:39.138615 [1086/1196]: [thread] Thread manage kernel=0Astart=
ed (in thread_manage_kernel() at main.c:957)=0ADEBUG1 - 04:41:39.141147=
 [1086/1196]: Updating kernel poll set (in=0Aupdate_kernel_poll() at mai=
n.c:817)=0ADEBUG1 - 04:41:39.141166 [1086/1196]: Thread kernel polling o=
n 2 fds=0A(in thread_manage_kernel() at main.c:1002)=0ADEBUG1 - 04:41:39=
138664 [1086/1197]: [load-session-thread] Load=0Asession (in thread_loa=
d_session() at load-session-thread.c:90)=0ADEBUG1 - 04:41:39.141624 [108=
6/1189]: Health check ready (in=0Athread_manage_health() at main.c:3827)=
=0AI/O warning : failed to load external entity=0A"/usr/share/xml/lttng/=
session.xsd"=0AXML Error: Failed to locate the main schema resource at=
=0A'/usr/share/xml/lttng/session.xsd'.=0AError: XSD parsing failed=0AErr=
or: Session load failed: Invalid session configuration=0A=0AThanks & Reg=
ards=0AAbhishek Kumar=0A7801078513 =0A=0A----- Original Message -----=0A=
From: "Jonathan Rajotte-Julien" =0ATo:=0ACc:=0ASent:Mon, 3 Apr 2017 11:2=
0:24 -0400=0ASubject:Re: [lttng-dev] Lttng trace showing empty result wh=
ile doing=0Alttng view=0A=0A On Mon, Apr 03, 2017 at 11:56:57AM +0530, a=
bhishekk@uurmi.com wrote:=0A > =0A > =0A > I am trying to trace raspberr=
y (I am using raspberry 3 B ) Linux=0A > kernel by using lttng. The prob=
lem i am facing is after the=0Asuccessful=0A > completion of running fol=
lowing commands i am not able to see=0Atracing=0A > result. It seems tra=
cing file is empty. 1. lltng create mysession=0A > =0A > 2. lttng enable=
-event -a -k =0A > =0A > 3. lttng start =0A > =0A > 4 lttng stop 5=0A >=
 =0A > . lttng view=0A > =0A > Note:- I am not facing any error while ru=
nning above command and=0A > kernel tracing file is generated at proper=
 path. And I am not=0Afacing=0A > this problem when i am tracing for use=
r space application. =0A > =0A > I am using version 2.9 of kernel module=
s and version 2.5 of lttng=0A > modules.Kernel modules are loaded i can=
 see using lsmod. =0A=0A Not sure I understand which version of lttng-mo=
dules you are=0Acurrently using.=0A=0A Can you share with us the result=
 of 'modinfo lttng-tracer'?=0A Could you pastebinit (or equivalent) the=
 log produced by the=0Alttng-sessiond in=0A verbose mode (lttng-sessiond=
 -vvv).=0A=0A Please take a look at the bug reporting guidelines [1].=0A=
=0A Cheers=0A=0A [1] http://lttng.org/community/#bug-reporting-guideline=
s=0A=0A > Thanks & Regards=0A > Abhishek Kumar=0A > 7801078513 =0A > =0A=
 > -------------------------=0A > Email sent using E-interact Webmail=0A=
=0A > _______________________________________________=0A > lttng-dev mai=
ling list=0A > lttng-dev@lists.lttng.org=0A > https://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev=0A=0A -- =0A Jonathan Rajotte-Julien=0A=
 EfficiOS=0A=0A-------------------------=0AEmail sent using E-interact W=
ebmail

--=_0705aed48d3e236ea86effb0bef7850e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-=
serif; font-size: 12px;">Hi,<br />&gt; Not sure I understand which versi=
on of lttng-modules you are currently using.<br />=0ASorry that was typo=
, I meant version 2.10 of lttng kernel modules and version 2.5 of lttng=
 tools. Please find the modinfo result below.<br />pi@raspberrypi-BKe28D=
DGW7:~ $ modinfo lttng-tracer<br />filename:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /lib/modules/4.4.44-v7+/extra/lttng-tracer.ko<br />version:=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.10.0-pre<br />description:=C2=
=A0=C2=A0=C2=A0 LTTng Events<br />author:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&=
gt;<br />license:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPL and addi=
tional rights<br />srcversion:=C2=A0=C2=A0=C2=A0=C2=A0 93F12D7CDB1873B93=
DF8BE4<br />depends:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lttng-lib=
-ring-buffer,lttng-kretprobes,lttng-clock,lttng-kprobes,lttng-statedump,=
lttng-ftrace<br />vermagic:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.4.44-v=
7+ SMP mod_unload modversions ARMv7<br />=C2=A0<br />=0A&gt;Can you shar=
e with us the result of 'modinfo lttng-tracer'?<br />=0A&gt;Could you pa=
stebinit (or equivalent) the log produced by the lttng-sessiond in<br />=
=0A&gt;verbose mode (lttng-sessiond -vvv).<br />please find below.<br />=
<b>pi@raspberrypi-BKe28DDGW7:~ $ sudo lttng-sessiond -vvv</b><br />DEBUG=
3 - 04:41:38.701706 [1086/1086]: Creating LTTng run directory: /var/run/=
lttng (in create_lttng_rundir() at main.c:4690)<br />DEBUG2 - 04:41:38.7=
01861 [1086/1086]: Kernel consumer err path: /var/run/lttng/kconsumerd/e=
rror (in main() at main.c:5078)<br />DEBUG2 - 04:41:38.701880 [1086/1086=
]: Kernel consumer cmd path: /var/run/lttng/kconsumerd/command (in main(=
) at main.c:5080)<br />DEBUG1 - 04:41:38.701933 [1086/1086]: Client sock=
et path /var/run/lttng/client-lttng-sessiond (in main() at main.c:5138)<=
br />DEBUG1 - 04:41:38.701951 [1086/1086]: Application socket path /var/=
run/lttng/lttng-ust-sock-5 (in main() at main.c:5139)<br />DEBUG1 - 04:4=
1:38.701966 [1086/1086]: Application wait path /lttng-ust-wait-5 (in mai=
n() at main.c:5140)<br />DEBUG1 - 04:41:38.701981 [1086/1086]: LTTng run=
 directory path: /var/run/lttng (in main() at main.c:5141)<br />DEBUG2 -=
 04:41:38.702014 [1086/1086]: UST consumer 32 bits err path: /var/run/lt=
tng/ustconsumerd32/error (in main() at main.c:5150)<br />DEBUG2 - 04:41:=
38.702030 [1086/1086]: UST consumer 32 bits cmd path: /var/run/lttng/ust=
consumerd32/command (in main() at main.c:5152)<br />DEBUG2 - 04:41:38.70=
2064 [1086/1086]: UST consumer 64 bits err path: /var/run/lttng/ustconsu=
merd64/error (in main() at main.c:5161)<br />DEBUG2 - 04:41:38.702079 [1=
086/1086]: UST consumer 64 bits cmd path: /var/run/lttng/ustconsumerd64/=
command (in main() at main.c:5163)<br />DEBUG3 - 04:41:38.702338 [1086/1=
086]: Created hashtable size 4 at 0x550de0a0 of type 1 (in lttng_ht_new(=
) at hashtable.c:127)<br />DEBUG3 - 04:41:38.702363 [1086/1086]: Created=
 hashtable size 4 at 0x550de320 of type 1 (in lttng_ht_new() at hashtabl=
e.c:127)<br />DEBUG3 - 04:41:38.702383 [1086/1086]: Created hashtable si=
ze 4 at 0x550de500 of type 1 (in lttng_ht_new() at hashtable.c:127)<br /=
>DEBUG3 - 04:41:38.702640 [1086/1086]: Created hashtable size 4 at 0x550=
de708 of type 1 (in lttng_ht_new() at hashtable.c:127)<br />DEBUG2 - 04:=
41:38.702661 [1086/1086]: Creating consumer directory: /var/run/lttng/kc=
onsumerd (in set_consumer_sockets() at main.c:4732)<br />DEBUG1 - 04:41:=
38.755859 [1086/1086]: Modprobe successfully lttng-tracer (in modprobe_l=
ttng() at modprobe.c:190)<br />DEBUG1 - 04:41:38.761092 [1086/1086]: Mod=
probe successfully lttng-lib-ring-buffer (in modprobe_lttng() at modprob=
e.c:190)<br />DEBUG1 - 04:41:38.771345 [1086/1086]: Modprobe successfull=
y lttng-ring-buffer-client-discard (in modprobe_lttng() at modprobe.c:19=
0)<br />DEBUG1 - 04:41:38.781390 [1086/1086]: Modprobe successfully lttn=
g-ring-buffer-client-overwrite (in modprobe_lttng() at modprobe.c:190)<b=
r />DEBUG1 - 04:41:38.791401 [1086/1086]: Modprobe successfully lttng-ri=
ng-buffer-metadata-client (in modprobe_lttng() at modprobe.c:190)<br />D=
EBUG1 - 04:41:38.801943 [1086/1086]: Modprobe successfully lttng-ring-bu=
ffer-client-mmap-discard (in modprobe_lttng() at modprobe.c:190)<br />DE=
BUG1 - 04:41:38.811961 [1086/1086]: Modprobe successfully lttng-ring-buf=
fer-client-mmap-overwrite (in modprobe_lttng() at modprobe.c:190)<br />D=
EBUG1 - 04:41:38.821920 [1086/1086]: Modprobe successfully lttng-ring-bu=
ffer-metadata-mmap-client (in modprobe_lttng() at modprobe.c:190)<br />D=
EBUG1 - 04:41:38.829615 [1086/1086]: Modprobe successfully lttng-types (=
in modprobe_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:38.834756 [10=
86/1086]: Modprobe successfully lttng-ftrace (in modprobe_lttng() at mod=
probe.c:190)<br />DEBUG1 - 04:41:38.839917 [1086/1086]: Modprobe success=
fully lttng-kprobes (in modprobe_lttng() at modprobe.c:190)<br />DEBUG1=
 - 04:41:38.845104 [1086/1086]: Modprobe successfully lttng-kretprobes (=
in modprobe_lttng() at modprobe.c:190)<br />DEBUG2 - 04:41:38.845198 [10=
86/1086]: Kernel tracer version validated (major version 2) (in kernel_v=
alidate_version() at kernel.c:701)<br />DEBUG1 - 04:41:38.853708 [1086/1=
086]: Modprobe successfully lttng-probe-asoc (in modprobe_lttng() at mod=
probe.c:190)<br />DEBUG1 - 04:41:38.862249 [1086/1086]: Modprobe success=
fully lttng-probe-block (in modprobe_lttng() at modprobe.c:190)<br />DEB=
UG1 - 04:41:38.870416 [1086/1086]: Modprobe successfully lttng-probe-btr=
fs (in modprobe_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:38.878920=
 [1086/1086]: Modprobe successfully lttng-probe-compaction (in modprobe_=
lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:38.884270 [1086/1086]: Mo=
dprobe successfully lttng-probe-ext3 (in modprobe_lttng() at modprobe.c:=
190)<br />DEBUG1 - 04:41:38.892863 [1086/1086]: Modprobe successfully lt=
tng-probe-ext4 (in modprobe_lttng() at modprobe.c:190)<br />DEBUG1 - 04:=
41:38.901249 [1086/1086]: Modprobe successfully lttng-probe-gpio (in mod=
probe_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:38.909818 [1086/108=
6]: Modprobe successfully lttng-probe-irq (in modprobe_lttng() at modpro=
be.c:190)<br />DEBUG1 - 04:41:38.915031 [1086/1086]: Modprobe successful=
ly lttng-probe-jbd (in modprobe_lttng() at modprobe.c:190)<br />DEBUG1 -=
 04:41:38.923627 [1086/1086]: Modprobe successfully lttng-probe-jbd2 (in=
 modprobe_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:38.931509 [1086=
/1086]: Modprobe successfully lttng-probe-kmem (in modprobe_lttng() at m=
odprobe.c:190)<br />DEBUG1 - 04:41:38.936862 [1086/1086]: Modprobe succe=
ssfully lttng-probe-kvm (in modprobe_lttng() at modprobe.c:190)<br />DEB=
UG1 - 04:41:38.942096 [1086/1086]: Modprobe successfully lttng-probe-kvm=
-x86 (in modprobe_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:38.9472=
39 [1086/1086]: Modprobe successfully lttng-probe-kvm-x86-mmu (in modpro=
be_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:38.952458 [1086/1086]:=
 Modprobe successfully lttng-probe-lock (in modprobe_lttng() at modprobe=
c:190)<br />DEBUG1 - 04:41:38.961008 [1086/1086]: Modprobe successfully=
 lttng-probe-module (in modprobe_lttng() at modprobe.c:190)<br />DEBUG1=
 - 04:41:38.969459 [1086/1086]: Modprobe successfully lttng-probe-napi (=
in modprobe_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:38.978036 [10=
86/1086]: Modprobe successfully lttng-probe-net (in modprobe_lttng() at=
 modprobe.c:190)<br />DEBUG1 - 04:41:38.986109 [1086/1086]: Modprobe suc=
cessfully lttng-probe-power (in modprobe_lttng() at modprobe.c:190)<br /=
>DEBUG1 - 04:41:38.994188 [1086/1086]: Modprobe successfully lttng-probe=
-printk (in modprobe_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:39.2=
16487 [1086/1086]: Modprobe successfully lttng-probe-random (in modprobe=
_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:39.107144 [1086/1086]: M=
odprobe successfully lttng-probe-rcu (in modprobe_lttng() at modprobe.c:=
190)<br />DEBUG1 - 04:41:39.192769 [1086/1086]: Modprobe successfully lt=
tng-probe-regmap (in modprobe_lttng() at modprobe.c:190)<br />DEBUG1 - 0=
4:41:39.245820 [1086/1086]: Modprobe successfully lttng-probe-regulator=
 (in modprobe_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:39.297071 [=
1086/1086]: Modprobe successfully lttng-probe-rpm (in modprobe_lttng() a=
t modprobe.c:190)<br />DEBUG1 - 04:41:39.377675 [1086/1086]: Modprobe su=
ccessfully lttng-probe-sched (in modprobe_lttng() at modprobe.c:190)<br=
 />DEBUG1 - 04:41:39.458216 [1086/1086]: Modprobe successfully lttng-pro=
be-scsi (in modprobe_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:39.5=
43405 [1086/1086]: Modprobe successfully lttng-probe-signal (in modprobe=
_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:39.627664 [1086/1086]: M=
odprobe successfully lttng-probe-skb (in modprobe_lttng() at modprobe.c:=
190)<br />DEBUG1 - 04:41:39.708022 [1086/1086]: Modprobe successfully lt=
tng-probe-sock (in modprobe_lttng() at modprobe.c:190)<br />DEBUG1 - 04:=
41:39.787606 [1086/1086]: Modprobe successfully lttng-probe-statedump (i=
n modprobe_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:39.868531 [108=
6/1086]: Modprobe successfully lttng-probe-sunrpc (in modprobe_lttng() a=
t modprobe.c:190)<br />DEBUG1 - 04:41:39.953995 [1086/1086]: Modprobe su=
ccessfully lttng-probe-timer (in modprobe_lttng() at modprobe.c:190)<br=
 />DEBUG1 - 04:41:39.104008 [1086/1086]: Modprobe successfully lttng-pro=
be-udp (in modprobe_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:39.11=
2143 [1086/1086]: Modprobe successfully lttng-probe-vmscan (in modprobe_=
lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:39.120207 [1086/1086]: Mo=
dprobe successfully lttng-probe-v4l2 (in modprobe_lttng() at modprobe.c:=
190)<br />DEBUG1 - 04:41:39.128172 [1086/1086]: Modprobe successfully lt=
tng-probe-workqueue (in modprobe_lttng() at modprobe.c:190)<br />DEBUG1=
 - 04:41:39.136462 [1086/1086]: Modprobe successfully lttng-probe-writeb=
ack (in modprobe_lttng() at modprobe.c:190)<br />DEBUG1 - 04:41:39.13653=
4 [1086/1086]: Kernel tracer fd 7 (in init_kernel_tracer() at main.c:253=
5)<br />DEBUG2 - 04:41:39.136566 [1086/1086]: Creating consumer director=
y: /var/run/lttng/ustconsumerd64 (in set_consumer_sockets() at main.c:47=
32)<br />DEBUG2 - 04:41:39.136838 [1086/1086]: Creating consumer directo=
ry: /var/run/lttng/ustconsumerd32 (in set_consumer_sockets() at main.c:4=
732)<br />DEBUG3 - 04:41:39.137038 [1086/1086]: Session daemon client so=
cket 10 and application socket 11 created (in init_daemon_socket() at ma=
in.c:4598)<br />DEBUG1 - 04:41:39.137166 [1086/1086]: All permissions ar=
e set (in set_permissions() at main.c:4678)<br />DEBUG3 - 04:41:39.13722=
8 [1086/1086]: Created hashtable size 4 at 0x550e0048 of type 2 (in lttn=
g_ht_new() at hashtable.c:127)<br />DEBUG3 - 04:41:39.137248 [1086/1086]=
: Global buffer per UID registry initialized (in buffer_reg_init_uid_reg=
istry() at buffer-registry.c:99)<br />DEBUG3 - 04:41:39.137267 [1086/108=
6]: Created hashtable size 4 at 0x550e0270 of type 2 (in lttng_ht_new()=
 at hashtable.c:127)<br />DEBUG3 - 04:41:39.137283 [1086/1086]: Global b=
uffer per PID registry initialized (in buffer_reg_init_pid_registry() at=
 buffer-registry.c:220)<br />DEBUG1 - 04:41:39.137335 [1086/1086]: epoll=
 set max size is 311472 (in compat_epoll_set_max_size() at compat-epoll.=
c:290)<br />DEBUG1 - 04:41:39.137357 [1086/1086]: Command subsystem init=
ialized (in cmd_init() at cmd.c:3227)<br />DEBUG1 - 04:41:39.137456 [108=
6/1086]: Pid 1086 written in file /var/run/lttng/lttng-sessiond.pid (in=
 utils_create_pid_file() at utils.c:467)<br />DEBUG1 - 04:41:39.137549 [=
1086/1086]: Pid 5345 written in file /var/run/lttng/jul.port (in utils_c=
reate_pid_file() at utils.c:467)<br />DEBUG1 - 04:41:39.137620 [1086/108=
6]: TCP inet operation timeout set to 216 sec (in lttcomm_inet_init() at=
 inet.c:529)<br />DEBUG1 - 04:41:39.137643 [1086/1086]: Health check tim=
e delta in seconds set to 236 (in health_init() at health.c:73)<br />DEB=
UG1 - 04:41:39.137844 [1086/1188]: [ht-thread] startup. (in thread_ht_cl=
eanup() at ht-cleanup.c:36)<br />DEBUG1 - 04:41:39.137916 [1086/1190]: [=
thread] Manage client started (in thread_manage_clients() at main.c:3948=
)<br />DEBUG1 - 04:41:39.138137 [1086/1190]: Accepting client command ..=
 (in thread_manage_clients() at main.c:3995)<br />DEBUG1 - 04:41:39.138=
253 [1086/1193]: [thread] Manage application started (in thread_manage_a=
pps() at main.c:1425)<br />DEBUG1 - 04:41:39.138319 [1086/1194]: [ust-th=
read] Manage application notify command (in ust_thread_manage_notify() a=
t ust-thread.c:39)<br />DEBUG1 - 04:41:39.138038 [1086/1191]: [thread] D=
ispatch UST command started (in thread_dispatch_ust_registration() at ma=
in.c:1711)<br />DEBUG1 - 04:41:39.138788 [1086/1191]: Futex n to 1 prepa=
re done (in futex_nto1_prepare() at futex.c:75)<br />DEBUG1 - 04:41:39.1=
38968 [1086/1191]: Woken up but nothing in the UST command queue (in thr=
ead_dispatch_ust_registration() at main.c:1734)<br />DEBUG1 - 04:41:39.1=
38185 [1086/1192]: [thread] Manage application registration started (in=
 thread_registration_apps() at main.c:1935)<br />DEBUG3 - 04:41:39.13820=
2 [1086/1188]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup() at=
 ht-cleanup.c:64)<br />DEBUG3 - 04:41:39.138566 [1086/1194]: [ust-thread=
] Manage notify polling on 2 fds (in ust_thread_manage_notify() at ust-t=
hread.c:68)<br />DEBUG1 - 04:41:39.138586 [1086/1193]: Apps thread polli=
ng on 2 fds (in thread_manage_apps() at main.c:1455)<br />DEBUG1 - 04:41=
:39.138603 [1086/1195]: [jul-thread] Manage JUL application registration=
 (in jul_thread_manage_registration() at jul-thread.c:260)<br />DEBUG3=
 - 04:41:39.139593 [1086/1195]: URI string: tcp://localhost (in uri_pars=
e() at uri.c:293)<br />DEBUG1 - 04:41:39.139744 [1086/1192]: Notifying a=
pplications of session daemon state: 1 (in notify_ust_apps() at main.c:7=
56)<br />DEBUG1 - 04:41:39.140036 [1086/1192]: Got the wait shm fd 26 (i=
n get_wait_shm() at shm.c:115)<br />DEBUG1 - 04:41:39.140255 [1086/1192]=
: Futex wait update active 1 (in futex_wait_update() at futex.c:63)<br /=
>DEBUG1 - 04:41:39.140442 [1086/1192]: Accepting application registratio=
n (in thread_registration_apps() at main.c:1972)<br />DEBUG1 - 04:41:39.=
137859 [1086/1189]: [thread] Manage health check started (in thread_mana=
ge_health() at main.c:3762)<br />DEBUG2 - 04:41:39.140418 [1086/1195]: I=
P address resolved to 127.0.0.1 (in set_ip_address() at uri.c:134)<br />=
DEBUG3 - 04:41:39.140884 [1086/1195]: URI dtype: 1, proto: 1, host: loca=
lhost, subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:507)<br />DEB=
UG1 - 04:41:39.140941 [1086/1195]: [jul-thread] Listening on TCP port 53=
45 and socket 27 (in init_tcp_socket() at jul-thread.c:158)<br />DEBUG3=
 - 04:41:39.141006 [1086/1195]: [jul-thread] Manage JUL polling on 2 fds=
 (in jul_thread_manage_registration() at jul-thread.c:288)<br />DEBUG1 -=
 04:41:39.138615 [1086/1196]: [thread] Thread manage kernel started (in=
 thread_manage_kernel() at main.c:957)<br />DEBUG1 - 04:41:39.141147 [10=
86/1196]: Updating kernel poll set (in update_kernel_poll() at main.c:81=
7)<br />DEBUG1 - 04:41:39.141166 [1086/1196]: Thread kernel polling on 2=
 fds (in thread_manage_kernel() at main.c:1002)<br />DEBUG1 - 04:41:39.1=
38664 [1086/1197]: [load-session-thread] Load session (in thread_load_se=
ssion() at load-session-thread.c:90)<br />DEBUG1 - 04:41:39.141624 [1086=
/1189]: Health check ready (in thread_manage_health() at main.c:3827)<br=
 /><b>I/O warning : failed to load external entity "/usr/share/xml/lttng=
/session.xsd"<br />XML Error: Failed to locate the main schema resource=
 at '/usr/share/xml/lttng/session.xsd'.<br />Error: XSD parsing failed<b=
r />Error: Session load failed: Invalid session configuration</b><br /><=
br />Thanks &amp; Regards<br />Abhishek Kumar<br />7801078513 <br /><br=
 /><blockquote><br />----- Original Message -----<br /><div style=3D"wid=
th:100%;background:rgb(228,228,228);"><div style=3D"font-weight:bold;">F=
rom:</div> "Jonathan Rajotte-Julien" &lt;jonathan.rajotte-julien@efficio=
s.com&gt;</div><br /><div style=3D"font-weight:bold;">To:</div>&lt;abhis=
hekk@uurmi.com&gt;<br /><div style=3D"font-weight:bold;">Cc:</div>&lt;lt=
tng-dev@lists.lttng.org&gt;<br /><div style=3D"font-weight:bold;">Sent:<=
/div>Mon, 3 Apr 2017 11:20:24 -0400<br /><div style=3D"font-weight:bold;=
">Subject:</div>Re: [lttng-dev] Lttng trace showing empty result while d=
oing lttng view<br /><br /><br />=0AOn Mon, Apr 03, 2017 at 11:56:57AM +=
0530, abhishekk@uurmi.com wrote:<br />=0A&gt;  <br />=0A&gt; <br />=0A&g=
t; =09I am trying to trace raspberry (I am using raspberry 3 B ) Linux<b=
r />=0A&gt; kernel by using lttng. The problem i am facing is after the=
 successful<br />=0A&gt; completion of running following commands i am n=
ot able to see tracing<br />=0A&gt; result. It seems tracing file is emp=
ty. 1. lltng create mysession<br />=0A&gt; <br />=0A&gt; =09 2. lttng en=
able-event -a -k <br />=0A&gt; <br />=0A&gt; =093. lttng start <br />=0A=
&gt; <br />=0A&gt; =094 lttng stop 5<br />=0A&gt; <br />=0A&gt; =09. ltt=
ng view<br />=0A&gt; <br />=0A&gt; =09 Note:- I am not facing any error=
 while running above command and<br />=0A&gt; kernel tracing file is gen=
erated at proper path. And I am not facing<br />=0A&gt; this problem whe=
n i am tracing for user space application.  <br />=0A&gt; <br />=0A&gt;=
 =09I am using version 2.9 of kernel modules and version 2.5 of lttng<br=
 />=0A&gt; modules.Kernel modules are loaded i can see using lsmod.  <br=
 /><br />=0ANot sure I understand which version of lttng-modules you are=
 currently using.<br /><br />=0ACan you share with us the result of 'mod=
info lttng-tracer'?<br />=0ACould you pastebinit (or equivalent) the log=
 produced by the lttng-sessiond in<br />=0Averbose mode (lttng-sessiond=
 -vvv).<br /><br />=0APlease take a look at the bug reporting guidelines=
 [1].<br /><br />=0ACheers<br /><br />=0A[1] http://lttng.org/community/=
#bug-reporting-guidelines<br /><br />=0A&gt; Thanks &amp; Regards<br />=
=0A&gt; Abhishek Kumar<br />=0A&gt; 7801078513 <br />=0A&gt; <br />=0A&g=
t; -------------------------<br />=0A&gt; Email sent using E-interact We=
bmail<br /><br />=0A&gt; _______________________________________________=
<br />=0A&gt; lttng-dev mailing list<br />=0A&gt; lttng-dev@lists.lttng.=
org<br />=0A&gt; https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev<br /><br /><br />=0A-- <br />=0AJonathan Rajotte-Julien<br />=0AEffi=
ciOS<br /></blockquote><hr>Email sent using E-interact Webmail</body></h=
tml>

--=_0705aed48d3e236ea86effb0bef7850e--


--===============3274418572172742890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3274418572172742890==--
