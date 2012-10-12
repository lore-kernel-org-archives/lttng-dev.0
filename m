From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH urcu] lfstack: implement pop_all and
	iterators
Date: Fri, 12 Oct 2012 10:17:33 -0400
Message-ID: <20121012141732.GA16820__43407.9970619225$1350051490$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TMg3T-0003KV-DL
	for lttng-dev@lists.lttng.org; Fri, 12 Oct 2012 10:17:35 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>, paulmck@linux.vnet.ibm.com
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

Please note that this code is currently developed in a volatile branch:

git://git.dorsal.polymtl.ca/~compudj/userspace-rcu
branch: urcu/lfstack

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/lfstack.c b/lfstack.c
index 74ffd4f..7e2011d 100644
--- a/lfstack.c
+++ b/lfstack.c
@@ -45,7 +45,12 @@ int cds_lfs_push(struct cds_lfs_stack *s, struct cds_lfs_node *node)
 	return _cds_lfs_push(s, node);
 }
 
-struct cds_lfs_node *cds_lfs_pop(struct cds_lfs_stack *s)
+struct cds_lfs_node *__cds_lfs_pop(struct cds_lfs_stack *s)
 {
-	return _cds_lfs_pop(s);
+	return ___cds_lfs_pop(s);
+}
+
+struct cds_lfs_head *__cds_lfs_pop_all(struct cds_lfs_stack *s)
+{
+	return ___cds_lfs_pop_all(s);
 }
diff --git a/tests/test_urcu_lfs.c b/tests/test_urcu_lfs.c
index a29dc94..8350e65 100644
--- a/tests/test_urcu_lfs.c
+++ b/tests/test_urcu_lfs.c
@@ -244,7 +244,7 @@ void *thr_dequeuer(void *_count)
 		struct test *node;
 
 		rcu_read_lock();
-		snode = cds_lfs_pop(&s);
+		snode = __cds_lfs_pop(&s);
 		node = caa_container_of(snode, struct test, list);
 		rcu_read_unlock();
 		if (node) {
@@ -275,7 +275,7 @@ void test_end(struct cds_lfs_stack *s, unsigned long long *nr_dequeues)
 	struct cds_lfs_node *snode;
 
 	do {
-		snode = cds_lfs_pop(s);
+		snode = __cds_lfs_pop(s);
 		if (snode) {
 			struct test *node;
 
diff --git a/urcu/lfstack.h b/urcu/lfstack.h
index d068739..463b0d9 100644
--- a/urcu/lfstack.h
+++ b/urcu/lfstack.h
@@ -27,14 +27,40 @@
 extern "C" {
 #endif
 
+/*
+ * struct cds_lfs_node is returned by cds_lfs_pop, and also used as
+ * iterator on stack. It is not safe to dereference the node next
+ * pointer when returned by cds_lfs_pop.
+ */
 struct cds_lfs_node {
 	struct cds_lfs_node *next;
 };
 
+/*
+ * struct cds_lfs_head is returned by __cds_lfs_pop_all, and can be used
+ * to begin iteration on the stack.
+ */
+struct cds_lfs_head {
+	struct cds_lfs_node node;
+};
+
 struct cds_lfs_stack {
-	struct cds_lfs_node *head;
+	struct cds_lfs_head *head;
 };
 
+/*
+ * Synchronization table:
+ *
+ * External synchronization techniques described in the API below is
+ * required between pairs marked with "X". No external synchronization
+ * required between pairs marked with "-".
+ *
+ *                      cds_lfs_push  __cds_lfs_pop  __cds_lfs_pop_all
+ * cds_lfs_push               -              -                  -
+ * __cds_lfs_pop              -              X                  X
+ * __cds_lfs_pop_all          -              X                  -
+ */
+
 #ifdef _LGPL_SOURCE
 
 #include <urcu/static/lfstack.h>
@@ -42,7 +68,8 @@ struct cds_lfs_stack {
 #define cds_lfs_node_init		_cds_lfs_node_init
 #define cds_lfs_init			_cds_lfs_init
 #define cds_lfs_push			_cds_lfs_push
-#define cds_lfs_pop			_cds_lfs_pop
+#define __cds_lfs_pop			___cds_lfs_pop
+#define __cds_lfs_pop_all		___cds_lfs_pop_all
 
 #else /* !_LGPL_SOURCE */
 
@@ -61,25 +88,74 @@ extern int cds_lfs_push(struct cds_lfs_stack *s,
 			struct cds_lfs_node *node);
 
 /*
- * cds_lfs_pop: pop a node from the stack.
+ * __cds_lfs_pop: pop a node from the stack.
  *
  * Returns NULL if stack is empty.
  *
- * cds_lfs_pop needs to be synchronized using one of the following
+ * __cds_lfs_pop needs to be synchronized using one of the following
  * techniques:
  *
- * 1) Calling cds_lfs_pop under rcu read lock critical section. The
+ * 1) Calling __cds_lfs_pop under rcu read lock critical section. The
  *    caller must wait for a grace period to pass before freeing the
  *    returned node or modifying the cds_lfs_node structure.
- * 2) Using mutual exclusion (e.g. mutexes) to protect cds_lfs_pop
- *    callers.
- * 3) Ensuring that only ONE thread can call cds_lfs_pop().
- *    (multi-provider/single-consumer scheme).
+ * 2) Using mutual exclusion (e.g. mutexes) to protect __cds_lfs_pop
+ *    and __cds_lfs_pop_all callers.
+ * 3) Ensuring that only ONE thread can call __cds_lfs_pop() and
+ *    __cds_lfs_pop_all(). (multi-provider/single-consumer scheme).
+ */
+extern struct cds_lfs_node *__cds_lfs_pop(struct cds_lfs_stack *s);
+
+/*
+ * __cds_lfs_pop_all: pop all nodes from a stack.
+ *
+ * __cds_lfs_pop_all does not require any synchronization with other
+ * push, nor with other __cds_lfs_pop_all, but requires synchronization
+ * matching the technique used to synchronize __cds_lfs_pop:
+ *
+ * 1) If __cds_lfs_pop is called under rcu read lock critical section,
+ *    both __cds_lfs_pop and cds_lfs_pop_all callers must wait for a
+ *    grace period to pass before freeing the returned node or modifying
+ *    the cds_lfs_node structure. However, no RCU read-side critical
+ *    section is needed around __cds_lfs_pop_all.
+ * 2) Using mutual exclusion (e.g. mutexes) to protect __cds_lfs_pop and
+ *    __cds_lfs_pop_all callers.
+ * 3) Ensuring that only ONE thread can call __cds_lfs_pop() and
+ *    __cds_lfs_pop_all(). (multi-provider/single-consumer scheme).
  */
-extern struct cds_lfs_node *cds_lfs_pop(struct cds_lfs_stack *s);
+extern struct cds_lfs_head *__cds_lfs_pop_all(struct cds_lfs_stack *s);
 
 #endif /* !_LGPL_SOURCE */
 
+/*
+ * cds_lfs_for_each: Iterate over all nodes returned by
+ *                   __cds_lfs_pop_all.
+ * @__head: node returned by __cds_lfs_pop_all (struct cds_lfs_node pointer).
+ * @__node: node to use as iterator (struct cds_lfs_node pointer).
+ *
+ * Content written into each node before push is guaranteed to be
+ * consistent, but no other memory ordering is ensured.
+ */
+#define cds_lfs_for_each(__head, __node)	\
+	for (__node = &__head->node;		\
+		__node != NULL;			\
+		__node = __node->next)
+
+/*
+ * cds_lfs_for_each_safe: Iterate over all nodes returned by
+ *                        __cds_lfs_pop_all, safe against node deletion.
+ * @__head: node returned by __cds_lfs_pop_all (struct cds_lfs_node pointer).
+ * @__node: node to use as iterator (struct cds_lfs_node pointer).
+ * @__n: struct cds_lfs_node pointer holding the next pointer (used
+ *       internally).
+ *
+ * Content written into each node before push is guaranteed to be
+ * consistent, but no other memory ordering is ensured.
+ */
+#define cds_lfs_for_each_safe(__head, __node, __n)			   \
+	for (__node = &__head->node, __n = (__node ? __node->next : NULL); \
+		__node != NULL;						   \
+		__node = __n, __n = (__node ? __node->next : NULL))
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/urcu/static/lfstack.h b/urcu/static/lfstack.h
index 7acbf54..479c8c3 100644
--- a/urcu/static/lfstack.h
+++ b/urcu/static/lfstack.h
@@ -33,6 +33,19 @@
 extern "C" {
 #endif
 
+/*
+ * Synchronization table:
+ *
+ * External synchronization techniques described in the API below is
+ * required between pairs marked with "X". No external synchronization
+ * required between pairs marked with "-".
+ *
+ *                      cds_lfs_push  __cds_lfs_pop  __cds_lfs_pop_all
+ * cds_lfs_push               -              -                  -
+ * __cds_lfs_pop              -              X                  X
+ * __cds_lfs_pop_all          -              X                  -
+ */
+
 static inline
 void _cds_lfs_node_init(struct cds_lfs_node *node)
 {
@@ -77,21 +90,23 @@ static inline
 int _cds_lfs_push(struct cds_lfs_stack *s,
 		  struct cds_lfs_node *node)
 {
-	struct cds_lfs_node *head = NULL;
+	struct cds_lfs_head *head = NULL;
+	struct cds_lfs_head *new_head =
+		caa_container_of(node, struct cds_lfs_head, node);
 
 	for (;;) {
-		struct cds_lfs_node *old_head = head;
+		struct cds_lfs_head *old_head = head;
 
 		/*
 		 * node->next is still private at this point, no need to
 		 * perform a _CMM_STORE_SHARED().
 		 */
-		node->next = head;
+		node->next = &head->node;
 		/*
 		 * uatomic_cmpxchg() implicit memory barrier orders earlier
 		 * stores to node before publication.
 		 */
-		head = uatomic_cmpxchg(&s->head, old_head, node);
+		head = uatomic_cmpxchg(&s->head, old_head, new_head);
 		if (old_head == head)
 			break;
 	}
@@ -99,30 +114,31 @@ int _cds_lfs_push(struct cds_lfs_stack *s,
 }
 
 /*
- * cds_lfs_pop: pop a node from the stack.
+ * __cds_lfs_pop: pop a node from the stack.
  *
  * Returns NULL if stack is empty.
  *
- * cds_lfs_pop needs to be synchronized using one of the following
+ * __cds_lfs_pop needs to be synchronized using one of the following
  * techniques:
  *
- * 1) Calling cds_lfs_pop under rcu read lock critical section. The
+ * 1) Calling __cds_lfs_pop under rcu read lock critical section. The
  *    caller must wait for a grace period to pass before freeing the
  *    returned node or modifying the cds_lfs_node structure.
- * 2) Using mutual exclusion (e.g. mutexes) to protect cds_lfs_pop
- *    callers.
- * 3) Ensuring that only ONE thread can call cds_lfs_pop().
- *    (multi-provider/single-consumer scheme).
+ * 2) Using mutual exclusion (e.g. mutexes) to protect __cds_lfs_pop
+ *    and __cds_lfs_pop_all callers.
+ * 3) Ensuring that only ONE thread can call __cds_lfs_pop() and
+ *    __cds_lfs_pop_all(). (multi-provider/single-consumer scheme).
  */
 static inline
-struct cds_lfs_node *_cds_lfs_pop(struct cds_lfs_stack *s)
+struct cds_lfs_node *___cds_lfs_pop(struct cds_lfs_stack *s)
 {
 	for (;;) {
-		struct cds_lfs_node *head;
+		struct cds_lfs_head *head;
 
 		head = _CMM_LOAD_SHARED(s->head);
 		if (head) {
 			struct cds_lfs_node *next;
+			struct cds_lfs_head *next_head;
 
 			/*
 			 * Read head before head->next. Matches the
@@ -130,9 +146,12 @@ struct cds_lfs_node *_cds_lfs_pop(struct cds_lfs_stack *s)
 			 * uatomic_cmpxchg() in cds_lfs_push.
 			 */
 			cmm_smp_read_barrier_depends();
-			next = _CMM_LOAD_SHARED(head->next);
-			if (uatomic_cmpxchg(&s->head, head, next) == head) {
-				return head;
+			next = _CMM_LOAD_SHARED(head->node.next);
+			next_head = caa_container_of(next,
+					struct cds_lfs_head, node);
+			if (uatomic_cmpxchg(&s->head, head, next_head)
+					== head) {
+				return &head->node;
 			} else {
 				/* Concurrent modification. Retry. */
 				continue;
@@ -144,6 +163,39 @@ struct cds_lfs_node *_cds_lfs_pop(struct cds_lfs_stack *s)
 	}
 }
 
+/*
+ * __cds_lfs_pop_all: pop all nodes from a stack.
+ *
+ * __cds_lfs_pop_all does not require any synchronization with other
+ * push, nor with other __cds_lfs_pop_all, but requires synchronization
+ * matching the technique used to synchronize __cds_lfs_pop:
+ *
+ * 1) If __cds_lfs_pop is called under rcu read lock critical section,
+ *    both __cds_lfs_pop and cds_lfs_pop_all callers must wait for a
+ *    grace period to pass before freeing the returned node or modifying
+ *    the cds_lfs_node structure. However, no RCU read-side critical
+ *    section is needed around __cds_lfs_pop_all.
+ * 2) Using mutual exclusion (e.g. mutexes) to protect __cds_lfs_pop and
+ *    __cds_lfs_pop_all callers.
+ * 3) Ensuring that only ONE thread can call __cds_lfs_pop() and
+ *    __cds_lfs_pop_all(). (multi-provider/single-consumer scheme).
+ */
+static inline
+struct cds_lfs_head *___cds_lfs_pop_all(struct cds_lfs_stack *s)
+{
+	/*
+	 * Implicit memory barrier after uatomic_xchg() matches implicit
+	 * memory barrier before uatomic_cmpxchg() in cds_lfs_push. It
+	 * ensures that all nodes of the returned list are consistent.
+	 * There is no need to issue memory barriers when iterating on
+	 * the returned list, because the full memory barrier issued
+	 * prior to each uatomic_cmpxchg, which each write to head, are
+	 * taking care to order writes to each node prior to the full
+	 * memory barrier after this uatomic_xchg().
+	 */
+	return uatomic_xchg(&s->head, NULL);
+}
+
 #ifdef __cplusplus
 }
 #endif

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
