Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472F6EB64D9
	for <lttng-dev@archiver.kernel.org>; Thu, 29 Jun 2023 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688064018;
	bh=aL8nykeo7/tvu8hUMkrJYYJZk6tXKDhETbf/q+zcaio=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=oi5lU438HT+rFqMYVqIGalHmVR7igMm/SMyijO8ImmxEZtt4rleCHEw+afda4a54w
	 veEqiPJPAnp9PyE2hLB1R5HncqZiu3qQENTGiLjldCBju2l+sxa24m4GbMqDp86vgd
	 qbthdv4G3AMgm5CY0NL+QirJFTAl28WnArp9DlYEx8bYHsb1EY8psCEdBYHgF9EcQV
	 viXoRC3tqzVJvxZjIQZXWm2gUSLGpmvbjDN2hl0W+3ZDdA58guEHM7fpLeJq+NcpE2
	 Pk8LXZ2rm4oUtrjM7lL2fyLUFPG0IidfbM4jVwz9+JNWQ1tABoL3OWq3Ir6Zn/xO6C
	 K/Bl1NV2OaCgQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QsS1Z21M1z22Lf;
	Thu, 29 Jun 2023 14:40:18 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by lists.lttng.org (Postfix) with ESMTPS id 4QsS1X5VfFz22Gx
 for <lttng-dev@lists.lttng.org>; Thu, 29 Jun 2023 14:40:16 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 826E0615C5;
 Thu, 29 Jun 2023 18:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E653FC433C0;
 Thu, 29 Jun 2023 18:40:08 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 8457ACE04CF; Thu, 29 Jun 2023 11:40:08 -0700 (PDT)
Date: Thu, 29 Jun 2023 11:40:08 -0700
To: Olivier Dion <odion@efficios.com>
Message-ID: <5a440c51-43d3-4be6-ba5a-215c9d3e960f@paulmck-laptop>
References: <20230515201718.9809-1-odion@efficios.com>
 <20230607185359.8125-6-odion@efficios.com>
 <b669606b-74bf-4a07-8094-babbd829d9e8@paulmck-laptop>
 <87bkgyjjsz.fsf@laura>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bkgyjjsz.fsf@laura>
Subject: Re: [lttng-dev] [PATCH v2 05/12] urcu/uatomic: Add CMM memory model
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
Cc: Tony Finch <dot@dotat.at>, lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Thu, Jun 29, 2023 at 12:49:00PM -0400, Olivier Dion wrote:
> On Wed, 21 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > On Wed, Jun 07, 2023 at 02:53:52PM -0400, Olivier Dion wrote:
> >> -#ifdef __URCU_DEREFERENCE_USE_ATOMIC_CONSUME
> >> -# define _rcu_dereference(p) __extension__ ({						\
> >> -				__typeof__(__extension__ ({				\
> >> -					__typeof__(p) __attribute__((unused)) _________p0 = { 0 }; \
> >> -					_________p0;					\
> >> -				})) _________p1;					\
> >> -				__atomic_load(&(p), &_________p1, __ATOMIC_CONSUME);	\
> >
> > There is talk of getting rid of memory_order_consume.  But for the moment,
> > it is what there is.  Another alternative is to use a volatile load,
> > similar to old-style CMM_LOAD_SHARED() or in-kernel READ_ONCE().
> 
> I think we can stick to __ATOMIC_CONSUME for now.  Hopefully getting rid
> of it means it will be an alias for __ATOMIC_ACQUIRE for ever.

That seems emininently reasonable to me!

							Thanx, Paul
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
