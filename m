From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH] sched: Fix sched_wakeup tracepoint
Date: Wed, 17 Jun 2015 14:47:09 -0400
Message-ID: <20150617144709.5814a48d@gandalf.local.home>
References: <1433504509-17013-1-git-send-email-mathieu.desnoyers@efficios.com>
	<20150605120909.GG19282@twins.programming.kicks-ass.net>
	<479621151.4836.1433507522491.JavaMail.zimbra@efficios.com>
	<1433508695.1495.16.camel@twins>
	<600031664.4911.1433510581646.JavaMail.zimbra@efficios.com>
	<1433592142.1495.22.camel@twins>
	<1960877063.5553.1433672414640.JavaMail.zimbra@efficios.com>
	<20150608132735.0763ad27@gandalf.local.home>
	<20150609091336.GQ3644@twins.programming.kicks-ass.net>
	<CAM_iQpXaWwgN6rYXsbpV9yNnrpgrX9mfzc5ZRLpHtSw_wYAxTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAM_iQpXaWwgN6rYXsbpV9yNnrpgrX9mfzc5ZRLpHtSw_wYAxTg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Francis Giraldeau <francis.giraldeau@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, 17 Jun 2015 11:23:00 -0700
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> On Tue, Jun 9, 2015 at 2:13 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > So how about we introduce the 'waking' tracepoint and leave the existing
> > wakeup one in place and preserve its woken semantics.
> >
> > Steven, can we do aliases? Where one tracepoint is known to userspace
> > under multiple names? In that case we could rename the thing to woken
> > and have an alias wakeup which we can phase out over time.
> >
> > The patch also takes away the success parameter to the tracepoint, but
> > does not quite go as far as actually removing it from the tracepoint
> > itself.
> >
> > We can do that in a follow up patch which we can quickly revert if it
> > turns out people are actually still using that for something.
> 
> +1 to this patch. How is it going?

It's not a top priority. But it shouldn't be too hard to implement.
This could be something I do after the 4.2 merge window closes.

-- Steve


> 
> Here at Twitter, we are analyzing scheduling latencies too, with our
> own tool using existing tracepoints, it would be nice to have more
> granularity on the scheduling latency.
> 
> And, you probably want to change perf sched to respect this
> new 'waking' event too. ;)
> 
> Thanks.
