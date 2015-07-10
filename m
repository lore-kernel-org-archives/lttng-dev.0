From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH babeltrace] Build: Update m4 for bison & flex
	version check to match autoconf-archive file
Date: Fri, 10 Jul 2015 11:36:45 -0400
Message-ID: <1436542605-22356-1-git-send-email-jonathan.rajotte-julien__37772.4681784914$1436542677$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZDaMJ-0003bI-OR
 for lttng-dev@lists.lttng.org; Fri, 10 Jul 2015 11:37:06 -0400
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

Officials m4 were merged in [1][2].

[1] https://github.com/peti/autoconf-archive/commit/b2bdd8591b2d6b1eb580ead5f978a30e3ecfc36c
[2] https://github.com/peti/autoconf-archive/commit/fd1f2862c1524e73495d67646d26000e2e85e807

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 m4/ax_prog_bison_version.m4 | 21 +++++++++++++--------
 m4/ax_prog_flex_version.m4  | 19 ++++++++++++-------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/m4/ax_prog_bison_version.m4 b/m4/ax_prog_bison_version.m4
index 6b95585..5da478c 100644
--- a/m4/ax_prog_bison_version.m4
+++ b/m4/ax_prog_bison_version.m4
@@ -1,22 +1,27 @@
+# ===========================================================================
+#   http://www.gnu.org/software/autoconf-archive/ax_prog_bison_version.html
+# ===========================================================================
+#
 # SYNOPSIS
 #
 #   AX_PROG_BISON_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-FALSE])
 #
 # DESCRIPTION
 #
-#   Makes sure that bison version is greater or equal to the version indicated.
-#   If true the shell commands in ACTION-IF-TRUE are executed. If not the shell
-#   commands in commands in ACTION-IF-TRUE are executed. If not the shell
-#   commands in ACTION-IF-FALSE are run. Note if $BISON is not set (for example
-#   by running AC_CHECK_PROG or AC_PATH_PROG) the macro will fail.
+#   Makes sure that bison version is greater or equal to the version
+#   indicated. If true the shell commands in ACTION-IF-TRUE are executed. If
+#   not the shell commands in commands in ACTION-IF-TRUE are executed. If
+#   not the shell commands in ACTION-IF-FALSE are run. Note if $BISON is not
+#   set (for example by running AC_CHECK_PROG or AC_PATH_PROG) the macro
+#   will fail.
 #
 #   Example:
 #
 #     AC_PATH_PROG([BISON],[bison])
 #     AX_PROG_BISON_VERSION([3.0.2],[ ... ],[ ... ])
 #
-#   This will check to make sure that the bison you have is at least
-#   version 3.0.2 or greater.
+#   This will check to make sure that the bison you have is at least version
+#   3.0.2 or greater.
 #
 #   NOTE: This macro uses the $BISON variable to perform the check.
 #
@@ -29,7 +34,7 @@
 #   and this notice are preserved. This file is offered as-is, without any
 #   warranty.
 
-#serial 12
+#serial 2
 
 AC_DEFUN([AX_PROG_BISON_VERSION],[
     AC_REQUIRE([AC_PROG_SED])
diff --git a/m4/ax_prog_flex_version.m4 b/m4/ax_prog_flex_version.m4
index f1ad9ef..da60e00 100644
--- a/m4/ax_prog_flex_version.m4
+++ b/m4/ax_prog_flex_version.m4
@@ -1,22 +1,27 @@
+# ===========================================================================
+#   http://www.gnu.org/software/autoconf-archive/ax_prog_flex_version.html
+# ===========================================================================
+#
 # SYNOPSIS
 #
 #   AX_PROG_FLEX_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-FALSE])
 #
 # DESCRIPTION
 #
-#   Makes sure that flex version is greater or equal to the version indicated.
-#   If true the shell commands in ACTION-IF-TRUE are executed. If not the shell
-#   commands in commands in ACTION-IF-TRUE are executed. If not the shell
-#   commands in ACTION-IF-FALSE are run. Note if $FLEX is not set (for example
-#   by running AC_CHECK_PROG or AC_PATH_PROG) the macro will fail.
+#   Makes sure that flex version is greater or equal to the version
+#   indicated. If true the shell commands in ACTION-IF-TRUE are executed. If
+#   not the shell commands in commands in ACTION-IF-TRUE are executed. If
+#   not the shell commands in ACTION-IF-FALSE are run. Note if $FLEX is not
+#   set (for example by running AC_CHECK_PROG or AC_PATH_PROG) the macro
+#   will fail.
 #
 #   Example:
 #
 #     AC_PATH_PROG([FLEX],[flex])
 #     AX_PROG_FLEX_VERSION([2.5.39],[ ... ],[ ... ])
 #
-#   This will check to make sure that the flex you have is at least
-#   version 2.5.39 or greater.
+#   This will check to make sure that the flex you have is at least version
+#   2.5.39 or greater.
 #
 #   NOTE: This macro uses the $FLEX variable to perform the check.
 #
-- 
2.1.4
