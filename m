From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH 1/4] tile: move declaration of sys_call_table to
	<asm/syscall.h>
Date: Mon, 21 Jan 2013 19:54:55 -0500
Message-ID: <1358816098-13070-1-git-send-email-simon.marchi__21933.1489796334$1358816158$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1TxS8q-0007nj-Hk
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 19:55:08 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: cmetcalf@tilera.com
Cc: lttng-dev@lists.lttng.org, linux-kernel@vger.kernel.org, Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

When activating syscall tracing, kernel/trace/trace_syscalls.c doesn't
find sys_call_table because it includes <asm/syscall.h>, not
<asm/syscalls.h>. Also, looking at the other architectures, that is
probably where it should be.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 arch/tile/include/asm/syscall.h  |    6 ++++++
 arch/tile/include/asm/syscalls.h |    6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/tile/include/asm/syscall.h b/arch/tile/include/asm/syscall.h
index d35e0dc..9644b88 100644
--- a/arch/tile/include/asm/syscall.h
+++ b/arch/tile/include/asm/syscall.h
@@ -22,6 +22,12 @@
 #include <linux/err.h>
 #include <arch/abi.h>
 
+/* The array of function pointers for syscalls. */
+extern void *sys_call_table[];
+#ifdef CONFIG_COMPAT
+extern void *compat_sys_call_table[];
+#endif
+
 /*
  * Only the low 32 bits of orig_r0 are meaningful, so we return int.
  * This importantly ignores the high bits on 64-bit, so comparisons
diff --git a/arch/tile/include/asm/syscalls.h b/arch/tile/include/asm/syscalls.h
index 4c8462a..3b18317 100644
--- a/arch/tile/include/asm/syscalls.h
+++ b/arch/tile/include/asm/syscalls.h
@@ -24,12 +24,6 @@
 #include <linux/types.h>
 #include <linux/compat.h>
 
-/* The array of function pointers for syscalls. */
-extern void *sys_call_table[];
-#ifdef CONFIG_COMPAT
-extern void *compat_sys_call_table[];
-#endif
-
 /*
  * Note that by convention, any syscall which requires the current
  * register set takes an additional "struct pt_regs *" pointer; a
-- 
1.7.1
