From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 2/3] Tests: Add the tracefile count
	test
Date: Tue, 14 May 2013 17:53:46 -0400
Message-ID: <1368568427-8289-2-git-send-email-christian.babeux__7714.62738416648$1368568494$gmane$org@efficios.com>
References: <1368568427-8289-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UcNAZ-0005uY-V5
	for lttng-dev@lists.lttng.org; Tue, 14 May 2013 17:54:04 -0400
Received: by mail-ve0-f169.google.com with SMTP id jw11so986833veb.14
	for <lttng-dev@lists.lttng.org>; Tue, 14 May 2013 14:53:58 -0700 (PDT)
In-Reply-To: <1368568427-8289-1-git-send-email-christian.babeux@efficios.com>
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

This test validate the newly introduced tracefile count feature.
In order to so, we enable a channel with the appropriate limits in
overwrite mode. The later constraint is to ensure that at least the
last few events are properly recorded and that we can validate that
they are present in the resulting trace (with the help of babeltrace
and babelstats).

We also validate that the tracefile count (per stream) in the trace
folder is conform to the one passed on the command line.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 configure.ac                                       |   1 +
 tests/fast_regression                              |   1 +
 tests/long_regression                              |   1 +
 .../regression/tools/tracefile-limits/Makefile.am  |   2 +
 .../tools/tracefile-limits/test_tracefile_count    | 174 +++++++++++++++++++++
 5 files changed, 179 insertions(+)
 create mode 100644 tests/regression/tools/tracefile-limits/Makefile.am
 create mode 100644 tests/regression/tools/tracefile-limits/test_tracefile_count

diff --git a/configure.ac b/configure.ac
index 9f14c12..9bb5e67 100644
--- a/configure.ac
+++ b/configure.ac
@@ -323,6 +323,7 @@ AC_CONFIG_FILES([
 	tests/regression/tools/streaming/Makefile
 	tests/regression/tools/filtering/Makefile
 	tests/regression/tools/health/Makefile
+	tests/regression/tools/tracefile-limits/Makefile
 	tests/regression/ust/Makefile
 	tests/regression/ust/nprocesses/Makefile
 	tests/regression/ust/high-throughput/Makefile
diff --git a/tests/fast_regression b/tests/fast_regression
index e6a883b..db26f1c 100644
--- a/tests/fast_regression
+++ b/tests/fast_regression
@@ -5,6 +5,7 @@ regression/tools/health/test_thread_exit
 regression/tools/health/test_thread_stall
 regression/tools/health/test_tp_fail
 regression/tools/streaming/test_ust
+regression/tools/tracefile-limits/test_tracefile_count
 regression/ust/before-after/test_before_after
 regression/ust/buffers-uid/test_buffers_uid
 regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
diff --git a/tests/long_regression b/tests/long_regression
index c198178..3780bd4 100644
--- a/tests/long_regression
+++ b/tests/long_regression
@@ -5,6 +5,7 @@ regression/tools/health/test_thread_exit
 regression/tools/health/test_thread_stall
 regression/tools/health/test_tp_fail
 regression/tools/streaming/test_ust
+regression/tools/tracefile-limits/test_tracefile_count
 regression/ust/before-after/test_before_after
 regression/ust/buffers-uid/test_buffers_uid
 regression/ust/high-throughput/test_high_throughput
diff --git a/tests/regression/tools/tracefile-limits/Makefile.am b/tests/regression/tools/tracefile-limits/Makefile.am
new file mode 100644
index 0000000..441d2bd
--- /dev/null
+++ b/tests/regression/tools/tracefile-limits/Makefile.am
@@ -0,0 +1,2 @@
+noinst_SCRIPTS = test_tracefile_count
+EXTRA_DIST = test_tracefile_count
diff --git a/tests/regression/tools/tracefile-limits/test_tracefile_count b/tests/regression/tools/tracefile-limits/test_tracefile_count
new file mode 100644
index 0000000..41b89f0
--- /dev/null
+++ b/tests/regression/tools/tracefile-limits/test_tracefile_count
@@ -0,0 +1,174 @@
+#!/bin/bash
+#
+# Copyright (C) - 2013 Christian Babeux <christian.babeux@efficios.com>
+#
+# This library is free software; you can redistribute it and/or modify it under
+# the terms of the GNU Lesser General Public License as published by the Free
+# Software Foundation; version 2.1 of the License.
+#
+# This library is distributed in the hope that it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
+# details.
+#
+# You should have received a copy of the GNU Lesser General Public License
+# along with this library; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+
+TEST_DESC="Tracefile count limits"
+
+CURDIR=$(dirname $0)/
+TESTDIR=$CURDIR/../../..
+
+TESTAPP_PATH="$TESTDIR/utils/testapp"
+TESTAPP_NAME="gen-ust-events"
+TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
+
+STATS_BIN="$TESTDIR/utils/babelstats.pl"
+NUM_TESTS=146
+
+source $TESTDIR/utils/utils.sh
+
+if [ ! -x "$TESTAPP_BIN" ]; then
+	BAIL_OUT "No UST events binary detected."
+fi
+
+function wait_apps
+{
+	while [ -n "$(pidof $TESTAPP_NAME)" ]; do
+		sleep 0.5
+	done
+	pass "Wait for applications to end"
+}
+
+function enable_lttng_channel_count_limit ()
+{
+	sess_name="$1"
+	channel_name="$2"
+	tracefile_count_limit="$3"
+
+	test_name="Enable channel $channel_name "
+	test_name+="for session $sess_name: "
+	test_name+="$tracefile_count_limit tracefiles"
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel \
+	    -u $channel_name -s $sess_name \
+	    -C 4096 -W $tracefile_count_limit \
+	    --overwrite >/dev/null 2>&1
+
+	ok $? "$test_name"
+}
+
+function enable_ust_lttng_event_per_channel ()
+{
+	sess_name="$1"
+	event_name="$2"
+	channel_name="$3"
+
+	test_name="Enable event $event_name "
+	test_name+="for session $sess_name "
+	test_name+="in channel $channel_name"
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" \
+	    -s $sess_name -u -c $channel_name >/dev/null 2>&1
+
+	ok $? "$test_name"
+}
+
+function validate_min_max
+{
+	stats="$1"
+	field="$2"
+	expected_min="$3"
+	expected_max="$4"
+
+	echo $stats | grep -q -E "$field $expected_min $expected_max"
+	return $?
+}
+
+function validate_file_count
+{
+	path="$1"
+	file_pattern="$2"
+	expected_max_count="$3"
+
+	count=`find $path -name "$file_pattern" -type f | wc -l`
+
+	if [ "$count" -gt "$expected_max_count" ]; then
+	    fail "Validate file count: $file_pattern"
+	    diag "File count: $count expected: $expected_max_count"
+	else
+	    pass "Validate file count: $file_pattern"
+	fi
+}
+
+function test_tracefile_count_limit ()
+{
+	count_limit="$1"
+	trace_path=$(mktemp -d)
+	session_name=$(randstring 16 0)
+	channel_name="channel"
+	event_name="tp:tptest"
+	num_iter=1000
+	expected_max=$(($num_iter - 1))
+
+	diag "Test tracefile count limit : $count_limit tracefiles"
+
+	create_lttng_session $session_name $trace_path
+
+	enable_lttng_channel_count_limit \
+	    $session_name $channel_name $count_limit
+
+	enable_ust_lttng_event_per_channel \
+	    $session_name $event_name $channel_name
+
+	start_lttng_tracing $session_name
+
+	$TESTAPP_BIN $num_iter >/dev/null 2>&1 &
+
+	wait_apps
+
+	stop_lttng_tracing $session_name
+
+	destroy_lttng_session $session_name
+
+	# Validate tracing dir
+
+	num_cpu=`nproc`
+
+	for cpuno in $(seq 0 $(($num_cpu - 1)))
+	do
+		validate_file_count \
+		    $trace_path "${channel_name}_${cpuno}_*" $count_limit
+	done
+
+	# Validate tracing data
+
+	stats=`babeltrace $trace_path | $STATS_BIN --tracepoint $event_name`
+
+	validate_min_max "$stats" "intfield" "[0-9]+" "$expected_max"
+	ok $? "Trace validation - intfield"
+
+	validate_min_max "$stats" "netintfield" "[0-9]+" "$expected_max"
+	ok $? "Trace validation - netintfield"
+
+	validate_min_max "$stats" "longfield" "[0-9]+" "$expected_max"
+	ok $? "Trace validation - longfield"
+
+	rm -rf $trace_path
+}
+
+plan_tests $NUM_TESTS
+
+print_test_banner "$TEST_DESC"
+
+start_lttng_sessiond
+
+LIMITS=("1" "2" "4" "8" "10" "16" "32" "64")
+
+for limit in ${LIMITS[@]};
+do
+	test_tracefile_count_limit $limit
+done
+
+stop_lttng_sessiond
-- 
1.8.2.2
