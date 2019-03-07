From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-modules 2/2] Move timekeeping blacklisting
 to a header file
Date: Thu,  7 Mar 2019 14:45:53 -0500
Message-ID: <20190307194553.13013-2-jonathan.rajotte-julien__20363.4672727034$1551988018$gmane$org@efficios.com>
References: <20190307194553.13013-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44Fh2R4NkSz1JZS
 for <lttng-dev@lists.lttng.org>; Thu,  7 Mar 2019 14:46:07 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 95945B84BC
 for <lttng-dev@lists.lttng.org>; Thu,  7 Mar 2019 14:46:07 -0500 (EST)
In-Reply-To: <20190307194553.13013-1-jonathan.rajotte-julien@efficios.com>
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 blacklist/timekeeping.h | 20 ++++++++++++++++++++
 wrapper/trace-clock.h   |  6 +-----
 2 files changed, 21 insertions(+), 5 deletions(-)
 create mode 100644 blacklist/timekeeping.h

diff --git a/blacklist/timekeeping.h b/blacklist/timekeeping.h
new file mode 100644
index 0000000..f9405ea
--- /dev/null
+++ b/blacklist/timekeeping.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR LGPL-2.1)
+ *
+ * blacklist/timekeeping.h
+ *
+ * Blacklist of kernel for buggy timekeeping implementation.
+ *
+ * Copyright (C) 2019 Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
+ */
+
+#ifndef _LTTNG_BLACKLIST_TIMEKEEPING_H
+#define _LTTNG_BLACKLIST_TIMEKEEPING_H
+
+#include <lttng-kernel-version.h>
+
+#if ((LTTNG_KERNEL_RANGE(3,10,0, 3,10,14) && !LTTNG_RHEL_KERNEL_RANGE(3,10,0,123,0,0, 3,10,14,0,0,0)) \
+	|| LTTNG_KERNEL_RANGE(3,11,0, 3,11,3))
+# error "Linux kernels 3.10 and 3.11 introduce a deadlock in the timekeeping subsystem. Fixed by commit 7bd36014460f793c19e7d6c94dab67b0afcfcb7f \"timekeeping: Fix HRTICK related deadlock from ntp lock changes\" in Linux."
+#endif
+
+#endif /* _LTTNG_BLACKLIST_TIMEKEEPING_H */
diff --git a/wrapper/trace-clock.h b/wrapper/trace-clock.h
index a98f034..9f4e366 100644
--- a/wrapper/trace-clock.h
+++ b/wrapper/trace-clock.h
@@ -27,11 +27,7 @@
 #include <wrapper/compiler.h>
 #include <wrapper/percpu-defs.h>
 #include <wrapper/random.h>
-
-#if ((LTTNG_KERNEL_RANGE(3,10,0, 3,10,14) && !LTTNG_RHEL_KERNEL_RANGE(3,10,0,123,0,0, 3,10,14,0,0,0)) \
-	|| LTTNG_KERNEL_RANGE(3,11,0, 3,11,3))
-#error "Linux kernels 3.10 and 3.11 introduce a deadlock in the timekeeping subsystem. Fixed by commit 7bd36014460f793c19e7d6c94dab67b0afcfcb7f \"timekeeping: Fix HRTICK related deadlock from ntp lock changes\" in Linux."
-#endif
+#include <blacklist/timekeeping.h>
 
 extern struct lttng_trace_clock *lttng_trace_clock;
 
-- 
2.17.1
