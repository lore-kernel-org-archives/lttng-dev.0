Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70A8C79FB6
	for <lttng-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:27:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hg1p23F2zz2J0k
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1788960475;
	b=ita1Ad7bpCsbLkpmbIdNDurR7nFjiAf6jw/UWLOmcK6o1CzFGpu+bfNDElICs+zwRAGt
	 /5tAZxCOOzAsY1o4MuLiMMRNN1qbZZuWgKiJDnt0BVMF74YzIKT2tjfJKo9qaAYjN/w6G
	 9QiPGSkuFpGCz8Tm4y5ri0YYp4wXvqOEsJ1/kbPPZ3aMV+f8QB5l4pSekz6bwcT5dCpcn
	 PbEn2X10OdNs1g1IW9/2m7Tc3IoctiaeeQx5z9wdLQrDuLN7TzBNmehAyWL6eESnhTbYT
	 9nDAds5zL30TTaiYZqO9Qr1IzmcPwrR1Q0kvigsaqSD2GyMYOUJSIShbULLqRIItngg==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1788960475;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=WVYoOCpBGw2DVPawRaNm4P10xTBbE6yknL2kKdmQI5s=;
	b=M9SgCuvQPsVk7B/T6+VB1H8R57m5Ryk8Zg9c6V4FJxxH0WeAl5FjvCE8eiLlDAPBO4vQ
	 JZGo8PA71YTZqePw6MOns8YPa+Q1mxigt9FDg9Tb2IDbIbVuLA6A7Rb3QMH+9I8fVvPa9
	 dWapXx0lxV0h5czen/9xgS9WQeiVeJSsJ0pmgkBeKtu9ZZ1+y3OG1PDlQAEVPwxVvyLoR
	 Tr8Yh/qWhN7zQ6bTQJcwPOc3D9avhqod0BZzVkBegejwG2fmyG2toQEafiemvuawCmmNI
	 Har9efW2g5zeSlJBFO1UNZCDt8oHInFS+H64wTPebtwJV0CzV/92NuGiGZZ4hE92q6w==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hg1p23F2zz2J0k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1788960475;
	bh=MgM1GREGXORVuRu6Tlk660Xx/Q8v9gOhyfKVIvE6uqs=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ptIKs8uNk1k1HvZ9l+IBn0iXPfeF+JN0/d3ny67WYsm+iI9sEzfP7ys4PPqIW+7eV
	 Yjrmn6Ax3FmCMlhOgbS6iZ6N30UHPL946vFOvaRRq3uWslqWbXQgt4l8b+r+W5Wqyi
	 P21gn57fELfmJqmJiaQj5t5IAIibO1CwnGdEb11ggiKL2+aAcn1IcLqjYp+3+Y5qFJ
	 FHKSzhJVgh13HWO2X9q3OJpDDEsWqwvgPgZzs5A/DDxdtb30L5JGgJdAQMQgvbI8iC
	 VbIp0MMK3NiX8E7S43qFn5k+pgdmCuYfCUsxWrtMozRmYBHCITJW8ffMub3ShJqrvT
	 klzg10cyOS2zg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4hg1p23F2zz2J0k;
	Wed,  9 Sep 2026 09:27:54 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hg1p12vHCz2HZw
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hg1p12vHCz2HZw
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11021128.outbound.protection.outlook.com
 [40.107.192.128])
 by lists.lttng.org (Postfix) with ESMTPS id 4hg1p12vHCz2HZw
 for <lttng-dev@lists.lttng.org>; Wed,  9 Sep 2026 09:27:52 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Et1rn6FdJq//iaFI9SIcTmz86zp0wOfnQBpv8AzicckDPHqbo3/vT/WyA/AWfucqAiWtOfN4WYBI6giNXx4a5YYQh/yte0XGuzGVVN6mS2565GbEuBPykdQ+HIO0lYOhjQYkWePjYU+oddg6N6RoOUtTyZLUl+OSpa0T+7Jry7w9zjprS3U2jD49c691XMo+z5duwhDcUnDoFh5BPnkFD+fm9Xmqbo00ObFvw39So1Wp1JTYNVJlhn3vao7UiqXzVrFyiWa78THYAlhyJDPzvp+xsZCvPKTKATBrG80drdvrxZyMdVjBATRENAwFwOD83iuGTo3dg+QCdyQNO/pqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgM1GREGXORVuRu6Tlk660Xx/Q8v9gOhyfKVIvE6uqs=;
 b=xlXqmfkMYg/SMra0m1YKhVxnOrmgOu6OXzLsm2rW8Ky0c79rTsuBTT4wncqleSsPtk6dJ9MfLKrUjZ1rnxeBwnk1JT7XaX1/gqHHrcWjVvzHwKm5FTPbTQxcRziwi4Uqqx4TXoTrZwfyotFC262tF6Lszh2pYtrqUwQC55wtlS4OmQK5nPIaF0uATN5FKSQXN8JwIxiKINJTevYeRYeh+TmYD8wdsjiTDG+WU+Z0XOHyNbWubRYgq1ZNyd0C0LiEbmxuHGy2QdwBtoal2fV+PkvfwuYqHVBAiDYDJELf+/K7Le4SGnm1GlhSK6EhuyeIAxtKdTkUgUYQ3d13YzAIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:42::24)
 by YQBPR0101MB5503.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:41::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 13:27:45 +0000
Received: from YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4c7b:7dec:7e59:918e]) by YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4c7b:7dec:7e59:918e%5]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 13:27:45 +0000
Message-ID: <60f283db-c495-45f9-98f1-7655f9a17695@efficios.com>
Date: Wed, 9 Sep 2026 09:27:43 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: [RELEASE] LTTng-tools 2.14.2 - Orbitales
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::30) To YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:42::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB2357:EE_|YQBPR0101MB5503:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c35fad9-835b-4f1c-5f0f-08df0e7621df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|3023799007|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: OdAc0AGyREWe6Rq3gpOlH/qXGO86O5y90uMQMlgg8baxXzJubCI/povGrrd6RyxhhlQ3wNqEh1aHndaPZDDIenCGmt72WvnECrn0h6iloz3FT3cHwgnGFbRZ/qgiQdD41Hze+JAjVqMNliMjT8SOotBLC9l+y8gP7uwN996owdnpI5BSd94F2twU/AGQlGoU+LLHJMDHdIs7DbdPxazAue0fZ0Pg9phKrE0o+dSa0a9uFRfHODrknC74F945mamHQbNXW2ElOCoK3Tpq3YFJ+UeIHHIXlUp7ELhKwX0oyaaHp4ujSPSdobv/iSvL12DNpzhJUGB4aqQXZ3iGkDn+jiFOBS4/edLDrsvsGtvFg4Zmtu7oSY5zQM3H7D+RgDRogjai7GrmlLI79I1JVZz5lc/vQxfnTgduA/oQ+gNPpZRxMSz2elkwHYa2UUDl26ME0R8yN9GHKLAsFeYZAz4U7iElPFR27zt0jHj9byRWdFLFKJ2qd/JijPWGGwJZMfFlngV+OsPRFWn9veswh1AbUUV6fb6SJuyOiNZHPyLaOj5jIMPS5dapTI0SH7n/Jnf4M8WirsNwQhPQzudGsasSM/mXvn7Mdy/yCnWll5YSeYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(3023799007)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFUzYjduUE8yaVhZMldjOFNOWThTbDlGaFJJcG9NRFR3dE8yTFNTSit2ZDBi?=
 =?utf-8?B?b1Y0U1NFYjUvNFJMd0crN1ZuMm1keEs4bjhaeExNOWI0dTZuZFdlUGNNMnF4?=
 =?utf-8?B?aktmTkFWL1A1YWY0QVlwb3c3azNjY3A5ZzNHNUM4MWRXY3BHTG1Uc0lNTW5h?=
 =?utf-8?B?TDJNNCtLNXBKcWlpQmFwSUxuUExBSTN0bVhsT096cDVCZ0FyT3BJcFFaQmZV?=
 =?utf-8?B?MFNXd0VDUjA4S0pOVCt2and3NzJHVE9malJrck9pdHpQUitkZWkwTjNCT1Bu?=
 =?utf-8?B?elBSSzdoTmJodmp5dFZscUVTWG1DS3pWTEtnY3R4R3ArMGJTSEdQOVRPSEla?=
 =?utf-8?B?VkVjVVROejdSRzl2S1hBSXZGZzk4OTdHSHpNZlpjNTdXVDRVdTMzdStHNFpK?=
 =?utf-8?B?ME9hV2lDcXkydGxJdzRnUjA2Zm9zdGI5b1ErL1FNOXJLWk5vMEg2Y3I3M2xm?=
 =?utf-8?B?dlVjTVplai9lWDgyOXcrVmt6djV4RjBZWU0yeVlEK00yc3I2T0hvTjZGL1ZU?=
 =?utf-8?B?ZzNaSUh4QjNVMkZYSUdkeFl2bzFDR2hrMzhEVXBGN1pzZzUyNGtCQklVME1K?=
 =?utf-8?B?b0xBVUFVMnBza2JLM0l0alIyRmxHUVR5M2xYcFRMUTF3cUVINXl1Mm5xL3J6?=
 =?utf-8?B?Yks1S3JxTXJtZzdRd1FyT1J6WHN2RTJ5aG1oUG5IRGtVSGczbWtJemxwNGpD?=
 =?utf-8?B?VFVoeld2aWxzelVBT1dzaFdNUzZrTHBrZEtJWEs1L1VxeG0wUUxVZUJWRTdG?=
 =?utf-8?B?N24yVEhhZ05EVkFUMTFZVVB1RDR6TkN1QituMURvdXBxRFlsNUZVVG9BSjZ0?=
 =?utf-8?B?V1h4VkdYLzVyRUIzcXhrblltMWsvOWthU243NlU0Q1lWVW5OZzhwSENRdG5Y?=
 =?utf-8?B?OWY5VEU2Yi9HNjdhSGxiR1l2bEE1Y2VKU3JNWnNzYmVtblJEdlcvMFJKdXJi?=
 =?utf-8?B?RFdSTTN4NktKemRBeE52dFBRbCs2MW0rVWZXMjQ4QXhlLzFZSGJZZk50Q3RG?=
 =?utf-8?B?NHFPbldyR2htMzU4TzFTbkZnOGRLVHJhemlSSmcrWUFtRnlmRzNMLzU5cHFX?=
 =?utf-8?B?Mm9RVXFOWlNodENzWWhSa0JPSGp5YTUxcStUUDBnclNHVUVXa0JqWG1QQkQ3?=
 =?utf-8?B?d2FnTEZNSms1eGRBNjVMN2syRkhwaUF2cW9vbmE4RFdFZDNGQXNtRFlyNTRB?=
 =?utf-8?B?RTVpUWxUSExNQy9UTGFqS295OVJDcGpmdEw4OWlHZEl2L2IxdW5sRWdld0pt?=
 =?utf-8?B?SFVaU2drbE5xeDFKdkV2TE90a095anBVcDVjbXp2TVpkNnZES25oY1JwSWFX?=
 =?utf-8?B?cndtUkhGaWdld0NZelRlU1ZHMGJHam9MU3VXanlDQTVGRmkyTzN4aFNSMndF?=
 =?utf-8?B?Q1Z1OTY3WjJQVVR5UitMelAwS2NGVXZZUWQ3dzZiSGlsUUxYSjJVdFBSb3FW?=
 =?utf-8?B?eU8yYXVGbkZlanFzUGphdGtXV0k2ZDRuNVpxYVAvcWNoTnl2MGhvN2kwd21r?=
 =?utf-8?B?VkxaZHMxZ1ZHTE00QmZuNzh0a3ZFRUNITVRZY0xzTXR0WGVHNlhNeGRKeTY0?=
 =?utf-8?B?SlJ6aTFYY3JFbEZmTm5wU1FoTmRSSUhKRFlwTzhxZEhMQ29yd1hIYXhOSW5W?=
 =?utf-8?B?N3VUK21YSTNtT2doQVBBYnZHTzBKZ1k3RkpnTGNjZTdiK0g5SmlLU3k1dUR4?=
 =?utf-8?B?VHNvQlB0cTUxeld5ZW1Wa3hEc0tadU1WdlFyV1NtYmR3cmRkc1pEZ3BoaCto?=
 =?utf-8?B?ZS9MT1ljRERoSGh6Qm4vZDZmWEtUd0tIazd3cXRuSzFDbTBUYUt1MGk1bU1m?=
 =?utf-8?B?Z0tKYStRVUZoZEx0REV0cUY5NzlKNFNKSnVwM2RLNXJxaGRwRnhFeUR2d1I3?=
 =?utf-8?B?ZzY0YzJwQ1dQcXprZENKZktjZFFoR1pCK1dHY2ZWRG45ZTlnV0R5WnVuazFP?=
 =?utf-8?B?RU03d3FEeGdNclNpY2VaUHpkRVhXcWx5NzJGNFZZNURwWFY1RTQvNzRDY2Ni?=
 =?utf-8?B?NmMvY1NLQ2RPQ2lITUd2WlA2ckNiRUk1VWNWdVRpTENsTitPanFKVmlibXpO?=
 =?utf-8?B?OXRVbEQraStvajIwM3I1Zzc4c253VUFUc1NITDdVTzdnL2JvcTFtanlRYVV4?=
 =?utf-8?B?K0R0QTl5eU1hbEkvQTk5bDV2aXdFcWZtTitCY3BiOGU1V3l5OSttaHVXcG4w?=
 =?utf-8?B?WTNTSmNSWjNMbTl2MUxob0FiQytpRDkrSisyMW1zTDQzSXRKdjBsNElMR2c1?=
 =?utf-8?B?WVpkZW9mcHZRS1Q5MVlWNDdhV2g5WDQ2YmQ4TFBpNW1iT1JvT3dsbk4rOXNt?=
 =?utf-8?B?ZzFJR0VvYkVDUVhQbHppcHdKRHpVS29WNmtRVEhBTDZXNE5ySWpPQT09?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c35fad9-835b-4f1c-5f0f-08df0e7621df
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 13:27:45.2238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqGljuIGdC4zVUl0KNgW0Z4wWcvB8WSxDHUNPYtbqZjWMkuqwFF0ajDEK1OFdTqm9jkAocheXPyuJMfj4p2eWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5503
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

Hi all,

The newest bug-fix release of LTTng-tools 2.14 - Orbitales is now 
available.

2026-09-01 lttng-tools 2.14.3 (Ginger Cat Appreciation Day)

         * tests: Use version-appropriate GDB logging command
         * sessiond: Allow missing UST app channel when modifying events
         * tests: Add regression test for sessiond assert
         * tests: Backport `disable_recording_rule`
         * tests: Backport `possible_cpus_array_len`
         * tests: Backport consumerd pid fetching
         * tests: Add debug option to GDB scripts for automatic print 
statements
         * tests: Add option to limit the number of tests skipped for 
missing requirements
         * tests: Add helper to fetch logging formatter
         * tests: Add GDB helpers to lttngtest.utils
         * tests: Add `LTTNG_TEST_ABORT_ON_MISSING_PLATFORM_REQUIREMENTS`
         * Replace removed Python 2 C API macros for SWIG 4.5.0 
compatibility
         * Fix: ust-consumerd: oldest packet lost in snapshot of active 
channel
         * Fix: consumerd: crash when consuming a packet with no output
         * Fix: ust-consumerd: crash when flushing a stream that has no 
chunk
         * Fix: common: check load data type in filter globbing validation
         * Fix: common: bound filter IR nesting depth
         * Fix: sessiond: validate filter bytecode generation length
         * Fix: common: harden trigger-list header decoding against 
short payloads
         * Fix: common: validate action header length before dereferencing
         * Fix: common: daemon abort on invalid log-level-rule type
         * Fix: common: validate action list payload length
         * Fix: sessiond: sanitize agent event-listing reply
         * Fix: common: sanitize event exclusion count on deserialization
         * Fix: relayd: 32-bit overflow of packet total size
         * Fix: relayd: NULL file handle dereference in GET_PACKET
         * Fix: relayd: live viewer can reach unattached sessions
         * Fix: relayd: size overflow in the live viewer GET_PACKET command
         * Fix: relayd: reject zero tracefile count
         * Fix: relayd: incomplete session base path validation
         * Fix: relayd: stream channel name allows path traversal
         * Fix: relayd: stream path traversal via reversed strstr() check

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.14.3.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.14.3.tar.bz2.asc
