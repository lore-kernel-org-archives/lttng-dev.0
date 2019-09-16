From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules v2] Fix: update sched prev_state
 instrumentation for upstream kernel
Date: Mon, 16 Sep 2019 13:57:38 -0400
Message-ID: <20190916175738.27525-1-mjeanson__41071.5711697534$1568656708$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46XDVT6mD0zqW0
 for <lttng-dev@lists.lttng.org>; Mon, 16 Sep 2019 13:57:53 -0400 (EDT)
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

From: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>

Introduced in upstream Linux kernel 4.14.

    commit efb40f588b4370ffaeffafbd50f6ff213d954254
    Author: Peter Zijlstra <peterz@infradead.org>
    Date:   Fri Sep 22 18:19:53 2017 +0200

        sched/tracing: Fix trace_sched_switch task-state printing

Introduced in upstream Linux kernel 4.15.
Backported in 13f12749af15 (4.14.64).

    commit 3f5fe9fef5b2da06b6319fab8123056da5217c3f
    Author: Thomas Gleixner <tglx@linutronix.de>
    Date:   Wed Nov 22 13:05:48 2017 +0100

        sched/debug: Fix task state recording/printout

Introduced in upstream Linux kernel 4.20.
Backported in e1e5fa73e466 (4.14.102) and fd8152818f11 (4.19.9).

    commit 3054426dc68e5d63aa6a6e9b91ac4ec78e3f3805
    Author: Pavankumar Kondeti <pkondeti@codeaurora.org>
    Date:   Tue Oct 30 12:24:33 2018 +0530

        sched, trace: Fix prev_state output in sched_switch tracepoint

Signed-off-by: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/sched.h | 58 ++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/sched.h b/instrumentation/events/lttng-module/sched.h
index 77d77b2..a845c5f 100644
--- a/instrumentation/events/lttng-module/sched.h
+++ b/instrumentation/events/lttng-module/sched.h
@@ -25,7 +25,63 @@
 #ifndef _TRACE_SCHED_DEF_
 #define _TRACE_SCHED_DEF_
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,15,0))
+
+static inline long __trace_sched_switch_state(bool preempt, struct task_struct *p)
+{
+        unsigned int state;
+
+#ifdef CONFIG_SCHED_DEBUG
+        BUG_ON(p != current);
+#endif /* CONFIG_SCHED_DEBUG */
+
+        /*
+         * Preemption ignores task state, therefore preempted tasks are always
+         * RUNNING (we will not have dequeued if state != RUNNING).
+         */
+        if (preempt)
+                return TASK_REPORT_MAX;
+
+        /*
+         * task_state_index() uses fls() and returns a value from 0-8 range.
+         * Decrement it by 1 (except TASK_RUNNING state i.e 0) before using
+         * it for left shift operation to get the correct task->state
+         * mapping.
+         */
+        state = task_state_index(p);
+
+        return state ? (1 << (state - 1)) : state;
+}
+
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0))
+
+static inline long __trace_sched_switch_state(bool preempt, struct task_struct *p)
+{
+        unsigned int state;
+
+#ifdef CONFIG_SCHED_DEBUG
+        BUG_ON(p != current);
+#endif /* CONFIG_SCHED_DEBUG */
+
+        /*
+         * Preemption ignores task state, therefore preempted tasks are always
+         * RUNNING (we will not have dequeued if state != RUNNING).
+         */
+        if (preempt)
+                return TASK_REPORT_MAX;
+
+        /*
+         * task_state_index() uses fls() and returns a value from 0-8 range.
+         * Decrement it by 1 (except TASK_RUNNING state i.e 0) before using
+         * it for left shift operation to get the correct task->state
+         * mapping.
+         */
+        state = __get_task_state(p);
+
+        return state ? (1 << (state - 1)) : state;
+}
+
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0))
 
 static inline long __trace_sched_switch_state(bool preempt, struct task_struct *p)
 {
-- 
2.17.1
