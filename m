Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E2CCA1005
	for <lttng-dev@archiver.kernel.org>; Tue,  2 Sep 2025 20:43:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGd3j4hsMz1Bv5
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1756845779;
	b=X4Qmh0ydDlpK5I/CEZoHkkx1UM80NwgKww8kdUo1880N9rMGkoJAnUWb+zzIwyy3YjnX
	 kzbUu3bR7PQz6vm1CSOtUbd/ZXtr8za7wgLj9AWnqWASfU0Srxrn7e1RITuF1RwNLLBDD
	 Gzm6DqNDsSuLAjiLb3Z2Yih1YDzKzN0MXos6Txz9bK9IuVshu4WiCSxR1pp6Y0ivh88eo
	 6k2FHoKBS+ZclfLU+UJhTNtXeK2Tuilmkh8GdpdTd35hjtfRmjBLxlWzbXMxFiJIu8hql
	 UCrqEtpaEvw4W1lFLpvQC8gppDiQYjeZvixRza1luAEyqwrjM6O7ytDaDa8rZQUAd5g==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1756845779;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=RN7qWmGsDd0NNhr32oFdWr0DHQIJ+zmsTxdS0ijCSSc=;
	b=kqyuVFcg1YymdR4QIIq2XSd96YazuInNfCJ7yqHogakhXRi2CED+3m5pBVaN9G2Mccm9
	 ptIAuLh6IWRPp4CmkyZ2prZrVc6WMFa9UpVpqSCQ6uM8X9Ccpb9dfX1lJpx9lATQF/AEo
	 hChtRouzLx5lQCw3FsfVNUIgTWeZf69by7ShZrYmzRa6CZIZb0tliIQcigUtEWiss56rO
	 iWGSmB2HhgbZtmwLsB8N0PfCrOx8l+vcFQN4CInYzQ8syzoyX8yHXx01CNNo6FrHEzXQ4
	 hik7111GmqFvDOqRsRHLueR2LlxGqQUmTzmEYzTp124aTyQUOPeuo2xFLcYN728CzYQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGd3j4hsMz1Bv5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1756845779;
	bh=RN7qWmGsDd0NNhr32oFdWr0DHQIJ+zmsTxdS0ijCSSc=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=pjakLuES84yfEEzRCBdZbtlx31hyufn7kcF1rkaqSnDPKP8yHedw6lUARLIJoHWy/
	 NL15e3ZYw9+OZMU7eRFr8iUVfiKCji/2S0u/n50bzPneLubyd7krQq2cgwSjH5csjG
	 MJCkw5RBv5HGY616/2argTblFuW4v64RYwUMmkTz1pNomnWGqkuknGbC/4oaJLy4tE
	 /HBbn1Xh+2seHTNq2X3EPmlaKIhZVggkqLLIOQvEFhD/V3gXzkHJM3NWdwtp2ZBJNc
	 gFjK1Kuw5tXQUB54aGkGBJim5toCT7apfOc2FbZA2ayRBsstq+df/8xid1z7HuslHS
	 o2vXPMfY4T4xg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cGd3j4hsMz1Bv5;
	Tue,  2 Sep 2025 16:42:57 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGd3h0wMrz1Bls
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGd3h0wMrz1Bls
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by lists.lttng.org (Postfix) with ESMTPS id 4cGd3h0wMrz1Bls
 for <lttng-dev@lists.lttng.org>; Tue,  2 Sep 2025 16:42:55 -0400 (EDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BC36360097;
 Tue,  2 Sep 2025 20:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70916C4CEED;
 Tue,  2 Sep 2025 20:33:28 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 1CA7BCE0C15; Tue,  2 Sep 2025 13:33:28 -0700 (PDT)
Date: Tue, 2 Sep 2025 13:33:28 -0700
To: Thobias Knudsen <thobknu@gmail.com>
Subject: Re: URCU feature request?
Message-ID: <2f0dc1b4-3fcb-453c-aa42-4a1f85623300@paulmck-laptop>
References: <CAKGpciq6Cb6+hqsfn+_zPk+MqCg+b0M_Gc3jVxVvnEGcE8rdLw@mail.gmail.com>
 <CAKGpciqHpGqGJChLa8p4P4Xv7EyUPMxULHxeknOTyie8kHH6hg@mail.gmail.com>
 <3c49eadb-f310-46b2-984d-58a0c193cde9@efficios.com>
 <CAKGpcipt=fWJi9Y497C3vq03CXmPY6rXQqs8ZP9nDoTGdRKnAA@mail.gmail.com>
 <CAKGpcipfyp3Ds4J0OH96Mu4zVhCLJg8g6tqEnfcRscZ1T8EmVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKGpcipfyp3Ds4J0OH96Mu4zVhCLJg8g6tqEnfcRscZ1T8EmVA@mail.gmail.com>
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
Cc: Olivier Dion <odion@efficios.com>, lttng-dev@lists.lttng.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Tue, Sep 02, 2025 at 04:24:16PM +0200, Thobias Knudsen wrote:
> Figured out what rcu_read_ongoing does. It just returns true if it's called
> within a read section and false otherwise. The problem for catching whether
> reads are done outside read sections is that you can not make macros for
> read and write operations. e.g. ptr->a = 4;.

We usually rely on the debugging code in rcu_dereference() to check this
sort of thing.  Or are you worried about the user leaking RCU-protected
pointers out past the rcu_read_unlock()?

							Thanx, Paul

> tir. 2. sep. 2025 kl. 16:17 skrev Thobias Knudsen <thobknu@gmail.com>:
> 
> > > I suspect that what you are trying to achieve is validation that
> > > calls to functions that require to be within a RCU read-side critical
> > > section such as cds_lfht_lookup are indeed invoked from within a
> > > critical section.
> >
> > Yes exactly, but not only for read sections. It could also be to validate
> > that rcu_barrier isnt called within a callback function or that
> > rcu_quiescent_state isnt called when thread is offline
> >
> > > We've added a "rcu_read_ongoing()" API for that purpose to liburcu
> > > RCU flavors, but AFAIK it's not used for any kind of validation
> > > within cds_lfht. This could indeed become a feature request that
> > > would apply to all liburcu data structure APIs.
> >
> > I can't find any documentation on rcu_read_ongoing. Btw the documentation
> > for urcu in general is scattered all around the repo it seems. It should
> > have been all at one place imo. Should I make a feature request for it? I
> > don't know how stuff works inside this repo though.
> >
> >
> >
> > man. 1. sep. 2025 kl. 17:09 skrev Mathieu Desnoyers <
> > mathieu.desnoyers@efficios.com>:
> >
> >> On 2025-08-31 16:48, Thobias Knudsen wrote:
> >> > BTW i've made a macro library which overrides the
> >> > urcu and lfht functions. It checks that you call the functions in the
> >> > correct order. This has been really useful for debugging and I think it
> >> > would be useful to have it integrated into urcu to make the it more
> >> user
> >> > friendly. you could have it integrated with the macro DEBUG_RCU or make
> >> > a new one, maybe DEBUG_FUNCTION_CALL_ORDER. The only thing it doesn't
> >> > catch is if you continue to use data from cds_lfht_lookup() after
> >> > rcu_read_unlock()
> >>
> >> I suspect that what you are trying to achieve is validation that
> >> calls to functions that require to be within a RCU read-side critical
> >> section such as cds_lfht_lookup are indeed invoked from within a
> >> critical section.
> >>
> >> We've added a "rcu_read_ongoing()" API for that purpose to liburcu
> >> RCU flavors, but AFAIK it's not used for any kind of validation
> >> within cds_lfht. This could indeed become a feature request that
> >> would apply to all liburcu data structure APIs.
> >>
> >> Thanks,
> >>
> >> Mathieu
> >>
> >> >
> >> > søn. 31. aug. 2025 kl. 22:42 skrev Thobias Knudsen <thobknu@gmail.com
> >> > <mailto:thobknu@gmail.com>>:
> >> >
> >> >     First question: why isn't Userspace RCU more popular?
> >> >     Second question: Why isn't it possible to create issues in the urcu
> >> >     repo? Im asking for a feature here:
> >> >     Is it possible to make a function which checks if there are more
> >> >     callbacks queued by call_rcu? I need that because there are some
> >> >     callbacks which call call_rcu, and then calling rcu_barrier once
> >> >     isn't enough and I therefore need a way to check if there are still
> >> >     callbacks to wait on before terminating the program. No worries if
> >> >     this is too much to ask for or if it isn't possible. This
> >> >     functionality is only needed in termination because otherwise
> >> >     isn't needed to call rcu_barrier multiple times (at least so far)
> >> >
> >> >     Best regards
> >> >     Thobias
> >> >
> >> >
> >>
> >>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> https://www.efficios.com
> >>
> >
