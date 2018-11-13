From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: Connect timeout arithmetic
 in inet/inet6 (v4)
Date: Tue, 13 Nov 2018 12:12:20 -0500
Message-ID: <20181113171221.2634-1-mathieu.desnoyers__11368.7002718963$1542129061$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42vZ1k2NXQzrYF
 for <lttng-dev@lists.lttng.org>; Tue, 13 Nov 2018 12:12:26 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, jonathan.rajotte-julien@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The nanoseconds part of the timespec struct time_a is not always
bigger than time_b since it wrap around each seconds.

Use 64-bit arithmetic to perform the difference.

Merge/move duplicated code into utils.c.

This function is really doing two things. Split it into timespec_to_ms()
and timespec_abs_diff().

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
Changes since v1:
- Use NSEC_PER_SEC constant.

Changes since v2:
- Move prototypes to time.h.
- Adapt timespec_to_ms() range check to take into account tv_nsec beyond
  1000000000-1.

Changes since v3:
- Use remainer for detection of overflow.
- set errno to EOVERFLOW in timespec_to_ms.
---
 src/common/common.h              |  1 +
 src/common/sessiond-comm/inet.c  | 27 +++++++--------------------
 src/common/sessiond-comm/inet6.c | 27 +++++++--------------------
 src/common/time.h                | 15 +++++++++++++++
 src/common/utils.c               | 36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 40 deletions(-)

diff --git a/src/common/common.h b/src/common/common.h
index 41eb0361..9168a245 100644
--- a/src/common/common.h
+++ b/src/common/common.h
@@ -23,5 +23,6 @@
 #include "macros.h"
 #include "runas.h"
 #include "readwrite.h"
+#include "time.h"
 
 #endif /* _COMMON_H */
diff --git a/src/common/sessiond-comm/inet.c b/src/common/sessiond-comm/inet.c
index e0b3e7a9..ac450dbc 100644
--- a/src/common/sessiond-comm/inet.c
+++ b/src/common/sessiond-comm/inet.c
@@ -112,31 +112,13 @@ int connect_no_timeout(struct lttcomm_sock *sock)
 			sizeof(sock->sockaddr.addr.sin));
 }
 
-/*
- * Return time_a - time_b  in milliseconds.
- */
-static
-unsigned long time_diff_ms(struct timespec *time_a,
-		struct timespec *time_b)
-{
-	time_t sec_diff;
-	long nsec_diff;
-	unsigned long result_ms;
-
-	sec_diff = time_a->tv_sec - time_b->tv_sec;
-	nsec_diff = time_a->tv_nsec - time_b->tv_nsec;
-
-	result_ms = sec_diff * MSEC_PER_SEC;
-	result_ms += nsec_diff / NSEC_PER_MSEC;
-	return result_ms;
-}
-
 static
 int connect_with_timeout(struct lttcomm_sock *sock)
 {
 	unsigned long timeout = lttcomm_get_network_timeout();
 	int ret, flags, connect_ret;
 	struct timespec orig_time, cur_time;
+	unsigned long diff_ms;
 
 	ret = fcntl(sock->fd, F_GETFL, 0);
 	if (ret == -1) {
@@ -217,7 +199,12 @@ int connect_with_timeout(struct lttcomm_sock *sock)
 			connect_ret = ret;
 			goto error;
 		}
-	} while (time_diff_ms(&cur_time, &orig_time) < timeout);
+		if (timespec_to_ms(timespec_abs_diff(cur_time, orig_time), &diff_ms) < 0) {
+			ERR("timespec_to_ms input overflows milliseconds output");
+			connect_ret = -1;
+			goto error;
+		}
+	} while (diff_ms < timeout);
 
 	/* Timeout */
 	errno = ETIMEDOUT;
diff --git a/src/common/sessiond-comm/inet6.c b/src/common/sessiond-comm/inet6.c
index dfb5fc5d..03b6627d 100644
--- a/src/common/sessiond-comm/inet6.c
+++ b/src/common/sessiond-comm/inet6.c
@@ -110,31 +110,13 @@ int connect_no_timeout(struct lttcomm_sock *sock)
 			sizeof(sock->sockaddr.addr.sin6));
 }
 
-/*
- * Return time_a - time_b  in milliseconds.
- */
-static
-unsigned long time_diff_ms(struct timespec *time_a,
-		struct timespec *time_b)
-{
-	time_t sec_diff;
-	long nsec_diff;
-	unsigned long result_ms;
-
-	sec_diff = time_a->tv_sec - time_b->tv_sec;
-	nsec_diff = time_a->tv_nsec - time_b->tv_nsec;
-
-	result_ms = sec_diff * MSEC_PER_SEC;
-	result_ms += nsec_diff / NSEC_PER_MSEC;
-	return result_ms;
-}
-
 static
 int connect_with_timeout(struct lttcomm_sock *sock)
 {
 	unsigned long timeout = lttcomm_get_network_timeout();
 	int ret, flags, connect_ret;
 	struct timespec orig_time, cur_time;
+	unsigned long diff_ms;
 
 	ret = fcntl(sock->fd, F_GETFL, 0);
 	if (ret == -1) {
@@ -216,7 +198,12 @@ int connect_with_timeout(struct lttcomm_sock *sock)
 			connect_ret = ret;
 			goto error;
 		}
-	} while (time_diff_ms(&cur_time, &orig_time) < timeout);
+		if (timespec_to_ms(timespec_abs_diff(cur_time, orig_time), &diff_ms) < 0) {
+			ERR("timespec_to_ms input overflows milliseconds output");
+			connect_ret = -1;
+			goto error;
+		}
+	} while (diff_ms < timeout);
 
 	/* Timeout */
 	errno = ETIMEDOUT;
diff --git a/src/common/time.h b/src/common/time.h
index 81770779..8a7dd958 100644
--- a/src/common/time.h
+++ b/src/common/time.h
@@ -19,9 +19,24 @@
 #ifndef LTTNG_TIME_H
 #define LTTNG_TIME_H
 
+#include <time.h>
+
 #define MSEC_PER_SEC	1000ULL
 #define NSEC_PER_SEC	1000000000ULL
 #define NSEC_PER_MSEC	1000000ULL
 #define NSEC_PER_USEC	1000ULL
 
+/*
+ * timespec_to_ms: Convert timespec to milliseconds.
+ *
+ * Returns 0 on success, else -1 on error. errno is set to EOVERFLOW if
+ * input would overflow the output in milliseconds.
+ */
+int timespec_to_ms(struct timespec ts, unsigned long *ms);
+
+/*
+ * timespec_abs_diff: Absolute difference between timespec.
+ */
+struct timespec timespec_abs_diff(struct timespec ts_a, struct timespec ts_b);
+
 #endif /* LTTNG_TIME_H */
diff --git a/src/common/utils.c b/src/common/utils.c
index 3442bef8..08139e5e 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -41,6 +41,7 @@
 
 #include "utils.h"
 #include "defaults.h"
+#include "time.h"
 
 /*
  * Return a partial realpath(3) of the path even if the full path does not
@@ -1645,3 +1646,38 @@ int utils_show_help(int section, const char *page_name,
 end:
 	return ret;
 }
+
+LTTNG_HIDDEN
+int timespec_to_ms(struct timespec ts, unsigned long *ms)
+{
+	unsigned long res, remain_ms;
+
+	if (ts.tv_sec > ULONG_MAX / MSEC_PER_SEC) {
+		errno = EOVERFLOW;
+		return -1;	/* multiplication overflow */
+	}
+	res = ts.tv_sec * MSEC_PER_SEC;
+	remain_ms = ULONG_MAX - res;
+	if (ts.tv_nsec / NSEC_PER_MSEC > remain_ms) {
+		errno = EOVERFLOW;
+		return -1;	/* addition overflow */
+	}
+	res += ts.tv_nsec / NSEC_PER_MSEC;
+	*ms = res;
+	return 0;
+}
+
+LTTNG_HIDDEN
+struct timespec timespec_abs_diff(struct timespec t1, struct timespec t2)
+{
+	uint64_t ts1 = (uint64_t) t1.tv_sec * (uint64_t) NSEC_PER_SEC +
+			(uint64_t) t1.tv_nsec;
+	uint64_t ts2 = (uint64_t) t2.tv_sec * (uint64_t) NSEC_PER_SEC +
+			(uint64_t) t2.tv_nsec;
+	uint64_t diff = max(ts1, ts2) - min(ts1, ts2);
+	struct timespec res;
+
+	res.tv_sec = diff / (uint64_t) NSEC_PER_SEC;
+	res.tv_nsec = diff % (uint64_t) NSEC_PER_SEC;
+	return res;
+}
-- 
2.11.0
