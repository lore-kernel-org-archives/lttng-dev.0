From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Fix: Use Java 6 syntax in JUL examples
Date: Mon, 15 Feb 2016 14:29:58 -0500
Message-ID: <1455564598-16049-1-git-send-email-mjeanson__1163.00513404912$1455564666$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aVOqZ-0005XN-Mc
 for lttng-dev@lists.lttng.org; Mon, 15 Feb 2016 14:30:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 28A513404C8
 for <lttng-dev@lists.lttng.org>; Mon, 15 Feb 2016 19:30:06 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 doc/examples/java-jul/ApplicationContextExample.java | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/doc/examples/java-jul/ApplicationContextExample.java b/doc/examples/java-jul/ApplicationContextExample.java
index 3da3ac8..52cef3f 100644
--- a/doc/examples/java-jul/ApplicationContextExample.java
+++ b/doc/examples/java-jul/ApplicationContextExample.java
@@ -67,12 +67,11 @@ public class ApplicationContextExample {
 
 		@Override
 		public Object retrieveContextInfo(String key) {
-			switch (key) {
-			case CONTEXT_NAME_SHORT:
+			if (CONTEXT_NAME_SHORT.equals(key)) {
 				return (short) 42;
-			case CONTEXT_NAME_STRING:
+			} else if (CONTEXT_NAME_STRING.equals(key)) {
 				return "context-value!";
-			default:
+			} else {
 				return null;
 			}
 		}
-- 
2.7.0
