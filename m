From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: =?utf-8?b?562U5aSN77yaIFVTVCBwZXJmb3JtYW5jZQ==?=
Date: Wed, 29 Apr 2015 02:25:12 +0000 (UTC)
Message-ID: <95067142.40057.1430274312545.JavaMail.zimbra__11531.0256057002$1430274379$gmane$org@efficios.com>
References: <2d399e36-59c3-4648-8b13-53a4b36b68de@aliyun.com> <",
 1778982370.39421.1430236058233.JavaMail.zimbra"@efficios.com>
 <5896be5a-83a3-4179-b07d-e5c855210bb7@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0442350001=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YnHgc-0005gA-QD
 for lttng-dev@lists.lttng.org; Tue, 28 Apr 2015 22:25:20 -0400
In-Reply-To: <5896be5a-83a3-4179-b07d-e5c855210bb7@aliyun.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0442350001==
Content-Type: multipart/alternative;
	boundary="----=_Part_40056_1352101328.1430274312544"

------=_Part_40056_1352101328.1430274312544
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> Hi,Mathieu

> > Is your sched_getcpu() system call a vdso too

> I use VSYSCALL_ADDR(__NR_vgetcpu) instead sched_getcpu so there is no get=
cpu
> system calls.

> > make sure you #define _LGPL_SOURCE in your benchmark program

> I do it as you suggested but no difference.

> > Then, you can try using "perf" to profile the runtime execution

> $~/renzhyu/perf record ./sample
> WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
> check /proc/sys/kernel/kptr_restrict.

> Samples in kernel functions may not be resolved if a suitable vmlinux
> file is not found in the buildid cache or in the vmlinux path.

> Samples in kernel modules won't be resolved at all.

> If some relocation was applied (e.g. kexec) symbols may be misresolved
> even with a suitable vmlinux or kallsyms file.

> using 5720094251 ns
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.221 MB perf.data (~9658 samples) ]

> $~/renzhyu/perf report
> Events: 5K cycles
> 16.82% sample liblttng-ust.so.0.0.0 [.] lttng_event_commit
> 10.55% sample liblttng-ust.so.0.0.0 [.] lttng_event_strcpy
> 10.45% sample [kernel.kallsyms] [k] 0xffffffff8103548a
> 8.16% sample liblttng-ust.so.0.0.0 [.] lttng_event_reserve
> 7.57% sample sample [.] __event_get_size__sample_component___message
> 6.42% sample sample [.] __event_probe__sample_component___message
> 6.24% sample liblttng-ust.so.0.0.0 [.] lttng_write_event_header
> 5.40% sample sample [.] _rcu_read_lock_update
> 5.35% sample sample [.] _rcu_read_unlock_bp
> 5.17% sample liburcu-bp.so.2.0.0 [.] rcu_read_unlock_bp
> 4.14% sample ld-2.5.so [.] __tls_get_addr
> 3.38% sample [vdso] [.] 0x7fff8f72e6be
> 3.35% sample sample [.] main
> 1.88% sample sample [.] lib_ring_buffer_ctx_init
> 1.79% sample sample [.] _rcu_read_lock_bp
> 1.20% sample liburcu-bp.so.2.0.0 [.] rcu_read_lock_bp
> 0.66% sample sample [.] lib_ring_buffer_align_ctx
> 0.38% sample sample [.] cds_list_empty
> 0.37% sample sample [.] lib_ring_buffer_align
> 0.35% sample liburcu-bp.so.2.0.0 [.] __tls_get_addr@plt
> 0.28% sample sample [.] __event_get_align__sample_component___message
> 0.09% sample ld-2.5.so [.] do_lookup_

Did you compile your program and the probe provider=20
(tp.c) with -O2 ?=20

Did you define _LGPL_SOURCE at the top of both files ?=20
(the code and the probe provider)=20

I tried your sample.c program here:=20

CPU:=20
Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz=20
This is within a virtual machine.=20

And I get 302 ns/event (total: 3019987815ns exec time)=20

I see that in the numbers you provided in your earlier email,=20
you talk about "us" (microseconds), did you actually mean=20
"ns" (nanoseconds) ?=20

I enabled tracing this way:=20

lttng create --snapshot=20
lttng enable-event -u -a=20
lttng start=20

Thoughts ?=20

Thanks,=20

Mathieu=20

> The symbol 0xffffffff8103548a is in native_write_msr_safe,I don't know wh=
at
> the function is and why that kernel function can be TOP 3.
> ffffffff81035480 <native_write_msr_safe>:
> ffffffff81035480: 55 push %rbp
> ffffffff81035481: 89 f9 mov %edi,%ecx
> ffffffff81035483: 89 f0 mov %esi,%eax
> ffffffff81035485: 48 89 e5 mov %rsp,%rbp
> ffffffff81035488: 0f 30 wrmsr
> ffffffff8103548a: 31 c0 xor %eax,%eax
> ffffffff8103548c: c9 leaveq
> ffffffff8103548d: c3 retq
> ffffffff8103548e: 66 90 xchg %ax,%ax

> PS:my sample.c

> #include <time.h>
> #include <unistd.h>
> #include <stdio.h>
> #define _LGPL_SOURCE
> #define TRACEPOINT_DEFINE
> #include "sample_component_provider.h"

> #define NUM 10000000
> int main(int argc, char **argv)
> {
> int i =3D 0;
> struct timespec bef,aft;
> long diff;
> clock_gettime(CLOCK_MONOTONIC,&bef);
> for (i =3D 0; i < NUM; i++) {
> tracepoint(sample_component, message, "HelloWorld");
> }
> clock_gettime(CLOCK_MONOTONIC,&aft);
> diff =3D (aft.tv_sec-bef.tv_sec)*1000000000+(aft.tv_nsec-bef.tv_nsec);
> printf("using %ld ns\n", diff);
> return 0;
> }

> Thanks
> zhenyu.ren

> > ------------------------------------------------------------------
>=20
> > =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu Desnoyers <mathieu.desnoyer=
s@efficios.com>
>=20
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2015=E5=B9=B44=E6=9C=8828=
=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=8C) 23:47
>=20
> > =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren <zhenyu.ren@aliyun.com>
>=20
> > =E6=8A=84 =E9=80=81=EF=BC=9Alttng-dev <lttng-dev@lists.lttng.org>
>=20
> > =E4=B8=BB =E9=A2=98=EF=BC=9ARe: [lttng-dev] UST performance
>=20

> > Hi,
>=20

> > Is your sched_getcpu() system call a vdso too ? This may explain the
> > difference.
>=20

> > Moreover, make sure you #define _LGPL_SOURCE in your benchmark program
>=20
> > before including any lttng ust header. It will inline many functions
> > associated with
>=20
> > tracepoints.
>=20

> > Then, you can try using "perf" to profile the runtime execution of your
> > program
>=20
> > traced by lttng-ust ? This should give us the information we need to
> > investigate the
>=20
> > performance profile.
>=20

> > Thanks,
>=20

> > Mathieu
>=20

> > ----- Original Message -----
>=20

> > > Hi,dev
> >=20
>=20

> > > About a month ago,I asked a question about how to do time recording f=
or
> > > ust
> > > event when vdso_clock_gettime not availble on my platform=EF=BC=88Gli=
bc too
> > > old=EF=BC=89.Recently I implemented a lib to analyze vdso in memory a=
nd lookuped
> > > the
> > > symbol vdso_clock_gettime successfully.With this vdso_clock_gettime
> > > availble,I get a 16% improvement in time spending per ust event. I.E.=
 I
> > > measured the time taked by a event with 10 bytes string :
> >=20
>=20

> > > no vdso_clock_gettime : 0.642us
> >=20
>=20
> > > with vdso_clock_gettime=EF=BC=9A0.554us
> >=20
>=20

> > > However=EF=BC=8CBoth the numbers are much higher than the following 0=
.28us(But
> > > closed
> > > to 0.5us --W/O opt). So what's the difference between UST(0.28us) and=
 UST
> > > W/O OPT(0.5us)??
> >=20
>=20

> > > PS:My hardware
> >=20
>=20
> > > 2 x Xeon E5-2430 2.20GHz 100MHz FSB (24 cores) 94.6GB / 96GB 1333MHz =
DDR3
> > > =3D=3D
> > > 6 x 16GB, 6 x empty
> >=20
>=20

> > > Thanks
> >=20
>=20
> > > zhenyu.ren
> >=20
>=20

> > > _______________________________________________
> >=20
>=20
> > > lttng-dev mailing list
> >=20
>=20
> > > lttng-dev@lists.lttng.org
> >=20
>=20
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >=20
>=20

> > --
>=20
> > Mathieu Desnoyers
>=20
> > EfficiOS Inc.
>=20
> > http://www.efficios.com
>=20

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_40056_1352101328.1430274312544
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"border-left: 2px s=
olid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-weight=
: normal; font-style: normal; text-decoration: none; font-family: Helvetica=
,Arial,sans-serif; font-size: 12pt;"><div class=3D"__aliyun_email_body_bloc=
k"><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;col=
or:#000000;" data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; fo=
nt-size: 14px; color: #000000;">Hi,Mathieu</div><div style=3D"font-family:T=
ahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D=
"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;=
"><br></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size=
:14px;color:#000000;" data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,S=
imSun; font-size: 14px; color: #000000;">&gt; <span style=3D"color: rgb(0, =
0, 0); font-family: 'times new roman', 'new york', times, serif; font-size:=
 16px; font-style: normal; font-variant: normal; font-weight: normal; lette=
r-spacing: normal; line-height: 26px; orphans: auto; text-align: start; tex=
t-indent: 0px; text-transform: none; white-space: normal; widows: auto; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, =
255, 255); display: inline !important; float: none;" data-mce-style=3D"colo=
r: #000000; font-family: 'times new roman', 'new york', times, serif; font-=
size: 16px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: 26px; orphans: auto; text-align: start=
; text-indent: 0px; text-transform: none; white-space: normal; widows: auto=
; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #fff=
fff; display: inline !important; float: none;">Is your sched_getcpu() syste=
m call a vdso too</span></div><div style=3D"font-family:Tahoma,Arial,STHeit=
i,SimSun;font-size:14px;color:#000000;" data-mce-style=3D"font-family: Taho=
ma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;"><br></div><div s=
tyle=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#00000=
0;" data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: =
14px; color: #000000;">&nbsp; &nbsp;I use&nbsp;VSYSCALL_ADDR(__NR_vgetcpu) =
instead sched_getcpu so there is no getcpu system calls.</div><div style=3D=
"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" dat=
a-mce-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; c=
olor: #000000;"><br></div><div style=3D"font-family:Tahoma,Arial,STHeiti,Si=
mSun;font-size:14px;color:#000000;" data-mce-style=3D"font-family: Tahoma,A=
rial,STHeiti,SimSun; font-size: 14px; color: #000000;">&gt; <span style=3D"=
color: rgb(0, 0, 0); font-family: 'times new roman', 'new york', times, ser=
if; font-size: 16px; font-style: normal; font-variant: normal; font-weight:=
 normal; letter-spacing: normal; line-height: 26px; orphans: auto; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wid=
ows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-co=
lor: rgb(255, 255, 255); display: inline !important; float: none;" data-mce=
-style=3D"color: #000000; font-family: 'times new roman', 'new york', times=
, serif; font-size: 16px; font-style: normal; font-variant: normal; font-we=
ight: normal; letter-spacing: normal; line-height: 26px; orphans: auto; tex=
t-align: start; text-indent: 0px; text-transform: none; white-space: normal=
; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; backgrou=
nd-color: #ffffff; display: inline !important; float: none;">make sure you =
#define _LGPL_SOURCE in your benchmark program</span></div><div style=3D"fo=
nt-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" data-m=
ce-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; colo=
r: #000000;"><br></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSu=
n;font-size:14px;color:#000000;" data-mce-style=3D"font-family: Tahoma,Aria=
l,STHeiti,SimSun; font-size: 14px; color: #000000;">&nbsp; &nbsp;I do it as=
 you suggested but no difference.</div><div class=3D"__aliyun_signature_wra=
p"><br></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-siz=
e:14px;color:#000000;" data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,=
SimSun; font-size: 14px; color: #000000;"><br></div><div style=3D"font-fami=
ly:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-styl=
e=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000=
000;">&gt; <span style=3D"color: rgb(0, 0, 0); font-family: 'times new roma=
n', 'new york', times, serif; font-size: 16px; font-style: normal; font-var=
iant: normal; font-weight: normal; letter-spacing: normal; line-height: 26p=
x; orphans: auto; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke=
-width: 0px; background-color: rgb(255, 255, 255); display: inline !importa=
nt; float: none;" data-mce-style=3D"color: #000000; font-family: 'times new=
 roman', 'new york', times, serif; font-size: 16px; font-style: normal; fon=
t-variant: normal; font-weight: normal; letter-spacing: normal; line-height=
: 26px; orphans: auto; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-s=
troke-width: 0px; background-color: #ffffff; display: inline !important; fl=
oat: none;">Then, you can try using "perf" to profile the runtime execution=
<span class=3D"Apple-converted-space">&nbsp;</span></span></div><div style=
=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" =
data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px=
; color: #000000;"><span style=3D"color: rgb(0, 0, 0); font-family: 'times =
new roman', 'new york', times, serif; font-size: 16px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; line-hei=
ght: 26px; orphans: auto; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inline =
!important; float: none;" data-mce-style=3D"color: #000000; font-family: 't=
imes new roman', 'new york', times, serif; font-size: 16px; font-style: nor=
mal; font-variant: normal; font-weight: normal; letter-spacing: normal; lin=
e-height: 26px; orphans: auto; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; widows: auto; word-spacing: 0px; -webki=
t-text-stroke-width: 0px; background-color: #ffffff; display: inline !impor=
tant; float: none;"><span class=3D"Apple-converted-space"><br></span></span=
></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px=
;color:#000000;" data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun=
; font-size: 14px; color: #000000;">$~/renzhyu/perf record ./sample<br>WARN=
ING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,<br>chec=
k /proc/sys/kernel/kptr_restrict.<br><div><br></div>Samples in kernel funct=
ions may not be resolved if a suitable vmlinux<br>file is not found in the =
buildid cache or in the vmlinux path.<br><div><br></div>Samples in kernel m=
odules won't be resolved at all.<br><div><br></div>If some relocation was a=
pplied (e.g. kexec) symbols may be misresolved<br>even with a suitable vmli=
nux or kallsyms file.<br><div><br></div><br>using 5720094251 ns<br>[ perf r=
ecord: Woken up 1 times to write data ]<br>[ perf record: Captured and wrot=
e 0.221 MB perf.data (~9658 samples) ]<br></div><div style=3D"font-family:T=
ahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D=
"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;=
"><br></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size=
:14px;color:#000000;" data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,S=
imSun; font-size: 14px; color: #000000;"><br></div><div style=3D"font-famil=
y:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-style=
=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #0000=
00;">$~/renzhyu/perf report<br></div><div style=3D"font-family:Tahoma,Arial=
,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D"font-famil=
y: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;">Events: 5=
K cycles<br></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;fon=
t-size:14px;color:#000000;" data-mce-style=3D"font-family: Tahoma,Arial,STH=
eiti,SimSun; font-size: 14px; color: #000000;">16.82% sample liblttng-ust.s=
o.0.0.0 [.] lttng_event_commit</div><div style=3D"font-family:Tahoma,Arial,=
STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D"font-family=
: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;">10.55% sam=
ple liblttng-ust.so.0.0.0 [.] lttng_event_strcpy</div><div style=3D"font-fa=
mily:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-st=
yle=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #0=
00000;">10.45% sample [kernel.kallsyms] [k] 0xffffffff8103548a</div><div st=
yle=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000=
;" data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 1=
4px; color: #000000;">8.16% sample liblttng-ust.so.0.0.0 [.] lttng_event_re=
serve</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:=
14px;color:#000000;" data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,Si=
mSun; font-size: 14px; color: #000000;">7.57% sample sample [.] __event_get=
_size__sample_component___message</div><div style=3D"font-family:Tahoma,Ari=
al,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D"font-fam=
ily: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;">6.42% s=
ample sample [.] __event_probe__sample_component___message</div><div style=
=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" =
data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px=
; color: #000000;">6.24% sample liblttng-ust.so.0.0.0 [.] lttng_write_event=
_header</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-siz=
e:14px;color:#000000;" data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,=
SimSun; font-size: 14px; color: #000000;">5.40% sample sample [.] _rcu_read=
_lock_update</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;fon=
t-size:14px;color:#000000;" data-mce-style=3D"font-family: Tahoma,Arial,STH=
eiti,SimSun; font-size: 14px; color: #000000;">5.35% sample sample [.] _rcu=
_read_unlock_bp</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;=
font-size:14px;color:#000000;" data-mce-style=3D"font-family: Tahoma,Arial,=
STHeiti,SimSun; font-size: 14px; color: #000000;">5.17% sample liburcu-bp.s=
o.2.0.0 [.] rcu_read_unlock_bp</div><div style=3D"font-family:Tahoma,Arial,=
STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D"font-family=
: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;">4.14% samp=
le ld-2.5.so [.] __tls_get_addr</div><div style=3D"font-family:Tahoma,Arial=
,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D"font-famil=
y: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;">3.38% sam=
ple [vdso] [.] 0x7fff8f72e6be</div><div style=3D"font-family:Tahoma,Arial,S=
THeiti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D"font-family:=
 Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;">3.35% sampl=
e sample [.] main</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSu=
n;font-size:14px;color:#000000;" data-mce-style=3D"font-family: Tahoma,Aria=
l,STHeiti,SimSun; font-size: 14px; color: #000000;">1.88% sample sample [.]=
 lib_ring_buffer_ctx_init</div><div style=3D"font-family:Tahoma,Arial,STHei=
ti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D"font-family: Tah=
oma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;">1.79% sample sa=
mple [.] _rcu_read_lock_bp</div><div style=3D"font-family:Tahoma,Arial,STHe=
iti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D"font-family: Ta=
homa,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;">1.20% sample l=
iburcu-bp.so.2.0.0 [.] rcu_read_lock_bp</div><div style=3D"font-family:Taho=
ma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D"fo=
nt-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;">0=
.66% sample sample [.] lib_ring_buffer_align_ctx</div><div style=3D"font-fa=
mily:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-st=
yle=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #0=
00000;">0.38% sample sample [.] cds_list_empty</div><div style=3D"font-fami=
ly:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-styl=
e=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000=
000;">0.37% sample sample [.] lib_ring_buffer_align</div><div style=3D"font=
-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce=
-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color:=
 #000000;">0.35% sample liburcu-bp.so.2.0.0 [.] __tls_get_addr@plt</div><di=
v style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#00=
0000;" data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-siz=
e: 14px; color: #000000;">0.28% sample sample [.] __event_get_align__sample=
_component___message</div><div style=3D"font-family:Tahoma,Arial,STHeiti,Si=
mSun;font-size:14px;color:#000000;" data-mce-style=3D"font-family: Tahoma,A=
rial,STHeiti,SimSun; font-size: 14px; color: #000000;">0.09% sample ld-2.5.=
so [.] do_lookup_</div></div></blockquote><div>Did you compile your program=
 and the probe provider<br></div><div>(tp.c) with -O2 ?<br></div><div><br><=
/div><div>Did you define _LGPL_SOURCE at the top of both files ?<br></div><=
div>(the code and the probe provider)<br></div><div><br></div><div>I tried =
your sample.c program here:<br></div><div><br></div><div>CPU:<br></div><div=
>Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz</div><div>This is within a virtua=
l machine.<br></div><div><br></div><div>And I get 302 ns/event (total: 3019=
987815ns exec time)<br></div><div><br></div><div>I see that in the numbers =
you provided in your earlier email,<br></div><div>you talk about "us" (micr=
oseconds), did you actually mean</div><div>"ns" (nanoseconds) ?<br></div><d=
iv><br></div><div>I enabled tracing this way:<br></div><div><br></div><div>=
lttng create --snapshot<br></div><div>lttng enable-event -u -a<br></div><di=
v>lttng start<br></div><div><br></div><div>Thoughts ?<br></div><div><br></d=
iv><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><blockquote s=
tyle=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;colo=
r:#000;font-weight:normal;font-style:normal;text-decoration:none;font-famil=
y:Helvetica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"border-left=
: 2px solid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font=
-weight: normal; font-style: normal; text-decoration: none; font-family: He=
lvetica,Arial,sans-serif; font-size: 12pt;"><div class=3D"__aliyun_email_bo=
dy_block"><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:1=
4px;color:#000000;" data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,Sim=
Sun; font-size: 14px; color: #000000;">The symbol&nbsp; <span style=3D"colo=
r: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14=
px; font-style: normal; font-variant: normal; font-weight: normal; letter-s=
pacing: normal; line-height: 23px; orphans: auto; text-align: start; text-i=
ndent: 0px; text-transform: none; white-space: normal; widows: auto; word-s=
pacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255=
, 255); display: inline !important; float: none;" data-mce-style=3D"color: =
#000000; font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; font=
-style: normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: 23px; orphans: auto; text-align: start; text-indent: 0=
px; text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; display: in=
line !important; float: none;">0xffffffff8103548a is in&nbsp;native_write_m=
sr_safe,I don't know what the function is and why that kernel function can =
be TOP 3.</span></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun=
;font-size:14px;color:#000000;" data-mce-style=3D"font-family: Tahoma,Arial=
,STHeiti,SimSun; font-size: 14px; color: #000000;"><span style=3D"color: rg=
b(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; f=
ont-style: normal; font-variant: normal; font-weight: normal; letter-spacin=
g: normal; line-height: 23px; orphans: auto; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; widows: auto; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255=
); display: inline !important; float: none;" data-mce-style=3D"color: #0000=
00; font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; font-styl=
e: normal; font-variant: normal; font-weight: normal; letter-spacing: norma=
l; line-height: 23px; orphans: auto; text-align: start; text-indent: 0px; t=
ext-transform: none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; background-color: #ffffff; display: inline =
!important; float: none;">ffffffff81035480 &lt;native_write_msr_safe&gt;:<b=
r>ffffffff81035480: 55 push %rbp<br>ffffffff81035481: 89 f9 mov %edi,%ecx<b=
r>ffffffff81035483: 89 f0 mov %esi,%eax<br>ffffffff81035485: 48 89 e5 mov %=
rsp,%rbp<br>ffffffff81035488: 0f 30 wrmsr<br>ffffffff8103548a: 31 c0 xor %e=
ax,%eax<br>ffffffff8103548c: c9 leaveq<br>ffffffff8103548d: c3 retq<br>ffff=
ffff8103548e: 66 90 xchg %ax,%ax</span></div><div style=3D"font-family:Taho=
ma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D"fo=
nt-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;"><=
span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, Sim=
Sun; font-size: 14px; font-style: normal; font-variant: normal; font-weight=
: normal; letter-spacing: normal; line-height: 23px; orphans: auto; text-al=
ign: start; text-indent: 0px; text-transform: none; white-space: normal; wi=
dows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-c=
olor: rgb(255, 255, 255); display: inline !important; float: none;" data-mc=
e-style=3D"color: #000000; font-family: Tahoma, Arial, STHeiti, SimSun; fon=
t-size: 14px; font-style: normal; font-variant: normal; font-weight: normal=
; letter-spacing: normal; line-height: 23px; orphans: auto; text-align: sta=
rt; text-indent: 0px; text-transform: none; white-space: normal; widows: au=
to; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #f=
fffff; display: inline !important; float: none;"><br></span></div><div styl=
e=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;"=
 data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14p=
x; color: #000000;"><span style=3D"color: rgb(0, 0, 0); font-family: Tahoma=
, Arial, STHeiti, SimSun; font-size: 14px; font-style: normal; font-variant=
: normal; font-weight: normal; letter-spacing: normal; line-height: 23px; o=
rphans: auto; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-wid=
th: 0px; background-color: rgb(255, 255, 255); display: inline !important; =
float: none;" data-mce-style=3D"color: #000000; font-family: Tahoma, Arial,=
 STHeiti, SimSun; font-size: 14px; font-style: normal; font-variant: normal=
; font-weight: normal; letter-spacing: normal; line-height: 23px; orphans: =
auto; text-align: start; text-indent: 0px; text-transform: none; white-spac=
e: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;=
 background-color: #ffffff; display: inline !important; float: none;">PS:my=
 sample.c</span></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun=
;font-size:14px;color:#000000;" data-mce-style=3D"font-family: Tahoma,Arial=
,STHeiti,SimSun; font-size: 14px; color: #000000;"><span style=3D"color: rg=
b(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; f=
ont-style: normal; font-variant: normal; font-weight: normal; letter-spacin=
g: normal; line-height: 23px; orphans: auto; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; widows: auto; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255=
); display: inline !important; float: none;" data-mce-style=3D"color: #0000=
00; font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; font-styl=
e: normal; font-variant: normal; font-weight: normal; letter-spacing: norma=
l; line-height: 23px; orphans: auto; text-align: start; text-indent: 0px; t=
ext-transform: none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; background-color: #ffffff; display: inline =
!important; float: none;"><br></span></div><div style=3D"font-family:Tahoma=
,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D"font=
-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;"><sp=
an style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSu=
n; font-size: 14px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: 23px; orphans: auto; text-alig=
n: start; text-indent: 0px; text-transform: none; white-space: normal; wido=
ws: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-col=
or: rgb(255, 255, 255); display: inline !important; float: none;" data-mce-=
style=3D"color: #000000; font-family: Tahoma, Arial, STHeiti, SimSun; font-=
size: 14px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: 23px; orphans: auto; text-align: start=
; text-indent: 0px; text-transform: none; white-space: normal; widows: auto=
; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #fff=
fff; display: inline !important; float: none;">#include &lt;time.h&gt;<br>#=
include &lt;unistd.h&gt;<br>#include &lt;stdio.h&gt;<br></span></div><div s=
tyle=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#00000=
0;" data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: =
14px; color: #000000;"><span style=3D"color: rgb(0, 0, 0); font-family: Tah=
oma, Arial, STHeiti, SimSun; font-size: 14px; font-style: normal; font-vari=
ant: normal; font-weight: normal; letter-spacing: normal; line-height: 23px=
; orphans: auto; text-align: start; text-indent: 0px; text-transform: none;=
 white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; background-color: rgb(255, 255, 255); display: inline !importan=
t; float: none;" data-mce-style=3D"color: #000000; font-family: Tahoma, Ari=
al, STHeiti, SimSun; font-size: 14px; font-style: normal; font-variant: nor=
mal; font-weight: normal; letter-spacing: normal; line-height: 23px; orphan=
s: auto; text-align: start; text-indent: 0px; text-transform: none; white-s=
pace: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; background-color: #ffffff; display: inline !important; float: none;"><s=
pan style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimS=
un; font-size: 14px; font-style: normal; font-variant: normal; font-weight:=
 normal; letter-spacing: normal; line-height: 23px; orphans: auto; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wid=
ows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-co=
lor: rgb(255, 255, 255); display: inline !important; float: none;" data-mce=
-style=3D"color: #000000; font-family: Tahoma, Arial, STHeiti, SimSun; font=
-size: 14px; font-style: normal; font-variant: normal; font-weight: normal;=
 letter-spacing: normal; line-height: 23px; orphans: auto; text-align: star=
t; text-indent: 0px; text-transform: none; white-space: normal; widows: aut=
o; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ff=
ffff; display: inline !important; float: none;">#define _LGPL_SOURCE<br>#de=
fine TRACEPOINT_DEFINE<br>#include "sample_component_provider.h"<br></span>=
</span><div><br></div><span style=3D"color: rgb(0, 0, 0); font-family: Taho=
ma, Arial, STHeiti, SimSun; font-size: 14px; font-style: normal; font-varia=
nt: normal; font-weight: normal; letter-spacing: normal; line-height: 23px;=
 orphans: auto; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-w=
idth: 0px; background-color: rgb(255, 255, 255); display: inline !important=
; float: none;" data-mce-style=3D"color: #000000; font-family: Tahoma, Aria=
l, STHeiti, SimSun; font-size: 14px; font-style: normal; font-variant: norm=
al; font-weight: normal; letter-spacing: normal; line-height: 23px; orphans=
: auto; text-align: start; text-indent: 0px; text-transform: none; white-sp=
ace: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0p=
x; background-color: #ffffff; display: inline !important; float: none;">#de=
fine NUM 10000000<br></span></div><div style=3D"font-family:Tahoma,Arial,ST=
Heiti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D"font-family: =
Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;"><span style=
=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; font-=
size: 14px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: 23px; orphans: auto; text-align: start=
; text-indent: 0px; text-transform: none; white-space: normal; widows: auto=
; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(=
255, 255, 255); display: inline !important; float: none;" data-mce-style=3D=
"color: #000000; font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14=
px; font-style: normal; font-variant: normal; font-weight: normal; letter-s=
pacing: normal; line-height: 23px; orphans: auto; text-align: start; text-i=
ndent: 0px; text-transform: none; white-space: normal; widows: auto; word-s=
pacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; dis=
play: inline !important; float: none;">int main(int argc, char **argv)<br>{=
<br> int i =3D 0;<br> struct timespec bef,aft;<br> long diff;<br> clock_get=
time(CLOCK_MONOTONIC,&amp;bef);<br> for (i =3D 0; i &lt; NUM; i++) {<br>tra=
cepoint(sample_component, message, "HelloWorld");<br> }<br> clock_gettime(C=
LOCK_MONOTONIC,&amp;aft);<br> diff =3D (aft.tv_sec-bef.tv_sec)*1000000000+(=
aft.tv_nsec-bef.tv_nsec);<br> printf("using %ld ns\n", diff);<br></span></d=
iv><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;col=
or:#000000;" data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; fo=
nt-size: 14px; color: #000000;"><span style=3D"color: rgb(0, 0, 0); font-fa=
mily: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; line-hei=
ght: 23px; orphans: auto; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inline =
!important; float: none;" data-mce-style=3D"color: #000000; font-family: Ta=
homa, Arial, STHeiti, SimSun; font-size: 14px; font-style: normal; font-var=
iant: normal; font-weight: normal; letter-spacing: normal; line-height: 23p=
x; orphans: auto; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke=
-width: 0px; background-color: #ffffff; display: inline !important; float: =
none;"> return 0;<br>}<br></span></div><div style=3D"font-family:Tahoma,Ari=
al,STHeiti,SimSun;font-size:14px;color:#000000;" data-mce-style=3D"font-fam=
ily: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;"><span s=
tyle=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, STHeiti, SimSun; f=
ont-size: 14px; font-style: normal; font-variant: normal; font-weight: norm=
al; letter-spacing: normal; line-height: 23px; orphans: auto; text-align: s=
tart; text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: =
rgb(255, 255, 255); display: inline !important; float: none;" data-mce-styl=
e=3D"color: #000000; font-family: Tahoma, Arial, STHeiti, SimSun; font-size=
: 14px; font-style: normal; font-variant: normal; font-weight: normal; lett=
er-spacing: normal; line-height: 23px; orphans: auto; text-align: start; te=
xt-indent: 0px; text-transform: none; white-space: normal; widows: auto; wo=
rd-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff;=
 display: inline !important; float: none;"><br></span></div><div style=3D"f=
ont-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;" data-=
mce-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; col=
or: #000000;"><span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Aria=
l, STHeiti, SimSun; font-size: 14px; font-style: normal; font-variant: norm=
al; font-weight: normal; letter-spacing: normal; line-height: 23px; orphans=
: auto; text-align: start; text-indent: 0px; text-transform: none; white-sp=
ace: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0p=
x; background-color: rgb(255, 255, 255); display: inline !important; float:=
 none;" data-mce-style=3D"color: #000000; font-family: Tahoma, Arial, STHei=
ti, SimSun; font-size: 14px; font-style: normal; font-variant: normal; font=
-weight: normal; letter-spacing: normal; line-height: 23px; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: nor=
mal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; backg=
round-color: #ffffff; display: inline !important; float: none;">Thanks</spa=
n></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14p=
x;color:#000000;" data-mce-style=3D"font-family: Tahoma,Arial,STHeiti,SimSu=
n; font-size: 14px; color: #000000;"><span style=3D"color: rgb(0, 0, 0); fo=
nt-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; font-style: nor=
mal; font-variant: normal; font-weight: normal; letter-spacing: normal; lin=
e-height: 23px; orphans: auto; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; widows: auto; word-spacing: 0px; -webki=
t-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display: in=
line !important; float: none;" data-mce-style=3D"color: #000000; font-famil=
y: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; font-style: normal; fon=
t-variant: normal; font-weight: normal; letter-spacing: normal; line-height=
: 23px; orphans: auto; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-s=
troke-width: 0px; background-color: #ffffff; display: inline !important; fl=
oat: none;">zhenyu.ren</span></div><blockquote style=3D"margin-right:0;marg=
in-top:0;margin-bottom:0" data-mce-style=3D"margin-right: 0; margin-top: 0;=
 margin-bottom: 0;"><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;f=
ont-size:14px;color:#000000" data-mce-style=3D"font-family: Tahoma,Arial,ST=
Heiti,SimSun; font-size: 14px; color: #000000;">---------------------------=
---------------------------------------</div><div style=3D"font-family:Taho=
ma,Arial,STHeiti,SimSun;font-size:14px;color:#000000" data-mce-style=3D"fon=
t-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;">=
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu Desnoyers &lt;mathieu.desnoyers=
@efficios.com&gt;</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSu=
n;font-size:14px;color:#000000" data-mce-style=3D"font-family: Tahoma,Arial=
,STHeiti,SimSun; font-size: 14px; color: #000000;">=E5=8F=91=E9=80=81=E6=97=
=B6=E9=97=B4=EF=BC=9A2015=E5=B9=B44=E6=9C=8828=E6=97=A5(=E6=98=9F=E6=9C=9F=
=E4=BA=8C) 23:47</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun=
;font-size:14px;color:#000000" data-mce-style=3D"font-family: Tahoma,Arial,=
STHeiti,SimSun; font-size: 14px; color: #000000;">=E6=94=B6=E4=BB=B6=E4=BA=
=BA=EF=BC=9Azhenyu.ren &lt;zhenyu.ren@aliyun.com&gt;</div><div style=3D"fon=
t-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000" data-mce=
-style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color:=
 #000000;">=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Alttng-dev &lt;lttng-dev@list=
s.lttng.org&gt;</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;=
font-size:14px;color:#000000" data-mce-style=3D"font-family: Tahoma,Arial,S=
THeiti,SimSun; font-size: 14px; color: #000000;">=E4=B8=BB=E3=80=80=E9=A2=
=98=EF=BC=9ARe: [lttng-dev] UST performance</div><div style=3D"font-family:=
Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000" data-mce-style=3D=
"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: #000000;=
"><br></div><div style=3D"font-family: times new roman , new york , times ,=
 serif;font-size: 12.0pt;color: #000000;" data-mce-style=3D"font-family: ti=
mes new roman , new york , times , serif; font-size: 12.0pt; color: #000000=
;"><div>Hi,</div><div><br></div><div>Is your sched_getcpu() system call a v=
dso too ? This may explain the difference.<br></div><div><br></div><div>Mor=
eover, make sure you #define _LGPL_SOURCE in your benchmark program<br></di=
v><div>before including any lttng ust header. It will inline many functions=
 associated with<br></div><div>tracepoints.<br></div><div><br></div><div>Th=
en, you can try using "perf" to profile the runtime execution of your progr=
am<br></div><div>traced by lttng-ust ? This should give us the information =
we need to investigate the<br></div><div>performance profile.<br></div><div=
><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div>=
<br></div><div><br></div><hr id=3D"zwchr"><blockquote style=3D"border-left:=
 2.0px solid #1010ff;margin-left: 5.0px;padding-left: 5.0px;color: #000000;=
font-weight: normal;font-style: normal;text-decoration: none;font-family: H=
elvetica , Arial , sans-serif;font-size: 12.0pt;" data-mce-style=3D"border-=
left: 2.0px solid #1010ff; margin-left: 5.0px; padding-left: 5.0px; color: =
#000000; font-weight: normal; font-style: normal; text-decoration: none; fo=
nt-family: Helvetica , Arial , sans-serif; font-size: 12.0pt;"><div class=
=3D"__aliyun_email_body_block"><div style=3D"font-family: Tahoma , Arial , =
STHeiti , SimSun;font-size: 14.0px;color: #000000;" data-mce-style=3D"font-=
family: Tahoma , Arial , STHeiti , SimSun; font-size: 14.0px; color: #00000=
0;">Hi,dev</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSu=
n;font-size: 14.0px;color: #000000;" data-mce-style=3D"font-family: Tahoma =
, Arial , STHeiti , SimSun; font-size: 14.0px; color: #000000;"><br></div><=
div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0=
px;color: #000000;" data-mce-style=3D"font-family: Tahoma , Arial , STHeiti=
 , SimSun; font-size: 14.0px; color: #000000;">&nbsp; &nbsp; About a month =
ago,I asked a question about how to do time recording for ust event when vd=
so_clock_gettime not availble on my platform=EF=BC=88Glibc too old=EF=BC=89=
.Recently I implemented a lib to analyze vdso in memory and lookuped the sy=
mbol vdso_clock_gettime successfully.With this vdso_clock_gettime availble,=
I get a 16% improvement in time spending per ust event. I.E. I measured the=
 time taked by a event with 10 bytes string :</div><div style=3D"font-famil=
y: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;" dat=
a-mce-style=3D"font-family: Tahoma , Arial , STHeiti , SimSun; font-size: 1=
4.0px; color: #000000;"><br></div><div style=3D"font-family: Tahoma , Arial=
 , STHeiti , SimSun;font-size: 14.0px;color: #000000;" data-mce-style=3D"fo=
nt-family: Tahoma , Arial , STHeiti , SimSun; font-size: 14.0px; color: #00=
0000;">&nbsp;no &nbsp; vdso_clock_gettime : 0.642us</div><div style=3D"font=
-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000=
;" data-mce-style=3D"font-family: Tahoma , Arial , STHeiti , SimSun; font-s=
ize: 14.0px; color: #000000;">&nbsp;with vdso_clock_gettime=EF=BC=9A0.554us=
</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-siz=
e: 14.0px;color: #000000;" data-mce-style=3D"font-family: Tahoma , Arial , =
STHeiti , SimSun; font-size: 14.0px; color: #000000;"><br></div><div style=
=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color:=
 #000000;" data-mce-style=3D"font-family: Tahoma , Arial , STHeiti , SimSun=
; font-size: 14.0px; color: #000000;">However=EF=BC=8CBoth the numbers are =
much higher than the following 0.28us(But closed to 0.5us --W/O opt). So wh=
at's the difference between UST(0.28us) and UST W/O OPT(0.5us)??&nbsp;</div=
><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14=
.0px;color: #000000;" data-mce-style=3D"font-family: Tahoma , Arial , STHei=
ti , SimSun; font-size: 14.0px; color: #000000;"><br></div><div style=3D"fo=
nt-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #0000=
00;" data-mce-style=3D"font-family: Tahoma , Arial , STHeiti , SimSun; font=
-size: 14.0px; color: #000000;"><br></div><div style=3D"font-family: Tahoma=
 , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;" data-mce-sty=
le=3D"font-family: Tahoma , Arial , STHeiti , SimSun; font-size: 14.0px; co=
lor: #000000;"><br></div><div style=3D"font-family: Tahoma , Arial , STHeit=
i , SimSun;font-size: 14.0px;color: #000000;" data-mce-style=3D"font-family=
: Tahoma , Arial , STHeiti , SimSun; font-size: 14.0px; color: #000000;"><b=
r></div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-s=
ize: 14.0px;color: #000000;" data-mce-style=3D"font-family: Tahoma , Arial =
, STHeiti , SimSun; font-size: 14.0px; color: #000000;">PS:My hardware</div=
><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14=
.0px;color: #000000;" data-mce-style=3D"font-family: Tahoma , Arial , STHei=
ti , SimSun; font-size: 14.0px; color: #000000;">2 x Xeon E5-2430 &nbsp;2.2=
0GHz 100MHz FSB (24 cores)&nbsp;94.6GB / 96GB 1333MHz DDR3 =3D=3D 6 x 16GB,=
 6 x empty</div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSu=
n;font-size: 14.0px;color: #000000;" data-mce-style=3D"font-family: Tahoma =
, Arial , STHeiti , SimSun; font-size: 14.0px; color: #000000;"><br></div><=
div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0=
px;color: #000000;" data-mce-style=3D"font-family: Tahoma , Arial , STHeiti=
 , SimSun; font-size: 14.0px; color: #000000;">Thanks</div><div style=3D"fo=
nt-family: Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #0000=
00;" data-mce-style=3D"font-family: Tahoma , Arial , STHeiti , SimSun; font=
-size: 14.0px; color: #000000;">zhenyu.ren</div><div style=3D"font-family: =
Tahoma , Arial , STHeiti , SimSun;font-size: 14.0px;color: #000000;" data-m=
ce-style=3D"font-family: Tahoma , Arial , STHeiti , SimSun; font-size: 14.0=
px; color: #000000;"><br></div><div class=3D"__aliyun_signature_wrap"><br><=
/div><div style=3D"font-family: Tahoma , Arial , STHeiti , SimSun;font-size=
: 14.0px;color: #000000;" data-mce-style=3D"font-family: Tahoma , Arial , S=
THeiti , SimSun; font-size: 14.0px; color: #000000;"><br></div></div><br>__=
_____________________________________________<br>lttng-dev mailing list<br>=
lttng-dev@lists.lttng.org<br><a href=3D"http://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" target=3D"_blank" data-mce-href=3D"http://lists.ltt=
ng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/m=
ailman/listinfo/lttng-dev</a><br></blockquote><div><br><div><br></div></div=
><div><br></div><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<b=
r><a href=3D"http://www.efficios.com" target=3D"_blank" data-mce-href=3D"ht=
tp://www.efficios.com">http://www.efficios.com</a><br></div></div></blockqu=
ote></div></blockquote><div><br><br></div><div><br></div><div>-- <br></div>=
<div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://w=
ww.efficios.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_40056_1352101328.1430274312544--




--===============0442350001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0442350001==--
