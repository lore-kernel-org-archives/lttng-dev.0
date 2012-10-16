From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 5/5] Tests: Add filtering tests to
	configure
Date: Tue, 16 Oct 2012 14:33:23 -0400
Message-ID: <1350412403-9974-5-git-send-email-christian.babeux__28671.1893081248$1350412478$gmane$org@efficios.com>
References: <1350412403-9974-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TOBxl-0006dS-Jz
	for lttng-dev@lists.lttng.org; Tue, 16 Oct 2012 14:33:57 -0400
Received: by mail-qc0-f176.google.com with SMTP id n41so6175539qco.35
	for <lttng-dev@lists.lttng.org>; Tue, 16 Oct 2012 11:33:57 -0700 (PDT)
In-Reply-To: <1350412403-9974-1-git-send-email-christian.babeux@efficios.com>
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

Add filtering folder to top-level Makefile.am.
Also add a runall script to run all filtering tests.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 configure.ac                      |  1 +
 tests/tools/Makefile.am           |  2 +-
 tests/tools/filtering/Makefile.am |  4 ++--
 tests/tools/filtering/runall      | 28 ++++++++++++++++++++++++++++
 tests/tools/runall.sh             |  2 +-
 5 files changed, 33 insertions(+), 4 deletions(-)
 create mode 100755 tests/tools/filtering/runall

diff --git a/configure.ac b/configure.ac
index cb5dc38..fbaae6f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -288,6 +288,7 @@ AC_CONFIG_FILES([
 	tests/kernel/Makefile
 	tests/tools/Makefile
 	tests/tools/streaming/Makefile
+	tests/tools/filtering/Makefile
 	tests/tools/health/Makefile
 	tests/ust/Makefile
 	tests/ust/nprocesses/Makefile
diff --git a/tests/tools/Makefile.am b/tests/tools/Makefile.am
index 173dce2..56eda3a 100644
--- a/tests/tools/Makefile.am
+++ b/tests/tools/Makefile.am
@@ -1,4 +1,4 @@
-SUBDIRS = streaming health
+SUBDIRS = streaming filtering health
 
 AM_CFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src -I$(top_srcdir)/tests -g -Wall
 AM_LDFLAGS = -lurcu -lurcu-cds
diff --git a/tests/tools/filtering/Makefile.am b/tests/tools/filtering/Makefile.am
index a3bf866..e1e715d 100644
--- a/tests/tools/filtering/Makefile.am
+++ b/tests/tools/filtering/Makefile.am
@@ -14,5 +14,5 @@ gen_ust_events_SOURCES = gen-ust-events.c tp.c tp.h
 gen_ust_events_LDADD = -llttng-ust
 endif
 
-noinst_SCRIPTS = unsupported-ops invalid-filters valid-filters babelstats.pl
-EXTRA_DIST = unsupported-ops invalid-filters valid-filters babelstats.pl
+noinst_SCRIPTS = runall unsupported-ops invalid-filters valid-filters babelstats.pl
+EXTRA_DIST = runall unsupported-ops invalid-filters valid-filters babelstats.pl
diff --git a/tests/tools/filtering/runall b/tests/tools/filtering/runall
new file mode 100755
index 0000000..c92e399
--- /dev/null
+++ b/tests/tools/filtering/runall
@@ -0,0 +1,28 @@
+#!/bin/bash
+
+DIR=$(dirname $0)
+
+tests=( $DIR/unsupported-ops $DIR/invalid-filters $DIR/valid-filters )
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
diff --git a/tests/tools/runall.sh b/tests/tools/runall.sh
index 0ad7cf1..b2be91c 100755
--- a/tests/tools/runall.sh
+++ b/tests/tools/runall.sh
@@ -3,7 +3,7 @@
 DIR=$(dirname $0)
 
 tests=( $DIR/test_kernel_data_trace $DIR/test_sessions $DIR/test_ust_data_trace \
-		$DIR/streaming/runall $DIR/health/runall )
+		$DIR/streaming/runall $DIR/health/runall $DIR/filtering/runall)
 
 exit_code=0
 
-- 
1.7.12.2
