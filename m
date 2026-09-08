Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666FCC79F99
	for <lttng-dev@archiver.kernel.org>; Tue,  8 Sep 2026 19:50:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hfZLG4YnHz27NL
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1788897048;
	b=npBlHdg2S+jybK+07G6KV2keus9VXgf/cEPrsU70jG/bwtIIVKFSZg6t+XDdLC5Dnjop
	 pby8yzTfXQpjoltd03WreNpi4WDWJYVzRLqBAvhlH7v1iHUi7t+AnHpGUJAVdGCaZqt8f
	 5MrK3uR+tKltLnVqOskf9Qk/HQIh0iDY6o8pXFYQNovQ6MLeeeNVu0h2BZ/boeBnSmwSR
	 IsTJbbfE8un5fowHpEb1jKz42otAppM2IDpgvtBDXk8+OpoQCDDYR6r2NTfMlLrc5ys+C
	 Wt0Fg8iBjppkef/xMHVqi3/rrwYN129SqBHYnoedgiRL43qCvNvDZ1adIO0mHdJLkjg==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1788897048;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=iB1Kq8LREO/U2veu/CXraqbYgzOEiQtuhp3QHpnD6Rw=;
	b=Ip4xmwzzByiRTV2/y//IRqRKPNOuhVivRglzt5ibj3Tv1mnOlPl7mogFx3XPO/sJHWDu
	 /RDt00b1+Ach35swAf8ndeoTSSKzPkJf8lZhO2cu1NpDLEBwhW5nVVknok3M22G7m4Kzo
	 QxGVFtvOTjYHcoUxcFecApPUN1sYS0oaLw09X4Yiu1AvF19l3/V9IjM5RZHDlq6k08EXL
	 ODS22g+ZHVZgqzvI5c+BuypQaCLOXttYwJsQKSi8QOQt68VCdQTbQO+/bUCUlaE5Wi6cp
	 cihYEY4RuWkH6kTL4VcLFWAteoP5iO0nsc6QGBX8+FUOG7AFOiuIRieYeydYaiNuB/A==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hfZLG4YnHz27NL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1788897048;
	bh=75OHHzLsy3Qf1LCsyF1owUOAt/hW4CHpr64kITO3fu4=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=tdQ4KtFCkVl51P3Aace5I0Od77uAMOE86yXe3/LRYBspHiId14JU5BxBSLLWG8/62
	 O3MeN5TsD0QQa5/+Mu9+QFoR/wL6bgJoRPyW5OoCni7siNztNYUB6zzraS2m678Uzo
	 ONkT5pRysvod1e8V6EBtcyr1pRdJbSuIt39WqxYLwG6ctkFJP4zA5UhYwGNwi9pm5A
	 3YfPbClkH7qENf1OZhyF6k1sx1LKN6dLn5MXpCHdhzAtUVsukzJQNyZMNiQqcz5Ht/
	 7K/jtPTvY6W7wsvKwmt63fXH4G0UpA16fUQPKDov87vaam3dmlLgF+dpwO8Ae5pB8H
	 u3X4DNLkQyUMg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4hfZLG4YnHz27NL;
	Tue,  8 Sep 2026 15:50:46 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hfZLD0nGbz27F7
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hfZLD0nGbz27F7
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11021122.outbound.protection.outlook.com
 [40.107.192.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4hfZLD0nGbz27F7
 for <lttng-dev@lists.lttng.org>; Tue,  8 Sep 2026 15:50:43 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkZq3zxOVttvuJ5XzxFNrVDzMuNhQ0nntaKpBGcsQPFLDerjucZxu8T+v+G/XxVrSZEkspsDKtucAtjj03g5BLWSZ7etBtJzhK7ASgIzeVr2ufL8ArrbwxaqHKo1vqeSbmHAFcRJuvzCfm/9KrKRyG7fjh06LYsgg10Wcje4BnK2NPrf+XrGQZGFnHxMzuR3FcB+Q2oxlEYXeHgk+6Q3OOSbPa5oCf2q2LuPaULvX+DLdCmflz/HbEtpNeQss2fQ3Sc59XQWNzM+apoKMe8WAKDGqXF68C7pJJGhv2lZ8oFAV2I1563sxqE86qj28jXMfS9AEwwTkOMv1hLVqyE99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75OHHzLsy3Qf1LCsyF1owUOAt/hW4CHpr64kITO3fu4=;
 b=mEAFMHcpzkc3RgpxQMfwx8kCnl+jjq0Uwtppo2Ohj4WHIa+/RnMlndIB/lmdXLHsJND4M5rgcc/KhGE7PLALSMnIv7RM8WnNOab42RPYpdej2+WT0UQoQxgRFf6VPAhxSoNS2FvYQnIv7z+kmDsy9sDxE+Bwx+dfyVea4kTls4a5d8oMvbc8VfedSF/J/Jqezk1f0uC7eBJeN67d+T09Sen8pwaltEVIt3AHFEEBmEdvwQu9+9X/xJkwqMzOodARb0P9nlveDOOaPi+RoFb2tYgAdwnOUOkwkxdvs77aUtrQfDicvUNxH3uWGY52IrlBVEJD5fcvJiuST5uyt/yvHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB11904.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:ae::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 19:50:34 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 19:50:34 +0000
Message-ID: <9e5ca6e9-1b5e-40c7-b38a-1a47ac3d9198@efficios.com>
Date: Tue, 8 Sep 2026 15:50:32 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-UST 2.14.3 (EOL) and 2.15.2 (Linux user-space tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::23) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB11904:EE_
X-MS-Office365-Filtering-Correlation-Id: 50231c34-5331-45ff-ac05-08df0de2723b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: oY3bYwrUpg5OQVMNOJAuBKtV84EV8Wde4z4nzlWktWL0934pux1RF/5asFtl5kf8576LG9Q23/lwVFV7iL50cd00dUQCRaZU7H5ME+Kj8QLZc+3/HAYakQ2Kr83Cx+h01nxq7S10OmNmy0PMt4xuJCS+2yWbgfl5q+Kj8iBOhIMh+yNwGe8/5fczDb53xgOAo+V8HFBrFZuCodAQGy5xVJvcfQY7GetGVZRfAd1+BoQQiz1I0jzVEnfDGniHcqeTjqSq5BMHTzMgkDz2REtY6Ihyokgq0yQms6rG9ykhb182b6kkYqCPy3QmDtq+yLlIJ2I3udBt6DLhhjk63CfvwVsYoVzhJ1lw3QpPSartljoWgcNlZxyfzGDYMZUq9Wc5k9L7vEnx6K9AI1dMEViTXNsllWGipzvNB0/wlWm62qeoxl0ymxKiW2Mp/3MUW5hRcfsMAI5vB6vMBnl2BWCJCbHRS3sbmFy00ZgKlgcbekUAxxJy52fR4FUoXjbKLCtY54F9m6/0rwZiVh5ZvInNPU2QuO3nrdUs0Y7TcjfBBQDfxqFf9SmuLHOgLfqnkWF+jQ/i42JwVD/aSgjdLmD8gRJAjmlcdt3m5P+ERVLV1d0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVhXT3NSZUpDRHJPbTZqTFFEeTgwSE96V0Q5bktsSTBQQ01TeUw2c1JLMkdH?=
 =?utf-8?B?cDR1TTJXSzRLV1VuZm5ESk9CV1MxQUNyLzd4am5ZemFKVEYrQUhHS0F6QmhX?=
 =?utf-8?B?S3NpN0tUZFNZTFBPSzZpVFM0b0NIVUtxSXJONWhoT1Z6dGlNc2t6RllQUGJS?=
 =?utf-8?B?a21hako4d1FUWXZWK2RLZGIzWXJWc3EwVW1BQktGOUJodDVPTERRN3FlTUNo?=
 =?utf-8?B?cUpWT3lMdkthWHNWZFNZS04yZ2pwcHY1ZElaR2hZYTF1SUFVVnJpK0xXaTFV?=
 =?utf-8?B?WDQ0a09UYWdaaU5BdEdqRlZRSWlVYlAzQVhJamcrQ21BM1lmTFhKTTE4d0I1?=
 =?utf-8?B?ZWFrL0lSYlpIMTNXN0xQdzRMYkZncG5icU5QWWdyNFg5R1lkNGswMkZnc3U3?=
 =?utf-8?B?ZWowMVlZN0pYTHNwNy9lQTc2cldidDY5emRFVVVVL2hEd3FXRmlEaW9iNWZu?=
 =?utf-8?B?dHBiS012Ym5vNHZ1bTgybjRmdzQ1ZmxsZGVMcWxJc3VrZ1RGemxXVGsrcWtl?=
 =?utf-8?B?WE9yZzBoMkd1dHkrREVFdXlKSk5TNWVoSDdkcGNvdHRKTjlHcFRFekF4VDRj?=
 =?utf-8?B?Vlo2dG5CNVQ5TE1GK2FZY1UrRGFzODJGWXNERW1JYnFLeU9uSFJqMmFxMVY2?=
 =?utf-8?B?MXBld3hPOGJFUFEzNDV3QmZDK2FYMDV2bHhDd0ozU24zeEhMa3FudVFGUHM3?=
 =?utf-8?B?akhDME9qSWZVZTFOeGJRWjMwaU9ITjFvSXVObXZsS3FQdTFJM0JKVnAwL0hY?=
 =?utf-8?B?SXdnTDJMc01DTnVHRmQrT3Y2bHBxMHJtY3Y2MlNwUVM5L2djbnNvcGJsM2kr?=
 =?utf-8?B?RzFRU0V2ZVhtaE93bFVGWkFaWVRGUGRSRjMwUnh4NXhKNWVpYXd5ZVhjSDE0?=
 =?utf-8?B?Q05nbmcwRXRXZDMwWFFDN2sxYjUwTWk0VFdMNDN4RmVRWnZMdzZIay82bUYr?=
 =?utf-8?B?VE0zZlRhZVhqUEF1eXNzUWUxSzB6SEFtcEZYVWRFSlVOWk4rK2t5VzkycE5i?=
 =?utf-8?B?cytYSGN3QWtWcng3bElTTVRoWEJBME1HWjhWRG1HcVlmaEVyWnJ0bVY0dnpL?=
 =?utf-8?B?eHBvYVZTc1ZXbE5oa0tzR3RtbEdBL2JhSzIvMkxSRVQxVEpmTlMxdGk1bG5O?=
 =?utf-8?B?UVNMRUJlek42eDNyaEVrSys5SUoxN0JEZE1mU1J2RlRuU3dSQmQrNTZQRjN1?=
 =?utf-8?B?djNtc2JJa3FTSkoyNzBhVmt6MldVVEFuUXREclNIZ0VTOVhHMWd1aWEyUGZJ?=
 =?utf-8?B?OVVCRXBERGxRTjhCMm9zRHh2T0hIeDdHamFDMC96bEVhWGwwWHIvNW14SVpI?=
 =?utf-8?B?RTJQckZRVTd3UjZocUtxcXRYRXpGbnc0SHd4T1hTNndLckFXS1hYTGFXNytH?=
 =?utf-8?B?U2ZxWjJmTWVyenRGcWhsVnJUcFRxSGdrSkZzZWtLS1BXTHJaRTlVcjlMNzE0?=
 =?utf-8?B?NWhxM2ZFRXBKZnNralhlbnpxTWRRT3d0akp0Y2xmRzBFVjhya3orSjdLZlVZ?=
 =?utf-8?B?VWxlSmM5TGdsVTRDMVY4TFpGVll4SVNLZjB1amFJa21HNFQrNkg1Qm5VZ1Rt?=
 =?utf-8?B?Vy80YnM1eXBQVVdPdjBodTJmRmRDckRkTTFJY0xMT3pNakQ1clFTR1kycm84?=
 =?utf-8?B?cXV6UFJyUkpSMUF6Ulk4eGNJbHI4ZGZWaXk3M3JHM2c3aEN6dksxQXhMeVgy?=
 =?utf-8?B?TXBpWWNYWVNTNEtLdFBNaXA1UFB3cUo5K3dWQ0ppRlRWMzZnOHBlbEl5TE41?=
 =?utf-8?B?VE9FdGNoRG44ZzN0Y3Fja1E2ZnhPZ0JvKzBiNEFxd2Z6UnI5eFpZbUJ4YTJX?=
 =?utf-8?B?ZmNyRHlEYUhUd1lIa2VGbWhlK21XU0hVNkUxZDBQTDd0QTRaTm5aYlNmWGhE?=
 =?utf-8?B?azgzZGJKRVQ2QnBEUzlQT1NBZHJJNk1adzJ4cnEvbmNwYVAzS0s1ZjZNemt1?=
 =?utf-8?B?R2JYMUx3aUtwU3lNQ0dRZmNHMUpQLzlsT0trNHdrSTV5enBkMDV2YXNqajJx?=
 =?utf-8?B?OWpobVhpTXFaa1RwR0w3L2VtL000WFU0K0pxc0V2Mks2R2IrUFZ1aG42aWNv?=
 =?utf-8?B?NXlFNUFWeVM0NW0xdjR2VHpIMjhRTzYzOTZOVW1MSFE5TFVXT3J1b3U0Z3VR?=
 =?utf-8?B?S0l5S0tuZFQ3RWd6T3M0eWFBRHlFcWdpWUtHd3RwTDNHMjUya2dkdlAvRG5L?=
 =?utf-8?B?YUUzODI1SVJzdTdkQmYxRHhsa0U5K3BoSm50bi94UWt0UDYreVYwQ1R0Tlhq?=
 =?utf-8?B?UEhFdlJGdUVIOGNsY1V4cUZpTFVxZDl5bHVZTlBYdUN5QStXVkgzOHRnZ0lW?=
 =?utf-8?B?aDNEZ25qVENRUytuTEhUUlZaTkhseCtPQVQwTHRCZVRDMHEwWk1UWEcrSjFM?=
 =?utf-8?Q?owfR4vy22qUAeqIc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50231c34-5331-45ff-ac05-08df0de2723b
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:50:34.1375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUkhyF9mxkVMqZsN1HGM//8Xx30YMqFaE6Lgc1xsg9mCSBOaSY9MhLXTUNihVNMeojlhJ0io1t4n9lw7dYWestkAAWuz+J7jtOpqK+xRldM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB11904
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

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer,
is a low-overhead application tracer. The library "liblttng-ust" enables
tracing of applications and libraries.

The most relevant bug fix can be found in the 2.15.2 release. It adds
bounded retry loops for per-channel buffers, thus fixing a regression
affecting the supported event throughput. This regression was introduced
by the robust ring buffers in LTTng-UST 2.15 and affected specifically
the per-channel buffers.

Note that version 2.14.3 of LTTng-UST is the last version of that stable
branch. With this release, the 2.14 branch of LTTng-UST has now reached
its cycle "End of Life".

Please upgrade to 2.15.x or 2.16.x if you wish to benefit from new
features and future bug fixes.

* New in these releases:

2026-09-08 lttng-ust 2.15.2
         * tests: Disable coredumps for expected ABI failures
         * Fix: lttng_ust_build_bug_on undefined behavior in C++ builds
         * Fix: ringbuffer: retry on wrap-around contention for per-channel buffers
         * Fix: Introduce concurrent subbuffer-ownership retry loop
         * lttng-ust(3): document lttng_ust_field_unused()
         * lttng-ust(3): document LTTNG_UST_TRACEPOINT_MODEL_EMF_URI()

2026-09-08 lttng-ust 2.14.3
         * tests: Disable coredumps for expected ABI failures
         * Fix: lttng_ust_build_bug_on undefined behavior in C++ builds
         * lttng-ust(3): document lttng_ust_field_unused()
         * lttng-ust(3): document LTTNG_UST_TRACEPOINT_MODEL_EMF_URI()

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

Enjoy!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

