Return-Path: <SRS0=ctY1=KA=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE8FC433B4
	for <lttng-dev@archiver.kernel.org>; Wed,  5 May 2021 13:19:35 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AC4613C3
	for <lttng-dev@archiver.kernel.org>; Wed,  5 May 2021 13:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AC4613C3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FZy3m1zNxz1hsp;
	Wed,  5 May 2021 09:19:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1620220773;
	bh=I4gYCdkIrHZp6IveNrVjDNWAkk7g9WMBmk4dWCnZV5k=;
	h=To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=yr79aV37jHTH3g/eyjahlUsP4fj5ojGr4QrfIN90cjxn41BpCqACcLLjTtB7BXkcf
	 DqlZzV6OlyDIHw2ZHGF9Y7ba1r/gJ5jzHFwn0GLSdrJUXHmqcY/t5TWCjSqbjSZBgZ
	 2qVKONGvq1HaLzQ1e+UfTJVtGL10XYy5JyK2OIIdKH4eVEWY7UHoSpRHmF6iGEeFiv
	 6J6Rdi62+Js613EO1zznzMVN6bu/Y5r4hUMBN+jEz53T/XwgWg3DLBUCdlCS3YANz2
	 RyGpkige3WrB1C0sNRLnQzDTgwYFYdDCAmyp9QMTaSXKVFUv9OmMFaoX9lGyXdFkD0
	 TFhuACgKCiL6w==
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by lists.lttng.org (Postfix) with ESMTPS id 4FZprZ6gZFz1hf9
 for <lttng-dev@lists.lttng.org>; Wed,  5 May 2021 03:54:22 -0400 (EDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9FBBEAFA9;
 Wed,  5 May 2021 07:54:15 +0000 (UTC)
Message-ID: <46bbe62ed2ebed63b6566516c792591deaf52a4a.camel@suse.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, paulmck
 <paulmck@kernel.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Date: Wed, 05 May 2021 09:54:14 +0200
In-Reply-To: <580855125.21864.1619808103861.JavaMail.zimbra@efficios.com>
References: <ebac01302ecae6cc2dd0ace8fcfffa6ab593e0fe.camel@suse.com>
 <580855125.21864.1619808103861.JavaMail.zimbra@efficios.com>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 05 May 2021 09:19:30 -0400
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

On Fri, 2021-04-30 at 14:41 -0400, Mathieu Desnoyers wrote:
> ----- On Apr 29, 2021, at 9:49 AM, lttng-dev =

> lttng-dev@lists.lttng.org=A0wrote:
> =

> > In multipath-tools, we are using a custom RCU helper thread, which
> > is cleaned
> > out
> > on exit:
> > =

> > https://github.com/opensvc/multipath-tools/blob/23a01fa679481ff11441392=
22fbd2c4c863b78f8/multipathd/main.c#L3058
> > =

> > I put a call to rcu_barrier() there in order to make sure all
> > callbacks had
> > finished
> > before detaching the helper thread.
> > =

> > Now we got a report that rcu_barrier() isn't available before user-
> > space RCU 0.8
> > (https://github.com/opensvc/multipath-tools/issues/5) (and RHEL7 /
> > Centos7
> > still has 0.7.16).
> > =

> > Question: was it over-cautious or otherwise wrong to call
> > rcu_barrier() before
> > set_thread_call_rcu_data(NULL)? Can we maybe just skip this call?
> > If no, what
> > would be the recommended way for liburcu < 0.8 to dissociate a
> > helper thread?
> > =

> > (Note: I'm not currently subscribed to lttng-dev).
> =

> First of all, there is a significant reason why liburcu does not free
> the "default"
> call_rcu worker thread data structures at process exit. This is
> caused by the fact that
> a call_rcu callback may very well invoke call_rcu() to re-enqueue
> more work.
> =

> AFAIU this is somewhat similar to what happens to the Linux kernel
> RCU implementation
> when the machine needs to be shutdown or rebooted: there may indeed
> never be any point
> in time where it is safe to free the call_rcu worker thread data
> structures without leaks,
> due to the fact that a call_rcu callback may re-enqueue further work
> indefinitely.
> =

> So my understanding is that you implement your own call rcu worker
> thread because the
> one provided by liburcu leaks data structure on process exit, and you
> expect that
> call rcu_barrier once will suffice to ensure quiescence of the call
> rcu worker thread
> data structures. Unfortunately, this does not cover the scenario
> where a call_rcu
> callback re-enqueues additional work.

I understand. In multipath-tools, we only have one callback, which
doesn't re-enqueue any work. Our callback really just calls free() on a
data structure. And it's unlikely that we'll get more RCU callbacks any
time soon.

So, to clarify my question: Does it make sense to call rcu_barrier()
before set_thread_call_rcu_data(NULL) in this case? If yes, is there an
alternative for safely detaching the custom RCU thread if rcu_barrier()
is unavailable?

> So without knowing more details on the reasons why you wish to clean
> up memory at
> process exit, and why it would be valid to do so in your particular
> use-case, it's
> rather difficult for me to elaborate a complete answer.

multipathd is a long-running process, so being wary of memory leaks is
important. valgrind tests pop up an ugly warning about liburcu - it's
obviously not a big issue, as it occurs only on exit, but it makes a
negative impression on users running memory leak tests. It's possible
to work around that by using valgrind "suppressions", but so far my
policy was to use these only as last resort measure, in case we
couldn't find any way to work around it in our code. That's why I came
up with the "custom RCU thread" approach.

Anyway, from what you're saying, it might be be better to simply accept
the fact that this pseudo-memory-leak exists than trying to fix it in
an unsafe way with older liburcu versions.

> I can see that maybe we could change liburcu to make it so that we
> free all
> call_rcu data structures _if_ they happen to be empty of callbacks at
> process exit,
> after invoking one rcu_barrier. That should take care of not leaking
> data structures
> in the common case where call_rcu does not enqueue further callbacks.
> =

> Thoughts ?

That would be nice, but it wouldn't help me in the specific case, where
I have to deal with an old version of liburcu.

Perhaps you could also consider an API extension by which an
application could tell liburcu that it's exiting, and no further
callbacks should be scheduled?

Thanks,
Martin


_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
