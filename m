From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/2] Format utils.sh messages
Date: Fri, 11 Sep 2015 10:46:06 -0400
Message-ID: <1441982766-3927-2-git-send-email-jonathan.rajotte-julien__3442.44442317194$1441982915$gmane$org@efficios.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD8F0D9827@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <1441982766-3927-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZaPau-0004Fq-UF
 for lttng-dev@lists.lttng.org; Fri, 11 Sep 2015 10:46:31 -0400
In-Reply-To: <1441982766-3927-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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
 tests/utils/utils.sh | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index d45f747..b56d9eb 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -194,7 +194,7 @@ function lttng_disable_kernel_syscall()
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test $ret -ne "0"
-		ok $? "Disable kernel syscall $syscall_name for session $sess_name on channel $channel_name fail as expected"
+		ok $? "Disable kernel syscall $syscall_name for session $sess_name on channel $channel_name failed as expected"
 	else
 		ok $ret "Disable kernel syscall $syscall_name for session $sess_name on channel $channel_name"
 	fi
@@ -220,7 +220,7 @@ function lttng_enable_kernel_channel()
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
-		ok $? "Expected failure on kernel channel creation $channel_name in $sess_name"
+		ok $? "Enable channel $channel_name for session $sess_name failed as expected"
 	else
 		ok $ret "Enable channel $channel_name for session $sess_name"
 	fi
@@ -246,9 +246,9 @@ function lttng_disable_kernel_channel()
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
-		ok $? "Expected failure on kernel channel creation $channel_name in $sess_name"
+		ok $? "Disable channel $channel_name for session $sess_name failed as expected"
 	else
-		ok $ret "disable channel $channel_name for session $sess_name"
+		ok $ret "Disable channel $channel_name for session $sess_name"
 	fi
 }
 
@@ -453,7 +453,7 @@ function create_lttng_session ()
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
-		ok $? "Expected fail on session creation $sess_name in $trace_path"
+		ok $? "Create session $sess_name in $trace_path failed as expected"
 	else
 		ok $ret "Create session $sess_name in $trace_path"
 	fi
@@ -472,15 +472,15 @@ function create_lttng_session_fail ()
 
 function enable_ust_lttng_channel ()
 {
-	local expect_fail=$1
+	local expected_to_fail=$1
 	local sess_name=$2
 	local channel_name=$3
 
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -u $channel_name -s $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ret=$?
-	if [[ $expect_fail -eq "1" ]]; then
+	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
-		ok $? "Expected fail on ust channel creation $channel_name in $sess_name"
+		ok $? "Enable channel $channel_name for session $sess_name failed as expected"
 	else
 		ok $ret "Enable channel $channel_name for session $sess_name"
 	fi
@@ -541,9 +541,9 @@ function enable_ust_lttng_event ()
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test $ret -ne "0"
-		ok $? "Enable ust event $event_name for session $session_name on channel $channel_name failed as expected"
+		ok $? "Enable ust event $event_name for session $session_name failed as expected"
 	else
-		ok $ret "Enable event $event_name for session $sess_name"
+		ok $ret "Enable ust event $event_name for session $sess_name"
 	fi
 }
 
@@ -745,7 +745,7 @@ function start_lttng_tracing ()
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
-		ok $? "Expected fail on start tracing for session: $sess_name"
+		ok $? "Start tracing for session $sess_name failed as expected"
 	else
 		ok $ret "Start tracing for session $sess_name"
 	fi
@@ -770,7 +770,7 @@ function stop_lttng_tracing ()
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
-		ok $? "Expected fail on stop tracing for session: $sess_name"
+		ok $? "Stop lttng tracing for session $sess_name failed as expected"
 	else
 		ok $ret "Stop lttng tracing for session $sess_name"
 	fi
@@ -795,7 +795,7 @@ function destroy_lttng_session ()
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
-		ok $? "Expected fail on session deletion $sess_name"
+		ok $? "Destroy session $sess_name failed as expected"
 	else
 		ok $ret "Destroy session $sess_name"
 	fi
@@ -829,7 +829,7 @@ function lttng_snapshot_add_output ()
 	ret=$?
 	if [[ $expected_to_fail -eq 1 ]]; then
 		test "$ret" -ne "0"
-		ok $? "Failed to add a  snapshot output file://$trace_path as expected"
+		ok $? "Added snapshot output file://$trace_path failed as expected"
 	else
 		ok $ret "Added snapshot output file://$trace_path"
 	fi
@@ -855,7 +855,7 @@ function lttng_snapshot_del_output ()
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
-		ok $? "Expect fail on deletion of snapshot output id $id"
+		ok $? "Deleted snapshot output id $id failed as expected"
 	else
 		ok $ret "Deleted snapshot output id $id"
 	fi
@@ -893,7 +893,7 @@ function lttng_save()
 	local opts=$2
 
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN save $sess_name $opts 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
-	ok $? "Session successfully saved"
+	ok $? "Session saved"
 }
 
 function lttng_load()
@@ -901,7 +901,7 @@ function lttng_load()
 	local opts=$1
 
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN load $opts 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
-	ok $? "Load command successful"
+	ok $? "Load command with opts: $opts"
 }
 
 function lttng_track()
@@ -914,7 +914,7 @@ function lttng_track()
 		test $ret -ne "0"
 		ok $? "Track command failed as expected with opts: $opts"
 	else
-		ok $ret "Track command success as expected with opts: $opts"
+		ok $ret "Track command with opts: $opts"
 	fi
 }
 
@@ -938,7 +938,7 @@ function lttng_untrack()
 		test $ret -ne "0"
 		ok $? "Untrack command failed as expected with opts: $opts"
 	else
-		ok $ret "Untrack command success as expected with opts: $opts"
+		ok $ret "Untrack command with opts: $opts"
 	fi
 }
 
-- 
2.1.4
