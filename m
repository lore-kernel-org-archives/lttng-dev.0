From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools v6 2/8] Add Unit test to poll
 compatibility layer
Date: Thu, 25 Apr 2019 18:23:28 -0400
Message-ID: <20190425222334.30349-3-ylamarre__8702.05467087857$1556231178$gmane$org@efficios.com>
References: <20190425222334.30349-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44qsCn4nHkz1L3v
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2019 18:23:49 -0400 (EDT)
In-Reply-To: <20190425222334.30349-1-ylamarre@efficios.com>
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

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 .gitignore                          |   1 +
 tests/unit/Makefile.am              |   9 +-
 tests/unit/test_utils_compat_poll.c | 233 ++++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+), 1 deletion(-)
 create mode 100644 tests/unit/test_utils_compat_poll.c

diff --git a/.gitignore b/.gitignore
index 19276012..b5d2a55a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -73,6 +73,7 @@ TAGS
 /tests/unit/test_session
 /tests/unit/test_uri
 /tests/unit/test_ust_data
+/tests/unit/test_utils_compat_poll
 /tests/unit/test_utils_parse_size_suffix
 /tests/unit/test_utils_parse_time_suffix
 /tests/unit/test_utils_expand_path
diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
index 5f485f00..a949d3cd 100644
--- a/tests/unit/Makefile.am
+++ b/tests/unit/Makefile.am
@@ -12,6 +12,7 @@ TESTS = test_kernel_data \
 	test_utils_parse_size_suffix \
 	test_utils_parse_time_suffix \
 	test_utils_expand_path \
+	test_utils_compat_poll \
 	test_string_utils \
 	test_notification \
 	ini_config/test_ini_config
@@ -28,7 +29,8 @@ LIBLTTNG_CTL=$(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la
 # Define test programs
 noinst_PROGRAMS = test_uri test_session test_kernel_data \
                   test_utils_parse_size_suffix test_utils_parse_time_suffix \
-                  test_utils_expand_path test_string_utils test_notification
+                  test_utils_expand_path test_utils_compat_poll \
+                  test_string_utils test_notification
 
 if HAVE_LIBLTTNG_UST_CTL
 noinst_PROGRAMS += test_ust_data
@@ -145,6 +147,11 @@ test_utils_parse_size_suffix_LDADD = $(LIBTAP) $(LIBHASHTABLE) $(LIBCOMMON) $(DL
 test_utils_parse_time_suffix_SOURCES = test_utils_parse_time_suffix.c
 test_utils_parse_time_suffix_LDADD = $(LIBTAP) $(LIBHASHTABLE) $(LIBCOMMON)
 
+# compat_poll unit test
+test_utils_compat_poll_SOURCES = test_utils_compat_poll.c
+test_utils_compat_poll_LDADD  = $(LIBTAP) $(LIBHASHTABLE) $(DL_LIBS) \
+		      $(top_builddir)/src/common/compat/libcompat.la $(LIBCOMMON)
+
 # expand_path unit test
 test_utils_expand_path_SOURCES = test_utils_expand_path.c
 test_utils_expand_path_LDADD = $(LIBTAP) $(LIBHASHTABLE) $(LIBCOMMON) $(DL_LIBS)
diff --git a/tests/unit/test_utils_compat_poll.c b/tests/unit/test_utils_compat_poll.c
new file mode 100644
index 00000000..d4edfe2a
--- /dev/null
+++ b/tests/unit/test_utils_compat_poll.c
@@ -0,0 +1,233 @@
+/*
+ * test_utils_compat_poll.c
+ *
+ * Unit tests for the compatibility layer of poll/epoll API.
+ *
+ * Copyright (C) 2019 Yannick Lamarre <ylamarre@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by as
+ * published by the Free Software Foundation; only version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ */
+
+#include <assert.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include <tap/tap.h>
+
+#include <common/compat/poll.h>
+#include <common/readwrite.h>
+
+/* Verification without trashing test order in the child process */
+#define childok(e, test, ...) do { \
+	if (!(e)) { \
+		diag(test, ## __VA_ARGS__); \
+		_exit(EXIT_FAILURE); \
+	} \
+} while(0)
+
+/* For error.h */
+int lttng_opt_quiet = 1;
+int lttng_opt_verbose;
+int lttng_opt_mi;
+
+#ifdef HAVE_EPOLL
+#define NUM_TESTS 46
+#else
+#define NUM_TESTS 45
+#endif
+
+#ifdef HAVE_EPOLL
+#if defined(HAVE_EPOLL_CREATE1) && defined(EPOLL_CLOEXEC)
+#define CLOE_VALUE EPOLL_CLOEXEC
+#else
+#define CLOE_VALUE FD_CLOEXEC
+#endif
+
+/* Non-zero 8-bits arbitrary value below 0x7f to ensure no sign extension
+ * used to verify that the value is properly propagated throught the pipe.
+ */
+#define MAGIC_VALUE ((char)0x5A)
+
+void test_epoll_compat(void)
+{
+	/*
+	 * Type conversion present to disable warning of anonymous enum from
+	 * compiler.
+	 */
+	ok((int) LTTNG_CLOEXEC == (int) CLOE_VALUE, "epoll's CLOEXEC value");
+}
+#endif
+
+void test_alloc(void)
+{
+	struct lttng_poll_event poll_events;
+
+	lttng_poll_init(&poll_events);
+
+	/* Null pointer */
+	ok(lttng_poll_create(NULL, 1, 0) != 0, "Create over NULL pointer fails");
+	/* Size 0 */
+	ok(lttng_poll_create(&poll_events, 0, 0) != 0, "Create with size 0 fails");
+	/* without CLOEXEC */
+	ok(lttng_poll_create(&poll_events, 1, 0) == 0, "Create valid poll set succeeds");
+	/*
+	 * lttng_poll_event structure untested due to incompatibility across
+	 * sublayers. lttng_poll_clean cannot be tested. There is no success
+	 * criteria. Verify set's max size cases.
+	 */
+	lttng_poll_clean(&poll_events);
+}
+
+/* Tests stuff related to what would be handled with epoll_ctl. */
+void test_add_del(void)
+{
+	struct lttng_poll_event poll_events;
+
+	lttng_poll_init(&poll_events);
+	ok(lttng_poll_add(NULL, 1, LPOLLIN) != 0, "Adding to NULL set fails");
+	ok(lttng_poll_add(&poll_events, 1, LPOLLIN) != 0, "Adding to uninitialized structure fails");
+	ok(lttng_poll_add(&poll_events, -1, LPOLLIN) != 0, "Adding invalid FD fails");
+
+	lttng_poll_create(&poll_events, 1, 0);
+	ok(LTTNG_POLL_GETNB(&poll_events) == 0, "Set created empty");
+
+	ok(lttng_poll_add(NULL, 1, LPOLLIN) != 0, "Adding to NULL set fails");
+	ok(LTTNG_POLL_GETNB(&poll_events) == 0, "Set still empty");
+	ok(lttng_poll_add(&poll_events, -1, LPOLLIN) != 0, "Adding invalid FD fails");
+	ok(LTTNG_POLL_GETNB(&poll_events) == 0, "Set still empty");
+
+	ok(lttng_poll_add(&poll_events, 1, LPOLLIN) == 0, "Adding valid FD succeeds");
+	ok(LTTNG_POLL_GETNB(&poll_events) == 1, "Nb of elements incremented");
+
+	ok(lttng_poll_del(NULL, 1) != 0, "Removing from NULL set fails");
+	ok(LTTNG_POLL_GETNB(&poll_events) == 1, "Number of FD in set unchanged");
+
+	ok(lttng_poll_del(&poll_events, -1) != 0, "Removing from negative FD fails");
+	ok(LTTNG_POLL_GETNB(&poll_events) == 1, "Number of FD in set unchanged");
+
+	ok(lttng_poll_del(&poll_events, 2) == 0, "Removing invalid FD still succeeds");
+	ok(LTTNG_POLL_GETNB(&poll_events) == 1, "Number of elements unchanged");
+
+	ok(lttng_poll_del(&poll_events, 1) == 0, "Removing valid FD succeeds");
+	ok(LTTNG_POLL_GETNB(&poll_events) == 0, "Nb of elements decremented");
+
+	ok(lttng_poll_del(&poll_events, 1) != 0, "Removing from empty set fails");
+	ok(LTTNG_POLL_GETNB(&poll_events) == 0, "Nb of elements unchanged");
+
+	lttng_poll_clean(&poll_events);
+}
+
+void test_mod_wait(void)
+{
+	struct lttng_poll_event poll_events;
+	struct lttng_poll_event cpoll_events;
+	int hupfd[2];
+	int infd[2];
+	pid_t cpid;
+	char rbuf = 0, tbuf = MAGIC_VALUE;
+	int wstatus;
+
+	lttng_poll_init(&poll_events);
+	lttng_poll_init(&cpoll_events);
+
+	ok(pipe(hupfd) != -1, "pipe function succeeds");
+	ok(pipe(infd) != -1, "pipe function succeeds");
+
+	cpid = fork();
+	if (cpid == 0) {
+		childok(lttng_poll_create(&cpoll_events, 1, 0) == 0, "Create valid poll set succeeds");
+		childok(lttng_poll_mod(NULL, infd[0], LPOLLIN) == -1, "lttng_poll_mod with invalid input returns an error");
+		childok(lttng_poll_mod(&cpoll_events, infd[0], LPOLLIN) == -1, "lttng_poll_mod with invalid input returns an error");
+		childok(lttng_poll_add(&cpoll_events, infd[0], LPOLLHUP) == 0, "Add valid FD succeeds");
+		childok(lttng_poll_mod(&cpoll_events, -1, LPOLLIN) == -1, "lttng_poll_mod with invalid input returns an error");
+		childok(lttng_poll_mod(&cpoll_events, hupfd[0], LPOLLIN) == 0, "lttng_poll_mod on unincluded FD goes on");
+		childok(lttng_poll_mod(&cpoll_events, infd[0], LPOLLIN) == 0, "Modify event type succeeds");
+		childok(close(infd[1]) == 0, "Close valid FD succeeds");
+		childok(lttng_poll_wait(&cpoll_events, -1) == 1, "Wait on close times out");
+		childok(lttng_read(infd[0], &rbuf, 1) == 1, "Data is present in the pipe");
+		childok(rbuf == MAGIC_VALUE, "Received data is consistent with transmitted data");
+		childok(lttng_poll_del(&cpoll_events, infd[0]) == 0, "Removing valid FD succeeds");
+		childok(close(infd[0]) == 0, "Close valid FD succeeds");
+		childok(close(hupfd[0]) == 0, "Close valid FD succeeds");
+		childok(close(hupfd[1]) == 0, "Close valid FD succeeds");
+		lttng_poll_clean(&cpoll_events);
+		_exit(EXIT_SUCCESS);
+	} else {
+		ok(close(hupfd[1]) == 0, "Close valid FD succeeds");
+		ok(close(infd[0]) == 0, "Close valid FD succeeds");
+
+		ok(lttng_poll_wait(NULL, -1) == -1, "lttng_poll_wait call with invalid input returns error");
+
+		ok(lttng_poll_create(&poll_events, 1, 0) == 0, "Create valid poll set succeeds");
+		ok(lttng_poll_wait(&poll_events, -1) == -1, "lttng_poll_wait call with invalid input returns error");
+		ok(lttng_poll_add(&poll_events, hupfd[0], LPOLLHUP) == 0, "Add valid FD succeeds");
+		ok(lttng_write(infd[1], &tbuf, 1) == 1, "Write to pipe succeeds");
+		ok(lttng_poll_wait(&poll_events, -1) == 1, "Wakes up on one event");
+		ok(lttng_poll_del(&poll_events, hupfd[0]) == 0, "Removing valid FD succeeds");
+		ok(close(hupfd[0]) == 0, "Close valid FD succeeds");
+		ok(close(infd[1]) == 0, "Close valid FD succeeds");
+		lttng_poll_clean(&poll_events);
+
+		ok(waitpid(cpid, &wstatus, 0) == cpid, "waitpid returns child's pid");
+		ok(WIFEXITED(wstatus) == 1, "Child process exited");
+		ok(WEXITSTATUS(wstatus) == (EXIT_SUCCESS & 0xff), "EXIT_SUCCESS is %i while exit status is %i\n", EXIT_SUCCESS, WEXITSTATUS(wstatus));
+	}
+}
+
+void test_func_def(void)
+{
+#ifdef LTTNG_POLL_GETFD
+#define PASS_GETFD 1
+#else
+#define PASS_GETFD 0
+#endif
+
+#ifdef LTTNG_POLL_GETEV
+#define PASS_GETEV 1
+#else
+#define PASS_GETEV 0
+#endif
+
+#ifdef LTTNG_POLL_GETSZ
+#define PASS_GETSZ 1
+#else
+#define PASS_GETSZ 0
+#endif
+
+#ifdef LTTNG_POLL_GET_PREV_FD
+#define PASS_GET_PREV_FD 1
+#else
+#define PASS_GET_PREV_FD 0
+#endif
+
+	ok(lttng_poll_reset == lttng_poll_reset, "lttng_poll_reset is defined");
+	ok(lttng_poll_init == lttng_poll_init , "lttng_poll_init is defined");
+	ok(PASS_GETFD, "GETFD is defined");
+	ok(PASS_GETEV, "GETEV is defined");
+	ok(PASS_GETSZ, "GETSZ is defined");
+	ok(PASS_GET_PREV_FD, "GET_PREV_FD is defined");
+}
+
+int main(void)
+{
+	plan_tests(NUM_TESTS);
+#ifdef HAVE_EPOLL
+	test_epoll_compat();
+#endif
+	test_func_def();
+	test_alloc();
+	test_add_del();
+	test_mod_wait();
+	return exit_status();
+}
-- 
2.11.0
