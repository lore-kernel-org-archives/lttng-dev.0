Return-Path: <SRS0=6Jbg=EC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBB1C55179
	for <lttng-dev@archiver.kernel.org>; Tue, 27 Oct 2020 14:47:39 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8AA20709
	for <lttng-dev@archiver.kernel.org>; Tue, 27 Oct 2020 14:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="kdXu0TN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8AA20709
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CLF135Tg6z17Hs;
	Tue, 27 Oct 2020 10:47:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1603810056;
	bh=J+Vzx97XFJp167liugkgeOaK+bMXUbr0UmZKH7WyWnU=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kdXu0TN0UTagcUi9OZXunQ++u5Tioz5Ian0HKZrdnbWjwRFBDiA/AgUypiHwoPgh4
	 uhOC0WwBnxd4aXfiUa6VAepR2j1DcfhwL6dF9lrxN85Wqu1YykUHqtaf78aa1OWsSB
	 Q37bsm55wKruJof/xK0quJtbt1EFk5qdUAfeB4E0dOug27rMCJuCiSfeGWmXYS0yUE
	 sDLsTDuFkZ547Jdle2GJrWdBbGfnysdcPTSu7ZaAqeRyg3qK5GGqHAsygG15Om70M9
	 U8rDpBTetrZE04Rhu4SSvGMJ2gFVR+awatPbeBq7kCpYuUSGx0XJpQK2lnSFTewLzK
	 e3FdycFaLE2Fg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CLF116WlMz17hM
 for <lttng-dev@lists.lttng.org>; Tue, 27 Oct 2020 10:47:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8642B2C2F98;
 Tue, 27 Oct 2020 10:47:27 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id kzEGE0NLNsJq; Tue, 27 Oct 2020 10:47:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0F5692C2F97;
 Tue, 27 Oct 2020 10:47:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0F5692C2F97
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id pMc0e0RSVB_Z; Tue, 27 Oct 2020 10:47:27 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id F38812C2F39;
 Tue, 27 Oct 2020 10:47:26 -0400 (EDT)
Date: Tue, 27 Oct 2020 10:47:26 -0400 (EDT)
To: paulmck <paulmck@kernel.org>, Michael Jeanson <mjeanson@efficios.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, 
 lttng-dev <lttng-dev@lists.lttng.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <272247506.38717.1603810046973.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201026205320.GT3249@paulmck-ThinkPad-P72>
References: <20201022223021.GA8535@paulmck-ThinkPad-P72>
 <1576751762.38206.1603742291604.JavaMail.zimbra@efficios.com>
 <20201026205320.GT3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF82 (Linux)/8.8.15_GA_3968)
Thread-Topic: call_rcu: Fix race between rcu_barrier() and call_rcu_data_free()
Thread-Index: W1lGg2TNSwQepZBTRfmC1fHV9JDNFQ==
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

----- On Oct 26, 2020, at 4:53 PM, paulmck paulmck@kernel.org wrote:

> On Mon, Oct 26, 2020 at 03:58:11PM -0400, Mathieu Desnoyers wrote:
>> ----- On Oct 22, 2020, at 6:30 PM, paulmck paulmck@kernel.org wrote:
>> 
>> > The current code can lose RCU callbacks at shutdown time, which can
>> > result in hangs.  This lossage can happen as follows:
>> > 
>> > o       A thread invokes call_rcu_data_free(), which executes up through
>> >        the wake_call_rcu_thread().  At this point, the call_rcu_data
>> >        structure has been drained of callbacks, but is still on the
>> >        call_rcu_data_list.  Note that this thread does not hold the
>> >        call_rcu_mutex.
>> > 
>> > o       Another thread invokes rcu_barrier(), which traverses the
>> >        call_rcu_data_list under the protection of call_rcu_mutex,
>> >        a list which still includes the above newly drained structure.
>> >        This thread therefore adds a callback to the newly drained
>> >        call_rcu_data structure.  It then releases call_rcu_mutex and
>> >        enters a mystifying loop that does futex stuff.
>> > 
>> > o       The first thread finishes executing call_rcu_data_free(),
>> >        which acquires call_rcu_mutex just long enough to remove the
>> >        newly drained call_rcu_data structure from call_rcu_data_list.
>> >        Which causes one of the rcu_barrier() invocation's callbacks to
>> >        be leaked.
>> > 
>> > o       The second thread's rcu_barrier() invocation never returns
>> >        resulting in a hang.
>> > 
>> > This commit therefore changes call_rcu_data_free() to acquire
>> > call_rcu_mutex before checking the call_rcu_data structure for callbacks.
>> > In the case where there are no callbacks, call_rcu_mutex is held across
>> > both the check and the removal from call_rcu_data_list, thus preventing
>> > rcu_barrier() from adding a callback in the meantime.  In the case where
>> > there are callbacks, call_rcu_mutex must be momentarily dropped across
>> > the call to get_default_call_rcu_data(), which can itself acquire
>> > call_rcu_mutex.  This momentary drop is not a problem because any
>> > callbacks that rcu_barrier() might queue during that period of time will
>> > be moved to the default call_rcu_data structure, and the lock will be
>> > held across the full time including moving those callbacks and removing
>> > the call_rcu_data structure that was passed into call_rcu_data_free()
>> > from call_rcu_data_list.
>> > 
>> > With this fix, a several-hundred-CPU test successfully completes more
>> > than 5,000 executions.  Without this fix, it fails within a few tens
>> > of executions.  Although the failures happen more quickly on larger
>> > systems, in theory this could happen on a single-CPU system, courtesy
>> > of preemption.
>> 
>> I agree with this fix, will merge in liburcu master, stable-0.12, and
>> stable-2.11.
>> Out of curiosity, which test is hanging ?  Is it a test which is part of the
>> liburcu
>> tree or some out-of-tree test ? I wonder why we did not catch it in our CI [1].
> 
> The hung test was from perfbook [1] in the CodeSamples/datastruct/hash
> directory.  A repeat-by is as follows:
> 
> # Have userspace RCU preinstalled as you wish.
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/perfbook.git
> cd CodeSamples
> make pthreads
> cd datastruct/hash
> make
> time for ((i = 0; i < 2000; i++)); do echo $i; ./hash_bkt_rcu --schroedinger
> --nreaders 444 --nupdaters 4 --duration 1000 --updatewait 1 --nbuckets 262144
> --elems/writer 65536; done
> 
> This normally hangs within a few tens of iterations.  With this patch,
> the passes more than 6,000 iterations.
> 
> I have smaller tests that produce this same hang on my 12-CPU laptop,
> but with much lower probability.  Here is one example that did hang on
> my laptop, and which could be placed into a similar bash loop as above:
> 
> hash_bkt_rcu --schroedinger --nreaders 10 --nupdaters 2 --duration 1000
> --updatewait 1 --nbuckets 8192 --elems/writer 4096
> 
> But I don't have a good estimate of the hang probability, except a
> suspicion that it is lower than would be convenient for a CI test.
> Attaching to the hung process using gdb did confirm the type of hang,
> however.
> 
> It might be possible to create a focused test that races rcu_barrier()
> against thread exit, where threads are created and exit repeatedly,
> and make a per-thread call_rcu() worker in the meantime..
> 
> Thoughts?

We'll try to come up with a narrowed-down test-case which reproduce the issue.
We may get some inspiration from your test-case. I'll ask Michael Jeanson
to add this to our backlog.

Thanks,

Mathieu

> 
>							Thanx, Paul
> 
> [1]	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/perfbook.git
> 
>> Thanks,
>> 
>> Mathieu
>> 
>> [1] https://ci.lttng.org/view/Liburcu/
>> 
>> > 
>> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> > Cc: Stephen Hemminger <stephen@networkplumber.org>
>> > Cc: Alan Stern <stern@rowland.harvard.edu>
>> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>> > Cc: <lttng-dev@lists.lttng.org>
>> > Cc: <linux-kernel@vger.kernel.org>
>> > 
>> > ---
>> > 
>> > urcu-call-rcu-impl.h |    7 +++++--
>> > 1 file changed, 5 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/src/urcu-call-rcu-impl.h b/src/urcu-call-rcu-impl.h
>> > index b6ec6ba..18fd65a 100644
>> > --- a/src/urcu-call-rcu-impl.h
>> > +++ b/src/urcu-call-rcu-impl.h
>> > @@ -772,9 +772,13 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
>> > 		while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0)
>> > 			(void) poll(NULL, 0, 1);
>> > 	}
>> > +	call_rcu_lock(&call_rcu_mutex);
>> > 	if (!cds_wfcq_empty(&crdp->cbs_head, &crdp->cbs_tail)) {
>> > -		/* Create default call rcu data if need be */
>> > +		call_rcu_unlock(&call_rcu_mutex);
>> > +		/* Create default call rcu data if need be. */
>> > +		/* CBs queued here will be handed to the default list. */
>> > 		(void) get_default_call_rcu_data();
>> > +		call_rcu_lock(&call_rcu_mutex);
>> > 		__cds_wfcq_splice_blocking(&default_call_rcu_data->cbs_head,
>> > 			&default_call_rcu_data->cbs_tail,
>> > 			&crdp->cbs_head, &crdp->cbs_tail);
>> > @@ -783,7 +787,6 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
>> > 		wake_call_rcu_thread(default_call_rcu_data);
>> > 	}
>> > 
>> > -	call_rcu_lock(&call_rcu_mutex);
>> > 	cds_list_del(&crdp->list);
>> >  	call_rcu_unlock(&call_rcu_mutex);
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
> > http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
