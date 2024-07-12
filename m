Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E444EC2BD09
	for <lttng-dev@archiver.kernel.org>; Fri, 12 Jul 2024 20:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1720814504;
	bh=hriY9xjHp0nje/TE1ZprsaW5xoG2kD5lF606Z3UvXn0=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MkMKdtqC45yrCXVY2CzzvSIjKcZ+i+ytukLojuAO15gEblpHgGoyZojG8eDCO0SPX
	 qCbmoJCi+QnsIrYBC5rRsWMAkfWZPB1hFzFT9W+S2vafbfPdDv9pvThJ/w4oV4D9Bj
	 WBZEWyCvSZJnzmWDba9FMXLMyzyQZSzt4vo/eCNNSrtEYlOPqE6klHzbrhS8OpAACy
	 MmmuXEDbNLImxiiI/RDM4/i8Yo82uKUEbwTh7YtoEMEjYi+mkyG4o6sRiFKdAjhfpi
	 csLWPRRJnt3xzQbyhYkpJvfq9yd6crWayDnAcV5oLIKQATSgifJlA5HktcwSWv7kqK
	 AXPGkB0wQq8jA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WLMtb6QtQzBhd;
	Fri, 12 Jul 2024 16:01:43 -0400 (EDT)
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::3])
 by lists.lttng.org (Postfix) with ESMTPS id 4WLMtZ3ftYz11SC
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jul 2024 16:01:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWjAuJ9Jj39KdVYJpLa5t+8nRwB+esEcC9RCBPDoH43o38ybk3pogVLXNgUBeznlKDaLEtcsl513iY8gPmiSwLKdPBfLLH5xKpGNc6/tHanXrzuQ003LDdq4dbjJRyf/dGx/vNsONKQXkOGQNEV90T7zTVMWqPOVyV5cxFrGEI6EKeurKmPfQwE1tkb9RRMXZIDSCPuViuVAPktwxd73o8gYNZgi0uwb2cgFwYOtnNEm0ZKf1caaREqYqcmjLFncWVGKeRpTsYv5O220T/g5eBXlgUlCt/CKagU6SgChXdF4VD/8baxHv9ouIYsN4Hv9qky1rGSA8cxyyXMfx4pnnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yzbff/sPRqw00q2jRT1/hsnpm6n3Q+vfQMsnfwI2IxU=;
 b=agYxklzTrsScAYOdtKzqbZNGrM7e+6YGeXWfRFgJVK93y7Tu0Zf/dxiJap68RIUAKTfDdqn1ExW4UQQ0mzWt/spL7FfVP/ne4oH40nfXzYnim2ycyI9g/yIAFkMocTNIZvMnmJ0qRih1Li7DXV3gyVDH5daKcdgQHcWomxGBVnuroCEYTTUKe819pWfMaEU3UBgmpDaKBYIyBGUJg5/OpJqh6peR38ieAjk0SJCy7TcYhRfkP+UXcZM6MbNzEBp4u22cvCkG2k+D6HNk2KDa4OG7z/A6fdvoFClKYCNSsr+lre/udkGX/Zx1S2EbFs98l76mTLwSKckAe9ezJdV8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT2PR01MB6048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 20:01:40 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 20:01:40 +0000
Message-ID: <870f6359-c0aa-48bb-9964-710bd0ea9cb0@efficios.com>
Date: Fri, 12 Jul 2024 16:01:38 -0400
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Fran=C3=A7ois_Belias?= <beliasossim@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <CAHD10Uhn1kCe7TE7taFQ8ACFJ2CLAKRXp2damYN8xi1SUFdmPA@mail.gmail.com>
 <626d718e-84b4-4561-9016-467db3594c3f@efficios.com>
 <CAHD10UjhpBQdXm5wDxSDdjYojBKXwbLKaom+EmeqNrWheLkQJg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHD10UjhpBQdXm5wDxSDdjYojBKXwbLKaom+EmeqNrWheLkQJg@mail.gmail.com>
X-ClientProxiedBy: YQXPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::39) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT2PR01MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 6987d187-b0a6-4053-28dd-08dca2ad71a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTc0dlR4TWhqRU5IZCtDMjhNSTdxZ2xYYmhwWmp4dnZhNDVneGErbnNBRndG?=
 =?utf-8?B?VDlSb3VQMjRsSmJJNDBIQ2ZDVlZNWUVzb1NkVmNnZlIvRlVvS0FEVTRuVDRE?=
 =?utf-8?B?OWJnRXMxMlhnNlhna3hMeklQVE5sY0puY0ZrMWp3QzFGVkZNM3NaOFJKQUU0?=
 =?utf-8?B?UGZLd1Y3SjBsdDZrSHlWUlJVcWJSak5aYlNQQWk1Z2xwK3pzZVJNbWNmQ214?=
 =?utf-8?B?M3kyV2JPVWFGQ1RrVXJMK0V6eE02em9sZUNJQlBjRVU5TzBLdG1oa0Zwdmp5?=
 =?utf-8?B?eDNEQjllUkRaYW10ZFBvd1paMmxNYktkVDkwSngwV0JqS3JIcUc2NThUYXBT?=
 =?utf-8?B?OXJWeW9Edmc0UVFqcnZKZG41Sk5KTUduaXNOM2Q5YXU2amd6N1lOYXZMR1lt?=
 =?utf-8?B?ekF6aUREbjRiRi8yMHllaUp2cUR6dlkzWDBYaUEycXliV29BU1NsTG1xcXF2?=
 =?utf-8?B?NnozaHdwR0NSNzVSQWhMRWdESnczTExIbE0zRHhQWEYvMHlDMER2b0dPZkN6?=
 =?utf-8?B?WmFCTnh2QnlMaW5JQUNEcXZXVGhGMnB3S3IrOUtyTjlMb3hLeHhFY0FVRkVt?=
 =?utf-8?B?bmVGZ3pvZXNtakJrdGJQeStqZ292emorQkVja1FHSGhYU3BORG1ZMkRWNjVs?=
 =?utf-8?B?TjlmeTFDU1BtcXFUSng3UUZDUTFJZXVEb2VFZ1pBNFVJTW9sbmlIRWp3Y2xN?=
 =?utf-8?B?dXJ2SFhTYjRpeGdpejVSQk1pbWc1Nzl4T25rcG9ZSlRhRUk2dFFROHp4V3U2?=
 =?utf-8?B?WXpsN1JzNktSR2RlVyt2R0dSS1JPWlMyRDZWQUJzK3R5TG0rcEY4dGNjSlJs?=
 =?utf-8?B?UWxLVGtiQ05vK3d6eDJlU2xrNlkxdXlUK2VHNDJqcTNLWFo2eVJSUFBnVG56?=
 =?utf-8?B?ejZoZE5VWUhHNjJGWE5lWEI4RnRjMHVWUHpadVYvUnlXNE1OUXhLb1ZMb3Rn?=
 =?utf-8?B?anhCTUoyVkNxWnQ5K2M2MkFGTy9ycElISWI3dEc3aHZRRUI3UGdHRnRQZ2pw?=
 =?utf-8?B?aW9BbXZlNzg0d0NjdlZIeW1iYjFDWlk1NnlSaEhrUDV4cmNscW9WWVFKc1BN?=
 =?utf-8?B?Ymc0Y0djelhpeStueFZKaS9LQkxPTlBHVzNMQmlZdHJSdnUrdnFhODFpRW93?=
 =?utf-8?B?K2pOWVpWRUt0WURVNWZKckREMTZqRml5TG9TdTlPTjdNSjVvMzRSbGwwa2d0?=
 =?utf-8?B?UEpZc0kxcERZaUczN0JCWml4NmhrY2E0bmtpWmtPVHNTcHpWMjlEUHZNWURG?=
 =?utf-8?B?L1d4YWVyU1UvNDFlVnRGZ2dKRUVSakZWMFhseGRUcHZvZmE5cEI1NEoxYnVS?=
 =?utf-8?B?WTllcnhPMDEraGwrZC9ydDNRMVN6b0VmOWVLcGFTRitkQmpmNzVPd0R5Q0Q5?=
 =?utf-8?B?UVEwUG1QVHFXZnVMdXJ1enNIOUdUN2RyYWdoR05PTHVhQ05ySzJxdHZMejVV?=
 =?utf-8?B?LzAyZGxQNlVRbU9UYXZGR2VFNXdETUpSMFI5eFBrNnp0b0xaSDJ4RnBWd1RV?=
 =?utf-8?B?NnhRbUt0Y2wxTUhTNTVKVjF6a09jQU5PNzF3QXA5bHFYTTl1UEM1OTN2NVZJ?=
 =?utf-8?B?anhac2IzRldlZXJaZ0N3ajIvRTArekx6cnl6RmJpT3p5L2w2ZExENHBkSFNE?=
 =?utf-8?B?dUNydnVaZFNKVDV0UGZiV2JyQmUzcWZqV3lkTVRqUW1JVmpLakNoSkYwQXE5?=
 =?utf-8?B?dUlBMFN5N0diMjVEd20yRmdZeDhRZkRTSkxCNEljREpPMXBQNVh4bkdpM0I3?=
 =?utf-8?Q?IZnQVEE5OeusL9q6pQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzJDMmdFM2Qvck9NUUFnSWFvQjVERnVGMDR4WE9YNGdqbzZ2dzV5azU4S215?=
 =?utf-8?B?R0lBMFhFcVN4QlJERWgvQUdQRWJ1dVEwc1pvd25ialhaazVsU0lNeUVNSXpO?=
 =?utf-8?B?aEM5ZmtSTzVmRzNScGNIdkVjNkdvOEJLSTROZHh1Q3ZiSHNQMjYvTCtad1dD?=
 =?utf-8?B?UFQzYXRFQ2tVZTliMzh5WFBHbkxvWGo5eFpMUzZib1IyZDkxKzF6eWxGakRG?=
 =?utf-8?B?cEpHckRLS0xtK2xYTlFUbjdlSjZDVkpjeFpkZStwOEIvMFlxaVVSbDBEYjkv?=
 =?utf-8?B?K3l6KzFNL21nNVB6aFZvdGVIaFIwZExXRHZlU3pmdHVBbE5KSVQveVNhT0hs?=
 =?utf-8?B?d21xU2h0V1NlV05DYXlOWlpYRitDN1ExNkJESzMzeG5CL0lBZkxIeUg0c28x?=
 =?utf-8?B?RXZ0YWo3aWRYMWVpdnplTmdmUVdBVmVVRmR5KzZnQWpQc2FzY0U2S1M1aDNw?=
 =?utf-8?B?OVJ3R3FHSWRDdlN2QkNoSm54Z0hsL203emRya0pxT3BFZXAwc2Rvd0c3SURY?=
 =?utf-8?B?SWtqTHF0TmdCU0NoSWVYbW1xODBSUUQ5UTBUdWhqR3lTcXpBTXl6MGQ3czdh?=
 =?utf-8?B?dXh6QjlTYTRwdldiR0grWENEbGZDa2p1WHNYMy95aWZrR3gzK0Z4aHpDZFpo?=
 =?utf-8?B?TS9xWmdseHI4disxcWxveVh6OFRDc0NPZ2dRaklVVVRheFBndXF3M2ZjWGxS?=
 =?utf-8?B?YVRWc0xKOW1WcEdaNmNRazNmYUJjOU9RMWxPN3pwOGx3d1NNT3RKc2RZSndP?=
 =?utf-8?B?MVdnZkNYVWQ1QkVFT2dkVUxOVWZ3ODZoRnFPT0pYenhxNVBZUjFCbkVrdWI4?=
 =?utf-8?B?MmJhNklOVy8yVHgxNUN0MkdLWnN4MDFSdG5YSkdDbWYwcEVlRTljWmM2Wm5V?=
 =?utf-8?B?TmZXN1lUYnVHMkRLMHZEUmxkUU9VNGRuY1pWRUNCZisvNlVDQWVLTVJNZEg3?=
 =?utf-8?B?M1kyampuUUtQY2lwOFRONlhnRDR3N1RNdEpkYzlJUy9iNXlnNytOWWpuQTgz?=
 =?utf-8?B?YmErdkFYdDYvemNxVmZ6dUZjcHo0OXVyU0R0NlVnWTlDUnNNR3BBSTR2NDRP?=
 =?utf-8?B?MWF4T3luRGdWSFo3SlJSMXArUmFvOEpoWHFTTmJtK3Y0U0ppblFzOW5xT3J6?=
 =?utf-8?B?Q0NPdjRTTkhhdW91Y3h1SkJzTmkveFlEVkJWQml3RkFIVWdFL0Rkc1h2bXo1?=
 =?utf-8?B?ellHU1gxeUlKeTNEamJHb1NvQ09FQTRRR3BsZElnNDU4WHkzODREMWxUZzd4?=
 =?utf-8?B?YzRRN2dPS0pGRWdLVU03emlnRks4N0JaOHZFcS9KcGtTRDhKcmVpL2FyUGJm?=
 =?utf-8?B?NFEvemg1WWZESmRvdko1bVdaa3Zpd1V1eFpwRFRXZjVXd28vMUhWQ0M2SmNP?=
 =?utf-8?B?b0V0NEY3RDFzNzNSc1Nybk1BVlMwcHhZc0pCUi9JV0hSV2FTZ2NQaElUNFEw?=
 =?utf-8?B?MFRWL0cvM2QyWlJTNzVnb044OWdpYjFuM1NSVEEydnBFMjFmU2pBZ1FSR0Jh?=
 =?utf-8?B?a01ocEwxWHNYREtzZFJlVjJ5UFRQcjdNSjczTlc5Z3BvZ3UzWlU2YlFIRHFh?=
 =?utf-8?B?d2VkY1NMQ0lINU80R3h3dGd2VWgzN293WlgwUXNPS1gveE03dFpyVmwyaXBj?=
 =?utf-8?B?S0Fac1VaU21GV3Myb0svaWdhT0RURlVrS01QQzlIRWhiSkM1OVluU3lGY0NI?=
 =?utf-8?B?N0FmMm1vcGpDYXd0dlp0c1dXWnVCNVJ5RWEzVXBsWDVpQ2tIdERHVGdZKzBN?=
 =?utf-8?B?dlhGaDk5UFFLVEVlbXY4ZzVyNVZCL2hlYy9WSkxZRC9KVGlWVHFJUWk3OUUv?=
 =?utf-8?B?QWQ0QVdMV24rMGEwcjdYOSttNFFBbm13Q0Y0Q1hodTlvOWplUFVZV2kwMDVm?=
 =?utf-8?B?a1JFRkF4MnRsVkFjekNSMUp1U3AxbThmOTZib1lKZUFzbkg0ZkUxS1VvdnNa?=
 =?utf-8?B?NlljV1NFbWc0b0tialY4TEdiai8rSzh1b2hWdUFuSnZoUXM5ZGNFd1k5TXZy?=
 =?utf-8?B?cS9Cb09JTUUwblhtS21PS2U0b3F2NWEvNTNiWXM5dFFGWFh0QzIybXdhN1RU?=
 =?utf-8?B?T0hYZzVKQ21GYWxQbUx5TmF3YnVOVmx5RTBuNGVrc0VqU0h2Q3ZUT3dMUEpk?=
 =?utf-8?B?UjQ0cUFWRXZOano4NDROQWRQc0preHJSaXNqMHg1VTdkRlhSTWljM1pUUnBQ?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6987d187-b0a6-4053-28dd-08dca2ad71a6
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 20:01:40.0505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GU4jJhZbcroSxBWEApJcTuC9Z2ORgGIOKW1tFpPGOcOFWJibg7TZj1pkn95nfQT1X3pKFAHOEqZeMcu9vLX7uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6048
Subject: Re: [lttng-dev] Error: Unable to list kernel events: Kernel tracer
 not available
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

SGkgRnJhbsOnb2lzLAoKT24gNy8xMi8yNCAzOjUyIFBNLCBGcmFuw6dvaXMgQmVsaWFzIHdyb3Rl
Ogo+IEhpIEtpZW5hbiwKPiBZZXMsIGBsdHRuZy1zZXNzaW9uZGAgaXMgYmVpbmcgcnVuIGJ5IHRo
ZSByb290IHVzZXIuIEkgaGF2ZSBzaGFyZWQgYSAKPiBzY3JlZW5zaG90IG9mIHRoZSByZXN1bHQg
d2hlbiBJIHJhbiB0aGUgYGx0dG5nLXNlc3Npb25kIC12dnZgIGNvbW1hbmQsIAo+IGJ1dCBJIGRv
bid0IHRoaW5rIHRoZSBrZXJuZWwgbW9kdWxlcyBhcmUgbG9hZGVkLgo+IHRoYW5rcwo+IAo+IAoK
VGhlcmUgYXJlIHR3byBpc3N1ZXMgaW4gdGhlIHNjcmVlbnNob3QgeW91IGF0dGFjaGVkOgoKICAg
MS4gWW91IGFyZSBub3Qgc3RhcnRpbmcgbHR0bmctc2Vzc2lvbmQgYXMgdGhlIHJvb3QgdXNlciwg
eW91IGFyZSAKcnVubmluZyBpdCBhcyB0aGUgdXNlciAncGhpbGlwcGUnCiAgIDIuIFRoZSBlcnJv
ciBpbiB0aGUgc2NyZWVuc2hvdCBpbmRpY2F0ZXMgdGhhdCB0aGVyZSBpcyBhbHJlYWR5IAphbm90
aGVyIGx0dG5nLXNlc3Npb25kIHJ1bm5pbmcuCgpDb3VsZCB5b3UgcGxlYXNlIHN0b3AgYWxsIG9m
IHRoZSBsdHRuZy1zZXNzaW9uZHMsIHRoZW4gcnVuIApgbHR0bmctc2Vzc2lvbmQgLXZ2dmAgYXMg
dGhlIHJvb3QgdXNlcj8KCnRoYW5rcywKa2llbmFuCgo+IExlIHZlbi4gMTIganVpbGwuIDIwMjQs
IMOgIDE1IGggMjQsIEtpZW5hbiBTdGV3YXJ0IDxrc3Rld2FydEBlZmZpY2lvcy5jb20gCj4gPG1h
aWx0bzprc3Rld2FydEBlZmZpY2lvcy5jb20+PiBhIMOpY3JpdMKgOgo+IAo+ICAgICBIaSBGcmFu
w6dvaXMsCj4gCj4gICAgIE9uIDcvMTIvMjQgMjo1MyBQTSwgRnJhbsOnb2lzIEJlbGlhcyB2aWEg
bHR0bmctZGV2IHdyb3RlOgo+ICAgICAgPiBIZWxsbywKPiAgICAgID4KPiAgICAgID4gV2hlbiBJ
IHJ1biB0aGUgY29tbWFuZCBgc3VkbyBsdHRuZyBsaXN0IC1rYCwgSSBnZXQgdGhlIGZvbGxvd2lu
Zwo+ICAgICBlcnJvcjoKPiAKPiAgICAgVG8gY2hlY2sgYSBmZXcgdGhpbmdzOgo+IAo+ICAgICAg
wqAgwqAqIElzIGx0dG5nLXNlc3Npb25kIGJlaW5nIHJ1biBieSB0aGUgcm9vdCB1c2VyPwo+ICAg
ICAgwqAgwqAqIElmIHlvdSBydW4gbHR0bmctc2Vzc2lvbiB3aXRoIHRoZSAiLXZ2diIgb3B0aW9u
LCBhcmUgdGhlcmUKPiAgICAgbWVzc2FnZXMKPiAgICAgcmVsYXRlZCB0byBsb2FkaW5nIHRoZSBr
ZXJuZWwgbW9kdWxlcz8KPiAgICAgIMKgIMKgKiBPbmNlIHRoZSBsdHRuZy1zZXNzaW9uZCBpcyBz
dGFydGVkLCB5b3UgY2FuIGNoZWNrIHRvIHNlZSBpZiB0aGUKPiAgICAga2VybmVsIG1vZHVsZXMg
aGF2ZSBiZWVuIGxvYWRlZCBieSBydW5uaW5nIHRoZSBmb2xsb3dpbmcgY29tbWFuZDoKPiAKPiAg
ICAgYGBgCj4gICAgIGxzbW9kIHwgZ3JlcCBsdHRuZwo+ICAgICBgYGAKPiAKPiAgICAgdGhhbmtz
LAo+ICAgICBraWVuYW4KPiAKPiAgICAgID4KPiAgICAgID4gYGBgCj4gICAgICA+IEVycm9yOiBV
bmFibGUgdG8gbGlzdCBrZXJuZWwgZXZlbnRzOiBLZXJuZWwgdHJhY2VyIG5vdCBhdmFpbGFibGUu
Cj4gICAgICA+IGBgYAo+ICAgICAgPgo+ICAgICAgPiBJIGFtIHRyeWluZyB0byBidWlsZCBMVFRu
Zy1tb2R1bGVzIGZyb20gdGhlIHNvdXJjZS4gSSBmb2xsb3dlZAo+ICAgICB0aGUgc3RlcHMKPiAg
ICAgID4gZnJvbSB0aGlzIHdlYnNpdGU6IFtMVFRuZwo+ICAgICAgPgo+ICAgICBEb2N1bWVudGF0
aW9uXShodHRwczovL2x0dG5nLm9yZy9kb2NzL3YyLjEzLyNkb2MtYnVpbGRpbmctZnJvbS1zb3Vy
Y2UgPGh0dHBzOi8vbHR0bmcub3JnL2RvY3MvdjIuMTMvI2RvYy1idWlsZGluZy1mcm9tLXNvdXJj
ZT4KPiAgICAgID4gPGh0dHBzOi8vbHR0bmcub3JnL2RvY3MvdjIuMTMvI2RvYy1idWlsZGluZy1m
cm9tLXNvdXJjZQo+ICAgICA8aHR0cHM6Ly9sdHRuZy5vcmcvZG9jcy92Mi4xMy8jZG9jLWJ1aWxk
aW5nLWZyb20tc291cmNlPj4pLCBidXQgSSBzdGlsbAo+ICAgICAgPiBlbmNvdW50ZXIgdGhpcyBl
cnJvci4gQ2FuIHNvbWVvbmUgaGVscCBtZSByZXNvbHZlIHRoaXMgaXNzdWU/Cj4gICAgICA+Cj4g
ICAgICA+IFRoYW5rcy4KPiAgICAgID4KPiAgICAgID4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiAgICAgID4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+
ICAgICAgPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnIDxtYWlsdG86bHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZz4KPiAgICAgID4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+ICAgICA8aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldj4KPiAKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
