From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH] Introduce timekeeper latch synchronization
Date: Fri, 13 Sep 2013 21:18:25 -0400
Message-ID: <20130914011825.GA24859@Krystal>
References: <20130913025253.GA17218@Krystal> <20130913153020.GA24383@Krystal> <52336576.1060908@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52336576.1060908@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Richard Cochran <richardcochran@gmail.com>, Prarit Bhargava <prarit@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* John Stultz (john.stultz@linaro.org) wrote:
> On 09/13/2013 08:30 AM, Mathieu Desnoyers wrote:
> > By the way, if there are some standard test-bench for timekeeping, I'd
> > be very interested to hear about them.
> I've got a git repo of tests that I use for basic sanity checks here:
>     https://github.com/johnstultz-work/timetests.git

Thanks for the pointer! It looks like I'm currently breaking
CLOCK_MONOTONIC_RAW. My thoughts are that struct clocksource read vs
updates are relying on the timekeeper seqlock for synchronization.
Therefore, I might have to apply the latch scheme to struct clocksource
too.

Thoughts ?

Thanks,

Mathieu

> 
> thanks
> -john
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
