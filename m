From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 30/30] Drop support for
 kernels < 3.0 from Makefiles
Date: Thu,  8 Nov 2018 16:45:35 -0500
Message-ID: <20181108214535.12081-30-mjeanson__41093.0949765772$1541713839$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKr5rkgzqKN
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:08 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id C6DA124AF62
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:08 -0500 (EST)
In-Reply-To: <20181108214535.12081-1-mjeanson@efficios.com>
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 Makefile      |  5 +---
 probes/Kbuild | 73 +++++++++++++--------------------------------------
 2 files changed, 19 insertions(+), 59 deletions(-)

diff --git a/Makefile b/Makefile
index ae2b195..c7b8a41 100644
--- a/Makefile
+++ b/Makefile
@@ -66,10 +66,7 @@ ifneq ($(KERNELRELEASE),)
   endif # CONFIG_HAVE_SYSCALL_TRACEPOINTS
 
   ifneq ($(CONFIG_PERF_EVENTS),)
-    lttng-tracer-objs += $(shell \
-      if [ $(VERSION) -ge 3 \
-        -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -eq 6 -a $(SUBLEVEL) -ge 33 \) ] ; then \
-        echo "lttng-context-perf-counters.o" ; fi;)
+    lttng-tracer-objs += lttng-context-perf-counters.o
   endif # CONFIG_PERF_EVENTS
 
   ifneq ($(CONFIG_PREEMPT_RT_FULL),)
diff --git a/probes/Kbuild b/probes/Kbuild
index 0b1e016..b43dd49 100644
--- a/probes/Kbuild
+++ b/probes/Kbuild
@@ -35,14 +35,8 @@ ifneq ($(CONFIG_KVM),)
       ifneq ($(wildcard $(kvm_dep)),)
         CFLAGS_lttng-probe-kvm-x86.o += -I$(srctree)/virt/kvm
         CFLAGS_lttng-probe-kvm-x86-mmu.o += -I$(srctree)/virt/kvm
-        obj-$(CONFIG_LTTNG) +=  $(shell \
-          if [ $(VERSION) -ge 3 \
-            -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -eq 6 -a $(SUBLEVEL) -ge 38 \) ] ; then \
-            echo "lttng-probe-kvm-x86.o" ; fi;)
-        obj-$(CONFIG_LTTNG) +=  $(shell \
-          if [ $(VERSION) -ge 3 \
-            -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -eq 6 -a $(SUBLEVEL) -ge 38 \) ] ; then \
-            echo "lttng-probe-kvm-x86-mmu.o" ; fi;)
+        obj-$(CONFIG_LTTNG) += lttng-probe-kvm-x86.o
+        obj-$(CONFIG_LTTNG) += lttng-probe-kvm-x86-mmu.o
       else
         $(warning File $(kvm_dep) not found. Probe "kvm" x86-specific is disabled. Use full kernel source tree to enable it.)
       endif # $(wildcard $(kvm_dep))
@@ -66,10 +60,7 @@ ifneq ($(CONFIG_X86),)
   endif # $(wildcard $(x86_exceptions_dep))
 endif # CONFIG_X86
 
-obj-$(CONFIG_LTTNG) +=  $(shell \
-  if [ $(VERSION) -ge 3 \
-    -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -eq 6 -a $(SUBLEVEL) -ge 33 \) ] ; then \
-    echo "lttng-probe-signal.o" ; fi;)
+obj-$(CONFIG_LTTNG) += lttng-probe-signal.o
 
 ifneq ($(CONFIG_BLOCK),)
   # need blk_cmd_buf_len
@@ -81,10 +72,7 @@ endif # CONFIG_BLOCK
 ifneq ($(CONFIG_NET),)
   obj-$(CONFIG_LTTNG) += lttng-probe-napi.o
   obj-$(CONFIG_LTTNG) += lttng-probe-skb.o
-  obj-$(CONFIG_LTTNG) +=  $(shell \
-    if [ $(VERSION) -ge 3 \
-      -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -eq 6 -a $(SUBLEVEL) -ge 37 \) ] ; then \
-      echo "lttng-probe-net.o" ; fi;)
+  obj-$(CONFIG_LTTNG) += lttng-probe-net.o
   obj-$(CONFIG_LTTNG) +=  $(shell \
     if [ $(VERSION) -ge 4 \
       -o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 1 \) ] ; then \
@@ -96,10 +84,7 @@ ifneq ($(CONFIG_NET),)
 endif # CONFIG_NET
 
 ifneq ($(CONFIG_SND_SOC),)
-  obj-$(CONFIG_LTTNG) +=  $(shell \
-    if [ $(VERSION) -ge 3 \
-      -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -eq 6 -a $(SUBLEVEL) -ge 38 \) ] ; then \
-      echo "lttng-probe-asoc.o" ; fi;)
+  obj-$(CONFIG_LTTNG) += lttng-probe-asoc.o
 endif # CONFIG_SND_SOC
 
 ifneq ($(CONFIG_EXT3_FS),)
@@ -141,23 +126,14 @@ ifneq ($(CONFIG_JBD),)
 endif # CONFIG_JBD
 
 ifneq ($(CONFIG_REGULATOR),)
-  obj-$(CONFIG_LTTNG) +=  $(shell \
-    if [ $(VERSION) -ge 3 \
-      -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -eq 6 -a $(SUBLEVEL) -ge 38 \) ] ; then \
-      echo "lttng-probe-regulator.o" ; fi;)
+  obj-$(CONFIG_LTTNG) += lttng-probe-regulator.o
 endif # CONFIG_REGULATOR
 
 ifneq ($(CONFIG_SCSI),)
-  obj-$(CONFIG_LTTNG) +=  $(shell \
-    if [ $(VERSION) -ge 3 \
-      -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -eq 6 -a $(SUBLEVEL) -ge 35 \) ] ; then \
-      echo "lttng-probe-scsi.o" ; fi;)
+  obj-$(CONFIG_LTTNG) += lttng-probe-scsi.o
 endif # CONFIG_SCSI
 
-obj-$(CONFIG_LTTNG) += $(shell \
-  if [ $(VERSION) -ge 3 \
-    -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -eq 6 -a $(SUBLEVEL) -ge 36 \) ] ; then \
-    echo "lttng-probe-vmscan.o" ; fi;)
+obj-$(CONFIG_LTTNG) += lttng-probe-vmscan.o
 
 # lock probe does not work, so disabling it for now
 #ifneq ($(CONFIG_LOCKDEP),)
@@ -166,32 +142,22 @@ obj-$(CONFIG_LTTNG) += $(shell \
 
 ifneq ($(CONFIG_BTRFS_FS),)
   btrfs_dep = $(srctree)/fs/btrfs/*.h
-  btrfs = $(shell \
-    if [ $(VERSION) -ge 3 \
-      -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -eq 6 -a $(SUBLEVEL) -ge 39 \) ] ; then \
-      echo "lttng-probe-btrfs.o" ; fi;)
-  ifneq ($(btrfs),)
-    ifeq ($(wildcard $(btrfs_dep)),)
-      $(warning Files $(btrfs_dep) not found. Probe "btrfs" is disabled. Use full kernel source tree to enable it.)
-      btrfs =
-    endif # $(wildcard $(btrfs_dep))
-  endif # $(btrfs)
-  obj-$(CONFIG_LTTNG) += $(btrfs)
+  ifneq ($(wildcard $(btrfs_dep)),)
+    obj-$(CONFIG_LTTNG) += lttng-probe-btrfs.o
+  else
+    $(warning Files $(btrfs_dep) not found. Probe "btrfs" is disabled. Use full kernel source tree to enable it.)
+  endif # $(wildcard $(btrfs_dep))
 endif # CONFIG_BTRFS_FS
 
-obj-$(CONFIG_LTTNG) +=  $(shell \
-  if [ $(VERSION) -ge 3 \
-    -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -eq 6 -a $(SUBLEVEL) -ge 38 \) ] ; then \
-    echo "lttng-probe-compaction.o" ; fi;)
+obj-$(CONFIG_LTTNG) += lttng-probe-compaction.o
 
 ifneq ($(CONFIG_EXT4_FS),)
   ext4_dep = $(srctree)/fs/ext4/*.h
-  ext4 = lttng-probe-ext4.o
-  ifeq ($(wildcard $(ext4_dep)),)
+  ifneq ($(wildcard $(ext4_dep)),)
+    obj-$(CONFIG_LTTNG) += lttng-probe-ext4.o
+  else
     $(warning Files $(ext4_dep) not found. Probe "ext4" is disabled. Use full kernel source tree to enable it.)
-    ext4 =
   endif # $(wildcard $(ext4_dep))
-  obj-$(CONFIG_LTTNG) += $(ext4)
 endif # CONFIG_EXT4_FS
 
 obj-$(CONFIG_LTTNG) +=  $(shell \
@@ -249,10 +215,7 @@ endif # CONFIG_VIDEO_V4L2
 obj-$(CONFIG_LTTNG) += lttng-probe-workqueue.o
 
 ifneq ($(CONFIG_KALLSYMS_ALL),)
-  obj-$(CONFIG_LTTNG) +=  $(shell \
-    if [ $(VERSION) -ge 3 \
-      -o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -eq 6 -a $(SUBLEVEL) -ge 36 \) ] ; then \
-      echo "lttng-probe-writeback.o" ; fi;)
+  obj-$(CONFIG_LTTNG) += lttng-probe-writeback.o
 else
   ifdef CONFIG_LOCALVERSION # Check if dot-config is included.
     $(warning CONFIG_KALLSYMS_ALL is disabled, therefore probe "writeback" is disabled. Rebuild your kernel with this configuration option enabled in order to trace this subsystem.)
-- 
2.17.1
