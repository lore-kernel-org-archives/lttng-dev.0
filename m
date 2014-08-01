From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH urcu v2] lfstack: Implement mutex-free stack
	head with transparent union
Date: Thu, 31 Jul 2014 21:05:54 -0400
Message-ID: <1406855154-16964-1-git-send-email-mathieu.desnoyers__13315.9004887149$1406855225$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XD1IU-0007pc-U2
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 21:06:17 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Eric Wong <normalperson@yhbt.net>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Changes since v1:
- implement __cds_lfs_init().

CC: "Eric Wong" <normalperson@yhbt.net>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: "Lai Jiangshan" <laijs@cn.fujitsu.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 lfstack.c             | 13 +++++++++----
 urcu/lfstack.h        | 27 +++++++++++++++++++++++----
 urcu/static/lfstack.h | 24 +++++++++++++++++++-----
 3 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/lfstack.c b/lfstack.c
index db2c2cf..3dac178 100644
--- a/lfstack.c
+++ b/lfstack.c
@@ -40,12 +40,17 @@ void cds_lfs_init(struct cds_lfs_stack *s)
 	_cds_lfs_init(s);
 }
 
-bool cds_lfs_empty(struct cds_lfs_stack *s)
+void __cds_lfs_init(struct __cds_lfs_stack *s)
+{
+	___cds_lfs_init(s);
+}
+
+bool cds_lfs_empty(cds_lfs_stack_ptr_t s)
 {
 	return _cds_lfs_empty(s);
 }
 
-bool cds_lfs_push(struct cds_lfs_stack *s, struct cds_lfs_node *node)
+bool cds_lfs_push(cds_lfs_stack_ptr_t s, struct cds_lfs_node *node)
 {
 	return _cds_lfs_push(s, node);
 }
@@ -70,12 +75,12 @@ void cds_lfs_pop_unlock(struct cds_lfs_stack *s)
 	_cds_lfs_pop_unlock(s);
 }
 
-struct cds_lfs_node *__cds_lfs_pop(struct cds_lfs_stack *s)
+struct cds_lfs_node *__cds_lfs_pop(cds_lfs_stack_ptr_t s)
 {
 	return ___cds_lfs_pop(s);
 }
 
-struct cds_lfs_head *__cds_lfs_pop_all(struct cds_lfs_stack *s)
+struct cds_lfs_head *__cds_lfs_pop_all(cds_lfs_stack_ptr_t s)
 {
 	return ___cds_lfs_pop_all(s);
 }
diff --git a/urcu/lfstack.h b/urcu/lfstack.h
index eddff0e..9f384d6 100644
--- a/urcu/lfstack.h
+++ b/urcu/lfstack.h
@@ -70,11 +70,25 @@ struct cds_lfs_head {
 	struct cds_lfs_node node;
 };
 
+struct __cds_lfs_stack {
+	struct cds_lfs_head *head;
+};
+
 struct cds_lfs_stack {
 	struct cds_lfs_head *head;
 	pthread_mutex_t lock;
 };
 
+/*
+ * The transparent union allows calling functions that work on both
+ * struct cds_lfs_stack and struct __cds_lfs_stack on any of those two
+ * types.
+ */
+typedef union __attribute__((__transparent_union__)) {
+	struct __cds_lfs_stack *_s;
+	struct cds_lfs_stack *s;
+} cds_lfs_stack_ptr_t;
+
 #ifdef _LGPL_SOURCE
 
 #include <urcu/static/lfstack.h>
@@ -109,11 +123,16 @@ extern void cds_lfs_node_init(struct cds_lfs_node *node);
 extern void cds_lfs_init(struct cds_lfs_stack *s);
 
 /*
+ * __cds_lfs_init: initialize lock-free stack.
+ */
+extern void __cds_lfs_init(struct __cds_lfs_stack *s);
+
+/*
  * cds_lfs_empty: return whether lock-free stack is empty.
  *
  * No memory barrier is issued. No mutual exclusion is required.
  */
-extern bool cds_lfs_empty(struct cds_lfs_stack *s);
+extern bool cds_lfs_empty(cds_lfs_stack_ptr_t s);
 
 /*
  * cds_lfs_push: push a node into the stack.
@@ -123,7 +142,7 @@ extern bool cds_lfs_empty(struct cds_lfs_stack *s);
  * Returns 0 if the stack was empty prior to adding the node.
  * Returns non-zero otherwise.
  */
-extern bool cds_lfs_push(struct cds_lfs_stack *s,
+extern bool cds_lfs_push(cds_lfs_stack_ptr_t s,
 			struct cds_lfs_node *node);
 
 /*
@@ -166,7 +185,7 @@ extern void cds_lfs_pop_unlock(struct cds_lfs_stack *s);
  * 3) Ensuring that only ONE thread can call __cds_lfs_pop() and
  *    __cds_lfs_pop_all(). (multi-provider/single-consumer scheme).
  */
-extern struct cds_lfs_node *__cds_lfs_pop(struct cds_lfs_stack *s);
+extern struct cds_lfs_node *__cds_lfs_pop(cds_lfs_stack_ptr_t s);
 
 /*
  * __cds_lfs_pop_all: pop all nodes from a stack.
@@ -185,7 +204,7 @@ extern struct cds_lfs_node *__cds_lfs_pop(struct cds_lfs_stack *s);
  * 3) Ensuring that only ONE thread can call __cds_lfs_pop() and
  *    __cds_lfs_pop_all(). (multi-provider/single-consumer scheme).
  */
-extern struct cds_lfs_head *__cds_lfs_pop_all(struct cds_lfs_stack *s);
+extern struct cds_lfs_head *__cds_lfs_pop_all(cds_lfs_stack_ptr_t s);
 
 #endif /* !_LGPL_SOURCE */
 
diff --git a/urcu/static/lfstack.h b/urcu/static/lfstack.h
index 0be9594..63af91a 100644
--- a/urcu/static/lfstack.h
+++ b/urcu/static/lfstack.h
@@ -78,6 +78,15 @@ void _cds_lfs_init(struct cds_lfs_stack *s)
 	assert(!ret);
 }
 
+/*
+ * ___cds_lfs_init: initialize lock-free stack.
+ */
+static inline
+void ___cds_lfs_init(struct __cds_lfs_stack *s)
+{
+	s->head = NULL;
+}
+
 static inline
 bool ___cds_lfs_empty_head(struct cds_lfs_head *head)
 {
@@ -90,9 +99,9 @@ bool ___cds_lfs_empty_head(struct cds_lfs_head *head)
  * No memory barrier is issued. No mutual exclusion is required.
  */
 static inline
-bool _cds_lfs_empty(struct cds_lfs_stack *s)
+bool _cds_lfs_empty(cds_lfs_stack_ptr_t s)
 {
-	return ___cds_lfs_empty_head(CMM_LOAD_SHARED(s->head));
+	return ___cds_lfs_empty_head(CMM_LOAD_SHARED(s._s->head));
 }
 
 /*
@@ -125,9 +134,10 @@ bool _cds_lfs_empty(struct cds_lfs_stack *s)
  * Returns non-zero otherwise.
  */
 static inline
-bool _cds_lfs_push(struct cds_lfs_stack *s,
+bool _cds_lfs_push(cds_lfs_stack_ptr_t u_s,
 		  struct cds_lfs_node *node)
 {
+	struct __cds_lfs_stack *s = u_s._s;
 	struct cds_lfs_head *head = NULL;
 	struct cds_lfs_head *new_head =
 		caa_container_of(node, struct cds_lfs_head, node);
@@ -168,8 +178,10 @@ bool _cds_lfs_push(struct cds_lfs_stack *s,
  *    __cds_lfs_pop_all(). (multi-provider/single-consumer scheme).
  */
 static inline
-struct cds_lfs_node *___cds_lfs_pop(struct cds_lfs_stack *s)
+struct cds_lfs_node *___cds_lfs_pop(cds_lfs_stack_ptr_t u_s)
 {
+	struct __cds_lfs_stack *s = u_s._s;
+
 	for (;;) {
 		struct cds_lfs_head *head, *next_head;
 		struct cds_lfs_node *next;
@@ -211,8 +223,10 @@ struct cds_lfs_node *___cds_lfs_pop(struct cds_lfs_stack *s)
  *    __cds_lfs_pop_all(). (multi-provider/single-consumer scheme).
  */
 static inline
-struct cds_lfs_head *___cds_lfs_pop_all(struct cds_lfs_stack *s)
+struct cds_lfs_head *___cds_lfs_pop_all(cds_lfs_stack_ptr_t u_s)
 {
+	struct __cds_lfs_stack *s = u_s._s;
+
 	/*
 	 * Implicit memory barrier after uatomic_xchg() matches implicit
 	 * memory barrier before uatomic_cmpxchg() in cds_lfs_push. It
-- 
2.0.1
