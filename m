From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools] Add test cases for options
 sanitizing
Date: Wed, 20 Mar 2019 12:33:13 -0400
Message-ID: <20190320163313.15616-2-ylamarre__9535.21163189492$1553099647$gmane$org@efficios.com>
References: <20190320163313.15616-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44Pb816Xwcz17VK
 for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2019 12:33:21 -0400 (EDT)
In-Reply-To: <20190320163313.15616-1-ylamarre@efficios.com>
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

Test cases now covers options that require full string matches which
were previously missing.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 tests/regression/kernel/test_channel               | 24 ++++++++++-
 .../regression/tools/snapshots/test_ust_streaming  | 46 +++++++++++++++++++++-
 tests/regression/ust/test_event_basic              |  8 +++-
 tests/regression/ust/test_event_perf               |  6 ++-
 tests/utils/utils.sh                               | 26 ++++++++++++
 5 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/tests/regression/kernel/test_channel b/tests/regression/kernel/test_channel
index cb0fa518..f3fcee38 100755
--- a/tests/regression/kernel/test_channel
+++ b/tests/regression/kernel/test_channel
@@ -19,10 +19,31 @@ TEST_DESC="Kernel tracer - Channel configuration"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../..
-NUM_TESTS=8
+NUM_TESTS=14
 
 source $TESTDIR/utils/utils.sh
 
+function test_channel_output_opt()
+{
+	TRACE_PATH=$(mktemp -d)
+	SESSION_NAME="test_session_name"
+	CHANNEL_NAME="test_channel_name"
+	CHANNEL_NAME2="test_channel_name2"
+	create_lttng_session_ok "$SESSION_NAME" "$TRACE_PATH"
+
+	# Try to create channel with invalid output types
+	lttng_enable_kernel_channel_fail "$SESSION_NAME" "$CHANNEL_NAME" "--output=splicethenice"
+	lttng_enable_kernel_channel_fail "$SESSION_NAME" "$CHANNEL_NAME" "--output=mmap-o-spread"
+
+	# Try to create channel with valid output types
+	lttng_enable_kernel_channel_ok "$SESSION_NAME" "$CHANNEL_NAME" "--output=splice"
+	lttng_enable_kernel_channel_ok "$SESSION_NAME" "$CHANNEL_NAME2" "--output=mmap"
+
+	destroy_lttng_session_ok "$SESSION_NAME"
+
+	rm -rf "$TRACE_PATH"
+}
+
 function test_channel_buffer()
 {
 	TRACE_PATH=$(mktemp -d)
@@ -69,6 +90,7 @@ skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 
 	test_channel_buffer
 	test_channel_buffer_too_large
+	test_channel_output_opt
 
 	stop_lttng_sessiond
 }
diff --git a/tests/regression/tools/snapshots/test_ust_streaming b/tests/regression/tools/snapshots/test_ust_streaming
index 20d4f7f6..6a926710 100755
--- a/tests/regression/tools/snapshots/test_ust_streaming
+++ b/tests/regression/tools/snapshots/test_ust_streaming
@@ -31,7 +31,7 @@ APPS_PID=
 
 TRACE_PATH=$(mktemp -d)
 
-NUM_TESTS=75
+NUM_TESTS=91
 
 source $TESTDIR/utils/utils.sh
 
@@ -233,6 +233,49 @@ function test_ust_n_snapshot()
 	return 0
 }
 
+# Test commandline parsing of snapshot options
+function test_ust_cmd_opt()
+{
+	diag "Test commandline parsing of snapshot options"
+	create_lttng_session_no_output $SESSION_NAME
+	enable_lttng_mmap_overwrite_ust_channel $SESSION_NAME $CHANNEL_NAME
+	enable_ust_lttng_event_ok $SESSION_NAME $EVENT_NAME $CHANNEL_NAME
+	start_lttng_tracing_ok $SESSION_NAME
+
+	start_test_app
+
+	snapshot_add_output $SESSION_NAME "net://localhost"
+	lttng_snapshot_record $SESSION_NAME
+
+	# Validate test
+	echo $TRACE_PATH/$HOSTNAME/snapshot-1
+	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/snapshot-1*
+	if [ $? -ne 0 ]; then
+		stop_test_apps
+		return $?
+	fi
+
+	lttng_snapshot_del_output_by_name_fail $SESSION_NAME "snap"
+	lttng_snapshot_del_output_by_name_fail $SESSION_NAME "snapshot-100"
+	lttng_snapshot_del_output_by_name_ok $SESSION_NAME "snapshot-1"
+	snapshot_add_output $SESSION_NAME "net://localhost"
+	lttng_snapshot_record $SESSION_NAME
+
+	# Validate test with the next ID since a del output was done prior.
+	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/snapshot-2*
+	if [ $? -ne 0 ]; then
+		stop_test_apps
+		return $?
+	fi
+
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	stop_test_apps
+
+	return 0
+}
+
 plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
@@ -251,6 +294,7 @@ tests=( test_ust_default_name_with_del
 	test_ust_custom_name
 	test_ust_default_name_custom_uri
 	test_ust_n_snapshot
+	test_ust_cmd_opt
 )
 
 for fct_test in ${tests[@]};
diff --git a/tests/regression/ust/test_event_basic b/tests/regression/ust/test_event_basic
index 9b58cb27..c0243728 100755
--- a/tests/regression/ust/test_event_basic
+++ b/tests/regression/ust/test_event_basic
@@ -24,7 +24,7 @@ SESSION_NAME="valid_filter"
 EVENT_NAME="tp:tptest"
 
 
-NUM_TESTS=25
+NUM_TESTS=28
 
 source $TESTDIR/utils/utils.sh
 
@@ -43,8 +43,14 @@ function test_event_basic()
 	create_lttng_session_ok $SESSION_NAME2 $TRACE_PATH
 
 	enable_ust_lttng_channel_ok $SESSION_NAME $CHAN_NAME
+
+	enable_ust_lttng_channel_fail $SESSION_NAME2 $CHAN_NAME2 "--output=splice"
+	enable_ust_lttng_channel_fail $SESSION_NAME2 $CHAN_NAME2 "--output=mmap-o-spread"
+
 	enable_ust_lttng_channel_ok $SESSION_NAME2 $CHAN_NAME2
 
+	enable_ust_lttng_channel_fail $SESSION_NAME2 $CHAN_NAME2
+
 	enable_ust_lttng_event_ok $SESSION_NAME $EVENT_NAME $CHAN_NAME
 	enable_ust_lttng_event_ok $SESSION_NAME $EVENT_NAME2 $CHAN_NAME
 	enable_ust_lttng_event_ok $SESSION_NAME2 $EVENT_NAME3 $CHAN_NAME2
diff --git a/tests/regression/ust/test_event_perf b/tests/regression/ust/test_event_perf
index 4e665e65..8a1fce63 100755
--- a/tests/regression/ust/test_event_perf
+++ b/tests/regression/ust/test_event_perf
@@ -22,7 +22,7 @@ CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../..
 SESSION_NAME="perf_counters"
 EVENT_NAME="tp:tptest"
-NUM_TESTS=24
+NUM_TESTS=28
 NR_ITER=1
 NR_USEC_WAIT=1
 TESTAPP_PATH="$TESTDIR/utils/testapp"
@@ -55,6 +55,10 @@ function test_parsing_raw()
 	enable_ust_lttng_event_per_chan $SESSION_NAME $EVENT_NAME $CHAN_NAME
 
 	add_context_ust_ok $SESSION_NAME $CHAN_NAME "perf:thread:raw:r0110:test"
+	add_context_ust_fail $SESSION_NAME $CHAN_NAME "perform:thread:raw:r0110:test"
+	add_context_ust_fail $SESSION_NAME $CHAN_NAME "perf:threadish:raw:r0110:test"
+	add_context_ust_fail $SESSION_NAME $CHAN_NAME "perf:cpush:raw:r0110:test"
+	add_context_ust_fail $SESSION_NAME $CHAN_NAME "perf:thread:rawesome:r0110:test"
 	add_context_ust_fail $SESSION_NAME $CHAN_NAME "perf:thread:raw:rZZZ:test"
 	add_context_ust_fail $SESSION_NAME $CHAN_NAME "perf:thread:raw:b0110:test"
 	add_context_ust_fail $SESSION_NAME $CHAN_NAME "perf:thread:raw:r0110:"
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index 94b3a3c4..cba38b93 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -1282,6 +1282,32 @@ function lttng_snapshot_del_output_fail ()
 	lttng_snapshot_del_output 1 "$@"
 }
 
+function lttng_snapshot_del_output_by_name ()
+{
+	local expected_to_fail=$1
+	local sess_name=$2
+	local name=$3
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot del-output -s $sess_name $name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
+	ret=$?
+	if [[ $expected_to_fail -eq "1" ]]; then
+		test "$ret" -ne "0"
+		ok $? "Deleted snapshot output name $name failed as expected"
+	else
+		ok $ret "Deleted snapshot output name $name"
+	fi
+}
+
+function lttng_snapshot_del_output_by_name_ok ()
+{
+	lttng_snapshot_del_output_by_name 0 "$@"
+}
+
+function lttng_snapshot_del_output_by_name_fail ()
+{
+	lttng_snapshot_del_output_by_name 1 "$@"
+}
+
 function lttng_snapshot_record ()
 {
 	local sess_name=$1
-- 
2.11.0
