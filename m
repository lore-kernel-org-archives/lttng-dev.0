From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 2/2] Tests: Add UST snapshots
	streaming test with custom URI
Date: Mon,  9 Sep 2013 18:10:40 -0400
Message-ID: <1378764640-11769-1-git-send-email-christian.babeux__24241.2060885274$1378764753$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VJ9fc-0008VH-0l
	for lttng-dev@lists.lttng.org; Mon, 09 Sep 2013 18:11:01 -0400
Received: by mail-qa0-f47.google.com with SMTP id ii20so558502qab.6
	for <lttng-dev@lists.lttng.org>; Mon, 09 Sep 2013 15:10:50 -0700 (PDT)
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

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 .../regression/tools/snapshots/test_ust_streaming  | 28 ++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tests/regression/tools/snapshots/test_ust_streaming b/tests/regression/tools/snapshots/test_ust_streaming
index 3aa3858..e64b10c 100755
--- a/tests/regression/tools/snapshots/test_ust_streaming
+++ b/tests/regression/tools/snapshots/test_ust_streaming
@@ -31,7 +31,7 @@ NR_USEC_WAIT=100
 
 TRACE_PATH=$(mktemp -d)
 
-NUM_TESTS=39
+NUM_TESTS=49
 
 source $TESTDIR/utils/utils.sh
 
@@ -119,6 +119,30 @@ function test_ust_default_name()
 	return $out
 }
 
+function test_ust_default_name_custom_uri()
+{
+	diag "Test UST snapshot streaming with default name with custom URL"
+	create_lttng_session_no_output $SESSION_NAME
+	enable_lttng_mmap_overwrite_ust_channel $SESSION_NAME $CHANNEL_NAME
+	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME $CHANNEL_NAME
+	start_lttng_tracing $SESSION_NAME
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT &
+	ok $? "Start application to trace"
+	snapshot_add_output $SESSION_NAME "-C tcp://localhost:5342 -D tcp://localhost:5343"
+	lttng_snapshot_record $SESSION_NAME
+	stop_lttng_tracing $SESSION_NAME
+	destroy_lttng_session $SESSION_NAME
+	# Validate test
+	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/snapshot-1*
+	out=$?
+
+	diag "Killing $TESTAPP_NAME"
+	PID_APP=`pidof $TESTAPP_NAME`
+	kill $PID_APP >/dev/null 2>&1
+
+	return $out
+}
+
 # Test a snapshot using a custom name for the output destination.
 function test_ust_custom_name()
 {
@@ -167,7 +191,7 @@ fi
 start_lttng_relayd "-o $TRACE_PATH"
 start_lttng_sessiond
 
-tests=( test_ust_default_name_with_del test_ust_default_name test_ust_custom_name )
+tests=( test_ust_default_name_with_del test_ust_default_name test_ust_custom_name test_ust_default_name_custom_uri )
 
 for fct_test in ${tests[@]};
 do
-- 
1.8.4
