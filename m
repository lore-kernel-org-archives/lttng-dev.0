From: Neil Bryan <Neil.Bryan@ttp.com>
Subject: Limited event types displayed.
Date: Thu, 19 Feb 2015 11:31:05 +0000
Message-ID: <8369DAE2C5B8814998E89CE414A915381F6B7DFB__40855.2429559224$1424345543$gmane$org@IT-Mailbox3.TTPGroup.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0828704071=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Neil.Bryan@ttp.com>) id 1YOPK2-0001zG-Ut
 for lttng-dev@lists.lttng.org; Thu, 19 Feb 2015 06:31:14 -0500
Content-Language: en-US
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

--===============0828704071==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_8369DAE2C5B8814998E89CE414A915381F6B7DFBITMailbox3TTPGr_"

--_000_8369DAE2C5B8814998E89CE414A915381F6B7DFBITMailbox3TTPGr_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Forum,

Now that I have got LTTng built, I have tried some preliminary tests. Unfor=
tunately the results are not quite as I expect.
I have used LTTng previously, although I did not perform the kernel integra=
tion. Using Eclipse TFM I could see various processes in the Control Flow t=
ab.
With low-level kernel events (interrupts, sched_wakeup etc) causing threads=
 to run or remain blocked. On my system I only see event data in the Histog=
ram view and in the Statistics tab.
Something has not been enabled in my build (tracepoints?) and I only have a=
 limited amount of instrumentation. My Control Flow tab is blank and I don'=
t see any driver threads or stuff
that I am interested. Any clues as to what is missing?

I imported this into eclipse as a Generic CTF Trace. Using LTTng kernel tra=
ce gave me a Validation Failed error. I have checked the plug-ins and featu=
res on eclipse (Version: Kepler Service Release 2
Build id: 20140224-0627) and all looks sensible.

A brief snippet running babeltrace on the collected trace reveals:

[01:00:04.612915372] (+0.009500290) irq_handler_entry: { cpu_id =3D 0 }, { =
irq =3D 690, name =3D "serial" }
[01:00:04.612922812] (+0.000007440) sched_wakeup: { cpu_id =3D 0 }, { comm =
=3D "kworker/0:1", tid =3D 305, prio =3D 120, success =3D 1, target_cpu =3D=
 0 }
[01:00:04.612927192] (+0.000004380) irq_handler_exit: { cpu_id =3D 0 }, { i=
rq =3D 690, ret =3D 1 }
[01:00:04.612936292] (+0.000009100) sched_switch: { cpu_id =3D 0 }, { prev_=
comm =3D "swapper/0", prev_tid =3D 0, prev_prio =3D 20, prev_state =3D 0, n=
ext_comm =3D "kworker/0:1", next_tid =3D 305, next_prio =3D 20 }
[01:00:04.612946732] (+0.000010440) sched_stat_runtime: { cpu_id =3D 0 }, {=
 comm =3D "kworker/0:1", tid =3D 305, runtime =3D 24080, vruntime =3D 16806=
205315 }
[01:00:04.612949162] (+0.000002430) sched_wakeup: { cpu_id =3D 0 }, { comm =
=3D "sh", tid =3D 737, prio =3D 120, success =3D 1, target_cpu =3D 0 }
[01:00:04.612955572] (+0.000006410) sched_stat_runtime: { cpu_id =3D 0 }, {=
 comm =3D "kworker/0:1", tid =3D 305, runtime =3D 9450, vruntime =3D 168062=
14765 }
[01:00:04.612958762] (+0.000003190) sched_switch: { cpu_id =3D 0 }, { prev_=
comm =3D "kworker/0:1", prev_tid =3D 305, prev_prio =3D 20, prev_state =3D =
1, next_comm =3D "sh", next_tid =3D 737, next_prio =3D 20 }
[01:00:04.612968132] (+0.000009370) exit_syscall: { cpu_id =3D 0 }, { ret =
=3D 3 }
[01:00:04.612977692] (+0.000009560) sys_unknown: { cpu_id =3D 0 }, { id =3D=
 175, args =3D [ [0] =3D 0, [1] =3D 672496, [2] =3D 672624, [3] =3D 8, [4] =
=3D 672624, [5] =3D 0 ] }
[01:00:04.612980852] (+0.000003160) exit_syscall: { cpu_id =3D 0 }, { ret =
=3D 175 }
[01:00:04.612992172] (+0.000011320) sys_unknown: { cpu_id =3D 0 }, { id =3D=
 4, args =3D [ [0] =3D 2, [1] =3D 692232, [2] =3D 1, [3] =3D 0, [4] =3D 199=
5966936, [5] =3D 1 ] }
[01:00:04.613000852] (+0.000008680) irq_handler_entry: { cpu_id =3D 0 }, { =
irq =3D 690, name =3D "serial" }
[01:00:04.613005092] (+0.000004240) sched_wakeup: { cpu_id =3D 0 }, { comm =
=3D "sh", tid =3D 737, prio =3D 120, success =3D 1, target_cpu =3D 0 }
[01:00:04.613009332] (+0.000004240) irq_handler_exit: { cpu_id =3D 0 }, { i=
rq =3D 690, ret =3D 1 }
[01:00:04.613015122] (+0.000005790) exit_syscall: { cpu_id =3D 0 }, { ret =
=3D 4 }
[01:00:04.613018292] (+0.000003170) sys_unknown: { cpu_id =3D 0 }, { id =3D=
 175, args =3D [ [0] =3D 2, [1] =3D 672624, [2] =3D 0, [3] =3D 8, [4] =3D 0=
, [5] =3D 2 ] }
[01:00:04.613020812] (+0.000002520) exit_syscall: { cpu_id =3D 0 }, { ret =
=3D 175 }
[01:00:04.613025972] (+0.000005160) sys_unknown: { cpu_id =3D 0 }, { id =3D=
 3, args =3D [ [0] =3D 0, [1] =3D 2125890263, [2] =3D 1, [3] =3D 2183135232=
, [4] =3D 1995967256, [5] =3D 673032 ] }
[01:00:04.613033202] (+0.000007230) sched_stat_runtime: { cpu_id =3D 0 }, {=
 comm =3D "sh", tid =3D 737, runtime =3D 77130, vruntime =3D 16806387825 }
[01:00:04.613040642] (+0.000007440) sched_switch: { cpu_id =3D 0 }, { prev_=
comm =3D "sh", prev_tid =3D 737, prev_prio =3D 20, prev_state =3D 1, next_c=
omm =3D "swapper/0", next_tid =3D 0, next_prio =3D 20 }
[01:00:04.613393572] (+0.000352930) irq_handler_entry: { cpu_id =3D 1 }, { =
irq =3D 525, name =3D "twd" }
[01:00:04.613394242] (+0.000000670) irq_handler_entry: { cpu_id =3D 0 }, { =
irq =3D 525, name =3D "twd" }
[01:00:04.613396802] (+0.000002560) softirq_raise: { cpu_id =3D 1 }, { vec =
=3D 1 }
[01:00:04.613400192] (+0.000003390) softirq_raise: { cpu_id =3D 1 }, { vec =
=3D 7 }
[01:00:04.613401732] (+0.000001540) softirq_raise: { cpu_id =3D 0 }, { vec =
=3D 1 }



Thank you for any help you can offer.

Regards,

Neil.

--_000_8369DAE2C5B8814998E89CE414A915381F6B7DFBITMailbox3TTPGr_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:2.0cm 42.5pt 2.0cm 3.0cm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Forum,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Now that I have got LTTng built, I have tried some p=
reliminary tests. Unfortunately the results are not quite as I expect.<o:p>=
</o:p></p>
<p class=3D"MsoNormal">I have used LTTng previously, although I did not per=
form the kernel integration. Using Eclipse TFM I could see various processe=
s in the Control Flow tab.<o:p></o:p></p>
<p class=3D"MsoNormal">With low-level kernel events (interrupts, sched_wake=
up etc) causing threads to run or remain blocked. On my system I only see e=
vent data in the Histogram view and in the Statistics tab.<o:p></o:p></p>
<p class=3D"MsoNormal">Something has not been enabled in my build (tracepoi=
nts?) and I only have a limited amount of instrumentation. My Control Flow =
tab is blank and I don&#8217;t see any driver threads or stuff
<o:p></o:p></p>
<p class=3D"MsoNormal">that I am interested. Any clues as to what is missin=
g?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">I imported this into e=
clipse as a Generic CTF Trace. Using LTTng kernel trace gave me a Validatio=
n Failed error. I have checked the plug-ins and features on eclipse (<span =
style=3D"font-size:9.0pt;font-family:&quot;Segoe UI&quot;,&quot;sans-serif&=
quot;">Version:
 Kepler Service Release 2<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Seg=
oe UI&quot;,&quot;sans-serif&quot;">Build id: 20140224-0627)
</span>and all looks sensible.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">A brief snippet running babeltrace on the collected =
trace reveals:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[01:00:04.612915372] (&#43;0.009500290) irq_handler_=
entry: { cpu_id =3D 0 }, { irq =3D 690, name =3D &quot;serial&quot; }<o:p><=
/o:p></p>
<p class=3D"MsoNormal">[01:00:04.612922812] (&#43;0.000007440) sched_wakeup=
: { cpu_id =3D 0 }, { comm =3D &quot;kworker/0:1&quot;, tid =3D 305, prio =
=3D 120, success =3D 1, target_cpu =3D 0 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.612927192] (&#43;0.000004380) irq_handler_=
exit: { cpu_id =3D 0 }, { irq =3D 690, ret =3D 1 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.612936292] (&#43;0.000009100) sched_switch=
: { cpu_id =3D 0 }, { prev_comm =3D &quot;swapper/0&quot;, prev_tid =3D 0, =
prev_prio =3D 20, prev_state =3D 0, next_comm =3D &quot;kworker/0:1&quot;, =
next_tid =3D 305, next_prio =3D 20 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.612946732] (&#43;0.000010440) sched_stat_r=
untime: { cpu_id =3D 0 }, { comm =3D &quot;kworker/0:1&quot;, tid =3D 305, =
runtime =3D 24080, vruntime =3D 16806205315 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.612949162] (&#43;0.000002430) sched_wakeup=
: { cpu_id =3D 0 }, { comm =3D &quot;sh&quot;, tid =3D 737, prio =3D 120, s=
uccess =3D 1, target_cpu =3D 0 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.612955572] (&#43;0.000006410) sched_stat_r=
untime: { cpu_id =3D 0 }, { comm =3D &quot;kworker/0:1&quot;, tid =3D 305, =
runtime =3D 9450, vruntime =3D 16806214765 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.612958762] (&#43;0.000003190) sched_switch=
: { cpu_id =3D 0 }, { prev_comm =3D &quot;kworker/0:1&quot;, prev_tid =3D 3=
05, prev_prio =3D 20, prev_state =3D 1, next_comm =3D &quot;sh&quot;, next_=
tid =3D 737, next_prio =3D 20 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.612968132] (&#43;0.000009370) exit_syscall=
: { cpu_id =3D 0 }, { ret =3D 3 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.612977692] (&#43;0.000009560) sys_unknown:=
 { cpu_id =3D 0 }, { id =3D 175, args =3D [ [0] =3D 0, [1] =3D 672496, [2] =
=3D 672624, [3] =3D 8, [4] =3D 672624, [5] =3D 0 ] }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.612980852] (&#43;0.000003160) exit_syscall=
: { cpu_id =3D 0 }, { ret =3D 175 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.612992172] (&#43;0.000011320) sys_unknown:=
 { cpu_id =3D 0 }, { id =3D 4, args =3D [ [0] =3D 2, [1] =3D 692232, [2] =
=3D 1, [3] =3D 0, [4] =3D 1995966936, [5] =3D 1 ] }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.613000852] (&#43;0.000008680) irq_handler_=
entry: { cpu_id =3D 0 }, { irq =3D 690, name =3D &quot;serial&quot; }<o:p><=
/o:p></p>
<p class=3D"MsoNormal">[01:00:04.613005092] (&#43;0.000004240) sched_wakeup=
: { cpu_id =3D 0 }, { comm =3D &quot;sh&quot;, tid =3D 737, prio =3D 120, s=
uccess =3D 1, target_cpu =3D 0 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.613009332] (&#43;0.000004240) irq_handler_=
exit: { cpu_id =3D 0 }, { irq =3D 690, ret =3D 1 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.613015122] (&#43;0.000005790) exit_syscall=
: { cpu_id =3D 0 }, { ret =3D 4 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.613018292] (&#43;0.000003170) sys_unknown:=
 { cpu_id =3D 0 }, { id =3D 175, args =3D [ [0] =3D 2, [1] =3D 672624, [2] =
=3D 0, [3] =3D 8, [4] =3D 0, [5] =3D 2 ] }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.613020812] (&#43;0.000002520) exit_syscall=
: { cpu_id =3D 0 }, { ret =3D 175 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.613025972] (&#43;0.000005160) sys_unknown:=
 { cpu_id =3D 0 }, { id =3D 3, args =3D [ [0] =3D 0, [1] =3D 2125890263, [2=
] =3D 1, [3] =3D 2183135232, [4] =3D 1995967256, [5] =3D 673032 ] }<o:p></o=
:p></p>
<p class=3D"MsoNormal">[01:00:04.613033202] (&#43;0.000007230) sched_stat_r=
untime: { cpu_id =3D 0 }, { comm =3D &quot;sh&quot;, tid =3D 737, runtime =
=3D 77130, vruntime =3D 16806387825 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.613040642] (&#43;0.000007440) sched_switch=
: { cpu_id =3D 0 }, { prev_comm =3D &quot;sh&quot;, prev_tid =3D 737, prev_=
prio =3D 20, prev_state =3D 1, next_comm =3D &quot;swapper/0&quot;, next_ti=
d =3D 0, next_prio =3D 20 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.613393572] (&#43;0.000352930) irq_handler_=
entry: { cpu_id =3D 1 }, { irq =3D 525, name =3D &quot;twd&quot; }<o:p></o:=
p></p>
<p class=3D"MsoNormal">[01:00:04.613394242] (&#43;0.000000670) irq_handler_=
entry: { cpu_id =3D 0 }, { irq =3D 525, name =3D &quot;twd&quot; }<o:p></o:=
p></p>
<p class=3D"MsoNormal">[01:00:04.613396802] (&#43;0.000002560) softirq_rais=
e: { cpu_id =3D 1 }, { vec =3D 1 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.613400192] (&#43;0.000003390) softirq_rais=
e: { cpu_id =3D 1 }, { vec =3D 7 }<o:p></o:p></p>
<p class=3D"MsoNormal">[01:00:04.613401732] (&#43;0.000001540) softirq_rais=
e: { cpu_id =3D 0 }, { vec =3D 1 }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you for any help you can offer.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Neil.<o:p></o:p></p>
</div>
</body>
</html>

--_000_8369DAE2C5B8814998E89CE414A915381F6B7DFBITMailbox3TTPGr_--


--===============0828704071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0828704071==--
