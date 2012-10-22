From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH urcu] lfstack: implement test
Date: Mon, 22 Oct 2012 09:02:44 -0400
Message-ID: <20121022130244.GD30944__12176.6073666096$1350911002$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TQHeZ-000308-2I
	for lttng-dev@lists.lttng.org; Mon, 22 Oct 2012 09:02:47 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Paul McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
---
diff --git a/tests/Makefile.am b/tests/Makefile.am
index c92bbe6..df22d06 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -14,10 +14,12 @@ noinst_PROGRAMS = test_urcu test_urcu_dynamic_link test_urcu_timing \
         test_uatomic test_urcu_assign test_urcu_assign_dynamic_link \
         test_urcu_bp test_urcu_bp_dynamic_link test_cycles_per_loop \
 	test_urcu_lfq test_urcu_wfq test_urcu_lfs test_urcu_wfs \
+	test_urcu_lfs_rcu \
 	test_urcu_wfcq \
 	test_urcu_wfq_dynlink test_urcu_wfs_dynlink \
 	test_urcu_wfcq_dynlink \
-	test_urcu_lfq_dynlink test_urcu_lfs_dynlink test_urcu_hash
+	test_urcu_lfq_dynlink test_urcu_lfs_dynlink test_urcu_hash \
+	test_urcu_lfs_rcu_dynlink
 noinst_HEADERS = rcutorture.h
 
 if COMPAT_ARCH
@@ -181,10 +183,17 @@ test_urcu_wfcq_dynlink_LDADD = $(URCU_COMMON_LIB)
 test_urcu_lfs_SOURCES = test_urcu_lfs.c $(URCU)
 test_urcu_lfs_LDADD = $(URCU_CDS_LIB)
 
+test_urcu_lfs_rcu_SOURCES = test_urcu_lfs_rcu.c $(URCU)
+test_urcu_lfs_rcu_LDADD = $(URCU_CDS_LIB)
+
 test_urcu_lfs_dynlink_SOURCES = test_urcu_lfs.c $(URCU)
 test_urcu_lfs_dynlink_CFLAGS = -DDYNAMIC_LINK_TEST $(AM_CFLAGS)
 test_urcu_lfs_dynlink_LDADD = $(URCU_CDS_LIB)
 
+test_urcu_lfs_rcu_dynlink_SOURCES = test_urcu_lfs_rcu.c $(URCU)
+test_urcu_lfs_rcu_dynlink_CFLAGS = -DDYNAMIC_LINK_TEST $(AM_CFLAGS)
+test_urcu_lfs_rcu_dynlink_LDADD = $(URCU_CDS_LIB)
+
 test_urcu_wfs_SOURCES = test_urcu_wfs.c $(COMPAT)
 test_urcu_wfs_LDADD = $(URCU_COMMON_LIB)
 
diff --git a/tests/test_urcu_lfs.c b/tests/test_urcu_lfs.c
index 61abaad..e15c677 100644
--- a/tests/test_urcu_lfs.c
+++ b/tests/test_urcu_lfs.c
@@ -1,9 +1,9 @@
 /*
  * test_urcu_lfs.c
  *
- * Userspace RCU library - example RCU-based lock-free stack
+ * Userspace RCU library - example lock-free stack
  *
- * Copyright February 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  * Copyright February 2010 - Paolo Bonzini <pbonzini@redhat.com>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -158,11 +158,11 @@ static unsigned int nr_enqueuers;
 static unsigned int nr_dequeuers;
 
 struct test {
-	struct cds_lfs_node_rcu list;
+	struct cds_lfs_node list;
 	struct rcu_head rcu;
 };
 
-static struct cds_lfs_stack_rcu s;
+static struct cds_lfs_stack s;
 
 void *thr_enqueuer(void *_count)
 {
@@ -184,9 +184,8 @@ void *thr_enqueuer(void *_count)
 		struct test *node = malloc(sizeof(*node));
 		if (!node)
 			goto fail;
-		cds_lfs_node_init_rcu(&node->list);
-		/* No rcu read-side is needed for push */
-		cds_lfs_push_rcu(&s, &node->list);
+		cds_lfs_node_init(&node->list);
+		cds_lfs_push(&s, &node->list);
 		URCU_TLS(nr_successful_enqueues)++;
 
 		if (caa_unlikely(wdelay))
@@ -234,10 +233,10 @@ void *thr_dequeuer(void *_count)
 	cmm_smp_mb();
 
 	for (;;) {
-		struct cds_lfs_node_rcu *snode;
+		struct cds_lfs_node *snode;
 
 		rcu_read_lock();
-		snode = cds_lfs_pop_rcu(&s);
+		snode = cds_lfs_pop(&s);
 		rcu_read_unlock();
 		if (snode) {
 			struct test *node;
@@ -264,12 +263,12 @@ void *thr_dequeuer(void *_count)
 	return ((void*)2);
 }
 
-void test_end(struct cds_lfs_stack_rcu *s, unsigned long long *nr_dequeues)
+void test_end(struct cds_lfs_stack *s, unsigned long long *nr_dequeues)
 {
-	struct cds_lfs_node_rcu *snode;
+	struct cds_lfs_node *snode;
 
 	do {
-		snode = cds_lfs_pop_rcu(s);
+		snode = cds_lfs_pop(s);
 		if (snode) {
 			struct test *node;
 
@@ -371,7 +370,7 @@ int main(int argc, char **argv)
 	tid_dequeuer = malloc(sizeof(*tid_dequeuer) * nr_dequeuers);
 	count_enqueuer = malloc(2 * sizeof(*count_enqueuer) * nr_enqueuers);
 	count_dequeuer = malloc(2 * sizeof(*count_dequeuer) * nr_dequeuers);
-	cds_lfs_init_rcu(&s);
+	cds_lfs_init(&s);
 	err = create_all_cpu_call_rcu_data(0);
 	if (err) {
 		printf("Per-CPU call_rcu() worker threads unavailable. Using default global worker thread.\n");
diff --git a/tests/test_urcu_lfs_rcu.c b/tests/test_urcu_lfs_rcu.c
new file mode 100644
index 0000000..d1e0ee9
--- /dev/null
+++ b/tests/test_urcu_lfs_rcu.c
@@ -0,0 +1,451 @@
+/*
+ * test_urcu_lfs_rcu.c
+ *
+ * Userspace RCU library - example RCU-based lock-free stack
+ *
+ * Copyright February 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright February 2010 - Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#define _GNU_SOURCE
+#include "../config.h"
+#include <stdio.h>
+#include <pthread.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <assert.h>
+#include <sched.h>
+#include <errno.h>
+
+#include <urcu/arch.h>
+#include <urcu/tls-compat.h>
+
+#ifdef __linux__
+#include <syscall.h>
+#endif
+
+/* hardcoded number of CPUs */
+#define NR_CPUS 16384
+
+#if defined(_syscall0)
+_syscall0(pid_t, gettid)
+#elif defined(__NR_gettid)
+static inline pid_t gettid(void)
+{
+	return syscall(__NR_gettid);
+}
+#else
+#warning "use pid as tid"
+static inline pid_t gettid(void)
+{
+	return getpid();
+}
+#endif
+
+#ifndef DYNAMIC_LINK_TEST
+#define _LGPL_SOURCE
+#endif
+#include <urcu.h>
+#include <urcu/cds.h>
+
+static volatile int test_go, test_stop;
+
+static unsigned long rduration;
+
+static unsigned long duration;
+
+/* read-side C.S. duration, in loops */
+static unsigned long wdelay;
+
+static inline void loop_sleep(unsigned long loops)
+{
+	while (loops-- != 0)
+		caa_cpu_relax();
+}
+
+static int verbose_mode;
+
+#define printf_verbose(fmt, args...)		\
+	do {					\
+		if (verbose_mode)		\
+			printf(fmt, args);	\
+	} while (0)
+
+static unsigned int cpu_affinities[NR_CPUS];
+static unsigned int next_aff = 0;
+static int use_affinity = 0;
+
+pthread_mutex_t affinity_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+#ifndef HAVE_CPU_SET_T
+typedef unsigned long cpu_set_t;
+# define CPU_ZERO(cpuset) do { *(cpuset) = 0; } while(0)
+# define CPU_SET(cpu, cpuset) do { *(cpuset) |= (1UL << (cpu)); } while(0)
+#endif
+
+static void set_affinity(void)
+{
+	cpu_set_t mask;
+	int cpu;
+	int ret;
+
+	if (!use_affinity)
+		return;
+
+#if HAVE_SCHED_SETAFFINITY
+	ret = pthread_mutex_lock(&affinity_mutex);
+	if (ret) {
+		perror("Error in pthread mutex lock");
+		exit(-1);
+	}
+	cpu = cpu_affinities[next_aff++];
+	ret = pthread_mutex_unlock(&affinity_mutex);
+	if (ret) {
+		perror("Error in pthread mutex unlock");
+		exit(-1);
+	}
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+#if SCHED_SETAFFINITY_ARGS == 2
+	sched_setaffinity(0, &mask);
+#else
+	sched_setaffinity(0, sizeof(mask), &mask);
+#endif
+#endif /* HAVE_SCHED_SETAFFINITY */
+}
+
+/*
+ * returns 0 if test should end.
+ */
+static int test_duration_dequeue(void)
+{
+	return !test_stop;
+}
+
+static int test_duration_enqueue(void)
+{
+	return !test_stop;
+}
+
+static DEFINE_URCU_TLS(unsigned long long, nr_dequeues);
+static DEFINE_URCU_TLS(unsigned long long, nr_enqueues);
+
+static DEFINE_URCU_TLS(unsigned long long, nr_successful_dequeues);
+static DEFINE_URCU_TLS(unsigned long long, nr_successful_enqueues);
+
+static unsigned int nr_enqueuers;
+static unsigned int nr_dequeuers;
+
+struct test {
+	struct cds_lfs_node_rcu list;
+	struct rcu_head rcu;
+};
+
+static struct cds_lfs_stack_rcu s;
+
+void *thr_enqueuer(void *_count)
+{
+	unsigned long long *count = _count;
+
+	printf_verbose("thread_begin %s, thread id : %lx, tid %lu\n",
+			"enqueuer", pthread_self(), (unsigned long)gettid());
+
+	set_affinity();
+
+	rcu_register_thread();
+
+	while (!test_go)
+	{
+	}
+	cmm_smp_mb();
+
+	for (;;) {
+		struct test *node = malloc(sizeof(*node));
+		if (!node)
+			goto fail;
+		cds_lfs_node_init_rcu(&node->list);
+		/* No rcu read-side is needed for push */
+		cds_lfs_push_rcu(&s, &node->list);
+		URCU_TLS(nr_successful_enqueues)++;
+
+		if (caa_unlikely(wdelay))
+			loop_sleep(wdelay);
+fail:
+		URCU_TLS(nr_enqueues)++;
+		if (caa_unlikely(!test_duration_enqueue()))
+			break;
+	}
+
+	rcu_unregister_thread();
+
+	count[0] = URCU_TLS(nr_enqueues);
+	count[1] = URCU_TLS(nr_successful_enqueues);
+	printf_verbose("enqueuer thread_end, thread id : %lx, tid %lu, "
+		       "enqueues %llu successful_enqueues %llu\n",
+		       pthread_self(), (unsigned long)gettid(),
+		       URCU_TLS(nr_enqueues), URCU_TLS(nr_successful_enqueues));
+	return ((void*)1);
+
+}
+
+static
+void free_node_cb(struct rcu_head *head)
+{
+	struct test *node =
+		caa_container_of(head, struct test, rcu);
+	free(node);
+}
+
+void *thr_dequeuer(void *_count)
+{
+	unsigned long long *count = _count;
+
+	printf_verbose("thread_begin %s, thread id : %lx, tid %lu\n",
+			"dequeuer", pthread_self(), (unsigned long)gettid());
+
+	set_affinity();
+
+	rcu_register_thread();
+
+	while (!test_go)
+	{
+	}
+	cmm_smp_mb();
+
+	for (;;) {
+		struct cds_lfs_node_rcu *snode;
+
+		rcu_read_lock();
+		snode = cds_lfs_pop_rcu(&s);
+		rcu_read_unlock();
+		if (snode) {
+			struct test *node;
+
+			node = caa_container_of(snode, struct test, list);
+			call_rcu(&node->rcu, free_node_cb);
+			URCU_TLS(nr_successful_dequeues)++;
+		}
+		URCU_TLS(nr_dequeues)++;
+		if (caa_unlikely(!test_duration_dequeue()))
+			break;
+		if (caa_unlikely(rduration))
+			loop_sleep(rduration);
+	}
+
+	rcu_unregister_thread();
+
+	printf_verbose("dequeuer thread_end, thread id : %lx, tid %lu, "
+		       "dequeues %llu, successful_dequeues %llu\n",
+		       pthread_self(), (unsigned long)gettid(),
+		       URCU_TLS(nr_dequeues), URCU_TLS(nr_successful_dequeues));
+	count[0] = URCU_TLS(nr_dequeues);
+	count[1] = URCU_TLS(nr_successful_dequeues);
+	return ((void*)2);
+}
+
+void test_end(struct cds_lfs_stack_rcu *s, unsigned long long *nr_dequeues)
+{
+	struct cds_lfs_node_rcu *snode;
+
+	do {
+		snode = cds_lfs_pop_rcu(s);
+		if (snode) {
+			struct test *node;
+
+			node = caa_container_of(snode, struct test, list);
+			free(node);
+			(*nr_dequeues)++;
+		}
+	} while (snode);
+}
+
+void show_usage(int argc, char **argv)
+{
+	printf("Usage : %s nr_dequeuers nr_enqueuers duration (s)", argv[0]);
+	printf(" [-d delay] (enqueuer period (in loops))");
+	printf(" [-c duration] (dequeuer period (in loops))");
+	printf(" [-v] (verbose output)");
+	printf(" [-a cpu#] [-a cpu#]... (affinity)");
+	printf("\n");
+}
+
+int main(int argc, char **argv)
+{
+	int err;
+	pthread_t *tid_enqueuer, *tid_dequeuer;
+	void *tret;
+	unsigned long long *count_enqueuer, *count_dequeuer;
+	unsigned long long tot_enqueues = 0, tot_dequeues = 0;
+	unsigned long long tot_successful_enqueues = 0,
+			   tot_successful_dequeues = 0;
+	unsigned long long end_dequeues = 0;
+	int i, a;
+
+	if (argc < 4) {
+		show_usage(argc, argv);
+		return -1;
+	}
+
+	err = sscanf(argv[1], "%u", &nr_dequeuers);
+	if (err != 1) {
+		show_usage(argc, argv);
+		return -1;
+	}
+
+	err = sscanf(argv[2], "%u", &nr_enqueuers);
+	if (err != 1) {
+		show_usage(argc, argv);
+		return -1;
+	}
+	
+	err = sscanf(argv[3], "%lu", &duration);
+	if (err != 1) {
+		show_usage(argc, argv);
+		return -1;
+	}
+
+	for (i = 4; i < argc; i++) {
+		if (argv[i][0] != '-')
+			continue;
+		switch (argv[i][1]) {
+		case 'a':
+			if (argc < i + 2) {
+				show_usage(argc, argv);
+				return -1;
+			}
+			a = atoi(argv[++i]);
+			cpu_affinities[next_aff++] = a;
+			use_affinity = 1;
+			printf_verbose("Adding CPU %d affinity\n", a);
+			break;
+		case 'c':
+			if (argc < i + 2) {
+				show_usage(argc, argv);
+				return -1;
+			}
+			rduration = atol(argv[++i]);
+			break;
+		case 'd':
+			if (argc < i + 2) {
+				show_usage(argc, argv);
+				return -1;
+			}
+			wdelay = atol(argv[++i]);
+			break;
+		case 'v':
+			verbose_mode = 1;
+			break;
+		}
+	}
+
+	printf_verbose("running test for %lu seconds, %u enqueuers, "
+		       "%u dequeuers.\n",
+		       duration, nr_enqueuers, nr_dequeuers);
+	printf_verbose("Writer delay : %lu loops.\n", rduration);
+	printf_verbose("Reader duration : %lu loops.\n", wdelay);
+	printf_verbose("thread %-6s, thread id : %lx, tid %lu\n",
+			"main", pthread_self(), (unsigned long)gettid());
+
+	tid_enqueuer = malloc(sizeof(*tid_enqueuer) * nr_enqueuers);
+	tid_dequeuer = malloc(sizeof(*tid_dequeuer) * nr_dequeuers);
+	count_enqueuer = malloc(2 * sizeof(*count_enqueuer) * nr_enqueuers);
+	count_dequeuer = malloc(2 * sizeof(*count_dequeuer) * nr_dequeuers);
+	cds_lfs_init_rcu(&s);
+	err = create_all_cpu_call_rcu_data(0);
+	if (err) {
+		printf("Per-CPU call_rcu() worker threads unavailable. Using default global worker thread.\n");
+	}
+
+	next_aff = 0;
+
+	for (i = 0; i < nr_enqueuers; i++) {
+		err = pthread_create(&tid_enqueuer[i], NULL, thr_enqueuer,
+				     &count_enqueuer[2 * i]);
+		if (err != 0)
+			exit(1);
+	}
+	for (i = 0; i < nr_dequeuers; i++) {
+		err = pthread_create(&tid_dequeuer[i], NULL, thr_dequeuer,
+				     &count_dequeuer[2 * i]);
+		if (err != 0)
+			exit(1);
+	}
+
+	cmm_smp_mb();
+
+	test_go = 1;
+
+	for (i = 0; i < duration; i++) {
+		sleep(1);
+		if (verbose_mode)
+			write (1, ".", 1);
+	}
+
+	test_stop = 1;
+
+	for (i = 0; i < nr_enqueuers; i++) {
+		err = pthread_join(tid_enqueuer[i], &tret);
+		if (err != 0)
+			exit(1);
+		tot_enqueues += count_enqueuer[2 * i];
+		tot_successful_enqueues += count_enqueuer[2 * i + 1];
+	}
+	for (i = 0; i < nr_dequeuers; i++) {
+		err = pthread_join(tid_dequeuer[i], &tret);
+		if (err != 0)
+			exit(1);
+		tot_dequeues += count_dequeuer[2 * i];
+		tot_successful_dequeues += count_dequeuer[2 * i + 1];
+	}
+	
+	test_end(&s, &end_dequeues);
+
+	printf_verbose("total number of enqueues : %llu, dequeues %llu\n",
+		       tot_enqueues, tot_dequeues);
+	printf_verbose("total number of successful enqueues : %llu, "
+		       "successful dequeues %llu\n",
+		       tot_successful_enqueues, tot_successful_dequeues);
+	printf("SUMMARY %-25s testdur %4lu nr_enqueuers %3u wdelay %6lu "
+		"nr_dequeuers %3u "
+		"rdur %6lu nr_enqueues %12llu nr_dequeues %12llu "
+		"successful enqueues %12llu successful dequeues %12llu "
+		"end_dequeues %llu nr_ops %12llu\n",
+		argv[0], duration, nr_enqueuers, wdelay,
+		nr_dequeuers, rduration, tot_enqueues, tot_dequeues,
+		tot_successful_enqueues,
+		tot_successful_dequeues, end_dequeues,
+		tot_enqueues + tot_dequeues);
+	if (tot_successful_enqueues != tot_successful_dequeues + end_dequeues)
+		printf("WARNING! Discrepancy between nr succ. enqueues %llu vs "
+		       "succ. dequeues + end dequeues %llu.\n",
+		       tot_successful_enqueues,
+		       tot_successful_dequeues + end_dequeues);
+
+	free_all_cpu_call_rcu_data();
+	free(count_enqueuer);
+	free(count_dequeuer);
+	free(tid_enqueuer);
+	free(tid_dequeuer);
+	return 0;
+}

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
