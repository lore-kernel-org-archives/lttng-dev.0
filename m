From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH] sched: Fix sched_wakeup tracepoint
Date: Mon, 8 Jun 2015 13:27:35 -0400
Message-ID: <20150608132735.0763ad27@gandalf.local.home>
References: <1433504509-17013-1-git-send-email-mathieu.desnoyers@efficios.com>
	<20150605120909.GG19282@twins.programming.kicks-ass.net>
	<479621151.4836.1433507522491.JavaMail.zimbra@efficios.com>
	<1433508695.1495.16.camel@twins>
	<600031664.4911.1433510581646.JavaMail.zimbra@efficios.com>
	<1433592142.1495.22.camel@twins>
	<1960877063.5553.1433672414640.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1960877063.5553.1433672414640.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Francis Giraldeau <francis.giraldeau@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: lttng-dev@lists.lttng.org


[ Keeping entire email because I added Linus ]

On Sun, 7 Jun 2015 10:20:14 +0000 (UTC)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Jun 6, 2015, at 2:02 PM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Fri, 2015-06-05 at 13:23 +0000, Mathieu Desnoyers wrote:
> >> OK, so considering the definition naming feedback you provided, we
> >> may need a 3 tracepoint if we want to calculate both wakeup latency
> >> and scheduling latency (naming ofc open to discussion):
> >> 
> >> sched_wakeup: when try_to_wake_up{,_local} is called in the waker.
> >> sched_activate_task: when the wakee is marked runnable.
> >> sched_switch: when scheduling actually happens.
> > 
> > I would propose:
> > 
> >	sched_waking: upon calling try_to_wake_up() as soon as we know we need
> > to change state; guaranteed to be called from the context doing the
> > wakeup.
> > 
> >	sched_woken: the wakeup is complete (task is runnable, any delay
> > between this and actually getting on a cpu is down to the scheduler).
> > 
> >	sched_switch: when switching from task @prev to @next.
> 
> Agreed,
> 
> > 
> > This means abandoning trace_sched_wakeup(); which might be a problem,
> > which is why I bloody hate tracepoints :-(
> 
> OK. I guess it's about time we dive into that question. Should tracepoint
> semantic be kept cast in stone forever ? Not in my opinion, and here is why.
> 
> Most of the Linux kernel ABI exposed to userspace serves as support to
> runtime (system calls, virtual file systems, etc). For all that, it makes
> tons of sense to keep it stable, following the Documentation/ABI/README
> guidelines. Even there, we have provisions for obsolescence and removal
> of an ABI if need be, which provides userspace some time to adapt to
> changes.
> 
> How are tracepoints different ? Well, those are not meant to be used in
> runtime support, but rather for analyzing systems, which means that
> userspace tools using the tracepoint content do not need it to _run_,
> but rather as information source to perform analyses.
> 
> Even though I dislike analogies, I think we need one here. Let's consider
> CAN bus ports for car debugging. Even though the transport is covered by
> standards, it does not mandate the semantics of the data per se. I would
> not expect a debugging device made in 2005 to work for newest generations
> of car. However, I would expect that new debug devices are compatible with
> older cars, and that those debug devices have means to query which type of
> car it is debugging. Otherwise, the debugging device is simply crap,
> because it cannot adapt to change. What should a debug device created in
> 2005 do if connected to a new car ? Ideally, it should gracefully decline
> to interact with this car, and require a software upgrade.
> 
> OK, now back to kernel tracepoints. My opinion is that it is a fundamental
> requirement that trace analysis tools should be able to detect that they
> are unable understand tracepoint data they care about. It seems perfectly
> fine to me to require that analysis tool upgrades are needed to interact
> with a new kernel. However, a tool should be able to handle a range of
> older kernel versions too.
> 
> This can be done by many means, including making sure preexisting event name
> and fields semantic are immutable, or by versioning of tracepoints on a
> per-event basis.
> 
> Here, in the case of sched_wakeup: we end up noticing that it accidentally
> changed location in the kernel across versions, which makes it useless for
> many analyses unless they use kernel version information to get the right
> semantic associated with this event.
> 
> So here, for introducing sched_waking/sched_woken, we have a few ways
> forward:
> 
> 1) Keep sched_wakeup as it is, and add those two new events. Analyses
>    can then continue using the old event for a while, and if they sees
>    that sched_waking/sched_woken are there, they can use those more
>    precise events instead. This could allow us to do a gradual
>    deprecation phase for the sched_wakeup tracepoint.
> 
> 2) Remove sched_wakeup event, replacing it by sched_waking/sched_woken.
>    Require immediate analysis tool upgrade to deal with this new
>    information. Old tools should gracefully fail and ask users to
>    upgrade. If they don't, fix them so they can handle change.

2 will break tools and even if they fail "gracefully" that probably
still isn't acceptable as the sched_wakeup tracepoint is a popular one.


  3) Add the two tracepoints and remove the sched_wakeup() one, but
  then add a manual tracepoint for perf and ftrace that can simulate
  the sched_wakeup() from the other two tracepoints. This should keep
  tools working and we can have better wake up tracepoints implemented,
  without the overhead of the third "obsolete" tracepoint in the
  scheduling code.

-- Steve
