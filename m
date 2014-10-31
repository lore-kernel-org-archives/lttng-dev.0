From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-ust] Fix: Warn when log4j version is too
	old
Date: Fri, 31 Oct 2014 15:33:59 -0400
Message-ID: <1414784039-11359-1-git-send-email-christian.babeux__37660.2713753984$1414784107$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <christian.babeux@0x80.ca>) id 1XkHxd-0003s0-4g
 for lttng-dev@lists.lttng.org; Fri, 31 Oct 2014 15:34:14 -0400
Received: by mail-qg0-f41.google.com with SMTP id q107so6225609qgd.28
 for <lttng-dev@lists.lttng.org>; Fri, 31 Oct 2014 12:34:07 -0700 (PDT)
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

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java | 1 +
 1 file changed, 1 insertion(+)

diff --git a/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java b/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java
index 47b4519..f7e1e38 100644
--- a/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java
+++ b/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java
@@ -119,6 +119,7 @@ public class LTTngAgent {
 		try {
 			logging.getDeclaredMethod("getTimeStamp");
 		} catch (NoSuchMethodException e) {
+			System.err.println("Warning: The loaded log4j library is too old. Log4j tracing with LTTng will be disabled.");
 			return false;
 		} catch (NullPointerException e) {
 			/* Should never happen */
-- 
2.1.1
