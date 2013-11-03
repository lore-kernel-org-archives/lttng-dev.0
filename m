From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: bug in urcu
Date: Sun, 3 Nov 2013 14:13:52 +0000 (UTC)
Message-ID: <1667340498.55993.1383488032176.JavaMail.zimbra__18128.10985507$1383488084$gmane$org@efficios.com>
References: <5738160F-42EA-4A55-A14B-EF6FAEE94370@tbricks.com>
	<6644DF0F-88BA-4092-825C-ABBA2A81FD97@tbricks.com>
	<31742818.47278.1382421362600.JavaMail.zimbra@efficios.com>
	<8EF7F1B0-56D0-4209-ADBA-D7C9852537D8@tbricks.com>
	<1732913493.55082.1383313336612.JavaMail.zimbra@efficios.com>
	<762373048.55095.1383314114453.JavaMail.zimbra@efficios.com>
	<1062453941.55297.1383337139657.JavaMail.zimbra@efficios.com>
	<20131103140359.GE3947@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VcyRC-0005uV-6V
	for lttng-dev@lists.lttng.org; Sun, 03 Nov 2013 09:14:01 -0500
In-Reply-To: <20131103140359.GE3947@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: paulmck@linux.vnet.ibm.com
Cc: lttng-dev@lists.lttng.org, Vladimir Nikulichev <nvs@tbricks.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "Vladimir Nikulichev" <nvs@tbricks.com>, lttng-dev@lists.lttng.org
> Sent: Sunday, November 3, 2013 9:03:59 AM
> Subject: Re: [lttng-dev] bug in urcu
> 
> On Fri, Nov 01, 2013 at 08:18:59PM +0000, Mathieu Desnoyers wrote:
> > ----- Original Message -----
> > > From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > > To: "Vladimir Nikulichev" <nvs@tbricks.com>
> > > Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney"
> > > <paulmck@linux.vnet.ibm.com>
> > > Sent: Friday, November 1, 2013 9:55:14 AM
> > > Subject: Re: [lttng-dev] bug in urcu
> > > 
> > > ----- Original Message -----
> > > > From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > > > To: "Vladimir Nikulichev" <nvs@tbricks.com>
> > > > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > > > Sent: Friday, November 1, 2013 9:42:16 AM
> > > > Subject: Re: bug in urcu
> > > > 
> > > > ----- Original Message -----
> > > > > From: "Vladimir Nikulichev" <nvs@tbricks.com>
> > > > > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > > > > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > > > > Sent: Tuesday, October 22, 2013 1:32:11 PM
> > > > > Subject: Re: bug in urcu
> > > > > 
> > > > > > 
> > > > > > It looks like an issue with the thread-local storage (TLS)
> > > > > > compatibility
> > > > > > layer.
> > > > > > 
> > > > > > Can you show me the output of ./configure on that machine ? I'm
> > > > > > especially
> > > > > > interested in the output of:
> > > > > > 
> > > > > > Thread Local Storage (TLS): __thread.     (example on my machine)
> > > > > 
> > > > > It uses pthread_getspecific() by default:
> > > > 
> > > > Good catch!
> > > > 
> > > > looking at the output of
> > > > 
> > > > nm tests/unit/.libs/test_urcu_multiflavor :
> > > > 
> > > >                  U __tls_access_rcu_reader
> > > > 
> > > > seems to be the issue. We're missing macro expansion in tls-compat.h.
> > > > With
> > > > the patch attached:
> > > > 
> > > >                  U __tls_access_rcu_reader_bp
> > > >                  U __tls_access_rcu_reader_mb
> > > >                  U __tls_access_rcu_reader_memb
> > > >                  U __tls_access_rcu_reader_sig
> > > > 
> > > > which should fix your issue. Can you try it out and let me know if it
> > > > fixes
> > > > your problem ?
> > > 
> > > Extra question (Paul ? Adding lttng-dev in CC):
> > > 
> > > Please note that this affects an unusual configuration of userspace RCU
> > > (with TLS pthread key fallback), needed for some BSD that don't support
> > > compiler TLS. Strictly speaking, this should require bumping the URCU
> > > library soname version major number, because it breaks the ABI presented
> > > to applications on those unusual configurations. However, since this is
> > > only for unusual configurations, I wonder if we should bump the soname
> > > version major number or not ? If we do need to bump the soname, can we
> > > really do this in a stable version fix (0.7, 0.8), or do we need to push
> > > a 0.9 out and document the limitation for 0.7 and 0.8 ?
> > 
> > I just found a way to keep ABI compatibility for 0.7 and 0.8, and abort()
> > the application if it's using the old ABI (with symbol clash) when there
> > are multiple instances of this symbol loaded. This involves tricks with
> > weak symbols, a constructor, a reference count, and a wrapper around the
> > bogus symbol, but it works !! Note that it only affects users of urcu that
> > have _LGPL_SOURCE defined.
> 
> Sounds good to me!  ;-)
> 
> I trust that you have also added copious comments...

Yes, especially within the 0.7 and 0.8 branches, within urcu/tls-compat.h:

/*
 * The *_1() macros ensure macro parameters are expanded.
 *
 * __DEFINE_URCU_TLS_GLOBAL and __URCU_TLS_CALL exist for the sole
 * purpose of notifying applications compiled against non-fixed 0.7 and
 * 0.8 userspace RCU headers and using multiple flavors concurrently to
 * recompile against fixed userspace RCU headers.
 */

as well as

/*
 * Define with and without macro expansion to handle erroneous callers.
 * Trigger an abort() if the caller application uses the clashing symbol
 * if a weak symbol is overridden.
 */

For the master branch, I added a much simpler comment:

/*
 * The *_1() macros ensure macro parameters are expanded.
 */

Thanks,

Mathieu

> 
> 							Thanx, Paul
> 
> > > > > checking whether gcc accepts -g... (cached) yes
> > > > > checking for gcc option to accept ISO C89... (cached) none needed
> > > > > checking whether gcc understands -c and -o together... (cached) yes
> > > > > checking dependency style of gcc... (cached) gcc3
> > > > > checking whether make sets $(MAKE)... (cached) yes
> > > > > checking how to print strings... printf
> > > > > checking for a sed that does not truncate output... /usr/bin/sed
> > > > > checking for grep that handles long lines and -e... /usr/bin/grep
> > > > > checking for egrep... /usr/bin/grep -E
> > > > > checking for fgrep... /usr/bin/grep -F
> > > > > checking for ld used by gcc...
> > > > > /usr/llvm-gcc-4.2/libexec/gcc/i686-apple-darwin11/4.2.1/ld
> > > > > checking if the linker
> > > > > (/usr/llvm-gcc-4.2/libexec/gcc/i686-apple-darwin11/4.2.1/ld) is GNU
> > > > > ld...
> > > > > no
> > > > > checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm
> > > > > checking the name lister (/usr/bin/nm) interface... BSD nm
> > > > > checking whether ln -s works... yes
> > > > > checking the maximum length of command line arguments... 196608
> > > > > checking whether the shell understands some XSI constructs... yes
> > > > > checking whether the shell understands "+="... yes
> > > > > checking how to convert x86_64-apple-darwin12.5.0 file names to
> > > > > x86_64-apple-darwin12.5.0 format... func_convert_file_noop
> > > > > checking how to convert x86_64-apple-darwin12.5.0 file names to
> > > > > toolchain
> > > > > format... func_convert_file_noop
> > > > > checking for
> > > > > /usr/llvm-gcc-4.2/libexec/gcc/i686-apple-darwin11/4.2.1/ld
> > > > > option to reload object files... -r
> > > > > checking for objdump... no
> > > > > checking how to recognize dependent libraries... pass_all
> > > > > checking for dlltool... no
> > > > > checking how to associate runtime and link libraries... printf %s\n
> > > > > checking for ar... ar
> > > > > checking for archiver @FILE support... no
> > > > > checking for strip... strip
> > > > > checking for ranlib... ranlib
> > > > > checking command to parse /usr/bin/nm output from gcc object... ok
> > > > > checking for sysroot... no
> > > > > checking for mt... no
> > > > > checking if : is a manifest tool... no
> > > > > checking for dsymutil... dsymutil
> > > > > checking for nmedit... nmedit
> > > > > checking for lipo... lipo
> > > > > checking for otool... otool
> > > > > checking for otool64... no
> > > > > checking for -single_module linker flag... yes
> > > > > checking for -exported_symbols_list linker flag... yes
> > > > > checking for -force_load linker flag... yes
> > > > > checking how to run the C preprocessor... gcc -E
> > > > > checking for ANSI C header files... yes
> > > > > checking for sys/types.h... yes
> > > > > checking for sys/stat.h... yes
> > > > > checking for stdlib.h... yes
> > > > > checking for string.h... yes
> > > > > checking for memory.h... yes
> > > > > checking for strings.h... yes
> > > > > checking for inttypes.h... yes
> > > > > checking for stdint.h... yes
> > > > > checking for unistd.h... yes
> > > > > checking for dlfcn.h... yes
> > > > > checking for objdir... .libs
> > > > > checking if gcc supports -fno-rtti -fno-exceptions... no
> > > > > checking for gcc option to produce PIC... -fno-common -DPIC
> > > > > checking if gcc PIC flag -fno-common -DPIC works... yes
> > > > > checking if gcc static flag -static works... no
> > > > > checking if gcc supports -c -o file.o... yes
> > > > > checking if gcc supports -c -o file.o... (cached) yes
> > > > > checking whether the gcc linker
> > > > > (/usr/llvm-gcc-4.2/libexec/gcc/i686-apple-darwin11/4.2.1/ld) supports
> > > > > shared
> > > > > libraries... yes
> > > > > checking dynamic linker characteristics... darwin12.5.0 dyld
> > > > > checking how to hardcode library paths into programs... immediate
> > > > > checking whether stripping libraries is possible... yes
> > > > > checking if libtool supports shared libraries... yes
> > > > > checking whether to build shared libraries... yes
> > > > > checking whether to build static libraries... yes
> > > > > checking for inline... inline
> > > > > checking for pid_t... yes
> > > > > checking for size_t... yes
> > > > > checking for stdlib.h... (cached) yes
> > > > > checking for GNU libc compatible malloc... yes
> > > > > checking for stdlib.h... (cached) yes
> > > > > checking for unistd.h... (cached) yes
> > > > > checking for sys/param.h... yes
> > > > > checking for getpagesize... yes
> > > > > checking for working mmap... yes
> > > > > checking for bzero... yes
> > > > > checking for gettimeofday... yes
> > > > > checking for munmap... yes
> > > > > checking for sched_getcpu... no
> > > > > checking for strtoul... yes
> > > > > checking for sysconf... yes
> > > > > checking if architecture really supports the mfence instruction...
> > > > > yes
> > > > > checking for sys_futex()... no
> > > > > checking for cpu_set_t... no
> > > > > checking whether CPU_ZERO works... no
> > > > > checking whether CPU_SET works... no
> > > > > checking for sched_setaffinity... no
> > > > > checking that generated files are newer than configure... done
> > > > > configure: creating ./config.status
> > > > > config.status: creating Makefile
> > > > > config.status: creating doc/Makefile
> > > > > config.status: creating doc/examples/Makefile
> > > > > config.status: creating tests/Makefile
> > > > > config.status: creating tests/common/Makefile
> > > > > config.status: creating tests/unit/Makefile
> > > > > config.status: creating tests/benchmark/Makefile
> > > > > config.status: creating tests/regression/Makefile
> > > > > config.status: creating liburcu.pc
> > > > > config.status: creating liburcu-bp.pc
> > > > > config.status: creating liburcu-cds.pc
> > > > > config.status: creating liburcu-qsbr.pc
> > > > > config.status: creating liburcu-mb.pc
> > > > > config.status: creating liburcu-signal.pc
> > > > > config.status: creating config.h
> > > > > config.status: creating urcu/config.h
> > > > > config.status: linking urcu/arch/x86.h to urcu/arch.h
> > > > > config.status: linking urcu/uatomic/x86.h to urcu/uatomic.h
> > > > > config.status: executing depfiles commands
> > > > > config.status: executing libtool commands
> > > > > SMP support enabled.
> > > > > Thread Local Storage (TLS): pthread_getspecific().
> > > > > 
> > > > > 
> > > > > 
> > > > > It seems to be another object file/static data issue. When it works
> > > > > with
> > > > > rcu_reader, it first initializes it (pthread_key_create) from
> > > > > liburcu.2,
> > > > > but
> > > > > latter stacks come from liburcu-bp.2.
> > > > > I ran it in debugger with breakpoints at pthread_key_create(),
> > > > > pthread_getspecific(), pthread_setspecific(). Each hit I recorded key
> > > > > numbers, values, etc. First time a library assigns the key number
> > > > > 0x103,
> > > > > second time 0x104.
> > > > > 
> > > > > (lldb) bt
> > > > > * thread #1: tid = 0x1c03, 0x00007fff8a5c0224
> > > > > libsystem_c.dylib`pthread_key_create, stop reason = breakpoint 1.1
> > > > >     frame #0: 0x00007fff8a5c0224 libsystem_c.dylib`pthread_key_create
> > > > >     frame #1: 0x0000000100004cea
> > > > >     liburcu.2.dylib`__tls_access_rcu_reader
> > > > >     +
> > > > >     58
> > > > >     at urcu.c:110
> > > > >     frame #2: 0x0000000100000c5e test_urcu_multiflavor`test_mf_bp
> > > > >     [inlined]
> > > > >     _rcu_read_lock_bp + 10 at urcu-bp.h:210
> > > > >     frame #3: 0x0000000100000c54 test_urcu_multiflavor`test_mf_bp + 4
> > > > >     at
> > > > >     test_urcu_multiflavor-bp.c:34
> > > > >     frame #4: 0x0000000100000989 test_urcu_multiflavor`main() + 9 at
> > > > >     test_urcu_multiflavor.c:44
> > > > >     frame #5: 0x00007fff8d8d67e1 libdyld.dylib`start + 1
> > > > > 
> > > > > (lldb) register read rdi rsi
> > > > >      rdi = 0x0000000100008300  __tls_rcu_reader.5085
> > > > >      rsi = 0x00007fff8a5d2801  libsystem_c.dylib`free
> > > > > 
> > > > > ... continue ...
> > > > > 
> > > > > 
> > > > > (lldb) bt
> > > > > * thread #1: tid = 0x1c03, 0x00007fff8a5a6128
> > > > > libsystem_c.dylib`pthread_getspecific, stop reason = breakpoint 2.1
> > > > >     frame #0: 0x00007fff8a5a6128
> > > > >     libsystem_c.dylib`pthread_getspecific
> > > > >     frame #1: 0x0000000100004d0c
> > > > >     liburcu.2.dylib`__tls_access_rcu_reader
> > > > >     +
> > > > >     92
> > > > >     at urcu.c:110
> > > > >     frame #2: 0x0000000100000c5e test_urcu_multiflavor`test_mf_bp
> > > > >     [inlined]
> > > > >     _rcu_read_lock_bp + 10 at urcu-bp.h:210
> > > > >     frame #3: 0x0000000100000c54 test_urcu_multiflavor`test_mf_bp + 4
> > > > >     at
> > > > >     test_urcu_multiflavor-bp.c:34
> > > > >     frame #4: 0x0000000100000989 test_urcu_multiflavor`main() + 9 at
> > > > >     test_urcu_multiflavor.c:44
> > > > >     frame #5: 0x00007fff8d8d67e1 libdyld.dylib`start + 1
> > > > > (lldb) register read rdi
> > > > >      rdi = 0x0000000000000103
> > > > > 
> > > > > ... continue ...
> > > > > 
> > > > > 
> > > > > (lldb) bt
> > > > > * thread #1: tid = 0x1c03, 0x00007fff8a5c03a0
> > > > > libsystem_c.dylib`pthread_setspecific, stop reason = breakpoint 3.1
> > > > >     frame #0: 0x00007fff8a5c03a0
> > > > >     libsystem_c.dylib`pthread_setspecific
> > > > >     frame #1: 0x0000000100004d32
> > > > >     liburcu.2.dylib`__tls_access_rcu_reader
> > > > >     +
> > > > >     130 at urcu.c:110
> > > > >     frame #2: 0x0000000100000c5e test_urcu_multiflavor`test_mf_bp
> > > > >     [inlined]
> > > > >     _rcu_read_lock_bp + 10 at urcu-bp.h:210
> > > > >     frame #3: 0x0000000100000c54 test_urcu_multiflavor`test_mf_bp + 4
> > > > >     at
> > > > >     test_urcu_multiflavor-bp.c:34
> > > > >     frame #4: 0x0000000100000989 test_urcu_multiflavor`main() + 9 at
> > > > >     test_urcu_multiflavor.c:44
> > > > >     frame #5: 0x00007fff8d8d67e1 libdyld.dylib`start + 1
> > > > > 
> > > > > 
> > > > > (lldb) register read rdi rsi
> > > > >      rdi = 0x0000000000000103
> > > > >      rsi = 0x00000001001038d0
> > > > > 
> > > > > ... continue ...
> > > > > 
> > > > > 
> > > > > (lldb) bt
> > > > > * thread #1: tid = 0x1c03, 0x00007fff8a5c0224
> > > > > libsystem_c.dylib`pthread_key_create, stop reason = breakpoint 1.1
> > > > >     frame #0: 0x00007fff8a5c0224 libsystem_c.dylib`pthread_key_create
> > > > >     frame #1: 0x00000001000288ca
> > > > >     liburcu-bp.2.dylib`__tls_access_rcu_reader
> > > > >     +
> > > > >     58 at urcu-bp.c:117
> > > > >     frame #2: 0x0000000100029bc5 liburcu-bp.2.dylib`rcu_bp_register +
> > > > >     53
> > > > >     at
> > > > >     urcu-bp.c:483
> > > > >     frame #3: 0x0000000100000c69 test_urcu_multiflavor`test_mf_bp
> > > > >     [inlined]
> > > > >     _rcu_read_lock_bp + 21 at urcu-bp.h:211
> > > > >     frame #4: 0x0000000100000c54 test_urcu_multiflavor`test_mf_bp + 4
> > > > >     at
> > > > >     test_urcu_multiflavor-bp.c:34
> > > > >     frame #5: 0x0000000100000989 test_urcu_multiflavor`main() + 9 at
> > > > >     test_urcu_multiflavor.c:44
> > > > >     frame #6: 0x00007fff8d8d67e1 libdyld.dylib`start + 1
> > > > > 
> > > > > 
> > > > > static/urcu-bp.h:
> > > > > 206 static inline void _rcu_read_lock(void)
> > > > > 207 {
> > > > > 208     unsigned long tmp;
> > > > > 209
> > > > > 210     if (caa_unlikely(!URCU_TLS(rcu_reader)))
> > > > > 211         rcu_bp_register(); /* If not yet registered. */
> > > > > 212     cmm_barrier();  /* Ensure the compiler does not reorder us
> > > > > with
> > > > > mutex
> > > > > */
> > > > > 213     tmp = URCU_TLS(rcu_reader)->ctr;
> > > > > 214     _rcu_read_lock_update(tmp);
> > > > > 215 }
> > > > > 
> > > > > 
> > > > > ... continue ...
> > > > > 
> > > > > 
> > > > > (lldb) bt
> > > > > * thread #1: tid = 0x1c03, 0x00007fff8a5a6131
> > > > > libsystem_c.dylib`pthread_getspecific + 9, stop reason = instruction
> > > > > step
> > > > > over
> > > > >     frame #0: 0x00007fff8a5a6131
> > > > >     libsystem_c.dylib`pthread_getspecific +
> > > > >     9
> > > > >     frame #1: 0x00000001000288ec
> > > > >     liburcu-bp.2.dylib`__tls_access_rcu_reader
> > > > >     +
> > > > >     92 at urcu-bp.c:117
> > > > >     frame #2: 0x0000000100029bc5 liburcu-bp.2.dylib`rcu_bp_register +
> > > > >     53
> > > > >     at
> > > > >     urcu-bp.c:483
> > > > >     frame #3: 0x0000000100000c69 test_urcu_multiflavor`test_mf_bp
> > > > >     [inlined]
> > > > >     _rcu_read_lock_bp + 21 at urcu-bp.h:211
> > > > >     frame #4: 0x0000000100000c54 test_urcu_multiflavor`test_mf_bp + 4
> > > > >     at
> > > > >     test_urcu_multiflavor-bp.c:34
> > > > >     frame #5: 0x0000000100000989 test_urcu_multiflavor`main() + 9 at
> > > > >     test_urcu_multiflavor.c:44
> > > > >     frame #6: 0x00007fff8d8d67e1 libdyld.dylib`start + 1
> > > > > 
> > > > > (lldb) register read rdi
> > > > >      rdi = 0x0000000000000104
> > > > > 
> > > > > ... continue ...
> > > > > 
> > > > > 
> > > > > (lldb) bt
> > > > > * thread #1: tid = 0x1c03, 0x00007fff8a5c03a0
> > > > > libsystem_c.dylib`pthread_setspecific, stop reason = breakpoint 3.1
> > > > >     frame #0: 0x00007fff8a5c03a0
> > > > >     libsystem_c.dylib`pthread_setspecific
> > > > >     frame #1: 0x0000000100028912
> > > > >     liburcu-bp.2.dylib`__tls_access_rcu_reader
> > > > >     +
> > > > >     130 at urcu-bp.c:117
> > > > >     frame #2: 0x0000000100029bc5 liburcu-bp.2.dylib`rcu_bp_register +
> > > > >     53
> > > > >     at
> > > > >     urcu-bp.c:483
> > > > >     frame #3: 0x0000000100000c69 test_urcu_multiflavor`test_mf_bp
> > > > >     [inlined]
> > > > >     _rcu_read_lock_bp + 21 at urcu-bp.h:211
> > > > >     frame #4: 0x0000000100000c54 test_urcu_multiflavor`test_mf_bp + 4
> > > > >     at
> > > > >     test_urcu_multiflavor-bp.c:34
> > > > >     frame #5: 0x0000000100000989 test_urcu_multiflavor`main() + 9 at
> > > > >     test_urcu_multiflavor.c:44
> > > > >     frame #6: 0x00007fff8d8d67e1 libdyld.dylib`start + 1
> > > > > 
> > > > > (lldb) register read rdi rsi
> > > > >      rdi = 0x0000000000000104
> > > > >      rsi = 0x00000001001000e0
> > > > > 
> > > > > ... continue, skip add_thread() ...
> > > > > 
> > > > > 
> > > > > (lldb) bt
> > > > > * thread #1: tid = 0x1c03, 0x00007fff8a5a6128
> > > > > libsystem_c.dylib`pthread_getspecific, stop reason = breakpoint 2.1
> > > > >     frame #0: 0x00007fff8a5a6128
> > > > >     libsystem_c.dylib`pthread_getspecific
> > > > >     frame #1: 0x00000001000288ec
> > > > >     liburcu-bp.2.dylib`__tls_access_rcu_reader
> > > > >     +
> > > > >     92 at urcu-bp.c:117
> > > > >     frame #2: 0x0000000100029e46 liburcu-bp.2.dylib`rcu_bp_register
> > > > >     [inlined]
> > > > >     add_thread + 470 at urcu-bp.c:425
> > > > >     frame #3: 0x0000000100029c70 liburcu-bp.2.dylib`rcu_bp_register +
> > > > >     224
> > > > >     at
> > > > >     urcu-bp.c:492
> > > > >     frame #4: 0x0000000100000c69 test_urcu_multiflavor`test_mf_bp
> > > > >     [inlined]
> > > > >     _rcu_read_lock_bp + 21 at urcu-bp.h:211
> > > > >     frame #5: 0x0000000100000c54 test_urcu_multiflavor`test_mf_bp + 4
> > > > >     at
> > > > >     test_urcu_multiflavor-bp.c:34
> > > > >     frame #6: 0x0000000100000989 test_urcu_multiflavor`main() + 9 at
> > > > >     test_urcu_multiflavor.c:44
> > > > >     frame #7: 0x00007fff8d8d67e1 libdyld.dylib`start + 1
> > > > > 
> > > > > (lldb) register read rdi
> > > > >      rdi = 0x0000000000000104
> > > > > 
> > > > > (lldb) n
> > > > > Process 59961 stopped
> > > > > * thread #1: tid = 0x1c03, 0x00007fff8a5a6131
> > > > > libsystem_c.dylib`pthread_getspecific + 9, stop reason = instruction
> > > > > step
> > > > > over
> > > > >     frame #0: 0x00007fff8a5a6131
> > > > >     libsystem_c.dylib`pthread_getspecific +
> > > > >     9
> > > > > libsystem_c.dylib`pthread_getspecific + 9:
> > > > > -> 0x7fff8a5a6131:  ret
> > > > > 
> > > > > (lldb) register read rax
> > > > >      rax = 0x00000001001000e0
> > > > > 
> > > > > ... next ...
> > > > > -> 425      URCU_TLS(rcu_reader) = rcu_reader_reg;
> > > > > ... next ...
> > > > > ... continue ...
> > > > > 
> > > > > 
> > > > > (lldb) bt
> > > > > * thread #1: tid = 0x1c03, 0x00007fff8a5a6128
> > > > > libsystem_c.dylib`pthread_getspecific, stop reason = breakpoint 2.1
> > > > >     frame #0: 0x00007fff8a5a6128
> > > > >     libsystem_c.dylib`pthread_getspecific
> > > > >     frame #1: 0x0000000100004d0c
> > > > >     liburcu.2.dylib`__tls_access_rcu_reader
> > > > >     +
> > > > >     92
> > > > >     at urcu.c:110
> > > > >     frame #2: 0x0000000100000c6e test_urcu_multiflavor`test_mf_bp
> > > > >     [inlined]
> > > > >     _rcu_read_lock_bp + 26 at urcu-bp.h:213
> > > > >     frame #3: 0x0000000100000c54 test_urcu_multiflavor`test_mf_bp + 4
> > > > >     at
> > > > >     test_urcu_multiflavor-bp.c:34
> > > > >     frame #4: 0x0000000100000989 test_urcu_multiflavor`main() + 9 at
> > > > >     test_urcu_multiflavor.c:44
> > > > >     frame #5: 0x00007fff8d8d67e1 libdyld.dylib`start + 1
> > > > > (lldb) register read rdi
> > > > >      rdi = 0x0000000000000103
> > > > > (lldb) c
> > > > > Process 59961 resuming
> > > > > Process 59961 stopped
> > > > > * thread #1: tid = 0x1c03, 0x0000000100000c71
> > > > > test_urcu_multiflavor`test_mf_bp [inlined] _rcu_read_lock_bp + 29 at
> > > > > urcu-bp.h:213, stop reason = EXC_BAD_ACCESS (code=1, address=0x0)
> > > > >     frame #0: 0x0000000100000c71 test_urcu_multiflavor`test_mf_bp
> > > > >     [inlined]
> > > > >     _rcu_read_lock_bp + 29 at urcu-bp.h:213
> > > > >    210      if (caa_unlikely(!URCU_TLS(rcu_reader)))
> > > > >    211          rcu_bp_register(); /* If not yet registered. */
> > > > >    212      cmm_barrier();  /* Ensure the compiler does not reorder
> > > > >    us
> > > > >    with
> > > > >    mutex */
> > > > > -> 213      tmp = URCU_TLS(rcu_reader)->ctr;
> > > > >    214      _rcu_read_lock_update(tmp);
> > > > >    215  }
> > > > >    216
> > > > > 
> > > > > CRASH
> > > > 
> > > > --
> > > > Mathieu Desnoyers
> > > > EfficiOS Inc.
> > > > http://www.efficios.com
> > > > 
> > > 
> > > --
> > > Mathieu Desnoyers
> > > EfficiOS Inc.
> > > http://www.efficios.com
> > > 
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > > 
> > 
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> > 
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
