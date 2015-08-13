From: Brian Robbins <brianrob@microsoft.com>
Subject: Instrumenting a Shared Object
Date: Thu, 13 Aug 2015 23:40:03 +0000
Message-ID: <SN1PR0301MB159862AA83F63780E73A8CFAC87D0__7647.36326314068$1439509285$gmane$org@SN1PR0301MB1598.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2087146477=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-by2on0136.outbound.protection.outlook.com
 ([207.46.100.136] helo=na01-by2-obe.outbound.protection.outlook.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <brianrob@microsoft.com>) id 1ZQ26d-0007ik-ST
 for lttng-dev@lists.lttng.org; Thu, 13 Aug 2015 19:40:22 -0400
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
Cc: Rama Krishnan Raghupathy <ramarag@microsoft.com>
List-Id: lttng-dev@lists.lttng.org

--===============2087146477==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR0301MB159862AA83F63780E73A8CFAC87D0SN1PR0301MB1598_"

--_000_SN1PR0301MB159862AA83F63780E73A8CFAC87D0SN1PR0301MB1598_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm looking to instrument a shared object using LTTng-UST tracepoints.  The=
 expectation is that users of the library will use dlopen to open it at the=
 beginning of their application and dlclose right before process exit.  Fro=
m what I've read at http://lttng.org/docs/#doc-building-tracepoint-provider=
s-and-user-application, it sounds like there is some complexity with this a=
s the tracepoint definition must remain in memory, but I want to make sure =
I fully understand.

If I want to instrument a shared object, is my only option to dynamically l=
ink and use LD_PRELOAD?  Also, do my options change if I know that the proc=
ess will exit right after it calls dlclose on the library?

Thank you very much.
-Brian



--_000_SN1PR0301MB159862AA83F63780E73A8CFAC87D0SN1PR0301MB1598_
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
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
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
<p class=3D"MsoNormal">I&#8217;m looking to instrument a shared object usin=
g LTTng-UST tracepoints.&nbsp; The expectation is that users of the library=
 will use dlopen to open it at the beginning of their application and dlclo=
se right before process exit.&nbsp; From what I&#8217;ve
 read at <span style=3D"font-size:10.0pt;font-family:&quot;Segoe UI&quot;,s=
ans-serif;color:black">
http://lttng.org/docs/#doc-building-tracepoint-providers-and-user-applicati=
on</span>, it sounds like there is some complexity with this as the tracepo=
int definition must remain in memory, but I want to make sure I fully under=
stand.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If I want to instrument a shared object, is my only =
option to dynamically link and use LD_PRELOAD?&nbsp; Also, do my options ch=
ange if I know that the process will exit right after it calls dlclose on t=
he library?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you very much.<o:p></o:p></p>
<p class=3D"MsoNormal">-Brian<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_SN1PR0301MB159862AA83F63780E73A8CFAC87D0SN1PR0301MB1598_--


--===============2087146477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2087146477==--
