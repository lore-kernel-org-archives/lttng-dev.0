From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 5/5] Tests: Add health check tests
	to configure
Date: Thu, 27 Sep 2012 14:25:21 -0400
Message-ID: <1348770321-1670-1-git-send-email-christian.babeux__26490.6776989394$1348770430$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1THImI-0003QC-S8
	for lttng-dev@lists.lttng.org; Thu, 27 Sep 2012 14:25:38 -0400
Received: by qcon41 with SMTP id n41so1940182qco.35
	for <lttng-dev@lists.lttng.org>; Thu, 27 Sep 2012 11:25:33 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Add health folder to top-level tests Makefile.am.
Also add a runall script to run all health check tests.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 configure.ac              |  1 +
 tests/tools/Makefile.am   |  2 +-
 tests/tools/health/runall | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100755 tests/tools/health/runall

diff --git a/configure.ac b/configure.ac
index 36c137b..713daa9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -288,6 +288,7 @@ AC_CONFIG_FILES([
 	tests/kernel/Makefile
 	tests/tools/Makefile
 	tests/tools/streaming/Makefile
+	tests/tools/health/Makefile
 	tests/ust/Makefile
 	tests/ust/nprocesses/Makefile
 	tests/ust/high-throughput/Makefile
diff --git a/tests/tools/Makefile.am b/tests/tools/Makefile.am
index 3d25900..faa836c 100644
--- a/tests/tools/Makefile.am
+++ b/tests/tools/Makefile.am
@@ -1,4 +1,4 @@
-SUBDIRS = streaming
+SUBDIRS = streaming health
 
 AM_CFLAGS = -g -Wall -I../
 AM_LDFLAGS = -lurcu -lurcu-cds
diff --git a/tests/tools/health/runall b/tests/tools/health/runall
new file mode 100755
index 0000000..c22e353
--- /dev/null
+++ b/tests/tools/health/runall
@@ -0,0 +1,28 @@
+#!/bin/bash
+
+DIR=$(dirname $0)
+
+tests=( $DIR/health_thread_exit $DIR/health_thread_stall )
+exit_code=0
+
+function start_tests ()
+{
+	for bin in ${tests[@]};
+	do
+		if [ ! -e $bin ]; then
+			echo -e "$bin not found, passing"
+			continue
+		fi
+
+		./$bin
+		# Test must return 0 to pass.
+		if [ $? -ne 0 ]; then
+			exit_code=1
+			break
+		fi
+	done
+}
+
+start_tests
+
+exit $exit_code
-- 
1.7.12
