Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67B6C4345F
	for <lttng-dev@archiver.kernel.org>; Thu, 25 Apr 2024 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1714059677;
	bh=5zG0b8XNCvvB4CoeQgGhcLKmuuDBRZvBhc4ul1LE158=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=YYoiwx9uRKRDCGwwaRdVL4i9SMU/ZZUUpzX1srsxl9g7pECmJqPbipnF4kNle15ER
	 ym2+9IeqLHRuREMglipSeyHI73MUqFO1MJUcCwdk4odibBGo7A3W4DipT5imY9dyio
	 22r5EAYTCK+YuYMFsYL75dzM5/y8M/tG1rbEDozIMyC1FOoIi2hAk45/E7A1Sgy7OO
	 unteEGMrQ+Cr0I9K2o7AGwE6Mn8cGmm8DgmxjbDwNbyzqG+6qZamhU+ip/7Uf5smDx
	 /bW61YXc01jyDlau/ZWLpVVI5WW39nmWgO5yjuabDzLhKWmVZujc/ERIeiHOqpLJoI
	 DZ6HxcxPKYTsQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VQKp44bzLz2jxj;
	Thu, 25 Apr 2024 11:41:16 -0400 (EDT)
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::2])
 by lists.lttng.org (Postfix) with ESMTPS id 4VQKp24lhvz2jFS
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2024 11:41:14 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UARvZA3ssZmUf2aZ7ZXSS9fBTkRm4W8XxlQ1Fw/cI4/wfN9MvQNomccv4U+67fGbfO4hbGb5R5KDufzJcbkQnnd/9eyMpWcPKUZxdEi1aw+xjkFlZpRMmPHbhcR3+EcTGMFf/dZHXI7muGtUGbdrB+H8GN1dE02fVBmF8ElwnCTpXpqyXv7r7t2ReZf048V8x9atHe/hvmKWoxq5AbpGxRePJwmIzC9We0ngUAKAf/aZS9mwGPJfUaNOSDbjpY6Dkgr1qfI8T6BowQwe7546uhDOBtufFSDAkK01wXdbxnTB6FUtipJCulIoleemX66/dBtIcGONOw263l2Z3Tg6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JfjtEGvFmpYi7Y+IwhFBiRLPc4XyzmlNfdpT69a5t0=;
 b=c6GDlrRcCQkMlIn1+EVeK3Taq5YQlYyjQ7clYLmT2t+bVUABzO9+0j7qezos5/vcwYtTcD66szNdcd/CilrWE78v2x8Bv+0KjM3bkW4hP3WJuuVmbWqORCxzJ+IpWeteHKrDxY6z0wxJJWXdqDgSQGNksdDE3ljSKs6p3xFB9iaJh98KOJGGjIwVv/BqSylqYZ48adcIkj51FJbEfC3OjOGU4MjGwugWw8jb6vO6Ue4Y9FVr8fAyaFFKklnebbdoYJc+6ZlpCTpnQ/c9pUsCVsAchmhPmgY885A4LrQ/Vu+6vZmweiX7dtd4ykddI5lbSnnFx6y4Y/f+8flELiyKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT3PR01MB8354.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 15:41:12 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed%5]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 15:41:12 +0000
Message-ID: <b8b2da19-5c08-4369-9bd4-8a3ae554ac4f@efficios.com>
Date: Thu, 25 Apr 2024 11:41:11 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Wu, Yannan" <yannanwu@amazon.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <03304ae9731e474db911b8ef6703cf69@amazon.com>
In-Reply-To: <03304ae9731e474db911b8ef6703cf69@amazon.com>
X-ClientProxiedBy: YQBPR0101CA0284.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::23) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT3PR01MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ca4dcc-ad0c-4e11-5047-08dc653e22d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Snhnck9QL2ptbENzSkMrQzhxL2o4dUt0NHV1Sm9GN3IxQ2xwYnhXbTNvQmR6?=
 =?utf-8?B?dU9RZzYrc0NtVkhIcjJ6WjRhRGJEOThFbCs1TUJXL25uajkxZlVwWWRBeUps?=
 =?utf-8?B?NTI3SXdXZUhnd0doMkkxR2wxM2N0ZHZnYW1oK25zOU1yRis5cFpXbDIreERl?=
 =?utf-8?B?ZEVuK3p3MGh5aVRHUTVXeUQrd3hGUmMxTjJhRWFwTkJiWUpuQWtqcitDUE5U?=
 =?utf-8?B?TEFrWWRTbWhNWHdmdWNOOHAvRFh4NTNDOEw1T1JvWXdzeFY0SFlET0M1K1py?=
 =?utf-8?B?TjdWWTRXQ0k0eWthWUFEL2tEcFJvRjZYN3Nwd1d5Y1JwdHpnU01uQmZDNFdt?=
 =?utf-8?B?cDg4UUtsbVdqODZpZXJvU2xiLzBJWmpUcWpQV0xtMVh3R2hxZ3BzVndFVHJN?=
 =?utf-8?B?L0tVbzhoR0V0R0FFdlVLUCtsQnFvbUttNTdqUlBrTXBUdTdGZnVhZktjWmJq?=
 =?utf-8?B?ZDBJcWFmcHgzVmVBRHk4dFZ4WHI2VDEydWY5YTBQNm9DeTdBTUVzWnRZZkV0?=
 =?utf-8?B?aDVxOUNPbVlzNjlXaUtxZG1sdklQaE9tdnFWUTdCOXc4VUJpVERnUnpFNkJm?=
 =?utf-8?B?NytDbWx0cnV5ejN1SEtLdTRuSWZRckk0TUdlaG1GRi9JeEJjcUF1TTFYZlMv?=
 =?utf-8?B?a1NXcWhaN3VFL3dYMmc1TWlpbFRwTXV4UW53M3NSYVd1bUNoWlFxL0lpWWdr?=
 =?utf-8?B?M3BxYVgyU1I5a1ZjYkVkMTZNbTRMQjM3YlJpWmVTVThhNSt5dWMwckZtRms3?=
 =?utf-8?B?MU53cVhpNzhSeVI4cjRveHo4SlhQWTVyRVpsWUdzMEd0MjRid3cycnZNZ3hU?=
 =?utf-8?B?TmRxZGoyUERLNnpFQUVPYmdxeGU5NE1zcFpIc2NTL1djZXVWcE5TWlVsckFn?=
 =?utf-8?B?NzU0QmxORmxaSGRXVnV6cllHNWQrU2hRQ2Q3NlEvS1lQUSt1VTB1akl0dlJz?=
 =?utf-8?B?d1JZelp1cERHV2hoUER5VlladThJVFdRdjlYdVBrcUQwb0o4U1JqeVVrcWov?=
 =?utf-8?B?YjZKdFFIZUh2UW5kRm4vUDVidmpYRDllOWR0bjFOQU1UMUdvRWZHb3lyR1ls?=
 =?utf-8?B?aHZvbDFJeW1hcEVxMkN5NUF4bndnZklvVGYxVHR1NkltWVpkd3JoS3UrbkVH?=
 =?utf-8?B?RzBEVVVyVlFsVWM4b0gwRkVmWjYwaDY4Mm1kZUhSZHFqMit0MDhwenptRDhi?=
 =?utf-8?B?aWVsZnNNNTBCQ3BQcDNxN0xudkVnOW5uSHNXSTBhMkd1ZXpFUVA0dTN3czNs?=
 =?utf-8?B?anE5b3JkejBmUmVOUCsvS1cxSWJlaDlPSXdwYndKSll3R3pGRUFyZ2FGbk1P?=
 =?utf-8?B?WHlpYVo4bGUyekFDOHBkbWZNTllscUxCVXROT0JpRFdWZ3hRVWFML2JtWUlL?=
 =?utf-8?B?RlNLOGE5ZFdjeEc0U3FVLzVpOXdtUnVoQitLV21DejdpN1RIRHVaTHF4eGt1?=
 =?utf-8?B?YmFHMC92WWw0ekNKWlZhbUZWZUFpNit2QW5yRUZ2RFJCUjUxaWRrU0QzRk5T?=
 =?utf-8?B?dmF4Mk5zVE5IY1N4endUVWNVQk1DSWoxNXFvaklkK2RsSTFqdHpaMEhRNGVS?=
 =?utf-8?B?ajRPQmxUNGZnS3k2THNpOS9hcmtJeXVrYjQvckF0ZnJycFY3REtCV29UeFcv?=
 =?utf-8?Q?c4/S9X2q7h4fm9sYvdPtLMQZTiZ739NXn39jPev1jQdk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFp1MFl1dS8zTDVWRUIvcW5CaXdYalJabWo4S2NkajNvYUQ0akk3bTRNUGRN?=
 =?utf-8?B?cWNEUURCckJaSHpVNnNPVHNaQm1LdUxDenFDUnNIYUNRWU9Sb0d1WW5YNlNZ?=
 =?utf-8?B?VFhlWm5LYVRxYUIveFlRODJaVTdUQlE5dkd2c05hSTVLcXlwQVZ6UGxJNmJM?=
 =?utf-8?B?TFBZL21JYy9RSUhYbGtmN1o3ODJJRXZ5aUgvZzB1NkgvVU9oK3pqR041aVZt?=
 =?utf-8?B?N21hUE1RbTNBcVNUQURDVld5SGFjNll3S1BlVXBLYm8zZ0I0TkZWc0JGNFFn?=
 =?utf-8?B?NStudW54REdEOGVwejlGdUJCNnFxTGxaNURWUVY5b090d3I1QktLcmhBY2RZ?=
 =?utf-8?B?ZTgwaW1iV2tSalRVTjE3RmljdGVadG4yb1h1NHpvWTRVNThTb0FvWUswZEFD?=
 =?utf-8?B?dm83L3FUTEdaRVdVUHZJQmxXWnVScnNZa3dVcFRjZ3BFejdnUVU5Slc5Vzdj?=
 =?utf-8?B?OWI4dU5laHVNZWVNMEdzOVJackxLai91YytQMUJPTElqSjRDRjY4K1VuN2Ro?=
 =?utf-8?B?UHlISEppbE9xdEJoOXFHeTJkaytUUjlOUktzUXdZNUlGY2JhamcrNDFqR3JL?=
 =?utf-8?B?eVVUTWpPeGpIMFA4dzhmTUg5UkRXUFVwTVlsRFZ5ZlhiQkVWR1QxbUlVVG1Q?=
 =?utf-8?B?elcwTGFlL09UdDZTcDNnTnF4NTJKdWV2OUNOeGNkbXRPM0tsS2tvODJUait5?=
 =?utf-8?B?YzFsK2lnZVhlcCs1MlErUVo3b3Q3Z1h2c0NnVlJMNy9qaElwcnBCWGQ5WlM2?=
 =?utf-8?B?MWVSR2p6QXArM2lTbFNUV01wNWFJNDZSSDR1S2hnaWgydUpuZm9HOFgySmFX?=
 =?utf-8?B?ZVBDZVhscm5QWVUyL3FubnFNcFE4OVh1anA4NHZXOHlnVUNJeG90ZVJYbUZR?=
 =?utf-8?B?aEc4NVN4QzdkYko2ZVNhTmlzUHZsRHdGa0RPdWUwTGtzVUE3VnBpZ3hWSVV0?=
 =?utf-8?B?K3JNWG55aGtyMmxybXNCSzlZbjhYQzdhbjZyWlh5aldqZVIxREV4dVhSWWY0?=
 =?utf-8?B?T3RvWTU3cWFvYlFRT0l0aU5oeGgxK1NuU2NYNDc1bkJmU003dzQvRWtWajV2?=
 =?utf-8?B?M0hxaUszL0VyTG9tdDd3R21zZXlkYUlzbDhRS0M5cC9nbCtoUTJCUHB6Mk1E?=
 =?utf-8?B?ZGNCNUpIS0Y0eXc0YSsxUFpxbXJWTWk4TzdVQzJReDlXaDZhV1MvQVJxbHBY?=
 =?utf-8?B?MWVJRndCMTNHNWxET0laVFF5LzBya1ZpcWk1TG9IQjM3R2oyUEZXMUtTR3RC?=
 =?utf-8?B?U1dRbUVHdk80cW9EaktOdHoxSlg1SjJHb1FVc2xUMzZxQjYrZ1lWdEtEdUVL?=
 =?utf-8?B?K1JRbm1QaTkrRE9hVWFYR0lZTllsS214Zzg2RXJPOU1OOU9VcWpBeUIzQkNI?=
 =?utf-8?B?eHNGZWVTMWJoS1FsMFBWZDJZZWJDVTNBK3BxbmxrYnpxQjFRZHIwWkNBQ200?=
 =?utf-8?B?ZjFsVnZ2Q2dXSjRxRU5kTUxUeENrUXczTVIwa3ZhZi9iYlBmeHRMK2w0WDJm?=
 =?utf-8?B?WnFQTTZtWjBTTDNiSWgzUlNBbVlrcTNnREpGNWNoTDlzdzFPTU5KYTQ1WWJS?=
 =?utf-8?B?QVZ3eEl5L1hTM0hlR1drOHZGWU5mNDVOd1dNSzk0eTVWV1BXVnRnSGpZMFhl?=
 =?utf-8?B?MmhJWmtyUTZzeDd0L2J4UklUdEdSc3AzdXY4ZDlHdVUzRUdjTDl5R2szQzBo?=
 =?utf-8?B?bUR3OFhaSTJySm1PeHA0bVVWYklyeDZPeGpOVnFqUFIxaTJCRXJyUk1PZDNC?=
 =?utf-8?B?Uk9xN0NmcnVPcncraFlQa3FSWHE5d25WTGFaSjFpeUl5dmk3MlhvbEJPeFNX?=
 =?utf-8?B?a2xqREJNK1RiZG1UcXhzODhOM1lDYlIydTBZZm9WeXR5UWNpaXF1bzM3Q1dn?=
 =?utf-8?B?TE5UMjRPZWxZVGhXUGE4R3dBNUVMSFdwZTZnZzZaV3ZGZndBWDRnZGlEeHUr?=
 =?utf-8?B?c1JhUGNnM0dkVTAwVTh0YlJUT2RmdGVIU1ZsdGRpWmcvOEFQOWxaMjlmNndR?=
 =?utf-8?B?bXpXVjMrOGErYWNXZUJQS1BXdUlaN3ZpdTV6M2RodTZkaTc3SFRTODJWWjhr?=
 =?utf-8?B?aEkvRGNqd0s0Q3U5WDY4NTE0RnpEakNXTTc1N3RTbDloN0VXYTVCc04zMGU3?=
 =?utf-8?B?UjVYK2ZkSVFLMjJOOGZaRUdScUpCRjFNYjliTFRSK0NBanptN2U4Wi9lajNW?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ca4dcc-ad0c-4e11-5047-08dc653e22d2
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 15:41:12.7693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: as/QtwIm+q8k8N7eFO4IfsnKhaf5bJq2AJfz90R239b536ornRLee/3EAZ+6zkkX69BQYvXTyCHV1wgO/YpAaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8354
Subject: Re: [lttng-dev] [babeltrace2]about python self-defined plugin
 loading
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgQW1hbmRhLAoKY291bGQgeW91IGRvdWJsZS1jaGVjayB0byBlbnN1cmUgdGhhdCBiYWJlbHRy
YWNlMiB3YXMgYnVpbHQgd2l0aCAKYC0tZW5hYmxlLXB5dGhvbi1wbHVnaW5zYCwgYW5kIHRoYXQg
YGltcG9ydCBidDJgIHdvcmtzPwoKVGhlcmUgc2hvdWxkIGJlIGEgYmFiZWx0cmFjZTItcHl0aG9u
LXBsdWdpbi1wcm92aWRlci5zbyBpbiAKYDxsaWJkaXI+L2JhYmVsdHJhY2UyL3BsdWdpbi1wcm92
aWRlc2AKCnRoYW5rcywKa2llbmFuCgoKT24gNC8yNC8yNCAxMToyOCBQTSwgV3UsIFlhbm5hbiB2
aWEgbHR0bmctZGV2IHdyb3RlOgo+IEhpLCBUaGVyZSwKPiAKPiBJIGFtIHRyeWluZyB0byBjb25z
dHJ1Y3QgYSBjdXN0b21pemVkIGZpbHRlciBhbmQgc2luayBiYXNlZCBvbiAKPiBiYWJlbHRyYWNl
MiBweXRob24gYmluZGluZy4gSG93ZXZlciwgbmV0aGVyIG1pbmUgcGx1Z2luIG5vciB0aGUgcGx1
Z2lucyAKPiBzYW1wbGUgSSBjb3VsZCBmaW5kIG9uIHRoZSBpbnRlcm5ldCBhbGwgZG9udCB3b3Jr
Lgo+IAo+IEZvciBleGFtcGxlLCAKPiBodHRwczovL2dpdGh1Yi5jb20vc2ltYXJrL2JhYmVsdHJh
Y2UtZnVuLXBsdWdpbnMvdHJlZS9tYXN0ZXIvbXktZmlyc3QtY29tcG9uZW50cyA8aHR0cHM6Ly9n
aXRodWIuY29tL3NpbWFyay9iYWJlbHRyYWNlLWZ1bi1wbHVnaW5zL3RyZWUvbWFzdGVyL215LWZp
cnN0LWNvbXBvbmVudHM+Cj4gCj4gSSBqdXN0IGRvd25sb2FkZWQgdGhlIHB5IGZpbGUgYW5kIHJ1
biB0aGUgZXhhY3QgY29tbWFuZCwgaXQgZmFpbGVkLiBUaGUgCj4gbG9nIGlzIGFzIGZvbGxvd2lu
ZzoKPiAKPiAKPiBiYWJlbHRyYWNlMiAtLXBsdWdpbi1wYXRoIC4gLWMgc291cmNlLmRlbW8uTXlG
aXJzdFNvdXJjZSAtYyAKPiBzaW5rLmRlbW8uTXlGaXJzdFNpbmsKPiAwNC0yNCAxNjo1MjowNC4z
NDkgOTE5ODA1IDkxOTgwNSBFIENMSSAKPiBhZGRfZGVzY3JpcHRvcl90b19jb21wb25lbnRfZGVz
Y3JpcHRvcl9zZXRAYmFiZWx0cmFjZTIuYzoxNzIwIENhbm5vdCAKPiBmaW5kIGNvbXBvbmVudCBj
bGFzczogcGx1Z2luLW5hbWU9ImRlbW8iLCBjb21wLWNscy1uYW1lPSJNeUZpcnN0U291cmNlIiwg
Cj4gY29tcC1jbHMtdHlwZT0xCj4gMDQtMjQgMTY6NTI6MDQuMzQ5IDkxOTgwNSA5MTk4MDUgRSBD
TEkgCj4gY21kX3J1bl9jdHhfaW5pdEBiYWJlbHRyYWNlMi5jOjE4ODIgQ2Fubm90IGZpbmQgYW4g
b3BlcmF0aXZlIG1lc3NhZ2UgCj4gaW50ZXJjaGFuZ2UgcHJvdG9jb2wgdmVyc2lvbiB0byB1c2Ug
dG8gY3JlYXRlIHRoZSBgcnVuYCBjb21tYW5kJ3MgZ3JhcGg6IAo+IHN0YXR1cz1FUlJPUgo+IDA0
LTI0IDE2OjUyOjA0LjM0OSA5MTk4MDUgOTE5ODA1IEUgQ0xJIGNtZF9ydW5AYmFiZWx0cmFjZTIu
YzoyNDY1IENhbm5vdCAKPiBpbml0aWFsaXplIHRoZSBjb21tYW5kJ3MgY29udGV4dC4KPiAKPiBF
UlJPUjrCoMKgwqAgW0JhYmVsdHJhY2UgQ0xJXSAoYmFiZWx0cmFjZTIuYzoyNDY1KQo+ICDCoCBD
YW5ub3QgaW5pdGlhbGl6ZSB0aGUgY29tbWFuZCdzIGNvbnRleHQuCj4gQ0FVU0VEIEJZIFtCYWJl
bHRyYWNlIENMSV0gKGJhYmVsdHJhY2UyLmM6MTg4MikKPiAgwqAgQ2Fubm90IGZpbmQgYW4gb3Bl
cmF0aXZlIG1lc3NhZ2UgaW50ZXJjaGFuZ2UgcHJvdG9jb2wgdmVyc2lvbiB0byB1c2UgCj4gdG8g
Y3JlYXRlIHRoZSBgcnVuYCBjb21tYW5kJ3MgZ3JhcGg6IHN0YXR1cz1FUlJPUgo+IENBVVNFRCBC
WSBbQmFiZWx0cmFjZSBDTEldIChiYWJlbHRyYWNlMi5jOjE3MjApCj4gIMKgIENhbm5vdCBmaW5k
IGNvbXBvbmVudCBjbGFzczogcGx1Z2luLW5hbWU9ImRlbW8iLCAKPiBjb21wLWNscy1uYW1lPSJN
eUZpcnN0U291cmNlIiwgY29tcC1jbHMtdHlwZT0xCj4gCj4gYmFiZWx0cmFjZTIgLS12ZXJzaW9u
Cj4gQmFiZWx0cmFjZSAyLjAuNyAiQW1xdWkiIFt2Mi4wLjYtMS1nODI1YTBlZDZkXQo+IAo+IEFt
cXVpICgvyZJta3dpy5AvKSBpcyBhIHRvd24gaW4gZWFzdGVybiBRdcOpYmVjLCBDYW5hZGEsIGF0
IHRoZSBiYXNlIG9mIHRoZSAKPiBHYXNww6kgcGVuaW5zdWxhIGluIEJhcy1TYWludC1MYXVyZW50
LiBMb2NhdGVkIGF0IHRoZQo+IGNvbmZsdWVuY2Ugb2YgdGhlIEh1bXF1aSBhbmQgTWF0YXDDqWRp
YSBSaXZlcnMsIGl0cyBwcm94aW1pdHkgdG8gCj4gd29vZGxhbmRzIG1ha2VzIGl0IGEgZ3JlYXQg
ZGVzdGluYXRpb24gZm9yIG91dGRvb3IgYWN0aXZpdGllcyBzdWNoIGFzCj4gY2FtcGluZywgaGlr
aW5nLCBhbmQgbW91bnRhaW4gYmlraW5nLgo+IHlhbm5hbnd1QHVlOTFlOTZmMjk1MWI1Yzp+L3Ry
ZWVzL2x0dG5nX3Rlc3RfcnVuJAo+IAo+IElzIHRoZSBjbGkgY2hhbmdlZCBvciBzb21ldGhpbmc/
IEhvdyBjYW4gSSBtYWtlIGl0IHJpZ2h0Pwo+IAo+IEJlc2lkZXMsIGlzIGl0IHBvc3NpYmxlIHdl
IGNyZWF0ZSBhIHBpcGVsaW5lIGluIHB5dGhvbiBhbmQgbWFrZSB1c2UgdGhlIAo+IHRoZSBweXRo
b24gZHJhZnRlZCBwbHVnaW4/IENhbiB5b3UgYWR2aXNlIG1lIGhvdz8KPiAKPiBBbWFuZGEKPiAK
PiAKPiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0
cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
