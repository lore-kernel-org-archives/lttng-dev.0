Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5E8C433FE
	for <lttng-dev@archiver.kernel.org>; Wed, 12 Oct 2022 09:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1665566345;
	bh=Ag5xUqh59OB4DmWic5+WJVvzA/FlOiIunemLRU4P3S0=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=rkYWVDl5uoQYi7nrMca34/UKbyINNH82o1/YRsQRU51rnCy24/GRnIbFIcWv8CvJG
	 u2WHd9rmw9wJMfn/EUllsYyfEOdvgqqyJwIYHADy1mTFlo5gXG+tLQKJbXn2MS3mKG
	 4WcPBs7oAyiPsYGO2TxH36iS8wh1G+LUCifUzWmgduWUKlGUKi2uROcY/eUO98Wzya
	 msGahwoilP+RhIJVWQUAU952DBomfhEq9IfQce9zUTppvsBuaRzSfZNOh7mSYJ1zYo
	 UVFCKJmE2wFUerXJ1Nws5FMmVwQd/J7wNolJF6llbgRs8jy7tnz1OQ5HEsOTOI9VYw
	 CBJhdLqX08FQA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MnRt10vmMz70H;
	Wed, 12 Oct 2022 05:19:05 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2065.outbound.protection.outlook.com [40.107.115.65])
 by lists.lttng.org (Postfix) with ESMTPS id 4MnRsz4Rn5z6GX
 for <lttng-dev@lists.lttng.org>; Wed, 12 Oct 2022 05:19:03 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWhOzupCtMUb9qnHU3P1dArLW43UJJae/O1PdOt+VDuQX172DBZatLBbOZ/+JacqwSATB1q1DtpOwo5W/YozR9V5x6Gfax3VxGG/lG7sYll/HXKxaf13zDixZzyQZQ2fYAXm2nvNYct09lQkm7gS5iSTi8I73nZkUIbiEoFZdVeYg/5D/9B+gcFblYdSlD5RZUM4OUAG67gNciGsa/qUspWyizpnRyO4lfEdfziAqk2Nri9ElWxuskNUXfcnO5WeneTK14vfBhQeo76eEtQ1EcdaNmiFHM23swEHnOyFSxDTxNeuAG7GsRn5PmwqrdFftPQTNSuDAwJCnwjruLvh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9NGaGXlA3O7lJECMLMIX6/xmF784HnUE8gOLKXAOXM=;
 b=I7iVLBQLX6NtfuNu2CrUbnbVxC5EGctHPGsfZIZlR03gtZ/JGxIt4Cl8wJzvJM3YukLmuWxAU3Tr8GeZGRYlcseEatLg90eSodZ8ZalsK6ClLoXLj66o8ws710Kg9SB5VBaHFRZJGIoFXDvuFiw4sfSKMYoYwM8zVIpFPT0YsgBuDOlgDCXupOHcxH2wT1qhVsAdjpEozKrTVmqqpUsgWS2nb26FRCMeEmKHKNsRGPnu3BHIjiF0RGAc/vcfVJAWNlnnoc2yjGKzN3mdbestOWOkGUxrKhmnhVd+k8ggvnrxBh+YCSbKoVZoIELDKp+gNRUZOOKMxOyCMbenOBcqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YQBPR0101MB5302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:45::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 09:19:01 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a05b:5150:ef:dede]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a05b:5150:ef:dede%6]) with mapi id 15.20.5709.022; Wed, 12 Oct 2022
 09:19:01 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Akhil Veeraghanta
 <akhil.veeraghanta@outlook.com>
Thread-Topic: [lttng-dev] lttng-ust on arm64 getting bogged down by the getcpu
 syscall (taking more than 600ns per call)
Thread-Index: AQHY3bKHGDMyO1W790+WQyQsoRbVcq4KegxF
Date: Wed, 12 Oct 2022 09:19:01 +0000
Message-ID: <YT2PR01MB59842EC5E5A7DCED7D7C3C2FBC229@YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM>
References: <CO1PR03MB59371096D2E4AB93558EA072E5239@CO1PR03MB5937.namprd03.prod.outlook.com>
In-Reply-To: <CO1PR03MB59371096D2E4AB93558EA072E5239@CO1PR03MB5937.namprd03.prod.outlook.com>
Accept-Language: en-CA, en-GB, fr-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB5984:EE_|YQBPR0101MB5302:EE_
x-ms-office365-filtering-correlation-id: 7b7fe300-0694-4855-510f-08daac32cd43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RHKLgpJqYacUvj/TG4Dc/Ec9UVGuAEcZM/w3O8X3YaHgaikXfUXepE+WTbbvjuYxboNuegU0WOBhFKB8y4D6f5bAgmPumfIezqf7XbvWNeMDeqgo3mW+p2qlYS9oqjo8aBQZyY7aVg7+I1C08SYinAhRqT8km3xRQKtzqn4fbNggp1KcUs/8IdRzUAviGYQ1dh/o7sFWjgxomUbGe/wgq3Hj0gM4C5CST5VLWLKcn/KfTWnzcoj3TZnRHOFJ0RFCIayIzk+6QCB6dlh8LnH9kGEWUW8tAedSLIu8TY4cEp0i6HEJtYdjVajWvZhWT0kVDKw/6kGsbXiu4awLTIpmbzUfIeDkjEK+CMrm9pzEoN1sTwy7WPO2p3ivj3JYqGfOMKboEX2XAf3mm47vG1m8RVGz7gtFyMSwFgCa5W9Y9HUqIg2vPG+FgH9WDhDV40RiIaY8wpI73KNjB0wv42zq02Z3hjDy8jScr7KbO1xFalelCI/YOMBaSdOL03CnBqOgn1gZecuJmnwTj3PZkg+kIGg24Wous6PDShLAlia9gZ/M0PkjXSOkA07ZlLeat5wKN7B3+xMFsDAb7EBISgB3RUalGdO6X7JEYwbEqTXriN7gfGsRXqbwxTHqZlK1++t+XrIcIB/PBNwprmu51YAO9MOrBxNbEVpphXd5bZItIyT11HLhlkc7/Te24uiCVXQUL/Ga1KA/zZJghJwMg8EaQj6v1gwqxS2MiitmMPpDnSHv/mnIJqA1b6Nlx4MDHvGVy5gH0xhXVaipQUx5wOhqbRYQgUpm3kVyxnPhWMS3X2M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(34096005)(136003)(42606007)(346002)(396003)(376002)(366004)(39830400003)(451199015)(33656002)(122000001)(38100700002)(86362001)(5660300002)(166002)(38070700005)(55016003)(316002)(71200400001)(966005)(478600001)(66476007)(91956017)(66446008)(64756008)(8676002)(8936002)(110136005)(66556008)(6506007)(52536014)(2906002)(76116006)(41300700001)(66946007)(66574015)(83380400001)(7696005)(186003)(53546011)(9686003)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/DO/d7UcXqGdZ1h2ylTgcGgaB188qM5S+kAuCFKpvBDiYu+LoVdbb9R3bq?=
 =?iso-8859-1?Q?eaVsh3TvGAidtCRVRYUqW88BPyQpOoYjfuKLS5BS6e8mOLhX+NxG0raRWd?=
 =?iso-8859-1?Q?UKMz/rfSh7SpVpXmEFFl4SpwU2b0dHvnPNj+ck8PQkAOy4m+ClEaS1JiOK?=
 =?iso-8859-1?Q?+WPzGKbwHPdH/+oxv3nk/KB4FZMAjL93OAnLnUg2zoHt5NBIqxFJD/frlL?=
 =?iso-8859-1?Q?Hzp0B4jXwnnZ81BWPqrOeKQNrMptAqsilj4kPhKjlprfLdhTItiJ8UMzaF?=
 =?iso-8859-1?Q?U7LGj5OB5lhHGe1WcTTotW+H5Ucd6wvW0wv9U3e8YZ5shdfq9tfpDe4R7R?=
 =?iso-8859-1?Q?9smnK0AVCUfIsDzvb/2lkho+51zpkmKMov82A9kAYdDUTdvmx6Y2oPpbjU?=
 =?iso-8859-1?Q?TC8PTe0OjftYwaaiWwyQZXbwTiFXrtbfJCo2EocOXz2H+v6PYXWvFxn+5M?=
 =?iso-8859-1?Q?qolKAvM51aWILMFWhd9vrNdLIw9sw2NURZ9KJg+fSczvmEDoRN+4rgHTed?=
 =?iso-8859-1?Q?gTRfuzPLvUesHCiVWYtx2Efjm8jn916XxDQ3RBVpzrkUGnOZap9ecAZ/Si?=
 =?iso-8859-1?Q?WoZjBT8X2OBsEqRkeo0W9xLPNwNDMq0vQOHwr1XtbUW1msRjJdKh6/N1hj?=
 =?iso-8859-1?Q?lCskosCUbYzxoNL4uemmEtNnHu2E1UlX9P/melhMlVxhR2aXhmTGSe8P8R?=
 =?iso-8859-1?Q?EMBWBNClysydjhtVl/B1StxGuIqKZPBjkcO83WUpwRfk+w1p9K44Ar1y3K?=
 =?iso-8859-1?Q?72a4svrmKpSBIixBa+4+1HVOBPN9l/elLRzdDrppd6s74g6nEYxsv00og0?=
 =?iso-8859-1?Q?hc52P7fZencSifZwsgpTXpn4afPkyvSL41+NP9df2OnR3NYF4Du9f7r/E4?=
 =?iso-8859-1?Q?edJ43g8JhwGtiv77JVwZ8M75x7auuIf3dhm+AOTWJxwB/dBZWElH0cnWGT?=
 =?iso-8859-1?Q?FgKvvSb/bQZVKaPn8wFn3tQ7J2jda61S/H+BxNxiUndqgzPYk01sGGz363?=
 =?iso-8859-1?Q?/fMOn/hi+kQ8pD77I1FQno559VXAbcu6caZz60V1px6AH6CqVxUUVM42YW?=
 =?iso-8859-1?Q?63QfztG/VXPyNfQ8HW3AJzq2zbSv4eYK7tSXV5OrjuQZ06rPLUpqkBBnlz?=
 =?iso-8859-1?Q?15BroGu3RjI0mYZL6sbO+h01Lnl9OfrUsAS9oDkUZBk9igdLElClAqo0kT?=
 =?iso-8859-1?Q?/Svo4D/qxcDXL5n2ak3q4ZDX6B3iiHq8BBc3dSNnRm8weBsnh2L4atFSOF?=
 =?iso-8859-1?Q?iWbkVwtBUlsjzINzAmwMSr6KYddjN/laWgRZNtB+39UGjrIJDp+Km1Okv4?=
 =?iso-8859-1?Q?Iord8+2NtxvmQ9KOuUjPlavzXMOo4xHUtLUoRTGiYHezDSDB32fvSv6qtC?=
 =?iso-8859-1?Q?lg6VRkvrEaVBSQ0onEj8gMxvjJt4LqBzE6l9eMEy5FOHZiOAn82Pj2RhHe?=
 =?iso-8859-1?Q?Qqn4t+0PgbNkUdQNkeUNr2tQxHmBGWttsas4K+h5D0QKSChj2jnP3FeoPR?=
 =?iso-8859-1?Q?2TeIxD0DkITYv6dGRRCTn5Em2hrUPATO8r9//F9HD7X6MrkX+j/dC5mya6?=
 =?iso-8859-1?Q?6/GU/5a7xGT0R9vuzK43g/285ZO2e9bhwBfqRLD5de5+BhynyeI7TcjWnX?=
 =?iso-8859-1?Q?dHhQskHBXdha/V161trMAlSmhUtKSq9hzWmQnCHSeb7mQ69KgHyzCkB+/7?=
 =?iso-8859-1?Q?9WFIPNwX5GdXQYb5Kuk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7fe300-0694-4855-510f-08daac32cd43
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 09:19:01.7804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWKRuuWWcp6+rJ6IXAKpTA6zprPkxpZf6kZTvqimEweJt4ofhOZUbwWN0qqK88zugBYekGqJWPbfzmlzYjWe3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5302
Subject: Re: [lttng-dev] lttng-ust on arm64 getting bogged down by the
 getcpu syscall (taking more than 600ns per call)
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
Content-Type: multipart/mixed; boundary="===============3001479882005981377=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3001479882005981377==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_YT2PR01MB59842EC5E5A7DCED7D7C3C2FBC229YT2PR01MB5984CANP_"

--_000_YT2PR01MB59842EC5E5A7DCED7D7C3C2FBC229YT2PR01MB5984CANP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I think the first problem you will run into is that rseq is only available =
on kernels 4.18+.

As far as I know, starting with glibc 2.35, getcpu() defers to using rseq w=
hen available.

Is there a way you can upgrade these two components and see if the overhead=
 is reduced?

J=E9r=E9mie

--
J=E9r=E9mie Galarneau
EfficiOS Inc.
https://www.efficios.com
________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of Akhil Veer=
aghanta via lttng-dev <lttng-dev@lists.lttng.org>
Sent: October 11, 2022 16:57
To: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] lttng-ust on arm64 getting bogged down by the getcpu s=
yscall (taking more than 600ns per call)

Hello!

I've run into an issue with getcpu not having a vsdo implementation and tak=
ing anywhere from 600ns to 80us (avg 1 us) when using lttng-ust tracepoints=
.
I am on lttng v2.13 and kernel version 4.9.253-l4t, running on a jetson (ar=
m64). I was digging around and found that rseq might be the recommended nex=
t step

I am wondering:

  1.  Are there examples of using rseq system call to replace getcpu
  2.  Are there any existing patches that I can apply to get better getcpu =
performance

Thanks in advance,
Akhil

--_000_YT2PR01MB59842EC5E5A7DCED7D7C3C2FBC229YT2PR01MB5984CANP_
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
Hi,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I think the first problem you will run into is that rseq is only available =
on kernels 4.18+.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
As far as I know, starting with glibc 2.35, getcpu() defers to using rseq w=
hen available.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Is there a way you can upgrade these two components and see if the overhead=
 is reduced?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
J=E9r=E9mie</div>
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
ev-bounces@lists.lttng.org&gt; on behalf of Akhil Veeraghanta via lttng-dev=
 &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Sent:</b> October 11, 2022 16:57<br>
<b>To:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Subject:</b> [lttng-dev] lttng-ust on arm64 getting bogged down by the g=
etcpu syscall (taking more than 600ns per call)</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div class=3D"x_elementToProof x_ContentPasted0" style=3D"font-family:Calib=
ri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
Hello!<br>
<br>
I've run into an issue with getcpu not having a vsdo implementation and tak=
ing anywhere from 600ns to 80us (avg 1 us) when using lttng-ust tracepoints=
.&nbsp;</div>
<div class=3D"x_elementToProof x_ContentPasted0" style=3D"font-family:Calib=
ri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
I am on lttng v2.13 and kernel version&nbsp;4.9.253-l4t, running on a jetso=
n (arm64). I was digging around and found that rseq might be the recommende=
d next step<br>
<br>
I am wondering:</div>
<div class=3D"x_elementToProof x_ContentPasted0" style=3D"font-family:Calib=
ri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<ol>
<li><span style=3D"color:rgb(0,0,0); font-family:Calibri,Helvetica,sans-ser=
if; font-size:12pt">Are there examples of using rseq system call to replace=
 getcpu</span><br>
</li><li>Are there any existing patches that I can apply to get better getc=
pu performance</li></ol>
<div>Thanks in&nbsp;advance,</div>
<div>Akhil</div>
</div>
</div>
</body>
</html>

--_000_YT2PR01MB59842EC5E5A7DCED7D7C3C2FBC229YT2PR01MB5984CANP_--

--===============3001479882005981377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3001479882005981377==--
