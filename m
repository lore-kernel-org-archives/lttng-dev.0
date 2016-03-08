From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH urcu 2/2] wfcqueue: add C++ compatibility API
Date: Mon,  7 Mar 2016 19:33:44 -0500
Message-ID: <1457397224-10952-2-git-send-email-mathieu.desnoyers__15093.1630553261$1457397402$gmane$org@efficios.com>
References: <1457397224-10952-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ad5b7-0002tL-C0
 for lttng-dev@lists.lttng.org; Mon, 07 Mar 2016 19:34:04 -0500
In-Reply-To: <1457397224-10952-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <jiangshanlai@gmail.com>, rp@svcs.cs.pdx.edu
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Introduce __cds_wfcq_head_cast and cds_wfcq_head_cast for compability
of wfcqueue with c++. Those are effect-less in C, where transparent
unions are supported. However, in C++, those transform struct
cds_wfcq_head and struct __cds_wfcq_head pointers to
cds_wfcq_head_ptr_t.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 urcu/static/wfcqueue.h | 16 +++++++++-------
 urcu/wfcqueue.h        | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
index 7c9d548..4ababbf 100644
--- a/urcu/static/wfcqueue.h
+++ b/urcu/static/wfcqueue.h
@@ -257,7 +257,7 @@ ___cds_wfcq_first(cds_wfcq_head_ptr_t u_head,
 	struct __cds_wfcq_head *head = u_head._h;
 	struct cds_wfcq_node *node;
 
-	if (_cds_wfcq_empty(head, tail))
+	if (_cds_wfcq_empty(__cds_wfcq_head_cast(head), tail))
 		return NULL;
 	node = ___cds_wfcq_node_sync_next(&head->node, blocking);
 	/* Load head->node.next before loading node's content */
@@ -375,7 +375,7 @@ ___cds_wfcq_dequeue_with_state(cds_wfcq_head_ptr_t u_head,
 	if (state)
 		*state = 0;
 
-	if (_cds_wfcq_empty(head, tail)) {
+	if (_cds_wfcq_empty(__cds_wfcq_head_cast(head), tail)) {
 		return NULL;
 	}
 
@@ -509,7 +509,7 @@ ___cds_wfcq_splice(
 	 * Initial emptiness check to speed up cases where queue is
 	 * empty: only require loads to check if queue is empty.
 	 */
-	if (_cds_wfcq_empty(src_q_head, src_q_tail))
+	if (_cds_wfcq_empty(__cds_wfcq_head_cast(src_q_head), src_q_tail))
 		return CDS_WFCQ_RET_SRC_EMPTY;
 
 	for (;;) {
@@ -539,7 +539,8 @@ ___cds_wfcq_splice(
 	 * Append the spliced content of src_q into dest_q. Does not
 	 * require mutual exclusion on dest_q (wait-free).
 	 */
-	if (___cds_wfcq_append(dest_q_head, dest_q_tail, head, tail))
+	if (___cds_wfcq_append(__cds_wfcq_head_cast(dest_q_head), dest_q_tail,
+			head, tail))
 		return CDS_WFCQ_RET_DEST_NON_EMPTY;
 	else
 		return CDS_WFCQ_RET_DEST_EMPTY;
@@ -599,7 +600,8 @@ _cds_wfcq_dequeue_with_state_blocking(struct cds_wfcq_head *head,
 	struct cds_wfcq_node *retval;
 
 	_cds_wfcq_dequeue_lock(head, tail);
-	retval = ___cds_wfcq_dequeue_with_state_blocking(head, tail, state);
+	retval = ___cds_wfcq_dequeue_with_state_blocking(cds_wfcq_head_cast(head),
+			tail, state);
 	_cds_wfcq_dequeue_unlock(head, tail);
 	return retval;
 }
@@ -638,8 +640,8 @@ _cds_wfcq_splice_blocking(
 	enum cds_wfcq_ret ret;
 
 	_cds_wfcq_dequeue_lock(src_q_head, src_q_tail);
-	ret = ___cds_wfcq_splice_blocking(dest_q_head, dest_q_tail,
-			src_q_head, src_q_tail);
+	ret = ___cds_wfcq_splice_blocking(cds_wfcq_head_cast(dest_q_head), dest_q_tail,
+			cds_wfcq_head_cast(src_q_head), src_q_tail);
 	_cds_wfcq_dequeue_unlock(src_q_head, src_q_tail);
 	return ret;
 }
diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
index c0bb289..ec86032 100644
--- a/urcu/wfcqueue.h
+++ b/urcu/wfcqueue.h
@@ -74,6 +74,7 @@ struct cds_wfcq_head {
 	pthread_mutex_t lock;
 };
 
+#ifndef __cplusplus
 /*
  * The transparent union allows calling functions that work on both
  * struct cds_wfcq_head and struct __cds_wfcq_head on any of those two
@@ -84,6 +85,45 @@ typedef union {
 	struct cds_wfcq_head *h;
 } __attribute__((__transparent_union__)) cds_wfcq_head_ptr_t;
 
+/*
+ * This static inline is only present for compatibility with C++. It is
+ * effect-less in C.
+ */
+static inline struct __cds_wfcq_head *__cds_wfcq_head_cast(struct __cds_wfcq_head *head)
+{
+	return head;
+}
+
+/*
+ * This static inline is only present for compatibility with C++. It is
+ * effect-less in C.
+ */
+static inline struct cds_wfcq_head *cds_wfcq_head_cast(struct cds_wfcq_head *head)
+{
+	return head;
+}
+#else /* #ifndef __cplusplus */
+
+/* C++ ignores transparent union. */
+typedef union {
+	struct __cds_wfcq_head *_h;
+	struct cds_wfcq_head *h;
+} cds_wfcq_head_ptr_t;
+
+/* C++ ignores transparent union. Requires an explicit conversion. */
+static inline cds_wfcq_head_ptr_t __cds_wfcq_head_cast(struct __cds_wfcq_head *head)
+{
+	cds_wfcq_head_ptr_t ret = { ._h = head };
+	return ret;
+}
+/* C++ ignores transparent union. Requires an explicit conversion. */
+static inline cds_wfcq_head_ptr_t cds_wfcq_head_cast(struct cds_wfcq_head *head)
+{
+	cds_wfcq_head_ptr_t ret = { .h = head };
+	return ret;
+}
+#endif /* #else #ifndef __cplusplus */
+
 struct cds_wfcq_tail {
 	struct cds_wfcq_node *p;
 };
-- 
2.1.4
