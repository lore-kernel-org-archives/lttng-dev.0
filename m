From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH urcu] Implement rcu_barrier()
Date: Fri, 31 May 2013 11:35:17 -0400
Message-ID: <20130531153517.GA12809__633.059876463626$1370014559$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UiRMP-0007WB-Gj
	for lttng-dev@lists.lttng.org; Fri, 31 May 2013 11:35:21 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: Stephen Hemminger <shemminger@vyatta.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: lttng-dev@lists.lttng.org

Awaits for all in-flight call_rcu handlers to complete execution before
returning.
    
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
index f7f0f71..fb3568f 100644
--- a/urcu-call-rcu-impl.h
+++ b/urcu-call-rcu-impl.h
@@ -64,6 +64,16 @@ struct call_rcu_data {
 	struct cds_list_head list;
 } __attribute__((aligned(CAA_CACHE_LINE_SIZE)));
 
+struct call_rcu_completion {
+	int barrier_count;
+	int32_t futex;
+};
+
+struct call_rcu_completion_work {
+	struct rcu_head head;
+	struct call_rcu_completion *completion;
+};
+
 /*
  * List of all call_rcu_data structures to keep valgrind happy.
  * Protected by call_rcu_mutex.
@@ -236,6 +246,26 @@ static void call_rcu_wake_up(struct call_rcu_data *crdp)
 	}
 }
 
+static void call_rcu_completion_wait(struct call_rcu_completion *completion)
+{
+	/* Read completion barrier count before read futex */
+	cmm_smp_mb();
+	if (uatomic_read(&completion->futex) == -1)
+		futex_async(&completion->futex, FUTEX_WAIT, -1,
+		      NULL, NULL, 0);
+}
+
+static void call_rcu_completion_wake_up(struct call_rcu_completion *completion)
+{
+	/* Write to completion barrier count before reading/writing futex */
+	cmm_smp_mb();
+	if (caa_unlikely(uatomic_read(&completion->futex) == -1)) {
+		uatomic_set(&completion->futex, 0);
+		futex_async(&completion->futex, FUTEX_WAKE, 1,
+		      NULL, NULL, 0);
+	}
+}
+
 /* This is the code run by each call_rcu thread. */
 
 static void *call_rcu_thread(void *arg)
@@ -604,6 +634,17 @@ static void wake_call_rcu_thread(struct call_rcu_data *crdp)
 		call_rcu_wake_up(crdp);
 }
 
+static void _call_rcu(struct rcu_head *head,
+		      void (*func)(struct rcu_head *head),
+		      struct call_rcu_data *crdp)
+{
+	cds_wfcq_node_init(&head->next);
+	head->func = func;
+	cds_wfcq_enqueue(&crdp->cbs_head, &crdp->cbs_tail, &head->next);
+	uatomic_inc(&crdp->qlen);
+	wake_call_rcu_thread(crdp);
+}
+
 /*
  * Schedule a function to be invoked after a following grace period.
  * This is the only function that must be called -- the others are
@@ -618,20 +659,15 @@ static void wake_call_rcu_thread(struct call_rcu_data *crdp)
  *
  * call_rcu must be called by registered RCU read-side threads.
  */
-
 void call_rcu(struct rcu_head *head,
 	      void (*func)(struct rcu_head *head))
 {
 	struct call_rcu_data *crdp;
 
-	cds_wfcq_node_init(&head->next);
-	head->func = func;
 	/* Holding rcu read-side lock across use of per-cpu crdp */
 	rcu_read_lock();
 	crdp = get_call_rcu_data();
-	cds_wfcq_enqueue(&crdp->cbs_head, &crdp->cbs_tail, &head->next);
-	uatomic_inc(&crdp->qlen);
-	wake_call_rcu_thread(crdp);
+	_call_rcu(head, func, crdp);
 	rcu_read_unlock();
 }
 
@@ -730,6 +766,89 @@ void free_all_cpu_call_rcu_data(void)
 	free(crdp);
 }
 
+static
+void _rcu_barrier_complete(struct rcu_head *head)
+{
+	struct call_rcu_completion_work *work;
+	struct call_rcu_completion *completion;
+
+	work = caa_container_of(head, struct call_rcu_completion_work, head);
+	completion = work->completion;
+	uatomic_dec(&completion->barrier_count);
+	call_rcu_completion_wake_up(completion);
+	free(work);
+}
+
+/*
+ * Wait for all in-flight call_rcu callbacks to complete execution.
+ */
+void rcu_barrier(void)
+{
+	struct call_rcu_data *crdp;
+	struct call_rcu_completion completion;
+	int count = 0, work_count = 0;
+	int was_online;
+
+	/* Put in offline state in QSBR. */
+	was_online = rcu_read_ongoing();
+	if (was_online)
+		rcu_thread_offline();
+	/*
+	 * Calling a rcu_barrier() within a RCU read-side critical
+	 * section is an error.
+	 */
+	if (rcu_read_ongoing()) {
+		static int warned = 0;
+
+		if (!warned) {
+			fprintf(stderr, "[error] liburcu: rcu_barrier() called from within RCU read-side critical section.\n");
+		}
+		warned = 1;
+		goto online;
+	}
+
+	call_rcu_lock(&call_rcu_mutex);
+	cds_list_for_each_entry(crdp, &call_rcu_data_list, list)
+		count++;
+
+	completion.barrier_count = count;
+
+	cds_list_for_each_entry(crdp, &call_rcu_data_list, list) {
+		struct call_rcu_completion_work *work;
+
+		work = calloc(sizeof(*work), 1);
+		if (!work) {
+			static int warned = 0;
+
+			if (!warned) {
+				fprintf(stderr, "[error] liburcu: unable to allocate memory for rcu_barrier()\n");
+			}
+			warned = 1;
+			break;
+		}
+		work->completion = &completion;
+		_call_rcu(&work->head, _rcu_barrier_complete, crdp);
+		work_count++;
+	}
+	call_rcu_unlock(&call_rcu_mutex);
+
+	if (work_count != count)
+		uatomic_sub(&completion.barrier_count, count - work_count);
+
+	/* Wait for them */
+	for (;;) {
+		uatomic_dec(&completion.futex);
+		/* Decrement futex before reading barrier_count */
+		cmm_smp_mb();
+		if (!uatomic_read(&completion.barrier_count))
+			break;
+		call_rcu_completion_wait(&completion);
+	}
+online:
+	if (was_online)
+		rcu_thread_online();
+}
+
 /*
  * Acquire the call_rcu_mutex in order to ensure that the child sees
  * all of the call_rcu() data structures in a consistent state. Ensure
diff --git a/urcu-call-rcu.h b/urcu-call-rcu.h
index 997bb2f..30388c5 100644
--- a/urcu-call-rcu.h
+++ b/urcu-call-rcu.h
@@ -92,6 +92,8 @@ void call_rcu_before_fork(void);
 void call_rcu_after_fork_parent(void);
 void call_rcu_after_fork_child(void);
 
+void rcu_barrier(void);
+
 #ifdef __cplusplus 
 }
 #endif
diff --git a/urcu-flavor.h b/urcu-flavor.h
index c04f1db..5e7f292 100644
--- a/urcu-flavor.h
+++ b/urcu-flavor.h
@@ -41,6 +41,8 @@ struct rcu_flavor_struct {
 	void (*thread_online)(void);
 	void (*register_thread)(void);
 	void (*unregister_thread)(void);
+
+	void (*barrier)(void);
 };
 
 #define DEFINE_RCU_FLAVOR(x)				\
@@ -56,6 +58,7 @@ const struct rcu_flavor_struct x = {			\
 	.thread_online		= rcu_thread_online,	\
 	.register_thread	= rcu_register_thread,	\
 	.unregister_thread	= rcu_unregister_thread,\
+	.barrier		= rcu_barrier,		\
 }
 
 extern const struct rcu_flavor_struct rcu_flavor;
diff --git a/urcu/map/urcu-bp.h b/urcu/map/urcu-bp.h
index 92863fe..67ba5c3 100644
--- a/urcu/map/urcu-bp.h
+++ b/urcu/map/urcu-bp.h
@@ -63,6 +63,7 @@
 #define call_rcu_before_fork		call_rcu_before_fork_bp
 #define call_rcu_after_fork_parent	call_rcu_after_fork_parent_bp
 #define call_rcu_after_fork_child	call_rcu_after_fork_child_bp
+#define rcu_barrier			rcu_barrier_bp
 
 #define defer_rcu			defer_rcu_bp
 #define rcu_defer_register_thread	rcu_defer_register_thread_bp
diff --git a/urcu/map/urcu-qsbr.h b/urcu/map/urcu-qsbr.h
index e3261ff..b89dd24 100644
--- a/urcu/map/urcu-qsbr.h
+++ b/urcu/map/urcu-qsbr.h
@@ -65,6 +65,7 @@
 #define call_rcu_before_fork		call_rcu_before_fork_qsbr
 #define call_rcu_after_fork_parent	call_rcu_after_fork_parent_qsbr
 #define call_rcu_after_fork_child	call_rcu_after_fork_child_qsbr
+#define rcu_barrier			rcu_barrier_qsbr
 
 #define defer_rcu			defer_rcu_qsbr
 #define rcu_defer_register_thread	rcu_defer_register_thread_qsbr
diff --git a/urcu/map/urcu.h b/urcu/map/urcu.h
index 77b3721..8f04caf 100644
--- a/urcu/map/urcu.h
+++ b/urcu/map/urcu.h
@@ -69,6 +69,7 @@
 #define call_rcu_before_fork		call_rcu_before_fork_memb
 #define call_rcu_after_fork_parent	call_rcu_after_fork_parent_memb
 #define call_rcu_after_fork_child	call_rcu_after_fork_child_memb
+#define rcu_barrier			rcu_barrier_memb
 
 #define defer_rcu			defer_rcu_memb
 #define rcu_defer_register_thread	rcu_defer_register_thread_memb
@@ -116,6 +117,7 @@
 #define call_rcu_before_fork		call_rcu_before_fork_sig
 #define call_rcu_after_fork_parent	call_rcu_after_fork_parent_sig
 #define call_rcu_after_fork_child	call_rcu_after_fork_child_sig
+#define rcu_barrier			rcu_barrier_sig
 
 #define defer_rcu			defer_rcu_sig
 #define rcu_defer_register_thread	rcu_defer_register_thread_sig
@@ -160,6 +162,7 @@
 #define call_rcu_before_fork		call_rcu_before_fork_mb
 #define call_rcu_after_fork_parent	call_rcu_after_fork_parent_mb
 #define call_rcu_after_fork_child	call_rcu_after_fork_child_mb
+#define rcu_barrier			rcu_barrier_mb
 
 #define defer_rcu			defer_rcu_mb
 #define rcu_defer_register_thread	rcu_defer_register_thread_mb

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
