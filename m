From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH 2/4] tile: Add definition of NR_syscalls
Date: Mon, 21 Jan 2013 19:54:56 -0500
Message-ID: <1358816098-13070-2-git-send-email-simon.marchi@polymtl.ca>
References: <1358816098-13070-1-git-send-email-simon.marchi@polymtl.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358816098-13070-1-git-send-email-simon.marchi@polymtl.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: cmetcalf@tilera.com
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

It is required by the syscall tracepoint mechanism.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 arch/tile/include/uapi/asm/unistd.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/tile/include/uapi/asm/unistd.h b/arch/tile/include/uapi/asm/unistd.h
index cd7b6dd..c763c86 100644
--- a/arch/tile/include/uapi/asm/unistd.h
+++ b/arch/tile/include/uapi/asm/unistd.h
@@ -20,6 +20,8 @@
 /* Use the standard ABI for syscalls. */
 #include <asm-generic/unistd.h>
 
+#define NR_syscalls (__NR_syscalls)
+
 /* Additional Tilera-specific syscalls. */
 #define __NR_cacheflush	(__NR_arch_specific_syscall + 1)
 __SYSCALL(__NR_cacheflush, sys_cacheflush)
-- 
1.7.1
