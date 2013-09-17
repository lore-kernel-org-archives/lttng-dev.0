From: Stefan Seefeld <stefan@seefeld.name>
Subject: [PATCH] Robustify tests.
Date: Tue, 17 Sep 2013 15:19:45 -0400
Message-ID: <1379445585-21203-1-git-send-email-stefan_seefeld__38301.8376109705$1379445673$gmane$org@mentor.com>
References: <52389381.20500@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stefan.seefeld@gmail.com>) id 1VM0od-0005Dk-4Q
	for lttng-dev@lists.lttng.org; Tue, 17 Sep 2013 15:20:11 -0400
Received: by mail-qc0-f169.google.com with SMTP id c9so4002716qcz.28
	for <lttng-dev@lists.lttng.org>; Tue, 17 Sep 2013 12:19:57 -0700 (PDT)
In-Reply-To: <52389381.20500@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Stefan Seefeld <stefan_seefeld@mentor.com>
---
 tests/Makefile.am                                  |  6 ++
 .../regression/tools/filtering/test_invalid_filter |  3 +-
 .../regression/tools/filtering/test_unsupported_op |  3 +-
 tests/regression/tools/filtering/test_valid_filter |  3 +-
 tests/regression/tools/health/test_thread_exit     |  1 -
 tests/regression/tools/health/test_thread_stall    |  1 -
 .../tools/snapshots/test_kernel_streaming          |  2 +-
 tests/regression/tools/snapshots/test_ust          |  2 +-
 .../regression/tools/snapshots/test_ust_streaming  |  2 +-
 .../tools/streaming/test_high_throughput_limits    |  2 +-
 tests/regression/tools/streaming/test_kernel       |  2 +-
 tests/regression/tools/streaming/test_ust          |  2 +-
 .../tools/tracefile-limits/test_tracefile_count    |  4 +-
 .../tools/tracefile-limits/test_tracefile_size     |  4 +-
 tests/regression/ust/buffers-pid/test_buffers_pid  | 12 +--
 tests/regression/ust/daemon/test_daemon            |  4 +-
 tests/regression/ust/exit-fast/test_exit-fast      |  4 +-
 tests/regression/ust/fork/test_fork                |  4 +-
 .../regression/ust/libc-wrapper/test_libc-wrapper  |  4 +-
 tests/regression/ust/linking/test_linking          |  4 +-
 tests/regression/ust/nprocesses/test_nprocesses    |  2 +-
 tests/regression/ust/overlap/test_overlap          |  2 +-
 .../test_periodical_metadata_flush                 |  8 +-
 tests/regression/ust/test_event_basic              |  7 +-
 tests/regression/ust/test_event_wildcard           |  1 -
 tests/utils/utils.sh                               | 85 ++++++++++++----------
 26 files changed, 87 insertions(+), 87 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index c14e733..5656eb1 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -1,5 +1,10 @@
 SUBDIRS = utils regression unit stress
 
+bindir := $(top_builddir)/src/bin
+local_path := $(bindir)/lttng:$(bindir)/lttng-consumerd:$(bindir)/lttng-relayd
+
+installcheck-am: export PATH := "$(prefix)/bin:$(PATH)"
+installcheck-am: export installcheck := 1
 installcheck-am:
 	./run.sh unit_tests
 	./run.sh fast_regression
@@ -7,6 +12,7 @@ if USE_PYTHON
 	./run.sh with_bindings_regression
 endif
 
+check-am: export PATH := "$(local_path):$(PATH)"
 check-am:
 	./run.sh unit_tests
 	./run.sh fast_regression
diff --git a/tests/regression/tools/filtering/test_invalid_filter b/tests/regression/tools/filtering/test_invalid_filter
index 5e096a5..891c7c1 100755
--- a/tests/regression/tools/filtering/test_invalid_filter
+++ b/tests/regression/tools/filtering/test_invalid_filter
@@ -19,7 +19,6 @@ TEST_DESC="Filtering - Invalid filters"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../../..
-LTTNG_BIN="lttng"
 SESSION_NAME="filter-invalid"
 EVENT_NAME="bogus"
 ENABLE_EVENT_STDERR="/tmp/invalid-filters-stderr"
@@ -34,7 +33,7 @@ function enable_ust_lttng_event_filter
 	event_name="$2"
 	filter="$3"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $event_name -s $sess_name -u --filter "$filter" 2> $ENABLE_EVENT_STDERR 1> /dev/null
+	lttng enable-event $event_name -s $sess_name -u --filter "$filter" 2> $ENABLE_EVENT_STDERR 1> /dev/null
 
 	# Enable must fail
 	if [ $? -eq 0 ]; then
diff --git a/tests/regression/tools/filtering/test_unsupported_op b/tests/regression/tools/filtering/test_unsupported_op
index b5b7f27..bc9bd51 100755
--- a/tests/regression/tools/filtering/test_unsupported_op
+++ b/tests/regression/tools/filtering/test_unsupported_op
@@ -19,7 +19,6 @@ TEST_DESC="Filtering - Unsupported operators"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../../..
-LTTNG_BIN="lttng"
 SESSION_NAME="filter-unsupported-ops"
 EVENT_NAME="bogus"
 ENABLE_EVENT_STDERR="/tmp/unsupported-ops-enable"
@@ -33,7 +32,7 @@ function enable_ust_lttng_event_filter_unsupported
 	event_name=$2
 	filter=$3
 
-	enable_cmd="$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event"
+	enable_cmd="lttng enable-event"
 	$enable_cmd $event_name -s $sess_name -u --filter "$filter" 2> $ENABLE_EVENT_STDERR 1> /dev/null
 
 	# Enable must fail
diff --git a/tests/regression/tools/filtering/test_valid_filter b/tests/regression/tools/filtering/test_valid_filter
index a62cc1e..ef6a013 100755
--- a/tests/regression/tools/filtering/test_valid_filter
+++ b/tests/regression/tools/filtering/test_valid_filter
@@ -19,7 +19,6 @@ TEST_DESC="Filtering - Valid filters"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../../..
-LTTNG_BIN="lttng"
 BIN_NAME="gen-ust-events"
 STATS_BIN="$TESTDIR/utils/babelstats.pl"
 SESSION_NAME="valid_filter"
@@ -39,7 +38,7 @@ function enable_ust_lttng_event_filter()
 	event_name="$2"
 	filter="$3"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $event_name -s $sess_name -u --filter "$filter" 2>&1 >/dev/null
+	lttng enable-event $event_name -s $sess_name -u --filter "$filter" 2>&1 >/dev/null
 
 	ok $? "Enable lttng event with filtering"
 }
diff --git a/tests/regression/tools/health/test_thread_exit b/tests/regression/tools/health/test_thread_exit
index b4fc73d..35fe42e 100755
--- a/tests/regression/tools/health/test_thread_exit
+++ b/tests/regression/tools/health/test_thread_exit
@@ -19,7 +19,6 @@ TEST_DESC="Health check - Thread exit"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../../..
-LTTNG_BIN="lttng"
 SESSION_NAME="health_thread_exit"
 EVENT_NAME="bogus"
 HEALTH_CHECK_BIN="health_check"
diff --git a/tests/regression/tools/health/test_thread_stall b/tests/regression/tools/health/test_thread_stall
index ddaab95..9055499 100755
--- a/tests/regression/tools/health/test_thread_stall
+++ b/tests/regression/tools/health/test_thread_stall
@@ -19,7 +19,6 @@ TEST_DESC="Health check - Thread stall"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../../..
-LTTNG_BIN="lttng"
 SESSION_NAME="health_thread_stall"
 EVENT_NAME="bogus"
 HEALTH_CHECK_BIN="health_check"
diff --git a/tests/regression/tools/snapshots/test_kernel_streaming b/tests/regression/tools/snapshots/test_kernel_streaming
index f28adaa..fc170a4 100755
--- a/tests/regression/tools/snapshots/test_kernel_streaming
+++ b/tests/regression/tools/snapshots/test_kernel_streaming
@@ -46,7 +46,7 @@ function snapshot_add_output ()
 		extra_opt="-n $name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot add-output -s $sess_name $extra_opt $trace_path >/dev/null 2>&1
+	lttng snapshot add-output -s $sess_name $extra_opt $trace_path >/dev/null 2>&1
 	ok $? "Added snapshot output $trace_path"
 }
 
diff --git a/tests/regression/tools/snapshots/test_ust b/tests/regression/tools/snapshots/test_ust
index c88e98a..8d01b33 100755
--- a/tests/regression/tools/snapshots/test_ust
+++ b/tests/regression/tools/snapshots/test_ust
@@ -99,7 +99,7 @@ function enable_channel_per_uid_mmap_overwrite()
 	sess_name=$1
 	channel_name=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel --buffers-uid -u $channel_name -s $sess_name --output mmap --overwrite >/dev/null 2>&1
+	lttng enable-channel --buffers-uid -u $channel_name -s $sess_name --output mmap --overwrite >/dev/null 2>&1
 	ok $? "Enable channel $channel_name per UID for session $sess_name"
 }
 
diff --git a/tests/regression/tools/snapshots/test_ust_streaming b/tests/regression/tools/snapshots/test_ust_streaming
index 3aa3858..c3a9e57 100755
--- a/tests/regression/tools/snapshots/test_ust_streaming
+++ b/tests/regression/tools/snapshots/test_ust_streaming
@@ -50,7 +50,7 @@ function snapshot_add_output ()
 		extra_opt="-n $name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot add-output -s $sess_name $extra_opt $trace_path >/dev/null 2>&1
+	lttng snapshot add-output -s $sess_name $extra_opt $trace_path >/dev/null 2>&1
 	ok $? "Added snapshot output $trace_path"
 }
 
diff --git a/tests/regression/tools/streaming/test_high_throughput_limits b/tests/regression/tools/streaming/test_high_throughput_limits
index b2c8864..671481f 100755
--- a/tests/regression/tools/streaming/test_high_throughput_limits
+++ b/tests/regression/tools/streaming/test_high_throughput_limits
@@ -80,7 +80,7 @@ function create_lttng_session_with_uri
 	sess_name=$1
 	uri=$2
 	# Create session with custom URI
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN create -U $uri $sess_name >/dev/null 2>&1
+	lttng create -U $uri $sess_name >/dev/null 2>&1
 	ok $? "Create session with uri $uri"
 }
 
diff --git a/tests/regression/tools/streaming/test_kernel b/tests/regression/tools/streaming/test_kernel
index 9877bb8..dd20ed7 100755
--- a/tests/regression/tools/streaming/test_kernel
+++ b/tests/regression/tools/streaming/test_kernel
@@ -37,7 +37,7 @@ fi
 function lttng_create_session_uri
 {
 	# Create session with default path
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN create $SESSION_NAME -U net://localhost >/dev/null 2>&1
+	lttng create $SESSION_NAME -U net://localhost >/dev/null 2>&1
 
 	ok $? "Create session $SESSION_NAME"
 }
diff --git a/tests/regression/tools/streaming/test_ust b/tests/regression/tools/streaming/test_ust
index 785a9a8..d87061d 100755
--- a/tests/regression/tools/streaming/test_ust
+++ b/tests/regression/tools/streaming/test_ust
@@ -40,7 +40,7 @@ fi
 function lttng_create_session_uri
 {
 	# Create session with default path
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN create $SESSION_NAME -U net://localhost >/dev/null 2>&1
+	lttng create $SESSION_NAME -U net://localhost >/dev/null 2>&1
 	ok $? "Create session with default path"
 }
 
diff --git a/tests/regression/tools/tracefile-limits/test_tracefile_count b/tests/regression/tools/tracefile-limits/test_tracefile_count
index 0c23d84..f905a7b 100755
--- a/tests/regression/tools/tracefile-limits/test_tracefile_count
+++ b/tests/regression/tools/tracefile-limits/test_tracefile_count
@@ -53,7 +53,7 @@ function enable_lttng_channel_count_limit ()
 	test_name+="for session $sess_name: "
 	test_name+="$tracefile_count_limit tracefiles"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel \
+	lttng enable-channel \
 	    -u $channel_name -s $sess_name \
 	    -C 4096 -W $tracefile_count_limit \
 	    --overwrite >/dev/null 2>&1
@@ -71,7 +71,7 @@ function enable_ust_lttng_event_per_channel ()
 	test_name+="for session $sess_name "
 	test_name+="in channel $channel_name"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" \
+	lttng enable-event "$event_name" \
 	    -s $sess_name -u -c $channel_name >/dev/null 2>&1
 
 	ok $? "$test_name"
diff --git a/tests/regression/tools/tracefile-limits/test_tracefile_size b/tests/regression/tools/tracefile-limits/test_tracefile_size
index ed58e70..bd87471 100755
--- a/tests/regression/tools/tracefile-limits/test_tracefile_size
+++ b/tests/regression/tools/tracefile-limits/test_tracefile_size
@@ -52,7 +52,7 @@ function enable_lttng_channel_size_limit ()
 	test_name+="for session $sess_name: "
 	test_name+="$tracefile_size_limit bytes tracefile limit"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel \
+	lttng enable-channel \
 	    -u $channel_name -s $sess_name --buffers-pid \
 	    -C $tracefile_size_limit >/dev/null 2>&1
 
@@ -69,7 +69,7 @@ function enable_ust_lttng_event_per_channel ()
 	test_name+="for session $sess_name "
 	test_name+="in channel $channel_name"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" \
+	lttng enable-event "$event_name" \
 	    -s $sess_name -u -c $channel_name >/dev/null 2>&1
 
 	ok $? "$test_name"
diff --git a/tests/regression/ust/buffers-pid/test_buffers_pid b/tests/regression/ust/buffers-pid/test_buffers_pid
index 2d227bf..27b7a02 100755
--- a/tests/regression/ust/buffers-pid/test_buffers_pid
+++ b/tests/regression/ust/buffers-pid/test_buffers_pid
@@ -41,7 +41,7 @@ function enable_channel_per_pid()
 	sess_name=$1
 	channel_name=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel --buffers-pid -u $channel_name -s $sess_name >/dev/null 2>&1
+	lttng enable-channel --buffers-pid -u $channel_name -s $sess_name >/dev/null 2>&1
 	ok $? "Enable channel $channel_name per PID for session $sess_name"
 }
 
@@ -189,15 +189,15 @@ test_multiple_channels() {
 	enable_channel_per_pid $SESSION_NAME "channel3"
 	enable_channel_per_pid $SESSION_NAME "channel4"
 	# Enable event in all channels.
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $EVENT_NAME -c channel0 -s $SESSION_NAME -u >/dev/null 2>&1
+	lttng enable-event $EVENT_NAME -c channel0 -s $SESSION_NAME -u >/dev/null 2>&1
 	ok $? "Enable event $EVENT_NAME for session $SESSION_NAME in channel0"
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $EVENT_NAME -c channel1 -s $SESSION_NAME -u >/dev/null 2>&1
+	lttng enable-event $EVENT_NAME -c channel1 -s $SESSION_NAME -u >/dev/null 2>&1
 	ok $? "Enable event $EVENT_NAME for session $SESSION_NAME in channel1"
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $EVENT_NAME -c channel2 -s $SESSION_NAME -u >/dev/null 2>&1
+	lttng enable-event $EVENT_NAME -c channel2 -s $SESSION_NAME -u >/dev/null 2>&1
 	ok $? "Enable event $EVENT_NAME for session $SESSION_NAME in channel2"
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $EVENT_NAME -c channel3 -s $SESSION_NAME -u >/dev/null 2>&1
+	lttng enable-event $EVENT_NAME -c channel3 -s $SESSION_NAME -u >/dev/null 2>&1
 	ok $? "Enable event $EVENT_NAME for session $SESSION_NAME in channel3"
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $EVENT_NAME -c channel4 -s $SESSION_NAME -u >/dev/null 2>&1
+	lttng enable-event $EVENT_NAME -c channel4 -s $SESSION_NAME -u >/dev/null 2>&1
 	ok $? "Enable event $EVENT_NAME for session $SESSION_NAME in channel4"
 	start_lttng_tracing $SESSION_NAME
 
diff --git a/tests/regression/ust/daemon/test_daemon b/tests/regression/ust/daemon/test_daemon
index 54afd0c..bfd9dc7 100755
--- a/tests/regression/ust/daemon/test_daemon
+++ b/tests/regression/ust/daemon/test_daemon
@@ -20,12 +20,10 @@
 STOP_SESSIOND=$?
 
 CURDIR=$(dirname $0)
-TESTDIR=${CURDIR}/../../..
 
 # Try to launch a sessiond before invoking the python test script
 if [ $STOP_SESSIOND -ne 0 ]; then
-	DIR=$(readlink -f ${TESTDIR})
-	${DIR}/../src/bin/lttng-sessiond/lttng-sessiond --daemonize --quiet --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
+        lttng-sessiond --daemonize --quiet
 fi
 
 python3 ${CURDIR}/test_daemon.py
diff --git a/tests/regression/ust/exit-fast/test_exit-fast b/tests/regression/ust/exit-fast/test_exit-fast
index e8a0bd6..d0d8da4 100755
--- a/tests/regression/ust/exit-fast/test_exit-fast
+++ b/tests/regression/ust/exit-fast/test_exit-fast
@@ -20,12 +20,10 @@
 STOP_SESSIOND=$?
 
 CURDIR=$(dirname $0)
-TESTDIR=${CURDIR}/../../..
 
 # Try to launch a sessiond before invoking the python test script
 if [ $STOP_SESSIOND -ne 0 ]; then
-	DIR=$(readlink -f ${TESTDIR})
-	${DIR}/../src/bin/lttng-sessiond/lttng-sessiond --daemonize --quiet --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
+	lttng-sessiond --daemonize --quiet
 fi
 
 python3 ${CURDIR}/test_exit-fast.py
diff --git a/tests/regression/ust/fork/test_fork b/tests/regression/ust/fork/test_fork
index e05b556..44a4591 100755
--- a/tests/regression/ust/fork/test_fork
+++ b/tests/regression/ust/fork/test_fork
@@ -20,12 +20,10 @@
 STOP_SESSIOND=$?
 
 CURDIR=$(dirname $0)
-TESTDIR=${CURDIR}/../../..
 
 # Try to launch a sessiond before invoking the python test script
 if [ $STOP_SESSIOND -ne 0 ]; then
-	DIR=$(readlink -f ${TESTDIR})
-	${DIR}/../src/bin/lttng-sessiond/lttng-sessiond --daemonize --quiet --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
+	lttng-sessiond --daemonize --quiet
 fi
 
 python3 ${CURDIR}/test_fork.py
diff --git a/tests/regression/ust/libc-wrapper/test_libc-wrapper b/tests/regression/ust/libc-wrapper/test_libc-wrapper
index 8c6b128..3d53676 100755
--- a/tests/regression/ust/libc-wrapper/test_libc-wrapper
+++ b/tests/regression/ust/libc-wrapper/test_libc-wrapper
@@ -20,12 +20,10 @@
 STOP_SESSIOND=$?
 
 CURDIR=$(dirname $0)
-TESTDIR=${CURDIR}/../../..
 
 # Try to launch a sessiond before invoking the python test script
 if [ $STOP_SESSIOND -ne 0 ]; then
-	DIR=$(readlink -f ${TESTDIR})
-	${DIR}/../src/bin/lttng-sessiond/lttng-sessiond --daemonize --quiet --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
+	lttng-sessiond --daemonize --quiet
 fi
 
 python3 ${CURDIR}/test_libc-wrapper.py
diff --git a/tests/regression/ust/linking/test_linking b/tests/regression/ust/linking/test_linking
index 77e0b82..7c8bbf6 100755
--- a/tests/regression/ust/linking/test_linking
+++ b/tests/regression/ust/linking/test_linking
@@ -20,12 +20,10 @@
 STOP_SESSIOND=$?
 
 CURDIR=$(dirname $0)
-TESTDIR=${CURDIR}/../../..
 
 # Try to launch a sessiond before invoking the python test script
 if [ $STOP_SESSIOND -ne 0 ]; then
-	DIR=$(readlink -f ${TESTDIR})
-	${DIR}/../src/bin/lttng-sessiond/lttng-sessiond --daemonize --quiet --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
+	lttng-sessiond --daemonize --quiet
 fi
 
 python3 ${CURDIR}/test_linking.py
diff --git a/tests/regression/ust/nprocesses/test_nprocesses b/tests/regression/ust/nprocesses/test_nprocesses
index 1660c21..19e8d40 100755
--- a/tests/regression/ust/nprocesses/test_nprocesses
+++ b/tests/regression/ust/nprocesses/test_nprocesses
@@ -52,7 +52,7 @@ done
 
 reg_app_count=0
 while [ $reg_app_count -ne $NUM_PROCESS ]; do
-	listing=$($TESTDIR/../src/bin/lttng/$LTTNG_BIN list -u)
+	listing=$(lttng list -u)
 	reg_app_count=$(echo -n $listing | sed "s#$TESTAPP_BIN#$TESTAPP_BIN\n#g" | grep "$TESTAPP_BIN" | wc -l)
 done
 
diff --git a/tests/regression/ust/overlap/test_overlap b/tests/regression/ust/overlap/test_overlap
index add8ff1..2369e8a 100755
--- a/tests/regression/ust/overlap/test_overlap
+++ b/tests/regression/ust/overlap/test_overlap
@@ -300,7 +300,7 @@ test_enable_same_wildcard_filter_2()
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild1" "1==1"
 
 	# Enabling the same events with same filters should fail. This one is expected to fail.
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_wild2" -s $SESSION_NAME -u --filter "1==1" >/dev/null 2>&1
+	lttng enable-event "$event_wild2" -s $SESSION_NAME -u --filter "1==1" >/dev/null 2>&1
 	if [ $? -ne 0 ]; then
 	    pass "Enable event $event_name with filtering for session $sess_name twice failure detected"
 	else
diff --git a/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush b/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
index ad9d33d..9760e36 100755
--- a/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
+++ b/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
@@ -41,7 +41,7 @@ function enable_channel_per_uid()
 	local sess_name=$1
 	local channel_name=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel --buffers-uid -u $channel_name -s $sess_name --switch-timer 100000 >/dev/null 2>&1
+	lttng enable-channel --buffers-uid -u $channel_name -s $sess_name --switch-timer 100000 >/dev/null 2>&1
 	ok $? "Enable channel $channel_name per UID for session $sess_name"
 }
 
@@ -50,7 +50,7 @@ function enable_channel_per_pid()
 	local sess_name=$1
 	local channel_name=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel --buffers-pid -u $channel_name -s $sess_name --switch-timer 100000 >/dev/null 2>&1
+	lttng enable-channel --buffers-pid -u $channel_name -s $sess_name --switch-timer 100000 >/dev/null 2>&1
 	ok $? "Enable channel $channel_name per UID for session $sess_name"
 }
 
@@ -59,7 +59,7 @@ function enable_metadata_per_uid()
 	local sess_name=$1
 	local channel_name="metadata"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel --buffers-uid -u $channel_name -s $sess_name --switch-timer 200000 >/dev/null 2>&1
+	lttng enable-channel --buffers-uid -u $channel_name -s $sess_name --switch-timer 200000 >/dev/null 2>&1
 	ok $? "Enable channel $channel_name per UID for session $sess_name"
 }
 
@@ -68,7 +68,7 @@ function enable_metadata_per_pid()
 	local sess_name=$1
 	local channel_name="metadata"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel --buffers-pid -u $channel_name -s $sess_name --switch-timer 200000 >/dev/null 2>&1
+	lttng enable-channel --buffers-pid -u $channel_name -s $sess_name --switch-timer 200000 >/dev/null 2>&1
 	ok $? "Enable channel $channel_name per PID for session $sess_name"
 }
 
diff --git a/tests/regression/ust/test_event_basic b/tests/regression/ust/test_event_basic
index 3ff91b3..9af5040 100755
--- a/tests/regression/ust/test_event_basic
+++ b/tests/regression/ust/test_event_basic
@@ -19,7 +19,6 @@ TEST_DESC="UST tracer - Basic events"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../..
-LTTNG_BIN="lttng"
 BIN_NAME="gen-ust-events"
 SESSION_NAME="valid_filter"
 EVENT_NAME="tp:tptest"
@@ -33,7 +32,7 @@ function enable_ust_lttng_event_per_chan()
 	event_name="$2"
 	chan_name="$3"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -s $sess_name -c $chan_name -u >/dev/null 2>&1
+	lttng enable-event "$event_name" -s $sess_name -c $chan_name -u >/dev/null 2>&1
 	ok $? "Enable event $event_name for session $sess_name in channel $chan_name"
 }
 
@@ -43,7 +42,7 @@ function disable_ust_lttng_event_per_chan()
 	event_name="$2"
 	chan_name="$3"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event "$event_name" -s $sess_name -c $chan_name -u >/dev/null 2>&1
+	lttng disable-event "$event_name" -s $sess_name -c $chan_name -u >/dev/null 2>&1
 	ok $? "Disable event $event_name for session $sess_name in channel $chan_name"
 }
 
@@ -53,7 +52,7 @@ function add_ust_lttng_context()
 	chan_name="$2"
 	type="$3"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN add-context -s $sess_name -c $chan_name -t $type -u >/dev/null 2>&1
+	lttng add-context -s $sess_name -c $chan_name -t $type -u >/dev/null 2>&1
 	ok $? "Add context $type for session $sess_name in channel $chan_name"
 }
 
diff --git a/tests/regression/ust/test_event_wildcard b/tests/regression/ust/test_event_wildcard
index 33ba4c4..743bac0 100755
--- a/tests/regression/ust/test_event_wildcard
+++ b/tests/regression/ust/test_event_wildcard
@@ -19,7 +19,6 @@ TEST_DESC="UST tracer - Event wildcard"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../..
-LTTNG_BIN="lttng"
 BIN_NAME="gen-ust-events"
 SESSION_NAME="valid_filter"
 EVENT_NAME="tp:tptest"
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index a09089a..2e44166 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -15,10 +15,21 @@
 # along with this library; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
 
-SESSIOND_BIN="lttng-sessiond"
-RELAYD_BIN="lttng-relayd"
-LTTNG_BIN="lttng"
-BABELTRACE_BIN="babeltrace"
+# For in-build-tree testing we need to use other hanes...
+LTTNG_BIN="$TESTDIR/../src/bin/lttng/lttng"
+SESSIOND_BIN="$TESTDIR/../src/bin/lttng-sessiond/lttng-sessiond"
+RELAYD_BIN="$TESTDIR/../src/bin/lttng-relayd/lttng-relayd"
+SESSIOND_NAME="lt-lttng-sessiond"
+RELAYD_NAME="lt-lttng-relayd"
+
+# ...then for installation testing.
+if [ $installcheck ]; then
+  LTTNG_BIN=lttng
+  SESSIOND_BIN=lttng-sessiond
+  RELAYD_BIN=lttng-relayd
+  SESSIOND_NAME=lttng-sessiond
+  RELAYD_NAME=lttng-relayd
+fi
 
 # Minimal kernel version supported for session daemon tests
 KERNEL_MAJOR_VERSION=2
@@ -96,7 +107,7 @@ function lttng_enable_kernel_event
 		chan="-c $channel_name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -k >/dev/null 2>&1
+	$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -k >/dev/null 2>&1
 	ok $? "Enable kernel event $event_name for session $sess_name"
 }
 
@@ -106,9 +117,9 @@ function start_lttng_relayd
 
 	DIR=$(readlink -f $TESTDIR)
 
-	if [ -z $(pidof lt-$RELAYD_BIN) ]; then
-		$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt >/dev/null 2>&1 &
-		#$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt -vvv >>/tmp/relayd.log 2>&1 &
+	if [ -z $(pidof $RELAYD_NAME) ]; then
+		$RELAYD_BIN $opt >/dev/null 2>&1 &
+		#$RELAYD_BIN $opt -vvv >>/tmp/relayd.log 2>&1 &
 		if [ $? -eq 1 ]; then
 			fail "Start lttng-relayd (opt: $opt)"
 			return 1
@@ -122,7 +133,7 @@ function start_lttng_relayd
 
 function stop_lttng_relayd
 {
-	PID_RELAYD=`pidof lt-$RELAYD_BIN`
+	PID_RELAYD=`pidof $RELAYD_NAME`
 
 	kill $PID_RELAYD >/dev/null 2>&1
 
@@ -132,7 +143,7 @@ function stop_lttng_relayd
 	else
 		out=1
 		while [ -n "$out" ]; do
-			out=$(pidof lt-$RELAYD_BIN)
+			out=$(pidof $RELAYD_NAME)
 			sleep 0.5
 		done
 		pass "Kill lttng-relayd (pid: $PID_RELAYD)"
@@ -155,9 +166,9 @@ function start_lttng_sessiond()
 
 	DIR=$(readlink -f $TESTDIR)
 
-	if [ -z $(pidof lt-$SESSIOND_BIN) ]; then
-		$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --daemonize --quiet --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
-		#$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --verbose-consumer >>/tmp/sessiond.log 2>&1 &
+	if [ -z $(pidof $SESSIOND_NAME) ]; then
+		$SESSIOND_BIN --daemonize --quiet
+		#$SESSIOND_BIN --verbose-consumer >>/tmp/sessiond.log 2>&1 &
 		status=$?
 		# Wait for sessiond to bootstrap
 		sleep 2
@@ -172,7 +183,7 @@ function stop_lttng_sessiond ()
 		return
 	fi
 
-	PID_SESSIOND=`pidof lt-$SESSIOND_BIN`
+	PID_SESSIOND=`pidof $SESSIOND_NAME`
 
 	kill $PID_SESSIOND >/dev/null 2>&1
 
@@ -182,7 +193,7 @@ function stop_lttng_sessiond ()
 	else
 		out=1
 		while [ -n "$out" ]; do
-			out=$(pidof lt-$SESSIOND_BIN)
+			out=$(pidof $SESSIOND_NAME)
 			sleep 0.5
 		done
 		pass "Kill session daemon"
@@ -193,7 +204,7 @@ function create_lttng_session_no_output ()
 {
 	sess_name=$1
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN create $sess_name --no-output >/dev/null 2>&1
+	$LTTNG_BIN create $sess_name --no-output >/dev/null 2>&1
 	ok $? "Create session $sess_name in no-output mode"
 }
 
@@ -202,7 +213,7 @@ function create_lttng_session ()
 	sess_name=$1
 	trace_path=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN create $sess_name -o $trace_path >/dev/null 2>&1
+	$LTTNG_BIN create $sess_name -o $trace_path >/dev/null 2>&1
 	ok $? "Create session $sess_name in $trace_path"
 }
 
@@ -211,7 +222,7 @@ function enable_ust_lttng_channel()
 	sess_name=$1
 	channel_name=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -u $channel_name -s $sess_name >/dev/null 2>&1
+	$LTTNG_BIN enable-channel -u $channel_name -s $sess_name >/dev/null 2>&1
 	ok $? "Enable channel $channel_name for session $sess_name"
 }
 
@@ -220,7 +231,7 @@ function disable_ust_lttng_channel()
 	sess_name=$1
 	channel_name=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-channel -u $channel_name -s $sess_name >/dev/null 2>&1
+	$LTTNG_BIN disable-channel -u $channel_name -s $sess_name >/dev/null 2>&1
 	ok $? "Disable channel $channel_name for session $sess_name"
 }
 
@@ -229,7 +240,7 @@ function enable_lttng_mmap_overwrite_kernel_channel()
 	sess_name=$1
 	channel_name=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -s $sess_name $channel_name -k --output mmap --overwrite >/dev/null 2>&1
+	$LTTNG_BIN enable-channel -s $sess_name $channel_name -k --output mmap --overwrite >/dev/null 2>&1
 	ok $? "Enable channel $channel_name for session $sess_name"
 }
 
@@ -238,7 +249,7 @@ function enable_lttng_mmap_overwrite_ust_channel()
 	sess_name=$1
 	channel_name=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -s $sess_name $channel_name -u --output mmap --overwrite >/dev/null 2>&1
+	$LTTNG_BIN enable-channel -s $sess_name $channel_name -u --output mmap --overwrite >/dev/null 2>&1
 	ok $? "Enable channel $channel_name for session $sess_name"
 }
 
@@ -255,7 +266,7 @@ function enable_ust_lttng_event ()
 		chan="-c $channel_name"
 	fi
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -u >/dev/null 2>&1
+	$LTTNG_BIN enable-event "$event_name" $chan -s $sess_name -u >/dev/null 2>&1
 	ok $? "Enable event $event_name for session $sess_name"
 }
 
@@ -265,7 +276,7 @@ function enable_ust_lttng_event_filter()
 	event_name="$2"
 	filter="$3"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -s $sess_name -u --filter "$filter" >/dev/null 2>&1
+	$LTTNG_BIN enable-event "$event_name" -s $sess_name -u --filter "$filter" >/dev/null 2>&1
 	ok $? "Enable event $event_name with filtering for session $sess_name"
 }
 
@@ -275,7 +286,7 @@ function enable_ust_lttng_event_loglevel()
 	event_name="$2"
 	loglevel="$3"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -s $sess_name -u --loglevel $loglevel >/dev/null 2>&1
+	$LTTNG_BIN enable-event "$event_name" -s $sess_name -u --loglevel $loglevel >/dev/null 2>&1
 	ok $? "Enable event $event_name with loglevel $loglevel"
 }
 
@@ -285,7 +296,7 @@ function enable_ust_lttng_event_loglevel_only()
 	event_name="$2"
 	loglevel="$3"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -s $sess_name -u --loglevel-only $loglevel >/dev/null 2>&1
+	$LTTNG_BIN enable-event "$event_name" -s $sess_name -u --loglevel-only $loglevel >/dev/null 2>&1
 	ok $? "Enable event $event_name with loglevel-only $loglevel"
 }
 
@@ -294,7 +305,7 @@ function disable_ust_lttng_event ()
 	sess_name="$1"
 	event_name="$2"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event "$event_name" -s $sess_name -u >/dev/null 2>&1
+	$LTTNG_BIN disable-event "$event_name" -s $sess_name -u >/dev/null 2>&1
 	ok $? "Disable event $event_name for session $sess_name"
 }
 
@@ -302,7 +313,7 @@ function start_lttng_tracing ()
 {
 	sess_name=$1
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN start $sess_name >/dev/null 2>&1
+	$LTTNG_BIN start $sess_name >/dev/null 2>&1
 	ok $? "Start tracing for session $sess_name"
 }
 
@@ -310,7 +321,7 @@ function stop_lttng_tracing ()
 {
 	sess_name=$1
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN stop $sess_name >/dev/null 2>&1
+	$LTTNG_BIN stop $sess_name >/dev/null 2>&1
 	ok $? "Stop lttng tracing for session $sess_name"
 }
 
@@ -319,7 +330,7 @@ function destroy_lttng_session ()
 	sess_name=$1
 
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN destroy $sess_name >/dev/null 2>&1
+	$LTTNG_BIN destroy $sess_name >/dev/null 2>&1
 	ok $? "Destroy lttng session $sess_name"
 }
 
@@ -328,7 +339,7 @@ function lttng_snapshot_add_output ()
 	sess_name=$1
 	trace_path=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot add-output -s $sess_name file://$trace_path >/dev/null 2>&1
+	$LTTNG_BIN snapshot add-output -s $sess_name file://$trace_path >/dev/null 2>&1
 	ok $? "Added snapshot output file://$trace_path"
 }
 
@@ -337,7 +348,7 @@ function lttng_snapshot_del_output ()
 	local sess_name=$1
 	local id=$2
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot del-output -s $sess_name $id >/dev/null 2>&1
+	$LTTNG_BIN snapshot del-output -s $sess_name $id >/dev/null 2>&1
 	ok $? "Deleted snapshot output id $id"
 }
 
@@ -345,8 +356,8 @@ function lttng_snapshot_record ()
 {
 	sess_name=$1
 	trace_path=$2
-
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot record -s $sess_name >/dev/null 2>&1
+	
+	$LTTNG_BIN snapshot record -s $sess_name >/dev/null 2>&1
 	ok $? "Snapshot recorded"
 }
 
@@ -356,10 +367,10 @@ function trace_matches ()
 	nr_iter=$2
 	trace_path=$3
 
-	which $BABELTRACE_BIN >/dev/null
+	which babeltrace >/dev/null
 	skip $? -ne 0 "Babeltrace binary not found. Skipping trace matches"
 
-	count=$($BABELTRACE_BIN $trace_path | grep $event_name | wc -l)
+	count=$(babeltrace $trace_path | grep $event_name | wc -l)
 
 	if [ "$count" -ne "$nr_iter" ]; then
 		fail "Trace match"
@@ -374,7 +385,7 @@ function validate_trace
 	event_name=$1
 	trace_path=$2
 
-	which $BABELTRACE_BIN >/dev/null
+	which babeltrace >/dev/null
 	if [ $? -ne 0 ]; then
 	    skip 0 "Babeltrace binary not found. Skipping trace validation"
 	fi
@@ -382,7 +393,7 @@ function validate_trace
 	OLDIFS=$IFS
 	IFS=","
 	for i in $event_name; do
-		traced=$($BABELTRACE_BIN $trace_path 2>/dev/null | grep $i | wc -l)
+		traced=$(babeltrace $trace_path 2>/dev/null | grep $i | wc -l)
 		if [ "$traced" -ne 0 ]; then
 			pass "Validate trace for event $i, $traced events"
 		else
-- 
1.8.3.1
