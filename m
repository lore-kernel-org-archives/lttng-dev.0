From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 6/8] urcu-bp: move quiescent threads to separate
	list
Date: Sat, 17 Nov 2012 11:16:45 -0500
Message-ID: <1353169007-31389-7-git-send-email-mathieu.desnoyers__33247.2504502677$1353170742$gmane$org@efficios.com>
References: <1353169007-31389-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1TZl5e-0000tr-2v
	for lttng-dev@lists.lttng.org; Sat, 17 Nov 2012 11:17:54 -0500
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
threads not within RCU read-side critical section.

CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
CC: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 urcu-bp.c             |   46 +++++++++++++++++++++++++++++++++++-----------
 urcu.c                |    2 +-
 urcu/static/urcu-bp.h |   29 +++++++++++++++++++----------
 3 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/urcu-bp.c b/urcu-bp.c
index 4b3cf01..f99c0e5 100644
--- a/urcu-bp.c
+++ b/urcu-bp.c
@@ -115,7 +115,7 @@ DEFINE_URCU_TLS(unsigned int, rcu_rand_yield);
  * Also has a RCU_GP_COUNT of 1, to accelerate the reader fast path.
  * Written to only by writer with mutex taken. Read by both writer and readers.
  */
-long rcu_gp_ctr = RCU_GP_COUNT;
+unsigned long rcu_gp_ctr = RCU_GP_COUNT;
 
 /*
  * Pointer to registry elements. Written to only by each individual reader. Read
@@ -164,9 +164,10 @@ static void mutex_unlock(pthread_mutex_t *mutex)
 		urcu_die(ret);
 }
 
-static void wait_for_readers(void)
+static void wait_for_readers(struct cds_list_head *input_readers,
+			struct cds_list_head *cur_snap_readers,
+			struct cds_list_head *qsreaders)
 {
-	CDS_LIST_HEAD(qsreaders);
 	int wait_loops = 0;
 	struct rcu_reader *index, *tmp;
 
@@ -177,12 +178,30 @@ static void wait_for_readers(void)
 	 */
 	for (;;) {
 		wait_loops++;
-		cds_list_for_each_entry_safe(index, tmp, &registry, node) {
-			if (!rcu_old_gp_ongoing(&index->ctr))
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
 			break;
 		} else {
 			if (wait_loops == RCU_QS_ACTIVE_ATTEMPTS)
@@ -191,12 +210,12 @@ static void wait_for_readers(void)
 				caa_cpu_relax();
 		}
 	}
-	/* put back the reader list in the registry */
-	cds_list_splice(&qsreaders, &registry);
 }
 
 void synchronize_rcu(void)
 {
+	CDS_LIST_HEAD(cur_snap_readers);
+	CDS_LIST_HEAD(qsreaders);
 	sigset_t newmask, oldmask;
 	int ret;
 
@@ -221,7 +240,7 @@ void synchronize_rcu(void)
 	/*
 	 * Wait for readers to observe original parity or be quiescent.
 	 */
-	wait_for_readers();
+	wait_for_readers(&registry, &cur_snap_readers, &qsreaders);
 
 	/*
 	 * Adding a cmm_smp_mb() which is _not_ formally required, but makes the
@@ -250,7 +269,12 @@ void synchronize_rcu(void)
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
 
 	/*
 	 * Finish waiting for reader threads before letting the old ptr being
diff --git a/urcu.c b/urcu.c
index c692db9..e6ff0f3 100644
--- a/urcu.c
+++ b/urcu.c
@@ -361,7 +361,7 @@ void synchronize_rcu(void)
 	/*
 	 * Wait for readers to observe new parity or be quiescent.
 	 */
-	wait_for_readers(&registry, NULL, &qsreaders);
+	wait_for_readers(&cur_snap_readers, NULL, &qsreaders);
 
 	/*
 	 * Put quiescent reader list back into registry.
diff --git a/urcu/static/urcu-bp.h b/urcu/static/urcu-bp.h
index c52a688..c7f5326 100644
--- a/urcu/static/urcu-bp.h
+++ b/urcu/static/urcu-bp.h
@@ -58,6 +58,12 @@ extern "C" {
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
@@ -129,11 +135,11 @@ extern void rcu_bp_register(void);
  * Using a int rather than a char to eliminate false register dependencies
  * causing stalls on some architectures.
  */
-extern long rcu_gp_ctr;
+extern unsigned long rcu_gp_ctr;
 
 struct rcu_reader {
 	/* Data used by both reader and synchronize_rcu() */
-	long ctr;
+	unsigned long ctr;
 	/* Data used for registry */
 	struct cds_list_head node __attribute__((aligned(CAA_CACHE_LINE_SIZE)));
 	pthread_t tid;
@@ -147,19 +153,22 @@ struct rcu_reader {
  */
 extern DECLARE_URCU_TLS(struct rcu_reader *, rcu_reader);
 
-static inline int rcu_old_gp_ongoing(long *value)
+static inline enum rcu_state rcu_reader_state(unsigned long *ctr)
 {
-	long v;
+	unsigned long v;
 
-	if (value == NULL)
-		return 0;
+	if (ctr == NULL)
+		return RCU_READER_INACTIVE;
 	/*
 	 * Make sure both tests below are done on the same version of *value
 	 * to insure consistency.
 	 */
-	v = CMM_LOAD_SHARED(*value);
-	return (v & RCU_GP_CTR_NEST_MASK) &&
-		 ((v ^ rcu_gp_ctr) & RCU_GP_CTR_PHASE);
+	v = CMM_LOAD_SHARED(*ctr);
+	if (!(v & RCU_GP_CTR_NEST_MASK))
+		return RCU_READER_INACTIVE;
+	if (!((v ^ rcu_gp_ctr) & RCU_GP_CTR_PHASE))
+		return RCU_READER_ACTIVE_CURRENT;
+	return RCU_READER_ACTIVE_OLD;
 }
 
 /*
@@ -190,7 +199,7 @@ static inline void _rcu_read_lock_update(unsigned long tmp)
  */
 static inline void _rcu_read_lock(void)
 {
-	long tmp;
+	unsigned long tmp;
 
 	if (caa_unlikely(!URCU_TLS(rcu_reader)))
 		rcu_bp_register(); /* If not yet registered. */
-- 
1.7.10.4
