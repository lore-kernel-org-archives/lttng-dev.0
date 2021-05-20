Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DFFC433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 15:39:45 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97E0610A2
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 15:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97E0610A2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmDSb3rGPz1rm8;
	Thu, 20 May 2021 11:39:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621525183;
	bh=Rlx8OSKsGmJCq5SJXNXN/QXSwwh9B8YZmOQ/1ptCD7k=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Gm94f+fgPBIUybBkTEHPGrjzt6FVeB8e9Xs7CnNlDOUY4RYfrNrYdDH9T32B2A5WL
	 I0GKqnixqPdl/BVQYq0MEUW4z8MGZRoqze9wz3uf3+Vljl4HGIQxrqj6/EBye00R//
	 ALNE216HE8h7kVy4ZK0EfSlTLaQ74s5JzNOOXTuazCwArFx8xp/RGjOqwsNOHI+Yfx
	 eUl91zmh4wvF4Ye4QI68IG1yeExJHvV4WmTe4nF7CWKs2ej+SyqyweejFgGrmeXN3r
	 ff5eNW0GuGpZYt0COj28BldT2ckG47V75y7RDapnIophUetqiI9Ni45XQuDTnmn6a0
	 6g8Kobs+tANjQ==
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmDSY5zXHz1rgv
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 11:39:41 -0400 (EDT)
Received: by mail-ot1-x32a.google.com with SMTP id
 36-20020a9d0ba70000b02902e0a0a8fe36so15207330oth.8
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 08:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F8AemLAt/RdYTuSK/AAEBh7ZyUM4eAslxQ/cddZZkBM=;
 b=mi6ppreq3ToPGyEY03a8YZKYHYUHWsoiM1i/nQwxSNgGxJPWYKzHwmQQ3uu0JpVx3g
 5TQvAgGUAXGahU33EJuAl2QZT0xnVyt7IB54YJ1ivJWdQJx+3kPBdJl+UYXVAEWZni/p
 3oRysCiRI0mzZytOctb/X+zmqyZgrzjMAT3Z/OCVTPwQzyC5jK6zrhL8trtJImLk5jMB
 kgmQFpR4RulbD7hhsW8giVv5bJEnfmN5egr5tUsOe1pQ9VTPduUnDk0CAjdbpchIULTQ
 d7unYk3BjKybHlhJoPIXu/HPb+7lTHDC9fB3d3WoXy47/JjLkXx3WevYzhi7BwAYKnQf
 sLhg==
X-Gm-Message-State: AOAM530NeYqYHBSjY9/YldUvviC2PhGAaWu8CY9/N5PYDJz5tyPx+R0S
 ZUtaTeMy0OXoYYHH3eBpdUU/cziW/d+gErDD74A=
X-Google-Smtp-Source: ABdhPJyMYLK01O1Do9B95OEDbLt5iDRCQfFmtY2NHkrOyR1TSA1TjRhvyospmm6QhIdTYc6eDquzNn4Eh7DVHwoPYTo=
X-Received: by 2002:a05:6830:51:: with SMTP id
 d17mr4392681otp.75.1621525181067; 
 Thu, 20 May 2021 08:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <PR3PR02MB6202C5373D6CECC72EBF45DAD12B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <CADYdroOAiKwD_um-ONn=UfNQrOxjs0fM-7ozhUNc18jUQX9cQw@mail.gmail.com>
 <AM7PR02MB6194C2E06B14077092AA06A0D12A9@AM7PR02MB6194.eurprd02.prod.outlook.com>
 <CADYdroNm+rLkqXV3tjtQ94_PQM_mTiHvmx3JzJG5h2YHbRfguA@mail.gmail.com>
 <851697925.52293.1621518874455.JavaMail.zimbra@efficios.com>
 <201689209.52304.1621519010729.JavaMail.zimbra@efficios.com>
 <186729016.52398.1621523346736.JavaMail.zimbra@efficios.com>
In-Reply-To: <186729016.52398.1621523346736.JavaMail.zimbra@efficios.com>
Date: Thu, 20 May 2021 17:39:30 +0200
Message-ID: <CADYdroOCUu7BWqMZ1CMa5mHSJB50V1aS+98sVfgXQRPdnJTyYg@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: MONTET Julien <julien.montet@reseau.eseo.fr>,
 lttng-dev <lttng-dev@lists.lttng.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>
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

Am Do., 20. Mai 2021 um 17:09 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
> ----- On May 20, 2021, at 9:56 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
>
> > ----- On May 20, 2021, at 9:54 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
> >
> >> ----- On May 20, 2021, at 5:11 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
> >>
> >>> Am Do., 20. Mai 2021 um 10:28 Uhr schrieb MONTET Julien
> >>> <julien.montet@reseau.eseo.fr>:
> >>>>
> >>>> Hi Norbert,
> >>>>
> >>>> Thank you for your answer !
> >>>>
> >>>> Yes, I am using a Xenomai cobalt - xenomai is 3.1
> >>>> cat /proc/xenomai/version => 3.1
> >>>>
> >>>> After the installation, I tested "test tools" in /proc/xenomai/ and it worked
> >>>> nice.
> >>>
> >>> Just asked to make sure, thought the scripts usual add some -xeno tag
> >>> to the kernel version.
> >>>
> >>>> What do you mean by "it might deadlock really good" ?
> >>>
> >>> clock_gettime will either use a syscall (kills realtime always) or is
> >>> optimized via VDSO (which very likely is your case).
> >>>
> >>> What happens is that the kernel will take a spinlock, then write new
> >>> values, then releases the spinlock.
> >>> your program will aswell spin (but just to see if the spinlock is
> >>> free), read the values and interpolates them.
> >>>
> >>> But if your program interrupts the kernel while the kernel holds the
> >>> lock (all on the same cpu core), then it will spin forever and the
> >>> kernel will never execute.
> >>
> >> Just one clarification: the specific locking strategy used by the
> >> Linux kernel monotonic clock vDSO is a "seqlock", where the kernel
> >> sets a bit which keeps concurrent readers looping until they observe
> >
> > When I say "sets a bit", I actually mean "increment a sequence counter",
> > and readers observe either odd or even state, thus knowing whether
> > they need to retry, and whether the value read before/after reading
> > the data structure changed.
>
> Looking again at the Linux kernel's kernel/time/vsyscall.c implementation
> of vdso_update_{begin,end}, I notice that interrupts are disabled across
> the entire update. So I understand that the Interrupt pipeline (I-pipe)
> interrupt gets delivered even when the kernel disables interrupts. Did
> you consider modifying the I-pipe kernel patch to change the vdso update so
> it updates the vdso from within an I-pipe virq handler ?

Yes, I did use an non-upstreamed patch for a while to get things in order:
https://www.xenomai.org/pipermail/xenomai/2018-December/040134.html

I would prefer just a NMI safe source that might jump back a bit, no matter how.

> AFAIU this would allow Xenomai userspace to use the Linux kernel vDSO
> clock sources.

The Xenomai folks are trying to get their next-gen abstraction "dovetail" closer
coupled to the kernel, AFAIR their will be VDSO support and
unification of the clock sources.

Still need to get stuff running today =)

Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
