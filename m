Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47580C3ABBC
	for <lttng-dev@archiver.kernel.org>; Fri,  9 May 2025 15:10:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZvC9z5YyYz11ZV
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1746803449;
	b=jX8Gq+Ie39jf0t3Wmubl0ITUUUxWQBlmmwL5spWIX+qauoTHAuy1uBCde2pxl9ALNslt
	 Ck/3o5OkbSwCtV+uqFkPMyYftftcZ/fN7pS8lydAWxNCh8xtGpy4rZ80gcndZtd3PFatz
	 xmtPBVmXzYGFs2mKvqpLyFauhdyq1utUMIbBWc483UOyPUlxwiMvtMt9x4Aw7I5+qYhGa
	 N1KDzSLBD3SP+zL3BiL3XWf+1+JZlMp13fjLCMxdhdBPrA3DcLLvGn/aOF4ibQhmdo8Ru
	 T+nuuUbntQLKuTJ8nPm7yoMyeGQYfY9dDpaRXH+YcEFHpahMPC3Bb1aNCQSDFSqb4QA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1746803449;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=wzSZ3uoQh4xvPN/e7FhTy5nCJmRxUUeUhJrlYZNNvrc=;
	b=PwAr9mvfQgNt1lRaFBNA672Lqex1Yr0c9weegIYbsCYMyUCEc/l9PWSUDe9GUFXTX2zD
	 PKG8qfHPdRHbkB2MZyepPOV7XLLHnp6dTWjVejxqaoYypiFs4vB71giD2H3kEPswJyNqz
	 F/Fehyjl2jgoYo8fyn1jJR/hm+dKVWwf0yt+GiMAD+EnkJFybcK0cKugjk176lpAfjWom
	 YqpXWbgN/VFfpndzXf61vMFVvr/FVfcaexVvleyiEfwddXDbILDTkuSM1skP7+YRIlWJK
	 4DgV29gWkpS9uCD8rieWjDIloJxbej4y305liSWSX1iklqfFVkaYMQkRzIkP+UgLBhg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZvC9z5YyYz11ZV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1746803449;
	bh=wzSZ3uoQh4xvPN/e7FhTy5nCJmRxUUeUhJrlYZNNvrc=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=GAylJ5WdjTamvJusXEXUZhvN8xHxC9wIJAe+m7dO/zoJD2GM+swu02maQ4V1ysT+P
	 SLGoa2fvdVP0LjhDSsMKimBkli1RaG1ahBcsFKDKlsPy3rTyICUH0/M5yZ+rk/5dmA
	 y6FxPGfMoNbIF4npuK+FQNMoUTE9tftS4SCOVWHg/VUNnX+aF0LoheZuUBpGYqvgWW
	 XOAD+2o+5Kn8/eLFNZOK+Jee10d5Rw5iTCmRniQ+7Q/1rT35gp8ugVTxerJTYm4zy1
	 OOVK4UZLU+vjrwhPk4C2s7S8cq5VWBhhSw2nEUnJEG/Ohl53hVes5AGfggXHA5UjjT
	 pPkqqEmzCnp8A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZvC9z5YyYz11ZV;
	Fri,  9 May 2025 11:10:46 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZvC9w37Qdz11Sy
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZvC9w37Qdz11Sy
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020101.outbound.protection.outlook.com
 [52.101.189.101])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZvC9w37Qdz11Sy
 for <lttng-dev@lists.lttng.org>; Fri,  9 May 2025 11:10:43 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJJ9H+mHOK1DX9ewAvL+yYrDz2rgiuC83UdUHMSoG8JRFSdeZ5dUVdTfpQ4bTWJNcj41F2qgb7g1JAYorHVfkeDJLstYVCoOmhHgDVlsVYE2v9eKJ+EnAg34XKvnxsosGFFg12HO828HsH/7uDw88m3WiMpRfSLNu/7FcjKanzCHmOkt0TkMtxIRLguEcvQnsDUTJ5FCfEjvv6nfslUHNqdczvAeEuQ71JjfmZH4r0L2GgfPuCaBD2CqhxHiaZrP7fUf59lL3/Uj0RJ5x0XXcJ5xRjAvjBP3z8TCz2l6iD2ovpz2OFwKIi8xYY2mCmVJf/U76X+PgQsnqvEuXoUkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjfwiWpPiz4DZkafPUQoMAatO+91usuVXzBjb1FKLDM=;
 b=X2ecvV4S0B9mu01hrvL1SgxYi3bmQb4HoprGHWAYhr1/rpBDLao5DcGHJDIdXqgP36/XCWWJVPdbIEHvSgL0gFj0NbeDj8fZh8X5Dskq/93N0h7Oaz6XP0M/EAMyN9zJuEzcZwCGpZyR5KaxiXF+M8VuMVEgX3+BD0oP1msPW1+x3jrWc746XRh1lKPHevoHOjEeNc6TBWqHAqcZFIGN3f1CQ0S8CFgj10m5T/HR0BW8+F2h4QkZMm4yryMRuYQXNSee9JxDGmSOiyJ8p7F0lUqHC3c2fs2k6a7yvBDWGFSdISIlwIDRWH204PbinuHc97H1jxgOK1/ClI/VbJXaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT2PR01MB9681.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:df::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 15:10:40 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%3]) with mapi id 15.20.8722.018; Fri, 9 May 2025
 15:10:39 +0000
Message-ID: <7078c448-41bb-4ec3-be56-cfd93ea94ce7@efficios.com>
Date: Fri, 9 May 2025 11:10:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Problems with arrays of floats (lttng 2.13)
To: Herman Bruyninckx <herman.bruyninckx@kuleuven.be>,
 lttng-dev@lists.lttng.org
References: <00f6c849-e4f6-396f-9f71-4b58bd203eda@kuleuven.be>
Content-Language: en-US
In-Reply-To: <00f6c849-e4f6-396f-9f71-4b58bd203eda@kuleuven.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::16) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT2PR01MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: e068b34d-6fc6-4762-a8d9-08dd8f0ba8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXhFZVhPZWdJUXBUV3Z6QW1MbFh4bE81d3dSQkIySlcvbWhiL1lJT1hDQmFo?=
 =?utf-8?B?ZWVaTVU1UkJVNGJxMG1jZXl4dmt5aHA5aEYyTmtpYnluQTFXMEU2QjN0TlZK?=
 =?utf-8?B?c0lLV0dGM3F4Vyt1bUVjYWxPK2hWQlp6aFBKd2xzMG9xek9pYnVXcEtLTHM2?=
 =?utf-8?B?S0E3RVRsKzZxTGtMdmxjTVpRVTZTVEpReUNvWFVydzNUY3A5M212bm5ERW9W?=
 =?utf-8?B?N2YxYXIyMFNPSlRRcUptSiswNFVDUDI4MG43U0Q2MzAwV1hoVVptM1lwWGpi?=
 =?utf-8?B?aEkrenlSRmZ6Wi93YzVobTB6UDQrWUFCbjNpUUZRaEc1VGJvRkRROXFsSGRn?=
 =?utf-8?B?RWpPYjhmQ0dmWjl1SXdYN1N6STdKMEYyb0NrYnlCd256a1FpRkRVamxVNGVn?=
 =?utf-8?B?TkcxSDFHcUJvbmhIVnh1eEo4RUFOZUhCUEM0SDcvM01JMWppNWVlSWRwNnJy?=
 =?utf-8?B?VGlocktQV2Q1WTVRcE45U05rK2gwT0FUeU5pQzdObzdmem02VVdlZ05TZm05?=
 =?utf-8?B?NXo5bDVkWVdVUFc4Y2tMSzZvUExSV2pCVFl3MEcyTHl6L2hNcUw2R3NzZ0Ux?=
 =?utf-8?B?VmFGeFlaMTRaQ2lFSlpIdk1qU3pUWFNuU1VkWW1wdjMzczFidlgwdHN5ZFda?=
 =?utf-8?B?RGRxby9xYVY0dlo5ald5d3poV0VoUTY3ajVGYTVFaTUwYUJ6VmRIOVJTZmEy?=
 =?utf-8?B?Q2hidGZwZERDNEE0MG9pRlhCY2NWYUFxVW1Ic1FUdlM5aEtsSjBGNkV3OTdL?=
 =?utf-8?B?S3dma2dDVm41dURFNVhUTE1jenRaZHpUUVdNMjF4NEpOTjZsbVlDeVJNWUxX?=
 =?utf-8?B?MUhFVUZJVGhIU0JJdWc4TkYza1BmYjJnNTVmYWQzNGt4ZC8xTHNPSHRBdUx4?=
 =?utf-8?B?M2RmOHpDbTFEWnZhZk1qeWd6Z1ppdmg1VnRvTG5kc2I0ck40QnBsUTUzVVA5?=
 =?utf-8?B?Q3ovWk92OUc5YlFSaW1YTnhRUFJzYUZYOFhHSlBQamJKck0ydXkxd0RlcjVH?=
 =?utf-8?B?OGR6YVVlcTZDNDU1NmRwc3JVbEtiOXhYU2tDbFpWckRLcDlGeGJwbGtwTHBz?=
 =?utf-8?B?QnErTUtKU3VkcVBNazE5YmJneTFJMk9sMytmZmFyaEM4Q3NXczlVQndPczZJ?=
 =?utf-8?B?TGprSko5NUZ6RWtvclFmbUliY2E5UDJ4NU9qazExNXZOWW1VRllQSk1NL0w5?=
 =?utf-8?B?S0dTSWxWc3NVWHNWOFlFMDhQN0hRem5YNCtYMEVXQzVLdVJnZm9KNS8zYXhN?=
 =?utf-8?B?Q0o4VzhWQTBIc0F4eDZ5aVljQXgxcnRySld4SVNzVFpRSThwN2F2djJzTGk0?=
 =?utf-8?B?cFZJUkNqTTFwSTd1NUpIMnhsTERieFFaSzZpV05JZTNEVC9JZWlNMzZtV2Uy?=
 =?utf-8?B?bmZPVGRVZEJSdjVrdlpQV3dBK3o5WmZrL0FhcnF4YTZpeHZ0U3pvYjlFM0xx?=
 =?utf-8?B?TDVrRDV0K3Z5NmZJS1ZVQnZHTXZ3QUFBRWI0WWQ0SzBGY0I3bkpEQkNqLytL?=
 =?utf-8?B?VVVzSTg1em01cDlmWDRwczNNdS9mcjVYUzhTU2NCY0kxemxjS3FkWEprTDNZ?=
 =?utf-8?B?UUhVUHk4RngvRXJOc0llMVBGV3Zid1FqbDFpa3ZqdzF6OFVsUHVyY3llQ21G?=
 =?utf-8?B?d2w0V0dUSlRxN3czRmc5RWtwYllreFJHb1kvVkhLMXRIZ2NxUWJ0SXIvOVZJ?=
 =?utf-8?B?K2RGSWNBVE0rNFlIVlBQVmlPWEI3SDdWRmo5SGhNUFl5MG14bk5tYnlPRm9H?=
 =?utf-8?B?eFhlT2RGSUhITytpNFVPcnhGamF6UVliUnBRS29ocWphbXdhclI0UnVIWDVB?=
 =?utf-8?Q?VX8xCeJ9xjGlzoQRv90zfdcFtbbsIM0/F4m88=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1pXSXRjM0pCNTZ2cXNwVEJpTVQ4dlVyVktENm41QVdjcE9YOUdjRjd2SUY1?=
 =?utf-8?B?aVJobXN1MDZBY2RBVzZKMm1BRWl4dzdaYXRvUEVUc0FGTElLK3dpVDZqWXNv?=
 =?utf-8?B?aFQ5bW5YU0kxOThkeEljUHRkcDd2ZVUzV2hpbGkyTm1aMGdKUjVNNkxYS0t5?=
 =?utf-8?B?QzdmL05CN3g1L3dKek5Rb3doc0RtSmozNC9iY0ZQMWJaRW04RnBUazRMbjd4?=
 =?utf-8?B?Y1pmNzBVSUxPdGV5cmhEcTRZMnhxeUJ0eExzL2VBTkovNGRPQ0RwbnVjVi83?=
 =?utf-8?B?NnpiT3hzRitWU3RwTUt3N1JkQWFGb0tFUHNHcGdKQW92bHVyWndWR2dYOEZq?=
 =?utf-8?B?djZJc1ZYeEpVUHpGdTJCVEhsNmkwbk1oanhZYUFoYTJvenhiem5nQWUrbXFX?=
 =?utf-8?B?Z3NZZ3hhYjhjUDUwdmNuVnN5Ylc1bUp2M0s2VGs1SXg0UDlJRGN1RUIxdUd6?=
 =?utf-8?B?ZlM0clc1WE01OFVTbmlrdnYydWVrT1BwVytNd01FeEplOGVhMkUvalB0SFJP?=
 =?utf-8?B?ZXgxMU9XMmpiWk95L3JzNHd4ZUtIZmRsSmx6Yy9VQXdJMS92T2VMTC9TaHNr?=
 =?utf-8?B?eGZYQWR6aDNob3dWL2ZkRE1VT2pGWG5OVHBnVzlPa3JoeDZZZzlrMUZOZHRl?=
 =?utf-8?B?RmVGNlR5cGVteEVXRDJRRzVuaUlSQ2VLRDE2TngzZ2t1WWcrUXl1N0tlSjVm?=
 =?utf-8?B?N3NjYW03Skd6SHk0UStPVlFSVGdwdmFIYndyRU4xVHNsRXVzMWlQVDFSZEFh?=
 =?utf-8?B?UEtDLzN1VmhnNFRHWURsSzVweFYyaHRNNHR2QzNuS0lYNzhXRnZvNXRhaklP?=
 =?utf-8?B?UTdXaVhPVjNhNVRNOE9ycEtGYmZxdG9QVGFieEdCNkpwS1Fld0sxZm0xK3dY?=
 =?utf-8?B?Z0ZmMy91N0d6ZHRvZGpsajNJczZXN2JLR3MxZ0lRRE9XUldJbGNtaUlOOWgx?=
 =?utf-8?B?eFNsUHFvdVVMdVpUK1lQdjU1aG9TSzE0c2hvbU5yWHZjT21aSmMwWms5RjIy?=
 =?utf-8?B?VVJCNXpXUjlHQ0NIWjV2Y3lqKytBUi9tTlJkT1hpcDZlZWgvN0VIY3JiL3lw?=
 =?utf-8?B?ZU9jWmp0a3pTcjlGU2kwYlJKK1d1TTJXQzB6OFBiZ0t6RVBPNDJNNGJUcDBi?=
 =?utf-8?B?aHVrRC9EN2x5emNXYlIwN002azlFOGx2V3NCK0tIRDYxdWZLSHNaQUE4VjlS?=
 =?utf-8?B?SHBHeDdUS2tTQTB5SG9XTEYrcmoxc3cxenVXcnFQM1hoR0VCQjNIY0IyMkIy?=
 =?utf-8?B?SXIzc1cwa1RRaFdubVVrMVJMWnQ5UGJCbEpaVkE2dlB6SzJaQ0NCMElGRi9k?=
 =?utf-8?B?Uy9vSHdTZ0xOOFV4ZlFpUWR4aCtvY3UranlNRGs4SVF1TS95YkgvSytTdU8w?=
 =?utf-8?B?bVhaek1uRVpiSEhaKzRkbVpUeWZEMXVCZHFkZEdFV2tRTituM0FueUcyenVD?=
 =?utf-8?B?N2dsUW95RjZDMGJTT2poYUhQOTA3WDdEYVNuQ0FuTEZlMFZqSXJTQ2thVGVK?=
 =?utf-8?B?bmhCUUREYUN6TWRaSkVHdmdmUmlodlV4TTUydFZtcGJmNGI4eVlLWldvOHR5?=
 =?utf-8?B?OEtBZ2V0MG1DRFd5dWJPQWRBYXlUeUNnRFZSelpwTnpHbUQyL1ROdWxyYWJv?=
 =?utf-8?B?bndpS3VkcVd0THMrWldIbkJNekVSUy9TTjhORWdodzZzeGJ6WlJ0eE01aWlT?=
 =?utf-8?B?SlBEdUd5QWw5Sm9wVm54STZzbG9McXg1Ky8wRzY1YnNuaTJtN3BUWDBIVEp5?=
 =?utf-8?B?UnZoSVBjd2hpbUtKOG9hdVExdVhRZDVHREVyYmNKOG5MUXNwT2pqQlhGUStn?=
 =?utf-8?B?K2RxWWlvYTVhVi9xZkRiQlZTSHNRNnMvSmJHN3hLWDcxcStkNWhxbDdQWlhZ?=
 =?utf-8?B?OGt6cjZzS1ltSVBEMHJucHJQNXQrcFF0cjRycENWTDFxR21nNU5wSmloSWlC?=
 =?utf-8?B?NmZTdlVjRTZIamR5YzlpZ3JybGRVcUxSZ0o3bS9DQ0FmNjhaaGUxdzFwU2l5?=
 =?utf-8?B?cC9jdVhzSm1ibHlkWmJXVVppNDEzNnRFTTdyelRDUjh1a1ZWTDFpUTRmazRw?=
 =?utf-8?B?bnZ4VHNaOXZXRExFN3kxNXU5L2dPb1EwM1JEM0ZkbHhWaEtTVHR1VzZlaFVo?=
 =?utf-8?Q?Q0idlatrleRtpxrq0H3BkE3Wo?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e068b34d-6fc6-4762-a8d9-08dd8f0ba8bb
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:10:39.6709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXAP319RSQSlTr5nlYNrTyc/0PKrpgI7mLEl5dHuTktmHc21aDhdexYLCGoLoHCuKI67dp2oFqJkVExCk5FRDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9681
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

Hi Herman,

On 5/9/25 6:03 AM, Herman Bruyninckx via lttng-dev wrote:
> Dear all,
> 
> I want to trace an array of floats, but I always get bogus output at the
> (Python) Babeltrace2 site...

could you give an example of the tracepoint you have setup in your code 
that doesn't work, with the corresponding output?

Could you explain what you mean by (Python) babeltrace2 site?

Are you instrumenting python code, or are you instrumenting a C/C++ 
application with lttng-ust?

> I have no problems with arrays of integers, though.
> 
> Is the float array feature not yet implemented in lttng 2.13?
> Will it be in 2.14? (Also the "BLOB" feature is useful for me.)
> 

I don't see any changes in lttng-ust for 2.14 that allow for tracepoints 
that have float arrays or blobs. lttng-modules 2.14 does add support for 
CTF 2. The support for CTF 2 in lttng-tools 2.14 will remain at an 
experimental level.

 From the release notes:

       CTF 2 output isn't enabled by default and is intended solely for
       preview and feedback purposes: having an experimental support will
       allow users to test and evaluate CTF 2 until we make it the
       default output format.


> Thanks for your help.
> 
> Herman

thanks,
kienan

[1]: 
https://git.lttng.org/?p=lttng-tools.git;a=blob_plain;f=ChangeLog;hb=11f963148df9597de6d891d96d748bae5ced7149

