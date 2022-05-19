Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9A5C433F5
	for <lttng-dev@archiver.kernel.org>; Thu, 19 May 2022 16:01:57 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4L3vkD2x6bz1PrT;
	Thu, 19 May 2022 12:01:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1652976117;
	bh=CBvZf583TxYsnUXAlWNA/hyGLrrv5E1Ls1sQk9ZQU0Y=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=M1EKjzl2Cd5tt4S4z8sif39+dd7q9ks73Bi+HSZoGokGfYgYobhGFbspkMNHI1tTe
	 t8NxzjB5Fw1byPgMSn5XpN3D7n4qywfhjXMOlg7qdR+0kDiElIEGPJRccfqO1iuVa/
	 LFm1VGAbCxwwPO6TWSdidGck+j3+DRJAN8MDsD3rl6j1V+9gvYhaCG+UWgM7+pLixH
	 268x7RS1iTi6jX1w9QOmhrdYfHTYZw7mkj7LnNUEKJrX+yitkY3gx6AAqqMWCkQ+Xj
	 1HTIneY3Eu2x2mC1JZvja7PeBCDg088ZnbIbPAdjYf6QQNKWzC6MyAmoKzKBlB5PK8
	 0Gh1rsyvAgbDA==
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by lists.lttng.org (Postfix) with ESMTPS id 4L3vkB5TW8z1PjL
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2022 12:01:54 -0400 (EDT)
Received: by mail-lj1-x22d.google.com with SMTP id q130so6773529ljb.5
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2022 09:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1G9DKLHjN6OyMUZAJC+0+WDy241HshuGLUiIp0Ca/Wc=;
 b=OYSKXN5YZ5jXlBqFoA5w69qoeZoWC7JLdEy0zkTLRsyyqUrREcjVsI/86GqF8xZs+f
 QGv7Wx8QbPDu7sD14GCzsMSXxHpUi/mrIdqnPBdQ9aYpaNXAvwjgyqAKoQuaWSoxjG2K
 ujPc7BHM4BPsKZrCsWWyce28ex3Ji2CH2NmV0kLjZ0Mn2RSSolFYULDwwA1ULWnClrWl
 Y5WHTyqvj5YdJTFMGc7EylCXU7WMOC9AoElFm8T3pBXKy7ZH79b/2VSYmDk4oasZNuPG
 QubGljLRf+RK9D26mIjZujRrg8vVep41gbX4tme3YhtgiL1wSWagPQt2RWbuqoClQYBA
 1E2A==
X-Gm-Message-State: AOAM531L8J1WkPQh5SGBZJVPC+oO2Wi7/pU/MhxAU+w7Nw3jxa8vtYaF
 rKvnnvJImqDYO4a/bHrSMr3G+51BLMsj9o2xodqPmDaCFKU=
X-Google-Smtp-Source: ABdhPJwkNQihpSxBwyd27lLGzq+Gf+JiDs2cjJupxdzDJiP29eYY3FE+iYpVm3JQda5mrjnD8qukTDp6MH4p1xZPNtw=
X-Received: by 2002:a05:651c:902:b0:253:db4b:8f34 with SMTP id
 e2-20020a05651c090200b00253db4b8f34mr214064ljq.46.1652976112902; Thu, 19 May
 2022 09:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220519150257.26136-1-bruce.ashfield@gmail.com>
 <1908357724.62379.1652974262072.JavaMail.zimbra@efficios.com>
In-Reply-To: <1908357724.62379.1652974262072.JavaMail.zimbra@efficios.com>
Date: Thu, 19 May 2022 12:01:41 -0400
Message-ID: <CADkTA4NeZgm-5wac8tZVs-QrAzafcHNWdfAnL0bkJDQjuUHQoA@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] [PATCH] sched/tracing: fix
 __trace_sched_switch_state (5.18-rc7+)
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
From: Bruce Ashfield via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Bruce Ashfield <bruce.ashfield@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Thu, May 19, 2022 at 11:31 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
>
> ----- On May 19, 2022, at 11:02 AM, Bruce Ashfield via lttng-dev lttng-dev@lists.lttng.org wrote:
>
> > From: Bruce Ashfield <bruce.ashfield@gmail.com>
> >
> > The commit [fix: sched/tracing: Don't re-read p->state when emitting
> > sched_switch event (v5.18)] was correct, but the kernel changed their
> > mind with the following commit:
> >
> >   commit 9c2136be0878c88c53dea26943ce40bb03ad8d8d
> >   Author: Delyan Kratunov <delyank@fb.com>
> >   Date:   Wed May 11 18:28:36 2022 +0000
> >
> >       sched/tracing: Append prev_state to tp args instead
> >
> >       Commit fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting
> >       sched_switch event, 2022-01-20) added a new prev_state argument to the
> >       sched_switch tracepoint, before the prev task_struct pointer.
> >
> >       This reordering of arguments broke BPF programs that use the raw
> >       tracepoint (e.g. tp_btf programs). The type of the second argument has
> >       changed and existing programs that assume a task_struct* argument
> >       (e.g. for bpf_task_storage access) will now fail to verify.
> >
> >       If we instead append the new argument to the end, all existing programs
> >       would continue to work and can conditionally extract the prev_state
> >       argument on supported kernel versions.
> >
> >       Fixes: fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting
> >       sched_switch event, 2022-01-20)
> >       Signed-off-by: Delyan Kratunov <delyank@fb.com>
> >       Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >       Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> >       Link:
> >       https://lkml.kernel.org/r/c8a6930dfdd58a4a5755fc01732675472979732b.camel@fb.com
> >
> > By reordering the parameters (again) we can get back up and building.
> >
> > Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
> > ---
> >
> > Hi all,
> >
> > This is more than likely NOT a correct fix, but while working on the
> > yocto -dev reference kernel, I ran into this build failure against
> > 5.18-rc7.
> >
> > I didn't see any sign of another fix on the mailing list, so I wanted
> > to send this in case anyone else runs into the failure and to check
> > to see if there's a better fix in progress.
>
> Hi Bruce,
>
> Please see: https://review.lttng.org/c/lttng-modules/+/8045
>
> I was planning to merge it today, unless you have objections.
>
> I notice that in your own patch, you modify the arguments passed to
> __trace_sched_switch_state(), althrough I don't see them changing in
> the upstream kernel. Am I missing something ?

No objects here. That is obviously better than mine :) I swear I saw
the order of the arguments changing when I looked at the kernel, and
had a secondary compile error in those calls .. but I very easily could
have been mistaken.

Bruce

>
> Thanks,
>
> Mathieu
>
> >
> > Cheers,
> >
> > Bruce
> >
> >
> > include/instrumentation/events/sched.h | 15 ++++++++-------
> > 1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/instrumentation/events/sched.h
> > b/include/instrumentation/events/sched.h
> > index 339bec9..f9e9c38 100644
> > --- a/include/instrumentation/events/sched.h
> > +++ b/include/instrumentation/events/sched.h
> > @@ -23,8 +23,9 @@
> > #if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(5,18,0))
> >
> > static inline long __trace_sched_switch_state(bool preempt,
> > -             unsigned int prev_state,
> > -             struct task_struct *p)
> > +             struct task_struct *p,
> > +             struct task_struct *n,
> > +             unsigned int prev_state )
> > {
> >         unsigned int state;
> >
> > @@ -356,20 +357,20 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_wakeup_template,
> > sched_wakeup_new,
> > LTTNG_TRACEPOINT_EVENT(sched_switch,
> >
> >       TP_PROTO(bool preempt,
> > -             unsigned int prev_state,
> >               struct task_struct *prev,
> > -             struct task_struct *next),
> > +             struct task_struct *next,
> > +             unsigned int prev_state),
> >
> > -     TP_ARGS(preempt, prev_state, prev, next),
> > +     TP_ARGS(preempt, prev, next, prev_state),
> >
> >       TP_FIELDS(
> >               ctf_array_text(char, prev_comm, prev->comm, TASK_COMM_LEN)
> >               ctf_integer(pid_t, prev_tid, prev->pid)
> >               ctf_integer(int, prev_prio, prev->prio - MAX_RT_PRIO)
> > #ifdef CONFIG_LTTNG_EXPERIMENTAL_BITWISE_ENUM
> > -             ctf_enum(task_state, long, prev_state, __trace_sched_switch_state(preempt,
> > prev_state, prev))
> > +             ctf_enum(task_state, long, prev_state, __trace_sched_switch_state(preempt,
> > prev, next, prev_state))
> > #else
> > -             ctf_integer(long, prev_state, __trace_sched_switch_state(preempt, prev_state,
> > prev))
> > +             ctf_integer(long, prev_state, __trace_sched_switch_state(preempt, prev, next,
> > prev_state))
> > #endif
> >               ctf_array_text(char, next_comm, next->comm, TASK_COMM_LEN)
> >               ctf_integer(pid_t, next_tid, next->pid)
> > --
> > 2.19.1
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com



-- 
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
