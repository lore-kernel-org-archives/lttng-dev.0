From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: faulty context for sched_stat_ tracepoints?
Date: Thu, 26 Nov 2015 16:20:28 +0000 (UTC)
Message-ID: <1983684660.158379.1448554828712.JavaMail.zimbra__27441.5192347535$1448554906$gmane$org@efficios.com>
References: <73b02dedea024337886a82474372bcde@FE-MBX1025.de.bosch.com>
 <1809072616.157482.1448551313021.JavaMail.zimbra@efficios.com>
 <1448553523339.1387@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0266305536=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1a1zHn-0003Ud-UW
 for lttng-dev@lists.lttng.org; Thu, 26 Nov 2015 11:20:45 -0500
In-Reply-To: <1448553523339.1387@de.bosch.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Luetkebohle Ingo (CR/AEA2)" <Ingo.Luetkebohle@de.bosch.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0266305536==
Content-Type: multipart/alternative;
	boundary="----=_Part_158378_1675550356.1448554828711"

------=_Part_158378_1675550356.1448554828711
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Nov 26, 2015, at 10:58 AM, Luetkebohle Ingo (CR/AEA2) <Ingo.Luetke=
bohle@de.bosch.com> wrote:=20

> Hi Mathieu,

> thank you for the explanation!

> This would suggest that the problem only occurs for scheduler events, bec=
ause
> only then we have this situation that the currently scheduled task is not=
 the
> one that the tracepoint relates that. Am I interpreting that correctly?
AFAIK, only the scheduler tracepoints pass a task struct as parameter (the =
one being=20
acted upon) that can differ from the current task. So yes, this kind of sit=
uation where a=20
tracepoint receives a task other than current as parameter pretty much only=
 happens=20
in the scheduler instrumentation.=20

> If yes, this would certainly ease my concerns, because for most tracepoin=
ts, I
> get the expected behavior. I can also get the information that I want rig=
ht now
> by looking at comm instead.

> However, for future development of LTTng: Isn't the intuitive context tha=
t of
> the *tracepoint*? In other words, isn't it wrong to always use the curren=
tly
> scheduled task?
By definition, the "current" task holds the current context, which is the=
=20
one saved in the tid/procname lttng context.=20

The task passed as parameter to the tracepoint is the task acted upon=20
in this case, not the currently running one anymore. Therefore, the "contex=
t" of the=20
tracepoint _is_ the currently running task, not the one passed as parameter=
.=20

This highlights something that might not be obvious at first: when the sche=
duler=20
puts a task into a sleeper queue, it does so while running in the context o=
f the=20
newly scheduled task.=20

Thanks,=20

Mathieu=20

> cheers,

> Dr. Ingo L=C3=BCtkebohle
> Software Design and Analysis -- Robotics (CR/AEA2)

> Tel. +49(711)811-12248
> Fax +49(711)811-0
> Mobil +49-1525-8813417
> Ingo.Luetkebohle@de.bosch.com

> Von: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Gesendet: Donnerstag, 26. November 2015 16:21
> An: Luetkebohle Ingo (CR/AEA2)
> Cc: lttng-dev
> Betreff: Re: [lttng-dev] faulty context for sched_stat_ tracepoints?
> ---- On Nov 26, 2015, at 7:34 AM, Luetkebohle Ingo (CR/AEA2)
> <Ingo.Luetkebohle@de.bosch.com> wrote:

>> Hi,

>> I noticed that the =E2=80=9Cprocname=E2=80=9D and =E2=80=9Ctid=E2=80=9D =
* context * variables can differ from
>> the =E2=80=9Ccomm=E2=80=9D and =E2=80=9Ctid=E2=80=9D variables of the sc=
hed_stat_-tracepoints (e.g., for
>> sched_stat_runtime).

>> For example, see the following two outputs:

>> [15:49:33.674072890] (+0.000029771) rng2070 sched_stat_sleep: { cpu_id =
=3D 4 }, {
>> pid =3D 26974, procname =3D "amcl", tid =3D 26975 }, { comm =3D "lttng-s=
essiond", tid =3D
>> 798, delay =3D 194122524 }

>> [15:49:33.722894563] (+0.000004851) rng2070 sched_stat_sleep: { cpu_id =
=3D 0 }, {
>> pid =3D 0, procname =3D "swapper/0", tid =3D 0 }, { comm =3D "amcl", tid=
 =3D 27078, delay
>> =3D 10043658 }

>> In both cases, procname differs from comm. I=E2=80=99ve looked at the ke=
rnel source
>> code, and the =E2=80=9Ccomm=E2=80=9D variable is taken from task_struct.=
filename. Barring
>> renames, this would be the correct one, so I=E2=80=99m assuming that the=
 context is
>> sometimes incorrect.

>> Now, for this particular case, I can take the correct variables from the
>> tracepoint, but of course, this makes me worried that the context might =
also be
>> wrong in other cases=E2=80=A6 Do you have any idea what could be going o=
n here?

>> LTTng is Version 2.7.x+stable+bzr2948+pack17+201511192116~ubuntu14.04.1 =
and this
>> is on a 3.19.0-33-generic kernel (btw, that=E2=80=99s not the default ke=
rnel for Ubuntu
>> 14.04, but the LTS vivid backport kernel).

> Hi,

> Looking at lttng-modules lttng-context-tid.c tid_record(), we see that it=
 uses
> task_pid_nr(current).
> It therefore gets the tid of the currently scheduled task. This is simila=
r for
> procname.

> Now looking at the Linux kernel kernel/sched/fair.c: enqueue_sleeper(), w=
hich
> calls
> trace_sched_stat_sleep(), we see that it passes "tsk" as parameter to the
> tracepoint.
> Already here, nothing seems to ensure that "tsk" is the currently schedul=
ed
> task. It's
> rather a task that is being put to sleep. Looking at the callers of
> enqueue_sleeper(),
> we can understand that the current task is first scheduled out before bei=
ng
> enqueued
> as a sleeper. This is why, when we hit the sched_stat_sleep tracepoint, t=
he
> current
> task is not "tsk", which explains the difference between the context info=
rmation
> and the tracepoint payload information: they really target different task=
s.

> Does this help solve your concerns ?

> Thanks,

> Mathieu

>> Mit freundlichen Gr=C3=BC=C3=9Fen / Best regards

>> Ingo Luetkebohle

>> Application Software (CR/AEA2)
>> Tel. +49(711)811-12248 | Fax +49(711)811-0 | Ingo.Luetkebohle@de.bosch.c=
om

>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_158378_1675550356.1448554828711
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><span id=3D"zwchr" data-mark=
er=3D"__DIVIDER__">----- On Nov 26, 2015, at 10:58 AM, Luetkebohle Ingo (CR=
/AEA2) &lt;Ingo.Luetkebohle@de.bosch.com&gt; wrote:<br></span></div><div da=
ta-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1=
010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-s=
tyle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fon=
t-size:12pt;"><style style=3D"display:none"><!--P{margin-top:0;margin-botto=
m:0;} @font-face
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
div.WordSection1
=09{}--></style><p>Hi Mathieu,</p><p><br></p><p>thank you for the explanati=
on! </p><p><br></p><p>This would suggest that the problem only occurs for s=
cheduler events, because only then we have this situation that the currentl=
y scheduled task is not the one that the tracepoint relates that. Am I inte=
rpreting that correctly?</p></blockquote><div>AFAIK, only the scheduler tra=
cepoints pass a task struct as parameter (the one being<br></div><div>acted=
 upon) that can differ from the current task. So yes, this kind of situatio=
n where a<br></div><div>tracepoint receives a task other than current as pa=
rameter pretty much only happens</div><div>in the scheduler instrumentation=
.<br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid =
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font=
-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;f=
ont-size:12pt;"><p><br></p><p><br></p><p>If yes, this would certainly ease =
my concerns, because for most tracepoints, I get the expected behavior. I c=
an also get the information that I want right now by looking at comm instea=
d.<br></p><p><br></p><p>However, for future development of LTTng: Isn't the=
 intuitive context that of the *tracepoint*? In other words, isn't it wrong=
 to always use the currently scheduled task?</p></blockquote><div>By defini=
tion, the "current" task holds the current context, which is the<br></div><=
div>one saved in the tid/procname lttng context.<br data-mce-bogus=3D"1"></=
div><div><br data-mce-bogus=3D"1"></div><div>The task passed as parameter t=
o the tracepoint is the task acted upon</div><div>in this case, not the cur=
rently running one anymore. Therefore, the "context" of the<br data-mce-bog=
us=3D"1"></div><div>tracepoint _is_ the currently running task, not the one=
 passed as parameter.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>This highlights something that might not be obvious at fi=
rst: when the scheduler<br data-mce-bogus=3D"1"></div><div>puts a task into=
 a sleeper queue, it does so while running in the context of the</div><div>=
newly scheduled task.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-b=
ogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-m=
ce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;mar=
gin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:norm=
al;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12=
pt;"><p><br></p><p><br></p><p>cheers,<br></p><p><br></p><div id=3D"Signatur=
e"><div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:=
; margin:0"><span style=3D"color: black; font-family: Calibri,Arial,Helveti=
ca,sans-serif; font-size: medium;" data-mce-style=3D"color: black; font-fam=
ily: Calibri,Arial,Helvetica,sans-serif; font-size: medium;" face=3D"Calibr=
i,Arial,Helvetica,sans-serif" color=3D"black" size=3D"3"><span dir=3D"ltr" =
style=3D"font-size:12pt; background-color:white"><span style=3D"font-family=
: Arial,sans-serif; font-size: small;" data-mce-style=3D"font-family: Arial=
,sans-serif; font-size: small;" face=3D"Arial,sans-serif" size=3D"2"><span =
style=3D"font-size:10pt" lang=3D"de"><b>Dr.
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
an><br data-mce-bogus=3D"1"></div></div><div style=3D"color: rgb(33, 33, 33=
);"><hr style=3D"display:inline-block; width:98%"><div id=3D"divRplyFwdMsg"=
 dir=3D"ltr"><span style=3D"font-size: 11pt; color: #000000; font-family: C=
alibri,sans-serif;" data-mce-style=3D"font-size: 11pt; color: #000000; font=
-family: Calibri,sans-serif;" face=3D"Calibri, sans-serif" color=3D"#000000=
"><b>Von:</b> Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>
<b>Gesendet:</b> Donnerstag, 26. November 2015 16:21<br>
<b>An:</b> Luetkebohle Ingo (CR/AEA2)<br>
<b>Cc:</b> lttng-dev<br>
<b>Betreff:</b> Re: [lttng-dev] faulty context for sched_stat_ tracepoints?=
</span></div><div><div style=3D"font-family:arial,helvetica,sans-serif; fon=
t-size:12pt; color:#000000"><div><span id=3D"zwchr">---- On Nov 26, 2015, a=
t 7:34 AM, Luetkebohle Ingo (CR/AEA2) &lt;Ingo.Luetkebohle@de.bosch.com&gt;=
 wrote:<br>
</span></div><div><blockquote style=3D"border-left:2px solid #1010FF; margi=
n-left:5px; padding-left:5px; color:#000; font-weight:normal; font-style:no=
rmal; text-decoration:none; font-family:Helvetica,Arial,sans-serif; font-si=
ze:12pt"><style>
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
div.WordSection1
=09{}
-->
</style><div class=3D"WordSection1"><p class=3D"MsoNormal"><span style=3D"f=
ont-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif" lang=3D"EN-US">H=
i,</span></p><p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-f=
amily:&quot;Arial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p><p clas=
s=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;Arial&qu=
ot;,sans-serif" lang=3D"EN-US">I noticed that the =E2=80=9Cprocname=E2=80=
=9D and =E2=80=9Ctid=E2=80=9D *<b>context</b>* variables can differ from th=
e =E2=80=9Ccomm=E2=80=9D and =E2=80=9Ctid=E2=80=9D variables of the sched_s=
tat_-tracepoints (e.g., for sched_stat_runtime).</span></p><p class=3D"MsoN=
ormal"><span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-=
serif" lang=3D"EN-US">&nbsp;</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif" lang=3D"EN-=
US">For example, see the following two outputs:</span></p><p class=3D"MsoNo=
rmal"><span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-s=
erif" lang=3D"EN-US">[15:49:33.674072890] (+0.000029771) rng2070 sched_stat=
_sleep: { cpu_id =3D 4 }, { pid =3D 26974, procname =3D "amcl", tid =3D 269=
75 }, { comm =3D "lttng-sessiond", tid =3D
 798, delay =3D 194122524 }</span></p><p class=3D"MsoNormal"><span style=3D=
"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif" lang=3D"EN-US"=
>[15:49:33.722894563] (+0.000004851) rng2070 sched_stat_sleep: { cpu_id =3D=
 0 }, { pid =3D 0, procname =3D "swapper/0", tid =3D 0 }, { comm =3D "amcl"=
, tid =3D 27078, delay
 =3D 10043658 }</span></p><p class=3D"MsoNormal"><span style=3D"font-size:1=
0.0pt; font-family:&quot;Arial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</spa=
n></p><p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&=
quot;Arial&quot;,sans-serif" lang=3D"EN-US">In both cases, procname differs=
 from comm. &nbsp;I=E2=80=99ve looked at the kernel source code, and the =
=E2=80=9Ccomm=E2=80=9D variable is taken from task_struct.filename. Barring=
 renames,
 this would be the correct one, so I=E2=80=99m assuming that the context is=
 sometimes incorrect.</span></p><p class=3D"MsoNormal"><span style=3D"font-=
size:10.0pt; font-family:&quot;Arial&quot;,sans-serif" lang=3D"EN-US">&nbsp=
;</span></p><p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-fa=
mily:&quot;Arial&quot;,sans-serif" lang=3D"EN-US">Now, for this particular =
case, I can take the correct variables from the tracepoint, but of course, =
this makes me worried that the context might also be wrong in
 other cases=E2=80=A6 Do you have any idea what could be going on here?</sp=
an></p><p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:=
&quot;Arial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p><p class=3D"M=
soNormal"><span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sa=
ns-serif" lang=3D"EN-US">LTTng is Version 2.7.x+stable+bzr2948+pack17+20151=
1192116~ubuntu14.04.1 and this is on a 3.19.0-33-generic kernel (btw, that=
=E2=80=99s not the default kernel for Ubuntu
 14.04, but the LTS vivid backport kernel).</span></p></div></blockquote><d=
iv>Hi,<br></div><div><br></div><div>Looking at lttng-modules lttng-context-=
tid.c tid_record(), we see that it uses task_pid_nr(current).<br></div><div=
>It therefore gets the tid of the currently scheduled task. This is similar=
 for procname.<br></div><div><br></div><div>Now looking at the Linux kernel=
 kernel/sched/fair.c: enqueue_sleeper(), which calls<br></div><div>trace_sc=
hed_stat_sleep(), we see that it passes "tsk" as parameter to the tracepoin=
t.<br></div><div>Already here, nothing seems to ensure that "tsk" is the cu=
rrently scheduled task. It's<br></div><div>rather a task that is being put =
to sleep. Looking at the callers of enqueue_sleeper(),<br></div><div>we can=
 understand that the current task is first scheduled out before being enque=
ued<br></div><div>as a sleeper. This is why, when we hit the sched_stat_sle=
ep tracepoint, the current<br></div><div>task is not "tsk", which explains =
the difference between the context information<br></div><div>and the tracep=
oint payload information: they really target different tasks.<br></div><div=
><br></div><div>Does this help solve your concerns ?<br></div><div><br></di=
v><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div=
><blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddi=
ng-left:5px; color:#000; font-weight:normal; font-style:normal; text-decora=
tion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt"><div cla=
ss=3D"WordSection1"><p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;=
 font-family:&quot;Arial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p>=
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
</span></p></div><br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><=
/div><div><br></div><div>-- <br></div><div>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
http://www.efficios.com</div></div></div></div><br></blockquote></div><div>=
<br></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desno=
yers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_158378_1675550356.1448554828711--


--===============0266305536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0266305536==--
