From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 3/3] Fix: Python agent tests
	were always skipped
Date: Wed, 12 Aug 2015 19:11:21 -0400
Message-ID: <CA+jJMxtRfuRTRo88AVdKLr6JWHXcVfdG5oynYNQsGB20Qm1ANw__36953.717590268$1439421174$gmane$org@mail.gmail.com>
References: <1438902016-17511-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <1438902016-17511-3-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1024821614=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZPfB8-0000PA-IX
 for lttng-dev@lists.lttng.org; Wed, 12 Aug 2015 19:11:34 -0400
Received: by ykaz130 with SMTP id z130so27644530yka.0
 for <lttng-dev@lists.lttng.org>; Wed, 12 Aug 2015 16:11:21 -0700 (PDT)
In-Reply-To: <1438902016-17511-3-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1024821614==
Content-Type: multipart/alternative; boundary=94eb2c0885be38c2a6051d25569c

--94eb2c0885be38c2a6051d25569c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2015 at 7:00 PM, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> Introduce --enable-test-python{2,3}-agent and
> --enable-test-python-agent-all
> flag on configure.
>
> Tests are enabled by default via best effort. Configure looks if it can
> find
> python agent for python 2&3 and enable/skip tests.
>
> When used --enable-test-python{2,3}-agent & --enable-test-python-agent-al=
l
> flags
> force strict checks on tests dependancies and fails at configure instead =
of
> simply disabling tests.
>
> --disable* flags can be used to force tests skipping.
>
> Also minor bug in agent test on enabling event with filtering.
>
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  .gitignore                                         |   1 +
>  configure.ac                                       | 121 +++-
>  .../ust/python-logging/test_python_logging         | 603
> --------------------
>  .../ust/python-logging/test_python_logging.in      | 610
> +++++++++++++++++++++
>  4 files changed, 731 insertions(+), 604 deletions(-)
>  delete mode 100755 tests/regression/ust/python-logging/test_python_loggi=
ng
>  create mode 100755 tests/regression/ust/python-logging/
> test_python_logging.in
>
> diff --git a/.gitignore b/.gitignore
> index 5d24bec..0ce35f9 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -85,6 +85,7 @@ health_check
>  /tests/regression/ust/fork/fork
>  /tests/regression/ust/fork/fork2
>  /tests/regression/ust/libc-wrapper/prog
> +tests/regression/ust/python-logging/test_python_logging
>  /tests/utils/testapp/gen-ust-nevents/gen-ust-nevents
>  /tests/utils/testapp/gen-ust-tracef/gen-ust-tracef
>  /tests/regression/tools/live/live_test
> diff --git a/configure.ac b/configure.ac
> index 324b596..386d557 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -359,7 +359,6 @@ if test "x${enable_python_binding:-yes}" =3D xyes; th=
en
>  else
>      AC_MSG_NOTICE([You may configure with --enable-python-bindings ]dnl
>  [if you want Python bindings.])
> -
>  fi
>
>  # Epoll check. If not present, the build will fallback on poll() API
> @@ -414,6 +413,104 @@ if test "x$test_java_agent_jul" =3D "xyes" || test
> "x$test_java_agent_log4j" =3D "xy
>         fi
>  fi
>
> +# Python agent test
> +UST_PYTHON_AGENT=3D"lttngust"
> +
> +AC_ARG_ENABLE(test-python2-agent,
> +       AS_HELP_STRING([--enable-test-python2-agent],
> +               [enable tests for python2 agent. Python2 interpreter path
> can be overrided by env. variable PYTHON2. Default: Best effort]
> +       ),[:],[test_python2_agent_best_effort=3Dyes]
> +)
> +
> +AC_ARG_ENABLE(test-python3-agent,
> +       AS_HELP_STRING([--enable-test-python3-agent],
> +               [enable tests for python3 agent. Python3 interpreter path
> can be overrided by env. variable PYTHON3. Default: Best effort]
> +       ),[:],[test_python3_agent_best_effort=3Dyes]
> +)
> +
> +AC_ARG_ENABLE(test-python-agent-all,
> +       AS_HELP_STRING([--enable-test-python-agent-all],
> +               [enable test for all python{2/3} agent.]
> +       ),
> +)
> +
> +AS_IF([test ! -z "$enable_test_python_agent_all"], [
> +       unset test_python2_agent_best_effort
> +       unset test_python3_agent_best_effort
> +])
> +
> +AS_IF([test "x$enable_test_python_agent_all" =3D "xyes"], [
> +       enable_test_python2_agent=3Dyes
> +       enable_test_python3_agent=3Dyes
> +])
> +
> +AS_IF([test "x$enable_test_python_agent_all" =3D "xno"], [
> +       enable_test_python2_agent=3Dno
> +       enable_test_python3_agent=3Dno
> +])
> +
> +
> +AS_IF([test "x$enable_test_python2_agent" =3D "xyes" -o
> "x$test_python2_agent_best_effort" =3D "xyes" ], [
> +       AS_IF([test -z "$PYTHON2"], [
> +                       PYTHON2=3Dpython2
> +               ], [
> +                       AC_MSG_WARN([Using user-defined PYTHON2 ($PYTHON2=
)
> for lttng-ust python2 agent check])
> +       ])
> +
> +       AC_PATH_PROG([PYTHON2_BIN],[$PYTHON2])
> +       AS_IF([test -z "$PYTHON2_BIN"], [
> +               AS_IF([test -z "$test_python2_agent_best_effort"],[
> +                       AC_MSG_ERROR([No python2 interpreter found.
> PYTHON2 can be set to override default interpreter path])
> +               ])
> +       ], [
> +               AC_MSG_CHECKING([for python2 lttng-ust agent])
> +               AS_IF([$PYTHON2_BIN -c "import $UST_PYTHON_AGENT"
> 2>/dev/null], [
> +                       PYTHON2_AGENT=3D$PYTHON2_BIN
> +                       AC_MSG_RESULT([yes])
> +                       RUN_PYTHON_AGENT_TEST=3Dyes
> +               ], [
> +                       AC_MSG_RESULT([no])
> +                       AS_IF([test -z "$test_python2_agent_best_effort"]=
,[
> +                               AC_MSG_ERROR([No python2 agent found.
> PYTHONPATH env. variable can be set with the path to the agent.])
> +                       ])
> +               ])
> +
> +       ])
> +
> +])
> +
> +AS_IF([test "x$enable_test_python3_agent" =3D "xyes" -o
> "x$test_python3_agent_best_effort" =3D "xyes" ], [
> +       AS_IF([test -z "$PYTHON3"], [
> +               PYTHON3=3Dpython3
> +       ], [
> +               AC_MSG_WARN([Using user-defined PYTHON3 ($PYTHON3) for
> lttng-ust python3 agent check])
> +       ])
> +
> +       AC_PATH_PROG([PYTHON3_BIN],[$PYTHON3])
> +       AS_IF([test -z "$PYTHON3_BIN"], [
> +               AS_IF([test -z "$test_python3_agent_best_effort"],[
> +                       AC_MSG_ERROR([No python3 interpreter found.
> PYTHON3 can be set to override default interpreter path])
> +               ])
> +       ], [
> +               AC_MSG_CHECKING([for python3 lttng-ust agent])
> +               AS_IF([$PYTHON3_BIN -c "import $UST_PYTHON_AGENT"
> 2>/dev/null], [
> +                       PYTHON3_AGENT=3D$PYTHON3_BIN
> +                       AC_MSG_RESULT([yes])
> +                       RUN_PYTHON_AGENT_TEST=3Dyes
> +               ], [
> +                       AC_MSG_RESULT([no])
> +                       AS_IF([test -z "$test_python3_agent_best_effort"]=
,[
> +                               AC_MSG_ERROR([No python3 agent found.
> PYTHONPATH env. variable can be set with the path to the agent.])
> +                       ])
> +               ])
> +
> +       ])
> +])
> +
> +AC_SUBST([RUN_PYTHON_AGENT_TEST])
> +AC_SUBST([PYTHON2_AGENT])
> +AC_SUBST([PYTHON3_AGENT])
> +
>  AC_SYS_LARGEFILE
>
>  # C compiler tests
> @@ -548,6 +645,9 @@ AC_CONFIG_FILES([
>         tests/utils/testapp/gen-ust-tracef/Makefile
>  ])
>
> +# Inject variable into python test script
> +AC_CONFIG_FILES([tests/regression/ust/python-logging/test_python_logging=
],[chmod
> +x tests/regression/ust/python-logging/test_python_logging])
> +
>  AC_OUTPUT
>
>  #
> @@ -621,6 +721,25 @@ AS_IF([test "x$consumerd_only" =3D "xyes"],[
>         AS_ECHO("All binaries will be built.")
>  ])
>
> +
> +# Info on optionnal test suites.
> +AS_ECHO()
> +AS_ECHO("Additional test suites to be run on make check":)
>

Looks good to me except this part. Can you modify this to report whether or
not the tests will run like we do for JUL and Log4j?

LTTng-UST Java agent JUL tests: Disabled
LTTng-UST Java agent Log4j tests: Disabled
etc.

Regards,
J=C3=A9r=C3=A9mie


> +
> +AS_ECHO_N("Python2 agent: ")
> +AS_IF([test ! -z "$PYTHON2_AGENT"],[
> +       AS_ECHO("yes")
> +],[
> +       AS_ECHO("no")
> +])
> +
> +AS_ECHO_N("Python3 agent: ")
> +AS_IF([test ! -z "$PYTHON3_AGENT"],[
> +       AS_ECHO("yes")
> +],[
> +       AS_ECHO("no")
> +])
> +
>  # Print the bindir and libdir this `make install' will install into.
>  AS_ECHO()
>  AS_ECHO_N("Binaries will be installed in:  ")
> diff --git a/tests/regression/ust/python-logging/test_python_logging
> b/tests/regression/ust/python-logging/test_python_logging
> deleted file mode 100755
> index b4fb410..0000000
> --- a/tests/regression/ust/python-logging/test_python_logging
> +++ /dev/null
> @@ -1,603 +0,0 @@
> -#!/bin/bash
> -#
> -# Copyright (C) - 2015 Philippe Proulx <pproulx@efficios.com>
> -# Copyright (C) - 2014 David Goulet <dgoulet@efficios.com>
> -#
> -# This program is free software; you can redistribute it and/or modify i=
t
> under
> -# the terms of the GNU General Public License, version 2 only, as
> published by
> -# the Free Software Foundation.
> -#
> -# This program is distributed in the hope that it will be useful, but
> WITHOUT
> -# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> FITNESS
> -# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
> -# details.
> -#
> -# You should have received a copy of the GNU General Public License alon=
g
> with
> -# this program; if not, write to the Free Software Foundation, Inc., 51
> -# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> -
> -TEST_DESC=3D"Python support"
> -
> -CURDIR=3D$(dirname $0)/
> -TESTDIR=3D$CURDIR/../../..
> -NR_ITER=3D5
> -NR_SEC_WAIT=3D1
> -TESTAPP_NAME=3D"test"
> -TESTAPP_BIN=3D"$TESTAPP_NAME.py"
> -TESTAPP_PATH=3D"$CURDIR"
> -SESSION_NAME=3D"python-test"
> -EVENT_NAME=3D"python-ev-test1"
> -EVENT_NAME2=3D"python-ev-test2"
> -OUTPUT_DEST=3D"/dev/null"
> -
> -NUM_TESTS=3D310
> -
> -source $TESTDIR/utils/utils.sh
> -
> -function run_app
> -{
> -       local python=3D$1
> -       local debug_tp=3D$2
> -       local fire_second_tp=3D$3
> -
> -       $python $TESTAPP_PATH/$TESTAPP_BIN $NR_ITER $NR_SEC_WAIT $debug_t=
p
> $fire_second_tp
> -}
> -
> -function run_app_background
> -{
> -       run_app $@ &
> -}
> -
> -function enable_python_loglevel_only()
> -{
> -       sess_name=3D$1
> -       event_name=3D"$2"
> -       loglevel=3D$3
> -       channel_name=3D$4
> -
> -       if [ -z $channel_name ]; then
> -               # default channel if none specified
> -               chan=3D""
> -       else
> -               chan=3D"-c $channel_name"
> -       fi
> -
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel-only
> $loglevel "$event_name" $chan -s $sess_name -p >$OUTPUT_DEST
> -       ok $? "Enable Python event $event_name for session $sess_name wit=
h
> loglevel-only $loglevel"
> -}
> -
> -function enable_python_filter()
> -{
> -       local sess_name=3D"$1"
> -       local event_name=3D"$2"
> -       local filter=3D"$3"
> -
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -=
s
> $sess_name -p --filter "$filter" >/dev/null 2>&1
> -       ok $? "Enable event $event_name with filter $filter for session
> $sess_name"
> -}
> -
> -function enable_python_filter_loglevel_only()
> -{
> -       local sess_name=3D"$1"
> -       local event_name=3D"$2"
> -       local filter=3D"$3"
> -       local loglevel=3D"$4"
> -
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel-only
> $loglevel "$event_name" -s $sess_name -p --filter "$filter" >$OUTPUT_DEST
> -       ok $? "Enable event $event_name with filter \"$filter\" and
> loglevel-only $loglevel for session $sess_name"
> -}
> -
> -# MUST set TESTDIR before calling those functions
> -
> -function test_python_before_start ()
> -{
> -       diag "Test Python application BEFORE tracing starts"
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> -       enable_python_lttng_event $SESSION_NAME $EVENT_NAME
> -
> -       # Run 5 times with a 1 second delay
> -       run_app_background $1
> -
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       # Wait for the applications started in background
> -       wait
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting all events.
> -       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -}
> -
> -function test_python_after_start ()
> -{
> -       diag "Test Python application AFTER tracing starts"
> -
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> -       enable_python_lttng_event $SESSION_NAME $EVENT_NAME
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       # Run 5 times with a 1 second delay
> -       run_app $1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting all events.
> -       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -}
> -
> -function test_python_loglevel ()
> -{
> -       diag "Test Python application with loglevel"
> -
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> -       enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME "INF=
O"
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       # Run 5 times with a 1 second delay
> -       run_app $1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting all events.
> -       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -
> -       diag "Test Python applications with lower loglevel"
> -
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> -       enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME
> "CRITICAL"
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       # Run 5 times with a 1 second delay
> -       run_app $1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting 0 events.
> -       trace_match_only $EVENT_NAME 0 $TRACE_PATH
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -
> -       diag "Test Python applications with higher loglevel"
> -
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> -       enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME
> "DEBUG"
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       # Run 5 times with a 1 second delay
> -       run_app $1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting all events.
> -       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
> -       return $?
> -}
> -
> -function test_python_loglevel_multiple ()
> -{
> -       diag "Test Python application with multiple loglevel"
> -
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> -       enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME "INF=
O"
> -       enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME
> "DEBUG"
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       # Run 5 times with a 1 second delay and fire two TP.
> -       run_app $1 1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting all events times two.
> -       trace_match_only $EVENT_NAME $(($NR_ITER * 2)) $TRACE_PATH
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> -       enable_python_lttng_event_loglevel $SESSION_NAME '*' "INFO"
> -       enable_python_lttng_event_loglevel $SESSION_NAME '*' "DEBUG"
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       # Run 5 times with a 1 second delay and fire two TP.
> -       run_app $1 1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting all events times two.
> -       trace_match_only $EVENT_NAME $(($NR_ITER * 2)) $TRACE_PATH
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -}
> -
> -function test_python_multi_session_loglevel()
> -{
> -       diag "Test Python with multiple session"
> -
> -       create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME=
-1
> -       enable_python_loglevel_only $SESSION_NAME-1 '*' "INFO"
> -       start_lttng_tracing_ok $SESSION_NAME-1
> -
> -       create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME=
-2
> -       enable_python_loglevel_only $SESSION_NAME-2 '*' "DEBUG"
> -       start_lttng_tracing_ok $SESSION_NAME-2
> -
> -       # Run 5 times with a 1 second delay and fire second TP.
> -       run_app $1 1 1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME-1
> -       stop_lttng_tracing_ok $SESSION_NAME-2
> -       destroy_lttng_session_ok $SESSION_NAME-1
> -       destroy_lttng_session_ok $SESSION_NAME-2
> -
> -       # Expecting NR_ITER events being the main event and the second tp
> one.
> -       trace_matches $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-1
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -       trace_matches $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-1
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -
> -       # Expectin NR_ITER events being the debug TP.
> -       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-2
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -}
> -
> -function test_python_multi_session_disable()
> -{
> -       diag "Test Python with multiple session with disabled event"
> -
> -       create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME=
-1
> -       enable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME
> -       enable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME2
> -       disable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME
> -       start_lttng_tracing_ok $SESSION_NAME-1
> -
> -       create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME=
-2
> -       enable_python_lttng_event $SESSION_NAME-2 $EVENT_NAME2
> -       start_lttng_tracing_ok $SESSION_NAME-2
> -
> -       # Run 5 times with a 1 second delay and fire second TP.
> -       run_app $1 0 1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME-1
> -       stop_lttng_tracing_ok $SESSION_NAME-2
> -       destroy_lttng_session_ok $SESSION_NAME-1
> -       destroy_lttng_session_ok $SESSION_NAME-2
> -
> -       # Validate test. Expecting one event of the second TP.
> -       trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-1
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -
> -       # Validate test. Expecting one event of the second TP.
> -       trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-2
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -}
> -
> -function test_python_multi_session_disable_wildcard()
> -{
> -       diag "Test Python with multiple session with disabled wildcard
> event"
> -
> -       create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME=
-1
> -       enable_python_lttng_event $SESSION_NAME-1 '*'
> -
> -       create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME=
-2
> -       enable_python_lttng_event $SESSION_NAME-2 '*'
> -
> -       disable_python_lttng_event $SESSION_NAME-1 '*'
> -
> -       start_lttng_tracing_ok $SESSION_NAME-1
> -       start_lttng_tracing_ok $SESSION_NAME-2
> -
> -       run_app $1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME-1
> -       stop_lttng_tracing_ok $SESSION_NAME-2
> -       destroy_lttng_session_ok $SESSION_NAME-1
> -       destroy_lttng_session_ok $SESSION_NAME-2
> -
> -       # Validate test. Expecting NO event of the first TP.
> -       trace_match_only $EVENT_NAME 0 $TRACE_PATH/$SESSION_NAME-1
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -
> -       # Validate test. Expecting all events of the first TP.
> -       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-2
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -}
> -
> -function test_python_disable_all()
> -{
> -       diag "Test Python with multiple session with disabled all event"
> -
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
> -       enable_python_lttng_event $SESSION_NAME '*'
> -       enable_python_lttng_event $SESSION_NAME $EVENT_NAME
> -       enable_python_lttng_event $SESSION_NAME $EVENT_NAME2
> -
> -       disable_python_lttng_event $SESSION_NAME '*'
> -
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       run_app $1 0 1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting NO event of the first TP and second TP=
.
> -       trace_match_only $EVENT_NAME 0 $TRACE_PATH/$SESSION_NAME
> -       trace_match_only $EVENT_NAME2 0 $TRACE_PATH/$SESSION_NAME
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -}
> -
> -function test_python_multi_session()
> -{
> -       diag "Test Python with multiple session"
> -
> -       create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME=
-1
> -       enable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME
> -       start_lttng_tracing_ok $SESSION_NAME-1
> -
> -       create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME=
-2
> -       enable_python_lttng_event $SESSION_NAME-2 $EVENT_NAME2
> -       start_lttng_tracing_ok $SESSION_NAME-2
> -
> -       # Run 5 times with a 1 second delay and fire second TP.
> -       run_app $1 0 1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME-1
> -       stop_lttng_tracing_ok $SESSION_NAME-2
> -       destroy_lttng_session_ok $SESSION_NAME-1
> -       destroy_lttng_session_ok $SESSION_NAME-2
> -
> -       # Validate test. Expecting all events of first TP
> -       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-1
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -
> -       # Validate test. Expecting one event of the second TP.
> -       trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-2
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -}
> -
> -function test_python_destroy_session()
> -{
> -       diag "Test Python two session with destroy"
> -
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/first-sess
> -       enable_python_lttng_event $SESSION_NAME $EVENT_NAME
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       # Run 5 times with a 1 second delay
> -       run_app_background $1 0 1
> -
> -       # Wait for the applications started in background
> -       wait
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting at least one event num 1
> -       validate_trace $EVENT_NAME $TRACE_PATH/first-sess
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/second-sess
> -       enable_python_lttng_event $SESSION_NAME $EVENT_NAME2
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       # Run 5 times with a 1 second delay
> -       run_app_background $1 0 1
> -
> -       # Wait for the applications started in background
> -       wait
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting only one event num 2
> -       trace_match_only $EVENT_NAME2 1 $TRACE_PATH/second-sess
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -}
> -
> -function test_python_filtering()
> -{
> -       diag "Test Python filtering"
> -
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
> -       # Enable all event with a filter.
> -       enable_python_filter $SESSION_NAME '*' 'msg =3D=3D "python-ev-tes=
t2
> fired [INFO]"'
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       # Run 5 times with a 1 second delay and fire second TP.
> -       run_app $1 0 1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting one event of the second TP only.
> -       trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
> -       # Enable first Logger but filter msg payload for the INFO one whi=
le
> -       # triggering the debug and second TP.
> -       enable_python_filter $SESSION_NAME $EVENT_NAME 'msg =3D=3D
> "python-ev-test1 fired" [INFO]'
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       # Run 5 times with a 1 second delay, fire debug and second TP.
> -       run_app $1 1 1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting NR_ITER event of the main INFO tp.
> -       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -}
> -
> -function test_python_disable()
> -{
> -       diag "Test Python disable event"
> -
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
> -       # Enable all event with a filter.
> -       enable_python_lttng_event $SESSION_NAME $EVENT_NAME
> -       enable_python_lttng_event $SESSION_NAME $EVENT_NAME2
> -       disable_python_lttng_event $SESSION_NAME $EVENT_NAME
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       # Run 5 times with a 1 second delay and fire second TP.
> -       run_app $1 0 1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting one event of the second TP only.
> -       trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -}
> -
> -function test_python_disable_enable()
> -{
> -       diag "Test Python disable event followed by an enable"
> -
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
> -       # Enable all event with a filter.
> -       enable_python_lttng_event $SESSION_NAME $EVENT_NAME
> -       disable_python_lttng_event $SESSION_NAME $EVENT_NAME
> -       enable_python_lttng_event $SESSION_NAME $EVENT_NAME
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       # Run 5 times with a 1 second delay and fire second TP.
> -       run_app $1 0 1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting NR_ITER event of the main INFO tp.
> -       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -}
> -
> -function test_python_filter_loglevel()
> -{
> -       local BOGUS_EVENT_NAME=3D"not_a_real_event"
> -       local FILTER=3D"int_loglevel > 30 || int_loglevel < 30"
> -       local ALL_EVENTS=3D"."
> -
> -       diag "Test Python a filter with a loglevel"
> -
> -       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
> -       # Enable an event with a filter and the loglevel-only option.
> -       enable_python_filter_loglevel_only $SESSION_NAME $BOGUS_EVENT_NAM=
E
> "$FILTER" "INFO"
> -       disable_python_lttng_event $SESSION_NAME $BOGUS_EVENT_NAME
> -       enable_python_filter_loglevel_only $SESSION_NAME $BOGUS_EVENT_NAM=
E
> "$FILTER" "INFO"
> -       start_lttng_tracing_ok $SESSION_NAME
> -
> -       # Run 5 times with a 1 second delay and fire second TP.
> -       run_app $1 0 1
> -
> -       stop_lttng_tracing_ok $SESSION_NAME
> -       destroy_lttng_session_ok $SESSION_NAME
> -
> -       # Validate test. Expecting no events.
> -       trace_match_only $ALL_EVENTS 0 $TRACE_PATH/$SESSION_NAME
> -       if [ $? -ne 0 ]; then
> -               return $?
> -       fi
> -}
> -
> -plan_tests $NUM_TESTS
> -
> -print_test_banner "$TEST_DESC"
> -
> -if [ ! -f "$TESTAPP_BIN" ]; then
> -       withapp=3D0
> -else
> -       withapp=3D1
> -fi
> -
> -skip $withapp "Python support is needed. Skipping all tests." $NUM_TESTS
> ||
> -{
> -       start_lttng_sessiond
> -
> -       tests=3D(
> -               test_python_multi_session_disable_wildcard
> -               test_python_multi_session_disable
> -               test_python_disable
> -               test_python_disable_enable
> -               test_python_disable_all
> -               test_python_filtering
> -               test_python_multi_session_loglevel
> -               test_python_destroy_session
> -               test_python_loglevel
> -               test_python_loglevel_multiple
> -               test_python_before_start
> -               test_python_after_start
> -               test_python_multi_session
> -               test_python_filter_loglevel
> -       )
> -
> -       for python_version in 2 3;
> -       do
> -               for fct_test in ${tests[@]};
> -               do
> -                       TRACE_PATH=3D$(mktemp -d)
> -
> -                       diag "(Python $python_version)"
> -                       ${fct_test} python$python_version
> -                       if [ $? -ne 0 ]; then
> -                               break;
> -                       fi
> -                       rm -rf $TRACE_PATH
> -               done
> -       done
> -
> -       stop_lttng_sessiond
> -}
> diff --git a/tests/regression/ust/python-logging/test_python_logging.in
> b/tests/regression/ust/python-logging/test_python_logging.in
> new file mode 100755
> index 0000000..8aff408
> --- /dev/null
> +++ b/tests/regression/ust/python-logging/test_python_logging.in
> @@ -0,0 +1,610 @@
> +#!/bin/bash
> +#
> +# Copyright (C) - 2015 Philippe Proulx <pproulx@efficios.com>
> +# Copyright (C) - 2014 David Goulet <dgoulet@efficios.com>
> +#
> +# This program is free software; you can redistribute it and/or modify i=
t
> under
> +# the terms of the GNU General Public License, version 2 only, as
> published by
> +# the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful, but
> WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> FITNESS
> +# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
> +# details.
> +#
> +# You should have received a copy of the GNU General Public License alon=
g
> with
> +# this program; if not, write to the Free Software Foundation, Inc., 51
> +# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +
> +TEST_DESC=3D"Python support"
> +
> +CURDIR=3D$(dirname $0)/
> +TESTDIR=3D$CURDIR/../../..
> +NR_ITER=3D5
> +NR_SEC_WAIT=3D0
> +TESTAPP_NAME=3D"test"
> +TESTAPP_BIN=3D"$TESTAPP_NAME.py"
> +TESTAPP_PATH=3D"$CURDIR"
> +SESSION_NAME=3D"python-test"
> +EVENT_NAME=3D"python-ev-test1"
> +EVENT_NAME2=3D"python-ev-test2"
> +OUTPUT_DEST=3D"/dev/null"
> +
> +python_versions=3D(@PYTHON2_AGENT@ @PYTHON3_AGENT@)
> +run_test=3D@RUN_PYTHON_AGENT_TEST@
> +
> +if [[ -z "$run_test" ]]; then
> +       NUM_TESTS=3D1
> +else
> +       NUM_TESTS=3D$(((154 * ${#python_versions[@]})+2))
> +fi
> +
> +source $TESTDIR/utils/utils.sh
> +
> +function run_app
> +{
> +       local python=3D$1
> +       local debug_tp=3D$2
> +       local fire_second_tp=3D$3
> +
> +       $python $TESTAPP_PATH/$TESTAPP_BIN $NR_ITER $NR_SEC_WAIT $debug_t=
p
> $fire_second_tp
> +}
> +
> +function run_app_background
> +{
> +       run_app $@ &
> +}
> +
> +function enable_python_loglevel_only()
> +{
> +       sess_name=3D$1
> +       event_name=3D"$2"
> +       loglevel=3D$3
> +       channel_name=3D$4
> +
> +       if [ -z $channel_name ]; then
> +               # default channel if none specified
> +               chan=3D""
> +       else
> +               chan=3D"-c $channel_name"
> +       fi
> +
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel-only
> $loglevel "$event_name" $chan -s $sess_name -p >$OUTPUT_DEST
> +       ok $? "Enable Python event $event_name for session $sess_name wit=
h
> loglevel-only $loglevel"
> +}
> +
> +function enable_python_filter()
> +{
> +       local sess_name=3D"$1"
> +       local event_name=3D"$2"
> +       local filter=3D"$3"
> +
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -=
s
> $sess_name -p --filter "$filter" >$OUTPUT_DEST
> +       ok $? "Enable event $event_name with filter $filter for session
> $sess_name"
> +}
> +
> +function enable_python_filter_loglevel_only()
> +{
> +       local sess_name=3D"$1"
> +       local event_name=3D"$2"
> +       local filter=3D"$3"
> +       local loglevel=3D"$4"
> +
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel-only
> $loglevel "$event_name" -s $sess_name -p --filter "$filter" >$OUTPUT_DEST
> +       ok $? "Enable event $event_name with filter \"$filter\" and
> loglevel-only $loglevel for session $sess_name"
> +}
> +
> +# MUST set TESTDIR before calling those functions
> +
> +function test_python_before_start ()
> +{
> +       diag "Test Python application BEFORE tracing starts"
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> +       enable_python_lttng_event $SESSION_NAME $EVENT_NAME
> +
> +       # Run 5 times with a 1 second delay
> +       run_app_background $1
> +
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       # Wait for the applications started in background
> +       wait
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting all events.
> +       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +}
> +
> +function test_python_after_start ()
> +{
> +       diag "Test Python application AFTER tracing starts"
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> +       enable_python_lttng_event $SESSION_NAME $EVENT_NAME
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       # Run 5 times with a 1 second delay
> +       run_app $1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting all events.
> +       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +}
> +
> +function test_python_loglevel ()
> +{
> +       diag "Test Python application with loglevel"
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> +       enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME "INF=
O"
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       # Run 5 times with a 1 second delay
> +       run_app $1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting all events.
> +       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +
> +       diag "Test Python applications with lower loglevel"
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> +       enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME
> "CRITICAL"
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       # Run 5 times with a 1 second delay
> +       run_app $1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting 0 events.
> +       trace_match_only $EVENT_NAME 0 $TRACE_PATH
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +
> +       diag "Test Python applications with higher loglevel"
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> +       enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME
> "DEBUG"
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       # Run 5 times with a 1 second delay
> +       run_app $1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting all events.
> +       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
> +       return $?
> +}
> +
> +function test_python_loglevel_multiple ()
> +{
> +       diag "Test Python application with multiple loglevel"
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> +       enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME "INF=
O"
> +       enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME
> "DEBUG"
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       # Run 5 times with a 1 second delay and fire two TP.
> +       run_app $1 1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting all events times two.
> +       trace_match_only $EVENT_NAME $(($NR_ITER * 2)) $TRACE_PATH
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> +       enable_python_lttng_event_loglevel $SESSION_NAME '*' "INFO"
> +       enable_python_lttng_event_loglevel $SESSION_NAME '*' "DEBUG"
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       # Run 5 times with a 1 second delay and fire two TP.
> +       run_app $1 1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting all events times two.
> +       trace_match_only $EVENT_NAME $(($NR_ITER * 2)) $TRACE_PATH
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +}
> +
> +function test_python_multi_session_loglevel()
> +{
> +       diag "Test Python with multiple session"
> +
> +       create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME=
-1
> +       enable_python_loglevel_only $SESSION_NAME-1 '*' "INFO"
> +       start_lttng_tracing_ok $SESSION_NAME-1
> +
> +       create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME=
-2
> +       enable_python_loglevel_only $SESSION_NAME-2 '*' "DEBUG"
> +       start_lttng_tracing_ok $SESSION_NAME-2
> +
> +       # Run 5 times with a 1 second delay and fire second TP.
> +       run_app $1 1 1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME-1
> +       stop_lttng_tracing_ok $SESSION_NAME-2
> +       destroy_lttng_session_ok $SESSION_NAME-1
> +       destroy_lttng_session_ok $SESSION_NAME-2
> +
> +       # Expecting NR_ITER events being the main event and the second tp
> one.
> +       trace_matches $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-1
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +       trace_matches $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-1
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +
> +       # Expectin NR_ITER events being the debug TP.
> +       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-2
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +}
> +
> +function test_python_multi_session_disable()
> +{
> +       diag "Test Python with multiple session with disabled event"
> +
> +       create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME=
-1
> +       enable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME
> +       enable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME2
> +       disable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME
> +       start_lttng_tracing_ok $SESSION_NAME-1
> +
> +       create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME=
-2
> +       enable_python_lttng_event $SESSION_NAME-2 $EVENT_NAME2
> +       start_lttng_tracing_ok $SESSION_NAME-2
> +
> +       # Run 5 times with a 1 second delay and fire second TP.
> +       run_app $1 0 1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME-1
> +       stop_lttng_tracing_ok $SESSION_NAME-2
> +       destroy_lttng_session_ok $SESSION_NAME-1
> +       destroy_lttng_session_ok $SESSION_NAME-2
> +
> +       # Validate test. Expecting one event of the second TP.
> +       trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-1
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +
> +       # Validate test. Expecting one event of the second TP.
> +       trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-2
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +}
> +
> +function test_python_multi_session_disable_wildcard()
> +{
> +       diag "Test Python with multiple session with disabled wildcard
> event"
> +
> +       create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME=
-1
> +       enable_python_lttng_event $SESSION_NAME-1 '*'
> +
> +       create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME=
-2
> +       enable_python_lttng_event $SESSION_NAME-2 '*'
> +
> +       disable_python_lttng_event $SESSION_NAME-1 '*'
> +
> +       start_lttng_tracing_ok $SESSION_NAME-1
> +       start_lttng_tracing_ok $SESSION_NAME-2
> +
> +       run_app $1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME-1
> +       stop_lttng_tracing_ok $SESSION_NAME-2
> +       destroy_lttng_session_ok $SESSION_NAME-1
> +       destroy_lttng_session_ok $SESSION_NAME-2
> +
> +       # Validate test. Expecting NO event of the first TP.
> +       trace_match_only $EVENT_NAME 0 $TRACE_PATH/$SESSION_NAME-1
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +
> +       # Validate test. Expecting all events of the first TP.
> +       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-2
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +}
> +
> +function test_python_disable_all()
> +{
> +       diag "Test Python with multiple session with disabled all event"
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
> +       enable_python_lttng_event $SESSION_NAME '*'
> +       enable_python_lttng_event $SESSION_NAME $EVENT_NAME
> +       enable_python_lttng_event $SESSION_NAME $EVENT_NAME2
> +
> +       disable_python_lttng_event $SESSION_NAME '*'
> +
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       run_app $1 0 1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting NO event of the first TP and second TP=
.
> +       trace_match_only $EVENT_NAME 0 $TRACE_PATH/$SESSION_NAME
> +       trace_match_only $EVENT_NAME2 0 $TRACE_PATH/$SESSION_NAME
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +}
> +
> +function test_python_multi_session()
> +{
> +       diag "Test Python with multiple session"
> +
> +       create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME=
-1
> +       enable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME
> +       start_lttng_tracing_ok $SESSION_NAME-1
> +
> +       create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME=
-2
> +       enable_python_lttng_event $SESSION_NAME-2 $EVENT_NAME2
> +       start_lttng_tracing_ok $SESSION_NAME-2
> +
> +       # Run 5 times with a 1 second delay and fire second TP.
> +       run_app $1 0 1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME-1
> +       stop_lttng_tracing_ok $SESSION_NAME-2
> +       destroy_lttng_session_ok $SESSION_NAME-1
> +       destroy_lttng_session_ok $SESSION_NAME-2
> +
> +       # Validate test. Expecting all events of first TP
> +       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-1
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +
> +       # Validate test. Expecting one event of the second TP.
> +       trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-2
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +}
> +
> +function test_python_destroy_session()
> +{
> +       diag "Test Python two session with destroy"
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/first-sess
> +       enable_python_lttng_event $SESSION_NAME $EVENT_NAME
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       # Run 5 times with a 1 second delay
> +       run_app_background $1 0 1
> +
> +       # Wait for the applications started in background
> +       wait
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting at least one event num 1
> +       validate_trace $EVENT_NAME $TRACE_PATH/first-sess
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/second-sess
> +       enable_python_lttng_event $SESSION_NAME $EVENT_NAME2
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       # Run 5 times with a 1 second delay
> +       run_app_background $1 0 1
> +
> +       # Wait for the applications started in background
> +       wait
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting only one event num 2
> +       trace_match_only $EVENT_NAME2 1 $TRACE_PATH/second-sess
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +}
> +
> +function test_python_filtering()
> +{
> +       diag "Test Python filtering"
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
> +       # Enable all event with a filter.
> +       enable_python_filter $SESSION_NAME '*' 'msg =3D=3D "python-ev-tes=
t2
> fired [INFO]"'
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       # Run 5 times with a 1 second delay and fire second TP.
> +       run_app $1 0 1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting one event of the second TP only.
> +       trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
> +       # Enable first Logger but filter msg payload for the INFO one whi=
le
> +       # triggering the debug and second TP.
> +       enable_python_filter $SESSION_NAME $EVENT_NAME 'msg =3D=3D
> "python-ev-test1 fired [INFO]"'
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       # Run 5 times with a 1 second delay, fire debug and second TP.
> +       run_app $1 1 1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting NR_ITER event of the main INFO tp.
> +       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +}
> +
> +function test_python_disable()
> +{
> +       diag "Test Python disable event"
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
> +       # Enable all event with a filter.
> +       enable_python_lttng_event $SESSION_NAME $EVENT_NAME
> +       enable_python_lttng_event $SESSION_NAME $EVENT_NAME2
> +       disable_python_lttng_event $SESSION_NAME $EVENT_NAME
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       # Run 5 times with a 1 second delay and fire second TP.
> +       run_app $1 0 1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting one event of the second TP only.
> +       trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +}
> +
> +function test_python_disable_enable()
> +{
> +       diag "Test Python disable event followed by an enable"
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
> +       # Enable all event with a filter.
> +       enable_python_lttng_event $SESSION_NAME $EVENT_NAME
> +       disable_python_lttng_event $SESSION_NAME $EVENT_NAME
> +       enable_python_lttng_event $SESSION_NAME $EVENT_NAME
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       # Run 5 times with a 1 second delay and fire second TP.
> +       run_app $1 0 1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting NR_ITER event of the main INFO tp.
> +       trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +}
> +
> +function test_python_filter_loglevel()
> +{
> +       local BOGUS_EVENT_NAME=3D"not_a_real_event"
> +       local FILTER=3D"int_loglevel > 30 || int_loglevel < 30"
> +       local ALL_EVENTS=3D"."
> +
> +       diag "Test Python a filter with a loglevel"
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
> +       # Enable an event with a filter and the loglevel-only option.
> +       enable_python_filter_loglevel_only $SESSION_NAME $BOGUS_EVENT_NAM=
E
> "$FILTER" "INFO"
> +       disable_python_lttng_event $SESSION_NAME $BOGUS_EVENT_NAME
> +       enable_python_filter_loglevel_only $SESSION_NAME $BOGUS_EVENT_NAM=
E
> "$FILTER" "INFO"
> +       start_lttng_tracing_ok $SESSION_NAME
> +
> +       # Run 5 times with a 1 second delay and fire second TP.
> +       run_app $1 0 1
> +
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Validate test. Expecting no events.
> +       trace_match_only $ALL_EVENTS 0 $TRACE_PATH/$SESSION_NAME
> +       if [ $? -ne 0 ]; then
> +               return $?
> +       fi
> +}
> +
> +plan_tests $NUM_TESTS
> +
> +print_test_banner "$TEST_DESC"
> +
> +if [[ ${#python_versions[@]} -eq 0 ||  "x$run_test" !=3D "xyes" ]]; then
> +       skip_agent=3D0
> +else
> +       skip_agent=3D1
> +fi
> +
> +skip $skip_agent "Python agent test skipped." $NUM_TESTS ||
> +{
> +       start_lttng_sessiond
> +
> +       tests=3D(
> +               test_python_multi_session_disable_wildcard
> +               test_python_multi_session_disable
> +               test_python_disable
> +               test_python_disable_enable
> +               test_python_disable_all
> +               test_python_filtering
> +               test_python_multi_session_loglevel
> +               test_python_destroy_session
> +               test_python_loglevel
> +               test_python_loglevel_multiple
> +               test_python_before_start
> +               test_python_after_start
> +               test_python_multi_session
> +               test_python_filter_loglevel
> +       )
> +
> +
> +       for python_version in ${python_versions[*]};
> +       do
> +               for fct_test in ${tests[@]};
> +               do
> +                       TRACE_PATH=3D$(mktemp -d)
> +
> +                       diag "(Python $python_version)"
> +                       ${fct_test} $python_version
> +                       if [ $? -ne 0 ]; then
> +                               break;
> +                       fi
> +                       rm -rf $TRACE_PATH
> +               done
> +       done
> +       stop_lttng_sessiond
> +}
> --
> 2.1.4
>
>
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--94eb2c0885be38c2a6051d25569c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Aug 6, 2015 at 7:00 PM, Jonathan Rajotte <span dir=3D"ltr">&lt;=
<a href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_blank">j=
onathan.rajotte-julien@efficios.com</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">Introduce --enable-test-python{2,3}-agent and --enable-tes=
t-python-agent-all<br>
flag on configure.<br>
<br>
Tests are enabled by default via best effort. Configure looks if it can fin=
d<br>
python agent for python 2&amp;3 and enable/skip tests.<br>
<br>
When used --enable-test-python{2,3}-agent &amp; --enable-test-python-agent-=
all flags<br>
force strict checks on tests dependancies and fails at configure instead of=
<br>
simply disabling tests.<br>
<br>
--disable* flags can be used to force tests skipping.<br>
<br>
Also minor bug in agent test on enabling event with filtering.<br>
<br>
Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte-juli=
en@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
---<br>
=C2=A0.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 121 +++-<br>
=C2=A0.../ust/python-logging/test_python_logging=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 603 --------------------<br>
=C2=A0.../ust/python-logging/<a href=3D"http://test_python_logging.in" rel=
=3D"noreferrer" target=3D"_blank">test_python_logging.in</a>=C2=A0 =C2=A0 =
=C2=A0 | 610 +++++++++++++++++++++<br>
=C2=A04 files changed, 731 insertions(+), 604 deletions(-)<br>
=C2=A0delete mode 100755 tests/regression/ust/python-logging/test_python_lo=
gging<br>
=C2=A0create mode 100755 tests/regression/ust/python-logging/<a href=3D"htt=
p://test_python_logging.in" rel=3D"noreferrer" target=3D"_blank">test_pytho=
n_logging.in</a><br>
<br>
diff --git a/.gitignore b/.gitignore<br>
index 5d24bec..0ce35f9 100644<br>
--- a/.gitignore<br>
+++ b/.gitignore<br>
@@ -85,6 +85,7 @@ health_check<br>
=C2=A0/tests/regression/ust/fork/fork<br>
=C2=A0/tests/regression/ust/fork/fork2<br>
=C2=A0/tests/regression/ust/libc-wrapper/prog<br>
+tests/regression/ust/python-logging/test_python_logging<br>
=C2=A0/tests/utils/testapp/gen-ust-nevents/gen-ust-nevents<br>
=C2=A0/tests/utils/testapp/gen-ust-tracef/gen-ust-tracef<br>
=C2=A0/tests/regression/tools/live/live_test<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index 324b596..386d557 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -359,7 +359,6 @@ if test &quot;x${enable_python_binding:-yes}&quot; =3D =
xyes; then<br>
=C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0AC_MSG_NOTICE([You may configure with --enable-python-b=
indings ]dnl<br>
=C2=A0[if you want Python bindings.])<br>
-<br>
=C2=A0fi<br>
<br>
=C2=A0# Epoll check. If not present, the build will fallback on poll() API<=
br>
@@ -414,6 +413,104 @@ if test &quot;x$test_java_agent_jul&quot; =3D &quot;x=
yes&quot; || test &quot;x$test_java_agent_log4j&quot; =3D &quot;xy<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0fi<br>
<br>
+# Python agent test<br>
+UST_PYTHON_AGENT=3D&quot;lttngust&quot;<br>
+<br>
+AC_ARG_ENABLE(test-python2-agent,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_HELP_STRING([--enable-test-python2-agent],<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[enable tests for p=
ython2 agent. Python2 interpreter path can be overrided by env. variable PY=
THON2. Default: Best effort]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0),[:],[test_python2_agent_best_effort=3Dyes]<br=
>
+)<br>
+<br>
+AC_ARG_ENABLE(test-python3-agent,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_HELP_STRING([--enable-test-python3-agent],<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[enable tests for p=
ython3 agent. Python3 interpreter path can be overrided by env. variable PY=
THON3. Default: Best effort]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0),[:],[test_python3_agent_best_effort=3Dyes]<br=
>
+)<br>
+<br>
+AC_ARG_ENABLE(test-python-agent-all,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_HELP_STRING([--enable-test-python-agent-all]=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[enable test for al=
l python{2/3} agent.]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0),<br>
+)<br>
+<br>
+AS_IF([test ! -z &quot;$enable_test_python_agent_all&quot;], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unset test_python2_agent_best_effort<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unset test_python3_agent_best_effort<br>
+])<br>
+<br>
+AS_IF([test &quot;x$enable_test_python_agent_all&quot; =3D &quot;xyes&quot=
;], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_test_python2_agent=3Dyes<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_test_python3_agent=3Dyes<br>
+])<br>
+<br>
+AS_IF([test &quot;x$enable_test_python_agent_all&quot; =3D &quot;xno&quot;=
], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_test_python2_agent=3Dno<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_test_python3_agent=3Dno<br>
+])<br>
+<br>
+<br>
+AS_IF([test &quot;x$enable_test_python2_agent&quot; =3D &quot;xyes&quot; -=
o &quot;x$test_python2_agent_best_effort&quot; =3D &quot;xyes&quot; ], [<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_IF([test -z &quot;$PYTHON2&quot;], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0PYTHON2=3Dpython2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_WARN([Using user-defined PYTHON2 ($PYTHON2) for lttng-ust =
python2 agent check])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0])<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AC_PATH_PROG([PYTHON2_BIN],[$PYTHON2])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_IF([test -z &quot;$PYTHON2_BIN&quot;], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AS_IF([test -z &quo=
t;$test_python2_agent_best_effort&quot;],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_ERROR([No python2 interpreter found. PYTHON2 can be set to=
 override default interpreter path])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_CHECKING([fo=
r python2 lttng-ust agent])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AS_IF([$PYTHON2_BIN=
 -c &quot;import $UST_PYTHON_AGENT&quot; 2&gt;/dev/null], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0PYTHON2_AGENT=3D$PYTHON2_BIN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_RESULT([yes])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0RUN_PYTHON_AGENT_TEST=3Dyes<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_RESULT([no])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AS_IF([test -z &quot;$test_python2_agent_best_effort&quot;],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_ERROR([No python2 agent found.=
 PYTHONPATH env. variable can be set with the path to the agent.])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0])<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0])<br>
+<br>
+])<br>
+<br>
+AS_IF([test &quot;x$enable_test_python3_agent&quot; =3D &quot;xyes&quot; -=
o &quot;x$test_python3_agent_best_effort&quot; =3D &quot;xyes&quot; ], [<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_IF([test -z &quot;$PYTHON3&quot;], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PYTHON3=3Dpython3<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_WARN([Using =
user-defined PYTHON3 ($PYTHON3) for lttng-ust python3 agent check])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0])<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AC_PATH_PROG([PYTHON3_BIN],[$PYTHON3])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_IF([test -z &quot;$PYTHON3_BIN&quot;], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AS_IF([test -z &quo=
t;$test_python3_agent_best_effort&quot;],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_ERROR([No python3 interpreter found. PYTHON3 can be set to=
 override default interpreter path])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_CHECKING([fo=
r python3 lttng-ust agent])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AS_IF([$PYTHON3_BIN=
 -c &quot;import $UST_PYTHON_AGENT&quot; 2&gt;/dev/null], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0PYTHON3_AGENT=3D$PYTHON3_BIN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_RESULT([yes])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0RUN_PYTHON_AGENT_TEST=3Dyes<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0], [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_RESULT([no])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AS_IF([test -z &quot;$test_python3_agent_best_effort&quot;],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_ERROR([No python3 agent found.=
 PYTHONPATH env. variable can be set with the path to the agent.])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0])<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0])<br>
+])<br>
+<br>
+AC_SUBST([RUN_PYTHON_AGENT_TEST])<br>
+AC_SUBST([PYTHON2_AGENT])<br>
+AC_SUBST([PYTHON3_AGENT])<br>
+<br>
=C2=A0AC_SYS_LARGEFILE<br>
<br>
=C2=A0# C compiler tests<br>
@@ -548,6 +645,9 @@ AC_CONFIG_FILES([<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tests/utils/testapp/gen-ust-tracef/Makefile<br>
=C2=A0])<br>
<br>
+# Inject variable into python test script<br>
+AC_CONFIG_FILES([tests/regression/ust/python-logging/test_python_logging],=
[chmod +x tests/regression/ust/python-logging/test_python_logging])<br>
+<br>
=C2=A0AC_OUTPUT<br>
<br>
=C2=A0#<br>
@@ -621,6 +721,25 @@ AS_IF([test &quot;x$consumerd_only&quot; =3D &quot;xye=
s&quot;],[<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 AS_ECHO(&quot;All binaries will be built.&quot;=
)<br>
=C2=A0])<br>
<br>
+<br>
+# Info on optionnal test suites.<br>
+AS_ECHO()<br>
+AS_ECHO(&quot;Additional test suites to be run on make check&quot;:)<br></=
blockquote><div><br></div><div>Looks good to me except this part. Can you m=
odify this to report whether or not the tests will run like we do for JUL a=
nd Log4j?</div><div><br></div><div><div>LTTng-UST Java agent JUL tests: Dis=
abled</div><div>LTTng-UST Java agent Log4j tests: Disabled</div></div><div>=
etc.</div><div><br></div><div>Regards,</div><div>J=C3=A9r=C3=A9mie</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
+<br>
+AS_ECHO_N(&quot;Python2 agent: &quot;)<br>
+AS_IF([test ! -z &quot;$PYTHON2_AGENT&quot;],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_ECHO(&quot;yes&quot;)<br>
+],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_ECHO(&quot;no&quot;)<br>
+])<br>
+<br>
+AS_ECHO_N(&quot;Python3 agent: &quot;)<br>
+AS_IF([test ! -z &quot;$PYTHON3_AGENT&quot;],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_ECHO(&quot;yes&quot;)<br>
+],[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AS_ECHO(&quot;no&quot;)<br>
+])<br>
+<br>
=C2=A0# Print the bindir and libdir this `make install&#39; will install in=
to.<br>
=C2=A0AS_ECHO()<br>
=C2=A0AS_ECHO_N(&quot;Binaries will be installed in:=C2=A0 &quot;)<br>
diff --git a/tests/regression/ust/python-logging/test_python_logging b/test=
s/regression/ust/python-logging/test_python_logging<br>
deleted file mode 100755<br>
index b4fb410..0000000<br>
--- a/tests/regression/ust/python-logging/test_python_logging<br>
+++ /dev/null<br>
@@ -1,603 +0,0 @@<br>
-#!/bin/bash<br>
-#<br>
-# Copyright (C) - 2015 Philippe Proulx &lt;<a href=3D"mailto:pproulx@effic=
ios.com">pproulx@efficios.com</a>&gt;<br>
-# Copyright (C) - 2014 David Goulet &lt;<a href=3D"mailto:dgoulet@efficios=
.com">dgoulet@efficios.com</a>&gt;<br>
-#<br>
-# This program is free software; you can redistribute it and/or modify it =
under<br>
-# the terms of the GNU General Public License, version 2 only, as publishe=
d by<br>
-# the Free Software Foundation.<br>
-#<br>
-# This program is distributed in the hope that it will be useful, but WITH=
OUT<br>
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FI=
TNESS<br>
-# FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public License for m=
ore<br>
-# details.<br>
-#<br>
-# You should have received a copy of the GNU General Public License along =
with<br>
-# this program; if not, write to the Free Software Foundation, Inc., 51<br=
>
-# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
-<br>
-TEST_DESC=3D&quot;Python support&quot;<br>
-<br>
-CURDIR=3D$(dirname $0)/<br>
-TESTDIR=3D$CURDIR/../../..<br>
-NR_ITER=3D5<br>
-NR_SEC_WAIT=3D1<br>
-TESTAPP_NAME=3D&quot;test&quot;<br>
-TESTAPP_BIN=3D&quot;$TESTAPP_NAME.py&quot;<br>
-TESTAPP_PATH=3D&quot;$CURDIR&quot;<br>
-SESSION_NAME=3D&quot;python-test&quot;<br>
-EVENT_NAME=3D&quot;python-ev-test1&quot;<br>
-EVENT_NAME2=3D&quot;python-ev-test2&quot;<br>
-OUTPUT_DEST=3D&quot;/dev/null&quot;<br>
-<br>
-NUM_TESTS=3D310<br>
-<br>
-source $TESTDIR/utils/utils.sh<br>
-<br>
-function run_app<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local python=3D$1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local debug_tp=3D$2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local fire_second_tp=3D$3<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$python $TESTAPP_PATH/$TESTAPP_BIN $NR_ITER $NR=
_SEC_WAIT $debug_tp $fire_second_tp<br>
-}<br>
-<br>
-function run_app_background<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $@ &amp;<br>
-}<br>
-<br>
-function enable_python_loglevel_only()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sess_name=3D$1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0event_name=3D&quot;$2&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0loglevel=3D$3<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0channel_name=3D$4<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ -z $channel_name ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# default channel i=
f none specified<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chan=3D&quot;&quot;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chan=3D&quot;-c $ch=
annel_name&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt --loglevel-only $loglevel &quot;$event_name&quot; $chan -s $sess_name -p=
 &gt;$OUTPUT_DEST<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Enable Python event $event_name for=
 session $sess_name with loglevel-only $loglevel&quot;<br>
-}<br>
-<br>
-function enable_python_filter()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local sess_name=3D&quot;$1&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local event_name=3D&quot;$2&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local filter=3D&quot;$3&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; -s $sess_name -p --filter &quot;$filter&quot; &g=
t;/dev/null 2&gt;&amp;1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Enable event $event_name with filte=
r $filter for session $sess_name&quot;<br>
-}<br>
-<br>
-function enable_python_filter_loglevel_only()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local sess_name=3D&quot;$1&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local event_name=3D&quot;$2&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local filter=3D&quot;$3&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local loglevel=3D&quot;$4&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt --loglevel-only $loglevel &quot;$event_name&quot; -s $sess_name -p --fil=
ter &quot;$filter&quot; &gt;$OUTPUT_DEST<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Enable event $event_name with filte=
r \&quot;$filter\&quot; and loglevel-only $loglevel for session $sess_name&=
quot;<br>
-}<br>
-<br>
-# MUST set TESTDIR before calling those functions<br>
-<br>
-function test_python_before_start ()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python application BEFORE traci=
ng starts&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app_background $1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Wait for the applications started in backgrou=
nd<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0wait<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-}<br>
-<br>
-function test_python_after_start ()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python application AFTER tracin=
g starts&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-}<br>
-<br>
-function test_python_loglevel ()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python application with logleve=
l&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event_loglevel $SESSION_NAM=
E $EVENT_NAME &quot;INFO&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python applications with lower =
loglevel&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event_loglevel $SESSION_NAM=
E $EVENT_NAME &quot;CRITICAL&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting 0 events.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME 0 $TRACE_PATH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python applications with higher=
 loglevel&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event_loglevel $SESSION_NAM=
E $EVENT_NAME &quot;DEBUG&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-}<br>
-<br>
-function test_python_loglevel_multiple ()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python application with multipl=
e loglevel&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event_loglevel $SESSION_NAM=
E $EVENT_NAME &quot;INFO&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event_loglevel $SESSION_NAM=
E $EVENT_NAME &quot;DEBUG&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire tw=
o TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events times two=
.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $(($NR_ITER * 2)) =
$TRACE_PATH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event_loglevel $SESSION_NAM=
E &#39;*&#39; &quot;INFO&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event_loglevel $SESSION_NAM=
E &#39;*&#39; &quot;DEBUG&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire tw=
o TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events times two=
.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $(($NR_ITER * 2)) =
$TRACE_PATH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-}<br>
-<br>
-function test_python_multi_session_loglevel()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python with multiple session&qu=
ot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-1 $TRACE_=
PATH/$SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_loglevel_only $SESSION_NAME-1 &#3=
9;*&#39; &quot;INFO&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-2 $TRACE_=
PATH/$SESSION_NAME-2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_loglevel_only $SESSION_NAME-2 &#3=
9;*&#39; &quot;DEBUG&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-2<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire se=
cond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 1 1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-2<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Expecting NR_ITER events being the main event=
 and the second tp one.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_matches $EVENT_NAME $NR_ITER $TRACE_PATH/=
$SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_matches $EVENT_NAME2 1 $TRACE_PATH/$SESSI=
ON_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Expectin NR_ITER events being the debug TP.<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH/$SESSION_NAME-2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-}<br>
-<br>
-function test_python_multi_session_disable()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python with multiple session wi=
th disabled event&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-1 $TRACE_=
PATH/$SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME-1 $EVEN=
T_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME-1 $EVEN=
T_NAME2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_python_lttng_event $SESSION_NAME-1 $EVE=
NT_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-2 $TRACE_=
PATH/$SESSION_NAME-2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME-2 $EVEN=
T_NAME2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-2<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire se=
cond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-2<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting one event of the sec=
ond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SE=
SSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting one event of the sec=
ond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SE=
SSION_NAME-2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-}<br>
-<br>
-function test_python_multi_session_disable_wildcard()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python with multiple session wi=
th disabled wildcard event&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-1 $TRACE_=
PATH/$SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME-1 &#39;=
*&#39;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-2 $TRACE_=
PATH/$SESSION_NAME-2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME-2 &#39;=
*&#39;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_python_lttng_event $SESSION_NAME-1 &#39=
;*&#39;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-2<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-2<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting NO event of the firs=
t TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME 0 $TRACE_PATH/$SES=
SION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events of the fi=
rst TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH/$SESSION_NAME-2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-}<br>
-<br>
-function test_python_disable_all()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python with multiple session wi=
th disabled all event&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/$SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME &#39;*&=
#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME2<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_python_lttng_event $SESSION_NAME &#39;*=
&#39;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting NO event of the firs=
t TP and second TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME 0 $TRACE_PATH/$SES=
SION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME2 0 $TRACE_PATH/$SE=
SSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-}<br>
-<br>
-function test_python_multi_session()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python with multiple session&qu=
ot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-1 $TRACE_=
PATH/$SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME-1 $EVEN=
T_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-2 $TRACE_=
PATH/$SESSION_NAME-2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME-2 $EVEN=
T_NAME2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-2<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire se=
cond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-2<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events of first =
TP<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH/$SESSION_NAME-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting one event of the sec=
ond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SE=
SSION_NAME-2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-}<br>
-<br>
-function test_python_destroy_session()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python two session with destroy=
&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/first-sess<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app_background $1 0 1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Wait for the applications started in backgrou=
nd<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0wait<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting at least one event n=
um 1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0validate_trace $EVENT_NAME $TRACE_PATH/first-se=
ss<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/second-sess<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app_background $1 0 1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Wait for the applications started in backgrou=
nd<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0wait<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting only one event num 2=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME2 1 $TRACE_PATH/sec=
ond-sess<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-}<br>
-<br>
-function test_python_filtering()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python filtering&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/$SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Enable all event with a filter.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_filter $SESSION_NAME &#39;*&#39; =
&#39;msg =3D=3D &quot;python-ev-test2 fired [INFO]&quot;&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire se=
cond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting one event of the sec=
ond TP only.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SE=
SSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/$SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Enable first Logger but filter msg payload fo=
r the INFO one while<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# triggering the debug and second TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_filter $SESSION_NAME $EVENT_NAME =
&#39;msg =3D=3D &quot;python-ev-test1 fired&quot; [INFO]&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay, fire debug=
 and second TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 1 1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting NR_ITER event of the=
 main INFO tp.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH/$SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-}<br>
-<br>
-function test_python_disable()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python disable event&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/$SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Enable all event with a filter.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_python_lttng_event $SESSION_NAME $EVENT=
_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire se=
cond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting one event of the sec=
ond TP only.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SE=
SSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-}<br>
-<br>
-function test_python_disable_enable()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python disable event followed b=
y an enable&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/$SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Enable all event with a filter.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_python_lttng_event $SESSION_NAME $EVENT=
_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire se=
cond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting NR_ITER event of the=
 main INFO tp.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH/$SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-}<br>
-<br>
-function test_python_filter_loglevel()<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local BOGUS_EVENT_NAME=3D&quot;not_a_real_event=
&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local FILTER=3D&quot;int_loglevel &gt; 30 || in=
t_loglevel &lt; 30&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local ALL_EVENTS=3D&quot;.&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python a filter with a loglevel=
&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/$SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Enable an event with a filter and the logleve=
l-only option.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_filter_loglevel_only $SESSION_NAM=
E $BOGUS_EVENT_NAME &quot;$FILTER&quot; &quot;INFO&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_python_lttng_event $SESSION_NAME $BOGUS=
_EVENT_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_filter_loglevel_only $SESSION_NAM=
E $BOGUS_EVENT_NAME &quot;$FILTER&quot; &quot;INFO&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire se=
cond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting no events.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $ALL_EVENTS 0 $TRACE_PATH/$SES=
SION_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-}<br>
-<br>
-plan_tests $NUM_TESTS<br>
-<br>
-print_test_banner &quot;$TEST_DESC&quot;<br>
-<br>
-if [ ! -f &quot;$TESTAPP_BIN&quot; ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0withapp=3D0<br>
-else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0withapp=3D1<br>
-fi<br>
-<br>
-skip $withapp &quot;Python support is needed. Skipping all tests.&quot; $N=
UM_TESTS ||<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_sessiond<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tests=3D(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_multi_s=
ession_disable_wildcard<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_multi_s=
ession_disable<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_disable=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_disable=
_enable<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_disable=
_all<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_filteri=
ng<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_multi_s=
ession_loglevel<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_destroy=
_session<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_logleve=
l<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_logleve=
l_multiple<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_before_=
start<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_after_s=
tart<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_multi_s=
ession<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_filter_=
loglevel<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for python_version in 2 3;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0do<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for fct_test in ${t=
ests[@]};<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TRACE_PATH=3D$(mktemp -d)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0diag &quot;(Python $python_version)&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0${fct_test} python$python_version<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if [ $? -ne 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fi<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rm -rf $TRACE_PATH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_sessiond<br>
-}<br>
diff --git a/tests/regression/ust/python-logging/<a href=3D"http://test_pyt=
hon_logging.in" rel=3D"noreferrer" target=3D"_blank">test_python_logging.in=
</a> b/tests/regression/ust/python-logging/<a href=3D"http://test_python_lo=
gging.in" rel=3D"noreferrer" target=3D"_blank">test_python_logging.in</a><b=
r>
new file mode 100755<br>
index 0000000..8aff408<br>
--- /dev/null<br>
+++ b/tests/regression/ust/python-logging/<a href=3D"http://test_python_log=
ging.in" rel=3D"noreferrer" target=3D"_blank">test_python_logging.in</a><br=
>
@@ -0,0 +1,610 @@<br>
+#!/bin/bash<br>
+#<br>
+# Copyright (C) - 2015 Philippe Proulx &lt;<a href=3D"mailto:pproulx@effic=
ios.com">pproulx@efficios.com</a>&gt;<br>
+# Copyright (C) - 2014 David Goulet &lt;<a href=3D"mailto:dgoulet@efficios=
.com">dgoulet@efficios.com</a>&gt;<br>
+#<br>
+# This program is free software; you can redistribute it and/or modify it =
under<br>
+# the terms of the GNU General Public License, version 2 only, as publishe=
d by<br>
+# the Free Software Foundation.<br>
+#<br>
+# This program is distributed in the hope that it will be useful, but WITH=
OUT<br>
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FI=
TNESS<br>
+# FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public License for m=
ore<br>
+# details.<br>
+#<br>
+# You should have received a copy of the GNU General Public License along =
with<br>
+# this program; if not, write to the Free Software Foundation, Inc., 51<br=
>
+# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
+<br>
+TEST_DESC=3D&quot;Python support&quot;<br>
+<br>
+CURDIR=3D$(dirname $0)/<br>
+TESTDIR=3D$CURDIR/../../..<br>
+NR_ITER=3D5<br>
+NR_SEC_WAIT=3D0<br>
+TESTAPP_NAME=3D&quot;test&quot;<br>
+TESTAPP_BIN=3D&quot;$TESTAPP_NAME.py&quot;<br>
+TESTAPP_PATH=3D&quot;$CURDIR&quot;<br>
+SESSION_NAME=3D&quot;python-test&quot;<br>
+EVENT_NAME=3D&quot;python-ev-test1&quot;<br>
+EVENT_NAME2=3D&quot;python-ev-test2&quot;<br>
+OUTPUT_DEST=3D&quot;/dev/null&quot;<br>
+<br>
+python_versions=3D(@PYTHON2_AGENT@ @PYTHON3_AGENT@)<br>
+run_test=3D@RUN_PYTHON_AGENT_TEST@<br>
+<br>
+if [[ -z &quot;$run_test&quot; ]]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0NUM_TESTS=3D1<br>
+else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0NUM_TESTS=3D$(((154 * ${#python_versions[@]})+2=
))<br>
+fi<br>
+<br>
+source $TESTDIR/utils/utils.sh<br>
+<br>
+function run_app<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local python=3D$1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local debug_tp=3D$2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local fire_second_tp=3D$3<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$python $TESTAPP_PATH/$TESTAPP_BIN $NR_ITER $NR=
_SEC_WAIT $debug_tp $fire_second_tp<br>
+}<br>
+<br>
+function run_app_background<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $@ &amp;<br>
+}<br>
+<br>
+function enable_python_loglevel_only()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sess_name=3D$1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0event_name=3D&quot;$2&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0loglevel=3D$3<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0channel_name=3D$4<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ -z $channel_name ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# default channel i=
f none specified<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chan=3D&quot;&quot;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chan=3D&quot;-c $ch=
annel_name&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt --loglevel-only $loglevel &quot;$event_name&quot; $chan -s $sess_name -p=
 &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Enable Python event $event_name for=
 session $sess_name with loglevel-only $loglevel&quot;<br>
+}<br>
+<br>
+function enable_python_filter()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local sess_name=3D&quot;$1&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local event_name=3D&quot;$2&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local filter=3D&quot;$3&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; -s $sess_name -p --filter &quot;$filter&quot; &g=
t;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Enable event $event_name with filte=
r $filter for session $sess_name&quot;<br>
+}<br>
+<br>
+function enable_python_filter_loglevel_only()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local sess_name=3D&quot;$1&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local event_name=3D&quot;$2&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local filter=3D&quot;$3&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local loglevel=3D&quot;$4&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt --loglevel-only $loglevel &quot;$event_name&quot; -s $sess_name -p --fil=
ter &quot;$filter&quot; &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Enable event $event_name with filte=
r \&quot;$filter\&quot; and loglevel-only $loglevel for session $sess_name&=
quot;<br>
+}<br>
+<br>
+# MUST set TESTDIR before calling those functions<br>
+<br>
+function test_python_before_start ()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python application BEFORE traci=
ng starts&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app_background $1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Wait for the applications started in backgrou=
nd<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wait<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+}<br>
+<br>
+function test_python_after_start ()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python application AFTER tracin=
g starts&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+}<br>
+<br>
+function test_python_loglevel ()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python application with logleve=
l&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event_loglevel $SESSION_NAM=
E $EVENT_NAME &quot;INFO&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python applications with lower =
loglevel&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event_loglevel $SESSION_NAM=
E $EVENT_NAME &quot;CRITICAL&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting 0 events.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME 0 $TRACE_PATH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python applications with higher=
 loglevel&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event_loglevel $SESSION_NAM=
E $EVENT_NAME &quot;DEBUG&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+}<br>
+<br>
+function test_python_loglevel_multiple ()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python application with multipl=
e loglevel&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event_loglevel $SESSION_NAM=
E $EVENT_NAME &quot;INFO&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event_loglevel $SESSION_NAM=
E $EVENT_NAME &quot;DEBUG&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire tw=
o TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events times two=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $(($NR_ITER * 2)) =
$TRACE_PATH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event_loglevel $SESSION_NAM=
E &#39;*&#39; &quot;INFO&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event_loglevel $SESSION_NAM=
E &#39;*&#39; &quot;DEBUG&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire tw=
o TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events times two=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $(($NR_ITER * 2)) =
$TRACE_PATH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+}<br>
+<br>
+function test_python_multi_session_loglevel()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python with multiple session&qu=
ot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-1 $TRACE_=
PATH/$SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_loglevel_only $SESSION_NAME-1 &#3=
9;*&#39; &quot;INFO&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-2 $TRACE_=
PATH/$SESSION_NAME-2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_loglevel_only $SESSION_NAME-2 &#3=
9;*&#39; &quot;DEBUG&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-2<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire se=
cond TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 1 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-2<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Expecting NR_ITER events being the main event=
 and the second tp one.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_matches $EVENT_NAME $NR_ITER $TRACE_PATH/=
$SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_matches $EVENT_NAME2 1 $TRACE_PATH/$SESSI=
ON_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Expectin NR_ITER events being the debug TP.<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH/$SESSION_NAME-2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+}<br>
+<br>
+function test_python_multi_session_disable()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python with multiple session wi=
th disabled event&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-1 $TRACE_=
PATH/$SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME-1 $EVEN=
T_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME-1 $EVEN=
T_NAME2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_python_lttng_event $SESSION_NAME-1 $EVE=
NT_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-2 $TRACE_=
PATH/$SESSION_NAME-2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME-2 $EVEN=
T_NAME2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-2<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire se=
cond TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-2<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting one event of the sec=
ond TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SE=
SSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting one event of the sec=
ond TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SE=
SSION_NAME-2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+}<br>
+<br>
+function test_python_multi_session_disable_wildcard()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python with multiple session wi=
th disabled wildcard event&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-1 $TRACE_=
PATH/$SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME-1 &#39;=
*&#39;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-2 $TRACE_=
PATH/$SESSION_NAME-2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME-2 &#39;=
*&#39;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_python_lttng_event $SESSION_NAME-1 &#39=
;*&#39;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-2<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-2<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting NO event of the firs=
t TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME 0 $TRACE_PATH/$SES=
SION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events of the fi=
rst TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH/$SESSION_NAME-2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+}<br>
+<br>
+function test_python_disable_all()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python with multiple session wi=
th disabled all event&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/$SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME &#39;*&=
#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME2<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_python_lttng_event $SESSION_NAME &#39;*=
&#39;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting NO event of the firs=
t TP and second TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME 0 $TRACE_PATH/$SES=
SION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME2 0 $TRACE_PATH/$SE=
SSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+}<br>
+<br>
+function test_python_multi_session()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python with multiple session&qu=
ot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-1 $TRACE_=
PATH/$SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME-1 $EVEN=
T_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME-2 $TRACE_=
PATH/$SESSION_NAME-2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME-2 $EVEN=
T_NAME2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME-2<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire se=
cond TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME-2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME-2<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting all events of first =
TP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH/$SESSION_NAME-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting one event of the sec=
ond TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SE=
SSION_NAME-2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+}<br>
+<br>
+function test_python_destroy_session()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python two session with destroy=
&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/first-sess<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app_background $1 0 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Wait for the applications started in backgrou=
nd<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wait<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting at least one event n=
um 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0validate_trace $EVENT_NAME $TRACE_PATH/first-se=
ss<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/second-sess<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app_background $1 0 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Wait for the applications started in backgrou=
nd<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wait<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting only one event num 2=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME2 1 $TRACE_PATH/sec=
ond-sess<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+}<br>
+<br>
+function test_python_filtering()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python filtering&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/$SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Enable all event with a filter.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_filter $SESSION_NAME &#39;*&#39; =
&#39;msg =3D=3D &quot;python-ev-test2 fired [INFO]&quot;&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire se=
cond TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting one event of the sec=
ond TP only.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SE=
SSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/$SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Enable first Logger but filter msg payload fo=
r the INFO one while<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# triggering the debug and second TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_filter $SESSION_NAME $EVENT_NAME =
&#39;msg =3D=3D &quot;python-ev-test1 fired [INFO]&quot;&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay, fire debug=
 and second TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 1 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting NR_ITER event of the=
 main INFO tp.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH/$SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+}<br>
+<br>
+function test_python_disable()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python disable event&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/$SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Enable all event with a filter.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_python_lttng_event $SESSION_NAME $EVENT=
_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire se=
cond TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting one event of the sec=
ond TP only.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SE=
SSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+}<br>
+<br>
+function test_python_disable_enable()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python disable event followed b=
y an enable&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/$SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Enable all event with a filter.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_python_lttng_event $SESSION_NAME $EVENT=
_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire se=
cond TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting NR_ITER event of the=
 main INFO tp.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $EVENT_NAME $NR_ITER $TRACE_PA=
TH/$SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+}<br>
+<br>
+function test_python_filter_loglevel()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local BOGUS_EVENT_NAME=3D&quot;not_a_real_event=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local FILTER=3D&quot;int_loglevel &gt; 30 || in=
t_loglevel &lt; 30&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local ALL_EVENTS=3D&quot;.&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Test Python a filter with a loglevel=
&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH/$SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Enable an event with a filter and the logleve=
l-only option.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_filter_loglevel_only $SESSION_NAM=
E $BOGUS_EVENT_NAME &quot;$FILTER&quot; &quot;INFO&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_python_lttng_event $SESSION_NAME $BOGUS=
_EVENT_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_filter_loglevel_only $SESSION_NAM=
E $BOGUS_EVENT_NAME &quot;$FILTER&quot; &quot;INFO&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Run 5 times with a 1 second delay and fire se=
cond TP.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate test. Expecting no events.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_match_only $ALL_EVENTS 0 $TRACE_PATH/$SES=
SION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+}<br>
+<br>
+plan_tests $NUM_TESTS<br>
+<br>
+print_test_banner &quot;$TEST_DESC&quot;<br>
+<br>
+if [[ ${#python_versions[@]} -eq 0 ||=C2=A0 &quot;x$run_test&quot; !=3D &q=
uot;xyes&quot; ]]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0skip_agent=3D0<br>
+else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0skip_agent=3D1<br>
+fi<br>
+<br>
+skip $skip_agent &quot;Python agent test skipped.&quot; $NUM_TESTS ||<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_sessiond<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tests=3D(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_multi_s=
ession_disable_wildcard<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_multi_s=
ession_disable<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_disable=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_disable=
_enable<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_disable=
_all<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_filteri=
ng<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_multi_s=
ession_loglevel<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_destroy=
_session<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_logleve=
l<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_logleve=
l_multiple<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_before_=
start<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_after_s=
tart<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_multi_s=
ession<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_python_filter_=
loglevel<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
+<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for python_version in ${python_versions[*]};<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for fct_test in ${t=
ests[@]};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TRACE_PATH=3D$(mktemp -d)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0diag &quot;(Python $python_version)&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0${fct_test} $python_version<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rm -rf $TRACE_PATH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_sessiond<br>
+}<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div></div>

--94eb2c0885be38c2a6051d25569c--


--===============1024821614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1024821614==--
