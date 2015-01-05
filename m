From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/3] Fix: ust snapshot: cleanup
	after error
Date: Sun,  4 Jan 2015 21:25:07 -0500
Message-ID: <1420424709-15095-1-git-send-email-mathieu.desnoyers__26569.0557928339$1420424764$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y7xMC-0007yk-OJ
 for lttng-dev@lists.lttng.org; Sun, 04 Jan 2015 21:25:25 -0500
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

The "break" statement on error skips the rest of the functions, thus
leaving test applications running after the end of the test, which is a
side-effect on the following tests.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tests/regression/tools/snapshots/ust_test | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tests/regression/tools/snapshots/ust_test b/tests/regression/tools/snapshots/ust_test
index cbc2058..e839b84 100755
--- a/tests/regression/tools/snapshots/ust_test
+++ b/tests/regression/tools/snapshots/ust_test
@@ -174,8 +174,6 @@ function test_ust_local_snapshot ()
 	if [ $? -eq 0 ]; then
 		# Only delete if successful
 		rm -rf $TRACE_PATH
-	else
-		break
 	fi
 
 	stop_test_apps
@@ -253,8 +251,6 @@ function test_ust_local_snapshot_large_metadata ()
 	if [ $? -eq 0 ]; then
 		# Only delete if successful
 		rm -rf $TRACE_PATH
-	else
-		break
 	fi
 }
 
@@ -288,8 +284,6 @@ function test_ust_per_uid_local_snapshot ()
 	if [ $? -eq 0 ]; then
 		# Only delete if successful
 		rm -rf $TRACE_PATH
-	else
-		break
 	fi
 
 	stop_test_apps
@@ -317,8 +311,6 @@ function test_ust_per_uid_local_snapshot_post_mortem ()
 	if [ $? -eq 0 ]; then
 		# Only delete if successful
 		rm -rf $TRACE_PATH
-	else
-		break
 	fi
 }
 
@@ -343,8 +335,6 @@ function test_ust_local_snapshots ()
 		if [ $? -eq 0 ]; then
 			# Only delete if successful
 			rm -rf $TRACE_PATH
-		else
-			break
 		fi
 	done
 	stop_lttng_tracing $SESSION_NAME
-- 
2.1.1
