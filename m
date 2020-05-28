From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: lttng_lib_ring_buffer: section 24 reloc 0 sym '':
 relocation 42 out of range
Date: Thu, 28 May 2020 09:31:34 -0400 (EDT)
Message-ID: <1946784173.38418.1590672694129.JavaMail.zimbra@efficios.com>
References: <CAGK+5gW_7Lo3O4oYW8jVJqDiUby6xoRyL3-JJQDQ8VYLG7WPAg@mail.gmail.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49XpWb24q7z1Fx8
 for <lttng-dev@lists.lttng.org>; Thu, 28 May 2020 09:31:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7E0412821C0
 for <lttng-dev@lists.lttng.org>; Thu, 28 May 2020 09:31:34 -0400 (EDT)
In-Reply-To: <CAGK+5gW_7Lo3O4oYW8jVJqDiUby6xoRyL3-JJQDQ8VYLG7WPAg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Lukasz Domowy <lukasz.odw39@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On May 28, 2020, at 7:51 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Hello,
> 
> First - of all: thank you very much for efforts to develop and
> maintain LTTng. It's very useful tool!
> I used it so far on PowerPC targets and now I try to run it on ARM:
> Cyclone5 ARMv7 CPU.
> 
> When trying to run LTTng I get:
> 
> # lttng list --kernel
> [ 2012.822578] lttng_lib_ring_buffer: section 24 reloc 0 sym '':
> relocation 42 out of range (0x7f05827c -> 0xc0cd7358)
> Error: Unable to list kernel events: Kernel tracer not available
> Error: Command error
> 
> Do you have any hints how to fix it?

Hrm, there is very little handcrafted assembly within the lttng_lib_ring_buffer.ko
module. Especially not large chunks of handcrafted assembly. I suspect a compiler
issue.

From a freshly booted system, if you issue "modprobe lttng_lib_ring_buffer",
so you get the same error ?

Also, what is your exact compiler version ?

Thanks,

Mathieu


> 
> I found https://bugs.lttng.org/issues/1173 but enabling
> CONFIG_ARM_MODULE_PLTS did not help.
> 
> I use LTTng from Yocto 3.0.2 with custom kernel 4.14.134-rt63-rt:
> 
> # lttng -V
> lttng (LTTng Trace Control) 2.10.7 - KeKriek
> 
> All options recommended from documentation are enabled:
> root@cyclone5:~# zcat /proc/config.gz | grep -i modules
> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
> CONFIG_MODULES_USE_ELF_REL=y
> CONFIG_MODULES=y
> CONFIG_MODULES_TREE_LOOKUP=y
> # Xtables combined modules
> # User Modules And Translation Layers
> root@cyclone5:~# zcat /proc/config.gz | grep -i kallsyms
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> root@cyclone5:~# zcat /proc/config.gz | grep -i high_res_timers
> CONFIG_HIGH_RES_TIMERS=y
> root@cyclone5:~# zcat /proc/config.gz | grep -i tracepoints
> CONFIG_TRACEPOINTS=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> 
> Thank you in advance!
> 
> Best regards,
> Lukasz
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
