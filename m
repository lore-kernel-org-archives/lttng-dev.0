From: "Sadon, Mirit" <Mirit.Sadon@emc.com>
Subject: clerification on limiting the size of the trace file
Date: Mon, 5 May 2014 08:24:39 +0000
Message-ID: <25901CD29106E944B1047FED2EADF345085832A3__24462.3166895055$1399400332$gmane$org@MX107CL01.corp.emc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1896048202=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailuogwhop.emc.com ([168.159.213.141])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Mirit.Sadon@emc.com>) id 1WhECu-0007py-N2
 for lttng-dev@lists.lttng.org; Mon, 05 May 2014 04:25:06 -0400
Received: from maildlpprd01.lss.emc.com (maildlpprd01.lss.emc.com
 [10.253.24.33])
 by mailuogwprd02.lss.emc.com (Sentrion-MTA-4.3.0/Sentrion-MTA-4.3.0) with
 ESMTP id s458OqIX024744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <lttng-dev@lists.lttng.org>; Mon, 5 May 2014 04:24:53 -0400
Received: from mailusrhubprd51.lss.emc.com (mailusrhubprd51.lss.emc.com
 [10.106.48.24]) by maildlpprd01.lss.emc.com (RSA Interceptor) for
 <lttng-dev@lists.lttng.org>; Mon, 5 May 2014 04:24:41 -0400
Received: from mxhub05.corp.emc.com (mxhub05.corp.emc.com [128.222.70.202])
 by mailusrhubprd51.lss.emc.com (Sentrion-MTA-4.3.0/Sentrion-MTA-4.3.0) with
 ESMTP id s458Odnw025580
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
 for <lttng-dev@lists.lttng.org>; Mon, 5 May 2014 04:24:40 -0400
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
Cc: "Eshel, Ayelet" <Ayelet.Eshel@emc.com>
List-Id: lttng-dev@lists.lttng.org

--===============1896048202==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_25901CD29106E944B1047FED2EADF345085832A3MX107CL01corpem_"

--_000_25901CD29106E944B1047FED2EADF345085832A3MX107CL01corpem_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I Am working with the lttng trace to see how it affects are program perform=
ance,
But if I don't limit the size of the trace file collected it fills all the =
space in the partition I specify.
What does it mean if I start the trace and limit the trace file to let say =
1GB.
Would the trace stop after it reaches the limit or it will continue and ove=
rride the previous collected points?

I tried by using this command when creating the channel but it didn't work.

lttng enable-channel perf --subbuf-size 262144 -C 262144 -W 32 --num-subbuf=
 32 -u"

We are working with lttng version 2.04.

Thanks
Mirit Sadon
EMC2


--_000_25901CD29106E944B1047FED2EADF345085832A3MX107CL01corpem_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Verdana;
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
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
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
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I Am working with the lttng trace to see how it affe=
cts are program performance,<o:p></o:p></p>
<p class=3D"MsoNormal">But if I don&#8217;t limit the size of the trace fil=
e collected it fills all the space in the partition I specify.<o:p></o:p></=
p>
<p class=3D"MsoNormal">What does it mean if I start the trace and limit the=
 trace file to let say 1GB.<o:p></o:p></p>
<p class=3D"MsoNormal">Would the trace stop after it reaches the limit or i=
t will continue and override the previous collected points?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I tried by using this command when creating the chan=
nel but it didn&#8217;t work.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">lttng enable-channel perf --subbuf-size 262144 -C 26=
2144 -W 32 --num-subbuf 32 -u&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are working with lttng version 2.04.<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks<o:p></o:p></p>
<p class=3D"MsoNormal">Mirit Sadon<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Verdana&quot;,&quot=
;sans-serif&quot;">EMC<sup>2</sup><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_25901CD29106E944B1047FED2EADF345085832A3MX107CL01corpem_--


--===============1896048202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1896048202==--
