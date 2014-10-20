From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: syscall list ioctl number
	conflict
Date: Mon, 20 Oct 2014 18:50:32 -0400
Message-ID: <1413845433-24348-1-git-send-email-mathieu.desnoyers__42598.2494991787$1413845506$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XgLn7-00073r-6r
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 18:51:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D0BA4340349
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 22:50:54 +0000 (UTC)
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/kernel-ctl/kernel-ioctl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/kernel-ctl/kernel-ioctl.h b/src/common/kernel-ctl/kernel-ioctl.h
index c88f970..475a066 100644
--- a/src/common/kernel-ctl/kernel-ioctl.h
+++ b/src/common/kernel-ctl/kernel-ioctl.h
@@ -103,7 +103,7 @@
 #define LTTNG_KERNEL_WAIT_QUIESCENT		_IO(0xF6, 0x48)
 #define LTTNG_KERNEL_CALIBRATE			\
 	_IOWR(0xF6, 0x49, struct lttng_kernel_calibrate)
-#define LTTNG_KERNEL_SYSCALL_LIST		_IO(0xF6, 0x49)
+#define LTTNG_KERNEL_SYSCALL_LIST		_IO(0xF6, 0x4A)
 
 /* Session FD ioctl */
 #define LTTNG_KERNEL_METADATA			\
-- 
2.1.0
