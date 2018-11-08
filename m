From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 04/30] Drop support for
 kernels < 3.0 from perf.h wrapper
Date: Thu,  8 Nov 2018 16:45:09 -0500
Message-ID: <20181108214535.12081-4-mjeanson__34333.2061930143$1541713484$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKW614mzq8q
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:51 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id CD02724ACD2
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:51 -0500 (EST)
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
 wrapper/perf.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/wrapper/perf.h b/wrapper/perf.h
index 48e256c..4a7f6d8 100644
--- a/wrapper/perf.h
+++ b/wrapper/perf.h
@@ -22,8 +22,6 @@ wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
 	return perf_event_create_kernel_counter(attr, cpu, task, callback, NULL);
 }
 #else /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0)) */
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 static inline struct perf_event *
 wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
 				int cpu,
@@ -32,29 +30,6 @@ wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
 {
 	return perf_event_create_kernel_counter(attr, cpu, task, callback);
 }
-#else /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37)) */
-static inline struct perf_event *
-wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
-				int cpu,
-				struct task_struct *task,
-				perf_overflow_handler_t callback)
-{
-	pid_t pid;
-
-	if (!task)
-		pid = -1;
-	else
-		pid = task->pid;
-
-	return perf_event_create_kernel_counter(attr, cpu, pid, callback);
-}
-
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37)) */
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
-#define local64_read(l)		atomic64_read(l)
-#endif
-
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0)) */
 
 #endif /* CONFIG_PERF_EVENTS */
-- 
2.17.1
