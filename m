From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 29/30] Drop support for
 kernels < 3.0 from writeback instrumentation
Date: Thu,  8 Nov 2018 16:45:34 -0500
Message-ID: <20181108214535.12081-29-mjeanson__5965.12642591751$1541713826$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKr0X9VzqJh
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:08 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E5F1124AF4D
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:07 -0500 (EST)
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
 instrumentation/events/lttng-module/writeback.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/instrumentation/events/lttng-module/writeback.h b/instrumentation/events/lttng-module/writeback.h
index 3327a0f..feef945 100644
--- a/instrumentation/events/lttng-module/writeback.h
+++ b/instrumentation/events/lttng-module/writeback.h
@@ -308,9 +308,7 @@ DEFINE_WRITEBACK_EVENT(writeback_bdi_register)
 #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)) */
 
 DEFINE_WRITEBACK_EVENT(writeback_nowork)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
 DEFINE_WRITEBACK_EVENT(writeback_wake_background)
-#endif
 DEFINE_WRITEBACK_EVENT(writeback_wake_thread)
 DEFINE_WRITEBACK_EVENT(writeback_wake_forker_thread)
 DEFINE_WRITEBACK_EVENT(writeback_bdi_unregister)
@@ -661,7 +659,6 @@ LTTNG_TRACEPOINT_EVENT(writeback_sb_inodes_requeue,
 )
 #endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 LTTNG_TRACEPOINT_EVENT_CLASS(writeback_congest_waited_template,
 
 	TP_PROTO(unsigned int usec_timeout, unsigned int usec_delayed),
@@ -687,7 +684,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(writeback_congest_waited_template, writeback_wai
 
 	TP_ARGS(usec_timeout, usec_delayed)
 )
-#endif
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
 LTTNG_TRACEPOINT_EVENT_CLASS(writeback_single_inode_template,
-- 
2.17.1
