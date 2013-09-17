From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [tip:timers/urgent] timekeeping: Fix HRTICK related deadlock
	from ntp lock changes
Date: Tue, 17 Sep 2013 12:33:03 -0400
Message-ID: <20130917163303.GA10491@Krystal>
References: <1378943457-27314-1-git-send-email-john.stultz@linaro.org> <tip-7bd36014460f793c19e7d6c94dab67b0afcfcb7f@git.kernel.org> <20130916160426.GA24669@Krystal> <20130917070728.GC20661@gmail.com> <20130917080941.GA4675@Krystal> <20130917082649.GE20661@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130917082649.GE20661@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, gerlando.falauto@keymile.com, john.stultz@linaro.org, minggr@gmail.com, tglx@linutronix.de, linux-tip-commits@vger.kernel.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Ingo Molnar (mingo@kernel.org) wrote:
> 
> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > * Ingo Molnar (mingo@kernel.org) wrote:
> > > 
> > > * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > > 
> > > > Hi Ingo,
> > > > 
> > > > Do you have an estimate of the time it will take for this fix to hit 
> > > > mainline, stable-3.10 and stable-3.11 ? Meanwhile, I'm marking 3.10 and 
> > > > 3.11 as broken for LTTng with a kernel version at compile-time, since 
> > > > this kernel regression currently triggers hard system lockup when people 
> > > > use LTTng on those kernels, and this is certainly something nobody 
> > > > wants.
> > > 
> > > So, at least as per the description of John, this should only trigger if 
> > > SCHED_HRTICK is enabled in sched_features - which is disabled by default, 
> > > it's a debug-only development feature. Does the bug trigger on more 
> > > regular kernels as well?
> > 
> > Unfortunately, it does happen on a pretty standard kernel config (giving
> > my x230 config as example below). Pasting relevant bug description from
> > http://bugs.lttng.org/issues/631 :
> > 
> > "Starting from Linux kernel commit
> > 06c017fdd4dc48451a29ac37fc1db4a3f86b7f40 "timekeeping: Hold
> > timekeepering locks in do_adjtimex and hardpps" (3.10 kernels), the
> > xtime write seqlock is held across calls to __do_adjtimex(), which
> > includes a call to notify_cmos_timer(), and hence
> > schedule_delayed_work().
> > 
> > This introduces a side-effect for a set of tracepoints, including mainly 
> > the workqueue tracepoints: a tracer hooking on those tracepoints and 
> > reading current time with ktime_get() will cause hard system LOCKUP"
> 
> It's the LTTng tracepoint 'hooking' in something that does something 
> invalid in that context that is causing the hang, not the vanilla kernel 
> itself, right?

Yes, that's correct. In order to ensure this kind of problem is entirely
taken care of, I've started working on a synchronization scheme proposed
by Peter Zijlstra that would allow ktime() to be called from any
execution context (see:
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg504089.html).

> 
> In that case the 'you get to keep both pieces' policy of out of tree code 
> applies - but the HRTICK fix should solve your problem as well, 
> incidentally.

Thanks,

Mathieu

> 
> Thanks,
> 
> 	Ingo

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
