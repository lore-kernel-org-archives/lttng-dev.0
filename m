From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 25/30] Drop support for
 kernels < 3.0 from sched instrumentation
Date: Thu,  8 Nov 2018 16:45:30 -0500
Message-ID: <20181108214535.12081-25-mjeanson__27914.1201907352$1541713780$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKn4DhrzqHL
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:05 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 8E32A24AF06
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:05 -0500 (EST)
In-Reply-To: <20181108214535.12081-1-mjeanson@efficios.com>
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/sched.h | 68 +++------------------
 1 file changed, 7 insertions(+), 61 deletions(-)

diff --git a/instrumentation/events/lttng-module/sched.h b/instrumentation/events/lttng-module/sched.h
index 550ce2f..77d77b2 100644
--- a/instrumentation/events/lttng-module/sched.h
+++ b/instrumentation/events/lttng-module/sched.h
@@ -93,7 +93,7 @@ static inline long __trace_sched_switch_state(struct task_struct *p)
 	return state;
 }
 
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
+#else
 
 static inline long __trace_sched_switch_state(struct task_struct *p)
 {
@@ -170,24 +170,16 @@ LTTNG_TRACEPOINT_EVENT_CLASS(sched_wakeup_template,
 #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)) */
 LTTNG_TRACEPOINT_EVENT_CLASS(sched_wakeup_template,
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
 	TP_PROTO(struct task_struct *p, int success),
 
 	TP_ARGS(p, success),
-#else
-	TP_PROTO(struct rq *rq, struct task_struct *p, int success),
-
-	TP_ARGS(rq, p, success),
-#endif
 
 	TP_FIELDS(
 		ctf_array_text(char, comm, p->comm, TASK_COMM_LEN)
 		ctf_integer(pid_t, tid, p->pid)
 		ctf_integer(int, prio, p->prio - MAX_RT_PRIO)
 		ctf_integer(int, success, success)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
 		ctf_integer(int, target_cpu, task_cpu(p))
-#endif
 	)
 )
 #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)) */
@@ -224,7 +216,7 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_wakeup_template, sched_wakeup_new,
 	     TP_PROTO(struct task_struct *p),
 	     TP_ARGS(p))
 
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
+#else
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_wakeup_template, sched_wakeup,
 	     TP_PROTO(struct task_struct *p, int success),
@@ -237,20 +229,7 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_wakeup_template, sched_wakeup_new,
 	     TP_PROTO(struct task_struct *p, int success),
 	     TP_ARGS(p, success))
 
-#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
-
-LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_wakeup_template, sched_wakeup,
-	     TP_PROTO(struct rq *rq, struct task_struct *p, int success),
-	     TP_ARGS(rq, p, success))
-
-/*
- * Tracepoint for waking up a new task:
- */
-LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_wakeup_template, sched_wakeup_new,
-	     TP_PROTO(struct rq *rq, struct task_struct *p, int success),
-	     TP_ARGS(rq, p, success))
-
-#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
+#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)) */
 
 /*
  * Tracepoint for task switches, performed by the scheduler:
@@ -263,17 +242,12 @@ LTTNG_TRACEPOINT_EVENT(sched_switch,
 		 struct task_struct *next),
 
 	TP_ARGS(preempt, prev, next),
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
+#else
 	TP_PROTO(struct task_struct *prev,
 		 struct task_struct *next),
 
 	TP_ARGS(prev, next),
-#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
-	TP_PROTO(struct rq *rq, struct task_struct *prev,
-		 struct task_struct *next),
-
-	TP_ARGS(rq, prev, next),
-#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
+#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)) */
 
 	TP_FIELDS(
 		ctf_array_text(char, prev_comm,	prev->comm, TASK_COMM_LEN)
@@ -281,10 +255,8 @@ LTTNG_TRACEPOINT_EVENT(sched_switch,
 		ctf_integer(int, prev_prio, prev->prio - MAX_RT_PRIO)
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0))
 		ctf_integer(long, prev_state, __trace_sched_switch_state(preempt, prev))
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
-		ctf_integer(long, prev_state, __trace_sched_switch_state(prev))
 #else
-		ctf_integer(long, prev_state, prev->state)
+		ctf_integer(long, prev_state, __trace_sched_switch_state(prev))
 #endif
 		ctf_array_text(char, next_comm, next->comm, TASK_COMM_LEN)
 		ctf_integer(pid_t, next_tid, next->pid)
@@ -341,15 +313,9 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_process_template, sched_process_exit,
 /*
  * Tracepoint for waiting on task to unschedule:
  */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
 LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_process_template, sched_wait_task,
 	TP_PROTO(struct task_struct *p),
 	TP_ARGS(p))
-#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
-LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_process_template, sched_wait_task,
-	TP_PROTO(struct rq *rq, struct task_struct *p),
-	TP_ARGS(rq, p))
-#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
 
 /*
  * Tracepoint for a waiting task:
@@ -445,24 +411,6 @@ LTTNG_TRACEPOINT_EVENT_CODE(sched_process_fork,
 	TP_code_post()
 )
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33))
-/*
- * Tracepoint for sending a signal:
- */
-LTTNG_TRACEPOINT_EVENT(sched_signal_send,
-
-	TP_PROTO(int sig, struct task_struct *p),
-
-	TP_ARGS(sig, p),
-
-	TP_FIELDS(
-		ctf_integer(int, sig, sig)
-		ctf_array_text(char, comm, p->comm, TASK_COMM_LEN)
-		ctf_integer(pid_t, tid, p->pid)
-	)
-)
-#endif
-
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
 /*
  * Tracepoint for exec:
@@ -482,7 +430,6 @@ LTTNG_TRACEPOINT_EVENT(sched_process_exec,
 )
 #endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
 /*
  * XXX the below sched_stat tracepoints only apply to SCHED_OTHER/BATCH/IDLE
  *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
@@ -551,7 +498,6 @@ LTTNG_TRACEPOINT_EVENT(sched_stat_runtime,
 		ctf_integer(u64, vruntime, vruntime)
 	)
 )
-#endif
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,12,0) || \
 	LTTNG_RT_KERNEL_RANGE(4,9,27,18, 4,10,0,0) || \
@@ -573,7 +519,7 @@ LTTNG_TRACEPOINT_EVENT(sched_pi_setprio,
 		ctf_integer(int, newprio, pi_task ? pi_task->prio - MAX_RT_PRIO : tsk->prio - MAX_RT_PRIO)
 	)
 )
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
+#else
 /*
  * Tracepoint for showing priority inheritance modifying a tasks
  * priority.
-- 
2.17.1
