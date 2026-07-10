Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DCBC43458
	for <lttng-dev@archiver.kernel.org>; Fri, 10 Jul 2026 02:57:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gxGhC3z2kz2C9W
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1783652219;
	b=btPr5H03RnIPS5eFzJ7iyB4rKMgixTwi5PVr4fbncf1ppXZTQcAF3AZMg6suILSdK8wA
	 oMPh2jAqBHC7RdPQWnNvk7BgiXKFeNfdTyyvd+tVRvcIVtJkUOg7ObX60uTSNfoo/U9iL
	 kzv+6aZBZ4P4vM3Ume0QQKHPcsgLwPJguopM5/qSFEY3WOU9Vfxs8dz2voavDeAdLrYaK
	 H/s8tMEoKvTc51QJqWCQWuh92PXwEoNerhgWQqp0fWgR/gqolotSFZiTXddrCPvEIuzTV
	 xIK5bcuuljrTEMnHccggGo6Gx3EODc0wRr/oqM+fnG0YkUKMwSnfhpjRImenCi3jr/A==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1783652219;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=aeNhDai/ydxSGLA5rdTQrTBM9bCumR/ypVEa+f0y9H0=;
	b=VDK07slIUOBgx/endtCyDyl9FRnXMoYH/LDkOGKzlxYurg8s2bxJixTcR+rigFwQqiG6
	 NQJwXN1YkeNan4V8pDdpj1pB7gdAMbtr39N7JO5xScxLbZLKuZa+2nPqnhNqebhBV10nM
	 vVTLTk3hqzz2fQbx8hmektz0e6GFzdLVpfbtRLi956cDnL7cPFYCLi7J1oeaJEehdHjLg
	 kURpoOxm4wWhno7zOh78pDVKZ2pe81SbJS2myG/OhbHfTD9oP9COoZTNehoWgOtfsRxz1
	 GQDAQno2H8Zc/yU/OYB6vQtEZGVlRsfggnkml07UQZZlr4Ajglmi3fVllmicoCvlz8g==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gxGhC3z2kz2C9W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1783652219;
	bh=4Qqhibb9fVRg17al2MEBCz5niomJ0E7UNDWxIdTSGek=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GFPP6lSFpRmyBc4IRVr8VyBNxg72SfTQog3WcDTLrQPhP6Yr6HcIOqWV4z9JoVSUg
	 hqGW5R/zBsMnPfUHHVl6NSu+IAHrc2QNgMAza7JQhQzPniHJ2NMRmppNv5XEe9/r68
	 Ay2hW19h7FVqYURSz9K2FAcvdLMUArTVX2cJKyq8FFGSOgsLNXtiiR6NMPjT6OKPQr
	 bwgy02oH5gRtA/aw91uZzZeYRxsXaDgnsMHwwq/OgzRAaxUhFT3kewDLWkzi+AOLR0
	 riVCOpqfaCjaRXgd/0fLwBe5LWOpFK8OOu3i/5wwu25wMCh6jf5oNHXPGw6qjekqVY
	 2eMvir9Nyij0A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gxGhC3z2kz2C9W;
	Thu,  9 Jul 2026 22:56:59 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gxGh92RhhzyS0
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gxGh92RhhzyS0
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022114.outbound.protection.outlook.com
 [40.107.193.114])
 by lists.lttng.org (Postfix) with ESMTPS id 4gxGh92RhhzyS0
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jul 2026 22:56:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDmW9Gf7actQ4hx8FObMHdqv+gXNjXzvdreul00GihI8QbmbLP3cyEBEdaYA2id+v7uyG9Pis/AxssjaNHSwb+etNa7xYInHmidZ2pL6uxuu20W+RpEavsG3YEQGH1ls91dybUGQ1x7Nah26LEzp2E5kPTCoxVOyuv2MBe3/OIGbHl/CPg2BDzjYkIPlF8BtXDRPuUsSioPofcFWrbpeLQLlinoXZNDTomhHwuiGvIG56SgMHdTmw+unC8MWNKHU916EEyscHF8iQfHUUyrPHY6CApWzAF7bSNWOWwvZB8Mqgfpe4M7GxXvY3L0NMEUhkAZaY9iTRIyKEYHgHVehFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Qqhibb9fVRg17al2MEBCz5niomJ0E7UNDWxIdTSGek=;
 b=r3UkZ9dqQbGbx3DWqwAZBrf5pWKQGoN6OeG6wPe3AegPZ0YSa3GnzjJfUuVwFC5+k6hdstfZ+sUVtJAbjS25fYRMTeFFs8mum3Ht9/NXGDqb3D2FkMz8Wc1uwkU3Hv2EQVqt1ogRfPKu/So2UIe+TV5GY9gBG/HgR72TGYQ8yGT5z1ZMSzvzBdvTM6mdE4oT608T2fdt/NYdO6Au9mhtR+ddrItyOz7j+TwdChNZ3gF28eWA4JQRA2gue+iZArOIVyfJmbYXzDedHUZo0yryAH/lb1baBbPip5nMBFVj4zkjhb2W2T7v5DOx9kuX+LDBMe/yruf4AuujoJN/qmqE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6636.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:42::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 02:56:52 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%4]) with mapi id 15.21.0181.017; Fri, 10 Jul 2026
 02:56:52 +0000
Message-ID: <14541751-5104-483b-b60c-415d791b4bf4@efficios.com>
Date: Thu, 9 Jul 2026 22:56:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: CPU affinity behavior of liburcu call-rcu per-cpu worker threads
To: paulmck@kernel.org
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Olivier Dion <odion@efficios.com>
References: <e8fa9744-74d2-4fae-8684-f1df59aec1c0@efficios.com>
 <0600b601-3edf-4897-b319-b4763943809c@efficios.com>
 <3573944e-3abc-48d7-aedf-3362ebd7ebe4@paulmck-laptop>
 <38f1f93e-3bfa-425a-96d9-3035c8ecc785@efficios.com>
 <1aaa979b-bad9-47a5-879b-b4fb2379ad20@paulmck-laptop>
 <a25cc916-2bb3-4133-afcb-230dd577726d@efficios.com>
 <02709be9-d7d8-47cc-8032-ed2e3a714fb0@paulmck-laptop>
Content-Language: en-US
In-Reply-To: <02709be9-d7d8-47cc-8032-ed2e3a714fb0@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0186.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d860262-5459-4c0e-a9eb-08dede2ee4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|366016|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eyjWXrNubMQyy6jRJWukEoa3izeT93m53Y93jKAftx/2KQ9xngR+2J4rVh6pKHJcB/g8cZDcl448HBDpgriLJcRcpE4lF/H/uZt6w1hHFZi1LcKULQWAmJeQS//xsAqkb0d3JAxETPQOmCEsxByk2E4l6chtVAnhgImUGofCkn1EJ6rq+QbxN92OU2SQbtTdgPyumCzxKnLj80pgSsz/uBBxrhelXATDhUrNPTEdlgo4H9cpmKtV8Su6oIc16FA664nGndCkGpTsAOOfRIhU7aoSrxUNGpekIii6myCMC2Js4/7h+UEns4ARvqJOK7H0gmWwTImjPtiCpdblPKMmd7bA00gj6tpAewWyK1FpzwbR2+xcwcMuOYsl25rPoPHLqcx+G0OvfzHkS5NhHx3vlaTuMz1ABSWUcTzRyM/GZdvZD1iM3rSlVepIycwJacdWoi8oBT6bbZ+RsBMXntMP8uh7R50m9xHfjks91/ZqD9bt+FtAVuH1vvFqqoaQVFlynkj4u8cwzARDerl0sJHHNoW7BLLetSHeP/AhEkq5TTyBHJnrPjUk/IZB4Hb+oirrnqH6X+1dmFlUIMLe+5aX7iY4iyyFJA8lq/tde9rMeno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ylhwb1ptamF6Vndob1h3REd4K2FzcEhXaWo0THdDandaSmVyeFdsTmNuQXBC?=
 =?utf-8?B?MUNYRWJycDlNeHFUWGtuaUY1Z21KenppU2RwSTJiYnc0VGdBZm1oSmdWRGxl?=
 =?utf-8?B?Ujk0Q0N2K3YyaFIwaitvN2laeVhtbDBHTzhPT096VU5teDBHZVZoL0VZMFJ2?=
 =?utf-8?B?bEFDWFZGKzBINFF5RnhqYnZtZnVUc2hmaUk0dlRhTUliUWc2VkN2amRFWDRX?=
 =?utf-8?B?dWZwZ0RCNStCc0Y4OTg5RlVYUEdiQnk0bERDNFlNTm5xNlh5L25obnkxQnJ2?=
 =?utf-8?B?MDdTNnhlRWxtTDIyckdHdHhyaURkaERnRG1yc2hpQjF4UkcyMlQxbFBhNjBy?=
 =?utf-8?B?L3hDeWlnc1JnQjVqSENBSDFhNDFKWW93bzhiTjFqS0dtYXZjSytONUdrVEdD?=
 =?utf-8?B?ZFJ5WktJVkYrc1NBSnhnY2paazN4ZTVDZ1RLcjhCNkhTNjdlRzBLTDJWeHNJ?=
 =?utf-8?B?c0NVZTNIUzRJMVRROXlnckJ4amJmclhKMHdhcW9qYSt2RkoraHQ5TnJYNjBa?=
 =?utf-8?B?Tkk2MVplZE90OW5uRHlyMlZ6eUpJOENLYXJ1ckM2elBldGdPYXFzWmNLSGM5?=
 =?utf-8?B?dDdOdVd3dHlCSk5iU09XcWhZMWFiSHpkeXN3YjloNWxJUXJVRS9QR28yL0lE?=
 =?utf-8?B?aHJFVmZPb3UwVmpQR1AzZGNrOU1OVWVIOTZ4TFBtMk1HZ1l6Zi9ONWYwVldk?=
 =?utf-8?B?WkFRcWM4NTBjQmRETTBJMU1DcnFOM3VGUkplZFJ2ZVJwZ2hnbVpIVkt0aFlP?=
 =?utf-8?B?WXNFaERIbVB5ZjFrVm5TdGNYa2ZOWVlNaHladHlzQmhyS1p6SGNOZ1NhVGVP?=
 =?utf-8?B?ejU3dEtDRTZYL3NFaG9VdHMzWExoZEVpT2pVcy8rclllMTN0VHdLN0JNdjd5?=
 =?utf-8?B?ZFFmbVh3WktLeThVWFdTbHdXaTVMS3VERU9BWkxwTGpxN1pDdGNvRjloMlN1?=
 =?utf-8?B?ckpGWE1OajJnU2dSRW9xRjJTVmNHUE5VRDluQjB5aytMM0RlZTRrY0xXMkF4?=
 =?utf-8?B?R2x1UWxhbk83UFI2YkExNElvVHFwSjN1NitKb083SDFWMWRJcWlHcmlwbkUw?=
 =?utf-8?B?c0o5dEdzSFVzcEsvQ2lTeVNCc2hMdmhWOW00ZTNWTHViYlE4YjFFeFphTVNW?=
 =?utf-8?B?NThlbUxnV3M1d2JIaFBDY2cybzFNMnZGaHJNcjdPVDZhTDNCN01CUlZJK0ZX?=
 =?utf-8?B?YWZSaHpxanlFMzU5cXlSS2VTR2ZEMG9hRFluNmVyL2lwbERhbmJoTzBZN1J0?=
 =?utf-8?B?cnlIWTRLb1FZV28ydmNCTWZLM24vNzkrOUZRU1B2RU52WHRPc28zVmg3RzJR?=
 =?utf-8?B?VFZ3Unlwb2lWVFQ3OVhMQmNMN2M3Q084Y0pOSmxwa1h6NEgwd0ZlZ1ZUZnFC?=
 =?utf-8?B?Z2oxL3lCVnd1Wk0rK2NDdDhVQUIxa21oSytPQyt4anN1TW5vWms0NVhjK0lr?=
 =?utf-8?B?cWlOK1oxYS9CdVVEc3NxdnpwZENYL0F2YUhJZHlPcWxVQXJzcDlQTHVsVHhv?=
 =?utf-8?B?WE1iT0g0RGZNN1BVTGhjRGhONXZkOGt5MHprenBma05yMW1kVXY4OWdaZnNn?=
 =?utf-8?B?K0VCS0JUQUZzMjVzbmIxY050eXFGMjIyQ3pPMTBDalhEbjRKV1pFNFlnTG80?=
 =?utf-8?B?UFoyVTZUemY2MHJrTC91aVNJNlRqM3ZXN0tFTElGN3UrNzZlZnYzNEVaeERE?=
 =?utf-8?B?NnhuTnI4ZDFma2Y4NzVuVkZGNEVQWUdMU2JlUy9FYmJjeG5FU2NPcC9sa2s5?=
 =?utf-8?B?VmpDNnkwTHNleGZoenMxay81cFZmcmh6ZE02b1Qrbjh3dS93amlRajlWZzRI?=
 =?utf-8?B?QzVIdU1vK3ZmUVNsZ09MUmlSWmZaSENNbGZVRGgyeGlIZ2Mwb1pZemlQZXlG?=
 =?utf-8?B?c1B3aUxMcEJZK3dSSkIxSldJN3hVaVFVTjBVUjlQMzYzdnEyaTBwcW9SYWQ1?=
 =?utf-8?B?anpqdzNFY2pYTER2cThTMkZaaU03M2l2N2dEUXgwTjNYeU1PUDFrUmltM0Z6?=
 =?utf-8?B?UEdIWUlGY1o0eG9QTVlCZlhncnZDTWdRTWtUN2tPU251dndld2podVdoWWJy?=
 =?utf-8?B?VllRSkFtUXpvYjcrRXl1bTBNZHNIemFhY0hNTVY5SjdGd3ZqcG8rbzdCZ2FJ?=
 =?utf-8?B?djNzS3NUMFBPTFpoUWF5N0tHL3hnODIydm91eVU0TDJvM1BJd1ovN3FIVmIr?=
 =?utf-8?B?dG9tU0p5ODNlSW5JVWo5N0svcTNDT2hCdGNUZ1lkZWFRTW9raFpqNGpDVW5E?=
 =?utf-8?B?aEk2QXBHazZTMGxzaUZoT1hibFFKN29iK01jeExIVWlLMDh3RTVXRkltL2l1?=
 =?utf-8?B?ZXo1Q1VXd0Y4eWlXMmRxdHJqQ2pXSnkwS2RRdXhMVW5Va0lHKzB2UVZKNjZl?=
 =?utf-8?Q?mRvWxwXUUBAJ3FAE6+0Nhtl8yAQr6bxtZxZM/oB4dIURQ?=
X-MS-Exchange-AntiSpam-MessageData-1: 1LU74z2v5laCcrrPMXsGcUYKvRyDfC2qgZtKWv8zVcf/SaGwLi16h3co
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d860262-5459-4c0e-a9eb-08dede2ee4b7
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 02:56:52.2625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+STVQKdPWXNzJNKMfbl70P2pUn1VM2zcp7s335SQog/d+3q8Sip0eVYgnpEKx9GOvhNbRxzBPcYMEBbqQ1UE6Vz2sFvwBCe6W176vYHz1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6636
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

On 2026-07-09 22:53, Paul E. McKenney wrote:
[...]
> 
>> And unfortunately, for me, tcmalloc is really not a viable option,
>> because it needs to own the RSEQ area registration, and because glibc
>> cannot use it at the same time as tcmalloc, my benchmarks suffer because
>> glibc has a slower sched_getcpu() implementation.
>>
>> So jemalloc it is. tcmalloc is not usable for me because they don't
>> compose with the rest of the world. I warned the tcmalloc developers
>> many times, but they did not listen. :-(
> 
> So an alternative rseq for the rest of us?

I'm not quite sure I understand. Since there is only one rseq
registration per thread, this means that tcmalloc require their
users to use a GLIBC tunable to disable rseq registration at the
libc level, leaving rseq solely to tcmalloc.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
