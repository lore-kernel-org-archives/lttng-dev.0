From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH lttng-modules] wrapper/perf.h: Fix kernel
	version condition
Date: Sun,  9 Dec 2012 09:00:30 -0600
Message-ID: <1355065230-4313-1-git-send-email-andrew_gabbasov__20025.2136019573$1355065277$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew_Gabbasov@mentor.com>) id 1ThiN1-0006eQ-M4
	for lttng-dev@lists.lttng.org; Sun, 09 Dec 2012 10:00:43 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1ThiMw-0006tO-6N from Andrew_Gabbasov@mentor.com
	for lttng-dev@lists.lttng.org; Sun, 09 Dec 2012 07:00:38 -0800
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The pid_t parameter of function perf_event_create_kernel_counter
was changed to task_struct pointer starting from 2.6.37.x.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 wrapper/perf.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/wrapper/perf.h b/wrapper/perf.h
index 5dfa84b..5de205c 100644
--- a/wrapper/perf.h
+++ b/wrapper/perf.h
@@ -34,7 +34,7 @@ wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
 }
 #else /* defined(CONFIG_PERF_EVENTS) && (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,99)) */
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 static inline struct perf_event *
 wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
 				int cpu,
@@ -43,7 +43,7 @@ wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
 {
 	return perf_event_create_kernel_counter(attr, cpu, task, callback);
 }
-#else /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)) */
+#else /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37)) */
 static inline struct perf_event *
 wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
 				int cpu,
@@ -60,8 +60,11 @@ wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
 	return perf_event_create_kernel_counter(attr, cpu, pid, callback);
 }
 
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37)) */
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
 #define local64_read(l)		atomic64_read(l)
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)) */
+#endif
 
 #endif /* defined(CONFIG_PERF_EVENTS) && (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,99)) */
 
-- 
1.7.10.4
