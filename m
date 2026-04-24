Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DF9FED3F2
	for <lttng-dev@archiver.kernel.org>; Fri, 24 Apr 2026 19:52:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4g2NsR1vwfz1s7G
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1777060349;
	b=mChKiSpSpSmviVbbsR+m28Xw5vomiObB/57EY4h+y/716Mvtt/EoGeEfBnoXtiA4ZPyM
	 wbOb7pGRlPlIH0cvqUK0AKX1VUQbaej4AFHFjU8wP2jny6tLvAksN6qMfQnacuyvwlw8D
	 zqWczTCLS/M/M+X0b8e93mZVdWQqJeEnE8KCE8qRN7zxNTkTKTa2Fy9uh7W8fyADyP/MF
	 1hvU0HhM8+4xcHYQYZ12ToliYrs7fCFtrd2y8KXcqVXJ6ZV3/kZ57AiisYM3vm/Mcjxvf
	 dPMMH2vQo29CsX6wH3TIAMsM5HBwjR7fgq4PZoP0M1N7Vm/l96jFqTziIVH/lh1dHlw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1777060349;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=6By0bKkyHsv5AeuP1tvxt3R4j+aWxAEmbhcC6aTG0Z4=;
	b=Ce58g4TNeO6/KHmoVHo4fOL2+1UvI+VveQlfcxqL6vZlD/dhb6WS3TLVIo/KxO9Hrebu
	 QvQi42IlyvxdLRrdVGESwxTOor3T960boIGRM70JqY4WebzhaBXivKUOKYw5EIte1p8I2
	 SNy8MIdoZd1J25I0SMmNeImA3Z9USQCmmKAoaLi5neSS12GnKJYE31Rw0eedrob7KC0TX
	 l7knuDk7PkgE7gQHHI12j1iTcHbvy9Cp9eixxasW2Zsk8oT8RW89kJJiay80a0ZP5wVEj
	 xHbYXyLp+kB5mJEPM/zuWrXsm5TwF7eLCzPBhnzOAIFTlFOyoc3VLH4OpxyKpiEL4dg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4g2NsR1vwfz1s7G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1777060349;
	bh=sAP7eT8/PoHkFPUGIn+ygwYcu3+wx+SXcH33/MTmQtE=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=sBMxKKTn5Y25mAqy4PlFBNx4hIb7YF4+TUlGDW1hsmivxkvN/RX+rLXn8F3hQRVfm
	 1SygyYF/AV4RDsuhJlsXDFmGZDAcY+V1bZeZai+ETNk0K1mO1z43r7ct2wDhXKC4w7
	 e9v334OiWEEQGw8JksofkrzsaC5N/E58D1pxohWNr7txUsjmYyFM4hquEgAbS3QSh/
	 /D/4ROeSO3CMXNBS5T0dTkhhT7/YV447f3QZqV3dURS14jhM/Z49k/jcsZOcYVw4DZ
	 06+WWNcPxtnIs/MYX0fghMTdzCEvZw1f/7gTX7w0QGzF+vYBB7Uu8pFCyYEtrBph5v
	 zKhU/X3BgHL7w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4g2NsR1vwfz1s7G;
	Fri, 24 Apr 2026 15:52:27 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4g2NsP2RTVz1sS3
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4g2NsP2RTVz1sS3
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11021105.outbound.protection.outlook.com
 [40.107.192.105])
 by lists.lttng.org (Postfix) with ESMTPS id 4g2NsP2RTVz1sS3
 for <lttng-dev@lists.lttng.org>; Fri, 24 Apr 2026 15:52:24 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkOuaQWwQKKn6FTtGMb/jtkvZrdgPbO5vwVDfNdN3pCaMRwonaiWLa5gU9311amOx3fJTboNbq8JlaroSmFN5ZaIpxwwKJdZKpPazzyGnNMkF1ZaMGS98q6uDjPO4qHCC1HFaNbJP0YcLZtG/5nfUR7Ap94qcoIyqv+w0tSaHrNGL360kgxx1S5HncDd8J8w0lA7fzm+S9Ztgu+mrjW87TP3PULyp1jL603s+sunq3R7q5HCOkO5etGKvN91CTJFmFvLUOc/eESl94y2BwkNtHimTw1bf4kZo5FOVfEjVh9xHVtjz/cK07DNM7yoMZGwUeDQbmXXTJe+nfkaIWD6tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAP7eT8/PoHkFPUGIn+ygwYcu3+wx+SXcH33/MTmQtE=;
 b=L0aj3snNNmvEND5H374cpb4fEbApZm9YWMJDIqn+HxH67yUBq7XFU/cZUQmqY3PDZgukW3cR1G3h9MlsU9WUnxYLuYFrygTnYTZnf9nHd4saq1S4vJaA0/TSGZPKPKPBTk1TzQl+BSkC9Wif8xyLEbrnne2FdcxWbT4F+8D/e1XrfF33zBKsslqAYqwuQOJiJpJU04ntcbVV3Q4WjnxbzsIddkRwFS/AEbEVbxobUpbcG2dneXJwJJ2Y6Xnh1BTr034jRgzCgvk+/oso+xegCcJKjg0c9FUvLyd4SVs5fHF0eRDHzUfGd7MQyGMu3P8AVzzsOslr2JgG6WovDg9TZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB6350.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 19:52:19 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 19:52:18 +0000
Message-ID: <7192935f-d79d-4bdd-9716-6a2a01dae7ec@efficios.com>
Date: Fri, 24 Apr 2026 15:52:17 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-modules 2.15.1 and 2.14.5 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0320.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a8a949-71aa-483b-9651-08dea23afdfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: d52vYDj+deAEvwv4k+ojogcRLy6jGTR9Gzyw1FacIMyA9tUQZidFf3xqjQtZ+2vbJSECLfVveHqsqXM9rYqJ2k5BeilUEXoGXFtvUvhr2VS3wTUfWjyYhUDTfOGHkkd14zBm0iDiAwfouF9y8OdmpbnE8M9DXpQQZwaO8zgrMfatNXvQXlEKoEEEQf/yc629+aQN/C+bvarAa50QPTb2j00LVH6Yz0VTHn2FOzWI8SJUg3ltLnOMpZAt2kAJahRk3BCloImipjHb+9HhmoZP3cMQ3A9cXVEf8Mr/OPWnJI2BkiWY3fwsip4wmfE4cca8d02EpaItdv3CT5IkIxdJbQoP12vxV3Brhr3y2zKgO6pEGvddmgtvMc7FeHO/OZtNqKLWVXTXzimZs/X8bzN6kIFgM1uztnSMkbiAlyv5yoCfK9gmZ4Jhi5Qp54Dwg1ajS3H8infXaB2+pHXSUXnBEcoLX6vl7BhkdxkPCfFl+UP8tSAYstEvbDHdDsoclP56zmJHt9ze7wTiSsL7dj+B0WOhN3KAELE2+XMdST7YDBzTNZ+eUABy+k0h7NJOawhrDVAtlQHOqNw08yXm5VOKgWBddHpKsLZkGJao3y8rno4gwwygS7SjN9lfRJOuW+f5CIhIKNtzGzJGMivycOiBQd1rcgW6oqKoyFPNfQEi9PE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXZqYXZtWUMxcFZjdmVtbzFpaTlXQXhoUUh4NmJmTWQ2ZGV1MjR1WXNmd3Ez?=
 =?utf-8?B?Y2h5dmVTd2pzVXEwMHRxUyt0ekFhNXlIalFOVGhFWG1CdzF6UGVCQjFMUWdC?=
 =?utf-8?B?UmpqbVpMNkxOTkptVUR2TS9KS3VSYlVSSUFFNGgrdEpxRWJzREdNeFpnbDJv?=
 =?utf-8?B?b2dpaDB4UTY2V1ErcnBrWlpVVi9tYm1VZjMrUWpabWJMZkt3a242TXlyQXJD?=
 =?utf-8?B?aWZHS2NQdHZ2ZVNoVXkvckJ5V285eHR0SGVuQlFaKzV2aFdSc0dyanBDYWY0?=
 =?utf-8?B?ckI0SE9aYVVxNzVTYUwvV1hDS0R6ZEFKZmFXMkVuNFpuQ1NMRWxkWVJ4Ynlr?=
 =?utf-8?B?NUZHNitsbWJIaG9tRXNIczJHakpvK0pQajVESXV1Wm5mN2xXNDlOVWxtK1JM?=
 =?utf-8?B?SUFSVSt0K2JCN3I1M1NQekJMbkN1QTlVeDBLYjFaT1hUUlFtRHVvdXk3Wkw4?=
 =?utf-8?B?anJ2VStSSW44RWVYWklia1V0Tng4Y1FyYmVFNUxvWXp5UmpFdkU0M2xqWFZt?=
 =?utf-8?B?V2hYVDVSS0NNUDVIVDNHSHl0K0NSR3R4NDJZK2FwWXZSckJ1SDU2SDdjUGlj?=
 =?utf-8?B?V0owNUJsTVk1dmFPZkxvU0FGTzE0ODBGZlFWM1VvRC9IWVV2V3o5U3FaTUhZ?=
 =?utf-8?B?bUdLUFR0S1JEYmE3aTQvWnR6czl2dDhxK0orRlhRVGlURm9POG00Qi9Fbkcz?=
 =?utf-8?B?UFg0emJTSFUyRHdnWVhWaFIrSGZlMFoyZmRCbXBCb0R4ZXZzT0grbGNIN2dp?=
 =?utf-8?B?NllnaWVtMUxlZW9KODdNaFlLcWN3OHVheUc1SVRzL2dndVR3SlBtYkMyOUJk?=
 =?utf-8?B?YWdwQlZPQTBrZjROZ1Z0QW1QWWhuNmp2b2xTdVdUU2hycDFoV0UvOHY5Vi9X?=
 =?utf-8?B?RFNhSFFkYWNBcUVjdWRyaUxOZTBCaHZDK0xNcHlwaUdWRlVWRm9PY3NRcW5O?=
 =?utf-8?B?eTlDTW13bmErQ2lkdkxKNzlkcDdoaTdHaVJDY1o4RDUrelpGTENjVDJPQkpv?=
 =?utf-8?B?QjZvZzNMZjNPSmEzV0ZEM0w2b0FSTFdWVkE2MHliV0FycmdkR3RPaEdDVXJo?=
 =?utf-8?B?cEhQcmgyUTdTNEN2RlJSZUpJd2dXbGZsWkVBbThHcU5lbE4yWDJxS1BkRi9y?=
 =?utf-8?B?K3RHRGZnMFJscEI5OFZ1eHNrd2lEeTd2Y2pPZFVVZUJFZFNCZ2VTeXBFdFZt?=
 =?utf-8?B?MDc4MWJHRTZweUp3dE9JakZJSXVZRTFlNFY0aTRUV3NvTk9mYVQxbThqN0kw?=
 =?utf-8?B?Ry9vWEZWTzhEd3BnblJ1dWtHR2FycXVlcFkvMmFZcFR1eVVHV3liRnh6K3Vv?=
 =?utf-8?B?QlI2eVl1SDR1Q3BXY2JRRUx4QUhCRy8rSWhKZUt2dzk1d21oN0FnTDZPZzVh?=
 =?utf-8?B?MHovZVJkeUdydk1rWGl2eWI5RXZBMXZsWDJOSXZNbkNOVGc3L3JlQzZXTmky?=
 =?utf-8?B?bFVvMURnclcrZVpuY2FHaEZpSHRtek83dGp6TjlPakxLbk44cGN4Nk9iUjBZ?=
 =?utf-8?B?dm1QbFMvbzMzVVFBNzQvWVk2WmxjRU5FUk8yeVRXcld2alNUWnN6bCszMlFx?=
 =?utf-8?B?YzZ6QkFZQ2E2T2dLdU43Q25xWG9qYmMyS1Y4dnBERDZlMmlnTWYxbk9GdE9V?=
 =?utf-8?B?bTlyV1c4R0wvWW5rMDNYQlFMOWlVbFFmNm1JRVQxSHRpbk1aa0xjS1BsSFBO?=
 =?utf-8?B?REY1aFJrTFV4NDc4OTNVL2xabzdLMGQ0d1dVT1JTOXpzSDlrbHJOUkdtVnAw?=
 =?utf-8?B?eUZyU2J2SXVmRDAvek5tMGlnYXgwbzBjaUNQTjk5RjNuMVd3eS9BQWlXRVU2?=
 =?utf-8?B?RlkxWUF3VlVPdFJBOTVBM25JUWxvNnVLYUZvNVM1Q1BFbmRmQW5WQitMSmd1?=
 =?utf-8?B?c3R2RFk3cE9UeGJnd2w0V1ZhTk91akY2dlJvRFd0MTBoTG1mNklDdjNsSFQ5?=
 =?utf-8?B?dCtURCtjSFN4YUNkQjVmeFFqWENhamZybUdRRUNMU3pvS3RqQ3Yzc1FuUFNP?=
 =?utf-8?B?U1VqMGxLUTJzK1FoeXpvekd2U0xDbDlOTlo1akRwbk5EakN2MXVMWldqbDNj?=
 =?utf-8?B?U1FyaGVFTmkvemk2TUZMbk42V3Q5cEVuZXRVOEVOSEpoQ3JNVVBlbnZBSzdq?=
 =?utf-8?B?andVbUpEakZ5a0FkL2tBNTIxNHNKS1c5YmFZNGpsOENQSXlYRHEzb3F0VThv?=
 =?utf-8?B?RGhTNWdyb1BCaldHNDNCYjA5NEIxek5JUkJxUnNuRGJZM3Nvd1AxcjdSZXYy?=
 =?utf-8?B?bEFVOFRDQ2NIWGRHak1HR0paNzdxKzNYZEV6bDRVUm1DNnBFUEZIRzRDdFRV?=
 =?utf-8?B?ZWk4M0hlSnZVaDJJUU1mTW1WTnNUekcwQkhXS29ZSGZmSk1ySU03bktncWcy?=
 =?utf-8?Q?5ocPXY5I0llxEKc8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a8a949-71aa-483b-9651-08dea23afdfe
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 19:52:18.8462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNZrloyVRieQj5aLe3lpWRf1DI97jnIWUFEhai5MnSvQcAQZUhQJr1SWV7BksWa0HshufLUpU+YY4hIbhCGtmt+2ePX1VkzetHzbetnD+WQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6350
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

Those releases include minor kernel version enablement changes for Linux
kernel v7.0 and v6.18.14+. More interestingly is a fix for powerpc64 ABI
V1, useful for those with custom distributions which rely on this
specific version of the big endian powerpc64 ABI.

* New in these releases:

2026-04-24 LTTng modules 2.15.1
         * Fix: kallsyms on powerpc64 with ABI V1
         * fix: ASoC: soc-dapm: move struct snd_soc_dapm_context (v7.0)
         * fix: adjust range in btrfs probe for v6.18.14


2026-04-24 LTTng modules 2.14.5
         * Fix: kallsyms on powerpc64 with ABI V1
         * fix: ASoC: soc-dapm: move struct snd_soc_dapm_context (v7.0)
         * fix: adjust range in btrfs probe for v6.18.14

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

