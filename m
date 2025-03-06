Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4B0C28B24
	for <lttng-dev@archiver.kernel.org>; Thu,  6 Mar 2025 16:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1741280306;
	bh=s8diTVK7WXoK7tepTLhsG6LZvkx3PChJgRcxxL0QADQ=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=MMcEuJ2ykCyIuqL3jJNBquxdmq6NBSxOUhBqBs68ZM1+f86c44vWEcMxSWWzAbEBt
	 g1agBMrV5evPiqMPboEnkr30s622Y9cJZU0gvMEFoTaXdCSHxV5MnM61FyL+ZUaWsN
	 8G/1nZGd3HW5Ob+GNYSZoHAPGXy4ryo/RKpsQoelIDb4jXlsrL46okT6uI6EQ77ZAb
	 IvgnJDqeQBp860cvOUvjuYCBkgW+yCjkdPAwuUZn5n24BnSkkv9rrYKo3g5NmiSXOM
	 Iubl/hzi5EE8aW/CYuvZv/Ae7d0UFj+LoCJks1ejJD8jc7fGJeOTqE8gT3byQyg/oS
	 p+vSsjXetgMgg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Z7wbk3B4Zz1rdQ;
	Thu,  6 Mar 2025 11:58:26 -0500 (EST)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020116.outbound.protection.outlook.com
 [52.101.191.116])
 by lists.lttng.org (Postfix) with ESMTPS id 4Z7wbj6XV5z1rdN
 for <lttng-dev@lists.lttng.org>; Thu,  6 Mar 2025 11:58:25 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdX235XBAwSWb/L69Z9BF10RIzKO6Q2jceGz0JTdt9+aiHZNDOaaNicnA9K5/Ne6CEuAsYuhgtS3EHzYynLFRI4a8fzR+vonyO8z0iFEVVIS5MzDbeckVMNG13uIlXuqV34XJnVctiOOtP3lp+5uPNcRPmvDuigNMaVd1buM1mh3Bw5NaFYYtu94I8pN/YOVtUyCQJlWYPCDqyvHM11Fz2k34TCfhWsA2VDrJfnxeYHatCcTGugaAVXRKNPQh4WINXNWNXdnUGGN7Jc0T7RhDoRb0iAZ9V+AdAaC38cDMwunJvtgA9qNLfRQQYMaYsMOmeTeE/jAL505n5pOpomJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfHzbOxIf6BUJY9wXOOjFZWdw9guDSBmDu9XsSvHYsw=;
 b=XFQp/FzM/nFJrcT1tnR/JpZAy659onQWYjLJGvVoTGaxnC4S60j2CqPbe9QGvCtTmLeEslpIvMtB/8ZbnMZE4x38n6TnE7eufG4nkSy73srvv6mKwejz2iUXiPactERL0LMYuLtbDOmMUIIUF4xXRqXzKp42g5m/vZ6LGUat/m0ul5PqxaRqGC4x5NRtBWlyCIhJ4GwSXkH8lOLj8S8gAb3laVQuuWLg/kfdRNeawG1RUh0ALmX1VUYtXSf6NQeNP4702zmRpWJCGILBTnunIg756cLZSGcHpiMqIO3EZhbAu0WPlf0u31N/Twh/SvfRB3u6Yy3rXkE3eSGmGEkCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 16:58:23 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 16:58:23 +0000
Message-ID: <7d25653c-5082-4632-8bc8-a387d41760e4@efficios.com>
Date: Thu, 6 Mar 2025 11:58:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: need help for avoiding system calls while using URCU (Userspace
 RCU)
To: Kienan Stewart <kstewart@efficios.com>, =?UTF-8?B?5pa56ZS0?=
 <fangkaihit@163.com>, lttng-dev@lists.lttng.org
References: <5bfbaea6.79f9.19560340335.Coremail.fangkaihit@163.com>
 <ab5ea7b4-abd6-430e-bc2c-52762654301a@efficios.com>
Content-Language: en-US
In-Reply-To: <ab5ea7b4-abd6-430e-bc2c-52762654301a@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ccab29-0a30-47a4-6141-08dd5cd01ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVVIWUFXVE14MTNmd0NJOE9pZERVSjFCYytucU1MR01nVi9PUzNtWEpudkQr?=
 =?utf-8?B?UGZTQS9Hc0dqSCtNRC9JUCs2YzZVcTVrTWczTDJMdlZoQWhaYVcxb1BNejd6?=
 =?utf-8?B?djNHenFuNTV1dXE1UVNJOFFSUEVJdmZZMFNSSCtSQURMS0RaOU8raXFodnRk?=
 =?utf-8?B?NTZYWjgwMkpDOFk5WVVmSG5RQk1zN29DYXh2YVk0Vm9Jdm1wbDcyUnBjTlhR?=
 =?utf-8?B?K1RCVGJ3OTJqUzB1b0ZOK3YwSDh4UzdKWlMySXdtVlFCQVJ4U2pqM3hjVUxG?=
 =?utf-8?B?QlVZeEJQMjl3NEI0ZDVwRU9BZXg5OTZsWE9QMnV4aGdDRnh5STVkbTMvQ3RC?=
 =?utf-8?B?VUtRam51dnZ2RjdmSTFFRUlOdzkvVFRTVUNYSXhPUFlQOXptT1ZrNmI1UitR?=
 =?utf-8?B?K1EweUNTV1N6TE5IbTFuMExnbGtCSUUvWDJDR2xLK3pob3BPa1Ezd1ZSK1Rm?=
 =?utf-8?B?dXlPVTNTKzBZVG1EVXlxRUd5Sy9mZ3B2Si91WXJnTWxyRytNZ2QzYVlhRXF6?=
 =?utf-8?B?Und1RGVRVGU0UFBwNTh5a2U4NitoNlJ1ZDJNZkY1ZHMraCtzWW9sQUJPd056?=
 =?utf-8?B?cmQybEFKS1JHcitaYkdOQk9lOEFuR2drSC9YSnB1MXQ1Sko2aUJiUlhCSUNH?=
 =?utf-8?B?K0FhL01NbE8yakNSYVhHNnJGQUJ1NGxkL0Erd05SaU1Jcm5HZGxMSEdzc2ow?=
 =?utf-8?B?ekgzcXJhZno4UTdZcjlOa2NhYTgrblZTQWlUTTJkWWRKTkRuZ0NKWSsrYzNq?=
 =?utf-8?B?b1N3bDdCTHc1ZUhKSEEyNmJDSWdlcU1UampyQ2xJRG1RUXR6bXk3RE9TMkJ2?=
 =?utf-8?B?bG43V2pTRTFSVlF4b3VEa0NvbCtHZUk3RG1Qa3M5M0NHc25iMHJ6YTNKcitx?=
 =?utf-8?B?QklOYVFZVkxyNU5aV3JXR2xxMFlkd1JQaXFHNEpaZWVjeTJ1ejIyOFBOT2l4?=
 =?utf-8?B?K2FlaGJEVGxXNk1yOFpNak80RnFoaXJzbEF2aVRRcDFraHY0V05PdTgvMHE1?=
 =?utf-8?B?LzE2NUZSREQvOXVhYVlNa0U3RzVpSTlkUDNnbzI4OSt0UnFpWnRrTzZ3dG9x?=
 =?utf-8?B?WU5ncXdXNFM4aEtNWW95dzd6YkV6MG1XejZCOGxoMWVNSUhuOGtnaG80K2la?=
 =?utf-8?B?V215UVpUU3djclBwY1U1bzgyYTcxRHVGeDM2eXhFNnAxcTMvelhuR1IzS3ow?=
 =?utf-8?B?ZnorVXVTMndDL2grUEE3dndRbHEwa1ZpL09NcXprZVcyWDRJa2ZaRExrb2Zt?=
 =?utf-8?B?NUU1azF4dWIwbTR3d1ZsMExHYXNKOUltRzdhMGtMNTMzUHdRRjdaZzBZdzVj?=
 =?utf-8?B?OVFMUkFRUlZyZnZHdjkzTnN0YUlqd0pETkd1VUZnaURiM0N3ZUhPY0NNR04x?=
 =?utf-8?B?SzdhcXQ5cDd0R3RLeEZtd1JRcGtEV1JaMGpHTzYwVGhZb0pOcWl3YzRUVWhD?=
 =?utf-8?B?RzZIaEFMbnp4NjhuRm01Q21BRHQzNi85WFc1eHh5RVUxZU1nQnpMZDZNUGw0?=
 =?utf-8?B?dUhhNlB2MklMdVcrOVZWeHhKUXVyYmY4Nm5kbXlEb2lHUjBiZGhOQm5XRHF1?=
 =?utf-8?B?Z0V6dWhHb3hSK3FKalZobGQ4YzBtd0MwYVQ3SG9SRmZGaDU1QjlMZCtQVldO?=
 =?utf-8?B?dVMxNVArMjcxSHpOT0thOEJFMHRCdVBOaVNYRTBFZlpkYnMydVpaZ3MvQkVR?=
 =?utf-8?B?bGNxcFlwZ09vRXhMdEw5UTZ3S25vVllqS1RwVWNJSndpUGFDOXU0Mjcwakp0?=
 =?utf-8?Q?AHVykxG27s8FMHB2jlvwHJ7eSxz4FXs6NKrxJDi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1J1NnNqaHJibXR1TTdSdzUrRWVaNTZRR3B4dG9aVjQzVlRDWnZlcFBDQzBM?=
 =?utf-8?B?aE1XYldGUUM5T0ZvU3JidHg1TUc2K2dIc0Q4WlpTUzFKS1pkdVk3RlFOZWFR?=
 =?utf-8?B?cWJpY1YxdUxJVG5WdVUrTWdMQlgzenNWdEdkYWlNUzdQU01aejNyWW1VQ1R4?=
 =?utf-8?B?eEpnRWNvWmJJOWZKRFVoaTRmK1ZuMHZZT0dlN2lrOER0VzVhVkQrU3dvN2RT?=
 =?utf-8?B?b0UyNVV5RTVwOUVNWkwybDl5eGViNlN5YmxlU3hCaUdSWGJFNXBmbVdPVnVz?=
 =?utf-8?B?cXM3QmpDUFFHTHo5L2xhMWlwd0F5VGhQQzZVQ2owdXN0YzhnUnRDVmxFUzl1?=
 =?utf-8?B?ODZRSExGTDBscENJOGF0MWFTSW9yRHNCTVdYWWRiM280bUNnWmRMcHQrY0Y2?=
 =?utf-8?B?Q0Uzc2lrbWRKMFRVbitRMWhLMG5zcUtabWw4Y0NMalhDYXMvWm51TUMwUFlU?=
 =?utf-8?B?Q3FlWjJYUmJrL09nTVdrNmFCb01HTys1OFF3RzBwTUFzaUVGT3F3dHpzbFFv?=
 =?utf-8?B?eU8xQjdZYjlYZ2FsaXl5TXRHRFc4QVV1bE1Yc2RMeWdmT1YrdlBxaE9Nejlq?=
 =?utf-8?B?a1FCd2x0UkJxb2Q5dmxQQy8yNFNlR0pqakVUNDE5MDR2cjlyTjk3SXVlUzNw?=
 =?utf-8?B?cXk4NlFxWlcxcTNtSWZpMktwVEU4ckxwWmdGQm9kcGpKOURMaWFwSG5VNThi?=
 =?utf-8?B?aHRpY2E4b2sxUVd6REFvVGhMdkgxK2c2QVZFVnN6ZWVXdXgxeklLRHkyZHBP?=
 =?utf-8?B?ZWxrNXQxcXpyT1gycVJyOW9ReUFSVVZvRGJxZmhWSVpScXNQMWt4S05rdXV3?=
 =?utf-8?B?c2lYbCtPVzlCMmtZN2dPV25lQ3V6djVvNkdvcEI1T3hFUkhnL3lyV2w1K2Uz?=
 =?utf-8?B?ck5ObVRmTjRNYlJMdGwveUhzbzZmcHRlaU1rdDhuVUtUVy9mK0J2c3g0RE1u?=
 =?utf-8?B?QmJDMVY1dTVRZjRoZC9YR1hxL21uWEpWMnl2ZUJmYjJwUnEyOEgzTlNBQVN2?=
 =?utf-8?B?MHJGdVZ0emtQOGRPbFVNa3EwdXdOcGFNa0NVTEVlTG9VZTZ1a1ljb2R6UXEw?=
 =?utf-8?B?K2J3ZWlpam5FaDFwMlY2UlM3S1p1Y3lncFpSU2J3d1lrcG12M1pqcU1GcGt4?=
 =?utf-8?B?UHM1TTh4QWtFY1pReUZ2NU5QeDB2UlpDRnVNOG5LRHNxUFN4RHVXSHd5dXVN?=
 =?utf-8?B?bGt1V2hmWHBaWlhVcVNpOE1MRkVBS0REVE5SNUkra0ZRTFJoZkNiQWFDMklB?=
 =?utf-8?B?L3FNNVp4dGZENWJlWVpXTEhYV3ZXTmg4S05CeVkvb1lQa1IyYnFnTjdTcS81?=
 =?utf-8?B?WmtXM0FDa3JpVTdPSWZLUi8yaFc1NWIrUkRCOTBGMk9zNGNZRERHY3R2ME1z?=
 =?utf-8?B?NXpOWVFPVTJKTTl5Tk4xT1BIeWN6YTdGMVVkREFGb1Y3bWc1V2FubUJyRjI3?=
 =?utf-8?B?NVhlMlkxR2RIcGw0NDlTcytDNEYxY0pLSE1BZDBXRVZIdkhsRk9tbWNTVTZh?=
 =?utf-8?B?R3BaL1MyNXhtcVRPbUlxK01jamZkVjhlUGxjM1NubUx4YnorQ0VFaTEyYmVw?=
 =?utf-8?B?Z2NSUEdJNUcrYVkxeld5TWY2SGd4QXE3N3NHbmZIeC9GQ0R3UlVZOVhuaTBy?=
 =?utf-8?B?M1dQQXZZZlpWTmNneGYxSU8rWGtYTWNtKzJlOHNVOGJwZmhybmtoMitMR05k?=
 =?utf-8?B?S2lxaExSa2I2Vm52V1pNbkVvQ0xoUEJWTmtKZUVEelZMOU0wUFcxdWNDZ2F0?=
 =?utf-8?B?dkJHSkMzaUh6NGt0TXFPeTlrQ2E2NlBUdXdUNHllZDNhMUs4dGxJcTNBbFU0?=
 =?utf-8?B?VU1JbkhGeDdsM2VmWE10a3dYUUEzdlBWc2MrOG5YUkF0Tk9EcnU5MkRrT040?=
 =?utf-8?B?SWRlZmZqZGJnMWtmdXB3c3d3ZStoVHozc1B0UWlqbm40V0k5Umh6bGxTQ242?=
 =?utf-8?B?OGJhNGk2TXZURk0xSDQwclVvcFh2eVZtbFFZNGtETlpVdkE5bkVZL2lqQ3hJ?=
 =?utf-8?B?dWpFSlpDY3lTcjJhdzJKYW1sWGttNnByODkvVUdRVDZOTWhyd2U0dkx6R1Bm?=
 =?utf-8?B?UFFZWmN2RG1KMzBTQXBjTm1TNnRINU9iMEttc2JvYXcxYkFqa1VSMDd4QzRr?=
 =?utf-8?B?U3FCMUduZTArY01lZ0xLcVhVQ1B2bkFMM2RFRzlZT3l2Mk9GUEx0QTZRcFR2?=
 =?utf-8?Q?fcNZabPWPSxSd1UgijL6My8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ccab29-0a30-47a4-6141-08dd5cd01ae4
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:58:23.2243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBTCQNoRpYcNakm8AxIZls1m0LYy9yZyC6JfaUWQqhOI0NRvBOmn1h3br0t7yRxM7HVQy4Ldl+uAT7eH7uESop0YuQYLtHW8oJLuYGAMaO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8140
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

On 2025-03-06 11:17, Kienan Stewart via lttng-dev wrote:
> Hi 方锴,
> 
> On 3/4/25 3:09 AM, 方锴 via lttng-dev wrote:
> 
>> I have referenced your project, URCU (Userspace RCU), on GitHub, which 
>> is based on the QSBR model. However, I 
> noticed that when using it in user mode, it makes system calls to enter 
> the kernel. Could you please provide guidance on how to address this issue?
> 
> Are there specific parts of the API that you need to be user-space only?
> 
>  > I aim to achieve a pure user-mode implementation. Specifically, I 
> would appreciate any insights or suggestions on avoiding system calls 
> while still maintaining the functionality of the QSBR model in user 
> space. Thank you very much for your time and assistance.
> 
> Currently the locking is done using futexs, which are system calls. 

Clarification: the wait/wakeup between read-side and synchronize is done
using the futex system call. There is no locking on the read-side
per-se.

Thanks,

Mathieu

> Those could potentially be replaced with a poll/retry system either in a 
> different flavour of URCU or at build-time.
> 
> thanks,
> kienan


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
