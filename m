From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu] Harmonize pprint macro across projects
Date: Tue, 16 Apr 2019 16:41:45 -0400
Message-ID: <20190416204145.28437-1-mjeanson__35607.7364807547$1555447329$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44kHNH4CNFz1Kyl
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 16:41:51 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id C0E4D1D7804
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 16:41:50 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 m4/pprint.m4 | 50 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/m4/pprint.m4 b/m4/pprint.m4
index c7024c3..a7cfd94 100644
--- a/m4/pprint.m4
+++ b/m4/pprint.m4
@@ -2,6 +2,8 @@
 #
 # Author: Philippe Proulx <pproulx@efficios.com>
 
+#serial 1
+
 # PPRINT_INIT(): initializes the pretty printing system.
 #
 # Use this macro before using any other PPRINT_* macro.
@@ -15,17 +17,17 @@ AC_DEFUN([PPRINT_INIT], [
   AC_PATH_PROG([pprint_tput], [tput])
 
   AS_IF([test -n "$pprint_tput"], [
-    AS_IF([test -n "$PS1" && test `"$pprint_tput" colors` -ge 8 && test -t 1], [
+    AS_IF([test -n "$PS1" && test `"$pprint_tput" colors` -eq 256 && test -t 1], [
       # interactive shell and colors supported and standard output
       # file descriptor is opened on a terminal
-      PPRINT_COLOR_TXTBLK="`"$pprint_tput" setf 0`"
-      PPRINT_COLOR_TXTBLU="`"$pprint_tput" setf 1`"
-      PPRINT_COLOR_TXTGRN="`"$pprint_tput" setf 2`"
-      PPRINT_COLOR_TXTCYN="`"$pprint_tput" setf 3`"
-      PPRINT_COLOR_TXTRED="`"$pprint_tput" setf 4`"
-      PPRINT_COLOR_TXTPUR="`"$pprint_tput" setf 5`"
-      PPRINT_COLOR_TXTYLW="`"$pprint_tput" setf 6`"
-      PPRINT_COLOR_TXTWHT="`"$pprint_tput" setf 7`"
+      PPRINT_COLOR_TXTBLK="`"$pprint_tput" setaf 0`"
+      PPRINT_COLOR_TXTBLU="`"$pprint_tput" setaf 4`"
+      PPRINT_COLOR_TXTGRN="`"$pprint_tput" setaf 2`"
+      PPRINT_COLOR_TXTCYN="`"$pprint_tput" setaf 6`"
+      PPRINT_COLOR_TXTRED="`"$pprint_tput" setaf 1`"
+      PPRINT_COLOR_TXTPUR="`"$pprint_tput" setaf 5`"
+      PPRINT_COLOR_TXTYLW="`"$pprint_tput" setaf 3`"
+      PPRINT_COLOR_TXTWHT="`"$pprint_tput" setaf 7`"
       PPRINT_COLOR_BLD=`"$pprint_tput" bold`
       PPRINT_COLOR_BLDBLK="$PPRINT_COLOR_BLD$PPRINT_COLOR_TXTBLK"
       PPRINT_COLOR_BLDBLU="$PPRINT_COLOR_BLD$PPRINT_COLOR_TXTBLU"
@@ -148,6 +150,36 @@ AC_DEFUN([PPRINT_PROP_BOOL], [
   m4_popdef([pprint_title])
 ])
 
+# PPRINT_PROP_BOOL_CUSTOM(title, value, no_msg, title_color?): pretty prints a boolean
+# property.
+#
+# The title is put as is in a double-quoted shell string so the user
+# needs to escape ".
+#
+# The value is evaluated at shell runtime. Its evaluation must be
+# 0 (false) or 1 (true).
+#
+# Uses the PPRINT_PROP_STRING() with the "yes" or "no" string.
+#
+# Use PPRINT_INIT() before using this macro.
+AC_DEFUN([PPRINT_PROP_BOOL_CUSTOM], [
+  m4_pushdef([pprint_title], [$1])
+  m4_pushdef([pprint_value], [$2])
+  m4_pushdef([pprint_value_no_msg], [$3])
+
+  test pprint_value -eq 0 && pprint_msg="$PPRINT_NO_MSG (pprint_value_no_msg)" || pprint_msg="$PPRINT_YES_MSG"
+
+  m4_if([$#], [4], [
+    PPRINT_PROP_STRING(pprint_title, [$pprint_msg], $4)
+  ], [
+    PPRINT_PROP_STRING(pprint_title, [$pprint_msg])
+  ])
+
+  m4_popdef([pprint_value_no_msg])
+  m4_popdef([pprint_value])
+  m4_popdef([pprint_title])
+])
+
 # PPRINT_WARN(msg): pretty prints a warning message.
 #
 # The message is put as is in a double-quoted shell string so the user
-- 
2.17.1
