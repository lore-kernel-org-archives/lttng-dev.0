From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-modules] Fix: update sched
 prev_state instrumentation for kernel 4.14.0 and 4.20.0
Date: Mon, 29 Jul 2019 12:02:59 -0400 (EDT)
Message-ID: <1768002952.1933.1564416179300.JavaMail.zimbra__20155.3993205138$1564416198$gmane$org@efficios.com>
References: <20190729154657.31997-1-gabriel.pollo-guilbert@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45y4GX1Ddjz18pX
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 12:03:00 -0400 (EDT)
In-Reply-To: <20190729154657.31997-1-gabriel.pollo-guilbert@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jul 29, 2019, at 11:46 AM, Gabriel-Andrew Pollo-Guilbert gabriel.pollo-guilbert@efficios.com wrote:

> Upstream Linux kernel commit in 4.14.0:
> 
> commit efb40f588b4370ffaeffafbd50f6ff213d954254
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Fri Sep 22 18:19:53 2017 +0200
> 
>    sched/tracing: Fix trace_sched_switch task-state printing
> 
> commit 3f5fe9fef5b2da06b6319fab8123056da5217c3f
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Wed Nov 22 13:05:48 2017 +0100
> 
>    sched/debug: Fix task state recording/printout
> 
> Upstream Linux kernel commit in 4.20.0:
> 
> commit 3054426dc68e5d63aa6a6e9b91ac4ec78e3f3805
> Author: Pavankumar Kondeti <pkondeti@codeaurora.org>
> Date:   Tue Oct 30 12:24:33 2018 +0530
> 
>    sched, trace: Fix prev_state output in sched_switch tracepoint
> 
> Signed-off-by: Gabriel-Andrew Pollo-Guilbert
> <gabriel.pollo-guilbert@efficios.com>
> ---
> instrumentation/events/lttng-module/sched.h | 47 ++++++++++++++++++++-
> 1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/instrumentation/events/lttng-module/sched.h
> b/instrumentation/events/lttng-module/sched.h
> index 77d77b2..f27cee5 100644
> --- a/instrumentation/events/lttng-module/sched.h
> +++ b/instrumentation/events/lttng-module/sched.h
> @@ -25,7 +25,52 @@
> #ifndef _TRACE_SCHED_DEF_
> #define _TRACE_SCHED_DEF_
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0))
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,20,0))

You need to check where the fixes were cherry-picked into respective
stable branches. And if a Linux fix tackles a trace-event issue for a given
kernel version (e.g. 4.14.0) without changing the internal kernel APIs
available for modules, we need to cover that version (and possibly earlier
versions) for that range in lttng-modules.

For instance, v4.14.109 has:

        /*
         * Preemption ignores task state, therefore preempted tasks are always
         * RUNNING (we will not have dequeued if state != RUNNING).
         */
        if (preempt)
                return TASK_REPORT_MAX;

        /*
         * task_state_index() uses fls() and returns a value from 0-8 range.
         * Decrement it by 1 (except TASK_RUNNING state i.e 0) before using
         * it for left shift operation to get the correct task->state
         * mapping.
         */
        state = __get_task_state(p);

        return state ? (1 << (state - 1)) : state;

But lttng-modules in this patch still has broken code for that kernel version.

Thanks,

Mathieu

> +
> +static inline long __trace_sched_switch_state(bool preempt, struct task_struct
> *p)
> +{
> +        unsigned int state;
> +
> +#ifdef CONFIG_SCHED_DEBUG
> +        BUG_ON(p != current);
> +#endif /* CONFIG_SCHED_DEBUG */
> +
> +        /*
> +         * Preemption ignores task state, therefore preempted tasks are always
> +         * RUNNING (we will not have dequeued if state != RUNNING).
> +         */
> +        if (preempt)
> +                return TASK_REPORT_MAX;
> +
> +        /*
> +         * task_state_index() uses fls() and returns a value from 0-8 range.
> +         * Decrement it by 1 (except TASK_RUNNING state i.e 0) before using
> +         * it for left shift operation to get the correct task->state
> +         * mapping.
> +         */
> +        state = task_state_index(p);
> +
> +        return state ? (1 << (state - 1)) : state;
> +}
> +
> +#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0))
> +
> +static inline long __trace_sched_switch_state(bool preempt, struct task_struct
> *p)
> +{
> +#ifdef CONFIG_SCHED_DEBUG
> +	BUG_ON(p != current);
> +#endif /* CONFIG_SCHED_DEBUG */
> +	/*
> +	 * Preemption ignores task state, therefore preempted tasks are always RUNNING
> +	 * (we will not have dequeued if state != RUNNING).
> +	 */
> +        if (preempt)
> +                return TASK_REPORT_MAX;
> +
> +        return 1 << task_state_index(p);
> +}
> +
> +#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0))
> 
> static inline long __trace_sched_switch_state(bool preempt, struct task_struct
> *p)
> {
> --
> 2.22.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
