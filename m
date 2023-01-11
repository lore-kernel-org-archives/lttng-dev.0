Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEDAC5479D
	for <lttng-dev@archiver.kernel.org>; Wed, 11 Jan 2023 13:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1673442506;
	bh=hE2LLuvEbcUy4MMTNJacPoGapmub0yLsV43FmQvM4iQ=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=rm1VETim4I1+XpBOhy8wEWmTrWZ79mAMfiNGm3K2ArSEV5kQLoBzwUpr2EthoHzgN
	 HPpJ5QTu+/KwPoAZC/oyxh4gQ7cTdI1hvQlJry/kaEvlM7584Zc4PcSN4Q48vbjNdi
	 bzO0k8x4pKYpZmWHXyq3ZAS/+pxqfnSxC/uaZZ3acH8d3uM9o31K18p0NKuuOziVqe
	 zKonhPN68Zdah3pMlRDfEPxrmz/49l5a3cO8h0jeb1elcYcSRiyB4pUkyqJyns2x0R
	 3U911wPoxeKqQCU6m1rTVOapydNJXHk45rsLEVaI3xEoUaG9EctMT2AgfPTrPNeqxd
	 T+rzlSm6SgTyw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NsSfd3yG7z1Pt1;
	Wed, 11 Jan 2023 08:08:25 -0500 (EST)
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
 by lists.lttng.org (Postfix) with ESMTPS id 4NsSfb1HWpz1Pqb
 for <lttng-dev@lists.lttng.org>; Wed, 11 Jan 2023 08:08:23 -0500 (EST)
X-IronPort-AV: E=Sophos;i="5.96,317,1665446400"; 
 d="scan'208,217";a="281697419"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-2101.iad2.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 13:08:20 +0000
Received: from EX13D40EUB002.ant.amazon.com
 (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
 by email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com (Postfix)
 with ESMTPS id E023AA2B5B
 for <lttng-dev@lists.lttng.org>; Wed, 11 Jan 2023 13:08:19 +0000 (UTC)
Received: from EX19D007EUB002.ant.amazon.com (10.252.51.117) by
 EX13D40EUB002.ant.amazon.com (10.43.166.32) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Wed, 11 Jan 2023 13:08:18 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D007EUB002.ant.amazon.com (10.252.51.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Wed, 11 Jan 2023 13:08:18 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with
 mapi id 15.02.1118.020; Wed, 11 Jan 2023 13:08:18 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Statically linking LTTng to an application built with MUSL
 toolchain
Thread-Index: AQHZJb1SQ/KpNoSeJ0qRplAhqvR1CA==
Date: Wed, 11 Jan 2023 13:08:18 +0000
Message-ID: <7293b52e1e0d41dbbca7af1ab26fac0e@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.43.160.120]
MIME-Version: 1.0
Subject: [lttng-dev] Statically linking LTTng to an application built with
 MUSL toolchain
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
From: "Mousa, Anas via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Mousa, Anas" <anasmous@amazon.com>
Content-Type: multipart/mixed; boundary="===============3544479305575570078=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3544479305575570078==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_7293b52e1e0d41dbbca7af1ab26fac0eamazoncom_"

--_000_7293b52e1e0d41dbbca7af1ab26fac0eamazoncom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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


--_000_7293b52e1e0d41dbbca7af1ab26fac0eamazoncom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple=
 Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI=
 Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<p></p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
Hello,</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
<br>
</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
I've built the urcu, lttng-ust and lttng-tools with the musl toolchain, and=
 upon statically linking the application with the lttng-ust</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
archive (just as documented here: https://lttng.org/docs/v2.13/#doc-buildin=
g-tracepoint-providers-and-user-application),</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
the trace-point constructors attempting to dlopen() of&nbsp;<b>liblttng-ust=
-tracepoint.so.1</b>&nbsp; fail as the debug logs show:</p>
<pre class=3D"x_c-mrkdwn__pre" style=3D"margin-top:4px; margin-bottom:4px; =
padding:8px; font-size:12px; line-height:1.50001; tab-size:4; white-space:p=
re-wrap; word-break:normal; border-radius:4px; counter-reset:list-0 0 list-=
1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0=
; color:rgb(29,28,29); font-family:Monaco,Menlo,Consolas,&quot;Courier New&=
quot;,monospace!important">lttng-ust-tracepoint [1581544]: dlopen() failed =
to find 'liblttng-ust-tracepoint.so.1', tracepoints in this binary won't be=
 registered. (at addr=3D0x400490 in lttng_ust_tracepoints_print_disabled_me=
ssage() at /usr/aarch64-unknown-linux-musl/sys-root//include/lttng/tracepoi=
nt.h:426)</pre>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
although that shared object does exist in the system, and&nbsp;dlerror() re=
turned&nbsp;<span><b>Dynamic loading not supported</b>&nbsp;</span></p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
<span></span>(Note:&nbsp;When linking dynamically, the dlopen() succeeds bu=
t other platform-dependent issues arise).<br>
</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
I need to link statically rather than dynamically, do statically linked pro=
grams using musl libc support dlopen()?</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
if there's no such support, is there any way around?</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
<br>
</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
Would appreciate any input,<br>
</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
Best Regards,</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont; font-=
size:16px">
Anas.</p>
<br>
<p></p>
</div>
</body>
</html>

--_000_7293b52e1e0d41dbbca7af1ab26fac0eamazoncom_--

--===============3544479305575570078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3544479305575570078==--
