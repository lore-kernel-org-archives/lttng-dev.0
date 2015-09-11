From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules v2] Fix: lttng-test build failure
	for kernels < 3.0
Date: Fri, 11 Sep 2015 16:06:25 -0400
Message-ID: <1442001985-24830-1-git-send-email-mjeanson__15880.0990939655$1442002072$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZaUaj-0005ox-N2
 for lttng-dev@lists.lttng.org; Fri, 11 Sep 2015 16:06:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5A8CC340268
 for <lttng-dev@lists.lttng.org>; Fri, 11 Sep 2015 20:06:32 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Fixes an undefined reference to kstrtouint_from_user.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 probes/lttng-test.c |  3 ++-
 wrapper/kstrtox.h   | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 wrapper/kstrtox.h

diff --git a/probes/lttng-test.c b/probes/lttng-test.c
index 2a66f45..bd9f5f8 100644
--- a/probes/lttng-test.c
+++ b/probes/lttng-test.c
@@ -28,6 +28,7 @@
 #include "../lttng-events.h"
 #include "../lttng-tracer.h"
 #include "../wrapper/tracepoint.h"
+#include "../wrapper/kstrtox.h"
 
 #define TP_MODULE_NOAUTOLOAD
 #define LTTNG_PACKAGE_BUILD
@@ -76,7 +77,7 @@ ssize_t lttng_test_filter_event_write(struct file *file, const char __user *user
 	int ret;
 
 	/* Get the number of iterations */
-	ret = kstrtouint_from_user(user_buf, count, 10, &nr_iter);
+	ret = lttng_kstrtouint_from_user(user_buf, count, 10, &nr_iter);
 	if (ret) {
 		written = ret;
 		goto end;
diff --git a/wrapper/kstrtox.h b/wrapper/kstrtox.h
new file mode 100644
index 0000000..0f0666f
--- /dev/null
+++ b/wrapper/kstrtox.h
@@ -0,0 +1,58 @@
+#ifndef _LTTNG_WRAPPER_KSTRTOX_H
+#define _LTTNG_WRAPPER_KSTRTOX_H
+
+/*
+ * wrapper/kstrtox.h
+ *
+ * Copyright (C) 2015 Michael Jeanson <mjeanson@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; only
+ * version 2.1 of the License.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0))
+
+/* Excludes final \0. */
+#define LTTNG_MAX_UINT_CHAR 10
+
+static inline
+int __must_check lttng_kstrtouint_from_user(const char __user *ubuf,
+		size_t count, unsigned int base, unsigned int *res)
+{
+	unsigned int _res;
+	char kbuf[LTTNG_MAX_UINT_CHAR + 1], *endptr;
+
+	memset(kbuf, 0, sizeof(kbuf));
+	if (copy_from_user(kbuf, ubuf, min_t(size_t, LTTNG_MAX_UINT_CHAR, count)))
+		return -EFAULT;
+
+	_res = simple_strtoul(kbuf, &endptr, base);
+	if (!endptr)
+		return -EINVAL;
+
+	*res = _res;
+	return 0;
+}
+#else
+static inline
+int __must_check lttng_kstrtouint_from_user(const char __user *ubuf,
+		size_t count, unsigned int base, unsigned int *res)
+{
+	return kstrtouint_from_user(ubuf, count, base, res);
+}
+#endif
+
+#endif /* _LTTNG_WRAPPER_KSTRTOX_H */
-- 
1.9.1
