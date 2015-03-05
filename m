From: Brian Robbins <brianrob@microsoft.com>
Subject: Userspace Tracing and Backtraces
Date: Thu, 5 Mar 2015 22:39:16 +0000
Message-ID: <BY2SR01MB595A5A400E2211CC7567298C81F0__22980.6870375343$1425596171$gmane$org@BY2SR01MB595.namsdf01.sdf.exchangelabs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0911967201=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from na01-sn2-obe.ptr.o365filtering.com ([157.55.158.29]
 helo=na01-sn2-obe.outbound.o365filtering.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <brianrob@microsoft.com>) id 1YTeQU-0005zL-Oq
 for lttng-dev@lists.lttng.org; Thu, 05 Mar 2015 17:39:34 -0500
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0911967201==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY2SR01MB595A5A400E2211CC7567298C81F0BY2SR01MB595namsdf_"

--_000_BY2SR01MB595A5A400E2211CC7567298C81F0BY2SR01MB595namsdf_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm looking into using the userspace tracing capabilities of LTTng, and I w=
anted to find out if it is possible to capture a stack backtrace when a use=
rspace tracepoint is hit.

I've done a bunch of searching, but have not yet been able to find the answ=
er.

Thank you.
-Brian

--_000_BY2SR01MB595A5A400E2211CC7567298C81F0BY2SR01MB595namsdf_
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
	{margin:0in;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m looking into using the userspace tracing c=
apabilities of LTTng, and I wanted to find out if it is possible to capture=
 a stack backtrace when a userspace tracepoint is hit.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;ve done a bunch of searching, but have not y=
et been able to find the answer.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you.<o:p></o:p></p>
<p class=3D"MsoNormal">-Brian<o:p></o:p></p>
</div>
</body>
</html>

--_000_BY2SR01MB595A5A400E2211CC7567298C81F0BY2SR01MB595namsdf_--


--===============0911967201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0911967201==--
