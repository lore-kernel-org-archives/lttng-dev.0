From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 15/16] urcu-wait: move wait code into separate
	file
Date: Tue, 20 Nov 2012 14:40:28 -0500
Message-ID: <1353440429-19223-16-git-send-email-mathieu.desnoyers__17926.2007041418$1353442696$gmane$org@efficios.com>
References: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1TathU-0001PC-Ut
	for lttng-dev@lists.lttng.org; Tue, 20 Nov 2012 14:41:40 -0500
In-Reply-To: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 Makefile.am |    2 +-
 urcu-qsbr.c |   82 +++++----------------------------------------
 urcu-wait.h |  107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 75 deletions(-)
 create mode 100644 urcu-wait.h

diff --git a/Makefile.am b/Makefile.am
index 195b89a..0a4d357 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -23,7 +23,7 @@ nobase_dist_include_HEADERS = urcu/compiler.h urcu/hlist.h urcu/list.h \
 		urcu/tls-compat.h
 nobase_nodist_include_HEADERS = urcu/arch.h urcu/uatomic.h urcu/config.h
 
-dist_noinst_HEADERS = urcu-die.h
+dist_noinst_HEADERS = urcu-die.h urcu-wait.h
 
 EXTRA_DIST = $(top_srcdir)/urcu/arch/*.h $(top_srcdir)/urcu/uatomic/*.h \
 		gpl-2.0.txt lgpl-2.1.txt lgpl-relicensing.txt \
diff --git a/urcu-qsbr.c b/urcu-qsbr.c
index 7f747ed..d691389 100644
--- a/urcu-qsbr.c
+++ b/urcu-qsbr.c
@@ -44,6 +44,7 @@
 #include "urcu/tls-compat.h"
 
 #include "urcu-die.h"
+#include "urcu-wait.h"
 
 /* Do not #define _LGPL_SOURCE to ensure we can emit the wrapper symbols */
 #undef _LGPL_SOURCE
@@ -79,24 +80,9 @@ DEFINE_URCU_TLS(unsigned int, rcu_rand_yield);
 
 static CDS_LIST_HEAD(registry);
 
-/*
- * Number of busy-loop attempts before waiting on futex for grace period
- * batching.
- */
-#define RCU_AWAKE_ATTEMPTS 1000
-
-enum adapt_wakeup_state {
-	/* AWAKE_WAITING is compared directly (futex compares it). */
-	AWAKE_WAITING =		0,
-	/* non-zero are used as masks. */
-	AWAKE_WAKEUP =		(1 << 0),
-	AWAKE_AWAKENED =	(1 << 1),
-	AWAKE_TEARDOWN =	(1 << 2),
-};
-
 struct gp_waiters_thread {
 	struct cds_wfs_node node;
-	int32_t wait_futex;
+	struct urcu_wait wait;
 };
 
 /*
@@ -146,58 +132,6 @@ static void wait_gp(void)
 		      NULL, NULL, 0);
 }
 
-/*
- * Note: urcu_adaptative_wake_up needs "value" to stay allocated
- * throughout its execution. In this scheme, the waiter owns the futex
- * memory, and we only allow it to free this memory when it receives the
- * AWAKE_TEARDOWN flag.
- */
-static void urcu_adaptative_wake_up(int32_t *value)
-{
-	cmm_smp_mb();
-	assert(uatomic_read(value) == AWAKE_WAITING);
-	uatomic_set(value, AWAKE_WAKEUP);
-	if (!(uatomic_read(value) & AWAKE_AWAKENED))
-		futex_noasync(value, FUTEX_WAKE, 1, NULL, NULL, 0);
-	/* Allow teardown of "value" memory. */
-	uatomic_or(value, AWAKE_TEARDOWN);
-}
-
-/*
- * Caller must initialize "value" to AWAKE_WAITING before passing its
- * memory to waker thread.
- */
-static void urcu_adaptative_busy_wait(int32_t *value)
-{
-	unsigned int i;
-
-	/* Load and test condition before read futex */
-	cmm_smp_rmb();
-	for (i = 0; i < RCU_AWAKE_ATTEMPTS; i++) {
-		if (uatomic_read(value) != AWAKE_WAITING)
-			goto skip_futex_wait;
-		caa_cpu_relax();
-	}
-	futex_noasync(value, FUTEX_WAIT, AWAKE_WAITING, NULL, NULL, 0);
-skip_futex_wait:
-
-	/* Tell waker thread than we are awakened. */
-	uatomic_or(value, AWAKE_AWAKENED);
-
-	/*
-	 * Wait until waker thread lets us know it's ok to tear down
-	 * memory allocated for value.
-	 */
-	for (i = 0; i < RCU_AWAKE_ATTEMPTS; i++) {
-		if (uatomic_read(value) & AWAKE_TEARDOWN)
-			break;
-		caa_cpu_relax();
-	}
-	while (!(uatomic_read(value) & AWAKE_TEARDOWN))
-		poll(NULL, 0, 10);
-	assert(uatomic_read(value) & AWAKE_TEARDOWN);
-}
-
 static void wait_for_readers(struct cds_list_head *input_readers,
 			struct cds_list_head *cur_snap_readers,
 			struct cds_list_head *qsreaders)
@@ -305,10 +239,10 @@ void synchronize_rcu(void)
 	 * if we are the first thread added into the stack.
 	 */
 	cds_wfs_node_init(&gp_waiters_thread.node);
-	gp_waiters_thread.wait_futex = AWAKE_WAITING;
+	urcu_wait_init(&gp_waiters_thread.wait);
 	if (cds_wfs_push(&gp_waiters, &gp_waiters_node) != 0) {
 		/* Not first in stack: will be awakened by another thread. */
-		urcu_adaptative_busy_wait(&gp_waiters_thread.wait_futex);
+		urcu_adaptative_busy_wait(&gp_waiters_thread.wait);
 		goto gp_end;
 	}
 
@@ -384,7 +318,7 @@ out:
 				struct gp_waiters_thread, node);
 		if (wt == &gp_waiters_thread)
 			continue;
-		urcu_adaptative_wake_up(&wt->wait_futex);
+		urcu_adaptative_wake_up(&wt->wait);
 	}
 
 gp_end:
@@ -424,10 +358,10 @@ void synchronize_rcu(void)
 	 * if we are the first thread added into the stack.
 	 */
 	cds_wfs_node_init(&gp_waiters_thread.node);
-	gp_waiters_thread.wait_futex = AWAKE_WAITING;
+	urcu_wait_init(&gp_waiters_thread.wait);
 	if (cds_wfs_push(&gp_waiters, &gp_waiters_thread.node) != 0) {
 		/* Not first in stack: will be awakened by another thread. */
-		urcu_adaptative_busy_wait(&gp_waiters_thread.wait_futex);
+		urcu_adaptative_busy_wait(&gp_waiters_thread.wait);
 		goto gp_end;
 	}
 
@@ -481,7 +415,7 @@ out:
 				struct gp_waiters_thread, node);
 		if (wt == &gp_waiters_thread)
 			continue;
-		urcu_adaptative_wake_up(&wt->wait_futex);
+		urcu_adaptative_wake_up(&wt->wait);
 	}
 
 gp_end:
diff --git a/urcu-wait.h b/urcu-wait.h
new file mode 100644
index 0000000..13f26cc
--- /dev/null
+++ b/urcu-wait.h
@@ -0,0 +1,107 @@
+#ifndef _URCU_WAIT_H
+#define _URCU_WAIT_H
+
+/*
+ * urcu-wait.h
+ *
+ * Userspace RCU library wait/wakeup management
+ *
+ * Copyright (c) 2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <urcu/uatomic.h>
+
+/*
+ * Number of busy-loop attempts before waiting on futex for grace period
+ * batching.
+ */
+#define URCU_WAIT_ATTEMPTS 1000
+
+enum urcu_wait_state {
+	/* URCU_WAIT_WAITING is compared directly (futex compares it). */
+	URCU_WAIT_WAITING =	0,
+	/* non-zero are used as masks. */
+	URCU_WAIT_WAKEUP =	(1 << 0),
+	URCU_WAIT_AWAKENED =	(1 << 1),
+	URCU_WAIT_TEARDOWN =	(1 << 2),
+};
+
+struct urcu_wait {
+	int32_t futex;
+};
+
+static inline
+void urcu_wait_init(struct urcu_wait *wait)
+{
+	wait->futex = URCU_WAIT_WAITING;
+}
+
+/*
+ * Note: urcu_adaptative_wake_up needs "value" to stay allocated
+ * throughout its execution. In this scheme, the waiter owns the futex
+ * memory, and we only allow it to free this memory when it receives the
+ * URCU_WAIT_TEARDOWN flag.
+ */
+static inline
+void urcu_adaptative_wake_up(struct urcu_wait *wait)
+{
+	cmm_smp_mb();
+	assert(uatomic_read(&wait->futex) == URCU_WAIT_WAITING);
+	uatomic_set(&wait->futex, URCU_WAIT_WAKEUP);
+	if (!(uatomic_read(&wait->futex) & URCU_WAIT_AWAKENED))
+		futex_noasync(&wait->futex, FUTEX_WAKE, 1, NULL, NULL, 0);
+	/* Allow teardown of struct urcu_wait memory. */
+	uatomic_or(&wait->futex, URCU_WAIT_TEARDOWN);
+}
+
+/*
+ * Caller must initialize "value" to URCU_WAIT_WAITING before passing its
+ * memory to waker thread.
+ */
+static void urcu_adaptative_busy_wait(struct urcu_wait *wait)
+{
+	unsigned int i;
+
+	/* Load and test condition before read futex */
+	cmm_smp_rmb();
+	for (i = 0; i < URCU_WAIT_ATTEMPTS; i++) {
+		if (uatomic_read(&wait->futex) != URCU_WAIT_WAITING)
+			goto skip_futex_wait;
+		caa_cpu_relax();
+	}
+	futex_noasync(&wait->futex, FUTEX_WAIT,
+		URCU_WAIT_WAITING, NULL, NULL, 0);
+skip_futex_wait:
+
+	/* Tell waker thread than we are awakened. */
+	uatomic_or(&wait->futex, URCU_WAIT_AWAKENED);
+
+	/*
+	 * Wait until waker thread lets us know it's ok to tear down
+	 * memory allocated for struct urcu_wait.
+	 */
+	for (i = 0; i < URCU_WAIT_ATTEMPTS; i++) {
+		if (uatomic_read(&wait->futex) & URCU_WAIT_TEARDOWN)
+			break;
+		caa_cpu_relax();
+	}
+	while (!(uatomic_read(&wait->futex) & URCU_WAIT_TEARDOWN))
+		poll(NULL, 0, 10);
+	assert(uatomic_read(&wait->futex) & URCU_WAIT_TEARDOWN);
+}
+
+#endif /* _URCU_WAIT_H */
-- 
1.7.10.4
