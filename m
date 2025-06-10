Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D241C5B552
	for <lttng-dev@archiver.kernel.org>; Tue, 10 Jun 2025 19:08:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bGywr5Jksz1Bpr
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1749582479;
	b=XJyaEcJzgoEr6YPlQEY1QqF6nD+KtRdF9oDHr1/JpgVMcfdI3w43xqP8mWXFRB4XFazl
	 TQyWtC9jkP/86AhEQ1DlgQJm/ghmOcV/o8b9ymH5sSmsrAB7Fe1mQtx+nCZ56Ofb4cw1d
	 eMHt3kVr0g8QMv7UBzRBpcQr9L2HNaA9UH2l8OU5DcPiJEBKvxGZmH+j76zmtXlGJkFFj
	 XbuWwoeAdj7RDNQ5mDlZsp/coeyeeH1XlkaK9fmgP+en92JCN4Hr1Q1DuVO9Pnt1r+8Xw
	 Hvl6tO+BV1UgyVi1U6rBJniVtsh2oQ5jsJDN97h848HRthDjN5Z9laRasYCj4eq8NJA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1749582479;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=a5RZ1n/RTVAxKDAc+/lzZM7sGODCLvloPPK4ZCCpuq8=;
	b=DVBmwqDEpD+D+wA77WOgUezWvYn7tv1q6HoHd19054eE0UM0sAXSf12CR3yXE2+f/yi1
	 u3cfPshJpQWVgZ5PieqJcA6gVdFPObLLEisMD3syFmLxC/v3wzpQba1SKfn8AfFRsjI+B
	 xdCHzEox0mn4BFZ+YKlj5xf98W5aaapQf0poINhOBa44qx6AvtIosu4KeE0CCJ4yyIgGX
	 /JY/9borXzUncTTWX1Ljq+0RxKKcy4+QNyuP2YeqpDuyoDKbORlGGrv0aUHdiVWHjm0zN
	 Q3l3vWhAfYsq/GtfsChIgkXLSAoR0mCJFx5MKw4QM3kGdCZ2oYT68jwrC5HNZ4WJy5Q==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bGywr5Jksz1Bpr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1749582479;
	bh=a5RZ1n/RTVAxKDAc+/lzZM7sGODCLvloPPK4ZCCpuq8=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=h84BOmnSf5epIIxSZRmROMEljpgWyUGEQt2BEYDmm+mQnOBW/14uB9q7OITw4vm7B
	 2pKLlDfw/6aNxzo9D7Q/yXSh7eBPMnim+zyTU0byrIfxpfebypqrQj1wUHG5lKMJfg
	 qKzr8YpTGF5vDed0agRvj2HN6jppwX2pO8OK4t2FbZD9vdnl0ExanfnzBSRQ26Sjgs
	 55ApFmuf00KdvqgiuDCLveaS8C6xK+iRT/oD0011DNt4/bwV6VWVH6PNIvwERaolP9
	 YMjRuF7HlNtQ/IZ6shrVzJnNNHyKRkMoIxnKWGbRo+d4yoJm/UqFP48/kGq80BHqg0
	 LoUZu+vHwDYHA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bGywr5Jksz1Bpr;
	Tue, 10 Jun 2025 15:07:56 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bGywp3Kfsz1BkV
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bGywp3Kfsz1BkV
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::70e])
 by lists.lttng.org (Postfix) with ESMTPS id 4bGywp3Kfsz1BkV
 for <lttng-dev@lists.lttng.org>; Tue, 10 Jun 2025 15:07:54 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiLOxOXre52seSytEEiuAWxA+0Tp1uuKERIGg55URmkLegfYd7v2tlJtJrr8xKbHf0TFDfMAbmZ7fZcSDy2wp1QQw4UYa6GU+Z0CH8foJC0O1ow+fw4sEtEeB36fDHtuo4EnqrVzaC2ObLLIn97c8MvXdoXPEey8TGJcpQjthqFHjB38WrJow/SH+YY2Ru46Lv2uIFPVDZhBKe9onuGQcCSBzjAlGXrVONhhPXS+ztsEbL3DBXH5P5XiWN57vmkU36wfYJ3zimkyGAFOpVdsYzDA2mX4KTIR5wczRWo89aIU0OLsXJxeWf/xSSjmzyiCckjf9He56mrYizUqoi/4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jta83ZbHQMey6W0eW+i7RXXAEVsESEoQx2jE4+8LJes=;
 b=c3QXuKMLVtzEI2Gz5Y3zp/NMrmjxfQi4aGQuQrtkF8+xqVnuv+BwyDvmse37rzPSo/LPO437tAiUfV6mwR0PNK9s0igdZcUozhDC1unbi3TmZ1jN3kxLPjgrdyhy7IMvp17eNaXv+j8I/q42CZVcCNA7ESRgvcy6QtUboAdgdFCDku83zVXlE+Jg6rJe5I+fIFg0OAA1e3/uOna0BtS8qdmEqHPuUJzG+RgbYgnpfTgCXC8qnqEsP0NrAUcUuJjorbptKE/5EqgJ0FE+b8vxOAF72NTqqm4s1GvdjAPwCGbQlx3JwK2F4r3vj6J+/M+JKmFum5yChAZ1UbIZK7n0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YT3PR01MB11207.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:12e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 19:07:49 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%5]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 19:07:49 +0000
Message-ID: <7c62fe87-b2fb-40df-a932-ba634216593e@efficios.com>
Date: Tue, 10 Jun 2025 15:07:47 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-modules 2.13.19 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::38)
 To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YT3PR01MB11207:EE_
X-MS-Office365-Filtering-Correlation-Id: b9497ae3-8275-4b1d-611e-08dda8521754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFA0bEVvQWFuamJoT2NqUGlzSzBCNy9Ga3Q1ZVlYLzR0OHlFU0FEWUc4MkNz?=
 =?utf-8?B?RWl1OTd2bUpjQVlPNzRZV0NkeU8wZGZ5SHp2ZHVQNTNTS204b3QzbldFVExM?=
 =?utf-8?B?WFN1QkJzdm45UmVPaWp5T08wb0Voak0rYi9YY09iTTV0T2loNkJES2M3bnE1?=
 =?utf-8?B?WnFZZERNbG9YeEZkeTFqbm1xank4R1NKb281QVpQNjBiTDF3cVdQRnN2emRr?=
 =?utf-8?B?TnFhcmNxa0kwK2hMY01tUWl6NFY2S2FyakhyZVJ5OEZ6SXFMS2dlRjNXK01O?=
 =?utf-8?B?RTNBZmZDZ3VMY0xwbkFwWXQwbitzWExvdFQ3NEZZYUI1SnF4ZTJwTWhKMXpy?=
 =?utf-8?B?WkU4VjArcDg5bEVnTnNoZ244TjVSSG5lOWNMbkJiUDBldnAraTI5Z2xkTGJD?=
 =?utf-8?B?NVlOUzVIZUdjUXpuYmpXSXlmL1VXbThOS3hFcWNQSUY1YXp6a1lhWk9hVlB3?=
 =?utf-8?B?ZzJ0SXJYMWFldmwrYXRaOG9oVGRhQzZQcWRoVW9wTnFkZmZDVkNsUVdqZUNq?=
 =?utf-8?B?KzFoRWdFU3pvNUJpeDRBN0Z6Vnd5alBLTjZJQ0FyTFF5MEZxeVd6R2xQR0No?=
 =?utf-8?B?VHlUa1NQWWFRRjRGcHI5MG1vOHBFUjVidGFscFBRekNMK2pMT2M1UmJRVWlT?=
 =?utf-8?B?Z1JNckxJT1p5NFZTVFVPWXNqVlFPbkpISU5Fa2J6M2hLb21Xd3I0OW42d3g5?=
 =?utf-8?B?M3p0OVRDeUVrM3UrSlpUQzMvT0t3WVFPWWR3a2gyRmdBOHpWME1Yc2phc3Jv?=
 =?utf-8?B?TW5jSm02UUk4OEtZSW04NmZIcmxMeVd0VzdoQzF6MVRjR0cxWmpZUTRCREdI?=
 =?utf-8?B?QVJHemk1TGpDbjYxTzhOODEwV1dscUhVcGwrWktsU3ZHcTVpU2Exbm9Xa2k3?=
 =?utf-8?B?bWRLWGd0ZE5aSUhLUGczQXk4QWlSOGptcWE1bkcrWDRpaHFFUTdjcXB3Wis3?=
 =?utf-8?B?YmdXaHhGcXhXNTZKcnJNOU1mZTFoc04yZitEVmpYNGFjMFErVXM4THhiYVhq?=
 =?utf-8?B?dlg0SENPMzdQMkNWUFR1VGdhRGl4YlgvRE9EdmtkWmZKbSsyVG9TUmEza2x3?=
 =?utf-8?B?bCs5R1RvZmlxRlgvYVFBVTF4UWc2b1l1UGordVpvbDFqcVZLdTJEcTlwZkda?=
 =?utf-8?B?L21MVTRuTEpJTlRoZ3MwUDRKaWUyc1BRUWxrdW1XTW84eVZTd2k5VzN2VVRG?=
 =?utf-8?B?VHNXRVFQek8rMW16SzFQdHljNUdxUDVPRExtMnJWMmJzUkd5WXhIT2pJRjl0?=
 =?utf-8?B?WWpwbEtuSFdlblhuSFVoUHo3QnhGZVh6RFdPYkV2L2dhbVdOMEpCVGdUR0JG?=
 =?utf-8?B?SCtOT053d20zZXUvTTRPS3Ayb2ROaTFzZXFadUF5Z0NIWDIwV0I3WmlpeEJS?=
 =?utf-8?B?T044OWYxNE8vVVlYQUtjMTNRT3NMQnIrNXJsSVhlend1My85NHhxMThXdE4r?=
 =?utf-8?B?ZWdja1VJd2RJTzRxMng4ZDliR0gzTTB6M1NlanVNb0tUblB1bzJsVFFvSEU2?=
 =?utf-8?B?OGZrSFlnNVFvaFVsSkJocXd6VXI1ckt4UVhOUi9ic2pTWVB0TVRmRjhsZDJw?=
 =?utf-8?B?RTgzNXNGQlo1elU5UDUvY1VGem5DczgyNGI5OGFYcWhVVEhTMkRSUi9OaU1h?=
 =?utf-8?B?Zk9rZTVaQlJ3WWZOS1pmQ0JaZ0FsOTRYUXNMbmhFQ1dqUmkrUFJCRi9RRHRr?=
 =?utf-8?B?bWZmaGgwakJkbjVZWGlaaVVUbHB5alFzcHkrblNEdzhtazZ1MXpaNGxvalZU?=
 =?utf-8?B?Y25mNDg0Y0JScjdSN0RrK3k2bVdFUWsyaGhWMjNnQTlzYWNBVkdRWnhFSWpm?=
 =?utf-8?Q?Xr50G1x4MwzBelSGL6EXY71Q/Vv3DGFUYKEq4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am5WcGJGQUNVYjQvUjlMT1pNTmhQVkdTMFF0MEdqejZaRjRtZGU0N2ZaVEpF?=
 =?utf-8?B?QUV3Tm9QS3gzSldhc2p4QTVuYlp3WE5EZVNEaStQWTh6RTd0MXBEb1lPaGpr?=
 =?utf-8?B?WTV3T25ZZzE5TC84QlA3Y1VEOHNjNm15YmpQSnpuaGZvblVVMU1IMlRwUHk1?=
 =?utf-8?B?VmZicmxoekxhM2dKd0xmb1dveFFUZEhXVGJGQnVVNmcxTldrRjFnNzU5amxw?=
 =?utf-8?B?NGNEM2FGY004VTYra0hHaGJPTDA5cXZHWGwrTnFYSmRDa1BOMVBJcVZsenpx?=
 =?utf-8?B?ZHVydlh4Z3ZoSHpjNXE2UHRTMGVndXphd3phd0Izbzk3UGJuNjFmcjYxNTdh?=
 =?utf-8?B?ZForTGgwTUQ1TmFiQUxTZnBRRlZUNys3RG9jc0c3aGFwaWpLN3VnWW1yZXY5?=
 =?utf-8?B?RGdKaVV4WWxvL1pqc21QNE9LYXJZdVpHa0lLL3I0ZFVMd3RKNGNNbzBlbkUx?=
 =?utf-8?B?ODQ2eGNSb1BuWHVSc3ZxL0dXRlhXRy80cHhCRjJLcnlWTG1DYVBzNWk4SlRt?=
 =?utf-8?B?ZFlvNUw4N2N5U2ROTTBrMlBPM2hRM2pvdUMzKzk5Q0d0Sndhc2IyeTIvTGNk?=
 =?utf-8?B?aVlYWFVVcTNwYjBQWnU4ZVN4SWZuQ1RpdW92ZStZcEkvTytrMnU5QmJoSnNv?=
 =?utf-8?B?N3dObzloSE5RdEUxWVExbGNnU1NyazY5emJGR2Z1QW45a29LMjUwQTlpWVJX?=
 =?utf-8?B?UG1qQXFhc1VkUkptTFlGcEllT2VQTlBJUnRKdHZQWTdLc0ZXK3lJUnFUdFo5?=
 =?utf-8?B?c3VaaDdYKzdUaDBSTFczMUVkT0hHQ1RwdElYTVBZbXRuYktOWndQUHAvMGxk?=
 =?utf-8?B?UnIyNnNKRHVKQk1rY1RTNlBCOXlvR3ZzaG9RUXZBSDI0SDNYTVk1TEc4Y0hO?=
 =?utf-8?B?V2hlaStMS2VlK3NMUmNUQkRNZmJ2WHRheG40c2VnQTk1RVRFeDVYYmdNaXZp?=
 =?utf-8?B?TWdMRXk4Z0VQeUVLNDAzWFJ0U0lzUDBPaGYzRFdHTGtDUjU3UUNVSWhxZi92?=
 =?utf-8?B?SDZrL2FrckRFaUozbDR2L1hXbDN3NEtaM1VqQkR6UDdKYTQrSzZaTjNHZHk3?=
 =?utf-8?B?RGpaUG9QNVlJdS9ITzgyQThlQWx2OWtRY2VpZ1JZN3U5bFFlRmplYktZL1VF?=
 =?utf-8?B?QnplSGRoVVNnVTZ3Z2hkMmZmVHlnNEVYa3c4OVRzQklyczkxMFA1Zjc1NDh5?=
 =?utf-8?B?ZkhYb3NMdHBtRTJmTlFaVmdna0t3eXFNRDlTN0w5UFlSbTZqckdUbjJseGNs?=
 =?utf-8?B?alo4RkhkenMzbTY0ZzEwR0pac1FZdTdwOTNFcDZ3cFNzZjJPNHFVaGY0V0hq?=
 =?utf-8?B?U2xQbTFLaE9NZXJMVmRMTWxxeFlHemg0TnVsWWxtWG1Cak9ZTkg0cWJWdndw?=
 =?utf-8?B?WTJQaDZESDA1cXpDRG5YNVo0ZGVZalhHOHpNbThWb3hRNlhGcjZlemswSkh6?=
 =?utf-8?B?anhRYngwNld2NUR1a3M2WU5OekEyQW9ERUVmQTVSNVJ5bVczeGVudmxWUGhD?=
 =?utf-8?B?ZWY4MCtHZEFqS3ppMktFMkszM2NyZ0dQRzVmbzNTdGhXQXdVY3grMm50NERE?=
 =?utf-8?B?RGNzb1Z3OFhBbDMvbGRjQjlFOTNSN0Z3ejdEVituVXl0TUFlMDZ0aHk2aW9l?=
 =?utf-8?B?Qml6UTQ2RUZxSXZIMWtRL2pTUGZrZmp0eHBPODY1YXdYRWVJNFZGeE02R1Rs?=
 =?utf-8?B?YlNpQ21QK1ozYnU5Sk1mOWhrRUVqcGVhRlljS0w2RU5WVVd2cjlxLzN4Zmcr?=
 =?utf-8?B?WkhMa2N2bTE1TjJvV3J3ZkR5aXJoTm40YVBnNTBxQ3lKbGcraW1Hc1NXZGRI?=
 =?utf-8?B?aDhhN3VDUzh5bEpCaCtWQkZWT0cyVXRYaWN0a2xHaUl0Ulp4TlRDWWVZZDZh?=
 =?utf-8?B?MWxzMlZEVTI2T1pWY0Iva0kwRUhtN2Zyd1IwcHlINlM4SHZZMnNsMWViQUky?=
 =?utf-8?B?WEowZzlxYUpkVndmZVExUkF2ZlpYU1I4bUdiNXpSb2FVU3RSMXp2Qi9hcnBW?=
 =?utf-8?B?SU00d3FMWk5ySThNLzZrb04vTnBkbUMvK0s4OUQ3ZDZUUExzUCtaVlZpSU01?=
 =?utf-8?B?dEpyclhtckdjQjZFQk84TU44ZHpKdXdCdzZpeko3d0ZpVmtSd0VwOWVnQ0h2?=
 =?utf-8?B?R1Z4cTRYZE9laWpaZzRySGJzdldLaHM0eVpPTVVtTmNnbEpVdkdMeWZRYnFZ?=
 =?utf-8?Q?QvZuY/GEDCikEElHPYUUbDI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9497ae3-8275-4b1d-611e-08dda8521754
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 19:07:49.1939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUl8tVH58CU8jFQvlX92UoQkvj3V3WZ1iYRC6X9OP96w7g4vY8MgpjOrudGWQMQ4jaOlmXbm0mur6hrv7fAir9NXvMQvD3VVDQcTRfMucCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11207
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

This is a stable release announcement for the LTTng kernel tracer
(LTTng-modules) version 2.13.19. LTTng-modules is an out-of-tree
kernel tracer for the Linux kernel.

The LTTng project provides low-overhead, correlated userspace and
kernel tracing on Linux. Its use of the Common Trace Format and a
flexible control interface allows it to fulfill various workloads.

* New & noteworthy in this release:

Add support for kernel v6.14.2+ and v6.15.

Detailed change log:

2025-06-10 LTTng modules 2.13.19
         * Fix missing override when CONFIG_COMPAT_OLD_SIGACTION is not defined
         * fix: writeback: `balance_dirty_pages` Respect `CONFIG_CGROUP_WRITEBACK`
         * Fix: scsi: RESERVE and RELEASE renamed in Linux v6.15-rc1
         * Fix: del_timer[_sync] deleted in linux v6.15-rc1
         * Fix: Use `nonseekable_open` for proc files
         * Fix: trace_balance_dirty_pages in Linux v6.14.2
         * fix: version constraint for building lttng-probe-9p

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

