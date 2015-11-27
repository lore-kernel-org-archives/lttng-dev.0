From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Tests: fix tracefile count when
	page_size is > 4k
Date: Fri, 27 Nov 2015 16:24:28 -0500
Message-ID: <1448659468-25013-1-git-send-email-mjeanson__14184.5659506091$1448659561$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1a2QW4-0003yV-30
 for lttng-dev@lists.lttng.org; Fri, 27 Nov 2015 16:25:18 -0500
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

Set the tracefile size according to the platform page_size and increase
the number of iterations to properly test the rotation.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tests/regression/tools/tracefile-limits/test_tracefile_count | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/regression/tools/tracefile-limits/test_tracefile_count b/tests/regression/tools/tracefile-limits/test_tracefile_count
index 4fe6ac3..6ada858 100755
--- a/tests/regression/tools/tracefile-limits/test_tracefile_count
+++ b/tests/regression/tools/tracefile-limits/test_tracefile_count
@@ -28,6 +28,7 @@ STATS_BIN="$TESTDIR/utils/babelstats.pl"
 NUM_TESTS=74
 
 NUM_CPUS=`nproc`
+PAGE_SIZE=$(getconf PAGE_SIZE)
 
 source $TESTDIR/utils/utils.sh
 
@@ -47,7 +48,7 @@ function enable_lttng_channel_count_limit ()
 
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel \
 	    -u $channel_name -s $sess_name \
-	    -C 4096 -W $tracefile_count_limit \
+	    -C $(($PAGE_SIZE*3)) -W $tracefile_count_limit \
 	    --overwrite >/dev/null 2>&1
 
 	ok $? "$test_name"
@@ -103,7 +104,7 @@ function test_tracefile_count_limit ()
 	session_name=$(randstring 16 0)
 	channel_name="channel"
 	event_name="tp:tptest"
-	num_iter=1000
+	num_iter=100000
 	expected_max=$(($num_iter - 1))
 
 	diag "Test tracefile count limit : $count_limit tracefiles"
-- 
1.9.1
