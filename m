Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC0BC02182
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Jan 2025 19:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1737489394;
	bh=OVgq/24dBJTwIAuIobRXW+oVHJwuQ/eDHjt6VcBU4pA=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=xfd+usnNPG9Ra5auwr9AVTauwvVZhOqks8Wu9h4U8C6MrmBoOf2WrdAcfEHvrV9eZ
	 APkPVMDApV8iPb44pn6CNeZ+L0sNs0pwzEg6GfzWgx2NJ7xm3J7Zu/Fpm+i93c6eMI
	 NVTUwmBsghkTE4hH1R3ZTSEnQIfxK5wbq1803RhDll/IBIEiQu9ZduwEJ5wATRuyoe
	 Zmhsk7LbKz8x8EN6tdzqUO3flP+WbWVnZdbjUMNeS1D8wc2dfy/LDsnQNNdZlr9GmS
	 9TIC3HIK5UtGkEr7tajHQNeUzDmd0baCgVPQmJqS1PpaGy6CvIInVY/lXl55fiqC9S
	 pYsZJ0IXD3TFA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4YcydY6BbQz1wgs;
	Tue, 21 Jan 2025 14:56:33 -0500 (EST)
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020122.outbound.protection.outlook.com
 [52.101.189.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4YcydX3K8Lz1wB3
 for <lttng-dev@lists.lttng.org>; Tue, 21 Jan 2025 14:56:32 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ub5cjnRP240D8p+yTnqKzCS3nCfubVVrMdLHnJfuIioRIrW9m+2Ivu3Ib0ECPuI4wqQIuf8pjFNjEqcmq6TVA9zakGTexRviFRaqCDJSIbdnoxi1NPqW5M+ILkVTy3stl79O/Tv3W3Wr/Hc3qmUt1axHHPnXfQuBC5o9LMSwuP2Ooo0j4WDwWbBLno83CUz9ud/zbDf/AsNY16uDiClyp6qQ6muDX6vAYQg/uunyxUn9gWUFSxmJs6L8oS993mbS6l1+BFX6YuN89WvVIak81HQ9SsnWE5ESJ6XMpHQZgMdBJNb2qjVc80X/hbG790mUkfLplcUNxl/cx49k5VpySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpyRH/3yoEuF7R5NE+Y4e1pM2oBTdTcwENcC11ah2pc=;
 b=gK5qZwFnIdjjVx1dLmy7pDvG02BR6VQzy0iE8JKOl/zGac2WWg4TbUOFmDQv/lFwIllhtbzg9rsdL/aEx5TNBgjROiU5NSqdovlXhYlHZUqLTpKJuZ5aWP2hjfH8uKcGD8L9sy0XlXIxHLbYEb0UvaCUQpStDnMZA39k3Nf18ZqFDYuE6/c0DSGV0/lEuI/Cc9+tEIpS8Fepq8Rg+1Z5QbQPc/ORUjtknvqNVJGUlyINTV96poKuY26Nn76sJbnDqNJuvVLYK++2PMNEd6OVAev2shIpYp7ju4gY0ZSJqHU47lN7Wg2nb8k0c24M13/3d0eZgjkmxn/1bvpjlHO3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10284.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 19:56:30 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 19:56:30 +0000
Message-ID: <7127ac1b-7cc5-4f98-afe8-1244c3a5056b@efficios.com>
Date: Tue, 21 Jan 2025 14:56:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lttng-modules fix for RHEL 9.5 kernels
To: Martin Hicks <martin@sr-research.com>, lttng-dev@lists.lttng.org
References: <20250115142300.vlupsqd2lr5bipfo@martin-pc>
Content-Language: en-US
In-Reply-To: <20250115142300.vlupsqd2lr5bipfo@martin-pc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::11) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10284:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a0faef-894b-4bee-1975-08dd3a55b30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXByalE5cy90SXV0Wk5LaUswZ0FaSWRqRk5WbG5kdEhVR3dMQnhVd3FRd3Zt?=
 =?utf-8?B?YTh4UVZ6ZVJaWXp6Wnhwc2FxYXpxWmNYQ1NxYVdDR3UzdFBtKzJhdUIwVkUz?=
 =?utf-8?B?dXd1UlcrR2hYMHJJWUJ5eWlDUlE2MlI3OXJGRnN6Q1BRWFB6KzlGYUtNaXFZ?=
 =?utf-8?B?dTUzUlRqUVpoSmQ2dU1rQ2JFYjdrZnlINWIzUFcyZ0d5TmpnMTNtN20wc0JG?=
 =?utf-8?B?TUswaUU0NjlTRDZORi81U29ycWFwSFkvcVFNZDhsOWxyekJTR0owbTdHNXNF?=
 =?utf-8?B?eHJ4bDVCQStaZHVmOEVwWlVPYkQ2ZW95ajBCcVFaamJMOFNyN3NGZGw2T3dr?=
 =?utf-8?B?NGVmU0FrRUorZWEzWEw1TzVRZHRWa3FXYXNhTy83UVlTVWRsUy82QjRabkpp?=
 =?utf-8?B?WC9HSGkvazJ6aUs5NlVubE5ycFM3cEl4WUM4UDF4UzdFczAydWs4Y1NlYVhu?=
 =?utf-8?B?WnhzV29jc0xBTXlsL3JOanJZNEwxaTM0Y09rOGIzNlRDSHdGWTBoN0czQ3Fn?=
 =?utf-8?B?STJRaWlEemNiQU44V1h4eGhyV0trTW9jK3FISGtENldyakZYUTV3bFh3aUt5?=
 =?utf-8?B?QjRjWDhLbU1wTHNoeitBY2ZNbkFsbW5HUHFuUzVjTFZNL1l4dlQ2OWFFeU0z?=
 =?utf-8?B?ZFlKSktMeW9udWlFdmpZNThmMVNBTzRBS0VGaGhsK2t3c1M4Sm0yTUo0b3o4?=
 =?utf-8?B?S3JKQUxqMWtuYVJTYlFFalFlZnRWcjRNa3diWWVWTEFBa2JyNldNZnFjT2l4?=
 =?utf-8?B?RjdDa2ozYllDRCtOV20yRXhGanhFcnc2WG5JZS85UmVlelVrM0FSN3doK1N4?=
 =?utf-8?B?RnVyaUd4K1hkeVJ0c21WcnFWaURHa0xIUS9pWThHeWkwclE5OXVZbzRFOHFK?=
 =?utf-8?B?Y2FjUGo2T0Y5WEl0NDBHdVQ5VzM3eUNETmtjNUZWN1d2TGRwWitrOUNFamJH?=
 =?utf-8?B?NCtJM0ZnbXZvMk9mWDRmM3E5Z2Y1MmV0RmJSblVMTlNDcDVQVmZTYkRkWnpU?=
 =?utf-8?B?Y2xPTmVIcEcweWJkQmpmY3B3Rk50dnNlZzN3S1JabDZSdDJMYmthdHdpdUdj?=
 =?utf-8?B?clZWMnpnaFdya0RuaFdGaGRmSUphdVdta1FsOEZDT0ZSaTlRNm40c2ZESXdK?=
 =?utf-8?B?eXBrRlVPcDVjRzlpVWRMNDFYZzhDYytjY0FpbFpYVVNvTlAwYklMdit6NGIz?=
 =?utf-8?B?eE9qNDZCcmwrQ3NTUDNRSmRDd2p3c3dnVUlPOWtPWlB1NzY2eFh2ZTh0MEQw?=
 =?utf-8?B?MlQzOGZIVjFaMWRzaEJNQnExUzdBTU4vV2NqSmpZMXdUbW9qSVJJSE1iYlFw?=
 =?utf-8?B?d1RrMW5MMGtlSmNKVWhZakZ5MGl5b3dBQVpQZWpDTHl6b3lPd2pkN0tLY2th?=
 =?utf-8?B?WDh3ZzMyNlI0MWVmM1EwdkIvMTA3TXFHMDVWSmFlS0E4b0twMHd6WHk5eU9O?=
 =?utf-8?B?SU16bFQ0SmF0c3ZvbGZsODVpTjZNQXVwRldvT0phZzlzcFIvT1lrV0h5SHN5?=
 =?utf-8?B?ZytidHRwNG9qRlFwUkxkSkUrMFVvVU1TU2FPOFpMMUlMcyt4eUxiTWRLc2ZY?=
 =?utf-8?B?OE92WGRQYU13YkR4Q2thVEFFdVpSemhaNGdhUDJLaEhISmJYUFB5NXlEYVRl?=
 =?utf-8?B?NTB5ck9YNFNwMnJ3ZXJ0YkdFYVBTY1V4dWl2VDZqU2xKbE9WbXE5VENLRDNP?=
 =?utf-8?B?anUwR25RZFY1ekZOb3lEL3U1Z1p0QUJieGdxSnZQNThhMkFGbXk1VjBocFJj?=
 =?utf-8?B?dWxhVWV3V2JEQk9QUTQyVndDNHdtb1RUUDlmbi90MWNUajdrNWoxdGFJNHNh?=
 =?utf-8?B?WmJMMjEra0lSSThZdXBjQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUZBWjR3N0FaV2VkMmR3eXRkOXF6Wmo2VkhheG43MVhNSkNOSEk3aHdiYkNj?=
 =?utf-8?B?aXlrNVgzeHE5dVFMTUJxTkszVzU1U0trYkRaSm9kQU5LZmk5ZXh2U2I0QjVK?=
 =?utf-8?B?VHhBSUtLenNPSlpZejBrbmNrUVcybkxrSDBWWkRQYUNTR1NBR2pMU29QeEJV?=
 =?utf-8?B?dm9wTkN1alBLTVhzUFhueWo2UzBxQXZ4c2lneTdsUWlLK2Y5eERkeUpTcDh1?=
 =?utf-8?B?WVJWUy9RcUZ1MGRta0dLNWZOamdmNkplTGJMM0d6ekxPbUpyZmF1M3BvQTRn?=
 =?utf-8?B?TVMvN25yK2FjOG9ITTRJcXZsa1A5VG54cVlJSGZVeElvWWhzbUY4S3c4UWtX?=
 =?utf-8?B?cE9BU05FT3BtVEp5RXRVWktmamVQUzZhanowSTY1dWh1NDlGYmRTTHJSbENs?=
 =?utf-8?B?TUphdkNNSjk0VEVvbGw0RUNmMTlPNUpLVUg4NTV5cjBxNGZPYTdzNkY4emQ5?=
 =?utf-8?B?UE01NjdLR1pqQmp5eHd0T3NtS1EwaVczOFVMUURXTGtLSXFRSlB6T3pmalpX?=
 =?utf-8?B?aWhDUTZPT0hTaVJmOFBoQzdBN3cwMTQvMkw3eHFDYnV2RjhlanR5OTMwMDc0?=
 =?utf-8?B?M3lIcUpQUDZNc2ZNeUhydjZuS0hhOHpidS9QT2N0SkJaOTAyYWU5Y1pzMW9X?=
 =?utf-8?B?bldhblk5K21XN3ViaHczcDdIQzE0cnpLQ0s1eFNMc3dncXc0NmEyWlhudDJC?=
 =?utf-8?B?VFMzQlRVeEVTcWJaSHA5VDFIcjZyVUZsMDB4UEczU1hPREp5SXNraFJSRXFo?=
 =?utf-8?B?eEtFMXJnVHBNaGZRL0cvNWpvcmJIbG1aMUdJdDloNThZa2NKVURwbFkwQkJk?=
 =?utf-8?B?emYvUVJTOG5Wc1IwbmVCWVNTL3VmOVIzQmtlNlViRDZrdDFaaEkzVEhYZ2xy?=
 =?utf-8?B?VU9YMHc2bTk5NUl1YUUwSUdjRHY3d1JEZi9lNGFWU2pFakdYV05lNTB2Z1h2?=
 =?utf-8?B?WmZlUGN3Z1RJZm9KNDRabDNFU09maWxERDJVYXRVTFhFS0NiUm5MZzJ4dGlP?=
 =?utf-8?B?NFVKbUoyVlRvNUswaTIvNzhZUElVWjlwVkIvTmtaWFFzT1RvWXRVeUhDQXg3?=
 =?utf-8?B?elhiazk1YVFWUndJUFEyaU9nMitDcUJwYnFXbmtralBJR3hTN0tjdmJSN20z?=
 =?utf-8?B?S1NaOFBneGkzMEFUNU9MMUs1Nk9MOXg2b040b3NVbld6bzNoN1BIcjRPZ3VF?=
 =?utf-8?B?VXE0UkZnanc1R3dxTW5JdS84N21CUGpsYXB2TERuYjByUGk5cHRyVVZKZ09h?=
 =?utf-8?B?bHBXZVNNbnpHY1Z4MVp4TENJenFNbS9RSHdYLzJCWHpSU1hkTy9BajdnUmRV?=
 =?utf-8?B?REJWSVZqaXNwVDF5RjFwRk1TaG0rMDY2VkZZbEp2YlJPbHF2SVZnNXVQNzhu?=
 =?utf-8?B?V2FmWGZsU0FpK25RbU9QUG5kZEJZOUhMTzdabGdZU2hTV2duOU5aSVp3eFkx?=
 =?utf-8?B?b25BT1JIak02RGJyenJGS2hTODMvdkJBcDQ1K2xmcGtKT3QxU1QrREhPaHR6?=
 =?utf-8?B?ZVg1RzYraTVkUGZTdnpqM0N0SE1hWGpyWEpJbHVNcWp6a2JEZ1grL3Y0bTBH?=
 =?utf-8?B?anJIelpBdENaalRDWlZ4elV1ZC96RzVEODExdi9GaFNMYUo1N3o3YjJhRHZv?=
 =?utf-8?B?YURvOGlTNFVvaG9DNUNkYkx6VlFlT2hINysrVm80N2VYd0V4ejZvTWwxMEdF?=
 =?utf-8?B?aFM0b2k5TnZKZzR6eHYrcE5ScVF0eE1lSFRjcG85d1hHaGNIYnpubjV1a3pZ?=
 =?utf-8?B?ZzBnc3ZVQ2hjSTJnWGNRbjJQUWlqTXRmWjRGZjh0M1R3RU81SlRRYTJrMHJr?=
 =?utf-8?B?bEZ6bWlNSjEvSE9GMGZUbEhacUlDTm4wUWRHOUlZWUVFWGFoc2V3SHNaSkVy?=
 =?utf-8?B?Q1YrV2Y4b2QwbnhIemlneGFXOEtnSzFzTU9TQ01WYWN2OTFpR1BwNlk5UEtt?=
 =?utf-8?B?NVhYaXNBMjllbXhsNGprdXBOYjZQcGVpV0xzcmk5NGxzaFRzRGFJSnMyTGNo?=
 =?utf-8?B?VHluV21YdWRVVTU1d2MzNVZkZ1pydUU3WnA4NnBuempkK0ZpbUVYc0UrTXB1?=
 =?utf-8?B?NWJzby9PdWJ0QlBiV0t5ZHBsMGhaNVArZXk0UXlSZ2xCNmc2NkVIVFhIM1g1?=
 =?utf-8?B?aVNYQmpiYXl4a0JGQlZvdk9OTmdmbzZjYnl0anhobXY0cHFaZVNuTk8wbjJj?=
 =?utf-8?Q?8IzE1C3Ti4nDiP0uST3RCYI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a0faef-894b-4bee-1975-08dd3a55b30c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:56:30.8233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RurHWItcmiKzQ9wEXWqiLrLcUt5h2tupSfKnSr5nASlET4gX6zQImC1emxNTueAeYKnPHxIu7ROWTWGLvRBXEBN6X50S0JW8zRMjYoQRixc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10284
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

On 2025-01-15 09:23, Martin Hicks via lttng-dev wrote:
> 
> This fixes the asoc_snd_*, kfree_skb and udp related tracepoints for the
> RHEL 9.5 distro kernel.
> 
> In all cases they've updated to the format of newer kernels.

I notice that this patch appears to be based on stable-2.13 rather
than the master branch.

I will apply it to master and forward port it to master, as the
cherry-pick seems trivial, but ideally please submit patches
against the master branch of lttng-modules in the future.

Thanks!

Mathieu

> 
> Signed-off-by: Martin Hicks <martin@sr-research.com>
> ---
>   include/instrumentation/events/asoc.h | 8 ++++++--
>   include/instrumentation/events/skb.h  | 4 +++-
>   include/instrumentation/events/udp.h  | 4 +++-
>   3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/instrumentation/events/asoc.h b/include/instrumentation/events/asoc.h
> index f6b2c76..31bedfe 100644
> --- a/include/instrumentation/events/asoc.h
> +++ b/include/instrumentation/events/asoc.h
> @@ -120,7 +120,9 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(asoc_snd_soc_preg, snd_soc_preg_read,
>   )
>   #endif
>   
> -#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,9,0))
> +#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,9,0) || \
> +    LTTNG_RHEL_KERNEL_RANGE(5,14,0,503,21,1,  5,15,0,0,0,0))
> +
>   LTTNG_TRACEPOINT_EVENT_CLASS(asoc_snd_soc_dapm_context,
>   
>   	TP_PROTO(struct snd_soc_dapm_context *dapm, int val),
> @@ -187,7 +189,9 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(asoc_snd_soc_card, snd_soc_bias_level_done,
>   )
>   #endif
>   
> -#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,9,0))
> +#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,9,0) || \
> +    LTTNG_RHEL_KERNEL_RANGE(5,14,0,503,21,1,  5,15,0,0,0,0))
> +
>   LTTNG_TRACEPOINT_EVENT_CLASS(asoc_snd_soc_dapm_basic,
>   
>   	TP_PROTO(struct snd_soc_card *card, int event),
> diff --git a/include/instrumentation/events/skb.h b/include/instrumentation/events/skb.h
> index 5556ab6..becfd80 100644
> --- a/include/instrumentation/events/skb.h
> +++ b/include/instrumentation/events/skb.h
> @@ -40,7 +40,9 @@ LTTNG_TRACEPOINT_ENUM(skb_drop_reason,
>   )
>   #endif
>   
> -#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,11,0))
> +#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,11,0) || \
> +    LTTNG_RHEL_KERNEL_RANGE(5,14,0,503,21,1,  5,15,0,0,0,0))
> +
>   LTTNG_TRACEPOINT_EVENT_MAP(kfree_skb,
>   
>   	skb_kfree,
> diff --git a/include/instrumentation/events/udp.h b/include/instrumentation/events/udp.h
> index 0a94b46..c228ef6 100644
> --- a/include/instrumentation/events/udp.h
> +++ b/include/instrumentation/events/udp.h
> @@ -9,7 +9,9 @@
>   #include <linux/udp.h>
>   #include <lttng/kernel-version.h>
>   
> -#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,10,0))
> +#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,10,0) || \
> +    LTTNG_RHEL_KERNEL_RANGE(5,14,0,503,21,1,  5,15,0,0,0,0))
> +
>   LTTNG_TRACEPOINT_ENUM(lttng_sk_family,
>   	TP_ENUM_VALUES(
>   		ctf_enum_value("AF_INET", AF_INET)

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

