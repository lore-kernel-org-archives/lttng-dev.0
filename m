From: Alex Xu via lttng-dev <lttng-dev@lists.lttng.org>
Subject: call_rcu seems inefficient without futex
Date: Fri, 24 Jan 2020 00:19:03 +0000
Message-ID: <157982514329.691.6168767011604689030@pink>
References: <157982514329.691.6168767011604689030.ref@pink>
Reply-To: Alex Xu <alex_y_xu@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic317-21.consmr.mail.gq1.yahoo.com
 (sonic317-21.consmr.mail.gq1.yahoo.com [98.137.66.147])
 by lists.lttng.org (Postfix) with ESMTPS id 483frw0KNLz1sTd
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jan 2020 19:19:10 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

I recently installed knot dns for a very small FreeBSD server. I noticed
that it uses a surprising amount of CPU, even when there is no load:
about 0.25%. That's not huge, but it seems unnecessarily high when my
QPS is less than 0.01.

After some profiling, I came to the conclusion that this is caused by
call_rcu_wait using futex_async to repeatedly wait. Since there is no
futex on FreeBSD (without the Linux compatibility layer), this
effectively turns into a permanent busy waiting loop.

I think futex_noasync can be used here instead. call_rcu_wait is only
supposed to be called from call_rcu_thread, never from a signal context.
call_rcu calls get_call_rcu_data, which may call
get_default_call_rcu_data, which calls pthread_mutex_lock through
call_rcu_lock. Therefore, call_rcu is not async-signal-safe already.
Also, I think it only makes sense to use call_rcu around a RCU write,
which contradicts the README saying that only RCU reads are allowed in
signal handlers.

I applied "sed -i -e 's/futex_async/futex_noasync/'
src/urcu-call-rcu-impl.h" and knot seems to work correctly with only
0.01% CPU now. I also ran tests/unit and tests/regression with default
and signal backends and all completed successfully.

I think that the other two usages of futex_async are also a little
suspicious, but I didn't look too closely.

Thanks,
Alex.
