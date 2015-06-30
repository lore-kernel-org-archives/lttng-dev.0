From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Fix: running java examples out of tree
Date: Tue, 30 Jun 2015 17:32:56 -0400
Message-ID: <1435699976-8809-1-git-send-email-mjeanson__23006.3853240155$1435700069$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZA39V-0000Hr-Sr
 for lttng-dev@lists.lttng.org; Tue, 30 Jun 2015 17:33:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B19183404A9
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jun 2015 21:33:08 +0000 (UTC)
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

---
 doc/examples/java-jul/run   | 7 ++++++-
 doc/examples/java-log4j/run | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/doc/examples/java-jul/run b/doc/examples/java-jul/run
index 37a3cfd..6deb6fd 100755
--- a/doc/examples/java-jul/run
+++ b/doc/examples/java-jul/run
@@ -8,6 +8,7 @@
 
 DIR=`dirname $0`
 JARFILE="liblttng-ust-agent.jar"
+JAVA_OPTIONS=""
 
 cd $DIR
 
@@ -20,6 +21,10 @@ else
 	#LIBPATH="/usr/local/lib:/usr/lib"
 fi
 
-java -classpath "$CLASSPATH:." -Djava.library.path="$LIBPATH" Hello
+if [ "x$LIBPATH" != "x" ]; then
+	JAVA_OPTIONS="$JAVA_OPTIONS -Djava.library.path=\"$LIBPATH\""
+fi
+
+java -classpath "$CLASSPATH:." $JAVA_OPTIONS Hello
 
 cd -
diff --git a/doc/examples/java-log4j/run b/doc/examples/java-log4j/run
index 9dca608..91f8f5d 100755
--- a/doc/examples/java-log4j/run
+++ b/doc/examples/java-log4j/run
@@ -8,6 +8,7 @@
 
 DIR=`dirname $0`
 JARFILE="liblttng-ust-agent.jar"
+JAVA_OPTIONS=""
 
 # If system classpath is empty, try to guess log4j location
 if [ "x$CLASSPATH" = "x" ]; then
@@ -25,6 +26,10 @@ else
 	#LIBPATH="/usr/local/lib:/usr/lib"
 fi
 
-java -classpath "$CLASSPATH:." -Djava.library.path="$LIBPATH" Hello
+if [ "x$LIBPATH" != "x" ]; then
+	JAVA_OPTIONS="$JAVA_OPTIONS -Djava.library.path=\"$LIBPATH\""
+fi
+
+java -classpath "$CLASSPATH:." $JAVA_OPTIONS Hello
 
 cd -
-- 
1.9.1
