Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1924CE92734
	for <lttng-dev@archiver.kernel.org>; Thu,  5 Oct 2023 19:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1696535954;
	bh=ju1WBW63aKZeMvG+jRHxGR2qea9kt9U4EFiNNuKsfj8=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=K945/17icQ6F7HeyCIbXpLKe8//KRxCP7sbpdpivmb2s/oXg4BHqPRUcf9N4YoIco
	 KN+Anc3oeVId29O6kCfBmU2iQQ9JshGOLsZytf3/fv32IsgIK8ilF21cCBj57tDnce
	 Hois29TRdZWNsVuujYJTIr1YcavLtrUmpbuCsq7vMLSOliESUxOGyoWdT72m/laGOW
	 m4V4syGFKRMPM+0Tc2xud+rs85GcPhF0EML4BUa1CqujxiSoFxWK2WyFq/RAYPmzRj
	 PhjcWC3eFKuVQuedeJzgXkpax8xUeTfla7d1yzq6F9oxWRV1X/VEIWooQ7xKUCJRoW
	 Z1ZNGhmUswY9A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4S1j7P4jQ8z2t22;
	Thu,  5 Oct 2023 15:59:13 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2040.outbound.protection.outlook.com [40.107.116.40])
 by lists.lttng.org (Postfix) with ESMTPS id 4S1j7N0MyYz2syw
 for <lttng-dev@lists.lttng.org>; Thu,  5 Oct 2023 15:59:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxbOc2F+mx8j3gAs3jf8wFwq2ra6B0DQ1wbw4hfntddpeIdG+HS8Q/Kd3fESfOs+BUJsruI56KnyozjhbV8RPTsSkpfE0lp+/e0zNciinSoGK5TYae6PXfKfSvnFtU3RQkUe5Gnwiy+QNCa/OwVqEgWQWH84eMgCDRnBbGlfQTeKzwJT/YHsm4k+/gD4yrl7Xc7ZO5M2mOAtxAAJRVVpraSNO9cOXPIkEHGjAXTfS9QjpLSs0q5fG90KRyYq82iaYJs38q0gep67Y3w4JRU5wEm3Dm+SRTzb7aJ+j8rrKOeWw+CtAzdj+PHZC9QqDiMbgSS5p8EsTvHag6u0611M6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rz5XqnhOvlztmOFJOuUs3cCsRmCv9HXvYOAZg4KO93A=;
 b=L4wDE8L1lzIkho4njoOJcH1+usMldHPCetbzM3EkiegwZj1OQE+dOSEFUL0IYQL60ZBN47sYEMnoPT+vL4vw4jRilRm4hJjzQOJTfoBFsX/Qlo5akaqwDMeLNmRDZJSNgPV4C5LAqlhz1ViLzBWM5pIyn/Cp5TluSs4n0HYc02vbF4Ophfd9w3DiwXfKllZSij4j3onXWQbQiOvnnQiCTHxiYc5ShuwLkiVt21lhKFRT2FH8ectWqRMskt9iCLdwH7JGAkC771bA8t8+bohf7E5ez1U/N8AFNhlh+1dK/37ClzWz32LZtz9uTtjVebTvI03/7quOJ2lh3hX4wEJilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YT3PR01MB8675.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 19:59:09 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ff6e:51dc:2551:82dd]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ff6e:51dc:2551:82dd%7]) with mapi id 15.20.6838.028; Thu, 5 Oct 2023
 19:59:09 +0000
Message-ID: <2d0b12a8-426f-4dbe-bde4-de6968dbd879@efficios.com>
Date: Thu, 5 Oct 2023 15:59:06 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-CA, en-CA
To: Christopher Harvey <chris@cwharvey.ca>, lttng-dev@lists.lttng.org,
 chris@cwharvey.ca
References: <0c1fcf2c-c061-4074-a20e-44b870fbeef5@app.fastmail.com>
 <2795ad9b-acbd-460a-bfcb-61f0101180d4@efficios.com>
 <db8dd95b-55ca-4259-bcc6-db145e0ad05d@app.fastmail.com>
 <7619596b-4c04-47d3-91ad-da49786fcfac@app.fastmail.com>
In-Reply-To: <7619596b-4c04-47d3-91ad-da49786fcfac@app.fastmail.com>
X-ClientProxiedBy: YQBPR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::34) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YT3PR01MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: f57a7172-225b-4a43-1e85-08dbc5dd89c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oktu3/hz/NrEIt7pXjVKuNsqFMI27k0tVX/hfafpbRYCiXJSQQwxkb6d7kbP/mNeYyx/1WWTpBxdyVAbOl8Gv3nwrCVMHS4Ct2RzkYFgTtefXyKnwvLlr6bPZ3U8ugZADpnhoQKM42kXoJPfi2yS00g+lbt7Z/u4u+oMxOWYeMRQxw4eXKRI6dNVDNtDU6bfAuqeZros8cTSkjBgAhiugjuVauhWHd1SObiWVfPwevfwQcbTATB+UGedG55dVhxDEeAAJ/QNRO6h1+yDRYQ1irW9/i5UNUY3vqqKVj23CaRrpqR807uevYjudDxckfbDgtSFGErqd383TL2bIBynV3AsNRfR5fYU1m+vvrk/E9lKy+noI1lJvWM6vndPzDvYIC7ewAFihuG4eBNv0On8S57dl9C/8dDJ2Zbt91ol2cG/RD21ed1UolnV61ivFOQG+6gTjsw+n7+fwSTU+bt8Glq4btgnPXUJCQtlNJ1VSSPLYmcjNh/+6i5KOWA3j1GLmgu+O9NIAHS3jO1MwoNbhvwdxpaYwz8XAk3JVK+dPqrTIdmJYbvjFx0dI2PuSreb+i/JNm7gz1/RG/gDJzlZ7O+Qv64cYyUgG7icM45Kg6+LzOdgLOeJ0PcYVYpLfNmD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39830400003)(136003)(376002)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38100700002)(36756003)(6666004)(2906002)(4744005)(86362001)(6506007)(5660300002)(53546011)(478600001)(6486002)(966005)(26005)(6512007)(66946007)(66556008)(66476007)(316002)(41300700001)(2616005)(31686004)(8676002)(8936002)(31696002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVJJdXJ0TmcwYUVRb3VMT1RLcCtKMVpNcndvakVaYkxOR01tbENEY1FOeEEx?=
 =?utf-8?B?SFRiM29wRXBGZThUUEdLRktrZmxOWnc2UVliNUdtSFpPWXBzUE5wajA5cTNE?=
 =?utf-8?B?Mm54RFlUSDhMc3RKb2ZkeUxYd1NlZXVaMm1sQ0hPeUlvM0NzZmIxQW9QcHBj?=
 =?utf-8?B?bW9ubkZuVGhFNCtzMWpzUWI0emhIUmxyWFdSSXpoSlFFeEVoMEp6NDdvaWZL?=
 =?utf-8?B?aWhKWE4ySldRc055R01CVzd1d3FCVlY3ck51ZUVBS2pZRVlOamVyaTZxbU1V?=
 =?utf-8?B?eTNYT3NQdzRxSUhIWnpMU0M5S3FQZFIrR2UvVnFtY3ZjRFdDNGhCMkpxNC9P?=
 =?utf-8?B?L1FxUEJEeitsdG1MZUR4c0hpMWs5N0k4R3lxRFlTWWJUTXVMOHljajhybmRK?=
 =?utf-8?B?N1g4ZmNNb2RXMFJzWE5tMzY2TFY4THI0dVdWdVZRVGVLRHlYb0NWQm5FaHdo?=
 =?utf-8?B?b25LYWIzd3VKU0QyZjJWU0FCREtuS1JLVmFlRW5VbjFIZUFLb3hmdXFVckxG?=
 =?utf-8?B?cEs4OVI5blg5WGk4TjFCY2VGMHZQVW8wb2lIVW5lVVZMMTJoVUk0c2tZcStL?=
 =?utf-8?B?YjJNVUNBSUNiazZLclY2Sloza29zN3JyMlBBc0ErMSswVlBwZDk0ZG00Tnl3?=
 =?utf-8?B?T0ZNUnV1aEsyeFpTaWV0VHowT1NYdTN5dDJUQWlaU0YwZVg0SjR2ODVQSGVH?=
 =?utf-8?B?OEdmOVlTWE1HalladkZaS2ROWEoyQ3NMc2lrSUJwMkJsVThVdGlvc3ZkTzl0?=
 =?utf-8?B?eW1vcDNuZVV6ZHhRU2xjZE9pdWs3Q1R4Vzk5YUxZOXNyMGFmK0ZBck9Fb3hN?=
 =?utf-8?B?eTA3MERmb1laTlNoTk5SN1RuRDkvNU9kWkl6UjFTRy9Ca05tMmtPU2huei9B?=
 =?utf-8?B?S2s3d2FVbmJMMEtqVmErYU5TcERibkd6UGZ1MDk0dmJ2cWNnclBCTWlQQkd1?=
 =?utf-8?B?am1nd1hoajFVekhRb0ZRYmJkZmtud3BndC9YbVB0Q25GTHcyM3NrcEtkUnF4?=
 =?utf-8?B?UnhTclJQYzZqQk4wVU1kV1lXTGNxelhHRnNtQ2tpS2VSSTA0Y0w0S0o2bzl1?=
 =?utf-8?B?Y0Z5YmRzOXJlSFlSY2hiakQySnNNMWNNdXdLMmE2WW9zVlRCSHQ4b0lUL0xu?=
 =?utf-8?B?UFZpcVZDVUxheVBsV2xHR3RHWG9pbVZnZ0dTYjlObmdzdDBnM2FsMEN0eTkx?=
 =?utf-8?B?blhSbklNZmhNMSsxZnl2dHRHWHJCVUduOFJobzdqaFJVeTRNcWpzR3hkM0w4?=
 =?utf-8?B?ODhuZjdtZEZuT2cva3lCMFY2TndhV3N0a0FWV0Yrb2hNQ3hqZStaenUvOEhu?=
 =?utf-8?B?ZS9YWEZZSy93OHYzWmhDQVM1Q2g3SmpiZnBGZmMrZ2RrRVBGcS8zZmEyTlFZ?=
 =?utf-8?B?dFpHaVBmQnhRUGMwc0ZXaEJqVDlLOXFwV0VhdmxLNDJsNno0Ty9BVmpDNkY2?=
 =?utf-8?B?cUlseXVnTjBFQVZYblR1OG1MUCtoclB3ZE0wN21VazZ4VmUvdHlTODFWS21Z?=
 =?utf-8?B?K0J5UWJkd2IwUDZVRHpvbFdjZGNqRzZRTGJOUGVzb09kRFZoc0tCVDJxQzdC?=
 =?utf-8?B?UjkwcmpkdTVsQmkyM3RPRXVQbUpRVUFFeE5pd2xxTTRHREwxMTNla0h2WUZw?=
 =?utf-8?B?bERTYkEvVGM0N21uL0FPNUtLbnovT2xhcnMxYUZmRDFXNGhmbWJBQ0ZPWUg3?=
 =?utf-8?B?ZFFPZXk3VEFtbGcvTm9ycEQrZVo4WFk4UEhPVVdDaEJaMEZtbWp6NFd5OExG?=
 =?utf-8?B?QXo3NUlQVi84NXFjQUk4WTRmT1dRalpybzlqSHRxYjBFeTI4UWt6b1h5SjNT?=
 =?utf-8?B?N1JSTGlabHJ4aUdqY1Y4dlo4YlAyTWtxdkd3M1VXQjhkVjJ6OUNIVlhnb3lX?=
 =?utf-8?B?bXpseklWQ2R4ZDZybFN0bEl3c205MnovUHlzeVVaeHYzemZwRUhvVU5qZEZE?=
 =?utf-8?B?clo5NG51YjY1L3hpM0hmTjJQeG9lSEtKVm9LQlpZejBhMVUrelFHaVpRQ1FO?=
 =?utf-8?B?d3FRZElzcDhGeTBhMGhBZWtGOEgvTnVrNWlXUU9LamQ0K1VWUTgzNFMxa1Z2?=
 =?utf-8?B?YkNuVmxSUjl4UVIvcEtWeWpJSTJMWXZxSEpTcGs4SXh5RlFRcU9uTER2NFNJ?=
 =?utf-8?B?UXgwK1JIc3hueHk1QWJ1NHQyQlpLb0hOU3VnZnZWUmczZWMydHVycEtLVmNk?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57a7172-225b-4a43-1e85-08dbc5dd89c4
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:59:09.4091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIzpEKPbaCBfXo5F0XWTfyew64vVK889wvvcvyD1H/LQllbrHI4hSKDG2jXQBD7eW8AyBHmYzqtpeRHQwNIgvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8675
Subject: Re: [lttng-dev] What is DEFINE_LTTNG_UST_SIGBUS_STATE for and other
 beginner questions
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Chris,

glad that you got it figured out! I created an issue based on your 
feedback. https://bugs.lttng.org/issues/1393

thanks,
kienan


On 2023-10-05 15:40, Christopher Harvey wrote:
> I got this one figured out. I used strace -fp <pid> -trace=connect on the target app to see why the connect was failing and it turns out there was a mismatch between sessiond's apps-socket paths and libust's.
> 
> time to review my build environment I guess. It's very possible my docker container's path environment variables are non-standard.
> 
> If I had a tiny bit of feedback to provide it would be to print out the errno and paths in the connect/bind commands in the DBG commands. I had to bust out strace to get that info. Small problem, but it could have saved me a few hours and some mailing list messages.
> 
> Thank you for making this nice looking software available for free. Looking forward to playing with it some more.
> 
> -Chris
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
