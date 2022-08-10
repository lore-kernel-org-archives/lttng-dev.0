Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CEBC25B07
	for <lttng-dev@archiver.kernel.org>; Wed, 10 Aug 2022 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660153732;
	bh=8WqIV2CDiNHuG5XiEG5twaSJ2Jqn05ZjFQaUlxEd77I=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=uiFFQ0irAl8DiN2J4rZa8hxcWJwUCET1t+Dd9WYT1k0Dc8JOQSFYKWzOQYWHZDzmA
	 CCAyrbdvu5iGivtygUF/o992huwxhRoJm+lXt0o3kWYJF9ysJJRtaW4UfBOyXLtcwC
	 Bk/5Fprej+merf1N+sWvSyzSYWfLknIsuppsKgRX27CF9oVlWMVNYRutFA86sgWU/I
	 XGMUD+qX7AnNnVCUZLXAjtk4jKvB1bfu2Xcg9lbdxVywjE6BNkvN4qcghEKODg8J4G
	 jb+AHziJ5K+vei6/hDj1wj2h7A+6DVIu+sBM0MNNta19SYiKOjOBbMabWleCdu2ZdX
	 JZhh/dEeN4TyA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M2y9J15d5z1DDm;
	Wed, 10 Aug 2022 13:48:52 -0400 (EDT)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by lists.lttng.org (Postfix) with ESMTPS id 4M2y9G6J4Wz1D7h
 for <lttng-dev@lists.lttng.org>; Wed, 10 Aug 2022 13:48:50 -0400 (EDT)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-10ee900cce0so18659103fac.5
 for <lttng-dev@lists.lttng.org>; Wed, 10 Aug 2022 10:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=gF4hj8qjZBXZqo54TdgRWQjl852d+9VsUtR9trhQ6rM=;
 b=llE66T66Jrf7grVaWqUPysD1h0KlSbIHBhhM6okaB0Z1tXfMhirGTDWVRqBPqrZum3
 Qd2AZGq/CYL38wt7ayjbIZSPsFVuMjc+QKDyN1DgfXfFAyL31SU6zPdRtZL5af3Zl1IN
 gIEkSQ5Sz5vKghWF5dsq3YpuZj2WBrG81Ez+syn9ebpJATxp/pm9+NuwemMp/+fL+iXo
 rDMdtGo4N4ab7wuZyu1mTQm1B+z1T9MHgaJkrPE5ih1yus4OR2vDMvEIv/ABMA93ywCH
 rTfKk+khqY/6od3KoR/96XIalItrEB7nVjpbAWTkzqh3g1kT8uV3GU9riylZzMrVtppz
 k1Ag==
X-Gm-Message-State: ACgBeo1wzbtNTHiDWEIPtfX+3+IpsF3LTcKzWqomRwfWQeh+yXBaD5lK
 w8XlKQKhOY1+xuxrNsKVg2TD9lfjMIyKtLkuMkE=
X-Google-Smtp-Source: AA6agR6Bq2UYrQTZHlU6jXG2gl+u5bwn2+Th/y3UFxPhWtNkMd9IGrZfNsvHCSfQi5mP59dZ/thqWRFPm8Z4sJPWGhw=
X-Received: by 2002:a05:6870:d29d:b0:10e:747b:f87b with SMTP id
 d29-20020a056870d29d00b0010e747bf87bmr1962569oae.6.1660153729800; Wed, 10 Aug
 2022 10:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220803192327.3726094-1-bruce.ashfield@gmail.com>
 <65c3cadc-9053-ba31-67b3-30bb9294642d@efficios.com>
In-Reply-To: <65c3cadc-9053-ba31-67b3-30bb9294642d@efficios.com>
Date: Wed, 10 Aug 2022 13:48:38 -0400
Message-ID: <CADkTA4NkNEE=kmsiBeJ_UQ7bOZ07CtAEumy8Qfs5cvG=AA1X5Q@mail.gmail.com>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] [PATCH] compaction: make tracepoints condtional on
 CONFIG_COMPACTION
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
From: Bruce Ashfield via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Bruce Ashfield <bruce.ashfield@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, Aug 10, 2022 at 11:20 AM Michael Jeanson <mjeanson@efficios.com> wrote:
>
> On 2022-08-03 15 h 23, Bruce Ashfield via lttng-dev wrote:
> > Hi all,
> >
> > This was found during the update of the yocto project reference
> > kernel to 5.19. Out of all the supported architectures, only
> > mips failed during the build of lttng-modules.
> >
> > Specifically, it seems like the lack of CONFIG_COMPACTION being
> > enabled in the kernel was the significant issue. Only one of the
> > tracepoints blew up, but I can't see how any of them would be
> > valid in this scenario, or why it would be limited to mips.
> >
> > While I don't think this is the right fix, this is what got me
> > up and passing sanity testing, so I wanted to send the change
> > and see what the actual, correct fix would be :)
> >
> > Cheers,
> >
> > Bruce
>
> Hi Bruce,
>
> Thanks for reporting this issue, I propose a simpler fix [1] of just
> disabling the build of the compaction probe module when
> CONFIG_COMPACTION is disabled in the kernel configuration.
>
> Can you confirm this patch fixes the issue on your side?

confirmed, it fixes the issue on my side.

Bruce

>
> Thanks,
>
> Michael
>
> [1] https://review.lttng.org/c/lttng-modules/+/8660



-- 
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
