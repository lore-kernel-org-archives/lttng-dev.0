From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH] Fix call_rcu fork handling
Date: Tue, 18 Dec 2012 00:42:05 -0500
Message-ID: <20121218054205.GA17469__46104.2654388168$1355809368$gmane$org@Krystal>
References: <tencent_23D20B3D4C566CFC60D89D83@qq.com>
	<20121212145848.GA29236@Krystal> <20121213103537.GB8637@Krystal>
	<20121218042214.GA16410@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TkpwN-00065G-GX
	for lttng-dev@lists.lttng.org; Tue, 18 Dec 2012 00:42:07 -0500
Content-Disposition: inline
In-Reply-To: <20121218042214.GA16410@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: zs <84500316@qq.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Fix call_rcu fork handling by putting all call_rcu threads in a
quiescent state before fork (paused state), and unpausing them when the
parent returns from fork.

On the child, everything will run fine as long as we don't issue fork()
from a call_rcu callback.

Side-note: pthread_atfork is not appropriate when playing with
multithread and malloc/free. The glibc malloc implementation sadly
expects that all malloc/free are executed from the context of a single
thread while pthread atfork handlers are running, which leads to
interesting hang in glibc.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/tests/test_urcu_fork.c b/tests/test_urcu_fork.c
index 07c521a..6e454b5 100644
--- a/tests/test_urcu_fork.c
+++ b/tests/test_urcu_fork.c
@@ -85,6 +85,8 @@ int main(int argc, char **argv)
 	pid_t pid;
 	int ret;
 
+#if 0
+	/* pthread_atfork does not work with malloc/free in callbacks */
 	ret = pthread_atfork(call_rcu_before_fork,
 		call_rcu_after_fork_parent,
 		call_rcu_after_fork_child);
@@ -93,6 +95,7 @@ int main(int argc, char **argv)
 		perror("pthread_atfork");
 		exit(EXIT_FAILURE);
 	}
+#endif
 
 	test_rcu();
 
@@ -101,10 +104,12 @@ int main(int argc, char **argv)
 	fprintf(stderr, "%s parent pid: %d, before fork\n",
 		argv[0], (int) getpid());
 
+	call_rcu_before_fork();
 	pid = fork();
 
 	if (pid == 0) {
 		/* child */
+		call_rcu_after_fork_child();
 		fprintf(stderr, "%s child pid: %d, after fork\n",
 			argv[0], (int) getpid());
 		test_rcu();
@@ -114,6 +119,7 @@ int main(int argc, char **argv)
 		int status;
 
 		/* parent */
+		call_rcu_after_fork_parent();
 		fprintf(stderr, "%s parent pid: %d, after fork\n",
 			argv[0], (int) getpid());
 		test_rcu();
diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
index 6580397..f6625ba 100644
--- a/urcu-call-rcu-impl.h
+++ b/urcu-call-rcu-impl.h
@@ -75,8 +75,9 @@ static CDS_LIST_HEAD(call_rcu_data_list);
 
 static DEFINE_URCU_TLS(struct call_rcu_data *, thread_call_rcu_data);
 
-/* Guard call_rcu thread creation. */
-
+/*
+ * Guard call_rcu thread creation and atfork handlers.
+ */
 static pthread_mutex_t call_rcu_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 /* If a given thread does not have its own call_rcu thread, this is default. */
@@ -254,6 +255,21 @@ static void *call_rcu_thread(void *arg)
 		struct cds_wfcq_node *cbs, *cbs_tmp_n;
 		enum cds_wfcq_ret splice_ret;
 
+		if (uatomic_read(&crdp->flags) & URCU_CALL_RCU_PAUSE) {
+			/*
+			 * Pause requested. Become quiescent: remove
+			 * ourself from all global lists, and don't
+			 * process any callback. The callback lists may
+			 * still be non-empty though.
+			 */
+			rcu_unregister_thread();
+			cmm_smp_mb__before_uatomic_or();
+			uatomic_or(&crdp->flags, URCU_CALL_RCU_PAUSED);
+			while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_PAUSE) != 0)
+				poll(NULL, 0, 1);
+			rcu_register_thread();
+		}
+
 		cds_wfcq_init(&cbs_tmp_head, &cbs_tmp_tail);
 		splice_ret = __cds_wfcq_splice_blocking(&cbs_tmp_head,
 			&cbs_tmp_tail, &crdp->cbs_head, &crdp->cbs_tail);
@@ -705,12 +721,25 @@ void free_all_cpu_call_rcu_data(void)
 
 /*
  * Acquire the call_rcu_mutex in order to ensure that the child sees
- * all of the call_rcu() data structures in a consistent state.
+ * all of the call_rcu() data structures in a consistent state. Ensure
+ * that all call_rcu threads are in a quiescent state across fork.
  * Suitable for pthread_atfork() and friends.
  */
 void call_rcu_before_fork(void)
 {
+	struct call_rcu_data *crdp;
+
 	call_rcu_lock(&call_rcu_mutex);
+
+	cds_list_for_each_entry(crdp, &call_rcu_data_list, list) {
+		uatomic_or(&crdp->flags, URCU_CALL_RCU_PAUSE);
+		cmm_smp_mb__after_uatomic_or();
+		wake_call_rcu_thread(crdp);
+	}
+	cds_list_for_each_entry(crdp, &call_rcu_data_list, list) {
+		while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_PAUSED) == 0)
+			poll(NULL, 0, 1);
+	}
 }
 
 /*
@@ -720,6 +749,10 @@ void call_rcu_before_fork(void)
  */
 void call_rcu_after_fork_parent(void)
 {
+	struct call_rcu_data *crdp;
+
+	cds_list_for_each_entry(crdp, &call_rcu_data_list, list)
+		uatomic_and(&crdp->flags, ~URCU_CALL_RCU_PAUSE);
 	call_rcu_unlock(&call_rcu_mutex);
 }
 
@@ -752,7 +785,11 @@ void call_rcu_after_fork_child(void)
 	rcu_set_pointer(&per_cpu_call_rcu_data, NULL);
 	URCU_TLS(thread_call_rcu_data) = NULL;
 
-	/* Dispose of all of the rest of the call_rcu_data structures. */
+	/*
+	 * Dispose of all of the rest of the call_rcu_data structures.
+	 * Leftover call_rcu callbacks will be merged into the new
+	 * default call_rcu thread queue.
+	 */
 	cds_list_for_each_entry_safe(crdp, next, &call_rcu_data_list, list) {
 		if (crdp == default_call_rcu_data)
 			continue;
diff --git a/urcu-call-rcu.h b/urcu-call-rcu.h
index 1dad0e2..997bb2f 100644
--- a/urcu-call-rcu.h
+++ b/urcu-call-rcu.h
@@ -44,10 +44,12 @@ struct call_rcu_data;
 
 /* Flag values. */
 
-#define URCU_CALL_RCU_RT	0x1
-#define URCU_CALL_RCU_RUNNING	0x2
-#define URCU_CALL_RCU_STOP	0x4
-#define URCU_CALL_RCU_STOPPED	0x8
+#define URCU_CALL_RCU_RT	(1U << 0)
+#define URCU_CALL_RCU_RUNNING	(1U << 1)
+#define URCU_CALL_RCU_STOP	(1U << 2)
+#define URCU_CALL_RCU_STOPPED	(1U << 3)
+#define URCU_CALL_RCU_PAUSE	(1U << 4)
+#define URCU_CALL_RCU_PAUSED	(1U << 5)
 
 /*
  * The rcu_head data structure is placed in the structure to be freed
-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
