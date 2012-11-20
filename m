From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 13/16] tests: use standard malloc/free for
	synchronize_rcu()
Date: Tue, 20 Nov 2012 14:40:26 -0500
Message-ID: <1353440429-19223-14-git-send-email-mathieu.desnoyers__16371.7210213237$1353442978$gmane$org@efficios.com>
References: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1TathT-0001Oa-B0
	for lttng-dev@lists.lttng.org; Tue, 20 Nov 2012 14:41:39 -0500
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

Allows removing mutex from tests, which allow testing scalability of
concurrent synchronize_rcu() executions.

CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
CC: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tests/test_urcu.c      |   60 ++++++++---------------------------------------
 tests/test_urcu_bp.c   |   59 +++++++---------------------------------------
 tests/test_urcu_qsbr.c |   61 ++++++++----------------------------------------
 3 files changed, 29 insertions(+), 151 deletions(-)

diff --git a/tests/test_urcu.c b/tests/test_urcu.c
index 6463d67..87972aa 100644
--- a/tests/test_urcu.c
+++ b/tests/test_urcu.c
@@ -66,15 +66,11 @@ static inline pid_t gettid(void)
 #endif
 #include <urcu.h>
 
-struct test_array {
-	int a;
-};
-
 static volatile int test_go, test_stop;
 
 static unsigned long wdelay;
 
-static struct test_array *test_rcu_pointer;
+static int *test_rcu_pointer;
 
 static unsigned long duration;
 
@@ -185,43 +181,10 @@ void rcu_copy_mutex_unlock(void)
 	}
 }
 
-/*
- * malloc/free are reusing memory areas too quickly, which does not let us
- * test races appropriately. Use a large circular array for allocations.
- * ARRAY_SIZE is larger than nr_writers, and we keep the mutex across
- * both alloc and free, which insures we never run over our tail.
- */
-#define ARRAY_SIZE (1048576 * nr_writers)
-#define ARRAY_POISON 0xDEADBEEF
-static int array_index;
-static struct test_array *test_array;
-
-static struct test_array *test_array_alloc(void)
-{
-	struct test_array *ret;
-	int index;
-
-	index = array_index % ARRAY_SIZE;
-	assert(test_array[index].a == ARRAY_POISON ||
-		test_array[index].a == 0);
-	ret = &test_array[index];
-	array_index++;
-	if (array_index == ARRAY_SIZE)
-		array_index = 0;
-	return ret;
-}
-
-static void test_array_free(struct test_array *ptr)
-{
-	if (!ptr)
-		return;
-	ptr->a = ARRAY_POISON;
-}
-
 void *thr_reader(void *_count)
 {
 	unsigned long long *count = _count;
-	struct test_array *local_ptr;
+	int *local_ptr;
 
 	printf_verbose("thread_begin %s, thread id : %lx, tid %lu\n",
 			"reader", (unsigned long) pthread_self(),
@@ -241,7 +204,7 @@ void *thr_reader(void *_count)
 		local_ptr = rcu_dereference(test_rcu_pointer);
 		rcu_debug_yield_read();
 		if (local_ptr)
-			assert(local_ptr->a == 8);
+			assert(*local_ptr == 8);
 		if (caa_unlikely(rduration))
 			loop_sleep(rduration);
 		rcu_read_unlock();
@@ -267,7 +230,7 @@ void *thr_reader(void *_count)
 void *thr_writer(void *_count)
 {
 	unsigned long long *count = _count;
-	struct test_array *new, *old;
+	int *new, *old;
 
 	printf_verbose("thread_begin %s, thread id : %lx, tid %lu\n",
 			"writer", (unsigned long) pthread_self(),
@@ -281,17 +244,16 @@ void *thr_writer(void *_count)
 	cmm_smp_mb();
 
 	for (;;) {
-		rcu_copy_mutex_lock();
-		new = test_array_alloc();
-		new->a = 8;
+		new = malloc(sizeof(int));
+		assert(new);
+		*new = 8;
 		old = rcu_xchg_pointer(&test_rcu_pointer, new);
 		if (caa_unlikely(wduration))
 			loop_sleep(wduration);
 		synchronize_rcu();
 		if (old)
-			old->a = 0;
-		test_array_free(old);
-		rcu_copy_mutex_unlock();
+			*old = 0;
+		free(old);
 		URCU_TLS(nr_writes)++;
 		if (caa_unlikely(!test_duration_write()))
 			break;
@@ -409,7 +371,6 @@ int main(int argc, char **argv)
 			"main", (unsigned long) pthread_self(),
 			(unsigned long)gettid());
 
-	test_array = calloc(1, sizeof(*test_array) * ARRAY_SIZE);
 	tid_reader = malloc(sizeof(*tid_reader) * nr_readers);
 	tid_writer = malloc(sizeof(*tid_writer) * nr_writers);
 	count_reader = malloc(sizeof(*count_reader) * nr_readers);
@@ -459,8 +420,7 @@ int main(int argc, char **argv)
 		argv[0], duration, nr_readers, rduration, wduration,
 		nr_writers, wdelay, tot_reads, tot_writes,
 		tot_reads + tot_writes);
-	test_array_free(test_rcu_pointer);
-	free(test_array);
+	free(test_rcu_pointer);
 	free(tid_reader);
 	free(tid_writer);
 	free(count_reader);
diff --git a/tests/test_urcu_bp.c b/tests/test_urcu_bp.c
index 7902388..58afe90 100644
--- a/tests/test_urcu_bp.c
+++ b/tests/test_urcu_bp.c
@@ -66,15 +66,11 @@ static inline pid_t gettid(void)
 #endif
 #include <urcu-bp.h>
 
-struct test_array {
-	int a;
-};
-
 static volatile int test_go, test_stop;
 
 static unsigned long wdelay;
 
-static struct test_array *test_rcu_pointer;
+static int *test_rcu_pointer;
 
 static unsigned long duration;
 
@@ -185,43 +181,10 @@ void rcu_copy_mutex_unlock(void)
 	}
 }
 
-/*
- * malloc/free are reusing memory areas too quickly, which does not let us
- * test races appropriately. Use a large circular array for allocations.
- * ARRAY_SIZE is larger than nr_writers, and we keep the mutex across
- * both alloc and free, which insures we never run over our tail.
- */
-#define ARRAY_SIZE (1048576 * nr_writers)
-#define ARRAY_POISON 0xDEADBEEF
-static int array_index;
-static struct test_array *test_array;
-
-static struct test_array *test_array_alloc(void)
-{
-	struct test_array *ret;
-	int index;
-
-	index = array_index % ARRAY_SIZE;
-	assert(test_array[index].a == ARRAY_POISON ||
-		test_array[index].a == 0);
-	ret = &test_array[index];
-	array_index++;
-	if (array_index == ARRAY_SIZE)
-		array_index = 0;
-	return ret;
-}
-
-static void test_array_free(struct test_array *ptr)
-{
-	if (!ptr)
-		return;
-	ptr->a = ARRAY_POISON;
-}
-
 void *thr_reader(void *_count)
 {
 	unsigned long long *count = _count;
-	struct test_array *local_ptr;
+	int *local_ptr;
 
 	printf_verbose("thread_begin %s, thread id : %lx, tid %lu\n",
 			"reader", (unsigned long) pthread_self(),
@@ -241,7 +204,7 @@ void *thr_reader(void *_count)
 		local_ptr = rcu_dereference(test_rcu_pointer);
 		rcu_debug_yield_read();
 		if (local_ptr)
-			assert(local_ptr->a == 8);
+			assert(*local_ptr == 8);
 		if (caa_unlikely(rduration))
 			loop_sleep(rduration);
 		rcu_read_unlock();
@@ -263,7 +226,7 @@ void *thr_reader(void *_count)
 void *thr_writer(void *_count)
 {
 	unsigned long long *count = _count;
-	struct test_array *new, *old;
+	int *new, *old;
 
 	printf_verbose("thread_begin %s, thread id : %lx, tid %lu\n",
 			"writer", (unsigned long) pthread_self(),
@@ -277,17 +240,15 @@ void *thr_writer(void *_count)
 	cmm_smp_mb();
 
 	for (;;) {
-		rcu_copy_mutex_lock();
-		new = test_array_alloc();
-		new->a = 8;
+		new = malloc(sizeof(int));
+		*new = 8;
 		old = rcu_xchg_pointer(&test_rcu_pointer, new);
 		if (caa_unlikely(wduration))
 			loop_sleep(wduration);
 		synchronize_rcu();
 		if (old)
-			old->a = 0;
-		test_array_free(old);
-		rcu_copy_mutex_unlock();
+			*old = 0;
+		free(old);
 		URCU_TLS(nr_writes)++;
 		if (caa_unlikely(!test_duration_write()))
 			break;
@@ -405,7 +366,6 @@ int main(int argc, char **argv)
 			"main", (unsigned long) pthread_self(),
 			(unsigned long) gettid());
 
-	test_array = calloc(1, sizeof(*test_array) * ARRAY_SIZE);
 	tid_reader = malloc(sizeof(*tid_reader) * nr_readers);
 	tid_writer = malloc(sizeof(*tid_writer) * nr_writers);
 	count_reader = malloc(sizeof(*count_reader) * nr_readers);
@@ -455,8 +415,7 @@ int main(int argc, char **argv)
 		argv[0], duration, nr_readers, rduration, wduration,
 		nr_writers, wdelay, tot_reads, tot_writes,
 		tot_reads + tot_writes);
-	test_array_free(test_rcu_pointer);
-	free(test_array);
+	free(test_rcu_pointer);
 	free(tid_reader);
 	free(tid_writer);
 	free(count_reader);
diff --git a/tests/test_urcu_qsbr.c b/tests/test_urcu_qsbr.c
index da26b77..d5d893c 100644
--- a/tests/test_urcu_qsbr.c
+++ b/tests/test_urcu_qsbr.c
@@ -66,15 +66,11 @@ static inline pid_t gettid(void)
 #endif
 #include "urcu-qsbr.h"
 
-struct test_array {
-	int a;
-};
-
 static volatile int test_go, test_stop;
 
 static unsigned long wdelay;
 
-static struct test_array *test_rcu_pointer;
+static int *test_rcu_pointer;
 
 static unsigned long duration;
 
@@ -184,43 +180,10 @@ void rcu_copy_mutex_unlock(void)
 	}
 }
 
-/*
- * malloc/free are reusing memory areas too quickly, which does not let us
- * test races appropriately. Use a large circular array for allocations.
- * ARRAY_SIZE is larger than nr_writers, and we keep the mutex across
- * both alloc and free, which insures we never run over our tail.
- */
-#define ARRAY_SIZE (1048576 * nr_writers)
-#define ARRAY_POISON 0xDEADBEEF
-static int array_index;
-static struct test_array *test_array;
-
-static struct test_array *test_array_alloc(void)
-{
-	struct test_array *ret;
-	int index;
-
-	index = array_index % ARRAY_SIZE;
-	assert(test_array[index].a == ARRAY_POISON ||
-		test_array[index].a == 0);
-	ret = &test_array[index];
-	array_index++;
-	if (array_index == ARRAY_SIZE)
-		array_index = 0;
-	return ret;
-}
-
-static void test_array_free(struct test_array *ptr)
-{
-	if (!ptr)
-		return;
-	ptr->a = ARRAY_POISON;
-}
-
 void *thr_reader(void *_count)
 {
 	unsigned long long *count = _count;
-	struct test_array *local_ptr;
+	int *local_ptr;
 
 	printf_verbose("thread_begin %s, thread id : %lx, tid %lu\n",
 			"reader", (unsigned long) pthread_self(),
@@ -240,7 +203,7 @@ void *thr_reader(void *_count)
 		local_ptr = rcu_dereference(test_rcu_pointer);
 		rcu_debug_yield_read();
 		if (local_ptr)
-			assert(local_ptr->a == 8);
+			assert(*local_ptr == 8);
 		if (caa_unlikely(rduration))
 			loop_sleep(rduration);
 		rcu_read_unlock();
@@ -269,7 +232,7 @@ void *thr_reader(void *_count)
 void *thr_writer(void *_count)
 {
 	unsigned long long *count = _count;
-	struct test_array *new, *old;
+	int *new, *old;
 
 	printf_verbose("thread_begin %s, thread id : %lx, tid %lu\n",
 			"writer", (unsigned long) pthread_self(),
@@ -283,18 +246,16 @@ void *thr_writer(void *_count)
 	cmm_smp_mb();
 
 	for (;;) {
-		rcu_copy_mutex_lock();
-		new = test_array_alloc();
-		new->a = 8;
+		new = malloc(sizeof(int));
+		assert(new);
+		*new = 8;
 		old = rcu_xchg_pointer(&test_rcu_pointer, new);
 		if (caa_unlikely(wduration))
 			loop_sleep(wduration);
 		synchronize_rcu();
-		/* can be done after unlock */
 		if (old)
-			old->a = 0;
-		test_array_free(old);
-		rcu_copy_mutex_unlock();
+			*old = 0;
+		free(old);
 		URCU_TLS(nr_writes)++;
 		if (caa_unlikely(!test_duration_write()))
 			break;
@@ -412,7 +373,6 @@ int main(int argc, char **argv)
 			"main", (unsigned long) pthread_self(),
 			(unsigned long) gettid());
 
-	test_array = calloc(1, sizeof(*test_array) * ARRAY_SIZE);
 	tid_reader = malloc(sizeof(*tid_reader) * nr_readers);
 	tid_writer = malloc(sizeof(*tid_writer) * nr_writers);
 	count_reader = malloc(sizeof(*count_reader) * nr_readers);
@@ -462,8 +422,7 @@ int main(int argc, char **argv)
 		argv[0], duration, nr_readers, rduration, wduration,
 		nr_writers, wdelay, tot_reads, tot_writes,
 		tot_reads + tot_writes);
-	test_array_free(test_rcu_pointer);
-	free(test_array);
+	free(test_rcu_pointer);
 	free(tid_reader);
 	free(tid_writer);
 	free(count_reader);
-- 
1.7.10.4
