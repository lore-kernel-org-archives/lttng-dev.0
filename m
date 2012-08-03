From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: Missing libs dependencies
	in configure check for lttng-ust-ctl
Date: Fri,  3 Aug 2012 16:31:28 -0400
Message-ID: <884d75d90550f85492dfcaac2b0088f78ced542b.1344025572.git.christian.babeux__15379.529403481$1344025977$gmane$org@efficios.com>
References: <cover.1344025572.git.christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yx0-f176.google.com ([209.85.213.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1SxOY3-0007qE-6h
	for lttng-dev@lists.lttng.org; Fri, 03 Aug 2012 16:32:39 -0400
Received: by yenl5 with SMTP id l5so1587724yen.35
	for <lttng-dev@lists.lttng.org>; Fri, 03 Aug 2012 13:32:32 -0700 (PDT)
In-Reply-To: <cover.1344025572.git.christian.babeux@efficios.com>
In-Reply-To: <cover.1344025572.git.christian.babeux@efficios.com>
References: <cover.1344025572.git.christian.babeux@efficios.com>
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

The lttng-ust-ctl library depends on liburcu-{common,bp,cds}.
The AC_CHECK_LIBRARY macro can't automatically resolve dependents
libraries (ala libtool), so any additionnals dependencies must
be manually specified.

Also, the AC_CHECK_LIB action-if-found case for the lttng-ust-ctl
check is modified to have a similar behavior as the default action,
which is to define HAVE_LIBxxx and append -lxxx to $LIBS, *except*
for the later step. This is to ensure that any future addition of
AC_CHECK_LIB after the one for lttng-ust-ctl will not need to append
the liburcu dependencies or fail unexpectedly.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 configure.ac | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 3a023cd..e4b9eb1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -138,13 +138,16 @@ AC_ARG_ENABLE(lttng-ust,
 	lttng_ust_support=$enableval, lttng_ust_support=yes)
 
 AS_IF([test "x$lttng_ust_support" = "xyes"], [
-	AC_CHECK_LIB([lttng-ust-ctl], [ustctl_create_session], [],
-		[AC_MSG_ERROR([Cannot find LTTng-UST. Use [LDFLAGS]=-Ldir to specify its location, or specify --disable-lttng-ust to build lttng-tools without LTTng-UST support.])]
+	AC_CHECK_LIB([lttng-ust-ctl], [ustctl_create_session],
+		[
+			AC_DEFINE([HAVE_LIBLTTNG_UST_CTL], [1], [has LTTng-UST control support])
+			lttng_ust_ctl_found=yes
+		],
+		[AC_MSG_ERROR([Cannot find LTTng-UST. Use [LDFLAGS]=-Ldir to specify its location, or specify --disable-lttng-ust to build lttng-tools without LTTng-UST support.])],
+		[-lurcu-common -lurcu-bp -lurcu-cds]
 	)
 ])
-
-AM_CONDITIONAL([HAVE_LIBLTTNG_UST_CTL], [ test "x$ac_cv_lib_lttng_ust_ctl_ustctl_create_session" = "xyes" ])
-
+AM_CONDITIONAL([HAVE_LIBLTTNG_UST_CTL], [test "x$lttng_ust_ctl_found" = xyes])
 AC_CHECK_FUNCS([sched_getcpu sysconf])
 
 # check for dlopen
-- 
1.7.11.3
