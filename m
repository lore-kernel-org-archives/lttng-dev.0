Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194A5C77B73
	for <lttng-dev@archiver.kernel.org>; Wed, 24 May 2023 08:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684916109;
	bh=B/NVeDQpy+ocj983K17EdhO2PZxULh1TaGMH+hFfC4U=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Uukwuy1AJx0tgqY5tDRiDJtY2emgzifS1r3JZqPALB9KhgomDuUTh647EgZILt1Th
	 s93NW4aHCJ2wqQsjjPNSog9LyV59HKogJhiq6/Nl71UnE7NLKnF9/foeMm4Gr2gMcK
	 vGqYat3HaA6EOdS6LcTMYVbKXGKfBcOauqgtxfrRcZds8wIJmu7LYdYyOnCeCGHnST
	 x1HF8o2fdiLUAu4Wnx3f2aXWJEpJ2K0ia6ty3R0ptJKJWMu+bF/xYLRwkISn3O0k9K
	 6RQUGHBJnenvrbZNu+aFk+RlLmV0ftKRcL19/H1cT+ldaYEZgR1BhlaF5996SPd7oq
	 1UIW00Wh6jkGA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QR3rs04YXz1HXZ;
	Wed, 24 May 2023 04:15:08 -0400 (EDT)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by lists.lttng.org (Postfix) with ESMTPS id 4QR3rp6N0lz1HPZ
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2023 04:15:06 -0400 (EDT)
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f14865fcc0so1146e87.0
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2023 01:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684916105; x=1687508105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cDBuuvCVPotqfG3IRbIc5/pr9WBHLxSpdlqlGMXV/4w=;
 b=d0jA0QL0+2uTtvNdkAuvff7Qzn4lUbdsGhMY5dU1gATernKxgLs/kMMAxrVZ5zYIx8
 9NOcCWuw/QO7gPFClEjyF+OZVP38mvkYBkoQ66DCTOYLsc//75Q3Ed+ZkKbIFKUwnN5C
 cnDLvG0K5tdOc/jcBrBDJsmnBSbTsK38NuEIt624xtVHRNON0SuRz7dNW19EZzuetkZP
 CoxXLAPerK/HUQyjKCw3m3R2G7yXtopehQrVN2C83r7aZmM0qC0zpgMKP48czaRTmCps
 kHFdRMuFhgJi1UwI0PvUXelCumvUCWzlCvx39ftLN+AcKOr4UprlNFjo5QOtmEQa1TH6
 X6kg==
X-Gm-Message-State: AC+VfDzKbIHks0Ggssc1c+ToTZ5tQGDIbQ6winZNHQUkdnf3O0htNw7N
 mPG8Gr8XPxPPF3ww42f5PmwrfomE7WZ759G8xEMlLg==
X-Google-Smtp-Source: ACHHUZ4ctLjvJAR1EZMBsiLWghxJPGJDCA/MGDn/xXrdpTEhsZnn5yt5S1L2zClcgbiDEok6pXo7X7pvVQHbSfZLRVY=
X-Received: by 2002:ac2:5f1c:0:b0:4f3:a7c6:590e with SMTP id
 28-20020ac25f1c000000b004f3a7c6590emr51852lfq.7.1684916105003; Wed, 24 May
 2023 01:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230515201718.9809-1-odion@efficios.com>
 <CACT4Y+b-THcfzGiXxu8Wc79GwiMsQREPnykffj52+sDLcDqHvw@mail.gmail.com>
 <874jocl1lf.fsf@laura>
 <CACT4Y+YFNRKTgA=s8+ntiwEsRVq9WAR2pBF3toyiGe08mUQ4Gg@mail.gmail.com>
 <CACT4Y+Z8c30QQ3KFTaMq1Zgm-5fFCXEpNN3Kc9KWC+xzRkTzRQ@mail.gmail.com>
 <87ttwbj9uz.fsf@laura> <87v8gj11ak.fsf@laura>
In-Reply-To: <87v8gj11ak.fsf@laura>
Date: Wed, 24 May 2023 10:14:51 +0200
Message-ID: <CACT4Y+a22N7gvcePvBazN_=AyeigVaeH-nFX-ZqZbq49mftMPg@mail.gmail.com>
To: Olivier Dion <odion@efficios.com>, tsan-users <tsan-users@google.com>
Subject: Re: [lttng-dev] [PATCH 00/11] Add support for TSAN to liburcu
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
From: Dmitry Vyukov via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Tue, 23 May 2023 at 18:05, Olivier Dion <odion@efficios.com> wrote:
>
> Hi Dmitry,
>
> We do have a new issue and we think it might be a limitation from TSAN.
>
> Find attached a test program that we believe is correct.  You can
> compile it with `gcc -fsanitize=thread test.c -pthread'.
>
>
> TSAN flags a race condition between the atomic store relaxed at line 36
> and the free at line 81.
>
> We can solve the issue by replacing the atomic store relaxed with a
> atomic store release.  However, the preceding atomic exchange with
> sequential consistency already acts as an implicit release (in term of
> memory barrier) for the following store, making the release semantic
> redundant.
>
> We've found an alternative to fix this by ignoring the thread during the
> relaxed store (line 39).  However, what we would like is to annotate the
> memory stored (line 45).
>
> My theory (I don't know the internal of TSAN much) is that TSAN thinks
> for some reason that the atomic store relaxed happen at the same epoch
> as the free, resulting in a false positive.  If so, m


I don't this this is true in the C/C++ memory model:
"the preceding atomic exchange with sequential consistency already
acts as an implicit release (in term of memory barrier) for the
following store".

std::atomic_thread_fence does affect all preceding/subsequent
operations, but an atomic memory operation only affects ordering on
that variable, it doesn't also serve as a standalone memory fence.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
