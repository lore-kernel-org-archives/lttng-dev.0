From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [UST PATCH] Add a multi-thread version of
	the	'hello' test program
Date: Tue, 26 Jun 2012 02:03:56 -0400
Message-ID: <20120626060356.GC11445__46007.3532224216$1340690660$gmane$org@Krystal>
References: <1340667760-28686-1-git-send-email-alexmonthy@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SjOsX-00062k-SJ
	for lttng-dev@lists.lttng.org; Tue, 26 Jun 2012 02:03:57 -0400
Content-Disposition: inline
In-Reply-To: <1340667760-28686-1-git-send-email-alexmonthy@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:
> Signed-off-by: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
> ---
>  .gitignore                            |    1 +
>  configure.ac                          |    1 +
>  tests/Makefile.am                     |    2 +-
>  tests/hello-mt/Makefile.am            |   13 +++++
>  tests/hello-mt/Makefile.example.bsd   |    8 +++
>  tests/hello-mt/Makefile.example.linux |    8 +++
>  tests/hello-mt/README                 |   11 ++++
>  tests/hello-mt/hello.c                |  103 +++++++++++++++++++++++++++++++++
>  tests/hello-mt/tp.c                   |   18 ++++++
>  tests/hello-mt/ust_tests_hello.h      |   67 +++++++++++++++++++++
>  10 files changed, 231 insertions(+), 1 deletion(-)
>  create mode 100644 tests/hello-mt/Makefile.am
>  create mode 100644 tests/hello-mt/Makefile.example.bsd
>  create mode 100644 tests/hello-mt/Makefile.example.linux
>  create mode 100644 tests/hello-mt/README
>  create mode 100644 tests/hello-mt/hello.c
>  create mode 100644 tests/hello-mt/tp.c
>  create mode 100644 tests/hello-mt/ust_tests_hello.h
> 
> diff --git a/.gitignore b/.gitignore
> index 076cd00..c9b45f1 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -39,6 +39,7 @@ tests/exit-fast/exit-fast
>  tests/fork/fork
>  tests/fork/fork2
>  tests/hello/hello
> +tests/hello-mt/hello
>  tests/hello.cxx/hello
>  tests/hello2/hello2
>  tests/libustctl_function_tests/libustctl_function_tests
> diff --git a/configure.ac b/configure.ac
> index 294d457..0a50ed0 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -305,6 +305,7 @@ AC_CONFIG_FILES([
>  	tools/Makefile
>  	tests/Makefile
>  	tests/hello/Makefile
> +	tests/hello-mt/Makefile
>  	tests/hello-static-lib/Makefile
>  	tests/hello.cxx/Makefile
>  	tests/demo/Makefile
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index e79ab7c..443b407 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -1,4 +1,4 @@
> -SUBDIRS = . hello hello-static-lib fork ust-basic-tracing ust-multi-test demo hello.cxx
> +SUBDIRS = . hello hello-mt hello-static-lib fork ust-basic-tracing ust-multi-test demo hello.cxx
>  #SUBDIRS = . hello2 basic basic_long simple_include snprintf test-nevents test-libustinstr-malloc dlopen same_line_marker trace_event register_test tracepoint libustctl_function_tests exit-fast
>  
>  dist_noinst_SCRIPTS = test_loop runtests trace_matches
> diff --git a/tests/hello-mt/Makefile.am b/tests/hello-mt/Makefile.am
> new file mode 100644
> index 0000000..4b7e16d
> --- /dev/null
> +++ b/tests/hello-mt/Makefile.am
> @@ -0,0 +1,13 @@
> +AM_CPPFLAGS = -I$(top_srcdir)/include -Wsystem-headers
> +AM_CFLAGS = -fopenmp
> +
> +noinst_PROGRAMS = hello
> +hello_SOURCES = hello.c tp.c ust_tests_hello.h
> +hello_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
> +
> +if LTTNG_UST_BUILD_WITH_LIBDL
> +hello_LDADD += -ldl
> +endif
> +if LTTNG_UST_BUILD_WITH_LIBC_DL
> +hello_LDADD += -lc
> +endif
> diff --git a/tests/hello-mt/Makefile.example.bsd b/tests/hello-mt/Makefile.example.bsd
> new file mode 100644
> index 0000000..a71f478
> --- /dev/null
> +++ b/tests/hello-mt/Makefile.example.bsd
> @@ -0,0 +1,8 @@
> +# Example makefile for build outside of the LTTng-UST tree.
> +
> +hello:
> +	${CC} -O2 -I. -o hello -lc -llttng-ust -fopenmp hello.c tp.c
> +
> +.PHONY: clean
> +clean:
> +	rm -f hello
> diff --git a/tests/hello-mt/Makefile.example.linux b/tests/hello-mt/Makefile.example.linux
> new file mode 100644
> index 0000000..bc5e58f
> --- /dev/null
> +++ b/tests/hello-mt/Makefile.example.linux
> @@ -0,0 +1,8 @@
> +# Example makefile for build outside of the LTTng-UST tree.
> +
> +hello:
> +	${CC} -O2 -I. -Wall -o hello hello.c tp.c -ldl -llttng-ust -fopenmp
> +
> +.PHONY: clean
> +clean:
> +	rm -f hello
> diff --git a/tests/hello-mt/README b/tests/hello-mt/README
> new file mode 100644
> index 0000000..0584dca
> --- /dev/null
> +++ b/tests/hello-mt/README
> @@ -0,0 +1,11 @@
> +This is a multi-threaded version of the "hello" test program. It uses OpenMP for
> +parallelization, and as such requires at least GCC 4.2.

Hrm. This adds a dependency on gcc 4.2. The entire project will fail to
build because of this test on other compiler, older gcc, right ? We
should have a configure.ac check that tests openmp availability. So I
won't merge this for now.

Thanks,

Mathieu

> +
> +You can pass one integer as argument when running the program, this will
> +indicate how many threads to use. For example
> +
> +./hello 10
> +
> +will run the test with 10 threads. If no argument is passed, the default of
> +1 thread is used, in which case the behaviour should be similar to the original
> +"hello" program.
> diff --git a/tests/hello-mt/hello.c b/tests/hello-mt/hello.c
> new file mode 100644
> index 0000000..2ff9869
> --- /dev/null
> +++ b/tests/hello-mt/hello.c
> @@ -0,0 +1,103 @@
> +/*
> + * Copyright (C) 2009  Pierre-Marc Fournier
> + * Copyright (C) 2011  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright (C) 2012  Alexandre Montplaisir <alexmonthy@voxpopuli.im>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; version 2.1 of
> + * the License.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> + */
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <stdarg.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <string.h>
> +#include <arpa/inet.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <omp.h>
> +
> +#define TRACEPOINT_DEFINE
> +#include "ust_tests_hello.h"
> +
> +#define NB_ITERATIONS 1000000
> +
> +void inthandler(int sig)
> +{
> +	printf("in SIGUSR1 handler\n");
> +	tracepoint(ust_tests_hello, tptest_sighandler);
> +}
> +
> +int init_int_handler(void)
> +{
> +	int result;
> +	struct sigaction act;
> +
> +	memset(&act, 0, sizeof(act));
> +	result = sigemptyset(&act.sa_mask);
> +	if (result == -1) {
> +		perror("sigemptyset");
> +		return -1;
> +	}
> +
> +	act.sa_handler = inthandler;
> +	act.sa_flags = SA_RESTART;
> +
> +	/* Only defer ourselves. Also, try to restart interrupted
> +	 * syscalls to disturb the traced program as little as possible.
> +	 */
> +	result = sigaction(SIGUSR1, &act, NULL);
> +	if (result == -1) {
> +		perror("sigaction");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int i, netint;
> +	long values[] = { 1, 2, 3 };
> +	char text[10] = "test";
> +	double dbl = 2.0;
> +	float flt = 2222.0;
> +	int nb_threads = 1;
> +	bool mybool = 123;	/* should print "1" */
> +
> +	init_int_handler();
> +
> +	if (argc == 2) {
> +		nb_threads = atoi(argv[1]);
> +	}
> +
> +	fprintf(stderr, "Running %d iterations with %d threads... ",
> +					NB_ITERATIONS, nb_threads);
> +
> +	#pragma omp parallel private(i, netint) num_threads(nb_threads)
> +	{
> +		for (i = 0; i < NB_ITERATIONS; i++) {
> +			netint = htonl(i);
> +			tracepoint(ust_tests_hello, tptest, i, netint, values,
> +				   text, strlen(text), dbl, flt, mybool);
> +			//usleep(100000);
> +		}
> +	}
> +	fprintf(stderr, " done.\n");
> +	return 0;
> +}
> diff --git a/tests/hello-mt/tp.c b/tests/hello-mt/tp.c
> new file mode 100644
> index 0000000..1806b42
> --- /dev/null
> +++ b/tests/hello-mt/tp.c
> @@ -0,0 +1,18 @@
> +/*
> + * tp.c
> + *
> + * Copyright (c) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + */
> +
> +#define TRACEPOINT_CREATE_PROBES
> +#include "ust_tests_hello.h"
> diff --git a/tests/hello-mt/ust_tests_hello.h b/tests/hello-mt/ust_tests_hello.h
> new file mode 100644
> index 0000000..b06dea0
> --- /dev/null
> +++ b/tests/hello-mt/ust_tests_hello.h
> @@ -0,0 +1,67 @@
> +#undef TRACEPOINT_PROVIDER
> +#define TRACEPOINT_PROVIDER ust_tests_hello
> +
> +#if !defined(_TRACEPOINT_UST_TESTS_HELLO_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
> +#define _TRACEPOINT_UST_TESTS_HELLO_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * Copyright (C) 2011  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + */
> +
> +#include <lttng/tracepoint.h>
> +#include <stdbool.h>
> +
> +TRACEPOINT_EVENT(ust_tests_hello, tptest,
> +	TP_ARGS(int, anint, int, netint, long *, values,
> +		char *, text, size_t, textlen,
> +		double, doublearg, float, floatarg,
> +		bool, boolarg),
> +	TP_FIELDS(
> +		ctf_integer(int, intfield, anint)
> +		ctf_integer_hex(int, intfield2, anint)
> +		ctf_integer(long, longfield, anint)
> +		ctf_integer_network(int, netintfield, netint)
> +		ctf_integer_network_hex(int, netintfieldhex, netint)
> +		ctf_array(long, arrfield1, values, 3)
> +		ctf_array_text(char, arrfield2, text, 10)
> +		ctf_sequence(char, seqfield1, text,
> +			     size_t, textlen)
> +		ctf_sequence_text(char, seqfield2, text,
> +			     size_t, textlen)
> +		ctf_string(stringfield, text)
> +		ctf_float(float, floatfield, floatarg)
> +		ctf_float(double, doublefield, doublearg)
> +		ctf_integer(bool, boolfield, boolarg)
> +	)
> +)
> +
> +TRACEPOINT_EVENT(ust_tests_hello, tptest_sighandler,
> +	TP_ARGS(),
> +	TP_FIELDS()
> +)
> +
> +#endif /* _TRACEPOINT_UST_TESTS_HELLO_H */
> +
> +#undef TRACEPOINT_INCLUDE_FILE
> +#define TRACEPOINT_INCLUDE_FILE ./ust_tests_hello.h
> +
> +/* This part must be outside ifdef protection */
> +#include <lttng/tracepoint-event.h>
> +
> +#ifdef __cplusplus 
> +}
> +#endif
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
