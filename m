Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A396C77B7A
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jun 2023 18:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686164105;
	bh=gw9USu16gMZZhKqfQ/BJjvZsJCafsVWq6Vi0q2GrlBU=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=j/lE7kejZgow+LZjjBRC3Y1XBedgnaDgCsoABELT9Zu2wdNgD9zaO/XX3E/0+q8qX
	 EHSHAatXvG0EdGpK4fq8tuEVQ0ayUyrmv/UXU0Ir4Qb8L/F0zvhTyIwRsOBGHLkGka
	 605IgoOaOMlq3PQPmEfCxqCvXBTTCXybG5qPZLuECE7vGcEANN0KuXM0sn05Ug5tF2
	 959uXmlxaRD1fY52wRvTe0mR+kzCnDeJD0GK8rl0uSvRxljW3hBlgHOWUGwuY9T69T
	 VbUGUnt1o4PfG9PSwJgXyEev7rcDUqCnLj8nOxlqHy93ofi0mlN/M7/sTZHD8ZkmTh
	 RRu0nxfT5A6Xw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QbxNn18jgz1XLZ;
	Wed,  7 Jun 2023 14:55:05 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QbxNg3MXvz1XbN
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jun 2023 14:54:59 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QbxNX5xXPz16t5;
 Wed,  7 Jun 2023 14:54:52 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Wed,  7 Jun 2023 14:53:55 -0400
Message-Id: <20230607185359.8125-9-odion@efficios.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH v2 08/12] benchmark: Use uatomic for accessing
 global states
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
Cc: Olivier Dion <odion@efficios.com>, Tony Finch <dot@dotat.at>,
 "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Global states accesses were protected via memory barriers. Use the
uatomic API with the CMM memory model so that TSAN can understand the
ordering imposed by the synchronization flags.

Change-Id: I1bf5702c5ac470f308c478effe39e424a3158060
Co-authored-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Olivier Dion <odion@efficios.com>
---
 tests/benchmark/Makefile.am             | 91 +++++++++++++------------
 tests/benchmark/common-states.c         |  1 +
 tests/benchmark/common-states.h         | 51 ++++++++++++++
 tests/benchmark/test_mutex.c            | 32 +--------
 tests/benchmark/test_perthreadlock.c    | 32 +--------
 tests/benchmark/test_rwlock.c           | 32 +--------
 tests/benchmark/test_urcu.c             | 33 +--------
 tests/benchmark/test_urcu_assign.c      | 33 +--------
 tests/benchmark/test_urcu_bp.c          | 33 +--------
 tests/benchmark/test_urcu_defer.c       | 33 +--------
 tests/benchmark/test_urcu_gc.c          | 34 ++-------
 tests/benchmark/test_urcu_hash.c        |  6 +-
 tests/benchmark/test_urcu_hash.h        | 15 ----
 tests/benchmark/test_urcu_hash_rw.c     | 10 +--
 tests/benchmark/test_urcu_hash_unique.c | 10 +--
 tests/benchmark/test_urcu_lfq.c         | 20 ++----
 tests/benchmark/test_urcu_lfs.c         | 20 ++----
 tests/benchmark/test_urcu_lfs_rcu.c     | 20 ++----
 tests/benchmark/test_urcu_qsbr.c        | 33 +--------
 tests/benchmark/test_urcu_qsbr_gc.c     | 34 ++-------
 tests/benchmark/test_urcu_wfcq.c        | 22 +++---
 tests/benchmark/test_urcu_wfq.c         | 20 ++----
 tests/benchmark/test_urcu_wfs.c         | 22 +++---
 23 files changed, 177 insertions(+), 460 deletions(-)
 create mode 100644 tests/benchmark/common-states.c
 create mode 100644 tests/benchmark/common-states.h

diff --git a/tests/benchmark/Makefile.am b/tests/benchmark/Makefile.am
index c53e025..a7f91c2 100644
--- a/tests/benchmark/Makefile.am
+++ b/tests/benchmark/Makefile.am
@@ -1,4 +1,5 @@
 AM_CPPFLAGS += -I$(top_srcdir)/src -I$(top_srcdir)/tests/common
+AM_CPPFLAGS += -include $(top_srcdir)/tests/benchmark/common-states.h
 
 TEST_EXTENSIONS = .tap
 TAP_LOG_DRIVER_FLAGS = --merge --comments
@@ -7,6 +8,8 @@ TAP_LOG_DRIVER = env AM_TAP_AWK='$(AWK)' \
 	URCU_TESTS_BUILDDIR='$(abs_top_builddir)/tests' \
 	$(SHELL) $(top_srcdir)/tests/utils/tap-driver.sh
 
+noinst_HEADERS = common-states.h
+
 SCRIPT_LIST = \
 	runpaul-phase1.sh \
 	runpaul-phase2.sh \
@@ -61,163 +64,163 @@ URCU_CDS_LIB=$(top_builddir)/src/liburcu-cds.la
 
 DEBUG_YIELD_LIB=$(builddir)/../common/libdebug-yield.la
 
-test_urcu_SOURCES = test_urcu.c
+test_urcu_SOURCES = test_urcu.c common-states.c
 test_urcu_LDADD = $(URCU_LIB)
 
-test_urcu_dynamic_link_SOURCES = test_urcu.c
+test_urcu_dynamic_link_SOURCES = test_urcu.c common-states.c
 test_urcu_dynamic_link_LDADD = $(URCU_LIB)
 test_urcu_dynamic_link_CFLAGS = -DDYNAMIC_LINK_TEST $(AM_CFLAGS)
 
-test_urcu_timing_SOURCES = test_urcu_timing.c
+test_urcu_timing_SOURCES = test_urcu_timing.c common-states.c
 test_urcu_timing_LDADD = $(URCU_LIB)
 
-test_urcu_yield_SOURCES = test_urcu.c
+test_urcu_yield_SOURCES = test_urcu.c common-states.c
 test_urcu_yield_LDADD = $(URCU_LIB) $(DEBUG_YIELD_LIB)
 test_urcu_yield_CFLAGS = -DDEBUG_YIELD $(AM_CFLAGS)
 
 
-test_urcu_qsbr_SOURCES = test_urcu_qsbr.c
+test_urcu_qsbr_SOURCES = test_urcu_qsbr.c common-states.c
 test_urcu_qsbr_LDADD = $(URCU_QSBR_LIB)
 
-test_urcu_qsbr_timing_SOURCES = test_urcu_qsbr_timing.c
+test_urcu_qsbr_timing_SOURCES = test_urcu_qsbr_timing.c common-states.c
 test_urcu_qsbr_timing_LDADD = $(URCU_QSBR_LIB)
 
 
-test_urcu_mb_SOURCES = test_urcu.c
+test_urcu_mb_SOURCES = test_urcu.c common-states.c
 test_urcu_mb_LDADD = $(URCU_MB_LIB)
 test_urcu_mb_CFLAGS = -DRCU_MB $(AM_CFLAGS)
 
 
-test_urcu_signal_SOURCES = test_urcu.c
+test_urcu_signal_SOURCES = test_urcu.c common-states.c
 test_urcu_signal_LDADD = $(URCU_SIGNAL_LIB)
 test_urcu_signal_CFLAGS = -DRCU_SIGNAL $(AM_CFLAGS)
 
-test_urcu_signal_dynamic_link_SOURCES = test_urcu.c
+test_urcu_signal_dynamic_link_SOURCES = test_urcu.c common-states.c
 test_urcu_signal_dynamic_link_LDADD = $(URCU_SIGNAL_LIB)
 test_urcu_signal_dynamic_link_CFLAGS = -DRCU_SIGNAL -DDYNAMIC_LINK_TEST \
 					$(AM_CFLAGS)
 
-test_urcu_signal_timing_SOURCES = test_urcu_timing.c
+test_urcu_signal_timing_SOURCES = test_urcu_timing.c common-states.c
 test_urcu_signal_timing_LDADD = $(URCU_SIGNAL_LIB)
 test_urcu_signal_timing_CFLAGS= -DRCU_SIGNAL $(AM_CFLAGS)
 
-test_urcu_signal_yield_SOURCES = test_urcu.c
+test_urcu_signal_yield_SOURCES = test_urcu.c common-states.c
 test_urcu_signal_yield_LDADD = $(URCU_SIGNAL_LIB) $(DEBUG_YIELD_LIB)
 test_urcu_signal_yield_CFLAGS = -DRCU_SIGNAL -DDEBUG_YIELD $(AM_CFLAGS)
 
-test_rwlock_timing_SOURCES = test_rwlock_timing.c
+test_rwlock_timing_SOURCES = test_rwlock_timing.c common-states.c
 test_rwlock_timing_LDADD = $(URCU_SIGNAL_LIB)
 
-test_rwlock_SOURCES = test_rwlock.c
+test_rwlock_SOURCES = test_rwlock.c common-states.c
 test_rwlock_LDADD = $(URCU_SIGNAL_LIB)
 
-test_perthreadlock_timing_SOURCES = test_perthreadlock_timing.c
+test_perthreadlock_timing_SOURCES = test_perthreadlock_timing.c common-states.c
 test_perthreadlock_timing_LDADD = $(URCU_SIGNAL_LIB)
 
-test_perthreadlock_SOURCES = test_perthreadlock.c
+test_perthreadlock_SOURCES = test_perthreadlock.c common-states.c
 test_perthreadlock_LDADD = $(URCU_SIGNAL_LIB)
 
-test_mutex_SOURCES = test_mutex.c
+test_mutex_SOURCES = test_mutex.c common-states.c
 
-test_looplen_SOURCES = test_looplen.c
+test_looplen_SOURCES = test_looplen.c common-states.c
 
-test_urcu_gc_SOURCES = test_urcu_gc.c
+test_urcu_gc_SOURCES = test_urcu_gc.c common-states.c
 test_urcu_gc_LDADD = $(URCU_LIB)
 
-test_urcu_signal_gc_SOURCES = test_urcu_gc.c
+test_urcu_signal_gc_SOURCES = test_urcu_gc.c common-states.c
 test_urcu_signal_gc_LDADD = $(URCU_SIGNAL_LIB)
 test_urcu_signal_gc_CFLAGS = -DRCU_SIGNAL $(AM_CFLAGS)
 
-test_urcu_mb_gc_SOURCES = test_urcu_gc.c
+test_urcu_mb_gc_SOURCES = test_urcu_gc.c common-states.c
 test_urcu_mb_gc_LDADD = $(URCU_MB_LIB)
 test_urcu_mb_gc_CFLAGS = -DRCU_MB $(AM_CFLAGS)
 
-test_urcu_qsbr_gc_SOURCES = test_urcu_qsbr_gc.c
+test_urcu_qsbr_gc_SOURCES = test_urcu_qsbr_gc.c common-states.c
 test_urcu_qsbr_gc_LDADD = $(URCU_QSBR_LIB)
 
-test_urcu_qsbr_lgc_SOURCES = test_urcu_qsbr_gc.c
+test_urcu_qsbr_lgc_SOURCES = test_urcu_qsbr_gc.c common-states.c
 test_urcu_qsbr_lgc_LDADD = $(URCU_QSBR_LIB)
 test_urcu_qsbr_lgc_CFLAGS = -DTEST_LOCAL_GC $(AM_CFLAGS)
 
-test_urcu_lgc_SOURCES = test_urcu_gc.c
+test_urcu_lgc_SOURCES = test_urcu_gc.c common-states.c
 test_urcu_lgc_LDADD = $(URCU_LIB)
 test_urcu_lgc_CFLAGS = -DTEST_LOCAL_GC $(AM_CFLAGS)
 
-test_urcu_signal_lgc_SOURCES = test_urcu_gc.c
+test_urcu_signal_lgc_SOURCES = test_urcu_gc.c common-states.c
 test_urcu_signal_lgc_LDADD = $(URCU_SIGNAL_LIB)
 test_urcu_signal_lgc_CFLAGS = -DRCU_SIGNAL -DTEST_LOCAL_GC $(AM_CFLAGS)
 
-test_urcu_mb_lgc_SOURCES = test_urcu_gc.c
+test_urcu_mb_lgc_SOURCES = test_urcu_gc.c common-states.c
 test_urcu_mb_lgc_LDADD = $(URCU_MB_LIB)
 test_urcu_mb_lgc_CFLAGS = -DTEST_LOCAL_GC -DRCU_MB $(AM_CFLAGS)
 
-test_urcu_qsbr_dynamic_link_SOURCES = test_urcu_qsbr.c
+test_urcu_qsbr_dynamic_link_SOURCES = test_urcu_qsbr.c common-states.c
 test_urcu_qsbr_dynamic_link_LDADD = $(URCU_QSBR_LIB)
 test_urcu_qsbr_dynamic_link_CFLAGS = -DDYNAMIC_LINK_TEST $(AM_CFLAGS)
 
-test_urcu_defer_SOURCES = test_urcu_defer.c
+test_urcu_defer_SOURCES = test_urcu_defer.c common-states.c
 test_urcu_defer_LDADD = $(URCU_LIB)
 
 test_cycles_per_loop_SOURCES = test_cycles_per_loop.c
 
-test_urcu_assign_SOURCES = test_urcu_assign.c
+test_urcu_assign_SOURCES = test_urcu_assign.c common-states.c
 test_urcu_assign_LDADD = $(URCU_LIB)
 
-test_urcu_assign_dynamic_link_SOURCES = test_urcu_assign.c
+test_urcu_assign_dynamic_link_SOURCES = test_urcu_assign.c common-states.c
 test_urcu_assign_dynamic_link_LDADD = $(URCU_LIB)
 test_urcu_assign_dynamic_link_CFLAGS = -DDYNAMIC_LINK_TEST $(AM_CFLAGS)
 
-test_urcu_bp_SOURCES = test_urcu_bp.c
+test_urcu_bp_SOURCES = test_urcu_bp.c common-states.c
 test_urcu_bp_LDADD = $(URCU_BP_LIB)
 
-test_urcu_bp_dynamic_link_SOURCES = test_urcu_bp.c
+test_urcu_bp_dynamic_link_SOURCES = test_urcu_bp.c common-states.c
 test_urcu_bp_dynamic_link_LDADD = $(URCU_BP_LIB)
 test_urcu_bp_dynamic_link_CFLAGS = -DDYNAMIC_LINK_TEST $(AM_CFLAGS)
 
-test_urcu_lfq_SOURCES = test_urcu_lfq.c
+test_urcu_lfq_SOURCES = test_urcu_lfq.c common-states.c
 test_urcu_lfq_LDADD = $(URCU_LIB) $(URCU_CDS_LIB)
 
-test_urcu_lfq_dynlink_SOURCES = test_urcu_lfq.c
+test_urcu_lfq_dynlink_SOURCES = test_urcu_lfq.c common-states.c
 test_urcu_lfq_dynlink_CFLAGS = -DDYNAMIC_LINK_TEST $(AM_CFLAGS)
 test_urcu_lfq_dynlink_LDADD = $(URCU_LIB) $(URCU_CDS_LIB)
 
-test_urcu_wfq_SOURCES = test_urcu_wfq.c
+test_urcu_wfq_SOURCES = test_urcu_wfq.c common-states.c
 test_urcu_wfq_LDADD = $(URCU_COMMON_LIB)
 
-test_urcu_wfq_dynlink_SOURCES = test_urcu_wfq.c
+test_urcu_wfq_dynlink_SOURCES = test_urcu_wfq.c common-states.c
 test_urcu_wfq_dynlink_CFLAGS = -DDYNAMIC_LINK_TEST $(AM_CFLAGS)
 test_urcu_wfq_dynlink_LDADD = $(URCU_COMMON_LIB)
 
-test_urcu_wfcq_SOURCES = test_urcu_wfcq.c
+test_urcu_wfcq_SOURCES = test_urcu_wfcq.c common-states.c
 test_urcu_wfcq_LDADD = $(URCU_COMMON_LIB)
 
-test_urcu_wfcq_dynlink_SOURCES = test_urcu_wfcq.c
+test_urcu_wfcq_dynlink_SOURCES = test_urcu_wfcq.c common-states.c
 test_urcu_wfcq_dynlink_CFLAGS = -DDYNAMIC_LINK_TEST $(AM_CFLAGS)
 test_urcu_wfcq_dynlink_LDADD = $(URCU_COMMON_LIB)
 
-test_urcu_lfs_SOURCES = test_urcu_lfs.c
+test_urcu_lfs_SOURCES = test_urcu_lfs.c common-states.c
 test_urcu_lfs_LDADD = $(URCU_LIB) $(URCU_CDS_LIB)
 
-test_urcu_lfs_rcu_SOURCES = test_urcu_lfs_rcu.c
+test_urcu_lfs_rcu_SOURCES = test_urcu_lfs_rcu.c common-states.c
 test_urcu_lfs_rcu_LDADD = $(URCU_LIB) $(URCU_CDS_LIB)
 
-test_urcu_lfs_dynlink_SOURCES = test_urcu_lfs.c
+test_urcu_lfs_dynlink_SOURCES = test_urcu_lfs.c common-states.c
 test_urcu_lfs_dynlink_CFLAGS = -DDYNAMIC_LINK_TEST $(AM_CFLAGS)
 test_urcu_lfs_dynlink_LDADD = $(URCU_LIB) $(URCU_CDS_LIB)
 
-test_urcu_lfs_rcu_dynlink_SOURCES = test_urcu_lfs_rcu.c
+test_urcu_lfs_rcu_dynlink_SOURCES = test_urcu_lfs_rcu.c common-states.c
 test_urcu_lfs_rcu_dynlink_CFLAGS = -DDYNAMIC_LINK_TEST $(AM_CFLAGS)
 test_urcu_lfs_rcu_dynlink_LDADD = $(URCU_LIB) $(URCU_CDS_LIB)
 
-test_urcu_wfs_SOURCES = test_urcu_wfs.c
+test_urcu_wfs_SOURCES = test_urcu_wfs.c common-states.c
 test_urcu_wfs_LDADD = $(URCU_COMMON_LIB)
 
-test_urcu_wfs_dynlink_SOURCES = test_urcu_wfs.c
+test_urcu_wfs_dynlink_SOURCES = test_urcu_wfs.c common-states.c
 test_urcu_wfs_dynlink_CFLAGS = -DDYNAMIC_LINK_TEST $(AM_CFLAGS)
 test_urcu_wfs_dynlink_LDADD = $(URCU_COMMON_LIB)
 
 test_urcu_hash_SOURCES = test_urcu_hash.c test_urcu_hash.h \
-		test_urcu_hash_rw.c test_urcu_hash_unique.c
+		test_urcu_hash_rw.c test_urcu_hash_unique.c common-states.c
 test_urcu_hash_CFLAGS = -DRCU_QSBR $(AM_CFLAGS)
 test_urcu_hash_LDADD = $(URCU_QSBR_LIB) $(URCU_COMMON_LIB) $(URCU_CDS_LIB)
 
diff --git a/tests/benchmark/common-states.c b/tests/benchmark/common-states.c
new file mode 100644
index 0000000..6e70351
--- /dev/null
+++ b/tests/benchmark/common-states.c
@@ -0,0 +1 @@
+volatile int _test_go = 0, _test_stop = 0;
diff --git a/tests/benchmark/common-states.h b/tests/benchmark/common-states.h
new file mode 100644
index 0000000..dfbbfe5
--- /dev/null
+++ b/tests/benchmark/common-states.h
@@ -0,0 +1,51 @@
+/* Common states for benchmarks. */
+
+#include <unistd.h>
+
+#include <urcu/uatomic.h>
+
+extern volatile int _test_go, _test_stop;
+
+static inline void complete_sleep(unsigned int seconds)
+{
+	while (seconds != 0) {
+		seconds = sleep(seconds);
+	}
+}
+
+static inline void begin_test(void)
+{
+	uatomic_store(&_test_go, 1, CMM_RELEASE);
+}
+
+static inline void end_test(void)
+{
+	uatomic_store(&_test_stop, 1, CMM_RELAXED);
+}
+
+static inline void test_for(unsigned int duration)
+{
+	begin_test();
+	complete_sleep(duration);
+	end_test();
+}
+
+static inline void wait_until_go(void)
+{
+	while (!uatomic_load(&_test_go, CMM_ACQUIRE))
+	{
+	}
+}
+
+/*
+ * returns 0 if test should end.
+ */
+static inline int test_duration_write(void)
+{
+	return !uatomic_load(&_test_stop, CMM_RELAXED);
+}
+
+static inline int test_duration_read(void)
+{
+	return !uatomic_load(&_test_stop, CMM_RELAXED);
+}
diff --git a/tests/benchmark/test_mutex.c b/tests/benchmark/test_mutex.c
index 55f7c38..145139c 100644
--- a/tests/benchmark/test_mutex.c
+++ b/tests/benchmark/test_mutex.c
@@ -49,8 +49,6 @@ struct test_array {
 
 static pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
 
-static volatile int test_go, test_stop;
-
 static unsigned long wdelay;
 
 static volatile struct test_array test_array = { 8 };
@@ -111,19 +109,6 @@ static void set_affinity(void)
 #endif /* HAVE_SCHED_SETAFFINITY */
 }
 
-/*
- * returns 0 if test should end.
- */
-static int test_duration_write(void)
-{
-	return !test_stop;
-}
-
-static int test_duration_read(void)
-{
-	return !test_stop;
-}
-
 static DEFINE_URCU_TLS(unsigned long long, nr_writes);
 static DEFINE_URCU_TLS(unsigned long long, nr_reads);
 
@@ -147,9 +132,7 @@ void *thr_reader(void *data)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
+	wait_until_go();
 
 	for (;;) {
 		int v;
@@ -182,10 +165,7 @@ void *thr_writer(void *data)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		pthread_mutex_lock(&lock);
@@ -325,13 +305,7 @@ int main(int argc, char **argv)
 			exit(1);
 	}
 
-	cmm_smp_mb();
-
-	test_go = 1;
-
-	sleep(duration);
-
-	test_stop = 1;
+	test_for(duration);
 
 	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
 		err = pthread_join(tid_reader[i_thr], &tret);
diff --git a/tests/benchmark/test_perthreadlock.c b/tests/benchmark/test_perthreadlock.c
index 47a512c..bf468eb 100644
--- a/tests/benchmark/test_perthreadlock.c
+++ b/tests/benchmark/test_perthreadlock.c
@@ -53,8 +53,6 @@ struct per_thread_lock {
 
 static struct per_thread_lock *per_thread_lock;
 
-static volatile int test_go, test_stop;
-
 static unsigned long wdelay;
 
 static volatile struct test_array test_array = { 8 };
@@ -117,19 +115,6 @@ static void set_affinity(void)
 #endif /* HAVE_SCHED_SETAFFINITY */
 }
 
-/*
- * returns 0 if test should end.
- */
-static int test_duration_write(void)
-{
-	return !test_stop;
-}
-
-static int test_duration_read(void)
-{
-	return !test_stop;
-}
-
 static DEFINE_URCU_TLS(unsigned long long, nr_writes);
 static DEFINE_URCU_TLS(unsigned long long, nr_reads);
 
@@ -175,9 +160,7 @@ void *thr_reader(void *data)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
+	wait_until_go();
 
 	for (;;) {
 		int v;
@@ -211,10 +194,7 @@ void *thr_writer(void *data)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		for (tidx = 0; tidx < (long)nr_readers; tidx++) {
@@ -359,13 +339,7 @@ int main(int argc, char **argv)
 			exit(1);
 	}
 
-	cmm_smp_mb();
-
-	test_go = 1;
-
-	sleep(duration);
-
-	test_stop = 1;
+	test_for(duration);
 
 	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
 		err = pthread_join(tid_reader[i_thr], &tret);
diff --git a/tests/benchmark/test_rwlock.c b/tests/benchmark/test_rwlock.c
index 6908ea4..f5099e8 100644
--- a/tests/benchmark/test_rwlock.c
+++ b/tests/benchmark/test_rwlock.c
@@ -53,8 +53,6 @@ struct test_array {
  */
 pthread_rwlock_t lock;
 
-static volatile int test_go, test_stop;
-
 static unsigned long wdelay;
 
 static volatile struct test_array test_array = { 8 };
@@ -116,19 +114,6 @@ static void set_affinity(void)
 #endif /* HAVE_SCHED_SETAFFINITY */
 }
 
-/*
- * returns 0 if test should end.
- */
-static int test_duration_write(void)
-{
-	return !test_stop;
-}
-
-static int test_duration_read(void)
-{
-	return !test_stop;
-}
-
 static DEFINE_URCU_TLS(unsigned long long, nr_writes);
 static DEFINE_URCU_TLS(unsigned long long, nr_reads);
 
@@ -147,9 +132,7 @@ void *thr_reader(void *_count)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
+	wait_until_go();
 
 	for (;;) {
 		int a, ret;
@@ -194,10 +177,7 @@ void *thr_writer(void *_count)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		int ret;
@@ -355,13 +335,7 @@ int main(int argc, char **argv)
 			exit(1);
 	}
 
-	cmm_smp_mb();
-
-	test_go = 1;
-
-	sleep(duration);
-
-	test_stop = 1;
+	test_for(duration);
 
 	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
 		err = pthread_join(tid_reader[i_thr], &tret);
diff --git a/tests/benchmark/test_urcu.c b/tests/benchmark/test_urcu.c
index ea849fa..b89513b 100644
--- a/tests/benchmark/test_urcu.c
+++ b/tests/benchmark/test_urcu.c
@@ -44,8 +44,6 @@
 #endif
 #include <urcu.h>
 
-static volatile int test_go, test_stop;
-
 static unsigned long wdelay;
 
 static int *test_rcu_pointer;
@@ -107,19 +105,6 @@ static void set_affinity(void)
 #endif /* HAVE_SCHED_SETAFFINITY */
 }
 
-/*
- * returns 0 if test should end.
- */
-static int test_duration_write(void)
-{
-	return !test_stop;
-}
-
-static int test_duration_read(void)
-{
-	return !test_stop;
-}
-
 static DEFINE_URCU_TLS(unsigned long long, nr_writes);
 static DEFINE_URCU_TLS(unsigned long long, nr_reads);
 
@@ -142,10 +127,7 @@ void *thr_reader(void *_count)
 	rcu_register_thread();
 	urcu_posix_assert(!rcu_read_ongoing());
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		rcu_read_lock();
@@ -186,10 +168,7 @@ void *thr_writer(void *_count)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		new = malloc(sizeof(int));
@@ -337,13 +316,7 @@ int main(int argc, char **argv)
 			exit(1);
 	}
 
-	cmm_smp_mb();
-
-	test_go = 1;
-
-	sleep(duration);
-
-	test_stop = 1;
+	test_for(duration);
 
 	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
 		err = pthread_join(tid_reader[i_thr], &tret);
diff --git a/tests/benchmark/test_urcu_assign.c b/tests/benchmark/test_urcu_assign.c
index 88889a8..e83b05e 100644
--- a/tests/benchmark/test_urcu_assign.c
+++ b/tests/benchmark/test_urcu_assign.c
@@ -48,8 +48,6 @@ struct test_array {
 	int a;
 };
 
-static volatile int test_go, test_stop;
-
 static unsigned long wdelay;
 
 static struct test_array *test_rcu_pointer;
@@ -111,19 +109,6 @@ static void set_affinity(void)
 #endif /* HAVE_SCHED_SETAFFINITY */
 }
 
-/*
- * returns 0 if test should end.
- */
-static int test_duration_write(void)
-{
-	return !test_stop;
-}
-
-static int test_duration_read(void)
-{
-	return !test_stop;
-}
-
 static DEFINE_URCU_TLS(unsigned long long, nr_writes);
 static DEFINE_URCU_TLS(unsigned long long, nr_reads);
 
@@ -201,10 +186,7 @@ void *thr_reader(void *_count)
 
 	rcu_register_thread();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		rcu_read_lock();
@@ -240,10 +222,7 @@ void *thr_writer(void *_count)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		rcu_copy_mutex_lock();
@@ -394,13 +373,7 @@ int main(int argc, char **argv)
 			exit(1);
 	}
 
-	cmm_smp_mb();
-
-	test_go = 1;
-
-	sleep(duration);
-
-	test_stop = 1;
+	test_for(duration);
 
 	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
 		err = pthread_join(tid_reader[i_thr], &tret);
diff --git a/tests/benchmark/test_urcu_bp.c b/tests/benchmark/test_urcu_bp.c
index 6f8c59d..c3b00f1 100644
--- a/tests/benchmark/test_urcu_bp.c
+++ b/tests/benchmark/test_urcu_bp.c
@@ -44,8 +44,6 @@
 #endif
 #include <urcu-bp.h>
 
-static volatile int test_go, test_stop;
-
 static unsigned long wdelay;
 
 static int *test_rcu_pointer;
@@ -107,19 +105,6 @@ static void set_affinity(void)
 #endif /* HAVE_SCHED_SETAFFINITY */
 }
 
-/*
- * returns 0 if test should end.
- */
-static int test_duration_write(void)
-{
-	return !test_stop;
-}
-
-static int test_duration_read(void)
-{
-	return !test_stop;
-}
-
 static DEFINE_URCU_TLS(unsigned long long, nr_writes);
 static DEFINE_URCU_TLS(unsigned long long, nr_reads);
 
@@ -142,10 +127,7 @@ void *thr_reader(void *_count)
 	rcu_register_thread();
 	urcu_posix_assert(!rcu_read_ongoing());
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		rcu_read_lock();
@@ -182,10 +164,7 @@ void *thr_writer(void *_count)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		new = malloc(sizeof(int));
@@ -332,13 +311,7 @@ int main(int argc, char **argv)
 			exit(1);
 	}
 
-	cmm_smp_mb();
-
-	test_go = 1;
-
-	sleep(duration);
-
-	test_stop = 1;
+	test_for(duration);
 
 	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
 		err = pthread_join(tid_reader[i_thr], &tret);
diff --git a/tests/benchmark/test_urcu_defer.c b/tests/benchmark/test_urcu_defer.c
index e948ebf..c501f60 100644
--- a/tests/benchmark/test_urcu_defer.c
+++ b/tests/benchmark/test_urcu_defer.c
@@ -49,8 +49,6 @@ struct test_array {
 	int a;
 };
 
-static volatile int test_go, test_stop;
-
 static unsigned long wdelay;
 
 static struct test_array *test_rcu_pointer;
@@ -112,19 +110,6 @@ static void set_affinity(void)
 #endif /* HAVE_SCHED_SETAFFINITY */
 }
 
-/*
- * returns 0 if test should end.
- */
-static int test_duration_write(void)
-{
-	return !test_stop;
-}
-
-static int test_duration_read(void)
-{
-	return !test_stop;
-}
-
 static DEFINE_URCU_TLS(unsigned long long, nr_writes);
 static DEFINE_URCU_TLS(unsigned long long, nr_reads);
 
@@ -149,10 +134,7 @@ void *thr_reader(void *_count)
 
 	rcu_register_thread();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		rcu_read_lock();
@@ -203,10 +185,7 @@ void *thr_writer(void *data)
 		exit(-1);
 	}
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		new = malloc(sizeof(*new));
@@ -359,13 +338,7 @@ int main(int argc, char **argv)
 			exit(1);
 	}
 
-	cmm_smp_mb();
-
-	test_go = 1;
-
-	sleep(duration);
-
-	test_stop = 1;
+	test_for(duration);
 
 	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
 		err = pthread_join(tid_reader[i_thr], &tret);
diff --git a/tests/benchmark/test_urcu_gc.c b/tests/benchmark/test_urcu_gc.c
index f14f728..1cbee44 100644
--- a/tests/benchmark/test_urcu_gc.c
+++ b/tests/benchmark/test_urcu_gc.c
@@ -33,6 +33,7 @@
 #include <urcu/arch.h>
 #include <urcu/assert.h>
 #include <urcu/tls-compat.h>
+#include <urcu/uatomic.h>
 #include "thread-id.h"
 #include "../common/debug-yield.h"
 
@@ -48,8 +49,6 @@ struct test_array {
 	int a;
 };
 
-static volatile int test_go, test_stop;
-
 static unsigned long wdelay;
 
 static struct test_array *test_rcu_pointer;
@@ -120,19 +119,6 @@ static void set_affinity(void)
 #endif /* HAVE_SCHED_SETAFFINITY */
 }
 
-/*
- * returns 0 if test should end.
- */
-static int test_duration_write(void)
-{
-	return !test_stop;
-}
-
-static int test_duration_read(void)
-{
-	return !test_stop;
-}
-
 static DEFINE_URCU_TLS(unsigned long long, nr_writes);
 static DEFINE_URCU_TLS(unsigned long long, nr_reads);
 
@@ -157,10 +143,7 @@ void *thr_reader(void *_count)
 
 	rcu_register_thread();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		rcu_read_lock();
@@ -231,10 +214,7 @@ void *thr_writer(void *data)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 #ifndef TEST_LOCAL_GC
@@ -399,13 +379,7 @@ int main(int argc, char **argv)
 			exit(1);
 	}
 
-	cmm_smp_mb();
-
-	test_go = 1;
-
-	sleep(duration);
-
-	test_stop = 1;
+	test_for(duration);
 
 	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
 		err = pthread_join(tid_reader[i_thr], &tret);
diff --git a/tests/benchmark/test_urcu_hash.c b/tests/benchmark/test_urcu_hash.c
index 3574b4c..1a3087e 100644
--- a/tests/benchmark/test_urcu_hash.c
+++ b/tests/benchmark/test_urcu_hash.c
@@ -96,8 +96,6 @@ DEFINE_URCU_TLS(unsigned long, lookup_ok);
 
 struct cds_lfht *test_ht;
 
-volatile int test_go, test_stop;
-
 unsigned long wdelay;
 
 unsigned long duration;
@@ -649,14 +647,14 @@ int main(int argc, char **argv)
 
 	cmm_smp_mb();
 
-	test_go = 1;
+	begin_test();
 
 	remain = duration;
 	do {
 		remain = sleep(remain);
 	} while (remain > 0);
 
-	test_stop = 1;
+	end_test();
 
 end_pthread_join:
 	for (i_thr = 0; i_thr < nr_readers_created; i_thr++) {
diff --git a/tests/benchmark/test_urcu_hash.h b/tests/benchmark/test_urcu_hash.h
index 47b2ae3..73a0a6d 100644
--- a/tests/benchmark/test_urcu_hash.h
+++ b/tests/benchmark/test_urcu_hash.h
@@ -125,8 +125,6 @@ cds_lfht_iter_get_test_node(struct cds_lfht_iter *iter)
 	return to_test_node(cds_lfht_iter_get_node(iter));
 }
 
-extern volatile int test_go, test_stop;
-
 extern unsigned long wdelay;
 
 extern unsigned long duration;
@@ -174,19 +172,6 @@ extern pthread_mutex_t affinity_mutex;
 
 void set_affinity(void);
 
-/*
- * returns 0 if test should end.
- */
-static inline int test_duration_write(void)
-{
-	return !test_stop;
-}
-
-static inline int test_duration_read(void)
-{
-	return !test_stop;
-}
-
 extern DECLARE_URCU_TLS(unsigned long long, nr_writes);
 extern DECLARE_URCU_TLS(unsigned long long, nr_reads);
 
diff --git a/tests/benchmark/test_urcu_hash_rw.c b/tests/benchmark/test_urcu_hash_rw.c
index 862a6f0..087e869 100644
--- a/tests/benchmark/test_urcu_hash_rw.c
+++ b/tests/benchmark/test_urcu_hash_rw.c
@@ -73,10 +73,7 @@ void *test_hash_rw_thr_reader(void *_count)
 
 	rcu_register_thread();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		rcu_read_lock();
@@ -133,10 +130,7 @@ void *test_hash_rw_thr_writer(void *_count)
 
 	rcu_register_thread();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		struct cds_lfht_node *ret_node = NULL;
diff --git a/tests/benchmark/test_urcu_hash_unique.c b/tests/benchmark/test_urcu_hash_unique.c
index de7c427..90c0e19 100644
--- a/tests/benchmark/test_urcu_hash_unique.c
+++ b/tests/benchmark/test_urcu_hash_unique.c
@@ -71,10 +71,7 @@ void *test_hash_unique_thr_reader(void *_count)
 
 	rcu_register_thread();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		struct lfht_test_node *node;
@@ -136,10 +133,7 @@ void *test_hash_unique_thr_writer(void *_count)
 
 	rcu_register_thread();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		/*
diff --git a/tests/benchmark/test_urcu_lfq.c b/tests/benchmark/test_urcu_lfq.c
index 490e8b0..50c4211 100644
--- a/tests/benchmark/test_urcu_lfq.c
+++ b/tests/benchmark/test_urcu_lfq.c
@@ -47,8 +47,6 @@
 #include <urcu.h>
 #include <urcu/cds.h>
 
-static volatile int test_go, test_stop;
-
 static unsigned long rduration;
 
 static unsigned long duration;
@@ -110,12 +108,12 @@ static void set_affinity(void)
  */
 static int test_duration_dequeue(void)
 {
-	return !test_stop;
+	return test_duration_read();
 }
 
 static int test_duration_enqueue(void)
 {
-	return !test_stop;
+	return test_duration_write();
 }
 
 static DEFINE_URCU_TLS(unsigned long long, nr_dequeues);
@@ -146,10 +144,7 @@ void *thr_enqueuer(void *_count)
 
 	rcu_register_thread();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		struct test *node = malloc(sizeof(*node));
@@ -202,10 +197,7 @@ void *thr_dequeuer(void *_count)
 
 	rcu_register_thread();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		struct cds_lfq_node_rcu *qnode;
@@ -375,7 +367,7 @@ int main(int argc, char **argv)
 
 	cmm_smp_mb();
 
-	test_go = 1;
+	begin_test();
 
 	for (i_thr = 0; i_thr < duration; i_thr++) {
 		sleep(1);
@@ -385,7 +377,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	test_stop = 1;
+	end_test();
 
 	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
 		err = pthread_join(tid_enqueuer[i_thr], &tret);
diff --git a/tests/benchmark/test_urcu_lfs.c b/tests/benchmark/test_urcu_lfs.c
index 52239e0..48b2b23 100644
--- a/tests/benchmark/test_urcu_lfs.c
+++ b/tests/benchmark/test_urcu_lfs.c
@@ -59,8 +59,6 @@ enum test_sync {
 
 static enum test_sync test_sync;
 
-static volatile int test_go, test_stop;
-
 static unsigned long rduration;
 
 static unsigned long duration;
@@ -124,12 +122,12 @@ static void set_affinity(void)
  */
 static int test_duration_dequeue(void)
 {
-	return !test_stop;
+	return test_duration_read();
 }
 
 static int test_duration_enqueue(void)
 {
-	return !test_stop;
+	return test_duration_write();
 }
 
 static DEFINE_URCU_TLS(unsigned long long, nr_dequeues);
@@ -159,10 +157,7 @@ static void *thr_enqueuer(void *_count)
 
 	rcu_register_thread();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		struct test *node = malloc(sizeof(*node));
@@ -261,10 +256,7 @@ static void *thr_dequeuer(void *_count)
 
 	rcu_register_thread();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	urcu_posix_assert(test_pop || test_pop_all);
 
@@ -459,7 +451,7 @@ int main(int argc, char **argv)
 
 	cmm_smp_mb();
 
-	test_go = 1;
+	begin_test();
 
 	for (i_thr = 0; i_thr < duration; i_thr++) {
 		sleep(1);
@@ -469,7 +461,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	test_stop = 1;
+	end_test();
 
 	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
 		err = pthread_join(tid_enqueuer[i_thr], &tret);
diff --git a/tests/benchmark/test_urcu_lfs_rcu.c b/tests/benchmark/test_urcu_lfs_rcu.c
index 7975faf..ae3dff4 100644
--- a/tests/benchmark/test_urcu_lfs_rcu.c
+++ b/tests/benchmark/test_urcu_lfs_rcu.c
@@ -51,8 +51,6 @@
 
 #include <urcu/cds.h>
 
-static volatile int test_go, test_stop;
-
 static unsigned long rduration;
 
 static unsigned long duration;
@@ -114,12 +112,12 @@ static void set_affinity(void)
  */
 static int test_duration_dequeue(void)
 {
-	return !test_stop;
+	return test_duration_read();
 }
 
 static int test_duration_enqueue(void)
 {
-	return !test_stop;
+	return test_duration_write();
 }
 
 static DEFINE_URCU_TLS(unsigned long long, nr_dequeues);
@@ -150,10 +148,7 @@ void *thr_enqueuer(void *_count)
 
 	rcu_register_thread();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		struct test *node = malloc(sizeof(*node));
@@ -205,10 +200,7 @@ void *thr_dequeuer(void *_count)
 
 	rcu_register_thread();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		struct cds_lfs_node_rcu *snode;
@@ -377,7 +369,7 @@ int main(int argc, char **argv)
 
 	cmm_smp_mb();
 
-	test_go = 1;
+	begin_test();
 
 	for (i_thr = 0; i_thr < duration; i_thr++) {
 		sleep(1);
@@ -387,7 +379,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	test_stop = 1;
+	end_test();
 
 	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
 		err = pthread_join(tid_enqueuer[i_thr], &tret);
diff --git a/tests/benchmark/test_urcu_qsbr.c b/tests/benchmark/test_urcu_qsbr.c
index 1ea369c..295e9db 100644
--- a/tests/benchmark/test_urcu_qsbr.c
+++ b/tests/benchmark/test_urcu_qsbr.c
@@ -44,8 +44,6 @@
 #endif
 #include "urcu-qsbr.h"
 
-static volatile int test_go, test_stop;
-
 static unsigned long wdelay;
 
 static int *test_rcu_pointer;
@@ -106,19 +104,6 @@ static void set_affinity(void)
 #endif /* HAVE_SCHED_SETAFFINITY */
 }
 
-/*
- * returns 0 if test should end.
- */
-static int test_duration_write(void)
-{
-	return !test_stop;
-}
-
-static int test_duration_read(void)
-{
-	return !test_stop;
-}
-
 static DEFINE_URCU_TLS(unsigned long long, nr_writes);
 static DEFINE_URCU_TLS(unsigned long long, nr_reads);
 
@@ -145,10 +130,7 @@ void *thr_reader(void *_count)
 	urcu_posix_assert(!rcu_read_ongoing());
 	rcu_thread_online();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		rcu_read_lock();
@@ -192,10 +174,7 @@ void *thr_writer(void *_count)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		new = malloc(sizeof(int));
@@ -343,13 +322,7 @@ int main(int argc, char **argv)
 			exit(1);
 	}
 
-	cmm_smp_mb();
-
-	test_go = 1;
-
-	sleep(duration);
-
-	test_stop = 1;
+	test_for(duration);
 
 	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
 		err = pthread_join(tid_reader[i_thr], &tret);
diff --git a/tests/benchmark/test_urcu_qsbr_gc.c b/tests/benchmark/test_urcu_qsbr_gc.c
index 8877a82..163405d 100644
--- a/tests/benchmark/test_urcu_qsbr_gc.c
+++ b/tests/benchmark/test_urcu_qsbr_gc.c
@@ -33,6 +33,7 @@
 #include <urcu/arch.h>
 #include <urcu/assert.h>
 #include <urcu/tls-compat.h>
+#include <urcu/uatomic.h>
 #include "thread-id.h"
 #include "../common/debug-yield.h"
 
@@ -46,8 +47,6 @@ struct test_array {
 	int a;
 };
 
-static volatile int test_go, test_stop;
-
 static unsigned long wdelay;
 
 static struct test_array *test_rcu_pointer;
@@ -118,19 +117,6 @@ static void set_affinity(void)
 #endif /* HAVE_SCHED_SETAFFINITY */
 }
 
-/*
- * returns 0 if test should end.
- */
-static int test_duration_write(void)
-{
-	return !test_stop;
-}
-
-static int test_duration_read(void)
-{
-	return !test_stop;
-}
-
 static DEFINE_URCU_TLS(unsigned long long, nr_writes);
 static DEFINE_URCU_TLS(unsigned long long, nr_reads);
 
@@ -154,10 +140,7 @@ void *thr_reader(void *_count)
 
 	rcu_register_thread();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		_rcu_read_lock();
@@ -231,10 +214,7 @@ void *thr_writer(void *data)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 #ifndef TEST_LOCAL_GC
@@ -399,13 +379,7 @@ int main(int argc, char **argv)
 			exit(1);
 	}
 
-	cmm_smp_mb();
-
-	test_go = 1;
-
-	sleep(duration);
-
-	test_stop = 1;
+	test_for(duration);
 
 	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
 		err = pthread_join(tid_reader[i_thr], &tret);
diff --git a/tests/benchmark/test_urcu_wfcq.c b/tests/benchmark/test_urcu_wfcq.c
index 2c6e0fd..542a13a 100644
--- a/tests/benchmark/test_urcu_wfcq.c
+++ b/tests/benchmark/test_urcu_wfcq.c
@@ -56,7 +56,7 @@ static enum test_sync test_sync;
 
 static int test_force_sync;
 
-static volatile int test_go, test_stop_enqueue, test_stop_dequeue;
+static volatile int test_stop_enqueue, test_stop_dequeue;
 
 static unsigned long rduration;
 
@@ -122,12 +122,12 @@ static void set_affinity(void)
  */
 static int test_duration_dequeue(void)
 {
-	return !test_stop_dequeue;
+	return !uatomic_load(&test_stop_dequeue, CMM_RELAXED);
 }
 
 static int test_duration_enqueue(void)
 {
-	return !test_stop_enqueue;
+	return !uatomic_load(&test_stop_enqueue, CMM_RELAXED);
 }
 
 static DEFINE_URCU_TLS(unsigned long long, nr_dequeues);
@@ -155,10 +155,7 @@ static void *thr_enqueuer(void *_count)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		struct cds_wfcq_node *node = malloc(sizeof(*node));
@@ -266,10 +263,7 @@ static void *thr_dequeuer(void *_count)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		if (test_dequeue && test_splice) {
@@ -482,7 +476,7 @@ int main(int argc, char **argv)
 
 	cmm_smp_mb();
 
-	test_go = 1;
+	begin_test();
 
 	for (i_thr = 0; i_thr < duration; i_thr++) {
 		sleep(1);
@@ -492,7 +486,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	test_stop_enqueue = 1;
+	uatomic_store(&test_stop_enqueue, 1, CMM_RELEASE);
 
 	if (test_wait_empty) {
 		while (nr_enqueuers != uatomic_read(&test_enqueue_stopped)) {
@@ -503,7 +497,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	test_stop_dequeue = 1;
+	uatomic_store(&test_stop_dequeue, 1, CMM_RELAXED);
 
 	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
 		err = pthread_join(tid_enqueuer[i_thr], &tret);
diff --git a/tests/benchmark/test_urcu_wfq.c b/tests/benchmark/test_urcu_wfq.c
index 8381160..2d8de87 100644
--- a/tests/benchmark/test_urcu_wfq.c
+++ b/tests/benchmark/test_urcu_wfq.c
@@ -51,8 +51,6 @@
 #include <urcu.h>
 #include <urcu/wfqueue.h>
 
-static volatile int test_go, test_stop;
-
 static unsigned long rduration;
 
 static unsigned long duration;
@@ -114,12 +112,12 @@ static void set_affinity(void)
  */
 static int test_duration_dequeue(void)
 {
-	return !test_stop;
+	return test_duration_read();
 }
 
 static int test_duration_enqueue(void)
 {
-	return !test_stop;
+	return test_duration_write();
 }
 
 static DEFINE_URCU_TLS(unsigned long long, nr_dequeues);
@@ -143,10 +141,7 @@ void *thr_enqueuer(void *_count)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		struct cds_wfq_node *node = malloc(sizeof(*node));
@@ -185,10 +180,7 @@ void *thr_dequeuer(void *_count)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		struct cds_wfq_node *node = cds_wfq_dequeue_blocking(&q);
@@ -343,7 +335,7 @@ int main(int argc, char **argv)
 
 	cmm_smp_mb();
 
-	test_go = 1;
+	begin_test();
 
 	for (i_thr = 0; i_thr < duration; i_thr++) {
 		sleep(1);
@@ -353,7 +345,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	test_stop = 1;
+	end_test();
 
 	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
 		err = pthread_join(tid_enqueuer[i_thr], &tret);
diff --git a/tests/benchmark/test_urcu_wfs.c b/tests/benchmark/test_urcu_wfs.c
index c285feb..d1a4afc 100644
--- a/tests/benchmark/test_urcu_wfs.c
+++ b/tests/benchmark/test_urcu_wfs.c
@@ -59,7 +59,7 @@ static enum test_sync test_sync;
 
 static int test_force_sync;
 
-static volatile int test_go, test_stop_enqueue, test_stop_dequeue;
+static volatile int test_stop_enqueue, test_stop_dequeue;
 
 static unsigned long rduration;
 
@@ -125,12 +125,12 @@ static void set_affinity(void)
  */
 static int test_duration_dequeue(void)
 {
-	return !test_stop_dequeue;
+	return !uatomic_load(&test_stop_dequeue, CMM_RELAXED);
 }
 
 static int test_duration_enqueue(void)
 {
-	return !test_stop_enqueue;
+	return !uatomic_load(&test_stop_enqueue, CMM_RELAXED);
 }
 
 static DEFINE_URCU_TLS(unsigned long long, nr_dequeues);
@@ -157,10 +157,7 @@ static void *thr_enqueuer(void *_count)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	for (;;) {
 		struct cds_wfs_node *node = malloc(sizeof(*node));
@@ -250,10 +247,7 @@ static void *thr_dequeuer(void *_count)
 
 	set_affinity();
 
-	while (!test_go)
-	{
-	}
-	cmm_smp_mb();
+	wait_until_go();
 
 	urcu_posix_assert(test_pop || test_pop_all);
 
@@ -469,7 +463,7 @@ int main(int argc, char **argv)
 
 	cmm_smp_mb();
 
-	test_go = 1;
+	begin_test();
 
 	for (i_thr = 0; i_thr < duration; i_thr++) {
 		sleep(1);
@@ -479,7 +473,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	test_stop_enqueue = 1;
+	uatomic_store(&test_stop_enqueue, 1, CMM_RELEASE);
 
 	if (test_wait_empty) {
 		while (nr_enqueuers != uatomic_read(&test_enqueue_stopped)) {
@@ -490,7 +484,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	test_stop_dequeue = 1;
+	uatomic_store(&test_stop_dequeue, 1, CMM_RELAXED);
 
 	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
 		err = pthread_join(tid_enqueuer[i_thr], &tret);
-- 
2.40.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
