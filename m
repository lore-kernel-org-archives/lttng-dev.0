From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH v2] wfcqueue: return whether dequeue is
	dequeuing last	element
Date: Sun, 20 Jan 2013 18:10:14 -0500
Message-ID: <20130120231014.GC22804__46457.6028557078$1358723460$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tx41o-0003ap-30
	for lttng-dev@lists.lttng.org; Sun, 20 Jan 2013 18:10:16 -0500
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

Newly introduced "with_state" dequeue API members return queue state
atomically sampled with the dequeue operation.

Allow testing behavior of dequeue with respect to number of
enqueue-to-empty and splice-from-non-empty.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/tests/test_urcu_wfcq.c b/tests/test_urcu_wfcq.c
index 91285a5..12acc93 100644
--- a/tests/test_urcu_wfcq.c
+++ b/tests/test_urcu_wfcq.c
@@ -168,6 +168,7 @@ static DEFINE_URCU_TLS(unsigned long long, nr_successful_dequeues);
 static DEFINE_URCU_TLS(unsigned long long, nr_successful_enqueues);
 static DEFINE_URCU_TLS(unsigned long long, nr_empty_dest_enqueues);
 static DEFINE_URCU_TLS(unsigned long long, nr_splice);
+static DEFINE_URCU_TLS(unsigned long long, nr_dequeue_last);
 
 static unsigned int nr_enqueuers;
 static unsigned int nr_dequeuers;
@@ -228,11 +229,17 @@ fail:
 static void do_test_dequeue(enum test_sync sync)
 {
 	struct cds_wfcq_node *node;
+	int state;
 
 	if (sync == TEST_SYNC_MUTEX)
-		node = cds_wfcq_dequeue_blocking(&head, &tail);
+		node = cds_wfcq_dequeue_with_state_blocking(&head, &tail,
+				&state);
 	else
-		node = __cds_wfcq_dequeue_blocking(&head, &tail);
+		node = __cds_wfcq_dequeue_with_state_blocking(&head, &tail,
+				&state);
+
+	if (state & CDS_WFCQ_STATE_LAST)
+		URCU_TLS(nr_dequeue_last)++;
 
 	if (node) {
 		free(node);
@@ -263,6 +270,7 @@ static void do_test_splice(enum test_sync sync)
 		break;
 	case CDS_WFCQ_RET_DEST_EMPTY:
 		URCU_TLS(nr_splice)++;
+		URCU_TLS(nr_dequeue_last)++;
 		/* ok */
 		break;
 	case CDS_WFCQ_RET_DEST_NON_EMPTY:
@@ -325,16 +333,22 @@ static void *thr_dequeuer(void *_count)
 	count[0] = URCU_TLS(nr_dequeues);
 	count[1] = URCU_TLS(nr_successful_dequeues);
 	count[2] = URCU_TLS(nr_splice);
+	count[3] = URCU_TLS(nr_dequeue_last);
 	return ((void*)2);
 }
 
-static void test_end(unsigned long long *nr_dequeues)
+static void test_end(unsigned long long *nr_dequeues,
+		unsigned long long *nr_dequeue_last)
 {
 	struct cds_wfcq_node *node;
+	int state;
 
 	do {
-		node = cds_wfcq_dequeue_blocking(&head, &tail);
+		node = cds_wfcq_dequeue_with_state_blocking(&head, &tail,
+				&state);
 		if (node) {
+			if (state & CDS_WFCQ_STATE_LAST)
+				(*nr_dequeue_last)++;
 			free(node);
 			(*nr_dequeues)++;
 		}
@@ -367,7 +381,7 @@ int main(int argc, char **argv)
 	unsigned long long tot_successful_enqueues = 0,
 			   tot_successful_dequeues = 0,
 			   tot_empty_dest_enqueues = 0,
-			   tot_splice = 0;
+			   tot_splice = 0, tot_dequeue_last = 0;
 	unsigned long long end_dequeues = 0;
 	int i, a, retval = 0;
 
@@ -480,7 +494,7 @@ int main(int argc, char **argv)
 	tid_enqueuer = malloc(sizeof(*tid_enqueuer) * nr_enqueuers);
 	tid_dequeuer = malloc(sizeof(*tid_dequeuer) * nr_dequeuers);
 	count_enqueuer = malloc(3 * sizeof(*count_enqueuer) * nr_enqueuers);
-	count_dequeuer = malloc(3 * sizeof(*count_dequeuer) * nr_dequeuers);
+	count_dequeuer = malloc(4 * sizeof(*count_dequeuer) * nr_dequeuers);
 	cds_wfcq_init(&head, &tail);
 
 	next_aff = 0;
@@ -493,7 +507,7 @@ int main(int argc, char **argv)
 	}
 	for (i = 0; i < nr_dequeuers; i++) {
 		err = pthread_create(&tid_dequeuer[i], NULL, thr_dequeuer,
-				     &count_dequeuer[3 * i]);
+				     &count_dequeuer[4 * i]);
 		if (err != 0)
 			exit(1);
 	}
@@ -533,34 +547,37 @@ int main(int argc, char **argv)
 		err = pthread_join(tid_dequeuer[i], &tret);
 		if (err != 0)
 			exit(1);
-		tot_dequeues += count_dequeuer[3 * i];
-		tot_successful_dequeues += count_dequeuer[3 * i + 1];
-		tot_splice += count_dequeuer[3 * i + 2];
+		tot_dequeues += count_dequeuer[4 * i];
+		tot_successful_dequeues += count_dequeuer[4 * i + 1];
+		tot_splice += count_dequeuer[4 * i + 2];
+		tot_dequeue_last += count_dequeuer[4 * i + 3];
 	}
 	
-	test_end(&end_dequeues);
+	test_end(&end_dequeues, &tot_dequeue_last);
 
 	printf_verbose("total number of enqueues : %llu, dequeues %llu\n",
 		       tot_enqueues, tot_dequeues);
 	printf_verbose("total number of successful enqueues : %llu, "
 		       "enqueues to empty dest : %llu, "
 		       "successful dequeues %llu, "
-		       "splice : %llu\n",
+		       "splice : %llu, dequeue_last : %llu\n",
 		       tot_successful_enqueues,
 		       tot_empty_dest_enqueues,
 		       tot_successful_dequeues,
-		       tot_splice);
+		       tot_splice, tot_dequeue_last);
 	printf("SUMMARY %-25s testdur %4lu nr_enqueuers %3u wdelay %6lu "
 		"nr_dequeuers %3u "
 		"rdur %6lu nr_enqueues %12llu nr_dequeues %12llu "
 		"successful enqueues %12llu enqueues to empty dest %12llu "
 		"successful dequeues %12llu splice %12llu "
+		"dequeue_last %llu "
 		"end_dequeues %llu nr_ops %12llu\n",
 		argv[0], duration, nr_enqueuers, wdelay,
 		nr_dequeuers, rduration, tot_enqueues, tot_dequeues,
 		tot_successful_enqueues,
 		tot_empty_dest_enqueues,
-		tot_successful_dequeues, tot_splice, end_dequeues,
+		tot_successful_dequeues, tot_splice, tot_dequeue_last,
+		end_dequeues,
 		tot_enqueues + tot_dequeues);
 
 	if (tot_successful_enqueues != tot_successful_dequeues + end_dequeues) {
@@ -576,12 +593,11 @@ int main(int argc, char **argv)
 	 * exactly as many empty queues than the number of non-empty
 	 * src splice.
 	 */
-	if (test_wait_empty && test_splice && !test_dequeue
-			&& tot_empty_dest_enqueues != tot_splice) {
+	if (tot_empty_dest_enqueues != tot_dequeue_last) {
 		printf("WARNING! Discrepancy between empty enqueue (%llu) and "
-			"number of non-empty splice (%llu)\n",
+			"number of dequeue of last element (%llu)\n",
 			tot_empty_dest_enqueues,
-			tot_splice);
+			tot_dequeue_last);
 		retval = 1;
 	}
 	free(count_enqueuer);
diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
index 4b3535a..c3f0328 100644
--- a/urcu/static/wfcqueue.h
+++ b/urcu/static/wfcqueue.h
@@ -350,18 +350,24 @@ ___cds_wfcq_next_nonblocking(struct cds_wfcq_head *head,
 }
 
 static inline struct cds_wfcq_node *
-___cds_wfcq_dequeue(struct cds_wfcq_head *head,
+___cds_wfcq_dequeue_with_state(struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail,
+		int *state,
 		int blocking)
 {
 	struct cds_wfcq_node *node, *next;
 
-	if (_cds_wfcq_empty(head, tail))
+	if (state)
+		*state = 0;
+
+	if (_cds_wfcq_empty(head, tail)) {
 		return NULL;
+	}
 
 	node = ___cds_wfcq_node_sync_next(&head->node, blocking);
-	if (!blocking && node == CDS_WFCQ_WOULDBLOCK)
+	if (!blocking && node == CDS_WFCQ_WOULDBLOCK) {
 		return CDS_WFCQ_WOULDBLOCK;
+	}
 
 	if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
 		/*
@@ -379,8 +385,11 @@ ___cds_wfcq_dequeue(struct cds_wfcq_head *head,
 		 * content.
 		 */
 		_cds_wfcq_node_init(&head->node);
-		if (uatomic_cmpxchg(&tail->p, node, &head->node) == node)
+		if (uatomic_cmpxchg(&tail->p, node, &head->node) == node) {
+			if (state)
+				*state |= CDS_WFCQ_STATE_LAST;
 			return node;
+		}
 		next = ___cds_wfcq_node_sync_next(node, blocking);
 		/*
 		 * In nonblocking mode, if we would need to block to
@@ -404,7 +413,7 @@ ___cds_wfcq_dequeue(struct cds_wfcq_head *head,
 }
 
 /*
- * __cds_wfcq_dequeue_blocking: dequeue a node from the queue.
+ * __cds_wfcq_dequeue_with_state_blocking: dequeue node from queue, with state.
  *
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
@@ -413,23 +422,49 @@ ___cds_wfcq_dequeue(struct cds_wfcq_head *head,
  * caller.
  */
 static inline struct cds_wfcq_node *
+___cds_wfcq_dequeue_with_state_blocking(struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail, int *state)
+{
+	return ___cds_wfcq_dequeue_with_state(head, tail, state, 1);
+}
+
+/*
+ * ___cds_wfcq_dequeue_blocking: dequeue node from queue.
+ *
+ * Same as __cds_wfcq_dequeue_with_state_blocking, but without saving
+ * state.
+ */
+static inline struct cds_wfcq_node *
 ___cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail)
 {
-	return ___cds_wfcq_dequeue(head, tail, 1);
+	return ___cds_wfcq_dequeue_with_state_blocking(head, tail, NULL);
 }
 
 /*
- * __cds_wfcq_dequeue_nonblocking: dequeue a node from a wait-free queue.
+ * __cds_wfcq_dequeue_with_state_nonblocking: dequeue node, with state.
  *
  * Same as __cds_wfcq_dequeue_blocking, but returns CDS_WFCQ_WOULDBLOCK
  * if it needs to block.
  */
 static inline struct cds_wfcq_node *
+___cds_wfcq_dequeue_with_state_nonblocking(struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail, int *state)
+{
+	return ___cds_wfcq_dequeue_with_state(head, tail, state, 0);
+}
+
+/*
+ * ___cds_wfcq_dequeue_nonblocking: dequeue node from queue.
+ *
+ * Same as __cds_wfcq_dequeue_with_state_nonblocking, but without saving
+ * state.
+ */
+static inline struct cds_wfcq_node *
 ___cds_wfcq_dequeue_nonblocking(struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail)
 {
-	return ___cds_wfcq_dequeue(head, tail, 0);
+	return ___cds_wfcq_dequeue_with_state_nonblocking(head, tail, NULL);
 }
 
 /*
@@ -532,7 +567,7 @@ ___cds_wfcq_splice_nonblocking(
 }
 
 /*
- * cds_wfcq_dequeue_blocking: dequeue a node from a wait-free queue.
+ * cds_wfcq_dequeue_with_state_blocking: dequeue a node from a wait-free queue.
  *
  * Content written into the node before enqueue is guaranteed to be
  * consistent, but no other memory ordering is ensured.
@@ -541,18 +576,30 @@ ___cds_wfcq_splice_nonblocking(
  * It is valid to reuse and free a dequeued node immediately.
  */
 static inline struct cds_wfcq_node *
-_cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
-		struct cds_wfcq_tail *tail)
+_cds_wfcq_dequeue_with_state_blocking(struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail, int *state)
 {
 	struct cds_wfcq_node *retval;
 
 	_cds_wfcq_dequeue_lock(head, tail);
-	retval = ___cds_wfcq_dequeue_blocking(head, tail);
+	retval = ___cds_wfcq_dequeue_with_state_blocking(head, tail, state);
 	_cds_wfcq_dequeue_unlock(head, tail);
 	return retval;
 }
 
 /*
+ * cds_wfcq_dequeue_blocking: dequeue node from queue.
+ *
+ * Same as cds_wfcq_dequeue_blocking, but without saving state.
+ */
+static inline struct cds_wfcq_node *
+_cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail)
+{
+	return _cds_wfcq_dequeue_with_state_blocking(head, tail, NULL);
+}
+
+/*
  * cds_wfcq_splice_blocking: enqueue all src_q nodes at the end of dest_q.
  *
  * Dequeue all nodes from src_q.
diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
index b6be9f3..5dcf07e 100644
--- a/urcu/wfcqueue.h
+++ b/urcu/wfcqueue.h
@@ -52,6 +52,10 @@ enum cds_wfcq_ret {
 	CDS_WFCQ_RET_SRC_EMPTY = 	2,
 };
 
+enum cds_wfcq_state {
+	CDS_WFCQ_STATE_LAST =		(1U << 0),
+};
+
 struct cds_wfcq_node {
 	struct cds_wfcq_node *next;
 };
@@ -85,12 +89,16 @@ struct cds_wfcq_tail {
 
 /* Locking performed within cds_wfcq calls. */
 #define cds_wfcq_dequeue_blocking	_cds_wfcq_dequeue_blocking
+#define cds_wfcq_dequeue_with_state_blocking	\
+					_cds_wfcq_dequeue_with_state_blocking
 #define cds_wfcq_splice_blocking	_cds_wfcq_splice_blocking
 #define cds_wfcq_first_blocking		_cds_wfcq_first_blocking
 #define cds_wfcq_next_blocking		_cds_wfcq_next_blocking
 
 /* Locking ensured by caller by holding cds_wfcq_dequeue_lock() */
 #define __cds_wfcq_dequeue_blocking	___cds_wfcq_dequeue_blocking
+#define __cds_wfcq_dequeue_with_state_blocking	\
+					___cds_wfcq_dequeue_with_state_blocking
 #define __cds_wfcq_splice_blocking	___cds_wfcq_splice_blocking
 #define __cds_wfcq_first_blocking	___cds_wfcq_first_blocking
 #define __cds_wfcq_next_blocking	___cds_wfcq_next_blocking
@@ -101,6 +109,8 @@ struct cds_wfcq_tail {
  * need to block. splice returns nonzero if it needs to block.
  */
 #define __cds_wfcq_dequeue_nonblocking	___cds_wfcq_dequeue_nonblocking
+#define __cds_wfcq_dequeue_with_state_nonblocking	\
+				___cds_wfcq_dequeue_with_state_nonblocking
 #define __cds_wfcq_splice_nonblocking	___cds_wfcq_splice_nonblocking
 #define __cds_wfcq_first_nonblocking	___cds_wfcq_first_nonblocking
 #define __cds_wfcq_next_nonblocking	___cds_wfcq_next_nonblocking
@@ -200,6 +210,17 @@ extern struct cds_wfcq_node *cds_wfcq_dequeue_blocking(
 		struct cds_wfcq_tail *tail);
 
 /*
+ * cds_wfcq_dequeue_with_state_blocking: dequeue with state.
+ *
+ * Same as cds_wfcq_dequeue_blocking, but saves whether dequeueing the
+ * last node of the queue into state (CDS_WFCQ_STATE_LAST).
+ */
+extern struct cds_wfcq_node *cds_wfcq_dequeue_with_state_blocking(
+		struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail,
+		int *state);
+
+/*
  * cds_wfcq_splice_blocking: enqueue all src_q nodes at the end of dest_q.
  *
  * Dequeue all nodes from src_q.
@@ -232,6 +253,17 @@ extern struct cds_wfcq_node *__cds_wfcq_dequeue_blocking(
 		struct cds_wfcq_tail *tail);
 
 /*
+ * __cds_wfcq_dequeue_with_state_blocking: dequeue with state.
+ *
+ * Same as __cds_wfcq_dequeue_blocking, but saves whether dequeueing the
+ * last node of the queue into state (CDS_WFCQ_STATE_LAST).
+ */
+extern struct cds_wfcq_node *__cds_wfcq_dequeue_with_state_blocking(
+		struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail,
+		int *state);
+
+/*
  * __cds_wfcq_dequeue_nonblocking: dequeue a node from a wait-free queue.
  *
  * Same as __cds_wfcq_dequeue_blocking, but returns CDS_WFCQ_WOULDBLOCK
@@ -242,6 +274,17 @@ extern struct cds_wfcq_node *__cds_wfcq_dequeue_nonblocking(
 		struct cds_wfcq_tail *tail);
 
 /*
+ * __cds_wfcq_dequeue_with_state_blocking: dequeue with state.
+ *
+ * Same as __cds_wfcq_dequeue_nonblocking, but saves whether dequeueing
+ * the last node of the queue into state (CDS_WFCQ_STATE_LAST).
+ */
+extern struct cds_wfcq_node *__cds_wfcq_dequeue_with_state_nonblocking(
+		struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail,
+		int *state);
+
+/*
  * __cds_wfcq_splice_blocking: enqueue all src_q nodes at the end of dest_q.
  *
  * Dequeue all nodes from src_q.
diff --git a/wfcqueue.c b/wfcqueue.c
index ab0eb93..4950c10 100644
--- a/wfcqueue.c
+++ b/wfcqueue.c
@@ -73,6 +73,14 @@ struct cds_wfcq_node *cds_wfcq_dequeue_blocking(
 	return _cds_wfcq_dequeue_blocking(head, tail);
 }
 
+struct cds_wfcq_node *cds_wfcq_dequeue_with_state_blocking(
+		struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail,
+		int *state)
+{
+	return _cds_wfcq_dequeue_with_state_blocking(head, tail, state);
+}
+
 enum cds_wfcq_ret cds_wfcq_splice_blocking(
 		struct cds_wfcq_head *dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
@@ -90,6 +98,14 @@ struct cds_wfcq_node *__cds_wfcq_dequeue_blocking(
 	return ___cds_wfcq_dequeue_blocking(head, tail);
 }
 
+struct cds_wfcq_node *__cds_wfcq_dequeue_with_state_blocking(
+		struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail,
+		int *state)
+{
+	return ___cds_wfcq_dequeue_with_state_blocking(head, tail, state);
+}
+
 struct cds_wfcq_node *__cds_wfcq_dequeue_nonblocking(
 		struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail)
@@ -97,6 +113,14 @@ struct cds_wfcq_node *__cds_wfcq_dequeue_nonblocking(
 	return ___cds_wfcq_dequeue_nonblocking(head, tail);
 }
 
+struct cds_wfcq_node *__cds_wfcq_dequeue_with_state_nonblocking(
+		struct cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail,
+		int *state)
+{
+	return ___cds_wfcq_dequeue_with_state_nonblocking(head, tail, state);
+}
+
 enum cds_wfcq_ret __cds_wfcq_splice_blocking(
 		struct cds_wfcq_head *dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
