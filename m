From: "Alex Xu \(Hello71\) via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: [PATCH v3] Use _umtx_op for futex on FreeBSD
Date: Mon, 27 Jan 2020 15:21:55 -0500
Message-ID: <20200127202155.30305-1-alex_y_xu@yahoo.ca>
References: <20200127202155.30305-1-alex_y_xu.ref@yahoo.ca>
Reply-To: "Alex Xu \(Hello71\)" <alex_y_xu@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic310-48.consmr.mail.gq1.yahoo.com
 (sonic310-48.consmr.mail.gq1.yahoo.com [98.137.69.174])
 by lists.lttng.org (Postfix) with ESMTPS id 4861Rp6Wp5z1xfC
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jan 2020 15:24:06 -0500 (EST)
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
 include/urcu/futex.h | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/urcu/futex.h b/include/urcu/futex.h
index c206c6f..9235024 100644
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
+	return _umtx_op(uaddr, umtx_op, val, umtx_uaddr, umtx_uaddr2);
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
