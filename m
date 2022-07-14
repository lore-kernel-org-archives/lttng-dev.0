Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F0EC43334
	for <lttng-dev@archiver.kernel.org>; Thu, 14 Jul 2022 13:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1657804245;
	bh=e69TSrCq7cfKo3ZWXkcEVbH9xPMU9mR1sGt4cbtrqUs=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ujpjoa71F4xISKGlX6VRtsWUG/YAgKe81ETTUj5XYxMuwqtaNpNLDkpBJVhPP+Ys6
	 Vmi0bJ7PFRdSaO+loVqd7xtqZUGIjhu4YoNieO1kZVlnDIuUnMnbdvo5NRmU1ewrgb
	 x1sM+2eZpwzrBPE2N5G2PUu/al8l0QkiSYYOlt7JscFwvqzOJczxmi1ihH0afsMQQE
	 UBB3wLvIfkBWiqrAPqzRjpLW8lKtT2SgK8ZGno8eiJAsJfhQeWRn0hx/yoJEITjzhZ
	 O0ua/NkgUL6FNGszgLyAQT1Od0FFmyNqvDvAVDfPZUX7y2Mxd7kFYAqmOXUyyU2Q8k
	 rTe7cwGinV6kQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LkFGs0GbgzMp4;
	Thu, 14 Jul 2022 09:10:45 -0400 (EDT)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 by lists.lttng.org (Postfix) with ESMTPS id 4LkFGq2gmSzN3f
 for <lttng-dev@lists.lttng.org>; Thu, 14 Jul 2022 09:10:43 -0400 (EDT)
Received: by mail-vk1-xa31.google.com with SMTP id g25so765389vkm.13
 for <lttng-dev@lists.lttng.org>; Thu, 14 Jul 2022 06:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=saD3EmM1px1CZSMUWWD6jBJVtknxkV8oJx++7848E/E=;
 b=MW4dRS9oM4qMDr4nUy2kMBCrnwglpCuP2NADeLSWtFj/gOtmHDOE0dugR3Ics0hMRE
 oWmzDp8g3NzHMQzxmbfZGJbwZJ6xp2u3bh6Ggtc7Qy+7PNIy5+ycRRrLtGKqy4yRcBeV
 i8GlJyMWJkxlvu2zKEboi/4+LrnGUBRAPId6vJrHFRfUJR6y/gypnk4iE+4vi0uaUj29
 HS538Byz2PsUZxHc/XlWkG2I+EEW85d2LKoplO7FLgGTuQhm+4M/sqEtuplulJA7cxCh
 lu8ipLePRDGj4Lyxlc1zR6bbJppKrlLiIrIuh9h/lOq9LHZnKU81jkM2VOYjgWbEvLuW
 OmfA==
X-Gm-Message-State: AJIora8exGq8ozN9nnvpky9L0axdOybMv58b9bTzGyOkDz9MKDFKxcDo
 ACQsKEH1Tb+Yr09V9/m6MwWCeEEpW7wm+gb6y4I=
X-Google-Smtp-Source: AGRyM1sxfbMtRG8mLFp5CTWYXClCPOP/mJsws0GyN1hTbR67mmzxOdRe8HEqdQovXXTXe8LTwbm4MjJMhGbV7ncS/IA=
X-Received: by 2002:a1f:294c:0:b0:374:834f:366b with SMTP id
 p73-20020a1f294c000000b00374834f366bmr3385828vkp.21.1657804242552; Thu, 14
 Jul 2022 06:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <CADYdroN3=pAe66crtsVT9aHE4T+bT61-tvHFKCuwZYkHhuyFjw@mail.gmail.com>
 <217443874.51651.1621450365666.JavaMail.zimbra@efficios.com>
 <CADYdroMVaMq6wdySyV-JGDyJaFpaLO1cHd2=hEb=WMpBHUz0Jg@mail.gmail.com>
 <1519877397.52210.1621517299822.JavaMail.zimbra@efficios.com>
 <CADYdroNEtUen6OiVSXeP7EgRrPGv6wW3FtV1-i0php5DoJQUFg@mail.gmail.com>
 <1054776587.52332.1621520134754.JavaMail.zimbra@efficios.com>
In-Reply-To: <1054776587.52332.1621520134754.JavaMail.zimbra@efficios.com>
Date: Thu, 14 Jul 2022 15:10:31 +0200
Message-ID: <CADYdroN9STUUxYZAYx2R-X2MjuGGF8kVOXEHG156ZTmnoiY9wQ@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] reading context fields causes syscalls
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
From: Norbert Lange via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Norbert Lange <nolange79@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello Mathieu,

Am Do., 20. Mai 2021 um 16:16 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
> ----- On May 20, 2021, at 9:42 AM, Norbert Lange nolange79@gmail.com wrote:
>
> > Am Do., 20. Mai 2021 um 15:28 Uhr schrieb Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com>:
> >>
> >> ----- On May 20, 2021, at 8:46 AM, Norbert Lange nolange79@gmail.com wrote:
> >>
> >> > Am Mi., 19. Mai 2021 um 20:52 Uhr schrieb Mathieu Desnoyers
> >> > <mathieu.desnoyers@efficios.com>:
> >> >>
> >> >> ----- On May 19, 2021, at 8:11 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
> >> >>
> >> >> > Hello,
> >> >> >
> >> >> > Several context fields will cause a syscall atleast the first time a
> >> >> > tracepoint is
> >> >> > recorded. For example all of the following:
> >> >> >
> >> >> > `lttng add-context -c chan --userspace --type=vpid --type=vtid --type=procname`
> >> >> >
> >> >> > Each of them seems cached in TLS however, and most should never change
> >> >> > after startup.
> >> >> >
> >> >> > As I am using Lttng over Xenomai, syscalls are strictly forbidden, I
> >> >> > would like to have some function that prepares all data, which I can
> >> >> > call on each thread before it switches to realtime work.
> >> >> >
> >> >> > Kinda similar to urcu_bp_register_thread, I'd like to have some
> >> >> > `lttng_ust_warmup_thread` function that fetches the context values
> >> >> > that can be cached. (urcu_bp_register_thread should be called there
> >> >> > aswell)
> >> >> > I considered just doing a tracepoint, but AFAIK the channel can be
> >> >> > changed/configured after the process is running. So this is not robust
> >> >> > enough.
> >> >>
> >> >> The new lttng_ust_init_thread() API in lttng-ust 2.13 would be the right
> >> >> place to do this I think:
> >> >>
> >> >> /*
> >> >>  * Initialize this thread's LTTng-UST data structures. There is
> >> >>  * typically no need to call this, because LTTng-UST initializes its
> >> >>  * per-thread data structures lazily, but it should be called explicitly
> >> >>  * upon creation of each thread before signal handlers nesting over
> >> >>  * those threads use LTTng-UST tracepoints.
> >> >>  */
> >> >>
> >> >> It would make sense that this new initialization helper also initializes
> >> >> all contexts which cache the result of a system call. Considering that
> >> >> contexts can be used from the filter and capture bytecode interpreter, as
> >> >> well as contexts added to channels, I think we'd need to simply initialize
> >> >> them all.

Any update on that, is there an list of open points/features for lttng?

Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
