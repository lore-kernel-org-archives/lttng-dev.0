From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 05/16] wfcqueue: document empty criterion
Date: Tue, 20 Nov 2012 14:40:18 -0500
Message-ID: <1353440429-19223-6-git-send-email-mathieu.desnoyers__12651.5293879949$1353442758$gmane$org@efficios.com>
References: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1TathK-0001Lx-7h
	for lttng-dev@lists.lttng.org; Tue, 20 Nov 2012 14:41:30 -0500
In-Reply-To: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 urcu/static/wfcqueue.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
index 1200227..8774c03 100644
--- a/urcu/static/wfcqueue.h
+++ b/urcu/static/wfcqueue.h
@@ -95,6 +95,13 @@ static inline void _cds_wfcq_init(struct cds_wfcq_head *head,
  * cds_wfcq_empty: return whether wait-free queue is empty.
  *
  * No memory barrier is issued. No mutual exclusion is required.
+ *
+ * We perform the test on head->node.next to check if the queue is
+ * possibly empty, but we confirm this by checking if the tail pointer
+ * points to the head node because the tail pointer is the linearisation
+ * point of the enqueuers. Just checking the head next pointer could
+ * make a queue appear empty if an enqueuer is preempted for a long time
+ * between xchg() and setting the previous node's next pointer.
  */
 static inline bool _cds_wfcq_empty(struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail)
-- 
1.7.10.4
