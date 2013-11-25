From: kumar s <skumar.m226@gmail.com>
Subject: Fwd:  liburcu error: Cannot find -lurcu
Date: Mon, 25 Nov 2013 12:11:09 +0530
Message-ID: <CAO_ArvrB-n-i=pDBuj=FdX3VnLyh=T7bUu45m-YOCZLGdFk+Ng__40688.9651240364$1385361745$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A58A5@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<CAO_Arvo3AHW3bqWtMJXb_YExCyvyCjqSaA-CfBJL=upPV+7jyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1607696644=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f54.google.com ([209.85.215.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1VkprC-0002Mj-18
	for lttng-dev@lists.lttng.org; Mon, 25 Nov 2013 01:41:24 -0500
Received: by mail-la0-f54.google.com with SMTP id hp15so738236lab.41
	for <lttng-dev@lists.lttng.org>; Sun, 24 Nov 2013 22:41:10 -0800 (PST)
In-Reply-To: <CAO_Arvo3AHW3bqWtMJXb_YExCyvyCjqSaA-CfBJL=upPV+7jyw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

--===============1607696644==
Content-Type: multipart/alternative; boundary=089e0158c7983798e804ebfaa6c1

--089e0158c7983798e804ebfaa6c1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ----------
From: kumar s <skumar.m226@gmail.com>
Date: Mon, Nov 25, 2013 at 12:10 PM
Subject: Re: [lttng-dev] liburcu error: Cannot find -lurcu
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>



Hi,

I tried test .so and app ,compiled with mips gcc . it worked fine without
throwing any errors.


configuring with static library works fine but shared lib throws this
error. I have attached the log below.

*Static Library build*

CC=3Dmips64-octeon-linux-gnu-gcc ./configure prefix=3D$(pwd)/urcu_install
--host=3Dmips64-octeon-linux-gnu --disable-shared
configure: WARNING: if you wanted to set the --build type, don't use --host=
.
    If a cross compiler is detected then cross compile mode will be used
checking build system type... i686-pc-linux-gnu
checking host system type... mips64-octeon-linux-gnu
checking target system type... mips64-octeon-linux-gnu
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for mips64-octeon-linux-gnu-strip... mips64-octeon-linux-gnu-strip
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for style of include used by make... GNU
checking for mips64-octeon-linux-gnu-gcc... mips64-octeon-linux-gnu-gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... yes
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether mips64-octeon-linux-gnu-gcc accepts -g... yes
checking for mips64-octeon-linux-gnu-gcc option to accept ISO C89... none
needed
checking dependency style of mips64-octeon-linux-gnu-gcc... gcc3
checking for thread local storage (TLS) class... __thread
checking for mips64-octeon-linux-gnu-gcc... (cached)
mips64-octeon-linux-gnu-gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether mips64-octeon-linux-gnu-gcc accepts -g... (cached) yes
checking for mips64-octeon-linux-gnu-gcc option to accept ISO C89...
(cached) none needed
checking dependency style of mips64-octeon-linux-gnu-gcc... (cached) gcc3
checking whether make sets $(MAKE)... (cached) yes
checking how to print strings... printf
checking for a sed that does not truncate output... /bin/sed
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for fgrep... /bin/grep -F
checking for ld used by mips64-octeon-linux-gnu-gcc...
/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/too=
ls-gcc-4.3/mips64-octeon-linux-gnu/bin/ld
checking if the linker
(/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/to=
ols-gcc-4.3/mips64-octeon-linux-gnu/bin/ld)
is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)...
/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/too=
ls/bin/mips64-octeon-linux-gnu-nm
-B
checking the name lister
(/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/to=
ols/bin/mips64-octeon-linux-gnu-nm
-B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+=3D"... yes
checking how to convert i686-pc-linux-gnu file names to
mips64-octeon-linux-gnu format... func_convert_file_noop
checking how to convert i686-pc-linux-gnu file names to toolchain format...
func_convert_file_noop
checking for
/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/too=
ls-gcc-4.3/mips64-octeon-linux-gnu/bin/ld
option to reload object files... -r
checking for mips64-octeon-linux-gnu-objdump...
mips64-octeon-linux-gnu-objdump
checking how to recognize dependent libraries... pass_all
checking for mips64-octeon-linux-gnu-dlltool... no
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for mips64-octeon-linux-gnu-ar... mips64-octeon-linux-gnu-ar
checking for archiver @FILE support... @
checking for mips64-octeon-linux-gnu-strip... (cached)
mips64-octeon-linux-gnu-strip
checking for mips64-octeon-linux-gnu-ranlib...
mips64-octeon-linux-gnu-ranlib
checking command to parse
/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/too=
ls/bin/mips64-octeon-linux-gnu-nm
-B output from mips64-octeon-linux-gnu-gcc object... ok
checking for sysroot... no
checking for mips64-octeon-linux-gnu-mt... no
checking for mt... no
checking if : is a manifest tool... no
checking how to run the C preprocessor... mips64-octeon-linux-gnu-gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if mips64-octeon-linux-gnu-gcc supports -fno-rtti
-fno-exceptions... no
checking for mips64-octeon-linux-gnu-gcc option to produce PIC... -fPIC
-DPIC
checking if mips64-octeon-linux-gnu-gcc PIC flag -fPIC -DPIC works... yes
checking if mips64-octeon-linux-gnu-gcc static flag -static works... yes
checking if mips64-octeon-linux-gnu-gcc supports -c -o file.o... yes
checking if mips64-octeon-linux-gnu-gcc supports -c -o file.o... (cached)
yes
checking whether the mips64-octeon-linux-gnu-gcc linker
(/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/to=
ols-gcc-4.3/mips64-octeon-linux-gnu/bin/ld)
supports shared libraries... yes
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
*checking whether to build shared libraries... no*
checking whether to build static libraries... yes
checking for inline... inline
checking for pid_t... yes
checking for size_t... yes
checking for stdlib.h... (cached) yes
checking for GNU libc compatible malloc... (cached) yes
checking for stdlib.h... (cached) yes
checking for unistd.h... (cached) yes
checking for sys/param.h... yes
checking for getpagesize... yes
checking for working mmap... no
checking for bzero... yes
checking for gettimeofday... yes
checking for munmap... yes
checking for sched_getcpu... yes
checking for strtoul... yes
checking for sysconf... yes
checking for sys_futex()... yes
checking for cpu_set_t... yes
checking whether CPU_ZERO works... yes
checking whether CPU_SET works... yes
checking for sched_setaffinity... yes
checking how many arguments sched_setaffinity takes... 3
configure: creating ./config.status
config.status: creating Makefile
config.status: creating doc/Makefile
config.status: creating doc/examples/Makefile
config.status: creating tests/Makefile
config.status: creating tests/common/Makefile
config.status: creating tests/unit/Makefile
config.status: creating tests/benchmark/Makefile
config.status: creating tests/regression/Makefile
config.status: creating liburcu.pc
config.status: creating liburcu-bp.pc
config.status: creating liburcu-cds.pc
config.status: creating liburcu-qsbr.pc
config.status: creating liburcu-mb.pc
config.status: creating liburcu-signal.pc
config.status: creating config.h
config.status: config.h is unchanged
config.status: creating urcu/config.h
config.status: urcu/config.h is unchanged
config.status: linking urcu/arch/mips.h to urcu/arch.h
config.status: linking urcu/uatomic/mips.h to urcu/uatomic.h
config.status: executing depfiles commands
config.status: executing libtool commands
SMP support enabled.
Thread Local Storage (TLS): __thread.


[shkumar@shrayanth userspace-rcu]$ make
make  all-recursive
make[1]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'
Making all in .
make[2]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'
  CC     wfqueue.lo
  CC     wfcqueue.lo

  CC     wfstack.lo
  CCLD   liburcu-common.la
  CC     urcu.lo
  CC     urcu-pointer.lo
  CCLD   liburcu.la
  CC     urcu-qsbr.lo
  CCLD   liburcu-qsbr.la
  CC     liburcu_mb_la-urcu.lo

  CC     liburcu_mb_la-urcu-pointer.lo
  CCLD   liburcu-mb.la
  CC     liburcu_signal_la-urcu.lo
  CC     liburcu_signal_la-urcu-pointer.lo
  CCLD   liburcu-signal.la
  CC     urcu-bp.lo
  CCLD   liburcu-bp.la
  CC     rculfqueue.lo
  CC     rculfstack.lo
  CC     lfstack.lo
  CC     rculfhash.lo
  CC     rculfhash-mm-order.lo
  CC     rculfhash-mm-chunk.lo
  CC     rculfhash-mm-mmap.lo
  CCLD   liburcu-cds.la
make[2]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'
Making all in doc
make[2]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc'
Making all in examples
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s'
make[3]: Nothing to be done for `all'.
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s'
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc'
make[3]: Nothing to be done for `all-am'.
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc'
make[2]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc'
Making all in tests
make[2]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests'
Making all in common
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/commo=
n'
make[3]: Nothing to be done for `all'.
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/commo=
n'
Making all in unit
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/unit'
  CC     test_uatomic.o
  CCLD   test_uatomic
  CC     test_urcu_multiflavor.o
  CC     test_urcu_multiflavor-memb.o
  CC     test_urcu_multiflavor-mb.o
  CC     test_urcu_multiflavor-signal.o
  CC     test_urcu_multiflavor-qsbr.o
  CC     test_urcu_multiflavor-bp.o
  CCLD   test_urcu_multiflavor
  CC     test_urcu_multiflavor_dynlink-test_urcu_multiflavor.o
  CC     test_urcu_multiflavor_dynlink-test_urcu_multiflavor-memb.o
  CC     test_urcu_multiflavor_dynlink-test_urcu_multiflavor-mb.o
  CC     test_urcu_multiflavor_dynlink-test_urcu_multiflavor-signal.o
  CC     test_urcu_multiflavor_dynlink-test_urcu_multiflavor-qsbr.o
  CC     test_urcu_multiflavor_dynlink-test_urcu_multiflavor-bp.o
  CCLD   test_urcu_multiflavor_dynlink
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/unit'
Making all in benchmark
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/bench=
mark'
  CC     test_urcu.o
  CC     urcu.o
  CC     urcu-pointer.o
  CC     wfcqueue.o
  CCLD   test_urcu
  CC     test_urcu_dynamic_link-test_urcu.o
  CC     test_urcu_dynamic_link-urcu.o
  CC     test_urcu_dynamic_link-urcu-pointer.o
  CC     test_urcu_dynamic_link-wfcqueue.o
  CCLD   test_urcu_dynamic_link
  CC     test_urcu_timing.o
  CCLD   test_urcu_timing
  CC     test_urcu_signal-test_urcu.o
  CC     test_urcu_signal-urcu.o
  CC     test_urcu_signal-urcu-pointer.o
  CC     test_urcu_signal-wfcqueue.o
  CCLD   test_urcu_signal
  CC     test_urcu_signal_dynamic_link-test_urcu.o
  CC     test_urcu_signal_dynamic_link-urcu.o
  CC     test_urcu_signal_dynamic_link-urcu-pointer.o
  CC     test_urcu_signal_dynamic_link-wfcqueue.o
  CCLD   test_urcu_signal_dynamic_link
  CC     test_urcu_signal_timing-test_urcu_timing.o
  CC     test_urcu_signal_timing-urcu.o
  CC     test_urcu_signal_timing-urcu-pointer.o
  CC     test_urcu_signal_timing-wfcqueue.o
  CCLD   test_urcu_signal_timing
  CC     test_rwlock_timing.o
  CCLD   test_rwlock_timing
  CC     test_rwlock.o
  CCLD   test_rwlock
  CC     test_perthreadlock_timing.o
  CCLD   test_perthreadlock_timing
  CC     test_perthreadlock.o
  CCLD   test_perthreadlock
  CC     test_urcu_yield-test_urcu.o
  CC     test_urcu_yield-urcu.o
  CC     test_urcu_yield-urcu-pointer.o
  CC     test_urcu_yield-wfcqueue.o
  CCLD   test_urcu_yield
  CC     test_urcu_signal_yield-test_urcu.o
  CC     test_urcu_signal_yield-urcu.o
  CC     test_urcu_signal_yield-urcu-pointer.o
  CC     test_urcu_signal_yield-wfcqueue.o
  CCLD   test_urcu_signal_yield
  CC     test_urcu_mb-test_urcu.o
  CC     test_urcu_mb-urcu.o
  CC     test_urcu_mb-urcu-pointer.o
  CC     test_urcu_mb-wfcqueue.o
  CCLD   test_urcu_mb
  CC     test_urcu_qsbr_timing.o
  CC     urcu-qsbr.o
  CCLD   test_urcu_qsbr_timing
  CC     test_urcu_qsbr.o
  CCLD   test_urcu_qsbr
  CC     test_mutex.o
  CCLD   test_mutex
  CC     test_looplen.o
  CCLD   test_looplen
  CC     test_urcu_gc.o
  CCLD   test_urcu_gc
  CC     test_urcu_signal_gc-test_urcu_gc.o
  CC     test_urcu_signal_gc-urcu.o
  CC     test_urcu_signal_gc-urcu-pointer.o
  CC     test_urcu_signal_gc-wfcqueue.o
  CCLD   test_urcu_signal_gc
  CC     test_urcu_lgc-test_urcu_gc.o
  CC     test_urcu_lgc-urcu.o
  CC     test_urcu_lgc-urcu-pointer.o
  CC     test_urcu_lgc-wfcqueue.o
  CCLD   test_urcu_lgc
  CC     test_urcu_mb_gc-test_urcu_gc.o
  CC     test_urcu_mb_gc-urcu.o
  CC     test_urcu_mb_gc-urcu-pointer.o
  CC     test_urcu_mb_gc-wfcqueue.o
  CCLD   test_urcu_mb_gc
  CC     test_urcu_qsbr_gc.o
  CCLD   test_urcu_qsbr_gc
  CC     test_urcu_qsbr_lgc-test_urcu_qsbr_gc.o
  CC     test_urcu_qsbr_lgc-urcu-qsbr.o
  CC     test_urcu_qsbr_lgc-urcu-pointer.o
  CC     test_urcu_qsbr_lgc-wfcqueue.o
  CCLD   test_urcu_qsbr_lgc
  CC     test_urcu_signal_lgc-test_urcu_gc.o
  CC     test_urcu_signal_lgc-urcu.o
  CC     test_urcu_signal_lgc-urcu-pointer.o
  CC     test_urcu_signal_lgc-wfcqueue.o
  CCLD   test_urcu_signal_lgc
  CC     test_urcu_mb_lgc-test_urcu_gc.o
  CC     test_urcu_mb_lgc-urcu.o
  CC     test_urcu_mb_lgc-urcu-pointer.o
  CC     test_urcu_mb_lgc-wfcqueue.o
  CCLD   test_urcu_mb_lgc
  CC     test_urcu_qsbr_dynamic_link-test_urcu_qsbr.o
  CC     test_urcu_qsbr_dynamic_link-urcu-qsbr.o
  CC     test_urcu_qsbr_dynamic_link-urcu-pointer.o
  CC     test_urcu_qsbr_dynamic_link-wfcqueue.o
  CCLD   test_urcu_qsbr_dynamic_link
  CC     test_urcu_defer.o
  CCLD   test_urcu_defer
  CC     test_urcu_assign.o
  CCLD   test_urcu_assign
  CC     test_urcu_assign_dynamic_link-test_urcu_assign.o
  CC     test_urcu_assign_dynamic_link-urcu.o
  CC     test_urcu_assign_dynamic_link-urcu-pointer.o
  CC     test_urcu_assign_dynamic_link-wfcqueue.o
  CCLD   test_urcu_assign_dynamic_link
  CC     test_urcu_bp.o
  CC     urcu-bp.o
  CCLD   test_urcu_bp
  CC     test_urcu_bp_dynamic_link-test_urcu_bp.o
  CC     test_urcu_bp_dynamic_link-urcu-bp.o
  CC     test_urcu_bp_dynamic_link-urcu-pointer.o
  CC     test_urcu_bp_dynamic_link-wfcqueue.o
  CCLD   test_urcu_bp_dynamic_link
  CC     test_cycles_per_loop.o
  CCLD   test_cycles_per_loop
  CC     test_urcu_lfq.o
  CCLD   test_urcu_lfq
  CC     test_urcu_wfq.o
  CCLD   test_urcu_wfq
  CC     test_urcu_lfs.o
  CCLD   test_urcu_lfs
  CC     test_urcu_wfs.o
  CCLD   test_urcu_wfs
  CC     test_urcu_lfs_rcu.o
  CCLD   test_urcu_lfs_rcu
  CC     test_urcu_wfcq.o
  CCLD   test_urcu_wfcq
  CC     test_urcu_wfq_dynlink-test_urcu_wfq.o
  CCLD   test_urcu_wfq_dynlink
  CC     test_urcu_wfs_dynlink-test_urcu_wfs.o
  CCLD   test_urcu_wfs_dynlink
  CC     test_urcu_wfcq_dynlink-test_urcu_wfcq.o
  CCLD   test_urcu_wfcq_dynlink
  CC     test_urcu_lfq_dynlink-test_urcu_lfq.o
  CC     test_urcu_lfq_dynlink-urcu.o
  CC     test_urcu_lfq_dynlink-urcu-pointer.o
  CC     test_urcu_lfq_dynlink-wfcqueue.o
  CCLD   test_urcu_lfq_dynlink
  CC     test_urcu_lfs_dynlink-test_urcu_lfs.o
  CC     test_urcu_lfs_dynlink-urcu.o
  CC     test_urcu_lfs_dynlink-urcu-pointer.o
  CC     test_urcu_lfs_dynlink-wfcqueue.o
  CCLD   test_urcu_lfs_dynlink
  CC     test_urcu_hash-test_urcu_hash.o
  CC     test_urcu_hash-test_urcu_hash_rw.o
  CC     test_urcu_hash-test_urcu_hash_unique.o
  CCLD   test_urcu_hash
  CC     test_urcu_lfs_rcu_dynlink-test_urcu_lfs_rcu.o
  CC     test_urcu_lfs_rcu_dynlink-urcu.o
  CC     test_urcu_lfs_rcu_dynlink-urcu-pointer.o
  CC     test_urcu_lfs_rcu_dynlink-wfcqueue.o
  CCLD   test_urcu_lfs_rcu_dynlink
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/bench=
mark'
Making all in regression
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/regre=
ssion'
  CC     test_urcu_fork.o
  CC     urcu.o
  CC     urcu-pointer.o
  CC     wfcqueue.o
  CCLD   test_urcu_fork
  CC     rcutorture_urcu-urcutorture.o
  CCLD   rcutorture_urcu
  CC     rcutorture_urcu_signal-urcutorture.o
  CCLD   rcutorture_urcu_signal
  CC     rcutorture_urcu_mb-urcutorture.o
  CCLD   rcutorture_urcu_mb
  CC     rcutorture_urcu_bp-urcutorture.o
  CCLD   rcutorture_urcu_bp
  CC     rcutorture_urcu_qsbr-urcutorture.o
  CCLD   rcutorture_urcu_qsbr
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/regre=
ssion'
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests'
make[3]: Nothing to be done for `all-am'.
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests'
make[2]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests'
make[1]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'



*Shared-library build.*

CC=3Dmips64-octeon-linux-gnu-gcc ./configure prefix=3D$(pwd)/urcu_install
--host=3Dmips64-octeon-linux-gnu --enable-shared
configure: WARNING: if you wanted to set the --build type, don't use --host=
.
    If a cross compiler is detected then cross compile mode will be used
checking build system type... i686-pc-linux-gnu
checking host system type... mips64-octeon-linux-gnu
checking target system type... mips64-octeon-linux-gnu
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for mips64-octeon-linux-gnu-strip... mips64-octeon-linux-gnu-strip
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for style of include used by make... GNU
checking for mips64-octeon-linux-gnu-gcc... mips64-octeon-linux-gnu-gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... yes
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether mips64-octeon-linux-gnu-gcc accepts -g... yes
checking for mips64-octeon-linux-gnu-gcc option to accept ISO C89... none
needed
checking dependency style of mips64-octeon-linux-gnu-gcc... gcc3
checking for thread local storage (TLS) class... __thread
checking for mips64-octeon-linux-gnu-gcc... (cached)
mips64-octeon-linux-gnu-gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether mips64-octeon-linux-gnu-gcc accepts -g... (cached) yes
checking for mips64-octeon-linux-gnu-gcc option to accept ISO C89...
(cached) none needed
checking dependency style of mips64-octeon-linux-gnu-gcc... (cached) gcc3
checking whether make sets $(MAKE)... (cached) yes
checking how to print strings... printf
checking for a sed that does not truncate output... /bin/sed
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for fgrep... /bin/grep -F
checking for ld used by mips64-octeon-linux-gnu-gcc...
/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/too=
ls-gcc-4.3/mips64-octeon-linux-gnu/bin/ld
checking if the linker
(/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/to=
ols-gcc-4.3/mips64-octeon-linux-gnu/bin/ld)
is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)...
/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/too=
ls/bin/mips64-octeon-linux-gnu-nm
-B
checking the name lister
(/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/to=
ols/bin/mips64-octeon-linux-gnu-nm
-B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+=3D"... yes
checking how to convert i686-pc-linux-gnu file names to
mips64-octeon-linux-gnu format... func_convert_file_noop
checking how to convert i686-pc-linux-gnu file names to toolchain format...
func_convert_file_noop
checking for
/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/too=
ls-gcc-4.3/mips64-octeon-linux-gnu/bin/ld
option to reload object files... -r
checking for mips64-octeon-linux-gnu-objdump...
mips64-octeon-linux-gnu-objdump
checking how to recognize dependent libraries... pass_all
checking for mips64-octeon-linux-gnu-dlltool... no
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for mips64-octeon-linux-gnu-ar... mips64-octeon-linux-gnu-ar
checking for archiver @FILE support... @
checking for mips64-octeon-linux-gnu-strip... (cached)
mips64-octeon-linux-gnu-strip
checking for mips64-octeon-linux-gnu-ranlib...
mips64-octeon-linux-gnu-ranlib
checking command to parse
/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/too=
ls/bin/mips64-octeon-linux-gnu-nm
-B output from mips64-octeon-linux-gnu-gcc object... ok
checking for sysroot... no
checking for mips64-octeon-linux-gnu-mt... no
checking for mt... no
checking if : is a manifest tool... no
checking how to run the C preprocessor... mips64-octeon-linux-gnu-gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if mips64-octeon-linux-gnu-gcc supports -fno-rtti
-fno-exceptions... no
checking for mips64-octeon-linux-gnu-gcc option to produce PIC... -fPIC
-DPIC
checking if mips64-octeon-linux-gnu-gcc PIC flag -fPIC -DPIC works... yes
checking if mips64-octeon-linux-gnu-gcc static flag -static works... yes
checking if mips64-octeon-linux-gnu-gcc supports -c -o file.o... yes
checking if mips64-octeon-linux-gnu-gcc supports -c -o file.o... (cached)
yes
checking whether the mips64-octeon-linux-gnu-gcc linker
(/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/to=
ols-gcc-4.3/mips64-octeon-linux-gnu/bin/ld)
supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
*checking whether to build shared libraries... yes*
checking whether to build static libraries... yes
checking for inline... inline
checking for pid_t... yes
checking for size_t... yes
checking for stdlib.h... (cached) yes
checking for GNU libc compatible malloc... (cached) yes
checking for stdlib.h... (cached) yes
checking for unistd.h... (cached) yes
checking for sys/param.h... yes
checking for getpagesize... yes
checking for working mmap... no
checking for bzero... yes
checking for gettimeofday... yes
checking for munmap... yes
checking for sched_getcpu... yes
checking for strtoul... yes
checking for sysconf... yes
checking for sys_futex()... yes
checking for cpu_set_t... yes
checking whether CPU_ZERO works... yes
checking whether CPU_SET works... yes
checking for sched_setaffinity... yes
checking how many arguments sched_setaffinity takes... 3
configure: creating ./config.status
config.status: creating Makefile
config.status: creating doc/Makefile
config.status: creating doc/examples/Makefile
config.status: creating tests/Makefile
config.status: creating tests/common/Makefile
config.status: creating tests/unit/Makefile
config.status: creating tests/benchmark/Makefile
config.status: creating tests/regression/Makefile
config.status: creating liburcu.pc
config.status: creating liburcu-bp.pc
config.status: creating liburcu-cds.pc
config.status: creating liburcu-qsbr.pc
config.status: creating liburcu-mb.pc
config.status: creating liburcu-signal.pc
config.status: creating config.h
config.status: config.h is unchanged
config.status: creating urcu/config.h
config.status: urcu/config.h is unchanged
config.status: linking urcu/arch/mips.h to urcu/arch.h
config.status: linking urcu/uatomic/mips.h to urcu/uatomic.h
config.status: executing depfiles commands
config.status: executing libtool commands
SMP support enabled.
Thread Local Storage (TLS): __thread.



[shkumar@shrayanth userspace-rcu]$ make
make  all-recursive
make[1]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'
Making all in .
make[2]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'
  CC     wfqueue.lo
  CC     wfcqueue.lo

  CC     wfstack.lo
  CCLD   liburcu-common.la
  CC     urcu.lo
  CC     urcu-pointer.lo
  CCLD   liburcu.la
  CC     urcu-qsbr.lo
  CCLD   liburcu-qsbr.la
  CC     liburcu_mb_la-urcu.lo

  CC     liburcu_mb_la-urcu-pointer.lo
  CCLD   liburcu-mb.la
  CC     liburcu_signal_la-urcu.lo
  CC     liburcu_signal_la-urcu-pointer.lo
  CCLD   liburcu-signal.la
  CC     urcu-bp.lo
  CCLD   liburcu-bp.la
  CC     rculfqueue.lo
  CC     rculfstack.lo
  CC     lfstack.lo
  CC     rculfhash.lo
  CC     rculfhash-mm-order.lo
  CC     rculfhash-mm-chunk.lo
  CC     rculfhash-mm-mmap.lo
  CCLD   liburcu-cds.la
make[2]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'
Making all in doc
make[2]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc'
Making all in examples
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s'
make -f dist-files/Makefile AM_CPPFLAGS=3D" -I../../../urcu/ -I../../../"
AM_CFLAGS=3D'-g -O2' AM_LDFLAGS=3D' -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"'
all
make[4]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s'
make -C hlist
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/hlist'
make -f Makefile.cds_hlist_add_head_rcu
make[6]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/hlist'

cc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g -O2 \
        -c -o cds_hlist_add_head_rcu.o cds_hlist_add_head_rcu.c
cc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\

        -o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -lurcu
/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when
searching for -lurcu
/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.a when searching
for -lurcu
/usr/bin/ld: cannot find -lurcu
collect2: ld returned 1 exit status
make[6]: *** [cds_hlist_add_head_rcu] Error 1
make[6]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/hlist'

make[5]: *** [all] Error 2
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/hlist'

make[4]: *** [all] Error 2
make[4]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s'

make[3]: *** [all-local] Error 2
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s'

make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc'

make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'

make: *** [all] Error 2



is userspace lib required to build lttng-tools (latest version from git).
It throws this error while trying to configure..

[...]
checking for grp.h... yes
checking for pthread_create in -lpthread... yes
checking for poptGetContext in -lpopt... yes
checking for uuid_generate in -luuid... yes
checking whether cds_list_add is declared... no
configure: error: liburcu >=3D 0.7.2 or newer is needed

thank you
skumar



On Fri, Nov 22, 2013 at 9:16 PM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

> > I edited the log to show only the error. The detailed log is  :
>
>    Copy-writer's tip: when omitting irrelevant parts from a log (or
> conversation quote), indicate the omission with an ellipsis (e.g. '(...)'
> or '[...]').
>
> > $ make
> > make  all-recursive
> > [...]
> >  CC     wfstack.lo
> >  CCLD   liburcu-common.la
> >  CC     urcu.lo
>
>    That's the line that creates liburcu.so.  It seems to succeed, albeit
> with a number of warnings.
>
> > In file included from urcu.c:530:
> > urcu-call-rcu-impl.h: In function 'alloc_cpu_call_rcu_data':
> > urcu-call-rcu-impl.h:150: warning: implicit declaration of function
> 'rpl_malloc'
> > urcu-call-rcu-impl.h:150: warning: assignment makes pointer from intege=
r
> without a cast
> > [...]
> >  CC     urcu-pointer.lo
> > [...]
> > make -f Makefile.cds_hlist_add_head_rcu
> > make[6]: Entering directory
> > `/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
> > cc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g -O2 \
> >        -c -o cds_hlist_add_head_rcu.o cds_hlist_add_head_rcu.c cc -g -O=
2
> -Wall  -g -O2 -L../../../.libs/
> -Wl,-rpath=3D"/home/kumar/userspace/userspace-rcu/doc/examples/../../.lib=
s/" \
> >        -o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -lurcu
> > /usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when
> searching for -lurcu
>
>    But when we get here and try to use liburcu.so for the first time, it
> turns out to be "incompatible".
>
> > /usr/bin/ld: skipping incompatible ../../../.libs//liburcu.a when
> searching for -lurcu
> > /usr/bin/ld: cannot find -lurcu
> > collect2: ld returned 1 exit status
> > make[6]: *** [cds_hlist_add_head_rcu] Error 1
> > [...]
>
>    Except for the warnings, your make log matches mine up to the fatal
> liburcu.so incompatibility error.
>
>    Could the compiler be misconfigured?  Try making a small test .so and
> application pair.
>
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection &
> Countermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l
> Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D
> Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>

--089e0158c7983798e804ebfaa6c1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">---------- Forwarded me=
ssage ----------<br>From: <b class=3D"gmail_sendername">kumar s</b> <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:skumar.m226@gmail.com">skumar.m226@gmail.c=
om</a>&gt;</span><br>
Date: Mon, Nov 25, 2013 at 12:10 PM<br>Subject: Re: [lttng-dev] liburcu err=
or: Cannot find -lurcu<br>To: &quot;Thibault, Daniel&quot; &lt;<a href=3D"m=
ailto:Daniel.Thibault@drdc-rddc.gc.ca">Daniel.Thibault@drdc-rddc.gc.ca</a>&=
gt;<br>
<br><br><div dir=3D"ltr"><div><br></div><div>Hi,<br><br>I tried test .so an=
d app ,compiled with mips gcc . it worked fine without throwing any errors.=
<br><br><br></div><div>configuring with static library works fine but share=
d lib throws this error. I have attached the log below. <br>

<br><b>Static Library build</b><br><br>CC=3Dmips64-octeon-linux-gnu-gcc ./c=
onfigure prefix=3D$(pwd)/urcu_install --host=3Dmips64-octeon-linux-gnu --di=
sable-shared<br>configure: WARNING: if you wanted to set the --build type, =
don&#39;t use --host.<br>

=A0=A0=A0 If a cross compiler is detected then cross compile mode will be u=
sed<br>checking build system type... i686-pc-linux-gnu<br>checking host sys=
tem type... mips64-octeon-linux-gnu<br>checking target system type... mips6=
4-octeon-linux-gnu<br>

checking for a BSD-compatible install... /usr/bin/install -c<br>checking wh=
ether build environment is sane... yes<br>checking for mips64-octeon-linux-=
gnu-strip... mips64-octeon-linux-gnu-strip<br>checking for a thread-safe mk=
dir -p... /bin/mkdir -p<br>

checking for gawk... gawk<br>checking whether make sets $(MAKE)... yes<br>c=
hecking for style of include used by make... GNU<br>checking for mips64-oct=
eon-linux-gnu-gcc... mips64-octeon-linux-gnu-gcc<br>checking whether the C =
compiler works... yes<br>

checking for C compiler default output file name... a.out<br>checking for s=
uffix of executables... <br>checking whether we are cross compiling... yes<=
br>checking for suffix of object files... o<br>checking whether we are usin=
g the GNU C compiler... yes<br>

checking whether mips64-octeon-linux-gnu-gcc accepts -g... yes<br>checking =
for mips64-octeon-linux-gnu-gcc option to accept ISO C89... none needed<br>=
checking dependency style of mips64-octeon-linux-gnu-gcc... gcc3<br>checkin=
g for thread local storage (TLS) class... __thread<br>

checking for mips64-octeon-linux-gnu-gcc... (cached) mips64-octeon-linux-gn=
u-gcc<br>checking whether we are using the GNU C compiler... (cached) yes<b=
r>checking whether mips64-octeon-linux-gnu-gcc accepts -g... (cached) yes<b=
r>

checking for mips64-octeon-linux-gnu-gcc option to accept ISO C89... (cache=
d) none needed<br>checking dependency style of mips64-octeon-linux-gnu-gcc.=
.. (cached) gcc3<br>checking whether make sets $(MAKE)... (cached) yes<br>

checking how to print strings... printf<br>checking for a sed that does not=
 truncate output... /bin/sed<br>checking for grep that handles long lines a=
nd -e... /bin/grep<br>checking for egrep... /bin/grep -E<br>checking for fg=
rep... /bin/grep -F<br>

checking for ld used by mips64-octeon-linux-gnu-gcc... /home/shkumar/Develo=
pment_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools-gcc-4.3/mips64-oc=
teon-linux-gnu/bin/ld<br>checking if the linker (/home/shkumar/Development_=
Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools-gcc-4.3/mips64-octeon-l=
inux-gnu/bin/ld) is GNU ld... yes<br>

checking for BSD- or MS-compatible name lister (nm)... /home/shkumar/Develo=
pment_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools/bin/mips64-octeon=
-linux-gnu-nm -B<br>checking the name lister (/home/shkumar/Development_Mer=
ge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools/bin/mips64-octeon-linux-gn=
u-nm -B) interface... BSD nm<br>

checking whether ln -s works... yes<br>checking the maximum length of comma=
nd line arguments... 1572864<br>checking whether the shell understands some=
 XSI constructs... yes<br>checking whether the shell understands &quot;+=3D=
&quot;... yes<br>

checking how to convert i686-pc-linux-gnu file names to mips64-octeon-linux=
-gnu format... func_convert_file_noop<br>checking how to convert i686-pc-li=
nux-gnu file names to toolchain format... func_convert_file_noop<br>checkin=
g for /home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-S=
DK/tools-gcc-4.3/mips64-octeon-linux-gnu/bin/ld option to reload object fil=
es... -r<br>

checking for mips64-octeon-linux-gnu-objdump... mips64-octeon-linux-gnu-obj=
dump<br>checking how to recognize dependent libraries... pass_all<br>checki=
ng for mips64-octeon-linux-gnu-dlltool... no<br>checking for dlltool... no<=
br>

checking how to associate runtime and link libraries... printf %s\n<br>chec=
king for mips64-octeon-linux-gnu-ar... mips64-octeon-linux-gnu-ar<br>checki=
ng for archiver @FILE support... @<br>checking for mips64-octeon-linux-gnu-=
strip... (cached) mips64-octeon-linux-gnu-strip<br>

checking for mips64-octeon-linux-gnu-ranlib... mips64-octeon-linux-gnu-ranl=
ib<br>checking command to parse /home/shkumar/Development_Merge/NewOCT/OCTE=
ON_SDK/octeon_sdk/OCTEON-SDK/tools/bin/mips64-octeon-linux-gnu-nm -B output=
 from mips64-octeon-linux-gnu-gcc object... ok<br>

checking for sysroot... no<br>checking for mips64-octeon-linux-gnu-mt... no=
<br>checking for mt... no<br>checking if : is a manifest tool... no<br>chec=
king how to run the C preprocessor... mips64-octeon-linux-gnu-gcc -E<br>

checking for ANSI C header files... yes<br>checking for sys/types.h... yes<=
br>checking for sys/stat.h... yes<br>checking for stdlib.h... yes<br>checki=
ng for string.h... yes<br>checking for memory.h... yes<br>checking for stri=
ngs.h... yes<br>

checking for inttypes.h... yes<br>checking for stdint.h... yes<br>checking =
for unistd.h... yes<br>checking for dlfcn.h... yes<br>checking for objdir..=
. .libs<br>checking if mips64-octeon-linux-gnu-gcc supports -fno-rtti -fno-=
exceptions... no<br>

checking for mips64-octeon-linux-gnu-gcc option to produce PIC... -fPIC -DP=
IC<br>checking if mips64-octeon-linux-gnu-gcc PIC flag -fPIC -DPIC works...=
 yes<br>checking if mips64-octeon-linux-gnu-gcc static flag -static works..=
. yes<br>

checking if mips64-octeon-linux-gnu-gcc supports -c -o file.o... yes<br>che=
cking if mips64-octeon-linux-gnu-gcc supports -c -o file.o... (cached) yes<=
br>checking whether the mips64-octeon-linux-gnu-gcc linker (/home/shkumar/D=
evelopment_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools-gcc-4.3/mips=
64-octeon-linux-gnu/bin/ld) supports shared libraries... yes<br>

checking dynamic linker characteristics... GNU/Linux ld.so<br>checking how =
to hardcode library paths into programs... immediate<br>checking whether st=
ripping libraries is possible... yes<br>checking if libtool supports shared=
 libraries... yes<br>

<b>checking whether to build shared libraries... no</b><br>checking whether=
 to build static libraries... yes<br>checking for inline... inline<br>check=
ing for pid_t... yes<br>checking for size_t... yes<br>checking for stdlib.h=
... (cached) yes<br>

checking for GNU libc compatible malloc... (cached) yes<br>checking for std=
lib.h... (cached) yes<br>checking for unistd.h... (cached) yes<br>checking =
for sys/param.h... yes<br>checking for getpagesize... yes<br>checking for w=
orking mmap... no<br>

checking for bzero... yes<br>checking for gettimeofday... yes<br>checking f=
or munmap... yes<br>checking for sched_getcpu... yes<br>checking for strtou=
l... yes<br>checking for sysconf... yes<br>checking for sys_futex()... yes<=
br>

checking for cpu_set_t... yes<br>checking whether CPU_ZERO works... yes<br>=
checking whether CPU_SET works... yes<br>checking for sched_setaffinity... =
yes<br>checking how many arguments sched_setaffinity takes... 3<br>configur=
e: creating ./config.status<br>

config.status: creating Makefile<br>config.status: creating doc/Makefile<br=
>config.status: creating doc/examples/Makefile<br>config.status: creating t=
ests/Makefile<br>config.status: creating tests/common/Makefile<br>config.st=
atus: creating tests/unit/Makefile<br>

config.status: creating tests/benchmark/Makefile<br>config.status: creating=
 tests/regression/Makefile<br>config.status: creating liburcu.pc<br>config.=
status: creating liburcu-bp.pc<br>config.status: creating liburcu-cds.pc<br=
>

config.status: creating liburcu-qsbr.pc<br>config.status: creating liburcu-=
mb.pc<br>config.status: creating liburcu-signal.pc<br>config.status: creati=
ng config.h<br>config.status: config.h is unchanged<br>config.status: creat=
ing urcu/config.h<br>

config.status: urcu/config.h is unchanged<br>config.status: linking urcu/ar=
ch/mips.h to urcu/arch.h<br>config.status: linking urcu/uatomic/mips.h to u=
rcu/uatomic.h<br>config.status: executing depfiles commands<br>config.statu=
s: executing libtool commands<br>

SMP support enabled.<br>Thread Local Storage (TLS): __thread.<div class=3D"=
im"><br><br>[shkumar@shrayanth userspace-rcu]$ make <br>make=A0 all-recursi=
ve<br></div>make[1]: Entering directory `/home/shkumar/Development_Merge/Ne=
wOCT/userspace/userspace-rcu&#39;<br>

Making all in .<br>make[2]: Entering directory `/home/shkumar/Development_M=
erge/NewOCT/userspace/userspace-rcu&#39;<br>=A0 CC=A0=A0=A0=A0 wfqueue.lo<b=
r>=A0 CC=A0=A0=A0=A0 wfcqueue.lo<div class=3D"im"><br>=A0 CC=A0=A0=A0=A0 wf=
stack.lo<br>=A0 CCLD=A0=A0 <a href=3D"http://liburcu-common.la" target=3D"_=
blank">liburcu-common.la</a><br>

=A0 CC=A0=A0=A0=A0 urcu.lo<br></div><div class=3D"im">=A0 CC=A0=A0=A0=A0 ur=
cu-pointer.lo<br>=A0 CCLD=A0=A0 <a href=3D"http://liburcu.la" target=3D"_bl=
ank">liburcu.la</a><br>=A0 CC=A0=A0=A0=A0 urcu-qsbr.lo<br></div>=A0 CCLD=A0=
=A0 <a href=3D"http://liburcu-qsbr.la" target=3D"_blank">liburcu-qsbr.la</a=
><br>
=A0 CC=A0=A0=A0=A0 liburcu_mb_la-urcu.lo<div class=3D"im"><br>
=A0 CC=A0=A0=A0=A0 liburcu_mb_la-urcu-pointer.lo<br>=A0 CCLD=A0=A0 <a href=
=3D"http://liburcu-mb.la" target=3D"_blank">liburcu-mb.la</a><br>=A0 CC=A0=
=A0=A0=A0 liburcu_signal_la-urcu.lo<br></div><div class=3D"im">=A0 CC=A0=A0=
=A0=A0 liburcu_signal_la-urcu-pointer.lo<br>
=A0 CCLD=A0=A0 <a href=3D"http://liburcu-signal.la" target=3D"_blank">libur=
cu-signal.la</a><br>
=A0 CC=A0=A0=A0=A0 urcu-bp.lo<br></div><div class=3D"im">=A0 CCLD=A0=A0 <a =
href=3D"http://liburcu-bp.la" target=3D"_blank">liburcu-bp.la</a><br>=A0 CC=
=A0=A0=A0=A0 rculfqueue.lo<br>=A0 CC=A0=A0=A0=A0 rculfstack.lo<br>=A0 CC=A0=
=A0=A0=A0 lfstack.lo<br>=A0 CC=A0=A0=A0=A0 rculfhash.lo<br>
</div><div class=3D"im">=A0 CC=A0=A0=A0=A0 rculfhash-mm-order.lo<br>=A0 CC=
=A0=A0=A0=A0 rculfhash-mm-chunk.lo<br>
=A0 CC=A0=A0=A0=A0 rculfhash-mm-mmap.lo<br>=A0 CCLD=A0=A0 <a href=3D"http:/=
/liburcu-cds.la" target=3D"_blank">liburcu-cds.la</a><br></div>make[2]: Lea=
ving directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-=
rcu&#39;<br>Making all in doc<br>
make[2]: Entering directory `/home/shkumar/Development_Merge/NewOCT/userspa=
ce/userspace-rcu/doc&#39;<br>
Making all in examples<br>make[3]: Entering directory `/home/shkumar/Develo=
pment_Merge/NewOCT/userspace/userspace-rcu/doc/examples&#39;<br>make[3]: No=
thing to be done for `all&#39;.<br>make[3]: Leaving directory `/home/shkuma=
r/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples&#39;<br>

make[3]: Entering directory `/home/shkumar/Development_Merge/NewOCT/userspa=
ce/userspace-rcu/doc&#39;<br>make[3]: Nothing to be done for `all-am&#39;.<=
br>make[3]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/users=
pace/userspace-rcu/doc&#39;<br>

make[2]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/userspac=
e/userspace-rcu/doc&#39;<br>Making all in tests<br>make[2]: Entering direct=
ory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests&#=
39;<br>

Making all in common<br>make[3]: Entering directory `/home/shkumar/Developm=
ent_Merge/NewOCT/userspace/userspace-rcu/tests/common&#39;<br>make[3]: Noth=
ing to be done for `all&#39;.<br>make[3]: Leaving directory `/home/shkumar/=
Development_Merge/NewOCT/userspace/userspace-rcu/tests/common&#39;<br>

Making all in unit<br>make[3]: Entering directory `/home/shkumar/Developmen=
t_Merge/NewOCT/userspace/userspace-rcu/tests/unit&#39;<br>=A0 CC=A0=A0=A0=
=A0 test_uatomic.o<br>=A0 CCLD=A0=A0 test_uatomic<br>=A0 CC=A0=A0=A0=A0 tes=
t_urcu_multiflavor.o<br>

=A0 CC=A0=A0=A0=A0 test_urcu_multiflavor-memb.o<br>=A0 CC=A0=A0=A0=A0 test_=
urcu_multiflavor-mb.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_multiflavor-signal.o<=
br>=A0 CC=A0=A0=A0=A0 test_urcu_multiflavor-qsbr.o<br>=A0 CC=A0=A0=A0=A0 te=
st_urcu_multiflavor-bp.o<br>=A0 CCLD=A0=A0 test_urcu_multiflavor<br>

=A0 CC=A0=A0=A0=A0 test_urcu_multiflavor_dynlink-test_urcu_multiflavor.o<br=
>=A0 CC=A0=A0=A0=A0 test_urcu_multiflavor_dynlink-test_urcu_multiflavor-mem=
b.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_multiflavor_dynlink-test_urcu_multiflav=
or-mb.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_multiflavor_dynlink-test_urcu_multi=
flavor-signal.o<br>

=A0 CC=A0=A0=A0=A0 test_urcu_multiflavor_dynlink-test_urcu_multiflavor-qsbr=
.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_multiflavor_dynlink-test_urcu_multiflavo=
r-bp.o<br>=A0 CCLD=A0=A0 test_urcu_multiflavor_dynlink<br>make[3]: Leaving =
directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/t=
ests/unit&#39;<br>

Making all in benchmark<br>make[3]: Entering directory `/home/shkumar/Devel=
opment_Merge/NewOCT/userspace/userspace-rcu/tests/benchmark&#39;<br>=A0 CC=
=A0=A0=A0=A0 test_urcu.o<br>=A0 CC=A0=A0=A0=A0 urcu.o<br>=A0 CC=A0=A0=A0=A0=
 urcu-pointer.o<br>=A0 CC=A0=A0=A0=A0 wfcqueue.o<br>

=A0 CCLD=A0=A0 test_urcu<br>=A0 CC=A0=A0=A0=A0 test_urcu_dynamic_link-test_=
urcu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_dynamic_link-urcu.o<br>=A0 CC=A0=A0=
=A0=A0 test_urcu_dynamic_link-urcu-pointer.o<br>=A0 CC=A0=A0=A0=A0 test_urc=
u_dynamic_link-wfcqueue.o<br>=A0 CCLD=A0=A0 test_urcu_dynamic_link<br>

=A0 CC=A0=A0=A0=A0 test_urcu_timing.o<br>=A0 CCLD=A0=A0 test_urcu_timing<br=
>=A0 CC=A0=A0=A0=A0 test_urcu_signal-test_urcu.o<br>=A0 CC=A0=A0=A0=A0 test=
_urcu_signal-urcu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_signal-urcu-pointer.o<b=
r>=A0 CC=A0=A0=A0=A0 test_urcu_signal-wfcqueue.o<br>

=A0 CCLD=A0=A0 test_urcu_signal<br>=A0 CC=A0=A0=A0=A0 test_urcu_signal_dyna=
mic_link-test_urcu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_signal_dynamic_link-ur=
cu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_signal_dynamic_link-urcu-pointer.o<br>=
=A0 CC=A0=A0=A0=A0 test_urcu_signal_dynamic_link-wfcqueue.o<br>

=A0 CCLD=A0=A0 test_urcu_signal_dynamic_link<br>=A0 CC=A0=A0=A0=A0 test_urc=
u_signal_timing-test_urcu_timing.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_signal_t=
iming-urcu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_signal_timing-urcu-pointer.o<b=
r>=A0 CC=A0=A0=A0=A0 test_urcu_signal_timing-wfcqueue.o<br>

=A0 CCLD=A0=A0 test_urcu_signal_timing<br>=A0 CC=A0=A0=A0=A0 test_rwlock_ti=
ming.o<br>=A0 CCLD=A0=A0 test_rwlock_timing<br>=A0 CC=A0=A0=A0=A0 test_rwlo=
ck.o<br>=A0 CCLD=A0=A0 test_rwlock<br>=A0 CC=A0=A0=A0=A0 test_perthreadlock=
_timing.o<br>=A0 CCLD=A0=A0 test_perthreadlock_timing<br>

=A0 CC=A0=A0=A0=A0 test_perthreadlock.o<br>=A0 CCLD=A0=A0 test_perthreadloc=
k<br>=A0 CC=A0=A0=A0=A0 test_urcu_yield-test_urcu.o<br>=A0 CC=A0=A0=A0=A0 t=
est_urcu_yield-urcu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_yield-urcu-pointer.o<=
br>=A0 CC=A0=A0=A0=A0 test_urcu_yield-wfcqueue.o<br>

=A0 CCLD=A0=A0 test_urcu_yield<br>=A0 CC=A0=A0=A0=A0 test_urcu_signal_yield=
-test_urcu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_signal_yield-urcu.o<br>=A0 CC=
=A0=A0=A0=A0 test_urcu_signal_yield-urcu-pointer.o<br>=A0 CC=A0=A0=A0=A0 te=
st_urcu_signal_yield-wfcqueue.o<br>=A0 CCLD=A0=A0 test_urcu_signal_yield<br=
>

=A0 CC=A0=A0=A0=A0 test_urcu_mb-test_urcu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu=
_mb-urcu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_mb-urcu-pointer.o<br>=A0 CC=A0=
=A0=A0=A0 test_urcu_mb-wfcqueue.o<br>=A0 CCLD=A0=A0 test_urcu_mb<br>=A0 CC=
=A0=A0=A0=A0 test_urcu_qsbr_timing.o<br>=A0 CC=A0=A0=A0=A0 urcu-qsbr.o<br>

=A0 CCLD=A0=A0 test_urcu_qsbr_timing<br>=A0 CC=A0=A0=A0=A0 test_urcu_qsbr.o=
<br>=A0 CCLD=A0=A0 test_urcu_qsbr<br>=A0 CC=A0=A0=A0=A0 test_mutex.o<br>=A0=
 CCLD=A0=A0 test_mutex<br>=A0 CC=A0=A0=A0=A0 test_looplen.o<br>=A0 CCLD=A0=
=A0 test_looplen<br>=A0 CC=A0=A0=A0=A0 test_urcu_gc.o<br>=A0 CCLD=A0=A0 tes=
t_urcu_gc<br>

=A0 CC=A0=A0=A0=A0 test_urcu_signal_gc-test_urcu_gc.o<br>=A0 CC=A0=A0=A0=A0=
 test_urcu_signal_gc-urcu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_signal_gc-urcu-=
pointer.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_signal_gc-wfcqueue.o<br>=A0 CCLD=
=A0=A0 test_urcu_signal_gc<br>=A0 CC=A0=A0=A0=A0 test_urcu_lgc-test_urcu_gc=
.o<br>

=A0 CC=A0=A0=A0=A0 test_urcu_lgc-urcu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_lgc=
-urcu-pointer.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_lgc-wfcqueue.o<br>=A0 CCLD=
=A0=A0 test_urcu_lgc<br>=A0 CC=A0=A0=A0=A0 test_urcu_mb_gc-test_urcu_gc.o<b=
r>=A0 CC=A0=A0=A0=A0 test_urcu_mb_gc-urcu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu=
_mb_gc-urcu-pointer.o<br>

=A0 CC=A0=A0=A0=A0 test_urcu_mb_gc-wfcqueue.o<br>=A0 CCLD=A0=A0 test_urcu_m=
b_gc<br>=A0 CC=A0=A0=A0=A0 test_urcu_qsbr_gc.o<br>=A0 CCLD=A0=A0 test_urcu_=
qsbr_gc<br>=A0 CC=A0=A0=A0=A0 test_urcu_qsbr_lgc-test_urcu_qsbr_gc.o<br>=A0=
 CC=A0=A0=A0=A0 test_urcu_qsbr_lgc-urcu-qsbr.o<br>

=A0 CC=A0=A0=A0=A0 test_urcu_qsbr_lgc-urcu-pointer.o<br>=A0 CC=A0=A0=A0=A0 =
test_urcu_qsbr_lgc-wfcqueue.o<br>=A0 CCLD=A0=A0 test_urcu_qsbr_lgc<br>=A0 C=
C=A0=A0=A0=A0 test_urcu_signal_lgc-test_urcu_gc.o<br>=A0 CC=A0=A0=A0=A0 tes=
t_urcu_signal_lgc-urcu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_signal_lgc-urcu-po=
inter.o<br>

=A0 CC=A0=A0=A0=A0 test_urcu_signal_lgc-wfcqueue.o<br>=A0 CCLD=A0=A0 test_u=
rcu_signal_lgc<br>=A0 CC=A0=A0=A0=A0 test_urcu_mb_lgc-test_urcu_gc.o<br>=A0=
 CC=A0=A0=A0=A0 test_urcu_mb_lgc-urcu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_mb_=
lgc-urcu-pointer.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_mb_lgc-wfcqueue.o<br>

=A0 CCLD=A0=A0 test_urcu_mb_lgc<br>=A0 CC=A0=A0=A0=A0 test_urcu_qsbr_dynami=
c_link-test_urcu_qsbr.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_qsbr_dynamic_link-u=
rcu-qsbr.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_qsbr_dynamic_link-urcu-pointer.o=
<br>=A0 CC=A0=A0=A0=A0 test_urcu_qsbr_dynamic_link-wfcqueue.o<br>

=A0 CCLD=A0=A0 test_urcu_qsbr_dynamic_link<br>=A0 CC=A0=A0=A0=A0 test_urcu_=
defer.o<br>=A0 CCLD=A0=A0 test_urcu_defer<br>=A0 CC=A0=A0=A0=A0 test_urcu_a=
ssign.o<br>=A0 CCLD=A0=A0 test_urcu_assign<br>=A0 CC=A0=A0=A0=A0 test_urcu_=
assign_dynamic_link-test_urcu_assign.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_assi=
gn_dynamic_link-urcu.o<br>

=A0 CC=A0=A0=A0=A0 test_urcu_assign_dynamic_link-urcu-pointer.o<br>=A0 CC=
=A0=A0=A0=A0 test_urcu_assign_dynamic_link-wfcqueue.o<br>=A0 CCLD=A0=A0 tes=
t_urcu_assign_dynamic_link<br>=A0 CC=A0=A0=A0=A0 test_urcu_bp.o<br>=A0 CC=
=A0=A0=A0=A0 urcu-bp.o<br>=A0 CCLD=A0=A0 test_urcu_bp<br>

=A0 CC=A0=A0=A0=A0 test_urcu_bp_dynamic_link-test_urcu_bp.o<br>=A0 CC=A0=A0=
=A0=A0 test_urcu_bp_dynamic_link-urcu-bp.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_=
bp_dynamic_link-urcu-pointer.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_bp_dynamic_l=
ink-wfcqueue.o<br>=A0 CCLD=A0=A0 test_urcu_bp_dynamic_link<br>

=A0 CC=A0=A0=A0=A0 test_cycles_per_loop.o<br>=A0 CCLD=A0=A0 test_cycles_per=
_loop<br>=A0 CC=A0=A0=A0=A0 test_urcu_lfq.o<br>=A0 CCLD=A0=A0 test_urcu_lfq=
<br>=A0 CC=A0=A0=A0=A0 test_urcu_wfq.o<br>=A0 CCLD=A0=A0 test_urcu_wfq<br>=
=A0 CC=A0=A0=A0=A0 test_urcu_lfs.o<br>=A0 CCLD=A0=A0 test_urcu_lfs<br>

=A0 CC=A0=A0=A0=A0 test_urcu_wfs.o<br>=A0 CCLD=A0=A0 test_urcu_wfs<br>=A0 C=
C=A0=A0=A0=A0 test_urcu_lfs_rcu.o<br>=A0 CCLD=A0=A0 test_urcu_lfs_rcu<br>=
=A0 CC=A0=A0=A0=A0 test_urcu_wfcq.o<br>=A0 CCLD=A0=A0 test_urcu_wfcq<br>=A0=
 CC=A0=A0=A0=A0 test_urcu_wfq_dynlink-test_urcu_wfq.o<br>

=A0 CCLD=A0=A0 test_urcu_wfq_dynlink<br>=A0 CC=A0=A0=A0=A0 test_urcu_wfs_dy=
nlink-test_urcu_wfs.o<br>=A0 CCLD=A0=A0 test_urcu_wfs_dynlink<br>=A0 CC=A0=
=A0=A0=A0 test_urcu_wfcq_dynlink-test_urcu_wfcq.o<br>=A0 CCLD=A0=A0 test_ur=
cu_wfcq_dynlink<br>=A0 CC=A0=A0=A0=A0 test_urcu_lfq_dynlink-test_urcu_lfq.o=
<br>

=A0 CC=A0=A0=A0=A0 test_urcu_lfq_dynlink-urcu.o<br>=A0 CC=A0=A0=A0=A0 test_=
urcu_lfq_dynlink-urcu-pointer.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_lfq_dynlink=
-wfcqueue.o<br>=A0 CCLD=A0=A0 test_urcu_lfq_dynlink<br>=A0 CC=A0=A0=A0=A0 t=
est_urcu_lfs_dynlink-test_urcu_lfs.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_lfs_dy=
nlink-urcu.o<br>

=A0 CC=A0=A0=A0=A0 test_urcu_lfs_dynlink-urcu-pointer.o<br>=A0 CC=A0=A0=A0=
=A0 test_urcu_lfs_dynlink-wfcqueue.o<br>=A0 CCLD=A0=A0 test_urcu_lfs_dynlin=
k<br>=A0 CC=A0=A0=A0=A0 test_urcu_hash-test_urcu_hash.o<br>=A0 CC=A0=A0=A0=
=A0 test_urcu_hash-test_urcu_hash_rw.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_hash=
-test_urcu_hash_unique.o<br>

=A0 CCLD=A0=A0 test_urcu_hash<br>=A0 CC=A0=A0=A0=A0 test_urcu_lfs_rcu_dynli=
nk-test_urcu_lfs_rcu.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_lfs_rcu_dynlink-urcu=
.o<br>=A0 CC=A0=A0=A0=A0 test_urcu_lfs_rcu_dynlink-urcu-pointer.o<br>=A0 CC=
=A0=A0=A0=A0 test_urcu_lfs_rcu_dynlink-wfcqueue.o<br>

=A0 CCLD=A0=A0 test_urcu_lfs_rcu_dynlink<br>make[3]: Leaving directory `/ho=
me/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/benchmark=
&#39;<br>Making all in regression<br>make[3]: Entering directory `/home/shk=
umar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/regression&#39;=
<br>

=A0 CC=A0=A0=A0=A0 test_urcu_fork.o<br>=A0 CC=A0=A0=A0=A0 urcu.o<br>=A0 CC=
=A0=A0=A0=A0 urcu-pointer.o<br>=A0 CC=A0=A0=A0=A0 wfcqueue.o<br>=A0 CCLD=A0=
=A0 test_urcu_fork<br>=A0 CC=A0=A0=A0=A0 rcutorture_urcu-urcutorture.o<br>=
=A0 CCLD=A0=A0 rcutorture_urcu<br>=A0 CC=A0=A0=A0=A0 rcutorture_urcu_signal=
-urcutorture.o<br>

=A0 CCLD=A0=A0 rcutorture_urcu_signal<br>=A0 CC=A0=A0=A0=A0 rcutorture_urcu=
_mb-urcutorture.o<br>=A0 CCLD=A0=A0 rcutorture_urcu_mb<br>=A0 CC=A0=A0=A0=
=A0 rcutorture_urcu_bp-urcutorture.o<br>=A0 CCLD=A0=A0 rcutorture_urcu_bp<b=
r>=A0 CC=A0=A0=A0=A0 rcutorture_urcu_qsbr-urcutorture.o<br>

=A0 CCLD=A0=A0 rcutorture_urcu_qsbr<br>make[3]: Leaving directory `/home/sh=
kumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/regression&#39=
;<br>make[3]: Entering directory `/home/shkumar/Development_Merge/NewOCT/us=
erspace/userspace-rcu/tests&#39;<br>

make[3]: Nothing to be done for `all-am&#39;.<br>make[3]: Leaving directory=
 `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests&#39;=
<br>make[2]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/user=
space/userspace-rcu/tests&#39;<br>

make[1]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/userspac=
e/userspace-rcu&#39;<br><br><br><br><font><b>Shared-library build.</b></fon=
t><br><br>CC=3Dmips64-octeon-linux-gnu-gcc ./configure prefix=3D$(pwd)/urcu=
_install --host=3Dmips64-octeon-linux-gnu --enable-shared<br>

configure: WARNING: if you wanted to set the --build type, don&#39;t use --=
host.<br>=A0=A0=A0 If a cross compiler is detected then cross compile mode =
will be used<br>checking build system type... i686-pc-linux-gnu<br>checking=
 host system type... mips64-octeon-linux-gnu<br>

checking target system type... mips64-octeon-linux-gnu<br>checking for a BS=
D-compatible install... /usr/bin/install -c<br>checking whether build envir=
onment is sane... yes<br>checking for mips64-octeon-linux-gnu-strip... mips=
64-octeon-linux-gnu-strip<br>

checking for a thread-safe mkdir -p... /bin/mkdir -p<br>checking for gawk..=
. gawk<br>checking whether make sets $(MAKE)... yes<br>checking for style o=
f include used by make... GNU<br>checking for mips64-octeon-linux-gnu-gcc..=
. mips64-octeon-linux-gnu-gcc<br>

checking whether the C compiler works... yes<br>checking for C compiler def=
ault output file name... a.out<br>checking for suffix of executables... <br=
>checking whether we are cross compiling... yes<br>checking for suffix of o=
bject files... o<br>

checking whether we are using the GNU C compiler... yes<br>checking whether=
 mips64-octeon-linux-gnu-gcc accepts -g... yes<br>checking for mips64-octeo=
n-linux-gnu-gcc option to accept ISO C89... none needed<br>checking depende=
ncy style of mips64-octeon-linux-gnu-gcc... gcc3<br>

checking for thread local storage (TLS) class... __thread<br>checking for m=
ips64-octeon-linux-gnu-gcc... (cached) mips64-octeon-linux-gnu-gcc<br>check=
ing whether we are using the GNU C compiler... (cached) yes<br>checking whe=
ther mips64-octeon-linux-gnu-gcc accepts -g... (cached) yes<br>

checking for mips64-octeon-linux-gnu-gcc option to accept ISO C89... (cache=
d) none needed<br>checking dependency style of mips64-octeon-linux-gnu-gcc.=
.. (cached) gcc3<br>checking whether make sets $(MAKE)... (cached) yes<br>

checking how to print strings... printf<br>checking for a sed that does not=
 truncate output... /bin/sed<br>checking for grep that handles long lines a=
nd -e... /bin/grep<br>checking for egrep... /bin/grep -E<br>checking for fg=
rep... /bin/grep -F<br>

checking for ld used by mips64-octeon-linux-gnu-gcc... /home/shkumar/Develo=
pment_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools-gcc-4.3/mips64-oc=
teon-linux-gnu/bin/ld<br>checking if the linker (/home/shkumar/Development_=
Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools-gcc-4.3/mips64-octeon-l=
inux-gnu/bin/ld) is GNU ld... yes<br>

checking for BSD- or MS-compatible name lister (nm)... /home/shkumar/Develo=
pment_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools/bin/mips64-octeon=
-linux-gnu-nm -B<br>checking the name lister (/home/shkumar/Development_Mer=
ge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools/bin/mips64-octeon-linux-gn=
u-nm -B) interface... BSD nm<br>

checking whether ln -s works... yes<br>checking the maximum length of comma=
nd line arguments... 1572864<br>checking whether the shell understands some=
 XSI constructs... yes<br>checking whether the shell understands &quot;+=3D=
&quot;... yes<br>

checking how to convert i686-pc-linux-gnu file names to mips64-octeon-linux=
-gnu format... func_convert_file_noop<br>checking how to convert i686-pc-li=
nux-gnu file names to toolchain format... func_convert_file_noop<br>checkin=
g for /home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-S=
DK/tools-gcc-4.3/mips64-octeon-linux-gnu/bin/ld option to reload object fil=
es... -r<br>

checking for mips64-octeon-linux-gnu-objdump... mips64-octeon-linux-gnu-obj=
dump<br>checking how to recognize dependent libraries... pass_all<br>checki=
ng for mips64-octeon-linux-gnu-dlltool... no<br>checking for dlltool... no<=
br>

checking how to associate runtime and link libraries... printf %s\n<br>chec=
king for mips64-octeon-linux-gnu-ar... mips64-octeon-linux-gnu-ar<br>checki=
ng for archiver @FILE support... @<br>checking for mips64-octeon-linux-gnu-=
strip... (cached) mips64-octeon-linux-gnu-strip<br>

checking for mips64-octeon-linux-gnu-ranlib... mips64-octeon-linux-gnu-ranl=
ib<br>checking command to parse /home/shkumar/Development_Merge/NewOCT/OCTE=
ON_SDK/octeon_sdk/OCTEON-SDK/tools/bin/mips64-octeon-linux-gnu-nm -B output=
 from mips64-octeon-linux-gnu-gcc object... ok<br>

checking for sysroot... no<br>checking for mips64-octeon-linux-gnu-mt... no=
<br>checking for mt... no<br>checking if : is a manifest tool... no<br>chec=
king how to run the C preprocessor... mips64-octeon-linux-gnu-gcc -E<br>

checking for ANSI C header files... yes<br>checking for sys/types.h... yes<=
br>checking for sys/stat.h... yes<br>checking for stdlib.h... yes<br>checki=
ng for string.h... yes<br>checking for memory.h... yes<br>checking for stri=
ngs.h... yes<br>

checking for inttypes.h... yes<br>checking for stdint.h... yes<br>checking =
for unistd.h... yes<br>checking for dlfcn.h... yes<br>checking for objdir..=
. .libs<br>checking if mips64-octeon-linux-gnu-gcc supports -fno-rtti -fno-=
exceptions... no<br>

checking for mips64-octeon-linux-gnu-gcc option to produce PIC... -fPIC -DP=
IC<br>checking if mips64-octeon-linux-gnu-gcc PIC flag -fPIC -DPIC works...=
 yes<br>checking if mips64-octeon-linux-gnu-gcc static flag -static works..=
. yes<br>

checking if mips64-octeon-linux-gnu-gcc supports -c -o file.o... yes<br>che=
cking if mips64-octeon-linux-gnu-gcc supports -c -o file.o... (cached) yes<=
br>checking whether the mips64-octeon-linux-gnu-gcc linker (/home/shkumar/D=
evelopment_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools-gcc-4.3/mips=
64-octeon-linux-gnu/bin/ld) supports shared libraries... yes<br>

checking whether -lc should be explicitly linked in... no<br>checking dynam=
ic linker characteristics... GNU/Linux ld.so<br>checking how to hardcode li=
brary paths into programs... immediate<br>checking whether stripping librar=
ies is possible... yes<br>

checking if libtool supports shared libraries... yes<br><b>checking whether=
 to build shared libraries... yes</b><br>checking whether to build static l=
ibraries... yes<br>checking for inline... inline<br>checking for pid_t... y=
es<br>

checking for size_t... yes<br>checking for stdlib.h... (cached) yes<br>chec=
king for GNU libc compatible malloc... (cached) yes<br>checking for stdlib.=
h... (cached) yes<br>checking for unistd.h... (cached) yes<br>checking for =
sys/param.h... yes<br>

checking for getpagesize... yes<br>checking for working mmap... no<br>check=
ing for bzero... yes<br>checking for gettimeofday... yes<br>checking for mu=
nmap... yes<br>checking for sched_getcpu... yes<br>checking for strtoul... =
yes<br>

checking for sysconf... yes<br>checking for sys_futex()... yes<br>checking =
for cpu_set_t... yes<br>checking whether CPU_ZERO works... yes<br>checking =
whether CPU_SET works... yes<br>checking for sched_setaffinity... yes<br>

checking how many arguments sched_setaffinity takes... 3<br>configure: crea=
ting ./config.status<br>config.status: creating Makefile<br>config.status: =
creating doc/Makefile<br>config.status: creating doc/examples/Makefile<br>

config.status: creating tests/Makefile<br>config.status: creating tests/com=
mon/Makefile<br>config.status: creating tests/unit/Makefile<br>config.statu=
s: creating tests/benchmark/Makefile<br>config.status: creating tests/regre=
ssion/Makefile<br>

config.status: creating liburcu.pc<br>config.status: creating liburcu-bp.pc=
<br>config.status: creating liburcu-cds.pc<br>config.status: creating libur=
cu-qsbr.pc<br>config.status: creating liburcu-mb.pc<br>config.status: creat=
ing liburcu-signal.pc<br>

config.status: creating config.h<br>config.status: config.h is unchanged<br=
>config.status: creating urcu/config.h<br>config.status: urcu/config.h is u=
nchanged<br>config.status: linking urcu/arch/mips.h to urcu/arch.h<br>
config.status: linking urcu/uatomic/mips.h to urcu/uatomic.h<br>
config.status: executing depfiles commands<br>config.status: executing libt=
ool commands<br>SMP support enabled.<br>Thread Local Storage (TLS): __threa=
d.<div class=3D"im"><br><br><br>[shkumar@shrayanth userspace-rcu]$ make<br>
make=A0 all-recursive<br></div>
make[1]: Entering directory `/home/shkumar/Development_Merge/NewOCT/userspa=
ce/userspace-rcu&#39;<br>Making all in .<br>make[2]: Entering directory `/h=
ome/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu&#39;<br>=A0 CC=
=A0=A0=A0=A0 wfqueue.lo<br>

=A0 CC=A0=A0=A0=A0 wfcqueue.lo<div class=3D"im"><br>=A0 CC=A0=A0=A0=A0 wfst=
ack.lo<br>=A0 CCLD=A0=A0 <a href=3D"http://liburcu-common.la" target=3D"_bl=
ank">liburcu-common.la</a><br>=A0 CC=A0=A0=A0=A0 urcu.lo<br></div><div clas=
s=3D"im">=A0 CC=A0=A0=A0=A0 urcu-pointer.lo<br>=A0 CCLD=A0=A0 <a href=3D"ht=
tp://liburcu.la" target=3D"_blank">liburcu.la</a><br>
=A0 CC=A0=A0=A0=A0 urcu-qsbr.lo<br></div>
=A0 CCLD=A0=A0 <a href=3D"http://liburcu-qsbr.la" target=3D"_blank">liburcu=
-qsbr.la</a><br>=A0 CC=A0=A0=A0=A0 liburcu_mb_la-urcu.lo<div class=3D"im"><=
br>=A0 CC=A0=A0=A0=A0 liburcu_mb_la-urcu-pointer.lo<br>=A0 CCLD=A0=A0 <a hr=
ef=3D"http://liburcu-mb.la" target=3D"_blank">liburcu-mb.la</a><br>
=A0 CC=A0=A0=A0=A0 liburcu_signal_la-urcu.lo<br></div><div class=3D"im">
=A0 CC=A0=A0=A0=A0 liburcu_signal_la-urcu-pointer.lo<br>=A0 CCLD=A0=A0 <a h=
ref=3D"http://liburcu-signal.la" target=3D"_blank">liburcu-signal.la</a><br=
>=A0 CC=A0=A0=A0=A0 urcu-bp.lo<br></div><div class=3D"im">=A0 CCLD=A0=A0 <a=
 href=3D"http://liburcu-bp.la" target=3D"_blank">liburcu-bp.la</a><br>
=A0 CC=A0=A0=A0=A0 rculfqueue.lo<br>
=A0 CC=A0=A0=A0=A0 rculfstack.lo<br>=A0 CC=A0=A0=A0=A0 lfstack.lo<br>=A0 CC=
=A0=A0=A0=A0 rculfhash.lo<br></div><div class=3D"im">=A0 CC=A0=A0=A0=A0 rcu=
lfhash-mm-order.lo<br>=A0 CC=A0=A0=A0=A0 rculfhash-mm-chunk.lo<br>=A0 CC=A0=
=A0=A0=A0 rculfhash-mm-mmap.lo<br>=A0 CCLD=A0=A0 <a href=3D"http://liburcu-=
cds.la" target=3D"_blank">liburcu-cds.la</a><br>
</div>
make[2]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/userspac=
e/userspace-rcu&#39;<br>Making all in doc<br>make[2]: Entering directory `/=
home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc&#39;<br>

Making all in examples<br>make[3]: Entering directory `/home/shkumar/Develo=
pment_Merge/NewOCT/userspace/userspace-rcu/doc/examples&#39;<br>make -f dis=
t-files/Makefile AM_CPPFLAGS=3D&quot; -I../../../urcu/ -I../../../&quot; AM=
_CFLAGS=3D&#39;-g -O2&#39; AM_LDFLAGS=3D&#39; -L../../../.libs/ -Wl,-rpath=
=3D&quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc=
/examples/../../.libs/&quot;&#39;=A0 all<br>

make[4]: Entering directory `/home/shkumar/Development_Merge/NewOCT/userspa=
ce/userspace-rcu/doc/examples&#39;<br>make -C hlist<br>make[5]: Entering di=
rectory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc=
/examples/hlist&#39;<br>

make -f Makefile.cds_hlist_add_head_rcu<br>make[6]: Entering directory `/ho=
me/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/hl=
ist&#39;<div class=3D"im"><br>cc=A0 -g -O2 -Wall -I../../../urcu/ -I../../.=
./ -g -O2 \<br>
=A0=A0=A0 =A0=A0=A0 -c -o cds_hlist_add_head_rcu.o cds_hlist_add_head_rcu.c=
<br></div>
cc -g -O2 -Wall=A0 -g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkuma=
r/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs=
/&quot; \<div class=3D"im"><br>=A0=A0=A0 =A0=A0=A0 -o cds_hlist_add_head_rc=
u cds_hlist_add_head_rcu.o -lurcu<br>

/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when searchin=
g for -lurcu<br></div><div class=3D"im">/usr/bin/ld: skipping incompatible =
../../../.libs//liburcu.a when searching for -lurcu<br>/usr/bin/ld: cannot =
find -lurcu<br>
collect2: ld returned 1 exit status<br>
make[6]: *** [cds_hlist_add_head_rcu] Error 1<br></div>make[6]: Leaving dir=
ectory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/=
examples/hlist&#39;<div class=3D"im"><br>make[5]: *** [all] Error 2<br></di=
v>
make[5]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/userspac=
e/userspace-rcu/doc/examples/hlist&#39;<div class=3D"im"><br>
make[4]: *** [all] Error 2<br></div>make[4]: Leaving directory `/home/shkum=
ar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples&#39;<div c=
lass=3D"im"><br>make[3]: *** [all-local] Error 2<br></div>make[3]: Leaving =
directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/d=
oc/examples&#39;<div class=3D"im">
<br>
make[2]: *** [all-recursive] Error 1<br></div>make[2]: Leaving directory `/=
home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc&#39;<div =
class=3D"im"><br>make[1]: *** [all-recursive] Error 1<br></div>make[1]: Lea=
ving directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-=
rcu&#39;<div class=3D"im">
<br>
make: *** [all] Error 2<br><br></div></div><div><br><br></div><div>is users=
pace lib required to build lttng-tools (latest version from git). It throws=
 this error while trying to configure..<br><br>[...]<br>checking for grp.h.=
.. yes<br>

checking for pthread_create in -lpthread... yes<br>checking for poptGetCont=
ext in -lpopt... yes<br>checking for uuid_generate in -luuid... yes<br>chec=
king whether cds_list_add is declared... no<br>configure: error: liburcu &g=
t;=3D 0.7.2 or newer is needed<br>

<br></div><div>thank you<br></div><div>skumar<br></div><div><br></div></div=
><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extra"><br><br=
><div class=3D"gmail_quote">On Fri, Nov 22, 2013 at 9:16 PM, Thibault, Dani=
el <span dir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca"=
 target=3D"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br=
>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>&gt; I edited the log to show only the =
error. The detailed log is =A0:<br>
<br>
</div>=A0 =A0Copy-writer&#39;s tip: when omitting irrelevant parts from a l=
og (or conversation quote), indicate the omission with an ellipsis (e.g. &#=
39;(...)&#39; or &#39;[...]&#39;).<br>
<br>
&gt; $ make<br>
&gt; make =A0all-recursive<br>
&gt; [...]<br>
<div>&gt; =A0CC =A0 =A0 wfstack.lo<br>
&gt; =A0CCLD =A0 <a href=3D"http://liburcu-common.la" target=3D"_blank">lib=
urcu-common.la</a><br>
&gt; =A0CC =A0 =A0 urcu.lo<br>
<br>
</div>=A0 =A0That&#39;s the line that creates liburcu.so. =A0It seems to su=
cceed, albeit with a number of warnings.<br>
<div><br>
&gt; In file included from urcu.c:530:<br>
&gt; urcu-call-rcu-impl.h: In function &#39;alloc_cpu_call_rcu_data&#39;:<b=
r>
&gt; urcu-call-rcu-impl.h:150: warning: implicit declaration of function &#=
39;rpl_malloc&#39;<br>
&gt; urcu-call-rcu-impl.h:150: warning: assignment makes pointer from integ=
er without a cast<br>
</div>&gt; [...]<br>
&gt; =A0CC =A0 =A0 urcu-pointer.lo<br>
&gt; [...]<br>
<div>&gt; make -f Makefile.cds_hlist_add_head_rcu<br>
&gt; make[6]: Entering directory<br>
&gt; `/home/kumar/userspace/userspace-rcu/doc/examples/hlist&#39;<br>
&gt; cc =A0-g -O2 -Wall -I../../../urcu/ -I../../../ -g -O2 \<br>
&gt; =A0 =A0 =A0 =A0-c -o cds_hlist_add_head_rcu.o cds_hlist_add_head_rcu.c=
 cc -g -O2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/kumar=
/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \<br>
&gt; =A0 =A0 =A0 =A0-o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -lur=
cu<br>
&gt; /usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when sea=
rching for -lurcu<br>
<br>
</div>=A0 =A0But when we get here and try to use liburcu.so for the first t=
ime, it turns out to be &quot;incompatible&quot;.<br>
<div><br>
&gt; /usr/bin/ld: skipping incompatible ../../../.libs//liburcu.a when sear=
ching for -lurcu<br>
&gt; /usr/bin/ld: cannot find -lurcu<br>
&gt; collect2: ld returned 1 exit status<br>
&gt; make[6]: *** [cds_hlist_add_head_rcu] Error 1<br>
</div>&gt; [...]<br>
<br>
=A0 =A0Except for the warnings, your make log matches mine up to the fatal =
liburcu.so incompatibility error.<br>
<br>
=A0 =A0Could the compiler be misconfigured? =A0Try making a small test .so =
and application pair.<br>
<div><div><br>
Daniel U. Thibault<br>
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &amp;=
 Countermeasures (SPC)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=E9bec QC =A0G3J 1X5<br>
CANADA<br>
Vox : (418) 844-4000 x4245<br>
Fax : (418) 844-4538<br>
NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V=
%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br>
</div></div></blockquote></div><br></div>
</div></div></div><br></div>

--089e0158c7983798e804ebfaa6c1--


--===============1607696644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1607696644==--
