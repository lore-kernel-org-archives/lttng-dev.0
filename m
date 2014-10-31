From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-ust] Update Java agent documentation
Date: Fri, 31 Oct 2014 15:33:40 -0400
Message-ID: <1414784020-11301-1-git-send-email-christian.babeux__46399.8284926221$1414784093$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <christian.babeux@0x80.ca>) id 1XkHxR-0003rS-4W
 for lttng-dev@lists.lttng.org; Fri, 31 Oct 2014 15:34:03 -0400
Received: by mail-qa0-f45.google.com with SMTP id dc16so5762422qab.32
 for <lttng-dev@lists.lttng.org>; Fri, 31 Oct 2014 12:33:55 -0700 (PDT)
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
 doc/Makefile.am           |  2 +-
 doc/java-agent.txt        | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 doc/java-util-logging.txt | 41 -------------------------------------
 3 files changed, 52 insertions(+), 42 deletions(-)
 create mode 100644 doc/java-agent.txt
 delete mode 100644 doc/java-util-logging.txt

diff --git a/doc/Makefile.am b/doc/Makefile.am
index 72dcde2..ba21e9f 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -5,4 +5,4 @@ dist_man_MANS = man/lttng-gen-tp.1 \
 	man/lttng-ust-dl.3 \
 	man/lttng-ust-cyg-profile.3
 
-dist_doc_DATA = java-util-logging.txt
+dist_doc_DATA = java-agent.txt
diff --git a/doc/java-agent.txt b/doc/java-agent.txt
new file mode 100644
index 0000000..51b0e8c
--- /dev/null
+++ b/doc/java-agent.txt
@@ -0,0 +1,51 @@
+The agent can now be built in three different configurations:
+
+1) Java agent with JUL support:
+
+$ ./configure --enable-java-agent-jul
+
+2) Java agent with Log4j support:
+
+$ export CLASSPATH=$CLASSPATH:/path/to/log4j.jar
+$ ./configure --enable-java-agent-log4j
+
+3) Java agent with JUL + Log4j support
+
+$ export CLASSPATH=$CLASSPATH:/path/to/log4j.jar
+$ ./configure --enable-java-agent-all
+
+To build the agent with log4j support, make sure that the log4j jar
+is in your Java classpath.
+
+The configure script will automatically detect the appropriate Java
+binaries to use in order to build the Java agent.
+
+The name of the agent jar file is now "liblttng-ust-agent.jar".
+It will be installed in the arch-agnostic "$prefix/share/java" path
+e.g: "/usr/share/java".
+
+In order to support older applications using the "org.lttng.ust.jul"
+package, a transitional package is built with the same name.
+
+All applications should move to use the "org.lttng.ust.agent" package.
+
+After building, you can use the "liblttng-ust-agent.jar" file in a
+Java project.  Depending on your configuration, the agent will
+requires shared objects (e.g: "liblttng-ust-jul.so") which is installed
+by the build system when doing "make install". Make sure that your
+Java application can find this shared object with the
+"java.library.path".
+
+In order to enable the agent in your Java application, you simply have to add
+this as early as you can in the runtime process.
+
+import org.lttng.ust.agent.LTTngAgent;
+[...]
+	private static LTTngAgent lttngAgent;
+	[...]
+	lttngAgent = LTTngAgent.getLTTngAgent();
+
+This will initialize automatically the singleton LTTngAgent, and will
+return when the session daemon registration is done. If no session daemon is
+available, the execution will continue and the agent will retry every
+3 seconds.
diff --git a/doc/java-util-logging.txt b/doc/java-util-logging.txt
deleted file mode 100644
index 9f827e6..0000000
--- a/doc/java-util-logging.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-The support for JUL needs to be explicitly enabled when lttng-ust is
-configured, e.g.:
-
-dependency: openjdk-7-jdk
-    ./configure --with-java-jdk=/usr/lib/jvm/java-7-openjdk --with-jni-interface
-
-On Debian system for instance you can simply use the "default-java" path:
-
-    ./configure --with-java-jdk=/usr/lib/jvm/default-java --with-jni-interface
-
-Note that the OpenJDK 7 is used for development and continuous integration thus
-we directly support that version for this library. However, it has been tested
-with OpenJDK 6 also. Please let us know if other Java version (commercial or
-not) work with this library.
-
-The LTTng Java Agent for JUL support is typically installed here:
-
-/usr/local/lib/lttng/java/liblttng-ust-jul.jar
-
-After building, you can use the "liblttng-ust-jul.jar" file in a Java project.
-It requires "liblttng-ust-jul.so" which is installed by the build system when
-doing "make install". Make sure that your Java application can find this shared
-object with the "java.library.path".
-
-In order to enable the agent in your Java application, you simply have to add
-this as early as you can in the runtime process.
-
-import org.lttng.ust.jul.LTTngAgent;
-[...]
-	private static LTTngAgent lttngAgent;
-	[...]
-	lttngAgent = LTTngAgent.getLTTngAgent();
-
-This will initialize automatically the singleton LTTngAgent, and will
-return when session daemon registration is done. If no session daemon is
-available, the execution will continue and the agent will retry every
-3 seconds.
-
-Once registered, it is adds a thread inside your Java application and will be
-able to automatically use every Logger object and map them to the jul_event
-tracepoint of the JNI interface.
-- 
2.1.1
