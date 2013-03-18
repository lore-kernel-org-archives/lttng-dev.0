From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Tests: Fix nprocesses applications
	shutdown
Date: Mon, 18 Mar 2013 15:00:09 -0400
Message-ID: <1363633209-7528-1-git-send-email-christian.babeux__14484.3286987909$1363633288$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UHfIJ-0003ec-58
	for lttng-dev@lists.lttng.org; Mon, 18 Mar 2013 15:00:27 -0400
Received: by mail-qe0-f45.google.com with SMTP id b4so3611478qen.32
	for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2013 12:00:21 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The nprocesses test is using the SIGPIPE signal to shutdown the
spawned child applications. This is done in order to silence
the shell message such as this one:

"nprocesses/test_nprocesses: line 79: 26458 Terminated"

This mechanism is broken on systems where the SIGPIPE default handler
is overriden (thus no application shutdown occurs) in the executing
environment. This could lead to stale applications polluting the system
and causing heratic behavior in subsequent tests.

This commit add a loop and check that all the spawned applications have
been successfully killed.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/regression/ust/nprocesses/test_nprocesses | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/regression/ust/nprocesses/test_nprocesses b/tests/regression/ust/nprocesses/test_nprocesses
index e89d02e..23d9a0a 100755
--- a/tests/regression/ust/nprocesses/test_nprocesses
+++ b/tests/regression/ust/nprocesses/test_nprocesses
@@ -74,8 +74,10 @@ destroy_lttng_session $SESSION_NAME
 
 rm -rf $TRACE_PATH
 
-# Send SIGPIPE to 'silence' bash process status such as "Process as terminated"
-killall -s PIPE -q $TEST_BIN_NAME >/dev/null 2>&1
+while [ -n "$(pidof $TEST_BIN_NAME)" ]; do
+	killall -q $TEST_BIN_NAME >/dev/null 2>&1
+	sleep 0.5
+done
 
 pass "Kill all spawned applications"
 
-- 
1.8.1.3
