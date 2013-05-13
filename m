From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 2/6] Tests: Replace usage of
	gen-ust-events testapp in streaming tests
Date: Mon, 13 May 2013 18:30:52 -0400
Message-ID: <1368484256-6666-2-git-send-email-christian.babeux__19985.3611215532$1368484314$gmane$org@efficios.com>
References: <1368484256-6666-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f41.google.com ([209.85.212.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Uc1HA-0002Ul-OH
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 18:31:25 -0400
Received: by mail-vb0-f41.google.com with SMTP id w8so5578439vbf.14
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 15:31:19 -0700 (PDT)
In-Reply-To: <1368484256-6666-1-git-send-email-christian.babeux@efficios.com>
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

Use the gen-ust-events binary found under tests/utils/testapp/gen-ust-events/.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/regression/tools/streaming/Makefile.am       | 16 ------
 tests/regression/tools/streaming/gen-ust-events.c  | 59 ----------------------
 .../tools/streaming/test_high_throughput_limits    | 12 +++--
 tests/regression/tools/streaming/test_ust          | 16 +++---
 tests/regression/tools/streaming/tp.c              | 15 ------
 tests/regression/tools/streaming/tp.h              | 56 --------------------
 6 files changed, 17 insertions(+), 157 deletions(-)
 delete mode 100644 tests/regression/tools/streaming/gen-ust-events.c
 delete mode 100644 tests/regression/tools/streaming/tp.c
 delete mode 100644 tests/regression/tools/streaming/tp.h

diff --git a/tests/regression/tools/streaming/Makefile.am b/tests/regression/tools/streaming/Makefile.am
index e424350..050cdea 100644
--- a/tests/regression/tools/streaming/Makefile.am
+++ b/tests/regression/tools/streaming/Makefile.am
@@ -1,18 +1,2 @@
-AM_CFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src -I$(top_srcdir)/tests/utils -I$(srcdir) -O2 -g
-AM_LDFLAGS =
-
-if LTTNG_TOOLS_BUILD_WITH_LIBDL
-AM_LDFLAGS += -ldl
-endif
-if LTTNG_TOOLS_BUILD_WITH_LIBC_DL
-AM_LDFLAGS += -lc
-endif
-
-if HAVE_LIBLTTNG_UST_CTL
-noinst_PROGRAMS = gen-ust-events
-gen_ust_events_SOURCES = gen-ust-events.c tp.c tp.h
-gen_ust_events_LDADD = -llttng-ust
-endif
-
 noinst_SCRIPTS = test_ust test_kernel test_high_throughput_limits
 EXTRA_DIST = test_ust test_kernel test_high_throughput_limits
diff --git a/tests/regression/tools/streaming/gen-ust-events.c b/tests/regression/tools/streaming/gen-ust-events.c
deleted file mode 100644
index 1385119..0000000
--- a/tests/regression/tools/streaming/gen-ust-events.c
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Copyright (C) - 2012 David Goulet <dgoulet@efficios.com>
- *
- * This library is free software; you can redistribute it and/or modify it
- * under the terms of the GNU Lesser General Public License as published by the
- * Free Software Foundation; version 2.1 of the License.
- *
- * This library is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
- * for more details.
- *
- * You should have received a copy of the GNU Lesser General Public License
- * along with this library; if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
- */
-
-#include <arpa/inet.h>
-#include <stdarg.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <sys/mman.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <unistd.h>
-
-#define TRACEPOINT_DEFINE
-#include "tp.h"
-
-int main(int argc, char **argv)
-{
-	int i, netint;
-	long values[] = { 1, 2, 3 };
-	char text[10] = "test";
-	double dbl = 2.0;
-	float flt = 2222.0;
-	/* Generate 30 events. */
-	unsigned int nr_iter = 100;
-	useconds_t nr_usec = 0;
-
-	if (argc >= 2) {
-		nr_iter = atoi(argv[1]);
-	}
-
-	if (argc == 3) {
-		/* By default, don't wait unless user specifies. */
-		nr_usec = atoi(argv[2]);
-	}
-
-	for (i = 0; i < nr_iter; i++) {
-		netint = htonl(i);
-		tracepoint(tp, tptest, i, netint, values, text, strlen(text), dbl,
-				flt);
-		usleep(nr_usec);
-	}
-
-	return 0;
-}
diff --git a/tests/regression/tools/streaming/test_high_throughput_limits b/tests/regression/tools/streaming/test_high_throughput_limits
index f3885a8..b2c8864 100755
--- a/tests/regression/tools/streaming/test_high_throughput_limits
+++ b/tests/regression/tools/streaming/test_high_throughput_limits
@@ -22,7 +22,9 @@ CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../../..
 NR_APP_ITER=10
 NR_ITER=1000000
-BIN_NAME="gen-ust-events"
+TESTAPP_PATH="$TESTDIR/utils/testapp"
+TESTAPP_NAME="gen-ust-events"
+TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
 SESSION_NAME="high-throughput"
 EVENT_NAME="tp:tptest"
 SESSIOND_CTRL_PORT=5342
@@ -35,8 +37,8 @@ NUM_TESTS=112
 
 source $TESTDIR/utils/utils.sh
 
-if [ ! -x "$CURDIR/$BIN_NAME" ]; then
-	BAIL_OUT "No UST nevents binary detected."
+if [ ! -x "$TESTAPP_BIN" ]; then
+	BAIL_OUT "No UST events binary detected."
 fi
 
 function set_bw_limit
@@ -89,13 +91,13 @@ function run_apps
 		# due to very slow communication between the consumer and relayd making
 		# the status reply from the consumer quite slow thus delaying the
 		# registration done message.
-		LTTNG_UST_REGISTER_TIMEOUT=-1 ./$CURDIR/$BIN_NAME $NR_ITER & >/dev/null 2>&1
+		LTTNG_UST_REGISTER_TIMEOUT=-1 $TESTAPP_BIN $NR_ITER & >/dev/null 2>&1
 	done
 }
 
 function wait_apps
 {
-	while [ -n "$(pidof $BIN_NAME)" ]; do
+	while [ -n "$(pidof $TESTAPP_NAME)" ]; do
 		sleep 1
 	done
 	pass "Wait for applications to end"
diff --git a/tests/regression/tools/streaming/test_ust b/tests/regression/tools/streaming/test_ust
index 333b2e9..785a9a8 100755
--- a/tests/regression/tools/streaming/test_ust
+++ b/tests/regression/tools/streaming/test_ust
@@ -18,7 +18,11 @@ TEST_DESC="Streaming - User space tracing"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../../..
-BIN_NAME="gen-ust-events"
+NR_ITER=5
+NR_USEC_WAIT=1000000
+TESTAPP_PATH="$TESTDIR/utils/testapp"
+TESTAPP_NAME="gen-ust-events"
+TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
 SESSION_NAME="stream"
 EVENT_NAME="tp:tptest"
 PID_RELAYD=0
@@ -29,8 +33,8 @@ NUM_TESTS=18
 
 source $TESTDIR/utils/utils.sh
 
-if [ ! -x "$CURDIR/$BIN_NAME" ]; then
-	BAIL_OUT "No UST nevents binary detected."
+if [ ! -x "$TESTAPP_BIN" ]; then
+	BAIL_OUT "No UST events binary detected."
 fi
 
 function lttng_create_session_uri
@@ -42,7 +46,7 @@ function lttng_create_session_uri
 
 function wait_apps
 {
-	while [ -n "$(pidof $BIN_NAME)" ]; do
+	while [ -n "$(pidof $TESTAPP_NAME)" ]; do
 		sleep 0.5
 	done
 	pass "Wait for applications to end"
@@ -57,7 +61,7 @@ function test_ust_before_start ()
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
 
 	# Run 5 times with a 1 second delay
-	./$CURDIR/$BIN_NAME 5 1000000 >/dev/null 2>&1 &
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1 &
 
 	start_lttng_tracing $SESSION_NAME
 
@@ -75,7 +79,7 @@ function test_ust_after_start ()
 	start_lttng_tracing $SESSION_NAME
 
 	# Run 5 times with a 1 second delay
-	./$CURDIR/$BIN_NAME 5 1000000 >/dev/null 2>&1 &
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1 &
 
 	wait_apps
 
diff --git a/tests/regression/tools/streaming/tp.c b/tests/regression/tools/streaming/tp.c
deleted file mode 100644
index a09561d..0000000
--- a/tests/regression/tools/streaming/tp.c
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * Copyright (c) - 2012 David Goulet <dgoulet@efficios.com>
- *
- * THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED OR
- * IMPLIED. ANY USE IS AT YOUR OWN RISK.
- *
- * Permission is hereby granted to use or copy this program for any purpose,
- * provided the above notices are retained on all copies.  Permission to modify
- * the code and to distribute modified code is granted, provided the above
- * notices are retained, and a notice that the code was modified is included
- * with the above copyright notice.
- */
-
-#define TRACEPOINT_CREATE_PROBES
-#include "tp.h"
diff --git a/tests/regression/tools/streaming/tp.h b/tests/regression/tools/streaming/tp.h
deleted file mode 100644
index 6ffbc32..0000000
--- a/tests/regression/tools/streaming/tp.h
+++ /dev/null
@@ -1,56 +0,0 @@
-#undef TRACEPOINT_PROVIDER
-#define TRACEPOINT_PROVIDER tp
-
-#if !defined(_TRACEPOINT_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
-#define _TRACEPOINT_TP_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-/*
- * Copyright (C) 2011  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
- *
- * THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
- * OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
- *
- * Permission is hereby granted to use or copy this program
- * for any purpose,  provided the above notices are retained on all copies.
- * Permission to modify the code and to distribute modified code is granted,
- * provided the above notices are retained, and a notice that the code was
- * modified is included with the above copyright notice.
- */
-
-#include <lttng/tracepoint.h>
-
-TRACEPOINT_EVENT(tp, tptest,
-	TP_ARGS(int, anint, int, netint, long *, values,
-		char *, text, size_t, textlen,
-		double, doublearg, float, floatarg),
-	TP_FIELDS(
-		ctf_integer(int, intfield, anint)
-		ctf_integer_hex(int, intfield2, anint)
-		ctf_integer(long, longfield, anint)
-		ctf_integer_network(int, netintfield, netint)
-		ctf_integer_network_hex(int, netintfieldhex, netint)
-		ctf_array(long, arrfield1, values, 3)
-		ctf_array_text(char, arrfield2, text, 10)
-		ctf_sequence(char, seqfield1, text, size_t, textlen)
-		ctf_sequence_text(char, seqfield2, text, size_t, textlen)
-		ctf_string(stringfield, text)
-		ctf_float(float, floatfield, floatarg)
-		ctf_float(double, doublefield, doublearg)
-	)
-)
-
-#endif /* _TRACEPOINT_TP_H */
-
-#undef TRACEPOINT_INCLUDE_FILE
-#define TRACEPOINT_INCLUDE_FILE ./tp.h
-
-/* This part must be outside ifdef protection */
-#include <lttng/tracepoint-event.h>
-
-#ifdef __cplusplus
-}
-#endif
-- 
1.8.2.2
