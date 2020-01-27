From: Alex Xu via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: call_rcu seems inefficient without futex
Date: Mon, 27 Jan 2020 18:25:04 +0000
Message-ID: <158014950427.63624.9193392146451473928@pink>
References: <157982514329.691.6168767011604689030.ref@pink>
 <157982514329.691.6168767011604689030@pink>
 <77660372.600081.1580139485777.JavaMail.zimbra@efficios.com>
Reply-To: Alex Xu <alex_y_xu@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic312-24.consmr.mail.gq1.yahoo.com
 (sonic312-24.consmr.mail.gq1.yahoo.com [98.137.69.205])
 by lists.lttng.org (Postfix) with ESMTPS id 485ypX4Bvwz1xLy
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jan 2020 13:25:08 -0500 (EST)
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
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Quoting Mathieu Desnoyers (2020-01-27 15:38:05)
> ----- On Jan 23, 2020, at 7:19 PM, lttng-dev lttng-dev@lists.lttng.org wrote:
> call_rcu() is meant to be async-signal-safe and lock-free after that
> initialization has been performed on first use. Paul, do you know where
> we have documented this in liburcu ?

Hm... reading it a little more carefully, it does seem that as long as
you manually initialize it, then it is async-signal-safe afterwards.

> > Also, I think it only makes sense to use call_rcu around a RCU write,
> > which contradicts the README saying that only RCU reads are allowed in
> > signal handlers.
> 
> Not sure what you mean by "use call_rcu around a RCU write" ?

I mean that in general, the pattern is usually to do an RCU write (to
remove an item from a list, for example), then do call_rcu to
aynchronously clean up the item.

> Is there anything similar to sys_futex on FreeBSD ?

Doing some more research, it seems that _umtx_op is allowed to be used
by userspace applications, see
https://patchwork.freedesktop.org/patch/200456/.

So we can probably just use that. I'll send a patch shortly.

> It would be good to look into alternative ways to fix this that do not
> involve changing the guarantees provided by call_rcu() for that fallback
> scenario (no futex available). Perhaps in your use-case you may want to
> tweak the retry delay for compat_futex_async(). Currently
> src/compat_futex.c:compat_futex_async() has a 10ms delay. Would 100ms
> be more acceptable ?

I don't completely understand what poll does here. Does it just mean
that call_rcu callbacks would be delayed up to 100 ms? That's probably
OK for cleanup uses, but I guess other uses may need faster reactions.
