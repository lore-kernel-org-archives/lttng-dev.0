Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C98C02181
	for <lttng-dev@archiver.kernel.org>; Fri, 24 Jan 2025 20:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1737752101;
	bh=t9x8nxwgHkuxLcJxPWNFFrpHOhAYNgxK1cEdIxbZQMQ=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=PrnB8ScEJGKAB/Ezvki2PdDLjhSFTgm3+SRo4RgTV7yeq6X61Ows1BvcaCQXoOJ7b
	 0iOqkwWz3TvncX6n6Y55oi8RzrBEQdgScmpAz/PhViNSMGsCWyMb1VBd53pKqSbJkj
	 EYGrgXVh+K3hljWuEHkE/cCMkBqe9P2QFGZ8dn6jCUrFZkNihpkZPkU432OpMj2/LV
	 F931Fun964pTRpZJpkpHlQ9xxdNFq+rtpf61BS87TqVB+8ux3d/cQ0IWgL4jGHIZn3
	 U7A1OFwcxiW3JgxwH0jiQRYn8mctiHsPZ41EOPjmiDFT1q4op6trocRBTxVxhXQdWO
	 BnzOe2aiAjq/A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Yfqnc5nlKz1f0n;
	Fri, 24 Jan 2025 15:55:00 -0500 (EST)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020120.outbound.protection.outlook.com
 [52.101.191.120])
 by lists.lttng.org (Postfix) with ESMTPS id 4YfqnZ5qHjz1djj
 for <lttng-dev@lists.lttng.org>; Fri, 24 Jan 2025 15:54:58 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPHr7+IoaryUgx6A9mdfrOqxHkCey9jH6JGs8W4MTPXr0TOJ4crl9zi+l/jCO05GKPVXj5aDnjCrcFhXpg00/RYzpiazllwEm/vkYS2sa+7qbX25Kg7nUl/Q8nNYPBY3HJNHFtb+BLEwhyj8wPJhOwlHefYEbs7OAVZ+1131JjZOwVsOLsz3ZSTzJeAkepR5jajR+x5EecEGDUbJVOjd4cl2J8+28Swy795B6G4S7x2+yrwZKh19NXmG0Rqyne1ZLrdmfEbHZUmpQagGjtDvryxiKmJJaiohlfGRBEGY6NTPpjTyhLAc/1YwARcZ8meeSH7IAMZGO8ugqyBgClxECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLvuXs9v5uFnc8p46vRopr6WqRceHlPeAvGpxEqzWm4=;
 b=i5JtcnC+7win8kSZNu9LCBK6UKP3/Z8TaqqM13Q3k2JwGZjsYFNeC1Hs7eoqAh1YyR4NXVRpsZeyNhL/Mxktq9GvyUklBqhHwA80f++L7TT5OlcasUAQxyRSe/+TznE6Ev1x/vkWs3H5bv0JMtO8eo2TSsc4gWG/WPvYqXJOnqCqm2d20NdsAgbbW7K0FglDM0L4Oc2ueC/c12/to1coAJxFAAMMfsmkgFYH8aPg4kFCWUCWaPNMbzMtAUAsGc2K4HElOQfWo1rAL9OnL9QfSKvtPj6F0D/mM1cSqFqlXqvXwrd+GMydodu5QXVdVEDRyfWwXSplR5leppdFpRAHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8967.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Fri, 24 Jan
 2025 20:54:57 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%6]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 20:54:57 +0000
Message-ID: <6c4edb5a-5506-4cb4-a251-ed77fcb385ae@efficios.com>
Date: Fri, 24 Jan 2025 15:54:55 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RELEASE] LTTng-modules 2.13.17 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::6) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 6675671c-415e-451a-bbb0-08dd3cb95c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0VPVG5BU01QWnRPTmFQaHdiSjZ4eHcvME5sZ3RVc080VlV1Q2UzenhtMm5T?=
 =?utf-8?B?V0RJOGN5SFRvaTd0THAwNVYvTFJ5MVBNSHF3dnM1T0RxSWQvbzN1RFB3aDJh?=
 =?utf-8?B?djlhQU9kQ1BBYmtQVDlwWk4wZm9wdHBtcjFGcWMzNVhjZXFIdXlUcHIrYUxu?=
 =?utf-8?B?a1pZVXhnSG5hTitsTmd0U0hMQ2FXSWtiRERyYVpVUm1RVkIzemw2M2tpUTlE?=
 =?utf-8?B?NzV3M3h2MnNIaDdFcjdPRWtaY3p6NXlUWnFVTzlpdEhyTDZUZ3NxRGFpRi9h?=
 =?utf-8?B?QVFoejFkci9yMStzZDE2TkVzVWZtdk1yQ3hOdkxvMlBHUis5cHYzM3BUcXNp?=
 =?utf-8?B?V2o4YU1TRDFKaW9RRVh3RkVzUXpmZHNFQ2ZWc1RpaEZnT0IrQkhTMUVWa1dv?=
 =?utf-8?B?bVFwS09UNnc2bHJ2KzRHT1lnQWZBWmhNbnJqK1E3S1BrZFYwVkhCM05CQU1L?=
 =?utf-8?B?NFp2TE1TOThnaFd4b28wamk0Zlc1MzhmYTRFMk9PUEFLU2JPUE8vcEhoZEd2?=
 =?utf-8?B?MEExak9yazBQNjJQMjVpamZRTEFLeTJuVUpCNFZ1MHdiSzZlak1oSEJkUjU3?=
 =?utf-8?B?dUNqY0JuM2hlaTJWdVJSMUlLb2lLa1c5QVpURFFpUG5mMkExM0JTQ3AxczZW?=
 =?utf-8?B?VDFwNS83ZTBsNVNISFRkM1dwZVBZakNEUENjOTZPcUdZdW5hbUc3Y3VDYkdZ?=
 =?utf-8?B?Q1hMc3NQUllPWGwrdzJia0ZOTi9wUUFIZ1FsVDI4SkN4ZjMxcWUzTEN4S0hW?=
 =?utf-8?B?SWFRQk1ZakVsRnVTOU03bzVVL3o4MWhTRXRqRmN0ZU5mZ01sc2NybGMxWHE3?=
 =?utf-8?B?MEdzOThmNEp4SVE0bmN0NExRK2RIQlhMQ3YveE1qWWp5TjhKTjFrS0hqMmpr?=
 =?utf-8?B?My9md04yeTVDMEZiYkhHWldpMEVWVS9Ma0tTcWs0anorSUdreFA5bjRZZGlI?=
 =?utf-8?B?UTFtZTBFYzFzbld0N1M0aUFCaFhjY1Y3Q2hWYjBRWmdOR0cvcUM5L2x4YnRT?=
 =?utf-8?B?ajI5bmd6OStibkdaTkJEaEpuMWJWS3M3UVZKSG1IL2JLbDVlVTJkdTFoTDV3?=
 =?utf-8?B?SnZpaTNNZGF5Q2R5STBUVnovVWQrOGQwVG9NNnNhT2orWWJmVTdPQnJwaVJV?=
 =?utf-8?B?QUFENldSK3FGampaUWx6aC9SQlFoeHliU0xESmMrNmdJbzFoTjRoVlZpdWs5?=
 =?utf-8?B?LzJjaHF3bzN5Qi9UY3JsSitFa0VMZWducDZQTGFvM0RXd09YTmdTMTVranRZ?=
 =?utf-8?B?eFErWk9LWG5BMnZvSmVYeWhLT0ZDVnd3YjRDUjU5QXVaWXZ5cEE0MWd5dWZO?=
 =?utf-8?B?Y2diU20vNmhMWFhwSHp4M3B5akZwaVlKSTZiZXVWQ0NPcCtHalc5bDNpYWk5?=
 =?utf-8?B?R1hZWTdUbExlUW5oYUlNZkI5eWRPMkVFRStjRFlNZXVaaHoyTWxaZnI5OHl6?=
 =?utf-8?B?bVE1WDhCNVRSQVhVdHpXWlNoSzV0VFJDVVc5UDVlMUFBNmRyL0lkUFkrYUtr?=
 =?utf-8?B?WmlZNk9XaGpvc285UGZoKy9kbnFaYWNUZDJFRkVEdHRyWE56c2JnYzA0U1JR?=
 =?utf-8?B?NkM2aXpkalZ1K2plSVRRTm9oR0RTMkkzQTNqbjF0S0YrTlBZcTB2cVBTenZa?=
 =?utf-8?B?SnBvUzFZZkIxNDdISVJpRml6SWsxSG42ZjdQNlBCRFJ1NXZsYzN5VW1NTWg4?=
 =?utf-8?B?WWlzeC9sOVl0K3FYeVpPQ0xSUkV4WXc1NjR3eTh1azdCdjRacXlER29SZXJX?=
 =?utf-8?B?YnZ6Qlh0NythZjk2R0pqcHRycnlpVENxSmp5T2NvVG90VUFwYnd6djYreGRm?=
 =?utf-8?B?WllyT1lvWGVEcHlwaVBYUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2l5REhrSjJIZmpVUHJ4UXltaXBRekFBdnNodDdnbUpYcEZ6cGNnSmRlVHBU?=
 =?utf-8?B?TEhNZFVYT1V5UkxBeFd2MEs4ZS80S0lqR0VOSDlCN2dDNnIva3lKQlovV2tJ?=
 =?utf-8?B?Q1lCT0RwdStxNFdleWZERy9PK0prOW5ZNzBDQzNBb244dHdrVjlxQzhuMVN3?=
 =?utf-8?B?NGdxZWdYODVkeEFJSTN4eG9TVldGRWdlQXVrOXpoWjg4V2lZZWMrM1FoMjJU?=
 =?utf-8?B?YVZjRXY3TEt0MGJaQ0Y3VityekVtZzEyaTlMNGdOaGVOeFNTeFRrZUpyWDZ2?=
 =?utf-8?B?L281ai9NVks5VGRreTFnbVkzaEtoNllubk93bDcvU296dDlKMzVwWVNYZUNu?=
 =?utf-8?B?Y3crUCtjQzUvUEJYaXZSb3U1RzNxemhRN0tWK3dDRkMvV2ZqVEc4NllWdisx?=
 =?utf-8?B?a0tlRHFEVmROS2FUeDE5NFN0SkdZanl4T21CVHhNd1l3SjBhdzhuTFBBNE50?=
 =?utf-8?B?bnd6czA4KysyTWRtTU5vK2hXWXRmUWJkSXdONnA5S0NEQU5QWmFOZmFYdk9P?=
 =?utf-8?B?MlhTcmhyNW1KN1dlZ3BrOVoyL2NjOE96ajUzVEdPd3dkTXZRM2piWW9HU0JB?=
 =?utf-8?B?MXA0SUFoRjFCeHVPdk5WZGlKRk1BRGpIeWVKWkRxMm4rWmxpcU85TUVlK1Jh?=
 =?utf-8?B?TjYySjhoOUNsaWdMRFg3bkpkT3RtVGRSUlFuYjhmLzZZRlZIV0U3ejM0VS94?=
 =?utf-8?B?NGY1QVY1aWpqVGh0dkU2K1VXekl4RHpCTWc0WVhpV3phRXd1dFNyUlYzalNW?=
 =?utf-8?B?Ti90d04yMGlTUXlQWkI0cHIvL3NRRG1Ld0gwekZyNU5CUk1KQ0VaWmV0UWdG?=
 =?utf-8?B?WDBFdW9UTFZTbDR4dHg4bVVRY1RTcGQzV1QvckVBTUp5WVJHOTRSOXBlTVpO?=
 =?utf-8?B?WUZMRkNEalVhaVBQa216T3haL0ZkeitKZlpVMnlDTHlyYTVoZXZ1Titxenky?=
 =?utf-8?B?M1MwVEt2cnJHWE81WUdTaUVuWUcvNGUrZFBYaUxXK3h3NTBWVkdkV3BheHlY?=
 =?utf-8?B?S3dKTHZRdThQakxOUkZPUVFHa3JrNGE4TTVFMmR5MlBNQmxncGxIN29NcDh3?=
 =?utf-8?B?MlBUUTc2ZHYwaUdCQ1Z3K1dlWmJzZ29aRUxuTHk3Tkp6STM4dlFFajVRdkdB?=
 =?utf-8?B?UVVBbU0zQkhQUmNYUnFGaW9VbHViT1h1MGx2M0RTVTBWa1d4bEpkYWpSK3pa?=
 =?utf-8?B?K3lwL0Z6QWkwYnd4bE9xYU0rT1lUZ204bkNEOHlLUk9naS9FT0RwdlVwLy9h?=
 =?utf-8?B?d2xWdkhBcG1GY080Z0thZm5kTVFRcGNLZkVWRVNsZTBWaExadHpUdVdRVnpx?=
 =?utf-8?B?UGJnaGlZcks0UXJHa1MwWndFck4vdGdVcXp2SWE5RDZBVjBJb2huVm16QW56?=
 =?utf-8?B?VTJSM1lGREV6bEhVczU0RTFRaFk5NERkUjZydThFWHdGZE04UHRwNUp4Sm9Q?=
 =?utf-8?B?azRlREk1T2ExWmkzM3Qxa3FJb1JodEpvV2ZhazcrOEw1LzZGcDUrbnZwMURh?=
 =?utf-8?B?MWZsMm9SYkRJNGgzcVpZQzhPVy9HTi9DNWhVYXI5dnlveWZZSzdFNTJEQnZj?=
 =?utf-8?B?MEJGdzhZdkhaMGt6bEk4M0V0S0pVTHBwc3ZFS25NVWprMGZyeDVhZjdhQ3Jx?=
 =?utf-8?B?RVNrTVRVaHZzWjlNN3l4THF2OHVWVXFDdVU3Q3dvMys2b1N2R2x2M1l6MElw?=
 =?utf-8?B?QUo4d0FYci9mV1BaMjAzSUUrSjNWbUw2bkdiQk1pdzY4b29VNEhUZ20wRnNx?=
 =?utf-8?B?ZHRQQTVnc1hVbDNidmMvUStBZXpmS2JHZzUzTFFEZ0RNNFkvUWczYU14ejB6?=
 =?utf-8?B?YUx2Q1FTc250LzdMcjBYcCtYMDNWT0gwc2VPMlhsS2VpZzNObEVJNGQxMzNH?=
 =?utf-8?B?UU9sbE81VmZ1bmxDQkFJMEh5bkZpbldlenczejJOb2hUc1JuSjhYVjZVTzcw?=
 =?utf-8?B?VzhZQnBwa1NuMnNNbjZWR1lJVFBETW1HRkpHSHRTb0trNnhyS1FMMHFhQWpj?=
 =?utf-8?B?end0U0Fta3VFbUtUNnlXNitaT2RaVXRGKy9Bam9PYS9qMExOclBHa0JSZkZI?=
 =?utf-8?B?QU9abEQ5b2JOTUZNZERaRVBYbHZYaG9CY01uOU5yWTV6Mm5xRHVLQlNvRGhU?=
 =?utf-8?B?VFhqT09iOXhDUEV0RnV0T3g3U09Kc2ZlY2NsM3NkYjV4Zk9vbEhIckluSFZr?=
 =?utf-8?Q?NgOrZKjlWAHDBsaRUAnUtu8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6675671c-415e-451a-bbb0-08dd3cb95c16
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 20:54:56.9550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tEy6dt9h8ySDvxrxrFhOC7lAI3dBHhAXB72VOXu4NPowqE8f2UUN3ahgFK+0iSi6WuMH+yvJTQO8SLMwkbU2Eto31LP4uq8brLnwp8Bq1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8967
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
a kernel tracer for the Linux kernel.

The most relevant news about this release is added support for
the Linux kernel v6.13 and for the RHEL 9.5 kernels by LTTng-modules
v2.13.17.

We are aware that this release of LTTng-modules fails to build
against sles15sp5 and Linux v6.13 on powerpc32 in our CI. We will
investigate and fix these in a future release, but we aim to release
promptly after Linux v6.13, so considering that LTTng-modules 2.13.x
has never successfully built against those kernels, those are not
considered release blockers.

Detailed change log:

2025-01-24 (Global Belly Laugh Day) LTTng modules 2.13.17
         * fix: include linux/fs.h for 'struct file' definition (v4.5)
         * fix: add missing check for __must_check 'lttng_file_ref_put()' (v6.13)
         * Fix: uprobe consumer handler signature changed in Linux 6.13.0-rc1
         * Fix: lookup_fdget_rcu removed in Linux 6.13.0-rc1
         * Fix: f_count replaced with f_ref in Linux 6.13.0-rc1
         * Fix: sched_stat_runtime changed in Linux 6.6.66
         * lttng-modules fix for RHEL 9.5 kernels

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
