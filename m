From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Tests: Ust getcpu override plugin
Date: Tue, 14 Jul 2015 17:52:51 -0400
Message-ID: <1436910771-23117-1-git-send-email-jonathan.rajotte-julien__225.587053182785$1436910859$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZF88Z-00014z-9k
 for lttng-dev@lists.lttng.org; Tue, 14 Jul 2015 17:53:19 -0400
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac                                       |   1 +
 tests/fast_regression                              |   1 +
 tests/regression/ust/Makefile.am                   |   3 +-
 tests/regression/ust/getcpu-override/Makefile.am   |  37 +++++
 .../lttng-ust-getcpu-override-test.c               |  84 +++++++++++
 .../ust/getcpu-override/run-getcpu-override        |  13 ++
 .../ust/getcpu-override/test_getcpu_override       | 166 +++++++++++++++++++++
 7 files changed, 304 insertions(+), 1 deletion(-)
 create mode 100644 tests/regression/ust/getcpu-override/Makefile.am
 create mode 100644 tests/regression/ust/getcpu-override/lttng-ust-getcpu-override-test.c
 create mode 100755 tests/regression/ust/getcpu-override/run-getcpu-override
 create mode 100755 tests/regression/ust/getcpu-override/test_getcpu_override

diff --git a/configure.ac b/configure.ac
index 1fcac72..287e3d4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -529,6 +529,7 @@ AC_CONFIG_FILES([
 	tests/regression/ust/java-jul/Makefile
 	tests/regression/ust/java-log4j/Makefile
 	tests/regression/ust/python-logging/Makefile
+	tests/regression/ust/getcpu-override/Makefile
 	tests/stress/Makefile
 	tests/unit/Makefile
 	tests/unit/ini_config/Makefile
diff --git a/tests/fast_regression b/tests/fast_regression
index c14f7f2..037054f 100644
--- a/tests/fast_regression
+++ b/tests/fast_regression
@@ -22,6 +22,7 @@ regression/ust/overlap/test_overlap
 regression/ust/java-jul/test_java_jul
 regression/ust/java-log4j/test_java_log4j
 regression/ust/python-logging/test_python_logging
+regression/ust/getcpu-override/test_getcpu_override
 regression/ust/test_event_basic
 regression/ust/test_event_tracef
 regression/ust/test_event_wildcard
diff --git a/tests/regression/ust/Makefile.am b/tests/regression/ust/Makefile.am
index 0d11f90..e3a04c0 100644
--- a/tests/regression/ust/Makefile.am
+++ b/tests/regression/ust/Makefile.am
@@ -1,7 +1,8 @@
 if HAVE_LIBLTTNG_UST_CTL
 SUBDIRS = nprocesses high-throughput low-throughput before-after multi-session \
 		overlap buffers-pid linking daemon exit-fast fork libc-wrapper \
-		periodical-metadata-flush java-jul java-log4j python-logging
+		periodical-metadata-flush java-jul java-log4j python-logging \
+		getcpu-override
 
 EXTRA_DIST = test_event_basic test_event_wildcard test_event_tracef test_event_perf
 
diff --git a/tests/regression/ust/getcpu-override/Makefile.am b/tests/regression/ust/getcpu-override/Makefile.am
new file mode 100644
index 0000000..f1026ac
--- /dev/null
+++ b/tests/regression/ust/getcpu-override/Makefile.am
@@ -0,0 +1,37 @@
+AM_CPPFLAGS = -I$(srcdir)
+
+# The rpath is necessary because libtool won't build a shared library
+# if it's noinst_
+GETCPU_LIBTOOL_FLAGS = \
+    -module \
+    -shared \
+    -avoid-version \
+    --no-as-needed \
+    -rpath $(abs_builddir)
+
+noinst_LTLIBRARIES = lttng-ust-getcpu-override-test.la
+lttng_ust_getcpu_override_test_la_LDFLAGS = $(GETCPU_LIBTOOL_FLAGS)
+
+if LTTNG_TOOLS_BUILD_WITH_LIBDL
+lttng_ust_getcpu_override_test_la_LIBADD = -ldl
+endif
+if LTTNG_TOOLS_BUILD_WITH_LIBC_DL
+lttng_ust_getcpu_override_test_la_LIBADD = -lc
+endif
+
+noinst_SCRIPTS = test_getcpu_override run-getcpu-override
+EXTRA_DIST = test_getcpu_override run-getcpu-override
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
diff --git a/tests/regression/ust/getcpu-override/lttng-ust-getcpu-override-test.c b/tests/regression/ust/getcpu-override/lttng-ust-getcpu-override-test.c
new file mode 100644
index 0000000..f098e2c
--- /dev/null
+++ b/tests/regression/ust/getcpu-override/lttng-ust-getcpu-override-test.c
@@ -0,0 +1,84 @@
+/*
+ * lttng-ust-getcpu-override-test.c
+ * Based on lttng-getcpu-override-example.c from LTTng-ust exemple
+ *
+ * Copyright (c) 2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright (c) 2015 Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <stdlib.h>
+#include <time.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <lttng/ust-getcpu.h>
+
+int plugin_getcpu(void)
+{
+	/* Generate a sequence based on the number of configurated processor
+	 * by using sequence[i] % nb_configured_processors. Where sequence
+	 * is a static random sequence.
+	 * The expected cpu_id sequence can be regenerated on the test script
+	 * side and compared to the extracted cpu sequence for validation.
+	 * This does no guarantee in absolute the validity of the getcpu
+	 * plugin but provide a strong argument of it's validity.
+	 */
+	static int i = 0;
+	static int seq_seed[256] = {100, 57, 232, 236, 42, 193, 224, 184, 216, 150,
+		92, 91, 108, 118, 55, 243, 65, 101, 209, 0, 147, 36, 29, 34, 49, 188,
+		174, 105, 253, 245, 227, 238, 112, 20, 222, 201, 102, 175, 119, 19, 132,
+		41, 78, 90, 114, 64, 138, 14, 48, 18, 162, 85, 204, 124, 133, 73, 172,
+		106, 241, 126, 28, 104, 111, 21, 127, 219, 9, 244, 237, 189, 59, 214,
+		52, 141, 107, 26, 25, 199, 3, 157, 117, 234, 33, 44, 46, 84, 69, 155,
+		122, 250, 231, 86, 239, 76, 190, 120, 1, 94, 206, 8, 148, 159, 167, 215,
+		164, 31, 217, 61, 71, 125, 68, 109, 195, 177, 95, 82, 142, 182, 129, 87,
+		37, 140, 134, 186, 173, 39, 116, 143, 254, 229, 131, 67, 121, 192, 240,
+		15, 221, 30, 242, 185, 80, 170, 135, 51, 187, 194, 246, 12, 225, 181,
+		137, 211, 228, 88, 218, 27, 233, 161, 77, 252, 123, 93, 220, 248, 205,
+		223, 144, 128, 196, 70, 247, 210, 178, 203, 154, 24, 169, 149, 163, 35,
+		7, 151, 103, 197, 139, 165, 158, 207, 72, 113, 145, 45, 183, 11, 198,
+		43, 81, 230, 97, 96, 2, 66, 213, 146, 179, 22, 58, 54, 38, 160, 200,
+		235, 226, 156, 56, 208, 249, 32, 176, 168, 110, 191, 79, 152, 115, 10,
+		74, 60, 251, 17, 83, 180, 171, 202, 40, 166, 255, 53, 212, 98, 5, 50,
+		99, 4, 89, 13, 63, 6, 136, 153, 23, 16, 47, 130, 75, 62};
+
+	int ret;
+	ret = seq_seed[i] % sysconf(_SC_NPROCESSORS_CONF);
+	i++;
+	i = i % 256;
+	return ret;
+}
+
+void lttng_ust_getcpu_plugin_init(void)
+{
+	int ret;
+
+	ret = lttng_ust_getcpu_override(plugin_getcpu);
+	if (ret) {
+		fprintf(stderr, "Error enabling getcpu override: %s\n",
+			strerror(-ret));
+		goto error;
+	}
+	return;
+
+error:
+	exit(EXIT_FAILURE);
+}
diff --git a/tests/regression/ust/getcpu-override/run-getcpu-override b/tests/regression/ust/getcpu-override/run-getcpu-override
new file mode 100755
index 0000000..2e5d82b
--- /dev/null
+++ b/tests/regression/ust/getcpu-override/run-getcpu-override
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+# launch with: run-getcpu-override progname args
+DIR=$(dirname $0)
+DIR=$(readlink -f $DIR)
+
+if [ -x "$DIR/.libs/lttng-ust-getcpu-override-test.so" ]; then
+	ret=`LTTNG_UST_GETCPU_PLUGIN="$DIR/.libs/lttng-ust-getcpu-override-test.so" $@`
+	exit $ret
+else
+	echo "Getcpu-override missing shared object"
+	exit $1
+fi
diff --git a/tests/regression/ust/getcpu-override/test_getcpu_override b/tests/regression/ust/getcpu-override/test_getcpu_override
new file mode 100755
index 0000000..2492c9c
--- /dev/null
+++ b/tests/regression/ust/getcpu-override/test_getcpu_override
@@ -0,0 +1,166 @@
+#!/bin/bash
+#
+# Copyright (C) - 2015 Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
+#
+# This library is free software; you can redistribute it and/or modify it under
+# the terms of the GNU Lesser General Public License as published by the Free
+# Software Foundation; version 2.1 of the License.
+#
+# This library is distributed in the hope that it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
+# details.
+#
+# You should have received a copy of the GNU Lesser General Public License
+# along with this library; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+TEST_DESC="UST - Getcpu override plugin"
+
+CURDIR=$(dirname $0)/
+TESTDIR=$CURDIR/../../..
+SESSION_NAME="sequence-cpu"
+
+TESTAPP_PATH="$TESTDIR/utils/testapp"
+TESTAPP_NAME="gen-ust-events"
+TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
+TESTAPP_WRAPPER="run-getcpu-override"
+NUM_EVENT=256
+EVENT_NAME="tp:tptest"
+
+NUM_TESTS=20
+
+SEQUENCE_SEED=(
+100 57 232 236 42 193 224 184 216 150 92 91 108 118 55 243 65 101 209 0 147 36
+29 34 49 188 174 105 253 245 227 238 112 20 222 201 102 175 119 19 132 41 78 90
+114 64 138 14 48 18 162 85 204 124 133 73 172 106 241 126 28 104 111 21 127 219
+9 244 237 189 59 214 52 141 107 26 25 199 3 157 117 234 33 44 46 84 69 155 122
+250 231 86 239 76 190 120 1 94 206 8 148 159 167 215 164 31 217 61 71 125 68 109
+195 177 95 82 142 182 129 87 37 140 134 186 173 39 116 143 254 229 131 67 121
+192 240 15 221 30 242 185 80 170 135 51 187 194 246 12 225 181 137 211 228 88
+218 27 233 161 77 252 123 93 220 248 205 223 144 128 196 70 247 210 178 203 154
+24 169 149 163 35 7 151 103 197 139 165 158 207 72 113 145 45 183 11 198 43 81
+230 97 96 2 66 213 146 179 22 58 54 38 160 200 235 226 156 56 208 249 32 176 168
+110 191 79 152 115 10 74 60 251 17 83 180 171 202 40 166 255 53 212 98 5 50 99 4
+89 13 63 6 136 153 23 16 47 130 75 62
+)
+
+# Equivalent to the syconf(_SC_NPROCESSORS_CONF) call.
+NPROC=`nproc --all`
+
+source $TESTDIR/utils/utils.sh
+
+if [ ! -x "$CURDIR/.libs/lttng-ust-getcpu-override-test.so" ]; then
+	BAIL_OUT "No shared object generated"
+fi
+
+# MUST set TESTDIR before calling those functions
+
+run_app()
+{
+	diag "Launching app without getcpu-plugin wrapper"
+	$TESTAPP_BIN $NUM_EVENT
+	ok $? "Application without wrapper done"
+}
+
+run_getcpu_plugin_app()
+{
+	diag "Launching app with getcpu-plugin wrapper"
+	$CURDIR/$TESTAPP_WRAPPER $TESTAPP_BIN $NUM_EVENT
+	ok $? "Application with wrapper done"
+}
+
+compare_ok()
+{
+	compare 0 "$@"
+}
+
+compare_fail()
+{
+	compare 1 "$@"
+}
+
+compare()
+{
+	local expected_to_fail=$1
+	declare -a array_to_compare=("${!2}")
+	local valid=0
+
+	test ${#array_to_compare[*]} -eq ${#SEQUENCE_SEED[*]}
+	ok $? "Sequence seed and cpuid sequence are equal ${#SEQUENCE_SEED[*]}/${#array_to_compare[*]}"
+
+	for (( i = 0; i < ${#SEQUENCE_SEED[*]}; i++ )); do
+		if [ "${array_to_compare[$i]}" -ne "$(( ${SEQUENCE_SEED[$i]} % $NPROC))" ]; then
+			valid=1
+			break
+		fi
+	done
+
+	if [[ $expected_to_fail -eq "1" ]]; then
+		test $valid -ne "0"
+		ok $? "Cpuid extraction and seed sequence comparison fail as expected"
+	else
+		ok $valid "Cpuid extraction and seed sequence comparison"
+	fi
+}
+
+test_getcpu_override()
+{
+	diag "Getcpu plugin"
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
+	enable_ust_lttng_event_ok $SESSION_NAME "$EVENT_NAME"
+	start_lttng_tracing_ok $SESSION_NAME
+	run_app
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	# Move output to an array by using =($())
+	cpuid_events=($($BABELTRACE_BIN $TRACE_PATH | sed -n 's/.*cpu_id = \([0-9]*\).*/\1/p'))
+	num_events=${#cpuid_events[*]}
+	test $num_events -eq $NUM_EVENT
+	ok $? "Extraction without getcpu plugin have $num_events/$NUM_EVENT"
+	compare_fail cpuid_events[@]
+
+	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
+	enable_ust_lttng_event_ok $SESSION_NAME "$EVENT_NAME"
+	start_lttng_tracing_ok $SESSION_NAME
+	run_getcpu_plugin_app
+	stop_lttng_tracing_ok $SESSION_NAME
+	destroy_lttng_session_ok $SESSION_NAME
+
+	cpuid_events=($($BABELTRACE_BIN $TRACE_PATH | sed -n 's/.*cpu_id = \([0-9]*\).*/\1/p'))
+	num_events=${#cpuid_events[*]}
+	test $num_events -eq $NUM_EVENT
+	ok $? "Extraction without getcpu plugin have $num_events/$NUM_EVENT"
+
+	compare_ok cpuid_events[@]
+
+	return $?
+}
+
+plan_tests $NUM_TESTS
+
+print_test_banner "$TEST_DESC"
+
+TESTS=(
+	"test_getcpu_override"
+)
+
+TEST_COUNT=${#TESTS[@]}
+i=0
+
+start_lttng_sessiond
+
+while [ "$i" -lt "$TEST_COUNT" ]; do
+
+	TRACE_PATH=$(mktemp -d)
+
+	# Execute test
+	${TESTS[$i]}
+
+	rm -rf $TRACE_PATH
+
+	let "i++"
+done
+
+stop_lttng_sessiond
-- 
2.1.4
