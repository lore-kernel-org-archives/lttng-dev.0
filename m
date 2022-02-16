Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB96C433EF
	for <lttng-dev@archiver.kernel.org>; Wed, 16 Feb 2022 21:22:37 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JzWBh3c5vzLh;
	Wed, 16 Feb 2022 16:22:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1645046557;
	bh=JRQkR7+6II6mqLDw3QukhCLBAZLznXjlo1jDBEEfNpw=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=TadCCpMoae6upcAMx1v8/rtE+oGwQWTfLiNJpfHid6DwfjQiCKTVMeGPuALsUS/pA
	 3GjHliYSNl/7qZno1aOKT9exK4fBjb++UdByHyK3b2K8QIU+82NPGyCXhO80dCDS42
	 +bE3nHdUOMYmGFEAkK37Oh8aDIkD4OHRmEunqr2CM9yLJPU3HKRzSxZh9I8iu4VEam
	 MI71ByjsZTWvU42STmxxMsjPlyVtMx3VToGCacBwt12b+FtFklEcYkGItyByqf8tSr
	 MfXcu43lIa5yqoYHgLUIsX53uTqx0lfG+3/xSuBdyhbQyANoNH0cHB70CT3IOQTldl
	 HXdJbP+qn+OIA==
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by lists.lttng.org (Postfix) with ESMTPS id 4JzWBg31kTzSH
 for <lttng-dev@lists.lttng.org>; Wed, 16 Feb 2022 16:22:35 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B6CBFB81ECF;
 Wed, 16 Feb 2022 21:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EF4C004E1;
 Wed, 16 Feb 2022 21:12:41 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 2A1215C064D; Wed, 16 Feb 2022 13:12:41 -0800 (PST)
Date: Wed, 16 Feb 2022 13:12:41 -0800
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: yaowenbin <yaowenbin1@huawei.com>,
 lttng-dev <lttng-dev@lists.lttng.org>, wuxu wu <wuxu.wu@huawei.com>,
 h00486469 <hewenliang4@huawei.com>
Message-ID: <20220216211241.GO4285@paulmck-ThinkPad-P17-Gen-1>
References: <bb4a9de6-3adb-bec0-1bf1-22dd25a8d5c0@huawei.com>
 <2033818248.4933.1645044800494.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2033818248.4933.1645044800494.JavaMail.zimbra@efficios.com>
Subject: Re: [lttng-dev] [PATCH] QSBR: Use xor operation to replace add
 operation when changing rcu_gp.ctr value
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
From: "Paul E. McKenney via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: paulmck@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, Feb 16, 2022 at 03:53:20PM -0500, Mathieu Desnoyers wrote:
> ----- On Feb 16, 2022, at 2:35 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
> 
> > It is enough to have three values of rcu_gp.ctr, 00 for INACTIVE,
> > 01 or 11 for ACTIVE. So it is possible to replace add operation
> > with xor operation when changing rcu_gp.ctr value.
> 
> What is missing here is a description justifying why this change is useful.
> 
> What is inherently better about XOR compared to ADD or even binary-OR ?
> 
> If it's about performance, then a benchmark on relevant architectures
> would be useful. But I suspect that if end users care that much about the
> performance of urcu_qsbr_synchronize_rcu(), they might be doing something
> wrong.

Plus having the full counter can be extremely helpful when debugging.

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > 
> > Signed-off-by: yaowenbin <yaowenbin1@huawei.com>
> > ---
> > src/urcu-qsbr.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/src/urcu-qsbr.c b/src/urcu-qsbr.c
> > index 3709412..46135f9 100644
> > --- a/src/urcu-qsbr.c
> > +++ b/src/urcu-qsbr.c
> > @@ -391,7 +391,7 @@ void urcu_qsbr_synchronize_rcu(void)
> > 		goto out;
> > 
> > 	/* Increment current G.P. */
> > -	CMM_STORE_SHARED(urcu_qsbr_gp.ctr, urcu_qsbr_gp.ctr + URCU_QSBR_GP_CTR);
> > +	CMM_STORE_SHARED(urcu_qsbr_gp.ctr, urcu_qsbr_gp.ctr ^ URCU_QSBR_GP_CTR);
> > 
> > 	/*
> > 	 * Must commit urcu_qsbr_gp.ctr update to memory before waiting for
> > --
> > 2.27.0
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
