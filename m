From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust] Build: add python interpreter used by
	python agent if builded
Date: Mon, 10 Aug 2015 14:45:33 -0400
Message-ID: <1439232334-31308-4-git-send-email-jonathan.rajotte-julien__19303.8363745019$1439232583$gmane$org@efficios.com>
References: <1439232334-31308-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZOs72-0001UV-Ay
 for lttng-dev@lists.lttng.org; Mon, 10 Aug 2015 14:47:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 19CA134053E
 for <lttng-dev@lists.lttng.org>; Mon, 10 Aug 2015 18:47:51 +0000 (UTC)
In-Reply-To: <1439232334-31308-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index ade4ffe..d2f7650 100644
--- a/configure.ac
+++ b/configure.ac
@@ -426,7 +426,7 @@ AS_IF([test "x$java_agent_log4j" = "xyes"], [AS_ECHO("Enabled")], [AS_ECHO("Disa
 AS_ECHO_N("JNI interface (JNI): ")
 AS_IF([test "x$jni_interface" = "xyes"], [AS_ECHO("Enabled")], [AS_ECHO("Disabled")])
 
-AS_ECHO_N("Python agent: ")
+AS_ECHO_N("Python($PYTHON) agent: ")
 AS_IF([test "x$python_agent" = "xyes"], [AS_ECHO("Enabled")], [AS_ECHO("Disabled")])
 
 AS_ECHO_N("sdt.h integration: ")
-- 
2.1.4
