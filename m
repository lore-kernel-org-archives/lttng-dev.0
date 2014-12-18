From: David Engraf <david.engraf@sysgo.com>
Subject: [PATCH] Fix compile error on kernel 3.0.101 with
	CONFIG_PERF_EVENTS
Date: Thu, 18 Dec 2014 11:57:00 +0100
Message-ID: <5492B2FC.9030406__32328.3221027397$1418939473$gmane$org@sysgo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030401020509080305030908"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.sysgo.com ([176.9.53.133])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <david.engraf@sysgo.com>) id 1Y1YlY-0000vP-9Y
 for lttng-dev@lists.lttng.org; Thu, 18 Dec 2014 05:57:09 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--------------030401020509080305030908
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



--------------030401020509080305030908
Content-Type: text/x-diff;
 name="0001-Fix-compile-error-on-kernel-3.0.101-with-CONFIG_PERF.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Fix-compile-error-on-kernel-3.0.101-with-CONFIG_PERF.pa";
 filename*1="tch"

From bed03bd7571b7b54d6b7af832f618d3b4faa7bdb Mon Sep 17 00:00:00 2001
From: David Engraf <david.engraf@sysgo.com>
Date: Thu, 18 Dec 2014 11:45:22 +0100
Subject: [PATCH] Fix compile error on kernel 3.0.101 with CONFIG_PERF_EVENTS

The context parameter of perf_event_create_kernel_counter() was introduced
with kernel 3.1.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 wrapper/perf.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/wrapper/perf.h b/wrapper/perf.h
index 5de205c..6bd2a5d 100644
--- a/wrapper/perf.h
+++ b/wrapper/perf.h
@@ -23,7 +23,9 @@
 
 #include <linux/perf_event.h>
 
-#if defined(CONFIG_PERF_EVENTS) && (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,99))
+#ifdef CONFIG_PERF_EVENTS
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
 static inline struct perf_event *
 wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
 				int cpu,
@@ -32,7 +34,7 @@ wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
 {
 	return perf_event_create_kernel_counter(attr, cpu, task, callback, NULL);
 }
-#else /* defined(CONFIG_PERF_EVENTS) && (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,99)) */
+#else /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0)) */
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 static inline struct perf_event *
@@ -66,6 +68,8 @@ wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
 #define local64_read(l)		atomic64_read(l)
 #endif
 
-#endif /* defined(CONFIG_PERF_EVENTS) && (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,99)) */
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0)) */
+
+#endif /* CONFIG_PERF_EVENTS */
 
 #endif /* _LTTNG_WRAPPER_PERF_H */
-- 
1.9.1


--------------030401020509080305030908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------030401020509080305030908--
