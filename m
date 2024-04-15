Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF14C4345F
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Apr 2024 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1713190865;
	bh=0R8E0Ac3azrJIzLWDeieQBgPR39BB7NG7cIUoeNUhiU=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=WUffxBa8djVmu+3+n6mIiceXXAaHGdWqOyjz6Stp0MsMbNyI8I0khY529dxQ6pNk0
	 v/kgseYWq1bqu0KJDTjDHrWuoRWt2X0jdDDkCT58w3JYwsEAcPY6xiFLFnMCP0VLTP
	 h4toSZBxzJDPs5s/0ngh16CMl6az8BVHkvTuJ6NdXUKq5WCTdG4avfGTUNQQiLS72T
	 1rYoZy3TYkbAyUEde8r17IE8t3+1IK7jZ0BgKZj6C9BojHNVIp/IunbifPgAqTMoGK
	 TVUgjIKUjkL37GLYMWsCKAoTjvnTCSfBrwDLMNg47TDLz3QEVRt7n5oCRkRPPMCcSa
	 RVCU6KZPCZqdg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VJ8V82bQ7z2h2k;
	Mon, 15 Apr 2024 10:21:04 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::701])
 by lists.lttng.org (Postfix) with ESMTPS id 4VJ8V64DYNz2gtx
 for <lttng-dev@lists.lttng.org>; Mon, 15 Apr 2024 10:21:02 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGbsm3JIY8y4/Wig8+mrQu8NOt84Er/spcJADcJisk7wbxMJ9J+rqmVUV2MDnJ7ApzlvOMQDQ0pFDwqCdwmZ7fcAHcEUTlNKSRf6Oa76HvNT2j1RV6TroGhZfEIAR4dUbFO8ON0TxCWwyLrvk5D5NtKhmVna4zPVVgGX5sG8439AFzx4ysGHY02jB90ASaVdQ6UAQSPo5n/HxNV+/5xUfMx+rhn+0dg5xOc/nETVG99g+IvfHhLauj0U6jwjP/M/GWmcsSv1IvVFptd+yn4Cj7Q2QxaXM/1LEqVXJt3+lRtr5nuFGrdy9p5WOpqf+i6SY4i0K9Brk/YYi7/nfDt6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXUNB6jLKGXMqpdsZV6/Mdswz1kU5rGsJlGGaiZKZDg=;
 b=oH9PGr0vsvCG3RfOcKE0tWqFRFsGSFSqArIWsOGeu8fJ+iKB6eBlYhleFslPl1z09YMGNNbLz5u1k1S8XVc6v7YkBFiUS9avJcxtcVsM3/7fCS8zpVoxIsXIpnUEFDDvdAukotI+BDGmgS5WVswjP6kYWK17SDXEFl9Kx1KVvAFSuofjs5ql6BcYnXQORHDMZAvTqRb0BgRSLAyWw4Cn6/UtNvuAUDvBQUgBPjPN61lv6hhErc8KHBdN6XSOcmFDM1SUApHB//c+jcdUqrd1KzfZkecRgTzg4CQplAXX78Bs/wsosIhNi2QRj0Q2OxTIoTbqiEu2miaCMGAm6UhE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT2PR01MB10697.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.30; Mon, 15 Apr
 2024 14:21:00 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a41:c476:7b73:99ec]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a41:c476:7b73:99ec%5]) with mapi id 15.20.7472.027; Mon, 15 Apr 2024
 14:21:00 +0000
Message-ID: <edd5722d-8103-4ef0-a53e-58d8d03ed928@efficios.com>
Date: Mon, 15 Apr 2024 10:20:58 -0400
User-Agent: Mozilla Thunderbird
To: Paul Wise <archival@softwareheritage.org>,
 LTTng development <lttng-dev@lists.lttng.org>
References: <dcdc31d82b68d1ecff6555f67b6a7c8f6b7032ad.camel@softwareheritage.org>
 <7bacc8ff-c7b8-43ac-89e0-c3036131e1c8@efficios.com>
 <d1d8d46ef56ca05206ca673804cbd651eeacc4e5.camel@softwareheritage.org>
Content-Language: en-US
In-Reply-To: <d1d8d46ef56ca05206ca673804cbd651eeacc4e5.camel@softwareheritage.org>
X-ClientProxiedBy: YQBPR0101CA0332.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::18) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT2PR01MB10697:EE_
X-MS-Office365-Filtering-Correlation-Id: 0399044b-bf9c-490d-1227-08dc5d57461b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQKqfA6DzyXHJXTDOd2vLD3MRPoPcm1tT+/rNhzfXOIHiOsb8MzAb6sARaCggHih1sbhAy6jXBH4C9f5cx+KS/D2r3TvawlG+ke9YbIBw57MQq2FfXxIGpTLY7jE7l4GpFto7Qf0aKWMVGjawLqVFwDeBo0egtXy64OCePQ6CxWLh50Ykotuwl0zpgf0RAwKwzdmSJHA/S3Y5YWYTwSb9B3zCvKvxpt31PF8gp8F/vs+Rxq8SF/PSemrG50jtgTV5mXKsgJVhPfT/Oz4ZX4MSdZ3OjAomjlIA4VxY/Uv0NTTb9vUP1Uxo/DjiKzw7bfWxfCgTAXtdP6iZbnNWojnGAgL/Fg4T4Z8m8Asg3vOu/EA8mhzbqd4+F7SXqTLD5Iotr41hW5/UmZfpB1WwkQiWyqPPG6WPBXI1Hg5lU8FRmisL7r3kdB9gtlisDbEuhBYkPUWH4O1NSkWKI52FnMGtRmSZPoc+DgWrqOMeR0642yZADX2ESwTNiww02E5Q2TxOPFP7/RcONyyge26fzeXWocplV/DBx5GAOP/6VR9uvIwqeRjitBujczEbm+5TxptMkOubaAzS30BG/+GHPzkVsCB87CkhBWNeLFDqB1cT0syEwKE/sc4vxNs7DxU3TyL+SPlgGpyFeNzl/8JRMTKjVqc8HHu56QlyN/SDZMHDio=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVhPQ1ZhajMxanhqSDJIblRTUE81TEpBWWVZQ0hkUkQ3dW5MTkIwTHJ5MGsw?=
 =?utf-8?B?WXNpN1ZZVFVoZWw5WmFhS2ZhR0hpOE1xMWMyZHJNTTk0TjZQK3I0b3c2b0ZK?=
 =?utf-8?B?dStjcVBNTWkvU3B1R1d6b0loVlcwd2pWRTVGdVZ2QnVIU1VtdmprY1JzREJt?=
 =?utf-8?B?NG5wa2I1ZmptRU5NK3dHQTJvY0hGRDFwTFhZOEpYMGN6L2ROdE1UMmpkekxa?=
 =?utf-8?B?dFN2bjZoV0xxMUlCQ05jblFuKzBlM2kzUzBadlNucThpeksrNVpHR2xUbkxH?=
 =?utf-8?B?NEJ4Y011MzNGdk1XdE9NczFDOTBnNzMvUGcyZWxXajlaQkVMSkJxQUZNWkVB?=
 =?utf-8?B?STJqdFBjN0N2aFBYUjd4UExqTkl3MFIyVFo3Q0NEWGVmRU5vOWdBVkRQSXVs?=
 =?utf-8?B?S3l4Sm9FTktVaUxTOHdFN041aWxqZTEzMVVuL0grM3FkZHJJaVZ6K1ZkL04w?=
 =?utf-8?B?WlFra1UxdGRGRlhUNjhrTzQrbnJaeldEd21zM1E0am9peTJOWWh1SnZHaERW?=
 =?utf-8?B?YXJsM2Y5Qy9HcTBERy9pSHJIQm94OGtRQVQ5MjNocUVyaDVsSU0rbjJ0Y090?=
 =?utf-8?B?QkVWSHI2WTd4Y0tncGU2V2RKY21LeXQwbHdGVmdzeGJQRmhITGdSd1VXbldF?=
 =?utf-8?B?eTVQMmo2VG9aUGZ1RERKWm1xWlYwaE9PRVFWdnpNWU5xU1p6ekk4SHBOdGM5?=
 =?utf-8?B?S0IxQWd1Wm5jSjlZNTY1UDdLSkNmTndhTmsyc1NneXVyMENlNU1nRk5VdVN0?=
 =?utf-8?B?RW8yOWY0Q0E2cXpOaE95TnhSQW5naDNoL1VoL1NUSE4zUC9vRmZBendaUUlj?=
 =?utf-8?B?dGtrcHhUaWFjcU1oTXFqdUtIM3JnS2Z3L0dRWDRoSXRrU1dpSGxUck1Sem5Z?=
 =?utf-8?B?NXI1WDE0ZUd3NmtQcVpTYUJ1R05RcEhPbkZRQ2xacisva2tMaVlrZWZkbmky?=
 =?utf-8?B?NzREbGRRaHJVQmdLNmJ1RU9LM0JJemRWWlNPd1ltck94NTdsaVRFanR6RTFy?=
 =?utf-8?B?dlNQQ292czY1Q0lkaE9PSXlOZGIrdEt3MFhZRG1rTHhyOGxmeDZSMDZMMjNU?=
 =?utf-8?B?djNJcmlJMDVtZ01xK2wzeGZTMHBBTHA2UlRVclZjNlNVMStGYkM1a0UyQWN5?=
 =?utf-8?B?UG5mU2NCa0JEZmU3QnZRVkM4MDNTL2lMem5wQ2dhNU12c2NYaHR0WnRtZUF2?=
 =?utf-8?B?L2RrNlgzSUJwTGVDUDQ1OTcya01QNFpBbkM1a09OMTA1cngxdkxQcUpwUnNs?=
 =?utf-8?B?U2pGb3k3UDhIdjhBVWJFTXVIbnFhTEYxdXErOEtCWFR2U0l1UmpoSkdmenlW?=
 =?utf-8?B?NjZDZnZnaXIybjRsL2xqRkREWGRON0FPb3RVaUNIK1UzZmhrYmxUOUdhbEVM?=
 =?utf-8?B?RGpuQ3hqUVpRSmJ6VW9lU3M2KzlIVExIOHFocnhwLzJpaGpuQnNrQjRCNWo3?=
 =?utf-8?B?Mi9EbVYzT1BGU3dSZHZ6a1ZXSVdjMjJHMTVBSCtqS2lOa25HOWIydG1HNE9Z?=
 =?utf-8?B?a01GVzdlNUJhWW5IeFg1eFhwaURTNnhUcGpLWjk2NHdEN3pQSXF0eGhsLzVS?=
 =?utf-8?B?cXRwVE02Wk1uSU9QbHFnY3pYZVZrNlBTUm85cjRaRys4ZXNOZStweXpBOENX?=
 =?utf-8?B?VmcvYlNuQWxSZERWU3ZiVmNWQ2FHRXNNM1NaSGdNZkU0WVBTeEJRR3h4S3o4?=
 =?utf-8?B?WG1QVnI4cWd4a3NDV3piQm9NbDVoVmtxUUJ1ajZGSGNIbXpxL1BtbWQrR2M4?=
 =?utf-8?B?TzJ3SG1kMHFaVk5UVEdyRGZvZHNpY1k1UTQxcmpQZmFqVmhzRGEreUUycVRv?=
 =?utf-8?B?N2s2a1RQOGRVNWY4bDYya0JzZThienZEVmkvWlBHR1R0Rk5PWW1TdFVETUhK?=
 =?utf-8?B?TEZPQmtFK0xMT0tQeVQzVHJZcU5zaVI1TUEzU0FFZzNFYXBGY2pJcnZHaHZK?=
 =?utf-8?B?Y1luMnFLM29GZ21nYVBQWkg3bnJRcW1VZXZVT2xuVkc0U01lU2FZcWNiOVU1?=
 =?utf-8?B?L2FZNWNRcnJmeWJCWDcxL3E0ZStCdWp0YlBXeWtHRk1aM0ovUFZmaEdYbU1y?=
 =?utf-8?B?NjVKNndFWFZrd0xmUUovbW8yOXVDYTBKRm5MOU8wUkZWRW5Yb3hMampYbS9C?=
 =?utf-8?B?Y1dZMUU3c0E4VXU4QjhBdTBqU1ZQNEVraEQwWldmMnphalJxZjY4MVNUd01z?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0399044b-bf9c-490d-1227-08dc5d57461b
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:21:00.1597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGM9ijwu8fwkdGQKzMkj6MgrEu99X2dvPZ4gXRyB348ii05FzWPXHWbeWH0K86apt3gCCS2Q5qp1yXNVb1n7MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10697
Subject: Re: [lttng-dev] Software Heritage archival notification for
 git.liburcu.org
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2024-04-14 20:39, Paul Wise wrote:
> On Thu, 2024-04-11 at 13:45 -0400, Michael Jeanson wrote:
> 
>> I see no issues with this, thanks for the heads-up.
> 
> PS: I note that git.liburcu.org and git.lttng.org seem to have
> identical contents. I wonder if SWH should be archiving just one of
> them or if we should archive both just in case they get split up?

At the moment 'git.liburu.org' is just a CNAME for 'git.lttng.org', we don't 
have plans to split them up so far.

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
