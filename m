From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 17/30] Drop support for
 kernels < 3.0 from jbd2 instrumentation
Date: Thu,  8 Nov 2018 16:45:22 -0500
Message-ID: <20181108214535.12081-17-mjeanson__18703.9987453774$1541713676$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKh3XR6zqFg
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:00 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 7878E24AE60
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:00 -0500 (EST)
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
 instrumentation/events/lttng-module/jbd2.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/instrumentation/events/lttng-module/jbd2.h b/instrumentation/events/lttng-module/jbd2.h
index 10e3073..a760da2 100644
--- a/instrumentation/events/lttng-module/jbd2.h
+++ b/instrumentation/events/lttng-module/jbd2.h
@@ -9,13 +9,11 @@
 #include <linux/jbd2.h>
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
 #ifndef _TRACE_JBD2_DEF
 #define _TRACE_JBD2_DEF
 struct transaction_chp_stats_s;
 struct transaction_run_stats_s;
 #endif
-#endif
 
 LTTNG_TRACEPOINT_EVENT(jbd2_checkpoint,
 
@@ -103,7 +101,6 @@ LTTNG_TRACEPOINT_EVENT(jbd2_submit_inode_data,
 	)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
 LTTNG_TRACEPOINT_EVENT(jbd2_run_stats,
 	TP_PROTO(dev_t dev, unsigned long tid,
 		 struct transaction_run_stats_s *stats),
@@ -139,9 +136,7 @@ LTTNG_TRACEPOINT_EVENT(jbd2_checkpoint_stats,
 		ctf_integer(__u32, dropped, stats->cs_dropped)
 	)
 )
-#endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
 LTTNG_TRACEPOINT_EVENT(jbd2_update_log_tail,
 #else
@@ -161,7 +156,6 @@ LTTNG_TRACEPOINT_EVENT(jbd2_cleanup_journal_tail,
 		ctf_integer(unsigned long, freed, freed)
 	)
 )
-#endif
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
 LTTNG_TRACEPOINT_EVENT(jbd2_write_superblock,
-- 
2.17.1
