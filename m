From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 1/2] Test: lttng-crash and ust shm
	path
Date: Wed,  9 Sep 2015 13:46:16 -0400
Message-ID: <1441820777-1092-1-git-send-email-jonathan.rajotte-julien__39956.4348896549$1441820883$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZZjSG-0007I3-BI
 for lttng-dev@lists.lttng.org; Wed, 09 Sep 2015 13:46:48 -0400
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

Fixes #916

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac                             |   1 +
 tests/fast_regression                    |   1 +
 tests/regression/tools/Makefile.am       |   2 +-
 tests/regression/tools/crash/Makefile.am |  18 ++
 tests/regression/tools/crash/test_crash  | 400 +++++++++++++++++++++++++++++++
 tests/utils/utils.sh                     |  71 +++++-
 6 files changed, 489 insertions(+), 4 deletions(-)
 create mode 100644 tests/regression/tools/crash/Makefile.am
 create mode 100755 tests/regression/tools/crash/test_crash

diff --git a/configure.ac b/configure.ac
index 06332d3..c8c4389 100644
--- a/configure.ac
+++ b/configure.ac
@@ -617,6 +617,7 @@ AC_CONFIG_FILES([
 	tests/regression/tools/save-load/Makefile
 	tests/regression/tools/mi/Makefile
 	tests/regression/tools/wildcard/Makefile
+	tests/regression/tools/crash/Makefile
 	tests/regression/ust/Makefile
 	tests/regression/ust/nprocesses/Makefile
 	tests/regression/ust/high-throughput/Makefile
diff --git a/tests/fast_regression b/tests/fast_regression
index 420fffb..97f0966 100644
--- a/tests/fast_regression
+++ b/tests/fast_regression
@@ -15,6 +15,7 @@ regression/tools/save-load/test_save
 regression/tools/save-load/test_load
 regression/tools/mi/test_mi
 regression/tools/wildcard/test_event_wildcard
+regression/tools/crash/test_crash
 regression/ust/before-after/test_before_after
 regression/ust/buffers-pid/test_buffers_pid
 regression/ust/multi-session/test_multi_session
diff --git a/tests/regression/tools/Makefile.am b/tests/regression/tools/Makefile.am
index a798de3..bae5b90 100644
--- a/tests/regression/tools/Makefile.am
+++ b/tests/regression/tools/Makefile.am
@@ -1,2 +1,2 @@
 SUBDIRS = streaming filtering health tracefile-limits snapshots live exclusion save-load mi \
-		wildcard
+		wildcard crash
diff --git a/tests/regression/tools/crash/Makefile.am b/tests/regression/tools/crash/Makefile.am
new file mode 100644
index 0000000..627a478
--- /dev/null
+++ b/tests/regression/tools/crash/Makefile.am
@@ -0,0 +1,18 @@
+AM_CPPFLAGS = -I$(top_srcdir)/include
+
+noinst_SCRIPTS = test_crash
+EXTRA_DIST = test_crash
+
+all-local:
+	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
+		for script in $(EXTRA_DIST); do \
+			cp -f $(srcdir)/$$script $(builddir); \
+		done; \
+	fi
+
+clean-local:
+	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
+		for script in $(EXTRA_DIST); do \
+			rm -f $(builddir)/$$script; \
+		done; \
+	fi
diff --git a/tests/regression/tools/crash/test_crash b/tests/regression/tools/crash/test_crash
new file mode 100755
index 0000000..ff5d0e3
--- /dev/null
+++ b/tests/regression/tools/crash/test_crash
@@ -0,0 +1,400 @@
+#!/bin/bash
+#
+# Copyright (C) - 2015 Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
+#
+# This library is free software; you can redistribute it and/or modify it under
+# the terms of the GNU Lesser General Public License as published by the Free
+# Software Foundation; version 2.1 of the License.
+#
+# This library is distributed in the hope that it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
+# details.
+#
+# You should have received a copy of the GNU Lesser General Public License
+# along with this library; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+
+TEST_DESC="LTTng-crash & shm testing"
+
+CURDIR=$(dirname $0)/
+TESTDIR=$CURDIR/../../../
+CRASH_BIN="lttng-crash"
+
+# Test app for ust event
+TESTAPP_PATH="$TESTDIR/utils/testapp"
+TESTAPP_NAME="gen-ust-events"
+TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
+NR_USEC_WAIT=0
+NR_ITER=-1
+
+# Temp file output
+OUTPUT_DIR=$(mktemp -d)
+
+NUM_TESTS=70
+
+source $TESTDIR/utils/utils.sh
+
+# Global declaration for simplification
+LTTNG_CRASH=$TESTDIR/../src/bin/lttng-crash/$CRASH_BIN
+
+# MUST set TESTDIR before calling those functions
+plan_tests $NUM_TESTS
+
+print_test_banner "$TEST_DESC"
+
+function start_test_app()
+{
+	local tmp_file=$(mktemp -u)
+
+	# Start application with a temporary file.
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT $tmp_file &
+	ret=$?
+	APPS_PID="${APPS_PID} ${!}"
+	ok $ret "Start application to trace"
+
+	# Wait for the application file to appear indicating that at least one
+	# tracepoint has been fired.
+	while [ ! -f "$tmp_file" ]; do
+		sleep 0.5
+	done
+	diag "Removing test app temporary file $tmp_file"
+	rm -rf $tmp_file
+}
+
+function stop_test_apps()
+{
+	diag "Stopping $TESTAPP_NAME"
+	for p in ${APPS_PID}; do
+		diag "Stopping $p"
+		kill ${p} 2>/dev/null
+		wait ${p} 2>/dev/null
+		diag "Stopped $p"
+	done
+	APPS_PID=
+}
+
+function stop_test_app()
+{
+	local pid="$1"
+	for p in ${pid}; do
+		diag "Stopping $p"
+		kill ${p} 2>/dev/null
+		wait ${p} 2>/dev/null
+	done
+}
+
+function verify_path_dont_exists()
+{
+	local path=$1
+	local timeout_try_limit=100
+	local timeout_try_count=0
+	local timeout_flag=0
+
+	while find $path -mindepth 1 -maxdepth 1 &>/dev/null ; do
+		if [[ $timeout_try_count -gt $timeout_try_limit ]]; then
+			timeout_flag=1
+			break
+		fi
+		timeout_try_count=$((timeout_try_count+1))
+		sleep 0.1
+	done
+	return $timeout_flag
+}
+
+function test_shm_path_per_pid()
+{
+	diag "Shm: ust per-pid test"
+	local session_name=shm_path_per_pid
+	local channel_name=channel_per_pid
+	local shm_path=$(mktemp -d)
+
+	# Build up
+	start_lttng_sessiond
+	create_lttng_session_ok $session_name $OUTPUT_DIR "--shm-path $shm_path"
+	enable_ust_lttng_channel_ok $session_name $channel_name "--buffers-pid"
+
+	diag "Shm: clean state"
+	file_count=$(find $shm_path -mindepth 1 -maxdepth 1 | wc -l)
+	test $file_count -eq "0"
+	ok $? "No file created on set-up"
+
+	# Look for per-pid folder structure
+	# Start first test app
+	diag "Shm: check folder creation and structure"
+
+	start_test_app
+	first_app_pid=$APPS_PID
+	shm_session_path=$(find $shm_path -mindepth 1 -maxdepth 1)
+
+	file_count=$(echo "$shm_session_path"| wc -l)
+	test $file_count -eq "1"
+	ok $? "Path $shm_session_path created on application creation"
+
+	first_pid_path=$(find $shm_session_path/ust/pid -mindepth 1 -maxdepth 1)
+	ok $? "Pid path exists: $first_pid_path"
+
+	file_count=$(find $shm_session_path/ust/pid -mindepth 1 -maxdepth 1 | wc -l)
+	test $file_count -eq "1"
+	ok $? "Expect 1 pid registration folder got $file_count"
+
+	# Check for buffer and metadata presence in ust/pid/appfolder
+	file_count=$(find $first_pid_path/ -mindepth 1 -maxdepth 1 | wc -l)
+	test $file_count -ne "0"
+	ok $? "Expect > 0 buffer and metadata files got $file_count"
+
+	# Start second application pid
+	diag "Shm: check basic creation of second ust application"
+
+	start_test_app
+	second_pid_path=$(find $shm_session_path/ust/pid -mindepth 1 -maxdepth 1)
+	ok $? "Pid path exist found $second_pid_path"
+
+	file_count=$(find $shm_session_path/ust/pid -mindepth 1 -maxdepth 1 | wc -l)
+	test $file_count -eq "2"
+	ok $? "Expect 2 pid registration folder got $file_count"
+
+	# Stop first test application and check for cleanup
+	stop_test_app "$first_app_pid"
+	verify_path_dont_exists "$first_pid_path"
+	ok $? "First pid cleanup"
+
+	# Stop all applications and check for full cleanup
+	stop_test_apps
+	verify_path_dont_exists "$shm_session_path"
+	ok $? "Full cleanup"
+
+	# Tear down
+	destroy_lttng_session_ok $session_name
+	stop_lttng_sessiond
+	rm -rf $shm_path
+}
+
+function test_shm_path_per_uid()
+{
+	diag "Shm: ust per-uid test"
+	local session_name=shm_path_per_uid
+	local channel_name=channel_per_uid
+	local shm_path=$(mktemp -d)
+
+	# Build up
+	start_lttng_sessiond
+	create_lttng_session_ok $session_name $OUTPUT_DIR "--shm-path $shm_path"
+	enable_ust_lttng_channel_ok $session_name $channel_name "--buffers-uid"
+
+	diag "Shm: test clean state"
+	file_count=$(find $shm_path -mindepth 1 -maxdepth 1 | wc -l)
+	test $file_count -eq "0"
+	ok $? "No files created on set-up"
+
+	# Look for per-pid folder structure
+	# Start first test app
+	diag "Shm: check folder creation and structure"
+
+	start_test_app
+	shm_session_path=$(find $shm_path -mindepth 1 -maxdepth 1)
+	file_count=$(echo "$shm_session_path"| wc -l)
+	test $file_count -eq "1"
+	ok $? "Path $shm_session_path created on application creation"
+
+	uid_path=$(find $shm_session_path/ust/uid -mindepth 1 -maxdepth 1)
+	ok $? "uid path exist found $uid_path"
+
+	file_count=$(find $shm_session_path/ust/uid -mindepth 1 -maxdepth 1 | wc -l)
+	test $file_count -eq "1"
+	ok $? "Expect 1 uid registration folder got $file_count"
+
+	# Stop all applications and check for uid presence
+	stop_test_apps
+	file_count=$(find $shm_session_path/ust/uid -mindepth 1 -maxdepth 1 | wc -l)
+	test $file_count -eq "1"
+	ok $? "Expect 1 uid registration folder got $file_count"
+
+	# Test full cleanup
+	destroy_lttng_session_ok $session_name
+	verify_path_dont_exists "$shm_session_path"
+	ok $? "Full cleanup"
+
+	stop_lttng_sessiond
+	rm -rf $shm_path
+}
+
+function test_lttng_crash()
+{
+	diag "Lttng-crash: basic recuperation"
+	local session_name=crash_test
+	local channel_name=channel_crash
+	local shm_path=$(mktemp -d)
+	local event_name="tp:tptest"
+
+	# Create a session in snapshot mode to deactivate any use of consumerd
+	start_lttng_sessiond
+	create_lttng_session_ok $session_name $OUTPUT_DIR "--shm-path $shm_path --snapshot"
+	enable_ust_lttng_channel_ok $session_name $channel_name "--buffers-uid"
+	enable_ust_lttng_event_ok $session_name $event_name $channel_name
+	start_lttng_tracing_ok $session_name
+
+	# Generate 10 events
+	$TESTAPP_BIN 10 0
+	stop_lttng_tracing
+
+	crash_recup_count=$($LTTNG_CRASH $shm_path | wc -l)
+	test $crash_recup_count -eq "10"
+	ok $? "Expect 10 recup event from buffers got $crash_recup_count"
+
+	# Tear down
+	destroy_lttng_session_ok $session_name
+	stop_lttng_sessiond
+	rm -rf $shm_path
+}
+
+function test_lttng_crash_extraction()
+{
+	diag "Lttng-crash: extraction to path"
+	local session_name=crash_test
+	local channel_name=channel_crash
+	local shm_path=$(mktemp -d)
+	local extraction_dir_path=$(mktemp -d)
+	local extraction_path=$extraction_dir_path/extract
+	local event_name="tp:tptest"
+
+	# Create a session in snapshot mode to deactivate any use of consumerd
+	start_lttng_sessiond
+	create_lttng_session_ok $session_name $OUTPUT_DIR "--shm-path $shm_path --snapshot"
+	enable_ust_lttng_channel_ok $session_name $channel_name "--buffers-uid"
+	enable_ust_lttng_event_ok $session_name $event_name $channel_name
+
+	start_lttng_tracing_ok $session_name
+	# Generate 10 events
+	$TESTAPP_BIN 10 0
+	stop_lttng_tracing
+
+	$LTTNG_CRASH -x $extraction_path $shm_path
+	ok $? "Extraction of crashed buffers to path"
+
+	# Test extracted trace
+	trace_match_only $event_name 10 $extraction_path
+
+	# Tear down
+	destroy_lttng_session_ok $session_name
+	stop_lttng_sessiond
+	rm -rf $shm_path
+	rm -rf $extraction_dir_path
+}
+
+function test_shm_path_per_pid_sigint()
+{
+	diag "Shm: ust per-pid test sigint"
+	local session_name=shm_path_per_pid
+	local channel_name=channel_per_pid
+	local shm_path=$(mktemp -d)
+	local num_files=0
+
+	# Build up
+	start_lttng_sessiond
+	create_lttng_session_ok $session_name $OUTPUT_DIR "--shm-path $shm_path"
+	enable_ust_lttng_channel_ok $session_name $channel_name "--buffers-pid"
+
+	start_test_app
+	start_test_app
+	shm_session_path=$(find $shm_path -mindepth 1 -maxdepth 1)
+
+	# Stop sessiond with sigint
+	stop_lttng_sessiond SIGINT
+
+	# Looking for a full cleanup
+	verify_path_dont_exists "$shm_session_path"
+	ok $? "Full cleanup on sigint"
+
+	# Tear down
+	stop_test_apps
+	rm -rf $shm_path
+}
+
+function test_shm_path_per_uid_sigint()
+{
+	diag "Shm: ust per-uid test sigint"
+	local session_name=shm_path_per_uid_sigint
+	local channel_name=channel_per_uid_sigint
+	local shm_path=$(mktemp -d)
+	local ret=0
+
+	# Build up
+	start_lttng_sessiond
+	create_lttng_session_ok $session_name $OUTPUT_DIR "--shm-path $shm_path"
+	enable_ust_lttng_channel_ok $session_name $channel_name "--buffers-uid"
+
+	start_test_app
+	start_test_app
+	shm_session_path=$(find $shm_path -mindepth 1 -maxdepth 1)
+
+	# Test full cleanup on SIGINT
+	stop_lttng_sessiond SIGINT
+
+	# Looking for a full cleanup
+	verify_path_dont_exists "$shm_session_path"
+	ok $? "Full cleanup on sigint"
+
+	# Tear down
+	stop_test_apps
+	rm -rf $shm_path
+}
+
+function test_lttng_crash_extraction_sigkill()
+{
+	diag "Lttng-crash: extraction with sigkill"
+	local session_name=crash_test
+	local channel_name=channel_crash
+	local shm_path=$(mktemp -d)
+	local extraction_dir_path=$(mktemp -d)
+	local extraction_path=$extraction_dir_path/extract
+	local event_name="tp:tptest"
+	local ret=0
+
+	start_lttng_sessiond
+	create_lttng_session_ok $session_name $OUTPUT_DIR "--shm-path $shm_path"
+	enable_ust_lttng_channel_ok $session_name $channel_name "--buffers-uid"
+	enable_ust_lttng_event_ok $session_name $event_name $channel_name
+	start_lttng_tracing_ok $session_name
+
+	# Generate 10 events
+	$TESTAPP_BIN 10 0
+
+	# Kill the consumers then sessiond with sigkill
+	stop_lttng_consumerd SIGKILL
+	stop_lttng_sessiond SIGKILL
+
+	$LTTNG_CRASH -x $extraction_path $shm_path
+	ret=$?
+	ok $ret "Extraction of crashed buffers to path $extraction_path"
+
+	# Test extracted trace
+	trace_match_only $event_name 10 $extraction_path
+
+	# Tear down
+	stop_test_apps
+	rm -rf $shm_path
+	rm -rf $extraction_dir_path
+}
+
+TESTS=(
+	test_shm_path_per_uid
+	test_shm_path_per_pid
+	test_lttng_crash
+	test_lttng_crash_extraction
+	test_shm_path_per_pid_sigint
+	test_shm_path_per_uid_sigint
+	test_lttng_crash_extraction_sigkill
+)
+
+
+for fct_test in ${TESTS[@]};
+do
+	${fct_test}
+	if [ $? -ne 0 ]; then
+		break;
+	fi
+done
+rm -rf $OUTPUT_DIR
+
+OUTPUT_DEST=/dev/null 2>&1
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index d466ee6..a0c9940 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -387,6 +387,8 @@ function start_lttng_sessiond_notap()
 function stop_lttng_sessiond_opt()
 {
 	local withtap=$1
+	local signal=$2
+	local kill_opt=""
 
 	if [ -n $TEST_NO_SESSIOND ] && [ "$TEST_NO_SESSIOND" == "1" ]; then
 		# Env variable requested no session daemon
@@ -395,7 +397,11 @@ function stop_lttng_sessiond_opt()
 
 	PID_SESSIOND=`pidof lt-$SESSIOND_BIN`
 
-	kill $PID_SESSIOND 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
+	if [ -n "$2" ]; then
+		kill_opt="$kill_opt -s $signal"
+	fi
+
+	kill $kill_opt $PID_SESSIOND 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 
 	if [ $? -eq 1 ]; then
 		if [ $withtap -eq "1" ]; then
@@ -428,6 +434,63 @@ function stop_lttng_sessiond_notap()
 	stop_lttng_sessiond_opt 0 "$@"
 }
 
+function stop_lttng_consumerd_opt()
+{
+	local withtap=$1
+	local signal=$2
+	local kill_opt=""
+
+	PID_CONSUMERD=`pidof $CONSUMERD_BIN`
+
+	if [ -n "$2" ]; then
+		kill_opt="$kill_opt -s $signal"
+	fi
+
+	if [ $withtap -eq "1" ]; then
+		diag "Killing lttng-consumerd (pid: $PID_CONSUMERD)"
+	fi
+	kill $kill_opt $PID_CONSUMERD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
+	retval=$?
+	set +x
+
+	if [ $? -eq 1 ]; then
+		if [ $withtap -eq "1" ]; then
+			fail "Kill consumer daemon"
+		fi
+		return 1
+	else
+		out=1
+		while [ $out -ne 0 ]; do
+			pid=$(pidof $CONSUMERD_BIN)
+
+			# If consumerds are still present check their status.
+			# A zombie status qualifies the consumerd as *killed*
+			out=0
+			for consumer_pid in $pid; do
+				state=$(ps -p $consumer_pid -o state= )
+				if [[ -n "$state" && "$state" != "Z" ]]; then
+					out=1
+				fi
+			done
+			sleep 0.5
+		done
+		if [ $withtap -eq "1" ]; then
+			pass "Kill consumer daemon"
+		fi
+	fi
+	return $retval
+}
+
+function stop_lttng_consumerd()
+{
+	stop_lttng_consumerd_opt 1 "$@"
+}
+
+function stop_lttng_consumerd_notap()
+{
+	stop_lttng_consumerd_opt 0 "$@"
+}
+
 function list_lttng_with_opts ()
 {
 	local opts=$1
@@ -448,8 +511,9 @@ function create_lttng_session ()
 	local expected_to_fail=$1
 	local sess_name=$2
 	local trace_path=$3
+	local opt=$4
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN create $sess_name -o $trace_path > $OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN create $sess_name -o $trace_path $opt > $OUTPUT_DEST
 	ret=$?
 	if [[ $expected_to_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
@@ -475,8 +539,9 @@ function enable_ust_lttng_channel ()
 	local expect_fail=$1
 	local sess_name=$2
 	local channel_name=$3
+	local opt=$4
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -u $channel_name -s $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -u $channel_name -s $sess_name $opt 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	ret=$?
 	if [[ $expect_fail -eq "1" ]]; then
 		test "$ret" -ne "0"
-- 
2.1.4
