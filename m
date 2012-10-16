From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 1/5] Tests: Add an unsupported
	operators filtering test
Date: Tue, 16 Oct 2012 14:33:19 -0400
Message-ID: <1350412403-9974-1-git-send-email-christian.babeux__38085.5711563074$1350412454$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TOBxP-0006dB-Mc
	for lttng-dev@lists.lttng.org; Tue, 16 Oct 2012 14:33:36 -0400
Received: by mail-qa0-f41.google.com with SMTP id c4so212075qae.14
	for <lttng-dev@lists.lttng.org>; Tue, 16 Oct 2012 11:33:30 -0700 (PDT)
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

This test validate that filters with unsupported operators are
correctly flagged and that an enable event with these filters
properly fails.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/tools/filtering/Makefile.am     |   2 +
 tests/tools/filtering/unsupported-ops | 114 ++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 tests/tools/filtering/Makefile.am
 create mode 100755 tests/tools/filtering/unsupported-ops

diff --git a/tests/tools/filtering/Makefile.am b/tests/tools/filtering/Makefile.am
new file mode 100644
index 0000000..62f7099
--- /dev/null
+++ b/tests/tools/filtering/Makefile.am
@@ -0,0 +1,2 @@
+noinst_SCRIPTS = unsupported-ops
+EXTRA_DIST = unsupported-ops
diff --git a/tests/tools/filtering/unsupported-ops b/tests/tools/filtering/unsupported-ops
new file mode 100755
index 0000000..8b743f4
--- /dev/null
+++ b/tests/tools/filtering/unsupported-ops
@@ -0,0 +1,114 @@
+#!/bin/bash
+#
+# Copyright (C) - 2012 Christian Babeux <christian.babeux@efficios.com>
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
+TEST_DESC="Filtering - Unsupported operators"
+
+CURDIR=$(dirname $0)/
+TESTDIR=$CURDIR/../..
+LTTNG_BIN="lttng"
+SESSION_NAME="filter-unsupported-ops"
+EVENT_NAME="bogus"
+ENABLE_EVENT_STDERR="/tmp/unsupported-ops-enable"
+TRACE_PATH=$(mktemp -d)
+
+source $TESTDIR/utils.sh
+
+print_test_banner "$TEST_DESC"
+
+function enable_ust_lttng_event_filter_unsupported
+{
+	sess_name=$1
+	event_name=$2
+	filter=$3
+
+	echo -n "Enabling lttng event with filtering and unsupported operator "
+	enable_cmd="$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event"
+	$enable_cmd $event_name -s $sess_name -u --filter "$filter" 2> $ENABLE_EVENT_STDERR 1> /dev/null
+
+	# Enable must fail
+	if [ $? -eq 0 ]; then
+		print_fail
+		return 1
+	else
+		print_ok
+		return 0
+	fi
+}
+
+function test_unsupported_op
+{
+	test_op_str=$1
+	test_op_tkn=$2
+
+	echo ""
+	echo -e "=== Testing filter expression with unsupported operator $test_op_str ($test_op_tkn)"
+
+	# Create session
+	create_lttng_session $SESSION_NAME $TRACE_PATH
+
+	# Create filter
+	if [ "$test_op_str" == "UNARY_BIN_NOT" ]; then
+		TEST_FILTER="${test_op_tkn}1"
+	else
+		TEST_FILTER="intfield $test_op_tkn 1"
+	fi
+
+	# Apply filter
+	enable_ust_lttng_event_filter_unsupported $SESSION_NAME $EVENT_NAME "$TEST_FILTER"
+
+	# Test stderr for unsupported operator
+	echo -n "Unsupported operator test $test_op_str ($test_op_tkn) "
+	grep -i -q "not[[:space:]]\+supported" $ENABLE_EVENT_STDERR
+
+	if [ $? -eq 1 ]; then
+		print_fail
+		return 1
+	else
+		print_ok
+	fi
+
+	# Destroy session
+	destroy_lttng_session $SESSION_NAME
+	return 0
+}
+
+# Unsupported operators
+OP_STR=("MUL" "DIV" "MOD" "PLUS" "MINUS" "LSHIFT" "RSHIFT"
+	"BIN_AND" "BIN_OR" "BIN_XOR" "UNARY_BIN_NOT")
+
+OP_TKN=("*" "/" "%" "+" "-" "<<" ">>" "&" "|" "^" "~")
+
+OP_COUNT=${#OP_STR[@]}
+i=0
+
+start_lttng_sessiond
+
+while [ "$i" -lt "$OP_COUNT" ]; do
+	test_unsupported_op "${OP_STR[$i]}" "${OP_TKN[$i]}"
+
+	if [ $? -eq 1 ]; then
+		exit 1
+	fi
+
+	let "i++"
+done
+
+stop_lttng_sessiond
+
+# Cleanup
+rm -f $ENABLE_EVENT_STDERR
+rm -rf $TRACE_PATH
-- 
1.7.12.2
