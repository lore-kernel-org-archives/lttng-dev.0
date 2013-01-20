From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH v2] wfstack: return whether pop is popping
	the last	element
Date: Sun, 20 Jan 2013 18:08:58 -0500
Message-ID: <20130120230858.GB22804__45361.8125328378$1358723386$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tx40a-0003Z4-Gj
	for lttng-dev@lists.lttng.org; Sun, 20 Jan 2013 18:09:00 -0500
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

Newly introduced "with_state" pop API members return stack state
atomically sampled with the pop operation.

Allow testing behavior of pop with respect to number of push-to-empty
and pop-all-from-non-empty.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/tests/test_urcu_wfs.c b/tests/test_urcu_wfs.c
index 259ca24..9892354 100644
--- a/tests/test_urcu_wfs.c
+++ b/tests/test_urcu_wfs.c
@@ -171,6 +171,7 @@ static DEFINE_URCU_TLS(unsigned long long, nr_successful_dequeues);
 static DEFINE_URCU_TLS(unsigned long long, nr_successful_enqueues);
 static DEFINE_URCU_TLS(unsigned long long, nr_empty_dest_enqueues);
 static DEFINE_URCU_TLS(unsigned long long, nr_pop_all);
+static DEFINE_URCU_TLS(unsigned long long, nr_pop_last);
 
 static unsigned int nr_enqueuers;
 static unsigned int nr_dequeuers;
@@ -230,14 +231,17 @@ fail:
 static void do_test_pop(enum test_sync sync)
 {
 	struct cds_wfs_node *node;
+	int state;
 
 	if (sync == TEST_SYNC_MUTEX)
 		cds_wfs_pop_lock(&s);
-	node = __cds_wfs_pop_blocking(&s);
+	node = __cds_wfs_pop_with_state_blocking(&s, &state);
 	if (sync == TEST_SYNC_MUTEX)
 		cds_wfs_pop_unlock(&s);
 
 	if (node) {
+		if (state & CDS_WFS_STATE_LAST)
+			URCU_TLS(nr_pop_last)++;
 		free(node);
 		URCU_TLS(nr_successful_dequeues)++;
 	}
@@ -260,6 +264,7 @@ static void do_test_pop_all(enum test_sync sync)
 		return;
 
 	URCU_TLS(nr_pop_all)++;
+	URCU_TLS(nr_pop_last)++;
 
 	cds_wfs_for_each_blocking_safe(head, node, n) {
 		free(node);
@@ -308,24 +313,30 @@ static void *thr_dequeuer(void *_count)
 
 	printf_verbose("dequeuer thread_end, thread id : %lx, tid %lu, "
 		       "dequeues %llu, successful_dequeues %llu "
-		       "pop_all %llu\n",
+		       "pop_all %llu pop_last %llu\n",
 		       pthread_self(),
 			(unsigned long) gettid(),
 		       URCU_TLS(nr_dequeues), URCU_TLS(nr_successful_dequeues),
-		       URCU_TLS(nr_pop_all));
+		       URCU_TLS(nr_pop_all),
+		       URCU_TLS(nr_pop_last));
 	count[0] = URCU_TLS(nr_dequeues);
 	count[1] = URCU_TLS(nr_successful_dequeues);
 	count[2] = URCU_TLS(nr_pop_all);
+	count[3] = URCU_TLS(nr_pop_last);
 	return ((void*)2);
 }
 
-static void test_end(struct cds_wfs_stack *s, unsigned long long *nr_dequeues)
+static void test_end(struct cds_wfs_stack *s, unsigned long long *nr_dequeues,
+		unsigned long long *nr_pop_last)
 {
 	struct cds_wfs_node *node;
+	int state;
 
 	do {
-		node = cds_wfs_pop_blocking(s);
+		node = cds_wfs_pop_with_state_blocking(s, &state);
 		if (node) {
+			if (state & CDS_WFS_STATE_LAST)
+				(*nr_pop_last)++;
 			free(node);
 			(*nr_dequeues)++;
 		}
@@ -358,7 +369,7 @@ int main(int argc, char **argv)
 	unsigned long long tot_successful_enqueues = 0,
 			   tot_successful_dequeues = 0,
 			   tot_empty_dest_enqueues = 0,
-			   tot_pop_all = 0;
+			   tot_pop_all = 0, tot_pop_last = 0;
 	unsigned long long end_dequeues = 0;
 	int i, a, retval = 0;
 
@@ -471,7 +482,7 @@ int main(int argc, char **argv)
 	tid_enqueuer = malloc(sizeof(*tid_enqueuer) * nr_enqueuers);
 	tid_dequeuer = malloc(sizeof(*tid_dequeuer) * nr_dequeuers);
 	count_enqueuer = malloc(3 * sizeof(*count_enqueuer) * nr_enqueuers);
-	count_dequeuer = malloc(3 * sizeof(*count_dequeuer) * nr_dequeuers);
+	count_dequeuer = malloc(4 * sizeof(*count_dequeuer) * nr_dequeuers);
 	cds_wfs_init(&s);
 
 	next_aff = 0;
@@ -484,7 +495,7 @@ int main(int argc, char **argv)
 	}
 	for (i = 0; i < nr_dequeuers; i++) {
 		err = pthread_create(&tid_dequeuer[i], NULL, thr_dequeuer,
-				     &count_dequeuer[3 * i]);
+				     &count_dequeuer[4 * i]);
 		if (err != 0)
 			exit(1);
 	}
@@ -524,34 +535,36 @@ int main(int argc, char **argv)
 		err = pthread_join(tid_dequeuer[i], &tret);
 		if (err != 0)
 			exit(1);
-		tot_dequeues += count_dequeuer[3 * i];
-		tot_successful_dequeues += count_dequeuer[3 * i + 1];
-		tot_pop_all += count_dequeuer[3 * i + 2];
+		tot_dequeues += count_dequeuer[4 * i];
+		tot_successful_dequeues += count_dequeuer[4 * i + 1];
+		tot_pop_all += count_dequeuer[4 * i + 2];
+		tot_pop_last += count_dequeuer[4 * i + 3];
 	}
 	
-	test_end(&s, &end_dequeues);
+	test_end(&s, &end_dequeues, &tot_pop_last);
 
 	printf_verbose("total number of enqueues : %llu, dequeues %llu\n",
 		       tot_enqueues, tot_dequeues);
 	printf_verbose("total number of successful enqueues : %llu, "
 		       "enqueues to empty dest : %llu, "
 		       "successful dequeues %llu, "
-		       "pop_all : %llu\n",
+		       "pop_all : %llu, pop_last : %llu\n",
 		       tot_successful_enqueues,
 		       tot_empty_dest_enqueues,
 		       tot_successful_dequeues,
-		       tot_pop_all);
+		       tot_pop_all, tot_pop_last);
 	printf("SUMMARY %-25s testdur %4lu nr_enqueuers %3u wdelay %6lu "
 		"nr_dequeuers %3u "
 		"rdur %6lu nr_enqueues %12llu nr_dequeues %12llu "
 		"successful enqueues %12llu enqueues to empty dest %12llu "
 		"successful dequeues %12llu pop_all %12llu "
-		"end_dequeues %llu nr_ops %12llu\n",
+		"pop_last %llu end_dequeues %llu nr_ops %12llu\n",
 		argv[0], duration, nr_enqueuers, wdelay,
 		nr_dequeuers, rduration, tot_enqueues, tot_dequeues,
 		tot_successful_enqueues,
 		tot_empty_dest_enqueues,
-		tot_successful_dequeues, tot_pop_all, end_dequeues,
+		tot_successful_dequeues, tot_pop_all, tot_pop_last,
+		end_dequeues,
 		tot_enqueues + tot_dequeues);
 	if (tot_successful_enqueues != tot_successful_dequeues + end_dequeues) {
 		printf("WARNING! Discrepancy between nr succ. enqueues %llu vs "
@@ -561,16 +574,14 @@ int main(int argc, char **argv)
 		retval = 1;
 	}
 	/*
-	 * If only using pop_all to dequeue, the enqueuer should see
-	 * exactly as many empty queues than the number of non-empty
-	 * stacks dequeued.
+	 * The enqueuer should see exactly as many empty queues than the
+	 * number of non-empty stacks dequeued.
 	 */
-	if (test_wait_empty && test_pop_all && !test_pop
-			&& tot_empty_dest_enqueues != tot_pop_all) {
+	if (tot_empty_dest_enqueues != tot_pop_last) {
 		printf("WARNING! Discrepancy between empty enqueue (%llu) and "
-			"number of non-empty pop_all (%llu)\n",
+			"number of pop last (%llu)\n",
 			tot_empty_dest_enqueues,
-			tot_pop_all);
+			tot_pop_last);
 		retval = 1;
 	}
 	free(count_enqueuer);
diff --git a/urcu/static/wfstack.h b/urcu/static/wfstack.h
index 9bc9519..db0d5b8 100644
--- a/urcu/static/wfstack.h
+++ b/urcu/static/wfstack.h
@@ -161,29 +161,37 @@ ___cds_wfs_node_sync_next(struct cds_wfs_node *node, int blocking)
 
 static inline
 struct cds_wfs_node *
-___cds_wfs_pop(struct cds_wfs_stack *s, int blocking)
+___cds_wfs_pop(struct cds_wfs_stack *s, int *state, int blocking)
 {
 	struct cds_wfs_head *head, *new_head;
 	struct cds_wfs_node *next;
 
+	if (state)
+		*state = 0;
 	for (;;) {
 		head = CMM_LOAD_SHARED(s->head);
-		if (___cds_wfs_end(head))
+		if (___cds_wfs_end(head)) {
 			return NULL;
+		}
 		next = ___cds_wfs_node_sync_next(&head->node, blocking);
-		if (!blocking && next == CDS_WFS_WOULDBLOCK)
+		if (!blocking && next == CDS_WFS_WOULDBLOCK) {
 			return CDS_WFS_WOULDBLOCK;
+		}
 		new_head = caa_container_of(next, struct cds_wfs_head, node);
-		if (uatomic_cmpxchg(&s->head, head, new_head) == head)
+		if (uatomic_cmpxchg(&s->head, head, new_head) == head) {
+			if (state && ___cds_wfs_end(new_head))
+				*state |= CDS_WFS_STATE_LAST;
 			return &head->node;
-		if (!blocking)
+		}
+		if (!blocking) {
 			return CDS_WFS_WOULDBLOCK;
+		}
 		/* busy-loop if head changed under us */
 	}
 }
 
 /*
- * __cds_wfs_pop_blocking: pop a node from the stack.
+ * __cds_wfs_pop_with_state_blocking: pop a node from the stack, with state.
  *
  * Returns NULL if stack is empty.
  *
@@ -197,12 +205,36 @@ ___cds_wfs_pop(struct cds_wfs_stack *s, int blocking)
  *     __cds_wfs_pop_blocking and __cds_wfs_pop_all callers.
  * 3) Ensuring that only ONE thread can call __cds_wfs_pop_blocking()
  *    and __cds_wfs_pop_all(). (multi-provider/single-consumer scheme).
+ *
+ * "state" saves state flags atomically sampled with pop operation.
  */
 static inline
 struct cds_wfs_node *
+___cds_wfs_pop_with_state_blocking(struct cds_wfs_stack *s, int *state)
+{
+	return ___cds_wfs_pop(s, state, 1);
+}
+
+static inline
+struct cds_wfs_node *
 ___cds_wfs_pop_blocking(struct cds_wfs_stack *s)
 {
-	return ___cds_wfs_pop(s, 1);
+	return ___cds_wfs_pop_with_state_blocking(s, NULL);
+}
+
+/*
+ * __cds_wfs_pop_with_state_nonblocking: pop a node from the stack.
+ *
+ * Same as __cds_wfs_pop_with_state_blocking, but returns
+ * CDS_WFS_WOULDBLOCK if it needs to block.
+ *
+ * "state" saves state flags atomically sampled with pop operation.
+ */
+static inline
+struct cds_wfs_node *
+___cds_wfs_pop_with_state_nonblocking(struct cds_wfs_stack *s, int *state)
+{
+	return ___cds_wfs_pop(s, state, 0);
 }
 
 /*
@@ -215,7 +247,7 @@ static inline
 struct cds_wfs_node *
 ___cds_wfs_pop_nonblocking(struct cds_wfs_stack *s)
 {
-	return ___cds_wfs_pop(s, 0);
+	return ___cds_wfs_pop_with_state_nonblocking(s, NULL);
 }
 
 /*
@@ -280,21 +312,31 @@ static inline void _cds_wfs_pop_unlock(struct cds_wfs_stack *s)
 }
 
 /*
- * Call __cds_wfs_pop_blocking with an internal pop mutex held.
+ * Call __cds_wfs_pop_with_state_blocking with an internal pop mutex held.
  */
 static inline
 struct cds_wfs_node *
-_cds_wfs_pop_blocking(struct cds_wfs_stack *s)
+_cds_wfs_pop_with_state_blocking(struct cds_wfs_stack *s, int *state)
 {
 	struct cds_wfs_node *retnode;
 
 	_cds_wfs_pop_lock(s);
-	retnode = ___cds_wfs_pop_blocking(s);
+	retnode = ___cds_wfs_pop_with_state_blocking(s, state);
 	_cds_wfs_pop_unlock(s);
 	return retnode;
 }
 
 /*
+ * Call _cds_wfs_pop_with_state_blocking without saving any state.
+ */
+static inline
+struct cds_wfs_node *
+_cds_wfs_pop_blocking(struct cds_wfs_stack *s)
+{
+	return _cds_wfs_pop_with_state_blocking(s, NULL);
+}
+
+/*
  * Call __cds_wfs_pop_all with an internal pop mutex held.
  */
 static inline
diff --git a/urcu/wfstack.h b/urcu/wfstack.h
index 34ddb3f..fc0b44b 100644
--- a/urcu/wfstack.h
+++ b/urcu/wfstack.h
@@ -60,6 +60,10 @@ extern "C" {
 
 #define CDS_WFS_WOULDBLOCK	((void *) -1UL)
 
+enum cds_wfs_state {
+	CDS_WFS_STATE_LAST =		(1U << 0),
+};
+
 /*
  * struct cds_wfs_node is returned by __cds_wfs_pop, and also used as
  * iterator on stack. It is not safe to dereference the node next
@@ -95,6 +99,7 @@ struct cds_wfs_stack {
 
 /* Locking performed internally */
 #define cds_wfs_pop_blocking		_cds_wfs_pop_blocking
+#define cds_wfs_pop_with_state_blocking	_cds_wfs_pop_with_state_blocking
 #define cds_wfs_pop_all_blocking	_cds_wfs_pop_all_blocking
 
 /*
@@ -111,7 +116,11 @@ struct cds_wfs_stack {
 
 /* Synchronization ensured by the caller. See synchronization table. */
 #define __cds_wfs_pop_blocking		___cds_wfs_pop_blocking
+#define __cds_wfs_pop_with_state_blocking	\
+					___cds_wfs_pop_with_state_blocking
 #define __cds_wfs_pop_nonblocking	___cds_wfs_pop_nonblocking
+#define __cds_wfs_pop_with_state_nonblocking	\
+					___cds_wfs_pop_with_state_nonblocking
 #define __cds_wfs_pop_all		___cds_wfs_pop_all
 
 #else /* !_LGPL_SOURCE */
@@ -152,6 +161,15 @@ extern int cds_wfs_push(struct cds_wfs_stack *s, struct cds_wfs_node *node);
 extern struct cds_wfs_node *cds_wfs_pop_blocking(struct cds_wfs_stack *s);
 
 /*
+ * cds_wfs_pop_with_state_blocking: pop a node from the stack, with state.
+ *
+ * Same as cds_wfs_pop_blocking, but stores whether the stack was
+ * empty into state (CDS_WFS_STATE_LAST).
+ */
+extern struct cds_wfs_node *
+	cds_wfs_pop_with_state_blocking(struct cds_wfs_stack *s, int *state);
+
+/*
  * cds_wfs_pop_all_blocking: pop all nodes from a stack.
  *
  * Calls __cds_wfs_pop_all with an internal pop mutex held.
@@ -224,6 +242,15 @@ extern void cds_wfs_pop_unlock(struct cds_wfs_stack *s);
 extern struct cds_wfs_node *__cds_wfs_pop_blocking(struct cds_wfs_stack *s);
 
 /*
+ * __cds_wfs_pop_with_state_blocking: pop a node from the stack, with state.
+ *
+ * Same as __cds_wfs_pop_blocking, but stores whether the stack was
+ * empty into state (CDS_WFS_STATE_LAST).
+ */
+extern struct cds_wfs_node *
+	__cds_wfs_pop_with_state_blocking(struct cds_wfs_stack *s, int *state);
+
+/*
  * __cds_wfs_pop_nonblocking: pop a node from the stack.
  *
  * Same as __cds_wfs_pop_blocking, but returns CDS_WFS_WOULDBLOCK if
@@ -232,6 +259,16 @@ extern struct cds_wfs_node *__cds_wfs_pop_blocking(struct cds_wfs_stack *s);
 extern struct cds_wfs_node *__cds_wfs_pop_nonblocking(struct cds_wfs_stack *s);
 
 /*
+ * __cds_wfs_pop_with_state_nonblocking: pop a node from the stack, with state.
+ *
+ * Same as __cds_wfs_pop_nonblocking, but stores whether the stack was
+ * empty into state (CDS_WFS_STATE_LAST).
+ */
+extern struct cds_wfs_node *
+	__cds_wfs_pop_with_state_nonblocking(struct cds_wfs_stack *s,
+		int *state);
+
+/*
  * __cds_wfs_pop_all: pop all nodes from a stack.
  *
  * __cds_wfs_pop_all does not require any synchronization with other
diff --git a/wfstack.c b/wfstack.c
index 4ccb6b9..c8bd7e6 100644
--- a/wfstack.c
+++ b/wfstack.c
@@ -53,6 +53,12 @@ struct cds_wfs_node *cds_wfs_pop_blocking(struct cds_wfs_stack *s)
 	return _cds_wfs_pop_blocking(s);
 }
 
+struct cds_wfs_node *
+	cds_wfs_pop_with_state_blocking(struct cds_wfs_stack *s, int *state)
+{
+	return _cds_wfs_pop_with_state_blocking(s, state);
+}
+
 struct cds_wfs_head *cds_wfs_pop_all_blocking(struct cds_wfs_stack *s)
 {
 	return _cds_wfs_pop_all_blocking(s);
@@ -88,11 +94,24 @@ struct cds_wfs_node *__cds_wfs_pop_blocking(struct cds_wfs_stack *s)
 	return ___cds_wfs_pop_blocking(s);
 }
 
+struct cds_wfs_node *
+	__cds_wfs_pop_with_state_blocking(struct cds_wfs_stack *s, int *state)
+{
+	return ___cds_wfs_pop_with_state_blocking(s, state);
+}
+
 struct cds_wfs_node *__cds_wfs_pop_nonblocking(struct cds_wfs_stack *s)
 {
 	return ___cds_wfs_pop_nonblocking(s);
 }
 
+struct cds_wfs_node *
+	__cds_wfs_pop_with_state_nonblocking(struct cds_wfs_stack *s,
+		int *state)
+{
+	return ___cds_wfs_pop_with_state_nonblocking(s, state);
+}
+
 struct cds_wfs_head *__cds_wfs_pop_all(struct cds_wfs_stack *s)
 {
 	return ___cds_wfs_pop_all(s);

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
