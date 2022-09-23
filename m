Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B28EECAAD8
	for <lttng-dev@archiver.kernel.org>; Fri, 23 Sep 2022 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1663948373;
	bh=oekWLX3ORTxyCwkl9upg3ZETaG1PAoBNlh+O3aQUuOc=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=EB9VRh+jO/+JqTjdsRfqniz5AKYxt12Zn5RzT9opHB1JEtunvvn5IaGgpP3e3OLgP
	 1e4g7k93+EkRLNJ2LjfZZ+U3rtLC6bd57vUcfeHhOqFaWywieYx3/XBRryFnCvbTH0
	 bLCPN0tUc1oOT6aj7Qsb7ceINHSFQy4l4gbg3MMkJw89948GbL2gJK75tBDxBkvFQj
	 gEJGLYky6tPFUWNm2S1CYrae9++hxEuEcg28i2QqG/ph3pATW7Uv68LjDuU1Mjq34D
	 baWKyTPHiES9BH8fnTQ7jUxO9gIVXjwL73nYu0y/ldJvcboVOjCQC3ORsZP7a4wavl
	 SZWN1yqIg2JSw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MYxW8687Bz24Nc;
	Fri, 23 Sep 2022 11:52:52 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2079.outbound.protection.outlook.com [40.107.116.79])
 by lists.lttng.org (Postfix) with ESMTPS id 4MYxW66797z244L
 for <lttng-dev@lists.lttng.org>; Fri, 23 Sep 2022 11:52:50 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDcBiAm6BXsl3+RXuMUgL8eGECtMW89CE7My1HHHkzDRvUpC6Ta9xpjkf8YUv9p3JDx7e4XFWGonXAbd33ct4urXRLuEBDmeU66B5LveZOAwYB+BcEys9jQ0xT/iiSKrXuUFQe5LG/jIxOWsGDH9SWeXC2iSBIupqdrimjGuhMawg2RvhzLej1TJ79ptrAppAy9RZM/Le4KPtLxzynzEYkB00h3kFwnDISITAOtnExHM76FrTGkqz57M+9bye7k/8MXIH4Cimu6Uuc5uHNFcgE0JPPXrJSsZch/4wqIY7bpd2jiaq1rpfmW2DSGkukf6/GKifkILKf+73xFZmAOvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52Nf56Eid8xna5VX26CHzi/SnNyp97uJjuKxDNP/oc4=;
 b=GP7O+9I58pxcc8hnjHVCJCsjNnCvl//by7T4bs3FBwuvI4il1z59+FDQjNd9k+aiW59o33IJVQMq6U+uvUI36lYH7Q8dYCB2u86xuAoW6zzLKTNy8LbUxK4pyKDjzDlNE8r6bz1oq4AeiQU3Dki2mhtQQsjF6ANgiAjOR41waS9QZAoA0f6MnJIoER8Fo+x6QpIIodPeocyIFTfZvUS1+HkxWuyJOH9+BVjRdYT6pg3pbQ70D+nPbvFCSp7r8AfyxBzHt1PiXqCG9l0AxC9m+mONVvxWr1CblwRllhchlbuMEdaxUqjq6A0eCRqKe4pou3LCtpw1lA+MYTC2HszcMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB6141.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 15:52:48 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 15:52:48 +0000
Message-ID: <9c056277-64f2-43a9-1816-f3556c2a76e6@efficios.com>
Date: Fri, 23 Sep 2022 11:53:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: Rouven Czerwinski <r.czerwinski@pengutronix.de>, lttng-dev@lists.lttng.org
References: <20220908082523.906444-1-r.czerwinski@pengutronix.de>
In-Reply-To: <20220908082523.906444-1-r.czerwinski@pengutronix.de>
X-ClientProxiedBy: YQBPR0101CA0217.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::28) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc0117c-a231-40eb-67af-08da9d7baa27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0SspkROFvhRN5CMNfqpVk8i8tes9DDgdPEl9uv5Efq8+0sCaTZ1aS4bqZHF/rbrvUOHfufPqWQbBmaJp0yNyOFxUwQkx9BAVAF0FHL4WdrnF1gmg0tlKtTgvO6p552a4cAuBnPPLUhQiuC+k1H8JMJ/pZUEgzTIzpiv4eJUTt2EIT588gHoISOu8dczma4i9r+1uqoTjDMNVEH6Njc1DbL+zG5GSALqcqGOus7bt+MPNhKptLdkIh6jFjlwMbKFP8wZaIRWp8cu7Z8Ch892OPil91SBD/sQ5G8HNrxYM9+R3OaaPsODqXkKmbEqmIZ3sXxF8FgLqInz+K8eYcQGSgISL8SfIu9N0o/SSWCuzcbsFmC0J/HPN22cw3/i1Hyci/z+Ri1mBbE6aenbdHsSFRp8tc2/jE79Ys9oJ0VFbtOL9hfjdtbQhE/bzZgc8QPS4IMrNzhfmbfRGZW/scc3WIu7TZFnzR4cL8YCcMxYFpe/cYmvN9Yii/OuoAaxONiyIyAVxHzsqm5eQ36205a+SisIWJXP4WVwMj2tMb9vG+jTds5kYj/Y2zsljRYX2PtjPBoajjhCk72P6WZCABu80LxVHpW8OQhmxLAk0FbnXac6mbWK07eTnmmKPzBLYTRqi7oMEKOUqjY50qhG7WxfkXthRIphIaNwxzOT7SQZTwn0WEQ84CI3s2SOh8TSUg7emliar8uWRwW3lAB2O/jVTTihY2OmjjFO1D2SrPwNQQSfCggtoLi0ulEszcyXsrEATkDoMH9fomKc0aFxS10LiijNoBKWPg1PX7CgCZr9oIhO09+3G7GTwT35P0KstIxf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(34096005)(34036004)(346002)(136003)(39830400003)(366004)(396003)(376002)(451199015)(31696002)(86362001)(31686004)(26005)(41300700001)(5660300002)(53546011)(38610400001)(186003)(2616005)(2906002)(498600001)(38100700002)(41320700001)(44832011)(8676002)(586005)(966005)(6486002)(83380400001)(66556008)(66946007)(66476007)(6512007)(6666004)(6506007)(8936002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmVYMTNXZ09rTXRUM2pLN0ovQ1JmZEJLcDI2RTYxVURZYVo0R1BXVjUyekNF?=
 =?utf-8?B?Uk4xb0tLVlk0QUU5Q09xc3JmdWxHWmtUNFdsaHJUNVBSaTMrYUlKRzdaZGlM?=
 =?utf-8?B?MEN0TGhJbjRHWWdEYnlnTVZWbFd4VTZZS2RZVEJVT05UT0l6eUtQdHU1bWhu?=
 =?utf-8?B?QUlJQjB4T01nUmNFU3E5Q2hub0ZLeDRKZnAyV3d3VTNZUWhYdHZkcXFWSjJl?=
 =?utf-8?B?S0N6Z0taUXdDcnk4NEpNa0VpQVl6SW5lTDJpSXYvbmQ3M0M4NFp4eTRiRHJh?=
 =?utf-8?B?UGdQL2FaNnhCMUJma2hjM04yZHZBU3kyZEJ4Rzk3VE5LTXJ0aFArRkRzaWds?=
 =?utf-8?B?ZUNCbzFYQnJCSzRkR2pSQkVSK2kraFk5V0xzcHpRZGdjcUR1c0lnZlcxdHNK?=
 =?utf-8?B?L1NSQzE5Vmh3dHB0T2JNVSt2NHRHbE5qNURINlFOVUNSYS9LYkxHanFqdGVU?=
 =?utf-8?B?UUlWeEhqZmN3cVI2T1E0WXZLRUNWQjJoNHNGWDhWMXhybjFYSDBET2pVaWp2?=
 =?utf-8?B?RGZweHJoeXJmZHRVa0d3RlR4UngxWmoydi9LdU1FTWQ4YlF3S25VVENEc01S?=
 =?utf-8?B?YTdOS1ZWZDhVdTdPUCtRUWpjME14ZVg0Vkx5a0pXVHYweUFFdFUxTHVJOExL?=
 =?utf-8?B?TkZtS3QxSXlON2hqbUw5ZFpaVEJsa0NmMTJXUzFmb3ppNlY1WVJkRVBERVZK?=
 =?utf-8?B?bXJ5NVlRNTY2bVJOV0E0MDRmMEVJdHdvQnlBNFBaUkRqWVdBSDJlSm5YUkJw?=
 =?utf-8?B?bDJHMnpFZ2FzRmNWcHY1UkVwUmhjN1FLc0M0YVZuY0JDQ3RMeXBEQkVobU5E?=
 =?utf-8?B?SDBZU0gwNjlOT1ZOYkRWNU1qcTdTU3NtQU5Oa1I2YURnajlWY3BPSklaMjUy?=
 =?utf-8?B?V05uWFZjQjRjblNkMWJZSE96OWVNWVRKSjFhWkFKeGIyb2RIY3ZDVnZBSEQx?=
 =?utf-8?B?NDlFS2RsZW5wamtvbWd4dHhjbVFoYWZpQVc4NGkwbzlHbkdFL0U3VERBWjQ4?=
 =?utf-8?B?dkl1TEpXVEpLQUdUL1gvUC81YjFSdkVob2ZmTVJKSmN1SXVtakVUWGRXbUxN?=
 =?utf-8?B?TXhmSVptS0l5U2hXTldHc3NaeGI3MmlMeFlsM3NiSnJpUGY4VTVXWmhsMCsx?=
 =?utf-8?B?d1lmYTRMV2JrTWlvNFNYd2xXOFlabGF3eDNWTTBCZFRlR2E4UDRIOGRzTS9B?=
 =?utf-8?B?S1NXMHpWNkhDTjBLeHVvcHJnVkVrdzVibjVNeEs3N3VvYmVGcVRoNktRcjV3?=
 =?utf-8?B?WSt6cGtWK0V2enpUbSt1T0VBRVpPUFpkS3hpaVdRMUthZ0JTRVMwUHVKUTJI?=
 =?utf-8?B?U3VNK1FvM0NZMFpvUTZUaXFkUkRncDM3UitYdzRTM0xiU2pVcStGL3NVT2Qz?=
 =?utf-8?B?cGJINlFDVkdCUExvc2RoeW92ZTl0V2xseHBFMWdMYnEvSjkrTVZWdDI3OFBK?=
 =?utf-8?B?cHpJRVFaVE83NWpldExCVEVENWw1MWVjeFpzZXd2bzA2dFM3UEU3RGlhQ2wz?=
 =?utf-8?B?NVZiMVlNL1hERGc3TzJtejYvczBHN2tiZWxQbmhjSkxWbzZaR0dTaEUxWUZT?=
 =?utf-8?B?YlVtSHpTRFk5cWxEd0h5ekgzL3dKUmJlSnVsRGI4SGFsRjFtWVdnaVd5ZXN3?=
 =?utf-8?B?TzkycnVPSjY4QkJPREtrK2RqczFidFNvWkdwMHJFWjAwcUZTVUtqZUxSZnJQ?=
 =?utf-8?B?QmUzemh0YUJXZThtWFlGRkV2Tm9vWEQ1WmhrakwzVkJvdzBMSVRmT1hnbk0v?=
 =?utf-8?B?dGZRUitLenVvM2U3WUpvY0FsS0FhbXN1aTFkVmxnMkFINFc5WGRNTDFhZGZG?=
 =?utf-8?B?Q1Q0YnQ2dDAwNy8wWHpaeFJPUDJhQlRqNkxKNitPQXdJUUgySVViMjdYZFpD?=
 =?utf-8?B?eWxPQ0tyUlBqeDJZc1hmU28xQ1g4VXFINGhTS3BsbzhpRlB0QVg4bDlLalN2?=
 =?utf-8?B?QU9kV2wvMi9iU0xNZHkyQWpIczYwYUdUYS9YZ29pWGhkWUtYWFFRVHJhQ2NT?=
 =?utf-8?B?ZGU5bmtSZkJndTl4RXF5M2pybVdNYVVqQkRzOUpOdDRJczlwZWRQOGZHdGVu?=
 =?utf-8?B?ODBDSEJVZjQ2Q2dsVVhtelhrbTZCVnpaZUQwRU8xWWc2d0RGUDV1SVlUYW56?=
 =?utf-8?B?ZGdWay9oWTY0OWtnVDNJMTc5WC9FaGFkUWhwVGV1Tjl3QWhnZzRvajl2MllP?=
 =?utf-8?Q?vP3CNYQ4Q411XbXf1ia0FZE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc0117c-a231-40eb-67af-08da9d7baa27
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 15:52:48.8531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAcM78IUKPixQZR/8qAdbIpX/HzHqMor5DmxRoIBETA0IEj7BTiU7eW+lsCWDF1e5EzMQN8MjkF+rfaUr//YB1nGoPFV7zXnY1/RtfO69WQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6141
Subject: Re: [lttng-dev] [PATCH lttng-modules] Add new tracepoints for
 drm_scheduler
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

On 2022-09-08 04:25, Rouven Czerwinski via lttng-dev wrote:
> Allows usage of the drm_gpu_scheduler tracepoints within lttng.
> 
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> ---
>   .../events/drm_gpu_scheduler.h                | 63 +++++++++++++++++++

[...]

> diff --git a/src/probes/Kbuild b/src/probes/Kbuild
> index 7597389b..2846b0c7 100644
> --- a/src/probes/Kbuild
> +++ b/src/probes/Kbuild
> @@ -104,6 +104,13 @@ ifneq ($(CONFIG_DMA_SHARED_BUFFER),)
>         echo "lttng-probe-dma-fence.o" ; fi;)
>   endif # CONFIG_DMA_SHARED_BUFFER
>   
> +ifneq ($(CONFIG_DRM_SCHED),)
> +  obj-$(CONFIG_LTTNG) += $(shell \
> +    if [ $(VERSION) -ge 5 \
> +       -o \( $VERSION -eq 4 -a $(PATCHLEVEL) -ge 16 \) ] ; then \
> +      echo "lttng-probe-drm-sched.o" ; fi;)
> +endif # CONFIG_DRM_SCHED
> +
>   ifneq ($(CONFIG_BLOCK),)
>     # need blk_cmd_buf_len
>     ifneq ($(CONFIG_EVENT_TRACING),)
> diff --git a/src/probes/lttng-probe-drm-sched.c b/src/probes/lttng-probe-drm-sched.c
> new file mode 100644
> index 00000000..fe8f9cb2
> --- /dev/null
> +++ b/src/probes/lttng-probe-drm-sched.c
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only or LGPL-2.1-only)
> + *
> + * probes/lttng-probe-drm-sched.c
> + *
> + * LTTng drm-sched probes.
> + *
> + * Copyright (C) 2022 Pengutronix, Rouven Czerwinski <entwicklung@pengutronix.de>
> + */
> +#include <drm/gpu_scheduler.h>
> +

This patch is missing an important piece here, see similar situation for regmap:

/*
  * Create the tracepoint static inlines from the kernel to validate that our
  * trace event macros match the kernel we run on.
  */
#include <../../drivers/base/regmap/trace.h>

and its associated checks in Kbuild:

ifneq ($(CONFIG_REGMAP),)
   regmap_dep_4_1 = $(srctree)/drivers/base/regmap/trace.h
   ifneq ($(wildcard $(regmap_dep_4_1)),)
     obj-$(CONFIG_LTTNG) += lttng-probe-regmap.o
   else
     $(warning File $(regmap_dep_4_1) not found. Probe "regmap" is disabled. Need Linux 4.1+ kernel source tree to enable it.)
   endif # $(wildcard $(regmap_dep_4_1)),
endif # CONFIG_REGMAP

This is required to validate that the tracepoint signature we build
against indeed matches the types expected by the tracepoint probe
callbacks.

Unfortunately, the drm-sched instrumentation is located in
drivers/gpu/drm/scheduler/gpu_scheduler_trace.h which is not
available with installed kernel headers. So we really need
access to the kernel sources to validate this signature.

If we don't validate this at compile-time, this can generate
kernel modules that will crash the kernel at runtime if the
tracepoint signature changes in future kernels. This is something
that is not acceptable.

Thanks,

Mathieu


> +/*
> + * Create LTTng tracepoint probes.
> + */
> +#define LTTNG_PACKAGE_BUILD
> +#define CREATE_TRACE_POINTS
> +#define TRACE_INCLUDE_PATH instrumentation/events
> +
> +#include <instrumentation/events/drm_gpu_scheduler.h>
> +
> +MODULE_LICENSE("GPL and additional rights");
> +MODULE_AUTHOR("Rouven Czerwinski <r.czerwinski@pengutronix.de>");
> +MODULE_DESCRIPTION("LTTng drm-gpu-scheduler probes");
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
