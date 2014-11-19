From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 6/8] Fix: tests: remove killall,
	add missing SIGTERM handlers
Date: Wed, 19 Nov 2014 22:40:30 +0100
Message-ID: <1416433232-20080-7-git-send-email-mathieu.desnoyers__13084.2101331384$1416433498$gmane$org@efficios.com>
References: <1416433232-20080-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XrCzj-0002Nn-1l
 for lttng-dev@lists.lttng.org; Wed, 19 Nov 2014 16:41:00 -0500
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
 tests/stress/test_multi_sessions_per_uid_10app               |  9 ++++++++-
 tests/stress/test_multi_sessions_per_uid_5app_streaming      |  9 ++++++++-
 .../test_multi_sessions_per_uid_5app_streaming_kill_relayd   | 12 ++++++++++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/tests/stress/test_multi_sessions_per_uid_10app b/tests/stress/test_multi_sessions_per_uid_10app
index 365519d..a86b724 100755
--- a/tests/stress/test_multi_sessions_per_uid_10app
+++ b/tests/stress/test_multi_sessions_per_uid_10app
@@ -24,6 +24,7 @@ NR_APP=10
 NR_SESSION=5
 NR_LOOP=1000
 COREDUMP_FILE=$(cat /proc/sys/kernel/core_pattern)
+APPS_PID=
 
 TEST_DESC="Stress test - $NR_SESSION sessions per UID with $NR_APP apps"
 
@@ -101,7 +102,11 @@ test_stress()
 function cleanup()
 {
 	diag "Cleaning up!"
-	killall -9 $LAUNCH_APP
+	for p in ${APPS_PID}; do
+		kill -s SIGKILL ${p}
+		wait ${p} 2>/dev/null
+	done
+	APPS_PID=
 	stop_lttng_sessiond
 }
 
@@ -113,6 +118,7 @@ function sighandler()
 }
 
 trap sighandler SIGINT
+trap sighandler SIGTERM
 
 # Make sure we collect a coredump if possible.
 ulimit -c unlimited
@@ -128,6 +134,7 @@ diag "Starting applications"
 
 # Start NR_APP applications script that will spawn apps non stop.
 ./$TESTDIR/stress/$LAUNCH_APP $NR_APP &
+APPS_PID="${APPS_PID} ${!}"
 
 TRACE_PATH=$(mktemp -d)
 
diff --git a/tests/stress/test_multi_sessions_per_uid_5app_streaming b/tests/stress/test_multi_sessions_per_uid_5app_streaming
index 40c0a4d..36a15d9 100755
--- a/tests/stress/test_multi_sessions_per_uid_5app_streaming
+++ b/tests/stress/test_multi_sessions_per_uid_5app_streaming
@@ -23,6 +23,7 @@ NR_SESSION=5
 NR_LOOP=1000
 COREDUMP_FILE=$(cat /proc/sys/kernel/core_pattern)
 NUM_TESTS=16
+APPS_PID=
 
 TEST_DESC="Stress test - $NR_SESSION sessions per UID streaming with $NR_APP apps"
 
@@ -140,7 +141,11 @@ test_stress()
 function cleanup()
 {
 	diag "Cleaning up!"
-	killall -9 $LAUNCH_APP
+	for p in ${APPS_PID}; do
+		kill -s SIGKILL ${p}
+		wait ${p} 2>/dev/null
+	done
+	APPS_PID=
 	stop_lttng_sessiond
 	stop_lttng_relayd
 }
@@ -153,6 +158,7 @@ function sighandler()
 }
 
 trap sighandler SIGINT
+trap sighandler SIGTERM
 
 # Make sure we collect a coredump if possible.
 ulimit -c unlimited
@@ -171,6 +177,7 @@ diag "Starting applications launcher"
 
 # Start NR_APP applications script that will spawn apps non stop.
 ./$TESTDIR/stress/$LAUNCH_APP $NR_APP &
+APPS_PID="${APPS_PID} ${!}"
 
 test_stress
 out=$?
diff --git a/tests/stress/test_multi_sessions_per_uid_5app_streaming_kill_relayd b/tests/stress/test_multi_sessions_per_uid_5app_streaming_kill_relayd
index fa41b4c..e01e6aa 100755
--- a/tests/stress/test_multi_sessions_per_uid_5app_streaming_kill_relayd
+++ b/tests/stress/test_multi_sessions_per_uid_5app_streaming_kill_relayd
@@ -24,6 +24,7 @@ NR_SESSION=5
 NR_LOOP=100000
 COREDUMP_FILE=$(cat /proc/sys/kernel/core_pattern)
 NUM_TESTS=16
+APPS_PID=
 
 TEST_DESC="Stress test - $NR_SESSION sessions per UID streaming with $NR_APP apps. The relayd is killed sporadically"
 
@@ -142,8 +143,11 @@ test_stress()
 function cleanup()
 {
 	diag "Cleaning up!"
-	killall -9 $LAUNCH_APP
-	killall -9 $KILL_RELAYD_HELPER
+	for p in ${APPS_PID}; do
+		kill ${p}
+		wait ${p} 2>/dev/null
+	done
+	APPS_PID=
 	stop_lttng_sessiond
 	stop_lttng_relayd
 }
@@ -156,6 +160,7 @@ function sighandler()
 }
 
 trap sighandler SIGINT
+trap sighandler SIGTERM
 
 # Make sure we collect a coredump if possible.
 ulimit -c unlimited
@@ -174,8 +179,11 @@ diag "Starting applications launcher"
 
 # Start NR_APP applications script that will spawn apps non stop.
 ./$TESTDIR/stress/$LAUNCH_APP $NR_APP &
+APPS_PID="${APPS_PID} ${!}"
+
 # Launch the helper script that will randomly kill the relayd at vitam eternam.
 ./$TESTDIR/stress/$KILL_RELAYD_HELPER 1 1 &
+APPS_PID="${APPS_PID} ${!}"
 
 test_stress
 out=$?
-- 
2.1.1
