From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/8] Fix: tests: don't use pidof to
	wait for test apps
Date: Wed, 19 Nov 2014 22:40:25 +0100
Message-ID: <1416433232-20080-2-git-send-email-mathieu.desnoyers__34175.3605906435$1416433311$gmane$org@efficios.com>
References: <1416433232-20080-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XrCzZ-0002NH-A7
 for lttng-dev@lists.lttng.org; Wed, 19 Nov 2014 16:40:51 -0500
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

Use the bash shell "wait" to wait for all background tasks rather than
the racy "pidof". Inded, it's possible that applications have been
forked, but not executed yet, when pidof is done, which would therefore
miss applications. Using "wait" from the shell solves this.

If we want to be really strict, we should have sessiond, consumerd, and
relayd export a file containing their own PID, and wait for this instead
of using pidof. But this will be for another fix.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../regression/tools/snapshots/test_ust_streaming  | 27 ++++++++++++----------
 tests/regression/tools/snapshots/ust_test          | 14 ++++++-----
 .../tools/streaming/test_high_throughput_limits    | 14 ++++-------
 tests/regression/ust/buffers-pid/test_buffers_pid  | 17 ++++----------
 .../ust/high-throughput/test_high_throughput       |  7 +++---
 tests/regression/ust/nprocesses/test_nprocesses    | 11 ++++-----
 .../test_periodical_metadata_flush                 | 24 +++++++------------
 7 files changed, 46 insertions(+), 68 deletions(-)

diff --git a/tests/regression/tools/snapshots/test_ust_streaming b/tests/regression/tools/snapshots/test_ust_streaming
index 632a563..c0d98c2 100755
--- a/tests/regression/tools/snapshots/test_ust_streaming
+++ b/tests/regression/tools/snapshots/test_ust_streaming
@@ -72,6 +72,15 @@ function start_trace_app()
 	rm -f $tmp_file
 }
 
+function stop_trace_app()
+{
+	diag "Killing $TESTAPP_NAME"
+	PID_APP=`pidof $TESTAPP_NAME`
+	kill $PID_APP >/dev/null 2>&1
+	diag "Waiting on $TESTAPP_NAME"
+	wait
+}
+
 # Test a snapshot using a default name for the output destination.
 function test_ust_default_name_with_del()
 {
@@ -90,6 +99,7 @@ function test_ust_default_name_with_del()
 	echo $TRACE_PATH/$HOSTNAME/snapshot-1
 	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/snapshot-1*
 	if [ $? -ne 0 ]; then
+		stop_trace_app
 		return $?
 	fi
 
@@ -100,15 +110,14 @@ function test_ust_default_name_with_del()
 	# Validate test with the next ID since a del output was done prior.
 	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/snapshot-2*
 	if [ $? -ne 0 ]; then
+		stop_trace_app
 		return $?
 	fi
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
-	diag "Killing $TESTAPP_NAME"
-	PID_APP=`pidof $TESTAPP_NAME`
-	kill $PID_APP >/dev/null 2>&1
+	stop_trace_app
 
 	return 0
 }
@@ -132,9 +141,7 @@ function test_ust_default_name()
 	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/snapshot-1*
 	out=$?
 
-	diag "Killing $TESTAPP_NAME"
-	PID_APP=`pidof $TESTAPP_NAME`
-	kill $PID_APP >/dev/null 2>&1
+	stop_trace_app
 
 	return $out
 }
@@ -157,9 +164,7 @@ function test_ust_default_name_custom_uri()
 	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/snapshot-1*
 	out=$?
 
-	diag "Killing $TESTAPP_NAME"
-	PID_APP=`pidof $TESTAPP_NAME`
-	kill $PID_APP >/dev/null 2>&1
+	stop_trace_app
 
 	return $out
 }
@@ -193,9 +198,7 @@ function test_ust_custom_name()
 		out=1
 	fi
 
-	diag "Killing $TESTAPP_NAME"
-	PID_APP=`pidof $TESTAPP_NAME`
-	kill $PID_APP >/dev/null 2>&1
+	stop_trace_app
 
 	return $out
 }
diff --git a/tests/regression/tools/snapshots/ust_test b/tests/regression/tools/snapshots/ust_test
index e727aa6..a35fbf3 100755
--- a/tests/regression/tools/snapshots/ust_test
+++ b/tests/regression/tools/snapshots/ust_test
@@ -63,11 +63,13 @@ function start_test_app()
 	rm -f $tmp_file
 }
 
-function kill_test_app()
+function stop_test_app()
 {
 	diag "Killing $TESTAPP_NAME"
 	PID_APP=`pidof $TESTAPP_NAME`
 	kill $PID_APP >/dev/null 2>&1
+	diag "Waiting on $TESTAPP_NAME"
+	wait
 }
 
 function snapshot_add_output ()
@@ -172,7 +174,7 @@ function test_ust_local_snapshot ()
 		break
 	fi
 
-	kill_test_app
+	stop_test_app
 }
 
 function test_ust_local_snapshot_max_size ()
@@ -220,7 +222,7 @@ function test_ust_local_snapshot_max_size ()
 		rm -rf $TRACE_PATH
 	fi
 
-	kill_test_app
+	stop_test_app
 }
 
 function test_ust_local_snapshot_large_metadata ()
@@ -286,7 +288,7 @@ function test_ust_per_uid_local_snapshot ()
 		break
 	fi
 
-	kill_test_app
+	stop_test_app
 }
 
 function test_ust_per_uid_local_snapshot_post_mortem ()
@@ -300,7 +302,7 @@ function test_ust_per_uid_local_snapshot_post_mortem ()
 
 	# Returns once the application has at least fired ONE tracepoint.
 	start_test_app
-	kill_test_app
+	stop_test_app
 
 	lttng_snapshot_record $SESSION_NAME
 	stop_lttng_tracing $SESSION_NAME
@@ -344,7 +346,7 @@ function test_ust_local_snapshots ()
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
-	kill_test_app
+	stop_test_app
 }
 
 plan_tests $NUM_TESTS
diff --git a/tests/regression/tools/streaming/test_high_throughput_limits b/tests/regression/tools/streaming/test_high_throughput_limits
index b2c8864..8ed2ce5 100755
--- a/tests/regression/tools/streaming/test_high_throughput_limits
+++ b/tests/regression/tools/streaming/test_high_throughput_limits
@@ -33,7 +33,7 @@ DEFAULT_IF="lo"
 
 TRACE_PATH=$(mktemp -d)
 
-NUM_TESTS=112
+NUM_TESTS=104
 
 source $TESTDIR/utils/utils.sh
 
@@ -95,14 +95,6 @@ function run_apps
 	done
 }
 
-function wait_apps
-{
-	while [ -n "$(pidof $TESTAPP_NAME)" ]; do
-		sleep 1
-	done
-	pass "Wait for applications to end"
-}
-
 function test_high_throughput
 {
 	NETWORK_URI="net://localhost"
@@ -110,7 +102,9 @@ function test_high_throughput
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
 	start_lttng_tracing $SESSION_NAME
 	run_apps
-	wait_apps
+	diag "Waiting for applications to end"
+	wait
+	pass "waiting done"
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 	validate_event_count
diff --git a/tests/regression/ust/buffers-pid/test_buffers_pid b/tests/regression/ust/buffers-pid/test_buffers_pid
index c7ee2d8..974fb71 100755
--- a/tests/regression/ust/buffers-pid/test_buffers_pid
+++ b/tests/regression/ust/buffers-pid/test_buffers_pid
@@ -26,7 +26,7 @@ TESTAPP_PATH="$TESTDIR/utils/testapp"
 TESTAPP_NAME="gen-ust-events"
 TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
 EVENT_NAME="tp:tptest"
-NUM_TESTS=58
+NUM_TESTS=59
 
 source $TESTDIR/utils/utils.sh
 
@@ -45,14 +45,6 @@ function enable_channel_per_pid()
 	ok $? "Enable channel $channel_name per PID for session $sess_name"
 }
 
-function wait_apps
-{
-	diag "Waiting for applications to end..."
-	while [ -n "$(pidof $TESTAPP_NAME)" ]; do
-		sleep 1
-	done
-}
-
 test_after_multiple_apps() {
 	local out
 	local i
@@ -95,8 +87,9 @@ test_before_multiple_apps() {
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME "channel0"
 	start_lttng_tracing $SESSION_NAME
 
-	# At least hit one event
-	sleep 2
+	diag "Waiting for applications to end"
+	wait
+	pass "Waiting done"
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
@@ -112,8 +105,6 @@ test_before_multiple_apps() {
 		out=0
 	fi
 
-	wait_apps
-
 	return $out
 }
 
diff --git a/tests/regression/ust/high-throughput/test_high_throughput b/tests/regression/ust/high-throughput/test_high_throughput
index ea45051..101a2c0 100755
--- a/tests/regression/ust/high-throughput/test_high_throughput
+++ b/tests/regression/ust/high-throughput/test_high_throughput
@@ -49,10 +49,9 @@ for i in `seq 1 $NR_APP`; do
 	./$CURDIR/$BIN_NAME & >/dev/null 2>&1
 done
 
-while [ -n "$(pidof $BIN_NAME)" ]; do
-	sleep 0.5
-done
-pass "Wait for application end"
+diag "Waiting for applications to end"
+wait
+pass "Wait for applications to end"
 
 stop_lttng_tracing $SESSION_NAME
 destroy_lttng_session $SESSION_NAME
diff --git a/tests/regression/ust/nprocesses/test_nprocesses b/tests/regression/ust/nprocesses/test_nprocesses
index 1660c21..84d0ff7 100755
--- a/tests/regression/ust/nprocesses/test_nprocesses
+++ b/tests/regression/ust/nprocesses/test_nprocesses
@@ -75,12 +75,9 @@ destroy_lttng_session $SESSION_NAME
 
 rm -rf $TRACE_PATH
 
-while [ -n "$(pidof $TESTAPP_NAME)" ]; do
-	killall -q $TESTAPP_NAME >/dev/null 2>&1
-	sleep 0.5
-done
-
-
-pass "Kill all spawned applications"
+diag "Stopping all spawned applications"
+killall -q $TESTAPP_NAME >/dev/null 2>&1
+wait
+pass "Stopped all spawned applications"
 
 stop_lttng_sessiond
diff --git a/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush b/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
index e836956..e419965 100755
--- a/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
+++ b/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
@@ -73,14 +73,6 @@ function enable_metadata_per_pid()
 	ok $? "Enable channel $channel_name per PID for session $sess_name"
 }
 
-function wait_apps
-{
-	diag "Waiting for applications to end..."
-	while [ -n "$(pidof $TESTAPP_NAME)" ]; do
-		sleep 1
-	done
-}
-
 function validate_trace()
 {
 	local out
@@ -149,11 +141,11 @@ test_after_app_pid() {
 	validate_trace
 	out=$?
 
+	killall -SIGKILL -q $TESTAPP_NAME
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
-	killall -SIGKILL -q $TESTAPP_NAME
-	wait_apps
+	wait
 
 	return $out
 }
@@ -188,11 +180,11 @@ test_before_app_pid() {
 	validate_trace
 	out=$?
 
+	killall -SIGKILL -q $TESTAPP_NAME
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
-	killall -SIGKILL -q $TESTAPP_NAME
-	wait_apps
+	wait
 
 	return $out
 }
@@ -223,11 +215,11 @@ test_after_app_uid() {
 	validate_trace
 	out=$?
 
+	killall -SIGKILL -q $TESTAPP_NAME
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
-	killall -SIGKILL -q $TESTAPP_NAME
-	wait_apps
+	wait
 
 	return $out
 }
@@ -261,11 +253,11 @@ test_before_app_uid() {
 	validate_trace
 	out=$?
 
+	killall -SIGKILL -q $TESTAPP_NAME
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
-	killall -SIGKILL -q $TESTAPP_NAME
-	wait_apps
+	wait
 
 	return $out
 }
-- 
2.1.1
