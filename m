From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: [PATCH lttng-tools] Tests: Java agent: update after
 Java agent refactoring
Date: Wed, 05 Aug 2015 20:32:28 -0400
Message-ID: <55C2AB1C.7070804__3340.46621942452$1438821223$gmane$org@voxpopuli.im>
References: <1438726900-17234-1-git-send-email-mjeanson@efficios.com>
 <CA+jJMxuWpP_vVWzFUS1CSvfUYsLZjVM8ZYLzAjjXpTaSAfw8Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1ZN96p-0000WS-Se
 for lttng-dev@lists.lttng.org; Wed, 05 Aug 2015 20:32:42 -0400
In-Reply-To: <CA+jJMxuWpP_vVWzFUS1CSvfUYsLZjVM8ZYLzAjjXpTaSAfw8Xg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?windows-1252?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>, Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This patch now makes lttng-tools have a hard requirement on Java to even =

compile the thing. Is this desirable, given that Java is only needed to =

run some tests?


On 2015-08-05 12:08 PM, J=E9r=E9mie Galarneau wrote:
> Merged, thanks!
>
> J=E9r=E9mie
>
> On Tue, Aug 4, 2015 at 6:21 PM, Michael Jeanson <mjeanson@efficios.com>
> wrote:
>
>> This patch fixes the Java agent tests which were impossible to run since
>> the Jar files have been renamed. It also overhauls the java part of the
>> configure script to match what's in UST and replace some hardcoded path
>> with configurable values.
>>
>> The tests are now enabled when corresponding classes are found in the
>> CLASSPATH during configure.
>>
>> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
>> ---
>>   .gitignore                                      |  2 +
>>   config/ax_check_class.m4                        |  2 +-
>>   configure.ac                                    | 80
>> +++++++++----------------
>>   tests/regression/ust/java-jul/JTestLTTng.java   | 34 ++++++++---
>>   tests/regression/ust/java-jul/Makefile.am       | 21 ++-----
>>   tests/regression/ust/java-jul/test_java_jul     |  4 +-
>>   tests/regression/ust/java-log4j/JTestLTTng.java | 38 +++++++++---
>>   tests/regression/ust/java-log4j/Makefile.am     | 17 +-----
>>   tests/regression/ust/java-log4j/test_java_log4j |  4 +-
>>   9 files changed, 99 insertions(+), 103 deletions(-)
>>
>> diff --git a/.gitignore b/.gitignore
>> index ff19c8d..5d24bec 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -93,3 +93,5 @@ health_check
>>   /benchmark/
>>
>>   /include/version.h
>> +
>> +classnoinst.stamp
>> diff --git a/config/ax_check_class.m4 b/config/ax_check_class.m4
>> index 098aa77..42b51d7 100644
>> --- a/config/ax_check_class.m4
>> +++ b/config/ax_check_class.m4
>> @@ -118,7 +118,7 @@ EOF
>>                           ac_cv_prog_uudecode_base64=3Dno
>>                   fi
>>           rm -f Test.uue
>> -        if AC_TRY_COMMAND($JAVA $JAVAFLAGS Test $1) >/dev/null 2>&1; th=
en
>> +        if AC_TRY_COMMAND($JAVA -classpath ".:$CLASSPATH" $JAVAFLAGS Te=
st
>> $1) >/dev/null 2>&1; then
>>                   eval "ac_cv_class_$ac_var_name=3Dyes"
>>           else
>>                   eval "ac_cv_class_$ac_var_name=3Dno"
>> diff --git a/configure.ac b/configure.ac
>> index 2fc6e53..bfef178 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -355,65 +355,43 @@ AX_CONFIG_FEATURE(
>>   )
>>   AM_CONDITIONAL([COMPAT_EPOLL], [ test "$enable_epoll" =3D "yes" ])
>>
>> -# Set compile flags to java include files if given. This is only used to
>> -# compile java agent tests.
>> -AC_ARG_WITH([java-jdk],
>> -       [AS_HELP_STRING([--with-java-jdk=3DDIR],[use the Java JDK in DIR=
. Ex
>> : $JAVA_HOME.])],
>> -       [JAVA_JDK=3D$withval],
>> -       [JAVA_JDK=3D""]
>> -)
>> -AM_CONDITIONAL([HAVE_JAVA_JDK], [test $JAVA_JDK], [Java JDK path])
>> -AC_SUBST([JAVA_JDK])
>> +AX_JAVA_OPTIONS
>> +AX_PROG_JAVAC
>> +AX_PROG_JAVA
>> +AX_PROG_JAR
>>
>> -AS_IF([test $JAVA_JDK],[
>> -       AS_IF([test -d $JAVA_JDK],
>> -               [
>> -                       AC_MSG_RESULT([using Java includes in $JAVA_SDK])
>> -                       SUBDIRS=3D`find $JAVA_JDK/include -type d`
>> -                       CPPFLAGS+=3D" "
>> -                       CPPFLAGS+=3D`for x in $SUBDIRS; do echo -n "-I$x=
 ";
>> done`
>> -                       CPPFLAGS+=3D" "
>> -        ],[AC_MSG_ERROR(Unable to find Java include files in $JAVA_JDK)]
>> -       )
>> -])
>> +AX_CHECK_CLASSPATH
>>
>> -# Check for the UST agent jar file in the system. Hardcoded path is add=
ed
>> here
>> -# since we have *no* idea where this could be installed. Note that this
>> is only
>> -# used for agent testing.
>> -AC_MSG_CHECKING(Java UST agent jar file)
>> -java_agent_jar_path=3D"${prefix}/share/java/liblttng-ust-agent.jar"
>> -if test -f $java_agent_jar_path; then
>> -       build_java_agent=3Dyes
>> -       AC_MSG_RESULT(found)
>> +# Check for Java UST agent common class first
>> +AX_CHECK_CLASS(org.lttng.ust.agent.AbstractLttngAgent)
>> +if test "x$ac_cv_class_org_lttng_ust_agent_AbstractLttngAgent" =3D "xye=
s";
>> then
>> +       java_agent_common=3Dyes
>>   else
>> -       build_java_agent=3Dno
>> -       AC_MSG_RESULT(not found)
>> +       java_agent_common=3Dno
>>   fi
>> -AM_CONDITIONAL([BUILD_JAVA_AGENT], [test "x$build_java_agent" =3D "xyes=
"])
>> -AC_SUBST([java_agent_jar_path])
>> -
>> -# Check for log4j support on the system to know if we can build or not =
the
>> -# log4j tests.
>> -if test "x$build_java_agent" =3D "xyes"; then
>> -       AC_MSG_CHECKING(Java agent support for log4j)
>> -       AX_JAVA_OPTIONS
>> -       AX_PROG_JAR
>> -       AX_PROG_JAVA
>> -       AX_PROG_JAVAC
>> -
>> -       # By default, use a commonly used classpath on the system to ease
>> things up
>> -       # for the Java testing in this directory.
>> -
>>   LOG4J_CLASSPATH=3D"$java_agent_jar_path:$CLASSPATH:.:/usr/share/java/*"
>> -       JAVAFLAGS=3D"-cp $LOG4J_CLASSPATH"
>> -       JAVACFLAGS=3D"$JAVAFLAGS"
>> +
>> +# If the common class is available, test for each agent
>> +if test "x$java_agent_common" =3D "xyes"; then
>> +       # Check for JUL
>> +       AX_CHECK_CLASS(org.lttng.ust.agent.jul.LttngLogHandler)
>> +       AX_CHECK_CLASS(org.lttng.ust.agent.log4j.LttngLogAppender)
>>          AX_CHECK_CLASS(org.apache.log4j.Logger)
>>
>> -       if test "x$ac_cv_class_org_apache_log4j_Logger" =3D "xno"; then
>> -               build_java_log4j_agent=3Dno
>> -       else
>> -               build_java_log4j_agent=3Dyes
>> +       build_java_jul_agent=3Dno
>> +       if test "x$ac_cv_class_org_lttng_ust_agent_jul_LttngLogHandler" =
=3D
>> "xyes"; then
>> +               build_java_jul_agent=3Dyes
>>          fi
>> +
>> +       build_java_log4j_agent=3Dno
>> +       if test "x$ac_cv_class_org_lttng_ust_agent_log4j_LttngLogAppende=
r"
>> =3D "xyes"; then
>> +               if test "x$ac_cv_class_org_apache_log4j_Logger" =3D "xye=
s";
>> then
>> +                       build_java_log4j_agent=3Dyes
>> +               fi
>> +       fi
>> +
>>   fi
>> +
>> +AM_CONDITIONAL([BUILD_JAVA_JUL_AGENT], [test "x$build_java_jul_agent" =
=3D
>> "xyes"])
>>   AM_CONDITIONAL([BUILD_JAVA_LOG4J_AGENT], [test "x$build_java_log4j_age=
nt"
>> =3D "xyes"])
>>
>>   AC_SYS_LARGEFILE
>> diff --git a/tests/regression/ust/java-jul/JTestLTTng.java
>> b/tests/regression/ust/java-jul/JTestLTTng.java
>> index 9431551..741d820 100644
>> --- a/tests/regression/ust/java-jul/JTestLTTng.java
>> +++ b/tests/regression/ust/java-jul/JTestLTTng.java
>> @@ -1,4 +1,5 @@
>>   /*
>> + * Copyright (C) 2015 - Michael Jeanson <mjeanson@efficios.com>
>>    * Copyright (C) 2013 - David Goulet <dgoulet@efficios.com>
>>    *
>>    * This program is free software; you can redistribute it and/or modif=
y it
>> @@ -15,20 +16,29 @@
>>    * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>    */
>>
>> +import java.io.IOException;
>>   import java.lang.Integer;
>> +import java.util.logging.Handler;
>>   import java.util.logging.Logger;
>>   import java.util.logging.Level;
>>
>> -import org.lttng.ust.agent.LTTngAgent;
>> +import org.lttng.ust.agent.jul.LttngLogHandler;
>>
>> -public class JTestLTTng
>> -{
>> -       private static LTTngAgent lttngAgent;
>> +public class JTestLTTng {
>> +
>> +       /**
>> +        * Application start
>> +        *
>> +        * @param args
>> +        *            Command-line arguments
>> +        * @throws IOException
>> +        * @throws InterruptedException
>> +        */
>> +       public static void main(String args[]) throws IOException,
>> InterruptedException {
>>
>> -       public static void main(String args[]) throws Exception
>> -       {
>>                  Logger lttng =3D Logger.getLogger("JTestLTTng");
>>                  Logger lttng2 =3D Logger.getLogger("JTestLTTng2");
>> +
>>                  int nrIter =3D Integer.parseInt(args[0]);
>>                  int waitTime =3D Integer.parseInt(args[1]);
>>                  int fire_finest_tp =3D 0;
>> @@ -41,7 +51,11 @@ public class JTestLTTng
>>                          fire_second_tp =3D Integer.parseInt(args[3]);
>>                  }
>>
>> -               lttngAgent =3D LTTngAgent.getLTTngAgent();
>> +               /* Instantiate a LTTngLogHandler object, and attach it to
>> our loggers */
>> +               Handler lttngHandler =3D new LttngLogHandler();
>> +               lttng.addHandler(lttngHandler);
>> +               lttng2.addHandler(lttngHandler);
>> +
>>                  lttng.setLevel(Level.FINEST);
>>
>>                  for (int iter =3D 0; iter < nrIter; iter++) {
>> @@ -57,6 +71,10 @@ public class JTestLTTng
>>                          lttng2.info("JUL second logger fired");
>>                  }
>>
>> -               lttngAgent.dispose();
>> +               /*
>> +                * Do not forget to close() all handlers so that the age=
nt
>> can shutdown
>> +                * and the session daemon socket gets cleaned up
>> explicitly.
>> +                */
>> +               lttngHandler.close();
>>          }
>>   }
>> diff --git a/tests/regression/ust/java-jul/Makefile.am
>> b/tests/regression/ust/java-jul/Makefile.am
>> index 286e3df..877237f 100644
>> --- a/tests/regression/ust/java-jul/Makefile.am
>> +++ b/tests/regression/ust/java-jul/Makefile.am
>> @@ -1,25 +1,13 @@
>> +JAVAROOT =3D .
>>
>>   noinst_SCRIPTS =3D test_java_jul JTestLTTng.java
>>   EXTRA_DIST =3D test_java_jul JTestLTTng.java
>>
>> -if HAVE_JAVA_JDK
>> -JCC=3D$(JAVA_JDK)/bin/javac
>> -else
>> -JCC=3Djavac
>> -endif
>> +if BUILD_JAVA_JUL_AGENT
>> +dist_noinst_JAVA =3D JTestLTTng.java
>> +endif # BUILD_JAVA_JUL_AGENT
>>
>> -AGENT_JAR_FILE=3D$(java_agent_jar_path)
>> -
>> -
>> -# Still need to copy test files in case of out of tree build
>> -if BUILD_JAVA_AGENT
>> -all-local: static_file JTestLTTng.class
>> -%.class: %.java
>> -       $(JCC) -d "$(builddir)" -cp "$(AGENT_JAR_FILE):." $<
>> -else
>>   all-local: static_file
>> -endif # BUILD_JAVA_AGENT
>> -
>>
>>   static_file:
>>          @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
>> @@ -28,7 +16,6 @@ static_file:
>>                  done; \
>>          fi
>>
>> -
>>   clean-local:
>>          rm -f *.class
>>          @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
>> diff --git a/tests/regression/ust/java-jul/test_java_jul
>> b/tests/regression/ust/java-jul/test_java_jul
>> index 48c8b74..f9f244b 100755
>> --- a/tests/regression/ust/java-jul/test_java_jul
>> +++ b/tests/regression/ust/java-jul/test_java_jul
>> @@ -27,7 +27,7 @@ TESTAPP_PATH=3D"$CURDIR/$TESTAPP_NAME"
>>   SESSION_NAME=3D"jul"
>>   EVENT_NAME=3D"JTestLTTng"
>>   EVENT_NAME2=3D"JTestLTTng2"
>>
>> -JAVA_CP=3D"$CURDIR:/usr/local/share/java/liblttng-ust-agent.jar:/usr/sh=
are/java/liblttng-ust-agent.jar"
>> +JAVA_CP=3D"$CURDIR:$CLASSPATH"
>>
>>   NUM_TESTS=3D155
>>
>> @@ -39,7 +39,7 @@ function run_app
>>          local fire_second_tp=3D$2
>>
>>          #FIXME: app should have synchro.
>> -       java -cp $JAVA_CP -Djava.library.path=3D"/usr/local/lib:/usr/lib"
>> $TESTAPP_NAME $NR_ITER $NR_MSEC_WAIT $finest_tp $fire_second_tp >/dev/nu=
ll
>> 2>&1
>> +       java -cp $JAVA_CP
>> -Djava.library.path=3D"$LD_LIBRARY_PATH:/usr/local/lib:/usr/lib"
>> $TESTAPP_NAME $NR_ITER $NR_MSEC_WAIT $finest_tp $fire_second_tp >/dev/nu=
ll
>> 2>&1
>>   }
>>
>>   function run_app_background
>> diff --git a/tests/regression/ust/java-log4j/JTestLTTng.java
>> b/tests/regression/ust/java-log4j/JTestLTTng.java
>> index 0019cb8..64a471b 100644
>> --- a/tests/regression/ust/java-log4j/JTestLTTng.java
>> +++ b/tests/regression/ust/java-log4j/JTestLTTng.java
>> @@ -1,4 +1,5 @@
>>   /*
>> + * Copyright (C) 2015 - Michael Jeanson <dgoulet@efficios.com>
>>    * Copyright (C) 2014 - David Goulet <dgoulet@efficios.com>
>>    *                      Christian Babeux <christian.babeux@efficios.co=
m>
>>    *
>> @@ -19,19 +20,26 @@
>>   import java.io.IOException;
>>   import java.lang.Integer;
>>
>> -import org.apache.log4j.Logger;
>> +import org.apache.log4j.Appender;
>>   import org.apache.log4j.BasicConfigurator;
>> +import org.apache.log4j.Logger;
>> +import org.lttng.ust.agent.log4j.LttngLogAppender;
>>
>> -import org.lttng.ust.agent.LTTngAgent;
>> +public class JTestLTTng {
>>
>> -public class JTestLTTng
>> -{
>> -       private static LTTngAgent lttngAgent;
>> +       /**
>> +        * Application start
>> +        *
>> +        * @param args
>> +        *            Command-line arguments
>> +        * @throws IOException
>> +        * @throws InterruptedException
>> +        */
>> +       public static void main(String args[]) throws IOException,
>> InterruptedException {
>>
>> -       public static void main(String args[]) throws Exception
>> -       {
>>                  Logger lttng =3D Logger.getLogger("log4j-event");
>>                  Logger lttng2 =3D Logger.getLogger("log4j-event-2");
>> +
>>                  int nrIter =3D Integer.parseInt(args[0]);
>>                  int waitTime =3D Integer.parseInt(args[1]);
>>                  int fire_debug_tp =3D 0;
>> @@ -44,8 +52,16 @@ public class JTestLTTng
>>                          fire_second_tp =3D Integer.parseInt(args[3]);
>>                  }
>>
>> +               /* Start with the default Log4j configuration, which logs
>> to console */
>>                  BasicConfigurator.configure();
>> -               lttngAgent =3D LTTngAgent.getLTTngAgent();
>> +
>> +               /*
>> +                * Add a LTTng log appender to both loggers, which will
>> also send the
>> +                * logged events to UST.
>> +                */
>> +               Appender lttngAppender =3D new LttngLogAppender();
>> +               lttng.addAppender(lttngAppender);
>> +               lttng2.addAppender(lttngAppender);
>>
>>                  for (int iter =3D 0; iter < nrIter; iter++) {
>>                          lttng.info("LOG4J tp fired!");
>> @@ -59,5 +75,11 @@ public class JTestLTTng
>>                  if (fire_second_tp =3D=3D 1) {
>>                          lttng2.info("LOG4J second logger fired");
>>                  }
>> +
>> +               /*
>> +                * Do not forget to close() all handlers so that the age=
nt
>> can shutdown
>> +                * and the session daemon socket gets cleaned up
>> explicitly.
>> +                */
>> +               lttngAppender.close();
>>          }
>>   }
>> diff --git a/tests/regression/ust/java-log4j/Makefile.am
>> b/tests/regression/ust/java-log4j/Makefile.am
>> index 7d6c048..42daab8 100644
>> --- a/tests/regression/ust/java-log4j/Makefile.am
>> +++ b/tests/regression/ust/java-log4j/Makefile.am
>> @@ -1,24 +1,13 @@
>> +JAVAROOT =3D .
>>
>>   noinst_SCRIPTS =3D test_java_log4j JTestLTTng.java
>>   EXTRA_DIST =3D test_java_log4j JTestLTTng.java
>>
>> -if HAVE_JAVA_JDK
>> -JCC=3D$(JAVA_JDK)/bin/javac
>> -else
>> -JCC=3Djavac
>> -endif
>> -
>> -# We still need to copy static files for out of tree and dist build
>>   if BUILD_JAVA_LOG4J_AGENT
>> -all-local: static_file JTestLTTng.class
>> -
>> -%.class: %.java
>> -       $(JCC) -d "$(builddir)" $(JAVACFLAGS) $<
>> -else
>> -all-local: static_file
>> +dist_noinst_JAVA =3D JTestLTTng.java
>>   endif # BUILD_JAVA_LOG4J_AGENT
>>
>> -JTestLTTng.class: JTestLTTng.java
>> +all-local: static_file
>>
>>   static_file:
>>          @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
>> diff --git a/tests/regression/ust/java-log4j/test_java_log4j
>> b/tests/regression/ust/java-log4j/test_java_log4j
>> index cdc0c4c..d5c6621 100755
>> --- a/tests/regression/ust/java-log4j/test_java_log4j
>> +++ b/tests/regression/ust/java-log4j/test_java_log4j
>> @@ -27,7 +27,7 @@ TESTAPP_PATH=3D"$CURDIR/$TESTAPP_NAME"
>>   SESSION_NAME=3D"log4j"
>>   EVENT_NAME=3D"log4j-event"
>>   EVENT_NAME2=3D"log4j-event-2"
>>
>> -JAVA_CP=3D"$CURDIR:/usr/local/share/java/liblttng-ust-agent.jar:/usr/sh=
are/java/*"
>> +JAVA_CP=3D"$CURDIR:$CLASSPATH"
>>   OUTPUT_DEST=3D"/dev/null"
>>
>>   NUM_TESTS=3D155
>> @@ -40,7 +40,7 @@ function run_app
>>          local fire_second_tp=3D$2
>>
>>          # FIXME: test app should have synchro.
>> -       java -cp $JAVA_CP -Djava.library.path=3D"/usr/local/lib:/usr/lib"
>> $TESTAPP_NAME $NR_ITER $NR_MSEC_WAIT $debug_tp $fire_second_tp >/dev/null
>> 2>&1
>> +       java -cp $JAVA_CP
>> -Djava.library.path=3D"$LD_LIBRARY_PATH:/usr/local/lib:/usr/lib"
>> $TESTAPP_NAME $NR_ITER $NR_MSEC_WAIT $debug_tp $fire_second_tp >/dev/null
>> 2>&1
>>   }
>>
>>   function run_app_background
>> --
>> 1.9.1
>>
>>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
