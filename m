Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8F4C54E58
	for <lttng-dev@archiver.kernel.org>; Tue, 12 Mar 2024 17:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1710265911;
	bh=GL3LfNV5Vh/scn/TR5T1wYKjCNlAdmiscBmpw4HosSE=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=YUaEWP8vy6LNjESVqMSR0qVrzsQ63fpz3NMHpeKrqjvXnIxyDtZatgbjm7MrzSGnS
	 bQYEwK/C/BsW2zAWL6KIrNDzRsKqIlbIEqBhFCLY5W/QunnQxuf/tai+zTFfIed2sn
	 l408W3LgbCsEyAHW0wzP3cTnXDf3iXe4HayLjRNwWZyY1TUGOBuPNUXoDQMid25AB6
	 NqzGwcsiid/6W2hJj/9d+Sp4drbW4Boi2v+gKsXR8BMSBDyEalt4MRsmQDNWB8Icu/
	 HaZXe4h5dXe5eQMMHP8OALHh6Ft+xWmbEMayClkOmedGKnE8X69p13glXv4qNKvCvT
	 8DqEEN/U+yciw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TvLn25rPBz2Kbt;
	Tue, 12 Mar 2024 13:51:50 -0400 (EDT)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by lists.lttng.org (Postfix) with ESMTPS id 4TvLn06fBKz2Kbm
 for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2024 13:51:48 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARu+tDKJFJw477Jmj2yh0ZEG0p/sJfRJoBJ7eWo4yOPB2CtRLe+Z17d96HJZdafGgczH9wlA7aYfue7RhGnyqTQfXK1PKLKcyfFa+Ak5O14WXwO3yLGv+ROvXZ0K1jA0oQNEx063ZOAT8VeFI4t0uL86hWcv2DdCo/NEu/qev7sZ+T6A8fIZXyzArKXJG78la2CL8WOusXC7zHWwG8zJbpNZzuxYLEYNDzmM4DnS8BYO0X4y/N2gUsYE8zcE9tkJEMYvoge3AFZT+55nrNG+VyfypLx9Z9aqYNVZgl6ibuyiEtBiR2ZgtRjpkVZ3TA4aKbyw6AMvgNmUyL/T5/Zutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcUa+539N7KJcHKaC4lcwZibjVP0JgGDL2f9D4Ei3VQ=;
 b=BuQSEP/ksmY5SDxVD3G2qo+DsUK79U5aRhaGsEkgoIvLqCEKukyum3tgSegvJvrXmIBBvq4kkVXBrBhMqORwDSQ2YE6iS96xxZ/MFIdaYHL2x7A7RZVEwFl/rtuqlJE/z41kAUEZSPEVhdUtWWiGYWR/06RdqMZrky8h/iuT1zrtEjW5FcKx5ZMMKXAPN+AgonT5NdgIVLyyRjZ6fu6aBF9+jQmpbLJpc2KaZp2qsf9SMkOhCfxwQNkzWxyfjDjLErQL6aIKRag4bkP8U7Dgen127Xkbq9+O04vY9V8RtZI2/GU66S/NlyeZYAIEYtqp43K32opaiKZvRzJ0GmbfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Tue, 12 Mar
 2024 17:51:43 +0000
Received: from MW3PR12MB4555.namprd12.prod.outlook.com
 ([fe80::36b3:e324:4bd8:7181]) by MW3PR12MB4555.namprd12.prod.outlook.com
 ([fe80::36b3:e324:4bd8:7181%4]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 17:51:43 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Kienan Stewart
 <kstewart@efficios.com>
Thread-Topic: LTTNG Continuously Crashing on Debian-12 
Thread-Index: AQHadKVtQ7sq+eJUs0u98MqrcJSpdw==
Date: Tue, 12 Mar 2024 17:51:43 +0000
Message-ID: <MW3PR12MB4555A944CE48D7780FF1C39DD92B2@MW3PR12MB4555.namprd12.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4555:EE_|SJ1PR12MB6171:EE_
x-ms-office365-filtering-correlation-id: 5b1fb2ca-8b10-4b8f-5050-08dc42bd1411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZ9aCBiRKxYsqSo+Y4l42bxwMCp3ZXKKdgtUeXdYr+T4vVObZCnIa6Hz9CDJXSHMTszZB+vkA5+yLEBb55XhTXJBwTeBi+wOH/bYdJnCuh/U9/bazr635mj2Jm7XHW+c9ZeK8dLbTjTb+j2YxK6Klg0r0Guut3feyN+NCyeEqwDQlA7Vsn9owe6JBllCu7vI6d+7L4i8A+O5iY+VdymUsRgMZ6B3wPLgHihWGBbYD3OzhnS9wWnEwKf79qjHfyg99vyPS193LRpeFozgHoHVv8dIEYuUyC355DVyPjPe2DE+vpcH9Hy1dSeg1b3r8qEZOeIKJAjnXsMU+memLOLjuUgO9BkGfj4en7/Y8G+UGcyqDjaBgXaGJnf4fnfYN7X/+ppIeztGUzWhmXGTIlfPlRMf47940bNVr3dnWhGQqztFiLzhbMGKmaMufnHAv4y9AA4vTSfr0YnFBWNH6jNiASgKNzoqwD/eieMa7sSsNTx+7W0vcGtJ+DGF8qy8M0rwFtL7MkjfujLMaI61y/4k6yw5LUfqPI3Gn4z5kacfa3GUMzHbN3RHh1kwA1FJ1fgM/eRtrwjz4jtKaDGoXsbduOIHynU2cK5Vyy89T1to3Usskpv7tiIeCseRKT9u8hm3khcOxpkJiHgphVzbipcYnS9PUbq4Wb0OKOR99iI/jGJdIRWJwd4pkelq5ohNDsdbDFTmFpeu6ZQvt7SFWB7yS5e2palGsZzCF06Rw1P1Xw0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QZOq+k0kY/ULos1XmqW2f4OLk022ABh4XT/nsLToIZygZb8TbMv48N8Shr?=
 =?iso-8859-1?Q?9epCZLk0gCabjM/g23KDII5PI64c37OVEtxEUcWjnRcmN6TafvovPunr9S?=
 =?iso-8859-1?Q?kZBOheyl6NwM/zy+st1wXcziv+cQ52l7ZyKcIbwad+Mf6VVm0XJircGB4z?=
 =?iso-8859-1?Q?t5CsyXv9XTml1EmF6n9NXllhG1k8OFQ5bmSf8oNYo7l6qv/vwMQr2Gr7sh?=
 =?iso-8859-1?Q?6R4GiDY8iKrPEbXWAcKcKXsOZFzJOldjWbZaPm3/rxtLNKsbTlvRJH/3Yt?=
 =?iso-8859-1?Q?AtFhUa5q+KlKMvItnBEhcGItmukbRjoiRbKiJUAOlIxbDNwLt5JsUQwAGq?=
 =?iso-8859-1?Q?VLBFTgxAwl2vy4vCzexk4LP3xJI8rrmsJ1vT4EXQ/pksG6zfPbAKs+Ckpw?=
 =?iso-8859-1?Q?Covh0QtRiZ8ZOSdnGcBN+VxhAtGIUF8xbExYlQTzprlPTwAUth+5dxKHcl?=
 =?iso-8859-1?Q?8cKpkUG4kdxtSBB/gyjrxxXlGOkw00GsuNshaZDRPlBXfoAK5wPlnX+aHb?=
 =?iso-8859-1?Q?m/jXSnDvGtqeOSpofR+wiqN4p4Nwr6QHGjMhLMFbpqtwFrsjZT9PvCkUHz?=
 =?iso-8859-1?Q?BgEt2DJEgkJLDvSP7EnDJo5ZSDGWJa+JtE2c3zoqEtCvZxaxOYv6ZdWHOP?=
 =?iso-8859-1?Q?yfyPKcnsd+rLTKfnhOP8uEyGfP/ihQ1x6vymH9KuVou+RDDHTWyswBs/7H?=
 =?iso-8859-1?Q?PEMp0FhZaXLERgDXIQ5GcaPUCsoM35clIOeZOgC3JPpVpRlio7y6CTwfK+?=
 =?iso-8859-1?Q?4xB31CWsuD/if5eZBycnJO0YEssgYnRfVxTYdHa1DpFGRqIuVdp2qWQMsM?=
 =?iso-8859-1?Q?4qNs62XKm+RB9NcqUPmmaFHx3dp7zuPu+I0hfdAjAdefvL4eE7Qg21WzwB?=
 =?iso-8859-1?Q?paEn4leYQElNrlf7AGfKBdRhBldd57kVAlaHchEdsrlxXQ5MGa4pvN1Ey+?=
 =?iso-8859-1?Q?4QEq2vVVUUFtTSA3BVr1vv1K3i5lpbLsZWlLxmf429ynd1kwVGPOoMEQFg?=
 =?iso-8859-1?Q?BsbbFByLLBeEzXansxhPyMl7m+atNMd31qn1aoKGOiBWIdekW5CXnARmGO?=
 =?iso-8859-1?Q?ozR8G8lmM3uim5wznzEVSnoR3xweu7iaayHzL382W4ukX536b4egoXxcim?=
 =?iso-8859-1?Q?EKD6ibNQ99cVlE0p0It8abDEaRIGEfe7KZLypH+pQbc8sH9qpGXXP+Ski3?=
 =?iso-8859-1?Q?LqTBxIudkTdOxxkpC2b69tqfQGiskF9HRgUbFQCNzmmQbHXK7dBWrYRf4Q?=
 =?iso-8859-1?Q?CeNYEkrxciTZIkfA2S01EPZuH1ShoCxBUT9ZKmnKFXXtYlbFZAVL7ieuqx?=
 =?iso-8859-1?Q?nkjbylAwTa+Hj9dp7RfchS6IVSLJq2k8WHV918r0MjnOd9XQuPuiHTlgIO?=
 =?iso-8859-1?Q?CQ4Ggn/US9jM9D0t/LRo60ZYsptumyekpXd9eRmzCU6hv9XFkDMb8f/lSK?=
 =?iso-8859-1?Q?shAIlAJvgMB+e1Uj+kDIHSvVWwlLg5w6gy4PIMOLLB19tkpFgmqdmTtv/2?=
 =?iso-8859-1?Q?Y63aboDa711q+F+bvcBYOAZSqL8jbSfJtxCHBHolLzbMzHbRF1sZKHP4bw?=
 =?iso-8859-1?Q?/MAHO+TzrK5H15dLZhpR1v4uaMY/FM52g4KpjLfb7cM0Y3IueoiOLKJ4fg?=
 =?iso-8859-1?Q?fbEBN5nM4P28g=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1fb2ca-8b10-4b8f-5050-08dc42bd1411
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 17:51:43.2526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HnY3eUAf2ubWeGt3iLzaoUdjNB+Rf5F5xI1XI2gUQUZZ89Kl0GKH89i0Ny9uwJppBfpoXYXON4Q/Mv9PyQCENg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
Subject: [lttng-dev] LTTNG Continuously Crashing on Debian-12
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
From: Lakshmi Deverkonda via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Lakshmi Deverkonda <laksd@nvidia.com>
Content-Type: multipart/mixed; boundary="===============6442725161047955813=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6442725161047955813==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4555A944CE48D7780FF1C39DD92B2MW3PR12MB4555namp_"

--_000_MW3PR12MB4555A944CE48D7780FF1C39DD92B2MW3PR12MB4555namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

We see that python3 based lttng is continuously crashing on debian-12.
Kernel Version is 6.1.0. Is there some special handling that has to be take=
n care for debian-12?

Following is the core decode.
Program terminated with signal SIGABRT, Aborted.
#0  0x00007fb95dac9e2c in ?? () from /lib/x86_64-linux-gnu/libc.so.6
[Current thread is 1 (Thread 0x7fb95d96c040 (LWP 19426))]
(gdb) bt
#0  0x00007fb95dac9e2c in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#1  0x00007fb95da7afb2 in raise () from /lib/x86_64-linux-gnu/libc.so.6
#2  0x00007fb95da65472 in abort () from /lib/x86_64-linux-gnu/libc.so.6
#3  0x00007fb95da65395 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#4  0x00007fb95da73eb2 in __assert_fail () from /lib/x86_64-linux-gnu/libc.=
so.6
#5  0x00007fb95d9efbbf in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
1
#6  0x00007fb95d9f0f23 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
1
#7  0x00007fb95d9ece2f in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
1
#8  0x00007fb95d9dc537 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
1
#9  0x00007fb95d9c73c2 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
1
#10 0x00007fb95d9c8003 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
1
#11 0x00007fb95d9c8003 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
1
#12 0x00007fb95d9c8003 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
1
#13 0x00007fb95d9c8fce in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
1
#14 0x00007fb95d9c2408 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
1
#15 0x00007fb95dd6812a in ?? () from /lib64/ld-linux-x86-64.so.2
#16 0x00007fb95dd6b764 in ?? () from /lib64/ld-linux-x86-64.so.2
#17 0x00007fb95da7d55d in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#18 0x00007fb95da7d69a in exit () from /lib/x86_64-linux-gnu/libc.so.6
#19 0x00007fb95da66251 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#20 0x00007fb95da66305 in __libc_start_main () from /lib/x86_64-linux-gnu/l=
ibc.so.6
#21 0x0000000000627461 in _start ()

Regards,
Lakshmi

--_000_MW3PR12MB4555A944CE48D7780FF1C39DD92B2MW3PR12MB4555namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi,&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
We see that python3 based lttng is continuously crashing on debian-12.&nbsp=
;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Kernel Version is 6.1.0. Is there some special handling that has to be take=
n care for debian-12?</div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Following is the core decode.&nbsp;</div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">Program terminated with signal SIGABRT, Aborted.=
</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#0 &nbsp;0x00007fb95dac9e2c in ?? () from /lib/x=
86_64-linux-gnu/libc.so.6</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">[Current thread is 1 (Thread 0x7fb95d96c040 (LWP=
 19426))]</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">(gdb) bt</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#0 &nbsp;0x00007fb95dac9e2c in ?? () from /lib/x=
86_64-linux-gnu/libc.so.6</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#1 &nbsp;0x00007fb95da7afb2 in raise () from /li=
b/x86_64-linux-gnu/libc.so.6</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#2 &nbsp;0x00007fb95da65472 in abort () from /li=
b/x86_64-linux-gnu/libc.so.6</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#3 &nbsp;0x00007fb95da65395 in ?? () from /lib/x=
86_64-linux-gnu/libc.so.6</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#4 &nbsp;0x00007fb95da73eb2 in __assert_fail () =
from /lib/x86_64-linux-gnu/libc.so.6</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#5 &nbsp;0x00007fb95d9efbbf in ?? () from /lib/x=
86_64-linux-gnu/liblttng-ust.so.1</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#6 &nbsp;0x00007fb95d9f0f23 in ?? () from /lib/x=
86_64-linux-gnu/liblttng-ust.so.1</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#7 &nbsp;0x00007fb95d9ece2f in ?? () from /lib/x=
86_64-linux-gnu/liblttng-ust.so.1</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#8 &nbsp;0x00007fb95d9dc537 in ?? () from /lib/x=
86_64-linux-gnu/liblttng-ust.so.1</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#9 &nbsp;0x00007fb95d9c73c2 in ?? () from /lib/x=
86_64-linux-gnu/liblttng-ust.so.1</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#10 0x00007fb95d9c8003 in ?? () from /lib/x86_64=
-linux-gnu/liblttng-ust.so.1</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#11 0x00007fb95d9c8003 in ?? () from /lib/x86_64=
-linux-gnu/liblttng-ust.so.1</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#12 0x00007fb95d9c8003 in ?? () from /lib/x86_64=
-linux-gnu/liblttng-ust.so.1</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#13 0x00007fb95d9c8fce in ?? () from /lib/x86_64=
-linux-gnu/liblttng-ust.so.1</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#14 0x00007fb95d9c2408 in ?? () from /lib/x86_64=
-linux-gnu/liblttng-ust.so.1</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#15 0x00007fb95dd6812a in ?? () from /lib64/ld-l=
inux-x86-64.so.2</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#16 0x00007fb95dd6b764 in ?? () from /lib64/ld-l=
inux-x86-64.so.2</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#17 0x00007fb95da7d55d in ?? () from /lib/x86_64=
-linux-gnu/libc.so.6</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#18 0x00007fb95da7d69a in exit () from /lib/x86_=
64-linux-gnu/libc.so.6</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#19 0x00007fb95da66251 in ?? () from /lib/x86_64=
-linux-gnu/libc.so.6</span></div>
<div><span style=3D"font-family: Consolas, Courier, monospace; font-size: 1=
2pt; color: rgb(0, 0, 0);">#20 0x00007fb95da66305 in __libc_start_main () f=
rom /lib/x86_64-linux-gnu/libc.so.6</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Consolas, Courier=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">#21 0x0000000000627461 =
in _start ()</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Consolas, Courier=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">Regards,</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">Lakshmi</span></div>
</body>
</html>

--_000_MW3PR12MB4555A944CE48D7780FF1C39DD92B2MW3PR12MB4555namp_--

--===============6442725161047955813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6442725161047955813==--
