From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 1/3] Cleanup tests
Date: Wed, 24 Jul 2013 09:59:56 -0400
Message-ID: <20130724135956.GC16524__25172.6563125432$1374674461$gmane$org@Krystal>
References: <1374645347-20312-1-git-send-email-soariez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V1zbl-0004S6-5v
	for lttng-dev@lists.lttng.org; Wed, 24 Jul 2013 10:00:09 -0400
Content-Disposition: inline
In-Reply-To: <1374645347-20312-1-git-send-email-soariez@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <soariez@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Zifei Tong (soariez@gmail.com) wrote:
> Move TAP related code to tests/utils.
> Remove scripts only used by obsolete tests.

This patch alone cannot be built without the following patches.

> 
> Signed-off-by: Zifei Tong <soariez@gmail.com>
> ---
>  configure.ac               |   1 +
>  tests/Makefile.am          |   8 +-
>  tests/snprintf/Makefile.am |   7 +-
>  tests/tap.c                | 433 ------------------------------------------
>  tests/tap.h                |  89 ---------
>  tests/tap.sh               | 456 ---------------------------------------------
>  tests/test_functions.sh    | 129 -------------
>  tests/trace_matches        | 104 -----------
>  tests/utils/Makefile.am    |   3 +
>  tests/utils/tap.c          | 433 ++++++++++++++++++++++++++++++++++++++++++
>  tests/utils/tap.h          |  89 +++++++++
>  tests/utils/tap.sh         | 456 +++++++++++++++++++++++++++++++++++++++++++++
>  12 files changed, 987 insertions(+), 1221 deletions(-)
>  delete mode 100644 tests/tap.c
>  delete mode 100644 tests/tap.h
>  delete mode 100644 tests/tap.sh
>  delete mode 100644 tests/test_functions.sh
>  delete mode 100755 tests/trace_matches
>  create mode 100644 tests/utils/Makefile.am
>  create mode 100644 tests/utils/tap.c
>  create mode 100644 tests/utils/tap.h
>  create mode 100755 tests/utils/tap.sh
> 
> diff --git a/configure.ac b/configure.ac
> index 84d121e..8b862ed 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -283,6 +283,7 @@ AC_CONFIG_FILES([
>  	tests/hello.cxx/Makefile
>  	tests/same_line_tracepoint/Makefile
>  	tests/snprintf/Makefile
> +	tests/utils/Makefile
>  	lttng-ust.pc
>  ])
>  
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index 317edcb..d9a7a30 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -1,14 +1,10 @@
> -SUBDIRS = . hello same_line_tracepoint snprintf
> +SUBDIRS = utils hello same_line_tracepoint snprintf benchmark
>  
>  if CXX_WORKS
>  SUBDIRS += hello.cxx
>  endif
>  
> -dist_noinst_SCRIPTS = test_loop run.sh trace_matches unit_tests
> -
> -noinst_LIBRARIES = libtap.a
> -
> -libtap_a_SOURCES = tap.c tap.h
> +dist_noinst_SCRIPTS = test_loop run.sh unit_tests
>  
>  check-am:
>  	./run.sh unit_tests
> diff --git a/tests/snprintf/Makefile.am b/tests/snprintf/Makefile.am
> index d9f9da0..2ceb948 100644
> --- a/tests/snprintf/Makefile.am
> +++ b/tests/snprintf/Makefile.am
> @@ -1,9 +1,8 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/tests/
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/tests/utils
>  
>  noinst_PROGRAMS = prog
>  prog_SOURCES = prog.c
>  prog_LDADD = $(top_builddir)/snprintf/libustsnprintf.la \
> -	$(top_builddir)/tests/libtap.a
> +	$(top_builddir)/tests/utils/libtap.a
>  
> -noinst_SCRIPT = test_snprintf
> -EXTRA_DIST = test_snprintf
> +dist_noinst_SCRIPTS = test_snprintf
> diff --git a/tests/tap.c b/tests/tap.c
> deleted file mode 100644
> index 8bf72f6..0000000
> --- a/tests/tap.c
> +++ /dev/null
> @@ -1,433 +0,0 @@
> -/*-
> - * Copyright (c) 2004 Nik Clayton
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions and the following disclaimer.
> - * 2. Redistributions in binary form must reproduce the above copyright
> - *    notice, this list of conditions and the following disclaimer in the
> - *    documentation and/or other materials provided with the distribution.
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> - * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
> - * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> - * SUCH DAMAGE.
> - */
> -
> -#define _GNU_SOURCE
> -#include <ctype.h>
> -#include <stdarg.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -
> -#include "tap.h"
> -
> -static int no_plan = 0;
> -static int skip_all = 0;
> -static int have_plan = 0;
> -static unsigned int test_count = 0; /* Number of tests that have been run */
> -static unsigned int e_tests = 0; /* Expected number of tests to run */
> -static unsigned int failures = 0; /* Number of tests that failed */
> -static char *todo_msg = NULL;
> -static char *todo_msg_fixed = "libtap malloc issue";
> -static int todo = 0;
> -static int test_died = 0;
> -
> -/* Encapsulate the pthread code in a conditional.  In the absence of
> -   libpthread the code does nothing */
> -#ifdef HAVE_LIBPTHREAD
> -#include <pthread.h>
> -static pthread_mutex_t M = PTHREAD_MUTEX_INITIALIZER;
> -# define LOCK pthread_mutex_lock(&M);
> -# define UNLOCK pthread_mutex_unlock(&M);
> -#else
> -# define LOCK
> -# define UNLOCK
> -#endif
> -
> -static void _expected_tests(unsigned int);
> -static void _tap_init(void);
> -static void _cleanup(void);
> -
> -/*
> - * Generate a test result.
> - *
> - * ok -- boolean, indicates whether or not the test passed.
> - * test_name -- the name of the test, may be NULL
> - * test_comment -- a comment to print afterwards, may be NULL
> - */
> -unsigned int
> -_gen_result(int ok, const char *func, char *file, unsigned int line,
> -	    char *test_name, ...)
> -{
> -	va_list ap;
> -	char *local_test_name = NULL;
> -	char *c;
> -	int name_is_digits;
> -
> -	LOCK;
> -
> -	test_count++;
> -
> -	/* Start by taking the test name and performing any printf()
> -	   expansions on it */
> -	if(test_name != NULL) {
> -		va_start(ap, test_name);
> -		if (vasprintf(&local_test_name, test_name, ap) == -1) {
> -			local_test_name = NULL;
> -		}
> -		va_end(ap);
> -
> -		/* Make sure the test name contains more than digits
> -		   and spaces.  Emit an error message and exit if it
> -		   does */
> -		if(local_test_name) {
> -			name_is_digits = 1;
> -			for(c = local_test_name; *c != '\0'; c++) {
> -				if(!isdigit(*c) && !isspace(*c)) {
> -					name_is_digits = 0;
> -					break;
> -				}
> -			}
> -
> -			if(name_is_digits) {
> -				diag("    You named your test '%s'.  You shouldn't use numbers for your test names.", local_test_name);
> -				diag("    Very confusing.");
> -			}
> -		}
> -	}
> -
> -	if(!ok) {
> -		printf("not ");
> -		failures++;
> -	}
> -
> -	printf("ok %d", test_count);
> -
> -	if(test_name != NULL) {
> -		printf(" - ");
> -
> -		/* Print the test name, escaping any '#' characters it
> -		   might contain */
> -		if(local_test_name != NULL) {
> -			flockfile(stdout);
> -			for(c = local_test_name; *c != '\0'; c++) {
> -				if(*c == '#')
> -					fputc('\\', stdout);
> -				fputc((int)*c, stdout);
> -			}
> -			funlockfile(stdout);
> -		} else {	/* vasprintf() failed, use a fixed message */
> -			printf("%s", todo_msg_fixed);
> -		}
> -	}
> -
> -	/* If we're in a todo_start() block then flag the test as being
> -	   TODO.  todo_msg should contain the message to print at this
> -	   point.  If it's NULL then asprintf() failed, and we should
> -	   use the fixed message.
> -
> -	   This is not counted as a failure, so decrement the counter if
> -	   the test failed. */
> -	if(todo) {
> -		printf(" # TODO %s", todo_msg ? todo_msg : todo_msg_fixed);
> -		if(!ok)
> -			failures--;
> -	}
> -
> -	printf("\n");
> -
> -	if(!ok) {
> -		if(getenv("HARNESS_ACTIVE") != NULL)
> -			fputs("\n", stderr);
> -
> -		diag("    Failed %stest (%s:%s() at line %d)",
> -		     todo ? "(TODO) " : "", file, func, line);
> -	}
> -	free(local_test_name);
> -
> -	UNLOCK;
> -
> -	/* We only care (when testing) that ok is positive, but here we
> -	   specifically only want to return 1 or 0 */
> -	return ok ? 1 : 0;
> -}
> -
> -/*
> - * Initialise the TAP library.  Will only do so once, however many times it's
> - * called.
> - */
> -void
> -_tap_init(void)
> -{
> -	static int run_once = 0;
> -
> -	if(!run_once) {
> -		atexit(_cleanup);
> -
> -		/* stdout needs to be unbuffered so that the output appears
> -		   in the same place relative to stderr output as it does
> -		   with Test::Harness */
> -		setbuf(stdout, 0);
> -		run_once = 1;
> -	}
> -}
> -
> -/*
> - * Note that there's no plan.
> - */
> -int
> -plan_no_plan(void)
> -{
> -
> -	LOCK;
> -
> -	_tap_init();
> -
> -	if(have_plan != 0) {
> -		fprintf(stderr, "You tried to plan twice!\n");
> -		test_died = 1;
> -		UNLOCK;
> -		exit(255);
> -	}
> -
> -	have_plan = 1;
> -	no_plan = 1;
> -
> -	UNLOCK;
> -
> -	return 1;
> -}
> -
> -/*
> - * Note that the plan is to skip all tests
> - */
> -int
> -plan_skip_all(char *reason)
> -{
> -
> -	LOCK;
> -
> -	_tap_init();
> -
> -	skip_all = 1;
> -
> -	printf("1..0");
> -
> -	if(reason != NULL)
> -		printf(" # Skip %s", reason);
> -
> -	printf("\n");
> -
> -	UNLOCK;
> -
> -	exit(0);
> -}
> -
> -/*
> - * Note the number of tests that will be run.
> - */
> -int
> -plan_tests(unsigned int tests)
> -{
> -
> -	LOCK;
> -
> -	_tap_init();
> -
> -	if(have_plan != 0) {
> -		fprintf(stderr, "You tried to plan twice!\n");
> -		test_died = 1;
> -		UNLOCK;
> -		exit(255);
> -	}
> -
> -	if(tests == 0) {
> -		fprintf(stderr, "You said to run 0 tests!  You've got to run something.\n");
> -		test_died = 1;
> -		UNLOCK;
> -		exit(255);
> -	}
> -
> -	have_plan = 1;
> -
> -	_expected_tests(tests);
> -
> -	UNLOCK;
> -
> -	return e_tests;
> -}
> -
> -unsigned int
> -diag(char *fmt, ...)
> -{
> -	va_list ap;
> -
> -	fputs("# ", stderr);
> -
> -	va_start(ap, fmt);
> -	vfprintf(stderr, fmt, ap);
> -	va_end(ap);
> -
> -	fputs("\n", stderr);
> -
> -	return 0;
> -}
> -
> -void
> -_expected_tests(unsigned int tests)
> -{
> -
> -	printf("1..%d\n", tests);
> -	e_tests = tests;
> -}
> -
> -int
> -skip(unsigned int n, char *fmt, ...)
> -{
> -	va_list ap;
> -	char *skip_msg = NULL;
> -
> -	LOCK;
> -
> -	va_start(ap, fmt);
> -	if (asprintf(&skip_msg, fmt, ap) == -1) {
> -		skip_msg = NULL;
> -	}
> -	va_end(ap);
> -
> -	while(n-- > 0) {
> -		test_count++;
> -		printf("ok %d # skip %s\n", test_count,
> -		       skip_msg != NULL ?
> -		       skip_msg : "libtap():malloc() failed");
> -	}
> -
> -	free(skip_msg);
> -
> -	UNLOCK;
> -
> -	return 1;
> -}
> -
> -void
> -todo_start(char *fmt, ...)
> -{
> -	va_list ap;
> -
> -	LOCK;
> -
> -	va_start(ap, fmt);
> -	if (vasprintf(&todo_msg, fmt, ap) == -1) {
> -		todo_msg = NULL;
> -	}
> -	va_end(ap);
> -
> -	todo = 1;
> -
> -	UNLOCK;
> -}
> -
> -void
> -todo_end(void)
> -{
> -
> -	LOCK;
> -
> -	todo = 0;
> -	free(todo_msg);
> -
> -	UNLOCK;
> -}
> -
> -int
> -exit_status(void)
> -{
> -	int r;
> -
> -	LOCK;
> -
> -	/* If there's no plan, just return the number of failures */
> -	if(no_plan || !have_plan) {
> -		UNLOCK;
> -		return failures;
> -	}
> -
> -	/* Ran too many tests?  Return the number of tests that were run
> -	   that shouldn't have been */
> -	if(e_tests < test_count) {
> -		r = test_count - e_tests;
> -		UNLOCK;
> -		return r;
> -	}
> -
> -	/* Return the number of tests that failed + the number of tests
> -	   that weren't run */
> -	r = failures + e_tests - test_count;
> -	UNLOCK;
> -
> -	return r;
> -}
> -
> -/*
> - * Cleanup at the end of the run, produce any final output that might be
> - * required.
> - */
> -void
> -_cleanup(void)
> -{
> -
> -	LOCK;
> -
> -	/* If plan_no_plan() wasn't called, and we don't have a plan,
> -	   and we're not skipping everything, then something happened
> -	   before we could produce any output */
> -	if(!no_plan && !have_plan && !skip_all) {
> -		diag("Looks like your test died before it could output anything.");
> -		UNLOCK;
> -		return;
> -	}
> -
> -	if(test_died) {
> -		diag("Looks like your test died just after %d.", test_count);
> -		UNLOCK;
> -		return;
> -	}
> -
> -
> -	/* No plan provided, but now we know how many tests were run, and can
> -	   print the header at the end */
> -	if(!skip_all && (no_plan || !have_plan)) {
> -		printf("1..%d\n", test_count);
> -	}
> -
> -	if((have_plan && !no_plan) && e_tests < test_count) {
> -		diag("Looks like you planned %d %s but ran %d extra.",
> -		     e_tests, e_tests == 1 ? "test" : "tests", test_count - e_tests);
> -		UNLOCK;
> -		return;
> -	}
> -
> -	if((have_plan || !no_plan) && e_tests > test_count) {
> -		diag("Looks like you planned %d %s but only ran %d.",
> -		     e_tests, e_tests == 1 ? "test" : "tests", test_count);
> -		UNLOCK;
> -		return;
> -	}
> -
> -	if(failures)
> -		diag("Looks like you failed %d %s of %d.",
> -		     failures, failures == 1 ? "test" : "tests", test_count);
> -
> -	UNLOCK;
> -}
> diff --git a/tests/tap.h b/tests/tap.h
> deleted file mode 100644
> index 0f05943..0000000
> --- a/tests/tap.h
> +++ /dev/null
> @@ -1,89 +0,0 @@
> -/*-
> - * Copyright (c) 2004 Nik Clayton
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions and the following disclaimer.
> - * 2. Redistributions in binary form must reproduce the above copyright
> - *    notice, this list of conditions and the following disclaimer in the
> - *    documentation and/or other materials provided with the distribution.
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> - * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
> - * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> - * SUCH DAMAGE.
> - */
> -
> -/* '## __VA_ARGS__' is a gcc'ism. C99 doesn't allow the token pasting
> -   and requires the caller to add the final comma if they've ommitted
> -   the optional arguments */
> -#ifdef __GNUC__
> -# define ok(e, test, ...) ((e) ?					\
> -			   _gen_result(1, __func__, __FILE__, __LINE__,	\
> -				       test, ## __VA_ARGS__) :		\
> -			   _gen_result(0, __func__, __FILE__, __LINE__,	\
> -				       test, ## __VA_ARGS__))
> -
> -# define ok1(e) ((e) ?							\
> -		 _gen_result(1, __func__, __FILE__, __LINE__, "%s", #e) : \
> -		 _gen_result(0, __func__, __FILE__, __LINE__, "%s", #e))
> -
> -# define pass(test, ...) ok(1, test, ## __VA_ARGS__);
> -# define fail(test, ...) ok(0, test, ## __VA_ARGS__);
> -
> -# define skip_start(test, n, fmt, ...)			\
> -	do {						\
> -		if((test)) {				\
> -			skip(n, fmt, ## __VA_ARGS__);	\
> -			continue;			\
> -		}
> -#elif __STDC_VERSION__ >= 199901L /* __GNUC__ */
> -# define ok(e, ...) ((e) ?						\
> -		     _gen_result(1, __func__, __FILE__, __LINE__,	\
> -				 __VA_ARGS__) :				\
> -		     _gen_result(0, __func__, __FILE__, __LINE__,	\
> -				 __VA_ARGS__))
> -
> -# define ok1(e) ((e) ?							\
> -		 _gen_result(1, __func__, __FILE__, __LINE__, "%s", #e) : \
> -		 _gen_result(0, __func__, __FILE__, __LINE__, "%s", #e))
> -
> -# define pass(...) ok(1, __VA_ARGS__);
> -# define fail(...) ok(0, __VA_ARGS__);
> -
> -# define skip_start(test, n, ...)			\
> -	do {						\
> -		if((test)) {				\
> -			skip(n,  __VA_ARGS__);		\
> -			continue;			\
> -		}
> -#else /* __STDC_VERSION__ */
> -# error "Needs gcc or C99 compiler for variadic macros."
> -#endif /* __STDC_VERSION__ */
> -
> -#define skip_end() } while(0);
> -
> -unsigned int _gen_result(int, const char *, char *, unsigned int, char *, ...);
> -
> -int plan_no_plan(void);
> -int plan_skip_all(char *);
> -int plan_tests(unsigned int);
> -
> -unsigned int diag(char *, ...);
> -
> -int skip(unsigned int, char *, ...);
> -
> -void todo_start(char *, ...);
> -void todo_end(void);
> -
> -int exit_status(void);
> diff --git a/tests/tap.sh b/tests/tap.sh
> deleted file mode 100644
> index 24ac1aa..0000000
> --- a/tests/tap.sh
> +++ /dev/null
> @@ -1,456 +0,0 @@
> -#!/bin/bash
> -#
> -# Copyright 2010 Patrick LeBoutillier <patrick.leboutillier@gmail.com>
> -#
> -#    This program is free software: you can redistribute it and/or modify
> -#    it under the terms of the GNU General Public License as published by
> -#    the Free Software Foundation, either version 3 of the License, or
> -#    (at your option) any later version.
> -#
> -#    This program is distributed in the hope that it will be useful,
> -#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -#    GNU General Public License for more details.
> -#
> -#    You should have received a copy of the GNU General Public License
> -#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
> -
> -
> -_version='1.01'
> -
> -_plan_set=0
> -_no_plan=0
> -_skip_all=0
> -_test_died=0
> -_expected_tests=0
> -_executed_tests=0
> -_failed_tests=0
> -TODO=
> -
> -
> -usage(){
> -    cat <<'USAGE'
> -tap-functions: A TAP-producing BASH library
> -
> -PLAN:
> -  plan_no_plan
> -  plan_skip_all [REASON]
> -  plan_tests NB_TESTS
> -
> -TEST:
> -  ok RESULT [NAME]
> -  okx COMMAND
> -  is RESULT EXPECTED [NAME]
> -  isnt RESULT EXPECTED [NAME]
> -  like RESULT PATTERN [NAME]
> -  unlike RESULT PATTERN [NAME]
> -  pass [NAME]
> -  fail [NAME]
> -
> -SKIP:
> -  skip [CONDITION] [REASON] [NB_TESTS=1]
> -
> -  skip $feature_not_present "feature not present" 2 || {
> -      is $a "a"
> -      is $b "b"
> -  }
> -
> -TODO:
> -  Specify TODO mode by setting $TODO:
> -    TODO="not implemented yet"
> -    ok $result "some not implemented test"
> -    unset TODO
> -
> -OTHER:
> -  diag MSG
> -
> -EXAMPLE:
> -  #!/bin/bash
> -
> -  . tap-functions
> -
> -  plan_tests 7
> -
> -  me=$USER
> -  is $USER $me "I am myself"
> -  like $HOME $me "My home is mine"
> -  like "`id`" $me "My id matches myself"
> -
> -  /bin/ls $HOME 1>&2
> -  ok $? "/bin/ls $HOME"
> -  # Same thing using okx shortcut
> -  okx /bin/ls $HOME
> -
> -  [[ "`id -u`" != "0" ]]
> -  i_am_not_root=$?
> -  skip $i_am_not_root "Must be root" || {
> -    okx ls /root
> -  }
> -
> -  TODO="figure out how to become root..."
> -  okx [ "$HOME" == "/root" ]
> -  unset TODO
> -USAGE
> -    exit
> -}
> -
> -opt=
> -set_u=
> -while getopts ":sx" opt ; do
> -    case $_opt in
> -        u) set_u=1 ;;
> -        *) usage ;;
> -    esac
> -done
> -shift $(( OPTIND - 1 ))
> -# Don't allow uninitialized variables if requested
> -[[ -n "$set_u" ]] && set -u
> -unset opt set_u
> -
> -# Used to call _cleanup on shell exit
> -trap _exit EXIT
> -
> -
> -plan_no_plan(){
> -    (( _plan_set != 0 )) && "You tried to plan twice!"
> -
> -    _plan_set=1
> -    _no_plan=1
> -
> -    return 0
> -}
> -
> -
> -plan_skip_all(){
> -    local reason=${1:-''}
> -
> -    (( _plan_set != 0 )) && _die "You tried to plan twice!"
> -
> -    _print_plan 0 "Skip $reason"
> -
> -    _skip_all=1
> -    _plan_set=1
> -    _exit 0
> -
> -    return 0
> -}
> -
> -plan_tests(){
> -    local tests=${1:?}
> -
> -    (( _plan_set != 0 )) && _die "You tried to plan twice!"
> -    (( tests == 0 )) && _die "You said to run 0 tests!  You've got to run something."
> -
> -    _print_plan $tests
> -    _expected_tests=$tests
> -    _plan_set=1
> -
> -    return $tests
> -}
> -
> -
> -_print_plan(){
> -    local tests=${1:?}
> -    local directive=${2:-''}
> -
> -    echo -n "1..$tests"
> -    [[ -n "$directive" ]] && echo -n " # $directive"
> -    echo
> -}
> -
> -
> -pass(){
> -    local name=$1
> -    ok 0 "$name"
> -}
> -
> -
> -fail(){
> -    local name=$1
> -    ok 1 "$name"
> -}
> -
> -# This is the workhorse method that actually
> -# prints the tests result.
> -ok(){
> -    local result=${1:?}
> -    local name=${2:-''}
> -
> -    (( _plan_set == 0 )) && _die "You tried to run a test without a plan!  Gotta have a plan."
> -
> -    _executed_tests=$(( $_executed_tests + 1 ))
> -
> -    if [[ -n "$name" ]] ; then
> -        if _matches "$name" "^[0-9]+$" ; then
> -            diag "    You named your test '$name'.  You shouldn't use numbers for your test names."
> -            diag "    Very confusing."
> -        fi
> -    fi
> -
> -    if (( result != 0 )) ; then
> -        echo -n "not "
> -        _failed_tests=$(( _failed_tests + 1 ))
> -    fi
> -    echo -n "ok $_executed_tests"
> -
> -    if [[ -n "$name" ]] ; then
> -        local ename=${name//\#/\\#}
> -        echo -n " - $ename"
> -    fi
> -
> -    if [[ -n "$TODO" ]] ; then
> -        echo -n " # TODO $TODO" ;
> -        if (( result != 0 )) ; then
> -            _failed_tests=$(( _failed_tests - 1 ))
> -        fi
> -    fi
> -
> -    echo
> -    if (( result != 0 )) ; then
> -        local file='tap-functions'
> -        local func=
> -        local line=
> -
> -        local i=0
> -        local bt=$(caller $i)
> -        while _matches "$bt" "tap-functions$" ; do
> -            i=$(( $i + 1 ))
> -            bt=$(caller $i)
> -        done
> -        local backtrace=
> -        eval $(caller $i | (read line func file ; echo "backtrace=\"$file:$func() at line $line.\""))
> -
> -        local t=
> -        [[ -n "$TODO" ]] && t="(TODO) "
> -
> -        if [[ -n "$name" ]] ; then
> -            diag "  Failed ${t}test '$name'"
> -            diag "  in $backtrace"
> -        else
> -            diag "  Failed ${t}test in $backtrace"
> -        fi
> -    fi
> -
> -    return $result
> -}
> -
> -
> -okx(){
> -    local command="$@"
> -
> -    local line=
> -    diag "Output of '$command':"
> -    "$@" | while read line ; do
> -        diag "$line"
> -    done
> -    ok ${PIPESTATUS[0]} "$command"
> -}
> -
> -
> -_equals(){
> -    local result=${1:?}
> -    local expected=${2:?}
> -
> -    if [[ "$result" == "$expected" ]] ; then
> -        return 0
> -    else
> -        return 1
> -    fi
> -}
> -
> -
> -# Thanks to Aaron Kangas for the patch to allow regexp matching
> -# under bash < 3.
> - _bash_major_version=${BASH_VERSION%%.*}
> -_matches(){
> -    local result=${1:?}
> -    local pattern=${2:?}
> -
> -    if [[ -z "$result" || -z "$pattern" ]] ; then
> -        return 1
> -    else
> -        if (( _bash_major_version >= 3 )) ; then
> -            [[ "$result" =~ "$pattern" ]]
> -        else
> -            echo "$result" | egrep -q "$pattern"
> -        fi
> -    fi
> -}
> -
> -
> -_is_diag(){
> -    local result=${1:?}
> -    local expected=${2:?}
> -
> -    diag "         got: '$result'"
> -    diag "    expected: '$expected'"
> -}
> -
> -
> -is(){
> -    local result=${1:?}
> -    local expected=${2:?}
> -    local name=${3:-''}
> -
> -    _equals "$result" "$expected"
> -    (( $? == 0 ))
> -    ok $? "$name"
> -    local r=$?
> -    (( r != 0 )) && _is_diag "$result" "$expected"
> -    return $r
> -}
> -
> -
> -isnt(){
> -    local result=${1:?}
> -    local expected=${2:?}
> -    local name=${3:-''}
> -
> -    _equals "$result" "$expected"
> -    (( $? != 0 ))
> -    ok $? "$name"
> -    local r=$?
> -    (( r != 0 )) && _is_diag "$result" "$expected"
> -    return $r
> -}
> -
> -
> -like(){
> -    local result=${1:?}
> -    local pattern=${2:?}
> -    local name=${3:-''}
> -
> -    _matches "$result" "$pattern"
> -    (( $? == 0 ))
> -    ok $? "$name"
> -    local r=$?
> -    (( r != 0 )) && diag "    '$result' doesn't match '$pattern'"
> -    return $r
> -}
> -
> -
> -unlike(){
> -    local result=${1:?}
> -    local pattern=${2:?}
> -    local name=${3:-''}
> -
> -    _matches "$result" "$pattern"
> -    (( $? != 0 ))
> -    ok $? "$name"
> -    local r=$?
> -    (( r != 0 )) && diag "    '$result' matches '$pattern'"
> -    return $r
> -}
> -
> -
> -skip(){
> -    local condition=${1:?}
> -    local reason=${2:-''}
> -    local n=${3:-1}
> -
> -    if (( condition == 0 )) ; then
> -        local i=
> -        for (( i=0 ; i<$n ; i++ )) ; do
> -            _executed_tests=$(( _executed_tests + 1 ))
> -            echo "ok $_executed_tests # skip: $reason"
> -        done
> -        return 0
> -    else
> -        return
> -    fi
> -}
> -
> -
> -diag(){
> -    local msg=${1:?}
> -
> -    if [[ -n "$msg" ]] ; then
> -        echo "# $msg"
> -    fi
> -
> -    return 1
> -}
> -
> -
> -_die(){
> -    local reason=${1:-'<unspecified error>'}
> -
> -    echo "$reason" >&2
> -    _test_died=1
> -    _exit 255
> -}
> -
> -
> -BAIL_OUT(){
> -    local reason=${1:-''}
> -
> -    echo "Bail out! $reason" >&2
> -    _exit 255
> -}
> -
> -
> -_cleanup(){
> -    local rc=0
> -
> -    if (( _plan_set == 0 )) ; then
> -        diag "Looks like your test died before it could output anything."
> -        return $rc
> -    fi
> -
> -    if (( _test_died != 0 )) ; then
> -        diag "Looks like your test died just after $_executed_tests."
> -        return $rc
> -    fi
> -
> -    if (( _skip_all == 0 && _no_plan != 0 )) ; then
> -        _print_plan $_executed_tests
> -    fi
> -
> -    local s=
> -    if (( _no_plan == 0 && _expected_tests < _executed_tests )) ; then
> -        s= ; (( _expected_tests > 1 )) && s=s
> -        local extra=$(( _executed_tests - _expected_tests ))
> -        diag "Looks like you planned $_expected_tests test$s but ran $extra extra."
> -        rc=1 ;
> -    fi
> -
> -    if (( _no_plan == 0 && _expected_tests > _executed_tests )) ; then
> -        s= ; (( _expected_tests > 1 )) && s=s
> -        diag "Looks like you planned $_expected_tests test$s but only ran $_executed_tests."
> -    fi
> -
> -    if (( _failed_tests > 0 )) ; then
> -        s= ; (( _failed_tests > 1 )) && s=s
> -        diag "Looks like you failed $_failed_tests test$s of $_executed_tests."
> -    fi
> -
> -    return $rc
> -}
> -
> -
> -_exit_status(){
> -    if (( _no_plan != 0 || _plan_set == 0 )) ; then
> -        return $_failed_tests
> -    fi
> -
> -    if (( _expected_tests < _executed_tests )) ; then
> -        return $(( _executed_tests - _expected_tests  ))
> -    fi
> -
> -    return $(( _failed_tests + ( _expected_tests - _executed_tests )))
> -}
> -
> -
> -_exit(){
> -    local rc=${1:-''}
> -    if [[ -z "$rc" ]] ; then
> -        _exit_status
> -        rc=$?
> -    fi
> -
> -    _cleanup
> -    local alt_rc=$?
> -    (( alt_rc != 0 )) && rc=$alt_rc
> -    trap - EXIT
> -    exit $rc
> -}
> diff --git a/tests/test_functions.sh b/tests/test_functions.sh
> deleted file mode 100644
> index c4e913b..0000000
> --- a/tests/test_functions.sh
> +++ /dev/null
> @@ -1,129 +0,0 @@
> -#!/bin/bash
> -#
> -# Copyright 2010 Ericsson AB
> -#
> -#    This file is part of LTTng-UST.
> -#
> -#    LTTng-UST is free software: you can redistribute it and/or modify
> -#    it under the terms of the GNU General Public License as published by
> -#    the Free Software Foundation, either version 3 of the License, or
> -#    (at your option) any later version.
> -#
> -#    LTTng-UST is distributed in the hope that it will be useful,
> -#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -#    GNU General Public License for more details.
> -#
> -#    You should have received a copy of the GNU General Public License
> -#    along with LTTng-UST.  If not, see <http://www.gnu.org/licenses/>.
> -
> -function starttest() {
> -
> -	echo "------------------------------------"
> -	echo "Starting test: $1"
> -	echo "------------------------------------"
> -}
> -
> -function check_trace_logs() {
> -	TRACE=$1
> -
> -	for f in $(ls $1/*.log); do
> -		NLINES=$(egrep "Warning|Error" $f | wc -l)
> -		if [ "$NLINES" -ne "0" ]; then
> -			fail "Errors/warnings found in $f"
> -			return 1;
> -		fi
> -	done
> -	pass "$f was consistent"
> -	return 0;
> -}
> -
> -
> -function trace_matches() {
> -    local OPTIND=
> -
> -    #Get a textdump command
> -    # if RUNLTTV is defined try to use it
> -    # if LTTV variable is defined try to use it
> -    # try to find lttv in the path
> -    # try to find runlttv in std paths (devel/lttv/runlttv and ust/../lttv/runlttv
> -
> -    if [ ! -d "$RUNLTTV" -a -x "$RUNLTTV" ]; then
> -	LTTV_TEXTDUMP_CMD="$RUNLTTV -m text "
> -	LTTV_TRACE_PREFIX=""
> -	
> -    elif [ -d "$RUNLTTV" -a -x "$RUNLTTV/runlttv" ]; then 
> -	LTTV_TEXTDUMP_CMD="$RUNLTTV/runlttv -m text "
> -	LTTV_TRACE_PREFIX=""
> -
> -    elif [ ! -d "$LTTV" -a -x "$LTTV" ]; then
> -	LTTV_TEXTDUMP_CMD="$LTTV -m textDump "
> -	LTTV_TRACE_PREFIX="-t"
> -
> -    elif [ -d "$LTTV" -a -x "$LTTV/lttv" ]; then
> -	LTTV_TEXTDUMP_CMD="$LTTV/lttv -m textDump "
> -	LTTV_TRACE_PREFIX="-t"
> -	
> -    elif [ -x "$(which lttv.real)" ]; then
> -	LTTV_TEXTDUMP_CMD="$(which lttv.real) -m textDump ";
> -	LTTV_TRACE_PREFIX="-t"
> -	
> -    elif [ -x "~/devel/lttv/runlttv" ]; then
> -	LTTV_TEXTDUMP_CMD="~/devel/lttv/runlttv -m text ";
> -	LTTV_TRACE_PREFIX=""
> -
> -    elif [ -x "$(dirname `readlink -f $0`)/../../lttv/runlttv" ]; then
> -	LTTV_TEXTDUMP_CMD="$(dirname `readlink -f $0`)/../../lttv/runlttv -m text "
> -	LTTV_TRACE_PREFIX=""
> -
> -    else
> -	echo "$0: No lttv found. Edit \$RUNLTTV to point to your lttv source directory or \$LTTV to you lttv executable." 1>&2
> -	exit 1;
> -
> -    fi
> -
> -    while getopts ":n:N:" options; do
> -	case "$options" in
> -	    n) expected_count=$OPTARG;;
> -	    N) name=$OPTARG;;
> -	    *) echo "Invalid option to trace_matches"
> -		exit 1;;
> -	esac
> -    done
> -    shift $(($OPTIND - 1))
> -
> -    pattern=$1
> -    if [ -z "$pattern" ]; then
> -	error "no pattern specified"
> -	usage
> -	exit 1
> -    fi
> -
> -    if [ -z "$2" ]; then
> -	error "no trace directory specified"
> -	return 1
> -    fi
> -    traces=$(find "$2" -mindepth 1 -maxdepth 1 -type d)
> -    lttv_trace_cmd=$LTTV_TEXTDUMP_CMD
> -    for trace in $traces; do
> -	lttv_trace_cmd="$lttv_trace_cmd $LTTV_TRACE_PREFIX $trace"
> -    done
> -    cnt=$($lttv_trace_cmd | grep "$pattern" | wc -l)
> -    if [ -z "$expected_count" ]; then
> -	if [ "$cnt" -eq "0" ]; then
> -	    fail "Did not find at least one instance of $name in trace"
> -	    return 1
> -	else
> -	    pass "Found at least one instance of $name in trace."
> -	    return 0
> -	fi
> -    else
> -	if [ "$cnt" -ne "$expected_count" ]; then
> -	    fail "Found $cnt instances of $name in trace, expected $expected_count"
> -	    return 1
> -	else
> -	    pass "Found $cnt instances of $name in trace."
> -	    return 0
> -	fi
> -    fi
> -}
> diff --git a/tests/trace_matches b/tests/trace_matches
> deleted file mode 100755
> index da3d954..0000000
> --- a/tests/trace_matches
> +++ /dev/null
> @@ -1,104 +0,0 @@
> -#!/bin/bash
> -
> -function error() {
> -	echo "$0: $@" 1>&2
> -}
> -
> -function usage() {
> -	echo "Usage: $0 [ -N pattern_name ] [ -n pattern_count ] PATTERN TRACE_PARENT_DIR"
> -}
> -
> -#Get a textdump command
> -# if RUNLTTV is defined try to use it
> -# if LTTV variable is defined try to use it
> -# try to find lttv in the path
> -# try to find runlttv in std paths (devel/lttv/runlttv and ust/../lttv/runlttv
> -
> -if [ ! -d "$RUNLTTV" -a -x "$RUNLTTV" ]; then
> -	LTTV_TEXTDUMP_CMD="$RUNLTTV -m text "
> -	LTTV_TRACE_PREFIX=""
> -
> -elif [ -d "$RUNLTTV" -a -x "$RUNLTTV/runlttv" ]; then 
> -	LTTV_TEXTDUMP_CMD="$RUNLTTV/runlttv -m text "
> -	LTTV_TRACE_PREFIX=""
> -
> -elif [ ! -d "$LTTV" -a -x "$LTTV" ]; then
> -	LTTV_TEXTDUMP_CMD="$LTTV -m textDump "
> -	LTTV_TRACE_PREFIX="-t"
> -		
> -elif [ -d "$LTTV" -a -x "$LTTV/lttv" ]; then
> -	LTTV_TEXTDUMP_CMD="$LTTV/lttv -m textDump "
> -	LTTV_TRACE_PREFIX="-t"
> -
> -elif [ -x "$(which lttv.real)" ]; then
> -	LTTV_TEXTDUMP_CMD="$(which lttv.real) -m textDump ";
> -	LTTV_TRACE_PREFIX="-t"
> -
> -elif [ -x "~/devel/lttv/runlttv" ]; then
> -	LTTV_TEXTDUMP_CMD="~/devel/lttv/runlttv -m text ";
> -	LTTV_TRACE_PREFIX=""
> -
> -elif [ -x "$(dirname `readlink -f $0`)/../../lttv/runlttv" ]; then
> -	LTTV_TEXTDUMP_CMD="$(dirname `readlink -f $0`)/../../lttv/runlttv -m text "
> -	LTTV_TRACE_PREFIX=""
> -
> -else
> -	echo "$0: No lttv found. Edit \$RUNLTTV to point to your lttv source directory or \$LTTV to you lttv executable." 1>&2
> -	exit 1;
> -
> -fi
> -
> -while getopts ":n:N:" options; do
> -	case "$options" in
> -		n) expected_count=$OPTARG;;
> -		N) name=$OPTARG;;
> -		h) usage;
> -		   exit 0;;
> -		\?) usage
> -			exit 1;;
> -		*) usage
> -			exit 1;;
> -	esac
> -done
> -shift $(($OPTIND - 1))
> -
> -pattern=$1
> -if [ -z "$pattern" ]; then
> -	error "no pattern specified"
> -	usage
> -	exit 1
> -fi
> -
> -if [ -z "$2" ]; then
> -	error "no trace directory specified"
> -	usage
> -	exit 1
> -fi
> -traces=$(find "$2" -mindepth 1 -maxdepth 1 -type d)
> -lttv_trace_cmd=$LTTV_TEXTDUMP_CMD
> -for trace in $traces; do
> -	lttv_trace_cmd="$lttv_trace_cmd $LTTV_TRACE_PREFIX $trace"
> -done
> -echo -n "Analyzing trace ($name): "
> -
> -cnt=$($lttv_trace_cmd | grep "$pattern" | wc -l)
> -if [ -z "$expected_count" ]; then
> -	if [ "$cnt" -eq "0" ]; then
> -		echo "ERROR"
> -		echo "Did not find at least one instance of this event ($cnt)"
> -		exit 1
> -	else
> -		echo "Success"
> -		exit 0
> -	fi
> -else 
> -	if [ "$cnt" -ne "$expected_count" ]; then
> -		echo "ERROR"
> -		echo "Expected: $expected_count"
> -		echo "In trace: $cnt"
> -		exit 1
> -	else
> -		echo "Success"
> -		exit 0
> -	fi
> -fi
> diff --git a/tests/utils/Makefile.am b/tests/utils/Makefile.am
> new file mode 100644
> index 0000000..24c0bb8
> --- /dev/null
> +++ b/tests/utils/Makefile.am
> @@ -0,0 +1,3 @@
> +noinst_LIBRARIES = libtap.a
> +libtap_a_SOURCES = tap.c tap.h
> +dist_noinst_SCRIPTS = tap.sh
> diff --git a/tests/utils/tap.c b/tests/utils/tap.c
> new file mode 100644
> index 0000000..8bf72f6
> --- /dev/null
> +++ b/tests/utils/tap.c
> @@ -0,0 +1,433 @@
> +/*-
> + * Copyright (c) 2004 Nik Clayton
> + * All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE.
> + */
> +
> +#define _GNU_SOURCE
> +#include <ctype.h>
> +#include <stdarg.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include "tap.h"
> +
> +static int no_plan = 0;
> +static int skip_all = 0;
> +static int have_plan = 0;
> +static unsigned int test_count = 0; /* Number of tests that have been run */
> +static unsigned int e_tests = 0; /* Expected number of tests to run */
> +static unsigned int failures = 0; /* Number of tests that failed */
> +static char *todo_msg = NULL;
> +static char *todo_msg_fixed = "libtap malloc issue";
> +static int todo = 0;
> +static int test_died = 0;
> +
> +/* Encapsulate the pthread code in a conditional.  In the absence of
> +   libpthread the code does nothing */
> +#ifdef HAVE_LIBPTHREAD
> +#include <pthread.h>
> +static pthread_mutex_t M = PTHREAD_MUTEX_INITIALIZER;
> +# define LOCK pthread_mutex_lock(&M);
> +# define UNLOCK pthread_mutex_unlock(&M);
> +#else
> +# define LOCK
> +# define UNLOCK
> +#endif
> +
> +static void _expected_tests(unsigned int);
> +static void _tap_init(void);
> +static void _cleanup(void);
> +
> +/*
> + * Generate a test result.
> + *
> + * ok -- boolean, indicates whether or not the test passed.
> + * test_name -- the name of the test, may be NULL
> + * test_comment -- a comment to print afterwards, may be NULL
> + */
> +unsigned int
> +_gen_result(int ok, const char *func, char *file, unsigned int line,
> +	    char *test_name, ...)
> +{
> +	va_list ap;
> +	char *local_test_name = NULL;
> +	char *c;
> +	int name_is_digits;
> +
> +	LOCK;
> +
> +	test_count++;
> +
> +	/* Start by taking the test name and performing any printf()
> +	   expansions on it */
> +	if(test_name != NULL) {
> +		va_start(ap, test_name);
> +		if (vasprintf(&local_test_name, test_name, ap) == -1) {
> +			local_test_name = NULL;
> +		}
> +		va_end(ap);
> +
> +		/* Make sure the test name contains more than digits
> +		   and spaces.  Emit an error message and exit if it
> +		   does */
> +		if(local_test_name) {
> +			name_is_digits = 1;
> +			for(c = local_test_name; *c != '\0'; c++) {
> +				if(!isdigit(*c) && !isspace(*c)) {
> +					name_is_digits = 0;
> +					break;
> +				}
> +			}
> +
> +			if(name_is_digits) {
> +				diag("    You named your test '%s'.  You shouldn't use numbers for your test names.", local_test_name);
> +				diag("    Very confusing.");
> +			}
> +		}
> +	}
> +
> +	if(!ok) {
> +		printf("not ");
> +		failures++;
> +	}
> +
> +	printf("ok %d", test_count);
> +
> +	if(test_name != NULL) {
> +		printf(" - ");
> +
> +		/* Print the test name, escaping any '#' characters it
> +		   might contain */
> +		if(local_test_name != NULL) {
> +			flockfile(stdout);
> +			for(c = local_test_name; *c != '\0'; c++) {
> +				if(*c == '#')
> +					fputc('\\', stdout);
> +				fputc((int)*c, stdout);
> +			}
> +			funlockfile(stdout);
> +		} else {	/* vasprintf() failed, use a fixed message */
> +			printf("%s", todo_msg_fixed);
> +		}
> +	}
> +
> +	/* If we're in a todo_start() block then flag the test as being
> +	   TODO.  todo_msg should contain the message to print at this
> +	   point.  If it's NULL then asprintf() failed, and we should
> +	   use the fixed message.
> +
> +	   This is not counted as a failure, so decrement the counter if
> +	   the test failed. */
> +	if(todo) {
> +		printf(" # TODO %s", todo_msg ? todo_msg : todo_msg_fixed);
> +		if(!ok)
> +			failures--;
> +	}
> +
> +	printf("\n");
> +
> +	if(!ok) {
> +		if(getenv("HARNESS_ACTIVE") != NULL)
> +			fputs("\n", stderr);
> +
> +		diag("    Failed %stest (%s:%s() at line %d)",
> +		     todo ? "(TODO) " : "", file, func, line);
> +	}
> +	free(local_test_name);
> +
> +	UNLOCK;
> +
> +	/* We only care (when testing) that ok is positive, but here we
> +	   specifically only want to return 1 or 0 */
> +	return ok ? 1 : 0;
> +}
> +
> +/*
> + * Initialise the TAP library.  Will only do so once, however many times it's
> + * called.
> + */
> +void
> +_tap_init(void)
> +{
> +	static int run_once = 0;
> +
> +	if(!run_once) {
> +		atexit(_cleanup);
> +
> +		/* stdout needs to be unbuffered so that the output appears
> +		   in the same place relative to stderr output as it does
> +		   with Test::Harness */
> +		setbuf(stdout, 0);
> +		run_once = 1;
> +	}
> +}
> +
> +/*
> + * Note that there's no plan.
> + */
> +int
> +plan_no_plan(void)
> +{
> +
> +	LOCK;
> +
> +	_tap_init();
> +
> +	if(have_plan != 0) {
> +		fprintf(stderr, "You tried to plan twice!\n");
> +		test_died = 1;
> +		UNLOCK;
> +		exit(255);
> +	}
> +
> +	have_plan = 1;
> +	no_plan = 1;
> +
> +	UNLOCK;
> +
> +	return 1;
> +}
> +
> +/*
> + * Note that the plan is to skip all tests
> + */
> +int
> +plan_skip_all(char *reason)
> +{
> +
> +	LOCK;
> +
> +	_tap_init();
> +
> +	skip_all = 1;
> +
> +	printf("1..0");
> +
> +	if(reason != NULL)
> +		printf(" # Skip %s", reason);
> +
> +	printf("\n");
> +
> +	UNLOCK;
> +
> +	exit(0);
> +}
> +
> +/*
> + * Note the number of tests that will be run.
> + */
> +int
> +plan_tests(unsigned int tests)
> +{
> +
> +	LOCK;
> +
> +	_tap_init();
> +
> +	if(have_plan != 0) {
> +		fprintf(stderr, "You tried to plan twice!\n");
> +		test_died = 1;
> +		UNLOCK;
> +		exit(255);
> +	}
> +
> +	if(tests == 0) {
> +		fprintf(stderr, "You said to run 0 tests!  You've got to run something.\n");
> +		test_died = 1;
> +		UNLOCK;
> +		exit(255);
> +	}
> +
> +	have_plan = 1;
> +
> +	_expected_tests(tests);
> +
> +	UNLOCK;
> +
> +	return e_tests;
> +}
> +
> +unsigned int
> +diag(char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	fputs("# ", stderr);
> +
> +	va_start(ap, fmt);
> +	vfprintf(stderr, fmt, ap);
> +	va_end(ap);
> +
> +	fputs("\n", stderr);
> +
> +	return 0;
> +}
> +
> +void
> +_expected_tests(unsigned int tests)
> +{
> +
> +	printf("1..%d\n", tests);
> +	e_tests = tests;
> +}
> +
> +int
> +skip(unsigned int n, char *fmt, ...)
> +{
> +	va_list ap;
> +	char *skip_msg = NULL;
> +
> +	LOCK;
> +
> +	va_start(ap, fmt);
> +	if (asprintf(&skip_msg, fmt, ap) == -1) {
> +		skip_msg = NULL;
> +	}
> +	va_end(ap);
> +
> +	while(n-- > 0) {
> +		test_count++;
> +		printf("ok %d # skip %s\n", test_count,
> +		       skip_msg != NULL ?
> +		       skip_msg : "libtap():malloc() failed");
> +	}
> +
> +	free(skip_msg);
> +
> +	UNLOCK;
> +
> +	return 1;
> +}
> +
> +void
> +todo_start(char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	LOCK;
> +
> +	va_start(ap, fmt);
> +	if (vasprintf(&todo_msg, fmt, ap) == -1) {
> +		todo_msg = NULL;
> +	}
> +	va_end(ap);
> +
> +	todo = 1;
> +
> +	UNLOCK;
> +}
> +
> +void
> +todo_end(void)
> +{
> +
> +	LOCK;
> +
> +	todo = 0;
> +	free(todo_msg);
> +
> +	UNLOCK;
> +}
> +
> +int
> +exit_status(void)
> +{
> +	int r;
> +
> +	LOCK;
> +
> +	/* If there's no plan, just return the number of failures */
> +	if(no_plan || !have_plan) {
> +		UNLOCK;
> +		return failures;
> +	}
> +
> +	/* Ran too many tests?  Return the number of tests that were run
> +	   that shouldn't have been */
> +	if(e_tests < test_count) {
> +		r = test_count - e_tests;
> +		UNLOCK;
> +		return r;
> +	}
> +
> +	/* Return the number of tests that failed + the number of tests
> +	   that weren't run */
> +	r = failures + e_tests - test_count;
> +	UNLOCK;
> +
> +	return r;
> +}
> +
> +/*
> + * Cleanup at the end of the run, produce any final output that might be
> + * required.
> + */
> +void
> +_cleanup(void)
> +{
> +
> +	LOCK;
> +
> +	/* If plan_no_plan() wasn't called, and we don't have a plan,
> +	   and we're not skipping everything, then something happened
> +	   before we could produce any output */
> +	if(!no_plan && !have_plan && !skip_all) {
> +		diag("Looks like your test died before it could output anything.");
> +		UNLOCK;
> +		return;
> +	}
> +
> +	if(test_died) {
> +		diag("Looks like your test died just after %d.", test_count);
> +		UNLOCK;
> +		return;
> +	}
> +
> +
> +	/* No plan provided, but now we know how many tests were run, and can
> +	   print the header at the end */
> +	if(!skip_all && (no_plan || !have_plan)) {
> +		printf("1..%d\n", test_count);
> +	}
> +
> +	if((have_plan && !no_plan) && e_tests < test_count) {
> +		diag("Looks like you planned %d %s but ran %d extra.",
> +		     e_tests, e_tests == 1 ? "test" : "tests", test_count - e_tests);
> +		UNLOCK;
> +		return;
> +	}
> +
> +	if((have_plan || !no_plan) && e_tests > test_count) {
> +		diag("Looks like you planned %d %s but only ran %d.",
> +		     e_tests, e_tests == 1 ? "test" : "tests", test_count);
> +		UNLOCK;
> +		return;
> +	}
> +
> +	if(failures)
> +		diag("Looks like you failed %d %s of %d.",
> +		     failures, failures == 1 ? "test" : "tests", test_count);
> +
> +	UNLOCK;
> +}
> diff --git a/tests/utils/tap.h b/tests/utils/tap.h
> new file mode 100644
> index 0000000..0f05943
> --- /dev/null
> +++ b/tests/utils/tap.h
> @@ -0,0 +1,89 @@
> +/*-
> + * Copyright (c) 2004 Nik Clayton
> + * All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE.
> + */
> +
> +/* '## __VA_ARGS__' is a gcc'ism. C99 doesn't allow the token pasting
> +   and requires the caller to add the final comma if they've ommitted
> +   the optional arguments */
> +#ifdef __GNUC__
> +# define ok(e, test, ...) ((e) ?					\
> +			   _gen_result(1, __func__, __FILE__, __LINE__,	\
> +				       test, ## __VA_ARGS__) :		\
> +			   _gen_result(0, __func__, __FILE__, __LINE__,	\
> +				       test, ## __VA_ARGS__))
> +
> +# define ok1(e) ((e) ?							\
> +		 _gen_result(1, __func__, __FILE__, __LINE__, "%s", #e) : \
> +		 _gen_result(0, __func__, __FILE__, __LINE__, "%s", #e))
> +
> +# define pass(test, ...) ok(1, test, ## __VA_ARGS__);
> +# define fail(test, ...) ok(0, test, ## __VA_ARGS__);
> +
> +# define skip_start(test, n, fmt, ...)			\
> +	do {						\
> +		if((test)) {				\
> +			skip(n, fmt, ## __VA_ARGS__);	\
> +			continue;			\
> +		}
> +#elif __STDC_VERSION__ >= 199901L /* __GNUC__ */
> +# define ok(e, ...) ((e) ?						\
> +		     _gen_result(1, __func__, __FILE__, __LINE__,	\
> +				 __VA_ARGS__) :				\
> +		     _gen_result(0, __func__, __FILE__, __LINE__,	\
> +				 __VA_ARGS__))
> +
> +# define ok1(e) ((e) ?							\
> +		 _gen_result(1, __func__, __FILE__, __LINE__, "%s", #e) : \
> +		 _gen_result(0, __func__, __FILE__, __LINE__, "%s", #e))
> +
> +# define pass(...) ok(1, __VA_ARGS__);
> +# define fail(...) ok(0, __VA_ARGS__);
> +
> +# define skip_start(test, n, ...)			\
> +	do {						\
> +		if((test)) {				\
> +			skip(n,  __VA_ARGS__);		\
> +			continue;			\
> +		}
> +#else /* __STDC_VERSION__ */
> +# error "Needs gcc or C99 compiler for variadic macros."
> +#endif /* __STDC_VERSION__ */
> +
> +#define skip_end() } while(0);
> +
> +unsigned int _gen_result(int, const char *, char *, unsigned int, char *, ...);
> +
> +int plan_no_plan(void);
> +int plan_skip_all(char *);
> +int plan_tests(unsigned int);
> +
> +unsigned int diag(char *, ...);
> +
> +int skip(unsigned int, char *, ...);
> +
> +void todo_start(char *, ...);
> +void todo_end(void);
> +
> +int exit_status(void);
> diff --git a/tests/utils/tap.sh b/tests/utils/tap.sh
> new file mode 100755
> index 0000000..24ac1aa
> --- /dev/null
> +++ b/tests/utils/tap.sh
> @@ -0,0 +1,456 @@
> +#!/bin/bash
> +#
> +# Copyright 2010 Patrick LeBoutillier <patrick.leboutillier@gmail.com>
> +#
> +#    This program is free software: you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation, either version 3 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License
> +#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +
> +
> +_version='1.01'
> +
> +_plan_set=0
> +_no_plan=0
> +_skip_all=0
> +_test_died=0
> +_expected_tests=0
> +_executed_tests=0
> +_failed_tests=0
> +TODO=
> +
> +
> +usage(){
> +    cat <<'USAGE'
> +tap-functions: A TAP-producing BASH library
> +
> +PLAN:
> +  plan_no_plan
> +  plan_skip_all [REASON]
> +  plan_tests NB_TESTS
> +
> +TEST:
> +  ok RESULT [NAME]
> +  okx COMMAND
> +  is RESULT EXPECTED [NAME]
> +  isnt RESULT EXPECTED [NAME]
> +  like RESULT PATTERN [NAME]
> +  unlike RESULT PATTERN [NAME]
> +  pass [NAME]
> +  fail [NAME]
> +
> +SKIP:
> +  skip [CONDITION] [REASON] [NB_TESTS=1]
> +
> +  skip $feature_not_present "feature not present" 2 || {
> +      is $a "a"
> +      is $b "b"
> +  }
> +
> +TODO:
> +  Specify TODO mode by setting $TODO:
> +    TODO="not implemented yet"
> +    ok $result "some not implemented test"
> +    unset TODO
> +
> +OTHER:
> +  diag MSG
> +
> +EXAMPLE:
> +  #!/bin/bash
> +
> +  . tap-functions
> +
> +  plan_tests 7
> +
> +  me=$USER
> +  is $USER $me "I am myself"
> +  like $HOME $me "My home is mine"
> +  like "`id`" $me "My id matches myself"
> +
> +  /bin/ls $HOME 1>&2
> +  ok $? "/bin/ls $HOME"
> +  # Same thing using okx shortcut
> +  okx /bin/ls $HOME
> +
> +  [[ "`id -u`" != "0" ]]
> +  i_am_not_root=$?
> +  skip $i_am_not_root "Must be root" || {
> +    okx ls /root
> +  }
> +
> +  TODO="figure out how to become root..."
> +  okx [ "$HOME" == "/root" ]
> +  unset TODO
> +USAGE
> +    exit
> +}
> +
> +opt=
> +set_u=
> +while getopts ":sx" opt ; do
> +    case $_opt in
> +        u) set_u=1 ;;
> +        *) usage ;;
> +    esac
> +done
> +shift $(( OPTIND - 1 ))
> +# Don't allow uninitialized variables if requested
> +[[ -n "$set_u" ]] && set -u
> +unset opt set_u
> +
> +# Used to call _cleanup on shell exit
> +trap _exit EXIT
> +
> +
> +plan_no_plan(){
> +    (( _plan_set != 0 )) && "You tried to plan twice!"
> +
> +    _plan_set=1
> +    _no_plan=1
> +
> +    return 0
> +}
> +
> +
> +plan_skip_all(){
> +    local reason=${1:-''}
> +
> +    (( _plan_set != 0 )) && _die "You tried to plan twice!"
> +
> +    _print_plan 0 "Skip $reason"
> +
> +    _skip_all=1
> +    _plan_set=1
> +    _exit 0
> +
> +    return 0
> +}
> +
> +plan_tests(){
> +    local tests=${1:?}
> +
> +    (( _plan_set != 0 )) && _die "You tried to plan twice!"
> +    (( tests == 0 )) && _die "You said to run 0 tests!  You've got to run something."
> +
> +    _print_plan $tests
> +    _expected_tests=$tests
> +    _plan_set=1
> +
> +    return $tests
> +}
> +
> +
> +_print_plan(){
> +    local tests=${1:?}
> +    local directive=${2:-''}
> +
> +    echo -n "1..$tests"
> +    [[ -n "$directive" ]] && echo -n " # $directive"
> +    echo
> +}
> +
> +
> +pass(){
> +    local name=$1
> +    ok 0 "$name"
> +}
> +
> +
> +fail(){
> +    local name=$1
> +    ok 1 "$name"
> +}
> +
> +# This is the workhorse method that actually
> +# prints the tests result.
> +ok(){
> +    local result=${1:?}
> +    local name=${2:-''}
> +
> +    (( _plan_set == 0 )) && _die "You tried to run a test without a plan!  Gotta have a plan."
> +
> +    _executed_tests=$(( $_executed_tests + 1 ))
> +
> +    if [[ -n "$name" ]] ; then
> +        if _matches "$name" "^[0-9]+$" ; then
> +            diag "    You named your test '$name'.  You shouldn't use numbers for your test names."
> +            diag "    Very confusing."
> +        fi
> +    fi
> +
> +    if (( result != 0 )) ; then
> +        echo -n "not "
> +        _failed_tests=$(( _failed_tests + 1 ))
> +    fi
> +    echo -n "ok $_executed_tests"
> +
> +    if [[ -n "$name" ]] ; then
> +        local ename=${name//\#/\\#}
> +        echo -n " - $ename"
> +    fi
> +
> +    if [[ -n "$TODO" ]] ; then
> +        echo -n " # TODO $TODO" ;
> +        if (( result != 0 )) ; then
> +            _failed_tests=$(( _failed_tests - 1 ))
> +        fi
> +    fi
> +
> +    echo
> +    if (( result != 0 )) ; then
> +        local file='tap-functions'
> +        local func=
> +        local line=
> +
> +        local i=0
> +        local bt=$(caller $i)
> +        while _matches "$bt" "tap-functions$" ; do
> +            i=$(( $i + 1 ))
> +            bt=$(caller $i)
> +        done
> +        local backtrace=
> +        eval $(caller $i | (read line func file ; echo "backtrace=\"$file:$func() at line $line.\""))
> +
> +        local t=
> +        [[ -n "$TODO" ]] && t="(TODO) "
> +
> +        if [[ -n "$name" ]] ; then
> +            diag "  Failed ${t}test '$name'"
> +            diag "  in $backtrace"
> +        else
> +            diag "  Failed ${t}test in $backtrace"
> +        fi
> +    fi
> +
> +    return $result
> +}
> +
> +
> +okx(){
> +    local command="$@"
> +
> +    local line=
> +    diag "Output of '$command':"
> +    "$@" | while read line ; do
> +        diag "$line"
> +    done
> +    ok ${PIPESTATUS[0]} "$command"
> +}
> +
> +
> +_equals(){
> +    local result=${1:?}
> +    local expected=${2:?}
> +
> +    if [[ "$result" == "$expected" ]] ; then
> +        return 0
> +    else
> +        return 1
> +    fi
> +}
> +
> +
> +# Thanks to Aaron Kangas for the patch to allow regexp matching
> +# under bash < 3.
> + _bash_major_version=${BASH_VERSION%%.*}
> +_matches(){
> +    local result=${1:?}
> +    local pattern=${2:?}
> +
> +    if [[ -z "$result" || -z "$pattern" ]] ; then
> +        return 1
> +    else
> +        if (( _bash_major_version >= 3 )) ; then
> +            [[ "$result" =~ "$pattern" ]]
> +        else
> +            echo "$result" | egrep -q "$pattern"
> +        fi
> +    fi
> +}
> +
> +
> +_is_diag(){
> +    local result=${1:?}
> +    local expected=${2:?}
> +
> +    diag "         got: '$result'"
> +    diag "    expected: '$expected'"
> +}
> +
> +
> +is(){
> +    local result=${1:?}
> +    local expected=${2:?}
> +    local name=${3:-''}
> +
> +    _equals "$result" "$expected"
> +    (( $? == 0 ))
> +    ok $? "$name"
> +    local r=$?
> +    (( r != 0 )) && _is_diag "$result" "$expected"
> +    return $r
> +}
> +
> +
> +isnt(){
> +    local result=${1:?}
> +    local expected=${2:?}
> +    local name=${3:-''}
> +
> +    _equals "$result" "$expected"
> +    (( $? != 0 ))
> +    ok $? "$name"
> +    local r=$?
> +    (( r != 0 )) && _is_diag "$result" "$expected"
> +    return $r
> +}
> +
> +
> +like(){
> +    local result=${1:?}
> +    local pattern=${2:?}
> +    local name=${3:-''}
> +
> +    _matches "$result" "$pattern"
> +    (( $? == 0 ))
> +    ok $? "$name"
> +    local r=$?
> +    (( r != 0 )) && diag "    '$result' doesn't match '$pattern'"
> +    return $r
> +}
> +
> +
> +unlike(){
> +    local result=${1:?}
> +    local pattern=${2:?}
> +    local name=${3:-''}
> +
> +    _matches "$result" "$pattern"
> +    (( $? != 0 ))
> +    ok $? "$name"
> +    local r=$?
> +    (( r != 0 )) && diag "    '$result' matches '$pattern'"
> +    return $r
> +}
> +
> +
> +skip(){
> +    local condition=${1:?}
> +    local reason=${2:-''}
> +    local n=${3:-1}
> +
> +    if (( condition == 0 )) ; then
> +        local i=
> +        for (( i=0 ; i<$n ; i++ )) ; do
> +            _executed_tests=$(( _executed_tests + 1 ))
> +            echo "ok $_executed_tests # skip: $reason"
> +        done
> +        return 0
> +    else
> +        return
> +    fi
> +}
> +
> +
> +diag(){
> +    local msg=${1:?}
> +
> +    if [[ -n "$msg" ]] ; then
> +        echo "# $msg"
> +    fi
> +
> +    return 1
> +}
> +
> +
> +_die(){
> +    local reason=${1:-'<unspecified error>'}
> +
> +    echo "$reason" >&2
> +    _test_died=1
> +    _exit 255
> +}
> +
> +
> +BAIL_OUT(){
> +    local reason=${1:-''}
> +
> +    echo "Bail out! $reason" >&2
> +    _exit 255
> +}
> +
> +
> +_cleanup(){
> +    local rc=0
> +
> +    if (( _plan_set == 0 )) ; then
> +        diag "Looks like your test died before it could output anything."
> +        return $rc
> +    fi
> +
> +    if (( _test_died != 0 )) ; then
> +        diag "Looks like your test died just after $_executed_tests."
> +        return $rc
> +    fi
> +
> +    if (( _skip_all == 0 && _no_plan != 0 )) ; then
> +        _print_plan $_executed_tests
> +    fi
> +
> +    local s=
> +    if (( _no_plan == 0 && _expected_tests < _executed_tests )) ; then
> +        s= ; (( _expected_tests > 1 )) && s=s
> +        local extra=$(( _executed_tests - _expected_tests ))
> +        diag "Looks like you planned $_expected_tests test$s but ran $extra extra."
> +        rc=1 ;
> +    fi
> +
> +    if (( _no_plan == 0 && _expected_tests > _executed_tests )) ; then
> +        s= ; (( _expected_tests > 1 )) && s=s
> +        diag "Looks like you planned $_expected_tests test$s but only ran $_executed_tests."
> +    fi
> +
> +    if (( _failed_tests > 0 )) ; then
> +        s= ; (( _failed_tests > 1 )) && s=s
> +        diag "Looks like you failed $_failed_tests test$s of $_executed_tests."
> +    fi
> +
> +    return $rc
> +}
> +
> +
> +_exit_status(){
> +    if (( _no_plan != 0 || _plan_set == 0 )) ; then
> +        return $_failed_tests
> +    fi
> +
> +    if (( _expected_tests < _executed_tests )) ; then
> +        return $(( _executed_tests - _expected_tests  ))
> +    fi
> +
> +    return $(( _failed_tests + ( _expected_tests - _executed_tests )))
> +}
> +
> +
> +_exit(){
> +    local rc=${1:-''}
> +    if [[ -z "$rc" ]] ; then
> +        _exit_status
> +        rc=$?
> +    fi
> +
> +    _cleanup
> +    local alt_rc=$?
> +    (( alt_rc != 0 )) && rc=$alt_rc
> +    trap - EXIT
> +    exit $rc
> +}
> -- 
> 1.8.3.3
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
