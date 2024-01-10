Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2B1C47073
	for <lttng-dev@archiver.kernel.org>; Wed, 10 Jan 2024 20:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1704920031;
	bh=egCoTY7itHoiT8mdPe5KBKlmmhLrIcAa5ToYQmCRIA4=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=oDaqz7YuEzFAmv4O2o8xQ3LY0tDBNh6QkTB02hGc00zsFOQrWG4OQRVDI890DhfIy
	 ZGUv2Q1bH6Ym5WdQSM8reftDFKy9ZrjheFDGFzXF+B50vqp9hZW2Z3vNAswxJ3UquL
	 PKNWBJD0Pc7YJ5wQAyuzAxufKJ5/PFrmo5V1Tcj61OOeL38Nh/SgqvtUT/lcB5vDiD
	 80sV1MpKULq7kGueGwBc76wbiShviSptUNgyKk8CFPbaB37p83WP4hGGFrmO+fa26H
	 lKzYNTQq761cC2a4B917tBbaTp2b+26En+A1PY8QVCCDzlSux6RIXS6hX5UwP6mOY4
	 kp0pezEyrQfmA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4T9Klg0Kf1z1K70;
	Wed, 10 Jan 2024 15:53:51 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4T9Klc5WbHz1K6s
 for <lttng-dev@lists.lttng.org>; Wed, 10 Jan 2024 15:53:48 -0500 (EST)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4T9Klb5fFTzKc8;
 Wed, 10 Jan 2024 15:53:47 -0500 (EST)
Message-ID: <3c38a8f7-8323-46b2-a29a-2ca06bc60448@efficios.com>
Date: Wed, 10 Jan 2024 15:53:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.12.15 and 2.13.11 (Linux
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

The LTTng modules provide Linux kernel tracing capability to the LTTng
tracer toolset.

* New and noteworthy in these releases:

Newer Linux kernels (v6.6 and v6.7) are now supported by LTTng modules
2.13.11. If you need support for recent kernels (v5.18+), you will
need to upgrade to a recent LTTng-modules 2.13.x.

The "prio" context has been fixed in 2.13.11 to eliminate a crash
triggered by calling a NULL pointer address when using the "prio"
context (lttng add-context -k -t prio). This issue was introduced
when refactoring the prio context code during the 2.13 development.
The missing initialization was re-introduced, and the use of the kernel
"task_prio()" symbol was entirely replaced by inlining a copy of this
trivial function into lttng-modules instead.

The "built-in.sh" script which can be used to add a link to lttng-modules
within a kernel source tree to built LTTng into a Linux kernel image
has been updated to adapt to changes introduced in Linux v6.1.

A work-around to ensure that LTTng-modules works fine on CPUs and kernels
with IBT support enabled has been integrated:

     When the Intel IBT feature is enabled, a CPU supporting this feature
     validates that all indirect jumps/calls land on an ENDBR64 instruction.
     
     The kernel seals functions which are not meant to be called indirectly,
     which means that calling functions indirectly from their address fetched
     using kallsyms or kprobes trigger a crash.
     
     Use the MSR_IA32_S_CET CET_ENDBR_EN MSR bit to temporarily disable ENDBR
     validation around indirect calls to kernel functions. Considering that
     the main purpose of this feature is to prevent ROP-style attacks,
     disabling the ENDBR validation temporarily around the call from a kernel
     module does not affect the ROP protection.


Both 2.13.11 and 2.12.15:

- Fix an issue with importing VFS namespace for Android kernels.

- Fix build for RHEL 8.8 with linux 4.18.0-477.10.1+

- Fix a hardening OOPS during validation of immediate strings in the bytecode
   validator when CONFIG_UBSAN_BOUNDS and/or CONFIG_FORTIFY_SOURCE are
   configured. It boils down to changing 0-len arrays to flexible arrays
   to let the toolchain know about our intent.

- Add Ubuntu Kinetic kernel ranges for jbd2 instrumentation.

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

Detailed change logs:

2024-01-10 (National Houseplant Appreciation Day) LTTng modules 2.13.11
         * Fix: Include linux/sched/rt.h for kernels v3.9 to v3.14
         * Fix: Disable IBT around indirect function calls
         * Inline implementation of task_prio()
         * Fix: prio context NULL pointer exception
         * Fix: MODULE_IMPORT_NS is introduced in kernel 5.4
         * Android: Import VFS namespace for android common kernel
         * Fix: get_file_rcu is missing in kernels < 4.1
         * fix: lookup_fd_rcu replaced by lookup_fdget_rcu in linux 6.7.0-rc1
         * fix: mm, vmscan signatures changed in linux 6.7.0-rc1
         * fix: phys_proc_id and cpu_core_id moved in linux 6.7.0-rc1
         * Fix build for RHEL 8.8 with linux 4.18.0-477.10.1+
         * Fix: bytecode validator: oops during validation of immediate string
         * fix: lttng-probe-kvm-x86-mmu build with linux 6.6
         * fix: built-in lttng with kernel >= v6.1
         * fix: ubuntu kinetic kernel range for jdb2

2024-01-10 (National Houseplant Appreciation Day) 2.12.15
         * Fix: MODULE_IMPORT_NS is introduced in kernel 5.4
         * Android: Import VFS namespace for android common kernel
         * Fix build for RHEL 8.8 with linux 4.18.0-477.10.1+
         * Fix: bytecode validator: oops during validation of immediate string
         * fix: ubuntu kinetic kernel range for jdb2

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
