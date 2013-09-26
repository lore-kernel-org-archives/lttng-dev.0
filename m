From: Arthur LAMBERT <arthur.lambert@sagemcom.com>
Subject: Re: Compilation error with openwrt and uclibc 0.9.31
Date: Thu, 26 Sep 2013 12:38:21 +0200
Message-ID: <52440E9D.9080803__49195.2841439799$1380192234$gmane$org@sagemcom.com>
References: <5242C3C4.3060207@sagemcom.com>
	<CA+jJMxuPudXDiatZfWVwUvvHJ9_WJ4gg_4vUeFapKZet4G-UFw@mail.gmail.com>
Reply-To: arthur.lambert@sagemcom.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1218163130=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sgc-chev-fe1.sgc.gmessaging.net ([194.51.18.91])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <arthur.lambert-ext@sagemcom.com>) id 1VP926-0003We-RI
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 06:42:58 -0400
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


--===============1218163130==
Content-Type: multipart/alternative;
	boundary="------------040501030506080604070703"


--------------040501030506080604070703
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi

After some research about compilation error with uclibc relative to=20
shm_open, I finally found a patch for my toolchain :=20
http://lists.uclibc.org/pipermail/uclibc/2009-February/041886.html
This patch add missing file for uclibc 0.9.30.1...

This patch fix shm_open issue with 2.1.0 and 2.3.0 version of LTT.

Now just need to test if my work around in getcpu.h allow the tool to=20
work correctly. So like often, just need to use the good key word in=20
google to find a way out hehe.

Arthur.

On 25/09/2013 18:17, J=E9r=E9mie Galarneau wrote:
> On Wed, Sep 25, 2013 at 7:06 AM, Arthur LAMBERT
> <arthur.lambert@sagemcom.com> wrote:
>> Hi,
>>
>> I am using backfire version of Openwrt and would like to try to use
>> profiling features bring by tools like lttng. I found some Makefile pa=
ckages
>> on openwrt website to build lttng-tools and lttng-ust with recent vers=
ion of
>> openwrt version but I am not able to compile lttng without error. with
>> mine..
>>
>> Environment :
>>
>> Openwrt Backfire
>> UCLIBC 0.9.31
>> Linux kernel 2.6.28
> Please note that kernel tracing is only available on kernels >=3D 2.6.3=
8
> (or 2.6.32 if patched appropriately).
> I'm not an openwrt user, but it seems Makefiles are only provided for
> LTTng 2.1.0. Can you confirm whether or not the build succeeds for
> that version?
>
>> ARCH mips32
>> lttng version : 2.3.0
>> librcu version : 0.8
>>
>> First problem was related to lttng-ust-2.3.0/libringbuffer/getcpu.h. I=
 get
>> an undefined reference to c variable in lttng_ust_get_cpu function. Af=
ter
>> some research I was not able to find a solution about this point even =
if I
>> seem to be up to date since I found some patch related to issue with o=
ld
>> version of uclibc than 0.9.32. This patch seems to be already integrat=
ed in
>> my lttng ust version. Anyway, I found a workaround to check that the n=
ext
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
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/feeds/tools/li=
bs/liburcu'
>> make[2]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/feeds/tools/li=
bs/liburcu'
>> make[2]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/package/e2fspr=
ogs'
>> WARNING: skipping e2fsprogs -- package not selected
>> WARNING: skipping uuidgen -- package not selected
>> WARNING: skipping libext2fs -- package not selected
>> WARNING: skipping tune2fs -- package not selected
>> WARNING: skipping resize2fs -- package not selected
>> WARNING: skipping badblocks -- package not selected
>> WARNING: skipping blkid -- package not selected
>> make[2]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/package/e2fspr=
ogs'
>> make[2]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/feeds/tools/de=
vel/lttng-ust'
>> CFLAGS=3D"-Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g=
3
>> -fhonour-copts -msoft-float
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
arget-mips_uClibc-0.9.30.1/usr/include
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
arget-mips_uClibc-0.9.30.1/include
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
oolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/include
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
oolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/include
>> " CXXFLAGS=3D"-Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasin=
g -g3
>> -fhonour-copts -msoft-float
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
arget-mips_uClibc-0.9.30.1/usr/include
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
arget-mips_uClibc-0.9.30.1/include
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
oolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/include
>> -I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
oolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/include
>> "
>> LDFLAGS=3D"-L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/st=
aging_dir/target-mips_uClibc-0.9.30.1/usr/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
arget-mips_uClibc-0.9.30.1/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
oolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
oolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib
>> " make  -j2 -C
>> /home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targe=
t-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/.
>> AR=3Dmips-openwrt-linux-uclibc-ar AS=3D"mips-openwrt-linux-uclibc-gcc =
-c -Os
>> -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3 -fhonour-cop=
ts
>> -msoft-float" LD=3Dmips-openwrt-linux-uclibc-ld
>> NM=3Dmips-openwrt-linux-uclibc-nm CC=3D"mips-openwrt-linux-uclibc-gcc"
>> GCC=3D"mips-openwrt-linux-uclibc-gcc" CXX=3D"mips-openwrt-linux-uclibc=
-g++"
>> RANLIB=3Dmips-openwrt-linux-uclibc-ranlib
>> STRIP=3Dmips-openwrt-linux-uclibc-strip
>> OBJCOPY=3Dmips-openwrt-linux-uclibc-objcopy
>> OBJDUMP=3Dmips-openwrt-linux-uclibc-objdump
>> SIZE=3Dmips-openwrt-linux-uclibc-size CROSS=3D"mips-openwrt-linux-ucli=
bc-"
>> ARCH=3D"mips" ;
>> make[3]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> make  all-recursive
>> make[4]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> Making all in .
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> make[5]: Nothing to be done for `all-am'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> Making all in include
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/include'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/include'
>> Making all in snprintf
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/snprintf'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/snprintf'
>> Making all in libringbuffer
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/libringbuffer'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/libringbuffer'
>> Making all in liblttng-ust-comm
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-comm'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-comm'
>> Making all in liblttng-ust
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust'
>> Making all in liblttng-ust-ctl
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-ctl'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-ctl'
>> Making all in liblttng-ust-fork
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-fork'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-fork'
>> Making all in liblttng-ust-libc-wrapper
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-libc-wrapper'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-libc-wrapper'
>> Making all in liblttng-ust-cyg-profile
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-cyg-profile'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-cyg-profile'
>> Making all in tools
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tools'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tools'
>> Making all in tests
>> make[5]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests'
>> Making all in utils
>> make[6]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests/utils'
>> make[6]: Nothing to be done for `all'.
>> make[6]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests/utils'
>> Making all in hello
>> make[6]: Entering directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests/hello'
>> /bin/bash ../../libtool  --tag=3DCC   --mode=3Dlink
>> mips-openwrt-linux-uclibc-gcc -Werror=3Dold-style-definition -Wall -Os=
 -pipe
>> -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3 -fhonour-copts -ms=
oft-float
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
arget-mips_uClibc-0.9.30.1/usr/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
arget-mips_uClibc-0.9.30.1/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
oolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
oolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib
>> -o hello hello-hello.o hello-tp.o ../../liblttng-ust/liblttng-ust.la -=
ldl
>> -lurcu-bp -lurcu-bp -lurcu-cds -lpthread
>> libtool: link: mips-openwrt-linux-uclibc-gcc -Werror=3Dold-style-defin=
ition
>> -Wall -Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3
>> -fhonour-copts -msoft-float -o .libs/hello hello-hello.o hello-tp.o
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
arget-mips_uClibc-0.9.30.1/usr/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
arget-mips_uClibc-0.9.30.1/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
oolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/lib
>> -L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/t=
oolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib
>> ../../liblttng-ust/.libs/liblttng-ust.so
>> /home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targe=
t-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust/.libs/liblttng-ust-tr=
acepoint.so
>> -lrt -ldl -lurcu-bp -lurcu-cds -lpthread
>> ../../liblttng-ust/.libs/liblttng-ust.so: warning: the use of `mktemp'=
 is
>> dangerous, better use `mkstemp'
>> /home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/too=
lchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib/gcc/mips-openwrt-linux-uclibc/4=
.4.2/../../../../mips-openwrt-linux-uclibc/bin/ld:
>> warning: liburcu-common.so.2, needed by
>> /home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tar=
get-mips_uClibc-0.9.30.1/usr/lib/liburcu-bp.so,
>> not found (try using -rpath or -rpath-link)
>> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to `shm_=
open'
>> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
>> `shm_unlink'
>> collect2: ld returned 1 exit status
>> make[6]: *** [hello] Error 1
>> make[6]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests/hello'
>> make[5]: *** [all-recursive] Error 1
>> make[5]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests'
>> make[4]: *** [all-recursive] Error 1
>> make[4]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> make[3]: *** [all] Error 2
>> make[3]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> make[2]: ***
>> [/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/targ=
et-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/.built]
>> Error 2
>> make[2]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/feeds/tools/de=
vel/lttng-ust'
>> make[1]: *** [package/feeds/tools/lttng-ust/compile] Error 2
>> make[1]: Leaving directory
>> `/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt'
>> make: *** [package/lttng-ust/compile] Erreur 2
>>
>> I am not very confortable with autotools but I am not able to understa=
nd
>> this error. Is it relared to the missing liburcu-common.so.2 library ?=
 shm
>> functions are define by uclibc ? missing include ?
>>
>> Thanks,
>> Arthur.
>>
>>
>> #
>> " Ce courriel et les documents qui lui sont joints peuvent contenir de=
s
>> informations confidentielles ou ayant un caract=C3=A8 priv=C3=A9S'ils =
ne vous sont
>> pas destin=C3=A9 nous vous signalons qu'il est strictement interdit de=
 les
>> divulguer, de les reproduire ou d'en utiliser de quelque mani=C3=A8 qu=
e ce
>> soit le contenu. Si ce message vous a =C3=A9 transmis par erreur, merc=
i d'en
>> informer l'exp=C3=A9teur et de supprimer imm=C3=A9atement de votre sys=
t=C3=A8
>> informatique ce courriel ainsi que tous les documents qui y sont attac=
h=C3=A9"
>>
>>
>>                                ******
>>
>> " This e-mail and any attached documents may contain confidential or
>> proprietary information. If you are not the intended recipient, you ar=
e
>> notified that any dissemination, copying of this e-mail and any attach=
ments
>> thereto or use of their contents by any means whatsoever is strictly
>> prohibited. If you have received this e-mail in error, please advise t=
he
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
informations confidentielles ou ayant un caract=C3=A8 priv=C3=A9S'ils ne =
vous sont
pas destin=C3=A9 nous vous signalons qu'il est strictement interdit de le=
s
divulguer, de les reproduire ou d'en utiliser de quelque mani=C3=A8 que c=
e
soit le contenu. Si ce message vous a =C3=A9 transmis par erreur, merci d=
'en
informer l'exp=C3=A9teur et de supprimer imm=C3=A9atement de votre syst=C3=
=A8
informatique ce courriel ainsi que tous les documents qui y sont attach=C3=
=A9"


                               ******

" This e-mail and any attached documents may contain confidential or
proprietary information. If you are not the intended recipient, you are
notified that any dissemination, copying of this e-mail and any attachmen=
ts
thereto or use of their contents by any means whatsoever is strictly
prohibited. If you have received this e-mail in error, please advise the
sender immediately and delete this e-mail and all attached documents
from your computer system."
#


--------------040501030506080604070703
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-1"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">Hi<br>
      <br>
      After some research about compilation error with uclibc relative
      to shm_open, I finally found a patch for my toolchain :
      <meta http-equiv=3D"content-type" content=3D"text/html;
        charset=3DISO-8859-1">
      <a
href=3D"http://lists.uclibc.org/pipermail/uclibc/2009-February/041886.htm=
l">http://lists.uclibc.org/pipermail/uclibc/2009-February/041886.html</a>=
<br>
      This patch add missing file for uclibc 0.9.30.1...<br>
      <br>
      This patch fix shm_open issue with 2.1.0 and 2.3.0 version of LTT.<=
br>
      <br>
      Now just need to test if my work around in getcpu.h allow the tool
      to work correctly. So like often, just need to use the good key
      word in google to find a way out hehe.<br>
      <br>
      Arthur.<br>
      <br>
      On 25/09/2013 18:17, J&eacute;r&eacute;mie Galarneau wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CA+jJMxuPudXDiatZfWVwUvvHJ9_WJ4gg_4vUeFapKZet4G-UFw@mail.gmai=
l.com"
      type=3D"cite">
      <pre wrap=3D"">On Wed, Sep 25, 2013 at 7:06 AM, Arthur LAMBERT
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:arthur.lambert@sagemcom=
.com">&lt;arthur.lambert@sagemcom.com&gt;</a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">Hi,

I am using backfire version of Openwrt and would like to try to use
profiling features bring by tools like lttng. I found some Makefile packa=
ges
on openwrt website to build lttng-tools and lttng-ust with recent version=
 of
openwrt version but I am not able to compile lttng without error. with
mine..

Environment :

Openwrt Backfire
UCLIBC 0.9.31
Linux kernel 2.6.28
</pre>
      </blockquote>
      <pre wrap=3D"">
Please note that kernel tracing is only available on kernels &gt;=3D 2.6.=
38
(or 2.6.32 if patched appropriately).
I'm not an openwrt user, but it seems Makefiles are only provided for
LTTng 2.1.0. Can you confirm whether or not the build succeeds for
that version?

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">ARCH mips32
lttng version : 2.3.0
librcu version : 0.8

First problem was related to lttng-ust-2.3.0/libringbuffer/getcpu.h. I ge=
t
an undefined reference to c variable in lttng_ust_get_cpu function. After
some research I was not able to find a solution about this point even if =
I
seem to be up to date since I found some patch related to issue with old
version of uclibc than 0.9.32. This patch seems to be already integrated =
in
my lttng ust version. Anyway, I found a workaround to check that the next
step on the compilation is find... but it is not...

</pre>
      </blockquote>
      <pre wrap=3D"">
Could you clarify what was the error and what is the workaround?

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">Compilation result :

make package/lttng-tools/compile V=3D99

make[1]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt'
make[2]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/feeds/tools/libs/=
liburcu'
make[2]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/feeds/tools/libs/=
liburcu'
make[2]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/package/e2fsprogs=
'
WARNING: skipping e2fsprogs -- package not selected
WARNING: skipping uuidgen -- package not selected
WARNING: skipping libext2fs -- package not selected
WARNING: skipping tune2fs -- package not selected
WARNING: skipping resize2fs -- package not selected
WARNING: skipping badblocks -- package not selected
WARNING: skipping blkid -- package not selected
make[2]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/package/e2fsprogs=
'
make[2]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/feeds/tools/devel=
/lttng-ust'
CFLAGS=3D"-Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3
-fhonour-copts -msoft-float
-I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/targ=
et-mips_uClibc-0.9.30.1/usr/include
-I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/targ=
et-mips_uClibc-0.9.30.1/include
-I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tool=
chain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/include
-I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tool=
chain-mips_gcc-4.4.2_uClibc-0.9.30.1/include
" CXXFLAGS=3D"-Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -=
g3
-fhonour-copts -msoft-float
-I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/targ=
et-mips_uClibc-0.9.30.1/usr/include
-I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/targ=
et-mips_uClibc-0.9.30.1/include
-I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tool=
chain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/include
-I/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tool=
chain-mips_gcc-4.4.2_uClibc-0.9.30.1/include
"
LDFLAGS=3D"-L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/stagi=
ng_dir/target-mips_uClibc-0.9.30.1/usr/lib
-L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/targ=
et-mips_uClibc-0.9.30.1/lib
-L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tool=
chain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/lib
-L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tool=
chain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib
" make  -j2 -C
/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-m=
ips_uClibc-0.9.30.1/lttng-ust-2.3.0/.
AR=3Dmips-openwrt-linux-uclibc-ar AS=3D"mips-openwrt-linux-uclibc-gcc -c =
-Os
-pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3 -fhonour-copts
-msoft-float" LD=3Dmips-openwrt-linux-uclibc-ld
NM=3Dmips-openwrt-linux-uclibc-nm CC=3D"mips-openwrt-linux-uclibc-gcc"
GCC=3D"mips-openwrt-linux-uclibc-gcc" CXX=3D"mips-openwrt-linux-uclibc-g+=
+"
RANLIB=3Dmips-openwrt-linux-uclibc-ranlib
STRIP=3Dmips-openwrt-linux-uclibc-strip
OBJCOPY=3Dmips-openwrt-linux-uclibc-objcopy
OBJDUMP=3Dmips-openwrt-linux-uclibc-objdump
SIZE=3Dmips-openwrt-linux-uclibc-size CROSS=3D"mips-openwrt-linux-uclibc-=
"
ARCH=3D"mips" ;
make[3]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
make  all-recursive
make[4]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
Making all in .
make[5]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
make[5]: Nothing to be done for `all-am'.
make[5]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
Making all in include
make[5]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/include'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/include'
Making all in snprintf
make[5]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/snprintf'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/snprintf'
Making all in libringbuffer
make[5]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/libringbuffer'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/libringbuffer'
Making all in liblttng-ust-comm
make[5]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-comm'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-comm'
Making all in liblttng-ust
make[5]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust'
Making all in liblttng-ust-ctl
make[5]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-ctl'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-ctl'
Making all in liblttng-ust-fork
make[5]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-fork'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-fork'
Making all in liblttng-ust-libc-wrapper
make[5]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-libc-wrapper'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-libc-wrapper'
Making all in liblttng-ust-cyg-profile
make[5]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-cyg-profile'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust-cyg-profile'
Making all in tools
make[5]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tools'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tools'
Making all in tests
make[5]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests'
Making all in utils
make[6]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests/utils'
make[6]: Nothing to be done for `all'.
make[6]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests/utils'
Making all in hello
make[6]: Entering directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests/hello'
/bin/bash ../../libtool  --tag=3DCC   --mode=3Dlink
mips-openwrt-linux-uclibc-gcc -Werror=3Dold-style-definition -Wall -Os -p=
ipe
-mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3 -fhonour-copts -msoft=
-float
-L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/targ=
et-mips_uClibc-0.9.30.1/usr/lib
-L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/targ=
et-mips_uClibc-0.9.30.1/lib
-L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tool=
chain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/lib
-L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tool=
chain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib
-o hello hello-hello.o hello-tp.o ../../liblttng-ust/liblttng-ust.la -ldl
-lurcu-bp -lurcu-bp -lurcu-cds -lpthread
libtool: link: mips-openwrt-linux-uclibc-gcc -Werror=3Dold-style-definiti=
on
-Wall -Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3
-fhonour-copts -msoft-float -o .libs/hello hello-hello.o hello-tp.o
-L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/targ=
et-mips_uClibc-0.9.30.1/usr/lib
-L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/targ=
et-mips_uClibc-0.9.30.1/lib
-L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tool=
chain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr/lib
-L/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/tool=
chain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib
../../liblttng-ust/.libs/liblttng-ust.so
/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-m=
ips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust/.libs/liblttng-ust-trace=
point.so
-lrt -ldl -lurcu-bp -lurcu-cds -lpthread
../../liblttng-ust/.libs/liblttng-ust.so: warning: the use of `mktemp' is
dangerous, better use `mkstemp'
/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/toolch=
ain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib/gcc/mips-openwrt-linux-uclibc/4.4.=
2/../../../../mips-openwrt-linux-uclibc/bin/ld:
warning: liburcu-common.so.2, needed by
/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/staging_dir/target=
-mips_uClibc-0.9.30.1/usr/lib/liburcu-bp.so,
not found (try using -rpath or -rpath-link)
../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to `shm_ope=
n'
../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
`shm_unlink'
collect2: ld returned 1 exit status
make[6]: *** [hello] Error 1
make[6]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests/hello'
make[5]: *** [all-recursive] Error 1
make[5]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tests'
make[4]: *** [all-recursive] Error 1
make[4]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
make[3]: *** [all] Error 2
make[3]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
make[2]: ***
[/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/build_dir/target-=
mips_uClibc-0.9.30.1/lttng-ust-2.3.0/.built]
Error 2
make[2]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt/feeds/tools/devel=
/lttng-ust'
make[1]: *** [package/feeds/tools/lttng-ust/compile] Error 2
make[1]: Leaving directory
`/home/g179168/middleware/dev/TELEFONICA_3_32_X/openwrt'
make: *** [package/lttng-ust/compile] Erreur 2

I am not very confortable with autotools but I am not able to understand
this error. Is it relared to the missing liburcu-common.so.2 library ? sh=
m
functions are define by uclibc ? missing include ?

Thanks,
Arthur.


#
" Ce courriel et les documents qui lui sont joints peuvent contenir des
informations confidentielles ou ayant un caract&Atilde;&uml; priv&Atilde;=
&copy;S'ils ne vous sont
pas destin&Atilde;&copy; nous vous signalons qu'il est strictement interd=
it de les
divulguer, de les reproduire ou d'en utiliser de quelque mani&Atilde;&uml=
; que ce
soit le contenu. Si ce message vous a &Atilde;&copy; transmis par erreur,=
 merci d'en
informer l'exp&Atilde;&copy;teur et de supprimer imm&Atilde;&copy;atement=
 de votre syst&Atilde;&uml;
informatique ce courriel ainsi que tous les documents qui y sont attach&A=
tilde;&copy;"


                              ******

" This e-mail and any attached documents may contain confidential or
proprietary information. If you are not the intended recipient, you are
notified that any dissemination, copying of this e-mail and any attachmen=
ts
thereto or use of their contents by any means whatsoever is strictly
prohibited. If you have received this e-mail in error, please advise the
sender immediately and delete this e-mail and all attached documents
from your computer system."
#


_______________________________________________
lttng-dev mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev@lists.lttn=
g.org">lttng-dev@lists.lttng.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"http://lists.lttng.org/cgi-bin=
/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev</a>
</pre>
      </blockquote>
      <pre wrap=3D"">


</pre>
    </blockquote>
    <br>
  <PRE>#
" Ce courriel et les documents qui lui sont joints peuvent contenir des
informations confidentielles ou ayant un caract=C3=A8 priv=C3=A9S'ils ne =
vous sont
pas destin=C3=A9 nous vous signalons qu'il est strictement interdit de le=
s
divulguer, de les reproduire ou d'en utiliser de quelque mani=C3=A8 que c=
e
soit le contenu. Si ce message vous a =C3=A9 transmis par erreur, merci d=
'en
informer l'exp=C3=A9teur et de supprimer imm=C3=A9atement de votre syst=C3=
=A8
informatique ce courriel ainsi que tous les documents qui y sont attach=C3=
=A9"


                               ******

" This e-mail and any attached documents may contain confidential or
proprietary information. If you are not the intended recipient, you are
notified that any dissemination, copying of this e-mail and any attachmen=
ts
thereto or use of their contents by any means whatsoever is strictly
prohibited. If you have received this e-mail in error, please advise the
sender immediately and delete this e-mail and all attached documents
from your computer system."
#
</PRE></body>
</html>

--------------040501030506080604070703--


--===============1218163130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1218163130==--
