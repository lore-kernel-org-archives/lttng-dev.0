Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81555C3DA49
	for <lttng-dev@archiver.kernel.org>; Thu, 18 Jul 2024 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1721324649;
	bh=txrshG8nopvmOpLI1fYtlwg/dReX0HKfjW8uFTihpT4=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=FofkGr9TllZehwnYOR/6lF1kMBdYuVUG1Uv65s++RuqeCyo9ChHdxIaeBzPyo8bjs
	 OxUW28WSWBU9rfN+TyQNl8FWe5WDOgvne4iDIIxtjNLO9PjRvmEAswqwIbC4Muj/dP
	 s6RMDqY6g1aW2gWvI0QSCjx7Jql2/NVEArJ1rAQjMxHMnAv9oJfomKHP8aMNOqsNE3
	 eHHkK4eMyynZn0TH03xcKWINyqFUMwxqVxbzl50GE7Ohct78y8f/cnExM2WoPXghEW
	 ltMD60IX0/ZmJXhryAGcATSQ6C4y8NAayG/UHFwF9j4uFksdzgaIphrlY9vKDzDURS
	 dsjCbX6BETVjA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WQ0Y459gzz12MY;
	Thu, 18 Jul 2024 13:44:08 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:b2ee::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4WQ0Y26lMvz12kB
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jul 2024 13:44:06 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4WQ0Y11PRqz1D2N;
 Thu, 18 Jul 2024 13:44:05 -0400 (EDT)
Message-ID: <1b61d65c-6c0e-4312-9939-cfdd3fd627ac@efficios.com>
Date: Thu, 18 Jul 2024 13:44:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.13.14 and 2.12.18 (Linux
 kernel tracer)
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

This is a stable release announcement for the LTTng kernel tracer,
an out-of-tree kernel tracer for the Linux kernel.

The highlight of these releases is the added support for Linux v6.10
in LTTng-modules v2.13.14.

The LTTng project provides low-overhead, correlated userspace and
kernel tracing on Linux. Its use of the Common Trace Format and a
flexible control interface allows it to fulfill various workloads.

New in these releases:

* LTTng-modules 2.13.14:

   - Introduce support for Linux v6.10.
   - Fix build on CentOS 9 Stream 2024-6.
   - Fix mm_vmscan_lru_isolate tracepoint build against RHEL 9.4 kernels

* In both LTTng-modules 2.12.18 and 2.13.14:

   - Fix kvm_mmio event NULL pointer dereference in KVM instrumentation.
     This is triggered in case of unsatisfied MMIO read.
   - Fix fdtable wrapper (lttng_lookup_fd_rcu()) for kernel ranges
     5.10.220+.

As usual feedback is welcome!

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
