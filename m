From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH urcu] lfstack: test pop_all and pop
Date: Mon, 22 Oct 2012 09:04:32 -0400
Message-ID: <20121022130432.GF30944__33144.2243689255$1350911106$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TQHgH-00032f-H1
	for lttng-dev@lists.lttng.org; Mon, 22 Oct 2012 09:04:33 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Paul McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
---
diff --git a/tests/test_urcu_lfs.c b/tests/test_urcu_lfs.c
index 6c30884..c6403b1 100644
--- a/tests/test_urcu_lfs.c
+++ b/tests/test_urcu_lfs.c
@@ -68,6 +68,16 @@ static inline pid_t gettid(void)
 #include <urcu.h>
 #include <urcu/cds.h>
 
+/*
+ * External synchronization used.
+ */
+enum test_sync {
+	TEST_SYNC_NONE = 0,
+	TEST_SYNC_RCU,
+};
+
+static enum test_sync test_sync;
+
 static volatile int test_go, test_stop;
 
 static unsigned long rduration;
@@ -85,10 +95,12 @@ static inline void loop_sleep(unsigned long loops)
 
 static int verbose_mode;
 
+static int test_pop, test_pop_all;
+
 #define printf_verbose(fmt, args...)		\
 	do {					\
 		if (verbose_mode)		\
-			printf(fmt, args);	\
+			printf(fmt, ## args);	\
 	} while (0)
 
 static unsigned int cpu_affinities[NR_CPUS];
@@ -216,6 +228,52 @@ void free_node_cb(struct rcu_head *head)
 	free(node);
 }
 
+static
+void do_test_pop(enum test_sync sync)
+{
+	struct cds_lfs_node *snode;
+
+	if (sync == TEST_SYNC_RCU)
+		rcu_read_lock();
+	snode = __cds_lfs_pop(&s);
+	if (sync == TEST_SYNC_RCU)
+		rcu_read_unlock();
+	if (snode) {
+		struct test *node;
+
+		node = caa_container_of(snode,
+			struct test, list);
+		if (sync == TEST_SYNC_RCU)
+			call_rcu(&node->rcu, free_node_cb);
+		else
+			free(node);
+		URCU_TLS(nr_successful_dequeues)++;
+	}
+	URCU_TLS(nr_dequeues)++;
+}
+
+static
+void do_test_pop_all(enum test_sync sync)
+{
+	struct cds_lfs_node *snode;
+	struct cds_lfs_head *head;
+	struct cds_lfs_node *n;
+
+	head = __cds_lfs_pop_all(&s);
+	cds_lfs_for_each_safe(head, snode, n) {
+		struct test *node;
+
+		node = caa_container_of(snode, struct test, list);
+		if (sync == TEST_SYNC_RCU)
+			call_rcu(&node->rcu, free_node_cb);
+		else
+			free(node);
+		URCU_TLS(nr_successful_dequeues)++;
+		URCU_TLS(nr_dequeues)++;
+	}
+
+}
+
 void *thr_dequeuer(void *_count)
 {
 	unsigned long long *count = _count;
@@ -232,20 +290,25 @@ void *thr_dequeuer(void *_count)
 	}
 	cmm_smp_mb();
 
-	for (;;) {
-		struct cds_lfs_node *snode;
-
-		rcu_read_lock();
-		snode = __cds_lfs_pop(&s);
-		rcu_read_unlock();
-		if (snode) {
-			struct test *node;
+	assert(test_pop || test_pop_all);
 
-			node = caa_container_of(snode, struct test, list);
-			call_rcu(&node->rcu, free_node_cb);
-			URCU_TLS(nr_successful_dequeues)++;
+	for (;;) {
+		unsigned int counter = 0;
+
+		if (test_pop && test_pop_all) {
+			/* both pop and pop all */
+			if (counter & 1)
+				do_test_pop(test_sync);
+			else
+				do_test_pop_all(test_sync);
+			counter++;
+		} else {
+			if (test_pop)
+				do_test_pop(test_sync);
+			else
+				do_test_pop_all(test_sync);
 		}
-		URCU_TLS(nr_dequeues)++;
+
 		if (caa_unlikely(!test_duration_dequeue()))
 			break;
 		if (caa_unlikely(rduration))
@@ -286,6 +349,10 @@ void show_usage(int argc, char **argv)
 	printf(" [-c duration] (dequeuer period (in loops))");
 	printf(" [-v] (verbose output)");
 	printf(" [-a cpu#] [-a cpu#]... (affinity)");
+	printf(" [-p] (test pop)");
+	printf(" [-P] (test pop_all, enabled by default)");
+	printf(" [-R] (use RCU external synchronization)");
+	printf("      Note: default: no external synchronization used.");
 	printf("\n");
 }
 
@@ -355,12 +422,29 @@ int main(int argc, char **argv)
 		case 'v':
 			verbose_mode = 1;
 			break;
+		case 'p':
+			test_pop = 1;
+			break;
+		case 'P':
+			test_pop_all = 1;
+			break;
+		case 'R':
+			test_sync = TEST_SYNC_RCU;
+			break;
 		}
 	}
 
+	/* activate pop_all test by default */
+	if (!test_pop && !test_pop_all)
+		test_pop_all = 1;
+
 	printf_verbose("running test for %lu seconds, %u enqueuers, "
 		       "%u dequeuers.\n",
 		       duration, nr_enqueuers, nr_dequeuers);
+	if (test_pop)
+		printf_verbose("pop test activated.\n");
+	if (test_pop_all)
+		printf_verbose("pop_all test activated.\n");
 	printf_verbose("Writer delay : %lu loops.\n", rduration);
 	printf_verbose("Reader duration : %lu loops.\n", wdelay);
 	printf_verbose("thread %-6s, thread id : %lx, tid %lu\n",

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
