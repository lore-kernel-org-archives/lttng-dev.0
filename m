Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7885C433B4
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 13:42:54 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0EB60240
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 13:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0EB60240
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fm9sm4hYkz1rg7;
	Thu, 20 May 2021 09:42:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621518173;
	bh=a6GztwWrqFslBA/amemsOE0sSKUtWXOgKeOJZlP5yoY=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=V4+ndmIqeseAeawkmDJU8/oAMRuGjIJk1DIHE89nN59yjQFRJsMw8P+nA+piZpRhk
	 SjN1ugiYYRBEwmAM5laLDBGzSDzTzq6XlyxG1VttdnJzi1bDe/bZCdhjr0gYApH8on
	 sXB8Zn1gyR9yAuc2Kb6dgKDrsUiiiNHyD79QzVXLi/hifgtTMSWJ5XZHgqhZQ7S57e
	 5dYVe/ORQg7ftTacuXrxc6NJ+iYx/KTJhKrOmmalhopsfco2RbEcxel1doFFzTYZkn
	 MrkBEamH16yPiPItoMv6UDjlPWMUddKLQJwfQSqg765Pht+vSYLFRWh7YJDdBm5mVC
	 kh6vxaGsiW6rg==
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fm9sk69j8z1rLt
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 09:42:50 -0400 (EDT)
Received: by mail-oi1-x22c.google.com with SMTP id w127so12587127oig.12
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 06:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/vX6od2clUS/CrzqoTmWE1dN0dkMXmBj1PU4ClELYg8=;
 b=KrM88uBpsKQOzYG9DSsAQpevdweg+0/fTPm3aqwjLrzeaWJh7Kbde5k4YVr7uPVcT5
 W5o7W/hjUGDLNGIjEE+V8uZV3LmQB8gvkxfIMr9/M+6cKdzNiGgMVL8PTH8X1o6OHtSN
 R5yaZUb2+ifrlP1WOuUOc667ElReLA341LcZEZqjc7tghufd4Cy15nZZtSvrOtQ/K7+u
 bVA2ab/pyC9bZGExJU8MuD3B80BM4DUJZjkRR1s6JLlOVT2A8ebqu6r0O6E68pRveHGC
 kLYV9LqNRVMVDO4oLwKSejTIHux6PVCWz0lpIkrEk6vMiYT9wEhC4y40ykAYmY16fUwn
 q52w==
X-Gm-Message-State: AOAM533umNDVxS4iltUnZkg6V57qRbGsYvpaV4BFTY8smPV/N962+rMA
 ShYUJPwmpTVo0WREp42/7JydGGm2+fJ0voQM8XA=
X-Google-Smtp-Source: ABdhPJxnphKavbOzndsDBcCprGiT4AmYlVnrsvMTuOvCjM7pXhbRIJkNi9sSWy+QIkqUH6UsBckJLNyUTv9B+tTSgJ0=
X-Received: by 2002:aca:acc7:: with SMTP id v190mr3383674oie.28.1621518169939; 
 Thu, 20 May 2021 06:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <CADYdroN3=pAe66crtsVT9aHE4T+bT61-tvHFKCuwZYkHhuyFjw@mail.gmail.com>
 <217443874.51651.1621450365666.JavaMail.zimbra@efficios.com>
 <CADYdroMVaMq6wdySyV-JGDyJaFpaLO1cHd2=hEb=WMpBHUz0Jg@mail.gmail.com>
 <1519877397.52210.1621517299822.JavaMail.zimbra@efficios.com>
In-Reply-To: <1519877397.52210.1621517299822.JavaMail.zimbra@efficios.com>
Date: Thu, 20 May 2021 15:42:39 +0200
Message-ID: <CADYdroNEtUen6OiVSXeP7EgRrPGv6wW3FtV1-i0php5DoJQUFg@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
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
From: Norbert Lange via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Norbert Lange <nolange79@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Am Do., 20. Mai 2021 um 15:28 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
> ----- On May 20, 2021, at 8:46 AM, Norbert Lange nolange79@gmail.com wrote:
>
> > Am Mi., 19. Mai 2021 um 20:52 Uhr schrieb Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com>:
> >>
> >> ----- On May 19, 2021, at 8:11 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
> >>
> >> > Hello,
> >> >
> >> > Several context fields will cause a syscall atleast the first time a
> >> > tracepoint is
> >> > recorded. For example all of the following:
> >> >
> >> > `lttng add-context -c chan --userspace --type=vpid --type=vtid --type=procname`
> >> >
> >> > Each of them seems cached in TLS however, and most should never change
> >> > after startup.
> >> >
> >> > As I am using Lttng over Xenomai, syscalls are strictly forbidden, I
> >> > would like to have some function that prepares all data, which I can
> >> > call on each thread before it switches to realtime work.
> >> >
> >> > Kinda similar to urcu_bp_register_thread, I'd like to have some
> >> > `lttng_ust_warmup_thread` function that fetches the context values
> >> > that can be cached. (urcu_bp_register_thread should be called there
> >> > aswell)
> >> > I considered just doing a tracepoint, but AFAIK the channel can be
> >> > changed/configured after the process is running. So this is not robust
> >> > enough.
> >>
> >> The new lttng_ust_init_thread() API in lttng-ust 2.13 would be the right
> >> place to do this I think:
> >>
> >> /*
> >>  * Initialize this thread's LTTng-UST data structures. There is
> >>  * typically no need to call this, because LTTng-UST initializes its
> >>  * per-thread data structures lazily, but it should be called explicitly
> >>  * upon creation of each thread before signal handlers nesting over
> >>  * those threads use LTTng-UST tracepoints.
> >>  */
> >>
> >> It would make sense that this new initialization helper also initializes
> >> all contexts which cache the result of a system call. Considering that
> >> contexts can be used from the filter and capture bytecode interpreter, as
> >> well as contexts added to channels, I think we'd need to simply initialize
> >> them all.
> >
> > Yeah, just figured that it doesnt help at all if I do a tracepoint, as
> > it might just be disabled ;)
> > lttng_ust_init_thread() sounds right for that, maybe add one or 2 arguments for
> > stuff you want initialized / dont want initialized over the default.
> >
> > I take that the downside of eager initialization is potentially wasted
> > resources (now ignoring any one-time runtime cost).
>
> I would not want to introduce too much coupling between the application and
> the tracer though. The public API I've added for the 2.13 release cycle takes
> no argument, and I'm not considering changing that at this stage (we are already
> at -rc2, so we're past the API freeze).

Ok, figured if that's preferred then nows the last chance

>
> I'd be open to adding an extra API with a different purpose though. Currently
> lttng_ust_init_thread is meant to initialize per-thread data structures for
> tracing signal handlers.
>
> Your use-case is different: you aim at tracing from a context which cannot
> issue system calls. Basically, any attempt to issue a system call from that
> thread after this is a no-go. I would be tempted to introduce something like
> "lttng_ust_{set,clear}_thread_no_syscall" or such, which would have the following
> effects when set:

No systemcalls and no clock_gettime().
>
> * Force immediate initialization of all thread's cached context information,

Definitely needed (adding context is often needed I guess)

> * Set a TLS variable flag indicating that the tracer should not do any system
>   call whatsoever. The tracer could either use dummy data (zeroes), log an error,
>   or abort() the process if a thread in no_syscall mode attempts to issue a system
>   call. This could be dynamically selected by a new environment variable.

How this works is than Xenomai will generate a synchronous signal,
which as default aborts. So fallbacks are nice, but error handling
isn't necessary.

Somewhat offtopic, but why is lltng not using __thread for TLS access,
usually I only see this for really old stuff?

> * Prevent threads in no_syscall mode from calling the write() system call on
>   sub-buffer switch (of course the read-timer channel option is preferred).

Yeah, that was part of the last discussion. What would happen without
write notification?
Bufferstate is polled elsewhere too, or will it just be full forever?

Come to think of it, maybe it would be better to add some form of
"tags" to software,
(like a defined symbol or ELF .note section) which could prevent
processes to be traced
if in the wrong mode (no read-timer), or change what work the
lttng_ust_init_thread function
does.

Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
