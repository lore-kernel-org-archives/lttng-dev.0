Return-Path: <SRS0=ctY1=KA=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CC1C433B4
	for <lttng-dev@archiver.kernel.org>; Wed,  5 May 2021 18:16:44 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096D961176
	for <lttng-dev@archiver.kernel.org>; Wed,  5 May 2021 18:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096D961176
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fb4ff43Zlz1j0M;
	Wed,  5 May 2021 14:16:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1620238603;
	bh=j77Ghgei0QR1UDoBUrzKOy/gSdYXLmqedAj0vvis0hw=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=f3LkGDoiPN2kROHG4MfqLk3baH2WfE+PWEvwqlA0aazCbZ+Pakdj5IBj9ZTi6apGj
	 O6mLY6XmihwdwWcVur2j3uIjjQTsvP+a05ABagGguW2oQiBFr/U7z62I5ZmbU2WZM6
	 WwH02Iwv1pZWe/IoYOpII7KRMaNzbqCXD9upWfaKS7mq1yF8VarIW6DCPT5Di/F738
	 leSInGfXUoFk+Cbb2DQEvpzfg1jy0/Xo7v/HsiVbv1OVvW11qgCzdV6ZR5j3LmpD9M
	 JiZm+dhwT5LCFK/zSamV25TAzcBqeIVe4z3ADgOB3BHf7qSewgRZS6q5ovqRz+gy5B
	 GUiewox7Gqy1A==
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fb4fb5KFqz1hlb
 for <lttng-dev@lists.lttng.org>; Wed,  5 May 2021 14:16:39 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 045B661182;
 Wed,  5 May 2021 18:07:39 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 96AAE5C00DC; Wed,  5 May 2021 11:07:38 -0700 (PDT)
Date: Wed, 5 May 2021 11:07:38 -0700
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Martin Wilck <mwilck@suse.com>, lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20210505180738.GN975577@paulmck-ThinkPad-P17-Gen-1>
References: <ebac01302ecae6cc2dd0ace8fcfffa6ab593e0fe.camel@suse.com>
 <580855125.21864.1619808103861.JavaMail.zimbra@efficios.com>
 <46bbe62ed2ebed63b6566516c792591deaf52a4a.camel@suse.com>
 <1131444540.26817.1620226018595.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1131444540.26817.1620226018595.JavaMail.zimbra@efficios.com>
Subject: Re: [lttng-dev] User-space RCU: call rcu_barrier() before
 dissociating helper thread?
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, May 05, 2021 at 10:46:58AM -0400, Mathieu Desnoyers wrote:
> ----- On May 5, 2021, at 3:54 AM, Martin Wilck mwilck@suse.com wrote:
> =

> > On Fri, 2021-04-30 at 14:41 -0400, Mathieu Desnoyers wrote:
> >> ----- On Apr 29, 2021, at 9:49 AM, lttng-dev
> >> lttng-dev@lists.lttng.org=A0wrote:
> >> =

> >> > In multipath-tools, we are using a custom RCU helper thread, which
> >> > is cleaned
> >> > out
> >> > on exit:
> >> > =

> >> > https://github.com/opensvc/multipath-tools/blob/23a01fa679481ff11441=
39222fbd2c4c863b78f8/multipathd/main.c#L3058
> >> > =

> >> > I put a call to rcu_barrier() there in order to make sure all
> >> > callbacks had
> >> > finished
> >> > before detaching the helper thread.
> >> > =

> >> > Now we got a report that rcu_barrier() isn't available before user-
> >> > space RCU 0.8
> >> > (https://github.com/opensvc/multipath-tools/issues/5) (and RHEL7 /
> >> > Centos7
> >> > still has 0.7.16).
> >> > =

> >> > Question: was it over-cautious or otherwise wrong to call
> >> > rcu_barrier() before
> >> > set_thread_call_rcu_data(NULL)? Can we maybe just skip this call?
> >> > If no, what
> >> > would be the recommended way for liburcu < 0.8 to dissociate a
> >> > helper thread?
> >> > =

> >> > (Note: I'm not currently subscribed to lttng-dev).
> >> =

> >> First of all, there is a significant reason why liburcu does not free
> >> the "default"
> >> call_rcu worker thread data structures at process exit. This is
> >> caused by the fact that
> >> a call_rcu callback may very well invoke call_rcu() to re-enqueue
> >> more work.
> >> =

> >> AFAIU this is somewhat similar to what happens to the Linux kernel
> >> RCU implementation
> >> when the machine needs to be shutdown or rebooted: there may indeed
> >> never be any point
> >> in time where it is safe to free the call_rcu worker thread data
> >> structures without leaks,
> >> due to the fact that a call_rcu callback may re-enqueue further work
> >> indefinitely.
> >> =

> >> So my understanding is that you implement your own call rcu worker
> >> thread because the
> >> one provided by liburcu leaks data structure on process exit, and you
> >> expect that
> >> call rcu_barrier once will suffice to ensure quiescence of the call
> >> rcu worker thread
> >> data structures. Unfortunately, this does not cover the scenario
> >> where a call_rcu
> >> callback re-enqueues additional work.
> > =

> > I understand. In multipath-tools, we only have one callback, which
> > doesn't re-enqueue any work. Our callback really just calls free() on a
> > data structure. And it's unlikely that we'll get more RCU callbacks any
> > time soon.
> > =

> > So, to clarify my question: Does it make sense to call rcu_barrier()
> > before set_thread_call_rcu_data(NULL) in this case?
> =

> Yes, it would ensure that all pending callbacks are executed prior to
> removing the worker thread. And considering that you don't have chained
> callbacks, it makes sense to invoke rcu_barrier() only once.

If you do have chained callbacks, one trick is to:

1.	Prevent your application from doing any more new invocations
	of call_rcu().

2.	Set a flag that prevents any future callbacks from chaining.

3.	Do two calls to rcu_barrier(), one to wait for pre-existing
	callbacks and another to wait for any additional chained
	callbacks that happened concurrently with #2 above.

							Thanx, Paul
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
