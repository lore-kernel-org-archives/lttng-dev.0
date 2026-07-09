Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103D0C43458
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Jul 2026 20:00:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gx5RY5GQ3z282f
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1783627227;
	b=TEPLa1Xmz5xjxHLutoYdp4KGiVeFmGyuKHZ5HJuYEvt+o65tS5HeUis4Xa8NtJwzQWY0
	 3/K03dh4Uym48gamwxAntVzLde5mctnMLIfK1a/hGLZZcsctyeqFJ7olkoM1llFelqRMw
	 jFTZRfNSTGVzBhNO0oerzachdFKwt+QbAnYJ+woJxRsP7T04e7KDMvAIJgd2hJ8Dp8viK
	 oC80dNWeTCKJHzNwp1ppYGq8uvslOL3oRyoAH1uEooIB5TFuDERBpFA/pVSD8Yv1N75cB
	 tjFaYKPKE8tQMwRWFJgnIr3Dlbv+cxYV6wgv2t2i766rxelzSXNW/N9lX73ssxT2KAw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1783627227;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=jG/G8wNELZX09XRuVfJ93EWP6a3PdxOKRINXZekXWgg=;
	b=C0KwL55hfkaTP3xpobXXiqsfdJYS9aZMbyfKht+zooSwBZyIyk8fR+xnnXblK8aOwzc8
	 UbgwMpDFaSP16FRkAUj/KCVFMJDSCkg5kkwnfx/2S4om2mBlxNQIVHx1hhBlEfGdyJZh5
	 SLiQRJVeEOGhS4lXiVtoUJU7FiyGsBlhz5CguRyoKHDOzbOA/zJYCcElSkPqUGkFDPp/R
	 iptcfBaOPKmdtbFBiovo278KXTT0T2t+ip6oKHq0k8JGq1FH66hAG9g2WYkoLAtYJ6jYs
	 AfONqYDey18VHnVOPEclz/uQ7uTfRCe3p1QSCJmURYUuhp0Z5pXsPsplZZLud0ITlww==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gx5RY5GQ3z282f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1783627227;
	bh=DE3JbYsiheRbr18s74V3SGdCezAGUIWsgJBUGNd+fHE=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jfjYgcJqlr0RPObfSGYeH5HuRUysfjEclfDWgsKQaYi+3PrvEEb9ERXwHxJL9ERdU
	 CzU0bzkT5H7ooYoNTzafyRymW2ZH7NoUp//gLSzqHq20WCrDczJXpV3DhXRFXvvLRB
	 Yn+OEeZrRYnZzo6eobi7Xuusw9ufr0Q6OoLCXSq3+WSN4usIfgffB3oP4ett/vDr2s
	 O3QLH8X9jB/+i2GJnYwf7CefOmdMUsVQNE+MRNmvFjJZv/RImNviw6pgKbQaY1LYxo
	 rGXgRyIUrHdJATxkDtHKokQ70++VXkPYdApth7D9JXgVGBIv8opNr2ABIJIPnaxYNy
	 lVyDjqm/6pTnw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gx5RY5GQ3z282f;
	Thu,  9 Jul 2026 16:00:25 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gx5RW6tNyz28K3
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gx5RW6tNyz28K3
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170110005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::5])
 by lists.lttng.org (Postfix) with ESMTPS id 4gx5RW6tNyz28K3
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jul 2026 16:00:23 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xywXl/kGTUIgRolxhoLnqfq7K2oSeFViRMVR995f8YZPXJr1L+t7nS4vNlJubFlq3M7vxsq/uCRAo/k60Djdb9AvMB9ylnplG0J2JvkBmAcv6wSQM/t9Y6Y8LG6Tak/RdQ9eKy1OAtpOr9dqCKdtEmBk2q3ELYtiT7xySOaeJnuUJeFFw7EFfrPEIiTdI/usoo+L7ke4J5TBpmuLbUCaZ0B6OOMMJu5tzn6E59ylKsMFE7TKFlQUTdeO4XstarAWQ15jwTxl6wnm8wiRsvo92Zxyof8CcM/1qkqoJ3Z+MPkrFfXuxFOyw8jBtiLkCLP30igKWRE77RUdOzxMuQVzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE3JbYsiheRbr18s74V3SGdCezAGUIWsgJBUGNd+fHE=;
 b=dY1WVI4i/cl0UJQRF+ealLFbVc1qsLOtwUS8OS3fQpYxnj4/TC0TwGWD0Vlh5VVb7+rOd2ZJOXy2Fexk/52JVI2AKbf6vxFBfSxuNnSraKAAtQrv9XnB3yJ+PjkFcu/o2dU3gzXlqWc4OakNERqNEnKX/OzK788R1naHo8sNIZl597IKKLK8gisRgoHHjMQh3CIj9/nzukMji5zxGeKLbyGsrIefSey299tDoMTFnje5q/U7VpxEyjbzoiML1CHbnD2jemleNzVRo1JFqBIyO7zfuigtAP1GadOrcj+psH/hmjg9VimPPqbEm9H6jkSdIrmBxEnVlcOhSXz+necirg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB5391.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 20:00:18 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 20:00:18 +0000
Message-ID: <0600b601-3edf-4897-b319-b4763943809c@efficios.com>
Date: Thu, 9 Jul 2026 16:00:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: CPU affinity behavior of liburcu call-rcu per-cpu worker threads
To: paulmck <paulmck@kernel.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Olivier Dion <odion@efficios.com>
References: <e8fa9744-74d2-4fae-8684-f1df59aec1c0@efficios.com>
Content-Language: en-US
In-Reply-To: <e8fa9744-74d2-4fae-8684-f1df59aec1c0@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::11) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: 987f5b71-d535-4d60-bc63-08deddf4b360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: PQOu8Oh0Uh9zc7VszHfK2NyCbeugJhxcnn49BcM9v3Qx2l7oTsHBvQtGXTv37rDXeFlvpxo6SniOn6bZw6G+odC8XJOAzWJaLyefQ+5OR06iR/TRkTag9CaWFY+7HvTbsRWKPwGjeKxhKHY/fozW+ozeYK7QwSuBnp1izpfXkDHlEe4v5UCmm1AUQpKtFJERFWtEgchf8CreqvBnnipbqPsqfv9VQWYr73glsMrlNquqKAqedLGru0keEF6+alfMlC1BibBGTBFAZhg44b2ed5TTM+mnUCAOBt7JEVDHrF19WTKOFP7UGg1XWTC8Go6UkVbhgGgY1XX8OoAWz18pPzzTWCdoy2qD3dTYokVOQcEcHDiPVwFjfH5bE45B5jh+u9DCysohJaOwAPsliX7oMJepPQmGz6m4Z7GzwI/eQIN88+fzJxy86buBEvXXewBbCRjGL0BK4s8bQyosjyLPAJBeG7VjVnrKgNHwTOqQhYzsEg6Ld5B7NZJ/uni9Tp1+nhcrK2z0ULpWPnFGjlAlvudRuERulzrUGQnYmPsmf6M2Xa0O54PBKTzpi8DKZ9q3PuGgyxTmILIoLxEP13pNNS0Bi3kfU6/wYXvUD+8eB+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHJFYVpFTmJ3UUFnNzZXSVRTTk9BbVNxcWxuWVRWNGxpNUtvU3FZcnEwM3BC?=
 =?utf-8?B?dTlLTGRNMDllNUIxSldRZ3dMUVZ1dFFDV1lCSkttV3d3cTBQUm1idkVpYXdI?=
 =?utf-8?B?a2xLaExxNGRLanFOMGN1ZGQwcFpWRzhqUkQzbUJrYmRPNk4wRE8zYWVWV05L?=
 =?utf-8?B?aithZnJ6b0kxUDFvZVVFVkxWemNaeUtmdkFPTEMzNmdHOUJqcVIzRWpwNEtZ?=
 =?utf-8?B?Wm0wOE1IRmxKcTZuNkkrTWoyWlNjNEJLMVFLT1ozajY1bkZEMFFoWGl5aklX?=
 =?utf-8?B?ZlQxNkk5RnNub2FrNXVIZlhpTzBaRCtSQlp1TEdsNHoyNVArTW56YnZTT0NR?=
 =?utf-8?B?cXk3WXdPUFdyQmFZMHRkdTRVWUtQR2Q1ZFM3akZmMWxoeDJGQW10V0RPVHZM?=
 =?utf-8?B?anAwS1hpd1hiWnlGY0Y1SE9DTmpVNW5yYzE2Y3JxTFNBWXBaalEyTkFwanNT?=
 =?utf-8?B?azI4NUZacTdJRU43ZTk1TU53NjRuSlJGMGVwQUhkaEZhSmE4MVZkaDFzV3k3?=
 =?utf-8?B?MmhDRS9tdnU1RTRaQmFVZFhRZFpsNThTNUxPL3pmTXVBTGZIdXNaU1dDb2hl?=
 =?utf-8?B?Ly9VQXdtUWpLWkY1UTFjTnB4R3k3bzh5WG9PcW5TeHU1TTNLUUNwa1FURndI?=
 =?utf-8?B?NVROWHhyYTRTL0JFbWpkbXFrU0hwZ1F1aDY5VjZROVhpQ2N6L2VKQjlZNUpu?=
 =?utf-8?B?R1FWUitiTjJCMGhZOG9wMEI0cmFIUFE3cUVtK0pNV0svbUZncUxOa2xuMXIz?=
 =?utf-8?B?cWRqNXV0TWp4WERnNG0xTTBaZVg5aEJTZzdncHM4ZTBNaVNrRzBPcEVVa3Jz?=
 =?utf-8?B?dHh3bFZwR0NheEc5eHF6bnBJODBZbGtWUlNpMWRJU3Q3dUFBSUVBSWswcXIv?=
 =?utf-8?B?a0VzVkllcHZhOURYbldwaHZCSWdKN1hrbE1GcDkwT3MzdkU1VWtSeDNaVjdw?=
 =?utf-8?B?ajkyQS9nVENzYXlnb282RE5IeEdCSUEwZFF5MjhhVXR2WFk3dUJhbWZEQXhQ?=
 =?utf-8?B?Z1Via1pRRjJndy9CeENDOG0vT1lGc3d1UFJjaVJhY3hKclNMRlJjZUFxcE9I?=
 =?utf-8?B?Y3U4UFBzTnVHZ1ZhcGNNZGZsamU0QWtwZFJFbjZCNEpRYi9HUVhzYXNqNWg3?=
 =?utf-8?B?ZGVVV0VNUjhIbGlrS1c0TEY5bEtabVQ0SW91NVVxME0yOVc3bW1XbEwrV04x?=
 =?utf-8?B?N0tvb0Z0dTd5QmJuUjNZajVLWXFTeWFEWHFtcDUrbUcyUWU3U3RtTTFsb3FM?=
 =?utf-8?B?SWY5eUpiZ0hFVzZHQklTZFNCcVlEVU9BU2dPZFpFeUVNT3VFZGJwY3NnVUxp?=
 =?utf-8?B?RUlVTnYzMWdCVFpLZW9WaGtCL3gxSHpLUmQ2QVVyR1pNSS9GT3V0WHhuYkkz?=
 =?utf-8?B?V1ZlZ09La05GVWh4YnNNRVBVMlVhSmt6UXpkdXVIWHd6VW1iMlNua1VLRE5u?=
 =?utf-8?B?b3NSRTFTVXhTTzNmbXdsbzFiMnNnNWdFM2Z4dmZGeUdVM0t4d3Q3VGNTTm9X?=
 =?utf-8?B?L05QMGROdlRiUzdTOCtzOWhWQU5rT0pWYlFQRHc5azZ1dXlnY2JyL0ovM0Jp?=
 =?utf-8?B?cU43ejZqOUUvWSs5THlucHphMEU1UzVwMzM2YnBBMHJNa1JtQkFYYzVYUXZs?=
 =?utf-8?B?MTVlOUVhSnF5R2FrSytIRFVNYnF1eVYyYjRiMFREeEdPbXV0b1Y2a0dkeDJq?=
 =?utf-8?B?UzVKc2EweGhVWURnTy9sU0lzcDN5YXlveWlESGlSSDQyZ1ZuUXJiTnhZNTVi?=
 =?utf-8?B?dGtOY1kvTlBWQUhiUU0ySC9XYlpsKy9pQnYxSkRzU1hXTVBQaCt2NDRFRXRr?=
 =?utf-8?B?U3VhOU9oWW5nSEltbHk0RUx3Y0tuV1ZEbW9nZzg0YmVmSmxtZXJpaHF4WGEw?=
 =?utf-8?B?NWxyQ3pDWkpXeWhET3liMndqVUtCNW0zNUZoZjJ5Z0V6cHNhMlRYVEZIOXVm?=
 =?utf-8?B?OVRJL1R4bnR4MzhmRThIMUdBeTVrZFVPWTF2d1d2NVpBRkVzZS9YdXA0WE9u?=
 =?utf-8?B?NGgydnlJYVBhaWM1ZlFNd3dLMkpmcEp4YWRJVnNnT04yd1RWMU43UnN0Q3lR?=
 =?utf-8?B?SC80dEttVWRTQkFoMXFPLzJ4NEprQXlVaGg1eTJKVHYxeEhEc1NjVUtDYmZj?=
 =?utf-8?B?dTh3d1E4dE1vQURMblRSTEFrWGRTTmpEbXkweHUvVzF5VkpZY2ZKQnRZaUp4?=
 =?utf-8?B?YjVkbHc2bWRheXZwdHlUZVRWam13a3lSV1Npc0hXYVlyZTdwYXdQVnE3Ym4x?=
 =?utf-8?B?YW0rRE5DNExaaE9YWFZwVytjQUlDT2tyQzdnQzRqT0FCOTQ4amRoN0JKZWJw?=
 =?utf-8?B?ejdvYzNONkFqMldRNlVKempZKzNZelo0SHN1Q1gvVG90eUNaeS9JaEVlTlZi?=
 =?utf-8?Q?Cj/IfZZt7qdtSxrw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987f5b71-d535-4d60-bc63-08deddf4b360
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:00:18.6013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uPKm9vJf9XtJS3n9N/tf3UnMe+BQO5jnO+DHQi6afmEvMpBY9hUv1vj9svjQsQh/0GBL0cBe8MML5yM+Y1/0nfMXKxxVPBgSF/xzpSF/c0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5391
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

On 2026-07-09 14:48, Mathieu Desnoyers wrote:
> Hi Paul,
> 
> I have a question related to liburcu per-cpu call-rcu worker threads.
> 
> So far in the current liburcu releases no affinity is set when the
> worker threads are started. We have to wait for 
> SET_AFFINITY_CHECK_PERIOD_MASK grace periods before the affinity is set
> (it takes about 2.5s in my benchmarks).
> 
> This means that short-lived test programs will get poor CPU affinity
> for call-rcu worker threads at the beginning of their lifetime. So for
> short lived programs, this means poor performance.
> 
> OTOH, if we have short-lived applications on a large machine, setting
> the affinity immediately when the worker thread is starting means
> we use CPU time on CPUs which may never be actually used by the
> application (no call-rcu activity), which can be detrimental to other
> use-cases as well.
> 
> So I was wondering: is the choice of skipping setting the affinity
> on call-rcu worker thread startup done on purpose ? And if so,
> should we perhaps consider setting the affinity as soon as the
> worker thread is woken up for the first time rather than after
> SET_AFFINITY_CHECK_PERIOD_MASK grace periods ?

I've implemented this compromise approach here:

https://review.lttng.org/c/userspace-rcu/+/18257 call-rcu worker: set CPU affinity on first non-empty dequeue

Feedback is welcome,

Thanks!

Mathieu

> 
> Note that there is a commit in liburcu changing this behavior right
> now, but it's not part of any release yet. I want to figure out the
> wanted behavior before releasing this change:
> 
> commit 28f282af1905a1cf50ff9b5835b4cd9de4416ddf
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Wed Jul 1 12:49:43 2026 -0400
> 
>      call_rcu: pin per-CPU worker at thread startup
> 
> Thanks,
> 
> Mathieu
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
