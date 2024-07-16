Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994BDC3DA59
	for <lttng-dev@archiver.kernel.org>; Tue, 16 Jul 2024 20:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1721162063;
	bh=GnCJp3vxj/rL3b07g4ZCo6/ZWed7XQA2jOIIHvzr+sg=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=j1JMH6HMpbrVSOHqN2T4WP6pWlySrpU0fyuUYgjFUsK/WWBKfBHbL8qkg7a2USpKJ
	 mIGmSQTOaKK/FSbZp9QmxwiX/4lTKRgRtgMvrfZDZ5V8qXy9GOaCw9gqgsGG43+iXf
	 bKKMxRZjLVIjczsi2qsBpxbW0yHD/hq5oTRNRg+DjJASQq+vNby7JtNy3cTkI1gvPN
	 zaspCE4RUeVLlNaACmzfoRnH4k28kI24t5p7jFoUyLcCQKtARHz+HLCQUM547SRQzq
	 nXe/z85aTYOU5qU0FcBvnwMzaaHVmt2rJNMo1suTaToeR9vZjx+IOfFpBkzHhj+ntk
	 1pTlX3xB0aQXA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WNrQR2qPQz12Dx;
	Tue, 16 Jul 2024 16:34:23 -0400 (EDT)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by lists.lttng.org (Postfix) with ESMTPS id 4WNrQQ0Brfz129Y
 for <lttng-dev@lists.lttng.org>; Tue, 16 Jul 2024 16:34:21 -0400 (EDT)
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-78c84837564so2380897a12.3
 for <lttng-dev@lists.lttng.org>; Tue, 16 Jul 2024 13:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721162061; x=1721766861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rDHOsaYXhoZsQBHX8E5duuuS6ArYSZgef8nvT344EQI=;
 b=Kj7WjViBHopCrH6NbKpK3k984nmnEsGJqIHTBNgy1OR7CusocEzlnD7kM3tNc/j3l3
 CJCCzX2fDzZE1WucybyWrYPv0X6f1PY/p/cipdAGldNxBA0NqEWUCWYnvzJ9qC8Y4Moq
 uq2j+6eEf9vs+khg1/H2lD+7+2BSl6apPMtG+kJZSnA/Wjr5+5XzfHqxGGJqagSOflCL
 jYMWv1KXmonP+w00/I6uZs2lmZqDOM6OB5sD4jpZcW6Lpopns5mmBH35smOxqgSAUZUG
 t5IFyCZrVVANEDitshwxr6Z9ThXjtGrZHCXGD6+q20BKI7u6pOA9sq3NYctxWXVCK9O+
 ywFQ==
X-Gm-Message-State: AOJu0Yxje7GleN//BycPiVkTNa3cVBIgpfm28cijXGOi+ldtDEFyNH8Y
 eErgtdyIPKytBEkOyarKz6pqY09irDEkYg4NYfzzBpwtqzcIsuPr5hpM8bGBwVyr7VvAJVdvKvp
 X7G2YfDRUhpzo6NP5r+Hv/z+k1Jo=
X-Google-Smtp-Source: AGHT+IG6Dra1LnwugSLPgKH5FaI4wz0iLS6grhkzDb6f90nhQeO14vsOeVF0Kt+imQfaye2fvOemlfrag7agdJQEuDk=
X-Received: by 2002:a05:6a20:d43:b0:1bf:13f6:7220 with SMTP id
 adf61e73a8af0-1c3f12a4e0bmr3339458637.56.1721162060563; Tue, 16 Jul 2024
 13:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHD10UjoaOjqZUH4j55Ra7zJ2HVRLOyk7xnjv+BjnJxs6rN6Aw@mail.gmail.com>
 <6deffa1d-4d46-4445-a510-a3aac271cc80@efficios.com>
 <CAHD10Ui_JkP9hRirGUvKBgHhWX48r26+M2_zTyOD_cMLnSDGCg@mail.gmail.com>
 <211e6d9f-834d-4511-b315-7844a5c04824@efficios.com>
In-Reply-To: <211e6d9f-834d-4511-b315-7844a5c04824@efficios.com>
Date: Tue, 16 Jul 2024 16:34:09 -0400
Message-ID: <CAHD10Ugvtu+wKGeRjujGgXbXrEqH-6OKHurJgMyf7CmUVjzRRQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============8460696637369104784=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8460696637369104784==
Content-Type: multipart/alternative; boundary="000000000000388e5d061d634598"

--000000000000388e5d061d634598
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Kienan,

When I proceed with the following steps:

```
# Warning: this removes all untracked content from the lttng-modules
directory
cd /path/to/lttng-modules-source
git clean -dxf

make
sudo make modules_install
sudo depmod -a
```

I encounter a warning in
`/home/philippe/lttng-modules/src/probes/Kbuild:79` stating "File
./arch/x86/kvm/lapic.h not found. Probe 'kvm' x86-specific is disabled. Use
full kernel source tree to enable it." Although everything compiles fine
and I'm able to load modules, when I execute `sudo lttng list -k`, I don't
see the tracepoints `kvm_entry` and `kvm_exit`, which I believe should be
available. Could this be due to not using my full kernel tree during
compilation?

Here are the answers to your questions:

- *Where did `/usr/src/linux-source-6.5.0` come from?*
  I initially attempted `sudo apt-get update && sudo apt-get install
linux-source`, but it gave me this answer *linux-source is already the
newest version (5.15.0.116.116)*`, which doesn't match my current kernel
version. So, I downloaded it directly from kernel.org using this command:
`wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz`.

- *Which Linux distribution and version are you using?*
  Running `lsb_release -a` gives me:
  ```
  No LSB modules are available.
  Distributor ID: Ubuntu
  Description:    Ubuntu 22.04.4 LTS
  Release:        22.04
  Codename:       jammy
  ```

- *Assuming your distribution has kernel packages, which do you have
installed, and do you have the corresponding kernel headers package
installed?*

  Running `dpkg -l | grep linux-image` shows these installed packages:
  ```
  ii  linux-image-5.15.0-116-generic           5.15.0-116.126      amd64
Signed kernel image generic
  ii  linux-image-6.5.0-28-generic             6.5.0-28.29~22.04.1  amd64
Signed kernel image generic
  ii  linux-image-6.5.0-41-generic             6.5.0-41.41~22.04.2  amd64
Signed kernel image generic
  ii  linux-image-6.5.0-44-generic             6.5.0-44.44~22.04.1  amd64
Signed kernel image generic
  ii  linux-image-generic                      5.15.0.116.116      amd64
Generic Linux kernel image
  ii  linux-image-generic-hwe-22.04            6.5.0.44.44~22.04.1  amd64
Generic Linux kernel image
  ```

  And `dpkg -l | grep linux-headers` shows these installed header packages:
  ```
  ii  linux-headers-5.15.0-116                 5.15.0-116.126      all
Header files related to Linux kernel version 5.15.0
  ii  linux-headers-5.15.0-116-generic         5.15.0-116.126      amd64
Linux kernel headers for version 5.15.0 on 64 bit x86 SMP
  ii  linux-headers-6.5.0-28-generic           6.5.0-28.29~22.04.1  amd64
Linux kernel headers for version 6.5.0 on 64 bit x86 SMP
  ii  linux-headers-6.5.0-41-generic           6.5.0-41.41~22.04.2  amd64
Linux kernel headers for version 6.5.0 on 64 bit x86 SMP
  ii  linux-headers-6.5.0-44-generic           6.5.0-44.44~22.04.1  amd64
Linux kernel headers for version 6.5.0 on 64 bit x86 SMP
  ii  linux-headers-generic                    5.15.0.116.116      amd64
Generic Linux kernel headers
  ii  linux-headers-generic-hwe-22.04          6.5.0.44.44~22.04.1  amd64
Generic Linux kernel headers
  ```

Thanks.
















Le mar. 16 juill. 2024, =C3=A0 15 h 41, Kienan Stewart <kstewart@efficios.c=
om> a
=C3=A9crit :

> Hi Fran=C3=A7ois,
>
> On 7/16/24 3:01 PM, Fran=C3=A7ois Belias wrote:
> > Hello Kienan,
> >
> > I've continued investigating my issue and discovered something new that
> > might shed some light. Here's the rundown:
> >
> > 1. To ensure my add-ons weren't causing problems, deleted all old
> > modules and I followed the documentation on the LTTng website
> > (https://lttng.org/docs/v2.13/#doc-building-from-source
> > <https://lttng.org/docs/v2.13/#doc-building-from-source>) and
> downloaded
> > `lttng-modules-2.13.13`.
> >
> > 2. Inside the downloaded folder, I successfully executed `make
> > KERNELDIR=3D/usr/src/linux-source-6.5.0` without any issues.
> >
> > 3. Subsequently, I ran `make KERNELDIR=3D/usr/src/linux-source-6.5.0
> > modules_install`, which also completed successfully.
> >
> > 4. After that, I updated the module dependencies using `sudo depmod -a`=
,
> > which went fine.
> >
> > However, when I tried to load a module, such as `sudo modprobe
> > lttng-probe-kvm`, it reported that the module couldn't be found at
> > `/lib/modules/6.5.0-41-generic/`. Upon checking the logs, I confirmed
> > that step 3 had installed the modules in `/lib/modules/6.5.0/`.
> >
> > To address this, I modified step 3 to simply `make modules_install`,
> > which then installed the modules correctly at
> > `/lib/modules/6.5.0-41-generic/` and ran again step 4. But now, when
> > attempting to load a module, I'm encountering the error `modprobe:
> > ERROR: could not insert 'lttng_probe_kvm': Exec format error`.
> >
> > Do you have any insights or ideas on what might be causing this issue?
> >
>
> It sounds like /usr/src/linux-source-6.5.0 is not correct source for the
> kernel that you are currently running.
>
> When running `make modules_install` in your modified step 3 (without
> KERNELDIR set), the modules were installed for your current kernel
> directory as auto-detected by the build script.
>
> What happens if you do the following
>
> ```
> unset KERNELDIR
>
> # Warning: this removes all untracked content from the lttng-modules
> directory
> cd /path/to/lttng-modules-source
> git clean -dxf
>
> make
> sudo make modules_install
> sudo depmod -a
> ```
>
> KERNELDIR is set based on the current running kernel: `uname -r`. C.f.
>
> https://github.com/lttng/lttng-modules/blob/434e86eea846b33cad57f1d810508=
9905f541853/Makefile#L16C1-L16C50
>
> A couple of questions for you:
>
> - Where did /usr/src/linux-source-6.5.0 come from?
> - Which linux distribution + version are you using?
> - Assuming your distribution has kernel packages, which do you have
> installed, and do you have the corresponding kernel headers package
> installed?
>
> thanks,
> kienan
>
> > Thanks again for your assistance.
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > Le mar. 16 juill. 2024, =C3=A0 09 h 05, Kienan Stewart <kstewart@effici=
os.com
> > <mailto:kstewart@efficios.com>> a =C3=A9crit :
> >
> >     Hi Fran=C3=A7ois,
> >
> >     On 7/15/24 6:10 PM, Fran=C3=A7ois Belias via lttng-dev wrote:
> >      > Hello,
> >      >
> >      > I'm currently running Linux kernel version 6.5.0-41-generic and
> >      > attempting to install LTTng from source. Here are the steps I
> >     followed:
> >      >
> >      >   - I cloned the LTTng git repository to my computer from
> >      >
> >     [
> https://github.com/lttng/lttng-modules.git](https://github.com/lttng/lttn=
g-modules.git)
> <
> https://github.com/lttng/lttng-modules.git%5D(https://github.com/lttng/lt=
tng-modules.git)>
> <
> https://github.com/lttng/lttng-modules.git](https://github.com/lttng/lttn=
g-modules.git)
> <
> https://github.com/lttng/lttng-modules.git%5D(https://github.com/lttng/lt=
tng-modules.git)
> >>.
> >      > - Downloaded the kernel source tree corresponding to my kernel
> >     version
> >      > to enable compilation.
> >      > - Executed `make KERNELDIR=3D/path/to/my/linux/source`, which wa=
s
> >      > completed successfully.
> >      > - Ran `make KERNELDIR=3D/path/to/my/linux/source modules_install=
`,
> >     also
> >      > without any issues.
> >      > - Finally, I executed `sudo depmod -a`, which was completed
> >     successfully.
> >      >
> >      > However, when I attempt to load a module with commands like `sud=
o
> >      > modprobe lttng-ketprobes` or "sudo modprobe lttng-tracer", I
> >     encounter
> >      > the following errors:
> >      >
> >      > - For `lttng-ketprobes`: `modprobe: FATAL: Module lttng-ketprobe=
s
> >     not
> >      > found in directory /lib/modules/6.5.0-41-generic`.
> >      > - For `lttng-tracer`: `modprobe: ERROR: could not insert
> >     'lttng_tracer':
> >      > Exec format error`.
> >
> >     If you rebuilt modules on the master branch as of yesterday you may
> >     need
> >     to clean the LTTng modules install directory, rebuild, and reinstal=
l.
> >
> >     This is due to kprobes, kretprobes, and uprobes modules being
> included
> >     in the tracer core module. C.f.
> >
> https://github.com/lttng/lttng-modules/commit/0c2c6606eb66cb5222ab7a2a4f8=
329fd5dfdef70
> <
> https://github.com/lttng/lttng-modules/commit/0c2c6606eb66cb5222ab7a2a4f8=
329fd5dfdef70
> >
> >
> >     You may want to stick with running lttng-modules 2.13.x which will
> not
> >     have breaking changes merged in.
> >
> >     The exec format error also could be due to modules that are install=
ed
> >     but built against a different version of the Linux kernel.
> >
> >     A few things to check
> >
> >     - If your kernel has been upgraded recently, ensure the new kernel =
is
> >     the one actually running
> >     - If the modules haven't been rebuilt since the upgrade, they shoul=
d
> be
> >     rebuilt and reinstalled
> >     - As I recall, you are playing around with some addon modules - do
> any
> >     of those modules define dependencies on the kprobes, kretprobes, or
> >     uprobes modules which now are no longer produced by builds of the
> >     master
> >     branch
> >
> >     Is there further information in dmesg or journalctl regarding the
> >     module
> >     loading?
> >
> >     hope this helps.
> >
> >     thanks,
> >     kienan
> >
> >      >
> >      > I've confirmed that the modules exist but can't load them. I'm
> >     unsure
> >      > how to resolve these issues. Could someone please assist me?
> >      >
> >      > Thank you.
> >      >
> >      > _______________________________________________
> >      > lttng-dev mailing list
> >      > lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> >      > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >     <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>
> >
>

--000000000000388e5d061d634598
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Kienan,<br><br>When I proceed with the following ste=
ps:<br><br>```<br># Warning: this removes all untracked content from the lt=
tng-modules directory<br>cd /path/to/lttng-modules-source<br>git clean -dxf=
<br><br>make<br>sudo make modules_install<br>sudo depmod -a<br>```<br><br>I=
 encounter a warning in `/home/philippe/lttng-modules/src/probes/Kbuild:79`=
 stating &quot;File ./arch/x86/kvm/lapic.h not found. Probe &#39;kvm&#39; x=
86-specific is disabled. Use full kernel source tree to enable it.&quot; Al=
though everything compiles fine and I&#39;m able to load modules, when I ex=
ecute `sudo lttng list -k`, I don&#39;t see the tracepoints `kvm_entry` and=
 `kvm_exit`, which I believe should be available. Could this be due to not =
using my full kernel tree during compilation?<br><br>Here are the answers t=
o your questions:<br><br>- <b>Where did `/usr/src/linux-source-6.5.0` come =
from?</b><br>=C2=A0 I initially attempted `sudo apt-get update &amp;&amp; s=
udo apt-get install linux-source`, but it gave me this answer <b><i>linux-s=
ource is already the newest version (5.15.0.116.116)</i></b>`, which doesn&=
#39;t match my current kernel version. So, I downloaded it directly from <a=
 href=3D"http://kernel.org">kernel.org</a> using this command: `wget <a hre=
f=3D"https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz`">https:=
//cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz`</a>.<br><br>- <b>W=
hich Linux distribution and version are you using?</b><br>=C2=A0 Running `l=
sb_release -a` gives me:<br>=C2=A0 ```<br>=C2=A0 No LSB modules are availab=
le.<br>=C2=A0 Distributor ID: Ubuntu<br>=C2=A0 Description: =C2=A0 =C2=A0Ub=
untu 22.04.4 LTS<br>=C2=A0 Release: =C2=A0 =C2=A0 =C2=A0 =C2=A022.04<br>=C2=
=A0 Codename: =C2=A0 =C2=A0 =C2=A0 jammy<br>=C2=A0 ```<br><br>- <b>Assuming=
 your distribution has kernel packages, which do you have installed, and do=
 you have the corresponding kernel headers package installed?</b><br><br>=
=C2=A0 Running `dpkg -l | grep linux-image` shows these installed packages:=
<br>=C2=A0 ```<br>=C2=A0 ii =C2=A0linux-image-5.15.0-116-generic =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 5.15.0-116.126 =C2=A0 =C2=A0 =C2=A0amd64 =C2=A0 Si=
gned kernel image generic<br>=C2=A0 ii =C2=A0linux-image-6.5.0-28-generic =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.5.0-28.29~22.04.1 =C2=A0amd64 =
=C2=A0 Signed kernel image generic<br>=C2=A0 ii =C2=A0linux-image-6.5.0-41-=
generic =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.5.0-41.41~22.04.2 =C2=
=A0amd64 =C2=A0 Signed kernel image generic<br>=C2=A0 ii =C2=A0linux-image-=
6.5.0-44-generic =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.5.0-44.44~22.0=
4.1 =C2=A0amd64 =C2=A0 Signed kernel image generic<br>=C2=A0 ii =C2=A0linux=
-image-generic =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A05.15.0.116.116 =C2=A0 =C2=A0 =C2=A0amd64 =C2=A0 Generic Li=
nux kernel image<br>=C2=A0 ii =C2=A0linux-image-generic-hwe-22.04 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.5.0.44.44~22.04.1 =C2=A0amd64 =C2=A0 Ge=
neric Linux kernel image<br>=C2=A0 ```<br><br>=C2=A0 And `dpkg -l | grep li=
nux-headers` shows these installed header packages:<br>=C2=A0 ```<br>=C2=A0=
 ii =C2=A0linux-headers-5.15.0-116 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 5.15.0-116.126 =C2=A0 =C2=A0 =C2=A0all =C2=A0 =C2=A0 Head=
er files related to Linux kernel version 5.15.0<br>=C2=A0 ii =C2=A0linux-he=
aders-5.15.0-116-generic =C2=A0 =C2=A0 =C2=A0 =C2=A0 5.15.0-116.126 =C2=A0 =
=C2=A0 =C2=A0amd64 =C2=A0 Linux kernel headers for version 5.15.0 on 64 bit=
 x86 SMP<br>=C2=A0 ii =C2=A0linux-headers-6.5.0-28-generic =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 6.5.0-28.29~22.04.1 =C2=A0amd64 =C2=A0 Linux kernel he=
aders for version 6.5.0 on 64 bit x86 SMP<br>=C2=A0 ii =C2=A0linux-headers-=
6.5.0-41-generic =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.5.0-41.41~22.04.2 =C2=
=A0amd64 =C2=A0 Linux kernel headers for version 6.5.0 on 64 bit x86 SMP<br=
>=C2=A0 ii =C2=A0linux-headers-6.5.0-44-generic =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 6.5.0-44.44~22.04.1 =C2=A0amd64 =C2=A0 Linux kernel headers for ver=
sion 6.5.0 on 64 bit x86 SMP<br>=C2=A0 ii =C2=A0linux-headers-generic =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05.15.0.11=
6.116 =C2=A0 =C2=A0 =C2=A0amd64 =C2=A0 Generic Linux kernel headers<br>=C2=
=A0 ii =C2=A0linux-headers-generic-hwe-22.04 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A06.5.0.44.44~22.04.1 =C2=A0amd64 =C2=A0 Generic Linux kernel headers<b=
r>=C2=A0 ```<br><br>Thanks.<br><br><div><div><br></div><div><br></div><div>=
<br></div><div><br></div><div><br></div><div><br></div><div><br></div><div>=
<br></div><div><br></div><div><br></div><div><br></div><div><br></div><div>=
<br></div><div><br></div></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">Le mar. 16 juill. 2024, =C3=A0 15 h 41, Kien=
an Stewart &lt;<a href=3D"mailto:kstewart@efficios.com">kstewart@efficios.c=
om</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Hi Fran=C3=A7ois,<br>
<br>
On 7/16/24 3:01 PM, Fran=C3=A7ois Belias wrote:<br>
&gt; Hello Kienan,<br>
&gt; <br>
&gt; I&#39;ve continued investigating my issue and discovered something new=
 that <br>
&gt; might shed some light. Here&#39;s the rundown:<br>
&gt; <br>
&gt; 1. To ensure my add-ons weren&#39;t causing problems, deleted all old =
<br>
&gt; modules and I followed the documentation on the LTTng website <br>
&gt; (<a href=3D"https://lttng.org/docs/v2.13/#doc-building-from-source" re=
l=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/v2.13/#doc-buildi=
ng-from-source</a> <br>
&gt; &lt;<a href=3D"https://lttng.org/docs/v2.13/#doc-building-from-source"=
 rel=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/v2.13/#doc-bui=
lding-from-source</a>&gt;) and downloaded <br>
&gt; `lttng-modules-2.13.13`.<br>
&gt; <br>
&gt; 2. Inside the downloaded folder, I successfully executed `make <br>
&gt; KERNELDIR=3D/usr/src/linux-source-6.5.0` without any issues.<br>
&gt; <br>
&gt; 3. Subsequently, I ran `make KERNELDIR=3D/usr/src/linux-source-6.5.0 <=
br>
&gt; modules_install`, which also completed successfully.<br>
&gt; <br>
&gt; 4. After that, I updated the module dependencies using `sudo depmod -a=
`, <br>
&gt; which went fine.<br>
&gt; <br>
&gt; However, when I tried to load a module, such as `sudo modprobe <br>
&gt; lttng-probe-kvm`, it reported that the module couldn&#39;t be found at=
 <br>
&gt; `/lib/modules/6.5.0-41-generic/`. Upon checking the logs, I confirmed =
<br>
&gt; that step 3 had installed the modules in `/lib/modules/6.5.0/`.<br>
&gt; <br>
&gt; To address this, I modified step 3 to simply `make modules_install`, <=
br>
&gt; which then installed the modules correctly at <br>
&gt; `/lib/modules/6.5.0-41-generic/` and ran again step=C2=A04. But now, w=
hen <br>
&gt; attempting to load a module, I&#39;m encountering the error `modprobe:=
 <br>
&gt; ERROR: could not insert &#39;lttng_probe_kvm&#39;: Exec format error`.=
<br>
&gt; <br>
&gt; Do you have any insights or ideas on what might be causing this issue?=
<br>
&gt; <br>
<br>
It sounds like /usr/src/linux-source-6.5.0 is not correct source for the <b=
r>
kernel that you are currently running.<br>
<br>
When running `make modules_install` in your modified step 3 (without <br>
KERNELDIR set), the modules were installed for your current kernel <br>
directory as auto-detected by the build script.<br>
<br>
What happens if you do the following<br>
<br>
```<br>
unset KERNELDIR<br>
<br>
# Warning: this removes all untracked content from the lttng-modules <br>
directory<br>
cd /path/to/lttng-modules-source<br>
git clean -dxf<br>
<br>
make<br>
sudo make modules_install<br>
sudo depmod -a<br>
```<br>
<br>
KERNELDIR is set based on the current running kernel: `uname -r`. C.f. <br>
<a href=3D"https://github.com/lttng/lttng-modules/blob/434e86eea846b33cad57=
f1d8105089905f541853/Makefile#L16C1-L16C50" rel=3D"noreferrer" target=3D"_b=
lank">https://github.com/lttng/lttng-modules/blob/434e86eea846b33cad57f1d81=
05089905f541853/Makefile#L16C1-L16C50</a><br>
<br>
A couple of questions for you:<br>
<br>
- Where did /usr/src/linux-source-6.5.0 come from?<br>
- Which linux distribution + version are you using?<br>
- Assuming your distribution has kernel packages, which do you have <br>
installed, and do you have the corresponding kernel headers package <br>
installed?<br>
<br>
thanks,<br>
kienan<br>
<br>
&gt; Thanks again for your assistance.<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Le mar. 16 juill. 2024, =C3=A0 09 h 05, Kienan Stewart &lt;<a href=3D"=
mailto:kstewart@efficios.com" target=3D"_blank">kstewart@efficios.com</a> <=
br>
&gt; &lt;mailto:<a href=3D"mailto:kstewart@efficios.com" target=3D"_blank">=
kstewart@efficios.com</a>&gt;&gt; a =C3=A9crit=C2=A0:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Fran=C3=A7ois,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 7/15/24 6:10 PM, Fran=C3=A7ois Belias via lttng-=
dev wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hello,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I&#39;m currently running Linux kernel versio=
n 6.5.0-41-generic and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; attempting to install LTTng from source. Here=
 are the steps I<br>
&gt;=C2=A0 =C2=A0 =C2=A0followed:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0- I cloned the LTTng git reposito=
ry to my computer from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0[<a href=3D"https://github.com/lttng/lttng-modules.=
git%5D(https://github.com/lttng/lttng-modules.git)" rel=3D"noreferrer" targ=
et=3D"_blank">https://github.com/lttng/lttng-modules.git](https://github.co=
m/lttng/lttng-modules.git)</a> &lt;<a href=3D"https://github.com/lttng/lttn=
g-modules.git%5D(https://github.com/lttng/lttng-modules.git)" rel=3D"norefe=
rrer" target=3D"_blank">https://github.com/lttng/lttng-modules.git%5D(https=
://github.com/lttng/lttng-modules.git)</a>&gt; &lt;<a href=3D"https://githu=
b.com/lttng/lttng-modules.git%5D(https://github.com/lttng/lttng-modules.git=
)" rel=3D"noreferrer" target=3D"_blank">https://github.com/lttng/lttng-modu=
les.git](https://github.com/lttng/lttng-modules.git)</a> &lt;<a href=3D"htt=
ps://github.com/lttng/lttng-modules.git%5D(https://github.com/lttng/lttng-m=
odules.git)" rel=3D"noreferrer" target=3D"_blank">https://github.com/lttng/=
lttng-modules.git%5D(https://github.com/lttng/lttng-modules.git)</a>&gt;&gt=
;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - Downloaded the kernel source tree correspon=
ding to my kernel<br>
&gt;=C2=A0 =C2=A0 =C2=A0version<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; to enable compilation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - Executed `make KERNELDIR=3D/path/to/my/linu=
x/source`, which was<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; completed successfully.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - Ran `make KERNELDIR=3D/path/to/my/linux/sou=
rce modules_install`,<br>
&gt;=C2=A0 =C2=A0 =C2=A0also<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; without any issues.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - Finally, I executed `sudo depmod -a`, which=
 was completed<br>
&gt;=C2=A0 =C2=A0 =C2=A0successfully.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; However, when I attempt to load a module with=
 commands like `sudo<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; modprobe lttng-ketprobes` or &quot;sudo modpr=
obe lttng-tracer&quot;, I<br>
&gt;=C2=A0 =C2=A0 =C2=A0encounter<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; the following errors:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - For `lttng-ketprobes`: `modprobe: FATAL: Mo=
dule lttng-ketprobes<br>
&gt;=C2=A0 =C2=A0 =C2=A0not<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; found in directory /lib/modules/6.5.0-41-gene=
ric`.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - For `lttng-tracer`: `modprobe: ERROR: could=
 not insert<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;lttng_tracer&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Exec format error`.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0If you rebuilt modules on the master branch as of y=
esterday you may<br>
&gt;=C2=A0 =C2=A0 =C2=A0need<br>
&gt;=C2=A0 =C2=A0 =C2=A0to clean the LTTng modules install directory, rebui=
ld, and reinstall.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This is due to kprobes, kretprobes, and uprobes mod=
ules being included<br>
&gt;=C2=A0 =C2=A0 =C2=A0in the tracer core module. C.f.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/lttng/lttng-modules/c=
ommit/0c2c6606eb66cb5222ab7a2a4f8329fd5dfdef70" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/lttng/lttng-modules/commit/0c2c6606eb66cb522=
2ab7a2a4f8329fd5dfdef70</a> &lt;<a href=3D"https://github.com/lttng/lttng-m=
odules/commit/0c2c6606eb66cb5222ab7a2a4f8329fd5dfdef70" rel=3D"noreferrer" =
target=3D"_blank">https://github.com/lttng/lttng-modules/commit/0c2c6606eb6=
6cb5222ab7a2a4f8329fd5dfdef70</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0You may want to stick with running lttng-modules 2.=
13.x which will not<br>
&gt;=C2=A0 =C2=A0 =C2=A0have breaking changes merged in.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The exec format error also could be due to modules =
that are installed<br>
&gt;=C2=A0 =C2=A0 =C2=A0but built against a different version of the Linux =
kernel.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0A few things to check<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0- If your kernel has been upgraded recently, ensure=
 the new kernel is<br>
&gt;=C2=A0 =C2=A0 =C2=A0the one actually running<br>
&gt;=C2=A0 =C2=A0 =C2=A0- If the modules haven&#39;t been rebuilt since the=
 upgrade, they should be<br>
&gt;=C2=A0 =C2=A0 =C2=A0rebuilt and reinstalled<br>
&gt;=C2=A0 =C2=A0 =C2=A0- As I recall, you are playing around with some add=
on modules - do any<br>
&gt;=C2=A0 =C2=A0 =C2=A0of those modules define dependencies on the kprobes=
, kretprobes, or<br>
&gt;=C2=A0 =C2=A0 =C2=A0uprobes modules which now are no longer produced by=
 builds of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0master<br>
&gt;=C2=A0 =C2=A0 =C2=A0branch<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Is there further information in dmesg or journalctl=
 regarding the<br>
&gt;=C2=A0 =C2=A0 =C2=A0module<br>
&gt;=C2=A0 =C2=A0 =C2=A0loading?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0hope this helps.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0kienan<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I&#39;ve confirmed that the modules exist but=
 can&#39;t load them. I&#39;m<br>
&gt;=C2=A0 =C2=A0 =C2=A0unsure<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; how to resolve these issues. Could someone pl=
ease assist me?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Thank you.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; _____________________________________________=
__<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; lttng-dev mailing list<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" =
target=3D"_blank">lttng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailt=
o:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a=
>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://list=
s.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>&gt;<br>
&gt; <br>
</blockquote></div>

--000000000000388e5d061d634598--

--===============8460696637369104784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8460696637369104784==--
