Return-Path: <SRS0=KqGB=FT=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6685C4361B
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Dec 2020 16:39:55 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43E1223D6
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Dec 2020 16:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43E1223D6
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CwP9z2YTPzDpW;
	Tue, 15 Dec 2020 11:39:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1608050392;
	bh=plpw32cgSlSiDHxwzOqkw5k1ll0nt/zZMCzd+ZM5aEA=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cVIWii4dBHI2GqHs62b3oR5dYzzkZLHaHE2MdGmVmV6RzfrCD3LWyxWvUEiGMrvrw
	 jUV7rluFsRpDLiMZZ+qPQi7cKhWT6E/kEm26vRtPkKkNnJPUAoYV4+D76d+qabHWWa
	 O29heS20NOY52HI9CD/Na2nG4jk3/uWP5ap7LU1E6sykNi6U42wWChVk8YQEfdPDj0
	 9xj8cFLTaoAJa6Ex1WEvDr7qYKF1ZyygnvtVEyb2rpGX6lFuYjAOFjWIfPiLtrG/+Q
	 O/FYTFl3LJ5Jg6uq/QFKB/7KXUFFU92wpi7elHA1ArJeuiKRBZ1+pjGOCpu8gfvAyw
	 b7Iir3f6FqI8Q==
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by lists.lttng.org (Postfix) with ESMTPS id 4CwP9x3PsGzDhj
 for <lttng-dev@lists.lttng.org>; Tue, 15 Dec 2020 11:39:49 -0500 (EST)
Date: Tue, 15 Dec 2020 08:39:41 -0800
To: Michael Jeanson <mjeanson@efficios.com>
Message-ID: <20201215163941.GA2657@paulmck-ThinkPad-P72>
References: <20201215162850.78638-1-mjeanson@efficios.com>
 <20201215162850.78638-4-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201215162850.78638-4-mjeanson@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Subject: Re: [lttng-dev] [PATCH urcu 4/4] Don't force a target and
 optimization level on ARMv7
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
From: "Paul E. McKenney via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: paulmck@kernel.org
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Tue, Dec 15, 2020 at 11:28:50AM -0500, Michael Jeanson wrote:
> We shouldn't force a specific target cpu for the compiler on ARMv7 but
> let the system or the user choose it. If some of our code depends on a
> specific target CPU features, it should be compile tested.
> 
> Also remove the default optimisation level of O1, it's potentially a
> workaround to an early armv7 compiler performance problem and anyway
> most builds will have an optimisation level flag set in the CFLAGS which
> will override this one.

Indeed, the original was based on advice from ARM that has undoubtedly
changed over time, so...

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> Change-Id: I1d1bb5cc0fa0be8f8b1d6a9ad7bf063809be1aef
> ---
>  configure.ac | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index daa967a..f477425 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -119,10 +119,6 @@ AS_CASE([$host],[*-cygwin*],
>  	[AM_CONDITIONAL(USE_CYGWIN, false)]
>  )
>  
> -AS_IF([test "$host_cpu" = "armv7l"],[
> -	AM_CFLAGS="$AM_CFLAGS -mcpu=cortex-a9 -mtune=cortex-a9 -O1"
> -])
> -
>  # Search for clock_gettime
>  AC_SEARCH_LIBS([clock_gettime], [rt], [
>  	AC_DEFINE([CONFIG_RCU_HAVE_CLOCK_GETTIME], [1])
> -- 
> 2.29.2
> 
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
