From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 1/5] Update macros from the autoconf
 archive
Date: Tue, 16 Apr 2019 16:43:44 -0400
Message-ID: <20190416204348.29127-1-mjeanson__22724.5755771705$1555447500$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44kHQm6pQkz1L0V
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 16:44:00 -0400 (EDT)
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 m4/ax_c___attribute__.m4                      |   6 +-
 m4/ax_check_class.m4                          |  75 +---
 m4/ax_check_classpath.m4                      |   6 +-
 m4/ax_check_link_flag.m4                      |  31 +-
 m4/ax_check_rqrd_class.m4                     |   6 +-
 m4/ax_compare_version.m4                      |   8 +-
 ...config_feature.m4 => ax_config_feature.m4} |   7 +-
 m4/{epoll.m4 => ax_have_epoll.m4}             |   5 +-
 m4/ax_java_options.m4                         |   4 +-
 m4/ax_jni_include_dir.m4                      |  57 ++-
 m4/ax_lib_socket_nsl.m4                       |   4 +-
 m4/ax_pkg_swig.m4                             |  14 +-
 m4/ax_prog_bison_version.m4                   |   4 +-
 m4/ax_prog_flex_version.m4                    |   4 +-
 m4/ax_prog_jar.m4                             |   4 +-
 m4/ax_prog_java.m4                            |   6 +-
 m4/ax_prog_java_works.m4                      |  51 +--
 m4/ax_prog_javac.m4                           |   6 +-
 m4/ax_prog_javac_works.m4                     |   6 +-
 m4/ax_prog_javah.m4                           |  35 +-
 m4/ax_pthread.m4                              | 390 ++++++++++++------
 m4/ax_try_compile_java.m4                     |   8 +-
 m4/ax_try_run_java.m4                         |   4 +-
 23 files changed, 403 insertions(+), 338 deletions(-)
 rename m4/{config_feature.m4 => ax_config_feature.m4} (97%)
 rename m4/{epoll.m4 => ax_have_epoll.m4} (97%)

diff --git a/m4/ax_c___attribute__.m4 b/m4/ax_c___attribute__.m4
index cf3d62bb..6a1ede15 100644
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
diff --git a/m4/ax_check_class.m4 b/m4/ax_check_class.m4
index 42b51d72..e673c2d3 100644
--- a/m4/ax_check_class.m4
+++ b/m4/ax_check_class.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#      http://www.gnu.org/software/autoconf-archive/ax_check_class.html
+#      https://www.gnu.org/software/autoconf-archive/ax_check_class.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -36,7 +36,7 @@
 #   Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <http://www.gnu.org/licenses/>.
+#   with this program. If not, see <https://www.gnu.org/licenses/>.
 #
 #   As a special exception, the respective Autoconf Macro's copyright owner
 #   gives unlimited permission to copy, distribute and modify the configure
@@ -51,83 +51,18 @@
 #   modified version of the Autoconf Macro, you may extend this special
 #   exception to the GPL to apply to your modified version as well.
 
-#serial 7
+#serial 12
 
 AU_ALIAS([AC_CHECK_CLASS], [AX_CHECK_CLASS])
 AC_DEFUN([AX_CHECK_CLASS],[
 AC_REQUIRE([AX_PROG_JAVA])
 ac_var_name=`echo $1 | sed 's/\./_/g'`
-dnl Normaly I'd use a AC_CACHE_CHECK here but since the variable name is
+dnl Normally I'd use a AC_CACHE_CHECK here but since the variable name is
 dnl dynamic I need an extra level of extraction
 AC_MSG_CHECKING([for $1 class])
 AC_CACHE_VAL(ax_cv_class_$ac_var_name, [
-if test x$ac_cv_prog_uudecode_base64 = xyes; then
-dnl /**
-dnl  * Test.java: used to test dynamicaly if a class exists.
-dnl  */
-dnl public class Test
-dnl {
-dnl
-dnl public static void
-dnl main( String[] argv )
-dnl {
-dnl     Class lib;
-dnl     if (argv.length < 1)
-dnl      {
-dnl             System.err.println ("Missing argument");
-dnl             System.exit (77);
-dnl      }
-dnl     try
-dnl      {
-dnl             lib = Class.forName (argv[0]);
-dnl      }
-dnl     catch (ClassNotFoundException e)
-dnl      {
-dnl             System.exit (1);
-dnl      }
-dnl     lib = null;
-dnl     System.exit (0);
-dnl }
-dnl
-dnl }
-cat << \EOF > Test.uue
-begin-base64 644 Test.class
-yv66vgADAC0AKQcAAgEABFRlc3QHAAQBABBqYXZhL2xhbmcvT2JqZWN0AQAE
-bWFpbgEAFihbTGphdmEvbGFuZy9TdHJpbmc7KVYBAARDb2RlAQAPTGluZU51
-bWJlclRhYmxlDAAKAAsBAANlcnIBABVMamF2YS9pby9QcmludFN0cmVhbTsJ
-AA0ACQcADgEAEGphdmEvbGFuZy9TeXN0ZW0IABABABBNaXNzaW5nIGFyZ3Vt
-ZW50DAASABMBAAdwcmludGxuAQAVKExqYXZhL2xhbmcvU3RyaW5nOylWCgAV
-ABEHABYBABNqYXZhL2lvL1ByaW50U3RyZWFtDAAYABkBAARleGl0AQAEKEkp
-VgoADQAXDAAcAB0BAAdmb3JOYW1lAQAlKExqYXZhL2xhbmcvU3RyaW5nOylM
-amF2YS9sYW5nL0NsYXNzOwoAHwAbBwAgAQAPamF2YS9sYW5nL0NsYXNzBwAi
-AQAgamF2YS9sYW5nL0NsYXNzTm90Rm91bmRFeGNlcHRpb24BAAY8aW5pdD4B
-AAMoKVYMACMAJAoAAwAlAQAKU291cmNlRmlsZQEACVRlc3QuamF2YQAhAAEA
-AwAAAAAAAgAJAAUABgABAAcAAABtAAMAAwAAACkqvgSiABCyAAwSD7YAFBBN
-uAAaKgMyuAAeTKcACE0EuAAaAUwDuAAasQABABMAGgAdACEAAQAIAAAAKgAK
-AAAACgAAAAsABgANAA4ADgATABAAEwASAB4AFgAiABgAJAAZACgAGgABACMA
-JAABAAcAAAAhAAEAAQAAAAUqtwAmsQAAAAEACAAAAAoAAgAAAAQABAAEAAEA
-JwAAAAIAKA==
-====
-EOF
-                if $UUDECODE Test.uue; then
-                        :
-                else
-                        echo "configure: __oline__: uudecode had trouble decoding base 64 file 'Test.uue'" >&AS_MESSAGE_LOG_FD
-                        echo "configure: failed file was:" >&AS_MESSAGE_LOG_FD
-                        cat Test.uue >&AS_MESSAGE_LOG_FD
-                        ac_cv_prog_uudecode_base64=no
-                fi
-        rm -f Test.uue
-        if AC_TRY_COMMAND($JAVA -classpath ".:$CLASSPATH" $JAVAFLAGS Test $1) >/dev/null 2>&1; then
-                eval "ac_cv_class_$ac_var_name=yes"
-        else
-                eval "ac_cv_class_$ac_var_name=no"
-        fi
-        rm -f Test.class
-else
         AX_TRY_COMPILE_JAVA([$1], , [eval "ac_cv_class_$ac_var_name=yes"],
                 [eval "ac_cv_class_$ac_var_name=no"])
-fi
 eval "ac_var_val=$`eval echo ac_cv_class_$ac_var_name`"
 eval "HAVE_$ac_var_name=$`echo ac_cv_class_$ac_var_val`"
 HAVE_LAST_CLASS=$ac_var_val
@@ -137,7 +72,7 @@ else
         ifelse([$3], , :, [$3])
 fi
 ])
-dnl for some reason the above statment didn't fall though here?
+dnl for some reason the above statement didn't fall though here?
 dnl do scripts have variable scoping?
 eval "ac_var_val=$`eval echo ac_cv_class_$ac_var_name`"
 AC_MSG_RESULT($ac_var_val)
diff --git a/m4/ax_check_classpath.m4 b/m4/ax_check_classpath.m4
index 3c9081a0..e08a253d 100644
--- a/m4/ax_check_classpath.m4
+++ b/m4/ax_check_classpath.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#    http://www.gnu.org/software/autoconf-archive/ax_check_classpath.html
+#    https://www.gnu.org/software/autoconf-archive/ax_check_classpath.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -33,7 +33,7 @@
 #   Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <http://www.gnu.org/licenses/>.
+#   with this program. If not, see <https://www.gnu.org/licenses/>.
 #
 #   As a special exception, the respective Autoconf Macro's copyright owner
 #   gives unlimited permission to copy, distribute and modify the configure
@@ -48,7 +48,7 @@
 #   modified version of the Autoconf Macro, you may extend this special
 #   exception to the GPL to apply to your modified version as well.
 
-#serial 5
+#serial 6
 
 AU_ALIAS([AC_CHECK_CLASSPATH], [AX_CHECK_CLASSPATH])
 AC_DEFUN([AX_CHECK_CLASSPATH],[
diff --git a/m4/ax_check_link_flag.m4 b/m4/ax_check_link_flag.m4
index 819409a2..03a30ce4 100644
--- a/m4/ax_check_link_flag.m4
+++ b/m4/ax_check_link_flag.m4
@@ -29,33 +29,12 @@
 #   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
 #   Copyright (c) 2011 Maarten Bosmans <mkbosmans@gmail.com>
 #
-#   This program is free software: you can redistribute it and/or modify it
-#   under the terms of the GNU General Public License as published by the
-#   Free Software Foundation, either version 3 of the License, or (at your
-#   option) any later version.
-#
-#   This program is distributed in the hope that it will be useful, but
-#   WITHOUT ANY WARRANTY; without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
-#   Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <https://www.gnu.org/licenses/>.
-#
-#   As a special exception, the respective Autoconf Macro's copyright owner
-#   gives unlimited permission to copy, distribute and modify the configure
-#   scripts that are the output of Autoconf when processing the Macro. You
-#   need not follow the terms of the GNU General Public License when using
-#   or distributing such scripts, even though portions of the text of the
-#   Macro appear in them. The GNU General Public License (GPL) does govern
-#   all other use of the material that constitutes the Autoconf Macro.
-#
-#   This special exception to the GPL applies to versions of the Autoconf
-#   Macro released by the Autoconf Archive. When you make and distribute a
-#   modified version of the Autoconf Macro, you may extend this special
-#   exception to the GPL to apply to your modified version as well.
+#   Copying and distribution of this file, with or without modification, are
+#   permitted in any medium without royalty provided the copyright notice
+#   and this notice are preserved.  This file is offered as-is, without any
+#   warranty.
 
-#serial 5
+#serial 6
 
 AC_DEFUN([AX_CHECK_LINK_FLAG],
 [AC_PREREQ(2.64)dnl for _AC_LANG_PREFIX and AS_VAR_IF
diff --git a/m4/ax_check_rqrd_class.m4 b/m4/ax_check_rqrd_class.m4
index 8f14241b..baa041ac 100644
--- a/m4/ax_check_rqrd_class.m4
+++ b/m4/ax_check_rqrd_class.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#    http://www.gnu.org/software/autoconf-archive/ax_check_rqrd_class.html
+#   https://www.gnu.org/software/autoconf-archive/ax_check_rqrd_class.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -35,7 +35,7 @@
 #   Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <http://www.gnu.org/licenses/>.
+#   with this program. If not, see <https://www.gnu.org/licenses/>.
 #
 #   As a special exception, the respective Autoconf Macro's copyright owner
 #   gives unlimited permission to copy, distribute and modify the configure
@@ -50,7 +50,7 @@
 #   modified version of the Autoconf Macro, you may extend this special
 #   exception to the GPL to apply to your modified version as well.
 
-#serial 5
+#serial 6
 
 AU_ALIAS([AC_CHECK_RQRD_CLASS], [AX_CHECK_RQRD_CLASS])
 AC_DEFUN([AX_CHECK_RQRD_CLASS],[
diff --git a/m4/ax_compare_version.m4 b/m4/ax_compare_version.m4
index 74dc0fdd..ffb4997e 100644
--- a/m4/ax_compare_version.m4
+++ b/m4/ax_compare_version.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#    http://www.gnu.org/software/autoconf-archive/ax_compare_version.html
+#    https://www.gnu.org/software/autoconf-archive/ax_compare_version.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -79,7 +79,7 @@
 #   and this notice are preserved. This file is offered as-is, without any
 #   warranty.
 
-#serial 11
+#serial 13
 
 dnl #########################################################################
 AC_DEFUN([AX_COMPARE_VERSION], [
@@ -146,7 +146,7 @@ x$B" | sed 's/^ *//' | sort -r | sed "s/x${A}/true/;s/x${B}/false/;1q"`
     ],
     [.+],[
       AC_WARNING(
-        [illegal OP numeric parameter: $2])
+        [invalid OP numeric parameter: $2])
     ],[])
 
     # Pad zeros at end of numbers to make same length.
@@ -162,7 +162,7 @@ x$B" | sed 's/^ *//' | sort -r | sed "s/x${A}/true/;s/x${B}/false/;1q"`
     [ne],[
       test "x$A" != "x$B" && ax_compare_version=true
     ],[
-      AC_WARNING([illegal OP parameter: $2])
+      AC_WARNING([invalid OP parameter: $2])
     ])
   ])
 
diff --git a/m4/config_feature.m4 b/m4/ax_config_feature.m4
similarity index 97%
rename from m4/config_feature.m4
rename to m4/ax_config_feature.m4
index db229f24..3c2f2ef2 100644
--- a/m4/config_feature.m4
+++ b/m4/ax_config_feature.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#     http://www.gnu.org/software/autoconf-archive/ax_config_feature.html
+#    https://www.gnu.org/software/autoconf-archive/ax_config_feature.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -73,7 +73,7 @@
 #   Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <http://www.gnu.org/licenses/>.
+#   with this program. If not, see <https://www.gnu.org/licenses/>.
 #
 #   As a special exception, the respective Autoconf Macro's copyright owner
 #   gives unlimited permission to copy, distribute and modify the configure
@@ -88,7 +88,7 @@
 #   modified version of the Autoconf Macro, you may extend this special
 #   exception to the GPL to apply to your modified version as well.
 
-#serial 10
+#serial 11
 
 AC_DEFUN([AX_CONFIG_FEATURE],[ dnl
 m4_pushdef([FEATURE], patsubst([$1], -, _))dnl
@@ -154,4 +154,3 @@ dnl Feature specific
 AC_DEFUN([AX_CONFIG_FEATURE_DISABLE],[ dnl
   ax_config_feature_[]patsubst([$1], -, _)[]=no
 ])
-
diff --git a/m4/epoll.m4 b/m4/ax_have_epoll.m4
similarity index 97%
rename from m4/epoll.m4
rename to m4/ax_have_epoll.m4
index 6508a201..9d9bc873 100644
--- a/m4/epoll.m4
+++ b/m4/ax_have_epoll.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#       http://www.gnu.org/software/autoconf-archive/ax_have_epoll.html
+#      https://www.gnu.org/software/autoconf-archive/ax_have_epoll.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -42,7 +42,7 @@
 #   and this notice are preserved. This file is offered as-is, without any
 #   warranty.
 
-#serial 10
+#serial 11
 
 AC_DEFUN([AX_HAVE_EPOLL], [dnl
   ax_have_epoll_cppflags="${CPPFLAGS}"
@@ -102,4 +102,3 @@ rc = epoll_pwait(fd, &ev, 1, 0, (sigset_t const *)(0));])],
 $1],[AC_MSG_RESULT([no])
 $2])
 ])dnl
-
diff --git a/m4/ax_java_options.m4 b/m4/ax_java_options.m4
index 36c10d92..722d7880 100644
--- a/m4/ax_java_options.m4
+++ b/m4/ax_java_options.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#      http://www.gnu.org/software/autoconf-archive/ax_java_options.html
+#     https://www.gnu.org/software/autoconf-archive/ax_java_options.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -27,7 +27,7 @@
 #   and this notice are preserved. This file is offered as-is, without any
 #   warranty.
 
-#serial 6
+#serial 7
 
 AU_ALIAS([AC_JAVA_OPTIONS], [AX_JAVA_OPTIONS])
 AC_DEFUN([AX_JAVA_OPTIONS],[
diff --git a/m4/ax_jni_include_dir.m4 b/m4/ax_jni_include_dir.m4
index b664d80b..ae7a5f04 100644
--- a/m4/ax_jni_include_dir.m4
+++ b/m4/ax_jni_include_dir.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#    http://www.gnu.org/software/autoconf-archive/ax_jni_include_dir.html
+#    https://www.gnu.org/software/autoconf-archive/ax_jni_include_dir.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -32,6 +32,10 @@
 #
 #   - at the configure level, setenv JAVAC
 #
+#   This macro depends on AC_CANONICAL_HOST which requires that config.guess
+#   and config.sub be distributed along with the source code.  See autoconf
+#   manual for details.
+#
 #   Note: This macro can work with the autoconf M4 macros for Java programs.
 #   This particular macro is not part of the original set of macros.
 #
@@ -44,11 +48,13 @@
 #   and this notice are preserved. This file is offered as-is, without any
 #   warranty.
 
-#serial 10
+#serial 15
 
 AU_ALIAS([AC_JNI_INCLUDE_DIR], [AX_JNI_INCLUDE_DIR])
 AC_DEFUN([AX_JNI_INCLUDE_DIR],[
 
+AC_REQUIRE([AC_CANONICAL_HOST])
+
 JNI_INCLUDE_DIRS=""
 
 if test "x$JAVA_HOME" != x; then
@@ -66,9 +72,17 @@ else
 fi
 
 case "$host_os" in
-        darwin*)        _JTOPDIR=`echo "$_JTOPDIR" | sed -e 's:/[[^/]]*$::'`
-                        _JINC="$_JTOPDIR/Headers";;
-        *)              _JINC="$_JTOPDIR/include";;
+        darwin*)        # Apple Java headers are inside the Xcode bundle.
+            macos_version=$(sw_vers -productVersion | sed -n -e 's/^@<:@0-9@:>@*.\(@<:@0-9@:>@*\).@<:@0-9@:>@*/\1/p')
+            if @<:@ "$macos_version" -gt "7" @:>@; then
+                _JTOPDIR="$(xcrun --show-sdk-path)/System/Library/Frameworks/JavaVM.framework"
+                _JINC="$_JTOPDIR/Headers"
+            else
+                _JTOPDIR="/System/Library/Frameworks/JavaVM.framework"
+                _JINC="$_JTOPDIR/Headers"
+            fi
+            ;;
+        *) _JINC="$_JTOPDIR/include";;
 esac
 _AS_ECHO_LOG([_JTOPDIR=$_JTOPDIR])
 _AS_ECHO_LOG([_JINC=$_JINC])
@@ -76,18 +90,27 @@ _AS_ECHO_LOG([_JINC=$_JINC])
 # On Mac OS X 10.6.4, jni.h is a symlink:
 # /System/Library/Frameworks/JavaVM.framework/Versions/Current/Headers/jni.h
 # -> ../../CurrentJDK/Headers/jni.h.
-AC_CHECK_FILE([$_JINC/jni.h],
-	[JNI_INCLUDE_DIRS="$JNI_INCLUDE_DIRS $_JINC"],
-	[_JTOPDIR=`echo "$_JTOPDIR" | sed -e 's:/[[^/]]*$::'`
-	 AC_CHECK_FILE([$_JTOPDIR/include/jni.h],
-		[JNI_INCLUDE_DIRS="$JNI_INCLUDE_DIRS $_JTOPDIR/include"],
-                AC_MSG_ERROR([cannot find JDK header files]))
-	])
+AC_CACHE_CHECK(jni headers, ac_cv_jni_header_path,
+[
+  if test -f "$_JINC/jni.h"; then
+    ac_cv_jni_header_path="$_JINC"
+    JNI_INCLUDE_DIRS="$JNI_INCLUDE_DIRS $ac_cv_jni_header_path"
+  else
+    _JTOPDIR=`echo "$_JTOPDIR" | sed -e 's:/[[^/]]*$::'`
+    if test -f "$_JTOPDIR/include/jni.h"; then
+      ac_cv_jni_header_path="$_JTOPDIR/include"
+      JNI_INCLUDE_DIRS="$JNI_INCLUDE_DIRS $ac_cv_jni_header_path"
+    else
+      ac_cv_jni_header_path=none
+    fi
+  fi
+])
 
 # get the likely subdirectories for system specific java includes
 case "$host_os" in
 bsdi*)          _JNI_INC_SUBDIRS="bsdos";;
 freebsd*)       _JNI_INC_SUBDIRS="freebsd";;
+darwin*)        _JNI_INC_SUBDIRS="darwin";;
 linux*)         _JNI_INC_SUBDIRS="linux genunix";;
 osf*)           _JNI_INC_SUBDIRS="alpha";;
 solaris*)       _JNI_INC_SUBDIRS="solaris";;
@@ -96,13 +119,15 @@ cygwin*)	_JNI_INC_SUBDIRS="win32";;
 *)              _JNI_INC_SUBDIRS="genunix";;
 esac
 
-# add any subdirectories that are present
-for JINCSUBDIR in $_JNI_INC_SUBDIRS
-do
+if test "x$ac_cv_jni_header_path" != "xnone"; then
+  # add any subdirectories that are present
+  for JINCSUBDIR in $_JNI_INC_SUBDIRS
+  do
     if test -d "$_JTOPDIR/include/$JINCSUBDIR"; then
          JNI_INCLUDE_DIRS="$JNI_INCLUDE_DIRS $_JTOPDIR/include/$JINCSUBDIR"
     fi
-done
+  done
+fi
 ])
 
 # _ACJNI_FOLLOW_SYMLINKS <path>
diff --git a/m4/ax_lib_socket_nsl.m4 b/m4/ax_lib_socket_nsl.m4
index 058e9751..54cad68b 100644
--- a/m4/ax_lib_socket_nsl.m4
+++ b/m4/ax_lib_socket_nsl.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#     http://www.gnu.org/software/autoconf-archive/ax_lib_socket_nsl.html
+#    https://www.gnu.org/software/autoconf-archive/ax_lib_socket_nsl.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -28,7 +28,7 @@
 #   and this notice are preserved. This file is offered as-is, without any
 #   warranty.
 
-#serial 6
+#serial 7
 
 AU_ALIAS([LIB_SOCKET_NSL], [AX_LIB_SOCKET_NSL])
 AC_DEFUN([AX_LIB_SOCKET_NSL],
diff --git a/m4/ax_pkg_swig.m4 b/m4/ax_pkg_swig.m4
index e112f3d3..1d467de3 100644
--- a/m4/ax_pkg_swig.m4
+++ b/m4/ax_pkg_swig.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#        http://www.gnu.org/software/autoconf-archive/ax_pkg_swig.html
+#       https://www.gnu.org/software/autoconf-archive/ax_pkg_swig.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -32,9 +32,9 @@
 # LICENSE
 #
 #   Copyright (c) 2008 Sebastian Huber <sebastian-huber@web.de>
-#   Copyright (c) 2008 Alan W. Irwin <irwin@beluga.phys.uvic.ca>
+#   Copyright (c) 2008 Alan W. Irwin
 #   Copyright (c) 2008 Rafael Laboissiere <rafael@laboissiere.net>
-#   Copyright (c) 2008 Andrew Collier <colliera@ukzn.ac.za>
+#   Copyright (c) 2008 Andrew Collier
 #   Copyright (c) 2011 Murray Cumming <murrayc@openismus.com>
 #
 #   This program is free software; you can redistribute it and/or modify it
@@ -48,7 +48,7 @@
 #   Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <http://www.gnu.org/licenses/>.
+#   with this program. If not, see <https://www.gnu.org/licenses/>.
 #
 #   As a special exception, the respective Autoconf Macro's copyright owner
 #   gives unlimited permission to copy, distribute and modify the configure
@@ -63,11 +63,11 @@
 #   modified version of the Autoconf Macro, you may extend this special
 #   exception to the GPL to apply to your modified version as well.
 
-#serial 8
+#serial 13
 
 AC_DEFUN([AX_PKG_SWIG],[
-        # Ubuntu has swig 2.0 as /usr/bin/swig2.0
-        AC_PATH_PROGS([SWIG],[swig swig2.0])
+        # Find path to the "swig" executable.
+        AC_PATH_PROGS([SWIG],[swig swig3.0 swig2.0])
         if test -z "$SWIG" ; then
                 m4_ifval([$3],[$3],[:])
         elif test -n "$1" ; then
diff --git a/m4/ax_prog_bison_version.m4 b/m4/ax_prog_bison_version.m4
index 5da478c1..4090332a 100644
--- a/m4/ax_prog_bison_version.m4
+++ b/m4/ax_prog_bison_version.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#   http://www.gnu.org/software/autoconf-archive/ax_prog_bison_version.html
+#  https://www.gnu.org/software/autoconf-archive/ax_prog_bison_version.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -34,7 +34,7 @@
 #   and this notice are preserved. This file is offered as-is, without any
 #   warranty.
 
-#serial 2
+#serial 3
 
 AC_DEFUN([AX_PROG_BISON_VERSION],[
     AC_REQUIRE([AC_PROG_SED])
diff --git a/m4/ax_prog_flex_version.m4 b/m4/ax_prog_flex_version.m4
index da60e00f..d518f18e 100644
--- a/m4/ax_prog_flex_version.m4
+++ b/m4/ax_prog_flex_version.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#   http://www.gnu.org/software/autoconf-archive/ax_prog_flex_version.html
+#   https://www.gnu.org/software/autoconf-archive/ax_prog_flex_version.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -34,7 +34,7 @@
 #   and this notice are preserved. This file is offered as-is, without any
 #   warranty.
 
-#serial 1
+#serial 2
 
 AC_DEFUN([AX_PROG_FLEX_VERSION],[
     AC_REQUIRE([AC_PROG_SED])
diff --git a/m4/ax_prog_jar.m4 b/m4/ax_prog_jar.m4
index 3c60fcaf..d474912a 100644
--- a/m4/ax_prog_jar.m4
+++ b/m4/ax_prog_jar.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#        http://www.gnu.org/software/autoconf-archive/ax_prog_jar.html
+#       https://www.gnu.org/software/autoconf-archive/ax_prog_jar.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -37,7 +37,7 @@
 #   and this notice are preserved. This file is offered as-is, without any
 #   warranty.
 
-#serial 7
+#serial 8
 
 AU_ALIAS([AC_PROG_JAR], [AX_PROG_JAR])
 AC_DEFUN([AX_PROG_JAR],[
diff --git a/m4/ax_prog_java.m4 b/m4/ax_prog_java.m4
index 03961db5..c2e6964e 100644
--- a/m4/ax_prog_java.m4
+++ b/m4/ax_prog_java.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#       http://www.gnu.org/software/autoconf-archive/ax_prog_java.html
+#       https://www.gnu.org/software/autoconf-archive/ax_prog_java.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -85,7 +85,7 @@
 #   Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <http://www.gnu.org/licenses/>.
+#   with this program. If not, see <https://www.gnu.org/licenses/>.
 #
 #   As a special exception, the respective Autoconf Macro's copyright owner
 #   gives unlimited permission to copy, distribute and modify the configure
@@ -100,7 +100,7 @@
 #   modified version of the Autoconf Macro, you may extend this special
 #   exception to the GPL to apply to your modified version as well.
 
-#serial 9
+#serial 10
 
 AU_ALIAS([AC_PROG_JAVA], [AX_PROG_JAVA])
 AC_DEFUN([AX_PROG_JAVA],[
diff --git a/m4/ax_prog_java_works.m4 b/m4/ax_prog_java_works.m4
index 54e132af..bc705261 100644
--- a/m4/ax_prog_java_works.m4
+++ b/m4/ax_prog_java_works.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#    http://www.gnu.org/software/autoconf-archive/ax_prog_java_works.html
+#    https://www.gnu.org/software/autoconf-archive/ax_prog_java_works.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -32,7 +32,7 @@
 #   Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <http://www.gnu.org/licenses/>.
+#   with this program. If not, see <https://www.gnu.org/licenses/>.
 #
 #   As a special exception, the respective Autoconf Macro's copyright owner
 #   gives unlimited permission to copy, distribute and modify the configure
@@ -47,57 +47,16 @@
 #   modified version of the Autoconf Macro, you may extend this special
 #   exception to the GPL to apply to your modified version as well.
 
-#serial 9
+#serial 11
 
 AU_ALIAS([AC_PROG_JAVA_WORKS], [AX_PROG_JAVA_WORKS])
 AC_DEFUN([AX_PROG_JAVA_WORKS], [
-AC_PATH_PROG(UUDECODE, uudecode, [no])
-if test x$UUDECODE != xno; then
-AC_CACHE_CHECK([if uudecode can decode base 64 file], ac_cv_prog_uudecode_base64, [
-dnl /**
-dnl  * Test.java: used to test if java compiler works.
-dnl  */
-dnl public class Test
-dnl {
-dnl
-dnl public static void
-dnl main( String[] argv )
-dnl {
-dnl     System.exit (0);
-dnl }
-dnl
-dnl }
-cat << \EOF > Test.uue
-begin-base64 644 Test.class
-yv66vgADAC0AFQcAAgEABFRlc3QHAAQBABBqYXZhL2xhbmcvT2JqZWN0AQAE
-bWFpbgEAFihbTGphdmEvbGFuZy9TdHJpbmc7KVYBAARDb2RlAQAPTGluZU51
-bWJlclRhYmxlDAAKAAsBAARleGl0AQAEKEkpVgoADQAJBwAOAQAQamF2YS9s
-YW5nL1N5c3RlbQEABjxpbml0PgEAAygpVgwADwAQCgADABEBAApTb3VyY2VG
-aWxlAQAJVGVzdC5qYXZhACEAAQADAAAAAAACAAkABQAGAAEABwAAACEAAQAB
-AAAABQO4AAyxAAAAAQAIAAAACgACAAAACgAEAAsAAQAPABAAAQAHAAAAIQAB
-AAEAAAAFKrcAErEAAAABAAgAAAAKAAIAAAAEAAQABAABABMAAAACABQ=
-====
-EOF
-if $UUDECODE Test.uue; then
-        ac_cv_prog_uudecode_base64=yes
-else
-        echo "configure: __oline__: uudecode had trouble decoding base 64 file 'Test.uue'" >&AS_MESSAGE_LOG_FD
-        echo "configure: failed file was:" >&AS_MESSAGE_LOG_FD
-        cat Test.uue >&AS_MESSAGE_LOG_FD
-        ac_cv_prog_uudecode_base64=no
-fi
-rm -f Test.uue])
-fi
-if test x$ac_cv_prog_uudecode_base64 != xyes; then
-        rm -f Test.class
-        AC_MSG_WARN([I have to compile Test.class from scratch])
         if test x$ac_cv_prog_javac_works = xno; then
                 AC_MSG_ERROR([Cannot compile java source. $JAVAC does not work properly])
         fi
         if test x$ac_cv_prog_javac_works = x; then
                 AX_PROG_JAVAC
         fi
-fi
 AC_CACHE_CHECK(if $JAVA works, ac_cv_prog_java_works, [
 JAVA_TEST=Test.java
 CLASS_TEST=Test.class
@@ -111,7 +70,6 @@ public static void main (String args[]) {
 } }
 EOF
 changequote([, ])dnl
-if test x$ac_cv_prog_uudecode_base64 != xyes; then
         if AC_TRY_COMMAND($JAVAC $JAVACFLAGS $JAVA_TEST) && test -s $CLASS_TEST; then
                 :
         else
@@ -119,7 +77,6 @@ if test x$ac_cv_prog_uudecode_base64 != xyes; then
           cat $JAVA_TEST >&AS_MESSAGE_LOG_FD
           AC_MSG_ERROR(The Java compiler $JAVAC failed (see config.log, check the CLASSPATH?))
         fi
-fi
 if AC_TRY_COMMAND($JAVA -classpath . $JAVAFLAGS $TEST) >/dev/null 2>&1; then
   ac_cv_prog_java_works=yes
 else
@@ -127,7 +84,7 @@ else
   cat $JAVA_TEST >&AS_MESSAGE_LOG_FD
   AC_MSG_ERROR(The Java VM $JAVA failed (see config.log, check the CLASSPATH?))
 fi
-rm -fr $JAVA_TEST $CLASS_TEST Test.uue
+rm -f $JAVA_TEST $CLASS_TEST
 ])
 AC_PROVIDE([$0])dnl
 ]
diff --git a/m4/ax_prog_javac.m4 b/m4/ax_prog_javac.m4
index d061243c..8abb733f 100644
--- a/m4/ax_prog_javac.m4
+++ b/m4/ax_prog_javac.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#       http://www.gnu.org/software/autoconf-archive/ax_prog_javac.html
+#      https://www.gnu.org/software/autoconf-archive/ax_prog_javac.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -49,7 +49,7 @@
 #   Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <http://www.gnu.org/licenses/>.
+#   with this program. If not, see <https://www.gnu.org/licenses/>.
 #
 #   As a special exception, the respective Autoconf Macro's copyright owner
 #   gives unlimited permission to copy, distribute and modify the configure
@@ -64,7 +64,7 @@
 #   modified version of the Autoconf Macro, you may extend this special
 #   exception to the GPL to apply to your modified version as well.
 
-#serial 7
+#serial 8
 
 AU_ALIAS([AC_PROG_JAVAC], [AX_PROG_JAVAC])
 AC_DEFUN([AX_PROG_JAVAC],[
diff --git a/m4/ax_prog_javac_works.m4 b/m4/ax_prog_javac_works.m4
index 7dfa1e37..9b48149d 100644
--- a/m4/ax_prog_javac_works.m4
+++ b/m4/ax_prog_javac_works.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#    http://www.gnu.org/software/autoconf-archive/ax_prog_javac_works.html
+#   https://www.gnu.org/software/autoconf-archive/ax_prog_javac_works.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -32,7 +32,7 @@
 #   Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <http://www.gnu.org/licenses/>.
+#   with this program. If not, see <https://www.gnu.org/licenses/>.
 #
 #   As a special exception, the respective Autoconf Macro's copyright owner
 #   gives unlimited permission to copy, distribute and modify the configure
@@ -47,7 +47,7 @@
 #   modified version of the Autoconf Macro, you may extend this special
 #   exception to the GPL to apply to your modified version as well.
 
-#serial 6
+#serial 7
 
 AU_ALIAS([AC_PROG_JAVAC_WORKS], [AX_PROG_JAVAC_WORKS])
 AC_DEFUN([AX_PROG_JAVAC_WORKS],[
diff --git a/m4/ax_prog_javah.m4 b/m4/ax_prog_javah.m4
index 2809f29c..935ec896 100644
--- a/m4/ax_prog_javah.m4
+++ b/m4/ax_prog_javah.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#       http://www.gnu.org/software/autoconf-archive/ax_prog_javah.html
+#      https://www.gnu.org/software/autoconf-archive/ax_prog_javah.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -21,7 +21,7 @@
 #   and this notice are preserved. This file is offered as-is, without any
 #   warranty.
 
-#serial 7
+#serial 11
 
 AU_ALIAS([AC_PROG_JAVAH], [AX_PROG_JAVAH])
 AC_DEFUN([AX_PROG_JAVAH],[
@@ -30,18 +30,35 @@ AC_REQUIRE([AC_PROG_CPP])dnl
 AC_PATH_PROG(JAVAH,javah)
 AS_IF([test -n "$ac_cv_path_JAVAH"],
       [
-        AC_TRY_CPP([#include <jni.h>],,[
+        AC_PREPROC_IFELSE([AC_LANG_SOURCE([[#include <jni.h>]])],[],[
         ac_save_CPPFLAGS="$CPPFLAGS"
-        ax_prog_javah_bin_dir=`AS_DIRNAME([$ac_cv_path_JAVAH])`
-        ac_dir="`AS_DIRNAME([$ax_prog_javah_bin])`/include"
+        _ACJAVAH_FOLLOW_SYMLINKS("$ac_cv_path_JAVAH")
+        ax_prog_javah_bin_dir=`AS_DIRNAME([$_ACJAVAH_FOLLOWED])`
+        ac_dir="`AS_DIRNAME([$ax_prog_javah_bin_dir])`/include"
         AS_CASE([$build_os],
-                [cygwin*],
+                [cygwin*|mingw*],
                 [ac_machdep=win32],
                 [ac_machdep=`AS_ECHO($build_os) | sed 's,[[-0-9]].*,,'`])
         CPPFLAGS="$ac_save_CPPFLAGS -I$ac_dir -I$ac_dir/$ac_machdep"
-        AC_TRY_CPP([#include <jni.h>],
-                   ac_save_CPPFLAGS="$CPPFLAGS",
-                   AC_MSG_WARN([unable to include <jni.h>]))
+        AC_PREPROC_IFELSE([AC_LANG_SOURCE([[#include <jni.h>]])],
+                          [ac_save_CPPFLAGS="$CPPFLAGS"],
+                          [AC_MSG_WARN([unable to include <jni.h>])])
         CPPFLAGS="$ac_save_CPPFLAGS"])
       ])
 ])
+
+AC_DEFUN([_ACJAVAH_FOLLOW_SYMLINKS],[
+# find the include directory relative to the javac executable
+_cur="$1"
+while ls -ld "$_cur" 2>/dev/null | grep " -> " >/dev/null; do
+        AC_MSG_CHECKING([symlink for $_cur])
+        _slink=`ls -ld "$_cur" | sed 's/.* -> //'`
+        case "$_slink" in
+        /*) _cur="$_slink";;
+        # 'X' avoids triggering unwanted echo options.
+        *) _cur=`echo "X$_cur" | sed -e 's/^X//' -e 's:[[^/]]*$::'`"$_slink";;
+        esac
+        AC_MSG_RESULT([$_cur])
+done
+_ACJAVAH_FOLLOWED="$_cur"
+])
diff --git a/m4/ax_pthread.m4 b/m4/ax_pthread.m4
index d383ad5c..4920e073 100644
--- a/m4/ax_pthread.m4
+++ b/m4/ax_pthread.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#        http://www.gnu.org/software/autoconf-archive/ax_pthread.html
+#        https://www.gnu.org/software/autoconf-archive/ax_pthread.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -19,10 +19,10 @@
 #   is necessary on AIX to use the special cc_r compiler alias.)
 #
 #   NOTE: You are assumed to not only compile your program with these flags,
-#   but also link it with them as well. e.g. you should link with
+#   but also to link with them as well. For example, you might link with
 #   $PTHREAD_CC $CFLAGS $PTHREAD_CFLAGS $LDFLAGS ... $PTHREAD_LIBS $LIBS
 #
-#   If you are only building threads programs, you may wish to use these
+#   If you are only building threaded programs, you may wish to use these
 #   variables in your default LIBS, CFLAGS, and CC:
 #
 #     LIBS="$PTHREAD_LIBS $LIBS"
@@ -30,8 +30,8 @@
 #     CC="$PTHREAD_CC"
 #
 #   In addition, if the PTHREAD_CREATE_JOINABLE thread-attribute constant
-#   has a nonstandard name, defines PTHREAD_CREATE_JOINABLE to that name
-#   (e.g. PTHREAD_CREATE_UNDETACHED on AIX).
+#   has a nonstandard name, this macro defines PTHREAD_CREATE_JOINABLE to
+#   that name (e.g. PTHREAD_CREATE_UNDETACHED on AIX).
 #
 #   Also HAVE_PTHREAD_PRIO_INHERIT is defined if pthread is found and the
 #   PTHREAD_PRIO_INHERIT symbol is defined when compiling with
@@ -67,7 +67,7 @@
 #   Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <http://www.gnu.org/licenses/>.
+#   with this program. If not, see <https://www.gnu.org/licenses/>.
 #
 #   As a special exception, the respective Autoconf Macro's copyright owner
 #   gives unlimited permission to copy, distribute and modify the configure
@@ -82,35 +82,40 @@
 #   modified version of the Autoconf Macro, you may extend this special
 #   exception to the GPL to apply to your modified version as well.
 
-#serial 21
+#serial 25
 
 AU_ALIAS([ACX_PTHREAD], [AX_PTHREAD])
 AC_DEFUN([AX_PTHREAD], [
 AC_REQUIRE([AC_CANONICAL_HOST])
+AC_REQUIRE([AC_PROG_CC])
+AC_REQUIRE([AC_PROG_SED])
 AC_LANG_PUSH([C])
 ax_pthread_ok=no
 
 # We used to check for pthread.h first, but this fails if pthread.h
-# requires special compiler flags (e.g. on True64 or Sequent).
+# requires special compiler flags (e.g. on Tru64 or Sequent).
 # It gets checked for in the link test anyway.
 
 # First of all, check if the user has set any of the PTHREAD_LIBS,
 # etcetera environment variables, and if threads linking works using
 # them:
-if test x"$PTHREAD_LIBS$PTHREAD_CFLAGS" != x; then
-        save_CFLAGS="$CFLAGS"
+if test "x$PTHREAD_CFLAGS$PTHREAD_LIBS" != "x"; then
+        ax_pthread_save_CC="$CC"
+        ax_pthread_save_CFLAGS="$CFLAGS"
+        ax_pthread_save_LIBS="$LIBS"
+        AS_IF([test "x$PTHREAD_CC" != "x"], [CC="$PTHREAD_CC"])
         CFLAGS="$CFLAGS $PTHREAD_CFLAGS"
-        save_LIBS="$LIBS"
         LIBS="$PTHREAD_LIBS $LIBS"
-        AC_MSG_CHECKING([for pthread_join in LIBS=$PTHREAD_LIBS with CFLAGS=$PTHREAD_CFLAGS])
-        AC_TRY_LINK_FUNC([pthread_join], [ax_pthread_ok=yes])
+        AC_MSG_CHECKING([for pthread_join using $CC $PTHREAD_CFLAGS $PTHREAD_LIBS])
+        AC_LINK_IFELSE([AC_LANG_CALL([], [pthread_join])], [ax_pthread_ok=yes])
         AC_MSG_RESULT([$ax_pthread_ok])
-        if test x"$ax_pthread_ok" = xno; then
+        if test "x$ax_pthread_ok" = "xno"; then
                 PTHREAD_LIBS=""
                 PTHREAD_CFLAGS=""
         fi
-        LIBS="$save_LIBS"
-        CFLAGS="$save_CFLAGS"
+        CC="$ax_pthread_save_CC"
+        CFLAGS="$ax_pthread_save_CFLAGS"
+        LIBS="$ax_pthread_save_LIBS"
 fi
 
 # We must check for the threads library under a number of different
@@ -123,7 +128,7 @@ fi
 # which indicates that we try without any flags at all, and "pthread-config"
 # which is a program returning the flags for the Pth emulation library.
 
-ax_pthread_flags="pthreads none -Kthread -kthread lthread -pthread -pthreads -mthreads pthread --thread-safe -mt pthread-config"
+ax_pthread_flags="pthreads none -Kthread -pthread -pthreads -mthreads pthread --thread-safe -mt pthread-config"
 
 # The ordering *is* (sometimes) important.  Some notes on the
 # individual items follow:
@@ -132,82 +137,225 @@ ax_pthread_flags="pthreads none -Kthread -kthread lthread -pthread -pthreads -mt
 # none: in case threads are in libc; should be tried before -Kthread and
 #       other compiler flags to prevent continual compiler warnings
 # -Kthread: Sequent (threads in libc, but -Kthread needed for pthread.h)
-# -kthread: FreeBSD kernel threads (preferred to -pthread since SMP-able)
-# lthread: LinuxThreads port on FreeBSD (also preferred to -pthread)
-# -pthread: Linux/gcc (kernel threads), BSD/gcc (userland threads)
-# -pthreads: Solaris/gcc
-# -mthreads: Mingw32/gcc, Lynx/gcc
+# -pthread: Linux/gcc (kernel threads), BSD/gcc (userland threads), Tru64
+#           (Note: HP C rejects this with "bad form for `-t' option")
+# -pthreads: Solaris/gcc (Note: HP C also rejects)
 # -mt: Sun Workshop C (may only link SunOS threads [-lthread], but it
-#      doesn't hurt to check since this sometimes defines pthreads too;
-#      also defines -D_REENTRANT)
-#      ... -mt is also the pthreads flag for HP/aCC
+#      doesn't hurt to check since this sometimes defines pthreads and
+#      -D_REENTRANT too), HP C (must be checked before -lpthread, which
+#      is present but should not be used directly; and before -mthreads,
+#      because the compiler interprets this as "-mt" + "-hreads")
+# -mthreads: Mingw32/gcc, Lynx/gcc
 # pthread: Linux, etcetera
 # --thread-safe: KAI C++
 # pthread-config: use pthread-config program (for GNU Pth library)
 
-case ${host_os} in
+case $host_os in
+
+        freebsd*)
+
+        # -kthread: FreeBSD kernel threads (preferred to -pthread since SMP-able)
+        # lthread: LinuxThreads port on FreeBSD (also preferred to -pthread)
+
+        ax_pthread_flags="-kthread lthread $ax_pthread_flags"
+        ;;
+
+        hpux*)
+
+        # From the cc(1) man page: "[-mt] Sets various -D flags to enable
+        # multi-threading and also sets -lpthread."
+
+        ax_pthread_flags="-mt -pthread pthread $ax_pthread_flags"
+        ;;
+
+        openedition*)
+
+        # IBM z/OS requires a feature-test macro to be defined in order to
+        # enable POSIX threads at all, so give the user a hint if this is
+        # not set. (We don't define these ourselves, as they can affect
+        # other portions of the system API in unpredictable ways.)
+
+        AC_EGREP_CPP([AX_PTHREAD_ZOS_MISSING],
+            [
+#            if !defined(_OPEN_THREADS) && !defined(_UNIX03_THREADS)
+             AX_PTHREAD_ZOS_MISSING
+#            endif
+            ],
+            [AC_MSG_WARN([IBM z/OS requires -D_OPEN_THREADS or -D_UNIX03_THREADS to enable pthreads support.])])
+        ;;
+
         solaris*)
 
         # On Solaris (at least, for some versions), libc contains stubbed
         # (non-functional) versions of the pthreads routines, so link-based
-        # tests will erroneously succeed.  (We need to link with -pthreads/-mt/
-        # -lpthread.)  (The stubs are missing pthread_cleanup_push, or rather
-        # a function called by this macro, so we could check for that, but
-        # who knows whether they'll stub that too in a future libc.)  So,
-        # we'll just look for -pthreads and -lpthread first:
+        # tests will erroneously succeed. (N.B.: The stubs are missing
+        # pthread_cleanup_push, or rather a function called by this macro,
+        # so we could check for that, but who knows whether they'll stub
+        # that too in a future libc.)  So we'll check first for the
+        # standard Solaris way of linking pthreads (-mt -lpthread).
+
+        ax_pthread_flags="-mt,pthread pthread $ax_pthread_flags"
+        ;;
+esac
+
+# GCC generally uses -pthread, or -pthreads on some platforms (e.g. SPARC)
 
-        ax_pthread_flags="-pthreads pthread -mt -pthread $ax_pthread_flags"
+AS_IF([test "x$GCC" = "xyes"],
+      [ax_pthread_flags="-pthread -pthreads $ax_pthread_flags"])
+
+# The presence of a feature test macro requesting re-entrant function
+# definitions is, on some systems, a strong hint that pthreads support is
+# correctly enabled
+
+case $host_os in
+        darwin* | hpux* | linux* | osf* | solaris*)
+        ax_pthread_check_macro="_REENTRANT"
         ;;
 
-        darwin*)
-        ax_pthread_flags="-pthread $ax_pthread_flags"
+        aix*)
+        ax_pthread_check_macro="_THREAD_SAFE"
+        ;;
+
+        *)
+        ax_pthread_check_macro="--"
         ;;
 esac
+AS_IF([test "x$ax_pthread_check_macro" = "x--"],
+      [ax_pthread_check_cond=0],
+      [ax_pthread_check_cond="!defined($ax_pthread_check_macro)"])
+
+# Are we compiling with Clang?
+
+AC_CACHE_CHECK([whether $CC is Clang],
+    [ax_cv_PTHREAD_CLANG],
+    [ax_cv_PTHREAD_CLANG=no
+     # Note that Autoconf sets GCC=yes for Clang as well as GCC
+     if test "x$GCC" = "xyes"; then
+        AC_EGREP_CPP([AX_PTHREAD_CC_IS_CLANG],
+            [/* Note: Clang 2.7 lacks __clang_[a-z]+__ */
+#            if defined(__clang__) && defined(__llvm__)
+             AX_PTHREAD_CC_IS_CLANG
+#            endif
+            ],
+            [ax_cv_PTHREAD_CLANG=yes])
+     fi
+    ])
+ax_pthread_clang="$ax_cv_PTHREAD_CLANG"
+
+ax_pthread_clang_warning=no
+
+# Clang needs special handling, because older versions handle the -pthread
+# option in a rather... idiosyncratic way
+
+if test "x$ax_pthread_clang" = "xyes"; then
+
+        # Clang takes -pthread; it has never supported any other flag
+
+        # (Note 1: This will need to be revisited if a system that Clang
+        # supports has POSIX threads in a separate library.  This tends not
+        # to be the way of modern systems, but it's conceivable.)
+
+        # (Note 2: On some systems, notably Darwin, -pthread is not needed
+        # to get POSIX threads support; the API is always present and
+        # active.  We could reasonably leave PTHREAD_CFLAGS empty.  But
+        # -pthread does define _REENTRANT, and while the Darwin headers
+        # ignore this macro, third-party headers might not.)
+
+        PTHREAD_CFLAGS="-pthread"
+        PTHREAD_LIBS=
+
+        ax_pthread_ok=yes
+
+        # However, older versions of Clang make a point of warning the user
+        # that, in an invocation where only linking and no compilation is
+        # taking place, the -pthread option has no effect ("argument unused
+        # during compilation").  They expect -pthread to be passed in only
+        # when source code is being compiled.
+        #
+        # Problem is, this is at odds with the way Automake and most other
+        # C build frameworks function, which is that the same flags used in
+        # compilation (CFLAGS) are also used in linking.  Many systems
+        # supported by AX_PTHREAD require exactly this for POSIX threads
+        # support, and in fact it is often not straightforward to specify a
+        # flag that is used only in the compilation phase and not in
+        # linking.  Such a scenario is extremely rare in practice.
+        #
+        # Even though use of the -pthread flag in linking would only print
+        # a warning, this can be a nuisance for well-run software projects
+        # that build with -Werror.  So if the active version of Clang has
+        # this misfeature, we search for an option to squash it.
+
+        AC_CACHE_CHECK([whether Clang needs flag to prevent "argument unused" warning when linking with -pthread],
+            [ax_cv_PTHREAD_CLANG_NO_WARN_FLAG],
+            [ax_cv_PTHREAD_CLANG_NO_WARN_FLAG=unknown
+             # Create an alternate version of $ac_link that compiles and
+             # links in two steps (.c -> .o, .o -> exe) instead of one
+             # (.c -> exe), because the warning occurs only in the second
+             # step
+             ax_pthread_save_ac_link="$ac_link"
+             ax_pthread_sed='s/conftest\.\$ac_ext/conftest.$ac_objext/g'
+             ax_pthread_link_step=`$as_echo "$ac_link" | sed "$ax_pthread_sed"`
+             ax_pthread_2step_ac_link="($ac_compile) && (echo ==== >&5) && ($ax_pthread_link_step)"
+             ax_pthread_save_CFLAGS="$CFLAGS"
+             for ax_pthread_try in '' -Qunused-arguments -Wno-unused-command-line-argument unknown; do
+                AS_IF([test "x$ax_pthread_try" = "xunknown"], [break])
+                CFLAGS="-Werror -Wunknown-warning-option $ax_pthread_try -pthread $ax_pthread_save_CFLAGS"
+                ac_link="$ax_pthread_save_ac_link"
+                AC_LINK_IFELSE([AC_LANG_SOURCE([[int main(void){return 0;}]])],
+                    [ac_link="$ax_pthread_2step_ac_link"
+                     AC_LINK_IFELSE([AC_LANG_SOURCE([[int main(void){return 0;}]])],
+                         [break])
+                    ])
+             done
+             ac_link="$ax_pthread_save_ac_link"
+             CFLAGS="$ax_pthread_save_CFLAGS"
+             AS_IF([test "x$ax_pthread_try" = "x"], [ax_pthread_try=no])
+             ax_cv_PTHREAD_CLANG_NO_WARN_FLAG="$ax_pthread_try"
+            ])
 
-# Clang doesn't consider unrecognized options an error unless we specify
-# -Werror. We throw in some extra Clang-specific options to ensure that
-# this doesn't happen for GCC, which also accepts -Werror.
+        case "$ax_cv_PTHREAD_CLANG_NO_WARN_FLAG" in
+                no | unknown) ;;
+                *) PTHREAD_CFLAGS="$ax_cv_PTHREAD_CLANG_NO_WARN_FLAG $PTHREAD_CFLAGS" ;;
+        esac
 
-AC_MSG_CHECKING([if compiler needs -Werror to reject unknown flags])
-save_CFLAGS="$CFLAGS"
-ax_pthread_extra_flags="-Werror"
-CFLAGS="$CFLAGS $ax_pthread_extra_flags -Wunknown-warning-option -Wsizeof-array-argument"
-AC_COMPILE_IFELSE([AC_LANG_PROGRAM([int foo(void);],[foo()])],
-                  [AC_MSG_RESULT([yes])],
-                  [ax_pthread_extra_flags=
-                   AC_MSG_RESULT([no])])
-CFLAGS="$save_CFLAGS"
+fi # $ax_pthread_clang = yes
 
-if test x"$ax_pthread_ok" = xno; then
-for flag in $ax_pthread_flags; do
+if test "x$ax_pthread_ok" = "xno"; then
+for ax_pthread_try_flag in $ax_pthread_flags; do
 
-        case $flag in
+        case $ax_pthread_try_flag in
                 none)
                 AC_MSG_CHECKING([whether pthreads work without any flags])
                 ;;
 
+                -mt,pthread)
+                AC_MSG_CHECKING([whether pthreads work with -mt -lpthread])
+                PTHREAD_CFLAGS="-mt"
+                PTHREAD_LIBS="-lpthread"
+                ;;
+
                 -*)
-                AC_MSG_CHECKING([whether pthreads work with $flag])
-                PTHREAD_CFLAGS="$flag"
+                AC_MSG_CHECKING([whether pthreads work with $ax_pthread_try_flag])
+                PTHREAD_CFLAGS="$ax_pthread_try_flag"
                 ;;
 
                 pthread-config)
                 AC_CHECK_PROG([ax_pthread_config], [pthread-config], [yes], [no])
-                if test x"$ax_pthread_config" = xno; then continue; fi
+                AS_IF([test "x$ax_pthread_config" = "xno"], [continue])
                 PTHREAD_CFLAGS="`pthread-config --cflags`"
                 PTHREAD_LIBS="`pthread-config --ldflags` `pthread-config --libs`"
                 ;;
 
                 *)
-                AC_MSG_CHECKING([for the pthreads library -l$flag])
-                PTHREAD_LIBS="-l$flag"
+                AC_MSG_CHECKING([for the pthreads library -l$ax_pthread_try_flag])
+                PTHREAD_LIBS="-l$ax_pthread_try_flag"
                 ;;
         esac
 
-        save_LIBS="$LIBS"
-        save_CFLAGS="$CFLAGS"
+        ax_pthread_save_CFLAGS="$CFLAGS"
+        ax_pthread_save_LIBS="$LIBS"
+        CFLAGS="$CFLAGS $PTHREAD_CFLAGS"
         LIBS="$PTHREAD_LIBS $LIBS"
-        CFLAGS="$CFLAGS $PTHREAD_CFLAGS $ax_pthread_extra_flags"
 
         # Check for various functions.  We must include pthread.h,
         # since some functions may be macros.  (On the Sequent, we
@@ -218,7 +366,11 @@ for flag in $ax_pthread_flags; do
         # pthread_cleanup_push because it is one of the few pthread
         # functions on Solaris that doesn't have a non-functional libc stub.
         # We try pthread_create on general principles.
+
         AC_LINK_IFELSE([AC_LANG_PROGRAM([#include <pthread.h>
+#                       if $ax_pthread_check_cond
+#                        error "$ax_pthread_check_macro must be defined"
+#                       endif
                         static void routine(void *a) { a = 0; }
                         static void *start_routine(void *a) { return a; }],
                        [pthread_t th; pthread_attr_t attr;
@@ -227,16 +379,14 @@ for flag in $ax_pthread_flags; do
                         pthread_attr_init(&attr);
                         pthread_cleanup_push(routine, 0);
                         pthread_cleanup_pop(0) /* ; */])],
-                [ax_pthread_ok=yes],
-                [])
+            [ax_pthread_ok=yes],
+            [])
 
-        LIBS="$save_LIBS"
-        CFLAGS="$save_CFLAGS"
+        CFLAGS="$ax_pthread_save_CFLAGS"
+        LIBS="$ax_pthread_save_LIBS"
 
         AC_MSG_RESULT([$ax_pthread_ok])
-        if test "x$ax_pthread_ok" = xyes; then
-                break;
-        fi
+        AS_IF([test "x$ax_pthread_ok" = "xyes"], [break])
 
         PTHREAD_LIBS=""
         PTHREAD_CFLAGS=""
@@ -244,71 +394,75 @@ done
 fi
 
 # Various other checks:
-if test "x$ax_pthread_ok" = xyes; then
-        save_LIBS="$LIBS"
-        LIBS="$PTHREAD_LIBS $LIBS"
-        save_CFLAGS="$CFLAGS"
+if test "x$ax_pthread_ok" = "xyes"; then
+        ax_pthread_save_CFLAGS="$CFLAGS"
+        ax_pthread_save_LIBS="$LIBS"
         CFLAGS="$CFLAGS $PTHREAD_CFLAGS"
+        LIBS="$PTHREAD_LIBS $LIBS"
 
         # Detect AIX lossage: JOINABLE attribute is called UNDETACHED.
-        AC_MSG_CHECKING([for joinable pthread attribute])
-        attr_name=unknown
-        for attr in PTHREAD_CREATE_JOINABLE PTHREAD_CREATE_UNDETACHED; do
-            AC_LINK_IFELSE([AC_LANG_PROGRAM([#include <pthread.h>],
-                           [int attr = $attr; return attr /* ; */])],
-                [attr_name=$attr; break],
-                [])
-        done
-        AC_MSG_RESULT([$attr_name])
-        if test "$attr_name" != PTHREAD_CREATE_JOINABLE; then
-            AC_DEFINE_UNQUOTED([PTHREAD_CREATE_JOINABLE], [$attr_name],
-                               [Define to necessary symbol if this constant
-                                uses a non-standard name on your system.])
-        fi
-
-        AC_MSG_CHECKING([if more special flags are required for pthreads])
-        flag=no
-        case ${host_os} in
-            aix* | freebsd* | darwin*) flag="-D_THREAD_SAFE";;
-            osf* | hpux*) flag="-D_REENTRANT";;
-            solaris*)
-            if test "$GCC" = "yes"; then
-                flag="-D_REENTRANT"
-            else
-                # TODO: What about Clang on Solaris?
-                flag="-mt -D_REENTRANT"
-            fi
-            ;;
-        esac
-        AC_MSG_RESULT([$flag])
-        if test "x$flag" != xno; then
-            PTHREAD_CFLAGS="$flag $PTHREAD_CFLAGS"
-        fi
+        AC_CACHE_CHECK([for joinable pthread attribute],
+            [ax_cv_PTHREAD_JOINABLE_ATTR],
+            [ax_cv_PTHREAD_JOINABLE_ATTR=unknown
+             for ax_pthread_attr in PTHREAD_CREATE_JOINABLE PTHREAD_CREATE_UNDETACHED; do
+                 AC_LINK_IFELSE([AC_LANG_PROGRAM([#include <pthread.h>],
+                                                 [int attr = $ax_pthread_attr; return attr /* ; */])],
+                                [ax_cv_PTHREAD_JOINABLE_ATTR=$ax_pthread_attr; break],
+                                [])
+             done
+            ])
+        AS_IF([test "x$ax_cv_PTHREAD_JOINABLE_ATTR" != "xunknown" && \
+               test "x$ax_cv_PTHREAD_JOINABLE_ATTR" != "xPTHREAD_CREATE_JOINABLE" && \
+               test "x$ax_pthread_joinable_attr_defined" != "xyes"],
+              [AC_DEFINE_UNQUOTED([PTHREAD_CREATE_JOINABLE],
+                                  [$ax_cv_PTHREAD_JOINABLE_ATTR],
+                                  [Define to necessary symbol if this constant
+                                   uses a non-standard name on your system.])
+               ax_pthread_joinable_attr_defined=yes
+              ])
+
+        AC_CACHE_CHECK([whether more special flags are required for pthreads],
+            [ax_cv_PTHREAD_SPECIAL_FLAGS],
+            [ax_cv_PTHREAD_SPECIAL_FLAGS=no
+             case $host_os in
+             solaris*)
+             ax_cv_PTHREAD_SPECIAL_FLAGS="-D_POSIX_PTHREAD_SEMANTICS"
+             ;;
+             esac
+            ])
+        AS_IF([test "x$ax_cv_PTHREAD_SPECIAL_FLAGS" != "xno" && \
+               test "x$ax_pthread_special_flags_added" != "xyes"],
+              [PTHREAD_CFLAGS="$ax_cv_PTHREAD_SPECIAL_FLAGS $PTHREAD_CFLAGS"
+               ax_pthread_special_flags_added=yes])
 
         AC_CACHE_CHECK([for PTHREAD_PRIO_INHERIT],
-            [ax_cv_PTHREAD_PRIO_INHERIT], [
-                AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <pthread.h>]],
-                                                [[int i = PTHREAD_PRIO_INHERIT;]])],
-                    [ax_cv_PTHREAD_PRIO_INHERIT=yes],
-                    [ax_cv_PTHREAD_PRIO_INHERIT=no])
+            [ax_cv_PTHREAD_PRIO_INHERIT],
+            [AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <pthread.h>]],
+                                             [[int i = PTHREAD_PRIO_INHERIT;
+                                               return i;]])],
+                            [ax_cv_PTHREAD_PRIO_INHERIT=yes],
+                            [ax_cv_PTHREAD_PRIO_INHERIT=no])
             ])
-        AS_IF([test "x$ax_cv_PTHREAD_PRIO_INHERIT" = "xyes"],
-            [AC_DEFINE([HAVE_PTHREAD_PRIO_INHERIT], [1], [Have PTHREAD_PRIO_INHERIT.])])
+        AS_IF([test "x$ax_cv_PTHREAD_PRIO_INHERIT" = "xyes" && \
+               test "x$ax_pthread_prio_inherit_defined" != "xyes"],
+              [AC_DEFINE([HAVE_PTHREAD_PRIO_INHERIT], [1], [Have PTHREAD_PRIO_INHERIT.])
+               ax_pthread_prio_inherit_defined=yes
+              ])
 
-        LIBS="$save_LIBS"
-        CFLAGS="$save_CFLAGS"
+        CFLAGS="$ax_pthread_save_CFLAGS"
+        LIBS="$ax_pthread_save_LIBS"
 
         # More AIX lossage: compile with *_r variant
-        if test "x$GCC" != xyes; then
+        if test "x$GCC" != "xyes"; then
             case $host_os in
                 aix*)
                 AS_CASE(["x/$CC"],
-                  [x*/c89|x*/c89_128|x*/c99|x*/c99_128|x*/cc|x*/cc128|x*/xlc|x*/xlc_v6|x*/xlc128|x*/xlc128_v6],
-                  [#handle absolute path differently from PATH based program lookup
-                   AS_CASE(["x$CC"],
-                     [x/*],
-                     [AS_IF([AS_EXECUTABLE_P([${CC}_r])],[PTHREAD_CC="${CC}_r"])],
-                     [AC_CHECK_PROGS([PTHREAD_CC],[${CC}_r],[$CC])])])
+                    [x*/c89|x*/c89_128|x*/c99|x*/c99_128|x*/cc|x*/cc128|x*/xlc|x*/xlc_v6|x*/xlc128|x*/xlc128_v6],
+                    [#handle absolute path differently from PATH based program lookup
+                     AS_CASE(["x$CC"],
+                         [x/*],
+                         [AS_IF([AS_EXECUTABLE_P([${CC}_r])],[PTHREAD_CC="${CC}_r"])],
+                         [AC_CHECK_PROGS([PTHREAD_CC],[${CC}_r],[$CC])])])
                 ;;
             esac
         fi
@@ -321,7 +475,7 @@ AC_SUBST([PTHREAD_CFLAGS])
 AC_SUBST([PTHREAD_CC])
 
 # Finally, execute ACTION-IF-FOUND/ACTION-IF-NOT-FOUND:
-if test x"$ax_pthread_ok" = xyes; then
+if test "x$ax_pthread_ok" = "xyes"; then
         ifelse([$1],,[AC_DEFINE([HAVE_PTHREAD],[1],[Define if you have POSIX threads libraries and header files.])],[$1])
         :
 else
diff --git a/m4/ax_try_compile_java.m4 b/m4/ax_try_compile_java.m4
index a8ed6b2a..245c36c4 100644
--- a/m4/ax_try_compile_java.m4
+++ b/m4/ax_try_compile_java.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#    http://www.gnu.org/software/autoconf-archive/ax_try_compile_java.html
+#   https://www.gnu.org/software/autoconf-archive/ax_try_compile_java.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -29,7 +29,7 @@
 #   and this notice are preserved. This file is offered as-is, without any
 #   warranty.
 
-#serial 8
+#serial 10
 
 AU_ALIAS([AC_TRY_COMPILE_JAVA], [AX_TRY_COMPILE_JAVA])
 AC_DEFUN([AX_TRY_COMPILE_JAVA],[
@@ -48,8 +48,8 @@ dnl Don't remove the temporary files here, so they can be examined.
 else
   echo "configure: failed program was:" >&AS_MESSAGE_LOG_FD
   cat Test.java >&AS_MESSAGE_LOG_FD
-ifelse([$4], , , [  rm -fr Test.java Test.class
+ifelse([$4], , , [  rm -f Test.java Test.class
   $4
 ])dnl
 fi
-rm -fr Test.java Test.class])
+rm -f Test.java Test.class])
diff --git a/m4/ax_try_run_java.m4 b/m4/ax_try_run_java.m4
index c680f03f..2ebb86d6 100644
--- a/m4/ax_try_run_java.m4
+++ b/m4/ax_try_run_java.m4
@@ -1,5 +1,5 @@
 # ===========================================================================
-#      http://www.gnu.org/software/autoconf-archive/ax_try_run_java.html
+#     https://www.gnu.org/software/autoconf-archive/ax_try_run_java.html
 # ===========================================================================
 #
 # SYNOPSIS
@@ -29,7 +29,7 @@
 #   and this notice are preserved. This file is offered as-is, without any
 #   warranty.
 
-#serial 2
+#serial 3
 
 AU_ALIAS([AC_TRY_RUN_JAVA], [AX_TRY_RUN_JAVA])
 AC_DEFUN([AX_TRY_RUN_JAVA],[
-- 
2.17.1
