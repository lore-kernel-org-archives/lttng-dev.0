Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1755CC3DA5D
	for <lttng-dev@archiver.kernel.org>; Thu, 18 Jul 2024 00:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1721263465;
	bh=tdMQcBnyYz1C5xB36qWM96jfajGHY5Sc0yECNIbkZkU=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KwrorzbmVPR0QkRU9a+pW72ol0kUDcUPmIYVHo/NksYHCdWuLjhpkBmZuLkSRTZ71
	 2zMK/+Gp25oSuV9zNiSmKcO82UZ8VpTYO0RZKnUJbx70Wbn4BGND6GbpUyOx3fz2X0
	 UU5SdrjPlycaArad6KwK0hFFOd/S4BMDr1Oh7YuBCK2sGgEA0Z0E2CZ21c37FDgL0K
	 7q/RAj8Lpbru9+/RQxDvGiX0XVT+oCH5SeozBsMUTcCWIZ7PqR5D3347MgJpOnwDHD
	 mcV1McX7DaCdpjslKT4LCZ5EANxe2xvrVuZoWBAem6SCYUdcrxAdVyW7uIRgKYw0ih
	 lac8idjar+3fw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WPYwS5tNhz12TY;
	Wed, 17 Jul 2024 20:44:24 -0400 (EDT)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by lists.lttng.org (Postfix) with ESMTPS id 4WPYwR5tdGz1200
 for <lttng-dev@lists.lttng.org>; Wed, 17 Jul 2024 20:44:23 -0400 (EDT)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fbfb8e5e0cso2577715ad.0
 for <lttng-dev@lists.lttng.org>; Wed, 17 Jul 2024 17:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721263463; x=1721868263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZW/yx2hVz9wc/5y6f5vmDGvio1Ugjd0icUf35HicNJ0=;
 b=DpnRd8HKJnXUproKn5tdaqeF4Q2ruRqp2JZiPDMKkNoTxn/tL6Qj9PuOF9ywk/+V2y
 1iCHsCQrlp2E8NLeaRut3Y+tPi6u0uNHgRx3knUGhON+mFhQtd14oixvsNjhbuu2n4a+
 6UuJKlsVGpKZA8Li797q1ydqRdqDFudUZdjR2yUG3MxE+FESY22SWrVbzFqiVd1qf0fs
 0vmsgfhzjVAzD+9g1sr1iX+7Z5L/phMYN2UqJgtAuqiT1X4E0pvIawMaD+L2//MVtqky
 083YjxOOJZSYG67fq6/Z3SOe/hYbguURghqjGQGuddvh4vGnMWv707KUOarRvwVmGdY5
 PefQ==
X-Gm-Message-State: AOJu0YzPEIwCuY2gcaycuRySt/jCGGTxeQ0VU6juMlO9JOqZfSyzNAWf
 LMOfjfEHgMs8hOnLpsq9a+F/Lf8n9YROE5++8z/TJlSL56wBdeDma6yMLvCwpK/gNFT1M8kwHG+
 K8NMjLwHrprp64TQYdXFwMxkRD0k=
X-Google-Smtp-Source: AGHT+IFkvBWmdaIBKpX8guo0SNlkFurm5rqXiPIJbghgaXHKC3pr91u03XMA90MsYNnmMkO+m/DUjDKfBw2Jxd6pMQ8=
X-Received: by 2002:a17:903:41c4:b0:1fb:3d7:1cfc with SMTP id
 d9443c01a7336-1fc4e16e5f5mr30749445ad.20.1721263462261; Wed, 17 Jul 2024
 17:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHD10UjoaOjqZUH4j55Ra7zJ2HVRLOyk7xnjv+BjnJxs6rN6Aw@mail.gmail.com>
 <6deffa1d-4d46-4445-a510-a3aac271cc80@efficios.com>
 <CAHD10Ui_JkP9hRirGUvKBgHhWX48r26+M2_zTyOD_cMLnSDGCg@mail.gmail.com>
 <211e6d9f-834d-4511-b315-7844a5c04824@efficios.com>
 <CAHD10Ugvtu+wKGeRjujGgXbXrEqH-6OKHurJgMyf7CmUVjzRRQ@mail.gmail.com>
 <5b7fc307-a52a-4e54-84df-294600454686@efficios.com>
 <CAHD10UgTthGz7gcgcga6W4xxjiKHfuZgM9uCjEkViKsVUnDF8A@mail.gmail.com>
 <CAHD10UhNDKo=4Kk-Z_mBG3PMm=1KgX9L0mjgTS+ZfrT4Xbmn9w@mail.gmail.com>
 <02547951-d7df-4006-853a-521b057e9b3f@efficios.com>
In-Reply-To: <02547951-d7df-4006-853a-521b057e9b3f@efficios.com>
Date: Wed, 17 Jul 2024 20:44:11 -0400
Message-ID: <CAHD10UgXdBoKGwSdXQk__OW7E1abyQKA=2rgmKry6p6ZQxmTyw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1824607737708365640=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1824607737708365640==
Content-Type: multipart/alternative; boundary="0000000000003bad8c061d7ae1d0"

--0000000000003bad8c061d7ae1d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Kienan,

Thanks to your advice, I managed to load some modules. However, I
encountered errors like these when running `dmesg | grep lttng`:

```
[  218.043672] module lttng_kretprobes: .gnu.linkonce.this_module section
size must match the kernel's built struct module size at run time
[  650.560883] lttng_kretprobes: module verification failed: signature
and/or required key missing - tainting kernel
[ 1468.329988] module lttng_ring_buffer_client_discard:
.gnu.linkonce.this_module section size must match the kernel's built struct
module size at run time
```

I'm unsure of their meaning. After loading my module, how can I be certain
that my tracepoints are active? I read online that people use `sudo lttng
list -k` for this purpose, but when I tried it, I got the error: "Error:
Unable to list kernel events: Kernel tracer not available". Is there
another way?

Thank you for your assistance.

Le mer. 17 juill. 2024, =C3=A0 12 h 08, Kienan Stewart <kstewart@efficios.c=
om> a
=C3=A9crit :

> Hi Fran=C3=A7ois,
>
> On 7/17/24 11:47 AM, Fran=C3=A7ois Belias wrote:
> > Hello, Kienan
> >
> >
> > *Right. Which kernel are you actually running at this time? You can che=
ck
> > using: `uname -a`*
> > Linux philippe 6.5.0-41-generic #41~22.04.2-Ubuntu SMP PREEMPT_DYNAMIC
> > Mon Jun  3 11:32:55 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
> >
> > *Since you've got a few different images and headers installed, it is
> > possible to check that same info the linux-source package: `dpkg -l |
> > grep linux-source`.*
> > ii  linux-source                                   5.15.0.116.116
> >                               all          Linux kernel source with
> > Ubuntu patches
> > ii  linux-source-5.15.0                       5.15.0-116.126
> >                         all          Linux kernel source for version
> > 5.15.0 with Ubuntu patches
> > ii  linux-source-6.5.0                      6.5.0-44.44~22.04.1
> >                        all          Linux kernel source for version
>
> Your currently running `6.5.0-41-generic #41~22.04.2-Ubuntu`
>
> You have source installed for `6.5.0-44.44~22.04.1`. From your previous
> e-mail, there is also a linux image installed:
>
> ```
> linux-image-6.5.0-44-generic 6.5.0-44.44~22.04.1
> ```
>
> Assuming you are using grub, could you verify that one of the options
> for booting in `/boot/grub/grub.cfg` is linux 6.5.0-44.44. Look for the
> lines similar to the following inside a menu entry block:
>
> (Note my example is 5.15.0-116, but you will be lookng for 6.5.0-44 or
> 6.5.0-44.44)
>
> ```
> linux   /boot/vmlinuz-5.15.0-116-generic root=3D....
> initrd  /boot/initrd.img-5.15.0-116-generic
> ```
>
> If you have a grub entry for linux 6.5.0-44.44, could you reboot to run
> on the linux 6.5.0-44.44.
>
> After rebooting verify with `uname -a` that your kernel version is
> 6.5.0-44.44.
>
> Make sure you have unpacked the linux sources:
>
> ```
> # Approximating the version numbers, since I don't have 6.5.0 installed
> cd /usr/src/linux-source-6.5.0
> bunzip2 linux-source-6.5.0.tar.bz2
> tar -xf linux-source-6.5.0.tar
> ```
>
> Then retry the build with
> `KERNELDIR=3D/usr/src/linux-source-6.5.0/linux-source-6.5.0/`
>
> I haven't personally tried the full steps on an Ubuntu installation so
> you may still need to tweak a couple of things, but I think this should
> get you on the right path.
>
> Really the important thing is to make sure that the kernel source code
> matches the kernel you are running.
>
> > 6.5.0 with Ubuntu patches
> > *Could you run either `apt-cache policy` or `apt policy` and `apt-mark
> > showhold` in order to know which sources you have configured.*
> > For this part, /*apt-mark showhold*/ gave me nothing I don't know what
> > is means.
>
> `apt-mark showhold` will show any packages that are on hold - it is a
> way of marking packages that shouldn't be updated.
>
> As you have the linux-source for 6.5.0-44.44~22.04.1, I don't think it
> will be necessary to have the output of `apt-cache policy`.
>
> thanks,
> kienan
>
> >
> > I am looking at the links, but nothing seems to match my kernel version=
.
> >
> > Thanks for your assistance.
> >
> > Le mer. 17 juill. 2024, =C3=A0 11 h 46, Fran=C3=A7ois Belias
> > <beliasossim@gmail.com <mailto:beliasossim@gmail.com>> a =C3=A9crit :
> >
> >     Hello, Kienan
> >
> >
> >     *Right. Which kernel are you actually running at this time? You can
> >     check
> >     using: `uname -a`*
> >     Linux philippe 6.5.0-41-generic #41~22.04.2-Ubuntu SMP
> >     PREEMPT_DYNAMIC Mon Jun  3 11:32:55 UTC 2 x86_64 x86_64 x86_64
> GNU/Linux
> >
> >     *Since you've got a few different images and headers installed, it =
is
> >     possible to check that same info the linux-source package: `dpkg -l=
 |
> >     grep linux-source`.*
> >     ii  linux-source                                   5.15.0.116.116
> >                                       all          Linux kernel source
> >     with Ubuntu patches
> >     ii  linux-source-5.15.0                       5.15.0-116.126
> >                                 all          Linux kernel source for
> >     version 5.15.0 with Ubuntu patches
> >     ii  linux-source-6.5.0                      6.5.0-44.44~22.04.1
> >                                all          Linux kernel source for
> >     version 6.5.0 with Ubuntu patches
> >     *Could you run either `apt-cache policy` or `apt policy` and
> `apt-mark
> >     showhold` in order to know which sources you have configured.*
> >     For this part, /*apt-mark showhold*/ gave me nothing I don't know
> >     what is means.
> >
> >     I am looking at the links, but nothing seems to match my kernel
> >     version.
> >
> >     Thanks for your assistance.
> >
> >     Le mer. 17 juill. 2024, =C3=A0 10 h 55, Kienan Stewart
> >     <kstewart@efficios.com <mailto:kstewart@efficios.com>> a =C3=A9crit=
 :
> >
> >         Hi Fran=C3=A7ois,
> >
> >         On 7/16/24 4:34 PM, Fran=C3=A7ois Belias wrote:
> >          > Hello Kienan,
> >          >
> >          > When I proceed with the following steps:
> >          >
> >          > ```
> >          > # Warning: this removes all untracked content from the
> >         lttng-modules
> >          > directory
> >          > cd /path/to/lttng-modules-source
> >          > git clean -dxf
> >          >
> >          > make
> >          > sudo make modules_install
> >          > sudo depmod -a
> >          > ```
> >          >
> >          > I encounter a warning in
> >          > `/home/philippe/lttng-modules/src/probes/Kbuild:79` stating
> >         "File
> >          > ./arch/x86/kvm/lapic.h not found. Probe 'kvm' x86-specific i=
s
> >         disabled.
> >          > Use full kernel source tree to enable it." Although
> >         everything compiles
> >          > fine and I'm able to load modules, when I execute `sudo lttn=
g
> >         list -k`,
> >          > I don't see the tracepoints `kvm_entry` and `kvm_exit`, whic=
h
> >         I believe
> >          > should be available. Could this be due to not using my full
> >         kernel tree
> >          > during compilation?
> >
> >
> >         Exactly. Those probes depend on having the full kernel source a=
s
> >         they
> >         require private headers which aren't shipped as part of the
> >         `linux-headers` package.
> >
> >          >
> >          > Here are the answers to your questions:
> >          >
> >          > - *Where did `/usr/src/linux-source-6.5.0` come from?*
> >          >    I initially attempted `sudo apt-get update && sudo apt-ge=
t
> >         install
> >          > linux-source`, but it gave me this answer */linux-source is
> >         already the
> >          > newest version (5.15.0.116.116)/*`, which doesn't match my
> >         current
> >          > kernel version. So, I downloaded it directly from kernel.org
> >         <http://kernel.org>
> >          > <http://kernel.org <http://kernel.org>> using this command:
> >         `wget
> >          >
> >         https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz`
> <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz>
> >         <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz>
> >          >
> >         <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz`
> <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz>
> >         <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz
> >>.
> >          >
> >
> >         Right. Which kernel are you actually running at this time? You
> >         can check
> >         using: `uname -a`
> >
> >         In any case, Linux upstream 6.5 is not the same as Ubuntus's 6.=
5.
> >
> >          > - *Which Linux distribution and version are you using?*
> >          >    Running `lsb_release -a` gives me:
> >          >    ```
> >          >    No LSB modules are available.
> >          >    Distributor ID: Ubuntu
> >          >    Description:    Ubuntu 22.04.4 LTS
> >          >    Release:        22.04
> >          >    Codename:       jammy
> >          >    ```
> >          >
> >          > - *Assuming your distribution has kernel packages, which do
> >         you have
> >          > installed, and do you have the corresponding kernel headers
> >         package
> >          > installed?*
> >          >
> >          >    Running `dpkg -l | grep linux-image` shows these installe=
d
> >         packages:
> >          >    ```
> >          >    ii  linux-image-5.15.0-116-generic           5.15.0-116.1=
26
> >          >   amd64   Signed kernel image generic
> >          >    ii  linux-image-6.5.0-28-generic
> >         6.5.0-28.29~22.04.1
> >          >   amd64   Signed kernel image generic
> >          >    ii  linux-image-6.5.0-41-generic
> >         6.5.0-41.41~22.04.2
> >          >   amd64   Signed kernel image generic
> >          >    ii  linux-image-6.5.0-44-generic
> >         6.5.0-44.44~22.04.1
> >          >   amd64   Signed kernel image generic
> >          >    ii  linux-image-generic                      5.15.0.116.1=
16
> >          >   amd64   Generic Linux kernel image
> >          >    ii  linux-image-generic-hwe-22.04
> >           6.5.0.44.44~22.04.1
> >          >   amd64   Generic Linux kernel image
> >          >    ```
> >          >
> >          >    And `dpkg -l | grep linux-headers` shows these installed
> >         header packages:
> >          >    ```
> >          >    ii  linux-headers-5.15.0-116
> >         5.15.0-116.126      all
> >          >      Header files related to Linux kernel version 5.15.0
> >          >    ii  linux-headers-5.15.0-116-generic         5.15.0-116.1=
26
> >          >   amd64   Linux kernel headers for version 5.15.0 on 64 bit
> >         x86 SMP
> >          >    ii  linux-headers-6.5.0-28-generic
> >         6.5.0-28.29~22.04.1
> >          >   amd64   Linux kernel headers for version 6.5.0 on 64 bit
> >         x86 SMP
> >          >    ii  linux-headers-6.5.0-41-generic
> >         6.5.0-41.41~22.04.2
> >          >   amd64   Linux kernel headers for version 6.5.0 on 64 bit
> >         x86 SMP
> >          >    ii  linux-headers-6.5.0-44-generic
> >         6.5.0-44.44~22.04.1
> >          >   amd64   Linux kernel headers for version 6.5.0 on 64 bit
> >         x86 SMP
> >          >    ii  linux-headers-generic                    5.15.0.116.1=
16
> >          >   amd64   Generic Linux kernel headers
> >          >    ii  linux-headers-generic-hwe-22.04
> >           6.5.0.44.44~22.04.1
> >          >   amd64   Generic Linux kernel headers
> >          >    ```
> >          >
> >
> >         Since you've got a few different images and headers installed,
> >         it is
> >         possible to check that same info the linux-source package: `dpk=
g
> >         -l |
> >         grep linux-source`.
> >
> >         Maybe one thing tripping this process up is that you don't have
> >         an apt
> >         source that provides linux-source that matches the kernel you
> >         are using.
> >         Could you run either `apt-cache policy` or `apt policy` and
> >         `apt-mark
> >         showhold` in order to know which sources you have configured.
> >
> >         There are also alternative sources for the full source tree:
> >
> >         - You could download the specific package from
> >         packages.ubuntu.com <http://packages.ubuntu.com>. See
> >         https://packages.ubuntu.com <https://packages.ubuntu.com> and
> >         use `apt install ./downloaded_package.deb`
> >
> >         - You could clone the kernel source for Ubuntu and checkout the
> >         appropriate tag. See
> >
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/=
refs/tags
> <
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/=
refs/tags
> >
> >
> >         thanks,
> >         kienan
> >
>

--0000000000003bad8c061d7ae1d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Kienan,<br><br>Thanks to your advice, I managed to l=
oad some modules. However, I encountered errors like these when running `dm=
esg | grep lttng`:<br><br>```<br>[ =C2=A0218.043672] module lttng_kretprobe=
s: .gnu.linkonce.this_module section size must match the kernel&#39;s built=
 struct module size at run time<br>[ =C2=A0650.560883] lttng_kretprobes: mo=
dule verification failed: signature and/or required key missing - tainting =
kernel<br>[ 1468.329988] module lttng_ring_buffer_client_discard: .gnu.link=
once.this_module section size must match the kernel&#39;s built struct modu=
le size at run time<br>```<br><br>I&#39;m unsure of their meaning. After lo=
ading my module, how can I be certain that my tracepoints are active? I rea=
d online that people use `sudo lttng list -k` for this purpose, but when I =
tried it, I got the error: &quot;Error: Unable to list kernel events: Kerne=
l tracer not available&quot;. Is there another way?<br><br>Thank you for yo=
ur assistance.<br><div></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Le mer. 17 juill. 2024, =C3=A0 12 h 08, Kiena=
n Stewart &lt;<a href=3D"mailto:kstewart@efficios.com">kstewart@efficios.co=
m</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Hi Fran=C3=A7ois,<br>
<br>
On 7/17/24 11:47 AM, Fran=C3=A7ois Belias wrote:<br>
&gt; Hello, Kienan<br>
&gt; <br>
&gt; <br>
&gt; *Right. Which kernel are you actually running at this time? You can ch=
eck<br>
&gt; using: `uname -a`*<br>
&gt; Linux philippe 6.5.0-41-generic #41~22.04.2-Ubuntu SMP PREEMPT_DYNAMIC=
 <br>
&gt; Mon Jun =C2=A03 11:32:55 UTC 2 x86_64 x86_64 x86_64 GNU/Linux<br>
&gt; <br>
&gt; *Since you&#39;ve got a few different images and headers installed, it=
 is<br>
&gt; possible to check that same info the linux-source package: `dpkg -l |<=
br>
&gt; grep linux-source`.*<br>
&gt; ii =C2=A0linux-source=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A05.15.0.116.116=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0all =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Linux kernel source with <br>
&gt; Ubuntu patches<br>
&gt; ii =C2=A0linux-source-5.15.0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05.15.0-116.126=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0all =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux kernel sour=
ce for version <br>
&gt; 5.15.0 with Ubuntu patches<br>
&gt; ii =C2=A0linux-source-6.5.0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.5.0-44.44~22.04.1=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 all =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux kernel source for=
 version <br>
<br>
Your currently running `6.5.0-41-generic #41~22.04.2-Ubuntu`<br>
<br>
You have source installed for `6.5.0-44.44~22.04.1`. From your previous <br=
>
e-mail, there is also a linux image installed:<br>
<br>
```<br>
linux-image-6.5.0-44-generic 6.5.0-44.44~22.04.1<br>
```<br>
<br>
Assuming you are using grub, could you verify that one of the options <br>
for booting in `/boot/grub/grub.cfg` is linux 6.5.0-44.44. Look for the <br=
>
lines similar to the following inside a menu entry block:<br>
<br>
(Note my example is 5.15.0-116, but you will be lookng for 6.5.0-44 or <br>
6.5.0-44.44)<br>
<br>
```<br>
linux=C2=A0 =C2=A0/boot/vmlinuz-5.15.0-116-generic root=3D....<br>
initrd=C2=A0 /boot/initrd.img-5.15.0-116-generic<br>
```<br>
<br>
If you have a grub entry for linux 6.5.0-44.44, could you reboot to run <br=
>
on the linux 6.5.0-44.44.<br>
<br>
After rebooting verify with `uname -a` that your kernel version is <br>
6.5.0-44.44.<br>
<br>
Make sure you have unpacked the linux sources:<br>
<br>
```<br>
# Approximating the version numbers, since I don&#39;t have 6.5.0 installed=
<br>
cd /usr/src/linux-source-6.5.0<br>
bunzip2 linux-source-6.5.0.tar.bz2<br>
tar -xf linux-source-6.5.0.tar<br>
```<br>
<br>
Then retry the build with <br>
`KERNELDIR=3D/usr/src/linux-source-6.5.0/linux-source-6.5.0/`<br>
<br>
I haven&#39;t personally tried the full steps on an Ubuntu installation so =
<br>
you may still need to tweak a couple of things, but I think this should <br=
>
get you on the right path.<br>
<br>
Really the important thing is to make sure that the kernel source code <br>
matches the kernel you are running.<br>
<br>
&gt; 6.5.0 with Ubuntu patches<br>
&gt; *Could you run either `apt-cache policy` or `apt policy` and `apt-mark=
<br>
&gt; showhold` in order to know which sources you have configured.*<br>
&gt; For this part, /*apt-mark showhold*/=C2=A0gave me nothing I don&#39;t =
know what <br>
&gt; is means.<br>
<br>
`apt-mark showhold` will show any packages that are on hold - it is a <br>
way of marking packages that shouldn&#39;t be updated.<br>
<br>
As you have the linux-source for 6.5.0-44.44~22.04.1, I don&#39;t think it =
<br>
will be necessary to have the output of `apt-cache policy`.<br>
<br>
thanks,<br>
kienan<br>
<br>
&gt; <br>
&gt; I am looking at the links, but nothing seems to match my kernel versio=
n.<br>
&gt; <br>
&gt; Thanks for your assistance.<br>
&gt; <br>
&gt; Le mer. 17 juill. 2024, =C3=A0 11 h 46, Fran=C3=A7ois Belias <br>
&gt; &lt;<a href=3D"mailto:beliasossim@gmail.com" target=3D"_blank">beliaso=
ssim@gmail.com</a> &lt;mailto:<a href=3D"mailto:beliasossim@gmail.com" targ=
et=3D"_blank">beliasossim@gmail.com</a>&gt;&gt; a =C3=A9crit=C2=A0:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hello, Kienan<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0*Right. Which kernel are you actually running at th=
is time? You can<br>
&gt;=C2=A0 =C2=A0 =C2=A0check<br>
&gt;=C2=A0 =C2=A0 =C2=A0using: `uname -a`*<br>
&gt;=C2=A0 =C2=A0 =C2=A0Linux philippe 6.5.0-41-generic #41~22.04.2-Ubuntu =
SMP<br>
&gt;=C2=A0 =C2=A0 =C2=A0PREEMPT_DYNAMIC Mon Jun =C2=A03 11:32:55 UTC 2 x86_=
64 x86_64 x86_64 GNU/Linux<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0*Since you&#39;ve got a few different images and he=
aders installed, it is<br>
&gt;=C2=A0 =C2=A0 =C2=A0possible to check that same info the linux-source p=
ackage: `dpkg -l |<br>
&gt;=C2=A0 =C2=A0 =C2=A0grep linux-source`.*<br>
&gt;=C2=A0 =C2=A0 =C2=A0ii =C2=A0linux-source=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A05.15.0.116.116=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0all =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux kernel source<br>
&gt;=C2=A0 =C2=A0 =C2=A0with Ubuntu patches<br>
&gt;=C2=A0 =C2=A0 =C2=A0ii =C2=A0linux-source-5.15.0=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05.15.0-116.12=
6=C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0all =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0Linux kernel source for<br>
&gt;=C2=A0 =C2=A0 =C2=A0version 5.15.0 with Ubuntu patches<br>
&gt;=C2=A0 =C2=A0 =C2=A0ii =C2=A0linux-source-6.5.0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.5.0-44.44~22.04.1=C2=
=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 all =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Linux kernel source for<br>
&gt;=C2=A0 =C2=A0 =C2=A0version 6.5.0 with Ubuntu patches<br>
&gt;=C2=A0 =C2=A0 =C2=A0*Could you run either `apt-cache policy` or `apt po=
licy` and `apt-mark<br>
&gt;=C2=A0 =C2=A0 =C2=A0showhold` in order to know which sources you have c=
onfigured.*<br>
&gt;=C2=A0 =C2=A0 =C2=A0For this part, /*apt-mark showhold*/ gave me nothin=
g I don&#39;t know<br>
&gt;=C2=A0 =C2=A0 =C2=A0what is means.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I am looking at the links, but nothing seems to mat=
ch my kernel<br>
&gt;=C2=A0 =C2=A0 =C2=A0version.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks for your assistance.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Le mer. 17 juill. 2024, =C3=A0 10 h 55, Kienan Stew=
art<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:kstewart@efficios.com" target=
=3D"_blank">kstewart@efficios.com</a> &lt;mailto:<a href=3D"mailto:kstewart=
@efficios.com" target=3D"_blank">kstewart@efficios.com</a>&gt;&gt; a =C3=A9=
crit=C2=A0:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hi Fran=C3=A7ois,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On 7/16/24 4:34 PM, Fran=C3=A7ois Bel=
ias wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Hello Kienan,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; When I proceed with the followi=
ng steps:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; # Warning: this removes all unt=
racked content from the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttng-modules<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; directory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; cd /path/to/lttng-modules-sourc=
e<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; git clean -dxf<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; make<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; sudo make modules_install<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; sudo depmod -a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; I encounter a warning in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; `/home/philippe/lttng-modules/s=
rc/probes/Kbuild:79` stating<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;File<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; ./arch/x86/kvm/lapic.h not foun=
d. Probe &#39;kvm&#39; x86-specific is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0disabled.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Use full kernel source tree to =
enable it.&quot; Although<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0everything compiles<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; fine and I&#39;m able to load m=
odules, when I execute `sudo lttng<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list -k`,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; I don&#39;t see the tracepoints=
 `kvm_entry` and `kvm_exit`, which<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I believe<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; should be available. Could this=
 be due to not using my full<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel tree<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; during compilation?<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Exactly. Those probes depend on havin=
g the full kernel source as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0they<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0require private headers which aren&#3=
9;t shipped as part of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0`linux-headers` package.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Here are the answers to your qu=
estions:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; - *Where did `/usr/src/linux-so=
urce-6.5.0` come from?*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 I initially attemp=
ted `sudo apt-get update &amp;&amp; sudo apt-get<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0install<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; linux-source`, but it gave me t=
his answer */linux-source is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0already the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; newest version (5.15.0.116.116)=
/*`, which doesn&#39;t match my<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0current<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; kernel version. So, I downloade=
d it directly from <a href=3D"http://kernel.org" rel=3D"noreferrer" target=
=3D"_blank">kernel.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://kernel.org" rel=
=3D"noreferrer" target=3D"_blank">http://kernel.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &lt;<a href=3D"http://kernel.or=
g" rel=3D"noreferrer" target=3D"_blank">http://kernel.org</a> &lt;<a href=
=3D"http://kernel.org" rel=3D"noreferrer" target=3D"_blank">http://kernel.o=
rg</a>&gt;&gt; using this command:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0`wget<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://cdn.kernel.org/pub=
/linux/kernel/v6.x/linux-6.5.tar.xz" rel=3D"noreferrer" target=3D"_blank">h=
ttps://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz`</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://cdn.kernel.org=
/pub/linux/kernel/v6.x/linux-6.5.tar.xz" rel=3D"noreferrer" target=3D"_blan=
k">https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz</a>&gt;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://cdn.kernel.org=
/pub/linux/kernel/v6.x/linux-6.5.tar.xz" rel=3D"noreferrer" target=3D"_blan=
k">https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz`</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://cdn.kernel.org=
/pub/linux/kernel/v6.x/linux-6.5.tar.xz" rel=3D"noreferrer" target=3D"_blan=
k">https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz</a>&gt;&gt=
;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Right. Which kernel are you actually =
running at this time? You<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0can check<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0using: `uname -a`<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0In any case, Linux upstream 6.5 is no=
t the same as Ubuntus&#39;s 6.5.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; - *Which Linux distribution and=
 version are you using?*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 Running `lsb_relea=
se -a` gives me:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 No LSB modules are=
 available.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 Distributor ID: Ub=
untu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 Description: =C2=
=A0 =C2=A0Ubuntu 22.04.4 LTS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 Release: =C2=A0 =
=C2=A0 =C2=A0 =C2=A022.04<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 Codename: =C2=A0 =
=C2=A0 =C2=A0 jammy<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; - *Assuming your distribution h=
as kernel packages, which do<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0you have<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; installed, and do you have the =
corresponding kernel headers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0package<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; installed?*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 Running `dpkg -l |=
 grep linux-image` shows these installed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packages:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ii =C2=A0linux-ima=
ge-5.15.0-116-generic =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5.15.0-116.126<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0amd64 =C2=A0 Signed=
 kernel image generic<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ii =C2=A0linux-ima=
ge-6.5.0-28-generic=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5.0-28.29~22.04.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0amd64 =C2=A0 Signed=
 kernel image generic<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ii =C2=A0linux-ima=
ge-6.5.0-41-generic=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5.0-41.41~22.04.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0amd64 =C2=A0 Signed=
 kernel image generic<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ii =C2=A0linux-ima=
ge-6.5.0-44-generic=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5.0-44.44~22.04.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0amd64 =C2=A0 Signed=
 kernel image generic<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ii =C2=A0linux-ima=
ge-generic =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A05.15.0.116.116<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0amd64 =C2=A0 Generi=
c Linux kernel image<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ii =C2=A0linux-ima=
ge-generic-hwe-22.04=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5.0.44.44~22.04.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0amd64 =C2=A0 Generi=
c Linux kernel image<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 And `dpkg -l | gre=
p linux-headers` shows these installed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0header packages:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ii =C2=A0linux-hea=
ders-5.15.0-116=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05.15.0-116.126 =C2=A0 =C2=A0 =C2=A0al=
l<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 Header file=
s related to Linux kernel version 5.15.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ii =C2=A0linux-hea=
ders-5.15.0-116-generic =C2=A0 =C2=A0 =C2=A0 =C2=A0 5.15.0-116.126<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0amd64 =C2=A0 Linux =
kernel headers for version 5.15.0 on 64 bit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x86 SMP<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ii =C2=A0linux-hea=
ders-6.5.0-28-generic=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5.0-28.29~22.04.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0amd64 =C2=A0 Linux =
kernel headers for version 6.5.0 on 64 bit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x86 SMP<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ii =C2=A0linux-hea=
ders-6.5.0-41-generic=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5.0-41.41~22.04.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0amd64 =C2=A0 Linux =
kernel headers for version 6.5.0 on 64 bit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x86 SMP<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ii =C2=A0linux-hea=
ders-6.5.0-44-generic=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5.0-44.44~22.04.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0amd64 =C2=A0 Linux =
kernel headers for version 6.5.0 on 64 bit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x86 SMP<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ii =C2=A0linux-hea=
ders-generic =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A05.15.0.116.116<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0amd64 =C2=A0 Generi=
c Linux kernel headers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ii =C2=A0linux-hea=
ders-generic-hwe-22.04=C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5.0.44.44~22.04.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0amd64 =C2=A0 Generi=
c Linux kernel headers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Since you&#39;ve got a few different =
images and headers installed,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0it is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0possible to check that same info the =
linux-source package: `dpkg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-l |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0grep linux-source`.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Maybe one thing tripping this process=
 up is that you don&#39;t have<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0an apt<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0source that provides linux-source tha=
t matches the kernel you<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0are using.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Could you run either `apt-cache polic=
y` or `apt policy` and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0`apt-mark<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0showhold` in order to know which sour=
ces you have configured.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0There are also alternative sources fo=
r the full source tree:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- You could download the specific pac=
kage from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://packages.ubuntu.com=
" rel=3D"noreferrer" target=3D"_blank">packages.ubuntu.com</a> &lt;<a href=
=3D"http://packages.ubuntu.com" rel=3D"noreferrer" target=3D"_blank">http:/=
/packages.ubuntu.com</a>&gt;. See<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://packages.ubuntu.co=
m" rel=3D"noreferrer" target=3D"_blank">https://packages.ubuntu.com</a> &lt=
;<a href=3D"https://packages.ubuntu.com" rel=3D"noreferrer" target=3D"_blan=
k">https://packages.ubuntu.com</a>&gt; and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use `apt install ./downloaded_package=
.deb`<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- You could clone the kernel source f=
or Ubuntu and checkout the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0appropriate tag. See<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.launchpad.net/=
~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/refs/tags" rel=3D"noreferrer=
" target=3D"_blank">https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source=
/linux/+git/jammy/refs/tags</a> &lt;<a href=3D"https://git.launchpad.net/~u=
buntu-kernel/ubuntu/+source/linux/+git/jammy/refs/tags" rel=3D"noreferrer" =
target=3D"_blank">https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/l=
inux/+git/jammy/refs/tags</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kienan<br>
&gt; <br>
</blockquote></div>

--0000000000003bad8c061d7ae1d0--

--===============1824607737708365640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1824607737708365640==--
