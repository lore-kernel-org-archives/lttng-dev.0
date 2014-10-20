From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.6.0-rc1
Date: Mon, 20 Oct 2014 23:14:40 +0000 (UTC)
Message-ID: <103016753.12516.1413846880063.JavaMail.zimbra__26397.9107993238$1413846927$gmane$org@efficios.com>
References: <437507841.12503.1413846502807.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XgMAA-0007Gs-TG
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 19:14:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E5FF5340351
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 23:14:50 +0000 (UTC)
In-Reply-To: <437507841.12503.1413846502807.JavaMail.zimbra@efficios.com>
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

New & noteworthy features in this release:
- System call filtering! Fine-tune which system calls you want
  to trace or not,
- We now gather in/out parameters of system calls at entry and
  exit of the syscall. Please note that the system call event
  semantic (naming) have changed in this release. You may have
  to update your analysis if they depended on the old semantic.
- Trace NMI handlers, using the new NMI-safe clock monotonic
  available in kernels >= 3.17,

Please note that the feature "syscall listing" will need lttng-tools
2.6.0-rc2 (which should come soon). We had to fix an ioctl numbering
clash at the last minute between the tools rc1 and modules rc1
releases.

Changelog:
2014-10-20 LTTng modules 2.6.0-rc1
        * Expose lttng-modules ABI version ioctl
        * Fix: syscall list ioctl number conflict
        * lttng-modules: fix build for non-x86
        * Fix: syscall listing of session
        * Print build warning when writeback probe is disabled
        * Add atomic.h wrapper for before/after atomic
        * Fix compilation on Ubuntu 14.10
        * Fix: export name as text array in writeback
        * Cleanup: remove unused trace_clock_read32()
        * Use 3.17 ktime_get_mono_fast_ns() new API
        * Check for stale version.h files
        * Fix: compile lttng_statedump_process_ns on Ubuntu
        * Reverse version check logic in lttng_statedump_process_ns
        * Fix block_rq_complete TP on Ubuntu kernel
        * Introduce macros to check Ubuntu kernel version
        * Sync writeback tracepoints from mainline
        * Fix: redefinition of DEFINE_WRITEBACK_EVENT
        * Fix: hander negative get_syscall_nr return value
        * Fix: statedump: close_on_exec flag backward compat
        * Fix instrumentation of vmscan for older kernels
        * Fix: older kernels (3.2.x) don't undefine TRACE_SYSTEM
        * Fix: syscall listing: handle "enable all syscall"
        * Fix: don't allow disabling syscalls when none are enabled
        * Fix: syscall: fail disable all if all already disabled
        * Fix: syscall filtering: NULL pointer deref
        * Cleanup: list syscall without syscall_entry prefix
        * Fix: syscall_list_show NULL pointer deref
        * implement syscall mask getter
        * Cleanup: lttng-abi.h coding style
        * syscall listing: show syscall ID
        * Allow events with same name to be enabled for each channel
        * ABI: use enable a syscall ABI field name
        * Implement syscall listing
        * Fix: tracepoint list anonymous file name
        * Fix: syscall filtering: disable all syscalls
        * syscall tracing: input/output parameter handling for all arch
        * lttng-get-syscall-inout.sh depends on bash
        * Fix generate syscall header script: add missing escape char
        * syscall instrumentation: handle copy_from_user return value
        * Rename LTTng syscall instrumentation macros
        * Rename LTTng instrumentation macros
        * Extract input/output arguments from accept and connect syscalls
        * syscall: extract pipe and pipe2 output args
        * Remove sys_ prefix from syscall names
        * System call inout/output arg processing
        * Update syscall inout table
        * Add syscall inout table
        * Extract syscall exit ret value on x86 32/64
        * Extract system call exit return value
        * Syscall filtering: apply to syscall exit
        * System call filtering
        * asoc.h: fix build with v3.17 kernel
        * Fix: lttng-modules teardown NULL pointer OOPS
        * Fix: handle concurrent flush vs get_next_subbuf on metadata cache
        * Modernize README using Markdown
        * Fix: OOT lttng_logger tracepoint not visible with signed kernels
        * Add cscope to gitignore
        * Update kvm instrumentation: compile on 3.17-rc1
        * Update statedump to 3.17 nsproxy locking
        * Fix: noargs probes should calculate alignment and event length
        * Update compaction instrumentation to 3.16 kernel
        * Update vmscan instrumentation to 3.16 kernel

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README.md files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
