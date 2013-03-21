From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 2/6] Tests: Fix missing TAP output
	in overlap test
Date: Thu, 21 Mar 2013 15:56:43 -0400
Message-ID: <1363895807-17892-2-git-send-email-christian.babeux__27399.0290974782$1363895890$gmane$org@efficios.com>
References: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UIlc1-0006hJ-HG
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 15:57:21 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so992583iec.33
	for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2013 12:57:16 -0700 (PDT)
In-Reply-To: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
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

The start and stop tracing shell functions are currently redirected to
/dev/null. This has the unfortunate side-effect of silencing the TAP
output thus producing an incomplete test output.

This commit remove the /dev/null redirection of those commands.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/regression/ust/overlap/test_overlap | 104 ++++++++++++++----------------
 1 file changed, 50 insertions(+), 54 deletions(-)

diff --git a/tests/regression/ust/overlap/test_overlap b/tests/regression/ust/overlap/test_overlap
index 4e0d90c..e823072 100755
--- a/tests/regression/ust/overlap/test_overlap
+++ b/tests/regression/ust/overlap/test_overlap
@@ -88,11 +88,11 @@ test_enable_simple_wildcard()
 	enable_ust_lttng_event $SESSION_NAME "$event_wild1"
 	enable_ust_lttng_event $SESSION_NAME "$event_wild2"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_all_demo_events
 
@@ -110,11 +110,11 @@ test_enable_wildcard_filter()
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild1" "1==1"
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild2" "1==0"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_all_demo_events
 	return $?
@@ -131,11 +131,11 @@ test_enable_wildcard_filter_2()
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild1" "1==0"
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild2" "1==1"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_all_demo_events
 	return $?
@@ -152,11 +152,11 @@ test_enable_wildcard_filter_3()
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild1" "1==1"
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild2" "1==1"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_all_demo_events
 	return $?
@@ -173,11 +173,11 @@ test_enable_wildcard_filter_4()
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild1" "1==0"
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild2" "1==0"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_no_demo_events
 	return $?
@@ -194,11 +194,11 @@ test_enable_wildcard_filter_5()
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild1" "1==1"
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild2" "1==0"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_all_demo_events
 	return $?
@@ -215,11 +215,11 @@ test_enable_wildcard_filter_6()
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild1" "1==0"
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild2" "1==1"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_matches $DEMO_EVENT1 $NUM_DEMO1_EVENT $TRACE_PATH
 	trace_matches $DEMO_EVENT1_2 0 $TRACE_PATH
@@ -239,11 +239,11 @@ test_enable_wildcard_filter_7()
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild1" "1==1"
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild2" "1==1"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_all_demo_events
 	return $?
@@ -260,11 +260,11 @@ test_enable_wildcard_filter_8()
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild1" "1==0"
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild2" "1==0"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_no_demo_events
 	return $?
@@ -281,11 +281,11 @@ test_enable_same_wildcard_filter()
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild1" "1==1&&1==1"
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild2" "1==1"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_all_demo_events
 	return $?
@@ -309,11 +309,11 @@ test_enable_same_wildcard_filter_2()
 	    fail "Enable event $event_name with filtering for session $sess_name twice failure NOT detected"
 	fi
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_all_demo_events
 	return $?
@@ -330,11 +330,11 @@ test_enable_same_wildcard_filter_3()
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild1" "1==1"
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild2" "1==0"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_all_demo_events
 	return $?
@@ -351,11 +351,11 @@ test_enable_same_wildcard_filter_4()
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild1" "1==0&&1==0"
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild2" "1==0"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_no_demo_events
 	return $?
@@ -372,11 +372,11 @@ test_enable_same_event_filter()
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild1" "1==1&&1==1"
 	enable_ust_lttng_event_filter $SESSION_NAME "$event_wild2" "1==1"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_matches $DEMO_EVENT1 $NUM_DEMO1_EVENT $TRACE_PATH
 	trace_matches $DEMO_EVENT1_2 0 $TRACE_PATH
@@ -398,11 +398,11 @@ test_disable_same_wildcard_filter()
 
 	disable_ust_lttng_event $SESSION_NAME "ust*"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_no_demo_events
 	return $?
@@ -422,11 +422,11 @@ test_enable_bad_wildcard()
 	enable_ust_lttng_event $SESSION_NAME "$event_wild2"
 	enable_ust_lttng_event $SESSION_NAME "$event_wild3"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_no_demo_events
 	return $?
@@ -443,11 +443,11 @@ test_enable_simple_wildcard_2()
 	enable_ust_lttng_event $SESSION_NAME "$event_wild1"
 	enable_ust_lttng_event $SESSION_NAME "$event_wild2"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_all_demo_events
 	return $?
@@ -464,11 +464,11 @@ test_enable_loglevel_overlap()
 	enable_ust_lttng_event_loglevel $SESSION_NAME "$event_wild1" "TRACE_WARNING"
 	enable_ust_lttng_event_loglevel $SESSION_NAME "$event_wild2" "TRACE_CRIT"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_all_demo_events
 	return $?
@@ -485,11 +485,11 @@ test_enable_loglevel_only_overlap()
 	enable_ust_lttng_event_loglevel $SESSION_NAME "$event_wild1" "TRACE_WARNING"
 	enable_ust_lttng_event_loglevel_only $SESSION_NAME "$event_wild2" "TRACE_CRIT"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_all_demo_events
 	return $?
@@ -506,11 +506,11 @@ test_enable_loglevel_overlap_2()
 	enable_ust_lttng_event_loglevel $SESSION_NAME "$event_wild1" "TRACE_WARNING"
 	enable_ust_lttng_event_loglevel $SESSION_NAME "$event_wild2" "TRACE_CRIT"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_all_demo_events
 	return $?
@@ -527,11 +527,11 @@ test_enable_same_wildcard_loglevels()
 	enable_ust_lttng_event_loglevel $SESSION_NAME "$event_wild1" "TRACE_CRIT"
 	enable_ust_lttng_event_loglevel $SESSION_NAME "$event_wild2" "TRACE_WARNING"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_match_all_demo_events
 	return $?
@@ -548,11 +548,11 @@ test_enable_same_event_loglevels()
 	enable_ust_lttng_event_loglevel $SESSION_NAME "$event_wild1" "TRACE_CRIT"
 	enable_ust_lttng_event_loglevel $SESSION_NAME "$event_wild2" "TRACE_WARNING"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	trace_matches $DEMO_EVENT1 $NUM_DEMO1_EVENT $TRACE_PATH
 	trace_matches $DEMO_EVENT1_2 0 $TRACE_PATH
@@ -575,11 +575,11 @@ test_disable_simple_wildcard()
 	disable_ust_lttng_event $SESSION_NAME "$event_wild1"
 	disable_ust_lttng_event $SESSION_NAME "$event_wild2"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	# No events are expected.
 	trace_match_no_demo_events
@@ -599,11 +599,11 @@ test_disable_wildcard_overlap()
 
 	disable_ust_lttng_event $SESSION_NAME "$event_wild1"
 
-	start_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	start_lttng_tracing $SESSION_NAME
 
 	run_demo_app
 
-	stop_lttng_tracing $SESSION_NAME >/dev/null 2>&1
+	stop_lttng_tracing $SESSION_NAME
 
 	# Expect only "ust_tests_demo" events.
 	trace_matches "$DEMO_EVENT1" $NUM_DEMO1_EVENT $TRACE_PATH
@@ -650,16 +650,12 @@ while [ "$i" -lt "$TEST_COUNT" ]; do
 
 	TRACE_PATH=$(mktemp -d)
 
-	create_lttng_session $SESSION_NAME $TRACE_PATH >/dev/null 2>&1
+	create_lttng_session $SESSION_NAME $TRACE_PATH
 
 	# Execute test
 	${TESTS[$i]}
-	if [ $? -ne 0 ]; then
-		stop_lttng_sessiond
-		exit 1
-	fi
 
-	destroy_lttng_session $SESSION_NAME >/dev/null 2>&1
+	destroy_lttng_session $SESSION_NAME
 
 	rm -rf $TRACE_PATH
 
-- 
1.8.1.3
