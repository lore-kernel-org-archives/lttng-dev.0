Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951A1C00140
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Aug 2022 16:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660582600;
	bh=mpfp+IgKUHLdc1VyrKcnl2firoMftgB0mBZGGLlDqKc=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=TaBKzMsfJw/EZiWWf7qQV9CHB7zRDEThcGct3tjpBvOTbkqPHktx0eHMeoRJXBphF
	 PUYl138AvP1If3AzGsrF4OHKZFIK1Hde5s4VHR7XiKPEB1VeqBWfHiDjahCldqMP0P
	 Y+izV9ufKHrcD1ZmEhX6WX4eyJUwXjTYIcaHMvKsmpWvTn2ENjDBDFLoX/8x3dceXG
	 WwqFZlBIetPhB/sNetAT1afn2fT374BdlAaH8H/NVc9twy3irR1bd28vAGcn1TukvE
	 VOg4L7+F6q5nOKGGPSLLYnHtF6PzX30mJI7tUxRJf2JckFxlMIwcqzyjjFopj7+jDT
	 0DM6RqFICgDNw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M60ml4Ksqz1Ghx;
	Mon, 15 Aug 2022 12:56:39 -0400 (EDT)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by lists.lttng.org (Postfix) with ESMTPS id 4M60mk1ccXz1Ghw
 for <lttng-dev@lists.lttng.org>; Mon, 15 Aug 2022 12:56:29 -0400 (EDT)
Received: by mail-ej1-x630.google.com with SMTP id a7so14550743ejp.2
 for <lttng-dev@lists.lttng.org>; Mon, 15 Aug 2022 09:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=gbeaFqZ8O5rSILboJxbhLeYfqlJJwiGC2Knd4rUxMIc=;
 b=dh7FgLZH8yx2NZdq+BcIHOj+g5gWeWNIxWwDe7pSQUJ8m/f4FU2bfsrRrjO7GW8uZV
 em06mqVGBrc30sEBUZwc1tCLAyv67wBdZCld2gv5qc/G/+Veu79ZSbq9wUYdlgJu6Yoo
 Spl7eYQ/ikHBjuqmCbfImamXBg+B7c5f/txNipNM5QcaKF6bjqFEQlaRlLwqFjP9Uo2p
 BWM9YSsAL1vGlBrWgg4hCV2emT50OYIrMqYqkEbZtQNKerIyXefZFCaHrmMjha7DGSn7
 +fEO/e73ZOBmgDtUjO37XQ+P7TkT8bmQJnzug7ao/VvYIeh5JGc/r9toO8wyfGtRsjgg
 xRNg==
X-Gm-Message-State: ACgBeo0UV64squTmt30uICuHyRE7S3IurJtaPd8eDNEaS3OkBXrh+S6U
 lyyATec1Tl6OBzGLTgekvsp52V46Mkc4zH3PUDWWrxmndPO5Ug==
X-Google-Smtp-Source: AA6agR4FSaY0aQzllK1/N/GQ9KBBbLb7gYpSWnFGccwk2a5jgjXbs0IyUEk2PT8tkX+DgMNLO5JdCBsTPSxlPnfWhHM=
X-Received: by 2002:a17:906:93ef:b0:731:1478:b774 with SMTP id
 yl15-20020a17090693ef00b007311478b774mr10418192ejb.531.1660582587992; Mon, 15
 Aug 2022 09:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJbg=FUXDnq0cSLCzhOAO4W44+monQF4s73t_sT4dAPGWt8fPg@mail.gmail.com>
 <dd0df1d0-12ed-a568-839e-7d2ff1fbcff7@efficios.com>
 <CAJbg=FWjjBT1RbGxvCcx1+6qgJfhqtF3h3WpLB11cGSb1Efzqw@mail.gmail.com>
 <7e3f4047-101e-d8d4-93ed-370c8eaf7494@efficios.com>
In-Reply-To: <7e3f4047-101e-d8d4-93ed-370c8eaf7494@efficios.com>
Date: Mon, 15 Aug 2022 12:56:16 -0400
Message-ID: <CAJbg=FVMKPrZ+s2UdMN57R_rwDMF6ZH7BkpfMZ-Waf_AQXh9Dw@mail.gmail.com>
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

That fixes the build, thanks.

I see some errors coming out of "make check", though:

ERROR: test_get_cpu_mask_from_sysfs - missing test plan
ERROR: test_get_cpu_mask_from_sysfs - exited with status 1

--Elad

On Mon, 15 Aug 2022 at 11:55, Michael Jeanson <mjeanson@efficios.com> wrote:
>
> On 2022-08-15 10 h 04, Elad Lahav wrote:
> > The problem is the use of d_type as a member of the dirent structure.
> > POSIX does not define such a member.
> > I can provide the necessary code for getting the file type in a
> > readdir() loop on QNX, but it seems unnecessary given that there is no
> > /sys file system with CPU information. The method for getting
> > information on processors is different, and I suspect that is true for
> > *BSDs and other non-Linux OSs.
> >
> > --Elad
>
> Can you try this patch [1] to see if it fixes the build on QNX? Can you
> also run 'make check' in 'tests/unit', the linux specific tests should
> be skipped.
>
> Michael
>
> [1] https://review.lttng.org/c/userspace-rcu/+/8664
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
