From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tool 1/2] Fix: test: java-jul:missing
	static test files for dist and out of tree build
Date: Fri, 30 Jan 2015 17:04:56 -0500
Message-ID: <1422655497-12445-1-git-send-email-jonathan.rajotte-julien__15110.1069445305$1422655578$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YHJh3-0005ms-Mk
 for lttng-dev@lists.lttng.org; Fri, 30 Jan 2015 17:05:38 -0500
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
 tests/regression/ust/java-jul/Makefile.am | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/regression/ust/java-jul/Makefile.am b/tests/regression/ust/java-jul/Makefile.am
index 4446c52..286e3df 100644
--- a/tests/regression/ust/java-jul/Makefile.am
+++ b/tests/regression/ust/java-jul/Makefile.am
@@ -1,4 +1,3 @@
-if BUILD_JAVA_AGENT
 
 noinst_SCRIPTS = test_java_jul JTestLTTng.java
 EXTRA_DIST = test_java_jul JTestLTTng.java
@@ -11,20 +10,25 @@ endif
 
 AGENT_JAR_FILE=$(java_agent_jar_path)
 
-all-local: JTestLTTng.class
 
+# Still need to copy test files in case of out of tree build
+if BUILD_JAVA_AGENT
+all-local: static_file JTestLTTng.class
 %.class: %.java
 	$(JCC) -d "$(builddir)" -cp "$(AGENT_JAR_FILE):." $<
+else
+all-local: static_file
+endif # BUILD_JAVA_AGENT
 
-JTestLTTng.class: JTestLTTng.java
 
-all-local:
+static_file:
 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
 		for script in $(EXTRA_DIST); do \
 			cp -f $(srcdir)/$$script $(builddir); \
 		done; \
 	fi
 
+
 clean-local:
 	rm -f *.class
 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
@@ -33,4 +37,3 @@ clean-local:
 		done; \
 	fi
 
-endif # BUILD_JAVA_AGENT
-- 
1.9.1
