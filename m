From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools v2 1/2] Tests: check for
 lttng-modules presence
Date: Thu, 28 Mar 2019 17:02:20 -0400
Message-ID: <20190328210221.27662-1-jonathan.rajotte-julien__44623.1991330691$1553806969$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Vckv1wkCz18DT
 for <lttng-dev@lists.lttng.org>; Thu, 28 Mar 2019 17:02:30 -0400 (EDT)
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
 tests/regression/tools/notification/test_notification_kernel | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/regression/tools/notification/test_notification_kernel b/tests/regression/tools/notification/test_notification_kernel
index 6d7f256ae..e7368df26 100755
--- a/tests/regression/tools/notification/test_notification_kernel
+++ b/tests/regression/tools/notification/test_notification_kernel
@@ -108,6 +108,7 @@ function kernel_test
 }
 
 if [ "$(id -u)" == "0" ]; then
+	validate_lttng_modules_present
 	kernel_test
 else
 	# Kernel tests are skipped.
-- 
2.17.1
