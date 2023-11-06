Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3A8C4332F
	for <lttng-dev@archiver.kernel.org>; Mon,  6 Nov 2023 07:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1699256639;
	bh=6Q45U4zgLdvEMDLG8CrLg1PU3BZ39axBY63MpPBix0g=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=0P+vkWLQvCrVmXZJQ54/NZqG0e/DbXFAEs17MapKEy7AO5TV+rtcYmybPorQc4vog
	 PePK9gMnB7TW9oG1kNGYgR5eACRIKzraqZ1qHyEyipASj6wuNZYB/OiWhSNDQps4J4
	 ZYRJGcrvDQkfh8Ee3j5QsLTwOdZkHGHO0KVk5gNVfRAYs/IL9iybR6mJE8prTPsQMc
	 fHPXe8brQAjvaSseV4gDDE4wyG28w+xPEkSc0hP13Pz1IXtLcOFaUkuRROjiAGWE2d
	 s33eJXokHVW3JT9RvcZrzpFYeIA5/GMLqMH6m3DeGbnz7RgHNweknFkBlA4r5dfWrA
	 pMqWhKDRry0iA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SP3JG5NwwzDJk;
	Mon,  6 Nov 2023 02:43:58 -0500 (EST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2125.outbound.protection.outlook.com [40.107.22.125])
 by lists.lttng.org (Postfix) with ESMTPS id 4SP3JD33pJzDM0
 for <lttng-dev@lists.lttng.org>; Mon,  6 Nov 2023 02:43:56 -0500 (EST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=QzMe2/qjRphFNqoU28mAkaYKh7gRMgpkMuevilUVR4Q/2iOBc8TIF/wTP2KavJZuz+uZ8KswatrQUttwPugHe8nZd6+9mGPiEa3U5XTVlvQpvQc1qdsNBUACY5QBYI5HtZdJlFTwi8n60ksJXfiyh6rX04ow6QL6D5yCNZizBQpxuYLZd0qeITUeOmuBmQnMQ3+0JwX1JriLACTkCB4+nMw8npFxztd8rZaxeaWeUODsaVHyihveW7daF6wSg2YbzvniZn0t+0koPDc8Kayc4ZCOFKLWON5FLveq3TElO6lvX+ar8p2hPpPBOvS+IhL8+VlS3mU3JtiDl0FZ7moFbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xu1t2r6V2hxi8MK9cOyuvl8FO0ZzwktDH2X8D33wpN0=;
 b=og3DEn1zaY+py6wjYvz0fa3I/SOgq93+f2w+pUvpDlisE4/hXRVZ3u/iSp/vm9N0mzW+mmgqx09UUGfJ5gKWkp/lwnCROSH38T+dxVjAaFu+nxbpC4SqmdiE+F/2cZc3mEvNm5rLS0pNHY7AIe9iflRGuYQcZYGzPp1Oo6kNH1CG6R9iclTmp2/3yRbkX4Mrb+qRAqpHQD+C/6J+9vyObTdj7xV9S3TawKILmQjUbl0Aq9DBAu7xLpk30GCKwqxL+BkNuub7jzW4Cp7g87fj3ALSekotMv/5iapnD2f8wH4fMxdSdH+8Hpbq/YOEWrM9ycLHpUmPvmXNZylpnG7Lgw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.11.40) smtp.rcpttodomain=efficios.com smtp.mailfrom=zeiss.com;
 dmarc=pass (p=quarantine sp=quarantine pct=25) action=none
 header.from=zeiss.com; dkim=pass (signature was verified)
 header.d=zeiss.onmicrosoft.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=zeiss.com] dkim=[1,1,header.d=zeiss.com]
 dmarc=[1,1,header.from=zeiss.com])
Received: from DU2PR04CA0288.eurprd04.prod.outlook.com (2603:10a6:10:28c::23)
 by DBAP190MB0824.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 07:43:54 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::d6) by DU2PR04CA0288.outlook.office365.com
 (2603:10a6:10:28c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27 via Frontend
 Transport; Mon, 6 Nov 2023 07:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.11.40)
 smtp.mailfrom=zeiss.com; dkim=pass (signature was verified)
 header.d=zeiss.onmicrosoft.com;dmarc=pass action=none header.from=zeiss.com;
Received-SPF: Pass (protection.outlook.com: domain of zeiss.com designates
 104.47.11.40 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.11.40; helo=EUR02-VI1-obe.outbound.protection.outlook.com;
 pr=C
Received: from jegw1.zeiss.com (18.192.202.217) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 07:43:54 +0000
Received: from ip-10-25-10-14 (localhost [127.0.0.1])
 by jegw1.zeiss.com (Postfix) with UTF8SMTP id 1737A1B620D;
 Mon,  6 Nov 2023 08:43:54 +0100 (CET)
Received: from kag06088vm016.zeiss.com (kag06088vm016 [10.25.10.115])
 by kag06088vm011.zeiss.org (Postfix) with UTF8SMTPS id F19061B6F52;
 Mon,  6 Nov 2023 08:43:53 +0100 (CET)
Received: from ip-10-25-10-115 (localhost [127.0.0.1])
 by kag06088vm016.zeiss.com (Postfix) with UTF8SMTP id EEE7C1B6554;
 Mon,  6 Nov 2023 08:43:53 +0100 (CET)
Received: from kag06088vm013.zeiss.com (kag06088vm013.zeiss.com [10.25.10.9])
 by kag06088vm016.zeiss.com (Postfix) with ESMTPS id E0D441B655E;
 Mon,  6 Nov 2023 08:43:53 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02lp2040.outbound.protection.outlook.com [104.47.11.40])
 by kag06088vm013.zeiss.com (Postfix) with ESMTPS id D65E8BBAA7;
 Mon,  6 Nov 2023 08:43:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMbFyEyysmyirVdnf7Wjiqonl7x3Uv669aM8ocr3ulp8oWdAqyjE2dg4IpvJjVvOuWud4JQvidsshlmmATU0XTCMaDozu+S/JuM3vJ3SORvA5pCjzJxahigt/XiVHyaatknd1q0RePvwNmc/LnvciFM3fPitzAyGfRTrKOfVJhn3bAN20soDus16+l0FnsymvgY0/U0l2f54TDjeKxnj/A5MGXpxS0i7pA38NeC7ztqjr1lwlH9q40mcTmbFIHQGZtWq67w3UMRNv5j+aeZxu2ZJ2kBT8li1hc4TrwvgdiMM1DluEENMbjdnLjnfrLgWUH0OyPBpGiTRYE/HEyRuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xu1t2r6V2hxi8MK9cOyuvl8FO0ZzwktDH2X8D33wpN0=;
 b=Htc2XU2yawd6kiclXIWEoBhAmV2b4l2gx5pYaJQICB+SEz7Mdy71QcIYTD9Ublo4G/gZ9vEsJtKw5g71hNzM00+/v4tvTYV+CX2iz0XzTVIhYezhr+ZgcLNHsWcf3QO8wcs/yhRh13ON+JBEIqSA+x+sW8o6QtIFmoOAFOmnKfI76W9PVR1uH8tj+ARto5vF5BUvomcCEghFm+f5XcumST2x2OB9debKjutDczu6ZxXJb7qYH0lAz/DqfbcoVPhQv9hRlsVwnNyUZIGGIUOgqqupVCz0MBQ9+p8BOth5RrcZPAaNlPhbg/vm2D7vdD2Jnrh5TalqhTe7RdiKYXxNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeiss.com; dmarc=pass action=none header.from=zeiss.com;
 dkim=pass header.d=zeiss.com; arc=none
Received: from AM9P190MB1075.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:265::21)
 by AM7P190MB0744.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:11d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 07:43:52 +0000
Received: from AM9P190MB1075.EURP190.PROD.OUTLOOK.COM
 ([fe80::2420:63f:8bb2:29fc]) by AM9P190MB1075.EURP190.PROD.OUTLOOK.COM
 ([fe80::2420:63f:8bb2:29fc%4]) with mapi id 15.20.6954.025; Mon, 6 Nov 2023
 07:43:51 +0000
To: Michael Jeanson <mjeanson@efficios.com>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] Building the Babeltrace-Libary for Windows?
Thread-Index: AdoOSZigLlS0YfWxQRmI49rDydJC/AAF2vSAAIek+eA=
Date: Mon, 6 Nov 2023 07:43:51 +0000
Message-ID: <AM9P190MB10759C317F92C6DF8CE429B688AAA@AM9P190MB1075.EURP190.PROD.OUTLOOK.COM>
References: <AS8P190MB10771A3EB2AFC92E4540399E88A5A@AS8P190MB1077.EURP190.PROD.OUTLOOK.COM>
 <a822b4bf-47a8-4396-a82e-af8589e165b8@efficios.com>
In-Reply-To: <a822b4bf-47a8-4396-a82e-af8589e165b8@efficios.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zeiss.com;
x-ms-traffictypediagnostic: AM9P190MB1075:EE_|AM7P190MB0744:EE_|DB1PEPF0003922F:EE_|DBAP190MB0824:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e462a28-dd39-4dce-227a-08dbde9c2078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /pEs/fbkz1VYCPCyFYTX52NKRYkifl/gECtPUkFPsIzyFX2qWMPGSofQAWUb28LVRVGBg2Gp1mwjS+41t7pJeLPlfKA8+Cr+J0jKD3i06PoA3EmPiypVSGOVdFXj+YX3i2thS/Vsppse8mt88lVINpVRjyTkmTYdaUNsbW6nJP/2BR/BvsVgaAE/3v1DTZrKkd5Lv5qbHqwvQJdM472SrqMIeVxIq0G7atCj0grXioUE+fHfTf51ESisIwR/LvhK5wd+hm0Ljs7NEe9KxYocY6PumD1ofSwp6UxulZtG4P07m7kGuPXPoSxU4redAyXd+WreEbnevXvA/2mKwsJL/OCngJgnIBF44mWf1D2QcIr9DcFTujIfmIq/qjhrEp/WbNRV6NwFTe6ilwiEdTxA/y0mxPReGAE3PQfA38mGDgjI5UgBwjmic3ZQ66DYIiWCkUdOm49c7VTzrIaBgsrGuQxReMmSJl3f98WtZUYxAIdpUrzwhvE1t+9J9q4avQzad1JxsoAbavz3e9KX3OxxqHVjX1pEbHhIrIpoLfp7SDJ/KMapczXTnxJpYlkK2Ps6VNXyROu+dxoiczHo7jWPa2ER1um+Q5tHQfYxbX0WyUw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9P190MB1075.EURP190.PROD.OUTLOOK.COM; PTR:;
 CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(9686003)(41300700001)(45080400002)(7696005)(6506007)(966005)(71200400001)(316002)(52536014)(8936002)(8676002)(76116006)(5660300002)(66556008)(26005)(66476007)(110136005)(64756008)(66946007)(66446008)(38100700002)(122000001)(2906002)(86362001)(82960400001)(15974865002)(33656002)(55016003)(38070700009);
 DIR:OUT; SFP:1102; 
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0744
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.11.40];
 domain=EUR02-VI1-obe.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender: ip=[104.47.11.40];
 domain=EUR02-VI1-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f0d9f854-baac-41f2-3423-08dbde9c1efb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T4bfp9OnrfzJeap7ri36VTErJAU7l1/I0zIyoAK0tntXXwkJUtwoH3aRIXyouXIr1VKinN+xukYCp2H3K8ru1ci58UvnZLLQlUY6xI7LwzBSxkrJYildKDPA+3k5fJW6Of/MIJAzI60os3eeHPlUoVKBQG2x9rvbjjcKc48/8DGnqqUqp9xDDGdu0tXPfPzZD/eTB8854oGiZYTfnIEO/zSqOQtpz3YssQAxaFpujpaC7i/0nzFD4rCE3elI8jwJAdbTo1wLhfbAbiimbCGnpDEj7fOZqa4DlzbRudx7y/DFPWPR6hfWhAtAatRIR7mKgkbHedj0kek5pg88jJ05FnjAPZQSpcjRIdtI1lhcY3q8tSX9u5CnBkcKM9/4zHEdT16zcsMVwgOP5Yy7+b47iESF1fdaNyUZMT+3FpKr8BOZFoNEGpkOyzCQwaF3JlriTCd1cchjwoTvvZb9BrYVRBJdnKh/IGZ24l5XWY9gIK974inrV1+l1J9+lpklmrrzg2wJpaNMpU72jBN0oFjalgf2M6XaQTmey24/IlQH67VyZA2+2WuFkIfXiu7jz8HOTV4z2Y7tN0vYAZDkZH7v45XW7FY5QLjtoko9hhM+d34Y0Qc5dXIbF0zdFGRnrZoVAzkFepq12W21zRoumvs3uFLrAkylh46rA2ah1p7uL2AWP5d5t6wsAjI2z5GOncpUOvObR0kAzMOdxpTrYawEL5bxroT0KQbj1Ubja4l8M0n3IU9KP8zvLwFTWXlsDbU60vsYQyP3+84DrtifmnjbR3kKXd3BtxoJyA5a5gsj78c8uG1pbiRKUBCubP+fuHkFHeIG988PsX2yTp4eQxCNV8JNcVYCfObxcvqR+bRzFgIpS0wF6NN9UXDxJ1urV7mcnzqIi0UfJVcg8hV8UexDadI2vNTPFby9zZPLz8T5VsE=
X-Forefront-Antispam-Report: CIP:18.192.202.217; CTRY:AT; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EUR02-VI1-obe.outbound.protection.outlook.com;
 PTR:mail-vi1eur02lp2040.outbound.protection.outlook.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(55016003)(156005)(36860700001)(7636003)(7696005)(6506007)(47076005)(40480700001)(32850700003)(40460700003)(336012)(9686003)(82960400001)(33656002)(86362001)(41300700001)(2906002)(966005)(52536014)(8676002)(8936002)(5660300002)(110136005)(316002)(70586007)(70206006)(82740400003)(26005)(478600001);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: zeiss.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 07:43:54.3284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e462a28-dd39-4dce-227a-08dbde9c2078
X-MS-Exchange-CrossTenant-Id: 28042244-bb51-4cd6-8034-7776fa3703e8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=28042244-bb51-4cd6-8034-7776fa3703e8; Ip=[18.192.202.217];
 Helo=[jegw1.zeiss.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0824
Subject: Re: [lttng-dev] Building the Babeltrace-Libary for Windows?
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
From: "Seidl, Aron via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Seidl, Aron" <aron.seidl@zeiss.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Michael,

Thank you a lot for your answer! I think I can work with that.

I set up the msys64 environment with all the packages that I need to build,=
 except for glibc. I ran the script and as always does the build process fa=
il because I can't install glibc in this environment.
Even building glibc from source fails, because the system is not compatible.

Do you guys link babeltrace to a different C library when building on windo=
ws, or is there a way for a possible workaround?
I'd be super grateful for a little more help!

I wish you a nice day

Sincerely,
Aron

__________
Aron Seidl
DH-Student IT Education

Carl Zeiss AG
Carl-Zeiss-Strasse 22
73447 Oberkochen, Deutschland

aron.seidl@zeiss.com
http://www.zeiss.de/
__________
Carl Zeiss AG
Sitz der Gesellschaft: Oberkochen, Deutschland
Vorsitzender des Aufsichtsrates: Dr. Michael Bolle
Vorstand: Dr. Karl Lamprecht (Vorsitzender),
Susan-Stefanie Breitkopf, Sven Hermann, Dr. Christian M=FCller,
Andreas Pecher, Dr. Jochen Peter, Dr. Markus Weber
Amtsgericht Ulm, HRB 501 555, USt-IdNr: DE 811 119 940






-----Urspr=FCngliche Nachricht-----
Von: Michael Jeanson <mjeanson@efficios.com>
Gesendet: Freitag, 3. November 2023 15:21
An: Seidl, Aron <aron.seidl@zeiss.com>; lttng-dev@lists.lttng.org
Betreff: Re: [lttng-dev] Building the Babeltrace-Libary for Windows?

On 2023-11-03 07 h 48, Seidl, Aron via lttng-dev wrote:
> Hello guys,
>
> after it was finally possible to debug Babeltrace properly, I step
> onto a next problem.
>
> I apologize in advance, but I'm new to Linux development and even more
> to cross compiling.
>
> Is it even possible to compile libbabeltrace for Windows and I have to
> dig deeper, trying to understand it better, or did I just waste 3 days
> of my life trying the impossible?
>
> Maybe you guys know a little more.
>
> FYI: I installed every Mingw-package on my machine, and I try to
> configure the project as follows:
>
> ./configure --prefix=3D$PWD/install --host=3Dx86_64-w64-mingw64
> --enable-built-in-plugins --enable-static --disable-shared
>
> The configure-phase runs well, but the make process fails.
>
> I hope it is the last time I have to ask you some questions. I wish
> you a great weekend!
>
> Sincerely,
>
> Aron

Hi,

It should be technically possible to cross-compile babeltrace2 with Mingw o=
n Linux but it was never tested, so a lot a small fixes to the build system=
 might be required.

What is tested however is building with Mingw in an MSYS2 [1] environment o=
n a Windows host. You can have a look at the CI job [2] for the details, th=
e configuration including the build script is publicly readable in "View Co=
nfiguration".

Cheers,

Michael

[1] https://www.msys2.org/
[2] https://ci.lttng.org/view/Babeltrace/job/babeltrace_master_winbuild/
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
