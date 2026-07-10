Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C79BC44501
	for <lttng-dev@archiver.kernel.org>; Fri, 10 Jul 2026 04:16:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gxJRl5cPyz10Hn
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1783656981;
	b=mO+BRbOnti2qcqXhCRRauaP4ukaCuP+uhseLDCm+qLSd0Xl7XbiUkQOXKWnJbyrfCAQq
	 MtvCHzEM7nJL71sep5u2ehkcWvVnwEdS8/24ONtukso9T0jkWWX8isGOGPvyQBlbQvJpj
	 bDu712OfdUC2Zn1sKpneMgzUELXevFa+5Xl1nOaXGc1KlhEQO/rmK34D5lpv8Y8s2hni5
	 qlO6xUMbPBL0B00Wo6UuTi+lK4ROHdheFczn4Oql6NFSi3L/e9Nh4d84R1+vACDOLC3PH
	 Sz6sxpPFG7/N2P0L0m1wH5oTN2Rt4x/Nle2FSwkkoBkhc69O/qWApi/AiSR7fCr7Nxw==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1783656981;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=l3i3e/1a+VsihdwztGA5VoHYX51ALAJbjQucSCy84cQ=;
	b=JfzVQ3o0D7nwUuQplyxLeiMHeK6Q8yM2NhLxPYgmx5M8AbBHbh/Hf4cY0RdIY7Xtxvs3
	 tYBL+SdW03tI3tbVP8PbxzmLdSUggy125Oe60h/dEYTpHPUOId3f9201Wq11oPwaCtt3B
	 IlorOQgA8QfR0+C6+aP8we15oEkGYeakDuMwUAyPIWybC6+N1MR6/yNF2Wh5xNUSRqfM5
	 F/SwCWAVqWzdrI77bkxm2NZ/YZpQWxbSoLSfH8W/c853RHFHT8ejGDG1SJtZhIpuNZQvr
	 I1f/KjyrEhKtTSnoF0aH8vAcu6JFF+BwSWq+eQKV6sA9t8IhIx54YuAowrba9Ku3FIQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gxJRl5cPyz10Hn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1783656981;
	bh=ZnwlTzNT/EG4PVpMSGnV9pbISQ2kfn5ToqPCWuvY50w=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=drgcg9xt558T9QH7k2Fw2A2uPa1wyT+LHW3gerhIbzFFVYqYXcRiM21xIa3PekmOO
	 L+wegen01ZanJNXPPcZIIdX9TKgwshdtbJekuigwOxajhAgDE5WafNvbOQTfC2u7Eu
	 gaWwaJxLeD58t5WV+L2Es/AEjAdTkt+t3DxSTyMDck7xuHFrQBQzdMbGEv0H9B8tJq
	 0qTb8FDZGKpmVzmjruTvMYHE1GbmA0B/xrqPcW8zL7m6ZwmcvsmKylUPFRp3ysPbBB
	 c3N9hnXbpL7KMIs062NF4klCMeigRecvXokI3qRERUDnl7fbrEt+eAoplAGREwD16K
	 gYnAZRkyyEOKw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gxJRl5cPyz10Hn;
	Fri, 10 Jul 2026 00:16:19 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gxJRk3tKGz10Hm
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gxJRk3tKGz10Hm
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by lists.lttng.org (Postfix) with ESMTPS id 4gxJRk3tKGz10Hm
 for <lttng-dev@lists.lttng.org>; Fri, 10 Jul 2026 00:16:18 -0400 (EDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7DB76001A;
 Fri, 10 Jul 2026 04:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8178F1F000E9;
 Fri, 10 Jul 2026 04:07:57 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 450F3CE0F42; Thu,  9 Jul 2026 21:07:57 -0700 (PDT)
Date: Thu, 9 Jul 2026 21:07:57 -0700
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>,
	Olivier Dion <odion@efficios.com>
Subject: Re: CPU affinity behavior of liburcu call-rcu per-cpu worker threads
Message-ID: <95f2d189-ebe2-47f1-91db-c964f2cda8a7@paulmck-laptop>
References: <e8fa9744-74d2-4fae-8684-f1df59aec1c0@efficios.com>
 <0600b601-3edf-4897-b319-b4763943809c@efficios.com>
 <3573944e-3abc-48d7-aedf-3362ebd7ebe4@paulmck-laptop>
 <38f1f93e-3bfa-425a-96d9-3035c8ecc785@efficios.com>
 <1aaa979b-bad9-47a5-879b-b4fb2379ad20@paulmck-laptop>
 <a25cc916-2bb3-4133-afcb-230dd577726d@efficios.com>
 <02709be9-d7d8-47cc-8032-ed2e3a714fb0@paulmck-laptop>
 <14541751-5104-483b-b60c-415d791b4bf4@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14541751-5104-483b-b60c-415d791b4bf4@efficios.com>
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
From: "Paul E. McKenney via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: paulmck@kernel.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Thu, Jul 09, 2026 at 10:56:51PM -0400, Mathieu Desnoyers wrote:
> On 2026-07-09 22:53, Paul E. McKenney wrote:
> [...]
> > 
> > > And unfortunately, for me, tcmalloc is really not a viable option,
> > > because it needs to own the RSEQ area registration, and because glibc
> > > cannot use it at the same time as tcmalloc, my benchmarks suffer because
> > > glibc has a slower sched_getcpu() implementation.
> > > 
> > > So jemalloc it is. tcmalloc is not usable for me because they don't
> > > compose with the rest of the world. I warned the tcmalloc developers
> > > many times, but they did not listen. :-(
> > 
> > So an alternative rseq for the rest of us?
> 
> I'm not quite sure I understand. Since there is only one rseq
> registration per thread, this means that tcmalloc require their
> users to use a GLIBC tunable to disable rseq registration at the
> libc level, leaving rseq solely to tcmalloc.

Could an independent thing very closely resembling rseq be brought into
being alongside the current rseq, so that tcmalloc gets the existing
one and everyone else plays nice and shares the new one?

							Thanx, Paul
