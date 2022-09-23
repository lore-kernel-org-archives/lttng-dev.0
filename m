Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0541CC6FA82
	for <lttng-dev@archiver.kernel.org>; Fri, 23 Sep 2022 15:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1663947940;
	bh=oMKLSUfsbKDvw2OH3Mk5hOqtw/MqzTincg18U+N87Lo=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=a9k8F1f8eAuxaW8+xGIbEtsIiwsIaGOwQZJM12RcTDYf+aR0I83bkIQBGe6u9QRhH
	 cnBF2Tt85PhePyfBGQacLZt3PXTjdu5brktD6Zr5nkaFP5XzK3WOohj9UPo+PGzb+K
	 E2r6+ycfwcGho+zu6pE7B9TI6gtBdYymrVA/uYKRQw6PEYkl2x6PF5zvayW1P5T4dH
	 s88/hKdGA1rlf2bEOcUGYDh6KwWaMs+GWX+Ws5He4Uy2cY2pK7OBvwWtOD6lpkt3Iw
	 2S24sBWLPTUdV6y/gdcG0s5CerZu0+ZfLsEqzfLsQoyB02HVE7GqYU7VrQShR7I59v
	 Zs3pEPl6Vzwsw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MYxLq6wckz24Hw;
	Fri, 23 Sep 2022 11:45:39 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2066.outbound.protection.outlook.com [40.107.116.66])
 by lists.lttng.org (Postfix) with ESMTPS id 4MYxLq0P3Zz244H
 for <lttng-dev@lists.lttng.org>; Fri, 23 Sep 2022 11:45:38 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le+qIwpC8Y6zWbqrR4s2EN2o3nTRCa0wCOyUBnpxd+eRBnB9Q/VwQWvb9cNUc6x+/5cvY5czlaOd1OGRpeMib1CiaHsNIrrTcVp/D4Cq0pwDtk3OUrQon8zpBYx1/zQRQ3MnP2dlKenqjAFn5klkRbDRHp0k0y6UN0gNILcN+1Y7iF1YFpVrrXi1HVZZ6bhDUQzalN7zeUU77Vf67/lRtWT/IOV5XpQt+6Ur1I+/Av9/tN696wQ+CoWwav30dqg2JA1l27CYbpDbRNfhv3ovpDi5nxKRwoKoI78ewtGmDjkOTQ4m4hCxlyOOEHIlkC8HePoQ6d+S4nO/TKPEanPb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwvK7bP7ec2XAcz5spbp99v+qeFsl7um7OUDl2uAHP0=;
 b=ngQ4yUTLvjoffpx3cogq7yV9kYcjngIL7Q6vSIwEjHzoD1Hrr3rtxSif2vcpoMtxFXfqeUqOvdJpNaje2O0VjSo15ZAxgYnBUpatn8i9gRXz1zvsNSea0BcUqtKqvIjOJsNvXe70UDS/c5wRp3BgIT47D6+cgccL3XAN5v3l72bfmW6+0JGNysiWsJbD6iZ7bVdxLjdgYKcvGifc4m21+MUEUjbCSP5salQSgIEhHBR8/hEnbCVwlsZEPa0SjCBDPZB48hXr+9+FpHALjPiEupqbZVu01WzVM0tOtQrS0hPzAx/EqPKzzLPTkWuRFnRiB5oy0ysJBCLNhvNmhU4BEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6623.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 15:45:37 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 15:45:37 +0000
Message-ID: <2647bf8d-19fb-93fb-f603-e5e37843917e@efficios.com>
Date: Fri, 23 Sep 2022 11:46:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: Rouven Czerwinski <r.czerwinski@pengutronix.de>, lttng-dev@lists.lttng.org
References: <20220908082351.906021-1-r.czerwinski@pengutronix.de>
In-Reply-To: <20220908082351.906021-1-r.czerwinski@pengutronix.de>
X-ClientProxiedBy: YQBPR0101CA0243.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::24) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fd105f-dfbe-4cf6-876b-08da9d7aa903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xe9mmd3yIF8CwlQApOr+U4Ui482/FyKj7W+P37OEOjjJXeZyVlH689nEn5Arnw57DLfkBcVvqHg/X368KKj3y4fhdSf7UqOESTriYHCyeiah0u2EBwK5FZFQMsS2KYOOGyVVl3ny2c1OOKF8D3HGB1eM3xVaphDZkMZk2vE49rPIWP5L2+VRgPQ+dKHgfgy5uB7sGKbYEs2XC2IDGqnAoha6m5qOrkOBXnxbRrQH7qrh3Bf2p8P2EcTc1+9TVntU+8b73L5jE8bKJtWh/FO9u17PN+klFFNTpbH+W+8GaiW4D8WP8Nb8I2dGbLLO4O7Xylm11CiyZOWUyF3x3IAew65tNlhsdN4OTqg0LsGF84t7l9H66hGsq+WvKjodTGK4kS9rPBWV/spGgct9Tn29Xm8bIDh0bSAU0aGMLx9J1usVoQV9xlU5A9DwCsAohQfXsWvwQ6Mp5Q6ZQ0YOWTwdtSLMeQ6MUDHvyig3luZIJCXtF9FBH/39JkMUw36938+l3aqv4k1TiXFfvc/RlfF0KkMuiO17HFICnhbu8iUsPqIEnNwrvw2UymGdYEotC8QUuX/h8GwWd3WqDPDepWpxl+IDwPRs2op8UwPLROziE9A4iD4EyKCyvN50x5ED0DuXaGYJxo4ErjHwfSMdoZIoFGr48yId8fgi631DmsyW4t34C2CsyhPrPjAaq7SOr+HQTld5SvBzqOn4EQ8YouOybGQXk81ByTh9uXONUKJPYeKUuGMpXKDPd1tpkLtKZD8/srrX0bVZ+10xBnBPN7INGyGSe4x5gB8hLLJKob3U/ytV7dKq1x0Teuu3jG4m59ay
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(366004)(34036004)(39830400003)(396003)(136003)(346002)(376002)(34096005)(451199015)(31686004)(2616005)(186003)(2906002)(966005)(586005)(6486002)(41300700001)(38100700002)(38610400001)(31696002)(86362001)(6506007)(36756003)(498600001)(66946007)(6666004)(66556008)(66476007)(8676002)(44832011)(53546011)(5660300002)(41320700001)(8936002)(26005)(6512007)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTNUeUpQcEsvNjZvUEt0K0VmSzkrU2RiVGtnOGV4YnQ0SWVIdlJxdGErMHdh?=
 =?utf-8?B?amxEZzdPQ2g5c010dnJWL0xyV3dRb0g0amtmM0RkVXRpVmFBSjJCVThZekQy?=
 =?utf-8?B?dnVqR3gyM2RkYU5GNzZmUWsvTUtlaHh0QkRFWlNjREVWNjQ5dFVYT05KYTEw?=
 =?utf-8?B?eUJ2SHVDWHdla3Y0Yi81ZmoxTXhCMmQ0dUZKZ1pjR2lYY2hTcDV4Y3NDb2xO?=
 =?utf-8?B?ZVJUNzNuTVgxZXN1NWhlMmFBZUVSaHFZUjFOTjArRHhJQnlrVFNCc0hZditN?=
 =?utf-8?B?WWNDVHZSOG95QzlqVjZyMi9vMCtMMUJXT1UzMUV0OERUVEN6Uk13RGxGd1Ju?=
 =?utf-8?B?TkVzZXNQbDhRTEc1UkthSlFmSmxxRWlZQ0xxVUNRNERvbnJqT0YrSHlkdTky?=
 =?utf-8?B?dktwQzJ2eDd0TlhPL0tkUVVHd3hmNVNPQ0lBbmR6WTV3cTkvL096dXh1eE15?=
 =?utf-8?B?ekt5OUxMbk03eXdXMmY4aFBZMW9jU0psZ2c1QW5OVE5MN1VMK1d5N2dLeXBy?=
 =?utf-8?B?ZGNLVGZrYi9mc3phelE2d0V1a01lMm1VdmoxTXJhVHJDSDNLNE9qRHd1ajdh?=
 =?utf-8?B?QW5odlhnUnV3ZDhwVGdyWGpwNnd3aHkwak4wbENEcGlBSEZSNnh4MGVLTXB2?=
 =?utf-8?B?ZHZ4RGtOcWZrdTF5bjlkR3dyRkJxUUkvdWUra25QekhEZ1VtOWFtR1NwSEdG?=
 =?utf-8?B?RTBBV1ZLbU9ZNkdBdVRLMFpndW9hcUx4Uk9uSkFGRFZsR3RnSjh5VHp5TjZ1?=
 =?utf-8?B?aklUSy94dHM2aEF3eDlWMWc4cXQwZjg4WitqQVpIc29VZzQ5bndHdzYxRDEz?=
 =?utf-8?B?cHl3RnVmcDRwVTBHRDRGV1RTTW96ZHZLSGZkM2lxTyt4dUZHVDQ2ZkUrNktP?=
 =?utf-8?B?SGxscTZDQmFXQlo3cGJGaWJneUtpZHJPa0pPVVJoaEdiWnBFaGJIZ3prMCtS?=
 =?utf-8?B?bWp2bm5EZ2JUY1FpVkFYeU9SVUZBM2RoY01QbXZSeldRZmhnQ25uc2l3VGRG?=
 =?utf-8?B?UVFvUVN4ZTlweXFWWjFuSmdENkdtZ0U3NFVtWWVNOGVYeEliSzFHbjZZSC8r?=
 =?utf-8?B?SXU2U3J5YUh1ZE1GS1V0S0VqN0MzZjVlSDM0QlpvUWpGSXZvVWlzN0FEc0Ev?=
 =?utf-8?B?U2Q4YXdYcVI5QUJ5bHVTb28zYkxxODhZenlzcDgxWm04SlVWb3pnUHhCTEo0?=
 =?utf-8?B?Q3RiZEZRN1o2OGgyT1JBQ1o0b3pBUTNUMHdsQ1FnclVOZGliYUo4MVlGNXdh?=
 =?utf-8?B?alpvazBOOXdlM1JEL1NkNzhSOE1KNzlzRHc2eWk1cjhvZ0hDMHlMaDNNS0JH?=
 =?utf-8?B?TG02enZtQU9jNWdEYmo1TkxFWlFEejRJV1NycG1BVkx6TU5OeWhXN0p1MFZk?=
 =?utf-8?B?NnRzY3B1YVZ2VFNKWXBZS2xZUWQ1SUJoYks4ekl4V2UvU3FYYWw2SWwydGtr?=
 =?utf-8?B?ZmEzUGRSTEpHUG5ENXc0V0VQY0lUOTJEMGN4aHk0YTFMWk1tSDZWelY0TVRT?=
 =?utf-8?B?bHRSMXJCdlpGakFvNlJFalk4b1R6WW5mSjNMTzZYVzN2UERxSnp6cjVvaTlw?=
 =?utf-8?B?cDdSUzZXWHJWdFN2RUZpanFnUHRmaWpSdEdOR1Bhd1d2YjdjUlE4cXlHSUcr?=
 =?utf-8?B?SFlzd2thdnRVOVJFS1JrQjJSWjRUREdvSXpzKy9ocW15WG1Sc08zUGtlUjAy?=
 =?utf-8?B?RlFEM3ZwZ0hCbG5CZkxPVmNwcmNjR1JRNUVhUDNQSSszUHVkcVMzcVUzUGRZ?=
 =?utf-8?B?QXdpNEZncUZiYUNMdERFZUxvd1UxSCthYUl5dU5kTGZJN2ViTTZGWjNISjlo?=
 =?utf-8?B?WmpNQXhieDlBWHFTejBjSjNNTkRHdHh0eEZxYWpuNk9LRDFsMlNJa2xyVFph?=
 =?utf-8?B?U1hPejBQcmlJVTR4Q0drYWR3S0VDOXZlMCtUVGpsbGdtei9LU0pGSlhnQnpC?=
 =?utf-8?B?Sk9Cb2g3TG80OW5BcjM5bS9GdGdLL2ZtbjdvOWFIS29lYThNS3Nid2xrcGEx?=
 =?utf-8?B?YXh5TXE2ZVlLYTVMS2NLbWVBZnlmalFiWGtOSEEvNStzQ3M4MmNzWUh4bHdT?=
 =?utf-8?B?MVk5c2J3UTBRWHlCbjdSWW9kZk5jSUt5OWxmTVNoUW5nanYxTFdGY3V6RU1J?=
 =?utf-8?B?N2l6TVFKQlJHY0FiNUh1WlFsN0FRMmlQSllQejl1bHRYd1I2T0xJZU1nRXF1?=
 =?utf-8?Q?pjQxf5FKOyjop79J9Lo/ssY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fd105f-dfbe-4cf6-876b-08da9d7aa903
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 15:45:37.4727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4bErssDvkvT9vZLL6371WNyzx+uLTU7NtElt+LRW9XaEEkfvknYvuJU+5yg/0RWr/zfmcKl+omLBT/m+NYZ/ed+FTm402GIoL3dOuHnagM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6623
Subject: Re: [lttng-dev] [PATCH lttng-modules] Add new tracepoints for
 dma_fence
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-09-08 04:23, Rouven Czerwinski via lttng-dev wrote:
> Allows usage of dma_fence tracepoints from lttng.
> 

Hi Rouven,

This patch looks good. Merged into the master branch of lttng-modules.

Thanks,

Mathieu

> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> ---
>   include/instrumentation/events/dma_fence.h | 83 ++++++++++++++++++++++
>   src/probes/Kbuild                          |  7 ++
>   src/probes/lttng-probe-dma-fence.c         | 32 +++++++++
>   3 files changed, 122 insertions(+)
>   create mode 100644 include/instrumentation/events/dma_fence.h
>   create mode 100644 src/probes/lttng-probe-dma-fence.c
> 
> diff --git a/include/instrumentation/events/dma_fence.h b/include/instrumentation/events/dma_fence.h
> new file mode 100644
> index 00000000..95d94ed5
> --- /dev/null
> +++ b/include/instrumentation/events/dma_fence.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM dma_fence
> +
> +#if !defined(LTTNG_TRACE_DMA_FENCE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define LTTNG_TRACE_DMA_FENCE_H
> +
> +#include <lttng/tracepoint-event.h>
> +
> +LTTNG_TRACEPOINT_EVENT_CLASS(dma_fence_class,
> +
> +	TP_PROTO(struct dma_fence *fence),
> +
> +	TP_ARGS(fence),
> +
> +	TP_FIELDS(
> +		ctf_string(driver, fence->ops->get_driver_name(fence))
> +		ctf_string(timeline, fence->ops->get_timeline_name(fence))
> +		ctf_integer(unsigned int, context, fence->context)
> +		ctf_integer(unsigned int, seqno, fence->seqno)
> +	)
> +)
> +
> +LTTNG_TRACEPOINT_EVENT_INSTANCE(dma_fence_class,
> +	dma_fence_emit,
> +
> +	TP_PROTO(struct dma_fence *fence),
> +
> +	TP_ARGS(fence)
> +)
> +
> +LTTNG_TRACEPOINT_EVENT_INSTANCE(dma_fence_class,
> +	dma_fence_init,
> +
> +	TP_PROTO(struct dma_fence *fence),
> +
> +	TP_ARGS(fence)
> +)
> +
> +LTTNG_TRACEPOINT_EVENT_INSTANCE(dma_fence_class,
> +	dma_fence_destroy,
> +
> +	TP_PROTO(struct dma_fence *fence),
> +
> +	TP_ARGS(fence)
> +)
> +
> +LTTNG_TRACEPOINT_EVENT_INSTANCE(dma_fence_class,
> +	dma_fence_enable_signal,
> +
> +	TP_PROTO(struct dma_fence *fence),
> +
> +	TP_ARGS(fence)
> +)
> +
> +LTTNG_TRACEPOINT_EVENT_INSTANCE(dma_fence_class,
> +	dma_fence_signaled,
> +
> +	TP_PROTO(struct dma_fence *fence),
> +
> +	TP_ARGS(fence)
> +)
> +
> +LTTNG_TRACEPOINT_EVENT_INSTANCE(dma_fence_class,
> +	dma_fence_wait_start,
> +
> +	TP_PROTO(struct dma_fence *fence),
> +
> +	TP_ARGS(fence)
> +)
> +
> +LTTNG_TRACEPOINT_EVENT_INSTANCE(dma_fence_class,
> +	dma_fence_wait_end,
> +
> +	TP_PROTO(struct dma_fence *fence),
> +
> +	TP_ARGS(fence)
> +)
> +
> +#endif /*  LTTNG_TRACE_DMA_FENCE_H */
> +
> +/* This part must be outside protection */
> +#include <lttng/define_trace.h>
> diff --git a/src/probes/Kbuild b/src/probes/Kbuild
> index aa002534..7597389b 100644
> --- a/src/probes/Kbuild
> +++ b/src/probes/Kbuild
> @@ -97,6 +97,13 @@ endif # CONFIG_X86
>   
>   obj-$(CONFIG_LTTNG) += lttng-probe-signal.o
>   
> +ifneq ($(CONFIG_DMA_SHARED_BUFFER),)
> +  obj-$(CONFIG_LTTNG) += $(shell \
> +    if [ $(VERSION) -ge 5 \
> +       -o \( $VERSION -eq 4 -a $(PATCHLEVEL) -ge 9 \) ] ; then \
> +      echo "lttng-probe-dma-fence.o" ; fi;)
> +endif # CONFIG_DMA_SHARED_BUFFER
> +
>   ifneq ($(CONFIG_BLOCK),)
>     # need blk_cmd_buf_len
>     ifneq ($(CONFIG_EVENT_TRACING),)
> diff --git a/src/probes/lttng-probe-dma-fence.c b/src/probes/lttng-probe-dma-fence.c
> new file mode 100644
> index 00000000..a6c9cd12
> --- /dev/null
> +++ b/src/probes/lttng-probe-dma-fence.c
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only or LGPL-2.1-only)
> + *
> + * probes/lttng-probe-dma-fence.c
> + *
> + * LTTng dma-fence probes.
> + *
> + * Copyright (C) 2022 Pengutronix, Rouven Czerwinski <entwicklung@pengutronix.de>
> + */
> +
> +#include <linux/dma-fence.h>
> +/*
> + * Create the tracepoint static inlines from the kernel to validate that our
> + * trace event macros match the kernel we run on.
> + */
> +#include <trace/events/dma_fence.h>
> +
> +/*
> + * Create LTTng tracepoint probes.
> + */
> +#define LTTNG_PACKAGE_BUILD
> +#define CREATE_TRACE_POINTS
> +#define TRACE_INCLUDE_PATH instrumentation/events
> +
> +#include <instrumentation/events/dma_fence.h>
> +
> +MODULE_LICENSE("GPL and additional rights");
> +MODULE_AUTHOR("Rouven Czerwinski <r.czerwinski@pengutronix.de>");
> +MODULE_DESCRIPTION("LTTng dma-fence probes");
> +MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> +	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> +	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> +	LTTNG_MODULES_EXTRAVERSION);


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
