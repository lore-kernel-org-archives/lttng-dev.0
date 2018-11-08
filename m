From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 22/30] Drop support for
 kernels < 3.0 from module instrumentation
Date: Thu,  8 Nov 2018 16:45:27 -0500
Message-ID: <20181108214535.12081-22-mjeanson__22819.9265468449$1541713743$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKl4mDyzqGf
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:03 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id A189F24AECA
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:03 -0500 (EST)
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
 instrumentation/events/lttng-module/module.h | 22 +-------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/instrumentation/events/lttng-module/module.h b/instrumentation/events/lttng-module/module.h
index febe8d2..89b1e79 100644
--- a/instrumentation/events/lttng-module/module.h
+++ b/instrumentation/events/lttng-module/module.h
@@ -54,24 +54,16 @@ LTTNG_TRACEPOINT_EVENT(module_free,
 
 LTTNG_TRACEPOINT_EVENT_CLASS(module_refcnt,
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
 	TP_PROTO(struct module *mod, unsigned long ip),
 
 	TP_ARGS(mod, ip),
-#else
-	TP_PROTO(struct module *mod, unsigned long ip, int refcnt),
-
-	TP_ARGS(mod, ip, refcnt),
-#endif
 
 	TP_FIELDS(
 		ctf_integer(unsigned long, ip, ip)
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0))
 		ctf_integer(int, refcnt, atomic_read(&mod->refcnt))
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
-		ctf_integer(int, refcnt, __this_cpu_read(mod->refptr->incs) + __this_cpu_read(mod->refptr->decs))
 #else
-		ctf_integer(int, refcnt, refcnt)
+		ctf_integer(int, refcnt, __this_cpu_read(mod->refptr->incs) + __this_cpu_read(mod->refptr->decs))
 #endif
 		ctf_string(name, mod->name)
 	)
@@ -79,28 +71,16 @@ LTTNG_TRACEPOINT_EVENT_CLASS(module_refcnt,
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(module_refcnt, module_get,
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
 	TP_PROTO(struct module *mod, unsigned long ip),
 
 	TP_ARGS(mod, ip)
-#else
-	TP_PROTO(struct module *mod, unsigned long ip, int refcnt),
-
-	TP_ARGS(mod, ip, refcnt)
-#endif
 )
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(module_refcnt, module_put,
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
 	TP_PROTO(struct module *mod, unsigned long ip),
 
 	TP_ARGS(mod, ip)
-#else
-	TP_PROTO(struct module *mod, unsigned long ip, int refcnt),
-
-	TP_ARGS(mod, ip, refcnt)
-#endif
 )
 #endif /* CONFIG_MODULE_UNLOAD */
 
-- 
2.17.1
