From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 4/4] Tests: Rename helper functions
	to have consistent names
Date: Thu, 20 Sep 2012 18:05:20 -0400
Message-ID: <1348178720-24610-4-git-send-email-christian.babeux__48068.3731301271$1348178789$gmane$org@efficios.com>
References: <1348178720-24610-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TEosh-0004XT-NW
	for lttng-dev@lists.lttng.org; Thu, 20 Sep 2012 18:06:00 -0400
Received: by mail-qc0-f176.google.com with SMTP id c21so2633842qcs.35
	for <lttng-dev@lists.lttng.org>; Thu, 20 Sep 2012 15:05:59 -0700 (PDT)
In-Reply-To: <1348178720-24610-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Most of the helper functions had inconsistent naming.

Suggested naming convention for helper functions:

<action>_<bin_name>
	or
<action>_lttng_<command>

List of modified helper functions:

lttng_start_relayd -> start_lttng_relayd
lttng_stop_relayd  -> stop_lttng_relayd

start_sessiond     -> start_lttng_sessiond
stop_sessiond      -> stop_lttng_sessiond

start_tracing      -> start_lttng_tracing
stop_tracing       -> stop_lttng_tracing

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/kernel/run-kernel-tests.sh    |  6 +++---
 tests/tools/streaming/run-kernel    | 16 ++++++++--------
 tests/tools/streaming/run-ust       | 16 ++++++++--------
 tests/tools/streaming/uri_switch    | 24 ++++++++++++------------
 tests/ust/before-after/run          | 16 ++++++++--------
 tests/ust/high-throughput/run       |  8 ++++----
 tests/ust/low-throughput/run        |  8 ++++----
 tests/ust/multi-session/run         | 10 +++++-----
 tests/ust/nprocesses/run            |  4 ++--
 tests/ust/nprocesses/ust-nprocesses |  4 ++--
 tests/ust/run-ust-global-tests.sh   |  6 +++---
 tests/utils.sh                      | 12 ++++++------
 12 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/tests/kernel/run-kernel-tests.sh b/tests/kernel/run-kernel-tests.sh
index 358bf92..c3a9078 100755
--- a/tests/kernel/run-kernel-tests.sh
+++ b/tests/kernel/run-kernel-tests.sh
@@ -19,16 +19,16 @@ function start_tests ()
 			continue
 		fi
 
-		start_sessiond
+		start_lttng_sessiond
 
         ./$bin $tmpdir
         # Test must return 0 to pass.
         if [ $? -ne 0 ]; then
             exit_code=1
-			stop_sessiond
+			stop_lttng_sessiond
             break
         fi
-		stop_sessiond
+		stop_lttng_sessiond
     done
 
 	# Cleaning up
diff --git a/tests/tools/streaming/run-kernel b/tests/tools/streaming/run-kernel
index fb05c71..f02d1dc 100755
--- a/tests/tools/streaming/run-kernel
+++ b/tests/tools/streaming/run-kernel
@@ -75,10 +75,10 @@ function test_kernel_before_start ()
 	lttng_create_session
 	lttng_enable_consumer_localhost
 	lttng_enable_kernel_event $SESSION_NAME $EVENT_NAME
-	start_tracing $SESSION_NAME
+	start_lttng_tracing $SESSION_NAME
 	# Give a second
 	sleep 1
-	stop_tracing $SESSION_NAME
+	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 }
 
@@ -89,16 +89,16 @@ function test_kernel_after_start ()
 	echo -e "\n=== Testing kernel streaming with event enable AFTER start\n"
 	lttng_create_session
 	lttng_enable_consumer_localhost
-	start_tracing $SESSION_NAME
+	start_lttng_tracing $SESSION_NAME
 	lttng_enable_kernel_event $SESSION_NAME $EVENT_NAME
 	# Give a second
 	sleep 1
-	stop_tracing $SESSION_NAME
+	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 }
 
-start_sessiond
-lttng_start_relayd "-o $TRACE_PATH"
+start_lttng_sessiond
+start_lttng_relayd "-o $TRACE_PATH"
 
 tests=( test_kernel_before_start )
 
@@ -118,8 +118,8 @@ do
 done
 
 echo ""
-stop_sessiond
-lttng_stop_relayd
+stop_lttng_sessiond
+stop_lttng_relayd
 
 
 exit $out
diff --git a/tests/tools/streaming/run-ust b/tests/tools/streaming/run-ust
index 4fd2f74..7aea4f6 100755
--- a/tests/tools/streaming/run-ust
+++ b/tests/tools/streaming/run-ust
@@ -68,10 +68,10 @@ function test_ust_before_start ()
 	# Run 5 times with a 1 second delay
 	./$CURDIR/$BIN_NAME 5 1000000 >/dev/null 2>&1 &
 
-	start_tracing $SESSION_NAME
+	start_lttng_tracing $SESSION_NAME
 
 	wait_apps
-	stop_tracing $SESSION_NAME
+	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 }
 
@@ -81,18 +81,18 @@ function test_ust_after_start ()
 	lttng_create_session
 	lttng_enable_consumer
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
-	start_tracing $SESSION_NAME
+	start_lttng_tracing $SESSION_NAME
 
 	# Run 5 times with a 1 second delay
 	./$CURDIR/$BIN_NAME 5 1000000 >/dev/null 2>&1 &
 
 	wait_apps
-	stop_tracing $SESSION_NAME
+	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 }
 
-start_sessiond
-lttng_start_relayd "-o $TRACE_PATH"
+start_lttng_sessiond
+start_lttng_relayd "-o $TRACE_PATH"
 
 tests=( test_ust_before_start test_ust_after_start )
 
@@ -112,7 +112,7 @@ do
 done
 
 echo ""
-stop_sessiond
-lttng_stop_relayd
+stop_lttng_sessiond
+stop_lttng_relayd
 
 exit $out
diff --git a/tests/tools/streaming/uri_switch b/tests/tools/streaming/uri_switch
index 6081417..762a2e7 100755
--- a/tests/tools/streaming/uri_switch
+++ b/tests/tools/streaming/uri_switch
@@ -94,10 +94,10 @@ function test_uri_switch_localhost_folder
 	done
 
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
-	start_tracing $SESSION_NAME
+	start_lttng_tracing $SESSION_NAME
 	run_apps
 	wait_apps
-	stop_tracing $SESSION_NAME
+	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/$RAND
 
@@ -135,10 +135,10 @@ function test_uri_switch_file_network
 		lttng_create_session $FILE_URI
 		lttng_enable_consumer "$NETWORK_URI/$NET_PATH"
 		enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
-		start_tracing $SESSION_NAME
+		start_lttng_tracing $SESSION_NAME
 		run_apps
 		wait_apps
-		stop_tracing $SESSION_NAME
+		stop_lttng_tracing $SESSION_NAME
 		destroy_lttng_session $SESSION_NAME
 		validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/$NET_PATH
 
@@ -179,10 +179,10 @@ IPVER=$1
 	    lttng_create_session $NETWORK_URI
 	    lttng_enable_consumer "$FILE_URI/$FILE_PATH"
 	    enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
-	    start_tracing $SESSION_NAME
+	    start_lttng_tracing $SESSION_NAME
 	    run_apps
 	    wait_apps
-	    stop_tracing $SESSION_NAME
+	    stop_lttng_tracing $SESSION_NAME
 	    destroy_lttng_session $SESSION_NAME
 	    validate_trace $EVENT_NAME $TMP_PATH/$FILE_PATH
 
@@ -196,22 +196,22 @@ IPVER=$1
 }
 
 
-start_sessiond
+start_lttng_sessiond
 
 echo ""
 echo "=== Testing with IPv4"
-lttng_start_relayd "-o $TRACE_PATH"
+start_lttng_relayd "-o $TRACE_PATH"
 test_uri_switch_localhost_folder "IPv4"
 test_uri_switch_file_network "IPv4"
 test_uri_switch_network_file "IPv4"
-lttng_stop_relayd
+stop_lttng_relayd
 
 echo ""
 echo "=== Testing with IPv6"
-lttng_start_relayd "-o $TRACE_PATH -C tcp6://localhost:5342 -D tcp6://localhost:5343"
+start_lttng_relayd "-o $TRACE_PATH -C tcp6://localhost:5342 -D tcp6://localhost:5343"
 test_uri_switch_localhost_folder "IPv6"
 test_uri_switch_file_network "IPv6"
 test_uri_switch_network_file "IPv6"
-lttng_stop_relayd
+stop_lttng_relayd
 
-stop_sessiond
+stop_lttng_sessiond
diff --git a/tests/ust/before-after/run b/tests/ust/before-after/run
index db6584b..4711b58 100755
--- a/tests/ust/before-after/run
+++ b/tests/ust/before-after/run
@@ -39,13 +39,13 @@ test_before_apps() {
 	# BEFORE application is spawned
 	create_lttng_session $SESSION_NAME $TRACE_PATH
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
-	start_tracing $SESSION_NAME
+	start_lttng_tracing $SESSION_NAME
 	# Start test
 	echo -n "Starting application... "
 	./$CURDIR/gen-nevents $NR_ITER
 	echo -e "Ended "
 	print_ok
-	stop_tracing $SESSION_NAME
+	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
 	trace_matches $EVENT_NAME $NR_ITER $TRACE_PATH
@@ -63,12 +63,12 @@ test_after_apps() {
 	# BEFORE application is spawned
 	create_lttng_session $SESSION_NAME $TRACE_PATH
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
-	start_tracing $SESSION_NAME
+	start_lttng_tracing $SESSION_NAME
 
 	# At least hit one event
 	sleep 2
 
-	stop_tracing $SESSION_NAME
+	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
 	out=$(babeltrace $TRACE_PATH | grep $EVENT_NAME | wc -l)
@@ -87,7 +87,7 @@ test_after_apps() {
 
 # MUST set TESTDIR before calling those functions
 
-start_sessiond
+start_lttng_sessiond
 
 echo ""
 echo "=== Start application BEFORE tracing was started ==="
@@ -97,7 +97,7 @@ TRACE_PATH=$(mktemp -d)
 test_before_apps
 out=$?
 if [ $out -ne 0 ]; then
-	stop_sessiond
+	stop_lttng_sessiond
 	exit $out
 fi
 
@@ -111,10 +111,10 @@ TRACE_PATH=$(mktemp -d)
 test_after_apps
 out=$?
 if [ $out -ne 0 ]; then
-	stop_sessiond
+	stop_lttng_sessiond
 	exit $out
 fi
 
-stop_sessiond
+stop_lttng_sessiond
 
 rm -rf $TRACE_PATH
diff --git a/tests/ust/high-throughput/run b/tests/ust/high-throughput/run
index a6aef3d..7bf9995 100755
--- a/tests/ust/high-throughput/run
+++ b/tests/ust/high-throughput/run
@@ -36,12 +36,12 @@ TRACE_PATH=$(mktemp -d)
 
 # MUST set TESTDIR before calling those functions
 
-start_sessiond
+start_lttng_sessiond
 
 create_lttng_session $SESSION_NAME $TRACE_PATH
 
 enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
-start_tracing $SESSION_NAME
+start_lttng_tracing $SESSION_NAME
 
 for i in `seq 1 $NR_ITER`; do
 	./$CURDIR/$BIN_NAME & >/dev/null 2>&1
@@ -54,10 +54,10 @@ while [ -n "$(pidof $BIN_NAME)" ]; do
 done
 echo ""
 
-stop_tracing $SESSION_NAME
+stop_lttng_tracing $SESSION_NAME
 destroy_lttng_session $SESSION_NAME
 
-stop_sessiond
+stop_lttng_sessiond
 
 # Validate test
 
diff --git a/tests/ust/low-throughput/run b/tests/ust/low-throughput/run
index 038eff2..0e70dad 100755
--- a/tests/ust/low-throughput/run
+++ b/tests/ust/low-throughput/run
@@ -35,20 +35,20 @@ TRACE_PATH=$(mktemp -d)
 
 # MUST set TESTDIR before calling those functions
 
-start_sessiond
+start_lttng_sessiond
 
 create_lttng_session $SESSION_NAME $TRACE_PATH
 
 enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
-start_tracing $SESSION_NAME
+start_lttng_tracing $SESSION_NAME
 
 # This is going to take 20 minutes
 ./$CURDIR/$BIN_NAME >/dev/null 2>&1
 
-stop_tracing $SESSION_NAME
+stop_lttng_tracing $SESSION_NAME
 destroy_lttng_session $SESSION_NAME
 
-stop_sessiond
+stop_lttng_sessiond
 
 # Validate test
 
diff --git a/tests/ust/multi-session/run b/tests/ust/multi-session/run
index f740b57..7d45f4a 100755
--- a/tests/ust/multi-session/run
+++ b/tests/ust/multi-session/run
@@ -40,7 +40,7 @@ test_multi_session() {
 	for i in `seq 0 3`; do
 		create_lttng_session "$SESSION_NAME-$i" "$TRACE_PATH/$i"
 		enable_ust_lttng_event "$SESSION_NAME-$i" "$EVENT_NAME$i"
-		start_tracing "$SESSION_NAME-$i"
+		start_lttng_tracing "$SESSION_NAME-$i"
 	done
 
 	echo -n "Starting application generating $NR_ITER events... "
@@ -56,7 +56,7 @@ test_multi_session() {
 	print_ok
 
 	for i in `seq 0 3`; do
-		stop_tracing "$SESSION_NAME-$i"
+		stop_lttng_tracing "$SESSION_NAME-$i"
 		destroy_lttng_session "$SESSION_NAME-$i"
 		out=$(babeltrace "$TRACE_PATH/$i" | grep "$EVENT_NAMEi$i" | wc -l)
 		if [ $out -ne $NR_ITER ]; then
@@ -75,17 +75,17 @@ test_multi_session() {
 
 # MUST set TESTDIR before calling those functions
 
-start_sessiond
+start_lttng_sessiond
 
 TRACE_PATH=$(mktemp -d)
 
 test_multi_session
 out=$?
 if [ $out -ne 0 ]; then
-	stop_sessiond
+	stop_lttng_sessiond
 	exit $out
 fi
 
-stop_sessiond
+stop_lttng_sessiond
 
 rm -rf "$TRACE_PATH"
diff --git a/tests/ust/nprocesses/run b/tests/ust/nprocesses/run
index b284fbc..838798a 100755
--- a/tests/ust/nprocesses/run
+++ b/tests/ust/nprocesses/run
@@ -32,10 +32,10 @@ fi
 
 # MUST set TESTDIR before calling those functions
 
-start_sessiond
+start_lttng_sessiond
 
 ./$CURDIR/ust-nprocesses $NR_ITER
 
-stop_sessiond
+stop_lttng_sessiond
 
 exit 0
diff --git a/tests/ust/nprocesses/ust-nprocesses b/tests/ust/nprocesses/ust-nprocesses
index 7355057..90c0c2e 100755
--- a/tests/ust/nprocesses/ust-nprocesses
+++ b/tests/ust/nprocesses/ust-nprocesses
@@ -52,13 +52,13 @@ TRACE_PATH=$(mktemp -d)
 create_lttng_session $SESSION_NAME $TRACE_PATH
 
 enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
-start_tracing $SESSION_NAME
+start_lttng_tracing $SESSION_NAME
 
 echo "Sleeping $TEST_WAIT_SEC seconds for tracing to start everywhere"
 echo "Warning: this arbitrary time can make the test fail on slower system"
 sleep $TEST_WAIT_SEC
 
-stop_tracing $SESSION_NAME
+stop_lttng_tracing $SESSION_NAME
 destroy_lttng_session $SESSION_NAME
 
 rm -rf $TRACE_PATH
diff --git a/tests/ust/run-ust-global-tests.sh b/tests/ust/run-ust-global-tests.sh
index 67239c2..875641a 100755
--- a/tests/ust/run-ust-global-tests.sh
+++ b/tests/ust/run-ust-global-tests.sh
@@ -19,16 +19,16 @@ function start_tests ()
 			continue
 		fi
 
-		start_sessiond
+		start_lttng_sessiond
 
         ./$bin $tmpdir
         # Test must return 0 to pass.
         if [ $? -ne 0 ]; then
             exit_code=1
-			stop_sessiond
+			stop_lttng_sessiond
             break
         fi
-		stop_sessiond
+		stop_lttng_sessiond
     done
 
 	# Cleaning up
diff --git a/tests/utils.sh b/tests/utils.sh
index 70b6607..4b2eeec 100644
--- a/tests/utils.sh
+++ b/tests/utils.sh
@@ -129,7 +129,7 @@ function lttng_enable_kernel_event
 	fi
 }
 
-function lttng_start_relayd
+function start_lttng_relayd
 {
 	local opt="$1"
 
@@ -151,7 +151,7 @@ function lttng_start_relayd
 	fi
 }
 
-function lttng_stop_relayd
+function stop_lttng_relayd
 {
 	PID_RELAYD=`pidof lt-$RELAYD_BIN`
 
@@ -171,7 +171,7 @@ function lttng_stop_relayd
 	fi
 }
 
-function start_sessiond()
+function start_lttng_sessiond()
 {
 	if [ -n $TEST_NO_SESSIOND ] && [ "$TEST_NO_SESSIOND" == "1" ]; then
 		# Env variable requested no session daemon
@@ -193,7 +193,7 @@ function start_sessiond()
 	sleep 2
 }
 
-function stop_sessiond ()
+function stop_lttng_sessiond ()
 {
 	if [ -n $TEST_NO_SESSIOND ] && [ "$TEST_NO_SESSIOND" == "1" ]; then
 		# Env variable requested no session daemon
@@ -277,7 +277,7 @@ function enable_ust_lttng_event ()
 	fi
 }
 
-function start_tracing ()
+function start_lttng_tracing ()
 {
 	sess_name=$1
 
@@ -291,7 +291,7 @@ function start_tracing ()
 	fi
 }
 
-function stop_tracing ()
+function stop_lttng_tracing ()
 {
 	sess_name=$1
 
-- 
1.7.12
