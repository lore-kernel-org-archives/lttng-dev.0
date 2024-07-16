Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E70C3DA59
	for <lttng-dev@archiver.kernel.org>; Tue, 16 Jul 2024 19:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1721156495;
	bh=1n8LNyYoUY05hu91ZIvaDmiWelNsUY6bT1otlUbf6iA=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VX5m4Xi7XBp3rIac5hGYSt6i3cxpAUWhgxbj5tngA6IY3WmkDrVBQDYjpBVNC1Zbk
	 CjPgSAzXbpirXewXAi3TGIQaQScNujqn/yoaUNBKvbBCknF9AegG+7ExE0rzZZR+fG
	 2zXEg8hvwEitpR7TECaBg8yprAcPzwi9wS1tT7lS4MSRQspiExD5DqQq/+gJjiDnlF
	 /ELp/OdcfFxpyD6rPheyow6qsAMaBGLbpqFtQ2ZFxlOf10wnoP1bh2Ikpqh8lk/H6i
	 j5rvHqbT3BgVPdOuBZ14o6KdSLFFliiXxAmHk9jeNpj8nNFTcoryLdcmsw1QnRmDor
	 IGzqPGTkXTB+w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WNpML5NCFz11lx;
	Tue, 16 Jul 2024 15:01:34 -0400 (EDT)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by lists.lttng.org (Postfix) with ESMTPS id 4WNpMJ3N7Cz126H
 for <lttng-dev@lists.lttng.org>; Tue, 16 Jul 2024 15:01:32 -0400 (EDT)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fbc0a1494dso35532405ad.3
 for <lttng-dev@lists.lttng.org>; Tue, 16 Jul 2024 12:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721156491; x=1721761291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vGpZS1MpMFOweYWe61grn9CdDxZ6gkbDf3sv+krhvbs=;
 b=d6yXMtwLRNFSdrQMps7omG296rGZtk1bjWiDp3A/z+iIfi5bKqxFBdZiU9eK/MYSTC
 roLIfvkx3kGTOe76umY2v7ESBlN0bCMu0LXbhaY3iBDhz9XKStDv5osQ65PksbdWgIkV
 cLyqpd7QBYpWk1mpPgLJUvT0T/pn1eFiu6Zmgqa/Z4O700Yv629xZtWkjzsPBCQ3VwiO
 Cjz4UO4qyG7gbZ87GZ1mRCMuqqoTRWmw8ENrApeAYYEq+DZ/goraGoy26nQQ9fzHlWLu
 CRiXVsV3N/WoktuFooMm4OQoX2huHqtS4tIb0fDvGsHHCHK0Mx4G1KujyO9VA0XVDTf5
 rAXQ==
X-Gm-Message-State: AOJu0YzeFnhIchJFJElE/t+qoo3jUCnRPtMXLEwGJcN32BVQcLJNu3st
 2Ig4oQm63W5aph1SOyuoIaTrV0OYYM4VesbF9x0GPdBwRYhhB1ODdATKfExlFziYBwHGn+qu4UG
 /MKmzT3MmZg7ynTsLVYWxw0IAtVU=
X-Google-Smtp-Source: AGHT+IG9FtNsR6xCuQ/yPUjHxQJjBPOpVezCgL35GzmwJL78jR1wCDt72t/DNCDG7R4/bYZbo6am2BWcOKvIjlH5EHc=
X-Received: by 2002:a17:903:1110:b0:1fb:719a:28cc with SMTP id
 d9443c01a7336-1fc3cb37b6fmr29961925ad.18.1721156490778; Tue, 16 Jul 2024
 12:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHD10UjoaOjqZUH4j55Ra7zJ2HVRLOyk7xnjv+BjnJxs6rN6Aw@mail.gmail.com>
 <6deffa1d-4d46-4445-a510-a3aac271cc80@efficios.com>
In-Reply-To: <6deffa1d-4d46-4445-a510-a3aac271cc80@efficios.com>
Date: Tue, 16 Jul 2024 15:01:19 -0400
Message-ID: <CAHD10Ui_JkP9hRirGUvKBgHhWX48r26+M2_zTyOD_cMLnSDGCg@mail.gmail.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] loading modules with modprobe
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: =?utf-8?q?Fran=C3=A7ois_Belias_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?Q?Fran=C3=A7ois_Belias?= <beliasossim@gmail.com>
Content-Type: multipart/mixed; boundary="===============5970068450124397604=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5970068450124397604==
Content-Type: multipart/alternative; boundary="0000000000003c5fe6061d61f96a"

--0000000000003c5fe6061d61f96a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Kienan,

I've continued investigating my issue and discovered something new that
might shed some light. Here's the rundown:

1. To ensure my add-ons weren't causing problems, deleted all old modules
and I followed the documentation on the LTTng website (
https://lttng.org/docs/v2.13/#doc-building-from-source) and downloaded
`lttng-modules-2.13.13`.

2. Inside the downloaded folder, I successfully executed `make
KERNELDIR=3D/usr/src/linux-source-6.5.0` without any issues.

3. Subsequently, I ran `make KERNELDIR=3D/usr/src/linux-source-6.5.0
modules_install`, which also completed successfully.

4. After that, I updated the module dependencies using `sudo depmod -a`,
which went fine.

However, when I tried to load a module, such as `sudo modprobe
lttng-probe-kvm`, it reported that the module couldn't be found at
`/lib/modules/6.5.0-41-generic/`. Upon checking the logs, I confirmed that
step 3 had installed the modules in `/lib/modules/6.5.0/`.

To address this, I modified step 3 to simply `make modules_install`, which
then installed the modules correctly at `/lib/modules/6.5.0-41-generic/`
and ran again step 4. But now, when attempting to load a module, I'm
encountering the error `modprobe: ERROR: could not insert
'lttng_probe_kvm': Exec format error`.

Do you have any insights or ideas on what might be causing this issue?

Thanks again for your assistance.




















Le mar. 16 juill. 2024, =C3=A0 09 h 05, Kienan Stewart <kstewart@efficios.c=
om> a
=C3=A9crit :

> Hi Fran=C3=A7ois,
>
> On 7/15/24 6:10 PM, Fran=C3=A7ois Belias via lttng-dev wrote:
> > Hello,
> >
> > I'm currently running Linux kernel version 6.5.0-41-generic and
> > attempting to install LTTng from source. Here are the steps I followed:
> >
> >   - I cloned the LTTng git repository to my computer from
> > [
> https://github.com/lttng/lttng-modules.git](https://github.com/lttng/lttn=
g-modules.git)
> <
> https://github.com/lttng/lttng-modules.git](https://github.com/lttng/lttn=
g-modules.git)
> >.
> > - Downloaded the kernel source tree corresponding to my kernel version
> > to enable compilation.
> > - Executed `make KERNELDIR=3D/path/to/my/linux/source`, which was
> > completed successfully.
> > - Ran `make KERNELDIR=3D/path/to/my/linux/source modules_install`, also
> > without any issues.
> > - Finally, I executed `sudo depmod -a`, which was completed successfull=
y.
> >
> > However, when I attempt to load a module with commands like `sudo
> > modprobe lttng-ketprobes` or "sudo modprobe lttng-tracer", I encounter
> > the following errors:
> >
> > - For `lttng-ketprobes`: `modprobe: FATAL: Module lttng-ketprobes not
> > found in directory /lib/modules/6.5.0-41-generic`.
> > - For `lttng-tracer`: `modprobe: ERROR: could not insert 'lttng_tracer'=
:
> > Exec format error`.
>
> If you rebuilt modules on the master branch as of yesterday you may need
> to clean the LTTng modules install directory, rebuild, and reinstall.
>
> This is due to kprobes, kretprobes, and uprobes modules being included
> in the tracer core module. C.f.
>
> https://github.com/lttng/lttng-modules/commit/0c2c6606eb66cb5222ab7a2a4f8=
329fd5dfdef70
>
> You may want to stick with running lttng-modules 2.13.x which will not
> have breaking changes merged in.
>
> The exec format error also could be due to modules that are installed
> but built against a different version of the Linux kernel.
>
> A few things to check
>
> - If your kernel has been upgraded recently, ensure the new kernel is
> the one actually running
> - If the modules haven't been rebuilt since the upgrade, they should be
> rebuilt and reinstalled
> - As I recall, you are playing around with some addon modules - do any
> of those modules define dependencies on the kprobes, kretprobes, or
> uprobes modules which now are no longer produced by builds of the master
> branch
>
> Is there further information in dmesg or journalctl regarding the module
> loading?
>
> hope this helps.
>
> thanks,
> kienan
>
> >
> > I've confirmed that the modules exist but can't load them. I'm unsure
> > how to resolve these issues. Could someone please assist me?
> >
> > Thank you.
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--0000000000003c5fe6061d61f96a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Kienan,<br><br>I&#39;ve continued investigating=
 my issue and discovered something new that might shed some light. Here&#39=
;s the rundown:<br><br>1. To ensure my add-ons weren&#39;t causing problems=
, deleted all old modules and I followed the documentation on the LTTng web=
site (<a href=3D"https://lttng.org/docs/v2.13/#doc-building-from-source">ht=
tps://lttng.org/docs/v2.13/#doc-building-from-source</a>) and downloaded `l=
ttng-modules-2.13.13`.<br><br>2. Inside the downloaded folder, I successful=
ly executed `make KERNELDIR=3D/usr/src/linux-source-6.5.0` without any issu=
es.<br><br>3. Subsequently, I ran `make KERNELDIR=3D/usr/src/linux-source-6=
.5.0 modules_install`, which also completed successfully.<br><br>4. After t=
hat, I updated the module dependencies using `sudo depmod -a`, which went f=
ine.<br><br>However, when I tried to load a module, such as `sudo modprobe =
lttng-probe-kvm`, it reported that the module couldn&#39;t be found at `/li=
b/modules/6.5.0-41-generic/`. Upon checking the logs, I confirmed that step=
 3 had installed the modules in `/lib/modules/6.5.0/`.<br><br>To address th=
is, I modified step 3 to simply `make modules_install`, which then installe=
d the modules correctly at `/lib/modules/6.5.0-41-generic/` and ran again s=
tep=C2=A04. But now, when attempting to load a module, I&#39;m encountering=
 the error `modprobe: ERROR: could not insert &#39;lttng_probe_kvm&#39;: Ex=
ec format error`.<br><br>Do you have any insights or ideas on what might be=
 causing this issue?<br><br>Thanks again for your assistance.<br></div><div=
><br></div><div><br></div><div><br></div><div>=C2=A0</div><div><br></div><d=
iv><br></div><div><br></div><div><br></div><div><br></div><div><br></div><d=
iv><br></div><div><br></div><div><br></div><div><br></div><div><br></div><d=
iv><br></div><div><br></div><div><br></div><div><br></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le mar. 16 juill.=
 2024, =C3=A0 09 h 05, Kienan Stewart &lt;<a href=3D"mailto:kstewart@effici=
os.com">kstewart@efficios.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">Hi Fran=C3=A7ois,<br>
<br>
On 7/15/24 6:10 PM, Fran=C3=A7ois Belias via lttng-dev wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; I&#39;m currently running Linux kernel version 6.5.0-41-generic and <b=
r>
&gt; attempting to install LTTng from source. Here are the steps I followed=
:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- I cloned the LTTng git repository to my computer from <b=
r>
&gt; [<a href=3D"https://github.com/lttng/lttng-modules.git%5D(https://gith=
ub.com/lttng/lttng-modules.git)" rel=3D"noreferrer" target=3D"_blank">https=
://github.com/lttng/lttng-modules.git](https://github.com/lttng/lttng-modul=
es.git)</a> &lt;<a href=3D"https://github.com/lttng/lttng-modules.git%5D(ht=
tps://github.com/lttng/lttng-modules.git)" rel=3D"noreferrer" target=3D"_bl=
ank">https://github.com/lttng/lttng-modules.git](https://github.com/lttng/l=
ttng-modules.git)</a>&gt;.<br>
&gt; - Downloaded the kernel source tree corresponding to my kernel version=
 <br>
&gt; to enable compilation.<br>
&gt; - Executed `make KERNELDIR=3D/path/to/my/linux/source`, which was <br>
&gt; completed successfully.<br>
&gt; - Ran `make KERNELDIR=3D/path/to/my/linux/source modules_install`, als=
o <br>
&gt; without any issues.<br>
&gt; - Finally, I executed `sudo depmod -a`, which was completed successful=
ly.<br>
&gt; <br>
&gt; However, when I attempt to load a module with commands like `sudo <br>
&gt; modprobe lttng-ketprobes` or &quot;sudo modprobe lttng-tracer&quot;, I=
 encounter <br>
&gt; the following errors:<br>
&gt; <br>
&gt; - For `lttng-ketprobes`: `modprobe: FATAL: Module lttng-ketprobes not =
<br>
&gt; found in directory /lib/modules/6.5.0-41-generic`.<br>
&gt; - For `lttng-tracer`: `modprobe: ERROR: could not insert &#39;lttng_tr=
acer&#39;: <br>
&gt; Exec format error`.<br>
<br>
If you rebuilt modules on the master branch as of yesterday you may need <b=
r>
to clean the LTTng modules install directory, rebuild, and reinstall.<br>
<br>
This is due to kprobes, kretprobes, and uprobes modules being included <br>
in the tracer core module. C.f. <br>
<a href=3D"https://github.com/lttng/lttng-modules/commit/0c2c6606eb66cb5222=
ab7a2a4f8329fd5dfdef70" rel=3D"noreferrer" target=3D"_blank">https://github=
.com/lttng/lttng-modules/commit/0c2c6606eb66cb5222ab7a2a4f8329fd5dfdef70</a=
><br>
<br>
You may want to stick with running lttng-modules 2.13.x which will not <br>
have breaking changes merged in.<br>
<br>
The exec format error also could be due to modules that are installed <br>
but built against a different version of the Linux kernel.<br>
<br>
A few things to check<br>
<br>
- If your kernel has been upgraded recently, ensure the new kernel is <br>
the one actually running<br>
- If the modules haven&#39;t been rebuilt since the upgrade, they should be=
 <br>
rebuilt and reinstalled<br>
- As I recall, you are playing around with some addon modules - do any <br>
of those modules define dependencies on the kprobes, kretprobes, or <br>
uprobes modules which now are no longer produced by builds of the master <b=
r>
branch<br>
<br>
Is there further information in dmesg or journalctl regarding the module <b=
r>
loading?<br>
<br>
hope this helps.<br>
<br>
thanks,<br>
kienan<br>
<br>
&gt; <br>
&gt; I&#39;ve confirmed that the modules exist but can&#39;t load them. I&#=
39;m unsure <br>
&gt; how to resolve these issues. Could someone please assist me?<br>
&gt; <br>
&gt; Thank you.<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
</blockquote></div>

--0000000000003c5fe6061d61f96a--

--===============5970068450124397604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5970068450124397604==--
