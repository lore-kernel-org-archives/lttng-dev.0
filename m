Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37403C3ABCB
	for <lttng-dev@archiver.kernel.org>; Sat, 10 May 2025 08:14:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zvdv21SSJz1B97
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1746864864;
	b=Ra+sFDMaO5bgmui2Qvs/nQzr6UHLEJp9EZOGfoN1bAmiqB365txRnTOYk9YkAGU1M0n7
	 w2a62RBvEjJBscCExhVxCF3KtGNf6fBFGAj3/xpNcBjJql/ngerRbzmTO1BmW2hdZTrXW
	 sw0ivw9dHTlw9m1ZeAQnSr8xW9im4/MKEArbWf6zGZRVHHSuriEzG8eP6HQc9P5X5J8X7
	 eQbtHgvJiP5YOg4Kf78z2OiaLReHPCa2tESNT1Yb8HXOsny3hfsyIa56VjSbKEPx6SBlD
	 d2Hy3NaDaPMT2oYT1F0YY8hXd0OTAq8VH9M1AqHMb813G+tySYExbmEAI4alSIztlYw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1746864864;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=dLCkMxevCWKhb5k3cB+MMY2ugge4WYqEGgWEehyqxmc=;
	b=VOSGIV1MOuBmdBDhAyPbCMbq9+1lW/JaWu3ITjgwefO3Pxt03PDw9XE5ztrNsodruHCW
	 WtvMAV9ix5uofbY60tdgP+ILCF5K2z1nLg0ffGkOSKLfAVyeKzEQEl7iB5dURyaIFXPqL
	 jWipOl1JzKSYSiEjStFuS81x7sOLaw1NeCI7zLLtazkqT4dDubHnVOB2/zY+W7fFTgO1a
	 DlOjC1btdnz3dCIrNSRMcem5lU2iVF0NmxCC7PLvRp15Q2fiLFoXOE7Owhmu20NwJJ2QD
	 U02RJyiFMJN22LvHks9l9CBhHBGcZQGihsoaqaWbchz03KJkTxChixdeyc4qCpg8jkA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zvdv21SSJz1B97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1746864864;
	bh=dLCkMxevCWKhb5k3cB+MMY2ugge4WYqEGgWEehyqxmc=;
	h=Date:To:Subject:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=tT0czwzIrQTSOKIkdWYDygDv04koWI25dGyhLoEPg+cL1W8cSPZSkxAqC76T6asuH
	 p6ECtkPJmCX3v5eaQofNUbFxJH8+bEyWorBvagsGPBT8BMCuXFaKhwKJzu/MgKWraC
	 2fyr5aJoUHvHBKvJpa8Y0+DCw/bUBluOI2URcUgVkLAOWBQ8zd9trQsPWfw9kCp4wW
	 5vusH1zE6EWLj1wyloDyHoSVubBHCkoPioq6Ay2huBaHtVHM9/YwZkvlUIYquhB7FY
	 UylEUfVquJBQud2WY7VBfR8ReIDfKkAvqOTRwHF5anarO2yZCcnEiK6cYOcalLPtce
	 Hi3V9Pv86NCQg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Zvdv21SSJz1B97;
	Sat, 10 May 2025 04:14:22 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zvdtz1Y7Cz19wB
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zvdtz1Y7Cz19wB
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::70c])
 by lists.lttng.org (Postfix) with ESMTPS id 4Zvdtz1Y7Cz19wB
 for <lttng-dev@lists.lttng.org>; Sat, 10 May 2025 04:14:18 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyqxyI0Z1Q1lQ9sO719LZMCq3hkGUicpVzVRmsUhR9cVF7b4PpKABdRFGQW/AMxTSrUEw+SFQlThjebuUdShDMPA2usNS8bmw69UWjR4widVfcfCRAubGMryZ3vmYVV9vFRY1Tv7P08eclAfg3ZFiJmBq+Jys5WtGgHihWve5gr2rPSWPhzmMkfeKa7c9yCccoQeUgCpiw6Tgvhri3XrJeN+T4XkMTTmTUH/ucqgT5AwhAiOYBepdAf4MGqexsbkF2I+I1+9mJXxii1IZ2qjba0ij7SCnuiZUJVviTSQqyJ7ZcVeDRIQ96sBeI7MhYhvHDSzBnF+8AKaqkjTJ2jiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vyt57J/cpcgAVZmb8sx2RJpbt0tlZdebtqRjCWzwOv0=;
 b=WsJiomg3gxhdgQp4mMvqduzmq2J1OGTnM3Sh1/vpxX9xOHJglzzlxVUMu6Kt3wVFvgnro5Hp2Vyd7pdYn40KNYyTERHyeLtIKzFzxGZ22JympFGBucPCvIqDCWRsAoHNVJJ9p/0+tN1yiFXYRsL+jUhij12QYrTeXk6idVW+dyz4Db7RDN1iChbUrHel436Wl3Xop6zqaqcqxHLzlxbgR26cDOIhahZiFODPKWsUtVd8yyWsSWxOj1nH2ZatrYKT8WQQH4WGbKfSyXKSD5JiTydEar1hqJR/2omdAcQkkVxu4xwtOO8t0a1NCcHMO0fgaVFDtBaSNUY2g6o4CvCP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
Received: from AM6PR08MB5013.eurprd08.prod.outlook.com (2603:10a6:20b:ef::21)
 by AS8PR08MB5989.eurprd08.prod.outlook.com (2603:10a6:20b:297::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Sat, 10 May
 2025 08:14:11 +0000
Received: from AM6PR08MB5013.eurprd08.prod.outlook.com
 ([fe80::2277:ee89:28ee:ac0a]) by AM6PR08MB5013.eurprd08.prod.outlook.com
 ([fe80::2277:ee89:28ee:ac0a%6]) with mapi id 15.20.8722.018; Sat, 10 May 2025
 08:14:11 +0000
Date: Sat, 10 May 2025 10:14:10 +0200 (CEST)
To: Kienan Stewart <kstewart@efficios.com>
Subject: Re: Problems with arrays of floats (lttng 2.13)
In-Reply-To: <7078c448-41bb-4ec3-be56-cfd93ea94ce7@efficios.com>
Message-ID: <c25050a5-9e48-1042-5428-a33c4602fcdf@kuleuven.be>
References: <00f6c849-e4f6-396f-9f71-4b58bd203eda@kuleuven.be>
 <7078c448-41bb-4ec3-be56-cfd93ea94ce7@efficios.com>
Content-Type: multipart/mixed;
 boundary="228850167-1171160360-1746864851=:354512"
X-ClientProxiedBy: AM0PR02CA0024.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::37) To AM6PR08MB5013.eurprd08.prod.outlook.com
 (2603:10a6:20b:ef::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB5013:EE_|AS8PR08MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: ba08170d-5e17-41c5-90e4-08dd8f9aa4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0hDYWVqSjluQ1ZrV0hEUTlZTXM1ZUhEQnpzb1IrYWpQSy9wOFdueTRsNzV4?=
 =?utf-8?B?OHRJVzJ5eGJQRzlsOUwwWjFPbHN2RUR1L2NBSldWeWs3R2dWYWdiVmhvL3hH?=
 =?utf-8?B?a2FRYkUwb2dQcUFEaWtuMEt6ejhUYlRFN1FKMWRyOVpFOUhsVFBUUEF3eHo3?=
 =?utf-8?B?eEZZUFExTFZsMC80bkdUM3ltb0FkaG1Jd25SeUl2Y3JaSHNwOXZ1cWVLaGQ2?=
 =?utf-8?B?Y1dyTldWbFNvOUVINTJ2VDdxWVZLdm91ZlpjRCtaY1dWNEZXVHlaNWFxbjFa?=
 =?utf-8?B?WEFUWWRNUE9GUVdTUGRTdWZvNGxqRUx6dkNQZFdKb1EwN3IrVHVPTjcvclUw?=
 =?utf-8?B?aDUwQ2g0ajdHT1M3SS91am44Kzd4NWVocndiaGhrUm9OblpPN2lOdVRJSXVY?=
 =?utf-8?B?dnBiZ3BLNzM4WE1ScWdsZUJNTVBkdFBLL1VZcVN2T1RTRFcxdElQbFRvbzFW?=
 =?utf-8?B?alpCbWkyNlo3WUMzcGVjSyttcVJiN0hRRnNaS2lNTTJYdU5rN052Nm5EN3RR?=
 =?utf-8?B?dURWeGd4WE9rV2ZGVDRMdGVlR3IxNGUzdWV6eEt5N0M0S1lYVkJ3WEpSV0lM?=
 =?utf-8?B?RUwxSUVxdlF0Z0QxUU9UeEZDU1hPYmRDampsa0czWC9ROUpqNkdSMFhyZ1k5?=
 =?utf-8?B?OVVtNEFSV2tiSkVBZktTVVBzcC9qY2s1YnNMV2tSMk9xTFVNVG10ZWU2SFUr?=
 =?utf-8?B?M0FzUWJrZzZveEZvaXN3UzJqLytWaSs1U0s5dzkvVWs1NkFwK1FDalpYNnBI?=
 =?utf-8?B?aGFLMkdtOWdKeVRjWnN1T2EzVXdkVnJvUXdMU3BOMjVyRHlCejk0NGpicG84?=
 =?utf-8?B?citWVzFaSFZrL1c5ZUZsUjJjNUdRQm8rMTlHNjN6SHhibHZROWxIWXZ5dmNl?=
 =?utf-8?B?ZHpKM0VSL0dobkNoc21STFJMeENnV0VBNUxuekZmY2c1eUFHZVVzcUdWTFBI?=
 =?utf-8?B?RjlKV3VQcGZTdWVMTmk2UEFtQlV1YVJrNkdUdVlmYjQ4b2hSK2xCb1lBL0JT?=
 =?utf-8?B?WnpRR0FqMUloeXc2UngrMlora2JWbE45N1ZtQ3F0SzZ6Y29Yai8reFlrQjJB?=
 =?utf-8?B?a01yV3F3OTBtL2ZQeU9saWJKS0FDRkQxOGMzeWp1b1puazFKVjM1bzgxL0ty?=
 =?utf-8?B?VEdSYi9XVmdSWmJncUhReDJnOHRvYjMxZG9wRHZDRU5MVFN1Y2VzeFlwaS9k?=
 =?utf-8?B?RzVMbEVha0cxenE0OGhGZUR5S0JNOFh1SFB5eXlocUhuenkvcDI2aldiSWZz?=
 =?utf-8?B?eXU5S1J3aWYrYkdWNEtUN1RSWVMyNFI3WjBMczhOUVJWTzFoMFMyVjNXVFNS?=
 =?utf-8?B?WHB5cGJEa1lqM29IcVljY1c3YVJITGxYbzl3SzdpamxZL29GMkh0SjJldzl6?=
 =?utf-8?B?Mmk5ck5GNHowMnBENnBmdXgybk1ZcnAzazlvS1EveGFFbTNkM052Ujc5alI3?=
 =?utf-8?B?VVN5SER3NVlqUDY5dHhTQlJ3VzN1QldxY3UyTDNKcGREMlhOdlpONTBhOE9m?=
 =?utf-8?B?Rk03V284aDlKcXRsc1NRdnlMOStBSXZrc1c4K2xpUGs5ZXoxMXZzYVlKcDAx?=
 =?utf-8?B?aWxuTkxGeVFOdUZJSlA1TllnQmZ5RU5sYjR0NFdiR29JTWJ0bVhKZ3hpaGx0?=
 =?utf-8?B?dkNVMk4xdnZIRFpaNXA1MHFoL01BY0oreXd0Mmt3S1JRY1c1aFd2b2VOU2pu?=
 =?utf-8?B?ZkN2bXlUdGMrNXZyMDBic2Z6MXZPU1Vnem1KYjhuRFJvK1lVYmtZWW9CNVBU?=
 =?utf-8?B?ZnZwbXdtWXRDcmZUVUg1VjFoQnhlclZZNXFtNU0vOVYyNVJrSGVNU2NVUmN4?=
 =?utf-8?Q?+0RdYj0lwUCKYq1gYQjvkuqLChPFMyTm8212A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB5013.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG9PTEkwelZ1MVh0S2V1MkVyaHdJQjZFQ0xPUmxrZ0dxWEovbG9VdzIrR2li?=
 =?utf-8?B?eHU2ejdjTWxoeGY5d0k2ZlA4V2dXQ0pDMG40c1RSbklNT29OM1pmNUEyWW5K?=
 =?utf-8?B?TllUUDVZNkhPSng0WndKc2ttMEFWM0pSaUs2bGIvM2gwK2FVZG1LVE5YTGZH?=
 =?utf-8?B?dDhGMUloK0RkUzArZHZIbzY0RnZIb21YUWpTVDBvNkp4elJDNmVwNlE3b2ZG?=
 =?utf-8?B?b3NWVUoxRDlILzlPeGE5bERjaXFaNUk0bXc1RUxNYUJhOW4ySEF1MTF5bFlu?=
 =?utf-8?B?Z0plM3BId0V1SnRIbFZHRUZiUTFJb3hTdmZhNTkrVEpnellQMjYrVUxUdlFW?=
 =?utf-8?B?VnpzQ2RuYkt6STQ4UkRVemlyNXpWOW4zQjMyU09qc2ZlUGdacjViOEUzczda?=
 =?utf-8?B?RE9lOEJaV29FQkxsKy9JNkwzTTJ5UERZUHp5SHdrRWgvUXVmditzeU9FcWRz?=
 =?utf-8?B?ckk0WkhjOXVGbURhSUFSNWtOY1IvU1BxQ0w3N0dQaHNGMitCa3pscUJLdENj?=
 =?utf-8?B?UUJsTi9JOHh6RkJBamhnTjd0QkdEUzZyWm1PQmpXaXQwOWc3eWVleFlVcysz?=
 =?utf-8?B?S1VpaEhydDVrU1FDcmFCUTE4SUt4SDhweWFQUmJlcExXNm95dU5La21jdkwr?=
 =?utf-8?B?L0hNUmd2MDJFMXgvT0FlYjlLV3JPcnltMmVrWXJ6ck92cjJUQXk4VWtHUU5E?=
 =?utf-8?B?SnhIbEtpWGNvN2ZaYVBmMGY3VEVhQmtuUHIwajFTZ2pPZ25XVWluTlkzdUxS?=
 =?utf-8?B?TkRKOGxjOTdBTjc1S1FFSEY3RTlUdFd2VlpzMVNWYTcvYTJkMEg3V0pCdzNQ?=
 =?utf-8?B?cFpjeXRVSnJqUjdoVUJGTGxoRXNFOFEya2t5UHNiNmxWZk0vdzd5c0RBTEM5?=
 =?utf-8?B?NnVTZkVBalhLcktRWmpFVkxncFQzZWRQQURvVFphZkxVbTg1NnhXZDhCWGsw?=
 =?utf-8?B?WUNDK2tZY1lDT3Y5eHFDbzd0YloyeGdKSlkxOUJvRmhUVzJjdWhaZThKd3Ra?=
 =?utf-8?B?QTNuYnE0bWxCMWZtbWRiN29vazhJZzdZb0xrNFBpdUxrQVdIVTc0dDRuVFJX?=
 =?utf-8?B?cGJGMnpnSjBYUFRMRVJ5bXZ4QUF5VHMxVXp1bEZEc2Z4eUFFclVLYUxCSFVP?=
 =?utf-8?B?eU1lSlNmS29OM1BkR3gzbWZINEw3VlJpdkVzenAySFR1bkMyNmx4bnQ2SEZ3?=
 =?utf-8?B?blF1WXh3KzJwK212dmFCMkNGV3REcWhONU9qeVhFamZRa3JLbldCK1JTNkZI?=
 =?utf-8?B?R2d5RDcvK1dtNTFla2FRbjNMMUg0NlVxZEVrY1grQmRPd0twcm51Z0ZLVnpq?=
 =?utf-8?B?SWUwRnBSRXNUeGRPVk1XTThRZWhadkdjaVFtZWpTZ1l2VjdYTHhzN1NocjRz?=
 =?utf-8?B?Q0o0aTdZUGVyYmR1azlHY0VQWVdMVFlzanF3SzJYWmZ5TTkzUUJ5emNvRzBX?=
 =?utf-8?B?Vnlab3c1U3gxcnJEaVlabUVqM09HbFBkZVZwZXhkQVJwYjZIQzJjdTRwa1o2?=
 =?utf-8?B?V3AvYTBwZmFzLzdLRzUvdmxkSkpxeW1qL2IzZC9IVzFLSDFMVEJRcTVJMkVa?=
 =?utf-8?B?cWVJK3RYd0NNclZuTWl4WXFYTExpOE9KdEh0K2V6dkttVXJUREc1cEdJOVY1?=
 =?utf-8?B?a0Q3aC9uNW5BRytMTHpjTzV3TzJKekp6bXJ2S29FSnY1TzJGK243Y1RtN1h4?=
 =?utf-8?B?RDNlNGJDeUlZOTVIVnJWZjd4Y1FyYnlQTkM5RzZUL05xdHRxdmNaV3dIL3di?=
 =?utf-8?B?WC9MRzB3eEdPZFp3ajkzZ3M5MlB2dDd0SjNUUjc4SElmSEtxQzgwVWtWTXBq?=
 =?utf-8?B?b1VuSzFhUS9LU3ZkaGJaRHVvY2hJaUg1dFVIMTdhUWNSaTllZk5KQXRYaWhN?=
 =?utf-8?B?dExXS3d4WUhieGhueklGbHFJUStMQm9VbXFSb2ZiWmNMQjcrUW1qMWZkYjNE?=
 =?utf-8?B?S3FyRGZqRkhJSHVwNyt5ZTUybndhSVREaDF3S04zb3BoUmhheTgya25lVDA3?=
 =?utf-8?B?cFZpeXVwQmZVOXVyNkIrQzlyTGdmTTNWbXIxRS8rVlY5T0xkZ2R6Y25nQW5K?=
 =?utf-8?B?cnI3Y1ZoYkFQMVJqeTRWVGtMVGN0eHc2MFg0UGhlNnVpcVpSdndFOHQzSWlI?=
 =?utf-8?B?b1ViNHVVWXptRkV5WkpxRXpjUDlZZ0tDN0RyUjRETTN3TXpUVTRzWTZyd3VU?=
 =?utf-8?B?WEt1QzFWNDFaWEp5Vm16ejBiMFJQMzBIaHY4RDlOdzNUQXJpOE1FV3Juc0tm?=
 =?utf-8?Q?zxgAR0BWeEpnKpM5TEROfAQfONMA3AU03P0et03lS4=3D?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: ba08170d-5e17-41c5-90e4-08dd8f9aa4e9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB5013.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2025 08:14:11.2801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3f69+C6RnKq2/t6BmyrhgLMgWx6qk3ytpcX80IfeuFucgSa5g+0nql6Z+v8UXOX8BDHmLkD+xId9BPz7kM4CNpOoLjHwR0QLwzjPa2UPrXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5989
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
From: Herman Bruyninckx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Herman Bruyninckx <herman.bruyninckx@kuleuven.be>
Cc: lttng-dev@lists.lttng.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--228850167-1171160360-1746864851=:354512
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 9 May 2025, Kienan Stewart wrote:

> Hi Herman,
>
> On 5/9/25 6:03 AM, Herman Bruyninckx via lttng-dev wrote:
>> Dear all,
>> 
>> I want to trace an array of floats, but I always get bogus output at the
>> (Python) Babeltrace2 site...
>
> could you give an example of the tracepoint you have setup in your code that 
> doesn't work, with the corresponding output?

Thank you for your swift reaction. Much appreaciated.

First of all, my apologies: I should have provided the required information the first time around already.

---
This is the information about the installed versions of the relevant software:

$ uname -a
Linux SET-L-ME-P22061 6.11.0-24-generic #24-Ubuntu SMP PREEMPT_DYNAMIC Fri Mar 14 18:13:56 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux

$ lttng -V
lttng (LTTng Trace Control) 2.13.13 - Nordicité

$ babeltrace2 -V
Babeltrace 2.0.6 "Amqui"
---


---
My application code generates a trace as follows:

Tracepoint "-tp.h":
LTTNG_UST_TRACEPOINT_EVENT(
     comm_activity,
     range_scan,

     /* Input arguments */
     LTTNG_UST_TP_ARGS(
         int *, distances,
     ),

     /* Output event fields */
     LTTNG_UST_TP_FIELDS(
         lttng_ust_field_array(int, distances,distances,5)
)


int testmeas[5] = {1, 2, 3, 4, 5};
// double testmeas[5] = {1., 2., 3., 4., 5.};
// (one array for test with integers, one with doubles):

lttng_ust_tracepoint(comm_activity,range_scan,5,testmeas, "range_scan");

---

> Could you explain what you mean by (Python) babeltrace2 site?
This is the Python code I use to display the trace generated above:
(inspired by <https://babeltrace.org/docs/v2.0/python/bt2/examples.html>)

---
file tt.py:

import bt2
import sys

# Get the trace path from the first command-line argument.
path = sys.argv[1]

# Create a trace collection message iterator with this path.
msg_it = bt2.TraceCollectionMessageIterator(path)

# Iterate the trace messages.
for msg in msg_it:
     # `bt2._EventMessageConst` is the Python type of an event message.
     if type(msg) is bt2._EventMessageConst:
         # An event message holds a trace event.
         event = msg.event
         # Only check `range_scan` events.
         if event.name != 'comm_activity:range_scan':
             continue
         print(event.payload_field)
---

and these are the resulting traces (for int and double, respectively, and with the C and Python versions of Babeltrace):

$ babeltrace2  ~/git-repositories/communication_5c/build/test_session/
[12:19:11.381152129] (+?.?????????) SET-L-ME-P22061 comm_activity:range_scan: { cpu_id = 6 }, { distances = [ [0] = 1, [1] = 2, [2] = 3, [3] = 4, [4] = 5 ] }

$ python3 tt.py  ~/git-repositories/communication_5c/build/test_session/
{'distances': [1, 2, 3, 4, 5]}

----

bt2$ babeltrace2  ~/git-repositories/communication_5c/build/test_session/
[10:04:51.068836215] (+?.?????????) SET-L-ME-P22061 comm_activity:range_scan: { cpu_id = 6 }, { distances = [ [0] = 0, [1] = 1072693248, [2] = 0, [3] = 1073741824, [4] = 0 ] }

$ python3 tt.py  ~/git-repositories/communication_5c/build/test_session/
{'distances': [0, 1072693248, 0, 1073741824, 0]}

> Are you instrumenting python code, or are you instrumenting a C/C++ 
> application with lttng-ust?

The latter.

>> I have no problems with arrays of integers, though.
>> 
>> Is the float array feature not yet implemented in lttng 2.13?
>> Will it be in 2.14? (Also the "BLOB" feature is useful for me.)
>> 
>
> I don't see any changes in lttng-ust for 2.14 that allow for tracepoints that 
> have float arrays or blobs. lttng-modules 2.14 does add support for CTF 2. 
> The support for CTF 2 in lttng-tools 2.14 will remain at an experimental 
> level.
>
> From the release notes:
>
>      CTF 2 output isn't enabled by default and is intended solely for
>      preview and feedback purposes: having an experimental support will
>      allow users to test and evaluate CTF 2 until we make it the
>      default output format.
>
>
>> Thanks for your help.
>> 
>> Herman
>
> thanks,
> kienan

Herman

> [1]: 
> https://git.lttng.org/?p=lttng-tools.git;a=blob_plain;f=ChangeLog;hb=11f963148df9597de6d891d96d748bae5ced7149
>
>
--228850167-1171160360-1746864851=:354512--
