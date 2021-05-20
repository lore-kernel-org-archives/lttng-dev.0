Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA6C433B4
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 15:54:31 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577D7610CC
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 15:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577D7610CC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmDnc4nvYz1rd9;
	Thu, 20 May 2021 11:54:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621526069;
	bh=90N56Ifv1RJeSc/tMKTZ2e+lV5iBz2P6eRU602hgnnY=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=l9O6GwWBCwmqBXkbfBXzrnLegit3SmaKWouGhqhOIhcUU9V3RCTWBNzNPsY3zy2ui
	 zMvM96ZG41Ij55ZGPU4vLtV0J+I8q2tCilYb3hipf4lUdmmwQ3oB9mkszls0MWGItt
	 rZOg6C/W3LVkD2AiKAJ5BENPfsaEEe63Bf1q4YkZ5w3cI+Cmv6rzZM9J72pYEpoYlt
	 DofAftifcfuzirxDuoaSLfCl4dqKC4m+SyjnXi9OgYEEW0rzOr8bAFxg/wGvDqChAP
	 Nl9WA7Ivfck29rhMDTlpJqMtTQG45v4tyfyeTd/TloKWmtDc3uTerKDCNZ0fDchbEl
	 f2BpCpcRM9mFg==
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmDnb70M1z1rh6
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 11:54:27 -0400 (EDT)
Received: by mail-oo1-xc32.google.com with SMTP id
 s1-20020a4ac1010000b02901cfd9170ce2so3884075oop.12
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 08:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0VnzijFU9mOA6wU7rpSJ/S2VTjRJH/GekYI70SpoFAE=;
 b=E8OzlJkCDh5qheweda6HQfsSLA9Q/WS4EP3HI+wiHL1UlIWYyZu4/9gIxkdUA5u9p/
 Y+JcGCJvjdsulQhwo0wtUu+t/ooQVucM+LFX+2MKSl17RfExdSoXy8152bgIuXTwl9Vp
 zRRrNHHivhSsPv+VqBjV4wkDQ+2zGhmMZGPKDLkmvCtSHAFGs0IejdfnL/HnOB084cJX
 soaq3cXfyWdqrEe1GkAxMn8qwhGJCL7SVWM9KyhbbTDG5pD56opQ361APYoTRG67J+hm
 P92DsUtN7VCkbcAN2j+DgrAjrFNc/TcAkVwHN+nwBvkBwutSizVTTH6azb+6HzpwSmQH
 Ryng==
X-Gm-Message-State: AOAM532UZRKb1ZKzhuZp+3TfJG372wak+Xd9BmSYPYo60DCIj3HID6PX
 dvKHScyaqbGHn6em6hZuUi+XCgSOWSEkU22rodg=
X-Google-Smtp-Source: ABdhPJyOWNWwo1QMQxWW3v3F4c/pA8qrujmbFAlv+33pn0niZbXpwc2akdnS6UpweDC7dQwXAEmaWZBHD78p3QdUlCw=
X-Received: by 2002:a4a:abc8:: with SMTP id o8mr4301591oon.77.1621526067154;
 Thu, 20 May 2021 08:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210520121807.55428-1-nolange79@gmail.com>
 <1600729511.52338.1621520352970.JavaMail.zimbra@efficios.com>
 <CADYdroN3FF3Qs_B55s_Un2qOGz3sP=JMpV=QWRFcO7KVzL-8_A@mail.gmail.com>
 <982122605.52445.1621524098787.JavaMail.zimbra@efficios.com>
In-Reply-To: <982122605.52445.1621524098787.JavaMail.zimbra@efficios.com>
Date: Thu, 20 May 2021 17:54:16 +0200
Message-ID: <CADYdroPZTrNg+gYy9SLyDnUGUd1kNq3vkzzjSwJx9e7Tz68quw@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] [PATCH lttng-ust] Improve tracelog handling,
 reduce exported functions
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

Am Do., 20. Mai 2021 um 17:21 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
> ----- On May 20, 2021, at 10:57 AM, Norbert Lange nolange79@gmail.com wrote:
>
> > Am Do., 20. Mai 2021 um 16:19 Uhr schrieb Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com>:
> >>
> >> ----- On May 20, 2021, at 8:18 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
> >>
> >> > Instead of creating functions for each loglevel, simply pass the
> >> > callback as argument.
> >> >
> >> > Further pack all preprocessor information into a struct that
> >> > the compiler already can prepare.
> >>
> >> This introduces an ABI break too late in the cycle.
> >
> > So 2.14 would be the next chance I guess
>
> No. The original ABI was introduced about 10 years ago with lttng-ust 2.0,
> and lttng-ust 2.13 introduces the first ABI break since. I don't
> plan on doing any ABI break in lttng-ust in the foreseeable future.
>
> ABI breaks require that our users recompile all their instrumented
> applications, which is really cumbersome for large software deployments.
> We don't break ABI lightly.

Yeah, I understand.


> >> Also, I'm not so keen on adding an indirect call on the fast-path
> >> when it's not absolutely needed.
> >
> > Code seems pretty similar: https://godbolt.org/z/oK1WhWqGT
>
> By fast-path, I also mean:
>
> +        (*callback)(source->file, source->line, source->func, msg, len,
> +                LTTNG_UST_CALLER_IP());
>
> Which introduces an indirect call which needs to be taken when tracing
> is active.

The worst thing is that it would tax branch-predictors. Indirect jumps aren't
that horrible, and if you have public interpose-able ELF symbols you
have more of them than you might know...

And that's a function that calls a printf variant, and did alloc memory.

> >> What is wrong with having one symbol per loglevel ?
> >
> > Macro-magic is cumbersome to edit, more code, more relocations.
>
> If it was still time for ABI breaks, I would be tempted to consider it
> especially given that tracelog and tracef are not expected to be "high-speed",
> but now is too late for breaking ABI.
>
> >
> > Easier to adapt aswell, could roll my own tracelog functions while
> > using lttng_ust__tracelog_printf (started soind that as I don't want
> > to link to lttng-ust.so)
>
> What prevents you from linking against lttng-ust.so again ?

I did not poke around enough with Lttng to be confident it wont have
side effects,
I really don't want it active in production. It doesn't seem there is
much public knowledge with Xenomai either.
lttng-ust.so will spawn threads, lttng-ust-tracepoint.so is mostly passive,
So Id want a dynamic tracepoint-provider than i can dlopen (so that
the signal masks are inherited,
I hope you dont touch them).

Of course I could just remove all lttng libraries on the production
system aswell. Still doesnt change that
tracelog and tracef doesnt work that way.

I implemented my own tracelog/tracef using the normal lttng
tracepoints for now, they totally break on source level with 2.13
aswell ;)
is it ok if I do this to access them:

#define TRACEPOINT_DEFINE
#define TRACEPOINT_PROBE_DYNAMIC_LINKAGE
// 2.12
// #include <lttng/lttng-ust-tracelog.h>
// #include <lttng/lttng-ust-tracef.h>
// 2.13
#include <lttng/tp/lttng-ust-tracelog.h>
#include <lttng/tp/lttng-ust-tracef.h>

ie. I would load lttng-ust.so later and can then use those tracepoints.

Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
