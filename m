From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools v2] Fix: timeout for connect is not
 respected
Date: Fri,  9 Nov 2018 10:37:28 -0500
Message-ID: <20181109153728.10409-1-jonathan.rajotte-julien__21839.1858776615$1541777744$gmane$org@efficios.com>
References: <237752dff54ba084bc7dcb4b117a66e6@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42s46D4rDszq4B
 for <lttng-dev@lists.lttng.org>; Fri,  9 Nov 2018 10:37:40 -0500 (EST)
In-Reply-To: <237752dff54ba084bc7dcb4b117a66e6@polymtl.ca>
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Problem:

The previous algorithm was not *wrong* but was prone to C type conversion
error.

Previous algorithm:

((A.sec - B.sec) * MSEC_PER_SEC) + ((A.nsec - B.nsec) / NSEC_PER_SEC)

((A.sec - B.sec) * 1000000ULL) + ((A.nsec - B.nsec) / 1000000ULL)

Note that "(A.nsec - B.nsec)" can be negative.

A *quick* fix here could be to cast the NSEC_PER_SEC to long allowing a
valid division operation.

The problem was introduced by 395d6b02dda3db1acd08936f49c1dc8efc48e613.

Solution:

Perform the time diff using a temporary timespec struct and perform the
carry operation manually. This prevent negative value for nsec and 
helps prevent C type promotion problems.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---

I initially misplaced the issue.
As mentioned in the commit message, we can also cast NSEC_PER_SEC to long to fix
the issue. I prefer the use of a timespec struct for expressiveness.

Also the case were we pass a time_b > time_a is handled by returning a
difference of zero. We might want to assert here since it should never happen.

 src/common/sessiond-comm/inet.c  | 28 ++++++++++++++++++++--------
 src/common/sessiond-comm/inet6.c | 28 ++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/src/common/sessiond-comm/inet.c b/src/common/sessiond-comm/inet.c
index e0b3e7a96..94a3c3a67 100644
--- a/src/common/sessiond-comm/inet.c
+++ b/src/common/sessiond-comm/inet.c
@@ -119,16 +119,28 @@ static
 unsigned long time_diff_ms(struct timespec *time_a,
 		struct timespec *time_b)
 {
-	time_t sec_diff;
-	long nsec_diff;
-	unsigned long result_ms;
+	struct timespec diff;
 
-	sec_diff = time_a->tv_sec - time_b->tv_sec;
-	nsec_diff = time_a->tv_nsec - time_b->tv_nsec;
+	diff.tv_sec = time_a->tv_sec - time_b->tv_sec;
+	diff.tv_nsec = time_a->tv_nsec - time_b->tv_nsec;
 
-	result_ms = sec_diff * MSEC_PER_SEC;
-	result_ms += nsec_diff / NSEC_PER_MSEC;
-	return result_ms;
+	if (diff.tv_nsec < 0) {
+		/* Perform borrow operation */
+		diff.tv_sec -= 1;
+		diff.tv_nsec += NSEC_PER_SEC;
+	}
+
+	if (diff.tv_sec < 0) {
+		/* We went back in time. Put all to zero */
+		diff.tv_sec = 0;
+		diff.tv_nsec = 0;
+	}
+
+	/*
+	 * Transform into MSEC, diff.tv_nsec is always positive due to borrow
+	 * operation. diff.tb_sec is always positive.
+	 */
+	return (diff.tv_sec * MSEC_PER_SEC) + (diff.tv_nsec / NSEC_PER_MSEC);
 }
 
 static
diff --git a/src/common/sessiond-comm/inet6.c b/src/common/sessiond-comm/inet6.c
index dfb5fc5d1..07043e93f 100644
--- a/src/common/sessiond-comm/inet6.c
+++ b/src/common/sessiond-comm/inet6.c
@@ -117,16 +117,28 @@ static
 unsigned long time_diff_ms(struct timespec *time_a,
 		struct timespec *time_b)
 {
-	time_t sec_diff;
-	long nsec_diff;
-	unsigned long result_ms;
+	struct timespec diff;
 
-	sec_diff = time_a->tv_sec - time_b->tv_sec;
-	nsec_diff = time_a->tv_nsec - time_b->tv_nsec;
+	diff.tv_sec = time_a->tv_sec - time_b->tv_sec;
+	diff.tv_nsec = time_a->tv_nsec - time_b->tv_nsec;
 
-	result_ms = sec_diff * MSEC_PER_SEC;
-	result_ms += nsec_diff / NSEC_PER_MSEC;
-	return result_ms;
+	if (diff.tv_nsec < 0) {
+		/* Perform borrow operation */
+		diff.tv_sec -= 1;
+		diff.tv_nsec += NSEC_PER_SEC;
+	}
+
+	if (diff.tv_sec < 0) {
+		/* We went back in time. Put all to zero */
+		diff.tv_sec = 0;
+		diff.tv_nsec = 0;
+	}
+
+	/*
+	 * Transform into MSEC, diff.tv_nsec is always positive due to borrow
+	 * operation. diff.tb_sec is always positive.
+	 */
+	return (diff.tv_sec * MSEC_PER_SEC) + (diff.tv_nsec / NSEC_PER_MSEC);
 }
 
 static
-- 
2.17.1
