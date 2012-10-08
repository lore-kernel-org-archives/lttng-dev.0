From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [URCU PATCH 3/3] call_rcu: use wfcqueue,
	eliminate	false-sharing
Date: Mon, 8 Oct 2012 12:03:55 -0400
Message-ID: <20121008160355.GA30083__24917.026810772$1349712269$gmane$org@Krystal>
References: <20121002141307.GA4057@Krystal> <20121002141638.GD4057@Krystal>
	<507243E9.8010604@cn.fujitsu.com> <20121008144916.GA29352@Krystal>
	<20121008151019.GA2453@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TLFoD-0005S2-Gd
	for lttng-dev@lists.lttng.org; Mon, 08 Oct 2012 12:03:57 -0400
Content-Disposition: inline
In-Reply-To: <20121008151019.GA2453@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> On Mon, Oct 08, 2012 at 10:49:16AM -0400, Mathieu Desnoyers wrote:
[...]
> > 
> > Good point! While we are there, I notice that the "qlen" count, kept for
> > debugging, is causing false-sharing too. I wonder if we should split
> > this counter in two counters: nr_enqueue and nr_dequeue, which would sit
> > in two different cache lines ? It's mainly Paul who cares about this
> > counter. Thoughts ?
> 
> Works for me, as long as nr_enqueue and nr_dequeue are both unsigned long
> to avoid issues with overflow.
> 

How about the following ? The 0.7% performance increase (which is this
small probably due to call rcu batching) makes me wonder if it's really
worth all the trouble through. If not, then we might want to consider
removing the head alignment altogether. Carefully placing head/tail into
different cache lines is really worth it if we have frequent dequeue,
but in this case we batch through "splice" operations on large queues.
Thoughts ?


Fix wfcqueue: false-sharing of qlen, flags, futex fields

The "qlen" count, kept for debugging, is causing false-sharing.  Split
this counter into two: nr_enqueue and nr_dequeue, which sit in two
different cache lines.

The flags field is read-only by enqueue, and read-mostly by dequeue. We
can eliminate all false-sharing between enqueue and dequeue by having
one copy of the flag for enqueue and one for dequeue. The STOP and
STOPPED flags are only used for dequeue (at "free" time), and the RT
flag is set at init time, and used by both enqueue and dequeue.

The "futex" field is very often read by enqueue, and less often
read and modified by dequeue (only when dequeue has emptied the queue).
Move it to the enqueuer cache-line too.

With these modifications, the test "test_urcu_hash 0 1 10" (one updater
for hash table, which uses call_rcu heavily for reclaim) gains 0.7%. The
small performance improvement in this case can be associated to the fact
that call_rcu dequeuer batches dequeuing of rcu head elements.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
index dca98e4..3f46be6 100644
--- a/urcu-call-rcu-impl.h
+++ b/urcu-call-rcu-impl.h
@@ -49,17 +49,18 @@
 struct call_rcu_data {
 	/*
 	 * Align the tail on cache line size to eliminate false-sharing
-	 * with head. Small note, however: the "qlen" field, kept for
-	 * debugging, will cause false-sharing between enqueue and
-	 * dequeue.
+	 * with head.
 	 */
 	struct cds_wfcq_tail cbs_tail;
+	unsigned long nr_enqueue;	/* maintained for debugging. */
+	unsigned long flags_enqueue;
+	int32_t futex;
+
 	/* Alignment on cache line size will add padding here */
 
 	struct cds_wfcq_head __attribute__((aligned(CAA_CACHE_LINE_SIZE))) cbs_head;
-	unsigned long flags;
-	int32_t futex;
-	unsigned long qlen; /* maintained for debugging. */
+	unsigned long nr_dequeue;	/* maintained for debugging. */
+	unsigned long flags_dequeue;
 	pthread_t tid;
 	int cpu_affinity;
 	struct cds_list_head list;
@@ -231,7 +232,7 @@ static void *call_rcu_thread(void *arg)
 {
 	unsigned long cbcount;
 	struct call_rcu_data *crdp = (struct call_rcu_data *) arg;
-	int rt = !!(uatomic_read(&crdp->flags) & URCU_CALL_RCU_RT);
+	int rt = !!(uatomic_read(&crdp->flags_dequeue) & URCU_CALL_RCU_RT);
 	int ret;
 
 	ret = set_thread_cpu_affinity(crdp);
@@ -269,9 +270,9 @@ static void *call_rcu_thread(void *arg)
 				rhp->func(rhp);
 				cbcount++;
 			}
-			uatomic_sub(&crdp->qlen, cbcount);
+			uatomic_add(&crdp->nr_dequeue, cbcount);
 		}
-		if (uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOP)
+		if (uatomic_read(&crdp->flags_dequeue) & URCU_CALL_RCU_STOP)
 			break;
 		rcu_thread_offline();
 		if (!rt) {
@@ -300,7 +301,7 @@ static void *call_rcu_thread(void *arg)
 		cmm_smp_mb();
 		uatomic_set(&crdp->futex, 0);
 	}
-	uatomic_or(&crdp->flags, URCU_CALL_RCU_STOPPED);
+	uatomic_or(&crdp->flags_dequeue, URCU_CALL_RCU_STOPPED);
 	rcu_unregister_thread();
 	return NULL;
 }
@@ -323,9 +324,12 @@ static void call_rcu_data_init(struct call_rcu_data **crdpp,
 		urcu_die(errno);
 	memset(crdp, '\0', sizeof(*crdp));
 	cds_wfcq_init(&crdp->cbs_head, &crdp->cbs_tail);
-	crdp->qlen = 0;
+	crdp->nr_enqueue = 0;
+	crdp->flags_enqueue = flags;
 	crdp->futex = 0;
-	crdp->flags = flags;
+
+	crdp->nr_dequeue = 0;
+	crdp->flags_dequeue = flags;
 	cds_list_add(&crdp->list, &call_rcu_data_list);
 	crdp->cpu_affinity = cpu_affinity;
 	cmm_smp_mb();  /* Structure initialized before pointer is planted. */
@@ -571,7 +575,7 @@ int create_all_cpu_call_rcu_data(unsigned long flags)
  */
 static void wake_call_rcu_thread(struct call_rcu_data *crdp)
 {
-	if (!(_CMM_LOAD_SHARED(crdp->flags) & URCU_CALL_RCU_RT))
+	if (!(_CMM_LOAD_SHARED(crdp->flags_enqueue) & URCU_CALL_RCU_RT))
 		call_rcu_wake_up(crdp);
 }
 
@@ -601,7 +605,7 @@ void call_rcu(struct rcu_head *head,
 	rcu_read_lock();
 	crdp = get_call_rcu_data();
 	cds_wfcq_enqueue(&crdp->cbs_head, &crdp->cbs_tail, &head->next);
-	uatomic_inc(&crdp->qlen);
+	uatomic_inc(&crdp->nr_enqueue);
 	wake_call_rcu_thread(crdp);
 	rcu_read_unlock();
 }
@@ -633,10 +637,10 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
 	if (crdp == NULL || crdp == default_call_rcu_data) {
 		return;
 	}
-	if ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0) {
-		uatomic_or(&crdp->flags, URCU_CALL_RCU_STOP);
+	if ((uatomic_read(&crdp->flags_dequeue) & URCU_CALL_RCU_STOPPED) == 0) {
+		uatomic_or(&crdp->flags_dequeue, URCU_CALL_RCU_STOP);
 		wake_call_rcu_thread(crdp);
-		while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0)
+		while ((uatomic_read(&crdp->flags_dequeue) & URCU_CALL_RCU_STOPPED) == 0)
 			poll(NULL, 0, 1);
 	}
 	if (!cds_wfcq_empty(&crdp->cbs_head, &crdp->cbs_tail)) {
@@ -645,8 +649,10 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
 		__cds_wfcq_splice_blocking(&default_call_rcu_data->cbs_head,
 			&default_call_rcu_data->cbs_tail,
 			&crdp->cbs_head, &crdp->cbs_tail);
-		uatomic_add(&default_call_rcu_data->qlen,
-			    uatomic_read(&crdp->qlen));
+		uatomic_add(&default_call_rcu_data->nr_enqueue,
+			    uatomic_read(&crdp->nr_enqueue));
+		uatomic_add(&default_call_rcu_data->nr_dequeue,
+			    uatomic_read(&crdp->nr_dequeue));
 		wake_call_rcu_thread(default_call_rcu_data);
 	}
 
@@ -750,7 +756,7 @@ void call_rcu_after_fork_child(void)
 	cds_list_for_each_entry_safe(crdp, next, &call_rcu_data_list, list) {
 		if (crdp == default_call_rcu_data)
 			continue;
-		uatomic_set(&crdp->flags, URCU_CALL_RCU_STOPPED);
+		uatomic_set(&crdp->flags_dequeue, URCU_CALL_RCU_STOPPED);
 		call_rcu_data_free(crdp);
 	}
 }

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
