From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH babeltrace 4/5] Tests: Add trace reading test
	with babeltrace bin
Date: Tue, 20 Aug 2013 17:38:20 -0400
Message-ID: <1377034701-5142-4-git-send-email-christian.babeux__48549.2888176397$1377035277$gmane$org@efficios.com>
References: <1377034701-5142-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VBtdV-0005QC-Sy
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 17:38:52 -0400
Received: by mail-qc0-f180.google.com with SMTP id j10so537761qcx.25
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 14:38:40 -0700 (PDT)
In-Reply-To: <1377034701-5142-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This test uses the sample traces found in tests/ctf-traces and the babeltrace
cli tool to parse them. The traces found in ctf-traces/succeed should return
a successful exit code and those in ctf-traces/fail should return a failure
exit code.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 configure.ac              |  1 +
 tests/Makefile.am         |  9 ++----
 tests/bin/Makefile.am     |  1 +
 tests/bin/test_trace_read | 48 ++++++++++++++++++++++++++++++
 tests/runall.sh           | 76 -----------------------------------------------
 5 files changed, 52 insertions(+), 83 deletions(-)
 create mode 100644 tests/bin/Makefile.am
 create mode 100755 tests/bin/test_trace_read
 delete mode 100755 tests/runall.sh

diff --git a/configure.ac b/configure.ac
index f38bfb7..58a472d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -133,6 +133,7 @@ AC_CONFIG_FILES([
 	lib/prio_heap/Makefile
 	include/Makefile
 	tests/Makefile
+	tests/bin/Makefile
 	tests/lib/Makefile
 	tests/utils/Makefile
 	tests/utils/tap/Makefile
diff --git a/tests/Makefile.am b/tests/Makefile.am
index cf68aac..b03b7e0 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -1,8 +1,3 @@
-AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include
+SUBDIRS = utils bin lib
 
-SUBDIRS = utils lib
-
-EXTRA_DIST = runall.sh ctf-traces/**
-
-check-am:
-	./runall.sh
+EXTRA_DIST = ctf-traces/**
diff --git a/tests/bin/Makefile.am b/tests/bin/Makefile.am
new file mode 100644
index 0000000..1243823
--- /dev/null
+++ b/tests/bin/Makefile.am
@@ -0,0 +1 @@
+EXTRA_DIST = test_trace_read
diff --git a/tests/bin/test_trace_read b/tests/bin/test_trace_read
new file mode 100755
index 0000000..b80ca95
--- /dev/null
+++ b/tests/bin/test_trace_read
@@ -0,0 +1,48 @@
+#!/bin/bash
+#
+# Copyright (C) - 2013 Christian Babeux <christian.babeux@efficios.com>
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License, version 2 only, as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program; if not, write to the Free Software Foundation, Inc., 51
+# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+CURDIR=$(dirname $0)
+TESTDIR=$CURDIR/..
+
+BABELTRACE_BIN=$CURDIR/../../converter/babeltrace
+
+CTF_TRACES=$TESTDIR/ctf-traces
+
+source $TESTDIR/utils/tap/tap.sh
+
+SUCCESS_TRACES=(${CTF_TRACES}/succeed/*)
+FAIL_TRACES=(${CTF_TRACES}/fail/*)
+
+NUM_TESTS=$((${#SUCCESS_TRACES[@]} + ${#FAIL_TRACES[@]}))
+
+plan_tests $NUM_TESTS
+
+for path in ${SUCCESS_TRACES[@]}; do
+	trace=$(basename ${path})
+	$BABELTRACE_BIN ${path} > /dev/null 2>&1
+	ok $? "Run babeltrace with trace ${trace}"
+done
+
+for path in ${FAIL_TRACES[@]}; do
+	trace=$(basename ${path})
+	$BABELTRACE_BIN ${path} > /dev/null 2>&1
+	if [ $? -eq 0 ]; then
+		fail "Run babeltrace with invalid trace ${trace}"
+	else
+		pass "Run babeltrace with invalid trace ${trace}"
+	fi
+done
diff --git a/tests/runall.sh b/tests/runall.sh
deleted file mode 100755
index c10e88a..0000000
--- a/tests/runall.sh
+++ /dev/null
@@ -1,76 +0,0 @@
-#!/bin/bash
-
-TESTDIR=$(dirname $0)
-DIR=$(readlink -f ${TESTDIR})
-BABELTRACE_BIN=${DIR}/../converter/babeltrace
-CTF_TRACES=${DIR}/ctf-traces
-
-function test_check_success ()
-{
-	if [ $? -ne 0 ] ; then
-		return 1
-	else
-		return 0
-	fi
-}
-
-function test_check_fail ()
-{
-	if [ $? -eq 0 ] ; then
-		return 1
-	else
-		return 0
-	fi
-}
-
-function run_babeltrace ()
-{
-	${BABELTRACE_BIN} $* > /dev/null 2>&1
-	return $?
-}
-
-function print_test_result ()
-{
-	if [ $# -ne 3 ] ; then
-		echo "Invalid arguments provided"
-		exit 1
-	fi
-
-	if [ ${2} -eq 0 ] ; then
-		echo -n "ok"
-	else
-		echo -n "not ok"
-	fi
-	echo -e " "${1}" - "${3}
-}
-
-successTraces=(${CTF_TRACES}/succeed/*)
-failTraces=(${CTF_TRACES}/fail/*)
-testCount=$((2 + ${#successTraces[@]} + ${#failTraces[@]}))
-
-currentTestIndex=1
-echo -e 1..${testCount}
-
-#run babeltrace, expects success
-run_babeltrace
-test_check_success
-print_test_result $((currentTestIndex++)) $? "Running babeltrace without arguments"
-
-#run babeltrace with a bogus argument, expects failure
-run_babeltrace --bogusarg
-test_check_fail
-print_test_result $((currentTestIndex++)) $? "Running babeltrace with a bogus argument"
-
-for tracePath in ${successTraces[@]}; do
-	run_babeltrace ${tracePath}
-	test_check_success
-	print_test_result $((currentTestIndex++)) $? "Running babeltrace with trace ${tracePath}"
-done
-
-for tracePath in ${failTraces[@]}; do
-	run_babeltrace ${tracePath}
-	test_check_fail
-	print_test_result $((currentTestIndex++)) $? "Running babeltrace with trace ${tracePath}"
-done
-
-exit 0
-- 
1.8.3.4
