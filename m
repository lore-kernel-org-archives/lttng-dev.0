From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: faulty context for sched_stat_ tracepoints?
Date: Thu, 26 Nov 2015 17:05:51 +0000 (UTC)
Message-ID: <1483147677.158546.1448557551137.JavaMail.zimbra__16280.4138767116$1448557632$gmane$org@efficios.com>
References: <73b02dedea024337886a82474372bcde@FE-MBX1025.de.bosch.com>
 <1809072616.157482.1448551313021.JavaMail.zimbra@efficios.com>
 <1448553523339.1387@de.bosch.com>
 <1983684660.158379.1448554828712.JavaMail.zimbra@efficios.com>
 <1448557049163.69693@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1483553881=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1a1zzh-0003oa-BP
 for lttng-dev@lists.lttng.org; Thu, 26 Nov 2015 12:06:07 -0500
In-Reply-To: <1448557049163.69693@de.bosch.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Luetkebohle Ingo (CR/AEA2)" <Ingo.Luetkebohle@de.bosch.com>, Philippe Proulx <philippe.proulx@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1483553881==
Content-Type: multipart/alternative;
	boundary="----=_Part_158545_768540615.1448557551136"

------=_Part_158545_768540615.1448557551136
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We could perhaps clarify our documentation to state that the "context"=20
info gathered by lttng is that of the execution context when the tracepoint=
=20
is invoked, but I'm afraid we won't start intermingling the tracepoint payl=
oad=20
information with context. This would be both technologically cumbersome,=20
and confusing.=20

I'm CCing Philippe Proulx who maintains our documentation,=20

Thanks,=20

Mathieu=20

----- On Nov 26, 2015, at 11:57 AM, Luetkebohle Ingo (CR/AEA2) <Ingo.Luetke=
bohle@de.bosch.com> wrote:=20

> Hi,

> well, the thing is, when I add "context" information, I want more informa=
tion on
> the task of the tracepoint. That the tracepoint is executed in a situatio=
n
> where the *kernel* already has a new task context is of no interest to me=
 as a
> user.

> Therefore, I would argue that what lttng treats as the context should, in=
 this
> situation, be something different from what the kernel treats as its cont=
ext.

> Don't know if that's *possible*, but its what I would expect ;-)

> YMMV, of course.

> cheers

> Dr. Ingo L=C3=BCtkebohle
> Software Design and Analysis -- Robotics (CR/AEA2)

> Tel. +49(711)811-12248
> Fax +49(711)811-0
> Mobil +49-1525-8813417
> Ingo.Luetkebohle@de.bosch.com

> Von: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Gesendet: Donnerstag, 26. November 2015 17:20
> An: Luetkebohle Ingo (CR/AEA2)
> Cc: lttng-dev
> Betreff: Re: AW: [lttng-dev] faulty context for sched_stat_ tracepoints?

> ----- On Nov 26, 2015, at 10:58 AM, Luetkebohle Ingo (CR/AEA2)
> <Ingo.Luetkebohle@de.bosch.com> wrote:

>> Hi Mathieu,

>> thank you for the explanation!

>> This would suggest that the problem only occurs for scheduler events, be=
cause
>> only then we have this situation that the currently scheduled task is no=
t the
>> one that the tracepoint relates that. Am I interpreting that correctly?
> AFAIK, only the scheduler tracepoints pass a task struct as parameter (th=
e one
> being
> acted upon) that can differ from the current task. So yes, this kind of
> situation where a
> tracepoint receives a task other than current as parameter pretty much on=
ly
> happens
> in the scheduler instrumentation.

>> If yes, this would certainly ease my concerns, because for most tracepoi=
nts, I
>> get the expected behavior. I can also get the information that I want ri=
ght now
>> by looking at comm instead.

>> However, for future development of LTTng: Isn't the intuitive context th=
at of
>> the *tracepoint*? In other words, isn't it wrong to always use the curre=
ntly
>> scheduled task?
> By definition, the "current" task holds the current context, which is the
> one saved in the tid/procname lttng context.

> The task passed as parameter to the tracepoint is the task acted upon
> in this case, not the currently running one anymore. Therefore, the "cont=
ext" of
> the
> tracepoint _is_ the currently running task, not the one passed as paramet=
er.

> This highlights something that might not be obvious at first: when the sc=
heduler
> puts a task into a sleeper queue, it does so while running in the context=
 of the
> newly scheduled task.

> Thanks,

> Mathieu

>> cheers,

>> Dr. Ingo L=C3=BCtkebohle
>> Software Design and Analysis -- Robotics (CR/AEA2)

>> Tel. +49(711)811-12248
>> Fax +49(711)811-0
>> Mobil +49-1525-8813417
>> Ingo.Luetkebohle@de.bosch.com

>> Von: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Gesendet: Donnerstag, 26. November 2015 16:21
>> An: Luetkebohle Ingo (CR/AEA2)
>> Cc: lttng-dev
>> Betreff: Re: [lttng-dev] faulty context for sched_stat_ tracepoints?
>> ---- On Nov 26, 2015, at 7:34 AM, Luetkebohle Ingo (CR/AEA2)
>> <Ingo.Luetkebohle@de.bosch.com> wrote:

>>> Hi,

>>> I noticed that the =E2=80=9Cprocname=E2=80=9D and =E2=80=9Ctid=E2=80=9D=
 * context * variables can differ from
>>> the =E2=80=9Ccomm=E2=80=9D and =E2=80=9Ctid=E2=80=9D variables of the s=
ched_stat_-tracepoints (e.g., for
>>> sched_stat_runtime).

>>> For example, see the following two outputs:

>>> [15:49:33.674072890] (+0.000029771) rng2070 sched_stat_sleep: { cpu_id =
=3D 4 }, {
>>> pid =3D 26974, procname =3D "amcl", tid =3D 26975 }, { comm =3D "lttng-=
sessiond", tid =3D
>>> 798, delay =3D 194122524 }

>>> [15:49:33.722894563] (+0.000004851) rng2070 sched_stat_sleep: { cpu_id =
=3D 0 }, {
>>> pid =3D 0, procname =3D "swapper/0", tid =3D 0 }, { comm =3D "amcl", ti=
d =3D 27078, delay
>>> =3D 10043658 }

>>> In both cases, procname differs from comm. I=E2=80=99ve looked at the k=
ernel source
>>> code, and the =E2=80=9Ccomm=E2=80=9D variable is taken from task_struct=
.filename. Barring
>>> renames, this would be the correct one, so I=E2=80=99m assuming that th=
e context is
>>> sometimes incorrect.

>>> Now, for this particular case, I can take the correct variables from th=
e
>>> tracepoint, but of course, this makes me worried that the context might=
 also be
>>> wrong in other cases=E2=80=A6 Do you have any idea what could be going =
on here?

>>> LTTng is Version 2.7.x+stable+bzr2948+pack17+201511192116~ubuntu14.04.1=
 and this
>>> is on a 3.19.0-33-generic kernel (btw, that=E2=80=99s not the default k=
ernel for Ubuntu
>>> 14.04, but the LTS vivid backport kernel).

>> Hi,

>> Looking at lttng-modules lttng-context-tid.c tid_record(), we see that i=
t uses
>> task_pid_nr(current).
>> It therefore gets the tid of the currently scheduled task. This is simil=
ar for
>> procname.

>> Now looking at the Linux kernel kernel/sched/fair.c: enqueue_sleeper(), =
which
>> calls
>> trace_sched_stat_sleep(), we see that it passes "tsk" as parameter to th=
e
>> tracepoint.
>> Already here, nothing seems to ensure that "tsk" is the currently schedu=
led
>> task. It's
>> rather a task that is being put to sleep. Looking at the callers of
>> enqueue_sleeper(),
>> we can understand that the current task is first scheduled out before be=
ing
>> enqueued
>> as a sleeper. This is why, when we hit the sched_stat_sleep tracepoint, =
the
>> current
>> task is not "tsk", which explains the difference between the context inf=
ormation
>> and the tracepoint payload information: they really target different tas=
ks.

>> Does this help solve your concerns ?

>> Thanks,

>> Mathieu

>>> Mit freundlichen Gr=C3=BC=C3=9Fen / Best regards

>>> Ingo Luetkebohle

>>> Application Software (CR/AEA2)
>>> Tel. +49(711)811-12248 | Fax +49(711)811-0 | Ingo.Luetkebohle@de.bosch.=
com

>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_158545_768540615.1448557551136
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>We could perhaps clarify our documentation =
to state that the "context"<br></div><div>info gathered by lttng is that of=
 the execution context when the tracepoint<br data-mce-bogus=3D"1"></div><d=
iv>is invoked, but I'm afraid we won't start intermingling the tracepoint p=
ayload<br data-mce-bogus=3D"1"></div><div>information with context. This wo=
uld be both technologically cumbersome,<br data-mce-bogus=3D"1"></div><div>=
and confusing.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1">=
</div><div>I'm CCing Philippe Proulx who maintains our documentation,<br da=
ta-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<b=
r data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathi=
eu<br data-mce-bogus=3D"1"></div><div><br></div><span id=3D"zwchr" data-mar=
ker=3D"__DIVIDER__">----- On Nov 26, 2015, at 11:57 AM, Luetkebohle Ingo (C=
R/AEA2) &lt;Ingo.Luetkebohle@de.bosch.com&gt; wrote:<br></span><div data-ma=
rker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF=
;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:=
normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-siz=
e:12pt;"><style style=3D"display:none"><!--P{margin-top:0;margin-bottom:0;}=
 p
=09{margin-top:0;
=09margin-bottom:0}
@font-face
=09{font-family:"Cambria Math"}
@font-face
=09{font-family:Calibri}
p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif}
a:link, span.MsoHyperlink
=09{color:#0563C1;
=09text-decoration:underline}
a:visited, span.MsoHyperlinkFollowed
=09{color:#954F72;
=09text-decoration:underline}
span.EmailStyle17
=09{font-family:"Arial",sans-serif;
=09color:windowtext;
=09font-weight:normal;
=09font-style:normal}
.MsoChpDefault
=09{font-family:"Calibri",sans-serif}
@page WordSection1
=09{margin:70.85pt 70.85pt 2.0cm 70.85pt}@font-face
=09{font-family:"Cambria Math"}
@font-face
=09{font-family:Calibri}
p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif}
a:link, span.MsoHyperlink
=09{color:#0563C1;
=09text-decoration:underline}
a:visited, span.MsoHyperlinkFollowed
=09{color:#954F72;
=09text-decoration:underline}
span.EmailStyle17
=09{font-family:"Arial",sans-serif;
=09color:windowtext;
=09font-weight:normal;
=09font-style:normal}
.MsoChpDefault
=09{font-family:"Calibri",sans-serif}
@page WordSection1
=09{margin:70.85pt 70.85pt 2.0cm 70.85pt}--></style>


<p>Hi,</p>
<p><br>
</p>
<p>well, the thing is, when I add "context" information, I want more inform=
ation on the task of the tracepoint. &nbsp;That the tracepoint is executed =
in a situation where the *kernel* already has a new task context is of no i=
nterest to me as a user.</p>
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
<span style=3D"color: black; font-family: Calibri,Arial,Helvetica,sans-seri=
f; font-size: medium;" data-mce-style=3D"color: black; font-family: Calibri=
,Arial,Helvetica,sans-serif; font-size: medium;" face=3D"Calibri,Arial,Helv=
etica,sans-serif" color=3D"black" size=3D"3"><span dir=3D"ltr" style=3D"fon=
t-size:12pt; background-color:white"><span style=3D"font-family: Arial,sans=
-serif; font-size: small;" data-mce-style=3D"font-family: Arial,sans-serif;=
 font-size: small;" face=3D"Arial,sans-serif" size=3D"2"><span style=3D"fon=
t-size:10pt" lang=3D"de"><b>Dr.
</b></span></span><span style=3D"font-family: Arial,sans-serif; font-size: =
small;" data-mce-style=3D"font-family: Arial,sans-serif; font-size: small;"=
 face=3D"Arial,sans-serif" size=3D"2"><span style=3D"font-size:10pt" lang=
=3D"en-US"><b>Ingo L=C3=BCtkebohle</b></span></span><span style=3D"font-fam=
ily: Arial,sans-serif; font-size: small;" data-mce-style=3D"font-family: Ar=
ial,sans-serif; font-size: small;" face=3D"Arial,sans-serif" size=3D"2"><sp=
an style=3D"font-size:10pt" lang=3D"en-US"><b><br>
</b></span></span><span style=3D"font-family: Arial,sans-serif; font-size: =
small;" data-mce-style=3D"font-family: Arial,sans-serif; font-size: small;"=
 face=3D"Arial,sans-serif" size=3D"2"><span style=3D"font-size:10pt" lang=
=3D"en-US">Software Design and Analysis -- Robotics (CR/AEA2)
</span></span><span style=3D"font-family: Arial,sans-serif; font-size: smal=
l;" data-mce-style=3D"font-family: Arial,sans-serif; font-size: small;" fac=
e=3D"Arial,sans-serif" size=3D"2"><span style=3D"font-size:10pt" lang=3D"en=
-US"><br>
</span></span><span style=3D"font-family: Arial,sans-serif; font-size: smal=
l;" data-mce-style=3D"font-family: Arial,sans-serif; font-size: small;" fac=
e=3D"Arial,sans-serif" size=3D"2"><span style=3D"font-size:10pt" lang=3D"en=
-US"><br>
Tel. </span></span><span style=3D"font-family: Arial,sans-serif; font-size:=
 small;" data-mce-style=3D"font-family: Arial,sans-serif; font-size: small;=
" face=3D"Arial,sans-serif" size=3D"2"><span style=3D"font-size:10pt" lang=
=3D"de">+49(711)811-12248
</span></span><span style=3D"font-family: Arial,sans-serif; font-size: smal=
l;" data-mce-style=3D"font-family: Arial,sans-serif; font-size: small;" fac=
e=3D"Arial,sans-serif" size=3D"2"><span style=3D"font-size:10pt" lang=3D"de=
"><br>
Fax +49(711)811-0 </span></span><span style=3D"font-family: Arial,sans-seri=
f; font-size: small;" data-mce-style=3D"font-family: Arial,sans-serif; font=
-size: small;" face=3D"Arial,sans-serif" size=3D"2"><span style=3D"font-siz=
e:10pt" lang=3D"de"><br>
Mobil +49-1525-8813417 </span></span><span style=3D"font-family: Arial,sans=
-serif; font-size: small;" data-mce-style=3D"font-family: Arial,sans-serif;=
 font-size: small;" face=3D"Arial,sans-serif" size=3D"2"><span style=3D"fon=
t-size:10pt" lang=3D"de"><br>
</span></span><a id=3D"NoLP" target=3D"_blank" href=3D"mailto:Ingo.Luetkebo=
hle@de.bosch.com" tabindex=3D"0"><span style=3D"font-family: Calibri,sans-s=
erif; font-size: small;" data-mce-style=3D"font-family: Calibri,sans-serif;=
 font-size: small;" face=3D"Calibri,sans-serif" size=3D"2"><span style=3D"f=
ont-size:11pt" lang=3D"de"><span style=3D"font-family: Arial,sans-serif; fo=
nt-size: small;" data-mce-style=3D"font-family: Arial,sans-serif; font-size=
: small;" face=3D"Arial,sans-serif" size=3D"2"><span style=3D"font-size:10p=
t">Ingo.Luetkebohle@de.bosch.com</span></span></span></span></a></span></sp=
an><br data-mce-bogus=3D"1"></div>
</div>
<div style=3D"color: rgb(33, 33, 33);">
<hr style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-size: 11pt; color=
: #000000; font-family: Calibri,sans-serif;" data-mce-style=3D"font-size: 1=
1pt; color: #000000; font-family: Calibri,sans-serif;" face=3D"Calibri, san=
s-serif" color=3D"#000000"><b>Von:</b> Mathieu Desnoyers &lt;mathieu.desnoy=
ers@efficios.com&gt;<br>
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
<style style=3D"">
<!--
p
=09{margin-top:0;
=09margin-bottom:0}
@font-face
=09{font-family:"Cambria Math"}
@font-face
=09{font-family:Calibri}
p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif}
a:link, span.MsoHyperlink
=09{color:#0563C1;
=09text-decoration:underline}
a:visited, span.MsoHyperlinkFollowed
=09{color:#954F72;
=09text-decoration:underline}
span.EmailStyle17
=09{font-family:"Arial",sans-serif;
=09color:windowtext;
=09font-weight:normal;
=09font-style:normal}
.MsoChpDefault
=09{font-family:"Calibri",sans-serif}
@page WordSection1
=09{margin:70.85pt 70.85pt 2.0cm 70.85pt}
-->
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
<div>By definition, the "current" task holds the current context, which is =
the<br>
</div>
<div>one saved in the tid/procname lttng context.<br>
</div>
<div><br>
</div>
<div>The task passed as parameter to the tracepoint is the task acted upon<=
/div>
<div>in this case, not the currently running one anymore. Therefore, the "c=
ontext" of the<br>
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
all"><span style=3D"font-size:10pt" lang=3D"en-US"><b>Ingo L=C3=BCtkebohle<=
/b></span></span><span style=3D"font-family:Arial,sans-serif; font-size:sma=
ll"><span style=3D"font-size:10pt" lang=3D"en-US"><b><br>
</b></span></span><span style=3D"font-family:Arial,sans-serif; font-size:sm=
all"><span style=3D"font-size:10pt" lang=3D"en-US">Software Design and Anal=
ysis -- Robotics (CR/AEA2)
</span></span><span style=3D"font-family:Arial,sans-serif; font-size:small"=
><span style=3D"font-size:10pt" lang=3D"en-US"><br>
</span></span><span style=3D"font-family:Arial,sans-serif; font-size:small"=
><span style=3D"font-size:10pt" lang=3D"en-US"><br>
Tel. </span></span><span style=3D"font-family:Arial,sans-serif; font-size:s=
mall"><span style=3D"font-size:10pt" lang=3D"de">+49(711)811-12248
</span></span><span style=3D"font-family:Arial,sans-serif; font-size:small"=
><span style=3D"font-size:10pt" lang=3D"de"><br>
Fax +49(711)811-0 </span></span><span style=3D"font-family:Arial,sans-serif=
; font-size:small"><span style=3D"font-size:10pt" lang=3D"de"><br>
Mobil +49-1525-8813417 </span></span><span style=3D"font-family:Arial,sans-=
serif; font-size:small"><span style=3D"font-size:10pt" lang=3D"de"><br>
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
<style>
<!--
@font-face
=09{font-family:"Cambria Math"}
@font-face
=09{font-family:Calibri}
p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif}
a:link, span.MsoHyperlink
=09{color:#0563C1;
=09text-decoration:underline}
a:visited, span.MsoHyperlinkFollowed
=09{color:#954F72;
=09text-decoration:underline}
span.EmailStyle17
=09{font-family:"Arial",sans-serif;
=09color:windowtext;
=09font-weight:normal;
=09font-style:normal}
.MsoChpDefault
=09{font-family:"Calibri",sans-serif}
@page WordSection1
=09{margin:70.85pt 70.85pt 2.0cm 70.85pt}
-->
</style>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">Hi,</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">I noticed that the =E2=80=9Cprocname=
=E2=80=9D and =E2=80=9Ctid=E2=80=9D *<b>context</b>* variables can differ f=
rom the =E2=80=9Ccomm=E2=80=9D and =E2=80=9Ctid=E2=80=9D variables of the s=
ched_stat_-tracepoints (e.g., for sched_stat_runtime).</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">For example, see the following two ou=
tputs:</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">[15:49:33.674072890] (+0.000029771) r=
ng2070 sched_stat_sleep: { cpu_id =3D 4 }, { pid =3D 26974, procname =3D "a=
mcl", tid =3D 26975 }, { comm =3D "lttng-sessiond", tid =3D
 798, delay =3D 194122524 }</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">[15:49:33.722894563] (+0.000004851) r=
ng2070 sched_stat_sleep: { cpu_id =3D 0 }, { pid =3D 0, procname =3D "swapp=
er/0", tid =3D 0 }, { comm =3D "amcl", tid =3D 27078, delay
 =3D 10043658 }</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">In both cases, procname differs from =
comm. &nbsp;I=E2=80=99ve looked at the kernel source code, and the =E2=80=
=9Ccomm=E2=80=9D variable is taken from task_struct.filename. Barring renam=
es,
 this would be the correct one, so I=E2=80=99m assuming that the context is=
 sometimes incorrect.</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">Now, for this particular case, I can =
take the correct variables from the tracepoint, but of course, this makes m=
e worried that the context might also be wrong in
 other cases=E2=80=A6 Do you have any idea what could be going on here?</sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">LTTng is Version 2.7.x+stable+bzr2948=
+pack17+201511192116~ubuntu14.04.1 and this is on a 3.19.0-33-generic kerne=
l (btw, that=E2=80=99s not the default kernel for Ubuntu
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
<div>trace_sched_stat_sleep(), we see that it passes "tsk" as parameter to =
the tracepoint.<br>
</div>
<div>Already here, nothing seems to ensure that "tsk" is the currently sche=
duled task. It's<br>
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
<div>task is not "tsk", which explains the difference between the context i=
nformation<br>
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
rial&quot;,sans-serif; color:black" lang=3D"EN-US">Mit freundlichen Gr=C3=
=BC=C3=9Fen / Best regards
<br>
<br>
<b>Ingo Luetkebohle<br>
</b><br>
Application Software (CR/AEA2) <br>
Tel. +49(711)811-12248 | Fax +49(711)811-0 | </span><span style=3D"font-siz=
e:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:black"><a href=3D=
"mailto:Ingo.Luetkebohle@de.bosch.com" target=3D"_blank"><span style=3D"col=
or:blue" lang=3D"EN-US">Ingo.Luetkebohle@de.bosch.com</span></a></span><spa=
n style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; colo=
r:black">
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
</div><br></blockquote></div><br><div data-marker=3D"__SIG_POST__">-- <br><=
/div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</di=
v></div></body></html>
------=_Part_158545_768540615.1448557551136--


--===============1483553881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1483553881==--
