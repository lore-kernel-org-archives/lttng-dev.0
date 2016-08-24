From: David Aldrich <David.Aldrich@EMEA.NEC.COM>
Subject: Beginner question: how to inspect scheduling of
 multi-threaded user application?
Date: Wed, 24 Aug 2016 07:17:36 +0000
Message-ID: <35de22c3d2034f3abb75596477b23e3a__34597.1093084247$1472023069$gmane$org@EUX13SRV1.EU.NEC.COM>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7667735324554107531=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
 [85.115.52.190])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 681C6A3AFC
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2016 07:17:54 +0000 (UTC)
Received: from mail1.neceur.com (mail1.neceur.com [195.47.207.3])
 by rly27a.srv.mailcontrol.com (MailControl) with ESMTP id u7O7HbhI004119
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2016 08:17:37 +0100
Received: from intmail1.neceur.com (intmail1.neceur.com [172.29.14.11])
 by mail1.neceur.com (8.14.4/8.14.4) with ESMTP id u7O7Hbce010412
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2016 08:17:37 +0100
Received: from av1.neceur.com (av1.neceur.com [172.29.14.21])
 by intmail1.neceur.com (8.13.8/8.13.8) with ESMTP id u7O7Ha0O031482
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2016 08:17:36 +0100
Received: from av1.neceur.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D53FC18045
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2016 08:17:36 +0100 (BST)
Received: from av1.neceur.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B62C01803F
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2016 08:17:36 +0100 (BST)
Received: from EUX13SRV1.EU.NEC.COM (unknown [172.29.155.138])
 by av1.neceur.com (Postfix) with ESMTPS
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2016 08:17:36 +0100 (BST)
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

--===============7667735324554107531==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_35de22c3d2034f3abb75596477b23e3aEUX13SRV1EUNECCOM_"

--_000_35de22c3d2034f3abb75596477b23e3aEUX13SRV1EUNECCOM_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi

I am new to tracing in Linux and to lttng. I have a multi-threaded user app=
lication and I want to see:


1)      When the threads are scheduled to run

2)      Which cores the threads are running on.

I have installed lttng on Ubuntu 14.04 LTS.  I am expecting to visualise th=
e trace using TraceCompass.

I have read the following doc section:

http://lttng.org/docs/#doc-tracing-your-own-user-application

In order to collect my trace, must I define custom tracepoint definitions (=
 in a tracepoint provider header file ), and insert tracepoints into my use=
r application, or is there a simpler way of achieving my goal?

Best regards

David


--_000_35de22c3d2034f3abb75596477b23e3aEUX13SRV1EUNECCOM_
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.apple-converted-space
	{mso-style-name:apple-converted-space;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:151026364;
	mso-list-type:hybrid;
	mso-list-template-ids:507957602 134807569 134807577 134807579 134807567 13=
4807577 134807579 134807567 134807577 134807579;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am new to tracing in Linux and to lttng. I have a =
multi-threaded user application and I want to see:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo2"><![if !supportLists]><span style=3D"mso-list:Ignore">1)<span style=
=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>When the threads are scheduled to run<o:p></o:p></p=
>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo2"><![if !supportLists]><span style=3D"mso-list:Ignore">2)<span style=
=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>Which cores the threads are running on.<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have installed lttng on Ubuntu 14.04 LTS.&nbsp; I =
am expecting to visualise the trace using TraceCompass.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have read the following doc section:<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><a href=3D"http://lttng.org/docs/#doc-tracing-your-o=
wn-user-application">http://lttng.org/docs/#doc-tracing-your-own-user-appli=
cation</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In order to collect my trace, must I define custom t=
racepoint definitions (<span class=3D"apple-converted-space"><span style=3D=
"color:#1A1A1A;background:#FDFDFD">&nbsp;in a
</span></span><span style=3D"color:#1A1A1A;background:#FDFDFD">tracepoint p=
rovider<span class=3D"apple-converted-space">&nbsp;header file ), and inser=
t tracepoints into my user application, or is there a simpler way of achiev=
ing my goal?</span></span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-GB">Best rega=
rds<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-GB"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-GB">David<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_35de22c3d2034f3abb75596477b23e3aEUX13SRV1EUNECCOM_--


--===============7667735324554107531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7667735324554107531==--
