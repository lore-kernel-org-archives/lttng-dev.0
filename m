From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 1/2] Update macros from the
 autoconf archive
Date: Wed, 17 Apr 2019 16:15:34 -0400 (EDT)
Message-ID: <1493676266.705.1555532134881.JavaMail.zimbra__28431.2257588439$1555532162$gmane$org@efficios.com>
References: <20190416201731.27244-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44ktlf6vBpz1Jhn
 for <lttng-dev@lists.lttng.org>; Wed, 17 Apr 2019 16:15:42 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 26F281D8826
 for <lttng-dev@lists.lttng.org>; Wed, 17 Apr 2019 16:15:36 -0400 (EDT)
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
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

both merged into lttng-ust master branch, thanks!

Mathieu

----- On Apr 16, 2019, at 4:17 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> m4/ax_c___attribute__.m4  |  6 ++--
> m4/ax_check_class.m4      | 75 +++------------------------------------
> m4/ax_check_classpath.m4  |  6 ++--
> m4/ax_check_rqrd_class.m4 |  6 ++--
> m4/ax_java_options.m4     |  4 +--
> m4/ax_jni_include_dir.m4  | 57 ++++++++++++++++++++---------
> m4/ax_prog_jar.m4         |  4 +--
> m4/ax_prog_java.m4        |  6 ++--
> m4/ax_prog_java_works.m4  | 51 +++-----------------------
> m4/ax_prog_javac.m4       |  6 ++--
> m4/ax_prog_javac_works.m4 |  6 ++--
> m4/ax_prog_javah.m4       | 35 +++++++++++++-----
> m4/ax_sys_weak_alias.m4   |  8 ++---
> m4/ax_try_compile_java.m4 |  8 ++---
> m4/ax_try_run_java.m4     |  4 +--
> 15 files changed, 108 insertions(+), 174 deletions(-)
> 
> diff --git a/m4/ax_c___attribute__.m4 b/m4/ax_c___attribute__.m4
> index cf3d62bb..6a1ede15 100644
> --- a/m4/ax_c___attribute__.m4
> +++ b/m4/ax_c___attribute__.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#    http://www.gnu.org/software/autoconf-archive/ax_c___attribute__.html
> +#    https://www.gnu.org/software/autoconf-archive/ax_c___attribute__.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -28,7 +28,7 @@
> #   Public License for more details.
> #
> #   You should have received a copy of the GNU General Public License along
> -#   with this program. If not, see <http://www.gnu.org/licenses/>.
> +#   with this program. If not, see <https://www.gnu.org/licenses/>.
> #
> #   As a special exception, the respective Autoconf Macro's copyright owner
> #   gives unlimited permission to copy, distribute and modify the configure
> @@ -43,7 +43,7 @@
> #   modified version of the Autoconf Macro, you may extend this special
> #   exception to the GPL to apply to your modified version as well.
> 
> -#serial 8
> +#serial 9
> 
> AC_DEFUN([AX_C___ATTRIBUTE__], [
>   AC_CACHE_CHECK([for __attribute__], [ax_cv___attribute__],
> diff --git a/m4/ax_check_class.m4 b/m4/ax_check_class.m4
> index 42b51d72..e673c2d3 100644
> --- a/m4/ax_check_class.m4
> +++ b/m4/ax_check_class.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#      http://www.gnu.org/software/autoconf-archive/ax_check_class.html
> +#      https://www.gnu.org/software/autoconf-archive/ax_check_class.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -36,7 +36,7 @@
> #   Public License for more details.
> #
> #   You should have received a copy of the GNU General Public License along
> -#   with this program. If not, see <http://www.gnu.org/licenses/>.
> +#   with this program. If not, see <https://www.gnu.org/licenses/>.
> #
> #   As a special exception, the respective Autoconf Macro's copyright owner
> #   gives unlimited permission to copy, distribute and modify the configure
> @@ -51,83 +51,18 @@
> #   modified version of the Autoconf Macro, you may extend this special
> #   exception to the GPL to apply to your modified version as well.
> 
> -#serial 7
> +#serial 12
> 
> AU_ALIAS([AC_CHECK_CLASS], [AX_CHECK_CLASS])
> AC_DEFUN([AX_CHECK_CLASS],[
> AC_REQUIRE([AX_PROG_JAVA])
> ac_var_name=`echo $1 | sed 's/\./_/g'`
> -dnl Normaly I'd use a AC_CACHE_CHECK here but since the variable name is
> +dnl Normally I'd use a AC_CACHE_CHECK here but since the variable name is
> dnl dynamic I need an extra level of extraction
> AC_MSG_CHECKING([for $1 class])
> AC_CACHE_VAL(ax_cv_class_$ac_var_name, [
> -if test x$ac_cv_prog_uudecode_base64 = xyes; then
> -dnl /**
> -dnl  * Test.java: used to test dynamicaly if a class exists.
> -dnl  */
> -dnl public class Test
> -dnl {
> -dnl
> -dnl public static void
> -dnl main( String[] argv )
> -dnl {
> -dnl     Class lib;
> -dnl     if (argv.length < 1)
> -dnl      {
> -dnl             System.err.println ("Missing argument");
> -dnl             System.exit (77);
> -dnl      }
> -dnl     try
> -dnl      {
> -dnl             lib = Class.forName (argv[0]);
> -dnl      }
> -dnl     catch (ClassNotFoundException e)
> -dnl      {
> -dnl             System.exit (1);
> -dnl      }
> -dnl     lib = null;
> -dnl     System.exit (0);
> -dnl }
> -dnl
> -dnl }
> -cat << \EOF > Test.uue
> -begin-base64 644 Test.class
> -yv66vgADAC0AKQcAAgEABFRlc3QHAAQBABBqYXZhL2xhbmcvT2JqZWN0AQAE
> -bWFpbgEAFihbTGphdmEvbGFuZy9TdHJpbmc7KVYBAARDb2RlAQAPTGluZU51
> -bWJlclRhYmxlDAAKAAsBAANlcnIBABVMamF2YS9pby9QcmludFN0cmVhbTsJ
> -AA0ACQcADgEAEGphdmEvbGFuZy9TeXN0ZW0IABABABBNaXNzaW5nIGFyZ3Vt
> -ZW50DAASABMBAAdwcmludGxuAQAVKExqYXZhL2xhbmcvU3RyaW5nOylWCgAV
> -ABEHABYBABNqYXZhL2lvL1ByaW50U3RyZWFtDAAYABkBAARleGl0AQAEKEkp
> -VgoADQAXDAAcAB0BAAdmb3JOYW1lAQAlKExqYXZhL2xhbmcvU3RyaW5nOylM
> -amF2YS9sYW5nL0NsYXNzOwoAHwAbBwAgAQAPamF2YS9sYW5nL0NsYXNzBwAi
> -AQAgamF2YS9sYW5nL0NsYXNzTm90Rm91bmRFeGNlcHRpb24BAAY8aW5pdD4B
> -AAMoKVYMACMAJAoAAwAlAQAKU291cmNlRmlsZQEACVRlc3QuamF2YQAhAAEA
> -AwAAAAAAAgAJAAUABgABAAcAAABtAAMAAwAAACkqvgSiABCyAAwSD7YAFBBN
> -uAAaKgMyuAAeTKcACE0EuAAaAUwDuAAasQABABMAGgAdACEAAQAIAAAAKgAK
> -AAAACgAAAAsABgANAA4ADgATABAAEwASAB4AFgAiABgAJAAZACgAGgABACMA
> -JAABAAcAAAAhAAEAAQAAAAUqtwAmsQAAAAEACAAAAAoAAgAAAAQABAAEAAEA
> -JwAAAAIAKA==
> -====
> -EOF
> -                if $UUDECODE Test.uue; then
> -                        :
> -                else
> -                        echo "configure: __oline__: uudecode had trouble
> decoding base 64 file 'Test.uue'" >&AS_MESSAGE_LOG_FD
> -                        echo "configure: failed file was:" >&AS_MESSAGE_LOG_FD
> -                        cat Test.uue >&AS_MESSAGE_LOG_FD
> -                        ac_cv_prog_uudecode_base64=no
> -                fi
> -        rm -f Test.uue
> -        if AC_TRY_COMMAND($JAVA -classpath ".:$CLASSPATH" $JAVAFLAGS Test $1)
> >/dev/null 2>&1; then
> -                eval "ac_cv_class_$ac_var_name=yes"
> -        else
> -                eval "ac_cv_class_$ac_var_name=no"
> -        fi
> -        rm -f Test.class
> -else
>         AX_TRY_COMPILE_JAVA([$1], , [eval "ac_cv_class_$ac_var_name=yes"],
>                 [eval "ac_cv_class_$ac_var_name=no"])
> -fi
> eval "ac_var_val=$`eval echo ac_cv_class_$ac_var_name`"
> eval "HAVE_$ac_var_name=$`echo ac_cv_class_$ac_var_val`"
> HAVE_LAST_CLASS=$ac_var_val
> @@ -137,7 +72,7 @@ else
>         ifelse([$3], , :, [$3])
> fi
> ])
> -dnl for some reason the above statment didn't fall though here?
> +dnl for some reason the above statement didn't fall though here?
> dnl do scripts have variable scoping?
> eval "ac_var_val=$`eval echo ac_cv_class_$ac_var_name`"
> AC_MSG_RESULT($ac_var_val)
> diff --git a/m4/ax_check_classpath.m4 b/m4/ax_check_classpath.m4
> index 3c9081a0..e08a253d 100644
> --- a/m4/ax_check_classpath.m4
> +++ b/m4/ax_check_classpath.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#    http://www.gnu.org/software/autoconf-archive/ax_check_classpath.html
> +#    https://www.gnu.org/software/autoconf-archive/ax_check_classpath.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -33,7 +33,7 @@
> #   Public License for more details.
> #
> #   You should have received a copy of the GNU General Public License along
> -#   with this program. If not, see <http://www.gnu.org/licenses/>.
> +#   with this program. If not, see <https://www.gnu.org/licenses/>.
> #
> #   As a special exception, the respective Autoconf Macro's copyright owner
> #   gives unlimited permission to copy, distribute and modify the configure
> @@ -48,7 +48,7 @@
> #   modified version of the Autoconf Macro, you may extend this special
> #   exception to the GPL to apply to your modified version as well.
> 
> -#serial 5
> +#serial 6
> 
> AU_ALIAS([AC_CHECK_CLASSPATH], [AX_CHECK_CLASSPATH])
> AC_DEFUN([AX_CHECK_CLASSPATH],[
> diff --git a/m4/ax_check_rqrd_class.m4 b/m4/ax_check_rqrd_class.m4
> index 8f14241b..baa041ac 100644
> --- a/m4/ax_check_rqrd_class.m4
> +++ b/m4/ax_check_rqrd_class.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#    http://www.gnu.org/software/autoconf-archive/ax_check_rqrd_class.html
> +#   https://www.gnu.org/software/autoconf-archive/ax_check_rqrd_class.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -35,7 +35,7 @@
> #   Public License for more details.
> #
> #   You should have received a copy of the GNU General Public License along
> -#   with this program. If not, see <http://www.gnu.org/licenses/>.
> +#   with this program. If not, see <https://www.gnu.org/licenses/>.
> #
> #   As a special exception, the respective Autoconf Macro's copyright owner
> #   gives unlimited permission to copy, distribute and modify the configure
> @@ -50,7 +50,7 @@
> #   modified version of the Autoconf Macro, you may extend this special
> #   exception to the GPL to apply to your modified version as well.
> 
> -#serial 5
> +#serial 6
> 
> AU_ALIAS([AC_CHECK_RQRD_CLASS], [AX_CHECK_RQRD_CLASS])
> AC_DEFUN([AX_CHECK_RQRD_CLASS],[
> diff --git a/m4/ax_java_options.m4 b/m4/ax_java_options.m4
> index 36c10d92..722d7880 100644
> --- a/m4/ax_java_options.m4
> +++ b/m4/ax_java_options.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#      http://www.gnu.org/software/autoconf-archive/ax_java_options.html
> +#     https://www.gnu.org/software/autoconf-archive/ax_java_options.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -27,7 +27,7 @@
> #   and this notice are preserved. This file is offered as-is, without any
> #   warranty.
> 
> -#serial 6
> +#serial 7
> 
> AU_ALIAS([AC_JAVA_OPTIONS], [AX_JAVA_OPTIONS])
> AC_DEFUN([AX_JAVA_OPTIONS],[
> diff --git a/m4/ax_jni_include_dir.m4 b/m4/ax_jni_include_dir.m4
> index b664d80b..ae7a5f04 100644
> --- a/m4/ax_jni_include_dir.m4
> +++ b/m4/ax_jni_include_dir.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#    http://www.gnu.org/software/autoconf-archive/ax_jni_include_dir.html
> +#    https://www.gnu.org/software/autoconf-archive/ax_jni_include_dir.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -32,6 +32,10 @@
> #
> #   - at the configure level, setenv JAVAC
> #
> +#   This macro depends on AC_CANONICAL_HOST which requires that config.guess
> +#   and config.sub be distributed along with the source code.  See autoconf
> +#   manual for details.
> +#
> #   Note: This macro can work with the autoconf M4 macros for Java programs.
> #   This particular macro is not part of the original set of macros.
> #
> @@ -44,11 +48,13 @@
> #   and this notice are preserved. This file is offered as-is, without any
> #   warranty.
> 
> -#serial 10
> +#serial 15
> 
> AU_ALIAS([AC_JNI_INCLUDE_DIR], [AX_JNI_INCLUDE_DIR])
> AC_DEFUN([AX_JNI_INCLUDE_DIR],[
> 
> +AC_REQUIRE([AC_CANONICAL_HOST])
> +
> JNI_INCLUDE_DIRS=""
> 
> if test "x$JAVA_HOME" != x; then
> @@ -66,9 +72,17 @@ else
> fi
> 
> case "$host_os" in
> -        darwin*)        _JTOPDIR=`echo "$_JTOPDIR" | sed -e 's:/[[^/]]*$::'`
> -                        _JINC="$_JTOPDIR/Headers";;
> -        *)              _JINC="$_JTOPDIR/include";;
> +        darwin*)        # Apple Java headers are inside the Xcode bundle.
> +            macos_version=$(sw_vers -productVersion | sed -n -e
> 's/^@<:@0-9@:>@*.\(@<:@0-9@:>@*\).@<:@0-9@:>@*/\1/p')
> +            if @<:@ "$macos_version" -gt "7" @:>@; then
> +                _JTOPDIR="$(xcrun
> --show-sdk-path)/System/Library/Frameworks/JavaVM.framework"
> +                _JINC="$_JTOPDIR/Headers"
> +            else
> +                _JTOPDIR="/System/Library/Frameworks/JavaVM.framework"
> +                _JINC="$_JTOPDIR/Headers"
> +            fi
> +            ;;
> +        *) _JINC="$_JTOPDIR/include";;
> esac
> _AS_ECHO_LOG([_JTOPDIR=$_JTOPDIR])
> _AS_ECHO_LOG([_JINC=$_JINC])
> @@ -76,18 +90,27 @@ _AS_ECHO_LOG([_JINC=$_JINC])
> # On Mac OS X 10.6.4, jni.h is a symlink:
> # /System/Library/Frameworks/JavaVM.framework/Versions/Current/Headers/jni.h
> # -> ../../CurrentJDK/Headers/jni.h.
> -AC_CHECK_FILE([$_JINC/jni.h],
> -	[JNI_INCLUDE_DIRS="$JNI_INCLUDE_DIRS $_JINC"],
> -	[_JTOPDIR=`echo "$_JTOPDIR" | sed -e 's:/[[^/]]*$::'`
> -	 AC_CHECK_FILE([$_JTOPDIR/include/jni.h],
> -		[JNI_INCLUDE_DIRS="$JNI_INCLUDE_DIRS $_JTOPDIR/include"],
> -                AC_MSG_ERROR([cannot find JDK header files]))
> -	])
> +AC_CACHE_CHECK(jni headers, ac_cv_jni_header_path,
> +[
> +  if test -f "$_JINC/jni.h"; then
> +    ac_cv_jni_header_path="$_JINC"
> +    JNI_INCLUDE_DIRS="$JNI_INCLUDE_DIRS $ac_cv_jni_header_path"
> +  else
> +    _JTOPDIR=`echo "$_JTOPDIR" | sed -e 's:/[[^/]]*$::'`
> +    if test -f "$_JTOPDIR/include/jni.h"; then
> +      ac_cv_jni_header_path="$_JTOPDIR/include"
> +      JNI_INCLUDE_DIRS="$JNI_INCLUDE_DIRS $ac_cv_jni_header_path"
> +    else
> +      ac_cv_jni_header_path=none
> +    fi
> +  fi
> +])
> 
> # get the likely subdirectories for system specific java includes
> case "$host_os" in
> bsdi*)          _JNI_INC_SUBDIRS="bsdos";;
> freebsd*)       _JNI_INC_SUBDIRS="freebsd";;
> +darwin*)        _JNI_INC_SUBDIRS="darwin";;
> linux*)         _JNI_INC_SUBDIRS="linux genunix";;
> osf*)           _JNI_INC_SUBDIRS="alpha";;
> solaris*)       _JNI_INC_SUBDIRS="solaris";;
> @@ -96,13 +119,15 @@ cygwin*)	_JNI_INC_SUBDIRS="win32";;
> *)              _JNI_INC_SUBDIRS="genunix";;
> esac
> 
> -# add any subdirectories that are present
> -for JINCSUBDIR in $_JNI_INC_SUBDIRS
> -do
> +if test "x$ac_cv_jni_header_path" != "xnone"; then
> +  # add any subdirectories that are present
> +  for JINCSUBDIR in $_JNI_INC_SUBDIRS
> +  do
>     if test -d "$_JTOPDIR/include/$JINCSUBDIR"; then
>          JNI_INCLUDE_DIRS="$JNI_INCLUDE_DIRS $_JTOPDIR/include/$JINCSUBDIR"
>     fi
> -done
> +  done
> +fi
> ])
> 
> # _ACJNI_FOLLOW_SYMLINKS <path>
> diff --git a/m4/ax_prog_jar.m4 b/m4/ax_prog_jar.m4
> index 3c60fcaf..d474912a 100644
> --- a/m4/ax_prog_jar.m4
> +++ b/m4/ax_prog_jar.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#        http://www.gnu.org/software/autoconf-archive/ax_prog_jar.html
> +#       https://www.gnu.org/software/autoconf-archive/ax_prog_jar.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -37,7 +37,7 @@
> #   and this notice are preserved. This file is offered as-is, without any
> #   warranty.
> 
> -#serial 7
> +#serial 8
> 
> AU_ALIAS([AC_PROG_JAR], [AX_PROG_JAR])
> AC_DEFUN([AX_PROG_JAR],[
> diff --git a/m4/ax_prog_java.m4 b/m4/ax_prog_java.m4
> index 03961db5..c2e6964e 100644
> --- a/m4/ax_prog_java.m4
> +++ b/m4/ax_prog_java.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#       http://www.gnu.org/software/autoconf-archive/ax_prog_java.html
> +#       https://www.gnu.org/software/autoconf-archive/ax_prog_java.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -85,7 +85,7 @@
> #   Public License for more details.
> #
> #   You should have received a copy of the GNU General Public License along
> -#   with this program. If not, see <http://www.gnu.org/licenses/>.
> +#   with this program. If not, see <https://www.gnu.org/licenses/>.
> #
> #   As a special exception, the respective Autoconf Macro's copyright owner
> #   gives unlimited permission to copy, distribute and modify the configure
> @@ -100,7 +100,7 @@
> #   modified version of the Autoconf Macro, you may extend this special
> #   exception to the GPL to apply to your modified version as well.
> 
> -#serial 9
> +#serial 10
> 
> AU_ALIAS([AC_PROG_JAVA], [AX_PROG_JAVA])
> AC_DEFUN([AX_PROG_JAVA],[
> diff --git a/m4/ax_prog_java_works.m4 b/m4/ax_prog_java_works.m4
> index 54e132af..bc705261 100644
> --- a/m4/ax_prog_java_works.m4
> +++ b/m4/ax_prog_java_works.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#    http://www.gnu.org/software/autoconf-archive/ax_prog_java_works.html
> +#    https://www.gnu.org/software/autoconf-archive/ax_prog_java_works.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -32,7 +32,7 @@
> #   Public License for more details.
> #
> #   You should have received a copy of the GNU General Public License along
> -#   with this program. If not, see <http://www.gnu.org/licenses/>.
> +#   with this program. If not, see <https://www.gnu.org/licenses/>.
> #
> #   As a special exception, the respective Autoconf Macro's copyright owner
> #   gives unlimited permission to copy, distribute and modify the configure
> @@ -47,57 +47,16 @@
> #   modified version of the Autoconf Macro, you may extend this special
> #   exception to the GPL to apply to your modified version as well.
> 
> -#serial 9
> +#serial 11
> 
> AU_ALIAS([AC_PROG_JAVA_WORKS], [AX_PROG_JAVA_WORKS])
> AC_DEFUN([AX_PROG_JAVA_WORKS], [
> -AC_PATH_PROG(UUDECODE, uudecode, [no])
> -if test x$UUDECODE != xno; then
> -AC_CACHE_CHECK([if uudecode can decode base 64 file],
> ac_cv_prog_uudecode_base64, [
> -dnl /**
> -dnl  * Test.java: used to test if java compiler works.
> -dnl  */
> -dnl public class Test
> -dnl {
> -dnl
> -dnl public static void
> -dnl main( String[] argv )
> -dnl {
> -dnl     System.exit (0);
> -dnl }
> -dnl
> -dnl }
> -cat << \EOF > Test.uue
> -begin-base64 644 Test.class
> -yv66vgADAC0AFQcAAgEABFRlc3QHAAQBABBqYXZhL2xhbmcvT2JqZWN0AQAE
> -bWFpbgEAFihbTGphdmEvbGFuZy9TdHJpbmc7KVYBAARDb2RlAQAPTGluZU51
> -bWJlclRhYmxlDAAKAAsBAARleGl0AQAEKEkpVgoADQAJBwAOAQAQamF2YS9s
> -YW5nL1N5c3RlbQEABjxpbml0PgEAAygpVgwADwAQCgADABEBAApTb3VyY2VG
> -aWxlAQAJVGVzdC5qYXZhACEAAQADAAAAAAACAAkABQAGAAEABwAAACEAAQAB
> -AAAABQO4AAyxAAAAAQAIAAAACgACAAAACgAEAAsAAQAPABAAAQAHAAAAIQAB
> -AAEAAAAFKrcAErEAAAABAAgAAAAKAAIAAAAEAAQABAABABMAAAACABQ=
> -====
> -EOF
> -if $UUDECODE Test.uue; then
> -        ac_cv_prog_uudecode_base64=yes
> -else
> -        echo "configure: __oline__: uudecode had trouble decoding base 64 file
> 'Test.uue'" >&AS_MESSAGE_LOG_FD
> -        echo "configure: failed file was:" >&AS_MESSAGE_LOG_FD
> -        cat Test.uue >&AS_MESSAGE_LOG_FD
> -        ac_cv_prog_uudecode_base64=no
> -fi
> -rm -f Test.uue])
> -fi
> -if test x$ac_cv_prog_uudecode_base64 != xyes; then
> -        rm -f Test.class
> -        AC_MSG_WARN([I have to compile Test.class from scratch])
>         if test x$ac_cv_prog_javac_works = xno; then
>                 AC_MSG_ERROR([Cannot compile java source. $JAVAC does not work properly])
>         fi
>         if test x$ac_cv_prog_javac_works = x; then
>                 AX_PROG_JAVAC
>         fi
> -fi
> AC_CACHE_CHECK(if $JAVA works, ac_cv_prog_java_works, [
> JAVA_TEST=Test.java
> CLASS_TEST=Test.class
> @@ -111,7 +70,6 @@ public static void main (String args[]) {
> } }
> EOF
> changequote([, ])dnl
> -if test x$ac_cv_prog_uudecode_base64 != xyes; then
>         if AC_TRY_COMMAND($JAVAC $JAVACFLAGS $JAVA_TEST) && test -s $CLASS_TEST; then
>                 :
>         else
> @@ -119,7 +77,6 @@ if test x$ac_cv_prog_uudecode_base64 != xyes; then
>           cat $JAVA_TEST >&AS_MESSAGE_LOG_FD
>           AC_MSG_ERROR(The Java compiler $JAVAC failed (see config.log, check the
>           CLASSPATH?))
>         fi
> -fi
> if AC_TRY_COMMAND($JAVA -classpath . $JAVAFLAGS $TEST) >/dev/null 2>&1; then
>   ac_cv_prog_java_works=yes
> else
> @@ -127,7 +84,7 @@ else
>   cat $JAVA_TEST >&AS_MESSAGE_LOG_FD
>   AC_MSG_ERROR(The Java VM $JAVA failed (see config.log, check the CLASSPATH?))
> fi
> -rm -fr $JAVA_TEST $CLASS_TEST Test.uue
> +rm -f $JAVA_TEST $CLASS_TEST
> ])
> AC_PROVIDE([$0])dnl
> ]
> diff --git a/m4/ax_prog_javac.m4 b/m4/ax_prog_javac.m4
> index d061243c..8abb733f 100644
> --- a/m4/ax_prog_javac.m4
> +++ b/m4/ax_prog_javac.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#       http://www.gnu.org/software/autoconf-archive/ax_prog_javac.html
> +#      https://www.gnu.org/software/autoconf-archive/ax_prog_javac.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -49,7 +49,7 @@
> #   Public License for more details.
> #
> #   You should have received a copy of the GNU General Public License along
> -#   with this program. If not, see <http://www.gnu.org/licenses/>.
> +#   with this program. If not, see <https://www.gnu.org/licenses/>.
> #
> #   As a special exception, the respective Autoconf Macro's copyright owner
> #   gives unlimited permission to copy, distribute and modify the configure
> @@ -64,7 +64,7 @@
> #   modified version of the Autoconf Macro, you may extend this special
> #   exception to the GPL to apply to your modified version as well.
> 
> -#serial 7
> +#serial 8
> 
> AU_ALIAS([AC_PROG_JAVAC], [AX_PROG_JAVAC])
> AC_DEFUN([AX_PROG_JAVAC],[
> diff --git a/m4/ax_prog_javac_works.m4 b/m4/ax_prog_javac_works.m4
> index 7dfa1e37..9b48149d 100644
> --- a/m4/ax_prog_javac_works.m4
> +++ b/m4/ax_prog_javac_works.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#    http://www.gnu.org/software/autoconf-archive/ax_prog_javac_works.html
> +#   https://www.gnu.org/software/autoconf-archive/ax_prog_javac_works.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -32,7 +32,7 @@
> #   Public License for more details.
> #
> #   You should have received a copy of the GNU General Public License along
> -#   with this program. If not, see <http://www.gnu.org/licenses/>.
> +#   with this program. If not, see <https://www.gnu.org/licenses/>.
> #
> #   As a special exception, the respective Autoconf Macro's copyright owner
> #   gives unlimited permission to copy, distribute and modify the configure
> @@ -47,7 +47,7 @@
> #   modified version of the Autoconf Macro, you may extend this special
> #   exception to the GPL to apply to your modified version as well.
> 
> -#serial 6
> +#serial 7
> 
> AU_ALIAS([AC_PROG_JAVAC_WORKS], [AX_PROG_JAVAC_WORKS])
> AC_DEFUN([AX_PROG_JAVAC_WORKS],[
> diff --git a/m4/ax_prog_javah.m4 b/m4/ax_prog_javah.m4
> index 2809f29c..935ec896 100644
> --- a/m4/ax_prog_javah.m4
> +++ b/m4/ax_prog_javah.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#       http://www.gnu.org/software/autoconf-archive/ax_prog_javah.html
> +#      https://www.gnu.org/software/autoconf-archive/ax_prog_javah.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -21,7 +21,7 @@
> #   and this notice are preserved. This file is offered as-is, without any
> #   warranty.
> 
> -#serial 7
> +#serial 11
> 
> AU_ALIAS([AC_PROG_JAVAH], [AX_PROG_JAVAH])
> AC_DEFUN([AX_PROG_JAVAH],[
> @@ -30,18 +30,35 @@ AC_REQUIRE([AC_PROG_CPP])dnl
> AC_PATH_PROG(JAVAH,javah)
> AS_IF([test -n "$ac_cv_path_JAVAH"],
>       [
> -        AC_TRY_CPP([#include <jni.h>],,[
> +        AC_PREPROC_IFELSE([AC_LANG_SOURCE([[#include <jni.h>]])],[],[
>         ac_save_CPPFLAGS="$CPPFLAGS"
> -        ax_prog_javah_bin_dir=`AS_DIRNAME([$ac_cv_path_JAVAH])`
> -        ac_dir="`AS_DIRNAME([$ax_prog_javah_bin])`/include"
> +        _ACJAVAH_FOLLOW_SYMLINKS("$ac_cv_path_JAVAH")
> +        ax_prog_javah_bin_dir=`AS_DIRNAME([$_ACJAVAH_FOLLOWED])`
> +        ac_dir="`AS_DIRNAME([$ax_prog_javah_bin_dir])`/include"
>         AS_CASE([$build_os],
> -                [cygwin*],
> +                [cygwin*|mingw*],
>                 [ac_machdep=win32],
>                 [ac_machdep=`AS_ECHO($build_os) | sed 's,[[-0-9]].*,,'`])
>         CPPFLAGS="$ac_save_CPPFLAGS -I$ac_dir -I$ac_dir/$ac_machdep"
> -        AC_TRY_CPP([#include <jni.h>],
> -                   ac_save_CPPFLAGS="$CPPFLAGS",
> -                   AC_MSG_WARN([unable to include <jni.h>]))
> +        AC_PREPROC_IFELSE([AC_LANG_SOURCE([[#include <jni.h>]])],
> +                          [ac_save_CPPFLAGS="$CPPFLAGS"],
> +                          [AC_MSG_WARN([unable to include <jni.h>])])
>         CPPFLAGS="$ac_save_CPPFLAGS"])
>       ])
> ])
> +
> +AC_DEFUN([_ACJAVAH_FOLLOW_SYMLINKS],[
> +# find the include directory relative to the javac executable
> +_cur="$1"
> +while ls -ld "$_cur" 2>/dev/null | grep " -> " >/dev/null; do
> +        AC_MSG_CHECKING([symlink for $_cur])
> +        _slink=`ls -ld "$_cur" | sed 's/.* -> //'`
> +        case "$_slink" in
> +        /*) _cur="$_slink";;
> +        # 'X' avoids triggering unwanted echo options.
> +        *) _cur=`echo "X$_cur" | sed -e 's/^X//' -e 's:[[^/]]*$::'`"$_slink";;
> +        esac
> +        AC_MSG_RESULT([$_cur])
> +done
> +_ACJAVAH_FOLLOWED="$_cur"
> +])
> diff --git a/m4/ax_sys_weak_alias.m4 b/m4/ax_sys_weak_alias.m4
> index e1bfd336..733b1ddd 100644
> --- a/m4/ax_sys_weak_alias.m4
> +++ b/m4/ax_sys_weak_alias.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#     http://www.gnu.org/software/autoconf-archive/ax_sys_weak_alias.html
> +#    https://www.gnu.org/software/autoconf-archive/ax_sys_weak_alias.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -22,8 +22,8 @@
> #   another object file.
> #
> #   There are four known schemes of declaring weak symbols; each scheme is
> -#   checked in turn, and the first one found is prefered. Note that only one
> -#   of the mentioned preprocessor macros will be defined!
> +#   checked in turn, and the first one found is preferred. Note that only
> +#   one of the mentioned preprocessor macros will be defined!
> #
> #   1. Function attributes
> #
> @@ -110,7 +110,7 @@
> #   and this notice are preserved. This file is offered as-is, without any
> #   warranty.
> 
> -#serial 6
> +#serial 8
> 
> AU_ALIAS([KLM_SYS_WEAK_ALIAS], [AX_SYS_WEAK_ALIAS])
> AC_DEFUN([AX_SYS_WEAK_ALIAS], [
> diff --git a/m4/ax_try_compile_java.m4 b/m4/ax_try_compile_java.m4
> index a8ed6b2a..245c36c4 100644
> --- a/m4/ax_try_compile_java.m4
> +++ b/m4/ax_try_compile_java.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#    http://www.gnu.org/software/autoconf-archive/ax_try_compile_java.html
> +#   https://www.gnu.org/software/autoconf-archive/ax_try_compile_java.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -29,7 +29,7 @@
> #   and this notice are preserved. This file is offered as-is, without any
> #   warranty.
> 
> -#serial 8
> +#serial 10
> 
> AU_ALIAS([AC_TRY_COMPILE_JAVA], [AX_TRY_COMPILE_JAVA])
> AC_DEFUN([AX_TRY_COMPILE_JAVA],[
> @@ -48,8 +48,8 @@ dnl Don't remove the temporary files here, so they can be
> examined.
> else
>   echo "configure: failed program was:" >&AS_MESSAGE_LOG_FD
>   cat Test.java >&AS_MESSAGE_LOG_FD
> -ifelse([$4], , , [  rm -fr Test.java Test.class
> +ifelse([$4], , , [  rm -f Test.java Test.class
>   $4
> ])dnl
> fi
> -rm -fr Test.java Test.class])
> +rm -f Test.java Test.class])
> diff --git a/m4/ax_try_run_java.m4 b/m4/ax_try_run_java.m4
> index c680f03f..2ebb86d6 100644
> --- a/m4/ax_try_run_java.m4
> +++ b/m4/ax_try_run_java.m4
> @@ -1,5 +1,5 @@
> # ===========================================================================
> -#      http://www.gnu.org/software/autoconf-archive/ax_try_run_java.html
> +#     https://www.gnu.org/software/autoconf-archive/ax_try_run_java.html
> # ===========================================================================
> #
> # SYNOPSIS
> @@ -29,7 +29,7 @@
> #   and this notice are preserved. This file is offered as-is, without any
> #   warranty.
> 
> -#serial 2
> +#serial 3
> 
> AU_ALIAS([AC_TRY_RUN_JAVA], [AX_TRY_RUN_JAVA])
> AC_DEFUN([AX_TRY_RUN_JAVA],[
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
