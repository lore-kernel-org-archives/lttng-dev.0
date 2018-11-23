From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu 1/4] Fix: compat_futex_noasync on Cygwin
Date: Fri, 23 Nov 2018 15:27:04 -0500
Message-ID: <20181123202707.19851-1-mjeanson__47811.8623760112$1543004758$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 431nt63tfTzyCg
 for <lttng-dev@lists.lttng.org>; Fri, 23 Nov 2018 15:27:26 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id DE3179A04B
 for <lttng-dev@lists.lttng.org>; Fri, 23 Nov 2018 15:27:19 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

The futex_noasync compat code uses a weak symbol to share state across
different shared object which is not possible on Windows with the
 Portable Executable format. Use the async compat code for both cases.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 include/urcu/futex.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/urcu/futex.h b/include/urcu/futex.h
index 0486ff6..753df62 100644
--- a/include/urcu/futex.h
+++ b/include/urcu/futex.h
@@ -102,6 +102,25 @@ static inline int futex_async(int32_t *uaddr, int op, int32_t val,
 	return ret;
 }
 
+#elif defined(__CYGWIN__)
+
+/*
+ * The futex_noasync compat code uses a weak symbol to share state across
+ * different shared object which is not possible on Windows with the
+ * Portable Executable format. Use the async compat code for both cases.
+ */
+static inline int futex_noasync(int32_t *uaddr, int op, int32_t val,
+		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
+{
+	return compat_futex_async(uaddr, op, val, timeout, uaddr2, val3);
+}
+
+static inline int futex_async(int32_t *uaddr, int op, int32_t val,
+		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
+{
+	return compat_futex_async(uaddr, op, val, timeout, uaddr2, val3);
+}
+
 #else
 
 static inline int futex_noasync(int32_t *uaddr, int op, int32_t val,
-- 
2.17.1
