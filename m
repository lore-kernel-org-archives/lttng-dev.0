From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH urcu] Fix: dynamic fallback to compat futex
	on sys_futex ENOSYS
Date: Fri, 11 Sep 2015 10:48:38 -0400
Message-ID: <1441982918-15047-1-git-send-email-mathieu.desnoyers__46290.8777212307$1441982989$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZaPdD-0004Jz-Rx
 for lttng-dev@lists.lttng.org; Fri, 11 Sep 2015 10:48:55 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Some MIPS processors (e.g. Cavium Octeon II) dynamically check if the
CPU supports ll/sc within sys_futex, and return a ENOSYS errno if they
don't, even though the architecture implements sys_futex.

Handle this situation by always building the sys_futex compatibility
layer, and fall-back on it if sys_futex return a ENOSYS errno. This is
a tiny compat layer which adds very little space overhead.

This adds an unlikely branch on return from sys_futex, which should
not be an issue performance-wise (we've already taken a system call).

Since this is a fall-back mode, don't try to be clever, and don't cache
the result, so that the common cases (architectures with a properly
working sys_futex) don't get two conditional branches, just one.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Michael Jeanson <mjeanson@efficios.com>
CC: Jon Bernard <jbernard@debian.org>
---
 Makefile.am  |  2 --
 urcu/futex.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 752510d..f9a8888 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -41,9 +41,7 @@ else
 COMPAT=
 endif
 
-if COMPAT_FUTEX
 COMPAT+=compat_futex.c
-endif
 
 RCULFHASH = rculfhash.c rculfhash-mm-order.c rculfhash-mm-chunk.c \
 		rculfhash-mm-mmap.c
diff --git a/urcu/futex.h b/urcu/futex.h
index 2be3bb6..13d2b1a 100644
--- a/urcu/futex.h
+++ b/urcu/futex.h
@@ -47,22 +47,66 @@ extern "C" {
  * (returns EINTR).
  */
 
+extern int compat_futex_noasync(int32_t *uaddr, int op, int32_t val,
+		const struct timespec *timeout, int32_t *uaddr2, int32_t val3);
+extern int compat_futex_async(int32_t *uaddr, int op, int32_t val,
+		const struct timespec *timeout, int32_t *uaddr2, int32_t val3);
+
 #ifdef CONFIG_RCU_HAVE_FUTEX
+
+#include <unistd.h>
+#include <errno.h>
+#include <urcu/compiler.h>
 #include <urcu/syscall-compat.h>
-#define futex(...)	syscall(__NR_futex, __VA_ARGS__)
-#define futex_noasync(uaddr, op, val, timeout, uaddr2, val3)	\
-		futex(uaddr, op, val, timeout, uaddr2, val3)
-#define futex_async(uaddr, op, val, timeout, uaddr2, val3)	\
-		futex(uaddr, op, val, timeout, uaddr2, val3)
+
+static inline int futex(int32_t *uaddr, int op, int32_t val,
+		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
+{
+	return syscall(__NR_futex, uaddr, op, val, timeout,
+			uaddr2, val3);
+}
+
+static inline int futex_noasync(int32_t *uaddr, int op, int32_t val,
+		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
+{
+	int ret;
+
+	ret = futex(uaddr, op, val, timeout, uaddr2, val3);
+	if (caa_unlikely(ret < 0 && errno == ENOSYS)) {
+		return compat_futex_noasync(uaddr, op, val, timeout,
+				uaddr2, val3);
+	}
+	return ret;
+
+}
+
+static inline int futex_async(int32_t *uaddr, int op, int32_t val,
+		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
+{
+	int ret;
+
+	ret = futex(uaddr, op, val, timeout, uaddr2, val3);
+	if (caa_unlikely(ret < 0 && errno == ENOSYS)) {
+		return compat_futex_async(uaddr, op, val, timeout,
+				uaddr2, val3);
+	}
+	return ret;
+}
+
 #else
-extern int compat_futex_noasync(int32_t *uaddr, int op, int32_t val,
-	const struct timespec *timeout, int32_t *uaddr2, int32_t val3);
-#define futex_noasync(uaddr, op, val, timeout, uaddr2, val3)	\
-		compat_futex_noasync(uaddr, op, val, timeout, uaddr2, val3)
-extern int compat_futex_async(int32_t *uaddr, int op, int32_t val,
-	const struct timespec *timeout, int32_t *uaddr2, int32_t val3);
-#define futex_async(uaddr, op, val, timeout, uaddr2, val3)	\
-		compat_futex_async(uaddr, op, val, timeout, uaddr2, val3)
+
+static inline int futex_noasync(int32_t *uaddr, int op, int32_t val,
+		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
+{
+	return compat_futex_noasync(uaddr, op, val, timeout, uaddr2, val3);
+}
+
+static inline int futex_async(int32_t *uaddr, int op, int32_t val,
+		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
+{
+	return compat_futex_async(uaddr, op, val, timeout, uaddr2, val3);
+}
+
 #endif
 
 #ifdef __cplusplus 
-- 
2.1.4
