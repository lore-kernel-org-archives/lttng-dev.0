From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 3/3] Fix: Python agent tests were
	always skipped
Date: Thu,  6 Aug 2015 19:00:16 -0400
Message-ID: <1438902016-17511-3-git-send-email-jonathan.rajotte-julien__9629.59294342927$1438902148$gmane$org@efficios.com>
References: <1438902016-17511-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZNU9b-0007iu-6T
 for lttng-dev@lists.lttng.org; Thu, 06 Aug 2015 19:00:55 -0400
In-Reply-To: <1438902016-17511-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Introduce --enable-test-python{2,3}-agent and --enable-test-python-agent-all
flag on configure.

Tests are enabled by default via best effort. Configure looks if it can find
python agent for python 2&3 and enable/skip tests.

When used --enable-test-python{2,3}-agent & --enable-test-python-agent-all flags
force strict checks on tests dependancies and fails at configure instead of
simply disabling tests.

--disable* flags can be used to force tests skipping.

Also minor bug in agent test on enabling event with filtering.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 .gitignore                                         |   1 +
 configure.ac                                       | 121 +++-
 .../ust/python-logging/test_python_logging         | 603 --------------------
 .../ust/python-logging/test_python_logging.in      | 610 +++++++++++++++++++++
 4 files changed, 731 insertions(+), 604 deletions(-)
 delete mode 100755 tests/regression/ust/python-logging/test_python_logging
 create mode 100755 tests/regression/ust/python-logging/test_python_logging.in

diff --git a/.gitignore b/.gitignore
index 5d24bec..0ce35f9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -85,6 +85,7 @@ health_check
 /tests/regression/ust/fork/fork
 /tests/regression/ust/fork/fork2
 /tests/regression/ust/libc-wrapper/prog
+tests/regression/ust/python-logging/test_python_logging
 /tests/utils/testapp/gen-ust-nevents/gen-ust-nevents
 /tests/utils/testapp/gen-ust-tracef/gen-ust-tracef
 /tests/regression/tools/live/live_test
diff --git a/configure.ac b/configure.ac
index 324b596..386d557 100644
--- a/configure.ac
+++ b/configure.ac
@@ -359,7 +359,6 @@ if test "x${enable_python_binding:-yes}" = xyes; then
 else
     AC_MSG_NOTICE([You may configure with --enable-python-bindings ]dnl
 [if you want Python bindings.])
-
 fi
 
 # Epoll check. If not present, the build will fallback on poll() API
@@ -414,6 +413,104 @@ if test "x$test_java_agent_jul" = "xyes" || test "x$test_java_agent_log4j" = "xy
 	fi
 fi
 
+# Python agent test
+UST_PYTHON_AGENT="lttngust"
+
+AC_ARG_ENABLE(test-python2-agent,
+	AS_HELP_STRING([--enable-test-python2-agent],
+		[enable tests for python2 agent. Python2 interpreter path can be overrided by env. variable PYTHON2. Default: Best effort]
+	),[:],[test_python2_agent_best_effort=yes]
+)
+
+AC_ARG_ENABLE(test-python3-agent,
+	AS_HELP_STRING([--enable-test-python3-agent],
+		[enable tests for python3 agent. Python3 interpreter path can be overrided by env. variable PYTHON3. Default: Best effort]
+	),[:],[test_python3_agent_best_effort=yes]
+)
+
+AC_ARG_ENABLE(test-python-agent-all,
+	AS_HELP_STRING([--enable-test-python-agent-all],
+		[enable test for all python{2/3} agent.]
+	),
+)
+
+AS_IF([test ! -z "$enable_test_python_agent_all"], [
+       unset test_python2_agent_best_effort
+       unset test_python3_agent_best_effort
+])
+
+AS_IF([test "x$enable_test_python_agent_all" = "xyes"], [
+       enable_test_python2_agent=yes
+       enable_test_python3_agent=yes
+])
+
+AS_IF([test "x$enable_test_python_agent_all" = "xno"], [
+       enable_test_python2_agent=no
+       enable_test_python3_agent=no
+])
+
+
+AS_IF([test "x$enable_test_python2_agent" = "xyes" -o "x$test_python2_agent_best_effort" = "xyes" ], [
+	AS_IF([test -z "$PYTHON2"], [
+			PYTHON2=python2
+		], [
+			AC_MSG_WARN([Using user-defined PYTHON2 ($PYTHON2) for lttng-ust python2 agent check])
+	])
+
+	AC_PATH_PROG([PYTHON2_BIN],[$PYTHON2])
+	AS_IF([test -z "$PYTHON2_BIN"], [
+		AS_IF([test -z "$test_python2_agent_best_effort"],[
+			AC_MSG_ERROR([No python2 interpreter found. PYTHON2 can be set to override default interpreter path])
+		])
+	], [
+		AC_MSG_CHECKING([for python2 lttng-ust agent])
+		AS_IF([$PYTHON2_BIN -c "import $UST_PYTHON_AGENT" 2>/dev/null], [
+			PYTHON2_AGENT=$PYTHON2_BIN
+			AC_MSG_RESULT([yes])
+			RUN_PYTHON_AGENT_TEST=yes
+		], [
+			AC_MSG_RESULT([no])
+			AS_IF([test -z "$test_python2_agent_best_effort"],[
+				AC_MSG_ERROR([No python2 agent found. PYTHONPATH env. variable can be set with the path to the agent.])
+			])
+		])
+
+	])
+
+])
+
+AS_IF([test "x$enable_test_python3_agent" = "xyes" -o "x$test_python3_agent_best_effort" = "xyes" ], [
+	AS_IF([test -z "$PYTHON3"], [
+		PYTHON3=python3
+	], [
+		AC_MSG_WARN([Using user-defined PYTHON3 ($PYTHON3) for lttng-ust python3 agent check])
+	])
+
+	AC_PATH_PROG([PYTHON3_BIN],[$PYTHON3])
+	AS_IF([test -z "$PYTHON3_BIN"], [
+		AS_IF([test -z "$test_python3_agent_best_effort"],[
+			AC_MSG_ERROR([No python3 interpreter found. PYTHON3 can be set to override default interpreter path])
+		])
+	], [
+		AC_MSG_CHECKING([for python3 lttng-ust agent])
+		AS_IF([$PYTHON3_BIN -c "import $UST_PYTHON_AGENT" 2>/dev/null], [
+			PYTHON3_AGENT=$PYTHON3_BIN
+			AC_MSG_RESULT([yes])
+			RUN_PYTHON_AGENT_TEST=yes
+		], [
+			AC_MSG_RESULT([no])
+			AS_IF([test -z "$test_python3_agent_best_effort"],[
+				AC_MSG_ERROR([No python3 agent found. PYTHONPATH env. variable can be set with the path to the agent.])
+			])
+		])
+
+	])
+])
+
+AC_SUBST([RUN_PYTHON_AGENT_TEST])
+AC_SUBST([PYTHON2_AGENT])
+AC_SUBST([PYTHON3_AGENT])
+
 AC_SYS_LARGEFILE
 
 # C compiler tests
@@ -548,6 +645,9 @@ AC_CONFIG_FILES([
 	tests/utils/testapp/gen-ust-tracef/Makefile
 ])
 
+# Inject variable into python test script
+AC_CONFIG_FILES([tests/regression/ust/python-logging/test_python_logging],[chmod +x tests/regression/ust/python-logging/test_python_logging])
+
 AC_OUTPUT
 
 #
@@ -621,6 +721,25 @@ AS_IF([test "x$consumerd_only" = "xyes"],[
 	AS_ECHO("All binaries will be built.")
 ])
 
+
+# Info on optionnal test suites.
+AS_ECHO()
+AS_ECHO("Additional test suites to be run on make check":)
+
+AS_ECHO_N("Python2 agent: ")
+AS_IF([test ! -z "$PYTHON2_AGENT"],[
+	AS_ECHO("yes")
+],[
+	AS_ECHO("no")
+])
+
+AS_ECHO_N("Python3 agent: ")
+AS_IF([test ! -z "$PYTHON3_AGENT"],[
+	AS_ECHO("yes")
+],[
+	AS_ECHO("no")
+])
+
 # Print the bindir and libdir this `make install' will install into.
 AS_ECHO()
 AS_ECHO_N("Binaries will be installed in:  ")
diff --git a/tests/regression/ust/python-logging/test_python_logging b/tests/regression/ust/python-logging/test_python_logging
deleted file mode 100755
index b4fb410..0000000
--- a/tests/regression/ust/python-logging/test_python_logging
+++ /dev/null
@@ -1,603 +0,0 @@
-#!/bin/bash
-#
-# Copyright (C) - 2015 Philippe Proulx <pproulx@efficios.com>
-# Copyright (C) - 2014 David Goulet <dgoulet@efficios.com>
-#
-# This program is free software; you can redistribute it and/or modify it under
-# the terms of the GNU General Public License, version 2 only, as published by
-# the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
-# details.
-#
-# You should have received a copy of the GNU General Public License along with
-# this program; if not, write to the Free Software Foundation, Inc., 51
-# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-TEST_DESC="Python support"
-
-CURDIR=$(dirname $0)/
-TESTDIR=$CURDIR/../../..
-NR_ITER=5
-NR_SEC_WAIT=1
-TESTAPP_NAME="test"
-TESTAPP_BIN="$TESTAPP_NAME.py"
-TESTAPP_PATH="$CURDIR"
-SESSION_NAME="python-test"
-EVENT_NAME="python-ev-test1"
-EVENT_NAME2="python-ev-test2"
-OUTPUT_DEST="/dev/null"
-
-NUM_TESTS=310
-
-source $TESTDIR/utils/utils.sh
-
-function run_app
-{
-	local python=$1
-	local debug_tp=$2
-	local fire_second_tp=$3
-
-	$python $TESTAPP_PATH/$TESTAPP_BIN $NR_ITER $NR_SEC_WAIT $debug_tp $fire_second_tp
-}
-
-function run_app_background
-{
-	run_app $@ &
-}
-
-function enable_python_loglevel_only()
-{
-	sess_name=$1
-	event_name="$2"
-	loglevel=$3
-	channel_name=$4
-
-	if [ -z $channel_name ]; then
-		# default channel if none specified
-		chan=""
-	else
-		chan="-c $channel_name"
-	fi
-
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel-only $loglevel "$event_name" $chan -s $sess_name -p >$OUTPUT_DEST
-	ok $? "Enable Python event $event_name for session $sess_name with loglevel-only $loglevel"
-}
-
-function enable_python_filter()
-{
-	local sess_name="$1"
-	local event_name="$2"
-	local filter="$3"
-
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -s $sess_name -p --filter "$filter" >/dev/null 2>&1
-	ok $? "Enable event $event_name with filter $filter for session $sess_name"
-}
-
-function enable_python_filter_loglevel_only()
-{
-	local sess_name="$1"
-	local event_name="$2"
-	local filter="$3"
-	local loglevel="$4"
-
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel-only $loglevel "$event_name" -s $sess_name -p --filter "$filter" >$OUTPUT_DEST
-	ok $? "Enable event $event_name with filter \"$filter\" and loglevel-only $loglevel for session $sess_name"
-}
-
-# MUST set TESTDIR before calling those functions
-
-function test_python_before_start ()
-{
-	diag "Test Python application BEFORE tracing starts"
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
-	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
-
-	# Run 5 times with a 1 second delay
-	run_app_background $1
-
-	start_lttng_tracing_ok $SESSION_NAME
-
-	# Wait for the applications started in background
-	wait
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting all events.
-	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-}
-
-function test_python_after_start ()
-{
-	diag "Test Python application AFTER tracing starts"
-
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
-	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
-	start_lttng_tracing_ok $SESSION_NAME
-
-	# Run 5 times with a 1 second delay
-	run_app $1
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting all events.
-	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-}
-
-function test_python_loglevel ()
-{
-	diag "Test Python application with loglevel"
-
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
-	enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME "INFO"
-	start_lttng_tracing_ok $SESSION_NAME
-
-	# Run 5 times with a 1 second delay
-	run_app $1
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting all events.
-	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-
-	diag "Test Python applications with lower loglevel"
-
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
-	enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME "CRITICAL"
-	start_lttng_tracing_ok $SESSION_NAME
-
-	# Run 5 times with a 1 second delay
-	run_app $1
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting 0 events.
-	trace_match_only $EVENT_NAME 0 $TRACE_PATH
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-
-	diag "Test Python applications with higher loglevel"
-
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
-	enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME "DEBUG"
-	start_lttng_tracing_ok $SESSION_NAME
-
-	# Run 5 times with a 1 second delay
-	run_app $1
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting all events.
-	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
-	return $?
-}
-
-function test_python_loglevel_multiple ()
-{
-	diag "Test Python application with multiple loglevel"
-
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
-	enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME "INFO"
-	enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME "DEBUG"
-	start_lttng_tracing_ok $SESSION_NAME
-
-	# Run 5 times with a 1 second delay and fire two TP.
-	run_app $1 1
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting all events times two.
-	trace_match_only $EVENT_NAME $(($NR_ITER * 2)) $TRACE_PATH
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
-	enable_python_lttng_event_loglevel $SESSION_NAME '*' "INFO"
-	enable_python_lttng_event_loglevel $SESSION_NAME '*' "DEBUG"
-	start_lttng_tracing_ok $SESSION_NAME
-
-	# Run 5 times with a 1 second delay and fire two TP.
-	run_app $1 1
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting all events times two.
-	trace_match_only $EVENT_NAME $(($NR_ITER * 2)) $TRACE_PATH
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-}
-
-function test_python_multi_session_loglevel()
-{
-	diag "Test Python with multiple session"
-
-	create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME-1
-	enable_python_loglevel_only $SESSION_NAME-1 '*' "INFO"
-	start_lttng_tracing_ok $SESSION_NAME-1
-
-	create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME-2
-	enable_python_loglevel_only $SESSION_NAME-2 '*' "DEBUG"
-	start_lttng_tracing_ok $SESSION_NAME-2
-
-	# Run 5 times with a 1 second delay and fire second TP.
-	run_app $1 1 1
-
-	stop_lttng_tracing_ok $SESSION_NAME-1
-	stop_lttng_tracing_ok $SESSION_NAME-2
-	destroy_lttng_session_ok $SESSION_NAME-1
-	destroy_lttng_session_ok $SESSION_NAME-2
-
-	# Expecting NR_ITER events being the main event and the second tp one.
-	trace_matches $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-1
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-	trace_matches $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-1
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-
-	# Expectin NR_ITER events being the debug TP.
-	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-2
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-}
-
-function test_python_multi_session_disable()
-{
-	diag "Test Python with multiple session with disabled event"
-
-	create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME-1
-	enable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME
-	enable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME2
-	disable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME
-	start_lttng_tracing_ok $SESSION_NAME-1
-
-	create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME-2
-	enable_python_lttng_event $SESSION_NAME-2 $EVENT_NAME2
-	start_lttng_tracing_ok $SESSION_NAME-2
-
-	# Run 5 times with a 1 second delay and fire second TP.
-	run_app $1 0 1
-
-	stop_lttng_tracing_ok $SESSION_NAME-1
-	stop_lttng_tracing_ok $SESSION_NAME-2
-	destroy_lttng_session_ok $SESSION_NAME-1
-	destroy_lttng_session_ok $SESSION_NAME-2
-
-	# Validate test. Expecting one event of the second TP.
-	trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-1
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-
-	# Validate test. Expecting one event of the second TP.
-	trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-2
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-}
-
-function test_python_multi_session_disable_wildcard()
-{
-	diag "Test Python with multiple session with disabled wildcard event"
-
-	create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME-1
-	enable_python_lttng_event $SESSION_NAME-1 '*'
-
-	create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME-2
-	enable_python_lttng_event $SESSION_NAME-2 '*'
-
-	disable_python_lttng_event $SESSION_NAME-1 '*'
-
-	start_lttng_tracing_ok $SESSION_NAME-1
-	start_lttng_tracing_ok $SESSION_NAME-2
-
-	run_app $1
-
-	stop_lttng_tracing_ok $SESSION_NAME-1
-	stop_lttng_tracing_ok $SESSION_NAME-2
-	destroy_lttng_session_ok $SESSION_NAME-1
-	destroy_lttng_session_ok $SESSION_NAME-2
-
-	# Validate test. Expecting NO event of the first TP.
-	trace_match_only $EVENT_NAME 0 $TRACE_PATH/$SESSION_NAME-1
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-
-	# Validate test. Expecting all events of the first TP.
-	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-2
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-}
-
-function test_python_disable_all()
-{
-	diag "Test Python with multiple session with disabled all event"
-
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
-	enable_python_lttng_event $SESSION_NAME '*'
-	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
-	enable_python_lttng_event $SESSION_NAME $EVENT_NAME2
-
-	disable_python_lttng_event $SESSION_NAME '*'
-
-	start_lttng_tracing_ok $SESSION_NAME
-
-	run_app $1 0 1
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting NO event of the first TP and second TP.
-	trace_match_only $EVENT_NAME 0 $TRACE_PATH/$SESSION_NAME
-	trace_match_only $EVENT_NAME2 0 $TRACE_PATH/$SESSION_NAME
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-}
-
-function test_python_multi_session()
-{
-	diag "Test Python with multiple session"
-
-	create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME-1
-	enable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME
-	start_lttng_tracing_ok $SESSION_NAME-1
-
-	create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME-2
-	enable_python_lttng_event $SESSION_NAME-2 $EVENT_NAME2
-	start_lttng_tracing_ok $SESSION_NAME-2
-
-	# Run 5 times with a 1 second delay and fire second TP.
-	run_app $1 0 1
-
-	stop_lttng_tracing_ok $SESSION_NAME-1
-	stop_lttng_tracing_ok $SESSION_NAME-2
-	destroy_lttng_session_ok $SESSION_NAME-1
-	destroy_lttng_session_ok $SESSION_NAME-2
-
-	# Validate test. Expecting all events of first TP
-	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-1
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-
-	# Validate test. Expecting one event of the second TP.
-	trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-2
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-}
-
-function test_python_destroy_session()
-{
-	diag "Test Python two session with destroy"
-
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/first-sess
-	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
-	start_lttng_tracing_ok $SESSION_NAME
-
-	# Run 5 times with a 1 second delay
-	run_app_background $1 0 1
-
-	# Wait for the applications started in background
-	wait
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting at least one event num 1
-	validate_trace $EVENT_NAME $TRACE_PATH/first-sess
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/second-sess
-	enable_python_lttng_event $SESSION_NAME $EVENT_NAME2
-	start_lttng_tracing_ok $SESSION_NAME
-
-	# Run 5 times with a 1 second delay
-	run_app_background $1 0 1
-
-	# Wait for the applications started in background
-	wait
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting only one event num 2
-	trace_match_only $EVENT_NAME2 1 $TRACE_PATH/second-sess
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-}
-
-function test_python_filtering()
-{
-	diag "Test Python filtering"
-
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
-	# Enable all event with a filter.
-	enable_python_filter $SESSION_NAME '*' 'msg == "python-ev-test2 fired [INFO]"'
-	start_lttng_tracing_ok $SESSION_NAME
-
-	# Run 5 times with a 1 second delay and fire second TP.
-	run_app $1 0 1
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting one event of the second TP only.
-	trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
-	# Enable first Logger but filter msg payload for the INFO one while
-	# triggering the debug and second TP.
-	enable_python_filter $SESSION_NAME $EVENT_NAME 'msg == "python-ev-test1 fired" [INFO]'
-	start_lttng_tracing_ok $SESSION_NAME
-
-	# Run 5 times with a 1 second delay, fire debug and second TP.
-	run_app $1 1 1
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting NR_ITER event of the main INFO tp.
-	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-}
-
-function test_python_disable()
-{
-	diag "Test Python disable event"
-
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
-	# Enable all event with a filter.
-	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
-	enable_python_lttng_event $SESSION_NAME $EVENT_NAME2
-	disable_python_lttng_event $SESSION_NAME $EVENT_NAME
-	start_lttng_tracing_ok $SESSION_NAME
-
-	# Run 5 times with a 1 second delay and fire second TP.
-	run_app $1 0 1
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting one event of the second TP only.
-	trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-}
-
-function test_python_disable_enable()
-{
-	diag "Test Python disable event followed by an enable"
-
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
-	# Enable all event with a filter.
-	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
-	disable_python_lttng_event $SESSION_NAME $EVENT_NAME
-	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
-	start_lttng_tracing_ok $SESSION_NAME
-
-	# Run 5 times with a 1 second delay and fire second TP.
-	run_app $1 0 1
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting NR_ITER event of the main INFO tp.
-	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-}
-
-function test_python_filter_loglevel()
-{
-	local BOGUS_EVENT_NAME="not_a_real_event"
-	local FILTER="int_loglevel > 30 || int_loglevel < 30"
-	local ALL_EVENTS="."
-
-	diag "Test Python a filter with a loglevel"
-
-	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
-	# Enable an event with a filter and the loglevel-only option.
-	enable_python_filter_loglevel_only $SESSION_NAME $BOGUS_EVENT_NAME "$FILTER" "INFO"
-	disable_python_lttng_event $SESSION_NAME $BOGUS_EVENT_NAME
-	enable_python_filter_loglevel_only $SESSION_NAME $BOGUS_EVENT_NAME "$FILTER" "INFO"
-	start_lttng_tracing_ok $SESSION_NAME
-
-	# Run 5 times with a 1 second delay and fire second TP.
-	run_app $1 0 1
-
-	stop_lttng_tracing_ok $SESSION_NAME
-	destroy_lttng_session_ok $SESSION_NAME
-
-	# Validate test. Expecting no events.
-	trace_match_only $ALL_EVENTS 0 $TRACE_PATH/$SESSION_NAME
-	if [ $? -ne 0 ]; then
-		return $?
-	fi
-}
-
-plan_tests $NUM_TESTS
-
-print_test_banner "$TEST_DESC"
-
-if [ ! -f "$TESTAPP_BIN" ]; then
-	withapp=0
-else
-	withapp=1
-fi
-
-skip $withapp "Python support is needed. Skipping all tests." $NUM_TESTS ||
-{
-	start_lttng_sessiond
-
-	tests=(
-		test_python_multi_session_disable_wildcard
-		test_python_multi_session_disable
-		test_python_disable
-		test_python_disable_enable
-		test_python_disable_all
-		test_python_filtering
-		test_python_multi_session_loglevel
-		test_python_destroy_session
-		test_python_loglevel
-		test_python_loglevel_multiple
-		test_python_before_start
-		test_python_after_start
-		test_python_multi_session
-		test_python_filter_loglevel
-	)
-
-	for python_version in 2 3;
-	do
-		for fct_test in ${tests[@]};
-		do
-			TRACE_PATH=$(mktemp -d)
-
-			diag "(Python $python_version)"
-			${fct_test} python$python_version
-			if [ $? -ne 0 ]; then
-				break;
-			fi
-			rm -rf $TRACE_PATH
-		done
-	done
-
-	stop_lttng_sessiond
-}
diff --git a/tests/regression/ust/python-logging/test_python_logging.in b/tests/regression/ust/python-logging/test_python_logging.in
new file mode 100755
index 0000000..8aff408
--- /dev/null
+++ b/tests/regression/ust/python-logging/test_python_logging.in
@@ -0,0 +1,610 @@
+#!/bin/bash
+#
+# Copyright (C) - 2015 Philippe Proulx <pproulx@efficios.com>
+# Copyright (C) - 2014 David Goulet <dgoulet@efficios.com>
+#
+# This program is free software; you can redistribute it and/or modify it under
+# the terms of the GNU General Public License, version 2 only, as published by
+# the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+# details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program; if not, write to the Free Software Foundation, Inc., 51
+# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+TEST_DESC="Python support"
+
+CURDIR=$(dirname $0)/
+TESTDIR=$CURDIR/../../..
+NR_ITER=5
+NR_SEC_WAIT=0
+TESTAPP_NAME="test"
+TESTAPP_BIN="$TESTAPP_NAME.py"
+TESTAPP_PATH="$CURDIR"
+SESSION_NAME="python-test"
+EVENT_NAME="python-ev-test1"
+EVENT_NAME2="python-ev-test2"
+OUTPUT_DEST="/dev/null"
+
+python_versions=(@PYTHON2_AGENT@ @PYTHON3_AGENT@)
+run_test=@RUN_PYTHON_AGENT_TEST@
+
+if [[ -z "$run_test" ]]; then
+	NUM_TESTS=1
+else
+	NUM_TESTS=$(((154 * ${#python_versions[@]})+2))
+fi
+
+source $TESTDIR/utils/utils.sh
+
+function run_app
+{
+	local python=$1
+	local debug_tp=$2
+	local fire_second_tp=$3
+
+	$python $TESTAPP_PATH/$TESTAPP_BIN $NR_ITER $NR_SEC_WAIT $debug_tp $fire_second_tp
+}
+
+function run_app_background
+{
+	run_app $@ &
+}
+
+function enable_python_loglevel_only()
+{
+	sess_name=$1
+	event_name="$2"
+	loglevel=$3
+	channel_name=$4
+
+	if [ -z $channel_name ]; then
+		# default channel if none specified
+		chan=""
+	else
+		chan="-c $channel_name"
+	fi
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel-only $loglevel "$event_name" $chan -s $sess_name -p >$OUTPUT_DEST
+	ok $? "Enable Python event $event_name for session $sess_name with loglevel-only $loglevel"
+}
+
+function enable_python_filter()
+{
+	local sess_name="$1"
+	local event_name="$2"
+	local filter="$3"
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -s $sess_name -p --filter "$filter" >$OUTPUT_DEST
+	ok $? "Enable event $event_name with filter $filter for session $sess_name"
+}
+
+function enable_python_filter_loglevel_only()
+{
+	local sess_name="$1"
+	local event_name="$2"
+	local filter="$3"
+	local loglevel="$4"
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel-only $loglevel "$event_name" -s $sess_name -p --filter "$filter" >$OUTPUT_DEST
+	ok $? "Enable event $event_name with filter \"$filter\" and loglevel-only $loglevel for session $sess_name"
+}
+
+# MUST set TESTDIR before calling those functions
+
+function test_python_before_start ()
+{
+	diag "Test Python application BEFORE tracing starts"
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
+	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
+
+	# Run 5 times with a 1 second delay
+	run_app_background $1
+
+	start_lttng_tracing_ok $SESSION_NAME
+
+	# Wait for the applications started in background
+	wait
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting all events.
+	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+}
+
+function test_python_after_start ()
+{
+	diag "Test Python application AFTER tracing starts"
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
+	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
+	start_lttng_tracing_ok $SESSION_NAME
+
+	# Run 5 times with a 1 second delay
+	run_app $1
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting all events.
+	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+}
+
+function test_python_loglevel ()
+{
+	diag "Test Python application with loglevel"
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
+	enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME "INFO"
+	start_lttng_tracing_ok $SESSION_NAME
+
+	# Run 5 times with a 1 second delay
+	run_app $1
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting all events.
+	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+
+	diag "Test Python applications with lower loglevel"
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
+	enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME "CRITICAL"
+	start_lttng_tracing_ok $SESSION_NAME
+
+	# Run 5 times with a 1 second delay
+	run_app $1
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting 0 events.
+	trace_match_only $EVENT_NAME 0 $TRACE_PATH
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+
+	diag "Test Python applications with higher loglevel"
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
+	enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME "DEBUG"
+	start_lttng_tracing_ok $SESSION_NAME
+
+	# Run 5 times with a 1 second delay
+	run_app $1
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting all events.
+	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
+	return $?
+}
+
+function test_python_loglevel_multiple ()
+{
+	diag "Test Python application with multiple loglevel"
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
+	enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME "INFO"
+	enable_python_lttng_event_loglevel $SESSION_NAME $EVENT_NAME "DEBUG"
+	start_lttng_tracing_ok $SESSION_NAME
+
+	# Run 5 times with a 1 second delay and fire two TP.
+	run_app $1 1
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting all events times two.
+	trace_match_only $EVENT_NAME $(($NR_ITER * 2)) $TRACE_PATH
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
+	enable_python_lttng_event_loglevel $SESSION_NAME '*' "INFO"
+	enable_python_lttng_event_loglevel $SESSION_NAME '*' "DEBUG"
+	start_lttng_tracing_ok $SESSION_NAME
+
+	# Run 5 times with a 1 second delay and fire two TP.
+	run_app $1 1
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting all events times two.
+	trace_match_only $EVENT_NAME $(($NR_ITER * 2)) $TRACE_PATH
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+}
+
+function test_python_multi_session_loglevel()
+{
+	diag "Test Python with multiple session"
+
+	create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME-1
+	enable_python_loglevel_only $SESSION_NAME-1 '*' "INFO"
+	start_lttng_tracing_ok $SESSION_NAME-1
+
+	create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME-2
+	enable_python_loglevel_only $SESSION_NAME-2 '*' "DEBUG"
+	start_lttng_tracing_ok $SESSION_NAME-2
+
+	# Run 5 times with a 1 second delay and fire second TP.
+	run_app $1 1 1
+
+	stop_lttng_tracing_ok $SESSION_NAME-1
+	stop_lttng_tracing_ok $SESSION_NAME-2
+	destroy_lttng_session_ok $SESSION_NAME-1
+	destroy_lttng_session_ok $SESSION_NAME-2
+
+	# Expecting NR_ITER events being the main event and the second tp one.
+	trace_matches $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-1
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+	trace_matches $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-1
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+
+	# Expectin NR_ITER events being the debug TP.
+	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-2
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+}
+
+function test_python_multi_session_disable()
+{
+	diag "Test Python with multiple session with disabled event"
+
+	create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME-1
+	enable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME
+	enable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME2
+	disable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME
+	start_lttng_tracing_ok $SESSION_NAME-1
+
+	create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME-2
+	enable_python_lttng_event $SESSION_NAME-2 $EVENT_NAME2
+	start_lttng_tracing_ok $SESSION_NAME-2
+
+	# Run 5 times with a 1 second delay and fire second TP.
+	run_app $1 0 1
+
+	stop_lttng_tracing_ok $SESSION_NAME-1
+	stop_lttng_tracing_ok $SESSION_NAME-2
+	destroy_lttng_session_ok $SESSION_NAME-1
+	destroy_lttng_session_ok $SESSION_NAME-2
+
+	# Validate test. Expecting one event of the second TP.
+	trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-1
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+
+	# Validate test. Expecting one event of the second TP.
+	trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-2
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+}
+
+function test_python_multi_session_disable_wildcard()
+{
+	diag "Test Python with multiple session with disabled wildcard event"
+
+	create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME-1
+	enable_python_lttng_event $SESSION_NAME-1 '*'
+
+	create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME-2
+	enable_python_lttng_event $SESSION_NAME-2 '*'
+
+	disable_python_lttng_event $SESSION_NAME-1 '*'
+
+	start_lttng_tracing_ok $SESSION_NAME-1
+	start_lttng_tracing_ok $SESSION_NAME-2
+
+	run_app $1
+
+	stop_lttng_tracing_ok $SESSION_NAME-1
+	stop_lttng_tracing_ok $SESSION_NAME-2
+	destroy_lttng_session_ok $SESSION_NAME-1
+	destroy_lttng_session_ok $SESSION_NAME-2
+
+	# Validate test. Expecting NO event of the first TP.
+	trace_match_only $EVENT_NAME 0 $TRACE_PATH/$SESSION_NAME-1
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+
+	# Validate test. Expecting all events of the first TP.
+	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-2
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+}
+
+function test_python_disable_all()
+{
+	diag "Test Python with multiple session with disabled all event"
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
+	enable_python_lttng_event $SESSION_NAME '*'
+	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
+	enable_python_lttng_event $SESSION_NAME $EVENT_NAME2
+
+	disable_python_lttng_event $SESSION_NAME '*'
+
+	start_lttng_tracing_ok $SESSION_NAME
+
+	run_app $1 0 1
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting NO event of the first TP and second TP.
+	trace_match_only $EVENT_NAME 0 $TRACE_PATH/$SESSION_NAME
+	trace_match_only $EVENT_NAME2 0 $TRACE_PATH/$SESSION_NAME
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+}
+
+function test_python_multi_session()
+{
+	diag "Test Python with multiple session"
+
+	create_lttng_session_ok $SESSION_NAME-1 $TRACE_PATH/$SESSION_NAME-1
+	enable_python_lttng_event $SESSION_NAME-1 $EVENT_NAME
+	start_lttng_tracing_ok $SESSION_NAME-1
+
+	create_lttng_session_ok $SESSION_NAME-2 $TRACE_PATH/$SESSION_NAME-2
+	enable_python_lttng_event $SESSION_NAME-2 $EVENT_NAME2
+	start_lttng_tracing_ok $SESSION_NAME-2
+
+	# Run 5 times with a 1 second delay and fire second TP.
+	run_app $1 0 1
+
+	stop_lttng_tracing_ok $SESSION_NAME-1
+	stop_lttng_tracing_ok $SESSION_NAME-2
+	destroy_lttng_session_ok $SESSION_NAME-1
+	destroy_lttng_session_ok $SESSION_NAME-2
+
+	# Validate test. Expecting all events of first TP
+	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME-1
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+
+	# Validate test. Expecting one event of the second TP.
+	trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME-2
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+}
+
+function test_python_destroy_session()
+{
+	diag "Test Python two session with destroy"
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/first-sess
+	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
+	start_lttng_tracing_ok $SESSION_NAME
+
+	# Run 5 times with a 1 second delay
+	run_app_background $1 0 1
+
+	# Wait for the applications started in background
+	wait
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting at least one event num 1
+	validate_trace $EVENT_NAME $TRACE_PATH/first-sess
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/second-sess
+	enable_python_lttng_event $SESSION_NAME $EVENT_NAME2
+	start_lttng_tracing_ok $SESSION_NAME
+
+	# Run 5 times with a 1 second delay
+	run_app_background $1 0 1
+
+	# Wait for the applications started in background
+	wait
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting only one event num 2
+	trace_match_only $EVENT_NAME2 1 $TRACE_PATH/second-sess
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+}
+
+function test_python_filtering()
+{
+	diag "Test Python filtering"
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
+	# Enable all event with a filter.
+	enable_python_filter $SESSION_NAME '*' 'msg == "python-ev-test2 fired [INFO]"'
+	start_lttng_tracing_ok $SESSION_NAME
+
+	# Run 5 times with a 1 second delay and fire second TP.
+	run_app $1 0 1
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting one event of the second TP only.
+	trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
+	# Enable first Logger but filter msg payload for the INFO one while
+	# triggering the debug and second TP.
+	enable_python_filter $SESSION_NAME $EVENT_NAME 'msg == "python-ev-test1 fired [INFO]"'
+	start_lttng_tracing_ok $SESSION_NAME
+
+	# Run 5 times with a 1 second delay, fire debug and second TP.
+	run_app $1 1 1
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting NR_ITER event of the main INFO tp.
+	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+}
+
+function test_python_disable()
+{
+	diag "Test Python disable event"
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
+	# Enable all event with a filter.
+	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
+	enable_python_lttng_event $SESSION_NAME $EVENT_NAME2
+	disable_python_lttng_event $SESSION_NAME $EVENT_NAME
+	start_lttng_tracing_ok $SESSION_NAME
+
+	# Run 5 times with a 1 second delay and fire second TP.
+	run_app $1 0 1
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting one event of the second TP only.
+	trace_match_only $EVENT_NAME2 1 $TRACE_PATH/$SESSION_NAME
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+}
+
+function test_python_disable_enable()
+{
+	diag "Test Python disable event followed by an enable"
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
+	# Enable all event with a filter.
+	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
+	disable_python_lttng_event $SESSION_NAME $EVENT_NAME
+	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
+	start_lttng_tracing_ok $SESSION_NAME
+
+	# Run 5 times with a 1 second delay and fire second TP.
+	run_app $1 0 1
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting NR_ITER event of the main INFO tp.
+	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH/$SESSION_NAME
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+}
+
+function test_python_filter_loglevel()
+{
+	local BOGUS_EVENT_NAME="not_a_real_event"
+	local FILTER="int_loglevel > 30 || int_loglevel < 30"
+	local ALL_EVENTS="."
+
+	diag "Test Python a filter with a loglevel"
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH/$SESSION_NAME
+	# Enable an event with a filter and the loglevel-only option.
+	enable_python_filter_loglevel_only $SESSION_NAME $BOGUS_EVENT_NAME "$FILTER" "INFO"
+	disable_python_lttng_event $SESSION_NAME $BOGUS_EVENT_NAME
+	enable_python_filter_loglevel_only $SESSION_NAME $BOGUS_EVENT_NAME "$FILTER" "INFO"
+	start_lttng_tracing_ok $SESSION_NAME
+
+	# Run 5 times with a 1 second delay and fire second TP.
+	run_app $1 0 1
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Validate test. Expecting no events.
+	trace_match_only $ALL_EVENTS 0 $TRACE_PATH/$SESSION_NAME
+	if [ $? -ne 0 ]; then
+		return $?
+	fi
+}
+
+plan_tests $NUM_TESTS
+
+print_test_banner "$TEST_DESC"
+
+if [[ ${#python_versions[@]} -eq 0 ||  "x$run_test" != "xyes" ]]; then
+	skip_agent=0
+else
+	skip_agent=1
+fi
+
+skip $skip_agent "Python agent test skipped." $NUM_TESTS ||
+{
+	start_lttng_sessiond
+
+	tests=(
+		test_python_multi_session_disable_wildcard
+		test_python_multi_session_disable
+		test_python_disable
+		test_python_disable_enable
+		test_python_disable_all
+		test_python_filtering
+		test_python_multi_session_loglevel
+		test_python_destroy_session
+		test_python_loglevel
+		test_python_loglevel_multiple
+		test_python_before_start
+		test_python_after_start
+		test_python_multi_session
+		test_python_filter_loglevel
+	)
+
+
+	for python_version in ${python_versions[*]};
+	do
+		for fct_test in ${tests[@]};
+		do
+			TRACE_PATH=$(mktemp -d)
+
+			diag "(Python $python_version)"
+			${fct_test} $python_version
+			if [ $? -ne 0 ]; then
+				break;
+			fi
+			rm -rf $TRACE_PATH
+		done
+	done
+	stop_lttng_sessiond
+}
-- 
2.1.4
