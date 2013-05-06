From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH lttng-tools 04/14] Adding epoll compat for
	Android and gettid check for presence on any arch
Date: Mon,  6 May 2013 18:18:41 +0000
Message-ID: <1367864331-15212-4-git-send-email-charlesbriere.flatzo__39396.3252696723$1367864401$gmane$org@gmail.com>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1UZQ09-0008WN-Dh
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 14:19:05 -0400
Received: by mail-qa0-f46.google.com with SMTP id g10so1459595qah.12
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 11:19:00 -0700 (PDT)
In-Reply-To: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>

Signed-off-by: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
---
 configure.ac             |  6 ++++++
 src/common/compat/poll.h | 13 +++++++++++++
 src/common/compat/tid.h  |  6 ++++++
 src/common/uri.h         |  6 ++++++
 4 files changed, 31 insertions(+)

diff --git a/configure.ac b/configure.ac
index b78cc94..eb79fc4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -133,6 +133,12 @@ AC_CHECK_DECL(be64toh, [],
 ]
 )
 
+# Check if gettid() is already defined
+AC_CHECK_DECL(gettid,
+[
+	AC_DEFINE_UNQUOTED([LTTNG_HAVE_GETTID], 1, [Has already gettid defined])
+])
+
 # Check libpopt
 AC_CHECK_LIB([popt], [poptGetContext], [],
 [
diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
index 9e88976..3687c5d 100644
--- a/src/common/compat/poll.h
+++ b/src/common/compat/poll.h
@@ -52,6 +52,19 @@ static inline void __lttng_poll_free(void *events)
 #ifdef HAVE_EPOLL
 #include <sys/epoll.h>
 #include <stdio.h>
+#ifdef __ANDROID__
+#include <asm/unistd.h>
+#ifndef EPOLLRDHUP
+#define EPOLLRDHUP 0x2000
+#endif
+#ifndef EPOLL_CLOEXEC
+#define EPOLL_CLOEXEC 02000000
+#endif
+static inline int epoll_create1(int flags)
+{
+	return syscall(__NR_epoll_create1,flags);
+}
+#endif /* __ANDROID__ */
 
 /* See man epoll(7) for this define path */
 #define COMPAT_EPOLL_PROC_PATH "/proc/sys/fs/epoll/max_user_watches"
diff --git a/src/common/compat/tid.h b/src/common/compat/tid.h
index 40f562f..81afa2b 100644
--- a/src/common/compat/tid.h
+++ b/src/common/compat/tid.h
@@ -26,17 +26,23 @@
 #define LTTNG_TID_H
 
 #ifdef __linux__
+#ifdef __ANDROID__
+#include <sys/syscall.h>
+#else
 #include <syscall.h>
+#endif // __ANDROID__
 #endif
 
 #if defined(_syscall0)
 _syscall0(pid_t, gettid)
 #elif defined(__NR_gettid)
 #include <unistd.h>
+#ifndef LTTNG_HAVE_GETTID
 static inline pid_t gettid(void)
 {
 	return syscall(__NR_gettid);
 }
+#endif // LTTNG_HAVE_GETTID
 #else
 #include <sys/types.h>
 #include <unistd.h>
diff --git a/src/common/uri.h b/src/common/uri.h
index 347b639..88a5e01 100644
--- a/src/common/uri.h
+++ b/src/common/uri.h
@@ -21,6 +21,12 @@
 #include <netinet/in.h>
 #include <lttng/lttng.h>
 
+#ifdef __ANDROID__
+#ifndef in_port_t
+typedef uint16_t in_port_t;
+#endif // in_port_t
+#endif // __ANDROID__
+
 /* Destination type of lttng URI */
 enum lttng_dst_type {
 	LTTNG_DST_IPV4                        = 1,
-- 
1.8.1.msysgit.1
