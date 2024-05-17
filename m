Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE09BC04FFE
	for <lttng-dev@archiver.kernel.org>; Fri, 17 May 2024 16:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1715961866;
	bh=BJ3zFt2rt19QFarchaWjcIdm898BXfuGn1a4xK2wo60=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Li12fxGGaL0merMKkC11kUHLWLvM6iDZDclsYFE1i23PoH+CDM35RNPK8Xou/sKSR
	 vJCOcCSLWLc7rZI5yrZKdZyWcJlUaVM0bkgaGRr8/B31tBqlfWMKUqbo80ri2D8fIx
	 y9R1L5KizAuCGxkQgvkU449NbvuXMPvYNFS2Z7d7XZPYt7IsmkTw/6Z8u9frrxCPWF
	 ocpT8AQa4CimyepKsVIZnHmcV0wiRVfJrZtffHwazTdhu326xYV0rmxPat/DUmH40k
	 Kh7DkMkYmPPUZmTjbjbeE1FoXXyCcFoBLGwQk3AfwH5lNO4DKuqsaAbU35xlCfFdl3
	 T9fymdeDX4hZg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VgsGf12gzz2nyF;
	Fri, 17 May 2024 12:04:26 -0400 (EDT)
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::4])
 by lists.lttng.org (Postfix) with ESMTPS id 4VgsGZ2Fl9z2nyC
 for <lttng-dev@lists.lttng.org>; Fri, 17 May 2024 12:04:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7WAjl8/+cmaN8syh4+csfG8z84aSh8sGNxKJVTlwYCGz2hAYeOrDr+nJr6ejlpbnT7sSNKoTEV4MpAD4cDgdOb0+GDpF1X8VK1pAY+b/oCufSGH6oOCw4RZrTGpYZ5nXjiIZ12vpd+rNdQww3SGzWYlP2Fl9o+RE8RQ676b+0WfmZ+ZvFBKvwlEmHhPLPjlX4IyZbAhkpAhNfjF6/XcPU+FLnwH+0hLuQLGvwzsR8ymJirsBOd+7iwe7uRaV++MekhMENuFg7cKlN387bbhRRUAFRQc6Rhb4n8qRqI5tvJiHxLxEv6X1dxZLwVKZ/JdXWdrrsXGEMtZvf7/66/glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Yl3Y6/EuM8tP4ndi92SLu9u9HZQNdam2d5MWO5NbjU=;
 b=ZWrXb5z7cw+m4PULhV960877aYQXPG/kee8IonWiXuCZvUcJQZwRN8CYEoPaS8IP4IMieaQ5HHViUNlrvU4C/DGEJiJLzIWmH9Fa14n90j27v7SQioFanGrQO2Cv/kGKikwplrGCnzJLbPtJU7SN7us/pUdsS+azVcQ1FS2loFJeyJhoNGeg+IpsAC7k/DohFy2GB/TfljwWwoNsrgE4nIV1SGKEYULcsiRb4SEznXLdSGkKZO0xlYc+oy0+c3y36iYHnb+GruNWtJ7maDySJtbSDyEtcPtb6WCqvCWmIk+sWZPIn3wx1xeo5BBxpwBLo6gswmzByAsYOzSK7AC4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YQBPR0101MB9294.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:61::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29; Fri, 17 May
 2024 16:04:20 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%2]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 16:04:20 +0000
Message-ID: <9e00bf4e-1059-402b-9be2-ef407dbdf039@efficios.com>
Date: Fri, 17 May 2024 12:04:18 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Martin Hicks <martin@sr-research.com>, lttng-dev@lists.lttng.org
References: <ZkdnIf/OX995MndN@t14.bork.org>
In-Reply-To: <ZkdnIf/OX995MndN@t14.bork.org>
X-ClientProxiedBy: YQBPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::45) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YQBPR0101MB9294:EE_
X-MS-Office365-Filtering-Correlation-Id: 1717808f-ffdb-491f-606e-08dc768b02d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXlBemhHSmtBdERsTnUwMEY3T3praHZ6dkc2TlV6bWcxaElXcVJKbzBpbTd1?=
 =?utf-8?B?clQzaWZqV2JrYWU5d1h4WEFQZjJpd2U1cWNpZ1NQNGEvWGxlaVRmaWRWRkxN?=
 =?utf-8?B?dW5CeDFqdU1jdWdka3B2cTNVTzRHZE1lQVB0K28rUjhOaitlY1h1QW95cE5B?=
 =?utf-8?B?bWdZN2NrNEk0ZjIzbnhXSlV5SFVNOGxOcmhKTnVZZ0tiMUNJaC82QjVNdGNu?=
 =?utf-8?B?V3J4Qmx4Zm1aczFJaEZ3UmgxUTZFVE41SG9GUTY3WTBVdGQrMUpyaDUvVlY3?=
 =?utf-8?B?OWk1YVBGTHBRbkEzTHFkR1hlcWtPZEsrSzVkMEdBbWE5Q2MyNVRFQjd3MXFM?=
 =?utf-8?B?TEVleU00eURrbzhyd3BNem9Rck9IZWhGUS9WZFdwYk9tTFVNTTE0L2k2RHhV?=
 =?utf-8?B?alJxZWxZL2pMSjI0aWI5Qm41VlliNE9SM0NEaXUxQ1BGbzVGVzZpV2UvaW13?=
 =?utf-8?B?UExBdkczaE94M3NWandKYlc5bUFIV0Q0dUVaeFpKVFl3YVhaRi9Ec2Z5TU5F?=
 =?utf-8?B?WXJPY2RmbFAwN0I3L3g0b3B2RXlEaTNCQ3ZVNkZaS21yM2NPQnp3R2R5eE1j?=
 =?utf-8?B?K1dDdE94QjR5cHprK1Rvb0N3V1pJdUk3V0REOTlBcnpIaDZTTDBPZkk4VTlh?=
 =?utf-8?B?c0ZZWmtNM0JUNUlvVzM2WWJ2TExaMWJyZDY5ZWR1ZmZSKzI0TEMrWGNzeVd5?=
 =?utf-8?B?bnhodE9vUTRXSWZTUjBSWFRuWFFNcS9qd3k3ZXh3WDhYa3hmYzFNNVRxM2s0?=
 =?utf-8?B?RzkvOGk4TC9PMFM3Snc2cFh1M0Vkd0xZNnNkd1ZMR2FsVitvUWNtQ01uSm94?=
 =?utf-8?B?M3Q0UzRlQXRJUXFTWXB2K2ZDR3JkT1A0YWFCb1BoZDFnWGlpZGM3Zi9RaEN4?=
 =?utf-8?B?Qi9jTkdHTDZ6aW9aYU85a0pVU3p1OXd5N0NhbTBYYW5VaE5xK3Iza044cDFX?=
 =?utf-8?B?b3diQ0hXSitsUDlGUXdjUlo3M3V4NkhUUFNpa1N5bTVuQ084UU9UN0d6NWpw?=
 =?utf-8?B?d2lkU0VhcXlySzRJREJpRUE4aDBRMXdZQ2tNSzA0VVA0UFBhV2NPbWNxdTRK?=
 =?utf-8?B?eHYzRWxwdWxxMmsrdFo4THh2ZzlKWmp0ZllTSnloUVN6Y092SUhkbTdlM01n?=
 =?utf-8?B?a3FIQzZ1UTZYc0FhelZyV1FJdUJWUTR1bmJwQ29Bejl4Q05WK2JVM2JBZHBL?=
 =?utf-8?B?YXUreDJ5S3FYOVkvNWp4U0orcTVxQmM5enhrRzZPVG5uUUVIRE9WaFF2Vldq?=
 =?utf-8?B?NTNjVUJDQVJ6bk1iTnBNZFAwWE52ODhGVjRXSVFvd1FPQ2tEazVLYzNXMXpC?=
 =?utf-8?B?bnBvOVBDdGdQa0JQMjN2U3BNMzAvVVNWRFJ2TjdvNGxHM2c0VDRTQUhVbjFm?=
 =?utf-8?B?dDhTMXBwZzJuR3dpVDIxWis5dWVsZlBjMXVpNUpEUTNNb0ZHRTdld0hjTUcx?=
 =?utf-8?B?dnEzMVF0dGxZcFpWRnFvRjZJY0RxVHd4MVBuYmxWS1hoRlhoL3NWd3VZZDZ3?=
 =?utf-8?B?OXBpdXBSSi9Xa0ZtcFZ6cXlHTHJoNVVvR29qVzF5bENJUURoK0xYeDJUNmRl?=
 =?utf-8?B?UXVBREwrdEc0bzd5TVRmSm1weXN0K3Y1Q0RrQmM2NzFXRnFXbUFwMnNzNlBn?=
 =?utf-8?Q?GCpjMGvEilzX/lUm63MAKjM9L+19fxM/wo4CX1FXQYhQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2plZTZ1SDM3NkkwQWJmNWVzNVNUMk8rd3c1UWF5dlNQTm5wNGU2M095MUJ5?=
 =?utf-8?B?ODNGU1pxcTUzVHJ0WG5XZEdHVGVucmtQUUIrbjBNNGdjMkRmcE1QMW5PbHFP?=
 =?utf-8?B?aTZNTVpKZnM2VXgxN2NvaHRyOVJubi93QnJGUU9qdURlbVBudW1DOHZGZmYr?=
 =?utf-8?B?aXVTYlVTTkNDamlLOVVYdlh2UVViSnNhekVEck90RStlZGxQWEJab0ZpK3Za?=
 =?utf-8?B?TnhRcmpVVkF4Q1kzOC9pUDRRUzM0TkllOWw3dmp5MzhPd2wyNWVNeXpjVXFK?=
 =?utf-8?B?NGdsa0tNY2JLK0EwK0htQkw2ZTRwb0RPQklzTFk5QWVMOUxXN05vUldJVlo0?=
 =?utf-8?B?L0VKMXcvVDdkSk5DOCtUQnV1cnJkUmlXSGxQcVkweWh0UWFTMzBjMHI2WVFt?=
 =?utf-8?B?UGZkWUhxU3cwVEtzU1IxMXF1SkxjYkFtQkNoc1RGWlpadDhuMkRIYWIybE1n?=
 =?utf-8?B?UTRPT3ZMMVg1SjhoVm94d1hDSExzbXF5NC82cU52a0Rja3Vkak1wcnhhR2ZK?=
 =?utf-8?B?Z0ltU2xOT1hhZEh6SXZWSEhnVUhZanBpa3hCT2lKTDhQU251eVN5SGU1bGlj?=
 =?utf-8?B?dStiay9VaXBYS0ptbHFOeGQyQzFiUmU0a0xBTktNQzVHYmVZdEpOeG1taThM?=
 =?utf-8?B?ZnFWenlsZndZQXVSMlYySjdWOXdmSWsrcXlhNEFQZENKZE1rWTFLbUZJUDNO?=
 =?utf-8?B?TXFPbi9BSVF3R0lEYkcrdFN0SzY1OXJMR000VnJWdXkrSmFBTk5PdmJiRmJQ?=
 =?utf-8?B?VEtNTmFOL3h4c0lCaHhrbmRtaG1KTzNsb3dhU3BsS3BHMEhQTFBya3lEekxp?=
 =?utf-8?B?ekN4VUg0NHVSbktnWlZVd1NLTGE0cUxHVVBydVdGOTR6dlNEYmM1WkNFNFRj?=
 =?utf-8?B?emVLdnlNWUhRQ05meGJtRWoycDhMSDAwc0JLYWFhVU9vcEpJbWtydU43WUxX?=
 =?utf-8?B?YnhkTlJla04vdjA0REhrNEJZRHIwbWdYTE43bjVUTWJ6cWJSQytWRjQ4dUQv?=
 =?utf-8?B?QXcwOUxPdUt0NHFGMEpRcUo0b1FFSUZiTXhwamVRd1BudmxBQTBsM0IxUzZw?=
 =?utf-8?B?N0RyQnQ1bW92SEZhYWZyemRrM1VTU280UFhCOVAybXlVZ3A1ODVjRTBmY2hP?=
 =?utf-8?B?VmUwelR3K01RWU0xTFMxMEdKbnRZdkVzUnoyTDdBVERaTzh2MVhNSzNiTUd0?=
 =?utf-8?B?d2ZBRGZ3TVFlcjlNcjRlYWU5Z2d2M3p5ejliSy9VbGdwelhVQzIrbTdPWVFl?=
 =?utf-8?B?KzkxSE9NUjBGZ1ZvQ2FrMGdrRzA0ZHZVL3I2WGFPbDRDWDZwZHdJWWZUKzNP?=
 =?utf-8?B?T0ZaNVVqUHI4SklIOFNBTHUrRnJTRGtwc2pTeFh6OXpRc0NrRHg3NDRhQXhQ?=
 =?utf-8?B?QU9KZlhOM2V0d2VRT2FDN3NEZENnall0c0tzN0RZeTFnbk1SaWlEcVVRUTZK?=
 =?utf-8?B?ak92M0o2TU9jcjlxdUFVdG9uMk91eFhGSmxCQVVRWkgzV2toeUtWVmN3WmZp?=
 =?utf-8?B?YUx5Mk91REVKU2Z4U3FTZTBienozRlVyamRJZ2ZQd0dVQW1FL1gvMmlTQ3li?=
 =?utf-8?B?ckNIRXdBMXMwcTJYNjUwWmtHenhqdUIrRk8rMlFrMDd3amhhSUZOWlhsNnAy?=
 =?utf-8?B?MVNWbjdhK3RHNUVraXNzTERNem5YaGFUZzYrbDFDRGhhMmE2V09hY3dwZW5J?=
 =?utf-8?B?L2xNOFNhZU51RlBiVmtISEN5WDQzY25uOEZmMFJHQzFXOFY2SUFjWjlNTW16?=
 =?utf-8?B?V2lwRWZKdlY3aWlHb0I3Vk9zSFhDUGhXejMxRDFBKzJDbVcxL29LdkdHYVAy?=
 =?utf-8?B?VXh3SFZ3RzRrYmJsQlpCQXZYTk1MZlRzK3E1MTVTbUlsbXBYdm13VnoyTS9V?=
 =?utf-8?B?elRjQUlmMUxLRHBPR0VBeGFKTHVTTi9YdjRoK203N2c2WndXMkJ0NFRJa2t5?=
 =?utf-8?B?c1o1UjRZVnBsaXFzVE5IenFuOXlGb0ZnMjJxZ1BzQmlobm9CM1A5YjZWYXBM?=
 =?utf-8?B?RC8rTzNrUm82MWlrdDZSVTYvaDhIaDBUZ05OYVRlaTZFai9VVXF3VzIxaTJE?=
 =?utf-8?B?eHVQbk55Q0FKQTEzL0lNQzFkb2s3MTlPUUJqRmtoQ205UGN6S2NIOHU2S1Vv?=
 =?utf-8?B?NXBodG5CUmRjRHRDZGlTcFlSUEMrZXZMNVN2ZUNta1BqdThQekVpQzgzSlFD?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1717808f-ffdb-491f-606e-08dc768b02d3
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 16:04:20.1435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmhbS/TbIZ38LzAlPGELkFzAuSlQKKj/ta7sGnEg2+gq7uAw6NYNKzSV6ywBSz0QNmWD3ngZ23JKWWGvNyXx8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9294
Subject: Re: [lttng-dev] [PATCH] Fix mm_vmscan_lru_isolate tracepoint for
 RHEL 9.4 kernel
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

Hi Martin,

thanks for the patch.

I changed the version range slightly. The RHEL kernel 5.14.0-427.13.1 
still has the `isolate_mode` parameter in the `mm_vmscan_lru_isolate` 
tracepoint; it was only removed in 5.14.0-427.16.1.

I also forward ported the patch to the master branch.

The updated patches will be reviewed at: 
https://review.lttng.org/q/topic:%22buildfix-el9.4%22

thanks,
kienan

On 5/17/24 10:30 AM, Martin Hicks via lttng-dev wrote:
> 
> 
> Redhat has moved to using the format first found in the 6.7 kernel
> for the mm_vmscan_lru_isolate tracepoint.
> 
> Signed-off-by: Martin Hicks <martin@sr-research.com>
> ---
>   include/instrumentation/events/mm_vmscan.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/instrumentation/events/mm_vmscan.h b/include/instrumentation/events/mm_vmscan.h
> index ea6f4b7..49a9eae 100644
> --- a/include/instrumentation/events/mm_vmscan.h
> +++ b/include/instrumentation/events/mm_vmscan.h
> @@ -369,7 +369,9 @@ LTTNG_TRACEPOINT_EVENT_MAP(mm_shrink_slab_end,
>   )
>   #endif
>   
> -#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,7,0))
> +#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,7,0) || \
> +     LTTNG_RHEL_KERNEL_RANGE(5,14,0,427,0,0, 5,15,0,0,0,0))
> +
>   LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_isolate,
>   
>   	TP_PROTO(int classzone_idx,
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
