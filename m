Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6C7C636CC
	for <lttng-dev@archiver.kernel.org>; Tue, 31 Jan 2023 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1675181884;
	bh=aNiIuajGSJ0xEGAuoxbVXbLX8s0QYikDP3JGRFtvafU=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=I7HjGVXGO5dTb71Qk6zf+j4fa5DjGOYMH8vHScHQfN6xjrss1NHDC8GBmkcPv2xHN
	 IV2Cp80hYc7uJ1SIjwfwMLpxhug7eMzLhXx+NaVu6AyxMo8GGkazEISwxii0mN1Z4G
	 oCNXZjY+Pq/BPp+LwO96zH8EtvDaFM2fxxlyxP0/W0L98SEmapTwsY7+x/EsqXKnOL
	 ndTUwxd76l+NNanCy/NHL0YTnuXNOS/8SCtlxjyIhYaKLxlf9LR2ncWFmU9UijvF56
	 tbYZhQ5ezDopKGomwQAvQmN1D3Ay4dWLw1yNIkKhu39r/ZcmZ6MF+s5cnu/Ve3cYH3
	 vpUKiL1JNbSHg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4P5qwC3tDTz1XGy;
	Tue, 31 Jan 2023 11:18:03 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4P5qwB0N3nz1XGw
 for <lttng-dev@lists.lttng.org>; Tue, 31 Jan 2023 11:18:01 -0500 (EST)
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4P5qvb2XhZzhqR;
 Tue, 31 Jan 2023 11:17:31 -0500 (EST)
Message-ID: <e525c864-a2ee-ef34-b7fd-1c114e70b081@efficios.com>
Date: Tue, 31 Jan 2023 11:18:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: "Beckius, Mikael" <mikael.beckius@windriver.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <PH0PR11MB490408B49130B7C9CB661E1A92D39@PH0PR11MB4904.namprd11.prod.outlook.com>
 <46f36a1a-c748-773b-8f6d-d481c9c8ad1b@efficios.com>
In-Reply-To: <46f36a1a-c748-773b-8f6d-d481c9c8ad1b@efficios.com>
Subject: Re: [lttng-dev] lttng-consumerd crash on aarch64 due to x86 arch
 specific optimization
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

On 2023-01-31 11:08, Mathieu Desnoyers wrote:
> On 2023-01-30 01:50, Beckius, Mikael via lttng-dev wrote:
>> Hello Matthieu!
>>
>> I have looked at this in place of Anders and as far as I can tell this 
>> is not an arm64 issue but an arm issue. And even on arm 
>> __ARM_FEATURE_UNALIGNED is 1 so it seems the problem only occurs if 
>> size equals 8.
> 
> So for ARM, perhaps we should do the following in include/lttng/ust-arch.h:
> 
> #if defined(LTTNG_UST_ARCH_ARM) && defined(__ARM_FEATURE_UNALIGNED)
> #define LTTNG_UST_ARCH_HAS_EFFICIENT_UNALIGNED_ACCESS 1
> #endif
> 
> And refer to 
> https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html#ARM-Options
> 
> Based on that documentation, it is possible to build with 
> -mno-unaligned-access,
> and for all pre-ARMv6, all ARMv6-M and for ARMv8-M Baseline architectures,
> unaligned accesses are not enabled.
> 
> I would only push this kind of change into the master branch though, due to
> its impact and the fact that this is only a performance improvement.

But setting LTTNG_UST_ARCH_HAS_EFFICIENT_UNALIGNED_ACCESS 1 for arm32
when __ARM_FEATURE_UNALIGNED is defined would still cause issues for
8-byte lttng_inline_memcpy with my proposed patch right ?

AFAIU 32-bit arm with __ARM_FEATURE_UNALIGNED has unaligned accesses for
2 and 4 bytes accesses, but somehow traps for unaligned 8-bytes
accesses ?

Thanks,

Mathieu

> 
>>
>> In addition I did some performance testing of lttng_inline_memcpy by 
>> extracting it and adding it to a simple test program. It appears that 
>> the general performance increases on arm, arm64, arm on arm64 hardware 
>> and x86-64. But it also appears that on arm if you end up in memcpy 
>> the old code where you call memcpy directly is actually slightly faster.
> 
> Nothing unexpected here. Just make sure that your test program does not 
> call lttng_inline_memcpy
> with constant size values which end up optimizing away branches. In the 
> context where lttng_inline_memcpy
> is used, most of the time its arguments are not constants.
> 
>>
>> Skipping the memcpy fallback on arm for unaligned copies of sizes 2 
>> and 4 further improves the performance
> 
> This would be naturally done on your board if we conditionally
> set LTTNG_UST_ARCH_HAS_EFFICIENT_UNALIGNED_ACCESS 1 for 
> __ARM_FEATURE_UNALIGNED
> right ?
> 
> and setting LTTNG_UST_ARCH_HAS_EFFICIENT_UNALIGNED_ACCESS 1 yields the 
> best performance on arm64.
> 
> This could go into lttng-ust master branch as well, e.g.:
> 
> #if defined(LTTNG_UST_ARCH_AARCH64)
> #define LTTNG_UST_ARCH_HAS_EFFICIENT_UNALIGNED_ACCESS 1
> #endif
> 
> Thanks!
> 
> Mathieu
> 
>>
>> Micke
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
