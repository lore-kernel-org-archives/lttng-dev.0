From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?b?562U5aSN77ya562U5aSN77yaIFVTVCBwZXJmb3Jt?=
	=?utf-8?q?ance?=
Date: Wed, 29 Apr 2015 11:39:08 +0800
Message-ID: <4c5c1841-8fdb-48b1-bdc3-e33e813314d2__9436.69195189632$1430278833$gmane$org@aliyun.com>
References: <2d399e36-59c3-4648-8b13-53a4b36b68de@aliyun.com> <",
 1778982370.39421.1430236058233.JavaMail.zimbra"@efficios.com>
 <5896be5a-83a3-4179-b07d-e5c855210bb7@aliyun.com>,
 95067142.40057.1430274312545.JavaMail.zimbra@efficios.com
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2073002541=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-316.freemail.mail.aliyun.com ([110.75.46.16])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <zhenyu.ren@aliyun.com>) id 1YnIqU-00062z-97
 for lttng-dev@lists.lttng.org; Tue, 28 Apr 2015 23:39:38 -0400
In-Reply-To: 95067142.40057.1430274312545.JavaMail.zimbra@efficios.com
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2073002541==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_24048_43fef940_5540525c_19d1b"

------=ALIBOUNDARY_24048_43fef940_5540525c_19d1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oh,My mistake. I am not using -O2 (I copied the Makefile from lttng-ust-2.6.0/=
doc/examples/easy-ust/Makefile :) ). When compiled with -O2, I get a 0.454us/e=
vent(10M events total=C2=A04548921074 ns).>Did you define _LGPL_SOURCE at the =
top of both files ? (the code and the probe provider)=C2=A0 Yes,I did define i=
t all of the files(provider(.h/.c) and sample.c)=0A>I see that in the numbers =
you provided in your earlier email, you talk about "us" (microseconds), did yo=
u actually mean "ns" (nanoseconds) ?=C2=A0 Yes,I use "us", say=C2=A0 0.554us ,=
 0.28us, 0.5us and the latest 0.454us . If use "ns",they are 554ns, 280ns,500n=
s,454ns ,it seems no mistake here=E3=80=82My CPU is=C2=A02 x Xeon E5-2420 =C2=A0=
1.90GHz , OS: RHEL6,2.6.32-220=C2=A0Maybe the fact my ust event slower than yo=
urs is due to the CPU ability,I am not sure about that. Does you perf report s=
how something like=C2=A0 native_write_msr_safe?Thankszhenyu.ren---------------=
---------------------------------------------------=E5=8F=91=E4=BB=B6=E4=BA=BA=
=EF=BC=9AMathieu Desnoyers <mathieu.desnoyers@efficios.com>=E5=8F=91=E9=80=81=E6=
=97=B6=E9=97=B4=EF=BC=9A2015=E5=B9=B44=E6=9C=8829=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=
=B8=89) 10:25=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren <zhenyu.ren@aliyun=
.com>=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Alttng-dev <lttng-dev@lists.lttng.org>=
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: =E7=AD=94=E5=A4=8D=EF=BC=9A[lttng-dev]=
 UST performance=0AHi,Mathieu=0A> Is your sched_getcpu() system call a vdso to=
o=0A=C2=A0 =C2=A0I use=C2=A0VSYSCALL_ADDR(__NR_vgetcpu) instead sched_getcpu s=
o there is no getcpu system calls.=0A> make sure you #define _LGPL_SOURCE in y=
our benchmark program=0A=C2=A0 =C2=A0I do it as you suggested but no differenc=
e.=0A=0A> Then, you can try using "perf" to profile the runtime execution=C2=A0=
=0A$~/renzhyu/perf record ./sample=0AWARNING: Kernel address maps (/proc/{kall=
syms,modules}) are restricted,=0Acheck /proc/sys/kernel/kptr_restrict.=0A=0ASa=
mples in kernel functions may not be resolved if a suitable vmlinux=0Afile is =
not found in the buildid cache or in the vmlinux path.=0A=0ASamples in kernel =
modules won't be resolved at all.=0A=0AIf some relocation was applied (e.g. ke=
xec) symbols may be misresolved=0Aeven with a suitable vmlinux or kallsyms fil=
e.=0A=0A=0Ausing 5720094251 ns=0A[ perf record: Woken up 1 times to write data=
 ]=0A[ perf record: Captured and wrote 0.221 MB perf.data (~9658 samples) ]=0A=
=0A=0A$~/renzhyu/perf report=0AEvents: 5K cycles=0A16.82% sample liblttng-ust.=
so.0.0.0 [.] lttng_event_commit10.55% sample liblttng-ust.so.0.0.0 [.] lttng_e=
vent_strcpy10.45% sample [kernel.kallsyms] [k] 0xffffffff8103548a8.16% sample =
liblttng-ust.so.0.0.0 [.] lttng_event_reserve7.57% sample sample [.] __event_g=
et_size__sample_component___message6.42% sample sample [.] __event_probe__samp=
le_component___message6.24% sample liblttng-ust.so.0.0.0 [.] lttng_write_event=
_header5.40% sample sample [.] _rcu_read_lock_update5.35% sample sample [.] _r=
cu_read_unlock_bp5.17% sample liburcu-bp.so.2.0.0 [.] rcu_read_unlock_bp4.14% =
sample ld-2.5.so [.] __tls_get_addr3.38% sample [vdso] [.] 0x7fff8f72e6be3.35%=
 sample sample [.] main1.88% sample sample [.] lib_ring_buffer_ctx_init1.79% s=
ample sample [.] _rcu_read_lock_bp1.20% sample liburcu-bp.so.2.0.0 [.] rcu_rea=
d_lock_bp0.66% sample sample [.] lib_ring_buffer_align_ctx0.38% sample sample =
[.] cds_list_empty0.37% sample sample [.] lib_ring_buffer_align0.35% sample li=
burcu-bp.so.2.0.0 [.] __tls_get_addr@plt0.28% sample sample [.] __event_get_al=
ign__sample_component___message0.09% sample ld-2.5.so [.] do_lookup_Did you co=
mpile your program and the probe provider=0A(tp.c) with -O2 ?=0A=0ADid you def=
ine _LGPL_SOURCE at the top of both files ?=0A(the code and the probe provider=
)=0A=0AI tried your sample.c program here:=0A=0ACPU:=0AIntel(R) Core(TM) i7-46=
00U CPU @ 2.10GHzThis is within a virtual machine.=0A=0AAnd I get 302 ns/event=
 (total: 3019987815ns exec time)=0A=0AI see that in the numbers you provided i=
n your earlier email,=0Ayou talk about "us" (microseconds), did you actually m=
ean"ns" (nanoseconds) ?=0A=0AI enabled tracing this way:=0A=0Alttng create --s=
napshot=0Alttng enable-event -u -a=0Alttng start=0A=0AThoughts ?=0A=0AThanks,=0A=
=0AMathieu=0AThe symbol=C2=A0 0xffffffff8103548a is in=C2=A0native_write_msr_s=
afe,I don't know what the function is and why that kernel function can be TOP =
3.ffffffff81035480 <native_write_msr_safe>:=0Affffffff81035480: 55 push %rbp=0A=
ffffffff81035481: 89 f9 mov %edi,%ecx=0Affffffff81035483: 89 f0 mov %esi,%eax=0A=
ffffffff81035485: 48 89 e5 mov %rsp,%rbp=0Affffffff81035488: 0f 30 wrmsr=0Afff=
fffff8103548a: 31 c0 xor %eax,%eax=0Affffffff8103548c: c9 leaveq=0Affffffff810=
3548d: c3 retq=0Affffffff8103548e: 66 90 xchg %ax,%ax=0APS:my sample.c=0A#incl=
ude <time.h>=0A#include <unistd.h>=0A#include <stdio.h>=0A#define _LGPL_SOURCE=
=0A#define TRACEPOINT_DEFINE=0A#include "sample_component_provider.h"=0A=0A#de=
fine NUM 10000000=0Aint main(int argc, char **argv)=0A{=0A int i =3D 0;=0A str=
uct timespec bef,aft;=0A long diff;=0A clock_gettime(CLOCK_MONOTONIC,&bef);=0A=
 for (i =3D 0; i < NUM; i++) {=0Atracepoint(sample_component, message, "HelloW=
orld");=0A }=0A clock_gettime(CLOCK_MONOTONIC,&aft);=0A diff =3D (aft.tv_sec-b=
ef.tv_sec)*1000000000+(aft.tv_nsec-bef.tv_nsec);=0A printf("using %ld ns\n", d=
iff);=0A return 0;=0A}=0A=0AThankszhenyu.ren----------------------------------=
--------------------------------=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu De=
snoyers <mathieu.desnoyers@efficios.com>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=
=BC=9A2015=E5=B9=B44=E6=9C=8828=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=8C) 23:47=E6=
=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren <zhenyu.ren@aliyun.com>=E6=8A=84=E3=
=80=80=E9=80=81=EF=BC=9Alttng-dev <lttng-dev@lists.lttng.org>=E4=B8=BB=E3=80=80=
=E9=A2=98=EF=BC=9ARe: [lttng-dev] UST performance=0AHi,=0AIs your sched_getcpu=
() system call a vdso too ? This may explain the difference.=0A=0AMoreover, ma=
ke sure you #define _LGPL_SOURCE in your benchmark program=0Abefore including =
any lttng ust header. It will inline many functions associated with=0Atracepoi=
nts.=0A=0AThen, you can try using "perf" to profile the runtime execution of y=
our program=0Atraced by lttng-ust ? This should give us the information we nee=
d to investigate the=0Aperformance profile.=0A=0AThanks,=0A=0AMathieu=0A=0A=0A=
Hi,dev=0A=C2=A0 =C2=A0 About a month ago,I asked a question about how to do ti=
me recording for ust event when vdso_clock_gettime not availble on my platform=
=EF=BC=88Glibc too old=EF=BC=89.Recently I implemented a lib to analyze vdso i=
n memory and lookuped the symbol vdso_clock_gettime successfully.With this vds=
o_clock_gettime availble,I get a 16% improvement in time spending per ust even=
t. I.E. I measured the time taked by a event with 10 bytes string :=0A=C2=A0no=
 =C2=A0 vdso_clock_gettime : 0.642us=C2=A0with vdso_clock_gettime=EF=BC=9A0.55=
4us=0AHowever=EF=BC=8CBoth the numbers are much higher than the following 0.28=
us(But closed to 0.5us --W/O opt). So what's the difference between UST(0.28us=
) and UST W/O OPT(0.5us)??=C2=A0=0A=0A=0A=0APS:My hardware2 x Xeon E5-2430 =C2=
=A02.20GHz 100MHz FSB (24 cores)=C2=A094.6GB / 96GB 1333MHz DDR3 =3D=3D 6 x 16=
GB, 6 x empty=0AThankszhenyu.ren=0A=0A=0A=0A__________________________________=
_____________=0Alttng-dev mailing list=0Alttng-dev@lists.lttng.org=0Ahttp://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=0A=0A=0A=0A-- =0AMathieu Desn=
oyers=0AEfficiOS Inc.=0Ahttp://www.efficios.com=0A=0A=0A=0A-- =0AMathieu Desno=
yers=0AEfficiOS Inc.=0Ahttp://www.efficios.com=0A
------=ALIBOUNDARY_24048_43fef940_5540525c_19d1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"__aliyun_email_body_block"><div style=3D"font-family:Tahoma,Aria=
l,STHeiti,SimSun;font-size:14px;color:#000000;">Oh,My mistake. I am not using =
-O2 (I copied the Makefile from lttng-ust-2.6.0/doc/examples/easy-ust/Makefile=
 :) ). When compiled with -O2, I get a 0.454us/event(10M events total&nbsp;454=
8921074 ns).</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-s=
ize:14px;color:#000000;"><br data-mce-bogus=3D"1"></div><div style=3D"font-fam=
ily:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;">&gt;Did you def=
ine _LGPL_SOURCE at the top of both files ? (the code and the probe provider)<=
/div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;colo=
r:#000000;"><br data-mce-bogus=3D"1"></div><div style=3D"font-family:Tahoma,Ar=
ial,STHeiti,SimSun;font-size:14px;color:#000000;">&nbsp; Yes,I did define it a=
ll of the files(provider(.h/.c) and sample.c)</div><div class=3D"__aliyun_sign=
ature_wrap"></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-s=
ize:14px;color:#000000;"><br></div><div style=3D"font-family:Tahoma,Arial,STHe=
iti,SimSun;font-size:14px;color:#000000;"><br data-mce-bogus=3D"1"></div><div =
style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;=
">&gt;I see that in the numbers you provided in your earlier email, you talk a=
bout "us" (microseconds), did you actually mean "ns" (nanoseconds) ?</div><div=
 style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000=
;"><br data-mce-bogus=3D"1"></div><div style=3D"font-family:Tahoma,Arial,STHei=
ti,SimSun;font-size:14px;color:#000000;">&nbsp; Yes,I use "us", say&nbsp; <spa=
n style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; f=
ont-size: 14px; font-style: normal; font-variant: normal; font-weight: normal;=
 letter-spacing: normal; line-height: 23px; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: auto; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255=
, 255); display: inline !important; float: none;">0.554us , 0.28us, 0.5us and =
the latest 0.454us . If use "ns",they are 554ns, 280ns,500ns,454ns ,it seems n=
o mistake here=E3=80=82</span></div><div style=3D"font-family:Tahoma,Arial,STH=
eiti,SimSun;font-size:14px;color:#000000;"><span style=3D"color: rgb(0, 0, 0);=
 font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; font-style: nor=
mal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-h=
eight: 23px; orphans: auto; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-st=
roke-width: 0px; background-color: rgb(255, 255, 255); display: inline !import=
ant; float: none;"><br data-mce-bogus=3D"1"></span></div><div style=3D"font-fa=
mily:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><span style=3D=
"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: =
14px; font-style: normal; font-variant: normal; font-weight: normal; letter-sp=
acing: normal; line-height: 23px; orphans: auto; text-align: start; text-inden=
t: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing:=
 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); di=
splay: inline !important; float: none;">My CPU is&nbsp;2 x Xeon E5-2420 &nbsp;=
1.90GHz , OS: RHEL6,2.6.32-220</span></div><div style=3D"font-family:Tahoma,Ar=
ial,STHeiti,SimSun;font-size:14px;color:#000000;"><span style=3D"color: rgb(0,=
 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; font-sty=
le: normal; font-variant: normal; font-weight: normal; letter-spacing: normal;=
 line-height: 23px; orphans: auto; text-align: start; text-indent: 0px; text-t=
ransform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inline =
!important; float: none;"><br data-mce-bogus=3D"1"></span></div><div style=3D"=
font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><span s=
tyle=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font=
-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; le=
tter-spacing: normal; line-height: 23px; orphans: auto; text-align: start; tex=
t-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-s=
pacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 2=
55); display: inline !important; float: none;">&nbsp;Maybe the fact my ust eve=
nt slower than yours is due to the CPU ability,I am not sure about that. Does =
you perf report show something like&nbsp; <span style=3D"color: rgb(0, 0, 0); =
font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; font-style: norm=
al; font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: 23px; orphans: auto; text-align: start; text-indent: 0px; text-transform=
: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-str=
oke-width: 0px; background-color: rgb(255, 255, 255); display: inline !importa=
nt; float: none;">native_write_msr_safe?</span></span></div><div style=3D"font=
-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><span style=
=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-siz=
e: 14px; font-style: normal; font-variant: normal; font-weight: normal; letter=
-spacing: normal; line-height: 23px; orphans: auto; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; widows: auto; word-spaci=
ng: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);=
 display: inline !important; float: none;"><br data-mce-bogus=3D"1"></span></d=
iv><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:=
#000000;"><span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHe=
iti, SimSun; font-size: 14px; font-style: normal; font-variant: normal; font-w=
eight: normal; letter-spacing: normal; line-height: 23px; orphans: auto; text-=
align: start; text-indent: 0px; text-transform: none; white-space: normal; wid=
ows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color=
: rgb(255, 255, 255); display: inline !important; float: none;">Thanks</span><=
/div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;colo=
r:#000000;"><span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, ST=
Heiti, SimSun; font-size: 14px; font-style: normal; font-variant: normal; font=
-weight: normal; letter-spacing: normal; line-height: 23px; orphans: auto; tex=
t-align: start; text-indent: 0px; text-transform: none; white-space: normal; w=
idows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-col=
or: rgb(255, 255, 255); display: inline !important; float: none;">zhenyu.ren</=
span></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14p=
x;color:#000000;"><br data-mce-bogus=3D"1"></div><blockquote style=3D"margin-r=
ight:0;margin-top:0;margin-bottom:0"><div style=3D"font-family:Tahoma,Arial,ST=
Heiti,SimSun;font-size:14px;color:#000000">-----------------------------------=
-------------------------------</div><div style=3D"font-family:Tahoma,Arial,ST=
Heiti,SimSun;font-size:14px;color:#000000">=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A=
Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</div><div style=3D"fo=
nt-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000">=E5=8F=91=E9=
=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2015=E5=B9=B44=E6=9C=8829=E6=97=A5(=E6=98=9F=E6=
=9C=9F=E4=B8=89) 10:25</div><div style=3D"font-family:Tahoma,Arial,STHeiti,Sim=
Sun;font-size:14px;color:#000000">=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.r=
en &lt;zhenyu.ren@aliyun.com&gt;</div><div style=3D"font-family:Tahoma,Arial,S=
THeiti,SimSun;font-size:14px;color:#000000">=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9A=
lttng-dev &lt;lttng-dev@lists.lttng.org&gt;</div><div style=3D"font-family:Tah=
oma,Arial,STHeiti,SimSun;font-size:14px;color:#000000">=E4=B8=BB=E3=80=80=E9=A2=
=98=EF=BC=9ARe: =E7=AD=94=E5=A4=8D=EF=BC=9A[lttng-dev] UST performance</div><d=
iv style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#0000=
00"><br></div><div style=3D"font-family: times new roman , new york , times , =
serif;font-size: 12.0pt;color: #000000;"><hr id=3D"zwchr"><div class=3D"__aliy=
un_email_body_block"><div style=3D"font-family: Tahoma , Arial , STHeiti , Sim=
Sun;font-size: 14.0px;color: #000000;">Hi,Mathieu</div><div style=3D"font-fami=
ly: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;"><br><=
/div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 1=
4.0px;color: #000000;">&gt; <span style=3D"color: #000000;font-family: times n=
ew roman , new york , times , serif;font-size: 16.0px;font-style: normal;font-=
variant: normal;font-weight: normal;letter-spacing: normal;line-height: 26.0px=
;orphans: auto;text-align: start;text-indent: 0.0px;text-transform: none;white=
-space: normal;widows: auto;word-spacing: 0.0px;background-color: #ffffff;disp=
lay: inline;float: none;">Is your sched_getcpu() system call a vdso too</span>=
</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: =
14.0px;color: #000000;"><br></div><div style=3D"font-family: Tahoma , Arial , =
STHeiti , SimSun;font-size: 14.0px;color: #000000;">&nbsp; &nbsp;I use&nbsp;VS=
YSCALL_ADDR(__NR_vgetcpu) instead sched_getcpu so there is no getcpu system ca=
lls.</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-si=
ze: 14.0px;color: #000000;"><br></div><div style=3D"font-family: Tahoma , Aria=
l , STHeiti , SimSun;font-size: 14.0px;color: #000000;">&gt; <span style=3D"co=
lor: #000000;font-family: times new roman , new york , times , serif;font-size=
: 16.0px;font-style: normal;font-variant: normal;font-weight: normal;letter-sp=
acing: normal;line-height: 26.0px;orphans: auto;text-align: start;text-indent:=
 0.0px;text-transform: none;white-space: normal;widows: auto;word-spacing: 0.0=
px;background-color: #ffffff;display: inline;float: none;">make sure you #defi=
ne _LGPL_SOURCE in your benchmark program</span></div><div style=3D"font-famil=
y: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;"><br></=
div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14=
.0px;color: #000000;">&nbsp; &nbsp;I do it as you suggested but no difference.=
</div><div class=3D"__aliyun_signature_wrap"><br></div><div style=3D"font-fami=
ly: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;"><br><=
/div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 1=
4.0px;color: #000000;">&gt; <span style=3D"color: #000000;font-family: times n=
ew roman , new york , times , serif;font-size: 16.0px;font-style: normal;font-=
variant: normal;font-weight: normal;letter-spacing: normal;line-height: 26.0px=
;orphans: auto;text-align: start;text-indent: 0.0px;text-transform: none;white=
-space: normal;widows: auto;word-spacing: 0.0px;background-color: #ffffff;disp=
lay: inline;float: none;">Then, you can try using "perf" to profile the runtim=
e execution<span class=3D"Apple-converted-space">&nbsp;</span></span></div><di=
v style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;co=
lor: #000000;"><span style=3D"color: #000000;font-family: times new roman , ne=
w york , times , serif;font-size: 16.0px;font-style: normal;font-variant: norm=
al;font-weight: normal;letter-spacing: normal;line-height: 26.0px;orphans: aut=
o;text-align: start;text-indent: 0.0px;text-transform: none;white-space: norma=
l;widows: auto;word-spacing: 0.0px;background-color: #ffffff;display: inline;f=
loat: none;"><span class=3D"Apple-converted-space"><br></span></span></div><di=
v style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;co=
lor: #000000;">$~/renzhyu/perf record ./sample<br>WARNING: Kernel address maps=
 (/proc/{kallsyms,modules}) are restricted,<br>check /proc/sys/kernel/kptr_res=
trict.<br><div><br></div>Samples in kernel functions may not be resolved if a =
suitable vmlinux<br>file is not found in the buildid cache or in the vmlinux p=
ath.<br><div><br></div>Samples in kernel modules won't be resolved at all.<br>=
<div><br></div>If some relocation was applied (e.g. kexec) symbols may be misr=
esolved<br>even with a suitable vmlinux or kallsyms file.<br><div><br></div><b=
r>using 5720094251 ns<br>[ perf record: Woken up 1 times to write data ]<br>[ =
perf record: Captured and wrote 0.221 MB perf.data (~9658 samples) ]<br></div>=
<div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px=
;color: #000000;"><br></div><div style=3D"font-family: Tahoma , Arial , STHeit=
i , SimSun;font-size: 14.0px;color: #000000;"><br></div><div style=3D"font-fam=
ily: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;">$~/r=
enzhyu/perf report<br></div><div style=3D"font-family: Tahoma , Arial , STHeit=
i , SimSun;font-size: 14.0px;color: #000000;">Events: 5K cycles<br></div><div =
style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;colo=
r: #000000;">16.82% sample liblttng-ust.so.0.0.0 [.] lttng_event_commit</div><=
div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;=
color: #000000;">10.55% sample liblttng-ust.so.0.0.0 [.] lttng_event_strcpy</d=
iv><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.=
0px;color: #000000;">10.45% sample [kernel.kallsyms] [k] 0xffffffff8103548a</d=
iv><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.=
0px;color: #000000;">8.16% sample liblttng-ust.so.0.0.0 [.] lttng_event_reserv=
e</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size:=
 14.0px;color: #000000;">7.57% sample sample [.] __event_get_size__sample_comp=
onent___message</div><div style=3D"font-family: Tahoma , Arial , STHeiti , Sim=
Sun;font-size: 14.0px;color: #000000;">6.42% sample sample [.] __event_probe__=
sample_component___message</div><div style=3D"font-family: Tahoma , Arial , ST=
Heiti , SimSun;font-size: 14.0px;color: #000000;">6.24% sample liblttng-ust.so=
.0.0.0 [.] lttng_write_event_header</div><div style=3D"font-family: Tahoma , A=
rial , STHeiti , SimSun;font-size: 14.0px;color: #000000;">5.40% sample sample=
 [.] _rcu_read_lock_update</div><div style=3D"font-family: Tahoma , Arial , ST=
Heiti , SimSun;font-size: 14.0px;color: #000000;">5.35% sample sample [.] _rcu=
_read_unlock_bp</div><div style=3D"font-family: Tahoma , Arial , STHeiti , Sim=
Sun;font-size: 14.0px;color: #000000;">5.17% sample liburcu-bp.so.2.0.0 [.] rc=
u_read_unlock_bp</div><div style=3D"font-family: Tahoma , Arial , STHeiti , Si=
mSun;font-size: 14.0px;color: #000000;">4.14% sample ld-2.5.so [.] __tls_get_a=
ddr</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-siz=
e: 14.0px;color: #000000;">3.38% sample [vdso] [.] 0x7fff8f72e6be</div><div st=
yle=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color:=
 #000000;">3.35% sample sample [.] main</div><div style=3D"font-family: Tahoma=
 , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;">1.88% sample sa=
mple [.] lib_ring_buffer_ctx_init</div><div style=3D"font-family: Tahoma , Ari=
al , STHeiti , SimSun;font-size: 14.0px;color: #000000;">1.79% sample sample [=
.] _rcu_read_lock_bp</div><div style=3D"font-family: Tahoma , Arial , STHeiti =
, SimSun;font-size: 14.0px;color: #000000;">1.20% sample liburcu-bp.so.2.0.0 [=
.] rcu_read_lock_bp</div><div style=3D"font-family: Tahoma , Arial , STHeiti ,=
 SimSun;font-size: 14.0px;color: #000000;">0.66% sample sample [.] lib_ring_bu=
ffer_align_ctx</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimS=
un;font-size: 14.0px;color: #000000;">0.38% sample sample [.] cds_list_empty</=
div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14=
.0px;color: #000000;">0.37% sample sample [.] lib_ring_buffer_align</div><div =
style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;colo=
r: #000000;">0.35% sample liburcu-bp.so.2.0.0 [.] __tls_get_addr@plt</div><div=
 style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;col=
or: #000000;">0.28% sample sample [.] __event_get_align__sample_component___me=
ssage</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-s=
ize: 14.0px;color: #000000;">0.09% sample ld-2.5.so [.] do_lookup_</div></div>=
</div></blockquote><div>Did you compile your program and the probe provider<br=
></div><div>(tp.c) with -O2 ?<br></div><div><br></div><div>Did you define _LGP=
L_SOURCE at the top of both files ?<br></div><div>(the code and the probe prov=
ider)<br></div><div><br></div><div>I tried your sample.c program here:<br></di=
v><div><br></div><div>CPU:<br></div><div>Intel(R) Core(TM) i7-4600U CPU @ 2.10=
GHz</div><div>This is within a virtual machine.<br></div><div><br></div><div>A=
nd I get 302 ns/event (total: 3019987815ns exec time)<br></div><div><br></div>=
<div>I see that in the numbers you provided in your earlier email,<br></div><d=
iv>you talk about "us" (microseconds), did you actually mean</div><div>"ns" (n=
anoseconds) ?<br></div><div><br></div><div>I enabled tracing this way:<br></di=
v><div><br></div><div>lttng create --snapshot<br></div><div>lttng enable-event=
 -u -a<br></div><div>lttng start<br></div><div><br></div><div>Thoughts ?<br></=
div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div>=
<blockquote style=3D"border-left: 2.0px solid #1010ff;margin-left: 5.0px;paddi=
ng-left: 5.0px;color: #000000;font-weight: normal;font-style: normal;text-deco=
ration: none;font-family: Helvetica , Arial , sans-serif;font-size: 12.0pt;"><=
div class=3D"__aliyun_email_body_block"><div style=3D"font-family: Tahoma , Ar=
ial , STHeiti , SimSun;font-size: 14.0px;color: #000000;">The symbol&nbsp; <sp=
an style=3D"color: #000000;font-family: Tahoma , Arial , STHeiti , SimSun;font=
-size: 14.0px;font-style: normal;font-variant: normal;font-weight: normal;lett=
er-spacing: normal;line-height: 23.0px;orphans: auto;text-align: start;text-in=
dent: 0.0px;text-transform: none;white-space: normal;widows: auto;word-spacing=
: 0.0px;background-color: #ffffff;display: inline;float: none;">0xffffffff8103=
548a is in&nbsp;native_write_msr_safe,I don't know what the function is and wh=
y that kernel function can be TOP 3.</span></div><div style=3D"font-family: Ta=
homa , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;"><span style=
=3D"color: #000000;font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 1=
4.0px;font-style: normal;font-variant: normal;font-weight: normal;letter-spaci=
ng: normal;line-height: 23.0px;orphans: auto;text-align: start;text-indent: 0.=
0px;text-transform: none;white-space: normal;widows: auto;word-spacing: 0.0px;=
background-color: #ffffff;display: inline;float: none;">ffffffff81035480 &lt;n=
ative_write_msr_safe&gt;:<br>ffffffff81035480: 55 push %rbp<br>ffffffff8103548=
1: 89 f9 mov %edi,%ecx<br>ffffffff81035483: 89 f0 mov %esi,%eax<br>ffffffff810=
35485: 48 89 e5 mov %rsp,%rbp<br>ffffffff81035488: 0f 30 wrmsr<br>ffffffff8103=
548a: 31 c0 xor %eax,%eax<br>ffffffff8103548c: c9 leaveq<br>ffffffff8103548d: =
c3 retq<br>ffffffff8103548e: 66 90 xchg %ax,%ax</span></div><div style=3D"font=
-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;">=
<span style=3D"color: #000000;font-family: Tahoma , Arial , STHeiti , SimSun;f=
ont-size: 14.0px;font-style: normal;font-variant: normal;font-weight: normal;l=
etter-spacing: normal;line-height: 23.0px;orphans: auto;text-align: start;text=
-indent: 0.0px;text-transform: none;white-space: normal;widows: auto;word-spac=
ing: 0.0px;background-color: #ffffff;display: inline;float: none;"><br></span>=
</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: =
14.0px;color: #000000;"><span style=3D"color: #000000;font-family: Tahoma , Ar=
ial , STHeiti , SimSun;font-size: 14.0px;font-style: normal;font-variant: norm=
al;font-weight: normal;letter-spacing: normal;line-height: 23.0px;orphans: aut=
o;text-align: start;text-indent: 0.0px;text-transform: none;white-space: norma=
l;widows: auto;word-spacing: 0.0px;background-color: #ffffff;display: inline;f=
loat: none;">PS:my sample.c</span></div><div style=3D"font-family: Tahoma , Ar=
ial , STHeiti , SimSun;font-size: 14.0px;color: #000000;"><span style=3D"color=
: #000000;font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;fon=
t-style: normal;font-variant: normal;font-weight: normal;letter-spacing: norma=
l;line-height: 23.0px;orphans: auto;text-align: start;text-indent: 0.0px;text-=
transform: none;white-space: normal;widows: auto;word-spacing: 0.0px;backgroun=
d-color: #ffffff;display: inline;float: none;"><br></span></div><div style=3D"=
font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #00000=
0;"><span style=3D"color: #000000;font-family: Tahoma , Arial , STHeiti , SimS=
un;font-size: 14.0px;font-style: normal;font-variant: normal;font-weight: norm=
al;letter-spacing: normal;line-height: 23.0px;orphans: auto;text-align: start;=
text-indent: 0.0px;text-transform: none;white-space: normal;widows: auto;word-=
spacing: 0.0px;background-color: #ffffff;display: inline;float: none;">#includ=
e &lt;time.h&gt;<br>#include &lt;unistd.h&gt;<br>#include &lt;stdio.h&gt;<br><=
/span></div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-=
size: 14.0px;color: #000000;"><span style=3D"color: #000000;font-family: Tahom=
a , Arial , STHeiti , SimSun;font-size: 14.0px;font-style: normal;font-variant=
: normal;font-weight: normal;letter-spacing: normal;line-height: 23.0px;orphan=
s: auto;text-align: start;text-indent: 0.0px;text-transform: none;white-space:=
 normal;widows: auto;word-spacing: 0.0px;background-color: #ffffff;display: in=
line;float: none;"><span style=3D"color: #000000;font-family: Tahoma , Arial ,=
 STHeiti , SimSun;font-size: 14.0px;font-style: normal;font-variant: normal;fo=
nt-weight: normal;letter-spacing: normal;line-height: 23.0px;orphans: auto;tex=
t-align: start;text-indent: 0.0px;text-transform: none;white-space: normal;wid=
ows: auto;word-spacing: 0.0px;background-color: #ffffff;display: inline;float:=
 none;">#define _LGPL_SOURCE<br>#define TRACEPOINT_DEFINE<br>#include "sample_=
component_provider.h"<br></span></span><div><br></div><span style=3D"color: #0=
00000;font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;font-st=
yle: normal;font-variant: normal;font-weight: normal;letter-spacing: normal;li=
ne-height: 23.0px;orphans: auto;text-align: start;text-indent: 0.0px;text-tran=
sform: none;white-space: normal;widows: auto;word-spacing: 0.0px;background-co=
lor: #ffffff;display: inline;float: none;">#define NUM 10000000<br></span></di=
v><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0=
px;color: #000000;"><span style=3D"color: #000000;font-family: Tahoma , Arial =
, STHeiti , SimSun;font-size: 14.0px;font-style: normal;font-variant: normal;f=
ont-weight: normal;letter-spacing: normal;line-height: 23.0px;orphans: auto;te=
xt-align: start;text-indent: 0.0px;text-transform: none;white-space: normal;wi=
dows: auto;word-spacing: 0.0px;background-color: #ffffff;display: inline;float=
: none;">int main(int argc, char **argv)<br>{<br> int i =3D 0;<br> struct time=
spec bef,aft;<br> long diff;<br> clock_gettime(CLOCK_MONOTONIC,&amp;bef);<br> =
for (i =3D 0; i &lt; NUM; i++) {<br>tracepoint(sample_component, message, "Hel=
loWorld");<br> }<br> clock_gettime(CLOCK_MONOTONIC,&amp;aft);<br> diff =3D (af=
t.tv_sec-bef.tv_sec)*1000000000+(aft.tv_nsec-bef.tv_nsec);<br> printf("using %=
ld ns\n", diff);<br></span></div><div style=3D"font-family: Tahoma , Arial , S=
THeiti , SimSun;font-size: 14.0px;color: #000000;"><span style=3D"color: #0000=
00;font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;font-style=
: normal;font-variant: normal;font-weight: normal;letter-spacing: normal;line-=
height: 23.0px;orphans: auto;text-align: start;text-indent: 0.0px;text-transfo=
rm: none;white-space: normal;widows: auto;word-spacing: 0.0px;background-color=
: #ffffff;display: inline;float: none;"> return 0;<br>}<br></span></div><div s=
tyle=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color=
: #000000;"><span style=3D"color: #000000;font-family: Tahoma , Arial , STHeit=
i , SimSun;font-size: 14.0px;font-style: normal;font-variant: normal;font-weig=
ht: normal;letter-spacing: normal;line-height: 23.0px;orphans: auto;text-align=
: start;text-indent: 0.0px;text-transform: none;white-space: normal;widows: au=
to;word-spacing: 0.0px;background-color: #ffffff;display: inline;float: none;"=
><br></span></div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun=
;font-size: 14.0px;color: #000000;"><span style=3D"color: #000000;font-family:=
 Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;font-style: normal;font-v=
ariant: normal;font-weight: normal;letter-spacing: normal;line-height: 23.0px;=
orphans: auto;text-align: start;text-indent: 0.0px;text-transform: none;white-=
space: normal;widows: auto;word-spacing: 0.0px;background-color: #ffffff;displ=
ay: inline;float: none;">Thanks</span></div><div style=3D"font-family: Tahoma =
, Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;"><span style=3D"c=
olor: #000000;font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px=
;font-style: normal;font-variant: normal;font-weight: normal;letter-spacing: n=
ormal;line-height: 23.0px;orphans: auto;text-align: start;text-indent: 0.0px;t=
ext-transform: none;white-space: normal;widows: auto;word-spacing: 0.0px;backg=
round-color: #ffffff;display: inline;float: none;">zhenyu.ren</span></div><blo=
ckquote style=3D"margin-right: 0;margin-top: 0;margin-bottom: 0;"><div style=3D=
"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #0000=
00;">------------------------------------------------------------------</div><=
div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;=
color: #000000;">=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu Desnoyers &lt;mat=
hieu.desnoyers@efficios.com&gt;</div><div style=3D"font-family: Tahoma , Arial=
 , STHeiti , SimSun;font-size: 14.0px;color: #000000;">=E5=8F=91=E9=80=81=E6=97=
=B6=E9=97=B4=EF=BC=9A2015=E5=B9=B44=E6=9C=8828=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=
=8C) 23:47</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;f=
ont-size: 14.0px;color: #000000;">=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.r=
en &lt;zhenyu.ren@aliyun.com&gt;</div><div style=3D"font-family: Tahoma , Aria=
l , STHeiti , SimSun;font-size: 14.0px;color: #000000;">=E6=8A=84=E3=80=80=E9=80=
=81=EF=BC=9Alttng-dev &lt;lttng-dev@lists.lttng.org&gt;</div><div style=3D"fon=
t-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;"=
>=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [lttng-dev] UST performance</div><div=
 style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;col=
or: #000000;"><br></div><div style=3D"font-family: times new roman , new york =
, times , serif;font-size: 12.0pt;color: #000000;"><div>Hi,</div><div><br></di=
v><div>Is your sched_getcpu() system call a vdso too ? This may explain the di=
fference.<br></div><div><br></div><div>Moreover, make sure you #define _LGPL_S=
OURCE in your benchmark program<br></div><div>before including any lttng ust h=
eader. It will inline many functions associated with<br></div><div>tracepoints=
.<br></div><div><br></div><div>Then, you can try using "perf" to profile the r=
untime execution of your program<br></div><div>traced by lttng-ust ? This shou=
ld give us the information we need to investigate the<br></div><div>performanc=
e profile.<br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>M=
athieu<br></div><div><br></div><div><br></div><hr id=3D"zwchr"><blockquote sty=
le=3D"border-left: 2.0px solid #1010ff;margin-left: 5.0px;padding-left: 5.0px;=
color: #000000;font-weight: normal;font-style: normal;text-decoration: none;fo=
nt-family: Helvetica , Arial , sans-serif;font-size: 12.0pt;"><div class=3D"__=
aliyun_email_body_block"><div style=3D"font-family: Tahoma , Arial , STHeiti ,=
 SimSun;font-size: 14.0px;color: #000000;">Hi,dev</div><div style=3D"font-fami=
ly: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;"><br><=
/div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 1=
4.0px;color: #000000;">&nbsp; &nbsp; About a month ago,I asked a question abou=
t how to do time recording for ust event when vdso_clock_gettime not availble =
on my platform=EF=BC=88Glibc too old=EF=BC=89.Recently I implemented a lib to =
analyze vdso in memory and lookuped the symbol vdso_clock_gettime successfully=
.With this vdso_clock_gettime availble,I get a 16% improvement in time spendin=
g per ust event. I.E. I measured the time taked by a event with 10 bytes strin=
g :</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-siz=
e: 14.0px;color: #000000;"><br></div><div style=3D"font-family: Tahoma , Arial=
 , STHeiti , SimSun;font-size: 14.0px;color: #000000;">&nbsp;no &nbsp; vdso_cl=
ock_gettime : 0.642us</div><div style=3D"font-family: Tahoma , Arial , STHeiti=
 , SimSun;font-size: 14.0px;color: #000000;">&nbsp;with vdso_clock_gettime=EF=BC=
=9A0.554us</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;f=
ont-size: 14.0px;color: #000000;"><br></div><div style=3D"font-family: Tahoma =
, Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;">However=EF=BC=8C=
Both the numbers are much higher than the following 0.28us(But closed to 0.5us=
 --W/O opt). So what's the difference between UST(0.28us) and UST W/O OPT(0.5u=
s)??&nbsp;</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;f=
ont-size: 14.0px;color: #000000;"><br></div><div style=3D"font-family: Tahoma =
, Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;"><br></div><div s=
tyle=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color=
: #000000;"><br></div><div style=3D"font-family: Tahoma , Arial , STHeiti , Si=
mSun;font-size: 14.0px;color: #000000;"><br></div><div style=3D"font-family: T=
ahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;">PS:My hard=
ware</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-si=
ze: 14.0px;color: #000000;">2 x Xeon E5-2430 &nbsp;2.20GHz 100MHz FSB (24 core=
s)&nbsp;94.6GB / 96GB 1333MHz DDR3 =3D=3D 6 x 16GB, 6 x empty</div><div style=3D=
"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #0000=
00;"><br></div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;fo=
nt-size: 14.0px;color: #000000;">Thanks</div><div style=3D"font-family: Tahoma=
 , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;">zhenyu.ren</div=
><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0p=
x;color: #000000;"><br></div><div class=3D"__aliyun_signature_wrap"><br></div>=
<div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px=
;color: #000000;"><br></div></div><br>________________________________________=
_______<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br><a href=3D"h=
ttp://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">ht=
tp://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br></blockquote><d=
iv><br><div><br></div></div><div><br></div><div>-- <br></div><div>Mathieu Desn=
oyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank=
">http://www.efficios.com</a><br></div></div></blockquote></div><div><br><br><=
/div><div><br></div><div>-- <br></div><div><span></span>Mathieu Desnoyers<br>E=
fficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://w=
ww.efficios.com</a><span></span><br></div></blockquote></div>
------=ALIBOUNDARY_24048_43fef940_5540525c_19d1b--



--===============2073002541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2073002541==--
