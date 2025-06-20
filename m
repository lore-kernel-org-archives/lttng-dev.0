Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41E8C7115B
	for <lttng-dev@archiver.kernel.org>; Fri, 20 Jun 2025 16:08:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bP2Sz24G0z1D6f
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1750435701;
	b=qPJDUneWSpP0saYuQ2NPcvoF6vPlnl78h8sAh5nTpkwigrth9Exd4t15kt1doq9kyiiR
	 PxiWamaPcJpe6LK/mmfFrGDFqTKIeUS4EGZqTKKzYokcHU5ffcTN29+sDSaR5fjN8PmHM
	 +yQjB4KzRpSQa5IEaqrONzLsp2ykJKxVt43XHZpZd9Uy7bQZeGUFJgOnvHJQbT5egKm3H
	 YM1VD+mZCBgieJK2Z4Sbl4NkUNLfWOoqDdC3ZbI3W3vdmF9LEmWd31jGRIcB5NzAwCGu2
	 CZL7gmCtg3/tDqi7R7JWO+jl2J0S6gPFB6M/mZeQvMhX8OUdccFAwd2/NanzDeeBysA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750435701;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=HdKPKFsAbVyZIdyjhstBRauTD2qkqeSFCgP1eX5UYfI=;
	b=O1/9rGJv5MbMDTtX6xuZS/6euY34eM4Hclzk+z/1rJsirlG07JYCM+D40xUyjRrFfjr3
	 kuPVfR7TGGZBaZTlA28EutGwbKtlFiTk5dc1/ihwueaBKG50T2ZsAPju0YFnb/Qsr+9SU
	 61x8ZYnoNJhN6yQcvElo2OOynkeg469YBKC6/0niqjT6nkQCxYQmGX8poKb1UUKllBF0n
	 0dZ8if4i9ElyuC5cXiGwrk1umTw1c89wZ96iFwHyCHJiqeHEIgX0NYmtCnn3cNnKAXw/t
	 9Kqh6rENkH/Lm//w3SyZEcRQtC2o/EllZCnnTeKOchUmX+ABxHclDYrIRlUU3jAwBhQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bP2Sz24G0z1D6f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750435701;
	bh=HdKPKFsAbVyZIdyjhstBRauTD2qkqeSFCgP1eX5UYfI=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=oK23z+U8j8Fb0MboJ8iq8Sm9X6Rg8fiuZV4zkgFO4wwtC801lbxSIohdW3rzH9nhX
	 GJPjAx0kdmF9TsRwLCkRDtQ/NCRejjAZqJ8MYxroMic3utkVAkhLJ9mhZ+YT2PMlqp
	 b1/SUpU+igqdPJlDyLQ9e93ukoCaxfw1tXLhRGytzvMvUVCf5kT35vEH1YOnr/aULC
	 uOrMxBK/tl+FEAu23RSc9eR/lgDpCwjvQygwVhynwRGfZToSuLdXgUjCJCg0wQY9lE
	 JXkzQyVvmBdQTZ6mMbvqyFmbKH0lvXs5JHp0iEAQ06Znynal/tP2Ipbq5t2eAjktzv
	 sq102ySSw9P/Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bP2Sz24G0z1D6f;
	Fri, 20 Jun 2025 12:08:19 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bP2Sw5S7qz1Crt
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bP2Sw5S7qz1Crt
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241d::72e])
 by lists.lttng.org (Postfix) with ESMTPS id 4bP2Sw5S7qz1Crt
 for <lttng-dev@lists.lttng.org>; Fri, 20 Jun 2025 12:08:16 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvG6p1nLlouz7NsS0GJ/+oGxXwwZI4Dr0lO0G6T9mTWGDd1Tydvo8vd98c2mdCx+/fh3aiaSFaTn7ZUw1igyXYGUfVEl9A7EyzMAis87yxgaWZodaq4agCh9pykxOlVTy/wmB/Qnfv7xjYI5unWlBWgft9p2W3OzoEwCyBSHr7T//+AcMHnqfsQyx+FACidKkSvOkopOUySfkO+X9JQxhszrVjbsUgY/n4nLpJmwkzKgWdIk3x6LdUgydY3NqOlQa6BGbHjtY4QuAkevzAIMaTGCqeMjOU/vFrLtJuqieW/2yFBK3YBRXCTX87ksRA070XaNOheQmYCWP6/meCZoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MJeibxkQH3j8KtgNtYBZLGgjpWDcQLgcgxLwrdBolU=;
 b=sqcOB6OkUcgs4k7zhn8+z83aKfcBEdKBd7JNFwRhocBzNKZsQ59sul3Z5EPmFe33pGIEcr8CQZptrAJI1eFq120MTQ6QGBeBEEyK9p3cNoUuugOcELbPXIBhST8/P3yap9oM+airsDsPq4S//u8P/ZTWcavGN6JwH5Pwhrxu+U85Qjj4wf5rEzLd9Eii4Q0Nb+MBss5UL35J0c5HhWZbChkvyd6Y34ar9V+UFXYtSLR5PEaRcTbUJ21sGTROx27bB83FoijruIGryqFLuPkPRPp9r3KQI92AK13SMJUWxkOTQlRfD0NehkG0jf7UMo5b/ccNCRmoJWROMfDAZdFiDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5d::22)
 by YQBPR0101MB5702.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:31::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Fri, 20 Jun
 2025 16:08:07 +0000
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4]) by YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4%3]) with mapi id 15.20.8857.025; Fri, 20 Jun 2025
 16:08:06 +0000
Message-ID: <6ba07571-9594-4097-b1ee-28f07359df86@efficios.com>
Date: Fri, 20 Jun 2025 12:08:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: lttng-tools-2.14.0-rc1: ODR violation
To: Norbert Lange <nolange79@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>
References: <CADYdroPQ-E4JGj=mhQkkRNv4PVgpXuN07fQpg9-r0TifsJpQ5w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADYdroPQ-E4JGj=mhQkkRNv4PVgpXuN07fQpg9-r0TifsJpQ5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0279.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::10) To YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:5d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB6319:EE_|YQBPR0101MB5702:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c98e5eb-ef4c-40fc-2c54-08ddb014a471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzFGQWxLMW94Y1pZdU9vS1V6eTFWcnlBMVRIOGlqZTlwRndDaHlnVzN4bCts?=
 =?utf-8?B?RW5QMXpPRG41UjA3QUpxaldSRm5sWTZrVmpsbjJ0RGZZZnJuQjcyWk9FOWpu?=
 =?utf-8?B?ZzMyQ3dqalErQWQyUFNpY1BzVnpSK1RNTVBDS0JIT09teHJ6THBTZDBuMlY4?=
 =?utf-8?B?UWNYNjMrN0dtTjh1TmlQWTdrTFZZaG90YmlqM3N6L1hRd0hWR0tTMnh6Q3hy?=
 =?utf-8?B?WmdFa2VoMGw1VFp1NzJmNlZLSU96aHVWRks3cFd0dlp1c1JqdDdTWjV0S3la?=
 =?utf-8?B?QzFCek5nK3dGZWhYQWl0cFN5NWRkZnlBNDZDQ3hra1JHeDN3NDFCNFQ1aHhJ?=
 =?utf-8?B?cTQyMHkrN2t4MzZQb1Q4Z3NSMFI4dXB0QWtzTlJXOVVWSjJZVkJpeko1TUFk?=
 =?utf-8?B?M3B4d1Q2QnZTMHFLcFhxUnQrNWdLeUQ3RVR5b3QyVndPd3JhWVJOZSt4WWdz?=
 =?utf-8?B?UUx6ZyszR3F4T1hHQXc4WTBBM2NvZFNTSm84NFBvL3RyeWZ4cndaSkRXYVFt?=
 =?utf-8?B?L1hyTDlsVHBOQlNyOFo4SWJndzczU0JTYVhTdC8wYmJINitIbkc4dXMvMzQ2?=
 =?utf-8?B?WEY1bEh2OWZnSStCZEVBUlQ2YTNEZTNUaS9tajl0eDM2Y21uNkZPdndCUDVk?=
 =?utf-8?B?c0hhNXh1Q3hDRkxmOW5KRktnYVNuWjU3N1pta25DMDQvMnlDa3c3anZKM2lI?=
 =?utf-8?B?cEFpQUdyaUxzczBMai9tcS9WS0Z4clR6Q1V5Y0dLT0w3Tll4WUxHWWJFOVVO?=
 =?utf-8?B?Q29JQnY2czZoZDcwc1FSUFRjOTJYdVJwUTF0VVU4TGxNWTdXZlBBaldpVWdt?=
 =?utf-8?B?TGxyV3pTMU9DTnl3dTJlOU9pQTRNMTZGNEhURXFROHFtQitReFpLUzkzZGFK?=
 =?utf-8?B?NnEvVjdNQ1VhSGQreHk0ajBiZlllNFdQbTZNVUZNQ3JibVk4d3M1OTRyNWNz?=
 =?utf-8?B?RlpSM0E2YTdVQjF4V21UbHdWMVN3dGlnNXpqdThydjdZRkl3MEljRG9wa1lS?=
 =?utf-8?B?S1BJM3hwczN4TXdrWnpFK2F6eGFnMHFoYVpZdm0zR3BpUzd6QkpPOW1Iek81?=
 =?utf-8?B?bFgvYjFDRmRZYWh1c3lEL01mQjdablV1MGlnVGFzS3BPWG5KY2F3b1lFQ1Bx?=
 =?utf-8?B?YWlnZzdjK3VSQ2ltTjdMbko5Yjc5eGtrelMxcEUzNnIyZDJLMlRaRVoxK3Fw?=
 =?utf-8?B?SkluMHZxaDRCTVFEYWRyUXc0TkhVemtLdWg0dE13V3d0d1Yvcng2T0p4Ui9O?=
 =?utf-8?B?eHA5VVIxUW1yeWlRSlJMRWEzemtPQWpsbDZBZU9vb1pHelkvN2hkYUdpREx0?=
 =?utf-8?B?RXZTQ1lub2xTSW9MdTU5KzZjVmtrNWZwNzFTSVpaamxmQktLSVVwRnFmN04x?=
 =?utf-8?B?cmpVNUl6bGZhRTNJVm1ZWVljQXF2L3YzR3JJUFlON29nQlB0aFVLZWtidUd5?=
 =?utf-8?B?d0p6Z1B5c2o1bUhwQVhyWGNJU0VaZ3F4TDBQZGVvVFpSNnVKNW9WTXZVL1ds?=
 =?utf-8?B?dmxoSzJDNkN6NVUwSXQwS3ZUa21zK0h3dW1lUGxUczBNVVZ0eGdTVzBQNXl2?=
 =?utf-8?B?b0ZlWjR4ZkZLbC8zSm9TU1ByNDBLcEE2eU9mVEhPbjI5Z00rdlVIa2RsdVAr?=
 =?utf-8?B?TkwxNDczTXB4SExCRTBlQUpRZUh0ZllWakg2bEVtRTZxRDlNRnhITDBNakJm?=
 =?utf-8?B?TFlyNVZ5V1daRnR5Z21lQXFwQ3JiRFdIVXlrcWozc09GN1g4YmxsNEViekF0?=
 =?utf-8?B?YUh0VkwwOVBLSzdPR0tsTHlyUG55UFFWNitUZHNtWEJKTVMySGo4U2V6ZTNs?=
 =?utf-8?B?SjNsa1JsRlUzbUZtNmxuL0JPdGEzeXRqUnFDbzVuNlBNRlhjY1BpSG02dExC?=
 =?utf-8?B?aVViVHV0dUY5SnpZK1lobytnV2ZIbEk0bXJCcWxySUhZYlJKeHhyUlVaNzFs?=
 =?utf-8?Q?TgHZHxiNtOU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEJpL2txc0VFQTcxL3prTXpKU0lHRFJzczhlVkR1OW5PVzF4cXZNNkhhcU00?=
 =?utf-8?B?cnJLV1Zkby9OVTBOVklGdU43K0psSm5GWHE3L3o2UmdSSXdCTUFKTjg4Y1Rh?=
 =?utf-8?B?K1l4bjd3VkR2ZWp1UVlMallvOFp2QTNOSnBXcmdESG9MbktSMmN5Z1BHajQw?=
 =?utf-8?B?Q0pKNTBMcU9nUEtPRWZDWTNqa0kwZllSSFd1QXRtMng5aTRwOTAvamEyZWFz?=
 =?utf-8?B?c0VONVdad0F3TGpiMGxPWkp5eGROalVtM2dyNU9aN1RtRVIyZEJGM2I0SzhU?=
 =?utf-8?B?OGo5c2hLemxrSHN0bGZTTmNWVWNTOGVoWENrRTFOeStITUJNZ01NZHlJbjc4?=
 =?utf-8?B?eXNpa083b2pmTWZNTUN1OXZkeFhIZ2FhdTkzaVdJTDZ5OUk2OTN5SnBWNXV2?=
 =?utf-8?B?ZFBRVVBIY0tiWUYxWmZXQS9sSHd3U3VDU0lSZ1ZNeGpOSnBmQmVRSkNweXZK?=
 =?utf-8?B?RG4vUzBEb0g3OHNZam9RYVlTWkJLNzQ2Zk92d0JienYxVTdlMDUxalROWlBN?=
 =?utf-8?B?cWlPREYrT0QxNHlZaGFsSlVXWnAvekllaVBYZnZXbmVBQ2J6VEYrSDRKQkxy?=
 =?utf-8?B?R0FWY21zZUcrNHZCVkNoTG9oVUF5OUtyYnVlc2EybC9OQy9hNGN1b2g5VUx2?=
 =?utf-8?B?RGU3WjJjYzR6L0tJWTBESlo5bUx5RVZGNjRLeC8reGNJWjg5Kzd2U1JleGF6?=
 =?utf-8?B?M29QMHcvQmpINzk4bHp3Y0xpck5EaDlQQzhGUll6UGJMSlVCL3ZOYmRsd3Ni?=
 =?utf-8?B?VUdJcWRsaGtEampDYjgwZVZhMUZSUUw4YWNWY1JPN2cwQVU0aFc5UTNvVFVD?=
 =?utf-8?B?V2tUNTlFNjlhMFIxdXJZU2crampPb2ZQVG1vajNuSEpkcGdUL0hNS1hFU2xq?=
 =?utf-8?B?bXN6TkpCb0xxY05TNTFLdER1OUZlUHhBUjNjWGhqUXJhcUh2VWlCNXg4RUtJ?=
 =?utf-8?B?d2RFM0o3MENxcEVNeWJCTlllamVXMGhnZGZsREtTZElzeTBmd0hqTFRLelM1?=
 =?utf-8?B?M0VOVDNuMlRmWmZROUw4bVVHVUJNTnh0YUhTV1NRS3h2UDJ2Qzd2b0pFYy8x?=
 =?utf-8?B?dXBiYXNaTDNMa0FQdEZXaDRKUGJKbk5rMUhzZlF6MVY2aVhLdUUrL3ZQOXVP?=
 =?utf-8?B?VkNSaTVWY2dLYjIwaXF0eUJremtlbVdaemFsZW5ML2hHZk4zSFY2dlNQNW4w?=
 =?utf-8?B?OXpLSmMxSHJQTXBDNXBnZ3lJczJZQ2p0Qnpva0dYdmFRK0tiMG9lRGlHcXhX?=
 =?utf-8?B?dUlsTUFaWkp5QjVvWjM1S05lQ0p2RkVIS29xKzVhbDloSGUrQkh0T05ER0dJ?=
 =?utf-8?B?TXhXdVNhRHdvcEoyWlJ3Nld1eCtxeEg4cWdLV0ZTZEU3RFAvcGIzSmwvRTVC?=
 =?utf-8?B?MXB2Q3Q1WVdIN0hvY3M1TFFIbDQ0MjdVSzF1dmRwd2I4cTNaRHBONEY1Q2Rn?=
 =?utf-8?B?ZmRXdWxPR3lYbkJodlV5aXhoNG4zYUl1Zi9HTHZINi9rNFVhUWM2UU9XSDly?=
 =?utf-8?B?OHpTc3hVZ055U2FyVDVLU1J0OEdTeGNSL2R4bkF5TERVSVpEZDZxRUVsRGp2?=
 =?utf-8?B?SFVlc1FaUy9ZUDUxT2k1WExQZDBWQk9xWUFQS3pZTDJHMXFDZzMyN3FsQmRJ?=
 =?utf-8?B?Q2srUmdwbklndXY3QnNPWm5oeitsbk5KajIvSTJvQmJuVGYwQUs0WU9FaFQ3?=
 =?utf-8?B?dGNuWVhJNFdLYUhpZk1pWk5QUk1YUVJPSGlKeTg4Q1pJMlJzd1lwZlBoUlZE?=
 =?utf-8?B?V3UrT0NJNmNUWDQxbWFWUSt0dzZ2d3FyUFpsNTJDd1hyeTltbk13NDNQbFNw?=
 =?utf-8?B?WFBmcmxFV2pqNVpOVCt3L3RXbm5obGZHNUxwY2hTUWhiN0tnbk9rS3MwcERa?=
 =?utf-8?B?bVIxV1FUd0JEN1FXR0JKK2pVTS9QQ1pBTGRjR1ZkRkVJOGwraEFmWkRsVXdZ?=
 =?utf-8?B?OUZ5Z3BUYk9xU1RtQjVXbGF6SUdVMjdtcFBELzd1RmhqWnVVcXEyOUV4WFpH?=
 =?utf-8?B?UDJHNFZkczFOWkk2N3Vxd0ErSGpYbWoyME1mUGE0Vnl1Ti9EY21VVGQ3SXlj?=
 =?utf-8?B?Q0FKdittUHdRTHRnYW5QbHNxdjRndTBuM1hyOWtwRUh3cFRTZlFYMkI5QkMy?=
 =?utf-8?Q?30F0MvpCRLOcqAo/BLBWE6AM6?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c98e5eb-ef4c-40fc-2c54-08ddb014a471
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 16:08:06.6194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Te2Hnbjj41KcmLAEOYJ1lPLfFHGxFOyP2VyDIyTFA8sRDvcp1d8+8c3ZGmoFfsI/lC/sKsGgWSw/5rLQ9vmkeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5702
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
From: Kienan Stewart via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Kienan Stewart <kstewart@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Nortbert,

thanks for the bug report. A change has been merged which addresses this 
warning: 
https://github.com/lttng/lttng-tools/commit/734b1cd20cb8390f9b0f6de9def9d5bccb621197

thanks,
kienan

On 6/17/25 7:00 AM, Norbert Lange via lttng-dev wrote:
> Hello,
> 
> enum communication_state exists twice with already diverging definitions.
> I am not sure if its a functional issue now, but this sound like it
> can cause fun bughunts in the future.
> 
> (enabling lto helps finding that kinda stuff)
> 
> ../../../../src/lib/lttng-ctl/clear.cpp:26:6: warning: type
> 'communication_state' violates the C++ One Definition Rule [-Wodr]
>     26 | enum communication_state {
>        |      ^
> ../../../../src/lib/lttng-ctl/destruction-handle.cpp:25:6: note: an
> enum with different value name is defined in another translation unit
>     25 | enum communication_state {
>        |      ^
> ../../../../src/lib/lttng-ctl/clear.cpp:29:2: note: name
> 'COMMUNICATION_STATE_END' differs from name
> 'COMMUNICATION_STATE_RECEIVE_PAYLOAD' defined in another translation
> unit
>     29 |  COMMUNICATION_STATE_END,
>        |  ^
> ../../../../src/lib/lttng-ctl/destruction-handle.cpp:28:2: note:
> mismatching definition
>     28 |  COMMUNICATION_STATE_RECEIVE_PAYLOAD,
>        |  ^
> 
> Regards, Norbert

