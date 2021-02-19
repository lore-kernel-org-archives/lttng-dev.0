Return-Path: <SRS0=UQx0=HV=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_SHORTFWD_URISHRT_QP,SPF_HELO_NONE,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF83C433E0
	for <lttng-dev@archiver.kernel.org>; Fri, 19 Feb 2021 22:46:13 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEDD564DF0
	for <lttng-dev@archiver.kernel.org>; Fri, 19 Feb 2021 22:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDD564DF0
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Dj6BC05j3z2sK;
	Fri, 19 Feb 2021 17:46:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1613774772;
	bh=NhPFPFJ/QeGgGuGb6LgChZg1dPh1ZJHCGNLKsygqctU=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=OORDHh2KjQNE7oHqeHEktCRPagdybmwfVGHlY0vxuDAdseRzIAkGitTB44sLbXcSn
	 ei3GSVJtiAkyF0eFFYoMuPEUZRu/er71P/ddwsr2bjt+L8sAU9DUIXipAPIxCHFD4y
	 ocTt425JVGjEPGVaYqbCH3w5ZirIBF4ikQJie86vWlUPNasdOg6b5N0MOuguNqnEN0
	 2HYjASfHETRpVRjlDBFfJx0WJs9AhxG6Is+HXcLroI5xhdYqz+B6G+5tYVU/3jc/vJ
	 v9wkvsLBRPW5Bh4s+dt95XgK2GMh6zuhetA2s0PIScYqn7lE+KOR1zFEaNpXWEbBCX
	 d3GOcUNu67W7Q==
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by lists.lttng.org (Postfix) with ESMTPS id 4Dj6B92bmRz2xb
 for <lttng-dev@lists.lttng.org>; Fri, 19 Feb 2021 17:46:09 -0500 (EST)
Received: by mail-pg1-x529.google.com with SMTP id b21so6000344pgk.7
 for <lttng-dev@lists.lttng.org>; Fri, 19 Feb 2021 14:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=52ALP2r924gZbSIb37FOGwZ91Qhaq6ngiQqSuIvBKrQ=;
 b=R78fYHxETxYsXPGpZTcNWOQfShD32RRgFYJjaNlWbEfzgH1OQBpCn4ztWnLq1f5oBm
 SxRKDJHiaPTd41Us1XjE/1EEjElbK/rFtsADRD+ZmvpzC5jX9CRVRH7AO/w62Q1soQfx
 4n/6yce8tlQIjB0GXQNsT/BFTXsf5MNW7Oc+3hwGWeANkK3Txkt8PsZpiAPy1Z+s/h+l
 o8v1Fw1iNldIkZlqKkOuMc1TEdLDj5fK6raydYkPttspBH/SRzkKz4WBapW4oXAF5Fdy
 xdf3d6mljCrvCK1AuGxa/Vbtk87hF27BcsC3ITqPCiLsz1IRAqmkUVWXmvWEeNSEIE3W
 ukCw==
X-Gm-Message-State: AOAM532SdMmZgffgtAxNX6yGLtHis4j882CGocpgYqgcDxPbMOfSfbyo
 Z5YsL+jvkYqzzMRNgq4KyokpXSWfE2dy5W/Qtps=
X-Google-Smtp-Source: ABdhPJyO9HflF6rsYCC9Wd22hefdH28aHnIev+MgwcSpcnMQMpjf65WWU7ltF3LpzLLwctjvYGdqRBrmvlEIvnnxeBk=
X-Received: by 2002:a65:47cc:: with SMTP id f12mr9445139pgs.305.1613774768042; 
 Fri, 19 Feb 2021 14:46:08 -0800 (PST)
MIME-Version: 1.0
References: <CABB28Cy1yzw7DGMO2Hoi83pQbEPr521YTWszO7LbgkQ8OXFAOQ@mail.gmail.com>
 <CABB28Cxfnmj7FyRTRJdgOJJ6UdSmf8Nd7ZeDt2CF_7FQMQhsVA@mail.gmail.com>
 <846525289.26662.1613658859303.JavaMail.zimbra@efficios.com>
 <CABB28Cy=1q3nEkW_zZheovzX5Lfa6f3HMO940mEHTE4QY7RYZw@mail.gmail.com>
 <1530611207.28274.1613762411148.JavaMail.zimbra@efficios.com>
In-Reply-To: <1530611207.28274.1613762411148.JavaMail.zimbra@efficios.com>
Date: Fri, 19 Feb 2021 22:45:43 +0000
Message-ID: <CABB28CxNRFk2tDkNUjCFaeOxDUyp=m-FOtvekTzmvG7LguxeRQ@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-dev] userspace-rcu 0.12.2: build fails
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
From: =?utf-8?q?Tomasz_K=C5=82oczko_via_lttng-dev?= <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?Q?Tomasz_K=C5=82oczko?= <kloczko.tomasz@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: multipart/mixed; boundary="===============6425487541814789592=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6425487541814789592==
Content-Type: multipart/alternative; boundary="000000000000cbf57c05bbb8371a"

--000000000000cbf57c05bbb8371a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Feb 2021 at 19:20, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:
[..]

> Good to know. This does not provide any clarification on your build
> environment
> though (see my request above). Therefore we cannot attempt to reproduce o=
n
> our side yet.
>

I'm building on top of my own distribution which is quite close to fedora
rawhide (with tons of fixes) however before starting actual build I'm
regenerating all ac/am/lt files using "autoreconf -fiv" because I'm
patching configiure.ac and some Makefile.am files.
I need that because 1.2.2 has underlinkig issues.
Here is the patch which fixes underlinking:
```
--- a/src/Makefile.am~  2021-02-17 19:52:04.000000000 +0000
+++ b/src/Makefile.am   2021-02-18 01:19:04.366349148 +0000
@@ -34,7 +34,7 @@

 liburcu_la_SOURCES =3D urcu.c urcu-pointer.c $(COMPAT)
 liburcu_la_CFLAGS =3D -DRCU_MEMBARRIER $(AM_CFLAGS)
-liburcu_la_LIBADD =3D liburcu-common.la
+liburcu_la_LIBADD =3D liburcu-common.la $(PTHREAD_LIBS)

 liburcu_memb_la_SOURCES =3D urcu.c urcu-pointer.c $(COMPAT)
 liburcu_memb_la_CFLAGS =3D -DRCU_MEMBARRIER $(AM_CFLAGS)
@@ -42,22 +42,22 @@

 liburcu_qsbr_la_SOURCES =3D urcu-qsbr.c urcu-pointer.c $(COMPAT)
 liburcu_qsbr_la_CFLAGS =3D -DRCU_QSBR $(AM_CFLAGS)
-liburcu_qsbr_la_LIBADD =3D liburcu-common.la
+liburcu_qsbr_la_LIBADD =3D liburcu-common.la $(PTHREAD_LIBS)

 liburcu_mb_la_SOURCES =3D urcu.c urcu-pointer.c $(COMPAT)
 liburcu_mb_la_CFLAGS =3D -DRCU_MB $(AM_CFLAGS)
-liburcu_mb_la_LIBADD =3D liburcu-common.la
+liburcu_mb_la_LIBADD =3D liburcu-common.la $(PTHREAD_LIBS)

 liburcu_signal_la_SOURCES =3D urcu.c urcu-pointer.c $(COMPAT)
 liburcu_signal_la_CFLAGS =3D -DRCU_SIGNAL $(AM_CFLAGS)
-liburcu_signal_la_LIBADD =3D liburcu-common.la
+liburcu_signal_la_LIBADD =3D liburcu-common.la $(PTHREAD_LIBS)

 liburcu_bp_la_SOURCES =3D urcu-bp.c urcu-pointer.c $(COMPAT)
-liburcu_bp_la_LIBADD =3D liburcu-common.la
+liburcu_bp_la_LIBADD =3D liburcu-common.la $(PTHREAD_LIBS)

 liburcu_cds_la_SOURCES =3D rculfqueue.c rculfstack.c lfstack.c \
        workqueue.c workqueue.h $(RCULFHASH) $(COMPAT)
-liburcu_cds_la_LIBADD =3D liburcu-common.la
+liburcu_cds_la_LIBADD =3D liburcu-common.la $(PTHREAD_LIBS)

 pkgconfigdir =3D $(libdir)/pkgconfig
 pkgconfig_DATA =3D liburcu-cds.pc liburcu.pc liburcu-bp.pc liburcu-qsbr.pc=
 \
```
Without that patch build fails on:
```
make[5]: Entering directory
'/home/tkloczko/rpmbuild/BUILD/userspace-rcu-0.12.2/doc/examples/hlist'
+ /usr/bin/gcc -g -O2 -Wall -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone
-L../../../src/.libs/ -Wl,-rpath
/home/tkloczko/rpmbuild/BUILD/userspace-rcu-0.12.2/doc/examples/../../src/.=
libs/
-Wl,-z,relro -Wl,--as-needed -Wl,--gc-sections -Wl,-z,now
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-ld -flto=3Dauto
-flto-partition=3Dnone -fuse-linker-plugin -o cds_hlist_add_head_rcu
cds_hlist_add_head_rcu.o -lurcu
/usr/bin/ld: ../../../src/.libs//liburcu.so: undefined reference to
`pthread_join'
/usr/bin/ld: ../../../src/.libs//liburcu.so: undefined reference to
`pthread_create'
collect2: error: ld returned 1 exit status
```

I must apologise. I made small mistake in my other patch which removes from
configiure.ac amd all Makefile.am files hadcoding all -W<foo> and -g flags
(I want to control such things completely from outside the build framework
over CFLAGS and other env variables).

After fixing that patch looks like 1.2.2 builds correctly however that
underlinking issue is real.

One more time sorry .. kind of my fault :/

kloczek
--=20
Tomasz K=C5=82oczko | LinkedIn: http://lnkd.in/FXPWxH

--000000000000cbf57c05bbb8371a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace"><span style=3D"font-family:Arial,Helvetica,sa=
ns-serif">On Fri, 19 Feb 2021 at 19:20, Mathieu Desnoyers &lt;<a href=3D"ma=
ilto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;=
 wrote:</span><br></div></div><div class=3D"gmail_quote"><div class=3D"gmai=
l_default" style=3D"font-family:monospace,monospace">[..]</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Good to know. This does not provide a=
ny clarification on your build environment<br>
though (see my request above). Therefore we cannot attempt to reproduce on =
our side yet.<br></blockquote><div><br></div><div class=3D"gmail_default" s=
tyle=3D"font-family:monospace,monospace">I&#39;m building on top of my own =
distribution which is quite close to fedora rawhide (with tons of fixes) ho=
wever before starting actual build I&#39;m regenerating all ac/am/lt files =
using &quot;autoreconf -fiv&quot; because I&#39;m patching <a href=3D"http:=
//configiure.ac">configiure.ac</a> and some Makefile.am files.</div><div cl=
ass=3D"gmail_default" style=3D"font-family:monospace,monospace">I need that=
 because 1.2.2 has underlinkig issues.</div><div class=3D"gmail_default" st=
yle=3D"font-family:monospace,monospace">Here is the patch which=C2=A0fixes =
underlinking:</div><div class=3D"gmail_default" style=3D"font-family:monosp=
ace,monospace">```</div><div class=3D"gmail_default" style=3D"font-family:m=
onospace,monospace">--- a/src/Makefile.am~ =C2=A02021-02-17 19:52:04.000000=
000 +0000<br>+++ b/src/Makefile.am =C2=A0 2021-02-18 01:19:04.366349148 +00=
00<br>@@ -34,7 +34,7 @@<br><br>=C2=A0liburcu_la_SOURCES =3D urcu.c urcu-poi=
nter.c $(COMPAT)<br>=C2=A0liburcu_la_CFLAGS =3D -DRCU_MEMBARRIER $(AM_CFLAG=
S)<br>-liburcu_la_LIBADD =3D <a href=3D"http://liburcu-common.la">liburcu-c=
ommon.la</a><br>+liburcu_la_LIBADD =3D <a href=3D"http://liburcu-common.la"=
>liburcu-common.la</a> $(PTHREAD_LIBS)<br><br>=C2=A0liburcu_memb_la_SOURCES=
 =3D urcu.c urcu-pointer.c $(COMPAT)<br>=C2=A0liburcu_memb_la_CFLAGS =3D -D=
RCU_MEMBARRIER $(AM_CFLAGS)<br>@@ -42,22 +42,22 @@<br><br>=C2=A0liburcu_qsb=
r_la_SOURCES =3D urcu-qsbr.c urcu-pointer.c $(COMPAT)<br>=C2=A0liburcu_qsbr=
_la_CFLAGS =3D -DRCU_QSBR $(AM_CFLAGS)<br>-liburcu_qsbr_la_LIBADD =3D <a hr=
ef=3D"http://liburcu-common.la">liburcu-common.la</a><br>+liburcu_qsbr_la_L=
IBADD =3D <a href=3D"http://liburcu-common.la">liburcu-common.la</a> $(PTHR=
EAD_LIBS)<br><br>=C2=A0liburcu_mb_la_SOURCES =3D urcu.c urcu-pointer.c $(CO=
MPAT)<br>=C2=A0liburcu_mb_la_CFLAGS =3D -DRCU_MB $(AM_CFLAGS)<br>-liburcu_m=
b_la_LIBADD =3D <a href=3D"http://liburcu-common.la">liburcu-common.la</a><=
br>+liburcu_mb_la_LIBADD =3D <a href=3D"http://liburcu-common.la">liburcu-c=
ommon.la</a> $(PTHREAD_LIBS)<br><br>=C2=A0liburcu_signal_la_SOURCES =3D urc=
u.c urcu-pointer.c $(COMPAT)<br>=C2=A0liburcu_signal_la_CFLAGS =3D -DRCU_SI=
GNAL $(AM_CFLAGS)<br>-liburcu_signal_la_LIBADD =3D <a href=3D"http://liburc=
u-common.la">liburcu-common.la</a><br>+liburcu_signal_la_LIBADD =3D <a href=
=3D"http://liburcu-common.la">liburcu-common.la</a> $(PTHREAD_LIBS)<br><br>=
=C2=A0liburcu_bp_la_SOURCES =3D urcu-bp.c urcu-pointer.c $(COMPAT)<br>-libu=
rcu_bp_la_LIBADD =3D <a href=3D"http://liburcu-common.la">liburcu-common.la=
</a><br>+liburcu_bp_la_LIBADD =3D <a href=3D"http://liburcu-common.la">libu=
rcu-common.la</a> $(PTHREAD_LIBS)<br><br>=C2=A0liburcu_cds_la_SOURCES =3D r=
culfqueue.c rculfstack.c lfstack.c \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 workque=
ue.c workqueue.h $(RCULFHASH) $(COMPAT)<br>-liburcu_cds_la_LIBADD =3D <a hr=
ef=3D"http://liburcu-common.la">liburcu-common.la</a><br>+liburcu_cds_la_LI=
BADD =3D <a href=3D"http://liburcu-common.la">liburcu-common.la</a> $(PTHRE=
AD_LIBS)<br><br>=C2=A0pkgconfigdir =3D $(libdir)/pkgconfig<br>=C2=A0pkgconf=
ig_DATA =3D liburcu-cds.pc liburcu.pc liburcu-bp.pc liburcu-qsbr.pc \<br></=
div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace">=
```</div><div class=3D"gmail_default" style=3D"font-family:monospace,monosp=
ace">Without that patch build fails on:</div><div class=3D"gmail_default" s=
tyle=3D"font-family:monospace,monospace">```</div><div class=3D"gmail_defau=
lt" style=3D"font-family:monospace,monospace">make[5]: Entering directory &=
#39;/home/tkloczko/rpmbuild/BUILD/userspace-rcu-0.12.2/doc/examples/hlist&#=
39;<br>+ /usr/bin/gcc -g -O2 -Wall -O2 -g -grecord-gcc-switches -pipe -Wall=
 -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTI=
ONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-stro=
ng -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -f=
asynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fdata-=
sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -L../../..=
/src/.libs/ -Wl,-rpath /home/tkloczko/rpmbuild/BUILD/userspace-rcu-0.12.2/d=
oc/examples/../../src/.libs/ -Wl,-z,relro -Wl,--as-needed -Wl,--gc-sections=
 -Wl,-z,now -specs=3D/usr/lib/rpm/redhat/redhat-hardened-ld -flto=3Dauto -f=
lto-partition=3Dnone -fuse-linker-plugin -o cds_hlist_add_head_rcu cds_hlis=
t_add_head_rcu.o -lurcu<br>/usr/bin/ld: ../../../src/.libs//liburcu.so: und=
efined reference to `pthread_join&#39;<br>/usr/bin/ld: ../../../src/.libs//=
liburcu.so: undefined reference to `pthread_create&#39;<br>collect2: error:=
 ld returned 1 exit status</div><div class=3D"gmail_default" style=3D"font-=
family:monospace,monospace">```<br></div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace"><br></div><div class=3D"gmail_default"=
 style=3D"font-family:monospace,monospace">I must apologise. I made small m=
istake in my other patch which removes from <a href=3D"http://configiure.ac=
">configiure.ac</a> amd all Makefile.am files hadcoding=C2=A0all -W&lt;foo&=
gt; and -g flags (I want to control=C2=A0such things completely=C2=A0from o=
utside the build framework over CFLAGS and other=C2=A0env variables).</div>=
<div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><br>=
</div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace=
">After fixing that patch looks like 1.2.2 builds correctly however that un=
derlinking issue is real.</div><div class=3D"gmail_default" style=3D"font-f=
amily:monospace,monospace"><br></div><div class=3D"gmail_default" style=3D"=
font-family:monospace,monospace">One more time sorry .. kind of my fault :/=
</div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace=
"><br></div><div class=3D"gmail_default" style=3D"font-family:monospace,mon=
ospace">kloczek</div><div><div dir=3D"ltr" class=3D"gmail_signature"><div d=
ir=3D"ltr"><div dir=3D"ltr"><font face=3D"monospace, monospace">--=C2=A0</f=
ont></div></div></div></div><div class=3D"gmail_default" style=3D"font-fami=
ly:monospace,monospace">Tomasz K=C5=82oczko | LinkedIn:=C2=A0<span style=3D=
"text-decoration-line:underline;font-size:13px;background-color:transparent=
;vertical-align:baseline;white-space:pre-wrap"><a href=3D"http://lnkd.in/FX=
PWxH" target=3D"_blank" style=3D"text-decoration-line:none">http://lnkd.in/=
FXPWxH</a></span></div></div></div>

--000000000000cbf57c05bbb8371a--

--===============6425487541814789592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6425487541814789592==--
