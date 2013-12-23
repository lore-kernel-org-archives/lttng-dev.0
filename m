From: kumar s <skumar.m226@gmail.com>
Subject: Re: is ltt patch required to build lttng module?
Date: Mon, 23 Dec 2013 10:33:12 +0530
Message-ID: <CAO_ArvoSH-6CiBjYuRRTpfE-P5i985-=bZkJ28s2hn-vZZqssw__41928.853854961$1387775052$gmane$org@mail.gmail.com>
References: <CAO_Arvp5Q6EfDS_LRBKKCaPybXG-3+vp6ezzjfAcRKfNk+YTrQ@mail.gmail.com>
	<CA+jJMxsuXT=_1Yw4N_ixx7RQyN0X5X3EaFPgPB2QzxuhKSDnLA@mail.gmail.com>
	<CAO_ArvoCr97=8rQiLx13OK1ndJQ4vZ2Ji9H1moXZ3OS8noYKaQ@mail.gmail.com>
	<CA+jJMxvaTkbH4tws5r9F_jgXv7Ter8E1C8hrJmKXOoNWaPtG+Q@mail.gmail.com>
	<CAO_ArvpJcByz_uJB3dhot55BXs99hmMazmT6GVnWvUSSqteHeg@mail.gmail.com>
	<CA+jJMxs2Hu61tcDbUjzRnNe19G_P=W50K5F=j9Sq_LF41nGDDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0538646009=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1Vuxfi-0003a7-Mu
	for lttng-dev@lists.lttng.org; Mon, 23 Dec 2013 00:03:21 -0500
Received: by mail-lb0-f172.google.com with SMTP id x18so2103534lbi.31
	for <lttng-dev@lists.lttng.org>; Sun, 22 Dec 2013 21:03:12 -0800 (PST)
In-Reply-To: <CA+jJMxs2Hu61tcDbUjzRnNe19G_P=W50K5F=j9Sq_LF41nGDDw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0538646009==
Content-Type: multipart/alternative; boundary=001a113499a46e3a8704ee2c8bd5

--001a113499a46e3a8704ee2c8bd5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi

I tried setting CONFIG_TRACEPOINT=3Dy , still not able to build modules.

I will share the sdk access.

Username - skumarm226
password - OCT123SDK

www.cnusers.org. Once logged in , you can download sdk, toolchain from
Downloads/Downloads for registered users/OCTEON cnusers Software
Development kit/ Octeon cnusers sdk 2.3


Thank you
Skumar


On Tue, Dec 10, 2013 at 8:50 PM, J=E9r=E9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> On Tue, Dec 10, 2013 at 6:40 AM, kumar s <skumar.m226@gmail.com> wrote:
> > Hi,
> >
> > I replaced the makefile with the original makefile. I did not make any
> > changes in Makefile now.
> >
> >
> > KERNELDIR=3D/opt/MIPS/OCTEON-SDK/linux/kernel_2.6/linux  make ARCH=3Dmi=
ps
> > CROSS_COMPILE=3Dmips64-octeon-linux-gnu-
> > make -C  /opt/MIPS/OCTEON-SDK/linux/kernel_2.6/linux
> > M=3D/home/shkumar/lttng-tools/lttngnew/lttng-modules-f49eb38 modules
> > make[1]: Entering directory `/opt/MIPS/OCTEON-SDK/linux/kernel_2.6/linu=
x'
> >
> >   Building modules, stage 2.
> >   MODPOST 0 modules
> > make[1]: Leaving directory `/opt/MIPS/OCTEON-SDK/linux/kernel_2.6/linux=
'
> >
> >
> > From  the Readme File ,
> >
> > I find only CONFIG_MODULES=3Dy, CONFIG_KALLSYMS=3Dy,CONFIG_HIGH_RES_TIM=
ERS=3Dy
> in
> > arch/mips/cavium-octeon_defconfig
> >
> > I dont find CONFIG_TRACEPOINT in cavium-octeon_defconfig.
> >
> > Also optional config mentioned in README is not there in
> >
> arch/mips/cavium-octeon_defconfig.(CONFIG_PERF_EVENTS,CONFIG_HAVE_SYSCALL=
_TRACEPOINTS,CONFIG_EVENT_TRACING,CONFIG_KPROBES).
> >
> > Is this a reason the lttng modules not getting built?. If so how should=
 i
> > set it or enable.?
>
> Probably. It's hard for me to verify since the SDK is behind a
> registration/pay wall. CONFIG_TRACEPOINT is a boolean config option so
> I guess adding CONFIG_TRACEPOINT=3Dy would do the trick.
>
> Keep in mind that you will have to rebuild your platform's kernel.
>
> Perhaps someone can spot something more obvious?
>
> J=E9r=E9mie
>
> >
> > Thank you
> > Skumar
> >
> >
> >
> > On Tue, Dec 10, 2013 at 1:01 AM, J=E9r=E9mie Galarneau
> > <jeremie.galarneau@efficios.com> wrote:
> >>
> >> On Mon, Dec 9, 2013 at 3:13 AM, kumar s <skumar.m226@gmail.com> wrote:
> >> > Hi,
> >> >
> >> > I have not patched the linux kernel provided with octeon sdk (kernel
> >> > version
> >> > 2.6.32.27). The Make has been modified with kernel directory path.
> >> >
> >> > #
> >> > # Makefile for the LTT objects.
> >> > #
> >> >
> >> > ifneq ($(KERNELRELEASE),)
> >> > ifneq ($(CONFIG_TRACEPOINTS),)
> >> >
> >> > obj-m +=3D lttng-ring-buffer-client-discard.o
> >> > obj-m +=3D lttng-ring-buffer-client-overwrite.o
> >> > obj-m +=3D lttng-ring-buffer-metadata-client.o
> >> > obj-m +=3D lttng-ring-buffer-client-mmap-discard.o
> >> > obj-m +=3D lttng-ring-buffer-client-mmap-overwrite.o
> >> > obj-m +=3D lttng-ring-buffer-metadata-mmap-client.o
> >> >
> >> > obj-m +=3D lttng-tracer.o
> >> > lttng-tracer-objs :=3D  lttng-events.o lttng-abi.o \
> >> > lttng-probes.o lttng-context.o \
> >> > lttng-context-pid.o lttng-context-procname.o \
> >> > lttng-context-prio.o lttng-context-nice.o \
> >> > lttng-context-vpid.o lttng-context-tid.o \
> >> > lttng-context-vtid.o lttng-context-ppid.o \
> >> > lttng-context-vppid.o lttng-calibrate.o \
> >> > lttng-context-hostname.o wrapper/random.o
> >> >
> >> > obj-m +=3D lttng-statedump.o
> >> > lttng-statedump-objs :=3D lttng-statedump-impl.o wrapper/irqdesc.o \
> >> > wrapper/fdtable.o
> >> >
> >> > ifneq ($(CONFIG_HAVE_SYSCALL_TRACEPOINTS),)
> >> > lttng-tracer-objs +=3D lttng-syscalls.o probes/lttng-probe-user.o
> >> > endif # CONFIG_HAVE_SYSCALL_TRACEPOINTS
> >> >
> >> > ifneq ($(CONFIG_PERF_EVENTS),)
> >> > lttng-tracer-objs +=3D $(shell \
> >> > if [ $(VERSION) -ge 3 \
> >> > -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 33
> \) ]
> >> > ;
> >> > then \
> >> > echo "lttng-context-perf-counters.o" ; fi;)
> >> > endif # CONFIG_PERF_EVENTS
> >> >
> >> > obj-m +=3D probes/
> >> > obj-m +=3D lib/
> >> >
> >> > endif # CONFIG_TRACEPOINTS
> >> >
> >> > else # KERNELRELEASE
> >> > KERNELDIR ?=3D
> >> >
> >> >
> /home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeon_sdk/OCTEON=
-SDK/linux/kernel_2.6/linux/
> >> > PWD :=3D $(shell pwd)
> >> > CFLAGS =3D $(EXTCFLAGS)
> >> >
> >> > default:
> >> > $(MAKE) -C $(KERNELDIR) M=3D$(PWD) modules ARCH=3Dmips
> >> > CROSS_COMPILE=3Dmips64-octeon-linux-gnu-
> >> >
> >> > modules_install:
> >> > $(MAKE) -C $(KERNELDIR) M=3D$(PWD) modules_install
> >> >
> >> > clean:
> >> > $(MAKE) -C $(KERNELDIR) M=3D$(PWD) clean
> >> >
> >> > %.i: %.c
> >> > $(MAKE) -C $(KERNELDIR) M=3D$(PWD) $@
> >> > endif # KERNELRELEASE
> >> >
> >> >
> >> >
> >> > when trying to build
> >> >
> >> > make -C
> >> >
> >> >
> /home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeon_sdk/OCTEON=
-SDK/linux/kernel_2.6/linux/
> >> > M=3D/home/shkumar/lttng-tools/lttngnew/lttng-modules-f49eb38 modules
> >> > ARCH=3Dmips
> >> > CROSS_COMPILE=3Dmips64-octeon-linux-gnu-
> >> > make[1]: Entering directory
> >> >
> >> >
> `/home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeon_sdk/OCTEO=
N-SDK/linux/kernel_2.6/linux'
> >> >   Building modules, stage 2.
> >> >   MODPOST 0 modules
> >> > make[1]: Leaving directory
> >> >
> >> >
> `/home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeon_sdk/OCTEO=
N-SDK/linux/kernel_2.6/linux'
> >> >
> >> > But lttng modules are not compiled. I cannot any modules(.ko or .o)
> >> > being
> >> > generated in lttng directory or in kernel path.
> >> >
> >> >
> >> > If Octeon sdk is required , it can be obtained from cnusers.org.
> >> >
> >> > Only patches in linux_patch directory has been applied to the kernel=
.
> >> >
> >> > any suggestions to fix this ?
> >>
> >> Using the -C option should not be necessary.
> >>
> >> The README in lttng-modules' tree explains how to set a custom kernel
> >> directory. The README also details the required kernel configuration
> >> options. Make sure that your platform's kernel configuration follows
> >> these requirements.
> >>
> >> % KERNELDIR=3Dpath_to_kernel_dir make
> >> # KERNELDIR=3Dpath_to_kernel_dir make modules_install
> >> # depmod -a kernel_version
> >>
> >> Regards,
> >> J=E9r=E9mie
> >>
> >> >
> >> > Thank you
> >> > Skumar
> >> >
> >> >
> >> > On Thu, Dec 5, 2013 at 8:55 PM, J=E9r=E9mie Galarneau
> >> > <jeremie.galarneau@efficios.com> wrote:
> >> >>
> >> >> On Thu, Dec 5, 2013 at 2:40 AM, kumar s <skumar.m226@gmail.com>
> wrote:
> >> >> > Hi,
> >> >> >
> >> >> > I am using kernel version 2.6.32.27. When building lttng module,
> do i
> >> >> > need
> >> >> > to build against kernel which is patched using lttng (v0.190) or
> >> >> > should
> >> >> > i
> >> >> > build lttng modules for kernel that is not patched.
> >> >> >
> >> >>
> >> >> You do not need to patch your kernel using the 0.x kernel patch set
> to
> >> >> use the 2.x tracer.
> >> >>
> >> >> To build lttng-modules on this kernel, you will need to apply the
> >> >> patches found under linux-patches in the lttng-modules tree.
> >> >>
> >> >> Regards,
> >> >> J=E9r=E9mie
> >> >>
> >> >> > I am trying to build lttng module latest version taken from
> >> >> > lttng-module.git
> >> >> >
> >> >> > Thank you
> >> >> > Skumar
> >> >> >
> >> >> > _______________________________________________
> >> >> > lttng-dev mailing list
> >> >> > lttng-dev@lists.lttng.org
> >> >> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >> >> >
> >> >>
> >> >>
> >> >>
> >> >> --
> >> >> J=E9r=E9mie Galarneau
> >> >> EfficiOS Inc.
> >> >> http://www.efficios.com
> >> >
> >> >
> >>
> >>
> >>
> >> --
> >> J=E9r=E9mie Galarneau
> >> EfficiOS Inc.
> >> http://www.efficios.com
> >
> >
>
>
>
> --
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--001a113499a46e3a8704ee2c8bd5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>I tried setting CONFIG_TRACEPOINT=3D=
y , still not able to build modules.=A0</div><div><br></div><div>I will sha=
re the sdk access.=A0</div><div><br></div><div>Username - skumarm226</div><=
div>password - OCT123SDK</div>
<div><br></div><div><a href=3D"http://www.cnusers.org">www.cnusers.org</a>.=
 Once logged in , you can download sdk, toolchain from Downloads/Downloads =
for registered users/OCTEON cnusers Software Development kit/ Octeon cnuser=
s sdk 2.3</div>
<div><br></div><div><br></div><div>Thank you</div><div>Skumar</div></div><d=
iv class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Tue, Dec 10,=
 2013 at 8:50 PM, J=E9r=E9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@ef=
ficios.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Tue, Dec 10, 2013 at 6:=
40 AM, kumar s &lt;<a href=3D"mailto:skumar.m226@gmail.com">skumar.m226@gma=
il.com</a>&gt; wrote:<br>

&gt; Hi,<br>
&gt;<br>
</div><div class=3D"im">&gt; I replaced the makefile with the original make=
file. I did not make any<br>
&gt; changes in Makefile now.<br>
&gt;<br>
&gt;<br>
&gt; KERNELDIR=3D/opt/MIPS/OCTEON-SDK/linux/kernel_2.6/linux =A0make ARCH=
=3Dmips<br>
&gt; CROSS_COMPILE=3Dmips64-octeon-linux-gnu-<br>
&gt; make -C =A0/opt/MIPS/OCTEON-SDK/linux/kernel_2.6/linux<br>
&gt; M=3D/home/shkumar/lttng-tools/lttngnew/lttng-modules-f49eb38 modules<b=
r>
&gt; make[1]: Entering directory `/opt/MIPS/OCTEON-SDK/linux/kernel_2.6/lin=
ux&#39;<br>
&gt;<br>
&gt; =A0 Building modules, stage 2.<br>
&gt; =A0 MODPOST 0 modules<br>
&gt; make[1]: Leaving directory `/opt/MIPS/OCTEON-SDK/linux/kernel_2.6/linu=
x&#39;<br>
&gt;<br>
&gt;<br>
&gt; From =A0the Readme File ,<br>
&gt;<br>
&gt; I find only CONFIG_MODULES=3Dy, CONFIG_KALLSYMS=3Dy,CONFIG_HIGH_RES_TI=
MERS=3Dy in<br>
&gt; arch/mips/cavium-octeon_defconfig<br>
&gt;<br>
&gt; I dont find CONFIG_TRACEPOINT in cavium-octeon_defconfig.<br>
&gt;<br>
&gt; Also optional config mentioned in README is not there in<br>
&gt; arch/mips/cavium-octeon_defconfig.(CONFIG_PERF_EVENTS,CONFIG_HAVE_SYSC=
ALL_TRACEPOINTS,CONFIG_EVENT_TRACING,CONFIG_KPROBES).<br>
&gt;<br>
&gt; Is this a reason the lttng modules not getting built?. If so how shoul=
d i<br>
&gt; set it or enable.?<br>
<br>
</div>Probably. It&#39;s hard for me to verify since the SDK is behind a<br=
>
registration/pay wall. CONFIG_TRACEPOINT is a boolean config option so<br>
I guess adding CONFIG_TRACEPOINT=3Dy would do the trick.<br>
<br>
Keep in mind that you will have to rebuild your platform&#39;s kernel.<br>
<br>
Perhaps someone can spot something more obvious?<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
J=E9r=E9mie<br>
<br>
&gt;<br>
&gt; Thank you<br>
&gt; Skumar<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Dec 10, 2013 at 1:01 AM, J=E9r=E9mie Galarneau<br>
&gt; &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">jeremie.galarnea=
u@efficios.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Dec 9, 2013 at 3:13 AM, kumar s &lt;<a href=3D"mailto:skum=
ar.m226@gmail.com">skumar.m226@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt; Hi,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I have not patched the linux kernel provided with octeon sdk =
(kernel<br>
&gt;&gt; &gt; version<br>
&gt;&gt; &gt; 2.6.32.27). The Make has been modified with kernel directory =
path.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; #<br>
&gt;&gt; &gt; # Makefile for the LTT objects.<br>
&gt;&gt; &gt; #<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ifneq ($(KERNELRELEASE),)<br>
&gt;&gt; &gt; ifneq ($(CONFIG_TRACEPOINTS),)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; obj-m +=3D lttng-ring-buffer-client-discard.o<br>
&gt;&gt; &gt; obj-m +=3D lttng-ring-buffer-client-overwrite.o<br>
&gt;&gt; &gt; obj-m +=3D lttng-ring-buffer-metadata-client.o<br>
&gt;&gt; &gt; obj-m +=3D lttng-ring-buffer-client-mmap-discard.o<br>
&gt;&gt; &gt; obj-m +=3D lttng-ring-buffer-client-mmap-overwrite.o<br>
&gt;&gt; &gt; obj-m +=3D lttng-ring-buffer-metadata-mmap-client.o<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; obj-m +=3D lttng-tracer.o<br>
&gt;&gt; &gt; lttng-tracer-objs :=3D =A0lttng-events.o lttng-abi.o \<br>
&gt;&gt; &gt; lttng-probes.o lttng-context.o \<br>
&gt;&gt; &gt; lttng-context-pid.o lttng-context-procname.o \<br>
&gt;&gt; &gt; lttng-context-prio.o lttng-context-nice.o \<br>
&gt;&gt; &gt; lttng-context-vpid.o lttng-context-tid.o \<br>
&gt;&gt; &gt; lttng-context-vtid.o lttng-context-ppid.o \<br>
&gt;&gt; &gt; lttng-context-vppid.o lttng-calibrate.o \<br>
&gt;&gt; &gt; lttng-context-hostname.o wrapper/random.o<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; obj-m +=3D lttng-statedump.o<br>
&gt;&gt; &gt; lttng-statedump-objs :=3D lttng-statedump-impl.o wrapper/irqd=
esc.o \<br>
&gt;&gt; &gt; wrapper/fdtable.o<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ifneq ($(CONFIG_HAVE_SYSCALL_TRACEPOINTS),)<br>
&gt;&gt; &gt; lttng-tracer-objs +=3D lttng-syscalls.o probes/lttng-probe-us=
er.o<br>
&gt;&gt; &gt; endif # CONFIG_HAVE_SYSCALL_TRACEPOINTS<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ifneq ($(CONFIG_PERF_EVENTS),)<br>
&gt;&gt; &gt; lttng-tracer-objs +=3D $(shell \<br>
&gt;&gt; &gt; if [ $(VERSION) -ge 3 \<br>
&gt;&gt; &gt; -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) =
-ge 33 \) ]<br>
&gt;&gt; &gt; ;<br>
&gt;&gt; &gt; then \<br>
&gt;&gt; &gt; echo &quot;lttng-context-perf-counters.o&quot; ; fi;)<br>
&gt;&gt; &gt; endif # CONFIG_PERF_EVENTS<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; obj-m +=3D probes/<br>
&gt;&gt; &gt; obj-m +=3D lib/<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; endif # CONFIG_TRACEPOINTS<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; else # KERNELRELEASE<br>
&gt;&gt; &gt; KERNELDIR ?=3D<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; /home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeo=
n_sdk/OCTEON-SDK/linux/kernel_2.6/linux/<br>
&gt;&gt; &gt; PWD :=3D $(shell pwd)<br>
&gt;&gt; &gt; CFLAGS =3D $(EXTCFLAGS)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; default:<br>
&gt;&gt; &gt; $(MAKE) -C $(KERNELDIR) M=3D$(PWD) modules ARCH=3Dmips<br>
&gt;&gt; &gt; CROSS_COMPILE=3Dmips64-octeon-linux-gnu-<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; modules_install:<br>
&gt;&gt; &gt; $(MAKE) -C $(KERNELDIR) M=3D$(PWD) modules_install<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; clean:<br>
&gt;&gt; &gt; $(MAKE) -C $(KERNELDIR) M=3D$(PWD) clean<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; %.i: %.c<br>
&gt;&gt; &gt; $(MAKE) -C $(KERNELDIR) M=3D$(PWD) $@<br>
&gt;&gt; &gt; endif # KERNELRELEASE<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; when trying to build<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; make -C<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; /home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeo=
n_sdk/OCTEON-SDK/linux/kernel_2.6/linux/<br>
&gt;&gt; &gt; M=3D/home/shkumar/lttng-tools/lttngnew/lttng-modules-f49eb38 =
modules<br>
&gt;&gt; &gt; ARCH=3Dmips<br>
&gt;&gt; &gt; CROSS_COMPILE=3Dmips64-octeon-linux-gnu-<br>
&gt;&gt; &gt; make[1]: Entering directory<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; `/home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octe=
on_sdk/OCTEON-SDK/linux/kernel_2.6/linux&#39;<br>
&gt;&gt; &gt; =A0 Building modules, stage 2.<br>
&gt;&gt; &gt; =A0 MODPOST 0 modules<br>
&gt;&gt; &gt; make[1]: Leaving directory<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; `/home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octe=
on_sdk/OCTEON-SDK/linux/kernel_2.6/linux&#39;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; But lttng modules are not compiled. I cannot any modules(.ko =
or .o)<br>
&gt;&gt; &gt; being<br>
&gt;&gt; &gt; generated in lttng directory or in kernel path.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; If Octeon sdk is required , it can be obtained from <a href=
=3D"http://cnusers.org" target=3D"_blank">cnusers.org</a>.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Only patches in linux_patch directory has been applied to the=
 kernel.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; any suggestions to fix this ?<br>
&gt;&gt;<br>
&gt;&gt; Using the -C option should not be necessary.<br>
&gt;&gt;<br>
&gt;&gt; The README in lttng-modules&#39; tree explains how to set a custom=
 kernel<br>
&gt;&gt; directory. The README also details the required kernel configurati=
on<br>
&gt;&gt; options. Make sure that your platform&#39;s kernel configuration f=
ollows<br>
&gt;&gt; these requirements.<br>
&gt;&gt;<br>
&gt;&gt; % KERNELDIR=3Dpath_to_kernel_dir make<br>
&gt;&gt; # KERNELDIR=3Dpath_to_kernel_dir make modules_install<br>
&gt;&gt; # depmod -a kernel_version<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; J=E9r=E9mie<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thank you<br>
&gt;&gt; &gt; Skumar<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Thu, Dec 5, 2013 at 8:55 PM, J=E9r=E9mie Galarneau<br>
&gt;&gt; &gt; &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">jeremie=
.galarneau@efficios.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; On Thu, Dec 5, 2013 at 2:40 AM, kumar s &lt;<a href=3D"ma=
ilto:skumar.m226@gmail.com">skumar.m226@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt; Hi,<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; I am using kernel version 2.6.32.27. When building l=
ttng module, do i<br>
&gt;&gt; &gt;&gt; &gt; need<br>
&gt;&gt; &gt;&gt; &gt; to build against kernel which is patched using lttng=
 (v0.190) or<br>
&gt;&gt; &gt;&gt; &gt; should<br>
&gt;&gt; &gt;&gt; &gt; i<br>
&gt;&gt; &gt;&gt; &gt; build lttng modules for kernel that is not patched.<=
br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; You do not need to patch your kernel using the 0.x kernel=
 patch set to<br>
&gt;&gt; &gt;&gt; use the 2.x tracer.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; To build lttng-modules on this kernel, you will need to a=
pply the<br>
&gt;&gt; &gt;&gt; patches found under linux-patches in the lttng-modules tr=
ee.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Regards,<br>
&gt;&gt; &gt;&gt; J=E9r=E9mie<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; I am trying to build lttng module latest version tak=
en from<br>
&gt;&gt; &gt;&gt; &gt; lttng-module.git<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Thank you<br>
&gt;&gt; &gt;&gt; &gt; Skumar<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; _______________________________________________<br>
&gt;&gt; &gt;&gt; &gt; lttng-dev mailing list<br>
&gt;&gt; &gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-d=
ev@lists.lttng.org</a><br>
&gt;&gt; &gt;&gt; &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev</a><br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; --<br>
&gt;&gt; &gt;&gt; J=E9r=E9mie Galarneau<br>
&gt;&gt; &gt;&gt; EfficiOS Inc.<br>
&gt;&gt; &gt;&gt; <a href=3D"http://www.efficios.com" target=3D"_blank">htt=
p://www.efficios.com</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; J=E9r=E9mie Galarneau<br>
&gt;&gt; EfficiOS Inc.<br>
&gt;&gt; <a href=3D"http://www.efficios.com" target=3D"_blank">http://www.e=
fficios.com</a><br>
&gt;<br>
&gt;<br>
<br>
<br>
<br>
--<br>
J=E9r=E9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</div></div></blockquote></div><br></div>

--001a113499a46e3a8704ee2c8bd5--


--===============0538646009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0538646009==--
