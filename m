Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223EFC77B7D
	for <lttng-dev@archiver.kernel.org>; Mon, 15 May 2023 20:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684181905;
	bh=fg8meJ8aqXRAS14UXhGG0bQfkTgRlgESEsroU1Ge6ek=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ZHk6NTU3b8Ymfmvcb5wtVHfH95l57zLJdX8vIYe2jPYRSP1KpaR5MUOR/4wRbvw7a
	 lVH9VYLFEWhsGtDP8Jig2u1lmrBuKNPrVBBFTOERO1/jQBXnlvvZgHAmXJJ59M0iZn
	 x3KSkZ2hg91dURFbtsh4/XofwyznDKc7mRbbjFrOq41RMqgKrkPLUgnSjruw1rnHwT
	 rouMeEOGKZoKmMHwnMkR7TrAkAygKYgPTKbeBPJmLkNBOi3zcfBbZTtIx2p/5xs/vq
	 vJkiGFQYxwHhKAgfO5xIpEYzYc89+4LYEicBYr1h6/cNnD1IYUYQAzSppwmqngk7Pa
	 QHCaIc6rhJ70g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QKrKY69xmz1F06;
	Mon, 15 May 2023 16:18:25 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QKrKN2q1Kz1Dn2
 for <lttng-dev@lists.lttng.org>; Mon, 15 May 2023 16:18:16 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QKrKN1ST7z12nX;
 Mon, 15 May 2023 16:18:16 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Mon, 15 May 2023 16:17:15 -0400
Message-Id: <20230515201718.9809-9-odion@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 08/11] tests: Use uatomic for accessing global
 states
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Cc: Olivier Dion <odion@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Global states accesses were protected via memory barriers. Use the
uatomic API with the RCU memory model so that TSAN does not warns about
none atomic concurrent accesses.

Also, the thread id map mutex must be unlocked after setting the new
created thread id in the map. Otherwise, the new thread could observe an
unset id.

Change-Id: I1ecdc387b3f510621cbc116ad3b95c676f5d659a
Co-authored-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Olivier Dion <odion@efficios.com>
---
 tests/common/api.h            |  12 ++--
 tests/regression/rcutorture.h | 102 ++++++++++++++++++++++++----------
 2 files changed, 80 insertions(+), 34 deletions(-)

diff --git a/tests/common/api.h b/tests/common/api.h
index a260463..9d22b0f 100644
--- a/tests/common/api.h
+++ b/tests/common/api.h
@@ -26,6 +26,7 @@
 
 #include <urcu/compiler.h>
 #include <urcu/arch.h>
+#include <urcu/uatomic.h>
 
 /*
  * Machine parameters.
@@ -135,7 +136,7 @@ static int __smp_thread_id(void)
 	thread_id_t tid = pthread_self();
 
 	for (i = 0; i < NR_THREADS; i++) {
-		if (__thread_id_map[i] == tid) {
+		if (uatomic_read(&__thread_id_map[i]) == tid) {
 			long v = i + 1;  /* must be non-NULL. */
 
 			if (pthread_setspecific(thread_id_key, (void *)v) != 0) {
@@ -184,12 +185,13 @@ static thread_id_t create_thread(void *(*func)(void *), void *arg)
 		exit(-1);
 	}
 	__thread_id_map[i] = __THREAD_ID_MAP_WAITING;
-	spin_unlock(&__thread_id_map_mutex);
+
 	if (pthread_create(&tid, NULL, func, arg) != 0) {
 		perror("create_thread:pthread_create");
 		exit(-1);
 	}
-	__thread_id_map[i] = tid;
+	uatomic_set(&__thread_id_map[i], tid);
+	spin_unlock(&__thread_id_map_mutex);
 	return tid;
 }
 
@@ -199,7 +201,7 @@ static void *wait_thread(thread_id_t tid)
 	void *vp;
 
 	for (i = 0; i < NR_THREADS; i++) {
-		if (__thread_id_map[i] == tid)
+		if (uatomic_read(&__thread_id_map[i]) == tid)
 			break;
 	}
 	if (i >= NR_THREADS){
@@ -211,7 +213,7 @@ static void *wait_thread(thread_id_t tid)
 		perror("wait_thread:pthread_join");
 		exit(-1);
 	}
-	__thread_id_map[i] = __THREAD_ID_MAP_EMPTY;
+	uatomic_set(&__thread_id_map[i], __THREAD_ID_MAP_EMPTY);
 	return vp;
 }
 
diff --git a/tests/regression/rcutorture.h b/tests/regression/rcutorture.h
index bc394f9..754bbf0 100644
--- a/tests/regression/rcutorture.h
+++ b/tests/regression/rcutorture.h
@@ -44,6 +44,14 @@
  * data.  A correct RCU implementation will have all but the first two
  * numbers non-zero.
  *
+ * rcu_stress_count: Histogram of "ages" of structures seen by readers.  If any
+ * entries past the first two are non-zero, RCU is broken. The age of a newly
+ * allocated structure is zero, it becomes one when removed from reader
+ * visibility, and is incremented once per grace period subsequently -- and is
+ * freed after passing through (RCU_STRESS_PIPE_LEN-2) grace periods.  Since
+ * this tests only has one true writer (there are fake writers), only buckets at
+ * indexes 0 and 1 should be none-zero.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -68,6 +76,8 @@
 #include <stdlib.h>
 #include "tap.h"
 
+#include <urcu/uatomic.h>
+
 #define NR_TESTS	1
 
 DEFINE_PER_THREAD(long long, n_reads_pt);
@@ -145,10 +155,10 @@ void *rcu_read_perf_test(void *arg)
 	run_on(me);
 	uatomic_inc(&nthreadsrunning);
 	put_thread_offline();
-	while (goflag == GOFLAG_INIT)
+	while (uatomic_read(&goflag) == GOFLAG_INIT)
 		(void) poll(NULL, 0, 1);
 	put_thread_online();
-	while (goflag == GOFLAG_RUN) {
+	while (uatomic_read(&goflag) == GOFLAG_RUN) {
 		for (i = 0; i < RCU_READ_RUN; i++) {
 			rcu_read_lock();
 			/* rcu_read_lock_nest(); */
@@ -180,9 +190,9 @@ void *rcu_update_perf_test(void *arg __attribute__((unused)))
 		}
 	}
 	uatomic_inc(&nthreadsrunning);
-	while (goflag == GOFLAG_INIT)
+	while (uatomic_read(&goflag) == GOFLAG_INIT)
 		(void) poll(NULL, 0, 1);
-	while (goflag == GOFLAG_RUN) {
+	while (uatomic_read(&goflag) == GOFLAG_RUN) {
 		synchronize_rcu();
 		n_updates_local++;
 	}
@@ -211,15 +221,11 @@ int perftestrun(int nthreads, int nreaders, int nupdaters)
 	int t;
 	int duration = 1;
 
-	cmm_smp_mb();
 	while (uatomic_read(&nthreadsrunning) < nthreads)
 		(void) poll(NULL, 0, 1);
-	goflag = GOFLAG_RUN;
-	cmm_smp_mb();
+	uatomic_set(&goflag, GOFLAG_RUN);
 	sleep(duration);
-	cmm_smp_mb();
-	goflag = GOFLAG_STOP;
-	cmm_smp_mb();
+	uatomic_set(&goflag, GOFLAG_STOP);
 	wait_all_threads();
 	for_each_thread(t) {
 		n_reads += per_thread(n_reads_pt, t);
@@ -300,6 +306,13 @@ struct rcu_stress rcu_stress_array[RCU_STRESS_PIPE_LEN] = { { 0, 0 } };
 struct rcu_stress *rcu_stress_current;
 int rcu_stress_idx = 0;
 
+/*
+ * How many time a reader has seen something that should not be visible. It is
+ * an error if this value is different than zero at the end of the stress test.
+ *
+ * Here, the something that should not be visibile is an old pipe that has been
+ * freed (mbtest = 0).
+ */
 int n_mberror = 0;
 DEFINE_PER_THREAD(long long [RCU_STRESS_PIPE_LEN + 1], rcu_stress_count);
 
@@ -315,19 +328,25 @@ void *rcu_read_stress_test(void *arg __attribute__((unused)))
 
 	rcu_register_thread();
 	put_thread_offline();
-	while (goflag == GOFLAG_INIT)
+	while (uatomic_read(&goflag) == GOFLAG_INIT)
 		(void) poll(NULL, 0, 1);
 	put_thread_online();
-	while (goflag == GOFLAG_RUN) {
+	while (uatomic_read(&goflag) == GOFLAG_RUN) {
 		rcu_read_lock();
 		p = rcu_dereference(rcu_stress_current);
 		if (p->mbtest == 0)
-			n_mberror++;
+			uatomic_inc_mo(&n_mberror, CMM_RELAXED);
 		rcu_read_lock_nest();
+		/*
+		 * The value of garbage is nothing important. This is
+		 * essentially a busy loop. The atomic operation -- while not
+		 * important here -- helps tools such as TSAN to not flag this
+		 * as a race condition.
+		 */
 		for (i = 0; i < 100; i++)
-			garbage++;
+			uatomic_inc(&garbage);
 		rcu_read_unlock_nest();
-		pc = p->pipe_count;
+		pc = uatomic_read(&p->pipe_count);
 		rcu_read_unlock();
 		if ((pc > RCU_STRESS_PIPE_LEN) || (pc < 0))
 			pc = RCU_STRESS_PIPE_LEN;
@@ -397,26 +416,47 @@ static
 void *rcu_update_stress_test(void *arg __attribute__((unused)))
 {
 	int i;
-	struct rcu_stress *p;
+	struct rcu_stress *p, *old_p;
 	struct rcu_head rh;
 	enum writer_state writer_state = WRITER_STATE_SYNC_RCU;
 
-	while (goflag == GOFLAG_INIT)
+	rcu_register_thread();
+
+	put_thread_offline();
+	while (uatomic_read(&goflag) == GOFLAG_INIT)
 		(void) poll(NULL, 0, 1);
-	while (goflag == GOFLAG_RUN) {
+
+	put_thread_online();
+	while (uatomic_read(&goflag) == GOFLAG_RUN) {
 		i = rcu_stress_idx + 1;
 		if (i >= RCU_STRESS_PIPE_LEN)
 			i = 0;
+		/*
+		 * Get old pipe that we free after a synchronize_rcu().
+		 */
+		rcu_read_lock();
+		old_p = rcu_dereference(rcu_stress_current);
+		rcu_read_unlock();
+
+		/*
+		 * Allocate a new pipe.
+		 */
 		p = &rcu_stress_array[i];
-		p->mbtest = 0;
-		cmm_smp_mb();
 		p->pipe_count = 0;
 		p->mbtest = 1;
+
 		rcu_assign_pointer(rcu_stress_current, p);
 		rcu_stress_idx = i;
+
+		/*
+		 * Increment every pipe except the freshly allocated one. A
+		 * reader should only see either the old pipe or the new
+		 * pipe. This is reflected in the rcu_stress_count histogram.
+		 */
 		for (i = 0; i < RCU_STRESS_PIPE_LEN; i++)
 			if (i != rcu_stress_idx)
-				rcu_stress_array[i].pipe_count++;
+				uatomic_inc(&rcu_stress_array[i].pipe_count);
+
 		switch (writer_state) {
 		case WRITER_STATE_SYNC_RCU:
 			synchronize_rcu();
@@ -478,10 +518,18 @@ void *rcu_update_stress_test(void *arg __attribute__((unused)))
 			break;
 		}
 		}
+		/*
+		 * No readers should see that old pipe now. Setting mbtest to 0
+		 * to mark it as "freed".
+		 */
+		old_p->mbtest = 0;
 		n_updates++;
 		advance_writer_state(&writer_state);
 	}
 
+	put_thread_offline();
+	rcu_unregister_thread();
+
 	return NULL;
 }
 
@@ -497,9 +545,9 @@ void *rcu_fake_update_stress_test(void *arg __attribute__((unused)))
 			set_thread_call_rcu_data(crdp);
 		}
 	}
-	while (goflag == GOFLAG_INIT)
+	while (uatomic_read(&goflag) == GOFLAG_INIT)
 		(void) poll(NULL, 0, 1);
-	while (goflag == GOFLAG_RUN) {
+	while (uatomic_read(&goflag) == GOFLAG_RUN) {
 		synchronize_rcu();
 		(void) poll(NULL, 0, 1);
 	}
@@ -535,13 +583,9 @@ int stresstest(int nreaders)
 	create_thread(rcu_update_stress_test, NULL);
 	for (i = 0; i < 5; i++)
 		create_thread(rcu_fake_update_stress_test, NULL);
-	cmm_smp_mb();
-	goflag = GOFLAG_RUN;
-	cmm_smp_mb();
+	uatomic_set(&goflag, GOFLAG_RUN);
 	sleep(10);
-	cmm_smp_mb();
-	goflag = GOFLAG_STOP;
-	cmm_smp_mb();
+	uatomic_set(&goflag, GOFLAG_STOP);
 	wait_all_threads();
 	for_each_thread(t)
 		n_reads += per_thread(n_reads_pt, t);
-- 
2.39.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
