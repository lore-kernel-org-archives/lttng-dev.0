Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F842C25B08
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Aug 2022 17:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660585938;
	bh=Qsf0mTcXKyWNRJ0q8AfRS8M9ha3kn7RNLQ3iFuqD63g=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=vFCtq6rusZUYh1i3eQ0qAsVIIL67uz4YPxGjiSY8LzAXoeOdjEQ7PTK2nT/uooXHh
	 qmXMDrMvgA+FV0njWSDGmnSk5oDugMoK1BVs2r28gM+oX9Sm3xhyWItx4+RKrLgoQ7
	 Iv9EBey779u9YMT8L3It85Jthpo4MsrJi19+oJPJVfcuXoLWaMAT+HeHWWwAmmxjnG
	 jyLaWgHxZIITnwCL9W9OUh2UF4icLv77WtPvceUCTm+ZvNBZowGfBIWonHlwqIa/5p
	 X794hrAewradkRT1Oexm5Bl8Bx/7wCmWN2rtORMfqDIM+mO2lhSMEC+IlpXqZi9Bog
	 ScvBZC+nEk6/w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M620x6q8qz1GYg;
	Mon, 15 Aug 2022 13:52:17 -0400 (EDT)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by lists.lttng.org (Postfix) with ESMTPS id 4M620w3Zdbz1GHF
 for <lttng-dev@lists.lttng.org>; Mon, 15 Aug 2022 13:52:16 -0400 (EDT)
Received: by mail-ej1-x632.google.com with SMTP id y13so14706682ejp.13
 for <lttng-dev@lists.lttng.org>; Mon, 15 Aug 2022 10:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=eJE4+GLqyam8W+3ce5RoW9NkwzvTYwCFg9Lc7UK4Iaw=;
 b=rTVSuRzBSTL/mEWHtWg9f+4d6r1IzgvQk+qZtYpsbJy8aXYOpw4gm/+dBuFgJwgw0q
 NiWBkY1jmlEm8qqXfWo57zSH4DZpgYaAnQPmAaP88+IZWtP8fhlIscR1P7KGFaE5Hq/I
 ZggampA1EhEKxOzawGTEckia7Pzzg/DEIqp93chX8IiUL7waJUjk/H1kffk0IAfVwi7C
 gYkYjnPBDJgmuSyI8GbCT4glzru+4mFyerhaEz/OVfr+ca+Cw8Z1SSJoo9Th+CtFfFo6
 JKO85uTP/e/W3U1AuQmSgNmml+rtNUuRWVubBT2QaA+mNG9rm/BBJimYQRBmxEMNZIT0
 5KPw==
X-Gm-Message-State: ACgBeo2ace2DHfwAdtezEkKoZ+9rQsjKWqIKtmlbRk16TdSK3pNGnH4K
 s6e+pkoJNk+ZfkiYcEbmCU686dFm+94AreVohYaucecvFds=
X-Google-Smtp-Source: AA6agR5vFfkxErEwWFrfEizl7+Bt7SQ1AxgwNi/OApU+ZiubJbg6KM3cG86+NR02Vue9G5WUfPhvTYaZid0AQ8dKy+o=
X-Received: by 2002:a17:907:7290:b0:731:3c0a:97f8 with SMTP id
 dt16-20020a170907729000b007313c0a97f8mr11112517ejc.127.1660585935418; Mon, 15
 Aug 2022 10:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAJbg=FUXDnq0cSLCzhOAO4W44+monQF4s73t_sT4dAPGWt8fPg@mail.gmail.com>
 <dd0df1d0-12ed-a568-839e-7d2ff1fbcff7@efficios.com>
 <CAJbg=FWjjBT1RbGxvCcx1+6qgJfhqtF3h3WpLB11cGSb1Efzqw@mail.gmail.com>
 <7e3f4047-101e-d8d4-93ed-370c8eaf7494@efficios.com>
 <CAJbg=FVMKPrZ+s2UdMN57R_rwDMF6ZH7BkpfMZ-Waf_AQXh9Dw@mail.gmail.com>
 <a5f31003-9cc9-33e3-5c23-e4360fe7edbf@efficios.com>
In-Reply-To: <a5f31003-9cc9-33e3-5c23-e4360fe7edbf@efficios.com>
Date: Mon, 15 Aug 2022 13:52:03 -0400
Message-ID: <CAJbg=FUVVfNkDM4xvmMtVtw+GCs2nXmbCT02BXoA+3Jd1Nc2cQ@mail.gmail.com>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Change to CPU number detection breaks QNX
 compilation
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
From: Elad Lahav via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Elad Lahav <e2lahav@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

/bin/sh on QNX is (by default) ksh, not bash, so perhaps that's the issue.

Shouldn't block you from submitting that change. +1 from me, if that matters ;-)

--Elad

On Mon, 15 Aug 2022 at 13:39, Michael Jeanson <mjeanson@efficios.com> wrote:
>
> On 2022-08-15 12 h 56, Elad Lahav wrote:
> > That fixes the build, thanks.
> >
> > I see some errors coming out of "make check", though:
> >
> > ERROR: test_get_cpu_mask_from_sysfs - missing test plan
> > ERROR: test_get_cpu_mask_from_sysfs - exited with status 1
> >
> > --Elad
>
> I tested on Freebsd (as a non-linux target) and I get the expected :
>
> SKIP: test_get_cpu_mask_from_sysfs - Skip Linux specific tests.
>
> I wonder what might differ here, it might have to do with the version of
> bash on QNX, I'm not familiar with this platform.
>
> Michael
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
