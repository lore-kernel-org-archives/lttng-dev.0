From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH v2 3/3] trace: emit tracepoint in preempt and irqs off tracer
Date: Wed,  7 Oct 2015 06:39:20 -0400
Message-ID: <1444214360-16708-3-git-send-email-mathieu.desnoyers@efficios.com>
References: <1444214360-16708-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444214360-16708-1-git-send-email-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: lttng-dev@lists.lttng.org

Allow Ftrace, Perf, and LTTng to hook on the irqsoff tracer and trace
irqsoff and preemptoff critical sections.

How to setup the irqsoff tracer for this use-case (needed for use with
=46trace, Perf, or LTTng): if the tracing_thresh value is set, all
durations beyond the specified threshold will emit a
"core_critical_timing_hit" tracepoint. If unset, then the max duration
will be tracked. The current max duration can be reset using the
tracing_max_latency file.

echo 0 > /sys/kernel/debug/tracing/options/function-trace  # don't need=
 function tracing
echo 0 > /sys/kernel/debug/tracing/options/ftrace-buffer
echo preemptirqsoff > /sys/kernel/debug/tracing/current_tracer
echo 2 > /sys/kernel/debug/tracing/tracing_thresh      # set threshold =
(e.g. 2 =C2=B5s)
echo 1 > /sys/kernel/debug/tracing/tracing_on

The following two commands can also be useful to tweak the
irqsoff tracer:
echo 0 > /sys/kernel/debug/tracing/tracing_max_latency # reset max late=
ncy
echo 0 > /sys/kernel/debug/tracing/tracing_thresh      # disable thresh=
old

*** An example usage of Ftrace hooking on this tracepoint: ***

echo 1 > /sys/kernel/debug/tracing/events/core/core_critical_timing_hit=
/enable
cat /sys/kernel/debug/tracing/trace_pipe
[...]
    bash-2380   19d..3 52794942us : core_critical_timing_hit: ip=3D0xff=
ffffff811021de parent_ip=3D0xffffffff818d1b17 delta_ns=3D3402 irqs_disa=
bled=3D0 preempt_disabled=3D1 in_softirq=3D0 in_irq=3D0 in_nmi=3D0

*** An example usage of Perf hooking on this tracepoint: ***

perf record -g -e core:core_critical_timing_hit -c 1 sleep 30
perf report -g

+  100.00%   100.00%  sleep    [kernel.vmlinux]  [k] check_critical_tim=
ing
+   92.75%     0.00%  sleep    [kernel.vmlinux]  [k] preempt_count_sub
+   92.75%     0.00%  sleep    [kernel.vmlinux]  [k] trace_preempt_on
+   65.22%     0.00%  sleep    [kernel.vmlinux]  [k] page_fault
+   65.22%     0.00%  sleep    [kernel.vmlinux]  [k] do_page_fault
+   63.77%     0.00%  sleep    [kernel.vmlinux]  [k] __do_page_fault
+   63.77%     0.00%  sleep    [kernel.vmlinux]  [k] handle_mm_fault
+   56.52%     0.00%  sleep    [kernel.vmlinux]  [k] _raw_spin_unlock
+   30.43%     0.00%  sleep    ld-2.19.so        [.] _dl_sysdep_start
[...]

*** An example usage of LTTng hooking on this tracepoint: ***

(as root)
lttng-sessiond -d

(then, as root or tracing group)
lttng create --live
lttng enable-event -k core_critical_timing_hit
lttng start
lttng view
[...]
[17:34:17.090669588] (+1.569689755) compudjdev core_critical_timing_hit=
: { cpu_id =3D 3 }, { ip =3D 0xFFFFFFFF81102135, parent_ip =3D 0xFFFFFF=
=46FA0798E13, delta_ns =3D 252994, irqs_disabled =3D 0, preempt_disable=
d =3D 1, in_softirq =3D 0, in_irq =3D 0, in_nmi =3D 0 }

Tracepoints core_critical_timing_start and core_critical_timing_stop ar=
e
also available. They trigger at a much higher rate than
core_critical_timing_hit.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
---
Changes since v1:
- Remove unneeded tracepoint jump label bypass.
- Enhance TP_printk() formatting.
- Use new ftrace-buffer option in changelog.
- Add core_critical_timing_start/stop tracepoints.
---
 include/trace/events/core.h  | 96 ++++++++++++++++++++++++++++++++++++=
++++++++
 kernel/trace/trace_irqsoff.c | 17 ++++++--
 2 files changed, 109 insertions(+), 4 deletions(-)
 create mode 100644 include/trace/events/core.h

diff --git a/include/trace/events/core.h b/include/trace/events/core.h
new file mode 100644
index 0000000..ccc3430
--- /dev/null
+++ b/include/trace/events/core.h
@@ -0,0 +1,96 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM core
+
+#if !defined(_TRACE_CORE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_CORE_H
+
+#include <linux/tracepoint.h>
+#include <linux/irqflags.h>
+#include <linux/preempt.h>
+
+/*
+ * Tracepoint for critical timings max/threshold hit.
+ */
+TRACE_EVENT(core_critical_timing_hit,
+
+	TP_PROTO(unsigned long ip, unsigned long parent_ip,
+			unsigned long flags, int preempt_cnt,
+			cycles_t delta_ns),
+
+	TP_ARGS(ip, parent_ip, flags, preempt_cnt, delta_ns),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long, ip		)
+		__field(	unsigned long, parent_ip	)
+		__field(	cycles_t, delta_ns		)
+		__field(	unsigned long, flags		)
+		__field(	int, preempt_cnt		)
+	),
+
+	TP_fast_assign(
+		__entry->ip		=3D ip;
+		__entry->parent_ip	=3D parent_ip;
+		__entry->delta_ns	=3D delta_ns;
+		__entry->flags		=3D flags;
+		__entry->preempt_cnt	=3D preempt_cnt;
+	),
+
+	TP_printk("ip=3D0x%lx parent_ip=3D0x%lx delta_ns=3D%llu irqs_disabled=
=3D%u preempt_disabled=3D%u in_softirq=3D%u in_irq=3D%u in_nmi=3D%u",
+		  __entry->ip, __entry->parent_ip,
+		  (unsigned long long) __entry->delta_ns,
+		  !!raw_irqs_disabled_flags(__entry->flags),
+		  !!(__entry->preempt_cnt & PREEMPT_MASK),
+		  !!(__entry->preempt_cnt & SOFTIRQ_MASK),
+		  !!(__entry->preempt_cnt & HARDIRQ_MASK),
+		  !!(__entry->preempt_cnt & NMI_MASK))
+);
+
+/*
+ * Tracepoint for critical timings start/stop.
+ */
+DECLARE_EVENT_CLASS(core_critical_timing,
+
+	TP_PROTO(unsigned long ip, unsigned long parent_ip,
+			unsigned long flags, int preempt_cnt),
+
+	TP_ARGS(ip, parent_ip, flags, preempt_cnt),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long, ip		)
+		__field(	unsigned long, parent_ip	)
+		__field(	unsigned long, flags		)
+		__field(	int, preempt_cnt		)
+	),
+
+	TP_fast_assign(
+		__entry->ip		=3D ip;
+		__entry->parent_ip	=3D parent_ip;
+		__entry->flags		=3D flags;
+		__entry->preempt_cnt	=3D preempt_cnt;
+	),
+
+	TP_printk("ip=3D0x%lx parent_ip=3D0x%lx irqs_disabled=3D%u preempt_di=
sabled=3D%u in_softirq=3D%u in_irq=3D%u in_nmi=3D%u",
+		  __entry->ip, __entry->parent_ip,
+		  !!raw_irqs_disabled_flags(__entry->flags),
+		  !!(__entry->preempt_cnt & PREEMPT_MASK),
+		  !!(__entry->preempt_cnt & SOFTIRQ_MASK),
+		  !!(__entry->preempt_cnt & HARDIRQ_MASK),
+		  !!(__entry->preempt_cnt & NMI_MASK))
+);
+
+DEFINE_EVENT(core_critical_timing, core_critical_timing_start,
+	TP_PROTO(unsigned long ip, unsigned long parent_ip,
+		unsigned long flags, int preempt_cnt),
+	TP_ARGS(ip, parent_ip, flags, preempt_cnt)
+);
+
+DEFINE_EVENT(core_critical_timing, core_critical_timing_stop,
+	TP_PROTO(unsigned long ip, unsigned long parent_ip,
+		unsigned long flags, int preempt_cnt),
+	TP_ARGS(ip, parent_ip, flags, preempt_cnt)
+);
+
+#endif /* _TRACE_CORE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.=
c
index 3e5635d..abfb77e 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -14,6 +14,9 @@
 #include <linux/module.h>
 #include <linux/ftrace.h>
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/core.h>
+
 #include "trace.h"
=20
 static struct trace_array		*irqsoff_trace __read_mostly;
@@ -339,6 +342,8 @@ check_critical_timing(struct trace_array *tr,
 		/* Skip 5 functions to get to the irq/preempt enable function */
 		__trace_stack(tr, flags, 5, pc);
 	}
+	trace_core_critical_timing_hit(CALLER_ADDR0, parent_ip, flags, pc,
+			delta);
=20
 	if (data->critical_sequence !=3D max_sequence)
 		goto out_unlock;
@@ -365,7 +370,7 @@ out:
 static inline void
 start_critical_timing(unsigned long ip, unsigned long parent_ip)
 {
-	int cpu;
+	int cpu, pc;
 	struct trace_array *tr =3D irqsoff_trace;
 	struct trace_array_cpu *data;
 	unsigned long flags;
@@ -390,8 +395,10 @@ start_critical_timing(unsigned long ip, unsigned l=
ong parent_ip)
 	data->critical_start =3D parent_ip ? : ip;
=20
 	local_save_flags(flags);
+	pc =3D preempt_count();
 	if (trace_flags & TRACE_ITER_FTRACE_BUFFER)
-		__trace_function(tr, ip, parent_ip, flags, preempt_count());
+		__trace_function(tr, ip, parent_ip, flags, pc);
+	trace_core_critical_timing_start(ip, parent_ip, flags, pc);
 	per_cpu(tracing_cpu, cpu) =3D 1;
=20
 	atomic_dec(&data->disabled);
@@ -400,7 +407,7 @@ start_critical_timing(unsigned long ip, unsigned lo=
ng parent_ip)
 static inline void
 stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 {
-	int cpu;
+	int cpu, pc;
 	struct trace_array *tr =3D irqsoff_trace;
 	struct trace_array_cpu *data;
 	unsigned long flags;
@@ -424,8 +431,10 @@ stop_critical_timing(unsigned long ip, unsigned lo=
ng parent_ip)
 	atomic_inc(&data->disabled);
=20
 	local_save_flags(flags);
+	pc =3D preempt_count();
 	if (trace_flags & TRACE_ITER_FTRACE_BUFFER)
-		__trace_function(tr, ip, parent_ip, flags, preempt_count());
+		__trace_function(tr, ip, parent_ip, flags, pc);
+	trace_core_critical_timing_stop(ip, parent_ip, flags, pc);
 	check_critical_timing(tr, data, parent_ip ? : ip, cpu);
 	data->critical_start =3D 0;
 	atomic_dec(&data->disabled);
--=20
2.1.4
