From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] sched: Fix sched_wakeup tracepoint
Date: Tue, 9 Jun 2015 11:13:36 +0200
Message-ID: <20150609091336.GQ3644@twins.programming.kicks-ass.net>
References: <1433504509-17013-1-git-send-email-mathieu.desnoyers@efficios.com>
 <20150605120909.GG19282@twins.programming.kicks-ass.net>
 <479621151.4836.1433507522491.JavaMail.zimbra@efficios.com>
 <1433508695.1495.16.camel@twins>
 <600031664.4911.1433510581646.JavaMail.zimbra@efficios.com>
 <1433592142.1495.22.camel@twins>
 <1960877063.5553.1433672414640.JavaMail.zimbra@efficios.com>
 <20150608132735.0763ad27@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150608132735.0763ad27@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Francis Giraldeau <francis.giraldeau@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: lttng-dev@lists.lttng.org


So how about we introduce the 'waking' tracepoint and leave the existing
wakeup one in place and preserve its woken semantics.

Steven, can we do aliases? Where one tracepoint is known to userspace
under multiple names? In that case we could rename the thing to woken
and have an alias wakeup which we can phase out over time.

The patch also takes away the success parameter to the tracepoint, but
does not quite go as far as actually removing it from the tracepoint
itself.

We can do that in a follow up patch which we can quickly revert if it
turns out people are actually still using that for something.

---
 include/trace/events/sched.h | 28 ++++++++++++++++++++--------
 kernel/sched/core.c          |  9 ++++++---
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index d57a575fe31f..b1608d5679e2 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -55,7 +55,7 @@ TRACE_EVENT(sched_kthread_stop_ret,
  */
 DECLARE_EVENT_CLASS(sched_wakeup_template,
 
-	TP_PROTO(struct task_struct *p, int success),
+	TP_PROTO(struct task_struct *p),
 
 	TP_ARGS(__perf_task(p), success),
 
@@ -71,25 +71,37 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
 		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio;
-		__entry->success	= success;
+		__entry->success	= 1; /* rudiment, kill when possible */
 		__entry->target_cpu	= task_cpu(p);
 	),
 
-	TP_printk("comm=%s pid=%d prio=%d success=%d target_cpu=%03d",
+	TP_printk("comm=%s pid=%d prio=%d target_cpu=%03d",
 		  __entry->comm, __entry->pid, __entry->prio,
-		  __entry->success, __entry->target_cpu)
+		  __entry->target_cpu)
 );
 
+/*
+ * Tracepoint called when waking a task; this tracepoint is guaranteed to be
+ * called from the waking context.
+ */
+DEFINE_EVENT(sched_wakeup_template, sched_waking,
+	     TP_PROTO(struct task_struct *p),
+	     TP_ARGS(p));
+
+/*
+ * Tracepoint called when the task is actually woken; p->state == TASK_RUNNNG.
+ * It it not always called from the waking context.
+ */
 DEFINE_EVENT(sched_wakeup_template, sched_wakeup,
-	     TP_PROTO(struct task_struct *p, int success),
-	     TP_ARGS(p, success));
+	     TP_PROTO(struct task_struct *p),
+	     TP_ARGS(p));
 
 /*
  * Tracepoint for waking up a new task:
  */
 DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new,
-	     TP_PROTO(struct task_struct *p, int success),
-	     TP_ARGS(p, success));
+	     TP_PROTO(struct task_struct *p),
+	     TP_ARGS(p));
 
 #ifdef CREATE_TRACE_POINTS
 static inline long __trace_sched_switch_state(struct task_struct *p)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d5078c0f20e6..354e667620a9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1487,9 +1487,9 @@ static void
 ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags)
 {
 	check_preempt_curr(rq, p, wake_flags);
-	trace_sched_wakeup(p, true);
-
 	p->state = TASK_RUNNING;
+	trace_sched_wakeup(p);
+
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken)
 		p->sched_class->task_woken(rq, p);
@@ -1695,6 +1695,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		goto out;
 
 	success = 1; /* we're going to change ->state */
+	trace_sched_waking(p);
 	cpu = task_cpu(p);
 
 	if (p->on_rq && ttwu_remote(p, wake_flags))
@@ -1761,6 +1762,8 @@ static void try_to_wake_up_local(struct task_struct *p)
 	if (!(p->state & TASK_NORMAL))
 		goto out;
 
+	trace_sched_waking(p);
+
 	if (!task_on_rq_queued(p))
 		ttwu_activate(rq, p, ENQUEUE_WAKEUP);
 
@@ -2119,7 +2122,7 @@ void wake_up_new_task(struct task_struct *p)
 	rq = __task_rq_lock(p);
 	activate_task(rq, p, 0);
 	p->on_rq = TASK_ON_RQ_QUEUED;
-	trace_sched_wakeup_new(p, true);
+	trace_sched_wakeup_new(p);
 	check_preempt_curr(rq, p, WF_FORK);
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken)
