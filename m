From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust 2/2] Harmonize rw_prog_cxx_works macro
 across projects
Date: Tue, 16 Apr 2019 16:17:31 -0400
Message-ID: <20190416201731.27244-2-mjeanson__26707.1555413835$1555445912$gmane$org@efficios.com>
References: <20190416201731.27244-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44kGrR0Wj0z1KwQ
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 16:17:43 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id AFD301D72A8
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 16:17:42 -0400 (EDT)
In-Reply-To: <20190416201731.27244-1-mjeanson@efficios.com>
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac            |  2 +-
 m4/rw_prog_cxx_works.m4 | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 3e443132..52fc3f68 100644
--- a/configure.ac
+++ b/configure.ac
@@ -55,7 +55,7 @@ AC_SYS_LARGEFILE
 AC_PROG_CC
 AC_PROG_CC_STDC
 AC_PROG_CXX
-rw_PROG_CXX_WORKS
+RW_PROG_CXX_WORKS
 AM_CONDITIONAL([CXX_WORKS], [test "x$rw_cv_prog_cxx_works" = "xyes"])
 
 # Check if the compiler support weak symbols
diff --git a/m4/rw_prog_cxx_works.m4 b/m4/rw_prog_cxx_works.m4
index 086af254..f3d6bde6 100644
--- a/m4/rw_prog_cxx_works.m4
+++ b/m4/rw_prog_cxx_works.m4
@@ -1,11 +1,25 @@
-# rw_PROG_CXX_WORKS
+# SYNOPSIS
 #
-# Check whether the C++ compiler works. There's a bit of oversight in
-# autoconf that will set the C++ compiler to g++ if no compiler is found,
-# even if g++ is not present! So we need an extra test to make sure that
-# the compiler works.
+#   RW_PROG_CXX_WORKS
 #
-AC_DEFUN([rw_PROG_CXX_WORKS], [
+# DESCRIPTION
+#
+#   RW_PROG_CXX_WORKS checks whether the C++ compiler works.
+#
+#   There's a bit of oversight in autoconf that will set the C++ compiler to
+#   g++ if no compiler is found, even if g++ is not present! So we need an
+#   extra test to make sure that the compiler works.
+#
+# LICENSE
+#
+#   Copying and distribution of this file, with or without modification, are
+#   permitted in any medium without royalty provided the copyright notice
+#   and this notice are preserved. This file is offered as-is, without any
+#   warranty.
+
+#serial 1
+
+AC_DEFUN([RW_PROG_CXX_WORKS], [
 AC_REQUIRE([AC_PROG_CXX])
 AC_CACHE_CHECK([whether the C++ compiler works],
 	[rw_cv_prog_cxx_works],
-- 
2.17.1
