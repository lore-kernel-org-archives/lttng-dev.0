Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30847CD5BB0
	for <lttng-dev@archiver.kernel.org>; Fri, 22 May 2026 19:09:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gMZZS1qQmz1PQn
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1779476946;
	b=i+9UAsKja7Nf4i5JWvFA0HjYhjMNO9VCPW6FjuyVRGn7HlHP4mygKgcDcODusBYp0fDJ
	 GvSw1LIjq/p882Ok7g+mkgEwLVfNm8UByvu19lh4R30GSvd8wiAyGToh/1EyEMQTFaoSS
	 xlXjk6ncTzAOdGiG2fZOvZ+2nhA4f3tzSWz7DbxzdG3ypE8hq7OF2NE3CPaGqnWZ/EQWB
	 2Si637N5t1P9wxE/ucG7DalqRnpDCkhB2TPfl2LjHKkQiUcXEDdXUxnhPPweVkn41Gm8e
	 SwnSF3hIxJFckrBQS6H5fnSYWCsGXJFHZiZqudahv8IJzKWe/FlN+XRFieYtr1SrKPA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1779476946;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=z7QAbyZmkJBPwuNszqv6AL1SVmO4fa83H6V+LpNYLAI=;
	b=Yy7vO9MMbhGVD/ftFGFDGo6FShepuqP7KY/tfleauW8KeVIvuaROYH2aT30ga5Bq6iOK
	 idQ6WEHnmgibk1eDbsZUk25VbnBA0LFwQCBGgHA4roxoSvWQNu7KiMjxUxA7LUi1LdoyR
	 M4hcqgBiyy953N8fkHfcwVKXDvPvwgnoCN1FD0naly2Y/AH5glreq2bR/5spqa7xZk6bc
	 fMG4YFVhVJ5u5KmUbIj2KF/sgp1ddmj39Tx5xKkrN2YBV97zI0iu8bqotoB/eBE0V9A3H
	 5AwkwwFR07NNOHCI1ALdnG+wW0raoaS3hP8YR4c+NUV4X0V62zuK+9CfPcDpIOo1uGg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gMZZS1qQmz1PQn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1779476946;
	bh=HR0aYUObw92zvivQtsu+RnPTLc/uKNnLxj7DAHsKYcg=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=X+QX46vWUOwbSu8JXGcWTOiTr2b0lOteotYxMQYmCWJ6NR6JqaSHfaeprBF0NyyPS
	 2av3wdpRNjJhQrZTttp62pxGoAkU5mttiw3aAVh8nytviB9ntr2iZcrOKKNH0ZM5CG
	 Lz8Ct59nQ29V13Y26JkRnqXHwxGCGLaAnhn+3/09t4lwY1mbxgvSVIqdkWlkhf2ODT
	 W/fnXtviiDaDhV6e3PceumiKt+SCbDyRXQ/cb9p+CJqMLJIiR5yGHddWcHJvZQv4a1
	 Eao12KNgJ5s5XKE6egvD3/cH9MATqAFemLkA1yUNTTiAZmnAeJzqyL6dyiCAsjyKtQ
	 XHuRPDanZP4NA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gMZZS1qQmz1PQn;
	Fri, 22 May 2026 15:09:04 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gMZZQ0F4Gz1MtH
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gMZZQ0F4Gz1MtH
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11021083.outbound.protection.outlook.com
 [40.107.192.83])
 by lists.lttng.org (Postfix) with ESMTPS id 4gMZZQ0F4Gz1MtH
 for <lttng-dev@lists.lttng.org>; Fri, 22 May 2026 15:09:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ytu38NPxYEP2GKmDiBmeVNgZDZoW38kllJi52nzM3HVje1lz+me4GXhs7kow0g2u6C/Gam+aPnAsjMYOAVlKgsPfbZJ5bTeYHyVuMTDH9uZ3EjERu2ftXbnbdahC79DTfD+CO+jOi8vWQp0Ocvwc03FF+7XZGBnL+YskeTkgbA/jeNLwPaASbQZwxQdj+7ZQLd584wY461mGkJCE7ARPVuH96XazdFAL8mV6PEG4K1TFj25cwq7s2/F6JpxpteDuuunuhSC6MIL4/7gAXD7N8zecG8BU6/o/IHyAyJc0ggmoyBRgOyv5KX815fPTiP4IZksNXwLUpe9rfMD5WrJ3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HR0aYUObw92zvivQtsu+RnPTLc/uKNnLxj7DAHsKYcg=;
 b=CNIaxxk8+Ea8mNt/MiPqfsIaLvxkiHoM/fk55QToBkYqnYO5GOHGJbnAsieQhoSPO2XaJTTf/i1Z174gO6uR8ZveoezB/0wzIpQXRQeGV6ImLEn2WdIQtSKYVx1L6FEnwHnAbtdsk3IccLCp97wDUWIqjPcPnvYuqdYQOIlorwsC/bnmN4Y9RFw3MhxTe6r3xj62kz33wUmLvbZF2C5iXw8awo78/w73fjVV65uOQg/A95CaPXyKaIFI7inb3OF3MAbKWzv9lMguM/dzddPp06AC57xLPfpVKasGbjNKNYsC9UNWC/x4axhOMc0Ib/BtBl7BJMqcd6f98yIw5u1Ijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB11898.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:16a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.9; Fri, 22 May 2026
 19:08:57 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.21.0071.007; Fri, 22 May 2026
 19:08:56 +0000
Message-ID: <e5fe9c15-f9b0-4d00-8fa7-3562759b4ca6@efficios.com>
Date: Fri, 22 May 2026 15:08:55 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RELEASE] LTTng-UST 2.14.2 and 2.15.1 (Linux user-space tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB11898:EE_
X-MS-Office365-Filtering-Correlation-Id: effe22b2-ec22-4ad3-de6c-08deb8359290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|6133799003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: VpZRUhR2tkyR9I+tLMpBSB/pWqGmHHWBPZqkm1+hcz6m3U7/9IPHIEg6wzvLYA2bDOCdBeOzjOcV2FQe+o2Gcn47rGx3fa0ZOYu/cdaDu7dJ4mgbbPQrpj+8BBdQFH7e4ssmZLcqsmwVszuLADEztxe/xUVOxFySPu4ZhYCcAbfkQTnk1dZp5Gv0pEyVdkWjmAvOerxQprJ6m/4fvgjSB49M5kt7VOc8UZQF8CZAYXGrCBaR4o1wlu672wX/dxpgeR17jbe6OH8EgAScRC2lxLqshbaoBuM14Ve5Dxv7SILioCfeTkeutoDAi9cN/yrBjEC4htOeY/iELyt08xtFycvZUXG3xj70+v/54Ovy16kvjTOogkJdKnPgpZ81W1TDaHIwYAdtphmK7zxP4dSBvNhqRuKUycf8UJxYdlGTwNY2IXglu/++lJtPrwr6rcuuT7sB8GFUd4vH4IgHaPaHne63otWhnQ2+NrifOFdiZ7w0g2B12zR4itCZ/JnW4A76ONMym84NbwN2lKXzx4SBTSfDAX2CaCZjGJEyhx0/zVi4Mq8jeTkMoLWbK2CEAQM/bUTCa06T+RKclmCd7CYas4H7oPDrRpAe5pj+89YrK3xqShZJv50ICP8HTkCzKKPsdx0riWOYtIdTEKE8uTjqNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(6133799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0hHb1Fralh4a0kyR2hGNXpFbHh1bUMyRkdab2hZdVYyZ2pLNUVWQnJhRmdX?=
 =?utf-8?B?SmpadUUxQmhlYVZhNTZHclFwWVE2YXpBSkhUMHVIclUvSDdQU3hiL09jYXJ5?=
 =?utf-8?B?TUExUDdvVFdqTG5DdW10cVFha0M4RWhGRCtTbVZHQzV6aHNCNUdsckRTVkFa?=
 =?utf-8?B?M3FDdWk0L0ZJQUdGeVJIWmtLMWtNaWp3MUZXd294N0N6bkR0bkhmcjlXQmh2?=
 =?utf-8?B?YTJ0OGJPSnNHSVBIQTc1bmQ5bzY1NjRYQ2J0NUZiQTJrZE5yTFVNMkR2VUxa?=
 =?utf-8?B?VmhsUElROWp6WVJxNDU5dlY5ZVRkdUhXZUlVRWRZSVR0c0dOMXNuSllheml0?=
 =?utf-8?B?UVpUZlRYZjltckIwNkVtaGkrUUZEVWpLK1draWYrdnFkRnRKOWRkRjZIUHZV?=
 =?utf-8?B?cHJOUmx4RWc4aDg0blYvSzRiOGF0OGVqSjdCYStzYXdBUk9WWWNTSm80VXli?=
 =?utf-8?B?azBpYXhjTkxqMnBtV2plUGp6YmtuOVQ4eWJNczJ4dWFTRmhDcGJidzF3M0JP?=
 =?utf-8?B?bk5objVpWm9oU0JwMmQ5bEpWcHlCQTJ1RG04dCtTR0ZldURyWUUwaGhpU3VJ?=
 =?utf-8?B?YmNYZlN2WTB6Sy9SZ2x0c0VHdGdpMU1vb1NySkwzdFVNbUF0Tndjb2hhUllK?=
 =?utf-8?B?L2Fyd2xWQnQxdjVVK1J3M216MmdTWTJLTURsQUFHV2ljNkloaTFRM3A5cVow?=
 =?utf-8?B?Y2t0aURxQTh0eVpSaFRsWVpPaU5EeTBTd3F0Q2NiSFJDQ3MycWQ5OHVuUmVm?=
 =?utf-8?B?MVBFdDVTRmlkRVhya05jSTRvMmdZK2FCVXRKLzR3TW9kcDNpOFgwNWdER1dG?=
 =?utf-8?B?bGNGcDAvZmY0NGx3QnNWR3h5VTViSGRFVnBEZllHRjRqYUp0UXh0Y3IrR3BZ?=
 =?utf-8?B?cXF3YkxPMUk3VnI3aEN6c3ZTWHdBNEpEek9LZ2VJbmR6ejEyM0JsdjlIbUJ5?=
 =?utf-8?B?bHoyV1lFdDdjaGcvMTNhbndPMWtXUDVhWXNBdFRkUUVqUGJqcUpjZjlSWktJ?=
 =?utf-8?B?WnpBRUxKL01IOTNCSXBBZEhGZ1VmTW1iaHMveWN1OWhaZEF1dHNWU3I5UU1p?=
 =?utf-8?B?R1JNeCthTzlhcnBOZWpYY3lQQ1RMNWxNbmFudTJ6YVRINENnSlZvRW4wZGtB?=
 =?utf-8?B?Uk9taTg1MHlYZDNyWklTQ0NYYk1USzEzNFltQ3QrbUd6Y3Z5d2h6UkZNSUh5?=
 =?utf-8?B?SVErMkppQmFBeUVyVlhkUjRZTHNTbnVtZGZZckJtejkxbmd6YlhLOTh0bWRz?=
 =?utf-8?B?dFZkMm9kaXRBTGlEcTd3cThqU0tuODlhU3B4K3hJUWJ0UFJrY2YwVTdiMWc3?=
 =?utf-8?B?UkVkOGRYdlBadEkyRFl6VDVMUnBEelkvMFFmSzk4VkgvMVhjQkl4SjdwSEFj?=
 =?utf-8?B?dWhxT0ZYNU1yaEhJY2pDVjBubnJJdzF5L3g5K2JUUGdFbHB1WmZibG9ZeUMw?=
 =?utf-8?B?ZjdQbTNCZU1UNHNxR3pSbitrN2hsSEg4Y2ZUd2tJbi9UMzJ0ZURZamIzcjhr?=
 =?utf-8?B?SHRHdURhQ1pVdmEybTVoVnkzNjlGbnpUbi9HVllLNGRBOWp5ZFArTDdhTmFD?=
 =?utf-8?B?QVYwbWc0eEVRZC90QUVCRnJ4T0FScWFleUhDYWs1bU94c1lJMjFwVkVEQ3Rr?=
 =?utf-8?B?OVhrTytwenBoVnNyVjVqMXpZWU1Ub0NKS2ZiQmZHU0FSN0NTZ0lhNUErcDZ4?=
 =?utf-8?B?YWNTOUZvV1F4MkNDbEhkM0NUSEVLbnlPdnpYTnEwN0tPTE5obFJTMWliRjBG?=
 =?utf-8?B?SThNM21xbmVWRVRRWWQzK2xwc3JwcHM0Rm4rWDlaQ0Q2VWtobmtkSzVUR2Ra?=
 =?utf-8?B?QkRDT2hZSXU0eEM3NG01cEkxbkhPczFVVDFLRzZFdkZFOEowODBuRVN1ci9O?=
 =?utf-8?B?Rys1RjVJck0rUUhsR0c2MTZZMmUzamViZVZTU0RmZVJsTFEyRHJOYjFHbTRL?=
 =?utf-8?B?eWVUL0hDYUpJZTIwbTc4MllPcXg0YVlydU1LeEM4QnRZc21CSTcyNGxUT0JO?=
 =?utf-8?B?elR0c2JJYzh6WnE3ZFJwTzMwajdRSk54ZW1ZbnNoNmQvT0djMVlkYWtIVFph?=
 =?utf-8?B?UXk1Z2pJc0pYbm4yUk5NTnRMRkZ1cGZpTFJVVG5PcmZDNHQzekNiOStWSHpV?=
 =?utf-8?B?aDZHZUlKUWZzc2JxOTcwd1pmL2xTcmgrZldFQ2ltcGk2NzdvSzFxYXlJZFFq?=
 =?utf-8?B?RlI2QnJkblJrajFpbHdieEowVEltRGluTmNyaFJ2Q1Nldkt0Mk1wSXBmM2VF?=
 =?utf-8?B?WW9tQmpkajJ4N20xbmhVZFVyUmE4YmFkcXNNM3JINm9DNThaVzlSejc2SWNi?=
 =?utf-8?B?Y0d3RUsrYlFuaThYdko1bHpMVGxWYnFSZHgrL0t0NmxEK3lSbkRVK0F5azdv?=
 =?utf-8?Q?eF4GDjTZhN2bCAUg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effe22b2-ec22-4ad3-de6c-08deb8359290
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 19:08:56.6965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBeLE5aZTtj28Y4eV6uY+8RINMMjjSFbwLfKm3gF6mM0YVurlnjML0fmf+77ZPDXbK+bQYI2xP+sGauetsmDEjU7Ivr4D/pBmPPR6RSF/hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB11898
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

This is a stable release announcement for the LTTng-UST tracer.

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer,
is a low-overhead application tracer. The library "liblttng-ust" enables
tracing of applications and libraries.

Those releases contain a few bug fixes, the most important being a fix for
missing "per-channel" buffers field header initialization, causing per-channel
traces to be sometimes only partially readable.

* Detailed change logs:

2026-05-22 lttng-ust 2.15.1
         * fix: return negative error code on incorrect message size
         * fix: check shmp() return value before dereference
         * frontend: Change likely to unlikely
         * fix: use decrementing counter in zero_file to avoid underflow warning
         * fix: initialize LTTNG_UST_LFILE struct in ust_safe_vsnprintf
         * fix: initialize sigevent struct before timer_create
         * fix: close_range inefficiency with hash table fd-tracker
         * fix: excessive memory usage of fd-tracker
         * fix: check for NULL before dereference in ustctl
         * Fix: stream instance id mismatch for populated packets in per-channel ringbuffers
         * doc/examples: add upper bound to minimal CMake version
         * fix: warning with gcc 15 attribute nonstring

2026-05-22 lttng-ust 2.14.2
         * Fix: stream instance id mismatch for populated packets in per-channel ringbuffers
         * fix: check shmp() return value before dereference
         * fix: return negative error code on incorrect message size
         * fix: use decrementing counter in zero_file to avoid underflow warning
         * fix: initialize LTTNG_UST_LFILE struct in ust_safe_vsnprintf
         * fix: initialize sigevent struct before timer_create
         * fix: close_range inefficiency with hash table fd-tracker
         * fix: excessive memory usage of fd-tracker
         * doc/examples: add upper bound to minimal CMake version
         * fix: warning with gcc 15 attribute nonstring

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

Enjoy!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

