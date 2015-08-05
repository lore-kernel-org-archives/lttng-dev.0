From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Tests: Java agent: update after
	Java agent refactoring
Date: Wed, 5 Aug 2015 12:08:18 -0400
Message-ID: <CA+jJMxuWpP_vVWzFUS1CSvfUYsLZjVM8ZYLzAjjXpTaSAfw8Xg__11661.3608938225$1438790990$gmane$org@mail.gmail.com>
References: <1438726900-17234-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0553551778=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZN1Eu-0006VI-2B
 for lttng-dev@lists.lttng.org; Wed, 05 Aug 2015 12:08:27 -0400
Received: by ykeo23 with SMTP id o23so39190043yke.3
 for <lttng-dev@lists.lttng.org>; Wed, 05 Aug 2015 09:08:18 -0700 (PDT)
In-Reply-To: <1438726900-17234-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0553551778==
Content-Type: multipart/alternative; boundary=001a114e61ae65075b051c929c46

--001a114e61ae65075b051c929c46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged, thanks!

J=C3=A9r=C3=A9mie

On Tue, Aug 4, 2015 at 6:21 PM, Michael Jeanson <mjeanson@efficios.com>
wrote:

> This patch fixes the Java agent tests which were impossible to run since
> the Jar files have been renamed. It also overhauls the java part of the
> configure script to match what's in UST and replace some hardcoded path
> with configurable values.
>
> The tests are now enabled when corresponding classes are found in the
> CLASSPATH during configure.
>
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  .gitignore                                      |  2 +
>  config/ax_check_class.m4                        |  2 +-
>  configure.ac                                    | 80
> +++++++++----------------
>  tests/regression/ust/java-jul/JTestLTTng.java   | 34 ++++++++---
>  tests/regression/ust/java-jul/Makefile.am       | 21 ++-----
>  tests/regression/ust/java-jul/test_java_jul     |  4 +-
>  tests/regression/ust/java-log4j/JTestLTTng.java | 38 +++++++++---
>  tests/regression/ust/java-log4j/Makefile.am     | 17 +-----
>  tests/regression/ust/java-log4j/test_java_log4j |  4 +-
>  9 files changed, 99 insertions(+), 103 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index ff19c8d..5d24bec 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -93,3 +93,5 @@ health_check
>  /benchmark/
>
>  /include/version.h
> +
> +classnoinst.stamp
> diff --git a/config/ax_check_class.m4 b/config/ax_check_class.m4
> index 098aa77..42b51d7 100644
> --- a/config/ax_check_class.m4
> +++ b/config/ax_check_class.m4
> @@ -118,7 +118,7 @@ EOF
>                          ac_cv_prog_uudecode_base64=3Dno
>                  fi
>          rm -f Test.uue
> -        if AC_TRY_COMMAND($JAVA $JAVAFLAGS Test $1) >/dev/null 2>&1; the=
n
> +        if AC_TRY_COMMAND($JAVA -classpath ".:$CLASSPATH" $JAVAFLAGS Tes=
t
> $1) >/dev/null 2>&1; then
>                  eval "ac_cv_class_$ac_var_name=3Dyes"
>          else
>                  eval "ac_cv_class_$ac_var_name=3Dno"
> diff --git a/configure.ac b/configure.ac
> index 2fc6e53..bfef178 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -355,65 +355,43 @@ AX_CONFIG_FEATURE(
>  )
>  AM_CONDITIONAL([COMPAT_EPOLL], [ test "$enable_epoll" =3D "yes" ])
>
> -# Set compile flags to java include files if given. This is only used to
> -# compile java agent tests.
> -AC_ARG_WITH([java-jdk],
> -       [AS_HELP_STRING([--with-java-jdk=3DDIR],[use the Java JDK in DIR.=
 Ex
> : $JAVA_HOME.])],
> -       [JAVA_JDK=3D$withval],
> -       [JAVA_JDK=3D""]
> -)
> -AM_CONDITIONAL([HAVE_JAVA_JDK], [test $JAVA_JDK], [Java JDK path])
> -AC_SUBST([JAVA_JDK])
> +AX_JAVA_OPTIONS
> +AX_PROG_JAVAC
> +AX_PROG_JAVA
> +AX_PROG_JAR
>
> -AS_IF([test $JAVA_JDK],[
> -       AS_IF([test -d $JAVA_JDK],
> -               [
> -                       AC_MSG_RESULT([using Java includes in $JAVA_SDK])
> -                       SUBDIRS=3D`find $JAVA_JDK/include -type d`
> -                       CPPFLAGS+=3D" "
> -                       CPPFLAGS+=3D`for x in $SUBDIRS; do echo -n "-I$x =
";
> done`
> -                       CPPFLAGS+=3D" "
> -        ],[AC_MSG_ERROR(Unable to find Java include files in $JAVA_JDK)]
> -       )
> -])
> +AX_CHECK_CLASSPATH
>
> -# Check for the UST agent jar file in the system. Hardcoded path is adde=
d
> here
> -# since we have *no* idea where this could be installed. Note that this
> is only
> -# used for agent testing.
> -AC_MSG_CHECKING(Java UST agent jar file)
> -java_agent_jar_path=3D"${prefix}/share/java/liblttng-ust-agent.jar"
> -if test -f $java_agent_jar_path; then
> -       build_java_agent=3Dyes
> -       AC_MSG_RESULT(found)
> +# Check for Java UST agent common class first
> +AX_CHECK_CLASS(org.lttng.ust.agent.AbstractLttngAgent)
> +if test "x$ac_cv_class_org_lttng_ust_agent_AbstractLttngAgent" =3D "xyes=
";
> then
> +       java_agent_common=3Dyes
>  else
> -       build_java_agent=3Dno
> -       AC_MSG_RESULT(not found)
> +       java_agent_common=3Dno
>  fi
> -AM_CONDITIONAL([BUILD_JAVA_AGENT], [test "x$build_java_agent" =3D "xyes"=
])
> -AC_SUBST([java_agent_jar_path])
> -
> -# Check for log4j support on the system to know if we can build or not t=
he
> -# log4j tests.
> -if test "x$build_java_agent" =3D "xyes"; then
> -       AC_MSG_CHECKING(Java agent support for log4j)
> -       AX_JAVA_OPTIONS
> -       AX_PROG_JAR
> -       AX_PROG_JAVA
> -       AX_PROG_JAVAC
> -
> -       # By default, use a commonly used classpath on the system to ease
> things up
> -       # for the Java testing in this directory.
> -
>  LOG4J_CLASSPATH=3D"$java_agent_jar_path:$CLASSPATH:.:/usr/share/java/*"
> -       JAVAFLAGS=3D"-cp $LOG4J_CLASSPATH"
> -       JAVACFLAGS=3D"$JAVAFLAGS"
> +
> +# If the common class is available, test for each agent
> +if test "x$java_agent_common" =3D "xyes"; then
> +       # Check for JUL
> +       AX_CHECK_CLASS(org.lttng.ust.agent.jul.LttngLogHandler)
> +       AX_CHECK_CLASS(org.lttng.ust.agent.log4j.LttngLogAppender)
>         AX_CHECK_CLASS(org.apache.log4j.Logger)
>
> -       if test "x$ac_cv_class_org_apache_log4j_Logger" =3D "xno"; then
> -               build_java_log4j_agent=3Dno
> -       else
> -               build_java_log4j_agent=3Dyes
> +       build_java_jul_agent=3Dno
> +       if test "x$ac_cv_class_org_lttng_ust_agent_jul_LttngLogHandler" =
=3D
> "xyes"; then
> +               build_java_jul_agent=3Dyes
>         fi
> +
> +       build_java_log4j_agent=3Dno
> +       if test "x$ac_cv_class_org_lttng_ust_agent_log4j_LttngLogAppender=
"
> =3D "xyes"; then
> +               if test "x$ac_cv_class_org_apache_log4j_Logger" =3D "xyes=
";
> then
> +                       build_java_log4j_agent=3Dyes
> +               fi
> +       fi
> +
>  fi
> +
> +AM_CONDITIONAL([BUILD_JAVA_JUL_AGENT], [test "x$build_java_jul_agent" =
=3D
> "xyes"])
>  AM_CONDITIONAL([BUILD_JAVA_LOG4J_AGENT], [test "x$build_java_log4j_agent=
"
> =3D "xyes"])
>
>  AC_SYS_LARGEFILE
> diff --git a/tests/regression/ust/java-jul/JTestLTTng.java
> b/tests/regression/ust/java-jul/JTestLTTng.java
> index 9431551..741d820 100644
> --- a/tests/regression/ust/java-jul/JTestLTTng.java
> +++ b/tests/regression/ust/java-jul/JTestLTTng.java
> @@ -1,4 +1,5 @@
>  /*
> + * Copyright (C) 2015 - Michael Jeanson <mjeanson@efficios.com>
>   * Copyright (C) 2013 - David Goulet <dgoulet@efficios.com>
>   *
>   * This program is free software; you can redistribute it and/or modify =
it
> @@ -15,20 +16,29 @@
>   * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>   */
>
> +import java.io.IOException;
>  import java.lang.Integer;
> +import java.util.logging.Handler;
>  import java.util.logging.Logger;
>  import java.util.logging.Level;
>
> -import org.lttng.ust.agent.LTTngAgent;
> +import org.lttng.ust.agent.jul.LttngLogHandler;
>
> -public class JTestLTTng
> -{
> -       private static LTTngAgent lttngAgent;
> +public class JTestLTTng {
> +
> +       /**
> +        * Application start
> +        *
> +        * @param args
> +        *            Command-line arguments
> +        * @throws IOException
> +        * @throws InterruptedException
> +        */
> +       public static void main(String args[]) throws IOException,
> InterruptedException {
>
> -       public static void main(String args[]) throws Exception
> -       {
>                 Logger lttng =3D Logger.getLogger("JTestLTTng");
>                 Logger lttng2 =3D Logger.getLogger("JTestLTTng2");
> +
>                 int nrIter =3D Integer.parseInt(args[0]);
>                 int waitTime =3D Integer.parseInt(args[1]);
>                 int fire_finest_tp =3D 0;
> @@ -41,7 +51,11 @@ public class JTestLTTng
>                         fire_second_tp =3D Integer.parseInt(args[3]);
>                 }
>
> -               lttngAgent =3D LTTngAgent.getLTTngAgent();
> +               /* Instantiate a LTTngLogHandler object, and attach it to
> our loggers */
> +               Handler lttngHandler =3D new LttngLogHandler();
> +               lttng.addHandler(lttngHandler);
> +               lttng2.addHandler(lttngHandler);
> +
>                 lttng.setLevel(Level.FINEST);
>
>                 for (int iter =3D 0; iter < nrIter; iter++) {
> @@ -57,6 +71,10 @@ public class JTestLTTng
>                         lttng2.info("JUL second logger fired");
>                 }
>
> -               lttngAgent.dispose();
> +               /*
> +                * Do not forget to close() all handlers so that the agen=
t
> can shutdown
> +                * and the session daemon socket gets cleaned up
> explicitly.
> +                */
> +               lttngHandler.close();
>         }
>  }
> diff --git a/tests/regression/ust/java-jul/Makefile.am
> b/tests/regression/ust/java-jul/Makefile.am
> index 286e3df..877237f 100644
> --- a/tests/regression/ust/java-jul/Makefile.am
> +++ b/tests/regression/ust/java-jul/Makefile.am
> @@ -1,25 +1,13 @@
> +JAVAROOT =3D .
>
>  noinst_SCRIPTS =3D test_java_jul JTestLTTng.java
>  EXTRA_DIST =3D test_java_jul JTestLTTng.java
>
> -if HAVE_JAVA_JDK
> -JCC=3D$(JAVA_JDK)/bin/javac
> -else
> -JCC=3Djavac
> -endif
> +if BUILD_JAVA_JUL_AGENT
> +dist_noinst_JAVA =3D JTestLTTng.java
> +endif # BUILD_JAVA_JUL_AGENT
>
> -AGENT_JAR_FILE=3D$(java_agent_jar_path)
> -
> -
> -# Still need to copy test files in case of out of tree build
> -if BUILD_JAVA_AGENT
> -all-local: static_file JTestLTTng.class
> -%.class: %.java
> -       $(JCC) -d "$(builddir)" -cp "$(AGENT_JAR_FILE):." $<
> -else
>  all-local: static_file
> -endif # BUILD_JAVA_AGENT
> -
>
>  static_file:
>         @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
> @@ -28,7 +16,6 @@ static_file:
>                 done; \
>         fi
>
> -
>  clean-local:
>         rm -f *.class
>         @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
> diff --git a/tests/regression/ust/java-jul/test_java_jul
> b/tests/regression/ust/java-jul/test_java_jul
> index 48c8b74..f9f244b 100755
> --- a/tests/regression/ust/java-jul/test_java_jul
> +++ b/tests/regression/ust/java-jul/test_java_jul
> @@ -27,7 +27,7 @@ TESTAPP_PATH=3D"$CURDIR/$TESTAPP_NAME"
>  SESSION_NAME=3D"jul"
>  EVENT_NAME=3D"JTestLTTng"
>  EVENT_NAME2=3D"JTestLTTng2"
>
> -JAVA_CP=3D"$CURDIR:/usr/local/share/java/liblttng-ust-agent.jar:/usr/sha=
re/java/liblttng-ust-agent.jar"
> +JAVA_CP=3D"$CURDIR:$CLASSPATH"
>
>  NUM_TESTS=3D155
>
> @@ -39,7 +39,7 @@ function run_app
>         local fire_second_tp=3D$2
>
>         #FIXME: app should have synchro.
> -       java -cp $JAVA_CP -Djava.library.path=3D"/usr/local/lib:/usr/lib"
> $TESTAPP_NAME $NR_ITER $NR_MSEC_WAIT $finest_tp $fire_second_tp >/dev/nul=
l
> 2>&1
> +       java -cp $JAVA_CP
> -Djava.library.path=3D"$LD_LIBRARY_PATH:/usr/local/lib:/usr/lib"
> $TESTAPP_NAME $NR_ITER $NR_MSEC_WAIT $finest_tp $fire_second_tp >/dev/nul=
l
> 2>&1
>  }
>
>  function run_app_background
> diff --git a/tests/regression/ust/java-log4j/JTestLTTng.java
> b/tests/regression/ust/java-log4j/JTestLTTng.java
> index 0019cb8..64a471b 100644
> --- a/tests/regression/ust/java-log4j/JTestLTTng.java
> +++ b/tests/regression/ust/java-log4j/JTestLTTng.java
> @@ -1,4 +1,5 @@
>  /*
> + * Copyright (C) 2015 - Michael Jeanson <dgoulet@efficios.com>
>   * Copyright (C) 2014 - David Goulet <dgoulet@efficios.com>
>   *                      Christian Babeux <christian.babeux@efficios.com>
>   *
> @@ -19,19 +20,26 @@
>  import java.io.IOException;
>  import java.lang.Integer;
>
> -import org.apache.log4j.Logger;
> +import org.apache.log4j.Appender;
>  import org.apache.log4j.BasicConfigurator;
> +import org.apache.log4j.Logger;
> +import org.lttng.ust.agent.log4j.LttngLogAppender;
>
> -import org.lttng.ust.agent.LTTngAgent;
> +public class JTestLTTng {
>
> -public class JTestLTTng
> -{
> -       private static LTTngAgent lttngAgent;
> +       /**
> +        * Application start
> +        *
> +        * @param args
> +        *            Command-line arguments
> +        * @throws IOException
> +        * @throws InterruptedException
> +        */
> +       public static void main(String args[]) throws IOException,
> InterruptedException {
>
> -       public static void main(String args[]) throws Exception
> -       {
>                 Logger lttng =3D Logger.getLogger("log4j-event");
>                 Logger lttng2 =3D Logger.getLogger("log4j-event-2");
> +
>                 int nrIter =3D Integer.parseInt(args[0]);
>                 int waitTime =3D Integer.parseInt(args[1]);
>                 int fire_debug_tp =3D 0;
> @@ -44,8 +52,16 @@ public class JTestLTTng
>                         fire_second_tp =3D Integer.parseInt(args[3]);
>                 }
>
> +               /* Start with the default Log4j configuration, which logs
> to console */
>                 BasicConfigurator.configure();
> -               lttngAgent =3D LTTngAgent.getLTTngAgent();
> +
> +               /*
> +                * Add a LTTng log appender to both loggers, which will
> also send the
> +                * logged events to UST.
> +                */
> +               Appender lttngAppender =3D new LttngLogAppender();
> +               lttng.addAppender(lttngAppender);
> +               lttng2.addAppender(lttngAppender);
>
>                 for (int iter =3D 0; iter < nrIter; iter++) {
>                         lttng.info("LOG4J tp fired!");
> @@ -59,5 +75,11 @@ public class JTestLTTng
>                 if (fire_second_tp =3D=3D 1) {
>                         lttng2.info("LOG4J second logger fired");
>                 }
> +
> +               /*
> +                * Do not forget to close() all handlers so that the agen=
t
> can shutdown
> +                * and the session daemon socket gets cleaned up
> explicitly.
> +                */
> +               lttngAppender.close();
>         }
>  }
> diff --git a/tests/regression/ust/java-log4j/Makefile.am
> b/tests/regression/ust/java-log4j/Makefile.am
> index 7d6c048..42daab8 100644
> --- a/tests/regression/ust/java-log4j/Makefile.am
> +++ b/tests/regression/ust/java-log4j/Makefile.am
> @@ -1,24 +1,13 @@
> +JAVAROOT =3D .
>
>  noinst_SCRIPTS =3D test_java_log4j JTestLTTng.java
>  EXTRA_DIST =3D test_java_log4j JTestLTTng.java
>
> -if HAVE_JAVA_JDK
> -JCC=3D$(JAVA_JDK)/bin/javac
> -else
> -JCC=3Djavac
> -endif
> -
> -# We still need to copy static files for out of tree and dist build
>  if BUILD_JAVA_LOG4J_AGENT
> -all-local: static_file JTestLTTng.class
> -
> -%.class: %.java
> -       $(JCC) -d "$(builddir)" $(JAVACFLAGS) $<
> -else
> -all-local: static_file
> +dist_noinst_JAVA =3D JTestLTTng.java
>  endif # BUILD_JAVA_LOG4J_AGENT
>
> -JTestLTTng.class: JTestLTTng.java
> +all-local: static_file
>
>  static_file:
>         @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
> diff --git a/tests/regression/ust/java-log4j/test_java_log4j
> b/tests/regression/ust/java-log4j/test_java_log4j
> index cdc0c4c..d5c6621 100755
> --- a/tests/regression/ust/java-log4j/test_java_log4j
> +++ b/tests/regression/ust/java-log4j/test_java_log4j
> @@ -27,7 +27,7 @@ TESTAPP_PATH=3D"$CURDIR/$TESTAPP_NAME"
>  SESSION_NAME=3D"log4j"
>  EVENT_NAME=3D"log4j-event"
>  EVENT_NAME2=3D"log4j-event-2"
>
> -JAVA_CP=3D"$CURDIR:/usr/local/share/java/liblttng-ust-agent.jar:/usr/sha=
re/java/*"
> +JAVA_CP=3D"$CURDIR:$CLASSPATH"
>  OUTPUT_DEST=3D"/dev/null"
>
>  NUM_TESTS=3D155
> @@ -40,7 +40,7 @@ function run_app
>         local fire_second_tp=3D$2
>
>         # FIXME: test app should have synchro.
> -       java -cp $JAVA_CP -Djava.library.path=3D"/usr/local/lib:/usr/lib"
> $TESTAPP_NAME $NR_ITER $NR_MSEC_WAIT $debug_tp $fire_second_tp >/dev/null
> 2>&1
> +       java -cp $JAVA_CP
> -Djava.library.path=3D"$LD_LIBRARY_PATH:/usr/local/lib:/usr/lib"
> $TESTAPP_NAME $NR_ITER $NR_MSEC_WAIT $debug_tp $fire_second_tp >/dev/null
> 2>&1
>  }
>
>  function run_app_background
> --
> 1.9.1
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a114e61ae65075b051c929c46
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged, thanks!<div><br></div><div>J=C3=A9r=C3=A9mie</div>=
</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Aug=
 4, 2015 at 6:21 PM, Michael Jeanson <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:mjeanson@efficios.com" target=3D"_blank">mjeanson@efficios.com</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">This patch fixes the Java age=
nt tests which were impossible to run since<br>
the Jar files have been renamed. It also overhauls the java part of the<br>
configure script to match what&#39;s in UST and replace some hardcoded path=
<br>
with configurable values.<br>
<br>
The tests are now enabled when corresponding classes are found in the<br>
CLASSPATH during configure.<br>
<br>
Signed-off-by: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com"=
>mjeanson@efficios.com</a>&gt;<br>
---<br>
=C2=A0.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 +<br>
=C2=A0config/ax_check_class.m4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 80 +++=
++++++----------------<br>
=C2=A0tests/regression/ust/java-jul/JTestLTTng.java=C2=A0 =C2=A0| 34 ++++++=
++---<br>
=C2=A0tests/regression/ust/java-jul/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 21 ++-----<br>
=C2=A0tests/regression/ust/java-jul/test_java_jul=C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 +-<br>
=C2=A0tests/regression/ust/java-log4j/JTestLTTng.java | 38 +++++++++---<br>
=C2=A0tests/regression/ust/java-log4j/Makefile.am=C2=A0 =C2=A0 =C2=A0| 17 +=
-----<br>
=C2=A0tests/regression/ust/java-log4j/test_java_log4j |=C2=A0 4 +-<br>
=C2=A09 files changed, 99 insertions(+), 103 deletions(-)<br>
<br>
diff --git a/.gitignore b/.gitignore<br>
index ff19c8d..5d24bec 100644<br>
--- a/.gitignore<br>
+++ b/.gitignore<br>
@@ -93,3 +93,5 @@ health_check<br>
=C2=A0/benchmark/<br>
<br>
=C2=A0/include/version.h<br>
+<br>
+classnoinst.stamp<br>
diff --git a/config/ax_check_class.m4 b/config/ax_check_class.m4<br>
index 098aa77..42b51d7 100644<br>
--- a/config/ax_check_class.m4<br>
+++ b/config/ax_check_class.m4<br>
@@ -118,7 +118,7 @@ EOF<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ac_cv_prog_uudecode_base64=3Dno<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f Test.uue<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if AC_TRY_COMMAND($JAVA $JAVAFLAGS Test $1) &g=
t;/dev/null 2&gt;&amp;1; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if AC_TRY_COMMAND($JAVA -classpath &quot;.:$CL=
ASSPATH&quot; $JAVAFLAGS Test $1) &gt;/dev/null 2&gt;&amp;1; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eval &quot;ac=
_cv_class_$ac_var_name=3Dyes&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eval &quot;ac=
_cv_class_$ac_var_name=3Dno&quot;<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index 2fc6e53..bfef178 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -355,65 +355,43 @@ AX_CONFIG_FEATURE(<br>
=C2=A0)<br>
=C2=A0AM_CONDITIONAL([COMPAT_EPOLL], [ test &quot;$enable_epoll&quot; =3D &=
quot;yes&quot; ])<br>
<br>
-# Set compile flags to java include files if given. This is only used to<b=
r>
-# compile java agent tests.<br>
-AC_ARG_WITH([java-jdk],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[AS_HELP_STRING([--with-java-jdk=3DDIR],[use th=
e Java JDK in DIR. Ex : $JAVA_HOME.])],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[JAVA_JDK=3D$withval],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[JAVA_JDK=3D&quot;&quot;]<br>
-)<br>
-AM_CONDITIONAL([HAVE_JAVA_JDK], [test $JAVA_JDK], [Java JDK path])<br>
-AC_SUBST([JAVA_JDK])<br>
+AX_JAVA_OPTIONS<br>
+AX_PROG_JAVAC<br>
+AX_PROG_JAVA<br>
+AX_PROG_JAR<br>
<br>
-AS_IF([test $JAVA_JDK],[<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_IF([test -d $JAVA_JDK],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_RESULT([using Java includes in $JAVA_SDK])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SUBDIRS=3D`find $JAVA_JDK/include -type d`<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0CPPFLAGS+=3D&quot; &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0CPPFLAGS+=3D`for x in $SUBDIRS; do echo -n &quot;-I$x &quot;; don=
e`<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0CPPFLAGS+=3D&quot; &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],[AC_MSG_ERROR(Unable to find Java include fi=
les in $JAVA_JDK)]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
-])<br>
+AX_CHECK_CLASSPATH<br>
<br>
-# Check for the UST agent jar file in the system. Hardcoded path is added =
here<br>
-# since we have *no* idea where this could be installed. Note that this is=
 only<br>
-# used for agent testing.<br>
-AC_MSG_CHECKING(Java UST agent jar file)<br>
-java_agent_jar_path=3D&quot;${prefix}/share/java/liblttng-ust-agent.jar&qu=
ot;<br>
-if test -f $java_agent_jar_path; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0build_java_agent=3Dyes<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_RESULT(found)<br>
+# Check for Java UST agent common class first<br>
+AX_CHECK_CLASS(org.lttng.ust.agent.AbstractLttngAgent)<br>
+if test &quot;x$ac_cv_class_org_lttng_ust_agent_AbstractLttngAgent&quot; =
=3D &quot;xyes&quot;; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0java_agent_common=3Dyes<br>
=C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0build_java_agent=3Dno<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_RESULT(not found)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0java_agent_common=3Dno<br>
=C2=A0fi<br>
-AM_CONDITIONAL([BUILD_JAVA_AGENT], [test &quot;x$build_java_agent&quot; =
=3D &quot;xyes&quot;])<br>
-AC_SUBST([java_agent_jar_path])<br>
-<br>
-# Check for log4j support on the system to know if we can build or not the=
<br>
-# log4j tests.<br>
-if test &quot;x$build_java_agent&quot; =3D &quot;xyes&quot;; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_CHECKING(Java agent support for log4j)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_JAVA_OPTIONS<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_PROG_JAR<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_PROG_JAVA<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_PROG_JAVAC<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# By default, use a commonly used classpath on =
the system to ease things up<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# for the Java testing in this directory.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0LOG4J_CLASSPATH=3D&quot;$java_agent_jar_path:$C=
LASSPATH:.:/usr/share/java/*&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0JAVAFLAGS=3D&quot;-cp $LOG4J_CLASSPATH&quot;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0JAVACFLAGS=3D&quot;$JAVAFLAGS&quot;<br>
+<br>
+# If the common class is available, test for each agent<br>
+if test &quot;x$java_agent_common&quot; =3D &quot;xyes&quot;; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Check for JUL<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_CHECK_CLASS(org.lttng.ust.agent.jul.LttngLog=
Handler)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AX_CHECK_CLASS(org.lttng.ust.agent.log4j.LttngL=
ogAppender)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 AX_CHECK_CLASS(org.apache.log4j.Logger)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x$ac_cv_class_org_apache_log4j_Lo=
gger&quot; =3D &quot;xno&quot;; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_java_log4j_ag=
ent=3Dno<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_java_log4j_ag=
ent=3Dyes<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0build_java_jul_agent=3Dno<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x$ac_cv_class_org_lttng_ust_agent=
_jul_LttngLogHandler&quot; =3D &quot;xyes&quot;; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_java_jul_agen=
t=3Dyes<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0build_java_log4j_agent=3Dno<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x$ac_cv_class_org_lttng_ust_agent=
_log4j_LttngLogAppender&quot; =3D &quot;xyes&quot;; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x$ac_=
cv_class_org_apache_log4j_Logger&quot; =3D &quot;xyes&quot;; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0build_java_log4j_agent=3Dyes<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
=C2=A0fi<br>
+<br>
+AM_CONDITIONAL([BUILD_JAVA_JUL_AGENT], [test &quot;x$build_java_jul_agent&=
quot; =3D &quot;xyes&quot;])<br>
=C2=A0AM_CONDITIONAL([BUILD_JAVA_LOG4J_AGENT], [test &quot;x$build_java_log=
4j_agent&quot; =3D &quot;xyes&quot;])<br>
<br>
=C2=A0AC_SYS_LARGEFILE<br>
diff --git a/tests/regression/ust/java-jul/JTestLTTng.java b/tests/regressi=
on/ust/java-jul/JTestLTTng.java<br>
index 9431551..741d820 100644<br>
--- a/tests/regression/ust/java-jul/JTestLTTng.java<br>
+++ b/tests/regression/ust/java-jul/JTestLTTng.java<br>
@@ -1,4 +1,5 @@<br>
=C2=A0/*<br>
+ * Copyright (C) 2015 - Michael Jeanson &lt;<a href=3D"mailto:mjeanson@eff=
icios.com">mjeanson@efficios.com</a>&gt;<br>
=C2=A0 * Copyright (C) 2013 - David Goulet &lt;<a href=3D"mailto:dgoulet@ef=
ficios.com">dgoulet@efficios.com</a>&gt;<br>
=C2=A0 *<br>
=C2=A0 * This program is free software; you can redistribute it and/or modi=
fy it<br>
@@ -15,20 +16,29 @@<br>
=C2=A0 * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
=C2=A0 */<br>
<br>
+import java.io.IOException;<br>
=C2=A0import java.lang.Integer;<br>
+import java.util.logging.Handler;<br>
=C2=A0import java.util.logging.Logger;<br>
=C2=A0import java.util.logging.Level;<br>
<br>
-import org.lttng.ust.agent.LTTngAgent;<br>
+import org.lttng.ust.agent.jul.LttngLogHandler;<br>
<br>
-public class JTestLTTng<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0private static LTTngAgent lttngAgent;<br>
+public class JTestLTTng {<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Application start<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * @param args<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Com=
mand-line arguments<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * @throws IOException<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * @throws InterruptedException<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0public static void main(String args[]) throws I=
OException, InterruptedException {<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0public static void main(String args[]) throws E=
xception<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Logger lttng =3D Lo=
gger.getLogger(&quot;JTestLTTng&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Logger lttng2 =3D L=
ogger.getLogger(&quot;JTestLTTng2&quot;);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int nrIter =3D Inte=
ger.parseInt(args[0]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int waitTime =3D In=
teger.parseInt(args[1]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int fire_finest_tp =
=3D 0;<br>
@@ -41,7 +51,11 @@ public class JTestLTTng<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fire_second_tp =3D Integer.parseInt(args[3]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttngAgent =3D LTTn=
gAgent.getLTTngAgent();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Instantiate a LT=
TngLogHandler object, and attach it to our loggers */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Handler lttngHandle=
r =3D new LttngLogHandler();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttng.addHandler(lt=
tngHandler);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttng2.addHandler(l=
ttngHandler);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng.setLevel(Leve=
l.FINEST);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int iter =3D 0=
; iter &lt; nrIter; iter++) {<br>
@@ -57,6 +71,10 @@ public class JTestLTTng<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <a href=3D"http://lttng2.info" rel=3D"noreferrer" target=3D"_bla=
nk">lttng2.info</a>(&quot;JUL second logger fired&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttngAgent.dispose(=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Do not forget to=
 close() all handlers so that the agent can shutdown<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * and the session =
daemon socket gets cleaned up explicitly.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttngHandler.close(=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
diff --git a/tests/regression/ust/java-jul/Makefile.am b/tests/regression/u=
st/java-jul/Makefile.am<br>
index 286e3df..877237f 100644<br>
--- a/tests/regression/ust/java-jul/Makefile.am<br>
+++ b/tests/regression/ust/java-jul/Makefile.am<br>
@@ -1,25 +1,13 @@<br>
+JAVAROOT =3D .<br>
<br>
=C2=A0noinst_SCRIPTS =3D test_java_jul JTestLTTng.java<br>
=C2=A0EXTRA_DIST =3D test_java_jul JTestLTTng.java<br>
<br>
-if HAVE_JAVA_JDK<br>
-JCC=3D$(JAVA_JDK)/bin/javac<br>
-else<br>
-JCC=3Djavac<br>
-endif<br>
+if BUILD_JAVA_JUL_AGENT<br>
+dist_noinst_JAVA =3D JTestLTTng.java<br>
+endif # BUILD_JAVA_JUL_AGENT<br>
<br>
-AGENT_JAR_FILE=3D$(java_agent_jar_path)<br>
-<br>
-<br>
-# Still need to copy test files in case of out of tree build<br>
-if BUILD_JAVA_AGENT<br>
-all-local: static_file JTestLTTng.class<br>
-%.class: %.java<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(JCC) -d &quot;$(builddir)&quot; -cp &quot;$(A=
GENT_JAR_FILE):.&quot; $&lt;<br>
-else<br>
=C2=A0all-local: static_file<br>
-endif # BUILD_JAVA_AGENT<br>
-<br>
<br>
=C2=A0static_file:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @if [ x&quot;$(srcdir)&quot; !=3D x&quot;$(buil=
ddir)&quot; ]; then \<br>
@@ -28,7 +16,6 @@ static_file:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 done; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-<br>
=C2=A0clean-local:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f *.class<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @if [ x&quot;$(srcdir)&quot; !=3D x&quot;$(buil=
ddir)&quot; ]; then \<br>
diff --git a/tests/regression/ust/java-jul/test_java_jul b/tests/regression=
/ust/java-jul/test_java_jul<br>
index 48c8b74..f9f244b 100755<br>
--- a/tests/regression/ust/java-jul/test_java_jul<br>
+++ b/tests/regression/ust/java-jul/test_java_jul<br>
@@ -27,7 +27,7 @@ TESTAPP_PATH=3D&quot;$CURDIR/$TESTAPP_NAME&quot;<br>
=C2=A0SESSION_NAME=3D&quot;jul&quot;<br>
=C2=A0EVENT_NAME=3D&quot;JTestLTTng&quot;<br>
=C2=A0EVENT_NAME2=3D&quot;JTestLTTng2&quot;<br>
-JAVA_CP=3D&quot;$CURDIR:/usr/local/share/java/liblttng-ust-agent.jar:/usr/=
share/java/liblttng-ust-agent.jar&quot;<br>
+JAVA_CP=3D&quot;$CURDIR:$CLASSPATH&quot;<br>
<br>
=C2=A0NUM_TESTS=3D155<br>
<br>
@@ -39,7 +39,7 @@ function run_app<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local fire_second_tp=3D$2<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #FIXME: app should have synchro.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0java -cp $JAVA_CP -Djava.library.path=3D&quot;/=
usr/local/lib:/usr/lib&quot; $TESTAPP_NAME $NR_ITER $NR_MSEC_WAIT $finest_t=
p $fire_second_tp &gt;/dev/null 2&gt;&amp;1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0java -cp $JAVA_CP -Djava.library.path=3D&quot;$=
LD_LIBRARY_PATH:/usr/local/lib:/usr/lib&quot; $TESTAPP_NAME $NR_ITER $NR_MS=
EC_WAIT $finest_tp $fire_second_tp &gt;/dev/null 2&gt;&amp;1<br>
=C2=A0}<br>
<br>
=C2=A0function run_app_background<br>
diff --git a/tests/regression/ust/java-log4j/JTestLTTng.java b/tests/regres=
sion/ust/java-log4j/JTestLTTng.java<br>
index 0019cb8..64a471b 100644<br>
--- a/tests/regression/ust/java-log4j/JTestLTTng.java<br>
+++ b/tests/regression/ust/java-log4j/JTestLTTng.java<br>
@@ -1,4 +1,5 @@<br>
=C2=A0/*<br>
+ * Copyright (C) 2015 - Michael Jeanson &lt;<a href=3D"mailto:dgoulet@effi=
cios.com">dgoulet@efficios.com</a>&gt;<br>
=C2=A0 * Copyright (C) 2014 - David Goulet &lt;<a href=3D"mailto:dgoulet@ef=
ficios.com">dgoulet@efficios.com</a>&gt;<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Christian Babeux &lt;<a href=3D"mailto:christian.babeux@efficios=
.com">christian.babeux@efficios.com</a>&gt;<br>
=C2=A0 *<br>
@@ -19,19 +20,26 @@<br>
=C2=A0import java.io.IOException;<br>
=C2=A0import java.lang.Integer;<br>
<br>
-import org.apache.log4j.Logger;<br>
+import org.apache.log4j.Appender;<br>
=C2=A0import org.apache.log4j.BasicConfigurator;<br>
+import org.apache.log4j.Logger;<br>
+import org.lttng.ust.agent.log4j.LttngLogAppender;<br>
<br>
-import org.lttng.ust.agent.LTTngAgent;<br>
+public class JTestLTTng {<br>
<br>
-public class JTestLTTng<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0private static LTTngAgent lttngAgent;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Application start<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * @param args<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Com=
mand-line arguments<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * @throws IOException<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * @throws InterruptedException<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0public static void main(String args[]) throws I=
OException, InterruptedException {<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0public static void main(String args[]) throws E=
xception<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Logger lttng =3D Lo=
gger.getLogger(&quot;log4j-event&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Logger lttng2 =3D L=
ogger.getLogger(&quot;log4j-event-2&quot;);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int nrIter =3D Inte=
ger.parseInt(args[0]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int waitTime =3D In=
teger.parseInt(args[1]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int fire_debug_tp =
=3D 0;<br>
@@ -44,8 +52,16 @@ public class JTestLTTng<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fire_second_tp =3D Integer.parseInt(args[3]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Start with the d=
efault Log4j configuration, which logs to console */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BasicConfigurator.c=
onfigure();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttngAgent =3D LTTn=
gAgent.getLTTngAgent();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Add a LTTng log =
appender to both loggers, which will also send the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * logged events to=
 UST.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Appender lttngAppen=
der =3D new LttngLogAppender();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttng.addAppender(l=
ttngAppender);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttng2.addAppender(=
lttngAppender);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int iter =3D 0=
; iter &lt; nrIter; iter++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <a href=3D"http://lttng.info" rel=3D"noreferrer" target=3D"_blan=
k">lttng.info</a>(&quot;LOG4J tp fired!&quot;);<br>
@@ -59,5 +75,11 @@ public class JTestLTTng<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fire_second_tp =
=3D=3D 1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <a href=3D"http://lttng2.info" rel=3D"noreferrer" target=3D"_bla=
nk">lttng2.info</a>(&quot;LOG4J second logger fired&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Do not forget to=
 close() all handlers so that the agent can shutdown<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * and the session =
daemon socket gets cleaned up explicitly.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttngAppender.close=
();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
diff --git a/tests/regression/ust/java-log4j/Makefile.am b/tests/regression=
/ust/java-log4j/Makefile.am<br>
index 7d6c048..42daab8 100644<br>
--- a/tests/regression/ust/java-log4j/Makefile.am<br>
+++ b/tests/regression/ust/java-log4j/Makefile.am<br>
@@ -1,24 +1,13 @@<br>
+JAVAROOT =3D .<br>
<br>
=C2=A0noinst_SCRIPTS =3D test_java_log4j JTestLTTng.java<br>
=C2=A0EXTRA_DIST =3D test_java_log4j JTestLTTng.java<br>
<br>
-if HAVE_JAVA_JDK<br>
-JCC=3D$(JAVA_JDK)/bin/javac<br>
-else<br>
-JCC=3Djavac<br>
-endif<br>
-<br>
-# We still need to copy static files for out of tree and dist build<br>
=C2=A0if BUILD_JAVA_LOG4J_AGENT<br>
-all-local: static_file JTestLTTng.class<br>
-<br>
-%.class: %.java<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(JCC) -d &quot;$(builddir)&quot; $(JAVACFLAGS)=
 $&lt;<br>
-else<br>
-all-local: static_file<br>
+dist_noinst_JAVA =3D JTestLTTng.java<br>
=C2=A0endif # BUILD_JAVA_LOG4J_AGENT<br>
<br>
-JTestLTTng.class: JTestLTTng.java<br>
+all-local: static_file<br>
<br>
=C2=A0static_file:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @if [ x&quot;$(srcdir)&quot; !=3D x&quot;$(buil=
ddir)&quot; ]; then \<br>
diff --git a/tests/regression/ust/java-log4j/test_java_log4j b/tests/regres=
sion/ust/java-log4j/test_java_log4j<br>
index cdc0c4c..d5c6621 100755<br>
--- a/tests/regression/ust/java-log4j/test_java_log4j<br>
+++ b/tests/regression/ust/java-log4j/test_java_log4j<br>
@@ -27,7 +27,7 @@ TESTAPP_PATH=3D&quot;$CURDIR/$TESTAPP_NAME&quot;<br>
=C2=A0SESSION_NAME=3D&quot;log4j&quot;<br>
=C2=A0EVENT_NAME=3D&quot;log4j-event&quot;<br>
=C2=A0EVENT_NAME2=3D&quot;log4j-event-2&quot;<br>
-JAVA_CP=3D&quot;$CURDIR:/usr/local/share/java/liblttng-ust-agent.jar:/usr/=
share/java/*&quot;<br>
+JAVA_CP=3D&quot;$CURDIR:$CLASSPATH&quot;<br>
=C2=A0OUTPUT_DEST=3D&quot;/dev/null&quot;<br>
<br>
=C2=A0NUM_TESTS=3D155<br>
@@ -40,7 +40,7 @@ function run_app<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local fire_second_tp=3D$2<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # FIXME: test app should have synchro.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0java -cp $JAVA_CP -Djava.library.path=3D&quot;/=
usr/local/lib:/usr/lib&quot; $TESTAPP_NAME $NR_ITER $NR_MSEC_WAIT $debug_tp=
 $fire_second_tp &gt;/dev/null 2&gt;&amp;1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0java -cp $JAVA_CP -Djava.library.path=3D&quot;$=
LD_LIBRARY_PATH:/usr/local/lib:/usr/lib&quot; $TESTAPP_NAME $NR_ITER $NR_MS=
EC_WAIT $debug_tp $fire_second_tp &gt;/dev/null 2&gt;&amp;1<br>
=C2=A0}<br>
<br>
=C2=A0function run_app_background<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--001a114e61ae65075b051c929c46--


--===============0553551778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0553551778==--
