From: Vanni Genua <vannigenua@gmail.com>
Subject: Re: HOW TO DOWNLOAD LTTng 2.0 stable?
Date: Fri, 18 May 2012 07:23:39 +0000
Message-ID: <CAO8ONPy5pO5pSL6ywHED0UEtvc7fJLYAr7meghrECp0VDwM-Qw__43597.8336296559$1338865794$gmane$org@mail.gmail.com>
References: <CAO8ONPxd_9JOHLCMdQXqFK9NTPGri8_+nvnU+kJx-6PSgARAKQ@mail.gmail.com>
	<4FB3EDC0.7080006@polymtl.ca>
	<CAO8ONPxm=jvfqTe0Fto1hMFX2xm3XGtRUGyyBuO16Qh9wRoR8g@mail.gmail.com>
	<CAO8ONPyZqAEbbn2k_=YJi_3uFRKNg7TvWcX_ysJoGtzu4z9GYw@mail.gmail.com>
	<CAO8ONPxOYN+01YG8695hgck7-c-8ZoypysH90gx8n9C0jCfKag@mail.gmail.com>
	<4FB50A3E.7030508@polymtl.ca> <20120517143031.GA30839@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1787880546=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <vannigenua@gmail.com>) id 1SVHXN-0006jI-A5
	for lttng-dev@lists.lttng.org; Fri, 18 May 2012 03:23:47 -0400
Received: by wgbds11 with SMTP id ds11so607586wgb.5
	for <lttng-dev@lists.lttng.org>; Fri, 18 May 2012 00:23:39 -0700 (PDT)
In-Reply-To: <20120517143031.GA30839@Krystal>
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

--===============1787880546==
Content-Type: multipart/alternative; boundary=f46d0418262868756204c04a6e57

--f46d0418262868756204c04a6e57
Content-Type: text/plain; charset=ISO-8859-1

I did it a minute ago, now the problems are the undefined references at the
end of this logs:

localhost lttng-ust-2.0.1 # ./configure --build=armv7a-unknown-linux-
gnueabi

checking build system type...
armv7a-unknown-linux-gnueabi

checking host system type...
armv7a-unknown-linux-gnueabi

checking target system type...
armv7a-unknown-linux-gnueabi

checking how to convert armv7a-unknown-linux-gnueabi file names to
armv7a-unknown-linux-gnueabi format...
func_convert_file_noop
checking how to convert armv7a-unknown-linux-gnueabi file names to
toolchain format...
func_convert_file_noop
checking library format for the host system...
elf32-littlearm

configure: creating
./config.status

config.status: creating
Makefile

config.status: creating
doc/Makefile

config.status: creating
doc/examples/Makefile

config.status: creating
include/Makefile

config.status: creating
include/lttng/ust-version.h

config.status: creating
snprintf/Makefile

config.status: creating
libringbuffer/Makefile

config.status: creating
liblttng-ust-comm/Makefile

config.status: creating
liblttng-ust/Makefile

config.status: creating
liblttng-ust-ctl/Makefile

config.status: creating
liblttng-ust-fork/Makefile

config.status: creating
liblttng-ust-java/Makefile

config.status: creating
liblttng-ust-libc-wrapper/Makefile

config.status: creating
tools/Makefile

config.status: creating
tests/Makefile

config.status: creating
tests/hello/Makefile

config.status: creating
tests/hello-static-lib/Makefile

config.status: creating
tests/hello.cxx/Makefile

config.status: creating
tests/demo/Makefile

config.status: creating
tests/fork/Makefile

config.status: creating
tests/ust-basic-tracing/Makefile

config.status: creating
tests/ust-multi-test/Makefile

config.status: creating
lttng-ust.pc

config.status: creating
config.h

config.status: config.h is
unchanged

config.status: creating
include/lttng/ust-config.h

config.status: include/lttng/ust-config.h is
unchanged

config.status: executing depfiles
commands

config.status: executing libtool
commands



Version name:
Annedd'ale

New type of beer, 100% from Quebec, flavored with sapin beaumier needles,
with a touch of
hops.


LTTng-UST will be built with the following
options:

Library format:
elf32-littlearm



Java support (JNI):
Disabled

sdt.h integration:
Disabled



Type 'make' to
compile.

localhost lttng-ust-2.0.1 #
make

make
all-recursive

make[1]: Entering directory
`/usr/src/lttng-ust-2.0.1'

Making all in
.

make[2]: Entering directory
`/usr/src/lttng-ust-2.0.1'

make[2]: Leaving directory
`/usr/src/lttng-ust-2.0.1'

Making all in
include

make[2]: Entering directory
`/usr/src/lttng-ust-2.0.1/include'

make[2]: Nothing to be done for
`all'.

make[2]: Leaving directory
`/usr/src/lttng-ust-2.0.1/include'

Making all in
snprintf

make[2]: Entering directory
`/usr/src/lttng-ust-2.0.1/snprintf'

make[2]: Nothing to be done for
`all'.

make[2]: Leaving directory
`/usr/src/lttng-ust-2.0.1/snprintf'

Making all in
libringbuffer

make[2]: Entering directory
`/usr/src/lttng-ust-2.0.1/libringbuffer'

  CC
libringbuffer_la-ring_buffer_backend.lo

  CC
libringbuffer_la-ring_buffer_frontend.lo

  CCLD   libringbuffer.la

make[2]: Leaving directory
`/usr/src/lttng-ust-2.0.1/libringbuffer'

Making all in
liblttng-ust-comm

make[2]: Entering directory
`/usr/src/lttng-ust-2.0.1/liblttng-ust-comm'

make[2]: Nothing to be done for
`all'.

make[2]: Leaving directory
`/usr/src/lttng-ust-2.0.1/liblttng-ust-comm'

Making all in
liblttng-ust

make[2]: Entering directory
`/usr/src/lttng-ust-2.0.1/liblttng-ust'

  CC
liblttng_ust_tracepoint_la-tracepoint.lo

  CCLD   liblttng-ust-tracepoint.la

  CC
lttng-ust-comm.lo

  CC
lttng-ust-abi.lo

  CC
ltt-probes.lo

  CC
lttng-probe-ust.lo

  CC
lttng-context-vtid.lo

  CC
lttng-context-vpid.lo

  CC
lttng-context-pthread-id.lo

  CC
lttng-context-procname.lo

  CC
ltt-context.lo

  CC
ltt-events.lo

  CCLD   liblttng-ust-runtime.la

  CC
ust-core.lo

  CC
ltt-ring-buffer-client-discard.lo

  CC
ltt-ring-buffer-client-overwrite.lo

  CC
ltt-ring-buffer-metadata-client.lo

  CCLD   liblttng-ust-support.la

  CCLD   liblttng-ust.la

/usr/lib/gcc/armv7a-unknown-linux-gnueabi/4.5.3/../../../../armv7a-unknown-linux-gnueabi/bin/ld:
warning: creating a DT_TEXTREL in object.
copying selected object files to avoid basename
conflicts...

make[2]: Leaving directory
`/usr/src/lttng-ust-2.0.1/liblttng-ust'

Making all in
liblttng-ust-ctl

make[2]: Entering directory
`/usr/src/lttng-ust-2.0.1/liblttng-ust-ctl'

  CC
ustctl.lo

  CCLD   liblttng-ust-ctl.la

/usr/lib/gcc/armv7a-unknown-linux-gnueabi/4.5.3/../../../../armv7a-unknown-linux-gnueabi/bin/ld:
warning: creating a DT_TEXTREL in object.
make[2]: Leaving directory
`/usr/src/lttng-ust-2.0.1/liblttng-ust-ctl'

Making all in
liblttng-ust-fork

make[2]: Entering directory
`/usr/src/lttng-ust-2.0.1/liblttng-ust-fork'

  CCLD   liblttng-ust-fork.la

make[2]: Leaving directory
`/usr/src/lttng-ust-2.0.1/liblttng-ust-fork'

Making all in
liblttng-ust-libc-wrapper

make[2]: Entering directory
`/usr/src/lttng-ust-2.0.1/liblttng-ust-libc-wrapper'

  CC
lttng-ust-malloc.lo

  CCLD   liblttng-ust-libc-wrapper.la

make[2]: Leaving directory
`/usr/src/lttng-ust-2.0.1/liblttng-ust-libc-wrapper'

Making all in
tools

make[2]: Entering directory
`/usr/src/lttng-ust-2.0.1/tools'

make[2]: Nothing to be done for
`all'.

make[2]: Leaving directory
`/usr/src/lttng-ust-2.0.1/tools'

Making all in
tests

make[2]: Entering directory
`/usr/src/lttng-ust-2.0.1/tests'

Making all in
.

make[3]: Entering directory
`/usr/src/lttng-ust-2.0.1/tests'

make[3]: Nothing to be done for
`all-am'.

make[3]: Leaving directory
`/usr/src/lttng-ust-2.0.1/tests'

Making all in
hello

make[3]: Entering directory
`/usr/src/lttng-ust-2.0.1/tests/hello'

  CC
tp.o

  CCLD
hello

../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
`__num_possible_cpus'

../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
`shm_object_table_create'

../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
`shm_object_table_append_shadow'

../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
`shm_object_table_append'

../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
`zalloc_shm'

../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
`_get_num_possible_cpus'

../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
`align_shm'

../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
`shm_object_table_destroy'

collect2: ld returned 1 exit
status

make[3]: *** [hello] Error
1

make[3]: Leaving directory
`/usr/src/lttng-ust-2.0.1/tests/hello'

make[2]: *** [all-recursive] Error
1

make[2]: Leaving directory
`/usr/src/lttng-ust-2.0.1/tests'

make[1]: *** [all-recursive] Error
1

make[1]: Leaving directory
`/usr/src/lttng-ust-2.0.1'

make: *** [all] Error
2

localhost lttng-ust-2.0.1 #


On Thu, May 17, 2012 at 2:30 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> * Alexandre Montplaisir (alexandre.montplaisir@polymtl.ca) wrote:
> > This is an interesting problem, I'll forward it to the mailing list.
> >
> >
> > On 12-05-17 10:02 AM, Vanni Genua wrote:
> > > Also why I get this error?
> > > see the attached log file.
> > > Best regards.
> > > V.G.
> > >
> > >
> >
> > localhost lttng-ust-2.0.1 # ./configure
> > checking build system type... armv7l-unknown-linux-gnueabi
> > checking host system type... armv7l-unknown-linux-gnueabi
> > checking target system type... armv7l-unknown-linux-gnueabi
> > checking for a BSD-compatible install... /usr/bin/install -c
> > checking whether build environment is sane... yes
> > checking for a thread-safe mkdir -p... /bin/mkdir -p
> > checking for gawk... gawk
> > checking whether make sets $(MAKE)... yes
> > checking whether make supports nested variables... yes
> > checking for a sed that does not truncate output... /bin/sed
> > checking for gcc... gcc
> > checking whether the C compiler works... yes
> > checking for C compiler default output file name... a.out
> > checking for suffix of executables...
> > checking whether we are cross compiling... no
> > checking for suffix of object files... o
> > checking whether we are using the GNU C compiler... yes
> > checking whether gcc accepts -g... yes
> > checking for gcc option to accept ISO C89... none needed
> > checking for style of include used by make... GNU
> > checking dependency style of gcc... gcc3
> > checking for g++... g++
> > checking whether we are using the GNU C++ compiler... yes
> > checking whether g++ accepts -g... yes
> > checking dependency style of g++... gcc3
> > checking whether make sets $(MAKE)... (cached) yes
> > checking how to print strings... printf
> > checking for a sed that does not truncate output... (cached) /bin/sed
> > checking for grep that handles long lines and -e... /bin/grep
> > checking for egrep... /bin/grep -E
> > checking for fgrep... /bin/grep -F
> > checking for ld used by gcc... /usr/armv7a-unknown-linux-gnueabi/bin/ld
> > checking if the linker (/usr/armv7a-unknown-linux-gnueabi/bin/ld) is GNU
> ld... yes
> > checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
> > checking the name lister (/usr/bin/nm -B) interface... BSD nm
> > checking whether ln -s works... yes
> > checking the maximum length of command line arguments... 1572864
> > checking whether the shell understands some XSI constructs... yes
> > checking whether the shell understands "+="... yes
> > checking how to convert armv7l-unknown-linux-gnueabi file names to
> armv7l-unknown-linux-gnueabi format... func_convert_file_noop
> > checking how to convert armv7l-unknown-linux-gnueabi file names to
> toolchain format... func_convert_file_noop
> > checking for /usr/armv7a-unknown-linux-gnueabi/bin/ld option to reload
> object files... -r
> > checking for objdump... objdump
> > checking how to recognize dependent libraries... pass_all
> > checking for dlltool... no
> > checking how to associate runtime and link libraries... printf %s\n
> > checking for ar... ar
> > checking for archiver @FILE support... @
> > checking for strip... strip
> > checking for ranlib... ranlib
> > checking command to parse /usr/bin/nm -B output from gcc object... ok
> > checking for sysroot... no
> > checking for mt... no
> > checking if : is a manifest tool... no
> > checking how to run the C preprocessor... gcc -E
> > checking for ANSI C header files... yes
> > checking for sys/types.h... yes
> > checking for sys/stat.h... yes
> > checking for stdlib.h... yes
> > checking for string.h... yes
> > checking for memory.h... yes
> > checking for strings.h... yes
> > checking for inttypes.h... yes
> > checking for stdint.h... yes
> > checking for unistd.h... yes
> > checking for dlfcn.h... yes
> > checking for objdir... .libs
> > checking if gcc supports -fno-rtti -fno-exceptions... no
> > checking for gcc option to produce PIC... -fPIC -DPIC
> > checking if gcc PIC flag -fPIC -DPIC works... yes
> > checking if gcc static flag -static works... yes
> > checking if gcc supports -c -o file.o... yes
> > checking if gcc supports -c -o file.o... (cached) yes
> > checking whether the gcc linker
> (/usr/armv7a-unknown-linux-gnueabi/bin/ld) supports shared libraries... yes
> > checking whether -lc should be explicitly linked in... no
> > checking dynamic linker characteristics... GNU/Linux ld.so
> > checking how to hardcode library paths into programs... immediate
> > checking whether stripping libraries is possible... yes
> > checking if libtool supports shared libraries... yes
> > checking whether to build shared libraries... yes
> > checking whether to build static libraries... yes
> > checking how to run the C++ preprocessor... g++ -E
> > checking for ld used by g++... /usr/armv7a-unknown-linux-gnueabi/bin/ld
> > checking if the linker (/usr/armv7a-unknown-linux-gnueabi/bin/ld) is GNU
> ld... yes
> > checking whether the g++ linker
> (/usr/armv7a-unknown-linux-gnueabi/bin/ld) supports shared libraries... yes
> > checking for g++ option to produce PIC... -fPIC -DPIC
> > checking if g++ PIC flag -fPIC -DPIC works... yes
> > checking if g++ static flag -static works... yes
> > checking if g++ supports -c -o file.o... yes
> > checking if g++ supports -c -o file.o... (cached) yes
> > checking whether the g++ linker
> (/usr/armv7a-unknown-linux-gnueabi/bin/ld) supports shared libraries... yes
> > checking dynamic linker characteristics... (cached) GNU/Linux ld.so
> > checking how to hardcode library paths into programs... immediate
> > checking for dlopen in -ldl... yes
> > checking for pthread_create in -lpthread... yes
> > checking for uuid_generate in -luuid... yes
> > checking for inline... inline
> > checking for stdlib.h... (cached) yes
> > checking for GNU libc compatible malloc... yes
> > checking for gettimeofday... yes
> > checking for munmap... yes
> > checking for socket... yes
> > checking for strerror... yes
> > checking for strtol... yes
> > checking for sched_getcpu... yes
> > checking for sysconf... yes
> > checking for makeinfo... yes
> > checking urcu-bp.h usability... yes
> > checking urcu-bp.h presence... yes
> > checking for urcu-bp.h... yes
> > checking caa_likely()... yes
> > checking for synchronize_rcu_bp in -lurcu-bp... yes
> > checking for call_rcu_bp in -lurcu-bp... yes
> > checking library format for the host system... configure: error: unable
> to detect library format (unsupported architecture (armv7l)?)
>
> Does it help if you add a line:
>
>        armv7l) LIBFORMAT="elf32-littlearm"; NO_UNALIGNED_ACCESS=1 ;;
>
> near line 188 of configure.ac ?
>
> What we did in userspace RCU is to use "arm*".
>
> Thanks,
>
> Mathieu
>
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
>

--f46d0418262868756204c04a6e57
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SSBkaWQgaXQgYSBtaW51dGUgYWdvLCBub3cgdGhlIHByb2JsZW1zIGFyZSB0aGUgdW5kZWZpbmVk
IHJlZmVyZW5jZXMgYXQgdGhlIGVuZCBvZiB0aGlzIGxvZ3M6PGJyPjxicj5sb2NhbGhvc3QgbHR0
bmctdXN0LTIuMC4xICMgLi9jb25maWd1cmUgLS1idWlsZD1hcm12N2EtdW5rbm93bi1saW51eC08
ZGl2IGlkPSI6MmkiPmdudWVhYmmgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+CgpjaGVja2luZyBi
dWlsZCBzeXN0ZW0gdHlwZS4uLiBhcm12N2EtdW5rbm93bi1saW51eC1nbnVlYWJpoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPmNoZWNraW5nIGhvc3Qgc3lzdGVtIHR5
cGUuLi4gYXJtdjdhLXVua25vd24tbGludXgtZ251ZWFiaaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoCA8YnI+CgpjaGVja2luZyB0YXJnZXQgc3lzdGVtIHR5cGUuLi4gYXJt
djdhLXVua25vd24tbGludXgtZ251ZWFiaaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKAgPGJyPmNoZWNraW5nCiBob3cgdG8gY29udmVydCBhcm12N2EtdW5rbm93bi1saW51eC1n
bnVlYWJpIGZpbGUgbmFtZXMgdG8gCmFybXY3YS11bmtub3duLWxpbnV4LWdudWVhYmkgZm9ybWF0
Li4uIGZ1bmNfY29udmVydF9maWxlX25vb3CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4K
Y2hlY2tpbmcgaG93IHRvIGNvbnZlcnQgYXJtdjdhLXVua25vd24tbGludXgtZ251ZWFiaSBmaWxl
IG5hbWVzIHRvIHRvb2xjaGFpbiBmb3JtYXQuLi4gZnVuY19jb252ZXJ0X2ZpbGVfbm9vcKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5jaGVja2luZyBsaWJy
YXJ5IGZvcm1hdCBmb3IgdGhlIGhvc3Qgc3lzdGVtLi4uIGVsZjMyLWxpdHRsZWFybaCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKY29uZmlndXJlOiBjcmVhdGluZyAuL2Nv
bmZpZy5zdGF0dXOgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgIDxicj5jb25maWcuc3RhdHVzOiBjcmVhdGluZyBNYWtlZmlsZaCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKAgPGJyPgoKY29uZmlnLnN0YXR1czogY3JlYXRpbmcgZG9jL01ha2VmaWxloKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5jb25m
aWcuc3RhdHVzOiBjcmVhdGluZyBkb2MvZXhhbXBsZXMvTWFrZWZpbGWgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKY29uZmlnLnN0YXR1czog
Y3JlYXRpbmcgaW5jbHVkZS9NYWtlZmlsZaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5jb25maWcuc3RhdHVzOiBjcmVhdGluZyBpbmNs
dWRlL2x0dG5nL3VzdC12ZXJzaW9uLmigoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKAgPGJyPgoKY29uZmlnLnN0YXR1czogY3JlYXRpbmcgc25wcmludGYvTWFrZWZp
bGWgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
IDxicj5jb25maWcuc3RhdHVzOiBjcmVhdGluZyBsaWJyaW5nYnVmZmVyL01ha2VmaWxloKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKY29uZmln
LnN0YXR1czogY3JlYXRpbmcgbGlibHR0bmctdXN0LWNvbW0vTWFrZWZpbGWgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5jb25maWcuc3RhdHVzOiBjcmVh
dGluZyBsaWJsdHRuZy11c3QvTWFrZWZpbGWgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKY29uZmlnLnN0YXR1czogY3JlYXRpbmcgbGlibHR0
bmctdXN0LWN0bC9NYWtlZmlsZaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIDxicj5jb25maWcuc3RhdHVzOiBjcmVhdGluZyBsaWJsdHRuZy11c3QtZm9yay9N
YWtlZmlsZaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJy
PgoKY29uZmlnLnN0YXR1czogY3JlYXRpbmcgbGlibHR0bmctdXN0LWphdmEvTWFrZWZpbGWgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5jb25maWcuc3Rh
dHVzOiBjcmVhdGluZyBsaWJsdHRuZy11c3QtbGliYy13cmFwcGVyL01ha2VmaWxloKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKY29uZmlnLnN0YXR1czogY3JlYXRp
bmcgdG9vbHMvTWFrZWZpbGWgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgIDxicj5jb25maWcuc3RhdHVzOiBjcmVhdGluZyB0ZXN0cy9NYWtl
ZmlsZaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKAgPGJyPgoKY29uZmlnLnN0YXR1czogY3JlYXRpbmcgdGVzdHMvaGVsbG8vTWFrZWZpbGWg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5j
b25maWcuc3RhdHVzOiBjcmVhdGluZyB0ZXN0cy9oZWxsby1zdGF0aWMtbGliL01ha2VmaWxloKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKY29uZmlnLnN0YXR1
czogY3JlYXRpbmcgdGVzdHMvaGVsbG8uY3h4L01ha2VmaWxloKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5jb25maWcuc3RhdHVzOiBjcmVhdGluZyB0
ZXN0cy9kZW1vL01ha2VmaWxloKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKAgPGJyPgoKY29uZmlnLnN0YXR1czogY3JlYXRpbmcgdGVzdHMvZm9yay9N
YWtlZmlsZaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgIDxicj5jb25maWcuc3RhdHVzOiBjcmVhdGluZyB0ZXN0cy91c3QtYmFzaWMtdHJhY2luZy9N
YWtlZmlsZaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKY29u
ZmlnLnN0YXR1czogY3JlYXRpbmcgdGVzdHMvdXN0LW11bHRpLXRlc3QvTWFrZWZpbGWgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5jb25maWcuc3RhdHVzOiBj
cmVhdGluZyBsdHRuZy11c3QucGOgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKY29uZmlnLnN0YXR1czogY3JlYXRpbmcgY29u
ZmlnLmigoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgIDxicj5jb25maWcuc3RhdHVzOiBjb25maWcuaCBpcyB1bmNoYW5nZWSgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAg
PGJyPgoKY29uZmlnLnN0YXR1czogY3JlYXRpbmcgaW5jbHVkZS9sdHRuZy91c3QtY29uZmlnLmig
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5jb25maWcu
c3RhdHVzOiBpbmNsdWRlL2x0dG5nL3VzdC1jb25maWcuaCBpcyB1bmNoYW5nZWSgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKY29uZmlnLnN0YXR1czogZXhl
Y3V0aW5nIGRlcGZpbGVzIGNvbW1hbmRzoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5jb25maWcuc3RhdHVzOiBleGVjdXRpbmcgbGlidG9v
bCBjb21tYW5kc6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKAgPGJyPgoKoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxi
cj5WZXJzaW9uIG5hbWU6IEFubmVkZCYjMzk7YWxloKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KCk5ldyB0
eXBlIG9mIGJlZXIsIDEwMCUgZnJvbSBRdWViZWMsIGZsYXZvcmVkIHdpdGggc2FwaW4gYmVhdW1p
ZXIgbmVlZGxlcywgd2l0aCBhIHRvdWNoIG9mIGhvcHMuoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+oKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KCkxUVG5nLVVTVCB3aWxsIGJlIGJ1aWx0IHdpdGgg
dGhlIGZvbGxvd2luZyBvcHRpb25zOqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoCA8YnI+TGlicmFyeSBmb3JtYXQ6IGVsZjMyLWxpdHRsZWFybaCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxi
cj4KCqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+SmF2YSBzdXBw
b3J0IChKTkkpOiBEaXNhYmxlZKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KCnNkdC5oIGludGVncmF0aW9uOqAg
RGlzYWJsZWSgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgIDxicj4KClR5cGUgJiMzOTttYWtlJiMzOTsgdG8gY29tcGlsZS6goKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgIDxicj5sb2NhbGhvc3QgbHR0bmctdXN0LTIuMC4xICMgbWFrZaCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKbWFr
ZaAgYWxsLXJlY3Vyc2l2ZaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5tYWtlWzFdOiBFbnRlcmlu
ZyBkaXJlY3RvcnkgYC91c3Ivc3JjL2x0dG5nLXVzdC0yLjAuMSYjMzk7oKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KCk1ha2luZyBhbGwgaW4gLqCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoCA8YnI+bWFrZVsyXTogRW50ZXJpbmcgZGlyZWN0b3J5IGAvdXNyL3Ny
Yy9sdHRuZy11c3QtMi4wLjEmIzM5O6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoCA8YnI+CgptYWtlWzJdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Vzci9zcmMvbHR0bmct
dXN0LTIuMC4xJiMzOTugoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
IDxicj5NYWtpbmcgYWxsIGluIGluY2x1ZGWgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKbWFrZVsy
XTogRW50ZXJpbmcgZGlyZWN0b3J5IGAvdXNyL3NyYy9sdHRuZy11c3QtMi4wLjEvaW5jbHVkZSYj
Mzk7oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+bWFrZVsyXTogTm90aGlu
ZyB0byBiZSBkb25lIGZvciBgYWxsJiMzOTsuoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+CgptYWtlWzJdOiBMZWF2aW5nIGRpcmVj
dG9yeSBgL3Vzci9zcmMvbHR0bmctdXN0LTIuMC4xL2luY2x1ZGUmIzM5O6CgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5NYWtpbmcgYWxsIGluIHNucHJpbnRmoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKAgPGJyPgoKbWFrZVsyXTogRW50ZXJpbmcgZGlyZWN0b3J5IGAvdXNyL3NyYy9sdHRu
Zy11c3QtMi4wLjEvc25wcmludGYmIzM5O6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oCA8YnI+bWFrZVsyXTogTm90aGluZyB0byBiZSBkb25lIGZvciBgYWxsJiMzOTsuoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+Cgpt
YWtlWzJdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Vzci9zcmMvbHR0bmctdXN0LTIuMC4xL3NucHJp
bnRmJiMzOTugoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5NYWtpbmcgYWxs
IGluIGxpYnJpbmdidWZmZXKgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKbWFrZVsyXTogRW50ZXJpbmcgZGly
ZWN0b3J5IGAvdXNyL3NyYy9sdHRuZy11c3QtMi4wLjEvbGlicmluZ2J1ZmZlciYjMzk7oKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+oCBDQ6CgoKAgbGlicmluZ2J1ZmZlcl9sYS1yaW5n
X2J1ZmZlcl9iYWNrZW5kLmxvoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIDxicj4KCqAgQ0OgoKCgIGxpYnJpbmdidWZmZXJfbGEtcmluZ19idWZmZXJfZnJv
bnRlbmQubG+goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8
YnI+oCBDQ0xEoKAgPGEgaHJlZj0iaHR0cDovL2xpYnJpbmdidWZmZXIubGEiIHRhcmdldD0iX2Js
YW5rIj5saWJyaW5nYnVmZmVyLmxhPC9hPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KCm1ha2VbMl06IExl
YXZpbmcgZGlyZWN0b3J5IGAvdXNyL3NyYy9sdHRuZy11c3QtMi4wLjEvbGlicmluZ2J1ZmZlciYj
Mzk7oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPk1ha2luZyBhbGwgaW4gbGlibHR0
bmctdXN0LWNvbW2goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+CgptYWtlWzJdOiBFbnRlcmluZyBkaXJlY3RvcnkgYC91
c3Ivc3JjL2x0dG5nLXVzdC0yLjAuMS9saWJsdHRuZy11c3QtY29tbSYjMzk7oKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgIDxicj5tYWtlWzJdOiBOb3RoaW5nIHRvIGJlIGRvbmUgZm9yIGBhbGwmIzM5
Oy6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgIDxicj4KCm1ha2VbMl06IExlYXZpbmcgZGlyZWN0b3J5IGAvdXNyL3NyYy9sdHRuZy11c3Qt
Mi4wLjEvbGlibHR0bmctdXN0LWNvbW0mIzM5O6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJy
Pk1ha2luZyBhbGwgaW4gbGlibHR0bmctdXN0oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+CgptYWtlWzJdOiBF
bnRlcmluZyBkaXJlY3RvcnkgYC91c3Ivc3JjL2x0dG5nLXVzdC0yLjAuMS9saWJsdHRuZy11c3Qm
IzM5O6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj6gIENDoKCgoCBsaWJsdHRuZ191
c3RfdHJhY2Vwb2ludF9sYS10cmFjZXBvaW50LmxvoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKoCBDQ0xEoKAgPGEgaHJlZj0iaHR0cDovL2xpYmx0
dG5nLXVzdC10cmFjZXBvaW50LmxhIiB0YXJnZXQ9Il9ibGFuayI+bGlibHR0bmctdXN0LXRyYWNl
cG9pbnQubGE8L2E+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoCA8YnI+CqAgQ0OgoKCgIGx0dG5nLXVzdC1jb21tLmxvoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoCA8YnI+CqAgQ0OgoKCgIGx0dG5nLXVzdC1hYmkubG+goKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+oCBD
Q6CgoKAgbHR0LXByb2Jlcy5sb6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KCqAgQ0OgoKCgIGx0dG5n
LXByb2JlLXVzdC5sb6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+oCBDQ6CgoKAgbHR0bmctY29udGV4dC12dGlk
LmxvoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgIDxicj4KCqAgQ0OgoKCgIGx0dG5nLWNvbnRleHQtdnBpZC5sb6CgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oCA8YnI+oCBDQ6CgoKAgbHR0bmctY29udGV4dC1wdGhyZWFkLWlkLmxvoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KCqAgQ0Og
oKCgIGx0dG5nLWNvbnRleHQtcHJvY25hbWUubG+goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+oCBDQ6CgoKAgbHR0LWNvbnRl
eHQubG+goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KCqAgQ0OgoKCgIGx0dC1ldmVudHMubG+goKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoCA8YnI+oCBDQ0xEoKAgPGEgaHJlZj0iaHR0cDovL2xpYmx0dG5nLXVzdC1ydW50
aW1lLmxhIiB0YXJnZXQ9Il9ibGFuayI+bGlibHR0bmctdXN0LXJ1bnRpbWUubGE8L2E+oKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oCA8YnI+CgqgIENDoKCgoCB1c3QtY29yZS5sb6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPqAgQ0Og
oKCgIGx0dC1yaW5nLWJ1ZmZlci1jbGllbnQtZGlzY2FyZC5sb6CgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+CgqgIENDoKCgoCBsdHQtcmlu
Zy1idWZmZXItY2xpZW50LW92ZXJ3cml0ZS5sb6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPqAgQ0OgoKCgIGx0dC1yaW5nLWJ1ZmZlci1tZXRh
ZGF0YS1jbGllbnQubG+goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoCA8YnI+CgqgIENDTESgoCA8YSBocmVmPSJodHRwOi8vbGlibHR0bmctdXN0LXN1
cHBvcnQubGEiIHRhcmdldD0iX2JsYW5rIj5saWJsdHRuZy11c3Qtc3VwcG9ydC5sYTwvYT6goKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgIDxicj6gIENDTESgoCA8YSBocmVmPSJodHRwOi8vbGlibHR0bmctdXN0LmxhIiB0YXJnZXQ9
Il9ibGFuayI+bGlibHR0bmctdXN0LmxhPC9hPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+CgovdXNyL2xp
Yi9nY2MvYXJtdjdhLXVua25vd24tbGludXgtZ251ZWFiaS80LjUuMy8uLi8uLi8uLi8uLi9hcm12
N2EtdW5rbm93bi1saW51eC1nbnVlYWJpL2Jpbi9sZDogd2FybmluZzogY3JlYXRpbmcgYSBEVF9U
RVhUUkVMIGluIG9iamVjdC6goKCgoKCgoKCgoKCgoKAgPGJyPmNvcHlpbmcgc2VsZWN0ZWQgb2Jq
ZWN0IGZpbGVzIHRvIGF2b2lkIGJhc2VuYW1lIGNvbmZsaWN0cy4uLqCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+CgptYWtlWzJdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Vz
ci9zcmMvbHR0bmctdXN0LTIuMC4xL2xpYmx0dG5nLXVzdCYjMzk7oKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgIDxicj5NYWtpbmcgYWxsIGluIGxpYmx0dG5nLXVzdC1jdGygoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAg
PGJyPgoKbWFrZVsyXTogRW50ZXJpbmcgZGlyZWN0b3J5IGAvdXNyL3NyYy9sdHRuZy11c3QtMi4w
LjEvbGlibHR0bmctdXN0LWN0bCYjMzk7oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+oCBD
Q6CgoKAgdXN0Y3RsLmxvoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KCqAgQ0NMRKCgIDxhIGhy
ZWY9Imh0dHA6Ly9saWJsdHRuZy11c3QtY3RsLmxhIiB0YXJnZXQ9Il9ibGFuayI+bGlibHR0bmct
dXN0LWN0bC5sYTwvYT6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+L3Vzci9saWIvZ2NjL2FybXY3YS11bmtub3du
LWxpbnV4LWdudWVhYmkvNC41LjMvLi4vLi4vLi4vLi4vYXJtdjdhLXVua25vd24tbGludXgtZ251
ZWFiaS9iaW4vbGQ6IHdhcm5pbmc6IGNyZWF0aW5nIGEgRFRfVEVYVFJFTCBpbiBvYmplY3QuoKCg
oKCgoKCgoKCgoKCgIDxicj4KCm1ha2VbMl06IExlYXZpbmcgZGlyZWN0b3J5IGAvdXNyL3NyYy9s
dHRuZy11c3QtMi4wLjEvbGlibHR0bmctdXN0LWN0bCYjMzk7oKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKAgPGJyPk1ha2luZyBhbGwgaW4gbGlibHR0bmctdXN0LWZvcmugoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+Cgpt
YWtlWzJdOiBFbnRlcmluZyBkaXJlY3RvcnkgYC91c3Ivc3JjL2x0dG5nLXVzdC0yLjAuMS9saWJs
dHRuZy11c3QtZm9yayYjMzk7oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj6gIENDTESgoCA8
YSBocmVmPSJodHRwOi8vbGlibHR0bmctdXN0LWZvcmsubGEiIHRhcmdldD0iX2JsYW5rIj5saWJs
dHRuZy11c3QtZm9yay5sYTwvYT6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KCm1ha2VbMl06IExlYXZpbmcgZGly
ZWN0b3J5IGAvdXNyL3NyYy9sdHRuZy11c3QtMi4wLjEvbGlibHR0bmctdXN0LWZvcmsmIzM5O6Cg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPk1ha2luZyBhbGwgaW4gbGlibHR0bmctdXN0LWxp
YmMtd3JhcHBlcqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoCA8YnI+CgptYWtlWzJdOiBFbnRlcmluZyBkaXJlY3RvcnkgYC91c3Ivc3JjL2x0
dG5nLXVzdC0yLjAuMS9saWJsdHRuZy11c3QtbGliYy13cmFwcGVyJiMzOTugoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgIDxicj6gIENDoKCgoCBsdHRuZy11c3QtbWFsbG9jLmxvoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKoCBD
Q0xEoKAgPGEgaHJlZj0iaHR0cDovL2xpYmx0dG5nLXVzdC1saWJjLXdyYXBwZXIubGEiIHRhcmdl
dD0iX2JsYW5rIj5saWJsdHRuZy11c3QtbGliYy13cmFwcGVyLmxhPC9hPqCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KbWFrZVsy
XTogTGVhdmluZyBkaXJlY3RvcnkgYC91c3Ivc3JjL2x0dG5nLXVzdC0yLjAuMS9saWJsdHRuZy11
c3QtbGliYy13cmFwcGVyJiMzOTugoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+Ck1ha2luZyBhbGwgaW4g
dG9vbHOgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+bWFrZVsyXTogRW50ZXJpbmcgZGlyZWN0b3J5
IGAvdXNyL3NyYy9sdHRuZy11c3QtMi4wLjEvdG9vbHMmIzM5O6CgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoCA8YnI+CgptYWtlWzJdOiBOb3RoaW5nIHRvIGJlIGRvbmUgZm9yIGBh
bGwmIzM5Oy6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIDxicj5tYWtlWzJdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Vzci9zcmMvbHR0bmct
dXN0LTIuMC4xL3Rvb2xzJiMzOTugoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
IDxicj4KCk1ha2luZyBhbGwgaW4gdGVzdHOgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+bWFrZVsy
XTogRW50ZXJpbmcgZGlyZWN0b3J5IGAvdXNyL3NyYy9sdHRuZy11c3QtMi4wLjEvdGVzdHMmIzM5
O6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+CgpNYWtpbmcgYWxsIGlu
IC6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPm1ha2VbM106IEVudGVyaW5nIGRpcmVjdG9y
eSBgL3Vzci9zcmMvbHR0bmctdXN0LTIuMC4xL3Rlc3RzJiMzOTugoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKbWFrZVszXTogTm90aGluZyB0byBiZSBkb25lIGZvciBg
YWxsLWFtJiMzOTsuoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoCA8YnI+bWFrZVszXTogTGVhdmluZyBkaXJlY3RvcnkgYC91c3Ivc3JjL2x0dG5n
LXVzdC0yLjAuMS90ZXN0cyYjMzk7oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oCA8YnI+CgpNYWtpbmcgYWxsIGluIGhlbGxvoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPm1ha2Vb
M106IEVudGVyaW5nIGRpcmVjdG9yeSBgL3Vzci9zcmMvbHR0bmctdXN0LTIuMC4xL3Rlc3RzL2hl
bGxvJiMzOTugoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKoCBDQ6CgoKAgdHAu
b6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj6gIENDTESgoCBoZWxsb6CgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKAgPGJyPgoKLi4vLi4vbGlibHR0bmctdXN0Ly5saWJzL2xpYmx0dG5nLXVz
dC5zbzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgX19udW1fcG9zc2libGVfY3B1cyYjMzk7oKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoCA8YnI+Li4vLi4vbGlibHR0bmctdXN0Ly5saWJzL2xpYmx0dG5nLXVzdC5zbzogdW5k
ZWZpbmVkIHJlZmVyZW5jZSB0byBgc2htX29iamVjdF90YWJsZV9jcmVhdGUmIzM5O6CgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8
YnI+CgouLi8uLi9saWJsdHRuZy11c3QvLmxpYnMvbGlibHR0bmctdXN0LnNvOiB1bmRlZmluZWQg
cmVmZXJlbmNlIHRvIGBzaG1fb2JqZWN0X3RhYmxlX2FwcGVuZF9zaGFkb3cmIzM5O6CgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4uLi8u
Li9saWJsdHRuZy11c3QvLmxpYnMvbGlibHR0bmctdXN0LnNvOiB1bmRlZmluZWQgcmVmZXJlbmNl
IHRvIGBzaG1fb2JqZWN0X3RhYmxlX2FwcGVuZCYjMzk7oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KCi4uLy4uL2xpYmx0
dG5nLXVzdC8ubGlicy9saWJsdHRuZy11c3Quc286IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHph
bGxvY19zaG0mIzM5O6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPi4uLy4uL2xpYmx0dG5nLXVzdC8u
bGlicy9saWJsdHRuZy11c3Quc286IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYF9nZXRfbnVtX3Bv
c3NpYmxlX2NwdXMmIzM5O6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKLi4vLi4vbGlibHR0bmctdXN0Ly5saWJzL2xp
Ymx0dG5nLXVzdC5zbzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgYWxpZ25fc2htJiMzOTugoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoCA8YnI+Li4vLi4vbGlibHR0bmctdXN0Ly5saWJzL2xpYmx0dG5nLXVz
dC5zbzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgc2htX29iamVjdF90YWJsZV9kZXN0cm95JiMz
OTugoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoCA8YnI+Cgpjb2xsZWN0MjogbGQgcmV0dXJuZWQgMSBleGl0IHN0YXR1c6CgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJy
Pm1ha2VbM106ICoqKiBbaGVsbG9dIEVycm9yIDGgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+CgptYWtlWzNdOiBM
ZWF2aW5nIGRpcmVjdG9yeSBgL3Vzci9zcmMvbHR0bmctdXN0LTIuMC4xL3Rlc3RzL2hlbGxvJiMz
OTugoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5tYWtlWzJdOiAqKiogW2FsbC1y
ZWN1cnNpdmVdIEVycm9yIDGgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKbWFrZVsyXTogTGVhdmluZyBkaXJlY3RvcnkgYC91
c3Ivc3JjL2x0dG5nLXVzdC0yLjAuMS90ZXN0cyYjMzk7oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoCA8YnI+bWFrZVsxXTogKioqIFthbGwtcmVjdXJzaXZlXSBFcnJvciAxoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
IDxicj4KCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdXNyL3NyYy9sdHRuZy11c3QtMi4w
LjEmIzM5O6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPm1h
a2U6ICoqKiBbYWxsXSBFcnJvciAyoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+Cgpsb2NhbGhvc3QgbHR0
bmctdXN0LTIuMC4xICMgPGRpdiBjbGFzcz0ieWo2cW8gYWpVIj48ZGl2IGlkPSI6MjQiIGNsYXNz
PSJhalIiIHRhYmluZGV4PSIwIj48aW1nIGNsYXNzPSJhalQiIHNyYz0iaHR0cHM6Ly9tYWlsLmdv
b2dsZS5jb20vbWFpbC91LzAvaW1hZ2VzL2NsZWFyZG90LmdpZiI+PC9kaXY+PC9kaXY+PC9kaXY+
PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVGh1LCBNYXkgMTcsIDIwMTIgYXQg
MjozMCBQTSwgTWF0aGlldSBEZXNub3llcnMgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJt
YWlsdG86bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tIiB0YXJnZXQ9Il9ibGFuayI+bWF0
aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj4KPGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBjbGFzcz0iSE9F
blpiIj48ZGl2IGNsYXNzPSJoNSI+KiBBbGV4YW5kcmUgTW9udHBsYWlzaXIgKDxhIGhyZWY9Im1h
aWx0bzphbGV4YW5kcmUubW9udHBsYWlzaXJAcG9seW10bC5jYSI+YWxleGFuZHJlLm1vbnRwbGFp
c2lyQHBvbHltdGwuY2E8L2E+KSB3cm90ZTo8YnI+CgomZ3Q7IFRoaXMgaXMgYW4gaW50ZXJlc3Rp
bmcgcHJvYmxlbSwgSSYjMzk7bGwgZm9yd2FyZCBpdCB0byB0aGUgbWFpbGluZyBsaXN0Ljxicj4K
Jmd0Ozxicj4KJmd0Ozxicj4KJmd0OyBPbiAxMi0wNS0xNyAxMDowMiBBTSwgVmFubmkgR2VudWEg
d3JvdGU6PGJyPgomZ3Q7ICZndDsgQWxzbyB3aHkgSSBnZXQgdGhpcyBlcnJvcj88YnI+CiZndDsg
Jmd0OyBzZWUgdGhlIGF0dGFjaGVkIGxvZyBmaWxlLjxicj4KJmd0OyAmZ3Q7IEJlc3QgcmVnYXJk
cy48YnI+CiZndDsgJmd0OyBWLkcuPGJyPgomZ3Q7ICZndDs8YnI+CiZndDsgJmd0Ozxicj4KJmd0
Ozxicj4KJmd0OyBsb2NhbGhvc3QgbHR0bmctdXN0LTIuMC4xICMgLi9jb25maWd1cmU8YnI+CiZn
dDsgY2hlY2tpbmcgYnVpbGQgc3lzdGVtIHR5cGUuLi4gYXJtdjdsLXVua25vd24tbGludXgtZ251
ZWFiaTxicj4KJmd0OyBjaGVja2luZyBob3N0IHN5c3RlbSB0eXBlLi4uIGFybXY3bC11bmtub3du
LWxpbnV4LWdudWVhYmk8YnI+CiZndDsgY2hlY2tpbmcgdGFyZ2V0IHN5c3RlbSB0eXBlLi4uIGFy
bXY3bC11bmtub3duLWxpbnV4LWdudWVhYmk8YnI+CiZndDsgY2hlY2tpbmcgZm9yIGEgQlNELWNv
bXBhdGlibGUgaW5zdGFsbC4uLiAvdXNyL2Jpbi9pbnN0YWxsIC1jPGJyPgomZ3Q7IGNoZWNraW5n
IHdoZXRoZXIgYnVpbGQgZW52aXJvbm1lbnQgaXMgc2FuZS4uLiB5ZXM8YnI+CiZndDsgY2hlY2tp
bmcgZm9yIGEgdGhyZWFkLXNhZmUgbWtkaXIgLXAuLi4gL2Jpbi9ta2RpciAtcDxicj4KJmd0OyBj
aGVja2luZyBmb3IgZ2F3ay4uLiBnYXdrPGJyPgomZ3Q7IGNoZWNraW5nIHdoZXRoZXIgbWFrZSBz
ZXRzICQoTUFLRSkuLi4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIHdoZXRoZXIgbWFrZSBzdXBwb3J0
cyBuZXN0ZWQgdmFyaWFibGVzLi4uIHllczxicj4KJmd0OyBjaGVja2luZyBmb3IgYSBzZWQgdGhh
dCBkb2VzIG5vdCB0cnVuY2F0ZSBvdXRwdXQuLi4gL2Jpbi9zZWQ8YnI+CiZndDsgY2hlY2tpbmcg
Zm9yIGdjYy4uLiBnY2M8YnI+CiZndDsgY2hlY2tpbmcgd2hldGhlciB0aGUgQyBjb21waWxlciB3
b3Jrcy4uLiB5ZXM8YnI+CiZndDsgY2hlY2tpbmcgZm9yIEMgY29tcGlsZXIgZGVmYXVsdCBvdXRw
dXQgZmlsZSBuYW1lLi4uIGEub3V0PGJyPgomZ3Q7IGNoZWNraW5nIGZvciBzdWZmaXggb2YgZXhl
Y3V0YWJsZXMuLi48YnI+CiZndDsgY2hlY2tpbmcgd2hldGhlciB3ZSBhcmUgY3Jvc3MgY29tcGls
aW5nLi4uIG5vPGJyPgomZ3Q7IGNoZWNraW5nIGZvciBzdWZmaXggb2Ygb2JqZWN0IGZpbGVzLi4u
IG88YnI+CiZndDsgY2hlY2tpbmcgd2hldGhlciB3ZSBhcmUgdXNpbmcgdGhlIEdOVSBDIGNvbXBp
bGVyLi4uIHllczxicj4KJmd0OyBjaGVja2luZyB3aGV0aGVyIGdjYyBhY2NlcHRzIC1nLi4uIHll
czxicj4KJmd0OyBjaGVja2luZyBmb3IgZ2NjIG9wdGlvbiB0byBhY2NlcHQgSVNPIEM4OS4uLiBu
b25lIG5lZWRlZDxicj4KJmd0OyBjaGVja2luZyBmb3Igc3R5bGUgb2YgaW5jbHVkZSB1c2VkIGJ5
IG1ha2UuLi4gR05VPGJyPgomZ3Q7IGNoZWNraW5nIGRlcGVuZGVuY3kgc3R5bGUgb2YgZ2NjLi4u
IGdjYzM8YnI+CiZndDsgY2hlY2tpbmcgZm9yIGcrKy4uLiBnKys8YnI+CiZndDsgY2hlY2tpbmcg
d2hldGhlciB3ZSBhcmUgdXNpbmcgdGhlIEdOVSBDKysgY29tcGlsZXIuLi4geWVzPGJyPgomZ3Q7
IGNoZWNraW5nIHdoZXRoZXIgZysrIGFjY2VwdHMgLWcuLi4geWVzPGJyPgomZ3Q7IGNoZWNraW5n
IGRlcGVuZGVuY3kgc3R5bGUgb2YgZysrLi4uIGdjYzM8YnI+CiZndDsgY2hlY2tpbmcgd2hldGhl
ciBtYWtlIHNldHMgJChNQUtFKS4uLiAoY2FjaGVkKSB5ZXM8YnI+CiZndDsgY2hlY2tpbmcgaG93
IHRvIHByaW50IHN0cmluZ3MuLi4gcHJpbnRmPGJyPgomZ3Q7IGNoZWNraW5nIGZvciBhIHNlZCB0
aGF0IGRvZXMgbm90IHRydW5jYXRlIG91dHB1dC4uLiAoY2FjaGVkKSAvYmluL3NlZDxicj4KJmd0
OyBjaGVja2luZyBmb3IgZ3JlcCB0aGF0IGhhbmRsZXMgbG9uZyBsaW5lcyBhbmQgLWUuLi4gL2Jp
bi9ncmVwPGJyPgomZ3Q7IGNoZWNraW5nIGZvciBlZ3JlcC4uLiAvYmluL2dyZXAgLUU8YnI+CiZn
dDsgY2hlY2tpbmcgZm9yIGZncmVwLi4uIC9iaW4vZ3JlcCAtRjxicj4KJmd0OyBjaGVja2luZyBm
b3IgbGQgdXNlZCBieSBnY2MuLi4gL3Vzci9hcm12N2EtdW5rbm93bi1saW51eC1nbnVlYWJpL2Jp
bi9sZDxicj4KJmd0OyBjaGVja2luZyBpZiB0aGUgbGlua2VyICgvdXNyL2FybXY3YS11bmtub3du
LWxpbnV4LWdudWVhYmkvYmluL2xkKSBpcyBHTlUgbGQuLi4geWVzPGJyPgomZ3Q7IGNoZWNraW5n
IGZvciBCU0QtIG9yIE1TLWNvbXBhdGlibGUgbmFtZSBsaXN0ZXIgKG5tKS4uLiAvdXNyL2Jpbi9u
bSAtQjxicj4KJmd0OyBjaGVja2luZyB0aGUgbmFtZSBsaXN0ZXIgKC91c3IvYmluL25tIC1CKSBp
bnRlcmZhY2UuLi4gQlNEIG5tPGJyPgomZ3Q7IGNoZWNraW5nIHdoZXRoZXIgbG4gLXMgd29ya3Mu
Li4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIHRoZSBtYXhpbXVtIGxlbmd0aCBvZiBjb21tYW5kIGxp
bmUgYXJndW1lbnRzLi4uIDE1NzI4NjQ8YnI+CiZndDsgY2hlY2tpbmcgd2hldGhlciB0aGUgc2hl
bGwgdW5kZXJzdGFuZHMgc29tZSBYU0kgY29uc3RydWN0cy4uLiB5ZXM8YnI+CiZndDsgY2hlY2tp
bmcgd2hldGhlciB0aGUgc2hlbGwgdW5kZXJzdGFuZHMgJnF1b3Q7Kz0mcXVvdDsuLi4geWVzPGJy
PgomZ3Q7IGNoZWNraW5nIGhvdyB0byBjb252ZXJ0IGFybXY3bC11bmtub3duLWxpbnV4LWdudWVh
YmkgZmlsZSBuYW1lcyB0byBhcm12N2wtdW5rbm93bi1saW51eC1nbnVlYWJpIGZvcm1hdC4uLiBm
dW5jX2NvbnZlcnRfZmlsZV9ub29wPGJyPgomZ3Q7IGNoZWNraW5nIGhvdyB0byBjb252ZXJ0IGFy
bXY3bC11bmtub3duLWxpbnV4LWdudWVhYmkgZmlsZSBuYW1lcyB0byB0b29sY2hhaW4gZm9ybWF0
Li4uIGZ1bmNfY29udmVydF9maWxlX25vb3A8YnI+CiZndDsgY2hlY2tpbmcgZm9yIC91c3IvYXJt
djdhLXVua25vd24tbGludXgtZ251ZWFiaS9iaW4vbGQgb3B0aW9uIHRvIHJlbG9hZCBvYmplY3Qg
ZmlsZXMuLi4gLXI8YnI+CiZndDsgY2hlY2tpbmcgZm9yIG9iamR1bXAuLi4gb2JqZHVtcDxicj4K
Jmd0OyBjaGVja2luZyBob3cgdG8gcmVjb2duaXplIGRlcGVuZGVudCBsaWJyYXJpZXMuLi4gcGFz
c19hbGw8YnI+CiZndDsgY2hlY2tpbmcgZm9yIGRsbHRvb2wuLi4gbm88YnI+CiZndDsgY2hlY2tp
bmcgaG93IHRvIGFzc29jaWF0ZSBydW50aW1lIGFuZCBsaW5rIGxpYnJhcmllcy4uLiBwcmludGYg
JXNcbjxicj4KJmd0OyBjaGVja2luZyBmb3IgYXIuLi4gYXI8YnI+CiZndDsgY2hlY2tpbmcgZm9y
IGFyY2hpdmVyIEBGSUxFIHN1cHBvcnQuLi4gQDxicj4KJmd0OyBjaGVja2luZyBmb3Igc3RyaXAu
Li4gc3RyaXA8YnI+CiZndDsgY2hlY2tpbmcgZm9yIHJhbmxpYi4uLiByYW5saWI8YnI+CiZndDsg
Y2hlY2tpbmcgY29tbWFuZCB0byBwYXJzZSAvdXNyL2Jpbi9ubSAtQiBvdXRwdXQgZnJvbSBnY2Mg
b2JqZWN0Li4uIG9rPGJyPgomZ3Q7IGNoZWNraW5nIGZvciBzeXNyb290Li4uIG5vPGJyPgomZ3Q7
IGNoZWNraW5nIGZvciBtdC4uLiBubzxicj4KJmd0OyBjaGVja2luZyBpZiA6IGlzIGEgbWFuaWZl
c3QgdG9vbC4uLiBubzxicj4KJmd0OyBjaGVja2luZyBob3cgdG8gcnVuIHRoZSBDIHByZXByb2Nl
c3Nvci4uLiBnY2MgLUU8YnI+CiZndDsgY2hlY2tpbmcgZm9yIEFOU0kgQyBoZWFkZXIgZmlsZXMu
Li4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIGZvciBzeXMvdHlwZXMuaC4uLiB5ZXM8YnI+CiZndDsg
Y2hlY2tpbmcgZm9yIHN5cy9zdGF0LmguLi4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIGZvciBzdGRs
aWIuaC4uLiB5ZXM8YnI+CiZndDsgY2hlY2tpbmcgZm9yIHN0cmluZy5oLi4uIHllczxicj4KJmd0
OyBjaGVja2luZyBmb3IgbWVtb3J5LmguLi4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIGZvciBzdHJp
bmdzLmguLi4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIGZvciBpbnR0eXBlcy5oLi4uIHllczxicj4K
Jmd0OyBjaGVja2luZyBmb3Igc3RkaW50LmguLi4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIGZvciB1
bmlzdGQuaC4uLiB5ZXM8YnI+CiZndDsgY2hlY2tpbmcgZm9yIGRsZmNuLmguLi4geWVzPGJyPgom
Z3Q7IGNoZWNraW5nIGZvciBvYmpkaXIuLi4gLmxpYnM8YnI+CiZndDsgY2hlY2tpbmcgaWYgZ2Nj
IHN1cHBvcnRzIC1mbm8tcnR0aSAtZm5vLWV4Y2VwdGlvbnMuLi4gbm88YnI+CiZndDsgY2hlY2tp
bmcgZm9yIGdjYyBvcHRpb24gdG8gcHJvZHVjZSBQSUMuLi4gLWZQSUMgLURQSUM8YnI+CiZndDsg
Y2hlY2tpbmcgaWYgZ2NjIFBJQyBmbGFnIC1mUElDIC1EUElDIHdvcmtzLi4uIHllczxicj4KJmd0
OyBjaGVja2luZyBpZiBnY2Mgc3RhdGljIGZsYWcgLXN0YXRpYyB3b3Jrcy4uLiB5ZXM8YnI+CiZn
dDsgY2hlY2tpbmcgaWYgZ2NjIHN1cHBvcnRzIC1jIC1vIGZpbGUuby4uLiB5ZXM8YnI+CiZndDsg
Y2hlY2tpbmcgaWYgZ2NjIHN1cHBvcnRzIC1jIC1vIGZpbGUuby4uLiAoY2FjaGVkKSB5ZXM8YnI+
CiZndDsgY2hlY2tpbmcgd2hldGhlciB0aGUgZ2NjIGxpbmtlciAoL3Vzci9hcm12N2EtdW5rbm93
bi1saW51eC1nbnVlYWJpL2Jpbi9sZCkgc3VwcG9ydHMgc2hhcmVkIGxpYnJhcmllcy4uLiB5ZXM8
YnI+CiZndDsgY2hlY2tpbmcgd2hldGhlciAtbGMgc2hvdWxkIGJlIGV4cGxpY2l0bHkgbGlua2Vk
IGluLi4uIG5vPGJyPgomZ3Q7IGNoZWNraW5nIGR5bmFtaWMgbGlua2VyIGNoYXJhY3RlcmlzdGlj
cy4uLiBHTlUvTGludXggbGQuc288YnI+CiZndDsgY2hlY2tpbmcgaG93IHRvIGhhcmRjb2RlIGxp
YnJhcnkgcGF0aHMgaW50byBwcm9ncmFtcy4uLiBpbW1lZGlhdGU8YnI+CiZndDsgY2hlY2tpbmcg
d2hldGhlciBzdHJpcHBpbmcgbGlicmFyaWVzIGlzIHBvc3NpYmxlLi4uIHllczxicj4KJmd0OyBj
aGVja2luZyBpZiBsaWJ0b29sIHN1cHBvcnRzIHNoYXJlZCBsaWJyYXJpZXMuLi4geWVzPGJyPgom
Z3Q7IGNoZWNraW5nIHdoZXRoZXIgdG8gYnVpbGQgc2hhcmVkIGxpYnJhcmllcy4uLiB5ZXM8YnI+
CiZndDsgY2hlY2tpbmcgd2hldGhlciB0byBidWlsZCBzdGF0aWMgbGlicmFyaWVzLi4uIHllczxi
cj4KJmd0OyBjaGVja2luZyBob3cgdG8gcnVuIHRoZSBDKysgcHJlcHJvY2Vzc29yLi4uIGcrKyAt
RTxicj4KJmd0OyBjaGVja2luZyBmb3IgbGQgdXNlZCBieSBnKysuLi4gL3Vzci9hcm12N2EtdW5r
bm93bi1saW51eC1nbnVlYWJpL2Jpbi9sZDxicj4KJmd0OyBjaGVja2luZyBpZiB0aGUgbGlua2Vy
ICgvdXNyL2FybXY3YS11bmtub3duLWxpbnV4LWdudWVhYmkvYmluL2xkKSBpcyBHTlUgbGQuLi4g
eWVzPGJyPgomZ3Q7IGNoZWNraW5nIHdoZXRoZXIgdGhlIGcrKyBsaW5rZXIgKC91c3IvYXJtdjdh
LXVua25vd24tbGludXgtZ251ZWFiaS9iaW4vbGQpIHN1cHBvcnRzIHNoYXJlZCBsaWJyYXJpZXMu
Li4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIGZvciBnKysgb3B0aW9uIHRvIHByb2R1Y2UgUElDLi4u
IC1mUElDIC1EUElDPGJyPgomZ3Q7IGNoZWNraW5nIGlmIGcrKyBQSUMgZmxhZyAtZlBJQyAtRFBJ
QyB3b3Jrcy4uLiB5ZXM8YnI+CiZndDsgY2hlY2tpbmcgaWYgZysrIHN0YXRpYyBmbGFnIC1zdGF0
aWMgd29ya3MuLi4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIGlmIGcrKyBzdXBwb3J0cyAtYyAtbyBm
aWxlLm8uLi4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIGlmIGcrKyBzdXBwb3J0cyAtYyAtbyBmaWxl
Lm8uLi4gKGNhY2hlZCkgeWVzPGJyPgomZ3Q7IGNoZWNraW5nIHdoZXRoZXIgdGhlIGcrKyBsaW5r
ZXIgKC91c3IvYXJtdjdhLXVua25vd24tbGludXgtZ251ZWFiaS9iaW4vbGQpIHN1cHBvcnRzIHNo
YXJlZCBsaWJyYXJpZXMuLi4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIGR5bmFtaWMgbGlua2VyIGNo
YXJhY3RlcmlzdGljcy4uLiAoY2FjaGVkKSBHTlUvTGludXggbGQuc288YnI+CiZndDsgY2hlY2tp
bmcgaG93IHRvIGhhcmRjb2RlIGxpYnJhcnkgcGF0aHMgaW50byBwcm9ncmFtcy4uLiBpbW1lZGlh
dGU8YnI+CiZndDsgY2hlY2tpbmcgZm9yIGRsb3BlbiBpbiAtbGRsLi4uIHllczxicj4KJmd0OyBj
aGVja2luZyBmb3IgcHRocmVhZF9jcmVhdGUgaW4gLWxwdGhyZWFkLi4uIHllczxicj4KJmd0OyBj
aGVja2luZyBmb3IgdXVpZF9nZW5lcmF0ZSBpbiAtbHV1aWQuLi4geWVzPGJyPgomZ3Q7IGNoZWNr
aW5nIGZvciBpbmxpbmUuLi4gaW5saW5lPGJyPgomZ3Q7IGNoZWNraW5nIGZvciBzdGRsaWIuaC4u
LiAoY2FjaGVkKSB5ZXM8YnI+CiZndDsgY2hlY2tpbmcgZm9yIEdOVSBsaWJjIGNvbXBhdGlibGUg
bWFsbG9jLi4uIHllczxicj4KJmd0OyBjaGVja2luZyBmb3IgZ2V0dGltZW9mZGF5Li4uIHllczxi
cj4KJmd0OyBjaGVja2luZyBmb3IgbXVubWFwLi4uIHllczxicj4KJmd0OyBjaGVja2luZyBmb3Ig
c29ja2V0Li4uIHllczxicj4KJmd0OyBjaGVja2luZyBmb3Igc3RyZXJyb3IuLi4geWVzPGJyPgom
Z3Q7IGNoZWNraW5nIGZvciBzdHJ0b2wuLi4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIGZvciBzY2hl
ZF9nZXRjcHUuLi4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIGZvciBzeXNjb25mLi4uIHllczxicj4K
Jmd0OyBjaGVja2luZyBmb3IgbWFrZWluZm8uLi4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIHVyY3Ut
YnAuaCB1c2FiaWxpdHkuLi4geWVzPGJyPgomZ3Q7IGNoZWNraW5nIHVyY3UtYnAuaCBwcmVzZW5j
ZS4uLiB5ZXM8YnI+CiZndDsgY2hlY2tpbmcgZm9yIHVyY3UtYnAuaC4uLiB5ZXM8YnI+CiZndDsg
Y2hlY2tpbmcgY2FhX2xpa2VseSgpLi4uIHllczxicj4KJmd0OyBjaGVja2luZyBmb3Igc3luY2hy
b25pemVfcmN1X2JwIGluIC1sdXJjdS1icC4uLiB5ZXM8YnI+CiZndDsgY2hlY2tpbmcgZm9yIGNh
bGxfcmN1X2JwIGluIC1sdXJjdS1icC4uLiB5ZXM8YnI+CiZndDsgY2hlY2tpbmcgbGlicmFyeSBm
b3JtYXQgZm9yIHRoZSBob3N0IHN5c3RlbS4uLiBjb25maWd1cmU6IGVycm9yOiB1bmFibGUgdG8g
ZGV0ZWN0IGxpYnJhcnkgZm9ybWF0ICh1bnN1cHBvcnRlZCBhcmNoaXRlY3R1cmUgKGFybXY3bCk/
KTxicj4KPGJyPgo8L2Rpdj48L2Rpdj5Eb2VzIGl0IGhlbHAgaWYgeW91IGFkZCBhIGxpbmU6PGJy
Pgo8YnI+CiCgIKAgoCCgYXJtdjdsKSBMSUJGT1JNQVQ9JnF1b3Q7ZWxmMzItbGl0dGxlYXJtJnF1
b3Q7OyBOT19VTkFMSUdORURfQUNDRVNTPTEgOzs8YnI+Cjxicj4KbmVhciBsaW5lIDE4OCBvZiA8
YSBocmVmPSJodHRwOi8vY29uZmlndXJlLmFjIiB0YXJnZXQ9Il9ibGFuayI+Y29uZmlndXJlLmFj
PC9hPiA/PGJyPgo8YnI+CldoYXQgd2UgZGlkIGluIHVzZXJzcGFjZSBSQ1UgaXMgdG8gdXNlICZx
dW90O2FybSomcXVvdDsuPGJyPgo8YnI+ClRoYW5rcyw8YnI+Cjxicj4KTWF0aGlldTxicj4KPGJy
PgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fPGJyPgomZ3Q7IGx0dG5nLWRldiBtYWlsaW5nIGxpc3Q8YnI+CiZndDsg
PGEgaHJlZj0ibWFpbHRvOmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmciPmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmc8L2E+PGJyPgomZ3Q7IDxhIGhyZWY9Imh0dHA6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldiIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldjwvYT48
YnI+CjxzcGFuIGNsYXNzPSJIT0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij48YnI+Ci0tPGJy
PgpNYXRoaWV1IERlc25veWVyczxicj4KT3BlcmF0aW5nIFN5c3RlbSBFZmZpY2llbmN5IFImYW1w
O0QgQ29uc3VsdGFudDxicj4KRWZmaWNpT1MgSW5jLjxicj4KPGEgaHJlZj0iaHR0cDovL3d3dy5l
ZmZpY2lvcy5jb20iIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vd3d3LmVmZmljaW9zLmNvbTwvYT48
YnI+CjwvZm9udD48L3NwYW4+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj4K
--f46d0418262868756204c04a6e57--


--===============1787880546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1787880546==--
