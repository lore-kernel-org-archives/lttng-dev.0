From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Fix: Use env CLASSPATH when building
	log4j example
Date: Thu, 25 Jun 2015 19:00:22 -0400
Message-ID: <1435273222-19462-1-git-send-email-mjeanson__14130.4099736319$1435273308$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1Z8G8P-0006E8-RU
 for lttng-dev@lists.lttng.org; Thu, 25 Jun 2015 19:00:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B4C903403F5
 for <lttng-dev@lists.lttng.org>; Thu, 25 Jun 2015 23:00:36 +0000 (UTC)
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

The location of the log4j jar file is specified during configure with
the CLASSPATH envvar, reuse it when building the example.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 doc/examples/java-log4j/Makefile | 10 +++++++---
 doc/examples/java-log4j/run      | 10 +++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/doc/examples/java-log4j/Makefile b/doc/examples/java-log4j/Makefile
index 4b59964..2c629c3 100644
--- a/doc/examples/java-log4j/Makefile
+++ b/doc/examples/java-log4j/Makefile
@@ -20,7 +20,11 @@ JFLAGS = -g
 
 # Default JUL jar name.
 JARFILE=liblttng-ust-agent.jar
-LOG4J=/usr/share/java/log4j.jar
+
+# If system classpath is empty, try to guess log4j location
+ifeq "$(CLASSPATH)" ""
+	CLASSPATH="/usr/local/share/java/log4j.jar:/usr/share/java/log4j.jar"
+endif
 
 # Check if the top level makefile overrides the JUL Jar file name.
 ifneq "$(JAVA_JARFILE_OVERRIDE)" ""
@@ -29,9 +33,9 @@ endif
 
 # Check if the top level makefile overrides the JUL classpath.
 ifeq "$(JAVA_CLASSPATH_OVERRIDE)" ""
-	CLASSPATH=/usr/local/share/java/$(JARFILE):/usr/share/java/$(JARFILE):$(LOG4J)
+	CLASSPATH:=/usr/local/share/java/$(JARFILE):/usr/share/java/$(JARFILE):$(CLASSPATH)
 else
-	CLASSPATH=$(JAVA_CLASSPATH_OVERRIDE)/$(JARFILE):$(LOG4J)
+	CLASSPATH:=$(JAVA_CLASSPATH_OVERRIDE)/$(JARFILE):$(CLASSPATH)
 endif
 
 JC = javac -classpath "$(CLASSPATH):."
diff --git a/doc/examples/java-log4j/run b/doc/examples/java-log4j/run
index 5e3cbeb..9dca608 100755
--- a/doc/examples/java-log4j/run
+++ b/doc/examples/java-log4j/run
@@ -8,15 +8,19 @@
 
 DIR=`dirname $0`
 JARFILE="liblttng-ust-agent.jar"
-LOG4J="/usr/local/share/java/log4j.jar:/usr/share/java/log4j.jar"
+
+# If system classpath is empty, try to guess log4j location
+if [ "x$CLASSPATH" = "x" ]; then
+	CLASSPATH="/usr/local/share/java/log4j.jar:/usr/share/java/log4j.jar"
+fi
 
 cd $DIR
 
 if [ -f "$DIR/.intree" ]; then
-	CLASSPATH="../../../liblttng-ust-java-agent/java/$JARFILE:$LOG4J"
+	CLASSPATH="../../../liblttng-ust-java-agent/java/$JARFILE:$CLASSPATH"
 	LIBPATH="../../../liblttng-ust-java-agent/jni/log4j/.libs"
 else
-	CLASSPATH="/usr/local/share/java/$JARFILE:/usr/share/java/$JARFILE:$LOG4J"
+	CLASSPATH="/usr/local/share/java/$JARFILE:/usr/share/java/$JARFILE:$CLASSPATH"
 	# Use system defined java.library.path
 	#LIBPATH="/usr/local/lib:/usr/lib"
 fi
-- 
1.9.1
