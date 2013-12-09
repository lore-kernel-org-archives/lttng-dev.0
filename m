From: kumar s <skumar.m226@gmail.com>
Subject: Re: is ltt patch required to build lttng module?
Date: Mon, 9 Dec 2013 13:43:26 +0530
Message-ID: <CAO_ArvoCr97=8rQiLx13OK1ndJQ4vZ2Ji9H1moXZ3OS8noYKaQ__46699.9296834276$1386576882$gmane$org@mail.gmail.com>
References: <CAO_Arvp5Q6EfDS_LRBKKCaPybXG-3+vp6ezzjfAcRKfNk+YTrQ@mail.gmail.com>
	<CA+jJMxsuXT=_1Yw4N_ixx7RQyN0X5X3EaFPgPB2QzxuhKSDnLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0907130005=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1Vpvy8-0007qC-D6
	for lttng-dev@lists.lttng.org; Mon, 09 Dec 2013 03:13:38 -0500
Received: by mail-vc0-f182.google.com with SMTP id lc6so3144492vcb.13
	for <lttng-dev@lists.lttng.org>; Mon, 09 Dec 2013 00:13:26 -0800 (PST)
In-Reply-To: <CA+jJMxsuXT=_1Yw4N_ixx7RQyN0X5X3EaFPgPB2QzxuhKSDnLA@mail.gmail.com>
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

--===============0907130005==
Content-Type: multipart/alternative; boundary=047d7b5d9edf03ce5204ed1592f3

--047d7b5d9edf03ce5204ed1592f3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I have not patched the linux kernel provided with octeon sdk (kernel
version 2.6.32.27). The Make has been modified with kernel directory path.

#
# Makefile for the LTT objects.
#

ifneq ($(KERNELRELEASE),)
ifneq ($(CONFIG_TRACEPOINTS),)

obj-m +=3D lttng-ring-buffer-client-discard.o
obj-m +=3D lttng-ring-buffer-client-overwrite.o
obj-m +=3D lttng-ring-buffer-metadata-client.o
obj-m +=3D lttng-ring-buffer-client-mmap-discard.o
obj-m +=3D lttng-ring-buffer-client-mmap-overwrite.o
obj-m +=3D lttng-ring-buffer-metadata-mmap-client.o

obj-m +=3D lttng-tracer.o
lttng-tracer-objs :=3D  lttng-events.o lttng-abi.o \
lttng-probes.o lttng-context.o \
lttng-context-pid.o lttng-context-procname.o \
lttng-context-prio.o lttng-context-nice.o \
lttng-context-vpid.o lttng-context-tid.o \
lttng-context-vtid.o lttng-context-ppid.o \
lttng-context-vppid.o lttng-calibrate.o \
lttng-context-hostname.o wrapper/random.o

obj-m +=3D lttng-statedump.o
lttng-statedump-objs :=3D lttng-statedump-impl.o wrapper/irqdesc.o \
wrapper/fdtable.o

ifneq ($(CONFIG_HAVE_SYSCALL_TRACEPOINTS),)
lttng-tracer-objs +=3D lttng-syscalls.o probes/lttng-probe-user.o
endif # CONFIG_HAVE_SYSCALL_TRACEPOINTS

ifneq ($(CONFIG_PERF_EVENTS),)
lttng-tracer-objs +=3D $(shell \
if [ $(VERSION) -ge 3 \
-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 33 \) ] ;
then \
echo "lttng-context-perf-counters.o" ; fi;)
endif # CONFIG_PERF_EVENTS

obj-m +=3D probes/
obj-m +=3D lib/

endif # CONFIG_TRACEPOINTS

else # KERNELRELEASE
KERNELDIR ?=3D*
/home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeon_sdk/OCTEON-S=
DK/linux/kernel_2.6/linux/*
PWD :=3D $(shell pwd)
CFLAGS =3D $(EXTCFLAGS)

default:
$(MAKE) -C $(KERNELDIR) M=3D$(PWD) modules ARCH=3Dmips
CROSS_COMPILE=3Dmips64-octeon-linux-gnu-

modules_install:
$(MAKE) -C $(KERNELDIR) M=3D$(PWD) modules_install

clean:
$(MAKE) -C $(KERNELDIR) M=3D$(PWD) clean

%.i: %.c
$(MAKE) -C $(KERNELDIR) M=3D$(PWD) $@
endif # KERNELRELEASE



when trying to build

make -C
/home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeon_sdk/OCTEON-S=
DK/linux/kernel_2.6/linux/
M=3D/home/shkumar/lttng-tools/lttngnew/lttng-modules-f49eb38 modules
ARCH=3Dmips CROSS_COMPILE=3Dmips64-octeon-linux-gnu-
make[1]: Entering directory
`/home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeon_sdk/OCTEON-=
SDK/linux/kernel_2.6/linux'
  Building modules, stage 2.
  MODPOST 0 modules
make[1]: Leaving directory
`/home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeon_sdk/OCTEON-=
SDK/linux/kernel_2.6/linux'

But lttng modules are not compiled. I cannot any modules(.ko or .o) being
generated in lttng directory or in kernel path.


If Octeon sdk is required , it can be obtained from cnusers.org.

Only patches in linux_patch directory has been applied to the kernel.

any suggestions to fix this ?

Thank you
Skumar


On Thu, Dec 5, 2013 at 8:55 PM, J=E9r=E9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> On Thu, Dec 5, 2013 at 2:40 AM, kumar s <skumar.m226@gmail.com> wrote:
> > Hi,
> >
> > I am using kernel version 2.6.32.27. When building lttng module, do i
> need
> > to build against kernel which is patched using lttng (v0.190) or should=
 i
> > build lttng modules for kernel that is not patched.
> >
>
> You do not need to patch your kernel using the 0.x kernel patch set to
> use the 2.x tracer.
>
> To build lttng-modules on this kernel, you will need to apply the
> patches found under linux-patches in the lttng-modules tree.
>
> Regards,
> J=E9r=E9mie
>
> > I am trying to build lttng module latest version taken from
> lttng-module.git
> >
> > Thank you
> > Skumar
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>
>
>
> --
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--047d7b5d9edf03ce5204ed1592f3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I have not patched the linux kernel=
 provided with octeon sdk (kernel version 2.6.32.27). The Make has been mod=
ified with kernel directory path.</div><div><br></div><div><div>#</div><div=
>
# Makefile for the LTT objects.</div><div>#</div><div><br></div><div>ifneq =
($(KERNELRELEASE),)</div><div>ifneq ($(CONFIG_TRACEPOINTS),)</div><div><br>=
</div><div>obj-m +=3D lttng-ring-buffer-client-discard.o</div><div>obj-m +=
=3D lttng-ring-buffer-client-overwrite.o</div>
<div>obj-m +=3D lttng-ring-buffer-metadata-client.o</div><div>obj-m +=3D lt=
tng-ring-buffer-client-mmap-discard.o</div><div>obj-m +=3D lttng-ring-buffe=
r-client-mmap-overwrite.o</div><div>obj-m +=3D lttng-ring-buffer-metadata-m=
map-client.o</div>
<div><br></div><div>obj-m +=3D lttng-tracer.o</div><div>lttng-tracer-objs :=
=3D =A0lttng-events.o lttng-abi.o \</div><div><span class=3D"" style=3D"whi=
te-space:pre">			</span>lttng-probes.o lttng-context.o \</div><div><span cl=
ass=3D"" style=3D"white-space:pre">			</span>lttng-context-pid.o lttng-cont=
ext-procname.o \</div>
<div><span class=3D"" style=3D"white-space:pre">			</span>lttng-context-pri=
o.o lttng-context-nice.o \</div><div><span class=3D"" style=3D"white-space:=
pre">			</span>lttng-context-vpid.o lttng-context-tid.o \</div><div><span c=
lass=3D"" style=3D"white-space:pre">			</span>lttng-context-vtid.o lttng-co=
ntext-ppid.o \</div>
<div><span class=3D"" style=3D"white-space:pre">			</span>lttng-context-vpp=
id.o lttng-calibrate.o \</div><div><span class=3D"" style=3D"white-space:pr=
e">			</span>lttng-context-hostname.o wrapper/random.o</div><div><br></div>=
<div>
obj-m +=3D lttng-statedump.o</div><div>lttng-statedump-objs :=3D lttng-stat=
edump-impl.o wrapper/irqdesc.o \</div><div><span class=3D"" style=3D"white-=
space:pre">			</span>wrapper/fdtable.o</div><div><br></div><div>ifneq ($(CO=
NFIG_HAVE_SYSCALL_TRACEPOINTS),)</div>
<div>lttng-tracer-objs +=3D lttng-syscalls.o probes/lttng-probe-user.o</div=
><div>endif # CONFIG_HAVE_SYSCALL_TRACEPOINTS</div><div><br></div><div>ifne=
q ($(CONFIG_PERF_EVENTS),)</div><div>lttng-tracer-objs +=3D $(shell \</div>
<div><span class=3D"" style=3D"white-space:pre">	</span>if [ $(VERSION) -ge=
 3 \</div><div><span class=3D"" style=3D"white-space:pre">		</span>-o \( $(=
VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 33 \) ] ; then \</=
div>
<div><span class=3D"" style=3D"white-space:pre">		</span>echo &quot;lttng-c=
ontext-perf-counters.o&quot; ; fi;)</div><div>endif # CONFIG_PERF_EVENTS</d=
iv><div><br></div><div>obj-m +=3D probes/</div><div>obj-m +=3D lib/</div><d=
iv><br>
</div><div>endif # CONFIG_TRACEPOINTS</div><div><br></div><div>else # KERNE=
LRELEASE</div><div><span class=3D"" style=3D"white-space:pre">	</span>KERNE=
LDIR ?=3D<b> /home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeon=
_sdk/OCTEON-SDK/linux/kernel_2.6/linux/</b></div>
<div><span class=3D"" style=3D"white-space:pre">	</span>PWD :=3D $(shell pw=
d)</div><div><span class=3D"" style=3D"white-space:pre">	</span>CFLAGS =3D =
$(EXTCFLAGS)</div><div><br></div><div>default:</div><div><span class=3D"" s=
tyle=3D"white-space:pre">	</span>$(MAKE) -C $(KERNELDIR) M=3D$(PWD) modules=
 ARCH=3Dmips CROSS_COMPILE=3Dmips64-octeon-linux-gnu-</div>
<div><br></div><div>modules_install:</div><div><span class=3D"" style=3D"wh=
ite-space:pre">	</span>$(MAKE) -C $(KERNELDIR) M=3D$(PWD) modules_install</=
div><div><br></div><div>clean:</div><div><span class=3D"" style=3D"white-sp=
ace:pre">	</span>$(MAKE) -C $(KERNELDIR) M=3D$(PWD) clean</div>
<div><br></div><div>%.i: %.c</div><div><span class=3D"" style=3D"white-spac=
e:pre">	</span>$(MAKE) -C $(KERNELDIR) M=3D$(PWD) $@</div><div>endif # KERN=
ELRELEASE</div></div><div><br></div><div><br></div><div><br></div><div>when=
 trying to build</div>
<div><br></div><div><div>make -C /home/shkumar/Development_Merge/OCT_no_pat=
ch/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux/ M=3D/home/shkum=
ar/lttng-tools/lttngnew/lttng-modules-f49eb38 modules ARCH=3Dmips CROSS_COM=
PILE=3Dmips64-octeon-linux-gnu-</div>
<div>make[1]: Entering directory `/home/shkumar/Development_Merge/OCT_no_pa=
tch/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux&#39;</div><div>=
=A0 Building modules, stage 2.</div><div>=A0 MODPOST 0 modules</div><div>ma=
ke[1]: Leaving directory `/home/shkumar/Development_Merge/OCT_no_patch/OCTE=
ON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux&#39;</div>
</div><div><br></div><div>But lttng modules are not compiled. I cannot any =
modules(.ko or .o) being generated in lttng directory or in kernel path.</d=
iv><div><br></div><div><br></div><div>If Octeon sdk is required , it can be=
 obtained from <a href=3D"http://cnusers.org">cnusers.org</a>.</div>
<div><br></div><div>Only patches in linux_patch directory has been applied =
to the kernel.</div><div><br></div><div>any suggestions to fix this ?</div>=
<div><br></div><div>Thank you</div><div>Skumar</div></div><div class=3D"gma=
il_extra">
<br><br><div class=3D"gmail_quote">On Thu, Dec 5, 2013 at 8:55 PM, J=E9r=E9=
mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@eff=
icios.com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</span> =
wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Thu, Dec 5, 2013 at 2:4=
0 AM, kumar s &lt;<a href=3D"mailto:skumar.m226@gmail.com">skumar.m226@gmai=
l.com</a>&gt; wrote:<br>

&gt; Hi,<br>
&gt;<br>
&gt; I am using kernel version 2.6.32.27. When building lttng module, do i =
need<br>
&gt; to build against kernel which is patched using lttng (v0.190) or shoul=
d i<br>
&gt; build lttng modules for kernel that is not patched.<br>
&gt;<br>
<br>
</div>You do not need to patch your kernel using the 0.x kernel patch set t=
o<br>
use the 2.x tracer.<br>
<br>
To build lttng-modules on this kernel, you will need to apply the<br>
patches found under linux-patches in the lttng-modules tree.<br>
<br>
Regards,<br>
J=E9r=E9mie<br>
<div class=3D"im"><br>
&gt; I am trying to build lttng module latest version taken from lttng-modu=
le.git<br>
&gt;<br>
&gt; Thank you<br>
&gt; Skumar<br>
&gt;<br>
</div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
J=E9r=E9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>

--047d7b5d9edf03ce5204ed1592f3--


--===============0907130005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0907130005==--
