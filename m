From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: call_rcu seems inefficient without futex
Date: Mon, 27 Jan 2020 19:45:45 -0800
Message-ID: <20200128034545.GP2935@paulmck-ThinkPad-P72>
References: <157982514329.691.6168767011604689030.ref@pink>
 <157982514329.691.6168767011604689030@pink>
 <77660372.600081.1580139485777.JavaMail.zimbra@efficios.com>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by lists.lttng.org (Postfix) with ESMTPS id 486CSz2gLpz1y9w
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jan 2020 22:55:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <77660372.600081.1580139485777.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Jan 27, 2020 at 10:38:05AM -0500, Mathieu Desnoyers wrote:
> ----- On Jan 23, 2020, at 7:19 PM, lttng-dev lttng-dev@lists.lttng.org wrote:
> 
> > Hi,
> > 
> > I recently installed knot dns for a very small FreeBSD server. I noticed
> > that it uses a surprising amount of CPU, even when there is no load:
> > about 0.25%. That's not huge, but it seems unnecessarily high when my
> > QPS is less than 0.01.
> > 
> > After some profiling, I came to the conclusion that this is caused by
> > call_rcu_wait using futex_async to repeatedly wait. Since there is no
> > futex on FreeBSD (without the Linux compatibility layer), this
> > effectively turns into a permanent busy waiting loop.
> > 
> > I think futex_noasync can be used here instead. call_rcu_wait is only
> > supposed to be called from call_rcu_thread, never from a signal context.
> > call_rcu calls get_call_rcu_data, which may call
> > get_default_call_rcu_data, which calls pthread_mutex_lock through
> > call_rcu_lock. Therefore, call_rcu is not async-signal-safe already.
> 
> call_rcu() is meant to be async-signal-safe and lock-free after that
> initialization has been performed on first use. Paul, do you know where
> we have documented this in liburcu ?

Lock freedom is the goal, but when not in real-time mode, call_rcu()
does invoke futex_async(), which can acquire locks within the Linux
kernel.

Should BSD instead use POSIX condvars for the call_rcu() waits and
wakeups?

> > Also, I think it only makes sense to use call_rcu around a RCU write,
> > which contradicts the README saying that only RCU reads are allowed in
> > signal handlers.

I do not believe that it is always safe to invoke call_rcu() from within
a signal handler.  If you made sure to invoke it outside a signal handler
the first time, and then used real-time mode, that should work.  But in
that case, you aren't invoking the futex code.

> Not sure what you mean by "use call_rcu around a RCU write" ?

I confess to some curiosity on this point as well.  Maybe what is meant
is "around a RCU write" as in "near to an RCU write" as in "in place of
using synchronize_rcu()"?

> Is there anything similar to sys_futex on FreeBSD ?
> 
> It would be good to look into alternative ways to fix this that do not
> involve changing the guarantees provided by call_rcu() for that fallback
> scenario (no futex available). Perhaps in your use-case you may want to
> tweak the retry delay for compat_futex_async(). Currently
> src/compat_futex.c:compat_futex_async() has a 10ms delay. Would 100ms
> be more acceptable ?

If this works for knot dns, it would of course be simpler.

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > 
> > I applied "sed -i -e 's/futex_async/futex_noasync/'
> > src/urcu-call-rcu-impl.h" and knot seems to work correctly with only
> > 0.01% CPU now. I also ran tests/unit and tests/regression with default
> > and signal backends and all completed successfully.
> > 
> > I think that the other two usages of futex_async are also a little
> > suspicious, but I didn't look too closely.
> > 
> > Thanks,
> > Alex.
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
