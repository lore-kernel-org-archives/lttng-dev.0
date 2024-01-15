Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A1AC3DA79
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Jan 2024 16:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705336185;
	bh=lIIdbIjj0pc11pZ33W2HLv+FwOBkCfCMxoacPXFujhY=;
	h=Date:To:cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=u5p88zLygCXV1yhwj7W+tj4iXudwfSvKCu1XvTaBi/jdG9ZinG/ekcbolwmYoGWKt
	 Q8mydDlDZTDtQrLYZqq6nj88pyt+mAutRvqFOZ6kXztFzINB3wKE1wDrsHwrrnAD/4
	 6YpJ3XoSlz52VefSzxJYNz02T5toiXYvjTcKeElQUYMUnT/Stbhhl1JDXw+lOYUD6j
	 nVj5+c/n3ZvsMOefDNcYQyAILpPs9XubHYfDbEufy6ell6lib2iRILGitTvGHr2o7H
	 0KzH64LOIRtDOKprGMedFcv44QFkJsHS+cdjDDpbcrfHbLZjkSw2j7V1mh3glK/ZH3
	 OFmfyZ+IYTOgg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TDHfc6gbnz1PM0;
	Mon, 15 Jan 2024 11:29:44 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4TDHfc1TSlz1Nm4
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jan 2024 11:29:43 -0500 (EST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-xp6-9xu3NT6wBOWfjCSYwA-1; Mon, 15 Jan 2024 11:29:41 -0500
X-MC-Unique: xp6-9xu3NT6wBOWfjCSYwA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3370de320d0so6691585f8f.1
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jan 2024 08:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705336180; x=1705940980;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0T3mEzWDMxKDP4ub2LbeDTdteTWuZJo9NHuP8E84c/Q=;
 b=lcHDOTbs4NVTnUiqhtDz5sthPQkJhcEq/K84CTd1tyk3YZgrZUmuy11O3VR2isgeZh
 3D+QfuYAhYPffngf//vuf7IepNvwS5J+IknTrv2GX8EQm8QRS9e6KK5lvBp9/m4ZhAAA
 iQ5wNay31RpJJdy5aFp0GkNty6sPc6d9KaMTWG16py5HnyyeW6HnIONHA8CPlM7lXC2C
 NbMSVeDH+tmbqRh5FN8ZCuA6e06teCwX/jScquSXgADwS1OOxwTTvAioC9Vu1ZoDr4ze
 d4m0B2W1KCbpCu6tSfn6X8gr2J5JGwmfliR46lER8gLURHoq+kXh6Sl5eRzuoy5zPgF6
 FP3g==
X-Gm-Message-State: AOJu0YxK6evN6h9XEPNimDzEEOKFmyB27fe1fO4E9i/a/DL0C0ls/Qpk
 s4d7E7+865peJTM7H5kGmLzrnEx4GwMEUAqF54UMfwJapYq3ta48fDdqVBl9IbhChrY6KBfkV5N
 1DokHeg0ZOK8AJUrBQiJPnMkqXgVW
X-Received: by 2002:a05:600c:c9:b0:40e:629a:b7c9 with SMTP id
 u9-20020a05600c00c900b0040e629ab7c9mr2129457wmm.40.1705336180097; 
 Mon, 15 Jan 2024 08:29:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrsnjJS2SBwVVTLxOY2KbLrf50154o3Ka5yp1boItE2Ckk2cyH9gt4XGLgcwbKLDCyD4V7Vw==
X-Received: by 2002:a05:600c:c9:b0:40e:629a:b7c9 with SMTP id
 u9-20020a05600c00c900b0040e629ab7c9mr2129451wmm.40.1705336179600; 
 Mon, 15 Jan 2024 08:29:39 -0800 (PST)
Received: from digraph.polyomino.org.uk (digraph.polyomino.org.uk.
 [2001:8b0:bf73:93f7::51bb:e332]) by smtp.gmail.com with ESMTPSA id
 n19-20020a05600c501300b0040e813f1f31sm766684wmr.25.2024.01.15.08.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 08:29:39 -0800 (PST)
Received: from jsm28 (helo=localhost)
 by digraph.polyomino.org.uk with local-esmtp (Exim 4.95)
 (envelope-from <josmyers@redhat.com>) id 1rPPpe-001JSE-6J;
 Mon, 15 Jan 2024 16:29:02 +0000
Date: Mon, 15 Jan 2024 16:29:02 +0000 (UTC)
To: Florian Weimer <fweimer@redhat.com>
cc: Carlos O'Donell <carlos@redhat.com>, 
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
 Szabolcs Nagy <szabolcs.nagy@arm.com>, gcc@gcc.gnu.org, 
 libc-alpha@sourceware.org, Iain Sandoe <iain@sandoe.co.uk>, 
 aburgess@redhat.com, lttng-dev@lists.lttng.org
In-Reply-To: <87jzoa6249.fsf@oldenburg.str.redhat.com>
Message-ID: <7c159449-acb9-3448-1829-1cd26ec2c60@redhat.com>
References: <8734v1ieke.fsf@oldenburg.str.redhat.com>
 <ZaUpDRmDTt8/apMh@arm.com> <da18db08-23e4-45de-91b6-6c49effdeeaa@linaro.org>
 <81279c5d-0b60-0e37-abe9-0936688b14fa@redhat.com>
 <87jzoa6249.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Subject: Re: [lttng-dev] New TLS usage in libgcc_s.so.1, compatibility impact
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
From: Joseph Myers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Joseph Myers <josmyers@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Mon, 15 Jan 2024, Florian Weimer via Gcc wrote:

> The change conflated multiple issues: sanitizer support,
> async-signal-safe TLS access, and eager allocation of all TLS-related
> memory, so that subsequent accesses cannot fail.  My impression was the
> main point of contention was eager allocation because it was perceived
> as a breaking semantic change.  Nowadays, as long as we are willing to
> maintain both allocator variants, we could offer a choice between them
> controlled by a tunable.  For sanitizer compatibility, we could perform
> eager allocation using malloc.  It's probably a good idea to do it this
> way anyway because a separate mmap-based allocator would increase TLB
> pressure.

Related to eager allocation is the question of whether libgcc_s.so.1 
should be loaded unconditionally by glibc at startup - doing so has much 
the same motivation (avoiding subsequent failures from interfaces that 
don't have any good way to signal failure, when glibc currently loads 
libgcc_s.so.1 dynamically), but also no doubt compatibility risk.

-- 
Joseph S. Myers
josmyers@redhat.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
