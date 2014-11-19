From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 4/8] Fix: tests: add missing wait,
	document missing synchro
Date: Wed, 19 Nov 2014 22:40:28 +0100
Message-ID: <1416433232-20080-5-git-send-email-mathieu.desnoyers__29265.0676252835$1416433477$gmane$org@efficios.com>
References: <1416433232-20080-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XrCzh-0002Ng-Q6
 for lttng-dev@lists.lttng.org; Wed, 19 Nov 2014 16:40:59 -0500
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

Move all wait ${!} that target a single process to "wait", to minimize
the chances to forget some background process in the future.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../regression/tools/snapshots/test_ust_streaming  |  1 +
 tests/regression/tools/snapshots/ust_test          |  1 +
 tests/regression/tools/streaming/test_ust          |  9 ++-
 .../regression/ust/before-after/test_before_after  |  7 ++-
 tests/regression/ust/buffers-pid/test_buffers_pid  | 17 ++++--
 .../ust/high-throughput/test_high_throughput       |  2 +-
 tests/regression/ust/java-jul/test_java_jul        |  2 +
 tests/regression/ust/java-log4j/test_java_log4j    |  2 +
 .../ust/multi-session/test_multi_session           |  2 +-
 tests/regression/ust/nprocesses/test_nprocesses    |  5 ++
 .../test_periodical_metadata_flush                 | 68 +++++++++++++++++-----
 11 files changed, 93 insertions(+), 23 deletions(-)

diff --git a/tests/regression/tools/snapshots/test_ust_streaming b/tests/regression/tools/snapshots/test_ust_streaming
index 52330a5..ad0c56b 100755
--- a/tests/regression/tools/snapshots/test_ust_streaming
+++ b/tests/regression/tools/snapshots/test_ust_streaming
@@ -82,6 +82,7 @@ function stop_test_apps()
 		kill ${p}
 		wait ${p} 2>&1
 	done
+	APPS_PID=
 }
 
 # Test a snapshot using a default name for the output destination.
diff --git a/tests/regression/tools/snapshots/ust_test b/tests/regression/tools/snapshots/ust_test
index 4ef9f58..69feb94 100755
--- a/tests/regression/tools/snapshots/ust_test
+++ b/tests/regression/tools/snapshots/ust_test
@@ -73,6 +73,7 @@ function stop_test_apps()
 		kill ${p}
 		wait ${p} 2>&1
 	done
+	APPS_PID=
 }
 
 function snapshot_add_output ()
diff --git a/tests/regression/tools/streaming/test_ust b/tests/regression/tools/streaming/test_ust
index 4c7ac97..4807175 100755
--- a/tests/regression/tools/streaming/test_ust
+++ b/tests/regression/tools/streaming/test_ust
@@ -56,9 +56,11 @@ function test_ust_before_start ()
 	# Run 5 times with a 1 second delay
 	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1 &
 
+	#FIXME: racy missing synchro
+
 	start_lttng_tracing $SESSION_NAME
 	# Wait for the applications started in background
-	wait ${!}
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
@@ -74,8 +76,13 @@ function test_ust_after_start ()
 	# Run 5 times with a 1 second delay
 	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1
 
+	#FIXME: racy missing synchro
+
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
+
+	# Wait for the applications started in background
+	wait
 }
 
 plan_tests $NUM_TESTS
diff --git a/tests/regression/ust/before-after/test_before_after b/tests/regression/ust/before-after/test_before_after
index 112f41a..1535f36 100755
--- a/tests/regression/ust/before-after/test_before_after
+++ b/tests/regression/ust/before-after/test_before_after
@@ -42,7 +42,8 @@ function test_before_apps()
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
 	start_lttng_tracing $SESSION_NAME
 
-	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT &
+	wait
 	ok $? "Traced application stopped."
 
 	stop_lttng_tracing $SESSION_NAME
@@ -63,9 +64,11 @@ function test_after_apps()
 	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT &
 	ok $? "Application started in background."
 
+	#FIXME: racy missing synchronization
+
 	start_lttng_tracing $SESSION_NAME
 
-	wait ${!}
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
diff --git a/tests/regression/ust/buffers-pid/test_buffers_pid b/tests/regression/ust/buffers-pid/test_buffers_pid
index 974fb71..0258e89 100755
--- a/tests/regression/ust/buffers-pid/test_buffers_pid
+++ b/tests/regression/ust/buffers-pid/test_buffers_pid
@@ -58,9 +58,10 @@ test_after_multiple_apps() {
 	start_lttng_tracing $SESSION_NAME
 
 	for i in `seq 1 5`; do
-		$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1
+		$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1 &
 		ok $? "Start application $i for tracing"
 	done
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
@@ -77,10 +78,12 @@ test_before_multiple_apps() {
 	diag "Start multiple applications BEFORE tracing is started"
 
 	for i in `seq 1 5`; do
-		$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT & >/dev/null 2>&1
+		$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1 &
 		ok $? "Start application $i for tracing"
 	done
 
+	#FIXME: racy missing synchronization
+
 	# BEFORE application is spawned
 	create_lttng_session $SESSION_NAME $TRACE_PATH
 	enable_channel_per_pid $SESSION_NAME "channel0"
@@ -119,8 +122,9 @@ test_after_app() {
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME "channel0"
 	start_lttng_tracing $SESSION_NAME
 
-	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT &
 	ok $? "Start application to trace"
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
@@ -144,9 +148,11 @@ test_before_app() {
 	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT &
 	ok $? "Start application to trace"
 
+	#FIXME: racy missing synchronization
+
 	start_lttng_tracing $SESSION_NAME
 
-	wait ${!}
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
@@ -190,8 +196,9 @@ test_multiple_channels() {
 	ok $? "Enable event $EVENT_NAME for session $SESSION_NAME in channel4"
 	start_lttng_tracing $SESSION_NAME
 
-	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT &
 	ok $? "Start application to trace"
+	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	trace_match_only $EVENT_NAME $[NR_ITER * 5] $TRACE_PATH
diff --git a/tests/regression/ust/high-throughput/test_high_throughput b/tests/regression/ust/high-throughput/test_high_throughput
index 101a2c0..1ee0ec1 100755
--- a/tests/regression/ust/high-throughput/test_high_throughput
+++ b/tests/regression/ust/high-throughput/test_high_throughput
@@ -46,7 +46,7 @@ enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
 start_lttng_tracing $SESSION_NAME
 
 for i in `seq 1 $NR_APP`; do
-	./$CURDIR/$BIN_NAME & >/dev/null 2>&1
+	./$CURDIR/$BIN_NAME >/dev/null 2>&1 &
 done
 
 diag "Waiting for applications to end"
diff --git a/tests/regression/ust/java-jul/test_java_jul b/tests/regression/ust/java-jul/test_java_jul
index 359fe05..d16880f 100755
--- a/tests/regression/ust/java-jul/test_java_jul
+++ b/tests/regression/ust/java-jul/test_java_jul
@@ -96,6 +96,8 @@ function test_jul_before_start ()
 	# Run 5 times with a 1 second delay
 	run_app_background
 
+	#FIXME: racy missing synchronization
+
 	start_lttng_tracing $SESSION_NAME
 
 	# Wait for the applications started in background
diff --git a/tests/regression/ust/java-log4j/test_java_log4j b/tests/regression/ust/java-log4j/test_java_log4j
index 173d508..11845a0 100755
--- a/tests/regression/ust/java-log4j/test_java_log4j
+++ b/tests/regression/ust/java-log4j/test_java_log4j
@@ -97,6 +97,8 @@ function test_log4j_before_start ()
 	# Run 5 times with a 1 second delay
 	run_app_background
 
+	#FIXME: racy missing synchronization
+
 	start_lttng_tracing $SESSION_NAME
 
 	# Wait for the applications started in background
diff --git a/tests/regression/ust/multi-session/test_multi_session b/tests/regression/ust/multi-session/test_multi_session
index 19f8d42..e1ff9b0 100755
--- a/tests/regression/ust/multi-session/test_multi_session
+++ b/tests/regression/ust/multi-session/test_multi_session
@@ -44,7 +44,7 @@ test_multi_session() {
 	./$CURDIR/gen-nevents $NR_ITER &
 	ok $? "Start application to generate $NR_ITER events"
 
-	wait ${!}
+	wait
 	pass "Wait for events to record"
 
 	for i in `seq 0 3`; do
diff --git a/tests/regression/ust/nprocesses/test_nprocesses b/tests/regression/ust/nprocesses/test_nprocesses
index 396dab0..ca0f9d4 100755
--- a/tests/regression/ust/nprocesses/test_nprocesses
+++ b/tests/regression/ust/nprocesses/test_nprocesses
@@ -53,6 +53,8 @@ do
 	APPS_PID="${APPS_PID} ${!}"
 done
 
+#FIXME: racy missing synchronization
+
 diag "Waiting for applications to be registered to sessiond"
 
 reg_app_count=0
@@ -76,6 +78,8 @@ start_lttng_tracing $SESSION_NAME
 stop_lttng_tracing $SESSION_NAME
 destroy_lttng_session $SESSION_NAME
 
+#FIXME/TODO: add validation after fixing racy synchroniaation
+
 rm -rf $TRACE_PATH
 
 diag "Stopping all spawned applications"
@@ -83,6 +87,7 @@ for p in ${APPS_PID}; do
 	kill ${p}
 	wait ${p} 2>/dev/null
 done
+APPS_PID=
 pass "Stopped all spawned applications"
 
 stop_lttng_sessiond
diff --git a/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush b/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
index e419965..53db813 100755
--- a/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
+++ b/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
@@ -28,6 +28,7 @@ EVENT_NAME="tp:tptest"
 BIN_NAME="gen-nevents"
 NUM_TESTS=38
 APP_TMP_FILE="/tmp/lttng_test_ust.42.file"
+APPS_PID=
 
 source $TESTDIR/utils/utils.sh
 
@@ -106,7 +107,9 @@ function start_trace_app()
 {
 	# Start application with a temporary file.
 	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT $APP_TMP_FILE &
-	ok $? "Start application to trace"
+	ret=$?
+	APPS_PID="${APPS_PID} ${!}"
+	ok $ret "Start application to trace"
 }
 
 function start_check_trace_app()
@@ -115,9 +118,20 @@ function start_check_trace_app()
 	check_app_tmp_file
 }
 
+
+function wait_trace_apps()
+{
+	for p in ${APPS_PID}; do
+		wait ${p} 2>/dev/null
+	done
+	APPS_PID=
+}
+
 test_after_app_pid() {
 	local out
 
+	APPS_PID=
+
 	diag "Start application AFTER tracing is started"
 
 	create_lttng_session $SESSION_NAME $TRACE_PATH
@@ -133,7 +147,9 @@ test_after_app_pid() {
 	# Make sure the application does not generate any more data,
 	# thus ensuring that we are not flushing a packet concurrently
 	# with validate_trace.
-	killall -SIGSTOP -q $TESTAPP_NAME
+	for p in ${APPS_PID}; do
+		kill -s SIGSTOP ${p}
+	done
 
 	# Give time to the consumer to write inflight data.
 	sleep 2
@@ -141,11 +157,14 @@ test_after_app_pid() {
 	validate_trace
 	out=$?
 
-	killall -SIGKILL -q $TESTAPP_NAME
+	for p in ${APPS_PID}; do
+		kill -s SIGKILL ${p}
+		wait ${p} 2>/dev/null
+	done
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
-	wait
+	wait_trace_apps
 
 	return $out
 }
@@ -154,6 +173,8 @@ test_before_app_pid() {
 	local out
 	local tmp_file="/tmp/lttng_test_ust.42.file"
 
+	APPS_PID=
+
 	diag "Start application BEFORE tracing is started"
 
 	start_trace_app
@@ -172,7 +193,9 @@ test_before_app_pid() {
 	# Make sure the application does not generate any more data,
 	# thus ensuring that we are not flushing a packet concurrently
 	# with validate_trace.
-	killall -SIGSTOP -q $TESTAPP_NAME
+	for p in ${APPS_PID}; do
+		kill -s SIGSTOP ${p}
+	done
 
 	# Give time to the consumer to write inflight data.
 	sleep 2
@@ -180,11 +203,15 @@ test_before_app_pid() {
 	validate_trace
 	out=$?
 
-	killall -SIGKILL -q $TESTAPP_NAME
+	for p in ${APPS_PID}; do
+		kill -s SIGKILL ${p}
+		wait ${p} 2>/dev/null
+	done
+
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
-	wait
+	wait_trace_apps
 
 	return $out
 }
@@ -192,6 +219,8 @@ test_before_app_pid() {
 test_after_app_uid() {
 	local out
 
+	APPS_PID=
+
 	diag "Start application AFTER tracing is started"
 
 	create_lttng_session $SESSION_NAME $TRACE_PATH
@@ -207,7 +236,10 @@ test_after_app_uid() {
 	# Make sure the application does not generate any more data,
 	# thus ensuring that we are not flushing a packet concurrently
 	# with validate_trace.
-	killall -SIGSTOP -q $TESTAPP_NAME
+	for p in ${APPS_PID}; do
+		kill -s SIGSTOP ${p}
+	done
+
 
 	# Give time to the consumer to write inflight data.
 	sleep 2
@@ -215,11 +247,14 @@ test_after_app_uid() {
 	validate_trace
 	out=$?
 
-	killall -SIGKILL -q $TESTAPP_NAME
+	for p in ${APPS_PID}; do
+		kill -s SIGKILL ${p}
+		wait ${p} 2>/dev/null
+	done
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
-	wait
+	wait_trace_apps
 
 	return $out
 }
@@ -227,6 +262,8 @@ test_after_app_uid() {
 test_before_app_uid() {
 	local out
 
+	APPS_PID=
+
 	diag "Start application BEFORE tracing is started"
 
 	# Start application before tracing
@@ -245,7 +282,9 @@ test_before_app_uid() {
 	# Make sure the application does not generate any more data,
 	# thus ensuring that we are not flushing a packet concurrently
 	# with validate_trace.
-	killall -SIGSTOP -q $TESTAPP_NAME
+	for p in ${APPS_PID}; do
+		kill -s SIGSTOP ${p}
+	done
 
 	# Give time to the consumer to write inflight data.
 	sleep 2
@@ -253,11 +292,14 @@ test_before_app_uid() {
 	validate_trace
 	out=$?
 
-	killall -SIGKILL -q $TESTAPP_NAME
+	for p in ${APPS_PID}; do
+		kill -s SIGKILL ${p}
+		wait ${p} 2>/dev/null
+	done
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
-	wait
+	wait_trace_apps
 
 	return $out
 }
-- 
2.1.1
