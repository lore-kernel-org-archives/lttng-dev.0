From: Arthur LAMBERT <arthur.lambert@sagemcom.com>
Subject: Re: Compilation error with openwrt and uclibc 0.9.31
Date: Thu, 26 Sep 2013 10:03:35 +0200
Message-ID: <5243EA57.9010803__40832.4462514885$1380182940$gmane$org@sagemcom.com>
References: <5242C3C4.3060207@sagemcom.com>
	<CA+jJMxuPudXDiatZfWVwUvvHJ9_WJ4gg_4vUeFapKZet4G-UFw@mail.gmail.com>
Reply-To: arthur.lambert@sagemcom.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sgc-chev-fe1.sgc.gmessaging.net ([194.51.18.91])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <arthur.lambert-ext@sagemcom.com>) id 1VP6cU-0004LT-Oy
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 04:08:21 -0400
In-Reply-To: <CA+jJMxuPudXDiatZfWVwUvvHJ9_WJ4gg_4vUeFapKZet4G-UFw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi

I am also aware that I can only profiling user space with my current =

kernel version. That's why I am only trying to install ust and tools =

tarballs.
First error is the same but the next one is new with 2.1.0-rc2.

First :
In file included from smp.h:24,
                  from smp.c:25:
getcpu.h: In function 'lttng_ust_get_cpu':
getcpu.h:61: error: 'c' undeclared (first use in this function)
getcpu.h:61: error: (Each undeclared identifier is reported only once
getcpu.h:61: error: for each function it appears in.)
make[5]: *** [libringbuffer_la-smp.lo] Error 1

About my work around, it is nothing, just I return ret or cpu instead of =

c to be able to compile and see what 's next. Even if I am not able to =

fix this issue, I guess that this function is not mandatory to get a =

profiling result by using lttng.

After a second try with my work around, the next one is :


In file included from smp.h:24,
                  from ring_buffer_frontend.c:63:
getcpu.h: In function 'lttng_ust_get_cpu':
getcpu.h:58: warning: implicit declaration of function 'syscall'
In file included from ../include/lttng/align.h:21,
                  from ../include/lttng/ringbuffer-config.h:29,
                  from ring_buffer_frontend.c:64:
...../openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib/gcc/=
mips-openwrt-linux-uclibc/4.4.2/../../../../mips-openwrt-linux-uclibc/sys-i=
nclude/unistd.h: =

At top level:
...../openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib/gcc/=
mips-openwrt-linux-uclibc/4.4.2/../../../../mips-openwrt-linux-uclibc/sys-i=
nclude/unistd.h:1020: =

error: conflicting types for 'syscall'
getcpu.h:58: note: previous implicit declaration of 'syscall' was here

I will try to understand this issue. It is perhaps a good clue to fix =

the 2.3.0 build on my environment. Everything seems to be related to my =

syscall file.

Arthur.

On 25/09/2013 18:17, J=E9r=E9mie Galarneau wrote:
> On Wed, Sep 25, 2013 at 7:06 AM, Arthur LAMBERT
> <arthur.lambert@sagemcom.com> wrote:
>> Hi,
>>
>> I am using backfire version of Openwrt and would like to try to use
>> profiling features bring by tools like lttng. I found some Makefile pack=
ages
>> on openwrt website to build lttng-tools and lttng-ust with recent versio=
n of
>> openwrt version but I am not able to compile lttng without error. with
>> mine..
>>
>> Environment :
>>
>> Openwrt Backfire
>> UCLIBC 0.9.31
>> Linux kernel 2.6.28
> Please note that kernel tracing is only available on kernels >=3D 2.6.38
> (or 2.6.32 if patched appropriately).
> I'm not an openwrt user, but it seems Makefiles are only provided for
> LTTng 2.1.0. Can you confirm whether or not the build succeeds for
> that version?
>
>> ARCH mips32
>> lttng version : 2.3.0
>> librcu version : 0.8
>>
>> First problem was related to lttng-ust-2.3.0/libringbuffer/getcpu.h. I g=
et
>> an undefined reference to c variable in lttng_ust_get_cpu function. After
>> some research I was not able to find a solution about this point even if=
 I
>> seem to be up to date since I found some patch related to issue with old
>> version of uclibc than 0.9.32. This patch seems to be already integrated=
 in
>> my lttng ust version. Anyway, I found a workaround to check that the next
>> step on the compilation is find... but it is not...
>>
> Could you clarify what was the error and what is the workaround?
>
>> Compilation result :
>>
>> make package/lttng-tools/compile V=3D99
>>
>> make[1]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt'
>> make[2]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/feeds/tools/libs=
/liburcu'
>> make[2]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/feeds/tools/libs=
/liburcu'
>> make[2]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/package/e2fsprog=
s'
>> WARNING: skipping e2fsprogs -- package not selected
>> WARNING: skipping uuidgen -- package not selected
>> WARNING: skipping libext2fs -- package not selected
>> WARNING: skipping tune2fs -- package not selected
>> WARNING: skipping resize2fs -- package not selected
>> WARNING: skipping badblocks -- package not selected
>> WARNING: skipping blkid -- package not selected
>> make[2]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/package/e2fsprog=
s'
>> make[2]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/feeds/tools/deve=
l/lttng-ust'
>> CFLAGS=3D"-Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3
>> -fhonour-copts -msoft-float
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tar=
get-mips_uClibc-0.9.30.1/usr/include
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tar=
get-mips_uClibc-0.9.30.1/include
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/too=
lchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/include
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/too=
lchain-mips_gcc-4.4.2_uClibc-0.9.30.1/include
>> " CXXFLAGS=3D"-Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing =
-g3
>> -fhonour-copts -msoft-float
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tar=
get-mips_uClibc-0.9.30.1/usr/include
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tar=
get-mips_uClibc-0.9.30.1/include
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/too=
lchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/include
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/too=
lchain-mips_gcc-4.4.2_uClibc-0.9.30.1/include
>> "
>> LDFLAGS=3D"-L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/stag=
ing_dir/target-mips_uClibc-0.9.30.1/usr/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tar=
get-mips_uClibc-0.9.30.1/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/too=
lchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/too=
lchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib
>> " make  -j2 -C
>> /home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/.
>> AR=3Dmips-openwrt-linux-uclibc-ar AS=3D"mips-openwrt-linux-uclibc-gcc -c=
 -Os
>> -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3 -fhonour-copts
>> -msoft-float" LD=3Dmips-openwrt-linux-uclibc-ld
>> NM=3Dmips-openwrt-linux-uclibc-nm CC=3D"mips-openwrt-linux-uclibc-gcc"
>> GCC=3D"mips-openwrt-linux-uclibc-gcc" CXX=3D"mips-openwrt-linux-uclibc-g=
++"
>> RANLIB=3Dmips-openwrt-linux-uclibc-ranlib
>> STRIP=3Dmips-openwrt-linux-uclibc-strip
>> OBJCOPY=3Dmips-openwrt-linux-uclibc-objcopy
>> OBJDUMP=3Dmips-openwrt-linux-uclibc-objdump
>> SIZE=3Dmips-openwrt-linux-uclibc-size CROSS=3D"mips-openwrt-linux-uclibc=
-"
>> ARCH=3D"mips" ;
>> make[3]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> make  all-recursive
>> make[4]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> Making all in .
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> make[5]: Nothing to be done for `all-am'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> Making all in include
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/include'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/include'
>> Making all in snprintf
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/snprintf'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/snprintf'
>> Making all in libringbuffer
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/libringbuffer'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/libringbuffer'
>> Making all in liblttng-ust-comm
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-comm'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-comm'
>> Making all in liblttng-ust
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust'
>> Making all in liblttng-ust-ctl
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-ctl'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-ctl'
>> Making all in liblttng-ust-fork
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-fork'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-fork'
>> Making all in liblttng-ust-libc-wrapper
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-libc-wrapper'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-libc-wrapper'
>> Making all in liblttng-ust-cyg-profile
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-cyg-profile'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-cyg-profile'
>> Making all in tools
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tools'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tools'
>> Making all in tests
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests'
>> Making all in utils
>> make[6]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests/utils'
>> make[6]: Nothing to be done for `all'.
>> make[6]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests/utils'
>> Making all in hello
>> make[6]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests/hello'
>> /bin/bash ../../libtool  --tag=3DCC   --mode=3Dlink
>> mips-openwrt-linux-uclibc-gcc -Werror=3Dold-style-definition -Wall -Os -=
pipe
>> -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3 -fhonour-copts -msof=
t-float
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tar=
get-mips_uClibc-0.9.30.1/usr/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tar=
get-mips_uClibc-0.9.30.1/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/too=
lchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/too=
lchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib
>> -o hello hello-hello.o hello-tp.o ../../liblttng-ust/liblttng-ust.la -ldl
>> -lurcu-bp -lurcu-bp -lurcu-cds -lpthread
>> libtool: link: mips-openwrt-linux-uclibc-gcc -Werror=3Dold-style-definit=
ion
>> -Wall -Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3
>> -fhonour-copts -msoft-float -o .libs/hello hello-hello.o hello-tp.o
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tar=
get-mips_uClibc-0.9.30.1/usr/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tar=
get-mips_uClibc-0.9.30.1/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/too=
lchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/too=
lchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib
>> ../../liblttng-ust/.libs/liblttng-ust.so
>> /home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust/.libs/liblttng-ust-tracep=
oint.so
>> -lrt -ldl -lurcu-bp -lurcu-cds -lpthread
>> ../../liblttng-ust/.libs/liblttng-ust.so: warning: the use of `mktemp' is
>> dangerous, better use `mkstemp'
>> /home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/toolc=
hain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib/gcc/mips-openwrt-linux-uclibc/4.4.2=
/../../../../mips-openwrt-linux-uclibc/bin/ld:
>> warning: liburcu-common.so.2, needed by
>> /home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/targe=
t-mips_uClibc-0.9.30.1/usr/lib/liburcu-bp.so,
>> not found (try using -rpath or -rpath-link)
>> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to `shm_op=
en'
>> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
>> `shm_unlink'
>> collect2: ld returned 1 exit status
>> make[6]: *** [hello] Error 1
>> make[6]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests/hello'
>> make[5]: *** [all-recursive] Error 1
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests'
>> make[4]: *** [all-recursive] Error 1
>> make[4]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> make[3]: *** [all] Error 2
>> make[3]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> make[2]: ***
>> [/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target=
-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/.built]
>> Error 2
>> make[2]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/feeds/tools/deve=
l/lttng-ust'
>> make[1]: *** [package/feeds/tools/lttng-ust/compile] Error 2
>> make[1]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt'
>> make: *** [package/lttng-ust/compile] Erreur 2
>>
>> I am not very confortable with autotools but I am not able to understand
>> this error. Is it relared to the missing liburcu-common.so.2 library ? s=
hm
>> functions are define by uclibc ? missing include ?
>>
>> Thanks,
>> Arthur.
>>
>>
>> #
>> " Ce courriel et les documents qui lui sont joints peuvent contenir des
>> informations confidentielles ou ayant un caract=C3=A8 priv=C3=A9S'ils ne=
 vous sont
>> pas destin=C3=A9 nous vous signalons qu'il est strictement interdit de l=
es
>> divulguer, de les reproduire ou d'en utiliser de quelque mani=C3=A8 que =
ce
>> soit le contenu. Si ce message vous a =C3=A9 transmis par erreur, merci =
d'en
>> informer l'exp=C3=A9teur et de supprimer imm=C3=A9atement de votre syst=
=C3=A8
>> informatique ce courriel ainsi que tous les documents qui y sont attach=
=C3=A9"
>>
>>
>>                                ******
>>
>> " This e-mail and any attached documents may contain confidential or
>> proprietary information. If you are not the intended recipient, you are
>> notified that any dissemination, copying of this e-mail and any attachme=
nts
>> thereto or use of their contents by any means whatsoever is strictly
>> prohibited. If you have received this e-mail in error, please advise the
>> sender immediately and delete this e-mail and all attached documents
>> from your computer system."
>> #
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


#
" Ce courriel et les documents qui lui sont joints peuvent contenir des
informations confidentielles ou ayant un caract=C3=A8 priv=C3=A9S'ils ne vo=
us sont
pas destin=C3=A9 nous vous signalons qu'il est strictement interdit de les
divulguer, de les reproduire ou d'en utiliser de quelque mani=C3=A8 que ce
soit le contenu. Si ce message vous a =C3=A9 transmis par erreur, merci d'en
informer l'exp=C3=A9teur et de supprimer imm=C3=A9atement de votre syst=C3=
=A8
informatique ce courriel ainsi que tous les documents qui y sont attach=C3=
=A9"


                               ******

" This e-mail and any attached documents may contain confidential or
proprietary information. If you are not the intended recipient, you are
notified that any dissemination, copying of this e-mail and any attachments
thereto or use of their contents by any means whatsoever is strictly
prohibited. If you have received this e-mail in error, please advise the
sender immediately and delete this e-mail and all attached documents
from your computer system."
#
