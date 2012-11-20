From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 16/16] urcu-wait: move queue management code
	into urcu-wait.h
Date: Tue, 20 Nov 2012 14:40:29 -0500
Message-ID: <1353440429-19223-17-git-send-email-mathieu.desnoyers__10322.9765700691$1353442999$gmane$org@efficios.com>
References: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1TathV-0001PX-Rn
	for lttng-dev@lists.lttng.org; Tue, 20 Nov 2012 14:41:41 -0500
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

Note: urcu-wait.h is not yet exposed outside of userspace RCU.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 urcu-qsbr.c |   72 ++++++++++--------------------------
 urcu-wait.h |  119 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 117 insertions(+), 74 deletions(-)

diff --git a/urcu-qsbr.c b/urcu-qsbr.c
index d691389..9ae17de 100644
--- a/urcu-qsbr.c
+++ b/urcu-qsbr.c
@@ -80,19 +80,11 @@ DEFINE_URCU_TLS(unsigned int, rcu_rand_yield);
 
 static CDS_LIST_HEAD(registry);
 
-struct gp_waiters_thread {
-	struct cds_wfs_node node;
-	struct urcu_wait wait;
-};
-
 /*
  * Stack keeping threads awaiting to wait for a grace period. Contains
  * struct gp_waiters_thread objects.
  */
-static struct cds_wfs_stack gp_waiters = {
-	.head = CDS_WFS_END,
-	.lock = PTHREAD_MUTEX_INITIALIZER,
-};
+static DEFINE_URCU_WAIT_QUEUE(gp_waiters);
 
 static void mutex_lock(pthread_mutex_t *mutex)
 {
@@ -214,9 +206,8 @@ void synchronize_rcu(void)
 	CDS_LIST_HEAD(cur_snap_readers);
 	CDS_LIST_HEAD(qsreaders);
 	unsigned long was_online;
-	struct gp_waiters_thread gp_waiters_thread;
-	struct cds_wfs_head *gp_waiters_head;
-	struct cds_wfs_node *waiters_iter, *waiters_iter_n;
+	DEFINE_URCU_WAIT_NODE(wait, URCU_WAIT_WAITING);
+	struct urcu_waiters waiters;
 
 	was_online = URCU_TLS(rcu_reader).ctr;
 
@@ -238,20 +229,20 @@ void synchronize_rcu(void)
 	 * for a grace period. Proceed to perform the grace period only
 	 * if we are the first thread added into the stack.
 	 */
-	cds_wfs_node_init(&gp_waiters_thread.node);
-	urcu_wait_init(&gp_waiters_thread.wait);
-	if (cds_wfs_push(&gp_waiters, &gp_waiters_node) != 0) {
+	if (urcu_wait_add(&gp_waiters, &wait) != 0) {
 		/* Not first in stack: will be awakened by another thread. */
-		urcu_adaptative_busy_wait(&gp_waiters_thread.wait);
+		urcu_adaptative_busy_wait(&wait);
 		goto gp_end;
 	}
+	/* We won't need to wake ourself up */
+	urcu_wait_set_state(&wait, URCU_WAIT_RUNNING);
 
 	mutex_lock(&rcu_gp_lock);
 
 	/*
-	 * Pop all waiters into our local stack head.
+	 * Move all waiters into our local queue.
 	 */
-	gp_waiters_head = __cds_wfs_pop_all(&gp_waiters);
+	urcu_move_waiters(&waiters, &gp_waiters);
 
 	if (cds_list_empty(&registry))
 		goto out;
@@ -308,19 +299,7 @@ void synchronize_rcu(void)
 	cds_list_splice(&qsreaders, &registry);
 out:
 	mutex_unlock(&rcu_gp_lock);
-
-	/* Wake all waiters in our stack head, excluding ourself. */
-	cds_wfs_for_each_blocking_safe(gp_waiters_head, waiters_iter,
-				waiters_iter_n) {
-		struct gp_waiters_thread *wt;
-
-		wt = caa_container_of(waiters_iter,
-				struct gp_waiters_thread, node);
-		if (wt == &gp_waiters_thread)
-			continue;
-		urcu_adaptative_wake_up(&wt->wait);
-	}
-
+	urcu_wake_all_waiters(&waiters);
 gp_end:
 	/*
 	 * Finish waiting for reader threads before letting the old ptr being
@@ -336,9 +315,8 @@ void synchronize_rcu(void)
 {
 	CDS_LIST_HEAD(qsreaders);
 	unsigned long was_online;
-	struct gp_waiters_thread gp_waiters_thread;
-	struct cds_wfs_head *gp_waiters_head;
-	struct cds_wfs_node *waiters_iter, *waiters_iter_n;
+	DEFINE_URCU_WAIT_NODE(wait, URCU_WAIT_WAITING);
+	struct urcu_waiters waiters;
 
 	was_online = URCU_TLS(rcu_reader).ctr;
 
@@ -357,20 +335,20 @@ void synchronize_rcu(void)
 	 * for a grace period. Proceed to perform the grace period only
 	 * if we are the first thread added into the stack.
 	 */
-	cds_wfs_node_init(&gp_waiters_thread.node);
-	urcu_wait_init(&gp_waiters_thread.wait);
-	if (cds_wfs_push(&gp_waiters, &gp_waiters_thread.node) != 0) {
+	if (urcu_wait_add(&gp_waiters, &wait) != 0) {
 		/* Not first in stack: will be awakened by another thread. */
-		urcu_adaptative_busy_wait(&gp_waiters_thread.wait);
+		urcu_adaptative_busy_wait(&wait);
 		goto gp_end;
 	}
+	/* We won't need to wake ourself up */
+	urcu_wait_set_state(&wait, URCU_WAIT_RUNNING);
 
 	mutex_lock(&rcu_gp_lock);
 
 	/*
-	 * Pop all waiters into our local stack head.
+	 * Move all waiters into our local queue.
 	 */
-	gp_waiters_head = __cds_wfs_pop_all(&gp_waiters);
+	urcu_move_waiters(&waiters, &gp_waiters);
 
 	if (cds_list_empty(&registry))
 		goto out;
@@ -405,19 +383,7 @@ void synchronize_rcu(void)
 	cds_list_splice(&qsreaders, &registry);
 out:
 	mutex_unlock(&rcu_gp_lock);
-
-	/* Wake all waiters in our stack head, excluding ourself. */
-	cds_wfs_for_each_blocking_safe(gp_waiters_head, waiters_iter,
-				waiters_iter_n) {
-		struct gp_waiters_thread *wt;
-
-		wt = caa_container_of(waiters_iter,
-				struct gp_waiters_thread, node);
-		if (wt == &gp_waiters_thread)
-			continue;
-		urcu_adaptative_wake_up(&wt->wait);
-	}
-
+	urcu_wake_all_waiters(&waiters);
 gp_end:
 	if (was_online)
 		rcu_thread_online();
diff --git a/urcu-wait.h b/urcu-wait.h
index 13f26cc..e365b7c 100644
--- a/urcu-wait.h
+++ b/urcu-wait.h
@@ -24,6 +24,7 @@
  */
 
 #include <urcu/uatomic.h>
+#include <urcu/wfstack.h>
 
 /*
  * Number of busy-loop attempts before waiting on futex for grace period
@@ -36,72 +37,148 @@ enum urcu_wait_state {
 	URCU_WAIT_WAITING =	0,
 	/* non-zero are used as masks. */
 	URCU_WAIT_WAKEUP =	(1 << 0),
-	URCU_WAIT_AWAKENED =	(1 << 1),
+	URCU_WAIT_RUNNING =	(1 << 1),
 	URCU_WAIT_TEARDOWN =	(1 << 2),
 };
 
-struct urcu_wait {
-	int32_t futex;
+struct urcu_wait_node {
+	struct cds_wfs_node node;
+	int32_t state;	/* enum urcu_wait_state */
 };
 
+#define URCU_WAIT_NODE_INIT(name, _state)		\
+	{ .state = _state }
+
+#define DEFINE_URCU_WAIT_NODE(name, state)		\
+	struct urcu_wait_node name = URCU_WAIT_NODE_INIT(name, state)
+
+#define DECLARE_URCU_WAIT_NODE(name)			\
+	struct urcu_wait_node name
+
+struct urcu_wait_queue {
+	struct cds_wfs_stack stack;
+};
+
+#define URCU_WAIT_QUEUE_HEAD_INIT(name)			\
+	{ .stack.head = CDS_WFS_END, .stack.lock = PTHREAD_MUTEX_INITIALIZER }
+
+#define DECLARE_URCU_WAIT_QUEUE(name)			\
+	struct urcu_wait_queue name
+
+#define DEFINE_URCU_WAIT_QUEUE(name)			\
+	struct urcu_wait_queue name = URCU_WAIT_QUEUE_HEAD_INIT(name)
+
+struct urcu_waiters {
+	struct cds_wfs_head *head;
+};
+
+/*
+ * Add ourself atomically to a wait queue. Return 0 if queue was
+ * previously empty, else return 1.
+ */
+static inline
+bool urcu_wait_add(struct urcu_wait_queue *queue,
+		struct urcu_wait_node *node)
+{
+	return cds_wfs_push(&queue->stack, &node->node);
+}
+
+/*
+ * Atomically move all waiters from wait queue into our local struct
+ * urcu_waiters.
+ */
+static inline
+void urcu_move_waiters(struct urcu_waiters *waiters,
+		struct urcu_wait_queue *queue)
+{
+	waiters->head = __cds_wfs_pop_all(&queue->stack);
+}
+
+static inline
+void urcu_wait_set_state(struct urcu_wait_node *node,
+		enum urcu_wait_state state)
+{
+	node->state = state;
+}
+
 static inline
-void urcu_wait_init(struct urcu_wait *wait)
+void urcu_wait_node_init(struct urcu_wait_node *node,
+		enum urcu_wait_state state)
 {
-	wait->futex = URCU_WAIT_WAITING;
+	urcu_wait_set_state(node, state);
+	cds_wfs_node_init(&node->node);
 }
 
 /*
  * Note: urcu_adaptative_wake_up needs "value" to stay allocated
- * throughout its execution. In this scheme, the waiter owns the futex
+ * throughout its execution. In this scheme, the waiter owns the node
  * memory, and we only allow it to free this memory when it receives the
  * URCU_WAIT_TEARDOWN flag.
  */
 static inline
-void urcu_adaptative_wake_up(struct urcu_wait *wait)
+void urcu_adaptative_wake_up(struct urcu_wait_node *wait)
 {
 	cmm_smp_mb();
-	assert(uatomic_read(&wait->futex) == URCU_WAIT_WAITING);
-	uatomic_set(&wait->futex, URCU_WAIT_WAKEUP);
-	if (!(uatomic_read(&wait->futex) & URCU_WAIT_AWAKENED))
-		futex_noasync(&wait->futex, FUTEX_WAKE, 1, NULL, NULL, 0);
+	assert(uatomic_read(&wait->state) == URCU_WAIT_WAITING);
+	uatomic_set(&wait->state, URCU_WAIT_WAKEUP);
+	if (!(uatomic_read(&wait->state) & URCU_WAIT_RUNNING))
+		futex_noasync(&wait->state, FUTEX_WAKE, 1, NULL, NULL, 0);
 	/* Allow teardown of struct urcu_wait memory. */
-	uatomic_or(&wait->futex, URCU_WAIT_TEARDOWN);
+	uatomic_or(&wait->state, URCU_WAIT_TEARDOWN);
 }
 
 /*
  * Caller must initialize "value" to URCU_WAIT_WAITING before passing its
  * memory to waker thread.
  */
-static void urcu_adaptative_busy_wait(struct urcu_wait *wait)
+static inline
+void urcu_adaptative_busy_wait(struct urcu_wait_node *wait)
 {
 	unsigned int i;
 
-	/* Load and test condition before read futex */
+	/* Load and test condition before read state */
 	cmm_smp_rmb();
 	for (i = 0; i < URCU_WAIT_ATTEMPTS; i++) {
-		if (uatomic_read(&wait->futex) != URCU_WAIT_WAITING)
+		if (uatomic_read(&wait->state) != URCU_WAIT_WAITING)
 			goto skip_futex_wait;
 		caa_cpu_relax();
 	}
-	futex_noasync(&wait->futex, FUTEX_WAIT,
+	futex_noasync(&wait->state, FUTEX_WAIT,
 		URCU_WAIT_WAITING, NULL, NULL, 0);
 skip_futex_wait:
 
-	/* Tell waker thread than we are awakened. */
-	uatomic_or(&wait->futex, URCU_WAIT_AWAKENED);
+	/* Tell waker thread than we are runnning. */
+	uatomic_or(&wait->state, URCU_WAIT_RUNNING);
 
 	/*
 	 * Wait until waker thread lets us know it's ok to tear down
 	 * memory allocated for struct urcu_wait.
 	 */
 	for (i = 0; i < URCU_WAIT_ATTEMPTS; i++) {
-		if (uatomic_read(&wait->futex) & URCU_WAIT_TEARDOWN)
+		if (uatomic_read(&wait->state) & URCU_WAIT_TEARDOWN)
 			break;
 		caa_cpu_relax();
 	}
-	while (!(uatomic_read(&wait->futex) & URCU_WAIT_TEARDOWN))
+	while (!(uatomic_read(&wait->state) & URCU_WAIT_TEARDOWN))
 		poll(NULL, 0, 10);
-	assert(uatomic_read(&wait->futex) & URCU_WAIT_TEARDOWN);
+	assert(uatomic_read(&wait->state) & URCU_WAIT_TEARDOWN);
+}
+
+static inline
+void urcu_wake_all_waiters(struct urcu_waiters *waiters)
+{
+	struct cds_wfs_node *iter, *iter_n;
+
+	/* Wake all waiters in our stack head */
+	cds_wfs_for_each_blocking_safe(waiters->head, iter, iter_n) {
+		struct urcu_wait_node *wait_node =
+			caa_container_of(iter, struct urcu_wait_node, node);
+
+		/* Don't wake already running threads */
+		if (wait_node->state & URCU_WAIT_RUNNING)
+			continue;
+		urcu_adaptative_wake_up(wait_node);
+	}
 }
 
 #endif /* _URCU_WAIT_H */
-- 
1.7.10.4
