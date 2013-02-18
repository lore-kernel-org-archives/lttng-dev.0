From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: lttng-tools : undefined reference to
	rcu_read_lock_mb
Date: Mon, 18 Feb 2013 13:11:21 -0500
Message-ID: <CA+jJMxvSTdUjOABtW0EcAw4L19+D+gEMXv09NpADk1GEznnN3g__17186.9286372841$1361211159$gmane$org@mail.gmail.com>
References: <CAO8ONPw=4sDBzXRW0RmObi6K5O=37CubrDnx0NbL+sS8t+RohA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1U7VBX-0001DR-7O
	for lttng-dev@lists.lttng.org; Mon, 18 Feb 2013 13:11:27 -0500
Received: by mail-wi0-f172.google.com with SMTP id ez12so3878132wid.5
	for <lttng-dev@lists.lttng.org>; Mon, 18 Feb 2013 10:11:21 -0800 (PST)
In-Reply-To: <CAO8ONPw=4sDBzXRW0RmObi6K5O=37CubrDnx0NbL+sS8t+RohA@mail.gmail.com>
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

It appears to be caused by a conflict between what you installed in
/usr/local/lib and /usr/lib.
Please make sure you uninstalled the libs in /usr/local/lib.

You may do so by running ./configure without any option, which will
set the default install path and then run "make uninstall".

Regards,
J=E9r=E9mie

On Mon, Feb 18, 2013 at 10:49 AM, Vanni Genua <vannigenua@gmail.com> wrote:
> After having installed on an Intel x86 platform lttng-modules,
> userspace-rcu, lttng-ust, I tried to install LTTng-tools but I get the
> following error, why?
>
>> 1)
>> lttng-tools # ./bootstrap
>> + '[' '!' -e config ']'
>> + autoreconf -i
>> 2)
>> lttng-tools # ./configure
>> checking build system type... i686-pc-linux-gnu
>> checking host system type... i686-pc-linux-gnu
>> checking target system type... i686-pc-linux-gnu
>> checking for a BSD-compatible install... /usr/bin/install -c
>> checking whether build environment is sane... yes
>> checking for a thread-safe mkdir -p... /bin/mkdir -p
>> checking for gawk... gawk
>> checking whether make sets $(MAKE)... yes
>> checking for grep that handles long lines and -e... /bin/grep
>> checking for occurence(s) of link_all_deplibs =3D no in
>> ./config/libtool.m4... none
>> checking for style of include used by make... GNU
>> checking for gcc... gcc
>> checking whether the C compiler works... yes
>> checking for C compiler default output file name... a.out
>> checking for suffix of executables...
>> checking whether we are cross compiling... no
>> checking for suffix of object files... o
>> checking whether we are using the GNU C compiler... yes
>> checking whether gcc accepts -g... yes
>> checking for gcc option to accept ISO C89... none needed
>> checking dependency style of gcc... gcc3
>> checking how to run the C preprocessor... gcc -E
>> checking for egrep... /bin/grep -E
>> checking for ANSI C header files... yes
>> checking for sys/types.h... yes
>> checking for sys/stat.h... yes
>> checking for stdlib.h... yes
>> checking for string.h... yes
>> checking for memory.h... yes
>> checking for strings.h... yes
>> checking for inttypes.h... yes
>> checking for stdint.h... yes
>> checking for unistd.h... yes
>> checking for sys/types.h... (cached) yes
>> checking for unistd.h... (cached) yes
>> checking fcntl.h usability... yes
>> checking fcntl.h presence... yes
>> checking for fcntl.h... yes
>> checking for string.h... (cached) yes
>> checking pthread.h usability... yes
>> checking pthread.h presence... yes
>> checking for pthread.h... yes
>> checking limits.h usability... yes
>> checking limits.h presence... yes
>> checking for limits.h... yes
>> checking signal.h usability... yes
>> checking signal.h presence... yes
>> checking for signal.h... yes
>> checking for stdlib.h... (cached) yes
>> checking sys/un.h usability... yes
>> checking sys/un.h presence... yes
>> checking for sys/un.h... yes
>> checking sys/socket.h usability... yes
>> checking sys/socket.h presence... yes
>> checking for sys/socket.h... yes
>> checking for stdlib.h... (cached) yes
>> checking stdio.h usability... yes
>> checking stdio.h presence... yes
>> checking for stdio.h... yes
>> checking getopt.h usability... yes
>> checking getopt.h presence... yes
>> checking for getopt.h... yes
>> checking sys/ipc.h usability... yes
>> checking sys/ipc.h presence... yes
>> checking for sys/ipc.h... yes
>> checking sys/shm.h usability... yes
>> checking sys/shm.h presence... yes
>> checking for sys/shm.h... yes
>> checking popt.h usability... yes
>> checking popt.h presence... yes
>> checking for popt.h... yes
>> checking grp.h usability... yes
>> checking grp.h presence... yes
>> checking for grp.h... yes
>> checking for pthread_create in -lpthread... yes
>> checking for poptGetContext in -lpopt... yes
>> checking whether cds_list_add is declared... yes
>> checking whether cds_wfq_init is declared... yes
>> checking whether cds_wfq_dequeue_blocking is declared... yes
>> checking whether futex_async is declared... yes
>> checking whether rcu_thread_offline is declared... yes
>> checking whether rcu_thread_online is declared... yes
>> checking whether caa_likely is declared... yes
>> checking for ustctl_set_filter in -llttng-ust-ctl... yes
>> checking for sched_getcpu... yes
>> checking for sysconf... yes
>> checking for sync_file_range... yes
>> checking for dlopen in -ldl... yes
>> checking for fmemopen in -lc... yes
>> checking for open_memstream in -lc... yes
>> configure: You may configure with --enable-python-bindings if you want
>> Python bindings.
>> checking linux/version.h usability... yes
>> checking linux/version.h presence... yes
>> checking for linux/version.h... yes
>> checking for Linux epoll(7) interface... yes
>> checking for special C compiler options needed for large files... no
>> checking for _FILE_OFFSET_BITS value needed for large files... 64
>> checking for gcc... (cached) gcc
>> checking whether we are using the GNU C compiler... (cached) yes
>> checking whether gcc accepts -g... (cached) yes
>> checking for gcc option to accept ISO C89... (cached) none needed
>> checking dependency style of gcc... (cached) gcc3
>> checking how to print strings... printf
>> checking for a sed that does not truncate output... /bin/sed
>> checking for fgrep... /bin/grep -F
>> checking for ld used by gcc... /usr/i686-pc-linux-gnu/bin/ld
>> checking if the linker (/usr/i686-pc-linux-gnu/bin/ld) is GNU ld... yes
>> checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
>> checking the name lister (/usr/bin/nm -B) interface... BSD nm
>> checking whether ln -s works... yes
>> checking the maximum length of command line arguments... 1572864
>> checking whether the shell understands some XSI constructs... yes
>> checking whether the shell understands "+=3D"... yes
>> checking for /usr/i686-pc-linux-gnu/bin/ld option to reload object
>> files... -r
>> checking for objdump... objdump
>> checking how to recognize dependent libraries... pass_all
>> checking for ar... ar
>> checking for strip... strip
>> checking for ranlib... ranlib
>> checking command to parse /usr/bin/nm -B output from gcc object... ok
>> checking for dlfcn.h... yes
>> checking for objdir... .libs
>> checking if gcc supports -fno-rtti -fno-exceptions... no
>> checking for gcc option to produce PIC... -fPIC -DPIC
>> checking if gcc PIC flag -fPIC -DPIC works... yes
>> checking if gcc static flag -static works... yes
>> checking if gcc supports -c -o file.o... yes
>> checking if gcc supports -c -o file.o... (cached) yes
>> checking whether the gcc linker (/usr/i686-pc-linux-gnu/bin/ld) supports
>> shared libraries... yes
>> checking whether -lc should be explicitly linked in... no
>> checking dynamic linker characteristics... GNU/Linux ld.so
>> checking how to hardcode library paths into programs... immediate
>> checking whether stripping libraries is possible... yes
>> checking if libtool supports shared libraries... yes
>> checking whether to build shared libraries... yes
>> checking whether to build static libraries... yes
>> checking for bison... bison -y
>> checking for flex... flex
>> checking lex output file root... lex.yy
>> checking lex library... -lfl
>> checking whether yytext is a pointer... yes
>> configure: creating ./config.status
>> config.status: creating Makefile
>> config.status: creating doc/Makefile
>> config.status: creating doc/man/Makefile
>> config.status: creating include/Makefile
>> config.status: creating extras/Makefile
>> config.status: creating extras/bindings/Makefile
>> config.status: creating extras/bindings/swig/Makefile
>> config.status: creating extras/bindings/swig/python/Makefile
>> config.status: creating src/Makefile
>> config.status: creating src/common/Makefile
>> config.status: creating src/common/kernel-ctl/Makefile
>> config.status: creating src/common/kernel-consumer/Makefile
>> config.status: creating src/common/ust-consumer/Makefile
>> config.status: creating src/common/hashtable/Makefile
>> config.status: creating src/common/sessiond-comm/Makefile
>> config.status: creating src/common/compat/Makefile
>> config.status: creating src/common/relayd/Makefile
>> config.status: creating src/common/testpoint/Makefile
>> config.status: creating src/lib/Makefile
>> config.status: creating src/lib/lttng-ctl/Makefile
>> config.status: creating src/lib/lttng-ctl/filter/Makefile
>> config.status: creating src/lib/lttng-ctl/lttng-ctl.pc
>> config.status: creating src/bin/Makefile
>> config.status: creating src/bin/lttng-consumerd/Makefile
>> config.status: creating src/bin/lttng-sessiond/Makefile
>> config.status: creating src/bin/lttng-relayd/Makefile
>> config.status: creating src/bin/lttng/Makefile
>> config.status: creating tests/Makefile
>> config.status: creating tests/kernel/Makefile
>> config.status: creating tests/tools/Makefile
>> config.status: creating tests/tools/streaming/Makefile
>> config.status: creating tests/tools/filtering/Makefile
>> config.status: creating tests/tools/health/Makefile
>> config.status: creating tests/ust/Makefile
>> config.status: creating tests/ust/nprocesses/Makefile
>> config.status: creating tests/ust/high-throughput/Makefile
>> config.status: creating tests/ust/low-throughput/Makefile
>> config.status: creating tests/ust/before-after/Makefile
>> config.status: creating tests/ust/multi-session/Makefile
>> config.status: creating tests/ust/overlap/Makefile
>> config.status: creating tests/ust/overlap/demo/Makefile
>> config.status: creating include/config.h
>> config.status: include/config.h is unchanged
>> config.status: executing depfiles commands
>> config.status: executing libtool commands
>>
>> Version name: Basse Messe
>> Light coloured German ale whose style was named after the city Cologne
>> (Koln) where it was first brewed. It is a rather simple beer with lightly
>> fruity aromas and a delicate hoppy fragrance. The beer has a pronounced
>> malty taste with a subtle bitter aftertaste
>>
>> Target architecture: i686
>> Lttng-UST support: Enabled
>> Python binding: Disabled
>> All binaries will be built.
>>
>> Binaries will be installed in:  /usr/local/bin
>> Libraries will be installed in: /usr/local/lib
>>
>> The sessiond daemon will look in the following directories:
>> 32-bit consumerd executable at:
>> /usr/local/lib/lttng/libexec/lttng-consumerd
>> 32-bit consumer libraries in:   /usr/local/lib
>> 64-bit consumerd executable at:
>> /usr/local/lib/lttng/libexec/lttng-consumerd
>> 64-bit consumer libraries in:   /usr/local/lib
>>
>> 3) lttng-tools # make
>> Making all in src
>> make[1]: Entering directory `/usr/src/LTTng/lttng-tools/src'
>> Making all in common
>> make[2]: Entering directory `/usr/src/LTTng/lttng-tools/src/common'
>> Making all in compat
>> make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common/compa=
t'
>>   CC     compat-fcntl.lo
>>   CC     compat-epoll.lo
>>   CCLD   libcompat.la
>> make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common/compat'
>> Making all in hashtable
>> make[3]: Entering directory
>> `/usr/src/LTTng/lttng-tools/src/common/hashtable'
>>   CC     hashtable.lo
>>   CC     utils.lo
>>   CC     rculfhash.lo
>>   CC     rculfhash-mm-chunk.lo
>>   CC     rculfhash-mm-mmap.lo
>>   CC     rculfhash-mm-order.lo
>>   CCLD   libhashtable.la
>> make[3]: Leaving directory
>> `/usr/src/LTTng/lttng-tools/src/common/hashtable'
>> Making all in kernel-ctl
>> make[3]: Entering directory
>> `/usr/src/LTTng/lttng-tools/src/common/kernel-ctl'
>>   CC     kernel-ctl.lo
>>   CCLD   libkernel-ctl.la
>> make[3]: Leaving directory
>> `/usr/src/LTTng/lttng-tools/src/common/kernel-ctl'
>> Making all in sessiond-comm
>> make[3]: Entering directory
>> `/usr/src/LTTng/lttng-tools/src/common/sessiond-comm'
>>   CC     sessiond-comm.lo
>>   CC     unix.lo
>>   CC     inet.lo
>>   CC     inet6.lo
>>   CCLD   libsessiond-comm.la
>> make[3]: Leaving directory
>> `/usr/src/LTTng/lttng-tools/src/common/sessiond-comm'
>> Making all in relayd
>> make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common/relay=
d'
>>   CC     relayd.lo
>> relayd.c: In function 'recv_reply':
>> relayd.c:90: warning: format '%ld' expects type 'long int', but argument=
 3
>> has type 'size_t'
>> relayd.c:90: warning: format '%ld' expects type 'long int', but argument=
 3
>> has type 'size_t'
>> relayd.c:90: warning: format '%ld' expects type 'long int', but argument=
 3
>> has type 'size_t'
>> relayd.c:90: warning: format '%ld' expects type 'long int', but argument=
 3
>> has type 'size_t'
>> relayd.c:98: warning: format '%lu' expects type 'long unsigned int', but
>> argument 4 has type 'size_t'
>> relayd.c:98: warning: format '%lu' expects type 'long unsigned int', but
>> argument 4 has type 'size_t'
>> relayd.c:98: warning: format '%lu' expects type 'long unsigned int', but
>> argument 4 has type 'size_t'
>> relayd.c:98: warning: format '%lu' expects type 'long unsigned int', but
>> argument 4 has type 'size_t'
>> relayd.c: In function 'relayd_send_data_hdr':
>> relayd.c:353: warning: format '%ld' expects type 'long int', but argument
>> 3 has type 'size_t'
>> relayd.c:353: warning: format '%ld' expects type 'long int', but argument
>> 3 has type 'size_t'
>> relayd.c:353: warning: format '%ld' expects type 'long int', but argument
>> 3 has type 'size_t'
>> relayd.c:353: warning: format '%ld' expects type 'long int', but argument
>> 3 has type 'size_t'
>>   CCLD   librelayd.la
>> make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common/relayd'
>> Making all in kernel-consumer
>> make[3]: Entering directory
>> `/usr/src/LTTng/lttng-tools/src/common/kernel-consumer'
>>   CC     kernel-consumer.lo
>>   CCLD   libkernel-consumer.la
>> make[3]: Leaving directory
>> `/usr/src/LTTng/lttng-tools/src/common/kernel-consumer'
>> Making all in ust-consumer
>> make[3]: Entering directory
>> `/usr/src/LTTng/lttng-tools/src/common/ust-consumer'
>>   CC     ust-consumer.lo
>> ust-consumer.c: In function 'lttng_ustconsumer_read_subbuffer':
>> ust-consumer.c:562: warning: format '%zd' expects type 'signed size_t',
>> but argument 3 has type 'long int'
>> ust-consumer.c:562: warning: format '%zd' expects type 'signed size_t',
>> but argument 3 has type 'long int'
>> ust-consumer.c:562: warning: format '%zd' expects type 'signed size_t',
>> but argument 3 has type 'long int'
>> ust-consumer.c:562: warning: format '%zd' expects type 'signed size_t',
>> but argument 3 has type 'long int'
>>   CCLD   libust-consumer.la
>> make[3]: Leaving directory
>> `/usr/src/LTTng/lttng-tools/src/common/ust-consumer'
>> Making all in testpoint
>> make[3]: Entering directory
>> `/usr/src/LTTng/lttng-tools/src/common/testpoint'
>>   CC     testpoint.lo
>>   CCLD   libtestpoint.la
>> make[3]: Leaving directory
>> `/usr/src/LTTng/lttng-tools/src/common/testpoint'
>> make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common'
>>   CC     error.lo
>>   CC     utils.lo
>>   CC     runas.lo
>>   CC     futex.lo
>>   CC     uri.lo
>>   CC     defaults.lo
>>   CCLD   libcommon.la
>>   CC     consumer.lo
>> consumer.c: In function 'consumer_add_relayd_socket':
>> consumer.c:2707: warning: 'relayd' may be used uninitialized in this
>> function
>>   CCLD   libconsumer.la
>> copying selected object files to avoid basename conflicts...
>> make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common'
>> make[2]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common'
>> Making all in lib
>> make[2]: Entering directory `/usr/src/LTTng/lttng-tools/src/lib'
>> Making all in lttng-ctl
>> make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-ct=
l'
>> Making all in filter
>> make[4]: Entering directory
>> `/usr/src/LTTng/lttng-tools/src/lib/lttng-ctl/filter'
>>   YACC   filter-parser.c
>> updating filter-parser.h
>> updating filter-parser.output
>> make  all-am
>> make[5]: Entering directory
>> `/usr/src/LTTng/lttng-tools/src/lib/lttng-ctl/filter'
>>   LEX    filter-lexer.c
>>   CC     libfilter_la-filter-lexer.lo
>> filter-lexer.c: In function 'yylex':
>> filter-lexer.l:136: warning: ignoring return value of 'fwrite', declared
>> with attribute warn_unused_result
>>   CC     libfilter_la-filter-parser.lo
>>   CC     libfilter_la-filter-visitor-set-parent.lo
>>   CC     libfilter_la-filter-visitor-xml.lo
>>   CC     libfilter_la-filter-visitor-generate-ir.lo
>>   CC     libfilter_la-filter-visitor-ir-check-binary-op-nesting.lo
>>   CC     libfilter_la-filter-visitor-generate-bytecode.lo
>>   CCLD   libfilter.la
>>   CC     filter-grammar-test.o
>>   CCLD   filter-grammar-test
>> make[5]: Leaving directory
>> `/usr/src/LTTng/lttng-tools/src/lib/lttng-ctl/filter'
>> make[4]: Leaving directory
>> `/usr/src/LTTng/lttng-tools/src/lib/lttng-ctl/filter'
>> make[4]: Entering directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-ct=
l'
>>   CC     lttng-ctl.lo
>>   CCLD   liblttng-ctl.la
>> copying selected object files to avoid basename conflicts...
>> make[4]: Leaving directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-ctl'
>> make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-ctl'
>> make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/lib'
>> make[3]: Nothing to be done for `all-am'.
>> make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/lib'
>> make[2]: Leaving directory `/usr/src/LTTng/lttng-tools/src/lib'
>> Making all in bin
>> make[2]: Entering directory `/usr/src/LTTng/lttng-tools/src/bin'
>> Making all in lttng-consumerd
>> make[3]: Entering directory
>> `/usr/src/LTTng/lttng-tools/src/bin/lttng-consumerd'
>>   CC     lttng-consumerd.o
>>   CCLD   lttng-consumerd
>> /usr/lib/gcc/i686-pc-linux-gnu/4.4.4/../../../../i686-pc-linux-gnu/bin/l=
d:
>> warning: liburcu-common.so.1, needed by /usr/local/lib/liblttng-ust-ctl.=
so,
>> may conflict with liburcu-common.so.2
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_data_pending':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2921: undefined referen=
ce
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:3030: undefined referen=
ce
>> to `rcu_read_unlock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:3024: undefined referen=
ce
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_steal_stream_key':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:116: undefined reference
>> to `rcu_read_lock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_find_stream':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:99: undefined reference
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:107: undefined reference
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_steal_stream_key':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:127: undefined reference
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_find_stream':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:107: undefined reference
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_steal_channel_key':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:161: undefined reference
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:172: undefined reference
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_add_channel':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:905: undefined reference
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:918: undefined reference
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `destroy_relayd':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:234: undefined reference
>> to `call_rcu_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_thread_sessiond_poll':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2523: undefined referen=
ce
>> to `rcu_register_thread_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2639: undefined referen=
ce
>> to `rcu_unregister_thread_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_del_channel':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:814: undefined reference
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:818: undefined reference
>> to `rcu_read_unlock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:839: undefined reference
>> to `call_rcu_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_del_metadata_stream':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1853: undefined referen=
ce
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1862: undefined referen=
ce
>> to `rcu_read_unlock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1886: undefined referen=
ce
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1912: undefined referen=
ce
>> to `rcu_read_unlock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1931: undefined referen=
ce
>> to `call_rcu_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_thread_metadata_poll':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2073: undefined referen=
ce
>> to `rcu_register_thread_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `destroy_stream_ht':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1793: undefined referen=
ce
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1801: undefined referen=
ce
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_thread_metadata_poll':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2247: undefined referen=
ce
>> to `rcu_unregister_thread_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2183: undefined referen=
ce
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2236: undefined referen=
ce
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_add_metadata_stream':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1959: undefined referen=
ce
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1998: undefined referen=
ce
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `validate_endpoint_status_metadata_stream':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2040: undefined referen=
ce
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2055: undefined referen=
ce
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `lttng_consumer_cleanup':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1044: undefined referen=
ce
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1053: undefined referen=
ce
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `cleanup_relayd_ht':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:246: undefined reference
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:255: undefined reference
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_del_stream':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:396: undefined reference
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:405: undefined reference
>> to `rcu_read_unlock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:430: undefined reference
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:457: undefined reference
>> to `rcu_read_unlock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:475: undefined reference
>> to `call_rcu_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_thread_data_poll':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2266: undefined referen=
ce
>> to `rcu_register_thread_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_update_poll_array':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:940: undefined reference
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:961: undefined reference
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `destroy_data_stream_ht':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1766: undefined referen=
ce
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1774: undefined referen=
ce
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_thread_data_poll':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2505: undefined referen=
ce
>> to `rcu_unregister_thread_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_add_stream':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:586: undefined reference
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:624: undefined reference
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `validate_endpoint_status_data_stream':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2015: undefined referen=
ce
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2024: undefined referen=
ce
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `consumer_allocate_stream':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:501: undefined reference
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:560: undefined reference
>> to `rcu_read_unlock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:564: undefined reference
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `update_endpoint_status_by_netidx':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:273: undefined reference
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:290: undefined reference
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `lttng_consumer_on_read_subbuffer_splice':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1517: undefined referen=
ce
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1687: undefined referen=
ce
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
>> `lttng_consumer_on_read_subbuffer_mmap':
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1345: undefined referen=
ce
>> to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1478: undefined referen=
ce
>> to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(kernel-consumer.o): In function
>> `lttng_kconsumer_recv_cmd':
>>
>> /usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.c:=
112:
>> undefined reference to `rcu_read_lock_mb'
>>
>> /usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.c:=
352:
>> undefined reference to `rcu_read_unlock_mb'
>>
>> /usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.c:=
287:
>> undefined reference to `rcu_read_unlock_mb'
>>
>> /usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.c:=
180:
>> undefined reference to `rcu_read_unlock_mb'
>>
>> /usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.c:=
172:
>> undefined reference to `rcu_read_unlock_mb'
>> ../../../src/common/.libs/libconsumer.a(hashtable.o): In function
>> `cds_lfht_new':
>> /usr/src/LTTng/lttng-tools/src/common/hashtable/rculfhash.h:167: undefin=
ed
>> reference to `rcu_flavor_mb'
>> ../../../src/common/.libs/libconsumer.a(ust-consumer.o): In function
>> `lttng_ustconsumer_recv_cmd':
>> /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:131:
>> undefined reference to `rcu_read_lock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:406:
>> undefined reference to `rcu_read_unlock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:376:
>> undefined reference to `rcu_read_unlock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:232:
>> undefined reference to `rcu_read_unlock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:165:
>> undefined reference to `rcu_read_unlock_mb'
>> /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:226:
>> undefined reference to `rcu_read_unlock_mb'
>> collect2: ld returned 1 exit status
>> make[3]: *** [lttng-consumerd] Error 1
>> make[3]: Leaving directory
>> `/usr/src/LTTng/lttng-tools/src/bin/lttng-consumerd'
>> make[2]: *** [all-recursive] Error 1
>> make[2]: Leaving directory `/usr/src/LTTng/lttng-tools/src/bin'
>> make[1]: *** [all-recursive] Error 1
>> make[1]: Leaving directory `/usr/src/LTTng/lttng-tools/src'
>> make: *** [all-recursive] Error 1
>>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
