Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74402C77B7F
	for <lttng-dev@archiver.kernel.org>; Wed, 17 May 2023 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684318970;
	bh=bU8RvXjB7+zyNPxH9WMkTtY+XKCB7zKIW4xjuxkTW4s=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=BRfe29habJ74tliKl/DDIEQuK8VHDTAwXzjuz09gteAAint32GrBrhRjCizY84vC6
	 Lv4A0V68o899UPNjuYHe+iRJfQ4awvj1TudjybPKttVNSbWtCYj2NLiOQQgkq8Wl7D
	 lr9RYLGrK+bD5TfQ02RxkRMKSvpALN8VJtkgP9IiIaqpV1DFciCb63dFe09EjwBkPt
	 5jlRHQ/eVrBzjtlN656zZhKLUK3AIbRiegns87gB0LBJobXqbi1AoK8rnMk87Z9wTy
	 IoUJrP4N4znicqlw9YK2lDteOpN2QI4BdleWC96UF71Q+QHFEgZ5+8Su5cEQcKYwKc
	 sItavxvZIsDqg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QLq1P4Jlfz1FLh;
	Wed, 17 May 2023 06:22:49 -0400 (EDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by lists.lttng.org (Postfix) with ESMTPS id 4QLq1N25PQz1FQw
 for <lttng-dev@lists.lttng.org>; Wed, 17 May 2023 06:22:48 -0400 (EDT)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-4f1217f16e9so2432e87.0
 for <lttng-dev@lists.lttng.org>; Wed, 17 May 2023 03:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684318907; x=1686910907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ERwHSICN6+YgaIfB490QKPyx52ITkXNqq8HdUhu5goI=;
 b=NQYPh7/7Zq5IdwwZgSWnGoaKdjSPcHDtBi4gd6/ZRgoeRa09erJAqvP86CYehfFxaF
 li9SePBfIUQcFSnsJEYWA9KD48dr1HwRXc8BxPyUHSH/86njpmhPaOd0KiNzmv4OXW0s
 vYX2pp06XwynWk33bj/U3jEqs0RSwGJbhWfcKKne/7lfFmBcMPlAL2saEnwvficFooN5
 9Ffy0bpnbWeJQikB/NTF2x9HGuJLnXaLwHj0rgDkvoZ10oQE6apoyleaxBkSKMAxmQJj
 MomnwhwTJnUauNURMdWbz20tUiw7iMKedqitGHBtsNXBPYtNquZATw/jo1ETMvHLYkhk
 D+RQ==
X-Gm-Message-State: AC+VfDyAFxIQd1yxksYj7E7diCq8OnMFoVuiAVULkwEAORYbYCiCe0dQ
 p3Iq5S6cqi8k88KvPhMx5himpKYyazlZ2S55VqKT1w==
X-Google-Smtp-Source: ACHHUZ65/egxI7WsZgduuWwwDc8tcGGU6i+hyEjJE+BUg4qaHA6bPYcFKS+iOkXmhN3gTx6vZHHXdZDphLVggdi70GQ=
X-Received: by 2002:a05:6512:361a:b0:4ef:ef61:90c7 with SMTP id
 f26-20020a056512361a00b004efef6190c7mr154890lfs.2.1684318906521; Wed, 17 May
 2023 03:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230515201718.9809-1-odion@efficios.com>
 <CACT4Y+b-THcfzGiXxu8Wc79GwiMsQREPnykffj52+sDLcDqHvw@mail.gmail.com>
 <874jocl1lf.fsf@laura>
In-Reply-To: <874jocl1lf.fsf@laura>
Date: Wed, 17 May 2023 12:21:33 +0200
Message-ID: <CACT4Y+YFNRKTgA=s8+ntiwEsRVq9WAR2pBF3toyiGe08mUQ4Gg@mail.gmail.com>
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

On Tue, 16 May 2023 at 17:47, Olivier Dion <odion@efficios.com> wrote:
>
> On Tue, 16 May 2023, Dmitry Vyukov via lttng-dev <lttng-dev@lists.lttng.org> wrote:
> > On Mon, 15 May 2023 at 22:18, Olivier Dion <odion@efficios.com> wrote:
>
> Hi Dmitry,
>
> > Where can I see the actual changes? Preferably side-by-side diffs with
> > full context. Are they (or can they be) uploaded somewhere on
> > github/gerrit?
>
> Here's the link to the first patch of the set on our Gerrit
> <https://review.lttng.org/c/userspace-rcu/+/9737>.
>
> > Are there any remaining open questions?
>
> On the Gerrit no.  But I would add this for the known issues:
>
> We have a regression test for forking.  We get the following when
> running it:
>
> ==23432==ThreadSanitizer: starting new threads after multi-threaded fork is not supported. Dying (set die_after_fork=0 to override)

> With TSAN_OPTIONS=die_after_fork=0, here are the results for GCC and
> Clang.
>
> * gcc 11.3.0
>   ==25266==ThreadSanitizer: dup thread with used id 0x7fd40dafe600
>
>   Looks like this was fixed with recent merged of TSAN in gcc 13.
>
> * clang 14.0.6

Hi Olivier,

Forking under tsan is a bit tricky. But I see we now take a number of
internal mutexes around  fork (but I think still not all of them), so
maybe it's not that bad. If  TSAN_OPTIONS=die_after_fork=0 works
reasonably reliably for you, then export it for testing.

Older compilers are missing a number of bug fixes.
So if you can restrict testing to newer compilers only, that's the way to go.


> Tests pass but are very slow.  This seems to be because we're calling
> exit(3) in the childs.  Changing it to _exit(2) solves the issue.  The
> only thing I can think of is that exit(3) is not async-signal-safe like
> _exit(2), yet we do other none-async safe calls like malloc(3) and
> free(3) in the childs.

By default tsan sleeps for 1 second at exit, since exit sequence is a
common source of races. Perhaps it's just these sleeps. Try
TSAN_OPTIONS=atexit_sleep_ms=0 (or maybe =50).


> Here are some perf records of that:
>
> With exit(3)
> ```
>   12.35%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ebd22b
>    8.69%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ebd8fa
>    7.50%  test_urcu_fork.  [unknown]                [k] 0xffffffff8a001360
>    6.11%  test_urcu_fork.  test_urcu_fork.tap       [.] __sanitizer::internal_memset
>    5.85%  test_urcu_fork.  test_urcu_fork.tap       [.] __tsan::ForkChildAfter
>    1.96%  test_urcu_fork.  [unknown]                [k] 0xffffffff892f8efd
>    1.88%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ec8e2c
>    1.29%  test_urcu_fork.  [unknown]                [k] 0xffffffff890a99d1
>    0.79%  test_urcu_fork.  [unknown]                [k] 0xffffffff8918c566
>    0.75%  test_urcu_fork.  test_urcu_fork.tap       [.] __sanitizer::ThreadRegistry::OnFork
>    0.71%  test_urcu_fork.  [unknown]                [k] 0xffffffff89349574
>    0.64%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ee424f
>    0.57%  test_urcu_fork.  test_urcu_fork.tap       [.] __tsan::MetaMap::AllocBlock
>    0.55%  test_urcu_fork.  [unknown]                [k] 0xffffffff89367249
>    0.53%  test_urcu_fork.  test_urcu_fork.tap       [.] __tsan_read8
>    0.51%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ec8e05
> ```
>
> With _exit(2)
> ```
>   12.26%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ebd8fa
>    9.51%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ebd22b
>    6.78%  test_urcu_fork.  test_urcu_fork.tap    [.] __sanitizer::internal_memset
>    6.49%  test_urcu_fork.  [unknown]             [k] 0xffffffff8a001360
>    4.92%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan::ForkChildAfter
>    2.92%  test_urcu_fork.  [unknown]             [k] 0xffffffff892f8efd
>    2.19%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ec8e2c
>    1.88%  test_urcu_fork.  [unknown]             [k] 0xffffffff890a99d1
>    0.83%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan::MetaMap::AllocBlock
>    0.72%  test_urcu_fork.  [unknown]             [k] 0xffffffff892f8f1c
>    0.67%  test_urcu_fork.  [unknown]             [k] 0xffffffff8918c566
>    0.65%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ec16dd
>    0.62%  test_urcu_fork.  test_urcu_fork.tap    [.] __sanitizer::CombinedAllocator<__sanitizer::SizeClassAllocator32<__sanitizer::AP32>, __sanitizer::LargeMmapAllocatorPtrArrayStatic>::Allocate
>    0.61%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan_write4
>    0.60%  test_urcu_fork.  [unknown]             [k] 0xffffffff89367249
>    0.59%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ee424f
>    0.50%  test_urcu_fork.  test_urcu_fork.tap    [.] __sanitizer::ThreadRegistry::OnFork
>    0.50%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan_write8
>    0.47%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan::ForkBefore
>    0.45%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan_func_entry
> ```
>
> > Is there CI coverage with -fsanitize=thread?
>
> Since the urcu-signal flavor deadlocks with TSAN (see reproducer in
> commit log), the CI simply timeouts.  I do however have a job with TSAN
> as an matrix axis here <https://ci.lttng.org/job/dev_odion_liburcu/>.

Sounds good.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
