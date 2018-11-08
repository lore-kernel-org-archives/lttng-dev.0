From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 28/30] Drop support for
 kernels < 3.0 from workqueue instrumentation
Date: Thu,  8 Nov 2018 16:45:33 -0500
Message-ID: <20181108214535.12081-28-mjeanson__16354.3254988783$1541713816$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKq4nPDzqJX
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:07 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 5612724AF3C
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:07 -0500 (EST)
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
 .../events/lttng-module/workqueue.h           | 61 -------------------
 1 file changed, 61 deletions(-)

diff --git a/instrumentation/events/lttng-module/workqueue.h b/instrumentation/events/lttng-module/workqueue.h
index 07d6a53..e0ef917 100644
--- a/instrumentation/events/lttng-module/workqueue.h
+++ b/instrumentation/events/lttng-module/workqueue.h
@@ -9,8 +9,6 @@
 #include <linux/workqueue.h>
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-
 #ifndef _TRACE_WORKQUEUE_DEF_
 #define _TRACE_WORKQUEUE_DEF_
 
@@ -30,7 +28,6 @@ LTTNG_TRACEPOINT_EVENT_CLASS(workqueue_work,
 	)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 /**
  * workqueue_queue_work - called when a work gets queued
  * @req_cpu:	the requested cpu
@@ -76,7 +73,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(workqueue_work, workqueue_activate_work,
 
 	TP_ARGS(work)
 )
-#endif
 
 /**
  * workqueue_execute_start - called immediately before the workqueue callback
@@ -109,63 +105,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(workqueue_work, workqueue_execute_end,
 	TP_ARGS(work)
 )
 
-#else
-
-LTTNG_TRACEPOINT_EVENT_CLASS(workqueue,
-
-	TP_PROTO(struct task_struct *wq_thread, struct work_struct *work),
-
-	TP_ARGS(wq_thread, work),
-
-	TP_FIELDS(
-		ctf_array(char, thread_comm, wq_thread->comm, TASK_COMM_LEN)
-		ctf_integer(pid_t, thread_pid, wq_thread->pid)
-		ctf_integer_hex(work_func_t, func, work->func)
-	)
-)
-
-LTTNG_TRACEPOINT_EVENT_INSTANCE(workqueue, workqueue_insertion,
-
-	TP_PROTO(struct task_struct *wq_thread, struct work_struct *work),
-
-	TP_ARGS(wq_thread, work)
-)
-
-LTTNG_TRACEPOINT_EVENT_INSTANCE(workqueue, workqueue_execution,
-
-	TP_PROTO(struct task_struct *wq_thread, struct work_struct *work),
-
-	TP_ARGS(wq_thread, work)
-)
-
-/* Trace the creation of one workqueue thread on a cpu */
-LTTNG_TRACEPOINT_EVENT(workqueue_creation,
-
-	TP_PROTO(struct task_struct *wq_thread, int cpu),
-
-	TP_ARGS(wq_thread, cpu),
-
-	TP_FIELDS(
-		ctf_array(char, thread_comm, wq_thread->comm, TASK_COMM_LEN)
-		ctf_integer(pid_t, thread_pid, wq_thread->pid)
-		ctf_integer(int, cpu, cpu)
-	)
-)
-
-LTTNG_TRACEPOINT_EVENT(workqueue_destruction,
-
-	TP_PROTO(struct task_struct *wq_thread),
-
-	TP_ARGS(wq_thread),
-
-	TP_FIELDS(
-		ctf_array(char, thread_comm, wq_thread->comm, TASK_COMM_LEN)
-		ctf_integer(pid_t, thread_pid, wq_thread->pid)
-	)
-)
-
-#endif
-
 #endif /*  LTTNG_TRACE_WORKQUEUE_H */
 
 /* This part must be outside protection */
-- 
2.17.1
