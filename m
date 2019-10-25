From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 4/5] Tests: base path: lttng load
 for session configuration
Date: Fri, 25 Oct 2019 18:12:03 -0400
Message-ID: <20191025221204.29696-4-jonathan.rajotte-julien__48850.9274249495$1572041671$gmane$org@efficios.com>
References: <20191025221204.29696-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 470JJ00fj7z1PYH
 for <lttng-dev@lists.lttng.org>; Fri, 25 Oct 2019 18:12:16 -0400 (EDT)
In-Reply-To: <20191025221204.29696-1-jonathan.rajotte-julien@efficios.com>
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 .../base-path/load-stream-extra-path.lttng    | 66 +++++++++++++++++++
 tests/regression/tools/base-path/test_ust     | 29 +++++++-
 2 files changed, 92 insertions(+), 3 deletions(-)
 create mode 100644 tests/regression/tools/base-path/load-stream-extra-path.lttng

diff --git a/tests/regression/tools/base-path/load-stream-extra-path.lttng b/tests/regression/tools/base-path/load-stream-extra-path.lttng
new file mode 100644
index 000000000..973d67a6d
--- /dev/null
+++ b/tests/regression/tools/base-path/load-stream-extra-path.lttng
@@ -0,0 +1,66 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<sessions>
+	<session>
+		<name>load-stream-extra-path</name>
+		<domains>
+			<domain>
+				<type>UST</type>
+				<buffer_type>PER_UID</buffer_type>
+				<channels>
+					<channel>
+						<name>channel0</name>
+						<enabled>true</enabled>
+						<overwrite_mode>DISCARD</overwrite_mode>
+						<subbuffer_size>524288</subbuffer_size>
+						<subbuffer_count>4</subbuffer_count>
+						<switch_timer_interval>0</switch_timer_interval>
+						<read_timer_interval>0</read_timer_interval>
+						<output_type>MMAP</output_type>
+						<blocking_timeout>0</blocking_timeout>
+						<monitor_timer_interval>1000000</monitor_timer_interval>
+						<tracefile_size>0</tracefile_size>
+						<tracefile_count>0</tracefile_count>
+						<live_timer_interval>0</live_timer_interval>
+						<events>
+							<event>
+								<name>tp:tptest</name>
+								<enabled>true</enabled>
+								<type>TRACEPOINT</type>
+								<loglevel_type>ALL</loglevel_type>
+							</event>
+						</events>
+						<contexts/>
+					</channel>
+				</channels>
+				<trackers/>
+			</domain>
+			<domain>
+				<type>JUL</type>
+				<buffer_type>PER_UID</buffer_type>
+				<channels/>
+			</domain>
+			<domain>
+				<type>LOG4J</type>
+				<buffer_type>PER_UID</buffer_type>
+				<channels/>
+			</domain>
+			<domain>
+				<type>PYTHON</type>
+				<buffer_type>PER_UID</buffer_type>
+				<channels/>
+			</domain>
+		</domains>
+		<started>false</started>
+		<output>
+			<consumer_output>
+				<enabled>true</enabled>
+				<destination>
+					<net_output>
+						<control_uri>tcp4://127.0.0.1:5342/my/custom/path5</control_uri>
+						<data_uri>tcp4://127.0.0.1:5343/</data_uri>
+					</net_output>
+				</destination>
+			</consumer_output>
+		</output>
+	</session>
+</sessions>
diff --git a/tests/regression/tools/base-path/test_ust b/tests/regression/tools/base-path/test_ust
index d7e324e7b..d60a2302a 100755
--- a/tests/regression/tools/base-path/test_ust
+++ b/tests/regression/tools/base-path/test_ust
@@ -27,7 +27,7 @@ EVENT_NAME="tp:tptest"
 
 TRACE_PATH=$(mktemp -d)
 
-NUM_TESTS=32
+NUM_TESTS=37
 
 source $TESTDIR/utils/utils.sh
 
@@ -117,7 +117,7 @@ function ust_app_snapshot_base_path ()
 function ust_app_snapshot_add_output_base_path ()
 {
 	local session_name=$(randstring 16 0)
-	local base_path="my/custom/path3"
+	local base_path="my/custom/path4"
 
 	diag "Test base path override for remote trace snapshot (URI on add-output)"
 	create_lttng_session_no_output $session_name --snapshot
@@ -142,6 +142,27 @@ function ust_app_snapshot_add_output_base_path ()
 	fi
 }
 
+function ust_app_stream_base_path_via_load ()
+{
+	local session_name="load-stream-extra-path"
+	local base_path="my/custom/path5"
+
+	diag "Test base path override for trace streaming using lttng load"
+	lttng_load_ok "-i $CURDIR/$session_name.lttng"
+	start_lttng_tracing_ok $session_name
+
+	$TESTAPP_BIN > /dev/null 2>&1
+
+	stop_lttng_tracing_ok $session_name
+	destroy_lttng_session_ok $session_name
+
+	# validate test
+	if validate_trace $EVENT_NAME "$TRACE_PATH/$HOSTNAME/$base_path"; then
+		# only delete if successful
+		rm -rf "$TRACE_PATH"
+	fi
+}
+
 plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
@@ -152,7 +173,9 @@ start_lttng_sessiond
 tests=( ust_app_stream_base_path
 	ust_app_snapshot_create_base_path
 	ust_app_snapshot_base_path
-	ust_app_snapshot_add_output_base_path )
+	ust_app_snapshot_add_output_base_path
+	ust_app_stream_base_path_via_load
+)
 for fct_test in ${tests[@]};
 do
 	${fct_test}
-- 
2.17.1
