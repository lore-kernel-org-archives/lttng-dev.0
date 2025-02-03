Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70198C02192
	for <lttng-dev@archiver.kernel.org>; Mon,  3 Feb 2025 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1738594571;
	bh=BuSeWrGvij/68w6x+h9BC8J6x+hRtb6t9niGkO4Edpg=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=o/K0pkoGPHCJ09+tNLsn+wBLdfRwvhTjRmdNuTvIRCfYgTjEnKo3a3A+Bpi+696/N
	 ahrZ6ngWTqGWMesBtIhPIIfryBHPH2PofswOAVm2OHLXykhxDacKPSsWDVP79R9H9X
	 /t/qsRrlbX0UiHAghH3xVI+GeR7S/3/x6P7dOnRhSKINoFbx1T+69rGgw2+Hhl+5Dx
	 +Brqk3j2dqCVQ56E4hn1MWCRscaNaV1BMCh+fHEndTM3Ie1qv7cTtvHojr+sivNeIG
	 lVqXcwVpo8TIAIvg8rga9bY6z9zPwVC0UU3duU/ULK+06IKp8dNOHvK1DH+r9cir4u
	 F2PBIRDhJp2iQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4YmqLz2tVyz1dxC;
	Mon,  3 Feb 2025 09:56:11 -0500 (EST)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020083.outbound.protection.outlook.com [52.101.191.83])
 by lists.lttng.org (Postfix) with ESMTPS id 4YmqLx211Jz1dx7
 for <lttng-dev@lists.lttng.org>; Mon,  3 Feb 2025 09:56:09 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxRXxi3qXXhaREdNfkYu8BGOeAKwRy8SakZo7ToWnmix8qprgaQ0anafQsyNaH3OBR1Miw1k8IuRQ4E4QVyNB+TNLhBwIgpg42tGHtHgA784nD0tLnlL923y9f6UyrNr10SDNxQPq8CTs9eC+RU5627zENqz3Z1pLI4i882uQXW/T+59RzssuXxR7BmUhk8+L5W4pC2WokmyH9DWroNSiNBdDq+y4J4jrRd/Moz9VQDE73qRx0gUgFHUaMcMGWsL87gy3sAmtiNo4f5Rc2l9v33GnXx02N3R0sCcJDeDUG/bfbyltZ2tymcjIwINs4d1D6/0DYHLhGMfXKsHLsQEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTEM759CfuTDN/hDii40KVAii1LZWeqD2OUObEGXJvo=;
 b=MNLJe9kj++ot7LsSgun4YdHGI20lIYQufEiFa6+Jqbm/8eSdR0tbLwPQnCEtwFWv4xWtbaWror3o3Nn3eiEuw4XFyKwu9o6po7DfnJky10zl7A/HatoqTW/g4u41pKkWEUPgLWi9dFMwswh43CHunxJgKcuMSBdoRVheT2HdP2q1c23nf57T6ZeHKh6ZWl4bXw0R8CROgbINnqoRTsU/AS2USXvUBOKPysLQ1N3Biwjh5gnHaYtB/u2OSUSbP1EO+Qo5DEt76LtyYUGE7KRx+JfMzVSZti8z/1iA/i+IZypvTMHIyxMIz0rdsqkM/s1vPJJi+FM57/ArqLA+xREH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB6292.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 14:56:08 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 14:56:08 +0000
Message-ID: <1da0ead9-b3a7-44a7-9c33-8da6a77f45d4@efficios.com>
Date: Mon, 3 Feb 2025 15:55:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: librseq memory allocator portability
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>,
 lttng-dev <lttng-dev@lists.lttng.org>
References: <165086BD-96DA-4A95-8411-F87DB502DB23@sury.org>
 <be6b6084-0356-450a-a090-8bb607f9a16c@efficios.com>
Content-Language: en-US
In-Reply-To: <be6b6084-0356-450a-a090-8bb607f9a16c@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0316.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::10) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: ad517f63-3761-45e5-2461-08dd4462e3e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SSt1S0hONDVmTk5PZEpHUFhXM3N4czJWakZ5QThDZDFvajFMbXhUVXJ3V2Rn?=
 =?utf-8?B?bThQZUhibU9EOCt6cStNSVRZVHovd2tpZk9ISTlNcGU5SEs1QTdWbVY1UFpC?=
 =?utf-8?B?YlEvWjEzbXZvOUdBcm1HS3VqWkcrYUF2ZDdsSE1MU0h4cS9nUGNNQWxrWFJp?=
 =?utf-8?B?UHZTMS9HVVNrRzhtTVRRMGZJWVJLNGN6dXBTVnNTUjRKQzBVTVlBOHhES05i?=
 =?utf-8?B?NjZ0clA2c09takN4ZGRpNCt1UU02UjcrRnRlWFRiN2tRN2h6MnE3UGN0bDl0?=
 =?utf-8?B?Vy9TYzBzOUMxV2tMbkgvRHFrMUxLVjhQMTQ4MWlPZm5mQUswTlBwWVBQZG1u?=
 =?utf-8?B?akdmczZuZzJORHdCSkYxUWFpVFJWUlA4LzYxbS8velgwZTI3ZjRsUFdYdTN1?=
 =?utf-8?B?NitVSVRVcXlydzdDcjJSempiRlFHZSttR0E0VnZRb1UvT0hTQ2M0anBqdmdS?=
 =?utf-8?B?UTE4SlJjNVErakdYQkhXUmg2cTFSVktFRFQ1VVZ1MG11RUlBNWkwcW9GcTZO?=
 =?utf-8?B?Ukg4Ris2YVpTMzJWT3JRYmQyb21EbVNQWHRHazB4THJVSTdXcGFIVGpyRHc1?=
 =?utf-8?B?ZzI5bmRBNDBnaG5xNkpXS0oySFpmT0FOaFhsY2NJcldQeWFxYkNsYllNK1BD?=
 =?utf-8?B?Y29WdlZoYkRMTXkrTUhxTTZsTjY0SHZMd3NXNnUweXQ4ZXRaSWYzR0duYXBV?=
 =?utf-8?B?dnkzNlJwQ0pCWm1FdUl3ZkpPMHF2bzZVcGNEeEUxYjZtZGFKZEUzRjJwelhB?=
 =?utf-8?B?SXNPSlFxT3QvZnk3Q2RpcXJEVExBZ2NMWWNXQXZTdHBiY2p5RXRsMzZlNy9v?=
 =?utf-8?B?QnRaZ0xNb2F2Q0wzSEdHd1VxUCt1a3J3b3ZzQnRSbEE5V2lFTnV0Vk1MbmtS?=
 =?utf-8?B?MCtQSnl2YXp0SzhWUS9VbDI0MkxNZE0yQzNiMWdibHMzS2dqR2xiZXVKbjA0?=
 =?utf-8?B?aFRCbWMwTmZMYlNPWTRXZDFBZGVNZW1xVTVMS1ZCbVhIZFBwM1JCQXprbW9j?=
 =?utf-8?B?ZXAvU2dLUExla2o4dXNlSUtZaVdRZXdUV1h5Yjc5S1FjRjRTRU9RUkY5NzNv?=
 =?utf-8?B?WUFrK0JSbG9Ma2dsRFJhV3A4SFFjMFBWZDlhNVU4RzVWZUJ1bHVSbWtLajRK?=
 =?utf-8?B?ZEVFMkZCZFBvUDRjSElwbW1ydUd1MEtvTnFxWkJkSnBMbUhWeWQ1c0NlQ1lT?=
 =?utf-8?B?VUZHV2ZkQ2NuT2lrdlQwVE1QeHJIcU03ZHU2Q09vem5CWkUwQmJLejRwUldu?=
 =?utf-8?B?aE9LYzRUNW4xeXV0TXczZ3ZJUGhhdkcxajk2VkROZ2hKUW04ajdTSWtFZGZt?=
 =?utf-8?B?YVR5dGpYN1phUFVsdEZkU211aEZqallFWS9YVDhWNjcvUjE3RlJxWnlBcUVP?=
 =?utf-8?B?cklxZjFHVVpuNEhBRU9rbW1FSyt5Tnh1RUxZUEdtbTlocFhhQ2FIaVFjQXdK?=
 =?utf-8?B?bWtrTVI0UlNYY1V5K3ZzNXhmVlliMlVCdzk1Q3dNVFRiVzEwbG9pZWxzUW9L?=
 =?utf-8?B?QU5tSVdUM1YrTXZHQ2JaQmk3ak1QTEh1Z2ZWMHJOYVlYOEFxZ0V6dW5WWjdZ?=
 =?utf-8?B?Ui9zdkM3R0JCSzJoK0kvejVpVnVSL1d5VGE5d296UGdMbVBFcUxPM3JzNXVw?=
 =?utf-8?B?bVR0K0FzMXBHNXJPT2ZQUkxNekZ3RGRtTWxzbm13ZHQwL2FCRE5HdXVITHpS?=
 =?utf-8?B?VmFYbWF5ZmlxRCs0QjVOT0xiYm5uRDF2emEzSGdRczBsZU9NVnZEOUlydG1B?=
 =?utf-8?Q?+bxKIiBfvYvChwQUCLaznDL/z7dmopsU5tVtGsI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDc5OU5wRzF1R1BnT2l3Vk9wanREUHZpRzhZYzZRS0ZaQTlzZGFTdFlOWCsr?=
 =?utf-8?B?akxxeE9GVnpNVHFYdFdZUHVQdU5xMnZTSms0Y3VCbXdsVnhLZ3VQcGhnTXE0?=
 =?utf-8?B?VmI2dUU2ZnFic0xPa3ZqRFFQRjhtdk52cmF6SmcvZ2M1d1ZLWG9PYjVUQnZM?=
 =?utf-8?B?SmFRMnA2S2hWVUVjZFV1QWNmRnZna1NhWndmTEdXVXAweGNFanBKNGpzcWxu?=
 =?utf-8?B?Q3BSUXNlVTd6QlF5TktjaUhOZzVOVVM4OVZMOHhZZWtTRlZta0Q4VElIclQ1?=
 =?utf-8?B?Z2hwSXpaNHlHV0NlTk1xaTE0YkZLMTNoUjRIRC9GWG5HUlBNVVMvdXVlN1Bq?=
 =?utf-8?B?aVFDVDN0Yk9pL0FDWkFzYjhJRTJJNnVUb093czIyM0tCc2JGVE5kSFN0MXl1?=
 =?utf-8?B?bTVVNk1ITlZnK3NyOEhnN0F1M2dDdmZBVHlhUDE3aVQ0WU14em9wNitXd3Fm?=
 =?utf-8?B?dHp4QU5BUTZzb2NQalZLM2puNkxETjNWODNSb2hqWmNXSUk4NndvZHRCSVY5?=
 =?utf-8?B?aEpJZWs2MFFTbXo3VTg0ZXpsNENRMm8weExxMWdYbTR3ZnoxZjdIa1R6b1RK?=
 =?utf-8?B?M2xXV053MzlxSkFQa2RncGhHaGgwMVZidlJGT2JleTRGZlFzK1pEM09pcU14?=
 =?utf-8?B?alkyWUVHelRyUmlYdExoMkVtU3U0cFplZ2I4WVBiS2kxbC9FdGxSL3dvaGNx?=
 =?utf-8?B?Y3pSQi9MT0w4WWlpY0Z6UXVvU29uOG5lemYzZXN4NiszZlRrNDlMMVNQTFkx?=
 =?utf-8?B?TG91RkxNZWVJUlk0cTY5a2dTK05LcWpXZ3JtelJxMzhMZzNRZzBScEw0MXlW?=
 =?utf-8?B?djFOWWd5aUFvQjBQY1NYaWtmbGpGSDFGZllJVEhQdm9oRHZjd0xZUUswYUp3?=
 =?utf-8?B?enIxWTlCVTlwcU9TNUdzZ3ZNUFFaUm95T0JobVR6UmdlbmZHZ3VlL0E5OWli?=
 =?utf-8?B?TVJPeUxxUGh1b0RZcE9XenB4ZnZTVnVHWjBGaFNScnZGbDYyVmkxejQrbVdm?=
 =?utf-8?B?NHlOZWpielBjRnFCVXRMTmRxVmM3am1oUXpzSjNQaEFTTGNZOGpvY1J1ZEZK?=
 =?utf-8?B?aktEN0cxYklBQ2NwVVFudGRja0xlK0tyRmZWV25OQ3dZMlNpQjVGcmRtbklm?=
 =?utf-8?B?MEcvNDZMbW82MDFXMC9aK1ltMVYwZ2FjNkpHalBuYUVacXYrY09BN0Y4Vmlh?=
 =?utf-8?B?b0hFRW1EUEdiQVlnQTk1UG9jVUZPRWJ1dlRvdHU2TU9mTzFlVFpOc2JyNW9o?=
 =?utf-8?B?cFJtaGl1UXZ5aW51aHplMzVUMmIreTBybnRJUlN4WlZoZlJ5RG55cksvZU5F?=
 =?utf-8?B?STFCcWs4d1l6Uy9BdW9RWFFHK29iVVBkeWJsSDN3WDFPL2h5bDNFbUh4aGp1?=
 =?utf-8?B?Z3Qyb1c4d05YS3pFVnFwSS8vOFZOM2dLckl6Ris2VUdSMTRyNmNIbzE1aXlM?=
 =?utf-8?B?QTR5UTZYb3JCU3dzeVkybTM2Z2FuVFA5WHRYdnl6L2FWMGRjaFMxbjlTK3d2?=
 =?utf-8?B?OE9Ba2VYdkhlNjZSREx4VnVQY3ZQKzl1ZE5TYWdMY2dqTUU3VlZ1OW9obEk0?=
 =?utf-8?B?Rk94Vk5tVnBaaEpYdzdZY2VGdkJwMXk4TUJGdjB4U055NjYvc2gwd3Mvdjl0?=
 =?utf-8?B?SWpHTTd4QXNYeVB1a1ZVSXdDVUpHMCtrSG01TUhTQUh3UERDNVJqYmhXRmc4?=
 =?utf-8?B?UGd1aDJCSTFnSnRTK0ZHYVQrNEhZbnRjZFpxclY5UTZlSmhNNWRuNFVZRmt3?=
 =?utf-8?B?eW8xNmEvT1NDQ0JGSlI1dGoyTXpES1RUVUllaGwrTHQwQXN2WDVoTlhudXo0?=
 =?utf-8?B?K3lJSHhWLzJlSFZkQTN5eEdrL0EvbDQ5enQxdVhUcFZodUZ3ZDIvYUtyc1Ro?=
 =?utf-8?B?ZFp5Rmpyalc1L0ozLzdQRUorVnp3dVM3WDV1L2JwYkNldjVXL0xuY3pPSExF?=
 =?utf-8?B?QmtPWTFlcjVkaDZXWjBIWFl2MWphYmpPWDZ5eTNOMjZwbkp3NlFrd3dJTDk0?=
 =?utf-8?B?N3YwY2FIQUxmdnZLNzZSR0VYWTBoSXRtS3hsOE1naGNZWVFaMTBYNm10RnZO?=
 =?utf-8?B?b001UXlkQnk5UTh2c21UM1p4L2xLRGlWUVpYQktFcGZsaGczd0Yzc0swaU9B?=
 =?utf-8?B?VUxWZ2ZoTHhpakd4QlAyUG96Z0xuVVIyelYrWTN2Nk5NUkJuOTRDUFUrcWJz?=
 =?utf-8?Q?KRq84g/pMMmsanhvPz63bJ4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad517f63-3761-45e5-2461-08dd4462e3e9
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 14:56:07.9054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDXwcWOdILUxguzjpHmumxDnZX0fExfRxdlnB9ZZLA19v4q3u+PGV7IHWtRh0h6T/4q/gavOWMAcFoU4CJ0U+ktcrrw7kz0oW/Ralx7WHJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6292
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

On 2025-02-03 15:52, Mathieu Desnoyers via lttng-dev wrote:
> On 2025-02-02 16:48, Ondřej Surý via lttng-dev wrote:
>> Hey Mathieu,
>>
>> I’m actually thinking about using librseq for some more lightweight 
>> stuff first - like statistic counters (especially those related to 
>> memory allocations), and my first obvious question would be - how 
>> portable is the librseq memory allocator?
>>
>> I am not keen on having a code with ifdef spaghetti to support BSDs, 
>> so I think that it probably should provide some per-thread memory 
>> pools at the expense of just consuming more memory on platforms 
>> without rseq system call.
> 
> Hi Ondrej,
> 
> I have good news: the librseq mempool allocator is completely
> independent of the rseq system call. It's just a memory
> allocator.
> 
> AFAIR, the only optional dependency which is Linux-specific
> is on memfd_create for the RSEQ_MEMPOOL_POPULATE_COW_INIT
> populate policy. The RSEQ_MEMPOOL_POPULATE_COW_ZERO policy
> can be used as fallback on other architectures. It uses
> more memory on systems where only few of the possible
> cores are used and allocated memory is initialized to
> non-zero values.
> 
> Indexing per-cpu can fallback to sched_getcpu(3) if
> rseq is not available, which should be common enough.
> This is actually what the librseq rseq_current_cpu()
> does as fallback. So you could just use that static
> inline helper.
> 
> Now in terms of strategy for using rseq critical sections
> for a split-counter use-case, let's see our options:
> 
> - You'll want to use rseq_load_add_store__ptr() on your
>    fast path. It will return a negative error in case of
>    abort, or if the environment does not support rseq:
> 
>    A) either your Linux kernel does not have CONFIG_RSEQ or
>       is too old,
>    B) or your GNU libc does not have rseq support, and you
>       did not explicitly call the librseq thread registration.
>    C) or your environment does not support rseq at all
>       (e.g. BSD).
> 
> In the caller code, when handing rseq_load_add_store__ptr()
> errors, I would recommend a fallback to an atomic counter
> increment of a _second_ counter, so if the fallback is used
> in a situation caused by an rseq abort (e.g. a debugger single
> stepping within the rseq critical section) it works flawlessly.
> 
> Then you'll want to sum up the per-cpu counters for the rseq
> fast-path and for the atomic counter slow-path whenever you
> read the counter value.
> 
> We may need to tweak the librseq code a little bit to handle
> case (C) for BSDs, as this has not been a target so far, so
> we may need to add a few #ifdefs to cover that case seamlessly.
> 
> We have an internal project progressing at EfficiOS which aims
> to implement the equivalent of the Linux kernel static keys for
> userspace on various architectures. The goal is to dynamically
> change the code behavior between a no-op and a jump, thus selecting
> between rseq or atomics from a library or program constructor
> based on rseq availability.
> 
> Please let me know if anything is unclear.

One more thing: we may want to go ahead with the implementation of
fork handling with pthread_atfork which is still on the librseq
TODO list so we can eliminate our dependency on madvise MADV_DONTFORK
and MADV_WIPEONFORK which are Linux-specific.

Thanks,

Mathieu


> 
> Thanks!
> 
> Mathieu
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
