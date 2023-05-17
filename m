Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1515CC77B7F
	for <lttng-dev@archiver.kernel.org>; Wed, 17 May 2023 10:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684321132;
	bh=LisBb8hYsJ52jpbyTjTtC7AmXR0I73KQCXw1VqDFLQk=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Bbb+sj8YS03/AwkhIoqUkmyk+ZqoMuBBqH1S49uDNDW1Rl6SwDgoYAza9d2t7bfbf
	 8A/5CCz4MKqsSB97nw4kKCMBSnTjeZnMkfv7A1zrs57/h08ODff+Kpe3J9D96e82Pu
	 0FCXaxaFOLYdBtiB+R3dxGmda9qOXgQzxDgZrbIfTvoQzfVSgmzt71rvpr1WX++2VS
	 RsteFs6Vz/QiR58PDL04+bkaXb9OUkt9mcSERtH41B/ntoa1m6OHRrgslkNEgVR2v4
	 BFxxKbGhCv83hxZcrhcDu3zn6WpaUuJAdXifljTDzgnjl+NT2oXq+DR+xyUE61gRi6
	 RoDtkWruIJ6hw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QLqq0008dz1FfS;
	Wed, 17 May 2023 06:58:51 -0400 (EDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by lists.lttng.org (Postfix) with ESMTPS id 4QLqpy5gZzz1FBm
 for <lttng-dev@lists.lttng.org>; Wed, 17 May 2023 06:58:50 -0400 (EDT)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-4f37884956bso1863e87.1
 for <lttng-dev@lists.lttng.org>; Wed, 17 May 2023 03:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684321069; x=1686913069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LonzCdh/+4xez/wbF4bBEzV/UW+JYn6T/HO1UrzIEIc=;
 b=fxdA1vM0atDcPD8PrA9iH39HmgwwYYc9DVCer+4xWi9z22zPFEBUttdf0Dd7JKTfSY
 bEc5RYvJ4ByCpRsAWb/86cNioPOKJ9Kj3MnnrdJDV9+tv+U1sPAUNs5c0KkmBknuwzGt
 oNOvgUWIlcO4YnGd813lt3kYnlk+QywMMDR75komcz6WfGLodA20AuMzteHFHWG3zLyk
 deBlJNSDDAKlsRXEMXbrSJAiCbEvKTzHbC+mqQD97auSfFKULvwy/YeVSAPDScw8GijO
 1dx8Z3pMkQr15ue7nLYjYc38oZUDj69/8YAWXgb3BER/K2AB2Ku4AOE3LDwm4E+cJffk
 d3HA==
X-Gm-Message-State: AC+VfDyBoPQrsZftetDrjtXvJecYhSbH4I2WByeyePayDsf3Z7RCw6ta
 WZmeyT7RcIt8lsd3X0GV/+mdKIABHdSeBnQ56Kv2kuC7vSiYj60C4YR+Sg==
X-Google-Smtp-Source: ACHHUZ7g2DW6t1WeMVXd5P1cMw954IqHquuNOj0RPjB+lo0qyuLGWgeBto0+br1JYqVCobR7gX3l5Ys0hIN/RR7gXns=
X-Received: by 2002:a05:6512:5d9:b0:4f2:5caa:693d with SMTP id
 o25-20020a05651205d900b004f25caa693dmr110287lfo.1.1684321069093; Wed, 17 May
 2023 03:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230515201718.9809-1-odion@efficios.com>
 <CACT4Y+b-THcfzGiXxu8Wc79GwiMsQREPnykffj52+sDLcDqHvw@mail.gmail.com>
 <874jocl1lf.fsf@laura>
 <CACT4Y+YFNRKTgA=s8+ntiwEsRVq9WAR2pBF3toyiGe08mUQ4Gg@mail.gmail.com>
In-Reply-To: <CACT4Y+YFNRKTgA=s8+ntiwEsRVq9WAR2pBF3toyiGe08mUQ4Gg@mail.gmail.com>
Date: Wed, 17 May 2023 12:57:36 +0200
Message-ID: <CACT4Y+Z8c30QQ3KFTaMq1Zgm-5fFCXEpNN3Kc9KWC+xzRkTzRQ@mail.gmail.com>
To: Olivier Dion <odion@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

I've skimmed through the changes. They look sane. You know what you
are doing. So unless you have any other open issues, I don't have much
to add.

On Wed, 17 May 2023 at 12:21, Dmitry Vyukov <dvyukov@google.com> wrote:
> > Hi Dmitry,
> >
> > > Where can I see the actual changes? Preferably side-by-side diffs with
> > > full context. Are they (or can they be) uploaded somewhere on
> > > github/gerrit?
> >
> > Here's the link to the first patch of the set on our Gerrit
> > <https://review.lttng.org/c/userspace-rcu/+/9737>.
> >
> > > Are there any remaining open questions?
> >
> > On the Gerrit no.  But I would add this for the known issues:
> >
> > We have a regression test for forking.  We get the following when
> > running it:
> >
> > ==23432==ThreadSanitizer: starting new threads after multi-threaded fork is not supported. Dying (set die_after_fork=0 to override)
>
> > With TSAN_OPTIONS=die_after_fork=0, here are the results for GCC and
> > Clang.
> >
> > * gcc 11.3.0
> >   ==25266==ThreadSanitizer: dup thread with used id 0x7fd40dafe600
> >
> >   Looks like this was fixed with recent merged of TSAN in gcc 13.
> >
> > * clang 14.0.6
>
> Hi Olivier,
>
> Forking under tsan is a bit tricky. But I see we now take a number of
> internal mutexes around  fork (but I think still not all of them), so
> maybe it's not that bad. If  TSAN_OPTIONS=die_after_fork=0 works
> reasonably reliably for you, then export it for testing.
>
> Older compilers are missing a number of bug fixes.
> So if you can restrict testing to newer compilers only, that's the way to go.
>
>
> > Tests pass but are very slow.  This seems to be because we're calling
> > exit(3) in the childs.  Changing it to _exit(2) solves the issue.  The
> > only thing I can think of is that exit(3) is not async-signal-safe like
> > _exit(2), yet we do other none-async safe calls like malloc(3) and
> > free(3) in the childs.
>
> By default tsan sleeps for 1 second at exit, since exit sequence is a
> common source of races. Perhaps it's just these sleeps. Try
> TSAN_OPTIONS=atexit_sleep_ms=0 (or maybe =50).
>
>
> > Here are some perf records of that:
> >
> > With exit(3)
> > ```
> >   12.35%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ebd22b
> >    8.69%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ebd8fa
> >    7.50%  test_urcu_fork.  [unknown]                [k] 0xffffffff8a001360
> >    6.11%  test_urcu_fork.  test_urcu_fork.tap       [.] __sanitizer::internal_memset
> >    5.85%  test_urcu_fork.  test_urcu_fork.tap       [.] __tsan::ForkChildAfter
> >    1.96%  test_urcu_fork.  [unknown]                [k] 0xffffffff892f8efd
> >    1.88%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ec8e2c
> >    1.29%  test_urcu_fork.  [unknown]                [k] 0xffffffff890a99d1
> >    0.79%  test_urcu_fork.  [unknown]                [k] 0xffffffff8918c566
> >    0.75%  test_urcu_fork.  test_urcu_fork.tap       [.] __sanitizer::ThreadRegistry::OnFork
> >    0.71%  test_urcu_fork.  [unknown]                [k] 0xffffffff89349574
> >    0.64%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ee424f
> >    0.57%  test_urcu_fork.  test_urcu_fork.tap       [.] __tsan::MetaMap::AllocBlock
> >    0.55%  test_urcu_fork.  [unknown]                [k] 0xffffffff89367249
> >    0.53%  test_urcu_fork.  test_urcu_fork.tap       [.] __tsan_read8
> >    0.51%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ec8e05
> > ```
> >
> > With _exit(2)
> > ```
> >   12.26%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ebd8fa
> >    9.51%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ebd22b
> >    6.78%  test_urcu_fork.  test_urcu_fork.tap    [.] __sanitizer::internal_memset
> >    6.49%  test_urcu_fork.  [unknown]             [k] 0xffffffff8a001360
> >    4.92%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan::ForkChildAfter
> >    2.92%  test_urcu_fork.  [unknown]             [k] 0xffffffff892f8efd
> >    2.19%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ec8e2c
> >    1.88%  test_urcu_fork.  [unknown]             [k] 0xffffffff890a99d1
> >    0.83%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan::MetaMap::AllocBlock
> >    0.72%  test_urcu_fork.  [unknown]             [k] 0xffffffff892f8f1c
> >    0.67%  test_urcu_fork.  [unknown]             [k] 0xffffffff8918c566
> >    0.65%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ec16dd
> >    0.62%  test_urcu_fork.  test_urcu_fork.tap    [.] __sanitizer::CombinedAllocator<__sanitizer::SizeClassAllocator32<__sanitizer::AP32>, __sanitizer::LargeMmapAllocatorPtrArrayStatic>::Allocate
> >    0.61%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan_write4
> >    0.60%  test_urcu_fork.  [unknown]             [k] 0xffffffff89367249
> >    0.59%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ee424f
> >    0.50%  test_urcu_fork.  test_urcu_fork.tap    [.] __sanitizer::ThreadRegistry::OnFork
> >    0.50%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan_write8
> >    0.47%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan::ForkBefore
> >    0.45%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan_func_entry
> > ```
> >
> > > Is there CI coverage with -fsanitize=thread?
> >
> > Since the urcu-signal flavor deadlocks with TSAN (see reproducer in
> > commit log), the CI simply timeouts.  I do however have a job with TSAN
> > as an matrix axis here <https://ci.lttng.org/job/dev_odion_liburcu/>.
>
> Sounds good.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
