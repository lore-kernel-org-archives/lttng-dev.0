From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: efficient use of LTTng in legacy codebase
Date: Thu, 12 Dec 2013 00:47:31 +0000 (UTC)
Message-ID: <38714154.84070.1386809251111.JavaMail.zimbra__20635.4675269269$1386809310$gmane$org@efficios.com>
References: <ECCC3645D4115E4293D3E8C0EB22F09C20D363@ESESSMB109.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0014022923=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VquRA-0005M7-AI
	for lttng-dev@lists.lttng.org; Wed, 11 Dec 2013 19:47:37 -0500
In-Reply-To: <ECCC3645D4115E4293D3E8C0EB22F09C20D363@ESESSMB109.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?TcOhdMOp?= Ferenczy <mate.ferenczy@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0014022923==
Content-Type: multipart/alternative;
	boundary="----=_Part_84069_937857362.1386809251110"

------=_Part_84069_937857362.1386809251110
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "M=C3=A1t=C3=A9 Ferenczy" <mate.ferenczy@ericsson.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Wednesday, December 11, 2013 6:52:22 PM
> Subject: RE: efficient use of LTTng in legacy codebase

> I found this email thread:
> https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg02278.html

> According to this I could just check
> caa_unlikely(__tracepoint_##provider##___##name.state). However, Dave cla=
ims
> that this state will stay true even if the tracepoint is disabled. Is the=
re
> anything else I should check for?

I would recommend doing this in the UST probe provider instead. Within the =
TRACEPOINT_EVENT "TP_FIELD" section, when you declare your string field, yo=
u could parse the format string there in the last argument of a ctf_string(=
) (a statement expression). The format string would be received as paramete=
r by the tracepoint, along with a variable arg list (...). In the probe, it=
 would be turned into a va_list (see stdarg(3)), and the parameters could b=
e decoded into a string there. This has the benefit of moving the serializa=
tion call out-of-line into the probe provider rather than clobbering the tr=
acepoint call site.=20

Thoughts ?=20

Thanks,=20

Mathieu=20

> Thanks,

> Mate

> From: M=C3=A1t=C3=A9 Ferenczy
> Sent: Wednesday, December 11, 2013 12:17 PM
> To: 'mathieu.desnoyers@efficios.com'
> Cc: 'lttng-dev@lists.lttng.org'
> Subject: efficient use of LTTng in legacy codebase

> Hello Mathieu,

> Our team was asked to support LTTng UST solution in a legacy codebase. Th=
e
> existing codebase is fairly large, and the requirement is that we provide
> all the existing logs and debugs in the system as LTTng traces.

> The planned solution so far was just to pass everything we have as text
> (strings) to LTTng. For that we obviously have to convert the printf-like
> format string and parameter list to a string by calling snprintf before
> giving the string to the LTTng API. That would however mean, that these
> snprintfs are getting called every time even if there is no listener/acti=
ve
> trace session for the given trace. In this case, all those unnecessary
> snprintf calls may end up significantly impacting the performance of our
> applications.

> In order to work around this, we were thinking that if there was a way to
> query the LTTng library from our application code whether there is an act=
ive
> tracing session for the given trace level, we could avoid calling those
> snprintfs in case they are not needed. Do you think it would be feasible =
to
> easily get this data from LTTng lib? If yes, can you provide us some
> pointers where to look at in order to do those changes ourselves?

> Any suggestions are welcome.

> Thank you,

> Mate Ferenczy

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_84069_937857362.1386809251110
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"M=C3=A1t=C3=A9 Ferencz=
y" &lt;mate.ferenczy@ericsson.com&gt;<br><b>To: </b>"mathieu desnoyers" &lt=
;mathieu.desnoyers@efficios.com&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.org=
<br><b>Sent: </b>Wednesday, December 11, 2013 6:52:22 PM<br><b>Subject: </b=
>RE: efficient use of LTTng in legacy codebase<br><div><br></div><style><!-=
-

@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
=09{font-family:Tahoma;
=09panose-1:2 11 6 4 3 5 4 4 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal;
=09font-family:"Calibri","sans-serif";
=09color:windowtext;}
span.EmailStyle18
=09{mso-style-type:personal-reply;
=09font-family:"Calibri","sans-serif";
=09color:#1F497D;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-size:10.0pt;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style><div class=3D"WordSection1"><p class=3D"MsoNormal">I found this =
email thread: <a href=3D"https://www.mail-archive.com/lttng-dev@lists.lttng=
.org/msg02278.html" target=3D"_blank">
https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg02278.html</a><br=
 data-mce-bogus=3D"1"></p><p class=3D"MsoNormal">According to this I could =
just check caa_unlikely(__tracepoint_##provider##___##name.state). However,=
 Dave claims that this state will stay true even if the tracepoint is disab=
led. Is there anything else I should check for?</p></div></blockquote><div>=
<br></div><div>I would recommend doing this in the UST probe provider inste=
ad. Within the TRACEPOINT_EVENT "TP_FIELD" section, when you declare your s=
tring field, you could parse the format string there in the last argument o=
f a ctf_string() (a statement expression). The format string would be recei=
ved as parameter by the tracepoint, along with a variable arg list (...). I=
n the probe, it would be turned into a va_list (see stdarg(3)), and the par=
ameters could be decoded into a string there. This has the benefit of movin=
g the serialization call out-of-line into the probe provider rather than cl=
obbering the tracepoint call site.<br></div><div><br></div><div>Thoughts ?<=
br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<b=
r></div><div><br></div><blockquote style=3D"border-left:2px solid #1010FF;m=
argin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:no=
rmal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:=
12pt;"><div class=3D"WordSection1"><p class=3D"MsoNormal">Thanks,</p><p cla=
ss=3D"MsoNormal">Mate</p><p class=3D"MsoNormal"><span style=3D"color:#1F497=
D">&nbsp;</span></p><div><div style=3D"border:none;border-top:solid #B5C4DF=
 1.0pt;padding:3.0pt 0in 0in 0in"><p class=3D"MsoNormal"><b><span style=3D"=
font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">Fro=
m:</span></b><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;=
,&quot;sans-serif&quot;"> M=C3=A1t=C3=A9 Ferenczy
<br>
<b>Sent:</b> Wednesday, December 11, 2013 12:17 PM<br>
<b>To:</b> 'mathieu.desnoyers@efficios.com'<br>
<b>Cc:</b> 'lttng-dev@lists.lttng.org'<br>
<b>Subject:</b> efficient use of LTTng in legacy codebase</span></p></div><=
/div><p class=3D"MsoNormal">Hello Mathieu,</p><p class=3D"MsoNormal">Our te=
am was asked to support LTTng UST solution in a legacy codebase. The existi=
ng codebase is fairly large, and the requirement is that we provide all the=
 existing logs and debugs in the system as LTTng traces.</p><p class=3D"Mso=
Normal">The planned solution so far was just to pass everything we have as =
text (strings) to LTTng. For that we obviously have to convert the printf-l=
ike format string and parameter list to a string by calling snprintf before=
 giving the string
 to the LTTng API. That would however mean, that these snprintfs are gettin=
g called every time even if there is no listener/active trace session for t=
he given trace. In this case, all those unnecessary snprintf calls may end =
up significantly impacting the performance
 of our applications.</p><p class=3D"MsoNormal">In order to work around thi=
s, we were thinking that if there was a way to query the LTTng library from=
 our application code whether there is an active tracing session for the gi=
ven trace level, we could avoid calling those snprintfs in
 case they are not needed. Do you think it would be feasible to easily get =
this data from LTTng lib? If yes, can you provide us some pointers where to=
 look at in order to do those changes ourselves?</p><p class=3D"MsoNormal">=
Any suggestions are welcome.</p><p class=3D"MsoNormal">Thank you,</p><p cla=
ss=3D"MsoNormal">Mate Ferenczy</p></div></blockquote><div><br><br></div><di=
v><br></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyer=
s<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></=
div></div></body></html>
------=_Part_84069_937857362.1386809251110--


--===============0014022923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0014022923==--
