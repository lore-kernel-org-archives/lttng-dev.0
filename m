Return-Path: <SRS0=QQXS=BN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563BAC433DF
	for <lttng-dev@archiver.kernel.org>; Mon,  3 Aug 2020 15:20:13 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC889206D7
	for <lttng-dev@archiver.kernel.org>; Mon,  3 Aug 2020 15:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Dt8tDpBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC889206D7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BL1lw10dHz1nQP;
	Mon,  3 Aug 2020 11:20:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1596468012;
	bh=K8DycYFypOb6XPemmSd/GeM/mUAevJlZ7B3NPoJKcAU=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Dt8tDpBFntFDJCvDUQVv2oSkTh+7gSzcqY4c8zxgw/tkbkrjrVtO201PqCzFEXM7C
	 7zLq4QfsFgrjeCOvJXS8Jp2k+UfcSOv77bGlLZn4bi2PdkvS7ULHHbDlK/MXdJn25d
	 O19F/Ax+cYs+GHR50VvVm9tGXRQ4S3rm9hr/peXwOX5D7TOdaLzcWnF9hX6YNYX1FQ
	 gwQ4EvHMAkcSLqzOdSvQvf6Q6mVXSQapsvVHo5/EsyrK7eI9I7fg8Zxm6bC/15uFVT
	 qS8sX7B8aAoFH/QxjqBvMxHIEjeR4kIJV9WY4iV5wrHFvqqQ4D6uDKExpZScE/Hy6W
	 MdZWAxNJfnS8Q==
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80124.outbound.protection.outlook.com [40.107.8.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4BKt693h1rz1nSP
 for <lttng-dev@lists.lttng.org>; Mon,  3 Aug 2020 05:35:29 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxC9Hs93LfzlTiWMENDhNpuiCCgpMCCquOJMDraUa9TsqCCdHChIqzyDn3cleAWomFsRj2qkRXWPgsvbTaBJCgoG6ewI/tcDjSPSnuKwdur14PLYd6FUovokxAwqKfrJo2VPut+TiKUQc3joFGQMgb7iRIKLUmGQ2jJGqB/Q379zcPOlQI44kmzFSfZK8ReNo4/+uHNHweDwZTgV3vLiPM6peByTJjCmtoNFPKU+wE8jTVegkLgelfry48rIYEXxszbbMFZL3mv71BLOFQrODNOZQ8+LPGxucaGibHtBn0k8tWKZqknwUIFFcDyGfdyynHfd9SoQBkmNzQs+FBFUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT6WcKHMev9nNsqiSNLOJ5UlfVmPdFYuNmoduOahi0M=;
 b=F/43WRz4S4/4ISr7pNmDkND051kft+vO0stbiIYHo2wWFC2apWHMDefBloQ4cems7bdc7VIkyxMGcO7EQBti4C3NhqIMZLvGYMHLAXWcP5x0cRN3B7ljvmxokzdIeXhaj2oTVbwB/8CmLMzizSDyJQHcom6yXTqsZKmNWpDJ9cHYHGutbyKcfkshT1CO3WtvNpBx+lT+cgGwXZ7HyHugn/PpLrsJhsoOewWqRC1cNXmCwgxpic8AK2YoybAgik9w4IQVqiDtCC3hA+O26bIy/i15+OfXkfR4TydvRPvyf+JWyR8WmbeOYZgwP9RnHFVdVbc4zwuEpOGhzTq+GSYCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hexagon.com; dmarc=pass action=none header.from=hexagon.com;
 dkim=pass header.d=hexagon.com; arc=none
Received: from AM0PR06MB4003.eurprd06.prod.outlook.com (2603:10a6:208:b0::15)
 by AM0PR06MB4436.eurprd06.prod.outlook.com (2603:10a6:208:c6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Mon, 3 Aug
 2020 09:35:26 +0000
Received: from AM0PR06MB4003.eurprd06.prod.outlook.com
 ([fe80::7406:e48e:2388:a6f4]) by AM0PR06MB4003.eurprd06.prod.outlook.com
 ([fe80::7406:e48e:2388:a6f4%6]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 09:35:26 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Help needed: No UST events recorded
Thread-Index: AQHWaXO/Sy0OYhQYf0G0q2MMQYLGAw==
Date: Mon, 3 Aug 2020 09:35:25 +0000
Message-ID: <AM0PR06MB40030B857FF08F8B7685563FE64D0@AM0PR06MB4003.eurprd06.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [62.12.152.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f3758ac-1381-42a5-a48e-08d837908d71
x-ms-traffictypediagnostic: AM0PR06MB4436:
x-microsoft-antispam-prvs: <AM0PR06MB44360D4CDEB4559FB574124EE64D0@AM0PR06MB4436.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +wMmlrN44jN3VxMrFhASdCj6eRALeWMvIKvjxwZcboCgw6WuJ27LiLo/Wzv1Zbq1uNR/hZAn5sTlg7B1b9zuwre0vqRNu9W9btUbCB4aoME3zYA5M24nKFrXMz1hR5tAaUoAHhKJqqPAD2rSVUQseF2R85iZ140ftVwyUKF98v6VdPk1heLY3qS0eUaQ2l9jejOXpbw0jGPTtWgjCuZkv1FstzpnzPLkUznuqESidMysDc1U2KCiXXmc7hXDvS99SMQqE42jIUw0m2PPvwzlPMrn6evG08Hww5VSl3nc9b+Oezcqul6rRLbxFno5daF46fy0LTFXzGpZb9Ly7yUrWYrxVyV8/1Tte0FLL1Q1mVC8zsj3mj1eqAKJ3qq+X8YHbLAvtBlbuy0pRSm3dYopCw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR06MB4003.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(5660300002)(52536014)(55016002)(66946007)(66476007)(66616009)(66446008)(86362001)(66556008)(64756008)(76116006)(9686003)(99936003)(166002)(19627405001)(186003)(7696005)(2906002)(316002)(6916009)(33656002)(71200400001)(478600001)(8676002)(26005)(8936002)(966005)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: REEr1LKUVQnp0G3awzZvAHmsg/FYjxPgmx92Z9Q6+7EtoB9Mfytx9SPNUzkqCqQi1u0ZbJYV0gAUoxkPM5uU3gAEP+xt9EhRiBoAN+j4005vGG11EleW4M/mjyCipTBccbai97DouQnLcySCE4sbLMXDmK7casfod0V2zAOO2o5wuzWHQsnaTecXgLHhIhtn+0YabRDTAcyPmJKn6gLUT1GoCfxKsEs99rKiH9kFigUOLQnp+ohNbC0fAtn86zUmO2vYRYVpCmFC7SMI3/1ikanKm2EWs6bHVN4XRhvF2/QIJUeQS6ZgYlzAwbQS2sn8TJvu25hFRgvrYLO3t0vSapYC7naKLNOj/qdA5z+cwXenLdgatGHnGe3GpX/hYcFmnBei+4/P9wnua4iMSZHaTczgVT3x6oofqb/Ox5NZKtlYape5itqVLy4Xmx9CNAmhMA8KoXBkrq3NcKzQeR3XXytdSuVicJlw8xRHzphEIemKdp5MmMXlU2GkVR+8Ryw6O+jiW32jdmpWarY93FKfBdvR8ZQx9AH1I3jmHHoelx4RKVHYl8oBzVfLAIc5u8lOyVnkIOqpaBWJyndhzekzCxBHpQe2rtJSBIml8/MDM4jRV8MKFRHDfnJiCrjyqzvRwkXQSvXk/IC/p7DQOtVONg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hexagon.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB4003.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3758ac-1381-42a5-a48e-08d837908d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 09:35:25.9529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gegX5puno6k9K5L9741f7etRpiOrniofGygggAgwh0FPWm+FbLmXNAEfznkHF48HW5S95VTaz1opD+V0a76HLTaQGFZRLyLlxH/3Aka47Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB4436
X-Mailman-Approved-At: Mon, 03 Aug 2020 11:20:10 -0400
Subject: [lttng-dev] Help needed: No UST events recorded
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
From: PFLANZER Moritz via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: PFLANZER Moritz <moritz.pflanzer@hexagon.com>
Content-Type: multipart/mixed; boundary="===============4328617327267883582=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4328617327267883582==
Content-Language: en-GB
Content-Type: multipart/related;
	boundary="_004_AM0PR06MB40030B857FF08F8B7685563FE64D0AM0PR06MB4003eurp_";
	type="multipart/alternative"

--_004_AM0PR06MB40030B857FF08F8B7685563FE64D0AM0PR06MB4003eurp_
Content-Type: multipart/alternative;
	boundary="_000_AM0PR06MB40030B857FF08F8B7685563FE64D0AM0PR06MB4003eurp_"

--_000_AM0PR06MB40030B857FF08F8B7685563FE64D0AM0PR06MB4003eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all!

I'm struggling to get userspace tracing working on an aarch64 platform (bus=
ybox on top of Linux 5.4.24 kernel). I followed the guidelines in the docs =
and am currently using this example program for testing: https://github.com=
/lttng/lttng-ust/tree/master/doc/examples/hello-static-lib
I cross-compiled lttng-ust and that example, but when I run the following c=
ommands on the platform no traces are recorded. If I use the same example o=
n my x86 machine everything works as expected. (And kernelspace tracing is =
working on that aarch64 system.)

Any hints where I could start investigating the issue are welcome.

Regards,
Moritz

~ # pwd
/root
~ # lttng create
Spawning a session daemon
Session auto-20200720-174509 created.
Traces will be written in /root/lttng-traces/auto-20200720-174509
~ # lttng enable-event -au
All UST events are enabled in channel channel0
~ # lttng start
Tracing started for session auto-20200720-174509
~ # ./hello
Hello, World!
Tracing...  done.
~ # lttng destroy
Session auto-20200720-174509 destroyed
~ # ll
total 40
-rwxr-xr-x    1 root     root         39280 Jul 20 17:44 hello*



Moritz Pflanzer
Software Development Engineer

[cid:image001.png@01D3BF6E.185110B0]

R=E4ffelstrasse 28

8045 Z=FCrich
E: moritz.pflanzer@hexagon.com<mailto:moritz.pflanzer@hexagon.com><mailto:c=
arolin.siebert@hexagon.com>
W: http://www.hexagongeosystems.com

--_000_AM0PR06MB40030B857FF08F8B7685563FE64D0AM0PR06MB4003eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi all!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I'm struggling to get userspace tracing working on an aarch64 platform (bus=
ybox on top of Linux 5.4.24 kernel). I followed the guidelines in the docs =
and am currently using this example program for testing:
<a href=3D"https://github.com/lttng/lttng-ust/tree/master/doc/examples/hell=
o-static-lib" id=3D"LPlnk712650">
https://github.com/lttng/lttng-ust/tree/master/doc/examples/hello-static-li=
b</a><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I cross-compiled lttng-ust and that example, but when I run the following c=
ommands on the platform no traces are recorded. If I use the same example o=
n my x86 machine everything works as expected. (And kernelspace tracing is =
working on that aarch64 system.)<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Any hints where I could start investigating the issue are welcome.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Moritz<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div>~ # pwd</div>
<div>/root</div>
~ # lttng create
<div>Spawning a session daemon</div>
<div>Session auto-20200720-174509 created.</div>
<div>Traces will be written in /root/lttng-traces/auto-20200720-174509</div=
>
<div>~ # lttng enable-event -au</div>
<div>All UST events are enabled in channel channel0</div>
<div>~ # lttng start</div>
<div>Tracing started for session auto-20200720-174509</div>
<div>~ # ./hello </div>
<div>Hello, World!</div>
<div>Tracing... &nbsp;done.</div>
<div>~ # lttng destroy</div>
<div>Session auto-20200720-174509 destroyed</div>
<div>~ # ll</div>
<div>total 40</div>
<div>-rwxr-xr-x &nbsp; &nbsp;1 root &nbsp; &nbsp; root &nbsp; &nbsp; &nbsp;=
 &nbsp; 39280 Jul 20 17:44 hello*</div>
<br>
</div>
<div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Helvetica,sans-serif">
<p class=3D"x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;"><sp=
an style=3D"font-size:10pt; font-family:&quot;Arial&quot;,sans-serif,serif,=
&quot;EmojiFont&quot;" lang=3D"EN-US"><br>
</span></p>
<p class=3D"x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;"><b>=
<span style=3D"font-size:10pt; font-family:&quot;Arial&quot;,sans-serif,ser=
if,&quot;EmojiFont&quot;; color:gray">Moritz Pflanzer</span></b><span style=
=3D"font-size:10pt; font-family:&quot;Arial&quot;,sans-serif,serif,&quot;Em=
ojiFont&quot;; color:gray"><br>
Software Development Engineer<br>
</span><u><span style=3D"font-size:10pt; font-family:&quot;Arial&quot;,sans=
-serif,serif,&quot;EmojiFont&quot;; color:rgb(0,130,191)"><br>
</span></u><span style=3D""><img class=3D"EmojiInsert" id=3D"OWAPstImg32830=
3" alt=3D"cid:image001.png@01D3BF6E.185110B0" style=3D"width:2.0833in; heig=
ht:0.6458in" width=3D"200" height=3D"62" data-outlook-trace=3D"F:1|T:1" src=
=3D"cid:6f38b333-ccc0-4343-bf38-1e4c24868a24"></span><u><span style=3D"font=
-size:10pt; font-family:&quot;Arial&quot;,sans-serif,serif,&quot;EmojiFont&=
quot;; color:rgb(0,130,191)"></span></u></p>
<p class=3D"x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;"><sp=
an style=3D"font-size:10pt; font-family:&quot;Arial&quot;,sans-serif,serif,=
&quot;EmojiFont&quot;; color:gray"><br>
R=E4ffelstrasse 28</span></p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;margin-top:0; margin-bottom=
:0"><span style=3D"font-size:10pt; font-family:&quot;Arial&quot;,sans-serif=
,serif,&quot;EmojiFont&quot;; color:gray">8045 Z=FCrich<b><br>
</b><b>E: </b><a href=3D"mailto:moritz.pflanzer@hexagon.com" class=3D"OWAAu=
toLink"><span style=3D"color:rgb(0,111,201)">moritz.pflanzer@hexagon.com</s=
pan></a><b></b></span><span style=3D""><a href=3D"mailto:carolin.siebert@he=
xagon.com" target=3D"_blank" rel=3D"noopener noreferrer"><span style=3D"fon=
t-size:10pt; font-family:&quot;Arial&quot;,sans-serif,serif,&quot;EmojiFont=
&quot;; color:rgb(5,99,193)"></span></a></span><b><span style=3D"font-size:=
10pt; font-family:&quot;Arial&quot;,sans-serif,serif,&quot;EmojiFont&quot;;=
 color:gray"><br>
W: </span></b><span style=3D""><a href=3D"http://www.hexagongeosystems.com"=
 target=3D"_blank" rel=3D"noopener noreferrer"><span style=3D"font-size:10p=
t; font-family:&quot;Arial&quot;,sans-serif,serif,&quot;EmojiFont&quot;; co=
lor:rgb(5,99,193)">http://www.hexagongeosystems.com</span></a></span><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_AM0PR06MB40030B857FF08F8B7685563FE64D0AM0PR06MB4003eurp_--

--_004_AM0PR06MB40030B857FF08F8B7685563FE64D0AM0PR06MB4003eurp_
Content-Type: image/png; name="Outlook-cid_image0.png"
Content-Description: Outlook-cid_image0.png
Content-Disposition: inline; filename="Outlook-cid_image0.png"; size=5901;
	creation-date="Mon, 03 Aug 2020 09:35:25 GMT";
	modification-date="Mon, 03 Aug 2020 09:35:25 GMT"
Content-ID: <6f38b333-ccc0-4343-bf38-1e4c24868a24>
Content-Transfer-Encoding: base64

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

--_004_AM0PR06MB40030B857FF08F8B7685563FE64D0AM0PR06MB4003eurp_--

--===============4328617327267883582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4328617327267883582==--
