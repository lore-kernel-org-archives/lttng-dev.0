From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] tap-driver.sh: flush stdout after
 each test result
Date: Wed, 13 Mar 2019 17:50:55 -0400
Message-ID: <20190313215055.12687-1-mjeanson__22931.2571276509$1552513881$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44KQWv2hVMz16Bx
 for <lttng-dev@lists.lttng.org>; Wed, 13 Mar 2019 17:51:07 -0400 (EDT)
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

This is useful in a CI system where stdout is fully buffered and you
look at the console output to see which test is hanging.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 config/tap-driver.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config/tap-driver.sh b/config/tap-driver.sh
index 4254e2b3..12742cae 100755
--- a/config/tap-driver.sh
+++ b/config/tap-driver.sh
@@ -273,6 +273,9 @@ function report(result, details)
     msg = msg " " details
   # Output on console might be colorized.
   print decorate_result(result) msg
+  # Flush stdout after each test result, this is useful when stdout
+  # is buffered, for example in a CI system.
+  fflush()
   # Log the result in the log file too, to help debugging (this is
   # especially true when said result is a TAP error or "Bail out!").
   print result msg | "cat >&3";
-- 
2.17.1
