From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 3/6] Tests: Fix tests first line of
	output to follow TAP guidelines
Date: Thu, 21 Mar 2013 15:56:44 -0400
Message-ID: <1363895807-17892-3-git-send-email-christian.babeux__5735.87693875215$1363895898$gmane$org@efficios.com>
References: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UIlcA-0006hc-8x
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 15:57:30 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so3919993ieb.17
	for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2013 12:57:24 -0700 (PDT)
In-Reply-To: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
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

From the Test::Harness::TAP documentation [1]:

     The plan tells how many tests will be run, or how many tests have run.
     It's a check that the test file hasn't stopped prematurely. It must
     appear once, whether at the beginning or end of the output.

The TAP plan *must* be the first line of output of any tests. Currently,
most of the tests output their description and then the TAP plan. This can
cause issues while parsing the test output for "strict" TAP parser such
as the one used in the prove tool.

This commit ensure that the first line outputted by any tests is the TAP
plan.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/regression/kernel/test_all_events                      | 4 ++--
 tests/regression/kernel/test_event_basic                     | 4 ++--
 tests/regression/tools/filtering/test_invalid_filter         | 4 ++--
 tests/regression/tools/filtering/test_unsupported_op         | 4 ++--
 tests/regression/tools/filtering/test_valid_filter           | 4 ++--
 tests/regression/tools/health/test_thread_exit               | 5 +++--
 tests/regression/tools/health/test_thread_stall              | 4 ++--
 tests/regression/tools/health/test_tp_fail                   | 4 ++--
 tests/regression/tools/streaming/test_high_throughput_limits | 4 ++--
 tests/regression/tools/streaming/test_kernel                 | 4 ++--
 tests/regression/tools/streaming/test_ust                    | 4 ++--
 tests/regression/ust/before-after/test_before_after          | 4 ++--
 tests/regression/ust/buffers-uid/test_buffers_uid            | 4 ++--
 tests/regression/ust/high-throughput/test_high_throughput    | 4 ++--
 tests/regression/ust/low-throughput/test_low_throughput      | 4 ++--
 tests/regression/ust/multi-session/test_multi_session        | 4 ++--
 tests/regression/ust/nprocesses/test_nprocesses              | 4 ++--
 tests/regression/ust/overlap/test_overlap                    | 4 ++--
 tests/regression/ust/test_event_basic                        | 4 ++--
 tests/regression/ust/test_event_wildcard                     | 4 ++--
 tests/unit/test_kernel_data.c                                | 4 ++--
 tests/unit/test_session.c                                    | 4 ++--
 tests/unit/test_uri.c                                        | 4 ++--
 tests/unit/test_ust_data.c                                   | 4 ++--
 24 files changed, 49 insertions(+), 48 deletions(-)

diff --git a/tests/regression/kernel/test_all_events b/tests/regression/kernel/test_all_events
index 4862748..afd42ab 100755
--- a/tests/regression/kernel/test_all_events
+++ b/tests/regression/kernel/test_all_events
@@ -23,8 +23,6 @@ NUM_TESTS=8
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 function test_all_event()
 {
 	TRACE_PATH=$(mktemp -d)
@@ -47,6 +45,8 @@ function test_all_event()
 # MUST set TESTDIR before calling those functions
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 if [ "$(id -u)" == "0" ]; then
 	isroot=1
 else
diff --git a/tests/regression/kernel/test_event_basic b/tests/regression/kernel/test_event_basic
index 4de94dc..5c19744 100755
--- a/tests/regression/kernel/test_event_basic
+++ b/tests/regression/kernel/test_event_basic
@@ -23,8 +23,6 @@ NUM_TESTS=12
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 function test_event_basic()
 {
 	TRACE_PATH=$(mktemp -d)
@@ -51,6 +49,8 @@ function test_event_basic()
 # MUST set TESTDIR before calling those functions
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 if [ "$(id -u)" == "0" ]; then
 	isroot=1
 else
diff --git a/tests/regression/tools/filtering/test_invalid_filter b/tests/regression/tools/filtering/test_invalid_filter
index 700fa23..9e8a3c6 100755
--- a/tests/regression/tools/filtering/test_invalid_filter
+++ b/tests/regression/tools/filtering/test_invalid_filter
@@ -28,8 +28,6 @@ NUM_TESTS=119
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 function enable_ust_lttng_event_filter
 {
 	sess_name="$1"
@@ -85,6 +83,8 @@ function test_bytecode_limit
 
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 IFS=$'\n'
 INVALID_FILTERS=(
 		# Unsupported ops
diff --git a/tests/regression/tools/filtering/test_unsupported_op b/tests/regression/tools/filtering/test_unsupported_op
index d0c6c86..b5b7f27 100755
--- a/tests/regression/tools/filtering/test_unsupported_op
+++ b/tests/regression/tools/filtering/test_unsupported_op
@@ -27,8 +27,6 @@ TRACE_PATH=$(mktemp -d)
 NUM_TESTS=46
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 function enable_ust_lttng_event_filter_unsupported
 {
 	sess_name=$1
@@ -86,6 +84,8 @@ function test_unsupported_op
 
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 # Unsupported operators
 OP_STR=("MUL" "DIV" "MOD" "PLUS" "MINUS" "LSHIFT" "RSHIFT"
 	"BIN_AND" "BIN_OR" "BIN_XOR" "UNARY_BIN_NOT")
diff --git a/tests/regression/tools/filtering/test_valid_filter b/tests/regression/tools/filtering/test_valid_filter
index 09ac868..5587fde 100755
--- a/tests/regression/tools/filtering/test_valid_filter
+++ b/tests/regression/tools/filtering/test_valid_filter
@@ -29,8 +29,6 @@ NUM_TESTS=198
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 if [ ! -x "$CURDIR/$BIN_NAME" ]; then
 	BAIL_OUT "No UST nevents binary detected."
 fi
@@ -313,6 +311,8 @@ function validator_true_statement
 
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 IFS=$'\n'
 
 issue_356_filter="intfield > 0 && intfield > 1 && "
diff --git a/tests/regression/tools/health/test_thread_exit b/tests/regression/tools/health/test_thread_exit
index 885ad19..aa2bd57 100755
--- a/tests/regression/tools/health/test_thread_exit
+++ b/tests/regression/tools/health/test_thread_exit
@@ -28,8 +28,6 @@ NUM_TESTS=12
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 if [ ! -f "$CURDIR/$SESSIOND_PRELOAD" ]; then
 	BAIL_OUT "libhealthexit.so not available for this test."
 fi
@@ -78,8 +76,11 @@ function test_thread_exit
 		return 1
 	fi
 }
+
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 THREAD=("LTTNG_THREAD_MANAGE_CLIENTS"
 	"LTTNG_THREAD_MANAGE_APPS"
 	"LTTNG_THREAD_REG_APPS")
diff --git a/tests/regression/tools/health/test_thread_stall b/tests/regression/tools/health/test_thread_stall
index 1651c02..9295131 100755
--- a/tests/regression/tools/health/test_thread_stall
+++ b/tests/regression/tools/health/test_thread_stall
@@ -28,8 +28,6 @@ NUM_TESTS=11
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 if [ ! -f "$CURDIR/$SESSIOND_PRELOAD" ]; then
 	BAIL_OUT "libhealthstall.so not available for this test."
 fi
@@ -99,6 +97,8 @@ function test_thread_stall
 
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 THREAD=("LTTNG_THREAD_MANAGE_CLIENTS"
 	"LTTNG_THREAD_MANAGE_APPS"
 # This thread is a little bit tricky to stall,
diff --git a/tests/regression/tools/health/test_tp_fail b/tests/regression/tools/health/test_tp_fail
index fdb8745..c7db624 100755
--- a/tests/regression/tools/health/test_tp_fail
+++ b/tests/regression/tools/health/test_tp_fail
@@ -28,8 +28,6 @@ NUM_TESTS=9
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 if [ ! -f "$CURDIR/$SESSIOND_PRELOAD" ]; then
 	BAIL_OUT "libhealthtpfail.so not available for this test."
 fi
@@ -73,6 +71,8 @@ function test_tp_fail
 
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 THREAD=("LTTNG_THREAD_MANAGE_CLIENTS"
 	"LTTNG_THREAD_MANAGE_APPS")
 
diff --git a/tests/regression/tools/streaming/test_high_throughput_limits b/tests/regression/tools/streaming/test_high_throughput_limits
index 2412374..f3885a8 100755
--- a/tests/regression/tools/streaming/test_high_throughput_limits
+++ b/tests/regression/tools/streaming/test_high_throughput_limits
@@ -35,8 +35,6 @@ NUM_TESTS=112
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 if [ ! -x "$CURDIR/$BIN_NAME" ]; then
 	BAIL_OUT "No UST nevents binary detected."
 fi
@@ -162,6 +160,8 @@ function interrupt_cleanup()
 
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 if [ "$(id -u)" == "0" ]; then
 	isroot=1
 else
diff --git a/tests/regression/tools/streaming/test_kernel b/tests/regression/tools/streaming/test_kernel
index db529c5..9877bb8 100755
--- a/tests/regression/tools/streaming/test_kernel
+++ b/tests/regression/tools/streaming/test_kernel
@@ -28,8 +28,6 @@ NUM_TESTS=10
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 # LTTng kernel modules check
 out=`ls /lib/modules/$(uname -r)/extra | grep lttng`
 if [ -z "$out" ]; then
@@ -79,6 +77,8 @@ function test_kernel_after_start ()
 
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 if [ "$(id -u)" == "0" ]; then
 	isroot=1
 else
diff --git a/tests/regression/tools/streaming/test_ust b/tests/regression/tools/streaming/test_ust
index 2d49cde..333b2e9 100755
--- a/tests/regression/tools/streaming/test_ust
+++ b/tests/regression/tools/streaming/test_ust
@@ -29,8 +29,6 @@ NUM_TESTS=18
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 if [ ! -x "$CURDIR/$BIN_NAME" ]; then
 	BAIL_OUT "No UST nevents binary detected."
 fi
@@ -87,6 +85,8 @@ function test_ust_after_start ()
 
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 start_lttng_relayd "-o $TRACE_PATH"
 start_lttng_sessiond
 
diff --git a/tests/regression/ust/before-after/test_before_after b/tests/regression/ust/before-after/test_before_after
index 6a5776e..c3e24f7 100755
--- a/tests/regression/ust/before-after/test_before_after
+++ b/tests/regression/ust/before-after/test_before_after
@@ -25,8 +25,6 @@ NUM_TESTS=16
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 if [ ! -x "$CURDIR/gen-nevents" ]; then
 	BAIL_OUT "No UST nevents binary detected."
 fi
@@ -86,6 +84,8 @@ test_after_apps() {
 # MUST set TESTDIR before calling those functions
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 start_lttng_sessiond
 
 diag "Start application BEFORE tracing was started"
diff --git a/tests/regression/ust/buffers-uid/test_buffers_uid b/tests/regression/ust/buffers-uid/test_buffers_uid
index a97a90a..1c590f2 100755
--- a/tests/regression/ust/buffers-uid/test_buffers_uid
+++ b/tests/regression/ust/buffers-uid/test_buffers_uid
@@ -26,8 +26,6 @@ NUM_TESTS=58
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 if [ ! -x "$CURDIR/gen-nevents" ]; then
 	BAIL_OUT "No UST nevents binary detected."
 fi
@@ -214,6 +212,8 @@ test_multiple_channels() {
 # MUST set TESTDIR before calling those functions
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 TESTS=(
 	"test_before_app"
 	"test_after_app"
diff --git a/tests/regression/ust/high-throughput/test_high_throughput b/tests/regression/ust/high-throughput/test_high_throughput
index a801400..ea45051 100755
--- a/tests/regression/ust/high-throughput/test_high_throughput
+++ b/tests/regression/ust/high-throughput/test_high_throughput
@@ -26,8 +26,6 @@ NUM_TESTS=9
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 if [ ! -x "$CURDIR/$BIN_NAME" ]; then
 	BAIL_OUT "No UST nevents binary detected."
 fi
@@ -38,6 +36,8 @@ TRACE_PATH=$(mktemp -d)
 
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 start_lttng_sessiond
 
 create_lttng_session $SESSION_NAME $TRACE_PATH
diff --git a/tests/regression/ust/low-throughput/test_low_throughput b/tests/regression/ust/low-throughput/test_low_throughput
index 197210a..1ca3c38 100755
--- a/tests/regression/ust/low-throughput/test_low_throughput
+++ b/tests/regression/ust/low-throughput/test_low_throughput
@@ -25,8 +25,6 @@ NUM_TESTS=8
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 if [ ! -x "$CURDIR/$BIN_NAME" ]; then
 	BAIL_OUT "No UST nevents binary detected."
 fi
@@ -37,6 +35,8 @@ TRACE_PATH=$(mktemp -d)
 
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 start_lttng_sessiond
 
 create_lttng_session $SESSION_NAME $TRACE_PATH
diff --git a/tests/regression/ust/multi-session/test_multi_session b/tests/regression/ust/multi-session/test_multi_session
index ffe8355..313a7d7 100755
--- a/tests/regression/ust/multi-session/test_multi_session
+++ b/tests/regression/ust/multi-session/test_multi_session
@@ -25,8 +25,6 @@ NUM_TESTS=28
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 if [ ! -x "$CURDIR/gen-nevents" ]; then
 	BAIL_OUT "No UST nevents binary detected."
 fi
@@ -76,6 +74,8 @@ test_multi_session() {
 
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 start_lttng_sessiond
 
 TRACE_PATH=$(mktemp -d)
diff --git a/tests/regression/ust/nprocesses/test_nprocesses b/tests/regression/ust/nprocesses/test_nprocesses
index ac8e99a..418fda5 100755
--- a/tests/regression/ust/nprocesses/test_nprocesses
+++ b/tests/regression/ust/nprocesses/test_nprocesses
@@ -27,8 +27,6 @@ NUM_TESTS=9
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 if [ ! -x "$CURDIR/$TEST_BIN_NAME" ]; then
 	BAIL_OUT "No UST $TEST_BIN_NAME binary detected."
 fi
@@ -37,6 +35,8 @@ fi
 
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 start_lttng_sessiond
 
 # Start test for 1000 seconds
diff --git a/tests/regression/ust/overlap/test_overlap b/tests/regression/ust/overlap/test_overlap
index e823072..add8ff1 100755
--- a/tests/regression/ust/overlap/test_overlap
+++ b/tests/regression/ust/overlap/test_overlap
@@ -34,8 +34,6 @@ NUM_TESTS=259
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 if [ ! -x "$CURDIR/demo/demo" ]; then
 	BAIL_OUT "No UST nevents binary detected."
 fi
@@ -615,6 +613,8 @@ test_disable_wildcard_overlap()
 
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 TESTS=(
 	"test_enable_wildcard_filter"
 	"test_enable_wildcard_filter_2"
diff --git a/tests/regression/ust/test_event_basic b/tests/regression/ust/test_event_basic
index 5a9cfe4..3ff91b3 100755
--- a/tests/regression/ust/test_event_basic
+++ b/tests/regression/ust/test_event_basic
@@ -27,8 +27,6 @@ NUM_TESTS=25
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 function enable_ust_lttng_event_per_chan()
 {
 	sess_name="$1"
@@ -111,6 +109,8 @@ function test_event_basic()
 # MUST set TESTDIR before calling those functions
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 start_lttng_sessiond
 
 test_event_basic
diff --git a/tests/regression/ust/test_event_wildcard b/tests/regression/ust/test_event_wildcard
index 88c02b0..33ba4c4 100755
--- a/tests/regression/ust/test_event_wildcard
+++ b/tests/regression/ust/test_event_wildcard
@@ -27,8 +27,6 @@ NUM_TESTS=9
 
 source $TESTDIR/utils/utils.sh
 
-print_test_banner "$TEST_DESC"
-
 function test_event_wildcard()
 {
 	TRACE_PATH=$(mktemp -d)
@@ -59,6 +57,8 @@ function test_event_wildcard()
 # MUST set TESTDIR before calling those functions
 plan_tests $NUM_TESTS
 
+print_test_banner "$TEST_DESC"
+
 start_lttng_sessiond
 
 test_event_wildcard
diff --git a/tests/unit/test_kernel_data.c b/tests/unit/test_kernel_data.c
index c9dc194..f368745 100644
--- a/tests/unit/test_kernel_data.c
+++ b/tests/unit/test_kernel_data.c
@@ -177,10 +177,10 @@ static void test_create_kernel_stream(void)
 
 int main(int argc, char **argv)
 {
-	diag("Kernel data structure unit test");
-
 	plan_tests(NUM_TESTS);
 
+	diag("Kernel data structure unit test");
+
 	test_create_one_kernel_session();
 	test_create_kernel_metadata();
 	test_create_kernel_channel();
diff --git a/tests/unit/test_session.c b/tests/unit/test_session.c
index 196124b..61db187 100644
--- a/tests/unit/test_session.c
+++ b/tests/unit/test_session.c
@@ -301,10 +301,10 @@ void test_large_session_number(void)
 
 int main(int argc, char **argv)
 {
-	diag("Sessions unit tests");
-
 	plan_tests(NUM_TESTS);
 
+	diag("Sessions unit tests");
+
 	test_session_list();
 
 	test_create_one_session();
diff --git a/tests/unit/test_uri.c b/tests/unit/test_uri.c
index 91bd21c..ba0baf9 100644
--- a/tests/unit/test_uri.c
+++ b/tests/unit/test_uri.c
@@ -252,10 +252,10 @@ void test_uri_cmp()
 
 int main(int argc, char **argv)
 {
-	diag("URI unit tests");
-
 	plan_tests(NUM_TESTS);
 
+	diag("URI unit tests");
+
 	test_uri_parsing();
 
 	test_uri_cmp();
diff --git a/tests/unit/test_ust_data.c b/tests/unit/test_ust_data.c
index 50d43bb..294b5c5 100644
--- a/tests/unit/test_ust_data.c
+++ b/tests/unit/test_ust_data.c
@@ -182,10 +182,10 @@ static void test_create_ust_context(void)
 
 int main(int argc, char **argv)
 {
-	diag("UST data structures unit test");
-
 	plan_tests(NUM_TESTS);
 
+	diag("UST data structures unit test");
+
 	test_create_one_ust_session();
 	test_create_ust_metadata();
 	test_create_ust_channel();
-- 
1.8.1.3
