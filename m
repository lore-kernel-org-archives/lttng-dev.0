Return-Path: <SRS0=9v83=E2=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2637C56201
	for <lttng-dev@archiver.kernel.org>; Fri, 20 Nov 2020 18:32:29 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6528724171
	for <lttng-dev@archiver.kernel.org>; Fri, 20 Nov 2020 18:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="CdyIAW7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6528724171
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Cd4sQ2GQjz1LZY;
	Fri, 20 Nov 2020 13:32:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1605897146;
	bh=GfhNo4aMfMeOzlN1AT9LWgvBAHa8dGkDyvg5GTcwqDc=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=CdyIAW7AQX3v//F2ZyFp/Ze488zd/79/469Mnc44mdkZHwRRyb7pe/iYMpTONrfAT
	 RHX7pcQInr409Ag8QSBvspfaSM0EfT+KN9AtkWRt8vYVYc6eXe4vLwoFvvbAu/arDp
	 nkQpQIV8i/4iONPfSo4sjH7kreJKB0STmLl5tXxcCwppl4sKcPI6DVRsG58cnLbC2p
	 B60UsYxq/qc11CyCusbZU/C63aI5j/+XzAgLeFSIIsGdmPcnH+JO/N79P/X1/Hr12n
	 Dgt7o7iSy28FD1+98ufH9TVz4q+RFRQ3oh+0h7VNxXRtpZR4B5PABFPf/H/p8z1A6J
	 ujXmto6S9iO+g==
Received: from mx0a-0014fe01.pphosted.com (mx0b-0014fe01.pphosted.com
 [208.86.201.212])
 by lists.lttng.org (Postfix) with ESMTPS id 4Cd47J0rlcz1LLY
 for <lttng-dev@lists.lttng.org>; Fri, 20 Nov 2020 12:59:23 -0500 (EST)
Received: from pps.filterd (m0000621.ppops.net [127.0.0.1])
 by mx0b-0014fe01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AKHdXFO003901
 for <lttng-dev@lists.lttng.org>; Fri, 20 Nov 2020 10:43:01 -0700
Received: from mail.ballaerospace.com ([162.18.172.11])
 by mx0b-0014fe01.pphosted.com with ESMTP id 34tejyy83t-2
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Fri, 20 Nov 2020 10:43:01 -0700
Received: from ex2016-co-04.AERO.BALL.COM (10.72.9.137) by
 ex2016-co-02.AERO.BALL.com (10.72.9.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.1466.3; Fri, 20 Nov 2020 10:43:00 -0700
Received: from ex2016-co-03.AERO.BALL.COM (10.72.9.80) by
 ex2016-co-04.AERO.BALL.com (10.72.9.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.1466.3; Fri, 20 Nov 2020 10:43:00 -0700
Received: from ex2016-co-03.AERO.BALL.COM ([fe80::a55a:f7d9:c791:da55]) by
 ex2016-co-03.AERO.BALL.com ([fe80::a55a:f7d9:c791:da55%12]) with mapi id
 15.01.1466.003; Fri, 20 Nov 2020 10:43:00 -0700
To: "'lttng-dev@lists.lttng.org'" <lttng-dev@lists.lttng.org>
Thread-Topic: lttng 2.12 install
Thread-Index: Ada/Y4SGFTZ5vBbyTkeGMcaNOjy/7A==
Date: Fri, 20 Nov 2020 17:43:00 +0000
Message-ID: <326539938460471c975e791ce6b1c775@ball.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.72.63.11]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-20_09:2020-11-20,
 2020-11-20 signatures=0
X-Mailman-Approved-At: Fri, 20 Nov 2020 13:32:24 -0500
Subject: [lttng-dev] lttng 2.12 install
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "Weber, John via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Weber, John" <jweber1@ball.com>
Content-Type: multipart/mixed; boundary="===============1716287665033624150=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1716287665033624150==
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_005_326539938460471c975e791ce6b1c775ballcom_";
	type="multipart/alternative"

--_005_326539938460471c975e791ce6b1c775ballcom_
Content-Type: multipart/alternative;
	boundary="_000_326539938460471c975e791ce6b1c775ballcom_"

--_000_326539938460471c975e791ce6b1c775ballcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, I have a centos 7.8 workstation that I'm trying to install lttng-module=
s & lttng-tools from source. Based on your install instructions I'm working=
 on installing the modules part first and its failing. I am getting the err=
or:
Make entering directory /usr/src/kernels/3.10.0-1127.19.1.el7.x86_64
Arch/x86/Makefile:166 *** CONFIG_RETPOLINE=3Dy, but not supported by the co=
mpiler. Compiler update recommended... stop
Make: modules error 2

Help, how can I get this program to install? Im stuck. Also, my work enviro=
nment is classified so there is no access to internet from high side.

----------------------------
John Weber
Ball Aerospace
ITS ND System Administrator
10 Longs Peak Dr., Broomfield, CO 80021
C: 303-807-3608   P: 303-234-2103
E: jweber1@ball.com


[cid:image001.jpg@01D6BF29.AD6C5250]


[cid:image002.jpg@01D6BF29.AD6C5250]<http://www.ball.com/aerospace>

This message and any enclosures are intended only for the addressee.  Pleas=
e=20
notify the sender by email if you are not the intended recipient.  If you a=
re=20
not the intended recipient, you may not use, copy, disclose, or distribute =
this=20
message or its contents or enclosures to any other person and any such acti=
ons=20
may be unlawful.  Ball reserves the right to monitor and review all message=
s=20
and enclosures sent to or from this email address.

--_000_326539938460471c975e791ce6b1c775ballcom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Comic Sans MS";
	panose-1:3 15 7 2 3 3 2 2 2 4;}
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
<p class=3D"MsoNormal">Hi, I have a centos 7.8 workstation that I&#8217;m t=
rying to install lttng-modules &amp; lttng-tools from source. Based on your=
 install instructions I&#8217;m working on installing the modules part firs=
t and its failing. I am getting the error:
<o:p></o:p></p>
<p class=3D"MsoNormal">Make entering directory /usr/src/kernels/3.10.0-1127=
.19.1.el7.x86_64<o:p></o:p></p>
<p class=3D"MsoNormal">Arch/x86/Makefile:166 *** CONFIG_RETPOLINE=3Dy, but =
not supported by the compiler. Compiler update recommended&#8230; stop<o:p>=
</o:p></p>
<p class=3D"MsoNormal">Make: modules error 2<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Help, how can I get this program to install? Im stuc=
k. Also, my work environment is classified so there is no access to interne=
t from high side.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Comic Sans MS&qu=
ot;">----------------------------<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Comic Sans MS&qu=
ot;">John Weber<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0D707F">Ball Aerospace</span></b><span style=3D"color:black">=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">ITS ND Syst=
em Administrator
</span><span style=3D"font-size:12.0pt;font-family:&quot;Times New Roman&qu=
ot;,serif;color:black"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">10 Longs Peak Dr., Broomfield, CO 80021</=
span><span style=3D"color:black"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">C: 303-807-3608&nbsp;&=
nbsp; P: 303-234-2103<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">E: jweber1@ball.com<u>=
<span style=3D"color:blue"><o:p></o:p></span></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Tim=
es New Roman&quot;,serif;color:#215968">&nbsp;</span><span style=3D"color:b=
lack"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif;color:black">&nbsp;</span><span style=3D"color:black"><=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><img width=3D"53" height=
=3D"53" style=3D"width:.552in;height:.552in" id=3D"Picture_x0020_1" src=3D"=
cid:image001.jpg@01D6BF29.AD6C5250"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;color:black">&nbsp;<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;color:black"><o:p>&nb=
sp;</o:p></span></p>
<p class=3D"MsoNormal"><a href=3D"http://www.ball.com/aerospace"><span styl=
e=3D"font-size:8.0pt;color:black;text-decoration:none"><img border=3D"0" wi=
dth=3D"261" height=3D"33" style=3D"width:2.7187in;height:.3437in" id=3D"Pic=
ture_x0020_2" src=3D"cid:image002.jpg@01D6BF29.AD6C5250"></span></a><span s=
tyle=3D"font-size:8.0pt;color:black">&nbsp;</span><span style=3D"color:blac=
k"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>

<DIV>
This message and any enclosures are intended only for the addressee.  Pleas=
e <BR>
notify the sender by email if you are not the intended recipient.  If you a=
re <BR>
not the intended recipient, you may not use, copy, disclose, or distribute =
this <BR>
message or its contents or enclosures to any other person and any such acti=
ons <BR>
may be unlawful.  Ball reserves the right to monitor and review all message=
s <BR>
and enclosures sent to or from this email address.<BR>
</DIV></body>
</html>

--_000_326539938460471c975e791ce6b1c775ballcom_--

--_005_326539938460471c975e791ce6b1c775ballcom_
Content-Type: image/jpeg; name="image001.jpg"
Content-Description: image001.jpg
Content-Disposition: inline; filename="image001.jpg"; size=1514;
	creation-date="Fri, 20 Nov 2020 17:41:17 GMT";
	modification-date="Fri, 20 Nov 2020 17:41:17 GMT"
Content-ID: <image001.jpg@01D6BF29.AD6C5250>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIf
IiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7
Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCAA1ADUDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDDPU0l
WrDTrzVLwWtlA00rdh0A9SewrQm0vSNOcxX+pyXNwOGisIwwU+hduM/QV67kk7Hx8aUpLm6GLRXa
WemaRY38Fiiypq13H+7W6RZktWPK7lGBuI9jiuW1SS4k1O4N0kaTq5SQRqFXcvBwB9KmM+Zl1KDp
xu2VKBz05rX0TTEuM3t1C0tvHIsccKnBuZj92MHsO5PYV09wLX+01v7aK2t3K+XDKiDy4Io+JZ8d
zuJVM0pVEnYqnhnOPM3Y4SSKSF9ksbxuP4XUg/kaKu67qjazrNxfMCFkbCA9Qo4GffFFaK9tTCaS
k1HY6KEvZ/DrzNJdfPuJj9udGAdEGePXHT8z61U8L6dBbW0mvX0kEUcJKWa3BISSbHBOATgfz+lY
2kaTNrWqw2MAw0jfM2PuKOrVseKTLd63DoWm20vkWAEEEQU5Zv4m/H19s1g1Z8t99TujK8VUa20S
8/6/Es2iS6LqyXG06prV/wDNayL/AKgbur7v4j17ACkuNH0SLT9Su5Zrq+urQ+W8oYLFNcPnhccn
B6+ta1vqWjaDqFrpl9cc6dYtGZUUtiZyC4GO+P50ltJL/YC29lpcWlWkUpeK/wBRcAjr84U8lyO/
Qdqy5ne51KnC1tHvpvZ/8P1fYq6taPpcFho+nq7Xsdqd8hXalvv/ANZIW9SOM9gD3NReMLa+WOzs
9Ns2k037NGFmt1Libb0BI7DOQPfNM1HxFp/2ZLS5vr3XvLGNrHyIGx0zj5m/GsqXxfqog+zWLRad
bDpFaJsx+PX9auMZ3TMqtWkk4337f1b8SvD4Z124XfHpVzt9WTb/ADxRVCa5uLiQyTzyyuerO5Y/
rRW/vnn3pdn9/wDwDoNB8RWXh3S7kwQSTaldAr5nAWIfw89Tzz+VX/DsPi7U7AImpSWenKvNxNjI
XvtJ5x+OPetDSfB2naBZnV/EkkbNH8whPKIew/2m9ulc94m8YXWusbeEG2sF4WIHl/dv8OlYaTb5
V8zv1owTqu3aK0+8tT6tofh1mj0O3GoXo+9f3PzAHuVH9f51zl/qV7qk5nvrmSeTsXPA+g6D8Kq0
VvGCjr1OGpXlPTZdkFFFFWYBRRRQBt+Jtdu9e1J2nbZDCxWKEHhMHGfcn1rG2e9FFRFJJJG1STnJ
yluGz3o2e9FFVciyDZ70bPeiii4WQbPeiiii4WR//9k=

--_005_326539938460471c975e791ce6b1c775ballcom_
Content-Type: image/jpeg; name="image002.jpg"
Content-Description: image002.jpg
Content-Disposition: inline; filename="image002.jpg"; size=2468;
	creation-date="Fri, 20 Nov 2020 17:41:17 GMT";
	modification-date="Fri, 20 Nov 2020 17:41:17 GMT"
Content-ID: <image002.jpg@01D6BF29.AD6C5250>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIf
IiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7
Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCAAhAQUDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwBfOm/5
7Sf99mjzpv8AntJ/32aZT4onnlSGNdzyMFUepPSgA86b/ntJ/wB9mjzpv+e0n/fZreuNP8P6TJ9k
1Ca7uboAeabfAWM+nPWqtpo9tqGqzRWl432GFPMkuJEwVXvx60AZfnTf89pP++zR503/AD2k/wC+
zW9BZeG9RmWytLi8gnc7Y5ZgCjntkds/hWHdW8tncS28wxJExVh7igBvnTf89pP++zR503/PaT/v
s10V5p+gad9hiuorxpLqFJC8cgwueOhot/DtnFr1/Y3TySw2tv5ylG2sehwfwNAHO+dN/wA9pP8A
vs0edN/z2k/77NaMs/h9vLMFpeKN48zfKD8nfGO9WpPDmfEMdlC5NnMomSbPSLuc+vb8qAMTzpv+
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
iiigC9pnWX/gP9aKKKAP/9k=

--_005_326539938460471c975e791ce6b1c775ballcom_--

--===============1716287665033624150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1716287665033624150==--
