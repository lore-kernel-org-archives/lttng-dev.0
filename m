Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B28CC433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 09:11:46 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14CF6101D
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 09:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14CF6101D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fm3rw3Pskz1rbg;
	Thu, 20 May 2021 05:11:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621501904;
	bh=cwI/vr0y6LWvt8DaWh13FMvSZ/I2Ykl85J69AmMtfdE=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kWmab8KbC617Ki4DpL+12SxEGyiLwqi2I8paj+KR62MyfCneS9Nv9Zj9vvdMTq+ov
	 onW6FYGw/GvCCNeV7AS0hWOhfD0bGQzXDtYlzmZsvzcLtdjrQFDhI/75FaMVx2QnsW
	 20uGnwvVMxHX2vxPq+kWsSg5pKjm2Xx/weqvY1NIgKqVgWZk/TNpsG5CZfR1Mzmh6e
	 B1Xach/CyFFi4ZSbLOA55j6Kom3rC+qYnPNvSlsemLquEXjOM6U1RR5Mv+XlVX+AnO
	 KiK8s0vkX9aCw1W/sOqJ4CExysA38rc5/KSnhRARe4y2hLevv/YiP6JJmxpexVTOmT
	 3hfR4VKGjyLNA==
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fm3rv1lKnz1rKk
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 05:11:43 -0400 (EDT)
Received: by mail-oi1-x22b.google.com with SMTP id s19so15762935oic.7
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 02:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mgoZDTfaMtpcH6dMEGkU53W6r0VTnFo6lQABiH+seYk=;
 b=Ae1Y4ywSl8BpsJBClFlgvKu2exrBQOcWGJ0wGVFaZMetABCgJyajwVcc2baqv23XFf
 oJe4YlZGp+5PjTCes12LKVYGBijRBqigYNJ5+lg1s8fTmZl/tluUjiNIrYk/Y0U3FQhx
 9WqItA3BpV8BuOhnZhuMRUofS/cDPHTq5gMYYskVMEuDGHDTAgRANfLojNZkF6/umn+9
 VToFsU0kupbC7GoDY1nVgdmR6RhMN4cpHuhzV9B6AE7w7RRw4ex539I39bIKC6KJN7JB
 1nYyyzJkhPHYrkuapIqM+w+qnbtDRd2yprK1bQN6EKgrO6ENc9NpYCtqaVGI81+F4Hn/
 PpHg==
X-Gm-Message-State: AOAM531hXOPSiH8X4fIXDCNegOTGTrGbbBDTmsTlaI6CDG4Nrv7EzXqu
 Gasr2/EyGJ0cMl0QG0iTiKlNSEVgseq6EV7Ht/4=
X-Google-Smtp-Source: ABdhPJyaTkf96me9bO/rZGA74VssCc2EGxv1ck1j/UdySq+evfhaNE5Kh2yMc5EUfGvFl1yYJnuRjFVjevdKD+nYHqs=
X-Received: by 2002:aca:acc7:: with SMTP id v190mr2651228oie.28.1621501902348; 
 Thu, 20 May 2021 02:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <PR3PR02MB6202C5373D6CECC72EBF45DAD12B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <CADYdroOAiKwD_um-ONn=UfNQrOxjs0fM-7ozhUNc18jUQX9cQw@mail.gmail.com>
 <AM7PR02MB6194C2E06B14077092AA06A0D12A9@AM7PR02MB6194.eurprd02.prod.outlook.com>
In-Reply-To: <AM7PR02MB6194C2E06B14077092AA06A0D12A9@AM7PR02MB6194.eurprd02.prod.outlook.com>
Date: Thu, 20 May 2021 11:11:31 +0200
Message-ID: <CADYdroNm+rLkqXV3tjtQ94_PQM_mTiHvmx3JzJG5h2YHbRfguA@mail.gmail.com>
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

Am Do., 20. Mai 2021 um 10:28 Uhr schrieb MONTET Julien
<julien.montet@reseau.eseo.fr>:
>
> Hi Norbert,
>
> Thank you for your answer !
>
> Yes, I am using a Xenomai cobalt - xenomai is 3.1
> cat /proc/xenomai/version => 3.1
>
> After the installation, I tested "test tools" in /proc/xenomai/ and it worked nice.

Just asked to make sure, thought the scripts usual add some -xeno tag
to the kernel version.

> What do you mean by "it might deadlock really good" ?

clock_gettime will either use a syscall (kills realtime always) or is
optimized via VDSO (which very likely is your case).

What happens is that the kernel will take a spinlock, then write new
values, then releases the spinlock.
your program will aswell spin (but just to see if the spinlock is
free), read the values and interpolates them.

But if your program interrupts the kernel while the kernel holds the
lock (all on the same cpu core), then it will spin forever and the
kernel will never execute.

The ugly truth is, that any library you use could call those
functions, you need to very closely look at your realtime path.
Some checkers can help: https://github.com/nolange/preload_checkers



Norbert.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
