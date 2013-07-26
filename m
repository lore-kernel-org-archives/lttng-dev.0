From: Zifei Tong <soariez@gmail.com>
Subject: [PATCH v2 2/3] Update obsolete benchmark test
Date: Fri, 26 Jul 2013 22:38:23 +0800
Message-ID: <1374849503-5492-1-git-send-email-soariez__22282.0630683147$1374849706$gmane$org@gmail.com>
References: <20130724161758.GB20539@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1V2jBt-0006dp-5m
	for lttng-dev@lists.lttng.org; Fri, 26 Jul 2013 10:40:25 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so3346091pab.17
	for <lttng-dev@lists.lttng.org>; Fri, 26 Jul 2013 07:40:15 -0700 (PDT)
In-Reply-To: <20130724161758.GB20539@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Update the test to use lttng-ust 2.x API and output result to TAP format.

Signed-off-by: Zifei Tong <soariez@gmail.com>
---
 configure.ac                          |  1 +
 tests/Makefile.am                     |  2 +-
 tests/benchmark/Makefile              | 14 -----
 tests/benchmark/Makefile.am           | 19 +++++++
 tests/benchmark/README                | 11 ++--
 tests/benchmark/average               | 18 -------
 tests/benchmark/bench.c               | 10 ++--
 tests/benchmark/install               | 15 ------
 tests/benchmark/ptime                 | 12 ++---
 tests/benchmark/run                   | 97 -----------------------------------
 tests/benchmark/test_benchmark        | 42 +++++++++++++++
 tests/benchmark/tp.c                  |  2 +
 tests/benchmark/ust_tests_benchmark.h | 30 +++++++++++
 13 files changed, 113 insertions(+), 160 deletions(-)
 delete mode 100644 tests/benchmark/Makefile
 create mode 100644 tests/benchmark/Makefile.am
 delete mode 100755 tests/benchmark/average
 delete mode 100755 tests/benchmark/install
 delete mode 100755 tests/benchmark/run
 create mode 100755 tests/benchmark/test_benchmark
 create mode 100644 tests/benchmark/tp.c
 create mode 100644 tests/benchmark/ust_tests_benchmark.h

diff --git a/configure.ac b/configure.ac
index 8b862ed..a59e8ce 100644
--- a/configure.ac
+++ b/configure.ac
@@ -283,6 +283,7 @@ AC_CONFIG_FILES([
 	tests/hello.cxx/Makefile
 	tests/same_line_tracepoint/Makefile
 	tests/snprintf/Makefile
+	tests/benchmark/Makefile
 	tests/utils/Makefile
 	lttng-ust.pc
 ])
diff --git a/tests/Makefile.am b/tests/Makefile.am
index d472a6a..d9a7a30 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -1,4 +1,4 @@
-SUBDIRS = utils hello same_line_tracepoint snprintf
+SUBDIRS = utils hello same_line_tracepoint snprintf benchmark
 
 if CXX_WORKS
 SUBDIRS += hello.cxx
diff --git a/tests/benchmark/Makefile b/tests/benchmark/Makefile
deleted file mode 100644
index cfccda9..0000000
--- a/tests/benchmark/Makefile
+++ /dev/null
@@ -1,14 +0,0 @@
-CC=gcc
-CFLAGS=-O3 -Wall
-LFLAGS=-lpthread -lust
-
-all: bench1 bench2
-
-bench1: bench.c
-	$(CC) $(CFLAGS) $(LFLAGS) -o bench1 bench.c
-bench2: bench.c
-	$(CC) $(CFLAGS) $(LFLAGS) -DMARKER -o bench2 bench.c
-
-
-clean:
-	rm -f *.o bench1 bench2
diff --git a/tests/benchmark/Makefile.am b/tests/benchmark/Makefile.am
new file mode 100644
index 0000000..99eafef
--- /dev/null
+++ b/tests/benchmark/Makefile.am
@@ -0,0 +1,19 @@
+AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include -Wsystem-headers
+
+noinst_PROGRAMS = bench1 bench2
+bench1_SOURCES = bench.c tp.c ust_tests_benchmark.h
+bench1_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
+bench2_SOURCES = bench.c tp.c ust_tests_benchmark.h
+bench2_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
+bench2_CFLAGS = -DTRACING
+
+dist_noinst_SCRIPTS = test_benchmark ptime README
+
+if LTTNG_UST_BUILD_WITH_LIBDL
+bench1_LDADD += -ldl
+bench2_LDADD += -ldl
+endif
+if LTTNG_UST_BUILD_WITH_LIBC_DL
+bench1_LDADD += -lc
+bench2_LDADD += -lc
+endif
diff --git a/tests/benchmark/README b/tests/benchmark/README
index 8a9321d..c8e3305 100644
--- a/tests/benchmark/README
+++ b/tests/benchmark/README
@@ -1,9 +1,8 @@
-UST Benchmark
+To run the benchmark:
 
-INSTALLATION INSTRUCTIONS:
+    ./test_benchmark
 
-  - run ./install  to install and compile UST/benchmark
-  - run ./run  to perform the benchmark
+You can specify the number of iterations, events and threads by setting
+environment variables ITERS, NR_EVENTS, NR_CPUS respectively:
 
-
-The trace files will be automatically saved at $HOME/.usttraces
+    ITERS=10 NR_EVENTS=10000 NR_CPUS=4 ./test_benchmark
diff --git a/tests/benchmark/average b/tests/benchmark/average
deleted file mode 100755
index bda898c..0000000
--- a/tests/benchmark/average
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/usr/bin/python
-
-import sys
-
-def main():
-	total = 0.0
-	n = 0.0
-	while 1:
-		line = sys.stdin.readline()
-		if not line:
-			break
-
-		val = float(line)
-		n = n+1.0
-		total = total+val
-
-	print total/n
-main()
diff --git a/tests/benchmark/bench.c b/tests/benchmark/bench.c
index 212baef..517bfb7 100644
--- a/tests/benchmark/bench.c
+++ b/tests/benchmark/bench.c
@@ -26,9 +26,13 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <sched.h>
-#include <ust/marker.h>
 #include <time.h>
 
+#ifdef TRACING
+#define TRACEPOINT_DEFINE
+#include "ust_tests_benchmark.h"
+#endif
+
 static int nr_cpus;
 static unsigned long nr_events;
 
@@ -44,8 +48,8 @@ void do_stuff(void)
 	fclose(file);
 	time(NULL);
 
-#ifdef MARKER
-	ust_marker(event, "event %d", v);
+#ifdef TRACING
+	tracepoint(ust_tests_benchmark, tpbench, v);
 #endif
 
 }
diff --git a/tests/benchmark/install b/tests/benchmark/install
deleted file mode 100755
index a66405d..0000000
--- a/tests/benchmark/install
+++ /dev/null
@@ -1,15 +0,0 @@
-#!/bin/bash
-#
-# install ust
-
-# compile and install UST
-cd ../../
-make clean
-CFLAGS=-O3 ./configure
-make
-sudo make install
-sudo ldconfig
-
-# compile benchmark
-cd tests/benchmark
-make clean && make
diff --git a/tests/benchmark/ptime b/tests/benchmark/ptime
index 8e22c02..419f368 100755
--- a/tests/benchmark/ptime
+++ b/tests/benchmark/ptime
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python
 
 import sys
 import time
@@ -7,16 +7,16 @@ import os
 def main():
 	args = sys.argv[1:]
 	if len(args) < 1:
-		print "usage: %s COMMAND" % sys.argv[0]
+		print("usage: %s COMMAND" % sys.argv[0])
 		sys.exit(1)
 
-	cmd = args[0]
+	cmd = ' '.join(args)
 
 	t1 = time.time()
 	os.system(cmd)
-	1
 	t2 = time.time()
 
-	print (t2-t1)
+	print(t2-t1)
 
-main()
+if __name__ == "__main__":
+	main()
diff --git a/tests/benchmark/run b/tests/benchmark/run
deleted file mode 100755
index 7fa580c..0000000
--- a/tests/benchmark/run
+++ /dev/null
@@ -1,97 +0,0 @@
-#!/bin/bash
-#
-# run ust benchmark
-#
-
-iters=20
-NR_EVENTS=7000000
-NR_CPUS=1
-
-TIME="./ptime"
-
-#PROG_NOMARKER="find /usr"
-PROG_NOMARKER="./bench1 $NR_CPUS $NR_EVENTS"
-#PROG_MARKER=$PROG_NOMARKER
-PROG_MARKER="./bench2 $NR_CPUS $NR_EVENTS"
-
-CMD_NOMARKER="$TIME '$PROG_NOMARKER >/dev/null 2>&1'"
-CMD_MARKER="$TIME '$PROG_MARKER >/dev/null 2>&1'"
-CMD_MARKERCONN="UST_AUTOPROBE=1 $TIME '$PROG_MARKER >/dev/null 2>&1'"
-CMD_MARKERTRACE="UST_TRACE=1 UST_AUTOPROBE=1 UST_OVERWRITE=1 UST_AUTOCOLLECT=0 $TIME '$PROG_MARKER >/dev/null 2>&1'"
-
-echo "ust benchmark"
-
-rm -f result-*.txt average-*.txt perevent-*.txt
-
-echo "using $NR_CPUS processor(s)"
-echo "using $NR_EVENTS events per cpu"
-
-n=0
-while [ $n -lt "$iters" ]; do
-	# without markers
-	echo ">running without markers"
-	echo 3 >/proc/sys/vm/drop_caches
-	t1=$(sh -c "$CMD_NOMARKER")
-	echo "$t1" >>result-nomark.txt
-	echo " time=$t1 sec"
-	n=$(($n+1))
-done
-./average <result-nomark.txt >average-nomark.txt
-
-## with markers, not connected
-#n=0
-#while [ $n -lt "$iters" ]; do
-#	echo ">running with markers, not connected"
-#	echo 3 >/proc/sys/vm/drop_caches
-#	t2=$(sh -c "$CMD_MARKER")
-#	echo "$t2" >>result-mark.txt
-#	echo " time=$t2 sec"
-#	n=$(($n+1))
-#done
-#./average <result-mark.txt >average-mark.txt
-#echo "( $(<average-mark.txt) - $(<average-nomark.txt) ) / $NR_EVENTS" | bc -l >perevent-mark.txt
-
-## with markers, connected
-#n=0
-#while [ $n -lt "$iters" ]; do
-#	echo ">running with markers activated"
-#	echo 3 >/proc/sys/vm/drop_caches
-#	t2=$(sh -c "$CMD_MARKERCONN")
-#	echo "$t2" >>result-markconn.txt
-#	echo " time=$t2 sec"
-#	n=$(($n+1))
-#done
-#./average <result-markconn.txt >average-markconn.txt
-#echo "( $(<average-markconn.txt) - $(<average-nomark.txt) ) / $NR_EVENTS" | bc -l >perevent-markconn.txt
-
-# with markers, connected, tracing
-n=0
-while [ $n -lt "$iters" ]; do
-	echo ">running with markers activated, trace recording"
-	echo 3 >/proc/sys/vm/drop_caches
-	t3=$(sh -c "$CMD_MARKERTRACE")
-	echo "$t3" >>result-marktrace.txt
-	echo " time=$t3 sec"
-	n=$(($n+1))
-done
-./average <result-marktrace.txt >average-marktrace.txt
-echo "( $(<average-marktrace.txt) - $(<average-nomark.txt) ) / $NR_EVENTS" | bc -l >perevent-marktrace.txt
-
-function print_penalty()
-{
-	echo ""
-
-	#penalty = t2 - t1
-	penalty=$(echo "$2 - $1;" | bc)
-	echo "Penalty ($3) = $penalty sec"
-
-	#event = penalty / (nr_events * nr_cpus)
-	event=$(echo "scale=10; ($penalty / ($NR_EVENTS * $NR_CPUS));" | bc)
-	echo "Penalty per event ($3) = $event sec"
-}
-
-#print_penalty $t1 $t2 "Penalty for markers enabled, not tracing"
-#print_penalty $t1 $t3 "Penalty for markers enabled, tracing"
-
-
-rm -f /tmp/bench.txt
diff --git a/tests/benchmark/test_benchmark b/tests/benchmark/test_benchmark
new file mode 100755
index 0000000..c55e302
--- /dev/null
+++ b/tests/benchmark/test_benchmark
@@ -0,0 +1,42 @@
+#!/bin/bash
+
+CURDIR=$(dirname $0)/
+TESTDIR=$CURDIR/..
+source $TESTDIR/utils/tap.sh
+
+plan_tests 1
+
+: ${ITERS:=20}
+: ${NR_EVENTS:=7000000}
+: ${NR_CPUS:=1}
+
+: ${TIME:="./$CURDIR/ptime"}
+
+: ${PROG_NOTRACING:="./$CURDIR/bench1 $NR_CPUS $NR_EVENTS"}
+: ${PROG_TRACING:="./$CURDIR/bench2 $NR_CPUS $NR_EVENTS"}
+
+CMD_NOTRACING="$TIME '$PROG_NOTRACING >/dev/null 2>&1'"
+CMD_TRACING="$TIME '$PROG_TRACING >/dev/null 2>&1'"
+
+time_notrace=0
+for i in $(seq $ITERS); do
+	echo 3 >/proc/sys/vm/drop_caches
+	time_notrace="$time_notrace+$(sh -c "$CMD_NOTRACING")"
+done
+
+lttng-sessiond -d --no-kernel
+lttng -q create
+lttng -q enable-event -u -a
+lttng -q start
+
+time_trace=0
+for i in $(seq $ITERS); do
+	echo 3 >/proc/sys/vm/drop_caches
+	time_trace="$time_trace+$(sh -c "$CMD_TRACING")"
+done
+
+lttng -q stop
+lttng -q destroy
+
+pass "Trace benchmark"
+diag "Average tracing overhead per event is $(echo "scale=6;( ($time_trace) - ($time_notrace) ) / $ITERS / $NR_EVENTS" | bc -l)s"
diff --git a/tests/benchmark/tp.c b/tests/benchmark/tp.c
new file mode 100644
index 0000000..a4f5352
--- /dev/null
+++ b/tests/benchmark/tp.c
@@ -0,0 +1,2 @@
+#define TRACEPOINT_CREATE_PROBES
+#include "ust_tests_benchmark.h"
diff --git a/tests/benchmark/ust_tests_benchmark.h b/tests/benchmark/ust_tests_benchmark.h
new file mode 100644
index 0000000..0ee986f
--- /dev/null
+++ b/tests/benchmark/ust_tests_benchmark.h
@@ -0,0 +1,30 @@
+#undef TRACEPOINT_PROVIDER
+#define TRACEPOINT_PROVIDER ust_tests_benchmark
+
+#if !defined(_TRACEPOINT_UST_TESTS_BENCHMARK_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
+#define _TRACEPOINT_UST_TESTS_BENCHMARK_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <lttng/tracepoint.h>
+
+TRACEPOINT_EVENT(ust_tests_benchmark, tpbench,
+	TP_ARGS(int, value),
+	TP_FIELDS(
+		ctf_integer(int, event, value)
+	)
+)
+
+#endif /* _TRACEPOINT_UST_TESTS_BENCHMARK_H */
+
+#undef TRACEPOINT_INCLUDE
+#define TRACEPOINT_INCLUDE "./ust_tests_benchmark.h"
+
+/* This part must be outside ifdef protection */
+#include <lttng/tracepoint-event.h>
+
+#ifdef __cplusplus
+}
+#endif
-- 
1.8.3.3
