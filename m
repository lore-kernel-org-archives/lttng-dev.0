From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 lttng-ust] Introduce vtracef
Date: Thu, 6 Feb 2020 10:06:44 -0500 (EST)
Message-ID: <256785620.613450.1581001604348.JavaMail.zimbra@efficios.com>
References: <20200205233640.21765-1-maxime.roussinbelanger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 48D1x76klvz10GT
 for <lttng-dev@lists.lttng.org>; Thu,  6 Feb 2020 10:06:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 21602243A7E
 for <lttng-dev@lists.lttng.org>; Thu,  6 Feb 2020 10:06:45 -0500 (EST)
In-Reply-To: <20200205233640.21765-1-maxime.roussinbelanger@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, champagne guillaume c <champagne.guillaume.c@gmail.com>
List-Id: lttng-dev@lists.lttng.org



----- On Feb 5, 2020, at 6:36 PM, Maxime Roussin-Belanger maxime.roussinbelanger@gmail.com wrote:

> vtracef accepts a va_list argument to simplify tracing
> functions which use a va_list
> 
> Here's an example from wpa_supplicant that I wanted to
> trace:
> 
> void wpa_debug(int level, const char* fmt, ...) {

Please follow the coding style of lttng-ust for this changelog
and within the entire patch:

functions:

void myfunc(void)
{

}

for loop:


for (expression) {

}

Thanks,

Mathieu

> 
>    va_list ap;
>    va_start(ap, fmt);
> 
>    ...
>    // The call I want to easily trace with vtracef
>    vprintf(fmt, ap);
> 
>    ...
>    va_end(ap);
> }
> 
> wpa_debug is used a fair amount and it would be annoying to
> replace all the wpa_debug calls with tracef.
> 
> With vtracef, it simplifies the find and replace effort by
> only changing it at one place.
> 
> Signed-off-by: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
> ---
> Changes in v2:
>	- Add man page
>	- Add an example
>	- Remove ifdef to guard against systemtap not having va_list
> 
> doc/examples/demo-tracef/Makefile       | 14 +++++-
> doc/examples/demo-tracef/demo-vtracef.c | 58 +++++++++++++++++++++++++
> doc/man/tracef-tracelog-limitations.txt |  3 ++
> doc/man/tracef.3.txt                    | 15 ++++---
> include/lttng/tracef.h                  |  8 ++++
> liblttng-ust/tracef.c                   | 18 +++++---
> 6 files changed, 101 insertions(+), 15 deletions(-)
> create mode 100644 doc/examples/demo-tracef/demo-vtracef.c
> 
> diff --git a/doc/examples/demo-tracef/Makefile
> b/doc/examples/demo-tracef/Makefile
> index ee207843..809aac19 100644
> --- a/doc/examples/demo-tracef/Makefile
> +++ b/doc/examples/demo-tracef/Makefile
> @@ -20,18 +20,28 @@ LIBS = -ldl -llttng-ust	# On Linux
> LOCAL_CPPFLAGS += -I.
> AM_V_P := :
> 
> -all: demo-tracef
> +all: demo-tracef demo-vtracef
> 
> demo-tracef.o: demo-tracef.c
> 	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
> 		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
> 		$(CFLAGS) -c -o $@ $<
> 
> demo-tracef: demo-tracef.o
> 	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
> 		$(CC) $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
> 		-o $@ $< $(LIBS)
> 
> +demo-vtracef.o: demo-vtracef.c
> +	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
> +		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
> +		$(CFLAGS) -c -o $@ $<
> +
> +demo-vtracef: demo-vtracef.o
> +	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
> +		$(CC) $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
> +		-o $@ $< $(LIBS)
> +
> .PHONY: clean
> clean:
> -	rm -f *.o *.a demo-tracef
> +	rm -f *.o *.a demo-tracef demo-vtracef
> diff --git a/doc/examples/demo-tracef/demo-vtracef.c
> b/doc/examples/demo-tracef/demo-vtracef.c
> new file mode 100644
> index 00000000..8eaccf61
> --- /dev/null
> +++ b/doc/examples/demo-tracef/demo-vtracef.c
> @@ -0,0 +1,58 @@
> +/*
> + * Copyright (C) 2020  Maxime Roussin-Belanger
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
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
> USA
> + */
> +
> +#include <stdarg.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +
> +#include <lttng/tracef.h>
> +
> +
> +void print_debug(const char* msg, ...) {
> +	va_list ap;
> +	va_start(ap, msg);
> +
> +	vtracef(msg, ap);
> +
> +	va_end(ap);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int i;
> +	int delay = 0;
> +	const char *str = "mystring test";
> +	long l = 0x42;
> +
> +	if (argc == 2)
> +		delay = atoi(argv[1]);
> +
> +	fprintf(stderr, "Demo program starting.\n");
> +
> +	sleep(delay);
> +
> +	fprintf(stderr, "Tracing... ");
> +
> +	for (i = 0; i < 5; i++)
> +	{
> +		print_debug("This is a \"%s\" formatted %d event %lx", str, i, l);
> +	}
> +	fprintf(stderr, " done.\n");
> +	return 0;
> +}
> diff --git a/doc/man/tracef-tracelog-limitations.txt
> b/doc/man/tracef-tracelog-limitations.txt
> index a9491903..ad4130dd 100644
> --- a/doc/man/tracef-tracelog-limitations.txt
> +++ b/doc/man/tracef-tracelog-limitations.txt
> @@ -21,4 +21,7 @@ Thus, +{macro-name}()+ is useful for quick prototyping and
> debugging, but
> should not be considered for any permanent/serious application
> instrumentation.
> 
> ++v{macro-name}()+ does not have a `STAP_PROBEV()` call, because `STAP_PROBEV()`
> +does not support `va_list`. If you need it, you should emit this call yourself.
> +
> See man:lttng-ust(3) to learn more about custom tracepoint providers.
> diff --git a/doc/man/tracef.3.txt b/doc/man/tracef.3.txt
> index 1068afad..b54a1623 100644
> --- a/doc/man/tracef.3.txt
> +++ b/doc/man/tracef.3.txt
> @@ -5,43 +5,44 @@ tracef(3)
> 
> NAME
> ----
> -tracef - LTTng-UST printf(3)-like interface
> +tracef, vtracef - LTTng-UST printf(3)-like interface
> 
> 
> SYNOPSIS
> --------
> [verse]
> *#include <lttng/tracef.h>*
> 
> [verse]
> #define *tracef*('fmt', ...)
> +#define *vtracef*('fmt', va_list ap)
> 
> Link with `-llttng-ust`.
> 
> 
> DESCRIPTION
> -----------
> The LTTng-UST `tracef()` API allows you to trace your application with
> the help of a simple man:printf(3)-like macro. The 'fmt' argument is
> passed directly to the 'fmt' parameter of man:vasprintf(3), as well as
> the optional parameters following 'fmt'.
> 
> -To use `tracef()`, include `<lttng/tracef.h>` where you need it, and
> -link your application with `liblttng-ust`. See the <<example,EXAMPLE>>
> +To use `tracef()` or `vtracef()`, include `<lttng/tracef.h>` where you need it,
> +and link your application with `liblttng-ust`. See the <<example,EXAMPLE>>
> section below for a complete usage example.
> 
> -Once your application is instrumented with `tracef()` calls and
> +Once your application is instrumented with `tracef()` or `vtracef()` calls and
> ready to run, use man:lttng-enable-event(1) to enable the
> `lttng_ust_tracef:*` event.
> 
> -The `tracef()` events contain a single field, named `msg`, which is the
> -formatted string output.
> +The `tracef()` events contain a single field, named `msg`,
> +which is the formatted string output.
> 
> If you need to attach a specific log level to a `tracef()` call, use
> man:tracelog(3) instead.
> 
> See also the <<limitations,LIMITATIONS>> section below for important
> -limitations to consider when using `tracef()`.
> +limitations to consider when using `tracef()` or `vtracef()`.
> 
> 
> [[example]]
> diff --git a/include/lttng/tracef.h b/include/lttng/tracef.h
> index 0c59c9ae..854ccdce 100644
> --- a/include/lttng/tracef.h
> +++ b/include/lttng/tracef.h
> @@ -32,13 +32,21 @@ extern "C" {
> extern
> void _lttng_ust_tracef(const char *fmt, ...);
> 
> +extern
> +void _lttng_ust_vtracef(const char *fmt, va_list ap);
> +
> #define tracef(fmt, ...)						\
> 	do {								\
> 		LTTNG_STAP_PROBEV(tracepoint_lttng_ust_tracef, event, ## __VA_ARGS__); \
> 		if (caa_unlikely(__tracepoint_lttng_ust_tracef___event.state)) \
> 			_lttng_ust_tracef(fmt, ## __VA_ARGS__);		\
> 	} while (0)
> 
> +#define vtracef(fmt, ap)						\
> +	do {								\
> +		if (caa_unlikely(__tracepoint_lttng_ust_tracef___event.state)) \
> +			_lttng_ust_vtracef(fmt, ap);		\
> +	} while (0)
> #ifdef __cplusplus
> }
> #endif
> diff --git a/liblttng-ust/tracef.c b/liblttng-ust/tracef.c
> index ea98e43e..1311f0d5 100644
> --- a/liblttng-ust/tracef.c
> +++ b/liblttng-ust/tracef.c
> @@ -29,20 +29,26 @@
> #define TRACEPOINT_DEFINE
> #include "lttng-ust-tracef-provider.h"
> 
> -void _lttng_ust_tracef(const char *fmt, ...)
> +void _lttng_ust_vtracef(const char *fmt, va_list ap)
> {
> -	va_list ap;
> 	char *msg;
> -	int len;
> -
> -	va_start(ap, fmt);
> -	len = vasprintf(&msg, fmt, ap);
> +	const int len = vasprintf(&msg, fmt, ap);
> 	/* len does not include the final \0 */
> 	if (len < 0)
> 		goto end;
> 	__tracepoint_cb_lttng_ust_tracef___event(msg, len,
> 		LTTNG_UST_CALLER_IP());
> 	free(msg);
> end:
> +	return;
> +}
> +
> +void _lttng_ust_tracef(const char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, fmt);
> +	_lttng_ust_vtracef(fmt, ap);
> +
> 	va_end(ap);
> }
> --
> 2.20.1
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
