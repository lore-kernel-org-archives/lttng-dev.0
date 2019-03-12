From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: test: skip
 test_getcpu_override on single thread system
Date: Tue, 12 Mar 2019 14:30:30 -0400
Message-ID: <20190312183031.20265-1-jonathan.rajotte-julien__30433.7745344796$1552415456$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44Jk736BKdz16BX
 for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2019 14:30:39 -0400 (EDT)
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

There is no value in performing this test on single thread system
since the only valid value for the cpu field is 0.

This test currently fails on single thread system (i.e yocto runquemu)
on the test_getcpu_override_fail test case.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 .../ust/getcpu-override/test_getcpu_override     | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/regression/ust/getcpu-override/test_getcpu_override b/tests/regression/ust/getcpu-override/test_getcpu_override
index 4ca385aeb..ee3e31953 100755
--- a/tests/regression/ust/getcpu-override/test_getcpu_override
+++ b/tests/regression/ust/getcpu-override/test_getcpu_override
@@ -157,13 +157,19 @@ plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
 
-if [ -x "$CURDIR/.libs/lttng-ust-getcpu-override-test.so" ]; then
-	foundobj=1
-else
-	foundobj=0
+if [ ! -x "$CURDIR/.libs/lttng-ust-getcpu-override-test.so" ]; then
+	skip 0 "No shared object generated. Skipping all tests." $NUM_TESTS && exit 0
+fi
+
+if [ "$num_cpus" -eq "1" ]; then
+	# Skip the test since we cannot perform it as designed since N mod 1
+	# is always equals to zero. There is no point testing this on a system
+	# with a single thread. LTTng-UST limits the get_cpu function to return
+	# value inside the [0, NUM_CPU - 1] range for a valid event (present in
+	# trace).
+	skip 0 "Test system only have a single thread. Skipping all tests." $NUM_TESTS && exit 0
 fi
 
-skip $foundobj "No shared object generated. Skipping all tests." $NUM_TESTS && exit 0
 
 TESTS=(
 	test_getcpu_override_fail
-- 
2.17.1
