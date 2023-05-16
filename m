Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6167FC77B7A
	for <lttng-dev@archiver.kernel.org>; Tue, 16 May 2023 15:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684252109;
	bh=DG/sjLLVna4b5YRpfb3TDOSCBgOOWf0zkmJgk9J/V1Q=;
	h=To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QaO65O9xHE0/0hfqINEu8wC+Kk5P75BDVXv1J4mrrDhkwaAtJNJ6sS41mjeAgLvez
	 PRrgd2WzGqzAvho7eN0SLcc/K9epslG/QA890SpRE5XNMCXggPDQywfNjfskWuo3ri
	 mUsgEisxaULra8UBOk4PnmeIwk5RcogNqN1baODZtqYaJNEBH+ICDj/cZlhObD9Sgd
	 EQbpOYxM3oZDVgVUF+6Wli8vRI5LEPmcONB3T8Sh4qwdm1rEWeyMzCahKJY7+mFJy3
	 o1K2WHaiWZg5lagTcibHTZN8fEJCAVAdDLruPFR6Zhi31j+VO0CC8L1hvwpfaVa+2S
	 E/2BH+2f0SWZA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QLLHc2xJNz1FDr;
	Tue, 16 May 2023 11:48:28 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QLLHb3xG4z1FDp
 for <lttng-dev@lists.lttng.org>; Tue, 16 May 2023 11:48:27 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QLLH06M4Tz12fD;
 Tue, 16 May 2023 11:47:56 -0400 (EDT)
To: Dmitry Vyukov <dvyukov@google.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@kernel.org>
In-Reply-To: <CACT4Y+b-THcfzGiXxu8Wc79GwiMsQREPnykffj52+sDLcDqHvw@mail.gmail.com>
Organization: EfficiOS
References: <20230515201718.9809-1-odion@efficios.com>
 <CACT4Y+b-THcfzGiXxu8Wc79GwiMsQREPnykffj52+sDLcDqHvw@mail.gmail.com>
Date: Tue, 16 May 2023 11:47:56 -0400
Message-ID: <874jocl1lf.fsf@laura>
MIME-Version: 1.0
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Tue, 16 May 2023, Dmitry Vyukov via lttng-dev <lttng-dev@lists.lttng.org> wrote:
> On Mon, 15 May 2023 at 22:18, Olivier Dion <odion@efficios.com> wrote:

Hi Dmitry,

> Where can I see the actual changes? Preferably side-by-side diffs with
> full context. Are they (or can they be) uploaded somewhere on
> github/gerrit?

Here's the link to the first patch of the set on our Gerrit
<https://review.lttng.org/c/userspace-rcu/+/9737>.

> Are there any remaining open questions?

On the Gerrit no.  But I would add this for the known issues:

We have a regression test for forking.  We get the following when
running it:

==23432==ThreadSanitizer: starting new threads after multi-threaded fork is not supported. Dying (set die_after_fork=0 to override)

With TSAN_OPTIONS=die_after_fork=0, here are the results for GCC and
Clang.

* gcc 11.3.0
  ==25266==ThreadSanitizer: dup thread with used id 0x7fd40dafe600

  Looks like this was fixed with recent merged of TSAN in gcc 13.

* clang 14.0.6

Tests pass but are very slow.  This seems to be because we're calling
exit(3) in the childs.  Changing it to _exit(2) solves the issue.  The
only thing I can think of is that exit(3) is not async-signal-safe like
_exit(2), yet we do other none-async safe calls like malloc(3) and
free(3) in the childs.

Here are some perf records of that:

With exit(3)
```
  12.35%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ebd22b
   8.69%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ebd8fa
   7.50%  test_urcu_fork.  [unknown]                [k] 0xffffffff8a001360
   6.11%  test_urcu_fork.  test_urcu_fork.tap       [.] __sanitizer::internal_memset
   5.85%  test_urcu_fork.  test_urcu_fork.tap       [.] __tsan::ForkChildAfter
   1.96%  test_urcu_fork.  [unknown]                [k] 0xffffffff892f8efd
   1.88%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ec8e2c
   1.29%  test_urcu_fork.  [unknown]                [k] 0xffffffff890a99d1
   0.79%  test_urcu_fork.  [unknown]                [k] 0xffffffff8918c566
   0.75%  test_urcu_fork.  test_urcu_fork.tap       [.] __sanitizer::ThreadRegistry::OnFork
   0.71%  test_urcu_fork.  [unknown]                [k] 0xffffffff89349574
   0.64%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ee424f
   0.57%  test_urcu_fork.  test_urcu_fork.tap       [.] __tsan::MetaMap::AllocBlock
   0.55%  test_urcu_fork.  [unknown]                [k] 0xffffffff89367249
   0.53%  test_urcu_fork.  test_urcu_fork.tap       [.] __tsan_read8
   0.51%  test_urcu_fork.  [unknown]                [k] 0xffffffff89ec8e05
```

With _exit(2)
```
  12.26%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ebd8fa
   9.51%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ebd22b
   6.78%  test_urcu_fork.  test_urcu_fork.tap    [.] __sanitizer::internal_memset
   6.49%  test_urcu_fork.  [unknown]             [k] 0xffffffff8a001360
   4.92%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan::ForkChildAfter
   2.92%  test_urcu_fork.  [unknown]             [k] 0xffffffff892f8efd
   2.19%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ec8e2c
   1.88%  test_urcu_fork.  [unknown]             [k] 0xffffffff890a99d1
   0.83%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan::MetaMap::AllocBlock
   0.72%  test_urcu_fork.  [unknown]             [k] 0xffffffff892f8f1c
   0.67%  test_urcu_fork.  [unknown]             [k] 0xffffffff8918c566
   0.65%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ec16dd
   0.62%  test_urcu_fork.  test_urcu_fork.tap    [.] __sanitizer::CombinedAllocator<__sanitizer::SizeClassAllocator32<__sanitizer::AP32>, __sanitizer::LargeMmapAllocatorPtrArrayStatic>::Allocate
   0.61%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan_write4
   0.60%  test_urcu_fork.  [unknown]             [k] 0xffffffff89367249
   0.59%  test_urcu_fork.  [unknown]             [k] 0xffffffff89ee424f
   0.50%  test_urcu_fork.  test_urcu_fork.tap    [.] __sanitizer::ThreadRegistry::OnFork
   0.50%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan_write8
   0.47%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan::ForkBefore
   0.45%  test_urcu_fork.  test_urcu_fork.tap    [.] __tsan_func_entry
```

> Is there CI coverage with -fsanitize=thread?

Since the urcu-signal flavor deadlocks with TSAN (see reproducer in
commit log), the CI simply timeouts.  I do however have a job with TSAN
as an matrix axis here <https://ci.lttng.org/job/dev_odion_liburcu/>.


-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
