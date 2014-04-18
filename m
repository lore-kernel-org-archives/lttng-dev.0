From: Keir Fraser <keir@cohodata.com>
Subject: [PATCH liburcu] Fix lifetime of rcu_barrier()'s
	completion structure
Date: Fri, 18 Apr 2014 21:12:49 +0100
Message-ID: <53518741.3060906__31629.4491327882$1397853497$gmane$org@cohodata.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080502090304040306060009"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <keir@cohodata.com>) id 1WbF9d-000399-D0
 for lttng-dev@lists.lttng.org; Fri, 18 Apr 2014 16:13:03 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so823685wgh.28
 for <lttng-dev@lists.lttng.org>; Fri, 18 Apr 2014 13:12:51 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--------------080502090304040306060009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[Another attachment, I must sort out to integrate with git send-mail]

rcu_barrier() can return as soon as completion.barrier_count==0, which 
frees the completion struct along with the rest of its stack frame. But 
its call_rcu callbacks may yet try to read and write completion.futex 
via the wake_up function.

Fix this by calloc()ing the completion struct and implementing a 
reference count to determine when it is eventually free()d.

This also fixes bug #787, since calloc() initialises all fields of the 
structure to zero.

  Regards,
  Keir

--------------080502090304040306060009
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="rcu_barrier_completion_delay_free.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rcu_barrier_completion_delay_free.patch"

From aa1d5d0000c6776b0dbf3dbf3681acf6e85b2623 Mon Sep 17 00:00:00 2001
From: Keir Fraser <keir@cohodata.com>
Date: Fri, 18 Apr 2014 20:53:52 +0100
Subject: [PATCH] Do not free the rcu_barrier() completion struct until all
 threads are done with it.

It cannot reside on the waiter's stack as rcu_barrier() may return
before the call_rcu handlers have finished checking whether it needs a
futex wakeup. Instead we dynamically allocate the structure and
determine its lifetime with a reference count.

Signed-off-by: Keir Fraser <keir@cohodata.com>
---
 urcu-call-rcu-impl.h | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
index 5c25a75..8e9ab21 100644
--- a/urcu-call-rcu-impl.h
+++ b/urcu-call-rcu-impl.h
@@ -66,6 +66,7 @@ struct call_rcu_data {
 
 struct call_rcu_completion {
 	int barrier_count;
+	int ref_count;
 	int32_t futex;
 };
 
@@ -266,6 +267,12 @@ static void call_rcu_completion_wake_up(struct call_rcu_completion *completion)
 	}
 }
 
+static void call_rcu_completion_put(struct call_rcu_completion *completion)
+{
+	if (!uatomic_add_return(&completion->ref_count, -1))
+		free(completion);
+}
+
 /* This is the code run by each call_rcu thread. */
 
 static void *call_rcu_thread(void *arg)
@@ -776,8 +783,9 @@ void _rcu_barrier_complete(struct rcu_head *head)
 
 	work = caa_container_of(head, struct call_rcu_completion_work, head);
 	completion = work->completion;
-	uatomic_dec(&completion->barrier_count);
-	call_rcu_completion_wake_up(completion);
+	if (!uatomic_add_return(&completion->barrier_count, -1))
+		call_rcu_completion_wake_up(completion);
+	call_rcu_completion_put(completion);
 	free(work);
 }
 
@@ -787,7 +795,7 @@ void _rcu_barrier_complete(struct rcu_head *head)
 void rcu_barrier(void)
 {
 	struct call_rcu_data *crdp;
-	struct call_rcu_completion completion;
+	struct call_rcu_completion *completion;
 	int count = 0;
 	int was_online;
 
@@ -809,11 +817,16 @@ void rcu_barrier(void)
 		goto online;
 	}
 
+	completion = calloc(sizeof(*completion), 1);
+	if (!completion)
+		urcu_die(errno);
+
 	call_rcu_lock(&call_rcu_mutex);
 	cds_list_for_each_entry(crdp, &call_rcu_data_list, list)
 		count++;
 
-	completion.barrier_count = count;
+	completion->ref_count = count + 1;
+	completion->barrier_count = count;
 
 	cds_list_for_each_entry(crdp, &call_rcu_data_list, list) {
 		struct call_rcu_completion_work *work;
@@ -821,20 +834,23 @@ void rcu_barrier(void)
 		work = calloc(sizeof(*work), 1);
 		if (!work)
 			urcu_die(errno);
-		work->completion = &completion;
+		work->completion = completion;
 		_call_rcu(&work->head, _rcu_barrier_complete, crdp);
 	}
 	call_rcu_unlock(&call_rcu_mutex);
 
 	/* Wait for them */
 	for (;;) {
-		uatomic_dec(&completion.futex);
+		uatomic_dec(&completion->futex);
 		/* Decrement futex before reading barrier_count */
 		cmm_smp_mb();
-		if (!uatomic_read(&completion.barrier_count))
+		if (!uatomic_read(&completion->barrier_count))
 			break;
-		call_rcu_completion_wait(&completion);
+		call_rcu_completion_wait(completion);
 	}
+
+	call_rcu_completion_put(completion);
+
 online:
 	if (was_online)
 		rcu_thread_online();
-- 
1.8.3.2


--------------080502090304040306060009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------080502090304040306060009--
