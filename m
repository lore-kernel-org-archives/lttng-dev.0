From: Lukasz Domowy via lttng-dev <lttng-dev@lists.lttng.org>
Subject: lttng_lib_ring_buffer: section 24 reloc 0 sym '':
 relocation 42 out of range
Date: Thu, 28 May 2020 13:51:12 +0200
Message-ID: <CAGK+5gW_7Lo3O4oYW8jVJqDiUby6xoRyL3-JJQDQ8VYLG7WPAg@mail.gmail.com>
Reply-To: Lukasz Domowy <lukasz.odw39@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by lists.lttng.org (Postfix) with ESMTPS id 49XmHx1zn2z1FrL
 for <lttng-dev@lists.lttng.org>; Thu, 28 May 2020 07:51:24 -0400 (EDT)
Received: by mail-ej1-x62a.google.com with SMTP id gl26so3392853ejb.11
 for <lttng-dev@lists.lttng.org>; Thu, 28 May 2020 04:51:24 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hello,

First - of all: thank you very much for efforts to develop and
maintain LTTng. It's very useful tool!
I used it so far on PowerPC targets and now I try to run it on ARM:
Cyclone5 ARMv7 CPU.

When trying to run LTTng I get:

# lttng list --kernel
[ 2012.822578] lttng_lib_ring_buffer: section 24 reloc 0 sym '':
relocation 42 out of range (0x7f05827c -> 0xc0cd7358)
Error: Unable to list kernel events: Kernel tracer not available
Error: Command error

Do you have any hints how to fix it?

I found https://bugs.lttng.org/issues/1173 but enabling
CONFIG_ARM_MODULE_PLTS did not help.

I use LTTng from Yocto 3.0.2 with custom kernel 4.14.134-rt63-rt:

# lttng -V
lttng (LTTng Trace Control) 2.10.7 - KeKriek

All options recommended from documentation are enabled:
root@cyclone5:~# zcat /proc/config.gz | grep -i modules
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_MODULES=y
CONFIG_MODULES_TREE_LOOKUP=y
# Xtables combined modules
# User Modules And Translation Layers
root@cyclone5:~# zcat /proc/config.gz | grep -i kallsyms
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
root@cyclone5:~# zcat /proc/config.gz | grep -i high_res_timers
CONFIG_HIGH_RES_TIMERS=y
root@cyclone5:~# zcat /proc/config.gz | grep -i tracepoints
CONFIG_TRACEPOINTS=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y

Thank you in advance!

Best regards,
Lukasz
