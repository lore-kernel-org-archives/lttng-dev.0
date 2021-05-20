Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FD7C433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 17:43:22 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F41F6135A
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 17:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F41F6135A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmHCD0L10z1rqY;
	Thu, 20 May 2021 13:43:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621532600;
	bh=AkS35fDg3k6ioH9b1T+T3NK7ryT4t1TiQGkUycZscyo=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=n19+UDxKw/x18YwCGIQP2X/IvDleUvwzh5NtVFqRQOcRuqXI7hbMbUhh8Q/kxzPAG
	 c5kzBqWwAOw74k4iUxxoflbvQZEFWveB+Qqn5Do3SWKbpnymw++6wHJSk2yUtA/iXX
	 h2Eza0zWK+1odR955lIbyWm+dQXYS1VMF/oYWDJpMNS5y/uAIwZuDWW045almThA2u
	 zTdBBdga4SSx491LwMUHE+jSI4AF/AArdXx7usDkUbJOJVbHGAJQQkZOaKiNK+v22z
	 82rrGZuQ3Ne3DmUmHiJycZk1KhVwfl/Jr0zRFX8sMX9vQN3bTtYN37QCb9SDGO90ev
	 SLtNJuCdm7EqA==
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmHCB2z6Dz1s1R
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 13:43:18 -0400 (EDT)
Received: by mail-oi1-x229.google.com with SMTP id h9so17186725oih.4
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 10:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u5t1zXP2ZhNUKkEkbnZBkILmyvG89eqg3Q7VXyIjfuw=;
 b=sdky5AY4kNbEAZeVL8FgrmAerUaxv7tUnsqp2Z9CNrL19+Hr1VxhC4gjW76YJGo4Z6
 1Ln+/C3CEnFK1IMQXOUa8cb0xZkV6SLHeOTwOMXKbOLjH7DBfhpMCXugBkn68ET0qQxV
 d7qNg8hFO/2+cr7FqirxdvG0O9wx9Wu1MzX0p7WKZAc5ec0OCZlCvblHXoFOVYcxXuAf
 u51vIbkYfwhfeL0arKkRhdhNGvn9xxzKSnyEmAp5DYiWKVw6Ic1Rgo98x6kE1yRIIzIg
 XBgAl/gObfzTx+hqfiK65bQyliKValy3QWPoTuvUz33xyfeQjznCLKEP2mVg7Va63r6J
 scqA==
X-Gm-Message-State: AOAM5338UQvamiFkKDzZbcPemDxUEhVK1zCcNyuR1KrnNq8etYqARQSB
 VYxikQ50sANBkZztKG9r1GgaC+xo4hT3lPBAeMg=
X-Google-Smtp-Source: ABdhPJxYTyDZOTe9uyyDEfyTGMJOS4BVEuMb1Ozt1E/mH57sltGQyIbOdtopv9yDDVSOsQnEb6TjmsTiSw5RLfXRzrs=
X-Received: by 2002:a05:6808:1402:: with SMTP id
 w2mr2923176oiv.72.1621532597317; 
 Thu, 20 May 2021 10:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210520121807.55428-1-nolange79@gmail.com>
 <1600729511.52338.1621520352970.JavaMail.zimbra@efficios.com>
 <CADYdroN3FF3Qs_B55s_Un2qOGz3sP=JMpV=QWRFcO7KVzL-8_A@mail.gmail.com>
 <982122605.52445.1621524098787.JavaMail.zimbra@efficios.com>
 <CADYdroPZTrNg+gYy9SLyDnUGUd1kNq3vkzzjSwJx9e7Tz68quw@mail.gmail.com>
 <523808152.52514.1621527935563.JavaMail.zimbra@efficios.com>
 <CADYdroMFR3P7OmHt=U9bUUpkWOfqBWdn9f6c4N+J_g5G9WL=Cw@mail.gmail.com>
 <154847626.52635.1621531127222.JavaMail.zimbra@efficios.com>
In-Reply-To: <154847626.52635.1621531127222.JavaMail.zimbra@efficios.com>
Date: Thu, 20 May 2021 19:43:06 +0200
Message-ID: <CADYdroM_7LVxoe6rQxZvgSqW_97pFd3t2i37NSvuGOmG0H2Lzw@mail.gmail.com>
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

Am Do., 20. Mai 2021 um 19:18 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
>
>
> ----- On May 20, 2021, at 12:51 PM, Norbert Lange nolange79@gmail.com wrote:
>
> > Am Do., 20. Mai 2021 um 18:25 Uhr schrieb Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com>:
> >>
> >> ----- On May 20, 2021, at 11:54 AM, Norbert Lange nolange79@gmail.com wrote:
> >> [...]
> >>
> >> >> What prevents you from linking against lttng-ust.so again ?
> >> >
> >> > I did not poke around enough with Lttng to be confident it wont have
> >> > side effects,
> >> > I really don't want it active in production. It doesn't seem there is
> >> > much public knowledge with Xenomai either.
> >> > lttng-ust.so will spawn threads, lttng-ust-tracepoint.so is mostly passive,
> >>
> >> There is indeed a split between instrumentation and runtime threads done
> >> with lttng-ust-tracepoint.so vs lttng-ust.so.
> >>
> >> I understand that this split is missing for tracelog and tracef, and
> >> would be a good thing to have.
> >>
> >> I would be interested to move the tracelog and tracef implementation
> >> from liblttng-ust.so to liblttng-ust-tracepoint.so, even this late
> >> in the -rc cycle, because all users of tracelog/tracef need to link
> >> against liblttng-ust-tracepoint.so anyway. So moving these symbols
> >> should not affect anyone.
> >>
> >> Can you give it a try and let me know if it works for you ?
> >
> > Will take some time, whats the timeframe you need for feedback?
>
> Here is the tentative commit:
>
> https://review.lttng.org/c/lttng-ust/+/5927 Move tracef/tracelog symbols to liblttng-ust-tracepoint.so

Well... this is certainly an improvement. I am not completely happy
though: "... users now link against
liblttng-ust-tracepoint.so explicitly"

My homecooked solution currently works like this:

*) define the probes from <lttng/lttng-ust-tracelog.h> with
TRACEPOINT_PROBE_DYNAMIC_LINKAGE,
    link them in the application, together with other dynamic probes
*) build a separate library with *other* tracepoints, lets call it
libtracepoint.so
*) don't link the application to any lttng library.

Which means:

1) the application works without lttng libraries. tracepoints are no-ops
2) if available then liblttng-ust-tracepoint.so is loaded (constructor
function from your headers). tracepoints are no-ops
3) if the application dlopen's libtracepoint.so and in turn
liblttng-ust.so then tracepoints work.

I'd lose option 1 compared to reimplementing tracelog using homecooked
lttng-ust-tracelog tracepoints.

So, are there any issues using <lttng/lttng-ust-tracelog.h> that way,
it seems to work fine,
are there mutliple competing instances now?
(I am not re-using any bit from tracelog.h, I am just after using the
tracepoint definition).

I mean I could dlsym all the functions, but tracelog has 1 per
loglevel and really ugly long names ;)

Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
