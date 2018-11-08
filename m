From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 11/30] Drop support for
 kernels < 3.0 from lttng-events.h
Date: Thu,  8 Nov 2018 16:45:16 -0500
Message-ID: <20181108214535.12081-11-mjeanson__27352.8124708266$1541713594$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKc5bnjzqCj
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:56 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id BF09A24AD7E
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:56 -0500 (EST)
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
 lttng-events.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lttng-events.h b/lttng-events.h
index f62e0cb..1903706 100644
--- a/lttng-events.h
+++ b/lttng-events.h
@@ -716,7 +716,7 @@ int lttng_add_migratable_to_ctx(struct lttng_ctx **ctx)
 
 int lttng_add_callstack_to_ctx(struct lttng_ctx **ctx, int type);
 
-#if defined(CONFIG_PERF_EVENTS) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
+#if defined(CONFIG_PERF_EVENTS)
 int lttng_add_perf_counter_to_ctx(uint32_t type,
 				  uint64_t config,
 				  const char *name,
@@ -891,8 +891,6 @@ int lttng_calibrate(struct lttng_kernel_calibrate *calibrate);
 extern const struct file_operations lttng_tracepoint_list_fops;
 extern const struct file_operations lttng_syscall_list_fops;
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
 #define TRACEPOINT_HAS_DATA_ARG
-#endif
 
 #endif /* _LTTNG_EVENTS_H */
-- 
2.17.1
