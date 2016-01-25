From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Tests: Fix test plans and do not
	skip on fail
Date: Mon, 25 Jan 2016 16:00:41 -0500
Message-ID: <1453755641-25741-1-git-send-email-mjeanson__36277.0204003484$1453755727$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aNoFx-00045D-NA
 for lttng-dev@lists.lttng.org; Mon, 25 Jan 2016 16:01:03 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Use fixed count test plans in all tests and make sure we do not skip
some tests on initialisation failures.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 .gitignore                  |  1 +
 tests/lib/test_bt_values.c  |  4 +++-
 tests/lib/test_ctf_ir_ref.c |  6 +++++-
 tests/lib/test_ctf_writer.c |  4 +++-
 tests/lib/test_seek.c       | 45 ++++++++++++++++-----------------------------
 5 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/.gitignore b/.gitignore
index bf869af..c572d18 100644
--- a/.gitignore
+++ b/.gitignore
@@ -5,6 +5,7 @@
 /tests/lib/test_ctf_writer
 /tests/lib/test_bt_objects
 /tests/lib/test_bt_values
+/tests/lib/test_ctf_ir_ref
 *.o
 *.a
 *.la
diff --git a/tests/lib/test_bt_values.c b/tests/lib/test_bt_values.c
index 4eb20ba..34fbc82 100644
--- a/tests/lib/test_bt_values.c
+++ b/tests/lib/test_bt_values.c
@@ -25,6 +25,8 @@
 #include <string.h>
 #include "tap/tap.h"
 
+#define NR_TESTS 238
+
 static
 void test_null(void)
 {
@@ -1154,7 +1156,7 @@ void test_freeze(void)
 
 int main(void)
 {
-	plan_no_plan();
+	plan_tests(NR_TESTS);
 
 	test_macros();
 	test_freeze();
diff --git a/tests/lib/test_ctf_ir_ref.c b/tests/lib/test_ctf_ir_ref.c
index 856715c..01434d4 100644
--- a/tests/lib/test_ctf_ir_ref.c
+++ b/tests/lib/test_ctf_ir_ref.c
@@ -27,6 +27,8 @@
 #include <babeltrace/object-internal.h>
 #include <assert.h>
 
+#define NR_TESTS 41
+
 struct user {
 	struct bt_ctf_trace *tc;
 	struct bt_ctf_stream_class *sc;
@@ -358,6 +360,9 @@ int main(int argc, char **argv)
 			*weak_ec3 = NULL;
 	struct user user_a = { 0 }, user_b = { 0 }, user_c = { 0 };
 
+	 /* Initialize tap harness before any tests */
+	plan_tests(NR_TESTS);
+
 	/* The only reference which exists at this point is on TC1. */
 	tc1 = create_tc1();
         ok(tc1, "Initialize trace");
@@ -367,7 +372,6 @@ int main(int argc, char **argv)
 
 	init_weak_refs(tc1, &weak_tc1, &weak_sc1, &weak_sc2, &weak_ec1,
 			&weak_ec2, &weak_ec3);
-	plan_no_plan();
 
 	ok(bt_object_get_ref_count(weak_sc1) == 0,
 			"Initial SC1 reference count is 0");
diff --git a/tests/lib/test_ctf_writer.c b/tests/lib/test_ctf_writer.c
index 596bb90..d246510 100644
--- a/tests/lib/test_ctf_writer.c
+++ b/tests/lib/test_ctf_writer.c
@@ -57,6 +57,8 @@
 #define DEFAULT_CLOCK_IS_ABSOLUTE 0
 #define DEFAULT_CLOCK_TIME 0
 
+#define NR_TESTS 588
+
 static uint64_t current_time = 42;
 
 /* Return 1 if uuids match, zero if different. */
@@ -2689,7 +2691,7 @@ int main(int argc, char **argv)
 		return -1;
 	}
 
-	plan_no_plan();
+	plan_tests(NR_TESTS);
 
 	if (!bt_mkdtemp(trace_path)) {
 		perror("# perror");
diff --git a/tests/lib/test_seek.c b/tests/lib/test_seek.c
index de2c934..63e5a6a 100644
--- a/tests/lib/test_seek.c
+++ b/tests/lib/test_seek.c
@@ -44,21 +44,18 @@ void run_seek_begin(char *path, uint64_t expected_begin)
 	int ret;
 	uint64_t timestamp_begin;
 	uint64_t timestamp_seek_begin;
-	unsigned int nr_seek_begin_test;
-
-	nr_seek_begin_test = 5;
 
 	/* Open the trace */
 	ctx = create_context_with_path(path);
 	if (!ctx) {
-		skip(nr_seek_begin_test, "Cannot create valid context");
+		diag("Cannot create valid context");
 		return;
 	}
 
 	/* Create iterator with null begin and end */
 	iter = bt_ctf_iter_create(ctx, NULL, NULL);
 	if (!iter) {
-		skip(nr_seek_begin_test, "Cannot create valid iterator");
+		diag("Cannot create valid iterator");
 		return;
 	}
 
@@ -97,21 +94,18 @@ void run_seek_last(char *path, uint64_t expected_last)
 	struct bt_iter_pos newpos;
 	int ret;
 	uint64_t timestamp_last;
-	unsigned int nr_seek_last_tests;
-
-	nr_seek_last_tests = 6;
 
 	/* Open the trace */
 	ctx = create_context_with_path(path);
 	if (!ctx) {
-		skip(nr_seek_last_tests, "Cannot create valid context");
+		diag("Cannot create valid context");
 		return;
 	}
 
 	/* Create iterator with null last and end */
 	iter = bt_ctf_iter_create(ctx, NULL, NULL);
 	if (!iter) {
-		skip(nr_seek_last_tests, "Cannot create valid iterator");
+		diag("Cannot create valid iterator");
 		return;
 	}
 
@@ -153,23 +147,18 @@ void run_seek_time_at_last(char *path, uint64_t expected_last)
 	struct bt_iter_pos newpos;
 	int ret;
 	uint64_t timestamp_last;
-	unsigned int nr_seek_time_at_last_tests;
-
-	nr_seek_time_at_last_tests = 6;
 
 	/* Open the trace */
 	ctx = create_context_with_path(path);
 	if (!ctx) {
-		skip(nr_seek_time_at_last_tests,
-		     "Cannot create valid context");
+		diag("Cannot create valid context");
 		return;
 	}
 
 	/* Create iterator with null last and end */
 	iter = bt_ctf_iter_create(ctx, NULL, NULL);
 	if (!iter) {
-		skip(nr_seek_time_at_last_tests,
-		     "Cannot create valid iterator");
+		diag("Cannot create valid iterator");
 		return;
 	}
 
@@ -215,21 +204,17 @@ void run_seek_cycles(char *path,
 	int ret;
 	uint64_t timestamp;
 
-	unsigned int nr_seek_cycles_tests;
-
-	nr_seek_cycles_tests = 12;
-
 	/* Open the trace */
 	ctx = create_context_with_path(path);
 	if (!ctx) {
-		skip(nr_seek_cycles_tests, "Cannot create valid context");
+		diag("Cannot create valid context");
 		return;
 	}
 
 	/* Create iterator with null last and end */
 	iter = bt_ctf_iter_create(ctx, NULL, NULL);
 	if (!iter) {
-		skip(nr_seek_cycles_tests, "Cannot create valid iterator");
+		diag("Cannot create valid iterator");
 		return;
 	}
 
@@ -304,9 +289,11 @@ int main(int argc, char **argv)
 	babeltrace_debug = 0;	/* libbabeltrace.la */
 	opt_clock_offset = 0;	/* libbabeltrace-ctf.la */
 
-	if (argc < 4) {
-		plan_skip_all("Invalid arguments: need a trace path and the start and last timestamp");
+	plan_tests(NR_TESTS);
 
+	if (argc < 4) {
+		diag("Invalid arguments: need a trace path and the start and last timestamp");
+		exit(1);
 	}
 
 	/* Parse arguments (Trace, begin timestamp) */
@@ -314,16 +301,16 @@ int main(int argc, char **argv)
 
 	expected_begin = strtoull(argv[2], NULL, 0);
 	if (ULLONG_MAX == expected_begin && errno == ERANGE) {
-		plan_skip_all("Invalid value for begin timestamp");
+		diag("Invalid value for begin timestamp");
+		exit(1);
 	}
 
 	expected_last = strtoull(argv[3], NULL, 0);
 	if (ULLONG_MAX == expected_last && errno == ERANGE) {
-		plan_skip_all("Invalid value for last timestamp");
+		diag("Invalid value for last timestamp");
+		exit(1);
 	}
 
-	plan_tests(NR_TESTS);
-
 	run_seek_begin(path, expected_begin);
 	run_seek_time_at_last(path, expected_last);
 	run_seek_last(path, expected_last);
-- 
2.7.0.rc3
