Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92834C79FB6
	for <lttng-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:30:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hg1rX61FKz2Hcr
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1788960604;
	b=i2yA3hrxvgXXc8j32ijwBeGF3UkTP/F8zJPksf6587fgeUW6AKnSdRuCb8GaeFA5/G/1
	 C/cil3Utp4D2W/swNzsLItwUkB9SGbgsR5fiLWYPhSCGSBcrIbGEysh6oI5axRhOdtvPG
	 pWo0U/MP6IDQnrAjZZypkBOq15Z5+mXfkNEaui/qd7mIG/fx5ibxMxwcVVr+1117T26YE
	 +/4j3UBAK+K6kwj2/zuk3Pz8CwSEzOY/p/M5f03JwRHOF26qxdImCMDufSLyACUKxJfLc
	 vugiqIwVjquhCsSEhzDT68nvxEqsraTeibJwmY8tyCvaMrIBE6riDXF5zp1QWvDtpew==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1788960604;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=aoXvxKb6t9sVGqNa95gPSy8A/64lkSl/1//f5dx4IrQ=;
	b=O0UeemEtOO/qAFufIgnUdcye8n/Lxgb5L4uiP2owRH0qnrJW00mJm4CKjS97iXKfPLWJ
	 ny1N+T27fbJlApqpry0XE6tXyFOzcVSa0HiBr60YvuvhHV4MyZsdeWHVNmKaDUjcwUpHn
	 4uR+ACK4m1tDm7yzMfEoLubin8hCoa4UcKWVfNerXPJ3egebrC7Q5MChcoLIf4VHQVw9i
	 iUJzLPQN1Gy+InSn+1JiVZPwQSSswzuGhPZd2LWj+mboQ3uPO/dXi/2ofF9p/HcSrjH0E
	 CGkfd8kff1Nt2Jascw4+z8Tp7CAlwhdxKwgze6JAVwzTjRuDjCGGnzCqTSTTQCnz7mg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hg1rX61FKz2Hcr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1788960604;
	bh=t9mQ9zPjj7Ee1hj5e+L85RBvKQ20D52uxh7UlhUIXX0=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=qiYMIWTsNClSi3L26b//N6ppPxYvwh23TU3bWsiZKb6V9ZQ6IJmgAr2K2ZC7FAS5G
	 uTR2LqYxREu9w9Q4SQEVoi+dz5KYnowHfLQtf+kiMh5YUvYR9TMnGh0I5pOU5Zx9K4
	 Eg012OTbeLfsNBTmGCe8hsDFNspQ9KaAwfUsnqVDPu8VE2rGIrcbWS8CHPJs+OlMVt
	 wQO9QeYifQzsL+3SJSJ3hNzB6aguzziknCy6LSXcMTEJCy394IN/Lyk4/h/poKsPU2
	 2o5UEZq9Auqnl3nX0Q/EgCpdE/Wpgqh/8qfm4u8tKOd80BIINiC8tg90Al+HZroEvu
	 LWG+XzRHvZJpQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4hg1rX61FKz2Hcr;
	Wed,  9 Sep 2026 09:30:04 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hg1rW0J0sz2HgY
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hg1rW0J0sz2HgY
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4hg1rW0J0sz2HgY
 for <lttng-dev@lists.lttng.org>; Wed,  9 Sep 2026 09:30:02 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGPxMFm6uMdqlbWd4ySRvxj9y6NQU7r4cQBdPYpC5sDvt3tQc801qPie3xOAn1Y2PBmiZQqe1xA2YhHsN7c39T0qMqgau1gCYN9uyK+7M8NQ6osK8zIVjFwXXTg2HkVWYtVVgMTOYUWBGKI+V9y/KILvyg5b5H1SbWddM6GQ2M2ebHIx2RmyZgAu6mL0KhGcN+7PE/uI0mfP9kR4S/y+qMfHRMtw/Ij2I3yd8KVX2T2Gb/iJMZAnMbhqRcQ2u6BfeI2Di5ZfuqiLQ3eRxwx06IxvypKaM8+LcXmjcaVLxa6YqAB5Pgrue2Ngzdp5g2+2KOs2/zMmUW4ehukPh0ahnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9mQ9zPjj7Ee1hj5e+L85RBvKQ20D52uxh7UlhUIXX0=;
 b=ngYxglNjnnEXMAH36lQuIh6y2JG87ptlLHm1csbc/0UjVZNMMeCEJ9J9p+I5uYD/VaPPMItODuOeYEtV70241Z/OHYhX+6pvVZS804jsLX0ZdqP5GM6FUwPd2d/RFH8U9ob3k80tJlcImBjRexRXxnzaSg6NY8QhcfwroNTB79BM8kdtyMgjmWJ22dV0DQs7nefJmETm9hLQv0KkJucV0lfnQtjvQTZF61NP2zli0Jz2EitHOtaadsUSZoHIMSAYFUdvVkJNxLq/6dVAa9ROH+JHcQtNE6ipFuR3hs9aTnf/fZhdtqqZg4jBw37C7RY67aWYH/aLoUs7zlSl3XRQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:42::24)
 by YT2PR01MB8454.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 13:29:31 +0000
Received: from YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4c7b:7dec:7e59:918e]) by YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4c7b:7dec:7e59:918e%5]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 13:29:30 +0000
Message-ID: <ecb20671-5c82-4d00-a6d5-45c8badce8a8@efficios.com>
Date: Wed, 9 Sep 2026 09:29:29 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: linux-trace-users@vger.kernel.org, diamon-discuss@lists.linuxfoundation.org
Subject: =?UTF-8?B?W1JFTEVBU0VdIExUVG5nLXRvb2xzIDIuMTUuMiAtIFDDqWNow6kgTW9y?=
 =?UTF-8?Q?tel?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::14) To YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:42::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB2357:EE_|YT2PR01MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: a9fdcb2f-f9d3-43a8-7cd0-08df0e7660f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|56012099006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: hPp9U13ntDrY2Um9zhUh2c3rRHVDspr+xN1rFwTj8/mivlynCXAvGAIaEA+5UjlKiVJ3ne1ITnnivO1Y7vE+9O4O5ZN1b+/ouiQa1mcJSqZvEv45/Y4xr65SZ7lXLvOm2l1Wmhfsmu8Ll7j5NLggoDgoIW9Q8sFhTorG3HznBIAIg9IQDb0UfOvvYJ8Y/zT9lCl3elGy7j2qKw84qYRgocrd0SeIP0WWuV6jaF/xpdc4tfihcbqOkULcwExZLcbaMhLj2yjCKiAqZ2DH24rENzYtbjFGFA4MidBGu1QmxQmmNuaUXACP7gDAuQjr0M/vThqljLYjwdn/3MzjBlV7wojEWNSskwxBRf4Iaj6lLYc4UbdtNBxVEYbv+Fl/nnh+95HbRHWS2rRu44KI9IjheKy16hVmzzrplP42qQX3w58uirSBBjodqfUUx8ru29v4XUWwGEcq6V3RRjDGN02BMGkhCaf13mIVlyvF+ptoWqhRc95w66inoL0AQwqWPAkTUNXIJYqIR7igzysNN2m9uhHpAdAiVcFiHQDoGXlGxKrU7ny/fk1F4W3AszB7E6ZdLrMm/zSPZS8ZsvDRKNJdW+5+hmucTHAFSyNntkFNLBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(3023799007)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzNuakVCa2hrT09Ca3FhNU45TnNoakhwZkJ5bVpmbjlwTE9aK3lPTVVwbmpm?=
 =?utf-8?B?Yzc1ZTd2NHUrQVM1Z3VqRTl5NjJDMFdjYnUzeUsyQTNTU3ZhUDhMZUFtd1Fo?=
 =?utf-8?B?c3BwUUl5d0w5TkpFVmhNL2VLVFkvZ0N2aVNDSDVnTlJWVUFKOHZIQ0o1d3BG?=
 =?utf-8?B?WXIweWhOOGRJY3dwZHBUeDlqSmQrOEpUeVVZZzJJR1NEVjRmYU1rL0tDQWFO?=
 =?utf-8?B?UEJlak95RmtlTVpkVHhKRk9PVkl0SzBLejVsYVJGS0lveDFmU09jM0NOdlhI?=
 =?utf-8?B?OGQ5bGpUR0QvR0IyZUcrb21SRDhSa1BQaFpoQVJFSCs3Q2g3WURVamprTzNq?=
 =?utf-8?B?U29jaEJTWDN6c1pYOFQ1cjd3WWhCRzN1aUg5bVNLUW9nanZiV3VobFJNcldK?=
 =?utf-8?B?KzhiUUd2RXNLMjN3bjJGSUZMSDJBT2lLNVBSWUtOcUlSRkNTSWhuQi9IaWEw?=
 =?utf-8?B?bWVZRHRYeUxmdGtQa3VGQU9QRDdGYzFsdURabmRKTy82RnZNZTVSQURYWDBD?=
 =?utf-8?B?WlZFdUFVdVgvc2dCMzJPZThFM2ZJK2Y2ajE0YlJxbTFNOGtXQzh6bms5RFlW?=
 =?utf-8?B?QkpyNHd0cDFFWTdSMFpjU01wSXhRcmJMUCtvTXhRQmZzVVhWOFgrYjh6NDBO?=
 =?utf-8?B?d20vQ2djN2VVTGxxRlE5Y2FVUlR2aGdUNU9JM3kvbG8xUTlMM2pFNzVmVXR1?=
 =?utf-8?B?YU44TkFDRm5WcitWUWNyWWgvNzQ3dERJL2RNZVBWUXhpRE1UZGRkZkFyMG04?=
 =?utf-8?B?SGhDV1c5aERrMUVoN2R1UDdMbTlNNjJqc1RRTkIvOVVoWWZVMU9vbkZwbFFR?=
 =?utf-8?B?bXBzS3VRZXZMN1dHOXFPbk1aSVFNRGtCQzdtRDRQUWFGeDJMQnpDQzVkRFRi?=
 =?utf-8?B?dXhWdFNZalpSZkkyREdaTnROUUFsWTUremRGTHliUzBYbzI4WUhVbGNJOVJ2?=
 =?utf-8?B?YkdxQThoc094UkpPNmlMZEN5Um1yYmw0UVc0dXFHT2dPeGpQQUpQenFBTTdO?=
 =?utf-8?B?cjhoVnFhaDNDSU1KU2FXcFNlSkhDQlFOQ1krRU9vdFFqWjFwRk1tblAwVHNY?=
 =?utf-8?B?aE5LQmFWZ1BPRXJ6NlZudmJBNFljckV3dUNmRnM3VnZLeWJzTVZ0YndTSkRr?=
 =?utf-8?B?M09vMUVRVnY5eGVwakFURVpadTNUbUdHLzNQR3dOL1VFbGZRampUaHNrRmlN?=
 =?utf-8?B?eENXL0hRZXFGbk04MnRDWWtBRk9VRlhLZFBoRjdMNytLVkdmNXhXOE5iWWxP?=
 =?utf-8?B?aGphcURERkxQbWNoeEs1Z0lQa3pRMGVzanVyNEZwTzVSQUM5QjZFUnhvaElk?=
 =?utf-8?B?NFdzQ0EvM2dnbXJFSmFLWnE4a2tFcExYUTFXZlNtNFIzWGVheXpNUUo4SEw1?=
 =?utf-8?B?UEVmOEhUejhvKzNrdGErSldCdVE2SUVSb3VuczJSL3BhdGZnYWdGZklwYlZK?=
 =?utf-8?B?UTkrRWY3VHBNbGxzTFRjUmZzZEtIYVB3ayt3dXp5S2lnSVNUVmJoZENpREhP?=
 =?utf-8?B?YXRTcDlkRnlaNkRTeWsyU2RzVG9xeVhOcUdpYzVMVDh5VnpUaVpUTUVlVzhM?=
 =?utf-8?B?Tys5Q3dGYWV5ZnowSXdTcnpNWjNoUzZ1NkFzOHVaN0JtTCtMREZhY285WE1o?=
 =?utf-8?B?WUJoVjhUY3VFUHhrZ0NxeU00cEJyVmM3OGxZbmNmQ1Q5aGhNWmJHcXMva3pJ?=
 =?utf-8?B?dytxVU5BR2RmVzF2QUx6Rnl0OStyZHpUR3dDUHdYdDhnclJKMVNoYVBLeER0?=
 =?utf-8?B?V3NWeXgrRFkxNk85dVhIdzU1QjRCNU1IS0Y5VFpNRHQ5bFhvbk1OaS81dEo2?=
 =?utf-8?B?TDA0eGNtbmxKbENWdytKN1VLSlZaY0d6ZER1dDBKLzk0bnpXTitKNG51OXFO?=
 =?utf-8?B?Zzd4L1VOZ2dGWFdTSXg5V1F0SzJ5ZDZ1d1Nab0pXV2FrK2dCVHNNZ29ZVUMx?=
 =?utf-8?B?eElvVUlEWDU3V3U3Qm9OcFVnL0ZCL0FOWVFnNU9ENE5YT0hMTnFwZWFaSFVU?=
 =?utf-8?B?MVNvVmxwamFpcC9ZcVhUdEhScUJpM1ZwekkraHNSZDBRcmJGR2Y2aGo0anFk?=
 =?utf-8?B?MHlwSkVzaEhObmF1dFp5a2hqQkJubThKZmRIbVBvUGZNai9UV0NzZ1FKaHY3?=
 =?utf-8?B?c0hNeFViRFBvaUY1QkRWanBrQnd5NmNaTW9Odjh3U0pWdndqRHZWK1N3R0xP?=
 =?utf-8?B?Sy9NWFROVUtXQlZid1cyeG1hTGVlelY1N2c4N1BBcitwSmtaTC9vRkVjMmE3?=
 =?utf-8?B?N3FKazBmdERxTWVmaHlvV20wbVJURWJBYXR1UkY5c2RTUGgvL0U0ZkRsbk55?=
 =?utf-8?B?QnYwYzhwRlRQbGEyaUUwYk5jVGRmSjVkV000Y3d5VlU2VFFQdWxIQT09?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fdcb2f-f9d3-43a8-7cd0-08df0e7660f5
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB2357.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 13:29:30.7302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZiCDce2rYh9HxzoaSYFb9N3aV+r1AEKO41y8MuEP10MMm2FXa1OQ5zIJ4tUrEqp2gqmSjn0GLVYFuuLRPxIODA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8454
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

The newest bug-fix release of LTTng-tools 2.15 - Péché Mortel is now 
available.

2026-09-01 lttng-tools 2.15.2 (Ginger Cat Appreciation Day)

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
         * Replace removed Python 2 C API macros for SWIG 4.5.0 
compatibility
         * Fix: ust-consumerd: oldest packet lost in snapshot of active 
channel
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
         * Fix: consumerd: crash when consuming a packet with no output
         * Fix: ust-consumerd: crash when flushing a stream that has no 
chunk
         * Fix: consumerd: no packet produced for idle streams on rotation
         * Fix: ust-consumerd: reclaim timer resumed for a single 
channel only
         * Fix: ust-consumerd: crash on deferred reclaim without an age 
limit
         * Fix: ust-consumerd: reclaim timer not resumed after explicit 
reclaim
         * common: re-arm a cancelled scheduler task when it is rescheduled
         * Fix: ust-consumerd: lock inversion between reclaim request 
and scheduler
         * Fix: tests: lttngtest: taskset_anycpu() retries the same CPU 
forever
         * Fix: relayd: 32-bit overflow of packet total size
         * Fix: relayd: NULL file handle dereference in GET_PACKET
         * Fix: relayd: live viewer can reach unattached sessions
         * Fix: relayd: size overflow in the live viewer GET_PACKET command
         * Fix: relayd: reject zero tracefile count
         * Fix: tests: stall-buffer timer relies on a packet-count artifact
         * Fix: ust-consumerd: stall watchdog ignores snapshot channels
         * Fix: relayd: incomplete session base path validation
         * Fix: relayd: stream channel name allows path traversal
         * Fix: relayd: stream path traversal via reversed strstr() check

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.15.2.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.15.2.tar.bz2.asc
