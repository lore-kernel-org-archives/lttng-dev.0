Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D960C433B4
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 12:46:31 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD56961001
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 12:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD56961001
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fm8cj4ggYz1rr6;
	Thu, 20 May 2021 08:46:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621514790;
	bh=t6Y7IIa+aUe2Bt2H+yNpcjIEvi3zE/K7YvdzWPRa5MA=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LgNiJUczZgz1tl40kt15qiRwgylxog8OwkgU1vndsjX9ppRwViDqLkgpz+j7TEpqx
	 8t4m+fVv6unXZR3rU6nneweBlk47ntP9gkwzvt8NTNxraI5pBgAILYgnbB/vFceVZh
	 u0N2FUq42PRfxq9AnfJSqZozZrXPVYkKmL4nKqoFkEmQLhx/mpsAXtVQoXbqCsYlNc
	 tONGRh0Taly32mZvkicdQiE7woZixuUp7LUUoa1n0/XL0L8s6LqxJsekKmVYLrxbM+
	 HelhDtQrCrCK6fIn/Ij6XRxRoTPyaqPw+ljSqHRf4R9lGgGYDHJYTd9JbKaVPB+Pqq
	 CAJ+u6nrfibAQ==
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fm8ch4MXWz1rTW
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 08:46:28 -0400 (EDT)
Received: by mail-oi1-x22d.google.com with SMTP id t24so761518oiw.3
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 05:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0q2KEmzsBhKrby9HaQ1gAzu5izyc1WZof9FQrcOwsmQ=;
 b=qtV6p1Zcw9T7fylaz0VJFRbhaGQwzF/dDPviwpRWJ2/jXlspYDyZSDoFkBJ7CwhlHR
 xBYX3WPkgGlzUSkW0P0IZQOSdFHfrZubCXPeT/Spm5mvdBp/EMImyeoHN/prBypIZInl
 nwHoOzwYGhvH9UrnKDttMoYHxVZfJ9xdGZSiioPfkqeL4BgoswpCeUDLPx7yNWrtD04R
 A3cXdpA4y1uth/AMrdEYhGoEtVwTRcbxeJVsdopAUzLAL06e7dqFK23gS6EuHzi5kVaD
 m+YhYogdIiNRFAJcOXiKA7myni1c40xIms24E95h3W4KvMKACPTcLZ1+vURShmbRiYPz
 poVA==
X-Gm-Message-State: AOAM5339DezQzt9ss2hH5/hBaM6ytUtyDLJg6K2dFuZloNjeNOWolXku
 c7PqhI3Sz1u/mYmGE7OvNtmq78P86s67tdir/p4EQSYLOnlyYw==
X-Google-Smtp-Source: ABdhPJx5lkXTByd0sPUbR9aXB0XhVm0b+1iNH9HpGghkTzplT2UsZe0VxsR5lGumxf+/TI0IGmm/r4LdGkkKjQgk8ag=
X-Received: by 2002:a05:6808:1402:: with SMTP id
 w2mr1956698oiv.72.1621514787811; 
 Thu, 20 May 2021 05:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <CADYdroN3=pAe66crtsVT9aHE4T+bT61-tvHFKCuwZYkHhuyFjw@mail.gmail.com>
 <217443874.51651.1621450365666.JavaMail.zimbra@efficios.com>
In-Reply-To: <217443874.51651.1621450365666.JavaMail.zimbra@efficios.com>
Date: Thu, 20 May 2021 14:46:16 +0200
Message-ID: <CADYdroMVaMq6wdySyV-JGDyJaFpaLO1cHd2=hEb=WMpBHUz0Jg@mail.gmail.com>
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

Am Mi., 19. Mai 2021 um 20:52 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
> ----- On May 19, 2021, at 8:11 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
>
> > Hello,
> >
> > Several context fields will cause a syscall atleast the first time a
> > tracepoint is
> > recorded. For example all of the following:
> >
> > `lttng add-context -c chan --userspace --type=vpid --type=vtid --type=procname`
> >
> > Each of them seems cached in TLS however, and most should never change
> > after startup.
> >
> > As I am using Lttng over Xenomai, syscalls are strictly forbidden, I
> > would like to have some function that prepares all data, which I can
> > call on each thread before it switches to realtime work.
> >
> > Kinda similar to urcu_bp_register_thread, I'd like to have some
> > `lttng_ust_warmup_thread` function that fetches the context values
> > that can be cached. (urcu_bp_register_thread should be called there
> > aswell)
> > I considered just doing a tracepoint, but AFAIK the channel can be
> > changed/configured after the process is running. So this is not robust
> > enough.
>
> The new lttng_ust_init_thread() API in lttng-ust 2.13 would be the right
> place to do this I think:
>
> /*
>  * Initialize this thread's LTTng-UST data structures. There is
>  * typically no need to call this, because LTTng-UST initializes its
>  * per-thread data structures lazily, but it should be called explicitly
>  * upon creation of each thread before signal handlers nesting over
>  * those threads use LTTng-UST tracepoints.
>  */
>
> It would make sense that this new initialization helper also initializes
> all contexts which cache the result of a system call. Considering that
> contexts can be used from the filter and capture bytecode interpreter, as
> well as contexts added to channels, I think we'd need to simply initialize
> them all.

Yeah, just figured that it doesnt help at all if I do a tracepoint, as
it might just be disabled ;)
lttng_ust_init_thread() sounds right for that, maybe add one or 2 arguments for
stuff you want initialized / dont want initialized over the default.

I take that the downside of eager initialization is potentially wasted
resources (now ignoring any one-time runtime cost).

Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
