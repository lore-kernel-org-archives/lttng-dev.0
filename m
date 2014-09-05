From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: What is the cost of user-space tracepoint() ?
Date: Fri, 5 Sep 2014 19:19:01 +0000 (UTC)
Message-ID: <1562010587.18919.1409944741320.JavaMail.zimbra__30119.2544786774$1409944662$gmane$org@efficios.com>
References: <270cf1f7125a489fb6e4a3562c030944@hioexcmbx04-prd.hq.netapp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0704864783=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XPyzu-0002Oi-BQ
 for lttng-dev@lists.lttng.org; Fri, 05 Sep 2014 15:16:44 -0400
In-Reply-To: <270cf1f7125a489fb6e4a3562c030944@hioexcmbx04-prd.hq.netapp.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Venkatesh ChitlurSrinivasa <Venkatesh.Babu@netapp.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0704864783==
Content-Type: multipart/alternative;
	boundary="----=_Part_18918_1216876824.1409944741318"

------=_Part_18918_1216876824.1409944741318
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "Venkatesh ChitlurSrinivasa" <Venkatesh.Babu@netapp.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Friday, September 5, 2014 2:53:51 PM
> Subject: What is the cost of user-space tracepoint() ?

> Mathieu,

> I tried to send this email to lttng-dev@ but I didn't get any response. S=
o I
> am sending this directly to you. I greatly appreciate your response.

Hi Venkatesh,=20

Sorry, I was on vacation and just recently returned. I must admit I did not=
=20
have time to fully deal with my email backlog.=20

> =E2=80=8B

> We are planning to use LTTng UST as it supports lot of interesting featur=
es,
> but have some performance concerns (as compared with our in-house tracing
> tool). Please point me to the latest benchmark tests and performance
> results. On CPU Intel Xeon E5-2680 v2 @ 2.80GHz=E2=80=8B, running Linux 3=
.6.11=E2=80=8B and
> lttng 2.4.1, I am getting about 927 cycles (9270692144 cycles for 1000000=
0=E2=80=8B
> iterations). This seems to be lot higher than the documented results. In =
the
> paper https://lttng.org/files/papers/desnoyers.pdf the average cost of
> tracepoint() with older ltt-usertrace-fast tracepoint is 297 cycles. Anot=
her
> link http://lttng.org/files/thesis/desnoyers-thesis-defense-2009-12-e1.pd=
f
> says cache hot tracepoint() cost is 238 cycles. =E2=80=8B

Indeed, this is surprising. I would expect a performance figure in the area=
 of 500 cycles per=20
UST tracepoints on modern Intel processors with lttng-ust 2.x, using the Li=
nux kernel=20
monotonic clock.=20

> I noticed that the tracepoint is making clock_gettime() and sched_getcpu(=
)
> system calls. With Linux kernel v3.6.11 and libc v2.13-38+deb7u3, I see t=
hat
> these system calls are not going through VDSO and hence costing more. I
> tried to add wrapper functions for these system calls to call
> __vdso_clock_gettime and __vdso_getcpu as upgrading libc was not an optio=
n.
> With this change the cost of tracepoint() recording one integer dropped t=
o
> 795 cycles (=3D 284 nsec on Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz). S=
till
> this number seems to be higher than earlier published numbers.

Indeed, going through a syscall for gettime and getcpu can be a large=20
cause of performance degradation. Upgrading the libc is really recommended=
=20
here.=20

The latest published benchmarks I remember are actually a bit old (UST 0.11=
):=20

https://sourceware.org/ml/systemtap/2011-q1/msg00244.html=20

This gave 211 ns/event on a CPU Intel Xeon E5404 at 2.0GHz, for=20
422 cycles per event. I remember having seen benchmarks of more=20
recent lttng-ust 2.x around these numbers (or perhaps more around=20
275 ns/event).=20

With LTTng 2.x, we reworked the ring buffer and added features, but=20
indeed the figure of 795 cycles/event (just below 400ns/event at 2.0GHz)=20
is higher than expected.=20

One very important question: what payload are you tracing exactly ? Can=20
you create a small package with a simple benchmark program you use=20
so we can build it ourselves and try it out ?=20

Another thing to consider is that performance is likely limited by the=20
cache throughput, memory barrier execution and so on. Therefore,=20
just because your CPU is running at 2.8GHz does not mean we can=20
trace faster than with a CPU at 2.0GHz. Therefore, it might be better=20
to measure in ns per event rather than cycles per event.=20

Moreover, I'd be interested to see results of perf profiling of the=20
benchmark.=20

Thanks,=20

Mathieu=20

> VBabu

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_18918_1216876824.1409944741318
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Venkatesh ChitlurSrini=
vasa" &lt;Venkatesh.Babu@netapp.com&gt;<br><b>To: </b>"mathieu desnoyers" &=
lt;mathieu.desnoyers@efficios.com&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.o=
rg<br><b>Sent: </b>Friday, September 5, 2014 2:53:51 PM<br><b>Subject: </b>=
What is the cost of user-space tracepoint() ?<br><div><br></div><style styl=
e=3D"display:none"><!--P{margin-top:0;margin-bottom:0;} .ms-cui-menu {backg=
round-color:#ffffff;border:1px rgb(171, 171, 171) solid;font-family:'Segoe =
UI WPC', 'Segoe UI', Tahoma, 'Microsoft Sans Serif', Verdana, sans-serif;fo=
nt-size:11pt;color:rgb(51, 51, 51);} .ms-cui-menusection-title {display:non=
e;} .ms-cui-ctl {vertical-align:text-top;text-decoration:none;color:rgb(51,=
 51, 51);} .ms-cui-ctl-on {background-color:rgb(223, 237, 250);opacity: 0.8=
;} .ms-cui-img-cont-float {display:inline-block;margin-top:2px} .ms-cui-sme=
nu-inner {padding-top:0px;} .ms-owa-paste-option-icon {margin: 2px 4px 0px =
4px;vertical-align:sub;padding-bottom: 2px;display:inline-block;} .ms-rtePa=
steFlyout-option:hover {background-color:rgb(223, 237, 250) !important;opac=
ity:1 !important;} .ms-rtePasteFlyout-option {padding:8px 4px 8px 4px;outli=
ne:none;} .ms-cui-menusection {float:left; width:85px;height:24px;overflow:=
hidden}.wf {speak:none; font-weight:normal; font-variant:normal; text-trans=
form:none; -webkit-font-smoothing:antialiased; vertical-align:middle; displ=
ay:inline-block;}.wf-family-owa {font-family:'o365Icons'}@font-face {  font=
-family:'o365IconsIE8';  src:;  font-weight:normal;  font-style:normal;}.wf=
-family-owa {font-family:'o365IconsMouse'}.ie8 .wf-family-owa {font-family:=
'o365IconsIE8'}.ie8 .wf-owa-play-large:before {content:'\e254';}.notIE8 .wf=
-owa-play-large:before {content:'\e054';}.ie8 .wf-owa-play-large {color:#FF=
FFFF;}.notIE8 .wf-owa-play-large {border-color:#FFFFFF; width:1.4em; height=
:1.4em; border-width:.1em; border-style:solid; border-radius:.8em; text-ali=
gn:center; box-sizing:border-box; -moz-box-sizing:border-box; padding:0.1em=
; color:#FFFFFF;}.ie8 .wf-size-play-large {width:40px; height:40px; font-si=
ze:30px}.notIE8 .wf-size-play-large {width:40px; height:40px; font-size:30p=
x}
<!--
p
=09{margin-top:0;
=09margin-bottom:0}
.ms-cui-menu
=09{background-color:#ffffff;
=09border:1px rgb(171,171,171) solid;
=09font-family:'Segoe UI WPC','Segoe UI',Tahoma,'Microsoft Sans Serif',Verd=
ana,sans-serif;
=09font-size:11pt;
=09color:rgb(51,51,51)}
.ms-cui-menusection-title
=09{}
.ms-cui-ctl
=09{vertical-align:text-top;
=09text-decoration:none;
=09color:rgb(51,51,51)}
.ms-cui-ctl-on
=09{background-color:rgb(223,237,250)}
.ms-cui-img-cont-float
=09{display:inline-block;
=09margin-top:2px}
.ms-cui-smenu-inner
=09{padding-top:0px}
.ms-owa-paste-option-icon
=09{margin:2px 4px 0px 4px;
=09vertical-align:sub;
=09padding-bottom:2px;
=09display:inline-block}
.ms-rtePasteFlyout-option
=09{padding:8px 4px 8px 4px;
=09outline:none}
.ms-cui-menusection
=09{float:left;
=09width:85px;
=09height:24px;
=09overflow:hidden}
.wf
=09{speak:none;
=09font-weight:normal;
=09font-variant:normal;
=09text-transform:none;
=09vertical-align:middle;
=09display:inline-block}
.wf-family-owa
=09{font-family:'o365Icons'}
@font-face
=09{font-family:'o365IconsIE8';
=09font-weight:normal;
=09font-style:normal}
@font-face
=09{font-family:'o365IconsMouse';
=09font-weight:normal;
=09font-style:normal}
.wf-family-owa
=09{font-family:'o365IconsMouse'}
.ie8 .wf-family-owa
=09{font-family:'o365IconsIE8'}
.notIE8 .wf-owa-play-large
=09{border-color:#FFFFFF;
=09width:1.4em;
=09height:1.4em;
=09border-width:.1em;
=09border-style:solid;
=09text-align:center;
=09padding:0.1em;
=09color:#FFFFFF}
.ie8 .wf-size-play-large
=09{width:40px;
=09height:40px;
=09font-size:30px}
.notIE8 .wf-size-play-large
=09{width:40px;
=09height:40px;
=09font-size:30px}
-->
--></style><div style=3D"font-size:12pt;color:#000000;background-color:#FFF=
FFF;font-family:Calibri,Arial,Helvetica,sans-serif;"><style style=3D"">
<!--
p
=09{margin-top:0;
=09margin-bottom:0}
.ms-cui-menu
=09{background-color:#ffffff;
=09border:1px rgb(171,171,171) solid;
=09font-family:'Segoe UI WPC','Segoe UI',Tahoma,'Microsoft Sans Serif',Verd=
ana,sans-serif;
=09font-size:11pt;
=09color:rgb(51,51,51)}
.ms-cui-menusection-title
=09{}
.ms-cui-ctl
=09{vertical-align:text-top;
=09text-decoration:none;
=09color:rgb(51,51,51)}
.ms-cui-ctl-on
=09{background-color:rgb(223,237,250)}
.ms-cui-img-cont-float
=09{display:inline-block;
=09margin-top:2px}
.ms-cui-smenu-inner
=09{padding-top:0px}
.ms-owa-paste-option-icon
=09{margin:2px 4px 0px 4px;
=09vertical-align:sub;
=09padding-bottom:2px;
=09display:inline-block}
.ms-rtePasteFlyout-option
=09{padding:8px 4px 8px 4px;
=09outline:none}
.ms-cui-menusection
=09{float:left;
=09width:85px;
=09height:24px;
=09overflow:hidden}
.wf
=09{speak:none;
=09font-weight:normal;
=09font-variant:normal;
=09text-transform:none;
=09vertical-align:middle;
=09display:inline-block}
.wf-family-owa
=09{font-family:'o365Icons'}
@font-face
=09{font-family:'o365IconsIE8';
=09font-weight:normal;
=09font-style:normal}
@font-face
=09{font-family:'o365IconsMouse';
=09font-weight:normal;
=09font-style:normal}
.wf-family-owa
=09{font-family:'o365IconsMouse'}
.ie8 .wf-family-owa
=09{font-family:'o365IconsIE8'}
.notIE8 .wf-owa-play-large
=09{border-color:#FFFFFF;
=09width:1.4em;
=09height:1.4em;
=09border-width:.1em;
=09border-style:solid;
=09text-align:center;
=09padding:0.1em;
=09color:#FFFFFF}
.ie8 .wf-size-play-large
=09{width:40px;
=09height:40px;
=09font-size:30px}
.notIE8 .wf-size-play-large
=09{width:40px;
=09height:40px;
=09font-size:30px}
-->
</style><div style=3D"background-color: rgb(255, 255, 255);"><p style=3D"co=
lor: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica, sans-serif; font=
-size: 12pt;"><span style=3D"color:rgb(40,40,40); font-family:'Segoe UI WPC=
','Segoe UI',Tahoma,'Microsoft Sans Serif',Verdana,sans-serif; font-size:13=
px">Mathieu,</span></p><p><br><span style=3D"color: #282828; font-family: S=
egoe UI WPC,Segoe UI,Tahoma,Microsoft Sans Serif,Verdana,sans-serif; font-s=
ize: small;" data-mce-style=3D"color: #282828; font-family: Segoe UI WPC,Se=
goe UI,Tahoma,Microsoft Sans Serif,Verdana,sans-serif; font-size: small;" c=
olor=3D"#282828" face=3D"Segoe UI WPC, Segoe UI, Tahoma, Microsoft Sans Ser=
if, Verdana, sans-serif" size=3D"2">I tried to send this email to&nbsp;lttn=
g-dev@&nbsp;but I didn't get any response. So I am sending this directly to=
 you. I greatly&nbsp;appreciate&nbsp;your response.</span></p></div></div><=
/blockquote><div>Hi Venkatesh,<br></div><div><br></div><div>Sorry, I was on=
 vacation and just recently returned. I must admit I did not<br></div><div>=
have time to fully deal with my email backlog.<br></div><div><br></div><blo=
ckquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left=
:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;f=
ont-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div style=3D"font-s=
ize:12pt;color:#000000;background-color:#FFFFFF;font-family:Calibri,Arial,H=
elvetica,sans-serif;"><div style=3D"background-color: rgb(255, 255, 255);">=
<p style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica, sa=
ns-serif; font-size: 12pt;"><span style=3D"color:rgb(40,40,40); font-family=
:'Segoe UI WPC','Segoe UI',Tahoma,'Microsoft Sans Serif',Verdana,sans-serif=
; font-size:13px">=E2=80=8B<br>
</span></p><p style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, He=
lvetica, sans-serif; font-size: 12pt;"><span style=3D"color:rgb(40,40,40); =
font-family:'Segoe UI WPC','Segoe UI',Tahoma,'Microsoft Sans Serif',Verdana=
,sans-serif; font-size:13px">We are planning to use LTTng UST as it support=
s lot of interesting features, but have some performance concerns (as compa=
red
 with our in-house tracing tool). Please point me to the latest benchmark t=
ests and performance results.&nbsp;<span style=3D"color: rgb(40, 40, 40); f=
ont-family: 'Segoe UI WPC', 'Segoe UI', Tahoma, 'Microsoft Sans Serif', Ver=
dana, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">O=
n&nbsp;CPU&nbsp;Intel
 Xeon&nbsp;E5-2680 v2 @ 2.80GHz=E2=80=8B, running Linux&nbsp;3.6.11=E2=80=
=8B and lttng 2.4.1, &nbsp;I am getting&nbsp;about 927 cycles (9270692144 c=
ycles for&nbsp;10000000=E2=80=8B iterations). This seems to be lot higher t=
han the documented results. In the paper&nbsp;</span><a href=3D"https://ltt=
ng.org/files/papers/desnoyers.pdf" target=3D"_blank" style=3D"font-family: =
'Segoe UI WPC', 'Segoe UI', Tahoma, 'Microsoft Sans Serif', Verdana, sans-s=
erif; font-size: 13px; background-color: rgb(255, 255, 255);">https://lttng=
.org/files/papers/desnoyers.pdf</a><span style=3D"color: rgb(40, 40, 40); f=
ont-family: 'Segoe UI WPC', 'Segoe UI', Tahoma, 'Microsoft Sans Serif', Ver=
dana, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">&=
nbsp;&nbsp;the
 average&nbsp;cost of tracepoint() with older&nbsp;ltt-usertrace-fast trace=
point is 297 cycles. Another link&nbsp;</span><a href=3D"http://lttng.org/f=
iles/thesis/desnoyers-thesis-defense-2009-12-e1.pdf" target=3D"_blank" styl=
e=3D"font-family: 'Segoe UI WPC', 'Segoe UI', Tahoma, 'Microsoft Sans Serif=
', Verdana, sans-serif; font-size: 13px; background-color: rgb(255, 255, 25=
5);">http://lttng.org/files/thesis/desnoyers-thesis-defense-2009-12-e1.pdf<=
/a><span style=3D"color: rgb(40, 40, 40); font-family: 'Segoe UI WPC', 'Seg=
oe UI', Tahoma, 'Microsoft Sans Serif', Verdana, sans-serif; font-size: 13p=
x; background-color: rgb(255, 255, 255);">&nbsp;says
 cache hot tracepoint() cost is 238 cycles.</span><span style=3D"font-famil=
y: Calibri, Arial, Helvetica, sans-serif; font-size: 16px; background-color=
: rgb(255, 255, 255);">=E2=80=8B</span></span></p></div></div></blockquote>=
<div>Indeed, this is surprising. I would expect a performance figure in the=
 area of 500 cycles per<br></div><div>UST tracepoints on modern Intel proce=
ssors with lttng-ust 2.x, using the Linux kernel<br></div><div>monotonic cl=
ock.<br></div><div><br></div><blockquote style=3D"border-left:2px solid #10=
10FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt;"><div style=3D"font-size:12pt;color:#000000;background-color:#F=
FFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;"><div style=3D"backgr=
ound-color: rgb(255, 255, 255);"><p style=3D"color: rgb(0, 0, 0); font-fami=
ly: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;"><br style=3D"c=
olor:rgb(40,40,40); font-family:'Segoe UI WPC','Segoe UI',Tahoma,'Microsoft=
 Sans Serif',Verdana,sans-serif; font-size:13px; background-color:rgb(255,2=
55,255)"><span style=3D"color:rgb(40,40,40); font-family:'Segoe UI WPC','Se=
goe UI',Tahoma,'Microsoft Sans Serif',Verdana,sans-serif; font-size:13px; b=
ackground-color:rgb(255,255,255)">I noticed that the tracepoint is making c=
lock_gettime() and sched_getcpu() system calls.
 With Linux kernel v3.6.11 and libc v2.13-38+deb7u3, I see that these syste=
m calls are not going through VDSO and hence costing more. I tried to add w=
rapper functions for these system calls to call __vdso_clock_gettime and __=
vdso_getcpu as upgrading libc was
 not an option. With this change the cost of tracepoint() recording one int=
eger dropped to 795 cycles (=3D 284 nsec on Intel(R) Xeon(R) CPU E5-2680 v2=
 @ 2.80GHz). Still this number seems to be higher than earlier published nu=
mbers.&nbsp;</span></p></div></div></blockquote><div>Indeed, going through =
a syscall for gettime and getcpu can be a large<br></div><div>cause of perf=
ormance degradation. Upgrading the libc is really recommended<br></div><div=
>here.<br></div><div><br></div><div>The latest published benchmarks I remem=
ber are actually a bit old (UST 0.11):<br></div><div><br></div><div>https:/=
/sourceware.org/ml/systemtap/2011-q1/msg00244.html</div><div><br></div><div=
>This gave 211 ns/event on a CPU Intel Xeon E5404 at 2.0GHz, for<br></div><=
div>422 cycles per event. I remember having seen benchmarks of more<br></di=
v><div>recent lttng-ust 2.x around these numbers (or perhaps more around</d=
iv><div>275 ns/event).<br></div><div><br></div><div>With LTTng 2.x, we rewo=
rked the ring buffer and added features, but<br></div><div>indeed the figur=
e of 795 cycles/event (just below 400ns/event at 2.0GHz)</div><div>is highe=
r than expected.<br></div><div><br></div><div>One very important question: =
what payload are you tracing exactly ? Can<br></div><div>you create a small=
 package with a simple benchmark program you use<br></div><div>so we can bu=
ild it ourselves and try it out ?<br></div><div><br></div><div>Another thin=
g to consider is that performance is likely limited by the<br></div><div>ca=
che throughput, memory barrier execution and so on. Therefore,</div><div>ju=
st because your CPU is running at 2.8GHz does not mean we can<br></div><div=
>trace faster than with a CPU at 2.0GHz. Therefore, it might be better<br><=
/div><div>to measure in ns per event rather than cycles per event.<br></div=
><div><br></div><div>Moreover, I'd be interested to see results of perf pro=
filing of the<br></div><div>benchmark.<br></div><div><br></div><div>Thanks,=
<br></div><div><br></div><div>Mathieu<br></div><div><br></div><div><br></di=
v><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;paddin=
g-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:=
none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div style=3D"=
font-size:12pt;color:#000000;background-color:#FFFFFF;font-family:Calibri,A=
rial,Helvetica,sans-serif;"><div style=3D"background-color: rgb(255, 255, 2=
55);"><p style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt;"><br style=3D"color:rgb(40,40,40); font-fa=
mily:'Segoe UI WPC','Segoe UI',Tahoma,'Microsoft Sans Serif',Verdana,sans-s=
erif; font-size:13px; background-color:rgb(255,255,255)"><span style=3D"col=
or:rgb(40,40,40); font-family:'Segoe UI WPC','Segoe UI',Tahoma,'Microsoft S=
ans Serif',Verdana,sans-serif; font-size:13px; background-color:rgb(255,255=
,255)">VBabu</span><br></p></div></div></blockquote><div><br><br></div><div=
><br></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers=
<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></d=
iv></div></body></html>
------=_Part_18918_1216876824.1409944741318--


--===============0704864783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0704864783==--
