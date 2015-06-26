From: Alexandre Montplaisir <alexmonthy@efficios.com>
Subject: [PATCH lttng-ust] Fix compiliation warnings
Date: Fri, 26 Jun 2015 18:03:31 -0400
Message-ID: <1435356211-8083-1-git-send-email-alexmonthy__28250.2217371531$1435356298$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@efficios.com>) id 1Z8bio-0004vD-M0
 for lttng-dev@lists.lttng.org; Fri, 26 Jun 2015 18:03:51 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Alexandre Montplaisir <alexmonthy@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Remove unused imports.
Access static fields statically.

Signed-off-by: Alexandre Montplaisir <alexmonthy@efficios.com>
---
 .../java/org/lttng/ust/agent/LTTngAgent.java       | 99 ++++++++++------------
 .../org/lttng/ust/agent/LTTngSessiondCmd2_6.java   |  4 +-
 .../lttng/ust/agent/LTTngTCPSessiondClient.java    | 29 +++----
 .../java/org/lttng/ust/agent/log4j/LTTngLog4j.java |  2 +-
 4 files changed, 59 insertions(+), 75 deletions(-)

diff --git a/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java b/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java
index f7e1e38..066966f 100644
--- a/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java
+++ b/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java
@@ -17,19 +17,10 @@
 
 package org.lttng.ust.agent;
 
-import org.lttng.ust.agent.jul.LTTngJUL;
-
 import java.io.IOException;
-import java.io.InputStream;
-import java.io.BufferedReader;
-import java.io.FileReader;
+import java.lang.reflect.InvocationTargetException;
 import java.util.concurrent.Semaphore;
 import java.util.concurrent.TimeUnit;
-import java.util.Enumeration;
-import java.lang.reflect.InvocationTargetException;
-
-import java.util.logging.Logger;
-import java.util.logging.SimpleFormatter;
 
 public class LTTngAgent {
 	/* Domains */
@@ -87,7 +78,7 @@ public class LTTngAgent {
 			initAgentLog4jClasses();
 		}
 
-		this.registerSem = new Semaphore(0, true);
+		registerSem = new Semaphore(0, true);
 	}
 
 	private Boolean loadLog4jClasses() {
@@ -151,8 +142,8 @@ public class LTTngAgent {
 	private void initAgentJULClasses() {
 		try {
 			Class<?> lttngJUL = loadClass("org.lttng.ust.agent.jul.LTTngJUL");
-			this.julUser = (LogFramework)lttngJUL.getDeclaredConstructor(new Class[] {Boolean.class}).newInstance(false);
-			this.julRoot = (LogFramework)lttngJUL.getDeclaredConstructor(new Class[] {Boolean.class}).newInstance(true);
+			julUser = (LogFramework)lttngJUL.getDeclaredConstructor(new Class[] {Boolean.class}).newInstance(false);
+			julRoot = (LogFramework)lttngJUL.getDeclaredConstructor(new Class[] {Boolean.class}).newInstance(true);
 			this.useJUL = true;
 		} catch (ClassNotFoundException e) {
 			/* LTTng JUL classes not found, no need to create the relevant objects */
@@ -171,8 +162,8 @@ public class LTTngAgent {
 	private void initAgentLog4jClasses() {
 		try {
 			Class<?> lttngLog4j = loadClass("org.lttng.ust.agent.log4j.LTTngLog4j");
-			this.log4jUser = (LogFramework)lttngLog4j.getDeclaredConstructor(new Class[] {Boolean.class}).newInstance(false);
-			this.log4jRoot = (LogFramework)lttngLog4j.getDeclaredConstructor(new Class[] {Boolean.class}).newInstance(true);
+			log4jUser = (LogFramework)lttngLog4j.getDeclaredConstructor(new Class[] {Boolean.class}).newInstance(false);
+			log4jRoot = (LogFramework)lttngLog4j.getDeclaredConstructor(new Class[] {Boolean.class}).newInstance(true);
 			this.useLog4j = true;
 		} catch (ClassNotFoundException e) {
 			/* LTTng Log4j classes not found, no need to create the relevant objects */
@@ -201,7 +192,7 @@ public class LTTngAgent {
 	}
 
 	private synchronized void init() throws SecurityException, IOException {
-		if (this.initialized) {
+		if (initialized) {
 			return;
 		}
 
@@ -220,38 +211,38 @@ public class LTTngAgent {
 
 		/* Wait for each registration to end. */
 		try {
-			this.registerSem.tryAcquire(numThreads,
+			registerSem.tryAcquire(numThreads,
 						    semTimeout,
 						    TimeUnit.SECONDS);
 		} catch (InterruptedException e) {
 			e.printStackTrace();
 		}
 
-		this.initialized = true;
+		initialized = true;
 	}
 
 	private synchronized Integer initJULClientThreads() {
 		Integer numThreads = 2;
 
 		/* Handle user session daemon if any. */
-		this.julUserClient = new LTTngTCPSessiondClient(Domain.JUL,
-								this.julUser,
-								this.registerSem);
+		julUserClient = new LTTngTCPSessiondClient(Domain.JUL,
+								julUser,
+								registerSem);
 
 		String userThreadName = "LTTng UST agent JUL user thread";
-		this.sessiondThreadJULUser = new Thread(julUserClient, userThreadName);
-		this.sessiondThreadJULUser.setDaemon(true);
-		this.sessiondThreadJULUser.start();
+		sessiondThreadJULUser = new Thread(julUserClient, userThreadName);
+		sessiondThreadJULUser.setDaemon(true);
+		sessiondThreadJULUser.start();
 
 		/* Handle root session daemon. */
-		this.julRootClient = new LTTngTCPSessiondClient(Domain.JUL,
-								this.julRoot,
-								this.registerSem);
+		julRootClient = new LTTngTCPSessiondClient(Domain.JUL,
+								julRoot,
+								registerSem);
 
 		String rootThreadName = "LTTng UST agent JUL root thread";
-		this.sessiondThreadJULRoot = new Thread(julRootClient, rootThreadName);
-		this.sessiondThreadJULRoot.setDaemon(true);
-		this.sessiondThreadJULRoot.start();
+		sessiondThreadJULRoot = new Thread(julRootClient, rootThreadName);
+		sessiondThreadJULRoot.setDaemon(true);
+		sessiondThreadJULRoot.start();
 
 		return numThreads;
 	}
@@ -259,23 +250,23 @@ public class LTTngAgent {
 	private synchronized Integer initLog4jClientThreads() {
 		Integer numThreads = 2;
 
-		this.log4jUserClient = new LTTngTCPSessiondClient(Domain.LOG4J,
-								  this.log4jUser,
-								  this.registerSem);
+		log4jUserClient = new LTTngTCPSessiondClient(Domain.LOG4J,
+								  log4jUser,
+								  registerSem);
 
 		String userThreadName = "LTTng UST agent Log4j user thread";
-		this.sessiondThreadLog4jUser = new Thread(log4jUserClient, userThreadName);
-		this.sessiondThreadLog4jUser.setDaemon(true);
-		this.sessiondThreadLog4jUser.start();
+		sessiondThreadLog4jUser = new Thread(log4jUserClient, userThreadName);
+		sessiondThreadLog4jUser.setDaemon(true);
+		sessiondThreadLog4jUser.start();
 
-		this.log4jRootClient = new LTTngTCPSessiondClient(Domain.LOG4J,
-								  this.log4jRoot,
-								  this.registerSem);
+		log4jRootClient = new LTTngTCPSessiondClient(Domain.LOG4J,
+								  log4jRoot,
+								  registerSem);
 
 		String rootThreadName = "LTTng UST agent Log4j root thread";
-		this.sessiondThreadLog4jRoot = new Thread(log4jRootClient,rootThreadName);
-		this.sessiondThreadLog4jRoot.setDaemon(true);
-		this.sessiondThreadLog4jRoot.start();
+		sessiondThreadLog4jRoot = new Thread(log4jRootClient,rootThreadName);
+		sessiondThreadLog4jRoot.setDaemon(true);
+		sessiondThreadLog4jRoot.start();
 
 		return numThreads;
 	}
@@ -283,28 +274,28 @@ public class LTTngAgent {
 
 	public void dispose() throws IOException {
 		if (this.useJUL) {
-			this.julUserClient.destroy();
-			this.julRootClient.destroy();
-			this.julUser.reset();
-			this.julRoot.reset();
+			julUserClient.destroy();
+			julRootClient.destroy();
+			julUser.reset();
+			julRoot.reset();
 		}
 
 		if (this.useLog4j) {
-			this.log4jUserClient.destroy();
-			this.log4jRootClient.destroy();
-			this.log4jUser.reset();
-			this.log4jRoot.reset();
+			log4jUserClient.destroy();
+			log4jRootClient.destroy();
+			log4jUser.reset();
+			log4jRoot.reset();
 		}
 
 		try {
 			if (this.useJUL) {
-				this.sessiondThreadJULUser.join();
-				this.sessiondThreadJULRoot.join();
+				sessiondThreadJULUser.join();
+				sessiondThreadJULRoot.join();
 			}
 
 			if (this.useLog4j) {
-				this.sessiondThreadLog4jUser.join();
-				this.sessiondThreadLog4jRoot.join();
+				sessiondThreadLog4jUser.join();
+				sessiondThreadLog4jRoot.join();
 			}
 
 		} catch (InterruptedException e) {
diff --git a/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngSessiondCmd2_6.java b/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngSessiondCmd2_6.java
index c68308e..3497689 100644
--- a/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngSessiondCmd2_6.java
+++ b/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngSessiondCmd2_6.java
@@ -20,11 +20,9 @@ package org.lttng.ust.agent;
 
 import java.nio.ByteBuffer;
 import java.nio.ByteOrder;
-import java.lang.Object;
 import java.util.ArrayList;
-import java.util.List;
-import java.util.Enumeration;
 import java.util.Iterator;
+import java.util.List;
 
 interface LTTngSessiondCmd2_6 {
 	/**
diff --git a/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngTCPSessiondClient.java b/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngTCPSessiondClient.java
index ab800ed..f16743c 100644
--- a/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngTCPSessiondClient.java
+++ b/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngTCPSessiondClient.java
@@ -17,20 +17,18 @@
 
 package org.lttng.ust.agent;
 
-import java.util.concurrent.Semaphore;
-import java.nio.ByteBuffer;
-import java.nio.ByteOrder;
-import java.lang.Integer;
-import java.io.IOException;
-import java.io.BufferedOutputStream;
 import java.io.BufferedReader;
-import java.io.ByteArrayOutputStream;
-import java.io.DataOutputStream;
 import java.io.DataInputStream;
-import java.io.FileReader;
+import java.io.DataOutputStream;
 import java.io.FileNotFoundException;
-import java.net.*;
+import java.io.FileReader;
+import java.io.IOException;
 import java.lang.management.ManagementFactory;
+import java.net.Socket;
+import java.net.UnknownHostException;
+import java.nio.ByteBuffer;
+import java.nio.ByteOrder;
+import java.util.concurrent.Semaphore;
 
 class LTTngTCPSessiondClient implements Runnable {
 
@@ -142,7 +140,7 @@ class LTTngTCPSessiondClient implements Runnable {
 	 */
 	private void recvHeader() throws Exception {
 		int read_len;
-		byte data[] = new byte[this.headerCmd.SIZE];
+		byte data[] = new byte[LTTngSessiondCmd2_6.sessiond_hdr.SIZE];
 
 		read_len = this.inFromSessiond.read(data, 0, data.length);
 		if (read_len != data.length) {
@@ -174,7 +172,6 @@ class LTTngTCPSessiondClient implements Runnable {
 	 * Handle session command from the session daemon.
 	 */
 	private void handleSessiondCmd() throws Exception {
-		int ret_code;
 		byte data[] = null;
 
 		while (true) {
@@ -238,8 +235,6 @@ class LTTngTCPSessiondClient implements Runnable {
 					data = new byte[4];
 					ByteBuffer buf = ByteBuffer.wrap(data);
 					buf.order(ByteOrder.BIG_ENDIAN);
-					LTTngSessiondCmd2_6.lttng_agent_ret_code code =
-						LTTngSessiondCmd2_6.lttng_agent_ret_code.CODE_INVALID_CMD;
 					break;
 				}
 			}
@@ -297,7 +292,7 @@ class LTTngTCPSessiondClient implements Runnable {
 			}
 		}
 
-		this.sessiondSock = new Socket(this.sessiondHost, port);
+		this.sessiondSock = new Socket(sessiondHost, port);
 		this.inFromSessiond = new DataInputStream(
 				sessiondSock.getInputStream());
 		this.outToSessiond = new DataOutputStream(
@@ -311,8 +306,8 @@ class LTTngTCPSessiondClient implements Runnable {
 
 		buf.putInt(this.agentDomain.value());
 		buf.putInt(Integer.parseInt(pid));
-		buf.putInt(this.protocolMajorVersion);
-		buf.putInt(this.protocolMinorVersion);
+		buf.putInt(protocolMajorVersion);
+		buf.putInt(protocolMinorVersion);
 		this.outToSessiond.write(data, 0, data.length);
 		this.outToSessiond.flush();
 	}
diff --git a/liblttng-ust-java-agent/java/org/lttng/ust/agent/log4j/LTTngLog4j.java b/liblttng-ust-java-agent/java/org/lttng/ust/agent/log4j/LTTngLog4j.java
index 065b163..6e892bc 100644
--- a/liblttng-ust-java-agent/java/org/lttng/ust/agent/log4j/LTTngLog4j.java
+++ b/liblttng-ust-java-agent/java/org/lttng/ust/agent/log4j/LTTngLog4j.java
@@ -69,7 +69,7 @@ public class LTTngLog4j extends LogFrameworkSkeleton {
 	@Override
 	public Iterator<String> listLoggers() {
 		Vector<String> logs = new Vector<String>();
-		for (Enumeration loggers = LogManager.getCurrentLoggers(); loggers.hasMoreElements(); ) {
+		for (Enumeration<?> loggers = LogManager.getCurrentLoggers(); loggers.hasMoreElements(); ) {
 			Logger logger = (Logger) loggers.nextElement();
 			String name = logger.getName();
 			logs.add(name);
-- 
2.1.4
