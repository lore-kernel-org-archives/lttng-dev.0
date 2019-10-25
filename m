From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 5/5] Tests: fix shellcheck warning
Date: Fri, 25 Oct 2019 18:12:04 -0400
Message-ID: <20191025221204.29696-5-jonathan.rajotte-julien__31134.6573334717$1572041696$gmane$org@efficios.com>
References: <20191025221204.29696-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 470JJ01scrz1PYK
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

No need to use random string for session name here, use the test name.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 tests/regression/tools/base-path/test_ust | 36 ++++++++++-------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/tests/regression/tools/base-path/test_ust b/tests/regression/tools/base-path/test_ust
index d60a2302a..84d434551 100755
--- a/tests/regression/tools/base-path/test_ust
+++ b/tests/regression/tools/base-path/test_ust
@@ -16,10 +16,8 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
 TEST_DESC="Streaming Base Path Override - User space tracing"
 
-CURDIR=$(dirname $0)/
+CURDIR=$(dirname "$0")/
 TESTDIR=$CURDIR/../../..
-NR_ITER=5
-NR_USEC_WAIT=0
 TESTAPP_PATH="$TESTDIR/utils/testapp"
 TESTAPP_NAME="gen-ust-events"
 TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
@@ -29,7 +27,7 @@ TRACE_PATH=$(mktemp -d)
 
 NUM_TESTS=37
 
-source $TESTDIR/utils/utils.sh
+source "$TESTDIR/utils/utils.sh"
 
 if [ ! -x "$TESTAPP_BIN" ]; then
 	BAIL_OUT "No UST events binary detected."
@@ -37,7 +35,7 @@ fi
 
 function ust_app_stream_base_path ()
 {
-	local session_name=$(randstring 16 0)
+	local session_name="ust_app_stream_base_path"
 	local base_path="my/custom/path1"
 
 	diag "Test base path override for trace streaming"
@@ -52,16 +50,15 @@ function ust_app_stream_base_path ()
 	destroy_lttng_session_ok $session_name
 
 	# validate test
-	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/$base_path
-	if [ $? -eq 0 ]; then
+	if validate_trace $EVENT_NAME "$TRACE_PATH/$HOSTNAME/$base_path"; then
 		# only delete if successful
-		rm -rf $TRACE_PATH
+		rm -rf "$TRACE_PATH"
 	fi
 }
 
 function ust_app_snapshot_create_base_path ()
 {
-	local session_name=$(randstring 16 0)
+	local session_name="ust_app_snapshot_create_base_path"
 	local base_path="my/custom/path2"
 
 	diag "Test base path override for remote trace snapshot (URI on create)"
@@ -80,16 +77,15 @@ function ust_app_snapshot_create_base_path ()
 	destroy_lttng_session_ok $session_name
 
 	# validate test
-	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/$base_path
-	if [ $? -eq 0 ]; then
+	if validate_trace $EVENT_NAME "$TRACE_PATH/$HOSTNAME/$base_path"; then
 		# only delete if successful
-		rm -rf $TRACE_PATH
+		rm -rf "$TRACE_PATH"
 	fi
 }
 
 function ust_app_snapshot_base_path ()
 {
-	local session_name=$(randstring 16 0)
+	local session_name="ust_app_snapshot_base_path"
 	local base_path="my/custom/path3"
 
 	diag "Test base path override for remote trace snapshot (URI on snapshot)"
@@ -107,16 +103,15 @@ function ust_app_snapshot_base_path ()
 	destroy_lttng_session_ok $session_name
 
 	# validate test
-	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/$base_path
-	if [ $? -eq 0 ]; then
+	if validate_trace $EVENT_NAME "$TRACE_PATH/$HOSTNAME/$base_path"; then
 		# only delete if successful
-		rm -rf $TRACE_PATH
+		rm -rf "$TRACE_PATH"
 	fi
 }
 
 function ust_app_snapshot_add_output_base_path ()
 {
-	local session_name=$(randstring 16 0)
+	local session_name="ust_app_snapshot_add_output_base_path"
 	local base_path="my/custom/path4"
 
 	diag "Test base path override for remote trace snapshot (URI on add-output)"
@@ -135,10 +130,9 @@ function ust_app_snapshot_add_output_base_path ()
 	destroy_lttng_session_ok $session_name
 
 	# validate test
-	validate_trace $EVENT_NAME $TRACE_PATH/$HOSTNAME/$base_path
-	if [ $? -eq 0 ]; then
+	if validate_trace $EVENT_NAME "$TRACE_PATH/$HOSTNAME/$base_path"; then
 		# only delete if successful
-		rm -rf $TRACE_PATH
+		rm -rf "$TRACE_PATH"
 	fi
 }
 
@@ -176,7 +170,7 @@ tests=( ust_app_stream_base_path
 	ust_app_snapshot_add_output_base_path
 	ust_app_stream_base_path_via_load
 )
-for fct_test in ${tests[@]};
+for fct_test in "${tests[@]}";
 do
 	${fct_test}
 done
-- 
2.17.1
