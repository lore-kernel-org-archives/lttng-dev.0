From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH urcu] wfcqueue: Implement mutex-free
	wfcqueue head with transparent union
Date: Thu, 31 Jul 2014 21:07:23 -0400
Message-ID: <1406855243-17124-1-git-send-email-mathieu.desnoyers__23285.4866110303$1406855322$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XD1Jt-0007rz-4Y
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 21:07:46 -0400
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

CC: "Eric Wong" <normalperson@yhbt.net>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: "Lai Jiangshan" <laijs@cn.fujitsu.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 urcu/static/wfcqueue.h | 57 ++++++++++++++++++++++++++++++++------------------
 urcu/wfcqueue.h        | 52 +++++++++++++++++++++++++++++++--------------
 wfcqueue.c             | 34 +++++++++++++++++-------------
 3 files changed, 93 insertions(+), 50 deletions(-)

diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
index 62e003f..48b2625 100644
--- a/urcu/static/wfcqueue.h
+++ b/urcu/static/wfcqueue.h
@@ -107,6 +107,17 @@ static inline void _cds_wfcq_init(struct cds_wfcq_head *head,
 }
 
 /*
+ * __cds_wfcq_init: initialize wait-free queue.
+ */
+static inline void ___cds_wfcq_init(struct __cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail)
+{
+	/* Set queue head and tail */
+	_cds_wfcq_node_init(&head->node);
+	tail->p = &head->node;
+}
+
+/*
  * cds_wfcq_empty: return whether wait-free queue is empty.
  *
  * No memory barrier is issued. No mutual exclusion is required.
@@ -118,9 +129,10 @@ static inline void _cds_wfcq_init(struct cds_wfcq_head *head,
  * make a queue appear empty if an enqueuer is preempted for a long time
  * between xchg() and setting the previous node's next pointer.
  */
-static inline bool _cds_wfcq_empty(struct cds_wfcq_head *head,
+static inline bool _cds_wfcq_empty(cds_wfcq_head_ptr_t u_head,
 		struct cds_wfcq_tail *tail)
 {
+	struct __cds_wfcq_head *head = u_head._h;
 	/*
 	 * Queue is empty if no node is pointed by head->node.next nor
 	 * tail->p. Even though the tail->p check is sufficient to find
@@ -150,11 +162,12 @@ static inline void _cds_wfcq_dequeue_unlock(struct cds_wfcq_head *head,
 	assert(!ret);
 }
 
-static inline bool ___cds_wfcq_append(struct cds_wfcq_head *head,
+static inline bool ___cds_wfcq_append(cds_wfcq_head_ptr_t u_head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *new_head,
 		struct cds_wfcq_node *new_tail)
 {
+	struct __cds_wfcq_head *head = u_head._h;
 	struct cds_wfcq_node *old_tail;
 
 	/*
@@ -190,7 +203,7 @@ static inline bool ___cds_wfcq_append(struct cds_wfcq_head *head,
  * Returns false if the queue was empty prior to adding the node.
  * Returns true otherwise.
  */
-static inline bool _cds_wfcq_enqueue(struct cds_wfcq_head *head,
+static inline bool _cds_wfcq_enqueue(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *new_tail)
 {
@@ -237,10 +250,11 @@ ___cds_wfcq_node_sync_next(struct cds_wfcq_node *node, int blocking)
 }
 
 static inline struct cds_wfcq_node *
-___cds_wfcq_first(struct cds_wfcq_head *head,
+___cds_wfcq_first(cds_wfcq_head_ptr_t u_head,
 		struct cds_wfcq_tail *tail,
 		int blocking)
 {
+	struct __cds_wfcq_head *head = u_head._h;
 	struct cds_wfcq_node *node;
 
 	if (_cds_wfcq_empty(head, tail))
@@ -266,7 +280,7 @@ ___cds_wfcq_first(struct cds_wfcq_head *head,
  * Returns NULL if queue is empty, first node otherwise.
  */
 static inline struct cds_wfcq_node *
-___cds_wfcq_first_blocking(struct cds_wfcq_head *head,
+___cds_wfcq_first_blocking(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail)
 {
 	return ___cds_wfcq_first(head, tail, 1);
@@ -280,14 +294,14 @@ ___cds_wfcq_first_blocking(struct cds_wfcq_head *head,
  * it needs to block.
  */
 static inline struct cds_wfcq_node *
-___cds_wfcq_first_nonblocking(struct cds_wfcq_head *head,
+___cds_wfcq_first_nonblocking(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail)
 {
 	return ___cds_wfcq_first(head, tail, 0);
 }
 
 static inline struct cds_wfcq_node *
-___cds_wfcq_next(struct cds_wfcq_head *head,
+___cds_wfcq_next(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *node,
 		int blocking)
@@ -328,7 +342,7 @@ ___cds_wfcq_next(struct cds_wfcq_head *head,
  * otherwise.
  */
 static inline struct cds_wfcq_node *
-___cds_wfcq_next_blocking(struct cds_wfcq_head *head,
+___cds_wfcq_next_blocking(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *node)
 {
@@ -342,7 +356,7 @@ ___cds_wfcq_next_blocking(struct cds_wfcq_head *head,
  * it needs to block.
  */
 static inline struct cds_wfcq_node *
-___cds_wfcq_next_nonblocking(struct cds_wfcq_head *head,
+___cds_wfcq_next_nonblocking(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *node)
 {
@@ -350,11 +364,12 @@ ___cds_wfcq_next_nonblocking(struct cds_wfcq_head *head,
 }
 
 static inline struct cds_wfcq_node *
-___cds_wfcq_dequeue_with_state(struct cds_wfcq_head *head,
+___cds_wfcq_dequeue_with_state(cds_wfcq_head_ptr_t u_head,
 		struct cds_wfcq_tail *tail,
 		int *state,
 		int blocking)
 {
+	struct __cds_wfcq_head *head = u_head._h;
 	struct cds_wfcq_node *node, *next;
 
 	if (state)
@@ -422,7 +437,7 @@ ___cds_wfcq_dequeue_with_state(struct cds_wfcq_head *head,
  * caller.
  */
 static inline struct cds_wfcq_node *
-___cds_wfcq_dequeue_with_state_blocking(struct cds_wfcq_head *head,
+___cds_wfcq_dequeue_with_state_blocking(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail, int *state)
 {
 	return ___cds_wfcq_dequeue_with_state(head, tail, state, 1);
@@ -435,7 +450,7 @@ ___cds_wfcq_dequeue_with_state_blocking(struct cds_wfcq_head *head,
  * state.
  */
 static inline struct cds_wfcq_node *
-___cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
+___cds_wfcq_dequeue_blocking(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail)
 {
 	return ___cds_wfcq_dequeue_with_state_blocking(head, tail, NULL);
@@ -448,7 +463,7 @@ ___cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
  * if it needs to block.
  */
 static inline struct cds_wfcq_node *
-___cds_wfcq_dequeue_with_state_nonblocking(struct cds_wfcq_head *head,
+___cds_wfcq_dequeue_with_state_nonblocking(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail, int *state)
 {
 	return ___cds_wfcq_dequeue_with_state(head, tail, state, 0);
@@ -461,7 +476,7 @@ ___cds_wfcq_dequeue_with_state_nonblocking(struct cds_wfcq_head *head,
  * state.
  */
 static inline struct cds_wfcq_node *
-___cds_wfcq_dequeue_nonblocking(struct cds_wfcq_head *head,
+___cds_wfcq_dequeue_nonblocking(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail)
 {
 	return ___cds_wfcq_dequeue_with_state_nonblocking(head, tail, NULL);
@@ -479,12 +494,14 @@ ___cds_wfcq_dequeue_nonblocking(struct cds_wfcq_head *head,
  */
 static inline enum cds_wfcq_ret
 ___cds_wfcq_splice(
-		struct cds_wfcq_head *dest_q_head,
+		cds_wfcq_head_ptr_t u_dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
-		struct cds_wfcq_head *src_q_head,
+		cds_wfcq_head_ptr_t u_src_q_head,
 		struct cds_wfcq_tail *src_q_tail,
 		int blocking)
 {
+	struct __cds_wfcq_head *dest_q_head = u_dest_q_head._h;
+	struct __cds_wfcq_head *src_q_head = u_src_q_head._h;
 	struct cds_wfcq_node *head, *tail;
 	int attempt = 0;
 
@@ -540,9 +557,9 @@ ___cds_wfcq_splice(
  */
 static inline enum cds_wfcq_ret
 ___cds_wfcq_splice_blocking(
-		struct cds_wfcq_head *dest_q_head,
+		cds_wfcq_head_ptr_t dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
-		struct cds_wfcq_head *src_q_head,
+		cds_wfcq_head_ptr_t src_q_head,
 		struct cds_wfcq_tail *src_q_tail)
 {
 	return ___cds_wfcq_splice(dest_q_head, dest_q_tail,
@@ -557,9 +574,9 @@ ___cds_wfcq_splice_blocking(
  */
 static inline enum cds_wfcq_ret
 ___cds_wfcq_splice_nonblocking(
-		struct cds_wfcq_head *dest_q_head,
+		cds_wfcq_head_ptr_t dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
-		struct cds_wfcq_head *src_q_head,
+		cds_wfcq_head_ptr_t src_q_head,
 		struct cds_wfcq_tail *src_q_tail)
 {
 	return ___cds_wfcq_splice(dest_q_head, dest_q_tail,
diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
index 4e83660..df26e33 100644
--- a/urcu/wfcqueue.h
+++ b/urcu/wfcqueue.h
@@ -65,11 +65,25 @@ struct cds_wfcq_node {
  * enqueue/dequeue are expected from many CPUs. This eliminates
  * false-sharing between enqueue and dequeue.
  */
+struct __cds_wfcq_head {
+	struct cds_wfcq_node node;
+};
+
 struct cds_wfcq_head {
 	struct cds_wfcq_node node;
 	pthread_mutex_t lock;
 };
 
+/*
+ * The transparent union allows calling functions that work on both
+ * struct cds_wfcq_head and struct __cds_wfcq_head on any of those two
+ * types.
+ */
+typedef union __attribute__((__transparent_union__)) {
+	struct __cds_wfcq_head *_h;
+	struct cds_wfcq_head *h;
+} cds_wfcq_head_ptr_t;
+
 struct cds_wfcq_tail {
 	struct cds_wfcq_node *p;
 };
@@ -164,11 +178,17 @@ extern void cds_wfcq_init(struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail);
 
 /*
+ * __cds_wfcq_init: initialize wait-free queue.
+ */
+extern void __cds_wfcq_init(struct __cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail);
+
+/*
  * cds_wfcq_empty: return whether wait-free queue is empty.
  *
  * No memory barrier is issued. No mutual exclusion is required.
  */
-extern bool cds_wfcq_empty(struct cds_wfcq_head *head,
+extern bool cds_wfcq_empty(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail);
 
 /*
@@ -192,7 +212,7 @@ extern void cds_wfcq_dequeue_unlock(struct cds_wfcq_head *head,
  * Returns false if the queue was empty prior to adding the node.
  * Returns true otherwise.
  */
-extern bool cds_wfcq_enqueue(struct cds_wfcq_head *head,
+extern bool cds_wfcq_enqueue(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *node);
 
@@ -249,7 +269,7 @@ extern enum cds_wfcq_ret cds_wfcq_splice_blocking(
  * caller.
  */
 extern struct cds_wfcq_node *__cds_wfcq_dequeue_blocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail);
 
 /*
@@ -259,7 +279,7 @@ extern struct cds_wfcq_node *__cds_wfcq_dequeue_blocking(
  * last node of the queue into state (CDS_WFCQ_STATE_LAST).
  */
 extern struct cds_wfcq_node *__cds_wfcq_dequeue_with_state_blocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		int *state);
 
@@ -270,7 +290,7 @@ extern struct cds_wfcq_node *__cds_wfcq_dequeue_with_state_blocking(
  * if it needs to block.
  */
 extern struct cds_wfcq_node *__cds_wfcq_dequeue_nonblocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail);
 
 /*
@@ -280,7 +300,7 @@ extern struct cds_wfcq_node *__cds_wfcq_dequeue_nonblocking(
  * the last node of the queue into state (CDS_WFCQ_STATE_LAST).
  */
 extern struct cds_wfcq_node *__cds_wfcq_dequeue_with_state_nonblocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		int *state);
 
@@ -295,9 +315,9 @@ extern struct cds_wfcq_node *__cds_wfcq_dequeue_with_state_nonblocking(
  * dest queue. Never returns CDS_WFCQ_RET_WOULDBLOCK.
  */
 extern enum cds_wfcq_ret __cds_wfcq_splice_blocking(
-		struct cds_wfcq_head *dest_q_head,
+		cds_wfcq_head_ptr_t dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
-		struct cds_wfcq_head *src_q_head,
+		cds_wfcq_head_ptr_t src_q_head,
 		struct cds_wfcq_tail *src_q_tail);
 
 /*
@@ -307,9 +327,9 @@ extern enum cds_wfcq_ret __cds_wfcq_splice_blocking(
  * CDS_WFCQ_RET_WOULDBLOCK if it needs to block.
  */
 extern enum cds_wfcq_ret __cds_wfcq_splice_nonblocking(
-		struct cds_wfcq_head *dest_q_head,
+		cds_wfcq_head_ptr_t dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
-		struct cds_wfcq_head *src_q_head,
+		cds_wfcq_head_ptr_t src_q_head,
 		struct cds_wfcq_tail *src_q_tail);
 
 /*
@@ -327,7 +347,7 @@ extern enum cds_wfcq_ret __cds_wfcq_splice_nonblocking(
  * Returns NULL if queue is empty, first node otherwise.
  */
 extern struct cds_wfcq_node *__cds_wfcq_first_blocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail);
 
 /*
@@ -337,7 +357,7 @@ extern struct cds_wfcq_node *__cds_wfcq_first_blocking(
  * it needs to block.
  */
 extern struct cds_wfcq_node *__cds_wfcq_first_nonblocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail);
 
 /*
@@ -356,7 +376,7 @@ extern struct cds_wfcq_node *__cds_wfcq_first_nonblocking(
  * otherwise.
  */
 extern struct cds_wfcq_node *__cds_wfcq_next_blocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *node);
 
@@ -367,7 +387,7 @@ extern struct cds_wfcq_node *__cds_wfcq_next_blocking(
  * it needs to block.
  */
 extern struct cds_wfcq_node *__cds_wfcq_next_nonblocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *node);
 
@@ -376,7 +396,7 @@ extern struct cds_wfcq_node *__cds_wfcq_next_nonblocking(
 /*
  * __cds_wfcq_for_each_blocking: Iterate over all nodes in a queue,
  * without dequeuing them.
- * @head: head of the queue (struct cds_wfcq_head pointer).
+ * @head: head of the queue (struct cds_wfcq_head or __cds_wfcq_head pointer).
  * @tail: tail of the queue (struct cds_wfcq_tail pointer).
  * @node: iterator on the queue (struct cds_wfcq_node pointer).
  *
@@ -393,7 +413,7 @@ extern struct cds_wfcq_node *__cds_wfcq_next_nonblocking(
 /*
  * __cds_wfcq_for_each_blocking_safe: Iterate over all nodes in a queue,
  * without dequeuing them. Safe against deletion.
- * @head: head of the queue (struct cds_wfcq_head pointer).
+ * @head: head of the queue (struct cds_wfcq_head or __cds_wfcq_head pointer).
  * @tail: tail of the queue (struct cds_wfcq_tail pointer).
  * @node: iterator on the queue (struct cds_wfcq_node pointer).
  * @n: struct cds_wfcq_node pointer holding the next pointer (used
diff --git a/wfcqueue.c b/wfcqueue.c
index 4950c10..e28d51a 100644
--- a/wfcqueue.c
+++ b/wfcqueue.c
@@ -40,14 +40,20 @@ void cds_wfcq_init(struct cds_wfcq_head *head,
 	_cds_wfcq_init(head, tail);
 }
 
-bool cds_wfcq_empty(struct cds_wfcq_head *head,
+void __cds_wfcq_init(struct __cds_wfcq_head *head,
+		struct cds_wfcq_tail *tail)
+{
+	___cds_wfcq_init(head, tail);
+}
+
+bool cds_wfcq_empty(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail)
 
 {
 	return _cds_wfcq_empty(head, tail);
 }
 
-bool cds_wfcq_enqueue(struct cds_wfcq_head *head,
+bool cds_wfcq_enqueue(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *node)
 {
@@ -92,14 +98,14 @@ enum cds_wfcq_ret cds_wfcq_splice_blocking(
 }
 
 struct cds_wfcq_node *__cds_wfcq_dequeue_blocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail)
 {
 	return ___cds_wfcq_dequeue_blocking(head, tail);
 }
 
 struct cds_wfcq_node *__cds_wfcq_dequeue_with_state_blocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		int *state)
 {
@@ -107,14 +113,14 @@ struct cds_wfcq_node *__cds_wfcq_dequeue_with_state_blocking(
 }
 
 struct cds_wfcq_node *__cds_wfcq_dequeue_nonblocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail)
 {
 	return ___cds_wfcq_dequeue_nonblocking(head, tail);
 }
 
 struct cds_wfcq_node *__cds_wfcq_dequeue_with_state_nonblocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		int *state)
 {
@@ -122,9 +128,9 @@ struct cds_wfcq_node *__cds_wfcq_dequeue_with_state_nonblocking(
 }
 
 enum cds_wfcq_ret __cds_wfcq_splice_blocking(
-		struct cds_wfcq_head *dest_q_head,
+		cds_wfcq_head_ptr_t dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
-		struct cds_wfcq_head *src_q_head,
+		cds_wfcq_head_ptr_t src_q_head,
 		struct cds_wfcq_tail *src_q_tail)
 {
 	return ___cds_wfcq_splice_blocking(dest_q_head, dest_q_tail,
@@ -132,9 +138,9 @@ enum cds_wfcq_ret __cds_wfcq_splice_blocking(
 }
 
 enum cds_wfcq_ret __cds_wfcq_splice_nonblocking(
-		struct cds_wfcq_head *dest_q_head,
+		cds_wfcq_head_ptr_t dest_q_head,
 		struct cds_wfcq_tail *dest_q_tail,
-		struct cds_wfcq_head *src_q_head,
+		cds_wfcq_head_ptr_t src_q_head,
 		struct cds_wfcq_tail *src_q_tail)
 {
 	return ___cds_wfcq_splice_nonblocking(dest_q_head, dest_q_tail,
@@ -142,21 +148,21 @@ enum cds_wfcq_ret __cds_wfcq_splice_nonblocking(
 }
 
 struct cds_wfcq_node *__cds_wfcq_first_blocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail)
 {
 	return ___cds_wfcq_first_blocking(head, tail);
 }
 
 struct cds_wfcq_node *__cds_wfcq_first_nonblocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail)
 {
 	return ___cds_wfcq_first_nonblocking(head, tail);
 }
 
 struct cds_wfcq_node *__cds_wfcq_next_blocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *node)
 {
@@ -164,7 +170,7 @@ struct cds_wfcq_node *__cds_wfcq_next_blocking(
 }
 
 struct cds_wfcq_node *__cds_wfcq_next_nonblocking(
-		struct cds_wfcq_head *head,
+		cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *node)
 {
-- 
2.0.1
