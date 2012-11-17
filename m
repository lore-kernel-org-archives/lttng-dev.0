From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 4/8] urcu-qsbr: move offline threads to separate
	list
Date: Sat, 17 Nov 2012 11:16:43 -0500
Message-ID: <1353169007-31389-5-git-send-email-mathieu.desnoyers__26465.159309055$1353169114$gmane$org@efficios.com>
References: <1353169007-31389-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1TZl5b-0000st-AG
	for lttng-dev@lists.lttng.org; Sat, 17 Nov 2012 11:17:51 -0500
In-Reply-To: <1353169007-31389-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Accelerate 2-phase grace period by not having to iterate on offline
threads twice.

CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
CC: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 urcu-qsbr.c             |   54 ++++++++++++++++++++++++++++++++++++-----------
 urcu/static/urcu-qsbr.h |   14 ++++++++++--
 2 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/urcu-qsbr.c b/urcu-qsbr.c
index eb167d1..5b341b5 100644
--- a/urcu-qsbr.c
+++ b/urcu-qsbr.c
@@ -116,9 +116,10 @@ static void wait_gp(void)
 		      NULL, NULL, 0);
 }
 
-static void wait_for_readers(void)
+static void wait_for_readers(struct cds_list_head *input_readers,
+			struct cds_list_head *cur_snap_readers,
+			struct cds_list_head *qsreaders)
 {
-	CDS_LIST_HEAD(qsreaders);
 	int wait_loops = 0;
 	struct rcu_reader *index, *tmp;
 
@@ -136,18 +137,36 @@ static void wait_for_readers(void)
 			 * reads them in the opposite order).
 			 */
 			cmm_smp_wmb();
-			cds_list_for_each_entry(index, &registry, node) {
+			cds_list_for_each_entry(index, input_readers, node) {
 				_CMM_STORE_SHARED(index->waiting, 1);
 			}
 			/* Write futex before read reader_gp */
 			cmm_smp_mb();
 		}
-		cds_list_for_each_entry_safe(index, tmp, &registry, node) {
-			if (!rcu_gp_ongoing(&index->ctr))
-				cds_list_move(&index->node, &qsreaders);
+		cds_list_for_each_entry_safe(index, tmp, input_readers, node) {
+			switch (rcu_reader_state(&index->ctr)) {
+			case RCU_READER_ACTIVE_CURRENT:
+				if (cur_snap_readers) {
+					cds_list_move(&index->node,
+						cur_snap_readers);
+					break;
+				}
+				/* Fall-through */
+			case RCU_READER_INACTIVE:
+				cds_list_move(&index->node, qsreaders);
+				break;
+			case RCU_READER_ACTIVE_OLD:
+				/*
+				 * Old snapshot. Leaving node in
+				 * input_readers will make us busy-loop
+				 * until the snapshot becomes current or
+				 * the reader becomes inactive.
+				 */
+				break;
+			}
 		}
 
-		if (cds_list_empty(&registry)) {
+		if (cds_list_empty(input_readers)) {
 			if (wait_loops >= RCU_QS_ACTIVE_ATTEMPTS) {
 				/* Read reader_gp before write futex */
 				cmm_smp_mb();
@@ -166,8 +185,6 @@ static void wait_for_readers(void)
 			}
 		}
 	}
-	/* put back the reader list in the registry */
-	cds_list_splice(&qsreaders, &registry);
 }
 
 /*
@@ -178,6 +195,8 @@ static void wait_for_readers(void)
 #if (CAA_BITS_PER_LONG < 64)
 void synchronize_rcu(void)
 {
+	CDS_LIST_HEAD(cur_snap_readers);
+	CDS_LIST_HEAD(qsreaders);
 	unsigned long was_online;
 
 	was_online = URCU_TLS(rcu_reader).ctr;
@@ -203,7 +222,7 @@ void synchronize_rcu(void)
 	/*
 	 * Wait for readers to observe original parity or be quiescent.
 	 */
-	wait_for_readers();
+	wait_for_readers(&registry, &cur_snap_readers, &qsreaders);
 
 	/*
 	 * Must finish waiting for quiescent state for original parity
@@ -244,7 +263,12 @@ void synchronize_rcu(void)
 	/*
 	 * Wait for readers to observe new parity or be quiescent.
 	 */
-	wait_for_readers();
+	wait_for_readers(&cur_snap_readers, NULL, &qsreaders);
+
+	/*
+	 * Put quiescent reader list back into registry.
+	 */
+	cds_list_splice(&qsreaders, &registry);
 out:
 	mutex_unlock(&rcu_gp_lock);
 
@@ -260,6 +284,7 @@ out:
 #else /* !(CAA_BITS_PER_LONG < 64) */
 void synchronize_rcu(void)
 {
+	CDS_LIST_HEAD(qsreaders);
 	unsigned long was_online;
 
 	was_online = URCU_TLS(rcu_reader).ctr;
@@ -300,7 +325,12 @@ void synchronize_rcu(void)
 	/*
 	 * Wait for readers to observe new count of be quiescent.
 	 */
-	wait_for_readers();
+	wait_for_readers(&registry, NULL, &qsreaders);
+
+	/*
+	 * Put quiescent reader list back into registry.
+	 */
+	cds_list_splice(&qsreaders, &registry);
 out:
 	mutex_unlock(&rcu_gp_lock);
 
diff --git a/urcu/static/urcu-qsbr.h b/urcu/static/urcu-qsbr.h
index f314956..f6e5580 100644
--- a/urcu/static/urcu-qsbr.h
+++ b/urcu/static/urcu-qsbr.h
@@ -62,6 +62,12 @@ extern "C" {
 #define rcu_assert(args...)
 #endif
 
+enum rcu_state {
+	RCU_READER_ACTIVE_CURRENT,
+	RCU_READER_ACTIVE_OLD,
+	RCU_READER_INACTIVE,
+};
+
 #ifdef DEBUG_YIELD
 #include <sched.h>
 #include <time.h>
@@ -149,12 +155,16 @@ static inline void wake_up_gp(void)
 	}
 }
 
-static inline int rcu_gp_ongoing(unsigned long *ctr)
+static inline enum rcu_state rcu_reader_state(unsigned long *ctr)
 {
 	unsigned long v;
 
 	v = CMM_LOAD_SHARED(*ctr);
-	return v && (v != rcu_gp_ctr);
+	if (!v)
+		return RCU_READER_INACTIVE;
+	if (v == rcu_gp_ctr)
+		return RCU_READER_ACTIVE_CURRENT;
+	return RCU_READER_ACTIVE_OLD;
 }
 
 /*
-- 
1.7.10.4
