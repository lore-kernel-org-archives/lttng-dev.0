From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2] Tests: expand UST wildcard
	tests, move to regression/tools
Date: Fri,  4 Sep 2015 19:53:18 -0400
Message-ID: <1441410799-10991-1-git-send-email-mathieu.desnoyers__47723.101944621$1441410907$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZY0nX-00068J-AS
 for lttng-dev@lists.lttng.org; Fri, 04 Sep 2015 19:53:47 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 configure.ac                                       |  1 +
 tests/fast_regression                              |  2 +-
 tests/long_regression                              |  2 +-
 tests/regression/tools/Makefile.am                 |  3 +-
 tests/regression/tools/wildcard/Makefile.am        | 26 ++++++++++
 .../{ust => tools/wildcard}/test_event_wildcard    | 59 ++++++++++++++++------
 tests/regression/ust/Makefile.am                   |  2 +-
 7 files changed, 75 insertions(+), 20 deletions(-)
 create mode 100644 tests/regression/tools/wildcard/Makefile.am
 rename tests/regression/{ust => tools/wildcard}/test_event_wildcard (53%)

diff --git a/configure.ac b/configure.ac
index 55977bc..1266431 100644
--- a/configure.ac
+++ b/configure.ac
@@ -518,6 +518,7 @@ AC_CONFIG_FILES([
 	tests/regression/tools/exclusion/Makefile
 	tests/regression/tools/save-load/Makefile
 	tests/regression/tools/mi/Makefile
+	tests/regression/tools/wildcard/Makefile
 	tests/regression/ust/Makefile
 	tests/regression/ust/nprocesses/Makefile
 	tests/regression/ust/high-throughput/Makefile
diff --git a/tests/fast_regression b/tests/fast_regression
index fa88621..420fffb 100644
--- a/tests/fast_regression
+++ b/tests/fast_regression
@@ -14,6 +14,7 @@ regression/tools/snapshots/test_ust_streaming
 regression/tools/save-load/test_save
 regression/tools/save-load/test_load
 regression/tools/mi/test_mi
+regression/tools/wildcard/test_event_wildcard
 regression/ust/before-after/test_before_after
 regression/ust/buffers-pid/test_buffers_pid
 regression/ust/multi-session/test_multi_session
@@ -26,5 +27,4 @@ regression/ust/getcpu-override/test_getcpu_override
 regression/ust/clock-override/test_clock_override
 regression/ust/test_event_basic
 regression/ust/test_event_tracef
-regression/ust/test_event_wildcard
 regression/ust/test_event_perf
diff --git a/tests/long_regression b/tests/long_regression
index 1fa8514..105dc51 100644
--- a/tests/long_regression
+++ b/tests/long_regression
@@ -8,6 +8,7 @@ regression/tools/streaming/test_ust
 regression/tools/snapshots/test_ust_long
 regression/tools/tracefile-limits/test_tracefile_count
 regression/tools/tracefile-limits/test_tracefile_size
+regression/tools/wildcard/test_event_wildcard
 regression/ust/before-after/test_before_after
 regression/ust/buffers-pid/test_buffers_pid
 regression/ust/high-throughput/test_high_throughput
@@ -17,4 +18,3 @@ regression/ust/nprocesses/test_nprocesses
 regression/ust/overlap/test_overlap
 regression/ust/test_event_basic
 regression/ust/test_event_tracef
-regression/ust/test_event_wildcard
diff --git a/tests/regression/tools/Makefile.am b/tests/regression/tools/Makefile.am
index 09f55b3..a798de3 100644
--- a/tests/regression/tools/Makefile.am
+++ b/tests/regression/tools/Makefile.am
@@ -1 +1,2 @@
-SUBDIRS = streaming filtering health tracefile-limits snapshots live exclusion save-load mi
+SUBDIRS = streaming filtering health tracefile-limits snapshots live exclusion save-load mi \
+		wildcard
diff --git a/tests/regression/tools/wildcard/Makefile.am b/tests/regression/tools/wildcard/Makefile.am
new file mode 100644
index 0000000..b95b495
--- /dev/null
+++ b/tests/regression/tools/wildcard/Makefile.am
@@ -0,0 +1,26 @@
+AM_CFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src -I$(top_srcdir)/tests -I$(srcdir) -O2 -g
+AM_LDFLAGS =
+
+if LTTNG_TOOLS_BUILD_WITH_LIBDL
+LIBS += -ldl
+endif
+if LTTNG_TOOLS_BUILD_WITH_LIBC_DL
+LIBS += -lc
+endif
+
+noinst_SCRIPTS = test_event_wildcard
+EXTRA_DIST = test_event_wildcard
+
+all-local:
+	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
+		for script in $(EXTRA_DIST); do \
+			cp -f $(srcdir)/$$script $(builddir); \
+		done; \
+	fi
+
+clean-local:
+	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
+		for script in $(EXTRA_DIST); do \
+			rm -f $(builddir)/$$script; \
+		done; \
+	fi
diff --git a/tests/regression/ust/test_event_wildcard b/tests/regression/tools/wildcard/test_event_wildcard
similarity index 53%
rename from tests/regression/ust/test_event_wildcard
rename to tests/regression/tools/wildcard/test_event_wildcard
index 1c0b27a..7fbfc18 100755
--- a/tests/regression/ust/test_event_wildcard
+++ b/tests/regression/tools/wildcard/test_event_wildcard
@@ -1,6 +1,7 @@
 #!/bin/bash
 #
 # Copyright (C) - 2013 Christian Babeux <christian.babeux@efficios.com>
+# Copyright (C) - 2015 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 #
 # This program is free software; you can redistribute it and/or modify it
 # under the terms of the GNU General Public License, version 2 only, as
@@ -20,40 +21,59 @@ TEST_DESC="UST tracer - Event wildcard"
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../..
 LTTNG_BIN="lttng"
-BIN_NAME="gen-ust-events"
-SESSION_NAME="valid_filter"
+TESTAPP_PATH="$TESTDIR/utils/testapp"
+TESTAPP_NAME="gen-ust-events"
+TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
+SESSION_NAME="wildcard"
 EVENT_NAME="tp:tptest"
-NUM_TESTS=9
+NUM_TESTS=39
+NR_ITER=100
 
 source $TESTDIR/utils/utils.sh
 
+if [ ! -x "$TESTAPP_BIN" ]; then
+	BAIL_OUT "No UST nevents binary detected."
+fi
+
 function test_event_wildcard()
 {
 	TRACE_PATH=$(mktemp -d)
-	SESSION_NAME="ust_event_basic"
-	SESSION_NAME2="ust_event_basic2"
-	CHAN_NAME="mychan"
-	CHAN_NAME2="mychan2"
-	EVENT_NAME="*"
-	EVENT_NAME2="abc*"
+	FIND="${1}"
+	WILDCARD="${2}"
 
 	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
-
-	enable_ust_lttng_event_ok $SESSION_NAME "$EVENT_NAME"
-	enable_ust_lttng_event_ok $SESSION_NAME "$EVENT_NAME2"
+	enable_ust_lttng_event_ok $SESSION_NAME "$WILDCARD"
 
 	start_lttng_tracing_ok
+
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT
+	ok $? "Traced application stopped."
+
 	stop_lttng_tracing_ok
+	destroy_lttng_session_ok $SESSION_NAME
+
+	if [ ${FIND} -eq 1 ]; then
+		trace_matches $EVENT_NAME $NR_ITER $TRACE_PATH
+	else
+		validate_trace_empty $TRACE_PATH
+	fi
+
+	rm -rf $TRACE_PATH
+}
 
-	TODO="Validate trace output is coherent"
-	ok 0 "Validate trace"
-	unset TODO
+function test_event_wildcard_fail()
+{
+	TRACE_PATH=$(mktemp -d)
+	WILDCARD="${1}"
 
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
+	enable_ust_lttng_event_fail $SESSION_NAME "$WILDCARD"
 	destroy_lttng_session_ok $SESSION_NAME
 
 	rm -rf $TRACE_PATH
 }
 
+
 # MUST set TESTDIR before calling those functions
 plan_tests $NUM_TESTS
 
@@ -61,6 +81,13 @@ print_test_banner "$TEST_DESC"
 
 start_lttng_sessiond
 
-test_event_wildcard
+test_event_wildcard 1 'tp:tp*'
+test_event_wildcard 1 '*'
+test_event_wildcard 1 'tp:tptest*'
+test_event_wildcard 0 'tp:abc*'
+
+test_event_wildcard_fail 'tp:*tp'
+test_event_wildcard_fail 'tp:tp**'
+test_event_wildcard_fail '*tp:tp*'
 
 stop_lttng_sessiond
diff --git a/tests/regression/ust/Makefile.am b/tests/regression/ust/Makefile.am
index 2616dc7..f2afad5 100644
--- a/tests/regression/ust/Makefile.am
+++ b/tests/regression/ust/Makefile.am
@@ -4,7 +4,7 @@ SUBDIRS = nprocesses high-throughput low-throughput before-after multi-session \
 		periodical-metadata-flush java-jul java-log4j python-logging \
 		getcpu-override clock-override
 
-EXTRA_DIST = test_event_basic test_event_wildcard test_event_tracef test_event_perf
+EXTRA_DIST = test_event_basic test_event_tracef test_event_perf
 
 all-local:
 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
-- 
2.1.4
