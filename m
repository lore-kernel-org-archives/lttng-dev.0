From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: skip test when ust doesn't
 have perf support
Date: Wed, 20 Mar 2019 17:49:00 -0400
Message-ID: <20190320214900.16654-1-mjeanson__48200.8602515393$1553118565$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Pk8R68j3z185d
 for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2019 17:49:11 -0400 (EDT)
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tests/regression/ust/test_event_perf | 43 +++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/tests/regression/ust/test_event_perf b/tests/regression/ust/test_event_perf
index 4e665e65..9b1dea3e 100755
--- a/tests/regression/ust/test_event_perf
+++ b/tests/regression/ust/test_event_perf
@@ -41,6 +41,29 @@ function enable_ust_lttng_event_per_chan()
 	ok $? "Enable event $event_name for session $sess_name in channel $chan_name"
 }
 
+function add_context_ust_skip_ok()
+{
+	local session_name=$1
+	local channel_name=$2
+	local context_name=$3
+	local skip_num=$4
+
+	local ret
+
+	"$TESTDIR/../src/bin/lttng/$LTTNG_BIN" add-context -u \
+		-s "$session_name" -c "$channel_name" \
+		-t "$context_name"  1>"$OUTPUT_DEST" 2>"$ERROR_OUTPUT_DEST"
+	ret=$?
+
+	if [ "$ret" == "4" ]; then
+		skip 0 "Current UST lib doesn't implement '$context_name' context" "$skip_num"
+	else
+		ok $ret "Add context command for type: $context_name"
+	fi
+
+	return $ret
+}
+
 # Only test parsing of the enabling by raw ID
 function test_parsing_raw()
 {
@@ -54,7 +77,7 @@ function test_parsing_raw()
 
 	enable_ust_lttng_event_per_chan $SESSION_NAME $EVENT_NAME $CHAN_NAME
 
-	add_context_ust_ok $SESSION_NAME $CHAN_NAME "perf:thread:raw:r0110:test"
+	add_context_ust_skip_ok $SESSION_NAME $CHAN_NAME "perf:thread:raw:r0110:test" 1
 	add_context_ust_fail $SESSION_NAME $CHAN_NAME "perf:thread:raw:rZZZ:test"
 	add_context_ust_fail $SESSION_NAME $CHAN_NAME "perf:thread:raw:b0110:test"
 	add_context_ust_fail $SESSION_NAME $CHAN_NAME "perf:thread:raw:r0110:"
@@ -76,24 +99,30 @@ function test_event_basic()
 	SESSION_NAME="ust_event_basic"
 	CHAN_NAME="mychan"
 
+	local ret
+
 	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
 
 	enable_ust_lttng_channel_ok $SESSION_NAME $CHAN_NAME
 
 	enable_ust_lttng_event_per_chan $SESSION_NAME $EVENT_NAME $CHAN_NAME
 
-	add_context_ust_ok $SESSION_NAME $CHAN_NAME "perf:thread:page-fault"
+	add_context_ust_skip_ok $SESSION_NAME $CHAN_NAME "perf:thread:page-fault" 4
+	ret=$?
 
-	start_lttng_tracing_ok
+	if [ "$ret" != "4" ]; then
+		start_lttng_tracing_ok
 
-	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1
+		$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1
 
-	stop_lttng_tracing_ok
+		stop_lttng_tracing_ok
+
+		validate_trace "perf_thread_page_fault" "$TRACE_PATH"
+	fi
 
 	destroy_lttng_session_ok $SESSION_NAME
 
-	validate_trace "perf_thread_page_fault" $TRACE_PATH
-	rm -rf $TRACE_PATH
+	rm -rf "$TRACE_PATH"
 }
 
 # MUST set TESTDIR before calling those functions
-- 
2.17.1
