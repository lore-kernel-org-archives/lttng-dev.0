Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A120FC07E9D
	for <lttng-dev@archiver.kernel.org>; Fri, 23 Sep 2022 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1663955713;
	bh=EGCaaatWt/FhsQj+yRvqo3HGbC4P5WB+E5rRIBqVdR4=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RDI+H8hQPk5c52eAzU43/+sjHVa5IY82A1hq8WYy/iP7YAFdUUvkgWzG+ZI8EF55n
	 wQ2pSsUP2oH7D8zpo4DMml+skoxH57PES6eMq5XyXKSZUZStPpb72c1qc2lMq4syXM
	 enDE3ad2TsWI1laTk2SKeBCZH5aTzObB1OLguvIcVS87TM3dLosRRGfkKOCENVb4Rp
	 ZeG3/5USEtANs3C9qi7JC5PMj+50Aubgei8/CXFHwL7B9GsqA6rPEtMvgBNXuDUsT+
	 Vud5K6ZtI62TUrQLGWPyQVpXxDxoyiUhVPjf/HdwayPWWcenYWCsXj3vx+6Dx15kfx
	 4dC1yaw8A5ipg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MZ0DJ45mxz24LX;
	Fri, 23 Sep 2022 13:55:12 -0400 (EDT)
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
 by lists.lttng.org (Postfix) with ESMTPS id 4MZ0DH1h2Fz24LV
 for <lttng-dev@lists.lttng.org>; Fri, 23 Sep 2022 13:55:11 -0400 (EDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
 by dcvr.yhbt.net (Postfix) with ESMTP id A6FB11F506;
 Fri, 23 Sep 2022 17:55:03 +0000 (UTC)
Date: Fri, 23 Sep 2022 17:55:03 +0000
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20220923175503.M564483@dcvr>
References: <20220922091536.GA4597@dcvr>
 <eb0bc02c-904d-1166-ddcc-39bbece70a67@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eb0bc02c-904d-1166-ddcc-39bbece70a67@efficios.com>
Subject: Re: [lttng-dev] URCU background threads vs signalfd
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
From: Eric Wong via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Eric Wong <normalperson@yhbt.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> On 2022-09-22 05:15, Eric Wong via lttng-dev wrote:
> > Hello, I'm using urcu-bp + rculfhash + call_rcu to implement
> > malloc instrumentation (via LD_PRELOAD) on an existing
> > single-threaded Perl codebase which uses Linux signalfd.
> > 
> > signalfd depends on signals being blocked in all threads
> > of the process, otherwise threads with unblocked signals
> > can receive them and starve the signalfd.
> > 
> > While some threads in URCU do block signals (e.g. workqueue
> > worker for rculfhash), the call_rcu thread and rculfhash
> > partition_resize_helper threads do not...
> > 
> > Should all threads URCU creates block signals (aside from SIGRCU)?
> 
> Yes, I think you are right. The SIGRCU signal is only needed for the
> urcu-signal flavor though.
> 
> Would you like to submit a patch ?

Sure.

Is there a way to detect at runtime when urcu-signal is in use
so SIGRCU (SIGUSR1) doesn't get unblocked when using other flavors?

I actually use SIGUSR1 in my signalfd-using codebase.

I also want to remove cds_lfht_worker_init entirely since it's racy.
Signal blocking needs to be done in the parent before pthread_create
to avoid a window where the child has unblocked signals.

Thanks.  Anyways, this is my work-in-progress:

diff --git a/src/rculfhash.c b/src/rculfhash.c
index 7c0b9fb..5f455af 100644
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
diff --git a/src/urcu-call-rcu-impl.h b/src/urcu-call-rcu-impl.h
index e9366b4..9f85d55 100644
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
index b5d7926..1c96287 100644
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
diff --git a/src/workqueue.c b/src/workqueue.c
index b6361ad..1039d72 100644
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
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
