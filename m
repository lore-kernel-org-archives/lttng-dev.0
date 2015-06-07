From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH] sched: Fix sched_wakeup tracepoint
Date: Sun, 7 Jun 2015 10:20:14 +0000 (UTC)
Message-ID: <1960877063.5553.1433672414640.JavaMail.zimbra__22197.720668237$1433672493$gmane$org@efficios.com>
References: <1433504509-17013-1-git-send-email-mathieu.desnoyers@efficios.com>
 <20150605120909.GG19282@twins.programming.kicks-ass.net>
 <479621151.4836.1433507522491.JavaMail.zimbra@efficios.com>
 <1433508695.1495.16.camel@twins>
 <600031664.4911.1433510581646.JavaMail.zimbra@efficios.com>
 <1433592142.1495.22.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Z1Xgo-0007lO-6s
 for lttng-dev@lists.lttng.org; Sun, 07 Jun 2015 06:20:30 -0400
In-Reply-To: <1433592142.1495.22.camel@twins>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, rostedt <rostedt@goodmis.org>, lttng-dev <lttng-dev@lists.lttng.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jun 6, 2015, at 2:02 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Fri, 2015-06-05 at 13:23 +0000, Mathieu Desnoyers wrote:
>> OK, so considering the definition naming feedback you provided, we
>> may need a 3 tracepoint if we want to calculate both wakeup latency
>> and scheduling latency (naming ofc open to discussion):
>> 
>> sched_wakeup: when try_to_wake_up{,_local} is called in the waker.
>> sched_activate_task: when the wakee is marked runnable.
>> sched_switch: when scheduling actually happens.
> 
> I would propose:
> 
>	sched_waking: upon calling try_to_wake_up() as soon as we know we need
> to change state; guaranteed to be called from the context doing the
> wakeup.
> 
>	sched_woken: the wakeup is complete (task is runnable, any delay
> between this and actually getting on a cpu is down to the scheduler).
> 
>	sched_switch: when switching from task @prev to @next.

Agreed,

> 
> This means abandoning trace_sched_wakeup(); which might be a problem,
> which is why I bloody hate tracepoints :-(

OK. I guess it's about time we dive into that question. Should tracepoint
semantic be kept cast in stone forever ? Not in my opinion, and here is why.

Most of the Linux kernel ABI exposed to userspace serves as support to
runtime (system calls, virtual file systems, etc). For all that, it makes
tons of sense to keep it stable, following the Documentation/ABI/README
guidelines. Even there, we have provisions for obsolescence and removal
of an ABI if need be, which provides userspace some time to adapt to
changes.

How are tracepoints different ? Well, those are not meant to be used in
runtime support, but rather for analyzing systems, which means that
userspace tools using the tracepoint content do not need it to _run_,
but rather as information source to perform analyses.

Even though I dislike analogies, I think we need one here. Let's consider
CAN bus ports for car debugging. Even though the transport is covered by
standards, it does not mandate the semantics of the data per se. I would
not expect a debugging device made in 2005 to work for newest generations
of car. However, I would expect that new debug devices are compatible with
older cars, and that those debug devices have means to query which type of
car it is debugging. Otherwise, the debugging device is simply crap,
because it cannot adapt to change. What should a debug device created in
2005 do if connected to a new car ? Ideally, it should gracefully decline
to interact with this car, and require a software upgrade.

OK, now back to kernel tracepoints. My opinion is that it is a fundamental
requirement that trace analysis tools should be able to detect that they
are unable understand tracepoint data they care about. It seems perfectly
fine to me to require that analysis tool upgrades are needed to interact
with a new kernel. However, a tool should be able to handle a range of
older kernel versions too.

This can be done by many means, including making sure preexisting event name
and fields semantic are immutable, or by versioning of tracepoints on a
per-event basis.

Here, in the case of sched_wakeup: we end up noticing that it accidentally
changed location in the kernel across versions, which makes it useless for
many analyses unless they use kernel version information to get the right
semantic associated with this event.

So here, for introducing sched_waking/sched_woken, we have a few ways
forward:

1) Keep sched_wakeup as it is, and add those two new events. Analyses
   can then continue using the old event for a while, and if they sees
   that sched_waking/sched_woken are there, they can use those more
   precise events instead. This could allow us to do a gradual
   deprecation phase for the sched_wakeup tracepoint.

2) Remove sched_wakeup event, replacing it by sched_waking/sched_woken.
   Require immediate analysis tool upgrade to deal with this new
   information. Old tools should gracefully fail and ask users to
   upgrade. If they don't, fix them so they can handle change.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
