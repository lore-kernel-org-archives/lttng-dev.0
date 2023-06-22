Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE767EB64DA
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Jun 2023 20:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687464717;
	bh=4WPEGB3ostWh9mEy7iCjLzQ827DZ4xJorMyixeF962E=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Hr54BzzMA8OaAYHHFS0adzL7iWiFsvC0ytJO9QMCU9aFNhnC0FJPpz8vbhvlJWS48
	 PmRpOiNe/w9z8Vi7TUj3lY/0B0BPmmIjuj5azxym6OQDnj5TwBB1VwnmC416WpF9hq
	 Qno5ArpkSDub+llereciVdD4l316ku28nlo/qDrd6qI50QBCvLTGvjq5XXu/Uo3pRo
	 aTuPkLgpYvuWJAr2nO5UcVHeOUoPyjJJb//u0t/VecQOnnkLSmKC9bKs6D6ERHYMwy
	 O63IrEn/YL54YdNWCTrmKnTZSvGkrKpYOZDHljfVDPzgAH/daJlEjGEsA99tpMq4Q6
	 tp74JLXvAK4ag==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QnBNY4QZpz20DP;
	Thu, 22 Jun 2023 16:11:57 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by lists.lttng.org (Postfix) with ESMTPS id 4QnBNW6WpWz20DM
 for <lttng-dev@lists.lttng.org>; Thu, 22 Jun 2023 16:11:55 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A6B2B618D1;
 Thu, 22 Jun 2023 20:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CD6C433C0;
 Thu, 22 Jun 2023 20:11:53 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id A2783CE39F6; Thu, 22 Jun 2023 13:11:52 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:11:52 -0700
To: Olivier Dion <odion@efficios.com>
Message-ID: <8152f4fb-7a3b-458e-a63c-414bc99ac0d4@paulmck-laptop>
References: <20230515201718.9809-1-odion@efficios.com>
 <20230515201718.9809-3-odion@efficios.com>
 <c7834f41-c033-4c53-96e8-0ad728c2a285@paulmck-laptop>
 <ffec193e-7060-3fe2-6526-c54e89e992e6@efficios.com>
 <105bad2a-9fed-4353-a434-a571ce9da7ac@paulmck-laptop>
 <87zg4rl1du.fsf@laura>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87zg4rl1du.fsf@laura>
Subject: Re: [lttng-dev] [PATCH 02/11] urcu/uatomic: Use atomic builtins if
 configured
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
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Thu, Jun 22, 2023 at 03:53:33PM -0400, Olivier Dion wrote:
> On Thu, 22 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > I suggest C11 volatile atomic load/store.  Load/store fusing is permitted
> > for non-volatile atomic loads and stores, and such fusing can ruin your
> > code's entire day.  ;-)
> 
> Good catch.  Seems like not a problem on GCC (yet), but Clang is extremely
> aggressive and seems to do store fusing on some corner cases [0].
> 
> However, I do not find any simple reproducer of load/store fusing.  Do
> you have example of such fusing, or is this a precaution?  In the
> meantime, back to reading the standard to be certain :-)
> 
>  [0] https://godbolt.org/z/odKG9a75a

I certainly have heard a number of compiler writers thinking in terms
of doing load/store fusing, some of whom were trying to get rid of the
volatile variants in order to remove an impediment to their mission of
optimizing all programs out of existence.  ;-)

I therefore suggest taking this possibility quite seriously.

							Thanx, Paul
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
