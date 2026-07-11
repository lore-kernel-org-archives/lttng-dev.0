Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261D9C43458
	for <lttng-dev@archiver.kernel.org>; Sat, 11 Jul 2026 13:52:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gy9B90Zclz1K58
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1783777955;
	b=e+EPpb0CweUx2FRx/At7G+NF22gobkPCddWCTJR5Nx8v8Mn37dRedxrlaDvYFf2RkJDQ
	 UiKf5fOOIuwc3tIrWuhUOn6U6+jWbnzB3Gg94nTZJj8BwavNGrKoKpFSAimbcfNmXe5yC
	 q9eP78y6D7hy3dSnSrECC2DE3Rr2YdljiRqRkTNJ0BWgPL+TWKET/ho0vhBrJBGM5A8pQ
	 pcj+xfBBBpOfQiaLsA7EAbotoz4W5TlevqaUJy1c22DHc3bR8C0tKaDiV+hi/10AsIS5u
	 M02PUCWISJEWB0w9OaBrFvOyyu22tiNVg+YHffWuh4o1uqABbZhQJJ1r5AlgbiTTsYg==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1783777955;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=YeU75O2KYCc0D3DzuNiAzx/LEEHUDzNKc7BeqEBMVlA=;
	b=UxMzuGwYjhXdlAp8TCACntf2uGUqZqMLm07/gu5Ueel7K9EfEWaEnDSdnPhPXtCoBkpG
	 VskXvkdSpqhqUAX7g+/9qGQHenewWZz1QqwhqrmCjon5QauxvTXeKYs+cvJIja5y2Tnx3
	 CiUoxOy+fR8CkPpFi66l8njX9L2pYMJVxOOjJw0S8TQX07UvYXwtAnEfbS7uHSgf/RC5Q
	 esCuDAcVPV5syeSBDWUwaEOva9dAYra0SgNdl4McPqUhI9OqiCdQv+UScZt3RuAUj804z
	 u+MVw4fEcvpx75MyK5QI248AaeRTneFt3zdUYUb3sxRDEY5D7Q266ST6aU+PT1BId1Q==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gy9B90Zclz1K58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1783777955;
	bh=6NXmFWzangCs/B20xx0y7//XnhgZcdwhm3cfUFvCOr8=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KK7/f4iY8o1XHmY+kTAkoz6YM0kDdscvJphEz5glLq2aL5khxlb1YOBZkjGOlY0QJ
	 Bxc+Yi1OQY1yDKEhKuZFXreF0UC9PSMMz7XpnnvxTGYOqcIeOTnoiFYPFGbl1Ff+ZI
	 Ywhfgoohy8M/QeXlVQuhL5TZ6Bv+jD3BbNK0fBF5n8Hlapv9LppGAKvGK7tSqGl9lo
	 YOoUu5JX8zogZsS8+ruW8zbZI/qp5birBrjZuX82O8W8EDnzMmy4UUHRq/EZc7KPBE
	 33vwb4at3HWqvMk5cSZb+rsGN3PEpszk5bENn+9By+p4knMPy6iCW+dr5LOSjOBlnK
	 tAPYcBQVJOZYA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gy9B90Zclz1K58;
	Sat, 11 Jul 2026 09:52:32 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gy9B72rNSz1Jn3
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gy9B72rNSz1Jn3
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c104::])
 by lists.lttng.org (Postfix) with ESMTPS id 4gy9B72rNSz1Jn3
 for <lttng-dev@lists.lttng.org>; Sat, 11 Jul 2026 09:52:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSzz0OdSr9zfGIkaR4h57iorFRed7wB+WlP4eEXfhmkeelIYDh2iIeVVl6eH8yaCEyh5mZzsc20JLptKQvj7JPkh9nPi9pKrA0788OaU8LceSeDpdRZ2pZG4BXfXP0KBlBONX9yAAiO5PMU3XnclPXCJyQ/wWgk8W+2/uK+6rmieDnGpul3NnJCyBOsaSGRO+YwaLiRBauY6EtWYC37sgQDFZJBgIAshGHA5LuabTxISKOkxoGUFNTYTLuSw2ZWHppoP9RGTOXAfd5IHWwwhk7F/Hfna+gbmdzMvDfOMDmN6wWZ+NLo9YRe7LcAhie2LQyDITja43r2BVNxnQl5xHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NXmFWzangCs/B20xx0y7//XnhgZcdwhm3cfUFvCOr8=;
 b=SADihm45UQ3Ss0PT8pFGbAffJ+du4ImumjmqCGnbgnb/2JxmM8l3RJl35ghtLh5zwCeQYLBWXGlk5aRMK1nD4syDX94cTJtetgRfQKDe4g7V05ebpodtX+lPnOIxpKo966gmQGzUJ83NCm18SssD3DRfWVQf0wo8NuA+h24ASD7Niokc2P1TuFXxgSiXbviP2m6ohovmtaShOF1e5RXmGq1jKmQlhxeOGlDZfYJTykuH1zykF85FlIaldz8xAchIMaOmGPs6LvRftT3Qa2up8Lw+JJpjNk7SQk47fjr76Ldrza/8/uvNOIkoA8jagz98nWUYcob2E3oZOQGd2oGTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PPFC9D71B7A9.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::486) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Sat, 11 Jul
 2026 13:52:23 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%4]) with mapi id 15.21.0181.019; Sat, 11 Jul 2026
 13:52:21 +0000
Message-ID: <d906e7fb-3e24-4b00-aaa9-0d51529e888c@efficios.com>
Date: Sat, 11 Jul 2026 09:52:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: CPU affinity behavior of liburcu call-rcu per-cpu worker threads
To: paulmck@kernel.org, Olivier Dion <odion@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
References: <e8fa9744-74d2-4fae-8684-f1df59aec1c0@efficios.com>
 <0600b601-3edf-4897-b319-b4763943809c@efficios.com>
 <3573944e-3abc-48d7-aedf-3362ebd7ebe4@paulmck-laptop>
 <38f1f93e-3bfa-425a-96d9-3035c8ecc785@efficios.com>
 <1aaa979b-bad9-47a5-879b-b4fb2379ad20@paulmck-laptop>
 <a25cc916-2bb3-4133-afcb-230dd577726d@efficios.com>
 <02709be9-d7d8-47cc-8032-ed2e3a714fb0@paulmck-laptop>
 <14541751-5104-483b-b60c-415d791b4bf4@efficios.com>
 <95f2d189-ebe2-47f1-91db-c964f2cda8a7@paulmck-laptop>
 <b37eebf7-1500-4b41-bb65-074473b35cd9@efficios.com>
 <8d48389d-5cf8-46b1-a6da-7738e11e3737@paulmck-laptop>
Content-Language: en-US
In-Reply-To: <8d48389d-5cf8-46b1-a6da-7738e11e3737@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0028.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PPFC9D71B7A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e75588b-7e9b-4d91-21e9-08dedf53a13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|23010399003|376014|1800799024|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: y/srurUSnpOjGm8jh4q8CCkV48dd6nzb6+mnzEN/SawqAMOATM+GFV3rcQROXEiN7tMz/equc57z2Zmy6mvaN9WkaNIbJ1XoziNSKDnqsScx1FASSGVbvh2P581YsLoQE5Q4itAJg5IoJ8YLqvhtaLMj3vJmOsLlw9wnQWZF1yn0tDB7tBOVw/roXHCBqiWvO3k21cFqgU+PsKGE8cQ/5K1NfvvcUAOfMObpSZnTmQZIfkOQXWOkSCAToTUIKqvRptWYJAe4c9+aDiOatM2ljysezj8NcHR/4J0g7SmKNoBFEdiTn/BF/NuOl6lxhBMdnGLLe8+5kfPTmuUgMllQAF7YtrhPKbtxAwJmo1mE519lBhzVsXJ/O0x0nI0Q3vuzYkOjVEctXgoGwHJ1hEjxk56xaSVKRWVQl32ksEsNoeFMofjwFNH3QRSkADpe0vE11JHHZvcWjXlvSkkg5qtn+kqPyUqs4NxW2J/hpyaWsLAvgJ4KcPE6bGxer4ak/iD5qFQjBP8WPA0sKK7/7Iygh+t4vFBPRbIFmD8grlcawEpL5IGUPHExyz0ccb8wwS6Wggy3OPkNJiIOUDT4q+ghdQ060YL4NKOc132UbQbHJGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFoOEhrcE9rT0EzNURVeVAyTmxDbG5uMzBGajFUYmx4Q05SVTk5dENjSFkr?=
 =?utf-8?B?UU5rcklDZWFRbW9MQytWTVIzYVNocHZ6VWVrUEQ4LzFNb3JoNnlKZzk4RXZI?=
 =?utf-8?B?YnlJR0YwV2RtTWNtWHpmU0puWVd3VXhwVkNERFE2cFJVTEhWb1RrTTE5aUFU?=
 =?utf-8?B?NlJYblJXR3pOd3hOb3lPbjJhMDhqYXF3VFJPZEt2cFRhYWdLcHVqR3ZhaUxr?=
 =?utf-8?B?QXVVK09VOHl1NG56b0ZLWTRDR0Iva2VQMmlrcDR6Rm1KbEpnaDRHRy8rS3Rn?=
 =?utf-8?B?a3JaWnRpUWJ2dCtkRW13RnNsZ1RrOUNQekZTMHdsTE1NeE1hVnBzTW51YzRR?=
 =?utf-8?B?VExFbW5nVGo5S0lXay8rTFVnL01aL1R6dFEyRUNvN0ZJUm1FRW9HbFBkVUEz?=
 =?utf-8?B?My9xVnBQbk0xeXJrZ3NsNG5WUTloRlhZWmdzZ1grK1NORS9BYkVEd2twc29v?=
 =?utf-8?B?VEdBcUI3WFh6YmNUQmlEWlVzdjRObVhDQ3dKZnRKWUhLS25tUExEK0FrMm0v?=
 =?utf-8?B?TUhzOFl5NDhBSlI0MDJhZlpyYmtTTTcrc2hHcDA3YUVheUdKTGp2TzdscHpZ?=
 =?utf-8?B?a3pTU2FpSEdtT0ZhOGxuaVY5QWh4bi9yWlErOXd4eTlvQWV0aDBiS3NwT1B0?=
 =?utf-8?B?YUdCVzhTOXZ5Zng5dStld3M3M1NkbjlmVFI4UmJJWFUybFZXVTRaVGFuNDVn?=
 =?utf-8?B?WFRONldpL2FxSHlzWTZIYUZ4dVZQelB5a2lYZ0gybkp5K3NVczdwenk2djV1?=
 =?utf-8?B?ZVpXQTBXMXlDQmVXQzg0VHRBOTgveGxwR0Q3TkJlRTZ0SnR3QkVTODdpVVJk?=
 =?utf-8?B?aWRBclFGVjdNeHJsb2E2N2Q4VGt2RTlzcEUxaXFsSnI1RXpOSUhXYnZBNlZB?=
 =?utf-8?B?eUJLNkJ0SWNzb2p4Q0NUWjRldVZnak93YVR3cXVQdEtDS1RFQnJNZlA0cmtw?=
 =?utf-8?B?cjJNeDBhSkV6Q1JNbVdIL2JFT3dRVThHaForZFo3SG5GRjVGR01WdHBKTFBx?=
 =?utf-8?B?bkxucDl5TENnMUFYVFRUbjViZWVaNnlUUG9xZHFCUnNHQ0dTR0p4RWtKZGNN?=
 =?utf-8?B?WGFBejRyK2k5M1lLT0VOdW1wRGlzcFp3b0cyM3kyb3MwSng2SzMrQ1NDUk1j?=
 =?utf-8?B?cGhsS0NCYmZCWUpjWEVTc04wdWR2QUI0RnpseExQNVVpQTNnSmROemdhUFMy?=
 =?utf-8?B?c2dPejRsZTNLMU42MWE0dG85NkR0UmN2cVBMTnZmc1FYdkVmazJPZFp6ZlB6?=
 =?utf-8?B?cG5wTFQ3UGVKVmYyNlRPVjQvQkVLQ0FsaTFWaG9MZlN6d3F0UmhkM1QrOWJa?=
 =?utf-8?B?dENRY1hSWFo3QUlYY1g1UENhTzZxblRXUlF2dWl3MkQwdXhiN09sZGFkOXY2?=
 =?utf-8?B?RzdnZDJ3Wm9hMkFHVDhPaTQ3bXpST0RYYzNIanlMNFFmM3dWKzI0OUZ3U05a?=
 =?utf-8?B?NUVVNXJBS0RYQzk4N3hoekVqbTVGRlV0TVgwTWh5OVVhU3B1S1JrdXp1dlln?=
 =?utf-8?B?QjFTZzYzZ1dTd3dZbzVrWXpta0xTNEtLSWY1NjVkeFJveERZcHZHdmVLeWVF?=
 =?utf-8?B?ZXZoVHVwZDB3Q3VXRTg0QmI4VW9POHZYVHBDOFZ4N2NOZTRKRmtaQmFhWmdq?=
 =?utf-8?B?M0x5UVpGRk5jN0VDZlp2K1FKSGFrclRLV1dvVndRMGJzOUk4TXVMTCtEY0pp?=
 =?utf-8?B?SXlhaC9WR0UwTDY0N1ZBYzB4ZFo2eWNTaFJmT0FZbjBuUGJhTmdXbS9XRjlU?=
 =?utf-8?B?V2ZvV2VxMXROMzdVSElYakZqR3dENk5kOTdYWVBET2RNbDYwUVhwV0VjV0Z4?=
 =?utf-8?B?MmxaZStkY24wYmV3Yk1zcUQzYnRIS1YwWnR6WmdBK0M3cEtkUDFadlJlSnUw?=
 =?utf-8?B?czBha2NUTE5hQms3ek1PZ2g1N3oxbUdIK2tMbmJtcmE1d0poSXNCR2luUGlj?=
 =?utf-8?B?dk1Qb2JYZnFHWjNCYWFRejg1djRrczRqczk0Yi96SG9jL1hLQ1ViREFjSUNq?=
 =?utf-8?B?UXlZN21yemFTOVkzZlEyUEhNSlVzbGlSWkVUT2syb3VaaWJnaWZuN2tLemRG?=
 =?utf-8?B?S3JJYWxjV2dzajVuUU5MUExtR1k4N215cTU0eWFubjFxdEViUi9xdEhLU0hY?=
 =?utf-8?B?enFxd2FHVGxBQS9IZkJPZWl4NmNCRXZrejNTMHoxNmNiUnQ2dTU5dHlscUdH?=
 =?utf-8?B?Tk91QlAwRnd4dUlXR0RzalJUNVp5VkwxekQvM21uOExhV2NIL1FIcERoa2dm?=
 =?utf-8?B?bDZ1MzZycHpBeDBaMFFZNnhLZEhNWFJ2VWNKVGo1dm9oWnBYWGIzdmh3bVlR?=
 =?utf-8?B?Tk5SbWNTN0FOOGplVGJvV3N2RkdldHZGeCtPcnJYbVVlVUN6VU4xN0daYUh3?=
 =?utf-8?Q?fVj685IyDccPXLuKLsxEyxNvWE1ILAVp+gcZK/P+ml1MU?=
X-MS-Exchange-AntiSpam-MessageData-1: IygcwOl231ZMROUuvhGSAwMOX7ieM6gvUtk=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e75588b-7e9b-4d91-21e9-08dedf53a13e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 13:52:21.5158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCXJ+uIotKVRqbgcvOR0mZrou65gW5pkMqjp2F6V3+tA3ctjCbgT+VFwohYJQQQkAIHUqsp+HRMC+8irTneCnmCqMl5mNwiVN7Dz0d1VG7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPFC9D71B7A9
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

On 2026-07-10 14:57, Paul E. McKenney wrote:
> On Fri, Jul 10, 2026 at 12:17:39AM -0400, Mathieu Desnoyers wrote:

[...]

>> The "simpler" option would be to implement the rseq extension tcmalloc
>> need, so they can finally stop doing their odd games and become
>> compatible with the rest of the world. But the last time I offered to
>> help them on this front I've been told that they would not even have
>> time to try my patches.
>>
>> Oh well.
> 
> I bet that there is a way, but thus far I at least add a load and a branch
> to those fastpaths.  Maybe convince someone to submit the needed patches
> to tcmalloc() and then browbeat the tcmalloc() folks into accepting them?
> You would need someone young, energetic, and obnoxious, which lets me
> off on two of the three.  ;-)

Olivier !

Can I interest you in a rseq system call extension and tcmalloc
contribution ? ;-)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
