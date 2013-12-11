From: =?iso-8859-1?Q?M=E1t=E9_Ferenczy?= <mate.ferenczy@ericsson.com>
Subject: Re: efficient use of LTTng in legacy codebase
Date: Wed, 11 Dec 2013 23:52:22 +0000
Message-ID: <ECCC3645D4115E4293D3E8C0EB22F09C20D363__47272.9274108589$1386807702$gmane$org@ESESSMB109.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1847152311=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailgw1.ericsson.se ([193.180.251.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mate.ferenczy@ericsson.com>) id 1VqtZp-0004sg-0f
	for lttng-dev@lists.lttng.org; Wed, 11 Dec 2013 18:52:31 -0500
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1847152311==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_ECCC3645D4115E4293D3E8C0EB22F09C20D363ESESSMB109ericsso_"

--_000_ECCC3645D4115E4293D3E8C0EB22F09C20D363ESESSMB109ericsso_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I found this email thread: https://www.mail-archive.com/lttng-dev@lists.ltt=
ng.org/msg02278.html

According to this I could just check caa_unlikely(__tracepoint_##provider##=
___##name.state). However, Dave claims that this state will stay true even =
if the tracepoint is disabled. Is there anything else I should check for?

Thanks,
Mate

From: M=E1t=E9 Ferenczy
Sent: Wednesday, December 11, 2013 12:17 PM
To: 'mathieu.desnoyers@efficios.com'
Cc: 'lttng-dev@lists.lttng.org'
Subject: efficient use of LTTng in legacy codebase

Hello Mathieu,

Our team was asked to support LTTng UST solution in a legacy codebase. The =
existing codebase is fairly large, and the requirement is that we provide a=
ll the existing logs and debugs in the system as LTTng traces.

The planned solution so far was just to pass everything we have as text (st=
rings) to LTTng. For that we obviously have to convert the printf-like form=
at string and parameter list to a string by calling snprintf before giving =
the string to the LTTng API. That would however mean, that these snprintfs =
are getting called every time even if there is no listener/active trace ses=
sion for the given trace. In this case, all those unnecessary snprintf call=
s may end up significantly impacting the performance of our applications.

In order to work around this, we were thinking that if there was a way to q=
uery the LTTng library from our application code whether there is an active=
 tracing session for the given trace level, we could avoid calling those sn=
printfs in case they are not needed. Do you think it would be feasible to e=
asily get this data from LTTng lib? If yes, can you provide us some pointer=
s where to look at in order to do those changes ourselves?

Any suggestions are welcome.

Thank you,
Mate Ferenczy

--_000_ECCC3645D4115E4293D3E8C0EB22F09C20D363ESESSMB109ericsso_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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
<p class=3D"MsoNormal">I found this email thread: <a href=3D"https://www.ma=
il-archive.com/lttng-dev@lists.lttng.org/msg02278.html">
https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg02278.html</a><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">According to this I could just check caa_unlikely(__=
tracepoint_##provider##___##name.state). However, Dave claims that this sta=
te will stay true even if the tracepoint is disabled. Is there anything els=
e I should check for?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Mate<span style=3D"color:#1F497D"><o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> M=E1t=E9=
 Ferenczy
<br>
<b>Sent:</b> Wednesday, December 11, 2013 12:17 PM<br>
<b>To:</b> 'mathieu.desnoyers@efficios.com'<br>
<b>Cc:</b> 'lttng-dev@lists.lttng.org'<br>
<b>Subject:</b> efficient use of LTTng in legacy codebase<o:p></o:p></span>=
</p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hello Mathieu,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Our team was asked to support LTTng UST solution in =
a legacy codebase. The existing codebase is fairly large, and the requireme=
nt is that we provide all the existing logs and debugs in the system as LTT=
ng traces.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The planned solution so far was just to pass everyth=
ing we have as text (strings) to LTTng. For that we obviously have to conve=
rt the printf-like format string and parameter list to a string by calling =
snprintf before giving the string
 to the LTTng API. That would however mean, that these snprintfs are gettin=
g called every time even if there is no listener/active trace session for t=
he given trace. In this case, all those unnecessary snprintf calls may end =
up significantly impacting the performance
 of our applications.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In order to work around this, we were thinking that =
if there was a way to query the LTTng library from our application code whe=
ther there is an active tracing session for the given trace level, we could=
 avoid calling those snprintfs in
 case they are not needed. Do you think it would be feasible to easily get =
this data from LTTng lib? If yes, can you provide us some pointers where to=
 look at in order to do those changes ourselves?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any suggestions are welcome.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">Mate Ferenczy<o:p></o:p></p>
</div>
</body>
</html>

--_000_ECCC3645D4115E4293D3E8C0EB22F09C20D363ESESSMB109ericsso_--


--===============1847152311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1847152311==--
