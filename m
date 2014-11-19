From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 8/8] Fix: add missing
	synchronization point for before app test case
Date: Wed, 19 Nov 2014 22:40:32 +0100
Message-ID: <1416433232-20080-9-git-send-email-mathieu.desnoyers__18691.831539809$1416433534$gmane$org@efficios.com>
References: <1416433232-20080-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XrCzl-0002O5-NA
 for lttng-dev@lists.lttng.org; Wed, 19 Nov 2014 16:41:04 -0500
In-Reply-To: <1416433232-20080-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Fixes a race where the application could generate all its events before
trace start.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../regression/tools/snapshots/test_ust_streaming  |  2 +-
 tests/regression/tools/snapshots/ust_test          |  2 +-
 tests/regression/tools/streaming/test_ust          | 23 ++++++--
 .../regression/ust/before-after/test_before_after  | 11 ++--
 tests/regression/ust/buffers-pid/test_buffers_pid  | 26 ++++++---
 tests/regression/ust/java-jul/test_java_jul        | 11 +++-
 tests/regression/ust/java-log4j/test_java_log4j    | 11 +++-
 tests/regression/ust/nprocesses/test_nprocesses    | 14 +++--
 .../test_periodical_metadata_flush                 |  2 +-
 .../utils/testapp/gen-ust-events/gen-ust-events.c  | 63 +++++++++++++++++-----
 10 files changed, 128 insertions(+), 37 deletions(-)

diff --git a/tests/regression/tools/snapshots/test_ust_streaming b/tests/regression/tools/snapshots/test_ust_streaming
index 55c1087..ef38bd5 100755
--- a/tests/regression/tools/snapshots/test_ust_streaming
+++ b/tests/regression/tools/snapshots/test_ust_streaming
@@ -58,7 +58,7 @@ function snapshot_add_output ()
 # Start trace application and return once one event has been hit.
 function start_test_app()
 {
-	local tmp_file="/tmp/lttng_test_ust.42.file"
+	local tmp_file=$(mktemp -u)
 
 	# Start application with a temporary file.
 	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT $tmp_file &
diff --git a/tests/regression/tools/snapshots/ust_test b/tests/regression/tools/snapshots/ust_test
index 1541e6e..cbc2058 100755
--- a/tests/regression/tools/snapshots/ust_test
+++ b/tests/regression/tools/snapshots/ust_test
@@ -49,7 +49,7 @@ NUM_TESTS=$(($NUM_TESTS + ($NR_SNAPSHOT * 2)))
 
 function start_test_app()
 {
-	local tmp_file="/tmp/lttng_test_ust.42.file"
+	local tmp_file=$(mktemp -u)
 
 	# Start application with a temporary file.
 	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT $tmp_file &
diff --git a/tests/regression/tools/streaming/test_ust b/tests/regression/tools/streaming/test_ust
index 4807175..330a707 100755
--- a/tests/regression/tools/streaming/test_ust
+++ b/tests/regression/tools/streaming/test_ust
@@ -49,40 +49,53 @@ function lttng_create_session_uri
 
 function test_ust_before_start ()
 {
+	local file_sync_after_first=$(mktemp -u)
+	local file_sync_before_last=$(mktemp -u)
+
 	diag "Test UST streaming BEFORE tracing starts"
 	lttng_create_session_uri
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
 
 	# Run 5 times with a 1 second delay
-	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1 &
-
-	#FIXME: racy missing synchro
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT ${file_sync_after_first} ${file_sync_before_last} /dev/null 2>&1 &
 
 	start_lttng_tracing $SESSION_NAME
+
+	touch ${file_sync_before_last}
+
 	# Wait for the applications started in background
 	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
+	rm -f ${file_sync_after_first}
+	rm -f ${file_sync_before_last}
 }
 
 function test_ust_after_start ()
 {
+	local file_sync_after_first=$(mktemp -u)
+	local file_sync_before_last=$(mktemp -u)
+
 	diag "Test UST streaming AFTER tracing starts"
 	lttng_create_session_uri
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
 	start_lttng_tracing $SESSION_NAME
 
 	# Run 5 times with a 1 second delay
-	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT ${file_sync_after_first} ${file_sync_before_last} >/dev/null 2>&1
 
-	#FIXME: racy missing synchro
+	while [ ! -f "${file_sync_after_first}" ]; do
+		sleep 0.5
+	done
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
 	# Wait for the applications started in background
 	wait
+	rm -f ${file_sync_after_first}
+	rm -f ${file_sync_before_last}
 }
 
 plan_tests $NUM_TESTS
diff --git a/tests/regression/ust/before-after/test_before_after b/tests/regression/ust/before-after/test_before_after
index 1535f36..460b04c 100755
--- a/tests/regression/ust/before-after/test_before_after
+++ b/tests/regression/ust/before-after/test_before_after
@@ -57,22 +57,27 @@ function test_before_apps()
 function test_after_apps()
 {
 	local out
+	local file_sync_after_first=$(mktemp -u)
+	local file_sync_before_last=$(mktemp -u)
 
 	create_lttng_session $SESSION_NAME $TRACE_PATH
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
 
-	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT &
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT ${file_sync_after_first} ${file_sync_before_last} &
 	ok $? "Application started in background."
 
-	#FIXME: racy missing synchronization
-
 	start_lttng_tracing $SESSION_NAME
 
+	touch ${file_sync_before_last}
+
 	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
+	rm -f ${file_sync_after_first}
+	rm -f ${file_sync_before_last}
+
 	validate_trace $EVENT_NAME $TRACE_PATH
 	out=$?
 
diff --git a/tests/regression/ust/buffers-pid/test_buffers_pid b/tests/regression/ust/buffers-pid/test_buffers_pid
index 0258e89..c95a4a1 100755
--- a/tests/regression/ust/buffers-pid/test_buffers_pid
+++ b/tests/regression/ust/buffers-pid/test_buffers_pid
@@ -74,22 +74,26 @@ test_after_multiple_apps() {
 test_before_multiple_apps() {
 	local out
 	local i
+	local file_sync_after_first=$(mktemp -u)
+	local file_sync_before_last=$(mktemp -u)
 
 	diag "Start multiple applications BEFORE tracing is started"
 
 	for i in `seq 1 5`; do
-		$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1 &
+		$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT ${file_sync_after_first}_${i} ${file_sync_before_last}_${i} >/dev/null 2>&1 &
 		ok $? "Start application $i for tracing"
 	done
 
-	#FIXME: racy missing synchronization
-
 	# BEFORE application is spawned
 	create_lttng_session $SESSION_NAME $TRACE_PATH
 	enable_channel_per_pid $SESSION_NAME "channel0"
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME "channel0"
 	start_lttng_tracing $SESSION_NAME
 
+	for i in `seq 1 5`; do
+		touch ${file_sync_before_last}_${i}
+	done
+
 	diag "Waiting for applications to end"
 	wait
 	pass "Waiting done"
@@ -97,6 +101,11 @@ test_before_multiple_apps() {
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
+	for i in `seq 1 5`; do
+		rm -f ${file_sync_after_first}_${i}
+		rm -f ${file_sync_before_last}_${i}
+	done
+
 	out=$(babeltrace $TRACE_PATH | grep $EVENT_NAME | wc -l)
 	if [ $out -eq 0 ]; then
 		fail "Trace validation"
@@ -136,6 +145,8 @@ test_after_app() {
 
 test_before_app() {
 	local out
+	local file_sync_after_first=$(mktemp -u)
+	local file_sync_before_last=$(mktemp -u)
 
 	diag "Start application BEFORE tracing is started"
 
@@ -145,18 +156,21 @@ test_before_app() {
 	enable_channel_per_pid $SESSION_NAME "channel0"
 	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME "channel0"
 
-	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT &
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT ${file_sync_after_first} ${file_sync_before_last} &
 	ok $? "Start application to trace"
 
-	#FIXME: racy missing synchronization
-
 	start_lttng_tracing $SESSION_NAME
 
+	touch ${file_sync_before_last}
+
 	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
+	rm -f ${file_sync_after_first}
+	rm -f ${file_sync_before_last}
+
 	out=$(babeltrace $TRACE_PATH | grep $EVENT_NAME | wc -l)
 	if [ $out -eq 0 ]; then
 		fail "Trace validation"
diff --git a/tests/regression/ust/java-jul/test_java_jul b/tests/regression/ust/java-jul/test_java_jul
index d16880f..d32d9ed 100755
--- a/tests/regression/ust/java-jul/test_java_jul
+++ b/tests/regression/ust/java-jul/test_java_jul
@@ -38,6 +38,7 @@ function run_app
 	local finest_tp=$1
 	local fire_second_tp=$2
 
+	#FIXME: app should have synchro.
 	java -cp $JAVA_CP -Djava.library.path="/usr/local/lib:/usr/lib" $TESTAPP_NAME $NR_ITER $NR_MSEC_WAIT $finest_tp $fire_second_tp >/dev/null 2>&1
 }
 
@@ -89,6 +90,9 @@ function enable_jul_filter_loglevel_only()
 
 function test_jul_before_start ()
 {
+	local file_sync_after_first=$(mktemp -u)
+	local file_sync_before_last=$(mktemp -u)
+
 	diag "Test JUL application BEFORE tracing starts"
 	create_lttng_session $SESSION_NAME $TRACE_PATH
 	enable_jul_lttng_event $SESSION_NAME $EVENT_NAME
@@ -96,16 +100,19 @@ function test_jul_before_start ()
 	# Run 5 times with a 1 second delay
 	run_app_background
 
-	#FIXME: racy missing synchronization
-
 	start_lttng_tracing $SESSION_NAME
 
+	touch ${file_sync_before_last}
+
 	# Wait for the applications started in background
 	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
+	rm -f ${file_sync_after_first}
+	rm -f ${file_sync_before_last}
+
 	# Validate test. Expecting all events.
 	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
 	if [ $? -ne 0 ]; then
diff --git a/tests/regression/ust/java-log4j/test_java_log4j b/tests/regression/ust/java-log4j/test_java_log4j
index 11845a0..a0b7cdc 100755
--- a/tests/regression/ust/java-log4j/test_java_log4j
+++ b/tests/regression/ust/java-log4j/test_java_log4j
@@ -39,6 +39,7 @@ function run_app
 	local debug_tp=$1
 	local fire_second_tp=$2
 
+	# FIXME: test app should have synchro.
 	java -cp $JAVA_CP -Djava.library.path="/usr/local/lib:/usr/lib" $TESTAPP_NAME $NR_ITER $NR_MSEC_WAIT $debug_tp $fire_second_tp >/dev/null 2>&1
 }
 
@@ -90,6 +91,9 @@ function enable_log4j_filter_loglevel_only()
 
 function test_log4j_before_start ()
 {
+	local file_sync_after_first=$(mktemp -u)
+	local file_sync_before_last=$(mktemp -u)
+
 	diag "Test LOG4J application BEFORE tracing starts"
 	create_lttng_session $SESSION_NAME $TRACE_PATH
 	enable_log4j_lttng_event $SESSION_NAME $EVENT_NAME
@@ -97,16 +101,19 @@ function test_log4j_before_start ()
 	# Run 5 times with a 1 second delay
 	run_app_background
 
-	#FIXME: racy missing synchronization
-
 	start_lttng_tracing $SESSION_NAME
 
+	touch ${file_sync_before_last}
+
 	# Wait for the applications started in background
 	wait
 
 	stop_lttng_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
+	rm -f ${file_sync_after_first}
+	rm -f ${file_sync_before_last}
+
 	# Validate test. Expecting all events.
 	trace_match_only $EVENT_NAME $NR_ITER $TRACE_PATH
 	if [ $? -ne 0 ]; then
diff --git a/tests/regression/ust/nprocesses/test_nprocesses b/tests/regression/ust/nprocesses/test_nprocesses
index ca0f9d4..8eed95f 100755
--- a/tests/regression/ust/nprocesses/test_nprocesses
+++ b/tests/regression/ust/nprocesses/test_nprocesses
@@ -46,15 +46,16 @@ start_lttng_sessiond
 
 # Start tests. Each is an infinite tracing loop.
 
+file_sync_after_first=$(mktemp -u)
+file_sync_before_last=$(mktemp -u)
+
 diag "Starting $NUM_PROCESS test applications"
 for i in `seq 1 $NUM_PROCESS`
 do
-	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1 &
+	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT ${file_sync_after_first} ${file_sync_before_last} >/dev/null 2>&1 &
 	APPS_PID="${APPS_PID} ${!}"
 done
 
-#FIXME: racy missing synchronization
-
 diag "Waiting for applications to be registered to sessiond"
 
 reg_app_count=0
@@ -72,13 +73,15 @@ create_lttng_session $SESSION_NAME $TRACE_PATH
 enable_ust_lttng_event $SESSION_NAME $EVENT_NAME
 start_lttng_tracing $SESSION_NAME
 
+touch ${file_sync_before_last}
+
 # We don't validate whether the applications have traced here, rather
 # just that they registered to sessiond (above).
 
 stop_lttng_tracing $SESSION_NAME
 destroy_lttng_session $SESSION_NAME
 
-#FIXME/TODO: add validation after fixing racy synchroniaation
+#TODO: add trace validation.
 
 rm -rf $TRACE_PATH
 
@@ -90,4 +93,7 @@ done
 APPS_PID=
 pass "Stopped all spawned applications"
 
+rm -f ${file_sync_after_first}
+rm -f ${file_sync_before_last}
+
 stop_lttng_sessiond
diff --git a/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush b/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
index 53db813..7937fa2 100755
--- a/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
+++ b/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
@@ -27,7 +27,7 @@ SESSION_NAME="periodical-flush"
 EVENT_NAME="tp:tptest"
 BIN_NAME="gen-nevents"
 NUM_TESTS=38
-APP_TMP_FILE="/tmp/lttng_test_ust.42.file"
+APP_TMP_FILE=$(mktemp -u)
 APPS_PID=
 
 source $TESTDIR/utils/utils.sh
diff --git a/tests/utils/testapp/gen-ust-events/gen-ust-events.c b/tests/utils/testapp/gen-ust-events/gen-ust-events.c
index 42fa082..60f1c6f 100644
--- a/tests/utils/testapp/gen-ust-events/gen-ust-events.c
+++ b/tests/utils/testapp/gen-ust-events/gen-ust-events.c
@@ -15,6 +15,7 @@
  * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
  */
 
+#define _GNU_SOURCE
 #include <assert.h>
 #include <arpa/inet.h>
 #include <fcntl.h>
@@ -27,15 +28,21 @@
 #include <sys/types.h>
 #include <unistd.h>
 #include <stdbool.h>
+#include <signal.h>
+#include <poll.h>
+#include <errno.h>
 
 #define TRACEPOINT_DEFINE
 #include "tp.h"
 
 void create_file(const char *path)
 {
+	static bool file_created = false;
 	int ret;
 
-	assert(path);
+	if (!path || file_created) {
+		return;
+	}
 
 	ret = creat(path, S_IRWXU);
 	if (ret < 0) {
@@ -44,6 +51,30 @@ void create_file(const char *path)
 	}
 
 	(void) close(ret);
+	file_created = true;
+}
+
+static
+void wait_on_file(const char *path)
+{
+	if (!path) {
+		return;
+	}
+	for (;;) {
+		int ret;
+		struct stat buf;
+
+		ret = stat(path, &buf);
+		if (ret == -1 && errno == ENOENT) {
+			(void) poll(NULL, 0, 10);	/* 10 ms delay */
+			continue;			/* retry */
+		}
+		if (ret) {
+			perror("stat");
+			exit(EXIT_FAILURE);
+		}
+		break;	/* found */
+	}
 }
 
 int main(int argc, char **argv)
@@ -55,8 +86,8 @@ int main(int argc, char **argv)
 	float flt = 2222.0;
 	int nr_iter = 100;
 	useconds_t nr_usec = 0;
-	char *tmp_file_path = NULL;
-	bool file_created = false;
+	char *after_first_event_file_path = NULL;
+	char *before_last_event_file_path = NULL;
 
 	if (argc >= 2) {
 		/*
@@ -71,22 +102,30 @@ int main(int argc, char **argv)
 	}
 
 	if (argc >= 4) {
-		tmp_file_path = argv[3];
+		after_first_event_file_path = argv[3];
+	}
+
+	if (argc >= 5) {
+		before_last_event_file_path = argv[4];
 	}
 
 	for (i = 0; nr_iter < 0 || i < nr_iter; i++) {
+		if (nr_iter >= 0 && i == nr_iter) {
+			/*
+			 * Wait on synchronization before writing last
+			 * event.
+			 */
+			wait_on_file(before_last_event_file_path);
+		}
 		netint = htonl(i);
-		tracepoint(tp, tptest, i, netint, values, text, strlen(text), dbl,
-				flt);
+		tracepoint(tp, tptest, i, netint, values, text,
+			strlen(text), dbl, flt);
 
 		/*
-		 * First loop we create the file if asked to indicate that at least one
-		 * tracepoint has been hit.
+		 * First loop we create the file if asked to indicate
+		 * that at least one tracepoint has been hit.
 		 */
-		if (!file_created && tmp_file_path) {
-			create_file(tmp_file_path);
-			file_created = true;
-		}
+		create_file(after_first_event_file_path);
 		usleep(nr_usec);
 	}
 
-- 
2.1.1
