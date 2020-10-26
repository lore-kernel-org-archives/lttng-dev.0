Return-Path: <SRS0=fQvM=EB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDBEC4363A
	for <lttng-dev@archiver.kernel.org>; Mon, 26 Oct 2020 19:58:22 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F32F20795
	for <lttng-dev@archiver.kernel.org>; Mon, 26 Oct 2020 19:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="k/rSdueS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F32F20795
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CKly360Zyz177q;
	Mon, 26 Oct 2020 15:58:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1603742300;
	bh=njvx7sDT+fAJrCR2gIYtM8ceJvU4GBT3dxZmOocjt7U=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=k/rSdueSbsM7hcp9dT0I8UHeeuDMqSaiK+ze43jkEkwiZvw06w8qJhviEe4rzYPDw
	 wBD0jozs3vb4vze5qXyS/1KxQpT8tjDPA2CnXIEqepWvP/VVIVpWS7dNrPo67qKEZb
	 P7govI2anOz/VTP1hr+skh9QgwjFCmt184lDFtA0H5HXif61BV/ZvoA0QQQD+DO6r+
	 v0LtF0ZLp6yiGg/gXW2eky6folQiHGtbqJxO1E00Qcd0zWzYocrJibyEK/WaJH8Hka
	 9l7YMm37TPIoYGrSM71tmEEQyqRiFXQW1AAOD0gvdwaTHPeeActgyVsMuP/rp7a6Gr
	 2VbjIYz80NIdg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CKly22xylz17Pp
 for <lttng-dev@lists.lttng.org>; Mon, 26 Oct 2020 15:58:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1DBF4243705
 for <lttng-dev@lists.lttng.org>; Mon, 26 Oct 2020 15:58:12 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ZL3Q0D64S4Pw; Mon, 26 Oct 2020 15:58:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BB44024322C;
 Mon, 26 Oct 2020 15:58:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BB44024322C
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id LiksraaO4Ybn; Mon, 26 Oct 2020 15:58:11 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id ADC0F243624;
 Mon, 26 Oct 2020 15:58:11 -0400 (EDT)
Date: Mon, 26 Oct 2020 15:58:11 -0400 (EDT)
To: paulmck <paulmck@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, 
 lttng-dev <lttng-dev@lists.lttng.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1576751762.38206.1603742291604.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201022223021.GA8535@paulmck-ThinkPad-P72>
References: <20201022223021.GA8535@paulmck-ThinkPad-P72>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: call_rcu: Fix race between rcu_barrier() and call_rcu_data_free()
Thread-Index: rMNXOOdfGCDrW92dFjPnT/ePYC8HIQ==
Subject: Re: [lttng-dev] [PATCH] call_rcu: Fix race between rcu_barrier()
 and call_rcu_data_free()
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Oct 22, 2020, at 6:30 PM, paulmck paulmck@kernel.org wrote:

> The current code can lose RCU callbacks at shutdown time, which can
> result in hangs.  This lossage can happen as follows:
> 
> o       A thread invokes call_rcu_data_free(), which executes up through
>        the wake_call_rcu_thread().  At this point, the call_rcu_data
>        structure has been drained of callbacks, but is still on the
>        call_rcu_data_list.  Note that this thread does not hold the
>        call_rcu_mutex.
> 
> o       Another thread invokes rcu_barrier(), which traverses the
>        call_rcu_data_list under the protection of call_rcu_mutex,
>        a list which still includes the above newly drained structure.
>        This thread therefore adds a callback to the newly drained
>        call_rcu_data structure.  It then releases call_rcu_mutex and
>        enters a mystifying loop that does futex stuff.
> 
> o       The first thread finishes executing call_rcu_data_free(),
>        which acquires call_rcu_mutex just long enough to remove the
>        newly drained call_rcu_data structure from call_rcu_data_list.
>        Which causes one of the rcu_barrier() invocation's callbacks to
>        be leaked.
> 
> o       The second thread's rcu_barrier() invocation never returns
>        resulting in a hang.
> 
> This commit therefore changes call_rcu_data_free() to acquire
> call_rcu_mutex before checking the call_rcu_data structure for callbacks.
> In the case where there are no callbacks, call_rcu_mutex is held across
> both the check and the removal from call_rcu_data_list, thus preventing
> rcu_barrier() from adding a callback in the meantime.  In the case where
> there are callbacks, call_rcu_mutex must be momentarily dropped across
> the call to get_default_call_rcu_data(), which can itself acquire
> call_rcu_mutex.  This momentary drop is not a problem because any
> callbacks that rcu_barrier() might queue during that period of time will
> be moved to the default call_rcu_data structure, and the lock will be
> held across the full time including moving those callbacks and removing
> the call_rcu_data structure that was passed into call_rcu_data_free()
> from call_rcu_data_list.
> 
> With this fix, a several-hundred-CPU test successfully completes more
> than 5,000 executions.  Without this fix, it fails within a few tens
> of executions.  Although the failures happen more quickly on larger
> systems, in theory this could happen on a single-CPU system, courtesy
> of preemption.

I agree with this fix, will merge in liburcu master, stable-0.12, and stable-2.11.
Out of curiosity, which test is hanging ?  Is it a test which is part of the liburcu
tree or some out-of-tree test ? I wonder why we did not catch it in our CI [1].

Thanks,

Mathieu

[1] https://ci.lttng.org/view/Liburcu/

> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: <lttng-dev@lists.lttng.org>
> Cc: <linux-kernel@vger.kernel.org>
> 
> ---
> 
> urcu-call-rcu-impl.h |    7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/src/urcu-call-rcu-impl.h b/src/urcu-call-rcu-impl.h
> index b6ec6ba..18fd65a 100644
> --- a/src/urcu-call-rcu-impl.h
> +++ b/src/urcu-call-rcu-impl.h
> @@ -772,9 +772,13 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
> 		while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0)
> 			(void) poll(NULL, 0, 1);
> 	}
> +	call_rcu_lock(&call_rcu_mutex);
> 	if (!cds_wfcq_empty(&crdp->cbs_head, &crdp->cbs_tail)) {
> -		/* Create default call rcu data if need be */
> +		call_rcu_unlock(&call_rcu_mutex);
> +		/* Create default call rcu data if need be. */
> +		/* CBs queued here will be handed to the default list. */
> 		(void) get_default_call_rcu_data();
> +		call_rcu_lock(&call_rcu_mutex);
> 		__cds_wfcq_splice_blocking(&default_call_rcu_data->cbs_head,
> 			&default_call_rcu_data->cbs_tail,
> 			&crdp->cbs_head, &crdp->cbs_tail);
> @@ -783,7 +787,6 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
> 		wake_call_rcu_thread(default_call_rcu_data);
> 	}
> 
> -	call_rcu_lock(&call_rcu_mutex);
> 	cds_list_del(&crdp->list);
>  	call_rcu_unlock(&call_rcu_mutex);

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
