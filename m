Return-Path: <SRS0=Ki2T=JN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3478FC433ED
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 16:11:44 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4532B610FA
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 16:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4532B610FA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FMLn94cbSz1C5S;
	Fri, 16 Apr 2021 12:11:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618589502;
	bh=avXxbdBdaZen+YTFT3zWNceUS7v1+01eYNZlnzhrv1k=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PI26VDFvUmw141ohxM5QgJ3cD0r5b56GlCspP2MAvGRfNwuhgsPxv2hq1aYx8vI8k
	 VjZ/jUrlVajKNm2qt4I2xJv2gTLSN+q9Wiz44pWAlKOFDArNE9JFGeow0I8/8Np2ad
	 XnRt2w0iYFPzYThXSqtfSWK1Si0gdl+ijKjNugLjXZI0RfTvvYGYGv7Lygqlm6Sdt0
	 IkHa7V0odLfZVYXWseo09oqnsxFb5xwtQFxMIcwEVZAQBuIwUMD3MkgkGu+L5DK+CJ
	 MAWYxIskECT1owkKJndrL9Xp0/Gmchy4FIf1GAefLM0QED6zfYxTt89QKBkZO//7F3
	 q/eFIL9VrYWOw==
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by lists.lttng.org (Postfix) with ESMTPS id 4FMLn75LHKz1Brj
 for <lttng-dev@lists.lttng.org>; Fri, 16 Apr 2021 12:11:39 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9CE8610FA;
 Fri, 16 Apr 2021 16:01:39 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 8877E5C0253; Fri, 16 Apr 2021 09:01:39 -0700 (PDT)
Date: Fri, 16 Apr 2021 09:01:39 -0700
To: Peter Zijlstra <peterz@infradead.org>
Message-ID: <20210416160139.GF4212@paulmck-ThinkPad-P17-Gen-1>
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
 <YHmqd3BHwVmaUZHX@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YHmqd3BHwVmaUZHX@hirez.programming.kicks-ass.net>
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
Cc: Will Deacon <will@kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Fri, Apr 16, 2021 at 05:17:11PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 16, 2021 at 10:52:16AM -0400, Mathieu Desnoyers wrote:
> > Hi Paul, Will, Peter,
> > 
> > I noticed in this discussion https://lkml.org/lkml/2021/4/16/118 that LTO
> > is able to break rcu_dereference. This seems to be taken care of by
> > arch/arm64/include/asm/rwonce.h on arm64 in the Linux kernel tree.
> > 
> > In the liburcu user-space library, we have this comment near rcu_dereference() in
> > include/urcu/static/pointer.h:
> > 
> >  * The compiler memory barrier in CMM_LOAD_SHARED() ensures that value-speculative
> >  * optimizations (e.g. VSS: Value Speculation Scheduling) does not perform the
> >  * data read before the pointer read by speculating the value of the pointer.
> >  * Correct ordering is ensured because the pointer is read as a volatile access.
> >  * This acts as a global side-effect operation, which forbids reordering of
> >  * dependent memory operations. Note that such concern about dependency-breaking
> >  * optimizations will eventually be taken care of by the "memory_order_consume"
> >  * addition to forthcoming C++ standard.
> > 
> > (note: CMM_LOAD_SHARED() is the equivalent of READ_ONCE(), but was introduced in
> > liburcu as a public API before READ_ONCE() existed in the Linux kernel)
> > 
> > Peter tells me the "memory_order_consume" is not something which can be used today.
> > Any information on its status at C/C++ standard levels and implementation-wise ?

Actually, you really can use memory_order_consume.  All current
implementations will compile it as if it was memory_order_acquire.
This will work correctly, but may be slower than you would like on ARM,
PowerPC, and so on.

On things like x86, the penalty is forgone optimizations, so less
of a problem there.

> > Pragmatically speaking, what should we change in liburcu to ensure we don't generate
> > broken code when LTO is enabled ? I suspect there are a few options here:
> > 
> > 1) Fail to build if LTO is enabled,
> > 2) Generate slower code for rcu_dereference, either on all architectures or only
> >    on weakly-ordered architectures,
> > 3) Generate different code depending on whether LTO is enabled or not. AFAIU this would only
> >    work if every compile unit is aware that it will end up being optimized with LTO. Not sure
> >    how this could be done in the context of user-space.
> > 4) [ Insert better idea here. ]

Use memory_order_consume if LTO is enabled.  That will work now, and
might generate good code in some hoped-for future.

> > Thoughts ?
> 
> Using memory_order_acquire is safe; and is basically what Will did for
> ARM64.
> 
> The problematic tranformations are possible even without LTO, although
> less likely due to less visibility, but everybody agrees they're
> possible and allowed.
> 
> OTOH we do not have a positive sighting of it actually happening (I
> think), we're all just being cautious and not willing to debug the
> resulting wreckage if it does indeed happen.

And yes, you can also use memory_order_acquire.

							Thanx, Paul
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
