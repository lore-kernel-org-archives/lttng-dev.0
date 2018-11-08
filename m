From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 07/30] Drop uuid.h wrapper
Date: Thu,  8 Nov 2018 16:45:12 -0500
Message-ID: <20181108214535.12081-7-mjeanson__29186.351146973$1541713535$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKZ0nf8zqB3
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:54 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 1A14C24AD03
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:54 -0500 (EST)
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
 lttng-events.c |  2 +-
 lttng-events.h |  2 +-
 wrapper/uuid.h | 30 ------------------------------
 3 files changed, 2 insertions(+), 32 deletions(-)
 delete mode 100644 wrapper/uuid.h

diff --git a/lttng-events.c b/lttng-events.c
index e3a8425..566080a 100644
--- a/lttng-events.c
+++ b/lttng-events.c
@@ -27,8 +27,8 @@
 #include <linux/jhash.h>
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
+#include <linux/uuid.h>
 
-#include <wrapper/uuid.h>
 #include <wrapper/vmalloc.h>	/* for wrapper_vmalloc_sync_all() */
 #include <wrapper/random.h>
 #include <wrapper/tracepoint.h>
diff --git a/lttng-events.h b/lttng-events.h
index f5a7d23..f62e0cb 100644
--- a/lttng-events.h
+++ b/lttng-events.h
@@ -15,7 +15,7 @@
 #include <linux/kprobes.h>
 #include <linux/kref.h>
 #include <lttng-cpuhotplug.h>
-#include <wrapper/uuid.h>
+#include <linux/uuid.h>
 #include <wrapper/uprobes.h>
 #include <lttng-tracer.h>
 #include <lttng-abi.h>
diff --git a/wrapper/uuid.h b/wrapper/uuid.h
deleted file mode 100644
index 465754e..0000000
--- a/wrapper/uuid.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0 or LGPL-2.1)
- *
- * wrapper/uuid.h
- *
- * Copyright (C) 2011-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
- */
-
-#ifndef _LTTNG_WRAPPER_UUID_H
-#define _LTTNG_WRAPPER_UUID_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
-#include <linux/uuid.h>
-#else
-
-#include <linux/random.h>
-
-typedef struct {
-	__u8 b[16];
-} uuid_le;
-
-static inline
-void uuid_le_gen(uuid_le *u)
-{
-	generate_random_uuid(u->b);
-}
-
-#endif
-#endif /* _LTTNG_WRAPPER_UUID_H */
-- 
2.17.1
