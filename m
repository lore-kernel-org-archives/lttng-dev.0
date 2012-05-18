From: Vanni Genua <vannigenua@gmail.com>
Subject: Re: HOW TO DOWNLOAD LTTng 2.0 stable?
Date: Fri, 18 May 2012 18:15:23 +0200
Message-ID: <CAO8ONPwa=VA0TrTt4CegO=yXGOPebMQYy1a-jAGn8cxGzymH8Q__31810.491186525$1338865795$gmane$org@mail.gmail.com>
References: <CAO8ONPxd_9JOHLCMdQXqFK9NTPGri8_+nvnU+kJx-6PSgARAKQ@mail.gmail.com>
	<4FB3EDC0.7080006@polymtl.ca>
	<CAO8ONPxm=jvfqTe0Fto1hMFX2xm3XGtRUGyyBuO16Qh9wRoR8g@mail.gmail.com>
	<CAO8ONPyZqAEbbn2k_=YJi_3uFRKNg7TvWcX_ysJoGtzu4z9GYw@mail.gmail.com>
	<CAO8ONPxOYN+01YG8695hgck7-c-8ZoypysH90gx8n9C0jCfKag@mail.gmail.com>
	<4FB50A3E.7030508@polymtl.ca> <20120517143031.GA30839@Krystal>
	<CAO8ONPy5pO5pSL6ywHED0UEtvc7fJLYAr7meghrECp0VDwM-Qw@mail.gmail.com>
	<20120518151850.GA17152@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <vannigenua@gmail.com>) id 1SVPpy-0002VN-21
	for lttng-dev@lists.lttng.org; Fri, 18 May 2012 12:15:30 -0400
Received: by wibhn14 with SMTP id hn14so254501wib.5
	for <lttng-dev@lists.lttng.org>; Fri, 18 May 2012 09:15:24 -0700 (PDT)
In-Reply-To: <20120518151850.GA17152@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Alexandre Montplaisir <alexandre.montplaisir@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

I asked you about the HEAD download (mater and stable2.0),
I found its size was about 180kB, whereas the 2.0.1 was over 500KB.
I also wrote you that the HEAD (master?) missed the configure file, so
it was not possible to run ./configure )
May you post me the exact link where the full HEAD is?
I'm using gcc  4.4.2 (I guess, because now I'm not at the office).
Thanks.
Vanni

On 5/18/12, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> * Vanni Genua (vannigenua@gmail.com) wrote:
>> I did it a minute ago, now the problems are the undefined references at
>> the
>> end of this logs:
>>
>> localhost lttng-ust-2.0.1 # ./configure --build=armv7a-unknown-linux-
>> gnueabi
>
> This looks like a problem with your toolchain (gcc/ld/...), since AFAIK
> Alexandre is able to cross-build for ARMv7 on Ubuntu. You should ask
> your distribution vendor.
>
> Also, you seem to be still using lttng-ust 2.0.1 instead of "HEAD".
> Which commit ID are you using ?
>
> Thanks,
>
> Mathieu
>
>
>
>>
>> checking build system type...
>> armv7a-unknown-linux-gnueabi
>>
>> checking host system type...
>> armv7a-unknown-linux-gnueabi
>>
>> checking target system type...
>> armv7a-unknown-linux-gnueabi
>>
>> checking how to convert armv7a-unknown-linux-gnueabi file names to
>> armv7a-unknown-linux-gnueabi format...
>> func_convert_file_noop
>> checking how to convert armv7a-unknown-linux-gnueabi file names to
>> toolchain format...
>> func_convert_file_noop
>> checking library format for the host system...
>> elf32-littlearm
>>
>> configure: creating
>> ./config.status
>>
>> config.status: creating
>> Makefile
>>
>> config.status: creating
>> doc/Makefile
>>
>> config.status: creating
>> doc/examples/Makefile
>>
>> config.status: creating
>> include/Makefile
>>
>> config.status: creating
>> include/lttng/ust-version.h
>>
>> config.status: creating
>> snprintf/Makefile
>>
>> config.status: creating
>> libringbuffer/Makefile
>>
>> config.status: creating
>> liblttng-ust-comm/Makefile
>>
>> config.status: creating
>> liblttng-ust/Makefile
>>
>> config.status: creating
>> liblttng-ust-ctl/Makefile
>>
>> config.status: creating
>> liblttng-ust-fork/Makefile
>>
>> config.status: creating
>> liblttng-ust-java/Makefile
>>
>> config.status: creating
>> liblttng-ust-libc-wrapper/Makefile
>>
>> config.status: creating
>> tools/Makefile
>>
>> config.status: creating
>> tests/Makefile
>>
>> config.status: creating
>> tests/hello/Makefile
>>
>> config.status: creating
>> tests/hello-static-lib/Makefile
>>
>> config.status: creating
>> tests/hello.cxx/Makefile
>>
>> config.status: creating
>> tests/demo/Makefile
>>
>> config.status: creating
>> tests/fork/Makefile
>>
>> config.status: creating
>> tests/ust-basic-tracing/Makefile
>>
>> config.status: creating
>> tests/ust-multi-test/Makefile
>>
>> config.status: creating
>> lttng-ust.pc
>>
>> config.status: creating
>> config.h
>>
>> config.status: config.h is
>> unchanged
>>
>> config.status: creating
>> include/lttng/ust-config.h
>>
>> config.status: include/lttng/ust-config.h is
>> unchanged
>>
>> config.status: executing depfiles
>> commands
>>
>> config.status: executing libtool
>> commands
>>
>>
>>
>> Version name:
>> Annedd'ale
>>
>> New type of beer, 100% from Quebec, flavored with sapin beaumier needles,
>> with a touch of
>> hops.
>>
>>
>> LTTng-UST will be built with the following
>> options:
>>
>> Library format:
>> elf32-littlearm
>>
>>
>>
>> Java support (JNI):
>> Disabled
>>
>> sdt.h integration:
>> Disabled
>>
>>
>>
>> Type 'make' to
>> compile.
>>
>> localhost lttng-ust-2.0.1 #
>> make
>>
>> make
>> all-recursive
>>
>> make[1]: Entering directory
>> `/usr/src/lttng-ust-2.0.1'
>>
>> Making all in
>> .
>>
>> make[2]: Entering directory
>> `/usr/src/lttng-ust-2.0.1'
>>
>> make[2]: Leaving directory
>> `/usr/src/lttng-ust-2.0.1'
>>
>> Making all in
>> include
>>
>> make[2]: Entering directory
>> `/usr/src/lttng-ust-2.0.1/include'
>>
>> make[2]: Nothing to be done for
>> `all'.
>>
>> make[2]: Leaving directory
>> `/usr/src/lttng-ust-2.0.1/include'
>>
>> Making all in
>> snprintf
>>
>> make[2]: Entering directory
>> `/usr/src/lttng-ust-2.0.1/snprintf'
>>
>> make[2]: Nothing to be done for
>> `all'.
>>
>> make[2]: Leaving directory
>> `/usr/src/lttng-ust-2.0.1/snprintf'
>>
>> Making all in
>> libringbuffer
>>
>> make[2]: Entering directory
>> `/usr/src/lttng-ust-2.0.1/libringbuffer'
>>
>>   CC
>> libringbuffer_la-ring_buffer_backend.lo
>>
>>   CC
>> libringbuffer_la-ring_buffer_frontend.lo
>>
>>   CCLD   libringbuffer.la
>>
>> make[2]: Leaving directory
>> `/usr/src/lttng-ust-2.0.1/libringbuffer'
>>
>> Making all in
>> liblttng-ust-comm
>>
>> make[2]: Entering directory
>> `/usr/src/lttng-ust-2.0.1/liblttng-ust-comm'
>>
>> make[2]: Nothing to be done for
>> `all'.
>>
>> make[2]: Leaving directory
>> `/usr/src/lttng-ust-2.0.1/liblttng-ust-comm'
>>
>> Making all in
>> liblttng-ust
>>
>> make[2]: Entering directory
>> `/usr/src/lttng-ust-2.0.1/liblttng-ust'
>>
>>   CC
>> liblttng_ust_tracepoint_la-tracepoint.lo
>>
>>   CCLD   liblttng-ust-tracepoint.la
>>
>>   CC
>> lttng-ust-comm.lo
>>
>>   CC
>> lttng-ust-abi.lo
>>
>>   CC
>> ltt-probes.lo
>>
>>   CC
>> lttng-probe-ust.lo
>>
>>   CC
>> lttng-context-vtid.lo
>>
>>   CC
>> lttng-context-vpid.lo
>>
>>   CC
>> lttng-context-pthread-id.lo
>>
>>   CC
>> lttng-context-procname.lo
>>
>>   CC
>> ltt-context.lo
>>
>>   CC
>> ltt-events.lo
>>
>>   CCLD   liblttng-ust-runtime.la
>>
>>   CC
>> ust-core.lo
>>
>>   CC
>> ltt-ring-buffer-client-discard.lo
>>
>>   CC
>> ltt-ring-buffer-client-overwrite.lo
>>
>>   CC
>> ltt-ring-buffer-metadata-client.lo
>>
>>   CCLD   liblttng-ust-support.la
>>
>>   CCLD   liblttng-ust.la
>>
>> /usr/lib/gcc/armv7a-unknown-linux-gnueabi/4.5.3/../../../../armv7a-unknown-linux-gnueabi/bin/ld:
>> warning: creating a DT_TEXTREL in object.
>> copying selected object files to avoid basename
>> conflicts...
>>
>> make[2]: Leaving directory
>> `/usr/src/lttng-ust-2.0.1/liblttng-ust'
>>
>> Making all in
>> liblttng-ust-ctl
>>
>> make[2]: Entering directory
>> `/usr/src/lttng-ust-2.0.1/liblttng-ust-ctl'
>>
>>   CC
>> ustctl.lo
>>
>>   CCLD   liblttng-ust-ctl.la
>>
>> /usr/lib/gcc/armv7a-unknown-linux-gnueabi/4.5.3/../../../../armv7a-unknown-linux-gnueabi/bin/ld:
>> warning: creating a DT_TEXTREL in object.
>> make[2]: Leaving directory
>> `/usr/src/lttng-ust-2.0.1/liblttng-ust-ctl'
>>
>> Making all in
>> liblttng-ust-fork
>>
>> make[2]: Entering directory
>> `/usr/src/lttng-ust-2.0.1/liblttng-ust-fork'
>>
>>   CCLD   liblttng-ust-fork.la
>>
>> make[2]: Leaving directory
>> `/usr/src/lttng-ust-2.0.1/liblttng-ust-fork'
>>
>> Making all in
>> liblttng-ust-libc-wrapper
>>
>> make[2]: Entering directory
>> `/usr/src/lttng-ust-2.0.1/liblttng-ust-libc-wrapper'
>>
>>   CC
>> lttng-ust-malloc.lo
>>
>>   CCLD   liblttng-ust-libc-wrapper.la
>>
>> make[2]: Leaving directory
>> `/usr/src/lttng-ust-2.0.1/liblttng-ust-libc-wrapper'
>>
>> Making all in
>> tools
>>
>> make[2]: Entering directory
>> `/usr/src/lttng-ust-2.0.1/tools'
>>
>> make[2]: Nothing to be done for
>> `all'.
>>
>> make[2]: Leaving directory
>> `/usr/src/lttng-ust-2.0.1/tools'
>>
>> Making all in
>> tests
>>
>> make[2]: Entering directory
>> `/usr/src/lttng-ust-2.0.1/tests'
>>
>> Making all in
>> .
>>
>> make[3]: Entering directory
>> `/usr/src/lttng-ust-2.0.1/tests'
>>
>> make[3]: Nothing to be done for
>> `all-am'.
>>
>> make[3]: Leaving directory
>> `/usr/src/lttng-ust-2.0.1/tests'
>>
>> Making all in
>> hello
>>
>> make[3]: Entering directory
>> `/usr/src/lttng-ust-2.0.1/tests/hello'
>>
>>   CC
>> tp.o
>>
>>   CCLD
>> hello
>>
>> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
>> `__num_possible_cpus'
>>
>> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
>> `shm_object_table_create'
>>
>> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
>> `shm_object_table_append_shadow'
>>
>> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
>> `shm_object_table_append'
>>
>> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
>> `zalloc_shm'
>>
>> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
>> `_get_num_possible_cpus'
>>
>> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
>> `align_shm'
>>
>> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
>> `shm_object_table_destroy'
>>
>> collect2: ld returned 1 exit
>> status
>>
>> make[3]: *** [hello] Error
>> 1
>>
>> make[3]: Leaving directory
>> `/usr/src/lttng-ust-2.0.1/tests/hello'
>>
>> make[2]: *** [all-recursive] Error
>> 1
>>
>> make[2]: Leaving directory
>> `/usr/src/lttng-ust-2.0.1/tests'
>>
>> make[1]: *** [all-recursive] Error
>> 1
>>
>> make[1]: Leaving directory
>> `/usr/src/lttng-ust-2.0.1'
>>
>> make: *** [all] Error
>> 2
>>
>> localhost lttng-ust-2.0.1 #
>>
>>
>> On Thu, May 17, 2012 at 2:30 PM, Mathieu Desnoyers <
>> mathieu.desnoyers@efficios.com> wrote:
>>
>> > * Alexandre Montplaisir (alexandre.montplaisir@polymtl.ca) wrote:
>> > > This is an interesting problem, I'll forward it to the mailing list.
>> > >
>> > >
>> > > On 12-05-17 10:02 AM, Vanni Genua wrote:
>> > > > Also why I get this error?
>> > > > see the attached log file.
>> > > > Best regards.
>> > > > V.G.
>> > > >
>> > > >
>> > >
>> > > localhost lttng-ust-2.0.1 # ./configure
>> > > checking build system type... armv7l-unknown-linux-gnueabi
>> > > checking host system type... armv7l-unknown-linux-gnueabi
>> > > checking target system type... armv7l-unknown-linux-gnueabi
>> > > checking for a BSD-compatible install... /usr/bin/install -c
>> > > checking whether build environment is sane... yes
>> > > checking for a thread-safe mkdir -p... /bin/mkdir -p
>> > > checking for gawk... gawk
>> > > checking whether make sets $(MAKE)... yes
>> > > checking whether make supports nested variables... yes
>> > > checking for a sed that does not truncate output... /bin/sed
>> > > checking for gcc... gcc
>> > > checking whether the C compiler works... yes
>> > > checking for C compiler default output file name... a.out
>> > > checking for suffix of executables...
>> > > checking whether we are cross compiling... no
>> > > checking for suffix of object files... o
>> > > checking whether we are using the GNU C compiler... yes
>> > > checking whether gcc accepts -g... yes
>> > > checking for gcc option to accept ISO C89... none needed
>> > > checking for style of include used by make... GNU
>> > > checking dependency style of gcc... gcc3
>> > > checking for g++... g++
>> > > checking whether we are using the GNU C++ compiler... yes
>> > > checking whether g++ accepts -g... yes
>> > > checking dependency style of g++... gcc3
>> > > checking whether make sets $(MAKE)... (cached) yes
>> > > checking how to print strings... printf
>> > > checking for a sed that does not truncate output... (cached) /bin/sed
>> > > checking for grep that handles long lines and -e... /bin/grep
>> > > checking for egrep... /bin/grep -E
>> > > checking for fgrep... /bin/grep -F
>> > > checking for ld used by gcc...
>> > > /usr/armv7a-unknown-linux-gnueabi/bin/ld
>> > > checking if the linker (/usr/armv7a-unknown-linux-gnueabi/bin/ld) is
>> > > GNU
>> > ld... yes
>> > > checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
>> > > checking the name lister (/usr/bin/nm -B) interface... BSD nm
>> > > checking whether ln -s works... yes
>> > > checking the maximum length of command line arguments... 1572864
>> > > checking whether the shell understands some XSI constructs... yes
>> > > checking whether the shell understands "+="... yes
>> > > checking how to convert armv7l-unknown-linux-gnueabi file names to
>> > armv7l-unknown-linux-gnueabi format... func_convert_file_noop
>> > > checking how to convert armv7l-unknown-linux-gnueabi file names to
>> > toolchain format... func_convert_file_noop
>> > > checking for /usr/armv7a-unknown-linux-gnueabi/bin/ld option to
>> > > reload
>> > object files... -r
>> > > checking for objdump... objdump
>> > > checking how to recognize dependent libraries... pass_all
>> > > checking for dlltool... no
>> > > checking how to associate runtime and link libraries... printf %s\n
>> > > checking for ar... ar
>> > > checking for archiver @FILE support... @
>> > > checking for strip... strip
>> > > checking for ranlib... ranlib
>> > > checking command to parse /usr/bin/nm -B output from gcc object... ok
>> > > checking for sysroot... no
>> > > checking for mt... no
>> > > checking if : is a manifest tool... no
>> > > checking how to run the C preprocessor... gcc -E
>> > > checking for ANSI C header files... yes
>> > > checking for sys/types.h... yes
>> > > checking for sys/stat.h... yes
>> > > checking for stdlib.h... yes
>> > > checking for string.h... yes
>> > > checking for memory.h... yes
>> > > checking for strings.h... yes
>> > > checking for inttypes.h... yes
>> > > checking for stdint.h... yes
>> > > checking for unistd.h... yes
>> > > checking for dlfcn.h... yes
>> > > checking for objdir... .libs
>> > > checking if gcc supports -fno-rtti -fno-exceptions... no
>> > > checking for gcc option to produce PIC... -fPIC -DPIC
>> > > checking if gcc PIC flag -fPIC -DPIC works... yes
>> > > checking if gcc static flag -static works... yes
>> > > checking if gcc supports -c -o file.o... yes
>> > > checking if gcc supports -c -o file.o... (cached) yes
>> > > checking whether the gcc linker
>> > (/usr/armv7a-unknown-linux-gnueabi/bin/ld) supports shared libraries...
>> > yes
>> > > checking whether -lc should be explicitly linked in... no
>> > > checking dynamic linker characteristics... GNU/Linux ld.so
>> > > checking how to hardcode library paths into programs... immediate
>> > > checking whether stripping libraries is possible... yes
>> > > checking if libtool supports shared libraries... yes
>> > > checking whether to build shared libraries... yes
>> > > checking whether to build static libraries... yes
>> > > checking how to run the C++ preprocessor... g++ -E
>> > > checking for ld used by g++...
>> > > /usr/armv7a-unknown-linux-gnueabi/bin/ld
>> > > checking if the linker (/usr/armv7a-unknown-linux-gnueabi/bin/ld) is
>> > > GNU
>> > ld... yes
>> > > checking whether the g++ linker
>> > (/usr/armv7a-unknown-linux-gnueabi/bin/ld) supports shared libraries...
>> > yes
>> > > checking for g++ option to produce PIC... -fPIC -DPIC
>> > > checking if g++ PIC flag -fPIC -DPIC works... yes
>> > > checking if g++ static flag -static works... yes
>> > > checking if g++ supports -c -o file.o... yes
>> > > checking if g++ supports -c -o file.o... (cached) yes
>> > > checking whether the g++ linker
>> > (/usr/armv7a-unknown-linux-gnueabi/bin/ld) supports shared libraries...
>> > yes
>> > > checking dynamic linker characteristics... (cached) GNU/Linux ld.so
>> > > checking how to hardcode library paths into programs... immediate
>> > > checking for dlopen in -ldl... yes
>> > > checking for pthread_create in -lpthread... yes
>> > > checking for uuid_generate in -luuid... yes
>> > > checking for inline... inline
>> > > checking for stdlib.h... (cached) yes
>> > > checking for GNU libc compatible malloc... yes
>> > > checking for gettimeofday... yes
>> > > checking for munmap... yes
>> > > checking for socket... yes
>> > > checking for strerror... yes
>> > > checking for strtol... yes
>> > > checking for sched_getcpu... yes
>> > > checking for sysconf... yes
>> > > checking for makeinfo... yes
>> > > checking urcu-bp.h usability... yes
>> > > checking urcu-bp.h presence... yes
>> > > checking for urcu-bp.h... yes
>> > > checking caa_likely()... yes
>> > > checking for synchronize_rcu_bp in -lurcu-bp... yes
>> > > checking for call_rcu_bp in -lurcu-bp... yes
>> > > checking library format for the host system... configure: error:
>> > > unable
>> > to detect library format (unsupported architecture (armv7l)?)
>> >
>> > Does it help if you add a line:
>> >
>> >        armv7l) LIBFORMAT="elf32-littlearm"; NO_UNALIGNED_ACCESS=1 ;;
>> >
>> > near line 188 of configure.ac ?
>> >
>> > What we did in userspace RCU is to use "arm*".
>> >
>> > Thanks,
>> >
>> > Mathieu
>> >
>> > >
>> > >
>> > > _______________________________________________
>> > > lttng-dev mailing list
>> > > lttng-dev@lists.lttng.org
>> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> >
>> > --
>> > Mathieu Desnoyers
>> > Operating System Efficiency R&D Consultant
>> > EfficiOS Inc.
>> > http://www.efficios.com
>> >
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
>
