From: Vanni Genua <vannigenua@gmail.com>
Subject: lttng-tools : undefined reference to rcu_read_lock_mb
Date: Mon, 18 Feb 2013 16:49:53 +0100
Message-ID: <CAO8ONPw=4sDBzXRW0RmObi6K5O=37CubrDnx0NbL+sS8t+RohA__46673.631508793$1361203236$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0068044564=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <vannigenua@gmail.com>) id 1U7Syd-0002tC-HX
	for lttng-dev@lists.lttng.org; Mon, 18 Feb 2013 10:49:59 -0500
Received: by mail-ia0-f178.google.com with SMTP id y26so5373930iab.9
	for <lttng-dev@lists.lttng.org>; Mon, 18 Feb 2013 07:49:53 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0068044564==
Content-Type: multipart/alternative; boundary=e89a8f3b9eb1111c0804d601ad32

--e89a8f3b9eb1111c0804d601ad32
Content-Type: text/plain; charset=ISO-8859-1

After having installed on an Intel x86 platform lttng-modules,
userspace-rcu, lttng-ust, I tried to install LTTng-tools but I get the
following error, why?

> 1)
> lttng-tools # ./bootstrap
> + '[' '!' -e config ']'
> + autoreconf -i
> 2)
> lttng-tools # ./configure
> checking build system type... i686-pc-linux-gnu
> checking host system type... i686-pc-linux-gnu
> checking target system type... i686-pc-linux-gnu
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether build environment is sane... yes
> checking for a thread-safe mkdir -p... /bin/mkdir -p
> checking for gawk... gawk
> checking whether make sets $(MAKE)... yes
> checking for grep that handles long lines and -e... /bin/grep
> checking for occurence(s) of link_all_deplibs = no in
./config/libtool.m4... none
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
> checking how to run the C preprocessor... gcc -E
> checking for egrep... /bin/grep -E
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
> checking for sys/types.h... (cached) yes
> checking for unistd.h... (cached) yes
> checking fcntl.h usability... yes
> checking fcntl.h presence... yes
> checking for fcntl.h... yes
> checking for string.h... (cached) yes
> checking pthread.h usability... yes
> checking pthread.h presence... yes
> checking for pthread.h... yes
> checking limits.h usability... yes
> checking limits.h presence... yes
> checking for limits.h... yes
> checking signal.h usability... yes
> checking signal.h presence... yes
> checking for signal.h... yes
> checking for stdlib.h... (cached) yes
> checking sys/un.h usability... yes
> checking sys/un.h presence... yes
> checking for sys/un.h... yes
> checking sys/socket.h usability... yes
> checking sys/socket.h presence... yes
> checking for sys/socket.h... yes
> checking for stdlib.h... (cached) yes
> checking stdio.h usability... yes
> checking stdio.h presence... yes
> checking for stdio.h... yes
> checking getopt.h usability... yes
> checking getopt.h presence... yes
> checking for getopt.h... yes
> checking sys/ipc.h usability... yes
> checking sys/ipc.h presence... yes
> checking for sys/ipc.h... yes
> checking sys/shm.h usability... yes
> checking sys/shm.h presence... yes
> checking for sys/shm.h... yes
> checking popt.h usability... yes
> checking popt.h presence... yes
> checking for popt.h... yes
> checking grp.h usability... yes
> checking grp.h presence... yes
> checking for grp.h... yes
> checking for pthread_create in -lpthread... yes
> checking for poptGetContext in -lpopt... yes
> checking whether cds_list_add is declared... yes
> checking whether cds_wfq_init is declared... yes
> checking whether cds_wfq_dequeue_blocking is declared... yes
> checking whether futex_async is declared... yes
> checking whether rcu_thread_offline is declared... yes
> checking whether rcu_thread_online is declared... yes
> checking whether caa_likely is declared... yes
> checking for ustctl_set_filter in -llttng-ust-ctl... yes
> checking for sched_getcpu... yes
> checking for sysconf... yes
> checking for sync_file_range... yes
> checking for dlopen in -ldl... yes
> checking for fmemopen in -lc... yes
> checking for open_memstream in -lc... yes
> configure: You may configure with --enable-python-bindings if you want
Python bindings.
> checking linux/version.h usability... yes
> checking linux/version.h presence... yes
> checking for linux/version.h... yes
> checking for Linux epoll(7) interface... yes
> checking for special C compiler options needed for large files... no
> checking for _FILE_OFFSET_BITS value needed for large files... 64
> checking for gcc... (cached) gcc
> checking whether we are using the GNU C compiler... (cached) yes
> checking whether gcc accepts -g... (cached) yes
> checking for gcc option to accept ISO C89... (cached) none needed
> checking dependency style of gcc... (cached) gcc3
> checking how to print strings... printf
> checking for a sed that does not truncate output... /bin/sed
> checking for fgrep... /bin/grep -F
> checking for ld used by gcc... /usr/i686-pc-linux-gnu/bin/ld
> checking if the linker (/usr/i686-pc-linux-gnu/bin/ld) is GNU ld... yes
> checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
> checking the name lister (/usr/bin/nm -B) interface... BSD nm
> checking whether ln -s works... yes
> checking the maximum length of command line arguments... 1572864
> checking whether the shell understands some XSI constructs... yes
> checking whether the shell understands "+="... yes
> checking for /usr/i686-pc-linux-gnu/bin/ld option to reload object
files... -r
> checking for objdump... objdump
> checking how to recognize dependent libraries... pass_all
> checking for ar... ar
> checking for strip... strip
> checking for ranlib... ranlib
> checking command to parse /usr/bin/nm -B output from gcc object... ok
> checking for dlfcn.h... yes
> checking for objdir... .libs
> checking if gcc supports -fno-rtti -fno-exceptions... no
> checking for gcc option to produce PIC... -fPIC -DPIC
> checking if gcc PIC flag -fPIC -DPIC works... yes
> checking if gcc static flag -static works... yes
> checking if gcc supports -c -o file.o... yes
> checking if gcc supports -c -o file.o... (cached) yes
> checking whether the gcc linker (/usr/i686-pc-linux-gnu/bin/ld) supports
shared libraries... yes
> checking whether -lc should be explicitly linked in... no
> checking dynamic linker characteristics... GNU/Linux ld.so
> checking how to hardcode library paths into programs... immediate
> checking whether stripping libraries is possible... yes
> checking if libtool supports shared libraries... yes
> checking whether to build shared libraries... yes
> checking whether to build static libraries... yes
> checking for bison... bison -y
> checking for flex... flex
> checking lex output file root... lex.yy
> checking lex library... -lfl
> checking whether yytext is a pointer... yes
> configure: creating ./config.status
> config.status: creating Makefile
> config.status: creating doc/Makefile
> config.status: creating doc/man/Makefile
> config.status: creating include/Makefile
> config.status: creating extras/Makefile
> config.status: creating extras/bindings/Makefile
> config.status: creating extras/bindings/swig/Makefile
> config.status: creating extras/bindings/swig/python/Makefile
> config.status: creating src/Makefile
> config.status: creating src/common/Makefile
> config.status: creating src/common/kernel-ctl/Makefile
> config.status: creating src/common/kernel-consumer/Makefile
> config.status: creating src/common/ust-consumer/Makefile
> config.status: creating src/common/hashtable/Makefile
> config.status: creating src/common/sessiond-comm/Makefile
> config.status: creating src/common/compat/Makefile
> config.status: creating src/common/relayd/Makefile
> config.status: creating src/common/testpoint/Makefile
> config.status: creating src/lib/Makefile
> config.status: creating src/lib/lttng-ctl/Makefile
> config.status: creating src/lib/lttng-ctl/filter/Makefile
> config.status: creating src/lib/lttng-ctl/lttng-ctl.pc
> config.status: creating src/bin/Makefile
> config.status: creating src/bin/lttng-consumerd/Makefile
> config.status: creating src/bin/lttng-sessiond/Makefile
> config.status: creating src/bin/lttng-relayd/Makefile
> config.status: creating src/bin/lttng/Makefile
> config.status: creating tests/Makefile
> config.status: creating tests/kernel/Makefile
> config.status: creating tests/tools/Makefile
> config.status: creating tests/tools/streaming/Makefile
> config.status: creating tests/tools/filtering/Makefile
> config.status: creating tests/tools/health/Makefile
> config.status: creating tests/ust/Makefile
> config.status: creating tests/ust/nprocesses/Makefile
> config.status: creating tests/ust/high-throughput/Makefile
> config.status: creating tests/ust/low-throughput/Makefile
> config.status: creating tests/ust/before-after/Makefile
> config.status: creating tests/ust/multi-session/Makefile
> config.status: creating tests/ust/overlap/Makefile
> config.status: creating tests/ust/overlap/demo/Makefile
> config.status: creating include/config.h
> config.status: include/config.h is unchanged
> config.status: executing depfiles commands
> config.status: executing libtool commands
>
> Version name: Basse Messe
> Light coloured German ale whose style was named after the city Cologne
(Koln) where it was first brewed. It is a rather simple beer with lightly
fruity aromas and a delicate hoppy fragrance. The beer has a pronounced
malty taste with a subtle bitter aftertaste
>
> Target architecture: i686
> Lttng-UST support: Enabled
> Python binding: Disabled
> All binaries will be built.
>
> Binaries will be installed in:  /usr/local/bin
> Libraries will be installed in: /usr/local/lib
>
> The sessiond daemon will look in the following directories:
> 32-bit consumerd executable at:
/usr/local/lib/lttng/libexec/lttng-consumerd
> 32-bit consumer libraries in:   /usr/local/lib
> 64-bit consumerd executable at:
/usr/local/lib/lttng/libexec/lttng-consumerd
> 64-bit consumer libraries in:   /usr/local/lib
>
> 3) lttng-tools # make
> Making all in src
> make[1]: Entering directory `/usr/src/LTTng/lttng-tools/src'
> Making all in common
> make[2]: Entering directory `/usr/src/LTTng/lttng-tools/src/common'
> Making all in compat
> make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common/compat'
>   CC     compat-fcntl.lo
>   CC     compat-epoll.lo
>   CCLD   libcompat.la
> make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common/compat'
> Making all in hashtable
> make[3]: Entering directory
`/usr/src/LTTng/lttng-tools/src/common/hashtable'
>   CC     hashtable.lo
>   CC     utils.lo
>   CC     rculfhash.lo
>   CC     rculfhash-mm-chunk.lo
>   CC     rculfhash-mm-mmap.lo
>   CC     rculfhash-mm-order.lo
>   CCLD   libhashtable.la
> make[3]: Leaving directory
`/usr/src/LTTng/lttng-tools/src/common/hashtable'
> Making all in kernel-ctl
> make[3]: Entering directory
`/usr/src/LTTng/lttng-tools/src/common/kernel-ctl'
>   CC     kernel-ctl.lo
>   CCLD   libkernel-ctl.la
> make[3]: Leaving directory
`/usr/src/LTTng/lttng-tools/src/common/kernel-ctl'
> Making all in sessiond-comm
> make[3]: Entering directory
`/usr/src/LTTng/lttng-tools/src/common/sessiond-comm'
>   CC     sessiond-comm.lo
>   CC     unix.lo
>   CC     inet.lo
>   CC     inet6.lo
>   CCLD   libsessiond-comm.la
> make[3]: Leaving directory
`/usr/src/LTTng/lttng-tools/src/common/sessiond-comm'
> Making all in relayd
> make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common/relayd'
>   CC     relayd.lo
> relayd.c: In function 'recv_reply':
> relayd.c:90: warning: format '%ld' expects type 'long int', but argument
3 has type 'size_t'
> relayd.c:90: warning: format '%ld' expects type 'long int', but argument
3 has type 'size_t'
> relayd.c:90: warning: format '%ld' expects type 'long int', but argument
3 has type 'size_t'
> relayd.c:90: warning: format '%ld' expects type 'long int', but argument
3 has type 'size_t'
> relayd.c:98: warning: format '%lu' expects type 'long unsigned int', but
argument 4 has type 'size_t'
> relayd.c:98: warning: format '%lu' expects type 'long unsigned int', but
argument 4 has type 'size_t'
> relayd.c:98: warning: format '%lu' expects type 'long unsigned int', but
argument 4 has type 'size_t'
> relayd.c:98: warning: format '%lu' expects type 'long unsigned int', but
argument 4 has type 'size_t'
> relayd.c: In function 'relayd_send_data_hdr':
> relayd.c:353: warning: format '%ld' expects type 'long int', but argument
3 has type 'size_t'
> relayd.c:353: warning: format '%ld' expects type 'long int', but argument
3 has type 'size_t'
> relayd.c:353: warning: format '%ld' expects type 'long int', but argument
3 has type 'size_t'
> relayd.c:353: warning: format '%ld' expects type 'long int', but argument
3 has type 'size_t'
>   CCLD   librelayd.la
> make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common/relayd'
> Making all in kernel-consumer
> make[3]: Entering directory
`/usr/src/LTTng/lttng-tools/src/common/kernel-consumer'
>   CC     kernel-consumer.lo
>   CCLD   libkernel-consumer.la
> make[3]: Leaving directory
`/usr/src/LTTng/lttng-tools/src/common/kernel-consumer'
> Making all in ust-consumer
> make[3]: Entering directory
`/usr/src/LTTng/lttng-tools/src/common/ust-consumer'
>   CC     ust-consumer.lo
> ust-consumer.c: In function 'lttng_ustconsumer_read_subbuffer':
> ust-consumer.c:562: warning: format '%zd' expects type 'signed size_t',
but argument 3 has type 'long int'
> ust-consumer.c:562: warning: format '%zd' expects type 'signed size_t',
but argument 3 has type 'long int'
> ust-consumer.c:562: warning: format '%zd' expects type 'signed size_t',
but argument 3 has type 'long int'
> ust-consumer.c:562: warning: format '%zd' expects type 'signed size_t',
but argument 3 has type 'long int'
>   CCLD   libust-consumer.la
> make[3]: Leaving directory
`/usr/src/LTTng/lttng-tools/src/common/ust-consumer'
> Making all in testpoint
> make[3]: Entering directory
`/usr/src/LTTng/lttng-tools/src/common/testpoint'
>   CC     testpoint.lo
>   CCLD   libtestpoint.la
> make[3]: Leaving directory
`/usr/src/LTTng/lttng-tools/src/common/testpoint'
> make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common'
>   CC     error.lo
>   CC     utils.lo
>   CC     runas.lo
>   CC     futex.lo
>   CC     uri.lo
>   CC     defaults.lo
>   CCLD   libcommon.la
>   CC     consumer.lo
> consumer.c: In function 'consumer_add_relayd_socket':
> consumer.c:2707: warning: 'relayd' may be used uninitialized in this
function
>   CCLD   libconsumer.la
> copying selected object files to avoid basename conflicts...
> make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common'
> make[2]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common'
> Making all in lib
> make[2]: Entering directory `/usr/src/LTTng/lttng-tools/src/lib'
> Making all in lttng-ctl
> make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-ctl'
> Making all in filter
> make[4]: Entering directory
`/usr/src/LTTng/lttng-tools/src/lib/lttng-ctl/filter'
>   YACC   filter-parser.c
> updating filter-parser.h
> updating filter-parser.output
> make  all-am
> make[5]: Entering directory
`/usr/src/LTTng/lttng-tools/src/lib/lttng-ctl/filter'
>   LEX    filter-lexer.c
>   CC     libfilter_la-filter-lexer.lo
> filter-lexer.c: In function 'yylex':
> filter-lexer.l:136: warning: ignoring return value of 'fwrite', declared
with attribute warn_unused_result
>   CC     libfilter_la-filter-parser.lo
>   CC     libfilter_la-filter-visitor-set-parent.lo
>   CC     libfilter_la-filter-visitor-xml.lo
>   CC     libfilter_la-filter-visitor-generate-ir.lo
>   CC     libfilter_la-filter-visitor-ir-check-binary-op-nesting.lo
>   CC     libfilter_la-filter-visitor-generate-bytecode.lo
>   CCLD   libfilter.la
>   CC     filter-grammar-test.o
>   CCLD   filter-grammar-test
> make[5]: Leaving directory
`/usr/src/LTTng/lttng-tools/src/lib/lttng-ctl/filter'
> make[4]: Leaving directory
`/usr/src/LTTng/lttng-tools/src/lib/lttng-ctl/filter'
> make[4]: Entering directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-ctl'
>   CC     lttng-ctl.lo
>   CCLD   liblttng-ctl.la
> copying selected object files to avoid basename conflicts...
> make[4]: Leaving directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-ctl'
> make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-ctl'
> make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/lib'
> make[3]: Nothing to be done for `all-am'.
> make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/lib'
> make[2]: Leaving directory `/usr/src/LTTng/lttng-tools/src/lib'
> Making all in bin
> make[2]: Entering directory `/usr/src/LTTng/lttng-tools/src/bin'
> Making all in lttng-consumerd
> make[3]: Entering directory
`/usr/src/LTTng/lttng-tools/src/bin/lttng-consumerd'
>   CC     lttng-consumerd.o
>   CCLD   lttng-consumerd
>
/usr/lib/gcc/i686-pc-linux-gnu/4.4.4/../../../../i686-pc-linux-gnu/bin/ld:
warning: liburcu-common.so.1, needed by /usr/local/lib/liblttng-ust-ctl.so,
may conflict with liburcu-common.so.2
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_data_pending':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2921: undefined
reference to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:3030: undefined
reference to `rcu_read_unlock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:3024: undefined
reference to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_steal_stream_key':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:116: undefined reference
to `rcu_read_lock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_find_stream':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:99: undefined reference
to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:107: undefined reference
to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_steal_stream_key':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:127: undefined reference
to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_find_stream':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:107: undefined reference
to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_steal_channel_key':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:161: undefined reference
to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:172: undefined reference
to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_add_channel':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:905: undefined reference
to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:918: undefined reference
to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`destroy_relayd':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:234: undefined reference
to `call_rcu_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_thread_sessiond_poll':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2523: undefined
reference to `rcu_register_thread_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2639: undefined
reference to `rcu_unregister_thread_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_del_channel':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:814: undefined reference
to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:818: undefined reference
to `rcu_read_unlock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:839: undefined reference
to `call_rcu_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_del_metadata_stream':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1853: undefined
reference to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1862: undefined
reference to `rcu_read_unlock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1886: undefined
reference to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1912: undefined
reference to `rcu_read_unlock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1931: undefined
reference to `call_rcu_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_thread_metadata_poll':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2073: undefined
reference to `rcu_register_thread_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`destroy_stream_ht':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1793: undefined
reference to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1801: undefined
reference to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_thread_metadata_poll':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2247: undefined
reference to `rcu_unregister_thread_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2183: undefined
reference to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2236: undefined
reference to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_add_metadata_stream':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1959: undefined
reference to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1998: undefined
reference to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`validate_endpoint_status_metadata_stream':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2040: undefined
reference to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2055: undefined
reference to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`lttng_consumer_cleanup':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1044: undefined
reference to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1053: undefined
reference to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`cleanup_relayd_ht':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:246: undefined reference
to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:255: undefined reference
to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_del_stream':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:396: undefined reference
to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:405: undefined reference
to `rcu_read_unlock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:430: undefined reference
to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:457: undefined reference
to `rcu_read_unlock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:475: undefined reference
to `call_rcu_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_thread_data_poll':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2266: undefined
reference to `rcu_register_thread_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_update_poll_array':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:940: undefined reference
to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:961: undefined reference
to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`destroy_data_stream_ht':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1766: undefined
reference to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1774: undefined
reference to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_thread_data_poll':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2505: undefined
reference to `rcu_unregister_thread_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_add_stream':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:586: undefined reference
to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:624: undefined reference
to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`validate_endpoint_status_data_stream':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2015: undefined
reference to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:2024: undefined
reference to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`consumer_allocate_stream':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:501: undefined reference
to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:560: undefined reference
to `rcu_read_unlock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:564: undefined reference
to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`update_endpoint_status_by_netidx':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:273: undefined reference
to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:290: undefined reference
to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`lttng_consumer_on_read_subbuffer_splice':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1517: undefined
reference to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1687: undefined
reference to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
`lttng_consumer_on_read_subbuffer_mmap':
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1345: undefined
reference to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/consumer.c:1478: undefined
reference to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(kernel-consumer.o): In function
`lttng_kconsumer_recv_cmd':
>
/usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.c:112:
undefined reference to `rcu_read_lock_mb'
>
/usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.c:352:
undefined reference to `rcu_read_unlock_mb'
>
/usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.c:287:
undefined reference to `rcu_read_unlock_mb'
>
/usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.c:180:
undefined reference to `rcu_read_unlock_mb'
>
/usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.c:172:
undefined reference to `rcu_read_unlock_mb'
> ../../../src/common/.libs/libconsumer.a(hashtable.o): In function
`cds_lfht_new':
> /usr/src/LTTng/lttng-tools/src/common/hashtable/rculfhash.h:167:
undefined reference to `rcu_flavor_mb'
> ../../../src/common/.libs/libconsumer.a(ust-consumer.o): In function
`lttng_ustconsumer_recv_cmd':
> /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:131:
undefined reference to `rcu_read_lock_mb'
> /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:406:
undefined reference to `rcu_read_unlock_mb'
> /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:376:
undefined reference to `rcu_read_unlock_mb'
> /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:232:
undefined reference to `rcu_read_unlock_mb'
> /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:165:
undefined reference to `rcu_read_unlock_mb'
> /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:226:
undefined reference to `rcu_read_unlock_mb'
> collect2: ld returned 1 exit status
> make[3]: *** [lttng-consumerd] Error 1
> make[3]: Leaving directory
`/usr/src/LTTng/lttng-tools/src/bin/lttng-consumerd'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/usr/src/LTTng/lttng-tools/src/bin'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/usr/src/LTTng/lttng-tools/src'
> make: *** [all-recursive] Error 1
>

--e89a8f3b9eb1111c0804d601ad32
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>After having installed on an Intel x86 platform lttng-modules, userspace=
-rcu, lttng-ust, I tried to install LTTng-tools but I get the following err=
or, why?</p>
<p>&gt; 1)<br>
&gt; lttng-tools # ./bootstrap <br>
&gt; + &#39;[&#39; &#39;!&#39; -e config &#39;]&#39;<br>
&gt; + autoreconf -i<br>
&gt; 2)<br>
&gt; lttng-tools # ./configure <br>
&gt; checking build system type... i686-pc-linux-gnu<br>
&gt; checking host system type... i686-pc-linux-gnu<br>
&gt; checking target system type... i686-pc-linux-gnu<br>
&gt; checking for a BSD-compatible install... /usr/bin/install -c<br>
&gt; checking whether build environment is sane... yes<br>
&gt; checking for a thread-safe mkdir -p... /bin/mkdir -p<br>
&gt; checking for gawk... gawk<br>
&gt; checking whether make sets $(MAKE)... yes<br>
&gt; checking for grep that handles long lines and -e... /bin/grep<br>
&gt; checking for occurence(s) of link_all_deplibs =3D no in ./config/libto=
ol.m4... none<br>
&gt; checking for style of include used by make... GNU<br>
&gt; checking for gcc... gcc<br>
&gt; checking whether the C compiler works... yes<br>
&gt; checking for C compiler default output file name... a.out<br>
&gt; checking for suffix of executables... <br>
&gt; checking whether we are cross compiling... no<br>
&gt; checking for suffix of object files... o<br>
&gt; checking whether we are using the GNU C compiler... yes<br>
&gt; checking whether gcc accepts -g... yes<br>
&gt; checking for gcc option to accept ISO C89... none needed<br>
&gt; checking dependency style of gcc... gcc3<br>
&gt; checking how to run the C preprocessor... gcc -E<br>
&gt; checking for egrep... /bin/grep -E<br>
&gt; checking for ANSI C header files... yes<br>
&gt; checking for sys/types.h... yes<br>
&gt; checking for sys/stat.h... yes<br>
&gt; checking for stdlib.h... yes<br>
&gt; checking for string.h... yes<br>
&gt; checking for memory.h... yes<br>
&gt; checking for strings.h... yes<br>
&gt; checking for inttypes.h... yes<br>
&gt; checking for stdint.h... yes<br>
&gt; checking for unistd.h... yes<br>
&gt; checking for sys/types.h... (cached) yes<br>
&gt; checking for unistd.h... (cached) yes<br>
&gt; checking fcntl.h usability... yes<br>
&gt; checking fcntl.h presence... yes<br>
&gt; checking for fcntl.h... yes<br>
&gt; checking for string.h... (cached) yes<br>
&gt; checking pthread.h usability... yes<br>
&gt; checking pthread.h presence... yes<br>
&gt; checking for pthread.h... yes<br>
&gt; checking limits.h usability... yes<br>
&gt; checking limits.h presence... yes<br>
&gt; checking for limits.h... yes<br>
&gt; checking signal.h usability... yes<br>
&gt; checking signal.h presence... yes<br>
&gt; checking for signal.h... yes<br>
&gt; checking for stdlib.h... (cached) yes<br>
&gt; checking sys/un.h usability... yes<br>
&gt; checking sys/un.h presence... yes<br>
&gt; checking for sys/un.h... yes<br>
&gt; checking sys/socket.h usability... yes<br>
&gt; checking sys/socket.h presence... yes<br>
&gt; checking for sys/socket.h... yes<br>
&gt; checking for stdlib.h... (cached) yes<br>
&gt; checking stdio.h usability... yes<br>
&gt; checking stdio.h presence... yes<br>
&gt; checking for stdio.h... yes<br>
&gt; checking getopt.h usability... yes<br>
&gt; checking getopt.h presence... yes<br>
&gt; checking for getopt.h... yes<br>
&gt; checking sys/ipc.h usability... yes<br>
&gt; checking sys/ipc.h presence... yes<br>
&gt; checking for sys/ipc.h... yes<br>
&gt; checking sys/shm.h usability... yes<br>
&gt; checking sys/shm.h presence... yes<br>
&gt; checking for sys/shm.h... yes<br>
&gt; checking popt.h usability... yes<br>
&gt; checking popt.h presence... yes<br>
&gt; checking for popt.h... yes<br>
&gt; checking grp.h usability... yes<br>
&gt; checking grp.h presence... yes<br>
&gt; checking for grp.h... yes<br>
&gt; checking for pthread_create in -lpthread... yes<br>
&gt; checking for poptGetContext in -lpopt... yes<br>
&gt; checking whether cds_list_add is declared... yes<br>
&gt; checking whether cds_wfq_init is declared... yes<br>
&gt; checking whether cds_wfq_dequeue_blocking is declared... yes<br>
&gt; checking whether futex_async is declared... yes<br>
&gt; checking whether rcu_thread_offline is declared... yes<br>
&gt; checking whether rcu_thread_online is declared... yes<br>
&gt; checking whether caa_likely is declared... yes<br>
&gt; checking for ustctl_set_filter in -llttng-ust-ctl... yes<br>
&gt; checking for sched_getcpu... yes<br>
&gt; checking for sysconf... yes<br>
&gt; checking for sync_file_range... yes<br>
&gt; checking for dlopen in -ldl... yes<br>
&gt; checking for fmemopen in -lc... yes<br>
&gt; checking for open_memstream in -lc... yes<br>
&gt; configure: You may configure with --enable-python-bindings if you want=
 Python bindings.<br>
&gt; checking linux/version.h usability... yes<br>
&gt; checking linux/version.h presence... yes<br>
&gt; checking for linux/version.h... yes<br>
&gt; checking for Linux epoll(7) interface... yes<br>
&gt; checking for special C compiler options needed for large files... no<b=
r>
&gt; checking for _FILE_OFFSET_BITS value needed for large files... 64<br>
&gt; checking for gcc... (cached) gcc<br>
&gt; checking whether we are using the GNU C compiler... (cached) yes<br>
&gt; checking whether gcc accepts -g... (cached) yes<br>
&gt; checking for gcc option to accept ISO C89... (cached) none needed<br>
&gt; checking dependency style of gcc... (cached) gcc3<br>
&gt; checking how to print strings... printf<br>
&gt; checking for a sed that does not truncate output... /bin/sed<br>
&gt; checking for fgrep... /bin/grep -F<br>
&gt; checking for ld used by gcc... /usr/i686-pc-linux-gnu/bin/ld<br>
&gt; checking if the linker (/usr/i686-pc-linux-gnu/bin/ld) is GNU ld... ye=
s<br>
&gt; checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B<=
br>
&gt; checking the name lister (/usr/bin/nm -B) interface... BSD nm<br>
&gt; checking whether ln -s works... yes<br>
&gt; checking the maximum length of command line arguments... 1572864<br>
&gt; checking whether the shell understands some XSI constructs... yes<br>
&gt; checking whether the shell understands &quot;+=3D&quot;... yes<br>
&gt; checking for /usr/i686-pc-linux-gnu/bin/ld option to reload object fil=
es... -r<br>
&gt; checking for objdump... objdump<br>
&gt; checking how to recognize dependent libraries... pass_all<br>
&gt; checking for ar... ar<br>
&gt; checking for strip... strip<br>
&gt; checking for ranlib... ranlib<br>
&gt; checking command to parse /usr/bin/nm -B output from gcc object... ok<=
br>
&gt; checking for dlfcn.h... yes<br>
&gt; checking for objdir... .libs<br>
&gt; checking if gcc supports -fno-rtti -fno-exceptions... no<br>
&gt; checking for gcc option to produce PIC... -fPIC -DPIC<br>
&gt; checking if gcc PIC flag -fPIC -DPIC works... yes<br>
&gt; checking if gcc static flag -static works... yes<br>
&gt; checking if gcc supports -c -o file.o... yes<br>
&gt; checking if gcc supports -c -o file.o... (cached) yes<br>
&gt; checking whether the gcc linker (/usr/i686-pc-linux-gnu/bin/ld) suppor=
ts shared libraries... yes<br>
&gt; checking whether -lc should be explicitly linked in... no<br>
&gt; checking dynamic linker characteristics... GNU/Linux ld.so<br>
&gt; checking how to hardcode library paths into programs... immediate<br>
&gt; checking whether stripping libraries is possible... yes<br>
&gt; checking if libtool supports shared libraries... yes<br>
&gt; checking whether to build shared libraries... yes<br>
&gt; checking whether to build static libraries... yes<br>
&gt; checking for bison... bison -y<br>
&gt; checking for flex... flex<br>
&gt; checking lex output file root... lex.yy<br>
&gt; checking lex library... -lfl<br>
&gt; checking whether yytext is a pointer... yes<br>
&gt; configure: creating ./config.status<br>
&gt; config.status: creating Makefile<br>
&gt; config.status: creating doc/Makefile<br>
&gt; config.status: creating doc/man/Makefile<br>
&gt; config.status: creating include/Makefile<br>
&gt; config.status: creating extras/Makefile<br>
&gt; config.status: creating extras/bindings/Makefile<br>
&gt; config.status: creating extras/bindings/swig/Makefile<br>
&gt; config.status: creating extras/bindings/swig/python/Makefile<br>
&gt; config.status: creating src/Makefile<br>
&gt; config.status: creating src/common/Makefile<br>
&gt; config.status: creating src/common/kernel-ctl/Makefile<br>
&gt; config.status: creating src/common/kernel-consumer/Makefile<br>
&gt; config.status: creating src/common/ust-consumer/Makefile<br>
&gt; config.status: creating src/common/hashtable/Makefile<br>
&gt; config.status: creating src/common/sessiond-comm/Makefile<br>
&gt; config.status: creating src/common/compat/Makefile<br>
&gt; config.status: creating src/common/relayd/Makefile<br>
&gt; config.status: creating src/common/testpoint/Makefile<br>
&gt; config.status: creating src/lib/Makefile<br>
&gt; config.status: creating src/lib/lttng-ctl/Makefile<br>
&gt; config.status: creating src/lib/lttng-ctl/filter/Makefile<br>
&gt; config.status: creating src/lib/lttng-ctl/lttng-ctl.pc<br>
&gt; config.status: creating src/bin/Makefile<br>
&gt; config.status: creating src/bin/lttng-consumerd/Makefile<br>
&gt; config.status: creating src/bin/lttng-sessiond/Makefile<br>
&gt; config.status: creating src/bin/lttng-relayd/Makefile<br>
&gt; config.status: creating src/bin/lttng/Makefile<br>
&gt; config.status: creating tests/Makefile<br>
&gt; config.status: creating tests/kernel/Makefile<br>
&gt; config.status: creating tests/tools/Makefile<br>
&gt; config.status: creating tests/tools/streaming/Makefile<br>
&gt; config.status: creating tests/tools/filtering/Makefile<br>
&gt; config.status: creating tests/tools/health/Makefile<br>
&gt; config.status: creating tests/ust/Makefile<br>
&gt; config.status: creating tests/ust/nprocesses/Makefile<br>
&gt; config.status: creating tests/ust/high-throughput/Makefile<br>
&gt; config.status: creating tests/ust/low-throughput/Makefile<br>
&gt; config.status: creating tests/ust/before-after/Makefile<br>
&gt; config.status: creating tests/ust/multi-session/Makefile<br>
&gt; config.status: creating tests/ust/overlap/Makefile<br>
&gt; config.status: creating tests/ust/overlap/demo/Makefile<br>
&gt; config.status: creating include/config.h<br>
&gt; config.status: include/config.h is unchanged<br>
&gt; config.status: executing depfiles commands<br>
&gt; config.status: executing libtool commands<br>
&gt;<br>
&gt; Version name: Basse Messe<br>
&gt; Light coloured German ale whose style was named after the city Cologne=
 (Koln) where it was first brewed. It is a rather simple beer with lightly =
fruity aromas and a delicate hoppy fragrance. The beer has a pronounced mal=
ty taste with a subtle bitter aftertaste<br>

&gt;<br>
&gt; Target architecture: i686<br>
&gt; Lttng-UST support: Enabled<br>
&gt; Python binding: Disabled<br>
&gt; All binaries will be built.<br>
&gt;<br>
&gt; Binaries will be installed in:=A0 /usr/local/bin<br>
&gt; Libraries will be installed in: /usr/local/lib<br>
&gt;<br>
&gt; The sessiond daemon will look in the following directories: <br>
&gt; 32-bit consumerd executable at: /usr/local/lib/lttng/libexec/lttng-con=
sumerd<br>
&gt; 32-bit consumer libraries in:=A0=A0 /usr/local/lib<br>
&gt; 64-bit consumerd executable at: /usr/local/lib/lttng/libexec/lttng-con=
sumerd<br>
&gt; 64-bit consumer libraries in:=A0=A0 /usr/local/lib<br>
&gt;<br>
&gt; 3) lttng-tools # make=A0=A0=A0=A0=A0 <br>
&gt; Making all in src<br>
&gt; make[1]: Entering directory `/usr/src/LTTng/lttng-tools/src&#39;<br>
&gt; Making all in common<br>
&gt; make[2]: Entering directory `/usr/src/LTTng/lttng-tools/src/common&#39=
;<br>
&gt; Making all in compat<br>
&gt; make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common/com=
pat&#39;<br>
&gt; =A0 CC=A0=A0=A0=A0 compat-fcntl.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 compat-epoll.lo<br>
&gt; =A0 CCLD=A0=A0 <a href=3D"http://libcompat.la">libcompat.la</a><br>
&gt; make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common/comp=
at&#39;<br>
&gt; Making all in hashtable<br>
&gt; make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common/has=
htable&#39;<br>
&gt; =A0 CC=A0=A0=A0=A0 hashtable.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 utils.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 rculfhash.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 rculfhash-mm-chunk.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 rculfhash-mm-mmap.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 rculfhash-mm-order.lo<br>
&gt; =A0 CCLD=A0=A0 <a href=3D"http://libhashtable.la">libhashtable.la</a><=
br>
&gt; make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common/hash=
table&#39;<br>
&gt; Making all in kernel-ctl<br>
&gt; make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common/ker=
nel-ctl&#39;<br>
&gt; =A0 CC=A0=A0=A0=A0 kernel-ctl.lo<br>
&gt; =A0 CCLD=A0=A0 <a href=3D"http://libkernel-ctl.la">libkernel-ctl.la</a=
><br>
&gt; make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common/kern=
el-ctl&#39;<br>
&gt; Making all in sessiond-comm<br>
&gt; make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common/ses=
siond-comm&#39;<br>
&gt; =A0 CC=A0=A0=A0=A0 sessiond-comm.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 unix.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 inet.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 inet6.lo<br>
&gt; =A0 CCLD=A0=A0 <a href=3D"http://libsessiond-comm.la">libsessiond-comm=
.la</a><br>
&gt; make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common/sess=
iond-comm&#39;<br>
&gt; Making all in relayd<br>
&gt; make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common/rel=
ayd&#39;<br>
&gt; =A0 CC=A0=A0=A0=A0 relayd.lo<br>
&gt; relayd.c: In function &#39;recv_reply&#39;:<br>
&gt; relayd.c:90: warning: format &#39;%ld&#39; expects type &#39;long int&=
#39;, but argument 3 has type &#39;size_t&#39;<br>
&gt; relayd.c:90: warning: format &#39;%ld&#39; expects type &#39;long int&=
#39;, but argument 3 has type &#39;size_t&#39;<br>
&gt; relayd.c:90: warning: format &#39;%ld&#39; expects type &#39;long int&=
#39;, but argument 3 has type &#39;size_t&#39;<br>
&gt; relayd.c:90: warning: format &#39;%ld&#39; expects type &#39;long int&=
#39;, but argument 3 has type &#39;size_t&#39;<br>
&gt; relayd.c:98: warning: format &#39;%lu&#39; expects type &#39;long unsi=
gned int&#39;, but argument 4 has type &#39;size_t&#39;<br>
&gt; relayd.c:98: warning: format &#39;%lu&#39; expects type &#39;long unsi=
gned int&#39;, but argument 4 has type &#39;size_t&#39;<br>
&gt; relayd.c:98: warning: format &#39;%lu&#39; expects type &#39;long unsi=
gned int&#39;, but argument 4 has type &#39;size_t&#39;<br>
&gt; relayd.c:98: warning: format &#39;%lu&#39; expects type &#39;long unsi=
gned int&#39;, but argument 4 has type &#39;size_t&#39;<br>
&gt; relayd.c: In function &#39;relayd_send_data_hdr&#39;:<br>
&gt; relayd.c:353: warning: format &#39;%ld&#39; expects type &#39;long int=
&#39;, but argument 3 has type &#39;size_t&#39;<br>
&gt; relayd.c:353: warning: format &#39;%ld&#39; expects type &#39;long int=
&#39;, but argument 3 has type &#39;size_t&#39;<br>
&gt; relayd.c:353: warning: format &#39;%ld&#39; expects type &#39;long int=
&#39;, but argument 3 has type &#39;size_t&#39;<br>
&gt; relayd.c:353: warning: format &#39;%ld&#39; expects type &#39;long int=
&#39;, but argument 3 has type &#39;size_t&#39;<br>
&gt; =A0 CCLD=A0=A0 <a href=3D"http://librelayd.la">librelayd.la</a><br>
&gt; make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common/rela=
yd&#39;<br>
&gt; Making all in kernel-consumer<br>
&gt; make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common/ker=
nel-consumer&#39;<br>
&gt; =A0 CC=A0=A0=A0=A0 kernel-consumer.lo<br>
&gt; =A0 CCLD=A0=A0 <a href=3D"http://libkernel-consumer.la">libkernel-cons=
umer.la</a><br>
&gt; make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common/kern=
el-consumer&#39;<br>
&gt; Making all in ust-consumer<br>
&gt; make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common/ust=
-consumer&#39;<br>
&gt; =A0 CC=A0=A0=A0=A0 ust-consumer.lo<br>
&gt; ust-consumer.c: In function &#39;lttng_ustconsumer_read_subbuffer&#39;=
:<br>
&gt; ust-consumer.c:562: warning: format &#39;%zd&#39; expects type &#39;si=
gned size_t&#39;, but argument 3 has type &#39;long int&#39;<br>
&gt; ust-consumer.c:562: warning: format &#39;%zd&#39; expects type &#39;si=
gned size_t&#39;, but argument 3 has type &#39;long int&#39;<br>
&gt; ust-consumer.c:562: warning: format &#39;%zd&#39; expects type &#39;si=
gned size_t&#39;, but argument 3 has type &#39;long int&#39;<br>
&gt; ust-consumer.c:562: warning: format &#39;%zd&#39; expects type &#39;si=
gned size_t&#39;, but argument 3 has type &#39;long int&#39;<br>
&gt; =A0 CCLD=A0=A0 <a href=3D"http://libust-consumer.la">libust-consumer.l=
a</a><br>
&gt; make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common/ust-=
consumer&#39;<br>
&gt; Making all in testpoint<br>
&gt; make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common/tes=
tpoint&#39;<br>
&gt; =A0 CC=A0=A0=A0=A0 testpoint.lo<br>
&gt; =A0 CCLD=A0=A0 <a href=3D"http://libtestpoint.la">libtestpoint.la</a><=
br>
&gt; make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common/test=
point&#39;<br>
&gt; make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/common&#39=
;<br>
&gt; =A0 CC=A0=A0=A0=A0 error.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 utils.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 runas.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 futex.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 uri.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 defaults.lo<br>
&gt; =A0 CCLD=A0=A0 <a href=3D"http://libcommon.la">libcommon.la</a><br>
&gt; =A0 CC=A0=A0=A0=A0 consumer.lo<br>
&gt; consumer.c: In function &#39;consumer_add_relayd_socket&#39;:<br>
&gt; consumer.c:2707: warning: &#39;relayd&#39; may be used uninitialized i=
n this function<br>
&gt; =A0 CCLD=A0=A0 <a href=3D"http://libconsumer.la">libconsumer.la</a><br=
>
&gt; copying selected object files to avoid basename conflicts...<br>
&gt; make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common&#39;=
<br>
&gt; make[2]: Leaving directory `/usr/src/LTTng/lttng-tools/src/common&#39;=
<br>
&gt; Making all in lib<br>
&gt; make[2]: Entering directory `/usr/src/LTTng/lttng-tools/src/lib&#39;<b=
r>
&gt; Making all in lttng-ctl<br>
&gt; make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-=
ctl&#39;<br>
&gt; Making all in filter<br>
&gt; make[4]: Entering directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-=
ctl/filter&#39;<br>
&gt; =A0 YACC=A0=A0 filter-parser.c<br>
&gt; updating filter-parser.h<br>
&gt; updating filter-parser.output<br>
&gt; make=A0 all-am<br>
&gt; make[5]: Entering directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-=
ctl/filter&#39;<br>
&gt; =A0 LEX=A0=A0=A0 filter-lexer.c<br>
&gt; =A0 CC=A0=A0=A0=A0 libfilter_la-filter-lexer.lo<br>
&gt; filter-lexer.c: In function &#39;yylex&#39;:<br>
&gt; filter-lexer.l:136: warning: ignoring return value of &#39;fwrite&#39;=
, declared with attribute warn_unused_result<br>
&gt; =A0 CC=A0=A0=A0=A0 libfilter_la-filter-parser.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 libfilter_la-filter-visitor-set-parent.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 libfilter_la-filter-visitor-xml.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 libfilter_la-filter-visitor-generate-ir.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 libfilter_la-filter-visitor-ir-check-binary-op-nest=
ing.lo<br>
&gt; =A0 CC=A0=A0=A0=A0 libfilter_la-filter-visitor-generate-bytecode.lo<br=
>
&gt; =A0 CCLD=A0=A0 <a href=3D"http://libfilter.la">libfilter.la</a><br>
&gt; =A0 CC=A0=A0=A0=A0 filter-grammar-test.o<br>
&gt; =A0 CCLD=A0=A0 filter-grammar-test<br>
&gt; make[5]: Leaving directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-c=
tl/filter&#39;<br>
&gt; make[4]: Leaving directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-c=
tl/filter&#39;<br>
&gt; make[4]: Entering directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-=
ctl&#39;<br>
&gt; =A0 CC=A0=A0=A0=A0 lttng-ctl.lo<br>
&gt; =A0 CCLD=A0=A0 <a href=3D"http://liblttng-ctl.la">liblttng-ctl.la</a><=
br>
&gt; copying selected object files to avoid basename conflicts...<br>
&gt; make[4]: Leaving directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-c=
tl&#39;<br>
&gt; make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/lib/lttng-c=
tl&#39;<br>
&gt; make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/lib&#39;<b=
r>
&gt; make[3]: Nothing to be done for `all-am&#39;.<br>
&gt; make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/lib&#39;<br=
>
&gt; make[2]: Leaving directory `/usr/src/LTTng/lttng-tools/src/lib&#39;<br=
>
&gt; Making all in bin<br>
&gt; make[2]: Entering directory `/usr/src/LTTng/lttng-tools/src/bin&#39;<b=
r>
&gt; Making all in lttng-consumerd<br>
&gt; make[3]: Entering directory `/usr/src/LTTng/lttng-tools/src/bin/lttng-=
consumerd&#39;<br>
&gt; =A0 CC=A0=A0=A0=A0 lttng-consumerd.o<br>
&gt; =A0 CCLD=A0=A0 lttng-consumerd<br>
&gt; /usr/lib/gcc/i686-pc-linux-gnu/4.4.4/../../../../i686-pc-linux-gnu/bin=
/ld: warning: liburcu-common.so.1, needed by /usr/local/lib/liblttng-ust-ct=
l.so, may conflict with liburcu-common.so.2<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_data_pending&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:2921: undefined refer=
ence to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:3030: undefined refer=
ence to `rcu_read_unlock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:3024: undefined refer=
ence to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_steal_stream_key&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:116: undefined refere=
nce to `rcu_read_lock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_find_stream&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:99: undefined referen=
ce to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:107: undefined refere=
nce to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_steal_stream_key&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:127: undefined refere=
nce to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_find_stream&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:107: undefined refere=
nce to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_steal_channel_key&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:161: undefined refere=
nce to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:172: undefined refere=
nce to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_add_channel&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:905: undefined refere=
nce to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:918: undefined refere=
nce to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `dest=
roy_relayd&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:234: undefined refere=
nce to `call_rcu_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_thread_sessiond_poll&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:2523: undefined refer=
ence to `rcu_register_thread_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:2639: undefined refer=
ence to `rcu_unregister_thread_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_del_channel&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:814: undefined refere=
nce to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:818: undefined refere=
nce to `rcu_read_unlock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:839: undefined refere=
nce to `call_rcu_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_del_metadata_stream&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1853: undefined refer=
ence to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1862: undefined refer=
ence to `rcu_read_unlock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1886: undefined refer=
ence to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1912: undefined refer=
ence to `rcu_read_unlock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1931: undefined refer=
ence to `call_rcu_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_thread_metadata_poll&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:2073: undefined refer=
ence to `rcu_register_thread_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `dest=
roy_stream_ht&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1793: undefined refer=
ence to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1801: undefined refer=
ence to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_thread_metadata_poll&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:2247: undefined refer=
ence to `rcu_unregister_thread_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:2183: undefined refer=
ence to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:2236: undefined refer=
ence to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_add_metadata_stream&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1959: undefined refer=
ence to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1998: undefined refer=
ence to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `vali=
date_endpoint_status_metadata_stream&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:2040: undefined refer=
ence to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:2055: undefined refer=
ence to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `lttn=
g_consumer_cleanup&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1044: undefined refer=
ence to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1053: undefined refer=
ence to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `clea=
nup_relayd_ht&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:246: undefined refere=
nce to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:255: undefined refere=
nce to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_del_stream&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:396: undefined refere=
nce to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:405: undefined refere=
nce to `rcu_read_unlock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:430: undefined refere=
nce to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:457: undefined refere=
nce to `rcu_read_unlock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:475: undefined refere=
nce to `call_rcu_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_thread_data_poll&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:2266: undefined refer=
ence to `rcu_register_thread_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_update_poll_array&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:940: undefined refere=
nce to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:961: undefined refere=
nce to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `dest=
roy_data_stream_ht&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1766: undefined refer=
ence to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1774: undefined refer=
ence to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_thread_data_poll&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:2505: undefined refer=
ence to `rcu_unregister_thread_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_add_stream&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:586: undefined refere=
nce to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:624: undefined refere=
nce to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `vali=
date_endpoint_status_data_stream&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:2015: undefined refer=
ence to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:2024: undefined refer=
ence to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `cons=
umer_allocate_stream&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:501: undefined refere=
nce to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:560: undefined refere=
nce to `rcu_read_unlock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:564: undefined refere=
nce to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `upda=
te_endpoint_status_by_netidx&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:273: undefined refere=
nce to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:290: undefined refere=
nce to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `lttn=
g_consumer_on_read_subbuffer_splice&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1517: undefined refer=
ence to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1687: undefined refer=
ence to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(consumer.o): In function `lttn=
g_consumer_on_read_subbuffer_mmap&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1345: undefined refer=
ence to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/consumer.c:1478: undefined refer=
ence to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(kernel-consumer.o): In functio=
n `lttng_kconsumer_recv_cmd&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.=
c:112: undefined reference to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.=
c:352: undefined reference to `rcu_read_unlock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.=
c:287: undefined reference to `rcu_read_unlock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.=
c:180: undefined reference to `rcu_read_unlock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/kernel-consumer/kernel-consumer.=
c:172: undefined reference to `rcu_read_unlock_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(hashtable.o): In function `cds=
_lfht_new&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/hashtable/rculfhash.h:167: undef=
ined reference to `rcu_flavor_mb&#39;<br>
&gt; ../../../src/common/.libs/libconsumer.a(ust-consumer.o): In function `=
lttng_ustconsumer_recv_cmd&#39;:<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:131:=
 undefined reference to `rcu_read_lock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:406:=
 undefined reference to `rcu_read_unlock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:376:=
 undefined reference to `rcu_read_unlock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:232:=
 undefined reference to `rcu_read_unlock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:165:=
 undefined reference to `rcu_read_unlock_mb&#39;<br>
&gt; /usr/src/LTTng/lttng-tools/src/common/ust-consumer/ust-consumer.c:226:=
 undefined reference to `rcu_read_unlock_mb&#39;<br>
&gt; collect2: ld returned 1 exit status<br>
&gt; make[3]: *** [lttng-consumerd] Error 1<br>
&gt; make[3]: Leaving directory `/usr/src/LTTng/lttng-tools/src/bin/lttng-c=
onsumerd&#39;<br>
&gt; make[2]: *** [all-recursive] Error 1<br>
&gt; make[2]: Leaving directory `/usr/src/LTTng/lttng-tools/src/bin&#39;<br=
>
&gt; make[1]: *** [all-recursive] Error 1<br>
&gt; make[1]: Leaving directory `/usr/src/LTTng/lttng-tools/src&#39;<br>
&gt; make: *** [all-recursive] Error 1<br>
&gt;<br>
</p>

--e89a8f3b9eb1111c0804d601ad32--


--===============0068044564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0068044564==--
