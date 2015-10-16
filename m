From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-dev] [RELEASE] Userspace RCU 0.9.0
Date: Fri, 16 Oct 2015 22:39:47 +0000 (UTC)
Message-ID: <1057263096.63985.1445035187857.JavaMail.zimbra@efficios.com>
References: <1624728994.63313.1445025500226.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1624728994.63313.1445025500226.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lttng-dev <lttng-dev@lists.lttng.org>, rp@svcs.cs.pdx.edu
Cc: Stephen Hemminger <shemminger@vyatta.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alan Stern <stern@rowland.harvard.edu>, Lai Jiangshan <laijs@cn.fujitsu.com>
List-Id: lttng-dev@lists.lttng.org

----- On Oct 16, 2015, at 3:58 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Hi,
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

I had to do a quick 0.9.1 release to add missing test files to
the makefile so they would be included in the distribution
tarballs. This ensures make regtest, make short_bench and
make long_bench all work fine when run on a tree extracted
from a distribution tarball.

Thanks,

Mathieu

> New and Noteworthy
> 
> Two years after the 0.8.0 release, it's about time we release
> Userspace RCU 0.9.0 with some interesting new features:
> 
> * liburcu.so and liburcu-bp.so now use the membarrier system call
>  to speed up RCU read-side critical sections when available. It
>  is newly introduced in Linux 4.3. See kernel/membarrier.c in a
>  recent Linux kernel tree for details.
> * Port Userspace RCU to Android,
> * Port Userspace RCU to Solaris 10 and 11,
> * Refactoring of tests into the following make targets:
>  # Short sanity check
>  make check
>  # Few minutes regression testing
>  make regtest
>  # Few tens of minutes benchmarks
>  make short_bench
>  # Hours-long benchmarks
>  make long_bench
> * Tests now output in "tap", for easier integration in continuous
>  integration. See https://ci.lttng.org/job/liburcu/ for the
>  Userspace RCU CI job.
> - Port to aarch64 and powerpc64le architectures,
> - Port to hppa/PA-RISC architecture,
> 
> Note: the soname major has been bumped to 4 even though it really
> only needed to be bumped to 3.
> 
> Changelog:
> 2015-10-16 Userspace RCU 0.9.0
>        * Bump soname major to 4
>        * Cleanup: remove trailing tab
>        * Fix: Use proper macro to detect stdbool.h
>        * Configure: Add missing checks
>        * Port: Add Solaris build instructions
>        * Fix: regtest outputs valid TAP protocol
>        * Port: Detect nproc bin name in benchmark scripts
>        * Port: Add Solaris getcpu support
>        * Port: Fixes to build system for portability
>        * Port: Add Solaris support to tests/common/thread-id.h
>        * Port: Add Solaris support to urcu/syscall-compat.h
>        * Port: replace bzero() by memset()
>        * Port: make bootstrap script work on most shell
>        * tests: rcutorture: use parameters rather than random
>        * Fix: only define membarrier system call on Linux
>        * Refactor tests
>        * Fix: cast caa_cycles_t to unsigned long long
>        * caa_get_cycles: caa_ prefix for type, use CLOCK_MONOTONIC
>        * Cleanup: remove trailing whitespaces at EOL
>        * Cleanup: move generic caa_get_cycles to arch/generic.h
>        * tile: allocate membarrier system call number
>        * ia64: allocate membarrier system call number
>        * aarch64: allocate membarrier system call number
>        * powerpc64le: use "ppc" architecture
>        * arm: allocate membarrier system call number
>        * s390: allocate membarrier system call number
>        * ppc: allocate membarrier system call number
>        * lfstack: relax constraints on node re-use
>        * Fix: format string signedness
>        * Cleanup: tests: Branch condition evaluates to a garbage value
>        * Fix: test: unchecked return value
>        * Fix: test: side-effect in assertion
>        * x86: allocate membarrier system call number
>        * urcu-bp: use sys_membarrier when available
>        * Cleanup: urcu: remove unused membarrier "group" parameter
>        * urcu/ref.h: implement urcu_ref_get_unless_zero()
>        * Fix: compat_futex: uninitialized ret variable
>        * Fix: compat_futex_noasync: don't override return value
>        * Fix: dynamic fallback to compat futex on sys_futex ENOSYS
>        * Detect RCU read-side overflows
>        * Detect RCU read-side underflows
>        * Introduce urcu_assert and registration check
>        * Fix: volatile in assert()
>        * Update following changes to sys_membarrier ABI
>        * uatomic: Specify complete types for atomic function calls
>        * Cleanup: remove unused return value warning from tests
>        * Fix: handle sys_futex() FUTEX_WAIT interrupted by signal
>        * Fix: compat_futex.c: *uaddr should be read as volatile
>        * Cleanup: cast poll delay return value to void
>        * tests: Convert unit tests to TAP
>        * Fix: make benchmark test run in oot build
>        * Fix: call_rcu_thread() affinity failure
>        * Cleanup: cast poll delay return value to void
>        * Cleanup: cast poll delay return value to void
>        * Cleanup: cast poll delay return value to void
>        * Cleanup: cast poll delay return value to void
>        * Cleanup: cast poll() return value to void for delays
>        * urcu: fix deprecation warning with new glibc
>        * urcu: add cds_list_for_each_entry_safe_from macro
>        * Fix: deadlock when thread join is issued in read-side C.S.
>        * Fix: rename RCU_DEBUG to DEBUG_RCU in urcu-qsbr.h
>        * Cleanup some c99 pedantic warnings
>        * Mark braced-groups within expressions with __extension__
>        * Fix: compat_futex_noasync race condition
>        * tests: Use stderr redirection for time output
>        * Fix: use space after rpath for OS X ld
>        * Fix: move transparent union attribute after union declaration for clang
>        * Configure: add check for used type
>        * Configure: add missing check of headers
>        * Configure: add missing check for funcs: memset, strerror
>        * Fix: documentation: urcu-pointer.h: s/rcu_dereference_pointer/rcu_dereference/
>        * urcu-bp/urcu-qsbr: remove unneeded DEBUG_YIELD code
>        * Fix: call rcu should call internal RCU API
>        * Fix: silence gcc -Wextra warning
>        * compiler: use __GNUC__ instead of the undefined __GNUC_MAJOR__
>        * Fix: lfstack reversed empty/non-empty return value
>        * lfstack: fix: add missing __cds_lfs_init
>        * wfstack: add missing union parameters
>        * Fix: preserve example files' timestamps when copying
>        * wfstack: implement mutex-free wfstack with transparent union
>        * wfcqueue: Implement mutex-free wfcqueue head with transparent union
>        * lfstack: Implement mutex-free stack head with transparent union (v2)
>        * rculfhash: remove duplicated code
>        * rculfhash: handle pthread_create failures
>        * rculfhash: fall back to single-threaded resize on calloc failure
>        * x86: drop extra semi-colon in caa_cpu_relax
>        * Cleanup: tests: cast console write return value as void
>        * Modernize doc using Markdown
>        * Fix: update automake following README to README.md change
>        * Modernize README using Markdown
>        * Fix: incorrect parenthesis in cds_hlist_for_each_entry_safe_2
>        * Fix: Use after free in rcu_barrier()
>        * Fix: rcu_barrier(): uninitialized futex field
>        * call_rcu threads should clear their PAUSED flag when they unpause
>        * test_urcu_fork: test many fork, with 3 children deep
>        * Update list of supported architectures in README
>        * Add support for hppa/PA-RISC architecture
>        * Use autoconf AM_MAINTAINER_MODE
>        * Use gcc atomics on aarch64/powerpc64le
>        * Fix: move wait loop increment before first conditional block
>        * Fix: high cpu usage in synchronize_rcu with long RCU read-side C.S.
>        * Fix: out of tree build: doc/examples
>        * Fix: out of tree build tests/common
>        * tests/unit: use lib rather than source
>        * automake: Rename INCLUDES to AM_CPPFLAGS (new name)
>        * tests regressions: use lib rather than recompile from source
>        * tests: use common lib rather than recompile compat sources
>        * urcu tests: use lib rather than compile from source
>        * urcu mb tests: use lib rather than recompile from source
>        * urcu signal tests: use library rather than recompile source
>        * tests: move yield debug to common test library
>        * tests urcu bp: use lib rather than recompile source
>        * test_urcu_defer: link on urcu lib rather than recompile source
>        * tests/benchmark: use urcu qsbr lib rather than recompile from source
>        * Pass the CC variable to the example Makefiles
>        * Fix: urcu-bp interaction with threads vs constructors/destructors
>        * x86 barrier for Xeon Phi: use rsp on x86-64
>        * Set RCU_HAVE_FENCE to false on Intel Xeon Phi
>        * Fix undefined NULL pointer arithmetic in hlist
>        * Cleanup: Check for pthread in Libc
>        * Cleanup: Android: Do not redefine gettid
>        * Fix undefined NULL pointer arithmetic
>        * Android: implement rand_r()
>        * Android: do not redefine gettid on Android
>        * Android: add a compat layer for 'syscall.h'
>        * Android: do not link pthread on Android
>        * Android: configure.ac Android check
>        * Blacklist ARM gcc 4.8.0, 4.8.1, 4.8.2
>        * rculfhash: document max_nr_buckets = 0
>        * Library major version number (soname) increment to 3
>        * Fix: tls-compat multi-lib conflict
>        * Use cross compiler for doc examples
>        * Add lttng-dev mailing list to readme
>        * wfcqueue: remove misleading comment
>        * gcc warning fixes: -Wsign-compare and -Wextra
>        * Fix: urcu-qsbr: reversed logic on RCU_DEBUG
>        * Fix: urcu-bp segfault in glibc pthread_kill()
>        * Fix urcu-bp: don't move registry
>        * Fix: compat futex duplicated lock and completion
>        * Fix: i386 compat code duplicated mutex instances
>        * Fix: urcu-bp: Bulletproof RCU arena resize bug
>        * Fix: test_mutex.c uninitialized mutex
> 
> Project website: http://liburcu.org
> Git repository: git://git.liburcu.org/urcu.git
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
