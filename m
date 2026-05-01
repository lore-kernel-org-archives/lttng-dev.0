Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A777CCFA13
	for <lttng-dev@archiver.kernel.org>; Fri,  1 May 2026 19:46:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4g6hPY2r4yz1Jw3
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1777664803;
	b=UrRbYVIFuwljp7u16ql9qSMBaIi/pH+vD8HFmLBwJbCcda4WtZSeF9VsX7IaRmaJyuoZ
	 rYnSqqdTb/id8uy8iA2jJjEg7eFpOR7VSRpc74cd9GAj2KUJJWdn+1nVoZ9L5eFoH1U/a
	 qgphp9dCgVW+OQhrqwRVi9+8pcakLGANRJGeSNao0qojs/oj2nIgPUoa/Bv27u1KUnmUG
	 mVLOOREgqLGkUsUWKkYI8Zv0LW74Xbi5IrSGJSPJUKQSS6yuWQW8QHi6WfcLTNo/lJ9Qr
	 VGXpu4Np9OZA2NLTQ0UTU9rTEmVZlzU1wT7Mcsa5RhIWlHo14YY7yyo0f51fK7GHrWg==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1777664803;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=zDtOgZV4SRnkgS7TW+ZK8+Qe+PRfnUZRVPnISzRebQs=;
	b=aEzIjLICQ2C0pOiaKeuyb7HFjR18VxwdMYoSmvdGPZbe0mvGW3g+QwRqPB2++SDnWWkO
	 UjW/ajnJ7tQXA4nqlIwqYEowpdMTjVfsmJ4EsRonWFW2ESQivHx9rB87ZlYAdDwqh6VvV
	 6iKyuFOOy4/iOOoxODHYW8uHGzaMn5gbn31ARiCd7rnr2aOSgF6wZ/hMmmEImkVa6ihG6
	 GLXr7zfJLa9s3WsX0kYpPV9GI3VxXdqb0Y545ILTrWFjeDI9KrUJI8Xu5o1+lSrP4JMpN
	 j7R1xAbqFrTjP2J18muBMiXYHsvOsHE4XdLHBfWj/GFgk67H23Tq8yPNnrIH5VHRSSg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4g6hPY2r4yz1Jw3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1777664803;
	bh=R0MSlZ/8B/kFNw2cEOUfAW7RziEpdIlCHUCih2V+x9U=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=CVkXK7lB2GieXo2z5QpXkpgLux6eVZhi5lmuJ3GW96K9Aya0eXTfcSu6+y0uXiMjZ
	 3C0wy9Mb7U5SApiItv16SxGPxBdKeSsa194AnOdvv3yqemXw2Ag86Y1lh3CIE0Feva
	 Q2WurDECjj5O4xMbg7M9Z5JeXlLobdESfqCH90tCicbJdfCFVW92u463xN/Kg4l0a8
	 EfFPSy88s4BHUGUqxn1ODYeoMaQen1o9bqP3Sa7wxk1bbbMO0Wk+nImzMaoxkYUlrp
	 EbbuCDAmo2XP7iFEukfrUn2iBUIM3/FKVYhvKaS64xnohtQdpO7ymiIr4WOiLSQqQR
	 daPiAZd7aPMzQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4g6hPY2r4yz1Jw3;
	Fri,  1 May 2026 15:46:41 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4g6hPW0fb9z1KBm
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4g6hPW0fb9z1KBm
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by lists.lttng.org (Postfix) with ESMTPS id 4g6hPW0fb9z1KBm
 for <lttng-dev@lists.lttng.org>; Fri,  1 May 2026 15:46:38 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQt5Msk7emxVN9ehJT3/FoxjEP9WawJxsGvVjrWUitc7ZvgjDFl0vfBpr7YBMslky+6IeZBtb7vnuDVtTUgwVtnptdm2PxhMVz79O04GT+sHDnbPwXQJ5gmOw/tV1TBpnlRL2gSX7YOoIveo6G/zxSRhjEo/SQTmX7ZGRy9F9fOjIQDhIYvIz6KipRiqKoTHCPK2azTNfHbWYDz6Iys/EFvwzraALJlNWsHsa9XT3A1Zjqbn+om3SgMHuNi+O2kRZpouMnOXWu7sHgr5tjxKZxH8b+Rwuh1QiKOFJQ+cNR6tSdYr60wzbrMvC+BV/pc+De0IKDf4MkFvLC6IBLDiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0MSlZ/8B/kFNw2cEOUfAW7RziEpdIlCHUCih2V+x9U=;
 b=En8NJq53ZndJYvLwyTqeodPpO7FPnhqRxxUSiJ6o749QY8LkJ1kTTNu9E857xJrhCaz5hn+UW/EKPwf3d1mTBcewOyAL1bB3yRVSKxvDmRyQ/cSkDtzbPZYX1e/n+E5QPyX98gf0F6Ifsdt+8iHAUl1ZjTiDIDY1qReDkDImW9G3yTbGDPCLX8pdJKDtmrbM9M+DPtuw10FtXQwI+PUNDZ2/NWFcw+NXb8EkLZ4exXYo2BoVbnPloPzqY2upNP5Xx3RgQx3pnick1JdR0KdxYzYDPvPwAqB7+24IyOz9dG5mloIyXAuoUdQwSBNmffRGoWCaX9MHl8FdGugkIBjekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
Received: from DS4PPFB691D9211.namprd15.prod.outlook.com
 (2603:10b6:f:fc00::9b3) by PH0PR15MB4639.namprd15.prod.outlook.com
 (2603:10b6:510:8b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 19:31:43 +0000
Received: from DS4PPFB691D9211.namprd15.prod.outlook.com
 ([fe80::938:2f84:23b0:33dc]) by DS4PPFB691D9211.namprd15.prod.outlook.com
 ([fe80::938:2f84:23b0:33dc%7]) with mapi id 15.20.9846.014; Fri, 1 May 2026
 19:31:43 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, David Aldrich
 <david.aldrich.ntml@gmail.com>
Subject: Re: How to show method entry/exit in Trace Compass?
Thread-Topic: How to show method entry/exit in Trace Compass?
Thread-Index: AQHc2MMUe/3CHoCcwUybP6qmxQTzE7X5kI5w
Date: Fri, 1 May 2026 19:31:43 +0000
Message-ID: <DS4PPFB691D9211860531ADD6E93FC33BA79E322@DS4PPFB691D9211.namprd15.prod.outlook.com>
References: <CAJK_ieix5QAMUEhY4R4Cm5tUwZ_W98fG8wrb947GwCW3YR0tqQ@mail.gmail.com>
In-Reply-To: <CAJK_ieix5QAMUEhY4R4Cm5tUwZ_W98fG8wrb947GwCW3YR0tqQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFB691D9211:EE_|PH0PR15MB4639:EE_
x-ms-office365-filtering-correlation-id: 51b7b81e-0ed0-429a-434e-08dea7b8469a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|8096899003|38070700021;
x-microsoft-antispam-message-info: dCzWfX6QfMTYWOwdhsApfFugsV4uYF+Na+JaFPiJOdPh0l31r9x/js3yhwwDo64N8aY18raBukdgWmG9scGQo8OsV93Ru9TZggomeM3c/k4dhfV1H6bFUnXYdBYRV5cTscjIwpJAeWRkjkfoDzTStx7AVVJFZ1D3HV1Oewb2LU+DkIAe82r7j/52uaRnfiqJYCnw4z37XmcwsGaBeTe6DD7A0pJyJU6gpFHKPq6kuJ24ziI1F+RU25SP0jqzgCrxgBZcNWu8Jpg2L93BzXq2ww8IRTckeS2i9ZIxioWgKpRXEki/UXEcvEBOTHWptdnKioDb0CvMuVXOEr6Ftz1Y/38+IRSzUAS+K/+AUYN+Vc3pGbm3gXRarEsIaEuf8nVZblbIN+ZXo+iZzag95+eDeGO1mBbrbvZ91vljGFr5GcNhf1yDYUvDPzgCUzb5w9Pnh1iXk8bUjjxZEN3+rTI5/Usos546/EcB7ivMnOHXFgMm/CxItGTjOvNpwYHqOJM+VHtNGd1jTmifY9tMNyK+8T30z27wh2tJ5eVejmiidkXr/3C4H6MdYc0g7uslC2JKyUd5Vl5RbB8ShyKoIwDX7y0cqN3CcYJ3Kxr0hUtwClshWleEp/OWUXsXKcDRtnmxYuyEwreU1yvG7TBGQ4IqerTsaZ9SNJ/IfCvr+aM5z4bIGX/IYUm/XcxOtjoxk+7qvUY+lZYkG9cnyiWoWBEkHTWL1raLhKwCdACfeKesoYKusZABxclQZgxwvUTzAVzz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFB691D9211.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q58H6LAZdsYwtWznR3C+gzE5eMifEvwlphXoi3gH9RrpULb0HvCgXB6ndyjS?=
 =?us-ascii?Q?7GbbGQAgVgh+GzUq/t/LKn6dQ+0umO8sA2rSkEnj3SAMLS+L5oO/YJZ1OPK/?=
 =?us-ascii?Q?PYgI+CdudrruEaWrFSb+pYuaVAPq/Y/mQhL5lzOInR9oH6j3B39uYLbsO4Nn?=
 =?us-ascii?Q?rs7BbtfE/RRyjUxMi/OsnMzu3sSnim+pO1FOLwYb0+WcUhRy4FQdCZ5gKD36?=
 =?us-ascii?Q?oG8PStbTQ01AAzJQ3ehGPZ/oRtO5ApHWlbqlidLR/efRyG06eI9yB4SH3AKY?=
 =?us-ascii?Q?D+TQ+qVeJBlk4iKAWEE8ONBNoDn9Bli3OOpmuGvdGdQE1darvc8VW3zbZ2ay?=
 =?us-ascii?Q?gmkTLuMxcxB/Abx5HOPqfqGIoDTo+6JqtKtpDCk7wsVyiShGWsNAUur2IgqQ?=
 =?us-ascii?Q?9cBlMG5wfl6fiqTVOuj4wdXFcn19gJHScr4Pr03JkXVzI1onYA6Nq1XXLy1v?=
 =?us-ascii?Q?xhu6SNDJq0SVDpj2Xf0u5Gdp73/PREa895aJJDQ+2tkBkEYhiEqOBiLxBvD4?=
 =?us-ascii?Q?mIhVML6KrDgNgJPazS6I2o9v2KAS3KSjokMy6JNmKKeaCAYsms0VFQ03KqKr?=
 =?us-ascii?Q?JpxGuuQSvOfjTxnvp/JQmhjvfu+ZhmWn8B8BA2ZuDsuwUwK/FujVYcdGsFna?=
 =?us-ascii?Q?GGbwCbsYFJcx/6Nor5QzrAkCGRTW263UGNylbNPk27LxUVqlalAAtEdlDJCs?=
 =?us-ascii?Q?lv6D9JqmQzl/OE3ipxPR0BZ2XipekUp2devp2+B/tkrlX/+3nU1JLHEzDNWE?=
 =?us-ascii?Q?LLkkmPYnTIF3s4Usv8VvcMnC1zEDZ7zWBHITXugca0RD971rBYLZhhbNJXdV?=
 =?us-ascii?Q?l0XOCxfEcTwHsZyWpiB79Xz1S8Gwd1mAcuAkG9MnzWEBrRgaQYLlXegzaKxs?=
 =?us-ascii?Q?mU8AGL9GT3VqkBQTEXP1Cf93QQaTiaWpdNzlsIjm9SF4+SlCZx+iua/087mC?=
 =?us-ascii?Q?21Ws/inWsRHwAF/jPbxzIGcWJhQL1TaXsoOQ38PSKmeCktrXbb8Vg3XUUE3v?=
 =?us-ascii?Q?BGsOdQt9ylc8uBQ/eDeODJuWg2teu8itCzFyhTtLkDFMxxVPtWCgZXKyrPXH?=
 =?us-ascii?Q?RVBZcnFNAChNxbOQ1iShdJgATQwbs00C0F7pBUEz0U3hF0L1D+ZN1l+fP1oB?=
 =?us-ascii?Q?l23Evcdz5SiXUR8jRblw5m5U0eXrvBvd/Zj/gCzsRwx1KPcPu8Uj4rZ1Ul5w?=
 =?us-ascii?Q?/wx9zEJou5vYDkk3bccY3xYnVZ9/mGJtkFP/K4c/adKgfFzVmO9PV8jLe+FJ?=
 =?us-ascii?Q?/7PZrY57Sqw6q6NN2mW7CHmikP/h+7dJffW+5ZnNzptmDwYnB8z8j1D5No2N?=
 =?us-ascii?Q?UbCJLQhSiFma7EOrVl+fNqSepbfC2kAnjc94Hj4LArQFkR5d4l3/8JyULVhU?=
 =?us-ascii?Q?SU0OuK5uYTCViDnQY05H8HsjgHCUKNr82F1dFMLJRW7wRW7iTAQhJCHpHb+K?=
 =?us-ascii?Q?RZKxYdh9vIVthg0SepFEFZh3kOsSWIzoTDUQp4wcMijG7KwtYgvyORYiEC+J?=
 =?us-ascii?Q?EuVeRSthhItbXcDqltqGkZ3iH512GVcwnTWU1vfuaxiTZWl2TnOpTiehKHEd?=
 =?us-ascii?Q?sECk3TuWlYyg6tW9SIDyGQohwLdqd/9jQqMxcDjz8DHGCDQvOSPmDdnR9gSG?=
 =?us-ascii?Q?iR5lf0lmmpkiX9wh9vGnluSEuEsxVU7fB20JTkgNGHhbTRNsiXA9VQ9mchix?=
 =?us-ascii?Q?1IEyDrvt1Kq2O/n/Q3WeI5a1p28ty1RmPJ11ZumqYntPxsyj9Pgv7yDWmeQP?=
 =?us-ascii?Q?lF3EjhU9Ew=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS4PPFB691D9211860531ADD6E93FC33BA79E322DS4PPFB691D9211_"
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFB691D9211.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b7b81e-0ed0-429a-434e-08dea7b8469a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2026 19:31:43.2934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WORgKBQpz9W45+YwcQ4lbaa9Fj3cJGDbeyHNXE2uzA8cQ8IuURR8BV0wIJrEJkvxCLYlbdJg8Pf27vHC7DUCfOokCK2Iv1TPM68DG0mlcJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4639
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
From: Matthew Khouzam via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--_000_DS4PPFB691D9211860531ADD6E93FC33BA79E322DS4PPFB691D9211_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi David,

I would love to look into the "lost event". Can you share the trace? maybe =
it's an easy win.
________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of David Aldr=
ich via lttng-dev <lttng-dev@lists.lttng.org>
Sent: Thursday, April 30, 2026 7:01 PM
To: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Subject: How to show method entry/exit in Trace Compass?

Hi

I'm using LTTng 2.13.11 on Ubuntu 24.04 with Trace Compass 11.3.0 on Window=
s, to analyse a C++ app.

I have used LTTng and Trace Compass a little to instrument our user space a=
pp using  lttng_ust_tracef(). I now want to show actual method entry/exit p=
oints in a Gantt type view.

With help from AI I instrumented entry/exit for one method. Babeltrace show=
s that the trace files contain those points:

<time> sr1  myapp:method_entry: { cpu_id =3D 4 }, { class =3D "ThreadPool",=
 method =3D "mainLoop" }
<time> sr1 myapp:method_exit: { cpu_id =3D 6 }, { class =3D "ThreadPool", m=
ethod =3D "mainLoop" }

But when I import the trace into Trace Compass I see the events but the tra=
ce shows only the app name, not the method name.

What am I missing? Is there a user guide article that would help me?

Best regards
David

--_000_DS4PPFB691D9211860531ADD6E93FC33BA79E322DS4PPFB691D9211_
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
olor: rgb(0, 0, 0);">
Hi David,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I would love to look into the &quot;lost event&quot;. Can you share the tra=
ce? maybe it's an easy win.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> lttng-dev &lt;lttng-d=
ev-bounces@lists.lttng.org&gt; on behalf of David Aldrich via lttng-dev &lt=
;lttng-dev@lists.lttng.org&gt;<br>
<b>Sent:</b> Thursday, April 30, 2026 7:01 PM<br>
<b>To:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Subject:</b> How to show method entry/exit in Trace Compass?</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">Hi<br>
<br>
I'm using LTTng 2.13.11 on&nbsp;Ubuntu 24.04 with Trace Compass 11.3.0 on&n=
bsp;Windows,&nbsp;to analyse a C++ app.
<div><br>
I have used LTTng and Trace Compass a little to instrument our user space a=
pp using&nbsp;&nbsp;lttng_ust_tracef(). I now want to show actual method en=
try/exit points in a Gantt type view.</div>
<div><br>
</div>
<div>With help from AI I instrumented entry/exit for one method. Babeltrace=
 shows that the trace files contain those points:<br>
<br>
&lt;time&gt; sr1&nbsp; myapp:method_entry: { cpu_id =3D 4 }, { class =3D &q=
uot;ThreadPool&quot;, method =3D &quot;mainLoop&quot; }</div>
<div>&lt;time&gt; sr1 myapp:method_exit: { cpu_id =3D 6 }, { class =3D &quo=
t;ThreadPool&quot;, method =3D &quot;mainLoop&quot; }</div>
<div><br>
</div>
<div>But when I import the trace into Trace Compass I see the events but th=
e trace shows only the app name, not the method name.<br>
<br>
What am I missing? Is there a user guide article that would help me?<br>
<br>
Best regards</div>
<div>David</div>
</div>
</div>
</body>
</html>

--_000_DS4PPFB691D9211860531ADD6E93FC33BA79E322DS4PPFB691D9211_--
