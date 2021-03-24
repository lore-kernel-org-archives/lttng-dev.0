Return-Path: <SRS0=fpp6=IW=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DC1C433C1
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 14:14:15 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E774E61962
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 14:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E774E61962
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F59GD1JCVzM6H;
	Wed, 24 Mar 2021 10:14:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1616595252;
	bh=BSC+ZvzbRwa761/YkyfsN+/w6t1GBvtFrD6OPHQH9to=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=dUqnbmZlLQczS6iLzc+mX52KxcS1Ozj+1CRID/VNfyyoHJSq+2ZjmbA+Yp3OAyOnX
	 dMI/WPwd5Z8BXCKzOqD4+5t4oueKgxUOpDefQd3qvnsS7MRFuQial4+PQilalWgni4
	 tys0jep9BfnqWRqPsDJmS1/PXZKUhvVfJ0TYXNkk+u5CPPN0S/uhSMM8AKaqwwUkjm
	 pmvj5yG+DTRBtiGAUxl7h0tjbGKlGfwCnj5bMaantmX/uxQHHrON2/5cZsO/cE6xxm
	 Y6kykWL3Hl9eDqHQmMJfRw5ptUvy+HGSk7JE4D8X2DjW2/WizeiUvWMOSxhFymj6nD
	 1RE5lp9k7b8cQ==
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60065.outbound.protection.outlook.com [40.107.6.65])
 by lists.lttng.org (Postfix) with ESMTPS id 4F55bl2PHTzMLH
 for <lttng-dev@lists.lttng.org>; Wed, 24 Mar 2021 07:29:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtSjHnARKtNLC/yeyuBrCRnDiSZCwWcqeeF12bBmey2xfU9w2ihcb/32bCF4fzi3C9E5n3IXvLLHudH79SraqtVJLn5GGJRF3To0rOK1x93pxg9vBWimUkj+YW+nH2ynoetaqr0/ZrmROZZOBpRvpTEh+4Ed+kHHaOLgJ5Vw2spYVrND/xn/zIRiLqifyWc4198mL20rrVKscqLug0EagU3f6gG5ry2GIminAuNYO1/WXJK4kNrM5dpaFdiZMO0fogAHbokNfp7KydzYiucRTxRyE3oMrnHs7dzm4IG+gXyHpCg434DxPzcFmoueQ9DD3+75p1Axmwwq1ZWgtOr1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Px+drE20MQ76/GYQ2nzrU4w7n6WlLSRoGf6xe+KdeI=;
 b=QI7NDWdwpu6gnDqkstJPXFF4clM1ksjYII3OKNpJ29Z4TmbTt3KWs+mu/HDFcvz+tfdyJAuUPZ1TRRJ1NRAgEygeE2GOPnknYP7zideuyF8xHKOBpZNiFQ3qq/PS1gGID0xyFQniyfTIuYVIRXbTyNFNJ0EJ8CFZQ+9RzQKSQ2RwZASiGZVRvhYX6LSPYIkt4TMWydvKa3x5xTJTSbeMwLFsAB1zHMVcFWSlp/iLKzx0tsgrQeeJ/dmxvqj3b9dIcUVdzirss5s0hmeOioJBVIBNfa06qHT/UdDe8iw+jZR579Bw4a9XY3HPG1P8jYbE1K4vhY/UVotuOBgHZUbg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reseau.eseo.fr; dmarc=pass action=none
 header.from=reseau.eseo.fr; dkim=pass header.d=reseau.eseo.fr; arc=none
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com (2603:10a6:102:63::15)
 by PR3PR02MB6458.eurprd02.prod.outlook.com (2603:10a6:102:70::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 11:29:04 +0000
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::9183:a57e:a921:f482]) by PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::9183:a57e:a921:f482%7]) with mapi id 15.20.3977.025; Wed, 24 Mar 2021
 11:29:04 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Issues on basic LTTng trace userspace (tutorial)
Thread-Index: AQHXIJ8+s4nBMhgB0EaYFg2Q2oJLGQ==
Date: Wed, 24 Mar 2021 11:29:04 +0000
Message-ID: <PR3PR02MB62023431654FB93182EA21A1D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.20.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cfedaa2-a498-4575-65da-08d8eeb80793
x-ms-traffictypediagnostic: PR3PR02MB6458:
x-microsoft-antispam-prvs: <PR3PR02MB6458993BD1059E5C95705C34D1639@PR3PR02MB6458.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FCLVc1WRuUk6/lkQhPFb5B1HqtcYDqxGtKCc3FgplgZ7HwUvDEAkYSmfMmKduOLXRCVep6V/od3wb1oSH83UPVBA1+ZcqZbyF/PUa2ybadx9JU5cWI+Tdp72O2SRtyoY+e7Jd6+GphikTZmr+CJnS1Y9W0i6yo+2lDtfSf8xEM5LcvcMW/VoYst3+DcZdCiF4ygEEmv73mHPxQokeTfvHv+X6HjgVh+YmZvxjoS87UeKTgG94kkbnVPvy+1Gr88pEkFo8asSIZLW8BCjRZBhMCxe8wWl0uy57OzuVmTv4CgZkbjBGTuxpNR0frSZ/LeVhY5sViHCzBZGPkTzSaAAELu1viyqvJrMUnTXj6WRDUZm3z0Pk3B47vVcOJaAfLMJIOK7krXF4qnmyDpkbIYSmJSOOYdi//Uxei0wX2IPmpLfzbYJQV1hW3Tz1kS1tHrWtVeB6CBb3aukPbbj4pL6FqQfpXsm/3bXPIWrMHDOXwPe0g2uhzVB4JNRy/yBn+Ge4McFOh+cqvALbP2dzxxdbV7AR442pkbeom6JiPo5nQHC8q87yE3CQEmU1GKO9inUfYR+OOdx4tvEjpul3cycHAkXpuiLxBjpwLH+iBW3rEh9XjHm6m5UCs+UPGJT0gZlORrKqXsLQVXsEBogULgQYYA9s3up2opUbDo+0ZKQTe3bRvv2o6U4Xlt2ge/GjNKRf3SmmnoxJRSoKCTSrTenDADS3I2WhIdbthr6fwIxr2Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3PR02MB6202.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39850400004)(396003)(136003)(366004)(26005)(86362001)(71200400001)(966005)(76116006)(66946007)(66446008)(99936003)(316002)(66576008)(478600001)(5660300002)(186003)(2906002)(64756008)(66556008)(66476007)(786003)(55016002)(9686003)(7696005)(8936002)(6916009)(38100700001)(55236004)(33656002)(4744005)(52536014)(19627405001)(166002)(8676002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?vQsqV8salm1Updq9IuDepPbgoxbXJyeNMy98N/G0M18Ncw5mxnFQYGa9Xw?=
 =?iso-8859-1?Q?0YmJQYjmSVShTNoOV/LSjebLR5fhK6zrZxYNtL6L0li6njaGTSNntZ4u53?=
 =?iso-8859-1?Q?TcWwIFVQUnwzJwNNEv99hhqDsatuanDRDjGGqo9D+RSLrEAM1iu/0CJvoK?=
 =?iso-8859-1?Q?di/eozcy3rNJG9yQ2Iz8XhDO4WBoj6zc2dvBHOFAu2RIPbTMQLzKuNLIDN?=
 =?iso-8859-1?Q?KVnEhHHH+trf+3vjCrJFac4o8g4xDeTM8svOJAtOHkTNHIA7Z96Ny4P2O9?=
 =?iso-8859-1?Q?weAK28wEKX3skJUgwgm9uiCf23qL94UjqseDuthE3srLobAif4EXOYkcvl?=
 =?iso-8859-1?Q?gjHQv+xKJu1jhahR0zgBtm/KYAFQx/O/QRn0AGUZzoqDTFzA4SUIoMK0GH?=
 =?iso-8859-1?Q?TRq6/oFcT8s3iDV4kEOsa7qZQR0lJy2ns0kl6UPJG9o2GVY5oXGVKw4SWm?=
 =?iso-8859-1?Q?jp+VMpr4rSiaFnbWGQuQAUUilowyuXB3vLlLQJMDoEX104PlcCEtyOYz0/?=
 =?iso-8859-1?Q?bj2UNo8VJCF6NakB8L0V7/0pyXvimVUNSvTf1gEKQ5ot0o+bF/uX3DHcTL?=
 =?iso-8859-1?Q?z4kNux0h24PWio0lF3QEa8oHuS6LH/kR6bMe9rNFyuNItMvVIVNU1l5JCH?=
 =?iso-8859-1?Q?iQG83WSp4mJZFuCeaMw/kGDYfRYN2CCcDhFNSShAoCxSukx81201Mbup3d?=
 =?iso-8859-1?Q?UD3j+D3UgeLhmIMrUannQHkjRaXyONK/1GKw+twc0paFYZuEcJ9/dRSkpm?=
 =?iso-8859-1?Q?U+PhQzpU0ILqebTXrfmlWmZ/KUKawY4A18+d9lBTTPbmZFr4PBktxsva6i?=
 =?iso-8859-1?Q?A0yd5IuUvl7kSusHMnSFZwtF3uiW6zbk3jbxbQkgOWGZfM/NfgoW6utCha?=
 =?iso-8859-1?Q?yYg4HTa2UG3nFEUC/t82GOPfbCv7Tc8cwY0DE/ZShz/pbeTJnIcQQuTSgN?=
 =?iso-8859-1?Q?1IBpNg7Jwy6hmNl2+vxOAHjqrx00I8djjsvj2a7Qe6oGwPHbt9IJTw1r67?=
 =?iso-8859-1?Q?kQNyKk5PPYUpx7HGYvxLRfKWaVNfEPkFgxs5+7GhxaV8Kd/3x4TwGDz5B/?=
 =?iso-8859-1?Q?IkOUsIkoc19NhAkkZ7JHdKfZzcCeiNSwE41AKGsOugcHEUQW6PlKGQI0P1?=
 =?iso-8859-1?Q?AvfERHjDkPMwMV8JikVPplTkDMUDaATF2gUwrG8/LcB1LkeJXYUo4ypLCw?=
 =?iso-8859-1?Q?UTrzCUun7jhbHQcQQKUltoPWS/ntDxwe9P5OHZ7soOaoWWqMUU3XTLf7DH?=
 =?iso-8859-1?Q?iS4y+r7wGRCmEY8KTK9rPrEWJDzf/7YRkfxmrVa/cifzLAOqeTz1TQDqAX?=
 =?iso-8859-1?Q?OR5a100mSOAcXCWjSfApj0Y9nguRojUobtTWT6yv8quvwLw=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: reseau.eseo.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR02MB6202.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfedaa2-a498-4575-65da-08d8eeb80793
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 11:29:04.0527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d7ad159-1265-437a-b9f6-2946247d5bf9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ou10gDsryiaODyX1Qn9f1Lgmqrnry2CZwvM5vY9ahI36h9/TaJZ7el9UntcpYzYsFgxjWtWq4YS/I/OwagYAkf1Zi1BxJ+5h5RYxg69dezo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6458
X-Mailman-Approved-At: Wed, 24 Mar 2021 10:14:10 -0400
Subject: [lttng-dev] Issues on basic LTTng trace userspace (tutorial)
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
From: MONTET Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: MONTET Julien <julien.montet@reseau.eseo.fr>
Content-Type: multipart/mixed; boundary="===============8795181223647186645=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8795181223647186645==
Content-Language: fr-FR
Content-Type: multipart/related;
	boundary="_005_PR3PR02MB62023431654FB93182EA21A1D1639PR3PR02MB6202eurp_";
	type="multipart/alternative"

--_005_PR3PR02MB62023431654FB93182EA21A1D1639PR3PR02MB6202eurp_
Content-Type: multipart/alternative;
	boundary="_000_PR3PR02MB62023431654FB93182EA21A1D1639PR3PR02MB6202eurp_"

--_000_PR3PR02MB62023431654FB93182EA21A1D1639PR3PR02MB6202eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello the LTTng team !

I would like, at first, to thank you for your projet and your impressive wo=
rk !

For the past few days I have been trying to learn how to use lttng (v2.12).

I followed the installation on your website for an Ubuntu 20.04.
[cid:c663399f-0584-43d3-90c5-3aa277ee7020]

The steps to get the trace of a Linux kernel and the babel trace are great =
!

However, I am stuck for the 'Trace a user application' : https://lttng.org/=
docs/v2.12/#doc-tracing-your-own-user-application
Compilation steps are ok, it launches without error but lttng list --usersp=
ace  gives me nothing.
I tried of course to add -L/usr/local/lib and -Wl,-rpath,/usr/local/lib

[cid:f913a7d9-4040-468e-ac5d-bea22d81da83]

Have you ever had those kind of issues ?
Could you advise me some debugging methods or solutions ?

Have a nice day,

Julien Montet


--_000_PR3PR02MB62023431654FB93182EA21A1D1639PR3PR02MB6202eurp_
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
Hello the LTTng team !</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I would like, at first, to thank you for your projet and your impressive wo=
rk !</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
For the past few days I have been trying to learn how to use lttng (v2.12).=
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I followed the installation on your website for an Ubuntu 20.04.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<img size=3D"8457" contenttype=3D"image/png" unselectable=3D"on" tabindex=
=3D"-1" style=3D"max-width: 100%; user-select: none;" data-outlook-trace=3D=
"F:1|T:1" src=3D"cid:c663399f-0584-43d3-90c5-3aa277ee7020"><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The steps to get the trace of a Linux kernel and the babel trace are great =
!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
However, I am stuck for the 'Trace a user application' :&nbsp;<a href=3D"ht=
tps://lttng.org/docs/v2.12/#doc-tracing-your-own-user-application" id=3D"LP=
lnk">https://lttng.org/docs/v2.12/#doc-tracing-your-own-user-application</a=
></div>
<span style=3D"color:rgb(0, 0, 0);font-family:Calibri, Arial, Helvetica, sa=
ns-serif;background-color:rgb(255, 255, 255);display:inline !important">Com=
pilation steps are ok, it launches without error but&nbsp;<span style=3D"co=
lor: rgba(0, 0, 0, 0.75); font-family: &quot;Andale Mono WT&quot;, &quot;An=
dale Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mon=
o&quot;, &quot;Nimbus Mono L&quot;, &quot;Ubuntu Mono&quot;, Monaco, Consol=
as, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;C=
ourier New&quot;, Courier, monospace; font-size: 12px;">lttng
 list --userspace <span style=3D"color:rgb(0, 0, 0);font-family:Calibri, Ar=
ial, Helvetica, sans-serif;font-size:14px;background-color:rgb(255, 255, 25=
5);display:inline !important">
<span>&nbsp;</span>gives me nothing.<br>
I tried of course to add&nbsp;<span style=3D"color:rgb(26, 26, 26);font-fam=
ily:&quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Bitstream Ve=
ra Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;,=
 &quot;Ubuntu Mono&quot;, Monaco, Consolas, &quot;Lucida Console&quot;, &qu=
ot;Lucida Sans Typewriter&quot;, &quot;Courier New&quot;, Courier, monospac=
e;font-size:12.96px;text-align:left;background-color:rgba(255, 255, 255, 0.=
9);display:inline !important">-L/usr/local/lib
 and&nbsp;<span style=3D"background-color:rgba(255, 255, 255, 0.9);display:=
inline !important">-Wl,-rpath,/usr/local/lib</span></span></span></span></s=
pan></div>
<div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<br>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<img size=3D"9833" contenttype=3D"image/png" unselectable=3D"on" tabindex=
=3D"-1" style=3D"max-width: 100%; user-select: none;" data-outlook-trace=3D=
"F:1|T:1" src=3D"cid:f913a7d9-4040-468e-ac5d-bea22d81da83"><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Have you ever had those kind of issues ?<br>
Could you advise me some debugging methods or solutions ?<br>
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Have a nice day,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Julien Montet</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"color:rgb(0,0,0); fon=
t-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;,&quot;Apple Col=
or Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Sym=
bol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:12pt">
<p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PR3PR02MB62023431654FB93182EA21A1D1639PR3PR02MB6202eurp_--

--_005_PR3PR02MB62023431654FB93182EA21A1D1639PR3PR02MB6202eurp_
Content-Type: image/png; name="image.png"
Content-Description: image.png
Content-Disposition: inline; filename="image.png"; size=9833;
	creation-date="Wed, 24 Mar 2021 11:26:43 GMT";
	modification-date="Wed, 24 Mar 2021 11:26:43 GMT"
Content-ID: <f913a7d9-4040-468e-ac5d-bea22d81da83>
Content-Transfer-Encoding: base64

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
QAwQA3bBwP8D4vPzNCo0Z3kAAAAASUVORK5CYII=

--_005_PR3PR02MB62023431654FB93182EA21A1D1639PR3PR02MB6202eurp_
Content-Type: image/png; name="Outlook-2uix20sn.png"
Content-Description: Outlook-2uix20sn.png
Content-Disposition: inline; filename="Outlook-2uix20sn.png"; size=9327;
	creation-date="Wed, 24 Mar 2021 11:29:03 GMT";
	modification-date="Wed, 24 Mar 2021 11:29:03 GMT"
Content-ID: <c663399f-0584-43d3-90c5-3aa277ee7020>
Content-Transfer-Encoding: base64

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

--_005_PR3PR02MB62023431654FB93182EA21A1D1639PR3PR02MB6202eurp_--

--===============8795181223647186645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8795181223647186645==--
