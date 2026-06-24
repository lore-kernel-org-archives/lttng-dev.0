Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7192CDB47F
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Jun 2026 21:00:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4glvTL1rKHz1lZx
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1782334808;
	b=TRmUGKWzKn99/SjHb4tJesVnt9l9FeIdkv9NVgtvzudrLV9+SQ0jG+fi9CH/dXOHO5sM
	 +JNRJL3PG8LoXf/QkJudN17UNh0WXKu4NrpPs/QlwAEGWoTJWf3EdcUTshV1C/vUiq3ry
	 zqB5GsYHrg4Wh0jlL9BXims/OLPYECTl6sywR4oS7N5j8uXjcOysCgIhXdXrbt+y+CQ1f
	 IoRS9poQVPSr15d5EpHoK07NiC1TOutZjTvdxQOngETGEQt7Ef0L8CicR19Y+NQRY/sRh
	 RZNYHaLfLqMfte9Jct7J9htnaye9nK+2kyGIudArOnp7CDqfYe10C5a/qMm6xzSiTJA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1782334808;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=SmTwHdK8GrLWJ/FddYYHOUnqbXlUSpmhKOHlsqiV/dg=;
	b=UQPvmwqxAKwiSun+TEc1h4F7LzTOZmW7MmLe+eSh+imHu1m1KnJVUGFa4enF9dLM9ktQ
	 bR9FyJkPT8rILt0lctIwRb2CgR/WOctLY4e1LcVdHbZF9qk4LiqUyDX5wIYKz81sdd0ZD
	 sgv3ppCB4jsdzKTrHEBakEOJPXNU0FFz6SCJE6OWh7bjBIrHfDR1EfWQVk/vD+6TxRJxb
	 Zd+uMhtJfolJT3WbybpNqZE8liYjl5MLKSyFyJEOiGXq+KXguDLT6G8x0w3i+Or4H0/qD
	 mCIa6lv056bUQ/8uUbaVD0TUX9sdGdHBhdPVkhcrdYLPgu3WZJrgjU9rA2/af0t2FaA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4glvTL1rKHz1lZx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1782334808;
	bh=AwU+Ao0kGtmnTD2Kl8s1LSr5f8mWSJwOf63MpM+2Iyc=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=C6VJJkLr/dn4PS4XofqE3NwmIhvdDKGxUwgexGMVDWstnG/2jjNZ6ahkG7jcgQm7b
	 V+KJ3oqKAZTGyMW/5cVN0eHJJeGSRi7tIhfkTe9HbZkM4JkGxDZWJ8m1dgEAhWB8Ff
	 A/Bz9JZJa8ync/T00D0Oluj5UrAum88I17cF3pb2e0+iXyoCLIslV9DfxgK+m2VBBk
	 R94n8dWZ5dGM7t9eYlSEYseNltURonLRBC3iCk5KHTLKFwm/hyg829wcO6MzyauTkx
	 BVHemlycvqenfEiBSxNAG4ucRZEV5QBgIxoGX5dOMiRrnKHjBHJ7dscTO1+/R+37UD
	 h/DkSKBm9thjA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4glvTL1rKHz1lZx;
	Wed, 24 Jun 2026 17:00:06 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4glvTJ1Rsjz1kgY
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4glvTJ1Rsjz1kgY
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::3])
 by lists.lttng.org (Postfix) with ESMTPS id 4glvTJ1Rsjz1kgY
 for <lttng-dev@lists.lttng.org>; Wed, 24 Jun 2026 17:00:03 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQwWvCE7++paLZS5vksOIpaNSGME91XN8eKn587Hshq3HI5S+/NjWRGqx5nLZ6g147KNj6FJCDy9aLtMUSaK81OLvBPaWLRSkLm8zX5y+u+gXbhH5UH/ZgW4Un74CzQbZcXNMwqqR+q5QyjU6o9E9uupV3UNdMdDzEnpaohUJ8RXNlhLAl9BcctvuASQ0P9ELfJFm5SB9xZ2YeNMvijcDZYlgbO+Cur1prsorTJGIUBHeRFrSsWvmn7aVecVaqZR8GR7aL2A+X72Ffy4ftyPASmLqcs5lTy7eimtEvX8mRdx1qb5KHt8DU/CxBxbDxKWfKL+z5BesGSrLRgPmPbdiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwU+Ao0kGtmnTD2Kl8s1LSr5f8mWSJwOf63MpM+2Iyc=;
 b=EkoRIJQxi+7P2JQKy4sNqDqrrPPetMw/x9Q+HWviG/x7/3wiHVXY/F4di7hbNJX29rVhgX9QFntfAYwX9rEMyO/a9DTIumDtCWX3/DbSe8IGqBk/7sXzo66V1ATLP0Agvpc9XZFNSnJjUVfz7O/ZsRwR/c1w9ABXXOxlWm9Qaxfy640R76TiIS+oRDg9AS0oQgzkKQ3W8pjZb4MvuOH16qYKsLla78qGH3eJF+aPl3XDgVHaPVIo22FN50Ux9/co9ppzbcnr+KPGo6X7kl0MSRXE5bzLyHMoOlvGBpYxHKlmJ+8f+XrjxsTC/qp4rfKNT1bKujcmwqDxauOCEudKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB8313.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.5; Wed, 24 Jun
 2026 20:59:58 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%4]) with mapi id 15.21.0181.005; Wed, 24 Jun 2026
 20:59:58 +0000
Message-ID: <bd14a9f6-c7ba-48c6-b429-9e4533e101e3@efficios.com>
Date: Wed, 24 Jun 2026 16:59:57 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: lwn@lwn.net, Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Subject: [RELEASE] LTTng 2.16.0-rc1 - Question de Perspective - Linux kernel
 and userspace tracer
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0017.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::28) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb2f293-c63d-4298-b88d-08ded2338d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|376014|6133799003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: fy1ADG8NgFDRafZvpZnbXBVKJ2Jwz4iMGhM5fk5zV//4h3hK8UadeeUQL+oLjdCn8733+K+2rqzggQ0rKhsXh/IrrIY20Lqw7wZb/Hv2xa1DNwlZAwgB+Lu3cX8MQOqeXkLvX2MmB19Ns8mJKeUwzUKmM8qZtFm+HHNumc32NGZJPjQK3DZyneFC4wcf7gaFVtxPEzohQZxJHOOSJjzvzMPoKkXUU7n70xUsEplbI89WBlRDatHdR8yjZP94it/N6SXacwL2o7iC8bZ84AQrcNR/Inn9nu4ZYd5CiOOPP1sQt+i5HqxeQMupdhGkhyUTAgIz+bKBjs+1TigStZB78/uRnI+oTLPVmkZdV9h1G6iRcDbrnhiSrdIc0PM2kK4zcKi08ZZMl+IBPyJONjwTMhTq0HowPfX4pOoU4JKmWL5WEF/Iokv9nvDkv0w6lN3+og96uBSsrOhUJtbcsl3NWARRU7/Cr70IDwemcp1x2dyUvcOjx6j/W62rlG0JppJdAdcgJapd294MA3OW1Mkl8VJVIrdHu8XQGlyn4OTOTwpyNmkJ1M1vXH5Obc7D3MJ4/8278KyexdLL5OCMpmK7phuX5tuyYHOEwXKVLfud5IY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(6133799003)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3JaQUU0cWFLaEErcWpXQzNTbWJTdTZFKzM3Y3Y4UEpxY1hzWitjNndBK1E2?=
 =?utf-8?B?ams1clhBUitSOUhUZ0pkY3I0OVIzc3Nld1JRMzVCeTFMcW9yeko3bURRU2xx?=
 =?utf-8?B?aFp5aFlqOEVJL2F0cE1Zd1JUZHVKL2JIK0NSdlRIMDVxaCtnbmRSaUt4Kys5?=
 =?utf-8?B?S1JqMHdiR2xZQkZWM1hoa05rVzVBZnp3VEFZK2NYcnpYeHVPRWloSDdEK0h3?=
 =?utf-8?B?Nms5czRhSnczNzRLdmRxWmxQUnAvTGNXWnZOUkQwZTNMS01hcmppMnJDZUJi?=
 =?utf-8?B?d2ZveEIvcFRmcTdTaGw1dDRNMEVoRFZ1NTBxWWtzRUY0ZTlPOEErZEV4RGxj?=
 =?utf-8?B?Umh0b2pHMllQTWlXSkZyWGV2Rzlxdjk4RitkMzNtLzM3NEhHRmlveGhDbElO?=
 =?utf-8?B?ZHQzNVVwbjk0ZTU1WG9rckRIQzNQLzJPL1ZCVkh2MEh2R0lveUVsOEtidnNu?=
 =?utf-8?B?SmtIZTVyUkRkN1pWZWRUZjVJMHNSZDlpVW1HYnR3SE5aMm5UclpIMXd3T3U3?=
 =?utf-8?B?cU9URUtQbWZuRHZJUUJOc3B6dlRNczhJcExyVlpJaDhxMlJOT2g1TmdMaTlj?=
 =?utf-8?B?cS8yQUZyYTFkYlFuU3U3Y2xuL2dBYnVHQ0Y3R1JQOUl3NzZxRnRMcnJCamdu?=
 =?utf-8?B?dGVRVnJWa3k1YTR6VFdNUUpFZzc5TkVWWFdZMGxvbkd0KzA0MUVKVUFVbUky?=
 =?utf-8?B?bGp4aUkrRmplM1REY1BUUUJoME5uNkdxTy9DcG10cGVKZGUxd3hYd0tNZFhE?=
 =?utf-8?B?eGVNdTZvMnQ2dUlEOVpOTFFkRTNPL2dIU2RONllOcUFGN0tTQklCc29mSWlX?=
 =?utf-8?B?Z25MVWJVUURUa3BvWWNzTFhWNmlXZDlMb3hpdERzZ1l6S3dTS3YwMVJUNWlz?=
 =?utf-8?B?cXFFTE82TEU5UW8yejJRemg5c3ZlZmxzWWxuTG91NkswOGU2bFMzYi9CeGtX?=
 =?utf-8?B?aHFDd3VUUkZZL2NQYlpoSDk1UG0rdHB5WElsdDZXMlhOTXdNOFVtaHJNZjVZ?=
 =?utf-8?B?SGZsVUtvYS8wUlZNZ3FTUnJlRHVuakpQNUdPQXBHOU9CRVRlMy9RUDJYTytV?=
 =?utf-8?B?SDk4YlJXNVZIRzBkMVpWazVQVDBPSXRPNFIzUWVsU0dMZ296NjZFOU5jUVdR?=
 =?utf-8?B?SGk5bUU3OU51OWE2MHdBRlBPdUVFQVRMN3c1UEJtWVgydi82b3JXTmdqbkdO?=
 =?utf-8?B?aXRHWTY0cGlQcGJrTDNVNjNLdGpqdit3TTdhYUVwa3dNcVgxaVlEMDY3VEs4?=
 =?utf-8?B?R1NoemVYa2t4aDV0QXM3VzBMUmhQQXB2K0Vpa1l0cng5OWwvN3BTY1l2Ym9N?=
 =?utf-8?B?Y1V4Z1M4eGlOaGsyMkVmWVd1OUJWbjBlOERodzlsWUhPTU9qRXA5SXY0djRO?=
 =?utf-8?B?c2h2SC80QW9saGV3NmZOSlhjMzBPUUVYb0NRUzhwMXBMSyt5ZDZKWkN6ZUdj?=
 =?utf-8?B?ci92WVBWaWVqUGJYZnNLSGVnU0ZuQjJRWUFCaythOS9lajVDVzFNd3gvZ1VJ?=
 =?utf-8?B?SVVQWTFtc1ZyUVBRWEN0VEpnL0YwTHFzc29OMDNVdDNabElETE0yTXpkY3N1?=
 =?utf-8?B?YjU3ZUZVa2twa3NrN2lUQlBkRmgrT1JHeWErcUNKTmdKeThiVWc5bFNZNC84?=
 =?utf-8?B?aFh5Ty9xSFpidWxVV01MRnhQVkNJV2o1aGJxS3JEQXM3cVg3czF4bEZFQzFm?=
 =?utf-8?B?dlVISVhGVnh3K0E2Q0JWc2piaWdzNDZ3WUcxMzhrVWhwYTkwb3dJSS9ieW4v?=
 =?utf-8?B?STJkSUdBUU9MRThEdmtNSHNOVGsyRnJnT0MvclBReUFWZDhwMC9vSFBiNkZl?=
 =?utf-8?B?djRabS85Tm02amRTN2hEcUpuQThQZjdnOS8wMjZlVmtGMkZRbEhBRFYyeW8v?=
 =?utf-8?B?VXNDNlQ1ZGZBYkdCU0VWb2tyZXNqNVhZTnVaWUVhWUJkMjZaU1RjemxzNEw5?=
 =?utf-8?B?aUNJdGk4VmMwL2paQndpSHEvR0NxdGZVSFpLTys3T2NhaGNUbVdVMG4rTWhr?=
 =?utf-8?B?bnBOZkRyYVRld2NSbkhwRVd0aVd2czVWTXUvUm1MTWdFOForb3kyN3FtcnNR?=
 =?utf-8?B?bkJEYmUwVFVYMXVyMW9Na3g5YzE1dmZOa1l5UzhucXFEM2FGWDFZM2VZYlc1?=
 =?utf-8?B?S015VitpS25FYm5lc0dhdGFydmEyWjBNSk83aGJVcElneE5PbUhBbGFtYytQ?=
 =?utf-8?B?aEtKd1VQK1NzSUpycnZ4SGw0S280ZWNBRDZZOEdhSkN5djdnQlVtWWFxVlox?=
 =?utf-8?B?NFJHdS9wRkNDUFlYVDEvZXB0OGlyNDlnZ3RmS0hVbisyZHhQSXE2WTJGMnMr?=
 =?utf-8?B?cXBhclk2bSt5bS9oL1lrdGZEN0FCdzBKUGpOeVJ5S2VFb3RuLzVxS2Q2TUhU?=
 =?utf-8?Q?jDxXewZnfQPERVt2W/AzlQkVaFBquytc608ANcNEFTAnP?=
X-MS-Exchange-AntiSpam-MessageData-1: tGf/+bYO55sh08ToZelsXK06JJEkbQCxsD0=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb2f293-c63d-4298-b88d-08ded2338d00
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 20:59:58.5950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQRd++/5FRRqHka4qLhdTebwvVhUh21JXuDxTeMkj0xgSvamsmYqf4Z9DcWl4xIDT+KA4IDRSSES0nxZ1ysRPD91h/aEJVEeVYI9R3Z2fbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8313
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

Hello, fellow tracers.

The LTTng team is proud to unveil the first release candidate of
LTTng 2.16, codenamed “Question de Perspective”!

This release introduces _maps_, a brand new way to aggregate live event
counters directly within a recording session, along with BLOB fields,
trigger persistence across session save/load, and other
thrilling refinements.

Aggregate live event counters with the new maps feature
───────────────────────────────────────────────────────
Maps are the main feature of LTTng 2.16: they add a new live aggregation
path alongside event recording.

Maps let you count event activity live, such as how often each system
call fires or which events your application emits the most, without
recording a single event record. You get a high-level view of the
observed system at a fraction of the resource use of recording
every event:

     ┏━━━━━━━━┯━━━━━━━━┓
     ┃  Key   │ Value  ┃
     ┣━━━━━━━━┿━━━━━━━━┫
     ┃ read   │ 48,201 ┃
     ┃ write  │ 31,944 ┃
     ┃ openat │  8,127 ┃
     ┃ close  │  7,930 ┃
     ┃ mmap   │  2,615 ┃
     ┗━━━━━━━━┷━━━━━━━━┛

A _map channel_ configures a set of per-CPU _counters_: named integer
values, keyed by strings, which accumulate over time.

Unlike an event record channel (new terminology for what used to be
simply called a “channel”), a map channel doesn't record individual
events to ring buffers; instead, it maintains running totals that you
can read at any moment.

Map channels and event record channels are independent and may coexist
within the same recording session: you don't need a dedicated recording
session to start counting events.

A live tally like this is a great way to guide your event recording
setup: once you know the busiest events, you can pick which ones to
actually record, size the buffers of your event record channels
accordingly, and pinpoint the real sources of tracing overhead instead
of recording blindly and sorting it out later.

Add a map channel to a recording session with the new
lttng-add-map-channel(1) command:

     $ lttng add-map-channel --type=user my-counters

Then, populate its counters with the new `incr-map-value` action of the
lttng-add-trigger(1) command.

The example below increments a separate counter for every user space
tracepoint event, using the event name as the key:

     $ lttng add-trigger --condition=event-rule-matches \
                         --type=user --name='*' \
                         --action=incr-map-value \
                         --session=my-session \
                         --channel=my-counters --type=user \
                         --key='{event_name}:count'

The `--key` option is actually a _template_ above: LTTng substitutes the
`{event_name}` and `{provider_name}` placeholders for each matching
event, so that a single trigger can feed many counters.

Read the current counter values with the new lttng-show-maps(1) command:

     $ lttng show-maps

     Recording session `my-session`:
     User space map channel `my-counters`:
     ┏━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━┯━━━━━━━━━━━┓
     ┃         Key         │   Value   │ Overflow? ┃
     ┣━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━┿━━━━━━━━━━━┫
     ┃ myapp:request:count │    12,043 │           ┃
     ┃ myapp:error:count   │        87 │           ┃
     ┃ mydb:query:count    │ 5,920,377 │           ┃
     ┗━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━┷━━━━━━━━━━━┛

Sort, filter, and slice the output in many ways, for example to show the
five highest-valued counters of some process:

     $ lttng show-maps --channel=counters --per=owner --pid=2860 \
                       --sort-by=value --sort-order=desc --limit=5

     Recording session `my-session`:
     User space map channel `counters`, process ID 2860 (`myapp`)
     (64-bit int. values):
     ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━┯━━━━━━━━━━━┓
     ┃            Key            │   Value   │ Overflow? ┃
     ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━┿━━━━━━━━━━━┫
     ┃ myapp:request:count       │ 2,481,005 │           ┃
     ┃ myapp:cache_hit:count     │ 1,938,712 │           ┃
     ┃ myapp:db_query:count      │   842,330 │           ┃
     ┃ myapp:cache_miss:count    │   220,118 │           ┃
     ┃ myapp:error:count         │     1,204 │           ┃
     ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━┷━━━━━━━━━━━┛

Or to break a single counter down for CPUs 3 and 9 of Unix user `paul`:

     $ lttng show-maps --channel=count --per=cpu \
                       --uid=paul --cpu-id=3 --cpu-id=9 \
                       --key=myapp:db_query:count

     Recording session `my-session`:
     User space map channel `count`, user ID 1002 (`paul`)
     (64-bit int. values), CPU 3:
     ┏━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━┯━━━━━━━━━━━┓
     ┃          Key         │  Value  │ Overflow? ┃
     ┣━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━┿━━━━━━━━━━━┫
     ┃ myapp:db_query:count │ 612,489 │           ┃
     ┗━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━┷━━━━━━━━━━━┛

     Recording session `my-session`:
     User space map channel `count`, user ID 1002 (`paul`)
     (64-bit int. values), CPU 9:
     ┏━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━┯━━━━━━━━━━━┓
     ┃          Key         │  Value  │ Overflow? ┃
     ┣━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━┿━━━━━━━━━━━┫
     ┃ myapp:db_query:count │ 229,581 │           ┃
     ┗━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━┷━━━━━━━━━━━┛

Power users can go further. When you'd rather query the counters
yourself instead of relying on the fixed, human-readable presentation of
lttng-show-maps(1), export every counter of every map channel as a
self-contained SQLite script with the new lttng-export-maps(1) command.
Where `show-maps` filters and aggregates for you, `export-maps` does
neither: it hands you the raw data so that you can slice, filter, and
aggregate it afterwards with the full power of SQL.

Pipe the script into `sqlite3` and query the convenient `vmap` view. For
example, with a shared resolver library feeding `resolver:cache_*`
counters across every process which resolves names, rank the processes
by their DNS cache hit rate, combining two different counters into a
ratio that `show-maps` can't express:

     $ { lttng export-maps; cat << EOF
         SELECT owner_name AS command,
                ROUND(100.0 *
                      SUM(CASE WHEN key = 'resolver:cache_hit'
                               THEN value
                          END) /
                      SUM(value), 1) AS hit_rate_pct
         FROM vmap
         WHERE channel_name = 'my-counters'
           AND group_type = 'user-per-process'
           AND key LIKE 'resolver:cache_%'
         GROUP BY owner_id
         ORDER BY hit_rate_pct;
       EOF
       } | sqlite3 -box :memory:

     ╭──────────────┬──────────────╮
     │   command    │ hit_rate_pct │
     ╞══════════════╪══════════════╡
     │ nginx        │         54.8 │
     │ chromium     │         71.2 │
     │ postfix      │         83.0 │
     │ redis-server │         94.6 │
     │ sshd         │         99.1 │
     ╰──────────────┴──────────────╯

See the lttng-export-maps(1) manual page to discover the full
SQL schema.

Other map highlights:

• A map channel may hold 32-bit or 64-bit signed integer counters, cap
   its number of keys, and follow a per-user or per-process buffer
   ownership model for user space tracing thanks to the `--value-type`,
   `--max-key-count`, and `--buffer-ownership` options
   of lttng-add-map-channel(1).

• With a per-process buffer ownership model, choose what happens to the
   counters of an instrumented process when it terminates while the map
   channel still exists with the `--dead-process-policy` option of
   lttng-add-map-channel(1): either discard them or, by default, fold
   them into the _shared counters_ of the map channel so that you don't
   lose any contributions.

• The lttng-list(1) and lttng-status(1) commands now list map channels
   and their configuration; filter them with the new `--map-channel`
   option if needed.

• The lttng-clear(1) command resets all the counters of a recording
   session to 0, without removing any allocated keys.

📖 To learn more, read:

    • The new “MAP CHANNEL AND COUNTERS” section of lttng-concepts(7).

    • The new “Map channel and counter” concept section of the
      online documentation [1].

    • The new “Count events with a map channel” online tutorial [2].

Save and load your triggers
───────────────────────────
The lttng-save(1) and lttng-load(1) commands now serialize and
restore _triggers_.

Saving a recording session configuration also writes every trigger which
exists at saving time, and loading it recreates those triggers.

This matters for maps: because the new `incr-map-value` action targets a
map channel, saving and loading triggers is the only way to preserve the
configuration which populates the counters of a recording session.
Without it, the saved configuration would have no record of which
triggers feed which map channels.

Skip this behaviour with the new `--no-triggers` option of
both commands:

     $ lttng save my-session
     $ lttng load my-session --no-triggers

lttng-load(1) doesn't restore the original owner of a loaded trigger:
the Unix user running the command becomes the owner of every loaded
trigger, regardless of which Unix user owned it at saving time.

📖 To learn more, read:

    • The lttng-save(1) and lttng-load(1) manual pages.

    • The “Save and load recording session configurations” section of the
      online documentation [3].

Record raw binary data with BLOB fields
───────────────────────────────────────
The new BLOB field instrumentation support of LTTng-UST records an
arbitrary sequence of bytes tagged with an IANA media type [4], for
example `image/jpeg`. Previously, LTTng-UST could only capture binary
data as an array of integers, with no way to tag its type.

The new lttng_ust_field_fixed_length_blob() and
lttng_ust_field_variable_length_blob() field macros do this:

     lttng_ust_field_variable_length_blob(payload, buf, size_t, len,
                                          "image/jpeg")

LTTng records the bytes as is, without interpreting them: think raw
network data, memory regions, binary protocol data, or whole files.

CTF 2 [5] supports the BLOB field class as is, including the IANA media
type. For CTF 1.8 [6], which has no equivalent field class, LTTng
records the bytes as a best-effort array field of 8-bit unsigned
integers; this loses the media type as CTF 1.8 has no way to encode it.

📖 To learn more, read the lttng-ust(3) manual page.

Start the consumer daemons up front
───────────────────────────────────
Pass the new `--spawn-consumers` option to the lttng-sessiond(8) command
to start the consumer daemons immediately instead of having the session
daemon spawn them on first need.

This removes the one-time delay of spawning them on first need from your
first recording session, which is handy when the earliest events matter
or when you're measuring startup latency.

Control the new features from the liblttng-ctl C API
────────────────────────────────────────────────────
The liblttng-ctl C API gains functions for all of the above:

• Add and enumerate map channels with lttng_session_add_map_channel()
   and lttng_session_list_map_channels().

• Configure and inspect map channels and their keys with the
   lttng_map_channel_*(), lttng_map_group_*(), and lttng_map_key_*()
   function families.

• Build the new “increment map value” trigger action with the
   lttng_action_increment_map_value_*() function family, along with
   string key template utilities.

• Capture and filter on BLOB event fields from triggers with the new
   `LTTNG_EVENT_FIELD_VALUE_TYPE_BLOB` event field value type.

   Get the IANA media type, length, and data of a captured BLOB field
   with lttng_event_field_value_blob_get_media_type(),
   lttng_event_field_value_blob_get_length(),
   and lttng_event_field_value_blob_get_data().

• lttng_register_consumer() is deprecated and now
   returns `LTTNG_ERR_NOT_SUPPORTED`.

📖 To learn more, read the liblttng-ctl C API documentation [7].

VERSION NAME
━━━━━━━━━━━━
This release is named after “Question de Perspective”, a stout brewed by
Ayawan in Val-Morin that the team adopted for its name. It is a
thoroughly standard stout: dark and roasty, faithful to the expectations
of the style, and remarkable mostly for how unremarkably it conforms to
them. An `std::stout`, if you will. Whether that counts for or against
it is, fittingly, a question of perspective.

IMPORTANT LINKS
━━━━━━━━━━━━━━━
LTTng tarball:
     • <https://lttng.org/files/lttng-tools/lttng-tools-2.16.0-rc1.tar.bz2>
     • <https://lttng.org/files/lttng-ust/lttng-ust-2.16.0-rc1.tar.bz2>
     • <https://lttng.org/files/lttng-modules/lttng-modules-2.16.0-rc1.tar.bz2>

LTTng website:
     <https://lttng.org/>

Mailing list for support and development:
     <https://lists.lttng.org/>

IRC channel:
     `#lttng` on `irc.oftc.net`

Bug tracker:
     <https://bugs.lttng.org/projects/lttng/>

GitHub organization:
     <https://github.com/lttng>

Continuous integration:
     • <https://ci.lttng.org/view/LTTng-tools/>
     • <https://ci.lttng.org/view/LTTng-ust/>
     • <https://ci.lttng.org/view/LTTng-modules/>

Code review:
     • <https://review.lttng.org/q/project:lttng-tools>
     • <https://review.lttng.org/q/project:lttng-ust>
     • <https://review.lttng.org/q/project:lttng-modules>

REFERENCES
━━━━━━━━━━
[1]: https://lttng.org/docs/v2.16/#doc-map-channel
[2]: https://lttng.org/docs/v2.16/#doc-count-events-map-channel
[3]: https://lttng.org/docs/v2.16/#doc-saving-loading-tracing-session
[4]: https://www.iana.org/assignments/media-types/
[5]: https://diamon.org/ctf/
[6]: https://diamon.org/ctf/v1.8.3/
[7]: https://lttng.org/docs/v2.16/liblttng-ctl/

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

