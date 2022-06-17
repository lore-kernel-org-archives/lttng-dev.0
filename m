Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B753AC43334
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Jun 2022 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655473049;
	bh=cOuYbSWfLrHhKYA3jWD4vXRJC+1AbRG2KgYbchFSodE=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=yprwKqcXKB8gUYQTplnD9jQbkJ5nKC50kOzZTEJKbzxAwSqcBcv/f5To88b49IpAX
	 3Ht2GAn8j48MB7hIn2lUBLRuy9iZ51jEWedx0TwnLrhhl8khX51EnxJ4qiw8ivtIhV
	 jCAYTbdatPCK1AZ51Qr4y3yjsxwMoBICQnE1ZFwIJDHTAFFqd6l6H768Un0kT2bp/c
	 pOOKOahg8JsD74yX4nU7irDNhzVHdHcjEyEXQ7LOfCME4wXSFtAsbB1scWwmLsAokF
	 nTFw0Tn32qKr34fkrFAzGlkSRybFOOfQAdrwZPmOeQLQC/UUG9HSCnf5qZxM3bZ9lp
	 pwYkVsDN/X6Kw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LPg865jlTzB6D;
	Fri, 17 Jun 2022 09:37:26 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LPg853V7TzBBQ
 for <lttng-dev@lists.lttng.org>; Fri, 17 Jun 2022 09:37:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 17B9637C270
 for <lttng-dev@lists.lttng.org>; Fri, 17 Jun 2022 09:37:24 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id z4wXGdr-tEvH; Fri, 17 Jun 2022 09:37:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 85A5137C468;
 Fri, 17 Jun 2022 09:37:23 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 85A5137C468
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id MpO0gfQyU8UO; Fri, 17 Jun 2022 09:37:23 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 73C6737C467;
 Fri, 17 Jun 2022 09:37:23 -0400 (EDT)
Date: Fri, 17 Jun 2022 09:37:23 -0400 (EDT)
To: Minlan Wang <wangminlan@szsandstone.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
Message-ID: <1711122492.5944.1655473043420.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220616080912.GA246781@localhost.localdomain>+A9F2DC87F5C41B48>
References: <20220614035533.GA174967@localhost.localdomain>
 <765519142.60031.1655221996546.JavaMail.zimbra@efficios.com>
 <20220615034900.GA187807@localhost.localdomain>
 <396090936.61897.1655302558168.JavaMail.zimbra@efficios.com>
 <20220616080912.GA246781@localhost.localdomain>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: urcu workqueue thread uses 99% of cpu while workqueue is empty
Thread-Index: z6/GARQPTmZuM2TkzLGNrWUYuGV0MQ==
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

----- On Jun 16, 2022, at 4:09 AM, Minlan Wang wangminlan@szsandstone.com wrote:

> Hi, Mathieu,
> I tried to write a simple program to reproduce this issue, but failed.
> The environment we used to produce this issue is a storage cluster.
> It has 3 nodes, each with an NVME and several SATA disks, urcu is part of the
> storage cluster software.
> The storage software is pretty big, 3+ GB in size. I guess it's hard for you to
> build a environment like ours.
> 
> Besides, I made some change into workqueue.c to debug this issue today, here's
> the patch i used for debuging:
> 
> From 18f3fea1436e0c999b346b998b7153150b92e62f Mon Sep 17 00:00:00 2001
> From: wangminlan <wangminlan@szsandstone.com>
> Date: Wed, 15 Jun 2022 14:28:53 +0800
> Subject: [PATCH] <urcu> debug workqueue->futex
> 
> ---
> .../userspace-rcu-0.12.1/src/workqueue.c           | 49 ++++++++++++++++++----
> 1 file changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git
> a/ceph/thirdpart/ascache/thirdparty/userspace-rcu-0.12.1/src/workqueue.c
> b/ceph/thirdpart/ascache/thirdparty/userspace-rcu-0.12.1/src/workqueue.c
> index 59eb21d..eed1e21 100644
> --- a/ceph/thirdpart/ascache/thirdparty/userspace-rcu-0.12.1/src/workqueue.c
> +++ b/ceph/thirdpart/ascache/thirdparty/userspace-rcu-0.12.1/src/workqueue.c
> @@ -132,12 +132,21 @@ static int set_thread_cpu_affinity(struct urcu_workqueue
> *workqueue)
> 
> static void futex_wait(int32_t *futex)
> {
> +	int ret;
> +	int err;
> 	/* Read condition before read futex */
> 	cmm_smp_mb();
> -	if (uatomic_read(futex) != -1)
> +	if (uatomic_read(futex) != -1) {
> +		fprintf(stderr, "%lu: wq %p: %s futex != -1, don't wait\n",
> +			pthread_self(), caa_container_of(futex, struct urcu_workqueue, futex),
> __func__);
> +
> 		return;
> -	while (futex_async(futex, FUTEX_WAIT, -1, NULL, NULL, 0)) {
> -		switch (errno) {
> +	}
> +	while ((ret = futex_async(futex, FUTEX_WAIT, -1, NULL, NULL, 0))) {
> +		err = errno;
> +		fprintf(stderr, "%lu: wq %p: %s failed, errno %d\n",
> +			pthread_self(), caa_container_of(futex, struct urcu_workqueue, futex),
> __func__, err);
> +		switch (err) {
> 		case EWOULDBLOCK:
> 			/* Value already changed. */
> 			return;
> @@ -146,17 +155,35 @@ static void futex_wait(int32_t *futex)
> 			break;	/* Get out of switch. */
> 		default:
> 			/* Unexpected error. */
> -			urcu_die(errno);
> +			urcu_die(err);
> 		}
> 	}
> +
> +	fprintf(stderr, "%lu: wq %p: %s wait return %d\n",
> +		pthread_self(), caa_container_of(futex, struct urcu_workqueue, futex),
> __func__, ret);
> +
> }
> 
> static void futex_wake_up(int32_t *futex)
> {
> 	/* Write to condition before reading/writing futex */
> +	int32_t old;
> +
> 	cmm_smp_mb();
> -	if (caa_unlikely(uatomic_read(futex) == -1)) {
> -		uatomic_set(futex, 0);
> +	old = uatomic_read(futex);
> +	if (caa_unlikely(old == -1)) {
> +		old = uatomic_xchg(futex, 0);
> +		if (old == -1) {
> +			fprintf(stderr, "%lu: wq %p, wakeup succeed: old %d\n",
> +				pthread_self(),
> +				caa_container_of(futex, struct urcu_workqueue, futex),
> +				old);
> +		} else {
> +			fprintf(stderr, "%lu: wq %p, wakeup failed: old %d\n",
> +				pthread_self(),
> +				caa_container_of(futex, struct urcu_workqueue, futex),
> +				old);
> +		}
> 		if (futex_async(futex, FUTEX_WAKE, 1,
> 				NULL, NULL, 0) < 0)
> 			urcu_die(errno);
> @@ -237,8 +264,16 @@ static void *workqueue_thread(void *arg)
> 		if (!rt) {
> 			if (cds_wfcq_empty(&workqueue->cbs_head,
> 					&workqueue->cbs_tail)) {
> +				int32_t new;
> 				futex_wait(&workqueue->futex);
> -				uatomic_dec(&workqueue->futex);
> +				new = uatomic_add_return(&workqueue->futex, -1);
> +				if (new == -1) {
> +					fprintf(stderr, "%lu: wq %p dec succeed: old %d, new %d\n",
> +						pthread_self(), workqueue, new + 1, new);
> +				} else {
> +					fprintf(stderr, "%lu: wq %p dec failed: old %d\n",
> +						pthread_self(), workqueue, new + 1);
> +				}
> 				/*
> 				 * Decrement futex before reading
> 				 * urcu_work list.
> --
> 1.8.3.1
> 
> And the instresting log began from here:
> ---
> ...
>   2097 140196498532096: wq 0x55f69a99ea00, wakeup succeed: old -1	/* enqueue op
>   set futex: -1 -> 0 */
>   2098 140196272453376: wq 0x55f69a99ea00: futex_wait wait return 0	/*
>   workqueue_thread wait success */
>   2099 140196272453376: wq 0x55f69a99ea00 dec failed: old -1		/* workqueue_thread
>   got futex == -1 ? */
>   2100 140196272453376: wq 0x55f69a99ea00: futex_wait futex != -1, don't wait
>   2101 140196272453376: wq 0x55f69a99ea00 dec failed: old -2
> ...
> ---
> In line 2099, how did workqueue_thread got futex as -1? This is wierd.
> 
> I put the patch i used to debug, and the complete log of the reproduce into the
> attachment, may this helps.

Here is my current line of investigation:

grep -e wakeup -e "futex_wait wait return 0" 8.osd.mail.log  |tail

shows:

140196498532096: wq 0x55f69a99ea00, wakeup succeed: old -1
140196272453376: wq 0x55f69a99ea00: futex_wait wait return 0
140196498532096: wq 0x55f69a99ea00, wakeup succeed: old -1
140196272453376: wq 0x55f69a99ea00: futex_wait wait return 0
140196498532096: wq 0x55f69a99ea00, wakeup succeed: old -1
140196272453376: wq 0x55f69a99ea00: futex_wait wait return 0
140196498532096: wq 0x55f69a99ea00, wakeup succeed: old -1
140196498532096: wq 0x55f69a99ea00, wakeup succeed: old -1
140196498532096: wq 0x55f69a99ea00, wakeup succeed: old -1
140196272453376: wq 0x55f69a99ea00: futex_wait wait return 0

Which basically shows that shortly before things go awry, many wakeups succeed
(and are thus potentially queued within the kernel) before a single futex_wait
succeeds.

I therefore suspect that this particular last futex_wait success has been caused
by a prior queued wakeup.

This could indeed be the culprit here, because it would cause the futex_wait to
return and proceed with uatomic_add_return(&workqueue->futex, -1); when the state
was not set to 0 by the wakeup side.

We should not rely too much on the ordering of fprintf stderr output between threads,
because those can be interleaved in any order (each fprintf to stderr is unbuffered).
If we want more precision in the order of events I would recommend using LTTng-UST for
fine-grained user-space tracing. This might explain why the futex has an unexpected value
at line 2099.

Can you try the following patch on top of v0.12.1 + your debug patch ?

diff --git a/src/workqueue.c b/src/workqueue.c
index eed1e21e..19fc89c8 100644
--- a/src/workqueue.c
+++ b/src/workqueue.c
@@ -142,6 +142,7 @@ static void futex_wait(int32_t *futex)
 
 		return;
 	}
+wait:
 	while ((ret = futex_async(futex, FUTEX_WAIT, -1, NULL, NULL, 0))) {
 		err = errno;
 		fprintf(stderr, "%lu: wq %p: %s failed, errno %d\n",
@@ -161,7 +162,16 @@ static void futex_wait(int32_t *futex)
 
 	fprintf(stderr, "%lu: wq %p: %s wait return %d\n",
 		pthread_self(), caa_container_of(futex, struct urcu_workqueue, futex), __func__, ret);
-
+	/*
+	 * Prior queued wakeups can cause futex wait to return even
+	 * though the futex value is still -1. If this happens, wait
+	 * again.
+	 */
+	if (uatomic_read(futex) == -1) {
+		fprintf(stderr, "%lu: wq %p: %s futex == -1, wait again\n",
+			pthread_self(), caa_container_of(futex, struct urcu_workqueue, futex), __func__);
+		goto wait;
+	}
 }
 
 static void futex_wake_up(int32_t *futex)


Thanks!

Mathieu

> 
> Thanks,
> Minlan

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
