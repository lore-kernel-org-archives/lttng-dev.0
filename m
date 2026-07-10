Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE92C43458
	for <lttng-dev@archiver.kernel.org>; Fri, 10 Jul 2026 18:58:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gxh142Ktgz17t8
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1783709882;
	b=lFCs5AMGKsZ5SzCaFzRv4mcAXuFfePJDdhq42FeJu7KypOOmKvqLzlnBMrHwwVgDQc2i
	 Zs5BGhUHChzA5VzFW2ZBzpE/hwB1hmmn52D7I3GrupU4eCDHnjLGCGG2qqPOq/vhWuG1j
	 q9nqmlebesGb4NpQGOJs0TpldKvfBf/k2sKDRIENySLr9MDVyDENopVPavOSn+do3sdR5
	 FOs98zXzVbpeW85aC/DtKpqhk6hgbx03I67dfD0enb+ovMo5CCBRXFguld6A2hhbhKHtP
	 eAam5kiy/bcxZcTSdQJ67HFm43doHG/7whOFW9VtNO2igfVOU9GxdzIT28z01id/Cvw==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1783709882;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=H/1nZFPAPaL8u258fAFdTfJ9LqkIDbztbA7siY2WH/Y=;
	b=N6Js7JT01OVzIqbnCagDc4LlYXxSG6novGTafYq24YDbgni0L1Jg8d2h6dDxQWQ4opfg
	 XcGG0CSRJRHr+Tja3Ng/amA49J5pSpVMx7m7vTEf47pc6fkFEO39V/qQomWDEC/xDJfGJ
	 Ed1eygmQYbDY1RUpGnla/h7B/4iRMaldgoBpsjSZqN/nfZvF/w44CQmDXRNeY89e2iZ8q
	 EZmrEBsTXdgEXFhOcjSdfzrYqLrEg0aU+zsiafoLkmvAqYGT+Xn2OPmfuw42DyPLUt5V7
	 pV39gLZ4MVxotQo0obFyHiBgypsYIg1YrlzH0rxBOxkheeNqkkdyxVQmS14Sv5wlCtA==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gxh142Ktgz17t8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1783709882;
	bh=cs43+sY+FfljqfKLFyTLcca/NrAozLY9ZTEKE74lCVw=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=sDmhoQvfiCnR5TY9bXJGOC/XArad6Wa0KwjCUQwuAJ06NU0rQDgFSQPocAlQw3jZg
	 1ebhAI5KaTdJWXVdbzmUxT2MnLMo4Jf00ybPgvCFqmDJWMtKzEpwri7sIy+QpAVFF8
	 bQ/oh5ZeatEpEk2eHtso9i0XXVFGeHBxXL+TDuoXeZwBgLC9z9BJguG804dcnF948d
	 aVJyarwKX/saGBlBvTv5SJwDqxFBwBJgrZ/j2ZRWaqQUalVGX/F5cgfqDTHlPCr2Hg
	 E82rp7WjxUck47ZL1P4v47qtPRZUuNCewcn8Jb47PvYv0BRR7kXWMzdNA4+f78wZB/
	 SfvxEfLkEb4mA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gxh142Ktgz17t8;
	Fri, 10 Jul 2026 14:58:00 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gxh1122cTz18Rk
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gxh1122cTz18Rk
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by lists.lttng.org (Postfix) with ESMTPS id 4gxh1122cTz18Rk
 for <lttng-dev@lists.lttng.org>; Fri, 10 Jul 2026 14:57:57 -0400 (EDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13C3342D54;
 Fri, 10 Jul 2026 18:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFA21F000E9;
 Fri, 10 Jul 2026 18:57:53 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id BF7BFCE084A; Fri, 10 Jul 2026 11:57:53 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:57:53 -0700
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>,
	Olivier Dion <odion@efficios.com>
Subject: Re: CPU affinity behavior of liburcu call-rcu per-cpu worker threads
Message-ID: <8d48389d-5cf8-46b1-a6da-7738e11e3737@paulmck-laptop>
References: <e8fa9744-74d2-4fae-8684-f1df59aec1c0@efficios.com>
 <0600b601-3edf-4897-b319-b4763943809c@efficios.com>
 <3573944e-3abc-48d7-aedf-3362ebd7ebe4@paulmck-laptop>
 <38f1f93e-3bfa-425a-96d9-3035c8ecc785@efficios.com>
 <1aaa979b-bad9-47a5-879b-b4fb2379ad20@paulmck-laptop>
 <a25cc916-2bb3-4133-afcb-230dd577726d@efficios.com>
 <02709be9-d7d8-47cc-8032-ed2e3a714fb0@paulmck-laptop>
 <14541751-5104-483b-b60c-415d791b4bf4@efficios.com>
 <95f2d189-ebe2-47f1-91db-c964f2cda8a7@paulmck-laptop>
 <b37eebf7-1500-4b41-bb65-074473b35cd9@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b37eebf7-1500-4b41-bb65-074473b35cd9@efficios.com>
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

On Fri, Jul 10, 2026 at 12:17:39AM -0400, Mathieu Desnoyers wrote:
> On 2026-07-10 00:07, Paul E. McKenney wrote:
> > On Thu, Jul 09, 2026 at 10:56:51PM -0400, Mathieu Desnoyers wrote:
> > > On 2026-07-09 22:53, Paul E. McKenney wrote:
> > > [...]
> > > > 
> > > > > And unfortunately, for me, tcmalloc is really not a viable option,
> > > > > because it needs to own the RSEQ area registration, and because glibc
> > > > > cannot use it at the same time as tcmalloc, my benchmarks suffer because
> > > > > glibc has a slower sched_getcpu() implementation.
> > > > > 
> > > > > So jemalloc it is. tcmalloc is not usable for me because they don't
> > > > > compose with the rest of the world. I warned the tcmalloc developers
> > > > > many times, but they did not listen. :-(
> > > > 
> > > > So an alternative rseq for the rest of us?
> > > 
> > > I'm not quite sure I understand. Since there is only one rseq
> > > registration per thread, this means that tcmalloc require their
> > > users to use a GLIBC tunable to disable rseq registration at the
> > > libc level, leaving rseq solely to tcmalloc.
> > 
> > Could an independent thing very closely resembling rseq be brought into
> > being alongside the current rseq, so that tcmalloc gets the existing
> > one and everyone else plays nice and shares the new one?
> 
> That would unfortunately roll the clock backward about 5 years in terms
> of glibc integration, which supports rseq out of the box since version
> 2.35 (Feb 2022).
> 
> Moreover, if we add a second rseq area, this means the kernel now need
> to have code to support both areas in key performance-critical code
> areas (scheduler, interrupt entry/exit).
> 
> So no, as far as I am concerned, this is really not an option.
> 
> The "simpler" option would be to implement the rseq extension tcmalloc
> need, so they can finally stop doing their odd games and become
> compatible with the rest of the world. But the last time I offered to
> help them on this front I've been told that they would not even have
> time to try my patches.
> 
> Oh well.

I bet that there is a way, but thus far I at least add a load and a branch
to those fastpaths.  Maybe convince someone to submit the needed patches
to tcmalloc() and then browbeat the tcmalloc() folks into accepting them?
You would need someone young, energetic, and obnoxious, which lets me
off on two of the three.  ;-)

							Thanx, Paul
