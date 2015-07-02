From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH babeltrace] Build: m4 macro for Bison version
	check
Date: Thu,  2 Jul 2015 15:12:31 -0400
Message-ID: <1435864351-30236-1-git-send-email-jonathan.rajotte-julien__29077.8125556701$1435864444$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZAjuv-0005bE-T1
 for lttng-dev@lists.lttng.org; Thu, 02 Jul 2015 15:13:06 -0400
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

This new m4 macro make check for a supported version of Bison.
This macro is valid starting from commit id
e79137accc7ea0352cd4677ff22818f9c68d4eab of the GNU Bison git tree[1].
This check works for version 1.29b to this day.

[1] http://git.savannah.gnu.org/cgit/bison.git/commit/?id=e79137accc7ea0352cd4677ff22818f9c68d4eab

Fixes: #891
Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac                |   4 +
 m4/ax_compare_version.m4    | 177 ++++++++++++++++++++++++++++++++++++++++++++
 m4/ax_prog_bison_version.m4 |  64 ++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100644 m4/ax_compare_version.m4
 create mode 100644 m4/ax_prog_bison_version.m4

diff --git a/configure.ac b/configure.ac
index f8d43d8..3421cbd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -35,6 +35,10 @@ if test ! -f "$srcdir/formats/ctf/metadata/ctf-parser.h"; then
                 AC_MSG_ERROR([[bison not found and is required when building from git.
                 Please install bison]])
         fi
+        AC_PATH_PROG([BISON],[bison])
+        AX_PROG_BISON_VERSION([2.4], [],[
+                AC_MSG_ERROR([[Bison >= 2.4 is required when building from git]])
+        ])
 fi
 
 if test ! -f "$srcdir/formats/ctf/metadata/ctf-lexer.c"; then
diff --git a/m4/ax_compare_version.m4 b/m4/ax_compare_version.m4
new file mode 100644
index 0000000..74dc0fd
--- /dev/null
+++ b/m4/ax_compare_version.m4
@@ -0,0 +1,177 @@
+# ===========================================================================
+#    http://www.gnu.org/software/autoconf-archive/ax_compare_version.html
+# ===========================================================================
+#
+# SYNOPSIS
+#
+#   AX_COMPARE_VERSION(VERSION_A, OP, VERSION_B, [ACTION-IF-TRUE], [ACTION-IF-FALSE])
+#
+# DESCRIPTION
+#
+#   This macro compares two version strings. Due to the various number of
+#   minor-version numbers that can exist, and the fact that string
+#   comparisons are not compatible with numeric comparisons, this is not
+#   necessarily trivial to do in a autoconf script. This macro makes doing
+#   these comparisons easy.
+#
+#   The six basic comparisons are available, as well as checking equality
+#   limited to a certain number of minor-version levels.
+#
+#   The operator OP determines what type of comparison to do, and can be one
+#   of:
+#
+#    eq  - equal (test A == B)
+#    ne  - not equal (test A != B)
+#    le  - less than or equal (test A <= B)
+#    ge  - greater than or equal (test A >= B)
+#    lt  - less than (test A < B)
+#    gt  - greater than (test A > B)
+#
+#   Additionally, the eq and ne operator can have a number after it to limit
+#   the test to that number of minor versions.
+#
+#    eq0 - equal up to the length of the shorter version
+#    ne0 - not equal up to the length of the shorter version
+#    eqN - equal up to N sub-version levels
+#    neN - not equal up to N sub-version levels
+#
+#   When the condition is true, shell commands ACTION-IF-TRUE are run,
+#   otherwise shell commands ACTION-IF-FALSE are run. The environment
+#   variable 'ax_compare_version' is always set to either 'true' or 'false'
+#   as well.
+#
+#   Examples:
+#
+#     AX_COMPARE_VERSION([3.15.7],[lt],[3.15.8])
+#     AX_COMPARE_VERSION([3.15],[lt],[3.15.8])
+#
+#   would both be true.
+#
+#     AX_COMPARE_VERSION([3.15.7],[eq],[3.15.8])
+#     AX_COMPARE_VERSION([3.15],[gt],[3.15.8])
+#
+#   would both be false.
+#
+#     AX_COMPARE_VERSION([3.15.7],[eq2],[3.15.8])
+#
+#   would be true because it is only comparing two minor versions.
+#
+#     AX_COMPARE_VERSION([3.15.7],[eq0],[3.15])
+#
+#   would be true because it is only comparing the lesser number of minor
+#   versions of the two values.
+#
+#   Note: The characters that separate the version numbers do not matter. An
+#   empty string is the same as version 0. OP is evaluated by autoconf, not
+#   configure, so must be a string, not a variable.
+#
+#   The author would like to acknowledge Guido Draheim whose advice about
+#   the m4_case and m4_ifvaln functions make this macro only include the
+#   portions necessary to perform the specific comparison specified by the
+#   OP argument in the final configure script.
+#
+# LICENSE
+#
+#   Copyright (c) 2008 Tim Toolan <toolan@ele.uri.edu>
+#
+#   Copying and distribution of this file, with or without modification, are
+#   permitted in any medium without royalty provided the copyright notice
+#   and this notice are preserved. This file is offered as-is, without any
+#   warranty.
+
+#serial 11
+
+dnl #########################################################################
+AC_DEFUN([AX_COMPARE_VERSION], [
+  AC_REQUIRE([AC_PROG_AWK])
+
+  # Used to indicate true or false condition
+  ax_compare_version=false
+
+  # Convert the two version strings to be compared into a format that
+  # allows a simple string comparison.  The end result is that a version
+  # string of the form 1.12.5-r617 will be converted to the form
+  # 0001001200050617.  In other words, each number is zero padded to four
+  # digits, and non digits are removed.
+  AS_VAR_PUSHDEF([A],[ax_compare_version_A])
+  A=`echo "$1" | sed -e 's/\([[0-9]]*\)/Z\1Z/g' \
+                     -e 's/Z\([[0-9]]\)Z/Z0\1Z/g' \
+                     -e 's/Z\([[0-9]][[0-9]]\)Z/Z0\1Z/g' \
+                     -e 's/Z\([[0-9]][[0-9]][[0-9]]\)Z/Z0\1Z/g' \
+                     -e 's/[[^0-9]]//g'`
+
+  AS_VAR_PUSHDEF([B],[ax_compare_version_B])
+  B=`echo "$3" | sed -e 's/\([[0-9]]*\)/Z\1Z/g' \
+                     -e 's/Z\([[0-9]]\)Z/Z0\1Z/g' \
+                     -e 's/Z\([[0-9]][[0-9]]\)Z/Z0\1Z/g' \
+                     -e 's/Z\([[0-9]][[0-9]][[0-9]]\)Z/Z0\1Z/g' \
+                     -e 's/[[^0-9]]//g'`
+
+  dnl # In the case of le, ge, lt, and gt, the strings are sorted as necessary
+  dnl # then the first line is used to determine if the condition is true.
+  dnl # The sed right after the echo is to remove any indented white space.
+  m4_case(m4_tolower($2),
+  [lt],[
+    ax_compare_version=`echo "x$A
+x$B" | sed 's/^ *//' | sort -r | sed "s/x${A}/false/;s/x${B}/true/;1q"`
+  ],
+  [gt],[
+    ax_compare_version=`echo "x$A
+x$B" | sed 's/^ *//' | sort | sed "s/x${A}/false/;s/x${B}/true/;1q"`
+  ],
+  [le],[
+    ax_compare_version=`echo "x$A
+x$B" | sed 's/^ *//' | sort | sed "s/x${A}/true/;s/x${B}/false/;1q"`
+  ],
+  [ge],[
+    ax_compare_version=`echo "x$A
+x$B" | sed 's/^ *//' | sort -r | sed "s/x${A}/true/;s/x${B}/false/;1q"`
+  ],[
+    dnl Split the operator from the subversion count if present.
+    m4_bmatch(m4_substr($2,2),
+    [0],[
+      # A count of zero means use the length of the shorter version.
+      # Determine the number of characters in A and B.
+      ax_compare_version_len_A=`echo "$A" | $AWK '{print(length)}'`
+      ax_compare_version_len_B=`echo "$B" | $AWK '{print(length)}'`
+
+      # Set A to no more than B's length and B to no more than A's length.
+      A=`echo "$A" | sed "s/\(.\{$ax_compare_version_len_B\}\).*/\1/"`
+      B=`echo "$B" | sed "s/\(.\{$ax_compare_version_len_A\}\).*/\1/"`
+    ],
+    [[0-9]+],[
+      # A count greater than zero means use only that many subversions
+      A=`echo "$A" | sed "s/\(\([[0-9]]\{4\}\)\{m4_substr($2,2)\}\).*/\1/"`
+      B=`echo "$B" | sed "s/\(\([[0-9]]\{4\}\)\{m4_substr($2,2)\}\).*/\1/"`
+    ],
+    [.+],[
+      AC_WARNING(
+        [illegal OP numeric parameter: $2])
+    ],[])
+
+    # Pad zeros at end of numbers to make same length.
+    ax_compare_version_tmp_A="$A`echo $B | sed 's/./0/g'`"
+    B="$B`echo $A | sed 's/./0/g'`"
+    A="$ax_compare_version_tmp_A"
+
+    # Check for equality or inequality as necessary.
+    m4_case(m4_tolower(m4_substr($2,0,2)),
+    [eq],[
+      test "x$A" = "x$B" && ax_compare_version=true
+    ],
+    [ne],[
+      test "x$A" != "x$B" && ax_compare_version=true
+    ],[
+      AC_WARNING([illegal OP parameter: $2])
+    ])
+  ])
+
+  AS_VAR_POPDEF([A])dnl
+  AS_VAR_POPDEF([B])dnl
+
+  dnl # Execute ACTION-IF-TRUE / ACTION-IF-FALSE.
+  if test "$ax_compare_version" = "true" ; then
+    m4_ifvaln([$4],[$4],[:])dnl
+    m4_ifvaln([$5],[else $5])dnl
+  fi
+]) dnl AX_COMPARE_VERSION
diff --git a/m4/ax_prog_bison_version.m4 b/m4/ax_prog_bison_version.m4
new file mode 100644
index 0000000..6b95585
--- /dev/null
+++ b/m4/ax_prog_bison_version.m4
@@ -0,0 +1,64 @@
+# SYNOPSIS
+#
+#   AX_PROG_BISON_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-FALSE])
+#
+# DESCRIPTION
+#
+#   Makes sure that bison version is greater or equal to the version indicated.
+#   If true the shell commands in ACTION-IF-TRUE are executed. If not the shell
+#   commands in commands in ACTION-IF-TRUE are executed. If not the shell
+#   commands in ACTION-IF-FALSE are run. Note if $BISON is not set (for example
+#   by running AC_CHECK_PROG or AC_PATH_PROG) the macro will fail.
+#
+#   Example:
+#
+#     AC_PATH_PROG([BISON],[bison])
+#     AX_PROG_BISON_VERSION([3.0.2],[ ... ],[ ... ])
+#
+#   This will check to make sure that the bison you have is at least
+#   version 3.0.2 or greater.
+#
+#   NOTE: This macro uses the $BISON variable to perform the check.
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
+#serial 12
+
+AC_DEFUN([AX_PROG_BISON_VERSION],[
+    AC_REQUIRE([AC_PROG_SED])
+    AC_REQUIRE([AC_PROG_GREP])
+
+    AS_IF([test -n "$BISON"],[
+        ax_bison_version="$1"
+
+        AC_MSG_CHECKING([for bison version])
+        changequote(<<,>>)
+        bison_version=`$BISON --version 2>&1 \
+          | $SED -n -e '/bison (GNU Bison)/b inspect
+b
+: inspect
+s/.* (\{0,1\}\([0-9]*\.[0-9]*\.[0-9]*\))\{0,1\}.*/\1/;p'`
+        changequote([,])
+        AC_MSG_RESULT($bison_version)
+
+	AC_SUBST([BISON_VERSION],[$bison_version])
+
+        AX_COMPARE_VERSION([$bison_version],[ge],[$ax_bison_version],[
+	    :
+            $2
+        ],[
+	    :
+            $3
+        ])
+    ],[
+        AC_MSG_WARN([could not find bison])
+        $3
+    ])
+])
-- 
2.1.4
