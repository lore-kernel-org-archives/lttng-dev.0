From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: tests: support systems where
	PAGE_SIZE is not 4096
Date: Tue, 22 Sep 2015 16:53:44 -0400
Message-ID: <1442955224-27693-1-git-send-email-mjeanson__41653.8671161563$1442955347$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZeUZa-00024N-NY
 for lttng-dev@lists.lttng.org; Tue, 22 Sep 2015 16:54:10 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tests/regression/tools/snapshots/ust_test          |  5 ++-
 .../tools/tracefile-limits/test_tracefile_size     | 51 +++++++++++++++++++++-
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/tests/regression/tools/snapshots/ust_test b/tests/regression/tools/snapshots/ust_test
index f05846f..54e1d88 100755
--- a/tests/regression/tools/snapshots/ust_test
+++ b/tests/regression/tools/snapshots/ust_test
@@ -181,9 +181,12 @@ function test_ust_local_snapshot ()
 
 function test_ust_local_snapshot_max_size ()
 {
-	subbuf_size=8192
+	page_size=`getconf PAGE_SIZE`
 	num_cpus=`nproc`
 
+	# The minimum subbuf size is the platform PAGE_SIZE
+	subbuf_size=$(($page_size*2))
+
 	# The minimum size limit is min(subbuf_size) * nb_streams
 	max_size=$(($subbuf_size*$num_cpus))
 
diff --git a/tests/regression/tools/tracefile-limits/test_tracefile_size b/tests/regression/tools/tracefile-limits/test_tracefile_size
index 9fe4637..41f0179 100755
--- a/tests/regression/tools/tracefile-limits/test_tracefile_size
+++ b/tests/regression/tools/tracefile-limits/test_tracefile_size
@@ -22,11 +22,13 @@ TESTDIR=$CURDIR/../../..
 
 NR_ITER=1000
 
+PAGE_SIZE=$(getconf PAGE_SIZE)
+
 TESTAPP_PATH="$TESTDIR/utils/testapp"
 TESTAPP_NAME="gen-ust-events"
 TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
 
-NUM_TESTS=42
+NUM_TESTS=58
 
 source $TESTDIR/utils/utils.sh
 
@@ -128,17 +130,62 @@ function test_tracefile_size_limit ()
 	rm -rf $trace_path
 }
 
+function test_tracefile_size_limit_pagesize ()
+{
+	# Set a size limit lower than the page_size
+	size_limit="$(($PAGE_SIZE-2))"
+	trace_path=$(mktemp -d)
+	session_name=$(randstring 16 0)
+	channel_name="channel"
+	event_name="tp:tptest"
+
+	diag "Test tracefile size limit lower than PAGE_SIZE : $size_limit bytes"
+
+	create_lttng_session_ok $session_name $trace_path
+
+	enable_lttng_channel_size_limit \
+	    $session_name $channel_name $size_limit
+
+	enable_ust_lttng_event_per_channel \
+	    $session_name $event_name $channel_name
+
+	start_lttng_tracing_ok $session_name
+
+	$TESTAPP_BIN $NR_ITER >/dev/null 2>&1
+
+	stop_lttng_tracing_ok $session_name
+
+	destroy_lttng_session_ok $session_name
+
+	# Validate file size, expect file size to be equal to the page size
+
+	check_file_size $trace_path "${channel_name}_*" $PAGE_SIZE
+
+	# Validate tracing data, we should at least have some events
+
+	validate_trace $event_name $trace_path
+
+	rm -rf $trace_path
+}
+
 plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
 
 start_lttng_sessiond
 
-LIMITS=("4096" "8192" "16384" "32768" "65536")
+LIMITS=("$(($PAGE_SIZE))"
+        "$(($PAGE_SIZE+4096))"
+        "$(($PAGE_SIZE+8192))"
+       	"$(($PAGE_SIZE+16384))"
+	"$(($PAGE_SIZE+32768))"
+       	"$(($PAGE_SIZE+65536))")
 
 for limit in ${LIMITS[@]};
 do
 	test_tracefile_size_limit $limit
 done
 
+test_tracefile_size_limit_pagesize
+
 stop_lttng_sessiond
-- 
1.9.1
