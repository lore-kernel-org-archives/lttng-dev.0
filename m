From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Tests: Java agent: Add configure
	switches to enable tests
Date: Thu,  6 Aug 2015 12:39:13 -0400
Message-ID: <1438879153-21852-1-git-send-email-mjeanson__9007.88926887817$1438879243$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZNOCn-0005UA-1K
 for lttng-dev@lists.lttng.org; Thu, 06 Aug 2015 12:39:49 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

This patch adds the switches --enable-test-java-agent-(jul|log4j|all) to
the configure script, the tests now need to be explicitly enabled and
their dependencies are only checked if so.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac                                | 94 ++++++++++++++++++++---------
 tests/regression/ust/java-jul/Makefile.am   |  4 +-
 tests/regression/ust/java-log4j/Makefile.am |  4 +-
 3 files changed, 69 insertions(+), 33 deletions(-)

diff --git a/configure.ac b/configure.ac
index bfef178..4e6c06e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -131,6 +131,25 @@ AC_ARG_WITH([lttng-system-rundir],
 	[LTTNG_SYSTEM_RUNDIR="/var/run/lttng"])
 AC_SUBST([LTTNG_SYSTEM_RUNDIR])
 
+AC_ARG_ENABLE([test-java-agent-jul],
+	[AS_HELP_STRING([--enable-test-java-agent-jul],[enable the LTTng UST Java agent JUL tests [default=no]])],
+	[test_java_agent_jul=$enableval],
+	[test_java_agent_jul=no]
+)
+
+AC_ARG_ENABLE([test-java-agent-log4j],
+        [AS_HELP_STRING([--enable-test-java-agent-log4j],[enable the LTTng UST Java agent Log4j tests [default=no]])],
+        [test_java_agent_log4j=$enableval],
+        [test_java_agent_log4j=no]
+)
+
+AC_ARG_ENABLE([test-java-agent-all],
+        [AS_HELP_STRING([--enable-test-java-agent-all],[enable all the LTTng UST Java agent tests [default=no]])],
+        [test_java_agent_jul=$enableval
+         test_java_agent_log4j=$enableval],
+        [:]
+)
+
 AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_BIN], "$CONSUMERD32_BIN", [Location of the 32-bit consumerd executable.])
 AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD64_BIN], "$CONSUMERD64_BIN", [Location of the 64-bit consumerd executable])
 AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_LIBDIR], "$CONSUMERD32_LIBDIR", [Search for consumerd 32-bit libraries in this location.])
@@ -355,44 +374,45 @@ AX_CONFIG_FEATURE(
 )
 AM_CONDITIONAL([COMPAT_EPOLL], [ test "$enable_epoll" = "yes" ])
 
-AX_JAVA_OPTIONS
-AX_PROG_JAVAC
-AX_PROG_JAVA
-AX_PROG_JAR
+AM_CONDITIONAL([TEST_JAVA_JUL_AGENT], [test "x$test_java_agent_jul" = "xyes"])
+AM_CONDITIONAL([TEST_JAVA_LOG4J_AGENT], [test "x$test_java_agent_log4j" = "xyes"])
 
-AX_CHECK_CLASSPATH
+if test "x$test_java_agent_jul" = "xyes" || test "x$test_java_agent_log4j" = "xyes"; then
+	AX_JAVA_OPTIONS
+	AX_PROG_JAVAC
+	AX_PROG_JAVA
+	AX_PROG_JAR
 
-# Check for Java UST agent common class first
-AX_CHECK_CLASS(org.lttng.ust.agent.AbstractLttngAgent)
-if test "x$ac_cv_class_org_lttng_ust_agent_AbstractLttngAgent" = "xyes"; then
-	java_agent_common=yes
-else
-	java_agent_common=no
-fi
-
-# If the common class is available, test for each agent
-if test "x$java_agent_common" = "xyes"; then
-	# Check for JUL
-	AX_CHECK_CLASS(org.lttng.ust.agent.jul.LttngLogHandler)
-	AX_CHECK_CLASS(org.lttng.ust.agent.log4j.LttngLogAppender)
-	AX_CHECK_CLASS(org.apache.log4j.Logger)
+	AX_CHECK_CLASSPATH
 
-	build_java_jul_agent=no
-	if test "x$ac_cv_class_org_lttng_ust_agent_jul_LttngLogHandler" = "xyes"; then
-		build_java_jul_agent=yes
+	# Check for Java UST agent common class first
+	AX_CHECK_CLASS(org.lttng.ust.agent.AbstractLttngAgent)
+	if test "x$ac_cv_class_org_lttng_ust_agent_AbstractLttngAgent" = "xno"; then
+		AC_MSG_ERROR([The UST Java agent common class was not found. Please specify the location of the jar via the Java CLASSPATH e.g: export CLASSPATH="/path/to/lttng-ust-agent-common.jar"])
 	fi
 
-	build_java_log4j_agent=no
-	if test "x$ac_cv_class_org_lttng_ust_agent_log4j_LttngLogAppender" = "xyes"; then
-		if test "x$ac_cv_class_org_apache_log4j_Logger" = "xyes"; then
-			build_java_log4j_agent=yes
+	if test "x$test_java_agent_jul" = "xyes"; then
+		# Check for JUL agent class
+		AX_CHECK_CLASS(org.lttng.ust.agent.jul.LttngLogHandler)
+		if test "x$ac_cv_class_org_lttng_ust_agent_jul_LttngLogHandler" = "xno"; then
+			AC_MSG_ERROR([The UST Java agent JUL class was not found. Please specify the location of the jar via the Java CLASSPATH e.g: export CLASSPATH="/path/to/lttng-ust-agent-jul.jar"])
 		fi
 	fi
 
-fi
+	if test "x$test_java_agent_log4j" = "xyes"; then
+		# Check for Log4j agent class
+		AX_CHECK_CLASS(org.lttng.ust.agent.log4j.LttngLogAppender)
+		if test "x$ac_cv_class_org_lttng_ust_agent_log4j_LttngLogAppender" = "xno"; then
+			AC_MSG_ERROR([The UST Java agent Log4j class was not found. Please specify the location of the jar via the Java CLASSPATH e.g: export CLASSPATH="/path/to/lttng-ust-agent-log4j.jar"])
+		fi
 
-AM_CONDITIONAL([BUILD_JAVA_JUL_AGENT], [test "x$build_java_jul_agent" = "xyes"])
-AM_CONDITIONAL([BUILD_JAVA_LOG4J_AGENT], [test "x$build_java_log4j_agent" = "xyes"])
+		# Check for Log4j class
+		AX_CHECK_CLASS(org.apache.log4j.Logger)
+		if test "x$ac_cv_class_org_apache_log4j_Logger" = "xno"; then
+			AC_MSG_ERROR([The Log4j class was not found. Please specify the location of the jar via the Java CLASSPATH e.g: export CLASSPATH="/path/to/log4j.jar"])
+		fi
+	fi
+fi
 
 AC_SYS_LARGEFILE
 
@@ -570,6 +590,22 @@ AS_IF([test "x$lttng_ust_support" = "xyes"],[
 	AS_ECHO("Disabled")
 ])
 
+# LTTng UST Java agent JUL tests enabled/disabled
+AS_ECHO_N("LTTng-UST Java agent JUL tests: ")
+AS_IF([test "x$test_java_agent_jul" = "xyes"],[
+	AS_ECHO("Enabled")
+],[
+	AS_ECHO("Disabled")
+])
+
+# LTTng UST Java agent Log4j tests enabled/disabled
+AS_ECHO_N("LTTng-UST Java agent Log4j tests: ")
+AS_IF([test "x$test_java_agent_log4j" = "xyes"],[
+	AS_ECHO("Enabled")
+],[
+	AS_ECHO("Disabled")
+])
+
 #Python binding enabled/disabled
 AS_ECHO_N("Python binding: ")
 AS_IF([test "x${enable_python:-yes}" = xyes], [
diff --git a/tests/regression/ust/java-jul/Makefile.am b/tests/regression/ust/java-jul/Makefile.am
index 877237f..b0a04f3 100644
--- a/tests/regression/ust/java-jul/Makefile.am
+++ b/tests/regression/ust/java-jul/Makefile.am
@@ -3,9 +3,9 @@ JAVAROOT = .
 noinst_SCRIPTS = test_java_jul JTestLTTng.java
 EXTRA_DIST = test_java_jul JTestLTTng.java
 
-if BUILD_JAVA_JUL_AGENT
+if TEST_JAVA_JUL_AGENT
 dist_noinst_JAVA = JTestLTTng.java
-endif # BUILD_JAVA_JUL_AGENT
+endif # TEST_JAVA_JUL_AGENT
 
 all-local: static_file
 
diff --git a/tests/regression/ust/java-log4j/Makefile.am b/tests/regression/ust/java-log4j/Makefile.am
index 42daab8..60d5c37 100644
--- a/tests/regression/ust/java-log4j/Makefile.am
+++ b/tests/regression/ust/java-log4j/Makefile.am
@@ -3,9 +3,9 @@ JAVAROOT = .
 noinst_SCRIPTS = test_java_log4j JTestLTTng.java
 EXTRA_DIST = test_java_log4j JTestLTTng.java
 
-if BUILD_JAVA_LOG4J_AGENT
+if TEST_JAVA_LOG4J_AGENT
 dist_noinst_JAVA = JTestLTTng.java
-endif # BUILD_JAVA_LOG4J_AGENT
+endif # TEST_JAVA_LOG4J_AGENT
 
 all-local: static_file
 
-- 
1.9.1
