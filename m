Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB8DCD4F26
	for <lttng-dev@archiver.kernel.org>; Fri, 19 Jun 2026 18:56:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ghmyz1hM6z1VW2
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1781895389;
	b=ZtyjNsQ7xC+QzStlFqKXW/VxFeFH0PInvbJqbELchpw0ZctTVNwHC/UhXEguNEm1+maQ
	 qIwLbhE3H8WAbtQL/0+IzYQ4iRYvbmpBHNMlz3gek3a5Phf/80sxq17apr06dze+Byb5u
	 zKB9qeKYzZqVlEfq7mAqo9DXPAbaMKGjGiBK9Fvzlwo9knDnrTZGYZvUzSnGfDljh0ZeP
	 Z4dkG0vYF5aKYJjBKk7iwnAKQVUzT/I1cbtIA6zpT3yxyepKTVxLMaAAkBZ72TdiOlw9P
	 vraGRDO3NHKIlH3R3pudgitgfRliEgD6fKbXp34uVNvDAP/Tu1vLjvMETn30rlPSsVA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1781895389;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=DpyWtfl/HU69cBExkYIVvo4i/7c4J75Y0Gz3ws/SBTU=;
	b=A6BlNs+q0XIZPlfd+G/ODDBZVFtNx/muLpFxVfFQxBPJj+tC946fxfPD86qEJ9R85PNq
	 UKd0F0/hJ4CXBJHu1NNa0uhPn/XcQwMLP3vQDscFrslHfpZpkK2QQu32uFb0PU9JGY0h4
	 ne0+tTrSd9hI2Lx8Y4sEXYcuSqCj0pdxckIIvljCWe/XsgJIYkz8Ya3x0fsj/T8myXLHg
	 m65dqeqcfvfRdmsKLJhHh94Gtn2uG3lzKSb3sQKK3gydWF23jLNk002TTAOfR8JuPvpJy
	 oYUsNPwrmMR6j6bZQjYh6Kgq8wsJIt1cQwrHVG+1dCaivzt+rDQXM7jmhCkvEj8wdeA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ghmyz1hM6z1VW2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1781895389;
	bh=nYLYZvUXL3i8ms6X9cjfWZ730kZvHkYWyCykT51L2nc=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ZNBqAyZOx9Q9Kv2WZyyi750BWOuroeWuwRIijrjpI+sQmtNEK1NrUf56deFN9dFcQ
	 piGdlyWncwY18yvQiCOX0cdPHDh+DlcYtkWZcoAkQlQ193s+xAgKgxK8vAJ03pMSSS
	 MdnWnySInPv1cKxfibJJAIojMyngVIbPj47AC665VI2qccan5V0V0wgr80TrsyTDgx
	 VANdVKnZj31F1jlRPF+GJqpH2rE+6JhXiP9Il9aDuoP/dgGr4tTYUS4fWVbCtCcDD6
	 0BgowwldP63M8/w3TmBgRLpPX25TWGpx2jPApkefBQfr6xcYjxdpAFCTlLmIHkS6mx
	 sFibJFi3PJkRQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ghmyz1hM6z1VW2;
	Fri, 19 Jun 2026 14:56:27 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ghmyx45dfz1VW0
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ghmyx45dfz1VW0
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020114.outbound.protection.outlook.com
 [52.101.189.114])
 by lists.lttng.org (Postfix) with ESMTPS id 4ghmyx45dfz1VW0
 for <lttng-dev@lists.lttng.org>; Fri, 19 Jun 2026 14:56:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LExKh3zOgtAZxP61QgfnrpPW6snT6H4g/aSJ9CQRDSlbEqfn5aeeF9MD+dIWdRzPJLCl4i+oLQotsPLrN0IDJ8Z8nY7i1nrNBlpbm7xoPXdYVewD37R6qiH8XeffacnRgGk5Hz+7td7QPqzXCUE46nC2NEGxQXg1GenP7XV4debmR02utzuHqtGWzy7bDOuBG22MMd0xa6I0jD7z0j4YTqu7+7FDS7GgfWHxQ5l0VUE0kgY4jhtx53fma7p4elbaI+/Kb9byGd9IzN4FvpsHcZhH8kwQgO0mQTm7oRgGOvCUAF2phsPAYBVxg/AV/5gWUHkNZYd00pYp0D3+N8qdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYLYZvUXL3i8ms6X9cjfWZ730kZvHkYWyCykT51L2nc=;
 b=lw/8Q7rIIyRrjMJXoDhU6F1I/WUIhcPR3IE9kaMNfUPB6+rNxPlucN8w3jKx4MOwLZxm57dqzNkuqHWfdYHn4jchbiJMrY/MNR5bvvkrvelCUbPAaCbARL+xMu9PQymTJHsEy+n29t0yBFPysIj/eP1veGMCf0iHjseVk+zO2bX59sgEh++4fNcrcrclRbadzxfgvlR9XaecPREk8Gn0efq6kB02PkbdWPllAUHRbmYZxDGDz4b87Uv6wtRDnyMzDSQZHDzZPBfOfwwjViXZv37V5pp6vLfVlTxtvXSBB5CxUkF6roDQuLzbHURX0p86ZWdLlz1Gu0v1fzEeHIpm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10651.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:95::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.7; Fri, 19 Jun
 2026 18:56:18 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.21.0159.007; Fri, 19 Jun 2026
 18:56:18 +0000
Message-ID: <394956c8-9e78-456b-845d-54a3219214d4@efficios.com>
Date: Fri, 19 Jun 2026 14:56:17 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-modules 2.14.6 and 2.15.2 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::15) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10651:EE_
X-MS-Office365-Filtering-Correlation-Id: 2667494a-1989-4f1e-0584-08dece3471f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|56012099006; 
X-Microsoft-Antispam-Message-Info: 0CHYHUHaNapb+tJS6hAQF1Mi9EkWr+S0UUcA0u8rinyE3QUlDkLkmberQna6Yi0Vn68JDGsRgoEkKFdBGCS6bLdGnn9mipGM7gqf7f+ayiaHnAkZKqMXaatgYrfWAtsb3ZvjiEQdRQw3F7GNwx+HEmzlcvCsP0yQG5Gh2oAva4GfoRVIpHvextA5Hxn3KP+WcVOciDOUIutzusAV1YLeYo7mMzmthzx10YeuAdaw5jk2zmnwBWqa7DX76O5pEst/B/dkqpusVltYGALOOaNgE5gqyGfWYyMxgGLAnvN/HEOHbNe/HdP2rH/WGpGA7xDVXp/A8+MAisS49B3DfksuayagC59dahHl3nKXj3edAcG+0yqMyt3hHaoNBwjc6pWE0hJkbcM+yEozc4Pw0waTLq+VjPzz7bQ3I6mDBxoUqrAGlaMh7gcexz+RR/9ADrNiylg+9GEX+kIZAFDEl15+qtPt5sv0TWstAhv26liDR3ngPEDbgkugH4otfduh6oOBKEyI7nRi/YM+h8iZhKz1Hs5rk5zbW9nuQz5y2ViGZymkxav6xbM1xH2lj7YpmVKUIRf1C3PZcoSKnFzl+IesXSO0FtWFV+6T5rNUKoaRhsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azBVYXpBZVF1TGtsYUg3OE9SUG5UcSt6bnZ0cWlpUkxENUk1cHY5R3JiOXFG?=
 =?utf-8?B?cmpLMjVpR09yRHluY2NJdWx4WWlrRC9PUUk1RnBMazBKL2VZa1JqckgvWUpP?=
 =?utf-8?B?ZGxqcmljWlV6S3MybHpWdVBaczIxRElGUlI2aUtvanVLb0hJaTd2K1ArK0pR?=
 =?utf-8?B?NmgreTdkajRocFlTaWlRNENJK2g2ZkU3WHlUaEZHZ1J6eDIvNVhRdlNMZ0JT?=
 =?utf-8?B?WlFkSXVYTUxaQ1R1eTBMMGFjZTdXQnNkNi8ybkpwMXNLZ0NxV1RsRlhlOHN4?=
 =?utf-8?B?cWN6bmNtNGVJNVVDd2M3bTZGZ1JKblVkT29vRkRtaC9IQmNaMnUrUFo1aFhJ?=
 =?utf-8?B?ZGJWMnBzaTBwZXIvd2VMR3NlOUNhMTZlZGk5eVF2UkVGZFZoTWRpNlE3NjJJ?=
 =?utf-8?B?aHBBL0VFZzhOUkpCS2tCSWlRcitNbmFtendud0cvcjJTTjgwUkgyOVFpR0xC?=
 =?utf-8?B?OGM4U1BxQms2U2dFL000bkh0QzE4OHBGeVhnOUdHeTgrMXVGVWZCYWZhK2Jj?=
 =?utf-8?B?bnFLR1I2R09aTEhiRlh0bUVDT3QrWkxIRHBTVXF1Rk5mZFBYeUJXWnhtWklO?=
 =?utf-8?B?eDVVMWt1T2E1RnNkUFRyV2RqSnk4a3VjMUo5NE5VVFhIV3kxcmtQVUJSNmNo?=
 =?utf-8?B?elhFbVpWQmNJQjgrbTJra1ByQnRUcjlLZHZsRHh3a0Z4RGd1bDRoSGR6cTdp?=
 =?utf-8?B?Q25JQXgySHRRZHFJSFhBd05qOEFqeTkvMTU3M2VzMmNrelpvUy9iR0JUUHZN?=
 =?utf-8?B?dkViU2s2TlZZYlkyVUJEVER5YzJlY2FVeVpRZG1MekluNmptcURaa3ZWa2hF?=
 =?utf-8?B?VFhqQ1UxUFpkSUFWalYzZ09oU1d1OTROZXJibTkrWGhwbzlBSVhQVGkybzEy?=
 =?utf-8?B?aTZWZkpDQW5MVHVmOTNNcFI1K3Q2V2RvdllPM0NoK29pQ1ZDYVA0eFpuSkcx?=
 =?utf-8?B?OFMvQWdwQXZBZXplZzBueTJtMmtJLzBTMDlZNXRlWWhzUGtnWHZ1T2dza1lz?=
 =?utf-8?B?OUVrRUpNSE9LckQ3S0s1VmVmWjlHOHFXRlJsSmdwWmxGdHNhODYrcFJQYlI5?=
 =?utf-8?B?WDVSSTB3dW9FaGJmWUZGZnJ3ajlQZmpLMmNlakJrZWRHeklLUHFHbit1Rjhi?=
 =?utf-8?B?eEhub3lYRGFlWEhhV1QvR2U1OG9DNGVMem4zakVWSlFCWEh1d2wwQ3QyRlJw?=
 =?utf-8?B?cTZ0aTZBVkt5Y2ZKajFLME5XMi85bEhWOWk5S0hPeTN5eUhNRVBVWGxodHRu?=
 =?utf-8?B?SzNXMkc4Zi9DNFlqR0NKLzcrcjBtci82c2xnRXZxMEEzN1piYk1iTHR5dTJC?=
 =?utf-8?B?RVBWWFNYZDNBbkp2U2JjS3pvbSs5M2U2ZWgwUFd2a2paMVFBck5ocGtVb3JS?=
 =?utf-8?B?VUY5ZVczVE1oTlNYS0dJR0hZaGdmRUN4Znd0TUdNa0M5U291azNURHp2ZFgy?=
 =?utf-8?B?MzJiMUN3SGpjKzlmelYralJ0ZHVkR0FYRmZpSDdlbTgySTNrZjV5elgvNGgx?=
 =?utf-8?B?elR2eWtGa2ZUaUhweFhYazFuODBUUWpHekpsNDhzekpxazJOTWc5VVI0L2do?=
 =?utf-8?B?MXE0dVpDck9YdnZINlNJYzBRbEVCc1IrUEZzYW95bStOOW9TSEFCN2dRbEts?=
 =?utf-8?B?VlVzS3lYVE5FRm13Mnh6UWtnZmoxT25wZUFXdTFCY1grTGJqSFk5a2svTTZ0?=
 =?utf-8?B?WDA1cVEzSW9lK2lyS3NKZUFJZTlpbnVmQ2ZjSEtIRTVMbDUzbUxpYUtiR0xr?=
 =?utf-8?B?ejBUUUxCblluaUVHbDlUd0RTNzh5eWN4MGI2d1RSS2pGT2xTWmhOL0ZQRXBN?=
 =?utf-8?B?M3NSM29Dd0NsZGtpaFFocGZYZHFMbWQ5dVJRcTlZbysyNTVJVStSNlUwMnhp?=
 =?utf-8?B?cldYTUNobS83TXh2aGQvdUNIVFYrL2RKK2pQOGZ0cDREQnMvZEdzazE1L1hJ?=
 =?utf-8?B?Z1NzdTFIcEtiSU9Fem95bCsvbjJuUm55NHZyMW95UzdhZy9JcVp0WElxczlK?=
 =?utf-8?B?TTBtU0lmQm01OXNESWl0MXRCTnkwTGR5SFN3TVRFYWtQZU5hR1hwblN0VXVB?=
 =?utf-8?B?VVRWQXhISURyOWFwSnd3c0pmWVZHTnpLaUtITnZjREtMTzdSWit6N3NMbGcy?=
 =?utf-8?B?K0E1ZEowK2F1UGRoczI3czRWWWgwM2doakQ3N2ZKeERoYU5lTDRwUVdGaGpR?=
 =?utf-8?B?cnkrS0dlSWk2WkU4SXJEdFVFT1dNS2p1RnJJaE14eVoyTlp4aSszRW9kTDFy?=
 =?utf-8?B?UjB6anM1T0JGUUlFcU5nNzVIYWFzZzBMWU1aeDZpM3RNaDFrUGpNRHNCMnVB?=
 =?utf-8?B?dTZPUEtMaktlK0F0Rmo3Y21TeUUyZktBUU5hMG9Rb1BGRnNtcE1sVVRQcXZs?=
 =?utf-8?Q?j7ImZHqtEgfmcp70=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2667494a-1989-4f1e-0584-08dece3471f7
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 18:56:18.1651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTf4tmywG5YiKvC3kUcxOj9Mm6+9Wiv1022qUkRf71ED/jwEFtNwUE1fXgrPqeYHVF4ReigyM+GI3YazKtBfL1kqgCMyJvEpiRCbgZbFdzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10651
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

This is a stable release announcement for the LTTng kernel tracer,
an out-of-tree kernel tracer for the Linux kernel.

The LTTng project provides low-overhead, correlated userspace and
kernel tracing on Linux. Its use of the Common Trace Format and a
flexible control interface allows it to fulfill various workloads.

The most relevant changes in these releases introduce support for version
7.1 of the Linux kernel.

* New in these releases:

2026-06-19 LTTng modules 2.15.2
         * fix: leaked file and fd on channel create error
         * fix: backport: hrtimer: Reduce trace noise in hrtimer_start() (v6.1.175)
         * fix: ext4: widen trace event i_ino fields to u64 (v7.1)
         * fix: ext4: delete some unused tracepoint definitions (v5.13)
         * fix: ext4: enhance tracepoints during the folios writeback (v6.17)
         * fix: btrfs: tracepoints, use correct type for inode number (v4.18)
         * fix: vfs: widen trace event i_ino fields to u64 (v7.1)
         * fix: treewide: change inode->i_ino from unsigned long to u64 (v7.1)
         * fix: mm/vmscan: Convert pageout() to take a folio (v5.18)
         * fix: mm: vmscan: add cgroup IDs to vmscan tracepoints (v7.1)
         * fix: hrtimer: Drop unnecessary pointer indirection in hrtimer_expire_entry event (v7.1)
         * fix: hrtimer: Reduce trace noise in hrtimer_start() (v7.1)

2026-06-19 LTTng modules 2.14.6
         * fix: leaked file and fd on channel create error
         * fix: backport: hrtimer: Reduce trace noise in hrtimer_start() (v6.1.175)
         * fix: ext4: widen trace event i_ino fields to u64 (v7.1)
         * fix: ext4: delete some unused tracepoint definitions (v5.13)
         * fix: ext4: enhance tracepoints during the folios writeback (v6.17)
         * fix: btrfs: tracepoints, use correct type for inode number (v4.18)
         * fix: vfs: widen trace event i_ino fields to u64 (v7.1)
         * fix: treewide: change inode->i_ino from unsigned long to u64 (v7.1)
         * fix: mm/vmscan: Convert pageout() to take a folio (v5.18)
         * fix: mm: vmscan: add cgroup IDs to vmscan tracepoints (v7.1)
         * fix: hrtimer: Drop unnecessary pointer indirection in hrtimer_expire_entry event (v7.1)
         * fix: hrtimer: Reduce trace noise in hrtimer_start() (v7.1)

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

Enjoy!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

