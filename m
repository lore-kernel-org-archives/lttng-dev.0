Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83827C43334
	for <lttng-dev@archiver.kernel.org>; Fri, 24 Jun 2022 06:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1656051718;
	bh=1FLEBdP5gIsdJdEKtu4XwP9RVRnjmvLIoB0ZR1/qw4Q=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=FLSc40mIvigH31SluUOq/x/kt1Cj5DUkBSNLVTxYG/fFc7uPbhH3bBvPDHAibVNkN
	 eT7osbDz01jMqlRidJ7fnpbhEStK/1029IQ2ygOAeZTX11l/6DaAEvZCibv6PoGCnd
	 LWu66QUAZhhgKadAswNBTbpCtgD+azJpHZcPame5b/T+gLudwZjSrxptpVQfoVj6Fm
	 gj3zX8IQYmaSS87pZ3mqiuQ6QV89xaUqyAPBY8WoRed3WhRzLvlfr87wlk0ZVSCJtx
	 izT4omahQ7Kr4CmOoQd5SOtCkgsWgHW5+zO6wjmg7aIEpaEs58WamaTskYEbnGo0Xs
	 LpKlyaQfOwdZA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LTn8P2G79zFB4;
	Fri, 24 Jun 2022 02:21:57 -0400 (EDT)
Received: from smtpbg506.qq.com (smtpbg506.qq.com [203.205.250.33])
 by lists.lttng.org (Postfix) with ESMTPS id 4LTn8L46YpzDmD
 for <lttng-dev@lists.lttng.org>; Fri, 24 Jun 2022 02:21:51 -0400 (EDT)
X-QQ-mid: bizesmtp85t1656051700t6ncgdag
Received: from localhost.localdomain ( [116.24.154.153])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 24 Jun 2022 14:21:38 +0800 (CST)
X-QQ-SSF: 01400000002000B0G000B00A0000000
X-QQ-FEAT: ZJ5VjJmbjcz+xkwwRCT+1PuLN47QjHjNAlM4+A1IA+EoypS0IuC/kad4jjYKp
 yEIxGdvexsdJwmJjNd8NGVxvbBfNX7BbSUWH5laqUHlBrI6BG90o/QMWvMMFOZoqoHH/ioa
 O9xk6v0+Voug6Y7q81Nvjf9bsdmB37Ydse8vqky+8r1vBgstTl5xomTysMuadZctZm2tKv/
 +DUbZ399SXBwSp2e0VBhz6zPEqCcohaf8uTrX5t2oCK2lFMlq206tiLniw8yYYHX6NSZEVM
 w/CQZ9hPlMxUvWNXDyeziarjv2qr96+h5zfvny+a/sn2tuO6TCyzEp7O+1ViMLPwyF0CJ7A
 re2WmwZ7icMFuPtoiQ=
X-QQ-GoodBg: 2
Date: Fri, 24 Jun 2022 02:21:35 -0400
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
Message-ID: <20220624062135.GA273344@localhost.localdomain>+F4949EE93CFACC14
References: <20220614035533.GA174967@localhost.localdomain>
 <1711122492.5944.1655473043420.JavaMail.zimbra@efficios.com>
 <20220621035206.GA267474@localhost.localdomain>
 <1843612610.17820.1655817158376.JavaMail.zimbra@efficios.com>
 <20220622074535.GA269641@localhost.localdomain>
 <1420937751.21327.1655903998961.JavaMail.zimbra@efficios.com>
 <20220623034528.GA271179@localhost.localdomain>
 <20220623035722.GA271206@localhost.localdomain>
 <1998086009.28888.1655993395580.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1998086009.28888.1655993395580.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:szsandstone.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
Subject: Re: [lttng-dev] ***UNCHECKED*** Re: Re: urcu workqueue thread uses
 99% of cpu while	workqueue is empty
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

On Thu, Jun 23, 2022 at 10:09:55AM -0400, Mathieu Desnoyers wrote:
> 
> By looking at the trace, here is one problematic scenario which end up emitting "workqueue:futex_wait_again":
> 
> [23:33:48.060581417] (+0.000006985) localhost.localdomain workqueue:futex_no_wait: { cpu_id = 4 }, { vpid = 19495, vtid = 21054 }, { futex = 0x5652A1035C40, val = 0 }
> [23:33:48.060581747] (+0.000000330) localhost.localdomain workqueue:futex_wake_up_success: { cpu_id = 6 }, { vpid = 19495, vtid = 20649 }, { futex = 0x5652A1035C40, val = -1 }
> [23:33:48.060581926] (+0.000000179) localhost.localdomain workqueue:futex_dec_success: { cpu_id = 4 }, { vpid = 19495, vtid = 21054 }, { futex = 0x5652A1035C40, old = 0, new = -1 }
> [23:33:48.060582826] (+0.000000900) localhost.localdomain syscall_entry_futex: { cpu_id = 6 }, { vpid = 19495, vtid = 20649, pid = 19495, tid = 20649 }, { uaddr = 94912888659008, op = 1, val = 1, utime = 0, uaddr2 = 0, val3 = 0 }
> [23:33:48.060582855] (+0.000000029) localhost.localdomain syscall_entry_futex: { cpu_id = 4 }, { vpid = 19495, vtid = 21054, pid = 19495, tid = 21054 }, { uaddr = 94912888659008, op = 0, val = 4294967295, utime = 0, uaddr2 = 0, val3 = 0 }
> [23:33:48.060584722] (+0.000001867) localhost.localdomain sched_stat_runtime: { cpu_id = 4 }, { vpid = 19495, vtid = 21054, pid = 19495, tid = 21054 }, { comm = "bcache_writebac", tid = 21054, runtime = 16033, vruntime = 96940983054 }
> [23:33:48.060585840] (+0.000001118) localhost.localdomain sched_switch: { cpu_id = 4 }, { vpid = 19495, vtid = 21054, pid = 19495, tid = 21054 }, { prev_comm = "bcache_writebac", prev_tid = 21054, prev_prio = 20, prev_state = 1, next_comm = "swapper/4", next_tid = 0, next_prio = 20 }
> [23:33:48.060587680] (+0.000001840) localhost.localdomain sched_stat_sleep: { cpu_id = 6 }, { vpid = 19495, vtid = 20649, pid = 19495, tid = 20649 }, { comm = "bcache_writebac", tid = 21054, delay = 2815 }
> [23:33:48.060588560] (+0.000000880) localhost.localdomain sched_wakeup: { cpu_id = 6 }, { vpid = 19495, vtid = 20649, pid = 19495, tid = 20649 }, { comm = "bcache_writebac", tid = 21054, prio = 20, success = 1, target_cpu = 4 }
> [23:33:48.060590437] (+0.000001877) localhost.localdomain syscall_exit_futex: { cpu_id = 4 }, { vpid = 19495, vtid = 21054, pid = 19495, tid = 21054 }, { ret = 0, uaddr = 94912888659008, uaddr2 = 0 }
> [23:33:48.060591337] (+0.000000900) localhost.localdomain syscall_exit_futex: { cpu_id = 6 }, { vpid = 19495, vtid = 20649, pid = 19495, tid = 20649 }, { ret = 1, uaddr = 94912888659008, uaddr2 = 0 }
> [23:33:48.060591385] (+0.000000048) localhost.localdomain workqueue:futex_wait_return: { cpu_id = 4 }, { vpid = 19495, vtid = 21054 }, { futex = 0x5652A1035C40, val = -1, ret = 0 }
> [23:33:48.060592205] (+0.000000820) localhost.localdomain workqueue:futex_wait_again: { cpu_id = 4 }, { vpid = 19495, vtid = 21054 }, { futex = 0x5652A1035C40, val = -1 }
> 
> Where the wake_up happens right before the dec_success on the waiter, which
> leads to the sched_wakeup awakening the waiter when the state is 0.
Yes, this makes things clear, urcu_workqueue_queue_work did wake up waiters on
futex when the futex is -1.

> 
> If we want to dig more into why this scenario can happen, we could also add tracepoints
> in urcu_workqueue_queue_work() just before/after cds_wfcq_enqueue(), and in 
> workqueue_thread() around each call to cds_wfcq_empty(), and around __cds_wfcq_splice_blocking().
> 
> I suspect we end up in a situation where:
> 
> * waker:
> 
>         cds_wfcq_enqueue(&workqueue->cbs_head, &workqueue->cbs_tail, &work->next); [a]
>         uatomic_inc(&workqueue->qlen);
>         wake_worker_thread(workqueue);                                             [b]
> 
> vs
> 
> * waiter:
>                 splice_ret = __cds_wfcq_splice_blocking(&cbs_tmp_head,             [c]
>                         &cbs_tmp_tail, &workqueue->cbs_head, &workqueue->cbs_tail);
> [...]
>                         if (cds_wfcq_empty(&workqueue->cbs_head,                   [d]
>                                         &workqueue->cbs_tail)) {
>                                 futex_wait(&workqueue->futex);                     [e]
>                                 uatomic_dec(&workqueue->futex);                    [f]
> 
> happen in an order such that 
> 
> [a] enqueues an item. Then [c] splices the item out of the queue because it was already awakened
> by a prior wakeup. So the queue is observed as empty by [c]. Then [b] sets the futex to 0
> (in userspace), which causes [e] to skip waiting on the futex, and [f] brings the value back
> to -1. However, in the next loop, the queue is still observed as empty by [d], thus calling
> [e] again. This time, the value is -1, so it calls sys_futex FUTEX_WAIT. Unfortunately, we
> still have the call to sys_futex FUTEX_WAKE that will eventually be executed, thus awakening
> the futex while the futex state is still -1, which is unexpected.
Yes, i agree with you. We'll add the patch you mentioned into our code to fix this.
Thanks for your help.

Since cds_wfcq_enqueue/__cds_wfcq_splice_blocking do nothing to
workqueue->futex, add debug info to see if workqueue is empty is not so
neccessary to me.
Let me know if you need anything else on this.

Thanks, again.

Minlan


_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
