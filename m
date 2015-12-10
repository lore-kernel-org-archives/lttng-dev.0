From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules] Add support for builtin
	kernel build
Date: Thu, 10 Dec 2015 15:15:31 -0500
Message-ID: <1449778531-19036-1-git-send-email-mjeanson__17430.3590706133$1449778622$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1a77cy-0004A6-74
 for lttng-dev@lists.lttng.org; Thu, 10 Dec 2015 15:15:52 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5B2A934055F
 for <lttng-dev@lists.lttng.org>; Thu, 10 Dec 2015 20:15:44 +0000 (UTC)
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

To build the LTTng modules as builtins in a kernel image, simply run
the "built-in.sh" with the path to you kernel source directory as an
argument. Then configure the kernel build and add the "CONFIG_LTTNG"
option trough menuconfig or your preferred method. Build as usual and
voila!

This is an early implementation with a single configuration that enable
or disable everything, if it's useful we could add fine grained config
options for each modules or group of modules.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 Kconfig                                            |  8 ++
 Makefile                                           | 26 +++---
 built-in.sh                                        | 24 ++++++
 .../syscalls/lttng-syscalls-extractor/Makefile     |  2 +-
 lib/Makefile                                       |  2 +-
 probes/Makefile                                    | 94 +++++++++++-----------
 6 files changed, 94 insertions(+), 62 deletions(-)
 create mode 100644 Kconfig
 create mode 100755 built-in.sh

diff --git a/Kconfig b/Kconfig
new file mode 100644
index 0000000..06e4202
--- /dev/null
+++ b/Kconfig
@@ -0,0 +1,8 @@
+config LTTNG
+	tristate "LTTng support"
+        help
+	  See https://lttng.org/
+
+	  To compile this library as a module, choose M here.
+
+	  If unsure, say N.
diff --git a/Makefile b/Makefile
index 29204bc..dd45644 100644
--- a/Makefile
+++ b/Makefile
@@ -25,15 +25,15 @@ endif
 
 include $(MAKEFILEDIR)/Makefile.ABI.workarounds
 
-obj-m += lttng-ring-buffer-client-discard.o
-obj-m += lttng-ring-buffer-client-overwrite.o
-obj-m += lttng-ring-buffer-metadata-client.o
-obj-m += lttng-ring-buffer-client-mmap-discard.o
-obj-m += lttng-ring-buffer-client-mmap-overwrite.o
-obj-m += lttng-ring-buffer-metadata-mmap-client.o
-obj-m += lttng-clock.o
-
-obj-m += lttng-tracer.o
+obj-$(CONFIG_LTTNG) += lttng-ring-buffer-client-discard.o
+obj-$(CONFIG_LTTNG) += lttng-ring-buffer-client-overwrite.o
+obj-$(CONFIG_LTTNG)+= lttng-ring-buffer-metadata-client.o
+obj-$(CONFIG_LTTNG) += lttng-ring-buffer-client-mmap-discard.o
+obj-$(CONFIG_LTTNG) += lttng-ring-buffer-client-mmap-overwrite.o
+obj-$(CONFIG_LTTNG) += lttng-ring-buffer-metadata-mmap-client.o
+obj-$(CONFIG_LTTNG) += lttng-clock.o
+
+obj-$(CONFIG_LTTNG) += lttng-tracer.o
 lttng-tracer-objs :=  lttng-events.o lttng-abi.o \
 			lttng-probes.o lttng-context.o \
 			lttng-context-pid.o lttng-context-procname.o \
@@ -52,7 +52,7 @@ lttng-tracer-objs :=  lttng-events.o lttng-abi.o \
 			lttng-filter-validator.o \
 			probes/lttng-probe-user.o
 
-obj-m += lttng-statedump.o
+obj-$(CONFIG_LTTNG) += lttng-statedump.o
 lttng-statedump-objs := lttng-statedump-impl.o wrapper/irqdesc.o \
 			wrapper/fdtable.o
 
@@ -81,8 +81,8 @@ lttng-tracer-objs += $(shell \
 		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 15 -a $(SUBLEVEL) -ge 0 \) ] ; then \
 		echo "lttng-tracepoint.o" ; fi;)
 
-obj-m += probes/
-obj-m += lib/
+obj-$(CONFIG_LTTNG) += probes/
+obj-$(CONFIG_LTTNG) += lib/
 
 endif # CONFIG_TRACEPOINTS
 
@@ -92,7 +92,7 @@ else # KERNELRELEASE
 	CFLAGS = $(EXTCFLAGS)
 
 default:
-	LTTNG_KERNELDIR=$(KERNELDIR) $(MAKE) -C $(KERNELDIR) M=$(PWD) modules
+	LTTNG_KERNELDIR=$(KERNELDIR) $(MAKE) -C $(KERNELDIR) M=$(PWD) CONFIG_LTTNG=m modules
 
 modules_install:
 	LTTNG_KERNELDIR=$(KERNELDIR) $(MAKE) -C $(KERNELDIR) M=$(PWD) modules_install
diff --git a/built-in.sh b/built-in.sh
new file mode 100755
index 0000000..782985f
--- /dev/null
+++ b/built-in.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+
+set -e
+
+usage() {
+	echo "usage: $0 <kernel source tree>" >&2
+	exit 1
+}
+
+[ "$#" -eq 1 ] || usage
+KERNEL_DIR="$(readlink --canonicalize-existing "$1")"
+
+# Symlink the lttng-modules directory in the kernel source
+ln -sf "$(pwd)" "${KERNEL_DIR}/lttng"
+
+# Graft ourself to the kernel build system
+echo 'source "lttng/Kconfig"' >> "${KERNEL_DIR}/Kconfig"
+sed -i 's#+= kernel/#+= kernel/ lttng/#' "${KERNEL_DIR}/Makefile"
+
+echo >&2
+echo "    $0: done." >&2
+echo "    $0: now you can build the kernel with LTTng support." >&2
+echo "    $0: make sure you enable it (CONFIG_LTTNG) before building." >&2
+echo >&2
diff --git a/instrumentation/syscalls/lttng-syscalls-extractor/Makefile b/instrumentation/syscalls/lttng-syscalls-extractor/Makefile
index 4beb88c..6f9f89c 100644
--- a/instrumentation/syscalls/lttng-syscalls-extractor/Makefile
+++ b/instrumentation/syscalls/lttng-syscalls-extractor/Makefile
@@ -1 +1 @@
-obj-m += lttng-syscalls-extractor.o
+obj-$(CONFIG_LTTNG) += lttng-syscalls-extractor.o
diff --git a/lib/Makefile b/lib/Makefile
index 6074406..1ea65ce 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -3,7 +3,7 @@ MAKEFILEDIR = $(shell dirname $(lastword $(MAKEFILE_LIST)))
 
 include $(MAKEFILEDIR)/../Makefile.ABI.workarounds
 
-obj-m += lttng-lib-ring-buffer.o
+obj-$(CONFIG_LTTNG) += lttng-lib-ring-buffer.o
 
 lttng-lib-ring-buffer-objs := \
 	ringbuffer/ring_buffer_backend.o \
diff --git a/probes/Makefile b/probes/Makefile
index 8a068c1..549a887 100644
--- a/probes/Makefile
+++ b/probes/Makefile
@@ -11,19 +11,19 @@ MAKEFILEDIR = $(shell dirname $(lastword $(MAKEFILE_LIST)))
 include $(MAKEFILEDIR)/../Makefile.ABI.workarounds
 
 ccflags-y += -I$(PWD)/probes
-obj-m += lttng-types.o
+obj-$(CONFIG_LTTNG) += lttng-types.o
 
-obj-m += lttng-probe-sched.o
-obj-m += lttng-probe-irq.o
-obj-m += lttng-probe-timer.o
-obj-m += lttng-probe-kmem.o
-obj-m += lttng-probe-module.o
-obj-m += lttng-probe-power.o
+obj-$(CONFIG_LTTNG) += lttng-probe-sched.o
+obj-$(CONFIG_LTTNG) += lttng-probe-irq.o
+obj-$(CONFIG_LTTNG) += lttng-probe-timer.o
+obj-$(CONFIG_LTTNG) += lttng-probe-kmem.o
+obj-$(CONFIG_LTTNG) += lttng-probe-module.o
+obj-$(CONFIG_LTTNG) += lttng-probe-power.o
 
-obj-m += lttng-probe-statedump.o
+obj-$(CONFIG_LTTNG) += lttng-probe-statedump.o
 
 ifneq ($(CONFIG_KVM),)
-obj-m += lttng-probe-kvm.o
+obj-$(CONFIG_LTTNG) += lttng-probe-kvm.o
 ifneq ($(CONFIG_X86),)
 kvm_dep_lapic = $(srctree)/arch/x86/kvm/lapic.h
 ifneq ($(wildcard $(kvm_dep_lapic)),)
@@ -31,11 +31,11 @@ kvm_dep = $(srctree)/virt/kvm/iodev.h $(srctree)/include/kvm/iodev.h
 ifneq ($(wildcard $(kvm_dep)),)
 CFLAGS_lttng-probe-kvm-x86.o += -I$(srctree)/virt/kvm
 CFLAGS_lttng-probe-kvm-x86-mmu.o += -I$(srctree)/virt/kvm
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 3 \
 		-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 38 \) ] ; then \
 		echo "lttng-probe-kvm-x86.o" ; fi;)
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 3 \
 		-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 38 \) ] ; then \
 		echo "lttng-probe-kvm-x86-mmu.o" ; fi;)
@@ -52,46 +52,46 @@ ifneq ($(CONFIG_X86),)
 
 x86_irq_vectors_dep = $(srctree)/arch/x86/include/asm/trace/irq_vectors.h
 ifneq ($(wildcard $(x86_irq_vectors_dep)),)
-obj-m += lttng-probe-x86-irq-vectors.o
+obj-$(CONFIG_LTTNG) += lttng-probe-x86-irq-vectors.o
 endif
 
 x86_exceptions_dep = $(srctree)/arch/x86/include/asm/trace/exceptions.h
 ifneq ($(wildcard $(x86_exceptions_dep)),)
-obj-m += lttng-probe-x86-exceptions.o
+obj-$(CONFIG_LTTNG) += lttng-probe-x86-exceptions.o
 endif
 
 endif
 
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 3 \
 		-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 33 \) ] ; then \
 		echo "lttng-probe-signal.o" ; fi;)
 
 ifneq ($(CONFIG_BLOCK),)
 ifneq ($(CONFIG_EVENT_TRACING),)	# need blk_cmd_buf_len
-obj-m += lttng-probe-block.o
+obj-$(CONFIG_LTTNG) += lttng-probe-block.o
 endif
 endif
 
 ifneq ($(CONFIG_NET),)
-obj-m += lttng-probe-napi.o
-obj-m += lttng-probe-skb.o
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) += lttng-probe-napi.o
+obj-$(CONFIG_LTTNG) += lttng-probe-skb.o
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 3 \
 		-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 37 \) ] ; then \
 		echo "lttng-probe-net.o" ; fi;)
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 4 \
 		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 1 \) ] ; then \
 		echo "lttng-probe-sock.o" ; fi;)
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 4 \
 		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 1 \) ] ; then \
 		echo "lttng-probe-udp.o" ; fi;)
 endif
 
 ifneq ($(CONFIG_SND_SOC),)
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 3 \
 		-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 38 \) ] ; then \
 		echo "lttng-probe-asoc.o" ; fi;)
@@ -113,35 +113,35 @@ ifeq ($(ext3),warn)
 $(warning Files $(ext3_dep) not found. Probe "ext3" is disabled. Use full kernel source tree to enable it.)
 ext3 =
 endif
-obj-m += $(ext3)
+obj-$(CONFIG_LTTNG) += $(ext3)
 endif
 
 ifneq ($(CONFIG_GPIOLIB),)
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 3 ] ; then \
 		echo "lttng-probe-gpio.o" ; fi;)
 endif
 
 ifneq ($(CONFIG_JBD2),)
-obj-m += lttng-probe-jbd2.o
+obj-$(CONFIG_LTTNG) += lttng-probe-jbd2.o
 endif
 
 ifneq ($(CONFIG_JBD),)
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 4 \
 		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 1 \) ] ; then \
 		echo "lttng-probe-jbd.o" ; fi;)
 endif
 
 ifneq ($(CONFIG_REGULATOR),)
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 3 \
 		-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 38 \) ] ; then \
 		echo "lttng-probe-regulator.o" ; fi;)
 endif
 
 ifneq ($(CONFIG_SCSI),)
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 3 \
 		-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 35 \) ] ; then \
 		echo "lttng-probe-scsi.o" ; fi;)
@@ -152,16 +152,16 @@ vmscan = $(shell \
 		-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 36 \) ] ; then \
 		echo "lttng-probe-vmscan.o" ; fi;)
 ifneq ($(CONFIG_SWAP),)
-	obj-m += $(vmscan)
+	obj-$(CONFIG_LTTNG) += $(vmscan)
 else
 ifneq ($(CONFIG_CGROUP_MEM_RES_CTLR),)
-	obj-m += $(vmscan)
+	obj-$(CONFIG_LTTNG) += $(vmscan)
 endif
 endif
 
 # lock probe does not work, so disabling it for now
 #ifneq ($(CONFIG_LOCKDEP),)
-#obj-m += lttng-probe-lock.o
+#obj-$(CONFIG_LTTNG) += lttng-probe-lock.o
 #endif
 
 ifneq ($(CONFIG_BTRFS_FS),)
@@ -176,10 +176,10 @@ $(warning Files $(btrfs_dep) not found. Probe "btrfs" is disabled. Use full kern
 btrfs =
 endif
 endif
-obj-m += $(btrfs)
+obj-$(CONFIG_LTTNG) += $(btrfs)
 endif
 
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 3 \
 		-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 38 \) ] ; then \
 		echo "lttng-probe-compaction.o" ; fi;)
@@ -191,10 +191,10 @@ ifeq ($(wildcard $(ext4_dep)),)
 $(warning Files $(ext4_dep) not found. Probe "ext4" is disabled. Use full kernel source tree to enable it.)
 ext4 =
 endif
-obj-m += $(ext4)
+obj-$(CONFIG_LTTNG) += $(ext4)
 endif
 
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 4 \
 		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 4 \) ] ; then \
 		echo "lttng-probe-printk.o" ; fi;)
@@ -202,7 +202,7 @@ ifneq ($(CONFIG_FRAME_WARN),0)
 CFLAGS_lttng-probe-printk.o += -Wframe-larger-than=2200
 endif
 
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 4 \
 		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 6 \) \
 		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -eq 5 -a $(SUBLEVEL) -ge 2 \) \
@@ -210,7 +210,7 @@ obj-m +=  $(shell \
 		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -eq 0 -a $(SUBLEVEL) -ge 41 \) ] ; then \
 		echo "lttng-probe-random.o" ; fi;)
 
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 4 \
 		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 2 \) ] ; then \
 		echo "lttng-probe-rcu.o" ; fi;)
@@ -218,37 +218,37 @@ obj-m +=  $(shell \
 ifneq ($(CONFIG_REGMAP),)
 regmap_dep_4_1 = $(srctree)/drivers/base/regmap/trace.h
 ifneq ($(wildcard $(regmap_dep_4_1)),)
-obj-m += lttng-probe-regmap.o
+obj-$(CONFIG_LTTNG) += lttng-probe-regmap.o
 else
 $(warning File $(regmap_dep_4_1) not found. Probe "regmap" is disabled. Need Linux 4.1+ kernel source tree to enable it.)
 endif
 endif
 
 ifneq ($(CONFIG_PM_RUNTIME),)
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 4 \
 		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 2 \) ] ; then \
 		echo "lttng-probe-rpm.o" ; fi;)
 endif
 
 ifneq ($(CONFIG_SUNRPC),)
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 4 \
 		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 4 \) ] ; then \
 		echo "lttng-probe-sunrpc.o" ; fi;)
 endif
 
 ifneq ($(CONFIG_VIDEO_V4L2),)
-obj-m += $(shell \
+obj-$(CONFIG_LTTNG) += $(shell \
 	if [ $(VERSION) -ge 4 \
 		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 14 \) ] ; then \
 		echo "lttng-probe-v4l2.o" ; fi;)
 endif
 
-obj-m += lttng-probe-workqueue.o
+obj-$(CONFIG_LTTNG) += lttng-probe-workqueue.o
 
 ifneq ($(CONFIG_KALLSYMS_ALL),)
-obj-m +=  $(shell \
+obj-$(CONFIG_LTTNG) +=  $(shell \
 	if [ $(VERSION) -ge 3 \
 		-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 36 \) ] ; then \
 		echo "lttng-probe-writeback.o" ; fi;)
@@ -258,21 +258,21 @@ endif
 
 
 ifneq ($(CONFIG_KPROBES),)
-obj-m += lttng-kprobes.o
+obj-$(CONFIG_LTTNG) += lttng-kprobes.o
 endif
 
 
 ifneq ($(CONFIG_KRETPROBES),)
-obj-m += lttng-kretprobes.o
+obj-$(CONFIG_LTTNG) += lttng-kretprobes.o
 endif
 
 ifneq ($(CONFIG_DYNAMIC_FTRACE),)
-obj-m += lttng-ftrace.o
+obj-$(CONFIG_LTTNG) += lttng-ftrace.o
 endif
 
 endif
 
-obj-m += lttng-test.o
+obj-$(CONFIG_LTTNG) += lttng-test.o
 
 else
 	KERNELDIR ?= /lib/modules/$(shell uname -r)/build
@@ -280,7 +280,7 @@ else
 	CFLAGS = $(EXTCFLAGS)
 
 default:
-	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
+	$(MAKE) -C $(KERNELDIR) M=$(PWD) CONFIG_LTTNG=m modules
 
 modules_install:
 	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules_install
-- 
1.9.1
