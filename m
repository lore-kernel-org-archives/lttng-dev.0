Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9DFF506D6
	for <lttng-dev@archiver.kernel.org>; Mon, 16 Mar 2026 13:58:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fZGrc66F6z1296
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1773669490;
	b=CVHbwTq4uAEUGHanMKQ6yN1OUoTFHfGw9qTX+sjnao38cSbMZbM6d2adFlxt4phj5cS0
	 HaTo1i/ugd4TaUyuuFtTuBLh5Qe7cAYZPL6NewSqXocJAZQyUcMqTC7fCG2Ew+s99iLPb
	 +9w2R8C7jpn/nJcvTX5Z1AuqA+MQd00g7IemwO3ESsbta89AY7tS1a44XAqw0h0FaDmPf
	 tl8j6t0iC6cDIwTMQepdAHJt/KWnVCvkpjUGWy20Mh+VQK20ydZXNoQlo6juKRq/Anjzz
	 s0px7X5kyEnIBorAFFReoZYBuhryObQ1LTmk4UWg3znUIKhUSpOLyXf0u9hfC0HPdyQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1773669490;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=shHO9QdU6fd5APWiizZTcchaEnGK2OiXCXpuTjyQ6Vw=;
	b=DKjulUo/BZV8vChLH3YaO+F3VbRYZ+IiZM7jDP+XZCq/1rqfHqHAO1PtAg9GENJ/sX1z
	 P+14+laOmPLghltBy3xaWlZ6r1BzcTL5bN+PA+y6OMLf9pZnO+6sHrZNEJlLN3Ly1jRE3
	 MvtPl824t7+Hwywz46qx43rl5vs2vkNlu2GGneAXyFRoHt9QInSrGlugDVxdifpEwIuOo
	 UGve9MMOmnBI8asLNxKMbfoX+x2VPEaoV+usH6GmSS76fys+M8PGJl8A3HbyU1NloRD8k
	 ICeqPdMOH3c4kqEpMO+MdhGilD2Q5eDpxvtsdr1WosCpEAXEhQA8kAkTH+C9cXHVFsw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fZGrc66F6z1296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1773669490;
	bh=L3lGHDKqSgaU0uwD9nVvyhIbS6j5kSUh7QAF0waf1/M=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ENkRKj8jvJz2/2TOn7Z7zbhB9kRUgu8SDZ7thzTniYOxcagRtaLLcfCFrcU/w+JLW
	 m0+bHj5qzcZOmJCiCbz/gHG3xFskGYH5PJyUp3x4XCKdLvX/lt7Bt9vxYsjmMmC1Kx
	 tAPmsKa4bxLp90/77gurZ3ABm/Fjt8VHbeTmCrBDfzpk5OKU7gtaww5z9G5sUo6G4b
	 ryKHPGZNkZPZV/BmIRtQzLJ3x8hC0WikX9BZWhJsfEtPHn6Wpr0NPKMGGdqIS5A3a2
	 6DrrkN8B/cJ4VzwNuUEcdMQMnXv9wMM9n0mHQReVAcetigtkIMdmHo6y9puLPHplxh
	 e4i1qL7+1Mkow==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4fZGrc66F6z1296;
	Mon, 16 Mar 2026 09:58:08 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fZGrZ5BmHz12MD
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fZGrZ5BmHz12MD
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170110005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::5])
 by lists.lttng.org (Postfix) with ESMTPS id 4fZGrZ5BmHz12MD
 for <lttng-dev@lists.lttng.org>; Mon, 16 Mar 2026 09:58:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sObbR6NdTSDNNUn5DK/nHVkecddiI1XvXfpqUMLIqcgXxjxAkHQ7FFp7pJT3GXR7GHXIQqWS5q/znKqAfKfhqMjX2G/mywMXAVWH90d1NI4Gb8ElflLi5ibNKWqJHDw5XLnHLV7g0M7riRPIcP+FMyvcx8rbVZ7TT+5+ZYMDkA4JUnhxM0Ir1g+dSQ/1IBlccnsX4VPIgH1x11DztsqRITuoezDHEAg1bkjAhSAEs8LnZDcdpvtWHlU+OFDoopdrTV7eoGCSio4jEfePYvf4KfmFd0Ci0E6S8CPCGgtHFEgMMPyE9MJx1aUhZ7J9A9YTQrPJzzAOoSbRSRjvJ8h3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3lGHDKqSgaU0uwD9nVvyhIbS6j5kSUh7QAF0waf1/M=;
 b=xL5kJ5+Hj9654NIBhHYOeiomDEinODmyiK7cLQNX4nIL5liwFbhwE/TQ7eJocrfVYXw/kAU0VtQDX1NYBb2tyX6i9jiNbTKepeoi/4Du7+12LfY9FJ0jcMaS3qbfpFW4qKk9iKv++B7FJpH3StyG7zJmnG1/NrwJz0bV/ekMr99lxIKwVbGr03v9uAdHLxXFtI3mHJwoxtlJhPJUUXZDnIc6P9V9pOM6xkr/O/7tfKJwHFfM1oyFCO4gpyEBb4cQWWYP9o9G7/AHcjP9qEDUlxdf1tbFWZPsXK92OuxUdKHQKJtZTdpzIxyPXaxv9EYIDEWN8LcR425B7eDghV7zQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:42::24)
 by YT3PR01MB10685.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:97::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 13:57:49 +0000
Received: from YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4c7b:7dec:7e59:918e]) by YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4c7b:7dec:7e59:918e%3]) with mapi id 15.20.9700.024; Mon, 16 Mar 2026
 13:57:57 +0000
Message-ID: <d50ce75f-36fa-4b4a-a36a-5a8340a8e6dc@efficios.com>
Date: Mon, 16 Mar 2026 09:57:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Build-time tests fail if machine has a single CPU
To: Santiago Vila <sanvila@debian.org>, lttng-dev@lists.lttng.org
References: <aa7-8LHGez9Bi0UQ@nuc> <aa7_bv8CMRlfeIFH@nuc>
 <e08d7ebb-d3b9-4c7d-a7af-ccefc339d5f6@efficios.com>
Content-Language: en-US
In-Reply-To: <e08d7ebb-d3b9-4c7d-a7af-ccefc339d5f6@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0207.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::11) To YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:42::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB2357:EE_|YT3PR01MB10685:EE_
X-MS-Office365-Filtering-Correlation-Id: 942e56a0-c6c4-46bd-585f-08de836406b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: GfabQ8itpAfKave9DrHyO+XbMkhDJ5SZVX0LucKFFR/a0rMObUwv+Ve+XLXIvV/ht+ZUc3MNsxHIX1QLstDwHxNSqBAhmmxRyKUYWLUnCsihy/W6MgrG5sD6qcLDtNlgOJ+Q0AiKBqPxHR0rr2mT0oHmX5lgh6g7yM5cAhGcNUBHiCMdHBeiUIKqsO3J5bDAJ+ETajhraIdtV89H1rrzIr4zDjPaAPFqE3n/F9bLK7eVl7bJHN3B+KwBC3IpvQ0Af6RTy9gwfUPGgjatoDSRDW4JMR3EJdmm94Kx8Etu8OXfXjj4xTlhg+j8v5tJJPBP9MQS3AyU4WxX4416nBi/LdiJlEQR6htnK2GOyP9NuikjBC3WbYcBDPA0SAWcYkfetgsvzGe4+w41qwrt42OW/kI0hJ53VLdYTw1l+7NR5LNvLp5RYJGiPP6ND4ficlhfPP1oaveaBzxYuURlMQgY8XqYchaTgDCJFBaqFyBwOMNI3Y5jIjm7ixOmSbHbdJHeV+/sfjhxOVg8gGJCmh+fIwgw0cV2utmH0qXdMw0W6uON0ZZ+Bq8AfURkuJ+BzNPkhbT+bI5auAj0j0tlcCbPHqCq4BNXsPLPttrCgNpYYEud/FABzaEjJDaDSasWKfsz3kEz1xxD3zahiSVlb/NJnFwfBS/xybJcpYePbNpWWngJQe7x/rY6M9P98xxPGeLge3hHiRyNJgboC6RkRy1N1lyGtUIyiJF83GUp23/C3jODsts+Y1SjizA0ZHlmeJEh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2hWNDJOTkkxbUpQMFlmNWc2ZjVCekVEMy9mV0lFdnhxWlpMaVcrR3E5VmVL?=
 =?utf-8?B?R2kxblppRCt6RnM5bGx3V1FUU1hodkNJdFpQRlkwNDFqOWhpc0NoTHBySFE3?=
 =?utf-8?B?SmszYXdkVkxuSWVzSHdBN242L21YUUoySTVkMGc0QlU3SEJRNFlQdTgza3Iw?=
 =?utf-8?B?bmthemVPczVIYjdGV2Z1dEhTRDhLdTNvVHc3MHRaSngrRnpPc2ZTa3dQalpU?=
 =?utf-8?B?Nlo0SWUwM2RXS3dvdnJNUVhhZ0FtOTJrSnFlNkViSVdzblIvVFBjbGt6YzBv?=
 =?utf-8?B?K3l4MDZLTnE2RzBKTW51Rzc4ZjZvaDR3QlFQK0hYZGZna3lzaEtVTEVqdm81?=
 =?utf-8?B?UlVkVE1mQ1VJZ2xFd25yODNabk5HcDczaVI3ZU5jSDk3N3g5VjZwY1BtSnpu?=
 =?utf-8?B?YWhiZzZmbVVwTkVldUNON1liaDBDNUx1M0djaVg2dGFyV0owckN1QjY1R1I4?=
 =?utf-8?B?QzFoRC9Pd0ExS1BBaEl1YTlQUEhzNm5wRE9xQzRnQyttcG8xQWx2eDRLakxO?=
 =?utf-8?B?TEQxdXNqTnlIL2NsZzYzZ1JCUU5HMkI0NlZ4TmtNbXFkQXcwWUpPaWJCYzBo?=
 =?utf-8?B?VHJyQXg3TkhBbnBXUFJzV0hJSm00eGhqZ2JUbmJTQ1dGN04wZWwrR2FqTGM4?=
 =?utf-8?B?aG5DOGZnRkZTZE1TYWRmbVhxcTl5YURIOFVRU3FSS1dFY3JKSXJIVkNIWnlS?=
 =?utf-8?B?bnJxYzY4ZElXTmFZd3YyWE00R0gwbk0yZEd0OFBYdDk0bjQ0SG4vaUpFc0Jv?=
 =?utf-8?B?M0pONGVmSXNJbHZ3YnhsMTBqbmZqdzVLVWREUTFBTHhmYzc5OEFKZFU0TTM5?=
 =?utf-8?B?RkFvM0wvQ1dzUDF4eVQrTUJjRkwyZUFKYWxCaVJqQ2kzc3o1T3o1eUVQbjgr?=
 =?utf-8?B?WE9JdzMvbS81bUJvUmF2WlVKUEV5cFl6NFJnMnIzb0ZBc1NhK29Eckd0VGxF?=
 =?utf-8?B?V3l1eC9HNG0xeE02a25ORTJpUXRsYUJURGJaMUtIVnY1SFpZYWlvYStIdDV4?=
 =?utf-8?B?N3NvQ1FWYXhDcE5JQ0FHSURHeEpIS1I5WjF4aUR3emdDQ1JUZFJSQVdscjh5?=
 =?utf-8?B?SEFIY0E4dlM5eHVCcjZqOWpyV01EeGJNNGEzU3B2b0xyblVlWXBNbjQxaXhx?=
 =?utf-8?B?NTZUb0NtTUpONlZqWE5VckdKZHJaVGMwSHJRdGRZVk8wL3VhalpQNlBkRkZP?=
 =?utf-8?B?SmVNSWczNSswTnNxTllOajVncjJBVWU5ZWliYm1JczEraldIOVhRajQwV1Na?=
 =?utf-8?B?anFRZzBvVW9IVzU2L3M1RDFMNWQraFhBblJVM25GQzgrTkFtc05NUVl3bG5S?=
 =?utf-8?B?ZW1wZWhLYm8yZ0VxbjBRMGlReUFzaUtnOTBHdnE0QU0wSXFVdzN3MHVOSVBO?=
 =?utf-8?B?dGxrTUJ5cUtjdWUzN1gxODlXaXlrVS9xaldsZGNqYWxQYmVOMUNSdFEwdy9H?=
 =?utf-8?B?NjFSeWlPeVBEeUV5cytMUDVsQWlKNGpVYUpnMFJsK1hUUXNXeWE4VDNMbVY4?=
 =?utf-8?B?dWc3N3NWbVpFSWNuR2ErS1pKOXVDQmJ0dWgzWjhSa05EdGJXdkZvVlF4RXZr?=
 =?utf-8?B?ZkxGVU1qU2wvS3U2bkV2KzZxK1dFU2s0U1FiTFY5eFpFcytrMmlVZVY1SWJU?=
 =?utf-8?B?UGhjUnB2aXBnbThzSVkwRERDTnpQOHBjZHFjTjY5dXdjZmdPa2padnFsWEdM?=
 =?utf-8?B?SXRzVkdITkxaK0Z3cUtBY0VFdW1mZTdHTjl6Z2x5ck9UMnRyT2x3TDZBVyth?=
 =?utf-8?B?eXpkUEN1b3NIa1JpMmVIN2dtLyt6NURJTHpyWmtaM2VUMG44MS84SjlvSzgv?=
 =?utf-8?B?ZG5ZM2U3anNoSjBLT2twSUlrbDNNcTVzay9Ib3d2dGJXTWtRcGU3Ym1Xdlox?=
 =?utf-8?B?S2s0M1piQjZLY280emVlalRoSHpUSE11RHFValFWbGo5aHB6aUsvRXNNQUpQ?=
 =?utf-8?B?ZUtuZ1I5SkE3RDVQNTFxd3JiN2dRTTJ2WEo0azlrOEV5c3d2dWdaaWtoMHpY?=
 =?utf-8?B?NWtuK24xd0poUi9DMEJySXFTd1pqVlRkUVBsUXNGUVNDMEd3aTEyZGp5a3RG?=
 =?utf-8?B?VitxRW1sa2lHRXIxM1EralNpbUt6ZytuNzlRbVBMWXNqOHliNW9xc3YxMWNk?=
 =?utf-8?B?V2dyQ20vK01OVkQ1dTI3MXJqVjdZTlJLZXRQaGtjZ0hGZi9vYmhqTHFIM0R3?=
 =?utf-8?B?YkMvb3MvWVZWQllHU2pDYlNrNFRqbHN4RjlobklTa0Y3Q3hqWmJUS3p3cFBl?=
 =?utf-8?B?TWNlNHdZalVmclFsTzBDdWlZOTQ3cHMyeWVlM2NtOW5McXdPMGszK0ZUZDds?=
 =?utf-8?B?a005L0ZPM3ViTy92c2RRaEdWV0FWTkVYeVJITjUyS2h1MWpKbWNtZz09?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942e56a0-c6c4-46bd-585f-08de836406b8
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 13:57:57.4337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6X9+ee3R0hWHL7MR3kN+bt7Rv9c2+rrzM2hJ4yKD5T7RGDWPlDBxms7KLDG/0eVwozkfoLEjfEwYq5+k+MxEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10685
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

Hi Santiago,

some changes have been merged into the master branch that should fix the 
issue you're facing. They should be backported into the next bug-fix 
release for 2.14

[1]: 
https://github.com/lttng/lttng-tools/commit/41e650ca6d7587fd217f276b6e9af19cd962b7da
[2]: 
https://github.com/lttng/lttng-tools/commit/519c2e6c6b286d33d3c4b4d8a5032317392e0939
[3]: 
https://github.com/lttng/lttng-tools/commit/562507728d13b7c3544d2059f9f891f9c82109a4
[4]: 
https://github.com/lttng/lttng-tools/commit/f1d33a72a5ffb1515f66b0af8b9044df93efd970
[5]: 
https://github.com/lttng/lttng-tools/commit/2a857d8fe56c76bc25b35cb8ecde5e8687412694

thanks,
kienan

On 3/9/26 3:02 PM, Kienan Stewart via lttng-dev wrote:
> Hi Santiago,
> 
> thanks for the bug report. I'll take a look at it.
> 
> kienan
> 
> On 3/9/26 1:12 PM, Santiago Vila via lttng-dev wrote:
>> I forgot one detail which might help to debug the issue:
>>
>> This started to happen in version 2.14.0.
>> Version 2.13.15 worked ok.
>>
>> Thanks.
> 

