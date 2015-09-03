From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust v2] Fix: make check in out of tree
	build
Date: Thu,  3 Sep 2015 15:43:20 -0400
Message-ID: <1441309400-4140-1-git-send-email-mjeanson__42987.8063769594$1441309502$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZXaQC-0005Xg-Bv
 for lttng-dev@lists.lttng.org; Thu, 03 Sep 2015 15:43:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C4135340469
 for <lttng-dev@lists.lttng.org>; Thu,  3 Sep 2015 19:43:39 +0000 (UTC)
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

Use the elf data files from the source dir when running make check in an
out of tree builddir.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 .gitignore                    |  1 +
 tests/ust-elf/Makefile.am     | 22 ++++++----------------
 tests/ust-elf/test_ust_elf    |  4 ----
 tests/ust-elf/test_ust_elf.in |  4 ++++
 4 files changed, 11 insertions(+), 20 deletions(-)
 delete mode 100755 tests/ust-elf/test_ust_elf
 create mode 100755 tests/ust-elf/test_ust_elf.in

diff --git a/.gitignore b/.gitignore
index b1f985b..41966c5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -50,6 +50,7 @@ tests/tracepoint/benchmark/tracepoint_benchmark
 tests/tracepoint/tracepoint_test
 tests/snprintf/prog
 tests/ust-elf/prog
+tests/ust-elf/test_ust_elf
 tests/benchmark/bench1
 tests/benchmark/bench2
 
diff --git a/tests/ust-elf/Makefile.am b/tests/ust-elf/Makefile.am
index 3cb5442..6fe5571 100644
--- a/tests/ust-elf/Makefile.am
+++ b/tests/ust-elf/Makefile.am
@@ -5,20 +5,10 @@ prog_SOURCES = prog.c
 prog_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la \
 	$(top_builddir)/tests/utils/libtap.a
 
-SCRIPT_LIST = test_ust_elf
+noinst_SCRIPTS = test_ust_elf
+CLEANFILES = $(noinst_SCRIPTS)
+EXTRA_DIST = test_ust_elf.in
 
-dist_noinst_SCRIPTS = $(SCRIPT_LIST)
-
-all-local:
-	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
-		for script in $(SCRIPT_LIST); do \
-			cp -f $(srcdir)/$$script $(builddir); \
-		done; \
-	fi
-
-clean-local:
-	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
-		for script in $(SCRIPT_LIST); do \
-			rm -f $(builddir)/$$script; \
-		done; \
-	fi
+$(noinst_SCRIPTS): %: %.in
+	sed "s#@TOPSRCDIR@#$(top_srcdir)#g" < $< > $@
+	chmod +x $@
diff --git a/tests/ust-elf/test_ust_elf b/tests/ust-elf/test_ust_elf
deleted file mode 100755
index cb7c7a9..0000000
--- a/tests/ust-elf/test_ust_elf
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-
-TEST_DIR=$(dirname $0)
-./${TEST_DIR}/prog $TEST_DIR
diff --git a/tests/ust-elf/test_ust_elf.in b/tests/ust-elf/test_ust_elf.in
new file mode 100755
index 0000000..5cfbff6
--- /dev/null
+++ b/tests/ust-elf/test_ust_elf.in
@@ -0,0 +1,4 @@
+#!/bin/bash
+
+TEST_DIR=$(dirname $0)
+./${TEST_DIR}/prog $TEST_DIR/@TOPSRCDIR@/tests/ust-elf
-- 
1.9.1
