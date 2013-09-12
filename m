From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH] timekeeping: introduce timekeeping_is_busy()
Date: Wed, 11 Sep 2013 20:48:11 -0400
Message-ID: <20130912004811.GA6096@Krystal>
References: <20130911150853.GA19800@Krystal> <52309D13.3020305@linaro.org> <20130911185441.GC23532@Krystal> <20130911203618.GH3966@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130911203618.GH3966@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Richard Cochran <richardcochran@gmail.com>, Prarit Bhargava <prarit@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> On Wed, Sep 11, 2013 at 02:54:41PM -0400, Mathieu Desnoyers wrote:
[...]
> > If we can afford a synchronize_rcu_sched() wherever the write seqlock is
> > needed, we could go with the following. Please note that I use
> > synchronize_rcu_sched() rather than call_rcu_sched() here because I try
> > to avoid having too many timekeeper structures hanging around, and I
> > think it can be generally a good think to ensure timekeeping core does
> > not depend on the memory allocator (but I could very well be wrong).
> 
> The issue called out with this the last time I remember it being put
> forward was that grace periods can be delayed for longer than is an
> acceptable gap between timekeeping updates.  But maybe something has
> changed since then -- that was a few years ago.

Assuming we have lockdep support for seqlock, and we ensure there is no
deadlock between timekeeper seqlock and other locks. Also, given our
intent is more or less to allow execution contexts nested over the write
seqlock to read time (e.g. nmi handlers), I think we could do the
following:

updates:
- spinlock irq save
- take a shadow copy of the old timekeeper structure.
- store the CPU number that owns the lock into a variable.
- barrier()     /* store cpu nr before seqlock from nested NMI POV */
- write seqlock begin
- perform timekeeper structure update
- write seqlock end
- barrier()     /* store seqlock before cpu nr from nested NMI POV */
- store -1 into lock owner variable
- spin unlock irqrestore

kernel read-side:
- try read seqlock loop for fast path
- if seqlock read fails, check if we are the CPU owning the lock
  (variable stored by the update). If it is so, fall-back to the shadow
  copy, else, retry seqlock.

This approach would _only_ work if there is no deadlock involving a lock
nested within the write seqlock. Hence the importance of adding lockdep
support if we choose this locking design.

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
