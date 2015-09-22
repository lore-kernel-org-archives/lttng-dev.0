From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] test: jul/log4j: use -a instead of
	'*' to disable all events
Date: Tue, 22 Sep 2015 13:55:34 -0400
Message-ID: <1442944534-5423-1-git-send-email-jonathan.rajotte-julien__23724.2975541905$1442944816$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZeRnH-00016k-GL
 for lttng-dev@lists.lttng.org; Tue, 22 Sep 2015 13:56:03 -0400
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 tests/regression/ust/java-jul/test_java_jul     | 2 +-
 tests/regression/ust/java-log4j/test_java_log4j | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/regression/ust/java-jul/test_java_jul b/tests/regression/ust/java-jul/test_java_jul
index f9f244b..b3f9b51 100755
--- a/tests/regression/ust/java-jul/test_java_jul
+++ b/tests/regression/ust/java-jul/test_java_jul
@@ -347,7 +347,7 @@ function test_jul_disable_all()
 	enable_jul_lttng_event $SESSION_NAME $EVENT_NAME
 	enable_jul_lttng_event $SESSION_NAME $EVENT_NAME2
 
-	disable_jul_lttng_event $SESSION_NAME '*'
+	disable_jul_lttng_event $SESSION_NAME -a
 
 	start_lttng_tracing_ok $SESSION_NAME
 
diff --git a/tests/regression/ust/java-log4j/test_java_log4j b/tests/regression/ust/java-log4j/test_java_log4j
index d5c6621..5c0f03d 100755
--- a/tests/regression/ust/java-log4j/test_java_log4j
+++ b/tests/regression/ust/java-log4j/test_java_log4j
@@ -348,7 +348,7 @@ function test_log4j_disable_all()
 	enable_log4j_lttng_event $SESSION_NAME $EVENT_NAME
 	enable_log4j_lttng_event $SESSION_NAME $EVENT_NAME2
 
-	disable_log4j_lttng_event $SESSION_NAME '*'
+	disable_log4j_lttng_event $SESSION_NAME -a
 
 	start_lttng_tracing_ok $SESSION_NAME
 
-- 
2.1.4
