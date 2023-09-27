Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF8FE810D5
	for <lttng-dev@archiver.kernel.org>; Wed, 27 Sep 2023 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1695815651;
	bh=lFiNLL1xQNOQO9M8a1gIQCiZA9vQRDVghvJ9Dner7ts=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=JgpG+naZL3GyzDs1cCWDkJME94svQfJ9tc/AK9U+bb2Hum3xvH2lTPP+myFUJXQsF
	 9Zv6sueE1yVYylbZSWB+Cmobk9FT/acMxKkVSg2GLgYW3ogKF8ZECkjIVo9cqG8cbZ
	 kiqVv2NCtgMQrDOUmh3Tv6zzxi5sLo57R2mSM8QnTiVWAnZWQ2rjRJz+aSZrh4Hjhs
	 1ulmzuSp/QbYb/t2oVDmYpPUrLHcSNkzAioia2VMr7J+Gfn1dnfQXYmRjdGApypAIx
	 gDkCD0VZPduoo0u9CTstb33SoNIOPztEpxbbq4FO8vY7T61V2KT+N7AgLYnMnkeI28
	 2oggtU5FiFLIA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RwZlQ4kH8z2d5C;
	Wed, 27 Sep 2023 07:54:10 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2079.outbound.protection.outlook.com [40.107.115.79])
 by lists.lttng.org (Postfix) with ESMTPS id 4RwZlL5X8Qz2d7M
 for <lttng-dev@lists.lttng.org>; Wed, 27 Sep 2023 07:54:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hppGtxFpRUZXvslj5M73h0p1tkH7LxPPsDdE56MF9B4gfvs3rj0PmXx/k0dmLRL08ioGYcRD8Y3FBW879Txe7zv8NFRmfU+qs9u+a1oON8NWPdLKnsJ7KZnQ/3ENDoEiO1UgefGRxPpcFrLw8l2nxFLW8RDz7QJ9Sr/2As1IDuyninSd1Dl9LYqL/LVlWGfsLdtLbmb2smEO9qm2JLcCwjiBB1bHKC22t3xTiC+3hB3SY5TS+wmIH10P+JL9zzaPOkrPspz2+dwHtLi2O9hF6hW6nFg+cWhO8DhWmQXIlbImSUXjU5fnOqeeIp08kgjPNCPDwUsF6F9DfKVYhTG18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbxZH+ZmaQ8f9tnsqshPyfl4LUVZi25sqRG6IrWavHQ=;
 b=S98pmUGgotzCCHR50TFViYGwltT7+bAmWY6hbnOoVx0UU3xF+EvBr0ZijmPNeKxAy1Glut3mIRjBYxr+ZAAfuUR3Fw9T+fPeh0/Ep+Y5L59Png8BA6MCoaSOwVekkT+iJQYe5T4ezhDWMRB9MtDFsBMgmRUZ56//c6F5Hd/u1p1UfhNTd1Vx8tEl1oIYu6KbaE71FkE0Vg2ys2Velmp4Oob/Jbq4pHW7OwskXGhjpQUF0yskWggedFHO0HJ1lqmSl9t8DrwZSG47cbq7+4STtZS0l6mkDyxHqz1bzNqqr5RQGlxKf1CKBdIxWOFUBiUautgMIOZniNIKftzR3mgFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB9884.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:90::20)
 by YT3PR01MB5650.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 11:54:04 +0000
Received: from YT3PR01MB9884.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bb96:3684:8c21:f7c3]) by YT3PR01MB9884.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bb96:3684:8c21:f7c3%3]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 11:54:04 +0000
Message-ID: <66f84388-7c42-46a7-ac93-58b5344757e5@efficios.com>
Date: Wed, 27 Sep 2023 07:54:02 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Danter, Richard" <Richard.Danter@windriver.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <661596f68dcda5a1aa87cd5faa4d5f6c5937728e.camel@windriver.com>
In-Reply-To: <661596f68dcda5a1aa87cd5faa4d5f6c5937728e.camel@windriver.com>
X-ClientProxiedBy: YQXP288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::16) To YT3PR01MB9884.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:90::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9884:EE_|YT3PR01MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f83576d-5c7d-46cb-63b9-08dbbf5072c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAylfAjOFXBOEuYNDOgDLrogup6Lfyz1z0GiykFnnBJ2VB1QPeHKT3gAki9erz3isXf14HUDmLil+zMg7Az42Me4F48k0gVgi/PkF+Ewz6di0YTytyp6Z/TWlyjnHcgmbF+lOTdhI4gX/lBgY/NjAXurgkLL4amWuscvuw4TTUOPQqJ/gqwTv2FC/UdIsLJyHYFI9u4Qq7iknX6C1Pwxex6Vr3nhfKrD5aGNVA2yaliY7cvL6U4fVyIR8t4EdFWS1vopMS4bPHG6ius18pvK9QKpLWOp4Qijdz85h9w3plgrAmZuc7BgxQGWhTII76RhCw3e//tVQtC+wfwUun6oGJB34LNXJ5v7jbiBSoZWtkk1L7sOEotehCbF9PUk4pgDy7VGiMOpZ5P1zHUVGBHCzVlEnI2zIyHEAyalJQk6ESZ2uB8cnWsIZcTMCmEo8hWWo+v/O7PvKYEfLssmIBT5Qqyl08djuqZV+5YgoXyCS9TAnl7SofUfXs5a9PnqOYlnWNqV/kCqMUrQfaQNPhv0d98f8SipY/Bw0D9NMAvya+vkfVViCr4XHCqrNHvYlVm6rIVJPPLV/wt120KBF6UGu1xSocNbQ94rKilo6sKs9M8lOkrwPnDqKH2yivetfOMcy+jPRo1dIu/KAWEUAQ+mWPaJYlkBhp+O3IjUdR8gO/l4nRvWNTt3ZnRrQYBdR6g6EVd6zOqDPMxqiVWHe8BQqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB9884.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39830400003)(346002)(366004)(376002)(396003)(230922051799003)(1800799009)(451199024)(186009)(2906002)(66899024)(53546011)(6512007)(26005)(6506007)(966005)(6486002)(31696002)(86362001)(110136005)(38100700002)(478600001)(316002)(83380400001)(5660300002)(8676002)(8936002)(36756003)(2616005)(66946007)(66556008)(41300700001)(66476007)(31686004)(67593001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWRRSnd2bG9GOFVyU0Iwb1VMbzN0amtqanhHR09zcHp1VXcxV3UxaGU5ZWxs?=
 =?utf-8?B?OW9hWldpNVpzYzlkRSttZTlKUnprZnVmT0FpUUczbUt1RTdpek9TZHI5STR4?=
 =?utf-8?B?dmhiWFF6K3AzSnYya1pEd2ZwdnJFMDZOcVU1bVkrc0l2OVNMYkRiUkZRQkRM?=
 =?utf-8?B?Nkp1bG5LTFl2Nyt5Wk9oQ3dwaGY5OEZzem9KWGlQTlJRU0o5SFhTKzFMNUNI?=
 =?utf-8?B?a0wxTHI5YkIyaWNqc1B3OHFuS0taUE9lZjUzdEExNVRGNjBCTjVZaUxSR3JI?=
 =?utf-8?B?azNMV3cyTkJ0KzI5c2V1WFF2T0NIVk9vZEVXSXpwNVB6MmRvcTMwUXkrcUI1?=
 =?utf-8?B?dnFMT1BpdDhQblVndDhSMUZNSDNzOUtFNFp2Wng4Yk9mQWVtby80ekRrN0s5?=
 =?utf-8?B?RitIMXcxR21hM2hUOFhqaEQzR2tJRENqZUVyQWh6UFdDQWQxZlZwR1A3Sm1h?=
 =?utf-8?B?elpQTldXSzBoOWozZTN0ZnBpWk8rTStwNnJTSG13b25XZnJzeFNFZ0FnZGdP?=
 =?utf-8?B?ZTdEaTRXK3V3UFBETUZMTjdtMlVWdysrdENPQXgvR1dzeWlLUW1ROUFTa2tE?=
 =?utf-8?B?QU9aNHVMbHJqVE0zRjJ3L2psVk8yYXlxRGZheFlwbkpEWlJOK01rR1JBVCtZ?=
 =?utf-8?B?T2JUM01CNHl3bUM2UnZYMzRsYjhiQmY3eUdJZG12U0FXdWxQRFdkcGt0TzFW?=
 =?utf-8?B?bmdpTFh0OUJORWZRODdRQ3p5Vis0UEFNbGJ0czlLblc4Rk40aksrcnl0eWdB?=
 =?utf-8?B?eWNCM2YzZ0xYQXJNcHdqY2FnMlkrcFI3V2tNb0tEZEZkQ1dWaDlCc0tINmx0?=
 =?utf-8?B?MFM4U2FPemtVWHV5SUZhYmZwVEVLZDkyVWs4K1doenA1VGlndHZJdjBjQ0Yv?=
 =?utf-8?B?R0NTRE96dlZSMVphUEVKR1NWcFlZTm9WZnBPc1FTVExtMnNDUnJuMnhhS0Rv?=
 =?utf-8?B?NEtYVWo5bUxCanVXWklVYzY3NjJhM0tET0JyRE5yNmc4emJBTUNOWG43SUdl?=
 =?utf-8?B?M2RMc1ZxdnltQklveklFZzIrTVB0YVFBZjJmZ2tvVTBKQzNLV09oRS9IZXRx?=
 =?utf-8?B?VG0yK1VwWGxGMG5rdExZSFdqbXpZS1N3Z214ZGRNYUhYWlJLUk84blFLNmwv?=
 =?utf-8?B?RGRRYTF1Tk94ZUl0eGIzYnRzOWlnV3lISnN0YkJTMEdISjYzYlNnV3hJK1Jz?=
 =?utf-8?B?MVlRWUlrNGFuWlROcmxiN2cxdi9TL3B2RVJycEJBUnhBNEgreldjZ09aR0g3?=
 =?utf-8?B?NWoyeXV4dnFsMjhlbDZySWY5TWdhOXc4RGhTemVleGIvRktHa0taMktlTmM4?=
 =?utf-8?B?NWlXVXdjNGFMSzJGdnF4NXY5UFJrN2ZiNXRRcXZpTk5DU3lFWGFPTXNMdFhH?=
 =?utf-8?B?U1Z3eVRvQUJrVzRmVmhydnR0Nmh3OEhESlZRam4yS1NndkRPUkxYOVRZNCtx?=
 =?utf-8?B?bUJBSkozQzRhdFF4d0FlMGVIVUlvejF4d3g2Znh2UnczZHhVWVptQVpmeW9V?=
 =?utf-8?B?WDNLZTMvcmRKdnlBVXlSVmNFTTVOYnR3cGt3WGoxeWF6bmFlYTdRVjYyMUJS?=
 =?utf-8?B?TnpsWVNLalNTc3ZuNjgzOUR0RXpKZVcwSkNoU2tLcFFUY2dsaCs1TkdsMXda?=
 =?utf-8?B?ejNYTjc1ZTZsNVIzY3FVRWZRSGZwT0VqYnVRNWIzUlZUS01oenR5K25IQVJw?=
 =?utf-8?B?cWYwU1Yvck4wUUR1MjZ6ZlFZbDg5S0JKRFdIbG80UjhhU0M3ZE9IdmxrT2RK?=
 =?utf-8?B?ckxDTU9TWm9UVTdNbmpzYS9KeGt0bXhvQVBGUFJvZG9Mb09TalRpSkh6K1pK?=
 =?utf-8?B?aElSZE1EWFBwUnVaTStkQU13N1cwbGM1Mk9KWGRmMDNFVW85dFpjcDBlSThw?=
 =?utf-8?B?THRuVmNSdHpEdTVaVGxyRHdEUW9iamRaODZYQU1FbFptSm1QcFBWVVZpT0t3?=
 =?utf-8?B?UVBNZDhvZWhVMkJUQ1hYQUY0ejBUTnJ3V25DeitvQUVxQUVJNUtZK2JwQ25B?=
 =?utf-8?B?dkI2SEY0Y05vUE5JRHgzSWY0WStZditvTXc2d2dSREFpS20yd2dxWGl3eFpR?=
 =?utf-8?B?VXdDbFdwTDRFUVd2TWl6Q2JvNm9vb25sdThrUnVsRm1hczRtNXBWNExQa2U3?=
 =?utf-8?Q?dVZgf/QubSTrT8KqPeS+lQv38?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f83576d-5c7d-46cb-63b9-08dbbf5072c1
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9884.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 11:54:04.7762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCRoLX1e0TqvJBWeNNF5z3nkSO/KvlTAfHgIEc+kjJwIWcWe1SdDbzVVx0mpyZDZZN0xDvdchEOjszxbDb1FSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5650
Subject: Re: [lttng-dev] Adding a simple "look here" event to the trace
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
From: Erica Bugden via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Erica Bugden <ebugden@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>



On 2023-09-08 06:56, Danter, Richard via lttng-dev wrote:
> Hi all,
> 
> I am investigating an issue that takes some time to reproduce. Finding
> the right point in the logs is therefore very difficult.
> 
> Since I can detect when the issue happens in the kernel I would like to
> be able to emit an event into the trace that I can then search for in
> Trace Compass of through Babeltrace. So basically a kind of flag that
> says "look here". That way I can jump right to the problem and then
> look backwards from there to see what happened just before.
> 
> I have looked at the docs for how to add a trace point, but it seems
> pretty complicated. I may have missed something though, so I wonder if
> there is a trivial way to add such a flag to the log? Up to now I just
> put a printk() in which helps, but would still be nicer to have
> something directly in the log.

Hello Rich,

This is a good question! The easiest way to point directly to the 
relevant part of a trace is to stop capturing trace data immediately 
after the identified issue is encountered. This means you know what 
you're looking for is right at the end of the trace. Stopping the trace 
seems like a good fit in this scenario because you're only interested in 
what happens immediately before the issue and you're able to identify 
when the problem has happened.

Assuming you would like to avoid modifying the kernel code, LTTng 
triggers [1] may be a good fit. Triggers allow you to associate a 
condition (e.g. event X happened) with an action you would like to take 
(e.g. stop tracing). When the condition is encountered, the associated 
action is automatically triggered.

In this scenario we would recommend:

  1. Trace in overwrite mode (flight recorder mode): Since the issue 
takes a while to reproduce and only the events immediately preceding the 
issue are relevant, keeping just a limited amount of the most recent 
data avoids accumulating useless data volume.

  2. Determine when the issue is encountered with a trigger: This will 
focus the trace on the problem area.

  3. When the issue is encountered, take a snapshot: This will give you 
a trace that contains what is relevant. What happened immediately before 
the trigger will be at the end of the trace.

In terms of defining the trigger condition, you can add a trigger [2] 
that matches a kernel event type that happens as close as possible to 
right after the issue is encountered and then specify additional details 
for the condition using the capture descriptor [3]. Ideally, you want a 
condition that will only be true when the issue is encountered to avoid 
having to manually sort through the snapshots afterwards. The add 
trigger man page provides several examples [4] that illustrate the 
condition and action syntax.

Hope this helps!

Best,
Erica

[1] LTTng triggers - https://lttng.org/docs/v2.13/#doc-trigger
[2] Add trigger - https://lttng.org/man/1/lttng-add-trigger/v2.13/
[3] Trigger capture descriptor - 
https://lttng.org/man/1/lttng-add-trigger/v2.13/#doc-capture-descr
[4] Trigger examples - 
https://lttng.org/man/1/lttng-add-trigger/v2.13/#doc-examples

> 
> If there isn't such a thing already, then would it be a reasonable
> enhancement request to be able to add such a feature?
> 
> Thanks
> Rich
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
