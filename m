From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.10.0, 0.9.4, 0.8.10 (EOL)
Date: Tue, 13 Jun 2017 00:16:12 +0000 (UTC)
Message-ID: <2029481774.11452.1497312972611.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu, lwn <lwn@lwn.net>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Stephen Hemminger <stephen@networkplumber.org>, Alan Stern <stern@rowland.harvard.edu>, Lai Jiangshan <jiangshanlai@gmail.com>
List-Id: lttng-dev@lists.lttng.org

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

Version 0.10.0 of liburcu introduces mainly the following changes
over version 0.9.x:

- Introduce a urcu_ref_get_safe API, which can return a failure in
  case of reference count overflow,

- Remove RCU caller context restrictions on RCU lock-free hash table
  cds_lfht_destroy API:

    Up to and including liburcu 0.9.x, the RCU lock-free hash table
    required that the destroy function should not be called from
    within RCU read-side critical sections. This is caused by the lazy
    resize, which uses the call_rcu worker thread, even though all it
    really needs is a workqueue/worker thread scheme.
    
    Use the new internal workqueue API instead of call_rcu in rculfhash to
    remove this restriction starting from liburcu 0.10.x.

- Allow forcing the use of the sys_membarrier() system call:

    When using the default (liburcu.so) and bulletproof (liburcu-bp.so)
    flavours of Userspace RCU, kernel support for sys-membarrier is detected
    dynamically and stored in the rcu_has_sys_membarrier_memb and
    urcu_bp_has_sys_membarrier global variables.
    
    Checking the value of these variables adds a small but measurable overhead
    to smp_mb_slave. On systems which support sys-membarrier, it would be
    nice to have a way of avoiding that overhead.
    
    Here is the proposed approach: if CONFIG_RCU_FORCE_SYS_MEMBARRIER is
    defined then rcu_has_sys_membarrier_memb/urcu_bp_has_sys_membarrier are
    replaced with the constant 1, eliminating the overhead in smp_mb_slave.
    As a sanity check, support for sys-membarrier is still detected at
    startup. A program using liburcu or liburcu-bp compiled with this option
    aborts in the library constructor if the membarrier system call is not
    supported by the operating system.

- Introduce support for NIOS2 and m68k architectures,

- ARM32: use lighter-weight dmb ish (inner shareable domain) for smp barrier,

- Introduce a --enable-rcu-debug configure option, which builds internal
  RCU consistency checks into the library,


Versions 0.9.4 and 0.8.10 introduce an important fix for ARM32: a missing
release barrier was added before uatomic_xchg(). They introduce other minor
fixes.

liburcu 0.8.10 will be the last release of the stable-0.8 series.
liburcu stable-0.8 branch has now reached end of life with the release of
liburcu 0.10.0. Users of liburcu 0.8.x should upgrade to 0.10.x or 0.9.x.

Enjoy!

Mathieu

Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

Changelog:

2017-06-12 Userspace RCU 0.10.0
        * Bump library soname due to urcu flavor structure change
        * Cleanup: use mutex_lock() wrapper in rculfhash
        * Use workqueue in rculfhash
        * Implement urcu workqueues internal API
        * Add support for m68k architecture
        * Set -Wall globally in AM_CFLAGS
        * Fix: remove double use of PTHREAD_CFLAGS
        * Re-add PTHREAD_CFLAGS to global CFLAGS
        * Fix: Don't override user variables within the build system
        * Add report at the end of configure
        * uatomic-api docs: use the third-person singular
        * Add --enable-rcu-debug to configure
        * ARM32: use dmb ish (inner shareable domain) for smp barriers
        * Cleanup: remove cmm_wmb() from rcu_xchg_pointer and rcu_cmpxchg_pointer
        * Fix: uatomic arm32: add missing release barrier before uatomic_xchg
        * Tests: Add verbose support to test script
        * Fix: add missing CONFIG_RCU_FORCE_SYS_MEMBARRIER to urcu/config.h.in
        * Allow forcing the use of sys membarrier
        * Fix: rcutorture: work-around signal issue on mac os x
        * Fix: rcutorture should register thread using call_rcu
        * Fix: add missing backslash in Makefile.am
        * Fix: Do not use wildcards in include/Makefile.am
        * Bump version to 0.10-pre
        * Fix: check for rand_r() in compat-rand.h
        * Fix: Move rand-compat to private src dir
        * Fix: remove AC_FUNC_MALLOC from configure.ac
        * Cleanup: Re-organise source dir
        * Cleanup: remove leftover manual pthread detection
        * Fix: update ax_pthread macro to handle newer clang
        * Update library current version due to adding destroy API
        * Fix: Use pthread_self to get threadid on OSX
        * Fix: examples: use destroy API for queues/stacks
        * Update library age due to new stack/queue destroy API
        * Fix: tests: invoke destroy APIs for queues/stacks
        * Fix: add missing destroy functions to queues/stack APIs
        * Fix: add missing __cds_wfcq_init for LGPL API
        * Fix: memory leak on hash table destroy
        * Fix: Add failover for platforms without nproc
        * Fix: use clock_get_time for caa_get_cycles fallback on MacOSX
        * Fix: syscall-compat.h MacOSX support
        * Fix: Add solaris-build.md to dist
        * rculfhash: Documentation: clarify need for grace period before "re-using"
        * Port: build shared libraries in Cygwin
        * Port: fix compatibility header for Cygwin
        * Add GNU Hurd support to syscall-compat.h
        * Add support for aarch64_be
        * Fix: urcu-bp: re-initialize list head on library exit
        * bootstrap: Standardize on autoreconf -vi
        * Harmonize bootstrap script across projects
        * Fix: examples make distcheck failure
        * wfcqueue: add C++ compatibility API
        * Fix: CDS_WFCQ_WOULDBLOCK typing for c++
        * Fix: configure.ac: check for possibly required libs for clock_gettime
        * Support for NIOS2 architecture
        * urcu_ref_get_safe: introduce new API
        * Fix: handle reference count overflow
        * Fix: compat_futex should work-around futex signal-restart kernel bug
        * Support for Xeon-Phi with newer MPSS
        * sparc64: allocate membarrier system call number
        * hppa: allocate membarrier system call number
        * Fix build on non-Linux Debian ports
        * Fix: urcu-signal: smp_mb_master() needs registry lock
        * Fix: rculfhash only needs to include urcu-pointers.h
        * Fix: out-of-tree benchmark/regtest
        * Fix: add missing regtest and benchmark files to dist tarball
        * Fix: add missing run.sh to benchmark makefile

2017-06-12 Userspace RCU 0.9.4
        * Fix: Don't override user variables within the build system
        * Fix: uatomic arm32: add missing release barrier before uatomic_xchg
        * Tests: Add verbose support to test script

2017-12-06 Userspace RCU 0.8.10 (End of Life)
        * Fix: Don't override user variables within the build system
        * Fix: uatomic arm32: add missing release barrier before uatomic_xchg
        * Fix: rcutorture: work-around signal issue on mac os x
        * Fix: rcutorture should register thread using call_rcu
        * Fix: remove AC_FUNC_MALLOC from configure.ac
        * Update library current version due to adding destroy API
        * Fix: Use pthread_self to get threadid on OSX
        * Fix: examples: use destroy API for queues/stacks
        * Update library age due to new stack/queue destroy API
        * Fix: tests: invoke destroy APIs for queues/stacks
        * Fix: add missing destroy functions to queues/stack APIs
        * Fix: memory leak on hash table destroy
        * Fix: urcu-bp: re-initialize list head on library exit
        * Fix: examples make distcheck failure
        * Cleanup: remove unused return value warning from tests

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
