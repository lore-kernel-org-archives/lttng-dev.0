From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools v2 2/2] Tests: plan_tests must be
 called before running tests/skipping
Date: Thu, 28 Mar 2019 17:02:21 -0400
Message-ID: <20190328210221.27662-2-jonathan.rajotte-julien__12814.2118033551$1553806994$gmane$org@efficios.com>
References: <20190328210221.27662-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Vckw6211z18Dq
 for <lttng-dev@lists.lttng.org>; Thu, 28 Mar 2019 17:02:32 -0400 (EDT)
In-Reply-To: <20190328210221.27662-1-jonathan.rajotte-julien@efficios.com>
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

Otherwise tap parsers can complain that there was no test plan and
report a failure.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 tests/regression/tools/notification/test_notification_kernel | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/regression/tools/notification/test_notification_kernel b/tests/regression/tools/notification/test_notification_kernel
index e7368df26..604cc48cf 100755
--- a/tests/regression/tools/notification/test_notification_kernel
+++ b/tests/regression/tools/notification/test_notification_kernel
@@ -107,12 +107,13 @@ function kernel_test
 	rm -rf ${consumerd_pipe[@]} 2> /dev/null
 }
 
+plan_tests $NUM_TESTS
+
 if [ "$(id -u)" == "0" ]; then
 	validate_lttng_modules_present
 	kernel_test
 else
 	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
 	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
 fi
 
-- 
2.17.1
