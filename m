Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4428C6FA8B
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Sep 2022 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1663838590;
	bh=7uD0MYCmFAPf7ByDqC2JT8/RkEiuLrMRXCi/o99ujQ8=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=QXysKks7KYTspkyDQMwfSHQdETu4jNmDYEWtCSukMmNun+R6epLDLRuWwdJW/pzG5
	 SvJ4TR+owgLnJ7wGCV8J1EYynuWBsGgAInUxcGGL+B8dtfVkyc637DbKDrgsoPRp5G
	 +Xt/ErFo5lNgRFGPvtMtELQ86tFCuZcWeMg3CRKTw0RnMLpWLAqskzlIAiGDbnKs8/
	 VgXWUKAOroSh2u3Ls6RGYEyI0g+9qgpLQGIHkv6actQTzq2qC9wIpblKi+0Q8yYIRP
	 /dmqLiA4DrA1rSXogoHyBek3V9GigJxdmspS0bNH6SDVK01T92SYT9DrFk7BMbQuPs
	 mdMip1EkrjRWQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MY8vy1GFzz23pJ;
	Thu, 22 Sep 2022 05:23:10 -0400 (EDT)
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
 by lists.lttng.org (Postfix) with ESMTPS id 4MY8vw5ZYYz245K
 for <lttng-dev@lists.lttng.org>; Thu, 22 Sep 2022 05:23:08 -0400 (EDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
 by dcvr.yhbt.net (Postfix) with ESMTP id D3CE51F506;
 Thu, 22 Sep 2022 09:15:36 +0000 (UTC)
Date: Thu, 22 Sep 2022 09:15:36 +0000
To: lttng-dev@lists.lttng.org
Message-ID: <20220922091536.GA4597@dcvr>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] URCU background threads vs signalfd
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

Hello, I'm using urcu-bp + rculfhash + call_rcu to implement
malloc instrumentation (via LD_PRELOAD) on an existing
single-threaded Perl codebase which uses Linux signalfd.

signalfd depends on signals being blocked in all threads
of the process, otherwise threads with unblocked signals
can receive them and starve the signalfd.

While some threads in URCU do block signals (e.g. workqueue
worker for rculfhash), the call_rcu thread and rculfhash
partition_resize_helper threads do not...

Should all threads URCU creates block signals (aside from SIGRCU)?

There might be other places, too, I haven't looked too closely...

Anyways, I'm currently relying on this workaround to ensure
initial calls to call_rcu and cds_lfht_resize are run with
signals blocked:

/* error-checking omitted for brevity */
__attribute__((constructor)) static void my_ctor(void)
{
	sigset_t set, old;
	struct foo_hdr *h;

	sigfillset(&set);
	pthread_sigmask(SIG_SETMASK, &set, &old);

	g_tbl = cds_lfht_new(8192, 1, 0, CDS_LFHT_AUTO_RESIZE, 0);

	h = malloc(sizeof(struct foo_hdr)));
	if (h) /* force call_rcu to start background thread */
		call_rcu(&h->as.dead, free_foo_hdr_rcu);

	/* start more background threads before unblocking signals */
	cds_lfht_resize(g_tbl, 16384);

	pthread_sigmask(SIG_SETMASK, &old, NULL);
}

But I suspect it's better to ensure signals are blocked in all
URCU-created threads...

Thanks.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
