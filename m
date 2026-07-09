Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03EFC43458
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Jul 2026 23:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gx9kG0pHxz2B8R
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1783638807;
	b=gZ1H4jebVZIWvqx47+d8EViVaAbcAOwFRurx1zE10RbJ+50I0zeRWzLJEJajcO4A753h
	 +zwQIJuo3FDMNejom2DFWZsmKVDcXB68Cc4opwkEVGvQLSaxXVUT9FrCk8rAEk3S820va
	 opSXz1gs+1YN9a8zpL3D+q5Y06heB0LHyS/vTU8uws5SatbEzuJDzY6SEexq2JHBDZsS/
	 fIM/hdNY8QJTt1D1gc3Yp7TDscJcivThl3NAJjSB0kxmWDE+0wbKarOzjm531L+RfS69s
	 TAlGLgjzHqvNN7ufsO0HGBAGUR34YfdUMUrRfB2CBGjjbDFv0mwGsUExraxmIzIeAVA==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1783638807;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=IqZh1zpYlAuWRR795Io5JRyO8lI4JgsNuDPgrkiXb4I=;
	b=lNNUEKRxZB0mrgsFDtdp6sHxbqIb9EEdccnSd2oFBMMmtvl0yTqNqAHAY1LVlcTs33Ob
	 l/HoBZ/+ooAainZzi7l/54C/iB86IEjYmmpa2k/nCJNxZhvJU/WjZ4gEJ25wtdy85iwy4
	 sI+FUQVpla7HCeINbUoaGoSL5msU8AmuLW3jt5Jncyj9ZQVmjPnI5HfJb6J6Yr3w3sC9Q
	 mah+AE7O2fN3ZLIzb/n4nlbMQBJmxM5agGERq0PPOOtpui3hd41Nng79d1GChW0hVGUQl
	 IyuxpzwmkeBUNgN5aR55G98KTHkU354FBNJfVOGcdXOKpy13EX0/2hr2zyboPSEnWkQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gx9kG0pHxz2B8R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1783638807;
	bh=Bml576EhURPuJE44TzbB8PYxHUvo0WzTyw+Px0kuSkk=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=HE9ilZ+ClNnbtQbaAg55bCHr6qEeixpGGUAY3YJP4VKdmusyEdV/y1Fax6NxDTYJv
	 aK3nFacNw2Nyn9YkN6kl+VnsyrRz7nySEPnHE7ZYH2oxG4e0civrf5PcHSXjUt551o
	 IN5hutRnVq6Ch1HASCNIT2wugil/T9CAM+VBeY39E4tBKVK79+iCBFaRlLGwWXddin
	 aFJf8+21V6vqf8p1ZundrlcgewXmolbmP6VxyPQ3ehnE4c+XVpDgw0LYhvLn58vaiW
	 QnvlbqC5o2m+HolyS2zo4pS+WqGzGrx3IzwHQR5czzyNDAtdTirWaPU2yWGSB38l8a
	 XEnFjmh76bFQA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gx9kG0pHxz2B8R;
	Thu,  9 Jul 2026 19:13:26 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gx9kC4flpz2B8M
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gx9kC4flpz2B8M
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by lists.lttng.org (Postfix) with ESMTPS id 4gx9kC4flpz2B8M
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jul 2026 19:13:23 -0400 (EDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CC4240EFA;
 Thu,  9 Jul 2026 23:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F731F000E9;
 Thu,  9 Jul 2026 23:13:21 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 4FDDCCE1E72; Thu,  9 Jul 2026 16:13:21 -0700 (PDT)
Date: Thu, 9 Jul 2026 16:13:21 -0700
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>,
	Olivier Dion <odion@efficios.com>
Subject: Re: CPU affinity behavior of liburcu call-rcu per-cpu worker threads
Message-ID: <1aaa979b-bad9-47a5-879b-b4fb2379ad20@paulmck-laptop>
References: <e8fa9744-74d2-4fae-8684-f1df59aec1c0@efficios.com>
 <0600b601-3edf-4897-b319-b4763943809c@efficios.com>
 <3573944e-3abc-48d7-aedf-3362ebd7ebe4@paulmck-laptop>
 <38f1f93e-3bfa-425a-96d9-3035c8ecc785@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f1f93e-3bfa-425a-96d9-3035c8ecc785@efficios.com>
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

On Thu, Jul 09, 2026 at 06:01:54PM -0400, Mathieu Desnoyers wrote:
> On 2026-07-09 17:45, Paul E. McKenney wrote:
> > On Thu, Jul 09, 2026 at 04:00:17PM -0400, Mathieu Desnoyers wrote:
> > > On 2026-07-09 14:48, Mathieu Desnoyers wrote:
> > > > Hi Paul,
> > > > 
> > > > I have a question related to liburcu per-cpu call-rcu worker threads.
> > > > 
> > > > So far in the current liburcu releases no affinity is set when the
> > > > worker threads are started. We have to wait for
> > > > SET_AFFINITY_CHECK_PERIOD_MASK grace periods before the affinity is set
> > > > (it takes about 2.5s in my benchmarks).
> > > > 
> > > > This means that short-lived test programs will get poor CPU affinity
> > > > for call-rcu worker threads at the beginning of their lifetime. So for
> > > > short lived programs, this means poor performance.
> > > > 
> > > > OTOH, if we have short-lived applications on a large machine, setting
> > > > the affinity immediately when the worker thread is starting means
> > > > we use CPU time on CPUs which may never be actually used by the
> > > > application (no call-rcu activity), which can be detrimental to other
> > > > use-cases as well.
> > > > 
> > > > So I was wondering: is the choice of skipping setting the affinity
> > > > on call-rcu worker thread startup done on purpose ? And if so,
> > > > should we perhaps consider setting the affinity as soon as the
> > > > worker thread is woken up for the first time rather than after
> > > > SET_AFFINITY_CHECK_PERIOD_MASK grace periods ?
> > 
> > My approach when I first implemented call_rcu() was that the typical
> > application would have lots of reads and very few updates, so the
> > default was a single call_rcu() thread shared by all worker threads.
> > I allowed for manual configuration and affinity of call_rcu() threads
> > for special-case high-update-rate applications.
> 
> I'm currently working on data structures supporting scalable updates,
> which highlight a broader need for per-cpu call-rcu worker threads
> (at least if update scalability is wanted).
> 
> > My hope was that we would be able to use per-CPU call_rcu() threads
> > with something like rseq allowing the worker threads to move around
> > arbitrarily but still getting good cache affinity in their interactions
> > with the call_rcu() threads.  Easy to say, I know!  ;-)
> 
> Having a call-rcu worker thread moving around and sitting on a different
> node than the call-rcu users on a big NUMA box is somewhat detrimental
> to performance unfortunately.

No, I mean that the call_rcu() worker threads each stay put on their
own CPU.  The other threads might (or might not, user's choice) move
around, but in the common case, they would queue to the worker thread
on the CPU that they were currently running on.

> The telltale sign of this behavior (which got fixed by pinning call-rcu
> workers early) was that benchmark results were mostly binomial (high
> variance, some slower, some faster). Those benchmarks happened to run
> many 2s instances of processes, all falling within the missing affinity
> window.

Understood, been there, and just pinned everything with each thread
having its own call_rcu() worker thread.  And ran longer benchmarks,
so that any initial issues would be lost in the noise.

> > > I've implemented this compromise approach here:
> > > 
> > > https://review.lttng.org/c/userspace-rcu/+/18257 call-rcu worker: set CPU affinity on first non-empty dequeue
> > 
> > The idea being that the call_rcu() thread checks its partner and uses
> > explicit affinity to follow it around?
> 
> Actually, the per-cpu call-rcu worker thread already has all the cpu
> affinity information it needs. It's handed over at creation. It's just
> that it applies it rather late (after ~2.5s), and only if it happens
> to be running on the "wrong" CPU at that particular moment.
> 
> Those two factors are not really great for benchmark reproducibility.

Indeed, 2.5 seconds is a long time, even for longish benchmarks.

> > I am reminded of a DYNIX/ptx feature that allowed you to say that a
> > pair of userspace threads were related, so that they should be migrated
> > together.  This idea did not go over well during the initial Linux-kernel
> > scheduler discussions a quarter century back.  ;-)
> 
> I don't really need to have the call-rcu worker related to specific
> tasks, but I do care that it's local to (at least) a core. I have a
> high-churn workload which quickly recycles per-cpu slab memory, and
> in order to get good performance with it I need:
> 
> - Per-cpu slab cache,
> - Per-cpu (or at least per core) call-rcu worker threads,
> 
> Which keeps all the alloc -> call-rcu -> worker -> free churn local
> to a CPU.

So tcmalloc()?  And extensions to rseq to allow something else to use
it concurrently.  Or modifications to tcmalloc() to play nicely.  :-/

> The task pairing you hint at would be great for the per-thread
> call-rcu workers we support in liburcu, but as you say it's easier
> said than done.

It worked great in DYNIX/ptx!  Which was admittedly way simpler than
Linux currently is.  ;-)

> Another approach which would be interesting to look into is to
> somehow attach the call-rcu workers to rseq mm_cid concurrency
> ids.

So that a given invocation of call_rcu() queues to the current CPU's
call_rcu() worker thread?  That sounds like a way to obtain what I was
asking for above.  As you said, easier said than done.

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
