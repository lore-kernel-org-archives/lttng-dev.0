Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFE0C02192
	for <lttng-dev@archiver.kernel.org>; Mon,  3 Feb 2025 14:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1738594380;
	bh=WZgzd585KHL5fXdpnQF+G/clXWQZWl5CdF+xBFQekgs=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=us8E+jWWWiCvgrVY1qrDqlssw70XaUiRK/WegCZed2jCGTNGzRfce5gXvyYf64UJF
	 m14JjLXZ95hcOdngh0m1qKFKHPI3pl7tSWbuL3BsN1ihiSDIyYOpoNxWhS08myGZkG
	 WhshpzUzvGoB3/5nZN7tPDXlQN8976d/GbitgW289oXOncq99MqlXaonao3kIetf+v
	 hJWa16IeDIwVrPYkJ2uISviN73XxxQvOS1ermO1mKHP3tOgcO7i/AEpOZvZdNPikC1
	 rNh7QUfGwvJw8SS7uSWtMmgYIOOcRd8QFB1ejm5V3ehdlHTMwdNRff9rMxk6taTLPj
	 ipJ40Wj6XuQ+w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4YmqHH3nk9z1df4;
	Mon,  3 Feb 2025 09:52:59 -0500 (EST)
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::3])
 by lists.lttng.org (Postfix) with ESMTPS id 4YmqHG4r3Vz1dlJ
 for <lttng-dev@lists.lttng.org>; Mon,  3 Feb 2025 09:52:58 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bX8Lbnl5VvZp+c4r3QfnMYVTnFG3zeL/vnQyl6JcL899S+CbdbwYCoefr2Pi7hY6INNv6vOQ0SCBGkwxpRcBcxzINczEsKplVmipOChiquk0fBpL4e3CMR8nIRS0Pw/kpjOktAEN8VxCXb/SHLFMTdLd+ceJ7XE11105Stnv554FCM/lhOaAC9WPadzfsnbX1gJawSbj1y972UvtuYvip3/qz9Lk2r8N/ThA9MfNDgFP+mI95y2uw2UBlCYxs57a2IZAQDHmWyrsi98lVtNDeR7l0dDo3ew5Kg2gqazfRF12fCM3CdikViN8HbAs4gXBbPSpPEfLPhv+Ok/j//H2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg4SNqhmAU/0SdCXSSNHxXXJn0/g50kT56c/DfowXQ8=;
 b=Rx72Xfkl5OemnQC5LlmEcVUvIyQ3PjmJo+r+NB64r4e0Nb7pXK7yu+t3rLhpESWKyWQOsjWDa/XVIIgGohcTf26OPA00GsAID9s6dX+XGDRvpsmwhFhvD2UBApNNJmk8l8S2PelEV5THRsv9O4c7NGph0iVoFF5MpPR63cd65qsLkk0vFquQiYn5tTPKrhfJuVO1Lr0Rsy6CxRyBBCmo2iZu0mLhyKoug3K8f9ocET1PpFFKbITZxufo3bm3Rnb7hLgKTwztFJXy/E4KW6diGKi7Xx5DcXE5tM3rXITK1Is0MtB+G2XW+pmsfZC+OJ/EPtYO0uwJR3SCUYO4Ui3HbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB6292.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 14:52:57 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 14:52:57 +0000
Message-ID: <be6b6084-0356-450a-a090-8bb607f9a16c@efficios.com>
Date: Mon, 3 Feb 2025 15:52:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: librseq memory allocator portability
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>,
 lttng-dev <lttng-dev@lists.lttng.org>
References: <165086BD-96DA-4A95-8411-F87DB502DB23@sury.org>
Content-Language: en-US
In-Reply-To: <165086BD-96DA-4A95-8411-F87DB502DB23@sury.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::49) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d982a5b-2b53-4f9e-aea5-08dd4462721e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ni9Fa3RNNGxYSjdFeThHbDVadjhzQXhnVWtaam1yRjNNUzRhMGJ6QjRtNlBZ?=
 =?utf-8?B?VW5KVEpoNzA5bzdhbUc2MWhuYW1RMllvRlFMSlAzWlBiTHY2Q0FrSFU5MWhK?=
 =?utf-8?B?bDI3am85d0ZUbW1BaVk3UVRJUi9RQW5YYTFXbWhGZ3h1a1VmVnViQWNMR0RC?=
 =?utf-8?B?VEhrUEY3SEx2Q2srNlhwd1JuV3BXS29UYStMbXRtSTBWK0hKZTN2eEZuSHBJ?=
 =?utf-8?B?UjdYM1hRNTRyY1dyVEFBTTRubmtnYUVBWmlTMWtNenpDK1M3dE9LSVZzc25W?=
 =?utf-8?B?WGYwZi8wcjFRNHZLajJMTEdsdGdlaC9zVHdjdjBzTkFCOUpweW1FZnkrUXBy?=
 =?utf-8?B?K1lZYlVFSHh2WDBkcjMrc2t4c1ZUbm5Ua3JGWVQwNU5JWGdacUEwVHRubU16?=
 =?utf-8?B?UlorNllMdW9hSWgxeE1rd0ZqZzBBMU1vYXVRQ09ycHhrZFI3V2hvdWtKSHFL?=
 =?utf-8?B?Ky9KWGNlSmpWNmo4cG1kRis0Zzh2aTBFQ2QrbFMwNllId3oxWndJeS8vaTJM?=
 =?utf-8?B?MzZpMHgzalRtWUZ2THROU0d4N0dMNklOMnhxOXZiMTU4QXBicGh2SUxTVFJF?=
 =?utf-8?B?alR1UzA0alN4V0RqTWtDMGFuaDJwQWpnYXNHOE04Vklhejh3bkcrWUlJYlhG?=
 =?utf-8?B?WENsd29IM1pNc29MRFhRbWptUXFCMmFuT2VPWlhYbFQvaEgrV1ZzUzEwcW9y?=
 =?utf-8?B?OUtZNm5SV1c1MGxjSlRTc2FUYzZlQU5OSmpGTDM1KytSaDlWNWlDSk1oOHBK?=
 =?utf-8?B?ZE4xaEZFcE9JV3RMK1lyMWpJRzhRWmxtdUFEZzFNajY1ZndpaktjSlMyeWlu?=
 =?utf-8?B?ZkFIWGZBVUNKbTlJMjRWallGa1I1TjZ2UTRVQ0k1R3Y2OXZBV0lVRkFHSWxW?=
 =?utf-8?B?RGxHZ0UrMmJTbzVoUVhhc2s0Wkdidm9VNVVvT09lT251aTcxS0htQjYxcUFS?=
 =?utf-8?B?dUVySG9ZN01YR1JmRDJGa3c0bnU4aTkrWHcwWmFvcHN4YTF1N0h6ZzVpZG9p?=
 =?utf-8?B?OVFscHRtem9jQ3gwaFR1dUZWMjUxeHpGLy9BYUYvcUF2NDR4NFc3clBuU2s0?=
 =?utf-8?B?dU1uQ1RPU1F3bXRqVGg4bDkvY2ZQZmQzNHoyUWJvNytRS1FDT3pDYUloYTBE?=
 =?utf-8?B?NC9sckRmM0kzbjlVcm5rWW84dXhhWS9OTERiU2s2dCt6QVZ5V29nd2tubnRJ?=
 =?utf-8?B?bWEzTytFYURxQ1Vjdlh6WGM0VWFoUG1PRWR0blhRTm5FcWdhM3dIbFBLbjIz?=
 =?utf-8?B?a2p5ZlBKT0M1SE1UUExTdUt3Qm9BdkNwS0pBeTBSWW93RGF6Q3QxWnNGSU9u?=
 =?utf-8?B?YzNDMTE2YjhTWmNNV005cVQvK2hyYzV0ZmJhQk5aazg0YlBDY3cwSmFXOVhu?=
 =?utf-8?B?OEVLWHRGMHVwS3piTmF2Z0xTSHhGQXpOUGRCeXNISUhKZlZCemNLK0VGZWNn?=
 =?utf-8?B?WnRyRGordUNIWm9OUnFjUzc2TFB2NFZ6Q1I3eURwRWhkL3pydjhab2JHSlQ0?=
 =?utf-8?B?WXhaVENKQnUxSmxnMnV4SmpHME1HVVN1dDRTZW9MQXhPcjViNE5FY0tiUmYv?=
 =?utf-8?B?NFJOWCtTWXRoU0FLVFRvQUVFQUI0bGUxMDNuNEQ3VjI5aWxseE8xSXJMaTR3?=
 =?utf-8?B?YndFcWdFSHJLTjRINW1paVBMS0IrQXpuOGxyd1ByVnlkclFZMFFhVjdiWUdx?=
 =?utf-8?B?bEYwVWRiYko0R0RHKzBJQk16cUVlTGpmRUxmcmIxNlZ4eEZmRldiMHBaUmpm?=
 =?utf-8?Q?Zfmpul8Yh2JgRgLTBZ87HSchxXAR03rCqZTr8lN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkFTSWFJK05GV3JRK3NFYUdYU0R6b1lubHZJTFFzZzl3VkU2R1FQalFZdWk3?=
 =?utf-8?B?MDB4VFRzaFhRYTlSaFU4NzlMSzVBVkZkdVpTUlc3cE93aWVvcS81UzZJS2E0?=
 =?utf-8?B?d2RaK24rd3BGQlBDL3laNHZqZmlIYlZWR0VaQVBiMmtuMEVsN0JTQ2lWWnNQ?=
 =?utf-8?B?MUlSSTVRUEFKdThyUnhjb0hYWGhhdUxFUDllV3k0cVdOWHVaZGNQc0Rxd2JB?=
 =?utf-8?B?bjB4UU0xd0hTVVh0QzJCakNZQWZSQkN0c1EyWElLRTJFL0JqSW9MMjl3QjVz?=
 =?utf-8?B?dFdDSkp0a3NITGhualpNc2RESi9YSGN2Uk10VDlyMFpxVXQxUTI1RExINTY5?=
 =?utf-8?B?aWpBOWt5ek1nbGo1dUJUWGJSTUZGR1FjVEZoamNkQmxHM2ZucDZBdFRFZ0ty?=
 =?utf-8?B?QUduSEgwT3RPeWhHL0lxdVZFV3hEMEdzWk5oVThzYXI4dVRORktYVnllSzNz?=
 =?utf-8?B?bHJXRUIzcXZGOTBWOUhkWFhZak5lKy9qcG9PYTIyL1Zab0dYLzZBeWx1OFRn?=
 =?utf-8?B?RFc3YS9oYks4UWhFcmVYY09vTHF1MjkvalpzbmQvYlozQ3lmR0UwREdGVHZZ?=
 =?utf-8?B?SjdlT1NvRE9HNXlVeDdwRHNTR1M1UGVNaklad3hCYWFZR21oWnJhNWF0QkpG?=
 =?utf-8?B?S0hPUkQ2TTFjY1dKOGNkQ2llUzhTNUdXU01oZU13YUU4ZzZJTm9HWFRqa01C?=
 =?utf-8?B?NWJFU3N6b0NkQVFWM0NhR3gzemhsRzdvZjl0MlZBNUxvMmVLaUxESG9xVzFK?=
 =?utf-8?B?eWZOcVJ2R0NhYk12NFZBNmV3OVd5am5wQ3A5SkVyMWI5NmUrL0U4cGdQWjZq?=
 =?utf-8?B?TldvbjhYWnV4eldUc1g2aTBzSzNpV2greDVwekpMTWdaU0VmenZKVlU2MDh4?=
 =?utf-8?B?b2dndGt2TUorNDI4bE51L0JCQS9Jc2FjL1VPMzFvTzIydEozY0h3OTdza3VP?=
 =?utf-8?B?VUh3NzV1eHUrejRueVBjUE9SN1RDYWx1Ty9kUU9VUndWK2JQTTA2WGNLeVR0?=
 =?utf-8?B?RnZBRjcvVzFKMmUyYjVBd1AxMHFoOHMvK2JaNFAxci9XSGhnb1dnQlJ4cjF4?=
 =?utf-8?B?M2ZhZ3dKUy82MHFRRlRuT3BzaEU1a2ZUbE9lTVhoQlZjNzUyaTg5UVNxT2d3?=
 =?utf-8?B?SlpDM0RVeTJmeHNISEpVaHZBanVWWklUYktvdjdCUXhDK2pHaFZTd09qN3lQ?=
 =?utf-8?B?WGc5OVU3d3ZpcjE0VmRGMHBTb1Z0MFprbFJ1OUJ6a3pPSGQ1aHhFbnZZZStE?=
 =?utf-8?B?RjhhVjF4ZmJYYTNXSjNoeDN0cThaYXZMVUpMN3FyWE1OV0hpdUU1djAzQ2V2?=
 =?utf-8?B?VDZHTEN6RkRBcmJBT2ZSOVNJUXJ2SXpFYXNmbk8zVFZLMXo0N0tsbFBQQ0RY?=
 =?utf-8?B?M1ZpbzRHcVc4NzFoenlETjFmcHAyWEpnNzhuclJSNWNTMEcyV2pVVS80VWxZ?=
 =?utf-8?B?WTRqUnZtaHl3czJzYnBLY20vbVZ5dy9lM1FCZmo0ZzBDWFgvbXA5SXk1QTk2?=
 =?utf-8?B?YmJrUUdIMFVjMHkydTV5L2xRN3dYRGpNekE2UlVhM3BEQkNycFlLTXhjOUpu?=
 =?utf-8?B?TDNFalNDQ2V5Vm5lLzl6RTdqZDNkSmlFRS9tdXM3T1NlMThWOWU5dUUxVU9R?=
 =?utf-8?B?bmpQRTU0bVFBaTc4cksxamhEWTBabU83NlJHQ0F6TXdpREtrSzJPOUNPcVBo?=
 =?utf-8?B?bFdTOE5VQ3pNK3RzZ1pybHNLUDFITFlVNzJ4dkJZOU45U3hGNkVoYlAvSHha?=
 =?utf-8?B?dUJ1d2ZUL1M4amFycEVLb0V2OFhhY01mMVNaalpoQWc2RnZZOVhkOCtLYkp6?=
 =?utf-8?B?QzNDSU9vTitJY2wxd0RxZC9HSUYvdldudlAweWs3TUllV21RKzM1d1FSTkxU?=
 =?utf-8?B?aTlxRCtib1hvOUVsYllFWC9KdmNVdlg4OEx5SkM0U2ZaSWQxeVBUSk5jNGxS?=
 =?utf-8?B?ckJVY3YxY0RYc0tob2dPRXpPU1BtYm9hV2taeE9TQnRDQ3VqTjJwVy9IaXo2?=
 =?utf-8?B?SHRsYmNVajh5c21NWlQxcUZWRXJ5MklyTVlSZFV6cnVYb3VGbVJYQkRLZVNh?=
 =?utf-8?B?M2c2QlR6WHlJMVB5czVLWnpBMjBOSFlFNkhDdnFUTEkxcnZDSHc5MFZhbDhV?=
 =?utf-8?B?R2Voam53OFlmcHBIbTBpLzBwNmZRTVFtUlh1S0hjaktmYnhDbFdTTEo4ZjVC?=
 =?utf-8?Q?wzAummgUX78p05yG6vxS+fc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d982a5b-2b53-4f9e-aea5-08dd4462721e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 14:52:57.0215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwJUWM4QzrCk2PVdgg2u5uuA+BhNA2VF9qea7EwKt5KKRVPcPMIDmlJtzg2xe2008S377EQRir5XaMmVatRemN3O3cOYymp6tlERR+6kKxA=
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

On 2025-02-02 16:48, Ondřej Surý via lttng-dev wrote:
> Hey Mathieu,
> 
> I’m actually thinking about using librseq for some more lightweight stuff first - like statistic counters (especially those related to memory allocations), and my first obvious question would be - how portable is the librseq memory allocator?
> 
> I am not keen on having a code with ifdef spaghetti to support BSDs, so I think that it probably should provide some per-thread memory pools at the expense of just consuming more memory on platforms without rseq system call.

Hi Ondrej,

I have good news: the librseq mempool allocator is completely
independent of the rseq system call. It's just a memory
allocator.

AFAIR, the only optional dependency which is Linux-specific
is on memfd_create for the RSEQ_MEMPOOL_POPULATE_COW_INIT
populate policy. The RSEQ_MEMPOOL_POPULATE_COW_ZERO policy
can be used as fallback on other architectures. It uses
more memory on systems where only few of the possible
cores are used and allocated memory is initialized to
non-zero values.

Indexing per-cpu can fallback to sched_getcpu(3) if
rseq is not available, which should be common enough.
This is actually what the librseq rseq_current_cpu()
does as fallback. So you could just use that static
inline helper.

Now in terms of strategy for using rseq critical sections
for a split-counter use-case, let's see our options:

- You'll want to use rseq_load_add_store__ptr() on your
   fast path. It will return a negative error in case of
   abort, or if the environment does not support rseq:

   A) either your Linux kernel does not have CONFIG_RSEQ or
      is too old,
   B) or your GNU libc does not have rseq support, and you
      did not explicitly call the librseq thread registration.
   C) or your environment does not support rseq at all
      (e.g. BSD).

In the caller code, when handing rseq_load_add_store__ptr()
errors, I would recommend a fallback to an atomic counter
increment of a _second_ counter, so if the fallback is used
in a situation caused by an rseq abort (e.g. a debugger single
stepping within the rseq critical section) it works flawlessly.

Then you'll want to sum up the per-cpu counters for the rseq
fast-path and for the atomic counter slow-path whenever you
read the counter value.

We may need to tweak the librseq code a little bit to handle
case (C) for BSDs, as this has not been a target so far, so
we may need to add a few #ifdefs to cover that case seamlessly.

We have an internal project progressing at EfficiOS which aims
to implement the equivalent of the Linux kernel static keys for
userspace on various architectures. The goal is to dynamically
change the code behavior between a no-op and a jump, thus selecting
between rseq or atomics from a library or program constructor
based on rseq availability.

Please let me know if anything is unclear.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
