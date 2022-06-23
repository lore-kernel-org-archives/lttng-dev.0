Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDEDC433EF
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jun 2022 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655993406;
	bh=64KWOcN6wqwCyGQAJ+zuJ8Q7ktC0vA4OMxvr5r0Ovio=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LOVod+GT+u/r4pRVVo0RdDgpuoDNhDg0z/pTt3B8ag71TZOApQDHN5qptpFUvuzPn
	 UjOa9JDr91ngq37YtC2pAtvqF6XYcE7eUy/D045idtsDBvOwi2qeKpJTxBM7W4k0OW
	 5USfGWzV5kh9qnCJFTCn5MyGgeZ6hLxX+MNSOoMcr3Dl7T16/+rgopcCxxH4+qShTz
	 m9NCpUHemd8aOvWFJyc0nHs9u/b6Q27TfjFlBcKDhTtyZIwLrFNrZntdDLsinYo/x4
	 YOFcAQ+tcBMBdM52X8/tVrt2ldCuqnyeZ/pqpRIlxrAGX7XqhhR7Erd7KeTDyemBMK
	 RjrnJx2wTMhqg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LTMb15FGRzDyq;
	Thu, 23 Jun 2022 10:10:05 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LTMZz4wxJzDns
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jun 2022 10:10:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 423863B4FF1
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jun 2022 10:09:56 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id TvSi8rJYcYPT; Thu, 23 Jun 2022 10:09:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BC2A43B52B5;
 Thu, 23 Jun 2022 10:09:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BC2A43B52B5
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Wy88GF6Xo4Sz; Thu, 23 Jun 2022 10:09:55 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id AB8FD3B54A7;
 Thu, 23 Jun 2022 10:09:55 -0400 (EDT)
Date: Thu, 23 Jun 2022 10:09:55 -0400 (EDT)
To: Minlan Wang <wangminlan@szsandstone.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
Message-ID: <1998086009.28888.1655993395580.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220623035722.GA271206@localhost.localdomain>+CCEFE5C72E6CA40A>
References: <20220614035533.GA174967@localhost.localdomain>
 <1711122492.5944.1655473043420.JavaMail.zimbra@efficios.com>
 <20220621035206.GA267474@localhost.localdomain>
 <1843612610.17820.1655817158376.JavaMail.zimbra@efficios.com>
 <20220622074535.GA269641@localhost.localdomain>
 <1420937751.21327.1655903998961.JavaMail.zimbra@efficios.com>
 <20220623034528.GA271179@localhost.localdomain>
 <20220623035722.GA271206@localhost.localdomain>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: ***UNCHECKED*** Re: Re: urcu workqueue thread uses 99% of cpu
 while workqueue is empty
Thread-Index: WOZluzwIliU/mUW13i1giI+EEHwmzw==
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Jun 22, 2022, at 11:57 PM, Minlan Wang wangminlan@szsandstone.com wrote:

> On Wed, Jun 22, 2022 at 11:45:28PM -0400, Minlan Wang wrote:
>> The session output is in attachment: 0623_futex-20220623-112754.tar.bz2
> Hi, Mathieu,
> There are several workqueues in the process i tracked.
> The one used to trigger the issuse is this:
> thread with vtid=21054, and futex = 0x5652A1035C40

By looking at the trace, here is one problematic scenario which end up emitting "workqueue:futex_wait_again":

[23:33:48.060581417] (+0.000006985) localhost.localdomain workqueue:futex_no_wait: { cpu_id = 4 }, { vpid = 19495, vtid = 21054 }, { futex = 0x5652A1035C40, val = 0 }
[23:33:48.060581747] (+0.000000330) localhost.localdomain workqueue:futex_wake_up_success: { cpu_id = 6 }, { vpid = 19495, vtid = 20649 }, { futex = 0x5652A1035C40, val = -1 }
[23:33:48.060581926] (+0.000000179) localhost.localdomain workqueue:futex_dec_success: { cpu_id = 4 }, { vpid = 19495, vtid = 21054 }, { futex = 0x5652A1035C40, old = 0, new = -1 }
[23:33:48.060582826] (+0.000000900) localhost.localdomain syscall_entry_futex: { cpu_id = 6 }, { vpid = 19495, vtid = 20649, pid = 19495, tid = 20649 }, { uaddr = 94912888659008, op = 1, val = 1, utime = 0, uaddr2 = 0, val3 = 0 }
[23:33:48.060582855] (+0.000000029) localhost.localdomain syscall_entry_futex: { cpu_id = 4 }, { vpid = 19495, vtid = 21054, pid = 19495, tid = 21054 }, { uaddr = 94912888659008, op = 0, val = 4294967295, utime = 0, uaddr2 = 0, val3 = 0 }
[23:33:48.060584722] (+0.000001867) localhost.localdomain sched_stat_runtime: { cpu_id = 4 }, { vpid = 19495, vtid = 21054, pid = 19495, tid = 21054 }, { comm = "bcache_writebac", tid = 21054, runtime = 16033, vruntime = 96940983054 }
[23:33:48.060585840] (+0.000001118) localhost.localdomain sched_switch: { cpu_id = 4 }, { vpid = 19495, vtid = 21054, pid = 19495, tid = 21054 }, { prev_comm = "bcache_writebac", prev_tid = 21054, prev_prio = 20, prev_state = 1, next_comm = "swapper/4", next_tid = 0, next_prio = 20 }
[23:33:48.060587680] (+0.000001840) localhost.localdomain sched_stat_sleep: { cpu_id = 6 }, { vpid = 19495, vtid = 20649, pid = 19495, tid = 20649 }, { comm = "bcache_writebac", tid = 21054, delay = 2815 }
[23:33:48.060588560] (+0.000000880) localhost.localdomain sched_wakeup: { cpu_id = 6 }, { vpid = 19495, vtid = 20649, pid = 19495, tid = 20649 }, { comm = "bcache_writebac", tid = 21054, prio = 20, success = 1, target_cpu = 4 }
[23:33:48.060590437] (+0.000001877) localhost.localdomain syscall_exit_futex: { cpu_id = 4 }, { vpid = 19495, vtid = 21054, pid = 19495, tid = 21054 }, { ret = 0, uaddr = 94912888659008, uaddr2 = 0 }
[23:33:48.060591337] (+0.000000900) localhost.localdomain syscall_exit_futex: { cpu_id = 6 }, { vpid = 19495, vtid = 20649, pid = 19495, tid = 20649 }, { ret = 1, uaddr = 94912888659008, uaddr2 = 0 }
[23:33:48.060591385] (+0.000000048) localhost.localdomain workqueue:futex_wait_return: { cpu_id = 4 }, { vpid = 19495, vtid = 21054 }, { futex = 0x5652A1035C40, val = -1, ret = 0 }
[23:33:48.060592205] (+0.000000820) localhost.localdomain workqueue:futex_wait_again: { cpu_id = 4 }, { vpid = 19495, vtid = 21054 }, { futex = 0x5652A1035C40, val = -1 }

Where the wake_up happens right before the dec_success on the waiter, which
leads to the sched_wakeup awakening the waiter when the state is 0.

If we want to dig more into why this scenario can happen, we could also add tracepoints
in urcu_workqueue_queue_work() just before/after cds_wfcq_enqueue(), and in 
workqueue_thread() around each call to cds_wfcq_empty(), and around __cds_wfcq_splice_blocking().

I suspect we end up in a situation where:

* waker:

        cds_wfcq_enqueue(&workqueue->cbs_head, &workqueue->cbs_tail, &work->next); [a]
        uatomic_inc(&workqueue->qlen);
        wake_worker_thread(workqueue);                                             [b]

vs

* waiter:
                splice_ret = __cds_wfcq_splice_blocking(&cbs_tmp_head,             [c]
                        &cbs_tmp_tail, &workqueue->cbs_head, &workqueue->cbs_tail);
[...]
                        if (cds_wfcq_empty(&workqueue->cbs_head,                   [d]
                                        &workqueue->cbs_tail)) {
                                futex_wait(&workqueue->futex);                     [e]
                                uatomic_dec(&workqueue->futex);                    [f]

happen in an order such that 

[a] enqueues an item. Then [c] splices the item out of the queue because it was already awakened
by a prior wakeup. So the queue is observed as empty by [c]. Then [b] sets the futex to 0
(in userspace), which causes [e] to skip waiting on the futex, and [f] brings the value back
to -1. However, in the next loop, the queue is still observed as empty by [d], thus calling
[e] again. This time, the value is -1, so it calls sys_futex FUTEX_WAIT. Unfortunately, we
still have the call to sys_futex FUTEX_WAKE that will eventually be executed, thus awakening
the futex while the futex state is still -1, which is unexpected.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
