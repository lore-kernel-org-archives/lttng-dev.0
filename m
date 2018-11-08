From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 08/30] Drop kstrtox.h
 wrapper
Date: Thu,  8 Nov 2018 16:45:13 -0500
Message-ID: <20181108214535.12081-8-mjeanson__14621.7343085029$1541713551$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKZ53bkzqBx
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:54 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id AC64224AD11
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
 tests/probes/lttng-test.c |  3 +--
 wrapper/kstrtox.h         | 47 ---------------------------------------
 2 files changed, 1 insertion(+), 49 deletions(-)
 delete mode 100644 wrapper/kstrtox.h

diff --git a/tests/probes/lttng-test.c b/tests/probes/lttng-test.c
index 42e48cf..d127818 100644
--- a/tests/probes/lttng-test.c
+++ b/tests/probes/lttng-test.c
@@ -16,7 +16,6 @@
 #include <lttng-events.h>
 #include <lttng-tracer.h>
 #include <wrapper/tracepoint.h>
-#include <wrapper/kstrtox.h>
 
 #define TP_MODULE_NOAUTOLOAD
 #define LTTNG_PACKAGE_BUILD
@@ -69,7 +68,7 @@ ssize_t lttng_test_filter_event_write(struct file *file, const char __user *user
 	int ret;
 
 	/* Get the number of iterations */
-	ret = lttng_kstrtouint_from_user(user_buf, count, 10, &nr_iter);
+	ret = kstrtouint_from_user(user_buf, count, 10, &nr_iter);
 	if (ret) {
 		written = ret;
 		goto end;
diff --git a/wrapper/kstrtox.h b/wrapper/kstrtox.h
deleted file mode 100644
index b0c6cf8..0000000
--- a/wrapper/kstrtox.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0 or LGPL-2.1)
- *
- * wrapper/kstrtox.h
- *
- * Copyright (C) 2015 Michael Jeanson <mjeanson@efficios.com>
- */
-
-#ifndef _LTTNG_WRAPPER_KSTRTOX_H
-#define _LTTNG_WRAPPER_KSTRTOX_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0))
-
-#include <linux/uaccess.h>
-
-/* Excludes final \0. */
-#define LTTNG_MAX_UINT_CHAR 10
-
-static inline
-int __must_check lttng_kstrtouint_from_user(const char __user *ubuf,
-		size_t count, unsigned int base, unsigned int *res)
-{
-	unsigned int _res;
-	char kbuf[LTTNG_MAX_UINT_CHAR + 1], *endptr;
-
-	memset(kbuf, 0, sizeof(kbuf));
-	if (copy_from_user(kbuf, ubuf, min_t(size_t, LTTNG_MAX_UINT_CHAR, count)))
-		return -EFAULT;
-
-	_res = simple_strtoul(kbuf, &endptr, base);
-	if (!endptr)
-		return -EINVAL;
-
-	*res = _res;
-	return 0;
-}
-#else
-static inline
-int __must_check lttng_kstrtouint_from_user(const char __user *ubuf,
-		size_t count, unsigned int base, unsigned int *res)
-{
-	return kstrtouint_from_user(ubuf, count, base, res);
-}
-#endif
-
-#endif /* _LTTNG_WRAPPER_KSTRTOX_H */
-- 
2.17.1
