Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAEFC433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 08:21:11 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74339610A2
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 08:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74339610A2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fm2kX5lCfz1rKd;
	Thu, 20 May 2021 04:21:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621498869;
	bh=jduqP9r9QHaNdJPQe4NsPjZnbwv58/O4uZuBWUOBmFQ=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0AT2JoVmC3r8VlK/uIAKCh8BG6K1DL0il42SBin/TrXepreaRbR6l6DioM4Nu3Ck9
	 R/MGT1rDkagQBifvppo+Lg60cvIU7OWGG1DrsaU5Lpd4afXIplMAXEX034mJgCWcJk
	 X5tKDMe+Lf1WwWXo3EL4uBYD4VHhjxDEpVL9gMQ0cewbZ6X++eswmrpvjUdGKdrs1j
	 t/43BR/c3tWsaVFIQJ2ouKv1qzyv7gSVKl+hcYEnfbFX52902jPVCY9ZUd/7Bre+Av
	 EkOZQssMWpVmG1cVp0kVVdvpr9hwjH72wMvYADdbbkTzw5kiC88De6p80QbA9vVvDO
	 Q5bANpJxdgKeA==
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fm2kV5zTJz1r8t
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 04:21:06 -0400 (EDT)
Received: by mail-oi1-x22d.google.com with SMTP id t24so169493oiw.3
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 01:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O9JrJnCFlLwI/Z7IFp2xvCB0hS2tRcyFSCKN18lhPPA=;
 b=F/ntecrr6iHhu7ugDw+l/b6kw6pJR2wUXOWKB8vq1Rr9+WMntQFEwJd6/DrT6cSGgA
 rWDzg7GY1cGERP81RZafn+mPoamMPZcbthMGD98lSeZzbNiCrZe7zJw6GHNozR9t9Ycl
 aUDV1MtWM1Rdv+abN0pFZ50P+z9GH0Sb9piMG+BlqPz+lUYUK098tJ0Db0zUyRvVL3cq
 x7QhtJtOdU0fs3tv2bjvJ+7KoPMhHxYMNeHPjoiz53DTLy5icOQvB9slSNr2KR8dGE+m
 cgWD/93wXPTG9YjOLg5J4psCN78eltzvwVIhuFeT1xkfOyJsGHTr6R0V/ZxjO4ZTrFLs
 5JpA==
X-Gm-Message-State: AOAM531J7IqROsbT45CIuOZPdxPS2hIOyk9+71zLycw73vFfGvXyVhSF
 CrRXCcZs3Ec/Z7+DQjRa77b8VJjiKWNWPQER640XZp73VN9pSQ==
X-Google-Smtp-Source: ABdhPJzvToWMriJxt2/QaB/pPqQ2+iFnN/FCqguF/F6hfEY7QOOEiTXnG3q7K0ddJ4OsXAFyQoxXh8KImwUxZA87Q5Q=
X-Received: by 2002:aca:acc7:: with SMTP id v190mr2536500oie.28.1621498865825; 
 Thu, 20 May 2021 01:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <PR3PR02MB6202C5373D6CECC72EBF45DAD12B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
In-Reply-To: <PR3PR02MB6202C5373D6CECC72EBF45DAD12B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
Date: Thu, 20 May 2021 10:20:55 +0200
Message-ID: <CADYdroOAiKwD_um-ONn=UfNQrOxjs0fM-7ozhUNc18jUQX9cQw@mail.gmail.com>
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] LTTng - Xenomai : different results between
 timestamp-lttng and rt_time_read()
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

Am Do., 20. Mai 2021 um 09:58 Uhr schrieb MONTET Julien via lttng-dev
<lttng-dev@lists.lttng.org>:
>
> Hi the developers !
>
> CONTEXT
> I am currently working on a Raspberry pi 3B with Xenomai and LTTng tools.
> Raspbian 10.9 Buster - kernel 4.19.85
> uname -a : Linux raspberrypi 4.19.85-v7+ #5 SMP PREEMPT Wed May 12 10:13:37
> Both tools are working, but I wonder about the accuracy of LTTng libraries.
>
>
> METHOD
> The code used is quite simple, it is written with the alchemy skin.
> A rt_task_spawn calls a function that has rt_task_set_periodic(NULL, TM_NOW, period) and rt_task_wait_period(NULL).
> ->The rt_task_set_periodic is based on 1ms.
> ->The  rt_task_wait_period(NULL) is of course inside a while loop (see below at the very end).
>
> My goal is to get accurate traces from Xenomai.
> I took two methods to do so :
> -> lttng
> -> basic calculation based on  rt_timer_read()
>
> What a surprise when I found both method have two different results.
> -> LTTng shows me traces [0.870;1.13] ms (or even less precise)
> -> rt_time_read shows me traces [0.980;1.020] ms
>
> Thing to note :
> -> The use of LTTng has no influence on rt_time_read(), you can use both methods at the same time.
>
> Then, I saved the output of rt_time_read inside a tracepoint.
> It appeared the LTTng is always called at the right time because the value got by rt_time_read () is really good.
>
>
> QUESTIONS
> These are now my questions :
> - What is the method I should trust ?
> - I have searched on the forum and I found LTTng uses a MONOTONIC clock for the timestamp. Can/Should I modify it ?
>
>
> CODE
> -----------------------------------------------------------------------
> A small part of my function called by rt_task_spawn :
> [...]
>     RTIME period = 1000*1000; // in ns
>     RTIME now;
>     RTIME previous = 0;
>     RTIME duration;
> [...]
>  while(1)
>     {
>         overruns = 0;
>         err = rt_task_wait_period(&overruns);
>         now = rt_timer_read();
>         tracepoint(tp_provider, tracepoint_tick_ms, now, "tick");
>
>         if (previous != 0)
>         {
>             duration=now-previous;
>             rt_printf("%llu\n \n", duration/1000);
>         }
>        previous=now;
>    [...]
> }

Are you using the Xenomai kernel ("Cobalt"), or just skins via
copperplate ("Mercury")?
You have some file /proc/xenomai/version?

The Xenomai kernel has his own clock, which in general is not
correlated to the linux monotonic clock.
(Under some circumstances it might be identical).

My plan is to use a clock plugin for Lttng, particularly because if
lttng uses the linux monotonic clock from a realtime thread
it might deadlock really good ;)

Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
