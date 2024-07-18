Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99C6C3DA49
	for <lttng-dev@archiver.kernel.org>; Thu, 18 Jul 2024 19:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1721332026;
	bh=UxpCzIt0WqH6PZ+nyrBzebBCruUE2M3UaEe97nY/QlQ=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=eYmtxKZkoWS3XSKHum7fq1ZfysJuyy31j8L+flAUcdthFSVYPD6a3ZzORt4esR3ku
	 KaV6BzLsxdV9q9zGndZf6ngIhV2lzufbPLYrFpaEP7QbIeNpof3q9Rzs6/YV193dAU
	 aiIR1PL6Dun/NWFlughRB1hShYT1JgXKxLBfZ381ZujxYfAYrt8r8LgwumaLUIEIWj
	 eOvuU1zBtSdVZIRf9J1rpHjKtd2G7IwJeJrbLY/gU7D81sm9IXyxbXwZMlTv/xho+B
	 zA4pje3S2nfdQz9jD5me1JhirzDM3b3XVA/YX+Hqv5YVaCKFHGzPINKUa2UNtGzEoR
	 p/W1usGnAgKUQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WQ3Gx4jySz12w1;
	Thu, 18 Jul 2024 15:47:05 -0400 (EDT)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by lists.lttng.org (Postfix) with ESMTPS id 4WQ3Gv5hcyz12w0
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jul 2024 15:47:03 -0400 (EDT)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fb3b7d0d56so8312745ad.1
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jul 2024 12:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721332022; x=1721936822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ehE+VtJdF+F6epnkOx0A/KG3TT4z2/Eq7DkeBjZgnp0=;
 b=VKmWXywlkZO3ASp6hjaHH7tQFQMEkx2k/qJzPEVHWL4EHc/P/2Yo6CyWQx8nlhJbTB
 FPtc2VNNJvTzLYi6/RGy3ZZ9r0ppUXZ4xzCIQsR+m39xeMOSpVUcBQaWWZIFrPzJiBgf
 L3pcGs9FC6WF/WW/gxDKza1VOwThNfvu8j73Lco+KWCYqVORU13A4UDbbAOB0na3rIwo
 NIiR34VPO+Eaf43jVI0A4iCc2BvlnHcVtLk/B4f1s2rW4mZAVyA53E6T9l0j2jaSMc0n
 M4LQ1iRUF9g709UWdElpOosUjpcXk36i5IQg9H0j5ApfeJ32d+cIeoHkoZG2nXamjK6T
 PV/w==
X-Gm-Message-State: AOJu0YwwSZrI6D/WK4tsZaC2y910HvF5K2+/hJ/oIL0Fu0yHF371PZWs
 4TXgvca2SOFeT6nJcvwt8WE2PwBy0BYRbz0OIH4EK0gR8CCaGGBA084UjsJ87Cn4NqgBATbmuRW
 NLwdIdCYqg/PMTZWGc4QfVy/xbVU=
X-Google-Smtp-Source: AGHT+IHEScc0Fk9hqGm+mXatclucQKkuotKB3lbp7L3DTN0B9kVjwOeaDIWht9+AfQSM7BdVIePhZ6Bv8FyGD7KDYPE=
X-Received: by 2002:a17:902:d2d2:b0:1fb:8a3b:ee9a with SMTP id
 d9443c01a7336-1fc4e6894c9mr60020925ad.61.1721332021963; Thu, 18 Jul 2024
 12:47:01 -0700 (PDT)
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
 <CAHD10UgXdBoKGwSdXQk__OW7E1abyQKA=2rgmKry6p6ZQxmTyw@mail.gmail.com>
 <f99d6473-e16d-44d6-8678-1f64a9f77981@efficios.com>
 <4cedc4f3-6f8b-48b7-84f5-c6627c7786ee@efficios.com>
In-Reply-To: <4cedc4f3-6f8b-48b7-84f5-c6627c7786ee@efficios.com>
Date: Thu, 18 Jul 2024 15:46:50 -0400
Message-ID: <CAHD10Ujd54CRn=XpA_NZGVoWkwKsHVBU_EjmXO7_ctcvKSR1+A@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============9101353945920727453=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============9101353945920727453==
Content-Type: multipart/alternative; boundary="000000000000b5bc0c061d8ad7a5"

--000000000000b5bc0c061d8ad7a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Kienan,

 my issue has been fixed. thanks for your help

Le jeu. 18 juill. 2024, =C3=A0 10 h 58, Kienan Stewart <kstewart@efficios.c=
om> a
=C3=A9crit :

> A couple of addendums inline below
>
> On 7/18/24 10:47 AM, Kienan Stewart via lttng-dev wrote:
> > Hi Fran=C3=A7ois,
> >
> > The dmesg excerpts are spaced by a number of minutes each, are they fro=
m
> > different attempts to build and load the modules?
> >
> > On 7/17/24 8:44 PM, Fran=C3=A7ois Belias wrote:
> >> Hello Kienan,
> >>
> >> Thanks to your advice, I managed to load some modules. However, I
> >> encountered errors like these when running `dmesg | grep lttng`:
> >>
> >> ```
> >> [  218.043672] module lttng_kretprobes: .gnu.linkonce.this_module
> >> section size must match the kernel's built struct module size at run
> time
> >
> > This sounds like the version of the module is built against the wrong
> > kernel headers or source.
>
> Also, are you using lttng-modules master or did you swap back to
> stable-2.13?
>
> If you're still on master and have the most recent changes
> lttng_kretprobes isn't required anymore. You will also need lttng-tools
> from master with the corresponding changes so that it doesn't try to
> load lttng_kretprobes.
>
> >
> >> [  650.560883] lttng_kretprobes: module verification failed: signature
> >> and/or required key missing - tainting kernel
> >
> > Is your system running with secure boot enabled? If so, you either need
> > to disable secure boot or sign the built modules with a MOK key that is
> > correctly enrolled.
> >
> > See the following documentation:
> >
> > - https://lttng.org/docs/v2.13/#doc-linux-kernel-sig
> > - https://www.kernel.org/doc/html/latest/admin-guide/module-signing.htm=
l
> > - https://github.com/dell/dkms
> > -
> >
> https://gitlab.com/linux-kernel/stable/-/blob/master/kernel/module/main.c=
#L2064
> >
> > Whatever you did for this test is pretty closed to working. The previou=
s
> > errors with the section size check happen earlier in the module load
> > process. This check seems to be one of the last, c.f.
> > https://elixir.bootlin.com/linux/v6.10/source/kernel/module/main.c#L290=
8
> >
> >> [ 1468.329988] module lttng_ring_buffer_client_discard:
> >> .gnu.linkonce.this_module section size must match the kernel's built
> >> struct module size at run time
> >> ```
> >>
> >> I'm unsure of their meaning. After loading my module, how can I be
> >> certain that my tracepoints are active? I read online that people use
> >> `sudo lttng list -k` for this purpose, but when I tried it, I got the
> >> error: "Error: Unable to list kernel events: Kernel tracer not
> >> available". Is there another way?
> >
> > If you're still getting "kernel tracer not available" then either
> > required kernel modules haven't been loaded or you started lttng-sessio=
n
> > with `--no-kernel` option. `lttng-sessiond -vvv`, dmesg, and/or
> > journalctl should have information on which modules failed to load.
> >
>
> I know you're doing `sudo lttng list -k`, but the basic checks still appl=
y:
>
> - is the lttng-sessiond running as the root user
> - (when running without sudo) does the tracing group exist, and is your
> user a member of that group
>
> > kienan
> >
> >>
> >> Thank you for your assistance.
> >>
> >> Le mer. 17 juill. 2024, =C3=A0 12 h 08, Kienan Stewart
> >> <kstewart@efficios.com <mailto:kstewart@efficios.com>> a =C3=A9crit :
> >>
> >>     Hi Fran=C3=A7ois,
> >>
> >>     On 7/17/24 11:47 AM, Fran=C3=A7ois Belias wrote:
> >>      > Hello, Kienan
> >>      >
> >>      >
> >>      > *Right. Which kernel are you actually running at this time? You
> >>     can check
> >>      > using: `uname -a`*
> >>      > Linux philippe 6.5.0-41-generic #41~22.04.2-Ubuntu SMP
> >>     PREEMPT_DYNAMIC
> >>      > Mon Jun  3 11:32:55 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
> >>      >
> >>      > *Since you've got a few different images and headers installed,
> >> it is
> >>      > possible to check that same info the linux-source package:
> >> `dpkg -l |
> >>      > grep linux-source`.*
> >>      > ii  linux-source                                   5.15.0.116.1=
16
> >>      >                               all          Linux kernel source
> >> with
> >>      > Ubuntu patches
> >>      > ii  linux-source-5.15.0                       5.15.0-116.126
> >>      >                         all          Linux kernel source for
> >> version
> >>      > 5.15.0 with Ubuntu patches
> >>      > ii  linux-source-6.5.0                      6.5.0-44.44~22.04.1
> >>      >                        all          Linux kernel source for
> >> version
> >>
> >>     Your currently running `6.5.0-41-generic #41~22.04.2-Ubuntu`
> >>
> >>     You have source installed for `6.5.0-44.44~22.04.1`. From your
> >> previous
> >>     e-mail, there is also a linux image installed:
> >>
> >>     ```
> >>     linux-image-6.5.0-44-generic 6.5.0-44.44~22.04.1
> >>     ```
> >>
> >>     Assuming you are using grub, could you verify that one of the
> options
> >>     for booting in `/boot/grub/grub.cfg` is linux 6.5.0-44.44. Look
> >> for the
> >>     lines similar to the following inside a menu entry block:
> >>
> >>     (Note my example is 5.15.0-116, but you will be lookng for
> >> 6.5.0-44 or
> >>     6.5.0-44.44)
> >>
> >>     ```
> >>     linux   /boot/vmlinuz-5.15.0-116-generic root=3D....
> >>     initrd  /boot/initrd.img-5.15.0-116-generic
> >>     ```
> >>
> >>     If you have a grub entry for linux 6.5.0-44.44, could you reboot
> >> to run
> >>     on the linux 6.5.0-44.44.
> >>
> >>     After rebooting verify with `uname -a` that your kernel version is
> >>     6.5.0-44.44.
> >>
> >>     Make sure you have unpacked the linux sources:
> >>
> >>     ```
> >>     # Approximating the version numbers, since I don't have 6.5.0
> >> installed
> >>     cd /usr/src/linux-source-6.5.0
> >>     bunzip2 linux-source-6.5.0.tar.bz2
> >>     tar -xf linux-source-6.5.0.tar
> >>     ```
> >>
> >>     Then retry the build with
> >>     `KERNELDIR=3D/usr/src/linux-source-6.5.0/linux-source-6.5.0/`
> >>
> >>     I haven't personally tried the full steps on an Ubuntu
> >> installation so
> >>     you may still need to tweak a couple of things, but I think this
> >> should
> >>     get you on the right path.
> >>
> >>     Really the important thing is to make sure that the kernel source
> >> code
> >>     matches the kernel you are running.
> >>
> >>      > 6.5.0 with Ubuntu patches
> >>      > *Could you run either `apt-cache policy` or `apt policy` and
> >>     `apt-mark
> >>      > showhold` in order to know which sources you have configured.*
> >>      > For this part, /*apt-mark showhold*/ gave me nothing I don't kn=
ow
> >>     what
> >>      > is means.
> >>
> >>     `apt-mark showhold` will show any packages that are on hold - it i=
s
> a
> >>     way of marking packages that shouldn't be updated.
> >>
> >>     As you have the linux-source for 6.5.0-44.44~22.04.1, I don't
> >> think it
> >>     will be necessary to have the output of `apt-cache policy`.
> >>
> >>     thanks,
> >>     kienan
> >>
> >>      >
> >>      > I am looking at the links, but nothing seems to match my kernel
> >>     version.
> >>      >
> >>      > Thanks for your assistance.
> >>      >
> >>      > Le mer. 17 juill. 2024, =C3=A0 11 h 46, Fran=C3=A7ois Belias
> >>      > <beliasossim@gmail.com <mailto:beliasossim@gmail.com>
> >>     <mailto:beliasossim@gmail.com <mailto:beliasossim@gmail.com>>> a
> >> =C3=A9crit :
> >>      >
> >>      >     Hello, Kienan
> >>      >
> >>      >
> >>      >     *Right. Which kernel are you actually running at this time?
> >>     You can
> >>      >     check
> >>      >     using: `uname -a`*
> >>      >     Linux philippe 6.5.0-41-generic #41~22.04.2-Ubuntu SMP
> >>      >     PREEMPT_DYNAMIC Mon Jun  3 11:32:55 UTC 2 x86_64 x86_64
> >>     x86_64 GNU/Linux
> >>      >
> >>      >     *Since you've got a few different images and headers
> >>     installed, it is
> >>      >     possible to check that same info the linux-source package:
> >>     `dpkg -l |
> >>      >     grep linux-source`.*
> >>      >     ii  linux-source       5.15.0.116.116
> >>      >                                       all          Linux kernel
> >>     source
> >>      >     with Ubuntu patches
> >>      >     ii  linux-source-5.15.0                       5.15.0-116.12=
6
> >>      >                                 all          Linux kernel
> >> source for
> >>      >     version 5.15.0 with Ubuntu patches
> >>      >     ii  linux-source-6.5.0
> >> 6.5.0-44.44~22.04.1
> >>      >                                all          Linux kernel source
> >> for
> >>      >     version 6.5.0 with Ubuntu patches
> >>      >     *Could you run either `apt-cache policy` or `apt policy` an=
d
> >>     `apt-mark
> >>      >     showhold` in order to know which sources you have
> configured.*
> >>      >     For this part, /*apt-mark showhold*/ gave me nothing I
> >> don't know
> >>      >     what is means.
> >>      >
> >>      >     I am looking at the links, but nothing seems to match my
> >> kernel
> >>      >     version.
> >>      >
> >>      >     Thanks for your assistance.
> >>      >
> >>      >     Le mer. 17 juill. 2024, =C3=A0 10 h 55, Kienan Stewart
> >>      >     <kstewart@efficios.com <mailto:kstewart@efficios.com>
> >>     <mailto:kstewart@efficios.com <mailto:kstewart@efficios.com>>> a
> >> =C3=A9crit :
> >>      >
> >>      >         Hi Fran=C3=A7ois,
> >>      >
> >>      >         On 7/16/24 4:34 PM, Fran=C3=A7ois Belias wrote:
> >>      >          > Hello Kienan,
> >>      >          >
> >>      >          > When I proceed with the following steps:
> >>      >          >
> >>      >          > ```
> >>      >          > # Warning: this removes all untracked content from t=
he
> >>      >         lttng-modules
> >>      >          > directory
> >>      >          > cd /path/to/lttng-modules-source
> >>      >          > git clean -dxf
> >>      >          >
> >>      >          > make
> >>      >          > sudo make modules_install
> >>      >          > sudo depmod -a
> >>      >          > ```
> >>      >          >
> >>      >          > I encounter a warning in
> >>      >          > `/home/philippe/lttng-modules/src/probes/Kbuild:79`
> >>     stating
> >>      >         "File
> >>      >          > ./arch/x86/kvm/lapic.h not found. Probe 'kvm'
> >>     x86-specific is
> >>      >         disabled.
> >>      >          > Use full kernel source tree to enable it." Although
> >>      >         everything compiles
> >>      >          > fine and I'm able to load modules, when I execute
> >>     `sudo lttng
> >>      >         list -k`,
> >>      >          > I don't see the tracepoints `kvm_entry` and
> >>     `kvm_exit`, which
> >>      >         I believe
> >>      >          > should be available. Could this be due to not using =
my
> >>     full
> >>      >         kernel tree
> >>      >          > during compilation?
> >>      >
> >>      >
> >>      >         Exactly. Those probes depend on having the full kernel
> >>     source as
> >>      >         they
> >>      >         require private headers which aren't shipped as part of
> >> the
> >>      >         `linux-headers` package.
> >>      >
> >>      >          >
> >>      >          > Here are the answers to your questions:
> >>      >          >
> >>      >          > - *Where did `/usr/src/linux-source-6.5.0` come from=
?*
> >>      >          >    I initially attempted `sudo apt-get update && sud=
o
> >>     apt-get
> >>      >         install
> >>      >          > linux-source`, but it gave me this answer
> >>     */linux-source is
> >>      >         already the
> >>      >          > newest version (5.15.0.116.116)/*`, which doesn't
> >> match my
> >>      >         current
> >>      >          > kernel version. So, I downloaded it directly from
> >>     kernel.org <http://kernel.org>
> >>      >         <http://kernel.org <http://kernel.org>>
> >>      >          > <http://kernel.org <http://kernel.org>
> >>     <http://kernel.org <http://kernel.org>>> using this command:
> >>      >         `wget
> >>      >          >
> >>      > https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz`
> <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz>
> >>     <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz>
> >>      >
> >>  <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz
> >>     <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz>>
> >>      >          >
> >>      >
> >>  <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz`
> <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz>
> >>     <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz>
> >>      >
> >>  <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz
> >>     <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz>>>.
> >>      >          >
> >>      >
> >>      >         Right. Which kernel are you actually running at this
> >>     time? You
> >>      >         can check
> >>      >         using: `uname -a`
> >>      >
> >>      >         In any case, Linux upstream 6.5 is not the same as
> >>     Ubuntus's 6.5.
> >>      >
> >>      >          > - *Which Linux distribution and version are you
> using?*
> >>      >          >    Running `lsb_release -a` gives me:
> >>      >          >    ```
> >>      >          >    No LSB modules are available.
> >>      >          >    Distributor ID: Ubuntu
> >>      >          >    Description:    Ubuntu 22.04.4 LTS
> >>      >          >    Release:        22.04
> >>      >          >    Codename:       jammy
> >>      >          >    ```
> >>      >          >
> >>      >          > - *Assuming your distribution has kernel packages,
> >>     which do
> >>      >         you have
> >>      >          > installed, and do you have the corresponding kernel
> >>     headers
> >>      >         package
> >>      >          > installed?*
> >>      >          >
> >>      >          >    Running `dpkg -l | grep linux-image` shows these
> >>     installed
> >>      >         packages:
> >>      >          >    ```
> >>      >          >    ii  linux-image-5.15.0-116-generic
> >> 5.15.0-116.126
> >>      >          >   amd64   Signed kernel image generic
> >>      >          >    ii  linux-image-6.5.0-28-generic
> >>      >         6.5.0-28.29~22.04.1
> >>      >          >   amd64   Signed kernel image generic
> >>      >          >    ii  linux-image-6.5.0-41-generic
> >>      >         6.5.0-41.41~22.04.2
> >>      >          >   amd64   Signed kernel image generic
> >>      >          >    ii  linux-image-6.5.0-44-generic
> >>      >         6.5.0-44.44~22.04.1
> >>      >          >   amd64   Signed kernel image generic
> >>      >          >    ii  linux-image-generic       5.15.0.116.116
> >>      >          >   amd64   Generic Linux kernel image
> >>      >          >    ii  linux-image-generic-hwe-22.04
> >>      >           6.5.0.44.44~22.04.1
> >>      >          >   amd64   Generic Linux kernel image
> >>      >          >    ```
> >>      >          >
> >>      >          >    And `dpkg -l | grep linux-headers` shows these
> >>     installed
> >>      >         header packages:
> >>      >          >    ```
> >>      >          >    ii  linux-headers-5.15.0-116
> >>      >         5.15.0-116.126      all
> >>      >          >      Header files related to Linux kernel version
> >> 5.15.0
> >>      >          >    ii  linux-headers-5.15.0-116-generic
> >> 5.15.0-116.126
> >>      >          >   amd64   Linux kernel headers for version 5.15.0 on
> >>     64 bit
> >>      >         x86 SMP
> >>      >          >    ii  linux-headers-6.5.0-28-generic
> >>      >         6.5.0-28.29~22.04.1
> >>      >          >   amd64   Linux kernel headers for version 6.5.0 on
> >> 64 bit
> >>      >         x86 SMP
> >>      >          >    ii  linux-headers-6.5.0-41-generic
> >>      >         6.5.0-41.41~22.04.2
> >>      >          >   amd64   Linux kernel headers for version 6.5.0 on
> >> 64 bit
> >>      >         x86 SMP
> >>      >          >    ii  linux-headers-6.5.0-44-generic
> >>      >         6.5.0-44.44~22.04.1
> >>      >          >   amd64   Linux kernel headers for version 6.5.0 on
> >> 64 bit
> >>      >         x86 SMP
> >>      >          >    ii  linux-headers-generic       5.15.0.116.116
> >>      >          >   amd64   Generic Linux kernel headers
> >>      >          >    ii  linux-headers-generic-hwe-22.04
> >>      >           6.5.0.44.44~22.04.1
> >>      >          >   amd64   Generic Linux kernel headers
> >>      >          >    ```
> >>      >          >
> >>      >
> >>      >         Since you've got a few different images and headers
> >>     installed,
> >>      >         it is
> >>      >         possible to check that same info the linux-source
> >>     package: `dpkg
> >>      >         -l |
> >>      >         grep linux-source`.
> >>      >
> >>      >         Maybe one thing tripping this process up is that you
> >>     don't have
> >>      >         an apt
> >>      >         source that provides linux-source that matches the
> >> kernel you
> >>      >         are using.
> >>      >         Could you run either `apt-cache policy` or `apt policy`
> >> and
> >>      >         `apt-mark
> >>      >         showhold` in order to know which sources you have
> >> configured.
> >>      >
> >>      >         There are also alternative sources for the full source
> >> tree:
> >>      >
> >>      >         - You could download the specific package from
> >>      > packages.ubuntu.com <http://packages.ubuntu.com>
> >>     <http://packages.ubuntu.com <http://packages.ubuntu.com>>. See
> >>      > https://packages.ubuntu.com <https://packages.ubuntu.com>
> >>     <https://packages.ubuntu.com <https://packages.ubuntu.com>> and
> >>      >         use `apt install ./downloaded_package.deb`
> >>      >
> >>      >         - You could clone the kernel source for Ubuntu and
> >>     checkout the
> >>      >         appropriate tag. See
> >>      >
> >>
> >>
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/=
refs/tags
> <
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/=
refs/tags>
> <
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/=
refs/tags
> <
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/=
refs/tags
> >>
> >>      >
> >>      >         thanks,
> >>      >         kienan
> >>      >
> >>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--000000000000b5bc0c061d8ad7a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello=C2=A0Kienan,=C2=A0=C2=A0<div><br></div><div>=C2=A0my=
 issue has been fixed. thanks for your help</div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le jeu. 18 juill. 2024, =
=C3=A0 10 h 58, Kienan Stewart &lt;<a href=3D"mailto:kstewart@efficios.com"=
>kstewart@efficios.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">A couple of addendums inline below<br>
<br>
On 7/18/24 10:47 AM, Kienan Stewart via lttng-dev wrote:<br>
&gt; Hi Fran=C3=A7ois,<br>
&gt; <br>
&gt; The dmesg excerpts are spaced by a number of minutes each, are they fr=
om <br>
&gt; different attempts to build and load the modules?<br>
&gt; <br>
&gt; On 7/17/24 8:44 PM, Fran=C3=A7ois Belias wrote:<br>
&gt;&gt; Hello Kienan,<br>
&gt;&gt;<br>
&gt;&gt; Thanks to your advice, I managed to load some modules. However, I =
<br>
&gt;&gt; encountered errors like these when running `dmesg | grep lttng`:<b=
r>
&gt;&gt;<br>
&gt;&gt; ```<br>
&gt;&gt; [ =C2=A0218.043672] module lttng_kretprobes: .gnu.linkonce.this_mo=
dule <br>
&gt;&gt; section size must match the kernel&#39;s built struct module size =
at run time<br>
&gt; <br>
&gt; This sounds like the version of the module is built against the wrong =
<br>
&gt; kernel headers or source.<br>
<br>
Also, are you using lttng-modules master or did you swap back to <br>
stable-2.13?<br>
<br>
If you&#39;re still on master and have the most recent changes <br>
lttng_kretprobes isn&#39;t required anymore. You will also need lttng-tools=
 <br>
from master with the corresponding changes so that it doesn&#39;t try to <b=
r>
load lttng_kretprobes.<br>
<br>
&gt; <br>
&gt;&gt; [ =C2=A0650.560883] lttng_kretprobes: module verification failed: =
signature <br>
&gt;&gt; and/or required key missing - tainting kernel<br>
&gt; <br>
&gt; Is your system running with secure boot enabled? If so, you either nee=
d <br>
&gt; to disable secure boot or sign the built modules with a MOK key that i=
s <br>
&gt; correctly enrolled.<br>
&gt; <br>
&gt; See the following documentation:<br>
&gt; <br>
&gt; - <a href=3D"https://lttng.org/docs/v2.13/#doc-linux-kernel-sig" rel=
=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/v2.13/#doc-linux-k=
ernel-sig</a><br>
&gt; - <a href=3D"https://www.kernel.org/doc/html/latest/admin-guide/module=
-signing.html" rel=3D"noreferrer" target=3D"_blank">https://www.kernel.org/=
doc/html/latest/admin-guide/module-signing.html</a><br>
&gt; - <a href=3D"https://github.com/dell/dkms" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/dell/dkms</a><br>
&gt; - <br>
&gt; <a href=3D"https://gitlab.com/linux-kernel/stable/-/blob/master/kernel=
/module/main.c#L2064" rel=3D"noreferrer" target=3D"_blank">https://gitlab.c=
om/linux-kernel/stable/-/blob/master/kernel/module/main.c#L2064</a><br>
&gt; <br>
&gt; Whatever you did for this test is pretty closed to working. The previo=
us <br>
&gt; errors with the section size check happen earlier in the module load <=
br>
&gt; process. This check seems to be one of the last, c.f. <br>
&gt; <a href=3D"https://elixir.bootlin.com/linux/v6.10/source/kernel/module=
/main.c#L2908" rel=3D"noreferrer" target=3D"_blank">https://elixir.bootlin.=
com/linux/v6.10/source/kernel/module/main.c#L2908</a><br>
&gt; <br>
&gt;&gt; [ 1468.329988] module lttng_ring_buffer_client_discard: <br>
&gt;&gt; .gnu.linkonce.this_module section size must match the kernel&#39;s=
 built <br>
&gt;&gt; struct module size at run time<br>
&gt;&gt; ```<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m unsure of their meaning. After loading my module, how can =
I be <br>
&gt;&gt; certain that my tracepoints are active? I read online that people =
use <br>
&gt;&gt; `sudo lttng list -k` for this purpose, but when I tried it, I got =
the <br>
&gt;&gt; error: &quot;Error: Unable to list kernel events: Kernel tracer no=
t <br>
&gt;&gt; available&quot;. Is there another way?<br>
&gt; <br>
&gt; If you&#39;re still getting &quot;kernel tracer not available&quot; th=
en either <br>
&gt; required kernel modules haven&#39;t been loaded or you started lttng-s=
ession <br>
&gt; with `--no-kernel` option. `lttng-sessiond -vvv`, dmesg, and/or <br>
&gt; journalctl should have information on which modules failed to load.<br=
>
&gt; <br>
<br>
I know you&#39;re doing `sudo lttng list -k`, but the basic checks still ap=
ply:<br>
<br>
- is the lttng-sessiond running as the root user<br>
- (when running without sudo) does the tracing group exist, and is your <br=
>
user a member of that group<br>
<br>
&gt; kienan<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; Thank you for your assistance.<br>
&gt;&gt;<br>
&gt;&gt; Le mer. 17 juill. 2024, =C3=A0 12 h 08, Kienan Stewart <br>
&gt;&gt; &lt;<a href=3D"mailto:kstewart@efficios.com" target=3D"_blank">kst=
ewart@efficios.com</a> &lt;mailto:<a href=3D"mailto:kstewart@efficios.com" =
target=3D"_blank">kstewart@efficios.com</a>&gt;&gt; a =C3=A9crit=C2=A0:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Hi Fran=C3=A7ois,<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 On 7/17/24 11:47 AM, Fran=C3=A7ois Belias wrote=
:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; Hello, Kienan<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; *Right. Which kernel are you actuall=
y running at this time? You<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 can check<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; using: `uname -a`*<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; Linux philippe 6.5.0-41-generic #41~=
22.04.2-Ubuntu SMP<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 PREEMPT_DYNAMIC<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; Mon Jun =C2=A03 11:32:55 UTC 2 x86_6=
4 x86_64 x86_64 GNU/Linux<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; *Since you&#39;ve got a few differen=
t images and headers installed, <br>
&gt;&gt; it is<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; possible to check that same info the=
 linux-source package: <br>
&gt;&gt; `dpkg -l |<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; grep linux-source`.*<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; ii =C2=A0linux-source=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05.15.0.116.116<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0all =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux kernel source <br>
&gt;&gt; with<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; Ubuntu patches<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; ii =C2=A0linux-source-5.15.0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A05.15.0-116.126<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0all =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Linux kernel source for <br>
&gt;&gt; version<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; 5.15.0 with Ubuntu patches<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; ii =C2=A0linux-source-6.5.0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.5.0=
-44.44~22.04.1<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 all =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0Linux kernel source for <br>
&gt;&gt; version<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Your currently running `6.5.0-41-generic #41~22=
.04.2-Ubuntu`<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 You have source installed for `6.5.0-44.44~22.0=
4.1`. From your <br>
&gt;&gt; previous<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 e-mail, there is also a linux image installed:<=
br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 ```<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 linux-image-6.5.0-44-generic 6.5.0-44.44~22.04.=
1<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 ```<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Assuming you are using grub, could you verify t=
hat one of the options<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 for booting in `/boot/grub/grub.cfg` is linux 6=
.5.0-44.44. Look <br>
&gt;&gt; for the<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 lines similar to the following inside a menu en=
try block:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 (Note my example is 5.15.0-116, but you will be=
 lookng for <br>
&gt;&gt; 6.5.0-44 or<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 6.5.0-44.44)<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 ```<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 linux=C2=A0 =C2=A0/boot/vmlinuz-5.15.0-116-gene=
ric root=3D....<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 initrd=C2=A0 /boot/initrd.img-5.15.0-116-generi=
c<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 ```<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 If you have a grub entry for linux 6.5.0-44.44,=
 could you reboot <br>
&gt;&gt; to run<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 on the linux 6.5.0-44.44.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 After rebooting verify with `uname -a` that you=
r kernel version is<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 6.5.0-44.44.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Make sure you have unpacked the linux sources:<=
br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 ```<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 # Approximating the version numbers, since I do=
n&#39;t have 6.5.0 <br>
&gt;&gt; installed<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 cd /usr/src/linux-source-6.5.0<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 bunzip2 linux-source-6.5.0.tar.bz2<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 tar -xf linux-source-6.5.0.tar<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 ```<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Then retry the build with<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 `KERNELDIR=3D/usr/src/linux-source-6.5.0/linux-=
source-6.5.0/`<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 I haven&#39;t personally tried the full steps o=
n an Ubuntu <br>
&gt;&gt; installation so<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 you may still need to tweak a couple of things,=
 but I think this <br>
&gt;&gt; should<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 get you on the right path.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Really the important thing is to make sure that=
 the kernel source <br>
&gt;&gt; code<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 matches the kernel you are running.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; 6.5.0 with Ubuntu patches<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; *Could you run either `apt-cache pol=
icy` or `apt policy` and<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 `apt-mark<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; showhold` in order to know which sou=
rces you have configured.*<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; For this part, /*apt-mark showhold*/=
=C2=A0gave me nothing I don&#39;t know<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 what<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; is means.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 `apt-mark showhold` will show any packages that=
 are on hold - it is a<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 way of marking packages that shouldn&#39;t be u=
pdated.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 As you have the linux-source for 6.5.0-44.44~22=
.04.1, I don&#39;t <br>
&gt;&gt; think it<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 will be necessary to have the output of `apt-ca=
che policy`.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 thanks,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 kienan<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; I am looking at the links, but nothi=
ng seems to match my kernel<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 version.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; Thanks for your assistance.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; Le mer. 17 juill. 2024, =C3=A0 11 h =
46, Fran=C3=A7ois Belias<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; &lt;<a href=3D"mailto:beliasossim@gm=
ail.com" target=3D"_blank">beliasossim@gmail.com</a> &lt;mailto:<a href=3D"=
mailto:beliasossim@gmail.com" target=3D"_blank">beliasossim@gmail.com</a>&g=
t;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;mailto:<a href=3D"mailto:beliasossim@gmail.=
com" target=3D"_blank">beliasossim@gmail.com</a> &lt;mailto:<a href=3D"mail=
to:beliasossim@gmail.com" target=3D"_blank">beliasossim@gmail.com</a>&gt;&g=
t;&gt; a <br>
&gt;&gt; =C3=A9crit=C2=A0:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Hello, Kienan<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0*Right. Which ker=
nel are you actually running at this time?<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 You can<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0check<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0using: `uname -a`=
*<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Linux philippe 6.=
5.0-41-generic #41~22.04.2-Ubuntu SMP<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0PREEMPT_DYNAMIC M=
on Jun =C2=A03 11:32:55 UTC 2 x86_64 x86_64<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 x86_64 GNU/Linux<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0*Since you&#39;ve=
 got a few different images and headers<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 installed, it is<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0possible to check=
 that same info the linux-source package:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 `dpkg -l |<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0grep linux-source=
`.*<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0ii =C2=A0linux-so=
urce =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A05.15.0.116.116<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0all =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux =
kernel<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 source<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0with Ubuntu patch=
es<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0ii =C2=A0linux-so=
urce-5.15.0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A05.15.0-116.126<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0all =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux kernel <br>
&gt;&gt; source for<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0version 5.15.0 wi=
th Ubuntu patches<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0ii =C2=A0linux-so=
urce-6.5.0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <br>
&gt;&gt; 6.5.0-44.44~22.04.1<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 all =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux kernel source <br>
&gt;&gt; for<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0version 6.5.0 wit=
h Ubuntu patches<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0*Could you run ei=
ther `apt-cache policy` or `apt policy` and<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 `apt-mark<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0showhold` in orde=
r to know which sources you have configured.*<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0For this part, /*=
apt-mark showhold*/ gave me nothing I <br>
&gt;&gt; don&#39;t know<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0what is means.<br=
>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0I am looking at t=
he links, but nothing seems to match my <br>
&gt;&gt; kernel<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0version.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Thanks for your a=
ssistance.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Le mer. 17 juill.=
 2024, =C3=A0 10 h 55, Kienan Stewart<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"ma=
ilto:kstewart@efficios.com" target=3D"_blank">kstewart@efficios.com</a> &lt=
;mailto:<a href=3D"mailto:kstewart@efficios.com" target=3D"_blank">kstewart=
@efficios.com</a>&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;mailto:<a href=3D"mailto:kstewart@efficios.=
com" target=3D"_blank">kstewart@efficios.com</a> &lt;mailto:<a href=3D"mail=
to:kstewart@efficios.com" target=3D"_blank">kstewart@efficios.com</a>&gt;&g=
t;&gt; a <br>
&gt;&gt; =C3=A9crit=C2=A0:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hi =
Fran=C3=A7ois,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On =
7/16/24 4:34 PM, Fran=C3=A7ois Belias wrote:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; Hello Kienan,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; When I proceed with the following steps:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; ```<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; # Warning: this removes all untracked content from the<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ltt=
ng-modules<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; directory<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; cd /path/to/lttng-modules-source<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; git clean -dxf<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; make<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; sudo make modules_install<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; sudo depmod -a<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; ```<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; I encounter a warning in<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; `/home/philippe/lttng-modules/src/probes/Kbuild:79`<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 stating<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&qu=
ot;File<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; ./arch/x86/kvm/lapic.h not found. Probe &#39;kvm&#39;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 x86-specific is<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dis=
abled.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; Use full kernel source tree to enable it.&quot; Although<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eve=
rything compiles<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; fine and I&#39;m able to load modules, when I execute<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 `sudo lttng<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lis=
t -k`,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; I don&#39;t see the tracepoints `kvm_entry` and<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 `kvm_exit`, which<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I b=
elieve<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; should be available. Could this be due to not using my<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 full<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ker=
nel tree<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; during compilation?<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Exa=
ctly. Those probes depend on having the full kernel<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 source as<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the=
y<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req=
uire private headers which aren&#39;t shipped as part of <br>
&gt;&gt; the<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0`li=
nux-headers` package.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; Here are the answers to your questions:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; - *Where did `/usr/src/linux-source-6.5.0` come from?*<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 I initially attempted `sudo apt-get update &amp;&amp; sudo<=
br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 apt-get<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ins=
tall<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; linux-source`, but it gave me this answer<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 */linux-source is<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0alr=
eady the<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; newest version (5.15.0.116.116)/*`, which doesn&#39;t <br>
&gt;&gt; match my<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cur=
rent<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; kernel version. So, I downloaded it directly from<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 <a href=3D"http://kernel.org" rel=3D"noreferrer=
" target=3D"_blank">kernel.org</a> &lt;<a href=3D"http://kernel.org" rel=3D=
"noreferrer" target=3D"_blank">http://kernel.org</a>&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt=
;<a href=3D"http://kernel.org" rel=3D"noreferrer" target=3D"_blank">http://=
kernel.org</a> &lt;<a href=3D"http://kernel.org" rel=3D"noreferrer" target=
=3D"_blank">http://kernel.org</a>&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; &lt;<a href=3D"http://kernel.org" rel=3D"noreferrer" target=3D"_blank">h=
ttp://kernel.org</a> &lt;<a href=3D"http://kernel.org" rel=3D"noreferrer" t=
arget=3D"_blank">http://kernel.org</a>&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;<a href=3D"http://kernel.org" rel=3D"norefe=
rrer" target=3D"_blank">http://kernel.org</a> &lt;<a href=3D"http://kernel.=
org" rel=3D"noreferrer" target=3D"_blank">http://kernel.org</a>&gt;&gt;&gt;=
 using this command:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0`wg=
et<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; <a href=3D"https://cdn.kernel.org/pu=
b/linux/kernel/v6.x/linux-6.5.tar.xz" rel=3D"noreferrer" target=3D"_blank">=
https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz`</a><br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;<a href=3D"https://cdn.kernel.org/pub/linux=
/kernel/v6.x/linux-6.5.tar.xz" rel=3D"noreferrer" target=3D"_blank">https:/=
/cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz</a>&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 <br>
&gt;&gt; =C2=A0&lt;<a href=3D"https://cdn.kernel.org/pub/linux/kernel/v6.x/=
linux-6.5.tar.xz" rel=3D"noreferrer" target=3D"_blank">https://cdn.kernel.o=
rg/pub/linux/kernel/v6.x/linux-6.5.tar.xz</a><br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;<a href=3D"https://cdn.kernel.org/pub/linux=
/kernel/v6.x/linux-6.5.tar.xz" rel=3D"noreferrer" target=3D"_blank">https:/=
/cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz</a>&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 <br>
&gt;&gt; =C2=A0&lt;<a href=3D"https://cdn.kernel.org/pub/linux/kernel/v6.x/=
linux-6.5.tar.xz" rel=3D"noreferrer" target=3D"_blank">https://cdn.kernel.o=
rg/pub/linux/kernel/v6.x/linux-6.5.tar.xz`</a><br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;<a href=3D"https://cdn.kernel.org/pub/linux=
/kernel/v6.x/linux-6.5.tar.xz" rel=3D"noreferrer" target=3D"_blank">https:/=
/cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz</a>&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 <br>
&gt;&gt; =C2=A0&lt;<a href=3D"https://cdn.kernel.org/pub/linux/kernel/v6.x/=
linux-6.5.tar.xz" rel=3D"noreferrer" target=3D"_blank">https://cdn.kernel.o=
rg/pub/linux/kernel/v6.x/linux-6.5.tar.xz</a><br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;<a href=3D"https://cdn.kernel.org/pub/linux=
/kernel/v6.x/linux-6.5.tar.xz" rel=3D"noreferrer" target=3D"_blank">https:/=
/cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz</a>&gt;&gt;&gt;.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Rig=
ht. Which kernel are you actually running at this<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 time? You<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0can=
 check<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usi=
ng: `uname -a`<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0In =
any case, Linux upstream 6.5 is not the same as<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Ubuntus&#39;s 6.5.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; - *Which Linux distribution and version are you using?*<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 Running `lsb_release -a` gives me:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ```<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 No LSB modules are available.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 Distributor ID: Ubuntu<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 Description: =C2=A0 =C2=A0Ubuntu 22.04.4 LTS<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 Release: =C2=A0 =C2=A0 =C2=A0 =C2=A022.04<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 Codename: =C2=A0 =C2=A0 =C2=A0 jammy<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ```<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; - *Assuming your distribution has kernel packages,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 which do<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0you=
 have<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; installed, and do you have the corresponding kernel<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 headers<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pac=
kage<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t; installed?*<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 Running `dpkg -l | grep linux-image` shows these<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 installed<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pac=
kages:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ```<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ii =C2=A0linux-image-5.15.0-116-generic=C2=A0 =C2=A0 =C2=A0=
<br>
&gt;&gt; 5.15.0-116.126<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0amd64 =C2=A0 Signed kernel image generic<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ii =C2=A0linux-image-6.5.0-28-generic<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5=
.0-28.29~22.04.1<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0amd64 =C2=A0 Signed kernel image generic<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ii =C2=A0linux-image-6.5.0-41-generic<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5=
.0-41.41~22.04.2<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0amd64 =C2=A0 Signed kernel image generic<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ii =C2=A0linux-image-6.5.0-44-generic<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5=
.0-44.44~22.04.1<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0amd64 =C2=A0 Signed kernel image generic<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ii =C2=A0linux-image-generic =C2=A0=C2=A0=C2=A0=C2=A0 =C2=
=A05.15.0.116.116<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0amd64 =C2=A0 Generic Linux kernel image<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ii =C2=A0linux-image-generic-hwe-22.04<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A06.5.0.44.44~22.04.1<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0amd64 =C2=A0 Generic Linux kernel image<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ```<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 And `dpkg -l | grep linux-headers` shows these<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 installed<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hea=
der packages:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ```<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ii =C2=A0linux-headers-5.15.0-116<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05.1=
5.0-116.126 =C2=A0 =C2=A0 =C2=A0all<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 =C2=A0 Header files related to Linux kernel version <br>
&gt;&gt; 5.15.0<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ii =C2=A0linux-headers-5.15.0-116-generic=C2=A0 =C2=A0 =C2=
=A0<br>
&gt;&gt; 5.15.0-116.126<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0amd64 =C2=A0 Linux kernel headers for version 5.15.0 on<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 64 bit<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x86=
 SMP<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ii =C2=A0linux-headers-6.5.0-28-generic<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5=
.0-28.29~22.04.1<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0amd64 =C2=A0 Linux kernel headers for version 6.5.0 on <br>
&gt;&gt; 64 bit<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x86=
 SMP<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ii =C2=A0linux-headers-6.5.0-41-generic<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5=
.0-41.41~22.04.2<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0amd64 =C2=A0 Linux kernel headers for version 6.5.0 on <br>
&gt;&gt; 64 bit<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x86=
 SMP<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ii =C2=A0linux-headers-6.5.0-44-generic<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5=
.0-44.44~22.04.1<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0amd64 =C2=A0 Linux kernel headers for version 6.5.0 on <br>
&gt;&gt; 64 bit<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x86=
 SMP<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ii =C2=A0linux-headers-generic =C2=A0=C2=A0=C2=A0=C2=A0 =C2=
=A05.15.0.116.116<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0amd64 =C2=A0 Generic Linux kernel headers<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ii =C2=A0linux-headers-generic-hwe-22.04<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A06.5.0.44.44~22.04.1<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0amd64 =C2=A0 Generic Linux kernel headers<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;=C2=A0 =C2=A0 ```<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &g=
t;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Sin=
ce you&#39;ve got a few different images and headers<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 installed,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0it =
is<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pos=
sible to check that same info the linux-source<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 package: `dpkg<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-l =
|<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gre=
p linux-source`.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0May=
be one thing tripping this process up is that you<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 don&#39;t have<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0an =
apt<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sou=
rce that provides linux-source that matches the <br>
&gt;&gt; kernel you<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0are=
 using.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Cou=
ld you run either `apt-cache policy` or `apt policy` <br>
&gt;&gt; and<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0`ap=
t-mark<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sho=
whold` in order to know which sources you have <br>
&gt;&gt; configured.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The=
re are also alternative sources for the full source <br>
&gt;&gt; tree:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Y=
ou could download the specific package from<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; <a href=3D"http://packages.ubuntu.co=
m" rel=3D"noreferrer" target=3D"_blank">packages.ubuntu.com</a> &lt;<a href=
=3D"http://packages.ubuntu.com" rel=3D"noreferrer" target=3D"_blank">http:/=
/packages.ubuntu.com</a>&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;<a href=3D"http://packages.ubuntu.com" rel=
=3D"noreferrer" target=3D"_blank">http://packages.ubuntu.com</a> &lt;<a hre=
f=3D"http://packages.ubuntu.com" rel=3D"noreferrer" target=3D"_blank">http:=
//packages.ubuntu.com</a>&gt;&gt;. See<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; <a href=3D"https://packages.ubuntu.c=
om" rel=3D"noreferrer" target=3D"_blank">https://packages.ubuntu.com</a> &l=
t;<a href=3D"https://packages.ubuntu.com" rel=3D"noreferrer" target=3D"_bla=
nk">https://packages.ubuntu.com</a>&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;<a href=3D"https://packages.ubuntu.com" rel=
=3D"noreferrer" target=3D"_blank">https://packages.ubuntu.com</a> &lt;<a hr=
ef=3D"https://packages.ubuntu.com" rel=3D"noreferrer" target=3D"_blank">htt=
ps://packages.ubuntu.com</a>&gt;&gt; and<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use=
 `apt install ./downloaded_package.deb`<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Y=
ou could clone the kernel source for Ubuntu and<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 checkout the<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0app=
ropriate tag. See<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt;&gt; <a href=3D"https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source=
/linux/+git/jammy/refs/tags" rel=3D"noreferrer" target=3D"_blank">https://g=
it.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/refs/tags</=
a> &lt;<a href=3D"https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/l=
inux/+git/jammy/refs/tags" rel=3D"noreferrer" target=3D"_blank">https://git=
.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/refs/tags</a>=
&gt; &lt;<a href=3D"https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source=
/linux/+git/jammy/refs/tags" rel=3D"noreferrer" target=3D"_blank">https://g=
it.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/refs/tags</=
a> &lt;<a href=3D"https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/l=
inux/+git/jammy/refs/tags" rel=3D"noreferrer" target=3D"_blank">https://git=
.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/refs/tags</a>=
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tha=
nks,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kie=
nan<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
</blockquote></div>

--000000000000b5bc0c061d8ad7a5--

--===============9101353945920727453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============9101353945920727453==--
