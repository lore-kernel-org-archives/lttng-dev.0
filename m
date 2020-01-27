From: "Alex Xu \(Hello71\) via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: [PATCH 2/2] Use _umtx_op for futex on FreeBSD
Date: Mon, 27 Jan 2020 13:25:26 -0500
Message-ID: <20200127182526.22881-2-alex_y_xu@yahoo.ca>
References: <20200127182526.22881-1-alex_y_xu@yahoo.ca>
Reply-To: "Alex Xu \(Hello71\)" <alex_y_xu@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic302-49.consmr.mail.gq1.yahoo.com
 (sonic302-49.consmr.mail.gq1.yahoo.com [98.137.68.175])
 by lists.lttng.org (Postfix) with ESMTPS id 485ysN3stpz1xJq
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jan 2020 13:27:36 -0500 (EST)
In-Reply-To: <20200127182526.22881-1-alex_y_xu@yahoo.ca>
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

---
 include/urcu/futex.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/urcu/futex.h b/include/urcu/futex.h
index c206c6f..33dc3db 100644
--- a/include/urcu/futex.h
+++ b/include/urcu/futex.h
@@ -24,6 +24,7 @@
  */
 
 #include <urcu/config.h>
+#include <errno.h>
 #include <stdint.h>
 #include <time.h>
 
@@ -103,6 +104,28 @@ static inline int futex_async(int32_t *uaddr, int op, int32_t val,
 	return ret;
 }
 
+#elif defined(__FreeBSD__)
+
+#include <sys/umtx.h>
+
+static inline int futex_noasync(int32_t *uaddr, int op, int32_t val,
+		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
+{
+	return futex_async(uaddr, op, val, timeout, uaddr2, val3);
+}
+
+static inline int futex_async(int32_t *uaddr, int op, int32_t val,
+		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
+{
+	switch (op) {
+		case FUTEX_WAIT: op = UMTX_OP_WAIT_UINT; break;
+		case FUTEX_WAKE: op = UMTX_OP_WAKE; break;
+		default: errno = EINVAL; return -1;
+	}
+	return _umtx_op(uaddr, op, val,
+                (void *)sizeof(*timeout), (void *)timeout);
+}
+
 #elif defined(__CYGWIN__)
 
 /*
-- 
2.25.0
