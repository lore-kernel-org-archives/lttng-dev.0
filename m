From: meher chaitanya <meher.146@gmail.com>
Subject: Re: unable to detect library format (unsupported
 architecture (armv7l)
Date: Tue, 25 Sep 2012 00:46:23 +0530
Message-ID: <CA+Kk8NuYbcbeOyRxJzOK4QbS-zKC0TJPs=bYxN_Wvhb0h0UAwQ__48977.4158144884$1348514226$gmane$org@mail.gmail.com>
References: <CA+Kk8Ns_q-yeT9LWAB3s5UY=uhObkUbCWX8_MCy7n_5ni696zQ@mail.gmail.com>
	<CA+Kk8NtDww0o1-S1Q6OViV9kgkbEBn6Ybi=_MhCokkKrp_4tiQ@mail.gmail.com>
	<CAGDH53kkGwNgwX4ijhUBOzwpdz0KQExLZbnxTmMmaRO-R3fGeg@mail.gmail.com>
	<CA+Kk8NtDQ_1uC6t1+D5XM5MijO5-7=RBBH_afua_Z5dVO3cyjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0648994267=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <meher.146@gmail.com>) id 1TGE8s-0004SP-6H
	for lttng-dev@lists.lttng.org; Mon, 24 Sep 2012 15:16:31 -0400
Received: by lboi15 with SMTP id i15so8612839lbo.35
	for <lttng-dev@lists.lttng.org>; Mon, 24 Sep 2012 12:16:24 -0700 (PDT)
In-Reply-To: <CA+Kk8NtDQ_1uC6t1+D5XM5MijO5-7=RBBH_afua_Z5dVO3cyjg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0648994267==
Content-Type: multipart/alternative; boundary=f46d0434bfdee694c304ca776c73

--f46d0434bfdee694c304ca776c73
Content-Type: text/plain; charset=ISO-8859-1

But while trying to do the make on lttng-modules i am getting the following
error

root@lttng:/home/meher/ltt/lttng-modules-2.0.4# make
make -C /lib/modules/3.1.10-00085-gc7ae3c9/build
M=/home/meher/ltt/lttng-modules-2.0.4 modules
make: *** /lib/modules/3.1.10-00085-gc7ae3c9/build: No such file or
directory.  Stop.
make: *** [default] Error 2

Thanks & Regards
Meher




On Tue, Sep 25, 2012 at 12:06 AM, meher chaitanya <meher.146@gmail.com>wrote:

> Hi I followed the way you specified ./configure ran successfully . But
>> when i am trying to do the make its reporting the following errors
>>
>
> Making all in hello
> make[3]: Entering directory `/home/nvidia/ltt/lttng-ust-2.0.4/tests/hello'
> make[3]: Warning: File `.deps/tp.Po' has modification time 1.6e+04 s in
> the future
>   CC     tp.o
>   CCLD   hello
> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
> `shm_object_table_append'
> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
> `align_shm'
> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
> `shm_object_table_create'
> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
> `_get_num_possible_cpus'
> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
> `zalloc_shm'
> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
> `__num_possible_cpus'
> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
> `shm_object_table_append_shadow'
> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
> `shm_object_table_destroy'
> collect2: ld returned 1 exit status
> make[3]: *** [hello] Error 1
> make[3]: Leaving directory `/home/nvidia/ltt/lttng-ust-2.0.4/tests/hello'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/home/nvidia/ltt/lttng-ust-2.0.4/tests'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/nvidia/ltt/lttng-ust-2.0.4'
> make: *** [all] Error 2
>
> can you kindly help me with this error.
>
>
> Thanks & Regards
> Meher Chaitanya
>
>
>
>
>> The change that you applied to your lttng-ust configure.ac should look
>>
>> like this:
>>
>> diff --git a/configure.ac b/configure.ac
>> index ea73243..efb16d4 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -209,6 +209,7 @@ changequote([,])dnl
>>         s390) LIBFORMAT="elf32-s390"; NO_UNALIGNED_ACCESS=1 ;;
>>         s390x) LIBFORMAT="elf64-s390"; NO_UNALIGNED_ACCESS=1 ;;
>>          armv5) LIBFORMAT="elf32-littlearm"; NO_UNALIGNED_ACCESS=1 ;;
>> +        armv7l) LIBFORMAT="elf32-littlearm"; NO_UNALIGNED_ACCESS=1 ;;
>>         arm) LIBFORMAT="elf32-littlearm"; NO_UNALIGNED_ACCESS=1 ;;
>>         mips*) LIBFORMAT=""; NO_UNALIGNED_ACCESS=1;;
>>         *) AC_MSG_ERROR([unable to detect library format (unsupported
>> architecture ($host_cpu)?)]) ;;
>>
>> Make sure after making this change that you run the autoreconf command
>> like this:
>>
>> autoreconf -i -v
>>
>> And then rerun ./configure with your platform specific flags.
>> The configure test should now pass without problem :).
>>
>> Thanks,
>>
>> Christian
>>
>> On Mon, Sep 24, 2012 at 12:31 PM, meher chaitanya <meher.146@gmail.com>
>> wrote:
>> > 1) I am using NFS file system and i am directly trying to set up the
>> lttng
>> > tool on my target ( its 3.1 kernel ) ( NO CROSS COMPILING : downloading
>> it
>> > on target and trying to set up )
>> >                       a) downloaded and extracted the files
>> >                       b) userspace-rcu was successfully installed ,
>> > configured and compiled using make and make install
>> >                       c) But for Lttng-ust i am getting the error "
>> > checking library format for the host system... configure: error: unable
>> to
>> >
>> >
>> > detect library format (unsupported architecture (armv7l)? "
>> >                        I tried to  change the configure.ac file to
>> make a
>> > new entry for armv7l . but even then this issue reproduces.
>> >
>> > can you help me with this as i am new to LTTNG  and this is very much
>> needed
>> > for my project . Thanks in advance.
>> >
>> >
>> > Thanks & Regards
>> >
>> > On Mon, Sep 24, 2012 at 3:46 PM, meher chaitanya <meher.146@gmail.com>
>> > wrote:
>> >>
>> >> root@lttng:/home/ltt/lttng-ust-2.0.4# ./configure
>> >> checking build system type... armv7l-unknown-linux-gnueabi
>> >> checking host system type... armv7l-unknown-linux-gnueabi
>> >> checking target system type... armv7l-unknown-linux-gnueabi
>> >> checking for a BSD-compatible install... /usr/bin/install -c
>> >> checking whether build environment is sane... yes
>> >> checking for a thread-safe mkdir -p... /bin/mkdir -p
>> >> checking for gawk... no
>> >> checking for mawk... mawk
>> >> checking whether make sets $(MAKE)... yes
>> >> checking whether make supports nested variables... yes
>> >> checking for a sed that does not truncate output... /bin/sed
>> >> checking for gcc... gcc
>> >> checking whether the C compiler works... yes
>> >> checking for C compiler default output file name... a.out
>> >> checking for suffix of executables...
>> >> checking whether we are cross compiling... no
>> >> checking for suffix of object files... o
>> >> checking whether we are using the GNU C compiler... yes
>> >> checking whether gcc accepts -g... yes
>> >> checking for gcc option to accept ISO C89... none needed
>> >> checking for style of include used by make... GNU
>> >> checking dependency style of gcc... gcc3
>> >> checking for g++... g++
>> >> checking whether we are using the GNU C++ compiler... yes
>> >> checking whether g++ accepts -g... yes
>> >> checking dependency style of g++... gcc3
>> >> checking whether make sets $(MAKE)... (cached) yes
>> >> checking how to print strings... printf
>> >> checking for a sed that does not truncate output... (cached) /bin/sed
>> >> checking for grep that handles long lines and -e... /bin/grep
>> >> checking for egrep... /bin/grep -E
>> >> checking for fgrep... /bin/grep -F
>> >> checking for ld used by gcc... /usr/bin/ld
>> >> checking if the linker (/usr/bin/ld) is GNU ld... yes
>> >> checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
>> >> checking the name lister (/usr/bin/nm -B) interface... BSD nm
>> >> checking whether ln -s works... yes
>> >> checking the maximum length of command line arguments... 1572864
>> >> checking whether the shell understands some XSI constructs... yes
>> >> checking whether the shell understands "+="... yes
>> >> checking how to convert armv7l-unknown-linux-gnueabi file names to
>> >> armv7l-unknown-linux-gnueabi format... func_convert_file_noop
>> >> checking how to convert armv7l-unknown-linux-gnueabi file names to
>> >> toolchain format... func_convert_file_noop
>> >> checking for /usr/bin/ld option to reload object files... -r
>> >> checking for objdump... objdump
>> >> checking how to recognize dependent libraries... pass_all
>> >> checking for dlltool... no
>> >> checking how to associate runtime and link libraries... printf %s\n
>> >> checking for ar... ar
>> >> checking for archiver @FILE support... @
>> >> checking for strip... strip
>> >> checking for ranlib... ranlib
>> >> checking command to parse /usr/bin/nm -B output from gcc object... ok
>> >> checking for sysroot... no
>> >> checking for mt... mt
>> >> checking if mt is a manifest tool... no
>> >> checking how to run the C preprocessor... gcc -E
>> >> checking for ANSI C header files... yes
>> >> checking for sys/types.h... yes
>> >> checking for sys/stat.h... yes
>> >> checking for stdlib.h... yes
>> >> checking for string.h... yes
>> >> checking for memory.h... yes
>> >> checking for strings.h... yes
>> >> checking for inttypes.h... yes
>> >> checking for stdint.h... yes
>> >> checking for unistd.h... yes
>> >> checking for dlfcn.h... yes
>> >> checking for objdir... .libs
>> >> checking if gcc supports -fno-rtti -fno-exceptions... no
>> >> checking for gcc option to produce PIC... -fPIC -DPIC
>> >> checking if gcc PIC flag -fPIC -DPIC works... yes
>> >> checking if gcc static flag -static works... yes
>> >> checking if gcc supports -c -o file.o... yes
>> >> checking if gcc supports -c -o file.o... (cached) yes
>> >> checking whether the gcc linker (/usr/bin/ld) supports shared
>> libraries...
>> >> yes
>> >> checking whether -lc should be explicitly linked in... no
>> >> checking dynamic linker characteristics... GNU/Linux ld.so
>> >> checking how to hardcode library paths into programs... immediate
>> >> checking whether stripping libraries is possible... yes
>> >> checking if libtool supports shared libraries... yes
>> >> checking whether to build shared libraries... yes
>> >> checking whether to build static libraries... yes
>> >> checking how to run the C++ preprocessor... g++ -E
>> >> checking for ld used by g++... /usr/bin/ld
>> >> checking if the linker (/usr/bin/ld) is GNU ld... yes
>> >> checking whether the g++ linker (/usr/bin/ld) supports shared
>> libraries...
>> >> yes
>> >> checking for g++ option to produce PIC... -fPIC -DPIC
>> >> checking if g++ PIC flag -fPIC -DPIC works... yes
>> >> checking if g++ static flag -static works... yes
>> >> checking if g++ supports -c -o file.o... yes
>> >> checking if g++ supports -c -o file.o... (cached) yes
>> >> checking whether the g++ linker (/usr/bin/ld) supports shared
>> libraries...
>> >> yes
>> >> checking dynamic linker characteristics... (cached) GNU/Linux ld.so
>> >> checking how to hardcode library paths into programs... immediate
>> >> checking for dlopen in -ldl... yes
>> >> checking for pthread_create in -lpthread... yes
>> >> checking for uuid_generate in -luuid... yes
>> >> checking for inline... inline
>> >> checking for stdlib.h... (cached) yes
>> >> checking for GNU libc compatible malloc... yes
>> >> checking for gettimeofday... yes
>> >> checking for munmap... yes
>> >> checking for socket... yes
>> >> checking for strerror... yes
>> >> checking for strtol... yes
>> >> checking for sched_getcpu... yes
>> >> checking for sysconf... yes
>> >> checking for makeinfo... yes
>> >> checking urcu-bp.h usability... yes
>> >> checking urcu-bp.h presence... yes
>> >> checking for urcu-bp.h... yes
>> >> checking caa_likely()... yes
>> >> checking for synchronize_rcu_bp in -lurcu-bp... yes
>> >> checking for call_rcu_bp in -lurcu-bp... yes
>> >> checking library format for the host system... configure: error:
>> unable to
>> >> detect library format (unsupported architecture (armv7l)?)
>> >>
>> >>
>> >> In the configure.ac file i had made an entry for arm7l but even then
>> i am
>> >> seeing this error . I am doing this on my target machine . can anyone
>> help
>> >> me with this??
>> >>
>> >
>> >
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> >
>>
>
>

--f46d0434bfdee694c304ca776c73
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

But while trying to do the make on lttng-modules i am getting the following=
 error<div><br></div><div><div>root@lttng:/home/meher/ltt/lttng-modules-2.0=
.4# make</div><div>make -C /lib/modules/3.1.10-00085-gc7ae3c9/build M=3D/ho=
me/meher/ltt/lttng-modules-2.0.4 modules</div>
<div>make: *** /lib/modules/3.1.10-00085-gc7ae3c9/build: No such file or di=
rectory. =A0Stop.</div><div>make: *** [default] Error 2</div><div><br></div=
><div>Thanks &amp; Regards</div><div>Meher</div><div><br></div><div><br></d=
iv>
<div><br></div><br><div class=3D"gmail_quote">On Tue, Sep 25, 2012 at 12:06=
 AM, meher chaitanya <span dir=3D"ltr">&lt;<a href=3D"mailto:meher.146@gmai=
l.com" target=3D"_blank">meher.146@gmail.com</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi I followed the=
 way you specified ./configure ran successfully . But when i am trying to d=
o the make its reporting the following errors=A0<br>

</blockquote><div>=A0 =A0=A0</div><div>Making all in hello</div><div>make[3=
]: Entering directory `/home/nvidia/ltt/lttng-ust-2.0.4/tests/hello&#39;</d=
iv><div>make[3]: Warning: File `.deps/tp.Po&#39; has modification time 1.6e=
+04 s in the future</div>

<div>=A0 CC =A0 =A0 tp.o</div><div>=A0 CCLD =A0 hello</div><div>../../liblt=
tng-ust/.libs/liblttng-ust.so: undefined reference to `shm_object_table_app=
end&#39;</div><div>../../liblttng-ust/.libs/liblttng-ust.so: undefined refe=
rence to `align_shm&#39;</div>

<div>../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to `shm_=
object_table_create&#39;</div><div>../../liblttng-ust/.libs/liblttng-ust.so=
: undefined reference to `_get_num_possible_cpus&#39;</div><div>../../liblt=
tng-ust/.libs/liblttng-ust.so: undefined reference to `zalloc_shm&#39;</div=
>

<div>../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to `__nu=
m_possible_cpus&#39;</div><div>../../liblttng-ust/.libs/liblttng-ust.so: un=
defined reference to `shm_object_table_append_shadow&#39;</div><div>../../l=
iblttng-ust/.libs/liblttng-ust.so: undefined reference to `shm_object_table=
_destroy&#39;</div>

<div>collect2: ld returned 1 exit status</div><div>make[3]: *** [hello] Err=
or 1</div><div>make[3]: Leaving directory `/home/nvidia/ltt/lttng-ust-2.0.4=
/tests/hello&#39;</div><div>make[2]: *** [all-recursive] Error 1</div>
<div>
make[2]: Leaving directory `/home/nvidia/ltt/lttng-ust-2.0.4/tests&#39;</di=
v><div>make[1]: *** [all-recursive] Error 1</div><div>make[1]: Leaving dire=
ctory `/home/nvidia/ltt/lttng-ust-2.0.4&#39;</div><div>make: *** [all] Erro=
r 2</div>

<div><br></div><div>can you kindly help me with this error.=A0</div><div cl=
ass=3D"im"><div><br></div><div><br></div><div>Thanks &amp; Regards=A0</div>=
<div>Meher Chaitanya</div><div><br></div><div><br></div><div>=A0</div></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">


The change that you applied to your lttng-ust <a href=3D"http://configure.a=
c" target=3D"_blank">configure.ac</a> should look<div><div class=3D"h5"><br=
>
like this:<br>
<br>
diff --git a/<a href=3D"http://configure.ac" target=3D"_blank">configure.ac=
</a> b/<a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a><b=
r>
index ea73243..efb16d4 100644<br>
--- a/<a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a><br=
>
+++ b/<a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a><br=
>
@@ -209,6 +209,7 @@ changequote([,])dnl<br>
=A0 =A0 =A0 =A0 s390) LIBFORMAT=3D&quot;elf32-s390&quot;; NO_UNALIGNED_ACCE=
SS=3D1 ;;<br>
=A0 =A0 =A0 =A0 s390x) LIBFORMAT=3D&quot;elf64-s390&quot;; NO_UNALIGNED_ACC=
ESS=3D1 ;;<br>
=A0 =A0 =A0 =A0 =A0armv5) LIBFORMAT=3D&quot;elf32-littlearm&quot;; NO_UNALI=
GNED_ACCESS=3D1 ;;<br>
+ =A0 =A0 =A0 =A0armv7l) LIBFORMAT=3D&quot;elf32-littlearm&quot;; NO_UNALIG=
NED_ACCESS=3D1 ;;<br>
=A0 =A0 =A0 =A0 arm) LIBFORMAT=3D&quot;elf32-littlearm&quot;; NO_UNALIGNED_=
ACCESS=3D1 ;;<br>
=A0 =A0 =A0 =A0 mips*) LIBFORMAT=3D&quot;&quot;; NO_UNALIGNED_ACCESS=3D1;;<=
br>
=A0 =A0 =A0 =A0 *) AC_MSG_ERROR([unable to detect library format (unsupport=
ed<br>
architecture ($host_cpu)?)]) ;;<br>
<br>
Make sure after making this change that you run the autoreconf command<br>
like this:<br>
<br>
autoreconf -i -v<br>
<br>
And then rerun ./configure with your platform specific flags.<br>
The configure test should now pass without problem :).<br>
<br>
Thanks,<br>
<br>
Christian<br>
<div><div><br>
On Mon, Sep 24, 2012 at 12:31 PM, meher chaitanya &lt;<a href=3D"mailto:meh=
er.146@gmail.com" target=3D"_blank">meher.146@gmail.com</a>&gt; wrote:<br>
&gt; 1) I am using NFS file system and i am directly trying to set up the l=
ttng<br>
&gt; tool on my target ( its 3.1 kernel ) ( NO CROSS COMPILING : downloadin=
g it<br>
&gt; on target and trying to set up )<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a) downloaded and extracte=
d the files<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 b) userspace-rcu was succe=
ssfully installed ,<br>
&gt; configured and compiled using make and make install<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c) But for Lttng-ust i am =
getting the error &quot;<br>
&gt; checking library format for the host system... configure: error: unabl=
e to<br>
&gt;<br>
&gt;<br>
&gt; detect library format (unsupported architecture (armv7l)? &quot;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0I tried to =A0change th=
e <a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a> file t=
o make a<br>
&gt; new entry for armv7l . but even then this issue reproduces.<br>
&gt;<br>
&gt; can you help me with this as i am new to LTTNG =A0and this is very muc=
h needed<br>
&gt; for my project . Thanks in advance.<br>
&gt;<br>
&gt;<br>
&gt; Thanks &amp; Regards<br>
&gt;<br>
&gt; On Mon, Sep 24, 2012 at 3:46 PM, meher chaitanya &lt;<a href=3D"mailto=
:meher.146@gmail.com" target=3D"_blank">meher.146@gmail.com</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; root@lttng:/home/ltt/lttng-ust-2.0.4# ./configure<br>
&gt;&gt; checking build system type... armv7l-unknown-linux-gnueabi<br>
&gt;&gt; checking host system type... armv7l-unknown-linux-gnueabi<br>
&gt;&gt; checking target system type... armv7l-unknown-linux-gnueabi<br>
&gt;&gt; checking for a BSD-compatible install... /usr/bin/install -c<br>
&gt;&gt; checking whether build environment is sane... yes<br>
&gt;&gt; checking for a thread-safe mkdir -p... /bin/mkdir -p<br>
&gt;&gt; checking for gawk... no<br>
&gt;&gt; checking for mawk... mawk<br>
&gt;&gt; checking whether make sets $(MAKE)... yes<br>
&gt;&gt; checking whether make supports nested variables... yes<br>
&gt;&gt; checking for a sed that does not truncate output... /bin/sed<br>
&gt;&gt; checking for gcc... gcc<br>
&gt;&gt; checking whether the C compiler works... yes<br>
&gt;&gt; checking for C compiler default output file name... a.out<br>
&gt;&gt; checking for suffix of executables...<br>
&gt;&gt; checking whether we are cross compiling... no<br>
&gt;&gt; checking for suffix of object files... o<br>
&gt;&gt; checking whether we are using the GNU C compiler... yes<br>
&gt;&gt; checking whether gcc accepts -g... yes<br>
&gt;&gt; checking for gcc option to accept ISO C89... none needed<br>
&gt;&gt; checking for style of include used by make... GNU<br>
&gt;&gt; checking dependency style of gcc... gcc3<br>
&gt;&gt; checking for g++... g++<br>
&gt;&gt; checking whether we are using the GNU C++ compiler... yes<br>
&gt;&gt; checking whether g++ accepts -g... yes<br>
&gt;&gt; checking dependency style of g++... gcc3<br>
&gt;&gt; checking whether make sets $(MAKE)... (cached) yes<br>
&gt;&gt; checking how to print strings... printf<br>
&gt;&gt; checking for a sed that does not truncate output... (cached) /bin/=
sed<br>
&gt;&gt; checking for grep that handles long lines and -e... /bin/grep<br>
&gt;&gt; checking for egrep... /bin/grep -E<br>
&gt;&gt; checking for fgrep... /bin/grep -F<br>
&gt;&gt; checking for ld used by gcc... /usr/bin/ld<br>
&gt;&gt; checking if the linker (/usr/bin/ld) is GNU ld... yes<br>
&gt;&gt; checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm=
 -B<br>
&gt;&gt; checking the name lister (/usr/bin/nm -B) interface... BSD nm<br>
&gt;&gt; checking whether ln -s works... yes<br>
&gt;&gt; checking the maximum length of command line arguments... 1572864<b=
r>
&gt;&gt; checking whether the shell understands some XSI constructs... yes<=
br>
&gt;&gt; checking whether the shell understands &quot;+=3D&quot;... yes<br>
&gt;&gt; checking how to convert armv7l-unknown-linux-gnueabi file names to=
<br>
&gt;&gt; armv7l-unknown-linux-gnueabi format... func_convert_file_noop<br>
&gt;&gt; checking how to convert armv7l-unknown-linux-gnueabi file names to=
<br>
&gt;&gt; toolchain format... func_convert_file_noop<br>
&gt;&gt; checking for /usr/bin/ld option to reload object files... -r<br>
&gt;&gt; checking for objdump... objdump<br>
&gt;&gt; checking how to recognize dependent libraries... pass_all<br>
&gt;&gt; checking for dlltool... no<br>
&gt;&gt; checking how to associate runtime and link libraries... printf %s\=
n<br>
&gt;&gt; checking for ar... ar<br>
&gt;&gt; checking for archiver @FILE support... @<br>
&gt;&gt; checking for strip... strip<br>
&gt;&gt; checking for ranlib... ranlib<br>
&gt;&gt; checking command to parse /usr/bin/nm -B output from gcc object...=
 ok<br>
&gt;&gt; checking for sysroot... no<br>
&gt;&gt; checking for mt... mt<br>
&gt;&gt; checking if mt is a manifest tool... no<br>
&gt;&gt; checking how to run the C preprocessor... gcc -E<br>
&gt;&gt; checking for ANSI C header files... yes<br>
&gt;&gt; checking for sys/types.h... yes<br>
&gt;&gt; checking for sys/stat.h... yes<br>
&gt;&gt; checking for stdlib.h... yes<br>
&gt;&gt; checking for string.h... yes<br>
&gt;&gt; checking for memory.h... yes<br>
&gt;&gt; checking for strings.h... yes<br>
&gt;&gt; checking for inttypes.h... yes<br>
&gt;&gt; checking for stdint.h... yes<br>
&gt;&gt; checking for unistd.h... yes<br>
&gt;&gt; checking for dlfcn.h... yes<br>
&gt;&gt; checking for objdir... .libs<br>
&gt;&gt; checking if gcc supports -fno-rtti -fno-exceptions... no<br>
&gt;&gt; checking for gcc option to produce PIC... -fPIC -DPIC<br>
&gt;&gt; checking if gcc PIC flag -fPIC -DPIC works... yes<br>
&gt;&gt; checking if gcc static flag -static works... yes<br>
&gt;&gt; checking if gcc supports -c -o file.o... yes<br>
&gt;&gt; checking if gcc supports -c -o file.o... (cached) yes<br>
&gt;&gt; checking whether the gcc linker (/usr/bin/ld) supports shared libr=
aries...<br>
&gt;&gt; yes<br>
&gt;&gt; checking whether -lc should be explicitly linked in... no<br>
&gt;&gt; checking dynamic linker characteristics... GNU/Linux ld.so<br>
&gt;&gt; checking how to hardcode library paths into programs... immediate<=
br>
&gt;&gt; checking whether stripping libraries is possible... yes<br>
&gt;&gt; checking if libtool supports shared libraries... yes<br>
&gt;&gt; checking whether to build shared libraries... yes<br>
&gt;&gt; checking whether to build static libraries... yes<br>
&gt;&gt; checking how to run the C++ preprocessor... g++ -E<br>
&gt;&gt; checking for ld used by g++... /usr/bin/ld<br>
&gt;&gt; checking if the linker (/usr/bin/ld) is GNU ld... yes<br>
&gt;&gt; checking whether the g++ linker (/usr/bin/ld) supports shared libr=
aries...<br>
&gt;&gt; yes<br>
&gt;&gt; checking for g++ option to produce PIC... -fPIC -DPIC<br>
&gt;&gt; checking if g++ PIC flag -fPIC -DPIC works... yes<br>
&gt;&gt; checking if g++ static flag -static works... yes<br>
&gt;&gt; checking if g++ supports -c -o file.o... yes<br>
&gt;&gt; checking if g++ supports -c -o file.o... (cached) yes<br>
&gt;&gt; checking whether the g++ linker (/usr/bin/ld) supports shared libr=
aries...<br>
&gt;&gt; yes<br>
&gt;&gt; checking dynamic linker characteristics... (cached) GNU/Linux ld.s=
o<br>
&gt;&gt; checking how to hardcode library paths into programs... immediate<=
br>
&gt;&gt; checking for dlopen in -ldl... yes<br>
&gt;&gt; checking for pthread_create in -lpthread... yes<br>
&gt;&gt; checking for uuid_generate in -luuid... yes<br>
&gt;&gt; checking for inline... inline<br>
&gt;&gt; checking for stdlib.h... (cached) yes<br>
&gt;&gt; checking for GNU libc compatible malloc... yes<br>
&gt;&gt; checking for gettimeofday... yes<br>
&gt;&gt; checking for munmap... yes<br>
&gt;&gt; checking for socket... yes<br>
&gt;&gt; checking for strerror... yes<br>
&gt;&gt; checking for strtol... yes<br>
&gt;&gt; checking for sched_getcpu... yes<br>
&gt;&gt; checking for sysconf... yes<br>
&gt;&gt; checking for makeinfo... yes<br>
&gt;&gt; checking urcu-bp.h usability... yes<br>
&gt;&gt; checking urcu-bp.h presence... yes<br>
&gt;&gt; checking for urcu-bp.h... yes<br>
&gt;&gt; checking caa_likely()... yes<br>
&gt;&gt; checking for synchronize_rcu_bp in -lurcu-bp... yes<br>
&gt;&gt; checking for call_rcu_bp in -lurcu-bp... yes<br>
&gt;&gt; checking library format for the host system... configure: error: u=
nable to<br>
&gt;&gt; detect library format (unsupported architecture (armv7l)?)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; In the <a href=3D"http://configure.ac" target=3D"_blank">configure=
.ac</a> file i had made an entry for arm7l but even then i am<br>
&gt;&gt; seeing this error . I am doing this on my target machine . can any=
one help<br>
&gt;&gt; me with this??<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
</div></div><div><div>&gt; _______________________________________________<=
br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
</div></div></div></div></blockquote></div><br>
</blockquote></div><br></div>

--f46d0434bfdee694c304ca776c73--


--===============0648994267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0648994267==--
