From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH lttng-modules] Fix: use timekeeping_is_busy() to fix
 ktime_get() hard lockup
Date: Thu, 12 Sep 2013 21:53:48 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1309122146360.4089@ionos.tec.linutronix.de>
References: <20130911151200.GB19800@Krystal> <52309DB0.4020403@linaro.org> <20130911190124.GA31443@Krystal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130911190124.GA31443@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: John Stultz <john.stultz@linaro.org>, Richard Cochran <richardcochran@gmail.com>, Prarit Bhargava <prarit@redhat.com>, lttng-dev@lists.lttng.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>
List-Id: lttng-dev@lists.lttng.org

On Wed, 11 Sep 2013, Mathieu Desnoyers wrote:
> * John Stultz (john.stultz@linaro.org) wrote:
> > On 09/11/2013 08:12 AM, Mathieu Desnoyers wrote:
> > > LTTng uses ktime to have the same time-base across kernel and
> > > user-space, so traces gathered from LTTng-modules and LTTng-UST can be
> > > correlated. We plan on using ktime until a fast, scalable, and
> > > fine-grained time-source for tracing that can be used across kernel and
> > > user-space, and which does not rely on read seqlock for kernel-level
> > > synchronization, makes its way into the kernel.
> > >
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Richard Cochran <richardcochran@gmail.com>
> > > Cc: Prarit Bhargava <prarit@redhat.com>
> > > Cc: John Stultz <john.stultz@linaro.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Ingo Molnar <mingo@elte.hu>
> > > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > ---
> > > diff --git a/wrapper/trace-clock.h b/wrapper/trace-clock.h
> > > index bced61c..2f9df7a 100644
> > > --- a/wrapper/trace-clock.h
> > > +++ b/wrapper/trace-clock.h
> > > @@ -32,6 +32,7 @@
> > >  #include <linux/ktime.h>
> > >  #include <linux/time.h>
> > >  #include <linux/hrtimer.h>
> > > +#include <linux/version.h>
> > >  #include "random.h"
> > >  
> > >  static inline u64 trace_clock_monotonic_wrapper(void)
> > > @@ -45,6 +46,10 @@ static inline u64 trace_clock_monotonic_wrapper(void)
> > >  	if (in_nmi())
> > >  		return (u64) -EIO;
> > >  
> > > +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0))
> > > +	if (timekeeping_is_busy())
> > > +		return (u64) -EIO;
> > > +#endif
> > >  	ktime = ktime_get();
> > >  	return ktime_to_ns(ktime);
> > >  }
> > 
> > 
> > I guess the other question here is should this functionality be pushed
> > down into the timekeeping accessors themselves?
> > 
> > I know any extra checks would probably be considered overhead in some
> > uses, but if we do the check only when we hit contention then it might
> > not be so bad.
> 
> I thought about the exact same thing, but wanted to keep my initial
> kernel patch minimal, so I chose not to touch the fast paths initially.
> 
> Indeed, if we only do this check after the seqretry has failed, we
> should be able to add this check without touching the fast-path.
> 
> It might be cleaner to make ktime_get() return an error rather than
> cause a hard lockup in those cases. Especially if it can be done without
> performance regression.

Nope. ktime_get() is not going to fail ever. We want to deadlock when
its called from inside xtime_lock held code. Simply because it's wrong
to do so.

If there are special use cases, i.e. tracing, which need this kind of
check, then we rather add a new interface, e.g. ktime_get_tracetime(),
than adding a tasteless bogosity like timekeeping_busy().

Thanks,

	tglx
