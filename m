From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: efficient use of LTTng in legacy codebase
Date: Thu, 12 Dec 2013 12:35:19 +0000 (UTC)
Message-ID: <1206710241.84238.1386851719338.JavaMail.zimbra__8417.46284063465$1386851768$gmane$org@efficios.com>
References: <ECCC3645D4115E4293D3E8C0EB22F09C20D363@ESESSMB109.ericsson.se>
	<38714154.84070.1386809251111.JavaMail.zimbra@efficios.com>
	<ECCC3645D4115E4293D3E8C0EB22F09C20D3F6@ESESSMB109.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_84234_95876688.1386851719332"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1Vr5U8-0002ke-LM
	for lttng-dev@lists.lttng.org; Thu, 12 Dec 2013 07:35:23 -0500
In-Reply-To: <ECCC3645D4115E4293D3E8C0EB22F09C20D3F6@ESESSMB109.ericsson.se>
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

------=_Part_84234_95876688.1386851719332
Content-Type: multipart/alternative;
	boundary="----=_Part_84235_786759966.1386851719332"

------=_Part_84235_786759966.1386851719332
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Just to speed things up, please have a look at the proposed UST patch. (it'=
s not in mainline yet)=20

This is specifically for a demo program example so far.=20

Comments are welcome,=20

Thanks,=20

Mathieu=20

----- Original Message -----

> From: "M=C3=A1t=C3=A9 Ferenczy" <mate.ferenczy@ericsson.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Wednesday, December 11, 2013 8:52:30 PM
> Subject: RE: efficient use of LTTng in legacy codebase

> It sounds great, I like the idea. Just to make sure I understand your
> suggestion, are we talking about converting the variable argument list to
> string in include/lttng/ust-tracepoint-event-write.h?

> For example:

> #define ctf_format_string(_item, =E2=80=A6) \

> do { \

> char _buf[BUF_MAXLEN]; \

> snprintf(buf, sizeof(_buf), __VA_ARGS__); \

> _ctf_string(_item, _buf, 0); \

> } while(0)

> Or do you have some better place to put this logic?

> Thanks,

> Mate

> From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> Sent: Wednesday, December 11, 2013 4:48 PM
> To: M=C3=A1t=C3=A9 Ferenczy
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: efficient use of LTTng in legacy codebase

> ----- Original Message -----

> > From: "M=C3=A1t=C3=A9 Ferenczy" < mate.ferenczy@ericsson.com >
>=20
> > To: "mathieu desnoyers" < mathieu.desnoyers@efficios.com >
>=20
> > Cc: lttng-dev@lists.lttng.org
>=20
> > Sent: Wednesday, December 11, 2013 6:52:22 PM
>=20
> > Subject: RE: efficient use of LTTng in legacy codebase
>=20

> > I found this email thread:
> > https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg02278.html
>=20

> > According to this I could just check
> > caa_unlikely(__tracepoint_##provider##___##name.state). However, Dave
> > claims
> > that this state will stay true even if the tracepoint is disabled. Is t=
here
> > anything else I should check for?
>=20
> I would recommend doing this in the UST probe provider instead. Within th=
e
> TRACEPOINT_EVENT "TP_FIELD" section, when you declare your string field, =
you
> could parse the format string there in the last argument of a ctf_string(=
)
> (a statement expression). The format string would be received as paramete=
r
> by the tracepoint, along with a variable arg list (...). In the probe, it
> would be turned into a va_list (see stdarg(3)), and the parameters could =
be
> decoded into a string there. This has the benefit of moving the
> serialization call out-of-line into the probe provider rather than
> clobbering the tracepoint call site.

> Thoughts ?

> Thanks,

> Mathieu

> > Thanks,
>=20

> > Mate
>=20

> > From: M=C3=A1t=C3=A9 Ferenczy
>=20
> > Sent: Wednesday, December 11, 2013 12:17 PM
>=20
> > To: 'mathieu.desnoyers@efficios.com'
>=20
> > Cc: 'lttng-dev@lists.lttng.org'
>=20
> > Subject: efficient use of LTTng in legacy codebase
>=20

> > Hello Mathieu,
>=20

> > Our team was asked to support LTTng UST solution in a legacy codebase. =
The
> > existing codebase is fairly large, and the requirement is that we provi=
de
> > all the existing logs and debugs in the system as LTTng traces.
>=20

> > The planned solution so far was just to pass everything we have as text
> > (strings) to LTTng. For that we obviously have to convert the printf-li=
ke
> > format string and parameter list to a string by calling snprintf before
> > giving the string to the LTTng API. That would however mean, that these
> > snprintfs are getting called every time even if there is no listener/ac=
tive
> > trace session for the given trace. In this case, all those unnecessary
> > snprintf calls may end up significantly impacting the performance of ou=
r
> > applications.
>=20

> > In order to work around this, we were thinking that if there was a way =
to
> > query the LTTng library from our application code whether there is an
> > active
> > tracing session for the given trace level, we could avoid calling those
> > snprintfs in case they are not needed. Do you think it would be feasibl=
e to
> > easily get this data from LTTng lib? If yes, can you provide us some
> > pointers where to look at in order to do those changes ourselves?
>=20

> > Any suggestions are welcome.
>=20

> > Thank you,
>=20

> > Mate Ferenczy
>=20
> --

> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_84235_786759966.1386851719332
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Just to speed things up, please =
have a look at the proposed UST patch. (it's not in mainline yet)<br></div>=
<div><br></div><div>This is specifically for a demo program example so far.=
<br></div><div><br></div><div>Comments are welcome,<br></div><div><br></div=
><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div>=
<div><br></div><hr id=3D"zwchr"><blockquote style=3D"border-left:2px solid =
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font=
-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;f=
ont-size:12pt;"><b>From: </b>"M=C3=A1t=C3=A9 Ferenczy" &lt;mate.ferenczy@er=
icsson.com&gt;<br><b>To: </b>"Mathieu Desnoyers" &lt;mathieu.desnoyers@effi=
cios.com&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>Wednes=
day, December 11, 2013 8:52:30 PM<br><b>Subject: </b>RE: efficient use of L=
TTng in legacy codebase<br><div><br></div>



<style><!--

@font-face
=09{font-family:Helvetica;
=09panose-1:2 11 5 4 2 2 2 2 2 4;}
@font-face
=09{font-family:Helvetica;
=09panose-1:2 11 5 4 2 2 2 2 2 4;}
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
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
=09{mso-style-priority:99;
=09mso-style-link:"Balloon Text Char";
=09margin:0in;
=09margin-bottom:.0001pt;
=09font-size:8.0pt;
=09font-family:"Tahoma","sans-serif";}
span.EmailStyle17
=09{mso-style-type:personal;
=09font-family:"Calibri","sans-serif";
=09color:windowtext;}
span.EmailStyle18
=09{mso-style-type:personal;
=09font-family:"Calibri","sans-serif";
=09color:#1F497D;}
span.EmailStyle19
=09{mso-style-type:personal-reply;
=09font-family:"Calibri","sans-serif";
=09color:#1F497D;}
span.BalloonTextChar
=09{mso-style-name:"Balloon Text Char";
=09mso-style-priority:99;
=09mso-style-link:"Balloon Text";
=09font-family:"Tahoma","sans-serif";}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-size:10.0pt;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style>


<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">It sounds great, I lik=
e the idea. Just to make sure I understand your suggestion, are we talking =
about converting the variable argument list to string in include/lttng/ust-=
tracepoint-event-write.h?</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">For example:</span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">#define ctf_format_string(_item, =E2=80=A6)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; \</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
\</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;char _buf[BUF_MAXLEN];&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;snprintf(buf, sizeof(_buf), __VA_ARGS__);&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
&nbsp;_ctf_string(_item, _buf, 0);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; \</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; } while(0)</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Or do you have some be=
tter place to put this logic?</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Thanks,</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Mate</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;</span></p>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Mathieu =
Desnoyers [mailto:mathieu.desnoyers@efficios.com]
<br>
<b>Sent:</b> Wednesday, December 11, 2013 4:48 PM<br>
<b>To:</b> M=C3=A1t=C3=A9 Ferenczy<br>
<b>Cc:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> Re: efficient use of LTTng in legacy codebase</span></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;</p>
<div>
<div class=3D"MsoNormal" style=3D"text-align:center" align=3D"center"><span=
 style=3D"color:black">
<hr id=3D"zwchr" align=3D"center" size=3D"3" width=3D"100%">
</span></div>
<blockquote style=3D"border:none;border-left:solid #1010FF 1.5pt;padding:0i=
n 0in 0in 4.0pt;margin-left:3.75pt;margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Helvetica&quot;,=
&quot;sans-serif&quot;;color:black">From:
</span></b><span style=3D"font-family:&quot;Helvetica&quot;,&quot;sans-seri=
f&quot;;color:black">"M=C3=A1t=C3=A9 Ferenczy" &lt;<a href=3D"mailto:mate.f=
erenczy@ericsson.com" target=3D"_blank">mate.ferenczy@ericsson.com</a>&gt;<=
br>
<b>To: </b>"mathieu desnoyers" &lt;<a href=3D"mailto:mathieu.desnoyers@effi=
cios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>
<b>Cc: </b><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a><br>
<b>Sent: </b>Wednesday, December 11, 2013 6:52:22 PM<br>
<b>Subject: </b>RE: efficient use of LTTng in legacy codebase</span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">&nbsp;</span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"color:black">I found this email threa=
d: <a href=3D"https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg022=
78.html" target=3D"_blank">
https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg02278.html</a></s=
pan><br data-mce-bogus=3D"1"></p>
<p class=3D"MsoNormal"><span style=3D"color:black">According to this I coul=
d just check caa_unlikely(__tracepoint_##provider##___##name.state). Howeve=
r, Dave claims that this state will stay true even if the tracepoint is dis=
abled. Is there anything else I should
 check for?</span></p>
</blockquote>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;;color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;;color:black">I would recommend doing =
this in the UST probe provider instead. Within the TRACEPOINT_EVENT "TP_FIE=
LD" section, when you declare your string field, you could
 parse the format string there in the last argument of a ctf_string() (a st=
atement expression). The format string would be received as parameter by th=
e tracepoint, along with a variable arg list (...). In the probe, it would =
be turned into a va_list (see stdarg(3)),
 and the parameters could be decoded into a string there. This has the bene=
fit of moving the serialization call out-of-line into the probe provider ra=
ther than clobbering the tracepoint call site.</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;;color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;;color:black">Thoughts ?</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;;color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;;color:black">Thanks,</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;;color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;;color:black">Mathieu</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;;color:black">&nbsp;</span></p>
</div>
<blockquote style=3D"border:none;border-left:solid #1010FF 1.5pt;padding:0i=
n 0in 0in 4.0pt;margin-left:3.75pt;margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal"><span style=3D"color:black">Thanks,</span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">Mate</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;</span><span sty=
le=3D"color:black"></span></p>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><span sty=
le=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot=
;;color:black"> M=C3=A1t=C3=A9 Ferenczy
<br>
<b>Sent:</b> Wednesday, December 11, 2013 12:17 PM<br>
<b>To:</b> 'mathieu.desnoyers@efficios.com'<br>
<b>Cc:</b> 'lttng-dev@lists.lttng.org'<br>
<b>Subject:</b> efficient use of LTTng in legacy codebase</span><span style=
=3D"color:black"></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"color:black">Hello Mathieu,</span></p=
>
<p class=3D"MsoNormal"><span style=3D"color:black">Our team was asked to su=
pport LTTng UST solution in a legacy codebase. The existing codebase is fai=
rly large, and the requirement is that we provide all the existing logs and=
 debugs in the system as LTTng traces.</span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">The planned solution so =
far was just to pass everything we have as text (strings) to LTTng. For tha=
t we obviously have to convert the printf-like format string and parameter =
list to a string by calling snprintf
 before giving the string to the LTTng API. That would however mean, that t=
hese snprintfs are getting called every time even if there is no listener/a=
ctive trace session for the given trace. In this case, all those unnecessar=
y snprintf calls may end up significantly
 impacting the performance of our applications.</span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">In order to work around =
this, we were thinking that if there was a way to query the LTTng library f=
rom our application code whether there is an active tracing session for the=
 given trace level, we could avoid calling
 those snprintfs in case they are not needed. Do you think it would be feas=
ible to easily get this data from LTTng lib? If yes, can you provide us som=
e pointers where to look at in order to do those changes ourselves?</span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:black">Any suggestions are welc=
ome.</span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">Thank you,</span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">Mate Ferenczy</span></p>
</blockquote>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:12.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;color:=
black">&nbsp;</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;;color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;;color:black">--
</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;;color:black">Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a></span><br data-mce-bogus=3D"1"></p>
</div>
</div>
</div>


</blockquote><div><br><br></div><div><br></div><div>-- <br></div><div><span=
 name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficio=
s.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_84235_786759966.1386851719332--

------=_Part_84234_95876688.1386851719332
Content-Type: text/x-patch; name=trace-fmt-demo.patch
Content-Disposition: attachment; filename=trace-fmt-demo.patch
Content-Transfer-Encoding: base64

Y29tbWl0IDJlNTg5YjYyMzUzOTZkMjk4MzJhZDlmZjUyZWNjMzVhOThkZjM0OWYKQXV0aG9yOiBN
YXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgpEYXRlOiAg
IFRodSBEZWMgMTIgMDc6Mjk6MjYgMjAxMyAtMDUwMAoKICAgIEFkZCB0cmFjZSBmb3JtYXQgZGVt
bwogICAgCiAgICBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNu
b3llcnNAZWZmaWNpb3MuY29tPgoKZGlmZiAtLWdpdCBhLy5naXRpZ25vcmUgYi8uZ2l0aWdub3Jl
CmluZGV4IGNlN2M1NzIuLmVjZTlmNWIgMTAwNjQ0Ci0tLSBhLy5naXRpZ25vcmUKKysrIGIvLmdp
dGlnbm9yZQpAQCAtMzYsNiArMzYsNyBAQCBkb2MvZXhhbXBsZXMvZWFzeS11c3Qvc2FtcGxlCiBk
b2MvZXhhbXBsZXMvaGVsbG8tc3RhdGljLWxpYi9oZWxsbwogZG9jL2V4YW1wbGVzL2dlbi10cC9z
YW1wbGUKIGRvYy9leGFtcGxlcy9nZW4tdHAvc2FtcGxlX3RyYWNlcG9pbnQuaAorZG9jL2V4YW1w
bGVzL2RlbW8tZm10LXN0cmluZy9kZW1vLWZtdC1zdHJpbmcKIAogdGVzdHMvaGVsbG8vaGVsbG8K
IHRlc3RzL2hlbGxvLmN4eC9oZWxsbwpkaWZmIC0tZ2l0IGEvZG9jL2V4YW1wbGVzL01ha2VmaWxl
LmFtIGIvZG9jL2V4YW1wbGVzL01ha2VmaWxlLmFtCmluZGV4IDcyNTgwNmQuLjkxNzk3NmQgMTAw
NjQ0Ci0tLSBhL2RvYy9leGFtcGxlcy9NYWtlZmlsZS5hbQorKysgYi9kb2MvZXhhbXBsZXMvTWFr
ZWZpbGUuYW0KQEAgLTQ0LDcgKzQ0LDcgQEAgaWYgTk9fU0hBUkVECiAjIGRpc2FibGVkLgogZWxz
ZQogIyBDb3BpZXMgYXJlIGZvciBWUEFUSCBidWlsZCBzdXBwb3J0Ci1TVUJESVJTX1BST1hZID0g
ZWFzeS11c3QgZGVtbyBnZW4tdHAgaGVsbG8tc3RhdGljLWxpYgorU1VCRElSU19QUk9YWSA9IGVh
c3ktdXN0IGRlbW8gZ2VuLXRwIGhlbGxvLXN0YXRpYy1saWIgZGVtby1mbXQtc3RyaW5nCiAKIGFs
bC1sb2NhbDoKIAlAaWYgWyB4IiQoc3JjZGlyKSIgIT0geCIkKGJ1aWxkZGlyKSIgXTsgdGhlbiBc
CmRpZmYgLS1naXQgYS9kb2MvZXhhbXBsZXMvZGVtby1mbXQtc3RyaW5nL01ha2VmaWxlIGIvZG9j
L2V4YW1wbGVzL2RlbW8tZm10LXN0cmluZy9NYWtlZmlsZQpuZXcgZmlsZSBtb2RlIDEwMDY0NApp
bmRleCAwMDAwMDAwLi5hMzA2MGQzCi0tLSAvZGV2L251bGwKKysrIGIvZG9jL2V4YW1wbGVzL2Rl
bW8tZm10LXN0cmluZy9NYWtlZmlsZQpAQCAtMCwwICsxLDQ4IEBACisjIENvcHlyaWdodCAoQykg
MjAxMyAgSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29t
PgorIworIyBUSElTIE1BVEVSSUFMIElTIFBST1ZJREVEIEFTIElTLCBXSVRIIEFCU09MVVRFTFkg
Tk8gV0FSUkFOVFkgRVhQUkVTU0VECisjIE9SIElNUExJRUQuIEFOWSBVU0UgSVMgQVQgWU9VUiBP
V04gUklTSy4KKyMKKyMgUGVybWlzc2lvbiBpcyBoZXJlYnkgZ3JhbnRlZCB0byB1c2Ugb3IgY29w
eSB0aGlzIHByb2dyYW0gZm9yIGFueQorIyBwdXJwb3NlLCBwcm92aWRlZCB0aGUgYWJvdmUgbm90
aWNlcyBhcmUgcmV0YWluZWQgb24gYWxsIGNvcGllcy4KKyMgUGVybWlzc2lvbiB0byBtb2RpZnkg
dGhlIGNvZGUgYW5kIHRvIGRpc3RyaWJ1dGUgbW9kaWZpZWQgY29kZSBpcworIyBncmFudGVkLCBw
cm92aWRlZCB0aGUgYWJvdmUgbm90aWNlcyBhcmUgcmV0YWluZWQsIGFuZCBhIG5vdGljZSB0aGF0
CisjIHRoZSBjb2RlIHdhcyBtb2RpZmllZCBpcyBpbmNsdWRlZCB3aXRoIHRoZSBhYm92ZSBjb3B5
cmlnaHQgbm90aWNlLgorIworIyBUaGlzIE1ha2VmaWxlIGlzIG5vdCB1c2luZyBhdXRvbWFrZSBz
byB0aGF0IHVzZXJzIG1heSBzZWUgaG93IHRvIGJ1aWxkCisjIGEgcHJvZ3JhbSB3aXRoIHRyYWNl
cG9pbnQgcHJvdmlkZXIgcHJvYmVzIGFzIHN0YW5kLWFsb25lIHNoYXJlZCBvYmplY3RzLgorIwor
IyBUaGlzIG1ha2VmaWxlIGlzIHB1cnBvc2VmdWxseSBrZXB0IHNpbXBsZSB0byBzdXBwb3J0IEdO
VSBhbmQgQlNEIG1ha2UuCisKK0NDID0gZ2NjCitMSUJTID0gLWxkbCAtbGx0dG5nLXVzdAkjIE9u
IExpbnV4CisjTElCUyA9IC1sYwkjIE9uIEJTRAorTE9DQUxfQ1BQRkxBR1MgKz0gLUkuCisKK2Fs
bDogZGVtby1mbXQtc3RyaW5nCisKK3RwLm86IHRwLmMgdXN0X3Rlc3RzX2RlbW9fZm10X3N0cmlu
Zy5oIHRyYWNlLWZtdC5oCisJJChDQykgJChDUFBGTEFHUykgJChMT0NBTF9DUFBGTEFHUykgJChD
RkxBR1MpICQoQU1fQ1BQRkxBR1MpIFwKKwkJJChBTV9DRkxBR1MpIC1mcGljIC1jIC1vICRAICQ8
CisKK3RyYWNlLWZtdC5vOiB0cmFjZS1mbXQuYyB1c3RfdGVzdHNfZGVtb19mbXRfc3RyaW5nLmgg
dHJhY2UtZm10LmgKKwkkKENDKSAkKENQUEZMQUdTKSAkKExPQ0FMX0NQUEZMQUdTKSAkKENGTEFH
UykgJChBTV9DUFBGTEFHUykgXAorCQkkKEFNX0NGTEFHUykgLWZwaWMgLWMgLW8gJEAgJDwKKwor
CitsdHRuZy11c3QtcHJvdmlkZXItdXN0LXRlc3RzLWRlbW8tZm10LXN0cmluZy5hOiB0cC5vIHRy
YWNlLWZtdC5vCisJYXIgLXJjICRAICQrCisKK2RlbW8tZm10LXN0cmluZy5vOiBkZW1vLWZtdC1z
dHJpbmcuYyB0cmFjZS1mbXQuaAorCSQoQ0MpICQoQ1BQRkxBR1MpICQoTE9DQUxfQ1BQRkxBR1Mp
ICQoQ0ZMQUdTKSAkKEFNX0NQUEZMQUdTKSBcCisJCSQoQU1fQ0ZMQUdTKSAtYyAtbyAkQCAkPAor
CitkZW1vLWZtdC1zdHJpbmc6IGRlbW8tZm10LXN0cmluZy5vIFwKKwkJbHR0bmctdXN0LXByb3Zp
ZGVyLXVzdC10ZXN0cy1kZW1vLWZtdC1zdHJpbmcuYQorCSQoQ0MpICQoTERGTEFHUykgJChDRkxB
R1MpICQoQU1fTERGTEFHUykgJChBTV9DRkxBR1MpIFwKKwkJLW8gJEAgZGVtby1mbXQtc3RyaW5n
Lm8gXAorCQlsdHRuZy11c3QtcHJvdmlkZXItdXN0LXRlc3RzLWRlbW8tZm10LXN0cmluZy5hICQo
TElCUykKKworLlBIT05ZOiBjbGVhbgorY2xlYW46CisJcm0gLWYgKi5vICouYSBkZW1vLWZtdC1z
dHJpbmcKZGlmZiAtLWdpdCBhL2RvYy9leGFtcGxlcy9kZW1vLWZtdC1zdHJpbmcvUkVBRE1FIGIv
ZG9jL2V4YW1wbGVzL2RlbW8tZm10LXN0cmluZy9SRUFETUUKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMC4uZTA2OWU3MwotLS0gL2Rldi9udWxsCisrKyBiL2RvYy9leGFtcGxlcy9k
ZW1vLWZtdC1zdHJpbmcvUkVBRE1FCkBAIC0wLDAgKzEsMjAgQEAKK1RoaXMgaXMgYSBkZW1vIGFw
cGxpY2F0aW9uIHNob3dpbmcgaG93IHRvIHRyYWNlIGZvcm1hdHRlZCBzdHJpbmdzIGludG8KK0xU
VG5nLVVTVC4KKworVGhlIHNpbXBsZXN0IGNvbW1hbmQgdG8gdHJhY2UgdGhlIGRlbW8gcHJvZ3Jh
bSBhcmU6CisKK2x0dG5nIGNyZWF0ZQorbHR0bmcgZW5hYmxlLWV2ZW50IC11ICJ1c3RfdGVzdHNf
ZGVtb19mbXRfc3RyaW5nOmV2ZW50IgorbHR0bmcgc3RhcnQKKy4vZGVtby1mbXQtc3RyaW5nCits
dHRuZyBzdG9wCitsdHRuZyB2aWV3CitsdHRuZyBkZXN0cm95CisKK1RoZSByZXN1bHRpbmcgbHR0
bmcgdmlldyBvdXRwdXQgc2hvdWxkIGxvb2sgbGlrZSB0aGlzOgorCitbMDc6MzI6MDIuMDIxMDQ1
NjgzXSAoKz8uPz8/Pz8/Pz8/KSB0aGlua29zIHVzdF90ZXN0c19kZW1vX2ZtdF9zdHJpbmc6ZXZl
bnQ6IHsgY3B1X2lkID0gMiB9LCB7IF9tc2dfbGVuZ3RoID0gNDYsIG1zZyA9ICJUaGlzIGlzIGEg
Im15c3RyaW5nIHRlc3QiIGZvcm1hdHRlZCAwIGV2ZW50IDQyIiB9CitbMDc6MzI6MDIuMDIxMDYy
MzI4XSAoKzAuMDAwMDE2NjQ1KSB0aGlua29zIHVzdF90ZXN0c19kZW1vX2ZtdF9zdHJpbmc6ZXZl
bnQ6IHsgY3B1X2lkID0gMiB9LCB7IF9tc2dfbGVuZ3RoID0gNDYsIG1zZyA9ICJUaGlzIGlzIGEg
Im15c3RyaW5nIHRlc3QiIGZvcm1hdHRlZCAxIGV2ZW50IDQyIiB9CitbMDc6MzI6MDIuMDIxMDY2
MzAwXSAoKzAuMDAwMDAzOTcyKSB0aGlua29zIHVzdF90ZXN0c19kZW1vX2ZtdF9zdHJpbmc6ZXZl
bnQ6IHsgY3B1X2lkID0gMiB9LCB7IF9tc2dfbGVuZ3RoID0gNDYsIG1zZyA9ICJUaGlzIGlzIGEg
Im15c3RyaW5nIHRlc3QiIGZvcm1hdHRlZCAyIGV2ZW50IDQyIiB9CitbMDc6MzI6MDIuMDIxMDY5
NTA3XSAoKzAuMDAwMDAzMjA3KSB0aGlua29zIHVzdF90ZXN0c19kZW1vX2ZtdF9zdHJpbmc6ZXZl
bnQ6IHsgY3B1X2lkID0gMiB9LCB7IF9tc2dfbGVuZ3RoID0gNDYsIG1zZyA9ICJUaGlzIGlzIGEg
Im15c3RyaW5nIHRlc3QiIGZvcm1hdHRlZCAzIGV2ZW50IDQyIiB9CitbMDc6MzI6MDIuMDIxMDcy
NTQxXSAoKzAuMDAwMDAzMDM0KSB0aGlua29zIHVzdF90ZXN0c19kZW1vX2ZtdF9zdHJpbmc6ZXZl
bnQ6IHsgY3B1X2lkID0gMiB9LCB7IF9tc2dfbGVuZ3RoID0gNDYsIG1zZyA9ICJUaGlzIGlzIGEg
Im15c3RyaW5nIHRlc3QiIGZvcm1hdHRlZCA0IGV2ZW50IDQyIiB9CmRpZmYgLS1naXQgYS9kb2Mv
ZXhhbXBsZXMvZGVtby1mbXQtc3RyaW5nL2RlbW8tZm10LXN0cmluZy5jIGIvZG9jL2V4YW1wbGVz
L2RlbW8tZm10LXN0cmluZy9kZW1vLWZtdC1zdHJpbmcuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NApp
bmRleCAwMDAwMDAwLi43YmU0ZWM0Ci0tLSAvZGV2L251bGwKKysrIGIvZG9jL2V4YW1wbGVzL2Rl
bW8tZm10LXN0cmluZy9kZW1vLWZtdC1zdHJpbmcuYwpAQCAtMCwwICsxLDU2IEBACisvKgorICog
Q29weXJpZ2h0IChDKSAyMDA5ICBQaWVycmUtTWFyYyBGb3VybmllcgorICogQ29weXJpZ2h0IChD
KSAyMDExICBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29t
PgorICoKKyAqIFRoaXMgbGlicmFyeSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJp
YnV0ZSBpdCBhbmQvb3IKKyAqIG1vZGlmeSBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBM
ZXNzZXIgR2VuZXJhbCBQdWJsaWMKKyAqIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVl
IFNvZnR3YXJlIEZvdW5kYXRpb247IHZlcnNpb24gMi4xIG9mCisgKiB0aGUgTGljZW5zZS4KKyAq
CisgKiBUaGlzIGxpYnJhcnkgaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxs
IGJlIHVzZWZ1bCwKKyAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRo
ZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1Ig
QSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlIEdOVQorICogTGVzc2VyIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVj
ZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgTGVzc2VyIEdlbmVyYWwgUHVibGljCisgKiBMaWNlbnNl
IGFsb25nIHdpdGggdGhpcyBsaWJyYXJ5OyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3
YXJlCisgKiBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xpbiBTdHJlZXQsIEZpZnRoIEZsb29y
LCBCb3N0b24sIE1BICAwMjExMC0xMzAxIFVTQQorICovCisKKyNpbmNsdWRlIDxzdGRpby5oPgor
I2luY2x1ZGUgPHVuaXN0ZC5oPgorI2luY2x1ZGUgPHN5cy9tbWFuLmg+CisjaW5jbHVkZSA8c3Rk
YXJnLmg+CisjaW5jbHVkZSA8c3lzL3R5cGVzLmg+CisjaW5jbHVkZSA8c3lzL3N0YXQuaD4KKyNp
bmNsdWRlIDxmY250bC5oPgorI2luY2x1ZGUgPHNpZ25hbC5oPgorI2luY2x1ZGUgPHN0cmluZy5o
PgorI2luY2x1ZGUgPGFycGEvaW5ldC5oPgorI2luY2x1ZGUgPHN0ZGxpYi5oPgorCisjaW5jbHVk
ZSAidHJhY2UtZm10LmgiCisKK2ludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKK3sKKwlp
bnQgaTsKKwlpbnQgZGVsYXkgPSAwOworCWNvbnN0IGNoYXIgKnN0ciA9ICJteXN0cmluZyB0ZXN0
IjsKKwlsb25nIGwgPSAweDQyOworCisJaWYgKGFyZ2MgPT0gMikKKwkJZGVsYXkgPSBhdG9pKGFy
Z3ZbMV0pOworCisJZnByaW50ZihzdGRlcnIsICJEZW1vIHByb2dyYW0gc3RhcnRpbmcuXG4iKTsK
KworCXNsZWVwKGRlbGF5KTsKKworCWZwcmludGYoc3RkZXJyLCAiVHJhY2luZy4uLiAiKTsKKwlm
b3IgKGkgPSAwOyBpIDwgNTsgaSsrKSB7CisJCXVzdF90ZXN0c19kZW1vX3RyYWNlX2ZtdCgKKwkJ
CSJUaGlzIGlzIGEgXCIlc1wiIGZvcm1hdHRlZCAlZCBldmVudCAlbHgiLAorCQkJc3RyLCBpLCBs
KTsKKwl9CisJZnByaW50ZihzdGRlcnIsICIgZG9uZS5cbiIpOworCXJldHVybiAwOworfQpkaWZm
IC0tZ2l0IGEvZG9jL2V4YW1wbGVzL2RlbW8tZm10LXN0cmluZy90cC5jIGIvZG9jL2V4YW1wbGVz
L2RlbW8tZm10LXN0cmluZy90cC5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAu
LjQ3MjgzYWQKLS0tIC9kZXYvbnVsbAorKysgYi9kb2MvZXhhbXBsZXMvZGVtby1mbXQtc3RyaW5n
L3RwLmMKQEAgLTAsMCArMSwyNiBAQAorLyoKKyAqIHRwLmMKKyAqCisgKiBDb3B5cmlnaHQgKGMp
IDIwMTEgTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4K
KyAqCisgKiBQZXJtaXNzaW9uIGlzIGhlcmVieSBncmFudGVkLCBmcmVlIG9mIGNoYXJnZSwgdG8g
YW55IHBlcnNvbiBvYnRhaW5pbmcgYSBjb3B5CisgKiBvZiB0aGlzIHNvZnR3YXJlIGFuZCBhc3Nv
Y2lhdGVkIGRvY3VtZW50YXRpb24gZmlsZXMgKHRoZSAiU29mdHdhcmUiKSwgdG8gZGVhbAorICog
aW4gdGhlIFNvZnR3YXJlIHdpdGhvdXQgcmVzdHJpY3Rpb24sIGluY2x1ZGluZyB3aXRob3V0IGxp
bWl0YXRpb24gdGhlIHJpZ2h0cworICogdG8gdXNlLCBjb3B5LCBtb2RpZnksIG1lcmdlLCBwdWJs
aXNoLCBkaXN0cmlidXRlLCBzdWJsaWNlbnNlLCBhbmQvb3Igc2VsbAorICogY29waWVzIG9mIHRo
ZSBTb2Z0d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25zIHRvIHdob20gdGhlIFNvZnR3YXJlIGlz
CisgKiBmdXJuaXNoZWQgdG8gZG8gc28sIHN1YmplY3QgdG8gdGhlIGZvbGxvd2luZyBjb25kaXRp
b25zOgorICoKKyAqIFRoZSBhYm92ZSBjb3B5cmlnaHQgbm90aWNlIGFuZCB0aGlzIHBlcm1pc3Np
b24gbm90aWNlIHNoYWxsIGJlIGluY2x1ZGVkIGluCisgKiBhbGwgY29waWVzIG9yIHN1YnN0YW50
aWFsIHBvcnRpb25zIG9mIHRoZSBTb2Z0d2FyZS4KKyAqCisgKiBUSEUgU09GVFdBUkUgSVMgUFJP
VklERUQgIkFTIElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkgS0lORCwgRVhQUkVTUyBPUgor
ICogSU1QTElFRCwgSU5DTFVESU5HIEJVVCBOT1QgTElNSVRFRCBUTyBUSEUgV0FSUkFOVElFUyBP
RiBNRVJDSEFOVEFCSUxJVFksCisgKiBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBB
TkQgTk9OSU5GUklOR0VNRU5ULiBJTiBOTyBFVkVOVCBTSEFMTCBUSEUKKyAqIEFVVEhPUlMgT1Ig
Q09QWVJJR0hUIEhPTERFUlMgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0sIERBTUFHRVMgT1IgT1RI
RVIKKyAqIExJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQg
T1IgT1RIRVJXSVNFLCBBUklTSU5HIEZST00sCisgKiBPVVQgT0YgT1IgSU4gQ09OTkVDVElPTiBX
SVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUgVVNFIE9SIE9USEVSIERFQUxJTkdTIElOIFRIRQorICog
U09GVFdBUkUuCisgKi8KKworI2RlZmluZSBUUkFDRVBPSU5UX0NSRUFURV9QUk9CRVMKKyNpbmNs
dWRlICJ1c3RfdGVzdHNfZGVtb19mbXRfc3RyaW5nLmgiCmRpZmYgLS1naXQgYS9kb2MvZXhhbXBs
ZXMvZGVtby1mbXQtc3RyaW5nL3RyYWNlLWZtdC5jIGIvZG9jL2V4YW1wbGVzL2RlbW8tZm10LXN0
cmluZy90cmFjZS1mbXQuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4xZjU5
YmU0Ci0tLSAvZGV2L251bGwKKysrIGIvZG9jL2V4YW1wbGVzL2RlbW8tZm10LXN0cmluZy90cmFj
ZS1mbXQuYwpAQCAtMCwwICsxLDQ3IEBACisvKgorICogQ29weXJpZ2h0IChDKSAyMDEzICBNYXRo
aWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgorICoKKyAqIFBl
cm1pc3Npb24gaXMgaGVyZWJ5IGdyYW50ZWQsIGZyZWUgb2YgY2hhcmdlLCB0byBhbnkgcGVyc29u
IG9idGFpbmluZyBhIGNvcHkKKyAqIG9mIHRoaXMgc29mdHdhcmUgYW5kIGFzc29jaWF0ZWQgZG9j
dW1lbnRhdGlvbiBmaWxlcyAodGhlICJTb2Z0d2FyZSIpLCB0byBkZWFsCisgKiBpbiB0aGUgU29m
dHdhcmUgd2l0aG91dCByZXN0cmljdGlvbiwgaW5jbHVkaW5nIHdpdGhvdXQgbGltaXRhdGlvbiB0
aGUgcmlnaHRzCisgKiB0byB1c2UsIGNvcHksIG1vZGlmeSwgbWVyZ2UsIHB1Ymxpc2gsIGRpc3Ry
aWJ1dGUsIHN1YmxpY2Vuc2UsIGFuZC9vciBzZWxsCisgKiBjb3BpZXMgb2YgdGhlIFNvZnR3YXJl
LCBhbmQgdG8gcGVybWl0IHBlcnNvbnMgdG8gd2hvbSB0aGUgU29mdHdhcmUgaXMKKyAqIGZ1cm5p
c2hlZCB0byBkbyBzbywgc3ViamVjdCB0byB0aGUgZm9sbG93aW5nIGNvbmRpdGlvbnM6CisgKgor
ICogVGhlIGFib3ZlIGNvcHlyaWdodCBub3RpY2UgYW5kIHRoaXMgcGVybWlzc2lvbiBub3RpY2Ug
c2hhbGwgYmUgaW5jbHVkZWQgaW4KKyAqIGFsbCBjb3BpZXMgb3Igc3Vic3RhbnRpYWwgcG9ydGlv
bnMgb2YgdGhlIFNvZnR3YXJlLgorICoKKyAqIFRIRSBTT0ZUV0FSRSBJUyBQUk9WSURFRCAiQVMg
SVMiLCBXSVRIT1VUIFdBUlJBTlRZIE9GIEFOWSBLSU5ELCBFWFBSRVNTIE9SCisgKiBJTVBMSUVE
LCBJTkNMVURJTkcgQlVUIE5PVCBMSU1JVEVEIFRPIFRIRSBXQVJSQU5USUVTIE9GIE1FUkNIQU5U
QUJJTElUWSwKKyAqIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFIEFORCBOT05JTkZS
SU5HRU1FTlQuIElOIE5PIEVWRU5UIFNIQUxMIFRIRQorICogQVVUSE9SUyBPUiBDT1BZUklHSFQg
SE9MREVSUyBCRSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwgREFNQUdFUyBPUiBPVEhFUgorICogTElB
QklMSVRZLCBXSEVUSEVSIElOIEFOIEFDVElPTiBPRiBDT05UUkFDVCwgVE9SVCBPUiBPVEhFUldJ
U0UsIEFSSVNJTkcgRlJPTSwKKyAqIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNP
RlRXQVJFIE9SIFRIRSBVU0UgT1IgT1RIRVIgREVBTElOR1MgSU4gVEhFCisgKiBTT0ZUV0FSRS4K
KyAqLworCisKKyNkZWZpbmUgX0dOVV9TT1VSQ0UKKyNpbmNsdWRlIDxzdGRpby5oPgorCisjZGVm
aW5lIFRSQUNFUE9JTlRfREVGSU5FCisjaW5jbHVkZSAidHJhY2UtZm10LmgiCisKK3ZvaWQgX3Vz
dF90ZXN0c19kZW1vX3RyYWNlX2ZtdChjb25zdCBjaGFyICpmbXQsIC4uLikKK3sKKwl2YV9saXN0
IGFwOworCWNoYXIgKm1zZzsKKwlpbnQgbGVuOworCisJdmFfc3RhcnQoYXAsIGZtdCk7CisJbGVu
ID0gdmFzcHJpbnRmKCZtc2csIGZtdCwgYXApOworCS8qIGxlbiBkb2VzIG5vdCBpbmNsdWRlIHRo
ZSBmaW5hbCBcMCAqLworCWlmIChsZW4gPCAwKQorCQlnb3RvIGVuZDsKKwlfX3RyYWNlcG9pbnRf
Y2JfdXN0X3Rlc3RzX2RlbW9fZm10X3N0cmluZ19fX2V2ZW50KG1zZywgbGVuKTsKKwlmcmVlKG1z
Zyk7CitlbmQ6CisJdmFfZW5kKGFwKTsKK30KKworCmRpZmYgLS1naXQgYS9kb2MvZXhhbXBsZXMv
ZGVtby1mbXQtc3RyaW5nL3RyYWNlLWZtdC5oIGIvZG9jL2V4YW1wbGVzL2RlbW8tZm10LXN0cmlu
Zy90cmFjZS1mbXQuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi43M2VmNThk
Ci0tLSAvZGV2L251bGwKKysrIGIvZG9jL2V4YW1wbGVzL2RlbW8tZm10LXN0cmluZy90cmFjZS1m
bXQuaApAQCAtMCwwICsxLDM3IEBACisjaWZuZGVmIF9MVFROR19VU1RfREVNT19UUkFDRV9GTVRf
SAorI2RlZmluZSBfTFRUTkdfVVNUX0RFTU9fVFJBQ0VfRk1UX0gKKworLyoKKyAqIENvcHlyaWdo
dCAoQykgMjAxMyAgTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9z
LmNvbT4KKyAqCisgKiBQZXJtaXNzaW9uIGlzIGhlcmVieSBncmFudGVkLCBmcmVlIG9mIGNoYXJn
ZSwgdG8gYW55IHBlcnNvbiBvYnRhaW5pbmcgYSBjb3B5CisgKiBvZiB0aGlzIHNvZnR3YXJlIGFu
ZCBhc3NvY2lhdGVkIGRvY3VtZW50YXRpb24gZmlsZXMgKHRoZSAiU29mdHdhcmUiKSwgdG8gZGVh
bAorICogaW4gdGhlIFNvZnR3YXJlIHdpdGhvdXQgcmVzdHJpY3Rpb24sIGluY2x1ZGluZyB3aXRo
b3V0IGxpbWl0YXRpb24gdGhlIHJpZ2h0cworICogdG8gdXNlLCBjb3B5LCBtb2RpZnksIG1lcmdl
LCBwdWJsaXNoLCBkaXN0cmlidXRlLCBzdWJsaWNlbnNlLCBhbmQvb3Igc2VsbAorICogY29waWVz
IG9mIHRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25zIHRvIHdob20gdGhlIFNvZnR3
YXJlIGlzCisgKiBmdXJuaXNoZWQgdG8gZG8gc28sIHN1YmplY3QgdG8gdGhlIGZvbGxvd2luZyBj
b25kaXRpb25zOgorICoKKyAqIFRoZSBhYm92ZSBjb3B5cmlnaHQgbm90aWNlIGFuZCB0aGlzIHBl
cm1pc3Npb24gbm90aWNlIHNoYWxsIGJlIGluY2x1ZGVkIGluCisgKiBhbGwgY29waWVzIG9yIHN1
YnN0YW50aWFsIHBvcnRpb25zIG9mIHRoZSBTb2Z0d2FyZS4KKyAqCisgKiBUSEUgU09GVFdBUkUg
SVMgUFJPVklERUQgIkFTIElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkgS0lORCwgRVhQUkVT
UyBPUgorICogSU1QTElFRCwgSU5DTFVESU5HIEJVVCBOT1QgTElNSVRFRCBUTyBUSEUgV0FSUkFO
VElFUyBPRiBNRVJDSEFOVEFCSUxJVFksCisgKiBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVS
UE9TRSBBTkQgTk9OSU5GUklOR0VNRU5ULiBJTiBOTyBFVkVOVCBTSEFMTCBUSEUKKyAqIEFVVEhP
UlMgT1IgQ09QWVJJR0hUIEhPTERFUlMgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0sIERBTUFHRVMg
T1IgT1RIRVIKKyAqIExJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1Qs
IFRPUlQgT1IgT1RIRVJXSVNFLCBBUklTSU5HIEZST00sCisgKiBPVVQgT0YgT1IgSU4gQ09OTkVD
VElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUgVVNFIE9SIE9USEVSIERFQUxJTkdTIElOIFRI
RQorICogU09GVFdBUkUuCisgKi8KKworI2luY2x1ZGUgInVzdF90ZXN0c19kZW1vX2ZtdF9zdHJp
bmcuaCIKKwordm9pZCBfdXN0X3Rlc3RzX2RlbW9fdHJhY2VfZm10KGNvbnN0IGNoYXIgKmZtdCwg
Li4uKTsKKworI2RlZmluZSB1c3RfdGVzdHNfZGVtb190cmFjZV9mbXQoZm10LCAuLi4pCQkJCVwK
KwlkbyB7CQkJCQkJCQlcCisJCVNUQVBfUFJPQkVWKHRyYWNlcG9pbnRfdXN0X3Rlc3RzX2RlbW9f
Zm10X3N0cmluZywgZXZlbnQsICMjIF9fVkFfQVJHU19fKTsgXAorCQlpZiAoY2FhX3VubGlrZWx5
KF9fdHJhY2Vwb2ludF91c3RfdGVzdHNfZGVtb19mbXRfc3RyaW5nX19fZXZlbnQuc3RhdGUpKSBc
CisJCQlfdXN0X3Rlc3RzX2RlbW9fdHJhY2VfZm10KGZtdCwgIyMgX19WQV9BUkdTX18pOwlcCisJ
fSB3aGlsZSAoMCkKKworI2VuZGlmIC8qIF9MVFROR19VU1RfREVNT19UUkFDRV9GTVRfSCAqLwpk
aWZmIC0tZ2l0IGEvZG9jL2V4YW1wbGVzL2RlbW8tZm10LXN0cmluZy91c3RfdGVzdHNfZGVtb19m
bXRfc3RyaW5nLmggYi9kb2MvZXhhbXBsZXMvZGVtby1mbXQtc3RyaW5nL3VzdF90ZXN0c19kZW1v
X2ZtdF9zdHJpbmcuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5jMWNmZjZi
Ci0tLSAvZGV2L251bGwKKysrIGIvZG9jL2V4YW1wbGVzL2RlbW8tZm10LXN0cmluZy91c3RfdGVz
dHNfZGVtb19mbXRfc3RyaW5nLmgKQEAgLTAsMCArMSw0NiBAQAorI3VuZGVmIFRSQUNFUE9JTlRf
UFJPVklERVIKKyNkZWZpbmUgVFJBQ0VQT0lOVF9QUk9WSURFUiB1c3RfdGVzdHNfZGVtb19mbXRf
c3RyaW5nCisKKyNpZiAhZGVmaW5lZChfVFJBQ0VQT0lOVF9VU1RfVEVTVFNfREVNT19GTVRfU1RS
SU5HX0gpIHx8IGRlZmluZWQoVFJBQ0VQT0lOVF9IRUFERVJfTVVMVElfUkVBRCkKKyNkZWZpbmUg
X1RSQUNFUE9JTlRfVVNUX1RFU1RTX0RFTU9fRk1UX1NUUklOR19ICisKKy8qCisgKiBDb3B5cmln
aHQgKEMpIDIwMTEgIE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lv
cy5jb20+CisgKgorICogUGVybWlzc2lvbiBpcyBoZXJlYnkgZ3JhbnRlZCwgZnJlZSBvZiBjaGFy
Z2UsIHRvIGFueSBwZXJzb24gb2J0YWluaW5nIGEgY29weQorICogb2YgdGhpcyBzb2Z0d2FyZSBh
bmQgYXNzb2NpYXRlZCBkb2N1bWVudGF0aW9uIGZpbGVzICh0aGUgIlNvZnR3YXJlIiksIHRvIGRl
YWwKKyAqIGluIHRoZSBTb2Z0d2FyZSB3aXRob3V0IHJlc3RyaWN0aW9uLCBpbmNsdWRpbmcgd2l0
aG91dCBsaW1pdGF0aW9uIHRoZSByaWdodHMKKyAqIHRvIHVzZSwgY29weSwgbW9kaWZ5LCBtZXJn
ZSwgcHVibGlzaCwgZGlzdHJpYnV0ZSwgc3VibGljZW5zZSwgYW5kL29yIHNlbGwKKyAqIGNvcGll
cyBvZiB0aGUgU29mdHdhcmUsIGFuZCB0byBwZXJtaXQgcGVyc29ucyB0byB3aG9tIHRoZSBTb2Z0
d2FyZSBpcworICogZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRoZSBmb2xsb3dpbmcg
Y29uZGl0aW9uczoKKyAqCisgKiBUaGUgYWJvdmUgY29weXJpZ2h0IG5vdGljZSBhbmQgdGhpcyBw
ZXJtaXNzaW9uIG5vdGljZSBzaGFsbCBiZSBpbmNsdWRlZCBpbgorICogYWxsIGNvcGllcyBvciBz
dWJzdGFudGlhbCBwb3J0aW9ucyBvZiB0aGUgU29mdHdhcmUuCisgKgorICogVEhFIFNPRlRXQVJF
IElTIFBST1ZJREVEICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5ZIEtJTkQsIEVYUFJF
U1MgT1IKKyAqIElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlURUQgVE8gVEhFIFdBUlJB
TlRJRVMgT0YgTUVSQ0hBTlRBQklMSVRZLAorICogRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBV
UlBPU0UgQU5EIE5PTklORlJJTkdFTUVOVC4gSU4gTk8gRVZFTlQgU0hBTEwgVEhFCisgKiBBVVRI
T1JTIE9SIENPUFlSSUdIVCBIT0xERVJTIEJFIExJQUJMRSBGT1IgQU5ZIENMQUlNLCBEQU1BR0VT
IE9SIE9USEVSCisgKiBMSUFCSUxJVFksIFdIRVRIRVIgSU4gQU4gQUNUSU9OIE9GIENPTlRSQUNU
LCBUT1JUIE9SIE9USEVSV0lTRSwgQVJJU0lORyBGUk9NLAorICogT1VUIE9GIE9SIElOIENPTk5F
Q1RJT04gV0lUSCBUSEUgU09GVFdBUkUgT1IgVEhFIFVTRSBPUiBPVEhFUiBERUFMSU5HUyBJTiBU
SEUKKyAqIFNPRlRXQVJFLgorICovCisKKyNpbmNsdWRlIDxsdHRuZy90cmFjZXBvaW50Lmg+Cisj
aW5jbHVkZSA8c3RkYXJnLmg+CisKK1RSQUNFUE9JTlRfRVZFTlQodXN0X3Rlc3RzX2RlbW9fZm10
X3N0cmluZywgZXZlbnQsCisJVFBfQVJHUyhjb25zdCBjaGFyICosIG1zZywgdW5zaWduZWQgaW50
LCBsZW4pLAorCVRQX0ZJRUxEUygKKwkJY3RmX3NlcXVlbmNlX3RleHQoY2hhciwgbXNnLCBtc2cs
IHVuc2lnbmVkIGludCwgbGVuKQorCSkKKykKK1RSQUNFUE9JTlRfTE9HTEVWRUwodXN0X3Rlc3Rz
X2RlbW9fZm10X3N0cmluZywgZXZlbnQsIFRSQUNFX0RFQlVHKQorCisjZW5kaWYgLyogX1RSQUNF
UE9JTlRfVVNUX1RFU1RTX0RFTU9fRk1UX1NUUklOR19IICovCisKKyN1bmRlZiBUUkFDRVBPSU5U
X0lOQ0xVREUKKyNkZWZpbmUgVFJBQ0VQT0lOVF9JTkNMVURFICIuL3VzdF90ZXN0c19kZW1vX2Zt
dF9zdHJpbmcuaCIKKworLyogVGhpcyBwYXJ0IG11c3QgYmUgb3V0c2lkZSBpZmRlZiBwcm90ZWN0
aW9uICovCisjaW5jbHVkZSA8bHR0bmcvdHJhY2Vwb2ludC1ldmVudC5oPgo=
------=_Part_84234_95876688.1386851719332
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

------=_Part_84234_95876688.1386851719332--
