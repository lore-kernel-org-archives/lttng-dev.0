From: David Goulet <dgoulet@ev0ke.net>
Subject: [PATCH lttng-ust] Change JUL agent to use the new ABI
Date: Fri,  8 Aug 2014 12:48:48 -0400
Message-ID: <1407516528-27193-1-git-send-email-dgoulet__8544.85555687479$1407516632$gmane$org@ev0ke.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@ev0ke.net>) id 1XFnLk-00013T-0x
 for lttng-dev@lists.lttng.org; Fri, 08 Aug 2014 12:49:09 -0400
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

From: David Goulet <dgoulet@efficios.com>

Two things have changed, the agent port file created by the session
daemon, the name is now "agent.port". The second thing is that upon
registration, the agent needs to send its domain which is here
LTTNG_DOMAIN_JUL (val: 3).

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 .../org/lttng/ust/jul/LTTngTCPSessiondClient.java            | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.java b/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.java
index 861c734..cf3074b 100644
--- a/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.java
+++ b/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.java
@@ -53,8 +53,13 @@ public class LTTngTCPSessiondClient {
 
 	private Semaphore registerSem;
 
-	private static final String rootPortFile = "/var/run/lttng/jul.port";
-	private static final String userPortFile = "/.lttng/jul.port";
+	private static final String rootPortFile = "/var/run/lttng/agent.port";
+	private static final String userPortFile = "/.lttng/agent.port";
+	/*
+	 * This is taken from the lttng/domain.h file which is mapped to
+	 * LTTNG_DOMAIN_JUL value for this agent.
+	 */
+	private static final int agent_domain = 3;
 
 	/* Indicate if we've already release the semaphore. */
 	private boolean sem_posted = false;
@@ -311,10 +316,11 @@ public class LTTngTCPSessiondClient {
 	}
 
 	private void registerToSessiond() throws Exception {
-		byte data[] = new byte[4];
+		byte data[] = new byte[8];
 		ByteBuffer buf = ByteBuffer.wrap(data);
 		String pid = ManagementFactory.getRuntimeMXBean().getName().split("@")[0];
 
+		buf.putInt(this.agent_domain);
 		buf.putInt(Integer.parseInt(pid));
 		this.outToSessiond.write(data, 0, data.length);
 		this.outToSessiond.flush();
-- 
2.1.0.rc1
