From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 5/6] Tests: Replace usage of
	gen-ust-events testapp in ust nprocesses test
Date: Mon, 13 May 2013 18:30:55 -0400
Message-ID: <1368484256-6666-5-git-send-email-christian.babeux__10941.4286482663$1368484336$gmane$org@efficios.com>
References: <1368484256-6666-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Uc1HX-0002XG-EY
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 18:31:47 -0400
Received: by mail-ve0-f170.google.com with SMTP id 14so2239207vea.15
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 15:31:42 -0700 (PDT)
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
 tests/regression/ust/nprocesses/Makefile.am       | 14 ------
 tests/regression/ust/nprocesses/gen-events-time.c | 61 -----------------------
 tests/regression/ust/nprocesses/test_nprocesses   | 28 ++++++-----
 tests/regression/ust/nprocesses/tp.c              | 16 ------
 tests/regression/ust/nprocesses/ust_gen_event.h   | 56 ---------------------
 5 files changed, 16 insertions(+), 159 deletions(-)
 delete mode 100644 tests/regression/ust/nprocesses/gen-events-time.c
 delete mode 100644 tests/regression/ust/nprocesses/tp.c
 delete mode 100644 tests/regression/ust/nprocesses/ust_gen_event.h

diff --git a/tests/regression/ust/nprocesses/Makefile.am b/tests/regression/ust/nprocesses/Makefile.am
index 3113a34..70a4eea 100644
--- a/tests/regression/ust/nprocesses/Makefile.am
+++ b/tests/regression/ust/nprocesses/Makefile.am
@@ -1,16 +1,2 @@
-AM_CFLAGS = -I$(srcdir) -O2
-AM_LDFLAGS = -llttng-ust
-
-if LTTNG_TOOLS_BUILD_WITH_LIBDL
-AM_LDFLAGS += -ldl
-endif
-if LTTNG_TOOLS_BUILD_WITH_LIBC_DL
-AM_LDFLAGS += -lc
-endif
-
-noinst_PROGRAMS = gen-events-time
-gen_events_time_SOURCES = gen-events-time.c tp.c ust_gen_event.h
-gen_events_time_LDADD = -llttng-ust
-
 noinst_SCRIPTS = test_nprocesses
 EXTRA_DIST = test_nprocesses
diff --git a/tests/regression/ust/nprocesses/gen-events-time.c b/tests/regression/ust/nprocesses/gen-events-time.c
deleted file mode 100644
index bc5b68c..0000000
--- a/tests/regression/ust/nprocesses/gen-events-time.c
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * Copyright (C) - 2009 Pierre-Marc Fournier
- * Copyright (C) - 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
-#include <fcntl.h>
-#include <signal.h>
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
-#include "ust_gen_event.h"
-
-int main(int argc, char **argv)
-{
-	int i, netint;
-	long values[] = { 1, 2, 3 };
-	char text[10] = "test";
-	double dbl = 2.0;
-	float flt = 2222.0;
-	/* Default loop time is 60 sec since each round sleeps 1 sec */
-	unsigned int nr_iter = 60;
-
-	fclose(stdout);
-	fclose(stderr);
-	fclose(stdin);
-
-	if (argc == 2) {
-		nr_iter = atoi(argv[1]);
-	}
-
-	for (i = 0; i < nr_iter; i++) {
-		netint = htonl(i);
-		tracepoint(ust_gen_event, tptest, i, netint, values, text,
-				strlen(text), dbl, flt);
-		sleep(1);
-	}
-
-	return 0;
-}
diff --git a/tests/regression/ust/nprocesses/test_nprocesses b/tests/regression/ust/nprocesses/test_nprocesses
index f9ed0b1..1660c21 100755
--- a/tests/regression/ust/nprocesses/test_nprocesses
+++ b/tests/regression/ust/nprocesses/test_nprocesses
@@ -14,21 +14,25 @@
 # You should have received a copy of the GNU Lesser General Public License
 # along with this library; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
-NR_ITER=30
-TEST_DESC="UST tracer - Generate $NR_ITER process"
+NUM_PROCESS=30
+TEST_DESC="UST tracer - Generate $NUM_PROCESS process"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../../..
-TEST_BIN_NAME="gen-events-time"
+NR_ITER=1000
+NR_USEC_WAIT=1000000
+TESTAPP_PATH="$TESTDIR/utils/testapp"
+TESTAPP_NAME="gen-ust-events"
+TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
 SESSION_NAME="ust-nprocesses"
-EVENT_NAME="ust_gen_event:tptest"
+EVENT_NAME="tp:tptest"
 TEST_WAIT_SEC=5
 NUM_TESTS=9
 
 source $TESTDIR/utils/utils.sh
 
-if [ ! -x "$CURDIR/$TEST_BIN_NAME" ]; then
-	BAIL_OUT "No UST $TEST_BIN_NAME binary detected."
+if [ ! -x "$TESTAPP_BIN" ]; then
+	BAIL_OUT "No UST $TESTAPP_BIN binary detected."
 fi
 
 # MUST set TESTDIR before calling those functions
@@ -41,15 +45,15 @@ start_lttng_sessiond
 
 # Start test for 1000 seconds
 
-for i in `seq 1 $NR_ITER`
+for i in `seq 1 $NUM_PROCESS`
 do
-	./$CURDIR/$TEST_BIN_NAME 1000 >/dev/null 2>&1 &
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1 &
 done
 
 reg_app_count=0
-while [ $reg_app_count -ne $NR_ITER ]; do
+while [ $reg_app_count -ne $NUM_PROCESS ]; do
 	listing=$($TESTDIR/../src/bin/lttng/$LTTNG_BIN list -u)
-	reg_app_count=$(echo -n $listing | sed "s/$TEST_BIN_NAME/$TEST_BIN_NAME\n/g" | grep "$TEST_BIN_NAME" | wc -l)
+	reg_app_count=$(echo -n $listing | sed "s#$TESTAPP_BIN#$TESTAPP_BIN\n#g" | grep "$TESTAPP_BIN" | wc -l)
 done
 
 pass "Trace validation"
@@ -71,8 +75,8 @@ destroy_lttng_session $SESSION_NAME
 
 rm -rf $TRACE_PATH
 
-while [ -n "$(pidof $TEST_BIN_NAME)" ]; do
-	killall -q $TEST_BIN_NAME >/dev/null 2>&1
+while [ -n "$(pidof $TESTAPP_NAME)" ]; do
+	killall -q $TESTAPP_NAME >/dev/null 2>&1
 	sleep 0.5
 done
 
diff --git a/tests/regression/ust/nprocesses/tp.c b/tests/regression/ust/nprocesses/tp.c
deleted file mode 100644
index 438139e..0000000
--- a/tests/regression/ust/nprocesses/tp.c
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Copyright (c) - 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
-#include "ust_gen_event.h"
diff --git a/tests/regression/ust/nprocesses/ust_gen_event.h b/tests/regression/ust/nprocesses/ust_gen_event.h
deleted file mode 100644
index 5bdcb37..0000000
--- a/tests/regression/ust/nprocesses/ust_gen_event.h
+++ /dev/null
@@ -1,56 +0,0 @@
-#undef TRACEPOINT_PROVIDER
-#define TRACEPOINT_PROVIDER ust_gen_event
-
-#if !defined(_TRACEPOINT_UST_GEN_EVENT_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
-#define _TRACEPOINT_UST_GEN_EVENT_H
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
-TRACEPOINT_EVENT(ust_gen_event, tptest,
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
-#endif /* _TRACEPOINT_UST_GEN_EVENT_H */
-
-#undef TRACEPOINT_INCLUDE_FILE
-#define TRACEPOINT_INCLUDE_FILE ./ust_gen_event.h
-
-/* This part must be outside ifdef protection */
-#include <lttng/tracepoint-event.h>
-
-#ifdef __cplusplus
-}
-#endif
-- 
1.8.2.2
