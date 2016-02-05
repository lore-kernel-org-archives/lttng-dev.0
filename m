From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 2/2] Fix: sched instrumentation
	for 4.1-rt11
Date: Fri,  5 Feb 2016 17:53:07 -0500
Message-ID: <1454712787-7944-2-git-send-email-mjeanson__6824.01355957172$1454712888$gmane$org@efficios.com>
References: <1454712787-7944-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aRpFt-0006h1-Cb
 for lttng-dev@lists.lttng.org; Fri, 05 Feb 2016 17:53:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 02D7D340412
 for <lttng-dev@lists.lttng.org>; Fri,  5 Feb 2016 22:53:28 +0000 (UTC)
In-Reply-To: <1454712787-7944-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

---
 instrumentation/events/lttng-module/sched.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/instrumentation/events/lttng-module/sched.h b/instrumentation/events/lttng-module/sched.h
index 4f3676b..116d65e 100644
--- a/instrumentation/events/lttng-module/sched.h
+++ b/instrumentation/events/lttng-module/sched.h
@@ -145,7 +145,8 @@ LTTNG_TRACEPOINT_EVENT(sched_kthread_stop_ret,
 /*
  * Tracepoint for waking up a task:
  */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0) || \
+	LTTNG_RT_KERNEL_RANGE(4,1,10,11, 4,2,0,0))
 LTTNG_TRACEPOINT_EVENT_CLASS(sched_wakeup_template,
 
 	TP_PROTO(struct task_struct *p),
@@ -184,7 +185,8 @@ LTTNG_TRACEPOINT_EVENT_CLASS(sched_wakeup_template,
 )
 #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)) */
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0) || \
+	LTTNG_RT_KERNEL_RANGE(4,1,10,11, 4,2,0,0))
 
 /*
  * Tracepoint called when waking a task; this tracepoint is guaranteed to be
-- 
2.7.0
