From: Brian Robbins <brianrob@microsoft.com>
Subject: Ubuntu Package for LTTng-UST Compiled with Debug
 Logging On By Default
Date: Thu, 22 Oct 2015 23:35:04 +0000
Message-ID: <SN1PR0301MB15981E02890EE7EBB67F42A2C8270__8249.31620522893$1445556994$gmane$org@SN1PR0301MB1598.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1011951284=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-bn1on0133.outbound.protection.outlook.com
 ([157.56.110.133] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <brianrob@microsoft.com>) id 1ZpPOB-0006iJ-4G
 for lttng-dev@lists.lttng.org; Thu, 22 Oct 2015 19:35:21 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1011951284==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR0301MB15981E02890EE7EBB67F42A2C8270SN1PR0301MB1598_"

--_000_SN1PR0301MB15981E02890EE7EBB67F42A2C8270SN1PR0301MB1598_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

The Linux build of CoreCLR now supports tracing using LTTng-UST.  One artif=
act that we noticed when running on Ubuntu 14.04 in our CI is that apps run=
ning on CoreCLR all have an LTTng warning written to stderr:

libust[883/883]: Warning: HOME environment variable not set. Disabling LTTn=
g-UST per-user tracing. (in setup_local_apps() at lttng-ust-comm.c:305)

I've investigated, and it is true that in the CI, there is no HOME environm=
ent variable.  However, what I'm more interested in is why this message is =
written in the first place.  Looking in at the latest LTTng-UST code, it ap=
pears that this message should only be logged when debug logging is enabled=
.  From code inspection, it appears that debug logging can be enabled at ei=
ther compile time (#define LTTNG_UST_DEBUG) or at runtime via an environmen=
t variable called LTTNG_UST_DEBUG.

I have confirmed that the environment variable LTTNG_UST_DEBUG is not prese=
nt.  I've also looked at the disassembly, and can confirm that the ust_logl=
evel check is not actually performed (the if statement is optimized away). =
 This makes me think that the Ubuntu package was compiled with LTTNG_UST_DE=
BUG defined.

The package in question is old - LTTng-UST 2.4.  I'm wondering if either de=
bug logging was always present in 2.4, or if the package was compiled with =
LTTNG_UST_DEBUG.  I would expect that most customers would want debug loggi=
ng off by default, since it affects the output of the program.

Your help in figuring this out is greatly appreciated.

Thank you.
-Brian

--_000_SN1PR0301MB15981E02890EE7EBB67F42A2C8270SN1PR0301MB1598_
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
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
.MsoChpDefault
	{mso-style-type:export-only;}
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
<p class=3D"MsoNormal">The Linux build of CoreCLR now supports tracing usin=
g LTTng-UST. &nbsp;One artifact that we noticed when running on Ubuntu 14.0=
4 in our CI is that apps running on CoreCLR all have an LTTng warning writt=
en to stderr:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:#333333">libust[883/883]: Warning: HOME environment v=
ariable not set. Disabling LTTng-UST per-user tracing. (in setup_local_apps=
() at lttng-ust-comm.c:305)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;ve investigated, and it is true that in the =
CI, there is no HOME environment variable.&nbsp; However, what I&#8217;m mo=
re interested in is why this message is written in the first place.&nbsp; L=
ooking in at the latest LTTng-UST code, it appears that
 this message should only be logged when debug logging is enabled.&nbsp; Fr=
om code inspection, it appears that debug logging can be enabled at either =
compile time (#define LTTNG_UST_DEBUG) or at runtime via an environment var=
iable called LTTNG_UST_DEBUG.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have confirmed that the environment variable LTTNG=
_UST_DEBUG is not present.&nbsp; I&#8217;ve also looked at the disassembly,=
 and can confirm that the ust_loglevel check is not actually performed (the=
 if statement is optimized away).&nbsp;
<b>This makes me think that the Ubuntu package was compiled with LTTNG_UST_=
DEBUG defined.</b><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b>The package in question is old &#8211; LTTng-UST =
2.4.&nbsp; I&#8217;m wondering if either debug logging was always present i=
n 2.4, or if the package was compiled with LTTNG_UST_DEBUG</b>.&nbsp; I wou=
ld expect that most customers would want debug logging off
 by default, since it affects the output of the program.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Your help in figuring this out is greatly appreciate=
d.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you.<o:p></o:p></p>
<p class=3D"MsoNormal">-Brian<o:p></o:p></p>
</div>
</body>
</html>

--_000_SN1PR0301MB15981E02890EE7EBB67F42A2C8270SN1PR0301MB1598_--


--===============1011951284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1011951284==--
