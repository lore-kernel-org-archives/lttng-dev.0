From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [RFC PATCH lttng-tools v4] lttng cli: Accept human
	readable sizes for --subbuf-size
Date: Wed, 10 Apr 2013 14:52:21 -0400
Message-ID: <1365619941-16708-1-git-send-email-simon.marchi__2668.26246302134$1365619959$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.electronicbox.net ([96.127.255.83])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1UQ082-00075h-2C
	for lttng-dev@lists.lttng.org; Wed, 10 Apr 2013 14:52:18 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

--subbuf-size accepts sizes such as:

- 123 -> 123
- 123k -> 123 * 1024
- 123M -> 123 * 1024 * 1024
- 123G -> 123 * 1024 * 1024 * 1024

It uses the new parse_size_suffix function, which could probably be used
at other places, such as tracefile size.

Unit tests are included.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
New in v4:
- Changes following David Goulet's comments
 - Move stuff in src/common/utils.{c,h}
 - malloc -> zmalloc
 - Formatting

 src/bin/lttng/commands/enable_channels.c |   21 ++++-
 src/common/utils.c                       |  124 ++++++++++++++++++++++++++++++
 src/common/utils.h                       |    8 ++
 tests/unit/Makefile.am                   |   15 +++-
 tests/unit/test_parse_size_suffix.c      |   73 ++++++++++++++++++
 5 files changed, 235 insertions(+), 6 deletions(-)
 create mode 100644 tests/unit/test_parse_size_suffix.c

diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
index d026af4..dbec8ab 100644
--- a/src/bin/lttng/commands/enable_channels.c
+++ b/src/bin/lttng/commands/enable_channels.c
@@ -66,7 +66,7 @@ static struct poptOption long_options[] = {
 	{"userspace",      'u', POPT_ARG_NONE, 0, OPT_USERSPACE, 0, 0},
 	{"discard",        0,   POPT_ARG_NONE, 0, OPT_DISCARD, 0, 0},
 	{"overwrite",      0,   POPT_ARG_NONE, 0, OPT_OVERWRITE, 0, 0},
-	{"subbuf-size",    0,   POPT_ARG_DOUBLE, 0, OPT_SUBBUF_SIZE, 0, 0},
+	{"subbuf-size",    0,   POPT_ARG_STRING, 0, OPT_SUBBUF_SIZE, 0, 0},
 	{"num-subbuf",     0,   POPT_ARG_INT, 0, OPT_NUM_SUBBUF, 0, 0},
 	{"switch-timer",   0,   POPT_ARG_INT, 0, OPT_SWITCH_TIMER, 0, 0},
 	{"read-timer",     0,   POPT_ARG_INT, 0, OPT_READ_TIMER, 0, 0},
@@ -289,6 +289,7 @@ int cmd_enable_channels(int argc, const char **argv)
 	int opt, ret = CMD_SUCCESS;
 	static poptContext pc;
 	char *session_name = NULL;
+	char *opt_arg = NULL;
 
 	init_channel_config();
 
@@ -309,8 +310,22 @@ int cmd_enable_channels(int argc, const char **argv)
 			DBG("Channel set to overwrite");
 			break;
 		case OPT_SUBBUF_SIZE:
-			/* TODO Replace atol with strtol and check for errors */
-			chan.attr.subbuf_size = atol(poptGetOptArg(pc));
+			/* Parse the size */
+			opt_arg = poptGetOptArg(pc);
+			if (parse_size_suffix(opt_arg, &chan.attr.subbuf_size) < 0) {
+				ERR("Wrong value the --subbuf-size parameter: %s", opt_arg);
+				ret = CMD_ERROR;
+				goto end;
+			}
+
+			/* Check if power of 2 */
+			if ((chan.attr.subbuf_size - 1) & chan.attr.subbuf_size) {
+				ERR("The subbuf size is not a power of 2: %" PRIu64 " (%s)",
+						chan.attr.subbuf_size, opt_arg);
+				ret = CMD_ERROR;
+				goto end;
+			}
+
 			DBG("Channel subbuf size set to %" PRIu64, chan.attr.subbuf_size);
 			break;
 		case OPT_NUM_SUBBUF:
diff --git a/src/common/utils.c b/src/common/utils.c
index b16cdc9..9e8fd9d 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -26,6 +26,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <inttypes.h>
+#include <regex.h>
 
 #include <common/common.h>
 #include <common/runas.h>
@@ -386,3 +387,126 @@ int utils_rotate_stream_file(char *path_name, char *file_name, uint64_t size,
 error:
 	return ret;
 }
+
+/**
+ * Prints the error message corresponding to a regex error code.
+ *
+ * @param errcode	The error code.
+ * @param regex		The regex object that produced the error code.
+ */
+static void regex_print_error(int errcode, regex_t *regex)
+{
+	/* Get length of error message and allocate accordingly */
+	size_t length;
+	char *buffer;
+
+	assert(regex != NULL);
+
+	length = regerror(errcode, regex, NULL, 0);
+	buffer = zmalloc(length);
+
+	if (!buffer) {
+		ERR("regex_print_error: zmalloc failed");
+		return;
+	}
+
+	/* Get and print error message */
+	regerror(errcode, regex, buffer, length);
+	ERR("regex error: %s\n", buffer);
+	free(buffer);
+
+}
+
+/**
+ * Parse a string that represents a size in human readable format. It
+ * supports decimal integers suffixed by 'k', 'M' or 'G'.
+ *
+ * The suffix multiply the integer by:
+ * 'k': 1024
+ * 'M': 1024 * 1024
+ * 'G': 1024 * 1024 * 1024
+ *
+ * @param str	The string to parse.
+ * @param size	Pointer to a size_t that will be filled with the
+ * 	  	resulting size.
+ *
+ * @return 0 on success, -1 on failure.
+ */
+int parse_size_suffix(char *str, uint64_t *size)
+{
+	regex_t regex;
+	int ret;
+	const int nmatch = 2;
+	regmatch_t suffix_match, matches[nmatch];
+
+	if (!str) {
+		return 0;
+	}
+
+	/* Compile regex */
+	ret = regcomp(&regex, "^[0-9][0-9]*\\([kKMG]\\{0,1\\}\\)$", 0);
+
+	/* Check for regex error */
+	if (ret != 0) {
+		regex_print_error(ret, &regex);
+		ret = -1;
+		goto end;
+	}
+
+	/* Match regex */
+	ret = regexec(&regex, str, nmatch, matches, 0);
+	if (ret != 0) {
+		/* There is no match (or error) */
+		ret = -1;
+		goto free;
+	}
+
+	/* There is a match ! */
+	unsigned long long base_size;
+	long shift = 0;
+	errno = 0;
+	base_size = strtoull(str, NULL, 10);
+	/* Check result of conversion */
+	if (errno != 0) {
+		PERROR("strtoull");
+		ret = -1;
+		goto free;
+	}
+
+	/* Check if there is a suffix */
+	suffix_match = matches[1];
+	if (suffix_match.rm_eo - suffix_match.rm_so == 1) {
+		switch (*(str + suffix_match.rm_so)) {
+		case 'K':
+		case 'k':
+			shift = KIBI_LOG2;
+			break;
+		case 'M':
+			shift = MEBI_LOG2;
+			break;
+		case 'G':
+			shift = GIBI_LOG2;
+			break;
+		default:
+			ERR("parse_human_size: invalid suffix");
+			ret = -1;
+			goto free;
+		}
+	}
+
+	*size = base_size << shift;
+
+	/* Check for overflow */
+	if ((*size >> shift) != base_size) {
+		ERR("parse_size_suffix: oops, overflow detected.");
+		ret = -1;
+		goto free;
+	}
+
+	ret = 0;
+
+free:
+	regfree(&regex);
+end:
+	return ret;
+}
diff --git a/src/common/utils.h b/src/common/utils.h
index 2d39cef..61faa4e 100644
--- a/src/common/utils.h
+++ b/src/common/utils.h
@@ -18,6 +18,14 @@
 #ifndef _COMMON_UTILS_H
 #define _COMMON_UTILS_H
 
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdint.h>
+
+#define KIBI_LOG2 10
+#define MEBI_LOG2 20
+#define GIBI_LOG2 30
+
 char *utils_expand_path(const char *path);
 int utils_create_pipe(int *dst);
 int utils_create_pipe_cloexec(int *dst);
diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
index 67e7fe4..4c15731 100644
--- a/tests/unit/Makefile.am
+++ b/tests/unit/Makefile.am
@@ -14,10 +14,11 @@ LIBCOMMON=$(top_builddir)/src/common/libcommon.la
 LIBSESSIOND_COMM=$(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la
 LIBHASHTABLE=$(top_builddir)/src/common/hashtable/libhashtable.la
 
+# Define test programs
+noinst_PROGRAMS = test_uri test_session	test_kernel_data test_parse_size_suffix
+
 if HAVE_LIBLTTNG_UST_CTL
-noinst_PROGRAMS = test_uri test_session test_ust_data test_kernel_data
-else
-noinst_PROGRAMS = test_uri test_session	test_kernel_data
+noinst_PROGRAMS += test_ust_data
 endif
 
 # URI unit tests
@@ -69,3 +70,11 @@ test_kernel_data_SOURCES = test_kernel_data.c
 test_kernel_data_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBSESSIOND_COMM) $(LIBHASHTABLE) \
 						 -lrt
 test_kernel_data_LDADD += $(KERN_DATA_TRACE)
+
+# parse_size_suffix unit test
+PARSE_SIZE_SUFFIX=$(top_srcdir)/src/common/utils.o \
+		$(top_srcdir)/src/common/runas.o
+
+test_parse_size_suffix_SOURCES = test_parse_size_suffix.c
+test_parse_size_suffix_LDADD = $(LIBTAP) $(LIBHASHTABLE) $(LIBCOMMON)
+test_parse_size_suffix_LDADD += $(PARSE_SIZE_SUFFIX)
diff --git a/tests/unit/test_parse_size_suffix.c b/tests/unit/test_parse_size_suffix.c
new file mode 100644
index 0000000..d3c3bda
--- /dev/null
+++ b/tests/unit/test_parse_size_suffix.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright (C) - 2013 Simon Marchi <simon.marchi@polymtl.ca>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by as
+ * published by the Free Software Foundation; only version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 51
+ * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <assert.h>
+#include <string.h>
+#include <stdio.h>
+
+#include <tap/tap.h>
+
+#include <src/common/utils.h>
+
+/* For lttngerr.h */
+int lttng_opt_quiet = 1;
+int lttng_opt_verbose = 3;
+
+/* Valid test cases */
+static char *valid_tests_inputs[] = { "0", "1234", "16k", "128K", "32M", "1024G" };
+static uint64_t valid_tests_expected_results[] = {0, 1234, 16384, 131072, 33554432, 1099511627776};
+static const int num_valid_tests = sizeof(valid_tests_inputs) / sizeof(valid_tests_inputs[0]);
+
+/* Invalid test cases */
+static char *invalid_tests_inputs[] = { "", "-1", "k", "4611686018427387904G" };
+static const int num_invalid_tests = sizeof(invalid_tests_inputs) / sizeof(invalid_tests_inputs[0]);
+
+void test_parse_size_suffix(void)
+{
+	uint64_t result;
+	int ret;
+	int i;
+
+	// Test valid cases
+	for (i = 0; i < num_valid_tests; i++) {
+		char name[100];
+		sprintf(name, "testing %s", valid_tests_inputs[i]);
+
+		ret = parse_size_suffix(valid_tests_inputs[i], &result);
+		ok(ret == 0 && result == valid_tests_expected_results[i], name);
+	}
+
+	// Test invalid cases
+	for (i = 0; i < num_invalid_tests; i++) {
+		char name[100];
+		sprintf(name, "testing %s", invalid_tests_inputs[i]);
+
+		ret = parse_size_suffix(invalid_tests_inputs[i], &result);
+		ok(ret != 0, name);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	plan_tests(num_valid_tests + num_invalid_tests);
+
+	diag("parse_size_suffix tests");
+
+	test_parse_size_suffix();
+
+	return exit_status();
+}
-- 
1.7.10.4
