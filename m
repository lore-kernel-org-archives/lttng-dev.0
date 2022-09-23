Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0972C04A95
	for <lttng-dev@archiver.kernel.org>; Fri, 23 Sep 2022 22:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1663970715;
	bh=2aw5+6vEDuL8sHpC4abUPoDtRACSdHW248TQ4D8h2DM=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hIjfrwmXVQ7Yy+/GqjPraSayCwM949xWP0gHgpUOhjjyCECWw1XGDRi7tZEDwP5sB
	 Lr5wnpvg3Gpx1qlZW+HElmpYLCLhGpg0cuQw8CrTmL304A5iTFZSPgC4V54NDmB23V
	 Z2jdgiuDSbIj7ShkxLuIZg4BmWmQO83ZQMIFeAtEN0fH2izJsFNA5UA4ymYiY36MmF
	 Q8zQ9vlgnISLnKbOezcFNFKWNnOwdG1PGQj4V0JElacutlc1usV53Sp7UmKwPTyRDq
	 zpxBx7ePPgdfyO80HeTh5NVSy+iN2kG1KpOcvpDKT9iXnXDitk/Wez+N+3RADlo1Db
	 QSsV1x2Db1FXA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MZ5mq100cz249g;
	Fri, 23 Sep 2022 18:05:15 -0400 (EDT)
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
 by lists.lttng.org (Postfix) with ESMTPS id 4MZ5mn59qtz244t
 for <lttng-dev@lists.lttng.org>; Fri, 23 Sep 2022 18:05:13 -0400 (EDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
 by dcvr.yhbt.net (Postfix) with ESMTP id 170331F506;
 Fri, 23 Sep 2022 22:05:11 +0000 (UTC)
Date: Fri, 23 Sep 2022 22:05:10 +0000
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20220923220510.M990534@dcvr>
References: <20220922091536.GA4597@dcvr>
 <eb0bc02c-904d-1166-ddcc-39bbece70a67@efficios.com>
 <20220923175503.M564483@dcvr>
 <6db30f66-8237-fef3-d92a-2e36be9efdf6@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6db30f66-8237-fef3-d92a-2e36be9efdf6@efficios.com>
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
> On 2022-09-23 13:55, Eric Wong wrote:
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > > On 2022-09-22 05:15, Eric Wong via lttng-dev wrote:
> > > > Hello, I'm using urcu-bp + rculfhash + call_rcu to implement
> > > > malloc instrumentation (via LD_PRELOAD) on an existing
> > > > single-threaded Perl codebase which uses Linux signalfd.
> > > > 
> > > > signalfd depends on signals being blocked in all threads
> > > > of the process, otherwise threads with unblocked signals
> > > > can receive them and starve the signalfd.
> > > > 
> > > > While some threads in URCU do block signals (e.g. workqueue
> > > > worker for rculfhash), the call_rcu thread and rculfhash
> > > > partition_resize_helper threads do not...
> > > > 
> > > > Should all threads URCU creates block signals (aside from SIGRCU)?
> > > 
> > > Yes, I think you are right. The SIGRCU signal is only needed for the
> > > urcu-signal flavor though.
> > > 
> > > Would you like to submit a patch ?
> > 
> > Sure.
> > 
> > Is there a way to detect at runtime when urcu-signal is in use
> > so SIGRCU (SIGUSR1) doesn't get unblocked when using other flavors?
> > 
> > I actually use SIGUSR1 in my signalfd-using codebase.
> > 
> > I also want to remove cds_lfht_worker_init entirely since it's racy.
> > Signal blocking needs to be done in the parent before pthread_create
> > to avoid a window where the child has unblocked signals.
> > 
> > Thanks.  Anyways, this is my work-in-progress:
> > 
> 
> Perhaps with this on top of your wip patch ? The idea is to always block all
> signals before creating threads, and only unblock SIGRCU when registering a
> urcu-signal thread. (compile-tested only)

Thanks, that makes sense.  It passes: make check short_bench

My original signalfd + urcu-bp case works well, too, with my
constructor workarounds reverted. (I ported our patches ported to
to 0.10.2 for Debian buster (oldstable)).

I don't know if the existing test coverage is sufficient,
though.  Waiting on regtest...
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
