From: Arthur LAMBERT <arthur.lambert@sagemcom.com>
Subject: Re: Compilation error with openwrt and uclibc 0.9.31
Date: Fri, 27 Sep 2013 11:22:53 +0200
Message-ID: <52454E6D.5080009__4076.7517908991$1380274111$gmane$org@sagemcom.com>
References: <5242C3C4.3060207@sagemcom.com>
	<CA+jJMxuPudXDiatZfWVwUvvHJ9_WJ4gg_4vUeFapKZet4G-UFw@mail.gmail.com>
	<5244599E.4050100@sagemcom.com>
	<CAGDH53ni8UgfT==5KifqCo7Qa3bJdRZSJ88Z20-BiSkdmseqGg@mail.gmail.com>
Reply-To: arthur.lambert@sagemcom.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1131913826=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sgc-chev-fe1.sgc.gmessaging.net ([194.51.18.91])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <arthur.lambert-ext@sagemcom.com>) id 1VPUKl-0001nW-PH
	for lttng-dev@lists.lttng.org; Fri, 27 Sep 2013 05:27:40 -0400
In-Reply-To: <CAGDH53ni8UgfT==5KifqCo7Qa3bJdRZSJ88Z20-BiSkdmseqGg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1131913826==
Content-Type: multipart/alternative;
	boundary="------------060700090508010203080301"


--------------060700090508010203080301
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Christian,

You right, I guess that I need to add something. I was checking my=20
Makefile using by openwrt to build lttng-ust and lttng-tools, the only=20
process concerning flag are :  :

lttng-tools :
TARGET_LDFLAGS +=3D -lurcu-bp
DEPENDS:=3D+lttng-ust +libpopt

lttng-ust
DEPENDS:=3D+liburcu +libuuid +librt

Nothing else..

Missing shared libraries file are :
- liburcu-common.so.1
- liblttng-ust-tracepoint.so.0
- libuuid.so.1
- liburcu-cds.so.1

I was checking my build-dir directory, all shared libraries seems to be=20
there :
[XXX ] find build_dir/ -name  liblttng-ust-tracepoint.so.0
build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust/.libs/=
liblttng-ust-tracepoint.so.0
build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/ipkg-install/usr/li=
b/liblttng-ust-tracepoint.so.0
build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/ipkg-sagemcom/lttng=
-ust/usr/lib/liblttng-ust-tracepoint.so.0
build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.1.0/liblttng-ust/.libs/=
liblttng-ust-tracepoint.so.0
build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.1.0/ipkg-install/usr/li=
b/liblttng-ust-tracepoint.so.0
build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.1.0/ipkg-sagemcom/lttng=
-ust/usr/lib/liblttng-ust-tracepoint.so.0
[XXX ] find build_dir/ -name  libuuid.so.1
build_dir/target-mips_uClibc-0.9.30.1/e2fsprogs-1.41.12/ipkg-install/usr/=
lib/libuuid.so.1
build_dir/target-mips_uClibc-0.9.30.1/e2fsprogs-1.41.12/ipkg-sagemcom/lib=
uuid/usr/lib/libuuid.so.1
build_dir/target-mips_uClibc-0.9.30.1/e2fsprogs-1.41.12/lib/libuuid.so.1
[XXX ] find build_dir/ -name  liburcu-cds.so.1
build_dir/target-mips_uClibc-0.9.30.1/userspace-rcu-0.7.6/ipkg-install/us=
r/lib/liburcu-cds.so.1
build_dir/target-mips_uClibc-0.9.30.1/userspace-rcu-0.7.6/ipkg-sagemcom/l=
iburcu/usr/lib/liburcu-cds.so.1
build_dir/target-mips_uClibc-0.9.30.1/userspace-rcu-0.7.6/.libs/liburcu-c=
ds.so.1
[XXX ] find build_dir/ -name  liburcu-common.so.1
build_dir/target-mips_uClibc-0.9.30.1/userspace-rcu-0.7.6/ipkg-install/us=
r/lib/liburcu-common.so.1
build_dir/target-mips_uClibc-0.9.30.1/userspace-rcu-0.7.6/ipkg-sagemcom/l=
iburcu/usr/lib/liburcu-common.so.1
build_dir/target-mips_uClibc-0.9.30.1/userspace-rcu-0.7.6/.libs/liburcu-c=
ommon.so.1

I guess that it is not an issue related to lttng build but related to my=20
knowledge about autotools usage in openwrt..

Last thing that I forgot, I get also an issue about useconds_t in=20
gen-ust-event source file. No patch found to fix this issue. Currently,=20
I just replace this type by an unsigned int to continue my building=20
adventure.

Arthur.

On 26/09/2013 18:34, Christian Babeux wrote:
> Hi Arthur,
>
>> Problem is that I seems to have already this fix in my lttng-ust versi=
on. I
>> am not very confortable with autotools. Do I have to add a
>> "libtool-linkdep-fixup" flag somewhere to be able to enable the fix du=
ring
>> my compile process ?
> No need to add any flag, if configure detect a bogus link_all_deplibs
> value in your libtool.m4 it will automatically patch it. Relevant
> configure output:
>
> [...]
> checking for occurence(s) of link_all_deplibs =3D no in ./config/libtoo=
l.m4... 3
> the detected libtool will not link all dependencies, forcing
> link_all_deplibs =3D unknown
> [...]
>
> Your issue is that ld cannot find shared objects such as libuuid,
> liburcu*. Which flag did you use to cross-compile?
>
> Thanks,
>
> Christian
>
> On Thu, Sep 26, 2013 at 11:58 AM, Arthur LAMBERT
> <arthur.lambert@sagemcom.com> wrote:
>> Hi again,
>>
>> I was able now to build lttng-ust but I have still some problems with
>> lttng-tools...
>>
>> My current story is ( Could be usefull for the next guy which want to =
try to
>> compile the tool with a toolchain from Jurassic time) :
>>
>> * shm_open issue
>>    -> patch for toolchain uClibc-0.9.30.1 :
>> http://lists.uclibc.org/pipermail/uclibc/2009-February/041886.html
>>
>> * epoll_create1 and EPOLLRDHUP issue
>>    -> patch for toolchain uClibc-0.9.30.1 :
>> http://uclibc.10924.n7.nabble.com/PATCH-Implement-epoll-create1-and-ep=
oll-pwait-system-calls-td268.html
>>
>> * be32toh issue
>>    -> patch for toolchain uClibc-0.9.30.1 :
>> http://lists.uclibc.org/pipermail/uclibc/2010-June/044107.html
>>
>> * pthread-condattr issue
>>     -> patch for toolchain uClibc-0.9.30.1 :
>> http://www.mail-archive.com/uclibc@uclibc.org/msg01909.html
>>
>> My last issue :
>>
>> /openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib/gcc/=
mips-openwrt-linux-uclibc/4.4.2/../../../../mips-openwrt-linux-uclibc/bin=
/ld:
>> warning: liburcu-common.so.1, needed by
>> /openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liburcu-bp.so=
, not
>> found (try using -rpath or -rpath-link)
>> /openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib/gcc/=
mips-openwrt-linux-uclibc/4.4.2/../../../../mips-openwrt-linux-uclibc/bin=
/ld:
>> warning: liblttng-ust-tracepoint.so.0, needed by
>> /openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-ust.=
so,
>> not found (try using -rpath or -rpath-link)
>> /openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib/gcc/=
mips-openwrt-linux-uclibc/4.4.2/../../../../mips-openwrt-linux-uclibc/bin=
/ld:
>> warning: libuuid.so.1, needed by
>> /openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-ust.=
so,
>> not found (try using -rpath or -rpath-link)
>> /openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib/gcc/=
mips-openwrt-linux-uclibc/4.4.2/../../../../mips-openwrt-linux-uclibc/bin=
/ld:
>> warning: liburcu-cds.so.1, needed by
>> /openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-ust.=
so,
>> not found (try using -rpath or -rpath-link)
>> XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttn=
g-ust.so:
>> undefined reference to `__tracepoint_probe_unregister'
>> XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttn=
g-ust.so:
>> undefined reference to `_cds_lfht_new'
>> XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttn=
g-ust.so:
>> undefined reference to `cds_lfht_lookup'
>> XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttn=
g-ust.so:
>> undefined reference to `init_tracepoint'
>> XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttn=
g-ust.so:
>> undefined reference to `cds_lfht_del'
>> XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttn=
g-ust.so:
>> undefined reference to `uuid_generate'
>> XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttn=
g-ust.so:
>> undefined reference to `exit_tracepoint'
>> XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttn=
g-ust.so:
>> undefined reference to `cds_lfht_destroy'
>> XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttn=
g-ust.so:
>> undefined reference to `cds_lfht_first'
>> XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttn=
g-ust.so:
>> undefined reference to `cds_lfht_add_unique'
>> XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttn=
g-ust.so:
>> undefined reference to `cds_lfht_next'
>> XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttn=
g-ust.so:
>> undefined reference to `__tracepoint_probe_register'
>>
>> I found a bug here which seems related to my issue :
>> https://bugs.lttng.org/issues/321
>> This bug talk about a fix in configure.ac :
>> https://bugs.lttng.org/projects/lttng-ust/repository/revisions/faebb41=
808b9deda5ef5dfea0c035077407e7f9f/diff
>>
>> Problem is that I seems to have already this fix in my lttng-ust versi=
on. I
>> am not very confortable with autotools. Do I have to add a
>> "libtool-linkdep-fixup" flag somewhere to be able to enable the fix du=
ring
>> my compile process ?
>>
>> Thanks,
>>
>> Arthur.
>>
>>
>> On 25/09/2013 18:17, J=C3=A9r=C3=A9mie Galarneau wrote:
>>
>> On Wed, Sep 25, 2013 at 7:06 AM, Arthur LAMBERT
>> <arthur.lambert@sagemcom.com> wrote:
>>
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
>>
>> Please note that kernel tracing is only available on kernels >=3D 2.6.=
38
>> (or 2.6.32 if patched appropriately).
>> I'm not an openwrt user, but it seems Makefiles are only provided for
>> LTTng 2.1.0. Can you confirm whether or not the build succeeds for
>> that version?
>>
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
>> Could you clarify what was the error and what is the workaround?
>>
>> Compilation result :
>>
>> make package/lttng-tools/compile V=3D99
>>
>> make[1]: Entering directory
>> `XXXXXX/openwrt'
>> make[2]: Entering directory
>> `XXXXXX/openwrt/feeds/tools/libs/liburcu'
>> make[2]: Leaving directory
>> `XXXXXX/openwrt/feeds/tools/libs/liburcu'
>> make[2]: Entering directory
>> `XXXXXX/openwrt/package/e2fsprogs'
>> WARNING: skipping e2fsprogs -- package not selected
>> WARNING: skipping uuidgen -- package not selected
>> WARNING: skipping libext2fs -- package not selected
>> WARNING: skipping tune2fs -- package not selected
>> WARNING: skipping resize2fs -- package not selected
>> WARNING: skipping badblocks -- package not selected
>> WARNING: skipping blkid -- package not selected
>> make[2]: Leaving directory
>> `XXXXXX/openwrt/package/e2fsprogs'
>> make[2]: Entering directory
>> `XXXXXX/openwrt/feeds/tools/devel/lttng-ust'
>> CFLAGS=3D"-Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g=
3
>> -fhonour-copts -msoft-float
>> -IXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/include
>> -IXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/include
>> -IXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/=
usr/include
>> -IXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/=
include
>> " CXXFLAGS=3D"-Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasin=
g -g3
>> -fhonour-copts -msoft-float
>> -IXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/include
>> -IXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/include
>> -IXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/=
usr/include
>> -IXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/=
include
>> "
>> LDFLAGS=3D"-LXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/us=
r/lib
>> -LXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/lib
>> -LXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/=
usr/lib
>> -LXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/=
lib
>> " make  -j2 -C
>> XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/.
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
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> make  all-recursive
>> make[4]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> Making all in .
>> make[5]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> make[5]: Nothing to be done for `all-am'.
>> make[5]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> Making all in include
>> make[5]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
include'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
include'
>> Making all in snprintf
>> make[5]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
snprintf'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
snprintf'
>> Making all in libringbuffer
>> make[5]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
libringbuffer'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
libringbuffer'
>> Making all in liblttng-ust-comm
>> make[5]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
liblttng-ust-comm'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
liblttng-ust-comm'
>> Making all in liblttng-ust
>> make[5]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
liblttng-ust'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
liblttng-ust'
>> Making all in liblttng-ust-ctl
>> make[5]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
liblttng-ust-ctl'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
liblttng-ust-ctl'
>> Making all in liblttng-ust-fork
>> make[5]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
liblttng-ust-fork'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
liblttng-ust-fork'
>> Making all in liblttng-ust-libc-wrapper
>> make[5]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
liblttng-ust-libc-wrapper'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
liblttng-ust-libc-wrapper'
>> Making all in liblttng-ust-cyg-profile
>> make[5]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
liblttng-ust-cyg-profile'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
liblttng-ust-cyg-profile'
>> Making all in tools
>> make[5]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
tools'
>> make[5]: Nothing to be done for `all'.
>> make[5]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
tools'
>> Making all in tests
>> make[5]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
tests'
>> Making all in utils
>> make[6]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
tests/utils'
>> make[6]: Nothing to be done for `all'.
>> make[6]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
tests/utils'
>> Making all in hello
>> make[6]: Entering directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
tests/hello'
>> /bin/bash ../../libtool  --tag=3DCC   --mode=3Dlink
>> mips-openwrt-linux-uclibc-gcc -Werror=3Dold-style-definition -Wall -Os=
 -pipe
>> -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3 -fhonour-copts -ms=
oft-float
>> -LXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib
>> -LXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/lib
>> -LXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/=
usr/lib
>> -LXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/=
lib
>> -o hello hello-hello.o hello-tp.o ../../liblttng-ust/liblttng-ust.la -=
ldl
>> -lurcu-bp -lurcu-bp -lurcu-cds -lpthread
>> libtool: link: mips-openwrt-linux-uclibc-gcc -Werror=3Dold-style-defin=
ition
>> -Wall -Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3
>> -fhonour-copts -msoft-float -o .libs/hello hello-hello.o hello-tp.o
>> -LXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib
>> -LXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/lib
>> -LXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/=
usr/lib
>> -LXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/=
lib
>> ../../liblttng-ust/.libs/liblttng-ust.so
>> XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/l=
iblttng-ust/.libs/liblttng-ust-tracepoint.so
>> -lrt -ldl -lurcu-bp -lurcu-cds -lpthread
>> ../../liblttng-ust/.libs/liblttng-ust.so: warning: the use of `mktemp'=
 is
>> dangerous, better use `mkstemp'
>> XXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/li=
b/gcc/mips-openwrt-linux-uclibc/4.4.2/../../../../mips-openwrt-linux-ucli=
bc/bin/ld:
>> warning: liburcu-common.so.2, needed by
>> XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liburcu=
-bp.so,
>> not found (try using -rpath or -rpath-link)
>> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to `shm_=
open'
>> ../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
>> `shm_unlink'
>> collect2: ld returned 1 exit status
>> make[6]: *** [hello] Error 1
>> make[6]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
tests/hello'
>> make[5]: *** [all-recursive] Error 1
>> make[5]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
tests'
>> make[4]: *** [all-recursive] Error 1
>> make[4]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> make[3]: *** [all] Error 2
>> make[3]: Leaving directory
>> `XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
>> make[2]: ***
>> [XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/=
.built]
>> Error 2
>> make[2]: Leaving directory
>> `XXXXXX/openwrt/feeds/tools/devel/lttng-ust'
>> make[1]: *** [package/feeds/tools/lttng-ust/compile] Error 2
>> make[1]: Leaving directory
>> `XXXXXX/openwrt'
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
>> informations confidentielles ou ayant un caract=C3=83=C2=A8 priv=C3=83=
=C2=A9S'ils ne vous sont
>> pas destin=C3=83=C2=A9 nous vous signalons qu'il est strictement inter=
dit de les
>> divulguer, de les reproduire ou d'en utiliser de quelque mani=C3=83=C2=
=A8 que ce
>> soit le contenu. Si ce message vous a =C3=83=C2=A9 transmis par erreur=
, merci d'en
>> informer l'exp=C3=83=C2=A9teur et de supprimer imm=C3=83=C2=A9atement =
de votre syst=C3=83=C2=A8
>> informatique ce courriel ainsi que tous les documents qui y sont attac=
h=C3=83=C2=A9"
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
>>
>>
>>
>> #
>> " Ce courriel et les documents qui lui sont joints peuvent contenir de=
s
>> informations confidentielles ou ayant un caract=C3=83=C2=A8 priv=C3=83=
=C2=A9S'ils ne vous sont
>> pas destin=C3=83=C2=A9 nous vous signalons qu'il est strictement inter=
dit de les
>> divulguer, de les reproduire ou d'en utiliser de quelque mani=C3=83=C2=
=A8 que ce
>> soit le contenu. Si ce message vous a =C3=83=C2=A9 transmis par erreur=
, merci d'en
>> informer l'exp=C3=83=C2=A9teur et de supprimer imm=C3=83=C2=A9atement =
de votre syst=C3=83=C2=A8
>> informatique ce courriel ainsi que tous les documents qui y sont attac=
h=C3=83=C2=A9"
>>
>>
>>                                 ******
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
>>


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


--------------060700090508010203080301
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">Hi Christian,<br>
      <br>
      You right, I guess that I need to add something. I was checking my
      Makefile using by openwrt to build lttng-ust and lttng-tools, the
      only process concerning flag are :=C2=A0 : <br>
      <br>
      lttng-tools :<br>
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DU=
TF-8">
      TARGET_LDFLAGS +=3D -lurcu-bp<br>
      DEPENDS:=3D+lttng-ust +libpopt<br>
      <br>
      lttng-ust<br>
      DEPENDS:=3D+liburcu +libuuid +librt<br>
      <br>
      Nothing else..<br>
      <br>
      Missing shared libraries file are :<br>
      - liburcu-common.so.1<br>
      - liblttng-ust-tracepoint.so.0<br>
      - libuuid.so.1<br>
      - liburcu-cds.so.1<br>
      <br>
      I was checking my build-dir directory, all shared libraries seems
      to be there :<br>
      [XXX ] find build_dir/ -name=C2=A0 liblttng-ust-tracepoint.so.0<br>
build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/liblttng-ust/.libs/=
liblttng-ust-tracepoint.so.0<br>
build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/ipkg-install/usr/li=
b/liblttng-ust-tracepoint.so.0<br>
build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/ipkg-sagemcom/lttng=
-ust/usr/lib/liblttng-ust-tracepoint.so.0<br>
build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.1.0/liblttng-ust/.libs/=
liblttng-ust-tracepoint.so.0<br>
build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.1.0/ipkg-install/usr/li=
b/liblttng-ust-tracepoint.so.0<br>
build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.1.0/ipkg-sagemcom/lttng=
-ust/usr/lib/liblttng-ust-tracepoint.so.0<br>
      [XXX ] find build_dir/ -name=C2=A0 libuuid.so.1<br>
build_dir/target-mips_uClibc-0.9.30.1/e2fsprogs-1.41.12/ipkg-install/usr/=
lib/libuuid.so.1<br>
build_dir/target-mips_uClibc-0.9.30.1/e2fsprogs-1.41.12/ipkg-sagemcom/lib=
uuid/usr/lib/libuuid.so.1<br>
build_dir/target-mips_uClibc-0.9.30.1/e2fsprogs-1.41.12/lib/libuuid.so.1<=
br>
      [XXX ] find build_dir/ -name=C2=A0 liburcu-cds.so.1<br>
build_dir/target-mips_uClibc-0.9.30.1/userspace-rcu-0.7.6/ipkg-install/us=
r/lib/liburcu-cds.so.1<br>
build_dir/target-mips_uClibc-0.9.30.1/userspace-rcu-0.7.6/ipkg-sagemcom/l=
iburcu/usr/lib/liburcu-cds.so.1<br>
build_dir/target-mips_uClibc-0.9.30.1/userspace-rcu-0.7.6/.libs/liburcu-c=
ds.so.1<br>
      [XXX ] find build_dir/ -name=C2=A0 liburcu-common.so.1<br>
build_dir/target-mips_uClibc-0.9.30.1/userspace-rcu-0.7.6/ipkg-install/us=
r/lib/liburcu-common.so.1<br>
build_dir/target-mips_uClibc-0.9.30.1/userspace-rcu-0.7.6/ipkg-sagemcom/l=
iburcu/usr/lib/liburcu-common.so.1<br>
build_dir/target-mips_uClibc-0.9.30.1/userspace-rcu-0.7.6/.libs/liburcu-c=
ommon.so.1<br>
      <br>
      I guess that it is not an issue related to lttng build but related
      to my knowledge about autotools usage in openwrt.. <br>
      <br>
      Last thing that I forgot, I get also an issue about useconds_t in
      gen-ust-event source file. No patch found to fix this issue.
      Currently, I just replace this type by an unsigned int to continue
      my building adventure.<br>
      <br>
      Arthur.<br>
      <br>
      On 26/09/2013 18:34, Christian Babeux wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CAGDH53ni8UgfT=3D=3D5KifqCo7Qa3bJdRZSJ88Z20-BiSkdmseqGg@mail.=
gmail.com"
      type=3D"cite">
      <pre wrap=3D"">Hi Arthur,

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">Problem is that I seems to have already this fix i=
n my lttng-ust version. I
am not very confortable with autotools. Do I have to add a
"libtool-linkdep-fixup" flag somewhere to be able to enable the fix durin=
g
my compile process ?
</pre>
      </blockquote>
      <pre wrap=3D"">
No need to add any flag, if configure detect a bogus link_all_deplibs
value in your libtool.m4 it will automatically patch it. Relevant
configure output:

[...]
checking for occurence(s) of link_all_deplibs =3D no in ./config/libtool.=
m4... 3
the detected libtool will not link all dependencies, forcing
link_all_deplibs =3D unknown
[...]

Your issue is that ld cannot find shared objects such as libuuid,
liburcu*. Which flag did you use to cross-compile?

Thanks,

Christian

On Thu, Sep 26, 2013 at 11:58 AM, Arthur LAMBERT
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:arthur.lambert@sagemcom=
.com">&lt;arthur.lambert@sagemcom.com&gt;</a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">Hi again,

I was able now to build lttng-ust but I have still some problems with
lttng-tools...

My current story is ( Could be usefull for the next guy which want to try=
 to
compile the tool with a toolchain from Jurassic time) :

* shm_open issue
  -&gt; patch for toolchain uClibc-0.9.30.1 :
<a class=3D"moz-txt-link-freetext" href=3D"http://lists.uclibc.org/piperm=
ail/uclibc/2009-February/041886.html">http://lists.uclibc.org/pipermail/u=
clibc/2009-February/041886.html</a>

* epoll_create1 and EPOLLRDHUP issue
  -&gt; patch for toolchain uClibc-0.9.30.1 :
<a class=3D"moz-txt-link-freetext" href=3D"http://uclibc.10924.n7.nabble.=
com/PATCH-Implement-epoll-create1-and-epoll-pwait-system-calls-td268.html=
">http://uclibc.10924.n7.nabble.com/PATCH-Implement-epoll-create1-and-epo=
ll-pwait-system-calls-td268.html</a>

* be32toh issue
  -&gt; patch for toolchain uClibc-0.9.30.1 :
<a class=3D"moz-txt-link-freetext" href=3D"http://lists.uclibc.org/piperm=
ail/uclibc/2010-June/044107.html">http://lists.uclibc.org/pipermail/uclib=
c/2010-June/044107.html</a>

* pthread-condattr issue
   -&gt; patch for toolchain uClibc-0.9.30.1 :
<a class=3D"moz-txt-link-freetext" href=3D"http://www.mail-archive.com/uc=
libc@uclibc.org/msg01909.html">http://www.mail-archive.com/uclibc@uclibc.=
org/msg01909.html</a>

My last issue :

/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib/gcc/mip=
s-openwrt-linux-uclibc/4.4.2/../../../../mips-openwrt-linux-uclibc/bin/ld=
:
warning: liburcu-common.so.1, needed by
/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liburcu-bp.so, n=
ot
found (try using -rpath or -rpath-link)
/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib/gcc/mip=
s-openwrt-linux-uclibc/4.4.2/../../../../mips-openwrt-linux-uclibc/bin/ld=
:
warning: liblttng-ust-tracepoint.so.0, needed by
/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-ust.so,
not found (try using -rpath or -rpath-link)
/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib/gcc/mip=
s-openwrt-linux-uclibc/4.4.2/../../../../mips-openwrt-linux-uclibc/bin/ld=
:
warning: libuuid.so.1, needed by
/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-ust.so,
not found (try using -rpath or -rpath-link)
/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib/gcc/mip=
s-openwrt-linux-uclibc/4.4.2/../../../../mips-openwrt-linux-uclibc/bin/ld=
:
warning: liburcu-cds.so.1, needed by
/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-ust.so,
not found (try using -rpath or -rpath-link)
XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-u=
st.so:
undefined reference to `__tracepoint_probe_unregister'
XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-u=
st.so:
undefined reference to `_cds_lfht_new'
XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-u=
st.so:
undefined reference to `cds_lfht_lookup'
XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-u=
st.so:
undefined reference to `init_tracepoint'
XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-u=
st.so:
undefined reference to `cds_lfht_del'
XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-u=
st.so:
undefined reference to `uuid_generate'
XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-u=
st.so:
undefined reference to `exit_tracepoint'
XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-u=
st.so:
undefined reference to `cds_lfht_destroy'
XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-u=
st.so:
undefined reference to `cds_lfht_first'
XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-u=
st.so:
undefined reference to `cds_lfht_add_unique'
XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-u=
st.so:
undefined reference to `cds_lfht_next'
XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liblttng-u=
st.so:
undefined reference to `__tracepoint_probe_register'

I found a bug here which seems related to my issue :
<a class=3D"moz-txt-link-freetext" href=3D"https://bugs.lttng.org/issues/=
321">https://bugs.lttng.org/issues/321</a>
This bug talk about a fix in configure.ac :
<a class=3D"moz-txt-link-freetext" href=3D"https://bugs.lttng.org/project=
s/lttng-ust/repository/revisions/faebb41808b9deda5ef5dfea0c035077407e7f9f=
/diff">https://bugs.lttng.org/projects/lttng-ust/repository/revisions/fae=
bb41808b9deda5ef5dfea0c035077407e7f9f/diff</a>

Problem is that I seems to have already this fix in my lttng-ust version.=
 I
am not very confortable with autotools. Do I have to add a
"libtool-linkdep-fixup" flag somewhere to be able to enable the fix durin=
g
my compile process ?

Thanks,

Arthur.


On 25/09/2013 18:17, J=C3=A9r=C3=A9mie Galarneau wrote:

On Wed, Sep 25, 2013 at 7:06 AM, Arthur LAMBERT
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:arthur.lambert@sagemcom=
.com">&lt;arthur.lambert@sagemcom.com&gt;</a> wrote:

Hi,

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

Please note that kernel tracing is only available on kernels &gt;=3D 2.6.=
38
(or 2.6.32 if patched appropriately).
I'm not an openwrt user, but it seems Makefiles are only provided for
LTTng 2.1.0. Can you confirm whether or not the build succeeds for
that version?

ARCH mips32
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

Could you clarify what was the error and what is the workaround?

Compilation result :

make package/lttng-tools/compile V=3D99

make[1]: Entering directory
`XXXXXX/openwrt'
make[2]: Entering directory
`XXXXXX/openwrt/feeds/tools/libs/liburcu'
make[2]: Leaving directory
`XXXXXX/openwrt/feeds/tools/libs/liburcu'
make[2]: Entering directory
`XXXXXX/openwrt/package/e2fsprogs'
WARNING: skipping e2fsprogs -- package not selected
WARNING: skipping uuidgen -- package not selected
WARNING: skipping libext2fs -- package not selected
WARNING: skipping tune2fs -- package not selected
WARNING: skipping resize2fs -- package not selected
WARNING: skipping badblocks -- package not selected
WARNING: skipping blkid -- package not selected
make[2]: Leaving directory
`XXXXXX/openwrt/package/e2fsprogs'
make[2]: Entering directory
`XXXXXX/openwrt/feeds/tools/devel/lttng-ust'
CFLAGS=3D"-Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3
-fhonour-copts -msoft-float
-IXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/include
-IXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/include
-IXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr=
/include
-IXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/inc=
lude
" CXXFLAGS=3D"-Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -=
g3
-fhonour-copts -msoft-float
-IXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/include
-IXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/include
-IXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr=
/include
-IXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/inc=
lude
"
LDFLAGS=3D"-LXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/l=
ib
-LXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/lib
-LXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr=
/lib
-LXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib
" make  -j2 -C
XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/.
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
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
make  all-recursive
make[4]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
Making all in .
make[5]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
make[5]: Nothing to be done for `all-am'.
make[5]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
Making all in include
make[5]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/inc=
lude'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/inc=
lude'
Making all in snprintf
make[5]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/snp=
rintf'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/snp=
rintf'
Making all in libringbuffer
make[5]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/lib=
ringbuffer'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/lib=
ringbuffer'
Making all in liblttng-ust-comm
make[5]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/lib=
lttng-ust-comm'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/lib=
lttng-ust-comm'
Making all in liblttng-ust
make[5]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/lib=
lttng-ust'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/lib=
lttng-ust'
Making all in liblttng-ust-ctl
make[5]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/lib=
lttng-ust-ctl'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/lib=
lttng-ust-ctl'
Making all in liblttng-ust-fork
make[5]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/lib=
lttng-ust-fork'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/lib=
lttng-ust-fork'
Making all in liblttng-ust-libc-wrapper
make[5]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/lib=
lttng-ust-libc-wrapper'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/lib=
lttng-ust-libc-wrapper'
Making all in liblttng-ust-cyg-profile
make[5]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/lib=
lttng-ust-cyg-profile'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/lib=
lttng-ust-cyg-profile'
Making all in tools
make[5]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/too=
ls'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/too=
ls'
Making all in tests
make[5]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tes=
ts'
Making all in utils
make[6]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tes=
ts/utils'
make[6]: Nothing to be done for `all'.
make[6]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tes=
ts/utils'
Making all in hello
make[6]: Entering directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tes=
ts/hello'
/bin/bash ../../libtool  --tag=3DCC   --mode=3Dlink
mips-openwrt-linux-uclibc-gcc -Werror=3Dold-style-definition -Wall -Os -p=
ipe
-mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3 -fhonour-copts -msoft=
-float
-LXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib
-LXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/lib
-LXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr=
/lib
-LXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib
-o hello hello-hello.o hello-tp.o ../../liblttng-ust/liblttng-ust.la -ldl
-lurcu-bp -lurcu-bp -lurcu-cds -lpthread
libtool: link: mips-openwrt-linux-uclibc-gcc -Werror=3Dold-style-definiti=
on
-Wall -Os -pipe -mabi=3D32 -mtune=3Dmips32 -fno-strict-aliasing -g3
-fhonour-copts -msoft-float -o .libs/hello hello-hello.o hello-tp.o
-LXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib
-LXXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/lib
-LXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/usr=
/lib
-LXXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib
../../liblttng-ust/.libs/liblttng-ust.so
XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/libl=
ttng-ust/.libs/liblttng-ust-tracepoint.so
-lrt -ldl -lurcu-bp -lurcu-cds -lpthread
../../liblttng-ust/.libs/liblttng-ust.so: warning: the use of `mktemp' is
dangerous, better use `mkstemp'
XXXXXX/openwrt/staging_dir/toolchain-mips_gcc-4.4.2_uClibc-0.9.30.1/lib/g=
cc/mips-openwrt-linux-uclibc/4.4.2/../../../../mips-openwrt-linux-uclibc/=
bin/ld:
warning: liburcu-common.so.2, needed by
XXXXXX/openwrt/staging_dir/target-mips_uClibc-0.9.30.1/usr/lib/liburcu-bp=
.so,
not found (try using -rpath or -rpath-link)
../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to `shm_ope=
n'
../../liblttng-ust/.libs/liblttng-ust.so: undefined reference to
`shm_unlink'
collect2: ld returned 1 exit status
make[6]: *** [hello] Error 1
make[6]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tes=
ts/hello'
make[5]: *** [all-recursive] Error 1
make[5]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/tes=
ts'
make[4]: *** [all-recursive] Error 1
make[4]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
make[3]: *** [all] Error 2
make[3]: Leaving directory
`XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0'
make[2]: ***
[XXXXXX/openwrt/build_dir/target-mips_uClibc-0.9.30.1/lttng-ust-2.3.0/.bu=
ilt]
Error 2
make[2]: Leaving directory
`XXXXXX/openwrt/feeds/tools/devel/lttng-ust'
make[1]: *** [package/feeds/tools/lttng-ust/compile] Error 2
make[1]: Leaving directory
`XXXXXX/openwrt'
make: *** [package/lttng-ust/compile] Erreur 2

I am not very confortable with autotools but I am not able to understand
this error. Is it relared to the missing liburcu-common.so.2 library ? sh=
m
functions are define by uclibc ? missing include ?

Thanks,
Arthur.


#
" Ce courriel et les documents qui lui sont joints peuvent contenir des
informations confidentielles ou ayant un caract=C3=83=C2=A8 priv=C3=83=C2=
=A9S'ils ne vous sont
pas destin=C3=83=C2=A9 nous vous signalons qu'il est strictement interdit=
 de les
divulguer, de les reproduire ou d'en utiliser de quelque mani=C3=83=C2=A8=
 que ce
soit le contenu. Si ce message vous a =C3=83=C2=A9 transmis par erreur, m=
erci d'en
informer l'exp=C3=83=C2=A9teur et de supprimer imm=C3=83=C2=A9atement de =
votre syst=C3=83=C2=A8
informatique ce courriel ainsi que tous les documents qui y sont attach=C3=
=83=C2=A9"


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



#
" Ce courriel et les documents qui lui sont joints peuvent contenir des
informations confidentielles ou ayant un caract=C3=83=C2=A8 priv=C3=83=C2=
=A9S'ils ne vous sont
pas destin=C3=83=C2=A9 nous vous signalons qu'il est strictement interdit=
 de les
divulguer, de les reproduire ou d'en utiliser de quelque mani=C3=83=C2=A8=
 que ce
soit le contenu. Si ce message vous a =C3=83=C2=A9 transmis par erreur, m=
erci d'en
informer l'exp=C3=83=C2=A9teur et de supprimer imm=C3=83=C2=A9atement de =
votre syst=C3=83=C2=A8
informatique ce courriel ainsi que tous les documents qui y sont attach=C3=
=83=C2=A9"


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

--------------060700090508010203080301--


--===============1131913826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1131913826==--
