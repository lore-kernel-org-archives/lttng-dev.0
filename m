From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 5/8] urcu-mb/signal/membarrier: move quiescent
	threads to separate list
Date: Sat, 17 Nov 2012 11:16:44 -0500
Message-ID: <1353169007-31389-6-git-send-email-mathieu.desnoyers__11371.6671978638$1353169116$gmane$org@efficios.com>
References: <1353169007-31389-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1TZl5c-0000tE-Od
	for lttng-dev@lists.lttng.org; Sat, 17 Nov 2012 11:17:52 -0500
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

Accelerate 2-phase grace period by not having to iterate twice on
threads not nested within a RCU read-side lock.

CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
CC: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 urcu.c             |   47 ++++++++++++++++++++++++++++++++++++-----------
 urcu/static/urcu.h |   15 ++++++++++++---
 2 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/urcu.c b/urcu.c
index 2d5c510..c692db9 100644
--- a/urcu.c
+++ b/urcu.c
@@ -215,9 +215,10 @@ static void wait_gp(void)
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
 
@@ -234,13 +235,31 @@ static void wait_for_readers(void)
 			smp_mb_master(RCU_MB_GROUP);
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
 
 #ifndef HAS_INCOHERENT_CACHES
-		if (cds_list_empty(&registry)) {
+		if (cds_list_empty(input_readers)) {
 			if (wait_loops == RCU_QS_ACTIVE_ATTEMPTS) {
 				/* Read reader_gp before write futex */
 				smp_mb_master(RCU_MB_GROUP);
@@ -259,7 +278,7 @@ static void wait_for_readers(void)
 		 * URCU_TLS(rcu_reader).ctr update to memory if we wait
 		 * for too long.
 		 */
-		if (cds_list_empty(&registry)) {
+		if (cds_list_empty(input_readers)) {
 			if (wait_loops == RCU_QS_ACTIVE_ATTEMPTS) {
 				/* Read reader_gp before write futex */
 				smp_mb_master(RCU_MB_GROUP);
@@ -281,12 +300,13 @@ static void wait_for_readers(void)
 		}
 #endif /* #else #ifndef HAS_INCOHERENT_CACHES */
 	}
-	/* put back the reader list in the registry */
-	cds_list_splice(&qsreaders, &registry);
 }
 
 void synchronize_rcu(void)
 {
+	CDS_LIST_HEAD(cur_snap_readers);
+	CDS_LIST_HEAD(qsreaders);
+
 	mutex_lock(&rcu_gp_lock);
 
 	if (cds_list_empty(&registry))
@@ -301,7 +321,7 @@ void synchronize_rcu(void)
 	/*
 	 * Wait for readers to observe original parity or be quiescent.
 	 */
-	wait_for_readers();
+	wait_for_readers(&registry, &cur_snap_readers, &qsreaders);
 
 	/*
 	 * Must finish waiting for quiescent state for original parity before
@@ -341,7 +361,12 @@ void synchronize_rcu(void)
 	/*
 	 * Wait for readers to observe new parity or be quiescent.
 	 */
-	wait_for_readers();
+	wait_for_readers(&registry, NULL, &qsreaders);
+
+	/*
+	 * Put quiescent reader list back into registry.
+	 */
+	cds_list_splice(&qsreaders, &registry);
 
 	/* Finish waiting for reader threads before letting the old ptr being
 	 * freed. Must be done within rcu_gp_lock because it iterates on reader
diff --git a/urcu/static/urcu.h b/urcu/static/urcu.h
index f32f300..973826a 100644
--- a/urcu/static/urcu.h
+++ b/urcu/static/urcu.h
@@ -96,6 +96,12 @@ extern "C" {
 #define SIGRCU SIGUSR1
 #endif
 
+enum rcu_state {
+	RCU_READER_ACTIVE_CURRENT,
+	RCU_READER_ACTIVE_OLD,
+	RCU_READER_INACTIVE,
+};
+
 #ifdef DEBUG_RCU
 #define rcu_assert(args...)	assert(args)
 #else
@@ -239,7 +245,7 @@ static inline void wake_up_gp(void)
 	}
 }
 
-static inline int rcu_gp_ongoing(unsigned long *ctr)
+static inline enum rcu_state rcu_reader_state(unsigned long *ctr)
 {
 	unsigned long v;
 
@@ -248,8 +254,11 @@ static inline int rcu_gp_ongoing(unsigned long *ctr)
 	 * to insure consistency.
 	 */
 	v = CMM_LOAD_SHARED(*ctr);
-	return (v & RCU_GP_CTR_NEST_MASK) &&
-		 ((v ^ rcu_gp_ctr) & RCU_GP_CTR_PHASE);
+	if (!(v & RCU_GP_CTR_NEST_MASK))
+		return RCU_READER_INACTIVE;
+	if (!((v ^ rcu_gp_ctr) & RCU_GP_CTR_PHASE))
+		return RCU_READER_ACTIVE_CURRENT;
+	return RCU_READER_ACTIVE_OLD;
 }
 
 /*
-- 
1.7.10.4
