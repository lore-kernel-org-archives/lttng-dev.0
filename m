Return-Path: <SRS0=HU/H=BY=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72964C433DF
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Aug 2020 13:11:38 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8E9207DA
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Aug 2020 13:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="TKokOY6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8E9207DA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BSkNT12Qrz1vjm;
	Fri, 14 Aug 2020 09:11:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1597410697;
	bh=QxRYgc7gSXfQnyX1lQhZkYhgFvfQot/WcJsvde8mHIc=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=TKokOY6v8AEqpx0JK5XVD1F5GFgN5q5VcEGtlVuCW3QdR3Fums3SdjEDxE2IsJtAU
	 HpLHXmDYD6+5NB/yQQnSk5q+0uvXz/trtlQ7aNqDCddpyOWzFaN/8+R3Nskw30QJCB
	 Cvb+VRjNc2P3cpz0VH/ZTebo0Qqord6LaPJF6yxlhu6F8EcDZ92aDKAJE26Qj3p7yP
	 9eySEcYuzDGgGjQPTM6ysd23bOTjWnz+vSa1hT6vrJ8RTm5YktFg9Ngrd2UjlrjeWD
	 M2OY9v4V4Z381olCnWci0qWSts/3ghsClAH1YgUCFVGL0ydDKbFAtNz605V6MOnm9I
	 Zu2fNKxItZRSA==
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by lists.lttng.org (Postfix) with ESMTPS id 4BSkNR40xhz1vp8
 for <lttng-dev@lists.lttng.org>; Fri, 14 Aug 2020 09:11:35 -0400 (EDT)
Received: by mail-ej1-x62b.google.com with SMTP id o18so9867774eje.7
 for <lttng-dev@lists.lttng.org>; Fri, 14 Aug 2020 06:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eMuOY4U98bVLliPzuffjvBnrATWfcL2N+nViK5tf+5s=;
 b=M83538V4N+E760yqfn0w//OcOBPYVgfHqAaStGJ2a0/wxkjGDnjBcfqjw7IQQTrSVy
 kmR6BJoyLASTUwabicj8cXqjqjVtDaQbCqiBaaylAyQeSdCwkF3Ol0YFG5ejANfzBAFa
 ywuVcHId4ISvBuOj/DvrZ8cIcHssuFnOhQCZxqLnogHmaAd9coZSH4qpfrfveaV2J1D1
 CL+vW5u1Ua9OLdw9r0leDNWI6+jNnaGsZgq4jqspPjfXJfaKzk51JF1DUOAUputxYA2S
 Bf1w0JwKCRNPAomJIUF+1Ma8SVveYs7A92w5RVzWj1u0duv9DXgGKfFVKvD/CqrCCgNi
 84yw==
X-Gm-Message-State: AOAM5306BXGg226C6EbN+7viUD5aMxyZ5zF3zu6WkJKe+AVcs35Z2BwW
 ej7QotJjQmVhP7PfyAOyjggYCYVe/YbdgpgQsPmWrExIVZeYBA==
X-Google-Smtp-Source: ABdhPJx9XhTBDcLvtA00EEGfHeMQpz7nlV+dgzjqV5kQpKuB36GuoJFn+VJ3TdhyEuaQ1r97B7w6BEmH/3pLV0t55vM=
X-Received: by 2002:a17:906:1ccd:: with SMTP id
 i13mr2378120ejh.424.1597410694379; 
 Fri, 14 Aug 2020 06:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <CACV+naq0k9Szvs_vPyB98uMh5v=CNYbuEZ7nq9dDJoPR=LL5Cw@mail.gmail.com>
In-Reply-To: <CACV+naq0k9Szvs_vPyB98uMh5v=CNYbuEZ7nq9dDJoPR=LL5Cw@mail.gmail.com>
Date: Fri, 14 Aug 2020 09:10:58 -0400
Message-ID: <CAAS9doYOfuN6j+biqfj-rT6x_oBR0UaaT-mWOiCVi53vsnwDfw@mail.gmail.com>
To: Jin Huang <andy.jinhuang@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] How to report a bug?
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
From: =?utf-8?q?Christophe_B=C3=A9dard_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?Q?Christophe_B=C3=A9dard?= <bedard.christophe@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

You have to register for an account first (top right corner):
https://bugs.lttng.org/account/register

Once your account is created and you've logged in, you can open a new
issue by clicking on "new issue" (or using this link:
https://bugs.lttng.org/projects/urcu/issues/new)


Christophe

On Thu, 13 Aug 2020 at 18:39, Jin Huang via lttng-dev
<lttng-dev@lists.lttng.org> wrote:
>
> Hi, My name is Jin Huang.
> I find 2 data races in the Master branch of userspace-rcu.
>
> But I do not figure out how to report a bug here,  https://bugs.lttng.org/projects/urcu .
> I do not know how to add a new bug description.
> Could you help me?
>
> Thank You
> Best
> Jin Huang
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
