From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: babeltrace 1.2.2 and python (more)
Date: Fri, 15 Aug 2014 18:51:00 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3D18507A__7222.95130040056$1408128762$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XIMai-0006Vy-VH
 for lttng-dev@lists.lttng.org; Fri, 15 Aug 2014 14:51:18 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

   Okay, I've got Python3 and Swig2.0 installed, now I try to make babeltra=
ce 1.2.2.

   Here is the bootstrap log:

+ '[' '!' -e config ']'
+ mkdir config
+ libtoolize --force --copy
libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `config'.
libtoolize: copying file `config/ltmain.sh'
libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.
libtoolize: copying file `m4/libtool.m4'
libtoolize: copying file `m4/ltoptions.m4'
libtoolize: copying file `m4/ltsugar.m4'
libtoolize: copying file `m4/ltversion.m4'
libtoolize: copying file `m4/lt~obsolete.m4'
+ autoreconf -i
libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `config'.
libtoolize: copying file `config/config.guess'
libtoolize: copying file `config/config.sub'
libtoolize: copying file `config/install-sh'
configure.ac:33: error: possibly undefined macro: AC_MSG_ERROR
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
autoreconf: /usr/bin/autoconf failed with exit status: 1

   No big surprise there, except the suspicious "possibly undefined macro".

   Next I launch configure, setting PYTHON and PYTHON_CONFIG beforehand:

checking build system type... x86_64-unknown-linux-gnu
checking host system type... x86_64-unknown-linux-gnu
checking target system type... x86_64-unknown-linux-gnu
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
/bin/sh: /usr/src/babeltrace-1.2.2/config/missing: No such file or directory
configure: WARNING: `missing' script is too old or missing
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking for style of include used by make... GNU
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables... =

checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking dependency style of gcc... none
checking for special C compiler options needed for large files... no
checking for _FILE_OFFSET_BITS value needed for large files... no
checking for gcc option to accept ISO C99... -std=3Dgnu99
checking for gcc -std=3Dgnu99 option to accept ISO Standard C... (cached) -=
std=3Dgnu99
checking whether make sets $(MAKE)... (cached) yes
checking how to print strings... printf
checking for a sed that does not truncate output... /bin/sed
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for fgrep... /bin/grep -F
checking for ld used by gcc -std=3Dgnu99... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
checking the name lister (/usr/bin/nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+=3D"... yes
checking how to convert x86_64-unknown-linux-gnu file names to x86_64-unkno=
wn-linux-gnu format... func_convert_file_noop
checking how to convert x86_64-unknown-linux-gnu file names to toolchain fo=
rmat... func_convert_file_noop
checking for /usr/bin/ld option to reload object files... -r
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for ar... ar
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /usr/bin/nm -B output from gcc -std=3Dgnu99 objec=
t... ok
checking for sysroot... no
checking for mt... mt
checking if mt is a manifest tool... no
checking how to run the C preprocessor... gcc -std=3Dgnu99 -E
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
checking if gcc -std=3Dgnu99 supports -fno-rtti -fno-exceptions... no
checking for gcc -std=3Dgnu99 option to produce PIC... -fPIC -DPIC
checking if gcc -std=3Dgnu99 PIC flag -fPIC -DPIC works... yes
checking if gcc -std=3Dgnu99 static flag -static works... yes
checking if gcc -std=3Dgnu99 supports -c -o file.o... yes
checking if gcc -std=3Dgnu99 supports -c -o file.o... (cached) yes
checking whether the gcc -std=3Dgnu99 linker (/usr/bin/ld -m elf_x86_64) su=
pports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for bison... bison -y
checking for flex... flex
checking lex output file root... lex.yy
checking lex library... -lfl
checking whether yytext is a pointer... yes
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.16... yes
checking for GLIB - version >=3D 2.22.0... yes (version 2.32.4)
checking for inline... inline
checking for pid_t... yes
checking for size_t... yes
checking for stdlib.h... (cached) yes
checking for GNU libc compatible malloc... yes
checking for stdlib.h... (cached) yes
checking for unistd.h... (cached) yes
checking for sys/param.h... yes
checking for getpagesize... yes
checking for working mmap... yes
checking for bzero... yes
checking for gettimeofday... yes
checking for munmap... yes
checking for strtoul... yes
checking for uuid_generate in -luuid... yes
checking for fmemopen in -lc... yes
checking for open_memstream in -lc... yes
checking for poptGetContext in -lpopt... yes
./configure: line 13260: syntax error near unexpected token `$swig_version,'
./configure: line 13260: `  AX_PKG_SWIG($swig_version, ,  AC_MSG_ERROR([SWI=
G $swig_version or newer is needed]) )'

   Yup, the macro is undefined.  How do I fix this?

   This is Ubuntu 12.04.5 LTS, 64-bits.  The kernel is 3.9.3.

   According to https://issues.mediagoblin.org/ticket/755 the fix is to run=
 'aclocal -I m4 --install' before invoking bootstrap.  Can this be fixed in=
 the bootstrap config files themselves?

   (I'm going on vacation now, so don't be surprised if I don't answer for =
a while)

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
[Valcartier]\\vsi-wdut-o980, [Valcartier]\\edge
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
