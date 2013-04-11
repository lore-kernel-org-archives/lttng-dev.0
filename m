From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Remove redondant "hello" test	and
	move "hello-static-lib" to doc/examples
Date: Thu, 11 Apr 2013 17:54:27 -0400
Message-ID: <20130411215427.GA31573__49097.8946014822$1365717300$gmane$org@Krystal>
References: <20130328135040.GA29485@Krystal>
	<1365715158-11452-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UQPRv-0003XB-H9
	for lttng-dev@lists.lttng.org; Thu, 11 Apr 2013 17:54:31 -0400
Content-Disposition: inline
In-Reply-To: <1365715158-11452-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

redondant -> redundant

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> The examples are now automatically built as part of the default make targ=
et.
> =

> The "hello" test verified that an application with statically embedded
> tracepoint providers could be built. This is now covered by "easy-ust" in
> doc/examples since we now build the examples.

No, hello is referenced by lttng-ust(3) manpage.

Please leave it there, but move it to examples.

Thanks,

Mathieu

> =

> Move the "hello-static-lib" test to doc/examples.
> =

> This should provide complete and easy to understand Makefile examples to =
users
> who wish to integrate tracepoint providers to their applications.
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  .gitignore                                      |  6 +-
>  README                                          |  2 +-
>  configure.ac                                    |  2 -
>  doc/examples/Makefile.am                        | 15 ++++
>  doc/examples/README                             |  3 +
>  doc/examples/demo/Makefile                      | 27 +++++--
>  doc/examples/easy-ust/Makefile                  | 30 ++++++--
>  doc/examples/hello-static-lib/Makefile          | 53 ++++++++++++++
>  doc/examples/hello-static-lib/README            |  3 +
>  doc/examples/hello-static-lib/hello.c           | 94 +++++++++++++++++++=
+++++
>  doc/examples/hello-static-lib/tp.c              | 26 +++++++
>  doc/examples/hello-static-lib/ust_tests_hello.h | 72 ++++++++++++++++++
>  doc/man/lttng-ust.3                             | 62 ++++++++--------
>  tests/Makefile.am                               |  2 +-
>  tests/hello-static-lib/Makefile.am              | 18 -----
>  tests/hello-static-lib/README                   |  3 -
>  tests/hello-static-lib/hello.c                  | 95 -------------------=
-----
>  tests/hello-static-lib/tp.c                     | 26 -------
>  tests/hello-static-lib/ust_tests_hello.h        | 72 ------------------
>  tests/hello/Makefile.am                         | 13 ----
>  tests/hello/Makefile.example.bsd                |  8 --
>  tests/hello/Makefile.example.linux              |  8 --
>  tests/hello/README                              |  2 -
>  tests/hello/hello.c                             | 97 -------------------=
------
>  tests/hello/tp.c                                | 26 -------
>  tests/hello/ust_tests_hello.h                   | 76 -------------------
>  26 files changed, 349 insertions(+), 492 deletions(-)
>  create mode 100644 doc/examples/README
>  create mode 100644 doc/examples/hello-static-lib/Makefile
>  create mode 100644 doc/examples/hello-static-lib/README
>  create mode 100644 doc/examples/hello-static-lib/hello.c
>  create mode 100644 doc/examples/hello-static-lib/tp.c
>  create mode 100644 doc/examples/hello-static-lib/ust_tests_hello.h
>  delete mode 100644 tests/hello-static-lib/Makefile.am
>  delete mode 100644 tests/hello-static-lib/README
>  delete mode 100644 tests/hello-static-lib/hello.c
>  delete mode 100644 tests/hello-static-lib/tp.c
>  delete mode 100644 tests/hello-static-lib/ust_tests_hello.h
>  delete mode 100644 tests/hello/Makefile.am
>  delete mode 100644 tests/hello/Makefile.example.bsd
>  delete mode 100644 tests/hello/Makefile.example.linux
>  delete mode 100644 tests/hello/README
>  delete mode 100644 tests/hello/hello.c
>  delete mode 100644 tests/hello/tp.c
>  delete mode 100644 tests/hello/ust_tests_hello.h
> =

> diff --git a/.gitignore b/.gitignore
> index 1065aa3..e118025 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -31,7 +31,10 @@ lttng-ust.pc
>  ustctl/ustctl
>  ust-consumerd/ust-consumerd
>  =

> -tests/hello/hello
> +doc/examples/demo/demo
> +doc/examples/easy-ust/sample
> +doc/examples/hello-static-lib/hello
> +
>  tests/hello.cxx/hello
>  tests/same_line_tracepoint/same_line_tracepoint
>  tests/ust-basic-tracing/ust-basic-tracing
> @@ -39,5 +42,4 @@ tests/ust-multi-test/ust-multi-test
>  tests/trace_event/trace_event_test
>  tests/tracepoint/benchmark/tracepoint_benchmark
>  tests/tracepoint/tracepoint_test
> -tests/hello-static-lib/hello
>  tests/snprintf/prog
> diff --git a/README b/README
> index 30ccb34..dadcd1f 100644
> --- a/README
> +++ b/README
> @@ -72,7 +72,7 @@ USAGE:
>      - If building the provider directly into the application,
>        link the application with "-llttng-ust".
>      - If building a static library for the provider, link the static
> -      library with "-lllttng-ust".
> +      library with "-llttng-ust".
>      - Include the tracepoint provider header into all C files using
>        the provider.
>      - Example:
> diff --git a/configure.ac b/configure.ac
> index e54cfea..be392cf 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -265,8 +265,6 @@ AC_CONFIG_FILES([
>  	liblttng-ust-cyg-profile/Makefile
>  	tools/Makefile
>  	tests/Makefile
> -	tests/hello/Makefile
> -	tests/hello-static-lib/Makefile
>  	tests/hello.cxx/Makefile
>  	tests/same_line_tracepoint/Makefile
>  	tests/snprintf/Makefile
> diff --git a/doc/examples/Makefile.am b/doc/examples/Makefile.am
> index 2dc042a..e9dd170 100644
> --- a/doc/examples/Makefile.am
> +++ b/doc/examples/Makefile.am
> @@ -1,6 +1,12 @@
> +SUBDIRS =3D easy-ust demo hello-static-lib
> +
> +doc_examplesdir =3D ${docdir}/examples
>  doc_examples_easy_ustdir =3D ${docdir}/examples/easy-ust
>  doc_examples_gen_tpdir =3D ${docdir}/examples/gen-tp
>  doc_examples_demodir =3D ${docdir}/examples/demo
> +doc_examples_hello_static_libdir =3D ${docdir}/examples/hello-static-lib
> +
> +dist_doc_examples_DATA =3D README
>  =

>  dist_doc_examples_easy_ust_DATA =3D easy-ust/Makefile \
>  	easy-ust/sample.c \
> @@ -19,3 +25,12 @@ dist_doc_examples_demo_DATA =3D demo/demo.c \
>  	demo/ust_tests_demo2.h \
>  	demo/ust_tests_demo3.h \
>  	demo/ust_tests_demo.h
> +
> +dist_doc_examples_hello_static_lib_DATA =3D hello-static-lib/Makefile \
> +	hello-static-lib/hello.c \
> +	hello-static-lib/README \
> +	hello-static-lib/ust_tests_hello.h \
> +	hello-static-lib/tp.c
> +
> +BUILD_EXAMPLES_FROM_TREE =3D 1
> +export
> diff --git a/doc/examples/README b/doc/examples/README
> new file mode 100644
> index 0000000..e9ed352
> --- /dev/null
> +++ b/doc/examples/README
> @@ -0,0 +1,3 @@
> +To build the examples from the source tree, the BUILD_EXAMPLES_FROM_TREE
> +environment variable must be defined. This will force the examples'
> +Makefiles to use the source tree's public header files and libraries.
> diff --git a/doc/examples/demo/Makefile b/doc/examples/demo/Makefile
> index 41f4321..0c829da 100644
> --- a/doc/examples/demo/Makefile
> +++ b/doc/examples/demo/Makefile
> @@ -9,13 +9,30 @@
>  # granted, provided the above notices are retained, and a notice that
>  # the code was modified is included with the above copyright notice.
>  =

> -# This Makefile is not using automake so that people may see how to build
> -# a program and tracepoint provider probes as stand-alone shared objects.
> +# This Makefile is not using automake so that users may see how to build
> +# a program with tracepoint provider probes as stand-alone shared object=
s.
>  =

>  CC =3D gcc
>  LIBS =3D -ldl	# On Linux
>  #LIBS =3D -lc	# On BSD
> -CFLAGS =3D -I.
> +CFLAGS +=3D -I.
> +
> +# Only necessary when building from the source tree and lttng-ust is not
> +# installed
> +ifdef BUILD_EXAMPLES_FROM_TREE
> +CFLAGS +=3D -I../../../include/
> +LIBLTTNG_UST_PATH =3D ../../../liblttng-ust/.libs/
> +LDFLAGS +=3D -L$(LIBLTTNG_UST_PATH) -Wl,-rpath=3D'$$ORIGIN/$(LIBLTTNG_US=
T_PATH)'
> +
> +# Third-party Makefiles have to define these targets to integrate with an
> +# automake project
> +EMPTY_AUTOMAKE_TARGETS =3D distdir install install-data install-exec uni=
nstall \
> +	install-dvi install-html install-info install-ps install-pdf \
> +	installdirs check installcheck mostlyclean distclean maintainer-clean \
> +	dvi html pdf ps info tags ctags
> +.PHONY: $(EMPTY_AUTOMAKE_TARGETS)
> +$(EMPTY_AUTOMAKE_TARGETS):
> +endif
>  =

>  all: demo lttng-ust-provider-ust-tests-demo.so lttng-ust-provider-ust-te=
sts-demo3.so
>  =

> @@ -23,13 +40,13 @@ lttng-ust-provider-ust-tests-demo.o: tp.c tp2.c ust_t=
ests_demo.h ust_tests_demo2
>  	$(CC) $(CFLAGS) -fpic -c -o $@ $<
>  =

>  lttng-ust-provider-ust-tests-demo.so: lttng-ust-provider-ust-tests-demo.o
> -	$(CC) -shared -o $@ -llttng-ust $<
> +	$(CC) -shared -o $@ $(LDFLAGS) -llttng-ust $<
>  =

>  lttng-ust-provider-ust-tests-demo3.o: tp3.c ust_tests_demo3.h
>  	$(CC) $(CFLAGS) -fpic -c -o $@ $<
>  =

>  lttng-ust-provider-ust-tests-demo3.so: lttng-ust-provider-ust-tests-demo=
3.o
> -	$(CC) -shared -o $@ -llttng-ust $<
> +	$(CC) -shared -o $@ $(LDFLAGS) -llttng-ust $<
>  =

>  demo.o: demo.c
>  	$(CC) $(CFLAGS) -c -o $@ $<
> diff --git a/doc/examples/easy-ust/Makefile b/doc/examples/easy-ust/Makef=
ile
> index 1e3c941..304632b 100644
> --- a/doc/examples/easy-ust/Makefile
> +++ b/doc/examples/easy-ust/Makefile
> @@ -10,20 +10,36 @@
>  # granted, provided the above notices are retained, and a notice that
>  # the code was modified is included with the above copyright notice.
>  =

> -# This makefile is not using automake so that people can see how to make
> -# simply. It builds a program with a statically embedded tracepoint
> -# provider probe.
> +# This makefile is not using automake so that users can see how to build
> +# a program with a statically embedded tracepoint provider probe.
>  # the "html" target helps for documentation (req. code2html)
>  =

>  CC =3D gcc
>  LIBS =3D -ldl -llttng-ust		# On Linux
>  #LIBS =3D -lc -llttng-ust		# On BSD
> -CFLAGS =3D -I.
> +CFLAGS +=3D -I.
> +
> +# Only necessary when building from the source tree and lttng-ust is not
> +# installed
> +ifdef BUILD_EXAMPLES_FROM_TREE
> +CFLAGS +=3D -I../../../include/
> +LIBLTTNG_UST_PATH =3D ../../../liblttng-ust/.libs/
> +LDFLAGS +=3D -L$(LIBLTTNG_UST_PATH) -Wl,-rpath=3D'$$ORIGIN/$(LIBLTTNG_US=
T_PATH)'
> +
> +# Third-party Makefiles have to define these targets to integrate with an
> +# automake project
> +EMPTY_AUTOMAKE_TARGETS =3D distdir install install-data install-exec uni=
nstall \
> +	install-dvi install-html install-info install-ps install-pdf \
> +	installdirs check installcheck mostlyclean distclean maintainer-clean \
> +	dvi pdf ps info tags ctags
> +.PHONY: $(EMPTY_AUTOMAKE_TARGETS)
> +$(EMPTY_AUTOMAKE_TARGETS):
> +endif
>  =

>  all: sample
>  =

>  sample: sample.o tp.o
> -	$(CC) -o $@ $^ $(LIBS)
> +	$(CC) -o $@ $^ $(LDFLAGS) $(LIBS)
>  =

>  sample.o: sample.c sample_component_provider.h
>  	$(CC) $(CFLAGS) -c -o $@ $<
> @@ -33,7 +49,7 @@ tp.o: tp.c sample_component_provider.h
>  =

>  html: sample_component_provider.html sample.html tp.html
>  =

> -%.html: %.c =

> +%.html: %.c
>  	code2html -lc $< $@
>  =

>  %.html : %.h
> @@ -41,5 +57,5 @@ html: sample_component_provider.html sample.html tp.html
>  =

>  .PHONY: clean
>  clean:
> -	rm -f *.html  =

> +	rm -f *.html
>  	rm -f *.o sample
> diff --git a/doc/examples/hello-static-lib/Makefile b/doc/examples/hello-=
static-lib/Makefile
> new file mode 100644
> index 0000000..c18fd3f
> --- /dev/null
> +++ b/doc/examples/hello-static-lib/Makefile
> @@ -0,0 +1,53 @@
> +# Copyright (C) 2013  J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
> +#
> +# THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
> +# OR IMPLIED. ANY USE IS AT YOUR OWN RISK.
> +#
> +# Permission is hereby granted to use or copy this program for any
> +# purpose, provided the above notices are retained on all copies.
> +# Permission to modify the code and to distribute modified code is
> +# granted, provided the above notices are retained, and a notice that
> +# the code was modified is included with the above copyright notice.
> +
> +# This Makefile is not using automake so that users may see how to build
> +# a program with tracepoint provider probes in static libraries.
> +
> +CC =3D gcc
> +CFLAGS +=3D -I.
> +LIBS =3D -ldl -llttng-ust	# On Linux
> +#LIBS =3D -lc -llttng-ust	# On BSD
> +
> +# Only necessary when building from the source tree and lttng-ust is not
> +# installed
> +ifdef BUILD_EXAMPLES_FROM_TREE
> +CFLAGS +=3D -I../../../include/
> +LIBLTTNG_UST_PATH =3D ../../../liblttng-ust/.libs/
> +LDFLAGS +=3D -L$(LIBLTTNG_UST_PATH) -Wl,-rpath=3D'$$ORIGIN/$(LIBLTTNG_US=
T_PATH)'
> +
> +# Third-party Makefiles have to define these targets to integrate with an
> +# automake project
> +EMPTY_AUTOMAKE_TARGETS =3D distdir install install-data install-exec uni=
nstall \
> +	install-dvi install-html install-info install-ps install-pdf \
> +	installdirs check installcheck mostlyclean distclean maintainer-clean \
> +	dvi html pdf ps info tags ctags
> +.PHONY: $(EMPTY_AUTOMAKE_TARGETS)
> +$(EMPTY_AUTOMAKE_TARGETS):
> +endif
> +
> +all: hello
> +
> +lttng-ust-provider-hello.o: tp.c ust_tests_hello.h
> +	$(CC) $(CFLAGS) -c -o $@ $<
> +
> +lttng-ust-provider-hello.a: lttng-ust-provider-hello.o
> +	ar -rc $@ $<
> +
> +hello.o: hello.c
> +	$(CC) $(CFLAGS) -c -o $@ $<
> +
> +hello: hello.o lttng-ust-provider-hello.a
> +	$(CC) -o $@ $(LDFLAGS) $(LIBS) $^
> +
> +.PHONY: clean
> +clean:
> +	rm -f *.o *.a hello
> diff --git a/doc/examples/hello-static-lib/README b/doc/examples/hello-st=
atic-lib/README
> new file mode 100644
> index 0000000..abb056f
> --- /dev/null
> +++ b/doc/examples/hello-static-lib/README
> @@ -0,0 +1,3 @@
> +This is a "hello world" application used to verify that an instrumented
> +program can be built successfully and linked with tracepoint providers
> +built as a separate static library.
> diff --git a/doc/examples/hello-static-lib/hello.c b/doc/examples/hello-s=
tatic-lib/hello.c
> new file mode 100644
> index 0000000..693709d
> --- /dev/null
> +++ b/doc/examples/hello-static-lib/hello.c
> @@ -0,0 +1,94 @@
> +/*
> + * Copyright (C) 2009  Pierre-Marc Fournier
> + * Copyright (C) 2011  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-=
1301 USA
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
> +
> +#define TRACEPOINT_DEFINE
> +#include "ust_tests_hello.h"
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
> +	result =3D sigemptyset(&act.sa_mask);
> +	if (result =3D=3D -1) {
> +		perror("sigemptyset");
> +		return -1;
> +	}
> +
> +	act.sa_handler =3D inthandler;
> +	act.sa_flags =3D SA_RESTART;
> +
> +	/* Only defer ourselves. Also, try to restart interrupted
> +	 * syscalls to disturb the traced program as little as possible.
> +	 */
> +	result =3D sigaction(SIGUSR1, &act, NULL);
> +	if (result =3D=3D -1) {
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
> +	long values[] =3D { 1, 2, 3 };
> +	char text[10] =3D "test";
> +	double dbl =3D 2.0;
> +	float flt =3D 2222.0;
> +	int delay =3D 0;
> +
> +	init_int_handler();
> +
> +	if (argc =3D=3D 2)
> +		delay =3D atoi(argv[1]);
> +
> +	fprintf(stderr, "Hello, World!\n");
> +
> +	sleep(delay);
> +
> +	fprintf(stderr, "Tracing... ");
> +	for (i =3D 0; i < 1000000; i++) {
> +		netint =3D htonl(i);
> +		tracepoint(ust_tests_hello, tptest, i, netint, values,
> +			   text, strlen(text), dbl, flt);
> +	}
> +	fprintf(stderr, " done.\n");
> +	return 0;
> +}
> diff --git a/doc/examples/hello-static-lib/tp.c b/doc/examples/hello-stat=
ic-lib/tp.c
> new file mode 100644
> index 0000000..4790965
> --- /dev/null
> +++ b/doc/examples/hello-static-lib/tp.c
> @@ -0,0 +1,26 @@
> +/*
> + * tp.c
> + *
> + * Copyright (c) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN THE
> + * SOFTWARE.
> + */
> +
> +#define TRACEPOINT_CREATE_PROBES
> +#include "ust_tests_hello.h"
> diff --git a/doc/examples/hello-static-lib/ust_tests_hello.h b/doc/exampl=
es/hello-static-lib/ust_tests_hello.h
> new file mode 100644
> index 0000000..35ea5f5
> --- /dev/null
> +++ b/doc/examples/hello-static-lib/ust_tests_hello.h
> @@ -0,0 +1,72 @@
> +#undef TRACEPOINT_PROVIDER
> +#define TRACEPOINT_PROVIDER ust_tests_hello
> +
> +#if !defined(_TRACEPOINT_UST_TESTS_HELLO_H) || defined(TRACEPOINT_HEADER=
_MULTI_READ)
> +#define _TRACEPOINT_UST_TESTS_HELLO_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * Copyright (C) 2011  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN THE
> + * SOFTWARE.
> + */
> +
> +#include <lttng/tracepoint.h>
> +
> +TRACEPOINT_EVENT(ust_tests_hello, tptest,
> +	TP_ARGS(int, anint, int, netint, long *, values,
> +		 char *, text, size_t, textlen,
> +		 double, doublearg, float, floatarg),
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
> +#undef TRACEPOINT_INCLUDE
> +#define TRACEPOINT_INCLUDE "./ust_tests_hello.h"
> +
> +/* This part must be outside ifdef protection */
> +#include <lttng/tracepoint-event.h>
> +
> +#ifdef __cplusplus
> +}
> +#endif
> diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3
> index 5be3cfa..585d133 100644
> --- a/doc/man/lttng-ust.3
> +++ b/doc/man/lttng-ust.3
> @@ -40,11 +40,11 @@ focus on the various types that can be recorded into =
a trace event:
>  TRACEPOINT_EVENT(
>  	/*
>  	 * provider name, not a variable but a string starting with a
> -	 * letter and containing either letters, numbers or underscores. =

> +	 * letter and containing either letters, numbers or underscores.
>  	 * Needs to be the same as TRACEPOINT_PROVIDER. Needs to
>  	 * follow the namespacing guide-lines in lttng/tracepoint.h:
> -	 * =

> -	 * Must be included before include tracepoint provider =

> +	 *
> +	 * Must be included before include tracepoint provider
>  	 * ex.: project_event
>  	 * ex.: project_component_event
>  	 *
> @@ -59,19 +59,19 @@ TRACEPOINT_EVENT(
>  	/*
>  	 * tracepoint name, same format as sample provider. Does not
>  	 * need to be declared before. in this case the name is
> -	 * "message" =

> +	 * "message"
>  	 */
>  	message,
>  =

>  	/*
> -	 * TP_ARGS macro contains the arguments passed for the tracepoint =

> +	 * TP_ARGS macro contains the arguments passed for the tracepoint
>  	 * it is in the following format
>  	 *	      TP_ARGS(type1, name1, type2, name2, ... type10,
>  				 name10)
> -	 * where there can be from zero to ten elements. =

> -	 * typeN is the datatype, such as int, struct or double **. =

> +	 * where there can be from zero to ten elements.
> +	 * typeN is the datatype, such as int, struct or double **.
>  	 * name is the variable name (in "int myInt" the name would be
> -	 * myint) =

> +	 * myint)
>  	 *	      TP_ARGS() is valid to mean no arguments
>  	 *	      TP_ARGS(void) is valid too
>  	 */
> @@ -80,7 +80,7 @@ TRACEPOINT_EVENT(
>  		 double, doublearg, float, floatarg),
>  =

>  	/*
> -	 * TP_FIELDS describes how to write the fields of the trace event. =

> +	 * TP_FIELDS describes how to write the fields of the trace event.
>  	 * You can put expressions in the "argument expression" area,
>  	 * typically using the input arguments from TP_ARGS.
>  	 */
> @@ -109,14 +109,14 @@ TRACEPOINT_EVENT(
>  		/*
>  		 * ctf_array: a statically-sized array.
>  		 * args: (type, field name, argument expression, value)
> -		 */ =

> +		 */
>  		ctf_array(long, arrfield1, values, 3)
>  =

>  		/*
>  		 * ctf_array_text: a statically-sized array, printed as
>  		 * a string. No need to be terminated by a null
>  		 * character.
> -		 */ =

> +		 */
>  		ctf_array_text(char, arrfield2, text, 10)
>  =

>  		/*
> @@ -127,7 +127,7 @@ TRACEPOINT_EVENT(
>  		 * unsigned type. As a reminder, "unsigned char" should
>  		 * be preferred to "char", since the signedness of
>  		 * "char" is implementation-defined.
> -		 */ =

> +		 */
>  		ctf_sequence(char, seqfield1, text,
>  			     size_t, textlen)
>  =

> @@ -172,54 +172,54 @@ declared before declaring a TRACEPOINT_LOGLEVEL.
>  =

>  The loglevels go from 0 to 14. Higher numbers imply the most verbosity
>  (higher event throughput expected.
> -  =

> +
>  Loglevels 0 through 6, and loglevel 14, match syslog(3) loglevels
>  semantic. Loglevels 7 through 13 offer more fine-grained selection of
>  debug information.
> -  =

> +
>     TRACE_EMERG           0
>     system is unusable
> -  =

> +
>     TRACE_ALERT           1
>     action must be taken immediately
> -  =

> +
>     TRACE_CRIT            2
>     critical conditions
> -  =

> +
>     TRACE_ERR             3
>     error conditions
> -  =

> +
>     TRACE_WARNING         4
>     warning conditions
> -  =

> +
>     TRACE_NOTICE          5
>     normal, but significant, condition
> -  =

> +
>     TRACE_INFO            6
>     informational message
> -  =

> +
>     TRACE_DEBUG_SYSTEM    7
>     debug information with system-level scope (set of programs)
> -  =

> +
>     TRACE_DEBUG_PROGRAM   8
>     debug information with program-level scope (set of processes)
> -  =

> +
>     TRACE_DEBUG_PROCESS   9
>     debug information with process-level scope (set of modules)
> -  =

> +
>     TRACE_DEBUG_MODULE    10
>     debug information with module (executable/library) scope (set of
>     units)
> -  =

> +
>     TRACE_DEBUG_UNIT      11
>     debug information with compilation unit scope (set of functions)
> -  =

> +
>     TRACE_DEBUG_FUNCTION  12
>     debug information with function-level scope
> -  =

> +
>     TRACE_DEBUG_LINE      13
>     debug information with line-level scope (TRACEPOINT_EVENT default)
> -  =

> +
>     TRACE_DEBUG           14
>     debug-level message (trace_printf default)
>  =

> @@ -269,7 +269,9 @@ carefully:
>      - Include the tracepoint provider header into all C files using
>        the provider.
>      - Example:
> -      - tests/hello/  hello.c tp.c ust_tests_hello.h Makefile.example
> +      - doc/examples/easy-ust/   sample.c sample_component_provider.h tp=
.c
> +        Makefile
> +      - doc/examples/hello-static-lib/   hello.c tp.c ust_test_hello.h M=
akefile
>  =

>    2) Compile the Tracepoint Provider separately from the application,
>       using dynamic linking:
> @@ -287,7 +289,7 @@ carefully:
>        needed. Another way is to dlopen the tracepoint probe when needed
>        by the application.
>      - Example:
> -      - doc/examples/demo   demo.c  tp*.c ust_tests_demo*.h demo-trace
> +      - doc/examples/demo   demo.c  tp*.c ust_tests_demo*.h demo-trace M=
akefile
>  =

>    - Note about dlclose() usage: it is not safe to use dlclose on a
>      provider shared object that is being actively used for tracing due
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index 425440a..8c971e3 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -1,4 +1,4 @@
> -SUBDIRS =3D . hello hello-static-lib same_line_tracepoint snprintf
> +SUBDIRS =3D . same_line_tracepoint snprintf
>  =

>  if CXX_WORKS
>  SUBDIRS +=3D hello.cxx
> diff --git a/tests/hello-static-lib/Makefile.am b/tests/hello-static-lib/=
Makefile.am
> deleted file mode 100644
> index 699845b..0000000
> --- a/tests/hello-static-lib/Makefile.am
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -AM_CPPFLAGS =3D -I$(top_srcdir)/include -I$(top_builddir)/include -Wsyst=
em-headers
> -
> -noinst_LTLIBRARIES =3D liblttng-ust-provider-ust-test-hello.la
> -liblttng_ust_provider_ust_test_hello_la_SOURCES =3D \
> -	tp.c ust_tests_hello.h
> -liblttng_ust_provider_ust_test_hello_la_LIBADD =3D \
> -	$(top_builddir)/liblttng-ust/liblttng-ust.la
> -
> -noinst_PROGRAMS =3D hello
> -hello_SOURCES =3D hello.c
> -hello_LDADD =3D liblttng-ust-provider-ust-test-hello.la
> -
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -hello_LDADD +=3D -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -hello_LDADD +=3D -lc
> -endif
> diff --git a/tests/hello-static-lib/README b/tests/hello-static-lib/README
> deleted file mode 100644
> index abb056f..0000000
> --- a/tests/hello-static-lib/README
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -This is a "hello world" application used to verify that an instrumented
> -program can be built successfully and linked with tracepoint providers
> -built as a separate static library.
> diff --git a/tests/hello-static-lib/hello.c b/tests/hello-static-lib/hell=
o.c
> deleted file mode 100644
> index 584d3f7..0000000
> --- a/tests/hello-static-lib/hello.c
> +++ /dev/null
> @@ -1,95 +0,0 @@
> -/*
> - * Copyright (C) 2009  Pierre-Marc Fournier
> - * Copyright (C) 2011  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; version 2.1 of
> - * the License.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-=
1301 USA
> - */
> -
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <sys/mman.h>
> -#include <stdarg.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <signal.h>
> -#include <string.h>
> -#include <arpa/inet.h>
> -#include <stdlib.h>
> -
> -#define TRACEPOINT_DEFINE
> -#include "ust_tests_hello.h"
> -
> -void inthandler(int sig)
> -{
> -	printf("in SIGUSR1 handler\n");
> -	tracepoint(ust_tests_hello, tptest_sighandler);
> -}
> -
> -int init_int_handler(void)
> -{
> -	int result;
> -	struct sigaction act;
> -
> -	memset(&act, 0, sizeof(act));
> -	result =3D sigemptyset(&act.sa_mask);
> -	if (result =3D=3D -1) {
> -		perror("sigemptyset");
> -		return -1;
> -	}
> -
> -	act.sa_handler =3D inthandler;
> -	act.sa_flags =3D SA_RESTART;
> -
> -	/* Only defer ourselves. Also, try to restart interrupted
> -	 * syscalls to disturb the traced program as little as possible.
> -	 */
> -	result =3D sigaction(SIGUSR1, &act, NULL);
> -	if (result =3D=3D -1) {
> -		perror("sigaction");
> -		return -1;
> -	}
> -
> -	return 0;
> -}
> -
> -int main(int argc, char **argv)
> -{
> -	int i, netint;
> -	long values[] =3D { 1, 2, 3 };
> -	char text[10] =3D "test";
> -	double dbl =3D 2.0;
> -	float flt =3D 2222.0;
> -	int delay =3D 0;
> -
> -	init_int_handler();
> -
> -	if (argc =3D=3D 2)
> -		delay =3D atoi(argv[1]);
> -
> -	fprintf(stderr, "Hello, World!\n");
> -
> -	sleep(delay);
> -
> -	fprintf(stderr, "Tracing... ");
> -	for (i =3D 0; i < 1000000; i++) {
> -		netint =3D htonl(i);
> -		tracepoint(ust_tests_hello, tptest, i, netint, values,
> -			   text, strlen(text), dbl, flt);
> -		//usleep(100000);
> -	}
> -	fprintf(stderr, " done.\n");
> -	return 0;
> -}
> diff --git a/tests/hello-static-lib/tp.c b/tests/hello-static-lib/tp.c
> deleted file mode 100644
> index 4790965..0000000
> --- a/tests/hello-static-lib/tp.c
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/*
> - * tp.c
> - *
> - * Copyright (c) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> - * of this software and associated documentation files (the "Software"),=
 to deal
> - * in the Software without restriction, including without limitation the=
 rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL THE
> - * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN THE
> - * SOFTWARE.
> - */
> -
> -#define TRACEPOINT_CREATE_PROBES
> -#include "ust_tests_hello.h"
> diff --git a/tests/hello-static-lib/ust_tests_hello.h b/tests/hello-stati=
c-lib/ust_tests_hello.h
> deleted file mode 100644
> index 35ea5f5..0000000
> --- a/tests/hello-static-lib/ust_tests_hello.h
> +++ /dev/null
> @@ -1,72 +0,0 @@
> -#undef TRACEPOINT_PROVIDER
> -#define TRACEPOINT_PROVIDER ust_tests_hello
> -
> -#if !defined(_TRACEPOINT_UST_TESTS_HELLO_H) || defined(TRACEPOINT_HEADER=
_MULTI_READ)
> -#define _TRACEPOINT_UST_TESTS_HELLO_H
> -
> -#ifdef __cplusplus
> -extern "C" {
> -#endif
> -
> -/*
> - * Copyright (C) 2011  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> - * of this software and associated documentation files (the "Software"),=
 to deal
> - * in the Software without restriction, including without limitation the=
 rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL THE
> - * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN THE
> - * SOFTWARE.
> - */
> -
> -#include <lttng/tracepoint.h>
> -
> -TRACEPOINT_EVENT(ust_tests_hello, tptest,
> -	TP_ARGS(int, anint, int, netint, long *, values,
> -		 char *, text, size_t, textlen,
> -		 double, doublearg, float, floatarg),
> -	TP_FIELDS(
> -		ctf_integer(int, intfield, anint)
> -		ctf_integer_hex(int, intfield2, anint)
> -		ctf_integer(long, longfield, anint)
> -		ctf_integer_network(int, netintfield, netint)
> -		ctf_integer_network_hex(int, netintfieldhex, netint)
> -		ctf_array(long, arrfield1, values, 3)
> -		ctf_array_text(char, arrfield2, text, 10)
> -		ctf_sequence(char, seqfield1, text,
> -			     size_t, textlen)
> -		ctf_sequence_text(char, seqfield2, text,
> -			     size_t, textlen)
> -		ctf_string(stringfield, text)
> -		ctf_float(float, floatfield, floatarg)
> -		ctf_float(double, doublefield, doublearg)
> -	)
> -)
> -
> -TRACEPOINT_EVENT(ust_tests_hello, tptest_sighandler,
> -	TP_ARGS(),
> -	TP_FIELDS()
> -)
> -
> -#endif /* _TRACEPOINT_UST_TESTS_HELLO_H */
> -
> -#undef TRACEPOINT_INCLUDE
> -#define TRACEPOINT_INCLUDE "./ust_tests_hello.h"
> -
> -/* This part must be outside ifdef protection */
> -#include <lttng/tracepoint-event.h>
> -
> -#ifdef __cplusplus
> -}
> -#endif
> diff --git a/tests/hello/Makefile.am b/tests/hello/Makefile.am
> deleted file mode 100644
> index 324c2cd..0000000
> --- a/tests/hello/Makefile.am
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -AM_CPPFLAGS =3D -I$(top_srcdir)/include -I$(top_builddir)/include -Wsyst=
em-headers
> -
> -noinst_PROGRAMS =3D hello
> -hello_SOURCES =3D hello.c tp.c ust_tests_hello.h
> -hello_LDADD =3D $(top_builddir)/liblttng-ust/liblttng-ust.la
> -hello_CFLAGS =3D -Werror=3Dold-style-definition
> -
> -if LTTNG_UST_BUILD_WITH_LIBDL
> -hello_LDADD +=3D -ldl
> -endif
> -if LTTNG_UST_BUILD_WITH_LIBC_DL
> -hello_LDADD +=3D -lc
> -endif
> diff --git a/tests/hello/Makefile.example.bsd b/tests/hello/Makefile.exam=
ple.bsd
> deleted file mode 100644
> index 607171c..0000000
> --- a/tests/hello/Makefile.example.bsd
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -# Example makefile for build outside of the LTTng-UST tree.
> -
> -hello:
> -	${CC} -O2 -I. -o hello -lc -llttng-ust hello.c tp.c
> -
> -.PHONY: clean
> -clean:
> -	rm -f hello
> diff --git a/tests/hello/Makefile.example.linux b/tests/hello/Makefile.ex=
ample.linux
> deleted file mode 100644
> index c983f4c..0000000
> --- a/tests/hello/Makefile.example.linux
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -# Example makefile for build outside of the LTTng-UST tree.
> -
> -hello:
> -	${CC} -O2 -I. -o hello -ldl -llttng-ust hello.c tp.c
> -
> -.PHONY: clean
> -clean:
> -	rm -f hello
> diff --git a/tests/hello/README b/tests/hello/README
> deleted file mode 100644
> index 5d5100d..0000000
> --- a/tests/hello/README
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -This is a "hello world" application used to verify that an instrumented
> -program can be built successfully.
> \ No newline at end of file
> diff --git a/tests/hello/hello.c b/tests/hello/hello.c
> deleted file mode 100644
> index 0c18c01..0000000
> --- a/tests/hello/hello.c
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -/*
> - * Copyright (C) 2009  Pierre-Marc Fournier
> - * Copyright (C) 2011  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; version 2.1 of
> - * the License.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-=
1301 USA
> - */
> -
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <sys/mman.h>
> -#include <stdarg.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <signal.h>
> -#include <string.h>
> -#include <arpa/inet.h>
> -#include <stdlib.h>
> -#include <stdbool.h>
> -
> -#define TRACEPOINT_DEFINE
> -#include "ust_tests_hello.h"
> -
> -void inthandler(int sig)
> -{
> -	printf("in SIGUSR1 handler\n");
> -	tracepoint(ust_tests_hello, tptest_sighandler);
> -}
> -
> -int init_int_handler(void)
> -{
> -	int result;
> -	struct sigaction act;
> -
> -	memset(&act, 0, sizeof(act));
> -	result =3D sigemptyset(&act.sa_mask);
> -	if (result =3D=3D -1) {
> -		perror("sigemptyset");
> -		return -1;
> -	}
> -
> -	act.sa_handler =3D inthandler;
> -	act.sa_flags =3D SA_RESTART;
> -
> -	/* Only defer ourselves. Also, try to restart interrupted
> -	 * syscalls to disturb the traced program as little as possible.
> -	 */
> -	result =3D sigaction(SIGUSR1, &act, NULL);
> -	if (result =3D=3D -1) {
> -		perror("sigaction");
> -		return -1;
> -	}
> -
> -	return 0;
> -}
> -
> -int main(int argc, char **argv)
> -{
> -	int i, netint;
> -	long values[] =3D { 1, 2, 3 };
> -	char text[10] =3D "test";
> -	double dbl =3D 2.0;
> -	float flt =3D 2222.0;
> -	int delay =3D 0;
> -	bool mybool =3D 123;	/* should print "1" */
> -
> -	init_int_handler();
> -
> -	if (argc =3D=3D 2)
> -		delay =3D atoi(argv[1]);
> -
> -	fprintf(stderr, "Hello, World!\n");
> -
> -	sleep(delay);
> -
> -	fprintf(stderr, "Tracing... ");
> -	for (i =3D 0; i < 1000000; i++) {
> -		netint =3D htonl(i);
> -		tracepoint(ust_tests_hello, tptest, i, netint, values,
> -			   text, strlen(text), dbl, flt, mybool);
> -		//usleep(100000);
> -	}
> -	fprintf(stderr, " done.\n");
> -	return 0;
> -}
> diff --git a/tests/hello/tp.c b/tests/hello/tp.c
> deleted file mode 100644
> index 4790965..0000000
> --- a/tests/hello/tp.c
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/*
> - * tp.c
> - *
> - * Copyright (c) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> - * of this software and associated documentation files (the "Software"),=
 to deal
> - * in the Software without restriction, including without limitation the=
 rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL THE
> - * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN THE
> - * SOFTWARE.
> - */
> -
> -#define TRACEPOINT_CREATE_PROBES
> -#include "ust_tests_hello.h"
> diff --git a/tests/hello/ust_tests_hello.h b/tests/hello/ust_tests_hello.h
> deleted file mode 100644
> index 88f1a7f..0000000
> --- a/tests/hello/ust_tests_hello.h
> +++ /dev/null
> @@ -1,76 +0,0 @@
> -#undef TRACEPOINT_PROVIDER
> -#define TRACEPOINT_PROVIDER ust_tests_hello
> -
> -#if !defined(_TRACEPOINT_UST_TESTS_HELLO_H) || defined(TRACEPOINT_HEADER=
_MULTI_READ)
> -#define _TRACEPOINT_UST_TESTS_HELLO_H
> -
> -#ifdef __cplusplus
> -extern "C" {
> -#endif
> -
> -/*
> - * Copyright (C) 2011  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> - * of this software and associated documentation files (the "Software"),=
 to deal
> - * in the Software without restriction, including without limitation the=
 rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL THE
> - * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN THE
> - * SOFTWARE.
> - */
> -
> -#include <lttng/tracepoint.h>
> -#include <stdbool.h>
> -
> -TRACEPOINT_EVENT(ust_tests_hello, tptest,
> -	TP_ARGS(int, anint, int, netint, long *, values,
> -		char *, text, size_t, textlen,
> -		double, doublearg, float, floatarg,
> -		bool, boolarg),
> -	TP_FIELDS(
> -		ctf_integer(int, intfield, anint)
> -		ctf_integer_hex(int, intfield2, anint)
> -		ctf_integer(long, longfield, anint)
> -		ctf_integer_network(int, netintfield, netint)
> -		ctf_integer_network_hex(int, netintfieldhex, netint)
> -		ctf_array(long, arrfield1, values, 3)
> -		ctf_array_text(char, arrfield2, text, 10)
> -		ctf_sequence(char, seqfield1, text,
> -			     size_t, textlen)
> -		ctf_sequence_text(char, seqfield2, text,
> -			     size_t, textlen)
> -		ctf_string(stringfield, text)
> -		ctf_float(float, floatfield, floatarg)
> -		ctf_float(double, doublefield, doublearg)
> -		ctf_integer(bool, boolfield, boolarg)
> -		ctf_integer_nowrite(int, filterfield, anint)
> -	)
> -)
> -
> -TRACEPOINT_EVENT(ust_tests_hello, tptest_sighandler,
> -	TP_ARGS(),
> -	TP_FIELDS()
> -)
> -
> -#endif /* _TRACEPOINT_UST_TESTS_HELLO_H */
> -
> -#undef TRACEPOINT_INCLUDE
> -#define TRACEPOINT_INCLUDE "./ust_tests_hello.h"
> -
> -/* This part must be outside ifdef protection */
> -#include <lttng/tracepoint-event.h>
> -
> -#ifdef __cplusplus
> -}
> -#endif
> -- =

> 1.8.2.1
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
