From: Zifei Tong <soariez@gmail.com>
Subject: [lttng-ust PATCH] Fix tests/benchmark
Date: Fri, 15 Nov 2013 23:04:55 +0800
Message-ID: <1384527895-8458-1-git-send-email-soariez__45404.4495513246$1384527998$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1VhKxg-00026W-QQ
	for lttng-dev@lists.lttng.org; Fri, 15 Nov 2013 10:05:38 -0500
Received: by mail-pa0-f47.google.com with SMTP id ld10so3713236pab.20
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 07:05:27 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Add copyright notice.

Remove extern C guard with respect to #597.

Signed-off-by: Zifei Tong <soariez@gmail.com>
---
 tests/benchmark/tp.c                  | 24 ++++++++++++++++++++++++
 tests/benchmark/ust_tests_benchmark.h | 28 +++++++++++++++++++++-------
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/tests/benchmark/tp.c b/tests/benchmark/tp.c
index a4f5352..4a5aa36 100644
--- a/tests/benchmark/tp.c
+++ b/tests/benchmark/tp.c
@@ -1,2 +1,26 @@
+/*
+ * tp.c
+ *
+ * Copyright (c) 2013 Zifei Tong <soariez@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
 #define TRACEPOINT_CREATE_PROBES
 #include "ust_tests_benchmark.h"
diff --git a/tests/benchmark/ust_tests_benchmark.h b/tests/benchmark/ust_tests_benchmark.h
index 0ee986f..f7d7864 100644
--- a/tests/benchmark/ust_tests_benchmark.h
+++ b/tests/benchmark/ust_tests_benchmark.h
@@ -4,9 +4,27 @@
 #if !defined(_TRACEPOINT_UST_TESTS_BENCHMARK_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
 #define _TRACEPOINT_UST_TESTS_BENCHMARK_H
 
-#ifdef __cplusplus
-extern "C" {
-#endif
+/*
+ * Copyright (C) 2013  Zifei Tong <soariez@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
 
 #include <lttng/tracepoint.h>
 
@@ -24,7 +42,3 @@ TRACEPOINT_EVENT(ust_tests_benchmark, tpbench,
 
 /* This part must be outside ifdef protection */
 #include <lttng/tracepoint-event.h>
-
-#ifdef __cplusplus
-}
-#endif
-- 
1.8.4.2
