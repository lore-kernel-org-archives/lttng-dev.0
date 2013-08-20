From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH babeltrace 1/5] Tests: Move TAP helpers to
	tests/utils/tap
Date: Tue, 20 Aug 2013 17:38:17 -0400
Message-ID: <1377034701-5142-1-git-send-email-christian.babeux__30566.1101280295$1377034790$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VBtdL-0005Pf-77
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 17:38:43 -0400
Received: by mail-qa0-f42.google.com with SMTP id bv4so2827734qab.1
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 14:38:29 -0700 (PDT)
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

tests/utils/tap/tap.{h,c}:
For use in C tests. You can link against libtap with the usual automake
mechanisms.

New TAP helper:

tests/utils/tap/tap.sh:
For use in shell scripts tests. Source the script
(e.g. source "tests/utils/tap/tap.sh") to use the relevants TAP functions.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 configure.ac                |   2 +
 tests/Makefile.am           |   2 +-
 tests/lib/Makefile.am       |  12 +-
 tests/lib/README.tap        |   2 -
 tests/lib/tap.c             | 433 -----------------------------------------
 tests/lib/tap.h             |  89 ---------
 tests/lib/test-bitfield.c   |   2 +-
 tests/lib/test-seeks.c      |   2 +-
 tests/utils/Makefile.am     |   1 +
 tests/utils/tap/Makefile.am |   4 +
 tests/utils/tap/tap.c       | 433 +++++++++++++++++++++++++++++++++++++++++
 tests/utils/tap/tap.h       |  89 +++++++++
 tests/utils/tap/tap.sh      | 456 ++++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 995 insertions(+), 532 deletions(-)
 delete mode 100644 tests/lib/README.tap
 delete mode 100644 tests/lib/tap.c
 delete mode 100644 tests/lib/tap.h
 create mode 100644 tests/utils/Makefile.am
 create mode 100644 tests/utils/tap/Makefile.am
 create mode 100644 tests/utils/tap/tap.c
 create mode 100644 tests/utils/tap/tap.h
 create mode 100755 tests/utils/tap/tap.sh

diff --git a/configure.ac b/configure.ac
index fdefe2a..f38bfb7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -134,6 +134,8 @@ AC_CONFIG_FILES([
 	include/Makefile
 	tests/Makefile
 	tests/lib/Makefile
+	tests/utils/Makefile
+	tests/utils/tap/Makefile
 	extras/Makefile
 	extras/valgrind/Makefile
 	babeltrace.pc
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 816fa66..cf68aac 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -1,6 +1,6 @@
 AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include
 
-SUBDIRS = lib
+SUBDIRS = utils lib
 
 EXTRA_DIST = runall.sh ctf-traces/**
 
diff --git a/tests/lib/Makefile.am b/tests/lib/Makefile.am
index 01831de..6ae694d 100644
--- a/tests/lib/Makefile.am
+++ b/tests/lib/Makefile.am
@@ -1,21 +1,23 @@
-AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include
+AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include -I$(top_srcdir)/tests/utils
 
 noinst_LIBRARIES = libtestcommon.a
 
-libtestcommon_a_SOURCES = tap.c tap.h common.c common.h
+LIBTAP=$(top_builddir)/tests/utils/tap/libtap.la
 
-test_seeks_LDADD = libtestcommon.a \
+libtestcommon_a_SOURCES = common.c common.h
+
+test_seeks_LDADD = $(LIBTAP) libtestcommon.a \
 	$(top_builddir)/lib/libbabeltrace.la \
 	$(top_builddir)/formats/ctf/libbabeltrace-ctf.la
 
-test_bitfield_LDADD = libtestcommon.a
+test_bitfield_LDADD = $(LIBTAP) libtestcommon.a
 
 noinst_PROGRAMS = test-seeks test-bitfield
 
 test_seeks_SOURCES = test-seeks.c
 test_bitfield_SOURCES = test-bitfield.c
 
-EXTRA_DIST = README.tap runall.sh
+EXTRA_DIST = runall.sh
 
 check-am:
 	./runall.sh
diff --git a/tests/lib/README.tap b/tests/lib/README.tap
deleted file mode 100644
index e99e7b2..0000000
--- a/tests/lib/README.tap
+++ /dev/null
@@ -1,2 +0,0 @@
-tap.c and tap.h were taken from
-http://jc.ngo.org.uk/trac-bin/trac.cgi/wiki/LibTap
diff --git a/tests/lib/tap.c b/tests/lib/tap.c
deleted file mode 100644
index 8bf72f6..0000000
--- a/tests/lib/tap.c
+++ /dev/null
@@ -1,433 +0,0 @@
-/*-
- * Copyright (c) 2004 Nik Clayton
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- */
-
-#define _GNU_SOURCE
-#include <ctype.h>
-#include <stdarg.h>
-#include <stdio.h>
-#include <stdlib.h>
-
-#include "tap.h"
-
-static int no_plan = 0;
-static int skip_all = 0;
-static int have_plan = 0;
-static unsigned int test_count = 0; /* Number of tests that have been run */
-static unsigned int e_tests = 0; /* Expected number of tests to run */
-static unsigned int failures = 0; /* Number of tests that failed */
-static char *todo_msg = NULL;
-static char *todo_msg_fixed = "libtap malloc issue";
-static int todo = 0;
-static int test_died = 0;
-
-/* Encapsulate the pthread code in a conditional.  In the absence of
-   libpthread the code does nothing */
-#ifdef HAVE_LIBPTHREAD
-#include <pthread.h>
-static pthread_mutex_t M = PTHREAD_MUTEX_INITIALIZER;
-# define LOCK pthread_mutex_lock(&M);
-# define UNLOCK pthread_mutex_unlock(&M);
-#else
-# define LOCK
-# define UNLOCK
-#endif
-
-static void _expected_tests(unsigned int);
-static void _tap_init(void);
-static void _cleanup(void);
-
-/*
- * Generate a test result.
- *
- * ok -- boolean, indicates whether or not the test passed.
- * test_name -- the name of the test, may be NULL
- * test_comment -- a comment to print afterwards, may be NULL
- */
-unsigned int
-_gen_result(int ok, const char *func, char *file, unsigned int line,
-	    char *test_name, ...)
-{
-	va_list ap;
-	char *local_test_name = NULL;
-	char *c;
-	int name_is_digits;
-
-	LOCK;
-
-	test_count++;
-
-	/* Start by taking the test name and performing any printf()
-	   expansions on it */
-	if(test_name != NULL) {
-		va_start(ap, test_name);
-		if (vasprintf(&local_test_name, test_name, ap) == -1) {
-			local_test_name = NULL;
-		}
-		va_end(ap);
-
-		/* Make sure the test name contains more than digits
-		   and spaces.  Emit an error message and exit if it
-		   does */
-		if(local_test_name) {
-			name_is_digits = 1;
-			for(c = local_test_name; *c != '\0'; c++) {
-				if(!isdigit(*c) && !isspace(*c)) {
-					name_is_digits = 0;
-					break;
-				}
-			}
-
-			if(name_is_digits) {
-				diag("    You named your test '%s'.  You shouldn't use numbers for your test names.", local_test_name);
-				diag("    Very confusing.");
-			}
-		}
-	}
-
-	if(!ok) {
-		printf("not ");
-		failures++;
-	}
-
-	printf("ok %d", test_count);
-
-	if(test_name != NULL) {
-		printf(" - ");
-
-		/* Print the test name, escaping any '#' characters it
-		   might contain */
-		if(local_test_name != NULL) {
-			flockfile(stdout);
-			for(c = local_test_name; *c != '\0'; c++) {
-				if(*c == '#')
-					fputc('\\', stdout);
-				fputc((int)*c, stdout);
-			}
-			funlockfile(stdout);
-		} else {	/* vasprintf() failed, use a fixed message */
-			printf("%s", todo_msg_fixed);
-		}
-	}
-
-	/* If we're in a todo_start() block then flag the test as being
-	   TODO.  todo_msg should contain the message to print at this
-	   point.  If it's NULL then asprintf() failed, and we should
-	   use the fixed message.
-
-	   This is not counted as a failure, so decrement the counter if
-	   the test failed. */
-	if(todo) {
-		printf(" # TODO %s", todo_msg ? todo_msg : todo_msg_fixed);
-		if(!ok)
-			failures--;
-	}
-
-	printf("\n");
-
-	if(!ok) {
-		if(getenv("HARNESS_ACTIVE") != NULL)
-			fputs("\n", stderr);
-
-		diag("    Failed %stest (%s:%s() at line %d)",
-		     todo ? "(TODO) " : "", file, func, line);
-	}
-	free(local_test_name);
-
-	UNLOCK;
-
-	/* We only care (when testing) that ok is positive, but here we
-	   specifically only want to return 1 or 0 */
-	return ok ? 1 : 0;
-}
-
-/*
- * Initialise the TAP library.  Will only do so once, however many times it's
- * called.
- */
-void
-_tap_init(void)
-{
-	static int run_once = 0;
-
-	if(!run_once) {
-		atexit(_cleanup);
-
-		/* stdout needs to be unbuffered so that the output appears
-		   in the same place relative to stderr output as it does
-		   with Test::Harness */
-		setbuf(stdout, 0);
-		run_once = 1;
-	}
-}
-
-/*
- * Note that there's no plan.
- */
-int
-plan_no_plan(void)
-{
-
-	LOCK;
-
-	_tap_init();
-
-	if(have_plan != 0) {
-		fprintf(stderr, "You tried to plan twice!\n");
-		test_died = 1;
-		UNLOCK;
-		exit(255);
-	}
-
-	have_plan = 1;
-	no_plan = 1;
-
-	UNLOCK;
-
-	return 1;
-}
-
-/*
- * Note that the plan is to skip all tests
- */
-int
-plan_skip_all(char *reason)
-{
-
-	LOCK;
-
-	_tap_init();
-
-	skip_all = 1;
-
-	printf("1..0");
-
-	if(reason != NULL)
-		printf(" # Skip %s", reason);
-
-	printf("\n");
-
-	UNLOCK;
-
-	exit(0);
-}
-
-/*
- * Note the number of tests that will be run.
- */
-int
-plan_tests(unsigned int tests)
-{
-
-	LOCK;
-
-	_tap_init();
-
-	if(have_plan != 0) {
-		fprintf(stderr, "You tried to plan twice!\n");
-		test_died = 1;
-		UNLOCK;
-		exit(255);
-	}
-
-	if(tests == 0) {
-		fprintf(stderr, "You said to run 0 tests!  You've got to run something.\n");
-		test_died = 1;
-		UNLOCK;
-		exit(255);
-	}
-
-	have_plan = 1;
-
-	_expected_tests(tests);
-
-	UNLOCK;
-
-	return e_tests;
-}
-
-unsigned int
-diag(char *fmt, ...)
-{
-	va_list ap;
-
-	fputs("# ", stderr);
-
-	va_start(ap, fmt);
-	vfprintf(stderr, fmt, ap);
-	va_end(ap);
-
-	fputs("\n", stderr);
-
-	return 0;
-}
-
-void
-_expected_tests(unsigned int tests)
-{
-
-	printf("1..%d\n", tests);
-	e_tests = tests;
-}
-
-int
-skip(unsigned int n, char *fmt, ...)
-{
-	va_list ap;
-	char *skip_msg = NULL;
-
-	LOCK;
-
-	va_start(ap, fmt);
-	if (asprintf(&skip_msg, fmt, ap) == -1) {
-		skip_msg = NULL;
-	}
-	va_end(ap);
-
-	while(n-- > 0) {
-		test_count++;
-		printf("ok %d # skip %s\n", test_count,
-		       skip_msg != NULL ?
-		       skip_msg : "libtap():malloc() failed");
-	}
-
-	free(skip_msg);
-
-	UNLOCK;
-
-	return 1;
-}
-
-void
-todo_start(char *fmt, ...)
-{
-	va_list ap;
-
-	LOCK;
-
-	va_start(ap, fmt);
-	if (vasprintf(&todo_msg, fmt, ap) == -1) {
-		todo_msg = NULL;
-	}
-	va_end(ap);
-
-	todo = 1;
-
-	UNLOCK;
-}
-
-void
-todo_end(void)
-{
-
-	LOCK;
-
-	todo = 0;
-	free(todo_msg);
-
-	UNLOCK;
-}
-
-int
-exit_status(void)
-{
-	int r;
-
-	LOCK;
-
-	/* If there's no plan, just return the number of failures */
-	if(no_plan || !have_plan) {
-		UNLOCK;
-		return failures;
-	}
-
-	/* Ran too many tests?  Return the number of tests that were run
-	   that shouldn't have been */
-	if(e_tests < test_count) {
-		r = test_count - e_tests;
-		UNLOCK;
-		return r;
-	}
-
-	/* Return the number of tests that failed + the number of tests
-	   that weren't run */
-	r = failures + e_tests - test_count;
-	UNLOCK;
-
-	return r;
-}
-
-/*
- * Cleanup at the end of the run, produce any final output that might be
- * required.
- */
-void
-_cleanup(void)
-{
-
-	LOCK;
-
-	/* If plan_no_plan() wasn't called, and we don't have a plan,
-	   and we're not skipping everything, then something happened
-	   before we could produce any output */
-	if(!no_plan && !have_plan && !skip_all) {
-		diag("Looks like your test died before it could output anything.");
-		UNLOCK;
-		return;
-	}
-
-	if(test_died) {
-		diag("Looks like your test died just after %d.", test_count);
-		UNLOCK;
-		return;
-	}
-
-
-	/* No plan provided, but now we know how many tests were run, and can
-	   print the header at the end */
-	if(!skip_all && (no_plan || !have_plan)) {
-		printf("1..%d\n", test_count);
-	}
-
-	if((have_plan && !no_plan) && e_tests < test_count) {
-		diag("Looks like you planned %d %s but ran %d extra.",
-		     e_tests, e_tests == 1 ? "test" : "tests", test_count - e_tests);
-		UNLOCK;
-		return;
-	}
-
-	if((have_plan || !no_plan) && e_tests > test_count) {
-		diag("Looks like you planned %d %s but only ran %d.",
-		     e_tests, e_tests == 1 ? "test" : "tests", test_count);
-		UNLOCK;
-		return;
-	}
-
-	if(failures)
-		diag("Looks like you failed %d %s of %d.",
-		     failures, failures == 1 ? "test" : "tests", test_count);
-
-	UNLOCK;
-}
diff --git a/tests/lib/tap.h b/tests/lib/tap.h
deleted file mode 100644
index 0f05943..0000000
--- a/tests/lib/tap.h
+++ /dev/null
@@ -1,89 +0,0 @@
-/*-
- * Copyright (c) 2004 Nik Clayton
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- */
-
-/* '## __VA_ARGS__' is a gcc'ism. C99 doesn't allow the token pasting
-   and requires the caller to add the final comma if they've ommitted
-   the optional arguments */
-#ifdef __GNUC__
-# define ok(e, test, ...) ((e) ?					\
-			   _gen_result(1, __func__, __FILE__, __LINE__,	\
-				       test, ## __VA_ARGS__) :		\
-			   _gen_result(0, __func__, __FILE__, __LINE__,	\
-				       test, ## __VA_ARGS__))
-
-# define ok1(e) ((e) ?							\
-		 _gen_result(1, __func__, __FILE__, __LINE__, "%s", #e) : \
-		 _gen_result(0, __func__, __FILE__, __LINE__, "%s", #e))
-
-# define pass(test, ...) ok(1, test, ## __VA_ARGS__);
-# define fail(test, ...) ok(0, test, ## __VA_ARGS__);
-
-# define skip_start(test, n, fmt, ...)			\
-	do {						\
-		if((test)) {				\
-			skip(n, fmt, ## __VA_ARGS__);	\
-			continue;			\
-		}
-#elif __STDC_VERSION__ >= 199901L /* __GNUC__ */
-# define ok(e, ...) ((e) ?						\
-		     _gen_result(1, __func__, __FILE__, __LINE__,	\
-				 __VA_ARGS__) :				\
-		     _gen_result(0, __func__, __FILE__, __LINE__,	\
-				 __VA_ARGS__))
-
-# define ok1(e) ((e) ?							\
-		 _gen_result(1, __func__, __FILE__, __LINE__, "%s", #e) : \
-		 _gen_result(0, __func__, __FILE__, __LINE__, "%s", #e))
-
-# define pass(...) ok(1, __VA_ARGS__);
-# define fail(...) ok(0, __VA_ARGS__);
-
-# define skip_start(test, n, ...)			\
-	do {						\
-		if((test)) {				\
-			skip(n,  __VA_ARGS__);		\
-			continue;			\
-		}
-#else /* __STDC_VERSION__ */
-# error "Needs gcc or C99 compiler for variadic macros."
-#endif /* __STDC_VERSION__ */
-
-#define skip_end() } while(0);
-
-unsigned int _gen_result(int, const char *, char *, unsigned int, char *, ...);
-
-int plan_no_plan(void);
-int plan_skip_all(char *);
-int plan_tests(unsigned int);
-
-unsigned int diag(char *, ...);
-
-int skip(unsigned int, char *, ...);
-
-void todo_start(char *, ...);
-void todo_end(void);
-
-int exit_status(void);
diff --git a/tests/lib/test-bitfield.c b/tests/lib/test-bitfield.c
index 2cb7a74..16e8a57 100644
--- a/tests/lib/test-bitfield.c
+++ b/tests/lib/test-bitfield.c
@@ -25,7 +25,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 
-#include "tap.h"
+#include <tap/tap.h>
 
 unsigned int glob;
 
diff --git a/tests/lib/test-seeks.c b/tests/lib/test-seeks.c
index a7b1360..b33f80d 100644
--- a/tests/lib/test-seeks.c
+++ b/tests/lib/test-seeks.c
@@ -29,8 +29,8 @@
 #include <errno.h>
 #include <limits.h>
 
+#include <tap/tap.h>
 #include "common.h"
-#include "tap.h"
 
 #define NR_TESTS	29
 
diff --git a/tests/utils/Makefile.am b/tests/utils/Makefile.am
new file mode 100644
index 0000000..feae65a
--- /dev/null
+++ b/tests/utils/Makefile.am
@@ -0,0 +1 @@
+SUBDIRS = tap
diff --git a/tests/utils/tap/Makefile.am b/tests/utils/tap/Makefile.am
new file mode 100644
index 0000000..d3b5b58
--- /dev/null
+++ b/tests/utils/tap/Makefile.am
@@ -0,0 +1,4 @@
+noinst_LTLIBRARIES = libtap.la
+libtap_la_SOURCES = tap.c tap.h
+dist_noinst_SCRIPTS = tap.sh
+EXTRA_DIST = tap.sh
diff --git a/tests/utils/tap/tap.c b/tests/utils/tap/tap.c
new file mode 100644
index 0000000..8bf72f6
--- /dev/null
+++ b/tests/utils/tap/tap.c
@@ -0,0 +1,433 @@
+/*-
+ * Copyright (c) 2004 Nik Clayton
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#define _GNU_SOURCE
+#include <ctype.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "tap.h"
+
+static int no_plan = 0;
+static int skip_all = 0;
+static int have_plan = 0;
+static unsigned int test_count = 0; /* Number of tests that have been run */
+static unsigned int e_tests = 0; /* Expected number of tests to run */
+static unsigned int failures = 0; /* Number of tests that failed */
+static char *todo_msg = NULL;
+static char *todo_msg_fixed = "libtap malloc issue";
+static int todo = 0;
+static int test_died = 0;
+
+/* Encapsulate the pthread code in a conditional.  In the absence of
+   libpthread the code does nothing */
+#ifdef HAVE_LIBPTHREAD
+#include <pthread.h>
+static pthread_mutex_t M = PTHREAD_MUTEX_INITIALIZER;
+# define LOCK pthread_mutex_lock(&M);
+# define UNLOCK pthread_mutex_unlock(&M);
+#else
+# define LOCK
+# define UNLOCK
+#endif
+
+static void _expected_tests(unsigned int);
+static void _tap_init(void);
+static void _cleanup(void);
+
+/*
+ * Generate a test result.
+ *
+ * ok -- boolean, indicates whether or not the test passed.
+ * test_name -- the name of the test, may be NULL
+ * test_comment -- a comment to print afterwards, may be NULL
+ */
+unsigned int
+_gen_result(int ok, const char *func, char *file, unsigned int line,
+	    char *test_name, ...)
+{
+	va_list ap;
+	char *local_test_name = NULL;
+	char *c;
+	int name_is_digits;
+
+	LOCK;
+
+	test_count++;
+
+	/* Start by taking the test name and performing any printf()
+	   expansions on it */
+	if(test_name != NULL) {
+		va_start(ap, test_name);
+		if (vasprintf(&local_test_name, test_name, ap) == -1) {
+			local_test_name = NULL;
+		}
+		va_end(ap);
+
+		/* Make sure the test name contains more than digits
+		   and spaces.  Emit an error message and exit if it
+		   does */
+		if(local_test_name) {
+			name_is_digits = 1;
+			for(c = local_test_name; *c != '\0'; c++) {
+				if(!isdigit(*c) && !isspace(*c)) {
+					name_is_digits = 0;
+					break;
+				}
+			}
+
+			if(name_is_digits) {
+				diag("    You named your test '%s'.  You shouldn't use numbers for your test names.", local_test_name);
+				diag("    Very confusing.");
+			}
+		}
+	}
+
+	if(!ok) {
+		printf("not ");
+		failures++;
+	}
+
+	printf("ok %d", test_count);
+
+	if(test_name != NULL) {
+		printf(" - ");
+
+		/* Print the test name, escaping any '#' characters it
+		   might contain */
+		if(local_test_name != NULL) {
+			flockfile(stdout);
+			for(c = local_test_name; *c != '\0'; c++) {
+				if(*c == '#')
+					fputc('\\', stdout);
+				fputc((int)*c, stdout);
+			}
+			funlockfile(stdout);
+		} else {	/* vasprintf() failed, use a fixed message */
+			printf("%s", todo_msg_fixed);
+		}
+	}
+
+	/* If we're in a todo_start() block then flag the test as being
+	   TODO.  todo_msg should contain the message to print at this
+	   point.  If it's NULL then asprintf() failed, and we should
+	   use the fixed message.
+
+	   This is not counted as a failure, so decrement the counter if
+	   the test failed. */
+	if(todo) {
+		printf(" # TODO %s", todo_msg ? todo_msg : todo_msg_fixed);
+		if(!ok)
+			failures--;
+	}
+
+	printf("\n");
+
+	if(!ok) {
+		if(getenv("HARNESS_ACTIVE") != NULL)
+			fputs("\n", stderr);
+
+		diag("    Failed %stest (%s:%s() at line %d)",
+		     todo ? "(TODO) " : "", file, func, line);
+	}
+	free(local_test_name);
+
+	UNLOCK;
+
+	/* We only care (when testing) that ok is positive, but here we
+	   specifically only want to return 1 or 0 */
+	return ok ? 1 : 0;
+}
+
+/*
+ * Initialise the TAP library.  Will only do so once, however many times it's
+ * called.
+ */
+void
+_tap_init(void)
+{
+	static int run_once = 0;
+
+	if(!run_once) {
+		atexit(_cleanup);
+
+		/* stdout needs to be unbuffered so that the output appears
+		   in the same place relative to stderr output as it does
+		   with Test::Harness */
+		setbuf(stdout, 0);
+		run_once = 1;
+	}
+}
+
+/*
+ * Note that there's no plan.
+ */
+int
+plan_no_plan(void)
+{
+
+	LOCK;
+
+	_tap_init();
+
+	if(have_plan != 0) {
+		fprintf(stderr, "You tried to plan twice!\n");
+		test_died = 1;
+		UNLOCK;
+		exit(255);
+	}
+
+	have_plan = 1;
+	no_plan = 1;
+
+	UNLOCK;
+
+	return 1;
+}
+
+/*
+ * Note that the plan is to skip all tests
+ */
+int
+plan_skip_all(char *reason)
+{
+
+	LOCK;
+
+	_tap_init();
+
+	skip_all = 1;
+
+	printf("1..0");
+
+	if(reason != NULL)
+		printf(" # Skip %s", reason);
+
+	printf("\n");
+
+	UNLOCK;
+
+	exit(0);
+}
+
+/*
+ * Note the number of tests that will be run.
+ */
+int
+plan_tests(unsigned int tests)
+{
+
+	LOCK;
+
+	_tap_init();
+
+	if(have_plan != 0) {
+		fprintf(stderr, "You tried to plan twice!\n");
+		test_died = 1;
+		UNLOCK;
+		exit(255);
+	}
+
+	if(tests == 0) {
+		fprintf(stderr, "You said to run 0 tests!  You've got to run something.\n");
+		test_died = 1;
+		UNLOCK;
+		exit(255);
+	}
+
+	have_plan = 1;
+
+	_expected_tests(tests);
+
+	UNLOCK;
+
+	return e_tests;
+}
+
+unsigned int
+diag(char *fmt, ...)
+{
+	va_list ap;
+
+	fputs("# ", stderr);
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+
+	fputs("\n", stderr);
+
+	return 0;
+}
+
+void
+_expected_tests(unsigned int tests)
+{
+
+	printf("1..%d\n", tests);
+	e_tests = tests;
+}
+
+int
+skip(unsigned int n, char *fmt, ...)
+{
+	va_list ap;
+	char *skip_msg = NULL;
+
+	LOCK;
+
+	va_start(ap, fmt);
+	if (asprintf(&skip_msg, fmt, ap) == -1) {
+		skip_msg = NULL;
+	}
+	va_end(ap);
+
+	while(n-- > 0) {
+		test_count++;
+		printf("ok %d # skip %s\n", test_count,
+		       skip_msg != NULL ?
+		       skip_msg : "libtap():malloc() failed");
+	}
+
+	free(skip_msg);
+
+	UNLOCK;
+
+	return 1;
+}
+
+void
+todo_start(char *fmt, ...)
+{
+	va_list ap;
+
+	LOCK;
+
+	va_start(ap, fmt);
+	if (vasprintf(&todo_msg, fmt, ap) == -1) {
+		todo_msg = NULL;
+	}
+	va_end(ap);
+
+	todo = 1;
+
+	UNLOCK;
+}
+
+void
+todo_end(void)
+{
+
+	LOCK;
+
+	todo = 0;
+	free(todo_msg);
+
+	UNLOCK;
+}
+
+int
+exit_status(void)
+{
+	int r;
+
+	LOCK;
+
+	/* If there's no plan, just return the number of failures */
+	if(no_plan || !have_plan) {
+		UNLOCK;
+		return failures;
+	}
+
+	/* Ran too many tests?  Return the number of tests that were run
+	   that shouldn't have been */
+	if(e_tests < test_count) {
+		r = test_count - e_tests;
+		UNLOCK;
+		return r;
+	}
+
+	/* Return the number of tests that failed + the number of tests
+	   that weren't run */
+	r = failures + e_tests - test_count;
+	UNLOCK;
+
+	return r;
+}
+
+/*
+ * Cleanup at the end of the run, produce any final output that might be
+ * required.
+ */
+void
+_cleanup(void)
+{
+
+	LOCK;
+
+	/* If plan_no_plan() wasn't called, and we don't have a plan,
+	   and we're not skipping everything, then something happened
+	   before we could produce any output */
+	if(!no_plan && !have_plan && !skip_all) {
+		diag("Looks like your test died before it could output anything.");
+		UNLOCK;
+		return;
+	}
+
+	if(test_died) {
+		diag("Looks like your test died just after %d.", test_count);
+		UNLOCK;
+		return;
+	}
+
+
+	/* No plan provided, but now we know how many tests were run, and can
+	   print the header at the end */
+	if(!skip_all && (no_plan || !have_plan)) {
+		printf("1..%d\n", test_count);
+	}
+
+	if((have_plan && !no_plan) && e_tests < test_count) {
+		diag("Looks like you planned %d %s but ran %d extra.",
+		     e_tests, e_tests == 1 ? "test" : "tests", test_count - e_tests);
+		UNLOCK;
+		return;
+	}
+
+	if((have_plan || !no_plan) && e_tests > test_count) {
+		diag("Looks like you planned %d %s but only ran %d.",
+		     e_tests, e_tests == 1 ? "test" : "tests", test_count);
+		UNLOCK;
+		return;
+	}
+
+	if(failures)
+		diag("Looks like you failed %d %s of %d.",
+		     failures, failures == 1 ? "test" : "tests", test_count);
+
+	UNLOCK;
+}
diff --git a/tests/utils/tap/tap.h b/tests/utils/tap/tap.h
new file mode 100644
index 0000000..0f05943
--- /dev/null
+++ b/tests/utils/tap/tap.h
@@ -0,0 +1,89 @@
+/*-
+ * Copyright (c) 2004 Nik Clayton
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+/* '## __VA_ARGS__' is a gcc'ism. C99 doesn't allow the token pasting
+   and requires the caller to add the final comma if they've ommitted
+   the optional arguments */
+#ifdef __GNUC__
+# define ok(e, test, ...) ((e) ?					\
+			   _gen_result(1, __func__, __FILE__, __LINE__,	\
+				       test, ## __VA_ARGS__) :		\
+			   _gen_result(0, __func__, __FILE__, __LINE__,	\
+				       test, ## __VA_ARGS__))
+
+# define ok1(e) ((e) ?							\
+		 _gen_result(1, __func__, __FILE__, __LINE__, "%s", #e) : \
+		 _gen_result(0, __func__, __FILE__, __LINE__, "%s", #e))
+
+# define pass(test, ...) ok(1, test, ## __VA_ARGS__);
+# define fail(test, ...) ok(0, test, ## __VA_ARGS__);
+
+# define skip_start(test, n, fmt, ...)			\
+	do {						\
+		if((test)) {				\
+			skip(n, fmt, ## __VA_ARGS__);	\
+			continue;			\
+		}
+#elif __STDC_VERSION__ >= 199901L /* __GNUC__ */
+# define ok(e, ...) ((e) ?						\
+		     _gen_result(1, __func__, __FILE__, __LINE__,	\
+				 __VA_ARGS__) :				\
+		     _gen_result(0, __func__, __FILE__, __LINE__,	\
+				 __VA_ARGS__))
+
+# define ok1(e) ((e) ?							\
+		 _gen_result(1, __func__, __FILE__, __LINE__, "%s", #e) : \
+		 _gen_result(0, __func__, __FILE__, __LINE__, "%s", #e))
+
+# define pass(...) ok(1, __VA_ARGS__);
+# define fail(...) ok(0, __VA_ARGS__);
+
+# define skip_start(test, n, ...)			\
+	do {						\
+		if((test)) {				\
+			skip(n,  __VA_ARGS__);		\
+			continue;			\
+		}
+#else /* __STDC_VERSION__ */
+# error "Needs gcc or C99 compiler for variadic macros."
+#endif /* __STDC_VERSION__ */
+
+#define skip_end() } while(0);
+
+unsigned int _gen_result(int, const char *, char *, unsigned int, char *, ...);
+
+int plan_no_plan(void);
+int plan_skip_all(char *);
+int plan_tests(unsigned int);
+
+unsigned int diag(char *, ...);
+
+int skip(unsigned int, char *, ...);
+
+void todo_start(char *, ...);
+void todo_end(void);
+
+int exit_status(void);
diff --git a/tests/utils/tap/tap.sh b/tests/utils/tap/tap.sh
new file mode 100755
index 0000000..24ac1aa
--- /dev/null
+++ b/tests/utils/tap/tap.sh
@@ -0,0 +1,456 @@
+#!/bin/bash
+#
+# Copyright 2010 Patrick LeBoutillier <patrick.leboutillier@gmail.com>
+#
+#    This program is free software: you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation, either version 3 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License
+#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+
+_version='1.01'
+
+_plan_set=0
+_no_plan=0
+_skip_all=0
+_test_died=0
+_expected_tests=0
+_executed_tests=0
+_failed_tests=0
+TODO=
+
+
+usage(){
+    cat <<'USAGE'
+tap-functions: A TAP-producing BASH library
+
+PLAN:
+  plan_no_plan
+  plan_skip_all [REASON]
+  plan_tests NB_TESTS
+
+TEST:
+  ok RESULT [NAME]
+  okx COMMAND
+  is RESULT EXPECTED [NAME]
+  isnt RESULT EXPECTED [NAME]
+  like RESULT PATTERN [NAME]
+  unlike RESULT PATTERN [NAME]
+  pass [NAME]
+  fail [NAME]
+
+SKIP:
+  skip [CONDITION] [REASON] [NB_TESTS=1]
+
+  skip $feature_not_present "feature not present" 2 || {
+      is $a "a"
+      is $b "b"
+  }
+
+TODO:
+  Specify TODO mode by setting $TODO:
+    TODO="not implemented yet"
+    ok $result "some not implemented test"
+    unset TODO
+
+OTHER:
+  diag MSG
+
+EXAMPLE:
+  #!/bin/bash
+
+  . tap-functions
+
+  plan_tests 7
+
+  me=$USER
+  is $USER $me "I am myself"
+  like $HOME $me "My home is mine"
+  like "`id`" $me "My id matches myself"
+
+  /bin/ls $HOME 1>&2
+  ok $? "/bin/ls $HOME"
+  # Same thing using okx shortcut
+  okx /bin/ls $HOME
+
+  [[ "`id -u`" != "0" ]]
+  i_am_not_root=$?
+  skip $i_am_not_root "Must be root" || {
+    okx ls /root
+  }
+
+  TODO="figure out how to become root..."
+  okx [ "$HOME" == "/root" ]
+  unset TODO
+USAGE
+    exit
+}
+
+opt=
+set_u=
+while getopts ":sx" opt ; do
+    case $_opt in
+        u) set_u=1 ;;
+        *) usage ;;
+    esac
+done
+shift $(( OPTIND - 1 ))
+# Don't allow uninitialized variables if requested
+[[ -n "$set_u" ]] && set -u
+unset opt set_u
+
+# Used to call _cleanup on shell exit
+trap _exit EXIT
+
+
+plan_no_plan(){
+    (( _plan_set != 0 )) && "You tried to plan twice!"
+
+    _plan_set=1
+    _no_plan=1
+
+    return 0
+}
+
+
+plan_skip_all(){
+    local reason=${1:-''}
+
+    (( _plan_set != 0 )) && _die "You tried to plan twice!"
+
+    _print_plan 0 "Skip $reason"
+
+    _skip_all=1
+    _plan_set=1
+    _exit 0
+
+    return 0
+}
+
+plan_tests(){
+    local tests=${1:?}
+
+    (( _plan_set != 0 )) && _die "You tried to plan twice!"
+    (( tests == 0 )) && _die "You said to run 0 tests!  You've got to run something."
+
+    _print_plan $tests
+    _expected_tests=$tests
+    _plan_set=1
+
+    return $tests
+}
+
+
+_print_plan(){
+    local tests=${1:?}
+    local directive=${2:-''}
+
+    echo -n "1..$tests"
+    [[ -n "$directive" ]] && echo -n " # $directive"
+    echo
+}
+
+
+pass(){
+    local name=$1
+    ok 0 "$name"
+}
+
+
+fail(){
+    local name=$1
+    ok 1 "$name"
+}
+
+# This is the workhorse method that actually
+# prints the tests result.
+ok(){
+    local result=${1:?}
+    local name=${2:-''}
+
+    (( _plan_set == 0 )) && _die "You tried to run a test without a plan!  Gotta have a plan."
+
+    _executed_tests=$(( $_executed_tests + 1 ))
+
+    if [[ -n "$name" ]] ; then
+        if _matches "$name" "^[0-9]+$" ; then
+            diag "    You named your test '$name'.  You shouldn't use numbers for your test names."
+            diag "    Very confusing."
+        fi
+    fi
+
+    if (( result != 0 )) ; then
+        echo -n "not "
+        _failed_tests=$(( _failed_tests + 1 ))
+    fi
+    echo -n "ok $_executed_tests"
+
+    if [[ -n "$name" ]] ; then
+        local ename=${name//\#/\\#}
+        echo -n " - $ename"
+    fi
+
+    if [[ -n "$TODO" ]] ; then
+        echo -n " # TODO $TODO" ;
+        if (( result != 0 )) ; then
+            _failed_tests=$(( _failed_tests - 1 ))
+        fi
+    fi
+
+    echo
+    if (( result != 0 )) ; then
+        local file='tap-functions'
+        local func=
+        local line=
+
+        local i=0
+        local bt=$(caller $i)
+        while _matches "$bt" "tap-functions$" ; do
+            i=$(( $i + 1 ))
+            bt=$(caller $i)
+        done
+        local backtrace=
+        eval $(caller $i | (read line func file ; echo "backtrace=\"$file:$func() at line $line.\""))
+
+        local t=
+        [[ -n "$TODO" ]] && t="(TODO) "
+
+        if [[ -n "$name" ]] ; then
+            diag "  Failed ${t}test '$name'"
+            diag "  in $backtrace"
+        else
+            diag "  Failed ${t}test in $backtrace"
+        fi
+    fi
+
+    return $result
+}
+
+
+okx(){
+    local command="$@"
+
+    local line=
+    diag "Output of '$command':"
+    "$@" | while read line ; do
+        diag "$line"
+    done
+    ok ${PIPESTATUS[0]} "$command"
+}
+
+
+_equals(){
+    local result=${1:?}
+    local expected=${2:?}
+
+    if [[ "$result" == "$expected" ]] ; then
+        return 0
+    else
+        return 1
+    fi
+}
+
+
+# Thanks to Aaron Kangas for the patch to allow regexp matching
+# under bash < 3.
+ _bash_major_version=${BASH_VERSION%%.*}
+_matches(){
+    local result=${1:?}
+    local pattern=${2:?}
+
+    if [[ -z "$result" || -z "$pattern" ]] ; then
+        return 1
+    else
+        if (( _bash_major_version >= 3 )) ; then
+            [[ "$result" =~ "$pattern" ]]
+        else
+            echo "$result" | egrep -q "$pattern"
+        fi
+    fi
+}
+
+
+_is_diag(){
+    local result=${1:?}
+    local expected=${2:?}
+
+    diag "         got: '$result'"
+    diag "    expected: '$expected'"
+}
+
+
+is(){
+    local result=${1:?}
+    local expected=${2:?}
+    local name=${3:-''}
+
+    _equals "$result" "$expected"
+    (( $? == 0 ))
+    ok $? "$name"
+    local r=$?
+    (( r != 0 )) && _is_diag "$result" "$expected"
+    return $r
+}
+
+
+isnt(){
+    local result=${1:?}
+    local expected=${2:?}
+    local name=${3:-''}
+
+    _equals "$result" "$expected"
+    (( $? != 0 ))
+    ok $? "$name"
+    local r=$?
+    (( r != 0 )) && _is_diag "$result" "$expected"
+    return $r
+}
+
+
+like(){
+    local result=${1:?}
+    local pattern=${2:?}
+    local name=${3:-''}
+
+    _matches "$result" "$pattern"
+    (( $? == 0 ))
+    ok $? "$name"
+    local r=$?
+    (( r != 0 )) && diag "    '$result' doesn't match '$pattern'"
+    return $r
+}
+
+
+unlike(){
+    local result=${1:?}
+    local pattern=${2:?}
+    local name=${3:-''}
+
+    _matches "$result" "$pattern"
+    (( $? != 0 ))
+    ok $? "$name"
+    local r=$?
+    (( r != 0 )) && diag "    '$result' matches '$pattern'"
+    return $r
+}
+
+
+skip(){
+    local condition=${1:?}
+    local reason=${2:-''}
+    local n=${3:-1}
+
+    if (( condition == 0 )) ; then
+        local i=
+        for (( i=0 ; i<$n ; i++ )) ; do
+            _executed_tests=$(( _executed_tests + 1 ))
+            echo "ok $_executed_tests # skip: $reason"
+        done
+        return 0
+    else
+        return
+    fi
+}
+
+
+diag(){
+    local msg=${1:?}
+
+    if [[ -n "$msg" ]] ; then
+        echo "# $msg"
+    fi
+
+    return 1
+}
+
+
+_die(){
+    local reason=${1:-'<unspecified error>'}
+
+    echo "$reason" >&2
+    _test_died=1
+    _exit 255
+}
+
+
+BAIL_OUT(){
+    local reason=${1:-''}
+
+    echo "Bail out! $reason" >&2
+    _exit 255
+}
+
+
+_cleanup(){
+    local rc=0
+
+    if (( _plan_set == 0 )) ; then
+        diag "Looks like your test died before it could output anything."
+        return $rc
+    fi
+
+    if (( _test_died != 0 )) ; then
+        diag "Looks like your test died just after $_executed_tests."
+        return $rc
+    fi
+
+    if (( _skip_all == 0 && _no_plan != 0 )) ; then
+        _print_plan $_executed_tests
+    fi
+
+    local s=
+    if (( _no_plan == 0 && _expected_tests < _executed_tests )) ; then
+        s= ; (( _expected_tests > 1 )) && s=s
+        local extra=$(( _executed_tests - _expected_tests ))
+        diag "Looks like you planned $_expected_tests test$s but ran $extra extra."
+        rc=1 ;
+    fi
+
+    if (( _no_plan == 0 && _expected_tests > _executed_tests )) ; then
+        s= ; (( _expected_tests > 1 )) && s=s
+        diag "Looks like you planned $_expected_tests test$s but only ran $_executed_tests."
+    fi
+
+    if (( _failed_tests > 0 )) ; then
+        s= ; (( _failed_tests > 1 )) && s=s
+        diag "Looks like you failed $_failed_tests test$s of $_executed_tests."
+    fi
+
+    return $rc
+}
+
+
+_exit_status(){
+    if (( _no_plan != 0 || _plan_set == 0 )) ; then
+        return $_failed_tests
+    fi
+
+    if (( _expected_tests < _executed_tests )) ; then
+        return $(( _executed_tests - _expected_tests  ))
+    fi
+
+    return $(( _failed_tests + ( _expected_tests - _executed_tests )))
+}
+
+
+_exit(){
+    local rc=${1:-''}
+    if [[ -z "$rc" ]] ; then
+        _exit_status
+        rc=$?
+    fi
+
+    _cleanup
+    local alt_rc=$?
+    (( alt_rc != 0 )) && rc=$alt_rc
+    trap - EXIT
+    exit $rc
+}
-- 
1.8.3.4
