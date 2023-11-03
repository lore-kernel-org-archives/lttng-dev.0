Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A10C4167D
	for <lttng-dev@archiver.kernel.org>; Fri,  3 Nov 2023 11:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1699012106;
	bh=JgPjnBIAxkKUX/JrINOfv0bTWNfLQOSP06mU0PrKqps=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Np540Enr6mjjmBkWhKqTPz7Cp/USJfnAkCX0fsxWl85Ig9uKIvtlyoCBdTe5deD8o
	 YaG6N7NYpHJXpD5AEO17lwY9mC+qGp4ERceKRzhz99hrmzMeZkAkH7dpe6zA39LgXG
	 7gQfhkeqPT94YGjCbN8jgeB2fiuJUAG9eoCc8u/xVIvGNxhvSoz4NkEmDkadvIrCCP
	 HH52+HG07uSaYKevVp5MQWGtuZz+sxu1XVIEeNL9n3b69iAWRPAQNsH7gQ34paQ4eX
	 /nzo278+C2iAvUsGwju53/TbpClKbwKQ/UyaI5AeYD1xQPt1GIHXREwhKwWruI91S7
	 qxtyj6hmXCMbw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SMJsj6FdFzCKl;
	Fri,  3 Nov 2023 07:48:25 -0400 (EDT)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2106.outbound.protection.outlook.com [40.107.20.106])
 by lists.lttng.org (Postfix) with ESMTPS id 4SMJsh1TR1zCKk
 for <lttng-dev@lists.lttng.org>; Fri,  3 Nov 2023 07:48:24 -0400 (EDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=ZeGwTiqdcO5oDiyLbGYHPSxXMlkR1yZsI7zKaYAbfmlOqjaLUgjktE0kVrOXcTCofOdaZY0vXaiGxtenH+OvgCKXXlLmpBBV/7hnBbAaCZ0D6G0dZvQzYwr53LHouJd9epMHX5faVMsRgqNQNijxEDmQSjGpEpq7sgE2E4/byu1C3SPTGiMDn9vjWneqQNgi7Z0nPzItyEG0Qmah1TkDX/m/32J4mLIHzGt43HSsuMiDZISvaWZhLEu0/vbVoXGRy8jyRChe+S3kJCLPnhEhN1mdewwmjDnZoKl7Jp4ZU360opOo8G/5vkupjSidAIUQUS8BthOoZaV0vMQID6IHjA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjxPx16gqA7P4iEaw7YWtCqGTPMrz39rXkAEK/05WCI=;
 b=JEhG8TnM39OIIhXps1mEjD09EsinGaoLV1PXtMkPQrhsuwIYwHm624B3WZFa4dmozRk7+DA0L+5YbOgzk3g7Gbmk8vmGA5/ZGORyp1p52dQTgjCgIAAriaVS7Xp8RfoZOtxFsU4+z8KV1IogGnAg1yQMIz05tUXq6rzoNIL4F29i9otUoA3oPTCpT9rltFLVineEaeEt7I2OHJug6baulAUNphfofcX8ikBB4WdQSBvAFXVHuzI4xxB6oTCKuAePP8Gywuvx2jlR6k5r++Bhqs/Vecje2tnZondtmAjf6M7GIV+jY2Pj+RvvffopAOP/9HaVGFEaf9lpN8rPKKJkTw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.51.233) smtp.rcpttodomain=lists.lttng.org smtp.mailfrom=zeiss.com;
 dmarc=pass (p=quarantine sp=quarantine pct=25) action=none
 header.from=zeiss.com; dkim=pass (signature was verified)
 header.d=zeiss.onmicrosoft.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=zeiss.com] dkim=[1,1,header.d=zeiss.com]
 dmarc=[1,1,header.from=zeiss.com])
Received: from AS9PR06CA0160.eurprd06.prod.outlook.com (2603:10a6:20b:45c::23)
 by DBAP190MB0933.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 11:48:22 +0000
Received: from AMS0EPF00000192.eurprd05.prod.outlook.com
 (2603:10a6:20b:45c:cafe::13) by AS9PR06CA0160.outlook.office365.com
 (2603:10a6:20b:45c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 11:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.51.233)
 smtp.mailfrom=zeiss.com; dkim=pass (signature was verified)
 header.d=zeiss.onmicrosoft.com;dmarc=pass action=none header.from=zeiss.com;
Received-SPF: Pass (protection.outlook.com: domain of zeiss.com designates
 104.47.51.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.51.233; helo=EUR03-AM7-obe.outbound.protection.outlook.com;
 pr=C
Received: from jegw1.zeiss.com (18.192.202.217) by
 AMS0EPF00000192.mail.protection.outlook.com (10.167.16.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 11:48:21 +0000
Received: from ip-10-25-10-14 (localhost [127.0.0.1])
 by jegw1.zeiss.com (Postfix) with UTF8SMTP id 5732E1B5A51
 for <lttng-dev@lists.lttng.org>; Fri,  3 Nov 2023 12:48:21 +0100 (CET)
Received: from kag06088vm016.zeiss.com (kag06088vm016 [10.25.10.115])
 by kag06088vm011.zeiss.org (Postfix) with UTF8SMTPS id 450AE1B5A2B
 for <lttng-dev@lists.lttng.org>; Fri,  3 Nov 2023 12:48:21 +0100 (CET)
Received: from ip-10-25-10-115 (localhost [127.0.0.1])
 by kag06088vm016.zeiss.com (Postfix) with UTF8SMTP id 4270C1B5F48
 for <lttng-dev@lists.lttng.org>; Fri,  3 Nov 2023 12:48:21 +0100 (CET)
Received: from kag06088vm013.zeiss.com (kag06088vm013.zeiss.com [10.25.10.9])
 by kag06088vm016.zeiss.com (Postfix) with ESMTPS id 34D3A1B6561
 for <lttng-dev@lists.lttng.org>; Fri,  3 Nov 2023 12:48:21 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2233.outbound.protection.outlook.com [104.47.51.233])
 by kag06088vm013.zeiss.com (Postfix) with ESMTPS id 2D6FABBAD4
 for <lttng-dev@lists.lttng.org>; Fri,  3 Nov 2023 12:48:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlXCKcjrDAcmNR3AUf9DRNQK5C7Bf13hHiDACJXNjr1oC+iKAY6egr0vBsov9OS6mXnSCEtAhu9ibkxgmFimbEe/crRrtxrImCwBpPRZRJBIz84nnsAMkmg/EJaqvDsNGKMIHDphXquD5E0migEYc7qgGiTfwnlxXNbNdHRpKI0HgqhbDRrhVnHfIUbZtf+my4HZwc8nQiD85ApsZY1GhL8zYEYTTmmZrvBtIiigs+fgNG69HockYrDZ3bieuNieyf2EWs5ULri2v3qRKpeEZFeIG1byBvuQz4uo9ggauZ3Du8bdy2FP0N6erK1hOLg5AxWkfX0h5Xz+yOpK5htAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjxPx16gqA7P4iEaw7YWtCqGTPMrz39rXkAEK/05WCI=;
 b=LmHoFx+AmMdYZbc2J5Z88/ge6IwssFDkf/6xVdQfP3p0HRkbJzxkQqUlHlBZ2YSjw3FDOPr4ijoV+5hAODbGrgr6ed3vEikkQNp1LLMfaKw0fu6HztnCDsm+vxNmN+c5En7xjS3hwV5wWLDnN/NoDujiAyZZe9NOs8A7pXpCeoFMm+uhaHeVx0cpf9WFh59NJRA/5O8YvLGtqGaj/9boGXJ16cGKsBHU3/IA+x9Wg6eItVZxR9eayfTz/46ZWBNRm7jGphqpaT6EKTLgneeie3OY5nkvkCreuOwbuIEB9wzsnr2mzultIwmL/U3jRT4VWKHgF3wbJ53dy3PCAdP4qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeiss.com; dmarc=pass action=none header.from=zeiss.com;
 dkim=pass header.d=zeiss.com; arc=none
Received: from AS8P190MB1077.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e2::18)
 by AM7P190MB0758.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:117::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 11:48:20 +0000
Received: from AS8P190MB1077.EURP190.PROD.OUTLOOK.COM
 ([fe80::977:835a:2894:6258]) by AS8P190MB1077.EURP190.PROD.OUTLOOK.COM
 ([fe80::977:835a:2894:6258%7]) with mapi id 15.20.6954.020; Fri, 3 Nov 2023
 11:48:20 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Building the Babeltrace-Libary for Windows?
Thread-Index: AdoOSZigLlS0YfWxQRmI49rDydJC/A==
Date: Fri, 3 Nov 2023 11:48:20 +0000
Message-ID: <AS8P190MB10771A3EB2AFC92E4540399E88A5A@AS8P190MB1077.EURP190.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zeiss.com;
x-ms-traffictypediagnostic: AS8P190MB1077:EE_|AM7P190MB0758:EE_|AMS0EPF00000192:EE_|DBAP190MB0933:EE_
X-MS-Office365-Filtering-Correlation-Id: 842ba838-d9ad-41e5-379c-08dbdc62c786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Be98iq1IofDalnZW7JDanPw99aeYCGgW33D3SPsIbIqqQ2e9KAQPU5AKu2EclNqldIc85aT2uYR/8AAlRK8UAnfbIqGM+BEI5MM6SKbmGzWRyekOn0tM+7nd96Bc+4aflCRRMEPGcyG6Sfm3w4dRegzq1ym46Q48+c95IJzRtM+Xy4aLgC7WvDCtQvCvwO/Sr+s7ZIdtvNtjZ/9aFWsNs8FiYVBcMZtQSSAWfwfoX24fMLOdef/Z8Uzl63kkH2H93oirZg+KMOlUFWqdFSpbBIeiFUbgibeVUY9QwvnQV/upD4vGma7NGl8VjkBTDIw5aYd8XEdklizqN+toffcyktT91KQreV7x4ooYQd0ihvqvaw34exyvHDJ3EP3YGXXLnH0noZ7S3T+Lmq45GYl5TWhe2NKHO1S+EqwL2pYgPgYbbAHIRvP7gv/DcpP28i/4p2Fylse5gojy9ZpsXKrAgeJ5xsgOYsbmoiMu9qS33Ac/ud0fT0+jVwA0F2v4hsIbCylFhjwa6AHwn0XM5XsLtlUApnbhhUvnNIA+yXoyAB35OrtAAzXQXuJgmvlOfSZf3Rq5fp5w8GAHQpamBk0Z5dLLIrnhVB8+snVcHSI8kl4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8P190MB1077.EURP190.PROD.OUTLOOK.COM; PTR:;
 CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(55016003)(9686003)(26005)(478600001)(6506007)(71200400001)(7696005)(2906002)(41300700001)(5660300002)(66946007)(76116006)(8936002)(8676002)(66556008)(19627235002)(66476007)(66446008)(52536014)(6916009)(64756008)(316002)(38070700009)(166002)(38100700002)(122000001)(82960400001)(86362001)(33656002);
 DIR:OUT; SFP:1102; 
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0758
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.51.233];
 domain=EUR03-AM7-obe.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender: ip=[104.47.51.233];
 domain=EUR03-AM7-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7c283629-2373-4b2b-cd7d-08dbdc62c6aa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylf9VTyB2rIksBnnhPo5gTNARmAks5amdUDTl4qZ7xBI/HpB5t8x1hm+kS1Bu/hfzYYJKU00SK+3Ac1jxmoF7utH7gYbyDJXIw6OhOoLLED0Chs3s1XcuNOSQo6H5PC83XWefSMbdzLPWGXeoTpaSNt+T5R70ynJZvArZH5omryRrBB9N2ff2J7ryU7vtvVeCBvPmHbb5L0FX2oRH1/pQtuQcwFnGrhC/BXSgPq92bcKqadwrzcJ8Vjw4vfxZW30xVjdtuzG6aRScNEPr50kyag+qI5wly8GmiJWJ5Hlz/Rf0SCB8X8+xWAQNzlLY3UuTfkeJxvf8SEQu89qotNarpgxsGZWs0euX21UQfEAdm3/pW/ZzUUdHCWjAJU5m3qpJX08HwsL7LCxULxG21N0L/zKuCdB0FWjqhyth+sb3QaWiOXpDhowRNdOwrAbbQIxyr0OT0+prNl/Ip7/9ylNYVjGBWJd/84GrDCZDCXd5PE65Q1vLtg72PmwrdD15apIP61WrBqvE9MAhY/neaSdNCO73FnrdldvLEfpmsobU8viXLs3n8eRYMjzbQKgE/X6tbcXkUcDzV4AdtOFNIzRH57aPJspc+D4Eul9VFfJ2+gAKBN4zxp6CSIf8eLSh2mFi2bHvqqDuBzJH74m10rlNoGUxXU1YkPN41WfzCziL26kwBp0BohahbvkSie896NI5eAZdy3i7oSr5LTEZrDvUcwhFLAN85rLzNbUQzwhZ1VPCJ2sirEhiUWEwWYcJI5TCIa1tHsS7RD2m1tE+RV6yXLav42CJjen6w3p6hXPyZRWqtp9EcNp8PlyqAbv1VjXWMC+5BnogR/23doUdTLUQPkZzNKNIyL3bP2ngkwT78eTUbHiK2D/iEp2ksY9k/hPYGeZ0zsoe1N/YXnAqVZOTkUVL+E3LM6o7OuqrgGGjWg=
X-Forefront-Antispam-Report: CIP:18.192.202.217; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EUR03-AM7-obe.outbound.protection.outlook.com;
 PTR:mail-am7eur03lp2233.outbound.protection.outlook.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(9686003)(55016003)(26005)(47076005)(7696005)(36860700001)(478600001)(2906002)(6506007)(336012)(41300700001)(5660300002)(70586007)(70206006)(8676002)(19627235002)(316002)(52536014)(6916009)(8936002)(166002)(82740400003)(82960400001)(156005)(7636003)(32850700003)(86362001)(33656002)(15974865002);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: zeiss.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 11:48:21.4956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 842ba838-d9ad-41e5-379c-08dbdc62c786
X-MS-Exchange-CrossTenant-Id: 28042244-bb51-4cd6-8034-7776fa3703e8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=28042244-bb51-4cd6-8034-7776fa3703e8; Ip=[18.192.202.217];
 Helo=[jegw1.zeiss.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0933
Subject: [lttng-dev] Building the Babeltrace-Libary for Windows?
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
Content-Type: multipart/mixed; boundary="===============5928637435370015812=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5928637435370015812==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_AS8P190MB10771A3EB2AFC92E4540399E88A5AAS8P190MB1077EURP_"

--_000_AS8P190MB10771A3EB2AFC92E4540399E88A5AAS8P190MB1077EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello guys,

after it was finally possible to debug Babeltrace properly, I step onto a n=
ext problem.
I apologize in advance, but I'm new to Linux development and even more to c=
ross compiling.
Is it even possible to compile libbabeltrace for Windows and I have to dig =
deeper, trying to understand it better, or did I just waste 3 days of my li=
fe trying the impossible?
Maybe you guys know a little more.

FYI: I installed every Mingw-package on my machine, and I try to configure =
the project as follows:

./configure --prefix=3D$PWD/install --host=3Dx86_64-w64-mingw64 --enable-bu=
ilt-in-plugins --enable-static --disable-shared

The configure-phase runs well, but the make process fails.

I hope it is the last time I have to ask you some questions. I wish you a g=
reat weekend!

Sincerely,
Aron

__________
Aron Seidl
DH-Student IT Education

Carl Zeiss AG
Carl-Zeiss-Strasse 22
73447 Oberkochen, Deutschland

aron.seidl@zeiss.com<mailto:aron.seidl@zeiss.com>
www.zeiss.de<http://www.zeiss.de/>
__________
Carl Zeiss AG
Sitz der Gesellschaft: Oberkochen, Deutschland
Vorsitzender des Aufsichtsrates: Dr. Michael Bolle
Vorstand: Dr. Karl Lamprecht (Vorsitzender),
Susan-Stefanie Breitkopf, Sven Hermann, Dr. Christian M=FCller,
Andreas Pecher, Dr. Jochen Peter, Dr. Markus Weber
Amtsgericht Ulm, HRB 501 555, USt-IdNr: DE 811 119 940






--_000_AS8P190MB10771A3EB2AFC92E4540399E88A5AAS8P190MB1077EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:ArialMT;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.E-MailFormatvorlage18
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">Hello guys,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">after it was finally possible to debug=
 Babeltrace properly, I step onto a next problem.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">I apologize in advance, but I&#8217;m =
new to Linux development and even more to cross compiling.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">Is it even possible to compile libbabe=
ltrace for Windows and I have to dig deeper, trying to understand it better=
, or did I just waste 3 days of my life trying the
 impossible?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">Maybe you guys know a little more.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">FYI: I installed every Mingw-package o=
n my machine, and I try to configure the project as follows:<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">./configure --prefix=3D$PWD/install --=
host=3Dx86_64-w64-mingw64 --enable-built-in-plugins --enable-static --disab=
le-shared<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">The configure-phase runs well, but the=
 make process fails.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">I hope it is the last time I have to a=
sk you some questions. I wish you a great weekend!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">Sincerely,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">Aron<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;text-autospace:none"><=
span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:ArialMT;color:bla=
ck">__________</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><b><span lang=3D"EN-US=
" style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:=
black">Aron Seidl</span></b><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:bla=
ck">DH-Student IT Education</span><span lang=3D"EN-US"><o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:bla=
ck">&nbsp;</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">Carl Zeiss =
AG</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">Carl-Zeiss-=
Strasse 22</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">73447 Oberk=
ochen, Deutschland</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><a href=3D"mailto:aron=
.seidl@zeiss.com"><span style=3D"color:#0563C1">aron.seidl@zeiss.com</span>=
</a><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><a href=3D"http://www.z=
eiss.de/"><span style=3D"color:#0563C1">www.zeiss.de</span></a></span><o:p>=
</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;text-autospace:none"><=
span style=3D"font-size:10.0pt;font-family:ArialMT;color:black">__________<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"vertical-align:baseline"><span style=3D"fon=
t-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">Carl Zeiss AG&nbsp;<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"vertical-align:baseline"><span style=3D"fon=
t-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">Sitz der Gesellschaf=
t: Oberkochen, Deutschland&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"vertical-align:baseline"><span style=3D"fon=
t-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">Vorsitzender des Auf=
sichtsrates: Dr. Michael Bolle&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"vertical-align:baseline"><span style=3D"fon=
t-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">Vorstand: Dr. Karl L=
amprecht (Vorsitzender),&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"vertical-align:baseline"><span style=3D"fon=
t-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">Susan-Stefanie Breit=
kopf, Sven Hermann, Dr. Christian M=FCller,<br>
Andreas Pecher, Dr. Jochen Peter, Dr. Markus Weber&nbsp;</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal" style=3D"vertical-align:baseline"><span style=3D"fon=
t-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">Amtsgericht Ulm, HRB=
 501 555, USt-IdNr: DE 811 119 940&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:8.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#979797">&nbsp;</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><br>
<br>
<br>
<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_AS8P190MB10771A3EB2AFC92E4540399E88A5AAS8P190MB1077EURP_--

--===============5928637435370015812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5928637435370015812==--
