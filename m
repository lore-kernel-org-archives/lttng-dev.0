Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D0EEE49A0
	for <lttng-dev@archiver.kernel.org>; Wed, 23 Aug 2023 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1692802531;
	bh=AoNuiIHm28tIzR1+DFgaMc6E1Kf9TogcQ9tjwGQKjm0=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jaSBDhsGuOiPCh+4KeGVy+QwX4QD7Z86NXdJekxfySGvGv20VEyZSnvCcoqXAciaG
	 deYtFSMaChmh2HkPEFNApCNxNyh5n04aTF171VFXK2BDRpbW4skPe7NjSEQz2AbnR+
	 GHMUgwfKv1W2jUZeAATE8Z10bi2gZP0uZqsmb88J/W0E8p/2c7FdgDSqEolTIc5jK5
	 18Ay1NNbVTLPmJX9rFtJtmGuDr97xy1BNBnTlA5nxI4eTcURz+PpXT69EV5c4+5DBD
	 gnP5qsb7TgnEYOfPKVrEsxomFhMD/aZuEMPBxYHh8QVelsU5f9dv35HV84zB0uTl/G
	 M09941FGVd/mQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RW8Qp4CJlz2Q7p;
	Wed, 23 Aug 2023 10:55:30 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4RW8Qn5wRKz2QMw
 for <lttng-dev@lists.lttng.org>; Wed, 23 Aug 2023 10:55:29 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BAE2C62B82;
 Wed, 23 Aug 2023 14:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00181C433C7;
 Wed, 23 Aug 2023 14:47:47 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 88CD4CE02EE; Wed, 23 Aug 2023 07:47:47 -0700 (PDT)
Date: Wed, 23 Aug 2023 07:47:47 -0700
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Message-ID: <cb0e05c0-c1ff-4ee2-8abe-e3134f86cfae@paulmck-laptop>
References: <87v8gzuc3g.fsf@laura> <87jztxjpxa.fsf@laura>
 <df134b32-9e1b-8deb-14fc-b09f02e2e678@efficios.com>
 <cf12aa23-f3ad-e286-58b6-ae1b7e70b9e2@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cf12aa23-f3ad-e286-58b6-ae1b7e70b9e2@efficios.com>
Subject: Re: [lttng-dev] [RFC] Deprecating RCU signal flavor
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
Cc: Olivier Dion <odion@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Mon, Aug 21, 2023 at 11:43:32AM -0400, Mathieu Desnoyers wrote:
> On 8/15/23 08:38, Mathieu Desnoyers via lttng-dev wrote:
> > On 8/14/23 17:05, Olivier Dion via lttng-dev wrote:
> > > =

> > > After discussing it with Mathieu, we agree on the following 3 phases =
for
> > > deprecating the signal flavor:
> > > =

> > > =A0 1) liburcu-signal will be implemented in term of liburcu-mb. The =
only
> > > =A0 difference between the two flavors will be the public header file=
s,
> > > =A0 linked symbols and library name.=A0 Note that this add a regressi=
on in
> > > =A0 term of performance, since the implementation of liburcu-mb adds =
memory
> > > =A0 barriers on the reader side which are not present in the original
> > > =A0 liburcu-signal implementation.
> > > =

> > > =A0 2) Adding the deprecated attribute to every public functions expo=
sed by
> > > =A0 the liburcu-signal flavor.=A0 At this point, tests for liburcu-si=
gnal
> > > =A0 will also be removed from the project.=A0 There will be no more s=
upport
> > > =A0 for this flavor.
> > > =

> > > =A0 3) Removing the liburcu-signal flavor completely from the project.
> > > =

> > > Finally, here is a tentative versions release of mine for each phase:
> > > =

> > > =A0 1) 0.15.0 [October 2023] (also TSAN support yay!)
> > > =

> > > =A0 2) 0.15.1
> > > =

> > > =A0 3) 0.16.0 || 1.0.0 (maybe a major bump since this is an API break=
ing
> > > =A0 change)
> > =

> > There is a distinction between the version number of the liburcu project
> > (0.14) and the ABI soname for the shared objects. We may be able to do
> > step (3) without going to 1.0.0 (I don't see removal of the urcu-signal
> > flavor a strong enough motivation for hitting 1.0.0 yet).
> > =

> > Technically speaking, given that we would be removing the entire
> > liburcu-signal.so shared object, we would not be changing _symbols_
> > within an existing shared object, therefore I'm not even sure we need to
> > bump the soname for all the other remaining shared objects.
> =

> So after merging this commit:
> =

>     Phase 1 of deprecating liburcu-signal
>     The first phase of liburcu-signal deprecation consists of implementing
>     it in term of liburcu-mb. In other words, liburcu-signal is identical=
 to
>     liburcu-mb at the exception of the function symbols and public header
>     files.
>     This is done by:
>       1) Removing the RCU_SIGNAL specific code in urcu.c
>       2) Making the RCU_MB specific code also specific to RCU_SIGNAL in
>       urcu.c
>       3) Rewriting _urcu_signal_read_unlock_update_and_wakeup to use a
>       atomic store with CMM_SEQ_CST instead of a store CMM_RELAXED with
>       cmm_barrier() around it. We could keep the explicit barriers, but t=
hat
>       would require to add some cmm_annotate annotations. Therefore, to be
>       less intrusive in a public header file, simply use the CMM_SEQ_CST
>       like for the mb flavor.
> =

> I notice that an application previously built against urcu-signal with
> _LGPL_SOURCE defined would have to be rebuilt, which would require a
> soname bump of urcu-signal.
> =

> So considering that this phase 1 is not really a "drop in" replacement,
> I favor removing the urcu-signal flavor entirely before the next release.
> =

> Thoughts ?

The replacement is liburcu-mb, correct?

I will need to change perfbook, but that should be an easy change,
plus sys_membarrier() is widely available by now.

							Thanx, Paul
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
