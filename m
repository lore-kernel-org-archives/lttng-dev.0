Return-Path: <SRS0=Ki2T=JN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C59AC433ED
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 15:47:03 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6AB611BF
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 15:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6AB611BF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FMLDj0tbgz1C3Z;
	Fri, 16 Apr 2021 11:47:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618588021;
	bh=Hui1/umEikHXy0LFGwPxH1iHCEr1ZLuIIAivt/8Gr7M=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oq3+2srhZw/GAQSsYteD2kcA97Fnj8NebnMqOCZVU8suPca1ZKzmt/r8MsFIGDru7
	 IT3il8FdNLKGh/cEgMMSSNTeMFD4QjGL07qnw32v0GHZwVF9ATukgKeGAJEC2AD91Y
	 U7F1siiV0ClifKEJcZjxJfBVHjhSGak5daCsaqwyb+xXFPFLGWbC5+AyZEN6f1wre8
	 dv5nH86hQcGSq8wtuAVLsYAztu3eJnM1DXZlH1hdOIapxiHtECuFWdZZlNH8DMOC4s
	 kNXBFwEDlSt1YlHFWu3TIjI570GQA0Sj69QbVQxk6X/1KLJXahIWoUPEU+FPUc1EdO
	 iCdjA6f+8WA7g==
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by lists.lttng.org (Postfix) with ESMTPS id 4FMLDf3qnNz1BgJ
 for <lttng-dev@lists.lttng.org>; Fri, 16 Apr 2021 11:46:58 -0400 (EDT)
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lXQDY-002aG6-8o; Fri, 16 Apr 2021 15:17:14 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60CD4300222;
 Fri, 16 Apr 2021 17:17:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 2E87B24C0E746; Fri, 16 Apr 2021 17:17:11 +0200 (CEST)
Date: Fri, 16 Apr 2021 17:17:11 +0200
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: paulmck <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <YHmqd3BHwVmaUZHX@hirez.programming.kicks-ass.net>
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
Subject: Re: [lttng-dev] liburcu: LTO breaking rcu_dereference on arm64 and
 possibly other architectures ?
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Peter Zijlstra via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Fri, Apr 16, 2021 at 10:52:16AM -0400, Mathieu Desnoyers wrote:
> Hi Paul, Will, Peter,
> 
> I noticed in this discussion https://lkml.org/lkml/2021/4/16/118 that LTO
> is able to break rcu_dereference. This seems to be taken care of by
> arch/arm64/include/asm/rwonce.h on arm64 in the Linux kernel tree.
> 
> In the liburcu user-space library, we have this comment near rcu_dereference() in
> include/urcu/static/pointer.h:
> 
>  * The compiler memory barrier in CMM_LOAD_SHARED() ensures that value-speculative
>  * optimizations (e.g. VSS: Value Speculation Scheduling) does not perform the
>  * data read before the pointer read by speculating the value of the pointer.
>  * Correct ordering is ensured because the pointer is read as a volatile access.
>  * This acts as a global side-effect operation, which forbids reordering of
>  * dependent memory operations. Note that such concern about dependency-breaking
>  * optimizations will eventually be taken care of by the "memory_order_consume"
>  * addition to forthcoming C++ standard.
> 
> (note: CMM_LOAD_SHARED() is the equivalent of READ_ONCE(), but was introduced in
> liburcu as a public API before READ_ONCE() existed in the Linux kernel)
> 
> Peter tells me the "memory_order_consume" is not something which can be used today.
> Any information on its status at C/C++ standard levels and implementation-wise ?
> 
> Pragmatically speaking, what should we change in liburcu to ensure we don't generate
> broken code when LTO is enabled ? I suspect there are a few options here:
> 
> 1) Fail to build if LTO is enabled,
> 2) Generate slower code for rcu_dereference, either on all architectures or only
>    on weakly-ordered architectures,
> 3) Generate different code depending on whether LTO is enabled or not. AFAIU this would only
>    work if every compile unit is aware that it will end up being optimized with LTO. Not sure
>    how this could be done in the context of user-space.
> 4) [ Insert better idea here. ]
> 
> Thoughts ?

Using memory_order_acquire is safe; and is basically what Will did for
ARM64.

The problematic tranformations are possible even without LTO, although
less likely due to less visibility, but everybody agrees they're
possible and allowed.

OTOH we do not have a positive sighting of it actually happening (I
think), we're all just being cautious and not willing to debug the
resulting wreckage if it does indeed happen.

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
