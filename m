From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 09/16] urcu-bp: improve 2-phase wait scheme
Date: Tue, 20 Nov 2012 14:40:22 -0500
Message-ID: <1353440429-19223-10-git-send-email-mathieu.desnoyers__30883.5944546901$1353440554$gmane$org@efficios.com>
References: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1TathN-0001Ma-SK
	for lttng-dev@lists.lttng.org; Tue, 20 Nov 2012 14:41:33 -0500
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

In the single-bit, 2-phase grace period scheme, all we need to do is to
observe each reader going through a quiescent state while we are in the
grace period.

We therefore only need to perform one global counter update, surrounded
by 2 iterations on readers to observe change in their snapshot.

We can therefore remove the first counter update (prior to the first
iteration on readers): it was useless and was only slowing down the
grace period.

CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
CC: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 urcu-bp.c |   48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/urcu-bp.c b/urcu-bp.c
index b07a1bb..4b3cf01 100644
--- a/urcu-bp.c
+++ b/urcu-bp.c
@@ -164,31 +164,16 @@ static void mutex_unlock(pthread_mutex_t *mutex)
 		urcu_die(ret);
 }
 
-static void update_counter_and_wait(void)
+static void wait_for_readers(void)
 {
 	CDS_LIST_HEAD(qsreaders);
 	int wait_loops = 0;
 	struct rcu_reader *index, *tmp;
 
-	/* Switch parity: 0 -> 1, 1 -> 0 */
-	CMM_STORE_SHARED(rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR_PHASE);
-
-	/*
-	 * Must commit qparity update to memory before waiting for other parity
-	 * quiescent state. Failure to do so could result in the writer waiting
-	 * forever while new readers are always accessing data (no progress).
-	 * Ensured by CMM_STORE_SHARED and CMM_LOAD_SHARED.
-	 */
-
-	/*
-	 * Adding a cmm_smp_mb() which is _not_ formally required, but makes the
-	 * model easier to understand. It does not have a big performance impact
-	 * anyway, given this is the write-side.
-	 */
-	cmm_smp_mb();
-
 	/*
-	 * Wait for each thread rcu_reader.ctr count to become 0.
+	 * Wait for each thread URCU_TLS(rcu_reader).ctr to either
+	 * indicate quiescence (not nested), or observe the current
+	 * rcu_gp_ctr value.
 	 */
 	for (;;) {
 		wait_loops++;
@@ -234,9 +219,26 @@ void synchronize_rcu(void)
 	rcu_gc_registry();
 
 	/*
-	 * Wait for previous parity to be empty of readers.
+	 * Wait for readers to observe original parity or be quiescent.
+	 */
+	wait_for_readers();
+
+	/*
+	 * Adding a cmm_smp_mb() which is _not_ formally required, but makes the
+	 * model easier to understand. It does not have a big performance impact
+	 * anyway, given this is the write-side.
+	 */
+	cmm_smp_mb();
+
+	/* Switch parity: 0 -> 1, 1 -> 0 */
+	CMM_STORE_SHARED(rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR_PHASE);
+
+	/*
+	 * Must commit qparity update to memory before waiting for other parity
+	 * quiescent state. Failure to do so could result in the writer waiting
+	 * forever while new readers are always accessing data (no progress).
+	 * Ensured by CMM_STORE_SHARED and CMM_LOAD_SHARED.
 	 */
-	update_counter_and_wait();	/* 0 -> 1, wait readers in parity 0 */
 
 	/*
 	 * Adding a cmm_smp_mb() which is _not_ formally required, but makes the
@@ -246,9 +248,9 @@ void synchronize_rcu(void)
 	cmm_smp_mb();
 
 	/*
-	 * Wait for previous parity to be empty of readers.
+	 * Wait for readers to observe new parity or be quiescent.
 	 */
-	update_counter_and_wait();	/* 1 -> 0, wait readers in parity 1 */
+	wait_for_readers();
 
 	/*
 	 * Finish waiting for reader threads before letting the old ptr being
-- 
1.7.10.4
