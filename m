Return-Path: <SRS0=49Hp=D5=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65297C388F9
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Oct 2020 22:37:33 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A5821D43
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Oct 2020 22:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="h0dWAbmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A5821D43
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CHMgZ4gYnz15nQ;
	Thu, 22 Oct 2020 18:37:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1603406251;
	bh=lb9XhfwyawphElhKebFAREY5480mP4Nkf70fMxqba3c=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=h0dWAbmfbfweO5DTxxNeHkKD4heiOtqYYB4tDvl5/jzLcO757EFwXwbP7H5V/wOIY
	 dg9rCHbzeH/MiLqAIovo5txG+mX61+8ZFK5PTZC8/6bwdOw/y+9ev6OvmAVFBDi0Wp
	 LdbkRN7k7PO5wnvj+fQXBEeyrr7alcB2vZuJElAfy/naAkkSpnl9j2/IDhHEqJ2lYc
	 fOYRt2E+iV24l82Wx3RPtrpW2g14ejU1jMTSN9pXAUEWL/NzvJx/mjL84AEUxY9lms
	 MTaQ+7QznglCMWw0xESXXqwt8AfROxpf6SamQr/6j0uwKVOoMMLsu3ABYyhEKIlbeW
	 rAAgg88/bO0Yw==
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by lists.lttng.org (Postfix) with ESMTPS id 4CHMgX2dSnz15sm
 for <lttng-dev@lists.lttng.org>; Thu, 22 Oct 2020 18:37:28 -0400 (EDT)
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net
 [50.39.104.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7BCF324650;
 Thu, 22 Oct 2020 22:30:21 +0000 (UTC)
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
 id 26F2F3522AB9; Thu, 22 Oct 2020 15:30:21 -0700 (PDT)
Date: Thu, 22 Oct 2020 15:30:21 -0700
To: mathieu.desnoyers@efficios.com
Cc: stephen@networkplumber.org, stern@rowland.harvard.edu,
 jiangshanlai@gmail.com, lttng-dev@lists.lttng.org,
 linux-kernel@vger.kernel.org
Message-ID: <20201022223021.GA8535@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Subject: [lttng-dev] [PATCH] call_rcu: Fix race between rcu_barrier() and
 call_rcu_data_free()
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "Paul E. McKenney via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: paulmck@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

The current code can lose RCU callbacks at shutdown time, which can
result in hangs.  This lossage can happen as follows:

o       A thread invokes call_rcu_data_free(), which executes up through
        the wake_call_rcu_thread().  At this point, the call_rcu_data
        structure has been drained of callbacks, but is still on the
        call_rcu_data_list.  Note that this thread does not hold the
        call_rcu_mutex.

o       Another thread invokes rcu_barrier(), which traverses the
        call_rcu_data_list under the protection of call_rcu_mutex,
        a list which still includes the above newly drained structure.
        This thread therefore adds a callback to the newly drained
        call_rcu_data structure.  It then releases call_rcu_mutex and
        enters a mystifying loop that does futex stuff.

o       The first thread finishes executing call_rcu_data_free(),
        which acquires call_rcu_mutex just long enough to remove the
        newly drained call_rcu_data structure from call_rcu_data_list.
        Which causes one of the rcu_barrier() invocation's callbacks to
        be leaked.

o       The second thread's rcu_barrier() invocation never returns
        resulting in a hang.

This commit therefore changes call_rcu_data_free() to acquire
call_rcu_mutex before checking the call_rcu_data structure for callbacks.
In the case where there are no callbacks, call_rcu_mutex is held across
both the check and the removal from call_rcu_data_list, thus preventing
rcu_barrier() from adding a callback in the meantime.  In the case where
there are callbacks, call_rcu_mutex must be momentarily dropped across
the call to get_default_call_rcu_data(), which can itself acquire
call_rcu_mutex.  This momentary drop is not a problem because any
callbacks that rcu_barrier() might queue during that period of time will
be moved to the default call_rcu_data structure, and the lock will be
held across the full time including moving those callbacks and removing
the call_rcu_data structure that was passed into call_rcu_data_free()
from call_rcu_data_list.

With this fix, a several-hundred-CPU test successfully completes more
than 5,000 executions.  Without this fix, it fails within a few tens
of executions.  Although the failures happen more quickly on larger
systems, in theory this could happen on a single-CPU system, courtesy
of preemption.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: <lttng-dev@lists.lttng.org>
Cc: <linux-kernel@vger.kernel.org>

---

 urcu-call-rcu-impl.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/urcu-call-rcu-impl.h b/src/urcu-call-rcu-impl.h
index b6ec6ba..18fd65a 100644
--- a/src/urcu-call-rcu-impl.h
+++ b/src/urcu-call-rcu-impl.h
@@ -772,9 +772,13 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
 		while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0)
 			(void) poll(NULL, 0, 1);
 	}
+	call_rcu_lock(&call_rcu_mutex);
 	if (!cds_wfcq_empty(&crdp->cbs_head, &crdp->cbs_tail)) {
-		/* Create default call rcu data if need be */
+		call_rcu_unlock(&call_rcu_mutex);
+		/* Create default call rcu data if need be. */
+		/* CBs queued here will be handed to the default list. */
 		(void) get_default_call_rcu_data();
+		call_rcu_lock(&call_rcu_mutex);
 		__cds_wfcq_splice_blocking(&default_call_rcu_data->cbs_head,
 			&default_call_rcu_data->cbs_tail,
 			&crdp->cbs_head, &crdp->cbs_tail);
@@ -783,7 +787,6 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
 		wake_call_rcu_thread(default_call_rcu_data);
 	}
 
-	call_rcu_lock(&call_rcu_mutex);
 	cds_list_del(&crdp->list);
 	call_rcu_unlock(&call_rcu_mutex);
 
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
