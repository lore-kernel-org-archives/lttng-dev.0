From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 3/4] Tests: Cleanup redundant code
	and use printing helper functions
Date: Thu, 20 Sep 2012 18:05:19 -0400
Message-ID: <1348178720-24610-3-git-send-email-christian.babeux__21573.4608391815$1348178786$gmane$org@efficios.com>
References: <1348178720-24610-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TEosa-0004XT-ED
	for lttng-dev@lists.lttng.org; Thu, 20 Sep 2012 18:05:52 -0400
Received: by mail-qc0-f176.google.com with SMTP id c21so2633842qcs.35
	for <lttng-dev@lists.lttng.org>; Thu, 20 Sep 2012 15:05:52 -0700 (PDT)
In-Reply-To: <1348178720-24610-1-git-send-email-christian.babeux@efficios.com>
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


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/kernel/run-kernel-tests.sh    |  7 +++--
 tests/tools/streaming/run-kernel    | 13 ++++----
 tests/tools/streaming/run-ust       |  5 ++--
 tests/tools/streaming/uri_switch    |  6 ++--
 tests/ust/before-after/run          | 14 ++++-----
 tests/ust/high-throughput/run       |  9 +++---
 tests/ust/low-throughput/run        |  9 +++---
 tests/ust/multi-session/run         | 13 ++++----
 tests/ust/nprocesses/run            |  7 ++---
 tests/ust/nprocesses/ust-nprocesses |  7 +++--
 tests/ust/run-ust-global-tests.sh   |  6 ++--
 tests/utils.sh                      | 60 +++++++++++++++++++------------------
 12 files changed, 76 insertions(+), 80 deletions(-)

diff --git a/tests/kernel/run-kernel-tests.sh b/tests/kernel/run-kernel-tests.sh
index f872be5..358bf92 100755
--- a/tests/kernel/run-kernel-tests.sh
+++ b/tests/kernel/run-kernel-tests.sh
@@ -46,9 +46,10 @@ function check_lttng_modules ()
 	fi
 }
 
-echo -e "\n---------------------"
-echo -e "Testing Kernel tracer"
-echo -e "---------------------"
+
+TEST_DESC="Testing Kernel tracer"
+
+print_test_banner
 
 # Detect lttng-modules installed
 check_lttng_modules
diff --git a/tests/tools/streaming/run-kernel b/tests/tools/streaming/run-kernel
index 73a99de..fb05c71 100755
--- a/tests/tools/streaming/run-kernel
+++ b/tests/tools/streaming/run-kernel
@@ -14,6 +14,7 @@
 # You should have received a copy of the GNU Lesser General Public License
 # along with this library; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+TEST_DESC="Streaming - Kernel tracing"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../..
@@ -25,9 +26,7 @@ TRACE_PATH=$(mktemp -d)
 
 source $TESTDIR/utils.sh
 
-echo -e "\n---------------------------"
-echo -e " Streaming - Kernel tracing "
-echo -e "----------------------------"
+print_test_banner
 
 if [ "$(id -u)" != "0" ]; then
 	echo "This test must be running as root. Aborting"
@@ -50,10 +49,10 @@ function lttng_create_session
 	# Create session with default path
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN create $SESSION_NAME >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
-		echo -e '\e[1;31mFAILED\e[0m'
+		print_fail
 		return 1
 	else
-		echo -e "\e[1;32mOK\e[0m"
+		print_ok
 	fi
 }
 
@@ -63,10 +62,10 @@ function lttng_enable_consumer_localhost
 	# Create session with default path
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-consumer -k net://localhost >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
-		echo -e '\e[1;31mFAILED\e[0m'
+		print_fail
 		return 1
 	else
-		echo -e "\e[1;32mOK\e[0m"
+		print_ok
 	fi
 }
 
diff --git a/tests/tools/streaming/run-ust b/tests/tools/streaming/run-ust
index 0149918..4fd2f74 100755
--- a/tests/tools/streaming/run-ust
+++ b/tests/tools/streaming/run-ust
@@ -14,6 +14,7 @@
 # You should have received a copy of the GNU Lesser General Public License
 # along with this library; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+TEST_DESC="Streaming - User space tracing"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../..
@@ -26,9 +27,7 @@ TRACE_PATH=$(mktemp -d)
 
 source $TESTDIR/utils.sh
 
-echo -e "\n-------------------------------"
-echo -e " Streaming - User space tracing "
-echo -e "--------------------------------"
+print_test_banner
 
 if [ ! -x "$CURDIR/$BIN_NAME" ]; then
 	echo -e "No UST nevents binary detected. Passing."
diff --git a/tests/tools/streaming/uri_switch b/tests/tools/streaming/uri_switch
index a6b1582..6081417 100755
--- a/tests/tools/streaming/uri_switch
+++ b/tests/tools/streaming/uri_switch
@@ -15,6 +15,7 @@
 # You should have received a copy of the GNU Lesser General Public License
 # along with this library; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+TEST_DESC="Streaming - URI switching"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../..
@@ -27,10 +28,7 @@ TRACE_PATH=$(mktemp -d)
 
 source $TESTDIR/utils.sh
 
-echo -e "\n"
-echo -e "---------------------------"
-echo -e " Streaming - URI switching "
-echo -e "---------------------------"
+print_test_banner
 
 if [ ! -x "$CURDIR/$BIN_NAME" ]; then
 	echo -e "No UST nevents binary detected. Skipping."
diff --git a/tests/ust/before-after/run b/tests/ust/before-after/run
index 9b16528..db6584b 100755
--- a/tests/ust/before-after/run
+++ b/tests/ust/before-after/run
@@ -14,6 +14,7 @@
 # You should have received a copy of the GNU Lesser General Public License
 # along with this library; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+TEST_DESC="UST tracer - Start tracing before and after execution"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../..
@@ -23,9 +24,7 @@ EVENT_NAME="ust_gen_nevents:tptest"
 
 source $TESTDIR/utils.sh
 
-echo -e "\n----------------------------------------------------"
-echo -e "UST tracer - Star tracing before and after execution"
-echo -e "----------------------------------------------------"
+print_test_banner
 
 if [ ! -x "$CURDIR/gen-nevents" ]; then
 	echo -e "No UST nevents binary detected. Passing."
@@ -44,7 +43,8 @@ test_before_apps() {
 	# Start test
 	echo -n "Starting application... "
 	./$CURDIR/gen-nevents $NR_ITER
-	echo -e "Ended \e[1;32mOK\e[0m"
+	echo -e "Ended "
+	print_ok
 	stop_tracing $SESSION_NAME
 	destroy_lttng_session $SESSION_NAME
 
@@ -58,7 +58,7 @@ test_after_apps() {
 
 	echo -n "Starting application... "
 	./$CURDIR/gen-nevents 100 &
-	echo -e "\e[1;32mOK\e[0m"
+	print_ok
 
 	# BEFORE application is spawned
 	create_lttng_session $SESSION_NAME $TRACE_PATH
@@ -74,11 +74,11 @@ test_after_apps() {
 	out=$(babeltrace $TRACE_PATH | grep $EVENT_NAME | wc -l)
 	if [ $out -eq 0 ]; then
 		echo -n "No event found. Suppose to have at least one... "
-		echo -e "\e[1;31mFAILED\e[0m"
+		print_fail
 		out=1
 	else
 		echo -n "Found $out event(s). Coherent... "
-		echo -e "\e[1;32mOK\e[0m"
+		print_ok
 		out=0
 	fi
 
diff --git a/tests/ust/high-throughput/run b/tests/ust/high-throughput/run
index de3111d..a6aef3d 100755
--- a/tests/ust/high-throughput/run
+++ b/tests/ust/high-throughput/run
@@ -14,6 +14,7 @@
 # You should have received a copy of the GNU Lesser General Public License
 # along with this library; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+TEST_DESC="UST tracer - Testing high events throughput"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../..
@@ -24,9 +25,7 @@ EVENT_NAME="tp:tptest"
 
 source $TESTDIR/utils.sh
 
-echo -e "\n-------------------------------------------"
-echo -e "UST tracer - Testing high events throughput"
-echo -e "-------------------------------------------"
+print_test_banner
 
 if [ ! -x "$CURDIR/$BIN_NAME" ]; then
 	echo -e "No UST nevents binary detected. Passing."
@@ -81,11 +80,11 @@ let wanted=$NR_ITER*1000000
 
 if [ $wanted -ne $total ]; then
 	echo -n "Expected $wanted. Dropped $dropped. Recorded $traced. Total $total... "
-	echo -e "\e[1;31mFAILED\e[0m"
+	print_fail
 	out=1
 else
 	echo -n "Expected $wanted. Dropped $dropped. Recorded $traced. Total $total... "
-	echo -e "\e[1;32mOK\e[0m"
+	print_ok
 	out=0
 fi
 
diff --git a/tests/ust/low-throughput/run b/tests/ust/low-throughput/run
index 3f2d1b7..038eff2 100755
--- a/tests/ust/low-throughput/run
+++ b/tests/ust/low-throughput/run
@@ -14,6 +14,7 @@
 # You should have received a copy of the GNU Lesser General Public License
 # along with this library; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+TEST_DESC="UST tracer - Testing low events throughput"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../..
@@ -23,9 +24,7 @@ EVENT_NAME="tp:slow"
 
 source $TESTDIR/utils.sh
 
-echo -e "\n-------------------------------------------"
-echo -e "UST tracer - Testing low events throughput"
-echo -e "-------------------------------------------"
+print_test_banner
 
 if [ ! -x "$CURDIR/$BIN_NAME" ]; then
 	echo -e "No UST nevents binary detected. Passing."
@@ -92,9 +91,9 @@ done
 
 if [ $out -eq 0 ]; then
 	echo -n "Trace is coherent... "
-	echo -e "\e[1;32mOK\e[0m"
+	print_ok
 else
-	echo -e "\e[1;31mFAILED\e[0m"
+	print_fail
 fi
 
 rm -rf $TRACE_PATH
diff --git a/tests/ust/multi-session/run b/tests/ust/multi-session/run
index f6dab7c..f740b57 100755
--- a/tests/ust/multi-session/run
+++ b/tests/ust/multi-session/run
@@ -14,6 +14,7 @@
 # You should have received a copy of the GNU Lesser General Public License
 # along with this library; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+TEST_DESC="UST tracer - Multi-session"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../..
@@ -23,9 +24,7 @@ EVENT_NAME="ust_gen_nevents:tptest"
 
 source $TESTDIR/utils.sh
 
-echo -e "\n--------------------------"
-echo -e "UST tracer - Multi-session"
-echo -e "--------------------------"
+print_test_banner
 
 if [ ! -x "$CURDIR/gen-nevents" ]; then
 	echo -e "No UST nevents binary detected. Passing."
@@ -46,7 +45,7 @@ test_multi_session() {
 
 	echo -n "Starting application generating $NR_ITER events... "
 	./$CURDIR/gen-nevents $NR_ITER &
-	echo -e "\e[1;32mOK\e[0m"
+	print_ok
 
 	# At least hit one event
 	echo -n "Waiting for events to record "
@@ -54,7 +53,7 @@ test_multi_session() {
 		echo -n "."
 		sleep 0.1
 	done
-	echo -e "\e[1;32m OK\e[0m"
+	print_ok
 
 	for i in `seq 0 3`; do
 		stop_tracing "$SESSION_NAME-$i"
@@ -62,11 +61,11 @@ test_multi_session() {
 		out=$(babeltrace "$TRACE_PATH/$i" | grep "$EVENT_NAMEi$i" | wc -l)
 		if [ $out -ne $NR_ITER ]; then
 			echo -n "No event found. Suppose to have at least one... "
-			echo -e "\e[1;31mFAILED\e[0m"
+			print_fail
 			out=1
 		else
 			echo -n "Found $out event(s) for $SESSION_NAME-$i. Coherent... "
-			echo -e "\e[1;32mOK\e[0m"
+			print_ok
 			out=0
 		fi
 	done
diff --git a/tests/ust/nprocesses/run b/tests/ust/nprocesses/run
index 7513fe1..b284fbc 100755
--- a/tests/ust/nprocesses/run
+++ b/tests/ust/nprocesses/run
@@ -14,17 +14,16 @@
 # You should have received a copy of the GNU Lesser General Public License
 # along with this library; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+NR_ITER=100
+TEST_DESC="UST tracer - Generate $NR_ITER process"
 
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../..
-NR_ITER=100
 TEST_BIN_NAME="gen-events-time"
 
 source $TESTDIR/utils.sh
 
-echo -e "\n-------------------------------------"
-echo -e "UST tracer - Generate $NR_ITER process"
-echo -e "---------------------------------------"
+print_test_banner
 
 if [ ! -x "$CURDIR/$TEST_BIN_NAME" ]; then
 	echo -e "No UST $TEST_BIN_NAME binary detected. Passing."
diff --git a/tests/ust/nprocesses/ust-nprocesses b/tests/ust/nprocesses/ust-nprocesses
index eab6d39..7355057 100755
--- a/tests/ust/nprocesses/ust-nprocesses
+++ b/tests/ust/nprocesses/ust-nprocesses
@@ -41,9 +41,10 @@ sleep 3
 listing=$($TESTDIR/../src/bin/lttng/$LTTNG_BIN list -u)
 reg_app_count=$(echo -n $listing | sed "s/$TEST_BIN_NAME/$TEST_BIN_NAME\n/g" | grep "$TEST_BIN_NAME" | wc -l)
 if [ "$reg_app_count" -ne "$NR_ITER" ]; then
-	echo -e "$reg_app_count apps listed. Expected $NR_ITER \e[1;31mFAILED\e[0m"
+	echo -e "$reg_app_count apps listed. Expected $NR_ITER "
+	print_fail
 else
-	echo -e "\e[1;32mOK\e[0m"
+	print_ok
 fi
 
 TRACE_PATH=$(mktemp -d)
@@ -64,5 +65,5 @@ rm -rf $TRACE_PATH
 
 echo -e -n "Killing all spawned applications..."
 killall -q $TEST_BIN_NAME >/dev/null 2>&1 &
-echo -e "\e[1;32mOK\e[0m"
+print_ok
 exit 0
diff --git a/tests/ust/run-ust-global-tests.sh b/tests/ust/run-ust-global-tests.sh
index 969e217..67239c2 100755
--- a/tests/ust/run-ust-global-tests.sh
+++ b/tests/ust/run-ust-global-tests.sh
@@ -35,9 +35,9 @@ function start_tests ()
 	rm -rf $tmpdir
 }
 
-echo -e "\n-------------------------------------------"
-echo -e "UST tracer - Global domain (LTTNG_DOMAIN_UST)"
-echo -e "---------------------------------------------"
+TEST_DESC="UST tracer - Global domain (LTTNG_DOMAIN_UST)"
+
+print_test_banner
 
 start_tests
 
diff --git a/tests/utils.sh b/tests/utils.sh
index 2670de3..70b6607 100644
--- a/tests/utils.sh
+++ b/tests/utils.sh
@@ -99,10 +99,10 @@ function spawn_sessiond ()
 		$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --daemonize --quiet --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
 		#$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --verbose-consumer >>/tmp/sessiond.log 2>&1 &
 		if [ $? -eq 1 ]; then
-			echo -e "\e[1;31mFAILED\e[0m"
+		        print_fail
 			return 1
 		else
-			echo -e "\e[1;32mOK\e[0m"
+		        print_ok
 		fi
 	fi
 
@@ -122,10 +122,10 @@ function lttng_enable_kernel_event
 	echo -n "Enabling kernel event $event_name for session $sess_name"
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $event_name -s $sess_name -k >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
-		echo -e '\e[1;31mFAILED\e[0m'
+		print_fail
 		return 1
 	else
-		echo -e "\e[1;32mOK\e[0m"
+	        print_ok
 	fi
 }
 
@@ -141,13 +141,13 @@ function lttng_start_relayd
 		$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt >/dev/null 2>&1 &
 		#$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt -vvv >>/tmp/relayd.log 2>&1 &
 		if [ $? -eq 1 ]; then
-			echo -e "\e[1;31mFAILED\e[0m"
+		        print_fail
 			return 1
 		else
-			echo -e "\e[1;32mOK\e[0m"
+			print_ok
 		fi
 	else
-		echo -e "\e[1;32mOK\e[0m"
+		print_ok
 	fi
 }
 
@@ -158,7 +158,7 @@ function lttng_stop_relayd
 	echo -e -n "Killing lttng-relayd (pid: $PID_RELAYD)... "
 	kill $PID_RELAYD >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
-		echo -e "\e[1;31mFAILED\e[0m"
+		print_fail
 		return 1
 	else
 		out=1
@@ -166,7 +166,7 @@ function lttng_stop_relayd
 			out=$(pidof lt-$RELAYD_BIN)
 			sleep 0.5
 		done
-		echo -e "\e[1;32mOK\e[0m"
+		print_ok
 		return 0
 	fi
 }
@@ -205,7 +205,7 @@ function stop_sessiond ()
 	echo -e -n "Killing session daemon... "
 	kill $PID_SESSIOND >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
-		echo -e "\e[1;31mFAILED\e[0m"
+		print_fail
 		return 1
 	else
 		out=1
@@ -213,7 +213,7 @@ function stop_sessiond ()
 			out=$(pidof lt-$SESSIOND_BIN)
 			sleep 0.5
 		done
-		echo -e "\e[1;32mOK\e[0m"
+		print_ok
 	fi
 }
 
@@ -225,10 +225,10 @@ function create_lttng_session ()
 	echo -n "Creating lttng session $sess_name in $trace_path "
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN create $sess_name -o $trace_path >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
-		echo -e "\e[1;31mFAILED\e[0m"
+		print_fail
 		return 1
 	else
-		echo -e "\e[1;32mOK\e[0m"
+		print_ok
 	fi
 }
 
@@ -240,10 +240,10 @@ function enable_lttng_channel()
 	echo -n "Enabling lttng channel $channel_name for session $sess_name"
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel $channel_name -s $sess_name >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
-		echo -e "\e[1;31mFAILED\e[0m"
+		print_fail
 		return 1
 	else
-		echo -e "\e[1;32mOK\e[0m"
+		print_ok
 	fi
 }
 
@@ -255,10 +255,10 @@ function disable_lttng_channel()
 	echo -n "Disabling lttng channel $channel_name for session $sess_name"
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-channel $channel_name -s $sess_name >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
-		echo -e "\e[1;31mFAILED\e[0m"
+	        print_fail
 		return 1
 	else
-		echo -e "\e[1;32mOK\e[0m"
+	        print_ok
 	fi
 }
 
@@ -270,10 +270,10 @@ function enable_ust_lttng_event ()
 	echo -n "Enabling lttng event $event_name for session $sess_name "
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $event_name -s $sess_name -u >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
-		echo -e '\e[1;31mFAILED\e[0m'
+		print_fail
 		return 1
 	else
-		echo -e "\e[1;32mOK\e[0m"
+		print_ok
 	fi
 }
 
@@ -284,10 +284,10 @@ function start_tracing ()
 	echo -n "Start lttng tracing for session $sess_name "
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN start $sess_name >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
-		echo -e '\e[1;31mFAILED\e[0m'
+		print_fail
 		return 1
 	else
-		echo -e "\e[1;32mOK\e[0m"
+	        print_ok
 	fi
 }
 
@@ -298,10 +298,10 @@ function stop_tracing ()
 	echo -n "Stop lttng tracing for session $sess_name "
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN stop $sess_name >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
-		echo -e '\e[1;31mFAILED\e[0m'
+		print_fail
 		return 1
 	else
-		echo -e "\e[1;32mOK\e[0m"
+	        print_ok
 	fi
 }
 
@@ -312,10 +312,10 @@ function destroy_lttng_session ()
 	echo -n "Destroy lttng session $sess_name "
 	$TESTDIR/../src/bin/lttng/$LTTNG_BIN destroy $sess_name >/dev/null 2>&1
 	if [ $? -eq 1 ]; then
-		echo -e '\e[1;31mFAILED\e[0m'
+		print_fail
 		return 1
 	else
-		echo -e "\e[1;32mOK\e[0m"
+	        print_ok
 	fi
 }
 
@@ -335,10 +335,12 @@ function trace_matches ()
 
 	count=$($BABELTRACE_BIN $trace_path | grep $event_name | wc -l)
 	if [ "$count" -ne "$nr_iter" ]; then
-		echo -e "$count found in trace \e[1;31mFAILED\e[0m"
+		echo -e "$count found in trace "
+		print_fail
 		return 1
 	else
-		echo -e "Trace is coherent \e[1;32mOK\e[0m"
+		echo -e "Trace is coherent "
+		print_ok
 		return 0
 	fi
 }
@@ -357,10 +359,10 @@ function validate_trace
 	echo -n "Validating trace for event $event_name... "
 	traced=$($BABELTRACE_BIN $trace_path 2>/dev/null | grep $event_name | wc -l)
 	if [ $traced -eq 0 ]; then
-		echo -e "\e[1;31mFAILED\e[0m"
+		print_fail
 		return 1
 	else
-		echo -e "\e[1;32mOK\e[0m"
+		print_ok
 		return 0
 	fi
 }
-- 
1.7.12
