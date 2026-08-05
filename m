Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0863BC55ABA
	for <lttng-dev@archiver.kernel.org>; Wed,  5 Aug 2026 14:10:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hFXNz16wpz1C96
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1785939013;
	b=g1Y7jEhJgQmkbPjbzNparp+5REv4SVTrlKuH/wd3eua1wWgUvFa4E5aymt1w8230+TCo
	 78t7sg5zi1U/5aqZygyu2NlUv1rc6g9R/63EQu++gCzx4Zo3QNpckFeaKvKpb3+kqEViv
	 6PrLG4Y8B0j+Dc6OH7+MXowBp6z+4BgQorolV5ChaQxjcQVG2MqEKDgTwkFmb4pJ+HUPw
	 JMZEvVX52/p7bVpV8aVjMDuL4mUYxMj+5sTPrlqwQozMeSPj4Y4w+7u67Hcq8zpDqoNQD
	 NpmlnviSnHRLIaKqqRsVDtWplZc1lZuaPaLXgVYom4E6ITNUCDEG/wMo4c+q2tPP6JA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1785939013;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=uL/r1/85SgOujAGapVdvixx4+NZNTtmhkuH0r6r2ITo=;
	b=I4gXimR/PHA4pChpBpZA4HGkM2yFMvFMA5JuWiKjjEtwggw7a+1xIJLZgnsKG7zNfxdZ
	 tQfkicAHcqJFVZhbs71ZZmfjLZiNpgH4avkqmnN3rvowEjhsm6b3Rp+DTVfiBBxzuRpuZ
	 MY8tN14MEjKbWvU9VTDbiMBZ+mEhK99ZVmRJF93l5xv3UgyjG+/hF/eMWmMCOJ9MgSfXb
	 0+fVkZRE/Pmj1fdYkcTuuH3ayV9t+cuhPFbKYnUE9jQSrTSjQOapAwSFxMKTvvLA0k4dQ
	 34NBrhpmOEfuZAf/ccyur3V7r+JxbvQEL/k+wjU6y1juumMV5bkAH8O7TXC5ttEFZ5g==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hFXNz16wpz1C96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1785939013;
	bh=uL/r1/85SgOujAGapVdvixx4+NZNTtmhkuH0r6r2ITo=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=qDvrVeVNNNukhdvHi3BmY3cZxDGzulXxG0fNcWYBeXMJkgS6fDmGNRO/TBrATNb90
	 TU4Lustpes8LJ2GQWS+X6fOFAaqXCrc9lfZ7rgel+hmirbN0Q5schN/q5TQROAsPLR
	 MM2NsR/BVUwimxBZ1W/TGcUskg+m8gRgDiJNv8i2eKvIwgrktSvy8UezHe4EQDlu4F
	 hGhluHCY+GYnFv3gewAMYcz1fcCtI+pmPz9Wkry9bl7hEFea9+S3x+No1u5zwjlBk4
	 LsMTvdUUo87EfcMxwiDYFveLKF6a56JYohoWMAM5KYqnyR5hXue14xaVzBDNcs1L2/
	 0Bo6unz/JDykg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4hFXNz16wpz1C96;
	Wed,  5 Aug 2026 10:10:11 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hFXNx3y1zz1CCD
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hFXNx3y1zz1CCD
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020084.outbound.protection.outlook.com [52.101.191.84])
 by lists.lttng.org (Postfix) with ESMTPS id 4hFXNx3y1zz1CCD
 for <lttng-dev@lists.lttng.org>; Wed,  5 Aug 2026 10:10:09 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCWbM9O+4FCKvMUmwL6f8xevqD14YFOtifRW/RtDyoWLpPrE9MLz/K7WMUxNhnkmJ0rdGFGvvwZcO8Yoc86Lj8cTQ/6thaKzwjGJQ04fnSre1VNmEHC40z054d6gDrPeP9YtwfGjJMmccYihhzImW2Tf3Fvqclqimlf6+ELBCtZzT6oTBEWKkieqrqw0unvgnJcnVOSRzsAuvbcJdgroSVGBGtn9HuxaejUQNDXQYgYemc0jW9GkJXWFV0L9P4djJPrRgVOJIc6WTHbBMKsz/QOnlW0gGtRpOMyV2nGpjLT9AdOoyO0C3IAOJM5FjcSeBpRhqWigrKmDZ6IEiVNHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL/r1/85SgOujAGapVdvixx4+NZNTtmhkuH0r6r2ITo=;
 b=VvPtscT2AU5FVhQwMbzeSf6NxIAM2+I3TibzIZh6j0STKSXc5RfSSf90R+qCsXRDsCXjA24Nb4HouMDfVoPDOk2QWkIjA/42FYcB+/IxWiloUIP712eFeHaEE1DrXX8w8yv0xSxqg9eGwtbeWgGSw0s36+c80FIj3LayDCpy+s0K2qP+dWy8042+XnPBrpYb1kJ78Z6cNvHgFlT+r0SKvp9vlEFm+WKITH6mbxsLPNHzbGCZPeKdjmaYUVppZ7NmBaQwnnBO8YX0I/qe+FP8mL9ulstcmTJte5ErHAzEHF7Ab60opYRe5J0fxm9jfuJ8vsWH9XJdW1HHmEbifly2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polymtl.ca; dmarc=pass action=none header.from=polymtl.ca;
 dkim=pass header.d=polymtl.ca; arc=none
Received: from YQBPR0101MB9838.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7a::17) by YT2PR01MB6332.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:4d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 14:10:05 +0000
Received: from YQBPR0101MB9838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17c2:2167:4422:a673]) by YQBPR0101MB9838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17c2:2167:4422:a673%6]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 14:10:05 +0000
To: "MOESSBAUER, Felix via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: Re: babeltrace master: trace-compass is unable to open trace with
 index
Thread-Topic: babeltrace master: trace-compass is unable to open trace with
 index
Thread-Index: AQHdJMN9J+nDISDJA0e9fh1jxkhO27aPfpob
Date: Wed, 5 Aug 2026 14:10:05 +0000
Message-ID: <YQBPR0101MB9838D35D912444AEB1C71531E9D32@YQBPR0101MB9838.CANPRD01.PROD.OUTLOOK.COM>
References: <5eed80a93b79f22f7c30a383f2a7b4d6f7068a97.camel@siemens.com>
In-Reply-To: <5eed80a93b79f22f7c30a383f2a7b4d6f7068a97.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQBPR0101MB9838:EE_|YT2PR01MB6332:EE_
x-ms-office365-filtering-correlation-id: 582f2062-eb19-4bed-75bc-08def2fb3fdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|786006|376014|23010399003|18002099003|22082099003|11063799006|56012099006|8096899003|38070700021|13003099007|6133799003|10067099003;
x-microsoft-antispam-message-info: DTGb8ukkMNlBPI/u4KXzuAN3iJWB9UuUKQnpyG96UnOsRw68r/zRMnbJ/3frMxQX6R+1zKY87dToo9eCvkGGm/m6ioPp940oNf59efEmU0BJspZQvYlYHgJYFeQmVfjPO4ThAQA9nLIdsV9n5jQXGK5Cuj+sUzS8Ro1TiD9bOaUiTjRtw+3JlzzGtvvYAff+irMMliTznQNKSKHxI9TZBrmMwrxtZa1HlB2kXcJj8ErzC2EF94L33Vvd1gSczf1YzUb6SavhsyIjeJ0j7+eqVPZXmhegO1LRlG6JcefU6Jjw1wq+f+ukKvlnyUyqzM5ZtwLw41hkPbPqWRaqYdkyS7QAnTjtab/s2JeEN8G0loQl4G0+vXId73YKnTLl7sySOY/WwZmKoMnsKmWN7H2ddEEdZwzh+MJ02vo9b7vafPayhjAVFQnxBtR3H9vWdi7Cu4ux+iU0trGTSc9/89EI0yk6rVNhNjkMHMKqPXrExFby7Bp+jLmEIqrcmtSUZOacpOoqpxnxZsstumPBps9IafEHK8NCyTdpdYmumx4EMUKrbflRChNJr93cZFYDWnHWh3o7XecZexVH46NKB2+JnhgyeTP7WEDFlFQH4XQ91AfPsSSCe6EsFoZmbbkOdADat7KD1xq3hGuDEzD2uYggN/Q/LrKZD/cuWxhps4Hcfmyfx4pX31C+RGJcUsks3pyUUz75SR2uh/5HyBxtmLOc8eUjEzCJmv5+KIfh0C4Ac1k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB9838.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(786006)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(8096899003)(38070700021)(13003099007)(6133799003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DZztKw0gakJGiuF+o/M6hI20om/6bPJGKRV1/bxfDUhXuzF8E87oOrwKWgU1?=
 =?us-ascii?Q?zKMGuGKHcd+pgkhBq8q27MMwBgZfAPG9379J/KFSj+c/sxAkj6Ipyle+P2hr?=
 =?us-ascii?Q?4jUsyOSAxilyVEa3JapeUKwK7o4VgRpDAUsQM+lMvcs1Ic+RNoXvJfTFzGTq?=
 =?us-ascii?Q?VW+YLbB+ZkCbjd92gkg3o7FaL5DhHPoPlnnjlmArzcIzTagKGWmdPysbkwBd?=
 =?us-ascii?Q?U+XXt43H4dsmbCpCTs90sNLHwhYNPZyWzQBbAO6khgShHkir+YdPUKSqr9EE?=
 =?us-ascii?Q?SD40t4ymgzeuogAarLSALQ2oskPw8pj3jjum9UY/zNuQE+pll3Tb1JhFm9GN?=
 =?us-ascii?Q?gJCj0kjoIvQ5ttvRvEOV8fVE5qcnKlBqmPdnJjGgzoR7Hf5JAVDqoXEsnHv4?=
 =?us-ascii?Q?mLYb7pY9Oijpy9pHtKNdjg1ynMDh3j/v7yTqHLU2aCUhGaseOAGdflisM7hb?=
 =?us-ascii?Q?AJBRKpDDnSTKftozWU6lYokIdLEIlhf9/lgpju5E58Pm2Cj1dCcjKwq9Rqw3?=
 =?us-ascii?Q?E5A7Oi/+URX5UjZh9Ah7RJhbZj0ClKE2Hh4ohgIg3pPfrH/Eiio6FFxfU3h9?=
 =?us-ascii?Q?fqZx7550J8tD5mjpQmfwtk2wUniVik/5PPX5jHRyfVm2dTcubIXCc3Jz2/aU?=
 =?us-ascii?Q?wEkRLsO81MiMo9YnruvUdP3ra7fJ9TQIESx4hdo16b/1ozG7+LrgQ29pOe9G?=
 =?us-ascii?Q?b8FDxDUGWUszaL1hxvfy2XspA9dzmxRX3joUWDB6AWgzkpb+1nedgNkrAvI0?=
 =?us-ascii?Q?c4Pu+QOlH0CAxLRpGBbvH62CaNfBHj7mBFSvG+uocOyNp4sJMLL7nXVsm1hF?=
 =?us-ascii?Q?FUmuTtvGDmrisa0ayiKJ50khNGDOv8OvI9ismcd1AtA1lQs6Y8QI8N3wG7aq?=
 =?us-ascii?Q?BYgPvCjQ5l0l5lkow+DN1yEi9CBNQNCWv9eW+cEXgQArib6ebYlgjj/hsp5P?=
 =?us-ascii?Q?yxi9kpl2dqbL3mWSZIKOzDOTS5YMAA8IongBLLkCoptFVF+09SVXPYKps5uj?=
 =?us-ascii?Q?LRPC/xSu6cffLHFXUDDHWM4FVB0nwGZD7pwQ9GKUUVMgNeRYeGZYa/5L7W2l?=
 =?us-ascii?Q?HKl5cyypYisfeEK0gvvLKLAEtYf0QsiDcvSD7GUIaFBkZdSqmRd1DcUbsTHH?=
 =?us-ascii?Q?Lwq7a85DH/bFWv2jDySufK743M38sKXDAxAxFM6DgpwTZshKYM7sfw+i7UOR?=
 =?us-ascii?Q?71zE1bYkJgK+fVe8lQvgW8lFoCe56S58pj728VVhweMBVd3jALwFfafDfcRp?=
 =?us-ascii?Q?lmmeSIiBUMLvGleUHQhPs/t0i7i4Np+DPmQg2cqTkejMR0p4R14HguKdkE5l?=
 =?us-ascii?Q?zITd1vkSczWQvh1bnE9K5YUI5HqQQQLD/xlXgKUbJZWj/+mFqitzVRdtPCgc?=
 =?us-ascii?Q?NW2Dk0oklg6HkYsumrsWPy1YkxgVoFzuNuTiheJcvEiDXTS0D06Jhu6TQWPn?=
 =?us-ascii?Q?HRJrqb26vVbBViD9dVBSLuU8AXlzo5ievA8aRb+pKvON3Ck377RsjN1CR/eJ?=
 =?us-ascii?Q?ErFvz03s876DZavPnkYpmXH2h8uaDr6Qipwl9tHGU1KQlMKaGP4LCdt86yBk?=
 =?us-ascii?Q?4auot3GruUXW1tHuwHmzQS+xKKETBUdEg0DEz5QMwoKoGDEUkZo5HpWJSyw9?=
 =?us-ascii?Q?ofQSLat6z3nR0wzvLz3jxVNRjUttyZKZ8LBTZxUqW4AwKCi/vYuUNbTkleCT?=
 =?us-ascii?Q?hzYwXYx0p2A8FdVCxfS6mdg3hZ/HmayUtAw5hA5ZpLHjgq3xzeEj8xce0Iox?=
 =?us-ascii?Q?RHib7W+oiw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_YQBPR0101MB9838D35D912444AEB1C71531E9D32YQBPR0101MB9838_"
MIME-Version: 1.0
X-OriginatorOrg: polymtl.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB9838.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 582f2062-eb19-4bed-75bc-08def2fb3fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 14:10:05.5110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 253209e9-7731-40eb-96e1-6444a6823237
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CklvXIbepKURFWu5cY/Qaab99RNJZR/0wbLUN/Eynx2sBk22BtuHOBU5z5LFxkpD9TyMeA0fmguUmtDORuKRDyLEBLiZyKXWSuVje4FPUYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6332
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
From: Arnaud Fiorini via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Arnaud Fiorini <arnaud-2.fiorini@polymtl.ca>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--_000_YQBPR0101MB9838D35D912444AEB1C71531E9D32YQBPR0101MB9838_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Felix,

There was indeed a bug in how CTF trace index is parsed in Trace Compass. I=
 created a fix in https://github.com/eclipse-tracecompass/org.eclipse.trace=
compass/pull/427

If you find another issue in Trace Compass, you can file a bug here instead=
: https://github.com/eclipse-tracecompass/org.eclipse.tracecompass/issues

Thank you,
Arnaud Fiorini

________________________________
From: MOESSBAUER, Felix via lttng-dev <lttng-dev@lists.lttng.org>
Sent: Wednesday, August 5, 2026 6:16 AM
To: MOESSBAUER, Felix via lttng-dev <lttng-dev@lists.lttng.org>
Subject: babeltrace master: trace-compass is unable to open trace with inde=
x

Hi,

the babeltrace version from the master branch (65fb4669f) is able to
create LTTng index files. However, these index files seem to be
incompatible with trace-compass.

On loading such a trace, trace-compass (incubator version, 0.18.0-
20260711-0558, or release 12.0.0) issues the following error message:

> Error initializing trace.
> org.eclipse.tracecompass.tmf.core.exceptions.TmfTraceException:
> Failed to allocate mapped byte buffer at 36 of size 416 on a
> file of size 176

I double checked the traces with babeltrace and
https://github.com/eepp/jacquesctf , which are both able to properly
read the traces.

For reproducing, run the
tests/plugins/sink.ctf.fs/test_create_lttng_index.py test and open any
of the generated CTF files in trace-compass. I explicitly tested and
reproduced it with "with-packets-ctf-2" and "no-packets-ctf-2".

The traces itself are valid, which can be proved by removing the index
file and successfully re-opening them in trace-compass.

PS: I'm pretty sure this is a trace-compass bug, but as I'm not a
member of the tracecompass-dev ML, I report it here. Feel free to
forward.

Best regards,
Felix Moessbauer

--
Siemens AG
Linux Expert Center
Friedrich-Ludwig-Bauer-Str. 3
85748 Garching, Germany


--_000_YQBPR0101MB9838D35D912444AEB1C71531E9D32YQBPR0101MB9838_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: black;">
Hi Felix,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: black;">
There was indeed a bug in how CTF trace index is parsed in Trace Compass. I=
 created a fix in
<a href=3D"https://github.com/eclipse-tracecompass/org.eclipse.tracecompass=
/pull/427" target=3D"_blank" id=3D"OWA79684497-5c55-1c0c-ba7e-216f2b92987b"=
 class=3D"OWAAutoLink" title=3D"https://github.com/eclipse-tracecompass/org=
.eclipse.tracecompass/pull/427" rel=3D"noopener noreferrer" data-auth=3D"No=
tApplicable" data-linkindex=3D"0">
https://github.com/eclipse-tracecompass/org.eclipse.tracecompass/pull/427</=
a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: black;">
If you find another issue in Trace Compass, you can file a bug here instead=
: <a href=3D"https://github.com/eclipse-tracecompass/org.eclipse.tracecompa=
ss/issues" target=3D"_blank" id=3D"OWAdb24d199-d214-5b0c-a2f4-84b88c057774"=
 class=3D"OWAAutoLink" title=3D"https://github.com/eclipse-tracecompass/org=
.eclipse.tracecompass/issues" rel=3D"noopener noreferrer" data-auth=3D"NotA=
pplicable" data-linkindex=3D"1">
https://github.com/eclipse-tracecompass/org.eclipse.tracecompass/issues</a>=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: black;">
Thank you,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: black;">
Arnaud Fiorini</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> MOESSBAUER, Felix via=
 lttng-dev &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Sent:</b> Wednesday, August 5, 2026 6:16 AM<br>
<b>To:</b> MOESSBAUER, Felix via lttng-dev &lt;lttng-dev@lists.lttng.org&gt=
;<br>
<b>Subject:</b> babeltrace master: trace-compass is unable to open trace wi=
th index</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi,<br>
<br>
the babeltrace version from the master branch (65fb4669f) is able to<br>
create LTTng index files. However, these index files seem to be<br>
incompatible with trace-compass.<br>
<br>
On loading such a trace, trace-compass (incubator version, 0.18.0-<br>
20260711-0558, or release 12.0.0) issues the following error message:<br>
<br>
&gt; Error initializing trace.<br>
&gt; org.eclipse.tracecompass.tmf.core.exceptions.TmfTraceException:<br>
&gt; Failed to allocate mapped byte buffer at 36 of size 416 on a<br>
&gt; file of size 176<br>
<br>
I double checked the traces with babeltrace and<br>
<a href=3D"https://github.com/eepp/jacquesctf">https://github.com/eepp/jacq=
uesctf</a> , which are both able to properly<br>
read the traces.<br>
<br>
For reproducing, run the<br>
tests/plugins/sink.ctf.fs/test_create_lttng_index.py test and open any<br>
of the generated CTF files in trace-compass. I explicitly tested and<br>
reproduced it with &quot;with-packets-ctf-2&quot; and &quot;no-packets-ctf-=
2&quot;.<br>
<br>
The traces itself are valid, which can be proved by removing the index<br>
file and successfully re-opening them in trace-compass.<br>
<br>
PS: I'm pretty sure this is a trace-compass bug, but as I'm not a<br>
member of the tracecompass-dev ML, I report it here. Feel free to<br>
forward.<br>
<br>
Best regards,<br>
Felix Moessbauer<br>
<br>
-- <br>
Siemens AG<br>
Linux Expert Center<br>
Friedrich-Ludwig-Bauer-Str. 3<br>
85748 Garching, Germany<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_YQBPR0101MB9838D35D912444AEB1C71531E9D32YQBPR0101MB9838_--
