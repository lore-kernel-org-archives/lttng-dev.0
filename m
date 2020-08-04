Return-Path: <SRS0=h30u=BO=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20666C433E3
	for <lttng-dev@archiver.kernel.org>; Tue,  4 Aug 2020 08:15:15 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE9A42076C
	for <lttng-dev@archiver.kernel.org>; Tue,  4 Aug 2020 08:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="GHaqHOxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9A42076C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BLSH51LFWz1nP3;
	Tue,  4 Aug 2020 04:15:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1596528913;
	bh=2+SbCtWg7HflqTf5sXiLOfu0CpgiVqzRexLriAvnKQI=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GHaqHOxRsVSZ/kS6C6Q+MiZIB82pNw5nkcPapwMUzlPtfxeqhDnzTkgRvrEwdePPS
	 0LUk9JMCG9dkLj3YFzZSFzNmM2sYncBuzMtBPAQmS28tuY/me6bR89T8Yg44h/90/k
	 k7FnfJHejI5o9C7Aga8c8z7/9bzTboGDFlPJZD+zOJ1Fa88YiDJmf8ncQdTPz+L0zb
	 27M5Ue1TfwIxz/QjgHDItokhkrUKU3MchG7xP5zn6pPZAf7cAZQKKcJ96vq5yS3sCr
	 SMbxlfCBwbClcgYjeho9H6eGZaq5E6M0VUjji83ihHUFvI0vknNnAxUZCCsvIoZ6pL
	 42G6kdmT5rECg==
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70095.outbound.protection.outlook.com [40.107.7.95])
 by lists.lttng.org (Postfix) with ESMTPS id 4BLSH31tzVz1nRP
 for <lttng-dev@lists.lttng.org>; Tue,  4 Aug 2020 04:15:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJUfJ9NoJTbWcuLaw7+xs+4DAxvilBwEWC5ZNHEQBl9kjqWdqkluomj7gb9a/HlnPPZeAifTf6zYZHPA2WMMW0qkeq8zDnVoW/SUzRNEqoINVqckSt3Qsh20JosjZOVcqSVWBuNNTaDL1ZMXgRqaB6z+CRPe98xlsmjS0gTbT7+hw6Sl/3NFHGfcwfQ0CVEoBA/iBwIv5Yuqm4otZ90p+22NZudD3L+0tN6nBDMFhZ0NCgZZnCDKqrMc9iG8CJtf/mA1NqFMsOKMxCNjPHYPCmGi/zvwwyLjY5HYoaC3T4og0D5i3oN0vc09J5rc6Bu6N9otLAnIO/N8UKmoVfE7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0tZ6XGkDwPN70AS+3dZddNAi5EEgvb4/FeQs/ESfFc=;
 b=Mvd2s2xoOMJClZvPT4UI2yniTQWzpgy8BuR3BWXlmFyvhE9mmTcOmeBfzg30fZSVHyfGCLGvAscAmntnlcKNvCKX20f6HD82DwhtjkSg2mehVHiy1E9qfIWAzs0YhYG0zglzDC6XN2yiN3XiBc4B3fUxpiOpgv7XnZ5H7lCKhtnLSEV2wdxz/7sD6uCQQ/AntSrI0iM9Cz86sOkdKmV7aVLsEsL1r3PvrVBsb0jOIhtQGmgsUdLf4JIok7Akq7IrBE6vGd0S5ygPTiTszn5dd4MCv5fFhA7boGneFSfc7jE2S24e9lA5ZvJCJOydkhhTw4T8JbiGUQIfKBdlPLa+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hexagon.com; dmarc=pass action=none header.from=hexagon.com;
 dkim=pass header.d=hexagon.com; arc=none
Received: from AM0PR06MB4003.eurprd06.prod.outlook.com (2603:10a6:208:b0::15)
 by AM0PR06MB4545.eurprd06.prod.outlook.com (2603:10a6:208:f1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Tue, 4 Aug
 2020 08:15:08 +0000
Received: from AM0PR06MB4003.eurprd06.prod.outlook.com
 ([fe80::7406:e48e:2388:a6f4]) by AM0PR06MB4003.eurprd06.prod.outlook.com
 ([fe80::7406:e48e:2388:a6f4%6]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 08:15:08 +0000
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] Help needed: No UST events recorded
Thread-Index: AQHWaXO/Sy0OYhQYf0G0q2MMQYLGA6kmg4iAgAEUcSU=
Date: Tue, 4 Aug 2020 08:15:08 +0000
Message-ID: <AM0PR06MB4003488DDC4A6809047ECA02E64A0@AM0PR06MB4003.eurprd06.prod.outlook.com>
References: <AM0PR06MB40030B857FF08F8B7685563FE64D0@AM0PR06MB4003.eurprd06.prod.outlook.com>,
 <20200803153155.GA207972@joraj-alpa>
In-Reply-To: <20200803153155.GA207972@joraj-alpa>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [81.221.214.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5625d38-1a9a-4d50-5ee0-08d8384e8045
x-ms-traffictypediagnostic: AM0PR06MB4545:
x-microsoft-antispam-prvs: <AM0PR06MB4545406DB20D7B757265B00AE64A0@AM0PR06MB4545.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 154yCUZH0XnzAFbffSRHTlminwUbb+ymOZH5TkEH0ClWEoS7PGJ3+KhFqusjfLiua/Qq7lvdObTasZAAoHhxnNNclvV2Yjlx5s4zDS7ewQA7Z+SPXJamuoUHt1IV5Ybi036qClipvR0YZqpp6fbJuOSJ1c43f6Be1rHvC07gQMFS/h6LzxlJ8zzKOeS3XV2fGQQa+gXcJE9sjrAbwie0Xm5dB7i+9VzWRwlgrATczyktrZzNF3QHQEmEHPUmxCnRgIRW6Qu5KDHoaz08RxM56M+JSCAQ4dN6EKqsf5GydM4fL0AACsmwwXBwenMdU7i5fVPbXZ+9wDdXi6G1EyXiyKRiE+Vmy0km+PccPu5F/CHxGj8YQ62TjeRedS/vKue4N3cS4wDEv+364/V0m4PuDJQqm0pk07VWcYHkTOE8ZgrO4JxraXpF+erOFOLHtXOOHx6G3So0NxnAz9qCGtwGyg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR06MB4003.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(71200400001)(66616009)(66556008)(26005)(52536014)(64756008)(5660300002)(6506007)(99936003)(33656002)(186003)(66946007)(166002)(76116006)(53546011)(316002)(66476007)(66446008)(83380400001)(19627235002)(966005)(6916009)(8936002)(7696005)(19627405001)(86362001)(45080400002)(4326008)(478600001)(8676002)(55016002)(2906002)(9686003)(10126625002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: fLke6gyK0N+1Vk6TJwrNZYq3B5RJ0pYbD8HUgmSHsmwZOI5vwC3faT+qqZ1TouWp/503WNKdLx77vu/CNYJmU5oggt7FFha8feO2rCrys+/SmrUmhaFpL3TIx9WfjnDmxf5vGHx7rgQRyi48io89LPLbhvz9KPIsWvTiiAQoCmSF6LS5zXpN7oYK9gijFPgl0TAOcn2+Skcu6PkAIbTVvJJF54dNGEvLwWGBDWL4R8l2DmQuj7fkBJ6xVD6ka8J/DjHbOc6iH97QzMfZGVmfCzsKSIaVrmposUn56duWP5JT+/fZhNQ3JwHxFLwASmYAcd7Cdx3Tjnj8b3aCBlI6+Ma6+sEn2agb62t9HSMhRpU08qocBO+BagbXJbX0DBIPdfmuT5G9QBr0HTevJTJ5eC/PKx0m435KPAQAnCnuPHN6k1CqEsy9GdhoohQeuaR3iLrtCX2dGaVQ1aInmOhNpZqkom+v5oboSoKS0+JLLF+tAghwpcourJ/d5VOGH+8ZOw1aNIqrIww8Zd/oBLICdIdzXdB8l4MZ8QjYkF3O5fGVMA/qBol4XIttVDeOwxKYZ8uqs0OxPxMzN2nfWVGCbNaP2Dc1AoOrTemFt3oUc5dJbJ556/pqPpmfMKjkzVj9lJn01DITOOOJCDiSL1lWBQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hexagon.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB4003.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5625d38-1a9a-4d50-5ee0-08d8384e8045
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 08:15:08.2850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zI1E24wPgiNaCG7Hw/0ka9sof4KkoxPiY8KQe2ioZmJOCcqhh+2uOj+MJo1lPHSJ68itcQODT0pjnOQmxBJUM9OF5xy0nN+6R6ksWeSIdok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB4545
Subject: Re: [lttng-dev] Help needed: No UST events recorded
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
Content-Type: multipart/mixed; boundary="===============6553190304240260713=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6553190304240260713==
Content-Language: en-GB
Content-Type: multipart/related;
	boundary="_004_AM0PR06MB4003488DDC4A6809047ECA02E64A0AM0PR06MB4003eurp_";
	type="multipart/alternative"

--_004_AM0PR06MB4003488DDC4A6809047ECA02E64A0AM0PR06MB4003eurp_
Content-Type: multipart/alternative;
	boundary="_000_AM0PR06MB4003488DDC4A6809047ECA02E64A0AM0PR06MB4003eurp_"

--_000_AM0PR06MB4003488DDC4A6809047ECA02E64A0AM0PR06MB4003eurp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Apologies that I forgot to mention which version of LTTng I'm using. I didn=
't build from master but downloaded the latest release archives for LTTng 2=
.12 "(Ta) Meilleure". "lttng --version" reports a corresponding "lttng (LTT=
ng Trace Control) 2.12.1 - (Ta) Meilleure"

Please find the console log here: https://pastebin.com/PVzqrPvr
and the lttng-sessiond.log here: https://pastebin.com/g3aXAcQg

Thanks,
Moritz



Moritz Pflanzer
Software Development Engineer

[cid:image001.png@01D3BF6E.185110B0]

R=E4ffelstrasse 28

8045 Z=FCrich
E: moritz.pflanzer@hexagon.com<mailto:moritz.pflanzer@hexagon.com><mailto:c=
arolin.siebert@hexagon.com>
W: http://www.hexagongeosystems.com

________________________________
From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Sent: 03 August 2020 17:31
To: PFLANZER Moritz <moritz.pflanzer@hexagon.com>
Cc: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] Help needed: No UST events recorded

This email is not from Hexagon=92s Office 365 instance. Please be careful w=
hile clicking links, opening attachments, or replying to this email.


Hi Moritz

What is your version of lttng-tools?

  lttng --version

Please run the `hello` executable using the LTTNG_UST_DEBUG env variable, w=
hile
tracing, and provide the output.

  pkill lttng-sessiond
  lttng-sessiond -b -vvv --verbose-consumer 2> /tmp/lttng-sessiond.log
  lttng create
  lttng enable-event -u -a
  lttng start
  LTTNG_UST_DEBUG=3Dy ./hello
  lttng stop
  lttng destroy
  pkill lttng-sessiond

Please also provide the /tmp/lttng-sessiond.log file via pastebin.

I suspect that if you cross-compiled lttng-ust from the master branch that
lttng-tools is not using the same version, resulting in the application not
being able to register to the lttng-sessiond.

Cheers

On Mon, Aug 03, 2020 at 09:35:25AM +0000, PFLANZER Moritz via lttng-dev wro=
te:
> Hi all!
>
> I'm struggling to get userspace tracing working on an aarch64 platform (b=
usybox on top of Linux 5.4.24 kernel). I followed the guidelines in the doc=
s and am currently using this example program for testing: https://eur02.sa=
felinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2Flttng%2Flt=
tng-ust%2Ftree%2Fmaster%2Fdoc%2Fexamples%2Fhello-static-lib&amp;data=3D02%7=
C01%7C%7Ce141a6eb68ea4d4c93c508d837c25b99%7C1b16ab3eb8f64fe39f3e2db7fe549f6=
a%7C0%7C0%7C637320655210160415&amp;sdata=3DlPbFWob0G4U22ncUmqfz12Ha42xOymct=
YWCOJC34oC8%3D&amp;reserved=3D0
> I cross-compiled lttng-ust and that example, but when I run the following=
 commands on the platform no traces are recorded. If I use the same example=
 on my x86 machine everything works as expected. (And kernelspace tracing i=
s working on that aarch64 system.)
>
> Any hints where I could start investigating the issue are welcome.
>
> Regards,
> Moritz
>
> ~ # pwd
> /root
> ~ # lttng create
> Spawning a session daemon
> Session auto-20200720-174509 created.
> Traces will be written in /root/lttng-traces/auto-20200720-174509
> ~ # lttng enable-event -au
> All UST events are enabled in channel channel0
> ~ # lttng start
> Tracing started for session auto-20200720-174509
> ~ # ./hello
> Hello, World!
> Tracing...  done.
> ~ # lttng destroy
> Session auto-20200720-174509 destroyed
> ~ # ll
> total 40
> -rwxr-xr-x    1 root     root         39280 Jul 20 17:44 hello*
>
>
>
> Moritz Pflanzer
> Software Development Engineer
>
> [cid:image001.png@01D3BF6E.185110B0]
>
> R=E4ffelstrasse 28
>
> 8045 Z=FCrich
> E: moritz.pflanzer@hexagon.com<mailto:moritz.pflanzer@hexagon.com><mailto=
:carolin.siebert@hexagon.com>
> W: http://www.hexagongeosystems.com/



> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev&amp;data=3D02%7C01%7C=
%7Ce141a6eb68ea4d4c93c508d837c25b99%7C1b16ab3eb8f64fe39f3e2db7fe549f6a%7C0%=
7C0%7C637320655210160415&amp;sdata=3DbH0laqzT2Hl5nQw1qTxubC6PMyzsthqYZ5gOa4=
VyxAA%3D&amp;reserved=3D0


--
Jonathan Rajotte-Julien
EfficiOS

--_000_AM0PR06MB4003488DDC4A6809047ECA02E64A0AM0PR06MB4003eurp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Jonathan,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Apologies that I forgot to mention which version of LTTng I'm using. I didn=
't build from master but downloaded the latest release archives for LTTng 2=
.12 &quot;(Ta) Meilleure&quot;. &quot;lttng --version&quot; reports a corre=
sponding &quot;lttng (LTTng Trace Control) 2.12.1 - (Ta)
 Meilleure&quot;<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please find the console log here: <a href=3D"https://pastebin.com/PVzqrPvr"=
 id=3D"LPNoLPOWALinkPreview_0">
https://pastebin.com/PVzqrPvr</a><br>
</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview_0 _EReadonl=
y_1"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
and the lttng-sessiond.log here: <a href=3D"https://pastebin.com/g3aXAcQg" =
id=3D"LPNoLPOWALinkPreview_1">
https://pastebin.com/g3aXAcQg</a><br>
</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview_1 _EReadonl=
y_1"></div>
<br>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Moritz<br>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top: 0px; margin-bottom: 0px;margin-top:0; margin-bottom=
:0"></p>
<p class=3D"x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;"><sp=
an style=3D"font-size:10pt; font-family:&quot;Arial&quot;,sans-serif,serif,=
&quot;EmojiFont&quot;" lang=3D"EN-US"><br>
</span></p>
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
=3D"cid:b9f0d510-265b-4b18-826c-f8669edaf371"></span><u><span style=3D"font=
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
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jonathan Rajotte-Juli=
en &lt;jonathan.rajotte-julien@efficios.com&gt;<br>
<b>Sent:</b> 03 August 2020 17:31<br>
<b>To:</b> PFLANZER Moritz &lt;moritz.pflanzer@hexagon.com&gt;<br>
<b>Cc:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Subject:</b> Re: [lttng-dev] Help needed: No UST events recorded</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This email is not from Hexagon=92s Office 365 inst=
ance. Please be careful while clicking links, opening attachments, or reply=
ing to this email.<br>
<br>
<br>
Hi Moritz<br>
<br>
What is your version of lttng-tools?<br>
<br>
&nbsp; lttng --version<br>
<br>
Please run the `hello` executable using the LTTNG_UST_DEBUG env variable, w=
hile<br>
tracing, and provide the output.<br>
<br>
&nbsp; pkill lttng-sessiond<br>
&nbsp; lttng-sessiond -b -vvv --verbose-consumer 2&gt; /tmp/lttng-sessiond.=
log<br>
&nbsp; lttng create<br>
&nbsp; lttng enable-event -u -a<br>
&nbsp; lttng start<br>
&nbsp; LTTNG_UST_DEBUG=3Dy ./hello<br>
&nbsp; lttng stop<br>
&nbsp; lttng destroy<br>
&nbsp; pkill lttng-sessiond<br>
<br>
Please also provide the /tmp/lttng-sessiond.log file via pastebin.<br>
<br>
I suspect that if you cross-compiled lttng-ust from the master branch that<=
br>
lttng-tools is not using the same version, resulting in the application not=
<br>
being able to register to the lttng-sessiond.<br>
<br>
Cheers<br>
<br>
On Mon, Aug 03, 2020 at 09:35:25AM +0000, PFLANZER Moritz via lttng-dev wro=
te:<br>
&gt; Hi all!<br>
&gt;<br>
&gt; I'm struggling to get userspace tracing working on an aarch64 platform=
 (busybox on top of Linux 5.4.24 kernel). I followed the guidelines in the =
docs and am currently using this example program for testing:
<a href=3D"https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fgithub.com%2Flttng%2Flttng-ust%2Ftree%2Fmaster%2Fdoc%2Fexamples%2Fhello=
-static-lib&amp;amp;data=3D02%7C01%7C%7Ce141a6eb68ea4d4c93c508d837c25b99%7C=
1b16ab3eb8f64fe39f3e2db7fe549f6a%7C0%7C0%7C637320655210160415&amp;amp;sdata=
=3DlPbFWob0G4U22ncUmqfz12Ha42xOymctYWCOJC34oC8%3D&amp;amp;reserved=3D0">
https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.=
com%2Flttng%2Flttng-ust%2Ftree%2Fmaster%2Fdoc%2Fexamples%2Fhello-static-lib=
&amp;amp;data=3D02%7C01%7C%7Ce141a6eb68ea4d4c93c508d837c25b99%7C1b16ab3eb8f=
64fe39f3e2db7fe549f6a%7C0%7C0%7C637320655210160415&amp;amp;sdata=3DlPbFWob0=
G4U22ncUmqfz12Ha42xOymctYWCOJC34oC8%3D&amp;amp;reserved=3D0</a><br>
&gt; I cross-compiled lttng-ust and that example, but when I run the follow=
ing commands on the platform no traces are recorded. If I use the same exam=
ple on my x86 machine everything works as expected. (And kernelspace tracin=
g is working on that aarch64 system.)<br>
&gt;<br>
&gt; Any hints where I could start investigating the issue are welcome.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Moritz<br>
&gt;<br>
&gt; ~ # pwd<br>
&gt; /root<br>
&gt; ~ # lttng create<br>
&gt; Spawning a session daemon<br>
&gt; Session auto-20200720-174509 created.<br>
&gt; Traces will be written in /root/lttng-traces/auto-20200720-174509<br>
&gt; ~ # lttng enable-event -au<br>
&gt; All UST events are enabled in channel channel0<br>
&gt; ~ # lttng start<br>
&gt; Tracing started for session auto-20200720-174509<br>
&gt; ~ # ./hello<br>
&gt; Hello, World!<br>
&gt; Tracing...&nbsp; done.<br>
&gt; ~ # lttng destroy<br>
&gt; Session auto-20200720-174509 destroyed<br>
&gt; ~ # ll<br>
&gt; total 40<br>
&gt; -rwxr-xr-x&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39280 Jul 20 17:44 hello*<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Moritz Pflanzer<br>
&gt; Software Development Engineer<br>
&gt;<br>
&gt; [cid:image001.png@01D3BF6E.185110B0]<br>
&gt;<br>
&gt; R=E4ffelstrasse 28<br>
&gt;<br>
&gt; 8045 Z=FCrich<br>
&gt; E: moritz.pflanzer@hexagon.com&lt;mailto:moritz.pflanzer@hexagon.com&g=
t;&lt;mailto:carolin.siebert@hexagon.com&gt;<br>
&gt; W: <a href=3D"http://www.hexagongeosystems.com/">http://www.hexagongeo=
systems.com/</a><br>
<br>
<br>
<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; <a href=3D"https://eur02.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev&amp;amp=
;data=3D02%7C01%7C%7Ce141a6eb68ea4d4c93c508d837c25b99%7C1b16ab3eb8f64fe39f3=
e2db7fe549f6a%7C0%7C0%7C637320655210160415&amp;amp;sdata=3DbH0laqzT2Hl5nQw1=
qTxubC6PMyzsthqYZ5gOa4VyxAA%3D&amp;amp;reserved=3D0">
https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.l=
ttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev&amp;amp;data=3D02%7C01%=
7C%7Ce141a6eb68ea4d4c93c508d837c25b99%7C1b16ab3eb8f64fe39f3e2db7fe549f6a%7C=
0%7C0%7C637320655210160415&amp;amp;sdata=3DbH0laqzT2Hl5nQw1qTxubC6PMyzsthqY=
Z5gOa4VyxAA%3D&amp;amp;reserved=3D0</a><br>
<br>
<br>
--<br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM0PR06MB4003488DDC4A6809047ECA02E64A0AM0PR06MB4003eurp_--

--_004_AM0PR06MB4003488DDC4A6809047ECA02E64A0AM0PR06MB4003eurp_
Content-Type: image/png; name="Outlook-cid_image0.png"
Content-Description: Outlook-cid_image0.png
Content-Disposition: inline; filename="Outlook-cid_image0.png"; size=5901;
	creation-date="Tue, 04 Aug 2020 08:15:07 GMT";
	modification-date="Tue, 04 Aug 2020 08:15:07 GMT"
Content-ID: <b9f0d510-265b-4b18-826c-f8669edaf371>
Content-Transfer-Encoding: base64

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

--_004_AM0PR06MB4003488DDC4A6809047ECA02E64A0AM0PR06MB4003eurp_--

--===============6553190304240260713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6553190304240260713==--
