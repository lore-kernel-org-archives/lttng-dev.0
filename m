From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 3/3] Tests: Add the tracefile size
	test
Date: Tue, 14 May 2013 17:53:47 -0400
Message-ID: <1368568427-8289-3-git-send-email-christian.babeux__10695.4323863194$1368568510$gmane$org@efficios.com>
References: <1368568427-8289-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UcNAe-0005vd-Rq
	for lttng-dev@lists.lttng.org; Tue, 14 May 2013 17:54:08 -0400
Received: by mail-ve0-f170.google.com with SMTP id 14so1325857vea.29
	for <lttng-dev@lists.lttng.org>; Tue, 14 May 2013 14:54:03 -0700 (PDT)
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
In order to so, we enable a channel with the appropriate file size limits.

After running an instrumented application, we validate that each file in
the trace folder is no larger than the limit set on the command line and
also that some events are present (it's possible that the tracer discard
events, so we can't validate on a fixed number of events in the resulting
trace).

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/fast_regression                              |   1 +
 tests/long_regression                              |   2 +
 .../regression/tools/tracefile-limits/Makefile.am  |   4 +-
 .../tools/tracefile-limits/test_tracefile_size     | 154 +++++++++++++++++++++
 4 files changed, 159 insertions(+), 2 deletions(-)
 create mode 100644 tests/regression/tools/tracefile-limits/test_tracefile_size

diff --git a/tests/fast_regression b/tests/fast_regression
index db26f1c..a7ba925 100644
--- a/tests/fast_regression
+++ b/tests/fast_regression
@@ -6,6 +6,7 @@ regression/tools/health/test_thread_stall
 regression/tools/health/test_tp_fail
 regression/tools/streaming/test_ust
 regression/tools/tracefile-limits/test_tracefile_count
+regression/tools/tracefile-limits/test_tracefile_size
 regression/ust/before-after/test_before_after
 regression/ust/buffers-uid/test_buffers_uid
 regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
diff --git a/tests/long_regression b/tests/long_regression
index 3780bd4..246259a 100644
--- a/tests/long_regression
+++ b/tests/long_regression
@@ -6,8 +6,10 @@ regression/tools/health/test_thread_stall
 regression/tools/health/test_tp_fail
 regression/tools/streaming/test_ust
 regression/tools/tracefile-limits/test_tracefile_count
+regression/tools/tracefile-limits/test_tracefile_size
 regression/ust/before-after/test_before_after
 regression/ust/buffers-uid/test_buffers_uid
+regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
 regression/ust/high-throughput/test_high_throughput
 regression/ust/low-throughput/test_low_throughput
 regression/ust/multi-session/test_multi_session
diff --git a/tests/regression/tools/tracefile-limits/Makefile.am b/tests/regression/tools/tracefile-limits/Makefile.am
index 441d2bd..f6ca236 100644
--- a/tests/regression/tools/tracefile-limits/Makefile.am
+++ b/tests/regression/tools/tracefile-limits/Makefile.am
@@ -1,2 +1,2 @@
-noinst_SCRIPTS = test_tracefile_count
-EXTRA_DIST = test_tracefile_count
+noinst_SCRIPTS = test_tracefile_count test_tracefile_size
+EXTRA_DIST = test_tracefile_count test_tracefile_size
diff --git a/tests/regression/tools/tracefile-limits/test_tracefile_size b/tests/regression/tools/tracefile-limits/test_tracefile_size
new file mode 100644
index 0000000..99301b5
--- /dev/null
+++ b/tests/regression/tools/tracefile-limits/test_tracefile_size
@@ -0,0 +1,154 @@
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
+TEST_DESC="Tracefile size limits"
+
+CURDIR=$(dirname $0)/
+TESTDIR=$CURDIR/../../..
+
+NR_ITER=1000
+
+TESTAPP_PATH="$TESTDIR/utils/testapp"
+TESTAPP_NAME="gen-ust-events"
+TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
+
+NUM_TESTS=47
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
+function enable_lttng_channel_size_limit ()
+{
+	sess_name="$1"
+	channel_name="$2"
+	tracefile_size_limit="$3"
+
+	test_name="Enable channel $channel_name "
+	test_name+="for session $sess_name: "
+	test_name+="$tracefile_size_limit bytes tracefile limit"
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel \
+	    -u $channel_name -s $sess_name \
+	    -C $tracefile_size_limit >/dev/null 2>&1
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
+function check_file_size ()
+{
+	path="$1"
+	file_pattern="$2"
+	expected_max_size="$3"
+
+	find $path -name "$file_pattern" -exec stat -c '%n %s' {} \; \
+	    | while read file_info;
+	do
+		name=$(echo $file_info | cut -f1 -d ' ')
+		size=$(echo $file_info | cut -f2 -d ' ')
+
+		if [ "$size" -gt "$expected_max_size" ]; then
+			diag_msg="file: $name size: $size"
+			diag_msg+="expected maximum size: $expected_max_size"
+			diag "$diag_msg"
+			exit 1
+		fi
+	done
+
+	ok $? "File size validation"
+}
+
+function test_tracefile_size_limit ()
+{
+	size_limit="$1"
+	trace_path=$(mktemp -d)
+	session_name=$(randstring 16 0)
+	channel_name="channel"
+	event_name="tp:tptest"
+
+	diag "Test tracefile size limit : $size_limit bytes"
+
+	create_lttng_session $session_name $trace_path
+
+	enable_lttng_channel_size_limit \
+	    $session_name $channel_name $size_limit
+
+	enable_ust_lttng_event_per_channel \
+	    $session_name $event_name $channel_name
+
+	start_lttng_tracing $session_name
+
+	$TESTAPP_BIN $NR_ITER >/dev/null 2>&1 &
+
+	wait_apps
+
+	stop_lttng_tracing $session_name
+
+	destroy_lttng_session $session_name
+
+	# Validate file size, each one shall be no larger than the
+	# specified size limit
+
+	check_file_size $trace_path "${channel_name}_*" $size_limit
+
+	# Validate tracing data, we should at least have some events
+
+	validate_trace $event_name $trace_path
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
+LIMITS=("4096" "8192" "16384" "32768" "65536")
+
+for limit in ${LIMITS[@]};
+do
+	test_tracefile_size_limit $limit
+done
+
+stop_lttng_sessiond
-- 
1.8.2.2
