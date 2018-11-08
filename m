From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 10/30] Drop support for
 kernels < 3.0 from lib
Date: Thu,  8 Nov 2018 16:45:15 -0500
Message-ID: <20181108214535.12081-10-mjeanson__44629.5980517336$1541713580$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKc1cdSzqC9
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:56 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 3660724AD60
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:56 -0500 (EST)
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
 lib/bug.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/lib/bug.h b/lib/bug.h
index 8ddf2b0..0f3b30b 100644
--- a/lib/bug.h
+++ b/lib/bug.h
@@ -8,14 +8,6 @@
 #ifndef _LTTNG_BUG_H
 #define _LTTNG_BUG_H
 
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
-#define LTTNG_BUILD_BUG_ON(cond) BUILD_BUG_ON(cond)
-#else
-#define LTTNG_BUILD_BUG_ON(cond) MAYBE_BUILD_BUG_ON(cond)
-#endif
-
 /**
  * BUILD_RUNTIME_BUG_ON - check condition at build (if constant) or runtime
  * @condition: the condition which should be false.
@@ -28,7 +20,7 @@
 #define BUILD_RUNTIME_BUG_ON(condition)				\
 	do {							\
 		if (__builtin_constant_p(condition))		\
-			LTTNG_BUILD_BUG_ON(condition);		\
+			BUILD_BUG_ON(condition);		\
 		else						\
 			BUG_ON(condition);			\
 	} while (0)
-- 
2.17.1
