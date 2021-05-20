Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEB3C433B4
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 12:21:00 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D773861186
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 12:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D773861186
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fm83G5tmtz1rJQ;
	Thu, 20 May 2021 08:20:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621513259;
	bh=sYzQKi+6dkpDcpwOyHXwLoFSs1JfEho9MCg/rDr+240=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SP8ltr0I3ct3evANFkB4OQAhFRuGMWHICEX5Tl0D8NkhKpJ01DDXvN8+ihlBh1abv
	 yeooKe1axGlkr/9kzClZQSAV8VgUmk6yt693VRAK61cNs7V25NeulAozFVr/atXFVw
	 upR+qmxhofHL4GMtzXjev7pb805Cd8FrkE+UcLr52Fm4SME+aHog6g7bIpKYdHeyfK
	 iv1cR2yLY+e2oGhsFE9XYK5ny678oy/YPd/yQBh02JVF3+i7NoG4KcxcPzuqU2peB0
	 DUATsCgVH3eg3GTrS6VHRa4eZlo0Khi9Zj2R8i48sqNPAVSTt/MfHGVsu9xpaDRFwd
	 1dfv4ipXB3vqQ==
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fm83F4PqPz1rJP
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 08:20:57 -0400 (EDT)
Received: by mail-oi1-x235.google.com with SMTP id c196so8007852oib.9
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 05:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B8zrmsYFe1n75kQjFWWRjkkLZ6NzgYWsnfDx1B88/p4=;
 b=Wbdl6S3sUyySk6FCWlfmvflzKORNQJUofJ2HZmMh6zKXsi+1WNQSu2IKTVY2geURfV
 OVRm6Nkl7qSr/9znTlBCNZftW7vECXhUqWiUUBGHnojm4TrNISAaNdeK/7a+Yd62jk1S
 mTPJLcdUvMEg1HK+obJiRI3HrFtKlc+9TOeJ7bjeZwBjT8IN1io4mkmZ1JMAiLd5S9A1
 PKA6xKPKzBGCQ2bWoSGYMK7F/MGsKz84UkIM5fm4i87/7EGsoUNiQDF2EZvEXmxCIh40
 goTYJiyGwbs8NBxlNJUTbVxg4OoLZBqC5mJa5GYnQK14cuCwNiCx0VAHdwx7JOxlEwry
 vobA==
X-Gm-Message-State: AOAM530C/Kk2HKkBPDp+hcsw8odya+iRvruvAufD9zEF+eX9lpRGiSPk
 iX/R8Ka0zYxX86q2ojPFaQjqXJWz63lFVRJCti8=
X-Google-Smtp-Source: ABdhPJwrhtpzT6el0aZE/KfhIvab39b2c3YR6cVj4q3sUEbELd4mv/SjLtY3gTeuJGDutmm7v4u3deZG8FYMLnWBl5s=
X-Received: by 2002:aca:acc7:: with SMTP id v190mr3133041oie.28.1621513256899; 
 Thu, 20 May 2021 05:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210519165648.792939-1-nolange79@gmail.com>
 <1498635684.51674.1621450841774.JavaMail.zimbra@efficios.com>
In-Reply-To: <1498635684.51674.1621450841774.JavaMail.zimbra@efficios.com>
Date: Thu, 20 May 2021 14:20:46 +0200
Message-ID: <CADYdroMkj-tsaBBFqnDsRk2cX5DNxO-yYzLpARJzkNx6CRc5jg@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] [PATCH] Avoid using the heap for small strings with
 tracef/tracelog
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

Am Mi., 19. Mai 2021 um 21:00 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
> ----- On May 19, 2021, at 12:56 PM, lttng-dev lttng-dev@lists.lttng.org wrote:
>
> > Try to use vsnprintf with a 512 Byte buffer on the Stack,
> > if that fails allocate a larger one.
>
> I agree with the approach.
>
> Can we move the hardcoded "512" to a #define within src/common/tracer.h ?
>
> Thanks,
>
> Mathieu
>
> >
> > Signed-off-by: Norbert Lange <nolange79@gmail.com>
> > ---
> > liblttng-ust/tracef.c   | 13 ++++++++++---
> > liblttng-ust/tracelog.c | 12 +++++++++---
> > 2 files changed, 19 insertions(+), 6 deletions(-)
> >
> > diff --git a/liblttng-ust/tracef.c b/liblttng-ust/tracef.c
> > index ea98e43e..18c29e25 100644
> > --- a/liblttng-ust/tracef.c
> > +++ b/liblttng-ust/tracef.c
> > @@ -32,17 +32,24 @@
> > void _lttng_ust_tracef(const char *fmt, ...)
> > {
> >       va_list ap;
> > -     char *msg;
> > +     char local_buf[512];
> > +     char *msg = local_buf;
> >       int len;
> >
> >       va_start(ap, fmt);
> > -     len = vasprintf(&msg, fmt, ap);
> > +     len = vsnprintf(local_buf, sizeof(local_buf), fmt, ap);
> > +     if (len >= sizeof(local_buf)) {
> > +             msg = (char *)malloc(len + 1);
> > +             len = msg ? vsnprintf(msg, len + 1, fmt, ap) : -1;
> > +     }
> > +
> >       /* len does not include the final \0 */
> >       if (len < 0)
> >               goto end;
> >       __tracepoint_cb_lttng_ust_tracef___event(msg, len,
> >               LTTNG_UST_CALLER_IP());
> > -     free(msg);
> > end:
> > +     if (msg != local_buf)
> > +             free(msg);
> >       va_end(ap);
> > }
> > diff --git a/liblttng-ust/tracelog.c b/liblttng-ust/tracelog.c
> > index 65fc87ed..a5d110fa 100644
> > --- a/liblttng-ust/tracelog.c
> > +++ b/liblttng-ust/tracelog.c
> > @@ -35,19 +35,25 @@
> >                       const char *fmt, ...) \
> >       { \
> >               va_list ap; \
> > -             char *msg; \
> > +             char local_buf[512]; \
> > +             char *msg = local_buf; \
> >               int len; \
> >               \
> >               va_start(ap, fmt); \
> > -             len = vasprintf(&msg, fmt, ap); \
> > +             len = vsnprintf(local_buf, sizeof(local_buf), fmt, ap); \
> > +             if (len >= sizeof(local_buf)) { \
> > +                     msg = (char *)malloc(len + 1); \
> > +                     len = msg ? vsnprintf(msg, len + 1, fmt, ap) : -1; \
> > +             } \
> >               /* len does not include the final \0 */ \
> >               if (len < 0) \
> >                       goto end; \
> >               __tracepoint_cb_lttng_ust_tracelog___##level(file, \
> >                       line, func, msg, len, \
> >                       LTTNG_UST_CALLER_IP()); \
> > -             free(msg); \
> >       end: \
> > +             if (msg != local_buf) \
> > +                     free(msg); \
> >               va_end(ap); \
> >       }
> >
> > --
> > 2.30.2
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

This patch was intended for 2.12, no src/common/tracer.h there.
Also this patch is brocken, as a va_list cant be iterated twice.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
