From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: liburcu-bp not found
Date: Mon, 18 Feb 2013 09:03:02 -0500
Message-ID: <20130218140302.GA2606__31046.9534983442$1361196235$gmane$org@Krystal>
References: <CALH8uKQvF=w14_tdoF2sq3ONHTNEmKWXtk-BbMQ2aOZu9y-Uew@mail.gmail.com>
	<CAO8ONPzQGziKFQPh_NopOO2HjdOCtsv9L_35aN+7G2WB8x+YgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1U7RJD-000201-NS
	for lttng-dev@lists.lttng.org; Mon, 18 Feb 2013 09:03:07 -0500
Content-Disposition: inline
In-Reply-To: <CAO8ONPzQGziKFQPh_NopOO2HjdOCtsv9L_35aN+7G2WB8x+YgA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Vanni Genua <vannigenua@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Vanni Genua (vannigenua@gmail.com) wrote:
> Hi Mathieu,
> After a long time, I decided to install LTTng on Intel Atom Z530 too.
> My kernel: 3.6.2-rt4
> My instruction set:x86
> My Linux distro:gentoo.
> After having installed glibc, uuidtools, automake, autoconf, libtools, I
> tried to install LTTng this way, getting some errors as reported below:
> 

CCing lttng-dev. Please contact lttng-dev@lists.lttng.org with these
issues, so that other LTTng developers can help you out.

Thanks,

Mathieu

> STEP1:
> #git clone http://git.lttng.org/lttng-modules.git
> 
> #cd lttng-modules
> 
> lttng-modules # make
> make -C /lib/modules/3.6.2-rt4/build M=/usr/src/LTTng/lttng-modules modules
> make[1]: Entering directory `/usr/src/linux-3.6.2-rt4'
>   Building modules, stage 2.
>   MODPOST 0 modules
> make[1]: Leaving directory `/usr/src/linux-3.6.2-rt4'
> 
> lttng-modules # make modules_install
> make -C /lib/modules/3.6.2-rt4/build M=/usr/src/LTTng/lttng-modules
> modules_install
> make[1]: Entering directory `/usr/src/linux-3.6.2-rt4'
>   DEPMOD  3.6.2-rt4
> make[1]: Leaving directory `/usr/src/linux-3.6.2-rt4'
> 
> lttng-modules # depmod -a
> 
> STEP2:
> # git clone http://git.lttng.org/userspace-rcu.git
> 
> #cd userspace-rcu
> userspace-rcu # ./bootstrap
> userspace-rcu # ./configure
> checking build system type... i686-pc-linux-gnu
> checking host system type... i686-pc-linux-gnu
> checking target system type... i686-pc-linux-gnu
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether build environment is sane... yes
> checking for a thread-safe mkdir -p... /bin/mkdir -p
> checking for gawk... gawk
> checking whether make sets $(MAKE)... yes
> checking for style of include used by make... GNU
> checking for gcc... gcc
> checking whether the C compiler works... yes
> checking for C compiler default output file name... a.out
> checking for suffix of executables...
> checking whether we are cross compiling... no
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether gcc accepts -g... yes
> checking for gcc option to accept ISO C89... none needed
> checking dependency style of gcc... gcc3
> checking for thread local storage (TLS) class... __thread
> checking for gcc... (cached) gcc
> checking whether we are using the GNU C compiler... (cached) yes
> checking whether gcc accepts -g... (cached) yes
> checking for gcc option to accept ISO C89... (cached) none needed
> checking dependency style of gcc... (cached) gcc3
> checking whether make sets $(MAKE)... (cached) yes
> checking how to print strings... printf
> checking for a sed that does not truncate output... /bin/sed
> checking for grep that handles long lines and -e... /bin/grep
> checking for egrep... /bin/grep -E
> checking for fgrep... /bin/grep -F
> checking for ld used by gcc... /usr/i686-pc-linux-gnu/bin/ld
> checking if the linker (/usr/i686-pc-linux-gnu/bin/ld) is GNU ld... yes
> checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
> checking the name lister (/usr/bin/nm -B) interface... BSD nm
> checking whether ln -s works... yes
> checking the maximum length of command line arguments... 1572864
> checking whether the shell understands some XSI constructs... yes
> checking whether the shell understands "+="... yes
> checking for /usr/i686-pc-linux-gnu/bin/ld option to reload object files...
> -r
> checking for objdump... objdump     checking how to recognize dependent
> libraries... pass_all
> checking for ar... ar
> checking for strip... strip
> checking for ranlib... ranlib
> checking command to parse /usr/bin/nm -B output from gcc object... ok
> checking how to run the C preprocessor... gcc -E
> checking for ANSI C header files... yes
> checking for sys/types.h... yes
> checking for sys/stat.h... yes
> checking for stdlib.h... yes
> checking for string.h... yes
> checking for memory.h... yes
> checking for strings.h... yes
> checking for inttypes.h... yes
> checking for stdint.h... yes
> checking for unistd.h... yes
> checking for dlfcn.h... yes
> checking for objdir... .libs
> checking if gcc supports -fno-rtti -fno-exceptions... no
> checking for gcc option to produce PIC... -fPIC -DPIC
> checking if gcc PIC flag -fPIC -DPIC works... yes
> checking if gcc static flag -static works... yes
> checking if gcc supports -c -o file.o... yes
> checking if gcc supports -c -o file.o... (cached) yes
> checking whether the gcc linker (/usr/i686-pc-linux-gnu/bin/ld) supports
> shared libraries... yes
> checking whether -lc should be explicitly linked in... no
> checking dynamic linker characteristics... GNU/Linux ld.so
> checking how to hardcode library paths into programs... immediate
> checking whether stripping libraries is possible... yes
> checking if libtool supports shared libraries... yes
> checking whether to build shared libraries... yes
> checking whether to build static libraries... yes
> checking for inline... inline
> checking for pid_t... yes
> checking for size_t... yes
> checking for stdlib.h... (cached) yes
> checking for GNU libc compatible malloc... yes
> checking for stdlib.h... (cached) yes
> checking for unistd.h... (cached) yes
> checking for sys/param.h... yes
> checking for getpagesize... yes
> checking for working mmap... yes
> checking for bzero... yes
> checking for gettimeofday... yes
> checking for munmap... yes
> checking for sched_getcpu... yes
> checking for strtoul... yes
> checking for sysconf... yes
> checking if architecture really supports the mfence instruction... no
> checking for sys_futex()... yes
> checking for sched_setaffinity... yes
> checking for cpu_set_t... yes
> checking whether CPU_ZERO works... yes
> checking how many arguments sched_setaffinity takes... 3
> configure: creating ./config.status
> config.status: creating Makefile
> config.status: creating doc/Makefile
> config.status: creating tests/Makefile
> config.status: creating liburcu.pc
> config.status: creating liburcu-bp.pc
> config.status: creating liburcu-cds.pc
> config.status: creating liburcu-qsbr.pc
> config.status: creating liburcu-mb.pc
> config.status: creating liburcu-signal.pc
> config.status: creating config.h
> config.status: config.h is unchanged
> config.status: creating urcu/config.h
> config.status: urcu/config.h is unchanged
> config.status: linking urcu/arch/x86.h to urcu/arch.h
> config.status: linking urcu/uatomic/x86.h to urcu/uatomic.h
> config.status: executing depfiles commands
> config.status: executing libtool commands
> SMP support enabled.
> Thread Local Storage (TLS): __thread.
> 
> userspace-rcu # make
> make  all-recursive
> make[1]: Entering directory `/usr/src/LTTng/userspace-rcu'
> Making all in .
> make[2]: Entering directory `/usr/src/LTTng/userspace-rcu'
> make[2]: Leaving directory `/usr/src/LTTng/userspace-rcu'
> Making all in doc
> make[2]: Entering directory `/usr/src/LTTng/userspace-rcu/doc'
> make[2]: Nothing to be done for `all'.
> make[2]: Leaving directory `/usr/src/LTTng/userspace-rcu/doc'
> Making all in tests
> make[2]: Entering directory `/usr/src/LTTng/userspace-rcu/tests'
> make[2]: Nothing to be done for `all'.
> make[2]: Leaving directory `/usr/src/LTTng/userspace-rcu/tests'
> make[1]: Leaving directory `/usr/src/LTTng/userspace-rcu'
> 
> userspace-rcu # make install
> Making install in .
> make[1]: Entering directory `/usr/src/LTTng/userspace-rcu'
> make[2]: Entering directory `/usr/src/LTTng/userspace-rcu'
> test -z "/usr/local/lib" || /bin/mkdir -p "/usr/local/lib"
> /bin/sh ./libtool   --mode=install /usr/bin/install -c   liburcu-common.la
> liburcu.la liburcu-qsbr.la liburcu-mb.la liburcu-signal.la liburcu-bp.la
> liburcu-cds.la '/usr/local/lib'
> libtool: install: /usr/bin/install -c .libs/liburcu-common.so.2.0.0
> /usr/local/lib/liburcu-common.so.2.0.0
> libtool: install: (cd /usr/local/lib && { ln -s -f liburcu-common.so.2.0.0
> liburcu-common.so.2 || { rm -f liburcu-common.so.2 && ln -s
> liburcu-common.so.2.0.0 liburcu-common.so.2; }; })
> libtool: install: (cd /usr/local/lib && { ln -s -f liburcu-common.so.2.0.0
> liburcu-common.so || { rm -f liburcu-common.so && ln -s
> liburcu-common.so.2.0.0 liburcu-common.so; }; })
> libtool: install: /usr/bin/install -c .libs/liburcu-common.lai
> /usr/local/lib/liburcu-common.la
> libtool: install: warning: relinking `liburcu.la'
> libtool: install: (cd /usr/src/LTTng/userspace-rcu; /bin/sh
> /usr/src/LTTng/userspace-rcu/libtool  --silent --tag CC --mode=relink gcc
> -Wall -g -O2 -lpthread -version-info 2:0:0 -o liburcu.la -rpath
> /usr/local/lib urcu.lo urcu-pointer.lo liburcu-common.la )
> libtool: install: /usr/bin/install -c .libs/liburcu.so.2.0.0T
> /usr/local/lib/liburcu.so.2.0.0
> libtool: install: (cd /usr/local/lib && { ln -s -f liburcu.so.2.0.0
> liburcu.so.2 || { rm -f liburcu.so.2 && ln -s liburcu.so.2.0.0
> liburcu.so.2; }; })
> libtool: install: (cd /usr/local/lib && { ln -s -f liburcu.so.2.0.0
> liburcu.so || { rm -f liburcu.so && ln -s liburcu.so.2.0.0 liburcu.so; }; })
> libtool: install: /usr/bin/install -c .libs/liburcu.lai /usr/local/lib/
> liburcu.la
> libtool: install: warning: relinking `liburcu-qsbr.la'
> libtool: install: (cd /usr/src/LTTng/userspace-rcu; /bin/sh
> /usr/src/LTTng/userspace-rcu/libtool  --silent --tag CC --mode=relink gcc
> -Wall -g -O2 -lpthread -version-info 2:0:0 -o liburcu-qsbr.la -rpath
> /usr/local/lib urcu-qsbr.lo urcu-pointer.lo liburcu-common.la )
> libtool: install: /usr/bin/install -c .libs/liburcu-qsbr.so.2.0.0T
> /usr/local/lib/liburcu-qsbr.so.2.0.0
> libtool: install: (cd /usr/local/lib && { ln -s -f liburcu-qsbr.so.2.0.0
> liburcu-qsbr.so.2 || { rm -f liburcu-qsbr.so.2 && ln -s
> liburcu-qsbr.so.2.0.0 liburcu-qsbr.so.2; }; })
> libtool: install: (cd /usr/local/lib && { ln -s -f liburcu-qsbr.so.2.0.0
> liburcu-qsbr.so || { rm -f liburcu-qsbr.so && ln -s liburcu-qsbr.so.2.0.0
> liburcu-qsbr.so; }; })
> libtool: install: /usr/bin/install -c .libs/liburcu-qsbr.lai /usr/local/lib/
> liburcu-qsbr.la
> libtool: install: warning: relinking `liburcu-mb.la'
> libtool: install: (cd /usr/src/LTTng/userspace-rcu; /bin/sh
> /usr/src/LTTng/userspace-rcu/libtool  --silent --tag CC --mode=relink gcc
> -DRCU_MB -g -O2 -lpthread -version-info 2:0:0 -o liburcu-mb.la -rpath
> /usr/local/lib liburcu_mb_la-urcu.lo liburcu_mb_la-urcu-pointer.lo
> liburcu-common.la )
> libtool: install: /usr/bin/install -c .libs/liburcu-mb.so.2.0.0T
> /usr/local/lib/liburcu-mb.so.2.0.0
> libtool: install: (cd /usr/local/lib && { ln -s -f liburcu-mb.so.2.0.0
> liburcu-mb.so.2 || { rm -f liburcu-mb.so.2 && ln -s liburcu-mb.so.2.0.0
> liburcu-mb.so.2; }; })
> libtool: install: (cd /usr/local/lib && { ln -s -f liburcu-mb.so.2.0.0
> liburcu-mb.so || { rm -f liburcu-mb.so && ln -s liburcu-mb.so.2.0.0
> liburcu-mb.so; }; })
> libtool: install: /usr/bin/install -c .libs/liburcu-mb.lai /usr/local/lib/
> liburcu-mb.la
> libtool: install: warning: relinking `liburcu-signal.la'
> libtool: install: (cd /usr/src/LTTng/userspace-rcu; /bin/sh
> /usr/src/LTTng/userspace-rcu/libtool  --silent --tag CC --mode=relink gcc
> -DRCU_SIGNAL -g -O2 -lpthread -version-info 2:0:0 -o
> liburcu-signal.la-rpath /usr/local/lib liburcu_signal_la-urcu.lo
> liburcu_signal_la-urcu-pointer.lo liburcu-common.la )
> libtool: install: /usr/bin/install -c .libs/liburcu-signal.so.2.0.0T
> /usr/local/lib/liburcu-signal.so.2.0.0
> libtool: install: (cd /usr/local/lib && { ln -s -f liburcu-signal.so.2.0.0
> liburcu-signal.so.2 || { rm -f liburcu-signal.so.2 && ln -s
> liburcu-signal.so.2.0.0 liburcu-signal.so.2; }; })
> libtool: install: (cd /usr/local/lib && { ln -s -f liburcu-signal.so.2.0.0
> liburcu-signal.so || { rm -f liburcu-signal.so && ln -s
> liburcu-signal.so.2.0.0 liburcu-signal.so; }; })
> libtool: install: /usr/bin/install -c .libs/liburcu-signal.lai
> /usr/local/lib/liburcu-signal.la
> libtool: install: warning: relinking `liburcu-bp.la'
> libtool: install: (cd /usr/src/LTTng/userspace-rcu; /bin/sh
> /usr/src/LTTng/userspace-rcu/libtool  --silent --tag CC --mode=relink gcc
> -Wall -g -O2 -lpthread -version-info 2:0:0 -o liburcu-bp.la -rpath
> /usr/local/lib urcu-bp.lo urcu-pointer.lo liburcu-common.la )
> libtool: install: /usr/bin/install -c .libs/liburcu-bp.so.2.0.0T
> /usr/local/lib/liburcu-bp.so.2.0.0
> libtool: install: (cd /usr/local/lib && { ln -s -f liburcu-bp.so.2.0.0
> liburcu-bp.so.2 || { rm -f liburcu-bp.so.2 && ln -s liburcu-bp.so.2.0.0
> liburcu-bp.so.2; }; })
> libtool: install: (cd /usr/local/lib && { ln -s -f liburcu-bp.so.2.0.0
> liburcu-bp.so || { rm -f liburcu-bp.so && ln -s liburcu-bp.so.2.0.0
> liburcu-bp.so; }; })
> libtool: install: /usr/bin/install -c .libs/liburcu-bp.lai /usr/local/lib/
> liburcu-bp.la
> libtool: install: warning: relinking `liburcu-cds.la'
> libtool: install: (cd /usr/src/LTTng/userspace-rcu; /bin/sh
> /usr/src/LTTng/userspace-rcu/libtool  --silent --tag CC --mode=relink gcc
> -Wall -g -O2 -lpthread -version-info 2:0:0 -o liburcu-cds.la -rpath
> /usr/local/lib rculfqueue.lo rculfstack.lo lfstack.lo rculfhash.lo
> rculfhash-mm-order.lo rculfhash-mm-chunk.lo rculfhash-mm-mmap.lo
> liburcu-common.la )
> libtool: install: /usr/bin/install -c .libs/liburcu-cds.so.2.0.0T
> /usr/local/lib/liburcu-cds.so.2.0.0
> libtool: install: (cd /usr/local/lib && { ln -s -f liburcu-cds.so.2.0.0
> liburcu-cds.so.2 || { rm -f liburcu-cds.so.2 && ln -s liburcu-cds.so.2.0.0
> liburcu-cds.so.2; }; })
> libtool: install: (cd /usr/local/lib && { ln -s -f liburcu-cds.so.2.0.0
> liburcu-cds.so || { rm -f liburcu-cds.so && ln -s liburcu-cds.so.2.0.0
> liburcu-cds.so; }; })
> libtool: install: /usr/bin/install -c .libs/liburcu-cds.lai /usr/local/lib/
> liburcu-cds.la
> libtool: install: /usr/bin/install -c .libs/liburcu-common.a
> /usr/local/lib/liburcu-common.a
> libtool: install: chmod 644 /usr/local/lib/liburcu-common.a
> libtool: install: ranlib /usr/local/lib/liburcu-common.a
> libtool: install: /usr/bin/install -c .libs/liburcu.a
> /usr/local/lib/liburcu.a
> libtool: install: chmod 644 /usr/local/lib/liburcu.a
> libtool: install: ranlib /usr/local/lib/liburcu.a
> libtool: install: /usr/bin/install -c .libs/liburcu-qsbr.a
> /usr/local/lib/liburcu-qsbr.a
> libtool: install: chmod 644 /usr/local/lib/liburcu-qsbr.a
> libtool: install: ranlib /usr/local/lib/liburcu-qsbr.a
> libtool: install: /usr/bin/install -c .libs/liburcu-mb.a
> /usr/local/lib/liburcu-mb.a
> libtool: install: chmod 644 /usr/local/lib/liburcu-mb.a
> libtool: install: ranlib /usr/local/lib/liburcu-mb.a
> libtool: install: /usr/bin/install -c .libs/liburcu-signal.a
> /usr/local/lib/liburcu-signal.a
> libtool: install: chmod 644 /usr/local/lib/liburcu-signal.a
> libtool: install: ranlib /usr/local/lib/liburcu-signal.a
> libtool: install: /usr/bin/install -c .libs/liburcu-bp.a
> /usr/local/lib/liburcu-bp.a
> libtool: install: chmod 644 /usr/local/lib/liburcu-bp.a
> libtool: install: ranlib /usr/local/lib/liburcu-bp.a
> libtool: install: /usr/bin/install -c .libs/liburcu-cds.a
> /usr/local/lib/liburcu-cds.a
> libtool: install: chmod 644 /usr/local/lib/liburcu-cds.a
> libtool: install: ranlib /usr/local/lib/liburcu-cds.a
> libtool: finish:
> PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:/usr/i686-pc-linux-gnu/gcc-bin/4.4.4:/usr/i686-pc-linux-gnu/gnat-gcc-bin/4.3:/usr/libexec/gnat-gcc/i686-pc-linux-gnu/4.3:/usr/lib/subversion/bin:/opt/gnat-gpl/bin:/sbin"
> ldconfig -n /usr/local/lib
> 
> ----------------------------------------------------------------------
> Libraries have been installed in:
>    /usr/local/lib
> 
> If you ever happen to want to link against installed libraries
> in a given directory, LIBDIR, you must either use libtool, and
> specify the full pathname of the library, or use the `-LLIBDIR'
> flag during linking and do at least one of the following:
>    - add LIBDIR to the `LD_LIBRARY_PATH' environment variable
>      during execution
>    - add LIBDIR to the `LD_RUN_PATH' environment variable
>      during linking
>    - use the `-Wl,-rpath -Wl,LIBDIR' linker flag
>    - have your system administrator add LIBDIR to `/etc/ld.so.conf'
> 
> See any operating system documentation about shared libraries for
> more information, such as the ld(1) and ld.so(8) manual pages.
> ----------------------------------------------------------------------
> test -z "/usr/local/share/doc/userspace-rcu" || /bin/mkdir -p
> "/usr/local/share/doc/userspace-rcu"
>  /usr/bin/install -c -m 644 README ChangeLog
> '/usr/local/share/doc/userspace-rcu'
> test -z "/usr/local/include" || /bin/mkdir -p "/usr/local/include"
>  /usr/bin/install -c -m 644 urcu.h urcu-bp.h urcu-call-rcu.h urcu-defer.h
> urcu-pointer.h urcu-qsbr.h urcu-flavor.h '/usr/local/include'
> test -z "/usr/local/include" || /bin/mkdir -p "/usr/local/include"
> /bin/mkdir -p '/usr/local/include/urcu/static'
>  /usr/bin/install -c -m 644  ./urcu/static/lfstack.h
> ./urcu/static/rculfqueue.h ./urcu/static/rculfstack.h
> ./urcu/static/urcu-bp.h ./urcu/static/urcu-pointer.h
> ./urcu/static/urcu-qsbr.h ./urcu/static/urcu.h ./urcu/static/wfcqueue.h
> ./urcu/static/wfqueue.h ./urcu/static/wfstack.h
> '/usr/local/include/urcu/static'
> /bin/mkdir -p '/usr/local/include/urcu/map'
>  /usr/bin/install -c -m 644  ./urcu/map/urcu-bp.h ./urcu/map/urcu-qsbr.h
> ./urcu/map/urcu.h '/usr/local/include/urcu/map'
> /bin/mkdir -p '/usr/local/include/urcu/arch'
> /usr/bin/install -c -m 644  urcu/arch/generic.h
> '/usr/local/include/urcu/arch'
> /bin/mkdir -p '/usr/local/include/urcu/uatomic'
>  /usr/bin/install -c -m 644  urcu/uatomic/generic.h
> '/usr/local/include/urcu/uatomic'
> /bin/mkdir -p '/usr/local/include/urcu'
>  /usr/bin/install -c -m 644  urcu/compiler.h urcu/hlist.h urcu/list.h
> urcu/rculist.h urcu/rcuhlist.h urcu/system.h urcu/futex.h urcu/wfstack.h
> urcu/wfqueue.h urcu/rculfstack.h urcu/rculfqueue.h urcu/ref.h urcu/cds.h
> urcu/urcu_ref.h urcu/urcu-futex.h urcu/uatomic_arch.h urcu/rculfhash.h
> urcu/wfcqueue.h urcu/lfstack.h urcu/tls-compat.h '/usr/local/include/urcu'
> test -z "/usr/local/include" || /bin/mkdir -p "/usr/local/include"
> /bin/mkdir -p '/usr/local/include/urcu'
> /usr/bin/install -c -m 644  urcu/arch.h urcu/uatomic.h urcu/config.h
> '/usr/local/include/urcu'
> test -z "/usr/local/lib/pkgconfig" || /bin/mkdir -p
> "/usr/local/lib/pkgconfig"
> /usr/bin/install -c -m 644 liburcu-cds.pc liburcu.pc liburcu-bp.pc
> liburcu-qsbr.pc liburcu-signal.pc liburcu-mb.pc '/usr/local/lib/pkgconfig'
> make[2]: Leaving directory `/usr/src/LTTng/userspace-rcu'
> make[1]: Leaving directory `/usr/src/LTTng/userspace-rcu'
> Making install in doc
> make[1]: Entering directory `/usr/src/LTTng/userspace-rcu/doc'
> make[2]: Entering directory `/usr/src/LTTng/userspace-rcu/doc'
> make[2]: Nothing to be done for `install-exec-am'.
> test -z "/usr/local/share/doc/userspace-rcu" || /bin/mkdir -p
> "/usr/local/share/doc/userspace-rcu"
> /usr/bin/install -c -m 644 rcu-api.txt cds-api.txt uatomic-api.txt
> '/usr/local/share/doc/userspace-rcu'
> make[2]: Leaving directory `/usr/src/LTTng/userspace-rcu/doc'
> make[1]: Leaving directory `/usr/src/LTTng/userspace-rcu/doc'
> Making install in tests
> make[1]: Entering directory `/usr/src/LTTng/userspace-rcu/tests'
> make[2]: Entering directory `/usr/src/LTTng/userspace-rcu/tests'
> make[2]: Nothing to be done for `install-exec-am'.
> make[2]: Nothing to be done for `install-data-am'.
> make[2]: Leaving directory `/usr/src/LTTng/userspace-rcu/tests'
> make[1]: Leaving directory `/usr/src/LTTng/userspace-rcu/tests'
> 
> userspace-rcu # ldconfig
> 
> STEP3:
> #git clone http://git.lttng.org/lttng-ust.git
> #cd lttng-ust
> lttng-ust # git checkout master
> Already on 'master'
> 
> lttng-ust # ./bootstrap
> + '[' '!' -e config ']'
> + autoreconf -i
> 
> lttng-ust # ./configure
> checking build system type... i686-pc-linux-gnu
> checking host system type... i686-pc-linux-gnu
> checking target system type... i686-pc-linux-gnu
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether build environment is sane... yes
> checking for a thread-safe mkdir -p... /bin/mkdir -p
> checking for gawk... gawk
> checking whether make sets $(MAKE)... yes
> checking for a sed that does not truncate output... /bin/sed
> checking for grep that handles long lines and -e... /bin/grep
> checking for occurence(s) of link_all_deplibs = no in
> ./config/libtool.m4... none
> checking for gcc... gcc
> checking whether the C compiler works... yes
> checking for C compiler default output file name... a.out
> .checking for suffix of executables...
> checking whether we are cross compiling... no
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether gcc accepts -g... yes
> checking for gcc option to accept ISO C89... none needed
> checking for style of include used by make... GNU
> checking dependency style of gcc... gcc3
> checking for g++... g++
> checking whether we are using the GNU C++ compiler... yes
> checking whether g++ accepts -g... yes
> checking dependency style of g++... gcc3
> checking whether make sets $(MAKE)... (cached) yes
> checking how to print strings... printf
> checking for a sed that does not truncate output... (cached) /bin/sed
> checking for egrep... /bin/grep -E
> checking for fgrep... /bin/grep -F
> checking for ld used by gcc... /usr/i686-pc-linux-gnu/bin/ld
> checking if the linker (/usr/i686-pc-linux-gnu/bin/ld) is GNU ld... yes
> checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
> checking the name lister (/usr/bin/nm -B) interface... BSD nm
> checking whether ln -s works... yes
> checking the maximum length of command line arguments... 1572864
> checking whether the shell understands some XSI constructs... yes
> checking whether the shell understands "+="... yes
> checking for /usr/i686-pc-linux-gnu/bin/ld option to reload object files...
> -r
> checking for objdump... objdump
> checking how to recognize dependent libraries... pass_all
> checking for ar... ar
> checking for strip... strip
> checking for ranlib... ranlib
> checking command to parse /usr/bin/nm -B output from gcc object... ok
> checking how to run the C preprocessor... gcc -E
> checking for ANSI C header files... yes
> checking for sys/types.h... yes
> checking for sys/stat.h... yes
> checking for stdlib.h... yes
> checking for string.h... yes
> checking for memory.h... yes
> checking for strings.h... yes
> checking for inttypes.h... yes
> checking for stdint.h... yes
> checking for unistd.h... yes
> checking for dlfcn.h... yes
> checking for objdir... .libs
> checking if gcc supports -fno-rtti -fno-exceptions... no
> checking for gcc option to produce PIC... -fPIC -DPIC
> checking if gcc PIC flag -fPIC -DPIC works... yes
> checking if gcc static flag -static works... yes
> checking if gcc supports -c -o file.o... yes
> checking if gcc supports -c -o file.o... (cached) yes
> checking whether the gcc linker (/usr/i686-pc-linux-gnu/bin/ld) supports
> shared libraries... yes
> checking whether -lc should be explicitly linked in... no
> checking dynamic linker characteristics... GNU/Linux ld.so
> checking how to hardcode library paths into programs... immediate
> checking whether stripping libraries is possible... yes
> checking if libtool supports shared libraries... yes
> checking whether to build shared libraries... yes
> checking whether to build static libraries... yes
> checking how to run the C++ preprocessor... g++ -E
> checking for ld used by g++... /usr/i686-pc-linux-gnu/bin/ld
> checking if the linker (/usr/i686-pc-linux-gnu/bin/ld) is GNU ld... yes
> checking whether the g++ linker (/usr/i686-pc-linux-gnu/bin/ld) supports
> shared libraries... yes
> checking for g++ option to produce PIC... -fPIC -DPIC
> checking if g++ PIC flag -fPIC -DPIC works... yes
> checking if g++ static flag -static works... yes
> checking if g++ supports -c -o file.o... yes
> checking if g++ supports -c -o file.o... (cached) yes
> checking whether the g++ linker (/usr/i686-pc-linux-gnu/bin/ld) supports
> shared libraries... yes
> checking dynamic linker characteristics... (cached) GNU/Linux ld.so
> checking how to hardcode library paths into programs... immediate
> checking whether the C++ compiler works... yes
> checking for dlopen in -ldl... yes
> checking for pthread_create in -lpthread... yes
> checking for uuid_generate in -luuid... yes
> checking for inline... inline
> checking for stdlib.h... (cached) yes
> checking for GNU libc compatible malloc... yes
> checking for gettimeofday... yes checking for munmap... yes
> checking for socket... yes
> checking for strerror... yes
> checking for strtol... yes
> checking for sched_getcpu... yes
> checking for sysconf... yes
> checking urcu-bp.h usability... yes
> checking urcu-bp.h presence... yes
> checking for urcu-bp.h... yes
> checking for _cds_lfht_new in -lurcu-cds... yes
> checking caa_likely()... yes
> checking for synchronize_rcu_bp in -lurcu-bp... no
> configure: error: Cannot find liburcu-bp lib. Use LDFLAGS=-Ldir to specify
> its location.
> 
> Why this error?
> Is LTTng-ust not stabile?
> Kind regards.
> Vanni Genua

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
