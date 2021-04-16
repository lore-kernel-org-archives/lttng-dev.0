Return-Path: <SRS0=Ki2T=JN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8D1C433B4
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 20:01:56 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6356124B
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 20:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6356124B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FMRtp4xSkz1BbB;
	Fri, 16 Apr 2021 16:01:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618603315;
	bh=EoIRDe6Dmv0VhOTn6/kRWVUyhBH0qJZ/j901RrnbyTE=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=O2R7YFZUJe0FHusZs2mrjD27p3LPcbiN3sjAlrukIRvQX+8rtG6ARI2pTrDJS6J55
	 wFuWF40k+FNSqNtwDm0XKUUYyHJU/AtIS3EVVkXd4mGbFxCpmrzejtD0aqHK8mnBne
	 E0W8dtCzjEkOVe8YahlAxDVL9t5GXVHMxSaw5eaRhYSpDz8m/+mj9D9LRGkzRl7TnE
	 5SibcSeCE341peF/1CcWxTqJkZwIjy3mpA8MgLdgjOejbj9RiJnLSiMunACWDK6QV5
	 QMWr+59FmzmOimtkLm/il6dCAlAS3YtQqvKn9PLmRiiYrInp3hVqddOpA8imYY3Y6X
	 OM8Wa7vFrAGPQ==
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by lists.lttng.org (Postfix) with ESMTPS id 4FMRtm63nrz1C1d
 for <lttng-dev@lists.lttng.org>; Fri, 16 Apr 2021 16:01:52 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56B8F613C0;
 Fri, 16 Apr 2021 20:01:46 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 0E3645C0253; Fri, 16 Apr 2021 13:01:46 -0700 (PDT)
Date: Fri, 16 Apr 2021 13:01:46 -0700
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 lttng-dev <lttng-dev@lists.lttng.org>, Carlos O'Donell <carlos@redhat.com>
Message-ID: <20210416200146.GK4212@paulmck-ThinkPad-P17-Gen-1>
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
 <YHmqd3BHwVmaUZHX@hirez.programming.kicks-ass.net>
 <20210416160139.GF4212@paulmck-ThinkPad-P17-Gen-1>
 <2089952450.84139.1618598408015.JavaMail.zimbra@efficios.com>
 <20210416190244.GJ4212@paulmck-ThinkPad-P17-Gen-1>
 <2056094038.84390.1618601453585.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2056094038.84390.1618601453585.JavaMail.zimbra@efficios.com>
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

On Fri, Apr 16, 2021 at 03:30:53PM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 16, 2021, at 3:02 PM, paulmck paulmck@kernel.org wrote:
> [...]
> > 
> > If it can be done reasonably, I suggest also having some way for the
> > person building userspace RCU to say "I know what I am doing, so do
> > it with volatile rather than memory_order_consume."
> 
> Like so ?
> 
> #define CMM_ACCESS_ONCE(x) (*(__volatile__  __typeof__(x) *)&(x))
> #define CMM_LOAD_SHARED(p) CMM_ACCESS_ONCE(p)
> 
> /*
>  * By defining URCU_DEREFERENCE_USE_VOLATILE, the user requires use of
>  * volatile access to implement rcu_dereference rather than
>  * memory_order_consume load from the C11/C++11 standards.
>  *
>  * This may improve performance on weakly-ordered architectures where
>  * the compiler implements memory_order_consume as a
>  * memory_order_acquire, which is stricter than required by the
>  * standard.
>  *
>  * Note that using volatile accesses for rcu_dereference may cause
>  * LTO to generate incorrectly ordered code starting from C11/C++11.
>  */
> 
> #ifdef URCU_DEREFERENCE_USE_VOLATILE
> # define rcu_dereference(x)     CMM_LOAD_SHARED(x)
> #else
> # if defined (__cplusplus)
> #  if __cplusplus >= 201103L
> #   include <atomic>
> #   define rcu_dereference(x)   ((std::atomic<__typeof__(x)>)(x)).load(std::memory_order_consume)
> #  else
> #   define rcu_dereference(x)   CMM_LOAD_SHARED(x)
> #  endif
> # else
> #  if (defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L)
> #   include <stdatomic.h>
> #   define rcu_dereference(x)   atomic_load_explicit(&(x), memory_order_consume)
> #  else
> #   define rcu_dereference(x)   CMM_LOAD_SHARED(x)
> #  endif
> # endif
> #endif

Looks good to me!

							Thanx, Paul
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
