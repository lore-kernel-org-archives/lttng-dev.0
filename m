From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] test wfcqueue: add tests for queue state return
	value
Date: Sun, 18 Nov 2012 10:43:14 -0500
Message-ID: <20121118154314.GB29968__21784.7075932243$1353253439$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Ta71l-0002oj-1V
	for lttng-dev@lists.lttng.org; Sun, 18 Nov 2012 10:43:21 -0500
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
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

with e.g. ./test_urcu_wfcq 2 2 10 -w

we can confirm that we see as many "enqueue to empty queue" as we see
"splice from non-empty queue", which confirms that the queue state
returned by enqueue is indeed sampled atomically with enqueue.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
---
diff --git a/tests/test_urcu_wfcq.c b/tests/test_urcu_wfcq.c
index f90fc14..1dc7e0d 100644
--- a/tests/test_urcu_wfcq.c
+++ b/tests/test_urcu_wfcq.c
@@ -75,7 +75,7 @@ enum test_sync {
 
 static enum test_sync test_sync;
 
-static volatile int test_go, test_stop;
+static volatile int test_go, test_stop_enqueue, test_stop_dequeue;
 
 static unsigned long rduration;
 
@@ -92,7 +92,7 @@ static inline void loop_sleep(unsigned long loops)
 
 static int verbose_mode;
 
-static int test_dequeue, test_splice;
+static int test_dequeue, test_splice, test_wait_empty;
 
 #define printf_verbose(fmt, args...)		\
 	do {					\
@@ -150,12 +150,12 @@ static void set_affinity(void)
  */
 static int test_duration_dequeue(void)
 {
-	return !test_stop;
+	return !test_stop_dequeue;
 }
 
 static int test_duration_enqueue(void)
 {
-	return !test_stop;
+	return !test_stop_enqueue;
 }
 
 static DEFINE_URCU_TLS(unsigned long long, nr_dequeues);
@@ -163,6 +163,8 @@ static DEFINE_URCU_TLS(unsigned long long, nr_enqueues);
 
 static DEFINE_URCU_TLS(unsigned long long, nr_successful_dequeues);
 static DEFINE_URCU_TLS(unsigned long long, nr_successful_enqueues);
+static DEFINE_URCU_TLS(unsigned long long, nr_empty_dest_enqueues);
+static DEFINE_URCU_TLS(unsigned long long, nr_splice);
 
 static unsigned int nr_enqueuers;
 static unsigned int nr_dequeuers;
@@ -173,6 +175,7 @@ static struct cds_wfcq_tail __attribute__((aligned(CAA_CACHE_LINE_SIZE))) tail;
 static void *thr_enqueuer(void *_count)
 {
 	unsigned long long *count = _count;
+	bool was_nonempty;
 
 	printf_verbose("thread_begin %s, thread id : %lx, tid %lu\n",
 			"enqueuer", (unsigned long) pthread_self(),
@@ -190,8 +193,10 @@ static void *thr_enqueuer(void *_count)
 		if (!node)
 			goto fail;
 		cds_wfcq_node_init(node);
-		cds_wfcq_enqueue(&head, &tail, node);
+		was_nonempty = cds_wfcq_enqueue(&head, &tail, node);
 		URCU_TLS(nr_successful_enqueues)++;
+		if (!was_nonempty)
+			URCU_TLS(nr_empty_dest_enqueues)++;
 
 		if (caa_unlikely(wdelay))
 			loop_sleep(wdelay);
@@ -203,11 +208,15 @@ fail:
 
 	count[0] = URCU_TLS(nr_enqueues);
 	count[1] = URCU_TLS(nr_successful_enqueues);
+	count[2] = URCU_TLS(nr_empty_dest_enqueues);
 	printf_verbose("enqueuer thread_end, thread id : %lx, tid %lu, "
-		       "enqueues %llu successful_enqueues %llu\n",
+		       "enqueues %llu successful_enqueues %llu, "
+		       "empty_dest_enqueues %llu\n",
 		       pthread_self(),
 			(unsigned long) gettid(),
-		       URCU_TLS(nr_enqueues), URCU_TLS(nr_successful_enqueues));
+		       URCU_TLS(nr_enqueues),
+		       URCU_TLS(nr_successful_enqueues),
+		       URCU_TLS(nr_empty_dest_enqueues));
 	return ((void*)1);
 
 }
@@ -233,16 +242,33 @@ static void do_test_splice(enum test_sync sync)
 	struct cds_wfcq_head tmp_head;
 	struct cds_wfcq_tail tmp_tail;
 	struct cds_wfcq_node *node, *n;
+	enum cds_wfcq_ret ret;
 
 	cds_wfcq_init(&tmp_head, &tmp_tail);
 
 	if (sync == TEST_SYNC_MUTEX)
-		cds_wfcq_splice_blocking(&tmp_head, &tmp_tail,
+		ret = cds_wfcq_splice_blocking(&tmp_head, &tmp_tail,
 			&head, &tail);
 	else
-		__cds_wfcq_splice_blocking(&tmp_head, &tmp_tail,
+		ret = __cds_wfcq_splice_blocking(&tmp_head, &tmp_tail,
 			&head, &tail);
 
+	switch (ret) {
+	case CDS_WFCQ_RET_WOULDBLOCK:
+		assert(0);	/* blocking call */
+		break;
+	case CDS_WFCQ_RET_DEST_EMPTY:
+		URCU_TLS(nr_splice)++;
+		/* ok */
+		break;
+	case CDS_WFCQ_RET_DEST_NON_EMPTY:
+		assert(0);	/* entirely unexpected */
+		break;
+	case CDS_WFCQ_RET_SRC_EMPTY:
+		/* ok, we could even skip iteration on dest if we wanted */
+		break;
+	}
+
 	__cds_wfcq_for_each_blocking_safe(&tmp_head, &tmp_tail, node, n) {
 		free(node);
 		URCU_TLS(nr_successful_dequeues)++;
@@ -286,12 +312,15 @@ static void *thr_dequeuer(void *_count)
 	}
 
 	printf_verbose("dequeuer thread_end, thread id : %lx, tid %lu, "
-		       "dequeues %llu, successful_dequeues %llu\n",
+		       "dequeues %llu, successful_dequeues %llu, "
+		       "nr_splice %llu\n",
 		       pthread_self(),
 			(unsigned long) gettid(),
-		       URCU_TLS(nr_dequeues), URCU_TLS(nr_successful_dequeues));
+		       URCU_TLS(nr_dequeues), URCU_TLS(nr_successful_dequeues),
+		       URCU_TLS(nr_splice));
 	count[0] = URCU_TLS(nr_dequeues);
 	count[1] = URCU_TLS(nr_successful_dequeues);
+	count[2] = URCU_TLS(nr_splice);
 	return ((void*)2);
 }
 
@@ -320,6 +349,7 @@ static void show_usage(int argc, char **argv)
 	printf(" [-M] (use mutex external synchronization)");
 	printf(" [-0] (use no external synchronization)");
 	printf("      Note: default: mutex external synchronization used.");
+	printf(" [-w] Wait for dequeuer to empty queue");
 	printf("\n");
 }
 
@@ -331,9 +361,11 @@ int main(int argc, char **argv)
 	unsigned long long *count_enqueuer, *count_dequeuer;
 	unsigned long long tot_enqueues = 0, tot_dequeues = 0;
 	unsigned long long tot_successful_enqueues = 0,
-			   tot_successful_dequeues = 0;
+			   tot_successful_dequeues = 0,
+			   tot_empty_dest_enqueues = 0,
+			   tot_splice = 0;
 	unsigned long long end_dequeues = 0;
-	int i, a;
+	int i, a, retval = 0;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -401,6 +433,9 @@ int main(int argc, char **argv)
 		case '0':
 			test_sync = TEST_SYNC_NONE;
 			break;
+		case 'w':
+			test_wait_empty = 1;
+			break;
 		}
 	}
 
@@ -419,6 +454,8 @@ int main(int argc, char **argv)
 		printf_verbose("External sync: mutex.\n");
 	else
 		printf_verbose("External sync: none.\n");
+	if (test_wait_empty)
+		printf_verbose("Wait for dequeuers to empty queue.\n");
 	printf_verbose("Writer delay : %lu loops.\n", rduration);
 	printf_verbose("Reader duration : %lu loops.\n", wdelay);
 	printf_verbose("thread %-6s, thread id : %lx, tid %lu\n",
@@ -427,21 +464,21 @@ int main(int argc, char **argv)
 
 	tid_enqueuer = malloc(sizeof(*tid_enqueuer) * nr_enqueuers);
 	tid_dequeuer = malloc(sizeof(*tid_dequeuer) * nr_dequeuers);
-	count_enqueuer = malloc(2 * sizeof(*count_enqueuer) * nr_enqueuers);
-	count_dequeuer = malloc(2 * sizeof(*count_dequeuer) * nr_dequeuers);
+	count_enqueuer = malloc(3 * sizeof(*count_enqueuer) * nr_enqueuers);
+	count_dequeuer = malloc(3 * sizeof(*count_dequeuer) * nr_dequeuers);
 	cds_wfcq_init(&head, &tail);
 
 	next_aff = 0;
 
 	for (i = 0; i < nr_enqueuers; i++) {
 		err = pthread_create(&tid_enqueuer[i], NULL, thr_enqueuer,
-				     &count_enqueuer[2 * i]);
+				     &count_enqueuer[3 * i]);
 		if (err != 0)
 			exit(1);
 	}
 	for (i = 0; i < nr_dequeuers; i++) {
 		err = pthread_create(&tid_dequeuer[i], NULL, thr_dequeuer,
-				     &count_dequeuer[2 * i]);
+				     &count_dequeuer[3 * i]);
 		if (err != 0)
 			exit(1);
 	}
@@ -456,21 +493,31 @@ int main(int argc, char **argv)
 			write (1, ".", 1);
 	}
 
-	test_stop = 1;
+	test_stop_enqueue = 1;
+
+	if (test_wait_empty) {
+		while (!cds_wfcq_empty(&head, &tail)) {
+			sleep(1);
+		}
+	}
+
+	test_stop_dequeue = 1;
 
 	for (i = 0; i < nr_enqueuers; i++) {
 		err = pthread_join(tid_enqueuer[i], &tret);
 		if (err != 0)
 			exit(1);
-		tot_enqueues += count_enqueuer[2 * i];
-		tot_successful_enqueues += count_enqueuer[2 * i + 1];
+		tot_enqueues += count_enqueuer[3 * i];
+		tot_successful_enqueues += count_enqueuer[3 * i + 1];
+		tot_empty_dest_enqueues += count_enqueuer[3 * i + 2];
 	}
 	for (i = 0; i < nr_dequeuers; i++) {
 		err = pthread_join(tid_dequeuer[i], &tret);
 		if (err != 0)
 			exit(1);
-		tot_dequeues += count_dequeuer[2 * i];
-		tot_successful_dequeues += count_dequeuer[2 * i + 1];
+		tot_dequeues += count_dequeuer[3 * i];
+		tot_successful_dequeues += count_dequeuer[3 * i + 1];
+		tot_splice += count_dequeuer[3 * i + 2];
 	}
 	
 	test_end(&end_dequeues);
@@ -478,27 +525,50 @@ int main(int argc, char **argv)
 	printf_verbose("total number of enqueues : %llu, dequeues %llu\n",
 		       tot_enqueues, tot_dequeues);
 	printf_verbose("total number of successful enqueues : %llu, "
-		       "successful dequeues %llu\n",
-		       tot_successful_enqueues, tot_successful_dequeues);
+		       "enqueues to empty dest : %llu, "
+		       "successful dequeues %llu, ",
+		       "splice : %llu\n",
+		       tot_successful_enqueues,
+		       tot_empty_dest_enqueues,
+		       tot_successful_dequeues,
+		       tot_splice);
 	printf("SUMMARY %-25s testdur %4lu nr_enqueuers %3u wdelay %6lu "
 		"nr_dequeuers %3u "
 		"rdur %6lu nr_enqueues %12llu nr_dequeues %12llu "
-		"successful enqueues %12llu successful dequeues %12llu "
+		"successful enqueues %12llu enqueues to empty dest %12llu "
+		"successful dequeues %12llu splice %12llu "
 		"end_dequeues %llu nr_ops %12llu\n",
 		argv[0], duration, nr_enqueuers, wdelay,
 		nr_dequeuers, rduration, tot_enqueues, tot_dequeues,
 		tot_successful_enqueues,
-		tot_successful_dequeues, end_dequeues,
+		tot_empty_dest_enqueues,
+		tot_successful_dequeues, tot_splice, end_dequeues,
 		tot_enqueues + tot_dequeues);
-	if (tot_successful_enqueues != tot_successful_dequeues + end_dequeues)
+
+	if (tot_successful_enqueues != tot_successful_dequeues + end_dequeues) {
 		printf("WARNING! Discrepancy between nr succ. enqueues %llu vs "
 		       "succ. dequeues + end dequeues %llu.\n",
 		       tot_successful_enqueues,
 		       tot_successful_dequeues + end_dequeues);
+		retval = 1;
+	}
 
+	/*
+	 * If only using splice to dequeue, the enqueuer should see
+	 * exactly as many empty queues than the number of non-empty
+	 * src splice.
+	 */
+	if (test_wait_empty && (test_splice && !test_dequeue)
+			&& tot_empty_dest_enqueues != tot_splice) {
+		printf("WARNING! Discrepancy between empty enqueue (%llu) and "
+			"number of non-empty splice (%llu)\n",
+			tot_empty_dest_enqueues,
+			tot_splice);
+		retval = 1;
+	}
 	free(count_enqueuer);
 	free(count_dequeuer);
 	free(tid_enqueuer);
 	free(tid_dequeuer);
-	return 0;
+	return retval;
 }

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
