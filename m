From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/6] Improve handling of test
 SIGTERM/SIGINT (v2)
Date: Thu, 16 May 2019 15:07:56 -0400
Message-ID: <20190516190801.16878-1-mathieu.desnoyers__36333.0946116307$1558033705$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 454gtH6lbhzypL
 for <lttng-dev@lists.lttng.org>; Thu, 16 May 2019 15:08:07 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: joraj@efficios.com, jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The current state of signal handling for test scripts is: on
SIGTERM/SIGINT of the tests (e.g. a CTRL-C on the console), session
daemon and relay daemon are killed with SIGKILL, thus leaking all their
resources, and leaving lttng kernel modules loaded.

Revamp the "stop" functions to take a signal number and a timeout
as optional parameters. The default signal number is SIGTERM.

The full_cleanup trap handler now tries to nicely kill relayd and
sessiond (if they are present) with SIGTERM, and wait up to the
user-configurable LTTNG_TEST_TEARDOWN_TIMEOUT environment variable
(which has a default of 60s). Then, if there are still either relayd,
sessiond, or consumerd present, it will SIGKILL them and wait for
them to vanish. If it had to kill sessiond with SIGKILL, it will
also explicitly try to unload the lttng modules with modprobe.

This approach is inspired from sysv init script shutdown behavior.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
Changes since v1:
- Take care of feedback from Jonathan Rajotte,
- Run through shellcheck.
---
 tests/utils/utils.sh | 296 +++++++++++++++++++++++++++++--------------
 1 file changed, 204 insertions(+), 92 deletions(-)

diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index 94b3a3c4..8f6381eb 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -15,14 +15,12 @@
 
 SESSIOND_BIN="lttng-sessiond"
 SESSIOND_MATCH=".*lttng-sess.*"
-SESSIOND_PIDS=""
 RUNAS_BIN="lttng-runas"
 RUNAS_MATCH=".*lttng-runas.*"
 CONSUMERD_BIN="lttng-consumerd"
 CONSUMERD_MATCH=".*lttng-consumerd.*"
 RELAYD_BIN="lttng-relayd"
 RELAYD_MATCH=".*lttng-relayd.*"
-RELAYD_PIDS=""
 LTTNG_BIN="lttng"
 BABELTRACE_BIN="babeltrace"
 OUTPUT_DEST=/dev/null
@@ -48,11 +46,20 @@ export LTTNG_SESSIOND_PATH="/bin/true"
 
 source $TESTDIR/utils/tap/tap.sh
 
+if [ -z $LTTNG_TEST_TEARDOWN_TIMEOUT ]; then
+	LTTNG_TEST_TEARDOWN_TIMEOUT=60
+fi
+
 function full_cleanup ()
 {
-	if [ -n "${SESSIOND_PIDS}" ] || [ -n "${RELAYD_PIDS}" ]; then
-		kill -9 ${SESSIOND_PIDS} ${RELAYD_PIDS} > /dev/null 2>&1
-	fi
+	# Try to kill daemons gracefully
+	stop_lttng_relayd_notap SIGTERM $LTTNG_TEST_TEARDOWN_TIMEOUT
+	stop_lttng_sessiond_notap SIGTERM $LTTNG_TEST_TEARDOWN_TIMEOUT
+
+	# If daemons are still present, forcibly kill them
+	stop_lttng_relayd_notap SIGKILL $LTTNG_TEST_TEARDOWN_TIMEOUT
+	stop_lttng_sessiond_notap SIGKILL $LTTNG_TEST_TEARDOWN_TIMEOUT
+	stop_lttng_consumerd_notap SIGKILL $LTTNG_TEST_TEARDOWN_TIMEOUT
 
 	# Disable trap for SIGTERM since the following kill to the
 	# pidgroup will be SIGTERM. Otherwise it loops.
@@ -379,26 +386,25 @@ function start_lttng_relayd_opt()
 	local withtap=$1
 	local opt=$2
 
-	DIR=$(readlink -f $TESTDIR)
+	DIR=$(readlink -f "$TESTDIR")
 
-	if [ -z $(pgrep $RELAYD_MATCH) ]; then
-		$DIR/../src/bin/lttng-relayd/$RELAYD_BIN -b $opt 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
-		#$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt -vvv >>/tmp/relayd.log 2>&1 &
+	if [ -z "$(pgrep "$RELAYD_MATCH")" ]; then
+		# shellcheck disable=SC2086
+		"$DIR/../src/bin/lttng-relayd/$RELAYD_BIN" -b $opt 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
+		#"$DIR/../src/bin/lttng-relayd/$RELAYD_BIN" $opt -vvv >>/tmp/relayd.log 2>&1 &
 		if [ $? -eq 1 ]; then
-			if [ $withtap -eq "1" ]; then
+			if [ "$withtap" -eq "1" ]; then
 				fail "Start lttng-relayd (opt: $opt)"
 			fi
 			return 1
 		else
-			if [ $withtap -eq "1" ]; then
+			if [ "$withtap" -eq "1" ]; then
 				pass "Start lttng-relayd (opt: $opt)"
 			fi
 		fi
 	else
 		pass "Start lttng-relayd (opt: $opt)"
 	fi
-
-	RELAYD_PIDS=$(pgrep $RELAYD_MATCH)
 }
 
 function start_lttng_relayd()
@@ -414,29 +420,60 @@ function start_lttng_relayd_notap()
 function stop_lttng_relayd_opt()
 {
 	local withtap=$1
+	local signal=$2
 
-	if [ $withtap -eq "1" ]; then
-		diag "Killing lttng-relayd (pid: $RELAYD_PIDS)"
+	if [ -z "$signal" ]; then
+		signal="SIGTERM"
 	fi
-	kill $RELAYD_PIDS 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
-	retval=$?
 
-	if [ $? -eq 1 ]; then
-		if [ $withtap -eq "1" ]; then
+	local timeout_s=$3
+	local dtimeleft_s=
+
+	# Multiply time by 2 to simplify integer arithmetic
+	if [ -n "$timeout_s" ]; then
+		dtimeleft_s=$((timeout_s * 2))
+	fi
+
+	local retval=0
+	local pids=
+
+	pids=$(pgrep "$RELAYD_MATCH")
+	if [ -z "$pids" ]; then
+		if [ "$withtap" -eq "1" ]; then
+			pass "No relay daemon to kill"
+		fi
+		return 0
+	fi
+
+	diag "Killing (signal $signal) lttng-relayd (pid: $pids)"
+
+	# shellcheck disable=SC2086
+	if ! kill -s $signal $pids 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST; then
+		retval=1
+		if [ "$withtap" -eq "1" ]; then
 			fail "Kill relay daemon"
 		fi
-		return 1
 	else
 		out=1
 		while [ -n "$out" ]; do
-			out=$(pgrep $RELAYD_MATCH)
+			out=$(pgrep "$RELAYD_MATCH")
+			if [ -n "$dtimeleft_s" ]; then
+				if [ $dtimeleft_s -lt 0 ]; then
+					out=
+					retval=1
+				fi
+				dtimeleft_s=$((dtimeleft_s - 1))
+			fi
 			sleep 0.5
 		done
-		if [ $withtap -eq "1" ]; then
-			pass "Kill relay daemon"
+		if [ "$withtap" -eq "1" ]; then
+			if [ "$retval" -eq "0" ]; then
+				pass "Wait after kill relay daemon"
+			else
+				fail "Wait after kill relay daemon"
+			fi
 		fi
 	fi
-	RELAYD_PIDS=""
 	return $retval
 }
 
@@ -459,14 +496,16 @@ function start_lttng_sessiond_opt()
 
 	local env_vars=""
 	local consumerd=""
-	local long_bit_value=$(getconf LONG_BIT)
 
-	if [ -n $TEST_NO_SESSIOND ] && [ "$TEST_NO_SESSIOND" == "1" ]; then
+	local long_bit_value=
+	long_bit_value=$(getconf LONG_BIT)
+
+	if [ -n "$TEST_NO_SESSIOND" ] && [ "$TEST_NO_SESSIOND" == "1" ]; then
 		# Env variable requested no session daemon
 		return
 	fi
 
-	DIR=$(readlink -f $TESTDIR)
+	DIR=$(readlink -f "$TESTDIR")
 
 	# Get long_bit value for 32/64 consumerd
 	case "$long_bit_value" in
@@ -483,32 +522,33 @@ function start_lttng_sessiond_opt()
 
 	# Check for env. variable. Allow the use of LD_PRELOAD etc.
 	if [[ "x${LTTNG_SESSIOND_ENV_VARS}" != "x" ]]; then
-		env_vars=${LTTNG_SESSIOND_ENV_VARS}
+		env_vars="${LTTNG_SESSIOND_ENV_VARS} "
 	fi
+	env_vars="${env_vars}$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN"
 
-	validate_kernel_version
-	if [ $? -ne 0 ]; then
+	if ! validate_kernel_version; then
 	    fail "Start session daemon"
 	    BAIL_OUT "*** Kernel too old for session daemon tests ***"
 	fi
 
-	: ${LTTNG_SESSION_CONFIG_XSD_PATH=${DIR}/../src/common/config/}
+	: "${LTTNG_SESSION_CONFIG_XSD_PATH="${DIR}/../src/common/config/"}"
 	export LTTNG_SESSION_CONFIG_XSD_PATH
 
-	if [ -z $(pgrep ${SESSIOND_MATCH}) ]; then
+	if [ -z "$(pgrep "${SESSIOND_MATCH}")" ]; then
 		# Have a load path ?
 		if [ -n "$load_path" ]; then
-			env $env_vars $DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --load "$load_path" --background $consumerd
+			# shellcheck disable=SC2086
+			env $env_vars --load "$load_path" --background "$consumerd"
 		else
-			env $env_vars $DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background $consumerd
+			# shellcheck disable=SC2086
+			env $env_vars --background "$consumerd"
 		fi
 		#$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --verbose-consumer >>/tmp/sessiond.log 2>&1
 		status=$?
-		if [ $withtap -eq "1" ]; then
+		if [ "$withtap" -eq "1" ]; then
 			ok $status "Start session daemon"
 		fi
 	fi
-	SESSIOND_PIDS=$(pgrep $SESSIOND_MATCH)
 }
 
 function start_lttng_sessiond()
@@ -525,44 +565,98 @@ function stop_lttng_sessiond_opt()
 {
 	local withtap=$1
 	local signal=$2
-	local kill_opt=""
 
-	if [ -n $TEST_NO_SESSIOND ] && [ "$TEST_NO_SESSIOND" == "1" ]; then
+	if [ -z "$signal" ]; then
+		signal=SIGTERM
+	fi
+
+	local timeout_s=$3
+	local dtimeleft_s=
+
+	# Multiply time by 2 to simplify integer arithmetic
+	if [ -n "$timeout_s" ]; then
+		dtimeleft_s=$((timeout_s * 2))
+	fi
+
+	if [ -n "$TEST_NO_SESSIOND" ] && [ "$TEST_NO_SESSIOND" == "1" ]; then
 		# Env variable requested no session daemon
-		return
+		return 0
 	fi
 
-	local pids="${SESSIOND_PIDS} $(pgrep $RUNAS_MATCH)"
+	local retval=0
 
-	if [ -n "$2" ]; then
-		kill_opt="$kill_opt -s $signal"
+	local runas_pids=
+	runas_pids=$(pgrep "$RUNAS_MATCH")
+
+	local pids=
+	pids=$(pgrep "$SESSIOND_MATCH")
+
+	if [ -n "$runas_pids" ]; then
+		pids="$pids $runas_pids"
 	fi
-	if [ $withtap -eq "1" ]; then
-		diag "Killing $SESSIOND_BIN and lt-$SESSIOND_BIN pids: $(echo $pids | tr '\n' ' ')"
+
+	if [ -z "$pids" ]; then
+		if [ "$withtap" -eq "1" ]; then
+			pass "No session daemon to kill"
+		fi
+		return 0
 	fi
-	kill $kill_opt $pids 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 
-	if [ $? -eq 1 ]; then
-		if [ $withtap -eq "1" ]; then
+	diag "Killing (signal $signal) $SESSIOND_BIN and lt-$SESSIOND_BIN pids: $(echo "$pids" | tr '\n' ' ')"
+
+	# shellcheck disable=SC2086
+	if ! kill -s $signal $pids 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST; then
+		retval=1
+		if [ "$withtap" -eq "1" ]; then
 			fail "Kill sessions daemon"
 		fi
 	else
 		out=1
 		while [ -n "$out" ]; do
-			out=$(pgrep ${SESSIOND_MATCH})
+			out=$(pgrep "${SESSIOND_MATCH}")
+			if [ -n "$dtimeleft_s" ]; then
+				if [ $dtimeleft_s -lt 0 ]; then
+					out=
+					retval=1
+				fi
+				dtimeleft_s=$((dtimeleft_s - 1))
+			fi
 			sleep 0.5
 		done
 		out=1
 		while [ -n "$out" ]; do
-			out=$(pgrep $CONSUMERD_MATCH)
+			out=$(pgrep "$CONSUMERD_MATCH")
+			if [ -n "$dtimeleft_s" ]; then
+				if [ $dtimeleft_s -lt 0 ]; then
+					out=
+					retval=1
+				fi
+				dtimeleft_s=$((dtimeleft_s - 1))
+			fi
 			sleep 0.5
 		done
 
-		SESSIOND_PIDS=""
-		if [ $withtap -eq "1" ]; then
-			pass "Kill session daemon"
+		if [ "$withtap" -eq "1" ]; then
+			if [ "$retval" -eq "0" ]; then
+				pass "Wait after kill session daemon"
+			else
+				fail "Wait after kill session daemon"
+			fi
 		fi
 	fi
+	if [ "$signal" = "SIGKILL" ]; then
+		if [ "$(id -u)" -eq "0" ]; then
+			local modules=
+			modules="$(lsmod | grep ^lttng | awk '{print $1}')"
+
+			if [ -n "$modules" ]; then
+				diag "Unloading all LTTng modules"
+				modprobe -r "$modules"
+			fi
+		fi
+	fi
+
+	return $retval
 }
 
 function stop_lttng_sessiond()
@@ -579,43 +673,40 @@ function sigstop_lttng_sessiond_opt()
 {
 	local withtap=$1
 	local signal=SIGSTOP
-	local kill_opt=""
 
-	if [ -n $TEST_NO_SESSIOND ] && [ "$TEST_NO_SESSIOND" == "1" ]; then
+	if [ -n "$TEST_NO_SESSIOND" ] && [ "$TEST_NO_SESSIOND" == "1" ]; then
 		# Env variable requested no session daemon
 		return
 	fi
 
-	PID_SESSIOND="$(pgrep ${SESSIOND_MATCH}) $(pgrep $RUNAS_MATCH)"
-
-	kill_opt="$kill_opt -s $signal"
+	PID_SESSIOND="$(pgrep "${SESSIOND_MATCH}") $(pgrep "$RUNAS_MATCH")"
 
-	if [ $withtap -eq "1" ]; then
-		diag "Sending SIGSTOP to lt-$SESSIOND_BIN and $SESSIOND_BIN pids: $(echo $PID_SESSIOND | tr '\n' ' ')"
+	if [ "$withtap" -eq "1" ]; then
+		diag "Sending SIGSTOP to lt-$SESSIOND_BIN and $SESSIOND_BIN pids: $(echo "$PID_SESSIOND" | tr '\n' ' ')"
 	fi
-	kill $kill_opt $PID_SESSIOND 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 
-	if [ $? -eq 1 ]; then
-		if [ $withtap -eq "1" ]; then
+	# shellcheck disable=SC2086
+	if ! kill -s $signal $PID_SESSIOND 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST; then
+		if [ "$withtap" -eq "1" ]; then
 			fail "Sending SIGSTOP to session daemon"
 		fi
 	else
 		out=1
 		while [ $out -ne 0 ]; do
-			pid=$(pgrep $SESSIOND_MATCH)
+			pid="$(pgrep "$SESSIOND_MATCH")"
 
 			# Wait until state becomes stopped for session
 			# daemon(s).
 			out=0
 			for sessiond_pid in $pid; do
-				state=$(ps -p $sessiond_pid -o state= )
+				state="$(ps -p "$sessiond_pid" -o state= )"
 				if [[ -n "$state" && "$state" != "T" ]]; then
 					out=1
 				fi
 			done
 			sleep 0.5
 		done
-		if [ $withtap -eq "1" ]; then
+		if [ "$withtap" -eq "1" ]; then
 			pass "Sending SIGSTOP to session daemon"
 		fi
 	fi
@@ -635,46 +726,70 @@ function stop_lttng_consumerd_opt()
 {
 	local withtap=$1
 	local signal=$2
-	local kill_opt=""
 
-	PID_CONSUMERD=$(pgrep $CONSUMERD_MATCH)
+	if [ -z "$signal" ]; then
+		signal=SIGTERM
+	fi
+
+	local timeout_s=$3
+	local dtimeleft_s=
 
-	if [ -n "$2" ]; then
-		kill_opt="$kill_opt -s $signal"
+	# Multiply time by 2 to simplify integer arithmetic
+	if [ -n "$timeout_s" ]; then
+		dtimeleft_s=$((timeout_s * 2))
 	fi
 
-	if [ $withtap -eq "1" ]; then
-		diag "Killing $CONSUMERD_BIN pids: $(echo $PID_CONSUMERD | tr '\n' ' ')"
+	local retval=0
+
+	PID_CONSUMERD="$(pgrep "$CONSUMERD_MATCH")"
+
+	if [ -z "$PID_CONSUMERD" ]; then
+		if [ "$withtap" -eq "1" ]; then
+			pass "No consumer daemon to kill"
+		fi
+		return 0
 	fi
 
-	kill $kill_opt $PID_CONSUMERD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
-	retval=$?
+	diag "Killing (signal $signal) $CONSUMERD_BIN pids: $(echo "$PID_CONSUMERD" | tr '\n' ' ')"
 
-	if [ $? -eq 1 ]; then
-		if [ $withtap -eq "1" ]; then
+	# shellcheck disable=SC2086
+	if ! kill -s $signal $PID_CONSUMERD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST; then
+		retval=1
+		if [ "$withtap" -eq "1" ]; then
 			fail "Kill consumer daemon"
 		fi
-		return 1
 	else
 		out=1
 		while [ $out -ne 0 ]; do
-			pid=$(pgrep $CONSUMERD_MATCH)
+			pid="$(pgrep "$CONSUMERD_MATCH")"
 
 			# If consumerds are still present check their status.
 			# A zombie status qualifies the consumerd as *killed*
 			out=0
 			for consumer_pid in $pid; do
-				state=$(ps -p $consumer_pid -o state= )
+				state="$(ps -p "$consumer_pid" -o state= )"
 				if [[ -n "$state" && "$state" != "Z" ]]; then
 					out=1
 				fi
 			done
+			if [ -n "$dtimeleft_s" ]; then
+				if [ $dtimeleft_s -lt 0 ]; then
+					out=0
+					retval=1
+				fi
+				dtimeleft_s=$((dtimeleft_s - 1))
+			fi
 			sleep 0.5
 		done
-		if [ $withtap -eq "1" ]; then
-			pass "Kill consumer daemon"
+		if [ "$withtap" -eq "1" ]; then
+			if [ "$retval" -eq "0" ]; then
+				pass "Wait after kill consumer daemon"
+			else
+				fail "Wait after kill consumer daemon"
+			fi
 		fi
 	fi
+
 	return $retval
 }
 
@@ -692,40 +807,37 @@ function sigstop_lttng_consumerd_opt()
 {
 	local withtap=$1
 	local signal=SIGSTOP
-	local kill_opt=""
 
-	PID_CONSUMERD=$(pgrep $CONSUMERD_MATCH)
+	PID_CONSUMERD="$(pgrep "$CONSUMERD_MATCH")"
 
-	kill_opt="$kill_opt -s $signal"
+	diag "Sending SIGSTOP to $CONSUMERD_BIN pids: $(echo "$PID_CONSUMERD" | tr '\n' ' ')"
 
-	if [ $withtap -eq "1" ]; then
-		diag "Sending SIGSTOP to $CONSUMERD_BIN pids: $(echo $PID_CONSUMERD | tr '\n' ' ')"
-	fi
-	kill $kill_opt $PID_CONSUMERD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
+	# shellcheck disable=SC2086
+	kill -s $signal $PID_CONSUMERD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
 	retval=$?
 
-	if [ $? -eq 1 ]; then
-		if [ $withtap -eq "1" ]; then
+	if [ $retval -eq 1 ]; then
+		if [ "$withtap" -eq "1" ]; then
 			fail "Sending SIGSTOP to consumer daemon"
 		fi
 		return 1
 	else
 		out=1
 		while [ $out -ne 0 ]; do
-			pid=$(pgrep $CONSUMERD_MATCH)
+			pid="$(pgrep "$CONSUMERD_MATCH")"
 
 			# Wait until state becomes stopped for all
 			# consumers.
 			out=0
 			for consumer_pid in $pid; do
-				state=$(ps -p $consumer_pid -o state= )
+				state="$(ps -p "$consumer_pid" -o state= )"
 				if [[ -n "$state" && "$state" != "T" ]]; then
 					out=1
 				fi
 			done
 			sleep 0.5
 		done
-		if [ $withtap -eq "1" ]; then
+		if [ "$withtap" -eq "1" ]; then
 			pass "Sending SIGSTOP to consumer daemon"
 		fi
 	fi
-- 
2.17.1
