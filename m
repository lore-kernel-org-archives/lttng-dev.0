From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 16/30] Drop support for
 kernels < 3.0 from irq instrumentation
Date: Thu,  8 Nov 2018 16:45:21 -0500
Message-ID: <20181108214535.12081-16-mjeanson__4183.75851954824$1541713660$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKg6gVYzqFJ
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:59 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E367724AE2E
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:59 -0500 (EST)
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
 instrumentation/events/lttng-module/irq.h | 64 -----------------------
 1 file changed, 64 deletions(-)

diff --git a/instrumentation/events/lttng-module/irq.h b/instrumentation/events/lttng-module/irq.h
index 6f66a5e..71553e6 100644
--- a/instrumentation/events/lttng-module/irq.h
+++ b/instrumentation/events/lttng-module/irq.h
@@ -61,7 +61,6 @@ LTTNG_TRACEPOINT_EVENT(irq_handler_exit,
 	)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 LTTNG_TRACEPOINT_EVENT_CLASS(irq_softirq,
 
 	TP_PROTO(unsigned int vec_nr),
@@ -120,69 +119,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(irq_softirq, softirq_raise,
 
 	TP_ARGS(vec_nr)
 )
-#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37)) */
-LTTNG_TRACEPOINT_EVENT_CLASS(irq_softirq,
-
-	TP_PROTO(struct softirq_action *h, struct softirq_action *vec),
-
-	TP_ARGS(h, vec),
-
-	TP_FIELDS(
-		ctf_integer(unsigned int, vec, (int)(h - vec))
-	)
-)
-
-/**
- * softirq_entry - called immediately before the softirq handler
- * @h: pointer to struct softirq_action
- * @vec: pointer to first struct softirq_action in softirq_vec array
- *
- * When used in combination with the softirq_exit tracepoint
- * we can determine the softirq handler runtine.
- */
-LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(irq_softirq, softirq_entry,
-
-	irq_softirq_entry,
-
-	TP_PROTO(struct softirq_action *h, struct softirq_action *vec),
-
-	TP_ARGS(h, vec)
-)
-
-/**
- * softirq_exit - called immediately after the softirq handler returns
- * @h: pointer to struct softirq_action
- * @vec: pointer to first struct softirq_action in softirq_vec array
- *
- * When used in combination with the softirq_entry tracepoint
- * we can determine the softirq handler runtine.
- */
-LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(irq_softirq, softirq_exit,
-
-	irq_softirq_exit,
-
-	TP_PROTO(struct softirq_action *h, struct softirq_action *vec),
-
-	TP_ARGS(h, vec)
-)
-
-/**
- * softirq_raise - called immediately when a softirq is raised
- * @h: pointer to struct softirq_action
- * @vec: pointer to first struct softirq_action in softirq_vec array
- *
- * When used in combination with the softirq_entry tracepoint
- * we can determine the softirq raise to run latency.
- */
-LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(irq_softirq, softirq_raise,
-
-	irq_softirq_raise,
-
-	TP_PROTO(struct softirq_action *h, struct softirq_action *vec),
-
-	TP_ARGS(h, vec)
-)
-#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37)) */
 
 #endif /*  LTTNG_TRACE_IRQ_H */
 
-- 
2.17.1
