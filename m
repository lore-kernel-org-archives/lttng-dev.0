From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] Introduce timekeeper latch synchronization
Date: Fri, 13 Sep 2013 09:31:56 +0200
Message-ID: <20130913073156.GF31370@twins.programming.kicks-ass.net>
References: <20130913025253.GA17218@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130913025253.GA17218@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Richard Cochran <richardcochran@gmail.com>, Prarit Bhargava <prarit@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Thu, Sep 12, 2013 at 10:52:53PM -0400, Mathieu Desnoyers wrote:
> OK! Here is the full implementation of the idea against Linux
> timekeeper, ntp, and PPS. It appears that ntp and PPS were relying on
> the timekeeper seqlock too. And guess what, after booting my laptop with
> this kernel there still no smoke coming out of it after a good 5 minutes
> of testing. ;-)
> 
> Comments are welcome.

I think that moving stuff into structures is a worthwhile change on its
own, but I'll leave John and Thomas to decide on all that.

The latch thing does make the update side slightly more expensive due to
having to do that copy every time, but ideally that wouldn't happen all
that often.
