From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Tests: use functions from utils.sh
Date: Thu, 10 Sep 2015 16:07:47 -0400
Message-ID: <1441915667-871-1-git-send-email-jonathan.rajotte-julien__49731.4508226284$1441915761$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1Za88W-0006wQ-6s
 for lttng-dev@lists.lttng.org; Thu, 10 Sep 2015 16:08:07 -0400
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 tests/regression/ust/test_event_basic | 56 +++++++++--------------------------
 tests/utils/utils.sh                  | 38 ++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/tests/regression/ust/test_event_basic b/tests/regression/ust/test_event_basic
index 31931a9..acc79e5 100755
--- a/tests/regression/ust/test_event_basic
+++ b/tests/regression/ust/test_event_basic
@@ -23,39 +23,11 @@ LTTNG_BIN="lttng"
 BIN_NAME="gen-ust-events"
 SESSION_NAME="valid_filter"
 EVENT_NAME="tp:tptest"
-NUM_TESTS=25
-
-source $TESTDIR/utils/utils.sh
-
-function enable_ust_lttng_event_per_chan()
-{
-	sess_name="$1"
-	event_name="$2"
-	chan_name="$3"
-
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -s $sess_name -c $chan_name -u >/dev/null 2>&1
-	ok $? "Enable event $event_name for session $sess_name in channel $chan_name"
-}
 
-function disable_ust_lttng_event_per_chan()
-{
-	sess_name="$1"
-	event_name="$2"
-	chan_name="$3"
-
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event "$event_name" -s $sess_name -c $chan_name -u >/dev/null 2>&1
-	ok $? "Disable event $event_name for session $sess_name in channel $chan_name"
-}
 
-function add_ust_lttng_context()
-{
-	sess_name="$1"
-	chan_name="$2"
-	type="$3"
+NUM_TESTS=25
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN add-context -s $sess_name -c $chan_name -t $type -u >/dev/null 2>&1
-	ok $? "Add context $type for session $sess_name in channel $chan_name"
-}
+source $TESTDIR/utils/utils.sh
 
 function test_event_basic()
 {
@@ -74,21 +46,21 @@ function test_event_basic()
 	enable_ust_lttng_channel_ok $SESSION_NAME $CHAN_NAME
 	enable_ust_lttng_channel_ok $SESSION_NAME2 $CHAN_NAME2
 
-	enable_ust_lttng_event_per_chan $SESSION_NAME $EVENT_NAME $CHAN_NAME
-	enable_ust_lttng_event_per_chan $SESSION_NAME $EVENT_NAME2 $CHAN_NAME
-	enable_ust_lttng_event_per_chan $SESSION_NAME2 $EVENT_NAME3 $CHAN_NAME2
+	enable_ust_lttng_event_ok $SESSION_NAME $EVENT_NAME $CHAN_NAME
+	enable_ust_lttng_event_ok $SESSION_NAME $EVENT_NAME2 $CHAN_NAME
+	enable_ust_lttng_event_ok $SESSION_NAME2 $EVENT_NAME3 $CHAN_NAME2
 
-	add_ust_lttng_context $SESSION_NAME $CHAN_NAME "vpid"
-	add_ust_lttng_context $SESSION_NAME $CHAN_NAME "vtid"
-	add_ust_lttng_context $SESSION_NAME $CHAN_NAME "pthread_id"
-	add_ust_lttng_context $SESSION_NAME $CHAN_NAME "procname"
-	add_ust_lttng_context $SESSION_NAME2 $CHAN_NAME2 "procname"
+	add_context_ust_ok $SESSION_NAME $CHAN_NAME "vpid"
+	add_context_ust_ok $SESSION_NAME $CHAN_NAME "vtid"
+	add_context_ust_ok $SESSION_NAME $CHAN_NAME "pthread_id"
+	add_context_ust_ok $SESSION_NAME $CHAN_NAME "procname"
+	add_context_ust_ok $SESSION_NAME2 $CHAN_NAME2 "procname"
 
-	disable_ust_lttng_event_per_chan $SESSION_NAME $EVENT_NAME $CHAN_NAME
-	disable_ust_lttng_event_per_chan $SESSION_NAME2 $EVENT_NAME3 $CHAN_NAME2
+	disable_ust_lttng_event $SESSION_NAME $EVENT_NAME $CHAN_NAME
+	disable_ust_lttng_event $SESSION_NAME2 $EVENT_NAME3 $CHAN_NAME2
 
-	enable_ust_lttng_event_per_chan $SESSION_NAME $EVENT_NAME $CHAN_NAME
-	enable_ust_lttng_event_per_chan $SESSION_NAME2 $EVENT_NAME3 $CHAN_NAME2
+	enable_ust_lttng_event_ok $SESSION_NAME $EVENT_NAME $CHAN_NAME
+	enable_ust_lttng_event_ok $SESSION_NAME2 $EVENT_NAME3 $CHAN_NAME2
 
 	start_lttng_tracing_ok
 	stop_lttng_tracing_ok
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index d466ee6..2a7b9db 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -952,6 +952,44 @@ function lttng_untrack_fail()
 	lttng_untrack 1 "$@"
 }
 
+function add_context_lttng()
+{
+	local expected_to_fail="$1"
+	local domain="$2"
+	local session_name="$3"
+	local channel_name="$4"
+	local type="$5"
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN add-context -s $session_name -c $channel_name -t $type $domain  1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
+	ret=$?
+	if [[ $expected_to_fail -eq "1" ]]; then
+		test $ret -ne "0"
+		ok $? "Add context command failed as expected"
+	else
+		ok $ret "Add context command success as expected"
+	fi
+}
+
+function add_context_ust_ok()
+{
+	add_context_lttng 0 -u "$@"
+}
+
+function add_context_ust_fail()
+{
+	add_context_lttng 1 -u "$@"
+}
+
+function add_context_kernel_ok()
+{
+	add_context_lttng 0 -k "$@"
+}
+
+function add_context_kernel_fail()
+{
+	add_context_lttng 1 -k "$@"
+}
+
 function trace_matches ()
 {
 	local event_name=$1
-- 
2.1.4
