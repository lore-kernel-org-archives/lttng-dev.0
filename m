From: "Ostermueller, Erik" <Erik.Ostermueller@fisglobal.com>
Subject: tracing of non-JNI java in IBM jvm
Date: Thu, 10 Jan 2013 22:52:26 +0000
Message-ID: <A94B468263DDE2448A14367F590EB97301D10803__21852.2763615058$1357858404$gmane$org@ltcfiswmsgmb15>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1030969648=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.fisglobal.com ([199.200.24.190])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Erik.Ostermueller@fisglobal.com>) id 1TtQzE-0000Wd-4l
	for lttng-dev@lists.lttng.org; Thu, 10 Jan 2013 17:52:36 -0500
Received: from smtp.fisglobal.com ([10.132.206.16])
	by ltcfislmsgpa04.fnfis.com (8.14.5/8.14.5) with ESMTP id
	r0AMqRKt017051
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Thu, 10 Jan 2013 16:52:27 -0600
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1030969648==
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_005_A94B468263DDE2448A14367F590EB97301D10803ltcfiswmsgmb15_";
	type="multipart/alternative"

--_005_A94B468263DDE2448A14367F590EB97301D10803ltcfiswmsgmb15_
Content-Type: multipart/alternative;
	boundary="_000_A94B468263DDE2448A14367F590EB97301D10803ltcfiswmsgmb15_"

--_000_A94B468263DDE2448A14367F590EB97301D10803ltcfiswmsgmb15_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

Would like to use LTTng to trace some pure, non-JNI java method calls.
Seems like I need to

*         install 2.1.0-rc2

*         install the TMF/Eclipse LTTng plugin

*         how do I indicate which classes/methods to be traced?

I started with the "User-space" tracing section this doc:  https://bugs.ltt=
ng.org/projects/lttng-tools/wiki
...but then I stop understanding things when I read "So, after instrumentin=
g you applications with LTTng-ust 2.0".
That was followed by a link to http://lttng.org/lttng2.0, but that didn't h=
elp.

Would love to be an alpha/beta tester if this isn't ready yet.

Thanks a lot,
--Erik

###   some info about my environment:  ####################################


=3D>uname -a
Linux vlxesngperf01.atldev.com 2.6.18-238.5.1.el5 #1 SMP Mon Feb 21 05:52:3=
9 EST 2011 x86_64 x86_64 x86_64 GNU/Linux

=3D>cat /etc/issue
Red Hat Enterprise Linux Server release 5.6 (Tikanga)
Kernel \r on an \m


tp@vlxesngperf01 /usr/tp/app/tp/nmon/bin$=3D>java -version
java version "1.6.0"
Java(TM) SE Runtime Environment (build pxa6460sr9fp2ifix-20111111_05(SR9 FP=
2+IV03622+IV02378+IZ99243+IZ97310+IV00707))
IBM J9 VM (build 2.4, JRE 1.6.0 IBM J9 2.4 Linux amd64-64 jvmxa6460sr9-2011=
1111_94827 (JIT enabled, AOT enabled)
J9VM - 20111111_094827
JIT  - r9_20101028_17488ifx45
GC   - 20101027_AA)
JCL  - 20110727_04


________________________________
Erik Ostermueller
Xpress Architecture

T: 501.220.7753
C:501.213.8309
erik.ostermueller@fisglobal.com<mailto:erik.ostermueller@fisglobal.com>
[Description: Description: Description: Description: cid:image001.png@01CD8=
AB3.84921E40]
[Description: Description: Description: Description: cid:image003.png@01CD8=
AB3.84921E40]

_____________
The information contained in this message is proprietary and/or confidentia=
l. If you are not the intended recipient, please: (i) delete the message an=
d all copies; (ii) do not disclose, distribute or use the message in any ma=
nner; and (iii) notify the sender immediately. In addition, please be aware=
 that any message addressed to our domain is subject to archiving and revie=
w by persons other than the intended recipient. Thank you.

--_000_A94B468263DDE2448A14367F590EB97301D10803ltcfiswmsgmb15_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:710229015;
	mso-list-type:hybrid;
	mso-list-template-ids:1548414798 -471973670 67698691 67698693 67698689 676=
98691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;
	mso-fareast-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Would like to use LTTng to trace some pure, non-JNI =
java method calls.<o:p></o:p></p>
<p class=3D"MsoNormal">Seems like I need to <o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo1"><![if !supportLists]><span style=3D"font-family:Symbol"><span style=
=3D"mso-list:Ignore">&middot;<span style=3D"font:7.0pt &quot;Times New Roma=
n&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>install 2.1.0-rc2<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo1"><![if !supportLists]><span style=3D"font-family:Symbol"><span style=
=3D"mso-list:Ignore">&middot;<span style=3D"font:7.0pt &quot;Times New Roma=
n&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>install the TMF/Eclipse LTTng plugin<o:p></o=
:p></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo1"><![if !supportLists]><span style=3D"font-family:Symbol"><span style=
=3D"mso-list:Ignore">&middot;<span style=3D"font:7.0pt &quot;Times New Roma=
n&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>how do I indicate which classes/methods to b=
e traced?&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I started with the &#8220;User-space&#8221; tracing =
section this doc:&nbsp; <a href=3D"https://bugs.lttng.org/projects/lttng-to=
ols/wiki">
https://bugs.lttng.org/projects/lttng-tools/wiki</a><o:p></o:p></p>
<p class=3D"MsoNormal">&#8230;but then I stop understanding things when I r=
ead &#8220;<span style=3D"font-size:9.0pt;font-family:&quot;Verdana&quot;,&=
quot;sans-serif&quot;;color:#484848;background:white">So, after instrumenti=
ng you applications with LTTng-ust 2.0</span>&#8221;.<o:p></o:p></p>
<p class=3D"MsoNormal">That was followed by a link to <a href=3D"http://ltt=
ng.org/lttng2.0">
http://lttng.org/lttng2.0</a>, but that didn&#8217;t help.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Would love to be an alpha/beta tester if this isn&#8=
217;t ready yet.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks a lot, <o:p></o:p></p>
<p class=3D"MsoNormal">--Erik<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">###&nbsp;&nbsp; some info about my environment:&nbsp=
; ####################################<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">=3D&gt;uname -a<o:p></o:p></p>
<p class=3D"MsoNormal">Linux vlxesngperf01.atldev.com 2.6.18-238.5.1.el5 #1=
 SMP Mon Feb 21 05:52:39 EST 2011 x86_64 x86_64 x86_64 GNU/Linux<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">=3D&gt;cat /etc/issue<o:p></o:p></p>
<p class=3D"MsoNormal">Red Hat Enterprise Linux Server release 5.6 (Tikanga=
)<o:p></o:p></p>
<p class=3D"MsoNormal">Kernel \r on an \m<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">tp@vlxesngperf01 /usr/tp/app/tp/nmon/bin$=3D&gt;java=
 -version<o:p></o:p></p>
<p class=3D"MsoNormal">java version &quot;1.6.0&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">Java(TM) SE Runtime Environment (build pxa6460sr9fp2=
ifix-20111111_05(SR9 FP2&#43;IV03622&#43;IV02378&#43;IZ99243&#43;IZ97310&#4=
3;IV00707))<o:p></o:p></p>
<p class=3D"MsoNormal">IBM J9 VM (build 2.4, JRE 1.6.0 IBM J9 2.4 Linux amd=
64-64 jvmxa6460sr9-20111111_94827 (JIT enabled, AOT enabled)<o:p></o:p></p>
<p class=3D"MsoNormal">J9VM - 20111111_094827<o:p></o:p></p>
<p class=3D"MsoNormal">JIT&nbsp; - r9_20101028_17488ifx45<o:p></o:p></p>
<p class=3D"MsoNormal">GC&nbsp;&nbsp; - 20101027_AA)<o:p></o:p></p>
<p class=3D"MsoNormal">JCL&nbsp; - 20110727_04<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;text-a=
utospace:none">
<b><span style=3D"font-size:10.0pt">
<hr size=3D"2" width=3D"100%" align=3D"center">
</span></b></div>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><b><span style=3D"font=
-size:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">Erik Oste=
rmueller</span></b><b><span style=3D"font-size:10.0pt"><br>
</span></b><span style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,&qu=
ot;sans-serif&quot;">Xpress Architecture<br>
<br>
T: 501.220.7753<br>
C:501.213.8309<br>
<a href=3D"mailto:erik.ostermueller@fisglobal.com"><span style=3D"color:blu=
e">erik.ostermueller@fisglobal.com</span></a></span><span style=3D"font-siz=
e:10.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><img border=3D"0" w=
idth=3D"90" height=3D"37" id=3D"Picture_x0020_2" src=3D"cid:image001.png@01=
CDEF50.D3D44B20" alt=3D"Description: Description: Description: Description:=
 cid:image001.png@01CD8AB3.84921E40"></span><span style=3D"font-size:16.0pt=
">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
<img border=3D"0" width=3D"124" height=3D"34" id=3D"Picture_x0020_1" src=3D=
"cid:image002.png@01CDEF50.D3D44B20" alt=3D"Description: Description: Descr=
iption: Description: cid:image003.png@01CD8AB3.84921E40"><o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>

<DIV>
_____________<BR>
The information contained in this message is proprietary and/or confidentia=
l. If you are not the intended recipient, please: (i) delete the message an=
d all copies; (ii) do not disclose, distribute or use the message in any ma=
nner; and (iii) notify the sender immediately. In addition, please be aware=
 that any message addressed to our domain is subject to archiving and revie=
w by persons other than the intended recipient. Thank you.<BR>
</DIV></body>
</html>

--_000_A94B468263DDE2448A14367F590EB97301D10803ltcfiswmsgmb15_--

--_005_A94B468263DDE2448A14367F590EB97301D10803ltcfiswmsgmb15_
Content-Type: image/png; name="image001.png"
Content-Description: image001.png
Content-Disposition: inline; filename="image001.png"; size=2842;
	creation-date="Thu, 10 Jan 2013 22:52:26 GMT";
	modification-date="Thu, 10 Jan 2013 22:52:26 GMT"
Content-ID: <image001.png@01CDEF50.D3D44B20>
Content-Transfer-Encoding: base64

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

--_005_A94B468263DDE2448A14367F590EB97301D10803ltcfiswmsgmb15_
Content-Type: image/png; name="image002.png"
Content-Description: image002.png
Content-Disposition: inline; filename="image002.png"; size=5509;
	creation-date="Thu, 10 Jan 2013 22:52:26 GMT";
	modification-date="Thu, 10 Jan 2013 22:52:26 GMT"
Content-ID: <image002.png@01CDEF50.D3D44B20>
Content-Transfer-Encoding: base64

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

--_005_A94B468263DDE2448A14367F590EB97301D10803ltcfiswmsgmb15_--


--===============1030969648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1030969648==--
