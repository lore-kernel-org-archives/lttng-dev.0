Return-Path: <SRS0=sJ7O=7L=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C62C433E0
	for <lttng-dev@archiver.kernel.org>; Fri, 29 May 2020 16:56:50 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D832075A
	for <lttng-dev@archiver.kernel.org>; Fri, 29 May 2020 16:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="B/LEBS1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D832075A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49YW1r0pkbz1Jyj;
	Fri, 29 May 2020 12:56:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1590771408;
	bh=Dks27z44VnLETAAoxt9RjUo4oetnIhTAqRH/RT89upA=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=B/LEBS1r5ivLd/w8gCR82ftD10U+Nx4PK2ENw3LwYebwnsRWqFf3Y8K0BDLpwvb/N
	 mH7v3HGbbARLiIHYPv3qFxkA16fJoMV2jiISt/F3TRCFOE2SnQ04jVCDf5EfRXkPXa
	 WrgZ5bXNSU6+KqoXZWAYZ3PnTZbNWfAliCU2aFTYraVnV9etxjTiEIkKrsYYZ+OSPz
	 +6XyP+fitVJwqOsJToCbU+gMjz9rtCeo3LQUKaZ8zj6Yi1LD66hP3MMM4fiB4WOjN8
	 QC/UNSa+3EHQEXMa2C+qdmlhSbZDa4lwvtcF/SUxl1OZ2zn4YHszZ1DC/GZdmJpWbm
	 QcWC4hD3ufa8A==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49YW1p5vkFz1Jqp
 for <lttng-dev@lists.lttng.org>; Fri, 29 May 2020 12:56:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 001071B46A4;
 Fri, 29 May 2020 12:56:39 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 5xaiULj-MX9Q; Fri, 29 May 2020 12:56:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8E6F41B42D9;
 Fri, 29 May 2020 12:56:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8E6F41B42D9
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id mo1cI6mlV6oY; Fri, 29 May 2020 12:56:38 -0400 (EDT)
Received: from thinkos.etherlink (unknown [192.222.236.144])
 by mail.efficios.com (Postfix) with ESMTPSA id 5B5FB1B42D8;
 Fri, 29 May 2020 12:56:38 -0400 (EDT)
To: jgalar@efficios.com
Date: Fri, 29 May 2020 12:56:36 -0400
Message-ID: <20200529165636.4962-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Subject: [lttng-dev] [PATCH lttng-tools] tests: introduce
 --with-babeltrace-test-bin
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200529165636.1RTRVuqX8EQz843pv4ricUgA7_iuGGq9BoxKA6p8Jtk@z>

Introduce --with-babeltrace-test-bin to allow specifying which
babeltrace binary should be used in tests.

If this option is not specified, use the babeltrace2 binary if found,
else fall back on babeltrace.

When looking for babeltrace2 and babeltrace, abide by
--with-babeltrace2-bin and --with-babeltrace-bin. If any of those are
not set, respectively use "babeltrace2" and "babeltrace".

Ensure all shell scripts and python tests use the BABELTRACE_BIN
environment variable.

Fixes #1270

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Co-developed-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Change-Id: I09006c4863df66f2f73980dce02ddc46e8f384ab
---
 .gitignore                                         |  1 +
 configure.ac                                       | 11 +++++++++
 tests/regression/tools/exclusion/test_exclusion    |  2 +-
 tests/regression/tools/filtering/test_valid_filter |  2 +-
 .../tools/streaming/test_high_throughput_limits    |  2 +-
 .../tools/tracefile-limits/test_tracefile_count    |  2 +-
 .../ust/baddr-statedump/test_baddr-statedump.py    |  2 +-
 tests/regression/ust/blocking/test_blocking        |  2 +-
 tests/regression/ust/buffers-pid/test_buffers_pid  |  4 ++--
 tests/regression/ust/daemon/test_daemon.py         |  2 +-
 tests/regression/ust/exit-fast/test_exit-fast.py   |  2 +-
 tests/regression/ust/fork/test_fork.py             |  2 +-
 .../ust/high-throughput/test_high_throughput       |  2 +-
 .../ust/libc-wrapper/test_libc-wrapper.py          |  2 +-
 tests/regression/ust/linking/test_linking.py       |  2 +-
 .../ust/low-throughput/test_low_throughput         |  2 +-
 .../ust/multi-session/test_multi_session           |  2 +-
 .../test_periodical_metadata_flush                 |  2 +-
 .../type-declarations/test_type_declarations.py    |  2 +-
 tests/regression/ust/ust-dl/test_ust-dl.py         |  2 +-
 tests/utils/babeltrace.sh.in                       | 28 ++++++++++++++++++++++
 tests/utils/utils.sh                               |  3 ++-
 22 files changed, 61 insertions(+), 20 deletions(-)
 create mode 100644 tests/utils/babeltrace.sh.in

diff --git a/.gitignore b/.gitignore
index 8f29a8623..1651cdf28 100644
--- a/.gitignore
+++ b/.gitignore
@@ -146,6 +146,7 @@ health_check
 /tests/utils/testapp/userspace-probe-sdt-binary/foobar_provider.h
 /tests/utils/testapp/userspace-probe-sdt-binary/userspace-probe-sdt-binary
 /tests/utils/testapp/gen-ns-events/gen-ns-events
+/tests/utils/babeltrace.sh
 
 # man pages
 /doc/man/*.1
diff --git a/configure.ac b/configure.ac
index 4e186d471..86307f81a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -283,6 +283,13 @@ AC_ARG_WITH([babeltrace2-bin],
 	[BABELTRACE2_BIN=''])
 AC_SUBST([BABELTRACE2_BIN])
 
+AC_ARG_WITH([babeltrace-test-bin],
+	AS_HELP_STRING([--with-babeltrace-test-bin],
+	[Location of the babeltrace2 viewer executable (including the filename) to use for tests]),
+	[BABELTRACE_TEST_BIN="$withval"],
+	[BABELTRACE_TEST_BIN=''])
+AC_SUBST([BABELTRACE_TEST_BIN])
+
 AC_ARG_WITH([consumerd32-bin],
 	AS_HELP_STRING([--with-consumerd32-bin],
 	[Location of the 32-bit consumerd executable (including the filename)]),
@@ -350,6 +357,7 @@ AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_LIBDIR], "$CONSUMERD32_LIBDIR", [Search f
 AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD64_LIBDIR], "$CONSUMERD64_LIBDIR", [Search for consumerd 64-bit libraries in this location.])
 AC_DEFINE_UNQUOTED([CONFIG_BABELTRACE_BIN], "$BABELTRACE_BIN", [Location of the babeltrace viewer executable.])
 AC_DEFINE_UNQUOTED([CONFIG_BABELTRACE2_BIN], "$BABELTRACE2_BIN", [Location of the babeltrace2 viewer executable.])
+AC_DEFINE_UNQUOTED([CONFIG_BABELTRACE_TEST_BIN], "$BABELTRACE_TEST_BIN", [Location of the babeltrace2 viewer executable to use for tests.])
 AC_DEFINE_UNQUOTED([CONFIG_SESSIOND_BIN], "$SESSIOND_BIN", [Location of the sessiond executable.])
 AC_DEFINE_UNQUOTED([CONFIG_LTTNG_SYSTEM_RUNDIR], ["$LTTNG_SYSTEM_RUNDIR"], [LTTng system runtime directory])
 
@@ -1220,6 +1228,9 @@ AC_CONFIG_FILES([tests/regression/ust/python-logging/test_python_logging],[chmod
 AC_CONFIG_FILES([tests/perf/test_perf_raw],[chmod +x tests/perf/test_perf_raw])
 AC_CONFIG_FILES([tests/regression/ust/ust-dl/test_ust-dl],[chmod +x tests/regression/ust/ust-dl/test_ust-dl])
 
+# Inject BABELTRACE_BIN and test env script.
+AC_CONFIG_FILES([tests/utils/babeltrace.sh])
+
 AC_OUTPUT
 
 #
diff --git a/tests/regression/tools/exclusion/test_exclusion b/tests/regression/tools/exclusion/test_exclusion
index ce5e988e5..e5905f628 100755
--- a/tests/regression/tools/exclusion/test_exclusion
+++ b/tests/regression/tools/exclusion/test_exclusion
@@ -53,7 +53,7 @@ function dry_run
 	run_apps
 	stop_lttng_tracing_ok $SESSION_NAME
 
-	nb_events=$(babeltrace $trace_path | wc -l)
+	nb_events=$($BABELTRACE_BIN $trace_path | wc -l)
 	if [ "$nb_events" -ne "0" ]; then
 		ok 0 "Events were found during the dry run without exclusion"
 	else
diff --git a/tests/regression/tools/filtering/test_valid_filter b/tests/regression/tools/filtering/test_valid_filter
index 6d1009a48..f9c39d4bd 100755
--- a/tests/regression/tools/filtering/test_valid_filter
+++ b/tests/regression/tools/filtering/test_valid_filter
@@ -113,7 +113,7 @@ function test_valid_filter
 	# Destroy session
 	destroy_lttng_session_ok $SESSION_NAME
 
-	stats=`babeltrace $trace_path | $STATS_BIN --tracepoint $event_name`
+	stats=`$BABELTRACE_BIN $trace_path | $STATS_BIN --tracepoint $event_name`
 
 	rm -rf $trace_path
 
diff --git a/tests/regression/tools/streaming/test_high_throughput_limits b/tests/regression/tools/streaming/test_high_throughput_limits
index 352cf9aa6..23f67a8e6 100755
--- a/tests/regression/tools/streaming/test_high_throughput_limits
+++ b/tests/regression/tools/streaming/test_high_throughput_limits
@@ -130,7 +130,7 @@ function validate_event_count
 	TEMP_FILE=$(mktemp)
 	TEMP_FILE_2=$(mktemp)
 
-	traced=$(babeltrace $TRACE_PATH 2>/dev/null | wc -l)
+	traced=$($BABELTRACE_BIN $TRACE_PATH 2>/dev/null | wc -l)
 	babeltrace $TRACE_PATH >/dev/null 2>$TEMP_FILE_2
 
 	cat $TEMP_FILE_2 | cut -f4 -d " " >$TEMP_FILE
diff --git a/tests/regression/tools/tracefile-limits/test_tracefile_count b/tests/regression/tools/tracefile-limits/test_tracefile_count
index b44de63c0..af80f8605 100755
--- a/tests/regression/tools/tracefile-limits/test_tracefile_count
+++ b/tests/regression/tools/tracefile-limits/test_tracefile_count
@@ -124,7 +124,7 @@ function test_tracefile_count_limit ()
 
 	# Validate tracing data
 
-	stats=`babeltrace $trace_path | $STATS_BIN --tracepoint $event_name`
+	stats=`$BABELTRACE_BIN $trace_path | $STATS_BIN --tracepoint $event_name`
 
 	validate_min_max "$stats" "intfield" "[0-9]+" "$expected_max"
 	ok $? "Trace validation - intfield"
diff --git a/tests/regression/ust/baddr-statedump/test_baddr-statedump.py b/tests/regression/ust/baddr-statedump/test_baddr-statedump.py
index 026f08444..f255d3e2a 100644
--- a/tests/regression/ust/baddr-statedump/test_baddr-statedump.py
+++ b/tests/regression/ust/baddr-statedump/test_baddr-statedump.py
@@ -44,7 +44,7 @@ stop_session(session_info)
 
 # Check for statedump events in the resulting trace
 try:
-    babeltrace_process = subprocess.Popen(["babeltrace", session_info.trace_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    babeltrace_process = subprocess.Popen([os.environ['BABELTRACE_BIN'], session_info.trace_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 except FileNotFoundError:
     bail("Could not open babeltrace. Please make sure it is installed.", session_info)
 
diff --git a/tests/regression/ust/blocking/test_blocking b/tests/regression/ust/blocking/test_blocking
index abd50d459..ea6ed07cf 100755
--- a/tests/regression/ust/blocking/test_blocking
+++ b/tests/regression/ust/blocking/test_blocking
@@ -123,7 +123,7 @@ function test_ust_blocking_no_discard()
 	destroy_lttng_session_ok $SESSION_NAME
 	stop_lttng_sessiond
 
-	nr_events=$(babeltrace $TRACE_PATH 2>/dev/null | wc -l)
+	nr_events=$($BABELTRACE_BIN $TRACE_PATH 2>/dev/null | wc -l)
 
 	test $nr_events -eq $NUM_EVENT
 	ok $? "No event lost with UST blocking mode: found $nr_events expect $NUM_EVENT"
diff --git a/tests/regression/ust/buffers-pid/test_buffers_pid b/tests/regression/ust/buffers-pid/test_buffers_pid
index 59f218c85..17cc783f9 100755
--- a/tests/regression/ust/buffers-pid/test_buffers_pid
+++ b/tests/regression/ust/buffers-pid/test_buffers_pid
@@ -98,7 +98,7 @@ test_before_multiple_apps() {
 		rm -f ${file_sync_before_last}_${i}
 	done
 
-	out=$(babeltrace $TRACE_PATH | grep $EVENT_NAME | wc -l)
+	out=$($BABELTRACE_BIN $TRACE_PATH | grep $EVENT_NAME | wc -l)
 	if [ $out -eq 0 ]; then
 		fail "Trace validation"
 		diag "No event(s) found. We are supposed to have at least one."
@@ -165,7 +165,7 @@ test_before_app() {
 	rm -f ${file_sync_after_first}
 	rm -f ${file_sync_before_last}
 
-	out=$(babeltrace $TRACE_PATH | grep $EVENT_NAME | wc -l)
+	out=$($BABELTRACE_BIN $TRACE_PATH | grep $EVENT_NAME | wc -l)
 	if [ $out -eq 0 ]; then
 		fail "Trace validation"
 		diag "No event(s) found. We are supposed to have at least one."
diff --git a/tests/regression/ust/daemon/test_daemon.py b/tests/regression/ust/daemon/test_daemon.py
index 0351f1d21..03adb6c80 100644
--- a/tests/regression/ust/daemon/test_daemon.py
+++ b/tests/regression/ust/daemon/test_daemon.py
@@ -57,7 +57,7 @@ if daemon_process_return_code != 0:
 stop_session(session_info)
 
 try:
-    babeltrace_process = subprocess.Popen(["babeltrace", session_info.trace_path], stdout=subprocess.PIPE)
+    babeltrace_process = subprocess.Popen([os.environ['BABELTRACE_BIN'], session_info.trace_path], stdout=subprocess.PIPE)
 except FileNotFoundError:
     bail("Could not open babeltrace. Please make sure it is installed.")
 
diff --git a/tests/regression/ust/exit-fast/test_exit-fast.py b/tests/regression/ust/exit-fast/test_exit-fast.py
index f61d540b3..1a4702b34 100644
--- a/tests/regression/ust/exit-fast/test_exit-fast.py
+++ b/tests/regression/ust/exit-fast/test_exit-fast.py
@@ -49,7 +49,7 @@ stop_session(session_info)
 
 # Check both events (normal exit and suicide messages) are present in the resulting trace
 try:
-    babeltrace_process = subprocess.Popen(["babeltrace", session_info.trace_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    babeltrace_process = subprocess.Popen([os.environ['BABELTRACE_BIN'], session_info.trace_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 except FileNotFoundError:
     bail("Could not open babeltrace. Please make sure it is installed.")
 
diff --git a/tests/regression/ust/fork/test_fork.py b/tests/regression/ust/fork/test_fork.py
index 4cb721f38..e08f2c106 100644
--- a/tests/regression/ust/fork/test_fork.py
+++ b/tests/regression/ust/fork/test_fork.py
@@ -52,7 +52,7 @@ stop_session(session_info)
 
 # Check both events (normal exit and suicide messages) are present in the resulting trace
 try:
-    babeltrace_process = subprocess.Popen(["babeltrace", session_info.trace_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    babeltrace_process = subprocess.Popen([os.environ['BABELTRACE_BIN'], session_info.trace_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 except FileNotFoundError:
     bail("Could not open babeltrace. Please make sure it is installed.", session_info)
 
diff --git a/tests/regression/ust/high-throughput/test_high_throughput b/tests/regression/ust/high-throughput/test_high_throughput
index a6dbdc758..57504656d 100755
--- a/tests/regression/ust/high-throughput/test_high_throughput
+++ b/tests/regression/ust/high-throughput/test_high_throughput
@@ -53,7 +53,7 @@ stop_lttng_sessiond
 TEMP_FILE=$(mktemp)
 TEMP_FILE_2=$(mktemp)
 
-traced=$(babeltrace $TRACE_PATH 2>/dev/null | wc -l)
+traced=$($BABELTRACE_BIN $TRACE_PATH 2>/dev/null | wc -l)
 babeltrace $TRACE_PATH >/dev/null 2>$TEMP_FILE_2
 
 cat $TEMP_FILE_2 | cut -f4 -d " " >$TEMP_FILE
diff --git a/tests/regression/ust/libc-wrapper/test_libc-wrapper.py b/tests/regression/ust/libc-wrapper/test_libc-wrapper.py
index f56fa50de..95e5db781 100644
--- a/tests/regression/ust/libc-wrapper/test_libc-wrapper.py
+++ b/tests/regression/ust/libc-wrapper/test_libc-wrapper.py
@@ -41,7 +41,7 @@ stop_session(session_info)
 
 # Check for malloc events in the resulting trace
 try:
-    babeltrace_process = subprocess.Popen(["babeltrace", session_info.trace_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    babeltrace_process = subprocess.Popen([os.environ['BABELTRACE_BIN'], session_info.trace_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 except FileNotFoundError:
     bail("Could not open babeltrace. Please make sure it is installed.", session_info)
 
diff --git a/tests/regression/ust/linking/test_linking.py b/tests/regression/ust/linking/test_linking.py
index 21941f0d2..28d4f52ce 100644
--- a/tests/regression/ust/linking/test_linking.py
+++ b/tests/regression/ust/linking/test_linking.py
@@ -133,7 +133,7 @@ for executable in test_executables:
         continue
 
     try:
-        babeltrace_process = subprocess.Popen(["babeltrace", session_info.trace_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+        babeltrace_process = subprocess.Popen([os.environ['BABELTRACE_BIN'], session_info.trace_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     except FileNotFoundError:
         bail("Could not open babeltrace. Please make sure it is installed.")
 
diff --git a/tests/regression/ust/low-throughput/test_low_throughput b/tests/regression/ust/low-throughput/test_low_throughput
index 16ef27347..33e6ba280 100755
--- a/tests/regression/ust/low-throughput/test_low_throughput
+++ b/tests/regression/ust/low-throughput/test_low_throughput
@@ -47,7 +47,7 @@ stop_lttng_sessiond
 last_val=0
 out=0
 
-babeltrace $TRACE_PATH | while read event;
+$BABELTRACE_BIN $TRACE_PATH | while read event;
 do
 	val=$(echo $event | cut -f10 -d" ")
 	val=${val%?}
diff --git a/tests/regression/ust/multi-session/test_multi_session b/tests/regression/ust/multi-session/test_multi_session
index ba73b7d20..013937285 100755
--- a/tests/regression/ust/multi-session/test_multi_session
+++ b/tests/regression/ust/multi-session/test_multi_session
@@ -40,7 +40,7 @@ test_multi_session() {
 	for i in `seq 0 3`; do
 		stop_lttng_tracing_ok "$SESSION_NAME-$i"
 		destroy_lttng_session_ok "$SESSION_NAME-$i"
-		out=$(babeltrace "$TRACE_PATH/$i" | grep "$EVENT_NAMEi$i" | wc -l)
+		out=$($BABELTRACE_BIN "$TRACE_PATH/$i" | grep "$EVENT_NAMEi$i" | wc -l)
 		if [ $out -ne $NR_ITER ]; then
 			fail "Trace validation of $SESSION_NAME-$i"
 			diag "No events found."
diff --git a/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush b/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
index 848fc2f3e..2aa086837 100755
--- a/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
+++ b/tests/regression/ust/periodical-metadata-flush/test_periodical_metadata_flush
@@ -68,7 +68,7 @@ function validate_trace()
 {
 	local out
 
-	out=$(babeltrace $TRACE_PATH | grep $EVENT_NAME | wc -l)
+	out=$($BABELTRACE_BIN $TRACE_PATH | grep $EVENT_NAME | wc -l)
 	if [ $out -eq 0 ]; then
 		fail "Trace validation"
 		diag "No event(s) found. We are supposed to have at least one."
diff --git a/tests/regression/ust/type-declarations/test_type_declarations.py b/tests/regression/ust/type-declarations/test_type_declarations.py
index 62eda73a3..a92545064 100644
--- a/tests/regression/ust/type-declarations/test_type_declarations.py
+++ b/tests/regression/ust/type-declarations/test_type_declarations.py
@@ -43,7 +43,7 @@ stop_session(session_info)
 
 # Check event fields using type declarations are present
 try:
-    babeltrace_process = subprocess.Popen(["babeltrace", session_info.trace_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    babeltrace_process = subprocess.Popen([os.environ['BABELTRACE_BIN'], session_info.trace_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 except FileNotFoundError:
     bail("Could not open babeltrace. Please make sure it is installed.")
 
diff --git a/tests/regression/ust/ust-dl/test_ust-dl.py b/tests/regression/ust/ust-dl/test_ust-dl.py
index 96509c7cf..3fc999111 100644
--- a/tests/regression/ust/ust-dl/test_ust-dl.py
+++ b/tests/regression/ust/ust-dl/test_ust-dl.py
@@ -52,7 +52,7 @@ stop_session(session_info)
 
 # Check for dl events in the resulting trace
 try:
-    babeltrace_process = subprocess.Popen(["babeltrace", session_info.trace_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    babeltrace_process = subprocess.Popen([os.environ['BABELTRACE_BIN'], session_info.trace_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 except FileNotFoundError:
     bail("Could not open babeltrace. Please make sure it is installed.", session_info)
 
diff --git a/tests/utils/babeltrace.sh.in b/tests/utils/babeltrace.sh.in
new file mode 100644
index 000000000..380559029
--- /dev/null
+++ b/tests/utils/babeltrace.sh.in
@@ -0,0 +1,28 @@
+user_defined_bt_test="@BABELTRACE_TEST_BIN@"
+user_defined_bt1="@BABELTRACE_BIN@"
+user_defined_bt2="@BABELTRACE2_BIN@"
+
+if [ -n "${user_defined_bt2}" ]; then
+	bt2_bin="${user_defined_bt2}"
+else
+	bt2_bin="babeltrace2"
+fi
+
+if [ -n "${user_defined_bt1}" ]; then
+	bt1_bin="${user_defined_bt1}"
+else
+	bt1_bin="babeltrace"
+fi
+
+# Use user-defined babeltrace test binary if specified. Else fallback
+# on using babeltrace2 if found, else fallback on babeltrace if found.
+
+if [ -n "${user_defined_bt_test}" ]; then
+	BABELTRACE_BIN="${user_defined_bt_test}"
+elif command -v "${bt2_bin}"; then
+	BABELTRACE_BIN="${bt2_bin}"
+elif command -v "${bt1_bin}"; then
+	BABELTRACE_BIN="${bt1_bin}"
+else
+	echo "Failed to find Babeltrace binaries: ${bt2_bin} ${bt1_bin}"
+fi
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index 0583b5c19..1a5f7fc5c 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -12,10 +12,11 @@ CONSUMERD_MATCH=".*lttng-consumerd.*"
 RELAYD_BIN="lttng-relayd"
 RELAYD_MATCH=".*lttng-relayd.*"
 LTTNG_BIN="lttng"
-BABELTRACE_BIN="babeltrace"
 OUTPUT_DEST=/dev/null
 ERROR_OUTPUT_DEST=/dev/null
 
+source $TESTDIR/utils/babeltrace.sh
+
 # Minimal kernel version supported for session daemon tests
 KERNEL_MAJOR_VERSION=2
 KERNEL_MINOR_VERSION=6
-- 
2.11.0

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
