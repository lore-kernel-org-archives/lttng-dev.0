From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 18/30] Drop support for
 kernels < 3.0 from kmem instrumentation
Date: Thu,  8 Nov 2018 16:45:23 -0500
Message-ID: <20181108214535.12081-18-mjeanson__38163.4907833815$1541713689$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKj0gs3zqFj
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:01 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 15E3F24AE7F
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:01 -0500 (EST)
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
 instrumentation/events/lttng-module/kmem.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/instrumentation/events/lttng-module/kmem.h b/instrumentation/events/lttng-module/kmem.h
index 8270fce..2313ae8 100644
--- a/instrumentation/events/lttng-module/kmem.h
+++ b/instrumentation/events/lttng-module/kmem.h
@@ -115,7 +115,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(kmem_free, kmem_cache_free,
 	TP_ARGS(call_site, ptr)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
 LTTNG_TRACEPOINT_EVENT_MAP(mm_page_free, kmem_mm_page_free,
 #else
@@ -218,11 +217,7 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(kmem_mm_page, mm_page_pcpu_drain,
 
 	kmem_mm_page_pcpu_drain,
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
 	TP_PROTO(struct page *page, unsigned int order, int migratetype),
-#else
-	TP_PROTO(struct page *page, int order, int migratetype),
-#endif
 
 	TP_ARGS(page, order, migratetype)
 )
@@ -337,8 +332,6 @@ LTTNG_TRACEPOINT_EVENT_MAP(mm_page_alloc_extfrag,
 
 #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)) */
 
-#endif
-
 #endif /* LTTNG_TRACE_KMEM_H */
 
 /* This part must be outside protection */
-- 
2.17.1
