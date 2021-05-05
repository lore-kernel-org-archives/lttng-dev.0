Return-Path: <SRS0=ctY1=KA=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42555C433B4
	for <lttng-dev@archiver.kernel.org>; Wed,  5 May 2021 21:30:57 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C90261106
	for <lttng-dev@archiver.kernel.org>; Wed,  5 May 2021 21:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C90261106
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fb8yk52gnz1j77;
	Wed,  5 May 2021 17:30:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1620250255;
	bh=RT+Xx6bNQqR/FZ6gSCctwguAfEY7OYwmUw7EuNboj7I=;
	h=To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qD7GYdureV01SoY91GxEoHFgVMT55HEti6T2q5HLo102/n1LP3q/kyWI570PEoos8
	 VaoHDABgc7klYbQ+P8cPFsKFmUm2z1pjIuHKsSH93ADA9habPgUk741nJzIHotgY33
	 2Xmn7F59cnsGN5hQ+yqlDz/Uc+YOCGN/xs/hrFSzIDM0oU5r17oOmq+AREDi/PSw6y
	 JyKa0lb9/eQLR97Vd4W7regttveFng2jyxuV9lKmPuJ8jlPGiQhEw4F1z1s5KNr78S
	 GEeZvl7ww43vN/vF265D9HIuVNVxQUbnNuwRntPNajrXx48/OoHLZg4mxSGF7+XWNK
	 h/aWuob9gqngQ==
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fb8yc01J7z1htP
 for <lttng-dev@lists.lttng.org>; Wed,  5 May 2021 17:30:47 -0400 (EDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3EFC7AFD5;
 Wed,  5 May 2021 21:30:40 +0000 (UTC)
Message-ID: <0b93eda87cfc7f4acccc9af97c46d60ffbd5713b.camel@suse.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: paulmck <paulmck@kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>
Date: Wed, 05 May 2021 23:30:39 +0200
In-Reply-To: <1131444540.26817.1620226018595.JavaMail.zimbra@efficios.com>
References: <ebac01302ecae6cc2dd0ace8fcfffa6ab593e0fe.camel@suse.com>
 <580855125.21864.1619808103861.JavaMail.zimbra@efficios.com>
 <46bbe62ed2ebed63b6566516c792591deaf52a4a.camel@suse.com>
 <1131444540.26817.1620226018595.JavaMail.zimbra@efficios.com>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
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
From: Martin Wilck via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello Mathieu,

thanks again.

On Wed, 2021-05-05 at 10:46 -0400, Mathieu Desnoyers wrote:
> > > =

> > > So my understanding is that you implement your own call rcu
> > > worker
> > > thread because the
> > > one provided by liburcu leaks data structure on process exit, and
> > > you
> > > expect that
> > > call rcu_barrier once will suffice to ensure quiescence of the
> > > call
> > > rcu worker thread
> > > data structures. Unfortunately, this does not cover the scenario
> > > where a call_rcu
> > > callback re-enqueues additional work.
> > =

> > I understand. In multipath-tools, we only have one callback, which
> > doesn't re-enqueue any work. Our callback really just calls free()
> > on a
> > data structure. And it's unlikely that we'll get more RCU callbacks
> > any
> > time soon.
> > =

> > So, to clarify my question: Does it make sense to call
> > rcu_barrier()
> > before set_thread_call_rcu_data(NULL) in this case?
> =

> Yes, it would ensure that all pending callbacks are executed prior to
> removing the worker thread. And considering that you don't have
> chained
> callbacks, it makes sense to invoke rcu_barrier() only once.
> =

> > If yes, is there an
> > alternative for safely detaching the custom RCU thread if
> > rcu_barrier()
> > is unavailable?
> =

> I suspect you could re-implement something similar to rcu_barrier()
> within
> your application through call_rcu and a rendez-vous synchronization.
> It
> all depends on how much complexity you want to add to your
> application
> for the sake of not leaking data structures when using old versions
> of
> liburcu.

Thanks, but I'm definitely not up to that task :-) As I said, our
software is using liburcu in a rather trivial way. What I'll do is
avoid creating and tearing down the custom RCU thread with liburcu
older than 0.8. Thus we'll end up with a minor memory leak on the
affected (old) distributions, which is acceptable.

> > =

> > > So without knowing more details on the reasons why you wish to
> > > clean
> > > up memory at
> > > process exit, and why it would be valid to do so in your
> > > particular
> > > use-case, it's
> > > rather difficult for me to elaborate a complete answer.
> > =

> > multipathd is a long-running process, so being wary of memory leaks
> > is
> > important. valgrind tests pop up an ugly warning about liburcu -
> > it's
> > obviously not a big issue, as it occurs only on exit, but it makes
> > a
> > negative impression on users running memory leak tests. It's
> > possible
> > to work around that by using valgrind "suppressions", but so far my
> > policy was to use these only as last resort measure, in case we
> > couldn't find any way to work around it in our code. That's why I
> > came
> > up with the "custom RCU thread" approach.
> > =

> > Anyway, from what you're saying, it might be be better to simply
> > accept
> > the fact that this pseudo-memory-leak exists than trying to fix it
> > in
> > an unsafe way with older liburcu versions.
> =

> If we push this line of thinking to the extreme, we should look into
> what
> improvement should be to to liburcu upstream so we fix this situation
> in
> the future, and then you can decide how you want to handle legacy
> liburcu
> on your side.
> =

> > > I can see that maybe we could change liburcu to make it so that
> > > we
> > > free all
> > > call_rcu data structures _if_ they happen to be empty of
> > > callbacks at
> > > process exit,
> > > after invoking one rcu_barrier. That should take care of not
> > > leaking
> > > data structures
> > > in the common case where call_rcu does not enqueue further
> > > callbacks.
> > > =

> > > Thoughts ?
> > =

> > That would be nice, but it wouldn't help me in the specific case,
> > where
> > I have to deal with an old version of liburcu.
> > =

> > Perhaps you could also consider an API extension by which an
> > application could tell liburcu that it's exiting, and no further
> > callbacks should be scheduled?
> =

> But then how is the application supposed to deal with this ? For
> instance,
> the call_rcu callback could be used to implement a condition variable
> rendez-vous
> point which blocks other parts of the application until it is
> executed.
> =

> I have a few ideas on how to deal with this in liburcu upstream:
> =

> 1) We could implement library destructor functions which cleanup the
> call rcu
> =A0=A0 worker threads (and their data structures) _only if_ they are
> quiescent and
> =A0=A0 their associated callback list is empty.

My idea would be to use an atomic variable that's checked before
every invocation of call_rcu(), in the entire application. If I
understood Paul's response correctly, this combined with two
invocations of rcu_barrier() should do the trick.

The documentation could include an example how to do this correctly.

> =

> 2.1) We could document that the application needs to invoke
> rcu_barrier() before
> =A0=A0=A0=A0 it exits if it wishes to ensure that all call_rcu callbacks =
are
> executed before
> =A0=A0=A0=A0 it exits. We should document that if the application chains
> call_rcu callbacks,
> =A0=A0=A0=A0 it needs to invoke rcu_barrier() as many times as there are
> consecutive chaining.
> =A0=A0=A0=A0 And of course, that a never-ending chaining of call_rcu
> callbacks will necessarily
> =A0=A0=A0=A0 lead to memory leaks at application exit.

This sounds perfectly reasonable. =


> =

> 2.2) Alternatively, we could have the rcu_barrier invoked from within
> liburcu's destructor.
> =A0=A0=A0=A0 The number of times rcu_barrier would be invoked could be
> configured through a new API.
> =A0=A0=A0=A0 The default could be that rcu_barrier is invoked once. An
> application could choose to
> =A0=A0=A0=A0 override this so rcu_barrier is never called at application =
exit
> if it cares more about
> =A0=A0=A0=A0 exiting quickly than leaking memory.
> =

> I would slightly favor approaches (1) + (2.1), because it leaves all
> flexibility to the
> application: if call_rcu is invoked from within a library, then that
> library is free to
> choose how many times it needs to invoke rcu_barrier in its own
> library destructor (e.g.
> on dlclose()).

Ack. If RCU is used by an application _and_ one or more libraries the
application uses, my global flag obviously doesn't work. I believe a
library using RCU should provide some means to signal exiting state via
its API, to avoid further callbacks/chaining in the library.


> In order to make sure the "common use-case" does not leak memory
> though, we could make sure
> liburcu does one rcu_barrier and conditionally cleanup the worker
> thread + data structures if
> the callback list is empty after the barrier.

Not sure about that. It would be a semantic change in the library, no?
I suppose calling rcu_barrier() one more time doesn't hurt, but it's
not my place to advise you about that. Apparently, other users of
liburcu so far haven't complained about the leak, so you might as well
just add a note to the documentation. For a simple use case such as
multipathd, the trick with the custom RCU thread seems to be a valid
workaround. That's fine for me.

Thanks a lot,
Martin


_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
