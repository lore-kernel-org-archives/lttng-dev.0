From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Tests: Java agent: Add
 configure switches to enable tests
Date: Thu, 6 Aug 2015 16:36:05 -0400
Message-ID: <CA+jJMxsxiE54n3zmEeQLxJ0zcY1ATnM_k7XX0DtqtMxbkMjLMA__5284.46905450455$1438893428$gmane$org@mail.gmail.com>
References: <1438879153-21852-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0531573929=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZNRta-0006rN-Nn
 for lttng-dev@lists.lttng.org; Thu, 06 Aug 2015 16:36:12 -0400
Received: by ykcq64 with SMTP id q64so67798084ykc.2
 for <lttng-dev@lists.lttng.org>; Thu, 06 Aug 2015 13:36:05 -0700 (PDT)
In-Reply-To: <1438879153-21852-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>, Alexandre Montplaisir <alexmonthy@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0531573929==
Content-Type: multipart/alternative; boundary=001a1139d2bae72af7051caa775d

--001a1139d2bae72af7051caa775d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged, thanks!

As discussed with Jonathan and Michael, we'll add a default "auto-detect"
mode to enable those as available on the system if neither enable-test-* or
disable-test-* are provided.

J=C3=A9r=C3=A9mie

On Thu, Aug 6, 2015 at 12:39 PM, Michael Jeanson <mjeanson@efficios.com>
wrote:

> This patch adds the switches --enable-test-java-agent-(jul|log4j|all) to
> the configure script, the tests now need to be explicitly enabled and
> their dependencies are only checked if so.
>
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  configure.ac                                | 94
> ++++++++++++++++++++---------
>  tests/regression/ust/java-jul/Makefile.am   |  4 +-
>  tests/regression/ust/java-log4j/Makefile.am |  4 +-
>  3 files changed, 69 insertions(+), 33 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index bfef178..4e6c06e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -131,6 +131,25 @@ AC_ARG_WITH([lttng-system-rundir],
>         [LTTNG_SYSTEM_RUNDIR=3D"/var/run/lttng"])
>  AC_SUBST([LTTNG_SYSTEM_RUNDIR])
>
> +AC_ARG_ENABLE([test-java-agent-jul],
> +       [AS_HELP_STRING([--enable-test-java-agent-jul],[enable the LTTng
> UST Java agent JUL tests [default=3Dno]])],
> +       [test_java_agent_jul=3D$enableval],
> +       [test_java_agent_jul=3Dno]
> +)
> +
> +AC_ARG_ENABLE([test-java-agent-log4j],
> +        [AS_HELP_STRING([--enable-test-java-agent-log4j],[enable the
> LTTng UST Java agent Log4j tests [default=3Dno]])],
> +        [test_java_agent_log4j=3D$enableval],
> +        [test_java_agent_log4j=3Dno]
> +)
> +
> +AC_ARG_ENABLE([test-java-agent-all],
> +        [AS_HELP_STRING([--enable-test-java-agent-all],[enable all the
> LTTng UST Java agent tests [default=3Dno]])],
> +        [test_java_agent_jul=3D$enableval
> +         test_java_agent_log4j=3D$enableval],
> +        [:]
> +)
> +
>  AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_BIN], "$CONSUMERD32_BIN",
> [Location of the 32-bit consumerd executable.])
>  AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD64_BIN], "$CONSUMERD64_BIN",
> [Location of the 64-bit consumerd executable])
>  AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_LIBDIR], "$CONSUMERD32_LIBDIR",
> [Search for consumerd 32-bit libraries in this location.])
> @@ -355,44 +374,45 @@ AX_CONFIG_FEATURE(
>  )
>  AM_CONDITIONAL([COMPAT_EPOLL], [ test "$enable_epoll" =3D "yes" ])
>
> -AX_JAVA_OPTIONS
> -AX_PROG_JAVAC
> -AX_PROG_JAVA
> -AX_PROG_JAR
> +AM_CONDITIONAL([TEST_JAVA_JUL_AGENT], [test "x$test_java_agent_jul" =3D
> "xyes"])
> +AM_CONDITIONAL([TEST_JAVA_LOG4J_AGENT], [test "x$test_java_agent_log4j" =
=3D
> "xyes"])
>
> -AX_CHECK_CLASSPATH
> +if test "x$test_java_agent_jul" =3D "xyes" || test
> "x$test_java_agent_log4j" =3D "xyes"; then
> +       AX_JAVA_OPTIONS
> +       AX_PROG_JAVAC
> +       AX_PROG_JAVA
> +       AX_PROG_JAR
>
> -# Check for Java UST agent common class first
> -AX_CHECK_CLASS(org.lttng.ust.agent.AbstractLttngAgent)
> -if test "x$ac_cv_class_org_lttng_ust_agent_AbstractLttngAgent" =3D "xyes=
";
> then
> -       java_agent_common=3Dyes
> -else
> -       java_agent_common=3Dno
> -fi
> -
> -# If the common class is available, test for each agent
> -if test "x$java_agent_common" =3D "xyes"; then
> -       # Check for JUL
> -       AX_CHECK_CLASS(org.lttng.ust.agent.jul.LttngLogHandler)
> -       AX_CHECK_CLASS(org.lttng.ust.agent.log4j.LttngLogAppender)
> -       AX_CHECK_CLASS(org.apache.log4j.Logger)
> +       AX_CHECK_CLASSPATH
>
> -       build_java_jul_agent=3Dno
> -       if test "x$ac_cv_class_org_lttng_ust_agent_jul_LttngLogHandler" =
=3D
> "xyes"; then
> -               build_java_jul_agent=3Dyes
> +       # Check for Java UST agent common class first
> +       AX_CHECK_CLASS(org.lttng.ust.agent.AbstractLttngAgent)
> +       if test "x$ac_cv_class_org_lttng_ust_agent_AbstractLttngAgent" =
=3D
> "xno"; then
> +               AC_MSG_ERROR([The UST Java agent common class was not
> found. Please specify the location of the jar via the Java CLASSPATH e.g:
> export CLASSPATH=3D"/path/to/lttng-ust-agent-common.jar"])
>         fi
>
> -       build_java_log4j_agent=3Dno
> -       if test "x$ac_cv_class_org_lttng_ust_agent_log4j_LttngLogAppender=
"
> =3D "xyes"; then
> -               if test "x$ac_cv_class_org_apache_log4j_Logger" =3D "xyes=
";
> then
> -                       build_java_log4j_agent=3Dyes
> +       if test "x$test_java_agent_jul" =3D "xyes"; then
> +               # Check for JUL agent class
> +               AX_CHECK_CLASS(org.lttng.ust.agent.jul.LttngLogHandler)
> +               if test
> "x$ac_cv_class_org_lttng_ust_agent_jul_LttngLogHandler" =3D "xno"; then
> +                       AC_MSG_ERROR([The UST Java agent JUL class was no=
t
> found. Please specify the location of the jar via the Java CLASSPATH e.g:
> export CLASSPATH=3D"/path/to/lttng-ust-agent-jul.jar"])
>                 fi
>         fi
>
> -fi
> +       if test "x$test_java_agent_log4j" =3D "xyes"; then
> +               # Check for Log4j agent class
> +               AX_CHECK_CLASS(org.lttng.ust.agent.log4j.LttngLogAppender=
)
> +               if test
> "x$ac_cv_class_org_lttng_ust_agent_log4j_LttngLogAppender" =3D "xno"; the=
n
> +                       AC_MSG_ERROR([The UST Java agent Log4j class was
> not found. Please specify the location of the jar via the Java CLASSPATH
> e.g: export CLASSPATH=3D"/path/to/lttng-ust-agent-log4j.jar"])
> +               fi
>
> -AM_CONDITIONAL([BUILD_JAVA_JUL_AGENT], [test "x$build_java_jul_agent" =
=3D
> "xyes"])
> -AM_CONDITIONAL([BUILD_JAVA_LOG4J_AGENT], [test "x$build_java_log4j_agent=
"
> =3D "xyes"])
> +               # Check for Log4j class
> +               AX_CHECK_CLASS(org.apache.log4j.Logger)
> +               if test "x$ac_cv_class_org_apache_log4j_Logger" =3D "xno"=
;
> then
> +                       AC_MSG_ERROR([The Log4j class was not found.
> Please specify the location of the jar via the Java CLASSPATH e.g: export
> CLASSPATH=3D"/path/to/log4j.jar"])
> +               fi
> +       fi
> +fi
>
>  AC_SYS_LARGEFILE
>
> @@ -570,6 +590,22 @@ AS_IF([test "x$lttng_ust_support" =3D "xyes"],[
>         AS_ECHO("Disabled")
>  ])
>
> +# LTTng UST Java agent JUL tests enabled/disabled
> +AS_ECHO_N("LTTng-UST Java agent JUL tests: ")
> +AS_IF([test "x$test_java_agent_jul" =3D "xyes"],[
> +       AS_ECHO("Enabled")
> +],[
> +       AS_ECHO("Disabled")
> +])
> +
> +# LTTng UST Java agent Log4j tests enabled/disabled
> +AS_ECHO_N("LTTng-UST Java agent Log4j tests: ")
> +AS_IF([test "x$test_java_agent_log4j" =3D "xyes"],[
> +       AS_ECHO("Enabled")
> +],[
> +       AS_ECHO("Disabled")
> +])
> +
>  #Python binding enabled/disabled
>  AS_ECHO_N("Python binding: ")
>  AS_IF([test "x${enable_python:-yes}" =3D xyes], [
> diff --git a/tests/regression/ust/java-jul/Makefile.am
> b/tests/regression/ust/java-jul/Makefile.am
> index 877237f..b0a04f3 100644
> --- a/tests/regression/ust/java-jul/Makefile.am
> +++ b/tests/regression/ust/java-jul/Makefile.am
> @@ -3,9 +3,9 @@ JAVAROOT =3D .
>  noinst_SCRIPTS =3D test_java_jul JTestLTTng.java
>  EXTRA_DIST =3D test_java_jul JTestLTTng.java
>
> -if BUILD_JAVA_JUL_AGENT
> +if TEST_JAVA_JUL_AGENT
>  dist_noinst_JAVA =3D JTestLTTng.java
> -endif # BUILD_JAVA_JUL_AGENT
> +endif # TEST_JAVA_JUL_AGENT
>
>  all-local: static_file
>
> diff --git a/tests/regression/ust/java-log4j/Makefile.am
> b/tests/regression/ust/java-log4j/Makefile.am
> index 42daab8..60d5c37 100644
> --- a/tests/regression/ust/java-log4j/Makefile.am
> +++ b/tests/regression/ust/java-log4j/Makefile.am
> @@ -3,9 +3,9 @@ JAVAROOT =3D .
>  noinst_SCRIPTS =3D test_java_log4j JTestLTTng.java
>  EXTRA_DIST =3D test_java_log4j JTestLTTng.java
>
> -if BUILD_JAVA_LOG4J_AGENT
> +if TEST_JAVA_LOG4J_AGENT
>  dist_noinst_JAVA =3D JTestLTTng.java
> -endif # BUILD_JAVA_LOG4J_AGENT
> +endif # TEST_JAVA_LOG4J_AGENT
>
>  all-local: static_file
>
> --
> 1.9.1
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a1139d2bae72af7051caa775d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged, thanks!<div><br></div><div>As discussed with Jonat=
han and Michael, we&#39;ll add a default &quot;auto-detect&quot; mode to en=
able those as available on the system if neither enable-test-* or disable-t=
est-* are provided.</div><div><br></div><div>J=C3=A9r=C3=A9mie</div></div><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Aug 6, 201=
5 at 12:39 PM, Michael Jeanson <span dir=3D"ltr">&lt;<a href=3D"mailto:mjea=
nson@efficios.com" target=3D"_blank">mjeanson@efficios.com</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">This patch adds the switches --enab=
le-test-java-agent-(jul|log4j|all) to<br>
the configure script, the tests now need to be explicitly enabled and<br>
their dependencies are only checked if so.<br>
<br>
Signed-off-by: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com"=
>mjeanson@efficios.com</a>&gt;<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 94 +++++++++++++++++=
+++---------<br>
=C2=A0tests/regression/ust/java-jul/Makefile.am=C2=A0 =C2=A0|=C2=A0 4 +-<br=
>
=C2=A0tests/regression/ust/java-log4j/Makefile.am |=C2=A0 4 +-<br>
=C2=A03 files changed, 69 insertions(+), 33 deletions(-)<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index bfef178..4e6c06e 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -131,6 +131,25 @@ AC_ARG_WITH([lttng-system-rundir],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [LTTNG_SYSTEM_RUNDIR=3D&quot;/var/run/lttng&quo=
t;])<br>
=C2=A0AC_SUBST([LTTNG_SYSTEM_RUNDIR])<br>
<br>
+AC_ARG_ENABLE([test-java-agent-jul],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[AS_HELP_STRING([--enable-test-java-agent-jul],=
[enable the LTTng UST Java agent JUL tests [default=3Dno]])],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[test_java_agent_jul=3D$enableval],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[test_java_agent_jul=3Dno]<br>
+)<br>
+<br>
+AC_ARG_ENABLE([test-java-agent-log4j],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-test-java-agent-log4=
j],[enable the LTTng UST Java agent Log4j tests [default=3Dno]])],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [test_java_agent_log4j=3D$enableval],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [test_java_agent_log4j=3Dno]<br>
+)<br>
+<br>
+AC_ARG_ENABLE([test-java-agent-all],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-test-java-agent-all]=
,[enable all the LTTng UST Java agent tests [default=3Dno]])],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [test_java_agent_jul=3D$enableval<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_java_agent_log4j=3D$enableval],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [:]<br>
+)<br>
+<br>
=C2=A0AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_BIN], &quot;$CONSUMERD32_BIN&q=
uot;, [Location of the 32-bit consumerd executable.])<br>
=C2=A0AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD64_BIN], &quot;$CONSUMERD64_BIN&q=
uot;, [Location of the 64-bit consumerd executable])<br>
=C2=A0AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_LIBDIR], &quot;$CONSUMERD32_LI=
BDIR&quot;, [Search for consumerd 32-bit libraries in this location.])<br>
@@ -355,44 +374,45 @@ AX_CONFIG_FEATURE(<br>
=C2=A0)<br>
=C2=A0AM_CONDITIONAL([COMPAT_EPOLL], [ test &quot;$enable_epoll&quot; =3D &=
quot;yes&quot; ])<br>
<br>
-AX_JAVA_OPTIONS<br>
-AX_PROG_JAVAC<br>
-AX_PROG_JAVA<br>
-AX_PROG_JAR<br>
+AM_CONDITIONAL([TEST_JAVA_JUL_AGENT], [test &quot;x$test_java_agent_jul&qu=
ot; =3D &quot;xyes&quot;])<br>
+AM_CONDITIONAL([TEST_JAVA_LOG4J_AGENT], [test &quot;x$test_java_agent_log4=
j&quot; =3D &quot;xyes&quot;])<br>
<br>
-AX_CHECK_CLASSPATH<br>
+if test &quot;x$test_java_agent_jul&quot; =3D &quot;xyes&quot; || test &qu=
ot;x$test_java_agent_log4j&quot; =3D &quot;xyes&quot;; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_JAVA_OPTIONS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_PROG_JAVAC<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_PROG_JAVA<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_PROG_JAR<br>
<br>
-# Check for Java UST agent common class first<br>
-AX_CHECK_CLASS(org.lttng.ust.agent.AbstractLttngAgent)<br>
-if test &quot;x$ac_cv_class_org_lttng_ust_agent_AbstractLttngAgent&quot; =
=3D &quot;xyes&quot;; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0java_agent_common=3Dyes<br>
-else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0java_agent_common=3Dno<br>
-fi<br>
-<br>
-# If the common class is available, test for each agent<br>
-if test &quot;x$java_agent_common&quot; =3D &quot;xyes&quot;; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Check for JUL<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_CHECK_CLASS(org.lttng.ust.agent.jul.LttngLog=
Handler)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_CHECK_CLASS(org.lttng.ust.agent.log4j.LttngL=
ogAppender)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_CHECK_CLASS(org.apache.log4j.Logger)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_CHECK_CLASSPATH<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0build_java_jul_agent=3Dno<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x$ac_cv_class_org_lttng_ust_agent=
_jul_LttngLogHandler&quot; =3D &quot;xyes&quot;; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_java_jul_agen=
t=3Dyes<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Check for Java UST agent common class first<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_CHECK_CLASS(org.lttng.ust.agent.AbstractLttn=
gAgent)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x$ac_cv_class_org_lttng_ust_agent=
_AbstractLttngAgent&quot; =3D &quot;xno&quot;; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_ERROR([The U=
ST Java agent common class was not found. Please specify the location of th=
e jar via the Java CLASSPATH e.g: export CLASSPATH=3D&quot;/path/to/lttng-u=
st-agent-common.jar&quot;])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0build_java_log4j_agent=3Dno<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x$ac_cv_class_org_lttng_ust_agent=
_log4j_LttngLogAppender&quot; =3D &quot;xyes&quot;; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x$ac_=
cv_class_org_apache_log4j_Logger&quot; =3D &quot;xyes&quot;; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0build_java_log4j_agent=3Dyes<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x$test_java_agent_jul&quot; =3D &=
quot;xyes&quot;; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Check for JUL age=
nt class<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AX_CHECK_CLASS(org.=
lttng.ust.agent.jul.LttngLogHandler)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x$ac_=
cv_class_org_lttng_ust_agent_jul_LttngLogHandler&quot; =3D &quot;xno&quot;;=
 then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_ERROR([The UST Java agent JUL class was not found. Please =
specify the location of the jar via the Java CLASSPATH e.g: export CLASSPAT=
H=3D&quot;/path/to/lttng-ust-agent-jul.jar&quot;])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x$test_java_agent_log4j&quot; =3D=
 &quot;xyes&quot;; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Check for Log4j a=
gent class<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AX_CHECK_CLASS(org.=
lttng.ust.agent.log4j.LttngLogAppender)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x$ac_=
cv_class_org_lttng_ust_agent_log4j_LttngLogAppender&quot; =3D &quot;xno&quo=
t;; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_ERROR([The UST Java agent Log4j class was not found. Pleas=
e specify the location of the jar via the Java CLASSPATH e.g: export CLASSP=
ATH=3D&quot;/path/to/lttng-ust-agent-log4j.jar&quot;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
<br>
-AM_CONDITIONAL([BUILD_JAVA_JUL_AGENT], [test &quot;x$build_java_jul_agent&=
quot; =3D &quot;xyes&quot;])<br>
-AM_CONDITIONAL([BUILD_JAVA_LOG4J_AGENT], [test &quot;x$build_java_log4j_ag=
ent&quot; =3D &quot;xyes&quot;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Check for Log4j c=
lass<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AX_CHECK_CLASS(org.=
apache.log4j.Logger)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x$ac_=
cv_class_org_apache_log4j_Logger&quot; =3D &quot;xno&quot;; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_ERROR([The Log4j class was not found. Please specify the l=
ocation of the jar via the Java CLASSPATH e.g: export CLASSPATH=3D&quot;/pa=
th/to/log4j.jar&quot;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+fi<br>
<br>
=C2=A0AC_SYS_LARGEFILE<br>
<br>
@@ -570,6 +590,22 @@ AS_IF([test &quot;x$lttng_ust_support&quot; =3D &quot;=
xyes&quot;],[<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 AS_ECHO(&quot;Disabled&quot;)<br>
=C2=A0])<br>
<br>
+# LTTng UST Java agent JUL tests enabled/disabled<br>
+AS_ECHO_N(&quot;LTTng-UST Java agent JUL tests: &quot;)<br>
+AS_IF([test &quot;x$test_java_agent_jul&quot; =3D &quot;xyes&quot;],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_ECHO(&quot;Enabled&quot;)<br>
+],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_ECHO(&quot;Disabled&quot;)<br>
+])<br>
+<br>
+# LTTng UST Java agent Log4j tests enabled/disabled<br>
+AS_ECHO_N(&quot;LTTng-UST Java agent Log4j tests: &quot;)<br>
+AS_IF([test &quot;x$test_java_agent_log4j&quot; =3D &quot;xyes&quot;],[<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_ECHO(&quot;Enabled&quot;)<br>
+],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_ECHO(&quot;Disabled&quot;)<br>
+])<br>
+<br>
=C2=A0#Python binding enabled/disabled<br>
=C2=A0AS_ECHO_N(&quot;Python binding: &quot;)<br>
=C2=A0AS_IF([test &quot;x${enable_python:-yes}&quot; =3D xyes], [<br>
diff --git a/tests/regression/ust/java-jul/Makefile.am b/tests/regression/u=
st/java-jul/Makefile.am<br>
index 877237f..b0a04f3 100644<br>
--- a/tests/regression/ust/java-jul/Makefile.am<br>
+++ b/tests/regression/ust/java-jul/Makefile.am<br>
@@ -3,9 +3,9 @@ JAVAROOT =3D .<br>
=C2=A0noinst_SCRIPTS =3D test_java_jul JTestLTTng.java<br>
=C2=A0EXTRA_DIST =3D test_java_jul JTestLTTng.java<br>
<br>
-if BUILD_JAVA_JUL_AGENT<br>
+if TEST_JAVA_JUL_AGENT<br>
=C2=A0dist_noinst_JAVA =3D JTestLTTng.java<br>
-endif # BUILD_JAVA_JUL_AGENT<br>
+endif # TEST_JAVA_JUL_AGENT<br>
<br>
=C2=A0all-local: static_file<br>
<br>
diff --git a/tests/regression/ust/java-log4j/Makefile.am b/tests/regression=
/ust/java-log4j/Makefile.am<br>
index 42daab8..60d5c37 100644<br>
--- a/tests/regression/ust/java-log4j/Makefile.am<br>
+++ b/tests/regression/ust/java-log4j/Makefile.am<br>
@@ -3,9 +3,9 @@ JAVAROOT =3D .<br>
=C2=A0noinst_SCRIPTS =3D test_java_log4j JTestLTTng.java<br>
=C2=A0EXTRA_DIST =3D test_java_log4j JTestLTTng.java<br>
<br>
-if BUILD_JAVA_LOG4J_AGENT<br>
+if TEST_JAVA_LOG4J_AGENT<br>
=C2=A0dist_noinst_JAVA =3D JTestLTTng.java<br>
-endif # BUILD_JAVA_LOG4J_AGENT<br>
+endif # TEST_JAVA_LOG4J_AGENT<br>
<br>
=C2=A0all-local: static_file<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--001a1139d2bae72af7051caa775d--


--===============0531573929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0531573929==--
