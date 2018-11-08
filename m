From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 24/30] Drop support for
 kernels < 3.0 from power instrumentation
Date: Thu,  8 Nov 2018 16:45:29 -0500
Message-ID: <20181108214535.12081-24-mjeanson__827.751475344662$1541713768$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKn08BXzqH6
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:04 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id D49B924AEEC
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:04 -0500 (EST)
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
 instrumentation/events/lttng-module/power.h | 40 ---------------------
 1 file changed, 40 deletions(-)

diff --git a/instrumentation/events/lttng-module/power.h b/instrumentation/events/lttng-module/power.h
index 2146a37..fee6f5f 100644
--- a/instrumentation/events/lttng-module/power.h
+++ b/instrumentation/events/lttng-module/power.h
@@ -9,7 +9,6 @@
 #include <linux/ktime.h>
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
 LTTNG_TRACEPOINT_EVENT_CLASS(power_cpu,
 
 	TP_PROTO(unsigned int state, unsigned int cpu_id),
@@ -59,7 +58,6 @@ LTTNG_TRACEPOINT_EVENT_MAP(machine_suspend,
 		ctf_integer(u32, state, state)
 	)
 )
-#endif
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
 LTTNG_TRACEPOINT_EVENT_CLASS(power_wakeup_source,
@@ -93,12 +91,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(power_wakeup_source, wakeup_source_deactivat
 )
 #endif
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38))
-#undef CONFIG_EVENT_POWER_TRACING_DEPRECATED
-#define CONFIG_EVENT_POWER_TRACING_DEPRECATED
-#define _PWR_EVENT_AVOID_DOUBLE_DEFINING_DEPRECATED
-#endif
-
 #ifdef CONFIG_EVENT_POWER_TRACING_DEPRECATED
 
 /*
@@ -107,69 +99,39 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(power_wakeup_source, wakeup_source_deactivat
  */
 LTTNG_TRACEPOINT_EVENT_CLASS(power,
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
 	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
 
 	TP_ARGS(type, state, cpu_id),
-#else
-	TP_PROTO(unsigned int type, unsigned int state),
-
-	TP_ARGS(type, state),
-#endif
 
 	TP_FIELDS(
 		ctf_integer(u64, type, type)
 		ctf_integer(u64, state, state)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
 		ctf_integer(u64, cpu_id, cpu_id)
-#endif
 	)
 )
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(power, power_start,
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
 	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
 
 	TP_ARGS(type, state, cpu_id)
-#else
-	TP_PROTO(unsigned int type, unsigned int state),
-
-	TP_ARGS(type, state)
-#endif
 )
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(power, power_frequency,
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
 	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
 
 	TP_ARGS(type, state, cpu_id)
-#else
-	TP_PROTO(unsigned int type, unsigned int state),
-
-	TP_ARGS(type, state)
-#endif
 )
 
 LTTNG_TRACEPOINT_EVENT(power_end,
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
 	TP_PROTO(unsigned int cpu_id),
 
 	TP_ARGS(cpu_id),
-#else
-	TP_PROTO(int dummy),
-
-	TP_ARGS(dummy),
-#endif
 
 	TP_FIELDS(
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
 		ctf_integer(u64, cpu_id, cpu_id)
-#else
-		ctf_integer(u64, dummy, 0xffff)
-#endif
 	)
 )
 
@@ -207,7 +169,6 @@ static inline void trace_power_frequency(u64 type, u64 state, u64 cpuid) {};
 
 #endif /* CONFIG_EVENT_POWER_TRACING_DEPRECATED */
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 /*
  * The clock events are used for clock enable/disable and for
  *  clock rate change
@@ -274,7 +235,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(power_domain, power_domain_target,
 
 	TP_ARGS(name, state, cpu_id)
 )
-#endif
 
 #endif /* LTTNG_TRACE_POWER_H */
 
-- 
2.17.1
