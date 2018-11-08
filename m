From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 12/30] Drop support for
 kernels < 3.0 from lttng-kernel-version.h
Date: Thu,  8 Nov 2018 16:45:17 -0500
Message-ID: <20181108214535.12081-12-mjeanson__7923.21411795474$1541713608$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKd39FzzqDM
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:57 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 6BC1924ADBB
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:57 -0500 (EST)
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
 lttng-kernel-version.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lttng-kernel-version.h b/lttng-kernel-version.h
index 6b545db..26f816c 100644
--- a/lttng-kernel-version.h
+++ b/lttng-kernel-version.h
@@ -11,12 +11,7 @@
 #define _LTTNG_KERNEL_VERSION_H
 
 #include <linux/version.h>
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
 #include <generated/utsrelease.h>
-#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33)) */
-#include <linux/utsrelease.h>
-#endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33)) */
 
 /*
  * This macro checks if the kernel version is between the two specified
-- 
2.17.1
