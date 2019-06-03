From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RELEASE] Userspace RCU 0.11
Date: Mon, 3 Jun 2019 17:32:40 -0400 (EDT)
Message-ID: <1807476901.26032.1559597560952.JavaMail.zimbra__7557.6691235014$1559597581$gmane$org@efficios.com>
References: <990796059.510.1557174774246.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45HpDr31Hzz10gw
 for <lttng-dev@lists.lttng.org>; Mon,  3 Jun 2019 17:32:43 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 522E11E9744
 for <lttng-dev@lists.lttng.org>; Mon,  3 Jun 2019 17:32:42 -0400 (EDT)
In-Reply-To: <990796059.510.1557174774246.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: linux-kernel <linux-kernel@vger.kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>, rp <rp@svcs.cs.pdx.edu>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Alan Stern <stern@rowland.harvard.edu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <jiangshanlai@gmail.com>
List-Id: lttng-dev@lists.lttng.org

----- On May 6, 2019, at 4:32 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Hi,
> 
> This is a 0.11 release of the Userspace RCU project.

FYI, I just released a 0.11.1 tag of Userspace RCU which does a
mandatory soname bump. Distributions wishing to package it should
grab 0.11.1. The prior release 0.11.0 changed the soname from 6.0.0 down
to 5.1.0, which was not intended. This release bumps it to 6.1.0 as
originally intended.

Changes:

2019-06-03 Userspace RCU 0.11.1
        * Fix: SONAME bump to 6.1.0
        * Fix: urcu/futex.h: users of struct timespec should include time.h

Thanks,

Mathieu


> 
> liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
> data synchronization library provides read-side access which scales
> linearly with the number of cores. It does so by allowing multiple
> copies of a given data structure to live at the same time, and by
> monitoring the data structure accesses to detect grace periods after
> which memory reclamation is possible.
> 
> liburcu-cds provides efficient data structures based on RCU and
> lock-free algorithms. Those structures include hash tables, queues,
> stacks, and doubly-linked lists.
> 
> Here is the high-level view of the changes introduced in this release:
> 
> * Allow combining many urcu flavors within the same
>  compile unit. Prefix public APIs with urcu_<flavor>_ prefix. Keep old
>  symbols as aliases for backward compatibility.
> 
> * liburcu flavors public headers are moved, including them from previous
>  headers for backward compatibility:
> 
>  urcu-bp.h -> urcu/urcu-bp.h
>  urcu-qsbr.h -> urcu/urcu-qsbr.h
>  urcu.h -> urcu/urcu-memb.h
>  urcu.h (after #define RCU_MEMBARRIER) -> urcu/urcu-memb.h
>  urcu.h (after #define RCU_MB) -> urcu/urcu-mb.h
>  urcu.h (after #define RCU_SIGNAL) -> urcu/urcu-mb.h
> 
> * The library liburcu is renamed to liburcu-memb, keeping the old
>  library name as alias for backward compatibility.
> 
> * RCU lock-free hash table debugging:
> 
>  --enable-cds-lfht-iter-debug is introduced.
> 
>  Building liburcu with --enable-cds-lfht-iter-debug and rebuilding
>  application to match the ABI change allows finding cases where the hash
>  table iterator is re-purposed to be used on a different hash table
>  while still being used to iterate on a hash table.
> 
>  This option alters the rculfhash ABI. Make sure to compile both library
>  and application with matching configuration.
> 
> * Added support for RISC-V architecture.
> 
> * Use membarrier PRIVATE_EXPEDITED when available from liburcu-bp and
>  liburcu-memb flavors.
> 
> The backward compatibility header files, library shared objects, and
> symbols will be kept for a few liburcu versions before being removed, at
> which point a major soname bump will happen.
> 
> As always, feedback is welcome!
> 
> Thanks,
> 
> Mathieu
> 
> Changelog:
> 
> 2019-05-06 Userspace RCU 0.11.0
>        * Bump library version to 6:0:1
>        * Cleanup: update code layout to fix old gcc warning
>        * Fix: typo CPPLAGS in examples Makefile
>        * Harmonize pprint macro across projects
>        * Check for TLS support after CC detection
>        * Update macros from the autotools archive
>        * tap-driver.sh: flush stdout after each test result
>        * Update dead link in lgpl-relicensing.txt
>        * Add multiflavor compat identifiers
>        * Cleanup: missing sign compare fixes
>        * Cleanup: enable signed/unsigned compare compiler warning
>        * Cleanup: compiler warning on 32-bit architectures
>        * config.h.in: rename CONFIG_RCU_MULTIFLAVOR to CONFIG_RCU_HAVE_MULTIFLAVOR
>        * rculfhash: implement iterator debugging config option
>        * Fix: examples silent rules on Solaris
>        * Add missing fall through annotations
>        * Fix: symbol aliases with TLS compat
>        * Port: no symbols aliases on MacOS
>        * Add -Wextra to CFLAGS
>        * Add silent mode to examples Makefiles
>        * doc: update examples to API changes
>        * test multiflavor single compile unit
>        * Update README following API changes
>        * Use new header locations for includes from urcu code
>        * Update call-rcu.h and defer.h comments and include guards
>        * rculfqueue.h: do not include urcu-call-rcu.h
>        * rculfhash: support use with multiple flavors per compile unit
>        * rculfhash: do not include urcu-call-rcu.h from public API
>        * Refactor liburcu to support many flavors per compile unit
>        * Fix: only wait if work queue is empty in real-time mode
>        * Fix: don't wait after completion of a work queue job batch
>        * Fix: don't wait after completion of job batch if work queue is empty
>        * Fix: workqueue: struct urcu_work vs rcu_head mixup
>        * Cleanup: workqueue: update comments referring to call-rcu
>        * Fix: mixup between URCU_WORKQUEUE_RT and URCU_CALL_RCU_RT
>        * test_rwlock: Add per-thread count to verbose output
>        * Add *.exe to gitignore for Cygwin
>        * Fix: pthread_rwlock initialization on Cygwin
>        * Fix: compat_futex_noasync on Cygwin
>        * wfcqueue: allow defining CDS_WFCQ_WAIT_SLEEP to override `poll'
>        * Update documentation for call_rcu before/after fork
>        * Add support for the RISC-V architecture
>        * Tests: Add tap-driver.sh for automake < 1.12
>        * Tests: Replace prove by autotools tap runner
>        * liburcu-bp: Use membarrier private expedited when available
>        * liburcu: Use membarrier private expedited when available
>        * rculfhash: improve error handling of mmap backend
>        * Fix: don't use overlapping mmap mappings on Cygwin
>        * Tests fix: errors in shell scripts
>        * Revert "Use initial-exec tls model"
>        * Use initial-exec tls model
>        * Fix: don't use membarrier SHARED syscall command in liburcu-bp
>        * Tests fix: add missing Cygwin thread id
>        * Fix: assignment from incompatible pointer type warnings
>        * Tests fix: unused variable warnings
>        * Fix: add missing m68k headers to dist
>        * Bump version to 0.11-pre
> 
> 
> Project website: http://liburcu.org
> Git repository: git://git.liburcu.org/urcu.git
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
