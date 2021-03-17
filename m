Return-Path: <SRS0=EUdU=IP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A86C433DB
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Mar 2021 13:45:22 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D1464F50
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Mar 2021 13:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D1464F50
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F0ry66FrnzJHD;
	Wed, 17 Mar 2021 09:45:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1615988719;
	bh=qpy02AjFuCXYe/hiKebdgYUNC1lK6SeFkf5+XNHT7PA=;
	h=To:CC:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=i6wG9CLqqUEzkX85+8a28l5rK9xDHIpqMPiVDmE96oac+8LLJLROYWs0bagiOa8va
	 aYZno6wt+Fbv1R+UKvoxvx2q2QrF7nMkPNZ97cqIPdSh6qmS3TWbF2bn5cWJ0Xsmg3
	 DJJrAURdGUefFyxhO40Lfmporyqe+tV/bXAUBLcBBYsMwFuphClH7mRHu2/V8m71Jr
	 IVoK8+JhUy81e9cymd/6A0oUqx8fdg092rBtZWXY24L5O4hkETd6Wtu5RK5gCySs+r
	 50uRGsxldKqjkaBbTEiZHktSoELt39lBwSezTXgvBG9MFyKql+sgdYqg91ZfVLISlL
	 JAAmuTwcqBLqQ==
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by lists.lttng.org (Postfix) with ESMTPS id 4F0ry459ygzJHC
 for <lttng-dev@lists.lttng.org>; Wed, 17 Mar 2021 09:45:16 -0400 (EDT)
IronPort-SDR: 70YyraTEm5uNugQZ1ZFHIWeVLMM7JUD8eLntkxauks9wt2KoGSpccCKgtSc6BVVIcPQspGZTOj
 uScwK9WkRm/Cu4gd8VhNXId6DLS7nGzwim+eTYtKeiPsY0KnqqtalrPDJ4XzdPgzyPaDQsWgnW
 0bw15TZmSEpyu1OrGWHgRdB82/TyoV4XMCADA0o8CsxCh4cuIwov0wkcbLbSfXSSkCyW0EO42E
 O9Mknu8w2p9rJoqENOx1Xjv/X4obtiQrF85BKT50vrzU7/H5u2LUK7RbNd26pwWJwyVAU4BFcI
 SYg=
X-IronPort-AV: E=Sophos;i="5.81,256,1610438400"; d="scan'208,217";a="59181745"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa2.mentor.iphmx.com with ESMTP; 17 Mar 2021 05:44:02 -0800
IronPort-SDR: 7CBdUt3N5YlU+7gO6vBpdSkGmj/rda6XsHa3qU3NKNrCcHGOYUIoVe7h7iJn5QCtzVqDfttzWB
 II5g1s1Bn1zn+EFxNAhhJibwuxu2dvMiCjGbq+xjq9jcvPU8P8nGAe8dg7yiVwUoBmVJJMlGsD
 ducNvbvj+Wp+XpRuqfo0/ZeWNeMeHRGBNsnuT4VU87hAzfjTIkVQqVP6rXhrc71A3cP8ZT2Zuc
 BTeMr4qYFwDDSLzKhPcZ/e8lU/25TrMStBAAbOM+giC2nJGCsGAgRTG2pjcKurjBRwmSdctaCR
 mKU=
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
CC: "Krishnakar, Srikanth" <Srikanth_Krishnakar@mentor.com>
Thread-Topic: LTTNG Support for arm64 based k3-am654 board 
Thread-Index: AQHXGzOV+6Br9rlLv0edjM4AEfE12w==
Date: Wed, 17 Mar 2021 13:43:59 +0000
Message-ID: <1615988639233.71702@mentor.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [147.34.91.1]
MIME-Version: 1.0
Subject: [lttng-dev] Reg: LTTNG Support for arm64 based k3-am654 board
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
From: "Vadivel, Arulpandiyan via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Vadivel, Arulpandiyan" <Arulpandiyan_Vadivel@mentor.com>
Content-Type: multipart/mixed; boundary="===============4571786249902331951=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4571786249902331951==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_161598863923371702mentorcom_"

--_000_161598863923371702mentorcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Team,

    We are working on the Texas Instrument's K3-am654 board(ARM64 based), o=
n 4.19.165-cip41 RT and Non-RT kernel. We would like to have the lttng supp=
ort on the board. Hence I have added below configurations.  With these conf=
igurations enabled I am not able to access the console itself and kernel st=
uck at Starting kernel itself as below.  Further we have added earlycon to =
debug the early console.  Bootargs given below. With these earlycon option =
also we are still stuck at  Starting kernel  itself.


Could you please help me to understand below queries,

  *    Do we have the support of lttng for TI's K3-am654 board?
  *    Or did we miss something in the kernel?


Bootargs
setenv bootargs "console=3DttyS3,115200n8 root=3D/dev/mmcblk0p1 rw rootfsty=
pe=3Dext4 rootwait earlycon=3Dns16550a,mmio32,0x02810000"
load mmc 0:1 0x82000000 /usr/lib/linux-image-4.19.165-cip41-rt18/ti/k3-am65=
4-base-board.dtb
load mmc 0:1 0x80080000 /boot/vmlinuz-4.19.165-cip41-rt18;
load mmc 0:1 0x81000000 /boot/initrd.img-4.19.165-cip41-rt18;
booti 0x80080000 0x81000000:20000 0x82000000

?
?Boot logs
=3D>
=3D> run bootcmd_mmc0
switch to partitions #0, OK
mmc0 is current device
Scanning mmc 0:1...
77332 bytes read in 9 ms (8.2 MiB/s)
16533512 bytes read in 4217 ms (3.7 MiB/s)
8740838 bytes read in 731 ms (11.4 MiB/s)
## Flattened Device Tree blob at 82000000
   Booting using the fdt blob at 0x8200000
   Loading Ramdisk to fd670000, end fdec5fe6 ... OK
   Loading Device Tree to 00000000fd65a000, end 00000000fd66fe13 ... OK

Starting kernel ...

Kernel Configurations.
CONFIG_KPROBES=3Dy
CONFIG_PERF_EVENTS=3Dy
CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
CONFIG_EVENT_TRACING=3Dy
CONFIG_KRETPROBES=3Dy
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_ALL=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy
CONFIG_TRACEPOINTS=3Dy
CONFIG_FTRACE=3Dy
CONFIG_FUNCTION_TRACER=3Dy
CONFIG_LTTNG=3Dm

Regards,
Arulpandiyan V.

--_000_161598863923371702mentorcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none"><!-- p { margin-top: 0px; m=
argin-bottom: 0px; }--></style>
</head>
<body dir=3D"ltr" style=3D"font-size:12pt;color:#000000;background-color:#F=
FFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi Team,&nbsp;<br>
</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;We are working on the Texas Instrument's&nbsp;K3=
-am654 board(ARM64 based),&nbsp;on 4.19.165-cip41&nbsp;RT and Non-RT&nbsp;k=
ernel. We would like to have the lttng support on the board. Hence I have a=
dded below configurations.&nbsp; With these configurations enabled&nbsp;I a=
m not able&nbsp;to
 access the console itself and kernel stuck at&nbsp;<strong><em>Starting ke=
rnel </em></strong>itself as below.&nbsp;&nbsp;<span style=3D"font-size: 12=
pt;">Further we&nbsp;have added earlycon to debug</span><span style=3D"font=
-size: 12pt;"> the early console.&nbsp; Bootargs given below.
 With these earlycon option also we are still stuck at&nbsp;&nbsp;<strong s=
tyle=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 16px=
; background-color: rgb(255, 255, 255);"><em>Starting kernel&nbsp;</em></st=
rong> itself.&nbsp;</span></p>
<p><span style=3D"font-size: 12pt;"><br>
</span></p>
<p><span style=3D"font-size: 12pt;">Could you please help me to understand =
below queries,</span><br>
</p>
<ul dir=3D"" class=3D"" style=3D"">
<li>&nbsp;Do we have the support of lttng for TI's&nbsp;K3-am654 board?<br>
</li><li><span style=3D"font-size: 12pt;">&nbsp;Or did we&nbsp;miss somethi=
ng in the kernel?</span></li></ul>
<p><span style=3D"font-size: 12pt;"><br>
</span></p>
<div><span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; fon=
t-size: 16px; background-color: rgb(255, 255, 255);"><strong>Bootargs</stro=
ng></span><br style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; =
font-size: 16px; background-color: rgb(255, 255, 255);">
</div>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px; background-color: rgb(255, 255, 255);">
<em>setenv bootargs &quot;console=3DttyS3,115200n8 root=3D/dev/mmcblk0p1 rw=
 rootfstype=3Dext4 rootwait earlycon=3Dns16550a,mmio32,0x02810000&quot;</em=
></div>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px; background-color: rgb(255, 255, 255);">
<em>load mmc 0:1 0x82000000 /usr/lib/linux-image-4.19.165-cip41-rt18/ti/k3-=
am654-base-board.dtb</em></div>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px; background-color: rgb(255, 255, 255);">
<div><em>load mmc 0:1 0x80080000 /boot/vmlinuz-4.19.165-cip41-rt18;</em></d=
iv>
</div>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px; background-color: rgb(255, 255, 255);">
<div><em>load mmc 0:1 0x81000000 /boot/initrd.img-4.19.165-cip41-rt18;</em>=
</div>
</div>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px; background-color: rgb(255, 255, 255);">
<div><em>booti 0x80080000 0x81000000:20000 0x82000000</em></div>
</div>
</div>
</blockquote>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px; background-color: rgb(255, 255, 255);">
</div>
<br>
</div>
<em style=3D"font-size: 12pt;">&#8203;</em><br>
<em style=3D"font-size: 12pt;"><strong>&#8203;Boot logs</strong></em><br>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div>
<div><em>=3D&gt;</em></div>
</div>
<div>
<div><em>=3D&gt; run bootcmd_mmc0</em></div>
</div>
<div>
<div><em>switch to partitions #0, OK</em></div>
</div>
<div>
<div><em>mmc0 is current device</em></div>
</div>
<div>
<div><em>Scanning mmc 0:1...</em></div>
</div>
<div>
<div><em>77332 bytes read in 9 ms (8.2 MiB/s)</em></div>
</div>
<div>
<div><em>16533512 bytes read in 4217 ms (3.7 MiB/s)</em></div>
</div>
<div>
<div><em>8740838 bytes read in 731 ms (11.4 MiB/s)</em></div>
</div>
<div>
<div><em>## Flattened Device Tree blob at 82000000</em></div>
</div>
<div>
<div><em>&nbsp; &nbsp;Booting using the fdt blob at 0x8200000</em></div>
</div>
<div>
<div><em>&nbsp; &nbsp;Loading Ramdisk to fd670000, end fdec5fe6 ... OK</em>=
</div>
</div>
<div>
<div><em>&nbsp; &nbsp;Loading Device Tree to 00000000fd65a000, end 00000000=
fd66fe13 ... OK</em></div>
</div>
<div>
<div><br>
</div>
</div>
<div>
<div><em style=3D"color: rgb(255, 0, 0); text-decoration: none solid rgb(25=
5, 0, 0);"><span style=3D"color: rgb(255, 0, 0); text-decoration: none soli=
d rgb(255, 0, 0);">Starting kernel ...</span></em></div>
</div>
</blockquote>
<div><br>
</div>
<div>Kernel Configurations.<br>
</div>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div>CONFIG_KPROBES=3Dy</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div>CONFIG_PERF_EVENTS=3Dy</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div>CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy<br>
</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div>CONFIG_EVENT_TRACING=3Dy</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div>CONFIG_KRETPROBES=3Dy</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div>CONFIG_KALLSYMS=3Dy</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div>CONFIG_KALLSYMS_ALL=3Dy</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div>CONFIG_HIGH_RES_TIMERS=3Dy</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div>CONFIG_TRACEPOINTS=3Dy</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div>CONFIG_FTRACE=3Dy</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div>CONFIG_FUNCTION_TRACER=3Dy</div>
</blockquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;">
<div>CONFIG_LTTNG=3Dm</div>
</blockquote>
</blockquote>
<div><br>
</div>
<div>Regards,<br>
</div>
<div>Arulpandiyan V.<br>
</div>
</body>
</html>

--_000_161598863923371702mentorcom_--

--===============4571786249902331951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4571786249902331951==--
