From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: make check in out of tree build
Date: Thu,  3 Sep 2015 14:13:21 -0400
Message-ID: <1441304001-12087-1-git-send-email-mjeanson__22362.0930024937$1441304106$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZXZ14-00052A-Hq
 for lttng-dev@lists.lttng.org; Thu, 03 Sep 2015 14:13:52 -0400
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

Use the tracefiles from the source dir when running make check in an out
of tree builddir.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 .gitignore                   |  2 ++
 tests/bin/Makefile.am        | 22 ++++++--------------
 tests/bin/test_trace_read    | 48 --------------------------------------------
 tests/bin/test_trace_read.in | 48 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 64 deletions(-)
 delete mode 100755 tests/bin/test_trace_read
 create mode 100755 tests/bin/test_trace_read.in

diff --git a/.gitignore b/.gitignore
index 30eadde..bf869af 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,8 +1,10 @@
 *~
+/tests/bin/test_trace_read
 /tests/lib/test_bitfield
 /tests/lib/test_seek
 /tests/lib/test_ctf_writer
 /tests/lib/test_bt_objects
+/tests/lib/test_bt_values
 *.o
 *.a
 *.la
diff --git a/tests/bin/Makefile.am b/tests/bin/Makefile.am
index e46285f..0245238 100644
--- a/tests/bin/Makefile.am
+++ b/tests/bin/Makefile.am
@@ -1,17 +1,7 @@
-SCRIPT_LIST = test_trace_read
+noinst_SCRIPTS = test_trace_read
+CLEANFILES = $(noinst_SCRIPTS)
+EXTRA_DIST = test_trace_read.in
 
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
diff --git a/tests/bin/test_trace_read b/tests/bin/test_trace_read
deleted file mode 100755
index b80ca95..0000000
--- a/tests/bin/test_trace_read
+++ /dev/null
@@ -1,48 +0,0 @@
-#!/bin/bash
-#
-# Copyright (C) - 2013 Christian Babeux <christian.babeux@efficios.com>
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of the GNU General Public License, version 2 only, as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-# more details.
-#
-# You should have received a copy of the GNU General Public License along with
-# this program; if not, write to the Free Software Foundation, Inc., 51
-# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-CURDIR=$(dirname $0)
-TESTDIR=$CURDIR/..
-
-BABELTRACE_BIN=$CURDIR/../../converter/babeltrace
-
-CTF_TRACES=$TESTDIR/ctf-traces
-
-source $TESTDIR/utils/tap/tap.sh
-
-SUCCESS_TRACES=(${CTF_TRACES}/succeed/*)
-FAIL_TRACES=(${CTF_TRACES}/fail/*)
-
-NUM_TESTS=$((${#SUCCESS_TRACES[@]} + ${#FAIL_TRACES[@]}))
-
-plan_tests $NUM_TESTS
-
-for path in ${SUCCESS_TRACES[@]}; do
-	trace=$(basename ${path})
-	$BABELTRACE_BIN ${path} > /dev/null 2>&1
-	ok $? "Run babeltrace with trace ${trace}"
-done
-
-for path in ${FAIL_TRACES[@]}; do
-	trace=$(basename ${path})
-	$BABELTRACE_BIN ${path} > /dev/null 2>&1
-	if [ $? -eq 0 ]; then
-		fail "Run babeltrace with invalid trace ${trace}"
-	else
-		pass "Run babeltrace with invalid trace ${trace}"
-	fi
-done
diff --git a/tests/bin/test_trace_read.in b/tests/bin/test_trace_read.in
new file mode 100755
index 0000000..f9410e5
--- /dev/null
+++ b/tests/bin/test_trace_read.in
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
+CTF_TRACES=$CURDIR/@TOPSRCDIR@/tests/ctf-traces
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
-- 
1.9.1
