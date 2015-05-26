From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Refactor state dump system
Date: Tue, 26 May 2015 18:31:46 +0000 (UTC)
Message-ID: <416768798.8310.1432665106408.JavaMail.zimbra__24784.2695600868$1432665216$gmane$org@efficios.com>
References: <1432595550-17799-1-git-send-email-abusque@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YxJdm-0006jo-Nz
 for lttng-dev@lists.lttng.org; Tue, 26 May 2015 14:32:01 -0400
In-Reply-To: <1432595550-17799-1-git-send-email-abusque@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Antoine Busque <abusque@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged, thanks!

Mathieu

----- Original Message -----
> This patch refactors the state dump system. The state dump provider is
> now "lttng_ust_statedump". Each process' state dump is now delimited
> by a pair of "start" and "end" events. These events mark the beginning
> and end of the state dump, which happens once per traced application
> per session. Note that for a given (process, session) pair, begin/end
> events are serialized and will match. However, in a session, state
> dumps from different processes may be interleaved. The vpid context
> should be used to identify which events belong to which process.
> 
> Signed-off-by: Antoine Busque <abusque@efficios.com>
> ---
>  liblttng-ust/Makefile.am                    |   6 +-
>  liblttng-ust/lttng-events.c                 |   4 +-
>  liblttng-ust/lttng-ust-baddr.c              | 212 -----------------------
>  liblttng-ust/lttng-ust-baddr.h              |  29 ----
>  liblttng-ust/lttng-ust-comm.c               |   6 +-
>  liblttng-ust/lttng-ust-statedump-provider.h |  77 ++++++++
>  liblttng-ust/lttng-ust-statedump.c          | 260
>  ++++++++++++++++++++++++++++
>  liblttng-ust/lttng-ust-statedump.h          |  29 ++++
>  liblttng-ust/ust_baddr_statedump.h          |  60 -------
>  9 files changed, 374 insertions(+), 309 deletions(-)
>  delete mode 100644 liblttng-ust/lttng-ust-baddr.c
>  delete mode 100644 liblttng-ust/lttng-ust-baddr.h
>  create mode 100644 liblttng-ust/lttng-ust-statedump-provider.h
>  create mode 100644 liblttng-ust/lttng-ust-statedump.c
>  create mode 100644 liblttng-ust/lttng-ust-statedump.h
>  delete mode 100644 liblttng-ust/ust_baddr_statedump.h
> 
> diff --git a/liblttng-ust/Makefile.am b/liblttng-ust/Makefile.am
> index 78eac97..a716a34 100644
> --- a/liblttng-ust/Makefile.am
> +++ b/liblttng-ust/Makefile.am
> @@ -35,9 +35,9 @@ liblttng_ust_runtime_la_SOURCES = \
>  	lttng-filter-interpreter.c \
>  	filter-bytecode.h \
>  	lttng-hash-helper.h \
> -	lttng-ust-baddr.c \
> -	lttng-ust-baddr.h \
> -	ust_baddr_statedump.h \
> +	lttng-ust-statedump.c \
> +	lttng-ust-statedump.h \
> +	lttng-ust-statedump-provider.h \
>  	tracepoint-internal.h \
>  	clock.h \
>  	compat.h \
> diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
> index 939dcd8..897b7f2 100644
> --- a/liblttng-ust/lttng-events.c
> +++ b/liblttng-ust/lttng-events.c
> @@ -54,7 +54,7 @@
>  #include "tracepoint-internal.h"
>  #include "lttng-tracer.h"
>  #include "lttng-tracer-core.h"
> -#include "lttng-ust-baddr.h"
> +#include "lttng-ust-statedump.h"
>  #include "wait.h"
>  #include "../libringbuffer/shm.h"
>  #include "jhash.h"
> @@ -683,7 +683,7 @@ void lttng_handle_pending_statedump(void *owner)
>  	struct lttng_session *session;
>  
>  	/* Execute state dump */
> -	lttng_ust_baddr_statedump(owner);
> +	do_lttng_ust_statedump(owner);
>  
>  	/* Clear pending state dump */
>  	if (ust_lock()) {
> diff --git a/liblttng-ust/lttng-ust-baddr.c b/liblttng-ust/lttng-ust-baddr.c
> deleted file mode 100644
> index 922899b..0000000
> --- a/liblttng-ust/lttng-ust-baddr.c
> +++ /dev/null
> @@ -1,212 +0,0 @@
> -/*
> - * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
> - *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2.1 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
> USA
> - */
> -
> -#define _LGPL_SOURCE
> -#define _GNU_SOURCE
> -#include <link.h>
> -
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
> -#include <limits.h>
> -#include <stdlib.h>
> -#include <errno.h>
> -#include <stdint.h>
> -#include <stddef.h>
> -#include <stdio.h>
> -
> -#include <usterr-signal-safe.h>
> -#include "lttng-tracer-core.h"
> -#include "lttng-ust-baddr.h"
> -
> -#define TRACEPOINT_DEFINE
> -#define TRACEPOINT_CREATE_PROBES
> -#define TP_SESSION_CHECK
> -#include "ust_baddr_statedump.h"
> -
> -struct extract_data {
> -	void *owner;
> -	void *exec_baddr;	/* executable base address */
> -};
> -
> -/*
> - * Trace baddr into all sessions for which statedump is pending owned by
> - * the caller thread.
> - */
> -static
> -int trace_baddr(void *base_addr_ptr,
> -	const char *resolved_path,
> -	int vdso,
> -	void *owner)
> -{
> -	struct cds_list_head *sessionsp;
> -	struct lttng_session *session;
> -	struct stat sostat;
> -
> -	if (vdso || stat(resolved_path, &sostat)) {
> -		sostat.st_size = 0;
> -		sostat.st_mtime = -1;
> -	}
> -	/*
> -	 * UST lock nests within dynamic loader lock.
> -	 */
> -	if (ust_lock()) {
> -		/*
> -		 * Stop iteration on headers if need to exit.
> -		 */
> -		ust_unlock();
> -		return 1;
> -	}
> -
> -	sessionsp = _lttng_get_sessions();
> -	cds_list_for_each_entry(session, sessionsp, node) {
> -		if (session->owner != owner)
> -			continue;
> -		if (!session->statedump_pending)
> -			continue;
> -		tracepoint(ust_baddr_statedump, soinfo,
> -				session, base_addr_ptr,
> -				resolved_path, sostat.st_size,
> -				sostat.st_mtime);
> -	}
> -	ust_unlock();
> -	return 0;
> -}
> -
> -static
> -int extract_soinfo_events(struct dl_phdr_info *info, size_t size, void
> *_data)
> -{
> -	int j;
> -	struct extract_data *data = _data;
> -	void *owner = data->owner;
> -
> -	for (j = 0; j < info->dlpi_phnum; j++) {
> -		char resolved_path[PATH_MAX];
> -		void *base_addr_ptr;
> -		int vdso = 0;
> -
> -		if (info->dlpi_phdr[j].p_type != PT_LOAD)
> -			continue;
> -
> -		/* Calculate virtual memory address of the loadable segment */
> -		base_addr_ptr = (void *) info->dlpi_addr
> -			+ info->dlpi_phdr[j].p_vaddr;
> -
> -		if ((info->dlpi_name == NULL || info->dlpi_name[0] == 0)
> -				&& !data->exec_baddr) {
> -			/*
> -			 * Only the first phdr encountered is considered
> -			 * as the program executable. The following
> -			 * could be e.g. vdso. Don't mistakenly dump
> -			 * them as being the program executable.
> -			 */
> -			data->exec_baddr = base_addr_ptr;
> -			/*
> -			 * Deal with program executable outside of phdr
> -			 * iteration.
> -			 */
> -			break;
> -		}
> -		if (info->dlpi_name == NULL || info->dlpi_name[0] == 0) {
> -			/* Found vDSO. */
> -			snprintf(resolved_path, PATH_MAX - 1, "[vdso]");
> -			vdso = 1;
> -		} else {
> -			/*
> -			 * For regular dl_phdr_info entries we have to check if
> -			 * the path to the shared object really exists.
> -			 */
> -			if (!realpath(info->dlpi_name, resolved_path)) {
> -				/* Path unknown, put the 'path' into brackets */
> -				snprintf(resolved_path, PATH_MAX - 1, "[%s]",
> -					info->dlpi_name);
> -				vdso = 1;
> -			}
> -		}
> -		if (trace_baddr(base_addr_ptr, resolved_path, vdso, owner)) {
> -			return 1;
> -		}
> -		/*
> -		 * We are only interested in the base address (lowest virtual
> -		 * address associated with the memory image), skip the rest
> -		 */
> -		break;
> -	}
> -	return 0;
> -}
> -
> -static
> -void dump_exec_baddr(struct extract_data *data)
> -{
> -	void *owner = data->owner;
> -	void *base_addr_ptr;
> -	char exe_path[PATH_MAX];
> -	ssize_t exe_len;
> -
> -	base_addr_ptr = data->exec_baddr;
> -	if (!base_addr_ptr)
> -		return;
> -	/*
> -	 * We have to use /proc/self/exe to determine the executable full
> -	 * path.
> -	 */
> -	exe_len = readlink("/proc/self/exe", exe_path, sizeof(exe_path) - 1);
> -	if (exe_len <= 0)
> -		return;
> -	exe_path[exe_len] = '\0';
> -	trace_baddr(base_addr_ptr, exe_path, 0, owner);
> -}
> -
> -int lttng_ust_baddr_statedump(void *owner)
> -{
> -	struct extract_data data;
> -
> -	if (getenv("LTTNG_UST_WITHOUT_BADDR_STATEDUMP"))
> -		return 0;
> -
> -	data.owner = owner;
> -	data.exec_baddr = NULL;
> -	/*
> -	 * Iterate through the list of currently loaded shared objects and
> -	 * generate events for loadable segments using
> -	 * extract_soinfo_events.
> -	 */
> -	dl_iterate_phdr(extract_soinfo_events, &data);
> -	/*
> -	 * We cannot call dladdr() from within phdr iteration, without
> -	 * causing constructor vs dynamic loader vs multithread internal
> -	 * deadlocks, so dump the executable outside of the phdr
> -	 * iteration.
> -	 */
> -	dump_exec_baddr(&data);
> -	return 0;
> -}
> -
> -void lttng_ust_baddr_statedump_init(void)
> -{
> -	__tracepoints__init();
> -	__tracepoints__ptrs_init();
> -	__lttng_events_init__ust_baddr_statedump();
> -}
> -
> -void lttng_ust_baddr_statedump_destroy(void)
> -{
> -	__lttng_events_exit__ust_baddr_statedump();
> -	__tracepoints__ptrs_destroy();
> -	__tracepoints__destroy();
> -}
> diff --git a/liblttng-ust/lttng-ust-baddr.h b/liblttng-ust/lttng-ust-baddr.h
> deleted file mode 100644
> index e7a0dfb..0000000
> --- a/liblttng-ust/lttng-ust-baddr.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -#ifndef LTTNG_UST_BADDR_H
> -#define LTTNG_UST_BADDR_H
> -
> -/*
> - * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
> - *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2.1 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
> USA
> - */
> -
> -#include <lttng/ust-events.h>
> -
> -void lttng_ust_baddr_statedump_init(void);
> -void lttng_ust_baddr_statedump_destroy(void);
> -
> -int lttng_ust_baddr_statedump(void *owner);
> -
> -#endif /* LTTNG_UST_BADDR_H */
> diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
> index 794cba9..b290204 100644
> --- a/liblttng-ust/lttng-ust-comm.c
> +++ b/liblttng-ust/lttng-ust-comm.c
> @@ -52,7 +52,7 @@
>  #include "lttng-tracer-core.h"
>  #include "compat.h"
>  #include "../libringbuffer/tlsfixup.h"
> -#include "lttng-ust-baddr.h"
> +#include "lttng-ust-statedump.h"
>  #include "clock.h"
>  #include "../libringbuffer/getcpu.h"
>  #include "getenv.h"
> @@ -1452,7 +1452,7 @@ void __attribute__((constructor)) lttng_ust_init(void)
>  	init_tracepoint();
>  	lttng_ust_clock_init();
>  	lttng_ust_getcpu_init();
> -	lttng_ust_baddr_statedump_init();
> +	lttng_ust_statedump_init();
>  	lttng_ring_buffer_metadata_client_init();
>  	lttng_ring_buffer_client_overwrite_init();
>  	lttng_ring_buffer_client_overwrite_rt_init();
> @@ -1573,7 +1573,7 @@ void lttng_ust_cleanup(int exiting)
>  	lttng_ring_buffer_client_overwrite_rt_exit();
>  	lttng_ring_buffer_client_overwrite_exit();
>  	lttng_ring_buffer_metadata_client_exit();
> -	lttng_ust_baddr_statedump_destroy();
> +	lttng_ust_statedump_destroy();
>  	exit_tracepoint();
>  	if (!exiting) {
>  		/* Reinitialize values for fork */
> diff --git a/liblttng-ust/lttng-ust-statedump-provider.h
> b/liblttng-ust/lttng-ust-statedump-provider.h
> new file mode 100644
> index 0000000..adfbf9b
> --- /dev/null
> +++ b/liblttng-ust/lttng-ust-statedump-provider.h
> @@ -0,0 +1,77 @@
> +#undef TRACEPOINT_PROVIDER
> +#define TRACEPOINT_PROVIDER lttng_ust_statedump
> +
> +#if !defined(_TRACEPOINT_LTTNG_UST_STATEDUMP_H) ||
> defined(TRACEPOINT_HEADER_MULTI_READ)
> +#define _TRACEPOINT_LTTNG_UST_STATEDUMP_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
> + * Copyright (C) 2015  Antoine Busque <abusque@efficios.com>
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
> +#include <lttng/ust-events.h>
> +
> +#define LTTNG_UST_STATEDUMP_PROVIDER
> +#include <lttng/tracepoint.h>
> +
> +TRACEPOINT_EVENT(lttng_ust_statedump, start,
> +	TP_ARGS(struct lttng_session *, session),
> +	TP_FIELDS()
> +)
> +
> +TRACEPOINT_EVENT(lttng_ust_statedump, soinfo,
> +	TP_ARGS(
> +		struct lttng_session *, session,
> +		void *, baddr,
> +		const char*, sopath,
> +		int64_t, size,
> +		int64_t, mtime
> +		),
> +	TP_FIELDS(
> +		ctf_integer_hex(void *, baddr, baddr)
> +		ctf_string(sopath, sopath)
> +		ctf_integer(int64_t, size, size)
> +		ctf_integer(int64_t, mtime, mtime)
> +	)
> +)
> +
> +TRACEPOINT_EVENT(lttng_ust_statedump, end,
> +	TP_ARGS(struct lttng_session *, session),
> +	TP_FIELDS()
> +)
> +
> +#endif /* _TRACEPOINT_LTTNG_UST_STATEDUMP_H */
> +
> +#undef TRACEPOINT_INCLUDE
> +#define TRACEPOINT_INCLUDE "./lttng-ust-statedump-provider.h"
> +
> +/* This part must be outside ifdef protection */
> +#include <lttng/tracepoint-event.h>
> +
> +#ifdef __cplusplus
> +}
> +#endif
> diff --git a/liblttng-ust/lttng-ust-statedump.c
> b/liblttng-ust/lttng-ust-statedump.c
> new file mode 100644
> index 0000000..4faee07
> --- /dev/null
> +++ b/liblttng-ust/lttng-ust-statedump.c
> @@ -0,0 +1,260 @@
> +/*
> + * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
> + * Copyright (C) 2015  Antoine Busque <abusque@efficios.com>
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
> +#define _LGPL_SOURCE
> +#define _GNU_SOURCE
> +#include <link.h>
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <limits.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <stdint.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +
> +#include <usterr-signal-safe.h>
> +#include "lttng-tracer-core.h"
> +#include "lttng-ust-statedump.h"
> +
> +#define TRACEPOINT_DEFINE
> +#define TRACEPOINT_CREATE_PROBES
> +#define TP_SESSION_CHECK
> +#include "lttng-ust-statedump-provider.h"
> +
> +struct dl_iterate_data {
> +	void *owner;
> +	int exec_found;
> +};
> +
> +struct soinfo_data {
> +	void *owner;
> +	void *base_addr_ptr;
> +	const char *resolved_path;
> +	int vdso;
> +	off_t size;
> +	time_t mtime;
> +};
> +
> +typedef void (*tracepoint_cb)(struct lttng_session *session, void *priv);
> +
> +/*
> + * Trace statedump event into all sessions owned by the caller thread
> + * for which statedump is pending.
> + */
> +static
> +int trace_statedump_event(tracepoint_cb tp_cb, void *owner, void *priv)
> +{
> +	struct cds_list_head *sessionsp;
> +	struct lttng_session *session;
> +
> +	/*
> +	 * UST lock nests within dynamic loader lock.
> +	 */
> +	if (ust_lock()) {
> +		ust_unlock();
> +		return 1;
> +	}
> +
> +	sessionsp = _lttng_get_sessions();
> +	cds_list_for_each_entry(session, sessionsp, node) {
> +		if (session->owner != owner)
> +			continue;
> +		if (!session->statedump_pending)
> +			continue;
> +		tp_cb(session, priv);
> +	}
> +	ust_unlock();
> +	return 0;
> +}
> +
> +static
> +void trace_soinfo_cb(struct lttng_session *session, void *priv)
> +{
> +	struct soinfo_data *so_data = (struct soinfo_data *) priv;
> +
> +	tracepoint(lttng_ust_statedump, soinfo,
> +		   session, so_data->base_addr_ptr,
> +		   so_data->resolved_path, so_data->size,
> +		   so_data->mtime);
> +}
> +
> +static
> +void trace_start_cb(struct lttng_session *session, void *priv)
> +{
> +	tracepoint(lttng_ust_statedump, start, session);
> +}
> +
> +static
> +void trace_end_cb(struct lttng_session *session, void *priv)
> +{
> +	tracepoint(lttng_ust_statedump, end, session);
> +}
> +
> +static
> +int trace_baddr(struct soinfo_data *so_data)
> +{
> +	struct stat sostat;
> +
> +	if (so_data->vdso || stat(so_data->resolved_path, &sostat)) {
> +		sostat.st_size = 0;
> +		sostat.st_mtime = -1;
> +	}
> +
> +	so_data->size = sostat.st_size;
> +	so_data->mtime = sostat.st_mtime;
> +
> +	return trace_statedump_event(trace_soinfo_cb, so_data->owner, so_data);
> +}
> +
> +static
> +int trace_statedump_start(void *owner)
> +{
> +	return trace_statedump_event(trace_start_cb, owner, NULL);
> +}
> +
> +static
> +int trace_statedump_end(void *owner)
> +{
> +	return trace_statedump_event(trace_end_cb, owner, NULL);
> +}
> +
> +static
> +int extract_soinfo_events(struct dl_phdr_info *info, size_t size, void
> *_data)
> +{
> +	int j;
> +	struct dl_iterate_data *data = _data;
> +
> +	for (j = 0; j < info->dlpi_phnum; j++) {
> +		struct soinfo_data so_data;
> +		char resolved_path[PATH_MAX];
> +		void *base_addr_ptr;
> +
> +		if (info->dlpi_phdr[j].p_type != PT_LOAD)
> +			continue;
> +
> +		/* Calculate virtual memory address of the loadable segment */
> +		base_addr_ptr = (void *) info->dlpi_addr +
> +			info->dlpi_phdr[j].p_vaddr;
> +
> +		if ((info->dlpi_name == NULL || info->dlpi_name[0] == 0)) {
> +			/*
> +			 * Only the first phdr without a dlpi_name
> +			 * encountered is considered as the program
> +			 * executable. The rest are vdsos.
> +			 */
> +			if (!data->exec_found) {
> +				ssize_t path_len;
> +				data->exec_found = 1;
> +
> +				/*
> +				 * Use /proc/self/exe to resolve the
> +				 * executable's full path.
> +				 */
> +				path_len = readlink("/proc/self/exe",
> +						    resolved_path,
> +						    PATH_MAX - 1);
> +				if (path_len <= 0)
> +					break;
> +
> +				resolved_path[path_len] = '\0';
> +				so_data.vdso = 0;
> +			} else {
> +				snprintf(resolved_path, PATH_MAX - 1, "[vdso]");
> +				so_data.vdso = 1;
> +			}
> +		} else {
> +			/*
> +			 * For regular dl_phdr_info entries check if
> +			 * the path to the SO really exists. If not,
> +			 * treat as vdso and use dlpi_name as 'path'.
> +			 */
> +			if (!realpath(info->dlpi_name, resolved_path)) {
> +				snprintf(resolved_path, PATH_MAX - 1, "[%s]",
> +					info->dlpi_name);
> +				so_data.vdso = 1;
> +			}
> +		}
> +
> +		so_data.owner = data->owner;
> +		so_data.base_addr_ptr = base_addr_ptr;
> +		so_data.resolved_path = resolved_path;
> +		return trace_baddr(&so_data);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Generate a statedump of base addresses of all shared objects loaded
> + * by the traced application, as well as for the application's
> + * executable itself.
> + */
> +static
> +int do_baddr_statedump(void *owner)
> +{
> +	struct dl_iterate_data data;
> +
> +	if (getenv("LTTNG_UST_WITHOUT_BADDR_STATEDUMP"))
> +		return 0;
> +
> +	data.owner = owner;
> +	data.exec_found = 0;
> +	/*
> +	 * Iterate through the list of currently loaded shared objects and
> +	 * generate events for loadable segments using
> +	 * extract_soinfo_events.
> +	 */
> +	dl_iterate_phdr(extract_soinfo_events, &data);
> +
> +	return 0;
> +}
> +
> +/*
> + * Generate a statedump of a given traced application. A statedump is
> + * delimited by start and end events. For a given (process, session)
> + * pair, begin/end events are serialized and will match. However, in a
> + * session, statedumps from different processes may be
> + * interleaved. The vpid context should be used to identify which
> + * events belong to which process.
> + */
> +int do_lttng_ust_statedump(void *owner)
> +{
> +	trace_statedump_start(owner);
> +	do_baddr_statedump(owner);
> +	trace_statedump_end(owner);
> +
> +	return 0;
> +}
> +
> +void lttng_ust_statedump_init(void)
> +{
> +	__tracepoints__init();
> +	__tracepoints__ptrs_init();
> +	__lttng_events_init__lttng_ust_statedump();
> +}
> +
> +void lttng_ust_statedump_destroy(void)
> +{
> +	__lttng_events_exit__lttng_ust_statedump();
> +	__tracepoints__ptrs_destroy();
> +	__tracepoints__destroy();
> +}
> diff --git a/liblttng-ust/lttng-ust-statedump.h
> b/liblttng-ust/lttng-ust-statedump.h
> new file mode 100644
> index 0000000..e78774d
> --- /dev/null
> +++ b/liblttng-ust/lttng-ust-statedump.h
> @@ -0,0 +1,29 @@
> +#ifndef LTTNG_UST_STATEDUMP_H
> +#define LTTNG_UST_STATEDUMP_H
> +
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
> +#include <lttng/ust-events.h>
> +
> +void lttng_ust_statedump_init(void);
> +void lttng_ust_statedump_destroy(void);
> +
> +int do_lttng_ust_statedump(void *owner);
> +
> +#endif /* LTTNG_UST_STATEDUMP_H */
> diff --git a/liblttng-ust/ust_baddr_statedump.h
> b/liblttng-ust/ust_baddr_statedump.h
> deleted file mode 100644
> index 77a9af4..0000000
> --- a/liblttng-ust/ust_baddr_statedump.h
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -#undef TRACEPOINT_PROVIDER
> -#define TRACEPOINT_PROVIDER ust_baddr_statedump
> -
> -#if !defined(_TRACEPOINT_UST_BADDR_STATEDUMP_H) ||
> defined(TRACEPOINT_HEADER_MULTI_READ)
> -#define _TRACEPOINT_UST_BADDR_STATEDUMP_H
> -
> -#ifdef __cplusplus
> -extern "C" {
> -#endif
> -
> -/*
> - * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> copy
> - * of this software and associated documentation files (the "Software"), to
> deal
> - * in the Software without restriction, including without limitation the
> rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included
> in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> THE
> - * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> THE
> - * SOFTWARE.
> - */
> -
> -#include <stdint.h>
> -#include <unistd.h>
> -#include <lttng/ust-events.h>
> -
> -#define LTTNG_UST_BADDR_STATEDUMP_PROVIDER
> -#include <lttng/tracepoint.h>
> -
> -TRACEPOINT_EVENT(ust_baddr_statedump, soinfo,
> -	TP_ARGS(struct lttng_session *, session, void *, baddr, const char*,
> sopath, int64_t, size, int64_t, mtime),
> -	TP_FIELDS(
> -		ctf_integer_hex(void *, baddr, baddr)
> -		ctf_string(sopath, sopath)
> -		ctf_integer(int64_t, size, size)
> -		ctf_integer(int64_t, mtime, mtime)
> -	)
> -)
> -
> -#endif /* _TRACEPOINT_UST_BADDR_STATEDUMP_H */
> -
> -#undef TRACEPOINT_INCLUDE
> -#define TRACEPOINT_INCLUDE "./ust_baddr_statedump.h"
> -
> -/* This part must be outside ifdef protection */
> -#include <lttng/tracepoint-event.h>
> -
> -#ifdef __cplusplus
> -}
> -#endif
> --
> 2.4.1
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
