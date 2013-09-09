From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 1/2] Tests: Add UST snapshots list
	output and max-size tests
Date: Mon,  9 Sep 2013 18:09:38 -0400
Message-ID: <1378764579-11692-1-git-send-email-christian.babeux__3252.3448383019$1378764653$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VJ9ec-0008Rz-0A
	for lttng-dev@lists.lttng.org; Mon, 09 Sep 2013 18:10:00 -0400
Received: by mail-qc0-f170.google.com with SMTP id m20so1167579qcx.29
	for <lttng-dev@lists.lttng.org>; Mon, 09 Sep 2013 15:09:48 -0700 (PDT)
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

Add two new tests to the UST snapshots tests:

test_ust_list_output:
Add/remove named outputs and validate with the list output command.

test_ust_local_snapshot_max_size:
Take a UST snapshot with max-size limits and validate that they are respected.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/regression/tools/snapshots/test_ust | 140 ++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 6 deletions(-)

diff --git a/tests/regression/tools/snapshots/test_ust b/tests/regression/tools/snapshots/test_ust
index c88e98a..bd2521c 100755
--- a/tests/regression/tools/snapshots/test_ust
+++ b/tests/regression/tools/snapshots/test_ust
@@ -30,7 +30,7 @@ NR_USEC_WAIT=100
 
 TRACE_PATH=$(mktemp -d)
 
-NUM_TESTS=2053
+NUM_TESTS=2075
 
 source $TESTDIR/utils/utils.sh
 
@@ -38,6 +38,83 @@ if [ ! -x "$TESTAPP_BIN" ]; then
 	BAIL_OUT "No UST events binary detected."
 fi
 
+function snapshot_add_output ()
+{
+	local sess_name=$1
+	local trace_path=$2
+	local name=$3
+	local max_size=$4
+	local extra_opt=""
+
+	if [ ! -z $name ]; then
+		extra_opt+=" -n $name "
+	fi
+
+	if [ ! -z $max_size ]; then
+		extra_opt+=" -m $max_size "
+	fi
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot add-output \
+		-s $sess_name $extra_opt $trace_path > /dev/null 2>&1
+
+	ok $? "Added snapshot output $trace_path ($extra_opt)"
+}
+
+function snapshot_del_output ()
+{
+	local sess_name=$1
+	local name=$2
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot del-output \
+		-s $sess_name $name > /dev/null 2>&1
+
+	ok $? "Deleted snapshot output named $name"
+}
+
+function enable_mmap_overwrite_subbuf_ust_channel ()
+{
+	local sess_name=$1
+	local chan_name=$2
+	local subbuf_size=$3
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -s $sess_name \
+		$chan_name -u --output mmap --overwrite \
+		--subbuf-size $subbuf_size > /dev/null 2>&1
+
+	ok $? "Enable channel $channel_name for session $sess_name with subbuf size $subbuf_size"
+}
+
+
+function test_ust_list_output ()
+{
+	output_names=("randomname" "somesnapshot")
+
+	diag "Test UST snapshot output listing"
+	create_lttng_session_no_output $SESSION_NAME
+	enable_lttng_mmap_overwrite_ust_channel $SESSION_NAME $CHANNEL_NAME
+	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME $CHANNEL_NAME
+
+	start_lttng_tracing $SESSION_NAME
+
+	snapshot_add_output $SESSION_NAME "file://$TRACE_PATH" ${output_names[0]}
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot list-output \
+		-s $SESSION_NAME 2>&1 | grep ${output_names[0]} > /dev/null
+	ok $? "Snapshot named ${output_names[0]} present in list-output listing"
+
+	snapshot_del_output $SESSION_NAME ${output_names[0]}
+
+	snapshot_add_output $SESSION_NAME "file://$TRACE_PATH" ${output_names[1]}
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot list-output \
+		-s $SESSION_NAME 2>&1 | grep ${output_names[1]} > /dev/null
+
+	ok $? "Snapshot named ${output_names[1]} present in list-output listing"
+
+	stop_lttng_tracing $SESSION_NAME
+	destroy_lttng_session $SESSION_NAME
+}
+
 function test_ust_local_snapshot ()
 {
 	diag "Test local UST snapshots"
@@ -65,6 +142,56 @@ function test_ust_local_snapshot ()
 	kill $PID_APP >/dev/null 2>&1
 }
 
+function test_ust_local_snapshot_max_size ()
+{
+	subbuf_size=8192
+	num_cpus=`nproc`
+
+	# The minimum size limit is min(subbuf_size) * nb_streams
+	max_size=$(($subbuf_size*$num_cpus))
+
+	diag "Test local UST snapshots with max size $max_size"
+	create_lttng_session_no_output $SESSION_NAME
+
+	enable_mmap_overwrite_subbuf_ust_channel $SESSION_NAME $CHANNEL_NAME $subbuf_size
+
+	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME $CHANNEL_NAME
+	start_lttng_tracing $SESSION_NAME
+
+	snapshot_add_output $SESSION_NAME "file://$TRACE_PATH" "" $max_size
+
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT &
+	ok $? "Start application to trace"
+
+	lttng_snapshot_record $SESSION_NAME
+
+	# Check file size
+	sum_size_tracefiles=$(find $TRACE_PATH -name "${CHANNEL_NAME}_*" \
+		-exec stat -c '%s' {} \; | awk '{s = s + $1}END{print s}')
+
+	if [ "$sum_size_tracefiles" -gt "$max_size" ]; then
+		fail "Tracefiles size sum validation"
+		diag "Tracefiles size sum: $sum_size_tracefiles Expected max: $max_size"
+	fi
+
+	pass "Tracefiles size sum validation"
+
+	stop_lttng_tracing $SESSION_NAME
+	destroy_lttng_session $SESSION_NAME
+
+	# Validate test
+	validate_trace $EVENT_NAME $TRACE_PATH/
+
+	if [ $? -eq 0 ]; then
+		# Only delete if successful
+		rm -rf $TRACE_PATH
+	fi
+
+	diag "Killing $TESTAPP_NAME"
+	PID_APP=`pidof $TESTAPP_NAME`
+	kill $PID_APP >/dev/null 2>&1
+}
+
 function test_ust_local_snapshot_large_metadata ()
 {
 	LM_EVENT="tp:tptest1,tp:tptest2,tp:tptest3,tp:tptest4,tp:tptest5"
@@ -200,17 +327,18 @@ fi
 
 start_lttng_sessiond
 
-tests=( test_ust_local_snapshot \
-	test_ust_per_uid_local_snapshot \
-	test_ust_per_uid_local_snapshot_post_mortem \
-	test_ust_local_snapshot_large_metadata \
+tests=( test_ust_list_output
+	test_ust_local_snapshot
+	test_ust_local_snapshot_max_size
+	test_ust_per_uid_local_snapshot
+	test_ust_per_uid_local_snapshot_post_mortem
+	test_ust_local_snapshot_large_metadata
 	test_ust_1000_local_snapshots )
 
 for fct_test in ${tests[@]};
 do
 	SESSION_NAME=$(randstring 16 0)
 	${fct_test}
-
 done
 
 stop_lttng_sessiond
-- 
1.8.4
