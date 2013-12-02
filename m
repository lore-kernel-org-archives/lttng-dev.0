From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH liburcu 1/2] FIX: Android : Do not redefine
	gettid
Date: Sun,  1 Dec 2013 18:00:49 -0800
Message-ID: <1385949650-16725-1-git-send-email-charlesbriere.flatzo__48873.225428588$1386016315$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1VnJYf-0005nH-Lv
	for lttng-dev@lists.lttng.org; Sun, 01 Dec 2013 21:48:30 -0500
Received: by mail-pb0-f51.google.com with SMTP id up15so18029440pbc.10
	for <lttng-dev@lists.lttng.org>; Sun, 01 Dec 2013 18:48:19 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: Charles Briere <charlesbriere.flatzo@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

When compiling with Android Toolchain, gettid
is already defined in <unistd.h> and therefore
doesn't need to be reimplemented. This patch
checks for gettid instead of looking for Android
in case other environements behave the same way.

Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
---
 configure.ac             |  2 +-
 tests/common/thread-id.h | 15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index b25685c..38e39e1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -56,7 +56,7 @@ AC_TYPE_SIZE_T
 # Checks for library functions.
 AC_FUNC_MALLOC
 AC_FUNC_MMAP
-AC_CHECK_FUNCS([bzero gettimeofday munmap sched_getcpu strtoul sysconf])
+AC_CHECK_FUNCS([bzero gettimeofday munmap sched_getcpu strtoul sysconf gettid])
 
 # Find arch type
 AS_CASE([$host_cpu],
diff --git a/tests/common/thread-id.h b/tests/common/thread-id.h
index 7261333..04db5bb 100644
--- a/tests/common/thread-id.h
+++ b/tests/common/thread-id.h
@@ -17,10 +17,18 @@
  * provided the above notices are retained, and a notice that the code was
  * modified is included with the above copyright notice.
  */
+#include <config.h>
+
 #ifdef __linux__
 # include <urcu/syscall-compat.h>
 
-# if defined(_syscall0)
+# if defined(HAVE_GETTID)
+/*
+ * Do not redefine gettid() as it is already included
+ * in bionic through <unistd.h>. Some other libc
+ * may also already contain an implementation of gettid.
+ */
+# elif defined(_syscall0)
 _syscall0(pid_t, gettid)
 # elif defined(__NR_gettid)
 static inline pid_t gettid(void)
@@ -42,11 +50,6 @@ unsigned long urcu_get_thread_id(void)
 {
 	return (unsigned long) pthread_getthreadid_np();
 }
-#elif defined(__Android__)
-/*
- * Do not redefine gettid() as it is already included
- * in bionic through <unistd.h>.
- */
 #else
 # warning "use pid as thread ID"
 static inline
-- 
1.8.4.2
