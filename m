From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 2/2] Implement test_event_tracef
Date: Tue, 27 May 2014 16:25:26 -0400
Message-ID: <1401222326-29474-2-git-send-email-mathieu.desnoyers__8049.63079649514$1401222665$gmane$org@efficios.com>
References: <1401222326-29474-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1WpO0W-0003dI-E7
 for lttng-dev@lists.lttng.org; Tue, 27 May 2014 16:30:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 599A034023C
 for <lttng-dev@lists.lttng.org>; Tue, 27 May 2014 20:30:00 +0000 (UTC)
In-Reply-To: <1401222326-29474-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tests/fast_regression                  |    1 +
 tests/long_regression                  |    1 +
 tests/regression/ust/Makefile.am       |    2 +-
 tests/regression/ust/test_event_tracef |   72 ++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100755 tests/regression/ust/test_event_tracef

diff --git a/tests/fast_regression b/tests/fast_regression
index 6ab2607..a3c2fe9 100644
--- a/tests/fast_regression
+++ b/tests/fast_regression
@@ -20,5 +20,6 @@ regression/ust/nprocesses/test_nprocesses
 regression/ust/overlap/test_overlap
 regression/ust/java-jul/test_java_jul
 regression/ust/test_event_basic
+regression/ust/test_event_tracef
 regression/ust/test_event_wildcard
 regression/ust/test_event_perf
diff --git a/tests/long_regression b/tests/long_regression
index ab4339d..1fa8514 100644
--- a/tests/long_regression
+++ b/tests/long_regression
@@ -16,4 +16,5 @@ regression/ust/multi-session/test_multi_session
 regression/ust/nprocesses/test_nprocesses
 regression/ust/overlap/test_overlap
 regression/ust/test_event_basic
+regression/ust/test_event_tracef
 regression/ust/test_event_wildcard
diff --git a/tests/regression/ust/Makefile.am b/tests/regression/ust/Makefile.am
index a4e3455..a95a605 100644
--- a/tests/regression/ust/Makefile.am
+++ b/tests/regression/ust/Makefile.am
@@ -3,7 +3,7 @@ SUBDIRS = nprocesses high-throughput low-throughput before-after multi-session \
 		overlap buffers-pid linking daemon exit-fast fork libc-wrapper \
 		periodical-metadata-flush java-jul
 
-EXTRA_DIST = test_event_basic test_event_wildcard
+EXTRA_DIST = test_event_basic test_event_wildcard test_event_tracef
 
 all-local:
 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
diff --git a/tests/regression/ust/test_event_tracef b/tests/regression/ust/test_event_tracef
new file mode 100755
index 0000000..66528d1
--- /dev/null
+++ b/tests/regression/ust/test_event_tracef
@@ -0,0 +1,72 @@
+#!/bin/bash
+#
+# Copyright (C) - 2013 Christian Babeux <christian.babeux@efficios.com>
+# Copyright (C) - 2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
+TEST_DESC="UST tracer - tracef events"
+
+CURDIR=$(dirname $0)/
+TESTDIR=$CURDIR/../..
+LTTNG_BIN="lttng"
+TESTAPP_PATH="$TESTDIR/utils/testapp"
+TESTAPP_NAME="gen-ust-tracef"
+TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
+SESSION_NAME="tracef"
+EVENT_NAME="lttng_ust_tracef:event"
+NUM_TESTS=9
+NR_ITER=100
+
+source $TESTDIR/utils/utils.sh
+
+if [ ! -x "$TESTAPP_BIN" ]; then
+	BAIL_OUT "No UST nevents binary detected."
+fi
+
+function test_event_tracef()
+{
+	create_lttng_session $SESSION_NAME $TRACE_PATH
+	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
+	start_lttng_tracing $SESSION_NAME
+
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT
+	ok $? "Traced application stopped."
+
+	stop_lttng_tracing $SESSION_NAME
+	destroy_lttng_session $SESSION_NAME
+
+	trace_matches $EVENT_NAME $NR_ITER $TRACE_PATH
+
+	return $?
+}
+
+# MUST set TESTDIR before calling those functions
+plan_tests $NUM_TESTS
+
+print_test_banner "$TEST_DESC"
+
+start_lttng_sessiond
+
+TRACE_PATH=$(mktemp -d)
+test_event_tracef
+out=$?
+if [ $out -ne 0 ]; then
+	stop_lttng_sessiond
+	exit $out
+fi
+
+stop_lttng_sessiond
+
+rm -rf $TRACE_PATH
-- 
1.7.10.4
