From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 1/8] urcu-qsbr: improve 2-phase wait scheme
Date: Sat, 17 Nov 2012 11:16:40 -0500
Message-ID: <1353169007-31389-2-git-send-email-mathieu.desnoyers__10391.3822946653$1353169103$gmane$org@efficios.com>
References: <1353169007-31389-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1TZl5T-0000rU-Ro
	for lttng-dev@lists.lttng.org; Sat, 17 Nov 2012 11:17:43 -0500
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

In the single-bit, 2-phase grace period scheme, all we need to do is to
observe each reader going through a quiescent state while we are in the
grace period.

We therefore only need to perform one global counter update, surrounded
by 2 iterations on readers to observe change in their snapshot.

We can therefore remove the first counter update (prior to the first
iteration on readers): it was useless and was only slowing down the
grace period.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 urcu-qsbr.c |   92 ++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 36 deletions(-)

diff --git a/urcu-qsbr.c b/urcu-qsbr.c
index c6a1b18..eb167d1 100644
--- a/urcu-qsbr.c
+++ b/urcu-qsbr.c
@@ -116,38 +116,16 @@ static void wait_gp(void)
 		      NULL, NULL, 0);
 }
 
-static void update_counter_and_wait(void)
+static void wait_for_readers(void)
 {
 	CDS_LIST_HEAD(qsreaders);
 	int wait_loops = 0;
 	struct rcu_reader *index, *tmp;
 
-#if (CAA_BITS_PER_LONG < 64)
-	/* Switch parity: 0 -> 1, 1 -> 0 */
-	CMM_STORE_SHARED(rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR);
-#else	/* !(CAA_BITS_PER_LONG < 64) */
-	/* Increment current G.P. */
-	CMM_STORE_SHARED(rcu_gp_ctr, rcu_gp_ctr + RCU_GP_CTR);
-#endif	/* !(CAA_BITS_PER_LONG < 64) */
-
-	/*
-	 * Must commit rcu_gp_ctr update to memory before waiting for
-	 * quiescent state. Failure to do so could result in the writer
-	 * waiting forever while new readers are always accessing data
-	 * (no progress). Enforce compiler-order of store to rcu_gp_ctr
-	 * before load URCU_TLS(rcu_reader).ctr.
-	 */
-	cmm_barrier();
-
-	/*
-	 * Adding a cmm_smp_mb() which is _not_ formally required, but makes the
-	 * model easier to understand. It does not have a big performance impact
-	 * anyway, given this is the write-side.
-	 */
-	cmm_smp_mb();
-
 	/*
-	 * Wait for each thread rcu_reader_qs_gp count to become 0.
+	 * Wait for each thread URCU_TLS(rcu_reader).ctr to either
+	 * indicate quiescence (offline), or for them to observe the
+	 * current rcu_gp_ctr value.
 	 */
 	for (;;) {
 		wait_loops++;
@@ -223,17 +201,17 @@ void synchronize_rcu(void)
 		goto out;
 
 	/*
-	 * Wait for previous parity to be empty of readers.
+	 * Wait for readers to observe original parity or be quiescent.
 	 */
-	update_counter_and_wait();	/* 0 -> 1, wait readers in parity 0 */
+	wait_for_readers();
 
 	/*
-	 * Must finish waiting for quiescent state for parity 0 before
-	 * committing next rcu_gp_ctr update to memory. Failure to
-	 * do so could result in the writer waiting forever while new
+	 * Must finish waiting for quiescent state for original parity
+	 * before committing next rcu_gp_ctr update to memory. Failure
+	 * to do so could result in the writer waiting forever while new
 	 * readers are always accessing data (no progress).  Enforce
-	 * compiler-order of load URCU_TLS(rcu_reader).ctr before store to
-	 * rcu_gp_ctr.
+	 * compiler-order of load URCU_TLS(rcu_reader).ctr before store
+	 * to rcu_gp_ctr.
 	 */
 	cmm_barrier();
 
@@ -244,10 +222,29 @@ void synchronize_rcu(void)
 	 */
 	cmm_smp_mb();
 
+	/* Switch parity: 0 -> 1, 1 -> 0 */
+	CMM_STORE_SHARED(rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR);
+
 	/*
-	 * Wait for previous parity to be empty of readers.
+	 * Must commit rcu_gp_ctr update to memory before waiting for
+	 * quiescent state. Failure to do so could result in the writer
+	 * waiting forever while new readers are always accessing data
+	 * (no progress). Enforce compiler-order of store to rcu_gp_ctr
+	 * before load URCU_TLS(rcu_reader).ctr.
 	 */
-	update_counter_and_wait();	/* 1 -> 0, wait readers in parity 1 */
+	cmm_barrier();
+
+	/*
+	 * Adding a cmm_smp_mb() which is _not_ formally required, but makes the
+	 * model easier to understand. It does not have a big performance impact
+	 * anyway, given this is the write-side.
+	 */
+	cmm_smp_mb();
+
+	/*
+	 * Wait for readers to observe new parity or be quiescent.
+	 */
+	wait_for_readers();
 out:
 	mutex_unlock(&rcu_gp_lock);
 
@@ -280,7 +277,30 @@ void synchronize_rcu(void)
 	mutex_lock(&rcu_gp_lock);
 	if (cds_list_empty(&registry))
 		goto out;
-	update_counter_and_wait();
+
+	/* Increment current G.P. */
+	CMM_STORE_SHARED(rcu_gp_ctr, rcu_gp_ctr + RCU_GP_CTR);
+
+	/*
+	 * Must commit rcu_gp_ctr update to memory before waiting for
+	 * quiescent state. Failure to do so could result in the writer
+	 * waiting forever while new readers are always accessing data
+	 * (no progress). Enforce compiler-order of store to rcu_gp_ctr
+	 * before load URCU_TLS(rcu_reader).ctr.
+	 */
+	cmm_barrier();
+
+	/*
+	 * Adding a cmm_smp_mb() which is _not_ formally required, but makes the
+	 * model easier to understand. It does not have a big performance impact
+	 * anyway, given this is the write-side.
+	 */
+	cmm_smp_mb();
+
+	/*
+	 * Wait for readers to observe new count of be quiescent.
+	 */
+	wait_for_readers();
 out:
 	mutex_unlock(&rcu_gp_lock);
 
-- 
1.7.10.4
