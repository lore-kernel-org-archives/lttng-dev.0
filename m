Return-Path: <SRS0=5oIU=KO=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FBFC43460
	for <lttng-dev@archiver.kernel.org>; Wed, 19 May 2021 18:52:56 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CF76135A
	for <lttng-dev@archiver.kernel.org>; Wed, 19 May 2021 18:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CF76135A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Flhnx1sdLz1qtL;
	Wed, 19 May 2021 14:52:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621450374;
	bh=8bsDeJ0qMMJn74/0pbSHLZd9wTrR5AVZeDdLCgDnWKY=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kE7DOPuDIvhEKnrDacijrPToU/8Edpahidod7lRnd0Bf9dpJkyMf5dKwePFpXqMbX
	 5XfIUGPgqtOvGIgc79ebLc4sKcYnNGf7Tr561z3e8U+RbKqtIV1eBxwmnIDUITCqj9
	 InB2YRp0tdYt4wYzLDktBo7Gqxlm0+ANuRbq66fDhH1Ruuk1WwS8YdoKpoXpOkP+j8
	 ki7FeiUrERqseK5wbURELrEg7OhVeP6AJEEO3+XAWYJAz16gK2rsNx8dz4JnT9BllY
	 grd/7qKrg1LoXfUM3tBGxvZoaRXO2aUz9eabcmmNm6BNWjufeGhNaoIoS9fe36flME
	 d6Y+Dznc8illw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Flhnw4cG9z1r6L
 for <lttng-dev@lists.lttng.org>; Wed, 19 May 2021 14:52:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2D60F32DFAE
 for <lttng-dev@lists.lttng.org>; Wed, 19 May 2021 14:52:46 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id EEWkpuRikxxn; Wed, 19 May 2021 14:52:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CA17832E019;
 Wed, 19 May 2021 14:52:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CA17832E019
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id W_ojtFefBKrD; Wed, 19 May 2021 14:52:45 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id BCA2B32DC28;
 Wed, 19 May 2021 14:52:45 -0400 (EDT)
Date: Wed, 19 May 2021 14:52:45 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <217443874.51651.1621450365666.JavaMail.zimbra@efficios.com>
In-Reply-To: <CADYdroN3=pAe66crtsVT9aHE4T+bT61-tvHFKCuwZYkHhuyFjw@mail.gmail.com>
References: <CADYdroN3=pAe66crtsVT9aHE4T+bT61-tvHFKCuwZYkHhuyFjw@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: reading context fields causes syscalls
Thread-Index: aTyJxyZBRNwWlNLtU8JIdDhX38xJ3A==
Subject: Re: [lttng-dev] reading context fields causes syscalls
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On May 19, 2021, at 8:11 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Hello,
> 
> Several context fields will cause a syscall atleast the first time a
> tracepoint is
> recorded. For example all of the following:
> 
> `lttng add-context -c chan --userspace --type=vpid --type=vtid --type=procname`
> 
> Each of them seems cached in TLS however, and most should never change
> after startup.
> 
> As I am using Lttng over Xenomai, syscalls are strictly forbidden, I
> would like to have some function that prepares all data, which I can
> call on each thread before it switches to realtime work.
> 
> Kinda similar to urcu_bp_register_thread, I'd like to have some
> `lttng_ust_warmup_thread` function that fetches the context values
> that can be cached. (urcu_bp_register_thread should be called there
> aswell)
> I considered just doing a tracepoint, but AFAIK the channel can be
> changed/configured after the process is running. So this is not robust
> enough.

The new lttng_ust_init_thread() API in lttng-ust 2.13 would be the right
place to do this I think:

/*
 * Initialize this thread's LTTng-UST data structures. There is
 * typically no need to call this, because LTTng-UST initializes its
 * per-thread data structures lazily, but it should be called explicitly
 * upon creation of each thread before signal handlers nesting over
 * those threads use LTTng-UST tracepoints.
 */

It would make sense that this new initialization helper also initializes
all contexts which cache the result of a system call. Considering that
contexts can be used from the filter and capture bytecode interpreter, as
well as contexts added to channels, I think we'd need to simply initialize
them all.

Thanks,

Mathieu

> 
> regards, Norbert
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
