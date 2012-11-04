From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH urcu] Implement RCU lock free concurrent
	queue
Date: Sun, 4 Nov 2012 15:22:05 -0500
Message-ID: <20121104202205.GA28373__8260.43169149688$1352060574$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TV6hs-0004vG-Kk
	for lttng-dev@lists.lttng.org; Sun, 04 Nov 2012 15:22:09 -0500
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
Cc: rp@svcs.cs.pdx.edu, lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>
List-Id: lttng-dev@lists.lttng.org

Queue with lock-free semantic for both enqueue and dequeue. This queue
requires the RCU read-side lock to be held around enqueue and around
dequeue. This queue guarantees correct queue behavior even if a thread
using the queue dies at any point (except of course for RCU read-side
lock related issues that may arise in that case, but that is a separate
issue).

The improvement of rculfcqueue vs the existing rculfqueue: the new queue
splits head and tail into 2 different objects, so users can put them
into different cache lines, and thus eliminate false-sharing between
head and tail.

Similarly to the prior implementation, rculfcqueue dequeuer allocates
dummy nodes to deal with the empty queue scenario. The only reason why
this implementation allocates dummy nodes is because all my attempts to
come up with a portable lock-free queue design that does not require
dummy nodes have failed so far.

Besides dummy node allocation, another downside of the lock-free queue
compared to the wait-free/blocking queue is that implementing "splice"
is not straightforward, because when splicing a chain of nodes into a
destination queue, if the tail pointer update fails due to a concurrent
enqueue, then other enqueuers will have to push the tail pointer over
all nodes newly spliced in. This unpredictable delay on enqueue is not
acceptable, so no splice operation is implemented.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
---
diff --git a/Makefile.am b/Makefile.am
index 195b89a..85a9263 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -15,6 +15,7 @@ nobase_dist_include_HEADERS = urcu/compiler.h urcu/hlist.h urcu/list.h \
 		urcu/rculist.h urcu/rcuhlist.h urcu/system.h urcu/futex.h \
 		urcu/uatomic/generic.h urcu/arch/generic.h urcu/wfstack.h \
 		urcu/wfqueue.h urcu/rculfstack.h urcu/rculfqueue.h \
+		urcu/rculfcqueue.h \
 		urcu/ref.h urcu/cds.h urcu/urcu_ref.h urcu/urcu-futex.h \
 		urcu/uatomic_arch.h urcu/rculfhash.h urcu/wfcqueue.h \
 		urcu/lfstack.h \
@@ -74,6 +75,7 @@ liburcu_bp_la_SOURCES = urcu-bp.c urcu-pointer.c $(COMPAT)
 liburcu_bp_la_LIBADD = liburcu-common.la
 
 liburcu_cds_la_SOURCES = rculfqueue.c rculfstack.c lfstack.c \
+	rculfcqueue.c \
 	$(RCULFHASH) $(COMPAT)
 liburcu_cds_la_LIBADD = liburcu-common.la
 
diff --git a/tests/Makefile.am b/tests/Makefile.am
index b029377..e04b847 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -16,8 +16,10 @@ noinst_PROGRAMS = test_urcu test_urcu_dynamic_link test_urcu_timing \
 	test_urcu_lfq test_urcu_wfq test_urcu_lfs test_urcu_wfs \
 	test_urcu_lfs_rcu \
 	test_urcu_wfcq \
+	test_urcu_lfcq \
 	test_urcu_wfq_dynlink test_urcu_wfs_dynlink \
 	test_urcu_wfcq_dynlink \
+	test_urcu_lfcq_dynlink \
 	test_urcu_lfq_dynlink test_urcu_lfs_dynlink test_urcu_hash \
 	test_urcu_lfs_rcu_dynlink \
 	test_urcu_multiflavor test_urcu_multiflavor_dynlink
@@ -167,6 +169,13 @@ test_urcu_lfq_dynlink_SOURCES = test_urcu_lfq.c $(URCU)
 test_urcu_lfq_dynlink_CFLAGS = -DDYNAMIC_LINK_TEST $(AM_CFLAGS)
 test_urcu_lfq_dynlink_LDADD = $(URCU_CDS_LIB)
 
+test_urcu_lfcq_SOURCES = test_urcu_lfcq.c $(URCU)
+test_urcu_lfcq_LDADD = $(URCU_CDS_LIB)
+
+test_urcu_lfcq_dynlink_SOURCES = test_urcu_lfcq.c $(URCU)
+test_urcu_lfcq_dynlink_CFLAGS = -DDYNAMIC_LINK_TEST $(AM_CFLAGS)
+test_urcu_lfcq_dynlink_LDADD = $(URCU_CDS_LIB)
+
 test_urcu_wfq_SOURCES = test_urcu_wfq.c $(COMPAT)
 test_urcu_wfq_LDADD = $(URCU_COMMON_LIB)
 
diff --git a/tests/test_urcu_lfcq.c b/tests/test_urcu_lfcq.c
new file mode 100644
index 0000000..2058aef
--- /dev/null
+++ b/tests/test_urcu_lfcq.c
@@ -0,0 +1,463 @@
+/*
+ * test_urcu_lfcq.c
+ *
+ * Userspace RCU library - example RCU-based lock-free concurrent queue
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
+#if HAVE_SCHED_SETAFFINITY
+	cpu_set_t mask;
+	int cpu, ret;
+#endif /* HAVE_SCHED_SETAFFINITY */
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
+	struct cds_lfcq_node list;
+	struct rcu_head rcu;
+};
+
+static struct cds_lfcq_head __attribute__((aligned(CAA_CACHE_LINE_SIZE))) head;
+static struct cds_lfcq_tail __attribute__((aligned(CAA_CACHE_LINE_SIZE))) tail;
+
+static void *thr_enqueuer(void *_count)
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
+		cds_lfcq_node_init(&node->list);
+		rcu_read_lock();
+		__cds_lfcq_enqueue(&head, &tail, &node->list);
+		rcu_read_unlock();
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
+static void free_node_cb(struct rcu_head *head)
+{
+	struct test *node =
+		caa_container_of(head, struct test, rcu);
+	free(node);
+}
+
+static void *thr_dequeuer(void *_count)
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
+		struct cds_lfcq_node *qnode;
+
+		rcu_read_lock();
+		qnode = __cds_lfcq_dequeue(&head, &tail);
+		rcu_read_unlock();
+
+		if (qnode) {
+			struct test *node;
+
+			node = caa_container_of(qnode, struct test, list);
+			call_rcu(&node->rcu, free_node_cb);
+			URCU_TLS(nr_successful_dequeues)++;
+		}
+
+		URCU_TLS(nr_dequeues)++;
+		if (caa_unlikely(!test_duration_dequeue()))
+			break;
+		if (caa_unlikely(rduration))
+			loop_sleep(rduration);
+	}
+
+	rcu_unregister_thread();
+	printf_verbose("dequeuer thread_end, thread id : %lx, tid %lu, "
+		       "dequeues %llu, successful_dequeues %llu\n",
+		       pthread_self(), (unsigned long)gettid(),
+		       URCU_TLS(nr_dequeues), URCU_TLS(nr_successful_dequeues));
+	count[0] = URCU_TLS(nr_dequeues);
+	count[1] = URCU_TLS(nr_successful_dequeues);
+	return ((void*)2);
+}
+
+static void test_end(unsigned long long *nr_dequeues)
+{
+	struct cds_lfcq_node *snode;
+	int ret;
+
+	do {
+		snode = __cds_lfcq_dequeue(&head, &tail);
+		if (snode) {
+			struct test *node;
+
+			node = caa_container_of(snode, struct test, list);
+			free(node);	/* no more concurrent access */
+			(*nr_dequeues)++;
+		}
+	} while (snode);
+
+	ret = cds_lfcq_finalize(&head, &tail);
+	assert(!ret);
+}
+
+static void show_usage(int argc, char **argv)
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
+	int i, a, mainret = 0;
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
+	cds_lfcq_init(&head, &tail);
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
+	test_end(&end_dequeues);
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
+	if (tot_successful_enqueues != tot_successful_dequeues + end_dequeues) {
+		printf("WARNING! Discrepancy between nr succ. enqueues %llu vs "
+		       "succ. dequeues + end dequeues %llu.\n",
+		       tot_successful_enqueues,
+		       tot_successful_dequeues + end_dequeues);
+		mainret = 1;
+	}
+
+	free_all_cpu_call_rcu_data();
+	free(count_enqueuer);
+	free(count_dequeuer);
+	free(tid_enqueuer);
+	free(tid_dequeuer);
+	if (!mainret)
+		exit(EXIT_SUCCESS);
+	else
+		exit(EXIT_FAILURE);
+}
diff --git a/urcu/cds.h b/urcu/cds.h
index 78534bb..3976089 100644
--- a/urcu/cds.h
+++ b/urcu/cds.h
@@ -34,5 +34,6 @@
 #include <urcu/wfcqueue.h>
 #include <urcu/wfstack.h>
 #include <urcu/lfstack.h>
+#include <urcu/rculfcqueue.h>
 
 #endif /* _URCU_CDS_H */
diff --git a/urcu/rculfcqueue.h b/urcu/rculfcqueue.h
new file mode 100644
index 0000000..1eff75f
--- /dev/null
+++ b/urcu/rculfcqueue.h
@@ -0,0 +1,139 @@
+#ifndef _URCU_RCULFCQUEUE_H
+#define _URCU_RCULFCQUEUE_H
+
+/*
+ * urcu/rculfcqueue.h
+ *
+ * Userspace RCU library - Lock-Free RCU Concurrent Queue
+ *
+ * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <assert.h>
+#include <stdbool.h>
+#include <urcu-call-rcu.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct cds_lfcq_node {
+	struct cds_lfcq_node *next;
+	int dummy;
+};
+
+
+struct cds_lfcq_head {
+        struct cds_lfcq_node *p;
+	void (*queue_call_rcu)(struct rcu_head *head,
+		void (*func)(struct rcu_head *head));
+};
+
+struct cds_lfcq_tail {
+        struct cds_lfcq_node *p;
+};
+
+#ifdef _LGPL_SOURCE
+
+#include <urcu/static/rculfcqueue.h>
+
+#define cds_lfcq_node_init		_cds_lfcq_node_init
+#define _cds_lfcq_init			__cds_lfcq_init
+#define cds_lfcq_finalize		_cds_lfcq_finalize
+#define __cds_lfcq_empty		___cds_lfcq_empty
+#define __cds_lfcq_enqueue		___cds_lfcq_enqueue
+#define __cds_lfcq_dequeue		___cds_lfcq_dequeue
+
+#else /* !_LGPL_SOURCE */
+
+/*
+ * cds_lfcq_node_init: initialize lock-free queue node.
+ * @node: node to initialize.
+ */
+extern void cds_lfcq_node_init(struct cds_lfcq_node *node);
+
+/*
+ * _cds_lfcq_init: intialize lock-free queue.
+ * @head: head of the queue.
+ * @tail: tail of the queue.
+ * queue_call_rcu: call_rcu function to use.
+ */
+extern void _cds_lfcq_init(struct cds_lfcq_head *head,
+		struct cds_lfcq_tail *tail,
+		void queue_call_rcu(struct rcu_head *head,
+			void (*func)(struct rcu_head *head)));
+
+/*
+ * cds_lfcq_finalize: finalize lock-free queue.
+ *
+ * The queue should be emptied before calling finalize. No concurrent
+ * enqueue/dequeue should be running when calling finalize.
+ *
+ * Return 0 on success, -EPERM if queue is not empty.
+ */
+extern int cds_lfcq_finalize(struct cds_lfcq_head *head,
+		struct cds_lfcq_tail *tail);
+
+/*
+ * cds_lfcq_empty: return whether lock-free queue is empty.
+ * @head: head of the queue.
+ * @tail: tail of the queue.
+ *
+ * Should be called under rcu read lock critical section.
+ */
+extern bool __cds_lfcq_empty(struct cds_lfcq_head *head,
+		struct cds_lfcq_tail *tail);
+
+/*
+ * __cds_lfcq_enqueue: enqueue a node into lock-free queue.
+ *
+ * Should be called under rcu read lock critical section.
+ */
+extern void __cds_lfcq_enqueue(struct cds_lfcq_head *head,
+		struct cds_lfcq_tail *tail,
+		struct cds_lfcq_node *node);
+
+/*
+ * __cds_lfcq_dequeue: dequeue a node from lock-free queue.
+ *
+ * The caller must wait for a grace period to pass before freeing the
+ * returned node or modifying the cds_lfq_node_rcu structure.
+ * Returns NULL if queue is empty.
+ * Should be called under rcu read lock critical section.
+ */
+extern
+struct cds_lfcq_node *__cds_lfcq_dequeue(struct cds_lfcq_head *head,
+		struct cds_lfcq_tail *tail);
+
+#endif /* !_LGPL_SOURCE */
+
+/*
+ * cds_lfcq_init: intialize lock-free queue with RCU flavor call_rcu.
+ * @head: head of the queue.
+ * @tail: tail of the queue.
+ */
+static inline void cds_lfcq_init(struct cds_lfcq_head *head,
+		struct cds_lfcq_tail *tail)
+{
+	_cds_lfcq_init(head, tail, call_rcu);
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _URCU_RCULFCQUEUE_H */
diff --git a/urcu/static/rculfcqueue.h b/urcu/static/rculfcqueue.h
new file mode 100644
index 0000000..d0354f4
--- /dev/null
+++ b/urcu/static/rculfcqueue.h
@@ -0,0 +1,319 @@
+#ifndef _URCU_STATIC_RCULFCQUEUE_H
+#define _URCU_STATIC_RCULFCQUEUE_H
+
+/*
+ * urcu/static/rculfcqueue.h
+ *
+ * Userspace RCU library - Lock-Free RCU Concurrent Queue
+ *
+ * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * TO BE INCLUDED ONLY IN LGPL-COMPATIBLE CODE. See urcu/rculfcqueue.h
+ * for linking dynamically with the userspace rcu library.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <urcu-call-rcu.h>
+#include <urcu/uatomic.h>
+#include <urcu-pointer.h>
+#include <assert.h>
+#include <errno.h>
+#include <stdbool.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Lock-free RCU queue. Enqueue and dequeue operations hold a RCU read
+ * lock to deal with cmpxchg ABA problem and guarantee existance of
+ * nodes being read and modified. This queue is *not* circular:
+ * head points to the oldest node, tail points to the newest node.
+ * Keeping a separate head and tail helps with large queues: enqueue and
+ * dequeue can proceed concurrently without wrestling for exclusive
+ * access to the same cache-line.
+ *
+ * Dequeue retry if it detects that it would be dequeueing the last node
+ * (it means a dummy node dequeue-requeue is in progress). This ensures
+ * that there is always at least one node in the queue.
+ *
+ * In the dequeue operation, we internally reallocate the dummy node
+ * upon dequeue/requeue and use call_rcu to free the old one after a
+ * grace period.
+ */
+
+struct cds_lfcq_node_dummy {
+	struct cds_lfcq_node parent;
+	struct rcu_head rcu_head;
+	struct cds_lfcq_head *head;
+	struct cds_lfcq_tail *tail;
+};
+
+static inline
+struct cds_lfcq_node *___cds_lfcq_make_dummy(struct cds_lfcq_head *head,
+		struct cds_lfcq_tail *tail,
+		struct cds_lfcq_node *next)
+{
+	struct cds_lfcq_node_dummy *dummy;
+
+	dummy = malloc(sizeof(struct cds_lfcq_node_dummy));
+	assert(dummy);
+	dummy->parent.next = next;
+	dummy->parent.dummy = 1;
+	dummy->head = head;
+	dummy->tail = tail;
+	return &dummy->parent;
+}
+
+static inline
+void ___cds_lfcq_free_dummy_cb(struct rcu_head *head)
+{
+	struct cds_lfcq_node_dummy *dummy;
+
+	dummy = caa_container_of(head, struct cds_lfcq_node_dummy, rcu_head);
+	free(dummy);
+}
+
+static inline
+void ___cds_lfcq_rcu_free_dummy(struct cds_lfcq_node *node)
+{
+	struct cds_lfcq_node_dummy *dummy;
+
+	assert(node->dummy);
+	dummy = caa_container_of(node, struct cds_lfcq_node_dummy, parent);
+	dummy->head->queue_call_rcu(&dummy->rcu_head, ___cds_lfcq_free_dummy_cb);
+}
+
+static inline
+void ___cds_lfcq_free_dummy(struct cds_lfcq_node *node)
+{
+	struct cds_lfcq_node_dummy *dummy;
+
+	assert(node->dummy);
+	dummy = caa_container_of(node, struct cds_lfcq_node_dummy, parent);
+	free(dummy);
+}
+
+/*
+ * cds_lfcq_node_init: initialize lock-free queue node.
+ * @node: node to initialize.
+ */
+static inline
+void _cds_lfcq_node_init(struct cds_lfcq_node *node)
+{
+	node->next = NULL;
+	node->dummy = 0;
+}
+
+/*
+ * _cds_lfcq_init: intialize lock-free queue.
+ * @head: head of the queue.
+ * @tail: tail of the queue.
+ * queue_call_rcu: call_rcu function to use.
+ */
+static inline
+void __cds_lfcq_init(struct cds_lfcq_head *head,
+		struct cds_lfcq_tail *tail,
+		void queue_call_rcu(struct rcu_head *head,
+			void (*func)(struct rcu_head *head)))
+{
+	/* Set queue head and tail */
+	tail->p = ___cds_lfcq_make_dummy(head, tail, NULL);
+	head->p = tail->p;
+	head->queue_call_rcu = queue_call_rcu;
+}
+
+static inline
+bool ___cds_lfcq_head_empty(struct cds_lfcq_node *node,
+		struct cds_lfcq_node *next)
+{
+	return node->dummy && next == NULL;
+}
+
+/*
+ * __cds_lfcq_empty: return whether lock-free queue is empty.
+ * @head: head of the queue.
+ * @tail: tail of the queue.
+ *
+ * Should be called under rcu read lock critical section.
+ */
+static inline
+bool ___cds_lfcq_empty(struct cds_lfcq_head *head,
+		struct cds_lfcq_tail *tail)
+{
+	struct cds_lfcq_node *node, *next;
+
+	for (;;) {
+		node = rcu_dereference(head->p);
+		next = rcu_dereference(node->next);
+		if (next == NULL)
+			return 1;	/* empty */
+		/* non-null next, not dummy: not empty. */
+		if (!node->dummy)
+			return 0;	/* non-empty */
+
+		/*
+		 * If first node is a dummy node, but it's not end of
+		 * queue, we need to dequeue it before being able to
+		 * state that the queue is empty. This is required
+		 * because "finalize" expects an empty queue to have
+		 * only one dummy node. It is possible that a queue have
+		 * more than one dummy node if multiple concurrent
+		 * dequeue enqueue dummy nodes simultaneously.
+		 */
+		if (uatomic_cmpxchg(&head->p, node, next) != node)
+			continue;	/* Concurrently pushed. */
+		/* Free dummy after grace period. */
+		___cds_lfcq_rcu_free_dummy(node);
+		continue;	/* try again */
+	}
+}
+
+/*
+ * cds_lfcq_finalize: finalize lock-free queue.
+ *
+ * The queue should be emptied before calling finalize. No concurrent
+ * enqueue/dequeue should be running when calling finalize.
+ *
+ * Return 0 on success, -EPERM if queue is not empty.
+ */
+static inline
+int _cds_lfcq_finalize(struct cds_lfcq_head *head,
+		struct cds_lfcq_tail *tail)
+{
+	struct cds_lfcq_node *node, *next;
+
+	node = head->p;
+	next = node->next;
+	if (!___cds_lfcq_head_empty(node, next))
+		return -EPERM;	/* not empty */
+	___cds_lfcq_free_dummy(node);
+	return 0;
+}
+
+/*
+ * Should be called under rcu read lock critical section.
+ */
+static inline
+void ___cds_lfcq_append(struct cds_lfcq_head *head,
+		struct cds_lfcq_tail *tail,
+		struct cds_lfcq_node *new_head,
+		struct cds_lfcq_node *new_tail)
+{
+	/*
+	 * uatomic_cmpxchg() implicit memory barrier orders earlier stores to
+	 * node before publication.
+	 */
+
+	for (;;) {
+		struct cds_lfcq_node *tail_node, *next;
+
+		tail_node = rcu_dereference(tail->p);
+		/*
+		 * RCU existance guarantee ensures we don't touch
+		 * &tail->next after it has been dequeued and freed.
+		 */
+		next = uatomic_cmpxchg(&tail_node->next, NULL, new_head);
+		if (next == NULL) {
+			/*
+			 * Tail was at the end of queue, we successfully
+			 * appended to it. Now move tail (another
+			 * enqueue or dequeue might beat us to it,
+			 * that's fine).
+			 */
+			(void) uatomic_cmpxchg(&tail->p, tail_node, new_tail);
+			return;
+		} else {
+			/*
+			 * Failure to append to current tail.
+			 * Help moving tail further and retry.
+			 */
+			(void) uatomic_cmpxchg(&tail->p, tail_node, next);
+			continue;
+		}
+	}
+}
+
+/*
+ * __cds_lfcq_enqueue: enqueue a node into lock-free queue.
+ *
+ * Should be called under rcu read lock critical section.
+ */
+static inline
+void ___cds_lfcq_enqueue(struct cds_lfcq_head *head,
+		struct cds_lfcq_tail *tail,
+		struct cds_lfcq_node *node)
+{
+	___cds_lfcq_append(head, tail, node, node);
+}
+
+static inline
+void ___cds_lfcq_enqueue_dummy(struct cds_lfcq_head *head,
+		struct cds_lfcq_tail *tail)
+{
+	struct cds_lfcq_node *node;
+
+	node = ___cds_lfcq_make_dummy(head, tail, NULL);
+	___cds_lfcq_enqueue(head, tail, node);
+}
+
+/*
+ * __cds_lfcq_dequeue: dequeue a node from lock-free queue.
+ *
+ * The caller must wait for a grace period to pass before freeing the
+ * returned node or modifying the cds_lfq_node_rcu structure.
+ * Returns NULL if queue is empty.
+ * Should be called under rcu read lock critical section.
+ */
+static inline
+struct cds_lfcq_node *___cds_lfcq_dequeue(struct cds_lfcq_head *head,
+		struct cds_lfcq_tail *tail)
+{
+	for (;;) {
+		struct cds_lfcq_node *node, *next;
+
+		/* First node */
+		node = rcu_dereference(head->p);
+		next = rcu_dereference(node->next);
+		if (___cds_lfcq_head_empty(node, next))
+			return NULL;	/* empty */
+		/*
+		 * We never, ever allow dequeue to get to a state where
+		 * the queue is empty (we need at least one node in the
+		 * queue). This is ensured by checking if the head next
+		 * is NULL, which means we need to enqueue a dummy node
+		 * before we can hope dequeuing anything.
+		 */
+		if (!next) {
+			___cds_lfcq_enqueue_dummy(head, tail);
+			next = rcu_dereference(node->next);
+		}
+		if (uatomic_cmpxchg(&head->p, node, next) != node)
+			continue;	/* Concurrently pushed. */
+		if (node->dummy) {
+			/* Free dummy after grace period. */
+			___cds_lfcq_rcu_free_dummy(node);
+			continue;	/* try again */
+		}
+		return node;
+	}
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _URCU_STATIC_RCULFCQUEUE_H */
-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
