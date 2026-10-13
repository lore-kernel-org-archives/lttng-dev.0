Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50134CC6B0E
	for <lttng-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:53:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4j3y4Z0nhpz1d9c
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1791903182;
	b=diNk3qjT81emDID98kgExV+8ZOb8Ih5Nm4LqENubbVjce33977ftakvkZ59MI5ZVtjan
	 7/uQulJvGjgnHdpa3/4Lh3hwxoHwbXuQ5fyaUF7oEI6Hlq2D4d6t2SNBO5v1V7Rx3G6Os
	 syAWo85qZgMKbo5x6EGM26W/YCVnCdb8fpmNmLYrJ2Kzgc4UbDJnKMIqHZliZR5EERQSl
	 KSSs/MGnzGRM/aCGiRdObspFhO6ydAmZeeUv33OzFfGObfQCocyzHAp/Us+Wa889GAGF7
	 KKc9XK0KenlIXh/LTYd836RlDD8497z9jqjIGqa6fiWTjodD3RTcMhNrAp2k88PqcSQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1791903182;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=7YoWtCHfRMMnL5k4HgfXeXaNGVwF6TGno2bhOlo4lHQ=;
	b=V5Om3SNjzDhwRspw+bj6i1+lQW3GrfGcrwkPXH5opuIVSNlw6zm1bUom5HB2C942ywz7
	 HWnvHC2RGUExZ1czhJliZl3LxR9wgRpIXsq222FKr2kdMQSEA12gjvcQ2d5xxHoDYBiKK
	 xKZxjHSIiR7tUdRRGZi0A92ge8PLw+BpILWlLvRx+JtS7jObCNbA9JYp1ba4ptzQ2AuLm
	 neLzlJ8bN0fdLKuGRWV3EO4wTOf/qwf+Fl7WYux8j1BGFX6rC7e4k1eFQ7HQgHnLD0MoW
	 /+7tqjr6YgMWnU+aIuuknkmmHtZ6Bog994F97BXuS6QKhkvjrdeNeoK3MzKqdy61ygQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4j3y4Z0nhpz1d9c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1791903182;
	bh=dahwR+DR1TDgD1bHEU/FivQGFglJukzuCMvRmiy2LI8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=cIM9ODwnMRQ0geQNE0FJcIvE5mmcUyEX9oRmM2HXQJ0Y4kiI2EdBifwCV4Lw31P5S
	 hEoLeH/8QXgzOO4raUjPxV7LpYmA5qLEeSYGQQWxl0WVi+l89R6yCJXe+YiKUOyOLV
	 IuVr4SnKKJ8ICH98CwWDAnmSNrqolItNIQy6QWcwZh3qYB6mMDkBpwMhdevPAFWfiH
	 FaUHbVLH/zvb6mDTrEPY6Mta1uVStAI3MlWgklYuS0ltty1y9zovOkWTcOG1uOC2N5
	 xIHONU8P1OsFv547CJON1ba8+oiWJ1WaISRhtk63yC20TxI5F87RPWBT8p5WJLLAYx
	 iWLga7vEctjOQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4j3y4Z0nhpz1d9c;
	Tue, 13 Oct 2026 10:53:02 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4j3y4X6z1xz1fDT
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4j3y4X6z1xz1fDT
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::])
 by lists.lttng.org (Postfix) with ESMTPS id 4j3y4X6z1xz1fDT
 for <lttng-dev@lists.lttng.org>; Tue, 13 Oct 2026 10:53:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IY83NMnVLQdZ1r2XVrhvF5XYzquM0BvbuEyGn2FA18gFh9MdYewIIniMrbJjnireO25Memz32V0S8LRfGM0GRYDCF2QZGT7fEx5OwwOQcJ+IpjA9q+yW0Wq7UrLzTf0EvuJPlSSyy2WT2z4KnBrBxIB+/yWudlVGs5JzhZ2kDsPPpnwCkVP4wgh+29k+d2q6K0aQgrWCjCdbxUGxlqL0E/VEgmCxoYlHOrr009g3f2Iuyc9Qg5ysNoq7kWU8TvDv0coFCR9riA/DRkeZ5eCT4kWyZtDy08OT/S0OmrQvO69kGs2VDAQE2Tp5vl10OAGh8RIrYSARjeSUiLpOHG5+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dahwR+DR1TDgD1bHEU/FivQGFglJukzuCMvRmiy2LI8=;
 b=u5p7BtVSZmtT7YAzXA90dDvIA3VjN779ZR2DImXGBALWOzrmF6b4u3JwmZU7fTvLc4wYNsnIDJ6G0KHrRlZDzKBlmUxmx93F7RZygIFIVsPlDArQYnTv9iSEOa+g8cJDlRIwyuOxaBcb+OcypbCKg4n523+siCOVnkPJFhnPTXPwgUMKTABKJOqU6C1yH+h0387co3dKtzmlp6tFEL1CEhFQK6pnOxYZ/YjB2NDHtAVdfM0hLZcbeQiLvToOakcsE1UP23sdHi0csgz0FUeUA2luF416aBbaF4EWv98JrXswxeMlAzNoCub18/3TaXFDU5mMGTFLt28KAOE4n8SGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB503061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1cc::20) by YQ1PR01MB592510.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:b3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 14:52:56 +0000
Received: from YT2PR01MB503061.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7954:520:5680:bfc5]) by YT2PR01MB503061.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7954:520:5680:bfc5%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 14:52:56 +0000
Message-ID: <2689e5cf-7e37-46c6-a65a-6987bf4b8c28@efficios.com>
Date: Tue, 13 Oct 2026 10:52:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix: tests: honour LTTNG_TOOLS_DISABLE_KERNEL_TESTS in
 two Python tests
To: OOHehir <oo.hehir@gmail.com>, lttng-dev@lists.lttng.org
References: <20261013093318.202203-1-40183643+OOHehir@users.noreply.github.com>
Content-Language: en-US
In-Reply-To: <20261013093318.202203-1-40183643+OOHehir@users.noreply.github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::20) To YT2PR01MB503061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1cc::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB503061:EE_|YQ1PR01MB592510:EE_
X-MS-Office365-Filtering-Correlation-Id: 170d0407-41cc-49b4-c5d4-08df2939aa7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|261009223027099003|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: bl8MmQhmO2yGazE8izh/IDxnK+VObXe0sDdJMt+a4XK/DJnan1ZXP3GIcDmtziajoWsNX8pT3wWZLyGSQvtp9hQonDwzMCK3AHmsa9QW7bKJH0z4UpuvK7wPnx1aERpGhTGMzhVWsjfaoP3OSjoLzveFZAbXiMzoS6tEqzf9NtNVE9S5/dmnYNHEJweVAna/E1wRtG5aZuzKcPggyBzFhJdfTFGW1ff4EdkVPxRBebZHxlmpciTMod9h4CAraBuNxB6E11q83k9I36eodask+vI5khFGCr/lr7i06QSj7Xa3a9NH1MdNGJbFBkANNpAOLCyQ9bv2KcHQjFqe8hpdRwlZKgR68ldT+arV0GJePXn1IouG95SQ7pRRSEKJzsqKoQd0ZzlwZ2SY6PzbySo+1lbMu9PH90h8qrle6nAQup0M1Yu1Sf1wnbqaVVA5aIWQJqXcS+JMYUSZf+uDq2yGsqMhKK84GeUdv1OKBh2n3sK+hlXtzq3AwgbtiJoWmtX74O3KhMKlwQg463oEzzO25hxxBukKglAOmJgBfczaz/83bvDY0kWC2Xw1SOpLeLIHsvyCtdx4n+Vv2Vyj57XpcgUlA4WMxjKrVMruedSJoFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB503061.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXNkZUo3MnYxUEFmNktPWThBZlIvOGxmUCtjcHdtcS9VT0M5QnhqVUI1U1dJ?=
 =?utf-8?B?LzRSb2ZPR01yblIrV09Ya0pjOEFaLzVrYzZLV29hWkJKQmxQUUNMUnh2N1J0?=
 =?utf-8?B?Zm0wY2VidWU3eGd3UVBEdmM5OVptWm4wVFhPYU02RjBWeWM3UzhDUFY3aXFk?=
 =?utf-8?B?L0FGakUxQTJPd1lKdFlnbThCQVZtdE84QUlCd0lqQUZXeTFCSXZBRlVJU3o4?=
 =?utf-8?B?QnVjTWlKdFV0Ump4aDNOcDEvcStoQ2tGSzVudjVES0ZkWWtUVlNaNW1NZXlr?=
 =?utf-8?B?aWY1ZDF3bk1td05sblNuK25pREo0Z3d2elRCa3hFcUlWeWdLMTl1OW1OanBY?=
 =?utf-8?B?L2MvZ0tZNWYwajFyTGgzVExwSjRiZTZkRU1LeWE0VHkzOVJJYlJmTmYwdlVs?=
 =?utf-8?B?NFZWSW1pcE9hVkxmM0Eyb3VTV3BqUEh5NHUxcWFZK3JMbFFCUFNBcis4VVRW?=
 =?utf-8?B?VXhIWDZxQTZBb2RtamNvaGFYR0tEYSt3ZWEvWEs5VmxTVkpxelVST3ZzVUZT?=
 =?utf-8?B?WkJ0RW9Ud2lpVldJVFZibXdQRVUrL3FIRVZuWDVTV3RBRUJCNGNHQkFvT1FK?=
 =?utf-8?B?NHZFMWxSRmRCTzladS9RWGUwSU5uTndkLzlTZS81aUwxUWxZajJ2NytTOVdO?=
 =?utf-8?B?TnhmK21lWjhzNHdxQUtuRzVINDZ0bG8rRjl6SEs4VXpEb3BNZFRjNmNNQVdH?=
 =?utf-8?B?VDdQako2eFlsaVdhai8wNlJiREJ1NEgvSnZpL25WNnl2ZVpHazB1M0ZheThs?=
 =?utf-8?B?WUVPTnJxUUhUelcyN0dNeHZybWNiS2o4cDJRVTlJVWVxaU1jSnJDWnNPUmVT?=
 =?utf-8?B?TWNwTWJVK1dzMTQveUxXT1BjVGFvcW1LZWs5MjBFRVFiNVdSQ29UWFNKNmNk?=
 =?utf-8?B?b0x5MStLbXFTbzUvSTBXSCs0S2VDZG1yV2ZKNlBuWkNjalZZSkRIUUlEK2Vm?=
 =?utf-8?B?SWR2MjBKdzdKc0pRS2EwQ3BUQUpjdUVSNGZiUFFHMFkvTFR3Rit6WHdIV29C?=
 =?utf-8?B?Z1RVNGdxTmZwK1JISjF1Mnc5NnF1UkpydFBUWk5GTkZSMWorNXBPUlVYTzBP?=
 =?utf-8?B?Sm43aklKNnQrOHVCVUlaa2w5NEsvbEd6eVVJWGtXNjhXQTh2MHczY3B1YWor?=
 =?utf-8?B?Q1NZSndvbG5PNk16d01ISWtGVDVPSUFlUWZKQXhHUThSTzdMdVd6WlFJT2d6?=
 =?utf-8?B?aHVDT3cvclhNMUc5TXhoOWV3QXMyOW1iWHRvYXRQb01RVEdaY0M0dk5EOFlX?=
 =?utf-8?B?RW5qdkRXenpZU25WdXR0MnRMdWRtUTVBWlhLbk1JNk9IaVpJT1V4M3BLZktT?=
 =?utf-8?B?a2hZZnl6M1UwUTdxeUdiaU9WZnhWbWZaSzNYZ2hobW9VaEM4cHZnUUpjL2U1?=
 =?utf-8?B?d1VjNXZESERWT1VXY2ZlNUMyL1pOOGlVTnV6MytFWnBlWEFwTHpUamlyRVhx?=
 =?utf-8?B?MG1EU1ZBV1NOUXhrYnlmNnYvRVlObFN1NHZQYXFmZFk1UFJ1aWhTZmJheHRz?=
 =?utf-8?B?WG45VG9HVkdxS1Rsbmdxamlkck80V2w5Q3FkNUlSU0NCT1A3bnAxenE1ZU1K?=
 =?utf-8?B?bkppblMvdExRcUVKSnRoNnU0WjVNRHJQNmFsOTFyU00rbDBpNWZqbXRtQkpj?=
 =?utf-8?B?K1ZQeGp0ZFdqUzB5YXZnb24rQXdoaGp2SVFLUjB5YXlhUTJzVWlaQzdmeWU5?=
 =?utf-8?B?SzgwbG1RT1JodUNydmFFaUxLRFBxNDBXbHdGSmRoNm1Dd1c4L0JYWnVJRWJT?=
 =?utf-8?B?ZjBkTXNudElybktKY250Vldrbk9URDNJWVV0RXIxc3JJV0NYLzdMdjdVTVhY?=
 =?utf-8?B?VVcwdy9WK0kwSFNNNzM0WU9vRVFaMkEzS1FhVi9YK0xjbzhVdzdsUmdOUHRM?=
 =?utf-8?B?NXIxYVdhMVRkV0hWbWtWdUlRU2J5ZW5keEszT0lIWGRIU3dkS2ZkdW5Gd2to?=
 =?utf-8?B?WE40eXNUYlRqbTNRQ2tlc2NuTHBLODJuTWswSUUrRStSR25yVkNsbFlZcWJ5?=
 =?utf-8?B?QjdpaEttTG1ScnkxRHJuQUFFSkFPVDF3a0p4N1NialFBNGdYWDUwK1NBSDN0?=
 =?utf-8?B?UGptdEhzRE1neVFxMG8yaE9YTHhqTkFqaEcwcisyYXV1Uys5RnRDTkVkZlo5?=
 =?utf-8?B?andrMFNCWE1JcUdIYmliTTJUMnBHSG93TXZPVHQ3NmZpaEFnLzVHalNKWkt3?=
 =?utf-8?B?bHg3eUFLYitrZVdPbmFiZlB3cHpsT29tUkFyNUR2WUhaQlBCQTlIcGpNUXVj?=
 =?utf-8?B?Mld6SE12T3JGZHF5NGFUY3ZSU2J0RVI3ZzZvN2h5SS85dHVmZkdsVmIxWXds?=
 =?utf-8?B?czlTUHEzWlA2OUtUR1JXN0NTZTdkcnJBeWtZVllCb1ppc0tQNHR3QT09?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170d0407-41cc-49b4-c5d4-08df2939aa7d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB503061.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:52:56.1082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFEX3Yy+QDrsCLdWwdE3tTrJg705K/YmYlb+4JP+LvT9ccNqu2PVW9ZCd5ZcU2YYFceRjjwdu+HNEwr1J5y0hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB592510
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

Hi OOHehir,

thanks for the patch! I've uploaded it to our patch management system 
https://review.lttng.org/c/lttng-tools/+/18903

thanks,
kienan

On 10/13/26 5:33 AM, OOHehir via lttng-dev wrote:
> From: OOHehir <oo.hehir@gmail.com>
> 
> OBSERVED ISSUE
> ━━━━━━━━━━━━━━
> On a target without lttng-modules, kernel/test_event_disable.py & the
> kernel cases of tools/save-load/test_save_load.py fail with "Kernel tracer
> not available", although the test run sets LTTNG_TOOLS_DISABLE_KERNEL_TESTS=1.
> Observed with the Yocto Project ptest on riscv64, which ships no lttng-modules.
> 
> CAUSE
> ━━━━━
> Both scripts only check that they run as root before running kernel cases,
> while the other Python tests use lttngtest._Environment.run_kernel_tests(),
> which also honours LTTNG_TOOLS_DISABLE_KERNEL_TESTS.
> 
> SOLUTION
> ━━━━━━━━
> Use run_kernel_tests() in both scripts. It checks for root as before, & also
> honours LTTNG_TOOLS_DISABLE_KERNEL_TESTS.
> 
> Signed-off-by: OOHehir <oo.hehir@gmail.com>
> ---
>   tests/regression/kernel/test_event_disable.py      | 7 ++-----
>   tests/regression/tools/save-load/test_save_load.py | 9 ++++-----
>   2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/regression/kernel/test_event_disable.py b/tests/regression/kernel/test_event_disable.py
> index da9f146..a373544 100755
> --- a/tests/regression/kernel/test_event_disable.py
> +++ b/tests/regression/kernel/test_event_disable.py
> @@ -15,7 +15,6 @@ Validates that disabling events works correctly:
>   - Disabling by name disables all matching rules regardless of filters
>   """
>   
> -import os
>   import pathlib
>   import sys
>   import traceback
> @@ -307,11 +306,9 @@ if __name__ == "__main__":
>           ),
>       ]
>   
> -    is_root = os.getuid() == 0
> -
> -    if not is_root:
> +    if not lttngtest._Environment.run_kernel_tests():
>           tap = lttngtest.TapGenerator(len(kernel_tests))
> -        tap.skip_all_remaining("Kernel tests require root privileges")
> +        tap.skip_all_remaining("Kernel tests not enabled")
>           sys.exit(0)
>   
>       tap = lttngtest.TapGenerator(len(kernel_tests))
> diff --git a/tests/regression/tools/save-load/test_save_load.py b/tests/regression/tools/save-load/test_save_load.py
> index 9dd8042..1983263 100755
> --- a/tests/regression/tools/save-load/test_save_load.py
> +++ b/tests/regression/tools/save-load/test_save_load.py
> @@ -13,7 +13,6 @@ through save/load cycles, including:
>   - Kernel syscalls and tracepoints
>   """
>   
> -import os
>   import pathlib
>   import sys
>   import traceback
> @@ -953,11 +952,11 @@ if __name__ == "__main__":
>           ),
>       ]
>   
> -    is_root = os.getuid() == 0
> +    run_kernel_tests = lttngtest._Environment.run_kernel_tests()
>       allows_destructive = lttngtest._Environment.allows_destructive()
>   
>       total_tests = len(user_tests) + len(agent_tests)
> -    if is_root:
> +    if run_kernel_tests:
>           total_tests += len(kernel_tests)
>           if allows_destructive:
>               total_tests += len(destructive_kernel_tests)
> @@ -971,7 +970,7 @@ if __name__ == "__main__":
>           for test_name, test_func, kwargs in agent_tests:
>               run_test(tap, test_env, test_func, test_name, **kwargs)
>   
> -    if is_root:
> +    if run_kernel_tests:
>           with lttngtest.test_environment(
>               with_sessiond=True, log=tap.diagnostic, enable_kernel_domain=True
>           ) as test_env:
> @@ -986,6 +985,6 @@ if __name__ == "__main__":
>                       "Skipping destructive kernel tests (LTTNG_ENABLE_DESTRUCTIVE_TESTS not set)"
>                   )
>       else:
> -        tap.diagnostic("Skipping kernel tests (not running as root)")
> +        tap.diagnostic("Skipping kernel tests (not enabled)")
>   
>       sys.exit(0 if tap.is_successful else 1)

