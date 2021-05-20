Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EEBC433B4
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 13:44:32 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAC360240
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 13:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAC360240
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fm9vg0CMKz1rxB;
	Thu, 20 May 2021 09:44:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621518271;
	bh=fEb/jXm/Ws+HZN9NoN0iZcrU22CQ2eFAJKTOd70Mo74=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=OHP26b3pIIT49Fh8Wyh6FmIjtxAgKnxiHbLgN56zG866K/cvdGH7ky9RGy+5a/+85
	 lfRYrNFVhUzsEfZxCaP/gB1+WBt0bBZQK/reBlzF2rpNQD5BFLppVsLL+9yv2OAqPs
	 5Xr2vh3QALY+bwDZaSCVAVP013dqss3TjVhYSYOaKb9hpGOrMh/RxPiBn2s1W96dKw
	 +iiwqkp60e7FlpvhFTktjrtRJVi8nO+jUQOSZyoiJj88RveiLTt39c4gmV8/f4RZ7k
	 s2TCTzQaIFd/uFyluMVBwiiOlhTL5htZD8BK0RHepu0n1IRxAWZP2ip9QYV+b0lM1W
	 2qqs1E+rxpRJA==
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fm9vd4h3Bz1rlT
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 09:44:29 -0400 (EDT)
Received: by mail-oi1-x22a.google.com with SMTP id b25so16491006oic.0
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 06:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Re2Kft3XxHa1CyAnmh6tTgUgPFswDcn7BgFS50sPtw4=;
 b=RFrIFHdAYBhzq/lkwkiCiYtfvCsZRyKBqTYJJFOXrtvAl31wR0cFXvZzAkhdX7L90T
 XKZum0Gul/Upzdwi9AO0o1rtjE8Y7oQbphVkF9mKos823Bre1cuOe0To4HsOlmck5t0P
 P1WgKB9rJ9pVHo7EVcq+Em+JiuJFN91urxUux1CTLV2+xQX/KVjhJedOyDzLJ7yn/cOG
 AhKd3f0zOLFPMXK5nRaVY5aR7Hy9cqILOSEmJPHHYXOU9xF+Lji5rfxYOdk4A99ovFF4
 Y0CyQsy6y24gumNB7hBs2N6Stsbsek6u7I+v96fapvybN5Fk/Qr4VDQZb9LeI+fa/CDv
 20kA==
X-Gm-Message-State: AOAM5324k6r1HIOK0rG2+w8BUIBvCXsVv3G4rZEINWy6PpohU+LIihr8
 EFSR8er4Dfrsm6WsfAJDBFPyhJnkwlkKtMtzj4Y=
X-Google-Smtp-Source: ABdhPJw55aLKl3f85pClOTMhF4cVm5p3j5vHpcKHCsxvWBJZO6JlGmM2nim/VnEDF9Tl6S/QR3kSITki8xQQ71LkB4Q=
X-Received: by 2002:a05:6808:1402:: with SMTP id
 w2mr2153737oiv.72.1621518269101; 
 Thu, 20 May 2021 06:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210519165648.792939-1-nolange79@gmail.com>
 <1498635684.51674.1621450841774.JavaMail.zimbra@efficios.com>
 <CADYdroMkj-tsaBBFqnDsRk2cX5DNxO-yYzLpARJzkNx6CRc5jg@mail.gmail.com>
 <1632491203.52217.1621517618464.JavaMail.zimbra@efficios.com>
In-Reply-To: <1632491203.52217.1621517618464.JavaMail.zimbra@efficios.com>
Date: Thu, 20 May 2021 15:44:18 +0200
Message-ID: <CADYdroN9bvvG2ga+UUatA0qUZi8LgoYTvT1RW4EGUBx6Gnjyog@mail.gmail.com>
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

Am Do., 20. Mai 2021 um 15:33 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
> ----- On May 20, 2021, at 8:20 AM, Norbert Lange nolange79@gmail.com wrote:
>
> > This patch was intended for 2.12, no src/common/tracer.h there.
>
> You should post feature patches against the master branch. Or if you just
> want to send a RFC, and you work on an older branch, please state that the
> patch is RFC and which branch the patch is against, but that work won't
> be merged unless it's rebased against master.

Yeah, I read the contributing guide since then, sorry =)

> > Also this patch is brocken, as a va_list cant be iterated twice.
>
> Right. But you could easily do:
>
> va_start() [ first use ] va_end()
> then
> va_start() [ second use ] va_end(), right ?

New patch vs master does this.

Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
