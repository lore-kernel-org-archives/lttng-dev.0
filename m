Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26D8C6FA82
	for <lttng-dev@archiver.kernel.org>; Fri, 23 Sep 2022 15:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1663948616;
	bh=D1pS7CDRr321JSXGmX+K5BOb9LYS47xAYxmpdxS/Jv8=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=paqxvAFFNcSDiPsgWY0zhKr9aPV2upXxBVc6iBpq7a2zxlSwwdZzfp397KFSH4ByM
	 OqV9OTzPLQe5Cg8LkNCGtmsIgDneatz/jvYwMIikPqCL415br5fF2cjntXlNxALX6b
	 R58onDxXmRz/t3nTIZGHiBz4GCT/S1e0QttHbP19lnM/ywe6SrUPEkyubTnrloE+V1
	 N9K+hX0mhX0JykrwK5cKRoBMSpfqqLtOvtw87yg9GUbhcLgGAx781t5/pUjVkymq4S
	 MkQVNL5p2xZ1m6R2gaIQ6cM6F5a8DfIuniYJQdidQ196jrV5uP0cTubyFn2McN2zkt
	 vucfOCXqpbKTw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MYxbr6SQ6z24CV;
	Fri, 23 Sep 2022 11:56:56 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2071.outbound.protection.outlook.com [40.107.115.71])
 by lists.lttng.org (Postfix) with ESMTPS id 4MYxbq1Wcjz24CS
 for <lttng-dev@lists.lttng.org>; Fri, 23 Sep 2022 11:56:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuCuxGXcyqtNRu4eQT6I1+fbh6+Hwfm0KqD2GP7I1i+jCsJ2ZNXjsH4+m9FifQAFAHPJjgq4GUw6bU3m7bq1MvmNvsY6U6mgfoPxBgGEjUnI2A90+ycaKas48/zsZnuuzLi/eQ2QY61IjHZSk/A7IG+7WtPGjjJ8sAQisU7atX0HhO751gY3Kof083A5Cn8SIu/+zAWGJKC25lL+048z/yRS4vDzFlDm8Tf/R4UPDw7qgHuhbIw0hJJWDbY0VAdx/T9kMy7HndhL93gc4bPLLc3bHW3ZDs3d40t3CoYQ6R/ZmjBPWZVSvNKFeCU8MLkvddWwNn5GxmH0CS9ksf6HiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GDwBmM+9srxBPLucqjW5Ru5PD8gY7+XOLDEOjno7cQ=;
 b=E8kEy1fZOBUrOvd4y675TMTru5GDUT46NY+OjNONBNTMiOrDa+qdMsr/m5kRZWissmFtYrUpQmLSOX/FdCPn8+P2c5GM/TU2yQBoT/R+zpJvRMopkNmgYVm0fBzWPP4LFeq231pDIhsgcigI0oj28J8pF5r3QXRC5q6SPpqfzF8ZWk1c1CNPDfWAYHPBsOMOL0/7MA3lixDZfuh4vFYz8R8rBN0cHcvIsAT67s5k0SDvxMA2ogqgEM1HuP8Mxw2YmhBBgHTRD9COoQC4pBKNTe+9TSHU1kjWuuVSHKU8bgrAP1rA8FBCm6jz/xko4QnDqz+QJ1AkOYibhEDXxVUOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8318.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 15:56:53 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 15:56:53 +0000
Message-ID: <eb0bc02c-904d-1166-ddcc-39bbece70a67@efficios.com>
Date: Fri, 23 Sep 2022 11:57:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: Eric Wong <normalperson@yhbt.net>, lttng-dev@lists.lttng.org
References: <20220922091536.GA4597@dcvr>
In-Reply-To: <20220922091536.GA4597@dcvr>
X-ClientProxiedBy: YQBPR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::34) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c43b63e-4999-4e43-1fb8-08da9d7c3c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L9tjQRWyHQmHwRjP9VlZdoFIKr7lS8B9puMJcbMX6IyxMycFx/1+40yZbmM9f7MP29ynQeAdAGTAGZtDDHSEiHA0tcvACoRHakBJfWFtTJ1de/Z/B38fVYlA+mNFdpXgfUU0lPEWco4iG2+sZNiyikwTeBdiT1VeLB0+iAhz7Kq8HKhZXEknAiWX45OKcCzqHhLxoWgn/sjWnAN9W6zd3by35QI7oJDq5LXZkf610lX17e1Rl9BvYhtuEj25C2DuZEu6tUsua/oatwZgeI6wPHiOVDEnLMs7YZzvFewVUmU/P2IelnfDGYoVHCbLOtZ2rLOHJONfNHP2Hu7inNFTHVZjKKXLYDI1La/LNeeRxwWLhe8vanbw44uXf7uzW/LKvm7Lq0132p1R5wTz65CTHCVtBF0r1764+hskWHY00IsudVaWiEFfpXet7rgKPPNkhgdXRd8PSkktWDfjpIwKwiOPC6h5JeDyIMXe2FYRP7WTl3VVPeMqeCpY+nrIZW8MAik+EhWpNpntgKR0tKWtwONZyUogUIjlFL03xLr+oT5UFjImU6KqPl/Wz4UZeux22oT2/ZzbOSM2CBY0GtU3tbvDafmQqFH/NGo0ZMPR0AQ1vp9VUGL6To8larslGhyUkDmb0Iyj+57o8RdaCVlNZl+Zja9eC4o8L/hZ4vNO/zfjyAwK8dOKzv6rqG/Rx4OeWESq7qi0n368qXefKHvR8mEG07wBBGimw7PuYRZvTxiK8c/dZp2+IZD1q6qgXKV97QP31ktOtEFxEhQp23uTUpwD7Z0BAgnKykH1ClAxCIcsT8fdn9liquriftelJw9u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(34096005)(346002)(366004)(376002)(396003)(39830400003)(34036004)(136003)(451199015)(86362001)(8936002)(38100700002)(31686004)(586005)(966005)(31696002)(2906002)(44832011)(83380400001)(53546011)(6486002)(41300700001)(66476007)(41320700001)(66556008)(38610400001)(26005)(66946007)(6506007)(6512007)(6666004)(498600001)(2616005)(5660300002)(36756003)(186003)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnUrY1hvV0RZYkc4N1NYeUtMc21xV3dzNlN6VWFtMFpLRDJZc0JJRmk2OVFC?=
 =?utf-8?B?RXdDQnJwVXRWM2tOTDFCUUdKbUdyWHlSeXhuSm1LVlIzYXR0ZTNma0QyeEhW?=
 =?utf-8?B?YUJqYWVTZE1aaGZqcThRaURRYmNmaXI0c3l6ZzRLdDlaMjA1QlkwWXhraGhx?=
 =?utf-8?B?YUM3RmpoN3VRS3cyZklRLzh0cm80VDJKaXdMQkFnS1NlZk9odzYrdVZsZTdN?=
 =?utf-8?B?bGI2Q1JOMDB1Tmw1Tm1PRERmWUk5Vzc5RE9lOWxDQ0FBM011VEJWT25aeTB3?=
 =?utf-8?B?SHBnK2VIVC9sVjRaV3VUL01kNWRqRHZ5WXV4cmE2NkZrM1Vqdmt2azV0U2Nh?=
 =?utf-8?B?UXBjSDFBOHVwSWQrcHc3QWhlVU11Vkx3YTBFT0hCVk1NVjJXeTRzVDdCdG16?=
 =?utf-8?B?eWVndkxKSnhBNHN1a0FMR3pqNmNGeHVUdXNCOGNyYnU3aUIwcWtCWEc4WHpr?=
 =?utf-8?B?RnZRbFN2b3hRVW1NWkNzMFJvR3UzWGhwcGNzNzZJd1FtS09hME51ajlhbkk5?=
 =?utf-8?B?OVlNQWhwclM1K3VuZE96WmZDNEh0QVJrbHBRUDNlam53QVdCcE9Nak1aR3lC?=
 =?utf-8?B?OVZjcTZ4Ynh0K3hpSnhHaDduTXA3dEVaS2s1aFozazlDWlozR0hQZ3dsSkNz?=
 =?utf-8?B?K29zSW1SUEVpOC9zYnRwb3ZFVzViY3J2Rnlaam9mejFIVGhUUkJTYXVVc3lL?=
 =?utf-8?B?TmZRYjdNcVdkblVOcnV2WFlCa2I4bjN3NVplL1JxNElJdUtCWnFwVU5xRmJU?=
 =?utf-8?B?ZkRNbkl5T0JSUCtjdTRpaWhUSGhsYmorM2JDTUtVZDlXRnZTaTFXRGRpZnI1?=
 =?utf-8?B?cFZtWk5GOVNrZk41YjFRWU1nTzhoYm5WbzZqd0R5VHhhU3EyLzcvMFk1MlhT?=
 =?utf-8?B?OHVxOVEwbXQzOHB6UkRPVEwxTTNlYjIwMEdTNXdwQVYydkZiVkZSVDFPVFpG?=
 =?utf-8?B?MjhnempuM3dBUlhuSkV0cmdXY2tMWnc2SE9yQjV5YjlKc0wyd3pYOGVxTHY5?=
 =?utf-8?B?LzRhRkY3T0tFVjRJTmdCWTh3L3Q5MzBtSjV0bUpjS1FXRUJWQlk0Mit3RTBh?=
 =?utf-8?B?MHlrcFBQVlFMaWtsYjVsbEtMcGY4MkJNcGpYWEh5bTZiZS9OeXh0RWZkby9E?=
 =?utf-8?B?dGY0dkloLzZUODJtZ3BpUnVGeUVZNWVUZ0tiZng1U3F0TnlVWjhOUVYraEZT?=
 =?utf-8?B?eDBrcjllam1WUUFrRmhIc2FJVDY2TitDdEEzN1JodEx2cjR0ekl0SjBaK3Y1?=
 =?utf-8?B?Q0dwMnRZVFVkNGxoSFpXVklrRTdMQWRlRGxmaDd1R0ZyZ0h6aXJXcmlGTWZJ?=
 =?utf-8?B?UzZYQUxPYUd3VUIya2NXZGJKQXNreWxJT2t1bnRhSC9qcEF2U3hERHlOSUxo?=
 =?utf-8?B?U09OaFZjYlRMZHF4RjZZM3h0TG9pMytFTnBlOW0zUG9BSjdjOUpyZUhoTmpF?=
 =?utf-8?B?cWtMb1hlRFhUNEVWSFdsMDBpZ0ZTbG9URE12WHhoM3VXaXoyNWpFem94Qm9u?=
 =?utf-8?B?M2VHeWw0bFpSUmltMUgwT2JUaVB3U3JiOEhiTTJaaW85K0FWenJSaStZNUlZ?=
 =?utf-8?B?eGtiRDZPNnlqZy9uMTBvOVpvb1RwZWVIWnp2bEJzMzRlZGk2T3lDUEowKzBW?=
 =?utf-8?B?bDY3ME9HYWt6ZUF1TVh0bzZPd1YwK0ExZHplcTVka2Rid1NqQnVPdHpjU1Vn?=
 =?utf-8?B?YjNKVjlnQVBzRDFaTTJuMzZUYmZuZmVHUWthNjUwYlZEczhhMmtDZnJYSE92?=
 =?utf-8?B?UFBpQ2xwQ2NMaXhQQ1RNeXBFcFh0a1dXKzdTQnZtV09FWXBJZ3VqdVg5c3pV?=
 =?utf-8?B?a3dCSFBhV0RWdndMandLTXh0YmNEalFUNnYzWitVQStXT2NsYjBhRFpWRCtH?=
 =?utf-8?B?Z0pFTlNSTzdxNDM5TmFBckYzdHJGSDVhR255YWFXb3FEWmVPV3czOEQ2WmRj?=
 =?utf-8?B?VG84QkVHWTBXU2tIdTB1YXBxMi9LTVF3U2NZNWdqWG5mbjFiZVI4SHMzV1V3?=
 =?utf-8?B?UStKelBnaHZ1cE1iYW4zSkgwN2tJTEdFLzVoUlowMTZ3WTRqMFVXZ2FrbXpJ?=
 =?utf-8?B?L1d4U1k5RjBIWFZYWktQOXpDTnpCajRnWlNvbjJPQzB3RDh4UGZCVWNSNkh0?=
 =?utf-8?B?RHJwczROb1I1eElQMzhkcGV2VHUxUmR2alBDejdhbWN0VlpDb013Y1B4bjJJ?=
 =?utf-8?Q?8LjWjuuErwXMFRAp0aarf3g=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c43b63e-4999-4e43-1fb8-08da9d7c3c1d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 15:56:53.7330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WAARGVmPJSGI+YhSQTqa8BpA1w7riuLUGvbY5uTVXomd3HE1xbFR2XMaV5HVGa/+rd/3c5N/UfRnLxuhRzApHzsQwQ9s5Z6CRZoFyAoNRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8318
Subject: Re: [lttng-dev] URCU background threads vs signalfd
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

On 2022-09-22 05:15, Eric Wong via lttng-dev wrote:
> Hello, I'm using urcu-bp + rculfhash + call_rcu to implement
> malloc instrumentation (via LD_PRELOAD) on an existing
> single-threaded Perl codebase which uses Linux signalfd.
> 
> signalfd depends on signals being blocked in all threads
> of the process, otherwise threads with unblocked signals
> can receive them and starve the signalfd.
> 
> While some threads in URCU do block signals (e.g. workqueue
> worker for rculfhash), the call_rcu thread and rculfhash
> partition_resize_helper threads do not...
> 
> Should all threads URCU creates block signals (aside from SIGRCU)?

Yes, I think you are right. The SIGRCU signal is only needed for the 
urcu-signal flavor though.

Would you like to submit a patch ?

Thanks,

Mathieu

> 
> There might be other places, too, I haven't looked too closely...
> 
> Anyways, I'm currently relying on this workaround to ensure
> initial calls to call_rcu and cds_lfht_resize are run with
> signals blocked:
> 
> /* error-checking omitted for brevity */
> __attribute__((constructor)) static void my_ctor(void)
> {
> 	sigset_t set, old;
> 	struct foo_hdr *h;
> 
> 	sigfillset(&set);
> 	pthread_sigmask(SIG_SETMASK, &set, &old);
> 
> 	g_tbl = cds_lfht_new(8192, 1, 0, CDS_LFHT_AUTO_RESIZE, 0);
> 
> 	h = malloc(sizeof(struct foo_hdr)));
> 	if (h) /* force call_rcu to start background thread */
> 		call_rcu(&h->as.dead, free_foo_hdr_rcu);
> 
> 	/* start more background threads before unblocking signals */
> 	cds_lfht_resize(g_tbl, 16384);
> 
> 	pthread_sigmask(SIG_SETMASK, &old, NULL);
> }
> 
> But I suspect it's better to ensure signals are blocked in all
> URCU-created threads...
> 
> Thanks.
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
