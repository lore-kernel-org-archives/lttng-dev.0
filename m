From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng and Red Hat / CentOS RealTime Kernels
Date: Thu, 17 Nov 2016 16:11:59 +0000 (UTC)
Message-ID: <1321420326.5617.1479399119390.JavaMail.zimbra__13963.3782826879$1479399078$gmane$org@efficios.com>
References: <9EF0E366B97A2444B715BD7861705886E293EE69@EX2010-CO-06.AERO.BALL.com>
 <162450272.4446.1479335231606.JavaMail.zimbra@efficios.com>
 <9EF0E366B97A2444B715BD7861705886E2942E56@EX2010-CO-06.AERO.BALL.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2050233026691783411=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tKR3M6BnmzmbP
 for <lttng-dev@lists.lttng.org>; Thu, 17 Nov 2016 16:12:15 +0000 (UTC)
In-Reply-To: <9EF0E366B97A2444B715BD7861705886E2942E56@EX2010-CO-06.AERO.BALL.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Shane Swartz <sswartz@ball.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Daniel W Smith <dwsmith@ball.com>
List-Id: lttng-dev@lists.lttng.org

--===============2050233026691783411==
Content-Type: multipart/alternative;
	boundary="=_8a7507ad-4483-4a2d-842a-edb3ab07d0b4"

--=_8a7507ad-4483-4a2d-842a-edb3ab07d0b4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Nov 17, 2016, at 11:09 AM, Shane Swartz <sswartz@ball.com> wrote:=
=20

> Mathieu,

> Thanks for the quick response to this question.

> Can you please let me know what =E2=80=9CCl=E2=80=9D is.

CI stands for "Continuous Integration", see https://ci.lttng.org=20

Thanks,=20

Mathieu=20

> Thanks.

> -Shane Swartz

> From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> Sent: Wednesday, November 16, 2016 3:27 PM
> To: Swartz, Shane
> Cc: lttng-dev; Smith, Daniel W
> Subject: Re: [lttng-dev] LTTng and Red Hat / CentOS RealTime Kernels

> ----- On Nov 15, 2016, at 11:52 PM, Swartz, Shane < [ mailto:sswartz@ball=
.com |
> sswartz@ball.com ] > wrote:

>> Is it possible to load the LTTng tools with a Red Hat or CentOS version =
7 Real
>> Time kernel? If yes, can it be done using the EfficiOS LTTng packages or=
 only
>> by building the packages from source code?

>> Thanks.
> Hi Shane,

> The LTTng kernel tracer works with a range of Preempt-RT kernel versions.

> It is tested in CI on the Preempt-RT kernel branches currently maintained

> by preempt-rt developers. However, it does not currently cover the

> 3.8.13-rt27.34 kernel listed on the RHEL page, and the EfficiOS

> packages for RHEL do not currently target their Preempt-RT kernel.

> Thanks,

> Mathieu

> --

> Mathieu Desnoyers
> EfficiOS Inc.
> [ http://www.efficios.com/ | http://www.efficios.com ]

> This message and any enclosures are intended only for the addressee. Plea=
se
> notify the sender by email if you are not the intended recipient. If you =
are
> not the intended recipient, you may not use, copy, disclose, or distribut=
e this
> message or its contents or enclosures to any other person and any such ac=
tions
> may be unlawful. Ball reserves the right to monitor and review all messag=
es
> and enclosures sent to or from this email address.

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_8a7507ad-4483-4a2d-842a-edb3ab07d0b4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><style><!--

@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
=09{font-family:Tahoma;
=09panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
=09{font-family:Verdana;
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
span.BalloonTextChar
=09{mso-style-name:"Balloon Text Char";
=09mso-style-priority:99;
=09mso-style-link:"Balloon Text";
=09font-family:"Tahoma","sans-serif";}
span.EmailStyle19
=09{mso-style-type:personal;
=09font-family:"Verdana","sans-serif";
=09color:windowtext;
=09font-weight:normal;
=09font-style:normal;
=09text-decoration:none none;}
span.EmailStyle20
=09{mso-style-type:personal-reply;
=09font-family:"Verdana","sans-serif";
=09color:#1F497D;
=09font-weight:normal;
=09font-style:normal;
=09text-decoration:none none;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-size:10.0pt;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style></div><div><br></div><div><span id=3D"zwchr" data-marker=3D"__DI=
VIDER__">----- On Nov 17, 2016, at 11:09 AM, Shane Swartz &lt;sswartz@ball.=
com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=3D"WordSecti=
on1"><p class=3D"MsoNormal"><span style=3D"font-family:&quot;Verdana&quot;,=
&quot;sans-serif&quot;;color:#1F497D">Mathieu,</span></p><p class=3D"MsoNor=
mal"><span style=3D"font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;=
color:#1F497D">&nbsp;</span></p><p class=3D"MsoNormal"><span style=3D"font-=
family:&quot;Verdana&quot;,&quot;sans-serif&quot;;color:#1F497D">Thanks for=
 the quick response to this question.</span></p><p class=3D"MsoNormal"><spa=
n style=3D"font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;color:#1F=
497D">&nbsp;</span></p><p class=3D"MsoNormal"><span style=3D"font-family:&q=
uot;Verdana&quot;,&quot;sans-serif&quot;;color:#1F497D">Can you please let =
me know what =E2=80=9CCl=E2=80=9D is.</span></p></div></blockquote><div><br=
></div><div>CI stands for "Continuous Integration", see https://ci.lttng.or=
g<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Th=
anks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><di=
v>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div=
><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding=
-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:n=
one;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=3D"W=
ordSection1"><p class=3D"MsoNormal"><span style=3D"font-family:&quot;Verdan=
a&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;</span></p><p class=3D"=
MsoNormal"><span style=3D"font-family:&quot;Verdana&quot;,&quot;sans-serif&=
quot;;color:#1F497D">Thanks.</span></p><p class=3D"MsoNormal"><span style=
=3D"font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;color:#1F497D">&=
nbsp;</span></p><p class=3D"MsoNormal"><span style=3D"font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;;color:#1F497D">-Shane Swartz</span></p><p=
 class=3D"MsoNormal"><span style=3D"font-family:&quot;Verdana&quot;,&quot;s=
ans-serif&quot;;color:#1F497D">&nbsp;</span></p><div><div style=3D"border:n=
one;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in 0in 0in"><p class=3D"M=
soNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;=
,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Mathieu Desnoyers [ma=
ilto:mathieu.desnoyers@efficios.com]
<br>
<b>Sent:</b> Wednesday, November 16, 2016 3:27 PM<br>
<b>To:</b> Swartz, Shane<br>
<b>Cc:</b> lttng-dev; Smith, Daniel W<br>
<b>Subject:</b> Re: [lttng-dev] LTTng and Red Hat / CentOS RealTime Kernels=
</span></p></div></div><div><div><p class=3D"MsoNormal"><span style=3D"font=
-size:12.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:bla=
ck">&nbsp;</span></p></div><div><p class=3D"MsoNormal"><span style=3D"font-=
size:12.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:blac=
k">----- On Nov 15, 2016, at 11:52 PM, Swartz, Shane &lt;<a href=3D"mailto:=
sswartz@ball.com" target=3D"_blank">sswartz@ball.com</a>&gt; wrote:<br>
<br>
</span></p></div><div><blockquote style=3D"border:none;border-left:solid #1=
010FF 1.5pt;padding:0in 0in 0in 4.0pt;margin-left:3.75pt;margin-top:5.0pt;m=
argin-bottom:5.0pt"><p class=3D"MsoNormal"><span style=3D"font-family:&quot=
;Verdana&quot;,&quot;sans-serif&quot;;color:black">Is it possible to load t=
he LTTng tools with a Red Hat or CentOS version 7 Real Time kernel?&nbsp; I=
f yes, can it be done using the EfficiOS LTTng packages or only by building=
 the packages
 from source code?</span></p><p class=3D"MsoNormal"><span style=3D"font-fam=
ily:&quot;Verdana&quot;,&quot;sans-serif&quot;;color:black">&nbsp;</span></=
p><p class=3D"MsoNormal"><span style=3D"font-family:&quot;Verdana&quot;,&qu=
ot;sans-serif&quot;;color:black">Thanks.</span></p></blockquote><div><div><=
p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ari=
al&quot;,&quot;sans-serif&quot;;color:black">Hi Shane,</span></p></div><div=
><p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;A=
rial&quot;,&quot;sans-serif&quot;;color:black">&nbsp;</span></p></div><div>=
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:black">The LTTng kernel tracer works=
 with a range of Preempt-RT kernel versions.</span></p></div><div><p class=
=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot=
;,&quot;sans-serif&quot;;color:black">It is tested in CI on the Preempt-RT =
kernel branches currently maintained</span></p></div><div><p class=3D"MsoNo=
rmal"><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;;color:black">by preempt-rt developers. However, it does not=
 currently cover the</span></p></div><div><p class=3D"MsoNormal"><span styl=
e=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;=
color:black">3.8.13-rt27.34 kernel listed on the RHEL page, and the EfficiO=
S</span></p></div><div><p class=3D"MsoNormal"><span style=3D"font-size:12.0=
pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black">packag=
es for RHEL do not currently target their Preempt-RT kernel.</span></p></di=
v><div><p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&=
quot;Arial&quot;,&quot;sans-serif&quot;;color:black">&nbsp;</span></p></div=
><p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;A=
rial&quot;,&quot;sans-serif&quot;;color:black">Thanks,</span></p><div><p cl=
ass=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Arial&q=
uot;,&quot;sans-serif&quot;;color:black">&nbsp;</span></p></div><div><p cla=
ss=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Arial&qu=
ot;,&quot;sans-serif&quot;;color:black">Mathieu</span></p></div></div><div>=
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:black">&nbsp;</span></p></div><p cla=
ss=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Arial&qu=
ot;,&quot;sans-serif&quot;;color:black">&nbsp;</span></p></div><div><p clas=
s=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quo=
t;,&quot;sans-serif&quot;;color:black">--
</span></p></div><div><p class=3D"MsoNormal"><span style=3D"font-size:12.0p=
t;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black">Mathieu=
 Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a></span><br data-mce-bogus=3D"1"></p></div></div></div><div><br><br>
This message and any enclosures are intended only for the addressee.  Pleas=
e <br>
notify the sender by email if you are not the intended recipient.  If you a=
re <br>
not the intended recipient, you may not use, copy, disclose, or distribute =
this <br>
message or its contents or enclosures to any other person and any such acti=
ons <br>
may be unlawful.  Ball reserves the right to monitor and review all message=
s <br>
and enclosures sent to or from this email address.<br></div><br></blockquot=
e></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>=
Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></=
body></html>
--=_8a7507ad-4483-4a2d-842a-edb3ab07d0b4--

--===============2050233026691783411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2050233026691783411==--
