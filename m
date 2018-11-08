From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 03/30] Drop support for
 kernels < 3.0 from atomic.h wrapper
Date: Thu,  8 Nov 2018 16:45:08 -0500
Message-ID: <20181108214535.12081-3-mjeanson__44632.8023834669$1541713467$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKW4NBWzq8m
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:51 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 1E1DC24ACC0
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:51 -0500 (EST)
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
 wrapper/atomic.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/wrapper/atomic.h b/wrapper/atomic.h
index 51920c4..5ead899 100644
--- a/wrapper/atomic.h
+++ b/wrapper/atomic.h
@@ -11,11 +11,7 @@
 #define _LTTNG_WRAPPER_ATOMIC_H
 
 #include <linux/version.h>
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 #include <linux/atomic.h>
-#else
-#include <asm/atomic.h>
-#endif
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0))
 static inline void lttng_smp_mb__before_atomic(void)
-- 
2.17.1
