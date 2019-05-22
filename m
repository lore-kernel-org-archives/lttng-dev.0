From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 1/5] fix: timer/trace: Improve
 timer tracing (v5.2)
Date: Wed, 22 May 2019 11:37:37 -0400 (EDT)
Message-ID: <1938745462.7459.1558539457112.JavaMail.zimbra__41434.7578001738$1558539475$gmane$org@efficios.com>
References: <20190521203314.8577-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 458Gwf1n3jzyVy
 for <lttng-dev@lists.lttng.org>; Wed, 22 May 2019 11:37:38 -0400 (EDT)
In-Reply-To: <20190521203314.8577-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

All merged into lttng-modules master, 2.11, 2.10, 2.9 branches.

I updated the field names for patch 4/5 as discussed.

Thanks,

Mathieu

----- On May 21, 2019, at 4:33 PM, Michael Jeanson mjeanson@efficios.com wrote:

> See upstream commit:
> 
>  commit f28d3d5346e97e60c81f933ac89ccf015430e5cf
>  Author: Anna-Maria Gleixner <anna-maria@linutronix.de>
>  Date:   Thu Mar 21 13:09:21 2019 +0100
> 
>    timer/trace: Improve timer tracing
> 
>    Timers are added to the timer wheel off by one. This is required in
>    case a timer is queued directly before incrementing jiffies to prevent
>    early timer expiry.
> 
>    When reading a timer trace and relying only on the expiry time of the timer
>    in the timer_start trace point and on the now in the timer_expiry_entry
>    trace point, it seems that the timer fires late. With the current
>    timer_expiry_entry trace point information only now=jiffies is printed but
>    not the value of base->clk. This makes it impossible to draw a conclusion
>    to the index of base->clk and makes it impossible to examine timer problems
>    without additional trace points.
> 
>    Therefore add the base->clk value to the timer_expire_entry trace
>    point, to be able to calculate the index the timer base is located at
>    during collecting expired timers.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> instrumentation/events/lttng-module/timer.h | 22 +++++++++++++++++++++
> 1 file changed, 22 insertions(+)
> 
> diff --git a/instrumentation/events/lttng-module/timer.h
> b/instrumentation/events/lttng-module/timer.h
> index 8703ea0..997084f 100644
> --- a/instrumentation/events/lttng-module/timer.h
> +++ b/instrumentation/events/lttng-module/timer.h
> @@ -89,6 +89,27 @@ LTTNG_TRACEPOINT_EVENT(timer_start,
> )
> #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0)) */
> 
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0))
> +/**
> + * timer_expire_entry - called immediately before the timer callback
> + * @timer:	pointer to struct timer_list
> + *
> + * Allows to determine the timer latency.
> + */
> +LTTNG_TRACEPOINT_EVENT(timer_expire_entry,
> +
> +	TP_PROTO(struct timer_list *timer, unsigned long baseclk),
> +
> +	TP_ARGS(timer, baseclk),
> +
> +	TP_FIELDS(
> +		ctf_integer_hex(void *, timer, timer)
> +		ctf_integer(unsigned long, now, jiffies)
> +		ctf_integer_hex(void *, function, timer->function)
> +		ctf_integer(unsigned long, baseclk, baseclk)
> +	)
> +)
> +#else
> /**
>  * timer_expire_entry - called immediately before the timer callback
>  * @timer:	pointer to struct timer_list
> @@ -107,6 +128,7 @@ LTTNG_TRACEPOINT_EVENT(timer_expire_entry,
> 		ctf_integer_hex(void *, function, timer->function)
> 	)
> )
> +#endif
> 
> /**
>  * timer_expire_exit - called immediately after the timer callback returns
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
