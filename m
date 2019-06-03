From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: namespace our gettid wrapper
Date: Mon,  3 Jun 2019 15:25:52 -0400
Message-ID: <20190603192552.19061-1-mjeanson__18451.1320361466$1559590028$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45HlQZ2xrfz10YM
 for <lttng-dev@lists.lttng.org>; Mon,  3 Jun 2019 15:25:58 -0400 (EDT)
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

Since glibc 2.30, a gettid wrapper was added that conflicts with our
static declaration. Namespace our wrapper so there is no conflict,
we'll add support for the glibc provided wrapper in a further commit.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/common/compat/tid.h | 12 +++++++-----
 src/common/error.h      |  4 ++--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/src/common/compat/tid.h b/src/common/compat/tid.h
index 40f562f9..15f9fdc7 100644
--- a/src/common/compat/tid.h
+++ b/src/common/compat/tid.h
@@ -29,23 +29,25 @@
 #include <syscall.h>
 #endif
 
-#if defined(_syscall0)
-_syscall0(pid_t, gettid)
-#elif defined(__NR_gettid)
+#if defined(__NR_gettid)
+
 #include <unistd.h>
-static inline pid_t gettid(void)
+static inline pid_t lttng_gettid(void)
 {
 	return syscall(__NR_gettid);
 }
+
 #else
+
 #include <sys/types.h>
 #include <unistd.h>
 
 /* Fall-back on getpid for tid if not available. */
-static inline pid_t gettid(void)
+static inline pid_t lttng_gettid(void)
 {
 	return getpid();
 }
+
 #endif
 
 #endif /* LTTNG_TID_H */
diff --git a/src/common/error.h b/src/common/error.h
index c90c4ae0..3fe742c0 100644
--- a/src/common/error.h
+++ b/src/common/error.h
@@ -151,11 +151,11 @@ static inline void __lttng_print_check_abort(enum lttng_error_level type)
 /* Three level of debug. Use -v, -vv or -vvv for the levels */
 #define _ERRMSG(msg, type, fmt, args...) __lttng_print(type, msg \
 		" - %s [%ld/%ld]: " fmt " (in %s() at " __FILE__ ":" XSTR(__LINE__) ")\n", \
-			log_add_time(), (long) getpid(), (long) gettid(), ## args, __func__)
+			log_add_time(), (long) getpid(), (long) lttng_gettid(), ## args, __func__)
 
 #define _ERRMSG_NO_LOC(msg, type, fmt, args...) __lttng_print(type, msg	\
 		" - %s [%ld/%ld]: " fmt "\n", \
-			log_add_time(), (long) getpid(), (long) gettid(), ## args)
+			log_add_time(), (long) getpid(), (long) lttng_gettid(), ## args)
 
 #define MSG(fmt, args...) \
 	__lttng_print(PRINT_MSG, fmt "\n", ## args)
-- 
2.17.1
