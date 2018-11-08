From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: nsec diff can be negative
 leading to expeditive connection timeout
Date: Thu,  8 Nov 2018 17:08:05 -0500
Message-ID: <20181108220805.10307-1-jonathan.rajotte-julien__46213.6091817685$1541714774$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcqH1GSPzqcP
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 17:08:10 -0500 (EST)
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

The nanoseconds part of the timespec struct time_a is not always
bigger than time_b since it wrap around each seconds.

Use the absolute value of the nanosecond difference to perform
unsigned long operation.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/common/sessiond-comm/inet.c  | 2 +-
 src/common/sessiond-comm/inet6.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common/sessiond-comm/inet.c b/src/common/sessiond-comm/inet.c
index e0b3e7a96..cb6f45357 100644
--- a/src/common/sessiond-comm/inet.c
+++ b/src/common/sessiond-comm/inet.c
@@ -124,7 +124,7 @@ unsigned long time_diff_ms(struct timespec *time_a,
 	unsigned long result_ms;
 
 	sec_diff = time_a->tv_sec - time_b->tv_sec;
-	nsec_diff = time_a->tv_nsec - time_b->tv_nsec;
+	nsec_diff = labs(time_a->tv_nsec - time_b->tv_nsec);
 
 	result_ms = sec_diff * MSEC_PER_SEC;
 	result_ms += nsec_diff / NSEC_PER_MSEC;
diff --git a/src/common/sessiond-comm/inet6.c b/src/common/sessiond-comm/inet6.c
index dfb5fc5d1..b73802d48 100644
--- a/src/common/sessiond-comm/inet6.c
+++ b/src/common/sessiond-comm/inet6.c
@@ -122,7 +122,7 @@ unsigned long time_diff_ms(struct timespec *time_a,
 	unsigned long result_ms;
 
 	sec_diff = time_a->tv_sec - time_b->tv_sec;
-	nsec_diff = time_a->tv_nsec - time_b->tv_nsec;
+	nsec_diff = labs(time_a->tv_nsec - time_b->tv_nsec);
 
 	result_ms = sec_diff * MSEC_PER_SEC;
 	result_ms += nsec_diff / NSEC_PER_MSEC;
-- 
2.17.1
