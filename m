From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?b?562U5aSN77yaIFVTVCBwZXJmb3JtYW5jZQ==?=
Date: Wed, 29 Apr 2015 09:31:16 +0800
Message-ID: <5896be5a-83a3-4179-b07d-e5c855210bb7__21007.6919793666$1430271172$gmane$org@aliyun.com>
References: <2d399e36-59c3-4648-8b13-53a4b36b68de@aliyun.com>,
 1778982370.39421.1430236058233.JavaMail.zimbra@efficios.com
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0417400817=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-313.freemail.mail.aliyun.com ([110.75.46.13])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <zhenyu.ren@aliyun.com>) id 1YnGql-0005O7-O4
 for lttng-dev@lists.lttng.org; Tue, 28 Apr 2015 21:31:46 -0400
In-Reply-To: 1778982370.39421.1430236058233.JavaMail.zimbra@efficios.com
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

--===============0417400817==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_14972_47f83940_55403464_195a5"

------=ALIBOUNDARY_14972_47f83940_55403464_195a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,Mathieu> Is your sched_getcpu() system call a vdso too =C2=A0 =C2=A0I use=C2=
=A0VSYSCALL_ADDR(__NR_vgetcpu) instead sched_getcpu so there is no getcpu syst=
em calls.=0A> make sure you #define _LGPL_SOURCE in your benchmark program =C2=
=A0 =C2=A0I do it as you suggested but no difference.=0A> Then, you can try us=
ing "perf" to profile the runtime execution=C2=A0$~/renzhyu/perf record ./samp=
le=0AWARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,=0A=
check /proc/sys/kernel/kptr_restrict.=0A=0ASamples in kernel functions may not=
 be resolved if a suitable vmlinux=0Afile is not found in the buildid cache or=
 in the vmlinux path.=0A=0ASamples in kernel modules won't be resolved at all.=
=0A=0AIf some relocation was applied (e.g. kexec) symbols may be misresolved=0A=
even with a suitable vmlinux or kallsyms file.=0A=0A=0Ausing 5720094251 ns=0A[=
 perf record: Woken up 1 times to write data ]=0A[ perf record: Captured and w=
rote 0.221 MB perf.data (~9658 samples) ]=0A$~/renzhyu/perf report=0AEvents: 5=
K cycles=0A16.82% sample liblttng-ust.so.0.0.0 [.] lttng_event_commit10.55% sa=
mple liblttng-ust.so.0.0.0 [.] lttng_event_strcpy10.45% sample [kernel.kallsym=
s] [k] 0xffffffff8103548a8.16% sample liblttng-ust.so.0.0.0 [.] lttng_event_re=
serve7.57% sample sample [.] __event_get_size__sample_component___message6.42%=
 sample sample [.] __event_probe__sample_component___message6.24% sample liblt=
tng-ust.so.0.0.0 [.] lttng_write_event_header5.40% sample sample [.] _rcu_read=
_lock_update5.35% sample sample [.] _rcu_read_unlock_bp5.17% sample liburcu-bp=
.so.2.0.0 [.] rcu_read_unlock_bp4.14% sample ld-2.5.so [.] __tls_get_addr3.38%=
 sample [vdso] [.] 0x7fff8f72e6be3.35% sample sample [.] main1.88% sample samp=
le [.] lib_ring_buffer_ctx_init1.79% sample sample [.] _rcu_read_lock_bp1.20% =
sample liburcu-bp.so.2.0.0 [.] rcu_read_lock_bp0.66% sample sample [.] lib_rin=
g_buffer_align_ctx0.38% sample sample [.] cds_list_empty0.37% sample sample [.=
] lib_ring_buffer_align0.35% sample liburcu-bp.so.2.0.0 [.] __tls_get_addr@plt=
0.28% sample sample [.] __event_get_align__sample_component___message 0.09% sa=
mple ld-2.5.so [.] do_lookup_The symbol=C2=A0 0xffffffff8103548a is in=C2=A0na=
tive_write_msr_safe,I don't know what the function is and why that kernel func=
tion can be TOP 3.ffffffff81035480 <native_write_msr_safe>:=0Affffffff81035480=
: 55 push %rbp=0Affffffff81035481: 89 f9 mov %edi,%ecx=0Affffffff81035483: 89 =
f0 mov %esi,%eax=0Affffffff81035485: 48 89 e5 mov %rsp,%rbp=0Affffffff81035488=
: 0f 30 wrmsr=0Affffffff8103548a: 31 c0 xor %eax,%eax=0Affffffff8103548c: c9 l=
eaveq=0Affffffff8103548d: c3 retq=0Affffffff8103548e: 66 90 xchg %ax,%axPS:my =
sample.c#include <time.h>=0A#include <unistd.h>=0A#include <stdio.h>=0A#define=
 _LGPL_SOURCE=0A#define TRACEPOINT_DEFINE=0A#include "sample_component_provide=
r.h"=0A=0A#define NUM 10000000=0Aint main(int argc, char **argv)=0A{=0A int i =
=3D 0;=0A struct timespec bef,aft;=0A long diff;=0A clock_gettime(CLOCK_MONOTO=
NIC,&bef);=0A for (i =3D 0; i < NUM; i++) {=0Atracepoint(sample_component, mes=
sage, "HelloWorld");=0A }=0A clock_gettime(CLOCK_MONOTONIC,&aft);=0A diff =3D =
(aft.tv_sec-bef.tv_sec)*1000000000+(aft.tv_nsec-bef.tv_nsec);=0A printf("using=
 %ld ns\n", diff);=0A return 0;=0A}=0AThankszhenyu.ren------------------------=
------------------------------------------=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A=
Mathieu Desnoyers <mathieu.desnoyers@efficios.com>=E5=8F=91=E9=80=81=E6=97=B6=E9=
=97=B4=EF=BC=9A2015=E5=B9=B44=E6=9C=8828=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=8C)=
 23:47=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren <zhenyu.ren@aliyun.com>=E6=
=8A=84=E3=80=80=E9=80=81=EF=BC=9Alttng-dev <lttng-dev@lists.lttng.org>=E4=B8=BB=
=E3=80=80=E9=A2=98=EF=BC=9ARe: [lttng-dev] UST performance=0AHi,=0AIs your sch=
ed_getcpu() system call a vdso too ? This may explain the difference.=0A=0AMor=
eover, make sure you #define _LGPL_SOURCE in your benchmark program=0Abefore i=
ncluding any lttng ust header. It will inline many functions associated with=0A=
tracepoints.=0A=0AThen, you can try using "perf" to profile the runtime execut=
ion of your program=0Atraced by lttng-ust ? This should give us the informatio=
n we need to investigate the=0Aperformance profile.=0A=0AThanks,=0A=0AMathieu=0A=
=0A=0AHi,dev=0A=C2=A0 =C2=A0 About a month ago,I asked a question about how to=
 do time recording for ust event when vdso_clock_gettime not availble on my pl=
atform=EF=BC=88Glibc too old=EF=BC=89.Recently I implemented a lib to analyze =
vdso in memory and lookuped the symbol vdso_clock_gettime successfully.With th=
is vdso_clock_gettime availble,I get a 16% improvement in time spending per us=
t event. I.E. I measured the time taked by a event with 10 bytes string :=0A=C2=
=A0no =C2=A0 vdso_clock_gettime : 0.642us=C2=A0with vdso_clock_gettime=EF=BC=9A=
0.554us=0AHowever=EF=BC=8CBoth the numbers are much higher than the following =
0.28us(But closed to 0.5us --W/O opt). So what's the difference between UST(0.=
28us) and UST W/O OPT(0.5us)??=C2=A0=0A=0A=0APS:My hardware2 x Xeon E5-2430 =C2=
=A02.20GHz 100MHz FSB (24 cores)=C2=A094.6GB / 96GB 1333MHz DDR3 =3D=3D 6 x 16=
GB, 6 x empty=0AThankszhenyu.ren=0A=0A=0A_____________________________________=
__________=0Alttng-dev mailing list=0Alttng-dev@lists.lttng.org=0Ahttp://lists=
.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=0A=0A=0A=0A-- =0AMathieu Desnoye=
rs=0AEfficiOS Inc.=0Ahttp://www.efficios.com=0A
------=ALIBOUNDARY_14972_47f83940_55403464_195a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"__aliyun_email_body_block"><div style=3D"font-family:Tahoma,Aria=
l,STHeiti,SimSun;font-size:14px;color:#000000;">Hi,Mathieu</div><div style=3D"=
font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><br dat=
a-mce-bogus=3D"1"></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;=
font-size:14px;color:#000000;">&gt; <span style=3D"color: rgb(0, 0, 0); font-f=
amily: 'times new roman', 'new york', times, serif; font-size: 16px; font-styl=
e: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: 26px; orphans: auto; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-t=
ext-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inline !=
important; float: none;">Is your sched_getcpu() system call a vdso too</span> =
</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;col=
or:#000000;"><br data-mce-bogus=3D"1"></div><div style=3D"font-family:Tahoma,A=
rial,STHeiti,SimSun;font-size:14px;color:#000000;">&nbsp; &nbsp;I use&nbsp;VSY=
SCALL_ADDR(__NR_vgetcpu) instead sched_getcpu so there is no getcpu system cal=
ls.</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;=
color:#000000;"><br></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSu=
n;font-size:14px;color:#000000;">&gt; <span style=3D"color: rgb(0, 0, 0); font=
-family: 'times new roman', 'new york', times, serif; font-size: 16px; font-st=
yle: normal; font-variant: normal; font-weight: normal; letter-spacing: normal=
; line-height: 26px; orphans: auto; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit=
-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inline=
 !important; float: none;">make sure you #define _LGPL_SOURCE in your benchmar=
k program</span> </div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;f=
ont-size:14px;color:#000000;"><br data-mce-bogus=3D"1"></div><div style=3D"fon=
t-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;">&nbsp; &nb=
sp;I do it as you suggested but no difference.</div><div class=3D"__aliyun_sig=
nature_wrap"></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-=
size:14px;color:#000000;"><br></div><div style=3D"font-family:Tahoma,Arial,STH=
eiti,SimSun;font-size:14px;color:#000000;">&gt; <span style=3D"color: rgb(0, 0=
, 0); font-family: 'times new roman', 'new york', times, serif; font-size: 16p=
x; font-style: normal; font-variant: normal; font-weight: normal; letter-spaci=
ng: normal; line-height: 26px; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0p=
x; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); displ=
ay: inline !important; float: none;">Then, you can try using "perf" to profile=
 the runtime execution<span class=3D"Apple-converted-space">&nbsp;</span></spa=
n></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;c=
olor:#000000;"><span style=3D"color: rgb(0, 0, 0); font-family: 'times new rom=
an', 'new york', times, serif; font-size: 16px; font-style: normal; font-varia=
nt: normal; font-weight: normal; letter-spacing: normal; line-height: 26px; or=
phans: auto; text-align: start; text-indent: 0px; text-transform: none; white-=
space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px=
; background-color: rgb(255, 255, 255); display: inline !important; float: non=
e;"><span class=3D"Apple-converted-space"><br data-mce-bogus=3D"1"></span></sp=
an></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;=
color:#000000;">$~/renzhyu/perf record ./sample<br>WARNING: Kernel address map=
s (/proc/{kallsyms,modules}) are restricted,<br>check /proc/sys/kernel/kptr_re=
strict.<br><br>Samples in kernel functions may not be resolved if a suitable v=
mlinux<br>file is not found in the buildid cache or in the vmlinux path.<br><b=
r>Samples in kernel modules won't be resolved at all.<br><br>If some relocatio=
n was applied (e.g. kexec) symbols may be misresolved<br>even with a suitable =
vmlinux or kallsyms file.<br><br><br>using 5720094251 ns<br>[ perf record: Wok=
en up 1 times to write data ]<br>[ perf record: Captured and wrote 0.221 MB pe=
rf.data (~9658 samples) ]<br></div><div style=3D"font-family:Tahoma,Arial,STHe=
iti,SimSun;font-size:14px;color:#000000;"><br data-mce-bogus=3D"1"></div><div =
style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;=
"><br data-mce-bogus=3D"1"></div><div style=3D"font-family:Tahoma,Arial,STHeit=
i,SimSun;font-size:14px;color:#000000;">$~/renzhyu/perf report<br></div><div s=
tyle=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"=
>Events: 5K cycles<br></div><div style=3D"font-family:Tahoma,Arial,STHeiti,Sim=
Sun;font-size:14px;color:#000000;">16.82% sample liblttng-ust.so.0.0.0 [.] ltt=
ng_event_commit</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;fon=
t-size:14px;color:#000000;">10.55% sample liblttng-ust.so.0.0.0 [.] lttng_even=
t_strcpy</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:=
14px;color:#000000;">10.45% sample [kernel.kallsyms] [k] 0xffffffff8103548a</d=
iv><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:=
#000000;">8.16% sample liblttng-ust.so.0.0.0 [.] lttng_event_reserve</div><div=
 style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000=
;">7.57% sample sample [.] __event_get_size__sample_component___message</div><=
div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000=
000;">6.42% sample sample [.] __event_probe__sample_component___message</div><=
div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000=
000;">6.24% sample liblttng-ust.so.0.0.0 [.] lttng_write_event_header</div><di=
v style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#00000=
0;">5.40% sample sample [.] _rcu_read_lock_update</div><div style=3D"font-fami=
ly:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;">5.35% sample sam=
ple [.] _rcu_read_unlock_bp</div><div style=3D"font-family:Tahoma,Arial,STHeit=
i,SimSun;font-size:14px;color:#000000;">5.17% sample liburcu-bp.so.2.0.0 [.] r=
cu_read_unlock_bp</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;f=
ont-size:14px;color:#000000;">4.14% sample ld-2.5.so [.] __tls_get_addr</div><=
div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000=
000;">3.38% sample [vdso] [.] 0x7fff8f72e6be</div><div style=3D"font-family:Ta=
homa,Arial,STHeiti,SimSun;font-size:14px;color:#000000;">3.35% sample sample [=
.] main</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:1=
4px;color:#000000;">1.88% sample sample [.] lib_ring_buffer_ctx_init</div><div=
 style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000=
;">1.79% sample sample [.] _rcu_read_lock_bp</div><div style=3D"font-family:Ta=
homa,Arial,STHeiti,SimSun;font-size:14px;color:#000000;">1.20% sample liburcu-=
bp.so.2.0.0 [.] rcu_read_lock_bp</div><div style=3D"font-family:Tahoma,Arial,S=
THeiti,SimSun;font-size:14px;color:#000000;">0.66% sample sample [.] lib_ring_=
buffer_align_ctx</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;fo=
nt-size:14px;color:#000000;">0.38% sample sample [.] cds_list_empty</div><div =
style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;=
">0.37% sample sample [.] lib_ring_buffer_align</div><div style=3D"font-family=
:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;">0.35% sample libur=
cu-bp.so.2.0.0 [.] __tls_get_addr@plt</div><div style=3D"font-family:Tahoma,Ar=
ial,STHeiti,SimSun;font-size:14px;color:#000000;">0.28% sample sample [.] __ev=
ent_get_align__sample_component___message </div><div style=3D"font-family:Taho=
ma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;">0.09% sample ld-2.5.so =
[.] do_lookup_</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font=
-size:14px;color:#000000;"><br data-mce-bogus=3D"1"></div><div style=3D"font-f=
amily:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;">The symbol&nb=
sp; <span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, S=
imSun; font-size: 14px; font-style: normal; font-variant: normal; font-weight:=
 normal; letter-spacing: normal; line-height: 23px; orphans: auto; text-align:=
 start; text-indent: 0px; text-transform: none; white-space: normal; widows: a=
uto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(=
255, 255, 255); display: inline !important; float: none;">0xffffffff8103548a i=
s in&nbsp;native_write_msr_safe,I don't know what the function is and why that=
 kernel function can be TOP 3.</span></div><div style=3D"font-family:Tahoma,Ar=
ial,STHeiti,SimSun;font-size:14px;color:#000000;"><span style=3D"color: rgb(0,=
 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; font-sty=
le: normal; font-variant: normal; font-weight: normal; letter-spacing: normal;=
 line-height: 23px; orphans: auto; text-align: start; text-indent: 0px; text-t=
ransform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inline =
!important; float: none;">ffffffff81035480 &lt;native_write_msr_safe&gt;:<br>f=
fffffff81035480: 55 push %rbp<br>ffffffff81035481: 89 f9 mov %edi,%ecx<br>ffff=
ffff81035483: 89 f0 mov %esi,%eax<br>ffffffff81035485: 48 89 e5 mov %rsp,%rbp<=
br>ffffffff81035488: 0f 30 wrmsr<br>ffffffff8103548a: 31 c0 xor %eax,%eax<br>f=
fffffff8103548c: c9 leaveq<br>ffffffff8103548d: c3 retq<br>ffffffff8103548e: 6=
6 90 xchg %ax,%ax</span></div><div style=3D"font-family:Tahoma,Arial,STHeiti,S=
imSun;font-size:14px;color:#000000;"><span style=3D"color: rgb(0, 0, 0); font-=
family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; font-style: normal; f=
ont-variant: normal; font-weight: normal; letter-spacing: normal; line-height:=
 23px; orphans: auto; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-w=
idth: 0px; background-color: rgb(255, 255, 255); display: inline !important; f=
loat: none;"><br data-mce-bogus=3D"1"></span></div><div style=3D"font-family:T=
ahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><span style=3D"color=
: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; =
font-style: normal; font-variant: normal; font-weight: normal; letter-spacing:=
 normal; line-height: 23px; orphans: auto; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display:=
 inline !important; float: none;">PS:my sample.c</span></div><div style=3D"fon=
t-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><span styl=
e=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-si=
ze: 14px; font-style: normal; font-variant: normal; font-weight: normal; lette=
r-spacing: normal; line-height: 23px; orphans: auto; text-align: start; text-i=
ndent: 0px; text-transform: none; white-space: normal; widows: auto; word-spac=
ing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255)=
; display: inline !important; float: none;"><br data-mce-bogus=3D"1"></span></=
div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color=
:#000000;"><span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STH=
eiti, SimSun; font-size: 14px; font-style: normal; font-variant: normal; font-=
weight: normal; letter-spacing: normal; line-height: 23px; orphans: auto; text=
-align: start; text-indent: 0px; text-transform: none; white-space: normal; wi=
dows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-colo=
r: rgb(255, 255, 255); display: inline !important; float: none;">#include &lt;=
time.h&gt;<br>#include &lt;unistd.h&gt;<br>#include &lt;stdio.h&gt;<br></span>=
</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;col=
or:#000000;"><span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, S=
THeiti, SimSun; font-size: 14px; font-style: normal; font-variant: normal; fon=
t-weight: normal; letter-spacing: normal; line-height: 23px; orphans: auto; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-co=
lor: rgb(255, 255, 255); display: inline !important; float: none;">#define _LG=
PL_SOURCE<br>#define TRACEPOINT_DEFINE<br>#include "sample_component_provider.=
h"<br><br>#define NUM 10000000<br></span></div><div style=3D"font-family:Tahom=
a,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><span style=3D"color: rg=
b(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; font=
-style: normal; font-variant: normal; font-weight: normal; letter-spacing: nor=
mal; line-height: 23px; orphans: auto; text-align: start; text-indent: 0px; te=
xt-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -web=
kit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inl=
ine !important; float: none;">int main(int argc, char **argv)<br>{<br> int i =3D=
 0;<br> struct timespec bef,aft;<br> long diff;<br> clock_gettime(CLOCK_MONOTO=
NIC,&amp;bef);<br> for (i =3D 0; i &lt; NUM; i++) {<br>tracepoint(sample_compo=
nent, message, "HelloWorld");<br> }<br> clock_gettime(CLOCK_MONOTONIC,&amp;aft=
);<br> diff =3D (aft.tv_sec-bef.tv_sec)*1000000000+(aft.tv_nsec-bef.tv_nsec);<=
br> printf("using %ld ns\n", diff);<br></span></div><div style=3D"font-family:=
Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><span style=3D"colo=
r: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px;=
 font-style: normal; font-variant: normal; font-weight: normal; letter-spacing=
: normal; line-height: 23px; orphans: auto; text-align: start; text-indent: 0p=
x; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px;=
 -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display=
: inline !important; float: none;"> return 0;<br>}<br></span></div><div style=3D=
"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"><span =
style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; fon=
t-size: 14px; font-style: normal; font-variant: normal; font-weight: normal; l=
etter-spacing: normal; line-height: 23px; orphans: auto; text-align: start; te=
xt-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-=
spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, =
255); display: inline !important; float: none;"><br data-mce-bogus=3D"1"></spa=
n></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;c=
olor:#000000;"><span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial,=
 STHeiti, SimSun; font-size: 14px; font-style: normal; font-variant: normal; f=
ont-weight: normal; letter-spacing: normal; line-height: 23px; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: normal=
; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-=
color: rgb(255, 255, 255); display: inline !important; float: none;">Thanks</s=
pan></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px=
;color:#000000;"><span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Aria=
l, STHeiti, SimSun; font-size: 14px; font-style: normal; font-variant: normal;=
 font-weight: normal; letter-spacing: normal; line-height: 23px; orphans: auto=
; text-align: start; text-indent: 0px; text-transform: none; white-space: norm=
al; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; backgroun=
d-color: rgb(255, 255, 255); display: inline !important; float: none;">zhenyu.=
ren</span></div><blockquote style=3D"margin-right:0;margin-top:0;margin-bottom=
:0"><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color=
:#000000">------------------------------------------------------------------</=
div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color=
:#000000">=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu Desnoyers &lt;mathieu.de=
snoyers@efficios.com&gt;</div><div style=3D"font-family:Tahoma,Arial,STHeiti,S=
imSun;font-size:14px;color:#000000">=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=
=9A2015=E5=B9=B44=E6=9C=8828=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=8C) 23:47</div>=
<div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#00=
0000">=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren &lt;zhenyu.ren@aliyun.com=
&gt;</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px=
;color:#000000">=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Alttng-dev &lt;lttng-dev@li=
sts.lttng.org&gt;</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;f=
ont-size:14px;color:#000000">=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [lttng-de=
v] UST performance</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;=
font-size:14px;color:#000000"><br></div><div style=3D"font-family: times new r=
oman , new york , times , serif;font-size: 12.0pt;color: #000000;"><div>Hi,</d=
iv><div><br></div><div>Is your sched_getcpu() system call a vdso too ? This ma=
y explain the difference.<br></div><div><br></div><div>Moreover, make sure you=
 #define _LGPL_SOURCE in your benchmark program<br></div><div>before including=
 any lttng ust header. It will inline many functions associated with<br></div>=
<div>tracepoints.<br></div><div><br></div><div>Then, you can try using "perf" =
to profile the runtime execution of your program<br></div><div>traced by lttng=
-ust ? This should give us the information we need to investigate the<br></div=
><div>performance profile.<br></div><div><br></div><div>Thanks,<br></div><div>=
<br></div><div>Mathieu<br></div><div><br></div><div><br></div><hr id=3D"zwchr"=
><blockquote style=3D"border-left: 2.0px solid #1010ff;margin-left: 5.0px;padd=
ing-left: 5.0px;color: #000000;font-weight: normal;font-style: normal;text-dec=
oration: none;font-family: Helvetica , Arial , sans-serif;font-size: 12.0pt;">=
<div class=3D"__aliyun_email_body_block"><div style=3D"font-family: Tahoma , A=
rial , STHeiti , SimSun;font-size: 14.0px;color: #000000;">Hi,dev</div><div st=
yle=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color:=
 #000000;"><br></div><div style=3D"font-family: Tahoma , Arial , STHeiti , Sim=
Sun;font-size: 14.0px;color: #000000;">&nbsp; &nbsp; About a month ago,I asked=
 a question about how to do time recording for ust event when vdso_clock_getti=
me not availble on my platform=EF=BC=88Glibc too old=EF=BC=89.Recently I imple=
mented a lib to analyze vdso in memory and lookuped the symbol vdso_clock_gett=
ime successfully.With this vdso_clock_gettime availble,I get a 16% improvement=
 in time spending per ust event. I.E. I measured the time taked by a event wit=
h 10 bytes string :</div><div style=3D"font-family: Tahoma , Arial , STHeiti ,=
 SimSun;font-size: 14.0px;color: #000000;"><br></div><div style=3D"font-family=
: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;">&nbsp;n=
o &nbsp; vdso_clock_gettime : 0.642us</div><div style=3D"font-family: Tahoma ,=
 Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;">&nbsp;with vdso_c=
lock_gettime=EF=BC=9A0.554us</div><div style=3D"font-family: Tahoma , Arial , =
STHeiti , SimSun;font-size: 14.0px;color: #000000;"><br></div><div style=3D"fo=
nt-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;=
">However=EF=BC=8CBoth the numbers are much higher than the following 0.28us(B=
ut closed to 0.5us --W/O opt). So what's the difference between UST(0.28us) an=
d UST W/O OPT(0.5us)??&nbsp;</div><div style=3D"font-family: Tahoma , Arial , =
STHeiti , SimSun;font-size: 14.0px;color: #000000;"><br></div><div style=3D"fo=
nt-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;=
"></div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size=
: 14.0px;color: #000000;"><br></div><div style=3D"font-family: Tahoma , Arial =
, STHeiti , SimSun;font-size: 14.0px;color: #000000;"><br></div><div style=3D"=
font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #00000=
0;">PS:My hardware</div><div style=3D"font-family: Tahoma , Arial , STHeiti , =
SimSun;font-size: 14.0px;color: #000000;">2 x Xeon E5-2430 &nbsp;2.20GHz 100MH=
z FSB (24 cores)&nbsp;94.6GB / 96GB 1333MHz DDR3 =3D=3D 6 x 16GB, 6 x empty</d=
iv><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.=
0px;color: #000000;"><br></div><div style=3D"font-family: Tahoma , Arial , STH=
eiti , SimSun;font-size: 14.0px;color: #000000;">Thanks</div><div style=3D"fon=
t-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;"=
>zhenyu.ren</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;=
font-size: 14.0px;color: #000000;"><br></div><div class=3D"__aliyun_signature_=
wrap"></div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-=
size: 14.0px;color: #000000;"><br></div></div><br>____________________________=
___________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>=
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D=
"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br></bl=
ockquote><div><br><br></div><div><br></div><div>-- <br></div><div><span></span=
>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" tar=
get=3D"_blank">http://www.efficios.com</a><span></span><br></div></div></block=
quote></div>
------=ALIBOUNDARY_14972_47f83940_55403464_195a5--



--===============0417400817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0417400817==--
