From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: tests: skip UST perf tests if
	not root
Date: Thu, 17 Sep 2015 14:10:50 -0400
Message-ID: <1442513450-8013-1-git-send-email-mathieu.desnoyers__4550.00403239882$1442513542$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Zcde8-0006jd-Pi
 for lttng-dev@lists.lttng.org; Thu, 17 Sep 2015 14:11:09 -0400
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

Some distributions like Debian (e.g. Debian kernel 4.1.0-2-amd64) have
some grsecurity options enabled, such as CONFIG_GRKERNSEC_PERF_HARDEN.

Unfortunately, this option makes it impossible to use the SW page-fault
perf event as a normal user. It only leaves some HW events. However, we
can only use SW events within virtual machines.

Therefore, only run this test as root for now until we find a better
approach.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tests/regression/ust/test_event_perf | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tests/regression/ust/test_event_perf b/tests/regression/ust/test_event_perf
index 7fb37ed..7dc2168 100755
--- a/tests/regression/ust/test_event_perf
+++ b/tests/regression/ust/test_event_perf
@@ -90,8 +90,17 @@ plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
 
-start_lttng_sessiond
+if [ "$(id -u)" == "0" ]; then
+        isroot=1
+else
+        isroot=0
+fi
+
+skip $isroot "Root access is needed. Skipping UST perf tests." ${NUM_TESTS} ||
+{
+	start_lttng_sessiond
 
-test_event_basic
+	test_event_basic
 
-stop_lttng_sessiond
+	stop_lttng_sessiond
+}
-- 
2.1.4
