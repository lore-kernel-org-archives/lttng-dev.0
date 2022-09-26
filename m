Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE9AC07E9D
	for <lttng-dev@archiver.kernel.org>; Mon, 26 Sep 2022 20:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1664223122;
	bh=DOw1O9LI0hAGT4+24wVg0vxrQX1dnV01yOEaJP2V6Js=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=t5/Vs6eWXTlQrb0Y8IFED8+RHdCHvs5CkByBVA/EES2/3Z3O6Jccz+xzWXWqnwkyL
	 vm2RX4ih55V3J2K9w5u7H6dV2AFBOL5rgmEDJnEWxw9KfiERxlwA6y1Ar/fxmJVqP9
	 lgCVPNxMR4tWJ494Jjd8xil/ayMrL/Qrafcib0rgRr78WgiydAROb/jg8Z9Lxxur0i
	 sZ7Z7EAREpPloC6g5KrmtRsJRGceM62mX2hEFv6PLPQY19h8PZRD3Ic5ZIlrWOhF88
	 qUuVsQYiC7sEsg7rkzPVsKFKDWlk5bNLBut71bkW2nAkHzO8r+Io+cLd6qUFVlcYZT
	 DgjFS+eZTSx5w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Mbv6n6l8lz25XD;
	Mon, 26 Sep 2022 16:12:01 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2089.outbound.protection.outlook.com [40.107.116.89])
 by lists.lttng.org (Postfix) with ESMTPS id 4Mbv6l7088z25Ft
 for <lttng-dev@lists.lttng.org>; Mon, 26 Sep 2022 16:11:58 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB1CiSeQIE0ovgMffLWtLNGRKBkfm9l0KNvuW9ZgZ02v9e7c2vYTRh2jhfhrs07uNlGoAJ8nW+VHoOIOu08DPV1Rqw9f5RKetXNg/aXnkIEsf8nWYlT6gCsEaOOrZet+Mb+wSAkOuFXtE8aBgTOWPlPnJSj+cvk3yyuV/kN0FAJlKiINc/6d+UckXd1zz0OuoMomfAhqelvqHRVECsp9mOhA0AOxvftL/JhY2uLVWx+4SRWRyxtTCY04cU4x+gblsRlRvcQnQ1qcbTKvBFtn8R8RAgkOeWhzOSBE6Ea7gZ7VcSKMRC+FvBbATrrQ4cjpZ2OoPF2wIndBMNdcjxvdfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55fwT+MGCU27HIU6FZaBIOT9GdmNUseInY8HXc9n+u8=;
 b=jKnvh9k0PX1qVu476vaXJKFJ3ctR6WVF3n1+dRXZGzcTQXG/UdoJG/XWncucFzZpPJSY9uJMiTSZr8w0s+aFqLRSityBhHJ56Kz0Gq9qFOOEfYN1Gk+MJ1RtMpqSm8GKlA3AapTQKnFb8A96obBiAsyIYosMINizP9wQUmb51bQvvyMkqfMZ5sRHnDgig9xZS+BPHDcHAQzDSnpZDXzekhQTPiKwjn5VJeD6uO6l2ttXAO0pPfMvsP0+ZY2MRCZwsNoGaGYIwIyp/6lVlwFx2nde+9AS8JiUUvS8X0ne7rB3v7Mx1uThKL0YTDAWHWYaevibqz8z4qNSbxnrS1a3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9160.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 20:11:57 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 20:11:57 +0000
Message-ID: <10d760d3-7622-2b6d-ea98-39534e2a1c8f@efficios.com>
Date: Mon, 26 Sep 2022 16:12:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: Eric Wong <normalperson@yhbt.net>
Cc: lttng-dev@lists.lttng.org, paulmck <paulmck@kernel.org>
References: <20220922091536.GA4597@dcvr>
 <eb0bc02c-904d-1166-ddcc-39bbece70a67@efficios.com>
 <20220923175503.M564483@dcvr>
 <6db30f66-8237-fef3-d92a-2e36be9efdf6@efficios.com>
 <20220923220510.M990534@dcvr>
 <a0d4a174-c210-33d8-9e31-0d7d1b6900c3@efficios.com>
 <20220926195829.GA10587@dcvr>
In-Reply-To: <20220926195829.GA10587@dcvr>
X-ClientProxiedBy: YQBPR0101CA0340.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbdc20d-ed9a-4f16-eeca-08da9ffb5d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNnvVwsSdOMRXTAk50Kmjzwg5paiHzvL/ytbqIPY+4zJgvFWY8zh7fW+oA4bYrmS5rOPEopoMxZ1BKsEUrNpLOyNbQ9/LObCRVUB574NQ7DPFR3w9Dl1Vwhc7sqqWLRklJeafZ72QjG1z8Z+YH2EMbrsQiSMDYmfoJVmEYo0c3BycVSmqsObbST6uACxWETJB4/qSW4qiKNxnZdrd6AfIuCrSxEYROVX5ocbE6egHtRPvEo0qwPXlBmQnk0EKbdxmVH5iiOhfo8qmm+B+Eae/fxpF3PZAKQTItT8myc2R6mLHMMLjnGtClRX38AGfmJmywiTDMb+UOroC3t6muRp/9B6PHq8s3hfK7Xatnz3qaR7sy3vHMZRP6uabOEGMGLSil59u9yPhqptNQC87B4qJ98+9u6aDGw6jI4z4LdJ0I06yRD07RhR3wUDZfNYxWDHCVR7RjJNivoXT4isjZnGLpQghnfJ5wF2DaQXdprHm8VGOOxXjOJCz3wzLYFmewW4LD21j/S83FU9ZilZQvMbXzE0/rQ3ZCxEXTBjk6APJbS8TrxuAapstnKybJrYou22VMvhBg5+6sXrM1QMILHkX3i6DH93vO1N4suM5QPX3Z+cVAFGd9KXw5uPrN3ZuhpLG8DVkdFikQtntwJGuH/2H7n8E4ZLKX+AdD67515XjtNlVcN3Gsx+Em2GN66QMZtCaR5lLDlpaBEXJnOR4FTeYRkRUkKzKYMO5LgrV9INTdgRlqNEx2SY6xk/vwlVn5mc6WWU4pkyPlXydayYEacRKJTJNhiLvxTvT51INuwHASDFHNEv8G9LmL9XREW7VhfQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(346002)(376002)(34096005)(39830400003)(34036004)(366004)(396003)(136003)(451199015)(36756003)(83380400001)(38100700002)(8676002)(66476007)(66556008)(66946007)(4326008)(44832011)(31696002)(2906002)(8936002)(5660300002)(6666004)(53546011)(6506007)(86362001)(6486002)(508600001)(966005)(2616005)(41300700001)(6512007)(186003)(41320700001)(316002)(6916009)(26005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDk4Q3dNTTlYYzNwOWpEVGRvOE5sbWpyN0Ywb0Y3OEtXTHJmTWNPOENKU3p4?=
 =?utf-8?B?ZDNPVGlmemE3RUcrVFRuZjNSUW9aUUdYYlRrL282OFdlRmdOSDhVdkZ4T0xw?=
 =?utf-8?B?RXRVSmlvK1IyWlNWZUZOTVMxZnoxZEF5NC8vRkVrYzBBc1hwUlBkM2NiZVlx?=
 =?utf-8?B?NGdWQnJ5T0xHK1hhOSszSm03dS9SSkIxMmlkUnY4V053VXRJMW1pV2VtQmxm?=
 =?utf-8?B?MWZiM2p3R2dIcDBOVXhsZXRkT05HOFVrb2xqR1RQMXQyVElXd1ErZ0pId2FD?=
 =?utf-8?B?L3ErUmcvem0xazBhRk5rWVE5anRqeitwdVV3NkNnVWVtcDc3Y0swMTJCSElW?=
 =?utf-8?B?bS9pY3JOdXRuRkRXU2I0ZHdCd295QjM1MWlieHYxVWIzdWlpYzIwNkR6Wk1j?=
 =?utf-8?B?eTBzd3pNTUpDRFRMQW1PRURxeUI5OTg4RjBETDJpYnp5M29ma3BRQmFiLzND?=
 =?utf-8?B?MlN0RU1SSzZSeitrUE5rOTFEVkNXRmdVL0FiZVlMUUJ2OU1rT1JMYkpTR2xu?=
 =?utf-8?B?MWc5Q0hFLzVzbnloaVFLYklGem1LRHpEL05HRE1kTVRXd1h0VnA2N0lVL21V?=
 =?utf-8?B?ViszYkZRZXBnTkZJUlBSQkNJem1DTk5lRXcvZmh2c01RTkpOZ0hpNW80RG40?=
 =?utf-8?B?Q3hjSUFpQW5VbFVTMDR2UXVSU1ZMVlUyRnR6T0l2NXQ2M1BrQ3RXZExheDdy?=
 =?utf-8?B?NDJ2TW1MbkNGNndFWisvTlY1VnJlbjdGQnJZWmRsKzdMVHpRSDB3cFFMRE10?=
 =?utf-8?B?ZjJwUzd1KzBQMWZyZmxwV1BSdEdDVVZmRGNMd0MwNytmSjBEZjNnZGxwTldZ?=
 =?utf-8?B?V3RZbGlFaXJYamdXd1dFRDZwSzVENGwrZ2gxMDAyZTRNWDl4aEJXOEUvOE9j?=
 =?utf-8?B?RFAveUdYcC9SVjhoSVdLUG1uRFBiajR5M2VlR24yOC9sb2FEWGZmclI2cTFE?=
 =?utf-8?B?RHFva2Z4OUNHQkF1Q09hQWp6L1ZhV2h6Zm1XZkdkbW10ZkJ6NmdjWE5seTFh?=
 =?utf-8?B?RjFkQVNTRFVReUJlZVdTNW5KWXFudHBETkpmTW1qcDd2UlcvMWZQMEFQbWhS?=
 =?utf-8?B?eXV6TURleEYxM1M4R0tzSHJHMS8vNFlxK3ZrWnRZWStuS0VMOGpUSkptdWRi?=
 =?utf-8?B?YjRtdGFKU3IrR21pS2VQT1JkaFozWTdtNHZmRE44L0I3RDN6UDRTdGY2YzQy?=
 =?utf-8?B?SGJVWnJ5RTl0MEQ3eWJDNEt0WWRLVXh5Z0tReks4V1dOMUJTak90QTVzanIz?=
 =?utf-8?B?TTdUNVFBZVZwOStpNWRiUTN1cHplUnpGNldNZkFXMTZMVUd4eU5IR2NGSUIy?=
 =?utf-8?B?RE9qNWc0eHUzOTNjV2VYNHN0NDVJU3poWmxrKzdnUkE3SDBWQ1YzQkRLSVFE?=
 =?utf-8?B?MXBTd0pZaURudjZtTGVHRlpkSS82VDlMbzJMbU12cVBIN3BYb0pmYVVIclhY?=
 =?utf-8?B?czJlam9ONXFRSnI1OURFTHN4ZUF4Qm4zaFF0SzdWNHJ0QzVxMS9jUzBTa0dz?=
 =?utf-8?B?akg4bnlHaHFRbUx6MC9ybW5OQTVvT3dWMTZWQ2NIZG5SM1NtY01qNDdyUVNw?=
 =?utf-8?B?eHQ0ZFBicnhNbGFGQVhwQjNPQ1F0NnV3SFM0OUZnWnVLc0xFV2lBYzBWRFZQ?=
 =?utf-8?B?NlpXUFQyRlBRaGRMN3EyUExOQ0Z3ZzN5YXp1ZXBmRS9vM1ZUcDVqU0gyQW05?=
 =?utf-8?B?alN2RzB1dEZ1SGdkdXJrZENmRk5iUlVJM2x2Z2ZtUERNM2ZLeDh3U0s3V3Vx?=
 =?utf-8?B?Z3EwM1puRTVjemlUYVVNWUNDT0FIRThNTGxVeVN4QUgvNVZhSFd3L0lvaFh6?=
 =?utf-8?B?M2ROeEIySm11K0k4NkZJOG9nbFlKV3lBRlk3aGNzQVhuRllDaTRhMERYcHcy?=
 =?utf-8?B?cmQwc1ZXK2JiaTdoK3VBSUxmYmxvQjMwRWtBYmtIOEMxbzI5eWR3SjMwd1d4?=
 =?utf-8?B?YXVlTFRuK3Z3Z0NweVFLNFZsNVZjbkNlenhKSVZOWHBHUkgzV3dsWHo3SjRO?=
 =?utf-8?B?OTh2NXBWVC9Dck1KUUVOZzdxSkN1UHBCZnlUV2o5bjMwSGVaazZFbUZlVkY3?=
 =?utf-8?B?VmdlM2NHQUxIMVZVaDIvclJXR2FUc1owL2xBc05pekpla3BpVUt5TWJiRUVS?=
 =?utf-8?B?Z09mRjVKZUs1NFVlZDNNRUFuMGl2QVZZd2V3MmViUzlvSEp3bERwWE0wcXFB?=
 =?utf-8?Q?5BeETLSgjxoJfwNkJXoEGyI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbdc20d-ed9a-4f16-eeca-08da9ffb5d0f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 20:11:57.4215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGEboczGoLTllK+KpOBQfyY9LydqGxhwahlPv0eXRBXSzlO4H1QMU1ewV2cznyuPdgjLYyDjoLDKdcXICAMlOoMIDL2imcturMcMa0zCLM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9160
Subject: Re: [lttng-dev] URCU background threads vs signalfd
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-09-26 15:58, Eric Wong wrote:
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> Do you mind if I fold our 2 patches together with a Co-developed-by tag and
>> use your Signed-off-by ?
> 
> Looks good to me, thanks.
> 
>> Then the question that will arise is whether this change is sufficiently
>> self-contained that we can push it to stable branches, or if it's master
>> branch material only.
> 
> It seems self-contained enough and fixes a real problem
> encountered in real-world usage, so I think it's suitable for stable.

That's tricky. I try very hard not to introduce any user-observable 
regressions in stable branches. I can very well imagine an application 
which, for its own peculiar reasons, would expect signals to be 
unblocked in call_rcu worker thread callbacks.

On the other hand, those worker threads have always had the behavior of 
having signals unblocked so far, therefore an application that wants to 
use signalfd() today with those liburcu worker threads already needs to 
take some care about how those threads get created.

Therefore, it's not a small self-contained change: it has effects on the 
blocked signal masks that are observable from the application call_rcu 
callbacks. So far, applications which expect to use signalfd() in a 
non-broken way need to ensure they either have the work-around in place 
around thread creation, or will need to add a dependency on an upcoming 
liburcu version (e.g. 0.14).

For all those reasons, I think it would be a good time to do a liburcu 
0.14 release soon, and I don't think backporting this patch makes sense 
for stable branches of liburcu.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
