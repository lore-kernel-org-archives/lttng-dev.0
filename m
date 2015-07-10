From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/2] Build: add Flex version check
Date: Fri, 10 Jul 2015 17:03:18 -0400
Message-ID: <1436562198-14747-2-git-send-email-jonathan.rajotte-julien__12345.7180023708$1436562290$gmane$org@efficios.com>
References: <1436562198-14747-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZDfSS-0005ER-Qx
 for lttng-dev@lists.lttng.org; Fri, 10 Jul 2015 17:03:49 -0400
In-Reply-To: <1436562198-14747-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 config/ax_prog_flex_version.m4 | 69 ++++++++++++++++++++++++++++++++++++++++++
 configure.ac                   |  4 +++
 2 files changed, 73 insertions(+)
 create mode 100644 config/ax_prog_flex_version.m4

diff --git a/config/ax_prog_flex_version.m4 b/config/ax_prog_flex_version.m4
new file mode 100644
index 0000000..da60e00
--- /dev/null
+++ b/config/ax_prog_flex_version.m4
@@ -0,0 +1,69 @@
+# ===========================================================================
+#   http://www.gnu.org/software/autoconf-archive/ax_prog_flex_version.html
+# ===========================================================================
+#
+# SYNOPSIS
+#
+#   AX_PROG_FLEX_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-FALSE])
+#
+# DESCRIPTION
+#
+#   Makes sure that flex version is greater or equal to the version
+#   indicated. If true the shell commands in ACTION-IF-TRUE are executed. If
+#   not the shell commands in commands in ACTION-IF-TRUE are executed. If
+#   not the shell commands in ACTION-IF-FALSE are run. Note if $FLEX is not
+#   set (for example by running AC_CHECK_PROG or AC_PATH_PROG) the macro
+#   will fail.
+#
+#   Example:
+#
+#     AC_PATH_PROG([FLEX],[flex])
+#     AX_PROG_FLEX_VERSION([2.5.39],[ ... ],[ ... ])
+#
+#   This will check to make sure that the flex you have is at least version
+#   2.5.39 or greater.
+#
+#   NOTE: This macro uses the $FLEX variable to perform the check.
+#
+# LICENSE
+#
+#   Copyright (c) 2015 Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
+#
+#   Copying and distribution of this file, with or without modification, are
+#   permitted in any medium without royalty provided the copyright notice
+#   and this notice are preserved. This file is offered as-is, without any
+#   warranty.
+
+#serial 1
+
+AC_DEFUN([AX_PROG_FLEX_VERSION],[
+    AC_REQUIRE([AC_PROG_SED])
+    AC_REQUIRE([AC_PROG_GREP])
+
+    AS_IF([test -n "$FLEX"],[
+        ax_flex_version="$1"
+
+        AC_MSG_CHECKING([for flex version])
+        changequote(<<,>>)
+        flex_version=`$FLEX --version 2>&1 \
+          | $SED -n -e '/flex /b inspect
+b
+: inspect
+s/.* (\{0,1\}\([0-9]*\.[0-9]*\.[0-9]*\))\{0,1\}.*/\1/;p'`
+        changequote([,])
+        AC_MSG_RESULT($flex_version)
+
+	AC_SUBST([FLEX_VERSION],[$flex_version])
+
+        AX_COMPARE_VERSION([$flex_version],[ge],[$ax_flex_version],[
+	    :
+            $2
+        ],[
+	    :
+            $3
+        ])
+    ],[
+        AC_MSG_WARN([could not find flex])
+        $3
+    ])
+])
diff --git a/configure.ac b/configure.ac
index b274ead..b7af59a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -455,6 +455,10 @@ if test ! -f "$srcdir/src/lib/lttng-ctl/filter/filter-lexer.c"; then
 		AC_MSG_ERROR([[flex not found and is required when building from git.
 		Please install flex]])
 	fi
+	AC_PATH_PROG([FLEX],[flex])
+	AX_PROG_FLEX_VERSION([2.5.35], [],[
+		AC_MSG_ERROR([[Flex >= 2.5.35 is required when building from git]])
+	])
 fi
 
 CFLAGS="-Wall $CFLAGS -g -fno-strict-aliasing"
-- 
2.1.4
