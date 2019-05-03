From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/9] Fix: tests: error handling in
 high throughput limits test
Date: Fri,  3 May 2019 09:55:40 -0400
Message-ID: <20190503135547.12968-3-mathieu.desnoyers__45105.5454251886$1556910932$gmane$org@efficios.com>
References: <20190503135547.12968-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44wYZC3dBlz1Kbn
 for <lttng-dev@lists.lttng.org>; Fri,  3 May 2019 09:56:03 -0400 (EDT)
In-Reply-To: <20190503135547.12968-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Each individual call to "tc" should be checked for error, else we
may fail to catch specific tc errors caused, for instance, by a
kernel configuration that only contains some of the required
class modules.

Also, invoke the utils.sh full_cleanup function from the script-specific
interrupt_cleanup trap handler rather than try to perform stopping
of relayd and sessiond within the script.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../tools/streaming/test_high_throughput_limits    | 32 ++++++++++++++++++----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tests/regression/tools/streaming/test_high_throughput_limits b/tests/regression/tools/streaming/test_high_throughput_limits
index 32c3f1f2..68973c73 100755
--- a/tests/regression/tools/streaming/test_high_throughput_limits
+++ b/tests/regression/tools/streaming/test_high_throughput_limits
@@ -51,28 +51,47 @@ function set_bw_limit
 	# parent qdisc (1:) will always limit us to the right max value
 	dataportlimit=$((9*${ctrlportlimit}))
 
+	diag "Set bandwidth limits to ${limit}kbits, ${ctrlportlimit} for control and ${dataportlimit} for data"
 
 	tc qdisc add dev $DEFAULT_IF root handle 1: htb default 15 >/dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		return 1
+	fi
 
 	# the total bandwidth is the limit set by the user
 	tc class add dev $DEFAULT_IF parent 1: classid 1:1 htb rate ${limit}kbit ceil ${limit}kbit >/dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		return 1
+	fi
 	# 1/10 of the bandwidth guaranteed and traffic prioritized for the control port
 	tc class add dev $DEFAULT_IF parent 1:1 classid 1:10 htb rate ${ctrlportlimit}kbit ceil ${limit}kbit prio 1 >/dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		return 1
+	fi
 	# 9/10 of the bandwidth guaranteed and can borrow up to the total bandwidth (if unused)
 	tc class add dev $DEFAULT_IF parent 1:1 classid 1:11 htb rate ${dataportlimit}kbit ceil ${limit}kbit prio 2 >/dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		return 1
+	fi
 
 	# filter to assign control traffic to the 1:10 class
 	tc filter add dev $DEFAULT_IF parent 1: protocol ip u32 match ip dport $SESSIOND_CTRL_PORT 0xffff flowid 1:10 >/dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		return 1
+	fi
 	# filter to assign data traffic to the 1:11 class
 	tc filter add dev $DEFAULT_IF parent 1: protocol ip u32 match ip dport $SESSIOND_DATA_PORT 0xffff flowid 1:11 >/dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		return 1
+	fi
 
-	ok $? "Set bandwidth limits to ${limit}kbits, ${ctrlportlimit} for control and ${dataportlimit} for data"
+	return 0
 }
 
 function reset_bw_limit
 {
 	tc qdisc del dev $DEFAULT_IF root >/dev/null 2>&1
-	ok $? "Reset bandwith limits"
+	return $?
 }
 
 function create_lttng_session_with_uri
@@ -148,9 +167,9 @@ function validate_event_count
 function interrupt_cleanup()
 {
 	diag "*** Exiting ***"
-	stop_lttng_relayd
-	stop_lttng_sessiond
 	reset_bw_limit
+	# invoke utils cleanup
+	full_cleanup
 	exit 1
 }
 
@@ -168,8 +187,7 @@ skip $isroot "Root access is needed to set bandwith limits. Skipping all tests."
 {
 
 	# Catch sigint and try to cleanup limits
-	trap interrupt_cleanup SIGTERM
-	trap interrupt_cleanup SIGINT
+	trap interrupt_cleanup SIGTERM SIGINT
 
 	BW_LIMITS=(3200 1600 800 400 200 100 50 25)
 	for BW in ${BW_LIMITS[@]};
@@ -177,6 +195,7 @@ skip $isroot "Root access is needed to set bandwith limits. Skipping all tests."
 		diag "Test high-throughput with bandwidth limit set to ${BW}kbits"
 
 		set_bw_limit $BW
+		ok $? "Setting bandwidth limit"
 
 		start_lttng_sessiond
 		start_lttng_relayd "-o $TRACE_PATH"
@@ -185,5 +204,6 @@ skip $isroot "Root access is needed to set bandwith limits. Skipping all tests."
 		stop_lttng_relayd
 		stop_lttng_sessiond
 		reset_bw_limit
+		ok $? "Reset bandwith limits"
 	done
 }
-- 
2.11.0
