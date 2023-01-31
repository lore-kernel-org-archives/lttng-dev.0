Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D65AC636CC
	for <lttng-dev@archiver.kernel.org>; Tue, 31 Jan 2023 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1675181300;
	bh=LB11Ok2XwRtxdeYKri7CBf3xAUbWJdg4xF8HAdjQwaU=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ptLSCcsPpx6ykMhpXV3mkXBPNs/jhBFu8aZalEIPQx58/UqcmtQ6IIxzWQ7bwD2Vm
	 3BoaFY/UK5YYibPDeKNAlnMiiMWeU6nR8McUZMUyXewOdPAXyQRimiyBmDYSg6YeQ3
	 AXPNUEbIQ6MLE1WD4Mtv4IrwVbyI7tcdthnnrasuAcZU4iopf13gthUsT2CLntJM96
	 gwehbTzVvfuG810UxlLxKT0QH6OP/y1hX6uO/tQgnQ0FXqu9S6+XHzkx4amgDQOhwE
	 6v9nGPF1UJ4I4Shbt+iMeGSOKZLaSp4pp7X22ZXlzM0nzMCkmoHQbUVas2qFRXjluk
	 hUvL6zMt9e+aw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4P5qhz5tMZz1XBZ;
	Tue, 31 Jan 2023 11:08:19 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4P5qhz1DhYz1XBX
 for <lttng-dev@lists.lttng.org>; Tue, 31 Jan 2023 11:08:19 -0500 (EST)
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4P5qhr091dzhwk;
 Tue, 31 Jan 2023 11:08:12 -0500 (EST)
Message-ID: <46f36a1a-c748-773b-8f6d-d481c9c8ad1b@efficios.com>
Date: Tue, 31 Jan 2023 11:08:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: "Beckius, Mikael" <mikael.beckius@windriver.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <PH0PR11MB490408B49130B7C9CB661E1A92D39@PH0PR11MB4904.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB490408B49130B7C9CB661E1A92D39@PH0PR11MB4904.namprd11.prod.outlook.com>
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

On 2023-01-30 01:50, Beckius, Mikael via lttng-dev wrote:
> Hello Matthieu!
> 
> I have looked at this in place of Anders and as far as I can tell this is not an arm64 issue but an arm issue. And even on arm __ARM_FEATURE_UNALIGNED is 1 so it seems the problem only occurs if size equals 8.

So for ARM, perhaps we should do the following in include/lttng/ust-arch.h:

#if defined(LTTNG_UST_ARCH_ARM) && defined(__ARM_FEATURE_UNALIGNED)
#define LTTNG_UST_ARCH_HAS_EFFICIENT_UNALIGNED_ACCESS 1
#endif

And refer to https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html#ARM-Options

Based on that documentation, it is possible to build with -mno-unaligned-access,
and for all pre-ARMv6, all ARMv6-M and for ARMv8-M Baseline architectures,
unaligned accesses are not enabled.

I would only push this kind of change into the master branch though, due to
its impact and the fact that this is only a performance improvement.

> 
> In addition I did some performance testing of lttng_inline_memcpy by extracting it and adding it to a simple test program. It appears that the general performance increases on arm, arm64, arm on arm64 hardware and x86-64. But it also appears that on arm if you end up in memcpy the old code where you call memcpy directly is actually slightly faster.

Nothing unexpected here. Just make sure that your test program does not call lttng_inline_memcpy
with constant size values which end up optimizing away branches. In the context where lttng_inline_memcpy
is used, most of the time its arguments are not constants.

> 
> Skipping the memcpy fallback on arm for unaligned copies of sizes 2 and 4 further improves the performance

This would be naturally done on your board if we conditionally
set LTTNG_UST_ARCH_HAS_EFFICIENT_UNALIGNED_ACCESS 1 for __ARM_FEATURE_UNALIGNED
right ?

and setting LTTNG_UST_ARCH_HAS_EFFICIENT_UNALIGNED_ACCESS 1 yields the best performance on arm64.

This could go into lttng-ust master branch as well, e.g.:

#if defined(LTTNG_UST_ARCH_AARCH64)
#define LTTNG_UST_ARCH_HAS_EFFICIENT_UNALIGNED_ACCESS 1
#endif

Thanks!

Mathieu

> 
> Micke
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
