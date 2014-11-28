From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-ust] Fix: Shorthand option -cp not
	supported in all version of Java
Date: Fri, 28 Nov 2014 16:39:50 -0500
Message-ID: <1417210790-5126-1-git-send-email-christian.babeux__1461.42199305377$1417210854$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <christian.babeux@0x80.ca>) id 1XuTGv-0001RH-GP
 for lttng-dev@lists.lttng.org; Fri, 28 Nov 2014 16:40:15 -0500
Received: by mail-qc0-f180.google.com with SMTP id i8so5384655qcq.11
 for <lttng-dev@lists.lttng.org>; Fri, 28 Nov 2014 13:40:08 -0800 (PST)
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
 doc/examples/java-jul/Makefile           | 2 +-
 doc/examples/java-jul/run                | 2 +-
 doc/examples/java-log4j/Makefile         | 2 +-
 doc/examples/java-log4j/run              | 2 +-
 liblttng-ust-java-agent/java/Makefile.am | 4 ++--
 liblttng-ust-java/Makefile.am            | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/examples/java-jul/Makefile b/doc/examples/java-jul/Makefile
index a45719d..1431b60 100644
--- a/doc/examples/java-jul/Makefile
+++ b/doc/examples/java-jul/Makefile
@@ -32,7 +32,7 @@ else
 endif
 
 JFLAGS = -g
-JC = javac -cp "$(CLASSPATH):."
+JC = javac -classpath "$(CLASSPATH):."
 .SUFFIXES: .java .class
 .java.class:
 	$(JC) $(JFLAGS) $*.java
diff --git a/doc/examples/java-jul/run b/doc/examples/java-jul/run
index b8342f7..1beac85 100755
--- a/doc/examples/java-jul/run
+++ b/doc/examples/java-jul/run
@@ -19,6 +19,6 @@ else
 	LIBPATH="/usr/local/lib:/usr/lib"
 fi
 
-java -cp "$CLASSPATH:." -Djava.library.path="$LIBPATH" Hello
+java -classpath "$CLASSPATH:." -Djava.library.path="$LIBPATH" Hello
 
 cd -
diff --git a/doc/examples/java-log4j/Makefile b/doc/examples/java-log4j/Makefile
index e174e31..4b59964 100644
--- a/doc/examples/java-log4j/Makefile
+++ b/doc/examples/java-log4j/Makefile
@@ -34,7 +34,7 @@ else
 	CLASSPATH=$(JAVA_CLASSPATH_OVERRIDE)/$(JARFILE):$(LOG4J)
 endif
 
-JC = javac -cp "$(CLASSPATH):."
+JC = javac -classpath "$(CLASSPATH):."
 .SUFFIXES: .java .class
 .java.class:
 	$(JC) $(JFLAGS) $*.java
diff --git a/doc/examples/java-log4j/run b/doc/examples/java-log4j/run
index 3a84f59..128725f 100755
--- a/doc/examples/java-log4j/run
+++ b/doc/examples/java-log4j/run
@@ -20,6 +20,6 @@ else
 	LIBPATH="/usr/local/lib:/usr/lib"
 fi
 
-java -cp "$CLASSPATH:." Hello
+java -classpath "$CLASSPATH:." Hello
 
 cd -
diff --git a/liblttng-ust-java-agent/java/Makefile.am b/liblttng-ust-java-agent/java/Makefile.am
index f9344bb..bcf6abe 100644
--- a/liblttng-ust-java-agent/java/Makefile.am
+++ b/liblttng-ust-java-agent/java/Makefile.am
@@ -53,11 +53,11 @@ $(jarfile_old): classnoinst.stamp
 	$(pkgpath)/jul/*.class $(pkgpath_old)/*.class
 
 jul-jni-header.stamp: $(dist_noinst_JAVA)
-	$(JAVAH) -cp $(CLASSPATH):$(srcdir) -d $(juljniout) $(JAVAHFLAGS) org.lttng.ust.agent.jul.LTTngLogHandler && \
+	$(JAVAH) -classpath $(CLASSPATH):$(srcdir) -d $(juljniout) $(JAVAHFLAGS) org.lttng.ust.agent.jul.LTTngLogHandler && \
 	echo "JUL JNI header generated" > jul-jni-header.stamp
 
 log4j-jni-header.stamp: $(dist_noinst_JAVA)
-	$(JAVAH) -cp $(CLASSPATH):$(srcdir) -d $(log4jjniout) $(JAVAHFLAGS) org.lttng.ust.agent.log4j.LTTngLogAppender && \
+	$(JAVAH) -classpath $(CLASSPATH):$(srcdir) -d $(log4jjniout) $(JAVAHFLAGS) org.lttng.ust.agent.log4j.LTTngLogAppender && \
 	echo "Log4j JNI header generated" > log4j-jni-header.stamp
 
 all-local: $(stamp)
diff --git a/liblttng-ust-java/Makefile.am b/liblttng-ust-java/Makefile.am
index fee9b7d..baada57 100644
--- a/liblttng-ust-java/Makefile.am
+++ b/liblttng-ust-java/Makefile.am
@@ -20,7 +20,7 @@ $(jarfile): classnoinst.stamp
 org_lttng_ust_LTTngUst.h: jni-header.stamp
 
 jni-header.stamp: $(dist_noinst_JAVA)
-	$(JAVAH) -cp $(srcdir) $(JAVAHFLAGS) org.lttng.ust.LTTngUst && \
+	$(JAVAH) -classpath $(srcdir) $(JAVAHFLAGS) org.lttng.ust.LTTngUst && \
 	echo "JNI header generated" > jni-header.stamp
 
 all-local: org_lttng_ust_LTTngUst.h
-- 
2.1.1
