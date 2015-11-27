From: "Luetkebohle Ingo (CR/AEA2)" <Ingo.Luetkebohle@de.bosch.com>
Subject: Re: faulty context for sched_stat_ tracepoints?
Date: Fri, 27 Nov 2015 08:12:53 +0000
Message-ID: <1448611973250.88200__12311.9606091224$1448612056$gmane$org@de.bosch.com>
References: <73b02dedea024337886a82474372bcde@FE-MBX1025.de.bosch.com>
 <1809072616.157482.1448551313021.JavaMail.zimbra@efficios.com>
 <1448553523339.1387@de.bosch.com>
 <1983684660.158379.1448554828712.JavaMail.zimbra@efficios.com>
 <1448557049163.69693@de.bosch.com>,
 <1483147677.158546.1448557551137.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0468741105=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Ingo.Luetkebohle@de.bosch.com>) id 1a2E9L-0008Go-QD
 for lttng-dev@lists.lttng.org; Fri, 27 Nov 2015 03:13:04 -0500
In-Reply-To: <1483147677.158546.1448557551137.JavaMail.zimbra@efficios.com>
Content-Language: de-DE
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Philippe Proulx <philippe.proulx@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0468741105==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_144861197325088200deboschcom_"

--_000_144861197325088200deboschcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,


I didn't mean to suggest some kind of "intermingling". I merely thought tha=
t, because for every other kind of tracepoint, the "context" is the executi=
on context of the task that *caused* the tracepoint (which happens to be th=
e same as the *current* context in almost all cases), it would be consisten=
t if this were the case for scheduler-tracepoints also. This seems to make =
more sense to me.


but I don't really feel strongly about this, and you're the experts, so if =
you prefer it to be the current context in all cases, I'll acquiesce.

cheers

Dr. Ingo L=FCtkebohle
Software Design and Analysis -- Robotics (CR/AEA2)

Tel. +49(711)811-12248
Fax +49(711)811-0
Mobil +49-1525-8813417
Ingo.Luetkebohle@de.bosch.com<mailto:Ingo.Luetkebohle@de.bosch.com>
________________________________
Von: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Gesendet: Donnerstag, 26. November 2015 18:05
An: Luetkebohle Ingo (CR/AEA2); Philippe Proulx
Cc: lttng-dev
Betreff: Re: AW: AW: [lttng-dev] faulty context for sched_stat_ tracepoints=
?

We could perhaps clarify our documentation to state that the "context"
info gathered by lttng is that of the execution context when the tracepoint
is invoked, but I'm afraid we won't start intermingling the tracepoint payl=
oad
information with context. This would be both technologically cumbersome,
and confusing.

I'm CCing Philippe Proulx who maintains our documentation,

Thanks,

Mathieu

----- On Nov 26, 2015, at 11:57 AM, Luetkebohle Ingo (CR/AEA2) <Ingo.Luetke=
bohle@de.bosch.com> wrote:

Hi,


well, the thing is, when I add "context" information, I want more informati=
on on the task of the tracepoint.  That the tracepoint is executed in a sit=
uation where the *kernel* already has a new task context is of no interest =
to me as a user.


Therefore, I would argue that what lttng treats as the context should, in t=
his situation, be something different from what the kernel treats as its co=
ntext.


Don't know if that's *possible*, but its what I would expect ;-)

YMMV, of course.


cheers


Dr. Ingo L=FCtkebohle
Software Design and Analysis -- Robotics (CR/AEA2)

Tel. +49(711)811-12248
Fax +49(711)811-0
Mobil +49-1525-8813417
Ingo.Luetkebohle@de.bosch.com<mailto:Ingo.Luetkebohle@de.bosch.com>
________________________________
Von: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Gesendet: Donnerstag, 26. November 2015 17:20
An: Luetkebohle Ingo (CR/AEA2)
Cc: lttng-dev
Betreff: Re: AW: [lttng-dev] faulty context for sched_stat_ tracepoints?


----- On Nov 26, 2015, at 10:58 AM, Luetkebohle Ingo (CR/AEA2) <Ingo.Luetke=
bohle@de.bosch.com> wrote:

Hi Mathieu,


thank you for the explanation!


This would suggest that the problem only occurs for scheduler events, becau=
se only then we have this situation that the currently scheduled task is no=
t the one that the tracepoint relates that. Am I interpreting that correctl=
y?

AFAIK, only the scheduler tracepoints pass a task struct as parameter (the =
one being
acted upon) that can differ from the current task. So yes, this kind of sit=
uation where a
tracepoint receives a task other than current as parameter pretty much only=
 happens
in the scheduler instrumentation.



If yes, this would certainly ease my concerns, because for most tracepoints=
, I get the expected behavior. I can also get the information that I want r=
ight now by looking at comm instead.


However, for future development of LTTng: Isn't the intuitive context that =
of the *tracepoint*? In other words, isn't it wrong to always use the curre=
ntly scheduled task?

By definition, the "current" task holds the current context, which is the
one saved in the tid/procname lttng context.

The task passed as parameter to the tracepoint is the task acted upon
in this case, not the currently running one anymore. Therefore, the "contex=
t" of the
tracepoint _is_ the currently running task, not the one passed as parameter=
.

This highlights something that might not be obvious at first: when the sche=
duler
puts a task into a sleeper queue, it does so while running in the context o=
f the
newly scheduled task.

Thanks,

Mathieu




cheers,


Dr. Ingo L=FCtkebohle
Software Design and Analysis -- Robotics (CR/AEA2)

Tel. +49(711)811-12248
Fax +49(711)811-0
Mobil +49-1525-8813417
Ingo.Luetkebohle@de.bosch.com<mailto:Ingo.Luetkebohle@de.bosch.com>
________________________________
Von: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Gesendet: Donnerstag, 26. November 2015 16:21
An: Luetkebohle Ingo (CR/AEA2)
Cc: lttng-dev
Betreff: Re: [lttng-dev] faulty context for sched_stat_ tracepoints?
---- On Nov 26, 2015, at 7:34 AM, Luetkebohle Ingo (CR/AEA2) <Ingo.Luetkebo=
hle@de.bosch.com> wrote:
Hi,

I noticed that the "procname" and "tid" *context* variables can differ from=
 the "comm" and "tid" variables of the sched_stat_-tracepoints (e.g., for s=
ched_stat_runtime).

For example, see the following two outputs:
[15:49:33.674072890] (+0.000029771) rng2070 sched_stat_sleep: { cpu_id =3D =
4 }, { pid =3D 26974, procname =3D "amcl", tid =3D 26975 }, { comm =3D "ltt=
ng-sessiond", tid =3D 798, delay =3D 194122524 }
[15:49:33.722894563] (+0.000004851) rng2070 sched_stat_sleep: { cpu_id =3D =
0 }, { pid =3D 0, procname =3D "swapper/0", tid =3D 0 }, { comm =3D "amcl",=
 tid =3D 27078, delay =3D 10043658 }

In both cases, procname differs from comm.  I've looked at the kernel sourc=
e code, and the "comm" variable is taken from task_struct.filename. Barring=
 renames, this would be the correct one, so I'm assuming that the context i=
s sometimes incorrect.

Now, for this particular case, I can take the correct variables from the tr=
acepoint, but of course, this makes me worried that the context might also =
be wrong in other cases... Do you have any idea what could be going on here=
?

LTTng is Version 2.7.x+stable+bzr2948+pack17+201511192116~ubuntu14.04.1 and=
 this is on a 3.19.0-33-generic kernel (btw, that's not the default kernel =
for Ubuntu 14.04, but the LTS vivid backport kernel).
Hi,

Looking at lttng-modules lttng-context-tid.c tid_record(), we see that it u=
ses task_pid_nr(current).
It therefore gets the tid of the currently scheduled task. This is similar =
for procname.

Now looking at the Linux kernel kernel/sched/fair.c: enqueue_sleeper(), whi=
ch calls
trace_sched_stat_sleep(), we see that it passes "tsk" as parameter to the t=
racepoint.
Already here, nothing seems to ensure that "tsk" is the currently scheduled=
 task. It's
rather a task that is being put to sleep. Looking at the callers of enqueue=
_sleeper(),
we can understand that the current task is first scheduled out before being=
 enqueued
as a sleeper. This is why, when we hit the sched_stat_sleep tracepoint, the=
 current
task is not "tsk", which explains the difference between the context inform=
ation
and the tracepoint payload information: they really target different tasks.

Does this help solve your concerns ?

Thanks,

Mathieu


Mit freundlichen Gr=FC=DFen / Best regards

Ingo Luetkebohle

Application Software (CR/AEA2)
Tel. +49(711)811-12248 | Fax +49(711)811-0 | Ingo.Luetkebohle@de.bosch.com<=
mailto:Ingo.Luetkebohle@de.bosch.com>



_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com


--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com


--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

--_000_144861197325088200deboschcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none"><!--P{margin-top:0;margin-b=
ottom:0;} p=0A=
	{margin-top:0;=0A=
	margin-bottom:0}=0A=
@font-face=0A=
	{font-family:"Cambria Math"}=0A=
@font-face=0A=
	{font-family:Calibri}=0A=
p.MsoNormal, li.MsoNormal, div.MsoNormal=0A=
	{margin:0cm;=0A=
	margin-bottom:.0001pt;=0A=
	font-size:11.0pt;=0A=
	font-family:"Calibri",sans-serif}=0A=
a:link, span.MsoHyperlink=0A=
	{color:#0563C1;=0A=
	text-decoration:underline}=0A=
a:visited, span.MsoHyperlinkFollowed=0A=
	{color:#954F72;=0A=
	text-decoration:underline}=0A=
span.EmailStyle17=0A=
	{font-family:"Arial",sans-serif;=0A=
	color:windowtext;=0A=
	font-weight:normal;=0A=
	font-style:normal}=0A=
.MsoChpDefault=0A=
	{font-family:"Calibri",sans-serif}=0A=
@page WordSection1=0A=
	{margin:70.85pt 70.85pt 2.0cm 70.85pt}=0A=
@font-face=0A=
	{font-family:"Cambria Math"}=0A=
@font-face=0A=
	{font-family:Calibri}=0A=
p.MsoNormal, li.MsoNormal, div.MsoNormal=0A=
	{margin:0cm;=0A=
	margin-bottom:.0001pt;=0A=
	font-size:11.0pt;=0A=
	font-family:"Calibri",sans-serif}=0A=
a:link, span.MsoHyperlink=0A=
	{color:#0563C1;=0A=
	text-decoration:underline}=0A=
a:visited, span.MsoHyperlinkFollowed=0A=
	{color:#954F72;=0A=
	text-decoration:underline}=0A=
span.EmailStyle17=0A=
	{font-family:"Arial",sans-serif;=0A=
	color:windowtext;=0A=
	font-weight:normal;=0A=
	font-style:normal}=0A=
.MsoChpDefault=0A=
	{font-family:"Calibri",sans-serif}=0A=
@page WordSection1=0A=
	{margin:70.85pt 70.85pt 2.0cm 70.85pt}p=0A=
	{margin-top:0;=0A=
	margin-bottom:0}=0A=
@font-face=0A=
	{font-family:"Cambria Math"}=0A=
@font-face=0A=
	{font-family:Calibri}=0A=
p.MsoNormal, li.MsoNormal, div.MsoNormal=0A=
	{margin:0cm;=0A=
	margin-bottom:.0001pt;=0A=
	font-size:11.0pt;=0A=
	font-family:"Calibri",sans-serif}=0A=
a:link, span.MsoHyperlink=0A=
	{color:#0563C1;=0A=
	text-decoration:underline}=0A=
a:visited, span.MsoHyperlinkFollowed=0A=
	{color:#954F72;=0A=
	text-decoration:underline}=0A=
span.EmailStyle17=0A=
	{font-family:"Arial",sans-serif;=0A=
	color:windowtext;=0A=
	font-weight:normal;=0A=
	font-style:normal}=0A=
.MsoChpDefault=0A=
	{font-family:"Calibri",sans-serif}=0A=
@page WordSection1=0A=
	{margin:70.85pt 70.85pt 2.0cm 70.85pt}@font-face=0A=
	{font-family:"Cambria Math"}=0A=
@font-face=0A=
	{font-family:Calibri}=0A=
p.MsoNormal, li.MsoNormal, div.MsoNormal=0A=
	{margin:0cm;=0A=
	margin-bottom:.0001pt;=0A=
	font-size:11.0pt;=0A=
	font-family:"Calibri",sans-serif}=0A=
a:link, span.MsoHyperlink=0A=
	{color:#0563C1;=0A=
	text-decoration:underline}=0A=
a:visited, span.MsoHyperlinkFollowed=0A=
	{color:#954F72;=0A=
	text-decoration:underline}=0A=
span.EmailStyle17=0A=
	{font-family:"Arial",sans-serif;=0A=
	color:windowtext;=0A=
	font-weight:normal;=0A=
	font-style:normal}=0A=
.MsoChpDefault=0A=
	{font-family:"Calibri",sans-serif}=0A=
@page WordSection1=0A=
	{margin:70.85pt 70.85pt 2.0cm 70.85pt}--></style>
</head>
<body dir=3D"ltr" style=3D"font-size:12pt;color:#000000;background-color:#F=
FFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi,</p>
<p><br>
</p>
<p>I didn't mean to suggest some kind of &quot;intermingling&quot;. I merel=
y thought that, because for every other kind of tracepoint, the &quot;conte=
xt&quot; is the execution context of the task that *caused* the tracepoint =
(which happens to be the same as the *current* context
 in almost all cases), it would be consistent if this were the case for sch=
eduler-tracepoints also. This seems to make more sense to me.<br>
</p>
<p><br>
</p>
<p>but I don't really feel strongly about this, and you're the experts, so =
if you prefer it to be the current context in all cases, I'll acquiesce.<br=
>
</p>
<div id=3D"Signature">
<div name=3D"divtagdefaultwrapper" style=3D"font-family:Calibri,Arial,Helve=
tica,sans-serif; font-size:; margin:0">
<font color=3D"black" face=3D"Calibri,Arial,Helvetica,sans-serif" size=3D"3=
"><span dir=3D"ltr" style=3D"font-size:12pt; background-color:white"><font =
face=3D"Arial,sans-serif" size=3D"2"><span style=3D"font-size:10pt" lang=3D=
"de"><b><br>
cheers<br>
<br>
Dr. </b></span></font><font face=3D"Arial,sans-serif" size=3D"2"><span styl=
e=3D"font-size:10pt" lang=3D"en-US"><b>Ingo L=FCtkebohle</b></span></font><=
font face=3D"Arial,sans-serif" size=3D"2"><span style=3D"font-size:10pt" la=
ng=3D"en-US"><b><br>
</b></span></font><font face=3D"Arial,sans-serif" size=3D"2"><span style=3D=
"font-size:10pt" lang=3D"en-US">Software Design and Analysis -- Robotics (C=
R/AEA2)
</span></font><font face=3D"Arial,sans-serif" size=3D"2"><span style=3D"fon=
t-size:10pt" lang=3D"en-US"><br>
</span></font><font face=3D"Arial,sans-serif" size=3D"2"><span style=3D"fon=
t-size:10pt" lang=3D"en-US"><br>
Tel. </span></font><font face=3D"Arial,sans-serif" size=3D"2"><span style=
=3D"font-size:10pt" lang=3D"de">&#43;49(711)811-12248
</span></font><font face=3D"Arial,sans-serif" size=3D"2"><span style=3D"fon=
t-size:10pt" lang=3D"de"><br>
Fax &#43;49(711)811-0 </span></font><font face=3D"Arial,sans-serif" size=3D=
"2"><span style=3D"font-size:10pt" lang=3D"de"><br>
Mobil &#43;49-1525-8813417 </span></font><font face=3D"Arial,sans-serif" si=
ze=3D"2"><span style=3D"font-size:10pt" lang=3D"de"><br>
</span></font><a id=3D"NoLP" target=3D"_blank" href=3D"mailto:Ingo.Luetkebo=
hle@de.bosch.com" tabindex=3D"0"><font face=3D"Calibri,sans-serif" size=3D"=
2"><span style=3D"font-size:11pt" lang=3D"de"><font face=3D"Arial,sans-seri=
f" size=3D"2"><span style=3D"font-size:10pt">Ingo.Luetkebohle@de.bosch.com<=
/span></font></span></font></a></span></font></div>
</div>
<div style=3D"color: rgb(33, 33, 33);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>Von:</b> Mathieu Desnoyers &lt=
;mathieu.desnoyers@efficios.com&gt;<br>
<b>Gesendet:</b> Donnerstag, 26. November 2015 18:05<br>
<b>An:</b> Luetkebohle Ingo (CR/AEA2); Philippe Proulx<br>
<b>Cc:</b> lttng-dev<br>
<b>Betreff:</b> Re: AW: AW: [lttng-dev] faulty context for sched_stat_ trac=
epoints?</font>
<div>&nbsp;</div>
</div>
<div>
<div style=3D"font-family:arial,helvetica,sans-serif; font-size:12pt; color=
:#000000">
<div>We could perhaps clarify our documentation to state that the &quot;con=
text&quot;<br>
</div>
<div>info gathered by lttng is that of the execution context when the trace=
point<br>
</div>
<div>is invoked, but I'm afraid we won't start intermingling the tracepoint=
 payload<br>
</div>
<div>information with context. This would be both technologically cumbersom=
e,<br>
</div>
<div>and confusing.<br>
</div>
<div><br>
</div>
<div>I'm CCing Philippe Proulx who maintains our documentation,<br>
</div>
<div><br>
</div>
<div>Thanks,<br>
</div>
<div><br>
</div>
<div>Mathieu<br>
</div>
<div><br>
</div>
<span id=3D"zwchr">----- On Nov 26, 2015, at 11:57 AM, Luetkebohle Ingo (CR=
/AEA2) &lt;Ingo.Luetkebohle@de.bosch.com&gt; wrote:<br>
</span>
<div>
<blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddin=
g-left:5px; color:#000; font-weight:normal; font-style:normal; text-decorat=
ion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt">
<style style=3D"">=0A=
<!--=0A=
p=0A=
	{margin-top:0;=0A=
	margin-bottom:0}=0A=
@font-face=0A=
	{font-family:"Cambria Math"}=0A=
@font-face=0A=
	{font-family:Calibri}=0A=
p.MsoNormal, li.MsoNormal, div.MsoNormal=0A=
	{margin:0cm;=0A=
	margin-bottom:.0001pt;=0A=
	font-size:11.0pt;=0A=
	font-family:"Calibri",sans-serif}=0A=
a:link, span.MsoHyperlink=0A=
	{color:#0563C1;=0A=
	text-decoration:underline}=0A=
a:visited, span.MsoHyperlinkFollowed=0A=
	{color:#954F72;=0A=
	text-decoration:underline}=0A=
span.EmailStyle17=0A=
	{font-family:"Arial",sans-serif;=0A=
	color:windowtext;=0A=
	font-weight:normal;=0A=
	font-style:normal}=0A=
.MsoChpDefault=0A=
	{font-family:"Calibri",sans-serif}=0A=
@page WordSection1=0A=
	{margin:70.85pt 70.85pt 2.0cm 70.85pt}=0A=
@font-face=0A=
	{font-family:"Cambria Math"}=0A=
@font-face=0A=
	{font-family:Calibri}=0A=
p.MsoNormal, li.MsoNormal, div.MsoNormal=0A=
	{margin:0cm;=0A=
	margin-bottom:.0001pt;=0A=
	font-size:11.0pt;=0A=
	font-family:"Calibri",sans-serif}=0A=
a:link, span.MsoHyperlink=0A=
	{color:#0563C1;=0A=
	text-decoration:underline}=0A=
a:visited, span.MsoHyperlinkFollowed=0A=
	{color:#954F72;=0A=
	text-decoration:underline}=0A=
span.EmailStyle17=0A=
	{font-family:"Arial",sans-serif;=0A=
	color:windowtext;=0A=
	font-weight:normal;=0A=
	font-style:normal}=0A=
.MsoChpDefault=0A=
	{font-family:"Calibri",sans-serif}=0A=
@page WordSection1=0A=
	{margin:70.85pt 70.85pt 2.0cm 70.85pt}=0A=
-->=0A=
</style>
<p>Hi,</p>
<p><br>
</p>
<p>well, the thing is, when I add &quot;context&quot; information, I want m=
ore information on the task of the tracepoint. &nbsp;That the tracepoint is=
 executed in a situation where the *kernel* already has a new task context =
is of no interest to me as a user.</p>
<p><br>
</p>
<p>Therefore, I would argue that what lttng treats as the context should, i=
n this situation, be something different from what the kernel treats as its=
 context.<br>
</p>
<p><br>
</p>
<p>Don't know if that's *possible*, but its what I would expect ;-)</p>
<p><br>
YMMV, of course.</p>
<p><br>
</p>
<p>cheers<br>
</p>
<p><br>
</p>
<div id=3D"Signature">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:; m=
argin:0">
<span face=3D"Calibri,Arial,Helvetica,sans-serif" color=3D"black" size=3D"3=
" style=3D"color:black; font-family:Calibri,Arial,Helvetica,sans-serif; fon=
t-size:medium"><span dir=3D"ltr" style=3D"font-size:12pt; background-color:=
white"><span face=3D"Arial,sans-serif" size=3D"2" style=3D"font-family:Aria=
l,sans-serif; font-size:small"><span style=3D"font-size:10pt" lang=3D"de"><=
b>Dr.
</b></span></span><span face=3D"Arial,sans-serif" size=3D"2" style=3D"font-=
family:Arial,sans-serif; font-size:small"><span style=3D"font-size:10pt" la=
ng=3D"en-US"><b>Ingo L=FCtkebohle</b></span></span><span face=3D"Arial,sans=
-serif" size=3D"2" style=3D"font-family:Arial,sans-serif; font-size:small">=
<span style=3D"font-size:10pt" lang=3D"en-US"><b><br>
</b></span></span><span face=3D"Arial,sans-serif" size=3D"2" style=3D"font-=
family:Arial,sans-serif; font-size:small"><span style=3D"font-size:10pt" la=
ng=3D"en-US">Software Design and Analysis -- Robotics (CR/AEA2)
</span></span><span face=3D"Arial,sans-serif" size=3D"2" style=3D"font-fami=
ly:Arial,sans-serif; font-size:small"><span style=3D"font-size:10pt" lang=
=3D"en-US"><br>
</span></span><span face=3D"Arial,sans-serif" size=3D"2" style=3D"font-fami=
ly:Arial,sans-serif; font-size:small"><span style=3D"font-size:10pt" lang=
=3D"en-US"><br>
Tel. </span></span><span face=3D"Arial,sans-serif" size=3D"2" style=3D"font=
-family:Arial,sans-serif; font-size:small"><span style=3D"font-size:10pt" l=
ang=3D"de">&#43;49(711)811-12248
</span></span><span face=3D"Arial,sans-serif" size=3D"2" style=3D"font-fami=
ly:Arial,sans-serif; font-size:small"><span style=3D"font-size:10pt" lang=
=3D"de"><br>
Fax &#43;49(711)811-0 </span></span><span face=3D"Arial,sans-serif" size=3D=
"2" style=3D"font-family:Arial,sans-serif; font-size:small"><span style=3D"=
font-size:10pt" lang=3D"de"><br>
Mobil &#43;49-1525-8813417 </span></span><span face=3D"Arial,sans-serif" si=
ze=3D"2" style=3D"font-family:Arial,sans-serif; font-size:small"><span styl=
e=3D"font-size:10pt" lang=3D"de"><br>
</span></span><a id=3D"NoLP" target=3D"_blank" href=3D"mailto:Ingo.Luetkebo=
hle@de.bosch.com" tabindex=3D"0"><span face=3D"Calibri,sans-serif" size=3D"=
2" style=3D"font-family:Calibri,sans-serif; font-size:small"><span style=3D=
"font-size:11pt" lang=3D"de"><span face=3D"Arial,sans-serif" size=3D"2" sty=
le=3D"font-family:Arial,sans-serif; font-size:small"><span style=3D"font-si=
ze:10pt">Ingo.Luetkebohle@de.bosch.com</span></span></span></span></a></spa=
n></span><br>
</div>
</div>
<div style=3D"color:rgb(33,33,33)">
<hr style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt; color:#000000; font-family:Calibri=
,sans-serif"><b>Von:</b> Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.c=
om&gt;<br>
<b>Gesendet:</b> Donnerstag, 26. November 2015 17:20<br>
<b>An:</b> Luetkebohle Ingo (CR/AEA2)<br>
<b>Cc:</b> lttng-dev<br>
<b>Betreff:</b> Re: AW: [lttng-dev] faulty context for sched_stat_ tracepoi=
nts?</span>
<div>&nbsp;</div>
</div>
<div>
<div style=3D"font-family:arial,helvetica,sans-serif; font-size:12pt; color=
:#000000">
<div><br>
</div>
<div><span id=3D"zwchr">----- On Nov 26, 2015, at 10:58 AM, Luetkebohle Ing=
o (CR/AEA2) &lt;Ingo.Luetkebohle@de.bosch.com&gt; wrote:<br>
</span></div>
<div>
<blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddin=
g-left:5px; color:#000; font-weight:normal; font-style:normal; text-decorat=
ion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt">
<style style=3D"">=0A=
<!--=0A=
p=0A=
	{margin-top:0;=0A=
	margin-bottom:0}=0A=
@font-face=0A=
	{font-family:"Cambria Math"}=0A=
@font-face=0A=
	{font-family:Calibri}=0A=
p.MsoNormal, li.MsoNormal, div.MsoNormal=0A=
	{margin:0cm;=0A=
	margin-bottom:.0001pt;=0A=
	font-size:11.0pt;=0A=
	font-family:"Calibri",sans-serif}=0A=
a:link, span.MsoHyperlink=0A=
	{color:#0563C1;=0A=
	text-decoration:underline}=0A=
a:visited, span.MsoHyperlinkFollowed=0A=
	{color:#954F72;=0A=
	text-decoration:underline}=0A=
span.EmailStyle17=0A=
	{font-family:"Arial",sans-serif;=0A=
	color:windowtext;=0A=
	font-weight:normal;=0A=
	font-style:normal}=0A=
.MsoChpDefault=0A=
	{font-family:"Calibri",sans-serif}=0A=
@page WordSection1=0A=
	{margin:70.85pt 70.85pt 2.0cm 70.85pt}=0A=
-->=0A=
</style>
<p>Hi Mathieu,</p>
<p><br>
</p>
<p>thank you for the explanation! </p>
<p><br>
</p>
<p>This would suggest that the problem only occurs for scheduler events, be=
cause only then we have this situation that the currently scheduled task is=
 not the one that the tracepoint relates that. Am I interpreting that corre=
ctly?</p>
</blockquote>
<div>AFAIK, only the scheduler tracepoints pass a task struct as parameter =
(the one being<br>
</div>
<div>acted upon) that can differ from the current task. So yes, this kind o=
f situation where a<br>
</div>
<div>tracepoint receives a task other than current as parameter pretty much=
 only happens</div>
<div>in the scheduler instrumentation.<br>
</div>
<blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddin=
g-left:5px; color:#000; font-weight:normal; font-style:normal; text-decorat=
ion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt">
<p><br>
</p>
<p><br>
</p>
<p>If yes, this would certainly ease my concerns, because for most tracepoi=
nts, I get the expected behavior. I can also get the information that I wan=
t right now by looking at comm instead.<br>
</p>
<p><br>
</p>
<p>However, for future development of LTTng: Isn't the intuitive context th=
at of the *tracepoint*? In other words, isn't it wrong to always use the cu=
rrently scheduled task?</p>
</blockquote>
<div>By definition, the &quot;current&quot; task holds the current context,=
 which is the<br>
</div>
<div>one saved in the tid/procname lttng context.<br>
</div>
<div><br>
</div>
<div>The task passed as parameter to the tracepoint is the task acted upon<=
/div>
<div>in this case, not the currently running one anymore. Therefore, the &q=
uot;context&quot; of the<br>
</div>
<div>tracepoint _is_ the currently running task, not the one passed as para=
meter.<br>
</div>
<div><br>
</div>
<div>This highlights something that might not be obvious at first: when the=
 scheduler<br>
</div>
<div>puts a task into a sleeper queue, it does so while running in the cont=
ext of the</div>
<div>newly scheduled task.<br>
</div>
<div><br>
</div>
<div>Thanks,<br>
</div>
<div><br>
</div>
<div>Mathieu<br>
</div>
<div><br>
</div>
<blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddin=
g-left:5px; color:#000; font-weight:normal; font-style:normal; text-decorat=
ion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt">
<p><br>
</p>
<p><br>
</p>
<p>cheers,<br>
</p>
<p><br>
</p>
<div id=3D"Signature">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:; m=
argin:0">
<span style=3D"color:black; font-family:Calibri,Arial,Helvetica,sans-serif;=
 font-size:medium"><span dir=3D"ltr" style=3D"font-size:12pt; background-co=
lor:white"><span style=3D"font-family:Arial,sans-serif; font-size:small"><s=
pan style=3D"font-size:10pt" lang=3D"de"><b>Dr.
</b></span></span><span style=3D"font-family:Arial,sans-serif; font-size:sm=
all"><span style=3D"font-size:10pt" lang=3D"en-US"><b>Ingo L=FCtkebohle</b>=
</span></span><span style=3D"font-family:Arial,sans-serif; font-size:small"=
><span style=3D"font-size:10pt" lang=3D"en-US"><b><br>
</b></span></span><span style=3D"font-family:Arial,sans-serif; font-size:sm=
all"><span style=3D"font-size:10pt" lang=3D"en-US">Software Design and Anal=
ysis -- Robotics (CR/AEA2)
</span></span><span style=3D"font-family:Arial,sans-serif; font-size:small"=
><span style=3D"font-size:10pt" lang=3D"en-US"><br>
</span></span><span style=3D"font-family:Arial,sans-serif; font-size:small"=
><span style=3D"font-size:10pt" lang=3D"en-US"><br>
Tel. </span></span><span style=3D"font-family:Arial,sans-serif; font-size:s=
mall"><span style=3D"font-size:10pt" lang=3D"de">&#43;49(711)811-12248
</span></span><span style=3D"font-family:Arial,sans-serif; font-size:small"=
><span style=3D"font-size:10pt" lang=3D"de"><br>
Fax &#43;49(711)811-0 </span></span><span style=3D"font-family:Arial,sans-s=
erif; font-size:small"><span style=3D"font-size:10pt" lang=3D"de"><br>
Mobil &#43;49-1525-8813417 </span></span><span style=3D"font-family:Arial,s=
ans-serif; font-size:small"><span style=3D"font-size:10pt" lang=3D"de"><br>
</span></span><a id=3D"NoLP" target=3D"_blank" href=3D"mailto:Ingo.Luetkebo=
hle@de.bosch.com" tabindex=3D"0"><span style=3D"font-family:Calibri,sans-se=
rif; font-size:small"><span style=3D"font-size:11pt" lang=3D"de"><span styl=
e=3D"font-family:Arial,sans-serif; font-size:small"><span style=3D"font-siz=
e:10pt">Ingo.Luetkebohle@de.bosch.com</span></span></span></span></a></span=
></span><br>
</div>
</div>
<div style=3D"color:rgb(33,33,33)">
<hr style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-size:11pt; color:=
#000000; font-family:Calibri,sans-serif"><b>Von:</b> Mathieu Desnoyers &lt;=
mathieu.desnoyers@efficios.com&gt;<br>
<b>Gesendet:</b> Donnerstag, 26. November 2015 16:21<br>
<b>An:</b> Luetkebohle Ingo (CR/AEA2)<br>
<b>Cc:</b> lttng-dev<br>
<b>Betreff:</b> Re: [lttng-dev] faulty context for sched_stat_ tracepoints?=
</span></div>
<div>
<div style=3D"font-family:arial,helvetica,sans-serif; font-size:12pt; color=
:#000000">
<div><span id=3D"zwchr">---- On Nov 26, 2015, at 7:34 AM, Luetkebohle Ingo =
(CR/AEA2) &lt;Ingo.Luetkebohle@de.bosch.com&gt; wrote:<br>
</span></div>
<div>
<blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddin=
g-left:5px; color:#000; font-weight:normal; font-style:normal; text-decorat=
ion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt">
<style>=0A=
<!--=0A=
@font-face=0A=
	{font-family:"Cambria Math"}=0A=
@font-face=0A=
	{font-family:Calibri}=0A=
p.MsoNormal, li.MsoNormal, div.MsoNormal=0A=
	{margin:0cm;=0A=
	margin-bottom:.0001pt;=0A=
	font-size:11.0pt;=0A=
	font-family:"Calibri",sans-serif}=0A=
a:link, span.MsoHyperlink=0A=
	{color:#0563C1;=0A=
	text-decoration:underline}=0A=
a:visited, span.MsoHyperlinkFollowed=0A=
	{color:#954F72;=0A=
	text-decoration:underline}=0A=
span.EmailStyle17=0A=
	{font-family:"Arial",sans-serif;=0A=
	color:windowtext;=0A=
	font-weight:normal;=0A=
	font-style:normal}=0A=
.MsoChpDefault=0A=
	{font-family:"Calibri",sans-serif}=0A=
@page WordSection1=0A=
	{margin:70.85pt 70.85pt 2.0cm 70.85pt}=0A=
-->=0A=
</style>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">Hi,</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">I noticed that the &#8220;procname&#8=
221; and &#8220;tid&#8221; *<b>context</b>* variables can differ from the &=
#8220;comm&#8221; and &#8220;tid&#8221; variables of the sched_stat_-tracep=
oints (e.g., for sched_stat_runtime).</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">For example, see the following two ou=
tputs:</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">[15:49:33.674072890] (&#43;0.00002977=
1) rng2070 sched_stat_sleep: { cpu_id =3D 4 }, { pid =3D 26974, procname =
=3D &quot;amcl&quot;, tid =3D 26975 }, { comm =3D &quot;lttng-sessiond&quot=
;, tid =3D
 798, delay =3D 194122524 }</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">[15:49:33.722894563] (&#43;0.00000485=
1) rng2070 sched_stat_sleep: { cpu_id =3D 0 }, { pid =3D 0, procname =3D &q=
uot;swapper/0&quot;, tid =3D 0 }, { comm =3D &quot;amcl&quot;, tid =3D 2707=
8, delay
 =3D 10043658 }</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">In both cases, procname differs from =
comm. &nbsp;I&#8217;ve looked at the kernel source code, and the &#8220;com=
m&#8221; variable is taken from task_struct.filename. Barring renames,
 this would be the correct one, so I&#8217;m assuming that the context is s=
ometimes incorrect.</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">Now, for this particular case, I can =
take the correct variables from the tracepoint, but of course, this makes m=
e worried that the context might also be wrong in
 other cases&#8230; Do you have any idea what could be going on here?</span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">LTTng is Version 2.7.x&#43;stable&#43=
;bzr2948&#43;pack17&#43;201511192116~ubuntu14.04.1 and this is on a 3.19.0-=
33-generic kernel (btw, that&#8217;s not the default kernel for Ubuntu
 14.04, but the LTS vivid backport kernel).</span></p>
</div>
</blockquote>
<div>Hi,<br>
</div>
<div><br>
</div>
<div>Looking at lttng-modules lttng-context-tid.c tid_record(), we see that=
 it uses task_pid_nr(current).<br>
</div>
<div>It therefore gets the tid of the currently scheduled task. This is sim=
ilar for procname.<br>
</div>
<div><br>
</div>
<div>Now looking at the Linux kernel kernel/sched/fair.c: enqueue_sleeper()=
, which calls<br>
</div>
<div>trace_sched_stat_sleep(), we see that it passes &quot;tsk&quot; as par=
ameter to the tracepoint.<br>
</div>
<div>Already here, nothing seems to ensure that &quot;tsk&quot; is the curr=
ently scheduled task. It's<br>
</div>
<div>rather a task that is being put to sleep. Looking at the callers of en=
queue_sleeper(),<br>
</div>
<div>we can understand that the current task is first scheduled out before =
being enqueued<br>
</div>
<div>as a sleeper. This is why, when we hit the sched_stat_sleep tracepoint=
, the current<br>
</div>
<div>task is not &quot;tsk&quot;, which explains the difference between the=
 context information<br>
</div>
<div>and the tracepoint payload information: they really target different t=
asks.<br>
</div>
<div><br>
</div>
<div>Does this help solve your concerns ?<br>
</div>
<div><br>
</div>
<div>Thanks,<br>
</div>
<div><br>
</div>
<div>Mathieu<br>
</div>
<div><br>
</div>
<blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddin=
g-left:5px; color:#000; font-weight:normal; font-style:normal; text-decorat=
ion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif; color:black" lang=3D"EN-US">Mit freundlichen Gr=FC=
=DFen / Best regards
<br>
<br>
<b>Ingo Luetkebohle<br>
</b><br>
Application Software (CR/AEA2) <br>
Tel. &#43;49(711)811-12248 | Fax &#43;49(711)811-0 | </span><span style=3D"=
font-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:black"><a=
 href=3D"mailto:Ingo.Luetkebohle@de.bosch.com" target=3D"_blank"><span styl=
e=3D"color:blue" lang=3D"EN-US">Ingo.Luetkebohle@de.bosch.com</span></a></s=
pan><span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-ser=
if; color:black">
</span><span style=3D"font-size:8.0pt; font-family:&quot;Arial&quot;,sans-s=
erif; color:black" lang=3D"EN-US"><br>
</span><span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-=
serif; color:black" lang=3D"EN-US"><br>
<br>
</span></p>
</div>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br>
</blockquote>
</div>
<div><br>
</div>
<div>-- <br>
</div>
<div>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
http://www.efficios.com</div>
</div>
</div>
</div>
<br>
</blockquote>
</div>
<div><br>
</div>
<div>-- <br>
</div>
<div>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
http://www.efficios.com</div>
</div>
</div>
</div>
<br>
</blockquote>
</div>
<br>
<div>-- <br>
</div>
<div>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
http://www.efficios.com</div>
</div>
</div>
</div>
</body>
</html>

--_000_144861197325088200deboschcom_--



--===============0468741105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0468741105==--
