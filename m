Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0117EC43458
	for <lttng-dev@archiver.kernel.org>; Fri, 10 Jul 2026 02:53:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gxGbq63RszyfM
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1783651993;
	b=eV34SCLHn4GSaI3wBaxw1WR4yhIwWY3B52raDNmBZu4/nn0cM+s7GAKtr4Tket/cTcMo
	 UfvTYJDNzElWJ6r68YVTW/WDlzD6ADpTnkbQ79XqUaZUL/IMeN1MiPmuVYhnkYydpcNgl
	 UCDx+jMEgIuVGj9wVrCcpgO9RkzLx8SQ6Z74+yGXq2DBsZvtmCpcCVKnh+EHEaEZKa5zA
	 A5YnvhITmagZDPnwqtr3d8UrwGP5MIsWfuVIs+ipFrI7YJ7PiGqZnsZrvMm4eDRFRHNtW
	 gzWoXIL3Xr6B8dCnuqgxWbp+YJs36nlPlb++jFALQ3NfuM8IGgikSU0hLZvD5VOl8Gw==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1783651993;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=9kWe9g4eEXcu9jZ7VFsACZFesxjz8l9t6IJqfDGM2e8=;
	b=H7/lT1vgrxYxSr4TPvT4LN6fro6Coo5JvkHvnLr8xzocUc+UvHU6ItvDfIBCQcHK+xxF
	 +wT5/PwoFVx3hb3x3jWeu8lUy8YzOzdZxKzpNwuQJa+QaDHGM6eBkq2BOm+PkKg4yTI+R
	 KhinqEzx4Mx1OioGkGPHTkd/20FdpqcWJNRAT34VN0oRKCaBMchHU7BwtI05tKOuXhUWg
	 YCGrZZydD9+lvvluIdtIoVLS48oXiwWCbIPv4Drchpkm6F6Vpb0EVBV9ftO+W2rH1U8wO
	 YJac0KDbnlgHdT7CGBFLUAbYUik6WaBS59gCS0lXliEXV0mAyacCkPhTcfWDhALQkwg==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gxGbq63RszyfM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1783651993;
	bh=+7teTaxKrIuVAZ+YXbluDYul0HIclna7r0C3rzbv98Y=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qVlWESAm2UNSC2/U117eFt5l9LQcFopFmVJRHiNcjX0Rt4HqgxveyXMZmnwmQXbJ/
	 rGm3GfXG6FyZei9I3tNlcgR/PGrwAa5YdpnpO4pYg9qYohskr1ITghyj6XOuXG9vjT
	 wgX72uI4sWvNlz4Nfrd/nCihnKORW2DYtO7Ef2Su/F0gZXTZU5RZmRr4Xv8BCYZHiP
	 cF8+j9VKsXEVJCu7lMVe+hcXjOS/04mD/xqsuneHDHYAjsoV6s9mBRAJsy707ZILN/
	 sEfYKK74w1etgxoKkroESjX/kISioTv1XUYKs/rr4WmZZtxDPS3WfU7ogJBWoP9pDi
	 pdZ7UgvHcVAUw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gxGbq63RszyfM;
	Thu,  9 Jul 2026 22:53:11 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gxGbp27Kwzyn3
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gxGbp27Kwzyn3
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by lists.lttng.org (Postfix) with ESMTPS id 4gxGbp27Kwzyn3
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jul 2026 22:53:09 -0400 (EDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7834943870;
 Fri, 10 Jul 2026 02:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2F81F000E9;
 Fri, 10 Jul 2026 02:53:07 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 2C41ACE0F42; Thu,  9 Jul 2026 19:53:07 -0700 (PDT)
Date: Thu, 9 Jul 2026 19:53:07 -0700
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>,
	Olivier Dion <odion@efficios.com>
Subject: Re: CPU affinity behavior of liburcu call-rcu per-cpu worker threads
Message-ID: <02709be9-d7d8-47cc-8032-ed2e3a714fb0@paulmck-laptop>
References: <e8fa9744-74d2-4fae-8684-f1df59aec1c0@efficios.com>
 <0600b601-3edf-4897-b319-b4763943809c@efficios.com>
 <3573944e-3abc-48d7-aedf-3362ebd7ebe4@paulmck-laptop>
 <38f1f93e-3bfa-425a-96d9-3035c8ecc785@efficios.com>
 <1aaa979b-bad9-47a5-879b-b4fb2379ad20@paulmck-laptop>
 <a25cc916-2bb3-4133-afcb-230dd577726d@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a25cc916-2bb3-4133-afcb-230dd577726d@efficios.com>
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Thu, Jul 09, 2026 at 07:31:18PM -0400, Mathieu Desnoyers wrote:
> On 2026-07-09 19:13, Paul E. McKenney wrote:
> [...]
> 
> > > > I am reminded of a DYNIX/ptx feature that allowed you to say that a
> > > > pair of userspace threads were related, so that they should be migrated
> > > > together.  This idea did not go over well during the initial Linux-kernel
> > > > scheduler discussions a quarter century back.  ;-)
> > > 
> > > I don't really need to have the call-rcu worker related to specific
> > > tasks, but I do care that it's local to (at least) a core. I have a
> > > high-churn workload which quickly recycles per-cpu slab memory, and
> > > in order to get good performance with it I need:
> > > 
> > > - Per-cpu slab cache,
> > > - Per-cpu (or at least per core) call-rcu worker threads,
> > > 
> > > Which keeps all the alloc -> call-rcu -> worker -> free churn local
> > > to a CPU.
> > 
> > So tcmalloc()?  And extensions to rseq to allow something else to use
> > it concurrently.  Or modifications to tcmalloc() to play nicely.  :-/
> 
> I created my own per-cpu "cache" with a wfstack list in a liburcu
> feature branch. It works with all allocators :)

Been there, done that!  ;-)

> And unfortunately, for me, tcmalloc is really not a viable option,
> because it needs to own the RSEQ area registration, and because glibc
> cannot use it at the same time as tcmalloc, my benchmarks suffer because
> glibc has a slower sched_getcpu() implementation.
> 
> So jemalloc it is. tcmalloc is not usable for me because they don't
> compose with the rest of the world. I warned the tcmalloc developers
> many times, but they did not listen. :-(

So an alternative rseq for the rest of us?

> > > The task pairing you hint at would be great for the per-thread
> > > call-rcu workers we support in liburcu, but as you say it's easier
> > > said than done.
> > 
> > It worked great in DYNIX/ptx!  Which was admittedly way simpler than
> > Linux currently is.  ;-)
> > 
> > > Another approach which would be interesting to look into is to
> > > somehow attach the call-rcu workers to rseq mm_cid concurrency
> > > ids.
> > 
> > So that a given invocation of call_rcu() queues to the current CPU's
> > call_rcu() worker thread?  That sounds like a way to obtain what I was
> > asking for above.  As you said, easier said than done.
> 
> Yes, the advantage is that you would only need to keep around one call
> rcu worker thread per _concurrently used_ cpu, rather than per-possible
> CPUs. And you would have one call-rcu list per concurrency ID.
> 
> Currently the max number for concurrency ids in a process is limited by
> min(nr_threads, hweight(affinity mask)).
> 
> And I still have future plans to implement a cgroup cpu.max.concurrency
> file, but I did not get there yet.

These do sound like good improvements!

							Thanx, Paul
