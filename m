From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 2/5] Tests: Add a test for invalid
	filters
Date: Tue, 16 Oct 2012 14:33:20 -0400
Message-ID: <1350412403-9974-2-git-send-email-christian.babeux__37162.1756734841$1350412456$gmane$org@efficios.com>
References: <1350412403-9974-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TOBxX-0006dS-My
	for lttng-dev@lists.lttng.org; Tue, 16 Oct 2012 14:33:44 -0400
Received: by mail-qc0-f176.google.com with SMTP id n41so6175539qco.35
	for <lttng-dev@lists.lttng.org>; Tue, 16 Oct 2012 11:33:38 -0700 (PDT)
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

This test validate that an invalid filter (unmatched parenthesis,
field dereferences, unsupported ops, etc.) are correctly flagged
as such.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/tools/filtering/Makefile.am     |   4 +-
 tests/tools/filtering/invalid-filters | 135 ++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 2 deletions(-)
 create mode 100755 tests/tools/filtering/invalid-filters

diff --git a/tests/tools/filtering/Makefile.am b/tests/tools/filtering/Makefile.am
index 62f7099..5f3423a 100644
--- a/tests/tools/filtering/Makefile.am
+++ b/tests/tools/filtering/Makefile.am
@@ -1,2 +1,2 @@
-noinst_SCRIPTS = unsupported-ops
-EXTRA_DIST = unsupported-ops
+noinst_SCRIPTS = unsupported-ops invalid-filters
+EXTRA_DIST = unsupported-ops invalid-filters
diff --git a/tests/tools/filtering/invalid-filters b/tests/tools/filtering/invalid-filters
new file mode 100755
index 0000000..d0777e5
--- /dev/null
+++ b/tests/tools/filtering/invalid-filters
@@ -0,0 +1,135 @@
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
+TEST_DESC="Filtering - Invalid filters"
+
+CURDIR=$(dirname $0)/
+TESTDIR=$CURDIR/../..
+LTTNG_BIN="lttng"
+SESSION_NAME="filter-invalid"
+EVENT_NAME="bogus"
+ENABLE_EVENT_STDERR="/tmp/invalid-filters-stderr"
+TRACE_PATH=$(mktemp -d)
+
+source $TESTDIR/utils.sh
+
+print_test_banner "$TEST_DESC"
+
+function enable_ust_lttng_event_filter
+{
+	sess_name="$1"
+	event_name="$2"
+	filter="$3"
+	echo -n "Enabling lttng event with filtering and invalid filter "
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $event_name -s $sess_name -u --filter "$filter" 2> $ENABLE_EVENT_STDERR 1> /dev/null
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
+function test_invalid_filter
+{
+	test_invalid_filter="$1"
+
+	echo ""
+	echo -e "=== Testing filter expression with invalid filter"
+	echo -e "Filter: $test_invalid_filter"
+
+	# Create session
+	create_lttng_session $SESSION_NAME $TRACE_PATH
+
+	# Apply filter
+	enable_ust_lttng_event_filter $SESSION_NAME $EVENT_NAME "$test_invalid_filter"
+
+	# Destroy session
+	destroy_lttng_session $SESSION_NAME
+}
+
+function test_bytecode_limit
+{
+	# Current bytecode limitation is 65536 bytes long.
+	# Generate a huge bytecode with some perl-fu
+	BYTECODE_LIMIT=`perl -e 'print "intfield" . " && 1" x5460'`
+
+	echo ""
+	echo -e "=== Testing filter bytecode limits (64KiB)"
+
+	# Create session
+	create_lttng_session $SESSION_NAME $TRACE_PATH
+
+	# Apply filter
+	enable_ust_lttng_event_filter $SESSION_NAME $EVENT_NAME "$BYTECODE_LIMIT"
+
+	# Destroy session
+	destroy_lttng_session $SESSION_NAME
+}
+
+IFS=$'\n'
+INVALID_FILTERS=(
+		# Unsupported ops
+		"intfield*1"
+		"intfield/1"
+		"intfield+1"
+		"intfield-1"
+		"intfield>>1"
+		"intfield<<1"
+		"intfield&1"
+		"intfield|1"
+		"intfield^1"
+		"~intfield"
+		"1+11111-3333+1"
+		"(1+2)*(55*666)"
+		"1+2*55*666"
+		"asdf + 1 > 1"
+		"asdfas < 2332 || asdf + 1 > 1"
+		"!+-+++-------+++++++++++-----!!--!44+1"
+		"aaa||(gg)+(333----1)"
+		"1+1"
+		# Unmatched parenthesis
+		"((((((((((((((intfield)))))))))))))"
+		'0 || ("abc" != "def")) && (3 < 4)'
+		# Field dereference
+		"a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a"
+		"a->"
+		"a-->a"
+		"a->a"
+		"a.b.c->d.e.f+1"
+		"!a.f.d"
+		"asdf.asdfsd.sadf < 4"
+		"asdfasdf->asdfasdf < 2"
+		)
+
+start_lttng_sessiond
+for FILTER in ${INVALID_FILTERS[@]};
+do
+	test_invalid_filter "$FILTER"
+done
+
+test_bytecode_limit
+
+unset IFS
+stop_lttng_sessiond
+
+rm -f $ENABLE_EVENT_STDERR
+rm -rf $TRACE_PATH
-- 
1.7.12.2
