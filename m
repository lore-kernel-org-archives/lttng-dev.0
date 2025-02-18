Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE45DC021AA
	for <lttng-dev@archiver.kernel.org>; Tue, 18 Feb 2025 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1739894813;
	bh=ZnavWF9p6Oq0VdhaBPEYB9LiUw+KRbAxNQ8fWVdDmOg=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=h7QmYTsYvC58QbqeTkGTTaDFn1sD1wqWjZHPIUqYEe1wlJOgc/QHZMfxK8pVKMq2/
	 u2piEpr8JH2vgg7XbsGDkMqA8zvq8OhTFnsiAz93NVh2oc5CXWQOgySYZ43cERDg/d
	 HYEL9b3cuz1g3tR2XL8VYgMcHHcec3k3OEStNgT26Cx9mlLvnfYVbVPLv0NvYdNcRX
	 YYOy+Uk7NdzkJDAsOPLPAFaNXLLnD1KxU5huoOzu2he+BB9mnvI21xMEdwTZnoijhJ
	 QsDM0aeD+AaSpJraI1YYO59ppty6JyH7nupcHwagFkG33ToNDgB/Ig/b9IVI6ggz8o
	 Mi3+4ciIZRCxw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Yy4Cd0pgLz260m;
	Tue, 18 Feb 2025 11:06:53 -0500 (EST)
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020096.outbound.protection.outlook.com
 [52.101.189.96])
 by lists.lttng.org (Postfix) with ESMTPS id 4Yy4Cb1FPQz260k
 for <lttng-dev@lists.lttng.org>; Tue, 18 Feb 2025 11:06:50 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mR9aXVkDmwpCdsINoscHolG1c51FkP0nQ3I7E34kQwDsOb7sGM1pVSHTFHdoJr3Tv3HG/P7WhhcDsF2Gt3jrf1UU9JPII3hWB8Ed11wEkX2DtCyTcnk8ECUNEPSdHWxItYOLsq4eW4RunRpPPzpFRUNzUgLJIbZLGJIMeh0RG8bJRSeslY0ysXbrJCvax7aWfgyCxKBWQPG6qeoj6Wd078TXJdjdIH5u7qXdjIelz9q0Lf4XzHDmPjo0RoyCHAe5Fk8jkii7jJtVjBS9a3PJahq+yx0JohhJzoyb4MMXcqRd5/P9fMbUVJ0Jn2AKyVy9cCZG6eZ6VSXTpe7VZGCljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wth7QwYy2N0jdDta40hwngryCT/WJOSojWhz+1j8mFg=;
 b=ZpRoUSx0WpifLii/B87ojF0h93UCVoW93bqCrLZJFulLUhe2YJdoBJHibR44zu3XuYxNqb5Mz7N8d0Wl9bx4zs47w+rWBuxNJJujwNqZqqbkQcfvqiE66twJzGJM/ZwuFfHVcYugkDKs5fMAcD+Fxl7mQ/OL9RlIO3neyBr2Zap3MJ5N2XXwlo7lDKeeEacfu5KrS2fzhy5VwFOQU4eWd5+eqcEa+iaeUijv9N/844gt1T/bmRCIdmCJ9yDCHO0qwEt5eExw+2VLepfx+RuMWXDR7Z4n+6rN4Bjk9qx90Zq1zXG6jX/ySAv8MtT7bewpo1EUj/7oN8ELAEkBcn/T6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PPFDF5E99EF2.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::494) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 15:51:15 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 15:51:15 +0000
Message-ID: <6894741e-c3c8-4464-92ab-ba8b88929961@efficios.com>
Date: Tue, 18 Feb 2025 10:51:14 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RELEASE] Userspace RCU 0.15.1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::32) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PPFDF5E99EF2:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fd9f5e-8583-4261-0b9f-08dd50341397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nnc2YWJPa1hMWkJZTEV4MkhZRGM4MDNqNXc5ZWorVGx4SUdnaWp0NGQyOUJy?=
 =?utf-8?B?dCsyeHpMak5OSWJWaVorMTE5OExVTVRZK1BrMUpVWFYzTWNqNjdMMUpDMGFG?=
 =?utf-8?B?dzdWOFVFRDVyemozRDM5K3VwK25ud3BFVWNNa3ZQdU4yK1ByYzlOSzFEa0xr?=
 =?utf-8?B?T3hmTC83RDFSWFd3Wk1FY2VTZVBocDJlUWRTM2tHN3RUUXhvS3d2L2lubmgz?=
 =?utf-8?B?ck1zbXBBbzlKVVloYWFqVTlYeWVNZjZ5QU9lK1d6d2FvcnVibUdwL2RSODND?=
 =?utf-8?B?UUJlc20xdCs4aTQ3VWRoTDJUZUNKNUo3ZDZFWGd6Q1BNWkdSQnc0bHBIYXVa?=
 =?utf-8?B?aGIwMTAzNEJLeGsxblJ0OHZmdXhKYXdoWXBVSDBBTHQxVVRnRUd3a2w5bVE3?=
 =?utf-8?B?RzZQbFBkQ2RmUEJobzlwSmJZZ1dSWFJTaC9LRUJac29HREt6WklLUFR5U0xH?=
 =?utf-8?B?a1VFRnVLaXEzdCtNSStGeHQ2dDhJaHhtcllBSVQzczFwMzZoT0R2aVhiMkQx?=
 =?utf-8?B?a0Y5MTc4SU1LdEpxaVFEWG11bThtQVA1TFJuZHdObDdDUk8xNHJIVmV4a1do?=
 =?utf-8?B?WkpZUERvWEZmZGlxODJRakd0UnVPTmdYT2ZYWkpqenVqNWsvTEFzNmNBQXpV?=
 =?utf-8?B?Vk5tbE9RbitnbytDTDArdWlLZmxENlNBdkh1ZUtsV1A1SHBKVlkvZVJjZk43?=
 =?utf-8?B?RjFNWjlhc25OTEorNVBVUnVITi9pNE5tWmxZdkxCdGF6aXFOK1N3eGdNa25o?=
 =?utf-8?B?aVpZdmYrRWFpLzVVMEczY1NCQVJhbytmSW91dWhnSlBqeHNyalMvSGpOMStU?=
 =?utf-8?B?YmFXSzE1eS9UMUJqY2dmQWJ4Zk9RaFFONzZtcDg2QjlpN0M0eXVVL1dUMVNW?=
 =?utf-8?B?ayt4bVU3NzFucFlGcVZRdFNqdTNBQytaQ2NVTXhCdWR1NUljZ1VNT2xXRVVz?=
 =?utf-8?B?cHZySFI3OUlUUnVPVjV2ZEIyRjFyWE1mZWxUa2JmUmlYcEtPdXNGeUJtREs4?=
 =?utf-8?B?WUN3enBHbFB6dXY3NVJsSnVZOG1pbEI2TGFESEtENm1RbWVTNVlBaGFiV0pz?=
 =?utf-8?B?aDhKU0g1U0ZrOStsWUFFckJlTjAxNWFMZWNWZjVnR1Bjc1VQdTlQelR0YjIz?=
 =?utf-8?B?MzVqSk5HTkJIR3k5M0Exek50QmNyQ2pKYmtJTnVpN0JYMWhTSXJiMEp5OUZP?=
 =?utf-8?B?RWN4aDdoRnNsKzVYeEZwUDFrbU1FeWR0T2RSNndodGoyNmtHbjF5NytJM2wz?=
 =?utf-8?B?NGFldzk5Ym4yQldFcnIvVFBRTkduaWlZR25nMXcrakhYRHlsYldmZEFjNnpJ?=
 =?utf-8?B?SVJIdnh4a0JibnVMazAwR0ZlM25yY2tSUVphSFFHNWlqWmlOWEpvZ1U1S0JB?=
 =?utf-8?B?OW9nRHAwcFBjdjl3MVJIaDZuMGhvbjNobWV4bzFVTVZrUU0wVnVoYzFXRXdx?=
 =?utf-8?B?aEk3QTVQY0lwcVoxd3JabkV0bXE1RTA4cTBpVm5KQ2tuUTZTQXpzdDBUcTZn?=
 =?utf-8?B?N0JXWnFyblhHV2xXK2dFTWxlNzZoZmZVT090aEI0YjZZT04vWFdkb3pmVHhU?=
 =?utf-8?B?ZjJLVHJzaGRYRFFXcjlDc28yTHJ3OXlxTHVHam90Z2YrMXhVcnJWZlEzejB4?=
 =?utf-8?B?dEVDaE45a2RFSVRRemlPMEl4clZuaHB4a2hwRXNzcnB5N1lIMVZ5VXpUOWdp?=
 =?utf-8?B?VlZ5TGVPMko3RzJjZ3FCODQ4K3d6VFY3Q1ZyVG9TSVc0M1c0dm8zTy9qQzEx?=
 =?utf-8?Q?Zz04wp81tYZUeBr2QZPbt5ku8NzqLSQAhBUTrEY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TktxdWg4VjV6Q2E1cTI0MTNtclJvRVdIaHJ2eUdyZXdoczFrazZsRGU2NDcv?=
 =?utf-8?B?TzV3N0R4MnR0cEt4TkZrOWlGbitjUXkwcGE2L2FQRGxNWU9uOGZGc095R3Yz?=
 =?utf-8?B?S2tlY3krQmRGNGJIWStUL0l5d3NRTUtrMWV1TVdHa1BaL1NZZVVvMDJ3Z3VZ?=
 =?utf-8?B?MjZlZnNURmR4c0VlTERiYTF4L2V2bW9CZGMvTTdBT3FXWlVrS2pqWmlFbDNp?=
 =?utf-8?B?RmNpUlo0dENwdU9uWXR6NktUcjVIWDUxLzdBTG9vcE1ZdVE1WHhDc3dENEVk?=
 =?utf-8?B?UFFWelRiWmVpOWlhTXQrelRUWlZjQmtFT0pWY1dLcXdreVo2MGJUYStNZnh4?=
 =?utf-8?B?WVBmRTV2eFlVTzg1VlhTVFlwK3I0QlpxcUc5Zml5ZUwzZFVHaHl5ZzllcTQw?=
 =?utf-8?B?YkR4dHFPUVM2anZMY3ozQW1mUjd6d21YQ0Qydi9qRU0zUThna3BaZVNYSjRP?=
 =?utf-8?B?VC9NcTlibWJ3T2FuSzhFVVJlNUhvak5pQit0b2VDSXZ6aHI4OUZYazhHUzlB?=
 =?utf-8?B?ZXhLd2R5R2JCRjRZblJrRkdQaHc5M2dLZjJwQ2YxRlgydTdCTTVKS2pjLzlO?=
 =?utf-8?B?aTRyblBoZEcrTnpiY25tV2MyU29QOGxnS3BuZFNrKzJEZkhnd1dLRnQ0ZzBz?=
 =?utf-8?B?aHBWeU9pcHhOZ3pDMDZ4bExXN0lPN0w2OVNETHBaWkx3eEZqbUlZeXBkT0k1?=
 =?utf-8?B?MGkweWhFTzBrVmsyZktUZVh5NHhJcnA2d2NNeUNOcU42cWlmampaLzUwdFZu?=
 =?utf-8?B?V2V0Q28xamJiNXdiN3JrYUhqSDcwUUR0Y1N1eWRPM2NpejhRSklDQzB2OGpQ?=
 =?utf-8?B?L1lqc1ZJZWxpS3pIa1pCWnVsYmFZL1lBaVR5YjV6elpCbDFsRnVHRGQrTHdn?=
 =?utf-8?B?Q3BiWnVGTFN6a1dFYmRZVjM5ekdWTEJnUU9IenhMYWJqcm5XVDBQeS9nT0JW?=
 =?utf-8?B?R1dodWVRTEZzSXIzZHNtZmpyOFBPTGc0NGJBR1lubjZjOWcvMlpzcS9zaTF4?=
 =?utf-8?B?QjdzZTR5eXZyRkxmWXQ3SFJHMEFIUFlFbEZPWjJDd0VzWXlmOURLSVRMTzh0?=
 =?utf-8?B?azN5ckhHY0VKRldwamtpR2cyNTc4d2Z0SndlZHh4WUhiY2pqTVRueW9EWGZr?=
 =?utf-8?B?V04ya0xHNXRpTlZ5b2NtYTZUSHM2R1VFRXJ5a0xuWlRUbEt2K21wZmlQMjhF?=
 =?utf-8?B?RGduTVJOdmZIaVJZVE9sN2NDUE50cUgzL0lvaWoyQXNicXlUU3YxK2RWb1hP?=
 =?utf-8?B?dkxQc2c3bkNHdFI1Z3EwWTdIYldZUFhVVXM5MjhRVlllS0MwMEtGckhyK3pn?=
 =?utf-8?B?TUttUWM1TFRZajRnRDd2RGN2M1Zoa1dQT3k2S0x5TXowRkNoRDdNOXNFcG5T?=
 =?utf-8?B?ZTZZcHdlekMvK0NudTBQa2V5Z01RSHpKOGtXY1Q3Z04vb2NSNTZIOFpaN2Zy?=
 =?utf-8?B?RnJBWVJQYWFQRlluTUs5bWg2OVEvamdhcGpnY1k0Q2xpcS9WWnRrT1dKZ2xR?=
 =?utf-8?B?MWtkVXdVV2ZrNHpicldMejdWaFVUbVVSQmNJV0cxZmNnakR0aDdMY0xTSlJ0?=
 =?utf-8?B?UXlqbE9hNWpWa2dGdDBqSUU3a2RCRDJWVEhpS2xCV2xwYUtGVFJxbnZqalZ0?=
 =?utf-8?B?d011NjBmeW51b2pDeE1neVNkZ05rOHgyN1FyWnlpb05LdUNxUDR2QmQ3Yy92?=
 =?utf-8?B?bDVpTHF5a1IvNy84VGd6ZU1qZHhMQWJtN0ZwZnhGU0JHY2M3T1ZyK2FSTWlw?=
 =?utf-8?B?enVYc2ZrRUxYTkp1TVo5dXZHOUtnTktFTXZCWW5xdkYrWlR1V3d5MmgzNThH?=
 =?utf-8?B?cTROQkVPaVlHNmhWVkRKd2F4d3QxUFg2N2cxQ3pEQ0pJSGNOcDFTeXZkc1RH?=
 =?utf-8?B?YUNuT3lsYzhmbndwYTAzT2IvL0dWWVRuT0ZNMkZhTC9qV1V0VHBqRUtBVVFU?=
 =?utf-8?B?czdOZkRITERzMys4YWxSKytIbGNVbGZ3ZXlIblNXOTNVUVcrSEFuMU8ybkVp?=
 =?utf-8?B?TTVYWjZBbVZzZU5jS0NYbk5qc3dSYk1wMGhQTG9GdDg1cFJQMWNYUWh3VUVh?=
 =?utf-8?B?Z213dVlmTnlyU1I4UDJNVFJkckY5MEY0RjNCT2FydVlVOHAzM1ZPbnQ4TFQ2?=
 =?utf-8?B?LzA4YkthRjF4U2FhNk03ajlHNTlUMW5EUHA5ak1oUHJqeTEvRWtJUDhhUEpG?=
 =?utf-8?Q?yZ+cLE27rX9SiOSa/SyPG9w=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fd9f5e-8583-4261-0b9f-08dd50341397
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 15:51:15.5140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dygBVftXc+TNdrg7D6QOAiLh2LO9ltSoo+rgLS1kOEd+botC/ggkXBJSvjUy6RWMGbZcTuKcrIK4xtxbr83u5HTry6KtraZcgQSt8tRyT10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPFDF5E99EF2
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

Hi,

I've released Userspace RCU v0.15.1. The main purpose is fixing a
missing include of stdlib.h in a public header. It's a small bug, but it
caused enough issues for end users to justify a release.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

Changelog:

2025-02-18 [*] Userspace RCU 0.15.1
         * uatomic/generic: Add missing #include <stdlib.h>
         * docs: Clarify that make is required to build the project
         * fix: add missing SPDX headers to urcu/uatomic/api.h
         * compiler.h: Remove caa_unqual_scalar_typeof

Project website: https://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

[*] note the Changelog file in the liburcu v0.15.1 release has
     2025-01-18 which is incorrect. I unfortunately noticed it too late
     for the release, but it's fixed in the stable-0.15 branch for
     the next release.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

