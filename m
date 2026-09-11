Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28393C88E45
	for <lttng-dev@archiver.kernel.org>; Fri, 11 Sep 2026 14:48:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hhHTl5XBgz1XNW
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1789138093;
	b=ij9j+kYcVD2t/ETcqSQUMRO+ZUVpKCQqiFa2I28ZSY/4hj9wbw2QVkkyqISErd4MM8yh
	 RqU4f/0cve/0zePB7JzgaBa5f5Lho1agbPK9lDNhB0jSjqpUmsYujy/FCOybLB5sjWTqs
	 Nkq42aRahRGQibjtSab2Nek+u8zhn5wp53EoQvIP46ESyl6yohcK3CXc0mnuCOALZJgyk
	 e645cQLshWo5bKEzlEybPLhn/NvY4CkLbtk5yJuf2UrvMR8WO66CuKayEgwq5nYZScf8T
	 R3rQmyWPw6vl7eCRum+BAsrkd8iflHSds7KowCqvdaZ06/utRrhElInvrzf11AcHbZA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1789138093;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=wkxF8vC7vpJW+f3Ct7JUTBBlL48tBtawEPA8B1CaUSE=;
	b=OKuOnNDO5Dk9TkWMbQr/jCy44NCbdWrfAy8hbEUAtvha8vpqYskIXDQEtuXQc12eS16R
	 RewXS8RaoALIEfEq33dGjOsT9qExuwQR9/eD8n149fQjzjYWuOONvnnvqyrxDPjFiJbx/
	 NjbSxMT3jPr91R9ew9Eh0vT6TF5ZpK/+8d2GMlenm/9/G2XbBf8962Tjaw3YA9cieREKF
	 B3+t0lIYto5fZkRvfAOTaJc2r6Pdl2Cdj1FWEyoXU2mPJvXheTYOjg9MgUELhkBRXIgtx
	 PAS+gndd23e6O/9TQkDaCDqseyXpxbuaKO10h2+u+8t0IZownUzuMPuYRsOhRWieHaQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hhHTl5XBgz1XNW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1789138093;
	bh=Gca5bMst3K8uogKeJgY943CC71RVk6dj8/NG+cGlQrg=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=QKzJ+wbNBm5vcQhdocXAAUPWase4cp8YSCb3zm8hLEi+bzr4btmd7W7nyzQsQ6Hut
	 yN+sTxXyjmIetRGj/OkJqFBwGnZOxnuYzGCiOWicZmP6A6AJSsBCBl2DVIoL6LJGCe
	 b3tcB3fLESFKKth1iPsdw9lfmYSR88K8+aqy9cRx5gDInAMBCGcrQFUtiIDbH3eUih
	 Rasg/LbZLoMCKTRjKIGkktQh3oTFLxiM/m3d+JeUMpwkwDsoiUnfYuuo2/gDKZ/9Gr
	 8Ml0tPvXutZsEWwgOsHFOmEKA/0fhgjKvZMQRBHeccc+OcBnJQl7C95bn4++20B7Nr
	 HGtwAzJxQOpeQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4hhHTl5XBgz1XNW;
	Fri, 11 Sep 2026 10:48:11 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hhHTj2l6fz1Xy2
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hhHTj2l6fz1Xy2
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022120.outbound.protection.outlook.com
 [40.107.193.120])
 by lists.lttng.org (Postfix) with ESMTPS id 4hhHTj2l6fz1Xy2
 for <lttng-dev@lists.lttng.org>; Fri, 11 Sep 2026 10:48:08 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJprIO1TdTDUGNZ2ZDShe26vdwnfPawL2KYOd7Jmq/Rv4Lq1SKjlpvH5xtFKySCewYsJ3vjl6pbDCKb+5wY3jPwvI1Dzzq0NKtVQ6Ooao1EMrYuV/PpFX+PEKhHTRlu1nNhh3gdHICRyedBcJa7WjPgdD1Xq17Rq3RF0lFAy7+RrBfUtxaigEWS6H3/LF2tsZqF3zMBGbwjeezfZ9K1FB6KwIrS5ZviQ79qIXBeiTvIzPIa48/K18yj+gvBCh5ZVAaz750MF+Wd9T/0P1cmfsT1ZxqlZwMppH/Xo2zEKmyQ/84wcBGXPcQc6EVSIUUi5E30eSBWNYPwnC3tLJO2Kzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gca5bMst3K8uogKeJgY943CC71RVk6dj8/NG+cGlQrg=;
 b=k42FZDdB3N6EBdab72defnraaNWtqLrytiBm+TXhLv2k/7yE3+IVY4OfToMQ5gblJunHDudMkKRiUSKrJfI3vmT41mf/16iwLtTCReF//i2k1RnGS9AoG4f7qDiCXBMtskz3Mm1dJ64UPTp2ZsnzPw1SFlH0cfYyZClJlx8VciFRCz/tuTx7xLyzvgEGOVtAZEb8ILzcioDlq9ZLL/wr46wOgfYMtzZyyjIdDFvRS3cNWf4UP1San35R6TNdSlJkEwF4qU45ZpK0ci6eBgbuMTHozZty5WDglnu+C7DydOUHZqEVIRho7yv4YPSzU7upljmEGUkgY5nxWbn0OmPt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB10575.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 14:48:01 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:48:01 +0000
Message-ID: <2e21853b-8c0b-4a70-8591-bd778b210d6f@efficios.com>
Date: Fri, 11 Sep 2026 10:48:00 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: Paul "E." McKenney "<paulmck@kernel.org>" Alan Stern
 "<stern@rowland.harvard.edu>" Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RELEASE] Userspace RCU 0.14.3 and 0.15.7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::11) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB10575:EE_
X-MS-Office365-Filtering-Correlation-Id: 6336a05e-2b88-408a-3faa-08df1013ad8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: SVKYco43sl33gL3474ZI2/62RWPEdz5/rAmgUhon8Ifs7Xfu9Lb1QLSqEl0ODm/Qv1Tl3/9sOAXO03fbR2iwpTFoDblcki4co7KD+QgSZtY/AbMPEpggV8QMUQxZ6QaFzN0wBkAvS9SCP5tCBlWW9Y3+JmeHlYw0d0pQ5d2sMcT4MelaBYBKzrDdNZzzaFBs6AKbJflIJG56M/GeO13zWzgVf774SH9bcdTV8Tv4aeYW3yPMPAX29M9gFqgOLEKEhrhuL9gg48uesboqN5GuywYRpAGPDHF+WtOTPeQB6BkiXLibmMJtGM1rV06/GFZjpWuR9dEZGaxckpI7K6P1txEOfqdlzx9glVGfQ/qJoBLIxq1rwc5xhkiHpmymRc6kSo3e4cM/qs8siSEBODjIpT0KGvwAXDo9E2TM3u5WxsR6V3TVl5vzPtgCTVRFrYpi6QZOuvcQoB1zvU6AegyXLKYVNPV81IAycgzL6GOyw14V8wz1Jj7PircfZ5rpjygUEcEosI4A1xnApBg7jmIq44NYxLV2gtu30zXLKwfDT2EDyE5YKbRFoT15eP2quwKy124Fd8g1TApdlfOajyc/Wq6wFoT/awzRjF7dLr+0wWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(3023799007)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXBlSW5ZdjVQM3E1d0RNUkZjTWoxVXY2enQ1djBvOW9mUjV1WDZiN1YzYU0z?=
 =?utf-8?B?OEtzM0Z0aGM2S0Zlbk80S2ttdHpxV0JINjZpL0YvaTRBTUFZRkU1elZIcVZK?=
 =?utf-8?B?d2dSTGVVcWd2KzFtR2R1OE9HL2NJZk1VZUlzNWtqbEI3Mm5mRTBLYlBwOG41?=
 =?utf-8?B?Y1U0U2RUN0VQNnplbVRPQW9yRE4rRlE5QlBockI1RVYvZlZtZUlJWEFiUjk3?=
 =?utf-8?B?eGxFNkQxN1JsclgwQ0M2NDAvajUvZG1vMHdRdEVLRVh2VkIrMlVVZFp0a2g4?=
 =?utf-8?B?VnhOd21YYm85Q2VKYnl6RjBzWitlL2trTktUR2pmNEpTdHc3NW5WU1pIRnNs?=
 =?utf-8?B?OG9mbWFMM0RqQVJyWkRBdmtIMEZmazlVb1hPWDFyNUpCZGt0SDUzRjcrNHFL?=
 =?utf-8?B?RE1McHhieDEwQjJ2SFNqSjlkckFOUnJzSmZvNWtrMHlZclFnUTJJckdXV3Js?=
 =?utf-8?B?c3lUNkU2dVFwZnRQVDRUMGg0Z2ZuVjdPQ1I5TmtWU1ZQOUdWa2orRitGVUtT?=
 =?utf-8?B?K0xMTlBFUVJlTGZQNEs4WUV3ZkFoU2FCU0ZSZTI5RnIwUTJHVnBDbWE0aDBG?=
 =?utf-8?B?V21Jc2cyY2I0eUs3NXVLSGJtT3JWNlFVUm1yQTZ4bXBxa3dCcERlS2tPRHhW?=
 =?utf-8?B?WXY3elgxdTJ5RXhzNGhrYTFJdUVVWVFhRjBXSWw3VUNnZTU3dE5KbE1HdVZB?=
 =?utf-8?B?LzVkZ0VFemc5SCtpTytFT1ArcVcwZzk3djZPV0xHak9HZXNhd3JHbWdCZXVs?=
 =?utf-8?B?Zk5VckxyMzZ5WXdCd2JzaVRnaXpJZlcrSC9VRVFRYzcwS09LVm5HWldnMDFK?=
 =?utf-8?B?ZHlnTXJQSmU5ZklUQ2dhTlliWG9XM0pwNWJIbTZvbFF0RUU4V1FubFR4RDNy?=
 =?utf-8?B?bjZYMnd2enlSSVF1bEhyQ1NGOVhmT1R6REY1VFRMaFN4b1VWZlc0RVhDZlEv?=
 =?utf-8?B?T0RnSm5kelV1dXBYa0NVaVRYNUpFdkJRNk9CWTFCNUluZC95SmtqalpHeHJu?=
 =?utf-8?B?cEJkM3JJTFloRkVqTlZMOUl6dXlTYVV0SFhsSHhYQW9aWkhSVytDMzBmQlhZ?=
 =?utf-8?B?dVcxY2YxcjN3cG1QUi9RWlplbVR0YlVqcFVyNnRPdEdpWktwSExnR1Q2QlhV?=
 =?utf-8?B?OFNLTFFpOThPelUrRitlWi9FVGYzMmpBTDY0cWgxUnQwV2N6S2VHemM4OWVs?=
 =?utf-8?B?blBORUptdXFSWVFYWDk4SkllZ1pYUnJBdE1IYXZRVzBJZU9MMlVZdExkQTgy?=
 =?utf-8?B?aFFJQjlkQ3lWa3ZsTzkvNFlJbmxSMVd1aFJwQjV2WE5FYVZRYTRiTG1GTFIr?=
 =?utf-8?B?RVlmM01iTXpvU0YzREwzbkhtdXA1MFRldG0rSk0zNkN1NW9VNHpOK2FBY2gw?=
 =?utf-8?B?KzVycG1td3JEeVhPejNxMUY2QWNuOVV0Si93RUplbVJNR0o3azlrM1BCYjVO?=
 =?utf-8?B?NEhWeXFTNVpBeGdhN0xXS2xZbTVSM1l6aDZFV2Z4WC9Sd2FFZjJCTTYyT0RZ?=
 =?utf-8?B?Szdwcm9lbnY4cXBBaHAvcnlCRzNpWHlwMUxZRnlYc3hVWFN0aFNWTXZCREph?=
 =?utf-8?B?VVBuNTdEV0JWQnVuR2RLMFYxZUVJVXZtdkVmSlZNTzJNeVVQVElHdk1udEoz?=
 =?utf-8?B?UnkrQWJYYit6V0Jab0dUTWcwVUFJWEVaWjhlTnFmS0FXdHFtVjJKODZsZHkx?=
 =?utf-8?B?bCtZZEcxc1A3cm1IWXlsbnZyY1ljaUtQN1RlUE5vNk9QeS9LTVpIYkgxVWhq?=
 =?utf-8?B?MlM1cWFrYWxnUXdGU09wVVBCQ3hYazBlNE51K2NnTnd1TjhDM2xYektjT0Fj?=
 =?utf-8?B?MUwwK0M3d2NNdHIvT1l5NTFhSHlCaThlRlBPTG93VGVWNXBmbVhKS1g4R3NJ?=
 =?utf-8?B?eU53OVpHS2JLcTQyb1dtVE1ZOCs4YnAwVnpoZERJUUYwVThiZDFKQnJBcXEx?=
 =?utf-8?B?ZTN1N3p4RWMvMWNBY3FBNExMVTNkSDU2V0NVZzlHK2FNa29hZWM2T09hZ09Q?=
 =?utf-8?B?eWZDUVJRaTBHb1F0Q0pPdzMwWWlNSGptRkFwZWJZTG81MFgvZVpScHhWNVBi?=
 =?utf-8?B?U2pYallGTlpFRnQxMDc1bXQ1dFRsV1piaGFHb3pVa0tvVm8zRkdtMDRiNWNI?=
 =?utf-8?B?R3RrekIvWTRlaDdsYzVaOTRGRXlWbFJCWE5iRTF4S0huemdOREF1NWJKZlhy?=
 =?utf-8?B?NHRPRGVSRWdyUDFDZ29WRTNUQmgwT3hSRGdyRkNWWVJ2L1ExUGhJOENwMDhU?=
 =?utf-8?B?MXF4L1NjMnpsUFhnTjVHSmJuazdueUQ2QkRJaFFOdXZCT0RjSmhiYXc3VXll?=
 =?utf-8?B?b3A2M2M4clFmc2hQTXZSTm1mbHE1a2s2UUQ4dXN5TEwxNFVuV1dKeUFxOU9s?=
 =?utf-8?Q?1KpsckdbNBCBw55JbTXDqooOIatGh4tLfLX5P?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6336a05e-2b88-408a-3faa-08df1013ad8b
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 14:48:01.2900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUM/PG+iLaJsOpY5VHkfcE9e7BBiB1jUFoXkjipy1jPaAj3BA6mZinlnVP3es2OlvTtSYS/D0+DFlpQ2josbpRn0m2cV/vGGARv5GM4mUsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10575
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

I hereby announce the 0.14.3 and 0.15.7 bugfix releases for the
currently maintained Userspace RCU stable branches.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

* Highlight

The most relevant fix in those releases is a fix for the memory
ordering of rcu_dereference() when used in code compiled without
_LGPL_SOURCE. The issue is that the load is non-volatile, non-atomic,
and lacks the relevant memory-order-consume semantic.

The fix is twofold:

1) A work-around in rcu_dereference_sym() which adds a cmm_smp_mb().
    This fixes memory ordering but not load atomicity.

2) Introduction of a new rcu_dereference_sym2() which fixes both
    atomicity and memory ordering. The macro now maps to this new
    symbol. The old symbol is preserved for backward compatibility.

There is also a change to the call-rcu worker to make sure the CPU
affinity is set earlier in the worker thread lifetime, eliminating
unwanted call RCU worker thread migration behaviors early in the
process lifetime (first ~2.5 seconds).

Changelog:

2026-09-11 Userspace RCU 0.15.7
         * call-rcu worker: set CPU affinity on first non-empty dequeue
         * Fix: leaky wfcq tests
         * Fix: test_build.c: Test output mismatch
         * Fix: workqueue leaks mutexes on FreeBSD
         * Fix: call-rcu leaks mutexes on FreeBSD
         * call_rcu: pin per-CPU worker at thread startup
         * urcu-pointer: Add rcu_dereference_sym2() taking the pointer address
         * urcu-pointer: Fix missing memory ordering in rcu_dereference_sym()

2026-09-11 Userspace RCU 0.14.3
         * call-rcu worker: set CPU affinity on first non-empty dequeue
         * Fix: leaky wfcq tests
         * Fix: test_build.c: Test output mismatch
         * Fix: workqueue leaks mutexes on FreeBSD
         * Fix: call-rcu leaks mutexes on FreeBSD
         * call_rcu: pin per-CPU worker at thread startup
         * urcu-pointer: Add rcu_dereference_sym2() taking the pointer address
         * urcu-pointer: Fix missing memory ordering in rcu_dereference_sym()

Project website: https://liburcu.org
Git repository: https://git.liburcu.org/userspace-rcu.git
-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

