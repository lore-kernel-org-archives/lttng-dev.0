Return-Path: <SRS0=pL6W=ID=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1DDC433E0
	for <lttng-dev@archiver.kernel.org>; Fri,  5 Mar 2021 13:21:36 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3ABE64FD3
	for <lttng-dev@archiver.kernel.org>; Fri,  5 Mar 2021 13:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3ABE64FD3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DsT0G3d4DzBrH;
	Fri,  5 Mar 2021 08:21:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1614950495;
	bh=YAy4TERbzsIplqaCGG5FjieaqiI41L8mtJDcIN6c6dM=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zx7i0N/snqCRz2ZOOcL08CKJ15mn/vXafyQvWm04QaBIUu9ltNoKrr5Rr/y9JU6Kk
	 DHMlkizBfV3h/sCGF/ZL4CJhOO3djDbmGDjwf+zXKw/lgI7cbUirqSP5N0LysitFv9
	 4N/AiX7SeD4t8CDheMBuL5GB9jhLaHldzSO9llWbArFPtsB5Xc5cOblGMfjWpxde6K
	 G/mYdje/j+gEH+61/QQgIGqcDx5Ohm9pY3M4n9vgyrc7lQVlBErae7TD2VnRf5ljba
	 mggEEh+0QTBGKJNtnJBBp9d85LjRJC3M2rQTSv41o0SRudHPxbUlxTvoo8Wi/NYEq6
	 mMs+KJpd8us0Q==
Received: from oxalide-smtp-out.extra.cea.fr (oxalide-smtp-out.extra.cea.fr
 [132.168.224.13])
 by lists.lttng.org (Postfix) with ESMTPS id 4DsT0D1Lq5zBrF
 for <lttng-dev@lists.lttng.org>; Fri,  5 Mar 2021 08:21:31 -0500 (EST)
Received: from pisaure.intra.cea.fr (pisaure.intra.cea.fr [132.166.88.21])
 by oxalide-sys.extra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP
 id 125CRtDI030736; Fri, 5 Mar 2021 13:27:55 +0100
Received: from pisaure.intra.cea.fr (localhost [127.0.0.1])
 by localhost (Postfix) with SMTP id E7C3D204D97;
 Fri,  5 Mar 2021 13:27:54 +0100 (CET)
Received: from muguet2-smtp-out.intra.cea.fr (muguet2-smtp-out.intra.cea.fr
 [132.166.192.13])
 by pisaure.intra.cea.fr (Postfix) with ESMTP id DDC71204D8E;
 Fri,  5 Mar 2021 13:27:54 +0100 (CET)
Received: from I-EXCH-A3.intra.cea.fr (i-exch-a3.intra.cea.fr [132.166.88.227])
 by muguet2-sys.intra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP
 id 125CRsId006863; Fri, 5 Mar 2021 13:27:54 +0100
Received: from I-EXCH-A3.intra.cea.fr (132.166.88.227) by
 I-EXCH-A3.intra.cea.fr (132.166.88.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 5 Mar 2021 13:27:54 +0100
Received: from EXCAH-B3.intra.cea.fr (132.166.88.88) by I-EXCH-A3.intra.cea.fr
 (132.166.88.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2 via Frontend
 Transport; Fri, 5 Mar 2021 13:27:54 +0100
Received: from EXDAG0-B1.intra.cea.fr ([fe80::c18e:d8e8:9a27:5b84]) by
 EXCAH-B3.intra.cea.fr ([fe80::947a:e02d:e083:3de0%10]) with mapi id
 14.03.0487.000; Fri, 5 Mar 2021 13:27:54 +0100
To: Philippe Proulx <eeppeliteloop@gmail.com>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] [barectf] How to ensure that last events before a
 crash get recorded
Thread-Index: AQHXEQfH8OO3fMfK7k2UMsDwYOrjfqp1PpcAgAAUZGc=
Date: Fri, 5 Mar 2021 12:27:53 +0000
Message-ID: <386C5D4D5C53C24CBC2C60CAAFD2136A5B4B2E34@EXDAG0-B1.intra.cea.fr>
References: <386C5D4D5C53C24CBC2C60CAAFD2136A5B4B2B92@EXDAG0-B1.intra.cea.fr>,
 <CAB4xu_38oAbOD606ZQCp71oJ8qwYOt7F1Ssmpk=idhhTM7to6w@mail.gmail.com>
In-Reply-To: <CAB4xu_38oAbOD606ZQCp71oJ8qwYOt7F1Ssmpk=idhhTM7to6w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [132.166.88.225]
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1012-26010.007
X-TM-AS-Result: No-10--9.522100-8.000000
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
MIME-Version: 1.0
X-TMASE-MatchedRID: nI1cAR4k0HY6yy6RAAEPc461Z+HJnvsO82SgwNf6SK69P3995H/RpcX9
 rqqdIj82c4NUrxbHjuJVjdEnKZ0vVi2l8grHOIQzlVHM/F6YkvRLqa9X75MqaeD0a1g8E91LqhX
 sUcL2MQRF6Jq8ne3VAI913mjfQ3KIIS4aUVryC8GTCCj1265aF0N+63YtzViHdjTiy6QtbPqF/D
 Brpeo+OXikEB4ENdrglZ0L7mYPE31Kzl0OLwrWWLSlePUaQB97QR7lWMXPA1vDqO6/8R69QNOiG
 FjeqLkCe1mK/cNFuML6+5es6gbvTgaDi8wMH7Dz1ilQ4KKAwrfGSb7RikwvVzLZyQk29Rf4tLSU
 4gcykWhWK5U/rCSFf3gHxXvVq0IS2wrN6ugrbs5yMswwR1sr65LQR37yyvyaStFk/81wIJIoIhl
 +v+yCGcJToVJxC6y00AAj4Lcjr8WZEKhZJ6HsIWK3N9p/OFh6Jd2n2XoSRFntjfny5P3G5TBBYV
 82eTWFohccjf+m6IIMPBva3w6jnSNgyw3swYMYvMr1EZWBgiEZ8RJ4fqmXhoVMrooKmT4Mw86bk
 UZoMU0AJxdQeYKU9svPy4osyYDXj2hRzH1UwuATNCcUsR4xSYDH9tzzuv1v/nnwJ52QYi+A6TP5
 7EUvvtsqsOw1SacbEZAWvTB+BsUU4yb51oAD+7CmHvLKHJZI2Zpwkui8XlIPYriGB6nAXXlwK2K
 DjeFOxghBl1d9Q1MvlAH6OIXaLJRMZUCEHkRt
X-TMASE-Result: 10--9.522100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1012-26010.007
X-TM-SNTS-SMTP: 1BBE7680DEBA2DE7D7378F4409AB6FAE6028E7B5FC6FBAD1201612EC6D3C29A82000:8
Subject: Re: [lttng-dev] [barectf] How to ensure that last events before a
 crash get recorded
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: RADERMACHER Ansgar via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: RADERMACHER Ansgar <Ansgar.RADERMACHER@cea.fr>
Content-Type: multipart/mixed; boundary="===============2643424569929170582=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2643424569929170582==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4B2E34EXDAG0B1intrace_"

--_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4B2E34EXDAG0B1intrace_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

thanks for your response. The reason not to use LTTng is simple: while I de=
velop on Linux, our client is chiefly using Windows with the mingw environm=
ent.

Best regards

Ansgar

________________________________
From: P
hilippe Proulx [eeppeliteloop@gmail.com]
Sent: Friday, March 05, 2021 13:11
To: RADERMACHER Ansgar
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] [barectf] How to ensure that last events before a =
crash get recorded

On Thu, Mar 4, 2021 at 10:28 RADERMACHER Ansgar via lttng-dev <lttng-dev@li=
sts.lttng.org<mailto:lttng-dev@lists.lttng.org>> wrote:
Hi,

when doing tracing with barectf, the trace elements are written into a buff=
er first and only written when the buffer is full - or if the function bare=
ctf_platform_fs_fini gets called.
In case of a crash, it's therefore possible to loose some events. What is t=
he best option to prevent this issue? I've used signal handlers that call t=
he function barectf_platform_fs_fini. This seems to work well with Linux, b=
ut is not portable. When using the provided sample platform, there is also =
the option to reduce the buffer size, but this is not ideal, as trace event=
s that are too big for the buffer are not written.

First question: why are you using barectf on Linux vs LTTng?

LTTng supports writing the sub-buffers to NVRAM and, if the system crashes,=
 convert those sub-buffers to a CTF trace with the lttng-crash utility. See=
 <
https://lttng.org/docs/v2.12/#doc-persistent-memory-file-systems>.

With NVRAM, you could do this with barectf with a corresponding platform us=
ing it. It's always up to the platform author to decide where buffers are a=
nd where complete packets go; it's not a feature of barectf as such.

Hope it helps,

Phil


Best regards

Ansgar


_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
--
Philippe Proulx

--_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4B2E34EXDAG0B1intrace_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" id=3D"owaParaStyle"></style>
</head>
<body fpstyle=3D"1" ocsi=3D"0">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">
<div>Hi Philippe,</div>
<div><br>
</div>
<div>thanks for your response. The reason not to use LTTng is simple: while=
 I develop on Linux, our client is chiefly using Windows with the mingw env=
ironment.</div>
<div><br>
</div>
<div>Best regards</div>
<div><br>
</div>
<div>Ansgar<br>
</div>
<br>
<div style=3D"font-family: Times New Roman; color: #000000; font-size: 16px=
">
<hr tabindex=3D"-1">
<div id=3D"divRpF148139" style=3D"direction: ltr;"><font size=3D"2" face=3D=
"Tahoma" color=3D"#000000"><b>From:</b> P</font></div>
<div style=3D"direction: ltr;"><font size=3D"2" face=3D"Tahoma" color=3D"#0=
00000">hilippe Proulx [eeppeliteloop@gmail.com]<br>
<b>Sent:</b> Friday, March 05, 2021 13:11<br>
<b>To:</b> RADERMACHER Ansgar<br>
<b>Cc:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> Re: [lttng-dev] [barectf] How to ensure that last events be=
fore a crash get recorded<br>
</font><br>
</div>
<div></div>
<div>
<div>On Thu, Mar 4, 2021 at 10:28 RADERMACHER Ansgar via lttng-dev &lt;<a h=
ref=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank" rel=3D"noopener =
noreferrer">lttng-dev@lists.lttng.org</a>&gt; wrote:<br>
</div>
<div>
<div class=3D"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; border=
-left-width:1px; border-left-style:solid; padding-left:1ex; border-left-col=
or:rgb(204,204,204)">
<div>
<div style=3D"direction:ltr; font-family:Tahoma; font-size:10pt; color:rgb(=
0,0,0)">
<div style=3D"font-family:Tahoma">Hi,</div>
<div style=3D"font-family:Tahoma"><br>
</div>
<div style=3D"font-family:Tahoma">when doing tracing with barectf, the trac=
e elements are written into a buffer first and only written when the buffer=
 is full - or if the function barectf_platform_fs_fini gets called.</div>
<div style=3D"font-family:Tahoma">In case of a crash, it's therefore possib=
le to loose some events. What is the best option to prevent this issue? I'v=
e used signal handlers that call the function barectf_platform_fs_fini. Thi=
s seems to work well with Linux, but
 is not portable. When using the provided sample platform, there is also th=
e option to reduce the buffer size, but this is not ideal, as trace events =
that are too big for the buffer are not written.</div>
</div>
</div>
</blockquote>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">First question: why are you using barectf on Linux vs LTT=
ng?</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">LTTng supports writing the sub-buffers to NVRAM and, if t=
he system crashes, convert those sub-buffers to a CTF trace with the lttng-=
crash utility. See &lt;
<div dir=3D"auto"><a href=3D"https://lttng.org/docs/v2.12/#doc-persistent-m=
emory-file-systems" target=3D"_blank" rel=3D"noopener noreferrer">https://l=
ttng.org/docs/v2.12/#doc-persistent-memory-file-systems</a>&gt;.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">With NVRAM, you could do this with barectf with a corresp=
onding platform using it. It's always up to the platform author to decide w=
here buffers are and where complete packets go; it's not a feature of barec=
tf as such.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Hope it helps,</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Phil</div>
</div>
<div dir=3D"auto"><br>
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; border=
-left-width:1px; border-left-style:solid; padding-left:1ex; border-left-col=
or:rgb(204,204,204)">
<div>
<div style=3D"direction:ltr; font-family:Tahoma; font-size:10pt; color:rgb(=
0,0,0)">
<div dir=3D"auto" style=3D"font-family:Tahoma"></div>
<div style=3D"font-family:Tahoma"><br>
</div>
<div style=3D"font-family:Tahoma">Best regards</div>
<div style=3D"font-family:Tahoma"><br>
</div>
<div style=3D"font-family:Tahoma">Ansgar<br>
</div>
<div style=3D"font-family:Tahoma"><br>
</div>
<div style=3D"font-family:Tahoma"><br>
</div>
</div>
</div>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank" rel=3D"noope=
ner noreferrer">lttng-dev@lists.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
</blockquote>
</div>
</div>
-- <br>
<div dir=3D"ltr" class=3D"gmail_signature">Philippe Proulx</div>
</div>
</div>
</div>
</body>
</html>

--_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4B2E34EXDAG0B1intrace_--

--===============2643424569929170582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2643424569929170582==--
