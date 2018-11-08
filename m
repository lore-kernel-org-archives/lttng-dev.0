From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 19/30] Drop support for
 kernels < 3.0 from kvm instrumentation
Date: Thu,  8 Nov 2018 16:45:24 -0500
Message-ID: <20181108214535.12081-19-mjeanson__35591.8497815312$1541713701$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKj5CKVzqGD
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:01 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id B0A6924AE8F
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
 instrumentation/events/lttng-module/kvm.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/instrumentation/events/lttng-module/kvm.h b/instrumentation/events/lttng-module/kvm.h
index 62030fc..4868d89 100644
--- a/instrumentation/events/lttng-module/kvm.h
+++ b/instrumentation/events/lttng-module/kvm.h
@@ -8,8 +8,6 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
-
 LTTNG_TRACEPOINT_EVENT(kvm_userspace_exit,
 	    TP_PROTO(__u32 reason, int errno),
 	    TP_ARGS(reason, errno),
@@ -19,7 +17,6 @@ LTTNG_TRACEPOINT_EVENT(kvm_userspace_exit,
 		ctf_integer(int, errno, errno)
 	)
 )
-#endif
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0))
 #if defined(__KVM_HAVE_IOAPIC)
@@ -142,8 +139,6 @@ LTTNG_TRACEPOINT_EVENT(kvm_mmio,
 
 #endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
-
 #define kvm_fpu_load_symbol	\
 	{0, "unload"},		\
 	{1, "load"}
@@ -187,9 +182,6 @@ LTTNG_TRACEPOINT_EVENT(kvm_age_page,
 	)
 )
 #endif
-#endif
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
 
 #ifdef CONFIG_KVM_ASYNC_PF
 LTTNG_TRACEPOINT_EVENT_CLASS(kvm_async_get_page_class,
@@ -276,8 +268,6 @@ LTTNG_TRACEPOINT_EVENT(
 
 #endif
 
-#endif
-
 #endif /* LTTNG_TRACE_KVM_MAIN_H */
 
 /* This part must be outside protection */
-- 
2.17.1
