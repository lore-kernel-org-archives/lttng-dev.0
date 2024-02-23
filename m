Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BDAC54798
	for <lttng-dev@archiver.kernel.org>; Fri, 23 Feb 2024 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1708707286;
	bh=3AFfzK/4VidznFI6nWETWRaF8ph8DRCFtB/R9gf6Um0=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=kjdTP+Ii9MwytoXkEHOIpM2a0FdSSNr/C4da/7jVw1O9K1UOst38xp7Btq8HuOnl0
	 MBW6WxyXSi4qmdXrsNSdfrzFXAcNW9UVqyKGniVTRytRhjlDMm02obSARy4Dr5ZPSD
	 F2Zh87+mcyb8mPwl3QYUe1mLI6URAg9PZS2LcAYQVIQb5EJ9txNrcyCyfZvaP7GNph
	 W80h2z7ldwVvTjkJ4Thn5TmS/UmQSibaZKW1Cs3nazP9wb5UaOc25TnK0MJ7KbtKy0
	 GOqOmJ9i3aI3gs/pTswhcvj6U+9Xv7d72mYkqNe8Hj14SpB5EEBVW7loTzicTwhPkh
	 0jHbDk1BdP3Hg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ThGMT0JNnz28py;
	Fri, 23 Feb 2024 11:54:45 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4ThGMS2CCXz28pw
 for <lttng-dev@lists.lttng.org>; Fri, 23 Feb 2024 11:54:37 -0500 (EST)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4ThGMB6c12zd2Q;
 Fri, 23 Feb 2024 11:54:30 -0500 (EST)
Message-ID: <c9427e40-10b1-49eb-9baa-dde1364e8fe5@efficios.com>
Date: Fri, 23 Feb 2024 11:54:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
 <20240217104924.GB10393@redhat.com>
 <20240219112926.77ac16f8@gandalf.local.home>
 <20240219170038.GA710@redhat.com>
 <20240219122825.31579a1e@gandalf.local.home>
 <776b842b-b19f-44bf-bc34-ac756fce7466@efficios.com>
 <20240223092630.49b9d367@gandalf.local.home>
In-Reply-To: <20240223092630.49b9d367@gandalf.local.home>
Subject: Re: [lttng-dev] [PATCH] coredump debugging: add a tracepoint to
 report the coredumping
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
Cc: wenyang.linux@foxmail.com, Peter Zijlstra <peterz@infradead.org>,
 Karim Yaghmour <karim.yaghmour@opersys.com>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, lttng-dev <lttng-dev@lists.lttng.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>, Ingo Molnar <mingo@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2024-02-23 09:26, Steven Rostedt wrote:
> On Mon, 19 Feb 2024 13:01:16 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Between "sched_process_exit" and "sched_process_free", the task can still be
>> observed by a trace analysis looking at sched and signal events: it's a zombie at
>> that stage.
> 
> Looking at the history of this tracepoint, it was added in 2008 by commit
> 0a16b60758433 ("tracing, sched: LTTng instrumentation - scheduler").
> Hmm, LLTng? I wonder who the author was?

[ common typo: LLTng -> LTTng ;-) ]

> 
>    Author: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> 
>   :-D
> 
> Mathieu, I would say it's your call on where the tracepoint can be located.
> You added it, you own it!

Wow! that's now 16 years ago :)

I've checked with Matthew Khouzam (maintainer of Trace Compass)
which care about this tracepoint, and we have not identified any
significant impact of moving it on its model of the scheduler, other
than slightly changing its timing.

I've also checked quickly in lttng-analyses and have not found
any code that care about its specific placement.

So I would say go ahead and move it earlier in do_exit(), it's
fine by me.

If you are interested in a bit of archeology, "sched_process_free"
originated from my ltt-experimental 0.1.99.13 kernel patch against
2.6.12-rc4-mm2 back in September 2005 (that's 19 years ago). It was
a precursor to the LTTng 0.x kernel patchset.

https://lttng.org/files/ltt-experimental/patch-2.6.12-rc4-mm2-ltt-exp-0.1.99.13.gz

Index: kernel/exit.c
===================================================================
--- a/kernel/exit.c	(.../trunk/kernel/linux-2.6.12-rc4-mm2)	(revision 41)
+++ b/kernel/exit.c	(.../branches/mathieu/linux-2.6.12-rc4-mm2)	(revision 41)
@@ -4,6 +4,7 @@
   *  Copyright (C) 1991, 1992  Linus Torvalds
   */
  
+#include <linux/ltt/ltt-facility-process.h>
  #include <linux/config.h>
  #include <linux/mm.h>
  #include <linux/slab.h>
@@ -55,6 +56,7 @@ static void __unhash_process(struct task
  	}
  
  	REMOVE_LINKS(p);
+  trace_process_free(p->pid);
  }
  
  void release_task(struct task_struct * p)
@@ -832,6 +834,8 @@ fastcall NORET_TYPE void do_exit(long co
  	}
  	exit_mm(tsk);
  
+	trace_process_exit(tsk->pid);
+
  	exit_sem(tsk);
  	__exit_files(tsk);
  	__exit_fs(tsk);

This was a significant improvement over the prior LTT which only
had the equivalent of "sched_process_exit", which caused issues
with the Linux scheduler model in LTTV due to zombie processes.

Here is where it appeared in LTT back in 1999:

http://www.opersys.com/ftp/pub/LTT/TracePackage-0.9.0.tgz

patch-ltt-2.2.13-991118

diff -urN linux/kernel/exit.c linux-2.2.13/kernel/exit.c
--- linux/kernel/exit.c	Tue Oct 19 20:14:02 1999
+++ linux-2.2.13/kernel/exit.c	Sun Nov  7 23:49:17 1999
@@ -14,6 +14,8 @@
  #include <linux/acct.h>
  #endif
  
+#include <linux/trace.h>
+
  #include <asm/uaccess.h>
  #include <asm/pgtable.h>
  #include <asm/mmu_context.h>
@@ -386,6 +388,8 @@
  	del_timer(&tsk->real_timer);
  	end_bh_atomic();
  
+	TRACE_PROCESS(TRACE_EV_PROCESS_EXIT, 0, 0);
+
  	lock_kernel();
  fake_volatile:
  #ifdef CONFIG_BSD_PROCESS_ACCT

And it was moved to its current location (after exit_mm()) a bit
later (2001):

http://www.opersys.com/ftp/pub/LTT/TraceToolkit-0.9.5pre2.tgz

Patches/patch-ltt-linux-2.4.5-vanilla-010909-1.10

diff -urN linux/kernel/exit.c /ext2/home/karym/kernel/linux-2.4.5/kernel/exit.c
--- linux/kernel/exit.c	Fri May  4 17:44:06 2001
+++ /ext2/home/karym/kernel/linux-2.4.5/kernel/exit.c	Wed Jun 20 12:39:24 2001
@@ -14,6 +14,8 @@
  #include <linux/acct.h>
  #endif
  
+#include <linux/trace.h>
+
  #include <asm/uaccess.h>
  #include <asm/pgtable.h>
  #include <asm/mmu_context.h>
@@ -439,6 +441,8 @@
  #endif
  	__exit_mm(tsk);
  
+	TRACE_PROCESS(TRACE_EV_PROCESS_EXIT, 0, 0);
+
  	lock_kernel();
  	sem_exit();
  	__exit_files(tsk);

So this sched_process_exit placement was actually decided
by Karim Yaghmour back in the LTT days (2001). I don't think
he will mind us moving it around some 23 years later. ;)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
