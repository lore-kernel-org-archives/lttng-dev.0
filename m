From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tool 2/2] Fix: test: log4j: missing static
	test files for dist and out of tree build
Date: Fri, 30 Jan 2015 17:04:57 -0500
Message-ID: <1422655497-12445-2-git-send-email-jonathan.rajotte-julien__42343.6384102844$1422655592$gmane$org@efficios.com>
References: <1422655497-12445-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YHJh6-0005mt-Sw
 for lttng-dev@lists.lttng.org; Fri, 30 Jan 2015 17:05:41 -0500
In-Reply-To: <1422655497-12445-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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
 tests/regression/ust/java-log4j/Makefile.am | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/regression/ust/java-log4j/Makefile.am b/tests/regression/ust/java-log4j/Makefile.am
index 7035ecf..7d6c048 100644
--- a/tests/regression/ust/java-log4j/Makefile.am
+++ b/tests/regression/ust/java-log4j/Makefile.am
@@ -1,4 +1,3 @@
-if BUILD_JAVA_LOG4J_AGENT
 
 noinst_SCRIPTS = test_java_log4j JTestLTTng.java
 EXTRA_DIST = test_java_log4j JTestLTTng.java
@@ -9,14 +8,19 @@ else
 JCC=javac
 endif
 
-all-local: JTestLTTng.class
+# We still need to copy static files for out of tree and dist build
+if BUILD_JAVA_LOG4J_AGENT
+all-local: static_file JTestLTTng.class
 
 %.class: %.java
 	$(JCC) -d "$(builddir)" $(JAVACFLAGS) $<
+else
+all-local: static_file
+endif # BUILD_JAVA_LOG4J_AGENT
 
 JTestLTTng.class: JTestLTTng.java
 
-all-local:
+static_file:
 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
 		for script in $(EXTRA_DIST); do \
 			cp -f $(srcdir)/$$script $(builddir); \
@@ -31,4 +35,3 @@ clean-local:
 		done; \
 	fi
 
-endif # BUILD_JAVA_LOG4J_AGENT
-- 
1.9.1
