Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89E2C4332F
	for <lttng-dev@archiver.kernel.org>; Wed, 12 Oct 2022 10:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1665570305;
	bh=6kSk2YemR2FkqXpDIPgEqNwkvAcyqKyRf9EAQ39bJ9c=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=PDMdejq6jNOVGG+C2leH+mizuHRo9bYB//2vHOPSoXShWOUPx1PzmoeRB3LOELJAL
	 ZK80utaz1Gq93Xd9nIuoxen8cD8dcOqirNskQ5UezkNUGrsqs6VNc36zpXi5SparrA
	 HB3wSkHVi+kVzSg3uc5iMx9mrWBYyJXl17EIgXa/hevLiZlnapv2dmKjLFIb/25qTl
	 o1PSpOBpxKF0CZ6onUowP64MjRN5VJxxtttc0yi5rFROCQLtkHAO1LyAcEW58Q68l9
	 LVz90+qZy0H+ozVRIsKpnv42aoTMIcgsOzXuGnr7OiuzcPOTUYm1ezJ1lxgIuza5Lp
	 I6fEYhQfdk5kw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MnTL86bqhz4Zc;
	Wed, 12 Oct 2022 06:25:04 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2081.outbound.protection.outlook.com [40.107.116.81])
 by lists.lttng.org (Postfix) with ESMTPS id 4MnTL71ljKz4S9
 for <lttng-dev@lists.lttng.org>; Wed, 12 Oct 2022 06:25:03 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/8OnF9w1mxZCa10sqXEE2Kq1Yjx8TQf4wQOf/vFJPIvaMrY/1Fdkxm20S1fe5ELWKAvwvYdMA111vt3O6aEIhNAffV3d9S+3g47aHV8OlfzRo4CSOFRCZTMcL+b07dnZRGaXGK+qCsvORJpRpqA/8wfK71/H0dvmWQkvFP7oX/mZtGkADciwasuWn2N2LDFVTLX9xf2Pbzx1/hlrKmL21SyOGwGt7I6EkfN0+2UTbOoHwEC57zH9EPQi0sUmgWlVOxopX8ae7i1I5UE2WCegS3Wv/zm3wcvkuts+2ZExFlkbh4QO9iyYos+bkbR58xj1uZMo4danvaIqzBHwCWzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iatBrez4K/LCmohrQf421hZR1QKDgX9K0OOLm8on/dE=;
 b=ZvxslT1QtOGyiSlLmOqtYa0bQhxeWWq5iBbXsAzlUPP8vruml3+ld48OALTr0PVrbjT+DEXQ0ffqTPquaTnw1tr8nV8nzpdxP9GLgIDaTEENQc/ijhOmjtLgYX8GpA66fHthm3ccDn8/jKvb/H7whXRnaM+Hgg7ex4iMY8nsqLQE9U/APZCuYNKVzLEbOuIqrITy8iO9RkKZIBbyIzrciG4AzCfOI6lSAJ4CnIuxTtHnSgjvPchvPkfqMrV57eYuB4eyWq/wB9FJgcUh1/oewlLpxwT8/iRs0IEosHGGpqreTJpxRsWIc6yFm/LLaZxvluirci2Y19S5UyNG7M6tlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQXPR01MB5977.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3e::6)
 by YT2PR01MB5405.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:50::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22; Wed, 12 Oct
 2022 10:25:01 +0000
Received: from YQXPR01MB5977.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3d44:fba0:1f47:4593]) by YQXPR01MB5977.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3d44:fba0:1f47:4593%2]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 10:25:01 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Maksim
 Khmelevskiy <mk.void.mail@gmail.com>
Thread-Topic: [lttng-dev] LTTng and containers.
Thread-Index: AQHY3W5KPiElldwc9kuXwN4gLXq7oK4Ki3jK
Date: Wed, 12 Oct 2022 10:25:01 +0000
Message-ID: <YQXPR01MB5977C8D851E3796DEB9CF5FBBC229@YQXPR01MB5977.CANPRD01.PROD.OUTLOOK.COM>
References: <CACXehJBSQAmFSKRzSPp9Cg2ZNjmF1UaujnSPeDQvyJBTW0L4Qw@mail.gmail.com>
In-Reply-To: <CACXehJBSQAmFSKRzSPp9Cg2ZNjmF1UaujnSPeDQvyJBTW0L4Qw@mail.gmail.com>
Accept-Language: en-CA, en-GB, fr-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQXPR01MB5977:EE_|YT2PR01MB5405:EE_
x-ms-office365-filtering-correlation-id: 17cde8aa-9398-43e9-d653-08daac3c0548
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bUdi3Jp1rdMToXj21y6gcEWyBCE+MmwFz8ZaspjcOL79+Ys0h7vSWa64WSzauG2qETRyBRnzoMGH2Lm0yRbHUCpUbOubpD99mW5Gs1FJKsbnQTasB5k+GK0Wplz2fVN/xYGXhDiVjE1lQeO1fUlPmGWQGd4xCTW4RJ+oJFAtP6By4A39m8W5YnB7sJMxkQ7m5hrLlbwc5IzWEZBxf9mTGANPXZL3PLxdehKb83eT2ypIhA2xy2hPuoFGBbHAxbQ/E6aqN/vPBl7x06ZNxqRL7Z5oLx37197xM7MF8pcwW84S6pyghdNJIJBPfcsOZMl3LK9zkHXnNx9042ZX3nvSOiJM3fkmu7XDHEx95ntYkOfF35YuwhsXn+m2ksGtQgWexjFrO2vLMmjtFQBfNcDLNpDjJhr3Fd8fgeB7Q2q6xe2JXqdtVLwywSpYRuApEBMibP3qcV06kixFuXWCm8SprbiCHTWPwligo+znaDqFxlV1N4zwjqGPUkATD6+mR1sZJD1eJ5nCM3wcmAOxb87Xo95V35ftqo6b8ZM0qgDrm5p0MlJq7U0rGPAr1b23CWYDfZrDtZOo7RrB4frzLHOCV+wIxh8o3v50BP2yrn5DInq4nYitV1NDrY8uDFoxrl8XRWwc1+GkSwGlQe2esFt+pYxTc+ab+bsjl9DILg1zsBOqykHI2Efo+1UCtUOGB+Is9AVOrJawCCgLTqKsN+twySdQ21b6iWxo8SuIurcCB+3R1TWayO3kpQgckew4ciQkvNCY6erY44eQOQRBi+s8uRZ1dsX404zrnFo8KP54vx6AEZs3HHb5iQnRTLIyfjXmFrnHAi4hf6O6AyVRtJQKPw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQXPR01MB5977.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(346002)(34096005)(396003)(42606007)(39830400003)(376002)(366004)(136003)(451199015)(1690799008)(966005)(21615005)(8936002)(478600001)(19627405001)(7696005)(41300700001)(2906002)(5660300002)(71200400001)(55016003)(33656002)(66446008)(66556008)(64756008)(91956017)(53546011)(66476007)(38070700005)(66946007)(166002)(76116006)(8676002)(9686003)(38100700002)(122000001)(6506007)(110136005)(52536014)(316002)(86362001)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+F7fO1eu7CG7de0RShnJJbjN5HGu/TjGELk7QmOCNYXiabU9pu1pF//DHJ?=
 =?iso-8859-1?Q?6n/tMzzGlwmE2FkckIYfx8rr2ZhO+/hLYbd/N7yLAt5yeSm/Q17w8AB6kN?=
 =?iso-8859-1?Q?UJoV9yjF6YNoHiqPyRaQtZ0FF0c549Hwfarw2uNPet4+PWDnHvhBwt3+g2?=
 =?iso-8859-1?Q?0qtmjq+GatZO0nu01vWW8dCVXKscJCZ7bIBu3pcikkIgyzDoB5O+v0kE/d?=
 =?iso-8859-1?Q?DCY7CeKTnhA1dMk6DdQvSbY8SAAtNKdTN1yiWhHyiWJHXIT1FN+YVH39Mw?=
 =?iso-8859-1?Q?FeZ93xox/4G62jJZcyGOBIk/pby7FBKPWOnTmm5mII8P1onpN1ZqChpEg2?=
 =?iso-8859-1?Q?vU+mJcyZegk4PS26SqaIt8N4fiMZA+8mwyC6A6jsmdbnfrCKvqUf12dOuh?=
 =?iso-8859-1?Q?s66VXLqlS4QMjQZ7aakOcyHLKLNSVbf07RCbFQkOU7ma6m2BpTWqKTDNqj?=
 =?iso-8859-1?Q?gT9KwcAHOV1epXaNzRhzWRomXGrfN5L6zZSEB2Hn9pp2IF+Xng2VHqpq+1?=
 =?iso-8859-1?Q?9TIG4vL/G3sL8aAbIiwNCgcv2EX0L84+g+HMSRX4if+ieY0HJEP3XnnDkn?=
 =?iso-8859-1?Q?4bI/nL1kUnmAXnpPwlvnfYK82zKAvHgCQlPYu4Q5dE8bINcjRDcEVcShml?=
 =?iso-8859-1?Q?8Gk/Mlgq9lG/MY2qwPewyz8G/Hn99HXmrI/a6m8JAV4plBLLGoNRZ0KQE9?=
 =?iso-8859-1?Q?HlB4yRtH8ftzbX7jcfQ6lPIOhGo/Nyzy23jDwT/zYB/IvO1L7ODeoKxq5u?=
 =?iso-8859-1?Q?eEmqzFulUViev3CiqeaunhsCX36NAFJvu2G2KoV637VU05MRdcTkIOxUsR?=
 =?iso-8859-1?Q?tE7mwL1HkK3YC4DeYFlcwCq0AlVF0Qd4OdP4kRjQ12TxMTj+KPxyFBDfpR?=
 =?iso-8859-1?Q?CMuKtjTrQz+EUUBh/NfMVEGmPMNmcEUqrTSW+BakNKd97u56mVgoKJmfk6?=
 =?iso-8859-1?Q?dtPoO2lw9qvD7ugRqBwoB8Es6Ck2WO2W31TBkV96/hPYav8FSIQXEr8+oz?=
 =?iso-8859-1?Q?DbRBXEgjYFOuvq7zZq2/iImWjJIog57XkvsCIOggjugiyyBI1yjzZpX1vy?=
 =?iso-8859-1?Q?cNUaDWVNJy7wkbh3AHNF/PUV1Fui5ivO9aZ6NM2V+CXS26QoCqjJyK6H83?=
 =?iso-8859-1?Q?7XI7hTcX/FF5HSWzRbykYVGFupg3xtmZDUwJlzM7+ARPC9PiRlPqRPRbH5?=
 =?iso-8859-1?Q?Msn1pIPkCUpLUX5nY3O7XTERlY7x+kf5UAvZB8IDvv8ECSq1gnwaiVfGdw?=
 =?iso-8859-1?Q?mbiEzIrSDNphjkBBlJUdq/X3GRkZ7+dtgqaZgluLqeYHrQEtNy4Ke189Bq?=
 =?iso-8859-1?Q?r4CeYWHuM9AMZDwVgFPOAVksw8aeVRC8g5ZXStW/beLUrTRAvjzIOapO7u?=
 =?iso-8859-1?Q?Qf/fS+dbUXSaGcylYABfs7dYhmz1vDOE5Q5hwesTRicNRNUC6J3BpYWRXP?=
 =?iso-8859-1?Q?f479rwgRUlx1/t6SuRolLsopC7iu30oil5UgeUiW0jNQ807AsXttW6KbdI?=
 =?iso-8859-1?Q?ICCj2xvnh3INI87Sf02Yf+U+i1gtQ3TGM6e4o44ze4KfwbCP4dMHGytKS+?=
 =?iso-8859-1?Q?aoVUkNAf75vA0FgBTVGvEPtuQ48G1a2LeeqkL9lxMbcKQrevMCmPCWftjC?=
 =?iso-8859-1?Q?ITjNMgqF8UB2oXyxfIpdW14yGZHMbMLRhcUL8SHlPQCzstxRbyMgzIFpT5?=
 =?iso-8859-1?Q?u4F938RD4RfK41U2ON54UHER7FWTfGxOyZssMgqs?=
MIME-Version: 1.0
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB5977.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cde8aa-9398-43e9-d653-08daac3c0548
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 10:25:01.2384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TI2bGievqzTsRXaHqxzWVWLwuw2uI0I1l1vn4TTikYivibYfkzDDF47e17kt/6lvvGWdUd5xDKo4NUUa2kT9LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5405
Subject: Re: [lttng-dev] LTTng and containers.
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jgalar@efficios.com>
Content-Type: multipart/mixed; boundary="===============4786222608361942893=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4786222608361942893==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_YQXPR01MB5977C8D851E3796DEB9CF5FBBC229YQXPR01MB5977CANP_"

--_000_YQXPR01MB5977C8D851E3796DEB9CF5FBBC229YQXPR01MB5977CANP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Maksim,

It's hard to give general advice without knowing more about your constraint=
s.

I can see three main approaches that are easy to reach:

  1.  Store the traces in each container and fetch them,
  2.  Trace to a shared volume (make sure sessions are stopped or rotated b=
efore you read them),
  3.  Or stream traces to a "collector" container (perhaps the one doing th=
e analyses) using network streaming

If you want to continuously consume traces, I would suggest you look into "=
trace rotations". You could setup periodic trace rotations (based on size o=
r time) and ship traces to your processor node as they become available.

Although my demo wasn't running in a container, the basic idea is what I pr=
esented at FOSDEM in 2019:

https://archive.fosdem.org/2019/schedule/event/lttng/
[https://fosdem.org/2019/assets/style/logo-gear-7204a6874eb0128932db10ff403=
0910401ac06f4e907f8b4a40da24ba592b252.png]<https://archive.fosdem.org/2019/=
schedule/event/lttng/>
FOSDEM 2019 - Fine-grained Distributed Application Monitoring Using LTTng<h=
ttps://archive.fosdem.org/2019/schedule/event/lttng/>
archive.fosdem.org

I hope that helps a bit,
J=E9r=E9mie

--
J=E9r=E9mie Galarneau
EfficiOS Inc.
https://www.efficios.com
________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of Maksim Khm=
elevskiy via lttng-dev <lttng-dev@lists.lttng.org>
Sent: October 10, 2022 12:12
To: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] LTTng and containers.

Hi,

I would like to ask regarding the hot topic - container tracing. I've seen =
a youtube video<https://www.youtube.com/watch?v=3Dhra-eu6EOpY>, have read a=
 message<https://lists.lttng.org/pipermail/lttng-dev/2021-May/029952.html> =
from LTTng mailing list and tried to google more about this topic but didn'=
t find much of info. Could you please direct me where should I continue dig=
ging?
My problem:
I would like to have multiple containers where traces are generated by apps=
 with compiled-in tracepoints. Traces could be stored in these containers a=
s well.
Besides these containers I would have a trace processor container, a master=
 container which could address a container(or a trace session) and fetch tr=
aces from it and read with babeltrace or similar tool.
So far, intuitively, remote tracing comes to my mind but before continuing =
with the task I would be happy to hear an advice from LTTng devs.

Thank you!

--_000_YQXPR01MB5977C8D851E3796DEB9CF5FBBC229YQXPR01MB5977CANP_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Maksim,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
It's hard to give general advice without knowing more about your constraint=
s.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I can see three main approaches that are easy to reach:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<ol>
<li>Store the traces in each container and fetch them,</li><li>Trace to a s=
hared volume (make sure sessions are stopped or rotated before you read the=
m),</li><li>Or stream traces to a &quot;collector&quot; container (perhaps =
the one doing the analyses) using network streaming</li></ol>
<div><br>
</div>
<div>If you want to continuously consume traces, I would suggest you look i=
nto &quot;trace rotations&quot;. You could setup periodic trace rotations (=
based on size or time) and ship traces to your processor node as they becom=
e available.</div>
<div><br>
</div>
<div>Although my demo wasn't running in a container, the basic idea is what=
 I presented at FOSDEM in 2019:</div>
<div><br>
</div>
<div class=3D"ContentPasted0"><a href=3D"https://archive.fosdem.org/2019/sc=
hedule/event/lttng/" id=3D"LPlnkOWALinkPreview">https://archive.fosdem.org/=
2019/schedule/event/lttng/</a><br>
</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1">
<div id=3D"LPBorder_GTaHR0cHM6Ly9hcmNoaXZlLmZvc2RlbS5vcmcvMjAxOS9zY2hlZHVsZ=
S9ldmVudC9sdHRuZy8." class=3D"LPBorder819483" style=3D"width: 100%; margin-=
top: 16px; margin-bottom: 16px; position: relative; max-width: 800px; min-w=
idth: 424px;">
<table id=3D"LPContainer819483" role=3D"presentation" style=3D"padding: 12p=
x 36px 12px 12px; width: 100%; border-width: 1px; border-style: solid; bord=
er-color: rgb(200, 200, 200); border-radius: 2px;">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td>
<div id=3D"LPImageContainer819483" style=3D"position: relative; margin-righ=
t: 12px; height: 160px; overflow: hidden;">
<a target=3D"_blank" id=3D"LPImageAnchor819483" href=3D"https://archive.fos=
dem.org/2019/schedule/event/lttng/"><img id=3D"LPThumbnailImageId819483" al=
t=3D"" height=3D"160" style=3D"display: block;" width=3D"160" src=3D"https:=
//fosdem.org/2019/assets/style/logo-gear-7204a6874eb0128932db10ff4030910401=
ac06f4e907f8b4a40da24ba592b252.png"></a></div>
</td>
<td style=3D"width: 100%;">
<div id=3D"LPTitle819483" style=3D"font-size: 21px; font-weight: 300; margi=
n-right: 8px; font-family: wf_segoe-ui_light, &quot;Segoe UI Light&quot;, &=
quot;Segoe WP Light&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Taho=
ma, Arial, sans-serif; margin-bottom: 12px;">
<a target=3D"_blank" id=3D"LPUrlAnchor819483" href=3D"https://archive.fosde=
m.org/2019/schedule/event/lttng/" style=3D"text-decoration: none; color: va=
r(--themePrimary);">FOSDEM 2019 - Fine-grained Distributed Application Moni=
toring Using LTTng</a></div>
<div id=3D"LPMetadata819483" style=3D"font-size: 14px; font-weight: 400; co=
lor: rgb(166, 166, 166); font-family: wf_segoe-ui_normal, &quot;Segoe UI&qu=
ot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif;">
archive.fosdem.org</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<br>
<div>I hope that helps a bit,</div>
<div>J=E9r=E9mie</div>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
J=E9r=E9mie Galarneau</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div>EfficiOS Inc.</div>
<a href=3D"https://www.efficios.com">https://www.efficios.com</a><br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> lttng-dev &lt;lttng-d=
ev-bounces@lists.lttng.org&gt; on behalf of Maksim Khmelevskiy via lttng-de=
v &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Sent:</b> October 10, 2022 12:12<br>
<b>To:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Subject:</b> [lttng-dev] LTTng and containers.</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">Hi,
<div><br>
</div>
<div>I would like to ask regarding the hot topic - container tracing. I've =
seen a
<a href=3D"https://www.youtube.com/watch?v=3Dhra-eu6EOpY">youtube video</a>=
, have read a
<a href=3D"https://lists.lttng.org/pipermail/lttng-dev/2021-May/029952.html=
">message</a> from LTTng mailing list and tried to google more about this t=
opic but didn't find much of info. Could you please direct me where should =
I continue digging?</div>
<div>My problem:&nbsp;</div>
<div>I would like to have multiple containers where traces are generated by=
 apps with compiled-in tracepoints. Traces could be stored in these contain=
ers as well.</div>
<div>Besides these containers I would have a trace processor container, a m=
aster container which could address a container(or a trace session) and fet=
ch traces from it and read with babeltrace or similar tool.</div>
<div>So far, intuitively, remote tracing comes to my mind but before contin=
uing with the task I would be happy to hear an advice from LTTng devs.</div=
>
<div><br>
</div>
<div>Thank you!</div>
</div>
</div>
</body>
</html>

--_000_YQXPR01MB5977C8D851E3796DEB9CF5FBBC229YQXPR01MB5977CANP_--

--===============4786222608361942893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4786222608361942893==--
