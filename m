From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/8] Fix: test flaky sleep and wait
	patterns
Date: Wed, 19 Nov 2014 22:40:26 +0100
Message-ID: <1416433232-20080-3-git-send-email-mathieu.desnoyers__48260.8312079266$1416433396$gmane$org@efficios.com>
References: <1416433232-20080-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XrCzd-0002NJ-Aw
 for lttng-dev@lists.lttng.org; Wed, 19 Nov 2014 16:40:56 -0500
In-Reply-To: <1416433232-20080-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tests/regression/tools/live/test_kernel            |  8 ++---
 tests/regression/tools/live/test_ust               |  8 ++---
 .../regression/tools/live/test_ust_tracefile_count |  8 ++---
 .../regression/tools/snapshots/test_ust_streaming  | 39 ++++++++++++----------
 tests/regression/tools/snapshots/ust_test          | 27 ++++++++-------
 tests/regression/tools/streaming/test_kernel       |  7 ----
 tests/regression/ust/java-jul/test_java_jul        | 10 ++++--
 tests/regression/ust/java-log4j/test_java_log4j    | 10 +++---
 tests/regression/ust/nprocesses/test_nprocesses    | 23 ++++++++-----
 .../ust/python-logging/test_python_logging         | 10 ++++--
 tests/stress/test_multi_sessions_per_uid_10app     |  4 +--
 .../test_multi_sessions_per_uid_5app_streaming     |  4 +--
 ...lti_sessions_per_uid_5app_streaming_kill_relayd |  8 ++---
 .../utils/testapp/gen-ust-events/gen-ust-events.c  | 14 +++++---
 tests/utils/utils.sh                               |  2 +-
 15 files changed, 95 insertions(+), 87 deletions(-)

diff --git a/tests/regression/tools/live/test_kernel b/tests/regression/tools/live/test_kernel
index ac4c19f..bf5e79c 100755
--- a/tests/regression/tools/live/test_kernel
+++ b/tests/regression/tools/live/test_kernel
@@ -63,18 +63,16 @@ else
 fi
 
 if [ -z $(pidof lt-$SESSIOND_BIN) ]; then
-	$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --daemonize --quiet --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
+	$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background --quiet --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
 	if [ $? -eq 1 ]; then
 		echo "Fail to start lttng-sessiond"
 		exit 1
 	fi
-	# Wait for sessiond to bootstrap
-	sleep 2
 fi
 
-opt="-o $TRACE_PATH"
+opt="--background -o $TRACE_PATH"
 if [ -z $(pidof lt-$RELAYD_BIN) ]; then
-	$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt >/dev/null 2>&1 &
+	$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
 		echo "Fail to start lttng-relayd (opt: $opt)"
 		return 1
diff --git a/tests/regression/tools/live/test_ust b/tests/regression/tools/live/test_ust
index 2eac48c..4026bba 100755
--- a/tests/regression/tools/live/test_ust
+++ b/tests/regression/tools/live/test_ust
@@ -60,18 +60,16 @@ function clean_live_tracing()
 }
 
 if [ -z $(pidof lt-$SESSIOND_BIN) ]; then
-	$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --daemonize --quiet --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
+	$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background --quiet --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
 	if [ $? -eq 1 ]; then
 		echo "Fail to start lttng-sessiond"
 		exit 1
 	fi
-	# Wait for sessiond to bootstrap
-	sleep 2
 fi
 
-opt="-o $TRACE_PATH"
+opt="-o $TRACE_PATH --background"
 if [ -z $(pidof lt-$RELAYD_BIN) ]; then
-	$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt >/dev/null 2>&1 &
+	$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
 		echo "Fail to start lttng-relayd (opt: $opt)"
 		return 1
diff --git a/tests/regression/tools/live/test_ust_tracefile_count b/tests/regression/tools/live/test_ust_tracefile_count
index f90cbd1..3ef2ee1 100755
--- a/tests/regression/tools/live/test_ust_tracefile_count
+++ b/tests/regression/tools/live/test_ust_tracefile_count
@@ -61,18 +61,16 @@ function clean_live_tracing()
 }
 
 if [ -z $(pidof lt-$SESSIOND_BIN) ]; then
-	$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --daemonize --quiet --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
+	$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background --quiet --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
 	if [ $? -eq 1 ]; then
 		echo "Fail to start lttng-sessiond"
 		exit 1
 	fi
-	# Wait for sessiond to bootstrap
-	sleep 2
 fi
 
-opt="-o $TRACE_PATH"
+opt="-o $TRACE_PATH --background"
 if [ -z $(pidof lt-$RELAYD_BIN) ]; then
-	$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt >/dev/null 2>&1 &
+	$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
 		echo "Fail to start lttng-relayd (opt: $opt)"
 		return 1
diff --git a/tests/regression/tools/snapshots/test_ust_streaming b/tests/regression/tools/snapshots/test_ust_streaming
index c0d98c2..52330a5 100755
--- a/tests/regression/tools/snapshots/test_ust_streaming
+++ b/tests/regression/tools/snapshots/test_ust_streaming
@@ -28,6 +28,7 @@ TESTAPP_NAME="gen-ust-events"
 TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
 NR_ITER=2000000
 NR_USEC_WAIT=100
+APPS_PID=
 
 TRACE_PATH=$(mktemp -d)
 
@@ -55,13 +56,15 @@ function snapshot_add_output ()
 }
 
 # Start trace application and return once one event has been hit.
-function start_trace_app()
+function start_test_app()
 {
 	local tmp_file="/tmp/lttng_test_ust.42.file"
 
 	# Start application with a temporary file.
 	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT $tmp_file &
-	ok $? "Start application to trace"
+	ret=$?
+	APPS_PID="${APPS_PID} ${!}"
+	ok $ret "Start application to trace"
 
 	# Wait for the application file to appear indicating that at least one
 	# tracepoint has been fired.
@@ -72,13 +75,13 @@ function start_trace_app()
 	rm -f $tmp_file
 }
 
-function stop_trace_app()
+function stop_test_apps()
 {
-	diag "Killing $TESTAPP_NAME"
-	PID_APP=`pidof $TESTAPP_NAME`
-	kill $PID_APP >/dev/null 2>&1
-	diag "Waiting on $TESTAPP_NAME"
-	wait
+	diag "Stopping $TESTAPP_NAME"
+	for p in ${APPS_PID}; do
+		kill ${p}
+		wait ${p} 2>&1
+	done
 }
 
 # Test a snapshot using a default name for the output destination.
@@ -90,7 +93,7 @@ function test_ust_default_name_with_del()
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME $CHANNEL_NAME
 	start_lttng_tracing $SESSION_NAME
 
-	start_trace_app
+	start_test_app
 
 	snapshot_add_output $SESSION_NAME "net://localhost"
 	lttng_snapshot_record $SESSION_NAME
@@ -99,7 +102,7 @@ function test_ust_default_name_with_del()
 	echo $TRACE_PATH/$HOSTNAME/snapshot-1
 	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/snapshot-1*
 	if [ $? -ne 0 ]; then
-		stop_trace_app
+		stop_test_apps
 		return $?
 	fi
 
@@ -110,14 +113,14 @@ function test_ust_default_name_with_del()
 	# Validate test with the next ID since a del output was done prior.
 	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/snapshot-2*
 	if [ $? -ne 0 ]; then
-		stop_trace_app
+		stop_test_apps
 		return $?
 	fi
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
-	stop_trace_app
+	stop_test_apps
 
 	return 0
 }
@@ -131,7 +134,7 @@ function test_ust_default_name()
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME $CHANNEL_NAME
 	start_lttng_tracing $SESSION_NAME
 
-	start_trace_app
+	start_test_app
 
 	snapshot_add_output $SESSION_NAME "net://localhost"
 	lttng_snapshot_record $SESSION_NAME
@@ -141,7 +144,7 @@ function test_ust_default_name()
 	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/snapshot-1*
 	out=$?
 
-	stop_trace_app
+	stop_test_apps
 
 	return $out
 }
@@ -154,7 +157,7 @@ function test_ust_default_name_custom_uri()
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME $CHANNEL_NAME
 	start_lttng_tracing $SESSION_NAME
 
-	start_trace_app
+	start_test_app
 
 	snapshot_add_output $SESSION_NAME "-C tcp://localhost:5342 -D tcp://localhost:5343"
 	lttng_snapshot_record $SESSION_NAME
@@ -164,7 +167,7 @@ function test_ust_default_name_custom_uri()
 	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/snapshot-1*
 	out=$?
 
-	stop_trace_app
+	stop_test_apps
 
 	return $out
 }
@@ -181,7 +184,7 @@ function test_ust_custom_name()
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME $CHANNEL_NAME
 	start_lttng_tracing $SESSION_NAME
 
-	start_trace_app
+	start_test_app
 
 	snapshot_add_output $SESSION_NAME "net://localhost" $name
 	lttng_snapshot_record $SESSION_NAME
@@ -198,7 +201,7 @@ function test_ust_custom_name()
 		out=1
 	fi
 
-	stop_trace_app
+	stop_test_apps
 
 	return $out
 }
diff --git a/tests/regression/tools/snapshots/ust_test b/tests/regression/tools/snapshots/ust_test
index a35fbf3..4ef9f58 100755
--- a/tests/regression/tools/snapshots/ust_test
+++ b/tests/regression/tools/snapshots/ust_test
@@ -27,6 +27,7 @@ TESTAPP_NAME="gen-ust-events"
 TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
 NR_ITER=2000000
 NR_USEC_WAIT=100
+APPS_PID=
 
 NUM_TESTS=76
 
@@ -52,7 +53,9 @@ function start_test_app()
 
 	# Start application with a temporary file.
 	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT $tmp_file &
-	ok $? "Start application to trace"
+	ret=$?
+	APPS_PID="${APPS_PID} ${!}"
+	ok $ret "Start application to trace"
 
 	# Wait for the application file to appear indicating that at least one
 	# tracepoint has been fired.
@@ -63,13 +66,13 @@ function start_test_app()
 	rm -f $tmp_file
 }
 
-function stop_test_app()
+function stop_test_apps()
 {
-	diag "Killing $TESTAPP_NAME"
-	PID_APP=`pidof $TESTAPP_NAME`
-	kill $PID_APP >/dev/null 2>&1
-	diag "Waiting on $TESTAPP_NAME"
-	wait
+	diag "Stopping $TESTAPP_NAME"
+	for p in ${APPS_PID}; do
+		kill ${p}
+		wait ${p} 2>&1
+	done
 }
 
 function snapshot_add_output ()
@@ -174,7 +177,7 @@ function test_ust_local_snapshot ()
 		break
 	fi
 
-	stop_test_app
+	stop_test_apps
 }
 
 function test_ust_local_snapshot_max_size ()
@@ -222,7 +225,7 @@ function test_ust_local_snapshot_max_size ()
 		rm -rf $TRACE_PATH
 	fi
 
-	stop_test_app
+	stop_test_apps
 }
 
 function test_ust_local_snapshot_large_metadata ()
@@ -288,7 +291,7 @@ function test_ust_per_uid_local_snapshot ()
 		break
 	fi
 
-	stop_test_app
+	stop_test_apps
 }
 
 function test_ust_per_uid_local_snapshot_post_mortem ()
@@ -302,7 +305,7 @@ function test_ust_per_uid_local_snapshot_post_mortem ()
 
 	# Returns once the application has at least fired ONE tracepoint.
 	start_test_app
-	stop_test_app
+	stop_test_apps
 
 	lttng_snapshot_record $SESSION_NAME
 	stop_lttng_tracing $SESSION_NAME
@@ -346,7 +349,7 @@ function test_ust_local_snapshots ()
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
-	stop_test_app
+	stop_test_apps
 }
 
 plan_tests $NUM_TESTS
diff --git a/tests/regression/tools/streaming/test_kernel b/tests/regression/tools/streaming/test_kernel
index 9877bb8..1e272c3 100755
--- a/tests/regression/tools/streaming/test_kernel
+++ b/tests/regression/tools/streaming/test_kernel
@@ -52,13 +52,6 @@ function test_kernel_before_start ()
 	sleep 1
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
-
-	# We can not predict _yet_ when the trace is available so we have to do a
-	# arbitratry sleep to validate the trace.
-	diag "Wait 3 seconds for the trace to be written on disk"
-	for i in `seq 1 3`; do
-		sleep 1
-	done
 }
 
 # Deactivated since this feature is not yet available where we can enable
diff --git a/tests/regression/ust/java-jul/test_java_jul b/tests/regression/ust/java-jul/test_java_jul
index bcde273..359fe05 100755
--- a/tests/regression/ust/java-jul/test_java_jul
+++ b/tests/regression/ust/java-jul/test_java_jul
@@ -99,7 +99,7 @@ function test_jul_before_start ()
 	start_lttng_tracing $SESSION_NAME
 
 	# Wait for the applications started in background
-	wait ${!}
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
@@ -399,7 +399,8 @@ function test_jul_destroy_session()
 	# Run 5 times with a 1 second delay
 	run_app_background 0 1
 
-	sleep 1
+	# Wait for the applications started in background
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
@@ -414,8 +415,11 @@ function test_jul_destroy_session()
 	enable_jul_lttng_event $SESSION_NAME $EVENT_NAME2
 	start_lttng_tracing $SESSION_NAME
 
+	# Run 5 times with a 1 second delay
+	run_app_background 0 1
+
 	# Wait for the applications started in background
-	wait ${!}
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
diff --git a/tests/regression/ust/java-log4j/test_java_log4j b/tests/regression/ust/java-log4j/test_java_log4j
index b4846c3..173d508 100755
--- a/tests/regression/ust/java-log4j/test_java_log4j
+++ b/tests/regression/ust/java-log4j/test_java_log4j
@@ -100,7 +100,7 @@ function test_log4j_before_start ()
 	start_lttng_tracing $SESSION_NAME
 
 	# Wait for the applications started in background
-	wait ${!}
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
@@ -399,8 +399,8 @@ function test_log4j_destroy_session()
 
 	# Run 5 times with a 1 second delay
 	run_app_background 0 1
-
-	sleep 1
+	# Wait for the applications started in background
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
@@ -415,8 +415,10 @@ function test_log4j_destroy_session()
 	enable_log4j_lttng_event $SESSION_NAME $EVENT_NAME2
 	start_lttng_tracing $SESSION_NAME
 
+	# Run 5 times with a 1 second delay
+	run_app_background 0 1
 	# Wait for the applications started in background
-	wait ${!}
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
diff --git a/tests/regression/ust/nprocesses/test_nprocesses b/tests/regression/ust/nprocesses/test_nprocesses
index 84d0ff7..396dab0 100755
--- a/tests/regression/ust/nprocesses/test_nprocesses
+++ b/tests/regression/ust/nprocesses/test_nprocesses
@@ -19,7 +19,7 @@ TEST_DESC="UST tracer - Generate $NUM_PROCESS process"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../../..
-NR_ITER=1000
+NR_ITER=-1	# infinite loop
 NR_USEC_WAIT=1000000
 TESTAPP_PATH="$TESTDIR/utils/testapp"
 TESTAPP_NAME="gen-ust-events"
@@ -28,6 +28,7 @@ SESSION_NAME="ust-nprocesses"
 EVENT_NAME="tp:tptest"
 TEST_WAIT_SEC=5
 NUM_TESTS=9
+APPS_PID=
 
 source $TESTDIR/utils/utils.sh
 
@@ -43,20 +44,24 @@ print_test_banner "$TEST_DESC"
 
 start_lttng_sessiond
 
-# Start test for 1000 seconds
+# Start tests. Each is an infinite tracing loop.
 
+diag "Starting $NUM_PROCESS test applications"
 for i in `seq 1 $NUM_PROCESS`
 do
 	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1 &
+	APPS_PID="${APPS_PID} ${!}"
 done
 
+diag "Waiting for applications to be registered to sessiond"
+
 reg_app_count=0
 while [ $reg_app_count -ne $NUM_PROCESS ]; do
 	listing=$($TESTDIR/../src/bin/lttng/$LTTNG_BIN list -u)
 	reg_app_count=$(echo -n $listing | sed "s#$TESTAPP_BIN#$TESTAPP_BIN\n#g" | grep "$TESTAPP_BIN" | wc -l)
 done
 
-pass "Trace validation"
+pass "All applications are registered to sessiond"
 
 TRACE_PATH=$(mktemp -d)
 
@@ -65,10 +70,8 @@ create_lttng_session $SESSION_NAME $TRACE_PATH
 enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
 start_lttng_tracing $SESSION_NAME
 
-diag "Sleeping $TEST_WAIT_SEC seconds for tracing to start everywhere"
-diag "Warning: this arbitrary time can make the test fail on slower system"
-
-sleep $TEST_WAIT_SEC
+# We don't validate whether the applications have traced here, rather
+# just that they registered to sessiond (above).
 
 stop_lttng_tracing $SESSION_NAME
 destroy_lttng_session $SESSION_NAME
@@ -76,8 +79,10 @@ destroy_lttng_session $SESSION_NAME
 rm -rf $TRACE_PATH
 
 diag "Stopping all spawned applications"
-killall -q $TESTAPP_NAME >/dev/null 2>&1
-wait
+for p in ${APPS_PID}; do
+	kill ${p}
+	wait ${p} 2>/dev/null
+done
 pass "Stopped all spawned applications"
 
 stop_lttng_sessiond
diff --git a/tests/regression/ust/python-logging/test_python_logging b/tests/regression/ust/python-logging/test_python_logging
index b2fa6fb..cb960da 100755
--- a/tests/regression/ust/python-logging/test_python_logging
+++ b/tests/regression/ust/python-logging/test_python_logging
@@ -99,7 +99,7 @@ function test_python_before_start ()
 	start_lttng_tracing $SESSION_NAME
 
 	# Wait for the applications started in background
-	wait ${!}
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
@@ -403,7 +403,8 @@ function test_python_destroy_session()
 	# Run 5 times with a 1 second delay
 	run_app_background 0 1
 
-	sleep 1
+	# Wait for the applications started in background
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
@@ -418,8 +419,11 @@ function test_python_destroy_session()
 	enable_python_lttng_event $SESSION_NAME $EVENT_NAME2
 	start_lttng_tracing $SESSION_NAME
 
+	# Run 5 times with a 1 second delay
+	run_app_background 0 1
+
 	# Wait for the applications started in background
-	wait ${!}
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
diff --git a/tests/stress/test_multi_sessions_per_uid_10app b/tests/stress/test_multi_sessions_per_uid_10app
index c960957..365519d 100755
--- a/tests/stress/test_multi_sessions_per_uid_10app
+++ b/tests/stress/test_multi_sessions_per_uid_10app
@@ -67,10 +67,8 @@ function start_sessiond()
 	if [ -z $(pidof lt-$SESSIOND_BIN) ]; then
 		# We have to start it like this so the ulimit -c is used by this
 		# process. Also, we collect any error message printed out.
-		$TESTDIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --quiet --consumerd32-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" >$LOG_FILE 2>&1 &
+		$TESTDIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --quiet --background --consumerd32-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" >$LOG_FILE 2>&1
 		status=$?
-		# Wait for sessiond to bootstrap
-		sleep 2
 		ok $status "Start session daemon"
 	fi
 }
diff --git a/tests/stress/test_multi_sessions_per_uid_5app_streaming b/tests/stress/test_multi_sessions_per_uid_5app_streaming
index eb68107..40c0a4d 100755
--- a/tests/stress/test_multi_sessions_per_uid_5app_streaming
+++ b/tests/stress/test_multi_sessions_per_uid_5app_streaming
@@ -89,10 +89,8 @@ function start_sessiond()
 	if [ -z $(pidof lt-$SESSIOND_BIN) ]; then
 		# We have to start it like this so the ulimit -c is used by this
 		# process. Also, we collect any error message printed out.
-		$TESTDIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --quiet --consumerd32-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" >$LOG_FILE_SESSIOND 2>&1 &
+		$TESTDIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --quiet --background --consumerd32-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" >$LOG_FILE_SESSIOND 2>&1
 		status=$?
-		# Wait for sessiond to bootstrap
-		sleep 2
 		ok $status "Start session daemon"
 	fi
 }
diff --git a/tests/stress/test_multi_sessions_per_uid_5app_streaming_kill_relayd b/tests/stress/test_multi_sessions_per_uid_5app_streaming_kill_relayd
index 4ff9276..fa41b4c 100755
--- a/tests/stress/test_multi_sessions_per_uid_5app_streaming_kill_relayd
+++ b/tests/stress/test_multi_sessions_per_uid_5app_streaming_kill_relayd
@@ -76,12 +76,10 @@ function start_sessiond()
 	if [ -z $(pidof lt-$SESSIOND_BIN) ]; then
 		# We have to start it like this so the ulimit -c is used by this
 		# process. Also, we collect any error message printed out.
-		#$TESTDIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --quiet --consumerd32-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" >$LOG_FILE_SESSIOND 2>&1 &
-		$TESTDIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --verbose-consumer -vvv --consumerd32-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" >$LOG_FILE_SESSIOND 2>&1 &
-		#$TESTDIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --consumerd32-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" >$LOG_FILE_SESSIOND 2>&1 &
+		#$TESTDIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --quiet --background --consumerd32-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" >$LOG_FILE_SESSIOND 2>&1
+		$TESTDIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --verbose-consumer -vvv --background --consumerd32-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" >$LOG_FILE_SESSIOND 2>&1
+		#$TESTDIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background --consumerd32-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$TESTDIR/../src/bin/lttng-consumerd/lttng-consumerd" >$LOG_FILE_SESSIOND 2>&1
 		status=$?
-		# Wait for sessiond to bootstrap
-		sleep 2
 		ok $status "Start session daemon"
 	fi
 }
diff --git a/tests/utils/testapp/gen-ust-events/gen-ust-events.c b/tests/utils/testapp/gen-ust-events/gen-ust-events.c
index 77d88db..42fa082 100644
--- a/tests/utils/testapp/gen-ust-events/gen-ust-events.c
+++ b/tests/utils/testapp/gen-ust-events/gen-ust-events.c
@@ -26,6 +26,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
+#include <stdbool.h>
 
 #define TRACEPOINT_DEFINE
 #include "tp.h"
@@ -47,16 +48,20 @@ void create_file(const char *path)
 
 int main(int argc, char **argv)
 {
-	int i, netint;
+	unsigned int i, netint;
 	long values[] = { 1, 2, 3 };
 	char text[10] = "test";
 	double dbl = 2.0;
 	float flt = 2222.0;
-	unsigned int nr_iter = 100;
+	int nr_iter = 100;
 	useconds_t nr_usec = 0;
 	char *tmp_file_path = NULL;
+	bool file_created = false;
 
 	if (argc >= 2) {
+		/*
+		 * If nr_iter is negative, do an infinite tracing loop.
+		 */
 		nr_iter = atoi(argv[1]);
 	}
 
@@ -69,7 +74,7 @@ int main(int argc, char **argv)
 		tmp_file_path = argv[3];
 	}
 
-	for (i = 0; i < nr_iter; i++) {
+	for (i = 0; nr_iter < 0 || i < nr_iter; i++) {
 		netint = htonl(i);
 		tracepoint(tp, tptest, i, netint, values, text, strlen(text), dbl,
 				flt);
@@ -78,8 +83,9 @@ int main(int argc, char **argv)
 		 * First loop we create the file if asked to indicate that at least one
 		 * tracepoint has been hit.
 		 */
-		if (i == 0 && tmp_file_path) {
+		if (!file_created && tmp_file_path) {
 			create_file(tmp_file_path);
+			file_created = true;
 		}
 		usleep(nr_usec);
 	}
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index fe75461..c3d8bd4 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -311,7 +311,7 @@ function start_lttng_sessiond()
 		else
 			$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
 		fi
-		#$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --verbose-consumer >>/tmp/sessiond.log 2>&1 &
+		#$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --verbose-consumer >>/tmp/sessiond.log 2>&1
 		status=$?
 		ok $status "Start session daemon"
 	fi
-- 
2.1.1
