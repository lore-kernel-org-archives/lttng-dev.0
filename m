From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: test_mi test
Date: Thu,  6 Aug 2015 15:52:37 -0400
Message-ID: <1438890757-29800-1-git-send-email-mathieu.desnoyers__28091.1551592455$1438890837$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZNRDf-0006ax-Pb
 for lttng-dev@lists.lttng.org; Thu, 06 Aug 2015 15:52:57 -0400
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
 tests/regression/tools/mi/test_mi | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tests/regression/tools/mi/test_mi b/tests/regression/tools/mi/test_mi
index a5c7493..5bd29ed 100755
--- a/tests/regression/tools/mi/test_mi
+++ b/tests/regression/tools/mi/test_mi
@@ -27,8 +27,8 @@ RELAYD_BIN="lttng-relayd"
 TESTAPP_PATH="$TESTDIR/utils/testapp"
 TESTAPP_NAME="gen-ust-events"
 TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
-NR_USEC_WAIT=10000
-
+NR_USEC_WAIT=0
+NR_ITER=10000
 
 #Temp file output
 OUTPUT_DIR=$(mktemp -d)
@@ -500,14 +500,25 @@ function test_list_session ()
 
 function test_list_ust_event ()
 {
+	local file_sync_after_first=$(mktemp -u)
+	local file_sync_before_last=$(mktemp -u)
+
 	OUTPUT_FILE="list_ust_event.xml"
 
 	#Test buid up
 	OUTPUT_DEST=$OUTPUT_DIR/$OUTPUT_FILE
 
 	#Begin testing
-	$TESTAPP_BIN $NR_USEC_WAIT & 2>/dev/null
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT ${file_sync_after_first} ${file_sync_before_last} & 2>/dev/null
+
+	while [ ! -f "${file_sync_after_first}" ]; do
+		sleep 0.5
+	done
+
 	list_lttng_with_opts "-u -f"
+
+	touch ${file_sync_before_last}
+
 	$XML_VALIDATE $OUTPUT_DEST
 	ok $? "Mi test: list ust event xsd validation"
 
@@ -530,6 +541,9 @@ function test_list_ust_event ()
 
 	#Wait for all background processes
 	wait
+
+	rm -f ${file_sync_after_first}
+	rm -f ${file_sync_before_last}
 }
 
 function test_start_stop () {
-- 
2.1.4
