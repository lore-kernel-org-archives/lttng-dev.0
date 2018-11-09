From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: Connect timeout arithmetic
 in inet/inet6 (v2)
Date: Fri,  9 Nov 2018 17:40:46 -0500
Message-ID: <20181109224047.18750-1-mathieu.desnoyers__6735.9474524439$1541803528$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42sFVV1blgzqYB
 for <lttng-dev@lists.lttng.org>; Fri,  9 Nov 2018 17:40:49 -0500 (EST)
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
---
 src/common/common.h              |  5 +++++
 src/common/sessiond-comm/inet.c  | 28 ++++++++--------------------
 src/common/sessiond-comm/inet6.c | 28 ++++++++--------------------
 src/common/utils.c               | 31 +++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/src/common/common.h b/src/common/common.h
index 41eb0361..48f39e0e 100644
--- a/src/common/common.h
+++ b/src/common/common.h
@@ -19,9 +19,14 @@
 #ifndef _COMMON_H
 #define _COMMON_H
 
+#include <time.h>
+
 #include "error.h"
 #include "macros.h"
 #include "runas.h"
 #include "readwrite.h"
 
+int timespec_to_ms(struct timespec ts, unsigned long *ms);
+struct timespec timespec_abs_diff(struct timespec ts_a, struct timespec ts_b);
+
 #endif /* _COMMON_H */
diff --git a/src/common/sessiond-comm/inet.c b/src/common/sessiond-comm/inet.c
index e0b3e7a9..76a3b7ff 100644
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
@@ -217,7 +199,13 @@ int connect_with_timeout(struct lttcomm_sock *sock)
 			connect_ret = ret;
 			goto error;
 		}
-	} while (time_diff_ms(&cur_time, &orig_time) < timeout);
+		if (timespec_to_ms(timespec_abs_diff(cur_time, orig_time), &diff_ms) < 0) {
+			ERR("timespec_to_ms input overflows milliseconds output");
+			errno = EOVERFLOW;
+			connect_ret = -1;
+			goto error;
+		}
+	} while (diff_ms < timeout);
 
 	/* Timeout */
 	errno = ETIMEDOUT;
diff --git a/src/common/sessiond-comm/inet6.c b/src/common/sessiond-comm/inet6.c
index dfb5fc5d..5c1ac2e0 100644
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
@@ -216,7 +198,13 @@ int connect_with_timeout(struct lttcomm_sock *sock)
 			connect_ret = ret;
 			goto error;
 		}
-	} while (time_diff_ms(&cur_time, &orig_time) < timeout);
+		if (timespec_to_ms(timespec_abs_diff(cur_time, orig_time), &diff_ms) < 0) {
+			ERR("timespec_to_ms input overflows milliseconds output");
+			errno = EOVERFLOW;
+			connect_ret = -1;
+			goto error;
+		}
+	} while (diff_ms < timeout);
 
 	/* Timeout */
 	errno = ETIMEDOUT;
diff --git a/src/common/utils.c b/src/common/utils.c
index 3442bef8..5b4e1d3c 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -31,6 +31,7 @@
 #include <pwd.h>
 #include <sys/file.h>
 #include <unistd.h>
+#include <stdint.h>
 
 #include <common/common.h>
 #include <common/runas.h>
@@ -41,6 +42,7 @@
 
 #include "utils.h"
 #include "defaults.h"
+#include "time.h"
 
 /*
  * Return a partial realpath(3) of the path even if the full path does not
@@ -1645,3 +1647,32 @@ int utils_show_help(int section, const char *page_name,
 end:
 	return ret;
 }
+
+LTTNG_HIDDEN
+int timespec_to_ms(struct timespec ts, unsigned long *ms)
+{
+	unsigned long res;
+
+	if (ts.tv_sec + 1 > ULONG_MAX / MSEC_PER_SEC) {
+		return -1;
+	}
+	res = ts.tv_sec * MSEC_PER_SEC;
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
