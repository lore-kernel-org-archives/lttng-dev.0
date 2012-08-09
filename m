From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [PATCH 1/2] urcu: move exsit code and name it
	___cds_wfq_node_sync_next()
Date: Thu, 9 Aug 2012 16:46:25 +0800
Message-ID: <1344501986-23151-1-git-send-email-laijs__7033.46075392819$1344502153$gmane$org@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1SzOOE-0008Ih-QY
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 04:46:47 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>
List-Id: lttng-dev@lists.lttng.org

This code which waits for a node's next pointer until it appears, will be used
many times, move it to a help function and name it ___cds_wfq_node_sync_next().

Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
---
 urcu/static/wfqueue.h |   36 +++++++++++++++++++++++++-----------
 1 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/urcu/static/wfqueue.h b/urcu/static/wfqueue.h
index 19314f5..636e1af 100644
--- a/urcu/static/wfqueue.h
+++ b/urcu/static/wfqueue.h
@@ -85,6 +85,29 @@ static inline void _cds_wfq_enqueue(struct cds_wfq_queue *q,
 }
 
 /*
+ * Waiting for enqueuer to complete enqueue and return the next node
+ */
+static inline struct cds_wfq_node *
+___cds_wfq_node_sync_next(struct cds_wfq_node *node)
+{
+	struct cds_wfq_node *next;
+	int attempt = 0;
+
+	/*
+	 * Adaptative busy-looping waiting for enqueuer to complete enqueue.
+	 */
+	while ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
+		if (++attempt >= WFQ_ADAPT_ATTEMPTS) {
+			poll(NULL, 0, WFQ_WAIT);	/* Wait for 10ms */
+			attempt = 0;
+		} else
+			caa_cpu_relax();
+	}
+
+	return next;
+}
+
+/*
  * It is valid to reuse and free a dequeued node immediately.
  *
  * No need to go on a waitqueue here, as there is no possible state in which the
@@ -96,7 +119,6 @@ static inline struct cds_wfq_node *
 ___cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
 {
 	struct cds_wfq_node *node, *next;
-	int attempt = 0;
 
 	/*
 	 * Queue is empty if it only contains the dummy node.
@@ -105,16 +127,8 @@ ___cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
 		return NULL;
 	node = q->head;
 
-	/*
-	 * Adaptative busy-looping waiting for enqueuer to complete enqueue.
-	 */
-	while ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
-		if (++attempt >= WFQ_ADAPT_ATTEMPTS) {
-			poll(NULL, 0, WFQ_WAIT);	/* Wait for 10ms */
-			attempt = 0;
-		} else
-			caa_cpu_relax();
-	}
+	next = ___cds_wfq_node_sync_next(node);
+
 	/*
 	 * Move queue head forward.
 	 */
-- 
1.7.7
