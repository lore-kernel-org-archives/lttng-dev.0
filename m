Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0950C5516D
	for <lttng-dev@archiver.kernel.org>; Thu, 30 Jul 2026 19:59:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hB0QM4wP5z2J7b
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1785441549;
	b=LgqG/Sz/2PHWN93/DgTOqOwC0/zWRCWn4I/zW06UCnkyD4w0+22AJ06FeVd0iy8CQZk3
	 nyAztkOKBbD+oVCIn0tRnRA63iUbChy5GS40OkmyjcsUX9yHJ8ulP3gCPb0Q9oa1Cq4lJ
	 5wmNIGRS09Vkn7bdJlnt3GuIBWnAVp6IbyuQhu7tfLB1Sk30X5vco6hLjEx+c/ARQurA8
	 isejuTBgnwBPuH+5kD5G9fY+KbSjg6Ltimq0sp5sL1Q/LhqJ7RrG0dSUzCuF+66Ertbkm
	 xksZVC7+WSTXZ4Yl61JIE2csCtPc0b/iqo8zRpKXjuGD9VuAjh18FVoL5moF3pT+wug==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1785441549;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=GijLH5FfhzXXNJdlsZ5nY/f1hR18XvNCd6HIZx9S/Qg=;
	b=fQuOPuu+jdT0ju6nVfAzG+W+CWgNXbVNjntVpFVHecQGvxbSrLnvw00Dt5E57iZvDqNS
	 cc8sdNkWuyC1QAmnEW+cNaCEKOiyWgsRH8CySutLVbXsMHveQyIi6ADnANszJ1y3RsURt
	 EKWYDTpxE+oLXKPGt1CXEmGh/UmZhHNxU/7sKKxdBL3KfIwsmI628CIGtHJ9AE81JNFSl
	 t9hHA5TZxM4yvL8XWI06CsPzWJWtsasmddJ9RooTg7VPwvU/bT+11m9BAHTnEmPrR/Or8
	 634R2jf5RdXJRdnWpzudiCg07yCNi/wHPvmrbnFLM2e7RQRah/H5GQRMj4qWpBvXwEA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hB0QM4wP5z2J7b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1785441549;
	bh=8cJQt06901ZFueT5j4B4mU1n2Dg4cqxVf6xx7sMkg1I=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=LfBflB5D31Sgsn6s6sE/lJ/4FE2aCIwonxesSGLmw6eoOcP5c5RKC7UxDNtvdtFSR
	 ytd8U+CmjDqSBFsrNS5UD7JeyKTdBAKuBjNU675hlVx7Uol08StKQnKx4V8ZRWU15r
	 pVTh8TPNQgqUMHX2qHojLmk/wraNnn5J03ZJE2tsApiP2M+mZLK734IGj3GtPy4dWy
	 /Dza0E/ScnWKCQad+dtzrYGB2yGzrJg0f2k6g4J42exIdv/rOusKtWAyNDcWvKYKzg
	 UJ0dgv5NbF7nH3Vjb7nJtCqXU9GleFuOgANxYTCTDtEfBccA7r3+kQ7tR2ZhowYnkl
	 VhkokqaMbM6mg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4hB0QM4wP5z2J7b;
	Thu, 30 Jul 2026 15:59:07 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hB0QK2WDzz2JMJ
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hB0QK2WDzz2JMJ
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022120.outbound.protection.outlook.com
 [40.107.193.120])
 by lists.lttng.org (Postfix) with ESMTPS id 4hB0QK2WDzz2JMJ
 for <lttng-dev@lists.lttng.org>; Thu, 30 Jul 2026 15:59:05 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m54RDoobrnsg91Ned5rweab9C7MG9ESJB8EJgDaQqvSF+z5kCU2eWNylzjv0f1vmhTk3rAS/uc0qLi6YzrsNLBhnW1DglI7IM2A1lxUaEJgdWOadOWqWeQoq3uB166xnv1HsbznY8CgY5u71/hUtUNJZuNd7UQTcCLcdhWVg4EehzoU4UwYT0HW+5+WjexSMFVDVmDVyC1qsMWZfz24RkQ9AJJqR61SR8POntO1LOio7+pG338aHwt+QnFB2JHTVG3alFGrIVtsNxaBO1TZjVF4ixF1gWeme6mO+F/QHod0yq53dcZMJ9x+XCMl6ThoSah9dJaVNMxwjM6wnO2kxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cJQt06901ZFueT5j4B4mU1n2Dg4cqxVf6xx7sMkg1I=;
 b=yE/Ydl5rEv0LMOk3RdetfwnuYRYi58zHRL9i2KqF+OrnqQ32kw6DUNuOj5FiN1OaIuTnFCBz5B3329xoDmWelNCWKagnCbZ0WgoiDTK3MEkLEYZbuvf4TwI3atNh/72n9dH2UskU/nn0dnNbk42qu3yEelRd53ZWPe8keypEie7ANSJxLj141haSkb2jKhkZYK1/eFj67utC5LzUejH3IVGcek5xV3MbxiQH6GqeuvXh7fUgRT988evZgR2kA9GYnKEeBHBLGxZiZPvQqUkJht7RSp+aCXxiY4IaKpA+a3yWrx8jtkmbxhRwJK1NG1wlJX06YYZAtgVusyzddUw1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6179.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:68::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 19:59:01 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 19:59:00 +0000
Message-ID: <0b50e8af-5f4d-4918-9431-1958568046aa@efficios.com>
Date: Thu, 30 Jul 2026 15:58:58 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Subject: [RELEASE] LTTng 2.16.0-rc2 - Question de Perspective - Linux kernel
 and userspace tracer
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0192.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a4663f-3fde-4a0b-59bb-08deee74ff2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: yO7LtYCLUpu2QSl/xR/zImQGVPv8+R1cuE4vMeqJy7X2GIHVkzkhmEtrFMv5OgFVSfFW1wRvcBT0H/KyStfteoR2NDO2uKE5RYBikOrR4wcVYu7FVhurlSQ4RhMrRm50QnNCh3SQopq/fve2nr5SAnEgRqImDHbLv5c87sJMfZOOpJjAbRkyD0j7ZQftT2vlKz5Vfzv5LP10NX/FfLnjdaJK0Wd4L37h1ArsObyfZQw2sE2YNWJ7Z4DOZnqy6N5qDHgV3aA0GC5751q12wn3Qjb2frlwpzRRVVZzelhYnpdK+jcFeYl0M8ZaLv9iDLjhQdduw5ExG91AK6TXRo/jCPOkmZ06mm1BlHTErb27uwX8qK7KyqRNZfEh8W5N3HGi6xCPMT0PnW8oyRFBzYWOEpcoZHZIvRGtMmnV2BzPIpsIGT6TUjjcLkxX65l6eD3XW1yeddAz0LJsi5S6Kl/kP1ecCcT+hxguEWoZGLGCPFvV7fEYGBAsMAbTaoF3Sood/YXezhjVfG2VyAvR3ZTF25c43N+xp3Z6KXTS6GuwDn3VthFqAppTKcw+35lMZuj1aSSD5xoeE0oNtpEqbWeRASjEKBC5pLv8Ynni1yOGVhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzFvQWVUeDMrOFZJWGt0N24vTTI1UGw5c2dYak1pWkFreENuM1ZiNkgvWHJ0?=
 =?utf-8?B?SnlHTDNYQnBwSFNZSmZ0NEUwQnFKUjgwamhrZTFuMk5BdytlbVNPdjFnSndR?=
 =?utf-8?B?Z2wzVTJ4ZDZBZ1BibGU4YTZCOExxOHNaMWtUQ0dWZ24wME1ZeUFucjVEb3NH?=
 =?utf-8?B?MTVhUDRVNUN0dTNTRWNqRy9qa2NTMVJCYmNpbDdhdWNlSFAyL0R6OFdCQmpW?=
 =?utf-8?B?R1hwY0lCZWEwYm9DL2xwek5XQmZjb2tjVjRlQlZJWGJxd05icE82bzdvdW83?=
 =?utf-8?B?YnNvWXZHdXdkbytpcDNmYjdmN0ZrN1c4dTBvM1RQNmRRQ3NyS0x2SXFjYkI3?=
 =?utf-8?B?aTduc3BVVXNRM01udHBhZHU0QStwRFkrN2dNSkR1S3ZNY0RGSEhiN1E3bVU3?=
 =?utf-8?B?TmVtLzNIWDhWOTM2amtFNk5ZVFBSUnpncWJXZkF6TkhQbFpHMG9jYm10amty?=
 =?utf-8?B?MGdiTmdxR0N2bkJPQ0JvOGc4U2ZjWHhETWdlZWc1U2Nia0NjbjJwRytiK001?=
 =?utf-8?B?eDloditjYWg1WHlOVE9GcmhjTHNhUlAxak40WmFlMWVRUU54TW1RR2ZaU0tm?=
 =?utf-8?B?Y0doUTlCVS9idjhndTlCdjlrZFdKL0c0cDliNDQ2TFlHb01DNTM3VjNjT0xa?=
 =?utf-8?B?NUR0Z1M2dXFjV0VnSXc5OU9EYlRQOStncllqbTlpeFFxdXltRmF2MlVVMnpu?=
 =?utf-8?B?L09wK0hvbzh4QW1uN1ZUU2NHcjJ4NmthQkpmaURUbGQ1VTU5azFWSTgzUnZV?=
 =?utf-8?B?cklsZDhYcUF2R3ZjRlh1Vy9DaGlyOHVCeUdXclV5NGRyQjRseHJOZlQvRXpU?=
 =?utf-8?B?ckpxbnQwZUlpVkYvRzNheWg5WTFtaHJYS3hZMWVKNk5HVnVQQ2lCdDNpNVBE?=
 =?utf-8?B?R3hpSXJuS1haMzZqeEtYck8wMnR0dXNJMEI4NitWM29pUXRqeU5ZcUkzVnJ4?=
 =?utf-8?B?TXhoSjdWNytOZ1hHUTFhRGYzeHhBa3liNkdzd2loU2VSY2RzdG5iR0M2UVly?=
 =?utf-8?B?MERtZDRPRUFJQnorSHlVSHpvNU9hSWxtUVpUVWpLUnErVFJSd3FxQk9qMHVk?=
 =?utf-8?B?dFVCeW92YkZlN3lrbTZZQkEvK0ZBYmVIV2c1MytoYnd4MXlCVndZdmZzTDVx?=
 =?utf-8?B?bkNPN3lKNzZnS1o5N3NFUFFnMGt0dGVkbzFLc1dJdGhPWG9hZXcrUXN6YzlU?=
 =?utf-8?B?OHNQL3JjOTBtR0pYbG80ZXhCWlhyaVMwK2I1Y2wrWUdmZWhPQ1NXdStyajUx?=
 =?utf-8?B?dy9KbVBGamh6TFNsRndmQi9lZ0p5ZUJFamZUZHVzQ3JRMVdvQmMrQ2Q0eFFL?=
 =?utf-8?B?RVM2QkFqbllqMjMyRTZCV01tOEFYRkVLNlJWUXVNZDVyZTRIUU9SZzJrVWww?=
 =?utf-8?B?MlphaUt4YkZ1T1hqY2ljcVM4eG5MK2JNY1ZSdWU1R0FCZFpZb3VnMmxzM2ly?=
 =?utf-8?B?RjhZeU5uVnZLU3VzN3hIVTFaUWg1TVBrUUs1aWdnWGJNRzNaUnlUUFVsWHYv?=
 =?utf-8?B?bngvSXZNSWxKOEVHQlMwQVl2bjhVc0thWStYZWp1d3RBUnpqby94Umcxc29x?=
 =?utf-8?B?amNIY015amQzWndnWk1GcEF5RFQ1OVVNWVFHVHF6NmJaQ0JxVnZrNzc0aVdt?=
 =?utf-8?B?dm54T0IzRE1FLzJsOUFJbHYvQ2dSckFxMVpUMEJUMVo3bzhiTXk4VVFjQVR2?=
 =?utf-8?B?VTEzdm1ETUNiUjhMMVhVT2liM1prbkpYQVFoMUUvSjVHeDh0OEt6ZWx0d0lu?=
 =?utf-8?B?bHhEcnhhcktBS1FVb01MeUhMRS9aTDhVc29Ba2VNUHZPK0doNzhaUUp0TEEw?=
 =?utf-8?B?bDhHek5ZeDZUM2N2dzcyWGN6cisyQ0ZlNExLQ3pZeE54YXcxUjlkZnlhQnhD?=
 =?utf-8?B?bXhjSG9zcDdkNWlPckVYSm1KNExDK1ZFaTNmVVBiWEdSOUMzMzdzWUttb1Vy?=
 =?utf-8?B?L25oR1F3c2graEVHRWVpMGxFTnFEVWNZT29Dc3hOS3YxNkd4aU9ORnAreVRn?=
 =?utf-8?B?c0xxVlh2T3hxbjNTTlpmNU5HVzd0T0duNHZoZUVpUWxzQ1RPMmhObmJSeU9Y?=
 =?utf-8?B?VE93dE1aNUZGZ25wMHJlbnZOZXlobUVzcmxISko4SHJwWXAyNTRCRGV4ZVRU?=
 =?utf-8?B?YXNMczdCeXFLSmM5VE5DdllMbi9zcy9ZVnEyKzFwL3E2RWVMYS9TRXFLWDlF?=
 =?utf-8?B?L0dyazZNcmpKMUp0b3NLVVNyeW0yb0lGcU9OSEZrKzdvRW52V0hsVGZqMUpa?=
 =?utf-8?B?b2J0UE9LRTNjSHdMZXg4Z2FWV2J4SU9HdUFMUWlKYURSL05iZnpMbkh1WUNL?=
 =?utf-8?B?N1QxVFNCVFF3K0xqQ3FVenZmcDdVRUFQajJqUEt3bmlnRi9uZjd0TXZuTlFq?=
 =?utf-8?Q?c4qvE+E3G+x1sTYMLABgz3bwXiji5V+hbibQl?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a4663f-3fde-4a0b-59bb-08deee74ff2f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 19:59:00.0268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ey3x0ojsK/3MihEcLtQVaTobKyTGH3W3Mv3h/Lz/Iu/OSaVRr+wYchYp1epr3ZnAIeyD7ufJSChMGOoBn3Q+ufDXW83cW3A0Qt6Y5OpGDy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6179
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

Hello, fellow tracers.

The LTTng team is proud to unveil the second release candidate of
LTTng 2.16, codenamed “Question de Perspective”!

What changed since RC1:
───────────────────────────────────────────────────────
This release candidate contains no new features; the changes are
bug fixes and hardening work, most of them covered by new regression
tests.

A good part of the work since RC1 went into stabilizing the new map
channels. Most notably, agent domain (JUL, Log4j, and Python) event
rules can now be used to increment the values of a map.

Other notable map-related changes:

   - The triggers targeting the keys of a map channel are now evaluated
     in their registration order, making key exhaustion deterministic
     when a channel fills up

   - Sessions containing only map channels no longer spawn an unneeded
     consumer daemon.

The session daemon now derives the kernel tracer's capabilities from
its ABI version. Attempting to create a map against an lttng-modules
release older than 2.16 now fails with a clear "not supported" error
rather than an obscure one. This work also fixes a regression
introduced during this release cycle that broke the use of older
lttng-modules releases: trigger error accounting failed against 2.14
and 2.15, and the kernel domain failed to initialize entirely against
2.13.

We also introduced retry behavior for global buffers to better handle
scenarios where concurrent producers writing to the same ring buffer
would cause effective ring buffer waste due to padding and unexpected
event loss rate. This became important since the introduction of the
robust per-user buffers in 2.15. This fix was backported to LTTng-UST
2.15.

Highlight
───────────────────────────────────────────────────────
This release introduces _maps_, a brand new way to aggregate live event
counters directly within a recording session, along with BLOB fields,
trigger persistence across session save/load, and other
thrilling refinements.

Aggregate live event counters with the new maps feature
───────────────────────────────────────────────────────
Maps are the main feature of LTTng 2.16: they add a new live aggregation
path alongside event recording.

Maps let you count event activity live, such as how often each system
call fires or which events your application emits the most, without
recording a single event record. You get a high-level view of the
observed system at a fraction of the resource use of recording
every event:

     ┏━━━━━━━━┯━━━━━━━━┓
     ┃  Key   │ Value  ┃
     ┣━━━━━━━━┿━━━━━━━━┫
     ┃ read   │ 48,201 ┃
     ┃ write  │ 31,944 ┃
     ┃ openat │  8,127 ┃
     ┃ close  │  7,930 ┃
     ┃ mmap   │  2,615 ┃
     ┗━━━━━━━━┷━━━━━━━━┛

A _map channel_ configures a set of per-CPU _counters_: named integer
values, keyed by strings, which accumulate over time.

Unlike an event record channel (new terminology for what used to be
simply called a “channel”), a map channel doesn't record individual
events to ring buffers; instead, it maintains running totals that you
can read at any moment.

Map channels and event record channels are independent and may coexist
within the same recording session: you don't need a dedicated recording
session to start counting events.

A live tally like this is a great way to guide your event recording
setup: once you know the busiest events, you can pick which ones to
actually record, size the buffers of your event record channels
accordingly, and pinpoint the real sources of tracing overhead instead
of recording blindly and sorting it out later.

Add a map channel to a recording session with the new
lttng-add-map-channel(1) command:

     $ lttng add-map-channel --type=user my-counters

Then, populate its counters with the new `incr-map-value` action of the
lttng-add-trigger(1) command.

The example below increments a separate counter for every user space
tracepoint event, using the event name as the key:

     $ lttng add-trigger --condition=event-rule-matches \
                         --type=user --name='*' \
                         --action=incr-map-value \
                         --session=my-session \
                         --channel=my-counters --type=user \
                         --key='{event_name}:count'

The `--key` option is actually a _template_ above: LTTng substitutes the
`{event_name}` and `{provider_name}` placeholders for each matching
event, so that a single trigger can feed many counters.

Read the current counter values with the new lttng-show-maps(1) command:

     $ lttng show-maps

     Recording session `my-session`:
     User space map channel `my-counters`:
     ┏━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━┯━━━━━━━━━━━┓
     ┃         Key         │   Value   │ Overflow? ┃
     ┣━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━┿━━━━━━━━━━━┫
     ┃ myapp:request:count │    12,043 │           ┃
     ┃ myapp:error:count   │        87 │           ┃
     ┃ mydb:query:count    │ 5,920,377 │           ┃
     ┗━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━┷━━━━━━━━━━━┛

Sort, filter, and slice the output in many ways, for example to show the
five highest-valued counters of some process:

     $ lttng show-maps --channel=counters --per=owner --pid=2860 \
                       --sort-by=value --sort-order=desc --limit=5

     Recording session `my-session`:
     User space map channel `counters`, process ID 2860 (`myapp`)
     (64-bit int. values):
     ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━┯━━━━━━━━━━━┓
     ┃            Key            │   Value   │ Overflow? ┃
     ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━┿━━━━━━━━━━━┫
     ┃ myapp:request:count       │ 2,481,005 │           ┃
     ┃ myapp:cache_hit:count     │ 1,938,712 │           ┃
     ┃ myapp:db_query:count      │   842,330 │           ┃
     ┃ myapp:cache_miss:count    │   220,118 │           ┃
     ┃ myapp:error:count         │     1,204 │           ┃
     ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━┷━━━━━━━━━━━┛

Or to break a single counter down for CPUs 3 and 9 of Unix user `paul`:

     $ lttng show-maps --channel=count --per=cpu \
                       --uid=paul --cpu-id=3 --cpu-id=9 \
                       --key=myapp:db_query:count

     Recording session `my-session`:
     User space map channel `count`, user ID 1002 (`paul`)
     (64-bit int. values), CPU 3:
     ┏━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━┯━━━━━━━━━━━┓
     ┃          Key         │  Value  │ Overflow? ┃
     ┣━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━┿━━━━━━━━━━━┫
     ┃ myapp:db_query:count │ 612,489 │           ┃
     ┗━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━┷━━━━━━━━━━━┛

     Recording session `my-session`:
     User space map channel `count`, user ID 1002 (`paul`)
     (64-bit int. values), CPU 9:
     ┏━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━┯━━━━━━━━━━━┓
     ┃          Key         │  Value  │ Overflow? ┃
     ┣━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━┿━━━━━━━━━━━┫
     ┃ myapp:db_query:count │ 229,581 │           ┃
     ┗━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━┷━━━━━━━━━━━┛

Power users can go further. When you'd rather query the counters
yourself instead of relying on the fixed, human-readable presentation of
lttng-show-maps(1), export every counter of every map channel as a
self-contained SQLite script with the new lttng-export-maps(1) command.
Where `show-maps` filters and aggregates for you, `export-maps` does
neither: it hands you the raw data so that you can slice, filter, and
aggregate it afterwards with the full power of SQL.

Pipe the script into `sqlite3` and query the convenient `vmap` view. For
example, with a shared resolver library feeding `resolver:cache_*`
counters across every process which resolves names, rank the processes
by their DNS cache hit rate, combining two different counters into a
ratio that `show-maps` can't express:

     $ { lttng export-maps; cat << EOF
         SELECT owner_name AS command,
                ROUND(100.0 *
                      SUM(CASE WHEN key = 'resolver:cache_hit'
                               THEN value
                          END) /
                      SUM(value), 1) AS hit_rate_pct
         FROM vmap
         WHERE channel_name = 'my-counters'
           AND group_type = 'user-per-process'
           AND key LIKE 'resolver:cache_%'
         GROUP BY owner_id
         ORDER BY hit_rate_pct;
       EOF
       } | sqlite3 -box :memory:

     ╭──────────────┬──────────────╮
     │   command    │ hit_rate_pct │
     ╞══════════════╪══════════════╡
     │ nginx        │         54.8 │
     │ chromium     │         71.2 │
     │ postfix      │         83.0 │
     │ redis-server │         94.6 │
     │ sshd         │         99.1 │
     ╰──────────────┴──────────────╯

See the lttng-export-maps(1) manual page to discover the full
SQL schema.

Other map highlights:

• A map channel may hold 32-bit or 64-bit signed integer counters, cap
   its number of keys, and follow a per-user or per-process buffer
   ownership model for user space tracing thanks to the `--value-type`,
   `--max-key-count`, and `--buffer-ownership` options
   of lttng-add-map-channel(1).

• With a per-process buffer ownership model, choose what happens to the
   counters of an instrumented process when it terminates while the map
   channel still exists with the `--dead-process-policy` option of
   lttng-add-map-channel(1): either discard them or, by default, fold
   them into the _shared counters_ of the map channel so that you don't
   lose any contributions.

• The lttng-list(1) and lttng-status(1) commands now list map channels
   and their configuration; filter them with the new `--map-channel`
   option if needed.

• The lttng-clear(1) command resets all the counters of a recording
   session to 0, without removing any allocated keys.

📖 To learn more, read:

    • The new “MAP CHANNEL AND COUNTERS” section of lttng-concepts(7).

    • The new “Map channel and counter” concept section of the
      online documentation [1].

    • The new “Count events with a map channel” online tutorial [2].

Save and load your triggers
───────────────────────────
The lttng-save(1) and lttng-load(1) commands now serialize and
restore _triggers_.

Saving a recording session configuration also writes every trigger which
exists at saving time, and loading it recreates those triggers.

This matters for maps: because the new `incr-map-value` action targets a
map channel, saving and loading triggers is the only way to preserve the
configuration which populates the counters of a recording session.
Without it, the saved configuration would have no record of which
triggers feed which map channels.

Skip this behaviour with the new `--no-triggers` option of
both commands:

     $ lttng save my-session
     $ lttng load my-session --no-triggers

lttng-load(1) doesn't restore the original owner of a loaded trigger:
the Unix user running the command becomes the owner of every loaded
trigger, regardless of which Unix user owned it at saving time.

📖 To learn more, read:

    • The lttng-save(1) and lttng-load(1) manual pages.

    • The “Save and load recording session configurations” section of the
      online documentation [3].

Record raw binary data with BLOB fields
───────────────────────────────────────
The new BLOB field instrumentation support of LTTng-UST records an
arbitrary sequence of bytes tagged with an IANA media type [4], for
example `image/jpeg`. Previously, LTTng-UST could only capture binary
data as an array of integers, with no way to tag its type.

The new lttng_ust_field_fixed_length_blob() and
lttng_ust_field_variable_length_blob() field macros do this:

     lttng_ust_field_variable_length_blob(payload, buf, size_t, len,
                                          "image/jpeg")

LTTng records the bytes as is, without interpreting them: think raw
network data, memory regions, binary protocol data, or whole files.

CTF 2 [5] supports the BLOB field class as is, including the IANA media
type. For CTF 1.8 [6], which has no equivalent field class, LTTng
records the bytes as a best-effort array field of 8-bit unsigned
integers; this loses the media type as CTF 1.8 has no way to encode it.

📖 To learn more, read the lttng-ust(3) manual page.

Start the consumer daemons up front
───────────────────────────────────
Pass the new `--spawn-consumers` option to the lttng-sessiond(8) command
to start the consumer daemons immediately instead of having the session
daemon spawn them on first need.

This removes the one-time delay of spawning them on first need from your
first recording session, which is handy when the earliest events matter
or when you're measuring startup latency.

Control the new features from the liblttng-ctl C API
────────────────────────────────────────────────────
The liblttng-ctl C API gains functions for all of the above:

• Add and enumerate map channels with lttng_session_add_map_channel()
   and lttng_session_list_map_channels().

• Configure and inspect map channels and their keys with the
   lttng_map_channel_*(), lttng_map_group_*(), and lttng_map_key_*()
   function families.

• Build the new “increment map value” trigger action with the
   lttng_action_increment_map_value_*() function family, along with
   string key template utilities.

• Capture and filter on BLOB event fields from triggers with the new
   `LTTNG_EVENT_FIELD_VALUE_TYPE_BLOB` event field value type.

   Get the IANA media type, length, and data of a captured BLOB field
   with lttng_event_field_value_blob_get_media_type(),
   lttng_event_field_value_blob_get_length(),
   and lttng_event_field_value_blob_get_data().

• lttng_register_consumer() is deprecated and now
   returns `LTTNG_ERR_NOT_SUPPORTED`.

📖 To learn more, read the liblttng-ctl C API documentation [7].

VERSION NAME
━━━━━━━━━━━━
This release is named after “Question de Perspective”, a stout brewed by
Ayawan in Val-Morin that the team adopted for its name. It is a
thoroughly standard stout: dark and roasty, faithful to the expectations
of the style, and remarkable mostly for how unremarkably it conforms to
them. An `std::stout`, if you will. Whether that counts for or against
it is, fittingly, a question of perspective.

IMPORTANT LINKS
━━━━━━━━━━━━━━━
LTTng tarball:
     • <https://lttng.org/files/lttng-tools/lttng-tools-2.16.0-rc2.tar.bz2>
     • <https://lttng.org/files/lttng-ust/lttng-ust-2.16.0-rc2.tar.bz2>
     • <https://lttng.org/files/lttng-modules/lttng-modules-2.16.0-rc2.tar.bz2>

LTTng website:
     <https://lttng.org/>

Mailing list for support and development:
     <https://lists.lttng.org/>

IRC channel:
     `#lttng` on `irc.oftc.net`

Bug tracker:
     <https://bugs.lttng.org/projects/lttng/>

GitHub organization:
     <https://github.com/lttng>

Continuous integration:
     • <https://ci.lttng.org/view/LTTng-tools/>
     • <https://ci.lttng.org/view/LTTng-ust/>
     • <https://ci.lttng.org/view/LTTng-modules/>

Code review:
     • <https://review.lttng.org/q/project:lttng-tools>
     • <https://review.lttng.org/q/project:lttng-ust>
     • <https://review.lttng.org/q/project:lttng-modules>

REFERENCES
━━━━━━━━━━
[1]: https://lttng.org/docs/v2.16/#doc-map-channel
[2]: https://lttng.org/docs/v2.16/#doc-count-events-map-channel
[3]: https://lttng.org/docs/v2.16/#doc-saving-loading-tracing-session
[4]: https://www.iana.org/assignments/media-types/
[5]: https://diamon.org/ctf/
[6]: https://diamon.org/ctf/v1.8.3/
[7]: https://lttng.org/docs/v2.16/liblttng-ctl/

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

