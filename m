Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F330C433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 16:51:48 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965FD611BD
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 16:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965FD611BD
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmG3k1YKQz1sCJ;
	Thu, 20 May 2021 12:51:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621529506;
	bh=MYiJA0YAoCxd1ZjBNpKziOkl30SWAwOOd50M9/QHqXk=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QjzFCeQqSeZLRpSJCm3I0G4+gFSoSHWjMGUT09MquCS8Ol7D936u8E1r8zmQhlUsm
	 k/bgXd4Z3i9Slizb5knHqzafp9r9DCg+sSe0sacOrQVWVj1zMOZP4hG7a7kuGN3q0q
	 7qZtA0xAJzHkRUH1wAtglQHiTWkV7SED8MfRTwIz7YYqWF6PfyD6sJ8HvLCYjmn50B
	 DO5ImOfuwjPO5wRJRVYXjttbjA/C0I7HiGBhxgT0NpsxSIde5M8+psGXUk0yi+Mhbx
	 cuYLmOYL96zrrXoG1dIT0nb9q4PDQLgG0KEJe+Gu9KQd0SiSYKZVH4SAncCljgbDzQ
	 HwvGmBrVyRt4w==
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmG3h6QNQz1sCG
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 12:51:44 -0400 (EDT)
Received: by mail-oi1-x22a.google.com with SMTP id y76so7733092oia.6
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 09:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qqn/lS5w114nKDlBoBYiuN4g9wxGm7wmjwfBbj2CqAo=;
 b=fRjmpsAgouwK7XtP0IJ2JIfJaPIS4UfiDzoS1wFLWpvkOluXhXJ6GcunSh3Unj0+mD
 fYiw3jZNZNyWIh8hNmCiC/prgswA46SzxaHtlPv0UaYiNDMOoLDldlAER8/a2YHazPvx
 uM8HfY1780WUjYtTt5ZMShmogOSZLVE1WNoy1jlDhE5ucbhxPtSeTS1FNBrp0/0gtwAq
 2xtcpUEzKJPwcsZ7ZuXtig69JufvG9FOIdQvzGoHHtjaKcyiZ1WbL0q4O7SOAh+brNpT
 VlFygMVm7aGrVazICaGic4KWMhugssHCMgCpJK1BQJ7ZruQAG/9yd+SpnHeoBITSFVXa
 ytyw==
X-Gm-Message-State: AOAM53356Pz3rxEPQWy4gS9gn5o30goeZpvSCXvgyxqbrNRxe+xKWoq2
 n0BI6/Gr1RZUpgTbiBOknt/Q+LO3/oJ7itLLBwY=
X-Google-Smtp-Source: ABdhPJwG62G5lAEj88Fpu8hi7UB/ltOwUAIl+Dbf9ZycrfG5lapbC9nHIM1cYfyp/7HOYQxQZqgJjcBlWY2fReLbNIw=
X-Received: by 2002:aca:acc7:: with SMTP id v190mr3980687oie.28.1621529504093; 
 Thu, 20 May 2021 09:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210520121807.55428-1-nolange79@gmail.com>
 <1600729511.52338.1621520352970.JavaMail.zimbra@efficios.com>
 <CADYdroN3FF3Qs_B55s_Un2qOGz3sP=JMpV=QWRFcO7KVzL-8_A@mail.gmail.com>
 <982122605.52445.1621524098787.JavaMail.zimbra@efficios.com>
 <CADYdroPZTrNg+gYy9SLyDnUGUd1kNq3vkzzjSwJx9e7Tz68quw@mail.gmail.com>
 <523808152.52514.1621527935563.JavaMail.zimbra@efficios.com>
In-Reply-To: <523808152.52514.1621527935563.JavaMail.zimbra@efficios.com>
Date: Thu, 20 May 2021 18:51:33 +0200
Message-ID: <CADYdroMFR3P7OmHt=U9bUUpkWOfqBWdn9f6c4N+J_g5G9WL=Cw@mail.gmail.com>
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

Am Do., 20. Mai 2021 um 18:25 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
> ----- On May 20, 2021, at 11:54 AM, Norbert Lange nolange79@gmail.com wrote:
> [...]
>
> >> What prevents you from linking against lttng-ust.so again ?
> >
> > I did not poke around enough with Lttng to be confident it wont have
> > side effects,
> > I really don't want it active in production. It doesn't seem there is
> > much public knowledge with Xenomai either.
> > lttng-ust.so will spawn threads, lttng-ust-tracepoint.so is mostly passive,
>
> There is indeed a split between instrumentation and runtime threads done
> with lttng-ust-tracepoint.so vs lttng-ust.so.
>
> I understand that this split is missing for tracelog and tracef, and
> would be a good thing to have.
>
> I would be interested to move the tracelog and tracef implementation
> from liblttng-ust.so to liblttng-ust-tracepoint.so, even this late
> in the -rc cycle, because all users of tracelog/tracef need to link
> against liblttng-ust-tracepoint.so anyway. So moving these symbols
> should not affect anyone.
>
> Can you give it a try and let me know if it works for you ?

Will take some time, whats the timeframe you need for feedback?

> > So Id want a dynamic tracepoint-provider than i can dlopen (so that
> > the signal masks are inherited,
> > I hope you dont touch them).
>
> The signals are all blocked for lttng-ust listener threads. We don't
> modify the signal masks in the tracepoint probes. Not sure which is
> the target of your question though.

The first one, if i'd preloaded lttng-ust and you dont mask signals,
then those could end up in the realtime threads.
Every Xenomai Thread has a background Linux Thread that's idle when
realtime is active,
ironically making them perfect targets for signal delivery

>
> >
> > Of course I could just remove all lttng libraries on the production
> > system aswell. Still doesnt change that
> > tracelog and tracef doesnt work that way.
>
> Would moving the tracelog/tracef implementation to liblttng-ust-tracepoint.so
> solve your issues ?

Yes, definitely. They should then work identically to other tracepoints
with TRACEPOINT_PROBE_DYNAMIC_LINKAGE.

>
> >
> > I implemented my own tracelog/tracef using the normal lttng
> > tracepoints for now, they totally break on source level with 2.13
> > aswell ;)
> > is it ok if I do this to access them:
> >
> > #define TRACEPOINT_DEFINE
> > #define TRACEPOINT_PROBE_DYNAMIC_LINKAGE
> > // 2.12
> > // #include <lttng/lttng-ust-tracelog.h>
> > // #include <lttng/lttng-ust-tracef.h>
> > // 2.13
> > #include <lttng/tp/lttng-ust-tracelog.h>
> > #include <lttng/tp/lttng-ust-tracef.h>
> >
> > ie. I would load lttng-ust.so later and can then use those tracepoints.
>
> Reimplementing the tracelog/tracef providers is not an intended use-case.
> I'd very much prefer if we move their implementation to
> liblttng-ust-tracepoint.so.

FWIW it works, and ill use it for a while (cant just swap out
libraries everywhere now).
Of course Id love a upstream solution.

Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
