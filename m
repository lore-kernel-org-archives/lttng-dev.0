Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5137EC43334
	for <lttng-dev@archiver.kernel.org>; Wed, 15 Jun 2022 13:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655300122;
	bh=I2Ytdm8kx88JqN9ek/hDjQX2Vlc6d4LuaRUDSocj+i4=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YBeuWRlao8rTw4oKwhzCD/SU2VKlp5nGU2WXNdUhlRVUyHSF+1q3KQzYH490AU4RS
	 856aU6a5ZxOuHgAnr9InoQkvKWSNxaaNpuGzSw3eJjNz2TXLKeZvbqXswxCo9yAN+c
	 3A/5XDNZTb22Y6eMfHhld57yK1KBhVde94MkIWt33Kt1k6lODCpiO4kuKeC4VNzSem
	 26xtin5Bhx3zT1M31PYbSJgkA0/r1RxkQl5BagoId6TuNNrab8ZHPKMW1PjM8woSG4
	 7xgTcMbszJYKrr/lx9xfw+gCufHrxG1R0ljP3fSBZouXA6FltYk+6FZBi9soqCl7Ve
	 IUrpVwz1mm+6g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LNRBd3kZPz8RZ;
	Wed, 15 Jun 2022 09:35:21 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LNRBb2pSGz8RX
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jun 2022 09:35:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C39E140991A
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jun 2022 09:35:18 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 0tpHqtC9JZdz; Wed, 15 Jun 2022 09:35:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0D72A4091E1;
 Wed, 15 Jun 2022 09:35:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0D72A4091E1
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 0L5728rTrUWW; Wed, 15 Jun 2022 09:35:18 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 02B0C40973C;
 Wed, 15 Jun 2022 09:35:18 -0400 (EDT)
Date: Wed, 15 Jun 2022 09:35:17 -0400 (EDT)
To: Minlan Wang <wangminlan@szsandstone.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1314631804.61859.1655300117898.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220615034900.GA187807@localhost.localdomain>+5075995E84B158A6>
References: <20220614035533.GA174967@localhost.localdomain>
 <765519142.60031.1655221996546.JavaMail.zimbra@efficios.com>
 <20220615034900.GA187807@localhost.localdomain>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4272 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4257)
Thread-Topic: urcu workqueue thread uses 99% of cpu while workqueue is empty
Thread-Index: vfakGoFUjUR5ACAPT7S/Ymeqm+T9qQ==
Subject: Re: [lttng-dev] urcu workqueue thread uses 99% of cpu while
 workqueue is empty
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

----- On Jun 14, 2022, at 11:49 PM, Minlan Wang wangminlan@szsandstone.com wrote:

> Hi, Mathieu,
> The commit on branch stable-0.12 correponds to the tarball we downloaded is
> this:
> 
> commit d5277e807192178ddb79f56ecbbd5ac3c4994f60 (HEAD -> v0.12.1.b, tag:
> v0.12.1)
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Wed Apr 22 08:51:41 2020 -0400
> 
>    Version 0.12.1
> 
>    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> The OS we are using is CentOS Linux release 7.9.2009 (Core), not CentOS 8.2
> as mentioned before. And the kernel version is: 3.10.0-1160.el7.x86_64.

Can you reproduce with an up-to-date kernel ? AFAIU, kernel version
3.10.0-1160.el7.x86_64 was built on Mon Oct 19 18:34:26 2020 [1], whereas
3.10.0-1160.66.1.el7 was built on Wed May 18 18:19:46 2022 [2].

[1] https://rpmfind.net/linux/RPM/centos/7.9.2009/x86_64/Packages/kernel-3.10.0-1160.el7.x86_64.html
[2] https://rpmfind.net/linux/RPM/centos/updates/7.9.2009/x86_64/Packages/kernel-3.10.0-1160.66.1.el7.x86_64.html

I just want to make sure we are not hitting a bug in the futex system call.

Can you also try to reproduce with an up-to-date Linux kernel ? (5.18.4)

Can you provide a reproducer I could try on my own system ?

Thanks,

Mathieu

> 
> On Tue, Jun 14, 2022 at 11:53:16AM -0400, Mathieu Desnoyers wrote:
>> Also, I notice that you appear to be using an internal liburcu API (not public)
>> from outside of the liburcu project, which is not really expected.
> We are trying to move some linux kernel module function into userspace, and
> found that the urcu internal workqueue.h has all the things we need for a
> replace for kernel workqueue, so we decided to give it a try.
> 
>> 
>> If your process forks without exec, make sure you wire up the equivalent of
>> rculfhash pthread_atfork functions which call urcu_workqueue_pause_worker(),
>> urcu_workqueue_resume_worker() and urcu_workqueue_create_worker().
> There's no fork/exec in the process who is calling alloc_workqueue, and the
> threads who are enqueue work into the workqueue is created by calling
> pthread_create.
> 
>> 
>> Also, can you validate of you have many workqueue worker threads trying to
>> dequeue from the same workqueue in parallel ? This is unsupported and would
>> cause the kind of issues you are observing here.
> The workqueue thread is created by calling urcu_workqueue_create in the code
> below, and it is the only thread which will dequeue work from the workqueue.
> Though, there are multiple threads who will enqueue work by calling
> urcu_workqueue_queue_work(wq, work, work->func).
> ---
> static void workqueue_init_fn(struct urcu_workqueue *workqueue, void *priv)
> {
>	pthread_t tid;
>	const char *name;
>	char thread_name[16] = {0};
> 
>	if (!priv)
>		return;
> 
>	name = (const char *)priv;
>	tid = pthread_self();
>	
>	memcpy(thread_name, name, 15);
>	if (pthread_setname_np(tid, thread_name)) {
>		pr_err("failed to set thread name for workqueue %s\n", name);
>	}
> 
>	urcu_memb_register_thread();
> }
> 
> static void workqueue_finalize_fn(struct urcu_workqueue *workqueue, void
>				  *priv)
> {
>	urcu_memb_unregister_thread();
>	if (priv)
>		free(priv);
> }
> 
> struct workqueue_struct *alloc_workqueue(const char *fmt,
>					 unsigned int flags,
>					 int max_active, ...)
> {
>	const char *name;
> 
>	name = strdup(fmt);
>	if (!name) {
>		pr_err("failed to dup name for workqueue %s\n", fmt);
>		return NULL;
>	}
> 
>	return urcu_workqueue_create(0, -1, (void *)name,
>			      NULL,			/* grace */
>			      workqueue_init_fn,	/* init */
>			      workqueue_finalize_fn,	/* finalize */
>			      NULL,			/* before wait */
>			      NULL,			/* after wake up */
>			      NULL,			/* before pasue */
>			      NULL);			/* after resume */
> }
> ---
> 
> B.R
> Minlan

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
