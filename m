From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: Use kbuild env instead of a
	custom var KERNELDIR
Date: Mon,  8 Feb 2016 16:33:17 -0500
Message-ID: <1454967197-27200-1-git-send-email-mjeanson__7236.74780824712$1454967277$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aStR6-0007hL-39
 for lttng-dev@lists.lttng.org; Mon, 08 Feb 2016 16:33:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C14EE340499
 for <lttng-dev@lists.lttng.org>; Mon,  8 Feb 2016 21:33:26 +0000 (UTC)
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

We currently use the custom variables KERNELDIR and LTTNG_KERNELDIR
to pass the kernel source tree directory to helper scripts. We should
instead use the built-in Kbuild variable CURDIR which is available in
all sub makefiles and always points to the kernel sources.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 Makefile                 | 9 ++++-----
 Makefile.ABI.workarounds | 4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 64d5885..6a8c5c7 100644
--- a/Makefile
+++ b/Makefile
@@ -9,7 +9,6 @@ ifneq ($(KERNELRELEASE),)
 
   ifneq ($(CONFIG_TRACEPOINTS),)
 
-    KERNELDIR = ${LTTNG_KERNELDIR}
     MAKEFILEDIR = $(shell dirname $(lastword $(MAKEFILE_LIST)))
 
     lttng_check_linux_version = $(shell pwd)/include/linux/version.h
@@ -101,15 +100,15 @@ PWD := $(shell pwd)
 CFLAGS = $(EXTCFLAGS)
 
 default:
-	LTTNG_KERNELDIR=$(KERNELDIR) $(MAKE) -C $(KERNELDIR) M=$(PWD) CONFIG_LTTNG=m modules
+	$(MAKE) -C $(KERNELDIR) M=$(PWD) CONFIG_LTTNG=m modules
 
 modules_install:
-	LTTNG_KERNELDIR=$(KERNELDIR) $(MAKE) -C $(KERNELDIR) M=$(PWD) modules_install
+	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules_install
 
 clean:
-	LTTNG_KERNELDIR=$(KERNELDIR) $(MAKE) -C $(KERNELDIR) M=$(PWD) clean
+	$(MAKE) -C $(KERNELDIR) M=$(PWD) clean
 
 %.i: %.c
-	LTTNG_KERNELDIR=$(KERNELDIR) $(MAKE) -C $(KERNELDIR) M=$(PWD) $@
+	$(MAKE) -C $(KERNELDIR) M=$(PWD) $@
 
 endif # KERNELRELEASE
diff --git a/Makefile.ABI.workarounds b/Makefile.ABI.workarounds
index e8cf520..f766bc9 100644
--- a/Makefile.ABI.workarounds
+++ b/Makefile.ABI.workarounds
@@ -4,13 +4,13 @@
 # the kernel EXTRAVERSION to figure it out. Translate this information
 # into a define visible from the C preprocessor.
 
-DEB_API_VERSION:=$(shell $(MAKEFILEDIR)/abi-debian-version.sh $(KERNELDIR))
+DEB_API_VERSION:=$(shell $(MAKEFILEDIR)/abi-debian-version.sh $(CURDIR))
 
 ifneq ($(DEB_API_VERSION), 0)
   ccflags-y += -DDEBIAN_API_VERSION=$(DEB_API_VERSION)
 endif
 
-RT_PATCH_VERSION:=$(shell $(MAKEFILEDIR)/rt-patch-version.sh $(KERNELDIR))
+RT_PATCH_VERSION:=$(shell $(MAKEFILEDIR)/rt-patch-version.sh $(CURDIR))
 
 ifneq ($(RT_PATCH_VERSION), 0)
   ccflags-y += -DRT_PATCH_VERSION=$(RT_PATCH_VERSION)
-- 
2.7.0
