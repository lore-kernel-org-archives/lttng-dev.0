Return-Path: <SRS0=Ki2T=JN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AD0C433B4
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 19:02:56 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A371F613B0
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 19:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A371F613B0
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FMQZk0xrkz1Bvx;
	Fri, 16 Apr 2021 15:02:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618599774;
	bh=FoDp4AzdzRBKsHwbyZ1YnZZQ7QNmKYdPmcmzdldULbQ=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wimY0U/80CyJ507eakLYdLrsawAPOQUuvx53scvr9A2DsEODD0TR/AJ0vfFrJr+/y
	 bTV+n9yw+4IYVs/ZqOwYWkwemtxuYrbsHDFjfkWYJeSP1dlLKbQgzLMl2xHyPnQKL3
	 vtnM3ZAcQJy4/yPZBipPwRsdgwHNucP/dNAt/EOcY6qW8/rAdtEEXkcFB9GHj35Oxj
	 n5jMKLIeJtVG9WJDSak4uBKcHjvaFlIAH5DAjPQLuQW9pVWghF0b0akVGF+PIqFh7E
	 FHXzqLj6MVb8ROjwmf2dLHWgdaKH/ZH9FfF2BcrSQbn8NnmfZyPuGXIK8teevp+PcC
	 I3g3jF3zqkmzA==
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by lists.lttng.org (Postfix) with ESMTPS id 4FMQZh0wYnz1C46
 for <lttng-dev@lists.lttng.org>; Fri, 16 Apr 2021 15:02:51 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1069611AF;
 Fri, 16 Apr 2021 19:02:44 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 61AB15C0253; Fri, 16 Apr 2021 12:02:44 -0700 (PDT)
Date: Fri, 16 Apr 2021 12:02:44 -0700
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 lttng-dev <lttng-dev@lists.lttng.org>, carlos <carlos@redhat.com>
Message-ID: <20210416190244.GJ4212@paulmck-ThinkPad-P17-Gen-1>
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
 <YHmqd3BHwVmaUZHX@hirez.programming.kicks-ass.net>
 <20210416160139.GF4212@paulmck-ThinkPad-P17-Gen-1>
 <2089952450.84139.1618598408015.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2089952450.84139.1618598408015.JavaMail.zimbra@efficios.com>
Subject: Re: [lttng-dev] liburcu: LTO breaking rcu_dereference on arm64 and
 possibly other architectures ?
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
From: "Paul E. McKenney via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: paulmck@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Fri, Apr 16, 2021 at 02:40:08PM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 16, 2021, at 12:01 PM, paulmck paulmck@kernel.org wrote:
> 
> > On Fri, Apr 16, 2021 at 05:17:11PM +0200, Peter Zijlstra wrote:
> >> On Fri, Apr 16, 2021 at 10:52:16AM -0400, Mathieu Desnoyers wrote:
> >> > Hi Paul, Will, Peter,
> >> > 
> >> > I noticed in this discussion https://lkml.org/lkml/2021/4/16/118 that LTO
> >> > is able to break rcu_dereference. This seems to be taken care of by
> >> > arch/arm64/include/asm/rwonce.h on arm64 in the Linux kernel tree.
> >> > 
> >> > In the liburcu user-space library, we have this comment near rcu_dereference()
> >> > in
> >> > include/urcu/static/pointer.h:
> >> > 
> >> >  * The compiler memory barrier in CMM_LOAD_SHARED() ensures that
> >> >  value-speculative
> >> >  * optimizations (e.g. VSS: Value Speculation Scheduling) does not perform the
> >> >  * data read before the pointer read by speculating the value of the pointer.
> >> >  * Correct ordering is ensured because the pointer is read as a volatile access.
> >> >  * This acts as a global side-effect operation, which forbids reordering of
> >> >  * dependent memory operations. Note that such concern about dependency-breaking
> >> >  * optimizations will eventually be taken care of by the "memory_order_consume"
> >> >  * addition to forthcoming C++ standard.
> >> > 
> >> > (note: CMM_LOAD_SHARED() is the equivalent of READ_ONCE(), but was introduced in
> >> > liburcu as a public API before READ_ONCE() existed in the Linux kernel)
> >> > 
> >> > Peter tells me the "memory_order_consume" is not something which can be used
> >> > today.
> >> > Any information on its status at C/C++ standard levels and implementation-wise ?
> > 
> > Actually, you really can use memory_order_consume.  All current
> > implementations will compile it as if it was memory_order_acquire.
> > This will work correctly, but may be slower than you would like on ARM,
> > PowerPC, and so on.
> > 
> > On things like x86, the penalty is forgone optimizations, so less
> > of a problem there.
> 
> OK
> 
> > 
> >> > Pragmatically speaking, what should we change in liburcu to ensure we don't
> >> > generate
> >> > broken code when LTO is enabled ? I suspect there are a few options here:
> >> > 
> >> > 1) Fail to build if LTO is enabled,
> >> > 2) Generate slower code for rcu_dereference, either on all architectures or only
> >> >    on weakly-ordered architectures,
> >> > 3) Generate different code depending on whether LTO is enabled or not. AFAIU
> >> > this would only
> >> >    work if every compile unit is aware that it will end up being optimized with
> >> >    LTO. Not sure
> >> >    how this could be done in the context of user-space.
> >> > 4) [ Insert better idea here. ]
> > 
> > Use memory_order_consume if LTO is enabled.  That will work now, and
> > might generate good code in some hoped-for future.
> 
> In the context of a user-space library, how does one check whether LTO is enabled with
> preprocessor directives ? A quick test with gcc seems to show that both with and without
> -flto cannot be distinguished from a preprocessor POV, e.g. the output of both
> 
> gcc --std=c11 -O2 -dM -E - < /dev/null
> and
> gcc --std=c11 -O2 -flto -dM -E - < /dev/null
> 
> is exactly the same. Am I missing something here ?

No idea.  ;-)

> If we accept to use memory_order_consume all the time in both C and C++ code starting from
> C11 and C++11, the following code snippet could do the trick:
> 
> #define CMM_ACCESS_ONCE(x) (*(__volatile__  __typeof__(x) *)&(x))
> #define CMM_LOAD_SHARED(p) CMM_ACCESS_ONCE(p)
> 
> #if defined (__cplusplus)
> # if __cplusplus >= 201103L
> #  include <atomic>
> #  define rcu_dereference(x)    ((std::atomic<__typeof__(x)>)(x)).load(std::memory_order_consume)
> # else
> #  define rcu_dereference(x)    CMM_LOAD_SHARED(x)
> # endif
> #else
> # if (defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L)
> #  include <stdatomic.h>
> #  define rcu_dereference(x)    atomic_load_explicit(&(x), memory_order_consume)
> # else
> #  define rcu_dereference(x)    CMM_LOAD_SHARED(x)
> # endif
> #endif
> 
> This uses the volatile approach prior to C11/C++11, and moves to memory_order_consume
> afterwards. This will bring a performance penalty on weakly-ordered architectures even
> when -flto is not specified though.
> 
> Then the burden is pushed on the compiler people to eventually implement an efficient
> memory_order_consume.
> 
> Is that acceptable ?

That makes sense to me!

If it can be done reasonably, I suggest also having some way for the
person building userspace RCU to say "I know what I am doing, so do
it with volatile rather than memory_order_consume."

							Thanx, Paul
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
