From: Alexandre Montplaisir <alexmonthy@efficios.com>
Subject: [PATCH lttng-ust] Clarify and simplify the Java agent
	"Hello" examples
Date: Mon,  7 Mar 2016 16:43:01 -0500
Message-ID: <1457386981-14638-1-git-send-email-alexmonthy__32834.7914656208$1457387097$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@efficios.com>) id 1ad2vz-0001jJ-Pb
 for lttng-dev@lists.lttng.org; Mon, 07 Mar 2016 16:43:27 -0500
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

An "Hello World" type example should only mention the bare
minimum required, to avoid confusing new users further!

Signed-off-by: Alexandre Montplaisir <alexmonthy@efficios.com>
---
 doc/examples/java-jul/Hello.java   | 75 ++++++++++++--------------------------
 doc/examples/java-log4j/Hello.java | 42 +++++++++++++--------
 2 files changed, 51 insertions(+), 66 deletions(-)

diff --git a/doc/examples/java-jul/Hello.java b/doc/examples/java-jul/Hello.java
index 7016cf4..cb9f24b 100644
--- a/doc/examples/java-jul/Hello.java
+++ b/doc/examples/java-jul/Hello.java
@@ -43,6 +43,21 @@ import org.lttng.ust.agent.jul.LttngLogHandler;
  * the Logger, those will continue logging events normally.
  * </p>
  *
+ * <p>
+ * To obtain LTTng trace events, you should run the following sequence of
+ * commands:
+ * </p>
+ *
+ * <ul>
+ * <li>$ lttng create</li>
+ * <li>$ lttng enable-event -j -a</li>
+ * <li>$ lttng start</li>
+ * <li>(run this program)</li>
+ * <li>$ lttng stop</li>
+ * <li>$ lttng view</li>
+ * <li>$ lttng destroy</li>
+ * </ul>
+ *
  * @author Alexandre Montplaisir
  * @author David Goulet
  */
@@ -57,65 +72,23 @@ public class Hello {
 	 * @param args
 	 *            Command-line arguments
 	 * @throws IOException
-	 * @throws InterruptedException
+	 *             If the required native libraries cannot be found. You may
+	 *             have to specify "-Djava.library.path=..." on the "java"
+	 *             command line.
 	 */
-	public static void main(String args[]) throws IOException, InterruptedException {
+	public static void main(String args[]) throws IOException {
 
 		/* Instantiate a LTTngLogHandler object, and attach it to our logger */
 		Handler lttngHandler = new LttngLogHandler();
 		LOGGER.addHandler(lttngHandler);
 
-		/*
-		 * Gives you time to do some lttng commands before any event is hit.
-		 */
-		Thread.sleep(5000);
-
-		/* Trigger a tracing event using the JUL Logger created before. */
+		/* Log events using the JUL Logger created before. */
 		LOGGER.info("Hello World, the answer is " + 42);
+		LOGGER.info("Another info event");
+		LOGGER.severe("A severe event");
 
-		/*
-		 * From this point on, the above message will be collected in the trace
-		 * if the event "Hello" is enabled for the JUL domain using the lttng
-		 * command line or the lttng-ctl API. For instance:
-		 *
-		 *   $ lttng enable-event -j Hello
-		 */
-
-		/*
-		 * A new logger is created here and fired after. Typically with JUL, you
-		 * use one static Logger per class. This example here can represent a
-		 * class being lazy-loaded later in the execution of the application.
-		 *
-		 * The agent has an internal timer that is fired every 5 seconds in
-		 * order to enable events that were not found at first but might need to
-		 * be enabled when a new Logger appears. Unfortunately, there is no way
-		 * right now to get notified of that so we have to actively poll.
-		 *
-		 * Using the --all command for instance, it will make this Logger
-		 * available in a LTTng trace after the internal agent's timer is fired.
-		 * (lttng enable-event -j -a).
-		 */
-		Logger helloLogDelayed = Logger.getLogger("hello_delay");
-
-		/*
-		 * Attach a handler to this new logger.
-		 *
-		 * Using the same handler as before would also work.
-		 */
-		Handler lttngHandler2 = new LttngLogHandler();
-		helloLogDelayed.addHandler(lttngHandler2);
-
-		System.out.println("Firing hello delay in 10 seconds...");
-		Thread.sleep(10000);
-		helloLogDelayed.info("Hello World delayed...");
-
-		System.out.println("Cleaning Hello");
-
-		/*
-		 * Do not forget to close() all handlers so that the agent can shutdown
-		 * and the session daemon socket gets cleaned up explicitly.
-		 */
+		/* Cleanup */
+		LOGGER.removeHandler(lttngHandler);
 		lttngHandler.close();
-		lttngHandler2.close();
 	}
 }
diff --git a/doc/examples/java-log4j/Hello.java b/doc/examples/java-log4j/Hello.java
index c51d4d4..a477e33 100644
--- a/doc/examples/java-log4j/Hello.java
+++ b/doc/examples/java-log4j/Hello.java
@@ -29,7 +29,22 @@ import org.apache.log4j.Logger;
 import org.lttng.ust.agent.log4j.LttngLogAppender;
 
 /**
- * Example application using the LTTng-UST Java JUL agent.
+ * Example application using the LTTng-UST Java log4j agent.
+ *
+ * <p>
+ * To obtain LTTng trace events, you should run the following sequence of
+ * commands:
+ * </p>
+ *
+ * <ul>
+ * <li>$ lttng create</li>
+ * <li>$ lttng enable-event -l -a</li>
+ * <li>$ lttng start</li>
+ * <li>(run this program)</li>
+ * <li>$ lttng stop</li>
+ * <li>$ lttng view</li>
+ * <li>$ lttng destroy</li>
+ * </ul>
  *
  * @author Alexandre Montplaisir
  * @author Christian Babeux
@@ -44,15 +59,17 @@ public class Hello {
 	 * @param args
 	 *            Command-line arguments
 	 * @throws IOException
-	 * @throws InterruptedException
+	 *             If the required native libraries cannot be found. You may
+	 *             have to specify "-Djava.library.path=..." on the "java"
+	 *             command line.
 	 */
-	public static void main(String args[]) throws IOException, InterruptedException {
+	public static void main(String args[]) throws IOException {
 		/* Start with the default Log4j configuration, which logs to console */
 		BasicConfigurator.configure();
 
 		/*
-		 * Add a LTTng log appender to the logger, which will also send the
-		 * logged events to UST.
+		 * Instantiate a LTTng log appender and attach it to the logger, which
+		 * will now send the logged events to UST.
 		 */
 		Appender lttngAppender = new LttngLogAppender();
 		HELLO_LOG.addAppender(lttngAppender);
@@ -63,18 +80,13 @@ public class Hello {
 		 */
 		// PropertyConfigurator.configure(fileName);
 
-		/*
-		 * Gives you time to do some lttng commands before any event is hit.
-		 */
-		Thread.sleep(5000);
-
-		/* Trigger a tracing event using the Log4j Logger created before. */
+		/* Trigger some tracing events using the Log4j Logger created before. */
 		HELLO_LOG.info("Hello World, the answer is " + 42);
+		HELLO_LOG.info("Another info event");
+		HELLO_LOG.error("An error event");
 
-		System.out.println("Firing second event in 5 seconds...");
-		Thread.sleep(5000);
-		HELLO_LOG.info("Hello World delayed...");
-
+		/* Cleanup */
+		HELLO_LOG.removeAppender(lttngAppender);
 		lttngAppender.close();
 	}
 }
-- 
2.5.0
