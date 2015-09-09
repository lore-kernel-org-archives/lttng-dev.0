From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/2] lttng-crash: support symlink
Date: Wed,  9 Sep 2015 13:46:17 -0400
Message-ID: <1441820777-1092-2-git-send-email-jonathan.rajotte-julien__12136.3604710952$1441820859$gmane$org@efficios.com>
References: <1441820777-1092-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZZjSC-0007I2-LE
 for lttng-dev@lists.lttng.org; Wed, 09 Sep 2015 13:46:43 -0400
In-Reply-To: <1441820777-1092-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

Fixes #915
Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-crash/lttng-crash.c       |  1 +
 tests/regression/tools/crash/test_crash | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/bin/lttng-crash/lttng-crash.c b/src/bin/lttng-crash/lttng-crash.c
index 5ca85f3..7f92165 100644
--- a/src/bin/lttng-crash/lttng-crash.c
+++ b/src/bin/lttng-crash/lttng-crash.c
@@ -1028,6 +1028,7 @@ int extract_trace_recursive(const char *output_path,
 			break;
 		}
 		case DT_REG:
+		case DT_LNK:
 			if (!strcmp(entry->d_name, "metadata")) {
 				ret = extract_one_trace(output_path,
 					input_path);
diff --git a/tests/regression/tools/crash/test_crash b/tests/regression/tools/crash/test_crash
index ff5d0e3..35a5bd7 100755
--- a/tests/regression/tools/crash/test_crash
+++ b/tests/regression/tools/crash/test_crash
@@ -31,7 +31,7 @@ NR_ITER=-1
 # Temp file output
 OUTPUT_DIR=$(mktemp -d)
 
-NUM_TESTS=70
+NUM_TESTS=71
 
 source $TESTDIR/utils/utils.sh
 
@@ -225,6 +225,7 @@ function test_lttng_crash()
 	local session_name=crash_test
 	local channel_name=channel_crash
 	local shm_path=$(mktemp -d)
+	local shm_path_symlink=$(mktemp -d)
 	local event_name="tp:tptest"
 
 	# Create a session in snapshot mode to deactivate any use of consumerd
@@ -242,10 +243,17 @@ function test_lttng_crash()
 	test $crash_recup_count -eq "10"
 	ok $? "Expect 10 recup event from buffers got $crash_recup_count"
 
+	# Test with symlink
+	cp -rs $shm_path/. $shm_path_symlink
+	crash_recup_count=$($LTTNG_CRASH $shm_path_symlink | wc -l)
+	test $crash_recup_count -eq "10"
+	ok $? "Expect 10 recup event from symlink buffers got $crash_recup_count"
+
 	# Tear down
 	destroy_lttng_session_ok $session_name
 	stop_lttng_sessiond
 	rm -rf $shm_path
+	rm -rf $shm_path_symlink
 }
 
 function test_lttng_crash_extraction()
@@ -380,10 +388,10 @@ function test_lttng_crash_extraction_sigkill()
 TESTS=(
 	test_shm_path_per_uid
 	test_shm_path_per_pid
-	test_lttng_crash
-	test_lttng_crash_extraction
 	test_shm_path_per_pid_sigint
 	test_shm_path_per_uid_sigint
+	test_lttng_crash
+	test_lttng_crash_extraction
 	test_lttng_crash_extraction_sigkill
 )
 
-- 
2.1.4
