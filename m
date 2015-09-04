From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/2] Test kernel wildcards
Date: Fri,  4 Sep 2015 19:53:19 -0400
Message-ID: <1441410799-10991-2-git-send-email-mathieu.desnoyers__32371.4103935801$1441411086$gmane$org@efficios.com>
References: <1441410799-10991-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZY0nb-00068K-VC
 for lttng-dev@lists.lttng.org; Fri, 04 Sep 2015 19:53:49 -0400
In-Reply-To: <1441410799-10991-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../regression/tools/wildcard/test_event_wildcard  | 87 ++++++++++++++++------
 tests/utils/utils.sh                               | 37 +++++++--
 2 files changed, 96 insertions(+), 28 deletions(-)

diff --git a/tests/regression/tools/wildcard/test_event_wildcard b/tests/regression/tools/wildcard/test_event_wildcard
index 7fbfc18..126bdae 100755
--- a/tests/regression/tools/wildcard/test_event_wildcard
+++ b/tests/regression/tools/wildcard/test_event_wildcard
@@ -16,37 +16,47 @@
 # this program; if not, write to the Free Software Foundation, Inc., 51
 # Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-TEST_DESC="UST tracer - Event wildcard"
+TEST_DESC="LTTng - Event wildcard test"
 
 CURDIR=$(dirname $0)/
-TESTDIR=$CURDIR/../..
+TESTDIR=$CURDIR/../../..
 LTTNG_BIN="lttng"
 TESTAPP_PATH="$TESTDIR/utils/testapp"
 TESTAPP_NAME="gen-ust-events"
 TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
 SESSION_NAME="wildcard"
-EVENT_NAME="tp:tptest"
-NUM_TESTS=39
 NR_ITER=100
+NUM_GLOBAL_TESTS=2
+NUM_UST_TESTS=37
+NUM_KERNEL_TESTS=37
+NUM_TESTS=$(($NUM_UST_TESTS+$NUM_KERNEL_TESTS+$NUM_GLOBAL_TESTS))
 
 source $TESTDIR/utils/utils.sh
 
-if [ ! -x "$TESTAPP_BIN" ]; then
-	BAIL_OUT "No UST nevents binary detected."
-fi
+function run_ust
+{
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT
+}
+
+function run_kernel
+{
+	# Trigger the event for 100 iterations
+	echo -n "100" > /proc/lttng-test-filter-event
+}
 
 function test_event_wildcard()
 {
 	TRACE_PATH=$(mktemp -d)
-	FIND="${1}"
-	WILDCARD="${2}"
+	DOMAIN="$1"
+	FIND="$2"
+	WILDCARD="$3"
 
 	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
-	enable_ust_lttng_event_ok $SESSION_NAME "$WILDCARD"
+	enable_${DOMAIN}_lttng_event_ok $SESSION_NAME "$WILDCARD"
 
 	start_lttng_tracing_ok
 
-	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT
+	run_${DOMAIN}
 	ok $? "Traced application stopped."
 
 	stop_lttng_tracing_ok
@@ -64,16 +74,16 @@ function test_event_wildcard()
 function test_event_wildcard_fail()
 {
 	TRACE_PATH=$(mktemp -d)
-	WILDCARD="${1}"
+	DOMAIN="$1"
+	WILDCARD="$2"
 
 	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
-	enable_ust_lttng_event_fail $SESSION_NAME "$WILDCARD"
+	enable_${DOMAIN}_lttng_event_fail $SESSION_NAME "$WILDCARD"
 	destroy_lttng_session_ok $SESSION_NAME
 
 	rm -rf $TRACE_PATH
 }
 
-
 # MUST set TESTDIR before calling those functions
 plan_tests $NUM_TESTS
 
@@ -81,13 +91,48 @@ print_test_banner "$TEST_DESC"
 
 start_lttng_sessiond
 
-test_event_wildcard 1 'tp:tp*'
-test_event_wildcard 1 '*'
-test_event_wildcard 1 'tp:tptest*'
-test_event_wildcard 0 'tp:abc*'
+diag "Test UST wildcard"
+
+if [ ! -x "$TESTAPP_BIN" ]; then
+	BAIL_OUT "No UST nevents binary detected."
+fi
+
+EVENT_NAME="tp:tptest"
+
+test_event_wildcard ust 1 'tp:tp*'
+test_event_wildcard ust 1 '*'
+test_event_wildcard ust 1 'tp:tptest*'
+test_event_wildcard ust 0 'tp:abc*'
+
+test_event_wildcard_fail ust 'tp:*tp'
+test_event_wildcard_fail ust 'tp:tp**'
+test_event_wildcard_fail ust '*tp:tp*'
+
+
+if [ "$(id -u)" == "0" ]; then
+	isroot=1
+else
+	isroot=0
+fi
 
-test_event_wildcard_fail 'tp:*tp'
-test_event_wildcard_fail 'tp:tp**'
-test_event_wildcard_fail '*tp:tp*'
+skip $isroot "Root access is needed. Skipping all kernel wildcard tests." $NUM_KERNEL_TESTS ||
+{
+	diag "Test kernel wildcards"
+
+	modprobe lttng-test
+
+	EVENT_NAME="lttng_test_filter_event"
+
+	test_event_wildcard kernel 1 'lttng_test_*'
+	test_event_wildcard kernel 1 '*'
+	test_event_wildcard kernel 1 'lttng_test_filter_event*'
+	test_event_wildcard kernel 0 'lttng_test_asdfasdf*'
+
+	test_event_wildcard_fail kernel 'tp_*tp'
+	test_event_wildcard_fail kernel 'tp_tp**'
+	test_event_wildcard_fail kernel '*tp_tp*'
+
+	rmmod lttng-test
+}
 
 stop_lttng_sessiond
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index 1e1e791..d466ee6 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -86,18 +86,19 @@ function randstring()
 	echo
 }
 
-function lttng_enable_kernel_event
+function enable_kernel_lttng_event
 {
-	local sess_name=$1
-	local event_name=$2
-	local channel_name=$3
+	local expected_to_fail="$1"
+	local sess_name="$2"
+	local event_name="$3"
+	local channel_name="$4"
 
-	if [ -z $event_name ]; then
+	if [ -z "$event_name" ]; then
 		# Enable all event if no event name specified
 		event_name="-a"
 	fi
 
-	if [ -z $channel_name ]; then
+	if [ -z "$channel_name" ]; then
 		# default channel if none specified
 		chan=""
 	else
@@ -105,7 +106,29 @@ function lttng_enable_kernel_event
 	fi
 
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -k 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
-	ok $? "Enable kernel event $event_name for session $sess_name"
+	ret=$?
+	if [[ $expected_to_fail -eq "1" ]]; then
+		test $ret -ne "0"
+		ok $? "Enable kernel event $event_name for session $session_name on channel $channel_name failed as expected"
+	else
+		ok $ret "Enable kernel event $event_name for session $sess_name"
+	fi
+}
+
+function enable_kernel_lttng_event_ok ()
+{
+	enable_kernel_lttng_event 0 "$@"
+}
+
+function enable_kernel_lttng_event_fail ()
+{
+	enable_kernel_lttng_event 1 "$@"
+}
+
+# Old interface
+function lttng_enable_kernel_event
+{
+	enable_kernel_lttng_event_ok "$@"
 }
 
 function lttng_enable_kernel_syscall()
-- 
2.1.4
