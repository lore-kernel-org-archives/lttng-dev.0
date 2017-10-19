From: =?iso-8859-1?Q?Arnaud_Cl=E8re?= <arnaud.clere@minmaxmedical.com>
Subject: Using LTTng for existing Qt-based tracepoints?
Date: Thu, 19 Oct 2017 10:00:01 +0000
Message-ID: <AM2PR03MB070508172009C835365F99B49E420__22152.7658206925$1508508933$gmane$org@AM2PR03MB0705.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1213351460487397506=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0060.outbound.protection.outlook.com [104.47.2.60])
 by lists.lttng.org (Postfix) with ESMTPS id 3yJ6HS4b23zrg3
 for <lttng-dev@lists.lttng.org>; Fri, 20 Oct 2017 00:34:12 +0000 (UTC)
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1213351460487397506==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_AM2PR03MB070508172009C835365F99B49E420AM2PR03MB0705eurp_"

--_000_AM2PR03MB070508172009C835365F99B49E420AM2PR03MB0705eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,
I am evaluating the feasibility of using LTTng as a backend for existing Qt=
 tracepoints following the discussions at Qt Contributors Summit : https://=
wiki.qt.io/QtCS2017_Discuss_Qt_Logging_enhancements .
The idea would be to get less performance impact when tracing and more stru=
ctured data to analyse without changing Qt users' code.

I see that instead of describing all tracepoints, we could use a generic LT=
T tracepoint like in Python:
http://git.lttng.org/?p=3Dlttng-ust.git;a=3Dblob;f=3Dliblttng-ust-python-ag=
ent/lttng_ust_python.h

Except, I would like to structure the tracepoint data at run-time following=
 a JSON-based data model.
I think I could encode that part of CTF dynamically by appending binary use=
r data, CTF variants, dynamically-sized CTF structures and sequences in a l=
ocal buffer.

But I am wondering how to pass this buffer along with its size to LTTng.
I am afraid a TP_ARGS(void*, buffer) and TP_FIELDS(buffer) would not work s=
ince it would require LTTng to read the CTF in "buffer" to discover where i=
t stops...

Or should I use some other API?

Thanks for any advice on how to do that.
Arnaud


--_000_AM2PR03MB070508172009C835365F99B49E420AM2PR03MB0705eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"FR" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-GB">Hi all,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB">I am evaluating the feasibility=
 of using LTTng as a backend for existing Qt tracepoints following the disc=
ussions at Qt Contributors Summit :
<a href=3D"https://wiki.qt.io/QtCS2017_Discuss_Qt_Logging_enhancements">htt=
ps://wiki.qt.io/QtCS2017_Discuss_Qt_Logging_enhancements</a> .<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB">The idea would be to get less p=
erformance impact when tracing and more structured data to analyse without =
changing Qt users&#8217; code.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB">I see that instead of describin=
g all tracepoints, we could use a generic LTT tracepoint like in Python:<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><a href=3D"http://git.lttng.org=
/?p=3Dlttng-ust.git;a=3Dblob;f=3Dliblttng-ust-python-agent/lttng_ust_python=
.h">http://git.lttng.org/?p=3Dlttng-ust.git;a=3Dblob;f=3Dliblttng-ust-pytho=
n-agent/lttng_ust_python.h</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB">Except, I would like to structu=
re the tracepoint data at run-time following a JSON-based data model.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB">I think I could encode that par=
t of CTF dynamically by appending binary user data, CTF variants, dynamical=
ly-sized CTF structures and sequences in a local buffer.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB">But I am wondering how to pass =
this buffer along with its size to LTTng.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB">I am afraid a TP_ARGS(void*, bu=
ffer) and TP_FIELDS(buffer) would not work since it would require LTTng to =
read the CTF in &#8220;buffer&#8221; to discover where it stops&#8230;<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB">Or should I use some other API?=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB">Thanks for any advice on how to=
 do that.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span lang=3D"EN-GB" style=3D"mso-fareast-language:FR">Arnaud<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_AM2PR03MB070508172009C835365F99B49E420AM2PR03MB0705eurp_--

--===============1213351460487397506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1213351460487397506==--
