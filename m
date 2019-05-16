From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 6/6] tests: invoke full_cleanup from
 script trap handlers, use modprobe -r
Date: Thu, 16 May 2019 15:08:01 -0400
Message-ID: <20190516190801.16878-6-mathieu.desnoyers__34772.8644775756$1558033830$gmane$org@efficios.com>
References: <20190516190801.16878-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 454gtJ1T7YzypV
 for <lttng-dev@lists.lttng.org>; Thu, 16 May 2019 15:08:08 -0400 (EDT)
In-Reply-To: <20190516190801.16878-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: joraj@efficios.com, jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Scripts implementing their own trap handlers override the generic
one provided by utils.sh (full_cleanup). Invoke it at the end of
the handlers to provide the utils cleanup as well.

Moreover, change use of "rmmod" to "modprobe -r", which is better
in trap handlers because it does not print errors if the module
was not loaded yet when the signal occurs.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 tests/regression/kernel/test_clock_override            | 10 +++-------
 tests/regression/kernel/test_rotation_destroy_flush    |  7 +++----
 tests/regression/tools/crash/test_crash                |  3 +--
 .../tools/notification/test_notification_kernel        |  2 +-
 .../tools/notification/test_notification_multi_app     |  2 +-
 .../tools/notification/test_notification_ust           |  2 +-
 .../tools/streaming/test_high_throughput_limits        |  1 -
 .../rotation-destroy-flush/test_rotation_destroy_flush |  3 +--
 tests/stress/test_multi_sessions_per_uid_10app         |  5 ++---
 .../stress/test_multi_sessions_per_uid_5app_streaming  |  5 ++---
 ...t_multi_sessions_per_uid_5app_streaming_kill_relayd |  5 ++---
 11 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/tests/regression/kernel/test_clock_override b/tests/regression/kernel/test_clock_override
index e19b77e1..1fbba771 100755
--- a/tests/regression/kernel/test_clock_override
+++ b/tests/regression/kernel/test_clock_override
@@ -49,11 +49,9 @@ source $TESTDIR/utils/utils.sh
 function signal_cleanup()
 {
 	diag "*** Exiting ***"
-	rmmod lttng-test
 	stop_lttng_sessiond
-	rmmod lttng-clock-plugin-test
-	rmmod lttng-clock
-	exit 1
+	modprobe -r lttng-test lttng-clock-plugin-test lttng-clock
+	full_cleanup
 }
 
 function extract_clock_metadata()
@@ -93,10 +91,8 @@ function test_clock_override_metadata()
 	stop_lttng_tracing_ok $SESSION_NAME
 	destroy_lttng_session_ok $SESSION_NAME
 
-	rmmod lttng-test
 	stop_lttng_sessiond
-	rmmod lttng-clock-plugin-test
-	rmmod lttng-clock
+	modprobe -r lttng-test lttng-clock-plugin-test lttng-clock
 
 	local TRACE_METADATA_FILE_PATH="$(find "$TRACE_PATH" -name metadata -type f)"
 	local TRACE_METADATA_DIR="$(dirname "$TRACE_METADATA_FILE_PATH")"
diff --git a/tests/regression/kernel/test_rotation_destroy_flush b/tests/regression/kernel/test_rotation_destroy_flush
index 0b0b0ca7..03933a3a 100755
--- a/tests/regression/kernel/test_rotation_destroy_flush
+++ b/tests/regression/kernel/test_rotation_destroy_flush
@@ -39,9 +39,8 @@ source $TESTDIR/utils/utils.sh
 function signal_cleanup()
 {
 	diag "*** Exiting ***"
-	rmmod lttng-test
-	stop_lttng_sessiond
-	exit 1
+	modprobe -r lttng-test
+	full_cleanup
 }
 
 function enable_kernel_lttng_channel_size_limit ()
@@ -107,7 +106,7 @@ function test_rotation_destroy_flush_single()
 
 	rm -rf $TRACE_PATH
 
-	rmmod lttng-test
+	modprobe -r lttng-test
 	stop_lttng_sessiond
 }
 
diff --git a/tests/regression/tools/crash/test_crash b/tests/regression/tools/crash/test_crash
index 13909c1b..5bad16e5 100755
--- a/tests/regression/tools/crash/test_crash
+++ b/tests/regression/tools/crash/test_crash
@@ -392,8 +392,7 @@ function interrupt_cleanup()
 {
     diag "*** Cleaning-up test ***"
     stop_test_apps
-    stop_lttng_sessiond
-    exit 1
+    full_cleanup
 }
 
 TESTS=(
diff --git a/tests/regression/tools/notification/test_notification_kernel b/tests/regression/tools/notification/test_notification_kernel
index e7368df2..cc6fc581 100755
--- a/tests/regression/tools/notification/test_notification_kernel
+++ b/tests/regression/tools/notification/test_notification_kernel
@@ -56,7 +56,7 @@ function kernel_event_generator
 	state_file=$1
 	kernel_event_generator_suspended=0
 	trap kernel_event_generator_toogle_state SIGUSR1
-	trap "exit" SIGTERM SIGINT EXIT
+
 	while (true); do
 		if [[ $kernel_event_generator_suspended -eq "1" ]]; then
 			touch $state_file
diff --git a/tests/regression/tools/notification/test_notification_multi_app b/tests/regression/tools/notification/test_notification_multi_app
index 7465a83f..51d94e4f 100755
--- a/tests/regression/tools/notification/test_notification_multi_app
+++ b/tests/regression/tools/notification/test_notification_multi_app
@@ -64,7 +64,7 @@ function kernel_event_generator
 	state_file=$1
 	kernel_event_generator_suspended=0
 	trap kernel_event_generator_toogle_state SIGUSR1
-	trap "exit" SIGTERM SIGINT
+
 	while (true); do
 		if [[ $kernel_event_generator_suspended -eq "1" ]]; then
 			touch $state_file
diff --git a/tests/regression/tools/notification/test_notification_ust b/tests/regression/tools/notification/test_notification_ust
index 8941e476..82f79a8e 100755
--- a/tests/regression/tools/notification/test_notification_ust
+++ b/tests/regression/tools/notification/test_notification_ust
@@ -56,7 +56,7 @@ function ust_event_generator
 	state_file=$1
 	ust_event_generator_suspended=0
 	trap ust_event_generator_toogle_state SIGUSR1
-	trap "exit" SIGTERM SIGINT
+
 	while (true); do
 		if [[ $ust_event_generator_suspended -eq "1" ]]; then
 			touch $state_file
diff --git a/tests/regression/tools/streaming/test_high_throughput_limits b/tests/regression/tools/streaming/test_high_throughput_limits
index 5945bde7..1bcf3532 100755
--- a/tests/regression/tools/streaming/test_high_throughput_limits
+++ b/tests/regression/tools/streaming/test_high_throughput_limits
@@ -176,7 +176,6 @@ function interrupt_cleanup()
 	reset_bw_limit
 	# invoke utils cleanup
 	full_cleanup
-	exit 1
 }
 
 plan_tests $NUM_TESTS
diff --git a/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush b/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush
index a7a93771..e404564e 100755
--- a/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush
+++ b/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush
@@ -48,8 +48,7 @@ function run_app()
 function signal_cleanup()
 {
 	diag "*** Exiting ***"
-	stop_lttng_sessiond
-	exit 1
+	full_cleanup
 }
 
 function enable_ust_lttng_channel_size_limit ()
diff --git a/tests/stress/test_multi_sessions_per_uid_10app b/tests/stress/test_multi_sessions_per_uid_10app
index 82e8ad50..c9f8403e 100755
--- a/tests/stress/test_multi_sessions_per_uid_10app
+++ b/tests/stress/test_multi_sessions_per_uid_10app
@@ -112,11 +112,10 @@ function sighandler()
 {
 	cleanup
 	rm $LOG_FILE
-	exit 1
+	full_cleanup
 }
 
-trap sighandler SIGINT
-trap sighandler SIGTERM
+trap sighandler SIGINT SIGTERM
 
 # Make sure we collect a coredump if possible.
 ulimit -c unlimited
diff --git a/tests/stress/test_multi_sessions_per_uid_5app_streaming b/tests/stress/test_multi_sessions_per_uid_5app_streaming
index ed989498..4203ac30 100755
--- a/tests/stress/test_multi_sessions_per_uid_5app_streaming
+++ b/tests/stress/test_multi_sessions_per_uid_5app_streaming
@@ -142,11 +142,10 @@ function sighandler()
 {
 	cleanup
 	rm $LOG_FILE_SESSIOND $LOG_FILE_RELAYD
-	exit 1
+	full_cleanup
 }
 
-trap sighandler SIGINT
-trap sighandler SIGTERM
+trap sighandler SIGINT SIGTERM
 
 # Make sure we collect a coredump if possible.
 ulimit -c unlimited
diff --git a/tests/stress/test_multi_sessions_per_uid_5app_streaming_kill_relayd b/tests/stress/test_multi_sessions_per_uid_5app_streaming_kill_relayd
index c699ac22..d0121e32 100755
--- a/tests/stress/test_multi_sessions_per_uid_5app_streaming_kill_relayd
+++ b/tests/stress/test_multi_sessions_per_uid_5app_streaming_kill_relayd
@@ -144,11 +144,10 @@ function sighandler()
 {
 	cleanup
 	#rm $LOG_FILE_SESSIOND $LOG_FILE_RELAYD
-	exit 1
+	full_cleanup
 }
 
-trap sighandler SIGINT
-trap sighandler SIGTERM
+trap sighandler SIGINT SIGTERM
 
 # Make sure we collect a coredump if possible.
 ulimit -c unlimited
-- 
2.17.1
