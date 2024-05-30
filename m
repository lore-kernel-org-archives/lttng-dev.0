Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C746C25B74
	for <lttng-dev@archiver.kernel.org>; Thu, 30 May 2024 19:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1717096342;
	bh=qUCfhYrK7aah0FaC3J9ta+AjK4QRpXmgICchk6LhVjM=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=douzxK44L3MDHVeme+2yTxxHzGZ/1gG7MHtDZPDvnu9YxzDSc6Fbv/pMwPAeFCgox
	 5qoY4RRij9sWBtOD2BuZ34GwT+C9okwch+mB9L9DkNL6ZbgfGkD2aoGdOCnwosqhxa
	 zwwO1MsADJIP9k0Avttw/QmWFyZcqUPr1VrDoYfn/MMT0FTNcxNvS/z6+uSPFudJWe
	 BAZ0AO1uSCrXR2ulvvHjNpeIgs+R4B8mFcugp/n+uZsZ9s9Dzb51+oVVOhT+7AlYjZ
	 0RaywhiqV3yFI2b7fJ2CUEUt4Yz3rAOW+oT2iAYwtewlkzyuaGr4NfZ4tKnhBdnH0U
	 16m+R7wfZYn9g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VqwqV2B0kz2s5b;
	Thu, 30 May 2024 15:12:22 -0400 (EDT)
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11021011.outbound.protection.outlook.com
 [52.101.189.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4VqwqS70vTz2rrZ
 for <lttng-dev@lists.lttng.org>; Thu, 30 May 2024 15:12:20 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRacxQdJvHf72BXqL8Av7U3ErbCe0GVLOtsiLS0zUC9Z1/y+C3STrOkrE+n4E+xxsLenoEUitQ3QAPEy7zURWc0/4KKMi7LV5vyPyfFd/BdHmMz4o4mUtde2vPwJ7z5GSFdYhqh/v+oElEcoYPwvhfTLe0Ec2Gq7FBf6vnFabwjDPXtot4TxqOWEXHArBJi9IUO4fOkvM43SIi57dc/YyDQBTpKoRTQbN+Z9UoP0dH/hDSWNwkCPY184dqoSWCt/WwDhPPP5Rw3dgVLfzOpH3YylfoH5VQZp8+OOBsuVWBWbMleiSdMAgHGunWZtJFrKhjEDv3yuQq0WFtaAp6id4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=midf9kw4hmtfxzBxKoej7Dn73APuyJIaLNZF7HOXk70=;
 b=nS6JKwG2rCYHcL16KFqvHeMr9pbjSkzPuVKYdG9y1OESpVMognObvllAvo0VWV0nWGz9FBYCbiqEPOO5YXQulTmUhMGnp9SIeGD9FKsKriX11ze/e4E+xlqKK3wnJC08JnJKDfCxATxsyKXp+EK5ED6n1ROCjauIR3GENK2ll86H9VZFFpim9AUIptn0mETM5h4BdZN7ZRFD6cZTLQEA/qxUALMNvgZMLBzPRQe7vJRwPF1u00ENKKzOL3+p5WNEHf85X2q7+nizU+FkeqNbiLYgkhTjPaWIMoMI3Zv6qKvRb6MWldZ9YqPp89qfnybrtJKRH8v92ADsF3Oi75O4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YQBPR0101MB8272.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:53::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 19:12:18 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%2]) with mapi id 15.20.7633.021; Thu, 30 May 2024
 19:12:18 +0000
Message-ID: <b974bf9f-b511-4fdb-8d67-93a6c1b273ab@efficios.com>
Date: Thu, 30 May 2024 15:12:16 -0400
User-Agent: Mozilla Thunderbird
To: "Wu, Yannan" <yannanwu@amazon.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <b2e9c32fbcbe4067a64fd831bac70d81@amazon.com>
Content-Language: en-US
In-Reply-To: <b2e9c32fbcbe4067a64fd831bac70d81@amazon.com>
X-ClientProxiedBy: YQBPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::14) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YQBPR0101MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 682eb66e-c6e0-480d-64a9-08dc80dc6ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cktBS2hXRm1mZ0cwOVFkS1FMdmFqaFJLMzJKeTE2eThaQitCWEVRSXpRQzJI?=
 =?utf-8?B?Zk5KL1FUbFNqNUs5dHF1UWhBOEdjaU54emxIem94MkJLc3FqQkxDWVc0MWhi?=
 =?utf-8?B?M1pxWEwxci9HWklqVUxKb21jNXp2N1BDbjlHc1UwZ3UyN2VxREcyTVdJSW1m?=
 =?utf-8?B?V2pTWUJlYjNjQ3NpbEdYL3JVeEd2b3l5Q3RPbml2eC9hcHV2a1RqK0Vza3ZZ?=
 =?utf-8?B?Z2NvTWlFemt2ei9tTmFDWE4yOExjNzlIaFh4WmNQUkFPZ1dQcUY5b1JjL3BU?=
 =?utf-8?B?SUswSHZmY1h3RnRjczhsSTVvUTlWaVMvSm81ak1GTmZVaFhZL2oyNWcwWVEy?=
 =?utf-8?B?VjFoWFJyWXUwYXJmTXY2S1k0bW03dWNGWlNjOC9hN0VlOTQ2NE82Sko1aXlh?=
 =?utf-8?B?UWZVK0hlSWV2RS9PVjRmN2xnWEhrUTJCVSt5dWZjaXpTZ2FTcnlUWVRra1ox?=
 =?utf-8?B?QlVKUTdvWURrK1IxTVlXRERpeDlBV1paWXhrK1hWdm0zbGhGZjJ1blJFZUJX?=
 =?utf-8?B?anNwSkFnREdIenJLZ1pSSWVjNjh6RWJsT25Cd2s2SEU4S1dhRThUV1NISWQw?=
 =?utf-8?B?TUVFOVdXKzVsY1NSbE4zZm8ySmUwZnJFOW0yMnVpSWN0bnkya2JtakJodTBp?=
 =?utf-8?B?UTVRa2IvcnJ1dEd5U0tpU2tXNEJDeGFDVUwzNlF0bEJ0cWFVSmhtVlIzWEtx?=
 =?utf-8?B?Y0J4MVNFd0xwTytESGVvUUV6VFhQL1piOUt5dzh5NENJSWhacWYvMWMzV0VW?=
 =?utf-8?B?Qjc3TWxlNjg5bStOZ1A5T20yMXRLRHJGMmhNSmdORVlHa3VvN1RhcXJtM2lk?=
 =?utf-8?B?NE5LbitkM3VqMHJ3WnpzZFZESGdOck1BSnltZDIzQVNMWnhXQVJDWWJ0dzVi?=
 =?utf-8?B?WERja1Rac0Y5dExvdHRoc1Z3dHI0dUNHYTlXdks1cENCZUNSL2hTd1VNTTYy?=
 =?utf-8?B?amNrK0JTbURVUC9Ic1Z4bSsyTk5tbmJubC9rdWR0a0JpZ0hPRkVSb0E1S0Yw?=
 =?utf-8?B?Vm90cjd6YS9XQWU2RmNYWkRQVWlmS0NKWkF2V1R2eDZNaGJzNkNJenpQdEVB?=
 =?utf-8?B?aE1zUDJuRzZaNENwdnBiVHZteXJMSi85eUgwbmtxYVJlZlBwa2FnVkh3c0ZV?=
 =?utf-8?B?RnRaZjFRVDlEUGZCZDlQM3pYN1g5UU1Ia1RtRTV0Yy9zeWVzUTVUUzBKTy82?=
 =?utf-8?B?SVFzaFdSYnlTNUZyTWRNL3VIdlZzcXRCLzZJM1IwYngrRHhvYjRuWFZxYWc1?=
 =?utf-8?B?L0tBOWI5R1h1V0Z0QTcvM0c1K1dLNDBtMHdUSU9ZcGMvckpNZUg4c2Ewd0gy?=
 =?utf-8?B?cXM3d3IwRWpWL01ZeFpMVUszcEdESnJ4QWNYcjNtR0ZnVm51M3pjMnA2OU5K?=
 =?utf-8?B?M1dUUkZkeHZ1TmRreXdXWTJjWVRsbWNacUhJK256YUo5N205bUEvam9YVTN6?=
 =?utf-8?B?cjAyVzlRZWZ6SFZBZVF4NURGRG5BUS83M1RsL0M4MXZnV2lVV0Z5SGxyYkox?=
 =?utf-8?B?dWFUZ3hGMjhFMWNYQnZQTWpqRlRod21rK1o4dlgwTzNGZGJ4OXF5VEc2NHhu?=
 =?utf-8?B?eWJ2TXl0VkhQb0NZZjNUN3E3NC8zMWVNRTZrZC8waVVPb1FTL3FkY2g0RTcw?=
 =?utf-8?Q?vmZK5lnMGuqt5mcfrBE+iPim1gRbBAvaBpWf8fTsZp1A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2daNWxzMnhFWmUzMVR3dkZuWTN0dkxvaStYN2liUHlRRTlZYTNOeUQ1Q3JM?=
 =?utf-8?B?NGM4dVVDVldabEZhcU1JQ25nanJhaHVPTTZhYWRFOGtRNHVmSGxtTlNyY0Z2?=
 =?utf-8?B?L1lMTGpvMDFMTkNZWk9lalNWSnJwVHBXWVhSc0pYcEpFL2JXMEZ6RU5pL2Vh?=
 =?utf-8?B?TUdvZlN4MGNKTnp6TXNVaXh4WDVQSmo2RE9EV0VwRHBLZ1VpNzRQeWJyd2c1?=
 =?utf-8?B?dXUxVXJOMVVseklrcHBDQlJOaGkyRnNZV0tMZVhQWVpvMHJSaklIRWlCY2NF?=
 =?utf-8?B?ZnpGdUxWaldtaTlNMWU3ckxhbDZlTGZNR0xrNEdqZnd3THdLUXdtUVJXV3M2?=
 =?utf-8?B?b09tU3NVU1kvR0xSaDhjS0x6dXdmZmYrZG9TUFNPZEgwVFd1b05qamcyZTkv?=
 =?utf-8?B?RGU2MWFNVFhvc3lEclRLYVpMbjg4dVo3eEI3Y1F6VHpaOUVsR09XLzR4YXkz?=
 =?utf-8?B?SVBnN2pnYTAzUGdZd082YVEyV0czRzNISzFWTUJaeGRTS1QwY3p6bXFMemNF?=
 =?utf-8?B?MjRoY2toOGZwa1Q1R1Npc2psL2Vwd1MyWEdpaXRLbXM5R0NPYUdJZS9wYnZz?=
 =?utf-8?B?L1Evc0RPeUY0OWdDaEpvcHhVTjcyNzVOa0JoVDJTWTVzeXNiMXNNQW1WdXRp?=
 =?utf-8?B?S3hXdWtZNzRtb3ByYUxiVnJ6dloreGRLa0EwQ1ZYMU9ZQ2FxdzZ4dW9HdUM0?=
 =?utf-8?B?d2c0SFZWM0hlejJiUUZ2RURUbWRyQldGK2RzTEhxaFJ5NERDR0hTYUV0SXFp?=
 =?utf-8?B?dUNGMC8rVHc2TU9CYTNNVTVoMFhuRyt4V0s4b3htZUNNQldQL1NNRVgrdzY5?=
 =?utf-8?B?dTY4UUtNVURtYjhGWmN5VHpaaExZaGNsSk13bjZmRnBYNW5EVW5qMjZQTWMz?=
 =?utf-8?B?aFloSkhmNVpDKzQ2RVRJR1psdGRsbU5lNmJsR0hzZFoxcU9pSGhDUFUvSmlF?=
 =?utf-8?B?Yk1FZ2ZNSXZBblF2VUdFd2Q2b3d3ekc2K044eDdOVDVFYmphVVFWN2tQRUkz?=
 =?utf-8?B?ZVFBQnJkWVhIdWxQWGg0cXA4dmtRVCtkRDZxZHlHVGlhZXpIUGJoMWtrQkxv?=
 =?utf-8?B?UDRQYzQ5M1RkMFpNQUZnbkVobDZaUHNQK3IxT25OQjN0ejVyZ0hhQXRXbzlq?=
 =?utf-8?B?Rmg4Y0toeXMvSkJGZ2Z1QkZ6SUlsbzNCWWVCN3Q1ZUtjeUpVcWxXMGg5akh2?=
 =?utf-8?B?RStWQkg1cjJmemxENDRFMGxyWXNUTDhtZCt1SUNSYS9oQVdZR24xUmw4TkJF?=
 =?utf-8?B?WFlCZHlkbDBQRnRzNDVCQS80T0xnb3BNSzV1S2hhTnV5OVNudW0wYkJrcG92?=
 =?utf-8?B?VStGWnlSdzI3dXNKdTBnYlZJMzRacWl2L0E3UkRQL2xHdWZDR0NtVk8veGxY?=
 =?utf-8?B?SldLVDRlRElMUWNLQUwzMTBWM2xvNDdXL3hQRkZPY3lSTUx1MmQxMHhRTUN3?=
 =?utf-8?B?aWRuUlA3VHJ1SU5nakR4R1ZDeVEvMk9QamNEZGZsK1JNdWIyRmpIUVFDS0x3?=
 =?utf-8?B?S0FHSmlEbGxvVXJCL09iK3M0YWFHWjhnbUhsdVFVL2FGR0ZMK1RzWDVZTGxu?=
 =?utf-8?B?NnFGV3FSeVZWMEJYUmNzN1prMmhGUEpabVBpdENWVkM5WURub2hDblpmRHBo?=
 =?utf-8?B?WXdLalVxdW1mS0RuekZQTjB2OHRSUzRmSTE0b1BYM2Rtc0hDZmNlN0o3MWFu?=
 =?utf-8?B?akNTRW95SWhhYUI2OTd1MDZlWFRiSTNQdEZEVUc0NFpzMjg4MXE1a1J6Nkh1?=
 =?utf-8?B?bWlsNWtwV1FMUjlCSUJjOElyUkhpdDNpRlRkMjdidlhURTE2c1dIUTc2VkJh?=
 =?utf-8?B?bGZDdjd2UXFJcEl5U1lacDZDcFFCVi9qK3RLNlNrUTBxWHZkNHJTNTRvVVJ4?=
 =?utf-8?B?ZFVTc2kxWGpKakk4N2dpbisvam1kUXNEYkNqbHZSSXR1ZXJxTXVnUnlWYXFX?=
 =?utf-8?B?U29UTDVjcjg4WVJVemhFU1RWM2htT1NneHN4c2EwbnB3aHBPWjdYZ3I0YVU4?=
 =?utf-8?B?aUNwTm5HZHlEVkZiQ3FQTHNVZGNrclRFUTNHR2tkMU1xd2NiUWNONjNIWWJn?=
 =?utf-8?B?TTM5VGNFKzhiSXVWamVUc1hFc3NUR2VTY3JoS1FTRmNNNVBXODFjcnVVbFo4?=
 =?utf-8?Q?nI30vFrObvszEu2KdGOpT2mRR?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682eb66e-c6e0-480d-64a9-08dc80dc6ca0
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 19:12:18.4465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntBtOsUmvbRcUxi/PanlKuQtLf3sArScRD0KEg8ADSJNmyWauklUBAb3Iz2JQ16aN29qNEad/u4h7aQyuQ5o/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8272
Subject: Re: [lttng-dev] [lttng-relayd] is there existing cases for relayd
 to stream over Android usb based adb?
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

SGkgQW1hbmRhLAoKSSdkIGxpa2UgdG8gY29uZmlybSBteSB1bmRlcnN0YW5kaW5nIHRoZSBzaXR1
YXRpb24uCgpBbmRyb2lkIGRldmljZQogICAtIFJ1bm5pbmcgbHR0bmctc2Vzc2lvbmQgd2l0aCBv
bmUgb3IgbW9yZSBjb25maWd1cmVkIHNlc3Npb25zCgpEZXZlbG9wbWVudCBkZXZpY2UKICAgLSBD
b25uZWN0ZWQgdG8gdGhlIGFuZHJvaWQgZGV2aWNlIG92ZXIgdXNiIHVzaW5nIGFkYgoKWW91IHdh
bnQgd2FudCB0aGUgZGF0YSBjYXB0dXJlZCBvbiB0aGUgYW5kcm9pZCBkZXZpY2UgdG8gYmUgc3Ry
ZWFtZWQgdmlhIAp0aGUgdXNiIGNvbm5lY3Rpb24gcmF0aGVyIHRoYW4gdGhlIG90aGVyIG5ldHdv
cmtzIG9uIHRoZSBhbmRyb2lkIGRldmljZS4KCkNvdWxkIHlvdSBleHBhbmQgb24gdGhlIGNvbW1h
bmRzIHlvdSB1c2VkIHRvIHNldCB1cCB0aGUgdHJhY2luZyBzZXNzaW9ucyAKYW5kIHJlbGF5LCBh
bmQgd2hlcmUgZWFjaCBvZiB0aG9zZSBjb21tYW5kcyB3ZXJlIHJ1bj8KCkl0IHNvdW5kcyB0byBt
ZSBsaWtlIHlvdSBtaWdodCB3YW50IHRvIGJlIGRvaW5nIHNvbWV0aGluZyBsaWtlIHRoZSAKZm9s
bG93aW5nOgoKKERldmVsb3BtZW50IGRldmljZSkgU3RhcnQgbHR0bmctcmVsYXlkOgogICAtIHRj
cDovLzAuMC4wLjA6NTM0MiBhbmQgOjUzNDMgd2lsbCBiZSBib3VuZCBvbiB0aGUgZGV2ZWxvcG1l
bnQgZGV2aWNlCiAgIC0gdGNwOi8vMTI3LjAuMC4xOjUzNDQgd2lsbCBiZSBhdmFpbGFibGUgZm9y
IHRoZSBsaXZlIHJlYWRlcgoKKERldmVsb3BtZW50IGRldmljZSkgQ3JlYXRlIHRoZSByZXZlcnNl
cyBmb3IgdGhlIGZvbGxvd2luZyBwb3J0czogNTM0MiAKYW5kIDUzNDMKICAgLSBBdCB0aGlzIHBv
aW50IDo1MzQyIGFuZCA6NTM0MyBzaG91bGQgYmUgYXZhaWxhYmxlIG9uIHRoZSBhbmRyb2lkIApk
ZXZpY2UgYW5kIHJlYWNoIHRoZSByZWxheWQgcnVubmluZyBvbiB0aGUgZGV2ZWxvcG1lbnQgZGV2
aWNlCgooQW5kcm9pZCBkZXZpY2UpIFN0YXJ0IGx0dG5nLXNlc3Npb25kCihBbmRyb2lkIGRldmlj
ZSkgQ3JlYXRlIHNlc3Npb24ocyk6IGBsdHRuZyBjcmVhdGUgLVUgdGNwOi8vbG9jYWxob3N0Lwog
ICAtIFVzaW5nIGAtVS8tLXNldC11cmxgLCBubyByZWxheWQgd2lsbCBiZSBzcGF3bmVkIG9uIHRo
ZSBhbmRyb2lkIGRldmljZQooQW5kcm9pZCBkZXZpY2UpIFN0YXJ0IHNlc3Npb24ocykKClRoaXMg
c2V0dXAgc2hvdWxkIGhhdmUgdGhlIHJlbGF5ZCBydW5uaW5nIG9uIHRoZSBkZXZlbG9wbWVudCBh
bmQgd3JpdGluZyAKdGhlIHRyYWNlcyB0aGVyZSBhbmQvb3Igdmlld2luZyB0aGVtIHdpdGggYSBs
aXZlIHZpZXdlci4gT24gdGhlIGFuZHJvaWQgCmRldmljZSwgdGhlIFVTVCBhcHBsaWNhdGlvbnMg
KGlmIGFueSkgd2lsbCBjb25uZWN0IHRvIHRoZSBsb2NhbCBzZXNzaW9uZCAKYW5kIGNvbnN1bWVy
cywgd2hpY2ggd2lsbCBzaHV0dGxlIHRoZSBpbmZvcm1hdGlvbiBvdmVyIDo1MzQyIGFuZCA6NTM0
MyAKdG8gdGhlIGRldmVsb3BlciBkZXZpY2UgdmlhIHRoZSByZXZlcnNlIHNvY2tldHMuCgpQbGVh
c2Ugbm90ZSB0aGF0IEkgZGlkbid0IGhhdmUgdGltZSB0byB0ZXN0IHRoaXMsIHNvIHRoZXJlIG1p
Z2h0IGJlIHNvbWUgCm1pc3Rha2VzLiBBcyBJIHJlcXVlc3RlZCBhYm92ZSwgY2xlYXIgZGV0YWls
cyBvZiB0aGUgZXhhY3QgY29tbWFuZHMgeW91IAp1c2UgZm9yIHRoZSB0cmFjaW5nIHNldHVwIHdv
dWxkIGJlIHZlcnkgaGVscGZ1bCB0byBoYXZlIHRoZSBjbGVhcmVzdCAKdW5kZXJzdGFuZGluZyBv
ZiB3aGF0IHlvdSdyZSBkb2luZy4KCmhvcGUgdGhpcyBoZWxwcywKa2llbmFuCgpPbiA1LzMwLzI0
IDE6NTMgQU0sIFd1LCBZYW5uYW4gdmlhIGx0dG5nLWRldiB3cm90ZToKPiBIaWhpLCB0aGVyZSwK
PiAKPiBJIGFtIGN1cnJlbnRseSB3b3JraW5nIG9uIGVuYWJsaW5nIGx0dG5nIGxpdmUgbW9kZSBv
dmVyIGFuZHJvaWQgdXNiIGFkYi4gCj4gSGVyZSBpcyB0aGUgc2l0dWF0aW9uLCBkdXJpbmcgZGVi
dWdnaW5nIHNvbWUgbmV0d29yayByZWxhdGVkIGlzc3Vlcywgd2UgCj4gZG9udCB3YW50IHRoZSB0
cmFjZSBkYXRhIHRvIGJlIHN0cmVhbWVkIHZpYSBuZXR3b3JrIHRvIGNhdXNlIGV4dHJhIGxvYWQg
Cj4gdG8gdGhlIHN5c3RlbSBiZWluZyBwcm9maWxlZC4gVGhlbiB3ZSBzZWxlY3QgdG8gY29ubmVj
dCBsdHRuZy1yZWxheWQgCj4gd2l0aCBhZGIgdmlhIHBvcnQgZm9yd2FyZGluZyBzbyB0aGF0IHRo
ZSBkYXRhIGlzICJmb3J3YXJkIiB0byB0aGUgaG9zdC4KPiAKPiAqSGVyZSBpcyB0aGUgc2V0IHVw
IGFuZCB0aGUgcHJvYmxlbToqCj4gCj4gZm9yIHRoZSBkZXZpY2U6wqAgYWRiIHJldmVyc2UgdGNw
OjUzNDIgdGNwOjUzNDI7IGFkYiByZXZlcnNlIHRjcDo1MzQzIAo+IHRjcDo1MzQzOyBhZGIgcmV2
ZXJzZSB0Y3A6NTM0NCB0Y3A6NTM0NAo+IFRoZW4gc3RhcnRpbmcgdXAgbHR0bmcgd2l0aCAtLWxp
dmUgZW5hYmxlZC4KPiAKPiAqV2hhdCBpcyBleHBlY3RlZDoqCj4gbHR0bmcgc3RhcnQgc3RyZWFt
aW5nIHRvIHRoZSBsb2NhbGhvc3QuCj4gKldoYXQgaXMgc2VlbjogKgo+IHRoZSBsdHRuZy1yZWxh
eWQgZmFpbGVkIHRvIHN0YXJ0LiBGb3IgdW5hYmxlIGJpbmRpbmcgdG8gdGhlIHNvY2tldC4KPiAK
PiAqVGhlIGNhdXNlIG9mIHRoaXMgaXNzdWU6ICoKPiAKPiBib3RoIGFkYiByZXZlcnNlIGFuZCBs
dHRuZyByZWxheWQgbmVlZCBiaW5kaW5nIHRvIHRoZSBzb2NrZXQgd2hpY2ggaXMgCj4gY29uZmxp
Y3Qgd2l0aCBlYWNoIG90aGVyLgo+IAo+IAo+IFNvIHdoYXQgSSB3YW5uYSBhc2sgaXMsIGZvciBl
bWJlZGRlZCBzeXN0ZW0gdXNlIGNhc2VzLCBkbyB3ZSBoYXZlIAo+IHN1Y2Nlc3NmdWwgdXNlIGNh
c2VzIGFtb25nIHRlYW0gdGhhdCBjb3VsZCBzdHJlYW0gdGhlIHRyYWNlIGRhdGEgaW4gbGl2ZSAK
PiBtb2RlIHRvIHRoZSBob3N0IHdpdGggdXNiIGJhc2VkIGFkYj8gSWYgbm90LCBhbnkgaWRlYSBv
ciBzdWdnZXN0aW9uIHRvIAo+IG1lIG9uIGhvdyB0byBwcm9jZXNzIGZvcndhcmQ/Cj4gCj4gQW1h
bmRhCj4gCj4gCj4gCj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
