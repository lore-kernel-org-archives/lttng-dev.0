From: Swati J <Swati.J@nectechnologies.in>
Subject: lttng-ust traces are not generated
Date: Tue, 9 May 2017 09:45:08 +0000
Message-ID: <52CDBD4F986AFC4CAEE1C14068436E7B94531026__14824.2689007477$1494341301$gmane$org@EXCH-MB02-U1.nectechnologies.in>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5838432406640491760=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from scanner.cloudmailstore.com (mx2.cloudmailstore.com
 [103.11.84.249])
 by lists.lttng.org (Postfix) with ESMTPS id 3wMZRH5vMCzkxk
 for <lttng-dev@lists.lttng.org>; Tue,  9 May 2017 09:52:27 +0000 (UTC)
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

--===============5838432406640491760==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_52CDBD4F986AFC4CAEE1C14068436E7B94531026EXCHMB02U1necte_"

--_000_52CDBD4F986AFC4CAEE1C14068436E7B94531026EXCHMB02U1necte_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear All,

I am using lttng tool to generate userspace traces but the userspace traces=
 are not getting generated .
I have used the following commands:

[root@pcmk1 ~]# lttng create
Session auto-20170506-152941 created.
Traces will be written in /root/lttng-traces/auto-20170506-152941
[root@pcmk1 ~]# lttng enable-event --userspace --all                       =
     All UST events are enabled in channel channel0
[root@pcmk1 ~]# lttng start                                                =
     Tracing started for session auto-20170506-152941
[root@pcmk1 ~]# systemctl start pcsd.service
[root@pcmk1 ~]# lttng stop
Waiting for data availability
Tracing stopped for session auto-20170506-152941
[root@pcmk1 ~]# lttng destroy
Session auto-20170506-152941 destroyed


I am not getting any error but also the file is not getting created
I also tried to create userspace traces by logging-in via user rather than =
root but there is no difference .


If anyone has any alternative approach or any suggestion please let me know=
 .


Regards,
Swati J


--_000_52CDBD4F986AFC4CAEE1C14068436E7B94531026EXCHMB02U1necte_
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
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Dear All, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am using lttng tool to generate userspace traces b=
ut the userspace traces are not getting generated .<o:p></o:p></p>
<p class=3D"MsoNormal">I have used the following commands:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[root@pcmk1 ~]# lttng create<o:p></o:p></p>
<p class=3D"MsoNormal">Session auto-20170506-152941 created.<o:p></o:p></p>
<p class=3D"MsoNormal">Traces will be written in /root/lttng-traces/auto-20=
170506-152941<o:p></o:p></p>
<p class=3D"MsoNormal">[root@pcmk1 ~]# lttng enable-event --userspace --all=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; All UST events are enabled in channel channel0<o:p></o:p></p>
<p class=3D"MsoNormal">[root@pcmk1 ~]# lttng start&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tracing star=
ted for session auto-20170506-152941<o:p></o:p></p>
<p class=3D"MsoNormal">[root@pcmk1 ~]# systemctl start pcsd.service<o:p></o=
:p></p>
<p class=3D"MsoNormal">[root@pcmk1 ~]# lttng stop<o:p></o:p></p>
<p class=3D"MsoNormal">Waiting for data availability<o:p></o:p></p>
<p class=3D"MsoNormal">Tracing stopped for session auto-20170506-152941<o:p=
></o:p></p>
<p class=3D"MsoNormal">[root@pcmk1 ~]# lttng destroy<o:p></o:p></p>
<p class=3D"MsoNormal">Session auto-20170506-152941 destroyed<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am not getting any error but also the file is not =
getting created
<o:p></o:p></p>
<p class=3D"MsoNormal">I also tried to create userspace traces by logging-i=
n via <b>
user</b> rather than root but there is no difference .<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If anyone has any alternative approach or any sugges=
tion please let me know .<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Swati J <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_52CDBD4F986AFC4CAEE1C14068436E7B94531026EXCHMB02U1necte_--

--===============5838432406640491760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5838432406640491760==--
