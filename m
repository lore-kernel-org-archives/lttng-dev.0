From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: filter tests now accept "." in
	identifiers
Date: Sat, 13 Feb 2016 11:18:27 -0500
Message-ID: <1455380307-5061-1-git-send-email-mathieu.desnoyers__36151.3080228635$1455380373$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1aUcu7-00034A-Fu
 for lttng-dev@lists.lttng.org; Sat, 13 Feb 2016 11:18:40 -0500
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../regression/tools/filtering/test_invalid_filter | 13 ++-------
 tests/regression/tools/filtering/test_valid_filter | 32 ++++++++++++++++++++--
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/tests/regression/tools/filtering/test_invalid_filter b/tests/regression/tools/filtering/test_invalid_filter
index bfc817d..9df5f2c 100755
--- a/tests/regression/tools/filtering/test_invalid_filter
+++ b/tests/regression/tools/filtering/test_invalid_filter
@@ -25,8 +25,8 @@ EVENT_NAME="bogus"
 ENABLE_EVENT_STDERR="/tmp/invalid-filters-stderr"
 TRACE_PATH=$(mktemp -d)
 NUM_GLOBAL_TESTS=2
-NUM_UST_TESTS=144
-NUM_KERNEL_TESTS=144
+NUM_UST_TESTS=123
+NUM_KERNEL_TESTS=123
 NUM_TESTS=$(($NUM_UST_TESTS+$NUM_KERNEL_TESTS+$NUM_GLOBAL_TESTS))
 
 source $TESTDIR/utils/utils.sh
@@ -117,14 +117,10 @@ INVALID_FILTERS=(
 		# Unmatched parenthesis
 		"((((((((((((((intfield)))))))))))))"
 		'0 || ("abc" != "def")) && (3 < 4)'
-		# Field dereference
-		"a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a"
 		"a->"
 		"a-->a"
 		"a->a"
 		"a.b.c->d.e.f+1"
-		"!a.f.d"
-		"asdf.asdfsd.sadf < 4"
 		"asdfasdf->asdfasdf < 2"
 		# String can\'t be root node
 		"\"somestring\""
@@ -141,11 +137,6 @@ INVALID_FILTERS=(
 		# Nesting of binary operator not allowed
 		"1 | (1 | (1 | 1))"
 		"1 > (1 > (1 > 1))"
-		# Exactly one chaining level under \$ctx allowed
-		"\$ctx.vtid.blah == 0"
-		"0 == \$ctx.vtid.blah"
-		"\$ctx.44 == 0"
-		"0 == \$ctx.44"
 		"\$ctx == 0"
 		"0 == \$ctx"
 		# Only \$ctx is supported for now
diff --git a/tests/regression/tools/filtering/test_valid_filter b/tests/regression/tools/filtering/test_valid_filter
index 28347a4..0a3a5a4 100755
--- a/tests/regression/tools/filtering/test_valid_filter
+++ b/tests/regression/tools/filtering/test_valid_filter
@@ -24,8 +24,8 @@ STATS_BIN="$TESTDIR/utils/babelstats.pl"
 SESSION_NAME="valid_filter"
 NR_ITER=100
 NUM_GLOBAL_TESTS=2
-NUM_UST_TESTS=288
-NUM_KERNEL_TESTS=288
+NUM_UST_TESTS=330
+NUM_KERNEL_TESTS=330
 NUM_TESTS=$(($NUM_UST_TESTS+$NUM_KERNEL_TESTS+$NUM_GLOBAL_TESTS))
 
 source $TESTDIR/utils/utils.sh
@@ -408,6 +408,13 @@ UST_FILTERS=("intfield"                                                 #1
 	 "\$ctx.procname == \"*\""                                      #46
 	 "\"*\" != \$ctx.procname"                                      #47
 	 "\"*\" == \$ctx.procname"                                      #48
+	 "!a.f.d"							#49
+	 "a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a"			#50
+	 "\$ctx.vtid.blah == 0"						#51
+	 "asdf.asdfsd.sadf < 4"						#52
+	 "0 == \$ctx.vtid.blah"						#53
+	 "\$ctx.44 == 0"						#54
+	 "0 == \$ctx.44"						#55
 )
 
 UST_FILTER_COUNT=${#UST_FILTERS[@]}
@@ -464,6 +471,13 @@ UST_VALIDATOR=("validator_intfield"                 #1
 	   "validator_has_events"                   #46
 	   "validator_has_no_event"                 #47
 	   "validator_has_events"                   #48
+	   "validator_has_no_event"                 #49
+	   "validator_has_no_event"                 #50
+	   "validator_has_no_event"                 #51
+	   "validator_has_no_event"                 #52
+	   "validator_has_no_event"                 #53
+	   "validator_has_no_event"                 #54
+	   "validator_has_no_event"                 #55
 )
 
 diag "Test UST valid filters"
@@ -537,6 +551,13 @@ KERNEL_FILTERS=("intfield"                                              #1
 	 "\$ctx.procname == \"*\""                                      #46
 	 "\"*\" != \$ctx.procname"                                      #47
 	 "\"*\" == \$ctx.procname"                                      #48
+	 "!a.f.d"							#49
+	 "a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a"			#50
+	 "\$ctx.vtid.blah == 0"						#51
+	 "asdf.asdfsd.sadf < 4"						#52
+	 "0 == \$ctx.vtid.blah"						#53
+	 "\$ctx.44 == 0"						#54
+	 "0 == \$ctx.44"						#55
 )
 
 KERNEL_FILTER_COUNT=${#KERNEL_FILTERS[@]}
@@ -589,6 +610,13 @@ KERNEL_VALIDATOR=("validator_intfield"              #1
 	   "validator_has_events"                   #46
 	   "validator_has_no_event"                 #47
 	   "validator_has_events"                   #48
+	   "validator_has_no_event"                 #49
+	   "validator_has_no_event"                 #50
+	   "validator_has_no_event"                 #51
+	   "validator_has_no_event"                 #52
+	   "validator_has_no_event"                 #53
+	   "validator_has_no_event"                 #54
+	   "validator_has_no_event"                 #55
 )
 
 if [ "$(id -u)" == "0" ]; then
-- 
2.1.4
