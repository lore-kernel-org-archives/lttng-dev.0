From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 04/16] urcu-call-rcu: use wait-free splice
	return value
Date: Tue, 20 Nov 2012 14:40:17 -0500
Message-ID: <1353440429-19223-5-git-send-email-mathieu.desnoyers__5178.74790025434$1353440542$gmane$org@efficios.com>
References: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1TathI-0001LM-FC
	for lttng-dev@lists.lttng.org; Tue, 20 Nov 2012 14:41:28 -0500
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

We can now use the splice return value to know if the source queue was
empty rather than testing for destination queue emptiness after the
splice operation.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 urcu-call-rcu-impl.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
index 5dfdb92..6580397 100644
--- a/urcu-call-rcu-impl.h
+++ b/urcu-call-rcu-impl.h
@@ -252,11 +252,14 @@ static void *call_rcu_thread(void *arg)
 		struct cds_wfcq_head cbs_tmp_head;
 		struct cds_wfcq_tail cbs_tmp_tail;
 		struct cds_wfcq_node *cbs, *cbs_tmp_n;
+		enum cds_wfcq_ret splice_ret;
 
 		cds_wfcq_init(&cbs_tmp_head, &cbs_tmp_tail);
-		__cds_wfcq_splice_blocking(&cbs_tmp_head, &cbs_tmp_tail,
-			&crdp->cbs_head, &crdp->cbs_tail);
-		if (!cds_wfcq_empty(&cbs_tmp_head, &cbs_tmp_tail)) {
+		splice_ret = __cds_wfcq_splice_blocking(&cbs_tmp_head,
+			&cbs_tmp_tail, &crdp->cbs_head, &crdp->cbs_tail);
+		assert(splice_ret != CDS_WFCQ_RET_WOULDBLOCK);
+		assert(splice_ret != CDS_WFCQ_RET_DEST_NON_EMPTY);
+		if (splice_ret != CDS_WFCQ_RET_SRC_EMPTY) {
 			synchronize_rcu();
 			cbcount = 0;
 			__cds_wfcq_for_each_blocking_safe(&cbs_tmp_head,
-- 
1.7.10.4
