Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38931C43458
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Jul 2026 21:53:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gx7xR4dPBz29SY
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1783633981;
	b=TRcdqkvRf+6UpNbgvHSCT6jAEyMxLa5KNzcMYiPJ8CXULG3x2xftCmbEfTCaUvHodh9Q
	 Aba7WYS6QQI1Eubk/MKa28HNS/zbFZBCAqHCbwZEOuJr0DKkmEG9p85MEcMboWERvIdZw
	 WO6yy8QXv+1BEjMCCjSoQAZ3cHc+aOHln03Gu6ihK8pLQ2kXhEvp4SJ3XR4fC7f81af2M
	 HOz8ojtA5Pe2N7aWk4DS2EJ9oZDa9GXojQ1Ezjl6QGMYekAPxDw0tIwrGn3nFlTPbaEWp
	 Wq0LnuXXdiKI/9TPP+cz1sMvOrPphJQJNZSEQFtkoIrB91uiYMsVAgxBbHpdiiNshTA==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1783633981;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=W0d9AeIS+tnsysTC1uwzcB3cC5v8OZIKspDeBECsCj0=;
	b=QURqvy4HT7OYK+BoDYsLnOQAQLNamkZqHPwNnlI59bjpMW2wqlmEyEQmpRZgVwycqAT8
	 XlyQnpJU0trUhjwMOSZgq2Wm9aIswm9dY0b5hsZKeN+Z9B/3tApbaZ21NUuvvnzo7WgkP
	 djk304HTVWPJKVq1qJ2xvaeyTPTIhai/f+iezlokGPLKy0bW2PWVuxVzeZYBQd2asM/Tf
	 XtH1icl1gPKVNawOt2XzWGR3mdInFzf5go112zoVq/jA5Tk0e71k7h1Dyl6rTjF1xyO9B
	 GYVh+XWLSf+CQtTfMfPSwEEnT/+DRHnXXC7uBgcJVUFaBS8rRvMy52juShgMJK8aQ9Q==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gx7xR4dPBz29SY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1783633981;
	bh=U2Q9PXVjBfzXXIvJMs7XIbB02eZ37ycEjxBAkf9VJds=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=n8R2wIoJmlVeiXFR5BExlRRpfwUueqcXM70xT8RyoMKE1WSbRq64iJEthAltj2/P7
	 NwDakQiMfMKqVbD//navqB1q/3m9gguarw6Ih4PAxL/oCR5LkrbSgHUhT6BhPCVDMe
	 J7hBYRxpd2cYHsKudB7eEgccOCkr/kI1Sqq4C7fV7xi1/Hf/oHTTuoF4RNBrlx6QND
	 G4tWvO1BIyptVB9EwqnlRTVpEK4WQ9XdZwoKVokWLyIWdI3lKhaQopHKOJQGFfxZNB
	 t0EWip7bebYSokvXTistFb34fjXU2zS8HNT/FKJ4/hvBvF9MtwTshizi5fIAikGw7L
	 J0RqgBppJS9QQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gx7xR4dPBz29SY;
	Thu,  9 Jul 2026 17:52:59 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gx7xP3x9Dz29GT
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gx7xP3x9Dz29GT
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by lists.lttng.org (Postfix) with ESMTPS id 4gx7xP3x9Dz29GT
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jul 2026 17:52:57 -0400 (EDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE176431E1;
 Thu,  9 Jul 2026 21:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B217C1F000E9;
 Thu,  9 Jul 2026 21:45:18 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 82D0ACE0F1C; Thu,  9 Jul 2026 14:45:18 -0700 (PDT)
Date: Thu, 9 Jul 2026 14:45:18 -0700
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>,
	Olivier Dion <odion@efficios.com>
Subject: Re: CPU affinity behavior of liburcu call-rcu per-cpu worker threads
Message-ID: <3573944e-3abc-48d7-aedf-3362ebd7ebe4@paulmck-laptop>
References: <e8fa9744-74d2-4fae-8684-f1df59aec1c0@efficios.com>
 <0600b601-3edf-4897-b319-b4763943809c@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0600b601-3edf-4897-b319-b4763943809c@efficios.com>
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

On Thu, Jul 09, 2026 at 04:00:17PM -0400, Mathieu Desnoyers wrote:
> On 2026-07-09 14:48, Mathieu Desnoyers wrote:
> > Hi Paul,
> > 
> > I have a question related to liburcu per-cpu call-rcu worker threads.
> > 
> > So far in the current liburcu releases no affinity is set when the
> > worker threads are started. We have to wait for
> > SET_AFFINITY_CHECK_PERIOD_MASK grace periods before the affinity is set
> > (it takes about 2.5s in my benchmarks).
> > 
> > This means that short-lived test programs will get poor CPU affinity
> > for call-rcu worker threads at the beginning of their lifetime. So for
> > short lived programs, this means poor performance.
> > 
> > OTOH, if we have short-lived applications on a large machine, setting
> > the affinity immediately when the worker thread is starting means
> > we use CPU time on CPUs which may never be actually used by the
> > application (no call-rcu activity), which can be detrimental to other
> > use-cases as well.
> > 
> > So I was wondering: is the choice of skipping setting the affinity
> > on call-rcu worker thread startup done on purpose ? And if so,
> > should we perhaps consider setting the affinity as soon as the
> > worker thread is woken up for the first time rather than after
> > SET_AFFINITY_CHECK_PERIOD_MASK grace periods ?

My approach when I first implemented call_rcu() was that the typical
application would have lots of reads and very few updates, so the
default was a single call_rcu() thread shared by all worker threads.
I allowed for manual configuration and affinity of call_rcu() threads
for special-case high-update-rate applications.

My hope was that we would be able to use per-CPU call_rcu() threads
with something like rseq allowing the worker threads to move around
arbitrarily but still getting good cache affinity in their interactions
with the call_rcu() threads.  Easy to say, I know!  ;-)

> I've implemented this compromise approach here:
> 
> https://review.lttng.org/c/userspace-rcu/+/18257 call-rcu worker: set CPU affinity on first non-empty dequeue

The idea being that the call_rcu() thread checks its partner and uses
explicit affinity to follow it around?

I am reminded of a DYNIX/ptx feature that allowed you to say that a
pair of userspace threads were related, so that they should be migrated
together.  This idea did not go over well during the initial Linux-kernel
scheduler discussions a quarter century back.  ;-)

I know!  I know!  Use sched_ext!!!  (Sorry, couldn't resist...)

							Thanx, Paul

> Feedback is welcome,
> 
> Thanks!
> 
> Mathieu
> 
> > 
> > Note that there is a commit in liburcu changing this behavior right
> > now, but it's not part of any release yet. I want to figure out the
> > wanted behavior before releasing this change:
> > 
> > commit 28f282af1905a1cf50ff9b5835b4cd9de4416ddf
> > Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Date:   Wed Jul 1 12:49:43 2026 -0400
> > 
> >      call_rcu: pin per-CPU worker at thread startup
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
