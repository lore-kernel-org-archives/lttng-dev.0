Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1DAC61D85
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Nov 2023 19:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1700768966;
	bh=q+hzGdTbGq0EdgBGAmupa/W2zpYfBbwtgFBhynZ3PDo=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=RxUNfeR411xNCLWy9RFnIy8BMYrAe0JMpwiGbkhE9lP4kpBrrKic/wQd/AzHtoKO5
	 AU4H2T7mkhAe2uLIViklMheRwRba5jEAmML1kT4ev5iCfFRplp9CbZZi2ESQeZEk/8
	 LTEJRaYcVcHlD2ZjSkkqqHDu1q6SnFroUh2ZB7QrNuZ1P76E4gabNHcZ67C8bN5GNP
	 CKorTKxwA2OpwZSy1XkqI1N2V6UmmjiPOlx6hoKsfBC9cdcWLdobDT1wkcCVVn9wLO
	 QD3JBkxGoP8ZfGD4kbwDs/CGHbTBmQdSe5CGZnLnVcMo1Nj08Sj5Zb3uPMTFkCgwPZ
	 CzXwNcmv8P3YA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SbpbT5J7lzLFC;
	Thu, 23 Nov 2023 14:49:25 -0500 (EST)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2055.outbound.protection.outlook.com [40.107.116.55])
 by lists.lttng.org (Postfix) with ESMTPS id 4SbpbS1vFbzLF9
 for <lttng-dev@lists.lttng.org>; Thu, 23 Nov 2023 14:49:24 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0EMeCCUKl3zy37LBHXQ8P9yeqUR8r3nBaaqKhd309/1czZeqREgkQLvdYJJJL0H3QhogqRTdjzgKPoKBvg5EuXpmAt/ujfoqxi7gH9GPUofnRFQIDbk88uGU0CxIvu9Y+Zh4umXakFuMD3Xx/P7pSYrPDW3D/EI+qjwNo4LnBQ6q/lS0pGBx2nCFjJu8rCuQgeEXdVXtjC/NU1nM6Wtp8lggtLQVZc2xbcytZ0wFwGqcrgW1CQryEFH0g+LNutALhZuEF+0dD54l99rI8cTKxtRTo2WyHtDWVdE+zWsvwuNjutOEwTcdTLwHmcIfKBGUJ/1gAe6Lb5tINPS5K7wnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+smxWnBuwb6v6hIZlosU5z99d991vkoV5dFo3SGzLo=;
 b=SVbkgSb8OoxBcfIyOMPD2p7d/ZD/SWI23h6kxKeOKbMBujdRznDhieBVIODimpdqczh68GO3xbzrfxRAz/1E+TtDf5VYmoHGWF+Ka99V+oQplvvxFLdPPm9cxucTYh9beBN4xnS3jO9QJjC5/tGrqXvtHD/OhxHLA/sZxDJdBbRSNKoUYQ5oATsyK5bKF1xbdONcu8ojmQzcb4+nJEtRu1acmOp2bTSmA+jPwEj8SDRQhMhS3t/EcJbTKcgAFY7n9XvCSq7ZnTec00epNlOdrn8eRitOKfXeIEx3EW6B9d5seJv7XsqaU4aLluX7Q33tHJEhoDaibLUvGhftLzvoYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YQXPR01MB5518.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 19:49:21 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd5:f7d:297b:a1e8]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd5:f7d:297b:a1e8%5]) with mapi id 15.20.7025.021; Thu, 23 Nov 2023
 19:49:21 +0000
Message-ID: <2c0e2bb6-470d-45b7-af19-cbe0bd7eb280@efficios.com>
Date: Thu, 23 Nov 2023 14:49:20 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-CA, en-CA
To: bruce.ashfield@gmail.com, lttng-dev@lists.lttng.org
References: <20231123193249.3190764-1-bruce.ashfield@gmail.com>
 <20231123193249.3190764-3-bruce.ashfield@gmail.com>
In-Reply-To: <20231123193249.3190764-3-bruce.ashfield@gmail.com>
X-ClientProxiedBy: YQBPR0101CA0289.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::9) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YQXPR01MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c00446-fa42-431d-3cf0-08dbec5d499f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJzferGg00VmJA02JCCOuBQpIZAyzkt9NOYKY+ZKNwkoxFJ+/lFIc45ygG24JKa5X4UvSwjKcgXyEIqnaKAxdlpbv/EkBiQjwgZtFQjA8FPrmyORoUyjJcVVU7fP+0nVr1VopVgLCjDTbe7oWyTvyaLqF85KBxT3CcqNxQ5sCagX8KXV8eoKAGoOuVpuuFhS4kYdA9LFCxOXLBGPn7d2vea1JBapBqQOOkwmS4FG1ldBhApKawmfE5I35OVR2OOaoLCoNpVexxbgNQ+91tpLtmCLV+md7oFD8DbEQaid9F3lHnOmls9ZAno3RayDb42qsr7u8s3p0KptC42fqLcloKu8IbEJvwnYwkbUtEFZMKwR4FoTfrUYPfCpu34u2hvuBkOgI1bU3RgjWm64wV4avvTsWOW+YLY6Ql/VEfjYP7tXeJcvyAl6YBDM4oJYxFGEp3zOe4aRuX/g9K+qofhrXNNqqlmCbMDEfw/KWxCiUsblQGDgxhAvKZftJmU3yAGcoYFdujpqu7Zk/mpTqCj8bo8PTYxOOBehw0sHa7y5Vvb67bTSrN94GL6bLXjKkXLmi/j9NNwTTsa09Z81vEw4ln1cmy9uYG0lHxA45tTD2tJPb905qoJ68XvqDMrfk/W8pe6Ef84Ra4VYxs/+a8DxhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(39830400003)(366004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6506007)(53546011)(478600001)(316002)(66946007)(66476007)(31686004)(66556008)(966005)(6486002)(6512007)(8676002)(26005)(2906002)(36756003)(4001150100001)(2616005)(8936002)(31696002)(38100700002)(5660300002)(41300700001)(86362001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGc0WnVBK2kvWjFtRnFpK1llc1ZZU1d5aVU3S2ZwRVJNMVpqQ0lJNjh3dU5O?=
 =?utf-8?B?VzkvM1FrL2t6aU92SmNaNDdzamJvUk9vOE9wdkloVWdhNEt4clNEOHlubVBB?=
 =?utf-8?B?dWxpbVFiMVU2WnNCUXYrUWpZOWw2L2VBV002KzAyZlhRc1VQVFYrajJaaTNL?=
 =?utf-8?B?NVZwcUV5ZUpucjlSejRQOWpkaVNHOXF5UnRvVTFXQVdCYTlsZEJtdTRvdjZ6?=
 =?utf-8?B?T29Xa2lvSmprWlJ1TU9yWGZPdENxWDY0b1pGNlFiejc3V3AyMWpLSGhSRHJN?=
 =?utf-8?B?ZHJBTldIL2NZN201TkZZeDVBVzhkdnBJVnlSNUlabmdTUTBDS3Z0bzQ0bEZh?=
 =?utf-8?B?aFFKeWtVSDNtbEQvWWFDSnl3RmxtT2k0Y0dLWmN5d1ZnakRiaWphY3pSRXBx?=
 =?utf-8?B?L3pCa29ibmtMRlVUWVdSd1RyaTJQTjhOSFAwWnVZL3NDYTJra0I5R2ZhZXZQ?=
 =?utf-8?B?N0wvR3lqS1pwOVMwQ25qUUVZbTBKcWFUWVFlcnRaUlBQYkpTTC9JUllZWVht?=
 =?utf-8?B?YnhLRnBTaFdIN0ZrenNzREdtU21TZEFuUHorSVJpanBldG9qSWwya3gxaWs0?=
 =?utf-8?B?QVpTS1oxa3ZCZ2VvT3VMV3J0aUlVcDJ6NzNsUm8wdjVrTnZITjBtVzBrWjBN?=
 =?utf-8?B?U0RMaDI3Q09lRTdUZi8zNGpmNzI4OXZQc1RTTXJ2aWU5dkQ5T2xZbnpROVZ2?=
 =?utf-8?B?QzhZMHltNDVybzBhanFRM05oSDljaktEdzNEc3RlWUZFSnhFaVhCNXczTi9l?=
 =?utf-8?B?eHRhWHpYdDhnUlNpenVpNC9OQ3gwTGZDRWJubEdkWWRRYUdScTIvUHFsaW1E?=
 =?utf-8?B?NDc5MTg1d0krYzlKK3dySmdSZ2lWUGhjUHBnejNHTnNucjBid0U5UEQ2TTZY?=
 =?utf-8?B?NHpHdFlvUEsrdWJpR1ZQOU11RFk2TFJOZnZYOUlPYllsRmV0cXhkNkYvYWhX?=
 =?utf-8?B?WWxnN2k1d2s1aXVxMnFDdFlYNS9aNHVacHFQVXE5RlpYTHVyQ3l1UFdSVjJN?=
 =?utf-8?B?QWNlZnhjbHQrVEJweEV2UlZ2eUVPS0h0bUdoYWIzcjdzSVltZmJNYWN1M2tD?=
 =?utf-8?B?NjZ0QmhWRnpJWEJPNThncHlpV1REakw0T1BtTERKQnc5VjF5Z0RUYTc4dVNV?=
 =?utf-8?B?SEJFc1hQbXdYSGJZY241TU5yNHNvbXBWZkJwcnR6c2NxVG04dHk4ZzRzRlRB?=
 =?utf-8?B?dEwyckdvZXppVUR0Q2YzVVYzemRLWnM3c1FyVDdKTWFMM2pxOG5uVnhLRHVq?=
 =?utf-8?B?Zlhtdlh4MFZXR2JxZ1B3ZDRQdkg4bFYxOTlsSmRNSS9KNE13amRJYmVoZE1E?=
 =?utf-8?B?Qm5LdHhQTWx0LzhzZ1o2SEZweVJ1YVp2UlRKMzhRa1RUYVZDcE9ocGk3V1Rk?=
 =?utf-8?B?WUlCNVZVclBhTWZDWlJpSEtFNFhnWGZyc09QaEJLYk8yMzRzV3RQYTgwRG5J?=
 =?utf-8?B?emxKZTNlQWFqeXJ2SXJwVUFteGtVQWZ3YStkVHdMQWg0RTBPdzhZU1VQYnF2?=
 =?utf-8?B?VFFxSGJIYVgwZy9XZk9PUCticzNzZlozMVJodGhiZFFFZU9IY3lLWGNBOUY4?=
 =?utf-8?B?SjlVcklpQWRONXJ6UjZueEVDc1F6UWZqdEE5QWErYkpDb3h1NXh5NjZhTWVJ?=
 =?utf-8?B?SHUwTDcvSStXdnlzaENWOGhCWUpod0RLVGx1bXFWTlRDRVRMZ1RBMm43eExU?=
 =?utf-8?B?eG1mZ3Azc091SzdOTkxHVGpqKzFwRTR3ZjNVcWdPSm1Ycmo4Qk5Vdm9nLysw?=
 =?utf-8?B?Zmw4dDRYNXlOQzB3NGs3QjhXZ2JhaXljMHc1cGJnN1g1MW1MVjRXN2p2dXUr?=
 =?utf-8?B?SnZZeGRhb3hVSEFsZkIrWjV1SURwekJzUlpyMk8wZTBUNHFzUlZiVlh4eTBG?=
 =?utf-8?B?L2k0MTZrcmdwMUlnWDU4OG9Ia21mVGp0WGdjNkNHcU12VFpKbVIycnpLcU11?=
 =?utf-8?B?MXFkcEJlS3k5aG1GT2MyNHVNQ3k4cTNVWm9jSllyNEN2bm5LbWVmY1MxeEZk?=
 =?utf-8?B?cFFFa3dMRjhhdU9QVjkva0Y0MTJwN0tpekVlN1JwL0hSaEhMMnZueUU5QXJ4?=
 =?utf-8?B?Mis2Wjc0M0R3UjVzR0c2dEVZemtNOTUwazRnZWRuazlGSVZSM0xwTmVhdzJ3?=
 =?utf-8?B?UFlidG1SZEV2dUZoaC83Y29wdmMxbGdNVWc3UG1DNEt5bjJoYkFBQ005ZkU3?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c00446-fa42-431d-3cf0-08dbec5d499f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 19:49:21.5723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Zd4MgvWBMTv9T2pEzThxX31xo5Y5QYVVppI7MUPZz9gxidhvkkhDU2KahJtIEYNWeamv1bcXwMGSP4ab9IYCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5518
Subject: Re: [lttng-dev] [PATCH 3/3] vmscan: drop isolate_mode (v6.7+)
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Bruce,

thanks for the patches! There's a similar series waiting for review: 
https://review.lttng.org/q/topic:%22fix-linux-6.7.0-rc1%22

thanks,
kienan

On 2023-11-23 14:32, Bruce Ashfield via lttng-dev wrote:
> From: Bruce Ashfield <bruce.ashfield@gmail.com>
> 
> commit 3dfbb555c98ac55b9 [mm, vmscan: remove ISOLATE_UNMAPPED]
> makes the isolate_mode parameter unused, so it is removed.
> 
> This updates the event to match.
> 
> Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
> ---
> 
> Repeating the comment from patch 1 & 2 of this series:
> 
> Someone else may or may not already have this in flight,
> but I didn't see anything on the list or in the git
> repo.
> 
> I ran into this failure when working on the v6.7-rc
> kernel as part of yocto project kernel updates.
> 
> Tweak as necessary, as I'm no expert in the right way
> to version these sort of changes.
> 
> Bruce
> 
>   include/instrumentation/events/mm_vmscan.h | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/instrumentation/events/mm_vmscan.h b/include/instrumentation/events/mm_vmscan.h
> index e7e9b613..a3e9ddf2 100644
> --- a/include/instrumentation/events/mm_vmscan.h
> +++ b/include/instrumentation/events/mm_vmscan.h
> @@ -343,12 +343,18 @@ LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_isolate,
>   		unsigned long nr_scanned,
>   		unsigned long nr_skipped,
>   		unsigned long nr_taken,
> +#if (LTTNG_LINUX_VERSION_CODE < LTTNG_KERNEL_VERSION(6,7,0))
>   		isolate_mode_t isolate_mode,
> +#endif
>   		int lru
>   	),
>   
>   	TP_ARGS(classzone_idx, order, nr_requested, nr_scanned, nr_skipped,
> -		nr_taken, isolate_mode, lru
> +		nr_taken,
> +#if (LTTNG_LINUX_VERSION_CODE < LTTNG_KERNEL_VERSION(6,7,0))
> +		isolate_mode,
> +#endif
> +		lru
>   	),
>   
>   	TP_FIELDS(
> @@ -358,7 +364,9 @@ LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_isolate,
>   		ctf_integer(unsigned long, nr_scanned, nr_scanned)
>   		ctf_integer(unsigned long, nr_skipped, nr_skipped)
>   		ctf_integer(unsigned long, nr_taken, nr_taken)
> +#if (LTTNG_LINUX_VERSION_CODE < LTTNG_KERNEL_VERSION(6,7,0))
>   		ctf_integer(isolate_mode_t, isolate_mode, isolate_mode)
> +#endif
>   		ctf_integer(int, lru, lru)
>   	)
>   )
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
