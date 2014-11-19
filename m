From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 7/8] Fix: tests: wait output hide
	Terminate errors
Date: Wed, 19 Nov 2014 22:40:31 +0100
Message-ID: <1416433232-20080-8-git-send-email-mathieu.desnoyers__29201.0420620956$1416433601$gmane$org@efficios.com>
References: <1416433232-20080-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XrCzk-0002O0-Vj
 for lttng-dev@lists.lttng.org; Wed, 19 Nov 2014 16:41:05 -0500
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

Also: Don't hide kill errors.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tests/regression/tools/live/test_kernel              | 4 ++--
 tests/regression/tools/live/test_ust                 | 4 ++--
 tests/regression/tools/live/test_ust_tracefile_count | 4 ++--
 tests/regression/tools/mi/test_mi                    | 6 ++----
 tests/regression/tools/snapshots/test_ust_streaming  | 2 +-
 tests/regression/tools/snapshots/ust_test            | 2 +-
 tests/regression/ust/overlap/test_overlap            | 3 ++-
 7 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/tests/regression/tools/live/test_kernel b/tests/regression/tools/live/test_kernel
index bf5e79c..4b958df 100755
--- a/tests/regression/tools/live/test_kernel
+++ b/tests/regression/tools/live/test_kernel
@@ -88,7 +88,7 @@ clean_live_tracing
 
 # Kill the relayd
 PID_RELAYD=`pidof lt-$RELAYD_BIN`
-kill $PID_RELAYD >/dev/null 2>&1
+kill $PID_RELAYD
 if [ $? -eq 1 ]; then
 	echo "Kill lttng-relayd (pid: $PID_RELAYD)"
 	exit 1
@@ -102,7 +102,7 @@ fi
 
 # Kill the sessiond
 PID_SESSIOND=`pidof lt-$SESSIOND_BIN`
-kill $PID_SESSIOND >/dev/null 2>&1
+kill $PID_SESSIOND
 if [ $? -eq 1 ]; then
 	echo "Kill sessiond daemon"
 	exit 1
diff --git a/tests/regression/tools/live/test_ust b/tests/regression/tools/live/test_ust
index 4026bba..ae69195 100755
--- a/tests/regression/tools/live/test_ust
+++ b/tests/regression/tools/live/test_ust
@@ -88,7 +88,7 @@ clean_live_tracing
 
 # Kill the relayd
 PID_RELAYD=`pidof lt-$RELAYD_BIN`
-kill $PID_RELAYD >/dev/null 2>&1
+kill $PID_RELAYD
 if [ $? -eq 1 ]; then
 	echo "Kill lttng-relayd (pid: $PID_RELAYD)"
 	exit 1
@@ -102,7 +102,7 @@ fi
 
 # Kill the sessiond
 PID_SESSIOND=`pidof lt-$SESSIOND_BIN`
-kill $PID_SESSIOND >/dev/null 2>&1
+kill $PID_SESSIOND
 if [ $? -eq 1 ]; then
 	echo "Kill sessiond daemon"
 	exit 1
diff --git a/tests/regression/tools/live/test_ust_tracefile_count b/tests/regression/tools/live/test_ust_tracefile_count
index 3ef2ee1..68e3722 100755
--- a/tests/regression/tools/live/test_ust_tracefile_count
+++ b/tests/regression/tools/live/test_ust_tracefile_count
@@ -89,7 +89,7 @@ clean_live_tracing
 
 # Kill the relayd
 PID_RELAYD=`pidof lt-$RELAYD_BIN`
-kill $PID_RELAYD >/dev/null 2>&1
+kill $PID_RELAYD
 if [ $? -eq 1 ]; then
 	echo "Kill lttng-relayd (pid: $PID_RELAYD)"
 	exit 1
@@ -103,7 +103,7 @@ fi
 
 # Kill the sessiond
 PID_SESSIOND=`pidof lt-$SESSIOND_BIN`
-kill $PID_SESSIOND >/dev/null 2>&1
+kill $PID_SESSIOND
 if [ $? -eq 1 ]; then
 	echo "Kill sessiond daemon"
 	exit 1
diff --git a/tests/regression/tools/mi/test_mi b/tests/regression/tools/mi/test_mi
index fa46b51..e690822 100755
--- a/tests/regression/tools/mi/test_mi
+++ b/tests/regression/tools/mi/test_mi
@@ -523,9 +523,8 @@ function test_list_ust_event ()
 	test "$num" -eq "12"
 	ok $? "Mi test: $num / 12 ust event fields discovered"
 
-	#Wait for last forked process
-	wait $!
-
+	#Wait for all background processes
+	wait
 }
 
 function test_start_stop () {
@@ -603,7 +602,6 @@ function test_start_stop () {
 	#Teardown
 	OUTPUT_DEST=$DEVNULL
 	destroy_lttng_sessions
-
 }
 
 function test_snapshot () {
diff --git a/tests/regression/tools/snapshots/test_ust_streaming b/tests/regression/tools/snapshots/test_ust_streaming
index ad0c56b..55c1087 100755
--- a/tests/regression/tools/snapshots/test_ust_streaming
+++ b/tests/regression/tools/snapshots/test_ust_streaming
@@ -80,7 +80,7 @@ function stop_test_apps()
 	diag "Stopping $TESTAPP_NAME"
 	for p in ${APPS_PID}; do
 		kill ${p}
-		wait ${p} 2>&1
+		wait ${p} 2>/dev/null
 	done
 	APPS_PID=
 }
diff --git a/tests/regression/tools/snapshots/ust_test b/tests/regression/tools/snapshots/ust_test
index 69feb94..1541e6e 100755
--- a/tests/regression/tools/snapshots/ust_test
+++ b/tests/regression/tools/snapshots/ust_test
@@ -71,7 +71,7 @@ function stop_test_apps()
 	diag "Stopping $TESTAPP_NAME"
 	for p in ${APPS_PID}; do
 		kill ${p}
-		wait ${p} 2>&1
+		wait ${p} 2>/dev/null
 	done
 	APPS_PID=
 }
diff --git a/tests/regression/ust/overlap/test_overlap b/tests/regression/ust/overlap/test_overlap
index add8ff1..3a8af98 100755
--- a/tests/regression/ust/overlap/test_overlap
+++ b/tests/regression/ust/overlap/test_overlap
@@ -45,8 +45,9 @@ run_demo_app()
 	cd $CURDIR/demo
 
 	# Start test
+	diag "Running application"
 	./demo-trace >/dev/null 2>&1
-	ok $? "Start application"
+	ok $? "Application done"
 
 	cd -
 }
-- 
2.1.1
