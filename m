Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EEDC3ABCB
	for <lttng-dev@archiver.kernel.org>; Mon, 12 May 2025 15:42:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zx3kd3PT6z1jyG
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1747064521;
	b=jdV3ecoS/wRqaotHQndeBtqwFIdiX5Kj31shYuWz/ZCJ/YtcO4M9z1j56cF/ufxk2a9J
	 cM6yk+VvvbIvZLPCRxclXcJ2sB4faigS0M3JNXQxN9T1yP9IhokqK3OckP7xqg/c2sPoy
	 kmjo02BQyoR6dZIVn0KxD5dX8b8//Tbj4Ax98oBhb8O30fyTbh6c0oeVzmxzKmxlwldSa
	 cPiIPf4vOVdDv03kN2ZIo+kbsv8ya1AZytdLpOoFmouK7NrGYwGbEn3yMdGl+XSmqjPsk
	 fWRzjm0pABlPqXEpLOmtYpix2JQCkJJX2EukoFjtGcJ9htV2ONcIXpvHZ7DdQ9EZ/rQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1747064521;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=bnV9PaHfzIRFnpfkYrBqy92WsbFzpMkwYhGKHIAacK4=;
	b=m2Dx8YemS8rwOqxPHUTPye7cNmXwuZ870mro6/VP4vUfkKDaNPGHWb4SPSiZKcvUv4nI
	 N5AC4Du6TsIVCGf7UMptnQsgH0/8S6vgILqS2D3tnFjpKOCQvS9t/t+AL4+pNqzIrDO/5
	 IlRZPqQ2RrzrtyXtPl9dKB8wUsKEnHrsP6ypvgOsf5bRxRtsL/bahTWhK27pZUefVem38
	 vK3xrCyvhLIjXjA92z3NsFV6yOqNYfUTBz97VyniuAIRkC2bAoFBKMLwdOzKa9ukPtO5H
	 LKUIFx9HXCW/doQfMpKCQTjHYyymQONpZ6HvdOQYosGwMND3hLyhAJVFKEjuSUDBbng==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zx3kd3PT6z1jyG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1747064521;
	bh=bnV9PaHfzIRFnpfkYrBqy92WsbFzpMkwYhGKHIAacK4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=C+S+uGtgc06h5kSj3DP6TaWJr4u79+3ot5wzCea5dcTnUmpba/J7F2Sef36JnsXJ0
	 IVwBRXFxsbUrRYUdS26LEQSDEYi+XXPG6Jb1IgleRrc+IRuZWXviRfmUH1/HR1HJt5
	 1on+zEttrblpdCpg0fmNOLgROW5d/LoPlMCMUURMIhPGhmO2m8RnFMS2atN0npCPj9
	 cdImj1g+p8QRPXqQgHoZIOSWpE0Cfqu2X8jhwCVw806JJhyiaiHc7msnMFU7dQZGVN
	 4FI9sN7P+lYVyoMcFGfi2n7Z16h6pDRXFxwHBruFkBtpIkp8nUEATgQGCV7SB37N/H
	 B7N3fMK3PypJg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Zx3kd3PT6z1jyG;
	Mon, 12 May 2025 11:42:01 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zx3kc2RM9z1jmB
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zx3kc2RM9z1jmB
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::])
 by lists.lttng.org (Postfix) with ESMTPS id 4Zx3kc2RM9z1jmB
 for <lttng-dev@lists.lttng.org>; Mon, 12 May 2025 11:41:59 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/E+ekrlxkazX4HvAcVUp1xbK81nblB06mURnUpfRvQjQVIaF/K2fWddN75fRQI42uPF09FEq/rZQZ1V5gJDZhpYdJyBZfpF58uecXpLUbQmXD67meRPaTZxMnxtjSyM+XnQBuoG4Aapg6pO+i4oxCQ81u3stEi0mxHRY6iRkXLew7I0zLHOS9fIhJZQp6dVWzCYGYvGL1Alp2j1C/BR9rIhI1ovkB0h2+cDQxRA1/JkuuDHbb29qDFsHiiYsnoWSurvstVffMe3VZR51haggOA6YFjOfOcQt4bpClQOOFrrpJs6T59+Hfcp+lSvRLq8BjcjS53IXK2f5b1VZfqdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+LK24WtbBC4a1jkwHOYHsvtbBleSTvk7pgfYRDj6O4=;
 b=FfRfUy5aY6C5WftPGSMHwJLaUK7iM10O6cA2Ns9Zex8i1/47/8Jl88kfekZsCkFKK+Ez7ebqOAQokbjp25wbbseW45eA9qoEcZkOiIlQSd3hJrEIFJgZ6PXhsKZBSbVGbVHxNB+I9l5UPX1zhEPULN78mkS4c2efpfi/fRDMQ3OsWvC8GnV+OfAFETf7kKvhPK5cW4OWCvV4PptZgfqTiZ6/e8tRghT7Xby/nxRTKR46Ts7eiRBR8unA/+FfGnwvDc1HAWniFXRZk6o5h5+vZVE71Jn5jjSWd5g32+C7uXkbQV5QfASGvkMuKvUKX72LjOoaM4iZ9tyfp0qUYwwLKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YT6PR01MB11217.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:120::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 15:41:54 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 15:41:54 +0000
Message-ID: <aff97e65-1941-413c-aa44-d6ba3e3431ed@efficios.com>
Date: Mon, 12 May 2025 11:41:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Understanding SOFT IRQ 1
To: David Aldrich <david.aldrich.ntml@gmail.com>, lttng-dev@lists.lttng.org
References: <CAJK_iegCiWpZcD8fyLCpkRtzOzv_nxyn8WBUs9gr5WDYQ1sK_w@mail.gmail.com>
 <c42f4ccd-5e16-4a7a-a9a8-19e61ee06b1b@efficios.com>
Content-Language: en-US
In-Reply-To: <c42f4ccd-5e16-4a7a-a9a8-19e61ee06b1b@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::32) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YT6PR01MB11217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa3b156-64bb-4a31-cec0-08dd916b856b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDlGZWtZTzlDZGQxbDVqbituTUtYVUgzRjZadGxZWC9xV2Zwc0FDQ3NNMnda?=
 =?utf-8?B?U3VJbVdYQnN5V3N0cFZRQWhjUCtGZGx1WCtrQ0xoLzUzMUtIZEo3SEJObzZl?=
 =?utf-8?B?QUhUaU1BQk9rY0JKYU96Si92YURidERJU3dyTmp2c0ttYTJaWTlESURTMjJy?=
 =?utf-8?B?VFVMNGFMUEw2eXdvTUlka0dDYzZKVEVoc3dmUEl1R0hBZ2NPOHg2MFRSS2Js?=
 =?utf-8?B?WFEvM3VpdW9LelIyN09qSEhQalVKaXZ4Mkk0cmxuN3ZHMFhlUm0xdHp6ZXE1?=
 =?utf-8?B?bmVzWnIvQ0J6U3RIU2t1TmxjakJYNERuSmdxaEhCM0xaakUyZVBaYmI0SDhR?=
 =?utf-8?B?c1VPU3hTcWR0Q283cEtaM3dMcXJCMm5vYWFkam5PT3kreUVpS2dxdllJTlV3?=
 =?utf-8?B?Q1B6d281dHgraXhVN1ZadFBWQ0FHcFJDZFd4bVBsSEgwNGNxRjEzZ2pIVE13?=
 =?utf-8?B?NkFSZGY1a0FzV0NzZXVMcDE0YUxYOE5FcmIyWXVxWlU5cm5lSWw2MVcrdFF0?=
 =?utf-8?B?Qytlb1JPZnFaQVNWNDRjeWNsK1AxYVB0b1prVktNdHI5ZUlnWTY5SElORWtv?=
 =?utf-8?B?bDMxU0I4VHRDbE9ybVY3UmNuR3BQcVFwdXZEcklnM1BHeGxSMkdYWk5Xbnhk?=
 =?utf-8?B?ZHlKeGZRMXZucWVtNEVnVTFhZmIzY2kvbitwbjZTbkFKMk5vSDQ3QnFrNTRm?=
 =?utf-8?B?ZzdydVJyYUJ4dERPeWlXcGZTOSswdlRRTUU3V2J3QU9laTY1WmZETWhINXZx?=
 =?utf-8?B?R2xNOGJyQ0R0TTJGaEZabG51K21ENTk0aXVoQUZ4bk14R2JUdmlRbmE4U2Ru?=
 =?utf-8?B?a1FuK2pxRmhGNjBSM0tGdEw5K2NwbVdzRmxoM2M0MHVnWEJJeHd0Vk1Udkdv?=
 =?utf-8?B?WUladzNnQmFldmRjZmpMckd6QUpuSlIwZityNkFRMCtyMTNObzg0ZkJ3ZTRw?=
 =?utf-8?B?RVVJemhvSjZ4YXJiQnVId0JhdVVjRUpoMnRUM09FMUJFNStpaUxHTDZ2bTYw?=
 =?utf-8?B?U0N3aUJoNXV2UHV0aW9SK0ozT09ZSlhlNUcyY0dlVUNOMUFObnZZcUlGRndq?=
 =?utf-8?B?bmpFRGpkM1dXVGo2dnRuTjBYUi9EWk5IbmhpZGs1Ykc4NmtVVzhlM1BzMity?=
 =?utf-8?B?Wm0wbk1IT1h2Y0cvcHRlNnA0YXBENm1VNXhORWpIdkZvVVdlSmFmTlZtSXFD?=
 =?utf-8?B?NmlLZ1EzYlhKWWF1WnJhQU9KWkZYWEhhOTdIWHFNUGFUWnEramM4UzkxR3Vi?=
 =?utf-8?B?aHdSVnpJNm9YT3dlQjFhT1ZtZi8yM2E2TXVsNmMvVTZ1emZMY09ERGd1WXBR?=
 =?utf-8?B?Mkc4cEtZNVNCVlVaeGtSV24xa1VxLzhrMkNRdnJ4QXFXRnZUcUVSaHZ2QlpW?=
 =?utf-8?B?bWUvRnhEOUdPdC9QSktoNlRXYnJNRld2SEhQcFRERUVFVTVjeWtIb3BSQU43?=
 =?utf-8?B?ZEZUaEZEQ001L2p5S1FPQ1ltR0lRVUF3KzRIRlllWlI5SE5vaHFMN3pkSTIv?=
 =?utf-8?B?N216bW5YeTB1ekE5eGJwd1B6a1pxdlBoR3pHbjVtbFZoaEhKb2p1bTYwZ1Fx?=
 =?utf-8?B?TnM3c1JkTHJURUtYKzBBWkJmOUc4QU1yZkpJbElITHBmL1JaeTRzSk5vOGZo?=
 =?utf-8?B?eHBXV3BmN1ZZM1hTUkd3SzJqV0UrUVE1djFtR2lnWG1OQ2xHcVl5UHh5TGov?=
 =?utf-8?B?SEtKQ0FHYzd0UVJyV21haHhwNWNUZHF6WEJBeDZRQmN2clpBeGIwd09JMk5J?=
 =?utf-8?B?eEh6MlR5WlJ2V3MrWjAvbnQrbGtlS3lDZG80M2FlUlNmOXNrYlhHL3RuQzZS?=
 =?utf-8?Q?DHnzyPw1wSTb+RC2DXnc7kFXbLVYA8Tg6ckLA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzU2Tjh4MVVNdFZxdXpRYzBOcmFqY1o0ejNEMzI5ejJKaUpIN0FUTnQ2OHAx?=
 =?utf-8?B?elB2aVN1UWJxd1BNaU1DN0d5NVdNRTZId0U4MHRZOGZKbG9SL1NzN085d3dY?=
 =?utf-8?B?c01senM3YTRNeUQwWiswUDBLdmV2RWNQUjF3TFdzekdqcWU2ZUVPQTRHTUJk?=
 =?utf-8?B?d2RWdWkwNGxKaUN0TE1iSFVIbDdybnpMQncwUmRUQ0xMSDRrOE1UbXZzaXdj?=
 =?utf-8?B?cEQ4NUlLekxLVkc5VnRZS3ZaQzFkRHV2STBxU1hYUTR0YjloMUFDdjVUd0Vu?=
 =?utf-8?B?czd0cWcreVZaR2RMWmIxcXh1eHpoS1h4bWNSTnhTb2JoS0ZKak9TbXhsWEJD?=
 =?utf-8?B?V3NsaTRhUWNYZUpxTDFQbXU4WUNyc3ZqMm1JUytZZWg5UFpUSnZYZzROeE9G?=
 =?utf-8?B?S2UzY3JkeHlGSlRZYTluckI1STRLTS9sSnhHRExKM1RvTlFFU3Nhd29LWlo4?=
 =?utf-8?B?YnVoUkY0TVc1c1FZQTQ5NFVTNldtdXNTTnNRQnl3ZUlaZm9XUk8zWTVUcnEy?=
 =?utf-8?B?Tk1ReWw4VXM3ZnNrSEpPeWdFSUd1UDFmZ1U2ejdrRUx1YnEzS2JpcGd1emlS?=
 =?utf-8?B?VHVRZjB6MGpXSThXeUpoQ1JkL3RKMTdZYzVMMUV5MU5xRDdURHdJTVdlYUdF?=
 =?utf-8?B?emVkUkU4OWxvUXlXRGZaaW43T2FDb2djYVNxd0FDOUV0a2FaUWxrVUNyWURh?=
 =?utf-8?B?ZXNUUTRiby9SUDhLTWkyaU1XMEtZQVVRSWpLSjh5OTd2NnhIU0JQc3diaU9D?=
 =?utf-8?B?WVh2cTVJWE1JTHRNQk9ESnZRZE53ZGRPWWx3M3ZqSXgwWmhNZ2tsRHZQVm5p?=
 =?utf-8?B?VVhSaFl1V2kzaTJmZ3psNUVzSktZMnF3ZE9LOHJGLzVYSVBhdXZsKzRxeStF?=
 =?utf-8?B?WE5UTVA0VEhtcXJncGV1SENXNnlmWDl5VEE2MjRBMTJLdGlkSVpJM1JEYkFO?=
 =?utf-8?B?NTV3aFNNQWVJd2Q3ZmV5cGExWTRNYWt4SzNRQ1oxaVJCM3pLaTZFWkRxL1ZM?=
 =?utf-8?B?M3NQTUNIQ2l2c0RoanUxbXRoL1dMQkVCTVdQTjlOalZBaDdqdU5rS0tRSS9m?=
 =?utf-8?B?WFVHMWcxbnVPOXlxM2RENDMxZEs3MTBzOGVmZzUxT1ZVWTFvb0U4STBic29i?=
 =?utf-8?B?eFJtMCs0K3RrNW5MQ01HQS9WMUJpVkhVOVkrdzlJQ0NNNjF4SW5VUkVuZmRj?=
 =?utf-8?B?a2QvbUVqWU00dU9uaG8zQ2F0ZnFDemJBZ2RlYnYzVnBMNkljckZLaHZkOWVu?=
 =?utf-8?B?R0xSbjFQZXBqUnRlZk5NNk9aUXBEM3VxR0F0cGFhQzFYTjF0WGM4OXp5RjRD?=
 =?utf-8?B?K0oyTnJVRHEwTHZvY2RpZjhsV1JuYmp2TXFwWDg3ZXJVMmZrK21Rb2I1YVQ1?=
 =?utf-8?B?MUpUQVVqd3NIRkY0cGltSHd0Nll2Z3VGUVVyYmZxU05IVWtNQlpNMkVoRjU3?=
 =?utf-8?B?cWhHOG9rOE1SODFLMHYzcVR2azMxNTFlWSs3bE9YUTA4cHhMRVFsRDNmNWh6?=
 =?utf-8?B?aTdIM1ZYTDlUNjg3U2hGUWVuM3dIa0ptTEtiaWQxa0ZjSWRqaEx4YWhIQ3d1?=
 =?utf-8?B?Kzl2dWwwRExPL0lkYmkweURRc2tPcGJTRXJ4ZFczL2RVU1hTSENFUll1TTA3?=
 =?utf-8?B?ditEdEJRTTFSQWM4MVB6cU9rNG9mVmlCRkl0cjcwa3RNQUNPdHhwRHA2aDY3?=
 =?utf-8?B?dHA1clBGRnNSNEJ4MDJ5NzFNVEtvL3FDa3kxUnR0eGNrM3VtbFJVbU9nM0Fa?=
 =?utf-8?B?cWJKQlVwMVNhajcyWk4rbjgxOWhDekowK0NtRlZpVGtORmNyRnBNTSszMkt2?=
 =?utf-8?B?cE5CKzZYcTVhWExkbDZkR2xVV0ZPUGoraWorU3FNTTd0LzB3aFlxemlUZkQy?=
 =?utf-8?B?cm14bTFNak9YQUFmNlo5eU5wcFhrOHVXdmhseDA2SmRJYVdYemF6VEhMR3k4?=
 =?utf-8?B?NXh6LzVkZlYyc0Vac3pYT1FJT2RNYkEyTXFKcmlNVWdvdjFTYVV3Ym1UNVhQ?=
 =?utf-8?B?QkZ1V2tFZlF4NS83TjB6MlJPanMwVXM2aFRVaTVUN1lsZjlrUGhDSW5VVTZJ?=
 =?utf-8?B?bDRhbkRPdzJQWjdrU0tYMjNjeXpTalRKbFM2RkZkVW55RlF1Rmh6VWduQk9I?=
 =?utf-8?B?ai9TbHl6ZXBlOGlKbmpzbFdkcjVObUcrMXgwei9QK3VwZlVSNWQ4MXVyUWQ5?=
 =?utf-8?B?T1FvdXZjdTRYMkRLbDhBREt1T3BUSTNNZUV2cVBuNWREdURmRkZUT3dIaitB?=
 =?utf-8?Q?lO3g1mPZIYGs2sYPbwFekCSbadbdGegF/zpiYUF/9o=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa3b156-64bb-4a31-cec0-08dd916b856b
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 15:41:54.8072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41sJfbDYYfJpTkv+FB/xTry5fA4avEAqu/MDmCtLzcds5MJ/glFhJ4FuqQZsLJPwzmwq4XCH+RmLYxZO2/dZIBqlDTjZzkYhy746+bEQkE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB11217
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2025-05-12 11:18, Mathieu Desnoyers via lttng-dev wrote:
> On 2025-05-09 12:00, David Aldrich via lttng-dev wrote:
>> Hi
>>
>> I am just getting started with LTTng and Trace Compass. I can capture
>> Kernel and UST events.
>>
>> My purpose is to investigate why a periodic task, running on an
>> isolated core, has occasional blips i.e. it's period (duration)
>> extends.
>>
>> I have inserted tracepoints to mark normal and extended durations. In
>> Trace Compass the blip tracepoint is preceded by a brown state that is
>> 'SOFT IRQ 1'. This extends down all cores. It lasts 105us and is
>> likely to be the reason for the blip.
>>
>> Please could someone explain to me what may be happening here and how
>> can I find out the reason for this SOFT IRQ?
> 
> See include/linux/interrupt.h from the Linux kernel:
> 
> enum
> {
>          HI_SOFTIRQ=0,
>          TIMER_SOFTIRQ,
>          NET_TX_SOFTIRQ,
>          NET_RX_SOFTIRQ,
>          BLOCK_SOFTIRQ,
>          IRQ_POLL_SOFTIRQ,
>          TASKLET_SOFTIRQ,
>          SCHED_SOFTIRQ,
>          HRTIMER_SOFTIRQ,
>          RCU_SOFTIRQ,    /* Preferable RCU should always be the last 
> softirq */
> 
>          NR_SOFTIRQS
> };
> 
> So SOFT IRQ 1 would be TIMER_SOFTIRQ.
> 
> Note that we have a TODO in lttng-modules:
> 
> lttng_dump_softirq_vec()
> 
> Implementing this by dumping this softirq table mapping numbers to names
> would be a welcome contribution.

I just implemented it (only compile-tested), see:

https://review.lttng.org/c/lttng-modules/+/14611 Implement softirq number, name statedump

This dumps the list of softirqs into the trace with their associated names.
We'd have to check whether tweaks are needed for older kernels before I can
merge this.

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
>>
>> Best regards
>> David
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
