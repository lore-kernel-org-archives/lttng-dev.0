From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH babeltrace] Fix: test_seek should only output
	one TAP plan
Date: Mon, 26 Aug 2013 14:15:14 -0400
Message-ID: <1377540914-17523-1-git-send-email-christian.babeux__3195.29887424341$1377540980$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VE1K1-0006Ej-0V
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 14:15:30 -0400
Received: by mail-qc0-f172.google.com with SMTP id a1so1968568qcx.17
	for <lttng-dev@lists.lttng.org>; Mon, 26 Aug 2013 11:15:19 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On critical failure paths, the test_seek test was outputting multiple TAP plans,
which according to the specification [1] is invalid. This causes parsing
issues on very strict TAP parsers.

[1] - http://podwiki.hexten.net/TAP/TAP.html?page=TAP

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/lib/test_seek.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/tests/lib/test_seek.c b/tests/lib/test_seek.c
index 170c830..4e1a823 100644
--- a/tests/lib/test_seek.c
+++ b/tests/lib/test_seek.c
@@ -44,17 +44,22 @@ void run_seek_begin(char *path, uint64_t expected_begin)
 	int ret;
 	uint64_t timestamp_begin;
 	uint64_t timestamp_seek_begin;
+	unsigned int nr_seek_begin_test;
+
+	nr_seek_begin_test = 5;
 
 	/* Open the trace */
 	ctx = create_context_with_path(path);
 	if (!ctx) {
-		plan_skip_all("Cannot create valid context");
+		skip(nr_seek_begin_test, "Cannot create valid context");
+		return;
 	}
 
 	/* Create iterator with null begin and end */
 	iter = bt_ctf_iter_create(ctx, NULL, NULL);
 	if (!iter) {
-		plan_skip_all("Cannot create valid iterator");
+		skip(nr_seek_begin_test, "Cannot create valid iterator");
+		return;
 	}
 
 	event = bt_ctf_iter_read_event(iter);
@@ -92,17 +97,22 @@ void run_seek_last(char *path, uint64_t expected_last)
 	struct bt_iter_pos newpos;
 	int ret;
 	uint64_t timestamp_last;
+	unsigned int nr_seek_last_tests;
+
+	nr_seek_last_tests = 6;
 
 	/* Open the trace */
 	ctx = create_context_with_path(path);
 	if (!ctx) {
-		plan_skip_all("Cannot create valid context");
+		skip(nr_seek_last_tests, "Cannot create valid context");
+		return;
 	}
 
 	/* Create iterator with null last and end */
 	iter = bt_ctf_iter_create(ctx, NULL, NULL);
 	if (!iter) {
-		plan_skip_all("Cannot create valid iterator");
+		skip(nr_seek_last_tests, "Cannot create valid iterator");
+		return;
 	}
 
 	event = bt_ctf_iter_read_event(iter);
@@ -143,17 +153,24 @@ void run_seek_time_at_last(char *path, uint64_t expected_last)
 	struct bt_iter_pos newpos;
 	int ret;
 	uint64_t timestamp_last;
+	unsigned int nr_seek_time_at_last_tests;
+
+	nr_seek_time_at_last_tests = 6;
 
 	/* Open the trace */
 	ctx = create_context_with_path(path);
 	if (!ctx) {
-		plan_skip_all("Cannot create valid context");
+		skip(nr_seek_time_at_last_tests,
+		     "Cannot create valid context");
+		return;
 	}
 
 	/* Create iterator with null last and end */
 	iter = bt_ctf_iter_create(ctx, NULL, NULL);
 	if (!iter) {
-		plan_skip_all("Cannot create valid iterator");
+		skip(nr_seek_time_at_last_tests,
+		     "Cannot create valid iterator");
+		return;
 	}
 
 	event = bt_ctf_iter_read_event(iter);
@@ -198,16 +215,22 @@ void run_seek_cycles(char *path,
 	int ret;
 	uint64_t timestamp;
 
+	unsigned int nr_seek_cycles_tests;
+
+	nr_seek_cycles_tests = 12;
+
 	/* Open the trace */
 	ctx = create_context_with_path(path);
 	if (!ctx) {
-		plan_skip_all("Cannot create valid context");
+		skip(nr_seek_cycles_tests, "Cannot create valid context");
+		return;
 	}
 
 	/* Create iterator with null last and end */
 	iter = bt_ctf_iter_create(ctx, NULL, NULL);
 	if (!iter) {
-		plan_skip_all("Cannot create valid iterator");
+		skip(nr_seek_cycles_tests, "Cannot create valid iterator");
+		return;
 	}
 
 	event = bt_ctf_iter_read_event(iter);
@@ -281,8 +304,6 @@ int main(int argc, char **argv)
 	babeltrace_debug = 0;	/* libbabeltrace.la */
 	opt_clock_offset = 0;	/* libbabeltrace-ctf.la */
 
-	plan_tests(NR_TESTS);
-
 	if (argc < 4) {
 		plan_skip_all("Invalid arguments: need a trace path and the start and last timestamp");
 
@@ -301,6 +322,8 @@ int main(int argc, char **argv)
 		plan_skip_all("Invalid value for last timestamp");
 	}
 
+	plan_tests(NR_TESTS);
+
 	run_seek_begin(path, expected_begin);
 	run_seek_time_at_last(path, expected_last);
 	run_seek_last(path, expected_last);
-- 
1.8.3.4
