From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH lttng-tools 1/2] Fix: build failure when
	__GLIBC_PREREQ is missing
Date: Tue,  8 Mar 2016 14:55:04 +0200
Message-ID: <17f5fc70d86b42e09f71fc46f6dfbd85b9ee3eaf.1457441705.git.baruch__36568.1392876015$1457441843$gmane$org@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <baruch@tkos.co.il>) id 1adHB0-0007xP-N4
 for lttng-dev@lists.lttng.org; Tue, 08 Mar 2016 07:55:52 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The musl C library does not provide the __GLIBC_PREREQ macro. Instead of
relying on glibc version test, check directly for the availability of
epoll_create1().

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 configure.ac             | 2 +-
 src/common/compat/poll.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 693c456a620d..fdbce41c2428 100644
--- a/configure.ac
+++ b/configure.ac
@@ -120,7 +120,7 @@ AC_CHECK_FUNCS([ \
 	gethostbyname gethostname getpagesize localtime_r memchr memset \
 	mkdir munmap putenv realpath rmdir socket strchr strcspn strdup \
 	strncasecmp strndup strnlen strpbrk strrchr strstr strtol strtoul \
-	strtoull dirfd gethostbyname2 getipnodebyname \
+	strtoull dirfd gethostbyname2 getipnodebyname epoll_create1 \
 ])
 
 # Babeltrace viewer check
diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
index 5f45da2b3b04..34d0cffda479 100644
--- a/src/common/compat/poll.h
+++ b/src/common/compat/poll.h
@@ -73,7 +73,7 @@ enum {
 	LPOLLNVAL = EPOLLHUP,
 	LPOLLRDHUP = EPOLLRDHUP,
 	/* Close on exec feature of epoll */
-#if __GLIBC_PREREQ(2, 9)
+#if defined(HAVE_EPOLL_CREATE1) && defined(EPOLL_CLOEXEC)
 	LTTNG_CLOEXEC = EPOLL_CLOEXEC,
 #else
 	/*
@@ -127,7 +127,7 @@ extern int compat_epoll_create(struct lttng_poll_event *events,
 #define lttng_poll_create(events, size, flags) \
 	compat_epoll_create(events, size, flags)
 
-#if __GLIBC_PREREQ(2, 9)
+#if defined(HAVE_EPOLL_CREATE1) && defined(EPOLL_CLOEXEC)
 static inline int compat_glibc_epoll_create(int size __attribute__((unused)),
 		int flags)
 {
-- 
2.7.0
