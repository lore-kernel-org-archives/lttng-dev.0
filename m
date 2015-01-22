From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tool] Test: do not run ust dependent tests
	on make check
Date: Thu, 22 Jan 2015 16:06:44 -0500
Message-ID: <1421960804-26726-1-git-send-email-jonathan.rajotte-julien__39059.3630647801$1421960902$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YEOyV-00025x-C4
 for lttng-dev@lists.lttng.org; Thu, 22 Jan 2015 16:07:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2CBFC340253
 for <lttng-dev@lists.lttng.org>; Thu, 22 Jan 2015 21:07:36 +0000 (UTC)
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac      | 1 +
 tests/Makefile.am | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/configure.ac b/configure.ac
index 8d1ff86..954059e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -251,6 +251,7 @@ AS_IF([test "x$lttng_ust_support" = "xyes"], [
 	)
 ])
 AM_CONDITIONAL([HAVE_LIBLTTNG_UST_CTL], [test "x$lttng_ust_ctl_found" = xyes])
+AM_CONDITIONAL([HAVE_LTTNG_UST], [test "x$lttng_ust_support" = xyes])
 AC_CHECK_FUNCS([sched_getcpu sysconf sync_file_range])
 
 # check for dlopen
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 2f1f1c3..b52d91b 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -2,14 +2,21 @@ SUBDIRS = utils regression unit stress
 
 installcheck-am:
 	./run.sh unit_tests
+
+if HAVE_LTTNG_UST
 	./run.sh fast_regression
+endif
+
 if USE_PYTHON
 	./run.sh with_bindings_regression
 endif
 
 check-am:
 	./run.sh unit_tests
+if HAVE_LTTNG_UST
 	./run.sh fast_regression
+endif
+
 if USE_PYTHON
 	./run.sh with_bindings_regression
 endif
-- 
1.9.1
