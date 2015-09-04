From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Test kernel filtering
Date: Fri,  4 Sep 2015 19:00:14 -0400
Message-ID: <1441407614-25692-1-git-send-email-mathieu.desnoyers__49176.8407439396$1441407691$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZXzyA-0005sI-UG
 for lttng-dev@lists.lttng.org; Fri, 04 Sep 2015 19:00:33 -0400
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

Requires the new lttng-test.ko lttng-modules test module.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../regression/tools/filtering/test_invalid_filter |  48 ++++-
 .../regression/tools/filtering/test_unsupported_op |  52 ++++-
 tests/regression/tools/filtering/test_valid_filter | 232 +++++++++++++++++----
 tests/utils/babelstats.pl                          |  17 +-
 4 files changed, 282 insertions(+), 67 deletions(-)

diff --git a/tests/regression/tools/filtering/test_invalid_filter b/tests/regression/tools/filtering/test_invalid_filter
index 4ba4b8b..bfc817d 100755
--- a/tests/regression/tools/filtering/test_invalid_filter
+++ b/tests/regression/tools/filtering/test_invalid_filter
@@ -24,17 +24,22 @@ SESSION_NAME="filter-invalid"
 EVENT_NAME="bogus"
 ENABLE_EVENT_STDERR="/tmp/invalid-filters-stderr"
 TRACE_PATH=$(mktemp -d)
-NUM_TESTS=146
+NUM_GLOBAL_TESTS=2
+NUM_UST_TESTS=144
+NUM_KERNEL_TESTS=144
+NUM_TESTS=$(($NUM_UST_TESTS+$NUM_KERNEL_TESTS+$NUM_GLOBAL_TESTS))
 
 source $TESTDIR/utils/utils.sh
 
-function enable_ust_lttng_event_filter
+function enable_lttng_event_filter
 {
-	sess_name="$1"
-	event_name="$2"
-	filter="$3"
+	domain="$1"
+	sess_name="$2"
+	event_name="$3"
+	filter="$4"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $event_name -s $sess_name -u --filter "$filter" 2> $ENABLE_EVENT_STDERR 1> /dev/null
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $event_name -s $sess_name \
+		$domain --filter "$filter" 2> $ENABLE_EVENT_STDERR 1> /dev/null
 
 	# Enable must fail
 	if [ $? -eq 0 ]; then
@@ -48,7 +53,8 @@ function enable_ust_lttng_event_filter
 
 function test_invalid_filter
 {
-	test_invalid_filter="$1"
+	domain="$1"
+	test_invalid_filter="$2"
 
 	diag "Test filter expression with invalid filter"
 	diag "Filter: $test_invalid_filter"
@@ -57,7 +63,7 @@ function test_invalid_filter
 	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
 
 	# Apply filter
-	enable_ust_lttng_event_filter $SESSION_NAME $EVENT_NAME "$test_invalid_filter"
+	enable_lttng_event_filter $domain $SESSION_NAME $EVENT_NAME "$test_invalid_filter"
 
 	# Destroy session
 	destroy_lttng_session_ok $SESSION_NAME
@@ -65,6 +71,8 @@ function test_invalid_filter
 
 function test_bytecode_limit
 {
+	domain="$1"
+
 	# Current bytecode limitation is 65536 bytes long.
 	# Generate a huge bytecode with some perl-fu
 	BYTECODE_LIMIT=`perl -e 'print "intfield" . " && 1" x5460'`
@@ -75,7 +83,7 @@ function test_bytecode_limit
 	create_lttng_session_ok $SESSION_NAME $TRACE_PATH
 
 	# Apply filter
-	enable_ust_lttng_event_filter $SESSION_NAME $EVENT_NAME "$BYTECODE_LIMIT"
+	enable_lttng_event_filter $domain $SESSION_NAME $EVENT_NAME "$BYTECODE_LIMIT"
 
 	# Destroy session
 	destroy_lttng_session_ok $SESSION_NAME
@@ -148,12 +156,30 @@ INVALID_FILTERS=(
 		)
 
 start_lttng_sessiond
+diag "Test UST filters"
 for FILTER in ${INVALID_FILTERS[@]};
 do
-	test_invalid_filter "$FILTER"
+	test_invalid_filter -u "$FILTER"
 done
 
-test_bytecode_limit
+test_bytecode_limit -u
+
+if [ "$(id -u)" == "0" ]; then
+	isroot=1
+else
+	isroot=0
+fi
+
+skip $isroot "Root access is needed. Skipping all kernel invalid filter tests." $NUM_KERNEL_TESTS ||
+{
+	diag "Test kernel filters"
+	for FILTER in ${INVALID_FILTERS[@]};
+	do
+		test_invalid_filter -k "$FILTER"
+	done
+
+	test_bytecode_limit -k
+}
 
 unset IFS
 stop_lttng_sessiond
diff --git a/tests/regression/tools/filtering/test_unsupported_op b/tests/regression/tools/filtering/test_unsupported_op
index 0c8ceb7..985f14e 100755
--- a/tests/regression/tools/filtering/test_unsupported_op
+++ b/tests/regression/tools/filtering/test_unsupported_op
@@ -24,17 +24,22 @@ SESSION_NAME="filter-unsupported-ops"
 EVENT_NAME="bogus"
 ENABLE_EVENT_STDERR="/tmp/unsupported-ops-enable"
 TRACE_PATH=$(mktemp -d)
-NUM_TESTS=46
+NUM_GLOBAL_TESTS=2
+NUM_UST_TESTS=44
+NUM_KERNEL_TESTS=44
+NUM_TESTS=$(($NUM_UST_TESTS+$NUM_KERNEL_TESTS+$NUM_GLOBAL_TESTS))
+
 source $TESTDIR/utils/utils.sh
 
-function enable_ust_lttng_event_filter_unsupported
+function enable_lttng_event_filter_unsupported
 {
-	sess_name=$1
-	event_name=$2
-	filter=$3
+	domain="$1"
+	sess_name="$2"
+	event_name="$3"
+	filter="$4"
 
 	enable_cmd="$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event"
-	$enable_cmd $event_name -s $sess_name -u --filter "$filter" 2> $ENABLE_EVENT_STDERR 1> /dev/null
+	$enable_cmd $event_name -s $sess_name $domain --filter "$filter" 2> $ENABLE_EVENT_STDERR 1> /dev/null
 
 	# Enable must fail
 	if [ $? -eq 0 ]; then
@@ -48,8 +53,9 @@ function enable_ust_lttng_event_filter_unsupported
 
 function test_unsupported_op
 {
-	test_op_str=$1
-	test_op_tkn=$2
+	domain="$1"
+	test_op_str="$2"
+	test_op_tkn="$3"
 
 	diag "Test filter expression with unsupported operator $test_op_str ($test_op_tkn)"
 
@@ -64,7 +70,7 @@ function test_unsupported_op
 	fi
 
 	# Apply filter
-	enable_ust_lttng_event_filter_unsupported $SESSION_NAME $EVENT_NAME "$TEST_FILTER"
+	enable_lttng_event_filter_unsupported $domain $SESSION_NAME $EVENT_NAME "$TEST_FILTER"
 
 	# Test stderr for unsupported operator
 
@@ -93,12 +99,14 @@ OP_STR=("MUL" "DIV" "MOD" "PLUS" "MINUS" "LSHIFT" "RSHIFT"
 OP_TKN=("*" "/" "%" "+" "-" "<<" ">>" "&" "|" "^" "~")
 
 OP_COUNT=${#OP_STR[@]}
-i=0
 
 start_lttng_sessiond
 
+diag "Test UST unsupported filter operations"
+
+i=0
 while [ "$i" -lt "$OP_COUNT" ]; do
-	test_unsupported_op "${OP_STR[$i]}" "${OP_TKN[$i]}"
+	test_unsupported_op -u "${OP_STR[$i]}" "${OP_TKN[$i]}"
 
 	if [ $? -eq 1 ]; then
 		exit 1
@@ -107,6 +115,28 @@ while [ "$i" -lt "$OP_COUNT" ]; do
 	let "i++"
 done
 
+if [ "$(id -u)" == "0" ]; then
+	isroot=1
+else
+	isroot=0
+fi
+
+skip $isroot "Root access is needed. Skipping all kernel unsupported filter operations tests." $NUM_KERNEL_TESTS ||
+{
+	diag "Test kernel unsupported filter operations"
+
+	i=0
+	while [ "$i" -lt "$OP_COUNT" ]; do
+		test_unsupported_op -k "${OP_STR[$i]}" "${OP_TKN[$i]}"
+
+		if [ $? -eq 1 ]; then
+			exit 1
+		fi
+
+		let "i++"
+	done
+}
+
 stop_lttng_sessiond
 
 # Cleanup
diff --git a/tests/regression/tools/filtering/test_valid_filter b/tests/regression/tools/filtering/test_valid_filter
index df4eb47..28347a4 100755
--- a/tests/regression/tools/filtering/test_valid_filter
+++ b/tests/regression/tools/filtering/test_valid_filter
@@ -20,41 +20,51 @@ TEST_DESC="Filtering - Valid filters"
 CURDIR=$(dirname $0)/
 TESTDIR=$CURDIR/../../..
 LTTNG_BIN="lttng"
-BIN_NAME="gen-ust-events"
 STATS_BIN="$TESTDIR/utils/babelstats.pl"
 SESSION_NAME="valid_filter"
-EVENT_NAME="tp:tptest"
 NR_ITER=100
-NUM_TESTS=290
+NUM_GLOBAL_TESTS=2
+NUM_UST_TESTS=288
+NUM_KERNEL_TESTS=288
+NUM_TESTS=$(($NUM_UST_TESTS+$NUM_KERNEL_TESTS+$NUM_GLOBAL_TESTS))
 
 source $TESTDIR/utils/utils.sh
 
-if [ ! -x "$CURDIR/$BIN_NAME" ]; then
-	BAIL_OUT "No UST nevents binary detected."
-fi
-
-function enable_ust_lttng_event_filter()
+function enable_lttng_event_filter()
 {
-	sess_name="$1"
-	event_name="$2"
-	filter="$3"
+	domain="$1"
+	sess_name="$2"
+	event_name="$3"
+	filter="$4"
 
-	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $event_name -s $sess_name -u --filter "$filter" 2>&1 >/dev/null
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event $event_name \
+			-s $sess_name $domain --filter "$filter" 2>&1 >/dev/null
+	$TESTDIR/../src/bin/lttng/$LTTNG_BIN add-context \
+			-s $sess_name $domain -t procname 2>&1 >/dev/null
 
 	ok $? "Enable lttng event with filtering"
 }
 
-function run_apps
+function run_ust
 {
 	./$CURDIR/$BIN_NAME $NR_ITER >/dev/null 2>&1
 }
 
+function run_kernel
+{
+	# Trigger the event for 100 iterations
+	echo -n "100" > /proc/lttng-test-filter-event
+}
+
 function test_valid_filter
 {
-	filter="$1"
-	validator="$2"
+	domain_name="$1"
+	domain="$2"
+	event_name="$3"
+	filter="$4"
+	validator="$5"
 
-	diag "Test valid filter: $1"
+	diag "Test valid $domain_name filter: $filter"
 
 	trace_path=$(mktemp -d)
 
@@ -62,17 +72,17 @@ function test_valid_filter
 	create_lttng_session_ok $SESSION_NAME $trace_path
 
 	# Enable filter
-	enable_ust_lttng_event_filter $SESSION_NAME $EVENT_NAME $filter
+	enable_lttng_event_filter $domain $SESSION_NAME $event_name $filter
 
 	# Trace apps
 	start_lttng_tracing_ok $SESSION_NAME
-	run_apps
+	run_$domain_name
 	stop_lttng_tracing_ok $SESSION_NAME
 
 	# Destroy session
 	destroy_lttng_session_ok $SESSION_NAME
 
-	stats=`babeltrace $trace_path | $STATS_BIN --tracepoint $EVENT_NAME`
+	stats=`babeltrace $trace_path | $STATS_BIN --tracepoint $event_name`
 
 	rm -rf $trace_path
 
@@ -115,11 +125,13 @@ function validator_intfield
 	validate_min_max "$stats" "netintfieldhex" "0x1" "0x63"
 	status=$(($status|$?))
 
-	validate_min_max "$stats" "floatfield" "2222" "2222"
-	status=$(($status|$?))
+	if [ $KERNEL_CHECK -eq 0 ]; then
+		validate_min_max "$stats" "floatfield" "2222" "2222"
+		status=$(($status|$?))
 
-	validate_min_max "$stats" "doublefield" "2" "2"
-	status=$(($status|$?))
+		validate_min_max "$stats" "doublefield" "2" "2"
+		status=$(($status|$?))
+	fi
 
 	return $status
 }
@@ -311,11 +323,13 @@ function validator_true_statement
 	validate_min_max "$stats" "netintfieldhex" "0x0" "0x63"
 	status=$(($status|$?))
 
-	validate_min_max "$stats" "floatfield" "2222" "2222"
-	status=$(($status|$?))
+	if [ $KERNEL_CHECK -eq 0 ]; then
+		validate_min_max "$stats" "floatfield" "2222" "2222"
+		status=$(($status|$?))
 
-	validate_min_max "$stats" "doublefield" "2" "2"
-	status=$(($status|$?))
+		validate_min_max "$stats" "doublefield" "2" "2"
+		status=$(($status|$?))
+	fi
 
 	validate_min_max "$stats" "stringfield" "\"test\"" "\"test\""
 	status=$(($status|$?))
@@ -338,9 +352,15 @@ issue_356_filter+="intfield > 4 && intfield > 5 && "
 issue_356_filter+="intfield > 6 && intfield > 7 && "
 issue_356_filter+="intfield > 8 || intfield > 0"
 
+start_lttng_sessiond
+
+### UST TESTS
+
+BIN_NAME="gen-ust-events"
+
 # One to one mapping between filters and validators
 
-FILTERS=("intfield"                                                     #1
+UST_FILTERS=("intfield"                                                 #1
 	 "intfield > 1"                                                 #2
 	 "intfield >= 1"                                                #3
 	 "intfield < 2"                                                 #4
@@ -390,7 +410,13 @@ FILTERS=("intfield"                                                     #1
 	 "\"*\" == \$ctx.procname"                                      #48
 )
 
-VALIDATOR=("validator_intfield"                     #1
+UST_FILTER_COUNT=${#UST_FILTERS[@]}
+
+if [ ! -x "$CURDIR/$BIN_NAME" ]; then
+	BAIL_OUT "No UST nevents binary detected."
+fi
+
+UST_VALIDATOR=("validator_intfield"                 #1
 	   "validator_intfield_gt"                  #2
 	   "validator_intfield_ge"                  #3
 	   "validator_intfield_lt"                  #4
@@ -440,14 +466,13 @@ VALIDATOR=("validator_intfield"                     #1
 	   "validator_has_events"                   #48
 )
 
-FILTER_COUNT=${#FILTERS[@]}
-i=0
-
-start_lttng_sessiond
+diag "Test UST valid filters"
 
-while [ "$i" -lt "$FILTER_COUNT" ]; do
+KERNEL_CHECK=0
+i=0
+while [ "$i" -lt "$UST_FILTER_COUNT" ]; do
 
-	test_valid_filter "${FILTERS[$i]}" "${VALIDATOR[$i]}"
+	test_valid_filter ust -u "tp:tptest" "${UST_FILTERS[$i]}" "${UST_VALIDATOR[$i]}"
 
 	if [ $? -eq 1 ]; then
 		stop_lttng_sessiond
@@ -457,4 +482,141 @@ while [ "$i" -lt "$FILTER_COUNT" ]; do
 	let "i++"
 done
 
+
+### KERNEL TESTS
+
+BIN_NAME="test_valid_filt"	# Current script name truncated by kernel
+
+# One to one mapping between filters and validators
+
+KERNEL_FILTERS=("intfield"                                              #1
+	 "intfield > 1"                                                 #2
+	 "intfield >= 1"                                                #3
+	 "intfield < 2"                                                 #4
+	 "intfield <= 2"                                                #5
+	 "intfield == 1"                                                #6
+	 "intfield != 99"                                               #7
+	 "!intfield"                                                    #8
+	 "-intfield"                                                    #9
+	 "--intfield"                                                   #10
+	 "+intfield"                                                    #11
+	 "++intfield"                                                   #12
+	 "intfield > 1 && longfield > 42"                               #13
+	 "intfield >= 42 && longfield <= 42"                            #14
+	 "intfield < 1 || longfield > 98"                               #15
+	 "(stringfield == \"test\" || intfield != 10) && intfield > 33" #16
+	 "intfield < 42.4242424242"                                     #17
+	 "\"test\" == \"test\""                                         #18 #Issue #342
+	 "stringfield == \"test\""                                      #19
+	 "stringfield == \"t*\""                                        #20
+	 "stringfield == \"*\""                                         #21
+	 $issue_356_filter                                              #22 #Issue #356
+	 "intfield < 0xDEADBEEF"                                        #23
+	 "intfield < 0x2"                                               #24
+	 "intfield < 02"                                                #25
+	 "stringfield2 == \"\\\*\""                                     #26
+	 "1.0 || intfield || 1.0"                                       #27
+	 "1 < intfield"                                                 #28
+	 "\$ctx.vtid == 0"                                              #29
+	 "\$ctx.vtid != 0"                                              #30
+	 "0 == \$ctx.vtid"                                              #31
+	 "0 != \$ctx.vtid"                                              #32
+	 "\$ctx.vpid == 0"                                              #33
+	 "\$ctx.vpid != 0"                                              #34
+	 "0 == \$ctx.vpid"                                              #35
+	 "0 != \$ctx.vpid"                                              #36
+	 "\$ctx.procname != \"$BIN_NAME\""                              #37
+	 "\$ctx.procname == \"$BIN_NAME\""                              #38
+	 "\"$BIN_NAME\" != \$ctx.procname"                              #39
+	 "\"$BIN_NAME\" == \$ctx.procname"                              #40
+	 "\$ctx.procname != \"$BIN_NAME*\""                             #41
+	 "\$ctx.procname == \"$BIN_NAME*\""                             #42
+	 "\"$BIN_NAME*\" != \$ctx.procname"                             #43
+	 "\"$BIN_NAME*\" == \$ctx.procname"                             #44
+	 "\$ctx.procname != \"*\""                                      #45
+	 "\$ctx.procname == \"*\""                                      #46
+	 "\"*\" != \$ctx.procname"                                      #47
+	 "\"*\" == \$ctx.procname"                                      #48
+)
+
+KERNEL_FILTER_COUNT=${#KERNEL_FILTERS[@]}
+
+KERNEL_VALIDATOR=("validator_intfield"              #1
+	   "validator_intfield_gt"                  #2
+	   "validator_intfield_ge"                  #3
+	   "validator_intfield_lt"                  #4
+	   "validator_intfield_le"                  #5
+	   "validator_intfield_eq"                  #6
+	   "validator_intfield_ne"                  #7
+	   "validator_intfield_not"                 #8
+	   "validator_intfield"                     #9
+	   "validator_intfield"                     #10
+	   "validator_intfield"                     #11
+	   "validator_intfield"                     #12
+	   "validator_intfield_gt_and_longfield_gt" #13
+	   "validator_intfield_ge_and_longfield_le" #14
+	   "validator_intfield_lt_or_longfield_gt"  #15
+	   "validator_mixed_str_or_int_and_int"     #16
+	   "validator_has_no_event"                 #17 #Unsupported by kernel
+	   "validator_true_statement"               #18
+	   "validator_true_statement"               #19
+	   "validator_true_statement"               #20
+	   "validator_true_statement"               #21
+	   "validator_intfield"                     #22
+	   "validator_true_statement"               #23
+	   "validator_intfield_lt"                  #24
+	   "validator_intfield_lt"                  #25
+	   "validator_true_statement"               #26
+	   "validator_has_no_event"                 #27 #Unsupported by kernel
+	   "validator_intfield_gt"                  #28
+	   "validator_has_no_event"                 #29
+	   "validator_has_events"                   #30
+	   "validator_has_no_event"                 #31
+	   "validator_has_events"                   #32
+	   "validator_has_no_event"                 #33
+	   "validator_has_events"                   #34
+	   "validator_has_no_event"                 #35
+	   "validator_has_events"                   #36
+	   "validator_has_no_event"                 #36
+	   "validator_has_events"                   #37
+	   "validator_has_no_event"                 #38
+	   "validator_has_events"                   #39
+	   "validator_has_no_event"                 #41
+	   "validator_has_events"                   #42
+	   "validator_has_no_event"                 #43
+	   "validator_has_events"                   #44
+	   "validator_has_no_event"                 #45
+	   "validator_has_events"                   #46
+	   "validator_has_no_event"                 #47
+	   "validator_has_events"                   #48
+)
+
+if [ "$(id -u)" == "0" ]; then
+	isroot=1
+else
+	isroot=0
+fi
+
+skip $isroot "Root access is needed. Skipping all kernel valid filter tests." $NUM_KERNEL_TESTS ||
+{
+	diag "Test kernel valid filters"
+
+	KERNEL_CHECK=1
+	modprobe lttng-test
+	i=0
+	while [ "$i" -lt "$KERNEL_FILTER_COUNT" ]; do
+
+		test_valid_filter kernel -k "lttng_test_filter_event" \
+				"${KERNEL_FILTERS[$i]}" "${KERNEL_VALIDATOR[$i]}"
+
+		if [ $? -eq 1 ]; then
+			stop_lttng_sessiond
+			exit 1
+		fi
+
+		let "i++"
+	done
+	rmmod lttng-test
+}
+
 stop_lttng_sessiond
diff --git a/tests/utils/babelstats.pl b/tests/utils/babelstats.pl
index 53c85d4..37a9b06 100755
--- a/tests/utils/babelstats.pl
+++ b/tests/utils/babelstats.pl
@@ -92,9 +92,8 @@ sub merge_fields
 	my %merged;
 
 	foreach my $event (@{$events_ref}) {
-		my $tp_provider = $event->{'tp_provider'};
-		my $tp_name     = $event->{'tp_name'};
-		my $tracepoint  = "$tp_provider:$tp_name";
+		my $tp_event     = $event->{'tp_event'};
+		my $tracepoint  = "${tp_event}";
 
 		foreach my $key (keys %{$event->{'fields'}}) {
 			my $val = $event->{'fields'}->{$key};
@@ -148,13 +147,12 @@ while (<>)
 	my $pname       = '.*';
 	my $pinfo       = '.*';
 	my $pid         = '\d+';
-	my $tp_provider = '.*';
-	my $tp_name     = '.*';
+	my $tp_event    = '.*';
 	my $cpu_info    = '{\scpu_id\s=\s(\d+)\s\}';
 	my $fields      = '{(.*)}';
 
 	# Parse babeltrace text output format
-	if (/$timestamp\s$elapsed\s($pinfo)\s($tp_provider):($tp_name):\s$cpu_info,\s$fields/) {
+	if (/$timestamp\s$elapsed\s($pinfo)\s($tp_event):\s$cpu_info,\s$fields/) {
 		my %event_hash;
 		$event_hash{'timestamp'}   = $1;
 		$event_hash{'elapsed'}     = $2;
@@ -165,10 +163,9 @@ while (<>)
 #		$event_hash{'pname'}       = defined($split_pinfo[1]) ? $split_pinfo[1] : undef;
 #		$event_hash{'pid'}         = defined($split_pinfo[2]) ? $split_pinfo[2] : undef;
 
-		$event_hash{'tp_provider'} = $4;
-		$event_hash{'tp_name'}     = $5;
-		$event_hash{'cpu_id'}      = $6;
-		$event_hash{'fields'}      = parse_fields($7);
+		$event_hash{'tp_event'}    = $4;
+		$event_hash{'cpu_id'}      = $5;
+		$event_hash{'fields'}      = parse_fields($6);
 
 		push @events, \%event_hash;
 	}
-- 
2.1.4
