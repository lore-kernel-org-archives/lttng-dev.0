Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C241BC43334
	for <lttng-dev@archiver.kernel.org>; Wed, 15 Jun 2022 03:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655264982;
	bh=CvY2jhv5+D0umgq22kS4gzsPxonjnVQ6vqJClFDMoDA=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LPkaE6sY+Qp4HzaF2SLxmRhhemmcuzoFUgiqil3zR8PnfcZP0bj1BuIoLQcieKJuT
	 7e9cx/r05knUW0N3zvdd+gqHBw9vF4gzQMPaKuyZXGwKDWohulhwVhFrrcvKIXcxrc
	 cXsUtJP7mVDRbj4Qa4n+tiWUKa/ZLy6JCflHfpq4zqZBQNoon5p+AxhA+ZAMMefdVU
	 6APsVYaGIz20fARrLR6rsCCP+2nJ2xxpDhv4vPlCRHt1rzbEnTWDyADqaWbF1CC9s3
	 XUniW3aj8vApA/4Nn4sditUD4il69g+1gI9OAOv+hgTGbtdv/TNOVOYSdPcdtfCY6N
	 1AeEgFOGC8W/w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LNBBs69Z7z8tH;
	Tue, 14 Jun 2022 23:49:41 -0400 (EDT)
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
 by lists.lttng.org (Postfix) with ESMTPS id 4LNBBq3v85z8fD
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2022 23:49:39 -0400 (EDT)
X-QQ-mid: bizesmtp85t1655264945tr435ovw
Received: from localhost.localdomain ( [113.87.195.227])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 15 Jun 2022 11:49:03 +0800 (CST)
X-QQ-SSF: 01400000000000B0G000000A0000000
X-QQ-FEAT: AnvTHaSthI4AA23/CSR285Fuh6MGl4RPAu9JM21yOITdHOo64RaaN4EF1UeQI
 v+Tk2UrQFcfquxoLbqB+VMh2TBAoimjhanxZQlPOvr5BABwrlfJBhB49LutWe+OBuqicl0T
 Y5h+mZw4cw7ynb7u5Ub4dtKQInyNwvYQrBsjYu5AtYJJQembi2GIljg58M/SoKsdlVuLC8B
 1M+6GT+VRXMYnPMBXdZ1TKVgoKiV1Dk2aGETHRyGGc5X95OzzmqiQ5fbUVzgBiufhff/BjC
 jNNblq1R4OQQRtlWoNtEO11/57ccR+I4qc2jDRHbQn51F3TpKeCn3xssKLlDAxrvgKZqCoM
 kHMaAMA
X-QQ-GoodBg: 2
Date: Tue, 14 Jun 2022 23:49:00 -0400
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20220615034900.GA187807@localhost.localdomain>+5075995E84B158A6
References: <20220614035533.GA174967@localhost.localdomain>
 <765519142.60031.1655221996546.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <765519142.60031.1655221996546.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:szsandstone.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
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
From: Minlan Wang via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Minlan Wang <wangminlan@szsandstone.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi, Mathieu,
The commit on branch stable-0.12 correponds to the tarball we downloaded is this:

commit d5277e807192178ddb79f56ecbbd5ac3c4994f60 (HEAD -> v0.12.1.b, tag: v0.12.1)
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed Apr 22 08:51:41 2020 -0400

    Version 0.12.1

    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

The OS we are using is CentOS Linux release 7.9.2009 (Core), not CentOS 8.2
as mentioned before. And the kernel version is: 3.10.0-1160.el7.x86_64.

On Tue, Jun 14, 2022 at 11:53:16AM -0400, Mathieu Desnoyers wrote:
> Also, I notice that you appear to be using an internal liburcu API (not public)
> from outside of the liburcu project, which is not really expected.
We are trying to move some linux kernel module function into userspace, and
found that the urcu internal workqueue.h has all the things we need for a
replace for kernel workqueue, so we decided to give it a try.

> 
> If your process forks without exec, make sure you wire up the equivalent of
> rculfhash pthread_atfork functions which call urcu_workqueue_pause_worker(),
> urcu_workqueue_resume_worker() and urcu_workqueue_create_worker().
There's no fork/exec in the process who is calling alloc_workqueue, and the
threads who are enqueue work into the workqueue is created by calling
pthread_create.

> 
> Also, can you validate of you have many workqueue worker threads trying to
> dequeue from the same workqueue in parallel ? This is unsupported and would
> cause the kind of issues you are observing here.
The workqueue thread is created by calling urcu_workqueue_create in the code
below, and it is the only thread which will dequeue work from the workqueue.
Though, there are multiple threads who will enqueue work by calling
urcu_workqueue_queue_work(wq, work, work->func).
---
static void workqueue_init_fn(struct urcu_workqueue *workqueue, void *priv)
{
	pthread_t tid;
	const char *name;
	char thread_name[16] = {0};

	if (!priv)
		return;

	name = (const char *)priv;
	tid = pthread_self();
	
	memcpy(thread_name, name, 15);
	if (pthread_setname_np(tid, thread_name)) {
		pr_err("failed to set thread name for workqueue %s\n", name);
	}

	urcu_memb_register_thread();
}

static void workqueue_finalize_fn(struct urcu_workqueue *workqueue, void
				  *priv)
{
	urcu_memb_unregister_thread();
	if (priv)
		free(priv);
}

struct workqueue_struct *alloc_workqueue(const char *fmt,
					 unsigned int flags,
					 int max_active, ...)
{
	const char *name;

	name = strdup(fmt);
	if (!name) {
		pr_err("failed to dup name for workqueue %s\n", fmt);
		return NULL;
	}

	return urcu_workqueue_create(0, -1, (void *)name,
			      NULL,			/* grace */
			      workqueue_init_fn,	/* init */
			      workqueue_finalize_fn,	/* finalize */
			      NULL,			/* before wait */
			      NULL,			/* after wake up */
			      NULL,			/* before pasue */
			      NULL);			/* after resume */
}
---

B.R
Minlan


_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
