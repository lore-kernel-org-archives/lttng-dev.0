From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] Fix: call_rcu_thread() affinity failure
Date: Mon, 29 Jun 2015 18:56:34 -0400
Message-ID: <1435618594-16125-1-git-send-email-mathieu.desnoyers__48179.1371167221$1435618657$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Z9hyn-0001b1-Ac
 for lttng-dev@lists.lttng.org; Mon, 29 Jun 2015 18:56:48 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Make call_rcu_thread() affine itself more persistently

Currently, URCU simply fails if a call_rcu_thread() fails to affine
itself. This is problematic when execution is constrained by cgroup
and hotunplugged CPUs. This commit therefore makes call_rcu_thread()
retry setting its affinity every 256 grace periods, but only if it
detects that it migrated to a different CPU. Since sched_getcpu() is
cheap on many architectures, this check is less costly than going
through a system call.

Reported-by: Michael Jeanson <mjeanson@efficios.com>
Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 urcu-call-rcu-impl.h | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
index 5cc02d9..b82a59b 100644
--- a/urcu-call-rcu-impl.h
+++ b/urcu-call-rcu-impl.h
@@ -45,6 +45,9 @@
 #include "urcu/ref.h"
 #include "urcu-die.h"
 
+#define SET_AFFINITY_CHECK_PERIOD		(1U << 8)	/* 256 */
+#define SET_AFFINITY_CHECK_PERIOD_MASK		(SET_AFFINITY_CHECK_PERIOD - 1)
+
 /* Data structure that identifies a call_rcu thread. */
 
 struct call_rcu_data {
@@ -62,6 +65,7 @@ struct call_rcu_data {
 	unsigned long qlen; /* maintained for debugging. */
 	pthread_t tid;
 	int cpu_affinity;
+	unsigned long gp_count;
 	struct cds_list_head list;
 } __attribute__((aligned(CAA_CACHE_LINE_SIZE)));
 
@@ -203,22 +207,42 @@ static void call_rcu_unlock(pthread_mutex_t *pmp)
 		urcu_die(ret);
 }
 
+/*
+ * Periodically retry setting CPU affinity if we migrate.
+ * Losing affinity can be caused by CPU hotunplug/hotplug, or by
+ * cpuset(7).
+ */
 #if HAVE_SCHED_SETAFFINITY
 static
 int set_thread_cpu_affinity(struct call_rcu_data *crdp)
 {
 	cpu_set_t mask;
+	int ret;
 
 	if (crdp->cpu_affinity < 0)
 		return 0;
+	if (++crdp->gp_count & SET_AFFINITY_CHECK_PERIOD_MASK)
+		return 0;
+	if (urcu_sched_getcpu() != crdp->cpu_affinity)
+		return 0;
 
 	CPU_ZERO(&mask);
 	CPU_SET(crdp->cpu_affinity, &mask);
 #if SCHED_SETAFFINITY_ARGS == 2
-	return sched_setaffinity(0, &mask);
+	ret = sched_setaffinity(0, &mask);
 #else
-	return sched_setaffinity(0, sizeof(mask), &mask);
+	ret = sched_setaffinity(0, sizeof(mask), &mask);
 #endif
+	/*
+	 * EINVAL is fine: can be caused by hotunplugged CPUs, or by
+	 * cpuset(7). This is why we should always retry is we detect
+	 * migration.
+	 */
+	if (ret && errno == EINVAL) {
+		ret = 0;
+		errno = 0;
+	}
+	return ret;
 }
 #else
 static
@@ -275,10 +299,8 @@ static void *call_rcu_thread(void *arg)
 	unsigned long cbcount;
 	struct call_rcu_data *crdp = (struct call_rcu_data *) arg;
 	int rt = !!(uatomic_read(&crdp->flags) & URCU_CALL_RCU_RT);
-	int ret;
 
-	ret = set_thread_cpu_affinity(crdp);
-	if (ret)
+	if (set_thread_cpu_affinity(crdp))
 		urcu_die(errno);
 
 	/*
@@ -298,6 +320,9 @@ static void *call_rcu_thread(void *arg)
 		struct cds_wfcq_node *cbs, *cbs_tmp_n;
 		enum cds_wfcq_ret splice_ret;
 
+		if (set_thread_cpu_affinity(crdp))
+			urcu_die(errno);
+
 		if (uatomic_read(&crdp->flags) & URCU_CALL_RCU_PAUSE) {
 			/*
 			 * Pause requested. Become quiescent: remove
@@ -391,6 +416,7 @@ static void call_rcu_data_init(struct call_rcu_data **crdpp,
 	crdp->flags = flags;
 	cds_list_add(&crdp->list, &call_rcu_data_list);
 	crdp->cpu_affinity = cpu_affinity;
+	crdp->gp_count = 0;
 	cmm_smp_mb();  /* Structure initialized before pointer is planted. */
 	*crdpp = crdp;
 	ret = pthread_create(&crdp->tid, NULL, call_rcu_thread, crdp);
-- 
2.1.4
