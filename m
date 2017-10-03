From: Andreas Indlekofer <andreas.indlekofer@ch.abb.com>
Subject: LTTNG question (Threads spawned by LTTNG)
Date: Tue, 3 Oct 2017 08:33:13 +0000
Message-ID: <VI1PR0601MB273405C7EE1426D9B726FBFBAE720__9412.27975204146$1507128680$gmane$org@VI1PR0601MB2734.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6961250837587737358=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0078.outbound.protection.outlook.com [104.47.2.78])
 by lists.lttng.org (Postfix) with ESMTPS id 3y6QV12c2Zz108h
 for <lttng-dev@lists.lttng.org>; Wed,  4 Oct 2017 06:09:44 +0000 (UTC)
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

--===============6961250837587737358==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_VI1PR0601MB273405C7EE1426D9B726FBFBAE720VI1PR0601MB2734_"

--_000_VI1PR0601MB273405C7EE1426D9B726FBFBAE720VI1PR0601MB2734_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

Our application consists of several services running in their own Linux pro=
cess. Now we see that every process contains two threads with the same name=
 as the parent process and the ending '-ust'. We are wondering why we have =
these threads, what is the purpose of the threads and did they influence th=
e runtime behavior in case we do no tracing.
Additionally we see atleast ten lttng-sessiond threads. Also here we have t=
he question, why we have ten threads, what is the purpose and do they influ=
ence the runtime behavior, if we have no tracing active.

Best regards,
Andreas

--_000_VI1PR0601MB273405C7EE1426D9B726FBFBAE720VI1PR0601MB2734_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
	font-family:"Calibri",sans-serif;}
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
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Our application consists of several services running=
 in their own Linux process. Now we see that every process contains two thr=
eads with the same name as the parent process and the ending &#8216;-ust&#8=
217;. We are wondering why we have these threads,
 what is the purpose of the threads and did they influence the runtime beha=
vior in case we do no tracing.<o:p></o:p></p>
<p class=3D"MsoNormal">Additionally we see atleast ten lttng-sessiond threa=
ds. Also here we have the question, why we have ten threads, what is the pu=
rpose and do they influence the runtime behavior, if we have no tracing act=
ive.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Andreas<o:p></o:p></p>
</div>
</body>
</html>

--_000_VI1PR0601MB273405C7EE1426D9B726FBFBAE720VI1PR0601MB2734_--

--===============6961250837587737358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6961250837587737358==--
