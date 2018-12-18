From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu] Cleanup: enable signed/unsigned compare
 compiler warning
Date: Tue, 18 Dec 2018 14:21:22 -0500
Message-ID: <20181218192122.12981-1-mjeanson__43124.5385822423$1545160793$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43K7Dm67y8z1708
 for <lttng-dev@lists.lttng.org>; Tue, 18 Dec 2018 14:21:44 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 148D1A6D1C
 for <lttng-dev@lists.lttng.org>; Tue, 18 Dec 2018 14:21:38 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac                                  |  2 +-
 doc/examples/rculfhash/cds_lfht_add_replace.c |  2 +-
 doc/examples/rculfhash/cds_lfht_add_unique.c  |  2 +-
 doc/examples/rculfhash/cds_lfht_del.c         |  2 +-
 .../cds_lfht_for_each_entry_duplicate.c       |  2 +-
 doc/examples/rculfhash/cds_lfht_lookup.c      |  2 +-
 src/rculfhash.c                               | 27 ++++++----
 src/urcu-utils.h                              | 14 +++++
 tests/benchmark/test_mutex.c                  | 27 +++++-----
 tests/benchmark/test_perthreadlock.c          | 31 +++++------
 tests/benchmark/test_perthreadlock_timing.c   |  4 +-
 tests/benchmark/test_rwlock.c                 | 25 ++++-----
 tests/benchmark/test_rwlock_timing.c          |  6 ++-
 tests/benchmark/test_urcu.c                   | 29 +++++-----
 tests/benchmark/test_urcu_assign.c            | 35 ++++++------
 tests/benchmark/test_urcu_bp.c                | 31 ++++++-----
 tests/benchmark/test_urcu_defer.c             | 29 +++++-----
 tests/benchmark/test_urcu_gc.c                | 54 ++++++++++---------
 tests/benchmark/test_urcu_hash.c              | 33 ++++++------
 tests/benchmark/test_urcu_lfq.c               | 36 +++++++------
 tests/benchmark/test_urcu_lfs.c               | 36 +++++++------
 tests/benchmark/test_urcu_lfs_rcu.c           | 35 ++++++------
 tests/benchmark/test_urcu_qsbr.c              | 29 +++++-----
 tests/benchmark/test_urcu_qsbr_gc.c           | 53 +++++++++---------
 tests/benchmark/test_urcu_qsbr_timing.c       |  4 +-
 tests/benchmark/test_urcu_timing.c            |  4 +-
 tests/benchmark/test_urcu_wfcq.c              | 44 +++++++--------
 tests/benchmark/test_urcu_wfq.c               | 36 +++++++------
 tests/benchmark/test_urcu_wfs.c               | 43 ++++++++-------
 29 files changed, 365 insertions(+), 312 deletions(-)

diff --git a/configure.ac b/configure.ac
index 017da5a..3879f8f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -381,7 +381,7 @@ AC_CHECK_FUNCS([sched_setaffinity],[
 AM_CPPFLAGS="-include config.h"
 AC_SUBST(AM_CPPFLAGS)
 
-AM_CFLAGS="-Wall -Wextra -Wno-unused-parameter -Wno-sign-compare $AM_CFLAGS"
+AM_CFLAGS="-Wall -Wextra -Wno-unused-parameter $AM_CFLAGS"
 AC_SUBST(AM_CFLAGS)
 
 AC_CONFIG_LINKS([
diff --git a/doc/examples/rculfhash/cds_lfht_add_replace.c b/doc/examples/rculfhash/cds_lfht_add_replace.c
index 19c3726..3b64ee0 100644
--- a/doc/examples/rculfhash/cds_lfht_add_replace.c
+++ b/doc/examples/rculfhash/cds_lfht_add_replace.c
@@ -41,7 +41,7 @@ int match(struct cds_lfht_node *ht_node, const void *_key)
 {
 	struct mynode *node =
 		caa_container_of(ht_node, struct mynode, node);
-	const unsigned int *key = _key;
+	const int *key = _key;
 
 	return *key == node->value;
 }
diff --git a/doc/examples/rculfhash/cds_lfht_add_unique.c b/doc/examples/rculfhash/cds_lfht_add_unique.c
index 6875971..23b29f2 100644
--- a/doc/examples/rculfhash/cds_lfht_add_unique.c
+++ b/doc/examples/rculfhash/cds_lfht_add_unique.c
@@ -38,7 +38,7 @@ int match(struct cds_lfht_node *ht_node, const void *_key)
 {
 	struct mynode *node =
 		caa_container_of(ht_node, struct mynode, node);
-	const unsigned int *key = _key;
+	const int *key = _key;
 
 	return *key == node->value;
 }
diff --git a/doc/examples/rculfhash/cds_lfht_del.c b/doc/examples/rculfhash/cds_lfht_del.c
index efa6d9a..f030ee1 100644
--- a/doc/examples/rculfhash/cds_lfht_del.c
+++ b/doc/examples/rculfhash/cds_lfht_del.c
@@ -37,7 +37,7 @@ int match(struct cds_lfht_node *ht_node, const void *_key)
 {
 	struct mynode *node =
 		caa_container_of(ht_node, struct mynode, node);
-	const unsigned int *key = _key;
+	const int *key = _key;
 
 	return *key == node->value;
 }
diff --git a/doc/examples/rculfhash/cds_lfht_for_each_entry_duplicate.c b/doc/examples/rculfhash/cds_lfht_for_each_entry_duplicate.c
index 9833280..a975128 100644
--- a/doc/examples/rculfhash/cds_lfht_for_each_entry_duplicate.c
+++ b/doc/examples/rculfhash/cds_lfht_for_each_entry_duplicate.c
@@ -37,7 +37,7 @@ int match(struct cds_lfht_node *ht_node, const void *_key)
 {
 	struct mynode *node =
 		caa_container_of(ht_node, struct mynode, node);
-	const unsigned int *key = _key;
+	const int *key = _key;
 
 	return *key == node->value;
 }
diff --git a/doc/examples/rculfhash/cds_lfht_lookup.c b/doc/examples/rculfhash/cds_lfht_lookup.c
index 053e6dd..de2a47f 100644
--- a/doc/examples/rculfhash/cds_lfht_lookup.c
+++ b/doc/examples/rculfhash/cds_lfht_lookup.c
@@ -37,7 +37,7 @@ int match(struct cds_lfht_node *ht_node, const void *_key)
 {
 	struct mynode *node =
 		caa_container_of(ht_node, struct mynode, node);
-	const unsigned int *key = _key;
+	const int *key = _key;
 
 	return *key == node->value;
 }
diff --git a/src/rculfhash.c b/src/rculfhash.c
index e0c5860..ff42df0 100644
--- a/src/rculfhash.c
+++ b/src/rculfhash.c
@@ -279,6 +279,7 @@
 #include <signal.h>
 #include "workqueue.h"
 #include "urcu-die.h"
+#include "urcu-utils.h"
 
 /*
  * Split-counters lazily update the global counter each 1024
@@ -711,9 +712,8 @@ int ht_get_split_count_index(unsigned long hash)
 static
 void ht_count_add(struct cds_lfht *ht, unsigned long size, unsigned long hash)
 {
-	unsigned long split_count;
+	unsigned long split_count, count;
 	int index;
-	long count;
 
 	if (caa_unlikely(!ht->split_count))
 		return;
@@ -732,7 +732,7 @@ void ht_count_add(struct cds_lfht *ht, unsigned long size, unsigned long hash)
 
 	if ((count >> CHAIN_LEN_RESIZE_THRESHOLD) < size)
 		return;
-	dbg_printf("add set global %ld\n", count);
+	dbg_printf("add set global %lu\n", count);
 	cds_lfht_resize_lazy_count(ht, size,
 		count >> (CHAIN_LEN_TARGET - 1));
 }
@@ -740,9 +740,8 @@ void ht_count_add(struct cds_lfht *ht, unsigned long size, unsigned long hash)
 static
 void ht_count_del(struct cds_lfht *ht, unsigned long size, unsigned long hash)
 {
-	unsigned long split_count;
+	unsigned long split_count, count;
 	int index;
-	long count;
 
 	if (caa_unlikely(!ht->split_count))
 		return;
@@ -1247,8 +1246,8 @@ void partition_resize_helper(struct cds_lfht *ht, unsigned long i,
 {
 	unsigned long partition_len, start = 0;
 	struct partition_resize_work *work;
-	int thread, ret;
-	unsigned long nr_threads;
+	int ret;
+	unsigned long thread, nr_threads;
 
 	assert(nr_cpus_mask != -1);
 	if (nr_cpus_mask < 0 || len < 2 * MIN_PARTITION_PER_THREAD)
@@ -1260,7 +1259,7 @@ void partition_resize_helper(struct cds_lfht *ht, unsigned long i,
 	 * partition size, up to the number of CPUs in the system.
 	 */
 	if (nr_cpus_mask > 0) {
-		nr_threads = min(nr_cpus_mask + 1,
+		nr_threads = min_t(unsigned long, nr_cpus_mask + 1,
 				 len >> MIN_PARTITION_PER_THREAD_ORDER);
 	} else {
 		nr_threads = 1;
@@ -1449,8 +1448,7 @@ static
 void fini_table(struct cds_lfht *ht,
 		unsigned long first_order, unsigned long last_order)
 {
-	long i;
-	unsigned long free_by_rcu_order = 0;
+	unsigned long free_by_rcu_order = 0, i;
 
 	dbg_printf("fini table: first_order %lu last_order %lu\n",
 		   first_order, last_order);
@@ -1499,11 +1497,15 @@ void fini_table(struct cds_lfht *ht,
 	}
 }
 
+/*
+ * Never called with size < 1.
+ */
 static
 void cds_lfht_create_bucket(struct cds_lfht *ht, unsigned long size)
 {
 	struct cds_lfht_node *prev, *node;
 	unsigned long order, len, i;
+	int bucket_order;
 
 	cds_lfht_alloc_bucket_table(ht, 0);
 
@@ -1512,7 +1514,10 @@ void cds_lfht_create_bucket(struct cds_lfht *ht, unsigned long size)
 	node->next = flag_bucket(get_end());
 	node->reverse_hash = 0;
 
-	for (order = 1; order < cds_lfht_get_count_order_ulong(size) + 1; order++) {
+	bucket_order = cds_lfht_get_count_order_ulong(size);
+	assert(bucket_order >= 0);
+
+	for (order = 1; order < (unsigned long) bucket_order + 1; order++) {
 		len = 1UL << (order - 1);
 		cds_lfht_alloc_bucket_table(ht, order);
 
diff --git a/src/urcu-utils.h b/src/urcu-utils.h
index eab6212..407f42e 100644
--- a/src/urcu-utils.h
+++ b/src/urcu-utils.h
@@ -26,6 +26,20 @@
 #define urcu_stringify(a) _urcu_stringify(a)
 #define _urcu_stringify(a) #a
 
+#define max_t(type, x, y)				\
+	({						\
+		type __max1 = (x);              	\
+		type __max2 = (y);              	\
+		__max1 > __max2 ? __max1: __max2;	\
+	})
+
+#define min_t(type, x, y)				\
+	({						\
+		type __min1 = (x);              	\
+		type __min2 = (y);              	\
+		__min1 <= __min2 ? __min1: __min2;	\
+	})
+
 /* There is no concept of symbol aliases on MacOS */
 #ifdef __APPLE__
 #define URCU_ATTR_ALIAS(x)
diff --git a/tests/benchmark/test_mutex.c b/tests/benchmark/test_mutex.c
index 049913c..19eb7c4 100644
--- a/tests/benchmark/test_mutex.c
+++ b/tests/benchmark/test_mutex.c
@@ -252,6 +252,7 @@ int main(int argc, char **argv)
 	unsigned long long *count_reader, *count_writer;
 	unsigned long long tot_reads = 0, tot_writes = 0;
 	int i, a;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -270,7 +271,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -334,15 +335,15 @@ int main(int argc, char **argv)
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_create(&tid_reader[i], NULL, thr_reader,
-				     (void *)(long)i);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_create(&tid_reader[i_thr], NULL, thr_reader,
+				     (void *)(long)i_thr);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_create(&tid_writer[i], NULL, thr_writer,
-				     (void *)(long)i);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_create(&tid_writer[i_thr], NULL, thr_writer,
+				     (void *)(long)i_thr);
 		if (err != 0)
 			exit(1);
 	}
@@ -355,17 +356,17 @@ int main(int argc, char **argv)
 
 	test_stop = 1;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_join(tid_reader[i], &tret);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_join(tid_reader[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_reads += tot_nr_reads[i];
+		tot_reads += tot_nr_reads[i_thr];
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_join(tid_writer[i], &tret);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_join(tid_writer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_writes += tot_nr_writes[i];
+		tot_writes += tot_nr_writes[i_thr];
 	}
 
 	printf_verbose("total number of reads : %llu, writes %llu\n", tot_reads,
diff --git a/tests/benchmark/test_perthreadlock.c b/tests/benchmark/test_perthreadlock.c
index 86476a0..512b1fc 100644
--- a/tests/benchmark/test_perthreadlock.c
+++ b/tests/benchmark/test_perthreadlock.c
@@ -263,6 +263,7 @@ int main(int argc, char **argv)
 	void *tret;
 	unsigned long long tot_reads = 0, tot_writes = 0;
 	int i, a;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -281,7 +282,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -341,21 +342,21 @@ int main(int argc, char **argv)
 	tot_nr_reads = calloc(nr_readers, sizeof(*tot_nr_reads));
 	tot_nr_writes = calloc(nr_writers, sizeof(*tot_nr_writes));
 	per_thread_lock = calloc(nr_readers, sizeof(*per_thread_lock));
-	for (i = 0; i < nr_readers; i++) {
-		pthread_mutex_init(&per_thread_lock[i].lock, NULL);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		pthread_mutex_init(&per_thread_lock[i_thr].lock, NULL);
 	}
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_create(&tid_reader[i], NULL, thr_reader,
-				     (void *)(long)i);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_create(&tid_reader[i_thr], NULL, thr_reader,
+				     (void *)(long)i_thr);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_create(&tid_writer[i], NULL, thr_writer,
-				     (void *)(long)i);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_create(&tid_writer[i_thr], NULL, thr_writer,
+				     (void *)(long)i_thr);
 		if (err != 0)
 			exit(1);
 	}
@@ -368,17 +369,17 @@ int main(int argc, char **argv)
 
 	test_stop = 1;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_join(tid_reader[i], &tret);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_join(tid_reader[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_reads += tot_nr_reads[i];
+		tot_reads += tot_nr_reads[i_thr];
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_join(tid_writer[i], &tret);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_join(tid_writer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_writes += tot_nr_writes[i];
+		tot_writes += tot_nr_writes[i_thr];
 	}
 
 	printf_verbose("total number of reads : %llu, writes %llu\n", tot_reads,
diff --git a/tests/benchmark/test_perthreadlock_timing.c b/tests/benchmark/test_perthreadlock_timing.c
index c9cc65f..c1cd567 100644
--- a/tests/benchmark/test_perthreadlock_timing.c
+++ b/tests/benchmark/test_perthreadlock_timing.c
@@ -69,7 +69,7 @@ static caa_cycles_t __attribute__((aligned(CAA_CACHE_LINE_SIZE))) *writer_time;
 
 void *thr_reader(void *arg)
 {
-	int i, j;
+	unsigned int i, j;
 	caa_cycles_t time1, time2;
 	long tidx = (long)arg;
 
@@ -98,7 +98,7 @@ void *thr_reader(void *arg)
 
 void *thr_writer(void *arg)
 {
-	int i, j;
+	unsigned int i, j;
 	long tidx;
 	caa_cycles_t time1, time2;
 
diff --git a/tests/benchmark/test_rwlock.c b/tests/benchmark/test_rwlock.c
index 827c117..4628080 100644
--- a/tests/benchmark/test_rwlock.c
+++ b/tests/benchmark/test_rwlock.c
@@ -277,6 +277,7 @@ int main(int argc, char **argv)
 	unsigned long long *count_reader, *count_writer;
 	unsigned long long tot_reads = 0, tot_writes = 0;
 	int i, a;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -364,15 +365,15 @@ int main(int argc, char **argv)
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_create(&tid_reader[i], NULL, thr_reader,
-				     &count_reader[i]);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_create(&tid_reader[i_thr], NULL, thr_reader,
+				     &count_reader[i_thr]);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_create(&tid_writer[i], NULL, thr_writer,
-				     &count_writer[i]);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_create(&tid_writer[i_thr], NULL, thr_writer,
+				     &count_writer[i_thr]);
 		if (err != 0)
 			exit(1);
 	}
@@ -385,17 +386,17 @@ int main(int argc, char **argv)
 
 	test_stop = 1;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_join(tid_reader[i], &tret);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_join(tid_reader[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_reads += count_reader[i];
+		tot_reads += count_reader[i_thr];
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_join(tid_writer[i], &tret);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_join(tid_writer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_writes += count_writer[i];
+		tot_writes += count_writer[i_thr];
 	}
 
 	printf_verbose("total number of reads : %llu, writes %llu\n", tot_reads,
diff --git a/tests/benchmark/test_rwlock_timing.c b/tests/benchmark/test_rwlock_timing.c
index bc51c45..0cc5253 100644
--- a/tests/benchmark/test_rwlock_timing.c
+++ b/tests/benchmark/test_rwlock_timing.c
@@ -69,7 +69,8 @@ static caa_cycles_t __attribute__((aligned(CAA_CACHE_LINE_SIZE))) *writer_time;
 
 void *thr_reader(void *arg)
 {
-	int i, j, ret;
+	unsigned int i, j;
+	int ret;
 	caa_cycles_t time1, time2;
 
 	printf("thread_begin %s, tid %lu\n",
@@ -107,7 +108,8 @@ void *thr_reader(void *arg)
 
 void *thr_writer(void *arg)
 {
-	int i, j, ret;
+	unsigned int i, j;
+	int ret;
 	caa_cycles_t time1, time2;
 
 	printf("thread_begin %s, tid %lu\n",
diff --git a/tests/benchmark/test_urcu.c b/tests/benchmark/test_urcu.c
index 5670d1e..24758a7 100644
--- a/tests/benchmark/test_urcu.c
+++ b/tests/benchmark/test_urcu.c
@@ -261,6 +261,7 @@ int main(int argc, char **argv)
 	unsigned long long *count_reader, *count_writer;
 	unsigned long long tot_reads = 0, tot_writes = 0;
 	int i, a;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -278,7 +279,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -346,15 +347,15 @@ int main(int argc, char **argv)
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_create(&tid_reader[i], NULL, thr_reader,
-				     &count_reader[i]);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_create(&tid_reader[i_thr], NULL, thr_reader,
+				     &count_reader[i_thr]);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_create(&tid_writer[i], NULL, thr_writer,
-				     &count_writer[i]);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_create(&tid_writer[i_thr], NULL, thr_writer,
+				     &count_writer[i_thr]);
 		if (err != 0)
 			exit(1);
 	}
@@ -367,19 +368,19 @@ int main(int argc, char **argv)
 
 	test_stop = 1;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_join(tid_reader[i], &tret);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_join(tid_reader[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_reads += count_reader[i];
+		tot_reads += count_reader[i_thr];
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_join(tid_writer[i], &tret);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_join(tid_writer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_writes += count_writer[i];
+		tot_writes += count_writer[i_thr];
 	}
-	
+
 	printf_verbose("total number of reads : %llu, writes %llu\n", tot_reads,
 	       tot_writes);
 	printf("SUMMARY %-25s testdur %4lu nr_readers %3u rdur %6lu wdur %6lu "
diff --git a/tests/benchmark/test_urcu_assign.c b/tests/benchmark/test_urcu_assign.c
index fe34af3..eaa04b3 100644
--- a/tests/benchmark/test_urcu_assign.c
+++ b/tests/benchmark/test_urcu_assign.c
@@ -165,8 +165,8 @@ void rcu_copy_mutex_unlock(void)
  * both alloc and free, which insures we never run over our tail.
  */
 #define ARRAY_SIZE (1048576 * nr_writers)
-#define ARRAY_POISON 0xDEADBEEF
-static int array_index;
+#define ARRAY_POISON (int) 0xDEADBEEF
+static unsigned int array_index;
 static struct test_array *test_array;
 
 static struct test_array *test_array_alloc(void)
@@ -294,6 +294,7 @@ int main(int argc, char **argv)
 	unsigned long long *count_reader, *count_writer;
 	unsigned long long tot_reads = 0, tot_writes = 0;
 	int i, a;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -311,7 +312,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -380,15 +381,15 @@ int main(int argc, char **argv)
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_create(&tid_reader[i], NULL, thr_reader,
-				     &count_reader[i]);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_create(&tid_reader[i_thr], NULL, thr_reader,
+				     &count_reader[i_thr]);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_create(&tid_writer[i], NULL, thr_writer,
-				     &count_writer[i]);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_create(&tid_writer[i_thr], NULL, thr_writer,
+				     &count_writer[i_thr]);
 		if (err != 0)
 			exit(1);
 	}
@@ -401,19 +402,19 @@ int main(int argc, char **argv)
 
 	test_stop = 1;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_join(tid_reader[i], &tret);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_join(tid_reader[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_reads += count_reader[i];
+		tot_reads += count_reader[i_thr];
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_join(tid_writer[i], &tret);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_join(tid_writer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_writes += count_writer[i];
+		tot_writes += count_writer[i_thr];
 	}
-	
+
 	printf_verbose("total number of reads : %llu, writes %llu\n", tot_reads,
 	       tot_writes);
 	printf("SUMMARY %-25s testdur %4lu nr_readers %3u rdur %6lu wdur %6lu "
@@ -422,11 +423,13 @@ int main(int argc, char **argv)
 		argv[0], duration, nr_readers, rduration, wduration,
 		nr_writers, wdelay, tot_reads, tot_writes,
 		tot_reads + tot_writes);
+
 	test_array_free(test_rcu_pointer);
 	free(test_array);
 	free(tid_reader);
 	free(tid_writer);
 	free(count_reader);
 	free(count_writer);
+
 	return 0;
 }
diff --git a/tests/benchmark/test_urcu_bp.c b/tests/benchmark/test_urcu_bp.c
index 52b0a2a..86b0b02 100644
--- a/tests/benchmark/test_urcu_bp.c
+++ b/tests/benchmark/test_urcu_bp.c
@@ -256,6 +256,7 @@ int main(int argc, char **argv)
 	unsigned long long *count_reader, *count_writer;
 	unsigned long long tot_reads = 0, tot_writes = 0;
 	int i, a;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -273,7 +274,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -341,15 +342,15 @@ int main(int argc, char **argv)
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_create(&tid_reader[i], NULL, thr_reader,
-				     &count_reader[i]);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_create(&tid_reader[i_thr], NULL, thr_reader,
+				     &count_reader[i_thr]);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_create(&tid_writer[i], NULL, thr_writer,
-				     &count_writer[i]);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_create(&tid_writer[i_thr], NULL, thr_writer,
+				     &count_writer[i_thr]);
 		if (err != 0)
 			exit(1);
 	}
@@ -362,19 +363,19 @@ int main(int argc, char **argv)
 
 	test_stop = 1;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_join(tid_reader[i], &tret);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_join(tid_reader[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_reads += count_reader[i];
+		tot_reads += count_reader[i_thr];
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_join(tid_writer[i], &tret);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_join(tid_writer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_writes += count_writer[i];
+		tot_writes += count_writer[i_thr];
 	}
-	
+
 	printf_verbose("total number of reads : %llu, writes %llu\n", tot_reads,
 	       tot_writes);
 	printf("SUMMARY %-25s testdur %4lu nr_readers %3u rdur %6lu wdur %6lu "
@@ -383,10 +384,12 @@ int main(int argc, char **argv)
 		argv[0], duration, nr_readers, rduration, wduration,
 		nr_writers, wdelay, tot_reads, tot_writes,
 		tot_reads + tot_writes);
+
 	free(test_rcu_pointer);
 	free(tid_reader);
 	free(tid_writer);
 	free(count_reader);
 	free(count_writer);
+
 	return 0;
 }
diff --git a/tests/benchmark/test_urcu_defer.c b/tests/benchmark/test_urcu_defer.c
index 0a49641..df8e335 100644
--- a/tests/benchmark/test_urcu_defer.c
+++ b/tests/benchmark/test_urcu_defer.c
@@ -283,6 +283,7 @@ int main(int argc, char **argv)
 	unsigned long long *count_reader;
 	unsigned long long tot_reads = 0, tot_writes = 0;
 	int i, a;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -300,7 +301,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -368,15 +369,15 @@ int main(int argc, char **argv)
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_create(&tid_reader[i], NULL, thr_reader,
-				     &count_reader[i]);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_create(&tid_reader[i_thr], NULL, thr_reader,
+				     &count_reader[i_thr]);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_create(&tid_writer[i], NULL, thr_writer,
-				     (void *)(long)i);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_create(&tid_writer[i_thr], NULL, thr_writer,
+				     (void *)(long)i_thr);
 		if (err != 0)
 			exit(1);
 	}
@@ -389,19 +390,19 @@ int main(int argc, char **argv)
 
 	test_stop = 1;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_join(tid_reader[i], &tret);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_join(tid_reader[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_reads += count_reader[i];
+		tot_reads += count_reader[i_thr];
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_join(tid_writer[i], &tret);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_join(tid_writer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_writes += tot_nr_writes[i];
+		tot_writes += tot_nr_writes[i_thr];
 	}
-	
+
 	printf_verbose("total number of reads : %llu, writes %llu\n", tot_reads,
 	       tot_writes);
 	printf("SUMMARY %-25s testdur %4lu nr_readers %3u rdur %6lu wdur %6lu "
diff --git a/tests/benchmark/test_urcu_gc.c b/tests/benchmark/test_urcu_gc.c
index 0d8e9a4..1e50e4c 100644
--- a/tests/benchmark/test_urcu_gc.c
+++ b/tests/benchmark/test_urcu_gc.c
@@ -304,6 +304,7 @@ int main(int argc, char **argv)
 	unsigned long long *count_reader;
 	unsigned long long tot_reads = 0, tot_writes = 0;
 	int i, a;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -321,7 +322,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -394,28 +395,29 @@ int main(int argc, char **argv)
 	count_reader = calloc(nr_readers, sizeof(*count_reader));
 	tot_nr_writes = calloc(nr_writers, sizeof(*tot_nr_writes));
 	pending_reclaims = calloc(nr_writers, sizeof(*pending_reclaims));
-	if (reclaim_batch * sizeof(*pending_reclaims[i].queue)
+
+	if (reclaim_batch * sizeof(*pending_reclaims[0].queue)
 			< CAA_CACHE_LINE_SIZE)
-		for (i = 0; i < nr_writers; i++)
-			pending_reclaims[i].queue = calloc(1, CAA_CACHE_LINE_SIZE);
+		for (i_thr = 0; i_thr < nr_writers; i_thr++)
+			pending_reclaims[i_thr].queue = calloc(1, CAA_CACHE_LINE_SIZE);
 	else
-		for (i = 0; i < nr_writers; i++)
-			pending_reclaims[i].queue = calloc(reclaim_batch,
-					sizeof(*pending_reclaims[i].queue));
-	for (i = 0; i < nr_writers; i++)
-		pending_reclaims[i].head = pending_reclaims[i].queue;
+		for (i_thr = 0; i_thr < nr_writers; i_thr++)
+			pending_reclaims[i_thr].queue = calloc(reclaim_batch,
+					sizeof(*pending_reclaims[i_thr].queue));
+	for (i_thr = 0; i_thr < nr_writers; i_thr++)
+		pending_reclaims[i_thr].head = pending_reclaims[i_thr].queue;
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_create(&tid_reader[i], NULL, thr_reader,
-				     &count_reader[i]);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_create(&tid_reader[i_thr], NULL, thr_reader,
+				     &count_reader[i_thr]);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_create(&tid_writer[i], NULL, thr_writer,
-				     (void *)(long)i);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_create(&tid_writer[i_thr], NULL, thr_writer,
+				     (void *)(long)i_thr);
 		if (err != 0)
 			exit(1);
 	}
@@ -428,20 +430,20 @@ int main(int argc, char **argv)
 
 	test_stop = 1;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_join(tid_reader[i], &tret);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_join(tid_reader[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_reads += count_reader[i];
+		tot_reads += count_reader[i_thr];
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_join(tid_writer[i], &tret);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_join(tid_writer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_writes += tot_nr_writes[i];
-		rcu_gc_clear_queue(i);
+		tot_writes += tot_nr_writes[i_thr];
+		rcu_gc_clear_queue(i_thr);
 	}
-	
+
 	printf_verbose("total number of reads : %llu, writes %llu\n", tot_reads,
 	       tot_writes);
 	printf("SUMMARY %-25s testdur %4lu nr_readers %3u rdur %6lu wdur %6lu "
@@ -451,12 +453,14 @@ int main(int argc, char **argv)
 		argv[0], duration, nr_readers, rduration, wduration,
 		nr_writers, wdelay, tot_reads, tot_writes,
 		tot_reads + tot_writes, reclaim_batch);
+
 	free(tid_reader);
 	free(tid_writer);
 	free(count_reader);
 	free(tot_nr_writes);
-	for (i = 0; i < nr_writers; i++)
-		free(pending_reclaims[i].queue);
+
+	for (i_thr = 0; i_thr < nr_writers; i_thr++)
+		free(pending_reclaims[i_thr].queue);
 	free(pending_reclaims);
 
 	return 0;
diff --git a/tests/benchmark/test_urcu_hash.c b/tests/benchmark/test_urcu_hash.c
index 39bdcf8..376f3b1 100644
--- a/tests/benchmark/test_urcu_hash.c
+++ b/tests/benchmark/test_urcu_hash.c
@@ -309,6 +309,7 @@ int main(int argc, char **argv)
 	unsigned long count;
 	long approx_before, approx_after;
 	int i, a, ret, err, mainret = 0;
+	unsigned int i_thr;
 	struct sigaction act;
 	unsigned int remain;
 	unsigned int nr_readers_created = 0, nr_writers_created = 0;
@@ -333,7 +334,7 @@ int main(int argc, char **argv)
 		mainret = 1;
 		goto end;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -618,10 +619,10 @@ int main(int argc, char **argv)
 		goto end_close_pipe;
 	}
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_create(&tid_reader[i],
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_create(&tid_reader[i_thr],
 				     NULL, get_thr_reader_cb(),
-				     &count_reader[i]);
+				     &count_reader[i_thr]);
 		if (err != 0) {
 			errno = err;
 			mainret = 1;
@@ -630,10 +631,10 @@ int main(int argc, char **argv)
 		}
 		nr_readers_created++;
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_create(&tid_writer[i],
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_create(&tid_writer[i_thr],
 				     NULL, get_thr_writer_cb(),
-				     &count_writer[i]);
+				     &count_writer[i_thr]);
 		if (err != 0) {
 			errno = err;
 			mainret = 1;
@@ -655,26 +656,26 @@ int main(int argc, char **argv)
 	test_stop = 1;
 
 end_pthread_join:
-	for (i = 0; i < nr_readers_created; i++) {
-		err = pthread_join(tid_reader[i], &tret);
+	for (i_thr = 0; i_thr < nr_readers_created; i_thr++) {
+		err = pthread_join(tid_reader[i_thr], &tret);
 		if (err != 0) {
 			errno = err;
 			mainret = 1;
 			perror("pthread_join");
 		}
-		tot_reads += count_reader[i];
+		tot_reads += count_reader[i_thr];
 	}
-	for (i = 0; i < nr_writers_created; i++) {
-		err = pthread_join(tid_writer[i], &tret);
+	for (i_thr = 0; i_thr < nr_writers_created; i_thr++) {
+		err = pthread_join(tid_writer[i_thr], &tret);
 		if (err != 0) {
 			errno = err;
 			mainret = 1;
 			perror("pthread_join");
 		}
-		tot_writes += count_writer[i].update_ops;
-		tot_add += count_writer[i].add;
-		tot_add_exist += count_writer[i].add_exist;
-		tot_remove += count_writer[i].remove;
+		tot_writes += count_writer[i_thr].update_ops;
+		tot_add += count_writer[i_thr].add;
+		tot_add_exist += count_writer[i_thr].add_exist;
+		tot_remove += count_writer[i_thr].remove;
 	}
 
 	/* teardown counter thread */
diff --git a/tests/benchmark/test_urcu_lfq.c b/tests/benchmark/test_urcu_lfq.c
index 5ef96e6..26247b5 100644
--- a/tests/benchmark/test_urcu_lfq.c
+++ b/tests/benchmark/test_urcu_lfq.c
@@ -282,6 +282,7 @@ int main(int argc, char **argv)
 			   tot_successful_dequeues = 0;
 	unsigned long long end_dequeues = 0;
 	int i, a;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -299,7 +300,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -360,15 +361,15 @@ int main(int argc, char **argv)
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_enqueuers; i++) {
-		err = pthread_create(&tid_enqueuer[i], NULL, thr_enqueuer,
-				     &count_enqueuer[2 * i]);
+	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
+		err = pthread_create(&tid_enqueuer[i_thr], NULL, thr_enqueuer,
+				     &count_enqueuer[2 * i_thr]);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_dequeuers; i++) {
-		err = pthread_create(&tid_dequeuer[i], NULL, thr_dequeuer,
-				     &count_dequeuer[2 * i]);
+	for (i_thr = 0; i_thr < nr_dequeuers; i_thr++) {
+		err = pthread_create(&tid_dequeuer[i_thr], NULL, thr_dequeuer,
+				     &count_dequeuer[2 * i_thr]);
 		if (err != 0)
 			exit(1);
 	}
@@ -377,7 +378,7 @@ int main(int argc, char **argv)
 
 	test_go = 1;
 
-	for (i = 0; i < duration; i++) {
+	for (i_thr = 0; i_thr < duration; i_thr++) {
 		sleep(1);
 		if (verbose_mode) {
 			fwrite(".", sizeof(char), 1, stdout);
@@ -387,21 +388,21 @@ int main(int argc, char **argv)
 
 	test_stop = 1;
 
-	for (i = 0; i < nr_enqueuers; i++) {
-		err = pthread_join(tid_enqueuer[i], &tret);
+	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
+		err = pthread_join(tid_enqueuer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_enqueues += count_enqueuer[2 * i];
-		tot_successful_enqueues += count_enqueuer[2 * i + 1];
+		tot_enqueues += count_enqueuer[2 * i_thr];
+		tot_successful_enqueues += count_enqueuer[2 * i_thr + 1];
 	}
-	for (i = 0; i < nr_dequeuers; i++) {
-		err = pthread_join(tid_dequeuer[i], &tret);
+	for (i_thr = 0; i_thr < nr_dequeuers; i_thr++) {
+		err = pthread_join(tid_dequeuer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_dequeues += count_dequeuer[2 * i];
-		tot_successful_dequeues += count_dequeuer[2 * i + 1];
+		tot_dequeues += count_dequeuer[2 * i_thr];
+		tot_successful_dequeues += count_dequeuer[2 * i_thr + 1];
 	}
-	
+
 	test_end(&q, &end_dequeues);
 	err = cds_lfq_destroy_rcu(&q);
 	assert(!err);
@@ -432,5 +433,6 @@ int main(int argc, char **argv)
 	free(count_dequeuer);
 	free(tid_enqueuer);
 	free(tid_dequeuer);
+
 	return 0;
 }
diff --git a/tests/benchmark/test_urcu_lfs.c b/tests/benchmark/test_urcu_lfs.c
index 38e99bf..2f6ee25 100644
--- a/tests/benchmark/test_urcu_lfs.c
+++ b/tests/benchmark/test_urcu_lfs.c
@@ -349,6 +349,7 @@ int main(int argc, char **argv)
 			   tot_successful_dequeues = 0;
 	unsigned long long end_dequeues = 0;
 	int i, a;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -366,7 +367,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -448,15 +449,15 @@ int main(int argc, char **argv)
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_enqueuers; i++) {
-		err = pthread_create(&tid_enqueuer[i], NULL, thr_enqueuer,
-				     &count_enqueuer[2 * i]);
+	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
+		err = pthread_create(&tid_enqueuer[i_thr], NULL, thr_enqueuer,
+				     &count_enqueuer[2 * i_thr]);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_dequeuers; i++) {
-		err = pthread_create(&tid_dequeuer[i], NULL, thr_dequeuer,
-				     &count_dequeuer[2 * i]);
+	for (i_thr = 0; i_thr < nr_dequeuers; i_thr++) {
+		err = pthread_create(&tid_dequeuer[i_thr], NULL, thr_dequeuer,
+				     &count_dequeuer[2 * i_thr]);
 		if (err != 0)
 			exit(1);
 	}
@@ -465,7 +466,7 @@ int main(int argc, char **argv)
 
 	test_go = 1;
 
-	for (i = 0; i < duration; i++) {
+	for (i_thr = 0; i_thr < duration; i_thr++) {
 		sleep(1);
 		if (verbose_mode) {
 			fwrite(".", sizeof(char), 1, stdout);
@@ -475,21 +476,21 @@ int main(int argc, char **argv)
 
 	test_stop = 1;
 
-	for (i = 0; i < nr_enqueuers; i++) {
-		err = pthread_join(tid_enqueuer[i], &tret);
+	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
+		err = pthread_join(tid_enqueuer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_enqueues += count_enqueuer[2 * i];
-		tot_successful_enqueues += count_enqueuer[2 * i + 1];
+		tot_enqueues += count_enqueuer[2 * i_thr];
+		tot_successful_enqueues += count_enqueuer[2 * i_thr + 1];
 	}
-	for (i = 0; i < nr_dequeuers; i++) {
-		err = pthread_join(tid_dequeuer[i], &tret);
+	for (i_thr = 0; i_thr < nr_dequeuers; i_thr++) {
+		err = pthread_join(tid_dequeuer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_dequeues += count_dequeuer[2 * i];
-		tot_successful_dequeues += count_dequeuer[2 * i + 1];
+		tot_dequeues += count_dequeuer[2 * i_thr];
+		tot_successful_dequeues += count_dequeuer[2 * i_thr + 1];
 	}
-	
+
 	test_end(&s, &end_dequeues);
 
 	printf_verbose("total number of enqueues : %llu, dequeues %llu\n",
@@ -519,5 +520,6 @@ int main(int argc, char **argv)
 	free(count_dequeuer);
 	free(tid_enqueuer);
 	free(tid_dequeuer);
+
 	return 0;
 }
diff --git a/tests/benchmark/test_urcu_lfs_rcu.c b/tests/benchmark/test_urcu_lfs_rcu.c
index 9e0bfad..d0e80db 100644
--- a/tests/benchmark/test_urcu_lfs_rcu.c
+++ b/tests/benchmark/test_urcu_lfs_rcu.c
@@ -284,6 +284,7 @@ int main(int argc, char **argv)
 			   tot_successful_dequeues = 0;
 	unsigned long long end_dequeues = 0;
 	int i, a;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -301,7 +302,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -362,15 +363,15 @@ int main(int argc, char **argv)
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_enqueuers; i++) {
-		err = pthread_create(&tid_enqueuer[i], NULL, thr_enqueuer,
-				     &count_enqueuer[2 * i]);
+	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
+		err = pthread_create(&tid_enqueuer[i_thr], NULL, thr_enqueuer,
+				     &count_enqueuer[2 * i_thr]);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_dequeuers; i++) {
-		err = pthread_create(&tid_dequeuer[i], NULL, thr_dequeuer,
-				     &count_dequeuer[2 * i]);
+	for (i_thr = 0; i_thr < nr_dequeuers; i_thr++) {
+		err = pthread_create(&tid_dequeuer[i_thr], NULL, thr_dequeuer,
+				     &count_dequeuer[2 * i_thr]);
 		if (err != 0)
 			exit(1);
 	}
@@ -379,7 +380,7 @@ int main(int argc, char **argv)
 
 	test_go = 1;
 
-	for (i = 0; i < duration; i++) {
+	for (i_thr = 0; i_thr < duration; i_thr++) {
 		sleep(1);
 		if (verbose_mode) {
 			fwrite(".", sizeof(char), 1, stdout);
@@ -389,21 +390,21 @@ int main(int argc, char **argv)
 
 	test_stop = 1;
 
-	for (i = 0; i < nr_enqueuers; i++) {
-		err = pthread_join(tid_enqueuer[i], &tret);
+	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
+		err = pthread_join(tid_enqueuer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_enqueues += count_enqueuer[2 * i];
-		tot_successful_enqueues += count_enqueuer[2 * i + 1];
+		tot_enqueues += count_enqueuer[2 * i_thr];
+		tot_successful_enqueues += count_enqueuer[2 * i_thr + 1];
 	}
-	for (i = 0; i < nr_dequeuers; i++) {
-		err = pthread_join(tid_dequeuer[i], &tret);
+	for (i_thr = 0; i_thr < nr_dequeuers; i_thr++) {
+		err = pthread_join(tid_dequeuer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_dequeues += count_dequeuer[2 * i];
-		tot_successful_dequeues += count_dequeuer[2 * i + 1];
+		tot_dequeues += count_dequeuer[2 * i_thr];
+		tot_successful_dequeues += count_dequeuer[2 * i_thr + 1];
 	}
-	
+
 	test_end(&s, &end_dequeues);
 
 	printf_verbose("total number of enqueues : %llu, dequeues %llu\n",
diff --git a/tests/benchmark/test_urcu_qsbr.c b/tests/benchmark/test_urcu_qsbr.c
index 1fcdfb1..962476c 100644
--- a/tests/benchmark/test_urcu_qsbr.c
+++ b/tests/benchmark/test_urcu_qsbr.c
@@ -267,6 +267,7 @@ int main(int argc, char **argv)
 	unsigned long long *count_reader, *count_writer;
 	unsigned long long tot_reads = 0, tot_writes = 0;
 	int i, a;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -284,7 +285,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -352,15 +353,15 @@ int main(int argc, char **argv)
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_create(&tid_reader[i], NULL, thr_reader,
-				     &count_reader[i]);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_create(&tid_reader[i_thr], NULL, thr_reader,
+				     &count_reader[i_thr]);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_create(&tid_writer[i], NULL, thr_writer,
-				     &count_writer[i]);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_create(&tid_writer[i_thr], NULL, thr_writer,
+				     &count_writer[i_thr]);
 		if (err != 0)
 			exit(1);
 	}
@@ -373,19 +374,19 @@ int main(int argc, char **argv)
 
 	test_stop = 1;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_join(tid_reader[i], &tret);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_join(tid_reader[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_reads += count_reader[i];
+		tot_reads += count_reader[i_thr];
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_join(tid_writer[i], &tret);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_join(tid_writer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_writes += count_writer[i];
+		tot_writes += count_writer[i_thr];
 	}
-	
+
 	printf_verbose("total number of reads : %llu, writes %llu\n", tot_reads,
 	       tot_writes);
 	printf("SUMMARY %-25s testdur %4lu nr_readers %3u rdur %6lu wdur %6lu "
diff --git a/tests/benchmark/test_urcu_qsbr_gc.c b/tests/benchmark/test_urcu_qsbr_gc.c
index 7e452d9..11f0359 100644
--- a/tests/benchmark/test_urcu_qsbr_gc.c
+++ b/tests/benchmark/test_urcu_qsbr_gc.c
@@ -306,6 +306,7 @@ int main(int argc, char **argv)
 	unsigned long long *count_reader;
 	unsigned long long tot_reads = 0, tot_writes = 0;
 	int i, a;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -323,7 +324,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -396,28 +397,28 @@ int main(int argc, char **argv)
 	count_reader = calloc(nr_readers, sizeof(*count_reader));
 	tot_nr_writes = calloc(nr_writers, sizeof(*tot_nr_writes));
 	pending_reclaims = calloc(nr_writers, sizeof(*pending_reclaims));
-	if (reclaim_batch * sizeof(*pending_reclaims[i].queue)
+	if (reclaim_batch * sizeof(*pending_reclaims[0].queue)
 			< CAA_CACHE_LINE_SIZE)
-		for (i = 0; i < nr_writers; i++)
-			pending_reclaims[i].queue = calloc(1, CAA_CACHE_LINE_SIZE);
+		for (i_thr = 0; i_thr < nr_writers; i_thr++)
+			pending_reclaims[i_thr].queue = calloc(1, CAA_CACHE_LINE_SIZE);
 	else
-		for (i = 0; i < nr_writers; i++)
-			pending_reclaims[i].queue = calloc(reclaim_batch,
-					sizeof(*pending_reclaims[i].queue));
-	for (i = 0; i < nr_writers; i++)
-		pending_reclaims[i].head = pending_reclaims[i].queue;
+		for (i_thr = 0; i_thr < nr_writers; i_thr++)
+			pending_reclaims[i_thr].queue = calloc(reclaim_batch,
+					sizeof(*pending_reclaims[i_thr].queue));
+	for (i_thr = 0; i_thr < nr_writers; i_thr++)
+		pending_reclaims[i_thr].head = pending_reclaims[i_thr].queue;
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_create(&tid_reader[i], NULL, thr_reader,
-				     &count_reader[i]);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_create(&tid_reader[i_thr], NULL, thr_reader,
+				     &count_reader[i_thr]);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_create(&tid_writer[i], NULL, thr_writer,
-				     (void *)(long)i);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_create(&tid_writer[i_thr], NULL, thr_writer,
+				     (void *)(long)i_thr);
 		if (err != 0)
 			exit(1);
 	}
@@ -430,20 +431,20 @@ int main(int argc, char **argv)
 
 	test_stop = 1;
 
-	for (i = 0; i < nr_readers; i++) {
-		err = pthread_join(tid_reader[i], &tret);
+	for (i_thr = 0; i_thr < nr_readers; i_thr++) {
+		err = pthread_join(tid_reader[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_reads += count_reader[i];
+		tot_reads += count_reader[i_thr];
 	}
-	for (i = 0; i < nr_writers; i++) {
-		err = pthread_join(tid_writer[i], &tret);
+	for (i_thr = 0; i_thr < nr_writers; i_thr++) {
+		err = pthread_join(tid_writer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_writes += tot_nr_writes[i];
-		rcu_gc_clear_queue(i);
+		tot_writes += tot_nr_writes[i_thr];
+		rcu_gc_clear_queue(i_thr);
 	}
-	
+
 	printf_verbose("total number of reads : %llu, writes %llu\n", tot_reads,
 	       tot_writes);
 	printf("SUMMARY %-25s testdur %4lu nr_readers %3u rdur %6lu wdur %6lu "
@@ -453,12 +454,14 @@ int main(int argc, char **argv)
 		argv[0], duration, nr_readers, rduration, wduration,
 		nr_writers, wdelay, tot_reads, tot_writes,
 		tot_reads + tot_writes, reclaim_batch);
+
 	free(tid_reader);
 	free(tid_writer);
 	free(count_reader);
 	free(tot_nr_writes);
-	for (i = 0; i < nr_writers; i++)
-		free(pending_reclaims[i].queue);
+
+	for (i_thr = 0; i_thr < nr_writers; i_thr++)
+		free(pending_reclaims[i_thr].queue);
 	free(pending_reclaims);
 
 	return 0;
diff --git a/tests/benchmark/test_urcu_qsbr_timing.c b/tests/benchmark/test_urcu_qsbr_timing.c
index 7619390..75e6faa 100644
--- a/tests/benchmark/test_urcu_qsbr_timing.c
+++ b/tests/benchmark/test_urcu_qsbr_timing.c
@@ -85,7 +85,7 @@ static caa_cycles_t __attribute__((aligned(CAA_CACHE_LINE_SIZE))) *writer_time;
 
 void *thr_reader(void *arg)
 {
-	int i, j;
+	unsigned int i, j;
 	struct test_array *local_ptr;
 	caa_cycles_t time1, time2;
 
@@ -122,7 +122,7 @@ void *thr_reader(void *arg)
 
 void *thr_writer(void *arg)
 {
-	int i, j;
+	unsigned int i, j;
 	struct test_array *new, *old;
 	caa_cycles_t time1, time2;
 
diff --git a/tests/benchmark/test_urcu_timing.c b/tests/benchmark/test_urcu_timing.c
index d586b1d..b5f3e4a 100644
--- a/tests/benchmark/test_urcu_timing.c
+++ b/tests/benchmark/test_urcu_timing.c
@@ -85,7 +85,7 @@ static caa_cycles_t __attribute__((aligned(CAA_CACHE_LINE_SIZE))) *writer_time;
 
 void *thr_reader(void *arg)
 {
-	int i, j;
+	unsigned int i, j;
 	struct test_array *local_ptr;
 	caa_cycles_t time1, time2;
 
@@ -121,7 +121,7 @@ void *thr_reader(void *arg)
 
 void *thr_writer(void *arg)
 {
-	int i, j;
+	unsigned int i, j;
 	struct test_array *new, *old;
 	caa_cycles_t time1, time2;
 
diff --git a/tests/benchmark/test_urcu_wfcq.c b/tests/benchmark/test_urcu_wfcq.c
index 84a0d0f..6b5e933 100644
--- a/tests/benchmark/test_urcu_wfcq.c
+++ b/tests/benchmark/test_urcu_wfcq.c
@@ -75,7 +75,7 @@ static inline void loop_sleep(unsigned long loops)
 static int verbose_mode;
 
 static int test_dequeue, test_splice, test_wait_empty;
-static int test_enqueue_stopped;
+static unsigned int test_enqueue_stopped;
 
 #define printf_verbose(fmt, args...)		\
 	do {					\
@@ -357,6 +357,7 @@ int main(int argc, char **argv)
 			   tot_splice = 0, tot_dequeue_last = 0;
 	unsigned long long end_dequeues = 0;
 	int i, a, retval = 0;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -374,7 +375,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -471,15 +472,15 @@ int main(int argc, char **argv)
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_enqueuers; i++) {
-		err = pthread_create(&tid_enqueuer[i], NULL, thr_enqueuer,
-				     &count_enqueuer[3 * i]);
+	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
+		err = pthread_create(&tid_enqueuer[i_thr], NULL, thr_enqueuer,
+				     &count_enqueuer[3 * i_thr]);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_dequeuers; i++) {
-		err = pthread_create(&tid_dequeuer[i], NULL, thr_dequeuer,
-				     &count_dequeuer[4 * i]);
+	for (i_thr = 0; i_thr < nr_dequeuers; i_thr++) {
+		err = pthread_create(&tid_dequeuer[i_thr], NULL, thr_dequeuer,
+				     &count_dequeuer[4 * i_thr]);
 		if (err != 0)
 			exit(1);
 	}
@@ -488,7 +489,7 @@ int main(int argc, char **argv)
 
 	test_go = 1;
 
-	for (i = 0; i < duration; i++) {
+	for (i_thr = 0; i_thr < duration; i_thr++) {
 		sleep(1);
 		if (verbose_mode) {
 			fwrite(".", sizeof(char), 1, stdout);
@@ -509,24 +510,24 @@ int main(int argc, char **argv)
 
 	test_stop_dequeue = 1;
 
-	for (i = 0; i < nr_enqueuers; i++) {
-		err = pthread_join(tid_enqueuer[i], &tret);
+	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
+		err = pthread_join(tid_enqueuer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_enqueues += count_enqueuer[3 * i];
-		tot_successful_enqueues += count_enqueuer[3 * i + 1];
-		tot_empty_dest_enqueues += count_enqueuer[3 * i + 2];
+		tot_enqueues += count_enqueuer[3 * i_thr];
+		tot_successful_enqueues += count_enqueuer[3 * i_thr + 1];
+		tot_empty_dest_enqueues += count_enqueuer[3 * i_thr + 2];
 	}
-	for (i = 0; i < nr_dequeuers; i++) {
-		err = pthread_join(tid_dequeuer[i], &tret);
+	for (i_thr = 0; i_thr < nr_dequeuers; i_thr++) {
+		err = pthread_join(tid_dequeuer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_dequeues += count_dequeuer[4 * i];
-		tot_successful_dequeues += count_dequeuer[4 * i + 1];
-		tot_splice += count_dequeuer[4 * i + 2];
-		tot_dequeue_last += count_dequeuer[4 * i + 3];
+		tot_dequeues += count_dequeuer[4 * i_thr];
+		tot_successful_dequeues += count_dequeuer[4 * i_thr + 1];
+		tot_splice += count_dequeuer[4 * i_thr + 2];
+		tot_dequeue_last += count_dequeuer[4 * i_thr + 3];
 	}
-	
+
 	test_end(&end_dequeues, &tot_dequeue_last);
 
 	printf_verbose("total number of enqueues : %llu, dequeues %llu\n",
@@ -579,5 +580,6 @@ int main(int argc, char **argv)
 	free(count_dequeuer);
 	free(tid_enqueuer);
 	free(tid_dequeuer);
+
 	return retval;
 }
diff --git a/tests/benchmark/test_urcu_wfq.c b/tests/benchmark/test_urcu_wfq.c
index 1cf356e..7682104 100644
--- a/tests/benchmark/test_urcu_wfq.c
+++ b/tests/benchmark/test_urcu_wfq.c
@@ -254,6 +254,7 @@ int main(int argc, char **argv)
 			   tot_successful_dequeues = 0;
 	unsigned long long end_dequeues = 0;
 	int i, a;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -271,7 +272,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -328,15 +329,15 @@ int main(int argc, char **argv)
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_enqueuers; i++) {
-		err = pthread_create(&tid_enqueuer[i], NULL, thr_enqueuer,
-				     &count_enqueuer[2 * i]);
+	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
+		err = pthread_create(&tid_enqueuer[i_thr], NULL, thr_enqueuer,
+				     &count_enqueuer[2 * i_thr]);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_dequeuers; i++) {
-		err = pthread_create(&tid_dequeuer[i], NULL, thr_dequeuer,
-				     &count_dequeuer[2 * i]);
+	for (i_thr = 0; i_thr < nr_dequeuers; i_thr++) {
+		err = pthread_create(&tid_dequeuer[i_thr], NULL, thr_dequeuer,
+				     &count_dequeuer[2 * i_thr]);
 		if (err != 0)
 			exit(1);
 	}
@@ -345,7 +346,7 @@ int main(int argc, char **argv)
 
 	test_go = 1;
 
-	for (i = 0; i < duration; i++) {
+	for (i_thr = 0; i_thr < duration; i_thr++) {
 		sleep(1);
 		if (verbose_mode) {
 			fwrite(".", sizeof(char), 1, stdout);
@@ -355,21 +356,21 @@ int main(int argc, char **argv)
 
 	test_stop = 1;
 
-	for (i = 0; i < nr_enqueuers; i++) {
-		err = pthread_join(tid_enqueuer[i], &tret);
+	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
+		err = pthread_join(tid_enqueuer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_enqueues += count_enqueuer[2 * i];
-		tot_successful_enqueues += count_enqueuer[2 * i + 1];
+		tot_enqueues += count_enqueuer[2 * i_thr];
+		tot_successful_enqueues += count_enqueuer[2 * i_thr + 1];
 	}
-	for (i = 0; i < nr_dequeuers; i++) {
-		err = pthread_join(tid_dequeuer[i], &tret);
+	for (i_thr = 0; i_thr < nr_dequeuers; i_thr++) {
+		err = pthread_join(tid_dequeuer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_dequeues += count_dequeuer[2 * i];
-		tot_successful_dequeues += count_dequeuer[2 * i + 1];
+		tot_dequeues += count_dequeuer[2 * i_thr];
+		tot_successful_dequeues += count_dequeuer[2 * i_thr + 1];
 	}
-	
+
 	test_end(&q, &end_dequeues);
 
 	printf_verbose("total number of enqueues : %llu, dequeues %llu\n",
@@ -398,5 +399,6 @@ int main(int argc, char **argv)
 	free(count_dequeuer);
 	free(tid_enqueuer);
 	free(tid_dequeuer);
+
 	return 0;
 }
diff --git a/tests/benchmark/test_urcu_wfs.c b/tests/benchmark/test_urcu_wfs.c
index 266884d..2c82c01 100644
--- a/tests/benchmark/test_urcu_wfs.c
+++ b/tests/benchmark/test_urcu_wfs.c
@@ -78,7 +78,7 @@ static inline void loop_sleep(unsigned long loops)
 static int verbose_mode;
 
 static int test_pop, test_pop_all, test_wait_empty;
-static int test_enqueue_stopped;
+static unsigned int test_enqueue_stopped;
 
 #define printf_verbose(fmt, args...)		\
 	do {					\
@@ -344,6 +344,7 @@ int main(int argc, char **argv)
 			   tot_pop_all = 0, tot_pop_last = 0;
 	unsigned long long end_dequeues = 0;
 	int i, a, retval = 0;
+	unsigned int i_thr;
 
 	if (argc < 4) {
 		show_usage(argc, argv);
@@ -361,7 +362,7 @@ int main(int argc, char **argv)
 		show_usage(argc, argv);
 		return -1;
 	}
-	
+
 	err = sscanf(argv[3], "%lu", &duration);
 	if (err != 1) {
 		show_usage(argc, argv);
@@ -458,15 +459,15 @@ int main(int argc, char **argv)
 
 	next_aff = 0;
 
-	for (i = 0; i < nr_enqueuers; i++) {
+	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
 		err = pthread_create(&tid_enqueuer[i], NULL, thr_enqueuer,
-				     &count_enqueuer[3 * i]);
+				     &count_enqueuer[3 * i_thr]);
 		if (err != 0)
 			exit(1);
 	}
-	for (i = 0; i < nr_dequeuers; i++) {
-		err = pthread_create(&tid_dequeuer[i], NULL, thr_dequeuer,
-				     &count_dequeuer[4 * i]);
+	for (i_thr = 0; i_thr < nr_dequeuers; i_thr++) {
+		err = pthread_create(&tid_dequeuer[i_thr], NULL, thr_dequeuer,
+				     &count_dequeuer[4 * i_thr]);
 		if (err != 0)
 			exit(1);
 	}
@@ -475,7 +476,7 @@ int main(int argc, char **argv)
 
 	test_go = 1;
 
-	for (i = 0; i < duration; i++) {
+	for (i_thr = 0; i_thr < duration; i_thr++) {
 		sleep(1);
 		if (verbose_mode) {
 			fwrite(".", sizeof(char), 1, stdout);
@@ -496,24 +497,24 @@ int main(int argc, char **argv)
 
 	test_stop_dequeue = 1;
 
-	for (i = 0; i < nr_enqueuers; i++) {
-		err = pthread_join(tid_enqueuer[i], &tret);
+	for (i_thr = 0; i_thr < nr_enqueuers; i_thr++) {
+		err = pthread_join(tid_enqueuer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_enqueues += count_enqueuer[3 * i];
-		tot_successful_enqueues += count_enqueuer[3 * i + 1];
-		tot_empty_dest_enqueues += count_enqueuer[3 * i + 2];
+		tot_enqueues += count_enqueuer[3 * i_thr];
+		tot_successful_enqueues += count_enqueuer[3 * i_thr + 1];
+		tot_empty_dest_enqueues += count_enqueuer[3 * i_thr + 2];
 	}
-	for (i = 0; i < nr_dequeuers; i++) {
-		err = pthread_join(tid_dequeuer[i], &tret);
+	for (i_thr = 0; i_thr < nr_dequeuers; i_thr++) {
+		err = pthread_join(tid_dequeuer[i_thr], &tret);
 		if (err != 0)
 			exit(1);
-		tot_dequeues += count_dequeuer[4 * i];
-		tot_successful_dequeues += count_dequeuer[4 * i + 1];
-		tot_pop_all += count_dequeuer[4 * i + 2];
-		tot_pop_last += count_dequeuer[4 * i + 3];
+		tot_dequeues += count_dequeuer[4 * i_thr];
+		tot_successful_dequeues += count_dequeuer[4 * i_thr + 1];
+		tot_pop_all += count_dequeuer[4 * i_thr + 2];
+		tot_pop_last += count_dequeuer[4 * i_thr + 3];
 	}
-	
+
 	test_end(&s, &end_dequeues, &tot_pop_last);
 
 	printf_verbose("total number of enqueues : %llu, dequeues %llu\n",
@@ -557,10 +558,12 @@ int main(int argc, char **argv)
 			tot_pop_last);
 		retval = 1;
 	}
+
 	cds_wfs_destroy(&s);
 	free(count_enqueuer);
 	free(count_dequeuer);
 	free(tid_enqueuer);
 	free(tid_dequeuer);
+
 	return retval;
 }
-- 
2.17.1
