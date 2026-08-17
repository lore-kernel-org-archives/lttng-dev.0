Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6A1C5B572
	for <lttng-dev@archiver.kernel.org>; Mon, 17 Aug 2026 14:51:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hNwkZ2q6dz29Sl
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1786978264;
	b=T+L1xWw6jUZPYl+/sVVY3ZZvLg9ZNtuhFDa1hwMmtpjRYOdr13onhxTduGCErhr6orXm
	 RaYSKH3hTmUNmvMNPZ7ufUEUuWpVB7lCFS7d81kCcQ9Kaxlmet+e9tbVV08kXr0VfQi7O
	 qHdkHcAC3GkKOMP/j8+nX/MMchuoBt/aFDIS0HbBXuNIFH/QPy+nw/TaahamjchF3+9WW
	 2SmVUdKE8CMmPrAgwtRZF/IYmLguuaRzRu+QyMqO9t0K0ugOOKhI7h37DvQdUtco8PQAl
	 SNafPG0aEutqxXvb+FpFEGWxW9Oo6J7Pe3uHpLW+GQ9NxY9YdHdmylId8205m0X1TaA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1786978264;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=GtWqVRzFDirTiOVQmexEMrZOtCQlKvMmsGPEb2WVStI=;
	b=E+koIUFymIRYi37V+RSP0pJminKsiiNPyhvHSZ15h5MwpQQd035Xu6LYLbejiL5A8G26
	 aCfs5ODJx0Dy8QaT4t/CZXFGwddjxLRSbkWjWaOz0s80B0PiOAfuf1M8cAVCJXHSIfHmU
	 y7Xy9C/ZLFcdRR8LdHbrsA7H0+q0fcfgePv7wtH3pi9eGjT/8TGKzmq3v650qkLWLlex/
	 QmPw3rNS+366NIbYpAkcaJFaIBD2E2019htFhhLPzKj6SFTEqE69gpj5ns2KRIaBR4Wa1
	 1PJbXFtgtTfcK5zYw6DDywnMPDRzcWZyN24eW+L78Gx71/RbbHV5VdOOB9FFZe9wCaw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hNwkZ2q6dz29Sl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1786978264;
	bh=8Lz8uEc9cdaly0zDLDixE3E1OOzcroe0Mv7rMrYccPc=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=SGvbIMDMp1m1O/JRgmRHoexUFut9YAZ7+sTcX1i1uu2HyVzistyaA49hFzjmmK4Eq
	 cQYnTVRpDpJ3bJagnxaOdQxwZ18ai1g9c5LWLfDDV5ebxEmW3GOOy3hEfdmG/asa07
	 /m+BBN9N4UbET/bvBgdxBT4XdXseho12Qk39AzRMPqk/pxB55nBz71cuSf8g/9l0o/
	 eb7uG8nnfrX27BeM5JatEoR9IhA/xoHQGMKXGaNdm4iu2uWsHD74LPKjpWwA2ot4NG
	 UuvL5Vrn4Qvn6wGchJ0wwk10qmzvBUWxR80ZUxdMfp6DE0gUvriqg1f3es/g/jVX1q
	 OmC0OfGEdQ7LQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4hNwkZ2q6dz29Sl;
	Mon, 17 Aug 2026 10:51:02 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hNwkX4NLQz29MQ
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hNwkX4NLQz29MQ
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c104::])
 by lists.lttng.org (Postfix) with ESMTPS id 4hNwkX4NLQz29MQ
 for <lttng-dev@lists.lttng.org>; Mon, 17 Aug 2026 10:51:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYJ5RpqwYSerwp0+BYQLh4h8eDGYCcF0vCMzJqlX9TCM64S31vCFmZ/95Se+TPqngi19Kx6pwR/qBAN8X3AWIHZSZcAieX5Pz/uBFPvWcmaROTA01bVWHDmwtq9Kdfiy1Nr1c59ZKg5q8R99PWpVmh7eqOjhYqsc1KEUVzH5RioJJb24C5za/+hz5wt/y/3BV4GePHhUsvw7hDlz9x86YiwbKUNe1HDbe/Fyxc1zX+pABgiXC66sYdNc4Ohy007XgC8wKGM364pgOcJp1Ao9CRn4vft07cmN8AVgVAEQEm/As2VEB4X4i3VntfVYtr37MrQWvLHKw1fRPaouvowyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Lz8uEc9cdaly0zDLDixE3E1OOzcroe0Mv7rMrYccPc=;
 b=hUeVOSG5mreIxc4cQGRo8AYEOt+8VvFjJ0b3DD1wX0EgQPDs8wiFosmVDYhsYeHbrW6RbM43g07n0iwSVTmBBhHCjx9I4q4NlXsaFLq2EhM1C/Wt5X6Ff/Mqcx1TGurmC616JGV9e8E58//jhRE49TT7m6O/Tsb9yB4Gy0OgYSXy7FXZ6vpl95fCB9FnaJ088/Hecc3z/3DjIgKlJIcxaeRZPDTkr4bb6I1RCXX569dWVa9jwCai9arxreUm4m3r06vc2SXHGKuuuBfr96yLY4ubqcRlZj0w5MjG1umnBf6aM0zG/YXviWnDalmEQA9LF8WJ/eDi5dKw/tdCPckRbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8487.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:50:54 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 14:50:54 +0000
Message-ID: <72b01b28-75ac-43d5-85b8-2a9317c946c3@efficios.com>
Date: Mon, 17 Aug 2026 10:50:52 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RELEASE] LTTng-modules 2.15.3 and 2.14.7 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 842a1b0d-95a0-4c6a-43b8-08defc6ef034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|23010399003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: C8+rqqAOIQvoN8fTrb4FQcblCLlSdNz6F9q5kdvIIfFWWzkQasJeRM9cSVA7jQrxPEWcJQ2FG9pdoTVfbXm75wiU4aHDCxNIryZbkIxNu8AbNHU+TJmznwiqjcrFaMap/UxKVj5YeL7hjN2cHHAwDl6ktOIb8odmg0aaV/mFhU1utEKZl5UuHiN8+A0FTdhWZDHsS8beNjDSa16FNgorF1VjV1YS1nbviXVfkvMdrtsJznzMfxu96aoyr155gRGldFisgHmIfkmclgeVPILaOHRjNrEL5Ca2u13VGYzqzaj9bDYpcm+ov4lnJhQL12x/Gr3l0AmZZiaJ71cpx8cBXRkIOTfTP1vqIO4sJ4A8pAoJKSzz0Gox440p4FxlqLlN8DOgCX9f7je5wctQIn8lOhc3m1i9TZkg/iy8e+mwNisVwqH940kCo8TfjbQpLapbrXyfojLDvTx9SpNhXTcCMZJZ9o3xELUfWLH+6pjlNsjl4BARnScLGqLhaMKLRPMjLM90+3EwyWbyc0Z2wuzxxdCxKzniq2Jl+/6VKsdPYNPh3DMjhtqXsIrVqVRPH7OwXY3BhZd6HmqgK0n+YWnuPdJwTVKM34+5d16xg7xysl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NENkemxsSTBOcS90KzBnMm44eGI1bmdEZ3lJY1ErbUFObmFjZ2JSeGFLWmk5?=
 =?utf-8?B?amowS0Q0RzBzaFZTOTYzZ2ttbjR6TFd2cWgyaUV3bnJLamlNd21PR1o2M0Zo?=
 =?utf-8?B?NWx5K0tZNlZOODRJNktMV21KMm1lcDRoOFdCYTJ1U3lQeUpiT0s2ZTVDNkxs?=
 =?utf-8?B?WURwcHZMMElhbUFtaHc4bGNMZTg5SWZPd0UvK29wWGZDR1J3UXFFc2hERWJE?=
 =?utf-8?B?L0hOcVN1M0hnemRsRi9KUkxrME1KNVFWYnhPZE9EWXFJZWVpOUE0d0JTZGJ5?=
 =?utf-8?B?RFZ1TE9jTkNzbUw3c1hsZ1EzekdJSndYdmNjejA1dGdIblRCVktCc1YzWE1p?=
 =?utf-8?B?Z3UvdHlCOU5qQTFUeUJOUmpaVS9sZTRkRUtmdEYrVElKbVVKODgxV0treUx6?=
 =?utf-8?B?eWRVc0daWHlhajRjQTd4dHBCZHk0Q2syeGtuRm8vVDMzL2JjQ0dXWEIyVjVZ?=
 =?utf-8?B?YXFRQzhlZTlGSDc1bVBOYmdzZHhLSDI5eXdwT1gwbGZ4VFE4L01tYTJMQldL?=
 =?utf-8?B?Q25uSzM2WU9yZnFMQlRHSVlaVlFNMWFiZXNVN3BqeG5vdmcybi9wTGVCcC9Q?=
 =?utf-8?B?a042TGlqUmVoaGRMaGRKRnArbldtbDNKaUxuMklXQ2pKYk9qUlBScGt3TVJy?=
 =?utf-8?B?Y3Vlbkxack4wZnBmbkFycDYxZVFHUlhDaEVHVExvTlcvVHlkRkd5NG9ObmY2?=
 =?utf-8?B?L2V6Z0ZpeW93d241ZXB4K09EWkJxcmNvQnRkMUhRRHQzVFQvQ21BQi82bnl3?=
 =?utf-8?B?MzZzNFdQTnk3R0lwVml4WW0xZkdRYStWWTdMaEY1Y1prR2dvMW84OEZUTUZa?=
 =?utf-8?B?Lzd2VnFCOHhGNEswcnpMZXhsZGZsQkdMR2RyVnpOZ1RQbFdLWDY0ZFQwdVli?=
 =?utf-8?B?Sk0vUnFORnNEaEdvMWNOQVlYVGhZZW55YnlNSmd3N3NlWkRKRUdVTkcrOEpC?=
 =?utf-8?B?ekZ1UjkybUpqNUt3V1dNT202RjZ1OE9KY2JmRkluY28wVDlKUERJdExKSkw0?=
 =?utf-8?B?ODBUOEgzMmJOdDBqdWk4TFBkRmhla0EyeEJRSkIydHRZY2tDTXNkcFBvRTB3?=
 =?utf-8?B?cDFxV1plbWF4OXROOFNqVC9GTFNsZjB2dGdhSCtnNVpEcFNpMWpVSTVYVFpz?=
 =?utf-8?B?UTM5OWhkSTI3K1VNSG4yMERmbWt4RUF6bXFEcytOVmMxaDloaGJsU2tDWEcw?=
 =?utf-8?B?Zi9QdGhoTldSQWpLQlo5ZGJrRW42U3lubDBOcm1VaU9sbkJOUk9Ea2E1OGpo?=
 =?utf-8?B?clduUGJYNG9RVk13dllWd0tjcmp4VWg1NjF2c2g1R3JyWDdNd2pvZFptaGNj?=
 =?utf-8?B?OWE5SEVHOG5uL0tPSXAvRnZ0NDR4VHJLLzk3Z2pZTFhHL3Y5ZGVPQVEvMnJ0?=
 =?utf-8?B?R2FvMU1HVXlnSVVYTlM1N3ZWNHVHNzlxRUQvN3NZWnFCdk5Jd0JkMGV6YzdJ?=
 =?utf-8?B?Y0oyR3hsV0pORXhMUnZQcGlYWDZKU3ZYYzl0d3dGRGxndXZaWkx2NGtsaUR3?=
 =?utf-8?B?cU9YK1lIeUZDVVZ3bzhNOUkxOGsxUFdLZTJmaFVIdG1PeExBUm5WSW1xSE1G?=
 =?utf-8?B?V2RXVnpValFSMjN6ZXI1NFUxNnRKT1dLSXBnT2d0bnhQNHdnV3NuVWs0SHZn?=
 =?utf-8?B?bmNlRXIzRm8yMndmRmN4MHdVbCszMU5DbWFlT3h6Q1ZqaG9vVGhDNFVRQk1h?=
 =?utf-8?B?SmJDMUYxQWZiYklFalFyS3k4UncrOXNsa3lYM0c3TzNTajhyQnBkTllTOUwz?=
 =?utf-8?B?RTFNdVU1ZTRZVktjb2VFajRTYk8xNjIyWUdxbGpQOVF0UHBUUFpZUGNTNUlr?=
 =?utf-8?B?eWk1TkszWGUybWRlK2p4U0hKMnAvYXJNNk1SU20vcElsNlg4QytMNjh2YUQr?=
 =?utf-8?B?SHU3bGZlUWsyK2hwa2RMN2wxVDY5blprWEVENnNaNUhZd1dQdXRzdE56OHR0?=
 =?utf-8?B?amNvdEZVbUN6RUxPN3RScitCZU9uRzVLL3pJZzA4YWdvLzUrLzRhSmZFVWJp?=
 =?utf-8?B?dGhESGtmeWxJUHdNck1EeEpheURZcVNYR2Nld0pZOUdhV2pIZWhLOTZnNTND?=
 =?utf-8?B?SXlsbjhBdzVyaStMOWRnVGVyNlE4cTdpVWhpbEJHN3pCTXJtakViMWhoT0xY?=
 =?utf-8?B?UlBZRUxkckFTbExnaWRhb2xYT0NTdkdtcWRITjkyYm1mWXhwb3RhQmU1RE5X?=
 =?utf-8?B?RWNpL2FQbFp1cndKMGMrUEFMQ2RlNWVHZHhxTmtnaHJiMkNGUWVqNmkrSEVp?=
 =?utf-8?B?Z3QrRGdvUlhKT21pRiswRHoxRzlveFNUZ0hoZmZqUTgxcWphdit1SUhvS2dT?=
 =?utf-8?B?K3I4SEpETWozRk0rWkJQYWUwZUV3YXRsTGhkV1JiVzR2S1R4R1dBVm9nZmlK?=
 =?utf-8?Q?iVndw8q8G1/PD62+Srg8SD9uQrncz9EYE2BcPghrIuBjh?=
X-MS-Exchange-AntiSpam-MessageData-1: GLwPa4C2UEqZtctQnk/evZ3kfjWGtbI8GsI=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842a1b0d-95a0-4c6a-43b8-08defc6ef034
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:50:54.1914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tb3h94wLUoxHrpEkkCa2eLVJ7Dr5vjYxRkpjxjbQeU34X2vxkAjfSY/hneOzGpPRveUbQhlR+UEc8bLSEihpHf9TP8HHNPWv6Vlx+qBf+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8487
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

This is a stable release announcement for the LTTng kernel tracer,
an out-of-tree kernel tracer for the Linux kernel.

* Highlights

LTTng-modules 2.15.3 adds support for the Linux kernel v7.2.
The 2.14.x releases of LTTng-modules now have an upper bound:
they support kernels up to v7.1. Considering that we expect
LTTng-modules 2.16.0 final to be released around next week,
we can expect this 2.14.7 release to be the last one for the
stable-2.14 branch.

A fix appears in those releases: since we introduced the
"flush or populate packet ioctl", a kernel trace could contain
zeroed UUID in the very last packet of the streams within snapshots,
thus causing Babeltrace 2 to fail with e.g.:

         Invalid metadata stream UUID:
         uuid=00000000-0000-0000-0000-000000000000,
         expected-uuid=8962f7e1-f875-8f47-a112-43868a4b000b

The commit "Fix: ring buffer: zeroed UUID in populated empty packet headers"
fixes this issue.

* New in these releases:

2026-08-17 LTTng modules 2.15.3
         * fix: backport: hrtimer: Reduce trace noise in hrtimer_start() (Ubuntu-6.8.0-136)
         * fix: string: Remove strncpy() from the kernel (v7.2)
         * fix: btrfs: tracepoints: trace transaction states during commit phase (v7.2)
         * fix: btrfs: tracepoints: add in_fsync field to transaction commit event (v7.2)
         * fix: btrfs: tracepoints: pass a transaction handle to transaction commit event (v7.2)
         * fix: net: constify sk_skb_reason_drop() sock parameter (v7.2)
         * fix: KVM: x86: Rename kvm_cache_regs.h => regs.h (v7.2)
         * fix: x86/msr: Remove rdmsrl() / wrmsrl() (v7.2)
         * fix: warning -Wordered-compare-function-pointers with LLVM
         * fix: warning -Wcast-function-type-strict with LLVM
         * Fix: ring buffer: zeroed UUID in populated empty packet headers

2026-08-17 LTTng modules 2.14.7
         * Document last supported kernel version for stable-2.14 branch
         * fix: backport: hrtimer: Reduce trace noise in hrtimer_start() (Ubuntu-6.8.0-136)
         * fix: warning -Wordered-compare-function-pointers with LLVM
         * fix: warning -Wcast-function-type-strict with LLVM
         * Fix: ring buffer: zeroed UUID in populated empty packet headers

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

