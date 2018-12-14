From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Support minute and hour as time
 suffix
Date: Fri, 14 Dec 2018 16:32:12 -0500
Message-ID: <20181214213212.31562-1-jonathan.rajotte-julien__4251.8381531865$1544823031$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43GkKL0NhJz15sS
 for <lttng-dev@lists.lttng.org>; Fri, 14 Dec 2018 16:32:21 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

utils_parse_time_suffix now support the following suffix:

    "us" for microsecond,
    "ms" for millisecond,
    "s"  for second,
    "m"  for minute,
    "h"  for hour

This remove the use of "m" for milliseconds and "u" for microseconds.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/thread-utils.c     |  2 -
 src/common/time.h                         |  8 ++++
 src/common/utils.c                        | 48 +++++++++++++++++------
 tests/unit/test_utils_parse_time_suffix.c | 30 +++++++++-----
 4 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/src/bin/lttng-sessiond/thread-utils.c b/src/bin/lttng-sessiond/thread-utils.c
index 549cd69f8..16ae9d692 100644
--- a/src/bin/lttng-sessiond/thread-utils.c
+++ b/src/bin/lttng-sessiond/thread-utils.c
@@ -22,8 +22,6 @@
 #include <common/utils.h>
 #include <pthread.h>
 
-#define USEC_PER_SEC 1000000
-
 /*
  * Quit pipe for all threads. This permits a single cancellation point
  * for all threads when receiving an event on the pipe.
diff --git a/src/common/time.h b/src/common/time.h
index 8a7dd958f..92775b9b2 100644
--- a/src/common/time.h
+++ b/src/common/time.h
@@ -25,6 +25,14 @@
 #define NSEC_PER_SEC	1000000000ULL
 #define NSEC_PER_MSEC	1000000ULL
 #define NSEC_PER_USEC	1000ULL
+#define USEC_PER_SEC	1000000ULL
+#define USEC_PER_MSEC	1000ULL
+
+#define SEC_PER_MINUTE	60ULL
+#define MINUTE_PER_HOUR	60ULL
+
+#define USEC_PER_MINUTE	(USEC_PER_SEC * SEC_PER_MINUTE)
+#define USEC_PER_HOURS	(USEC_PER_MINUTE * MINUTE_PER_HOUR)
 
 /*
  * timespec_to_ms: Convert timespec to milliseconds.
diff --git a/src/common/utils.c b/src/common/utils.c
index 08139e5e2..2327b7d94 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -1104,12 +1104,19 @@ end:
 
 /**
  * Parse a string that represents a time in human readable format. It
- * supports decimal integers suffixed by 's', 'u', 'm', 'us', and 'ms'.
+ * supports decimal integers suffixed by:
+ *     "us" for microsecond,
+ *     "ms" for millisecond,
+ *     "s"  for second,
+ *     "m"  for minute,
+ *     "h"  for hour
  *
  * The suffix multiply the integer by:
- * 'u'/'us': 1
- * 'm'/'ms': 1000
- * 's': 1000000
+ *     "us" : 1
+ *     "ms" : 1000
+ *     "s"  : 1000000
+ *     "m"  : 60000000
+ *     "h"  : 3600000000
  *
  * Note that unit-less numbers are assumed to be microseconds.
  *
@@ -1124,7 +1131,7 @@ int utils_parse_time_suffix(char const * const str, uint64_t * const time_us)
 {
 	int ret;
 	uint64_t base_time;
-	long multiplier = 1;
+	uint64_t multiplier = 1;
 	const char *str_end;
 	char *num_end;
 
@@ -1161,17 +1168,34 @@ int utils_parse_time_suffix(char const * const str, uint64_t * const time_us)
 	/* Check if a prefix is present. */
 	switch (*num_end) {
 	case 'u':
-		multiplier = 1;
-		/* Skip another letter in the 'us' case. */
-		num_end += (*(num_end + 1) == 's') ? 2 : 1;
+		/* Microsecond (us) */
+		if (*(num_end + 1) != 's') {
+			DBG("utils_parse_time_suffix: invalid suffix.");
+			ret = -1;
+			goto end;
+		}
+		num_end += 2;
 		break;
 	case 'm':
-		multiplier = 1000;
-		/* Skip another letter in the 'ms' case. */
-		num_end += (*(num_end + 1) == 's') ? 2 : 1;
+		if (*(num_end + 1) == 's') {
+			/* Millisecond (ms) */
+			multiplier = USEC_PER_MSEC;
+			/* Skip the 's' */
+			num_end++;
+		} else {
+			/* Minute (m) */
+			multiplier = USEC_PER_MINUTE;
+		}
+		num_end++;
 		break;
 	case 's':
-		multiplier = 1000000;
+		/* Second */
+		multiplier = USEC_PER_SEC;
+		num_end++;
+		break;
+	case 'h':
+		/* Hour */
+		multiplier = USEC_PER_HOURS;
 		num_end++;
 		break;
 	case '\0':
diff --git a/tests/unit/test_utils_parse_time_suffix.c b/tests/unit/test_utils_parse_time_suffix.c
index 96482769b..1e7aa22f1 100644
--- a/tests/unit/test_utils_parse_time_suffix.c
+++ b/tests/unit/test_utils_parse_time_suffix.c
@@ -18,6 +18,7 @@
 #include <assert.h>
 #include <string.h>
 #include <stdio.h>
+#include <inttypes.h>
 
 #include <tap/tap.h>
 
@@ -37,16 +38,25 @@ struct valid_test_input {
 static struct valid_test_input valid_tests_inputs[] = {
 		{ "0", 0 },
 		{ "1234", 1234 },
-		{ "0u", 0 },
-		{ "1234u", 1234 },
-		{ "16m", 16000 },
-		{ "128m", 128000 },
+		{ "1234us", 1234 },
+		{ "16ms", 16000 },
+		{ "128ms", 128000 },
 		{ "32s", 32000000 },
+		{ "1m", 60000000 },
+		{ "20m", 1200000000 },
+		{ "1h", 3600000000 },
+		{ "5h", 18000000000 },
 		{ "00", 0 },
-		{ "0m", 0 },
+		{ "0us", 0 },
+		{ "0ms", 0 },
 		{ "0s", 0 },
-		{ "00m", 0 },
+		{ "0m", 0 },
+		{ "0h", 0 },
+		{ "00us", 0 },
+		{ "00ms", 0 },
 		{ "00s", 0 },
+		{ "00m", 0 },
+		{ "00h", 0 },
 		{ "12ms", 12000 },
 		{ "3597us", 3597 },
 		{ "+5", 5 },
@@ -79,6 +89,9 @@ static char *invalid_tests_inputs[] = {
 		"14ns",
 		"14ms garbage after value",
 		"0x14s",
+		"0u",
+		"5mS",
+		"5Ms",
 };
 static const int num_invalid_tests = sizeof(invalid_tests_inputs) / sizeof(invalid_tests_inputs[0]);
 
@@ -90,11 +103,10 @@ static void test_utils_parse_time_suffix(void)
 
 	/* Test valid cases */
 	for (i = 0; i < num_valid_tests; i++) {
-		char name[100];
-
-		sprintf(name, "valid test case: %s", valid_tests_inputs[i].input);
+		char name[256];
 
 		ret = utils_parse_time_suffix(valid_tests_inputs[i].input, &result);
+		sprintf(name, "valid test case: %s expected %" PRIu64, valid_tests_inputs[i].input, result);
 		ok(ret == 0 && result == valid_tests_inputs[i].expected_result, name);
 	}
 
-- 
2.17.1
