From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: is ltt patch required to build lttng module?
Date: Tue, 10 Dec 2013 10:20:15 -0500
Message-ID: <CA+jJMxs2Hu61tcDbUjzRnNe19G_P=W50K5F=j9Sq_LF41nGDDw__36208.5130568177$1386688866$gmane$org@mail.gmail.com>
References: <CAO_Arvp5Q6EfDS_LRBKKCaPybXG-3+vp6ezzjfAcRKfNk+YTrQ@mail.gmail.com>
	<CA+jJMxsuXT=_1Yw4N_ixx7RQyN0X5X3EaFPgPB2QzxuhKSDnLA@mail.gmail.com>
	<CAO_ArvoCr97=8rQiLx13OK1ndJQ4vZ2Ji9H1moXZ3OS8noYKaQ@mail.gmail.com>
	<CA+jJMxvaTkbH4tws5r9F_jgXv7Ter8E1C8hrJmKXOoNWaPtG+Q@mail.gmail.com>
	<CAO_ArvpJcByz_uJB3dhot55BXs99hmMazmT6GVnWvUSSqteHeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f47.google.com ([209.85.128.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VqP6j-0006Ec-1P
	for lttng-dev@lists.lttng.org; Tue, 10 Dec 2013 10:20:24 -0500
Received: by mail-qe0-f47.google.com with SMTP id t7so4070399qeb.6
	for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2013 07:20:15 -0800 (PST)
In-Reply-To: <CAO_ArvpJcByz_uJB3dhot55BXs99hmMazmT6GVnWvUSSqteHeg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: kumar s <skumar.m226@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, Dec 10, 2013 at 6:40 AM, kumar s <skumar.m226@gmail.com> wrote:
> Hi,
>
> I replaced the makefile with the original makefile. I did not make any
> changes in Makefile now.
>
>
> KERNELDIR=3D/opt/MIPS/OCTEON-SDK/linux/kernel_2.6/linux  make ARCH=3Dmips
> CROSS_COMPILE=3Dmips64-octeon-linux-gnu-
> make -C  /opt/MIPS/OCTEON-SDK/linux/kernel_2.6/linux
> M=3D/home/shkumar/lttng-tools/lttngnew/lttng-modules-f49eb38 modules
> make[1]: Entering directory `/opt/MIPS/OCTEON-SDK/linux/kernel_2.6/linux'
>
>   Building modules, stage 2.
>   MODPOST 0 modules
> make[1]: Leaving directory `/opt/MIPS/OCTEON-SDK/linux/kernel_2.6/linux'
>
>
> From  the Readme File ,
>
> I find only CONFIG_MODULES=3Dy, CONFIG_KALLSYMS=3Dy,CONFIG_HIGH_RES_TIMER=
S=3Dy in
> arch/mips/cavium-octeon_defconfig
>
> I dont find CONFIG_TRACEPOINT in cavium-octeon_defconfig.
>
> Also optional config mentioned in README is not there in
> arch/mips/cavium-octeon_defconfig.(CONFIG_PERF_EVENTS,CONFIG_HAVE_SYSCALL=
_TRACEPOINTS,CONFIG_EVENT_TRACING,CONFIG_KPROBES).
>
> Is this a reason the lttng modules not getting built?. If so how should i
> set it or enable.?

Probably. It's hard for me to verify since the SDK is behind a
registration/pay wall. CONFIG_TRACEPOINT is a boolean config option so
I guess adding CONFIG_TRACEPOINT=3Dy would do the trick.

Keep in mind that you will have to rebuild your platform's kernel.

Perhaps someone can spot something more obvious?

J=E9r=E9mie

>
> Thank you
> Skumar
>
>
>
> On Tue, Dec 10, 2013 at 1:01 AM, J=E9r=E9mie Galarneau
> <jeremie.galarneau@efficios.com> wrote:
>>
>> On Mon, Dec 9, 2013 at 3:13 AM, kumar s <skumar.m226@gmail.com> wrote:
>> > Hi,
>> >
>> > I have not patched the linux kernel provided with octeon sdk (kernel
>> > version
>> > 2.6.32.27). The Make has been modified with kernel directory path.
>> >
>> > #
>> > # Makefile for the LTT objects.
>> > #
>> >
>> > ifneq ($(KERNELRELEASE),)
>> > ifneq ($(CONFIG_TRACEPOINTS),)
>> >
>> > obj-m +=3D lttng-ring-buffer-client-discard.o
>> > obj-m +=3D lttng-ring-buffer-client-overwrite.o
>> > obj-m +=3D lttng-ring-buffer-metadata-client.o
>> > obj-m +=3D lttng-ring-buffer-client-mmap-discard.o
>> > obj-m +=3D lttng-ring-buffer-client-mmap-overwrite.o
>> > obj-m +=3D lttng-ring-buffer-metadata-mmap-client.o
>> >
>> > obj-m +=3D lttng-tracer.o
>> > lttng-tracer-objs :=3D  lttng-events.o lttng-abi.o \
>> > lttng-probes.o lttng-context.o \
>> > lttng-context-pid.o lttng-context-procname.o \
>> > lttng-context-prio.o lttng-context-nice.o \
>> > lttng-context-vpid.o lttng-context-tid.o \
>> > lttng-context-vtid.o lttng-context-ppid.o \
>> > lttng-context-vppid.o lttng-calibrate.o \
>> > lttng-context-hostname.o wrapper/random.o
>> >
>> > obj-m +=3D lttng-statedump.o
>> > lttng-statedump-objs :=3D lttng-statedump-impl.o wrapper/irqdesc.o \
>> > wrapper/fdtable.o
>> >
>> > ifneq ($(CONFIG_HAVE_SYSCALL_TRACEPOINTS),)
>> > lttng-tracer-objs +=3D lttng-syscalls.o probes/lttng-probe-user.o
>> > endif # CONFIG_HAVE_SYSCALL_TRACEPOINTS
>> >
>> > ifneq ($(CONFIG_PERF_EVENTS),)
>> > lttng-tracer-objs +=3D $(shell \
>> > if [ $(VERSION) -ge 3 \
>> > -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 33 \)=
 ]
>> > ;
>> > then \
>> > echo "lttng-context-perf-counters.o" ; fi;)
>> > endif # CONFIG_PERF_EVENTS
>> >
>> > obj-m +=3D probes/
>> > obj-m +=3D lib/
>> >
>> > endif # CONFIG_TRACEPOINTS
>> >
>> > else # KERNELRELEASE
>> > KERNELDIR ?=3D
>> >
>> > /home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeon_sdk/OCT=
EON-SDK/linux/kernel_2.6/linux/
>> > PWD :=3D $(shell pwd)
>> > CFLAGS =3D $(EXTCFLAGS)
>> >
>> > default:
>> > $(MAKE) -C $(KERNELDIR) M=3D$(PWD) modules ARCH=3Dmips
>> > CROSS_COMPILE=3Dmips64-octeon-linux-gnu-
>> >
>> > modules_install:
>> > $(MAKE) -C $(KERNELDIR) M=3D$(PWD) modules_install
>> >
>> > clean:
>> > $(MAKE) -C $(KERNELDIR) M=3D$(PWD) clean
>> >
>> > %.i: %.c
>> > $(MAKE) -C $(KERNELDIR) M=3D$(PWD) $@
>> > endif # KERNELRELEASE
>> >
>> >
>> >
>> > when trying to build
>> >
>> > make -C
>> >
>> > /home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeon_sdk/OCT=
EON-SDK/linux/kernel_2.6/linux/
>> > M=3D/home/shkumar/lttng-tools/lttngnew/lttng-modules-f49eb38 modules
>> > ARCH=3Dmips
>> > CROSS_COMPILE=3Dmips64-octeon-linux-gnu-
>> > make[1]: Entering directory
>> >
>> > `/home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeon_sdk/OC=
TEON-SDK/linux/kernel_2.6/linux'
>> >   Building modules, stage 2.
>> >   MODPOST 0 modules
>> > make[1]: Leaving directory
>> >
>> > `/home/shkumar/Development_Merge/OCT_no_patch/OCTEON_SDK/octeon_sdk/OC=
TEON-SDK/linux/kernel_2.6/linux'
>> >
>> > But lttng modules are not compiled. I cannot any modules(.ko or .o)
>> > being
>> > generated in lttng directory or in kernel path.
>> >
>> >
>> > If Octeon sdk is required , it can be obtained from cnusers.org.
>> >
>> > Only patches in linux_patch directory has been applied to the kernel.
>> >
>> > any suggestions to fix this ?
>>
>> Using the -C option should not be necessary.
>>
>> The README in lttng-modules' tree explains how to set a custom kernel
>> directory. The README also details the required kernel configuration
>> options. Make sure that your platform's kernel configuration follows
>> these requirements.
>>
>> % KERNELDIR=3Dpath_to_kernel_dir make
>> # KERNELDIR=3Dpath_to_kernel_dir make modules_install
>> # depmod -a kernel_version
>>
>> Regards,
>> J=E9r=E9mie
>>
>> >
>> > Thank you
>> > Skumar
>> >
>> >
>> > On Thu, Dec 5, 2013 at 8:55 PM, J=E9r=E9mie Galarneau
>> > <jeremie.galarneau@efficios.com> wrote:
>> >>
>> >> On Thu, Dec 5, 2013 at 2:40 AM, kumar s <skumar.m226@gmail.com> wrote:
>> >> > Hi,
>> >> >
>> >> > I am using kernel version 2.6.32.27. When building lttng module, do=
 i
>> >> > need
>> >> > to build against kernel which is patched using lttng (v0.190) or
>> >> > should
>> >> > i
>> >> > build lttng modules for kernel that is not patched.
>> >> >
>> >>
>> >> You do not need to patch your kernel using the 0.x kernel patch set to
>> >> use the 2.x tracer.
>> >>
>> >> To build lttng-modules on this kernel, you will need to apply the
>> >> patches found under linux-patches in the lttng-modules tree.
>> >>
>> >> Regards,
>> >> J=E9r=E9mie
>> >>
>> >> > I am trying to build lttng module latest version taken from
>> >> > lttng-module.git
>> >> >
>> >> > Thank you
>> >> > Skumar
>> >> >
>> >> > _______________________________________________
>> >> > lttng-dev mailing list
>> >> > lttng-dev@lists.lttng.org
>> >> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> >> >
>> >>
>> >>
>> >>
>> >> --
>> >> J=E9r=E9mie Galarneau
>> >> EfficiOS Inc.
>> >> http://www.efficios.com
>> >
>> >
>>
>>
>>
>> --
>> J=E9r=E9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
