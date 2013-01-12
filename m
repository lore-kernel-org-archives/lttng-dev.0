From: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH] Make sync_file_range() usage optional
Date: Sat, 12 Jan 2013 09:23:57 +0100
Message-ID: <1357979037-28550-1-git-send-email-s.martin49__32237.3387557038$1357979187$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <s.martin49@gmail.com>) id 1TtwPX-0007o4-Gf
	for lttng-dev@lists.lttng.org; Sat, 12 Jan 2013 03:25:51 -0500
Received: by mail-wg0-f42.google.com with SMTP id dr1so274808wgb.1
	for <lttng-dev@lists.lttng.org>; Sat, 12 Jan 2013 00:25:45 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Under uClibc, sync_file_range() is not available under all
architectures, so we fall back to fdatasync() in this case.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 configure.ac                     | 2 +-
 src/common/compat/compat-fcntl.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 425941b..80940c0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -150,7 +150,7 @@ AS_IF([test "x$lttng_ust_support" = "xyes"], [
 	)
 ])
 AM_CONDITIONAL([HAVE_LIBLTTNG_UST_CTL], [test "x$lttng_ust_ctl_found" = xyes])
-AC_CHECK_FUNCS([sched_getcpu sysconf])
+AC_CHECK_FUNCS([sched_getcpu sysconf sync_file_range])
 
 # check for dlopen
 AC_CHECK_LIB([dl], [dlopen],
diff --git a/src/common/compat/compat-fcntl.c b/src/common/compat/compat-fcntl.c
index 5a1c757..7ff63a3 100644
--- a/src/common/compat/compat-fcntl.c
+++ b/src/common/compat/compat-fcntl.c
@@ -23,7 +23,11 @@
 int compat_sync_file_range(int fd, off64_t offset, off64_t nbytes,
 		unsigned int flags)
 {
+#ifdef HAVE_SYNC_FILE_RANGE
 	return sync_file_range(fd, offset, nbytes, flags);
+#else
+	return fdatasync(fd);
+#endif
 }
 
 #endif /* __linux__ */
-- 
1.8.1
