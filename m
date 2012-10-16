From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 4/5] Tests: Add a test for valid
	filters
Date: Tue, 16 Oct 2012 14:33:22 -0400
Message-ID: <1350412403-9974-4-git-send-email-christian.babeux__1358.53236211023$1350412478$gmane$org@efficios.com>
References: <1350412403-9974-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TOBxg-0006dB-0p
	for lttng-dev@lists.lttng.org; Tue, 16 Oct 2012 14:33:52 -0400
Received: by mail-qa0-f41.google.com with SMTP id c4so212075qae.14
	for <lttng-dev@lists.lttng.org>; Tue, 16 Oct 2012 11:33:52 -0700 (PDT)
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

This test validate that for a given filter the expected
trace output is conform to the expected filter behavior.

This test rely on the babelstats utility. With the help
of this script, we can verify that the expected minimum
and maximum values on fields of interest are within the
expected ranges.

For example, given 100 iterations on a tracepoint with the
field 'intfield', with values starting from 0 and incrementing
on each iteration, and the filter expression 'intfield < 4',
we would expect that the min-max range lie within [0,3].

Thus, if the babelstat computed range does not match the
expected range, this could potentially indicate failure in
the filtering mechanism.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/tools/filtering/Makefile.am      |  20 +-
 tests/tools/filtering/gen-ust-events.c |  59 +++++
 tests/tools/filtering/tp.c             |  15 ++
 tests/tools/filtering/tp.h             |  57 +++++
 tests/tools/filtering/valid-filters    | 411 +++++++++++++++++++++++++++++++++
 5 files changed, 560 insertions(+), 2 deletions(-)
 create mode 100644 tests/tools/filtering/gen-ust-events.c
 create mode 100644 tests/tools/filtering/tp.c
 create mode 100644 tests/tools/filtering/tp.h
 create mode 100755 tests/tools/filtering/valid-filters

diff --git a/tests/tools/filtering/Makefile.am b/tests/tools/filtering/Makefile.am
index df99e27..a3bf866 100644
--- a/tests/tools/filtering/Makefile.am
+++ b/tests/tools/filtering/Makefile.am
@@ -1,2 +1,18 @@
-noinst_SCRIPTS = unsupported-ops invalid-filters babelstats.pl
-EXTRA_DIST = unsupported-ops invalid-filters babelstats.pl
+AM_CFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src -I$(top_srcdir)/tests -I$(srcdir) -O2 -g
+AM_LDFLAGS =
+
+if LTTNG_TOOLS_BUILD_WITH_LIBDL
+AM_LDFLAGS += -ldl
+endif
+if LTTNG_TOOLS_BUILD_WITH_LIBC_DL
+AM_LDFLAGS += -lc
+endif
+
+if HAVE_LIBLTTNG_UST_CTL
+noinst_PROGRAMS = gen-ust-events
+gen_ust_events_SOURCES = gen-ust-events.c tp.c tp.h
+gen_ust_events_LDADD = -llttng-ust
+endif
+
+noinst_SCRIPTS = unsupported-ops invalid-filters valid-filters babelstats.pl
+EXTRA_DIST = unsupported-ops invalid-filters valid-filters babelstats.pl
diff --git a/tests/tools/filtering/gen-ust-events.c b/tests/tools/filtering/gen-ust-events.c
new file mode 100644
index 0000000..c789c89
--- /dev/null
+++ b/tests/tools/filtering/gen-ust-events.c
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) - 2012 David Goulet <dgoulet@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU Lesser General Public License as published by the
+ * Free Software Foundation; version 2.1 of the License.
+ *
+ * This library is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with this library; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#include <arpa/inet.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define TRACEPOINT_DEFINE
+#include "tp.h"
+
+int main(int argc, char **argv)
+{
+	int i, netint;
+	long values[] = { 1, 2, 3 };
+	char text[10] = "test";
+	char escape[10] = "\\*";
+	double dbl = 2.0;
+	float flt = 2222.0;
+	/* Generate 30 events. */
+	unsigned int nr_iter = 100;
+	useconds_t nr_usec = 0;
+
+	if (argc >= 2) {
+		nr_iter = atoi(argv[1]);
+	}
+
+	if (argc == 3) {
+		/* By default, don't wait unless user specifies. */
+		nr_usec = atoi(argv[2]);
+	}
+
+	for (i = 0; i < nr_iter; i++) {
+		netint = htonl(i);
+		tracepoint(tp, tptest, i, netint, values, text, strlen(text), escape, dbl, flt);
+		usleep(nr_usec);
+	}
+
+	return 0;
+}
diff --git a/tests/tools/filtering/tp.c b/tests/tools/filtering/tp.c
new file mode 100644
index 0000000..a09561d
--- /dev/null
+++ b/tests/tools/filtering/tp.c
@@ -0,0 +1,15 @@
+/*
+ * Copyright (c) - 2012 David Goulet <dgoulet@efficios.com>
+ *
+ * THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED OR
+ * IMPLIED. ANY USE IS AT YOUR OWN RISK.
+ *
+ * Permission is hereby granted to use or copy this program for any purpose,
+ * provided the above notices are retained on all copies.  Permission to modify
+ * the code and to distribute modified code is granted, provided the above
+ * notices are retained, and a notice that the code was modified is included
+ * with the above copyright notice.
+ */
+
+#define TRACEPOINT_CREATE_PROBES
+#include "tp.h"
diff --git a/tests/tools/filtering/tp.h b/tests/tools/filtering/tp.h
new file mode 100644
index 0000000..15f81e5
--- /dev/null
+++ b/tests/tools/filtering/tp.h
@@ -0,0 +1,57 @@
+#undef TRACEPOINT_PROVIDER
+#define TRACEPOINT_PROVIDER tp
+
+#if !defined(_TRACEPOINT_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
+#define _TRACEPOINT_TP_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Copyright (C) 2011  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
+ * OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
+ *
+ * Permission is hereby granted to use or copy this program
+ * for any purpose,  provided the above notices are retained on all copies.
+ * Permission to modify the code and to distribute modified code is granted,
+ * provided the above notices are retained, and a notice that the code was
+ * modified is included with the above copyright notice.
+ */
+
+#include <lttng/tracepoint.h>
+
+TRACEPOINT_EVENT(tp, tptest,
+	TP_ARGS(int, anint, int, netint, long *, values,
+		char *, text, size_t, textlen,
+		char *, etext, double, doublearg, float, floatarg),
+	TP_FIELDS(
+		ctf_integer(int, intfield, anint)
+		ctf_integer_hex(int, intfield2, anint)
+		ctf_integer(long, longfield, anint)
+		ctf_integer_network(int, netintfield, netint)
+		ctf_integer_network_hex(int, netintfieldhex, netint)
+		ctf_array(long, arrfield1, values, 3)
+		ctf_array_text(char, arrfield2, text, 10)
+		ctf_sequence(char, seqfield1, text, size_t, textlen)
+		ctf_sequence_text(char, seqfield2, text, size_t, textlen)
+		ctf_string(stringfield, text)
+		ctf_string(stringfield2, etext)
+		ctf_float(float, floatfield, floatarg)
+		ctf_float(double, doublefield, doublearg)
+	)
+)
+
+#endif /* _TRACEPOINT_TP_H */
+
+#undef TRACEPOINT_INCLUDE_FILE
+#define TRACEPOINT_INCLUDE_FILE ./tp.h
+
+/* This part must be outside ifdef protection */
+#include <lttng/tracepoint-event.h>
+
+#ifdef __cplusplus
+}
+#endif
diff --git a/tests/tools/filtering/valid-filters b/tests/tools/filtering/valid-filters
new file mode 100755
index 0000000..b48b6ed
--- /dev/null
+++ b/tests/tools/filtering/valid-filters
@@ -0,0 +1,411 @@
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
+TEST_DESC="Filtering - Valid filters"
+
+CURDIR=$(dirname $0)/
+TESTDIR=$CURDIR/../..
+LTTNG_BIN="lttng"
+BIN_NAME="gen-ust-events"
+STATS_BIN="babelstats.pl"
+SESSION_NAME="valid_filter"
+EVENT_NAME="tp:tptest"
+NR_ITER=100
+
+source $TESTDIR/utils.sh
+
+print_test_banner "$TEST_DESC"
+
+if [ ! -x "$CURDIR/$BIN_NAME" ]; then
+	echo -e "No UST nevents binary detected. Passing."
+	exit 0
+fi
+
+function enable_ust_lttng_event_filter()
+{
+	sess_name="$1"
+	event_name="$2"
+	filter="$3"
+	echo -n "Enabling lttng event with filtering "
+
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $event_name -s $sess_name -u --filter "$filter" 2>&1 >/dev/null
+
+	if [ $? -eq 0 ]; then
+		print_ok
+		return 0
+	else
+		print_fail
+		return 1
+	fi
+}
+
+function run_apps
+{
+	./$CURDIR/$BIN_NAME $NR_ITER & >/dev/null 2>&1
+}
+
+function wait_apps
+{
+	echo "Waiting for applications to end"
+	while [ -n "$(pidof $BIN_NAME)" ]; do
+		echo -n "."
+		sleep 1
+	done
+	echo ""
+}
+
+function test_valid_filter
+{
+	filter="$1"
+	validator="$2"
+
+	echo ""
+	echo -e "=== Testing valid filter: $1"
+
+	trace_path=$(mktemp -d)
+
+	# Create session
+	create_lttng_session $SESSION_NAME $trace_path
+
+	# Enable filter
+	enable_ust_lttng_event_filter $SESSION_NAME $EVENT_NAME $filter
+
+	# Trace apps
+	start_lttng_tracing $SESSION_NAME
+	run_apps
+	wait_apps
+	stop_lttng_tracing $SESSION_NAME
+
+	# Destroy session
+	destroy_lttng_session $SESSION_NAME
+
+	echo -n "Validating filter output "
+	stats=`babeltrace $trace_path | $CURDIR/$STATS_BIN --tracepoint $EVENT_NAME`
+
+	$validator "$stats"
+
+	if [ $? -eq 0 ]; then
+		print_ok
+#		rm -rf $trace_path
+		return 0
+	else
+		print_fail
+		return 1
+	fi
+}
+
+function validate_min_max
+{
+	stats="$1"
+	field=$2
+	expected_min=$3
+	expected_max=$4
+
+	echo $stats | grep -q "$field $expected_min $expected_max"
+
+	return $?
+}
+
+function validator_intfield
+{
+	stats="$1"
+	status=0
+
+	validate_min_max "$stats" "intfield" "1" "99"
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "intfield2" "0x1" "0x63"
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "longfield" "1" "99"
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "netintfield" "1" "99"
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "netintfieldhex" "0x1" "0x63"
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "floatfield" "2222" "2222"
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "doublefield" "2" "2"
+	status=$(($status|$?))
+
+	return $status
+}
+
+function validator_intfield_gt
+{
+	stats="$1"
+	status=0
+
+	validate_min_max "$stats" "intfield" "2" "99"
+	status=$(($status|$?))
+
+	return $status
+}
+
+function validator_intfield_ge
+{
+	stats="$1"
+	status=0
+
+	validate_min_max "$stats" "intfield" "1" "99"
+	status=$(($status|$?))
+
+	return $status
+}
+
+function validator_intfield_lt
+{
+	stats="$1"
+	status=0
+
+	validate_min_max "$stats" "intfield" "0" "1"
+	status=$(($status|$?))
+
+	return $status
+}
+
+function validator_intfield_le
+{
+	stats="$1"
+	status=0
+
+	validate_min_max "$stats" "intfield" "0" "2"
+	status=$(($status|$?))
+
+	return $status
+}
+
+function validator_intfield_eq
+{
+	stats="$1"
+	status=0
+
+	validate_min_max "$stats" "intfield" "1" "1"
+	status=$(($status|$?))
+
+	return $status
+}
+
+function validator_intfield_ne
+{
+	stats="$1"
+	status=0
+
+	validate_min_max "$stats" "intfield" "0" "98"
+	status=$(($status|$?))
+
+	return $status
+}
+
+function validator_intfield_not
+{
+	stats="$1"
+	status=0
+
+	validate_min_max "$stats" "intfield" "0" "0"
+	status=$(($status|$?))
+
+	return $status
+}
+
+function validator_intfield_gt_and_longfield_gt
+{
+	stats="$1"
+	status=0
+
+	validate_min_max "$stats" "intfield" "43" "99"
+	status=$(($status|$?))
+	validate_min_max "$stats" "longfield" "43" "99"
+	status=$(($status|$?))
+
+	return $status
+}
+
+function validator_intfield_ge_and_longfield_le
+{
+	stats="$1"
+	status=0
+
+	validate_min_max "$stats" "intfield" "42" "42"
+	status=$(($status|$?))
+	validate_min_max "$stats" "longfield" "42" "42"
+	status=$(($status|$?))
+
+	return $status
+}
+
+function validator_intfield_lt_or_longfield_gt
+{
+	stats="$1"
+	status=0
+
+	validate_min_max "$stats" "intfield" "0" "99"
+	status=$(($status|$?))
+	validate_min_max "$stats" "longfield" "0" "99"
+	status=$(($status|$?))
+
+	return $status
+}
+
+function validator_mixed_str_or_int_and_int
+{
+	stats="$1"
+	status=0
+
+	validate_min_max "$stats" "intfield" "34" "99"
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "stringfield" "\"test\"" "\"test\""
+	status=$(($status|$?))
+
+	return $status
+}
+
+function validator_mixed_int_double
+{
+	stats="$1"
+	status=0
+
+	validate_min_max "$stats" "intfield" "0" "42"
+	status=$(($status|$?))
+
+	return $status
+}
+
+function validator_true_statement
+{
+	stats="$1"
+	status=0
+
+	validate_min_max "$stats" "intfield" "0" "99"
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "intfield2" "0x0" "0x63"
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "longfield" "0" "99"
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "netintfield" "0" "99"
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "netintfieldhex" "0x0" "0x63"
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "floatfield" "2222" "2222"
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "doublefield" "2" "2"
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "stringfield" "\"test\"" "\"test\""
+	status=$(($status|$?))
+
+	validate_min_max "$stats" "stringfield2" ""\*"" ""\*""
+	status=$(($status|$?))
+
+	return $status
+}
+
+IFS=$'\n'
+
+issue_356_filter="intfield > 0 && intfield > 1 && "
+issue_356_filter+="intfield > 2 && intfield > 3 && "
+issue_356_filter+="intfield > 4 && intfield > 5 && "
+issue_356_filter+="intfield > 6 && intfield > 7 && "
+issue_356_filter+="intfield > 8 || intfield > 0"
+
+# One to one mapping between filters and validators
+
+FILTERS=("intfield"                                                     #1
+	 "intfield > 1"                                                 #2
+	 "intfield >= 1"                                                #3
+	 "intfield < 2"                                                 #4
+	 "intfield <= 2"                                                #5
+	 "intfield == 1"                                                #6
+	 "intfield != 99"                                               #7
+	 "!intfield"                                                    #8
+	 "-intfield"                                                    #9
+	 "--intfield"                                                   #10
+	 "+intfield"                                                    #11
+	 "++intfield"                                                   #12
+	 "intfield > 1 && longfield > 42"                               #13
+	 "intfield >= 42 && longfield <= 42"                            #14
+	 "intfield < 1 || longfield > 98"                               #15
+	 "(stringfield == \"test\" || intfield != 10) && intfield > 33" #16
+	 "intfield < 42.4242424242"                                     #17
+	 "\"test\" == \"test\""                                         #18 #Issue #342
+	 "stringfield == \"test\""                                      #19
+	 "stringfield == \"t*\""                                        #20
+	 "stringfield == \"*\""                                         #21
+	 $issue_356_filter                                              #22 #Issue #356
+	 "intfield < 0xDEADBEEF"                                        #23
+	 "intfield < 0x2"                                               #24
+	 "intfield < 02"                                                #25
+	 "stringfield2 == \"\\\*\""                                     #26
+)
+
+VALIDATOR=("validator_intfield"                     #1
+	   "validator_intfield_gt"                  #2
+	   "validator_intfield_ge"                  #3
+	   "validator_intfield_lt"                  #4
+	   "validator_intfield_le"                  #5
+	   "validator_intfield_eq"                  #6
+	   "validator_intfield_ne"                  #7
+	   "validator_intfield_not"                 #8
+	   "validator_intfield"                     #9
+	   "validator_intfield"                     #10
+	   "validator_intfield"                     #11
+	   "validator_intfield"                     #12
+	   "validator_intfield_gt_and_longfield_gt" #13
+	   "validator_intfield_ge_and_longfield_le" #14
+	   "validator_intfield_lt_or_longfield_gt"  #15
+	   "validator_mixed_str_or_int_and_int"     #16
+	   "validator_mixed_int_double"             #17
+	   "validator_true_statement"               #18
+	   "validator_true_statement"               #19
+	   "validator_true_statement"               #20
+	   "validator_true_statement"               #21
+	   "validator_intfield"                     #22
+	   "validator_true_statement"               #23
+	   "validator_intfield_lt"                  #24
+	   "validator_intfield_lt"                  #25
+	   "validator_true_statement"               #26
+)
+
+FILTER_COUNT=${#FILTERS[@]}
+i=0
+
+start_lttng_sessiond
+
+while [ "$i" -lt "$FILTER_COUNT" ]; do
+
+	test_valid_filter "${FILTERS[$i]}" "${VALIDATOR[$i]}"
+
+	if [ $? -eq 1 ]; then
+		stop_lttng_sessiond
+		exit 1
+	fi
+
+	let "i++"
+done
+
+stop_lttng_sessiond
-- 
1.7.12.2
