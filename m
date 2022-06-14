Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1A9C433EF
	for <lttng-dev@archiver.kernel.org>; Tue, 14 Jun 2022 15:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655221999;
	bh=XEbPyKz9qE4Z/m+zlNf1d/ncJLrPicjA8gSD6bYiAuQ=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QgBgf+HKvhexQ4I71no1ppFjtbUlNIzE78nu1XAPQZxHONS/+3k4gUoybWzjebNqt
	 b3oSTsoXArDEbTAkkoaftFD3cZhswZ71dNWQm8H9i+7EcW8QNyrnDJGuc36mUN4RgS
	 CWuyXBoizkdv5lsAQRe/aJ7xaAy4MFTv3wrAViMt48dw5DIzP33egp4J3xZ9nT/kj8
	 GOFgJpvdf55nwPsjejQFjZqycSm1nST6v8D985fkIG1kTBsyCbFu0RIVqY3f/X0g/Q
	 4rl18uaXVql37+x2nlW6GiRWBia6N3Pr1RT/Ze/wPIBYI23q8g93UtikJvMjDhi5oS
	 jAFexwts82w6A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LMtJH2GT3z8Gd;
	Tue, 14 Jun 2022 11:53:19 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LMtJF6rWQz8Yq
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2022 11:53:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 56B6D3C7756
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2022 11:53:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id UWH9LCsV2j_J; Tue, 14 Jun 2022 11:53:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id AD5403C7C56;
 Tue, 14 Jun 2022 11:53:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AD5403C7C56
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id LZHDej-10BvS; Tue, 14 Jun 2022 11:53:16 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id A1A943C7C54;
 Tue, 14 Jun 2022 11:53:16 -0400 (EDT)
Date: Tue, 14 Jun 2022 11:53:16 -0400 (EDT)
To: Minlan Wang <wangminlan@szsandstone.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <765519142.60031.1655221996546.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220614035533.GA174967@localhost.localdomain>+C23B4245BB527E95>
References: <20220614035533.GA174967@localhost.localdomain>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4272 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4257)
Thread-Topic: urcu workqueue thread uses 99% of cpu while workqueue is empty
Thread-Index: goEX3WUDexCipU/y1uYMUct8SUQY4A==
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

----- On Jun 13, 2022, at 11:55 PM, Minlan Wang wangminlan@szsandstone.com wrote:

> Hi, Mathieu,
>	We are running a CentOS 8.2 os on Intel(R) Xeon(R) CPU E5-2630 v4,
> and using the workqueue interfaces in src/workqueue.h in
> userspace-rcu-latest-0.12.tar.bz2.

Also, I notice that you appear to be using an internal liburcu API (not public)
from outside of the liburcu project, which is not really expected.

If your process forks without exec, make sure you wire up the equivalent of
rculfhash pthread_atfork functions which call urcu_workqueue_pause_worker(),
urcu_workqueue_resume_worker() and urcu_workqueue_create_worker().

Also, can you validate of you have many workqueue worker threads trying to
dequeue from the same workqueue in parallel ? This is unsupported and would
cause the kind of issues you are observing here.

Thanks,

Mathieu

>	Recently, we found the workqueue thread rushes cpu into 99% usage.
> After some debuging, we found that the futex in struct urcu_workqueue got
> into very big negative value, e.g, -12484; while the qlen, cbs_tail, and
> cbs_head suggest that the workqueue is empty.
> We add a watchpoint of workqueue->futex in workqueue_thread(), and got this
> log when workqueue->futex first get into -2:
> ...
> Old value = -1
> New value = 0
> 0x00007ffff37c1d6d in futex_wake_up (futex=0x55555f74aa40) at workqueue.c:160
> 160     in workqueue.c
> #0  0x00007ffff37c1d6d in futex_wake_up (futex=0x55555f74aa40) at
> workqueue.c:160
> #1  0x00007ffff37c2737 in wake_worker_thread (workqueue=0x55555f74aa00) at
> workqueue.c:324
> #2  0x00007ffff37c29fb in urcu_workqueue_queue_work (workqueue=0x55555f74aa00,
> work=0x555566e05e00, func=0x7ffff7523c90 <write_dirty_finish>) at
> workqueue.c:3
> 67
> #3  0x00007ffff752c520 in aio_complete_cb (ctx=<optimized out>,
> iocb=<optimized out>, res=<optimized out>, res2=<optimized out>) at
> bio/aio_bio_adapter.c:152
> #4  0x00007ffff752c696 in poll_io_complete (arg=0x555562e4f4a0) at
> bio/aio_bio_adapter.c:289
> #5  0x00007ffff72e6ea5 in start_thread () from /usr/lib64/libpthread.so.0
> #6  0x00007ffff415d96d in clone () from /usr/lib64/libc.so.6
> [Switching to Thread 0x7fffde3f3700 (LWP 821768)]
> Hardware watchpoint 4: -location workqueue->futex
> 
> Old value = 0
> New value = -1
> 0x00007ffff37c2473 in __uatomic_dec (len=4, addr=0x55555f74aa40) at
> ../include/urcu/uatomic.h:490
> 490     ../include/urcu/uatomic.h: No such file or directory.
> #0  0x00007ffff37c2473 in __uatomic_dec (len=4, addr=0x55555f74aa40) at
> ../include/urcu/uatomic.h:490
> #1  workqueue_thread (arg=0x55555f74aa00) at workqueue.c:250
> #2  0x00007ffff72e6ea5 in start_thread () from /usr/lib64/libpthread.so.0
> #3  0x00007ffff415d96d in clone () from /usr/lib64/libc.so.6
> Hardware watchpoint 4: -location workqueue->futex
> 
> Old value = -1
> New value = -2
> 0x00007ffff37c2473 in __uatomic_dec (len=4, addr=0x55555f74aa40) at
> ../include/urcu/uatomic.h:490
> 490     in ../include/urcu/uatomic.h
> #0  0x00007ffff37c2473 in __uatomic_dec (len=4, addr=0x55555f74aa40) at
> ../include/urcu/uatomic.h:490
> #1  workqueue_thread (arg=0x55555f74aa00) at workqueue.c:250
> #2  0x00007ffff72e6ea5 in start_thread () from /usr/lib64/libpthread.so.0
> #3  0x00007ffff415d96d in clone () from /usr/lib64/libc.so.6
> Hardware watchpoint 4: -location workqueue->futex
> 
> Old value = -2
> New value = -3
> 0x00007ffff37c2473 in __uatomic_dec (len=4, addr=0x55555f74aa40) at
> ../include/urcu/uatomic.h:490
> 490     in ../include/urcu/uatomic.h
> #0  0x00007ffff37c2473 in __uatomic_dec (len=4, addr=0x55555f74aa40) at
> ../include/urcu/uatomic.h:490
> #1  workqueue_thread (arg=0x55555f74aa00) at workqueue.c:250
> #2  0x00007ffff72e6ea5 in start_thread () from /usr/lib64/libpthread.so.0
> #3  0x00007ffff415d96d in clone () from /usr/lib64/libc.so.6
> Hardware watchpoint 4: -location workqueue->futex
> ...
> 
> After this, things went into wild, workqueue->futex got into bigger negative
> value, and workqueue thread eat up the cpu it is using.
> This ends only when workqueue->futex down flew into 0.
> 
> Do you have any idea why this is happening, and how to fix it?
> 
> B.R
> Minlan Wang

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
