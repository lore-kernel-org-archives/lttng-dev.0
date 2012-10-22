From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH urcu] lfstack: implement empty,
	pop_all and iterators, document API
Date: Mon, 22 Oct 2012 09:03:40 -0400
Message-ID: <20121022130340.GE30944__30563.8628350154$1350911053$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TQHfS-00031O-DY
	for lttng-dev@lists.lttng.org; Mon, 22 Oct 2012 09:03:42 -0400
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

We are changing the ABI by adding a mutex into struct cds_lfs_stack.
This ABI has never been exposed in a release so far, so we can change
it.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Paul McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
---
diff --git a/lfstack.c b/lfstack.c
index 74ffd4f..db2c2cf 100644
--- a/lfstack.c
+++ b/lfstack.c
@@ -40,12 +40,42 @@ void cds_lfs_init(struct cds_lfs_stack *s)
 	_cds_lfs_init(s);
 }
 
-int cds_lfs_push(struct cds_lfs_stack *s, struct cds_lfs_node *node)
+bool cds_lfs_empty(struct cds_lfs_stack *s)
+{
+	return _cds_lfs_empty(s);
+}
+
+bool cds_lfs_push(struct cds_lfs_stack *s, struct cds_lfs_node *node)
 {
 	return _cds_lfs_push(s, node);
 }
 
-struct cds_lfs_node *cds_lfs_pop(struct cds_lfs_stack *s)
+struct cds_lfs_node *cds_lfs_pop_blocking(struct cds_lfs_stack *s)
+{
+	return _cds_lfs_pop_blocking(s);
+}
+
+struct cds_lfs_head *cds_lfs_pop_all_blocking(struct cds_lfs_stack *s)
+{
+	return _cds_lfs_pop_all_blocking(s);
+}
+
+void cds_lfs_pop_lock(struct cds_lfs_stack *s)
+{
+	_cds_lfs_pop_lock(s);
+}
+
+void cds_lfs_pop_unlock(struct cds_lfs_stack *s)
+{
+	_cds_lfs_pop_unlock(s);
+}
+
+struct cds_lfs_node *__cds_lfs_pop(struct cds_lfs_stack *s)
+{
+	return ___cds_lfs_pop(s);
+}
+
+struct cds_lfs_head *__cds_lfs_pop_all(struct cds_lfs_stack *s)
 {
-	return _cds_lfs_pop(s);
+	return ___cds_lfs_pop_all(s);
 }
diff --git a/tests/test_urcu_lfs.c b/tests/test_urcu_lfs.c
index e15c677..6c30884 100644
--- a/tests/test_urcu_lfs.c
+++ b/tests/test_urcu_lfs.c
@@ -236,7 +236,7 @@ void *thr_dequeuer(void *_count)
 		struct cds_lfs_node *snode;
 
 		rcu_read_lock();
-		snode = cds_lfs_pop(&s);
+		snode = __cds_lfs_pop(&s);
 		rcu_read_unlock();
 		if (snode) {
 			struct test *node;
@@ -268,7 +268,7 @@ void test_end(struct cds_lfs_stack *s, unsigned long long *nr_dequeues)
 	struct cds_lfs_node *snode;
 
 	do {
-		snode = cds_lfs_pop(s);
+		snode = __cds_lfs_pop(s);
 		if (snode) {
 			struct test *node;
 
diff --git a/urcu/lfstack.h b/urcu/lfstack.h
index d068739..eddff0e 100644
--- a/urcu/lfstack.h
+++ b/urcu/lfstack.h
@@ -27,12 +27,52 @@
 extern "C" {
 #endif
 
+#include <stdbool.h>
+#include <pthread.h>
+
+/*
+ * Lock-free stack.
+ *
+ * Stack implementing push, pop, pop_all operations, as well as iterator
+ * on the stack head returned by pop_all.
+ *
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
+ *
+ * cds_lfs_pop_blocking and cds_lfs_pop_all_blocking use an internal
+ * mutex to provide synchronization.
+ */
+
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
+ * to begin iteration on the stack. "node" needs to be the first field
+ * of cds_lfs_head, so the end-of-stack pointer value can be used for
+ * both types.
+ */
+struct cds_lfs_head {
+	struct cds_lfs_node node;
+};
+
 struct cds_lfs_stack {
-	struct cds_lfs_node *head;
+	struct cds_lfs_head *head;
+	pthread_mutex_t lock;
 };
 
 #ifdef _LGPL_SOURCE
@@ -41,15 +81,41 @@ struct cds_lfs_stack {
 
 #define cds_lfs_node_init		_cds_lfs_node_init
 #define cds_lfs_init			_cds_lfs_init
+#define cds_lfs_empty			_cds_lfs_empty
 #define cds_lfs_push			_cds_lfs_push
-#define cds_lfs_pop			_cds_lfs_pop
+
+/* Locking performed internally */
+#define cds_lfs_pop_blocking		_cds_lfs_pop_blocking
+#define cds_lfs_pop_all_blocking	_cds_lfs_pop_all_blocking
+
+/* Synchronize pop with internal mutex */
+#define cds_lfs_pop_lock		_cds_lfs_pop_lock
+#define cds_lfs_pop_unlock		_cds_lfs_pop_unlock
+
+/* Synchronization ensured by the caller. See synchronization table. */
+#define __cds_lfs_pop			___cds_lfs_pop
+#define __cds_lfs_pop_all		___cds_lfs_pop_all
 
 #else /* !_LGPL_SOURCE */
 
+/*
+ * cds_lfs_node_init: initialize lock-free stack node.
+ */
 extern void cds_lfs_node_init(struct cds_lfs_node *node);
+
+/*
+ * cds_lfs_init: initialize lock-free stack.
+ */
 extern void cds_lfs_init(struct cds_lfs_stack *s);
 
 /*
+ * cds_lfs_empty: return whether lock-free stack is empty.
+ *
+ * No memory barrier is issued. No mutual exclusion is required.
+ */
+extern bool cds_lfs_empty(struct cds_lfs_stack *s);
+
+/*
  * cds_lfs_push: push a node into the stack.
  *
  * Does not require any synchronization with other push nor pop.
@@ -57,29 +123,102 @@ extern void cds_lfs_init(struct cds_lfs_stack *s);
  * Returns 0 if the stack was empty prior to adding the node.
  * Returns non-zero otherwise.
  */
-extern int cds_lfs_push(struct cds_lfs_stack *s,
+extern bool cds_lfs_push(struct cds_lfs_stack *s,
 			struct cds_lfs_node *node);
 
 /*
- * cds_lfs_pop: pop a node from the stack.
+ * cds_lfs_pop_blocking: pop a node from the stack.
+ *
+ * Calls __cds_lfs_pop with an internal pop mutex held.
+ */
+extern struct cds_lfs_node *cds_lfs_pop_blocking(struct cds_lfs_stack *s);
+
+/*
+ * cds_lfs_pop_all_blocking: pop all nodes from a stack.
+ *
+ * Calls __cds_lfs_pop_all with an internal pop mutex held.
+ */
+extern struct cds_lfs_head *cds_lfs_pop_all_blocking(struct cds_lfs_stack *s);
+
+/*
+ * cds_lfs_pop_lock: lock stack pop-protection mutex.
+ */
+extern void cds_lfs_pop_lock(struct cds_lfs_stack *s);
+
+/*
+ * cds_lfs_pop_unlock: unlock stack pop-protection mutex.
+ */
+extern void cds_lfs_pop_unlock(struct cds_lfs_stack *s);
+
+/*
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
-extern struct cds_lfs_node *cds_lfs_pop(struct cds_lfs_stack *s);
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
+ */
+extern struct cds_lfs_head *__cds_lfs_pop_all(struct cds_lfs_stack *s);
 
 #endif /* !_LGPL_SOURCE */
 
+/*
+ * cds_lfs_for_each: Iterate over all nodes returned by
+ *                   __cds_lfs_pop_all.
+ * @__head: node returned by __cds_lfs_pop_all (struct cds_lfs_head pointer).
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
+ * @__head: node returned by __cds_lfs_pop_all (struct cds_lfs_head pointer).
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
index 7acbf54..77a26dc 100644
--- a/urcu/static/lfstack.h
+++ b/urcu/static/lfstack.h
@@ -26,6 +26,9 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+#include <stdbool.h>
+#include <pthread.h>
+#include <assert.h>
 #include <urcu/uatomic.h>
 #include <urcu-pointer.h>
 
@@ -33,15 +36,63 @@
 extern "C" {
 #endif
 
+/*
+ * Lock-free stack.
+ *
+ * Stack implementing push, pop, pop_all operations, as well as iterator
+ * on the stack head returned by pop_all.
+ *
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
+ *
+ * cds_lfs_pop_blocking and cds_lfs_pop_all_blocking use an internal
+ * mutex to provide synchronization.
+ */
+
+/*
+ * cds_lfs_node_init: initialize lock-free stack node.
+ */
 static inline
 void _cds_lfs_node_init(struct cds_lfs_node *node)
 {
 }
 
+/*
+ * cds_lfs_init: initialize lock-free stack.
+ */
 static inline
 void _cds_lfs_init(struct cds_lfs_stack *s)
 {
+        int ret;
+
 	s->head = NULL;
+	ret = pthread_mutex_init(&s->lock, NULL);
+	assert(!ret);
+}
+
+static inline
+bool ___cds_lfs_empty_head(struct cds_lfs_head *head)
+{
+	return head == NULL;
+}
+
+/*
+ * cds_lfs_empty: return whether lock-free stack is empty.
+ *
+ * No memory barrier is issued. No mutual exclusion is required.
+ */
+static inline
+bool _cds_lfs_empty(struct cds_lfs_stack *s)
+{
+	return ___cds_lfs_empty_head(CMM_LOAD_SHARED(s->head));
 }
 
 /*
@@ -74,76 +125,159 @@ void _cds_lfs_init(struct cds_lfs_stack *s)
  * Returns non-zero otherwise.
  */
 static inline
-int _cds_lfs_push(struct cds_lfs_stack *s,
+bool _cds_lfs_push(struct cds_lfs_stack *s,
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
-	return (int) !!((unsigned long) head);
+	return ___cds_lfs_empty_head(head);
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
+		struct cds_lfs_head *head, *next_head;
+		struct cds_lfs_node *next;
 
 		head = _CMM_LOAD_SHARED(s->head);
-		if (head) {
-			struct cds_lfs_node *next;
-
-			/*
-			 * Read head before head->next. Matches the
-			 * implicit memory barrier before
-			 * uatomic_cmpxchg() in cds_lfs_push.
-			 */
-			cmm_smp_read_barrier_depends();
-			next = _CMM_LOAD_SHARED(head->next);
-			if (uatomic_cmpxchg(&s->head, head, next) == head) {
-				return head;
-			} else {
-				/* Concurrent modification. Retry. */
-				continue;
-			}
-		} else {
-			/* Empty stack */
-			return NULL;
-		}
+		if (___cds_lfs_empty_head(head))
+			return NULL;	/* Empty stack */
+
+		/*
+		 * Read head before head->next. Matches the implicit
+		 * memory barrier before uatomic_cmpxchg() in
+		 * cds_lfs_push.
+		 */
+		cmm_smp_read_barrier_depends();
+		next = _CMM_LOAD_SHARED(head->node.next);
+		next_head = caa_container_of(next,
+				struct cds_lfs_head, node);
+		if (uatomic_cmpxchg(&s->head, head, next_head) == head)
+			return &head->node;
+		/* busy-loop if head changed under us */
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
+/*
+ * cds_lfs_pop_lock: lock stack pop-protection mutex.
+ */
+static inline void _cds_lfs_pop_lock(struct cds_lfs_stack *s)
+{
+	int ret;
+
+	ret = pthread_mutex_lock(&s->lock);
+	assert(!ret);
+}
+
+/*
+ * cds_lfs_pop_unlock: unlock stack pop-protection mutex.
+ */
+static inline void _cds_lfs_pop_unlock(struct cds_lfs_stack *s)
+{
+	int ret;
+
+	ret = pthread_mutex_unlock(&s->lock);
+	assert(!ret);
+}
+
+/*
+ * Call __cds_lfs_pop with an internal pop mutex held.
+ */
+static inline
+struct cds_lfs_node *
+_cds_lfs_pop_blocking(struct cds_lfs_stack *s)
+{
+	struct cds_lfs_node *retnode;
+
+	_cds_lfs_pop_lock(s);
+	retnode = ___cds_lfs_pop(s);
+	_cds_lfs_pop_unlock(s);
+	return retnode;
+}
+
+/*
+ * Call __cds_lfs_pop_all with an internal pop mutex held.
+ */
+static inline
+struct cds_lfs_head *
+_cds_lfs_pop_all_blocking(struct cds_lfs_stack *s)
+{
+	struct cds_lfs_head *rethead;
+
+	_cds_lfs_pop_lock(s);
+	rethead = ___cds_lfs_pop_all(s);
+	_cds_lfs_pop_unlock(s);
+	return rethead;
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
