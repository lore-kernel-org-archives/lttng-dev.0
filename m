From: Thomas Bertauld <thomas.bertauld@gmail.com>
Subject: LTTng-modules install failed on a Parallella
Date: Wed, 20 May 2015 16:31:06 -0400
Message-ID: <CALzKSt7AhA=gTrpzGyk-dNG7jMfKHP=kgjbgcEgY4Hfg31g9og__11048.2740951285$1432153959$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1184908397=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thomas.bertauld@gmail.com>) id 1YvAe0-0001WV-77
 for lttng-dev@lists.lttng.org; Wed, 20 May 2015 16:31:22 -0400
Received: by obblk2 with SMTP id lk2so45925614obb.0
 for <lttng-dev@lists.lttng.org>; Wed, 20 May 2015 13:31:06 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1184908397==
Content-Type: multipart/alternative; boundary=089e0149bb0e7c50560516894e5e

--089e0149bb0e7c50560516894e5e
Content-Type: text/plain; charset=UTF-8

Hi !

I recently began to work on a Parallella board and I wanted to try tracing
the ARM processor with LTTng before doing ant work with the Epiphany chip
(co-processor).

Nevertheless, i'm stuck with an error anytime i try to install the
lttng-modules. I've tried installing it from the official repositories and
from the PPA but none worked.

For now i only tried with the headless version of Ubuntu 14.04 (
http://www.parallella.org/create-sdcard/) for the Zynq-7010 (the processor
itself is a ARM Cortex A9).

The kernel version is 3.14.12, as seen in the error message below


parallella@parallella:~$ sudo apt-get install lttng-modules-dkms
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following extra packages will be installed:
  dkms
The following NEW packages will be installed:
  dkms lttng-modules-dkms
0 upgraded, 2 newly installed, 0 to remove and 1 not upgraded.
Need to get 286 kB of archives.
After this operation, 2816 kB of additional disk space will be used.
Do you want to continue? [Y/n]
Get:1 http://ports.ubuntu.com/ trusty-updates/main dkms all
2.2.0.3-1.1ubuntu5.14.04 [64.6 kB]
Get:2 http://ports.ubuntu.com/ trusty-updates/universe lttng-modules-dkms
all 2.4.0-1ubuntu1.1 [221 kB]
Fetched 286 kB in 0s (356 kB/s)
Selecting previously unselected package dkms.
(Reading database ... 39070 files and directories currently installed.)
Preparing to unpack .../dkms_2.2.0.3-1.1ubuntu5.14.04_all.deb ...
Unpacking dkms (2.2.0.3-1.1ubuntu5.14.04) ...
Selecting previously unselected package lttng-modules-dkms.
Preparing to unpack .../lttng-modules-dkms_2.4.0-1ubuntu1.1_all.deb ...
Unpacking lttng-modules-dkms (2.4.0-1ubuntu1.1) ...
Processing triggers for man-db (2.6.7.1-1ubuntu1) ...
Setting up dkms (2.2.0.3-1.1ubuntu5.14.04) ...
Setting up lttng-modules-dkms (2.4.0-1ubuntu1.1) ...



*Loading new lttng-modules-2.4.0 DKMS files...First Installation: checking
all kernels...dpkg: warning: version '*-*' has bad syntax: version number
does not start with digitIt is likely that
3.14.12-parallella-xilinx-g40a90c3 belongs to a chroot's host*

And at this point the installation just stop and i'm back with the prompt.

Since i'm quite new in the LTTng universe i don't know what to do. I made
some researches on the subject but there was nothing for the Parallella. I
only found an answer for a similar problem suggesting to install the kernel
causing this trouble in the chroot environment, but i'm not quite sure how
to do this properly.

Thanks in advance !

Thomas.

--089e0149bb0e7c50560516894e5e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi !<br><br></div>I recently began to work =
on a Parallella board and I wanted to try tracing the ARM processor with LT=
Tng before doing ant work with the Epiphany chip (co-processor).<br><br></d=
iv>Nevertheless, i&#39;m stuck with an error anytime i try to install the l=
ttng-modules. I&#39;ve tried installing it from the official repositories a=
nd from the PPA but none worked.<br><br></div>For now i only tried with the=
 headless version of Ubuntu 14.04 (<a href=3D"http://www.parallella.org/cre=
ate-sdcard/">http://www.parallella.org/create-sdcard/</a>) for the Zynq-701=
0 (the processor itself is a ARM Cortex A9).<br><div><div><br></div><div>Th=
e kernel version is 3.14.12, as seen in the error message below<br><br><br>=
</div><div><font size=3D"2"><span style=3D"font-family:times new roman,seri=
f">parallella@parallella:~$ sudo apt-get install lttng-modules-dkms<br>Read=
ing package lists... Done<br>Building dependency tree=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 <br>Reading state information... Done<br>The following extr=
a packages will be installed:<br>=C2=A0 dkms<br>The following NEW packages =
will be installed:<br>=C2=A0 dkms lttng-modules-dkms<br>0 upgraded, 2 newly=
 installed, 0 to remove and 1 not upgraded.<br>Need to get 286 kB of archiv=
es.<br>After this operation, 2816 kB of additional disk space will be used.=
<br>Do you want to continue? [Y/n] <br>Get:1 <a href=3D"http://ports.ubuntu=
.com/">http://ports.ubuntu.com/</a> trusty-updates/main dkms all 2.2.0.3-1.=
1ubuntu5.14.04 [64.6 kB]<br>Get:2 <a href=3D"http://ports.ubuntu.com/">http=
://ports.ubuntu.com/</a> trusty-updates/universe lttng-modules-dkms all 2.4=
.0-1ubuntu1.1 [221 kB]<br>Fetched 286 kB in 0s (356 kB/s)=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>Selecting previously unselected package =
dkms.<br>(Reading database ... 39070 files and directories currently instal=
led.)<br>Preparing to unpack .../dkms_2.2.0.3-1.1ubuntu5.14.04_all.deb ...<=
br>Unpacking dkms (2.2.0.3-1.1ubuntu5.14.04) ...<br>Selecting previously un=
selected package lttng-modules-dkms.<br>Preparing to unpack .../lttng-modul=
es-dkms_2.4.0-1ubuntu1.1_all.deb ...<br>Unpacking lttng-modules-dkms (2.4.0=
-1ubuntu1.1) ...<br>Processing triggers for man-db (2.6.7.1-1ubuntu1) ...<b=
r>Setting up dkms (2.2.0.3-1.1ubuntu5.14.04) ...<br>Setting up lttng-module=
s-dkms (2.4.0-1ubuntu1.1) ...<br><b>Loading new lttng-modules-2.4.0 DKMS fi=
les...<br>First Installation: checking all kernels...<br>dpkg: warning: ver=
sion &#39;*-*&#39; has bad syntax: version number does not start with digit=
<br>It is likely that 3.14.12-parallella-xilinx-g40a90c3 belongs to a chroo=
t&#39;s host</b></span></font><br><br></div><div>And at this point the inst=
allation just stop and i&#39;m back with the prompt.<br></div><div><br></di=
v><div>Since i&#39;m quite new in the LTTng universe i don&#39;t know what =
to do. I made some researches on the subject but there was nothing for the =
Parallella. I only found an answer for a similar problem suggesting to inst=
all the kernel causing this trouble in the chroot environment, but i&#39;m =
not quite sure how to do this properly.<br><br></div><div>Thanks in advance=
 !<br><br></div><div>Thomas.<br></div></div></div>

--089e0149bb0e7c50560516894e5e--


--===============1184908397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1184908397==--
