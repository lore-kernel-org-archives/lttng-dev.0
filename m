Return-Path: <SRS0=MOqf=OU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74CBC433EF
	for <lttng-dev@archiver.kernel.org>; Thu, 30 Sep 2021 13:15:09 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296B861278
	for <lttng-dev@archiver.kernel.org>; Thu, 30 Sep 2021 13:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 296B861278
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4HKtyM2YkNz1H9p;
	Thu, 30 Sep 2021 09:15:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1633007708;
	bh=t0dgbCUyGEALfQIstEtF8flEECi227IBZgrJ0sV0Rw8=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=PDljK7KAJtHUtLUnD+X7OjDbS1xnUZlraGaFOzqMkI/D6RIEWYgDavUScKPP7kqrI
	 dr+9xlI+H8VeavT6t+vFKIBYCOtJB1FtUP8rYfXFsFpLiJpjCsTaZvYAWddXYG5/zC
	 TSoReezcKdUoTne5T97btT7pqGQn3FzWPWmYCOsf2B6miE4GMFZzX92jHBXLX3hQr9
	 LEtwmy0emv/OFtoJ7LIYTheGeeScuh9t2zBgiWkJy+8GfV6IeUVCu3fp67qAbgUz9g
	 T+bQwX/rA47PKO9lAsi5QMNb0eqvCbr7SS4hJ1zBfgBy1qsSuVByJvhqNfrv5ZmZla
	 nO44IOykcDJMA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4HKtyJ6MTKz1H9m
 for <lttng-dev@lists.lttng.org>; Thu, 30 Sep 2021 09:15:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6500F37BADE
 for <lttng-dev@lists.lttng.org>; Thu, 30 Sep 2021 09:14:58 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id cv4FAJwJ7kMh; Thu, 30 Sep 2021 09:14:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4AC9937BADB;
 Thu, 30 Sep 2021 09:14:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4AC9937BADB
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 8R4DGx3cdzkq; Thu, 30 Sep 2021 09:14:57 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 3685137BD8F;
 Thu, 30 Sep 2021 09:14:57 -0400 (EDT)
Date: Thu, 30 Sep 2021 09:14:57 -0400 (EDT)
To: Changqing Li <changqing.li@windriver.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <613136200.45770.1633007697070.JavaMail.zimbra@efficios.com>
In-Reply-To: <0c4c0d31-5551-b84a-386c-32990b128f09@windriver.com>
References: <0c4c0d31-5551-b84a-386c-32990b128f09@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - FF92 (Linux)/8.8.15_GA_4059)
Thread-Topic: with -Og option, lttng-ust compile failed on 32bit arm
Thread-Index: 1iCUY+RmQvxO8m3bXNgDlsEsOQj9Ag==
Subject: Re: [lttng-dev] with -Og option,
 lttng-ust compile failed on 32bit arm
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: multipart/mixed; boundary="===============9097924945924341271=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============9097924945924341271==
Content-Type: multipart/alternative; 
	boundary="=_1797865e-b62f-4b27-8bc2-9ce2d0f1a314"

--=_1797865e-b62f-4b27-8bc2-9ce2d0f1a314
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Sep 29, 2021, at 11:47 PM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> Hi,

> The problem happened after upgrade to lttng-ust 2.13.0. 2.12.0 don't have this
> issue.

> liburcu version: 0.13.0

> gcc: 11.2.0

> This is my reproduce steps, it is cross compile enviroment based on yocto
> project.

>     1. git clone git://git.yoctoproject.org/poky
>     2. . oe-init-build-env
>     3. echo "MACHINE='qemuarm'" >> conf/local.conf
>     4. echo "DEBUG_BUILD='1'" >> conf/local.conf
>     5. bitbake lttng-ust

> compile failed with error:

>| /work/cortexa15t2hf-neon-poky-linux-gnueabi/lttng-ust/2_2.13.0-r0/recipe-sysroot-native/usr/bin/arm-poky-linux-gnueabi/../../libexec/arm-poky-linux-gnueabi/gcc/arm-poky-linux-gnueabi/11.2.0/ld:
>| ../../../src/lib/lttng-ust/.libs/liblttng-ust.so: undefined reference to
> | `_uatomic_link_error'
> | collect2: error: ld returned 1 exit status
> | Makefile:399: recipe for target 'test_ust_error' failed

> checked with "nm ../../../src/lib/lttng-ust/.libs/liblttng-ust.so" | grep
> atomic, we can see 'U _uatomic_link_error', but since -Og

> is used, liburcu don't define this function.

> [snip]
> #if !defined __OPTIMIZE__ || defined UATOMIC_NO_LINK_ERROR
> static inline __attribute__((always_inline, noreturn))
> void _uatomic_link_error(void)
> {
> #ifdef ILLEGAL_INSTR
> /*
> * generate an illegal instruction. Cannot catch this with
> * linker tricks when optimizations are disabled.
> */
> __asm__ __volatile__(ILLEGAL_INSTR);
> #else
> __builtin_trap();
> #endif
> }
> #else /* #if !defined __OPTIMIZE__ || defined UATOMIC_NO_LINK_ERROR */
> extern void _uatomic_link_error(void);
> #endif /* #else #if !defined __OPTIMIZE__ || defined UATOMIC_NO_LINK_ERROR */

> [snip]

> we cannot see 'U _uatomic_link_error' in following conditions, so compile
> successed:

> 1. without -Og(using -O2), + 32bit arm

> 2. -Og + 64bit arm

> 3. -Og + x86/x86-64

> Do you have any idea about how to fix this? I don't understand why only "-Og +
> 32bit arm" will call function _uatomic_link_error.
I suspect it depends on which optimizations are being enabled at -Og on each architecture. 
The "_uatomic_link_error()" trick indeed depends on the compiler optimizing away 
unreachable calls. 

If you really intend on using "-Og" on arm32, trying building with "-DUATOMIC_NO_LINK_ERROR". 
It should take care of making sure to generate an illegal instruction rather than rely on the linker 
error. 

Thanks, 

Mathieu 

> Thanks

> //Changqing

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_1797865e-b62f-4b27-8bc2-9ce2d0f1a314
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Sep 29, 2021, at 11:47 PM, lttng-dev &lt;lttng-dev@lists.lttng=
.org&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><block=
quote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5=
px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fon=
t-family:Helvetica,Arial,sans-serif;font-size:12pt;"><p>Hi, <br>
    </p>
    <p>The problem happened after upgrade to lttng-ust 2.13.0.&nbsp; 2.12.0
      don't have this issue.</p>
    <p>liburcu version: 0.13.0</p>
    <p>gcc: 11.2.0<br>
      <br>
    </p>
    <p>This is my reproduce steps, it is cross compile enviroment based
      on yocto project.<br>
    </p>
    <ol><li>git clone git://git.yoctoproject.org/poky</li><li>. oe-init-bui=
ld-env</li><li>echo "MACHINE=3D'qemuarm'" &gt;&gt; conf/local.conf</li><li>=
echo "DEBUG_BUILD=3D'1'" &gt;&gt; conf/local.conf <br>
      </li><li>bitbake lttng-ust</li></ol>
    <p>compile failed with error:</p>
    <p>|
/work/cortexa15t2hf-neon-poky-linux-gnueabi/lttng-ust/2_2.13.0-r0/recipe-sy=
sroot-native/usr/bin/arm-poky-linux-gnueabi/../../libexec/arm-poky-linux-gn=
ueabi/gcc/arm-poky-linux-gnueabi/11.2.0/ld:
      ../../../src/lib/lttng-ust/.libs/liblttng-ust.so: undefined
      reference to `_uatomic_link_error'<br>
      | collect2: error: ld returned 1 exit status<br>
      | Makefile:399: recipe for target 'test_ust_error' failed</p>
    <p>checked with "nm
      ../../../src/lib/lttng-ust/.libs/liblttng-ust.so" | grep atomic,&nbsp=
;&nbsp;
      we can see 'U _uatomic_link_error',&nbsp; but since -Og <br>
    </p>
    <p>is used,&nbsp; liburcu don't define this function.</p>
    <p>[snip]<br>
      #if !defined __OPTIMIZE__&nbsp; || defined UATOMIC_NO_LINK_ERROR<br>
      static inline __attribute__((always_inline, noreturn))<br>
      void _uatomic_link_error(void)<br>
      {<br>
      #ifdef ILLEGAL_INSTR<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * generate an illega=
l instruction. Cannot catch this with<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * linker tricks when=
 optimizations are disabled.<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __asm__ __volatile__(ILLEG=
AL_INSTR);<br>
      #else<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __builtin_trap();<br>
      #endif<br>
      }<br>
      #else /* #if !defined __OPTIMIZE__&nbsp; || defined
      UATOMIC_NO_LINK_ERROR */<br>
      extern void _uatomic_link_error(void);<br>
      #endif /* #else #if !defined __OPTIMIZE__&nbsp; || defined
      UATOMIC_NO_LINK_ERROR */<br>
    </p>
    <p>[snip]<br>
    </p>
    <p>we cannot see 'U _uatomic_link_error' in following conditions, so
      compile successed:</p>
    <p>1.&nbsp; without -Og(using -O2),&nbsp; + 32bit arm</p>
    <p>2. -Og + 64bit arm</p>
    <p>3. -Og + x86/x86-64</p>
    <p><br>
    </p>
    <p>Do you have any idea about how to fix this? I don't understand
      why only "-Og + 32bit arm" will call function _uatomic_link_error.</p=
></blockquote><div><br></div><div>I suspect it depends on which optimizatio=
ns are being enabled at -Og on each architecture.<br data-mce-bogus=3D"1"><=
/div><div>The "_uatomic_link_error()" trick indeed depends on the compiler =
optimizing away<br data-mce-bogus=3D"1"></div><div>unreachable calls.<br da=
ta-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>If you re=
ally intend on using "-Og" on arm32, trying building with "-DUATOMIC_NO_LIN=
K_ERROR".<br data-mce-bogus=3D"1"></div><div>It should take care of making =
sure to generate an illegal instruction rather than rely on the linker<br d=
ata-mce-bogus=3D"1"></div><div>error.<br data-mce-bogus=3D"1"></div><div><b=
r data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><di=
v><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div=
><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px s=
olid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal=
;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-se=
rif;font-size:12pt;">
    <p>Thanks</p>
    <p>//Changqing<br>
    </p>
 =20
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_1797865e-b62f-4b27-8bc2-9ce2d0f1a314--

--===============9097924945924341271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============9097924945924341271==--
