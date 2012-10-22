From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH urcu] wfstack: implement cds_wfs_pop_all and
	iterators, document API
Date: Mon, 22 Oct 2012 08:58:55 -0400
Message-ID: <20121022125855.GA30944__9864.26985259659$1350910776$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TQHar-0002uh-Nr
	for lttng-dev@lists.lttng.org; Mon, 22 Oct 2012 08:58:57 -0400
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
diff --git a/urcu/static/wfstack.h b/urcu/static/wfstack.h
index cb68a59..668ff7d 100644
--- a/urcu/static/wfstack.h
+++ b/urcu/static/wfstack.h
@@ -1,10 +1,10 @@
-#ifndef _URCU_WFSTACK_STATIC_H
-#define _URCU_WFSTACK_STATIC_H
+#ifndef _URCU_STATIC_WFSTACK_H
+#define _URCU_STATIC_WFSTACK_H
 
 /*
- * wfstack-static.h
+ * urcu/static/wfstack.h
  *
- * Userspace RCU library - Stack with Wait-Free push, Blocking pop.
+ * Userspace RCU library - Stack with with wait-free push, blocking traversal.
  *
  * TO BE INCLUDED ONLY IN LGPL-COMPATIBLE CODE. See wfstack.h for linking
  * dynamically with the userspace rcu library.
@@ -29,6 +29,7 @@
 #include <pthread.h>
 #include <assert.h>
 #include <poll.h>
+#include <stdbool.h>
 #include <urcu/compiler.h>
 #include <urcu/uatomic.h>
 
@@ -36,95 +37,292 @@
 extern "C" {
 #endif
 
-#define CDS_WF_STACK_END			((void *)0x1UL)
+#define CDS_WFS_END			((void *) 0x1UL)
 #define CDS_WFS_ADAPT_ATTEMPTS		10	/* Retry if being set */
 #define CDS_WFS_WAIT			10	/* Wait 10 ms if being set */
 
+/*
+ * Stack with wait-free push, blocking traversal.
+ *
+ * Stack implementing push, pop, pop_all operations, as well as iterator
+ * on the stack head returned by pop_all.
+ *
+ * Wait-free operations: cds_wfs_push, __cds_wfs_pop_all.
+ * Blocking operations: cds_wfs_pop, cds_wfs_pop_all, iteration on stack
+ *                      head returned by pop_all.
+ *
+ * Synchronization table:
+ *
+ * External synchronization techniques described in the API below is
+ * required between pairs marked with "X". No external synchronization
+ * required between pairs marked with "-".
+ *
+ *                      cds_wfs_push  __cds_wfs_pop  __cds_wfs_pop_all
+ * cds_wfs_push               -              -                  -
+ * __cds_wfs_pop              -              X                  X
+ * __cds_wfs_pop_all          -              X                  -
+ *
+ * cds_wfs_pop and cds_wfs_pop_all use an internal mutex to provide
+ * synchronization.
+ */
+
+/*
+ * cds_wfs_node_init: initialize wait-free stack node.
+ */
 static inline
 void _cds_wfs_node_init(struct cds_wfs_node *node)
 {
 	node->next = NULL;
 }
 
+/*
+ * cds_wfs_init: initialize wait-free stack.
+ */
 static inline
 void _cds_wfs_init(struct cds_wfs_stack *s)
 {
 	int ret;
 
-	s->head = CDS_WF_STACK_END;
+	s->head = CDS_WFS_END;
 	ret = pthread_mutex_init(&s->lock, NULL);
 	assert(!ret);
 }
 
+static inline bool ___cds_wfs_end(void *node)
+{
+	return node == CDS_WFS_END;
+}
+
 /*
- * Returns 0 if stack was empty, 1 otherwise.
+ * cds_wfs_empty: return whether wait-free stack is empty.
+ *
+ * No memory barrier is issued. No mutual exclusion is required.
+ */
+static inline bool _cds_wfs_empty(struct cds_wfs_stack *s)
+{
+	return ___cds_wfs_end(CMM_LOAD_SHARED(s->head));
+}
+
+/*
+ * cds_wfs_push: push a node into the stack.
+ *
+ * Issues a full memory barrier before push. No mutual exclusion is
+ * required.
+ *
+ * Returns 0 if the stack was empty prior to adding the node.
+ * Returns non-zero otherwise.
  */
 static inline
 int _cds_wfs_push(struct cds_wfs_stack *s, struct cds_wfs_node *node)
 {
-	struct cds_wfs_node *old_head;
+	struct cds_wfs_head *old_head, *new_head;
 
 	assert(node->next == NULL);
+	new_head = caa_container_of(node, struct cds_wfs_head, node);
 	/*
-	 * uatomic_xchg() implicit memory barrier orders earlier stores to node
-	 * (setting it to NULL) before publication.
+	 * uatomic_xchg() implicit memory barrier orders earlier stores
+	 * to node (setting it to NULL) before publication.
 	 */
-	old_head = uatomic_xchg(&s->head, node);
+	old_head = uatomic_xchg(&s->head, new_head);
 	/*
-	 * At this point, dequeuers see a NULL node->next, they should busy-wait
-	 * until node->next is set to old_head.
+	 * At this point, dequeuers see a NULL node->next, they should
+	 * busy-wait until node->next is set to old_head.
 	 */
-	CMM_STORE_SHARED(node->next, old_head);
-	return (old_head != CDS_WF_STACK_END);
+	CMM_STORE_SHARED(node->next, &old_head->node);
+	return !___cds_wfs_end(old_head);
 }
 
 /*
- * Returns NULL if stack is empty.
+ * Waiting for push to complete enqueue and return the next node.
  */
-static inline
-struct cds_wfs_node *
-___cds_wfs_pop_blocking(struct cds_wfs_stack *s)
+static inline struct cds_wfs_node *
+___cds_wfs_node_sync_next(struct cds_wfs_node *node)
 {
-	struct cds_wfs_node *head, *next;
+	struct cds_wfs_node *next;
 	int attempt = 0;
 
-retry:
-	head = CMM_LOAD_SHARED(s->head);
-	if (head == CDS_WF_STACK_END)
-		return NULL;
 	/*
 	 * Adaptative busy-looping waiting for push to complete.
 	 */
-	while ((next = CMM_LOAD_SHARED(head->next)) == NULL) {
+	while ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
 		if (++attempt >= CDS_WFS_ADAPT_ATTEMPTS) {
 			poll(NULL, 0, CDS_WFS_WAIT);	/* Wait for 10ms */
 			attempt = 0;
-		} else
+		} else {
 			caa_cpu_relax();
+		}
 	}
-	if (uatomic_cmpxchg(&s->head, head, next) == head)
-		return head;
-	else
-		goto retry;		/* Concurrent modification. Retry. */
+
+	return next;
 }
 
+/*
+ * __cds_wfs_pop_blocking: pop a node from the stack.
+ *
+ * Returns NULL if stack is empty.
+ *
+ * __cds_wfs_pop_blocking needs to be synchronized using one of the
+ * following techniques:
+ *
+ * 1) Calling __cds_wfs_pop_blocking under rcu read lock critical
+ *    section. The caller must wait for a grace period to pass before
+ *    freeing the returned node or modifying the cds_wfs_node structure.
+ * 2) Using mutual exclusion (e.g. mutexes) to protect
+ *     __cds_wfs_pop_blocking and __cds_wfs_pop_all callers.
+ * 3) Ensuring that only ONE thread can call __cds_wfs_pop_blocking()
+ *    and __cds_wfs_pop_all(). (multi-provider/single-consumer scheme).
+ */
 static inline
 struct cds_wfs_node *
-_cds_wfs_pop_blocking(struct cds_wfs_stack *s)
+___cds_wfs_pop_blocking(struct cds_wfs_stack *s)
+{
+	struct cds_wfs_head *head, *new_head;
+	struct cds_wfs_node *next;
+
+	for (;;) {
+		head = CMM_LOAD_SHARED(s->head);
+		if (___cds_wfs_end(head))
+			return NULL;
+		next = ___cds_wfs_node_sync_next(&head->node);
+		new_head = caa_container_of(next, struct cds_wfs_head, node);
+		if (uatomic_cmpxchg(&s->head, head, new_head) == head)
+			return &head->node;
+		/* busy-loop if head changed under us */
+	}
+}
+
+/*
+ * __cds_wfs_pop_all: pop all nodes from a stack.
+ *
+ * __cds_wfs_pop_all does not require any synchronization with other
+ * push, nor with other __cds_wfs_pop_all, but requires synchronization
+ * matching the technique used to synchronize __cds_wfs_pop_blocking:
+ *
+ * 1) If __cds_wfs_pop_blocking is called under rcu read lock critical
+ *    section, both __cds_wfs_pop_blocking and cds_wfs_pop_all callers
+ *    must wait for a grace period to pass before freeing the returned
+ *    node or modifying the cds_wfs_node structure. However, no RCU
+ *    read-side critical section is needed around __cds_wfs_pop_all.
+ * 2) Using mutual exclusion (e.g. mutexes) to protect
+ *     __cds_wfs_pop_blocking and __cds_wfs_pop_all callers.
+ * 3) Ensuring that only ONE thread can call __cds_wfs_pop_blocking()
+ *    and __cds_wfs_pop_all(). (multi-provider/single-consumer scheme).
+ */
+static inline
+struct cds_wfs_head *
+___cds_wfs_pop_all(struct cds_wfs_stack *s)
+{
+	struct cds_wfs_head *head;
+
+	/*
+	 * Implicit memory barrier after uatomic_xchg() matches implicit
+	 * memory barrier before uatomic_xchg() in cds_wfs_push. It
+	 * ensures that all nodes of the returned list are consistent.
+	 * There is no need to issue memory barriers when iterating on
+	 * the returned list, because the full memory barrier issued
+	 * prior to each uatomic_cmpxchg, which each write to head, are
+	 * taking care to order writes to each node prior to the full
+	 * memory barrier after this uatomic_xchg().
+	 */
+	head = uatomic_xchg(&s->head, CDS_WFS_END);
+	if (___cds_wfs_end(head))
+		return NULL;
+	return head;
+}
+
+/*
+ * cds_wfs_pop_lock: lock stack pop-protection mutex.
+ */
+static inline void _cds_wfs_pop_lock(struct cds_wfs_stack *s)
 {
-	struct cds_wfs_node *retnode;
 	int ret;
 
 	ret = pthread_mutex_lock(&s->lock);
 	assert(!ret);
-	retnode = ___cds_wfs_pop_blocking(s);
+}
+
+/*
+ * cds_wfs_pop_unlock: unlock stack pop-protection mutex.
+ */
+static inline void _cds_wfs_pop_unlock(struct cds_wfs_stack *s)
+{
+	int ret;
+
 	ret = pthread_mutex_unlock(&s->lock);
 	assert(!ret);
+}
+
+/*
+ * Call __cds_wfs_pop_blocking with an internal pop mutex held.
+ */
+static inline
+struct cds_wfs_node *
+_cds_wfs_pop_blocking(struct cds_wfs_stack *s)
+{
+	struct cds_wfs_node *retnode;
+
+	_cds_wfs_pop_lock(s);
+	retnode = ___cds_wfs_pop_blocking(s);
+	_cds_wfs_pop_unlock(s);
 	return retnode;
 }
 
+/*
+ * Call __cds_wfs_pop_all with an internal pop mutex held.
+ */
+static inline
+struct cds_wfs_head *
+_cds_wfs_pop_all_blocking(struct cds_wfs_stack *s)
+{
+	struct cds_wfs_head *rethead;
+
+	_cds_wfs_pop_lock(s);
+	rethead = ___cds_wfs_pop_all(s);
+	_cds_wfs_pop_unlock(s);
+	return rethead;
+}
+
+/*
+ * cds_wfs_first_blocking: get first node of a popped stack.
+ *
+ * Content written into the node before enqueue is guaranteed to be
+ * consistent, but no other memory ordering is ensured.
+ *
+ * Used by for-like iteration macros in urcu/wfstack.h:
+ * cds_wfs_for_each_blocking()
+ * cds_wfs_for_each_blocking_safe()
+ */
+static inline struct cds_wfs_node *
+_cds_wfs_first_blocking(struct cds_wfs_head *head)
+{
+	if (___cds_wfs_end(head))
+		return NULL;
+	return &head->node;
+}
+
+/*
+ * cds_wfs_next_blocking: get next node of a popped stack.
+ *
+ * Content written into the node before enqueue is guaranteed to be
+ * consistent, but no other memory ordering is ensured.
+ *
+ * Used by for-like iteration macros in urcu/wfstack.h:
+ * cds_wfs_for_each_blocking()
+ * cds_wfs_for_each_blocking_safe()
+ */
+static inline struct cds_wfs_node *
+_cds_wfs_next_blocking(struct cds_wfs_node *node)
+{
+	struct cds_wfs_node *next;
+
+	next = ___cds_wfs_node_sync_next(node);
+	if (___cds_wfs_end(next))
+		return NULL;
+	return next;
+}
+
 #ifdef __cplusplus
 }
 #endif
 
-#endif /* _URCU_WFSTACK_STATIC_H */
+#endif /* _URCU_STATIC_WFSTACK_H */
diff --git a/urcu/wfstack.h b/urcu/wfstack.h
index db2ee0c..b6992e8 100644
--- a/urcu/wfstack.h
+++ b/urcu/wfstack.h
@@ -2,9 +2,9 @@
 #define _URCU_WFSTACK_H
 
 /*
- * wfstack.h
+ * urcu/wfstack.h
  *
- * Userspace RCU library - Stack with Wait-Free push, Blocking pop.
+ * Userspace RCU library - Stack with wait-free push, blocking traversal.
  *
  * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  *
@@ -25,18 +25,59 @@
 
 #include <pthread.h>
 #include <assert.h>
+#include <stdbool.h>
 #include <urcu/compiler.h>
 
 #ifdef __cplusplus
 extern "C" {
 #endif
 
+/*
+ * Stack with wait-free push, blocking traversal.
+ *
+ * Stack implementing push, pop, pop_all operations, as well as iterator
+ * on the stack head returned by pop_all.
+ *
+ * Wait-free operations: cds_wfs_push, __cds_wfs_pop_all.
+ * Blocking operations: cds_wfs_pop, cds_wfs_pop_all, iteration on stack
+ *                      head returned by pop_all.
+ *
+ * Synchronization table:
+ *
+ * External synchronization techniques described in the API below is
+ * required between pairs marked with "X". No external synchronization
+ * required between pairs marked with "-".
+ *
+ *                      cds_wfs_push  __cds_wfs_pop  __cds_wfs_pop_all
+ * cds_wfs_push               -              -                  -
+ * __cds_wfs_pop              -              X                  X
+ * __cds_wfs_pop_all          -              X                  -
+ *
+ * cds_wfs_pop and cds_wfs_pop_all use an internal mutex to provide
+ * synchronization.
+ */
+
+/*
+ * struct cds_wfs_node is returned by __cds_wfs_pop, and also used as
+ * iterator on stack. It is not safe to dereference the node next
+ * pointer when returned by __cds_wfs_pop_blocking.
+ */
 struct cds_wfs_node {
 	struct cds_wfs_node *next;
 };
 
+/*
+ * struct cds_wfs_head is returned by __cds_wfs_pop_all, and can be used
+ * to begin iteration on the stack. "node" needs to be the first field of
+ * cds_wfs_head, so the end-of-stack pointer value can be used for both
+ * types.
+ */
+struct cds_wfs_head {
+	struct cds_wfs_node node;
+};
+
 struct cds_wfs_stack {
-	struct cds_wfs_node *head;
+	struct cds_wfs_head *head;
 	pthread_mutex_t lock;
 };
 
@@ -45,24 +86,179 @@ struct cds_wfs_stack {
 #include <urcu/static/wfstack.h>
 
 #define cds_wfs_node_init		_cds_wfs_node_init
-#define cds_wfs_init		_cds_wfs_init
-#define cds_wfs_push		_cds_wfs_push
-#define __cds_wfs_pop_blocking	___cds_wfs_pop_blocking
-#define cds_wfs_pop_blocking	_cds_wfs_pop_blocking
+#define cds_wfs_init			_cds_wfs_init
+#define cds_wfs_empty			_cds_wfs_empty
+#define cds_wfs_push			_cds_wfs_push
+
+/* Locking performed internally */
+#define cds_wfs_pop_blocking		_cds_wfs_pop_blocking
+#define cds_wfs_pop_all_blocking	_cds_wfs_pop_all_blocking
+
+/*
+ * For iteration on cds_wfs_head returned by __cds_wfs_pop_all or
+ * cds_wfs_pop_all_blocking.
+ */
+#define cds_wfs_first_blocking		_cds_wfs_first_blocking
+#define cds_wfs_next_blocking		_cds_wfs_next_blocking
+
+/* Pop locking with internal mutex */
+#define cds_wfs_pop_lock		_cds_wfs_pop_lock
+#define cds_wfs_pop_unlock		_cds_wfs_pop_unlock
+
+/* Synchronization ensured by the caller. See synchronization table. */
+#define __cds_wfs_pop_blocking		___cds_wfs_pop_blocking
+#define __cds_wfs_pop_all		___cds_wfs_pop_all
 
 #else /* !_LGPL_SOURCE */
 
+/*
+ * cds_wfs_node_init: initialize wait-free stack node.
+ */
 extern void cds_wfs_node_init(struct cds_wfs_node *node);
+
+/*
+ * cds_wfs_init: initialize wait-free stack.
+ */
 extern void cds_wfs_init(struct cds_wfs_stack *s);
+
+/*
+ * cds_wfs_empty: return whether wait-free stack is empty.
+ *
+ * No memory barrier is issued. No mutual exclusion is required.
+ */
+extern bool cds_wfs_empty(struct cds_wfs_stack *s);
+
+/*
+ * cds_wfs_push: push a node into the stack.
+ *
+ * Issues a full memory barrier before push. No mutual exclusion is
+ * required.
+ *
+ * Returns 0 if the stack was empty prior to adding the node.
+ * Returns non-zero otherwise.
+ */
 extern int cds_wfs_push(struct cds_wfs_stack *s, struct cds_wfs_node *node);
-/* __cds_wfs_pop_blocking: caller ensures mutual exclusion between pops */
-extern struct cds_wfs_node *__cds_wfs_pop_blocking(struct cds_wfs_stack *s);
+
+/*
+ * cds_wfs_pop_blocking: pop a node from the stack.
+ *
+ * Calls __cds_wfs_pop_blocking with an internal pop mutex held.
+ */
 extern struct cds_wfs_node *cds_wfs_pop_blocking(struct cds_wfs_stack *s);
 
+/*
+ * cds_wfs_pop_all_blocking: pop all nodes from a stack.
+ *
+ * Calls __cds_wfs_pop_all with an internal pop mutex held.
+ */
+extern struct cds_wfs_head *cds_wfs_pop_all_blocking(struct cds_wfs_stack *s);
+
+/*
+ * cds_wfs_first_blocking: get first node of a popped stack.
+ *
+ * Content written into the node before enqueue is guaranteed to be
+ * consistent, but no other memory ordering is ensured.
+ *
+ * Used by for-like iteration macros in urcu/wfstack.h:
+ * cds_wfs_for_each_blocking()
+ * cds_wfs_for_each_blocking_safe()
+ */
+extern struct cds_wfs_node *cds_wfs_first_blocking(struct cds_wfs_head *head);
+
+/*
+ * cds_wfs_next_blocking: get next node of a popped stack.
+ *
+ * Content written into the node before enqueue is guaranteed to be
+ * consistent, but no other memory ordering is ensured.
+ *
+ * Used by for-like iteration macros in urcu/wfstack.h:
+ * cds_wfs_for_each_blocking()
+ * cds_wfs_for_each_blocking_safe()
+ */
+extern struct cds_wfs_node *cds_wfs_next_blocking(struct cds_wfs_node *node);
+
+/*
+ * cds_wfs_pop_lock: lock stack pop-protection mutex.
+ */
+extern void cds_wfs_pop_lock(struct cds_wfs_stack *s);
+
+/*
+ * cds_wfs_pop_unlock: unlock stack pop-protection mutex.
+ */
+extern void cds_wfs_pop_unlock(struct cds_wfs_stack *s);
+
+/*
+ * __cds_wfs_pop_blocking: pop a node from the stack.
+ *
+ * Returns NULL if stack is empty.
+ *
+ * __cds_wfs_pop_blocking needs to be synchronized using one of the
+ * following techniques:
+ *
+ * 1) Calling __cds_wfs_pop_blocking under rcu read lock critical
+ *    section. The caller must wait for a grace period to pass before
+ *    freeing the returned node or modifying the cds_wfs_node structure.
+ * 2) Using mutual exclusion (e.g. mutexes) to protect
+ *     __cds_wfs_pop_blocking and __cds_wfs_pop_all callers.
+ * 3) Ensuring that only ONE thread can call __cds_wfs_pop_blocking()
+ *    and __cds_wfs_pop_all(). (multi-provider/single-consumer scheme).
+ */
+extern struct cds_wfs_node *__cds_wfs_pop_blocking(struct cds_wfs_stack *s);
+
+/*
+ * __cds_wfs_pop_all: pop all nodes from a stack.
+ *
+ * __cds_wfs_pop_all does not require any synchronization with other
+ * push, nor with other __cds_wfs_pop_all, but requires synchronization
+ * matching the technique used to synchronize __cds_wfs_pop_blocking:
+ *
+ * 1) If __cds_wfs_pop_blocking is called under rcu read lock critical
+ *    section, both __cds_wfs_pop_blocking and cds_wfs_pop_all callers
+ *    must wait for a grace period to pass before freeing the returned
+ *    node or modifying the cds_wfs_node structure. However, no RCU
+ *    read-side critical section is needed around __cds_wfs_pop_all.
+ * 2) Using mutual exclusion (e.g. mutexes) to protect
+ *     __cds_wfs_pop_blocking and __cds_wfs_pop_all callers.
+ * 3) Ensuring that only ONE thread can call __cds_wfs_pop_blocking()
+ *    and __cds_wfs_pop_all(). (multi-provider/single-consumer scheme).
+ */
+extern struct cds_wfs_head *__cds_wfs_pop_all(struct cds_wfs_stack *s);
+
 #endif /* !_LGPL_SOURCE */
 
 #ifdef __cplusplus
 }
 #endif
 
+/*
+ * cds_wfs_for_each_blocking: Iterate over all nodes returned by
+ * __cds_wfs_pop_all().
+ * @head: head of the queue (struct cds_wfs_head pointer).
+ * @node: iterator (struct cds_wfs_node pointer).
+ *
+ * Content written into each node before enqueue is guaranteed to be
+ * consistent, but no other memory ordering is ensured.
+ */
+#define cds_wfs_for_each_blocking(head, node)			\
+	for (node = cds_wfs_first_blocking(head);		\
+		node != NULL;					\
+		node = cds_wfs_next_blocking(node))
+
+/*
+ * cds_wfs_for_each_blocking_safe: Iterate over all nodes returned by
+ * __cds_wfs_pop_all(). Safe against deletion.
+ * @head: head of the queue (struct cds_wfs_head pointer).
+ * @node: iterator (struct cds_wfs_node pointer).
+ * @n: struct cds_wfs_node pointer holding the next pointer (used
+ *     internally).
+ *
+ * Content written into each node before enqueue is guaranteed to be
+ * consistent, but no other memory ordering is ensured.
+ */
+#define cds_wfs_for_each_blocking_safe(head, node, n)			   \
+	for (node = cds_wfs_first_blocking(head),			   \
+			n = (node ? cds_wfs_next_blocking(node) : NULL);   \
+		node != NULL;						   \
+		node = n, n = (node ? cds_wfs_next_blocking(node) : NULL))
+
 #endif /* _URCU_WFSTACK_H */
diff --git a/wfstack.c b/wfstack.c
index e9799e6..48f290c 100644
--- a/wfstack.c
+++ b/wfstack.c
@@ -1,7 +1,7 @@
 /*
  * wfstack.c
  *
- * Userspace RCU library - Stack with Wait-Free push, Blocking pop.
+ * Userspace RCU library - Stack with wait-free push, blocking traversal.
  *
  * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  *
@@ -38,17 +38,52 @@ void cds_wfs_init(struct cds_wfs_stack *s)
 	_cds_wfs_init(s);
 }
 
+bool cds_wfs_empty(struct cds_wfs_stack *s)
+{
+	return _cds_wfs_empty(s);
+}
+
 int cds_wfs_push(struct cds_wfs_stack *s, struct cds_wfs_node *node)
 {
 	return _cds_wfs_push(s, node);
 }
 
+struct cds_wfs_node *cds_wfs_pop_blocking(struct cds_wfs_stack *s)
+{
+	return _cds_wfs_pop_blocking(s);
+}
+
+struct cds_wfs_head *cds_wfs_pop_all_blocking(struct cds_wfs_stack *s)
+{
+	return _cds_wfs_pop_all_blocking(s);
+}
+
+struct cds_wfs_node *cds_wfs_first_blocking(struct cds_wfs_head *head)
+{
+	return _cds_wfs_first_blocking(head);
+}
+
+struct cds_wfs_node *cds_wfs_next_blocking(struct cds_wfs_node *node)
+{
+	return _cds_wfs_next_blocking(node);
+}
+
+void cds_wfs_pop_lock(struct cds_wfs_stack *s)
+{
+	_cds_wfs_pop_lock(s);
+}
+
+void cds_wfs_pop_unlock(struct cds_wfs_stack *s)
+{
+	_cds_wfs_pop_unlock(s);
+}
+
 struct cds_wfs_node *__cds_wfs_pop_blocking(struct cds_wfs_stack *s)
 {
 	return ___cds_wfs_pop_blocking(s);
 }
 
-struct cds_wfs_node *cds_wfs_pop_blocking(struct cds_wfs_stack *s)
+struct cds_wfs_head *__cds_wfs_pop_all(struct cds_wfs_stack *s)
 {
-	return _cds_wfs_pop_blocking(s);
+	return ___cds_wfs_pop_all(s);
 }

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
