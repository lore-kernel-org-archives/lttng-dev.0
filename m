From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 09/30] Drop spinlock.h
 wrapper
Date: Thu,  8 Nov 2018 16:45:14 -0500
Message-ID: <20181108214535.12081-9-mjeanson__4141.54737159169$1541713566$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKb39h0zqC0
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:55 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 6BF0D24AD24
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:55 -0500 (EST)
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
 lib/ringbuffer/frontend_types.h |  1 -
 lttng-statedump-impl.c          |  5 ++---
 wrapper/spinlock.h              | 34 ---------------------------------
 3 files changed, 2 insertions(+), 38 deletions(-)
 delete mode 100644 wrapper/spinlock.h

diff --git a/lib/ringbuffer/frontend_types.h b/lib/ringbuffer/frontend_types.h
index 2b0c932..837a926 100644
--- a/lib/ringbuffer/frontend_types.h
+++ b/lib/ringbuffer/frontend_types.h
@@ -15,7 +15,6 @@
 #include <linux/kref.h>
 #include <wrapper/ringbuffer/config.h>
 #include <wrapper/ringbuffer/backend_types.h>
-#include <wrapper/spinlock.h>
 #include <lib/prio_heap/lttng_prio_heap.h>	/* For per-CPU read-side iterator */
 #include <lttng-cpuhotplug.h>
 
diff --git a/lttng-statedump-impl.c b/lttng-statedump-impl.c
index 6d91a2c..8ce50c0 100644
--- a/lttng-statedump-impl.c
+++ b/lttng-statedump-impl.c
@@ -37,7 +37,6 @@
 #include <lttng-events.h>
 #include <lttng-tracer.h>
 #include <wrapper/irqdesc.h>
-#include <wrapper/spinlock.h>
 #include <wrapper/fdtable.h>
 #include <wrapper/irq.h>
 #include <wrapper/tracepoint.h>
@@ -373,12 +372,12 @@ int lttng_list_interrupts(struct lttng_session *session)
 			irq_desc_get_chip(desc)->name ? : "unnamed_irq_chip";
 
 		local_irq_save(flags);
-		wrapper_desc_spin_lock(&desc->lock);
+		raw_spin_lock(&desc->lock);
 		for (action = desc->action; action; action = action->next) {
 			trace_lttng_statedump_interrupt(session,
 				irq, irq_chip_name, action);
 		}
-		wrapper_desc_spin_unlock(&desc->lock);
+		raw_spin_unlock(&desc->lock);
 		local_irq_restore(flags);
 	}
 	return 0;
diff --git a/wrapper/spinlock.h b/wrapper/spinlock.h
deleted file mode 100644
index b3570d4..0000000
--- a/wrapper/spinlock.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0 or LGPL-2.1)
- *
- * wrapper/spinlock.h
- *
- * Copyright (C) 2011-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
- */
-
-#ifndef _LTTNG_WRAPPER_SPINLOCK_H
-#define _LTTNG_WRAPPER_SPINLOCK_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33))
-
-#include <linux/string.h>
-
-#define raw_spin_lock_init(lock)					\
-	do {								\
-		raw_spinlock_t __lock = __RAW_SPIN_LOCK_UNLOCKED;	\
-		memcpy(lock, &__lock, sizeof(lock));			\
-	} while (0)
-
-#define raw_spin_is_locked(lock)	__raw_spin_is_locked(lock)
-
-#define wrapper_desc_spin_lock(lock)	spin_lock(lock)
-#define wrapper_desc_spin_unlock(lock)	spin_unlock(lock)
-
-#else
-
-#define wrapper_desc_spin_lock(lock)	raw_spin_lock(lock)
-#define wrapper_desc_spin_unlock(lock)	raw_spin_unlock(lock)
-
-#endif
-#endif /* _LTTNG_WRAPPER_SPINLOCK_H */
-- 
2.17.1
