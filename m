Return-Path: <SRS0=zN6S=HK=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC27C433E0
	for <lttng-dev@archiver.kernel.org>; Mon,  8 Feb 2021 14:59:06 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1B064E0B
	for <lttng-dev@archiver.kernel.org>; Mon,  8 Feb 2021 14:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1B064E0B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DZ8LJ1D0Xz18ny;
	Mon,  8 Feb 2021 09:59:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1612796344;
	bh=JMxaNX//M1NQ1OjI73AY9QnbDelLwAMhokz5RDz8zrk=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=eLLT7ZmvJCWhKYDVGyPLx5lqiSY5Mlz7J2EUDAcxv9oRkFjjUAM+XVE80/mjCtX/I
	 leTG3aGn2s2qp9HmhpoSU84DQ0qZ8xieMdxPUfX9+u6lvKQucaiD3wN1ZMp0QVYYG+
	 CMRnowN8qJxSjzzUox7EJ7sogi6gRsLo/Tr33jPhk9JjxUIKp18rEJBThO3V0uCHwX
	 PIDC61n3i22bwbSeEcnDYlX8HY2jvrrNmq+rK084R/Ni8MFtlAAgpLBZQkVxq67DRg
	 N9TZ+1kyeNIyRtHp0cWtrBg3EZRd9T36RxPsAZli/csSGItGqHkdhkDGOIAs2dTNwz
	 4PuVN8d1vj+eg==
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 by lists.lttng.org (Postfix) with ESMTPS id 4DZ8LF6rFJz18nt
 for <lttng-dev@lists.lttng.org>; Mon,  8 Feb 2021 09:59:01 -0500 (EST)
Received: by mail-yb1-xb2e.google.com with SMTP id r2so14817081ybk.11
 for <lttng-dev@lists.lttng.org>; Mon, 08 Feb 2021 06:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=F8snKO3FsKClyAiRGpcERZGBdpYZ+O6tqrmRAxm4SBo=;
 b=ICoFQgFU19hbzFe1mnS605DKz9NTvKICi72Af2XiDa8Jdp3a7KpzZy+QKgMYp10e/B
 Y+lZiQjG74Lmfil2UEuw6+uRUQVMdm9aEw6tbldI6UTvbaky/OeqmsOJZZyY1DGFyusw
 8QkJzvHl8Fvsn8f/TxDiDLJ/zZv4bfl4VMEMtkk2dhqQOktHzx6eJQBwLeF4ljJyi+kE
 StXWnAw2egEMmaqFC5LPl8boNCmq4DNuEJLEvGyFmo6VHbPJ7ZqJdn3jZ+/UnH+AHuZB
 r7lhPRQaorrs0B5rvDjFPRvJ7TSGH3WCZ16lpGh5I1HovuYh3XBx7yrTDY6XwA4ljD9v
 mI/Q==
X-Gm-Message-State: AOAM532OSieLvVEOUgDAfFvl7sA0kpg2Po3Wd1DJ2pZnZNM9tPSsNY1Z
 x4xriEAEz61Y3Jix8oZK5o/dvKd30b664a7BGkY=
X-Google-Smtp-Source: ABdhPJy1gwUud3p0mi5bKvFkFhPrSaJZJo71/kavtBlquQPVVBsmzNInnMFglNZ82wpzd4O6aa+htY6r6y+qD4F9R7I=
X-Received: by 2002:a5b:108:: with SMTP id 8mr26920565ybx.398.1612796341160;
 Mon, 08 Feb 2021 06:59:01 -0800 (PST)
MIME-Version: 1.0
References: <386C5D4D5C53C24CBC2C60CAAFD2136A5B4A9BAB@EXDAG0-B1.intra.cea.fr>
 <386C5D4D5C53C24CBC2C60CAAFD2136A5B4A9D26@EXDAG0-B1.intra.cea.fr>
In-Reply-To: <386C5D4D5C53C24CBC2C60CAAFD2136A5B4A9D26@EXDAG0-B1.intra.cea.fr>
Date: Mon, 8 Feb 2021 09:58:34 -0500
Message-ID: <CAB4xu_3eLXWugyeGDYBC-tKo3qGfCWWs7QFfaEyK0Lh3UiBnhg@mail.gmail.com>
To: RADERMACHER Ansgar <Ansgar.RADERMACHER@cea.fr>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] [barectf] no nested types?
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <eeppeliteloop@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Mon, Feb 8, 2021 at 5:27 AM RADERMACHER Ansgar via lttng-dev
<lttng-dev@lists.lttng.org> wrote:
>
> Dear all,
>
> having thought a bit more about it, I can see now that nested types are problematic in general: some types in the language need to be mapped to types that match but are not identical, i.e. have likely a different memory layout. This would be problematic for nested types.

Exactly: compound types represent a challenge in general because we
don't know the memory layout details of the user data, so we can't just
copy bytes as is to a CTF data stream.

There are strategies to achieve such a feature in barectf and in
LTTng-UST (similar problem), but implementing and testing them is not on
the roadmap currently.

This is why both barectf and LTTng-UST support basic arrays of
simple/scalar instances (numbers and strings), but not the rest, even if
CTF itself can represent more complex data.

barectf supports nested static arrays [1], but not nested dynamic
arrays.

Hope this helps,

Phil

[1]: https://barectf.org/docs/barectf/3.0/yaml/static-array-ft-obj.html

> Thus, I'm opting for flattening data (with the exception of lists).
>
> Best regards
>
> Ansgar
>
>
> ________________________________
> From: lttng-dev [lttng-dev-bounces@lists.lttng.org] on behalf of RADERMACHER Ansgar via lttng-dev [lttng-dev@lists.lttng.org]
> Sent: Friday, February 05, 2021 22:58
> To: lttng-dev@lists.lttng.org
> Subject: [lttng-dev] [barectf] no nested types?
>
> Hello,
>
> I've generated a config.yaml from type definitions in UML. If the type of a payload field is a UML DataType, the generator produces an associated type alias file with "class = structure" and the contained members.
>
> When I tried to compile the configuration file, I get an error message from barectf:
> `field-type` property: Nested structure field types are not supported
>
> It this really not supported or are there other mechanisms that enable the use of nested types? If not supported, it would be an important restriction which seems to be not prominently documented (in [1], there is a parenthesis "except a structure field type object" but it's easy to miss)
>
> Best regards
>
> Ansgar
>
>
> [1] https://barectf.org/docs/barectf/3.0/yaml/struct-ft-obj.html
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
