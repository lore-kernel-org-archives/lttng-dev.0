From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 2/2] trace: emit tracepoint in preempt and irqs off
 tracer
Date: Wed, 7 Oct 2015 02:54:09 +0000 (UTC)
Message-ID: <2024433358.21693.1444186448994.JavaMail.zimbra@efficios.com>
References: <1444175817-12425-1-git-send-email-mathieu.desnoyers@efficios.com> <1444175817-12425-2-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444175817-12425-2-git-send-email-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, lttng-dev <lttng-dev@lists.lttng.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: lttng-dev@lists.lttng.org

----- On Oct 6, 2015, at 7:56 PM, Mathieu Desnoyers mathieu.desnoyers@e=
fficios.com wrote:

> Allow Ftrace, Perf, and LTTng to hook on the irqsoff tracer and trace
> longest irqsoff and preemptoff critical sections, or those beyond a
> specified threshold.
>=20
> This requires introducing a __trace_<name>() tracepoint static inline
> which bypass static jump labels, because calling a breakpoint from th=
e
> irqsoff tracer triggers machine reboots due to recursive calls into t=
he
> tracer.

Actually, the static jump label bypass is not needed here, thanks to
data->disabled which skips nested events. I was seeing the machine
reboots in earlier attempts to add a tracepoint elsewhere in the
irqsoff tracer (before the delta checks). We should be OK with the
static jump label after all.

I'll simplify that part of the patch before resubmitting.

Thanks,

Mathieu

>=20
> How to setup the irqsoff tracer for this use-case (needed for use wit=
h
> Ftrace, Perf, or LTTng): if the tracing_thread value is set, all
> durations beyond the specified threshold will emit a tracepoint. If
> unset, then the max duration will be tracked. The current max duratio=
n
> can be reset using the tracing_max_latency file.
>=20
> echo 0 > /sys/kernel/debug/tracing/options/function-trace  # don't ne=
ed function
> tracing
> echo preemptirqsoff > /sys/kernel/debug/tracing/current_tracer
> echo 2 > /sys/kernel/debug/tracing/tracing_thresh      # set threshol=
d (e.g. 2
> =C2=B5s)
> echo 1 > /sys/kernel/debug/tracing/tracing_on
>=20
> The following two commands can also be useful to tweak the
> irqsoff tracer:
> echo 0 > /sys/kernel/debug/tracing/tracing_max_latency # reset max la=
tency
> echo 0 > /sys/kernel/debug/tracing/tracing_thresh      # disable thre=
shold
>=20
> *** An example usage of Ftrace hooking on this tracepoint: ***
>=20
> echo 1 > /sys/kernel/debug/tracing/events/core/core_critical_timing_h=
it/enable
> cat /sys/kernel/debug/tracing/trace_pipe
> [...]
>     cat-2422    1d..2 66157455us : core_critical_timing_hit: ip=3D0xf=
fffffff81101cae
>     parent_ip=3D0xffffffff818d38e7 delta_ns=3D5078 flags=3D6 preempt_=
cnt=3D0
>=20
> *** An example usage of Perf hooking on this tracepoint: ***
>=20
> perf record -g -e core:core_critical_timing_hit -c 1 sleep 30
> perf report -g
>=20
> +  100.00%   100.00%  sleep    [kernel.vmlinux]  [k] check_critical_t=
iming
> +   92.75%     0.00%  sleep    [kernel.vmlinux]  [k] preempt_count_su=
b
> +   92.75%     0.00%  sleep    [kernel.vmlinux]  [k] trace_preempt_on
> +   65.22%     0.00%  sleep    [kernel.vmlinux]  [k] page_fault
> +   65.22%     0.00%  sleep    [kernel.vmlinux]  [k] do_page_fault
> +   63.77%     0.00%  sleep    [kernel.vmlinux]  [k] __do_page_fault
> +   63.77%     0.00%  sleep    [kernel.vmlinux]  [k] handle_mm_fault
> +   56.52%     0.00%  sleep    [kernel.vmlinux]  [k] _raw_spin_unlock
> +   30.43%     0.00%  sleep    ld-2.19.so        [.] _dl_sysdep_start
> [...]
>=20
> *** An example usage of LTTng hooking on this tracepoint: ***
>=20
> (as root)
> lttng-sessiond -d
>=20
> (then, as root or tracing group)
> lttng create --live
> lttng enable-event -k 'core_*'
> lttng start
> lttng view
> [...]
> [17:34:17.090669588] (+1.569689755) compudjdev core_critical_timing_h=
it: {
> cpu_id =3D 3 }, { ip =3D 0xFFFFFFFF81102135, parent_ip =3D 0xFFFFFFFF=
A0798E13,
> delta_ns =3D 252994, irqs_disabled =3D 0, preempt_disabled =3D 1, in_=
softirq =3D 0,
> in_irq =3D 0, in_nmi =3D 0 }
>=20
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> ---
> include/linux/tracepoint.h   | 41 +++++++++++++++++++++++++++++-----
> include/trace/events/core.h  | 52 +++++++++++++++++++++++++++++++++++=
+++++++++
> kernel/trace/trace_irqsoff.c |  6 +++++
> 3 files changed, 94 insertions(+), 5 deletions(-)
> create mode 100644 include/trace/events/core.h
>=20
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index c8e3030..17f5a47 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -95,6 +95,23 @@ extern void syscall_unregfunc(void);
>=20
> #define TRACE_DEFINE_ENUM(x)
>=20
> +#ifdef CONFIG_LOCKDEP
> +static inline void check_trace_lockdep_rcu(struct tracepoint_func __=
rcu *funcs,
> +		int condition)
> +{
> +	if (!condition)
> +		return;
> +	rcu_read_lock_sched_notrace();
> +	rcu_dereference_sched(funcs);
> +	rcu_read_unlock_sched_notrace();
> +}
> +#else
> +static inline void check_trace_lockdep_rcu(struct tracepoint_func __=
rcu *funcs,
> +		int condition)
> +{
> +}
> +#endif
> +
> #endif /* _LINUX_TRACEPOINT_H */
>=20
> /*
> @@ -172,6 +189,11 @@ extern void syscall_unregfunc(void);
>  * instrumentation. This lets us find RCU issues triggered with trace=
points
>  * even when this tracepoint is off. This code has no purpose other t=
han
>  * poking RCU a bit.
> + *
> + * trace_<name>() should usually be used for instrumentation.
> + *
> + * __trace_<name>() can be used in core instrumentation where recurs=
ion into
> + * the breakpoint handler is unwanted.
>  */
> #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_arg=
s) \
> 	extern struct tracepoint __tracepoint_##name;			\
> @@ -182,11 +204,18 @@ extern void syscall_unregfunc(void);
> 				TP_PROTO(data_proto),			\
> 				TP_ARGS(data_args),			\
> 				TP_CONDITION(cond),,);			\
> -		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> -			rcu_read_lock_sched_notrace();			\
> -			rcu_dereference_sched(__tracepoint_##name.funcs);\
> -			rcu_read_unlock_sched_notrace();		\
> -		}							\
> +		check_trace_lockdep_rcu(__tracepoint_##name.funcs,	\
> +			TP_CONDITION(cond));				\
> +	}								\
> +	static inline void __trace_##name(proto)			\
> +	{								\
> +		if (static_key_enabled(&__tracepoint_##name.key))	\
> +			__DO_TRACE(&__tracepoint_##name,		\
> +				TP_PROTO(data_proto),			\
> +				TP_ARGS(data_args),			\
> +				TP_CONDITION(cond),,);			\
> +		check_trace_lockdep_rcu(__tracepoint_##name.funcs,	\
> +			TP_CONDITION(cond));				\
> 	}								\
> 	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
> 		PARAMS(cond), PARAMS(data_proto), PARAMS(data_args))	\
> @@ -239,6 +268,8 @@ extern void syscall_unregfunc(void);
> #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_arg=
s) \
> 	static inline void trace_##name(proto)				\
> 	{ }								\
> +	static inline void __trace_##name(proto)			\
> +	{ }								\
> 	static inline void trace_##name##_rcuidle(proto)		\
> 	{ }								\
> 	static inline int						\
> diff --git a/include/trace/events/core.h b/include/trace/events/core.=
h
> new file mode 100644
> index 0000000..b2c130c
> --- /dev/null
> +++ b/include/trace/events/core.h
> @@ -0,0 +1,52 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM core
> +
> +#if !defined(_TRACE_CORE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_CORE_H
> +
> +#include <linux/tracepoint.h>
> +
> +/*
> + * Tracepoint for critical timings.
> + */
> +DECLARE_EVENT_CLASS(core_critical_timing,
> +
> +	TP_PROTO(unsigned long ip, unsigned long parent_ip,
> +			unsigned long flags, int preempt_cnt,
> +			cycles_t delta_ns),
> +
> +	TP_ARGS(ip, parent_ip, flags, preempt_cnt, delta_ns),
> +
> +	TP_STRUCT__entry(
> +		__field(	unsigned long, ip		)
> +		__field(	unsigned long, parent_ip	)
> +		__field(	cycles_t, delta_ns		)
> +		__field(	unsigned long, flags		)
> +		__field(	int, preempt_cnt		)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->ip		=3D ip;
> +		__entry->parent_ip	=3D parent_ip;
> +		__entry->delta_ns	=3D delta_ns;
> +		__entry->flags		=3D flags;
> +		__entry->preempt_cnt	=3D preempt_cnt;
> +	),
> +
> +	TP_printk("ip=3D0x%lx parent_ip=3D0x%lx delta_ns=3D%llu flags=3D%lu=
 preempt_cnt=3D%d",
> +		  __entry->ip, __entry->parent_ip,
> +		  (unsigned long long) __entry->delta_ns,
> +		  __entry->flags,  __entry->preempt_cnt)
> +);
> +
> +DEFINE_EVENT(core_critical_timing, core_critical_timing_hit,
> +	TP_PROTO(unsigned long ip, unsigned long parent_ip,
> +		unsigned long flags, int preempt_cnt,
> +		cycles_t delta_ns),
> +	TP_ARGS(ip, parent_ip, flags, preempt_cnt, delta_ns)
> +);
> +
> +#endif /* _TRACE_CORE_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsof=
f.c
> index 8523ea3..fad8949 100644
> --- a/kernel/trace/trace_irqsoff.c
> +++ b/kernel/trace/trace_irqsoff.c
> @@ -14,6 +14,9 @@
> #include <linux/module.h>
> #include <linux/ftrace.h>
>=20
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/core.h>
> +
> #include "trace.h"
>=20
> static struct trace_array		*irqsoff_trace __read_mostly;
> @@ -338,6 +341,9 @@ check_critical_timing(struct trace_array *tr,
> 	/* Skip 5 functions to get to the irq/preempt enable function */
> 	__trace_stack(tr, flags, 5, pc);
>=20
> +	__trace_core_critical_timing_hit(CALLER_ADDR0, parent_ip, flags, pc=
,
> +			delta);
> +
> 	if (data->critical_sequence !=3D max_sequence)
> 		goto out_unlock;
>=20
> --
> 2.1.4

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
