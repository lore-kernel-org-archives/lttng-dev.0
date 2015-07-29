From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: tests: stderr not correctly
	redirected
Date: Wed, 29 Jul 2015 17:57:52 -0400
Message-ID: <1438207072-1122-1-git-send-email-jonathan.rajotte-julien__47056.4798721627$1438207180$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZKZMX-0008Lj-9c
 for lttng-dev@lists.lttng.org; Wed, 29 Jul 2015 17:58:19 -0400
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
 tests/utils/utils.sh | 75 ++++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index 4282fbb..ba0b10e 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -20,7 +20,8 @@ CONSUMERD_BIN="lttng-consumerd"
 RELAYD_BIN="lttng-relayd"
 LTTNG_BIN="lttng"
 BABELTRACE_BIN="babeltrace"
-OUTPUT_DEST=/dev/null 2>&1
+OUTPUT_DEST=/dev/null
+ERROR_OUTPUT_DEST=/dev/null
 
 # Minimal kernel version supported for session daemon tests
 KERNEL_MAJOR_VERSION=2
@@ -103,7 +104,7 @@ function lttng_enable_kernel_event
 		chan="-c $channel_name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -k >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -k 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Enable kernel event $event_name for session $sess_name"
 }
 
@@ -126,7 +127,7 @@ function lttng_enable_kernel_syscall()
 		chan="-c $channel_name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --syscall "$syscall_name" $chan -s $sess_name -k >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --syscall "$syscall_name" $chan -s $sess_name -k 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test $ret -ne "0"
@@ -165,7 +166,7 @@ function lttng_disable_kernel_syscall()
 		chan="-c $channel_name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event --syscall "$syscall_name" $chan -s $sess_name -k >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event --syscall "$syscall_name" $chan -s $sess_name -k 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
@@ -192,7 +193,7 @@ function lttng_enable_kernel_channel()
 	local sess_name=$2
 	local channel_name=$3
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -k $channel_name -s $sess_name >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -k $channel_name -s $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
@@ -218,7 +219,7 @@ function lttng_disable_kernel_channel()
 	local sess_name=$2
 	local channel_name=$3
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-channel -k $channel_name -s $sess_name >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-channel -k $channel_name -s $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
@@ -245,7 +246,7 @@ function start_lttng_relayd
 	DIR=$(readlink -f $TESTDIR)
 
 	if [ -z $(pidof lt-$RELAYD_BIN) ]; then
-		$DIR/../src/bin/lttng-relayd/$RELAYD_BIN -b $opt >$OUTPUT_DEST
+		$DIR/../src/bin/lttng-relayd/$RELAYD_BIN -b $opt 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 		#$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt -vvv >>/tmp/relayd.log 2>&1 &
 		if [ $? -eq 1 ]; then
 			fail "Start lttng-relayd (opt: $opt)"
@@ -263,7 +264,7 @@ function stop_lttng_relayd_nocheck
 	PID_RELAYD=`pidof lt-$RELAYD_BIN`
 
 	diag "Killing lttng-relayd (pid: $PID_RELAYD)"
-	kill $PID_RELAYD >$OUTPUT_DEST
+	kill $PID_RELAYD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	retval=$?
 
 	if [ $retval -eq 1 ]; then
@@ -331,7 +332,7 @@ function stop_lttng_sessiond ()
 
 	PID_SESSIOND=`pidof lt-$SESSIOND_BIN`
 
-	kill $PID_SESSIOND >$OUTPUT_DEST
+	kill $PID_SESSIOND 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 
 	if [ $? -eq 1 ]; then
 		fail "Kill sessions daemon"
@@ -354,7 +355,7 @@ function stop_lttng_sessiond ()
 function list_lttng_with_opts ()
 {
 	local opts=$1
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN list $opts >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN list $opts 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Lttng-tool list command with option $opts"
 }
 
@@ -362,7 +363,7 @@ function create_lttng_session_no_output ()
 {
 	local sess_name=$1
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN create $sess_name --no-output >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN create $sess_name --no-output 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Create session $sess_name in no-output mode"
 }
 
@@ -399,7 +400,7 @@ function enable_ust_lttng_channel ()
 	local sess_name=$2
 	local channel_name=$3
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -u $channel_name -s $sess_name >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -u $channel_name -s $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ret=$?
 	if [[ $expect_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
@@ -424,7 +425,7 @@ function disable_ust_lttng_channel()
 	local sess_name=$1
 	local channel_name=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-channel -u $channel_name -s $sess_name >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-channel -u $channel_name -s $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Disable channel $channel_name for session $sess_name"
 }
 
@@ -433,7 +434,7 @@ function enable_lttng_mmap_overwrite_kernel_channel()
 	local sess_name=$1
 	local channel_name=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -s $sess_name $channel_name -k --output mmap --overwrite >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -s $sess_name $channel_name -k --output mmap --overwrite 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Enable channel $channel_name for session $sess_name"
 }
 
@@ -442,7 +443,7 @@ function enable_lttng_mmap_overwrite_ust_channel()
 	local sess_name=$1
 	local channel_name=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -s $sess_name $channel_name -u --output mmap --overwrite >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -s $sess_name $channel_name -u --output mmap --overwrite 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Enable channel $channel_name for session $sess_name"
 }
 
@@ -460,7 +461,7 @@ function enable_ust_lttng_event ()
 		chan="-c $channel_name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -u >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -u 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test $ret -ne "0"
@@ -493,7 +494,7 @@ function enable_jul_lttng_event()
 		chan="-c $channel_name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -j >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -j 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Enable JUL event $event_name for session $sess_name"
 }
 
@@ -511,7 +512,7 @@ function enable_jul_lttng_event_loglevel()
 		chan="-c $channel_name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel $loglevel "$event_name" $chan -s $sess_name -j >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel $loglevel "$event_name" $chan -s $sess_name -j 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Enable JUL event $event_name for session $sess_name with loglevel $loglevel"
 }
 
@@ -528,7 +529,7 @@ function enable_log4j_lttng_event()
 		chan="-c $channel_name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -l >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -l 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Enable LOG4J event $event_name for session $sess_name"
 }
 
@@ -546,7 +547,7 @@ function enable_log4j_lttng_event_loglevel()
 		chan="-c $channel_name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel $loglevel "$event_name" $chan -s $sess_name -l >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel $loglevel "$event_name" $chan -s $sess_name -l 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Enable LOG4J event $event_name for session $sess_name with loglevel $loglevel"
 }
 
@@ -563,7 +564,7 @@ function enable_python_lttng_event()
 		chan="-c $channel_name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -p >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -p 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Enable Python event $event_name for session $sess_name"
 }
 
@@ -581,7 +582,7 @@ function enable_python_lttng_event_loglevel()
 		chan="-c $channel_name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel $loglevel "$event_name" $chan -s $sess_name -p >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel $loglevel "$event_name" $chan -s $sess_name -p 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Enable Python event $event_name for session $sess_name with loglevel $loglevel"
 }
 
@@ -591,7 +592,7 @@ function enable_ust_lttng_event_filter()
 	local event_name="$2"
 	local filter="$3"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -s $sess_name -u --filter "$filter" >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -s $sess_name -u --filter "$filter" 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Enable event $event_name with filtering for session $sess_name"
 }
 
@@ -601,7 +602,7 @@ function enable_ust_lttng_event_loglevel()
 	local event_name="$2"
 	local loglevel="$3"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -s $sess_name -u --loglevel $loglevel >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -s $sess_name -u --loglevel $loglevel 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Enable event $event_name with loglevel $loglevel"
 }
 
@@ -611,7 +612,7 @@ function enable_ust_lttng_event_loglevel_only()
 	local event_name="$2"
 	local loglevel="$3"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -s $sess_name -u --loglevel-only $loglevel >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -s $sess_name -u --loglevel-only $loglevel 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Enable event $event_name with loglevel-only $loglevel"
 }
 
@@ -628,7 +629,7 @@ function disable_ust_lttng_event ()
 		chan="-c $channel_name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event "$event_name" -s $sess_name $chan -u >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event "$event_name" -s $sess_name $chan -u 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Disable event $event_name for session $sess_name"
 }
 
@@ -655,7 +656,7 @@ function disable_python_lttng_event ()
 	local sess_name="$1"
 	local event_name="$2"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event "$event_name" -s $sess_name -p >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event "$event_name" -s $sess_name -p 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Disable Python event $event_name for session $sess_name"
 }
 
@@ -664,7 +665,7 @@ function start_lttng_tracing ()
 	local expected_to_fail=$1
 	local sess_name=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN start $sess_name >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN start $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
@@ -689,7 +690,7 @@ function stop_lttng_tracing ()
 	local expected_to_fail=$1
 	local sess_name=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN stop $sess_name >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN stop $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
@@ -714,7 +715,7 @@ function destroy_lttng_session ()
 	local expected_to_fail=$1
 	local sess_name=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN destroy $sess_name >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN destroy $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
@@ -738,7 +739,7 @@ function destroy_lttng_session_fail ()
 
 function destroy_lttng_sessions ()
 {
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN destroy --all >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN destroy --all 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Destroy all lttng sessions"
 }
 
@@ -748,7 +749,7 @@ function lttng_snapshot_add_output ()
 	local sess_name=$2
 	local trace_path=$3
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot add-output -s $sess_name file://$trace_path >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot add-output -s $sess_name file://$trace_path 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ret=$?
 	if [[ $expected_to_fail -eq 1 ]]; then
 		test "$ret" -ne "0"
@@ -774,7 +775,7 @@ function lttng_snapshot_del_output ()
 	local sess_name=$2
 	local id=$3
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot del-output -s $sess_name $id >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot del-output -s $sess_name $id 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
@@ -799,14 +800,14 @@ function lttng_snapshot_record ()
 	local sess_name=$1
 	local trace_path=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot record -s $sess_name >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot record -s $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Snapshot recorded"
 }
 
 function lttng_snapshot_list ()
 {
 	local sess_name=$1
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot list-output -s $sess_name >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot list-output -s $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Snapshot list"
 }
 
@@ -815,7 +816,7 @@ function lttng_save()
 	local sess_name=$1
 	local opts=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN save $sess_name $opts >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN save $sess_name $opts 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Session successfully saved"
 }
 
@@ -823,7 +824,7 @@ function lttng_load()
 {
 	local opts=$1
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN load $opts >$OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN load $opts 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ok $? "Load command successful"
 }
 
-- 
2.1.4
