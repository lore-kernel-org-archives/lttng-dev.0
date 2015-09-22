From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH urcu] lfstack: relax constraints on node
	re-use
Date: Tue, 22 Sep 2015 14:49:25 -0400
Message-ID: <1442947766-12746-1-git-send-email-mathieu.desnoyers__49646.1920942695$1442947880$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZeSdJ-0001ST-2Q
 for lttng-dev@lists.lttng.org; Tue, 22 Sep 2015 14:49:51 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

The documentation of the RCU-based synchronization technique in lfstack
is too strict. It currently states that the cds_lfs_node structure
cannot be overwritten before a grace period has passed. However, lfstack
pop only use the next pointer as the replacement value when doing the
cmpxchg on the head. After the node has been pop'd from the stack,
concurrent cmpxchg trying to pop that same node will necessarily fail as
long as there is a grace period before pop/pop_all and re-adding the
node into the stack.

It is therefore sufficient to wait for a grace period between:
1) pop/pop_all and
2) freeing the node (to ensure existence for concurrent pop trying to
   read node->next) or re-adding the node into the stack.

This node re-use constraint relaxation is only possible because we don't
care about node->next content read by concurrent pop: it will be simply
discarded by the cmpxchg on head. Be careful not to apply this relaxed
constraint to other data structures which care about the content of the
node's next pointer (e.g. wfstack).

This relaxed constraint allows implementing efficient free-lists (memory
allocation) with a lock-free allocation/free based on lfstack: it allows
re-using the memory backing the free-list node immediately after
allocation. The only requirement with respect to this use-case is to
wait for a grace period before putting the node back into the free-list.

Also update the test_urcu_lfs to poison the next pointer immediately
after pop/pop_all to make sure we test this relaxed constraint.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <jiangshanlai@gmail.com>
CC: lttng-dev@lists.lttng.org
CC: rp@svcs.cs.pdx.edu
---
 tests/benchmark/test_urcu_lfs.c |  4 ++++
 urcu/lfstack.h                  | 19 ++++++++++++-------
 urcu/static/lfstack.h           | 20 +++++++++++++-------
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/tests/benchmark/test_urcu_lfs.c b/tests/benchmark/test_urcu_lfs.c
index 2101532..1d2dc84 100644
--- a/tests/benchmark/test_urcu_lfs.c
+++ b/tests/benchmark/test_urcu_lfs.c
@@ -50,6 +50,8 @@
 #include <urcu.h>
 #include <urcu/cds.h>
 
+#define POISON_PTR	((void *) 0x42UL)
+
 /*
  * External synchronization used.
  */
@@ -219,6 +221,7 @@ void do_test_pop(enum test_sync sync)
 	if (snode) {
 		struct test *node;
 
+		snode->next = POISON_PTR;
 		node = caa_container_of(snode,
 			struct test, list);
 		if (sync == TEST_SYNC_RCU)
@@ -241,6 +244,7 @@ void do_test_pop_all(enum test_sync sync)
 	cds_lfs_for_each_safe(head, snode, n) {
 		struct test *node;
 
+		snode->next = POISON_PTR;
 		node = caa_container_of(snode, struct test, list);
 		if (sync == TEST_SYNC_RCU)
 			call_rcu(&node->rcu, free_node_cb);
diff --git a/urcu/lfstack.h b/urcu/lfstack.h
index fa58054..11a63d9 100644
--- a/urcu/lfstack.h
+++ b/urcu/lfstack.h
@@ -178,9 +178,12 @@ extern void cds_lfs_pop_unlock(struct cds_lfs_stack *s);
  * __cds_lfs_pop needs to be synchronized using one of the following
  * techniques:
  *
- * 1) Calling __cds_lfs_pop under rcu read lock critical section. The
- *    caller must wait for a grace period to pass before freeing the
- *    returned node or modifying the cds_lfs_node structure.
+ * 1) Calling __cds_lfs_pop under rcu read lock critical section.
+ *    Both __cds_lfs_pop and __cds_lfs_pop_all callers must wait for a
+ *    grace period to pass before freeing the returned node or pushing
+ *    the node back into the stack. It is valid to overwrite the content
+ *    of cds_lfs_node immediately after __cds_lfs_pop and
+ *    __cds_lfs_pop_all.
  * 2) Using mutual exclusion (e.g. mutexes) to protect __cds_lfs_pop
  *    and __cds_lfs_pop_all callers.
  * 3) Ensuring that only ONE thread can call __cds_lfs_pop() and
@@ -196,10 +199,12 @@ extern struct cds_lfs_node *__cds_lfs_pop(cds_lfs_stack_ptr_t s);
  * matching the technique used to synchronize __cds_lfs_pop:
  *
  * 1) If __cds_lfs_pop is called under rcu read lock critical section,
- *    both __cds_lfs_pop and cds_lfs_pop_all callers must wait for a
- *    grace period to pass before freeing the returned node or modifying
- *    the cds_lfs_node structure. However, no RCU read-side critical
- *    section is needed around __cds_lfs_pop_all.
+ *    both __cds_lfs_pop and __cds_lfs_pop_all callers must wait for a
+ *    grace period to pass before freeing the returned node or pushing
+ *    the node back into the stack. It is valid to overwrite the content
+ *    of cds_lfs_node immediately after __cds_lfs_pop and
+ *    __cds_lfs_pop_all. No RCU read-side critical section is needed
+ *    around __cds_lfs_pop_all.
  * 2) Using mutual exclusion (e.g. mutexes) to protect __cds_lfs_pop and
  *    __cds_lfs_pop_all callers.
  * 3) Ensuring that only ONE thread can call __cds_lfs_pop() and
diff --git a/urcu/static/lfstack.h b/urcu/static/lfstack.h
index 41895a6..7afe71e 100644
--- a/urcu/static/lfstack.h
+++ b/urcu/static/lfstack.h
@@ -169,9 +169,13 @@ bool _cds_lfs_push(cds_lfs_stack_ptr_t u_s,
  * __cds_lfs_pop needs to be synchronized using one of the following
  * techniques:
  *
- * 1) Calling __cds_lfs_pop under rcu read lock critical section. The
- *    caller must wait for a grace period to pass before freeing the
- *    returned node or modifying the cds_lfs_node structure.
+ * 1) Calling __cds_lfs_pop under rcu read lock critical section.
+ *    Both __cds_lfs_pop and __cds_lfs_pop_all callers must wait for a
+ *    grace period to pass before freeing the returned node or pushing
+ *    the node back into the stack. It is valid to overwrite the content
+ *    of cds_lfs_node immediately after __cds_lfs_pop and
+ *    __cds_lfs_pop_all. No RCU read-side critical section is needed
+ *    around __cds_lfs_pop_all.
  * 2) Using mutual exclusion (e.g. mutexes) to protect __cds_lfs_pop
  *    and __cds_lfs_pop_all callers.
  * 3) Ensuring that only ONE thread can call __cds_lfs_pop() and
@@ -213,10 +217,12 @@ struct cds_lfs_node *___cds_lfs_pop(cds_lfs_stack_ptr_t u_s)
  * matching the technique used to synchronize __cds_lfs_pop:
  *
  * 1) If __cds_lfs_pop is called under rcu read lock critical section,
- *    both __cds_lfs_pop and cds_lfs_pop_all callers must wait for a
- *    grace period to pass before freeing the returned node or modifying
- *    the cds_lfs_node structure. However, no RCU read-side critical
- *    section is needed around __cds_lfs_pop_all.
+ *    both __cds_lfs_pop and __cds_lfs_pop_all callers must wait for a
+ *    grace period to pass before freeing the returned node or pushing
+ *    the node back into the stack. It is valid to overwrite the content
+ *    of cds_lfs_node immediately after __cds_lfs_pop and
+ *    __cds_lfs_pop_all. No RCU read-side critical section is needed
+ *    around __cds_lfs_pop_all.
  * 2) Using mutual exclusion (e.g. mutexes) to protect __cds_lfs_pop and
  *    __cds_lfs_pop_all callers.
  * 3) Ensuring that only ONE thread can call __cds_lfs_pop() and
-- 
2.1.4
