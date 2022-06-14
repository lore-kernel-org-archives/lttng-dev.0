Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A62FC43334
	for <lttng-dev@archiver.kernel.org>; Tue, 14 Jun 2022 13:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655214843;
	bh=LxzfP9eCO+VV0MqAwXiPomZ1KQCddlIjqIAieeQdBZU=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=wRKnuecdgi7CBKlWWcuAOsXZIZm1ckdX/HiWSDSwDjOlCD9tbXpTlajnG2H1MqN4x
	 pTzfYuydhvgi8TKc84hu8m6CWlkwUPHHPSj0f6cBVEgnE0QQeQDZYMB01feodwMbac
	 DreMfLuB/tgV4c91rtDqUaK7Wl751A8zUvUIx46OVRoOPqD0hLUUF301dp252uCiyx
	 6v8c4LU7hiARcmI5PBQL0BI0rHy+s3IhovmyCJl9DE81nwWOybggCdwHgI6c9AG3GM
	 SA84glqdfmiTqcgyiuAG6h+Wjm8auNZbghy/9YSRW7vXQADSnZf8lvy2edLQUjHtxc
	 pLCG9MOKe//Sw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LMqfg22dsz80X;
	Tue, 14 Jun 2022 09:54:03 -0400 (EDT)
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
 by lists.lttng.org (Postfix) with ESMTPS id 4LMZPJ0cLtz85J
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jun 2022 23:56:35 -0400 (EDT)
X-QQ-mid: bizesmtp73t1655178937tnor3bnb
Received: from localhost.localdomain ( [113.90.139.158])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 14 Jun 2022 11:55:36 +0800 (CST)
X-QQ-SSF: 01400000000000B0G000000A0000000
X-QQ-FEAT: RMVj0UrY8cDx58+wE+cgDcehCJ3mNoNWv1N4tG4Dj1qxzSn4KaIOpAWnhRccx
 Q9jRMLy8H07uvomFcB+Ycl9kPD5gOsCWqWBVds6zrCph1dcUEviqsNrkhS+VGGD2dKhYJDf
 jyPU4vfCfilrBtz2hS9kLqJWNUBGLAIR3udrWbECOGZwtu8ZB61ksSQTWiNaVWhygTX2Ral
 8YJgBN8RnOyTz1npW+D0sgGDQ3PYVKvmTT0PraeESqZEwF2YWCuTUAujghNkkcbagD3W4Rb
 W3B+v70PMfd6A9RbrNUltCmcDWSpTr2zg7/onzL+Z6sm6QC4J8t+ApibMgR2lTYQbeq+3TG
 Frbo7mU8xdDBdQn8T0=
X-QQ-GoodBg: 2
Date: Mon, 13 Jun 2022 23:55:33 -0400
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
Message-ID: <20220614035533.GA174967@localhost.localdomain>+C23B4245BB527E95
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:szsandstone.com:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
X-Mailman-Approved-At: Tue, 14 Jun 2022 09:54:01 -0400
Subject: [lttng-dev] urcu workqueue thread uses 99% of cpu while workqueue
 is empty
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
	We are running a CentOS 8.2 os on Intel(R) Xeon(R) CPU E5-2630 v4,
and using the workqueue interfaces in src/workqueue.h in
userspace-rcu-latest-0.12.tar.bz2. 
	Recently, we found the workqueue thread rushes cpu into 99% usage.
After some debuging, we found that the futex in struct urcu_workqueue got
into very big negative value, e.g, -12484; while the qlen, cbs_tail, and
cbs_head suggest that the workqueue is empty.
We add a watchpoint of workqueue->futex in workqueue_thread(), and got this
log when workqueue->futex first get into -2:
...
Old value = -1
New value = 0
0x00007ffff37c1d6d in futex_wake_up (futex=0x55555f74aa40) at workqueue.c:160
160     in workqueue.c
#0  0x00007ffff37c1d6d in futex_wake_up (futex=0x55555f74aa40) at
workqueue.c:160
#1  0x00007ffff37c2737 in wake_worker_thread (workqueue=0x55555f74aa00) at
workqueue.c:324
#2  0x00007ffff37c29fb in urcu_workqueue_queue_work (workqueue=0x55555f74aa00,
work=0x555566e05e00, func=0x7ffff7523c90 <write_dirty_finish>) at
workqueue.c:3
67
#3  0x00007ffff752c520 in aio_complete_cb (ctx=<optimized out>,
iocb=<optimized out>, res=<optimized out>, res2=<optimized out>) at
bio/aio_bio_adapter.c:152
#4  0x00007ffff752c696 in poll_io_complete (arg=0x555562e4f4a0) at
bio/aio_bio_adapter.c:289
#5  0x00007ffff72e6ea5 in start_thread () from /usr/lib64/libpthread.so.0
#6  0x00007ffff415d96d in clone () from /usr/lib64/libc.so.6
[Switching to Thread 0x7fffde3f3700 (LWP 821768)]
Hardware watchpoint 4: -location workqueue->futex

Old value = 0
New value = -1
0x00007ffff37c2473 in __uatomic_dec (len=4, addr=0x55555f74aa40) at
../include/urcu/uatomic.h:490
490     ../include/urcu/uatomic.h: No such file or directory.
#0  0x00007ffff37c2473 in __uatomic_dec (len=4, addr=0x55555f74aa40) at
../include/urcu/uatomic.h:490
#1  workqueue_thread (arg=0x55555f74aa00) at workqueue.c:250
#2  0x00007ffff72e6ea5 in start_thread () from /usr/lib64/libpthread.so.0
#3  0x00007ffff415d96d in clone () from /usr/lib64/libc.so.6
Hardware watchpoint 4: -location workqueue->futex

Old value = -1
New value = -2
0x00007ffff37c2473 in __uatomic_dec (len=4, addr=0x55555f74aa40) at
../include/urcu/uatomic.h:490
490     in ../include/urcu/uatomic.h
#0  0x00007ffff37c2473 in __uatomic_dec (len=4, addr=0x55555f74aa40) at
../include/urcu/uatomic.h:490
#1  workqueue_thread (arg=0x55555f74aa00) at workqueue.c:250
#2  0x00007ffff72e6ea5 in start_thread () from /usr/lib64/libpthread.so.0
#3  0x00007ffff415d96d in clone () from /usr/lib64/libc.so.6
Hardware watchpoint 4: -location workqueue->futex

Old value = -2
New value = -3
0x00007ffff37c2473 in __uatomic_dec (len=4, addr=0x55555f74aa40) at
../include/urcu/uatomic.h:490
490     in ../include/urcu/uatomic.h
#0  0x00007ffff37c2473 in __uatomic_dec (len=4, addr=0x55555f74aa40) at
../include/urcu/uatomic.h:490
#1  workqueue_thread (arg=0x55555f74aa00) at workqueue.c:250
#2  0x00007ffff72e6ea5 in start_thread () from /usr/lib64/libpthread.so.0
#3  0x00007ffff415d96d in clone () from /usr/lib64/libc.so.6
Hardware watchpoint 4: -location workqueue->futex
...

After this, things went into wild, workqueue->futex got into bigger negative
value, and workqueue thread eat up the cpu it is using.
This ends only when workqueue->futex down flew into 0.

Do you have any idea why this is happening, and how to fix it?

B.R
Minlan Wang



_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
