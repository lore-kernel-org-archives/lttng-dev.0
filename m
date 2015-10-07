From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 2/3] ftrace: add ftrace-buffer option
Date: Wed,  7 Oct 2015 06:39:19 -0400
Message-ID: <1444214360-16708-2-git-send-email-mathieu.desnoyers@efficios.com>
References: <1444214360-16708-1-git-send-email-mathieu.desnoyers@efficios.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444214360-16708-1-git-send-email-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: lttng-dev@lists.lttng.org

In order to use ftrace tracers to generate tracepoints without doing
tracing to its own hardcoded ring buffers, add a ftrace-buffer option
(default: 1). When set to 0, it disables tracing into the ftrace
hardcoded buffers.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
---
 kernel/trace/trace.c         |  4 +++-
 kernel/trace/trace.h         |  1 +
 kernel/trace/trace_irqsoff.c | 19 +++++++++++--------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6e79408..d664f0e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -472,7 +472,8 @@ static inline void trace_access_lock_init(void)
 unsigned long trace_flags = TRACE_ITER_PRINT_PARENT | TRACE_ITER_PRINTK |
 	TRACE_ITER_ANNOTATE | TRACE_ITER_CONTEXT_INFO | TRACE_ITER_SLEEP_TIME |
 	TRACE_ITER_GRAPH_TIME | TRACE_ITER_RECORD_CMD | TRACE_ITER_OVERWRITE |
-	TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS | TRACE_ITER_FUNCTION;
+	TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS | TRACE_ITER_FUNCTION |
+	TRACE_ITER_FTRACE_BUFFER;
 
 static void tracer_tracing_on(struct trace_array *tr)
 {
@@ -862,6 +863,7 @@ static const char *trace_options[] = {
 	"irq-info",
 	"markers",
 	"function-trace",
+	"ftrace-buffer",
 	NULL
 };
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 74bde81..29968e1 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -930,6 +930,7 @@ enum trace_iterator_flags {
 	TRACE_ITER_IRQ_INFO		= 0x800000,
 	TRACE_ITER_MARKERS		= 0x1000000,
 	TRACE_ITER_FUNCTION		= 0x2000000,
+	TRACE_ITER_FTRACE_BUFFER	= 0x4000000,
 };
 
 /*
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 8523ea3..3e5635d 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -334,9 +334,11 @@ check_critical_timing(struct trace_array *tr,
 	if (!report_latency(tr, delta))
 		goto out_unlock;
 
-	__trace_function(tr, CALLER_ADDR0, parent_ip, flags, pc);
-	/* Skip 5 functions to get to the irq/preempt enable function */
-	__trace_stack(tr, flags, 5, pc);
+	if (trace_flags & TRACE_ITER_FTRACE_BUFFER) {
+		__trace_function(tr, CALLER_ADDR0, parent_ip, flags, pc);
+		/* Skip 5 functions to get to the irq/preempt enable function */
+		__trace_stack(tr, flags, 5, pc);
+	}
 
 	if (data->critical_sequence != max_sequence)
 		goto out_unlock;
@@ -356,7 +358,8 @@ out_unlock:
 out:
 	data->critical_sequence = max_sequence;
 	data->preempt_timestamp = ftrace_now(cpu);
-	__trace_function(tr, CALLER_ADDR0, parent_ip, flags, pc);
+	if (trace_flags & TRACE_ITER_FTRACE_BUFFER)
+		__trace_function(tr, CALLER_ADDR0, parent_ip, flags, pc);
 }
 
 static inline void
@@ -387,9 +390,8 @@ start_critical_timing(unsigned long ip, unsigned long parent_ip)
 	data->critical_start = parent_ip ? : ip;
 
 	local_save_flags(flags);
-
-	__trace_function(tr, ip, parent_ip, flags, preempt_count());
-
+	if (trace_flags & TRACE_ITER_FTRACE_BUFFER)
+		__trace_function(tr, ip, parent_ip, flags, preempt_count());
 	per_cpu(tracing_cpu, cpu) = 1;
 
 	atomic_dec(&data->disabled);
@@ -422,7 +424,8 @@ stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 	atomic_inc(&data->disabled);
 
 	local_save_flags(flags);
-	__trace_function(tr, ip, parent_ip, flags, preempt_count());
+	if (trace_flags & TRACE_ITER_FTRACE_BUFFER)
+		__trace_function(tr, ip, parent_ip, flags, preempt_count());
 	check_critical_timing(tr, data, parent_ip ? : ip, cpu);
 	data->critical_start = 0;
 	atomic_dec(&data->disabled);
-- 
2.1.4
