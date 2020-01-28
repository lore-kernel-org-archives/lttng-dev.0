From: "Alex Xu \(Hello71\) via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: [PATCH v4] Use _umtx_op for futex on FreeBSD
Date: Mon, 27 Jan 2020 20:17:22 -0500
Message-ID: <20200128011722.36025-1-alex_y_xu@yahoo.ca>
References: <20200128011722.36025-1-alex_y_xu.ref@yahoo.ca>
Reply-To: "Alex Xu \(Hello71\)" <alex_y_xu@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic309-22.consmr.mail.gq1.yahoo.com
 (sonic309-22.consmr.mail.gq1.yahoo.com [98.137.65.148])
 by lists.lttng.org (Postfix) with ESMTPS id 4867yJ5X46z1y6x
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jan 2020 20:17:28 -0500 (EST)
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

Tested with "make check", "make regtest" and a knotd slave.
---
 include/urcu/futex.h | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/urcu/futex.h b/include/urcu/futex.h
index c206c6f..0777d95 100644
--- a/include/urcu/futex.h
+++ b/include/urcu/futex.h
@@ -24,6 +24,7 @@
  */
 
 #include <urcu/config.h>
+#include <errno.h>
 #include <stdint.h>
 #include <time.h>
 
@@ -103,6 +104,50 @@ static inline int futex_async(int32_t *uaddr, int op, int32_t val,
 	return ret;
 }
 
+#elif defined(__FreeBSD__)
+
+#include <sys/types.h>
+#include <sys/umtx.h>
+
+static inline int futex_async(int32_t *uaddr, int op, int32_t val,
+		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
+{
+	int umtx_op;
+	void *umtx_uaddr = NULL, *umtx_uaddr2 = NULL;
+	struct _umtx_time umtx_timeout = {
+		._flags = UMTX_ABSTIME,
+		._clockid = CLOCK_MONOTONIC
+	};
+
+	switch (op) {
+		case FUTEX_WAIT:
+			// on FreeBSD, a "u_int" is a 32-bit integer
+			umtx_op = UMTX_OP_WAIT_UINT;
+			if (timeout != NULL) {
+				umtx_timeout._timeout = *timeout;
+				umtx_uaddr = (void *)sizeof(umtx_timeout);
+				umtx_uaddr2 = (void *)&umtx_timeout;
+			}
+			break;
+
+		case FUTEX_WAKE:
+			umtx_op = UMTX_OP_WAKE;
+			break;
+
+		default:
+			errno = EINVAL;
+			return -1;
+	}
+
+	return _umtx_op(uaddr, umtx_op, (uint32_t)val, umtx_uaddr, umtx_uaddr2);
+}
+
+static inline int futex_noasync(int32_t *uaddr, int op, int32_t val,
+		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
+{
+	return futex_async(uaddr, op, val, timeout, uaddr2, val3);
+}
+
 #elif defined(__CYGWIN__)
 
 /*
-- 
2.25.0
