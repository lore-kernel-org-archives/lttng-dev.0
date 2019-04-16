From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu 1/2] Update macros from the autotools
 archive
Date: Tue, 16 Apr 2019 13:47:59 -0400
Message-ID: <20190416174800.16938-1-mjeanson__2486.4218941488$1555436952$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44kCXl0mHPz1Kff
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 13:48:54 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 769EC1D5386
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 13:48:54 -0400 (EDT)
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
 m4/ax_c___attribute__.m4 |  6 ++---
 m4/ax_pthread.m4         |  9 ++++---
 m4/ax_tls.m4             | 57 ++++++++++++++++------------------------
 3 files changed, 30 insertions(+), 42 deletions(-)

diff --git a/m4/ax_c___attribute__.m4 b/m4/ax_c___attribute__.m4
index cf3d62b..6a1ede1 100644
--- a/m4/ax_c___attribute__.m4
+++ b/m4/ax_c___attribute__.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#    http://www.gnu.org/software/autoconf-archive/ax_c___attribute__.html
+#    https://www.gnu.org/software/autoconf-archive/ax_c___attribute__.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -28,7 +28,7 @@
 #   Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <http://www.gnu.org/licenses/>.
+#   with this program. If not, see <https://www.gnu.org/licenses/>.
 #
 #   As a special exception, the respective Autoconf Macro's copyright owner
 #   gives unlimited permission to copy, distribute and modify the configure
@@ -43,7 +43,7 @@
 #   modified version of the Autoconf Macro, you may extend this special
 #   exception to the GPL to apply to your modified version as well.
 
-#serial 8
+#serial 9
 
 AC_DEFUN([AX_C___ATTRIBUTE__], [
   AC_CACHE_CHECK([for __attribute__], [ax_cv___attribute__],
diff --git a/m4/ax_pthread.m4 b/m4/ax_pthread.m4
index 4c4051e..4920e07 100644
--- a/m4/ax_pthread.m4
+++ b/m4/ax_pthread.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#        http://www.gnu.org/software/autoconf-archive/ax_pthread.html
+#        https://www.gnu.org/software/autoconf-archive/ax_pthread.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -67,7 +67,7 @@
 #   Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <http://www.gnu.org/licenses/>.
+#   with this program. If not, see <https://www.gnu.org/licenses/>.
 #
 #   As a special exception, the respective Autoconf Macro's copyright owner
 #   gives unlimited permission to copy, distribute and modify the configure
@@ -82,7 +82,7 @@
 #   modified version of the Autoconf Macro, you may extend this special
 #   exception to the GPL to apply to your modified version as well.
 
-#serial 23
+#serial 25
 
 AU_ALIAS([ACX_PTHREAD], [AX_PTHREAD])
 AC_DEFUN([AX_PTHREAD], [
@@ -438,7 +438,8 @@ if test "x$ax_pthread_ok" = "xyes"; then
         AC_CACHE_CHECK([for PTHREAD_PRIO_INHERIT],
             [ax_cv_PTHREAD_PRIO_INHERIT],
             [AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <pthread.h>]],
-                                             [[int i = PTHREAD_PRIO_INHERIT;]])],
+                                             [[int i = PTHREAD_PRIO_INHERIT;
+                                               return i;]])],
                             [ax_cv_PTHREAD_PRIO_INHERIT=yes],
                             [ax_cv_PTHREAD_PRIO_INHERIT=no])
             ])
diff --git a/m4/ax_tls.m4 b/m4/ax_tls.m4
index 7c86daf..51edee8 100644
--- a/m4/ax_tls.m4
+++ b/m4/ax_tls.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#          http://www.gnu.org/software/autoconf-archive/ax_tls.html
+#          https://www.gnu.org/software/autoconf-archive/ax_tls.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -9,9 +9,9 @@
 # DESCRIPTION
 #
 #   Provides a test for the compiler support of thread local storage (TLS)
-#   extensions. Defines TLS if it is found. Currently knows about GCC/ICC
-#   and MSVC. I think SunPro uses the same as GCC, and Borland apparently
-#   supports either.
+#   extensions. Defines TLS if it is found. Currently knows about C++11,
+#   GCC/ICC, and MSVC. I think SunPro uses the same as GCC, and Borland
+#   apparently supports either.
 #
 # LICENSE
 #
@@ -29,7 +29,7 @@
 #   Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <http://www.gnu.org/licenses/>.
+#   with this program. If not, see <https://www.gnu.org/licenses/>.
 #
 #   As a special exception, the respective Autoconf Macro's copyright owner
 #   gives unlimited permission to copy, distribute and modify the configure
@@ -44,44 +44,31 @@
 #   modified version of the Autoconf Macro, you may extend this special
 #   exception to the GPL to apply to your modified version as well.
 
-#serial 11
-
-#   Define m4_ifblank and m4_ifnblank macros from introduced in
-#   autotools 2.64 m4sugar.m4 if using an earlier autotools.
-
-ifdef([m4_ifblank], [], [
-m4_define([m4_ifblank],
-[m4_if(m4_translit([[$1]],  [ ][	][
-]), [], [$2], [$3])])
-])
-
-
-ifdef([m4_ifnblank], [], [
-m4_define([m4_ifnblank],
-[m4_if(m4_translit([[$1]],  [ ][	][
-]), [], [$3], [$2])])
-])
+#serial 14
 
 AC_DEFUN([AX_TLS], [
-  AC_MSG_CHECKING(for thread local storage (TLS) class)
-  AC_CACHE_VAL(ac_cv_tls, [
-    ax_tls_keywords="__thread __declspec(thread) none"
-    for ax_tls_keyword in $ax_tls_keywords; do
+  AC_MSG_CHECKING([for thread local storage (TLS) class])
+  AC_CACHE_VAL([ac_cv_tls],
+   [for ax_tls_keyword in thread_local _Thread_local __thread '__declspec(thread)' none; do
        AS_CASE([$ax_tls_keyword],
           [none], [ac_cv_tls=none ; break],
-          [AC_TRY_LINK(
-               [$ax_tls_keyword int foo;],
-               [++foo;],
+          [AC_TRY_COMPILE(
+              [#include <stdlib.h>
+               static void
+               foo(void) {
+               static ] $ax_tls_keyword [ int bar;
+               exit(1);
+               }],
+               [],
                [ac_cv_tls=$ax_tls_keyword ; break],
-               [ac_cv_tls=none]
+               ac_cv_tls=none
            )])
     done
   ])
-  AC_MSG_RESULT($ac_cv_tls)
+  AC_MSG_RESULT([$ac_cv_tls])
 
   AS_IF([test "$ac_cv_tls" != "none"],
-    AC_DEFINE_UNQUOTED([TLS], $ac_cv_tls, [If the compiler supports a TLS storage class define it to that here])
-      m4_ifnblank([$1], [$1]),
-    m4_ifnblank([$2], [$2])
-  )
+    [AC_DEFINE_UNQUOTED([TLS],[$ac_cv_tls],[If the compiler supports a TLS storage class define it to that here])
+     m4_ifnblank([$1],[$1])],
+    [m4_ifnblank([$2],[$2])])
 ])
-- 
2.17.1
