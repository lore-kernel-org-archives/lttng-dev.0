From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 1/2] Tests: take multiple snapshots
 in streaming mode
Date: Thu,  7 Feb 2019 20:25:41 -0500
Message-ID: <20190208012542.30069-1-jonathan.rajotte-julien__29684.2725410656$1549589171$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43wcvL1DCRzfjH
 for <lttng-dev@lists.lttng.org>; Thu,  7 Feb 2019 20:25:49 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 .../tools/snapshots/test_kernel_streaming     | 35 ++++++++++++++++--
 .../tools/snapshots/test_ust_streaming        | 36 +++++++++++++++++--
 2 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/tests/regression/tools/snapshots/test_kernel_streaming b/tests/regression/tools/snapshots/test_kernel_streaming
index 06e0a5c4a..0b535c612 100755
--- a/tests/regression/tools/snapshots/test_kernel_streaming
+++ b/tests/regression/tools/snapshots/test_kernel_streaming
@@ -24,7 +24,7 @@ CHANNEL_NAME="chan1"
 
 TRACE_PATH=$(mktemp -d)
 
-NUM_TESTS=36
+NUM_TESTS=61
 
 source $TESTDIR/utils/utils.sh
 
@@ -124,6 +124,32 @@ function test_kernel_custom_name()
 	return $out
 }
 
+function test_kernel_n_snapshot()
+{
+	diag "Test kernel snapshot streaming multiple consecutive snapshot"
+	create_lttng_session_no_output $SESSION_NAME
+	enable_lttng_mmap_overwrite_kernel_channel $SESSION_NAME $CHANNEL_NAME
+	lttng_enable_kernel_event $SESSION_NAME $EVENT_NAME $CHANNEL_NAME
+	snapshot_add_output $SESSION_NAME "net://localhost"
+
+	for i in {1..5};
+	do
+		start_lttng_tracing_ok $SESSION_NAME
+		lttng_snapshot_record $SESSION_NAME
+		stop_lttng_tracing_ok $SESSION_NAME
+		validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/snapshot-1*
+		if [ $? -ne 0 ]; then
+			return 1
+		fi
+		set -u
+		rm -rf $TRACE_PATH/$HOSTNAME
+		set +u
+	done
+
+	destroy_lttng_session_ok $SESSION_NAME
+	return 0
+}
+
 plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
@@ -141,8 +167,11 @@ skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_
 	start_lttng_relayd "-o $TRACE_PATH"
 	start_lttng_sessiond
 
-	tests=( test_kernel_default_name test_kernel_custom_name \
-			test_kernel_default_name_with_del )
+	tests=( test_kernel_default_name
+		test_kernel_custom_name
+		test_kernel_default_name_with_del
+		test_kernel_n_snapshot
+	)
 
 	for fct_test in ${tests[@]};
 	do
diff --git a/tests/regression/tools/snapshots/test_ust_streaming b/tests/regression/tools/snapshots/test_ust_streaming
index c97813e40..20d4f7f6b 100755
--- a/tests/regression/tools/snapshots/test_ust_streaming
+++ b/tests/regression/tools/snapshots/test_ust_streaming
@@ -31,7 +31,7 @@ APPS_PID=
 
 TRACE_PATH=$(mktemp -d)
 
-NUM_TESTS=49
+NUM_TESTS=75
 
 source $TESTDIR/utils/utils.sh
 
@@ -206,6 +206,33 @@ function test_ust_custom_name()
 	return $out
 }
 
+function test_ust_n_snapshot()
+{
+	diag "Test ust snapshot streaming multiple consecutive snapshot"
+	create_lttng_session_no_output $SESSION_NAME
+	enable_lttng_mmap_overwrite_ust_channel $SESSION_NAME $CHANNEL_NAME
+	enable_ust_lttng_event_ok $SESSION_NAME $EVENT_NAME $CHANNEL_NAME
+	snapshot_add_output $SESSION_NAME "net://localhost" $name
+	start_test_app
+	for i in {1..5};
+	do
+		start_lttng_tracing_ok $SESSION_NAME
+		lttng_snapshot_record $SESSION_NAME
+		stop_lttng_tracing_ok $SESSION_NAME
+		validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/snapshot-1*
+		if [ $? -ne 0 ]; then
+			return 1
+		fi
+		set -u
+		rm -rf $TRACE_PATH/$HOSTNAME
+		set +u
+	done
+
+	destroy_lttng_session_ok $SESSION_NAME
+	stop_test_apps
+	return 0
+}
+
 plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
@@ -219,7 +246,12 @@ fi
 start_lttng_relayd "-o $TRACE_PATH"
 start_lttng_sessiond
 
-tests=( test_ust_default_name_with_del test_ust_default_name test_ust_custom_name test_ust_default_name_custom_uri )
+tests=( test_ust_default_name_with_del
+	test_ust_default_name
+	test_ust_custom_name
+	test_ust_default_name_custom_uri
+	test_ust_n_snapshot
+)
 
 for fct_test in ${tests[@]};
 do
-- 
2.17.1
