Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D19C77B7F
	for <lttng-dev@archiver.kernel.org>; Tue, 16 May 2023 12:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684239792;
	bh=Fu3GtSx9Mi+OWbBBTDMdWBa7lWvI0LuFSwA/2NQ7XwY=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=vbyTupKvT/xAQYy0sBW0G2LhVWOnNioEL8ziz6O8+stXCbVM7eFkBdaMVuv3ejtFI
	 QEMu1K6+2JRFkJE+0sXO6lCP/LxPBakb7TM9+CW0UvQ5WFmr63UUGQhTQnkbDN0Z4I
	 S8hN6iBsDuU4rHCvEeriK5TmrOFhTGm9/1PNhSaNRP+RpItcFqDHuoPSlMWwyqU+0/
	 ZPIRqQDmkWJ67EkMFtQlSK8BMylzyDUP/dGF/kRaHuRGu84KRkfV2IffisXc/awfzs
	 +QlNFib32xQE3n1/PcnDQylfRP6PAaCrRI0H384VD7PmXO7eu1+U8GIHt244LFf3+x
	 xTkAlOsRGLHjg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QLFkl4HGXz1F83;
	Tue, 16 May 2023 08:23:11 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by lists.lttng.org (Postfix) with ESMTPS id 4QLFkj4MRdz1F7s
 for <lttng-dev@lists.lttng.org>; Tue, 16 May 2023 08:23:09 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7AD5563961;
 Tue, 16 May 2023 12:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9628C4339B;
 Tue, 16 May 2023 12:16:27 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 73CD0CE1432; Tue, 16 May 2023 05:16:27 -0700 (PDT)
Date: Tue, 16 May 2023 05:16:27 -0700
To: Olivier Dion <odion@efficios.com>
Message-ID: <67447df6-11a8-4315-8357-d1127c80798f@paulmck-laptop>
References: <87v8gzuc3g.fsf@laura>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87v8gzuc3g.fsf@laura>
Subject: Re: [lttng-dev] [RFC] Deprecating RCU signal flavor
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, May 10, 2023 at 05:10:27PM -0400, Olivier Dion wrote:
> Hi all,
> 
> We have the intention of deprecating the urcu-signal flavor in the
> future.  We are asking users of URCU for _feedback_ on this before
> going any further.
> 
> Part of this decision is that we are adding support for TSAN in URCU and
> the signal flavor deadlocks with TSAN.  It is also my understanding that
> the urcu-signal flavor was historically made as a fallback for system
> lacking the membarrier(2) system call.  Nowadays, most systems have
> support for that system call, making the urcu-signal an artifact of the
> past.

No objections here.  I will need to do a little rework of my book, but
I can do that.  ;-)

> The following is a proposed timeline of events:
> 
>   1. Asking for feedback from users of URCU (this message)
>   2. Disabling the signal flavor by default and adding --enable-flavor-signal
>   3. Removing the signal flavor

Makes sense to me!

							Thanx, Paul
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
