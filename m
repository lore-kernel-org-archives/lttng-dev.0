Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E61C004D4
	for <lttng-dev@archiver.kernel.org>; Thu, 19 Jan 2023 11:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1674128947;
	bh=FigV9sk2iJwxgOfOOxRr9Lfnrcsf3eDHu+rT+8x2WVw=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=sIEI6kthzvS3vRYpQg8pclfbR5ykM1CoomhJ+G+lAXgqNQoUij6TSKlKZCR+C09T/
	 YGtwM1EwIIuG7dz9Kwwkla8rhXHczMR8c/HlkLg3vD3rTvCFEG3LTK5UmbfWest2sv
	 9nPvmDtdQ4sIWLCceqn0xYKrmnTm6+hfyinLV0wmKA0roZ1MEPx+u73Ycd0CdHtKaH
	 C0yhQzj9Jno9ZWGDSUAIRLYmlanB7XGMLnW1sAPzavxtnT5LxuoJ6dcKnK9YaV8cR9
	 gtmfXMqIaRE36NKsbrHrqVdvdlS0rw4pnRsM0Q9omuFzIISCRlCH9DYAYUs5533r1k
	 pZ+qmTSOIJM7A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NyLWQ5mxLz1Sfh;
	Thu, 19 Jan 2023 06:49:06 -0500 (EST)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
 by lists.lttng.org (Postfix) with ESMTPS id 4NyLWN6dHCz1SyT
 for <lttng-dev@lists.lttng.org>; Thu, 19 Jan 2023 06:49:04 -0500 (EST)
X-IronPort-AV: E=Sophos;i="5.97,229,1669075200"; 
 d="scan'208,217";a="288220607"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.43.8.6])
 by smtp-border-fw-6002.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 11:49:01 +0000
Received: from EX13D39EUA001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
 by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix)
 with ESMTPS id 9520F811AC
 for <lttng-dev@lists.lttng.org>; Thu, 19 Jan 2023 11:49:00 +0000 (UTC)
Received: from EX19D008EUA001.ant.amazon.com (10.252.50.34) by
 EX13D39EUA001.ant.amazon.com (10.43.165.90) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Thu, 19 Jan 2023 11:48:59 +0000
Received: from EX19D007EUA004.ant.amazon.com (10.252.50.76) by
 EX19D008EUA001.ant.amazon.com (10.252.50.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Thu, 19 Jan 2023 11:48:59 +0000
Received: from EX19D007EUA004.ant.amazon.com ([fe80::d9f5:ab17:b5c0:4f4d]) by
 EX19D007EUA004.ant.amazon.com ([fe80::d9f5:ab17:b5c0:4f4d%3]) with
 mapi id 15.02.1118.020; Thu, 19 Jan 2023 11:48:59 +0000
To: "Mousa, Anas" <anasmous@amazon.com>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
Thread-Topic: Statically linking LTTng to an application built with MUSL
 toolchain
Thread-Index: AQHZJb1SQ/KpNoSeJ0qRplAhqvR1CK6lq+pg
Date: Thu, 19 Jan 2023 11:48:59 +0000
Message-ID: <a421e860877b4936be3ee718deac393a@amazon.com>
References: <7293b52e1e0d41dbbca7af1ab26fac0e@amazon.com>
In-Reply-To: <7293b52e1e0d41dbbca7af1ab26fac0e@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.85.143.174]
MIME-Version: 1.0
Subject: Re: [lttng-dev] Statically linking LTTng to an application built
 with MUSL toolchain
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "Yitschak, Yehuda via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Yitschak, Yehuda" <yehuday@amazon.com>
Content-Type: multipart/mixed; boundary="===============7698054439622581158=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7698054439622581158==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_a421e860877b4936be3ee718deac393aamazoncom_"

--_000_a421e860877b4936be3ee718deac393aamazoncom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Bumping.

Appreciate your comments on this

Yehuda



Hello,



I've built the urcu, lttng-ust and lttng-tools with the musl toolchain, and=
 upon statically linking the application with the lttng-ust

archive (just as documented here: https://lttng.org/docs/v2.13/#doc-buildin=
g-tracepoint-providers-and-user-application),

the trace-point constructors attempting to dlopen() of liblttng-ust-tracepo=
int.so.1  fail as the debug logs show:

lttng-ust-tracepoint [1581544]: dlopen() failed to find 'liblttng-ust-trace=
point.so.1', tracepoints in this binary won't be registered. (at addr=3D0x4=
00490 in lttng_ust_tracepoints_print_disabled_message() at /usr/aarch64-unk=
nown-linux-musl/sys-root//include/lttng/tracepoint.h:426)

although that shared object does exist in the system, and dlerror() returne=
d Dynamic loading not supported

(Note: When linking dynamically, the dlopen() succeeds but other platform-d=
ependent issues arise).

I need to link statically rather than dynamically, do statically linked pro=
grams using musl libc support dlopen()?

if there's no such support, is there any way around?



Would appreciate any input,

Best Regards,

Anas.


--_000_a421e860877b4936be3ee718deac393aamazoncom_
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
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<p class=3D"MsoNormal">Bumping.<br>
<br>
Appreciate your comments on this<br>
<br>
Yehuda <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">Hello,<o:p></o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">I've built the urcu, lttng-=
ust and lttng-tools with the musl toolchain, and upon statically linking th=
e application with the lttng-ust<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black">archive (just as documented=
 here: <a href=3D"https://lttng.org/docs/v2.13/#doc-building-tracepoint-pro=
viders-and-user-application">
https://lttng.org/docs/v2.13/#doc-building-tracepoint-providers-and-user-ap=
plication</a>),<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black">the trace-point constructor=
s attempting to dlopen() of&nbsp;<b>liblttng-ust-tracepoint.so.1</b>&nbsp; =
fail as the debug logs show:<o:p></o:p></span></p>
<pre style=3D"mso-margin-top-alt:3.0pt;margin-right:0cm;margin-bottom:3.0pt=
;margin-left:0cm;tab-size:4;white-space:pre-wrap;border-radius:4px;counter-=
reset:list-0 0 list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7=
 0 list-8 0 list-9 0"><span style=3D"font-size:9.0pt;font-family:Consolas;c=
olor:#1D1C1D">lttng-ust-tracepoint [1581544]: dlopen() failed to find 'libl=
ttng-ust-tracepoint.so.1', tracepoints in this binary won't be registered. =
(at addr=3D0x400490 in lttng_ust_tracepoints_print_disabled_message() at /u=
sr/aarch64-unknown-linux-musl/sys-root//include/lttng/tracepoint.h:426)<o:p=
></o:p></span></pre>
<p><span style=3D"font-size:12.0pt;color:black">although that shared object=
 does exist in the system, and&nbsp;dlerror() returned&nbsp;<b>Dynamic load=
ing not supported</b>&nbsp;<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black">(Note:&nbsp;When linking dy=
namically, the dlopen() succeeds but other platform-dependent issues arise)=
.<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black">I need to link statically r=
ather than dynamically, do statically linked programs using musl libc suppo=
rt dlopen()?<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black">if there's no such support,=
 is there any way around?<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">Would appreciate any input,=
<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black">Best Regards,<o:p></o:p></s=
pan></p>
<p><span style=3D"font-size:12.0pt;color:black">Anas.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_a421e860877b4936be3ee718deac393aamazoncom_--

--===============7698054439622581158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7698054439622581158==--
