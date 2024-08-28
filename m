Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D32C636F0
	for <lttng-dev@archiver.kernel.org>; Wed, 28 Aug 2024 19:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1724872970;
	bh=dqhDHnU+OmbistiZgDxHPqTB+BtQDy2vL1qbMstyTAY=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=E+YGFMTOBpeL2nfp2RKj5WceCsoGZHpxhKOqnJiTIz+Yvi1+qcJ2eGRjbLul0wdm1
	 E1BAQU/w5mLQbLxxyzB0rffo+ahvUBq14x38Y2sQ6xYCypjVwy1NJx/tz72ChRt9qk
	 PFhwft3T27SzARiL/uAaBI0UE+c31x68QcC5GLyuJy8jVmWsDgrrDZ85CLn1xr3cAJ
	 U/+o/NAOhIEJyZEMtPLGlX/9Y/i5JVMFJZiXHHwr0sj95nBroF7iCyWo1Idjrbb0FY
	 n45zzL9FyD45jMdQD4igNk0L/4d2ZyJb/2RHPn31HQ/E+VmDhjp0EukBVTW4EFWDzX
	 m2MwbfKf9+VKg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WvDp13pwLz1DNM;
	Wed, 28 Aug 2024 15:22:49 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4WvDnz4kmKz1D5c
 for <lttng-dev@lists.lttng.org>; Wed, 28 Aug 2024 15:22:47 -0400 (EDT)
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net
 [96.127.217.162])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4WvDnr5Zckz1JQQ;
 Wed, 28 Aug 2024 15:22:40 -0400 (EDT)
Message-ID: <aeb6373f-9bdb-4ae4-8740-c0dcdd825ea1@efficios.com>
Date: Wed, 28 Aug 2024 15:22:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [lttng-dev] [RELEASE] Userspace RCU 0.14.1 and 0.13.4
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

This is a release announcement for the version 0.14.1 and 0.13.4
of the liburcu project.

Included in those releases are bug fixes, new architecture support,
OpenBSD support, and documentation updates.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

* New in these releases:

v0.14.1:

2024-08-28 Userspace RCU 0.14.1
         * Fix: missing typename in URCU_FORCE_CAST
         * Allow building with GCC >= 13.3 on RISC-V
         * pointer.h: Fix the rcu_cmpxchg_pointer documentation
         * Adjust shell script to allow Bash in other locations
         * fix: handle EINTR correctly in get_cpu_mask_from_sysfs
         * Relicense src/compat-smp.h to MIT
         * ppc.h: use mftb on ppc
         * Fix: allow clang to build liburcu on RISC-V
         * Fix -Walloc-size
         * urcu/uatomic/riscv: Mark RISC-V as broken
         * Fix: urcu-bp: misaligned reader accesses
         * LoongArch: Document that byte and short atomics are implemented with LL/SC
         * Add LoongArch support
         * tests/regression/rcutorture: Add wait state
         * urcu-wait: Initialize node in URCU_WAIT_NODE_INIT
         * Fix: urcu-wait: add missing futex.h include
         * Adjust shell scripts to allow Bash in other locations
         * Add support for OpenBSD
         * Revert "compiler.h: Introduce caa_unqual_scalar_typeof"
         * rculfhash: Use caa_container_of_check_null in cds_lfht_entry
         * compiler.h: Introduce caa_container_of_check_null
         * compiler.h: Introduce caa_unqual_scalar_typeof
         * Avoid calling caa_container_of on NULL pointer in cds_lfht macros
         * Fix: revise urcu_read_lock_update() comment
         * Fix: uatomic powerpc comment about lwsync
         * fix: aarch64: allow RHEL7 gcc 4.8.5-11
         * fix: warning 'noreturn' function does return on ppc
         * Fix: use __noreturn__ for C11-compatibility

v0.13.4:

2024-08-28 Userspace RCU 0.13.4
         * Allow building with GCC >= 13.3 on RISC-V
         * pointer.h: Fix the rcu_cmpxchg_pointer documentation
         * fix: handle EINTR correctly in get_cpu_mask_from_sysfs
         * Relicense src/compat-smp.h to MIT
         * ppc.h: use mftb on ppc
         * Fix: allow clang to build liburcu on RISC-V
         * Fix -Walloc-size
         * urcu/uatomic/riscv: Mark RISC-V as broken
         * Fix: urcu-bp: misaligned reader accesses
         * tests/regression/rcutorture: Add wait state
         * urcu-wait: Initialize node in URCU_WAIT_NODE_INIT
         * Fix: urcu-wait: add missing futex.h include
         * Adjust shell scripts to allow Bash in other locations
         * Add support for OpenBSD
         * Revert "compiler.h: Introduce caa_unqual_scalar_typeof"
         * rculfhash: Use caa_container_of_check_null in cds_lfht_entry
         * compiler.h: Introduce caa_container_of_check_null
         * compiler.h: Introduce caa_unqual_scalar_typeof
         * Avoid calling caa_container_of on NULL pointer in cds_lfht macros
         * Fix: revise urcu_read_lock_update() comment
         * Fix: uatomic powerpc comment about lwsync
         * fix: aarch64: allow RHEL7 gcc 4.8.5-11
         * fix: warning 'noreturn' function does return on ppc
         * Fix: use __noreturn__ for C11-compatibility

Project website: https://liburcu.org
Git repository: git://git.liburcu.org/urcu.git
-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
