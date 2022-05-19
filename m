Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25DAC433F5
	for <lttng-dev@archiver.kernel.org>; Thu, 19 May 2022 15:31:11 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4L3v2k2lY0z1PXv;
	Thu, 19 May 2022 11:31:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1652974271;
	bh=Qbp/TCfldKIxhjkfdClv/UAXplo72OOJbI9XD47Nxio=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rCVWkTFW+LS1bQWcDhTJzORQHZu2KDhHjEHdJZTfOIq8jqflHRUCDCUs6Hq+LxrQP
	 JxwtvR9YUyjlond/xRaUIRjM4bV7LusV6OfbUXBPjBw0MI6VhKIhwGOvbGVg+5qlf9
	 Cr4+RWOIOqLV+aFeyzbDA5+O7uudxQX7UdIpjuAups95KwgqFTcaB9W+pIfNcDDgRT
	 RWwFhcIBgsXQi/3hMMA8ciscEBp15v/DbGdM82QLemUarKocl6XXck+WN+984mN3el
	 7M+B3WIJ4lBWaUVSnG4AqW2+rLik8HQSDtsAwQz+TdGwntD3YniX5jMHTAGnNCkkmz
	 lKiohSKrUHbOg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4L3v2j1JCLz1Q4S
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2022 11:31:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A47F43FCF71
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2022 11:31:02 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id C328FAf6_cza; Thu, 19 May 2022 11:31:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3B9523FCDF6;
 Thu, 19 May 2022 11:31:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3B9523FCDF6
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id A2WcVnQfbkib; Thu, 19 May 2022 11:31:02 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 327B83FD194;
 Thu, 19 May 2022 11:31:02 -0400 (EDT)
Date: Thu, 19 May 2022 11:31:02 -0400 (EDT)
To: bruce ashfield <bruce.ashfield@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1908357724.62379.1652974262072.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220519150257.26136-1-bruce.ashfield@gmail.com>
References: <20220519150257.26136-1-bruce.ashfield@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4257 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4257)
Thread-Topic: sched/tracing: fix __trace_sched_switch_state (5.18-rc7+)
Thread-Index: bIn7W1ParJF45CJYf+vEelROg0UxWw==
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


----- On May 19, 2022, at 11:02 AM, Bruce Ashfield via lttng-dev lttng-dev@lists.lttng.org wrote:

> From: Bruce Ashfield <bruce.ashfield@gmail.com>
> 
> The commit [fix: sched/tracing: Don't re-read p->state when emitting
> sched_switch event (v5.18)] was correct, but the kernel changed their
> mind with the following commit:
> 
>   commit 9c2136be0878c88c53dea26943ce40bb03ad8d8d
>   Author: Delyan Kratunov <delyank@fb.com>
>   Date:   Wed May 11 18:28:36 2022 +0000
> 
>       sched/tracing: Append prev_state to tp args instead
> 
>       Commit fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting
>       sched_switch event, 2022-01-20) added a new prev_state argument to the
>       sched_switch tracepoint, before the prev task_struct pointer.
> 
>       This reordering of arguments broke BPF programs that use the raw
>       tracepoint (e.g. tp_btf programs). The type of the second argument has
>       changed and existing programs that assume a task_struct* argument
>       (e.g. for bpf_task_storage access) will now fail to verify.
> 
>       If we instead append the new argument to the end, all existing programs
>       would continue to work and can conditionally extract the prev_state
>       argument on supported kernel versions.
> 
>       Fixes: fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting
>       sched_switch event, 2022-01-20)
>       Signed-off-by: Delyan Kratunov <delyank@fb.com>
>       Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>       Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>       Link:
>       https://lkml.kernel.org/r/c8a6930dfdd58a4a5755fc01732675472979732b.camel@fb.com
> 
> By reordering the parameters (again) we can get back up and building.
> 
> Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
> ---
> 
> Hi all,
> 
> This is more than likely NOT a correct fix, but while working on the
> yocto -dev reference kernel, I ran into this build failure against
> 5.18-rc7.
> 
> I didn't see any sign of another fix on the mailing list, so I wanted
> to send this in case anyone else runs into the failure and to check
> to see if there's a better fix in progress.

Hi Bruce,

Please see: https://review.lttng.org/c/lttng-modules/+/8045

I was planning to merge it today, unless you have objections.

I notice that in your own patch, you modify the arguments passed to
__trace_sched_switch_state(), althrough I don't see them changing in
the upstream kernel. Am I missing something ?

Thanks,

Mathieu

> 
> Cheers,
> 
> Bruce
> 
> 
> include/instrumentation/events/sched.h | 15 ++++++++-------
> 1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/instrumentation/events/sched.h
> b/include/instrumentation/events/sched.h
> index 339bec9..f9e9c38 100644
> --- a/include/instrumentation/events/sched.h
> +++ b/include/instrumentation/events/sched.h
> @@ -23,8 +23,9 @@
> #if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(5,18,0))
> 
> static inline long __trace_sched_switch_state(bool preempt,
> -		unsigned int prev_state,
> -		struct task_struct *p)
> +		struct task_struct *p,
> +		struct task_struct *n,
> +		unsigned int prev_state )
> {
>         unsigned int state;
> 
> @@ -356,20 +357,20 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_wakeup_template,
> sched_wakeup_new,
> LTTNG_TRACEPOINT_EVENT(sched_switch,
> 
> 	TP_PROTO(bool preempt,
> -		unsigned int prev_state,
> 		struct task_struct *prev,
> -		struct task_struct *next),
> +		struct task_struct *next,
> +		unsigned int prev_state),
> 
> -	TP_ARGS(preempt, prev_state, prev, next),
> +	TP_ARGS(preempt, prev, next, prev_state),
> 
> 	TP_FIELDS(
> 		ctf_array_text(char, prev_comm,	prev->comm, TASK_COMM_LEN)
> 		ctf_integer(pid_t, prev_tid, prev->pid)
> 		ctf_integer(int, prev_prio, prev->prio - MAX_RT_PRIO)
> #ifdef CONFIG_LTTNG_EXPERIMENTAL_BITWISE_ENUM
> -		ctf_enum(task_state, long, prev_state, __trace_sched_switch_state(preempt,
> prev_state, prev))
> +		ctf_enum(task_state, long, prev_state, __trace_sched_switch_state(preempt,
> prev, next, prev_state))
> #else
> -		ctf_integer(long, prev_state, __trace_sched_switch_state(preempt, prev_state,
> prev))
> +		ctf_integer(long, prev_state, __trace_sched_switch_state(preempt, prev, next,
> prev_state))
> #endif
> 		ctf_array_text(char, next_comm, next->comm, TASK_COMM_LEN)
> 		ctf_integer(pid_t, next_tid, next->pid)
> --
> 2.19.1
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
