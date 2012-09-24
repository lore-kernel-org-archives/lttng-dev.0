From: meher chaitanya <meher.146@gmail.com>
Subject: Re: unable to detect library format (unsupported
 architecture (armv7l)
Date: Mon, 24 Sep 2012 17:25:06 +0530
Message-ID: <CA+Kk8NupaNYkC_ziQaOvM=PGwOKhKynxW5RgFCwMsys=bt5cPw__36049.4116241627$1348489320$gmane$org@mail.gmail.com>
References: <CA+Kk8Ns_q-yeT9LWAB3s5UY=uhObkUbCWX8_MCy7n_5ni696zQ@mail.gmail.com>
	<20120924113333.GA26574@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1766625553=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <meher.146@gmail.com>) id 1TG7fA-0001Cz-US
	for lttng-dev@lists.lttng.org; Mon, 24 Sep 2012 08:21:26 -0400
Received: by lboi15 with SMTP id i15so7830031lbo.35
	for <lttng-dev@lists.lttng.org>; Mon, 24 Sep 2012 05:21:18 -0700 (PDT)
In-Reply-To: <20120924113333.GA26574@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1766625553==
Content-Type: multipart/alternative; boundary=e0cb4efe2f96c1428f04ca714259

--e0cb4efe2f96c1428f04ca714259
Content-Type: text/plain; charset=ISO-8859-1

I got the same issue in   lttng-ust 2.0.5  . I added the line  armv7l)
LIBFORMAT="elf32-littlearm"; NO_UNALIGNED_ACCESS=1 ;; in configure.ac file
. Even then i am able to see this issue.



On Mon, Sep 24, 2012 at 5:03 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> * meher chaitanya (meher.146@gmail.com) wrote:
> > root@lttng:/home/ltt/lttng-ust-2.0.4# ./configure
> > checking build system type... armv7l-unknown-linux-gnueabi
> > checking host system type... armv7l-unknown-linux-gnueabi
> > checking target system type... armv7l-unknown-linux-gnueabi
> > checking for a BSD-compatible install... /usr/bin/install -c
> > checking whether build environment is sane... yes
> > checking for a thread-safe mkdir -p... /bin/mkdir -p
> > checking for gawk... no
> > checking for mawk... mawk
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
> > checking for ld used by gcc... /usr/bin/ld
> > checking if the linker (/usr/bin/ld) is GNU ld... yes
> > checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
> > checking the name lister (/usr/bin/nm -B) interface... BSD nm
> > checking whether ln -s works... yes
> > checking the maximum length of command line arguments... 1572864
> > checking whether the shell understands some XSI constructs... yes
> > checking whether the shell understands "+="... yes
> > checking how to convert armv7l-unknown-linux-gnueabi file names to
> > armv7l-unknown-linux-gnueabi format... func_convert_file_noop
> > checking how to convert armv7l-unknown-linux-gnueabi file names to
> > toolchain format... func_convert_file_noop
> > checking for /usr/bin/ld option to reload object files... -r
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
> > checking for mt... mt
> > checking if mt is a manifest tool... no
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
> > checking whether the gcc linker (/usr/bin/ld) supports shared
> libraries...
> > yes
> > checking whether -lc should be explicitly linked in... no
> > checking dynamic linker characteristics... GNU/Linux ld.so
> > checking how to hardcode library paths into programs... immediate
> > checking whether stripping libraries is possible... yes
> > checking if libtool supports shared libraries... yes
> > checking whether to build shared libraries... yes
> > checking whether to build static libraries... yes
> > checking how to run the C++ preprocessor... g++ -E
> > checking for ld used by g++... /usr/bin/ld
> > checking if the linker (/usr/bin/ld) is GNU ld... yes
> > checking whether the g++ linker (/usr/bin/ld) supports shared
> libraries...
> > yes
> > checking for g++ option to produce PIC... -fPIC -DPIC
> > checking if g++ PIC flag -fPIC -DPIC works... yes
> > checking if g++ static flag -static works... yes
> > checking if g++ supports -c -o file.o... yes
> > checking if g++ supports -c -o file.o... (cached) yes
> > checking whether the g++ linker (/usr/bin/ld) supports shared
> libraries...
> > yes
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
> to
> > detect library format (unsupported architecture (armv7l)?)
> >
> >
> > In the configure.ac file i had made an entry for arm7l but even then i
> am
> > seeing this error . I am doing this on my target machine . can anyone
> help
> > me with this??
>
> There is a fix for cross-compiling in lttng-ust 2.0.5. Please upgrade.
> Refer to the Changelog for details,
>
> Thanks,
>
> Mathieu
>
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
>

--e0cb4efe2f96c1428f04ca714259
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I got the same issue in=A0
<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:1=
3px;background-color:rgb(255,255,255)">=A0lttng-ust 2.0.5</span>=A0 . I add=
ed the line=A0=A0<span style=3D"background-color:rgb(255,255,255);font-size=
:medium">armv7l) LIBFORMAT=3D&quot;elf32-littlearm&quot;; NO_UNALIGNED_ACCE=
SS=3D1 ;; in <a href=3D"http://configure.ac">configure.ac</a> file . Even t=
hen i am able to see this issue.</span><br>
<br><br><br><div class=3D"gmail_quote">On Mon, Sep 24, 2012 at 5:03 PM, Mat=
hieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span>=
 wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">* me=
her chaitanya (<a href=3D"mailto:meher.146@gmail.com">meher.146@gmail.com</=
a>) wrote:<br>

&gt; root@lttng:/home/ltt/lttng-ust-2.0.4# ./configure<br>
&gt; checking build system type... armv7l-unknown-linux-gnueabi<br>
&gt; checking host system type... armv7l-unknown-linux-gnueabi<br>
&gt; checking target system type... armv7l-unknown-linux-gnueabi<br>
&gt; checking for a BSD-compatible install... /usr/bin/install -c<br>
&gt; checking whether build environment is sane... yes<br>
&gt; checking for a thread-safe mkdir -p... /bin/mkdir -p<br>
&gt; checking for gawk... no<br>
&gt; checking for mawk... mawk<br>
&gt; checking whether make sets $(MAKE)... yes<br>
&gt; checking whether make supports nested variables... yes<br>
&gt; checking for a sed that does not truncate output... /bin/sed<br>
&gt; checking for gcc... gcc<br>
&gt; checking whether the C compiler works... yes<br>
&gt; checking for C compiler default output file name... a.out<br>
&gt; checking for suffix of executables...<br>
&gt; checking whether we are cross compiling... no<br>
&gt; checking for suffix of object files... o<br>
&gt; checking whether we are using the GNU C compiler... yes<br>
&gt; checking whether gcc accepts -g... yes<br>
&gt; checking for gcc option to accept ISO C89... none needed<br>
&gt; checking for style of include used by make... GNU<br>
&gt; checking dependency style of gcc... gcc3<br>
&gt; checking for g++... g++<br>
&gt; checking whether we are using the GNU C++ compiler... yes<br>
&gt; checking whether g++ accepts -g... yes<br>
&gt; checking dependency style of g++... gcc3<br>
&gt; checking whether make sets $(MAKE)... (cached) yes<br>
&gt; checking how to print strings... printf<br>
&gt; checking for a sed that does not truncate output... (cached) /bin/sed<=
br>
&gt; checking for grep that handles long lines and -e... /bin/grep<br>
&gt; checking for egrep... /bin/grep -E<br>
&gt; checking for fgrep... /bin/grep -F<br>
&gt; checking for ld used by gcc... /usr/bin/ld<br>
&gt; checking if the linker (/usr/bin/ld) is GNU ld... yes<br>
&gt; checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B<=
br>
&gt; checking the name lister (/usr/bin/nm -B) interface... BSD nm<br>
&gt; checking whether ln -s works... yes<br>
&gt; checking the maximum length of command line arguments... 1572864<br>
&gt; checking whether the shell understands some XSI constructs... yes<br>
&gt; checking whether the shell understands &quot;+=3D&quot;... yes<br>
&gt; checking how to convert armv7l-unknown-linux-gnueabi file names to<br>
&gt; armv7l-unknown-linux-gnueabi format... func_convert_file_noop<br>
&gt; checking how to convert armv7l-unknown-linux-gnueabi file names to<br>
&gt; toolchain format... func_convert_file_noop<br>
&gt; checking for /usr/bin/ld option to reload object files... -r<br>
&gt; checking for objdump... objdump<br>
&gt; checking how to recognize dependent libraries... pass_all<br>
&gt; checking for dlltool... no<br>
&gt; checking how to associate runtime and link libraries... printf %s\n<br=
>
&gt; checking for ar... ar<br>
&gt; checking for archiver @FILE support... @<br>
&gt; checking for strip... strip<br>
&gt; checking for ranlib... ranlib<br>
&gt; checking command to parse /usr/bin/nm -B output from gcc object... ok<=
br>
&gt; checking for sysroot... no<br>
&gt; checking for mt... mt<br>
&gt; checking if mt is a manifest tool... no<br>
&gt; checking how to run the C preprocessor... gcc -E<br>
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
&gt; checking for dlfcn.h... yes<br>
&gt; checking for objdir... .libs<br>
&gt; checking if gcc supports -fno-rtti -fno-exceptions... no<br>
&gt; checking for gcc option to produce PIC... -fPIC -DPIC<br>
&gt; checking if gcc PIC flag -fPIC -DPIC works... yes<br>
&gt; checking if gcc static flag -static works... yes<br>
&gt; checking if gcc supports -c -o file.o... yes<br>
&gt; checking if gcc supports -c -o file.o... (cached) yes<br>
&gt; checking whether the gcc linker (/usr/bin/ld) supports shared librarie=
s...<br>
&gt; yes<br>
&gt; checking whether -lc should be explicitly linked in... no<br>
&gt; checking dynamic linker characteristics... GNU/Linux ld.so<br>
&gt; checking how to hardcode library paths into programs... immediate<br>
&gt; checking whether stripping libraries is possible... yes<br>
&gt; checking if libtool supports shared libraries... yes<br>
&gt; checking whether to build shared libraries... yes<br>
&gt; checking whether to build static libraries... yes<br>
&gt; checking how to run the C++ preprocessor... g++ -E<br>
&gt; checking for ld used by g++... /usr/bin/ld<br>
&gt; checking if the linker (/usr/bin/ld) is GNU ld... yes<br>
&gt; checking whether the g++ linker (/usr/bin/ld) supports shared librarie=
s...<br>
&gt; yes<br>
&gt; checking for g++ option to produce PIC... -fPIC -DPIC<br>
&gt; checking if g++ PIC flag -fPIC -DPIC works... yes<br>
&gt; checking if g++ static flag -static works... yes<br>
&gt; checking if g++ supports -c -o file.o... yes<br>
&gt; checking if g++ supports -c -o file.o... (cached) yes<br>
&gt; checking whether the g++ linker (/usr/bin/ld) supports shared librarie=
s...<br>
&gt; yes<br>
&gt; checking dynamic linker characteristics... (cached) GNU/Linux ld.so<br=
>
&gt; checking how to hardcode library paths into programs... immediate<br>
&gt; checking for dlopen in -ldl... yes<br>
&gt; checking for pthread_create in -lpthread... yes<br>
&gt; checking for uuid_generate in -luuid... yes<br>
&gt; checking for inline... inline<br>
&gt; checking for stdlib.h... (cached) yes<br>
&gt; checking for GNU libc compatible malloc... yes<br>
&gt; checking for gettimeofday... yes<br>
&gt; checking for munmap... yes<br>
&gt; checking for socket... yes<br>
&gt; checking for strerror... yes<br>
&gt; checking for strtol... yes<br>
&gt; checking for sched_getcpu... yes<br>
&gt; checking for sysconf... yes<br>
&gt; checking for makeinfo... yes<br>
&gt; checking urcu-bp.h usability... yes<br>
&gt; checking urcu-bp.h presence... yes<br>
&gt; checking for urcu-bp.h... yes<br>
&gt; checking caa_likely()... yes<br>
&gt; checking for synchronize_rcu_bp in -lurcu-bp... yes<br>
&gt; checking for call_rcu_bp in -lurcu-bp... yes<br>
&gt; checking library format for the host system... configure: error: unabl=
e to<br>
&gt; detect library format (unsupported architecture (armv7l)?)<br>
&gt;<br>
&gt;<br>
&gt; In the <a href=3D"http://configure.ac" target=3D"_blank">configure.ac<=
/a> file i had made an entry for arm7l but even then i am<br>
&gt; seeing this error . I am doing this on my target machine . can anyone =
help<br>
&gt; me with this??<br>
<br>
</div></div>There is a fix for cross-compiling in lttng-ust 2.0.5. Please u=
pgrade.<br>
Refer to the Changelog for details,<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Mathieu Desnoyers<br>
Operating System Efficiency R&amp;D Consultant<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br>

--e0cb4efe2f96c1428f04ca714259--


--===============1766625553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1766625553==--
