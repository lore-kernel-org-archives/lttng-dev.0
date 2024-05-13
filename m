Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82703C25B10
	for <lttng-dev@archiver.kernel.org>; Mon, 13 May 2024 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1715628854;
	bh=b4LebmtHm2XSisooDXhx7cDwGea0pqxo0/QlPeZ5Gu0=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=pyhmA7H2j5TeToL+0DNpOmNC3rxlAB3pu/ZFm/wIdh1V86R8e/8tz8H0iJ1uyLD9F
	 1p1UJbDJ16yjQsqA2jOy1oiZIl+3O3N9cG1qjRVu9IkW/z7/LgmGfy3RVAQcy6N2oZ
	 ff801exC17XNNVjeGDDi/6x2ggqEjiLkDHUAYQ6FWuSEvS9mjC9uHh2xCpbUsrcDWP
	 QakKBtavDqfckXLAc13cK5vaYE/9gVu8s3Ay1pF0XFQJkicvNW8Cof+gs+P+KXlmnC
	 DGU+ZH7ZpJ28Y7d/QnyqF23BURnFLP5vWOle9VCF+dKsBPDsRcttSptKZWrxvWk1rf
	 zyn43jaMTayGg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VdV6Y2mzSz2nKN;
	Mon, 13 May 2024 15:34:13 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:b2ee::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4VdV6W3292z2nCl
 for <lttng-dev@lists.lttng.org>; Mon, 13 May 2024 15:34:11 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4VdV6V5dydz109Z;
 Mon, 13 May 2024 15:34:10 -0400 (EDT)
Message-ID: <5c0e0cc3-b849-400c-90eb-2b7d115d2f66@efficios.com>
Date: Mon, 13 May 2024 15:34:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.13.13 and 2.12.17 (Linux
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

The LTTng project provides low-overhead, correlated userspace and
kernel tracing on Linux. Its use of the Common Trace Format and a
flexible control interface allows it to fulfill various workloads.

* New in these releases:

- LTTng-modules 2.13.13:

   - Introduce support for Linux v6.9.

   - Removed unused duplicated code, add missing static to
     function definitions, and add missing includes for function
     declarations which were observed when building against recent
     kernels with newer toolchains.
     We plan to adapt our CI to add jobs that will report warnings
     as errors when building lttng-modules against recent kernels
     with a recent tool chain so we can catch and fix those warnings
     earlier in the future.

- In both LTTng-modules 2.12.17 and 2.13.13:

   - Fix incorrect get_pfnblock_flags_mask prototype which did not match
     upstream after upstream commit 535b81e209219 (v5.9). Fix the prototype
     mismatch detection code as well. This affects the event
     mm_page_alloc_extfrag which uses get_pageblock_migratetype(). Note that
     because the kernel macro get_pageblock_migratetype was also updated
     to pass 3 parameters to get_pfnblock_flags_mask as its kernel prototype
     was updated to expect three parameters, it does not matter that the
     lttng-modules wrapper expects 4 parameters and provides those 4 parameters
     to the kernel function. This issue should therefore not affect the
     runtime behavior.

   - Instrumentation updates to support EL 8.4+.

   - Instrumentation updates for RHEL kernels.

   - Instrumentation updates to the timer subsystem to adapt to
     changes backported in the 4.19 stable kernels.


* Detailed change logs:

2024-05-13 (National Leprechaun Day) LTTng modules 2.13.13
         * splice wrapper: Fix missing declaration
         * page alloc wrapper: Fix get_pfnblock_flags_mask prototype
         * lttng probe: include events-internal.h
         * syscalls: Remove unused duplicated code
         * statedump: Add missing events-internal.h include
         * lttng-events: Add missing static
         * event notifier: Add missing static
         * context callstack: Add missing static
         * lttng-clock: Add missing lttng/events-internal.h include
         * lttng-calibrate: Add missing static and include
         * lttng-bytecode: Remove dead code
         * lttng-abi: Add missing static to function definitions
         * ring buffer: Add missing static to function definitions
         * blkdev wrapper: Fix constness warning
         * Fix: timer_expire_entry changed in 4.19.312
         * Fix: dev_base_lock removed in linux 6.9-rc1
         * Fix: mm_compaction_migratepages changed in linux 6.9-rc1
         * Fix: ASoC add component to set_bias_level events in linux 6.9-rc1
         * Fix: ASoC snd_doc_dapm on linux 6.9-rc1
         * Fix: build kvm probe on EL 8.4+
         * Fix: support ext4_journal_start on EL 8.4+
         * Fix: correct RHEL range for kmem_cache_free define

2024-05-13 (National Leprechaun Day) 2.12.17
         * page alloc wrapper: Fix get_pfnblock_flags_mask prototype
         * Fix: timer_expire_entry changed in 4.19.312
         * Fix: build kvm probe on EL 8.4+
         * Fix: support ext4_journal_start on EL 8.4+
         * Fix: correct RHEL range for kmem_cache_free define

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
