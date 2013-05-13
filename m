From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 4/6] Tests: Replace usage of
	gen-ust-events testapp in ust buffers-uid test
Date: Mon, 13 May 2013 18:30:54 -0400
Message-ID: <1368484256-6666-4-git-send-email-christian.babeux__23935.6790007607$1368484329$gmane$org@efficios.com>
References: <1368484256-6666-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Uc1HP-0002WR-43
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 18:31:39 -0400
Received: by mail-vc0-f172.google.com with SMTP id m17so6042680vca.3
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 15:31:33 -0700 (PDT)
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
 tests/regression/ust/buffers-uid/Makefile.am       | 14 ------
 tests/regression/ust/buffers-uid/gen-nevents.c     | 56 ----------------------
 tests/regression/ust/buffers-uid/test_buffers_uid  | 24 ++++++----
 tests/regression/ust/buffers-uid/tp.c              | 16 -------
 tests/regression/ust/buffers-uid/ust_gen_nevents.h | 56 ----------------------
 5 files changed, 14 insertions(+), 152 deletions(-)
 delete mode 100644 tests/regression/ust/buffers-uid/gen-nevents.c
 delete mode 100644 tests/regression/ust/buffers-uid/tp.c
 delete mode 100644 tests/regression/ust/buffers-uid/ust_gen_nevents.h

diff --git a/tests/regression/ust/buffers-uid/Makefile.am b/tests/regression/ust/buffers-uid/Makefile.am
index 31fb019..4fefd80 100644
--- a/tests/regression/ust/buffers-uid/Makefile.am
+++ b/tests/regression/ust/buffers-uid/Makefile.am
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
-noinst_PROGRAMS = gen-nevents
-gen_nevents_SOURCES = gen-nevents.c tp.c ust_gen_nevents.h
-gen_nevents_LDADD = -llttng-ust
-
 noinst_SCRIPTS = test_buffers_uid
 EXTRA_DIST = test_buffers_uid
diff --git a/tests/regression/ust/buffers-uid/gen-nevents.c b/tests/regression/ust/buffers-uid/gen-nevents.c
deleted file mode 100644
index b2c1992..0000000
--- a/tests/regression/ust/buffers-uid/gen-nevents.c
+++ /dev/null
@@ -1,56 +0,0 @@
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
-#include "ust_gen_nevents.h"
-
-int main(int argc, char **argv)
-{
-	int i, netint;
-	long values[] = { 1, 2, 3 };
-	char text[10] = "test";
-	double dbl = 2.0;
-	float flt = 2222.0;
-	unsigned int nr_iter = 100;
-
-	if (argc == 2) {
-		nr_iter = atoi(argv[1]);
-	}
-
-	for (i = 0; i < nr_iter; i++) {
-		netint = htonl(i);
-		tracepoint(ust_gen_nevents, tptest, i, netint, values, text,
-				strlen(text), dbl, flt);
-		usleep(100000);
-	}
-
-	return 0;
-}
diff --git a/tests/regression/ust/buffers-uid/test_buffers_uid b/tests/regression/ust/buffers-uid/test_buffers_uid
index 3b5c7a6..6af675c 100755
--- a/tests/regression/ust/buffers-uid/test_buffers_uid
+++ b/tests/regression/ust/buffers-uid/test_buffers_uid
@@ -19,15 +19,19 @@ TEST_DESC="UST tracer - Tracing with per UID buffers"
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../../..
 NR_ITER=100
+NR_USEC_WAIT=100000
 SESSION_NAME="buffers-uid"
-EVENT_NAME="ust_gen_nevents:tptest"
-BIN_NAME="gen-nevents"
+
+TESTAPP_PATH="$TESTDIR/utils/testapp"
+TESTAPP_NAME="gen-ust-events"
+TESTAPP_BIN="$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
+EVENT_NAME="tp:tptest"
 NUM_TESTS=58
 
 source $TESTDIR/utils/utils.sh
 
-if [ ! -x "$CURDIR/gen-nevents" ]; then
-	BAIL_OUT "No UST nevents binary detected."
+if [ ! -x "$TESTAPP_BIN" ]; then
+	BAIL_OUT "No UST events binary detected."
 fi
 
 # MUST set TESTDIR before calling those functions
@@ -44,7 +48,7 @@ function enable_channel_per_uid()
 function wait_apps
 {
 	diag "Waiting for applications to end..."
-	while [ -n "$(pidof $BIN_NAME)" ]; do
+	while [ -n "$(pidof $TESTAPP_NAME)" ]; do
 		sleep 1
 	done
 }
@@ -62,7 +66,7 @@ test_after_multiple_apps() {
 	start_lttng_tracing $SESSION_NAME
 
 	for i in `seq 1 5`; do
-		./$CURDIR/$BIN_NAME $NR_ITER & >/dev/null 2>&1
+		$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT & >/dev/null 2>&1
 		ok $? "Start application $i for tracing"
 	done
 	wait_apps
@@ -82,7 +86,7 @@ test_before_multiple_apps() {
 	diag "Start multiple applications BEFORE tracing is started"
 
 	for i in `seq 1 5`; do
-		./$CURDIR/$BIN_NAME $NR_ITER & >/dev/null 2>&1
+		$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT & >/dev/null 2>&1
 		ok $? "Start application $i for tracing"
 	done
 
@@ -125,7 +129,7 @@ test_after_app() {
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
 	start_lttng_tracing $SESSION_NAME
 
-	./$CURDIR/$BIN_NAME $NR_ITER
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT
 	ok $? "Start application to trace"
 
 	stop_lttng_tracing $SESSION_NAME
@@ -141,7 +145,7 @@ test_before_app() {
 
 	diag "Start application BEFORE tracing is started"
 
-	./$CURDIR/$BIN_NAME $NR_ITER &
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT &
 	ok $? "Start application to trace"
 
 	# BEFORE application is spawned
@@ -197,7 +201,7 @@ test_multiple_channels() {
 	ok $? "Enable event $EVENT_NAME for session $SESSION_NAME in channel4"
 	start_lttng_tracing $SESSION_NAME
 
-	./$CURDIR/$BIN_NAME $NR_ITER
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT
 	ok $? "Start application to trace"
 
 	stop_lttng_tracing $SESSION_NAME
diff --git a/tests/regression/ust/buffers-uid/tp.c b/tests/regression/ust/buffers-uid/tp.c
deleted file mode 100644
index e291924..0000000
--- a/tests/regression/ust/buffers-uid/tp.c
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
-#include "ust_gen_nevents.h"
diff --git a/tests/regression/ust/buffers-uid/ust_gen_nevents.h b/tests/regression/ust/buffers-uid/ust_gen_nevents.h
deleted file mode 100644
index bc09c44..0000000
--- a/tests/regression/ust/buffers-uid/ust_gen_nevents.h
+++ /dev/null
@@ -1,56 +0,0 @@
-#undef TRACEPOINT_PROVIDER
-#define TRACEPOINT_PROVIDER ust_gen_nevents
-
-#if !defined(_TRACEPOINT_UST_GEN_NEVENTS_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
-#define _TRACEPOINT_UST_GEN_NEVENTS_H
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
-TRACEPOINT_EVENT(ust_gen_nevents, tptest,
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
-#endif /* _TRACEPOINT_UST_GEN_NEVENTS_H */
-
-#undef TRACEPOINT_INCLUDE_FILE
-#define TRACEPOINT_INCLUDE_FILE ./ust_gen_nevents.h
-
-/* This part must be outside ifdef protection */
-#include <lttng/tracepoint-event.h>
-
-#ifdef __cplusplus
-}
-#endif
-- 
1.8.2.2
