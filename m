From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] Base-address tracing for dlopen and
	dlclose
Date: Thu, 14 Nov 2013 16:20:48 +0000 (UTC)
Message-ID: <1583845794.67317.1384446048785.JavaMail.zimbra__2386.62250708348$1384446112$gmane$org@efficios.com>
References: <1384362841-16111-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1Vgzf0-0003vG-Qe
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 11:20:57 -0500
In-Reply-To: <1384362841-16111-1-git-send-email-paul_woegerer@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <paul_woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Paul Woegerer" <paul_woegerer@mentor.com>
> To: lttng-dev@lists.lttng.org, "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Wednesday, November 13, 2013 12:14:01 PM
> Subject: [PATCH v2] Base-address tracing for dlopen and dlclose
> 
> Provide an LD_PRELOAD library to allow tracing of calls to dlopen and
> dlclose.
> 
> Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
> ---
>  Makefile.am                          |   2 +
>  configure.ac                         |   2 +
>  liblttng-ust-baddr/Makefile.am       |  18 +++++
>  liblttng-ust-baddr/lttng-ust-baddr.c |  64 +++++++++++++++
>  liblttng-ust-baddr/ust_baddr.c       |  20 +++++
>  liblttng-ust-baddr/ust_baddr.h       |  66 ++++++++++++++++
>  liblttng-ust-dl/Makefile.am          |  17 ++++
>  liblttng-ust-dl/ustdl.c              | 146
>  +++++++++++++++++++++++++++++++++++
>  8 files changed, 335 insertions(+)
>  create mode 100644 liblttng-ust-baddr/Makefile.am
>  create mode 100644 liblttng-ust-baddr/lttng-ust-baddr.c
>  create mode 100644 liblttng-ust-baddr/ust_baddr.c
>  create mode 100644 liblttng-ust-baddr/ust_baddr.h
>  create mode 100644 liblttng-ust-dl/Makefile.am
>  create mode 100644 liblttng-ust-dl/ustdl.c
> 
> diff --git a/Makefile.am b/Makefile.am
> index edb1a85..00dd576 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -4,6 +4,8 @@ SUBDIRS = . include snprintf libringbuffer liblttng-ust-comm
> \
>  		liblttng-ust \
>  		liblttng-ust-ctl \
>  		liblttng-ust-fork \
> +		liblttng-ust-baddr \
> +		liblttng-ust-dl \
>  		liblttng-ust-libc-wrapper \
>  		liblttng-ust-cyg-profile \
>  		tools \
> diff --git a/configure.ac b/configure.ac
> index c5802ee..37ea8c6 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -285,6 +285,8 @@ AC_CONFIG_FILES([
>  	liblttng-ust/Makefile
>  	liblttng-ust-ctl/Makefile
>  	liblttng-ust-fork/Makefile
> +	liblttng-ust-baddr/Makefile
> +	liblttng-ust-dl/Makefile
>  	liblttng-ust-java/Makefile
>  	liblttng-ust-jul/Makefile
>  	liblttng-ust-libc-wrapper/Makefile
> diff --git a/liblttng-ust-baddr/Makefile.am b/liblttng-ust-baddr/Makefile.am
> new file mode 100644
> index 0000000..afa9489
> --- /dev/null
> +++ b/liblttng-ust-baddr/Makefile.am
> @@ -0,0 +1,18 @@
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
> +AM_CFLAGS = -fno-strict-aliasing
> +
> +lib_LTLIBRARIES = liblttng-ust-baddr.la
> +liblttng_ust_baddr_la_SOURCES = \
> +	lttng-ust-baddr.c \
> +	ust_baddr.c \
> +	ust_baddr.h
> +liblttng_ust_baddr_la_LIBADD = \
> +	-L$(top_builddir)/liblttng-ust/.libs \
> +	-llttng-ust
> +
> +if LTTNG_UST_BUILD_WITH_LIBDL
> +liblttng_ust_baddr_la_LIBADD += -ldl
> +endif
> +if LTTNG_UST_BUILD_WITH_LIBC_DL
> +liblttng_ust_baddr_la_LIBADD += -lc
> +endif
> diff --git a/liblttng-ust-baddr/lttng-ust-baddr.c
> b/liblttng-ust-baddr/lttng-ust-baddr.c
> new file mode 100644
> index 0000000..21c22a2
> --- /dev/null
> +++ b/liblttng-ust-baddr/lttng-ust-baddr.c
> @@ -0,0 +1,64 @@
> +/*
> + * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
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
> +#define _GNU_SOURCE
> +#include <dlfcn.h>
> +#include <link.h>
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <limits.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <stdint.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include "usterr.h"
> +
> +#define TRACEPOINT_DEFINE
> +#include "ust_baddr.h"
> +
> +int
> +push_baddr(void *so_base, const char *so_name)

for these push and pop symbols, do we really need to expose them to the outside world ? If we to, then we need a lttng_ust_ prefix. Else, we could put a hidden visibility on them.

The rest of this patch looks good.

Thanks,

Mathieu

> +{
> +	char resolved_path[PATH_MAX];
> +	struct stat sostat;
> +
> +	if (!realpath(so_name, resolved_path)) {
> +		ERR("could not resolve path '%s'", so_name);
> +		return 0;
> +	}
> +
> +	if (stat(resolved_path, &sostat)) {
> +		ERR("could not access file status for %s", resolved_path);
> +		return 0;
> +	}
> +
> +	tracepoint(ust_baddr, push,
> +		so_base, resolved_path, sostat.st_size, sostat.st_mtime);
> +	return 0;
> +}
> +
> +int
> +pop_baddr(void *so_base)
> +{
> +	tracepoint(ust_baddr, pop, so_base);
> +	return 0;
> +}
> diff --git a/liblttng-ust-baddr/ust_baddr.c b/liblttng-ust-baddr/ust_baddr.c
> new file mode 100644
> index 0000000..bfbb7bf
> --- /dev/null
> +++ b/liblttng-ust-baddr/ust_baddr.c
> @@ -0,0 +1,20 @@
> +/*
> + * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
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
> +#define TRACEPOINT_CREATE_PROBES
> +#include "ust_baddr.h"
> diff --git a/liblttng-ust-baddr/ust_baddr.h b/liblttng-ust-baddr/ust_baddr.h
> new file mode 100644
> index 0000000..2c757f7
> --- /dev/null
> +++ b/liblttng-ust-baddr/ust_baddr.h
> @@ -0,0 +1,66 @@
> +#undef TRACEPOINT_PROVIDER
> +#define TRACEPOINT_PROVIDER ust_baddr
> +
> +#if !defined(_TRACEPOINT_UST_BADDR_H) ||
> defined(TRACEPOINT_HEADER_MULTI_READ)
> +#define _TRACEPOINT_UST_BADDR_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> copy
> + * of this software and associated documentation files (the "Software"), to
> deal
> + * in the Software without restriction, including without limitation the
> rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included
> in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> THE
> + * SOFTWARE.
> + */
> +
> +#include <stdint.h>
> +#include <unistd.h>
> +
> +#define LTTNG_UST_BADDR_PROVIDER
> +#include <lttng/tracepoint.h>
> +
> +TRACEPOINT_EVENT(ust_baddr, push,
> +	TP_ARGS(void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime),
> +	TP_FIELDS(
> +		ctf_integer_hex(void *, baddr, baddr)
> +		ctf_string(sopath, sopath)
> +		ctf_integer(int64_t, size, size)
> +		ctf_integer(int64_t, mtime, mtime)
> +	)
> +)
> +
> +TRACEPOINT_EVENT(ust_baddr, pop,
> +	TP_ARGS(void *, baddr),
> +	TP_FIELDS(
> +		ctf_integer_hex(void *, baddr, baddr)
> +	)
> +)
> +
> +#endif /* _TRACEPOINT_UST_BADDR_H */
> +
> +#undef TRACEPOINT_INCLUDE
> +#define TRACEPOINT_INCLUDE "./ust_baddr.h"
> +
> +/* This part must be outside ifdef protection */
> +#include <lttng/tracepoint-event.h>
> +
> +#ifdef __cplusplus
> +}
> +#endif
> diff --git a/liblttng-ust-dl/Makefile.am b/liblttng-ust-dl/Makefile.am
> new file mode 100644
> index 0000000..14d8abf
> --- /dev/null
> +++ b/liblttng-ust-dl/Makefile.am
> @@ -0,0 +1,17 @@
> +AM_CPPFLAGS = -I$(top_srcdir)/include
> +AM_CFLAGS = -fno-strict-aliasing
> +
> +lib_LTLIBRARIES = liblttng-ust-dl.la
> +liblttng_ust_dl_la_SOURCES = ustdl.c
> +liblttng_ust_dl_la_LIBADD = \
> +	$(top_builddir)/liblttng-ust/liblttng-ust.la
> +
> +if LTTNG_UST_BUILD_WITH_LIBDL
> +liblttng_ust_dl_la_LIBADD += -ldl
> +endif
> +if LTTNG_UST_BUILD_WITH_LIBC_DL
> +liblttng_ust_dl_la_LIBADD += -lc
> +endif
> +
> +libustdl_CFLAGS = -DUST_COMPONENT=liblttng-ust-dl -fno-strict-aliasing
> +
> diff --git a/liblttng-ust-dl/ustdl.c b/liblttng-ust-dl/ustdl.c
> new file mode 100644
> index 0000000..8f22b91
> --- /dev/null
> +++ b/liblttng-ust-dl/ustdl.c
> @@ -0,0 +1,146 @@
> +/*
> + * Copyright (C) 2013  Paul Woegerer <paul.woegerer@mentor.com>
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
> +#define _GNU_SOURCE
> +#include <inttypes.h>
> +#include <dlfcn.h>
> +#include <link.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <signal.h>
> +#include <sched.h>
> +#include <stdarg.h>
> +#include "usterr.h"
> +
> +#include <lttng/ust-compiler.h>
> +#include <lttng/ust.h>
> +
> +static void *(*__lttng_ust_plibc_dlopen)(const char *filename, int flag);
> +static int (*__lttng_ust_plibc_dlclose)(void *handle);
> +static void *__lttng_ust_baddr_handle;
> +
> +static
> +void *_lttng_ust_dl_libc_dlopen(const char *filename, int flag)
> +{
> +	if (!__lttng_ust_plibc_dlopen) {
> +		__lttng_ust_plibc_dlopen = dlsym(RTLD_NEXT, "dlopen");
> +		if (__lttng_ust_plibc_dlopen == NULL) {
> +			fprintf(stderr, "%s\n", dlerror());
> +			return NULL;
> +		}
> +	}
> +	return __lttng_ust_plibc_dlopen(filename, flag);
> +}
> +
> +static
> +int _lttng_ust_dl_libc_dlclose(void *handle)
> +{
> +	if (!__lttng_ust_plibc_dlclose) {
> +		__lttng_ust_plibc_dlclose = dlsym(RTLD_NEXT, "dlclose");
> +		if (__lttng_ust_plibc_dlclose == NULL) {
> +			fprintf(stderr, "%s\n", dlerror());
> +			return -1;
> +		}
> +	}
> +	return __lttng_ust_plibc_dlclose(handle);
> +}
> +
> +static
> +void *lttng_ust_baddr_handle(void)
> +{
> +	if (!__lttng_ust_baddr_handle) {
> +		__lttng_ust_baddr_handle = _lttng_ust_dl_libc_dlopen(
> +			"liblttng-ust-baddr.so.0", RTLD_NOW | RTLD_GLOBAL);
> +		if (__lttng_ust_baddr_handle == NULL)
> +			fprintf(stderr, "%s\n", dlerror());
> +	}
> +	return __lttng_ust_baddr_handle;
> +}
> +
> +static
> +int lttng_ust_baddr_push(void *so_base, const char *so_name)
> +{
> +	static int
> +	(*lttng_ust_baddr_push_fn)(void *so_base, const char *so_name);
> +	if (!lttng_ust_baddr_push_fn) {
> +		void *baddr_handle = lttng_ust_baddr_handle();
> +		if (baddr_handle) {
> +			lttng_ust_baddr_push_fn = dlsym(baddr_handle,
> +				"push_baddr");
> +			if (lttng_ust_baddr_push_fn == NULL)
> +				fprintf(stderr, "%s\n", dlerror());
> +		}
> +		if (!lttng_ust_baddr_push_fn)
> +			return -1;
> +	}
> +	return lttng_ust_baddr_push_fn(so_base, so_name);
> +}
> +
> +static
> +int lttng_ust_baddr_pop(void *so_base)
> +{
> +	static int
> +	(*lttng_ust_baddr_pop_fn)(void *so_base);
> +	if (!lttng_ust_baddr_pop_fn) {
> +		void *baddr_handle = lttng_ust_baddr_handle();
> +		if (baddr_handle) {
> +			lttng_ust_baddr_pop_fn = dlsym(baddr_handle,
> +				"pop_baddr");
> +			if (lttng_ust_baddr_pop_fn == NULL)
> +				fprintf(stderr, "%s\n", dlerror());
> +		}
> +		if (!lttng_ust_baddr_pop_fn)
> +			return -1;
> +	}
> +	return lttng_ust_baddr_pop_fn(so_base);
> +}
> +
> +void *dlopen(const char *filename, int flag)
> +{
> +	void *handle = _lttng_ust_dl_libc_dlopen(filename, flag);
> +	if (handle) {
> +		struct link_map *p = NULL;
> +		if (dlinfo(handle, RTLD_DI_LINKMAP, &p) != -1 && p != NULL
> +				&& p->l_addr != 0)
> +			lttng_ust_baddr_push((void *) p->l_addr, p->l_name);
> +	}
> +	return handle;
> +}
> +
> +int dlclose(void *handle)
> +{
> +	if (handle) {
> +		struct link_map *p = NULL;
> +		if (dlinfo(handle, RTLD_DI_LINKMAP, &p) != -1 && p != NULL
> +				&& p->l_addr != 0)
> +			lttng_ust_baddr_pop((void *) p->l_addr);
> +	}
> +	return _lttng_ust_dl_libc_dlclose(handle);
> +}
> +
> +static void __attribute__((destructor))
> +lttng_ust_baddr_handle_fini(void);
> +static void
> +lttng_ust_baddr_handle_fini(void)
> +{
> +	if (__lttng_ust_baddr_handle) {
> +		int ret = _lttng_ust_dl_libc_dlclose(__lttng_ust_baddr_handle);
> +		if (ret)
> +			fprintf(stderr, "%s\n", dlerror());
> +	}
> +}
> --
> 1.8.4.2
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
