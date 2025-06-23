Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F025C77B7C
	for <lttng-dev@archiver.kernel.org>; Mon, 23 Jun 2025 19:05:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bQyFV6Wbdz2C2g
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1750705504;
	b=I8fc2IFTPEVHZ1vfSUOaRDYPvM8pL6Bgq8MV+S17akYYnuSh5GChkyYzl6LSoh7Qgi62
	 UEkN+tOfRtJFl+MjJ5XPPUbnD4KnGy1QAaq9WtDxquVi04uUHmEu7Pc3V1wgL108Saw7d
	 eY7XxOJ9Se99yGigGfULkX5BynslWgKOpxtc1TR9rzXdfoERg5p53Hbx/QSO1p3Vn4ahs
	 thgSP6n6ehxbvMWqShZgtvgm5O1asD1Hz+C1IejJf8klXX2MBbc+0sB2KSGYvmG7biJBY
	 Nxa/gtf7RHLp/cuch67mXzzPJZo84CV40yc5bQmFGviCJNs2OU31SZ42N2Bdre3RLpQ==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750705504;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=74oeh2J2d/58Qth+oWtSXYMZb8vInHAhjxqx7fbWTM8=;
	b=b526PMYa112ZtYG2yNCa4xAwH/hnp+iWlPANANCtiXv+3K6ZzVOLEhGwfh7gY3/oqfI/
	 w21AVu19PcmqXBTwHy6JMDa+/o8ez+FTfVq2tA6tW5MyFbKjkqzXRUt/1wDtKO4D9IAuk
	 DtSq0XfBFlZKLfr+te2TPEUBhtStFDMOCGqsNnZRSDpG8yfd6bNVKSXx000cn1vozakeo
	 KXsuYQd3LUCu8fDufQtM/E358SRas4mQ2ggCYQDr8R9HkFLkPvUqmtzK4qBRXiEqXHlqA
	 0nub1ulDxQACv/vNLkM8oRYDO013x9+3jMpR0dS9wq0g9Lix7nCbJUDKVt4JMNFodqA==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bQyFV6Wbdz2C2g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750705504;
	bh=74oeh2J2d/58Qth+oWtSXYMZb8vInHAhjxqx7fbWTM8=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LI5a5uQL8dpje6MbPKA3EZ7b/8ZrDPEYFCKiXkuJwnKz2BG2zDREhoqa+F466MHul
	 pY8OCNtWkS09b0dqdYm9UfaKKSjKfxL17C4YtkvfFhW9S0mDvlVx3Gn74Fm3HszCdF
	 s0XgvaVWGzSzFqZCWl1UuNn7H7Y7G9/cdoCo4m6LerchkLux5M5GC5umLwLpkn8N5c
	 9OMEV9shdx1deMigjkaGf8eSMfSXyNVzwUm+seDhShmgylUPaVUGqhM+zyv0Ui0H5A
	 zC4hF5sfFkzLPEAUO80Q6UKV0rfFjCCmIZrCCuMrtzyHveBVyCM+54iQ/ADyv7kXPE
	 9AmhfgTlcUttw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bQyFV6Wbdz2C2g;
	Mon, 23 Jun 2025 15:05:02 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bQyFS5CtQz2C2d
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bQyFS5CtQz2C2d
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by lists.lttng.org (Postfix) with ESMTPS id 4bQyFS5CtQz2C2d
 for <lttng-dev@lists.lttng.org>; Mon, 23 Jun 2025 15:05:00 -0400 (EDT)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-32b553e33e6so39253041fa.2
 for <lttng-dev@lists.lttng.org>; Mon, 23 Jun 2025 12:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750705494; x=1751310294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xqLJKv2KWO9qzSOXYRzHleJD4SosvWrdUnYhZjHkN9I=;
 b=set5jMvgFskKOU2wB4qhfgzhPSj6mP8oYSfZajCRjhAD4JVoLhZXhzo03Bom+3uHGK
 mLTRKxmfStKHjGZY70RjV9Q/DadTa0MC1yPwLVWDLCpO5LNoiLhWLdh9IMtQnpet5YNj
 YGJbhkrp7F6WnVU67qkLQ2gDEI3QTPi/KfPtRW2guDrqd/IahXLeGlDFFPZrf0mvYw36
 C4s/kAZ4ymr+g6dIr5qmwyfyczrlPnkC0ySsu61tY64zjhzEkGiAQ339AoiaH4nB0PK0
 OwlYxA0JuLAMI/dH8z4dgW/GYh1Clo1KxF7AQ8E+LnGxu6paWA+xXMlXxYOknUJpJgMz
 Qbdw==
X-Gm-Message-State: AOJu0YxI0VpjqYNL/HA8LVMI3mbFKRBtJf3lrpnWcv5FYuoZPaEVNLxj
 QHr1C7LP+hxGpBdM+AtnNNvyiLB9iB8JGFu/xuVO0bjMAipEkfv4fQNEh/lG9WvtrtBd9AhgbkL
 peC0CRkzEXbpnoLV2snBUqfscghgwI4o=
X-Gm-Gg: ASbGnctZR3Lg5YqHBJTCAAUahuvSVEGLOyN1xcQDsSxhzbx9aslZQBDDyNOMc7Yr/rM
 BRnp3xanjq1hmmSYLJqOw15KvAaYYwXMexnybNXQaKgMmiMSM4EOROkTfqpdu4H6Rb957o39BFw
 S9CAwMk/5QSvGRplZ3ylHXIsj/xpKraQ84ASKuuADEEw==
X-Google-Smtp-Source: AGHT+IFRLLSJzVnGKc+Utgp57pLbve6gCudRJM1fhaO6eiy9s5+EqiJGLp4W+3cOwpWHJ9AQgI8LhlycIfCNbvjjWHA=
X-Received: by 2002:a2e:bc1a:0:b0:32a:de39:eb4c with SMTP id
 38308e7fff4ca-32b98ea9ae0mr42861201fa.18.1750705493563; Mon, 23 Jun 2025
 12:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <CADYdroMBu0gocZXpeaMWqr3TG4p5FW71eeN1+y-XM_8bDxijzw@mail.gmail.com>
 <df98623f-172e-4e71-9592-cb864e239000@efficios.com>
In-Reply-To: <df98623f-172e-4e71-9592-cb864e239000@efficios.com>
Date: Mon, 23 Jun 2025 21:04:42 +0200
X-Gm-Features: AX0GCFuz8_KQHFUgqM0c8Ga9-SXOuTfOOOl-Tj40tQYT_OThazyWhsKIDn0_M1g
Message-ID: <CADYdroMtZ8qYToUF+GF8ZbgAzjHu5yMv9+dtk8Hjki_FMx=PWA@mail.gmail.com>
Subject: Re: Method to get LTTNG-UST version during runtime?
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

I dont want to use anything else, I just want  to add instrumentation
for dynamically loaded tracepoints that does next to nothing if not
activated (see [1]).
liblttng-ust-ctl is not even ABI compatible between 2.13 and 2.14
(different soname), so that's pretty useless since it already binds to
either 2.13 or 2.14 at compile-time.

[1] - https://lists.lttng.org/pipermail/lttng-dev/2021-May/030004.html

Norbert

Am Mo., 23. Juni 2025 um 16:21 Uhr schrieb Kienan Stewart
<kstewart@efficios.com>:
>
> Hi Norbert,
>
> If you link to liblttng-ust-ctl, you can use `lttng_ust_ctl_get_version`.
>
> thanks,
> kienan
>
>
> On 6/18/25 11:22 AM, Norbert Lange via lttng-dev wrote:
> > Hi,
> >
> > there are some substantial changes in 2.14.0 that afffect how/if
> > tracing is possible.
> > For ex. c246521ddcba1d1d28cfa0482aa500b9122e7264 allows doing more work upfront
> > by calling lttng_ust_init_thread().
> > With 2.13.x the same code will instead do various syscalls or
> > allocations during the first tracepoints, violating realtime
> > constraints and possible abort the process.
> >
> > I miss an easy method to inspect the Lttng UST Version for checks or
> > workarounds.
> >
> > There is the lttng_ust_loaded variable that could be abused to carry
> > an packed version instead of 1. (Of course that could always cause
> > fallout)
> >
> > Regards, Norbert
>
