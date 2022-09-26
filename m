Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5570CC32771
	for <lttng-dev@archiver.kernel.org>; Mon, 26 Sep 2022 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1664204422;
	bh=JXk8v2u3/qAyaR8k1JUKhMO9+lQcmX6rwSQsCnMVhCI=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=zB03VsVLLQEvu/oV+kImHk5JXVFcXMtdFiZ05BMfFUv6xG+s1FxbS8mrYyhhcfgCA
	 1BPalJ/8HS7zSD6H/ieBBMqn53ip78wO2upNwqW8hb3YcpZtw9u3it/JsbmyfTEWlR
	 /NOJbxMIqVWviMBLxq5LAehJwuX1p4H9W0vEs4/vy8Uyq83gniH9AzboVE7vlMa9AI
	 z+Ie/Drg1BZukOuGLvBl/bhmyHb909OeVbxtwLi+n8NG4/jL6AxFcsyCYoH0KPcpcd
	 V/+W3VDWzavODM/9kUdOkWbj3xDkiURmR+QgLZTP8OvbE3aJ0dTR473kCiio+LfnS9
	 ZZCTUaGs1XdZg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MbmC92Cc2z25Cq;
	Mon, 26 Sep 2022 11:00:21 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:5aae::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4MbmC75v6tz25Tv
 for <lttng-dev@lists.lttng.org>; Mon, 26 Sep 2022 11:00:19 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4MbmC516cRzP3F;
 Mon, 26 Sep 2022 11:00:17 -0400 (EDT)
To: paulmck@kernel.org
Date: Mon, 26 Sep 2022 11:01:04 -0400
Message-Id: <20220926150104.111189-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Subject: [lttng-dev] [RFC PATCH urcu] Disable signals in URCU background
 threads
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Applications using signalfd depend on signals being blocked in all
threads of the process, otherwise threads with unblocked signals
can receive them and starve the signalfd.

While some threads in URCU do block signals (e.g. workqueue
worker for rculfhash), the call_rcu, defer_rcu, and rculfhash
partition_resize_helper threads do not.

Always block all signals before creating threads, and only unblock
SIGRCU when registering a urcu-signal thread. Restore the SIGRCU
signal to its pre-registration blocked state on unregistration.

For rculfhash, cds_lfht_worker_init can be removed, because its only
effect is to block all signals except SIGRCU. Blocking all signals is
already done by the workqueue code, and unbloking SIGRCU is now done by
the urcu signal flavor thread regisration.

Co-developed-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Change-Id: If78346b15bdc287417b992a8963098c6ea0dc7d2
---
 src/rculfhash.c          | 36 ++++++++++--------------------
 src/urcu-call-rcu-impl.h | 10 +++++++++
 src/urcu-defer-impl.h    |  9 ++++++++
 src/urcu.c               | 48 ++++++++++++++++++++++++++++++++++++++++
 src/workqueue.c          | 21 ++++++++++++++++++
 5 files changed, 100 insertions(+), 24 deletions(-)

diff --git a/src/rculfhash.c b/src/rculfhash.c
index 7c0b9fb8..a41cac83 100644
--- a/src/rculfhash.c
+++ b/src/rculfhash.c
@@ -1251,6 +1251,7 @@ void partition_resize_helper(struct cds_lfht *ht, unsigned long i,
 	struct partition_resize_work *work;
 	int ret;
 	unsigned long thread, nr_threads;
+	sigset_t newmask, oldmask;
 
 	urcu_posix_assert(nr_cpus_mask != -1);
 	if (nr_cpus_mask < 0 || len < 2 * MIN_PARTITION_PER_THREAD)
@@ -1273,6 +1274,12 @@ void partition_resize_helper(struct cds_lfht *ht, unsigned long i,
 		dbg_printf("error allocating for resize, single-threading\n");
 		goto fallback;
 	}
+
+	ret = sigfillset(&newmask);
+	urcu_posix_assert(!ret);
+	ret = pthread_sigmask(SIG_BLOCK, &newmask, &oldmask);
+	urcu_posix_assert(!ret);
+
 	for (thread = 0; thread < nr_threads; thread++) {
 		work[thread].ht = ht;
 		work[thread].i = i;
@@ -1294,6 +1301,10 @@ void partition_resize_helper(struct cds_lfht *ht, unsigned long i,
 		}
 		urcu_posix_assert(!ret);
 	}
+
+	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
+	urcu_posix_assert(!ret);
+
 	for (thread = 0; thread < nr_threads; thread++) {
 		ret = pthread_join(work[thread].thread_id, NULL);
 		urcu_posix_assert(!ret);
@@ -2163,29 +2174,6 @@ static struct urcu_atfork cds_lfht_atfork = {
 	.after_fork_child = cds_lfht_after_fork_child,
 };
 
-/*
- * Block all signals for the workqueue worker thread to ensure we don't
- * disturb the application. The SIGRCU signal needs to be unblocked for
- * the urcu-signal flavor.
- */
-static void cds_lfht_worker_init(
-		struct urcu_workqueue *workqueue __attribute__((unused)),
-		void *priv __attribute__((unused)))
-{
-	int ret;
-	sigset_t mask;
-
-	ret = sigfillset(&mask);
-	if (ret)
-		urcu_die(errno);
-	ret = sigdelset(&mask, SIGRCU);
-	if (ret)
-		urcu_die(errno);
-	ret = pthread_sigmask(SIG_SETMASK, &mask, NULL);
-	if (ret)
-		urcu_die(ret);
-}
-
 static void cds_lfht_init_worker(const struct rcu_flavor_struct *flavor)
 {
 	flavor->register_rculfhash_atfork(&cds_lfht_atfork);
@@ -2194,7 +2182,7 @@ static void cds_lfht_init_worker(const struct rcu_flavor_struct *flavor)
 	if (cds_lfht_workqueue_user_count++)
 		goto end;
 	cds_lfht_workqueue = urcu_workqueue_create(0, -1, NULL,
-		NULL, cds_lfht_worker_init, NULL, NULL, NULL, NULL, NULL);
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL);
 end:
 	mutex_unlock(&cds_lfht_fork_mutex);
 }
diff --git a/src/urcu-call-rcu-impl.h b/src/urcu-call-rcu-impl.h
index e9366b42..9f85d55b 100644
--- a/src/urcu-call-rcu-impl.h
+++ b/src/urcu-call-rcu-impl.h
@@ -434,6 +434,7 @@ static void call_rcu_data_init(struct call_rcu_data **crdpp,
 {
 	struct call_rcu_data *crdp;
 	int ret;
+	sigset_t newmask, oldmask;
 
 	crdp = malloc(sizeof(*crdp));
 	if (crdp == NULL)
@@ -448,9 +449,18 @@ static void call_rcu_data_init(struct call_rcu_data **crdpp,
 	crdp->gp_count = 0;
 	cmm_smp_mb();  /* Structure initialized before pointer is planted. */
 	*crdpp = crdp;
+
+	ret = sigfillset(&newmask);
+	urcu_posix_assert(!ret);
+	ret = pthread_sigmask(SIG_BLOCK, &newmask, &oldmask);
+	urcu_posix_assert(!ret);
+
 	ret = pthread_create(&crdp->tid, NULL, call_rcu_thread, crdp);
 	if (ret)
 		urcu_die(ret);
+
+	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
+	urcu_posix_assert(!ret);
 }
 
 /*
diff --git a/src/urcu-defer-impl.h b/src/urcu-defer-impl.h
index b5d79262..1c962879 100644
--- a/src/urcu-defer-impl.h
+++ b/src/urcu-defer-impl.h
@@ -409,9 +409,18 @@ void defer_rcu(void (*fct)(void *p), void *p)
 static void start_defer_thread(void)
 {
 	int ret;
+	sigset_t newmask, oldmask;
+
+	ret = sigfillset(&newmask);
+	urcu_posix_assert(!ret);
+	ret = pthread_sigmask(SIG_BLOCK, &newmask, &oldmask);
+	urcu_posix_assert(!ret);
 
 	ret = pthread_create(&tid_defer, NULL, thr_defer, NULL);
 	urcu_posix_assert(!ret);
+
+	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
+	urcu_posix_assert(!ret);
 }
 
 static void stop_defer_thread(void)
diff --git a/src/urcu.c b/src/urcu.c
index 59f2e8f1..cf4d6d03 100644
--- a/src/urcu.c
+++ b/src/urcu.c
@@ -110,6 +110,8 @@ static int init_done;
 
 void __attribute__((constructor)) rcu_init(void);
 void __attribute__((destructor)) rcu_exit(void);
+
+static DEFINE_URCU_TLS(int, rcu_signal_was_blocked);
 #endif
 
 /*
@@ -537,8 +539,52 @@ int rcu_read_ongoing(void)
 	return _rcu_read_ongoing();
 }
 
+#ifdef RCU_SIGNAL
+/*
+ * Make sure the signal used by the urcu-signal flavor is unblocked
+ * while the thread is registered.
+ */
+static
+void urcu_signal_unblock(void)
+{
+	sigset_t mask, oldmask;
+	int ret;
+
+	ret = sigemptyset(&mask);
+	urcu_posix_assert(!ret);
+	ret = sigaddset(&mask, SIGRCU);
+	urcu_posix_assert(!ret);
+	ret = pthread_sigmask(SIG_UNBLOCK, &mask, &oldmask);
+	urcu_posix_assert(!ret);
+	URCU_TLS(rcu_signal_was_blocked) = sigismember(&oldmask, SIGRCU);
+}
+
+static
+void urcu_signal_restore(void)
+{
+	sigset_t mask;
+	int ret;
+
+	if (!URCU_TLS(rcu_signal_was_blocked))
+		return;
+	ret = sigemptyset(&mask);
+	urcu_posix_assert(!ret);
+	ret = sigaddset(&mask, SIGRCU);
+	urcu_posix_assert(!ret);
+	ret = pthread_sigmask(SIG_BLOCK, &mask, NULL);
+	urcu_posix_assert(!ret);
+}
+#else
+static
+void urcu_signal_unblock(void) { }
+static
+void urcu_signal_restore(void) { }
+#endif
+
 void rcu_register_thread(void)
 {
+	urcu_signal_unblock();
+
 	URCU_TLS(rcu_reader).tid = pthread_self();
 	urcu_posix_assert(URCU_TLS(rcu_reader).need_mb == 0);
 	urcu_posix_assert(!(URCU_TLS(rcu_reader).ctr & URCU_GP_CTR_NEST_MASK));
@@ -558,6 +604,8 @@ void rcu_unregister_thread(void)
 	URCU_TLS(rcu_reader).registered = 0;
 	cds_list_del(&URCU_TLS(rcu_reader).node);
 	mutex_unlock(&rcu_registry_lock);
+
+	urcu_signal_restore();
 }
 
 #ifdef RCU_MEMBARRIER
diff --git a/src/workqueue.c b/src/workqueue.c
index b6361ada..1039d729 100644
--- a/src/workqueue.c
+++ b/src/workqueue.c
@@ -284,6 +284,7 @@ struct urcu_workqueue *urcu_workqueue_create(unsigned long flags,
 {
 	struct urcu_workqueue *workqueue;
 	int ret;
+	sigset_t newmask, oldmask;
 
 	workqueue = malloc(sizeof(*workqueue));
 	if (workqueue == NULL)
@@ -304,10 +305,20 @@ struct urcu_workqueue *urcu_workqueue_create(unsigned long flags,
 	workqueue->cpu_affinity = cpu_affinity;
 	workqueue->loop_count = 0;
 	cmm_smp_mb();  /* Structure initialized before pointer is planted. */
+
+	ret = sigfillset(&newmask);
+	urcu_posix_assert(!ret);
+	ret = pthread_sigmask(SIG_BLOCK, &newmask, &oldmask);
+	urcu_posix_assert(!ret);
+
 	ret = pthread_create(&workqueue->tid, NULL, workqueue_thread, workqueue);
 	if (ret) {
 		urcu_die(ret);
 	}
+
+	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
+	urcu_posix_assert(!ret);
+
 	return workqueue;
 }
 
@@ -464,13 +475,23 @@ void urcu_workqueue_resume_worker(struct urcu_workqueue *workqueue)
 void urcu_workqueue_create_worker(struct urcu_workqueue *workqueue)
 {
 	int ret;
+	sigset_t newmask, oldmask;
 
 	/* Clear workqueue state from parent. */
 	workqueue->flags &= ~URCU_WORKQUEUE_PAUSED;
 	workqueue->flags &= ~URCU_WORKQUEUE_PAUSE;
 	workqueue->tid = 0;
+
+	ret = sigfillset(&newmask);
+	urcu_posix_assert(!ret);
+	ret = pthread_sigmask(SIG_BLOCK, &newmask, &oldmask);
+	urcu_posix_assert(!ret);
+
 	ret = pthread_create(&workqueue->tid, NULL, workqueue_thread, workqueue);
 	if (ret) {
 		urcu_die(ret);
 	}
+
+	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
+	urcu_posix_assert(!ret);
 }
-- 
2.30.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
