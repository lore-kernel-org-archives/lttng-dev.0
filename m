Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4F5C77B7F
	for <lttng-dev@archiver.kernel.org>; Thu, 11 May 2023 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1683828876;
	bh=W/Q6ucDflJPCvAGYIekR+nBTtaSHOPL2Ou05VQigNh0=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=wkXmDlhQKAazG+PsZDe4jEmZv+1EoYkWa5T0dvO8y7AkU6phPKW98WcNOjEYhz4pg
	 NEWT/oH10FaWdZSCUCvLM0XUZgaLYvFe06Y6aoQzvpicdfOt8WS9UEDz3xkHjKBvU3
	 Z3MyQGeZmVV0K/S8M6jZjF6P21OzvkkuYyImei7f3rZvOYfqSAHBuEzKcaMMm2FdCW
	 0eJov2j6jhHjM66xE+qA54q5XpT8Xktb93Ywxy2HzjOyHmgRJiLidlEcZA9L44gSoI
	 AH5ikZVQvQXnPE6LcwFrdd+oCHBhbUTe4VopPIBMQqj9SsvS099htl675tsx1i8SBC
	 kOPjkmBhr2LBg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QHKmX224WzSdJ;
	Thu, 11 May 2023 14:14:36 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2067.outbound.protection.outlook.com [40.107.116.67])
 by lists.lttng.org (Postfix) with ESMTPS id 4QHKmW0rN4zT2d
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2023 14:14:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub4sXb63Mgw0VcYeVzu29mnVVp6vAEfIDnM+s74sosgPcMACFqWMdYO2fyDvYNyqPSQes4oHAy2bQaVdNPmsDzgBa8TUfSbtGCKFPxevBjmzeCpiuHivMChBBtxygfprhHClOmavS+ZECMvIsg/SIc/v89XEpaQQwlS3tHIY0AyewCvjkl9qovYUsOtKVzbQ4cMI0byo7mAVOjih3bauj+5AHmVdoLA7WqtN95eUjw8mscOhCwtBDjI9wJCZPiHh7hjNpwBFwJQ0x328HvBF/bHgIDXXiXDMufQMsbcB/r6hKrdtBb01J0p4BR5Bg+mrt/xOEGngEAOBnUqQs+NrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh3v4nnBuQAXGJ7Anw5jELtJIi2ypNjE2efRgYg73PM=;
 b=di17IrAt0rldKZGvebR4T/jhIAbi1sBSPoJQp8gDrcBcNajlridyzEfY6uivicWdHQ3gnbZIXrpBDg8LYtjjjoQxXQzjbeTy1Qb2mT+yO8NykyvGXuw9Zp8xhE5H/ymDfa69xlhSCBs3VypPtvqQ7H/RMDY9FVzint2YfbDBGjL91zLMcCUIs5p1ci+wCR6jy7d1Fa6gi65zm+fXLRTyBRCZRaqAUHJMjNyIkWNrlG7TBdVal2g8+2isYbU6lInevIrg46M09rUwurFI6nB8cSVoZKy+p25LPa8IQkqHuC1nBVmuJaTuX1UL0nV6VMc/CCQoavG81XyOj7nfpGDeFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YQBPR0101MB5223.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:46::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 18:14:33 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e0fc:d614:3cdf:4313]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e0fc:d614:3cdf:4313%7]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 18:14:33 +0000
Message-ID: <6ffecb5c-fa2f-9ace-bc50-5b5f49f36d42@efficios.com>
Date: Thu, 11 May 2023 14:14:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: lttng-dev@lists.lttng.org
References: <CAFZh4h-Xsf7HGZ6A57BpuWH7CzogwV6D25vg05dOq30_MfxE0A@mail.gmail.com>
 <CAFZh4h8awEpJgAcygRY=1f7A2qK91b31HBnLBPvvueuRnquOjQ@mail.gmail.com>
In-Reply-To: <CAFZh4h8awEpJgAcygRY=1f7A2qK91b31HBnLBPvvueuRnquOjQ@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0272.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::13) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YQBPR0101MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e34c2f6-de94-4d18-a694-08db524b920c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgqfC4+A3b91ipFPzuXKWjIsDWQeEMJDbITKnj4tXBDvYukSeUX+B8BmXrua4KBfFFhoL3katlW7/Z0ZJW1Vk6wjnzgxn4CTQkyVivoRdwJIZziIxWrZ6ZORDdCMuBzYypETo0+i4GBGQwcmf1p571PWU/GDJwiX6v+bAFmBFUDk4RPYGqP5SlELHmJ2eN/1ImJ/iLdQjIRIBxMRhxip/KvZ5Ht++tIIfV7olJK9MoETOmIs8HbCldQVntn+A7MC7Uo3a5/qT/ovDMbxknxnNoUfGA9uUaH5/ntdfOiIeZq0n28JN9QFhh59tyd0x6fKx6tir8ZX6W+CqFRg91a8AmDvCl4bQvzdLwW6qUwFOcOdVvKyohy5KSTg3KyFdU8FsxdjR8r0OFW6XfC6HfIgZ7R3ioh5RK4a58WphWGb8SjsLyo6zaxeVc4SiTcEQzKT8+O6ZbZA3Y+WsAQRBN/W4wdHREQxfzpAlt1tmv0F6TJQcr2g3L7xFYT9uQeLN1OPtj4x6Sffs9TIFL2oKvGlCvM7BcedVvBmeg4AeLuH+BvJNm83GMBG+056KEmoFtuQBqSLOFj/CxuP0AxMN42DiP4XqKbRIAV7/AjkJsGrUfyz0Vr4lLk5hSVsg90hoKeBeZMvnNeFfYkZddZPW4jWcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(396003)(346002)(376002)(136003)(39830400003)(451199021)(31686004)(66946007)(66556008)(66476007)(6486002)(478600001)(966005)(31696002)(36756003)(6916009)(4326008)(316002)(86362001)(6506007)(186003)(2616005)(6512007)(38100700002)(2906002)(5660300002)(41300700001)(4744005)(8676002)(8936002)(26005)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEwvVmRZdDIvNE9FcklUcmNkenBqalhSa2cxazcwS3RQQ0dXSlgzUWtsWWxG?=
 =?utf-8?B?aDNMSWFKU0R4bDdydVUvckRrUWxFR0FiUkNFbUtxcXByNHl0RTRXM3IxRU1N?=
 =?utf-8?B?UlRWYWppbGZZYVUwYTlZa2RlcmpVaWIzYWFRSzE5WmYzTVVEdlpnNVJsSDUx?=
 =?utf-8?B?dEs1Z013SVZURkJrbW91OEEzVnhGRXJCU3VXRFFMbHg5dkhyNnJNODltWldK?=
 =?utf-8?B?U2dqREVKeDNBNEEvMXVTMEN0YjdCeTlGdllzZVRwcHNDaTZpZElXQitUT01t?=
 =?utf-8?B?bUpYYlJYSnNDdHpPSDRMdEFCUHM5TUNYZDVVaG15WUNrTGFxaC9MdHJ5c3dj?=
 =?utf-8?B?OTBuWm1HYlBSekxEUnBmSGsvdDR4R3BMeTNVbUtyVVM5bnZEOFh1cDNaRTJu?=
 =?utf-8?B?NVNDRHRKNm5IWGdWd1N6c2cxbExlOVZtZzJIbHpwaTBsYzdRWURvUTJWRktj?=
 =?utf-8?B?U2FraytpRlhWNFkvaXFXTkxjN1VDajdlMUx5VjJYSjlBMFJqckZjd1VRaGkw?=
 =?utf-8?B?UnZybkppKy9DTkwrYk55clVPenJWazRITURHSmVaU25PV3VQKzEzWEpmTnJV?=
 =?utf-8?B?QXpJKzFGWFpKMTVBdEZpVDVFS3JnVlhIK2UzNlJ2NVN1alVFU3hNT2Jtdkk2?=
 =?utf-8?B?WVk4Y2dadmJ3dmhIRjlvcVVQeWpkYTVoUmpsUS9TaU5MUFg0bmE2RmtJL3JS?=
 =?utf-8?B?RFBGWGEwUmt2Z0txN2w3NnJkNUxJVUplQVpnK2gwcE5BYTFvc2VOOHFxYlh0?=
 =?utf-8?B?R3NFb0RMSnl2Zkk2N0hHTzlDWElaZ0s0Qm9QeDVkWmN0RGtrZWlEWlF6Qmc2?=
 =?utf-8?B?ZXJNTy8rd2V6d05uZnZ3NWExZVFPamRSVHJKeE9PMTlCYUY1bU5yMjJmQ2Nr?=
 =?utf-8?B?azkra21NaEhLb2NMcytncGdOQjByOUtmbzhZSlI2NGp1OGxZZHJYOWh1ZThI?=
 =?utf-8?B?d2ZWYUhhYTc3VkVHTXhhSEJMVnVMWWJVUEdEcVkzNzRlbjlvdHNQd1RmZEJB?=
 =?utf-8?B?SlZ3cC8wbVZxMXJGbVljWEhoaXJzWkpQK2daa0ZpQWJkVHlmcHpaYWNLeFln?=
 =?utf-8?B?MVN1RUlpNGVxOW1WUmxKUUd3YzdSSitLTndDWFNuM3JyZzlySUFGL2ZwdFZZ?=
 =?utf-8?B?ai9pemMwZFZFZWpGNy81bFN0dkFTT3UwSmQ0eURmUGpnZ3p0bTVrcmN6RHNJ?=
 =?utf-8?B?WVRyWmVMVjl0YkoreWRQa3hLWVlHY3pkV3dYUFVpOERuQ2RpcWk1S1JYejI1?=
 =?utf-8?B?aFFWRmQ0YUFlQnREdjNSeXdIUGhYWGVHdlpWOHFzNzA0d0VZRjR3OHcvSDla?=
 =?utf-8?B?UkZTUU9pcWVvS1FuVU1GTE9jalFSL2krbndZUnJXM0NHdFNDNldYcEFva2pM?=
 =?utf-8?B?dllISWllVEg2SVR0UXZEQUh6SkxFUVZUU282Y2wxMTRSZWR2SFZVb3VUdGtw?=
 =?utf-8?B?SUs3RFZPdWVKQlcwM0cvVVpXckxGajR3K3Jzc2RJejA3aFpaQ0huQVdJQ2V4?=
 =?utf-8?B?TFdRakF2Z0RyRUE0TnhhTmEwaDJVWUJnVmwxK1FEMllwUHN3VUs4cTRiRk1N?=
 =?utf-8?B?aGZJZ0lkanpqSEZIaXgvY2RPNzZCeG9WWUZGbnl0QVZXK0NvMnJCMUNvZ1Qv?=
 =?utf-8?B?NUR6SXVHZHZ1dTR2MU5KZDYrSit0OGpUaGZ5dFBmNytMQXU4SHl2Q2l4VlRW?=
 =?utf-8?B?NXhaTnA0N0MwdDVpOVdHOC8welRxaHl5NFRMRWt0bndrVitFNjdtSGxDbEE3?=
 =?utf-8?B?OUtnblNhRWp5d0llK1RlUm1ZdkJMamNCaXdFUDZEbi83K3kxZ0swWkVETWlh?=
 =?utf-8?B?WUZaTGJpaVBsbFRXcTlxUFZ1SWErZmF4QzFCZ29hRVFWcUFTVFZWV01LVUM4?=
 =?utf-8?B?N1gxb0FmczVjWjJTVDhvWDhZNWZHVFZveCszakVlQnhLOUFjV2RrbGNkWHRB?=
 =?utf-8?B?ZnRlcDlHVFZIOVBpS1M1ZHE3cllvUWZaa2RNWGYyWXV6bDE0SWZLRzJvcXNo?=
 =?utf-8?B?QVhJRUFKbU1lRWtzd3ZxbWo4Z3dBZDNEeWk4aVpzblFTV1dLNnBoU080bTFN?=
 =?utf-8?B?TXkxUUVXS2dQSzc5Mk5BbHhrakFYanExVmlkTEc5YkRzSlRUU1dqd3kzNVNl?=
 =?utf-8?B?T05id0Y5YWw3YTlJMmtGYVh6bEVuamVZZUJudlZYSGsyVTJ4OTF5R1R3bGp0?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e34c2f6-de94-4d18-a694-08db524b920c
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 18:14:33.0787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyE4gWO6yvpZvEW76zQ3fx3bilYfHt1v4XPQJNWOLIFHRjj8bT3N50cCX8v1d7ICKNHOBDo+jWWK2rUYUR1NZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5223
Subject: Re: [lttng-dev] I'm still getting empty ust traces using tracef
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

On 2023-05-11 12:36, Brian Hutchinson via lttng-dev wrote:
> ... more background.  I've always used ltt in the kernel so I don't
> have much experience with the user side of it and especially
> multi-threaded, multi-core so I'm probably missing some fundamental
> concepts that I need to understand.
> 
> Regards,
> 
> Brian

Hi,

If you are static linking 'liblttng-ust' then the library constructor won't be 
executed and you'll get no traces. While this setup is untested and 
unsupported, you could call the UST constructor from your application early 
initialisation but that would require patching lttng-ust to export the 
'lttng_ust_ctor' symbol.

And the first thing to do to start diagnosing UST tracing issues is to run 
your application with hte LTTNG_UST_DEBUG environment variable set, see [1] 
for details.

Cheers,

Michael

[1] https://lttng.org/man/3/lttng-ust/v2.13/#doc-_environment_variables

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
