From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 1/6] Tests: Fix wrong number of
	tests in test plan of the thread stall test
Date: Thu, 21 Mar 2013 15:56:42 -0400
Message-ID: <1363895807-17892-1-git-send-email-christian.babeux__27275.6256432787$1363895889$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UIlbq-0006gU-9S
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 15:57:10 -0400
Received: by mail-ie0-f177.google.com with SMTP id 16so3995332iea.36
	for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2013 12:57:04 -0700 (PDT)
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


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/regression/tools/health/test_thread_stall | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/regression/tools/health/test_thread_stall b/tests/regression/tools/health/test_thread_stall
index 92cfb01..1651c02 100755
--- a/tests/regression/tools/health/test_thread_stall
+++ b/tests/regression/tools/health/test_thread_stall
@@ -24,7 +24,7 @@ SESSION_NAME="health_thread_stall"
 EVENT_NAME="bogus"
 HEALTH_CHECK_BIN="health_check"
 SESSIOND_PRELOAD=".libs/libhealthstall.so"
-NUM_TESTS=12
+NUM_TESTS=11
 
 source $TESTDIR/utils/utils.sh
 
-- 
1.8.1.3
