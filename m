Return-Path: <SRS0=Lz2h=KU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2740C2B9F8
	for <lttng-dev@archiver.kernel.org>; Tue, 25 May 2021 08:46:50 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536796108D
	for <lttng-dev@archiver.kernel.org>; Tue, 25 May 2021 08:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536796108D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fq73r60MBz1vh2;
	Tue, 25 May 2021 04:46:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621932409;
	bh=gxGGuGvnwbtv7RmiXaZvmVqlDRxZwLpfkco5C9EUfi0=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=aXKNPUvU6T2HIhdJHaaj04XjhQxf7i+n8OvRs9rHmbjjZE2zuEeAdToCfaQbIrTlw
	 +tScWnIBqlMpsf0VS4z1uF8DHl4+s0kMDvZsL0rYXOY/Dj7ygCdjNaQXjeLEEsebXs
	 B5CJj7Tdyirew+ayqjVDMiH/6Q+4BZ5a06yeSXGFOS5F8l8FLjHLN5Le8owK3j8qSQ
	 JsLiOaNFMCoHo3TbxWcGbUOwi2aXy0HUE83JBAzS2rpKDD7dzrDQaNMyaif3g+Am6V
	 LsbJ5nCRJNLrirM6TvXyHL0ASZ6KUP1++4QE0glQjrLQgsfG1sKaj14hfUEG12wkgL
	 9sb96LxLTh0Bg==
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fq73p6cZpz1wHy
 for <lttng-dev@lists.lttng.org>; Tue, 25 May 2021 04:46:46 -0400 (EDT)
Received: by mail-ot1-x333.google.com with SMTP id
 i23-20020a9d68d70000b02902dc19ed4c15so27962589oto.0
 for <lttng-dev@lists.lttng.org>; Tue, 25 May 2021 01:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y2jOcofkOyVSili3ONXaLeX9USNp2YBBtn07TYWh+vg=;
 b=oicC0fOunSm8lz4rtPol9mXdPJyoRfPtx9cnlMiq2QM6eyOl4P8fPDvMiw1GUUWtAv
 /sUwkOHqGKFvYTTMvFiiPm3r4ubtO3gVlf7QQNCDV06t5EVVL7U1OZMdWzT2DqmJq4Lq
 utmi9+cNlx9WF5lrvC1Rwv+q5AmlrqfDznSLnu5Iie4/d1NGb7m/ZgrkMNvKFnH1HiIK
 7U7wsJ2tcz4WZYQykfSSVyE/KyVvJw1RyNwFr0qlbjcIv5oIbvMaT+VJsVFSvec/IHUa
 0Rr21LK5KQMQz82yC1fiXs3GFFT0PPL/Iies3ngWAy96VKtjsjHcM9VYMOZ4V+f/QKaW
 wl1g==
X-Gm-Message-State: AOAM533He+yDIz5Xw6D3g8Mi9nJG4As1NEs5JuBTdSuDlyQlO8UQhg8S
 VjnmH6PiMkkIa/ukPhzuygERCHASO5/TiY2KK7o=
X-Google-Smtp-Source: ABdhPJyebvkniAvjJH1pZb9Vb92qkfosIGoD34MCj8r2wM4F38wGZg6/iWYL1UHSMkM6282P4BuTK+CCPUH8f230EO0=
X-Received: by 2002:a9d:5c14:: with SMTP id o20mr7834109otk.328.1621932406149; 
 Tue, 25 May 2021 01:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <PR3PR02MB6202C5373D6CECC72EBF45DAD12B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <CADYdroOAiKwD_um-ONn=UfNQrOxjs0fM-7ozhUNc18jUQX9cQw@mail.gmail.com>
 <AM7PR02MB6194C2E06B14077092AA06A0D12A9@AM7PR02MB6194.eurprd02.prod.outlook.com>
 <CADYdroNm+rLkqXV3tjtQ94_PQM_mTiHvmx3JzJG5h2YHbRfguA@mail.gmail.com>
 <851697925.52293.1621518874455.JavaMail.zimbra@efficios.com>
 <201689209.52304.1621519010729.JavaMail.zimbra@efficios.com>
 <186729016.52398.1621523346736.JavaMail.zimbra@efficios.com>
 <CADYdroOCUu7BWqMZ1CMa5mHSJB50V1aS+98sVfgXQRPdnJTyYg@mail.gmail.com>
 <PR3PR02MB6202E077AEC8C62B022780EED1299@PR3PR02MB6202.eurprd02.prod.outlook.com>
In-Reply-To: <PR3PR02MB6202E077AEC8C62B022780EED1299@PR3PR02MB6202.eurprd02.prod.outlook.com>
Date: Tue, 25 May 2021 10:46:35 +0200
Message-ID: <CADYdroMmANMwnkfVMUOJuFJ-=_ggnE_4u=qoFSsdtgk_1SkTEQ@mail.gmail.com>
To: MONTET Julien <julien.montet@reseau.eseo.fr>
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, lttng-dev <lttng-dev@lists.lttng.org>,
 Xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Am Fr., 21. Mai 2021 um 12:13 Uhr schrieb MONTET Julien
<julien.montet@reseau.eseo.fr>:
>
> Hello Mathieu, Norbert and Jan,
>
> Thank you for all of your explainations and the overview of the system.
> No I didn't change the ipipe patch for the vDSO, I may try this.
> If I have correctly understood, this patch prevents Cobalt from entering in a deadlock when the kernel is using the vDSO and the program interrupts the kernel at the same time. On which kernel does it word (aroubd 4.19) ?
> I currently try to avoid kernel 5.4 because I remember I faced some boot issues (but it is on another topic).

That patch was for 4.19 AFAIR, but its specific to x86. The Linux
kernel cleaned up the vdso handling to have a common base with some
5.x version,
but back then its been separate for each arch

>
> Here the issues i faced (drawn on TraceCompass). Are these the deadlocks we are talking about ?
> https://postimg.cc/BP4G3bF0 (on 11:02:56:380)
> https://postimg.cc/q6wHvrcC

Nope, if you get such a deadlock, then your only hope is Xenomai's
Watchdog killing the process.
It should happen very rarely (but thats not an argument if your
software should run for years).

Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
