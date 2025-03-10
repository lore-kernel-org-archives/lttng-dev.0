Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776FAC282DE
	for <lttng-dev@archiver.kernel.org>; Mon, 10 Mar 2025 17:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1741628224;
	bh=pCimWH3AdsXAHdr62cHR//i1S9dcW33gJ83TFWBIm0o=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=PZnRfkB7HxrK20dc9mvd1QY7IitoTScffhZSPvGmbjnR02hI/h4Hkc7ijo3kRAdEx
	 Cd+KTQ9F2w+v66GHMvaTDgQbID+HaxvEmuFSsCJMu5UJd9cWlt+Q3mIB7Hd1P2KeMp
	 MmyisJvSyB6w8aFDFN2lDr2TaAmKL49VMN5cXb+bKn8Iw8R6yIuuCoeGxYYW7nTkFd
	 FeMsmsW/XwYZCoflU76sMSy4IaoY2GU9IEwMoM/YrxycMOsGg7XiQIxEtzGE/iR2T3
	 WCWzlXHKyMTt6h9uSiCYNs9iGrZ6bl0xv+vlC52G7YEspCXNOgox35m3d/QjE0yQfL
	 aI+CIyoMMn3yw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZBPGS1FGhz1mjv;
	Mon, 10 Mar 2025 13:37:04 -0400 (EDT)
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZBPGR4jwFz1mgr
 for <lttng-dev@lists.lttng.org>; Mon, 10 Mar 2025 13:37:03 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuOjqUE/SGAHBzKdc37UVRt5fdWUMuJrxcKCGeYe0yuWiJbFX4AWCH1+tBtRlVHSakQiy7S74uinNTkNzO6f1skMF/ZJaghhw+a8E4ineyy00C9MLtC6U7d0ve25n2cfs+Fa+mEsVSgASIQ3Yr/T818pN/2dlsZrMHcN3C06phxXYPLvRVKr4jckZnh/ZLxSgLLKX/8o4vhytcsDROdw5OY5oHNiqiJee7d6xnCRO1+n9l/PBjFsoUJTuJCTTRhyqGVW/HhR7r+HMPESnScOof1gbf7jGM8d2370gFgYtt05qiQKL0AuUkAx0NrudNBmil4V8LIgPp21C/jophovjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q61QfOkPl0PYVI1l60CCErJwKvTHul1xaFH+Z3xylpg=;
 b=USKuoWHhnkmcjwcpNAid/pbi94IHcqC5nv85WReCW8vk7MqFiFAGKrvW018UCgh+eIZJHLuIm1VtOWHTScePQlRJCGotVx0YdcOrtEd1DfGow7RpX9WscH+LN9qFfx14efdvMoeeTAhp0xxtsiXCIXMBg9PlGy5JxfdEMUbzG2gPeDo6bUfN7ckr7c9bjG+nj8qt7uxS/6odjqBCMEhDdUIcKCLbqRjMQHrjlUmKj8QKsSW//JWdIAkdi5U5KPjeSu9gLooDYMg6QcebrXxyXXDtdmQxIptSIOWAGJGzsIt7ikoxkED+1OOfePZDXNHxwqZbd6nvGk4K4rk4dsBMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:91::8)
 by YT6PR01MB11298.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:13c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 17:37:00 +0000
Received: from YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6d35:443f:e789:df9f]) by YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6d35:443f:e789:df9f%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 17:37:00 +0000
Message-ID: <a1a58744-f98e-4498-9be2-f2d93288bd40@efficios.com>
Date: Mon, 10 Mar 2025 13:36:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Github Action Runners creating world-writable shared memory
 section: lttng-ust-wait-n
To: lttng-dev@lists.lttng.org
References: <CANTRYLg9VSJMeJ1XHcBCtUfiaGiyyigCoLcAdrX8r-CM+xeDEQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANTRYLg9VSJMeJ1XHcBCtUfiaGiyyigCoLcAdrX8r-CM+xeDEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0297.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::16) To YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:91::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB10347:EE_|YT6PR01MB11298:EE_
X-MS-Office365-Filtering-Correlation-Id: f899edd7-6390-465a-b9be-08dd5ffa29ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWl2WndMVU1hUU1UbFZaV0lHYnl1cEo5ZmlDMHovemtrKzRzUWF6USs2emMy?=
 =?utf-8?B?M2JaSnovbmtNaFh1Z0tLRndYbFIxNUszUE90aUVDTkwyZzlFRzZTTXhEUXNJ?=
 =?utf-8?B?YlMvR05PZUJLY2JOdk9zKy9aU3RIQlhVMGxxOGVBOHJnU1hPZE5QcXdSZU5p?=
 =?utf-8?B?UjEwZjNrdnV2VHpLK0F4UHlKQi8zMUFDYUxaUTJOaW90dGIrck42WmVmLytP?=
 =?utf-8?B?U3lpUENMMHJPV0RCeDltR1BueC9PbTA3UTNsdndudktSRWZ6SUZqay9JT1ZQ?=
 =?utf-8?B?TlpmdS9UdnZwQ21qYkhOM0djNXVhb2hQMG95RzdzV1ZJNDhLcEJnR25pNloz?=
 =?utf-8?B?Ukc2anlMeVdHbyt3RytLQzh1alZ1RmRuTUhWZlVPcWNHaWNUSHU4QUNPZGRP?=
 =?utf-8?B?d3J3MWk3Yk9SeVgvWk93VGZsckhwQS9VSElVRjdYRDNzaTlMVlV3TXB6THVk?=
 =?utf-8?B?WUU2cTBGVWFUOHhwN3JxZ09RaWgxY3VCa1BoVktzd2dUQmVrM3JiczJML1gx?=
 =?utf-8?B?TytXNFA2MGgrQzZRM0F1cnF0UGhBSVRLc1dXeEgxZlFsdStYdUJKZzJIMUM2?=
 =?utf-8?B?NTF5WFU0UXppaXQvbHpOWVdwK0Z6VWtINmhTQUxCb0xrOXVGci80WlNlWXBJ?=
 =?utf-8?B?Yzd5UnhIMmx2NFJGaHBMNEFVQmtjYmdaczZwZThleG5tL3M5NVBIZmZ6MXh1?=
 =?utf-8?B?ZVQwUzV5QlluUWFzcmpJcWxIVmdzbExUVUdCUEVjZUxLOEVvQXBQaGl5M1k0?=
 =?utf-8?B?RGh2RzBGaVdLelgwYTUyRFJWWUgwUzYyWVlVUHFIODdLNnNGMW4rbFhqbGc0?=
 =?utf-8?B?Y2tRUXk5MWp5WjB4QmtUekYrN010QitKRjR5ZW5oRmIxbmpQWU9TUXZiU283?=
 =?utf-8?B?ZzBEa2NOcDBycUZFMWt5TWxqR2lJb3RaaGUxSjJyRGF5eDZrdjJxUmJ2UElx?=
 =?utf-8?B?OFVHc2pXN0JuN1VsTmkwSFNFWWJzdXphanZkSS80WHBtQVU4TGg3NG1KUU9n?=
 =?utf-8?B?NXI4NWRMNU5Fa29MeFNja3BjQlUvMk5pdFFVQkZ6blJMeGVCV2JHcWN5ZzJD?=
 =?utf-8?B?YkYwRytQQThZR0s4S2NLNE9GSGorWTFHdDBqaGtrM0NzZVZoZnNvaFNySHFx?=
 =?utf-8?B?MnUvRlFuMUlRVDJoaUV4cGl5M1JmR2M0K1VHazJHVjNxcWZ3YW1rY3RWbmNS?=
 =?utf-8?B?OVNlbGxrOFJNOFI4ZHNMT1MzV0lCRzNxSlk4dDVybzRzNEdqKzU3OXR2Nm1W?=
 =?utf-8?B?R2k0ZFN1QkFUeVhCNXVIMW01N3FMVUFJWEtYWkNtMTQrS0R0OHRZSW1qcjJ5?=
 =?utf-8?B?RkluVklMNy9UU1BXOHZRU08wb2xXU2swei9GL2hFZXBoYnAxNzcwTUwyZ25r?=
 =?utf-8?B?eUxZWXFVRmNYS05TeDJieHZ5KzBEYnZzcU5qN1VpOUo5aFVOU3dXVFJ4RDVy?=
 =?utf-8?B?YS85OG52YXhxclNldldQNjRpWHN2VWpwZS9LMWRuNmRURW9ZK2hHRmdJM2Qw?=
 =?utf-8?B?RS9QUExPZXRIRmtvZE5oaFk2OWV3eklVUWRUdFJ1dC96aDFWVTRTQk1vUzR1?=
 =?utf-8?B?aDRkOU0wd0FlN1dFSG9kUUtuamRzQmNsUTNaOCs2Tzh5STZUUXhybjR1Znls?=
 =?utf-8?B?UTk5OVY1Rkl2ZUJKTTRxNE1xOWMzbVF0NmU5eHJSRzZLZ2RIemp0UTE2TytH?=
 =?utf-8?B?S2hkR252Tm5SZWNvQ3R6MXhZQ1RFbE4yOWlyaTNQZkNQNkllcXpOYksrSjFU?=
 =?utf-8?B?YUtpSU9PUHJTMkZoSVdqLy9mcHJpMDlya0lTd2ZRNFN2MmlpNnI3YlpkZ3py?=
 =?utf-8?B?cFpmWVY4WHpEV3ZwTDNKdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHN6RHBMU0x6emNrakFSc1dTaWdYeE95elVSdjBRZUZ4Yk5wSkY3MHFsSjJQ?=
 =?utf-8?B?VEYyY1hUdk9HVHNqQ29leGk4LzlNZUdBVnJxRTYzQUV1cFV5UkhZOW1DTk1Z?=
 =?utf-8?B?TUhmVGZ6a0JzTXV2NUFXc2UyRU1pVHNac3JHRjFWZnY4Q3ZJTEU1emFYUDl6?=
 =?utf-8?B?TEJIZnVIeHd4d2p0SWJuOEpENC9zNE9ESXBseDNOVlRRNVVtVVN1d00zVjhX?=
 =?utf-8?B?bDZqcGZKNnFITW9WVDlET3U0ZXJVeTZvWWNzQVFFK29VSGl4bHhpMGova2NR?=
 =?utf-8?B?cEtwd1MrandWQnpIcENiQ1FGTVhWdm1HdUFCWVQwWXFDRWRTSkZoS3UzM0FW?=
 =?utf-8?B?b25zcXE1ZU9pY0lVbE1yc2VZYWpZR01MWnZxdHhEaXJJZkJIcUJ0dlA1MGcz?=
 =?utf-8?B?V0UzYUtKV3doQkFGdDR6QmJUQkcrUUxTRzNiek9hWGZzbzkrbmY5SERSaS8r?=
 =?utf-8?B?QjdwV2RnSm44SmxPTVg2STdxV0huQXQ3c1dhRVRuZisyUWFyWWVkQkRTY2JW?=
 =?utf-8?B?U3dxeEdkUlRBY2NjYnMvUDF3aWNDRWM4VjJIQWVvUTYyamJpdEY3NWVpTGo3?=
 =?utf-8?B?R0gyUHErUFdNZnFzRi9kMzhtcnN6OGFYeUJtUkNQeDI1M0g5QWlaeGE1YXdx?=
 =?utf-8?B?d09WYzE0V3hpZmsxYVlLdHBwcGxWbzBuRzhBY3FWN3pTWmpqMThQS29ORUs0?=
 =?utf-8?B?OE5JOHIybERYakh5U0JtL3VDSDhrYW1sdVdKTDhUZFQwMmhybjU5SFliNnBm?=
 =?utf-8?B?T1h5dEU4ejRXcm96NmthL0xpMjIrZFBXUmZEZm5jclRLbzQ0N3ArQnI1dUpi?=
 =?utf-8?B?U1lTa0taTDZnbjhwbEU4NXpaRHNOelh1d0pSWmlpMHpxNHQrcXVZYUNlU1g4?=
 =?utf-8?B?WnFVZTJTcmE2c0EvSTlzc21HOHo3dWM0dkZURGZTZy9UVEV1ZU96dmJvb0p3?=
 =?utf-8?B?bHpGRnd3czdlalM2b0pORXRrSlVoakxqWmpDSkUyZUU5S1BkclBMYWxad015?=
 =?utf-8?B?Zko5MVZEektXajYrc2JaTlNNYTE2UlR6Sy9sRUEySlp4allkY0FsNDNObklT?=
 =?utf-8?B?RWNxUFltNHlSU0JvdExjQ0doQ2h1d0czRUdKMktVR1lmZU55U2VMOWlLWXVM?=
 =?utf-8?B?aFgzbldhZkk1S0tycVFaQjk3SUQ2S0pveWhlZXZZQU9yKzVpalJqYjJvV2V5?=
 =?utf-8?B?UWRVcnFZaDMwc2VReWQ2MUErNmtGZGZrdzNKTWxUSmd3ZFdUaW94N3lmM0J0?=
 =?utf-8?B?a0Vqd2cxVG5VYVlLbVpTenRnbmVMdk9UamRDbGpubGY4aHk0RW1xajdSWTlG?=
 =?utf-8?B?Qk0wL3JZUS91STNKMG1Tc2JJNzJQL2N6emU2TVFyUW1XMGE0Si9NYVdrWU9m?=
 =?utf-8?B?QVk1K0l5UzhTUFRoMDNmN3h0c0R0eC9RSXFCSytUeTFpTXkwMUZkeFhyc0pX?=
 =?utf-8?B?NkM2NlBMdTVIK0VrN2Fwbkdvd0s4aklWb01SZ0FZN2I5SUpZUXBRbWQ3WE9h?=
 =?utf-8?B?djlONnB6dnljTmF2ZlhWbUpFUmp1SmFNL1RwYkVxWHNsQ3BacEF1SnFPWG9i?=
 =?utf-8?B?bWZpS1V1Y1ZYM2VpaDdaUDdFQy9QVTRqOEF6M2ZiM3JzY2tsOU9oOGduZ3ZO?=
 =?utf-8?B?QWJJWTB5bWtrRmxXVWRzSEwxWGJ4eEF4Z1ViOXdqbTdiVG51Q3ZWTzJTRm1Y?=
 =?utf-8?B?K0w0MjJGbENrcEdIUW5ZMGNCd2MvSy9Bem9vcFdtSDBtZ3R2OGpMOXgwdFgx?=
 =?utf-8?B?NlpscTJJNUdUK1FxeHlxd1M4RmIxeE1EZjU1YWtWVnBPMytwcG1MRVlpRnJ0?=
 =?utf-8?B?M2hGS1FDZk5hNkVZSlNnSHp1VFhHbkg5WVF5b01ZS2NQUjZBTTVEeWdkYWdF?=
 =?utf-8?B?cDBWQTFHaVh1a1BobFMwNEpUMi8rK1lOdW4wRXhDQ2Rsc2wxOHpQV1hScE40?=
 =?utf-8?B?ZHFYQXRSV1phLy9BYWRZUUhyRGRoTDg5Y1RjUFFyangvaHE3Z0l2RVJvUVFi?=
 =?utf-8?B?eVhyRTBmRXp4WDcyRTh0ZWlOQklGLzgrdjBraGVRNWZsbG00VklqT0hTM1I3?=
 =?utf-8?B?QWlWdjRETENWaEtENmtmYUorMUU2M1BDTjRCYVFHMUpKR2Zyb0tvanI3SzRz?=
 =?utf-8?Q?d5V06sRUzG77N1ITropMuH027?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f899edd7-6390-465a-b9be-08dd5ffa29ce
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB10347.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 17:37:00.5752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxhrGap2ea5yn+NLuXksxb2bW0t9Z8XD8189JbLZ/nRfmTFXtOrITeFKV9x44+u9/cEziFq7m7S2GoSsY1ZxoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB11298
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

Hi Bill,

I don't have the context about gha-runner to answer regarding their use 
of LTTng.

I can however, give a bit of context about how the those shared memory 
allocations are used within the scope of LTTng.

These shared memory sections are used for presence/absence notifications 
between lttng-sessiond and applications instrumented with LTTng-UST.

`lttng-ust-wait-8` is intended to be used for applications that are 
running as root, or those run as non-root users that are members of the 
tracing group (if configured).

`lttng-ust-wait-8-NNN` is used for non-root instrumented applications 
where NNN is the UID of the user.

When either lttng-sessiond or an application instrumented with lttng-ust 
starts, the shared memory sections will be allocated. There is special 
treatment for `lttng-ust-wait-8` since it may be used to notify non-root 
applications that are run by users that are members of the tracing 
group. In that case, it is created with an extended mode[1], as you are 
observing. Those permissions are updated when there is a root 
lttng-sessiond that starts and opens or creates a shared memory section 
at the same path[2].


On 3/10/25 10:12 AM, bill robertson via lttng-dev wrote:
> GHA runners appear to use lttng-ust for some sort of IPC between runners on
> the same machine.
> 
> $ ll /dev/shm/
> 
> -rw-rw-rw- 1 gha-runner-7 gha-runner-7  4096 Feb 20 04:03 lttng-ust-wait-8
> -rw-r----- 1 gha-runner-8 gha-runner-8  4096 Feb 20 04:03 lttng-ust-wait-8-558
> -rw-r----- 1 gha-runner-7 gha-runner-7  4096 Feb 20 04:03 lttng-ust-wait-8-559
> -rw-r----- 1 gha-runner-6 gha-runner-6  4096 Feb 20 04:03 lttng-ust-wait-8-560
> -rw-r----- 1 gha-runner-5 gha-runner-5  4096 Feb 20 04:03 lttng-ust-wait-8-561
> -rw-r----- 1 gha-runner-4 gha-runner-4  4096 Feb 20 04:03 lttng-ust-wait-8-562
> -rw-r----- 1 gha-runner-3 gha-runner-3  4096 Feb 20 04:03 lttng-ust-wait-8-563
> -rw-r----- 1 gha-runner-2 gha-runner-2  4096 Feb 20 04:03 lttng-ust-wait-8-564
> -rw-r----- 1 gha-runner-1 gha-runner-1  4096 Feb 20 04:03 lttng-ust-wait-8-565
> 
> 
> I assume that this is their code, and not some configuration issue on the
> host machine, but if this may not be the case, can someone explain what can
> be done or point me to information on the subject?

Could you clarify what you are trying to achieve?

> 
> Otherwise, is there some sort of environment variable or other setting that
> lttng will reference when creating this shared memory section such that it
> is not world-writable? All of the runners run under user accounts that are
> in a common group.

In LTTng-UST 2.14+, setting `LTTNG_UST_APP_PATH`[3] will disable 
connections to root (global) lttng-sessionds for instrumented applications.

> 
> Thanks!
> Bill
> 

[1]: 
https://github.com/lttng/lttng-ust/blob/ce89cb05f0fc02b68396220815070996fa0bb4a5/src/lib/lttng-ust/lttng-ust-comm.c#L1705
[2]: 
https://github.com/lttng/lttng-tools/blob/e995b146f3456dd51fd76288db6dae9efdbce592/src/common/shm.cpp#L118
[3]: 
https://github.com/lttng/lttng-ust/blob/ce89cb05f0fc02b68396220815070996fa0bb4a5/src/lib/lttng-ust/lttng-ust-comm.c#L611C9-L611C27

