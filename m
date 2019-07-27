From: Khem Raj <raj.khem@gmail.com>
Subject: [lttng-tools][PATCH] check for gettid API during
 configure
Date: Sat, 27 Jul 2019 08:56:59 -0700
Message-ID: <20190727155659.38125-1-raj.khem__36622.3970822588$1564243054$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by lists.lttng.org (Postfix) with ESMTPS id 45wrDj5RT2z1H1F
 for <lttng-dev@lists.lttng.org>; Sat, 27 Jul 2019 11:57:09 -0400 (EDT)
Received: by mail-pf1-x42e.google.com with SMTP id u14so25933885pfn.2
 for <lttng-dev@lists.lttng.org>; Sat, 27 Jul 2019 08:57:09 -0700 (PDT)
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

Add support for gettid() provided by glibc 2.30+

Since version 2.30 glibc provides gettid and it causes conflicts with
locally defined gettid(). Use the local definition of
gettid only if system gettid is not available.

https://sourceware.org/git/?p=glibc.git;a=blob_plain;f=NEWS;hb=HEAD<Paste>

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 configure.ac            | 2 +-
 src/common/compat/tid.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7b99f5c..e4bd82c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -190,7 +190,7 @@ AC_CHECK_HEADERS([ \
 # Basic functions check
 AC_CHECK_FUNCS([ \
 	atexit bzero clock_gettime dup2 fdatasync fls ftruncate \
-	gethostbyname gethostname getpagesize localtime_r memchr memset \
+	gethostbyname gethostname getpagesize gettid localtime_r memchr memset \
 	mkdir munmap putenv realpath rmdir socket strchr strcspn strdup \
 	strncasecmp strndup strnlen strpbrk strrchr strstr strtol strtoul \
 	strtoull dirfd gethostbyname2 getipnodebyname epoll_create1 \
diff --git a/src/common/compat/tid.h b/src/common/compat/tid.h
index 40f562f..aa07a85 100644
--- a/src/common/compat/tid.h
+++ b/src/common/compat/tid.h
@@ -25,6 +25,7 @@
 #ifndef LTTNG_TID_H
 #define LTTNG_TID_H
 
+#if !HAVE_GETTID
 #ifdef __linux__
 #include <syscall.h>
 #endif
@@ -47,5 +48,5 @@ static inline pid_t gettid(void)
 	return getpid();
 }
 #endif
-
+#endif /* HAVE_GETTID */
 #endif /* LTTNG_TID_H */
-- 
2.22.0
