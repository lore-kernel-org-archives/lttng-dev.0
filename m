From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu] tap-driver.sh: flush stdout after each
 test result
Date: Thu, 14 Mar 2019 11:35:39 -0400
Message-ID: <20190314153539.1196-1-mjeanson__4947.71916871599$1552577763$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Kt8L1fKXz15ng
 for <lttng-dev@lists.lttng.org>; Thu, 14 Mar 2019 11:35:45 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id CCC66BA4F4
 for <lttng-dev@lists.lttng.org>; Thu, 14 Mar 2019 11:35:44 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

This is useful in a CI system where stdout is fully buffered and you
look at the console output to see which test is hanging.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 config/tap-driver.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config/tap-driver.sh b/config/tap-driver.sh
index 4254e2b..12742ca 100755
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
