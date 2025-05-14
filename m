Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D267AC3ABD8
	for <lttng-dev@archiver.kernel.org>; Wed, 14 May 2025 19:54:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZyPDT4S58z11Bw
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1747252442;
	b=lu+2307FyjGLdHQQa02EQBzKV/UQfmAF050X8fLtnLnTvhPUqurJKSsyIhcfFd403dtY
	 4V3oPZSpHA8vSWFSwX8Rsf1ybX7YLBOZWB7W53y3oovEau7Mza9n8SfnQqZwqtGVmtgHk
	 saBE8QzpjdwIufJzNtL06SBgtradJvCOTTVeR1of18vefbAY1i5K4toqgxJOXOGF68MhG
	 aNfRKhygQ5Se5HcKb7Tpm53Hiboafa92OkgT7NNkt2yljfgbCmmz03SAlDIVb0iIwZEL3
	 3S2+Oo1hcIxh1HFl554Q7/uJ99geJlV6eV7V08xiDsPQP2n0lhgwmYQoPQ2JMO0sSoA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1747252442;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=QlNuEhH4F/X+aV7e9RZAeYjqz8x7JpKIhWa/vtPrQXA=;
	b=pmL666YXE6WbbT2JQjGwwsfiUKh7bXHpymLJeecdXXyQYLKCIwbua+XOGl6oOA1RkGbJ
	 0v+ZmjKpwJv2hzOAHdM4giSs2RdtzkmspL85rwQopITrKvoMxY1DdEAk86sE8BOPo9DSj
	 qex0D2Q0Mc1oaGfaj0lnRd47pBCkG63jQDOGPPeWIuGqBdrRaOWHgKaYYnAxP23mk/EVe
	 Cw0PxQq4htjou87tSIvDYFqncf3ORrlXuhD6E3+U5M+OZcmkM0qBjQo6IooHWJktxiPUe
	 b5zObbGKUajAlux8dyEHvz9LkeQz3JRpk/9/f5srtgnFfF2eCdFTtfv1MXWM/dj3vRw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZyPDT4S58z11Bw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1747252442;
	bh=QlNuEhH4F/X+aV7e9RZAeYjqz8x7JpKIhWa/vtPrQXA=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=b+4BnzKT+rmwTVdd5pyeYD3Ah1GgiGbcAYa1/DjqFVCxMN28K79gtSaIXNPjrPhcz
	 DmVnFOFf2vSnwlzvHB3tc/d7eYD00XmkH2D5pkmPkSHNtELIQ98KUruMHkvAlmbbLR
	 uHIjC6xajwoarB77wMzovtQ3a2hPrl2teBEJhi3fIfZCkjf+Yl6GmuKU8yhwT8qjDH
	 8AgltgpLlnutZifr84LpWWRcj7VQQxD6sC/tSeC3ZQFNC4DRMS6rpejOa8TZNMDe9i
	 quBJy2m4yxjEoun12Y9pPNY/KOpG5FrFMjhocpOE97IDuP6eZBTUcGD2mfzc7EGJTv
	 C1fVqWh0tcjJA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZyPDT4S58z11Bw;
	Wed, 14 May 2025 15:54:01 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZyPDS5TyWz10Pj
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZyPDS5TyWz10Pj
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::3])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZyPDS5TyWz10Pj
 for <lttng-dev@lists.lttng.org>; Wed, 14 May 2025 15:54:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RS2iPoWZlREq9SA5FZ4idrxZGmkEH3aJnmJEUaowbF3TmI1fc8NwLxvpAVw4TZCpt+v3uj4wT3epAhyDgTKaVSEKCDtENCb8jDvzV6ZDVEscvQv3fOuH2m3xkef/8LYnNQcjxP+33zM+qfC5mzlTfvkchcr6jCnwrWeAOKezZTYQGyUZFfGRn4pEJd4t40muJPmUAyLbYqAKYZzxXMSnssLeuhmMshQMf14zMCWAmIDk6sZc5A4hzBW8mI+VVSYEPQ2dORNFYPPz1IS0Gx3UR2KLOSfohVBdNkTYK58CzkNXT+3P7k8x87VOxCsGHtA+A/pwVvxUYZwCiQXpPSuoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QDJnMAJKPADZ9DGRqG4FnB0RmD6nD3t914DrzJhjCA=;
 b=cGpl4TSeG40oG5ma0NoPaNhHbu0l8cgchPXFBiEB5OsXWAnv0JBdZOZdgq1mKoAdE0MxJ+M41B2P05sDxbmEcnn0wESLs1x479EZPmBnq3NCp/pUt42iDLsJ7m1De9hsbjRcvDV0w/XfSeVOwue0qTpSOhlepn9EfmJrTCwPebcPsvD/3gU339nvm2u0mSAL7LxV4eFGUoAudXFNkrLdYeU8BgaXWHSLblEp502cLcmYpEeSHuWDR75n8QEv3nbocFhu88l6cw6PyU/M2fYvAJdgAah8aL81qTFUv6Awsn2K+XqyiXEB7xkqYWXZSqZ6pSmKBKHiuABxC2nG6GsSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 19:53:56 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8722.031; Wed, 14 May 2025
 19:53:56 +0000
Message-ID: <cd6c769f-8d56-475a-b12a-f47426348b95@efficios.com>
Date: Wed, 14 May 2025 15:53:55 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-modules 2.14.0-rc2 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0338.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::6) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: 330e43e5-faa0-480f-d6f0-08dd93210f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzBJZW96dEt5WkF0N3pIUGE4Mk1CZlpxcm1DZFU2NmZpcWdOdWZhN1N6ZHlP?=
 =?utf-8?B?R1dtcVJYRVhPZzQ5T2J6RU5TYjR2K3Roa0lHK09UUnZGZUYwQXZNUWFiUHFp?=
 =?utf-8?B?Zm5mWncrNGxtbE0wQkdPQ2lncVlPMWJSaCtNSHJNUVU1cHJST3UrVEpmc010?=
 =?utf-8?B?Q2hVVkcxVGJQOXlmTldxUHE3WmdEdndQMklwMHM5Z3lwYmRpT2V5M3BOMkFq?=
 =?utf-8?B?OWtJTGhLZ21QbklGcUFEOG9xQjZYd01qdnpKRmJmVkRSTVNVRXFWdHc2b3cr?=
 =?utf-8?B?OTcxSHNrZTQ0cE9nTHEyQzNRZVo3aGtTTGxNN1NWK00vYlduYSt1UXhhb05T?=
 =?utf-8?B?MjZrVlZCdTF5cDhhMG5wbXVvcERQNEErR3VOVkQwS2laVExnditIRVAwWU1H?=
 =?utf-8?B?U0hGVFdKSitYdWlFZXlaSXdJNzkwMUNEY084blN5bTljdVovTHY1QTNmWG5J?=
 =?utf-8?B?SCttMWVrOTBBa0NtdXpVQ0l4b0VoUWxUYXNqQVV2cjZKRzdQWTYrY3djeUFJ?=
 =?utf-8?B?ZUVxK0cxdU5VQUk5Q2c0VzFwMVBoN25SMDgvazZJeEtlR1Y3R0JlVGJZZy9h?=
 =?utf-8?B?czN1SlQ1T2htN01oT2RHMFg4dGlvQzdkN24ramhLQ2RpUmJ5QzZLT3hZMTJm?=
 =?utf-8?B?eFhBa1hQT3VkelVoeTErWkxMQll2NU1Wa1UrelNyNWVLc3dRaWYrWjdQdkNY?=
 =?utf-8?B?RWlMU2plK1BveUVUTU16QWVhWFNDVndseWd3M0RBVGJXaUltZ0VxakRBcU45?=
 =?utf-8?B?RE1NcEF4cE96UUttMFdYM2hjUndPSGwrNlhjakxmUkQ4VzNZUHZta2ZYb2Rn?=
 =?utf-8?B?TzBoS1RRcXZGU21xTkhrRnFIMHg1bVBjczViWDlRQmhpMWg3TTRreHhscDJO?=
 =?utf-8?B?d2Zyd0llQVpxU0MzNUEyWC95OXpHUHBqYWZBR1ZRR0Y2ZlBDcWVrdm5vb2Fn?=
 =?utf-8?B?MlpXVTdOTmJDaVR6Y2N5WDA3THdIMkE1U2EvbWJLUXowTnhBb0FYNkk1VElu?=
 =?utf-8?B?T0Q0d1pkL1BkbzlSR1I3cmZaVEw0bHhnbzlUMExZZTkvY2FGZFJocURidlpU?=
 =?utf-8?B?Rm5KU0dDdTNCV1ZOR3FyckIxeTRKNW1nTFdvUlRKeUY3S1dWdmhIbDhyUXYy?=
 =?utf-8?B?blhhMzcvcjBiK3VuNksyZS95clFxV3RQWVRuaW9GeE83TFYxRENTQnd2VDlE?=
 =?utf-8?B?QW9LN00wRGhJU2dEb3lZUW1MZU4xbDczZTY1SG80L2d4Q3NXQVhjeFV5R0Rs?=
 =?utf-8?B?RzNxaUU0NndYdTJQdVM5Z0NaSkVZbENodGVNUTRLT2Z6aG5rMEQ4amF0MThB?=
 =?utf-8?B?aHFVYUFiYStScndSS2J3VWF1Mmc3OGpVR2M3TUhSNStCd01DNkFweitDdk5N?=
 =?utf-8?B?MDFxTmJVRUJxNHIvOVUzbHdtZ2VicTYzTGxXNzhDTmxoWDRIcG9tWXlzTDFl?=
 =?utf-8?B?c0dETWRyWFlybnF5RHFweVk4ZlZaK2tQOXB2azFJV0Mvcjlrd0dVV1lET1VT?=
 =?utf-8?B?U1NTY1E0V0lYNFZhZkhCWEF0d1JTVWQ3TS94MU1ndkgrdmhIdTRsYmlxSW9K?=
 =?utf-8?B?cmJFeFUyYWtLdHoyaWlwRHN2dStTcmx0NDVXMmFOa2h3bGFpdk1jQXQxYzJh?=
 =?utf-8?B?ajBzeE9lWFBqSVBiUnZHN1lReWtIU043Q0h5bE9zQ3Q4MU9rUFBtd2xrN2ZE?=
 =?utf-8?B?YzN4UXU2cnhVSnFaVmJsTmNxT1c4RVJYNVZDc2p1MXo0Z3BQdDliMmhwQTRw?=
 =?utf-8?B?NWUyZklKUGhKMzFpYVpMSDg1eWNwOVU5S3dINzdUSzZiTWsyU1ZZYVV1MW1s?=
 =?utf-8?Q?ioYu80wPu/lPYr8wYjBErrzC+eFDIgSMXnp/w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjU2TnJJOU5lVGZGYmgxbjhMQzRaZ0RuSjVEekRqalF5RUI3ek9vODNPNW5H?=
 =?utf-8?B?anhFVDROTEhHQm02TlpBcFd2Q0gvMnJ4aHUwY0ZZV2pMMm9HWm9ETSs5ZEQ3?=
 =?utf-8?B?bnU3OWRIUVJUQWNuWkJxemMyUEEydndTdTczUERUSERReGY2SVlmR0pmclFB?=
 =?utf-8?B?dVg1V1lncFBTZ05vVUZmVWdwc2dReDlPQlIwZDJDRkUyTDJ2ek9aTTJRRkQ3?=
 =?utf-8?B?VU1FR2hPbU5GMHVwYzkzY1F3SVFjTE4ya3o0YUhCVDRheUlGWHo4RVlka1hQ?=
 =?utf-8?B?YTl2dVNULzF0Vk5ZMmFIRFU5bTVTQ1V5NisvV2NPRVNmTmR2SGxLTjRCYnlZ?=
 =?utf-8?B?NEFXdWttMUVDazJjb3RqeEZHR3h6L0c1MjlpbkdGc3J2enkvSjJPVndpQUZD?=
 =?utf-8?B?NTdMQ29zRzB5eUZsNWdzYUF1eUl5a0JYNGxmL1RqdG9ESVhCZFpsb0RwQk52?=
 =?utf-8?B?UHdYVmlKeEZJVG94eDVIVHRzbGc0MFNDZTlBZEt1L2MwdE5wVjhweTZkeUx1?=
 =?utf-8?B?bUFuL0RmRUJlU2IvZHV6dnVJYzBSbFhzQmk5V21ZZlJZL2ZpV0VBanJ3S29L?=
 =?utf-8?B?QmdhWmxIN01SMUZGcGp4VkE2WjhsUkE2RlkrNzNCVzIvMDdDZlAxS0V4VnpM?=
 =?utf-8?B?WkIyMzJuNnFPYVZhQVJtb2xaV0NKWnpaejcwK1JKTDVRSWpRczUxZmFmSlh6?=
 =?utf-8?B?ZnpwTFlSdmhqcUdUdFhKSnAwR3RtMzJad1hhQU9SbXhGZXlDNnpzaVJqYzA0?=
 =?utf-8?B?N2Q0NVlGbmxCd0hJTnA0THVETGJ1b1FsKzQ1TkRSZ0QxTzVZeXBqRXFnQllZ?=
 =?utf-8?B?cjJNSU5YWjc4RHZ1ZEIwSE1VdXVURGhoUEp0L3Nha3ZHcUduRGlMNEprbDNm?=
 =?utf-8?B?ZVlocndydE5MT2RMNlJLZXZucXIvRlkzcWt1OXBjMGhOOG1nWVk1SWxndXha?=
 =?utf-8?B?OVRRY0p3MEx1KzVZaTUxOElIeUZjSE1vSTMzdzRxWWMwNlhwcVdHZE5hNkt6?=
 =?utf-8?B?dUd3ZmU4WTMvNEFQaGhIdDdzcDhoMkZHcnYydTArQmc4bmk2aWtPZG1iSWlx?=
 =?utf-8?B?cERpa0I4YnpuU2tBU3VyQkh2OXI0VnNSSEd3b29DaC9FOTJ6M2FxcFJhYllP?=
 =?utf-8?B?NngwSjdqRE5qc1hPZzZtdHZ3ZDF4c3dqeGNTR3NDbFlsMW1EUS9WOE5QMzZo?=
 =?utf-8?B?QVdOVGpCWS9sYkVsbFFXenNmR29UNU16aTdLRWw5WW8vYlFJeWxud00wL3g2?=
 =?utf-8?B?NG9WbG03cXhORW84NGhwdm04dHZZSVZEVGtKMW9GYVFQWTEzZVNSamJuSEJo?=
 =?utf-8?B?dzA5NlBKNHJVVm5yNUN5YkZtbnY1V0RVSE16VUdlUmVnaTg1c2ZEZWJVbUlG?=
 =?utf-8?B?YlZ5VWxmT2cwMDgrV0FZQ283M2JsdzVsTWg3d1llaHpiQnJlUEt4OTFFc0xw?=
 =?utf-8?B?S2EwQ3MzbXhwYjUrcnhaOWNYMmhINmRqbS9XQVh4WitqZ2NWUFYwZmZjb2Rr?=
 =?utf-8?B?K24xZmxRckpvWU5GelArTmR5R0NSdE1ZN29KSFVpU1RPalZIZjlrTjFpai96?=
 =?utf-8?B?V1l4OGR2bnlVMWdVdEF5bTlrVFdDaG9oREt3K1hnZldhcHJlTDExN2hzOVRP?=
 =?utf-8?B?VW8ra1BvTjFQMG83Y0MzeU5Rb2IvY0pQdUNEdTN2UmlUTHN3dXI2VWo1MDRp?=
 =?utf-8?B?ZXZmRTRjbjQ0UnIvakdjU3ErQVNlVUxUOEMxRlo5cXo3d0FtUFpTYTlMTEc3?=
 =?utf-8?B?WGwrdzJpZDNXaFJ3MlFNUnFRbWl0N3RFUVZWanVnbEd0RW1EZ1A1UjdydEkx?=
 =?utf-8?B?aDdqR0pkMlhNZm51TGRtbXlUem02MkJiMlhvVlZ2R1NnR1NPamtJNnF5RWRs?=
 =?utf-8?B?dUg0b0UyekdUNngrcTRzbUpiQm5CYkFUWWpNOWtlZnkwKy94ZlNYQTJBZGQ0?=
 =?utf-8?B?RzV6b3QydFFQVGtsVzZXSEdvTmkyRElaN1QvS3pCM05TYXlYZk5XYUhIN1Nu?=
 =?utf-8?B?Z1k4dU9NRHFuVW0rOURKNWVnc2R5K0h5UEpvRDNiUk9ibCttdnY5a3pPczlI?=
 =?utf-8?B?TEkwYWROUEFuWXdseGU0VHpjV1ZaR25PL3BPaUZTRG5JbmM1T2RjUHExNEZX?=
 =?utf-8?B?Mm1CZ2l1U2JHa3hacEFFZW9iTm9HbFhBVEQwcisyZVBtcS9rdHZHT0NONE9I?=
 =?utf-8?Q?73xh8zYeWBNvKYJCxPOSIyQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330e43e5-faa0-480f-d6f0-08dd93210f79
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 19:53:56.1267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o53OVx11Onq/8QjKJyYRhy1t/xQ9led83e9kznvEtOagQTDZai14ZzYjlLqBiHDScBM9tEyQHT5rx5pPu+gRQWCX9q9o9ETqPSkPQ/G1w9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9171
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

Hi,

This is a stable release announcement for the LTTng kernel tracer,
an out-of-tree kernel tracer for the Linux kernel.

The LTTng project provides low-overhead, correlated userspace and
kernel tracing on Linux. Its use of the Common Trace Format and a
flexible control interface allows it to fulfill various workloads.

* New in this release

This 2.14.0-rc2 release is a bug fix release in preparation for the
final 2.14 release. The most notable changes are a fix to the
new ring_buffer_flush_or_populate_packet which did not affect x86-64,
but does affect other architecture, causing a snapshot test to fail.

A "nonseekable_open" is introduced to fix python use of the /proc/lttng
file, which affects lttng-modules built against Linux kernels older than
v6.0.

There is an uninitialized variable fix for the experimental CTF2 support,
which only triggers when building against kernels that do not have
CONFIG_INIT_STACK_ALL_ZERO=y, which appears in kernel v5.9.

* Detailed change log:

2025-05-14 LTTng modules 2.14.0-rc2
         * Fix channel_backend lookup during `ring_buffer_flush_or_populate_packet`
         * Fix: Use `nonseekable_open` for proc files
         * Fix: metadata-ctf2: enum mappings are not serialized

Feedback is welcome!

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

