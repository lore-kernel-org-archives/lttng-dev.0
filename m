From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 1/6] Tests: Cleanup and move
 gen-ust-events testapp under utils
Date: Tue, 14 May 2013 10:20:04 -0400
Message-ID: <51924814.3020509__23688.422542955$1368541247$gmane$org@efficios.com>
References: <1368484256-6666-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UcG5M-0002Ah-N9
	for lttng-dev@lists.lttng.org; Tue, 14 May 2013 10:20:13 -0400
In-Reply-To: <1368484256-6666-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

All 6 patches merged.

David

Christian Babeux:
> This will improve the maintainability and stop the copying madness going
> on in each test needing a UST sample application.
> 
> Application under test should go in tests/utils/testapp/<testapp_name>/.
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  configure.ac                                       |  2 +
>  tests/utils/Makefile.am                            |  2 +-
>  tests/utils/testapp/Makefile.am                    |  2 +
>  tests/utils/testapp/gen-ust-events/Makefile.am     | 15 ++++++
>  .../utils/testapp/gen-ust-events/gen-ust-events.c  | 58 ++++++++++++++++++++++
>  tests/utils/testapp/gen-ust-events/tp.c            | 15 ++++++
>  tests/utils/testapp/gen-ust-events/tp.h            | 56 +++++++++++++++++++++
>  7 files changed, 149 insertions(+), 1 deletion(-)
>  create mode 100644 tests/utils/testapp/Makefile.am
>  create mode 100644 tests/utils/testapp/gen-ust-events/Makefile.am
>  create mode 100644 tests/utils/testapp/gen-ust-events/gen-ust-events.c
>  create mode 100644 tests/utils/testapp/gen-ust-events/tp.c
>  create mode 100644 tests/utils/testapp/gen-ust-events/tp.h
> 
> diff --git a/configure.ac b/configure.ac
> index 650ae7f..9f14c12 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -341,6 +341,8 @@ AC_CONFIG_FILES([
>  	tests/unit/Makefile
>  	tests/utils/Makefile
>  	tests/utils/tap/Makefile
> +	tests/utils/testapp/Makefile
> +	tests/utils/testapp/gen-ust-events/Makefile
>  ])
>  
>  AC_OUTPUT
> diff --git a/tests/utils/Makefile.am b/tests/utils/Makefile.am
> index 25c6e04..e0de483 100644
> --- a/tests/utils/Makefile.am
> +++ b/tests/utils/Makefile.am
> @@ -1,4 +1,4 @@
> -SUBDIRS = tap
> +SUBDIRS = tap testapp
>  
>  EXTRA_DIST = utils.sh test_utils.py
>  dist_noinst_SCRIPTS = utils.sh test_utils.py
> diff --git a/tests/utils/testapp/Makefile.am b/tests/utils/testapp/Makefile.am
> new file mode 100644
> index 0000000..8b631ee
> --- /dev/null
> +++ b/tests/utils/testapp/Makefile.am
> @@ -0,0 +1,2 @@
> +SUBDIRS = gen-ust-events
> +
> diff --git a/tests/utils/testapp/gen-ust-events/Makefile.am b/tests/utils/testapp/gen-ust-events/Makefile.am
> new file mode 100644
> index 0000000..1be5835
> --- /dev/null
> +++ b/tests/utils/testapp/gen-ust-events/Makefile.am
> @@ -0,0 +1,15 @@
> +AM_CFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src -I$(srcdir) -O2 -g
> +AM_LDFLAGS =
> +
> +if LTTNG_TOOLS_BUILD_WITH_LIBDL
> +AM_LDFLAGS += -ldl
> +endif
> +if LTTNG_TOOLS_BUILD_WITH_LIBC_DL
> +AM_LDFLAGS += -lc
> +endif
> +
> +if HAVE_LIBLTTNG_UST_CTL
> +noinst_PROGRAMS = gen-ust-events
> +gen_ust_events_SOURCES = gen-ust-events.c tp.c tp.h
> +gen_ust_events_LDADD = -llttng-ust
> +endif
> diff --git a/tests/utils/testapp/gen-ust-events/gen-ust-events.c b/tests/utils/testapp/gen-ust-events/gen-ust-events.c
> new file mode 100644
> index 0000000..edf40ee
> --- /dev/null
> +++ b/tests/utils/testapp/gen-ust-events/gen-ust-events.c
> @@ -0,0 +1,58 @@
> +/*
> + * Copyright (C) - 2012 David Goulet <dgoulet@efficios.com>
> + *
> + * This library is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU Lesser General Public License as published by the
> + * Free Software Foundation; version 2.1 of the License.
> + *
> + * This library is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
> + * for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public License
> + * along with this library; if not, write to the Free Software Foundation,
> + * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> + */
> +
> +#include <arpa/inet.h>
> +#include <stdarg.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define TRACEPOINT_DEFINE
> +#include "tp.h"
> +
> +int main(int argc, char **argv)
> +{
> +	int i, netint;
> +	long values[] = { 1, 2, 3 };
> +	char text[10] = "test";
> +	double dbl = 2.0;
> +	float flt = 2222.0;
> +	unsigned int nr_iter = 100;
> +	useconds_t nr_usec = 0;
> +
> +	if (argc >= 2) {
> +		nr_iter = atoi(argv[1]);
> +	}
> +
> +	if (argc == 3) {
> +		/* By default, don't wait unless user specifies. */
> +		nr_usec = atoi(argv[2]);
> +	}
> +
> +	for (i = 0; i < nr_iter; i++) {
> +		netint = htonl(i);
> +		tracepoint(tp, tptest, i, netint, values, text, strlen(text),
> +			   dbl, flt);
> +		usleep(nr_usec);
> +	}
> +
> +	return 0;
> +}
> diff --git a/tests/utils/testapp/gen-ust-events/tp.c b/tests/utils/testapp/gen-ust-events/tp.c
> new file mode 100644
> index 0000000..a09561d
> --- /dev/null
> +++ b/tests/utils/testapp/gen-ust-events/tp.c
> @@ -0,0 +1,15 @@
> +/*
> + * Copyright (c) - 2012 David Goulet <dgoulet@efficios.com>
> + *
> + * THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED OR
> + * IMPLIED. ANY USE IS AT YOUR OWN RISK.
> + *
> + * Permission is hereby granted to use or copy this program for any purpose,
> + * provided the above notices are retained on all copies.  Permission to modify
> + * the code and to distribute modified code is granted, provided the above
> + * notices are retained, and a notice that the code was modified is included
> + * with the above copyright notice.
> + */
> +
> +#define TRACEPOINT_CREATE_PROBES
> +#include "tp.h"
> diff --git a/tests/utils/testapp/gen-ust-events/tp.h b/tests/utils/testapp/gen-ust-events/tp.h
> new file mode 100644
> index 0000000..6ffbc32
> --- /dev/null
> +++ b/tests/utils/testapp/gen-ust-events/tp.h
> @@ -0,0 +1,56 @@
> +#undef TRACEPOINT_PROVIDER
> +#define TRACEPOINT_PROVIDER tp
> +
> +#if !defined(_TRACEPOINT_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
> +#define _TRACEPOINT_TP_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * Copyright (C) 2011  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + *
> + * THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
> + * OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
> + *
> + * Permission is hereby granted to use or copy this program
> + * for any purpose,  provided the above notices are retained on all copies.
> + * Permission to modify the code and to distribute modified code is granted,
> + * provided the above notices are retained, and a notice that the code was
> + * modified is included with the above copyright notice.
> + */
> +
> +#include <lttng/tracepoint.h>
> +
> +TRACEPOINT_EVENT(tp, tptest,
> +	TP_ARGS(int, anint, int, netint, long *, values,
> +		char *, text, size_t, textlen,
> +		double, doublearg, float, floatarg),
> +	TP_FIELDS(
> +		ctf_integer(int, intfield, anint)
> +		ctf_integer_hex(int, intfield2, anint)
> +		ctf_integer(long, longfield, anint)
> +		ctf_integer_network(int, netintfield, netint)
> +		ctf_integer_network_hex(int, netintfieldhex, netint)
> +		ctf_array(long, arrfield1, values, 3)
> +		ctf_array_text(char, arrfield2, text, 10)
> +		ctf_sequence(char, seqfield1, text, size_t, textlen)
> +		ctf_sequence_text(char, seqfield2, text, size_t, textlen)
> +		ctf_string(stringfield, text)
> +		ctf_float(float, floatfield, floatarg)
> +		ctf_float(double, doublefield, doublearg)
> +	)
> +)
> +
> +#endif /* _TRACEPOINT_TP_H */
> +
> +#undef TRACEPOINT_INCLUDE_FILE
> +#define TRACEPOINT_INCLUDE_FILE ./tp.h
> +
> +/* This part must be outside ifdef protection */
> +#include <lttng/tracepoint-event.h>
> +
> +#ifdef __cplusplus
> +}
> +#endif
