From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [URCU PATCH 3/3] call_rcu: use wfcqueue,
	eliminate false-sharing
Date: Tue, 2 Oct 2012 10:16:38 -0400
Message-ID: <20121002141638.GD4057__92.4923610456929$1349187479$gmane$org@Krystal>
References: <20121002141307.GA4057@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TJ3H6-00022b-K3
	for lttng-dev@lists.lttng.org; Tue, 02 Oct 2012 10:16:40 -0400
Content-Disposition: inline
In-Reply-To: <20121002141307.GA4057@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul McKenney <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <eag0628@gmail.com>, rp@svcs.cs.pdx.edu, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Eliminate false-sharing between call_rcu (enqueuer) and worker threads
on the queue head and tail.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 81718bb..c92bbe6 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -30,14 +30,14 @@ if COMPAT_FUTEX
 COMPAT+=$(top_srcdir)/compat_futex.c
 endif
 
-URCU=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfqueue.c $(COMPAT)
-URCU_QSBR=$(top_srcdir)/urcu-qsbr.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfqueue.c $(COMPAT)
+URCU=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfcqueue.c $(COMPAT)
+URCU_QSBR=$(top_srcdir)/urcu-qsbr.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfcqueue.c $(COMPAT)
 # URCU_MB uses urcu.c but -DRCU_MB must be defined
-URCU_MB=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfqueue.c $(COMPAT)
+URCU_MB=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfcqueue.c $(COMPAT)
 # URCU_SIGNAL uses urcu.c but -DRCU_SIGNAL must be defined
-URCU_SIGNAL=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfqueue.c $(COMPAT)
-URCU_BP=$(top_srcdir)/urcu-bp.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfqueue.c $(COMPAT)
-URCU_DEFER=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfqueue.c $(COMPAT)
+URCU_SIGNAL=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfcqueue.c $(COMPAT)
+URCU_BP=$(top_srcdir)/urcu-bp.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfcqueue.c $(COMPAT)
+URCU_DEFER=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfcqueue.c $(COMPAT)
 
 URCU_COMMON_LIB=$(top_builddir)/liburcu-common.la
 URCU_LIB=$(top_builddir)/liburcu.la
diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
index 13b24ff..cf65992 100644
--- a/urcu-call-rcu-impl.h
+++ b/urcu-call-rcu-impl.h
@@ -21,6 +21,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <stdio.h>
 #include <pthread.h>
 #include <signal.h>
@@ -35,7 +36,7 @@
 #include <sched.h>
 
 #include "config.h"
-#include "urcu/wfqueue.h"
+#include "urcu/wfcqueue.h"
 #include "urcu-call-rcu.h"
 #include "urcu-pointer.h"
 #include "urcu/list.h"
@@ -46,7 +47,14 @@
 /* Data structure that identifies a call_rcu thread. */
 
 struct call_rcu_data {
-	struct cds_wfq_queue cbs;
+	/*
+	 * Align the tail on cache line size to eliminate false-sharing
+	 * with head.
+	 */
+	struct cds_wfcq_tail __attribute__((aligned(CAA_CACHE_LINE_SIZE))) cbs_tail;
+	/* Alignment on cache line size will add padding here */
+
+	struct cds_wfcq_head cbs_head;
 	unsigned long flags;
 	int32_t futex;
 	unsigned long qlen; /* maintained for debugging. */
@@ -220,10 +228,7 @@ static void call_rcu_wake_up(struct call_rcu_data *crdp)
 static void *call_rcu_thread(void *arg)
 {
 	unsigned long cbcount;
-	struct cds_wfq_node *cbs;
-	struct cds_wfq_node **cbs_tail;
-	struct call_rcu_data *crdp = (struct call_rcu_data *)arg;
-	struct rcu_head *rhp;
+	struct call_rcu_data *crdp = (struct call_rcu_data *) arg;
 	int rt = !!(uatomic_read(&crdp->flags) & URCU_CALL_RCU_RT);
 	int ret;
 
@@ -243,35 +248,33 @@ static void *call_rcu_thread(void *arg)
 		cmm_smp_mb();
 	}
 	for (;;) {
-		if (&crdp->cbs.head != _CMM_LOAD_SHARED(crdp->cbs.tail)) {
-			while ((cbs = _CMM_LOAD_SHARED(crdp->cbs.head)) == NULL)
-				poll(NULL, 0, 1);
-			_CMM_STORE_SHARED(crdp->cbs.head, NULL);
-			cbs_tail = (struct cds_wfq_node **)
-				uatomic_xchg(&crdp->cbs.tail, &crdp->cbs.head);
+		struct cds_wfcq_head cbs_tmp_head;
+		struct cds_wfcq_tail cbs_tmp_tail;
+		struct cds_wfcq_node *cbs, *cbs_tmp_n;
+
+		cds_wfcq_init(&cbs_tmp_head, &cbs_tmp_tail);
+		__cds_wfcq_splice_blocking(&cbs_tmp_head, &cbs_tmp_tail,
+			&crdp->cbs_head, &crdp->cbs_tail);
+		if (!cds_wfcq_empty(&cbs_tmp_head, &cbs_tmp_tail)) {
 			synchronize_rcu();
 			cbcount = 0;
-			do {
-				while (cbs->next == NULL &&
-				       &cbs->next != cbs_tail)
-				       	poll(NULL, 0, 1);
-				if (cbs == &crdp->cbs.dummy) {
-					cbs = cbs->next;
-					continue;
-				}
-				rhp = (struct rcu_head *)cbs;
-				cbs = cbs->next;
+			__cds_wfcq_for_each_blocking_safe(&cbs_tmp_head,
+					&cbs_tmp_tail, cbs, cbs_tmp_n) {
+				struct rcu_head *rhp;
+
+				rhp = caa_container_of(cbs,
+					struct rcu_head, next);
 				rhp->func(rhp);
 				cbcount++;
-			} while (cbs != NULL);
+			}
 			uatomic_sub(&crdp->qlen, cbcount);
 		}
 		if (uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOP)
 			break;
 		rcu_thread_offline();
 		if (!rt) {
-			if (&crdp->cbs.head
-			    == _CMM_LOAD_SHARED(crdp->cbs.tail)) {
+			if (cds_wfcq_empty(&crdp->cbs_head,
+					&crdp->cbs_tail)) {
 				call_rcu_wait(crdp);
 				poll(NULL, 0, 10);
 				uatomic_dec(&crdp->futex);
@@ -317,7 +320,7 @@ static void call_rcu_data_init(struct call_rcu_data **crdpp,
 	if (crdp == NULL)
 		urcu_die(errno);
 	memset(crdp, '\0', sizeof(*crdp));
-	cds_wfq_init(&crdp->cbs);
+	cds_wfcq_init(&crdp->cbs_head, &crdp->cbs_tail);
 	crdp->qlen = 0;
 	crdp->futex = 0;
 	crdp->flags = flags;
@@ -590,12 +593,12 @@ void call_rcu(struct rcu_head *head,
 {
 	struct call_rcu_data *crdp;
 
-	cds_wfq_node_init(&head->next);
+	cds_wfcq_node_init(&head->next);
 	head->func = func;
 	/* Holding rcu read-side lock across use of per-cpu crdp */
 	rcu_read_lock();
 	crdp = get_call_rcu_data();
-	cds_wfq_enqueue(&crdp->cbs, &head->next);
+	cds_wfcq_enqueue(&crdp->cbs_head, &crdp->cbs_tail, &head->next);
 	uatomic_inc(&crdp->qlen);
 	wake_call_rcu_thread(crdp);
 	rcu_read_unlock();
@@ -625,10 +628,6 @@ void call_rcu(struct rcu_head *head,
  */
 void call_rcu_data_free(struct call_rcu_data *crdp)
 {
-	struct cds_wfq_node *cbs;
-	struct cds_wfq_node **cbs_tail;
-	struct cds_wfq_node **cbs_endprev;
-
 	if (crdp == NULL || crdp == default_call_rcu_data) {
 		return;
 	}
@@ -638,17 +637,12 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
 		while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0)
 			poll(NULL, 0, 1);
 	}
-	if (&crdp->cbs.head != _CMM_LOAD_SHARED(crdp->cbs.tail)) {
-		while ((cbs = _CMM_LOAD_SHARED(crdp->cbs.head)) == NULL)
-			poll(NULL, 0, 1);
-		_CMM_STORE_SHARED(crdp->cbs.head, NULL);
-		cbs_tail = (struct cds_wfq_node **)
-			uatomic_xchg(&crdp->cbs.tail, &crdp->cbs.head);
+	if (!cds_wfcq_empty(&crdp->cbs_head, &crdp->cbs_tail)) {
 		/* Create default call rcu data if need be */
 		(void) get_default_call_rcu_data();
-		cbs_endprev = (struct cds_wfq_node **)
-			uatomic_xchg(&default_call_rcu_data, cbs_tail);
-		*cbs_endprev = cbs;
+		__cds_wfcq_splice_blocking(&default_call_rcu_data->cbs_head,
+			&default_call_rcu_data->cbs_tail,
+			&crdp->cbs_head, &crdp->cbs_tail);
 		uatomic_add(&default_call_rcu_data->qlen,
 			    uatomic_read(&crdp->qlen));
 		wake_call_rcu_thread(default_call_rcu_data);
diff --git a/urcu-call-rcu.h b/urcu-call-rcu.h
index f7eac8d..1dad0e2 100644
--- a/urcu-call-rcu.h
+++ b/urcu-call-rcu.h
@@ -32,7 +32,7 @@
 #include <stdlib.h>
 #include <pthread.h>
 
-#include <urcu/wfqueue.h>
+#include <urcu/wfcqueue.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -55,7 +55,7 @@ struct call_rcu_data;
  */
 
 struct rcu_head {
-	struct cds_wfq_node next;
+	struct cds_wfcq_node next;
 	void (*func)(struct rcu_head *head);
 };
 
-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
