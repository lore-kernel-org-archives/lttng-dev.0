From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 4/5] Update the ac_define_dir macro
 from the autoconf archive
Date: Tue, 16 Apr 2019 16:43:47 -0400
Message-ID: <20190416204348.29127-4-mjeanson__18559.2154318996$1555447553$gmane$org@efficios.com>
References: <20190416204348.29127-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44kHQn44PQz1L0x
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 16:44:01 -0400 (EDT)
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

This macro was removed many years ago from the archive because it crosses
the boundary between configure and make time variables. For the moment
update it to the latest released version.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac        |  2 +-
 m4/ac_define_dir.m4 | 34 ----------------------------
 m4/ax_define_dir.m4 | 54 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 35 deletions(-)
 delete mode 100644 m4/ac_define_dir.m4
 create mode 100644 m4/ax_define_dir.m4

diff --git a/configure.ac b/configure.ac
index f0a4d975..dd99855e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -425,7 +425,7 @@ CONFDIR=`eval echo $sysconfdir`
 AC_SUBST(CONFDIR)
 AC_DEFINE_UNQUOTED([CONFIG_LTTNG_SYSTEM_CONFIGDIR],"$CONFDIR", [LTTng system configuration directory.])
 
-AC_DEFINE_DIR([CONFIG_LTTNG_SYSTEM_DATADIR],[datadir], [LTTng system data directory.])
+AX_DEFINE_DIR([CONFIG_LTTNG_SYSTEM_DATADIR], [datadir], [LTTng system data directory.])
 
 # Check libpopt
 PKG_CHECK_MODULES([POPT], [popt],
diff --git a/m4/ac_define_dir.m4 b/m4/ac_define_dir.m4
deleted file mode 100644
index e15cea2c..00000000
--- a/m4/ac_define_dir.m4
+++ /dev/null
@@ -1,34 +0,0 @@
-dnl @synopsis AC_DEFINE_DIR(VARNAME, DIR [, DESCRIPTION])
-dnl
-dnl This macro sets VARNAME to the expansion of the DIR variable,
-dnl taking care of fixing up ${prefix} and such.
-dnl
-dnl VARNAME is then offered as both an output variable and a C
-dnl preprocessor symbol.
-dnl
-dnl Example:
-dnl
-dnl    AC_DEFINE_DIR([DATADIR], [datadir], [Where data are placed to.])
-dnl
-dnl @category Misc
-dnl @author Stepan Kasal <kasal@ucw.cz>
-dnl @author Andreas Schwab <schwab@suse.de>
-dnl @author Guido U. Draheim <guidod@gmx.de>
-dnl @author Alexandre Oliva
-dnl @version 2006-10-13
-dnl @license AllPermissive
-
-AC_DEFUN([AC_DEFINE_DIR], [
-  prefix_NONE=
-  exec_prefix_NONE=
-  test "x$prefix" = xNONE && prefix_NONE=yes && prefix=$ac_default_prefix
-  test "x$exec_prefix" = xNONE && exec_prefix_NONE=yes && exec_prefix=$prefix
-dnl In Autoconf 2.60, ${datadir} refers to ${datarootdir}, which in turn
-dnl refers to ${prefix}.  Thus we have to use `eval' twice.
-  eval ac_define_dir="\"[$]$2\""
-  eval ac_define_dir="\"$ac_define_dir\""
-  AC_SUBST($1, "$ac_define_dir")
-  AC_DEFINE_UNQUOTED($1, "$ac_define_dir", [$3])
-  test "$prefix_NONE" && prefix=NONE
-  test "$exec_prefix_NONE" && exec_prefix=NONE
-])
diff --git a/m4/ax_define_dir.m4 b/m4/ax_define_dir.m4
new file mode 100644
index 00000000..a26ba372
--- /dev/null
+++ b/m4/ax_define_dir.m4
@@ -0,0 +1,54 @@
+# ===========================================================================
+#       http://www.gnu.org/software/autoconf-archive/ax_define_dir.html
+# ===========================================================================
+#
+# OBSOLETE MACRO
+#
+#   Deprecated because it does not comply with the GNU Coding Standards. See
+#   the autoconf manual section "Defining Directories" for alternatives.
+#
+# SYNOPSIS
+#
+#   AX_DEFINE_DIR(VARNAME, DIR [, DESCRIPTION])
+#
+# DESCRIPTION
+#
+#   This macro sets VARNAME to the expansion of the DIR variable, taking
+#   care of fixing up ${prefix} and such.
+#
+#   VARNAME is then offered as both an output variable and a C preprocessor
+#   symbol.
+#
+#   Example:
+#
+#     AX_DEFINE_DIR([DATADIR], [datadir], [Where data are placed to.])
+#
+# LICENSE
+#
+#   Copyright (c) 2008 Stepan Kasal <kasal@ucw.cz>
+#   Copyright (c) 2008 Andreas Schwab <schwab@suse.de>
+#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
+#   Copyright (c) 2008 Alexandre Oliva
+#
+#   Copying and distribution of this file, with or without modification, are
+#   permitted in any medium without royalty provided the copyright notice
+#   and this notice are preserved. This file is offered as-is, without any
+#   warranty.
+
+#serial 8
+
+AU_ALIAS([AC_DEFINE_DIR], [AX_DEFINE_DIR])
+AC_DEFUN([AX_DEFINE_DIR], [
+  prefix_NONE=
+  exec_prefix_NONE=
+  test "x$prefix" = xNONE && prefix_NONE=yes && prefix=$ac_default_prefix
+  test "x$exec_prefix" = xNONE && exec_prefix_NONE=yes && exec_prefix=$prefix
+dnl In Autoconf 2.60, ${datadir} refers to ${datarootdir}, which in turn
+dnl refers to ${prefix}.  Thus we have to use `eval' twice.
+  eval ax_define_dir="\"[$]$2\""
+  eval ax_define_dir="\"$ax_define_dir\""
+  AC_SUBST($1, "$ax_define_dir")
+  AC_DEFINE_UNQUOTED($1, "$ax_define_dir", [$3])
+  test "$prefix_NONE" && prefix=NONE
+  test "$exec_prefix_NONE" && exec_prefix=NONE
+])
-- 
2.17.1
