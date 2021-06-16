Return-Path: <SRS0=pLug=LK=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E2FC48BE6
	for <lttng-dev@archiver.kernel.org>; Wed, 16 Jun 2021 06:49:49 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13610611CE
	for <lttng-dev@archiver.kernel.org>; Wed, 16 Jun 2021 06:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13610611CE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4G4bQY0ntMzHJ8;
	Wed, 16 Jun 2021 02:49:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1623826182;
	bh=JdabV42LN5NBSTwhg7gHkiw2U6jrw/KL1n1Q1YWvKmM=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=TiW4T52sXtoc1q5LeUgST5rUsnEyJB8Qn3wU0CdqfWRCHqU/EmzhHi5ahiOhef0wa
	 yniZJVf6FDsAjrz42EVL9wojTf7H+xIOaNT7kjMu/mkgA/0Am8i0sjiblMl1D6rYMv
	 +ZMtK3hxFV9EhYVu8xIwg5ey6pgT+W6uo/TMXGbAx13kAfQZ+4Zju/SuOQ3t6lm0f0
	 ZrxjZH+ZHxGHH9RHDwaYxd2ktw/APZt4lu8Gp59JSNu2x0eKPoTM1/5jSRwaxjCQ/i
	 5v0VL6OHW8RHU/2TqVW3jH1AY5bw1BmR5hswF1DyH5YcOFlanfPDOh2fI1ag4F1QIk
	 5xNXYQ9m6UCMQ==
Received: from smtp.avcs-au.com (unknown [144.130.96.35])
 by lists.lttng.org (Postfix) with SMTP id 4G4bQV47gvzHJC
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jun 2021 02:49:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by pac.avcs-au.com (Postfix) with ESMTP id 6790411A7133
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jun 2021 16:49:18 +1000 (AEST)
X-Virus-Scanned: amavisd-new at avcs-au.com
Received: from smtp.avcs-au.com ([127.0.0.1])
 by localhost (smtp.avcs-au.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 7p1fJbutrDJb for <lttng-dev@lists.lttng.org>;
 Wed, 16 Jun 2021 16:48:52 +1000 (AEST)
Received: from HPOmenPAC (unknown [192.168.100.145])
 by smtp.avcs-au.com (Postfix) with ESMTP id 18C9C11A5585
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jun 2021 16:48:52 +1000 (AEST)
To: <lttng-dev@lists.lttng.org>
Date: Wed, 16 Jun 2021 16:49:00 +1000
Message-ID: <000a01d7627b$b01032b0$10309810$@triplanets.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Addie4Sj+TGmPgrHS+GUDO2GtZCxew==
Content-Language: en-au
Subject: [lttng-dev] Problems cross compiling LTTNG
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Merlin via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: public@triplanets.com
Content-Type: multipart/mixed; boundary="===============4715336618880944799=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

This is a multipart message in MIME format.

--===============4715336618880944799==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000B_01D762CF.81BEDAC0"
Content-Language: en-au

This is a multipart message in MIME format.

------=_NextPart_000_000B_01D762CF.81BEDAC0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

I am having problems cross compiling LTTNG for the ARM platform.  Everything
compiles fine, except the TOOLS.

 

The error I am getting is:

 

libtool: warning: library
'/home/USER/work/LTTNG/sysroot/usr/local/lib/liburcu.la' was moved.

/bin/grep: /usr/local/lib/liburcu-common.la: No such file or directory

/bin/sed: can't read /usr/local/lib/liburcu-common.la: No such file or
directory

libtool:   error: '/usr/local/lib/liburcu-common.la' is not a valid libtool
archive

Makefile:547: recipe for target 'libhashtable.la' failed

make[3]: *** [libhashtable.la] Error 1

make[3]: Leaving directory
'/home/USER/work/LTTNG/builds/lttng-tools/src/common/hashtable'

Makefile:955: recipe for target 'all-recursive' failed

make[2]: *** [all-recursive] Error 1

make[2]: Leaving directory
'/home/USER/work/LTTNG/builds/lttng-tools/src/common'

Makefile:551: recipe for target 'all-recursive' failed

make[1]: *** [all-recursive] Error 1

make[1]: Leaving directory '/home/USER/work/LTTNG/builds/lttng-tools/src'

Makefile:661: recipe for target 'all-recursive' failed

make: *** [all-recursive] Error 1

 

It is looking for "/usr/local/lib/libiconv.la" when it should be looking for
"/home/USER/work/LTTNG/sysroot /usr/local/lib/libiconv.la" which is where
the builds are being installed.

 

In desperation I tried setting -with-sysroot in the configuration step to
the appropriate directory but it made no difference.

 

My build scripts seem okay but maybe I am missing something obvious.  I also
tried a couple of other build scripts that were on the web as examples of
cross compiling LTTNG with similar results, so I wonder if the build
environment I am using is a little "different", but I have no control over
that.

 

This is the script that I am using.  It is based on one that was posted as a
successful example of cross compiling LTTNG, and I have made some changes
for my environment.  Works well for everything except the tools.

 

All suggestions on where the problem lies are welcome.

 

#!/bin/bash

 

# set your base directory

BASEDIR=/home/USER/work/LTTNG

 

# set your system root path

SYSROOT=$BASEDIR/sysroot

 

# export symlink to the real arm gcc

export HOST=arm-cortex_a8-linux

export CC="/home/USER/bin/${HOST}-gcc"

 

# set your kernel build path (you will need to symlink the includes into
this)

G_KERNELDIR=/home/USER/work/linux/build-2605246

 

# set the support library versions to build 

LIBICONV_VERSION=1.16                                               

LIBUUID_VERSION=1.0.3

LIBXML2_VERSION=2.9.9

POPT_VERSION=1.16

ZLIB_VERSION=1.2.11

 

#######################################################

#

# YOU SHOULD NOT NEED TO ALTER ANYTHING BELOW THIS LINE

#

#######################################################

 

# change your flags here

export ac_cv_func_malloc_0_nonnull=yes

export ac_cv_func_realloc_0_nonnull=yes

 

G_PREFIX=/usr/local

 

export PKG_CONFIG_PATH=${SYSROOT}${G_PREFIX}/lib/pkgconfig

export CPPFLAGS="-I${SYSROOT}${G_PREFIX}/include"

export LDFLAGS="-L${SYSROOT}${G_PREFIX}/lib
-Wl,-rpath-link=${SYSROOT}${G_PREFIX}/lib"

export LT_SYS_LIBRARY_PATH="${SYSROOT}${G_PREFIX}/lib"

 

G_ARCH=arm

G_CROSS_COMPILE=arm-

 

# tracking download/compile steps

G_CFG_FILE="$PWD/${0%\.*}.conf"

 

# other directories

G_TARBALL_DIR=$PWD/tarballs

G_SOURCES_DIR=$PWD/sources

G_BUILD_DIR=$PWD/builds

 

# steps for tracking progress in $G_CFG_FILE

step_start=0

step_download=1

step_compile=2

 

echo

echo "This script will compile and install lttng and some deps"

echo "Building for HOST=${HOST}"

echo

echo "Builds are located in $G_BUILD_DIR"

echo "Sources are located in $G_SOURCES_DIR"

echo "Tarballs are located in $G_TARBALL_DIR"

echo "sysroot is located at ${SYSROOT}"

echo "prefix is set to $G_PREFIX"

echo

echo "press Enter to continue or CRTL-C to abort"

read

 

[ -e "$G_CFG_FILE" ] && . "$G_CFG_FILE" &> /dev/null

 

function get_src_dir()

{

    local filename="$1"

    tar -tf "$G_TARBALL_DIR/$filename"| sed -e 's@/.*@@' | uniq

}

 

function build()

{

    local filename="$1"

    local what="$2"

    local dir_name="$3"

    local state="$4"

    local do_bootstrap=$5

 

    if [ $state -eq $step_download ] ; then

 

        if $do_bootstrap ; then

            pushd $G_SOURCES_DIR/$dir_name

            ./bootstrap

            popd

        fi

 

        mkdir -p "$G_BUILD_DIR/$dir_name"       

        pushd "$G_BUILD_DIR/$dir_name"      

        if [ -n "$patch" ] ; then

            pushd "$G_SOURCES_DIR/$dir_name"        

            wget $patch -O- | patch -p1

            popd

        fi

        "$G_SOURCES_DIR/$dir_name"/configure --host=${HOST}
--prefix=${G_PREFIX} ${EXTRA_CONF} --enable-shared

        if [ -n ${COPY_MAKEFILE} ] ; then

               # this hack in necessary because the tests do not compile in
our build environment

               cp -f $BASEDIR/mtmake ${COPY_MAKEFILE}

        fi

        make -j3 \

          && make install DESTDIR=${SYSROOT} \

            && echo "$what=$step_compile" >> $G_CFG_FILE

        popd

   fi

    if [ $state -eq $step_compile ] ; then

        echo ">> $what is already compiled"

    fi

}

 

function download()

{

    local url="$1"

    local what="$2"

    local filename="$3"

    local state="$4"

 

    if [ $state -lt $step_download ] ; then

        wget "$url" -O "$G_TARBALL_DIR/$filename"

        echo "$what=$step_download" >> $G_CFG_FILE

        tar -C $G_SOURCES_DIR -xf "$G_TARBALL_DIR/$filename"

        . "$G_CFG_FILE" &> /dev/null

    fi

}

 

function download_git()

{

    local url="$1"

    local what="$2"

    local filename="$3"

    local state="$4"

 

    if [ $state -lt $step_download ] ; then

 

        pushd $G_SOURCES_DIR

        git clone $url

        popd

        echo "$what=$step_download" >> $G_CFG_FILE

        . "$G_CFG_FILE" &> /dev/null

    fi

}

 

function init()

{

    local what="$1"

    eval state=\$$what

 

    if [ ! -n "$state" ] ; then

        echo "$what=$step_start" >> $G_CFG_FILE

        . "$G_CFG_FILE" &> /dev/null

    fi

 

    eval state=\$$what

}

 

function get_em()

{

    local url="$1"

    local what="$2"

    local filename=$(basename $url) 

 

    init "$what"

    download "$url" "$what" $filename $state

    eval state=\$$what

    local dir_name=$(get_src_dir $filename)

    build $filename "$what" $dir_name $state false

}

 

function get_em_git()

{

    local url="$1"

    local what="$2"

    local do_bootstrap="$3"

    local filename=$(basename $url) 

    filename=${filename/.git}

 

    init "$what"

    download_git "$url" "$what" $filename $state

    eval state=\$$what

 

    build $filename "$what" $filename $state $do_bootstrap

}

 

echo "create directories"

mkdir -p "$G_TARBALL_DIR" "$G_SOURCES_DIR" "$G_BUILD_DIR" &>/dev/null

 

 

########################

# define the packages we want to compile

########################

 

# this are the dependencies that are missing for our sysroot

# we will compile them and install the to the ${SYSROOT}

#

# --- BEGIN --- dependencies

what=libuuid

url=http://downloads.sourceforge.net/project/libuuid/libuuid-$LIBUUID_VERSIO
N.tar.gz

get_em $url "$what"

 

what=libiconv

url=https://ftp.gnu.org/gnu/libiconv/libiconv-$LIBICONV_VERSION.tar.gz

get_em $url "$what"

unset patch

 

what=zlib

url=https://zlib.net/zlib-$ZLIB_VERSION.tar.gz

init "$what"

filename=$(basename $url)   

download "$url" "$what" $filename $state

if [ $state -eq $step_compile ] ; then

    echo ">> $what is already compiled"

else

    dir_name=$(get_src_dir $filename)

    pushd $G_SOURCES_DIR/$dir_name

    LDSHARED="$CC -shared -Wl,-soname,libz.so.1" \

    ./configure --shared --prefix="${G_PREFIX}"

    make \

      && make install prefix="${G_PREFIX}" DESTDIR=${SYSROOT} \

        && echo "$what=$step_compile" >> $G_CFG_FILE

    popd

fi

 

what=libxml2

url=ftp://xmlsoft.org/libxml2/libxml2-sources-$LIBXML2_VERSION.tar.gz

EXTRA_CONF="--without-python"

get_em $url "$what"

unset EXTRA_CONF

export libxml2_CFLAGS="-I${SYSROOT}${G_PREFIX}/include/libxml2"

export libxml2_LIBS="L${SYSROOT}${G_PREFIX}/lib -lxml2 -lpthread -lm -lz"

 

what=popt

url=ftp://anduin.linuxfromscratch.org/BLFS/svn/p/popt-$POPT_VERSION.tar.gz

get_em $url "$what"

export POPT_LIBS="-L${SYSROOT}${G_PREFIX}/lib -lpopt"

 

# --- END --- dependencies

 

 

#######################

# compile lttng related packages and install into ${SYSROOT}

what=userspace_rcu

url=git://git.lttng.org/userspace-rcu.git

get_em_git $url "$what" true

export URCU_BP_CFLAGS="-I${SYSROOT}${G_PREFIX}/include"

export URCU_BP_LIBS="-L${SYSROOT}${G_PREFIX}/lib -lurcu-common -lurcu-bp"

export URCU_CDS_CFLAGS="-I${SYSROOT}${G_PREFIX}/include"

export URCU_CDS_LIBS="-L${SYSROOT}${G_PREFIX}/lib -lurcu-common -lurcu-cds"

export URCU_CFLAGS="-I${SYSROOT}${G_PREFIX}/include/urcu"

export URCU_LIBS="-L${SYSROOT}${G_PREFIX}/lib -lurcu-common -lurcu
-lurcu-cds"

export CPPFLAGS="-I${SYSROOT}${G_PREFIX}/include
-I${SYSROOT}${G_PREFIX}/include/urcu"

 

 

 

what=lttng_ust

url=git://git.lttng.org/lttng-ust.git

EXTRA_CONF="--disable-maintainer-mode --disable-examples
--disable-man-pages"

COPY_MAKEFILE="$BASEDIR/builds/lttng-ust/tests/Makefile"

get_em_git $url "$what" true

unset COPY_MAKEFILE

unset EXTRA_CONF

export UST_LIBS="-L${SYSROOT}${G_PREFIX}/lib -llttng-ust -llttng-ust-common
-ldl"

 


# fix the paths in the la files

#for FILE in $(find ${SYSROOT}${G_PREFIX}/lib -type f -name "*.la") ; do

#             sed -i "s^-L/home/USER/work/LTTNG/sysroot/usr/local/lib
/usr/local/lib^-L/home/USER/work/LTTNG/sysroot/usr/local/lib
/home/USER/work/LTTNG/sysroot/usr/local/lib^" ${FILE}

#done

 

 

 

what=lttng_tools

url=git://git.lttng.org/lttng-tools.git

EXTRA_CONF="--disable-maintainer-mode --disable-man-pages --disable-static
--with-sessiond-bin=/mnt/sd1/modulesLTTNG/lttng/usr/local/bin/lttng-sessiond
"

COPY_MAKEFILE="${BASEDIR}/builds/lttng-tools/tests/Makefile"

get_em_git $url "$what" true              

unset COPY_MAKEFILE

unset EXTRA_CONF

 

 

 

what=lttng_modules

url=git://git.lttng.org/lttng-modules.git

init "$what"

filename=$(basename $url)   

filename=${filename/.git}

download_git "$url" "$what" $filename $state

if [ $state -eq $step_compile ] ; then

    echo ">> $what is already compiled"

else

    #dir_name=$(get_src_dir $filename)

    pushd $G_SOURCES_DIR/$filename

    make ARCH=$G_ARCH CROSS_COMPILE=$G_CROSS_COMPILE KERNELDIR=$G_KERNELDIR
-j4 \

    && make ARCH=$G_ARCH CROSS_COMPILE=$G_CROSS_COMPILE
KERNELDIR=$G_KERNELDIR INSTALL_MOD_PATH=${SYSROOT} modules_install \

        && echo "$what=$step_compile" >> $G_CFG_FILE

    popd

fi

 

echo

echo "INFO: the build progress for all packages is tracked in $G_CFG_FILE"

 


------=_NextPart_000_000B_01D762CF.81BEDAC0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:8.0pt;
	margin-left:0cm;
	line-height:106%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-AU =
link=3D"#0563C1" vlink=3D"#954F72" style=3D'word-wrap:break-word'><div =
class=3DWordSection1><p class=3DMsoNormal><span =
lang=3DEN-US>Hi,<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>I am having problems cross compiling LTTNG for the ARM =
platform.&nbsp; Everything compiles fine, except the =
TOOLS.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>The error I am getting is:<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal>libtool: warning: library =
'/home/USER/work/LTTNG/sysroot/usr/local/lib/liburcu.la' was =
moved.<o:p></o:p></p><p class=3DMsoNormal>/bin/grep: =
/usr/local/lib/liburcu-common.la: No such file or =
directory<o:p></o:p></p><p class=3DMsoNormal>/bin/sed: can't read =
/usr/local/lib/liburcu-common.la: No such file or =
directory<o:p></o:p></p><p class=3DMsoNormal>libtool:&nbsp; &nbsp;error: =
'/usr/local/lib/liburcu-common.la' is not a valid libtool =
archive<o:p></o:p></p><p class=3DMsoNormal>Makefile:547: recipe for =
target 'libhashtable.la' failed<o:p></o:p></p><p =
class=3DMsoNormal>make[3]: *** [libhashtable.la] Error =
1<o:p></o:p></p><p class=3DMsoNormal>make[3]: Leaving directory =
'/home/USER/work/LTTNG/builds/lttng-tools/src/common/hashtable'<o:p></o:p=
></p><p class=3DMsoNormal>Makefile:955: recipe for target =
'all-recursive' failed<o:p></o:p></p><p class=3DMsoNormal>make[2]: *** =
[all-recursive] Error 1<o:p></o:p></p><p class=3DMsoNormal>make[2]: =
Leaving directory =
'/home/USER/work/LTTNG/builds/lttng-tools/src/common'<o:p></o:p></p><p =
class=3DMsoNormal>Makefile:551: recipe for target 'all-recursive' =
failed<o:p></o:p></p><p class=3DMsoNormal>make[1]: *** [all-recursive] =
Error 1<o:p></o:p></p><p class=3DMsoNormal>make[1]: Leaving directory =
'/home/USER/work/LTTNG/builds/lttng-tools/src'<o:p></o:p></p><p =
class=3DMsoNormal>Makefile:661: recipe for target 'all-recursive' =
failed<o:p></o:p></p><p class=3DMsoNormal>make: *** [all-recursive] =
Error 1<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><span lang=3DEN-US>It is looking for =
&#8220;/usr/local/lib/libiconv.la&#8221; when it should be looking for =
&#8220;/home/USER/work/LTTNG/sysroot /usr/local/lib/libiconv.la&#8221; =
which is where the builds are being installed.<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>In desperation I tried setting =
&#8211;with-sysroot in the configuration step to the appropriate =
directory but it made no difference.<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>My build scripts seem okay but =
maybe I am missing something obvious.&nbsp; I also tried a couple of =
other build scripts that were on the web as examples of cross compiling =
LTTNG with similar results, so I wonder if the build environment I am =
using is a little &#8220;different&#8221;, but I have no control over =
that.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>This is the script that I am using.&nbsp; It is based on =
one that was posted as a successful example of cross compiling LTTNG, =
and I have made some changes for my environment.&nbsp; Works well for =
everything except the tools.<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>All suggestions on where the =
problem lies are welcome.<o:p></o:p></span></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>#!/bin/bash<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal># set your =
base directory<o:p></o:p></p><p =
class=3DMsoNormal>BASEDIR=3D/home/USER/work/LTTNG<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal># set your =
system root path<o:p></o:p></p><p =
class=3DMsoNormal>SYSROOT=3D$BASEDIR/sysroot<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal># export =
symlink to the real arm gcc<o:p></o:p></p><p class=3DMsoNormal>export =
HOST=3Darm-cortex_a8-linux<o:p></o:p></p><p class=3DMsoNormal>export =
CC=3D&quot;/home/USER/bin/${HOST}-gcc&quot;<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal># set your =
kernel build path (you will need to symlink the includes into =
this)<o:p></o:p></p><p =
class=3DMsoNormal>G_KERNELDIR=3D/home/USER/work/linux/build-2605246<o:p><=
/o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal># set the support library versions to build =
<o:p></o:p></p><p =
class=3DMsoNormal>LIBICONV_VERSION=3D1.16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></p><p =
class=3DMsoNormal>LIBUUID_VERSION=3D1.0.3<o:p></o:p></p><p =
class=3DMsoNormal>LIBXML2_VERSION=3D2.9.9<o:p></o:p></p><p =
class=3DMsoNormal>POPT_VERSION=3D1.16<o:p></o:p></p><p =
class=3DMsoNormal>ZLIB_VERSION=3D1.2.11<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>#######################################################=
<o:p></o:p></p><p class=3DMsoNormal>#<o:p></o:p></p><p =
class=3DMsoNormal># YOU SHOULD NOT NEED TO ALTER ANYTHING BELOW THIS =
LINE<o:p></o:p></p><p class=3DMsoNormal>#<o:p></o:p></p><p =
class=3DMsoNormal>#######################################################=
<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal># change your flags here<o:p></o:p></p><p =
class=3DMsoNormal>export =
ac_cv_func_malloc_0_nonnull=3Dyes<o:p></o:p></p><p =
class=3DMsoNormal>export =
ac_cv_func_realloc_0_nonnull=3Dyes<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>G_PREFIX=3D/usr/local<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>export =
PKG_CONFIG_PATH=3D${SYSROOT}${G_PREFIX}/lib/pkgconfig<o:p></o:p></p><p =
class=3DMsoNormal>export =
CPPFLAGS=3D&quot;-I${SYSROOT}${G_PREFIX}/include&quot;<o:p></o:p></p><p =
class=3DMsoNormal>export LDFLAGS=3D&quot;-L${SYSROOT}${G_PREFIX}/lib =
-Wl,-rpath-link=3D${SYSROOT}${G_PREFIX}/lib&quot;<o:p></o:p></p><p =
class=3DMsoNormal>export =
LT_SYS_LIBRARY_PATH=3D&quot;${SYSROOT}${G_PREFIX}/lib&quot;<o:p></o:p></p=
><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>G_ARCH=3Darm<o:p></o:p></p><p =
class=3DMsoNormal>G_CROSS_COMPILE=3Darm-<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal># tracking =
download/compile steps<o:p></o:p></p><p =
class=3DMsoNormal>G_CFG_FILE=3D&quot;$PWD/${0%\.*}.conf&quot;<o:p></o:p><=
/p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal># =
other directories<o:p></o:p></p><p =
class=3DMsoNormal>G_TARBALL_DIR=3D$PWD/tarballs<o:p></o:p></p><p =
class=3DMsoNormal>G_SOURCES_DIR=3D$PWD/sources<o:p></o:p></p><p =
class=3DMsoNormal>G_BUILD_DIR=3D$PWD/builds<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal># steps for =
tracking progress in $G_CFG_FILE<o:p></o:p></p><p =
class=3DMsoNormal>step_start=3D0<o:p></o:p></p><p =
class=3DMsoNormal>step_download=3D1<o:p></o:p></p><p =
class=3DMsoNormal>step_compile=3D2<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>echo<o:p></o:p></p><p class=3DMsoNormal>echo =
&quot;This script will compile and install lttng and some =
deps&quot;<o:p></o:p></p><p class=3DMsoNormal>echo &quot;Building for =
HOST=3D${HOST}&quot;<o:p></o:p></p><p =
class=3DMsoNormal>echo<o:p></o:p></p><p class=3DMsoNormal>echo =
&quot;Builds are located in $G_BUILD_DIR&quot;<o:p></o:p></p><p =
class=3DMsoNormal>echo &quot;Sources are located in =
$G_SOURCES_DIR&quot;<o:p></o:p></p><p class=3DMsoNormal>echo =
&quot;Tarballs are located in $G_TARBALL_DIR&quot;<o:p></o:p></p><p =
class=3DMsoNormal>echo &quot;sysroot is located at =
${SYSROOT}&quot;<o:p></o:p></p><p class=3DMsoNormal>echo &quot;prefix is =
set to $G_PREFIX&quot;<o:p></o:p></p><p =
class=3DMsoNormal>echo<o:p></o:p></p><p class=3DMsoNormal>echo =
&quot;press Enter to continue or CRTL-C to abort&quot;<o:p></o:p></p><p =
class=3DMsoNormal>read<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>[ -e =
&quot;$G_CFG_FILE&quot; ] &amp;&amp; . &quot;$G_CFG_FILE&quot; &amp;&gt; =
/dev/null<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>function get_src_dir()<o:p></o:p></p><p =
class=3DMsoNormal>{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
filename=3D&quot;$1&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; tar -tf =
&quot;$G_TARBALL_DIR/$filename&quot;| sed -e 's@/.*@@' | =
uniq<o:p></o:p></p><p class=3DMsoNormal>}<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>function =
build()<o:p></o:p></p><p class=3DMsoNormal>{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
filename=3D&quot;$1&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
what=3D&quot;$2&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
dir_name=3D&quot;$3&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
state=3D&quot;$4&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
do_bootstrap=3D$5<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; if [ $state -eq $step_download ] ; =
then<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
$do_bootstrap ; then<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; pushd $G_SOURCES_DIR/$dir_name<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ./bootstrap<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; popd<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
fi<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mkdir -p =
&quot;$G_BUILD_DIR/$dir_name&quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pushd =
&quot;$G_BUILD_DIR/$dir_name&quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if [ =
-n &quot;$patch&quot; ] ; then<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; pushd =
&quot;$G_SOURCES_DIR/$dir_name&quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;wget $patch -O- | patch -p1<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; popd<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
fi<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&quot;$G_SOURCES_DIR/$dir_name&quot;/configure --host=3D${HOST} =
--prefix=3D${G_PREFIX} ${EXTRA_CONF} --enable-shared<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ -n =
${COPY_MAKEFILE} ] ; then<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # this hack in necessary because =
the tests do not compile in our build environment<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp -f $BASEDIR/mtmake =
${COPY_MAKEFILE}<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
fi<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make -j3 =
\<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&amp;&amp; make install DESTDIR=3D${SYSROOT} \<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; &amp;&amp; echo &quot;$what=3D$step_compile&quot; &gt;&gt; =
$G_CFG_FILE<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
popd<o:p></o:p></p><p class=3DMsoNormal> =
&nbsp;&nbsp;&nbsp;fi<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; if [ $state -eq $step_compile ] ; =
then<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo =
&quot;&gt;&gt; $what is already compiled&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; fi<o:p></o:p></p><p =
class=3DMsoNormal>}<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>function =
download()<o:p></o:p></p><p class=3DMsoNormal>{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
url=3D&quot;$1&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
what=3D&quot;$2&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
filename=3D&quot;$3&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
state=3D&quot;$4&quot;<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; if [ $state -lt $step_download ] ; =
then<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wget =
&quot;$url&quot; -O =
&quot;$G_TARBALL_DIR/$filename&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo =
&quot;$what=3D$step_download&quot; &gt;&gt; $G_CFG_FILE<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tar -C =
$G_SOURCES_DIR -xf &quot;$G_TARBALL_DIR/$filename&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; . =
&quot;$G_CFG_FILE&quot; &amp;&gt; /dev/null<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; fi<o:p></o:p></p><p =
class=3DMsoNormal>}<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>function =
download_git()<o:p></o:p></p><p class=3DMsoNormal>{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
url=3D&quot;$1&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
what=3D&quot;$2&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
filename=3D&quot;$3&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
state=3D&quot;$4&quot;<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; if [ $state -lt $step_download ] ; =
then<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pushd =
$G_SOURCES_DIR<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; git clone =
$url<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
popd<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo =
&quot;$what=3D$step_download&quot; &gt;&gt; $G_CFG_FILE<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;. =
&quot;$G_CFG_FILE&quot; &amp;&gt; /dev/null<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; fi<o:p></o:p></p><p =
class=3DMsoNormal>}<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>function =
init()<o:p></o:p></p><p class=3DMsoNormal>{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
what=3D&quot;$1&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; eval =
state=3D\$$what<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; if [ ! -n &quot;$state&quot; ] ; =
then<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo =
&quot;$what=3D$step_start&quot; &gt;&gt; $G_CFG_FILE<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; . =
&quot;$G_CFG_FILE&quot; &amp;&gt; /dev/null<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; fi<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; eval =
state=3D\$$what<o:p></o:p></p><p class=3DMsoNormal>}<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>function =
get_em()<o:p></o:p></p><p class=3DMsoNormal>{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
url=3D&quot;$1&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
what=3D&quot;$2&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local filename=3D$(basename $url) =
<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; init =
&quot;$what&quot;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
download &quot;$url&quot; &quot;$what&quot; $filename =
$state<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; eval =
state=3D\$$what<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
local dir_name=3D$(get_src_dir $filename)<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; build $filename &quot;$what&quot; =
$dir_name $state false<o:p></o:p></p><p =
class=3DMsoNormal>}<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>function =
get_em_git()<o:p></o:p></p><p class=3DMsoNormal>{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
url=3D&quot;$1&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
what=3D&quot;$2&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local =
do_bootstrap=3D&quot;$3&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; local filename=3D$(basename $url) =
<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;filename=3D${filename/.git}<o:p=
></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; init =
&quot;$what&quot;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
download_git &quot;$url&quot; &quot;$what&quot; $filename =
$state<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; eval =
state=3D\$$what<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; build $filename &quot;$what&quot; =
$filename $state $do_bootstrap<o:p></o:p></p><p =
class=3DMsoNormal>}<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>echo =
&quot;create directories&quot;<o:p></o:p></p><p class=3DMsoNormal>mkdir =
-p &quot;$G_TARBALL_DIR&quot; &quot;$G_SOURCES_DIR&quot; =
&quot;$G_BUILD_DIR&quot; &amp;&gt;/dev/null<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>########################<o:p></o:p></p><p =
class=3DMsoNormal># define the packages we want to =
compile<o:p></o:p></p><p =
class=3DMsoNormal>########################<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal># this are =
the dependencies that are missing for our sysroot<o:p></o:p></p><p =
class=3DMsoNormal># we will compile them and install the to the =
${SYSROOT}<o:p></o:p></p><p class=3DMsoNormal>#<o:p></o:p></p><p =
class=3DMsoNormal># --- BEGIN --- dependencies<o:p></o:p></p><p =
class=3DMsoNormal>what=3Dlibuuid<o:p></o:p></p><p =
class=3DMsoNormal>url=3Dhttp://downloads.sourceforge.net/project/libuuid/=
libuuid-$LIBUUID_VERSION.tar.gz<o:p></o:p></p><p =
class=3DMsoNormal>get_em $url &quot;$what&quot;<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>what=3Dlibiconv<o:p></o:p></p><p =
class=3DMsoNormal>url=3Dhttps://ftp.gnu.org/gnu/libiconv/libiconv-$LIBICO=
NV_VERSION.tar.gz<o:p></o:p></p><p class=3DMsoNormal>get_em $url =
&quot;$what&quot;<o:p></o:p></p><p class=3DMsoNormal>unset =
patch<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>what=3Dzlib<o:p></o:p></p><p =
class=3DMsoNormal>url=3Dhttps://zlib.net/zlib-$ZLIB_VERSION.tar.gz<o:p></=
o:p></p><p class=3DMsoNormal>init &quot;$what&quot;<o:p></o:p></p><p =
class=3DMsoNormal>filename=3D$(basename $url)&nbsp;&nbsp; =
<o:p></o:p></p><p class=3DMsoNormal>download &quot;$url&quot; =
&quot;$what&quot; $filename $state<o:p></o:p></p><p class=3DMsoNormal>if =
[ $state -eq $step_compile ] ; then<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; echo &quot;&gt;&gt; $what is =
already compiled&quot;<o:p></o:p></p><p =
class=3DMsoNormal>else<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dir_name=3D$(get_src_dir =
$filename)<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; pushd =
$G_SOURCES_DIR/$dir_name<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; LDSHARED=3D&quot;$CC -shared =
-Wl,-soname,libz.so.1&quot; \<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; ./configure --shared =
--prefix=3D&quot;${G_PREFIX}&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; make \<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; make install =
prefix=3D&quot;${G_PREFIX}&quot; DESTDIR=3D${SYSROOT} \<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; =
echo &quot;$what=3D$step_compile&quot; &gt;&gt; =
$G_CFG_FILE<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
popd<o:p></o:p></p><p class=3DMsoNormal>fi<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>what=3Dlibxml2<o:p></o:p></p><p =
class=3DMsoNormal>url=3Dftp://xmlsoft.org/libxml2/libxml2-sources-$LIBXML=
2_VERSION.tar.gz<o:p></o:p></p><p =
class=3DMsoNormal>EXTRA_CONF=3D&quot;--without-python&quot;<o:p></o:p></p=
><p class=3DMsoNormal>get_em $url &quot;$what&quot;<o:p></o:p></p><p =
class=3DMsoNormal>unset EXTRA_CONF<o:p></o:p></p><p =
class=3DMsoNormal>export =
libxml2_CFLAGS=3D&quot;-I${SYSROOT}${G_PREFIX}/include/libxml2&quot;<o:p>=
</o:p></p><p class=3DMsoNormal>export =
libxml2_LIBS=3D&quot;L${SYSROOT}${G_PREFIX}/lib -lxml2 -lpthread -lm =
-lz&quot;<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>what=3Dpopt<o:p></o:p></p><p =
class=3DMsoNormal>url=3Dftp://anduin.linuxfromscratch.org/BLFS/svn/p/popt=
-$POPT_VERSION.tar.gz<o:p></o:p></p><p class=3DMsoNormal>get_em $url =
&quot;$what&quot;<o:p></o:p></p><p class=3DMsoNormal>export =
POPT_LIBS=3D&quot;-L${SYSROOT}${G_PREFIX}/lib =
-lpopt&quot;<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal># --- END --- dependencies<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>#######################<o:p></o:p></p><p =
class=3DMsoNormal># compile lttng related packages and install into =
${SYSROOT}<o:p></o:p></p><p =
class=3DMsoNormal>what=3Duserspace_rcu<o:p></o:p></p><p =
class=3DMsoNormal>url=3Dgit://git.lttng.org/userspace-rcu.git<o:p></o:p><=
/p><p class=3DMsoNormal>get_em_git $url &quot;$what&quot; =
true<o:p></o:p></p><p class=3DMsoNormal>export =
URCU_BP_CFLAGS=3D&quot;-I${SYSROOT}${G_PREFIX}/include&quot;<o:p></o:p></=
p><p class=3DMsoNormal>export =
URCU_BP_LIBS=3D&quot;-L${SYSROOT}${G_PREFIX}/lib -lurcu-common =
-lurcu-bp&quot;<o:p></o:p></p><p class=3DMsoNormal>export =
URCU_CDS_CFLAGS=3D&quot;-I${SYSROOT}${G_PREFIX}/include&quot;<o:p></o:p><=
/p><p class=3DMsoNormal>export =
URCU_CDS_LIBS=3D&quot;-L${SYSROOT}${G_PREFIX}/lib -lurcu-common =
-lurcu-cds&quot;<o:p></o:p></p><p class=3DMsoNormal>export =
URCU_CFLAGS=3D&quot;-I${SYSROOT}${G_PREFIX}/include/urcu&quot;<o:p></o:p>=
</p><p class=3DMsoNormal>export =
URCU_LIBS=3D&quot;-L${SYSROOT}${G_PREFIX}/lib -lurcu-common -lurcu =
-lurcu-cds&quot;<o:p></o:p></p><p class=3DMsoNormal>export =
CPPFLAGS=3D&quot;-I${SYSROOT}${G_PREFIX}/include =
-I${SYSROOT}${G_PREFIX}/include/urcu&quot;<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>what=3Dlttng_ust<o:p></o:p></p><p =
class=3DMsoNormal>url=3Dgit://git.lttng.org/lttng-ust.git<o:p></o:p></p><=
p class=3DMsoNormal>EXTRA_CONF=3D&quot;--disable-maintainer-mode =
--disable-examples --disable-man-pages&quot;<o:p></o:p></p><p =
class=3DMsoNormal>COPY_MAKEFILE=3D&quot;$BASEDIR/builds/lttng-ust/tests/M=
akefile&quot;<o:p></o:p></p><p class=3DMsoNormal>get_em_git $url =
&quot;$what&quot; true<o:p></o:p></p><p class=3DMsoNormal>unset =
COPY_MAKEFILE<o:p></o:p></p><p class=3DMsoNormal>unset =
EXTRA_CONF<o:p></o:p></p><p class=3DMsoNormal>export =
UST_LIBS=3D&quot;-L${SYSROOT}${G_PREFIX}/lib -llttng-ust =
-llttng-ust-common -ldl&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;<o:p></o:p></p><p class=3DMsoNormal># fix the paths in the =
la files<o:p></o:p></p><p class=3DMsoNormal>#for FILE in $(find =
${SYSROOT}${G_PREFIX}/lib -type f -name &quot;*.la&quot;) ; =
do<o:p></o:p></p><p =
class=3DMsoNormal>#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; sed -i =
&quot;s^-L/home/USER/work/LTTNG/sysroot/usr/local/lib =
/usr/local/lib^-L/home/USER/work/LTTNG/sysroot/usr/local/lib =
/home/USER/work/LTTNG/sysroot/usr/local/lib^&quot; =
${FILE}<o:p></o:p></p><p class=3DMsoNormal>#done<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>what=3Dlttng_tools<o:p></o:p></p><p =
class=3DMsoNormal>url=3Dgit://git.lttng.org/lttng-tools.git<o:p></o:p></p=
><p class=3DMsoNormal>EXTRA_CONF=3D&quot;--disable-maintainer-mode =
--disable-man-pages --disable-static =
--with-sessiond-bin=3D/mnt/sd1/modulesLTTNG/lttng/usr/local/bin/lttng-ses=
siond&quot;<o:p></o:p></p><p =
class=3DMsoNormal>COPY_MAKEFILE=3D&quot;${BASEDIR}/builds/lttng-tools/tes=
ts/Makefile&quot;<o:p></o:p></p><p class=3DMsoNormal>get_em_git $url =
&quot;$what&quot; =
true&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; <o:p></o:p></p><p class=3DMsoNormal>unset =
COPY_MAKEFILE<o:p></o:p></p><p class=3DMsoNormal>unset =
EXTRA_CONF<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>what=3Dlttng_modules<o:p></o:p></p><p =
class=3DMsoNormal>url=3Dgit://git.lttng.org/lttng-modules.git<o:p></o:p><=
/p><p class=3DMsoNormal>init &quot;$what&quot;<o:p></o:p></p><p =
class=3DMsoNormal>filename=3D$(basename $url)&nbsp;&nbsp; =
<o:p></o:p></p><p =
class=3DMsoNormal>filename=3D${filename/.git}<o:p></o:p></p><p =
class=3DMsoNormal>download_git &quot;$url&quot; &quot;$what&quot; =
$filename $state<o:p></o:p></p><p class=3DMsoNormal>if [ $state -eq =
$step_compile ] ; then<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; echo &quot;&gt;&gt; $what is =
already compiled&quot;<o:p></o:p></p><p =
class=3DMsoNormal>else<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; #dir_name=3D$(get_src_dir =
$filename)<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; pushd =
$G_SOURCES_DIR/$filename<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; make ARCH=3D$G_ARCH =
CROSS_COMPILE=3D$G_CROSS_COMPILE KERNELDIR=3D$G_KERNELDIR -j4 =
\<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; &amp;&amp; make =
ARCH=3D$G_ARCH CROSS_COMPILE=3D$G_CROSS_COMPILE KERNELDIR=3D$G_KERNELDIR =
INSTALL_MOD_PATH=3D${SYSROOT} modules_install \<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; =
echo &quot;$what=3D$step_compile&quot; &gt;&gt; =
$G_CFG_FILE<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
popd<o:p></o:p></p><p class=3DMsoNormal>fi<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>echo<o:p></o:p></p><p class=3DMsoNormal>echo =
&quot;INFO: the build progress for all packages is tracked in =
$G_CFG_FILE&quot;<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_000B_01D762CF.81BEDAC0--



--===============4715336618880944799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4715336618880944799==--


