Return-Path: <SRS0=Lz2h=KU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61409C2B9F8
	for <lttng-dev@archiver.kernel.org>; Tue, 25 May 2021 13:32:31 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC316108D
	for <lttng-dev@archiver.kernel.org>; Tue, 25 May 2021 13:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC316108D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FqFPS4KSgz1wPG;
	Tue, 25 May 2021 09:32:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621949549;
	bh=VWJHcyBu+8n9Ot1utMTZq8yno1hEDCdbg2RL/dMzYKE=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Kjgw//WRZScX7koU/NGF+x9MAhBxmsVOJJMLeVLbpidlO5Xs1iFYrUU7Fxk6tg0nq
	 ZGS00idgSiWPsqtUmzzigkLFSpHUvdCj884OQfriXw8UDL15TIV3nom1zqE7tdpMEm
	 Vs5U126P4xpqczTiZN97HDr3F7NSY3bVdIgKFgIqpvRgwiP2I6Yz5Ze+tJucM1C7nA
	 K0xgHruyovowZSwKHiX2z77XA/rGsR9uD0kmwYFvb/tQwp/IM/c3SiRtPq3YHS0SxN
	 4Top9D2ww5G0qagwUSw0hBdzfXate3YNeRs7AVsvq1lmBvnpFSrVfxxgOnV8PAXE7R
	 38zz5I/sJegOg==
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by lists.lttng.org (Postfix) with ESMTPS id 4FqFPR1vmWz1w9v
 for <lttng-dev@lists.lttng.org>; Tue, 25 May 2021 09:32:27 -0400 (EDT)
Received: by mail-ot1-x336.google.com with SMTP id
 69-20020a9d0a4b0000b02902ed42f141e1so28582173otg.2
 for <lttng-dev@lists.lttng.org>; Tue, 25 May 2021 06:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0cOObiyoOLCeaZdxFQsMv8Z1b4lJfJ9jHLtz4aro4OY=;
 b=l/xfFiFQzndL1plb3mklarTAxJ/0eitH9z0zyRTKXkY5EvnQ7zesrU1lVVNAB+roZS
 Qqru1J5VdnPrEAw4bAbdCiQLeUESv7ls/jWGwIxo2mOkGsoVHexOE5qSSWOCRLBzjjT3
 eXjTGPwdTitYSibMcXu0tF1BHmRP+XjUCeber4nXiiIjWYL44/SJyxmVS253iz/J44nU
 NgTigtwPGnwEmrLpDW4NIzFgWkLTRR4eKHguhFAZQ5Nv8MWQ/7XMAcCzUiI1fvgpxOuF
 VYQ5Vcls9B5In8J3Oen5CiSXNcgwmy6yDQn9WzBSbDZNSw48k45M3A36b1Wdd2ZXMPib
 ++6A==
X-Gm-Message-State: AOAM533a0hSGoL3BHVPTzFXcP4tv/EbaEvmA8u6aKusQ7OYAUPN5e55k
 hgDaQT9pvqND4HjSnMe+nBINx1tSLjXbDza486A=
X-Google-Smtp-Source: ABdhPJzBMF/x+miwGKfXZH+bUZKjGRgCQeMLSoaz1OuD1GrLspz1bJPCFPBKZD42bb4u6ntVEbOBTW1mUq+bnGTYNdk=
X-Received: by 2002:a9d:7612:: with SMTP id k18mr22872103otl.178.1621949546337; 
 Tue, 25 May 2021 06:32:26 -0700 (PDT)
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
Date: Tue, 25 May 2021 15:32:15 +0200
Message-ID: <CADYdroO7wuokeU_zqzPw0VsCc1HrTZAipai6qp1tQrX0aVhdPA@mail.gmail.com>
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
>

Make a own thread for this?
I testet this, but get errors as liblttng-ust-tracepoint.so depends on
symbols from liblttng-ust.so.

/usr/lib/gcc/x86_64-linux-gnu/10/../../../../x86_64-linux-gnu/bin/ld:
/tmp/opt/hipase2/buildroot-acpu/host/x86_64-buildroot-linux-gnu/sysroot/lib/../lib64/liblttng-ust-tracepoint.so:
undefined reference to `lttng_ust_probe_register'
/usr/lib/gcc/x86_64-linux-gnu/10/../../../../x86_64-linux-gnu/bin/ld:
/tmp/opt/hipase2/buildroot-acpu/host/x86_64-buildroot-linux-gnu/sysroot/lib/../lib64/liblttng-ust-tracepoint.so:
undefined reference to `lttng_ust_probe_unregister'
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
