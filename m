From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH] Fix: set thread in daemon mode
Date: Thu, 26 Jun 2014 15:07:54 -0400
Message-ID: <1403809674-13603-1-git-send-email-dgoulet__40871.2711571299$1403809746$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1X0F1j-0001Vj-1E
 for lttng-dev@lists.lttng.org; Thu, 26 Jun 2014 15:08:12 -0400
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

This way, when the JVM stops the main thread, the agent's thread will be
automatically shutdown thus making the .dispose() call optional.

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 liblttng-ust-jul/org/lttng/ust/jul/LTTngAgent.java | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/liblttng-ust-jul/org/lttng/ust/jul/LTTngAgent.java b/liblttng-ust-jul/org/lttng/ust/jul/LTTngAgent.java
index 2485be2..6717cd1 100644
--- a/liblttng-ust-jul/org/lttng/ust/jul/LTTngAgent.java
+++ b/liblttng-ust-jul/org/lttng/ust/jul/LTTngAgent.java
@@ -128,6 +128,7 @@ public class LTTngAgent {
 		this.lttngThreadUser = new LTTngThread(this.sessiondAddr,
 				this.lttngHandlerUser, this.registerSem);
 		this.sessiondThUser = new Thread(lttngThreadUser);
+		this.sessiondThUser.setDaemon(true);
 		this.sessiondThUser.start();
 		/* Wait for registration done of per-user sessiond */
 		nr_acquires++;
@@ -136,6 +137,7 @@ public class LTTngAgent {
 		this.lttngThreadRoot = new LTTngThread(this.sessiondAddr,
 				this.lttngHandlerRoot, this.registerSem);
 		this.sessiondThRoot = new Thread(lttngThreadRoot);
+		this.sessiondThRoot.setDaemon(true);
 		this.sessiondThRoot.start();
 		/* Wait for registration done of system-wide sessiond */
 		nr_acquires++;
-- 
2.0.0
