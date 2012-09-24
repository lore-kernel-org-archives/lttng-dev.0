From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: unable to detect library format
	(unsupported	architecture (armv7l)
Date: Mon, 24 Sep 2012 07:33:33 -0400
Message-ID: <20120924113333.GA26574__20240.759131457$1348486446$gmane$org@Krystal>
References: <CA+Kk8Ns_q-yeT9LWAB3s5UY=uhObkUbCWX8_MCy7n_5ni696zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TG6uu-0000qI-3T
	for lttng-dev@lists.lttng.org; Mon, 24 Sep 2012 07:33:36 -0400
Content-Disposition: inline
In-Reply-To: <CA+Kk8Ns_q-yeT9LWAB3s5UY=uhObkUbCWX8_MCy7n_5ni696zQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: meher chaitanya <meher.146@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* meher chaitanya (meher.146@gmail.com) wrote:
> root@lttng:/home/ltt/lttng-ust-2.0.4# ./configure
> checking build system type... armv7l-unknown-linux-gnueabi
> checking host system type... armv7l-unknown-linux-gnueabi
> checking target system type... armv7l-unknown-linux-gnueabi
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether build environment is sane... yes
> checking for a thread-safe mkdir -p... /bin/mkdir -p
> checking for gawk... no
> checking for mawk... mawk
> checking whether make sets $(MAKE)... yes
> checking whether make supports nested variables... yes
> checking for a sed that does not truncate output... /bin/sed
> checking for gcc... gcc
> checking whether the C compiler works... yes
> checking for C compiler default output file name... a.out
> checking for suffix of executables...
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
> checking for grep that handles long lines and -e... /bin/grep
> checking for egrep... /bin/grep -E
> checking for fgrep... /bin/grep -F
> checking for ld used by gcc... /usr/bin/ld
> checking if the linker (/usr/bin/ld) is GNU ld... yes
> checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
> checking the name lister (/usr/bin/nm -B) interface... BSD nm
> checking whether ln -s works... yes
> checking the maximum length of command line arguments... 1572864
> checking whether the shell understands some XSI constructs... yes
> checking whether the shell understands "+="... yes
> checking how to convert armv7l-unknown-linux-gnueabi file names to
> armv7l-unknown-linux-gnueabi format... func_convert_file_noop
> checking how to convert armv7l-unknown-linux-gnueabi file names to
> toolchain format... func_convert_file_noop
> checking for /usr/bin/ld option to reload object files... -r
> checking for objdump... objdump
> checking how to recognize dependent libraries... pass_all
> checking for dlltool... no
> checking how to associate runtime and link libraries... printf %s\n
> checking for ar... ar
> checking for archiver @FILE support... @
> checking for strip... strip
> checking for ranlib... ranlib
> checking command to parse /usr/bin/nm -B output from gcc object... ok
> checking for sysroot... no
> checking for mt... mt
> checking if mt is a manifest tool... no
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
> checking whether the gcc linker (/usr/bin/ld) supports shared libraries...
> yes
> checking whether -lc should be explicitly linked in... no
> checking dynamic linker characteristics... GNU/Linux ld.so
> checking how to hardcode library paths into programs... immediate
> checking whether stripping libraries is possible... yes
> checking if libtool supports shared libraries... yes
> checking whether to build shared libraries... yes
> checking whether to build static libraries... yes
> checking how to run the C++ preprocessor... g++ -E
> checking for ld used by g++... /usr/bin/ld
> checking if the linker (/usr/bin/ld) is GNU ld... yes
> checking whether the g++ linker (/usr/bin/ld) supports shared libraries...
> yes
> checking for g++ option to produce PIC... -fPIC -DPIC
> checking if g++ PIC flag -fPIC -DPIC works... yes
> checking if g++ static flag -static works... yes
> checking if g++ supports -c -o file.o... yes
> checking if g++ supports -c -o file.o... (cached) yes
> checking whether the g++ linker (/usr/bin/ld) supports shared libraries...
> yes
> checking dynamic linker characteristics... (cached) GNU/Linux ld.so
> checking how to hardcode library paths into programs... immediate
> checking for dlopen in -ldl... yes
> checking for pthread_create in -lpthread... yes
> checking for uuid_generate in -luuid... yes
> checking for inline... inline
> checking for stdlib.h... (cached) yes
> checking for GNU libc compatible malloc... yes
> checking for gettimeofday... yes
> checking for munmap... yes
> checking for socket... yes
> checking for strerror... yes
> checking for strtol... yes
> checking for sched_getcpu... yes
> checking for sysconf... yes
> checking for makeinfo... yes
> checking urcu-bp.h usability... yes
> checking urcu-bp.h presence... yes
> checking for urcu-bp.h... yes
> checking caa_likely()... yes
> checking for synchronize_rcu_bp in -lurcu-bp... yes
> checking for call_rcu_bp in -lurcu-bp... yes
> checking library format for the host system... configure: error: unable to
> detect library format (unsupported architecture (armv7l)?)
> 
> 
> In the configure.ac file i had made an entry for arm7l but even then i am
> seeing this error . I am doing this on my target machine . can anyone help
> me with this??

There is a fix for cross-compiling in lttng-ust 2.0.5. Please upgrade.
Refer to the Changelog for details,

Thanks,

Mathieu


> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
