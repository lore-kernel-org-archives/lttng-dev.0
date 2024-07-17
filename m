Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947E6C3DA42
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Jul 2024 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1721231246;
	bh=QwwKUDHbJA/0fmzbLUc0T8FWOMpd8+0/u4amsLjgrWg=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=n/uUoXt/1wjexbCvpxf9Vc3FozAp70AN5feVKlAYl3trvB4+SfqOscLIwJBH5Qopm
	 hXVODnzHk2avMoF1Ki++zk9jPiKMm0QdoaD45sQQQ5J3WQQUx3erpDrj4BbzquKgpu
	 4cGtnAvZDUSmoHrqZIVn7sJMnxlMNtoRiao8RWO1jYqVbtuwYWjCZ9zkl0geH+yVIZ
	 1SYR1nTnPovsjLfbVaBsDf/5wjyHfh5o7No64hptvSTHxarUm7exBXtOew6pFWWGaP
	 xuGMbrZwo9MQUTpkCOpBa83X/qZEwc0wFTmaHBY0DgmaezKKdeTnZ4xhbmrr3KTK1B
	 L1SJxSFRFbLWQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WPL0s6xXvz12FY;
	Wed, 17 Jul 2024 11:47:25 -0400 (EDT)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by lists.lttng.org (Postfix) with ESMTPS id 4WPL0r2MZkz12LG
 for <lttng-dev@lists.lttng.org>; Wed, 17 Jul 2024 11:47:24 -0400 (EDT)
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-6bce380eb9bso3860104a12.0
 for <lttng-dev@lists.lttng.org>; Wed, 17 Jul 2024 08:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231243; x=1721836043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YLtVy7CTmxschaaiyd7xHNqZXEu0DgitUj7UTtgDAbY=;
 b=HEkXDdEFS9W5qw2k0RZtVMpaCicv4EbaOAMxaQxkRCn+6cJK+xqVjykJn3BBf8Sq9K
 eIPntOw5ri4z4dU+K6j28uEGDn+4tFwoRyLnGpFgLpoYc4CPjXg0Rjuf5txNUnDNvb2W
 dB1Jk5ygoS9DDMwqq9g9/ucwlwxCln4UPyFPRVrnt3W7Ye1QTqCL5qbxn03W49Sc8RYb
 MCOwILkGzU+EQXw/2ra2W3S/SOdrDwtgNKe3//fJkF9Vz+5Cy2SI276P4nPeQh285I92
 XXfEECUTkoaMnwb07LGsw71/yL6TvajxjuRysQEg6PYQPdMF+D9kt4B7N67QcpYmypJa
 I0OQ==
X-Gm-Message-State: AOJu0YwHn/q3hvmsL4c8hu90pqf/r9bzdp1U1PulWB/3bwMvLh5Hf+ea
 /45qcv/7bjWHYkxi5fwl/VqK9vv1TUqthmX9F3bvCCfVWNNxzDNGRh4xaIXRaH0HUgNhXVCRGrA
 8spPc0/iyVqUKFoAcyxcPNS7+1QWkyiAa
X-Google-Smtp-Source: AGHT+IFBw2SckO6KnlgF82WrCt0bt9lKOtxfMjzjJ6b4SBKtFun3GPoSzCPZSCrsarhiBomDIMTpxUPDamP6GmcQJiM=
X-Received: by 2002:a05:6a20:12c5:b0:1c0:ec1c:f4a0 with SMTP id
 adf61e73a8af0-1c3fdd6b4f2mr2765154637.38.1721231242797; Wed, 17 Jul 2024
 08:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHD10UjoaOjqZUH4j55Ra7zJ2HVRLOyk7xnjv+BjnJxs6rN6Aw@mail.gmail.com>
 <6deffa1d-4d46-4445-a510-a3aac271cc80@efficios.com>
 <CAHD10Ui_JkP9hRirGUvKBgHhWX48r26+M2_zTyOD_cMLnSDGCg@mail.gmail.com>
 <211e6d9f-834d-4511-b315-7844a5c04824@efficios.com>
 <CAHD10Ugvtu+wKGeRjujGgXbXrEqH-6OKHurJgMyf7CmUVjzRRQ@mail.gmail.com>
 <5b7fc307-a52a-4e54-84df-294600454686@efficios.com>
 <CAHD10UgTthGz7gcgcga6W4xxjiKHfuZgM9uCjEkViKsVUnDF8A@mail.gmail.com>
In-Reply-To: <CAHD10UgTthGz7gcgcga6W4xxjiKHfuZgM9uCjEkViKsVUnDF8A@mail.gmail.com>
Date: Wed, 17 Jul 2024 11:47:11 -0400
Message-ID: <CAHD10UhNDKo=4Kk-Z_mBG3PMm=1KgX9L0mjgTS+ZfrT4Xbmn9w@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============7787348023408380498=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7787348023408380498==
Content-Type: multipart/alternative; boundary="000000000000cdaa67061d73608f"

--000000000000cdaa67061d73608f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Kienan



*Right. Which kernel are you actually running at this time? You can
checkusing: `uname -a`*
Linux philippe 6.5.0-41-generic #41~22.04.2-Ubuntu SMP PREEMPT_DYNAMIC Mon
Jun  3 11:32:55 UTC 2 x86_64 x86_64 x86_64 GNU/Linux



*Since you've got a few different images and headers installed, it
ispossible to check that same info the linux-source package: `dpkg -l |grep
linux-source`.*
ii  linux-source                                   5.15.0.116.116
                         all          Linux kernel source with Ubuntu
patches
ii  linux-source-5.15.0                       5.15.0-116.126
                     all          Linux kernel source for version 5.15.0
with Ubuntu patches
ii  linux-source-6.5.0                      6.5.0-44.44~22.04.1
                  all          Linux kernel source for version 6.5.0 with
Ubuntu patches

*Could you run either `apt-cache policy` or `apt policy` and
`apt-markshowhold` in order to know which sources you have configured.*
For this part, *apt-mark showhold* gave me nothing I don't know what is
means.

I am looking at the links, but nothing seems to match my kernel version.

Thanks for your assistance.

Le mer. 17 juill. 2024, =C3=A0 11 h 46, Fran=C3=A7ois Belias <beliasossim@g=
mail.com>
a =C3=A9crit :

> Hello, Kienan
>
>
>
> *Right. Which kernel are you actually running at this time? You can
> checkusing: `uname -a`*
> Linux philippe 6.5.0-41-generic #41~22.04.2-Ubuntu SMP PREEMPT_DYNAMIC Mo=
n
> Jun  3 11:32:55 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
>
>
>
> *Since you've got a few different images and headers installed, it
> ispossible to check that same info the linux-source package: `dpkg -l |gr=
ep
> linux-source`.*
> ii  linux-source                                   5.15.0.116.116
>                            all          Linux kernel source with Ubuntu
> patches
> ii  linux-source-5.15.0                       5.15.0-116.126
>                      all          Linux kernel source for version 5.15.0
> with Ubuntu patches
> ii  linux-source-6.5.0                      6.5.0-44.44~22.04.1
>                     all          Linux kernel source for version 6.5.0 wi=
th
> Ubuntu patches
>
> *Could you run either `apt-cache policy` or `apt policy` and
> `apt-markshowhold` in order to know which sources you have configured.*
> For this part, *apt-mark showhold* gave me nothing I don't know what is
> means.
>
> I am looking at the links, but nothing seems to match my kernel version.
>
> Thanks for your assistance.
>
> Le mer. 17 juill. 2024, =C3=A0 10 h 55, Kienan Stewart <kstewart@efficios=
.com>
> a =C3=A9crit :
>
>> Hi Fran=C3=A7ois,
>>
>> On 7/16/24 4:34 PM, Fran=C3=A7ois Belias wrote:
>> > Hello Kienan,
>> >
>> > When I proceed with the following steps:
>> >
>> > ```
>> > # Warning: this removes all untracked content from the lttng-modules
>> > directory
>> > cd /path/to/lttng-modules-source
>> > git clean -dxf
>> >
>> > make
>> > sudo make modules_install
>> > sudo depmod -a
>> > ```
>> >
>> > I encounter a warning in
>> > `/home/philippe/lttng-modules/src/probes/Kbuild:79` stating "File
>> > ./arch/x86/kvm/lapic.h not found. Probe 'kvm' x86-specific is disabled=
.
>> > Use full kernel source tree to enable it." Although everything compile=
s
>> > fine and I'm able to load modules, when I execute `sudo lttng list -k`=
,
>> > I don't see the tracepoints `kvm_entry` and `kvm_exit`, which I believ=
e
>> > should be available. Could this be due to not using my full kernel tre=
e
>> > during compilation?
>>
>>
>> Exactly. Those probes depend on having the full kernel source as they
>> require private headers which aren't shipped as part of the
>> `linux-headers` package.
>>
>> >
>> > Here are the answers to your questions:
>> >
>> > - *Where did `/usr/src/linux-source-6.5.0` come from?*
>> >    I initially attempted `sudo apt-get update && sudo apt-get install
>> > linux-source`, but it gave me this answer */linux-source is already th=
e
>> > newest version (5.15.0.116.116)/*`, which doesn't match my current
>> > kernel version. So, I downloaded it directly from kernel.org
>> > <http://kernel.org> using this command: `wget
>> > https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz`
>> <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz>
>> > <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz`
>> <https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz>>.
>> >
>>
>> Right. Which kernel are you actually running at this time? You can check
>> using: `uname -a`
>>
>> In any case, Linux upstream 6.5 is not the same as Ubuntus's 6.5.
>>
>> > - *Which Linux distribution and version are you using?*
>> >    Running `lsb_release -a` gives me:
>> >    ```
>> >    No LSB modules are available.
>> >    Distributor ID: Ubuntu
>> >    Description:    Ubuntu 22.04.4 LTS
>> >    Release:        22.04
>> >    Codename:       jammy
>> >    ```
>> >
>> > - *Assuming your distribution has kernel packages, which do you have
>> > installed, and do you have the corresponding kernel headers package
>> > installed?*
>> >
>> >    Running `dpkg -l | grep linux-image` shows these installed packages=
:
>> >    ```
>> >    ii  linux-image-5.15.0-116-generic           5.15.0-116.126
>> >   amd64   Signed kernel image generic
>> >    ii  linux-image-6.5.0-28-generic             6.5.0-28.29~22.04.1
>> >   amd64   Signed kernel image generic
>> >    ii  linux-image-6.5.0-41-generic             6.5.0-41.41~22.04.2
>> >   amd64   Signed kernel image generic
>> >    ii  linux-image-6.5.0-44-generic             6.5.0-44.44~22.04.1
>> >   amd64   Signed kernel image generic
>> >    ii  linux-image-generic                      5.15.0.116.116
>> >   amd64   Generic Linux kernel image
>> >    ii  linux-image-generic-hwe-22.04            6.5.0.44.44~22.04.1
>> >   amd64   Generic Linux kernel image
>> >    ```
>> >
>> >    And `dpkg -l | grep linux-headers` shows these installed header
>> packages:
>> >    ```
>> >    ii  linux-headers-5.15.0-116                 5.15.0-116.126      al=
l
>> >      Header files related to Linux kernel version 5.15.0
>> >    ii  linux-headers-5.15.0-116-generic         5.15.0-116.126
>> >   amd64   Linux kernel headers for version 5.15.0 on 64 bit x86 SMP
>> >    ii  linux-headers-6.5.0-28-generic           6.5.0-28.29~22.04.1
>> >   amd64   Linux kernel headers for version 6.5.0 on 64 bit x86 SMP
>> >    ii  linux-headers-6.5.0-41-generic           6.5.0-41.41~22.04.2
>> >   amd64   Linux kernel headers for version 6.5.0 on 64 bit x86 SMP
>> >    ii  linux-headers-6.5.0-44-generic           6.5.0-44.44~22.04.1
>> >   amd64   Linux kernel headers for version 6.5.0 on 64 bit x86 SMP
>> >    ii  linux-headers-generic                    5.15.0.116.116
>> >   amd64   Generic Linux kernel headers
>> >    ii  linux-headers-generic-hwe-22.04          6.5.0.44.44~22.04.1
>> >   amd64   Generic Linux kernel headers
>> >    ```
>> >
>>
>> Since you've got a few different images and headers installed, it is
>> possible to check that same info the linux-source package: `dpkg -l |
>> grep linux-source`.
>>
>> Maybe one thing tripping this process up is that you don't have an apt
>> source that provides linux-source that matches the kernel you are using.
>> Could you run either `apt-cache policy` or `apt policy` and `apt-mark
>> showhold` in order to know which sources you have configured.
>>
>> There are also alternative sources for the full source tree:
>>
>> - You could download the specific package from packages.ubuntu.com. See
>> https://packages.ubuntu.com and use `apt install
>> ./downloaded_package.deb`
>>
>> - You could clone the kernel source for Ubuntu and checkout the
>> appropriate tag. See
>>
>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy=
/refs/tags
>>
>> thanks,
>> kienan
>>
>

--000000000000cdaa67061d73608f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello, Kienan<span class=3D"gmail-im" style=3D"color:rgb(8=
0,0,80)"><div><br></div><div><br></div><div><b>Right. Which kernel are you =
actually running at this time? You can check<br>using: `uname -a`</b><br></=
div></span><div>Linux philippe 6.5.0-41-generic #41~22.04.2-Ubuntu SMP PREE=
MPT_DYNAMIC Mon Jun =C2=A03 11:32:55 UTC 2 x86_64 x86_64 x86_64 GNU/Linux<b=
r></div><span class=3D"gmail-im" style=3D"color:rgb(80,0,80)"><div><br></di=
v><div><b>Since you&#39;ve got a few different images and headers installed=
, it is<br>possible to check that same info the linux-source package: `dpkg=
 -l |<br>grep linux-source`.</b><br></div></span><div>ii =C2=A0linux-source=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05.15.0.116.116 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0all =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Linux kernel source with Ubuntu patches<br>ii =C2=A0linux-source-=
5.15.0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A05.15.0-116.126 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0all =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux kernel source for version=
 5.15.0 with Ubuntu patches<br>ii =C2=A0linux-source-6.5.0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.5.0-44.44~22.=
04.1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 all =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Li=
nux kernel source for version 6.5.0 with Ubuntu patches<br></div><span clas=
s=3D"gmail-im" style=3D"color:rgb(80,0,80)"><div><b>Could you run either `a=
pt-cache policy` or `apt policy` and `apt-mark<br>showhold` in order to kno=
w which sources you have configured.</b><br></div></span><div>For this part=
,=C2=A0<i><b>apt-mark showhold</b></i>=C2=A0gave me nothing I don&#39;t kno=
w what is means.</div><div><br></div><div>I am looking at the links, but no=
thing seems to match my kernel version.=C2=A0</div><div><br></div><div>Than=
ks for your assistance.</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Le mer. 17 juill. 2024, =C3=A0 11 h 46, Fran=
=C3=A7ois Belias &lt;<a href=3D"mailto:beliasossim@gmail.com">beliasossim@g=
mail.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr">Hello, Kienan<div><br></div><div><br>=
</div><div><b>Right. Which kernel are you actually running at this time? Yo=
u can check<br>using: `uname -a`</b><br></div><div>Linux philippe 6.5.0-41-=
generic #41~22.04.2-Ubuntu SMP PREEMPT_DYNAMIC Mon Jun =C2=A03 11:32:55 UTC=
 2 x86_64 x86_64 x86_64 GNU/Linux<br></div><div><br></div><div><b>Since you=
&#39;ve got a few different images and headers installed, it is<br>possible=
 to check that same info the linux-source package: `dpkg -l |<br>grep linux=
-source`.</b><br></div><div>ii =C2=A0linux-source=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A05.15.0.116.116 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0all =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux kernel sour=
ce with Ubuntu patches<br>ii =C2=A0linux-source-5.15.0=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05.15.0-116.12=
6 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0all =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Linux kernel source for version 5.15.0 with Ubuntu patches=
<br>ii =C2=A0linux-source-6.5.0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.5.0-44.44~22.04.1 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 all =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux kernel source for ve=
rsion 6.5.0 with Ubuntu patches<br></div><div><b>Could you run either `apt-=
cache policy` or `apt policy` and `apt-mark<br>showhold` in order to know w=
hich sources you have configured.</b><br></div><div>For this part, <i><b>ap=
t-mark showhold</b></i> gave me nothing I don&#39;t know what is means.</di=
v><div><br></div><div>I am looking at the links, but nothing seems to match=
 my kernel version.=C2=A0</div><div><br></div><div>Thanks for your assistan=
ce.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">Le mer. 17 juill. 2024, =C3=A0 10 h 55, Kienan Stewart &lt;<a href=
=3D"mailto:kstewart@efficios.com" target=3D"_blank">kstewart@efficios.com</=
a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Fran=C3=A7ois,<br>
<br>
On 7/16/24 4:34 PM, Fran=C3=A7ois Belias wrote:<br>
&gt; Hello Kienan,<br>
&gt; <br>
&gt; When I proceed with the following steps:<br>
&gt; <br>
&gt; ```<br>
&gt; # Warning: this removes all untracked content from the lttng-modules <=
br>
&gt; directory<br>
&gt; cd /path/to/lttng-modules-source<br>
&gt; git clean -dxf<br>
&gt; <br>
&gt; make<br>
&gt; sudo make modules_install<br>
&gt; sudo depmod -a<br>
&gt; ```<br>
&gt; <br>
&gt; I encounter a warning in <br>
&gt; `/home/philippe/lttng-modules/src/probes/Kbuild:79` stating &quot;File=
 <br>
&gt; ./arch/x86/kvm/lapic.h not found. Probe &#39;kvm&#39; x86-specific is =
disabled. <br>
&gt; Use full kernel source tree to enable it.&quot; Although everything co=
mpiles <br>
&gt; fine and I&#39;m able to load modules, when I execute `sudo lttng list=
 -k`, <br>
&gt; I don&#39;t see the tracepoints `kvm_entry` and `kvm_exit`, which I be=
lieve <br>
&gt; should be available. Could this be due to not using my full kernel tre=
e <br>
&gt; during compilation?<br>
<br>
<br>
Exactly. Those probes depend on having the full kernel source as they <br>
require private headers which aren&#39;t shipped as part of the <br>
`linux-headers` package.<br>
<br>
&gt; <br>
&gt; Here are the answers to your questions:<br>
&gt; <br>
&gt; - *Where did `/usr/src/linux-source-6.5.0` come from?*<br>
&gt;=C2=A0 =C2=A0 I initially attempted `sudo apt-get update &amp;&amp; sud=
o apt-get install <br>
&gt; linux-source`, but it gave me this answer */linux-source is already th=
e <br>
&gt; newest version (5.15.0.116.116)/*`, which doesn&#39;t match my current=
 <br>
&gt; kernel version. So, I downloaded it directly from <a href=3D"http://ke=
rnel.org" rel=3D"noreferrer" target=3D"_blank">kernel.org</a> <br>
&gt; &lt;<a href=3D"http://kernel.org" rel=3D"noreferrer" target=3D"_blank"=
>http://kernel.org</a>&gt; using this command: `wget <br>
&gt; <a href=3D"https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.=
xz" rel=3D"noreferrer" target=3D"_blank">https://cdn.kernel.org/pub/linux/k=
ernel/v6.x/linux-6.5.tar.xz`</a> <br>
&gt; &lt;<a href=3D"https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.=
tar.xz" rel=3D"noreferrer" target=3D"_blank">https://cdn.kernel.org/pub/lin=
ux/kernel/v6.x/linux-6.5.tar.xz`</a>&gt;.<br>
&gt; <br>
<br>
Right. Which kernel are you actually running at this time? You can check <b=
r>
using: `uname -a`<br>
<br>
In any case, Linux upstream 6.5 is not the same as Ubuntus&#39;s 6.5.<br>
<br>
&gt; - *Which Linux distribution and version are you using?* <br>
&gt;=C2=A0 =C2=A0 Running `lsb_release -a` gives me:<br>
&gt;=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 No LSB modules are available.<br>
&gt;=C2=A0 =C2=A0 Distributor ID: Ubuntu<br>
&gt;=C2=A0 =C2=A0 Description: =C2=A0 =C2=A0Ubuntu 22.04.4 LTS<br>
&gt;=C2=A0 =C2=A0 Release: =C2=A0 =C2=A0 =C2=A0 =C2=A022.04<br>
&gt;=C2=A0 =C2=A0 Codename: =C2=A0 =C2=A0 =C2=A0 jammy<br>
&gt;=C2=A0 =C2=A0 ```<br>
&gt; <br>
&gt; - *Assuming your distribution has kernel packages, which do you have <=
br>
&gt; installed, and do you have the corresponding kernel headers package <b=
r>
&gt; installed?*<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 Running `dpkg -l | grep linux-image` shows these installe=
d packages:<br>
&gt;=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 ii =C2=A0linux-image-5.15.0-116-generic =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 5.15.0-116.126=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0amd64 =C2=A0 Signed kernel image generic<br>
&gt;=C2=A0 =C2=A0 ii =C2=A0linux-image-6.5.0-28-generic =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 6.5.0-28.29~22.04.1 <br>
&gt;=C2=A0 =C2=A0amd64 =C2=A0 Signed kernel image generic<br>
&gt;=C2=A0 =C2=A0 ii =C2=A0linux-image-6.5.0-41-generic =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 6.5.0-41.41~22.04.2 <br>
&gt;=C2=A0 =C2=A0amd64 =C2=A0 Signed kernel image generic<br>
&gt;=C2=A0 =C2=A0 ii =C2=A0linux-image-6.5.0-44-generic =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 6.5.0-44.44~22.04.1 <br>
&gt;=C2=A0 =C2=A0amd64 =C2=A0 Signed kernel image generic<br>
&gt;=C2=A0 =C2=A0 ii =C2=A0linux-image-generic =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05.15.0.116.116=C2=A0 =C2=A0=
 =C2=A0<br>
&gt;=C2=A0 =C2=A0amd64 =C2=A0 Generic Linux kernel image<br>
&gt;=C2=A0 =C2=A0 ii =C2=A0linux-image-generic-hwe-22.04 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A06.5.0.44.44~22.04.1 <br>
&gt;=C2=A0 =C2=A0amd64 =C2=A0 Generic Linux kernel image<br>
&gt;=C2=A0 =C2=A0 ```<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 And `dpkg -l | grep linux-headers` shows these installed =
header packages:<br>
&gt;=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 ii =C2=A0linux-headers-5.15.0-116 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5.15.0-116.126 =C2=A0 =C2=A0 =C2=A0all <=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 Header files related to Linux kernel version 5.15.=
0<br>
&gt;=C2=A0 =C2=A0 ii =C2=A0linux-headers-5.15.0-116-generic =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 5.15.0-116.126=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0amd64 =C2=A0 Linux kernel headers for version 5.15.0 on 64=
 bit x86 SMP<br>
&gt;=C2=A0 =C2=A0 ii =C2=A0linux-headers-6.5.0-28-generic =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 6.5.0-28.29~22.04.1 <br>
&gt;=C2=A0 =C2=A0amd64 =C2=A0 Linux kernel headers for version 6.5.0 on 64 =
bit x86 SMP<br>
&gt;=C2=A0 =C2=A0 ii =C2=A0linux-headers-6.5.0-41-generic =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 6.5.0-41.41~22.04.2 <br>
&gt;=C2=A0 =C2=A0amd64 =C2=A0 Linux kernel headers for version 6.5.0 on 64 =
bit x86 SMP<br>
&gt;=C2=A0 =C2=A0 ii =C2=A0linux-headers-6.5.0-44-generic =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 6.5.0-44.44~22.04.1 <br>
&gt;=C2=A0 =C2=A0amd64 =C2=A0 Linux kernel headers for version 6.5.0 on 64 =
bit x86 SMP<br>
&gt;=C2=A0 =C2=A0 ii =C2=A0linux-headers-generic =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05.15.0.116.116=C2=A0 =C2=A0 =
=C2=A0<br>
&gt;=C2=A0 =C2=A0amd64 =C2=A0 Generic Linux kernel headers<br>
&gt;=C2=A0 =C2=A0 ii =C2=A0linux-headers-generic-hwe-22.04 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A06.5.0.44.44~22.04.1 <br>
&gt;=C2=A0 =C2=A0amd64 =C2=A0 Generic Linux kernel headers<br>
&gt;=C2=A0 =C2=A0 ```<br>
&gt; <br>
<br>
Since you&#39;ve got a few different images and headers installed, it is <b=
r>
possible to check that same info the linux-source package: `dpkg -l | <br>
grep linux-source`.<br>
<br>
Maybe one thing tripping this process up is that you don&#39;t have an apt =
<br>
source that provides linux-source that matches the kernel you are using. <b=
r>
Could you run either `apt-cache policy` or `apt policy` and `apt-mark <br>
showhold` in order to know which sources you have configured.<br>
<br>
There are also alternative sources for the full source tree:<br>
<br>
- You could download the specific package from <a href=3D"http://packages.u=
buntu.com" rel=3D"noreferrer" target=3D"_blank">packages.ubuntu.com</a>. Se=
e <br>
<a href=3D"https://packages.ubuntu.com" rel=3D"noreferrer" target=3D"_blank=
">https://packages.ubuntu.com</a> and use `apt install ./downloaded_package=
.deb`<br>
<br>
- You could clone the kernel source for Ubuntu and checkout the <br>
appropriate tag. See <br>
<a href=3D"https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+g=
it/jammy/refs/tags" rel=3D"noreferrer" target=3D"_blank">https://git.launch=
pad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/refs/tags</a><br>
<br>
thanks,<br>
kienan<br>
</blockquote></div>
</blockquote></div>

--000000000000cdaa67061d73608f--

--===============7787348023408380498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7787348023408380498==--
