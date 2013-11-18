From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: [PATCH v3 2/2] Implement base-address-state tracing
Date: Mon, 18 Nov 2013 09:59:41 +0200
Message-ID: <OF1F00F6D7.52820426-ONC2257C27.002B607D-C2257C27.002BEA45__2042.6131006845$1384761741$gmane$org@il.ibm.com>
References: <1384454389-456-1-git-send-email-paul_woegerer@mentor.com>
	<1581197758.67644.1384457210726.JavaMail.zimbra@efficios.com>
	<OF5EA7C09A.2F75FE97-ONC2257C26.00348FD3-C2257C26.0034C2F3@il.ibm.com>
	<424052805.69587.1384696944197.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0587807195=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1ViJlo-0007Zz-GW
	for lttng-dev@lists.lttng.org; Mon, 18 Nov 2013 03:01:24 -0500
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Mon, 18 Nov 2013 08:01:14 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
	(d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0C7812190061
	for <lttng-dev@lists.lttng.org>; Mon, 18 Nov 2013 08:01:11 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id rAI7xhKd17760366
	for <lttng-dev@lists.lttng.org>; Mon, 18 Nov 2013 07:59:43 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id rAI7xtL3021434
	for <lttng-dev@lists.lttng.org>; Mon, 18 Nov 2013 00:59:55 -0700
In-Reply-To: <424052805.69587.1384696944197.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0587807195==
Content-Type: multipart/alternative; boundary="=_alternative 002BE94FC2257C27_="

This is a multipart message in MIME format.
--=_alternative 002BE94FC2257C27_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

I understand, and I see two issue with this -

The application will still perform all the tracking, but when the event is 
to be generated, it will be checked and since it is disabled, will not be 
emitted.
While the overhead of checking whether the event is enabled is indeed 
minimal, the overhead of tracking existing state, is not negligible - it 
includes code, data and CPU cycles.
I believe that the average user will simply want to use "enable-event -u 
-a" or similar, and should not care about later disabling these specific 
events.

I believe this ought to be a compile-time option, and I don't mind if it 
defaults to "Enabled"...

What do you think?

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org, Paul Woegerer 
<paul_woegerer@mentor.com>
Date:   11/17/2013 04:02 PM
Subject:        Re: [lttng-dev] [PATCH v3 2/2] Implement 
base-address-state tracing




From: "Amit Margalit" <AMITM@il.ibm.com>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul Woegerer" <paul_woegerer@mentor.com>
Sent: Sunday, November 17, 2013 4:36:19 AM
Subject: Re: [lttng-dev] [PATCH v3 2/2] Implement base-address-state 
tracing

I guess I missed something in the discussion - is this going to be active 
all the time, or can I disable it somehow?

Maybe a command-line switch to turn this off?

For me this is overhead that I don't need and don't want.

You just have to not enable those new events if you don't care about them.

Thanks,

Mathieu


Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:        Paul Woegerer <paul_woegerer@mentor.com>
Cc:        lttng-dev@lists.lttng.org
Date:        11/14/2013 09:30 PM
Subject:        Re: [lttng-dev] [PATCH v3 2/2] Implement 
base-address-state tracing



----- Original Message -----
> From: "Paul Woegerer" <paul_woegerer@mentor.com>
> To: lttng-dev@lists.lttng.org, "mathieu desnoyers" 
<mathieu.desnoyers@efficios.com>
> Sent: Thursday, November 14, 2013 1:39:49 PM
> Subject: [PATCH v3 2/2] Implement base-address-state tracing
> 
> Dump the base-address state (executable and shared objects) into session
> on session-enable (per-session events).

Merged, thanks !

Mathieu

> 
> Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
> ---
>  include/lttng/ust-tracepoint-event.h     | 14 +++++++
>  liblttng-ust-baddr/Makefile.am           |  4 +-
>  liblttng-ust-baddr/lttng-ust-baddr.c     | 72
>  ++++++++++++++++++++++++++++++++
>  liblttng-ust-baddr/ust_baddr_statedump.c | 21 ++++++++++
>  liblttng-ust-baddr/ust_baddr_statedump.h | 60 
++++++++++++++++++++++++++
>  liblttng-ust/lttng-events.c              |  2 +
>  liblttng-ust/lttng-tracer-core.h         |  3 ++
>  liblttng-ust/lttng-ust-comm.c            | 60 
++++++++++++++++++++++++++
>  8 files changed, 235 insertions(+), 1 deletion(-)
>  create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.c
>  create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.h
> 
> diff --git a/include/lttng/ust-tracepoint-event.h
> b/include/lttng/ust-tracepoint-event.h
> index bb3a05d..be58030 100644
> --- a/include/lttng/ust-tracepoint-event.h
> +++ b/include/lttng/ust-tracepoint-event.h
> @@ -480,6 +480,18 @@ size_t
> __event_get_align__##_provider##___##_name(_TP_ARGS_PROTO(_args))      \
>  #define TP_FIELDS(...) __VA_ARGS__
> 
>  /*
> + * For state dump, check that "session" argument (mandatory) matches 
the
> + * session this event belongs to. Ensures that we write state dump data 
only
> + * into the started session, not into all sessions.
> + */
> +#undef _TP_SESSION_CHECK
> +#ifdef TP_SESSION_CHECK
> +#define _TP_SESSION_CHECK(session, csession)   (session == csession)
> +#else /* TP_SESSION_CHECK */
> +#define _TP_SESSION_CHECK(session, csession)   1
> +#endif /* TP_SESSION_CHECK */
> +
> +/*
>   * Using twice size for filter stack data to hold size and pointer for
>   * each field (worse case). For integers, max size required is 64-bit.
>   * Same for double-precision floats. Those fit within
> @@ -506,6 +518,8 @@ void
> __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args))     \
>                \
>                   if (0)                                               \
>                                    (void) __dynamic_len_idx;     /* 
don't warn if unused */    \
> +                 if (!_TP_SESSION_CHECK(session, __chan->session))      
                   \
> +                                  return;           \
>                   if 
(caa_unlikely(!CMM_ACCESS_ONCE(__chan->session->active)))      \
>                                    return;           \
>                   if (caa_unlikely(!CMM_ACCESS_ONCE(__chan->enabled)))   
                                  \
> diff --git a/liblttng-ust-baddr/Makefile.am 
b/liblttng-ust-baddr/Makefile.am
> index afa9489..0d3cf28 100644
> --- a/liblttng-ust-baddr/Makefile.am
> +++ b/liblttng-ust-baddr/Makefile.am
> @@ -5,7 +5,9 @@ lib_LTLIBRARIES = liblttng-ust-baddr.la
>  liblttng_ust_baddr_la_SOURCES = \
>                   lttng-ust-baddr.c \
>                   ust_baddr.c \
> -                 ust_baddr.h
> +                 ust_baddr.h \
> +                 ust_baddr_statedump.c \
> +                 ust_baddr_statedump.h
>  liblttng_ust_baddr_la_LIBADD = \
>                   -L$(top_builddir)/liblttng-ust/.libs \
>                   -llttng-ust
> diff --git a/liblttng-ust-baddr/lttng-ust-baddr.c
> b/liblttng-ust-baddr/lttng-ust-baddr.c
> index f24a171..a856965 100644
> --- a/liblttng-ust-baddr/lttng-ust-baddr.c
> +++ b/liblttng-ust-baddr/lttng-ust-baddr.c
> @@ -34,6 +34,7 @@
> 
>  #define TRACEPOINT_DEFINE
>  #include "ust_baddr.h"
> +#include "ust_baddr_statedump.h"
> 
>  int
>  lttng_ust_push_baddr(void *so_base, const char *so_name)
> @@ -62,3 +63,74 @@ lttng_ust_pop_baddr(void *so_base)
>                   tracepoint(ust_baddr, pop, so_base);
>                   return 0;
>  }
> +
> +static int
> +extract_soinfo_events(struct dl_phdr_info *info, size_t size, void 
*data)
> +{
> +                 int j;
> +                 int num_loadable_segment = 0;
> +
> +                 for (j = 0; j < info->dlpi_phnum; j++) {
> +                                  char resolved_path[PATH_MAX];
> +                                  struct stat sostat;
> +                                  void *base_addr_ptr;
> +
> +                                  if (info->dlpi_phdr[j].p_type != 
PT_LOAD)
> +                                                   continue;
> +
> +                                  /* Calculate virtual memory address 
of the loadable segment */
> +                                  base_addr_ptr = (void *) 
info->dlpi_addr
> +                                                   + 
info->dlpi_phdr[j].p_vaddr;
> +
> +                                  num_loadable_segment += 1;
> +                                  if ((info->dlpi_name == NULL || 
info->dlpi_name[0] == 0)
> +                                                                    && 
num_loadable_segment == 1) {
> +                                                   /*
> +                                                    * If the iterated 
element is the executable itself we
> +                                                    * have to use 
Dl_info to determine its full path
> +                                                    */
> +                                                   Dl_info dl_info = { 
0 };
> +                                                   if 
(!dladdr(base_addr_ptr, &dl_info))
> + return 0;
> +                                                   if 
(!realpath(dl_info.dli_fname, resolved_path))
> + return 0;
> +                                  } else {
> +                                                   /*
> +                                                    * For regular 
dl_phdr_info entries we have to check if
> +                                                    * the path to the 
shared object really exists
> +                                                    */
> +                                                   if 
(!realpath(info->dlpi_name, resolved_path)) {
> +                                                                    /* 
Found vDSO, put the 'path' into brackets */
> + snprintf(resolved_path, PATH_MAX - 1, "[%s]",
> +                               info->dlpi_name);
> +                                                   }
> +                                  }
> +
> +                                  if (stat(resolved_path, &sostat)) {
> +                                                   sostat.st_size = 0;
> +                                                   sostat.st_mtime = 
-1;
> +                                  }
> +
> +                                  tracepoint(ust_baddr_statedump, 
soinfo,
> + (struct lttng_session *) data, base_addr_ptr,
> + resolved_path, sostat.st_size, sostat.st_mtime);
> +
> +                                  /*
> +                                   * We are only interested in the base 
address (lowest virtual
> +                                   * address associated with the memory 
image), skip the rest
> +                                   */
> +                                  break;
> +                 }
> +                 return 0;
> +}
> +
> +int
> +lttng_ust_baddr_statedump(struct lttng_session *session)
> +{
> +                 /*
> +                  * Iterate through the list of currently loaded shared 
objects and
> +                  * generate events for loadable segments using 
extract_soinfo_events
> +                  */
> +                 dl_iterate_phdr(extract_soinfo_events, session);
> +                 return 0;
> +}
> diff --git a/liblttng-ust-baddr/ust_baddr_statedump.c
> b/liblttng-ust-baddr/ust_baddr_statedump.c
> new file mode 100644
> index 0000000..75f74ca
> --- /dev/null
> +++ b/liblttng-ust-baddr/ust_baddr_statedump.c
> @@ -0,0 +1,21 @@
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
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 
02110-1301
> USA
> + */
> +
> +#define TRACEPOINT_CREATE_PROBES
> +#define TP_SESSION_CHECK
> +#include "ust_baddr_statedump.h"
> diff --git a/liblttng-ust-baddr/ust_baddr_statedump.h
> b/liblttng-ust-baddr/ust_baddr_statedump.h
> new file mode 100644
> index 0000000..77a9af4
> --- /dev/null
> +++ b/liblttng-ust-baddr/ust_baddr_statedump.h
> @@ -0,0 +1,60 @@
> +#undef TRACEPOINT_PROVIDER
> +#define TRACEPOINT_PROVIDER ust_baddr_statedump
> +
> +#if !defined(_TRACEPOINT_UST_BADDR_STATEDUMP_H) ||
> defined(TRACEPOINT_HEADER_MULTI_READ)
> +#define _TRACEPOINT_UST_BADDR_STATEDUMP_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
> + *
> + * Permission is hereby granted, free of charge, to any person 
obtaining a
> copy
> + * of this software and associated documentation files (the 
"Software"), to
> deal
> + * in the Software without restriction, including without limitation 
the
> rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or 
sell
> + * copies of the Software, and to permit persons to whom the Software 
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be 
included
> in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
EXPRESS
> OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
SHALL
> THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR 
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
ARISING
> FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
DEALINGS IN
> THE
> + * SOFTWARE.
> + */
> +
> +#include <stdint.h>
> +#include <unistd.h>
> +#include <lttng/ust-events.h>
> +
> +#define LTTNG_UST_BADDR_STATEDUMP_PROVIDER
> +#include <lttng/tracepoint.h>
> +
> +TRACEPOINT_EVENT(ust_baddr_statedump, soinfo,
> +                 TP_ARGS(struct lttng_session *, session, void *, 
baddr, const char*,
> sopath, int64_t, size, int64_t, mtime),
> +                 TP_FIELDS(
> +                                  ctf_integer_hex(void *, baddr, baddr)
> +                                  ctf_string(sopath, sopath)
> +                                  ctf_integer(int64_t, size, size)
> +                                  ctf_integer(int64_t, mtime, mtime)
> +                 )
> +)
> +
> +#endif /* _TRACEPOINT_UST_BADDR_STATEDUMP_H */
> +
> +#undef TRACEPOINT_INCLUDE
> +#define TRACEPOINT_INCLUDE "./ust_baddr_statedump.h"
> +
> +/* This part must be outside ifdef protection */
> +#include <lttng/tracepoint-event.h>
> +
> +#ifdef __cplusplus
> +}
> +#endif
> diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
> index 26601a6..21e3639 100644
> --- a/liblttng-ust/lttng-events.c
> +++ b/liblttng-ust/lttng-events.c
> @@ -293,6 +293,8 @@ int lttng_session_enable(struct lttng_session 
*session)
>                   /* Set atomically the state to "active" */
>                   CMM_ACCESS_ONCE(session->active) = 1;
>                   CMM_ACCESS_ONCE(session->been_active) = 1;
> +
> +                 lttng_ust_sockinfo_session_enabled(session->owner, 
session);
>  end:
>                   return ret;
>  }
> diff --git a/liblttng-ust/lttng-tracer-core.h
> b/liblttng-ust/lttng-tracer-core.h
> index f643a7e..e7f549e 100644
> --- a/liblttng-ust/lttng-tracer-core.h
> +++ b/liblttng-ust/lttng-tracer-core.h
> @@ -45,4 +45,7 @@ const char *lttng_ust_obj_get_name(int id);
> 
>  int lttng_get_notify_socket(void *owner);
> 
> +void lttng_ust_sockinfo_session_enabled(void *owner,
> +                                  struct lttng_session 
*session_enabled);
> +
>  #endif /* _LTTNG_TRACER_CORE_H */
> diff --git a/liblttng-ust/lttng-ust-comm.c 
b/liblttng-ust/lttng-ust-comm.c
> index a6e4ba3..6ef3006 100644
> --- a/liblttng-ust/lttng-ust-comm.c
> +++ b/liblttng-ust/lttng-ust-comm.c
> @@ -34,6 +34,7 @@
>  #include <time.h>
>  #include <assert.h>
>  #include <signal.h>
> +#include <dlfcn.h>
>  #include <urcu/uatomic.h>
>  #include <urcu/futex.h>
>  #include <urcu/compiler.h>
> @@ -106,6 +107,7 @@ struct sock_info {
> 
>                   char wait_shm_path[PATH_MAX];
>                   char *wait_shm_mmap;
> +                 struct lttng_session *session_enabled;
>  };
> 
>  /* Socket from app (connect) to session daemon (listen) for 
communication */
> @@ -122,6 +124,8 @@ struct sock_info global_apps = {
>                   .notify_socket = -1,
> 
>                   .wait_shm_path = "/" LTTNG_UST_WAIT_FILENAME,
> +
> +                 .session_enabled = NULL,
>  };
> 
>  /* TODO: allow global_apps_sock_path override */
> @@ -135,6 +139,8 @@ struct sock_info local_apps = {
> 
>                   .socket = -1,
>                   .notify_socket = -1,
> +
> +                 .session_enabled = NULL,
>  };
> 
>  static int wait_poll_fallback;
> @@ -176,6 +182,7 @@ static const char *cmd_name_mapping[] = {
> 
>  static const char *str_timeout;
>  static int got_timeout_env;
> +static void *ust_baddr_handle;
> 
>  extern void lttng_ring_buffer_client_overwrite_init(void);
>  extern void lttng_ring_buffer_client_overwrite_rt_init(void);
> @@ -235,6 +242,39 @@ void print_cmd(int cmd, int handle)
>  }
> 
>  static
> +void *lttng_ust_baddr_handle(void)
> +{
> +                 if (!ust_baddr_handle) {
> +                                  ust_baddr_handle = dlopen(
> + "liblttng-ust-baddr.so.0", RTLD_NOW | RTLD_GLOBAL);
> +                                  if (ust_baddr_handle == NULL)
> +                                                   ERR("%s", 
dlerror());
> +                 }
> +                 return ust_baddr_handle;
> +}
> +
> +static
> +int lttng_ust_baddr_statedump(struct lttng_session *session)
> +{
> +                 static
> +                 int (*lttng_ust_baddr_init_fn)(struct lttng_session 
*);
> +
> +                 if (!lttng_ust_baddr_init_fn) {
> +                                  void *baddr_handle = 
lttng_ust_baddr_handle();
> +                                  if (baddr_handle) {
> + lttng_ust_baddr_init_fn = dlsym(baddr_handle,
> + "lttng_ust_baddr_statedump");
> +                                                   if 
(lttng_ust_baddr_init_fn == NULL)
> + ERR("%s", dlerror());
> +                                  }
> +                                  if (!lttng_ust_baddr_init_fn)
> +                                                   return -1;
> +                 }
> +
> +                 return lttng_ust_baddr_init_fn(session);
> +}
> +
> +static
>  int setup_local_apps(void)
>  {
>                   const char *home_dir;
> @@ -1143,6 +1183,13 @@ restart:
>                                                     ret = 
handle_message(sock_info, sock, &lum);
>                                                     if (ret) {
> ERR("Error handling message for %s socket", sock_info->name);
> +                                                   } else {
> + struct lttng_session *session =
> +              sock_info->session_enabled;
> +                                                                    if 
(session) {
> +              sock_info->session_enabled = NULL;
> +              lttng_ust_baddr_statedump(session);
> +                                                                    }
>                                                     }
>                                                     continue;
>                                    default:
> @@ -1379,6 +1426,12 @@ void __attribute__((destructor)) 
lttng_ust_exit(void)
>                    * cleanup the threads if there are stalled in a 
syscall.
>                    */
>                   lttng_ust_cleanup(1);
> +
> +                 if (ust_baddr_handle) {
> +                                  int ret = dlclose(ust_baddr_handle);
> +                                  if (ret)
> +                                                   ERR("%s", 
dlerror());
> +                 }
>  }
> 
>  /*
> @@ -1456,3 +1509,10 @@ void ust_after_fork_child(sigset_t 
*restore_sigset)
>                   ust_after_fork_common(restore_sigset);
>                   lttng_ust_init();
>  }
> +
> +void lttng_ust_sockinfo_session_enabled(void *owner,
> +                                  struct lttng_session 
*session_enabled)
> +{
> +                 struct sock_info *sock_info = owner;
> +                 sock_info->session_enabled = session_enabled;
> +}
> --
> 1.8.4.2
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev





-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

--=_alternative 002BE94FC2257C27_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I understand, and I see two issue with
this -</font>
<br>
<ol>
<li value=1><font size=2 face="sans-serif">The application will still perform
all the tracking, but when the event is to be generated, it will be checked
and since it is disabled, will not be emitted.<br>
While the overhead of checking whether the event is enabled is indeed minimal,
the overhead of tracking existing state, is not negligible - it includes
code, data and CPU cycles.</font>
<li value=2><font size=2 face="sans-serif">I believe that the average user
will simply want to use &quot;enable-event -u -a&quot; or similar, and
should not care about later disabling these specific events.</font></ol>
<br><font size=2 face="sans-serif">I believe this ought to be a compile-time
option, and I don't mind if it defaults to &quot;Enabled&quot;...</font>
<br>
<br><font size=2 face="sans-serif">What do you think?</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
<br>
<br>
<br>
<br><font size=1 color=#5f5f5f face="sans-serif">From: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org,
Paul Woegerer &lt;paul_woegerer@mentor.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">11/17/2013 04:02 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
[PATCH v3 2/2] Implement base-address-state tracing</font>
<br>
<hr noshade>
<br>
<br>
<br>
<hr>
<br><font size=3 face="Arial"><b>From: </b>&quot;Amit Margalit&quot; &lt;AMITM@il.ibm.com&gt;<b><br>
To: </b>&quot;Mathieu Desnoyers&quot; &lt;mathieu.desnoyers@efficios.com&gt;<b><br>
Cc: </b>lttng-dev@lists.lttng.org, &quot;Paul Woegerer&quot; &lt;paul_woegerer@mentor.com&gt;<b><br>
Sent: </b>Sunday, November 17, 2013 4:36:19 AM<b><br>
Subject: </b>Re: [lttng-dev] [PATCH v3 2/2] Implement base-address-state
tracing</font>
<br>
<br><font size=2 face="Arial">I guess I missed something in the discussion
- is this going to be active all the time, or can I disable it somehow?</font><font size=3 face="Arial"><br>
</font><font size=2 face="Arial"><br>
Maybe a command-line switch to turn this off?</font><font size=3 face="Arial"><br>
</font><font size=2 face="Arial"><br>
For me this is overhead that I don't need and don't want.</font>
<br>
<br><font size=3>You just have to not enable those new events if you don't
care about them.</font>
<br>
<br><font size=3>Thanks,</font>
<br>
<br><font size=3>Mathieu</font>
<br>
<br><font size=2 face="Arial"><br>
Thanks,</font><font size=3 face="Arial"><br>
</font><font size=2 color=#000080 face="Arial"><br>
Amit Margalit</font><font size=2 color=#808000 face="Arial"><br>
IBM XIV </font><font size=2 face="Arial">- <i>Storage Reinvented</i><br>
XIV-NAS Development Team<br>
Tel. 03-689-7774<br>
Fax. 03-689-7230</font><font size=3 face="Arial"><br>
<br>
<br>
</font><font size=1 color=#5f5f5f face="Arial"><br>
From: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=1 face="Arial">Mathieu
Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</font><font size=1 color=#5f5f5f face="Arial"><br>
To: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=1 face="Arial">Paul Woegerer
&lt;paul_woegerer@mentor.com&gt;</font><font size=1 color=#5f5f5f face="Arial"><br>
Cc: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=1 face="Arial">lttng-dev@lists.lttng.org</font><font size=1 color=#5f5f5f face="Arial"><br>
Date: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=1 face="Arial">11/14/2013
09:30 PM</font><font size=1 color=#5f5f5f face="Arial"><br>
Subject: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=1 face="Arial">Re:
[lttng-dev] [PATCH v3 2/2] Implement base-address-state tracing</font><font size=3 face="Arial"><br>
</font>
<hr noshade><font size=3 face="Arial"><br>
<br>
</font><font size=2 face="Arial"><br>
----- Original Message -----<br>
&gt; From: &quot;Paul Woegerer&quot; &lt;paul_woegerer@mentor.com&gt;<br>
&gt; To: lttng-dev@lists.lttng.org, &quot;mathieu desnoyers&quot; &lt;mathieu.desnoyers@efficios.com&gt;<br>
&gt; Sent: Thursday, November 14, 2013 1:39:49 PM<br>
&gt; Subject: [PATCH v3 2/2] Implement base-address-state tracing<br>
&gt; <br>
&gt; Dump the base-address state (executable and shared objects) into session<br>
&gt; on session-enable (per-session events).<br>
<br>
Merged, thanks !<br>
<br>
Mathieu<br>
<br>
&gt; <br>
&gt; Signed-off-by: Paul Woegerer &lt;paul_woegerer@mentor.com&gt;<br>
&gt; ---<br>
&gt; &nbsp;include/lttng/ust-tracepoint-event.h &nbsp; &nbsp; | 14 +++++++<br>
&gt; &nbsp;liblttng-ust-baddr/Makefile.am &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
| &nbsp;4 +-<br>
&gt; &nbsp;liblttng-ust-baddr/lttng-ust-baddr.c &nbsp; &nbsp; | 72<br>
&gt; &nbsp;++++++++++++++++++++++++++++++++<br>
&gt; &nbsp;liblttng-ust-baddr/ust_baddr_statedump.c | 21 ++++++++++<br>
&gt; &nbsp;liblttng-ust-baddr/ust_baddr_statedump.h | 60 ++++++++++++++++++++++++++<br>
&gt; &nbsp;liblttng-ust/lttng-events.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;| &nbsp;2 +<br>
&gt; &nbsp;liblttng-ust/lttng-tracer-core.h &nbsp; &nbsp; &nbsp; &nbsp;
| &nbsp;3 ++<br>
&gt; &nbsp;liblttng-ust/lttng-ust-comm.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;| 60 ++++++++++++++++++++++++++<br>
&gt; &nbsp;8 files changed, 235 insertions(+), 1 deletion(-)<br>
&gt; &nbsp;create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.c<br>
&gt; &nbsp;create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.h<br>
&gt; <br>
&gt; diff --git a/include/lttng/ust-tracepoint-event.h<br>
&gt; b/include/lttng/ust-tracepoint-event.h<br>
&gt; index bb3a05d..be58030 100644<br>
&gt; --- a/include/lttng/ust-tracepoint-event.h<br>
&gt; +++ b/include/lttng/ust-tracepoint-event.h<br>
&gt; @@ -480,6 +480,18 @@ size_t<br>
&gt; __event_get_align__##_provider##___##_name(_TP_ARGS_PROTO(_args))
&nbsp; &nbsp; &nbsp;\<br>
&gt; &nbsp;#define TP_FIELDS(...) __VA_ARGS__<br>
&gt; &nbsp;<br>
&gt; &nbsp;/*<br>
&gt; + * For state dump, check that &quot;session&quot; argument (mandatory)
matches the<br>
&gt; + * session this event belongs to. Ensures that we write state dump
data only<br>
&gt; + * into the started session, not into all sessions.<br>
&gt; + */<br>
&gt; +#undef _TP_SESSION_CHECK<br>
&gt; +#ifdef TP_SESSION_CHECK<br>
&gt; +#define _TP_SESSION_CHECK(session, csession) &nbsp; (session == csession)<br>
&gt; +#else /* TP_SESSION_CHECK */<br>
&gt; +#define _TP_SESSION_CHECK(session, csession) &nbsp; 1<br>
&gt; +#endif /* TP_SESSION_CHECK */<br>
&gt; +<br>
&gt; +/*<br>
&gt; &nbsp; * Using twice size for filter stack data to hold size and pointer
for<br>
&gt; &nbsp; * each field (worse case). For integers, max size required
is 64-bit.<br>
&gt; &nbsp; * Same for double-precision floats. Those fit within<br>
&gt; @@ -506,6 +518,8 @@ void<br>
&gt; __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args))
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
\<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if
(0) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(void) __dynamic_len_idx;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* don't warn if
unused */ &nbsp; &nbsp;\<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!_TP_SESSION_CHECK(session,
__chan-&gt;session)) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;\<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if
(caa_unlikely(!CMM_ACCESS_ONCE(__chan-&gt;session-&gt;active))) &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if
(caa_unlikely(!CMM_ACCESS_ONCE(__chan-&gt;enabled))) &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\<br>
&gt; diff --git a/liblttng-ust-baddr/Makefile.am b/liblttng-ust-baddr/Makefile.am<br>
&gt; index afa9489..0d3cf28 100644<br>
&gt; --- a/liblttng-ust-baddr/Makefile.am<br>
&gt; +++ b/liblttng-ust-baddr/Makefile.am<br>
&gt; @@ -5,7 +5,9 @@ lib_LTLIBRARIES = liblttng-ust-baddr.la<br>
&gt; &nbsp;liblttng_ust_baddr_la_SOURCES = \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng-ust-baddr.c
\<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ust_baddr.c
\<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ust_baddr.h<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ust_baddr.h
\<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ust_baddr_statedump.c
\<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ust_baddr_statedump.h<br>
&gt; &nbsp;liblttng_ust_baddr_la_LIBADD = \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -L$(top_builddir)/liblttng-ust/.libs
\<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -llttng-ust<br>
&gt; diff --git a/liblttng-ust-baddr/lttng-ust-baddr.c<br>
&gt; b/liblttng-ust-baddr/lttng-ust-baddr.c<br>
&gt; index f24a171..a856965 100644<br>
&gt; --- a/liblttng-ust-baddr/lttng-ust-baddr.c<br>
&gt; +++ b/liblttng-ust-baddr/lttng-ust-baddr.c<br>
&gt; @@ -34,6 +34,7 @@<br>
&gt; &nbsp;<br>
&gt; &nbsp;#define TRACEPOINT_DEFINE<br>
&gt; &nbsp;#include &quot;ust_baddr.h&quot;<br>
&gt; +#include &quot;ust_baddr_statedump.h&quot;<br>
&gt; &nbsp;<br>
&gt; &nbsp;int<br>
&gt; &nbsp;lttng_ust_push_baddr(void *so_base, const char *so_name)<br>
&gt; @@ -62,3 +63,74 @@ lttng_ust_pop_baddr(void *so_base)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tracepoint(ust_baddr,
pop, so_base);<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return
0;<br>
&gt; &nbsp;}<br>
&gt; +<br>
&gt; +static int<br>
&gt; +extract_soinfo_events(struct dl_phdr_info *info, size_t size, void
*data)<br>
&gt; +{<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int j;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int num_loadable_segment
= 0;<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for (j =
0; j &lt; info-&gt;dlpi_phnum; j++) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;char resolved_path[PATH_MAX];<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct stat sostat;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;void *base_addr_ptr;<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (info-&gt;dlpi_phdr[j].p_type
!= PT_LOAD)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Calculate virtual memory
address of the loadable segment */<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;base_addr_ptr = (void *)
info-&gt;dlpi_addr<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; + info-&gt;dlpi_phdr[j].p_vaddr;<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;num_loadable_segment +=
1;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if ((info-&gt;dlpi_name
== NULL || info-&gt;dlpi_name[0] == 0)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;&amp;&amp; num_loadable_segment == 1) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; /*<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* If the iterated element is the executable
itself we<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* have to use Dl_info to determine its
full path<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; Dl_info dl_info = { 0 };<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; if (!dladdr(base_addr_ptr, &amp;dl_info))<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;return 0;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; if (!realpath(dl_info.dli_fname, resolved_path))<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;return 0;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; /*<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* For regular dl_phdr_info entries we
have to check if<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* the path to the shared object really
exists<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; if (!realpath(info-&gt;dlpi_name, resolved_path))
{<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;/* Found vDSO, put the 'path' into brackets */<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;snprintf(resolved_path, PATH_MAX - 1, &quot;[%s]&quot;,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;info-&gt;dlpi_name);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (stat(resolved_path,
&amp;sostat)) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; sostat.st_size = 0;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; sostat.st_mtime = -1;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tracepoint(ust_baddr_statedump,
soinfo,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;(struct lttng_session *) data, base_addr_ptr,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;resolved_path, sostat.st_size, sostat.st_mtime);<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * We are only interested
in the base address (lowest virtual<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * address associated with
the memory image), skip the rest<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int<br>
&gt; +lttng_ust_baddr_statedump(struct lttng_session *session)<br>
&gt; +{<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*
Iterate through the list of currently loaded shared objects and<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*
generate events for loadable segments using extract_soinfo_events<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dl_iterate_phdr(extract_soinfo_events,
session);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return 0;<br>
&gt; +}<br>
&gt; diff --git a/liblttng-ust-baddr/ust_baddr_statedump.c<br>
&gt; b/liblttng-ust-baddr/ust_baddr_statedump.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..75f74ca<br>
&gt; --- /dev/null<br>
&gt; +++ b/liblttng-ust-baddr/ust_baddr_statedump.c<br>
&gt; @@ -0,0 +1,21 @@<br>
&gt; +/*<br>
&gt; + * Copyright (C) 2013 &nbsp;Paul Woegerer &lt;paul_woegerer@mentor.com&gt;<br>
&gt; + *<br>
&gt; + * This library is free software; you can redistribute it and/or<br>
&gt; + * modify it under the terms of the GNU Lesser General Public<br>
&gt; + * License as published by the Free Software Foundation; either<br>
&gt; + * version 2.1 of the License, or (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This library is distributed in the hope that it will be useful,<br>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. &nbsp;See
the GNU<br>
&gt; + * Lesser General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU Lesser General Public<br>
&gt; + * License along with this library; if not, write to the Free Software<br>
&gt; + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
&nbsp;02110-1301<br>
&gt; USA<br>
&gt; + */<br>
&gt; +<br>
&gt; +#define TRACEPOINT_CREATE_PROBES<br>
&gt; +#define TP_SESSION_CHECK<br>
&gt; +#include &quot;ust_baddr_statedump.h&quot;<br>
&gt; diff --git a/liblttng-ust-baddr/ust_baddr_statedump.h<br>
&gt; b/liblttng-ust-baddr/ust_baddr_statedump.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..77a9af4<br>
&gt; --- /dev/null<br>
&gt; +++ b/liblttng-ust-baddr/ust_baddr_statedump.h<br>
&gt; @@ -0,0 +1,60 @@<br>
&gt; +#undef TRACEPOINT_PROVIDER<br>
&gt; +#define TRACEPOINT_PROVIDER ust_baddr_statedump<br>
&gt; +<br>
&gt; +#if !defined(_TRACEPOINT_UST_BADDR_STATEDUMP_H) ||<br>
&gt; defined(TRACEPOINT_HEADER_MULTI_READ)<br>
&gt; +#define _TRACEPOINT_UST_BADDR_STATEDUMP_H<br>
&gt; +<br>
&gt; +#ifdef __cplusplus<br>
&gt; +extern &quot;C&quot; {<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Copyright (C) 2013 &nbsp;Paul Woegerer &lt;paul_woegerer@mentor.com&gt;<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtaining
a<br>
&gt; copy<br>
&gt; + * of this software and associated documentation files (the &quot;Software&quot;),
to<br>
&gt; deal<br>
&gt; + * in the Software without restriction, including without limitation
the<br>
&gt; rights<br>
&gt; + * to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell<br>
&gt; + * copies of the Software, and to permit persons to whom the Software
is<br>
&gt; + * furnished to do so, subject to the following conditions:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be
included<br>
&gt; in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF
ANY KIND, EXPRESS<br>
&gt; OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
SHALL<br>
&gt; THE<br>
&gt; + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
OR OTHER<br>
&gt; + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING<br>
&gt; FROM,<br>
&gt; + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN<br>
&gt; THE<br>
&gt; + * SOFTWARE.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;stdint.h&gt;<br>
&gt; +#include &lt;unistd.h&gt;<br>
&gt; +#include &lt;lttng/ust-events.h&gt;<br>
&gt; +<br>
&gt; +#define LTTNG_UST_BADDR_STATEDUMP_PROVIDER<br>
&gt; +#include &lt;lttng/tracepoint.h&gt;<br>
&gt; +<br>
&gt; +TRACEPOINT_EVENT(ust_baddr_statedump, soinfo,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TP_ARGS(struct
lttng_session *, session, void *, baddr, const char*,<br>
&gt; sopath, int64_t, size, int64_t, mtime),<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TP_FIELDS(<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_integer_hex(void *,
baddr, baddr)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_string(sopath, sopath)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_integer(int64_t, size,
size)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_integer(int64_t, mtime,
mtime)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; )<br>
&gt; +)<br>
&gt; +<br>
&gt; +#endif /* _TRACEPOINT_UST_BADDR_STATEDUMP_H */<br>
&gt; +<br>
&gt; +#undef TRACEPOINT_INCLUDE<br>
&gt; +#define TRACEPOINT_INCLUDE &quot;./ust_baddr_statedump.h&quot;<br>
&gt; +<br>
&gt; +/* This part must be outside ifdef protection */<br>
&gt; +#include &lt;lttng/tracepoint-event.h&gt;<br>
&gt; +<br>
&gt; +#ifdef __cplusplus<br>
&gt; +}<br>
&gt; +#endif<br>
&gt; diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c<br>
&gt; index 26601a6..21e3639 100644<br>
&gt; --- a/liblttng-ust/lttng-events.c<br>
&gt; +++ b/liblttng-ust/lttng-events.c<br>
&gt; @@ -293,6 +293,8 @@ int lttng_session_enable(struct lttng_session
*session)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*
Set atomically the state to &quot;active&quot; */<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; CMM_ACCESS_ONCE(session-&gt;active)
= 1;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; CMM_ACCESS_ONCE(session-&gt;been_active)
= 1;<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng_ust_sockinfo_session_enabled(session-&gt;owner,
session);<br>
&gt; &nbsp;end:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return
ret;<br>
&gt; &nbsp;}<br>
&gt; diff --git a/liblttng-ust/lttng-tracer-core.h<br>
&gt; b/liblttng-ust/lttng-tracer-core.h<br>
&gt; index f643a7e..e7f549e 100644<br>
&gt; --- a/liblttng-ust/lttng-tracer-core.h<br>
&gt; +++ b/liblttng-ust/lttng-tracer-core.h<br>
&gt; @@ -45,4 +45,7 @@ const char *lttng_ust_obj_get_name(int id);<br>
&gt; &nbsp;<br>
&gt; &nbsp;int lttng_get_notify_socket(void *owner);<br>
&gt; &nbsp;<br>
&gt; +void lttng_ust_sockinfo_session_enabled(void *owner,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct lttng_session *session_enabled);<br>
&gt; +<br>
&gt; &nbsp;#endif /* _LTTNG_TRACER_CORE_H */<br>
&gt; diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c<br>
&gt; index a6e4ba3..6ef3006 100644<br>
&gt; --- a/liblttng-ust/lttng-ust-comm.c<br>
&gt; +++ b/liblttng-ust/lttng-ust-comm.c<br>
&gt; @@ -34,6 +34,7 @@<br>
&gt; &nbsp;#include &lt;time.h&gt;<br>
&gt; &nbsp;#include &lt;assert.h&gt;<br>
&gt; &nbsp;#include &lt;signal.h&gt;<br>
&gt; +#include &lt;dlfcn.h&gt;<br>
&gt; &nbsp;#include &lt;urcu/uatomic.h&gt;<br>
&gt; &nbsp;#include &lt;urcu/futex.h&gt;<br>
&gt; &nbsp;#include &lt;urcu/compiler.h&gt;<br>
&gt; @@ -106,6 +107,7 @@ struct sock_info {<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; char
wait_shm_path[PATH_MAX];<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; char
*wait_shm_mmap;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct lttng_session
*session_enabled;<br>
&gt; &nbsp;};<br>
&gt; &nbsp;<br>
&gt; &nbsp;/* Socket from app (connect) to session daemon (listen) for
communication */<br>
&gt; @@ -122,6 +124,8 @@ struct sock_info global_apps = {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .notify_socket
= -1,<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .wait_shm_path
= &quot;/&quot; LTTNG_UST_WAIT_FILENAME,<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .session_enabled
= NULL,<br>
&gt; &nbsp;};<br>
&gt; &nbsp;<br>
&gt; &nbsp;/* TODO: allow global_apps_sock_path override */<br>
&gt; @@ -135,6 +139,8 @@ struct sock_info local_apps = {<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .socket
= -1,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .notify_socket
= -1,<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .session_enabled
= NULL,<br>
&gt; &nbsp;};<br>
&gt; &nbsp;<br>
&gt; &nbsp;static int wait_poll_fallback;<br>
&gt; @@ -176,6 +182,7 @@ static const char *cmd_name_mapping[] = {<br>
&gt; &nbsp;<br>
&gt; &nbsp;static const char *str_timeout;<br>
&gt; &nbsp;static int got_timeout_env;<br>
&gt; +static void *ust_baddr_handle;<br>
&gt; &nbsp;<br>
&gt; &nbsp;extern void lttng_ring_buffer_client_overwrite_init(void);<br>
&gt; &nbsp;extern void lttng_ring_buffer_client_overwrite_rt_init(void);<br>
&gt; @@ -235,6 +242,39 @@ void print_cmd(int cmd, int handle)<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; &nbsp;static<br>
&gt; +void *lttng_ust_baddr_handle(void)<br>
&gt; +{<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!ust_baddr_handle)
{<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ust_baddr_handle = dlopen(<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &quot;liblttng-ust-baddr.so.0&quot;, RTLD_NOW
| RTLD_GLOBAL);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ust_baddr_handle ==
NULL)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; ERR(&quot;%s&quot;, dlerror());<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return ust_baddr_handle;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static<br>
&gt; +int lttng_ust_baddr_statedump(struct lttng_session *session)<br>
&gt; +{<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; static<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int (*lttng_ust_baddr_init_fn)(struct
lttng_session *);<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!lttng_ust_baddr_init_fn)
{<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;void *baddr_handle = lttng_ust_baddr_handle();<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (baddr_handle) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; lttng_ust_baddr_init_fn = dlsym(baddr_handle,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;&quot;lttng_ust_baddr_statedump&quot;);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; if (lttng_ust_baddr_init_fn == NULL)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;ERR(&quot;%s&quot;, dlerror());<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!lttng_ust_baddr_init_fn)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return lttng_ust_baddr_init_fn(session);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static<br>
&gt; &nbsp;int setup_local_apps(void)<br>
&gt; &nbsp;{<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; const
char *home_dir;<br>
&gt; @@ -1143,6 +1183,13 @@ restart:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret = handle_message(sock_info, sock,
&amp;lum);<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ret) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;ERR(&quot;Error handling message for %s socket&quot;,
sock_info-&gt;name);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; } else {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;struct lttng_session *session =<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sock_info-&gt;session_enabled;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;if (session) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sock_info-&gt;session_enabled
= NULL;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng_ust_baddr_statedump(session);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;}<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;default:<br>
&gt; @@ -1379,6 +1426,12 @@ void __attribute__((destructor)) lttng_ust_exit(void)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*
cleanup the threads if there are stalled in a syscall.<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng_ust_cleanup(1);<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ust_baddr_handle)
{<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;int ret = dlclose(ust_baddr_handle);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ret)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; ERR(&quot;%s&quot;, dlerror());<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; &nbsp;/*<br>
&gt; @@ -1456,3 +1509,10 @@ void ust_after_fork_child(sigset_t *restore_sigset)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ust_after_fork_common(restore_sigset);<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng_ust_init();<br>
&gt; &nbsp;}<br>
&gt; +<br>
&gt; +void lttng_ust_sockinfo_session_enabled(void *owner,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct lttng_session *session_enabled)<br>
&gt; +{<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct sock_info
*sock_info = owner;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sock_info-&gt;session_enabled
= session_enabled;<br>
&gt; +}<br>
&gt; --<br>
&gt; 1.8.4.2<br>
&gt; <br>
&gt; <br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.</font><font size=3 color=blue face="Arial"><u><br>
</u></font><a href=http://www.efficios.com/ target=_blank><font size=2 color=blue face="Arial"><u>http://www.efficios.com</u></font></a><font size=2 face="Arial"><br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org</font><font size=3 color=blue face="Arial"><u><br>
</u></font><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=_blank><font size=2 color=blue face="Arial"><u>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</u></font></a><font size=2 face="Arial"><br>
</font><font size=3 face="Arial"><br>
</font>
<br><font size=3><br>
</font>
<br>
<br><font size=3>-- </font>
<br><font size=3>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
</font><a href=http://www.efficios.com/><font size=3>http://www.efficios.com</font></a>
<br>
--=_alternative 002BE94FC2257C27_=--



--===============0587807195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0587807195==--
