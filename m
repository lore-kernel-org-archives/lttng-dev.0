From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH babeltrace] Buid: add version check on flex
Date: Thu,  2 Jul 2015 18:20:25 -0400
Message-ID: <1435875625-21658-1-git-send-email-jonathan.rajotte-julien__21392.2838251621$1435875699$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZAmqj-0006eS-1X
 for lttng-dev@lists.lttng.org; Thu, 02 Jul 2015 18:20:54 -0400
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

This new m4 macro is valid starting from [1].

[1]http://sourceforge.net/p/flex/flex/ci/712c03b38fb35f9d7f16e0fdd27441c3efda0071/tree/

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac               |  4 +++
 m4/ax_prog_flex_version.m4 | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 m4/ax_prog_flex_version.m4

diff --git a/configure.ac b/configure.ac
index 3421cbd..ef2db73 100644
--- a/configure.ac
+++ b/configure.ac
@@ -46,6 +46,10 @@ if test ! -f "$srcdir/formats/ctf/metadata/ctf-lexer.c"; then
                 AC_MSG_ERROR([[flex not found and is required when building from git.
                 Please install flex]])
         fi
+        AC_PATH_PROG([FLEX],[flex])
+        AX_PROG_FLEX_VERSION([2.5.35], [],[
+                AC_MSG_ERROR([[Flex >= 2.5.35 is required when building from git]])
+        ])
 fi
 
 
diff --git a/m4/ax_prog_flex_version.m4 b/m4/ax_prog_flex_version.m4
new file mode 100644
index 0000000..f1ad9ef
--- /dev/null
+++ b/m4/ax_prog_flex_version.m4
@@ -0,0 +1,64 @@
+# SYNOPSIS
+#
+#   AX_PROG_FLEX_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-FALSE])
+#
+# DESCRIPTION
+#
+#   Makes sure that flex version is greater or equal to the version indicated.
+#   If true the shell commands in ACTION-IF-TRUE are executed. If not the shell
+#   commands in commands in ACTION-IF-TRUE are executed. If not the shell
+#   commands in ACTION-IF-FALSE are run. Note if $FLEX is not set (for example
+#   by running AC_CHECK_PROG or AC_PATH_PROG) the macro will fail.
+#
+#   Example:
+#
+#     AC_PATH_PROG([FLEX],[flex])
+#     AX_PROG_FLEX_VERSION([2.5.39],[ ... ],[ ... ])
+#
+#   This will check to make sure that the flex you have is at least
+#   version 2.5.39 or greater.
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
-- 
2.1.4
