From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.2.0-rc1
Date: Fri, 29 Mar 2013 22:41:44 -0400
Message-ID: <20130330024144.GA20642__47118.3238122196$1364611365$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1ULljm-0000Mc-8i
	for lttng-dev@lists.lttng.org; Fri, 29 Mar 2013 22:41:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id EF8A51410AC
	for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2013 22:41:45 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id XvzgjwFAxeYx for <lttng-dev@lists.lttng.org>;
	Fri, 29 Mar 2013 22:41:44 -0400 (EDT)
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.2 tracer toolset.

Noteworthy changes:
- Many new subsystems are instrumented. Thanks to Mentor Graphics for
  the patches.

Changelog:
2013-03-29 LTTng modules 2.2.0-rc1
        * Update README
        * Fix: vmscan instrumentation build
        * writeback instrumentation: remove duplicated structures
        * block: update instrumentation to 3.9 rc kernel
        * rcu: update to 3.9 rc kernel instrumentation
        * workqueue instrumentation: remove duplicated structures
        * Rename odd event names
        * Introduce API to remap event names exposed by LTTng
        * lttng-module: sched.h: Fix compilation on 3.9 kernel
        * Fix Linux 3.8 btrfs probe warning
        * Fix Linux 3.8 ext4 probe support
        * Fix 3.8 kernel support: namespace lttng_is_signed_type()
        * Fix: don't flush-final for offset 0 if reader is on sub-buffer
        * instrumentation sched: add missing fork pid info
        * Fix check in lttng_strlen_user_inatomic
        * instrumentation: sync with Linux commit a1ce392
        * Fix: statedump: missing locking, use lttng_iterate_fd
        * Implement lttng_iterate_fd wrapper
        * Instrumentation cleanup: kmem events should print hex pointers
        * Fix compilation of ext4 and btrfs tracepoints on 2.6.40 kernels
        * Fix: statedump hang/too early completion due to logic error
        * Fix: statedump hang due to incorrect wait/wakeup use
        * put_ulong calls in lib_ring_buffer_compat_ioctl() should be compat
        * wrapper/perf.h: Fix kernel version condition
        * Add new kernel probes instrumentation
        * Update kernel probes to more detailed match to kernel versions
        * Fix possible kernel build errors with linux-patches
        * Add missing MIT license text to 3 files under this license
        * Update sites using kernel version checking macro to new range
        * Make upper bound of kernel version checking macro exclusive
        * sock instrumentation: fix fields to get referenced values
        * ext3 instrumentation: fix of assignment code conversion
        * sched instrumentation: rename "pid" fields in sched_process_exec
        * Remove remaining semicolons in TP_fast_assign blocks
        * Fix compilation for 3.0 kernels that are named 2.6.40
        * Fix compilation for 3.0 branch (>= 3.0.39)
        * Add kernel version checking macro
        * Remove semicolons in TP_fast_assign blocks
        * Add ifdefs to net probe to support Linux 2.6.39
        * Add kernel probes for supplementary subsystems
        * Check if interrupt action name is not null in statedump
        * Fix exec instrumentation: only for kernels 3.4.0 and higher
        * Add TRACE_EVENT(sched_process_exec) to sched.h
        * lib/ringbuffer/frontend_api.h: Include linux/prefetch.h.
        * Fix warning with 3.6.0 kernel
        * ABI with support for compat 32/64 bits
        * Perform calculation on bit size in 64-bit
        * Use uint64_t for packet header content size and packet size
        * Fix: compat layer only on supported architectures
        * Fix ring buffer 32/64 bits compat
        * Fix cleanup: move lttng-tracer-core.h include to lib ringbuffer config.h
        * Fix ring_buffer_frontend.c: missing include lttng-tracer-core.h
        * Fix: statedump missing check for NULL namespace


Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
