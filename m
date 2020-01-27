From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: call_rcu seems inefficient without futex
Date: Mon, 27 Jan 2020 10:38:05 -0500 (EST)
Message-ID: <77660372.600081.1580139485777.JavaMail.zimbra@efficios.com>
References: <157982514329.691.6168767011604689030.ref@pink>
 <157982514329.691.6168767011604689030@pink>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 485v5p6H8yz1xGg
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jan 2020 10:38:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4581325F1FB
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jan 2020 10:38:06 -0500 (EST)
In-Reply-To: <157982514329.691.6168767011604689030@pink>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Alex Xu <alex_y_xu@yahoo.ca>, paulmck <paulmck@kernel.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jan 23, 2020, at 7:19 PM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Hi,
> 
> I recently installed knot dns for a very small FreeBSD server. I noticed
> that it uses a surprising amount of CPU, even when there is no load:
> about 0.25%. That's not huge, but it seems unnecessarily high when my
> QPS is less than 0.01.
> 
> After some profiling, I came to the conclusion that this is caused by
> call_rcu_wait using futex_async to repeatedly wait. Since there is no
> futex on FreeBSD (without the Linux compatibility layer), this
> effectively turns into a permanent busy waiting loop.
> 
> I think futex_noasync can be used here instead. call_rcu_wait is only
> supposed to be called from call_rcu_thread, never from a signal context.
> call_rcu calls get_call_rcu_data, which may call
> get_default_call_rcu_data, which calls pthread_mutex_lock through
> call_rcu_lock. Therefore, call_rcu is not async-signal-safe already.

call_rcu() is meant to be async-signal-safe and lock-free after that
initialization has been performed on first use. Paul, do you know where
we have documented this in liburcu ?

> Also, I think it only makes sense to use call_rcu around a RCU write,
> which contradicts the README saying that only RCU reads are allowed in
> signal handlers.

Not sure what you mean by "use call_rcu around a RCU write" ?

Is there anything similar to sys_futex on FreeBSD ?

It would be good to look into alternative ways to fix this that do not
involve changing the guarantees provided by call_rcu() for that fallback
scenario (no futex available). Perhaps in your use-case you may want to
tweak the retry delay for compat_futex_async(). Currently
src/compat_futex.c:compat_futex_async() has a 10ms delay. Would 100ms
be more acceptable ?

Thanks,

Mathieu

> 
> I applied "sed -i -e 's/futex_async/futex_noasync/'
> src/urcu-call-rcu-impl.h" and knot seems to work correctly with only
> 0.01% CPU now. I also ran tests/unit and tests/regression with default
> and signal backends and all completed successfully.
> 
> I think that the other two usages of futex_async are also a little
> suspicious, but I didn't look too closely.
> 
> Thanks,
> Alex.
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
