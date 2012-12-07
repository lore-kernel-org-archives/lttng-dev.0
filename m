From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [PATCH] urcu: make the code of urcu-qsbr as normal urcu
Date: Fri, 07 Dec 2012 15:42:28 +0800
Message-ID: <50C19DE4.1070007__7441.05755952678$1354866914$gmane$org@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, ltt-dev@lists.casi.polymtl.ca
List-Id: lttng-dev@lists.lttng.org

urcu-qsbr's read site's quiescence is much longer than normal urcu ==>
synchronize_rcu() is much slower ==>
rcu_gp_ctr is updated much less ==>
the whole urcu-qsbr will not be slowed down by false sharing of rcu_gp_ctr.

But this patch makes sense to keep the code of urcu-qsbr like normal urcu,
better readability and maintenance.

Test: (4*6 CPUs)
Before patch:
[root@localhost userspace-rcu]# ./tests/test_urcu_qsbr 20 1 20
SUMMARY ./tests/test_urcu_qsbr    testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads  65498297587 nr_writes      2000665 nr_ops  65500298252
[root@localhost userspace-rcu]# ./tests/test_urcu_qsbr 20 1 20
SUMMARY ./tests/test_urcu_qsbr    testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads  67218079467 nr_writes      1981593 nr_ops  67220061060

After patch
./tests/test_urcu_qsbr 20 1 20
SUMMARY ./tests/test_urcu_qsbr    testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads  67473798999 nr_writes      1999151 nr_ops  67475798150
[root@localhost userspace-rcu]# ./tests/test_urcu_qsbr 20 1 20
SUMMARY ./tests/test_urcu_qsbr    testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads  67065521397 nr_writes      1993956 nr_ops  67067515353


Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
--
diff --git a/urcu-qsbr.c b/urcu-qsbr.c
index 3c2c65d..995c564 100644
--- a/urcu-qsbr.c
+++ b/urcu-qsbr.c
@@ -53,13 +53,7 @@
 void __attribute__((destructor)) rcu_exit(void);
 
 static pthread_mutex_t rcu_gp_lock = PTHREAD_MUTEX_INITIALIZER;
-
-int32_t rcu_gp_futex;
-
-/*
- * Global grace period counter.
- */
-unsigned long rcu_gp_ctr = RCU_GP_ONLINE;
+struct urcu_gp rcu_gp = { .ctr = RCU_GP_ONLINE };
 
 /*
  * Active attempts to check for reader Q.S. before calling futex().
@@ -118,8 +112,8 @@ static void wait_gp(void)
 {
 	/* Read reader_gp before read futex */
 	cmm_smp_rmb();
-	if (uatomic_read(&rcu_gp_futex) == -1)
-		futex_noasync(&rcu_gp_futex, FUTEX_WAIT, -1,
+	if (uatomic_read(&rcu_gp.futex) == -1)
+		futex_noasync(&rcu_gp.futex, FUTEX_WAIT, -1,
 		      NULL, NULL, 0);
 }
 
@@ -133,12 +127,12 @@ static void wait_for_readers(struct cds_list_head *input_readers,
 	/*
 	 * Wait for each thread URCU_TLS(rcu_reader).ctr to either
 	 * indicate quiescence (offline), or for them to observe the
-	 * current rcu_gp_ctr value.
+	 * current rcu_gp.ctr value.
 	 */
 	for (;;) {
 		wait_loops++;
 		if (wait_loops >= RCU_QS_ACTIVE_ATTEMPTS) {
-			uatomic_set(&rcu_gp_futex, -1);
+			uatomic_set(&rcu_gp.futex, -1);
 			/*
 			 * Write futex before write waiting (the other side
 			 * reads them in the opposite order).
@@ -177,7 +171,7 @@ static void wait_for_readers(struct cds_list_head *input_readers,
 			if (wait_loops >= RCU_QS_ACTIVE_ATTEMPTS) {
 				/* Read reader_gp before write futex */
 				cmm_smp_mb();
-				uatomic_set(&rcu_gp_futex, 0);
+				uatomic_set(&rcu_gp.futex, 0);
 			}
 			break;
 		} else {
@@ -253,11 +247,11 @@ void synchronize_rcu(void)
 
 	/*
 	 * Must finish waiting for quiescent state for original parity
-	 * before committing next rcu_gp_ctr update to memory. Failure
+	 * before committing next rcu_gp.ctr update to memory. Failure
 	 * to do so could result in the writer waiting forever while new
 	 * readers are always accessing data (no progress).  Enforce
 	 * compiler-order of load URCU_TLS(rcu_reader).ctr before store
-	 * to rcu_gp_ctr.
+	 * to rcu_gp.ctr.
 	 */
 	cmm_barrier();
 
@@ -269,13 +263,13 @@ void synchronize_rcu(void)
 	cmm_smp_mb();
 
 	/* Switch parity: 0 -> 1, 1 -> 0 */
-	CMM_STORE_SHARED(rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR);
+	CMM_STORE_SHARED(rcu_gp.ctr, rcu_gp.ctr ^ RCU_GP_CTR);
 
 	/*
-	 * Must commit rcu_gp_ctr update to memory before waiting for
+	 * Must commit rcu_gp.ctr update to memory before waiting for
 	 * quiescent state. Failure to do so could result in the writer
 	 * waiting forever while new readers are always accessing data
-	 * (no progress). Enforce compiler-order of store to rcu_gp_ctr
+	 * (no progress). Enforce compiler-order of store to rcu_gp.ctr
 	 * before load URCU_TLS(rcu_reader).ctr.
 	 */
 	cmm_barrier();
@@ -353,13 +347,13 @@ void synchronize_rcu(void)
 		goto out;
 
 	/* Increment current G.P. */
-	CMM_STORE_SHARED(rcu_gp_ctr, rcu_gp_ctr + RCU_GP_CTR);
+	CMM_STORE_SHARED(rcu_gp.ctr, rcu_gp.ctr + RCU_GP_CTR);
 
 	/*
-	 * Must commit rcu_gp_ctr update to memory before waiting for
+	 * Must commit rcu_gp.ctr update to memory before waiting for
 	 * quiescent state. Failure to do so could result in the writer
 	 * waiting forever while new readers are always accessing data
-	 * (no progress). Enforce compiler-order of store to rcu_gp_ctr
+	 * (no progress). Enforce compiler-order of store to rcu_gp.ctr
 	 * before load URCU_TLS(rcu_reader).ctr.
 	 */
 	cmm_barrier();
diff --git a/urcu/static/urcu-qsbr.h b/urcu/static/urcu-qsbr.h
index f6e5580..2b9bece 100644
--- a/urcu/static/urcu-qsbr.h
+++ b/urcu/static/urcu-qsbr.h
@@ -119,12 +119,18 @@ static inline void rcu_debug_yield_init(void)
 #define RCU_GP_ONLINE		(1UL << 0)
 #define RCU_GP_CTR		(1UL << 1)
 
-/*
- * Global quiescent period counter with low-order bits unused.
- * Using a int rather than a char to eliminate false register dependencies
- * causing stalls on some architectures.
- */
-extern unsigned long rcu_gp_ctr;
+struct urcu_gp {
+	/*
+	 * Global quiescent period counter with low-order bits unused.
+	 * Using a int rather than a char to eliminate false register
+	 * dependencies causing stalls on some architectures.
+	 */
+	unsigned long ctr;
+
+	int32_t futex;
+} __attribute__((aligned(CAA_CACHE_LINE_SIZE)));
+
+extern struct urcu_gp rcu_gp;
 
 struct rcu_reader {
 	/* Data used by both reader and synchronize_rcu() */
@@ -137,8 +143,6 @@ struct rcu_reader {
 
 extern DECLARE_URCU_TLS(struct rcu_reader, rcu_reader);
 
-extern int32_t rcu_gp_futex;
-
 /*
  * Wake-up waiting synchronize_rcu(). Called from many concurrent threads.
  */
@@ -147,10 +151,10 @@ static inline void wake_up_gp(void)
 	if (caa_unlikely(_CMM_LOAD_SHARED(URCU_TLS(rcu_reader).waiting))) {
 		_CMM_STORE_SHARED(URCU_TLS(rcu_reader).waiting, 0);
 		cmm_smp_mb();
-		if (uatomic_read(&rcu_gp_futex) != -1)
+		if (uatomic_read(&rcu_gp.futex) != -1)
 			return;
-		uatomic_set(&rcu_gp_futex, 0);
-		futex_noasync(&rcu_gp_futex, FUTEX_WAKE, 1,
+		uatomic_set(&rcu_gp.futex, 0);
+		futex_noasync(&rcu_gp.futex, FUTEX_WAKE, 1,
 		      NULL, NULL, 0);
 	}
 }
@@ -162,7 +166,7 @@ static inline enum rcu_state rcu_reader_state(unsigned long *ctr)
 	v = CMM_LOAD_SHARED(*ctr);
 	if (!v)
 		return RCU_READER_INACTIVE;
-	if (v == rcu_gp_ctr)
+	if (v == rcu_gp.ctr)
 		return RCU_READER_ACTIVE_CURRENT;
 	return RCU_READER_ACTIVE_OLD;
 }
@@ -216,7 +220,7 @@ static inline void _rcu_quiescent_state_update_and_wakeup(unsigned long gp_ctr)
  * to be invoked directly from non-LGPL code.
  *
  * We skip the memory barriers and gp store if our local ctr already
- * matches the global rcu_gp_ctr value: this is OK because a prior
+ * matches the global rcu_gp.ctr value: this is OK because a prior
  * _rcu_quiescent_state() or _rcu_thread_online() already updated it
  * within our thread, so we have no quiescent state to report.
  */
@@ -224,7 +228,7 @@ static inline void _rcu_quiescent_state(void)
 {
 	unsigned long gp_ctr;
 
-	if ((gp_ctr = CMM_LOAD_SHARED(rcu_gp_ctr)) == URCU_TLS(rcu_reader).ctr)
+	if ((gp_ctr = CMM_LOAD_SHARED(rcu_gp.ctr)) == URCU_TLS(rcu_reader).ctr)
 		return;
 	_rcu_quiescent_state_update_and_wakeup(gp_ctr);
 }
@@ -257,7 +261,7 @@ static inline void _rcu_thread_offline(void)
 static inline void _rcu_thread_online(void)
 {
 	cmm_barrier();	/* Ensure the compiler does not reorder us with mutex */
-	_CMM_STORE_SHARED(URCU_TLS(rcu_reader).ctr, CMM_LOAD_SHARED(rcu_gp_ctr));
+	_CMM_STORE_SHARED(URCU_TLS(rcu_reader).ctr, CMM_LOAD_SHARED(rcu_gp.ctr));
 	cmm_smp_mb();
 }
