Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34289C43334
	for <lttng-dev@archiver.kernel.org>; Fri,  3 Jun 2022 19:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1654284638;
	bh=lUDC1bHncqyBAwfj4iBiTs/dXnoceuxqVv05OlO/TLc=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Jh2AB2jeeuJfuDcYbYpsDB+CRuNuNiFlEAKokeUu2qhEBEIHtxWLimvAvX4oe7uwW
	 2MkhM6DyqpDJqpEufcjfKG1JA5C5JbZt2auDVPx/IXIClK6yFBClJXx48m20gPz9OU
	 5eSubM9AYnX759ttu+ZysN4mgT9dotr9qNFGR1OTzUUmTWOUuz+Ihi1KaGnyk7Ow4V
	 il/2stGhArp6TjplryoMxwFDMTXZyArgCKGo0zKkVe3yzv7BV+YPApKkSkRFFyKilB
	 XeNl4twB4DJnzghsd1ptIICkG7uTjidyOfLFz47HSmGPa3E66mTeFRFhSpgwDmhzAV
	 2vQ/KY4+r66ow==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LFCf61YLmz4Vk;
	Fri,  3 Jun 2022 15:30:38 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LFCf46XLLz4Vh
 for <lttng-dev@lists.lttng.org>; Fri,  3 Jun 2022 15:30:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D78913FD692
 for <lttng-dev@lists.lttng.org>; Fri,  3 Jun 2022 15:30:35 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id PoAEU5B-W_Nf; Fri,  3 Jun 2022 15:30:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 56F813FD2E8;
 Fri,  3 Jun 2022 15:30:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 56F813FD2E8
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id y1CIPhIGFxiu; Fri,  3 Jun 2022 15:30:35 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 4BE963FD619;
 Fri,  3 Jun 2022 15:30:35 -0400 (EDT)
Date: Fri, 3 Jun 2022 15:30:35 -0400 (EDT)
To: lttng-dev <lttng-dev@lists.lttng.org>, 
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>, 
 linux-trace-users <linux-trace-users@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <846400291.20840.1654284635213.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4272 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4257)
Thread-Index: DHrGG1JJg8YJlaBmRz8CT/+mTxeC+w==
Thread-Topic: LTTng-modules 2.13.4 and 2.12.9 (Linux kernel tracer)
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.13.4 and 2.12.9 (Linux kernel
 tracer)
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

Hi,

The 2.13.4 and 2.12.9 releases are bug fix releases for the currently
maintained LTTng-modules stable branches.

Noteworthy in the 2.12.9 release:

The README.md file now document that the stable-2.12 branch of
LTTng-modules supports Linux kernels between 3.0 and 5.17 (inclusive).
Support for the 5.18 kernel is provided starting from the stable-2.13
branch of LTTng-modules. Also, tracepoint instrumentation was adapted
to follow changes to upstream kernels: the "random" tracepoint
subsystem was removed from 5.18, and this removal was backported to
stable kernels as well. Finally, a compaction subsystem instrumentation
name-spacing fix is included.

Noteworthy in the 2.13.4 release: 

The same instrumentation fixes as 2.12.4 were integrated, affecting the
compaction and random subsystems. Changes to tracepoint instrumentation
were done to support the 5.18 Linux kernel, affecting the block, compaction,
sched, scsi, and kvm subsystems. The kprobes instrumentation was adapted
to use the rethooks if possible (needed for 5.18).

Now that the kvm subsystem unexports the kvm_x86_ops symbols in 5.18,
lttng-modules relies on kallsyms to use this symbol.

Finally, two changes are really more in the "bug fix" category rather than
adapting to newer kernels: the bytecode interpreter in lttng-modules left the
context fields byte order uninitialized, thus leading to bogus context field
values in the event notification capture feature. Fix this by initializing
the byte order. A hard-to-trigger race is also fixed in the event notifier
use of the ring buffer.

Changelog:

2022-06-03 (National Repeat Day) (National Repeat Day) LTTng modules 2.13.4
        * Fix: event notifier: racy use of last subbuffer record
        * Fix: bytecode interpreter context_get_index() leaves byte order uninitialized
        * fix: 'random' tracepoints removed in stable kernels
        * fix: random: remove unused tracepoints (v5.10, v5.15)
        * fix: sched/tracing: Append prev_state to tp args instead (v5.18)
        * fix: mm: compaction: cleanup the compaction trace events (v5.18)
        * fix: scsi: core: Remove <scsi/scsi_request.h> (v5.18)
        * fix: kprobes: Use rethook for kretprobe if possible (v5.18)
        * fix: random: remove unused tracepoints (v5.18)
        * fix: scsi: block: Remove REQ_OP_WRITE_SAME support (v5.18)
        * fix: block: remove genhd.h (v5.18)
        * fix: sched/tracing: Don't re-read p->state when emitting sched_switch event (v5.18)
        * fix: KVM: x86: Unexport kvm_x86_ops (v5.18)
        * Fix: do not warn on unknown counter ioctl
        * Fix: tracepoint event: allow same provider and event name
        * Fix: compaction migratepages event name

2022-06-03 (National Repeat Day) (National Repeat Day) LTTng modules 2.12.9
        * fix: 'random' tracepoints removed in stable kernels
        * fix: random: remove unused tracepoints (v5.10, v5.15)
        * fix: random: remove unused tracepoints (v5.18)
        * Document supported kernel versions for stable-2.12 branch
        * Fix: include erroneously removed by backport
        * Fix: tracepoint event: allow same provider and event name
        * Fix: compaction migratepages event name

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
