From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: RELEASE] LTTng modules 2.7.0-rc1
Date: Wed, 15 Jul 2015 22:34:46 +0000 (UTC)
Message-ID: <1558721358.1038.1436999686345.JavaMail.zimbra__5167.94120562754$1436999745$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZFVGX-0000Bv-IL
 for lttng-dev@lists.lttng.org; Wed, 15 Jul 2015 18:35:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E639E3403CA
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2015 22:34:57 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id XLGrxxM_jKch for <lttng-dev@lists.lttng.org>;
 Wed, 15 Jul 2015 22:34:46 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BC5CD3403CD
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2015 22:34:46 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 6s94LNGOuXeZ for <lttng-dev@lists.lttng.org>;
 Wed, 15 Jul 2015 22:34:46 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 959CA3403CA
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2015 22:34:46 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.x tracer toolset.

New and noteworthy for 2.7:

* Supports kernels up to and including 4.1.x,

* Filtering is now implemented for kernel tracing. It can be used
  through the same UI and API as with lttng-ust.

* Added $ctx.cpu_id context for filtering (note: also available in
  lttng-ust now),

* New clock source plugin support. User-provide clock source
  override can be provided as a kernel module,

* New PID tracker: specify which process IDs you want to trace,
  (also available with lttng-ust)

* Wildcard support now available: can now specify e.g. 'sched_*'
  to enable all scheduler events. Similar UI/API as lttng-ust.

Changelog:

2015-07-15 (Pet Fire Safety Day) lttng-ust 2.7.0-rc1
        * Fix: Building the event list fails on fragmented memory
        * Fix: use after free on metadata cache reallocation
        * Fix: version checks for kernel 4.0
        * Fix: Incorrect Ubuntu kernel patchlevel
        * Fix: cpu-id context should use int type
        * Implement cpu-id context
        * Implement cpu_id context for filtering
        * Fix: context printk mismatch on error
        * Cleanup: misleading comment about deferrable timer
        * Fix: arm-32 build
        * Fix: Update kmem event for Ubuntu's 3.16 kernel
        * Fix: RHEL 7.1 block instrumentation
        * Fix: add RHEL version macros
        * Fix: add missing parenthesis in ubuntu version check
        * Fix: remove regmap instrumentation for kernels < 4.1
        * Fix: Update kmem event for recent Ubuntu kernel
        * Fix: missing statedump end event when block device listing available
        * Fix: don't generate incorrect macros for debian/ubuntu version check
        * Revert "Fix: build against Ubuntu kernels"
        * Fix: build against Ubuntu kernels
        * Add namespace info in sched_fork and statedump
        * Fix: ext4 instrumentation: flags parameter did not exist prior to 3.11
        * Fix: printk instrumentation: remove "condition" tracepoints
        * Fix: regmap build against kernel 4.0 kernel headers
        * Add mmu_valid_gen field to mmutrace events
        * Fix: add missing x86 mmutrace kernel header include
        * Fix: x86 mmutrace event extra field for kernels >= 3.11
        * Fix: remove execute flag from kvm.h file
        * Fix: build x86 kvm probes on kernels >= 4.1-rc1
        * Fix: compilation on 4.1-rc1 kernel, remove unused WB_WORK_REASON
        * Fix: 4.1-rc1 Linux build and regmap instrumentation
        * Fix: don't clash with older Debian kernel versions
        * Fix: update get_pfnblock_flags_mask wrapper for debian kernels
        * Fix: discover Debian API
        * Fix: Update README.md to match reality: kernels >= 2.6.36 are supported
        * Fix: atomic.h wrapper for kernels < 2.6.37
        * Fix: disable x86 kvm instrumentation for kernels < 2.6.38
        * Fix: add missing types.h include for older kernels
        * Fix: add hlist lttng wrappers
        * Fix: add struct file_handle forward declaration
        * Fix: string length calculation reversed user vs kernel args
        * Fix: use lttng_rcu_dereference within lttng-syscalls.c
        * Fix: add lttng rcu wrapper to allow tracing RCU
        * Fix: double-unlock of session mutex
        * Fix: check that class and instance prototype match
        * Fix: lttng-events.h check function takes void
        * Fix: regmap instrumentation for Linux 3.19.4 and 4.0
        * Fix: kernels >= 2.6.33 put utsrelease.h in generated/
        * Fix: Include utsrelease.h in lttng-kernel-version.h
        * Fix: ext4 ext4_da_write_pages instrumentation for kernels < 3.11.0
        * Fix: old kernels need module.h included before vermagic.h
        * Fix: net instrumentation for kernels 2.6.39 and below
        * Fix: version condition in makefile
        * Implement wrapper around get_pfnblock_flags_mask
        * Be more restrictive in provider name check
        * Fix: net instrumentation namespacing
        * Fix: compaction instrumentation namespacing
        * Fix: Support 4.x kernel versions in Makefile
        * Fix: remove stale TP_STRUCT_entry from kvm instrumentation
        * Fix: add missing module.h include to lttng-probe-user.c
        * Fix: use lttng hlist wrapper in wildcard and filter
        * Fix: namespace asoc and kmem instrumentation
        * Fix: update instrumentation after wildcard rebase
        * Fix: lttng_abi_syscall_list does not need to be exported
        * Migrate ARM, powerpc, MIPS syscall instrumentation to TP_FIELDS
        * Remove now unused syscalls.h from lttng-modules
        * Filter: start with enabler "disabled"
        * Fix coverity warning about sizeof(void **) != sizeof(void *)
        * Fix length type and text sequence base
        * Fix: TP_FIELDS: add missing headers
        * Migrate syscall instrumentation to TP_FIELDS
        * Migrate tracepoint instrumentation to TP_FIELDS
        * Implement filtering infrastructure
        * syscall wildcards: apply syscall filtering
        * Implement syscall wildcard support
        * Implement tracepoint wildcard support
        * Namespace all tracepoints
        * Implement list.h wrapper for hlist in older kernels
        * Implement listing of pid tracker content
        * Implement PID tracking
        * Fix: mm_page_alloc_extfrag instrumentation for kernel 3.14.36
        * Fix: update writeback instrumentation for kernel 4.0+
        * Fix: compaction mm_compaction_isolate_template update for Linux 4.0+
        * Fix: kmem instrumentation update for mm_page_alloc_extfrag kernel 3.19.2+
        * Fix: kmem instrumentation: mm_page_alloc extfrag change_ownership field
        * Fix: missing parenthesis in offset_align_floor
        * Fix: implement time.h wrapper for FD_ISSET
        * Fix: update sched instrumentation for 3.19+ kernels
        * Fix: update rcu instrumentation for 3.19+ kernels
        * Fix: update scsi instrumentation for 3.19+ kernels
        * Fix: update module instrumentation for 3.19+ kernels
        * Fix: Add f_dentry wrapper for 3.19+ kernels
        * Fix: introduce lttng_get_unused_fd() wrapper for 3.19 kernels
        * Fix: lttng_this_cpu_ptr wrapper for kernel 3.19+
        * Fix: Update btrfs instrumentation for 3.18 Linux kernel
        * Fix compile error on kernel 3.0.101 with CONFIG_PERF_EVENTS
        * Conditional compilation introduced by lttng-modules commit
        * Fix: compaction instrumentation update for 3.14.x stable kernels
        * Fix: context alignment not properly handled
        * Fix compilation on Linux kernel >= 3.18.0
        * Fix: build for architectures without HAVE_SYSCALL_TRACEPOINTS

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
