Return-Path: <SRS0=6RGT=GS=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4F1C433E0
	for <lttng-dev@archiver.kernel.org>; Fri, 15 Jan 2021 19:18:56 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E043B235F8
	for <lttng-dev@archiver.kernel.org>; Fri, 15 Jan 2021 19:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E043B235F8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DHWFB01qXzRvF;
	Fri, 15 Jan 2021 14:18:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1610738334;
	bh=fUa4hXuTmtV15DGNlrSTJGe4m+xG0AgM0izp6rF435s=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=HunW0us+hDKCm9xVFAQ2AeZtSZz/AMnkCzvZ8jGL3T8RrwiMwTHSopcQ4W/EIkrvC
	 XoC3ot2tSp46U4i6Y44RlD0KJJ1UXqATyv0BHILJ7CeaiJP/2IcMIWQ3Mif6Z/hqQC
	 F70A09fXrYHlzVdYbB1XtIbYifk1v8M2mwax9d84UMrR8ItSardWZy0iOMQYgBvD5e
	 oM9NINo44rS7LyvHQIQEwjWYUzJWcWjNVt3EJCBCY8w9eygWIwA33TIXo6O8FIZpVF
	 9IdfJA+x5uV45UC5o+WOXPutMWnM1flBkPs1eTJqyW2nAhyAUuywIOuEMvlOEsk35K
	 uJ4Lv76XE2byw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DHWF853f5zRj1
 for <lttng-dev@lists.lttng.org>; Fri, 15 Jan 2021 14:18:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3D0022EF2E1
 for <lttng-dev@lists.lttng.org>; Fri, 15 Jan 2021 14:18:46 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 2Cj7lTsMEyKX; Fri, 15 Jan 2021 14:18:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9AFB12EF2E0;
 Fri, 15 Jan 2021 14:18:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9AFB12EF2E0
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id LCka7CyscKFz; Fri, 15 Jan 2021 14:18:45 -0500 (EST)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id 45F122EF42C;
 Fri, 15 Jan 2021 14:18:45 -0500 (EST)
Date: Fri, 15 Jan 2021 14:18:41 -0500
To: "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20210115191841.GA3115961@joraj-alpa>
References: <BYAPR11MB263254ABB57F458031AB33DBFFD50@BYAPR11MB2632.namprd11.prod.outlook.com>
 <BYAPR11MB2632B3DA9B535943CEE08A73FFD00@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210106150309.GA227614@joraj-alpa>
 <BYAPR11MB2632B5DE22E2561F0B018909FFAF0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210107165408.GC227614@joraj-alpa>
 <BYAPR11MB2632B7E0BD848485746A80AFFFAE0@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <BYAPR11MB2632B7E0BD848485746A80AFFFAE0@BYAPR11MB2632.namprd11.prod.outlook.com>
Subject: Re: [lttng-dev] 
 =?utf-8?b?5Zue5aSNOiDlm57lpI06IGhlbHAgbW9kcG9zdDog?=
 =?utf-8?b?Il9fYmFkX2NtcHhjaGci?=
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Quiang,

Please test the attached patch.

Cheers

On Sat, Jan 09, 2021 at 05:40:48AM +0000, Zhang, Qiang wrote:
>=20
>=20
> ________________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Jonathan Rajotte-Julien <jonathan.rajotte-ju=
lien@efficios.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2021=E5=B9=B41=E6=9C=888=E6=97=A5 0=
:54
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Zhang, Qiang
> =E6=8A=84=E9=80=81: lttng-dev
> =E4=B8=BB=E9=A2=98: Re: =E5=9B=9E=E5=A4=8D: help modpost: "__bad_cmpxchg"
>=20
> [Please note this e-mail is from an EXTERNAL e-mail address]
>=20
> >Hi,
> >
> >Note
> >  The initial email was sent to the "owner" of the mailing list. Please
> >  *always* send email to the mailing list directly: lttng->dev@lists.ltt=
ng.org .
> > Otherwise we will not be interested in helping you in the future.
> >
> >Sorry forgot to ask you the following.
> >
> >What is the arm CPU you are compiling against? The more details the >mor=
e we can
> >help here.
> >
> >Please provide the .config file for the kernel (via pastebin please) and=
 >the
> =20
>  Hello
>=20
>  Attached is the kernel configuration file
>  and compiler configuration file.
>=20
>  bsp is xilinx-zynq (arm32, armv7),  v5.10 kernel have delete=20
>  'CONFIG_OPTIMIZE_INLINING'  config option.=20
>=20
>  Cheers
>=20
> >compiler used. Mathieu Desnoyers (CompuDJ) might have a lead >regarding =
cmpxchg
> >and __bad_cmpxchg linker error trick used by the implementation and >the
> >optimized inlining config option (CONFIG_OPTIMIZE_INLINING).
> >
> >These should help us validate this lead.
>=20
> >
> >Cheers
> >
> >On Thu, Jan 07, 2021 at 01:20:54AM +0000, Zhang, Qiang wrote:
> >
> >
> > ________________________________________
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Jonathan Rajotte-Julien <jonathan.rajotte-=
julien@efficios.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2021=E5=B9=B41=E6=9C=886=E6=97=A5=
 23:03
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Zhang, Qiang
> > =E6=8A=84=E9=80=81: lttng-dev-owner@lists.lttng.org
> > =E4=B8=BB=E9=A2=98: Re: help modpost: "__bad_cmpxchg"
> >
> > [Please note this e-mail is from an EXTERNAL e-mail address]
> >
> > >Hi,
> > >
> > >What the kernel version are you compiling against?
> >
> >
> >    kernel version 5.10.2
> >    lttng-modules master branch commit :
> >    61e631e93e512b636ea6d52796bcce1c485a551b
> >
> >     Cheers
> >
> > >
> > >Cheers
> > >
> > >On Wed, Jan 06, 2021 at 05:20:06AM +0000, Zhang, Qiang wrote:
> > >
> > >
> > > The following error occurred when I compiled lttng modules under armv=
7 architecture
> > >
> > > ERROR: modpost: "__bad_cmpxchg" [/buildarea1/OnDemand_CI_Build_World/=
build_dir/12251727-build_world/xilinx-zynq-standard-std-OE/build/tmp-glibc/=
work/xilinx_zynq-wrs-linux-gnueabi/lttng-modules/2.12.3+gitAUTOINC+61e631e9=
3e-r0/git/src/lttng-counter-client-percpu-64-modular.ko] undefined!
> > >
> > > ERROR: modpost: "__bad_cmpxchg" [/buildarea1/OnDemand_CI_Build_World/=
build_dir/12251727-build_world/xilinx-zynq-standard-std-OE/build/tmp-glibc/=
work/xilinx_zynq-wrs-linux-gnueabi/lttng-modules/2.12.3+gitAUTOINC+61e631e9=
3e-r0/git/src/lttng-counter-client-percpu-32-modular.ko] undefined!
> > >
> > > I find  under the condition of
> > >
> > > COUNTER_SIZE_32_BIT,  cmpxchg_local  function trigger error in counte=
r-api.h file.
> > >
> > > is cmpxchg_local is support in amv7?
> >
> > --
> > Jonathan Rajotte-Julien
> > EfficiOS
>=20
> --
> Jonathan Rajotte-Julien
> EfficiOS


> ./arm-wrs-linux-gnueabi-gcc -v
> Using built-in specs.
> COLLECT_GCC=3D./arm-wrs-linux-gnueabi-gcc
> COLLECT_LTO_WRAPPER=3D/buildarea1/qzhang2/jira/LINCD-3904/build/tmp-glibc=
/work/armv7at2hf-neon-wrs-linux-gnueabi/libgcc/10.2.0-r0/recipe-sysroot-nat=
ive/usr/bin/arm-wrs-linux-gnueabi/../../libexec/arm-wrs-linux-gnueabi/gcc/a=
rm-wrs-linux-gnueabi/10.2.0/lto-wrapper
> Target: arm-wrs-linux-gnueabi
> Configured with: ../../../../../../work-shared/gcc-10.2.0-r0/gcc-10.2.0/c=
onfigure --build=3Dx86_64-linux --host=3Dx86_64-linux --target=3Darm-wrs-li=
nux-gnueabi --prefix=3D/host-native/usr --exec_prefix=3D/host-native/usr --=
bindir=3D/host-native/usr/bin/arm-wrs-linux-gnueabi --sbindir=3D/host-nativ=
e/usr/bin/arm-wrs-linux-gnueabi --libexecdir=3D/host-native/usr/libexec/arm=
-wrs-linux-gnueabi --datadir=3D/host-native/usr/share --sysconfdir=3D/host-=
native/etc --sharedstatedir=3D/host-native/com --localstatedir=3D/host-nati=
ve/var --libdir=3D/host-native/usr/lib/arm-wrs-linux-gnueabi --includedir=
=3D/host-native/usr/include --oldincludedir=3D/host-native/usr/include --in=
fodir=3D/host-native/usr/share/info --mandir=3D/host-native/usr/share/man -=
-disable-silent-rules --disable-dependency-tracking --with-libtool-sysroot=
=3D/host-native --enable-clocale=3Dgeneric --with-gnu-ld --enable-shared --=
enable-languages=3Dc,c++ --enable-threads=3Dposix --disable-multilib --enab=
le-default-pie --enable-c99 --enable-long-long --enable-symvers=3Dgnu --ena=
ble-libstdcxx-pch --program-prefix=3Darm-wrs-linux-gnueabi- --without-local=
-prefix --disable-install-libiberty --disable-libssp --enable-libitm --enab=
le-lto --disable-bootstrap --with-system-zlib --with-linker-hash-style=3Dsy=
sv --enable-linker-build-id --with-ppl=3Dno --with-cloog=3Dno --enable-chec=
king=3Drelease --enable-cheaders=3Dc_global --without-isl --with-gxx-includ=
e-dir=3D/not/exist/usr/include/c++/10.2.0 --with-sysroot=3D/not/exist --wit=
h-build-sysroot=3D/host --enable-poison-system-directories --with-system-zl=
ib --disable-nls --with-glibc-version=3D2.28 --enable-initfini-array
> Thread model: posix
> Supported LTO compression algorithms: zlib
> gcc version 10.2.0 (GCC)=20
>=20


--=20
Jonathan Rajotte-Julien
EfficiOS

--bp/iNruPH9dso1Pn
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Fix-counter-api-always-inline-counter-add-function.patch"

From f08da105102561886a9d207c56b65dd89beb0de7 Mon Sep 17 00:00:00 2001
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Wed, 6 Jan 2021 15:07:01 -0500
Subject: [PATCH lttng-modules] Fix: counter-api: always inline counter add
 function

The counter add function uses cmpxchg() and cmpxchg_local() on 1, 2, 4,
and 8 bytes types.

In libcounter, the 8 bytes type is only supported on 64-bit
architectures, but the 1, 2, 4 byte type code is present for all
architectures, even though only the 4 byte code is currently used by
lttng-modules.

The ARM implementation of cmpxchg uses the "__bad_cmpxchg" linker error
to report use of cmpxchg on an unsupported size.

Considering that "inline" does not strictly mean always inline (depends
on CONFIG_OPTIMIZE_INLINING on some kernels, and does not mean forced
inlining in recent kernels), the compiler is free to generate a function
rather than perform inlining. If that happens, then the __bad_cmpxchg
linker error is generated even if the 1 and 2 bytes types are unused.

Therefore, use __always_inline for functions in counter-api.h to force
inlining, and therefore removal of unused code before linking, which is
required by this Linux kernel __bad_cmpxchg linker error trick.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Change-Id: I1adccd1382e71abc5880e0351d976b779245468a
Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 include/counter/counter-api.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/counter/counter-api.h b/include/counter/counter-api.h
index 12520445..fbc65818 100644
--- a/include/counter/counter-api.h
+++ b/include/counter/counter-api.h
@@ -20,7 +20,7 @@
 /*
  * Using unsigned arithmetic because overflow is defined.
  */
-static inline int __lttng_counter_add(const struct lib_counter_config *config,
+static __always_inline int __lttng_counter_add(const struct lib_counter_config *config,
 				       enum lib_counter_config_alloc alloc,
 				       enum lib_counter_config_sync sync,
 				       struct lib_counter *counter,
@@ -226,7 +226,7 @@ static inline int __lttng_counter_add(const struct lib_counter_config *config,
 	return 0;
 }
 
-static inline int __lttng_counter_add_percpu(const struct lib_counter_config *config,
+static __always_inline int __lttng_counter_add_percpu(const struct lib_counter_config *config,
 				     struct lib_counter *counter,
 				     const size_t *dimension_indexes, int64_t v)
 {
@@ -243,7 +243,7 @@ static inline int __lttng_counter_add_percpu(const struct lib_counter_config *co
 	return 0;
 }
 
-static inline int __lttng_counter_add_global(const struct lib_counter_config *config,
+static __always_inline int __lttng_counter_add_global(const struct lib_counter_config *config,
 				     struct lib_counter *counter,
 				     const size_t *dimension_indexes, int64_t v)
 {
@@ -251,7 +251,7 @@ static inline int __lttng_counter_add_global(const struct lib_counter_config *co
 				   dimension_indexes, v, NULL);
 }
 
-static inline int lttng_counter_add(const struct lib_counter_config *config,
+static __always_inline int lttng_counter_add(const struct lib_counter_config *config,
 				    struct lib_counter *counter,
 				    const size_t *dimension_indexes, int64_t v)
 {
@@ -266,14 +266,14 @@ static inline int lttng_counter_add(const struct lib_counter_config *config,
 	}
 }
 
-static inline int lttng_counter_inc(const struct lib_counter_config *config,
+static __always_inline int lttng_counter_inc(const struct lib_counter_config *config,
 				     struct lib_counter *counter,
 				     const size_t *dimension_indexes)
 {
 	return lttng_counter_add(config, counter, dimension_indexes, 1);
 }
 
-static inline int lttng_counter_dec(const struct lib_counter_config *config,
+static __always_inline int lttng_counter_dec(const struct lib_counter_config *config,
 				    struct lib_counter *counter,
 				    const size_t *dimension_indexes)
 {
-- 
2.25.1


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--bp/iNruPH9dso1Pn--
