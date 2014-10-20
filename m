From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/2] Use lttng-modules ABI version
	ioctl
Date: Mon, 20 Oct 2014 18:50:33 -0400
Message-ID: <1413845433-24348-2-git-send-email-mathieu.desnoyers__45538.6789785281$1413845530$gmane$org@efficios.com>
References: <1413845433-24348-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XgLnF-00074D-LC
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 18:51:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4908D340346
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 22:51:09 +0000 (UTC)
In-Reply-To: <1413845433-24348-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Check compatibility between lttng-modules and tools using a version
numbering specifically for the ABI, rather than relying on the major
version of lttng-modules per se. This takes into account that we
sometimes depend on lock-step updates of the toolchain, including
tools and modules.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/kernel.c      | 25 +++++++++++++++++++------
 src/common/kernel-ctl/kernel-ctl.c   |  6 ++++++
 src/common/kernel-ctl/kernel-ctl.h   |  1 +
 src/common/kernel-ctl/kernel-ioctl.h |  5 +++++
 src/common/lttng-kernel.h            |  5 +++++
 5 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/src/bin/lttng-sessiond/kernel.c b/src/bin/lttng-sessiond/kernel.c
index 2aeef26..00bfbbc 100644
--- a/src/bin/lttng-sessiond/kernel.c
+++ b/src/bin/lttng-sessiond/kernel.c
@@ -26,6 +26,7 @@
 
 #include <common/common.h>
 #include <common/kernel-ctl/kernel-ctl.h>
+#include <common/kernel-ctl/kernel-ioctl.h>
 #include <common/sessiond-comm/sessiond-comm.h>
 
 #include "consumer.h"
@@ -698,6 +699,7 @@ int kernel_validate_version(int tracer_fd)
 {
 	int ret;
 	struct lttng_kernel_tracer_version version;
+	struct lttng_kernel_tracer_abi_version abi_version;
 
 	ret = kernctl_tracer_version(tracer_fd, &version);
 	if (ret < 0) {
@@ -706,17 +708,28 @@ int kernel_validate_version(int tracer_fd)
 	}
 
 	/* Validate version */
-	if (version.major != KERN_MODULES_PRE_MAJOR
-		&& version.major != KERN_MODULES_MAJOR) {
+	if (version.major != VERSION_MAJOR) {
+		ERR("Kernel tracer major version (%d) is not compatible with lttng-tools major version (%d)",
+			version.major, VERSION_MAJOR);
 		goto error_version;
 	}
-
-	DBG2("Kernel tracer version validated (major version %d)", version.major);
+	ret = kernctl_tracer_abi_version(tracer_fd, &abi_version);
+	if (ret < 0) {
+		ERR("Failed at getting lttng-modules ABI version");
+		goto error;
+	}
+	if (abi_version.major != LTTNG_MODULES_ABI_MAJOR_VERSION) {
+		ERR("Kernel tracer ABI version (%d.%d) is not compatible with expected ABI major version (%d.*)",
+			abi_version.major, abi_version.minor,
+			LTTNG_MODULES_ABI_MAJOR_VERSION);
+		goto error;
+	}
+	DBG2("Kernel tracer version validated (%d.%d, ABI %d.%d)",
+			version.major, version.minor,
+			abi_version.major, abi_version.minor);
 	return 0;
 
 error_version:
-	ERR("Kernel major version %d is not compatible (supporting <= %d)",
-			version.major, KERN_MODULES_MAJOR)
 	ret = -1;
 
 error:
diff --git a/src/common/kernel-ctl/kernel-ctl.c b/src/common/kernel-ctl/kernel-ctl.c
index a387b93..f3ef93d 100644
--- a/src/common/kernel-ctl/kernel-ctl.c
+++ b/src/common/kernel-ctl/kernel-ctl.c
@@ -346,6 +346,12 @@ end:
 	return ret;
 }
 
+int kernctl_tracer_abi_version(int fd,
+		struct lttng_kernel_tracer_abi_version *v)
+{
+	return ioctl(fd, LTTNG_KERNEL_TRACER_ABI_VERSION, v);
+}
+
 int kernctl_wait_quiescent(int fd)
 {
 	return compat_ioctl_no_arg(fd, LTTNG_KERNEL_OLD_WAIT_QUIESCENT,
diff --git a/src/common/kernel-ctl/kernel-ctl.h b/src/common/kernel-ctl/kernel-ctl.h
index 4ef1b87..d9e6c54 100644
--- a/src/common/kernel-ctl/kernel-ctl.h
+++ b/src/common/kernel-ctl/kernel-ctl.h
@@ -38,6 +38,7 @@ int kernctl_stop_session(int fd);
 int kernctl_tracepoint_list(int fd);
 int kernctl_syscall_list(int fd);
 int kernctl_tracer_version(int fd, struct lttng_kernel_tracer_version *v);
+int kernctl_tracer_abi_version(int fd, struct lttng_kernel_tracer_abi_version *v);
 int kernctl_wait_quiescent(int fd);
 int kernctl_calibrate(int fd, struct lttng_kernel_calibrate *calibrate);
 
diff --git a/src/common/kernel-ctl/kernel-ioctl.h b/src/common/kernel-ctl/kernel-ioctl.h
index 475a066..927de6f 100644
--- a/src/common/kernel-ctl/kernel-ioctl.h
+++ b/src/common/kernel-ctl/kernel-ioctl.h
@@ -19,6 +19,9 @@
 #ifndef _LTT_KERNEL_IOCTL_H
 #define _LTT_KERNEL_IOCTL_H
 
+#define LTTNG_MODULES_ABI_MAJOR_VERSION		1
+#define LTTNG_MODULES_ABI_MINOR_VERSION		0
+
 /* Get a snapshot of the current ring buffer producer and consumer positions */
 #define RING_BUFFER_SNAPSHOT                _IO(0xF6, 0x00)
 /* Get the consumer position (iteration start) */
@@ -104,6 +107,8 @@
 #define LTTNG_KERNEL_CALIBRATE			\
 	_IOWR(0xF6, 0x49, struct lttng_kernel_calibrate)
 #define LTTNG_KERNEL_SYSCALL_LIST		_IO(0xF6, 0x4A)
+#define LTTNG_KERNEL_TRACER_ABI_VERSION		\
+	_IOR(0xF6, 0x4B, struct lttng_kernel_tracer_abi_version)
 
 /* Session FD ioctl */
 #define LTTNG_KERNEL_METADATA			\
diff --git a/src/common/lttng-kernel.h b/src/common/lttng-kernel.h
index 4df3240..abd22c9 100644
--- a/src/common/lttng-kernel.h
+++ b/src/common/lttng-kernel.h
@@ -124,6 +124,11 @@ struct lttng_kernel_tracer_version {
 	uint32_t patchlevel;
 } LTTNG_PACKED;
 
+struct lttng_kernel_tracer_abi_version {
+	uint32_t major;
+	uint32_t minor;
+} LTTNG_PACKED;
+
 enum lttng_kernel_calibrate_type {
 	LTTNG_KERNEL_CALIBRATE_KRETPROBE,
 };
-- 
2.1.0
