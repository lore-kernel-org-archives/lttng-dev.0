From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 2/5] Namespace check_sdt_works
 custom macro
Date: Tue, 16 Apr 2019 16:43:45 -0400
Message-ID: <20190416204348.29127-2-mjeanson__49345.8238475554$1555447461$gmane$org@efficios.com>
References: <20190416204348.29127-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44kHQm263cz1L0N
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 16:44:00 -0400 (EDT)
In-Reply-To: <20190416204348.29127-1-mjeanson@efficios.com>
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

The ax_ prefix is for macros that are copied from the
Autoconf archive project.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac                |  4 ++--
 m4/ax_check_sdt_works.m4    | 20 ----------------
 m4/lttng_check_sdt_works.m4 | 46 +++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 22 deletions(-)
 delete mode 100644 m4/ax_check_sdt_works.m4
 create mode 100644 m4/lttng_check_sdt_works.m4

diff --git a/configure.ac b/configure.ac
index f11d1b86..f95ccb7e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -25,8 +25,8 @@ AC_PROG_CXX
 rw_PROG_CXX_WORKS
 AM_CONDITIONAL([CXX_WORKS], [test "x$rw_cv_prog_cxx_works" = "xyes"])
 
-ax_CHECK_SDT_WORKS
-AM_CONDITIONAL([SDT_WORKS], [test "x$ax_check_sdt_works" = "xyes"])
+LTTNG_CHECK_SDT_WORKS
+AM_CONDITIONAL([SDT_WORKS], [test "x$lttng_cv_sdt_works" = "xyes"])
 
 # Checks for programs.
 AC_PROG_GREP
diff --git a/m4/ax_check_sdt_works.m4 b/m4/ax_check_sdt_works.m4
deleted file mode 100644
index 49ee6844..00000000
--- a/m4/ax_check_sdt_works.m4
+++ /dev/null
@@ -1,20 +0,0 @@
-# ac_CHECK_SDT_WORKS
-#
-# Check whether it's possible to build a binary with Systemtap SDT probes.
-
-AC_DEFUN([ax_CHECK_SDT_WORKS], [
-AC_COMPILE_IFELSE(
-[AC_LANG_SOURCE([[
-		#define SDT_USE_VARIADIC
-		#include <sys/sdt.h>
-		void fct(void)
-		{
-			STAP_PROBEV(provider,name,1,2,3,4,5,6,7,8,9,10);
-		}
-	]])], [
-		ax_check_sdt_works=yes
-	], [
-		ax_check_sdt_works=no
-	]
-)
-])
diff --git a/m4/lttng_check_sdt_works.m4 b/m4/lttng_check_sdt_works.m4
new file mode 100644
index 00000000..7f2a1ba5
--- /dev/null
+++ b/m4/lttng_check_sdt_works.m4
@@ -0,0 +1,46 @@
+# SYNOPSIS
+#
+#   LTTNG_CHECK_SDT_WORKS([ACTION-SUCCESS], [ACTION-FAILURE])
+#
+# DESCRIPTION
+#
+#   Check whether it's possible to build a binary with Systemtap SDT probes.
+#
+#   ACTION-SUCCESS/ACTION-FAILURE are shell commands to execute on
+#   success/failure.
+#
+# LICENSE
+#
+#   Copyright (c) 2018 Francis Deslauriers <francis.deslauriers@efficios.com>
+#   Copyright (c) 2019 Michael Jeanson <mjeanson@efficios.com>
+#
+#   Copying and distribution of this file, with or without modification, are
+#   permitted in any medium without royalty provided the copyright notice
+#   and this notice are preserved.  This file is offered as-is, without any
+#   warranty.
+
+#serial 1
+
+AC_DEFUN([LTTNG_CHECK_SDT_WORKS], [
+  AC_CACHE_CHECK([whether SDT probes compile], [lttng_cv_sdt_works], [
+    AC_COMPILE_IFELSE([
+      AC_LANG_SOURCE([[
+	#define SDT_USE_VARIADIC
+	#include <sys/sdt.h>
+	void fct(void)
+	{
+		STAP_PROBEV(provider,name,1,2,3,4,5,6,7,8,9,10);
+	}
+      ]])
+    ], [
+      lttng_cv_sdt_works=yes
+    ], [
+      lttng_cv_sdt_works=no
+    ])
+  ])
+  AS_IF([test "x$lttng_cv_sdt_works" = "xyes"], [
+    m4_default([$1], :)
+  ], [
+    m4_default([$2], :)
+  ])
+])
-- 
2.17.1
