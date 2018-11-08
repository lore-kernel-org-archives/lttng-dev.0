From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 20/30] Drop support for
 kernels < 3.0 from lock instrumentation
Date: Thu,  8 Nov 2018 16:45:25 -0500
Message-ID: <20181108214535.12081-20-mjeanson__41539.9661906578$1541713714$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKk3CsrzqGP
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:02 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 6BD8D24AEA9
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:02 -0500 (EST)
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
 instrumentation/events/lttng-module/lock.h | 71 +---------------------
 probes/lttng-probe-lock.c                  |  5 --
 2 files changed, 2 insertions(+), 74 deletions(-)

diff --git a/instrumentation/events/lttng-module/lock.h b/instrumentation/events/lttng-module/lock.h
index 49e7811..c8cdc55 100644
--- a/instrumentation/events/lttng-module/lock.h
+++ b/instrumentation/events/lttng-module/lock.h
@@ -1,16 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/version.h>
 
 #undef TRACE_SYSTEM
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
 #define TRACE_SYSTEM lock
-#else
-#define TRACE_SYSTEM lockdep
-#define TRACE_INCLUDE_FILE lock
-#if defined(_TRACE_LOCKDEP_H)
-#define LTTNG_TRACE_LOCK_H
-#endif
-#endif
 
 #if !defined(LTTNG_TRACE_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
 #define LTTNG_TRACE_LOCK_H
@@ -31,14 +22,10 @@ LTTNG_TRACEPOINT_EVENT(lock_acquire,
 	TP_FIELDS(
 		ctf_integer(unsigned int, flags, (trylock ? 1 : 0) | (read ? 2 : 0))
 		ctf_string(name, lock->name)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
 		ctf_integer_hex(void *, lockdep_addr, lock)
-#endif
 	)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
-
 LTTNG_TRACEPOINT_EVENT_CLASS(lock,
 
 	TP_PROTO(struct lockdep_map *lock, unsigned long ip),
@@ -74,63 +61,9 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(lock, lock_acquired,
 	TP_ARGS(lock, ip)
 )
 
-#endif
-
-#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
-
-LTTNG_TRACEPOINT_EVENT(lock_release,
-
-	TP_PROTO(struct lockdep_map *lock, int nested, unsigned long ip),
-
-	TP_ARGS(lock, nested, ip),
-
-	TP_FIELDS(
-		ctf_string(name, lock->name)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
-		ctf_integer_hex(void *, lockdep_addr, lock)
-#endif
-	)
-)
-
-#ifdef CONFIG_LOCK_STAT
-
-LTTNG_TRACEPOINT_EVENT(lock_contended,
-
-	TP_PROTO(struct lockdep_map *lock, unsigned long ip),
-
-	TP_ARGS(lock, ip),
-
-	TP_FIELDS(
-		ctf_string(name, lock->name)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
-		ctf_integer_hex(void *, lockdep_addr, lock)
-#endif
-	)
-)
-
-LTTNG_TRACEPOINT_EVENT(lock_acquired,
-
-	TP_PROTO(struct lockdep_map *lock, unsigned long ip, s64 waittime),
-
-	TP_ARGS(lock, ip, waittime),
-
-	TP_FIELDS(
-		ctf_string(name, lock->name)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
-		ctf_integer(s64, wait_nsec, wait_nsec)
-		ctf_integer_hex(void *, lockdep_addr, lock)
-#else
-		ctf_integer(unsigned long, wait_usec, (unsigned long) waittime)
-		ctf_integer(unsigned long, wait_nsec_rem, do_div(waittime, NSEC_PER_USEC))
-#endif
-	)
-)
-
-#endif
-
-#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
+#endif /* CONFIG_LOCK_STAT */
 
-#endif
+#endif /* CONFIG_LOCKDEP */
 
 #endif /* LTTNG_TRACE_LOCK_H */
 
diff --git a/probes/lttng-probe-lock.c b/probes/lttng-probe-lock.c
index b3ad230..e81eb36 100644
--- a/probes/lttng-probe-lock.c
+++ b/probes/lttng-probe-lock.c
@@ -16,12 +16,7 @@
  * Create the tracepoint static inlines from the kernel to validate that our
  * trace event macros match the kernel we run on.
  */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
 #include <trace/events/lock.h>
-#else
-#include <trace/events/lockdep.h>
-#endif
-
 #include <wrapper/tracepoint.h>
 
 /*
-- 
2.17.1
