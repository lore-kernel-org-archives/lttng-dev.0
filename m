From: Chris J Arges <chris.j.arges@canonical.com>
Subject: [PATCH lttng-modules] Fix: disable kvm probe if lapic.h
	isn't found
Date: Fri, 24 Jul 2015 13:18:59 -0500
Message-ID: <1437761939-1782-1-git-send-email-chris.j.arges__5479.53579011864$1437764918$gmane$org@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chris.j.arges@canonical.com>) id 1ZIhYp-0004ke-Fv
 for lttng-dev@lists.lttng.org; Fri, 24 Jul 2015 14:19:16 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Chris J Arges <chris.j.arges@canonical.com>
List-Id: lttng-dev@lists.lttng.org

In a typical distribution if just linux-headers is installed, lapic.h will
not be installed. We should check if that file exists and not build the module.

Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>
---
 probes/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/probes/Makefile b/probes/Makefile
index 0314a5e..cc4c352 100644
--- a/probes/Makefile
+++ b/probes/Makefile
@@ -25,6 +25,8 @@ obj-m += lttng-probe-statedump.o
 ifneq ($(CONFIG_KVM),)
 obj-m += lttng-probe-kvm.o
 ifneq ($(CONFIG_X86),)
+kvm_dep_lapic = $(srctree)/arch/x86/kvm/lapic.h
+ifneq ($(wildcard $(kvm_dep_lapic)),)
 kvm_dep = $(srctree)/virt/kvm/iodev.h $(srctree)/include/kvm/iodev.h
 ifneq ($(wildcard $(kvm_dep)),)
 CFLAGS_lttng-probe-kvm-x86.o += -I$(srctree)/virt/kvm
@@ -40,6 +42,9 @@ obj-m +=  $(shell \
 else
 $(warning File $(kvm_dep) not found. Probe "kvm" x86-specific is disabled. Use full kernel source tree to enable it.)
 endif
+else
+$(warning File $(kvm_dep_lapic) not found. Probe "kvm" x86-specific is disabled. Use full kernel source tree to enable it.)
+endif
 endif
 endif
 
-- 
2.1.4
