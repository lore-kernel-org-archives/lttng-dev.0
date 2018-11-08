From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 06/30] Drop vzalloc.h
 wrapper
Date: Thu,  8 Nov 2018 16:45:11 -0500
Message-ID: <20181108214535.12081-6-mjeanson__7703.41689135439$1541713518$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKY36Rlzq9j
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:53 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 69ACC24ACEF
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:53 -0500 (EST)
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
 lttng-events.c    |  5 ++---
 wrapper/vzalloc.h | 34 ----------------------------------
 2 files changed, 2 insertions(+), 37 deletions(-)
 delete mode 100644 wrapper/vzalloc.h

diff --git a/lttng-events.c b/lttng-events.c
index f1be602..e3a8425 100644
--- a/lttng-events.c
+++ b/lttng-events.c
@@ -40,7 +40,6 @@
 #include <lttng-abi-old.h>
 #include <lttng-endian.h>
 #include <lttng-string-utils.h>
-#include <wrapper/vzalloc.h>
 #include <wrapper/ringbuffer/backend.h>
 #include <wrapper/ringbuffer/frontend.h>
 
@@ -130,7 +129,7 @@ struct lttng_session *lttng_session_create(void)
 			GFP_KERNEL);
 	if (!metadata_cache)
 		goto err_free_session;
-	metadata_cache->data = lttng_vzalloc(METADATA_CACHE_DEFAULT_SIZE);
+	metadata_cache->data = vzalloc(METADATA_CACHE_DEFAULT_SIZE);
 	if (!metadata_cache->data)
 		goto err_free_cache;
 	metadata_cache->cache_alloc = METADATA_CACHE_DEFAULT_SIZE;
@@ -1692,7 +1691,7 @@ int lttng_metadata_printf(struct lttng_session *session,
 		tmp_cache_alloc_size = max_t(unsigned int,
 				session->metadata_cache->cache_alloc + len,
 				session->metadata_cache->cache_alloc << 1);
-		tmp_cache_realloc = lttng_vzalloc(tmp_cache_alloc_size);
+		tmp_cache_realloc = vzalloc(tmp_cache_alloc_size);
 		if (!tmp_cache_realloc)
 			goto err;
 		if (session->metadata_cache->data) {
diff --git a/wrapper/vzalloc.h b/wrapper/vzalloc.h
deleted file mode 100644
index eedaf8d..0000000
--- a/wrapper/vzalloc.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0 or LGPL-2.1)
- *
- * wrapper/vzalloc.h
- *
- * Copyright (C) 2015 Michael Jeanson <mjeanson@efficios.com>
- */
-
-#ifndef _LTTNG_WRAPPER_VZALLOC_H
-#define _LTTNG_WRAPPER_VZALLOC_H
-
-#include <linux/version.h>
-#include <linux/vmalloc.h>
-
-#if LTTNG_KERNEL_RANGE(2,6,36, 2,6,37)
-static inline
-void *lttng_vzalloc(unsigned long size)
-{
-	void *ret;
-	ret = vmalloc(size);
-	if (!ret)
-		return NULL;
-	memset(ret, 0, size);
-	return ret;
-}
-#else
-static inline
-void *lttng_vzalloc(unsigned long size)
-{
-	return vzalloc(size);
-}
-#endif
-
-
-#endif /* _LTTNG_WRAPPER_VZALLOC_H */
-- 
2.17.1
