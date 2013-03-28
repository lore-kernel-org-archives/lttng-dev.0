From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add demo test back as an example
Date: Thu, 28 Mar 2013 09:50:40 -0400
Message-ID: <20130328135040.GA29485__2303.60007049075$1364478707$gmane$org@Krystal>
References: <1364443511-5091-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1ULDE3-0008PL-TR
	for lttng-dev@lists.lttng.org; Thu, 28 Mar 2013 09:50:44 -0400
Content-Disposition: inline
In-Reply-To: <1364443511-5091-1-git-send-email-jeremie.galarneau@efficios.com>
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

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> Updated the lttng-ust man page to point to doc/examples/demo instead
> of the now moved /tests/demo.

Merged, thanks! I added demo to doc/examples/Makefile.am too.

Moreover, do we need "hello" under tests ? Why not move it under
doc/examples ?

Also, we'd need to add capability to build examples within the tree from
automake. e.g.

make examples

from lttng-ust root. (or with just a simple "make" or "make check" maybe ?)

Thanks,

Mathieu

> =

> Minor typo fix.
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  doc/examples/demo/Makefile          | 42 ++++++++++++++++++++++
>  doc/examples/demo/README            | 27 ++++++++++++++
>  doc/examples/demo/demo-trace        |  6 ++++
>  doc/examples/demo/demo.c            | 65 +++++++++++++++++++++++++++++++=
++
>  doc/examples/demo/tp.c              | 26 ++++++++++++++
>  doc/examples/demo/tp2.c             | 26 ++++++++++++++
>  doc/examples/demo/tp3.c             | 26 ++++++++++++++
>  doc/examples/demo/ust_tests_demo.h  | 71 +++++++++++++++++++++++++++++++=
++++++
>  doc/examples/demo/ust_tests_demo2.h | 68 +++++++++++++++++++++++++++++++=
++++
>  doc/examples/demo/ust_tests_demo3.h | 53 +++++++++++++++++++++++++++
>  doc/man/lttng-ust.3                 |  4 +--
>  11 files changed, 412 insertions(+), 2 deletions(-)
>  create mode 100644 doc/examples/demo/Makefile
>  create mode 100644 doc/examples/demo/README
>  create mode 100755 doc/examples/demo/demo-trace
>  create mode 100644 doc/examples/demo/demo.c
>  create mode 100644 doc/examples/demo/tp.c
>  create mode 100644 doc/examples/demo/tp2.c
>  create mode 100644 doc/examples/demo/tp3.c
>  create mode 100644 doc/examples/demo/ust_tests_demo.h
>  create mode 100644 doc/examples/demo/ust_tests_demo2.h
>  create mode 100644 doc/examples/demo/ust_tests_demo3.h
> =

> diff --git a/doc/examples/demo/Makefile b/doc/examples/demo/Makefile
> new file mode 100644
> index 0000000..41f4321
> --- /dev/null
> +++ b/doc/examples/demo/Makefile
> @@ -0,0 +1,42 @@
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
> +# This Makefile is not using automake so that people may see how to build
> +# a program and tracepoint provider probes as stand-alone shared objects.
> +
> +CC =3D gcc
> +LIBS =3D -ldl	# On Linux
> +#LIBS =3D -lc	# On BSD
> +CFLAGS =3D -I.
> +
> +all: demo lttng-ust-provider-ust-tests-demo.so lttng-ust-provider-ust-te=
sts-demo3.so
> +
> +lttng-ust-provider-ust-tests-demo.o: tp.c tp2.c ust_tests_demo.h ust_tes=
ts_demo2.h
> +	$(CC) $(CFLAGS) -fpic -c -o $@ $<
> +
> +lttng-ust-provider-ust-tests-demo.so: lttng-ust-provider-ust-tests-demo.o
> +	$(CC) -shared -o $@ -llttng-ust $<
> +
> +lttng-ust-provider-ust-tests-demo3.o: tp3.c ust_tests_demo3.h
> +	$(CC) $(CFLAGS) -fpic -c -o $@ $<
> +
> +lttng-ust-provider-ust-tests-demo3.so: lttng-ust-provider-ust-tests-demo=
3.o
> +	$(CC) -shared -o $@ -llttng-ust $<
> +
> +demo.o: demo.c
> +	$(CC) $(CFLAGS) -c -o $@ $<
> +
> +demo: demo.o
> +	$(CC) demo.o -o $@ $(LIBS)
> +
> +.PHONY: clean
> +clean:
> +	rm -f *.o *.so demo
> diff --git a/doc/examples/demo/README b/doc/examples/demo/README
> new file mode 100644
> index 0000000..03ee4ee
> --- /dev/null
> +++ b/doc/examples/demo/README
> @@ -0,0 +1,27 @@
> +This is a demo application used to test the LTTng userspace tracer.
> +
> +demo-trace shell script preloads the provider shared objects before
> +executing the demo. Executing "demo" without the shell wrapper will not
> +provide any tracing support. This ensures the demo binary can be
> +distributed on distros without depending on having liblttng-ust.so in
> +place. Note: the "demo" program must be compiled with "-ldl" on Linux,
> +with "-lc" on BSD.
> +
> +The simplest command to trace the demo program are:
> +lttng create
> +lttng enable-event -u -a
> +lttng start
> +./demo-trace
> +lttng destroy
> +
> +That will create a trace in your $HOME/lttng-traces directory.
> +
> +The resulting babeltrace output should look like this:
> +[554297567999315] ust_tests_demo:starting: { 1 }, { value =3D 123 }
> +[554297568020834] ust_tests_demo2:loop: { 1 }, { intfield =3D 0, intfiel=
d2 =3D 0x0, longfield =3D 0, netintfield =3D 0, netintfieldhex =3D 0x0, arr=
field1 =3D [ [0] =3D 1, [1] =3D 2, [2] =3D 3 ], arrfield2 =3D "test", _seqf=
ield1_length =3D 4, seqfield1 =3D [ [0] =3D 116, [1] =3D 101, [2] =3D 115, =
[3] =3D 116 ], _seqfield2_length =3D 4, seqfield2 =3D "test", stringfield =
=3D "test", floatfield =3D 2222, doublefield =3D 2 }
> +[554297568024780] ust_tests_demo2:loop: { 1 }, { intfield =3D 1, intfiel=
d2 =3D 0x1, longfield =3D 1, netintfield =3D 1, netintfieldhex =3D 0x1, arr=
field1 =3D [ [0] =3D 1, [1] =3D 2, [2] =3D 3 ], arrfield2 =3D "test", _seqf=
ield1_length =3D 4, seqfield1 =3D [ [0] =3D 116, [1] =3D 101, [2] =3D 115, =
[3] =3D 116 ], _seqfield2_length =3D 4, seqfield2 =3D "test", stringfield =
=3D "test", floatfield =3D 2222, doublefield =3D 2 }
> +[554297568027050] ust_tests_demo2:loop: { 1 }, { intfield =3D 2, intfiel=
d2 =3D 0x2, longfield =3D 2, netintfield =3D 2, netintfieldhex =3D 0x2, arr=
field1 =3D [ [0] =3D 1, [1] =3D 2, [2] =3D 3 ], arrfield2 =3D "test", _seqf=
ield1_length =3D 4, seqfield1 =3D [ [0] =3D 116, [1] =3D 101, [2] =3D 115, =
[3] =3D 116 ], _seqfield2_length =3D 4, seqfield2 =3D "test", stringfield =
=3D "test", floatfield =3D 2222, doublefield =3D 2 }
> +[554297568029014] ust_tests_demo2:loop: { 1 }, { intfield =3D 3, intfiel=
d2 =3D 0x3, longfield =3D 3, netintfield =3D 3, netintfieldhex =3D 0x3, arr=
field1 =3D [ [0] =3D 1, [1] =3D 2, [2] =3D 3 ], arrfield2 =3D "test", _seqf=
ield1_length =3D 4, seqfield1 =3D [ [0] =3D 116, [1] =3D 101, [2] =3D 115, =
[3] =3D 116 ], _seqfield2_length =3D 4, seqfield2 =3D "test", stringfield =
=3D "test", floatfield =3D 2222, doublefield =3D 2 }
> +[554297568030861] ust_tests_demo2:loop: { 1 }, { intfield =3D 4, intfiel=
d2 =3D 0x4, longfield =3D 4, netintfield =3D 4, netintfieldhex =3D 0x4, arr=
field1 =3D [ [0] =3D 1, [1] =3D 2, [2] =3D 3 ], arrfield2 =3D "test", _seqf=
ield1_length =3D 4, seqfield1 =3D [ [0] =3D 116, [1] =3D 101, [2] =3D 115, =
[3] =3D 116 ], _seqfield2_length =3D 4, seqfield2 =3D "test", stringfield =
=3D "test", floatfield =3D 2222, doublefield =3D 2 }
> +[554297568033138] ust_tests_demo:done: { 1 }, { value =3D 456 }
> +[554297568034533] ust_tests_demo3:done: { 1 }, { value =3D 42 }
> diff --git a/doc/examples/demo/demo-trace b/doc/examples/demo/demo-trace
> new file mode 100755
> index 0000000..dd67727
> --- /dev/null
> +++ b/doc/examples/demo/demo-trace
> @@ -0,0 +1,6 @@
> +#!/bin/sh
> +
> +DIR=3D$(dirname $0)
> +DIR=3D$(readlink -f $DIR)
> +
> +LD_PRELOAD=3D$DIR/lttng-ust-provider-ust-tests-demo.so:$DIR/lttng-ust-pr=
ovider-ust-tests-demo3.so $DIR/demo ${*}
> diff --git a/doc/examples/demo/demo.c b/doc/examples/demo/demo.c
> new file mode 100644
> index 0000000..e2b61c2
> --- /dev/null
> +++ b/doc/examples/demo/demo.c
> @@ -0,0 +1,65 @@
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
> +#define TRACEPOINT_PROBE_DYNAMIC_LINKAGE
> +#include "ust_tests_demo.h"
> +#include "ust_tests_demo2.h"
> +#include "ust_tests_demo3.h"
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
> +	if (argc =3D=3D 2)
> +		delay =3D atoi(argv[1]);
> +
> +	fprintf(stderr, "Demo program starting.\n");
> +
> +	sleep(delay);
> +
> +	fprintf(stderr, "Tracing... ");
> +	tracepoint(ust_tests_demo, starting, 123);
> +	for (i =3D 0; i < 5; i++) {
> +		netint =3D htonl(i);
> +		tracepoint(ust_tests_demo2, loop, i, netint, values,
> +			   text, strlen(text), dbl, flt);
> +	}
> +	tracepoint(ust_tests_demo, done, 456);
> +	tracepoint(ust_tests_demo3, done, 42);
> +	fprintf(stderr, " done.\n");
> +	return 0;
> +}
> diff --git a/doc/examples/demo/tp.c b/doc/examples/demo/tp.c
> new file mode 100644
> index 0000000..8e44db4
> --- /dev/null
> +++ b/doc/examples/demo/tp.c
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
> +#include "ust_tests_demo.h"
> diff --git a/doc/examples/demo/tp2.c b/doc/examples/demo/tp2.c
> new file mode 100644
> index 0000000..ba45c23
> --- /dev/null
> +++ b/doc/examples/demo/tp2.c
> @@ -0,0 +1,26 @@
> +/*
> + * tp2.c
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
> +#include "ust_tests_demo2.h"
> diff --git a/doc/examples/demo/tp3.c b/doc/examples/demo/tp3.c
> new file mode 100644
> index 0000000..5f97651
> --- /dev/null
> +++ b/doc/examples/demo/tp3.c
> @@ -0,0 +1,26 @@
> +/*
> + * tp3.c
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
> +#include "ust_tests_demo3.h"
> diff --git a/doc/examples/demo/ust_tests_demo.h b/doc/examples/demo/ust_t=
ests_demo.h
> new file mode 100644
> index 0000000..b27d539
> --- /dev/null
> +++ b/doc/examples/demo/ust_tests_demo.h
> @@ -0,0 +1,71 @@
> +#undef TRACEPOINT_PROVIDER
> +#define TRACEPOINT_PROVIDER ust_tests_demo
> +
> +#if !defined(_TRACEPOINT_UST_TESTS_DEMO_H) || defined(TRACEPOINT_HEADER_=
MULTI_READ)
> +#define _TRACEPOINT_UST_TESTS_DEMO_H
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
> +TRACEPOINT_EVENT(ust_tests_demo, starting,
> +	TP_ARGS(int, value),
> +	TP_FIELDS(
> +		ctf_integer(int, value, value)
> +	)
> +)
> +TRACEPOINT_LOGLEVEL(ust_tests_demo, starting, TRACE_CRIT)
> +
> +/*
> + * Dummy model information, just for example. TODO: we should check if
> + * EMF model URI have some standard format we should follow.
> + */
> +TRACEPOINT_MODEL_EMF_URI(ust_tests_demo, starting,
> +	"http://example.com/path_to_model?q=3Dust_tests_demo:starting")
> +
> +TRACEPOINT_EVENT(ust_tests_demo, done,
> +	TP_ARGS(int, value),
> +	TP_FIELDS(
> +		ctf_integer(int, value, value)
> +	)
> +)
> +TRACEPOINT_LOGLEVEL(ust_tests_demo, done, TRACE_CRIT)
> +
> +TRACEPOINT_MODEL_EMF_URI(ust_tests_demo, done,
> +	"http://example.com/path_to_model?q=3Dust_tests_demo:done")
> +
> +#endif /* _TRACEPOINT_UST_TESTS_DEMO_H */
> +
> +#undef TRACEPOINT_INCLUDE
> +#define TRACEPOINT_INCLUDE "./ust_tests_demo.h"
> +
> +/* This part must be outside ifdef protection */
> +#include <lttng/tracepoint-event.h>
> +
> +#ifdef __cplusplus
> +}
> +#endif
> diff --git a/doc/examples/demo/ust_tests_demo2.h b/doc/examples/demo/ust_=
tests_demo2.h
> new file mode 100644
> index 0000000..25d42ad
> --- /dev/null
> +++ b/doc/examples/demo/ust_tests_demo2.h
> @@ -0,0 +1,68 @@
> +#undef TRACEPOINT_PROVIDER
> +#define TRACEPOINT_PROVIDER ust_tests_demo2
> +
> +#if !defined(_TRACEPOINT_UST_TESTS_DEMO2_H) || defined(TRACEPOINT_HEADER=
_MULTI_READ)
> +#define _TRACEPOINT_UST_TESTS_DEMO2_H
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
> +TRACEPOINT_EVENT(ust_tests_demo2, loop,
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
> +TRACEPOINT_LOGLEVEL(ust_tests_demo2, loop, TRACE_WARNING)
> +
> +#endif /* _TRACEPOINT_UST_TESTS_DEMO2_H */
> +
> +#undef TRACEPOINT_INCLUDE
> +#define TRACEPOINT_INCLUDE "./ust_tests_demo2.h"
> +
> +/* This part must be outside ifdef protection */
> +#include <lttng/tracepoint-event.h>
> +
> +#ifdef __cplusplus
> +}
> +#endif
> diff --git a/doc/examples/demo/ust_tests_demo3.h b/doc/examples/demo/ust_=
tests_demo3.h
> new file mode 100644
> index 0000000..c7b63dd
> --- /dev/null
> +++ b/doc/examples/demo/ust_tests_demo3.h
> @@ -0,0 +1,53 @@
> +#undef TRACEPOINT_PROVIDER
> +#define TRACEPOINT_PROVIDER ust_tests_demo3
> +
> +#if !defined(_TRACEPOINT_UST_TESTS_DEMO3_H) || defined(TRACEPOINT_HEADER=
_MULTI_READ)
> +#define _TRACEPOINT_UST_TESTS_DEMO3_H
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
> +TRACEPOINT_EVENT(ust_tests_demo3, done,
> +	TP_ARGS(int, value),
> +	TP_FIELDS(
> +		ctf_integer(int, value, value)
> +	)
> +)
> +TRACEPOINT_LOGLEVEL(ust_tests_demo3, done, TRACE_WARNING)
> +
> +#endif /* _TRACEPOINT_UST_TESTS_DEMO3_H */
> +
> +#undef TRACEPOINT_INCLUDE
> +#define TRACEPOINT_INCLUDE "./ust_tests_demo3.h"
> +
> +/* This part must be outside ifdef protection */
> +#include <lttng/tracepoint-event.h>
> +
> +#ifdef __cplusplus
> +}
> +#endif
> diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3
> index 7cc3bfd..da3976d 100644
> --- a/doc/man/lttng-ust.3
> +++ b/doc/man/lttng-ust.3
> @@ -283,7 +283,7 @@ carefully:
>        needed. Another way is to dlopen the tracepoint probe when needed
>        by the application.
>      - Example:
> -      - tests/demo/   demo.c  tp*.c ust_tests_demo*.h demo-trace
> +      - doc/examples/demo   demo.c  tp*.c ust_tests_demo*.h demo-trace
>  =

>    - Note about dlclose() usage: it is not safe to use dlclose on a
>      provider shared object that is being actively used for tracing due
> @@ -365,7 +365,7 @@ lttng-gen-tp(1), lttng(1), babeltrace(1), lttng-sessi=
ond(8)
>  .SH "BUGS"
>  =

>  .PP
> -No knows bugs at this point.
> +No known bugs at this point.
>  =

>  If you encounter any issues or usability problem, please report it on
>  our mailing list <lttng-dev@lists.lttng.org> to help improve this
> -- =

> 1.8.2
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
