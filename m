From: meher chaitanya <meher.146@gmail.com>
Subject: unable to detect library format (unsupported
	architecture (armv7l)
Date: Mon, 24 Sep 2012 15:46:13 +0530
Message-ID: <CA+Kk8Ns_q-yeT9LWAB3s5UY=uhObkUbCWX8_MCy7n_5ni696zQ__46260.7047091753$1348481818$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0481538586=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <meher.146@gmail.com>) id 1TG5i8-0008QE-HD
	for lttng-dev@lists.lttng.org; Mon, 24 Sep 2012 06:16:21 -0400
Received: by lboi15 with SMTP id i15so7666307lbo.35
	for <lttng-dev@lists.lttng.org>; Mon, 24 Sep 2012 03:16:13 -0700 (PDT)
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

--===============0481538586==
Content-Type: multipart/alternative; boundary=f46d04016fbb1ac40b04ca6fe10c

--f46d04016fbb1ac40b04ca6fe10c
Content-Type: text/plain; charset=ISO-8859-1

root@lttng:/home/ltt/lttng-ust-2.0.4# ./configure
checking build system type... armv7l-unknown-linux-gnueabi
checking host system type... armv7l-unknown-linux-gnueabi
checking target system type... armv7l-unknown-linux-gnueabi
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... no
checking for mawk... mawk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking for a sed that does not truncate output... /bin/sed
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
checking for g++... g++
checking whether we are using the GNU C++ compiler... yes
checking whether g++ accepts -g... yes
checking dependency style of g++... gcc3
checking whether make sets $(MAKE)... (cached) yes
checking how to print strings... printf
checking for a sed that does not truncate output... (cached) /bin/sed
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for fgrep... /bin/grep -F
checking for ld used by gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
checking the name lister (/usr/bin/nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+="... yes
checking how to convert armv7l-unknown-linux-gnueabi file names to
armv7l-unknown-linux-gnueabi format... func_convert_file_noop
checking how to convert armv7l-unknown-linux-gnueabi file names to
toolchain format... func_convert_file_noop
checking for /usr/bin/ld option to reload object files... -r
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for ar... ar
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for sysroot... no
checking for mt... mt
checking if mt is a manifest tool... no
checking how to run the C preprocessor... gcc -E
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
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC -DPIC
checking if gcc PIC flag -fPIC -DPIC works... yes
checking if gcc static flag -static works... yes
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker (/usr/bin/ld) supports shared libraries...
yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking how to run the C++ preprocessor... g++ -E
checking for ld used by g++... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking whether the g++ linker (/usr/bin/ld) supports shared libraries...
yes
checking for g++ option to produce PIC... -fPIC -DPIC
checking if g++ PIC flag -fPIC -DPIC works... yes
checking if g++ static flag -static works... yes
checking if g++ supports -c -o file.o... yes
checking if g++ supports -c -o file.o... (cached) yes
checking whether the g++ linker (/usr/bin/ld) supports shared libraries...
yes
checking dynamic linker characteristics... (cached) GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking for dlopen in -ldl... yes
checking for pthread_create in -lpthread... yes
checking for uuid_generate in -luuid... yes
checking for inline... inline
checking for stdlib.h... (cached) yes
checking for GNU libc compatible malloc... yes
checking for gettimeofday... yes
checking for munmap... yes
checking for socket... yes
checking for strerror... yes
checking for strtol... yes
checking for sched_getcpu... yes
checking for sysconf... yes
checking for makeinfo... yes
checking urcu-bp.h usability... yes
checking urcu-bp.h presence... yes
checking for urcu-bp.h... yes
checking caa_likely()... yes
checking for synchronize_rcu_bp in -lurcu-bp... yes
checking for call_rcu_bp in -lurcu-bp... yes
checking library format for the host system... configure: error: unable to
detect library format (unsupported architecture (armv7l)?)


In the configure.ac file i had made an entry for arm7l but even then i am
seeing this error . I am doing this on my target machine . can anyone help
me with this??

--f46d04016fbb1ac40b04ca6fe10c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

root@lttng:/home/ltt/lttng-ust-2.0.4# ./configure<br>checking build system =
type... armv7l-unknown-linux-gnueabi<br>checking host system type... armv7l=
-unknown-linux-gnueabi<br>checking target system type... armv7l-unknown-lin=
ux-gnueabi<br>
checking for a BSD-compatible install... /usr/bin/install -c<br>checking wh=
ether build environment is sane... yes<br>checking for a thread-safe mkdir =
-p... /bin/mkdir -p<br>checking for gawk... no<br>checking for mawk... mawk=
<br>
checking whether make sets $(MAKE)... yes<br>checking whether make supports=
 nested variables... yes<br>checking for a sed that does not truncate outpu=
t... /bin/sed<br>checking for gcc... gcc<br>checking whether the C compiler=
 works... yes<br>
checking for C compiler default output file name... a.out<br>checking for s=
uffix of executables... <br>checking whether we are cross compiling... no<b=
r>checking for suffix of object files... o<br>checking whether we are using=
 the GNU C compiler... yes<br>
checking whether gcc accepts -g... yes<br>checking for gcc option to accept=
 ISO C89... none needed<br>checking for style of include used by make... GN=
U<br>checking dependency style of gcc... gcc3<br>checking for g++... g++<br=
>
checking whether we are using the GNU C++ compiler... yes<br>checking wheth=
er g++ accepts -g... yes<br>checking dependency style of g++... gcc3<br>che=
cking whether make sets $(MAKE)... (cached) yes<br>checking how to print st=
rings... printf<br>
checking for a sed that does not truncate output... (cached) /bin/sed<br>ch=
ecking for grep that handles long lines and -e... /bin/grep<br>checking for=
 egrep... /bin/grep -E<br>checking for fgrep... /bin/grep -F<br>checking fo=
r ld used by gcc... /usr/bin/ld<br>
checking if the linker (/usr/bin/ld) is GNU ld... yes<br>checking for BSD- =
or MS-compatible name lister (nm)... /usr/bin/nm -B<br>checking the name li=
ster (/usr/bin/nm -B) interface... BSD nm<br>checking whether ln -s works..=
. yes<br>
checking the maximum length of command line arguments... 1572864<br>checkin=
g whether the shell understands some XSI constructs... yes<br>checking whet=
her the shell understands &quot;+=3D&quot;... yes<br>checking how to conver=
t armv7l-unknown-linux-gnueabi file names to armv7l-unknown-linux-gnueabi f=
ormat... func_convert_file_noop<br>
checking how to convert armv7l-unknown-linux-gnueabi file names to toolchai=
n format... func_convert_file_noop<br>checking for /usr/bin/ld option to re=
load object files... -r<br>checking for objdump... objdump<br>checking how =
to recognize dependent libraries... pass_all<br>
checking for dlltool... no<br>checking how to associate runtime and link li=
braries... printf %s\n<br>checking for ar... ar<br>checking for archiver @F=
ILE support... @<br>checking for strip... strip<br>checking for ranlib... r=
anlib<br>
checking command to parse /usr/bin/nm -B output from gcc object... ok<br>ch=
ecking for sysroot... no<br>checking for mt... mt<br>checking if mt is a ma=
nifest tool... no<br>checking how to run the C preprocessor... gcc -E<br>
checking for ANSI C header files... yes<br>checking for sys/types.h... yes<=
br>checking for sys/stat.h... yes<br>checking for stdlib.h... yes<br>checki=
ng for string.h... yes<br>checking for memory.h... yes<br>checking for stri=
ngs.h... yes<br>
checking for inttypes.h... yes<br>checking for stdint.h... yes<br>checking =
for unistd.h... yes<br>checking for dlfcn.h... yes<br>checking for objdir..=
. .libs<br>checking if gcc supports -fno-rtti -fno-exceptions... no<br>
checking for gcc option to produce PIC... -fPIC -DPIC<br>checking if gcc PI=
C flag -fPIC -DPIC works... yes<br>checking if gcc static flag -static work=
s... yes<br>checking if gcc supports -c -o file.o... yes<br>checking if gcc=
 supports -c -o file.o... (cached) yes<br>
checking whether the gcc linker (/usr/bin/ld) supports shared libraries... =
yes<br>checking whether -lc should be explicitly linked in... no<br>checkin=
g dynamic linker characteristics... GNU/Linux ld.so<br>checking how to hard=
code library paths into programs... immediate<br>
checking whether stripping libraries is possible... yes<br>checking if libt=
ool supports shared libraries... yes<br>checking whether to build shared li=
braries... yes<br>checking whether to build static libraries... yes<br>
checking how to run the C++ preprocessor... g++ -E<br>checking for ld used =
by g++... /usr/bin/ld<br>checking if the linker (/usr/bin/ld) is GNU ld... =
yes<br>checking whether the g++ linker (/usr/bin/ld) supports shared librar=
ies... yes<br>
checking for g++ option to produce PIC... -fPIC -DPIC<br>checking if g++ PI=
C flag -fPIC -DPIC works... yes<br>checking if g++ static flag -static work=
s... yes<br>checking if g++ supports -c -o file.o... yes<br>checking if g++=
 supports -c -o file.o... (cached) yes<br>
checking whether the g++ linker (/usr/bin/ld) supports shared libraries... =
yes<br>checking dynamic linker characteristics... (cached) GNU/Linux ld.so<=
br>checking how to hardcode library paths into programs... immediate<br>
checking for dlopen in -ldl... yes<br>checking for pthread_create in -lpthr=
ead... yes<br>checking for uuid_generate in -luuid... yes<br>checking for i=
nline... inline<br>checking for stdlib.h... (cached) yes<br>checking for GN=
U libc compatible malloc... yes<br>
checking for gettimeofday... yes<br>checking for munmap... yes<br>checking =
for socket... yes<br>checking for strerror... yes<br>checking for strtol...=
 yes<br>checking for sched_getcpu... yes<br>checking for sysconf... yes<br>
checking for makeinfo... yes<br>checking urcu-bp.h usability... yes<br>chec=
king urcu-bp.h presence... yes<br>checking for urcu-bp.h... yes<br>checking=
 caa_likely()... yes<br>checking for synchronize_rcu_bp in -lurcu-bp... yes=
<br>
checking for call_rcu_bp in -lurcu-bp... yes<br>checking library format for=
 the host system... configure: error: unable to detect library format (unsu=
pported architecture (armv7l)?)<br><br><br>In the <a href=3D"http://configu=
re.ac">configure.ac</a> file i had made an entry for arm7l but even then i =
am seeing this error . I am doing this on my target machine . can anyone he=
lp me with this??<br>
<br>

--f46d04016fbb1ac40b04ca6fe10c--


--===============0481538586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0481538586==--
