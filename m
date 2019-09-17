From: "Polzer, Franz" <Franz_Polzer@mentor.com>
Subject: Test pid_ns in local build
Date: Tue, 17 Sep 2019 08:03:20 +0000
Message-ID: <5a49b436d1cd4659b96dfcaffe63b38e__19202.3885015928$1568707434$gmane$org@SVR-IES-MBX-04.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4855372602993205664=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by lists.lttng.org (Postfix) with ESMTPS id 46XbGK3x7Kzpf2
 for <lttng-dev@lists.lttng.org>; Tue, 17 Sep 2019 04:03:37 -0400 (EDT)
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

--===============4855372602993205664==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_5a49b436d1cd4659b96dfcaffe63b38eSVRIESMBX04mgcmentorgco_"

--_000_5a49b436d1cd4659b96dfcaffe63b38eSVRIESMBX04mgcmentorgco_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I wanted to give the pid_ns context tracing a try and built LTTng from mast=
er, but I get the following error when applying this command:

lttng add-context -k -t procname -t pid -t vpid -t tid -t vtid -t pid_ns

Error: Unknown context type pid_ns

Maybe I need another branch to build from to get that feature in or forgot =
to enable the feature during building?

Where can I find documentation about the pid_ns tracing and how to test the=
 current version of that implementation?

Thanks for your help and best regards,
Franz

--_000_5a49b436d1cd4659b96dfcaffe63b38eSVRIESMBX04mgcmentorgco_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:m=3D"http://schema=
s.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html=
40">
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
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
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
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
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
<p class=3D"MsoNormal">I wanted to give the pid_ns context tracing a try an=
d built LTTng from master, but I get the following error when applying this=
 command:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span lang=3D"DE-AT" s=
tyle=3D"font-family:Consolas">lttng add-context -k -t procname -t pid -t vp=
id -t tid -t vtid -t pid_ns<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span lang=3D"DE-AT" s=
tyle=3D"font-family:Consolas"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:Consolas">Error: Unknown context type pid_ns<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Maybe I need another branch to build from to get tha=
t feature in or forgot to enable the feature during building?<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Where can I find documentation about the pid_ns trac=
ing and how to test the current version of that implementation?<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks for your help and best regards,<o:p></o:p></p=
>
<p class=3D"MsoNormal">Franz<o:p></o:p></p>
</div>
</body>
</html>

--_000_5a49b436d1cd4659b96dfcaffe63b38eSVRIESMBX04mgcmentorgco_--

--===============4855372602993205664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4855372602993205664==--
