From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.11
Date: Mon, 6 May 2019 16:32:54 -0400 (EDT)
Message-ID: <990796059.510.1557174774246.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Stephen Hemminger <stephen@networkplumber.org>, Alan Stern <stern@rowland.harvard.edu>, Lai Jiangshan <jiangshanlai@gmail.com>
List-Id: lttng-dev@lists.lttng.org

Hi,

This is a 0.11 release of the Userspace RCU project.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

Here is the high-level view of the changes introduced in this release:

* Allow combining many urcu flavors within the same
  compile unit. Prefix public APIs with urcu_<flavor>_ prefix. Keep old
  symbols as aliases for backward compatibility.

* liburcu flavors public headers are moved, including them from previous
  headers for backward compatibility:

  urcu-bp.h -> urcu/urcu-bp.h
  urcu-qsbr.h -> urcu/urcu-qsbr.h
  urcu.h -> urcu/urcu-memb.h
  urcu.h (after #define RCU_MEMBARRIER) -> urcu/urcu-memb.h
  urcu.h (after #define RCU_MB) -> urcu/urcu-mb.h
  urcu.h (after #define RCU_SIGNAL) -> urcu/urcu-mb.h

* The library liburcu is renamed to liburcu-memb, keeping the old
  library name as alias for backward compatibility.

* RCU lock-free hash table debugging:

  --enable-cds-lfht-iter-debug is introduced.

  Building liburcu with --enable-cds-lfht-iter-debug and rebuilding
  application to match the ABI change allows finding cases where the hash
  table iterator is re-purposed to be used on a different hash table
  while still being used to iterate on a hash table.

  This option alters the rculfhash ABI. Make sure to compile both library
  and application with matching configuration.

* Added support for RISC-V architecture.

* Use membarrier PRIVATE_EXPEDITED when available from liburcu-bp and
  liburcu-memb flavors.

The backward compatibility header files, library shared objects, and
symbols will be kept for a few liburcu versions before being removed, at
which point a major soname bump will happen.

As always, feedback is welcome!

Thanks,

Mathieu

Changelog:

2019-05-06 Userspace RCU 0.11.0
        * Bump library version to 6:0:1
        * Cleanup: update code layout to fix old gcc warning
        * Fix: typo CPPLAGS in examples Makefile
        * Harmonize pprint macro across projects
        * Check for TLS support after CC detection
        * Update macros from the autotools archive
        * tap-driver.sh: flush stdout after each test result
        * Update dead link in lgpl-relicensing.txt
        * Add multiflavor compat identifiers
        * Cleanup: missing sign compare fixes
        * Cleanup: enable signed/unsigned compare compiler warning
        * Cleanup: compiler warning on 32-bit architectures
        * config.h.in: rename CONFIG_RCU_MULTIFLAVOR to CONFIG_RCU_HAVE_MULTIFLAVOR
        * rculfhash: implement iterator debugging config option
        * Fix: examples silent rules on Solaris
        * Add missing fall through annotations
        * Fix: symbol aliases with TLS compat
        * Port: no symbols aliases on MacOS
        * Add -Wextra to CFLAGS
        * Add silent mode to examples Makefiles
        * doc: update examples to API changes
        * test multiflavor single compile unit
        * Update README following API changes
        * Use new header locations for includes from urcu code
        * Update call-rcu.h and defer.h comments and include guards
        * rculfqueue.h: do not include urcu-call-rcu.h
        * rculfhash: support use with multiple flavors per compile unit
        * rculfhash: do not include urcu-call-rcu.h from public API
        * Refactor liburcu to support many flavors per compile unit
        * Fix: only wait if work queue is empty in real-time mode
        * Fix: don't wait after completion of a work queue job batch
        * Fix: don't wait after completion of job batch if work queue is empty
        * Fix: workqueue: struct urcu_work vs rcu_head mixup
        * Cleanup: workqueue: update comments referring to call-rcu
        * Fix: mixup between URCU_WORKQUEUE_RT and URCU_CALL_RCU_RT
        * test_rwlock: Add per-thread count to verbose output
        * Add *.exe to gitignore for Cygwin
        * Fix: pthread_rwlock initialization on Cygwin
        * Fix: compat_futex_noasync on Cygwin
        * wfcqueue: allow defining CDS_WFCQ_WAIT_SLEEP to override `poll'
        * Update documentation for call_rcu before/after fork
        * Add support for the RISC-V architecture
        * Tests: Add tap-driver.sh for automake < 1.12
        * Tests: Replace prove by autotools tap runner
        * liburcu-bp: Use membarrier private expedited when available
        * liburcu: Use membarrier private expedited when available
        * rculfhash: improve error handling of mmap backend
        * Fix: don't use overlapping mmap mappings on Cygwin
        * Tests fix: errors in shell scripts
        * Revert "Use initial-exec tls model"
        * Use initial-exec tls model
        * Fix: don't use membarrier SHARED syscall command in liburcu-bp
        * Tests fix: add missing Cygwin thread id
        * Fix: assignment from incompatible pointer type warnings
        * Tests fix: unused variable warnings
        * Fix: add missing m68k headers to dist
        * Bump version to 0.11-pre


Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
