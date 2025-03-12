Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EC3C28B28
	for <lttng-dev@archiver.kernel.org>; Wed, 12 Mar 2025 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1741790194;
	bh=9Nocea0EJvGXXU886WHsnVL+ptj0Ireq+AFU+eq9HUY=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=cc/KlwKg+PLxudfLKs9e0Zvu3VVF8YvBtHLMzBpBxUJGSF9OKqngUtFbQngeUX3bZ
	 wWl0puvWZDGsrSkHeUx7KcmABkyCPKV0J/KL6NbSpE37oU2z1H2sX3eBw6Lnc2sIzW
	 39w+n2aQ3LIXtA4tElgoGOd+ZNd2Jne0grRS0ATKolpSOD5o1ya2qESL4IJfP5fLFo
	 zSImhbPnfDmmnMtA6Wl6o/cnpYGl/ZiKZ2xdgfyGlUNfOz8oHE+nPUkckFWmprcB6U
	 dbkB4Vk1Gd++WvUVp3+t3whuUzdcJasbcgjPxCfUJv/LHCDkM+08Rhoz9J+s2eeCbW
	 ddudxLyamyAPQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZCY9F3zdbz10r3;
	Wed, 12 Mar 2025 10:36:33 -0400 (EDT)
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::3])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZCY9C1yCNz10r1
 for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2025 10:36:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4mvYbHmRS0ghHODWGxsUwViG+X8fmDCbkmdFeZGF6NMUoiMJ8KkTZdHKyzftA4YYMK6VCKHq7jdWsMgPg2gQH2wnKrRB2g8c9qDbYc+07Wkv3enWkJ1puaruU9JHtnjhD2gfcvTa54igch0CUo+Jm7ekVGDgs8ThNeVIEQF5bkUhoOn9AIjAx3UZSsfo3EeVoty0GUmKck+S18ytBSU6yRasSe1AfywN3QHmMJOL/iWIPsKOts0K5r6Il00Zri52otXtnZKRtTKb/dnYYQ82QzYQuKvrTEAFYWXeJSKsgxYHzuo6BgtyfAIESiCIBWlnzEwaUaU5b1TPBSYrP5/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DtWSOQYX18+dH4iN/hQJuxe8VUre/hbzeiWqjvIkwE=;
 b=hYZLw6SsOgF3x7G8T4b//+KQzD10bYQzZIr/c06VcRqtH00786a/8cRfWX1hOiTksiI9xpgcEmpA96zXKd9zkJYaJ0OdFrzdq9RE3ch6ayqlV8jgfFMYDHXwOXk003si1Jl1fY35tAxL8MM79YUlG33ZqqSBv7drkQE9U+ZR783xfat82As4lGO68HnTbVJIhh2Nfm/KFuOK5jr//IVwHk7XIt3rDtFJJl4ZgYM8S2uepucHix4z3z3YAEp8X0HsmOI2P+97MkkmCe5SiwVdu8f11Ovo7ELAljQCg8rO4cvWJuIDLqQ658q9wel1AtvNKFvVSxMCxF5Layfljq53gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT3PR01MB9659.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:92::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:36:29 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:36:29 +0000
Message-ID: <0f819583-ea8e-468e-9102-e1410d886a6f@efficios.com>
Date: Wed, 12 Mar 2025 10:36:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
To: Gour DEV <lakshyagour10@gmail.com>, lttng-dev@lists.lttng.org
References: <CAE9JrziSBzHDOLjLzY=8FHPRWxm9+xq40Kzq8GUivb=u9V74wg@mail.gmail.com>
 <8a3a094c-3afc-49da-8764-8fec1179f7c0@efficios.com>
 <38dab5ef-f106-4e57-9e36-b4b30015c019@efficios.com>
 <CAE9JrzhPxAzOKjk+3Z0ZEtuyYq3f_mAmPS980dNZhMe9LFPtew@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAE9JrzhPxAzOKjk+3Z0ZEtuyYq3f_mAmPS980dNZhMe9LFPtew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0345.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::19) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT3PR01MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 2182f058-ddb2-4e9b-a21f-08dd617346d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVZCcVlHT1Jpd3c5ZUUyR1VaZ2hDdVI5WVZSZWVpSlFqaFJTNXo0WStOTDZC?=
 =?utf-8?B?VGZZL3VaWXArWDJ3eXhvZ2hOa1l0NmFrTklFcGtnM3lkd3o5b09RMnVrYWtj?=
 =?utf-8?B?RXp4K0NWd0twQnpzZ3lWUDJjajN4WVFSMVBMUWI4UnZLejZnbXJrRFFwL2xQ?=
 =?utf-8?B?ejkwMCtyVUN2TGI3VHI4b2txV000eTlNUXlJOW4xZUZIbnhNT0x0WWk3VkJH?=
 =?utf-8?B?UFJPU1ppazUxWnl3cW45RG1Gd1c1MlptVDNQaC80WVcwREdRUkZqVk9PQjha?=
 =?utf-8?B?K3BtSEM2THhnY3Y5YmFrR0t6RWkxWEtQNEN1YWxwaWZXbmppMXJaaGFMVzlJ?=
 =?utf-8?B?WlNLN0J0L25jZzJUcWpXOWN5NlIrVWppTjJaLzFnYVdlUTRoTm5BUVV2OTN6?=
 =?utf-8?B?V3c0dzJFdkhWKytJTjdDblM3aVB3N0NLaVV2T2x4cnRoTzFLeE5xQThmeDhl?=
 =?utf-8?B?Zy9FNDZDU0lpdXhWYUJZamhibnNDMmNYaGtvS0xYSlN6aHFrNFVaSDhVZWdL?=
 =?utf-8?B?UUdjVzN1SVBFZGloRit6RjVqWkNWK0NRdnpNeWFsU2VaQkxEb3I0ZlFTZk1t?=
 =?utf-8?B?QWpsLzhMYWFidFZZeWRJNHcyTXowUXZ0S1p1SklhdzloK1dtMXJKdTJQSStO?=
 =?utf-8?B?d2ZZUFdFbDd6MEpmOFNubEFGOFpqK1h4NWkzVG4zM2JXZnhLeUM1alVEdHBC?=
 =?utf-8?B?NC9pQk0raW1xSUw0UFMzdnF6bFBwUENFMS92cU9FdHowYUFON0VYMEV2d0Js?=
 =?utf-8?B?VFNOYU0yVHhPZnM4NG9ub3poejVSK2RsZEh5RGxDSWhpcGlsQTJoVmNLNzdl?=
 =?utf-8?B?VkhVaUVkWDk4TFZEajE0bVU2Y3o5Tkd1Z0pTNU1sVVFXd2pEMlF0QUhMRHhC?=
 =?utf-8?B?R00ydTdQT3BKbFMreExLUnpwWVpKYjZxbHUrZGJqdUFCK3hreG5kVGNJbGdF?=
 =?utf-8?B?N2dEVS9acW9IbUdxOVJ2TW1TbkJYcTRrL3haZWtwYVF0S1BTSkFhQk1FSUdK?=
 =?utf-8?B?bGk4Y3E3eXVreFo3ODN2czl4TlFZSmwvTERqQXYweUdnc2kwMkxwTG1XRnJi?=
 =?utf-8?B?YkZsbXJweWhJQlFrQXBCSCtDSnZ2MlBLbUpMMk95VzZMdm1uL0N6dGtqQS9t?=
 =?utf-8?B?V2NWQ3pTYlo4MFFQYUdRME5xK2NGM1dWUFJoTE5laC90eHEvNlJkMUIvZjZs?=
 =?utf-8?B?UTB5MXg3SGpYZXd4ODJyZ29YOENnT0h1RmZMRGhSN0ZVQjBKRXpZTEpiQlVt?=
 =?utf-8?B?cjhaQ0Q4VWh6VFh0R1hGV2MvSzk3YWh4SWFSSWFwYkh3ejVWWFNzVVFlRmZT?=
 =?utf-8?B?eDBZdlRBeGdXV0tqTzRuZXN6aEZ3MEdoVmRvRFZmbi8vWHhzVUlraERWNm5T?=
 =?utf-8?B?Yi9SaHA5ZGF4YUFCclE0VE1JWC9tbllOTS9IWmNQMFkyNUorSVY2a2dUU1RP?=
 =?utf-8?B?dWt5TGtMREtmWDVNb0hxaHJMQ2JyQkhudEE2NFFDVFQ4YXRpdFFYdi9lY3JP?=
 =?utf-8?B?aFFsZHB6R1JrVWdBRUtFK3h6YlJYYTdCQW5wSVBBZjhhVjFHQ1c2aDlJL3Y2?=
 =?utf-8?B?R0pSUUd1U0d5cmJGTEhnaXYwR2NKSVdsZS9BbDl5RlFWbWUxWU9iYjE2em1w?=
 =?utf-8?B?cTVLTm1hek1yMGFlQXk4VTBjWHlNNVFTT3MxeFZSZ2RHWWdqTWg1NkxIbm80?=
 =?utf-8?B?SU4xUzRnNHg5bTcwV0JVRTBtUHV0NGtYU0pQOXkxcy90Qm9qKy9OclV0ZFJu?=
 =?utf-8?B?OUZoa25SM2xoVnI1ME16WWRjRHhCdjZoZVg0bVNSRUZ2ZHd4VFNQdFNhTHNn?=
 =?utf-8?B?RkpEQlF6akFXblppdGpHdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2QrakoxL3VSK0oxZzdtcUVoME1VU1o3SStFbkNjbkxKUWdVYUNMVDgrakM5?=
 =?utf-8?B?WGVCWkRvR1Y3Z2hHakViWGJIWWgrMXFJT0E2d2VlZWQxVENwcFlHUERTcTNP?=
 =?utf-8?B?Z3hIRHh6cHlXWkJYOXFBbHQrOXJZdmxtZHJGZmNVelgyQ2toOGM2Y056ejVv?=
 =?utf-8?B?Q0ZQSEUrUzlldWVSTi9MdXRjcDU4Nk1pVXpmdGpmTWJ6ZUVJdklYNk56MUpG?=
 =?utf-8?B?ZDE5VmhNOE5jeEVPcHBWRmFnMkhueEtNYVFRRmU4TnhCZVluZlZ6QnU3U25r?=
 =?utf-8?B?dFNTeDh4VUc2WHhUZFFhZ2pqMVNNSjdHUUhyY0xLcEtBdW43TXlMWVdURkdV?=
 =?utf-8?B?Nm9SOWpleFB6NXBCQlFtWEE5NEEvRkZLWXh4RXBndzYrM0FJYmZyTGNmWHRX?=
 =?utf-8?B?OXYyUEZnM2x0d2FUbWxqazQyNWREQ3dLSEczM2gvTks1TzYxMm81ZE4vUW15?=
 =?utf-8?B?YnA4cnA5MVhQSjErUGtHTGw0bDhMa0E1T0VUMnd2bWJWbVN4VzF0RVJiOFFY?=
 =?utf-8?B?bC8xZUplZ3gzMWJIU24vYzQzSkNuaTNhSzBsRkFCWjFMMlZEOWU1N3pVaGQr?=
 =?utf-8?B?bCtqV21MYlQ4TkQ4aG41eEdHYmtGZzEwOGs3K0JMTHF0dlNteFdTOVJzM3Vh?=
 =?utf-8?B?UFJ1azRMY0Q2cWJFL0xFbnZJSExxQ29uTUJVWllPaUVOYXg4UnJpbVE2ZUVi?=
 =?utf-8?B?UEFSYXlWamlxeDYvUkMyOFB2MWRwRlpucTZzVlR5enZXSXoxc2ZzY1g3bHZD?=
 =?utf-8?B?SjdBZ0pxQWZucFB4c21LWVZ3T0FxaHMwU01xUS8raHQvVlRycW9IMWdLQmpE?=
 =?utf-8?B?SXYxcU83b054bzV4UDArREV1ZzRhaE9sQ1lCNEkvQWw3NDNKQjJ3eTJ3Nmgx?=
 =?utf-8?B?eGNITXdXdGxnZnZKNWhEZG9KNzEvZ1dqTm56ckhNTE9GNXFIcllwMnloejI4?=
 =?utf-8?B?aW5DUk9BMFA3bzZrK0VicmtsR3dDNUxSZlFYWUtGZ1krT3dtL014d3FLL0NJ?=
 =?utf-8?B?SzVWT2Jsc204US81bWN6dnRJbDlIYnhZVzFnTkxwNmxDbmdTQlQ1czV3cjVr?=
 =?utf-8?B?cm9OQmovS0xYbko4MFpWbHBtN001c0JxRXpOTjRLdVJUazZwUWNFZ1RZWEVk?=
 =?utf-8?B?MzA4eFFtdWUrd3pSbEVhbkJmNkRwN3NyWVE5d3pmdkNsRHR0OS9KL2FMSVRj?=
 =?utf-8?B?VDhjUm05eDlONlJCTkNXK2lFYlQyWTh6Rk95TjdtL1FweGdlNlZ2b0tESTB0?=
 =?utf-8?B?RTJ5cjZxOGNUa0VvYnZrWG5ndERBbGg3NU1jRFB1TTkyMUROMnBSRzY1RzRQ?=
 =?utf-8?B?UmNkMEdKN2JrZCsxa2pCd0tpRmk1Smlqc1lyQmZsWVppallkOThjem15Tmwx?=
 =?utf-8?B?RHRtUHRDV0xoemxFU2h2dlF0SnRRc1BncURUVUl2TXVVdkRFVjR3elphWkk2?=
 =?utf-8?B?ek9rajNBa1NiaWZMZ1dwV2xOamMyQXdveGY3VGFiQW1zV2tSeEhiemFRL25t?=
 =?utf-8?B?Tk13UUxCc2Rkc2ZodlhEd3dCNVMzZitzVS8vKzF0U05hdUVoVCtSN3FqOWEw?=
 =?utf-8?B?UVI2QVYyVzU3cEVpWmJSdndERk9YeUVFTE5RTjd2VWw0R1BOVFZFeGM1eG5j?=
 =?utf-8?B?bjJaSllNeXF4UzV4UjBGS0hhYkZVc2U2bGNZaTlpSEM5UzdEN25WcjR3ZnJi?=
 =?utf-8?B?K1cxYUZhSWllRUcvY1gvMFBpeTllOFd5eU11RXo3MVlmajRnMkdpbFE3SFJw?=
 =?utf-8?B?dHVNRm1oamNtblNUVytXcDkxRSthKzN2QWlnVGtQRVc4V0plZ2ZGczJtc280?=
 =?utf-8?B?TDl5QnhaYktadlJYQjloeHdCa3pxbk1xbEpFdThsbnd6dHpnYm1MYzk0dzJT?=
 =?utf-8?B?WktiQnhGOHpyTVA1K3ZFQkcxV0JNU1hmQmkwaGlRdnN2eWNUTG9yUTZXLyto?=
 =?utf-8?B?MCtLT3pmS2JRVmhndUV2cWtSalVNN2c1U1hsdGJWcExxdm1FY2s5VHpmMFhr?=
 =?utf-8?B?MjZZV01pTk5hajBsN3BuUWFTR0RYa1F5YVN3cVo4NTN6ektveXVMMkVIZVFQ?=
 =?utf-8?B?ZmhkNWtrTjdKaWRRTXJtVDBwa08wbmYzMkpXNTliQzd2Y2lSeTNiVzhxQmZJ?=
 =?utf-8?Q?6DtS8fZBsfeYUcwwOwb9o8eqH?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2182f058-ddb2-4e9b-a21f-08dd617346d8
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:36:29.5476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyOYw6a0wB8HDLg2WHQB+SSSMkLDuLkTgkV4bCnTyjrbHV4t+7RSsrLlEkOXFGKtNo9S/zvmIKiHEu5JxXR3gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9659
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Lakshya,

On 3/12/25 5:03 AM, Gour DEV wrote:
> Hi, Kienan
> 
> I am attaching an screen recording of the behaviour I am seeing in this
> mail. The behaviour is same irrespective of the device i use, sorry for
> miscommunication in the npocs output (I assumed it was 32), but other than
> that all outputs are same (except the hostname as there are multiple
> devices with same lttng config but this memory cosumption is seen on all
> the devices).
> 
> I had few question
> 
> 1. Does lltng allocated all the memory it needs and mark it as dirty in ram
> when any process which links/uses lttng-ust runs? (here i tried with one
> process but it is same for any of my process)

I believe the shared memory for per-CPU data structures is allocated 
when an instrumented application connects. There is no pre-allocation 
for each possible UID on the system.

You can run your instrumented applications with `LTTNG_UST_DEBUG=1` to 
see when the connection happens[1].

> 2. (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
> (nUIDs or nPIDs)
> 
> How do we calculate uid in the system is it all uids in the system? is it
> equal to `cat /etc/passwd | wc -l` ?

nUIDs is the number of distinct UIDs running instrumented applications.

> 
> I will put my calculations according to the above estimate based on all the
> channel i am creating
> 
> (4194304*4 + 262144*4 + 16384*4) * (16) * (30 if number user are equal to
> `cat /etc/passwd | wc -l`)B = 7.998046875 GB approx [this is based on the
> start_lttng.py please do correct me if am wrong here.]
> 
> But since there are only two users which uses lttng i think the correct
> estimate would be
> (4194304*4 + 262144*4 + 16384*4) * (16) * (2)B = 546MB

The estimate I gave is per-channel.

small channel: (0.015625 MiB * 4) * (16 + 1) = 1.0625 MiB per-channel 
per-UID
medium channel: (0.250 MiB * 4) * (16 + 1) = 17.0 MiB per-channel per-UID
large channel: (4 MiB * 4) * (16 + 1) = 27 2MiB per-channel per-UID

Now, you said you have 0 small channels, 6 medium channels, and 16 large 
channels in your session. (Note: I see your script differs from these 
stated channel counts).

small: 0 * 1.0625 MiB = 0 MiB per-UID
medium: 6 * 17 MiB = 102 MiB per-UID
large: 16 * 272 MiB = 4352 MiB per-UID

And if you're running instrumented applications with 2 users:

small: 0 MiB * 2 = 0 MiB with 2 UIDs
medium: 102 MiB * 2 = 204 MiB with 2 UIDs
large: 4352 MiB * 2 = 8704 MiB with 2 UIDs

Now this is just an estimation for the per-CPU ring buffers only, and 
you numbers aren't hugely off so without analyzing your specific system 
it doesn't seem to be that strange to me.

If I take the number of channels I see in your script, it becomes:

small: 0 MiB with 2 UIDs
medium: 136 MiB with 2 UIDs
large: 7616 MiB with 2 UIDs

total: 7.57 GiB with 2 UIDs

> 
> Please do correct me If I am wrong calculations here.
> 
> Now, there are a few things here, according to my output lttng is using 11G
> which is much more higher than the what is configured.
> 

I have no idea what 'service start spyder' is doing. Maybe it's running 
instrumented applications with an extra user that you didn't expect? I 
can't help you with that aspect of your system.

The above estimated 7.57 GiB with 2 UIDs would be 11.35 GiB with 3 UIDs 
so maybe?

I'd recommend you read your verbose sessiond log so see which 
applications are connecting and with which UIDs.

> I am attaching the lttng status and the file which is uses to create the
> lttng sessions.
> 
> 
> 
> Thank You.
> 

In any case, the information you have given to date hasn't demonstrated 
to me in a tangible manner that you are seeing a difference related to 
the version of LTTng being used.

thanks,
kienan

[1]: https://lttng.org/man/3/lttng-ust/v2.13/#doc-_environment_variables
