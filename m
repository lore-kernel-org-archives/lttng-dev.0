From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: logging: log_add_time()
 save/restore errno
Date: Tue,  2 Apr 2019 13:41:17 -0400
Message-ID: <20190402174117.8663-2-mathieu.desnoyers__47203.9965492272$1554227066$gmane$org@efficios.com>
References: <20190402174117.8663-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44Yc2n4rK5z1Kvs
 for <lttng-dev@lists.lttng.org>; Tue,  2 Apr 2019 13:41:37 -0400 (EDT)
In-Reply-To: <20190402174117.8663-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The debugging logging macros (e.g. DBG()) are used as printf in the
lttng-tools source files. The printf() implementation does not alter the
errno value, so the fact that log_add_time() (through clock_gettime())
can alter errno is unexpected. For instance, adding a logging statement
for debugging purposes within a function for which errno is expected to
stay unchanged on return will change the behavior between execution with
-vvv and non-verbose.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/error.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/common/error.c b/src/common/error.c
index c79ce571..a13320f6 100644
--- a/src/common/error.c
+++ b/src/common/error.c
@@ -20,6 +20,7 @@
 #include <inttypes.h>
 #include <stdlib.h>
 #include <string.h>
+#include <errno.h>
 
 #include <lttng/lttng-error.h>
 #include <common/common.h>
@@ -45,6 +46,7 @@ const char *log_add_time(void)
 	struct tm tm, *res;
 	struct timespec tp;
 	time_t now;
+	int errsv = errno;
 
 	ret = lttng_clock_gettime(CLOCK_REALTIME, &tp);
 	if (ret < 0) {
@@ -65,10 +67,12 @@ const char *log_add_time(void)
 		goto error;
 	}
 
+	errno = errsv;
 	return URCU_TLS(error_log_time).str;
 
 error:
 	/* Return an empty string on error so logging is not affected. */
+	errno = errsv;
 	return "";
 }
 
-- 
2.17.1
