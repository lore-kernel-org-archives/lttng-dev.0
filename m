From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 2/2] Implement base-address-state tracing
Date: Sun, 17 Nov 2013 14:02:24 +0000 (UTC)
Message-ID: <424052805.69587.1384696944197.JavaMail.zimbra__14727.0005349585$1384697010$gmane$org@efficios.com>
References: <1384454389-456-1-git-send-email-paul_woegerer@mentor.com>
	<1581197758.67644.1384457210726.JavaMail.zimbra@efficios.com>
	<OF5EA7C09A.2F75FE97-ONC2257C26.00348FD3-C2257C26.0034C2F3@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1951312098=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1Vi2vn-0007Q7-U3
	for lttng-dev@lists.lttng.org; Sun, 17 Nov 2013 09:02:35 -0500
In-Reply-To: <OF5EA7C09A.2F75FE97-ONC2257C26.00348FD3-C2257C26.0034C2F3@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1951312098==
Content-Type: multipart/alternative;
	boundary="----=_Part_69586_1784249759.1384696944194"

------=_Part_69586_1784249759.1384696944194
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Amit Margalit" <AMITM@il.ibm.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Paul Woegerer" <paul_woegerer@mentor.com>
> Sent: Sunday, November 17, 2013 4:36:19 AM
> Subject: Re: [lttng-dev] [PATCH v3 2/2] Implement base-address-state tracing

> I guess I missed something in the discussion - is this going to be active all
> the time, or can I disable it somehow?

> Maybe a command-line switch to turn this off?

> For me this is overhead that I don't need and don't want.
You just have to not enable those new events if you don't care about them. 

Thanks, 

Mathieu 

> Thanks,

> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03 -689-7774
> Fax. 03-689-7230

> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: Paul Woegerer <paul_woegerer@mentor.com>
> Cc: lttng-dev@lists.lttng.org
> Date: 11/14/2013 09:30 PM
> Subject: Re: [lttng-dev] [PATCH v3 2/2] Implement base-address-state tracing

> ----- Original Message -----
> > From: "Paul Woegerer" <paul_woegerer@mentor.com>
> > To: lttng-dev@lists.lttng.org, "mathieu desnoyers"
> > <mathieu.desnoyers@efficios.com>
> > Sent: Thursday, November 14, 2013 1:39:49 PM
> > Subject: [PATCH v3 2/2] Implement base-address-state tracing
> >
> > Dump the base-address state (executable and shared objects) into session
> > on session-enable (per-session events).

> Merged, thanks !

> Mathieu

> >
> > Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
> > ---
> > include/lttng/ust-tracepoint-event.h | 14 +++++++
> > liblttng-ust-baddr/Makefile.am | 4 +-
> > liblttng-ust-baddr/lttng-ust-baddr.c | 72
> > ++++++++++++++++++++++++++++++++
> > liblttng-ust-baddr/ust_baddr_statedump.c | 21 ++++++++++
> > liblttng-ust-baddr/ust_baddr_statedump.h | 60 ++++++++++++++++++++++++++
> > liblttng-ust/lttng-events.c | 2 +
> > liblttng-ust/lttng-tracer-core.h | 3 ++
> > liblttng-ust/lttng-ust-comm.c | 60 ++++++++++++++++++++++++++
> > 8 files changed, 235 insertions(+), 1 deletion(-)
> > create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.c
> > create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.h
> >
> > diff --git a/include/lttng/ust-tracepoint-event.h
> > b/include/lttng/ust-tracepoint-event.h
> > index bb3a05d..be58030 100644
> > --- a/include/lttng/ust-tracepoint-event.h
> > +++ b/include/lttng/ust-tracepoint-event.h
> > @@ -480,6 +480,18 @@ size_t
> > __event_get_align__##_provider##___##_name(_TP_ARGS_PROTO(_args)) \
> > #define TP_FIELDS(...) __VA_ARGS__
> >
> > /*
> > + * For state dump, check that "session" argument (mandatory) matches the
> > + * session this event belongs to. Ensures that we write state dump data
> > only
> > + * into the started session, not into all sessions.
> > + */
> > +#undef _TP_SESSION_CHECK
> > +#ifdef TP_SESSION_CHECK
> > +#define _TP_SESSION_CHECK(session, csession) (session == csession)
> > +#else /* TP_SESSION_CHECK */
> > +#define _TP_SESSION_CHECK(session, csession) 1
> > +#endif /* TP_SESSION_CHECK */
> > +
> > +/*
> > * Using twice size for filter stack data to hold size and pointer for
> > * each field (worse case). For integers, max size required is 64-bit.
> > * Same for double-precision floats. Those fit within
> > @@ -506,6 +518,8 @@ void
> > __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args)) \
> > \
> > if (0) \
> > (void) __dynamic_len_idx; /* don't warn if unused */ \
> > + if (!_TP_SESSION_CHECK(session, __chan->session)) \
> > + return; \
> > if (caa_unlikely(!CMM_ACCESS_ONCE(__chan->session->active))) \
> > return; \
> > if (caa_unlikely(!CMM_ACCESS_ONCE(__chan->enabled))) \
> > diff --git a/liblttng-ust-baddr/Makefile.am
> > b/liblttng-ust-baddr/Makefile.am
> > index afa9489..0d3cf28 100644
> > --- a/liblttng-ust-baddr/Makefile.am
> > +++ b/liblttng-ust-baddr/Makefile.am
> > @@ -5,7 +5,9 @@ lib_LTLIBRARIES = liblttng-ust-baddr.la
> > liblttng_ust_baddr_la_SOURCES = \
> > lttng-ust-baddr.c \
> > ust_baddr.c \
> > - ust_baddr.h
> > + ust_baddr.h \
> > + ust_baddr_statedump.c \
> > + ust_baddr_statedump.h
> > liblttng_ust_baddr_la_LIBADD = \
> > -L$(top_builddir)/liblttng-ust/.libs \
> > -llttng-ust
> > diff --git a/liblttng-ust-baddr/lttng-ust-baddr.c
> > b/liblttng-ust-baddr/lttng-ust-baddr.c
> > index f24a171..a856965 100644
> > --- a/liblttng-ust-baddr/lttng-ust-baddr.c
> > +++ b/liblttng-ust-baddr/lttng-ust-baddr.c
> > @@ -34,6 +34,7 @@
> >
> > #define TRACEPOINT_DEFINE
> > #include "ust_baddr.h"
> > +#include "ust_baddr_statedump.h"
> >
> > int
> > lttng_ust_push_baddr(void *so_base, const char *so_name)
> > @@ -62,3 +63,74 @@ lttng_ust_pop_baddr(void *so_base)
> > tracepoint(ust_baddr, pop, so_base);
> > return 0;
> > }
> > +
> > +static int
> > +extract_soinfo_events(struct dl_phdr_info *info, size_t size, void *data)
> > +{
> > + int j;
> > + int num_loadable_segment = 0;
> > +
> > + for (j = 0; j < info->dlpi_phnum; j++) {
> > + char resolved_path[PATH_MAX];
> > + struct stat sostat;
> > + void *base_addr_ptr;
> > +
> > + if (info->dlpi_phdr[j].p_type != PT_LOAD)
> > + continue;
> > +
> > + /* Calculate virtual memory address of the loadable segment */
> > + base_addr_ptr = (void *) info->dlpi_addr
> > + + info->dlpi_phdr[j].p_vaddr;
> > +
> > + num_loadable_segment += 1;
> > + if ((info->dlpi_name == NULL || info->dlpi_name[0] == 0)
> > + && num_loadable_segment == 1) {
> > + /*
> > + * If the iterated element is the executable itself we
> > + * have to use Dl_info to determine its full path
> > + */
> > + Dl_info dl_info = { 0 };
> > + if (!dladdr(base_addr_ptr, &dl_info))
> > + return 0;
> > + if (!realpath(dl_info.dli_fname, resolved_path))
> > + return 0;
> > + } else {
> > + /*
> > + * For regular dl_phdr_info entries we have to check if
> > + * the path to the shared object really exists
> > + */
> > + if (!realpath(info->dlpi_name, resolved_path)) {
> > + /* Found vDSO, put the 'path' into brackets */
> > + snprintf(resolved_path, PATH_MAX - 1, "[%s]",
> > + info->dlpi_name);
> > + }
> > + }
> > +
> > + if (stat(resolved_path, &sostat)) {
> > + sostat.st_size = 0;
> > + sostat.st_mtime = -1;
> > + }
> > +
> > + tracepoint(ust_baddr_statedump, soinfo,
> > + (struct lttng_session *) data, base_addr_ptr,
> > + resolved_path, sostat.st_size, sostat.st_mtime);
> > +
> > + /*
> > + * We are only interested in the base address (lowest virtual
> > + * address associated with the memory image), skip the rest
> > + */
> > + break;
> > + }
> > + return 0;
> > +}
> > +
> > +int
> > +lttng_ust_baddr_statedump(struct lttng_session *session)
> > +{
> > + /*
> > + * Iterate through the list of currently loaded shared objects and
> > + * generate events for loadable segments using extract_soinfo_events
> > + */
> > + dl_iterate_phdr(extract_soinfo_events, session);
> > + return 0;
> > +}
> > diff --git a/liblttng-ust-baddr/ust_baddr_statedump.c
> > b/liblttng-ust-baddr/ust_baddr_statedump.c
> > new file mode 100644
> > index 0000000..75f74ca
> > --- /dev/null
> > +++ b/liblttng-ust-baddr/ust_baddr_statedump.c
> > @@ -0,0 +1,21 @@
> > +/*
> > + * Copyright (C) 2013 Paul Woegerer <paul_woegerer@mentor.com>
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, write to the Free Software
> > + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> > 02110-1301
> > USA
> > + */
> > +
> > +#define TRACEPOINT_CREATE_PROBES
> > +#define TP_SESSION_CHECK
> > +#include "ust_baddr_statedump.h"
> > diff --git a/liblttng-ust-baddr/ust_baddr_statedump.h
> > b/liblttng-ust-baddr/ust_baddr_statedump.h
> > new file mode 100644
> > index 0000000..77a9af4
> > --- /dev/null
> > +++ b/liblttng-ust-baddr/ust_baddr_statedump.h
> > @@ -0,0 +1,60 @@
> > +#undef TRACEPOINT_PROVIDER
> > +#define TRACEPOINT_PROVIDER ust_baddr_statedump
> > +
> > +#if !defined(_TRACEPOINT_UST_BADDR_STATEDUMP_H) ||
> > defined(TRACEPOINT_HEADER_MULTI_READ)
> > +#define _TRACEPOINT_UST_BADDR_STATEDUMP_H
> > +
> > +#ifdef __cplusplus
> > +extern "C" {
> > +#endif
> > +
> > +/*
> > + * Copyright (C) 2013 Paul Woegerer <paul_woegerer@mentor.com>
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaining a
> > copy
> > + * of this software and associated documentation files (the "Software"),
> > to
> > deal
> > + * in the Software without restriction, including without limitation the
> > rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
> > sell
> > + * copies of the Software, and to permit persons to whom the Software is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be included
> > in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> > OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > THE
> > + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> > IN
> > THE
> > + * SOFTWARE.
> > + */
> > +
> > +#include <stdint.h>
> > +#include <unistd.h>
> > +#include <lttng/ust-events.h>
> > +
> > +#define LTTNG_UST_BADDR_STATEDUMP_PROVIDER
> > +#include <lttng/tracepoint.h>
> > +
> > +TRACEPOINT_EVENT(ust_baddr_statedump, soinfo,
> > + TP_ARGS(struct lttng_session *, session, void *, baddr, const char*,
> > sopath, int64_t, size, int64_t, mtime),
> > + TP_FIELDS(
> > + ctf_integer_hex(void *, baddr, baddr)
> > + ctf_string(sopath, sopath)
> > + ctf_integer(int64_t, size, size)
> > + ctf_integer(int64_t, mtime, mtime)
> > + )
> > +)
> > +
> > +#endif /* _TRACEPOINT_UST_BADDR_STATEDUMP_H */
> > +
> > +#undef TRACEPOINT_INCLUDE
> > +#define TRACEPOINT_INCLUDE "./ust_baddr_statedump.h"
> > +
> > +/* This part must be outside ifdef protection */
> > +#include <lttng/tracepoint-event.h>
> > +
> > +#ifdef __cplusplus
> > +}
> > +#endif
> > diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
> > index 26601a6..21e3639 100644
> > --- a/liblttng-ust/lttng-events.c
> > +++ b/liblttng-ust/lttng-events.c
> > @@ -293,6 +293,8 @@ int lttng_session_enable(struct lttng_session *session)
> > /* Set atomically the state to "active" */
> > CMM_ACCESS_ONCE(session->active) = 1;
> > CMM_ACCESS_ONCE(session->been_active) = 1;
> > +
> > + lttng_ust_sockinfo_session_enabled(session->owner, session);
> > end:
> > return ret;
> > }
> > diff --git a/liblttng-ust/lttng-tracer-core.h
> > b/liblttng-ust/lttng-tracer-core.h
> > index f643a7e..e7f549e 100644
> > --- a/liblttng-ust/lttng-tracer-core.h
> > +++ b/liblttng-ust/lttng-tracer-core.h
> > @@ -45,4 +45,7 @@ const char *lttng_ust_obj_get_name(int id);
> >
> > int lttng_get_notify_socket(void *owner);
> >
> > +void lttng_ust_sockinfo_session_enabled(void *owner,
> > + struct lttng_session *session_enabled);
> > +
> > #endif /* _LTTNG_TRACER_CORE_H */
> > diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
> > index a6e4ba3..6ef3006 100644
> > --- a/liblttng-ust/lttng-ust-comm.c
> > +++ b/liblttng-ust/lttng-ust-comm.c
> > @@ -34,6 +34,7 @@
> > #include <time.h>
> > #include <assert.h>
> > #include <signal.h>
> > +#include <dlfcn.h>
> > #include <urcu/uatomic.h>
> > #include <urcu/futex.h>
> > #include <urcu/compiler.h>
> > @@ -106,6 +107,7 @@ struct sock_info {
> >
> > char wait_shm_path[PATH_MAX];
> > char *wait_shm_mmap;
> > + struct lttng_session *session_enabled;
> > };
> >
> > /* Socket from app (connect) to session daemon (listen) for communication
> > */
> > @@ -122,6 +124,8 @@ struct sock_info global_apps = {
> > .notify_socket = -1,
> >
> > .wait_shm_path = "/" LTTNG_UST_WAIT_FILENAME,
> > +
> > + .session_enabled = NULL,
> > };
> >
> > /* TODO: allow global_apps_sock_path override */
> > @@ -135,6 +139,8 @@ struct sock_info local_apps = {
> >
> > .socket = -1,
> > .notify_socket = -1,
> > +
> > + .session_enabled = NULL,
> > };
> >
> > static int wait_poll_fallback;
> > @@ -176,6 +182,7 @@ static const char *cmd_name_mapping[] = {
> >
> > static const char *str_timeout;
> > static int got_timeout_env;
> > +static void *ust_baddr_handle;
> >
> > extern void lttng_ring_buffer_client_overwrite_init(void);
> > extern void lttng_ring_buffer_client_overwrite_rt_init(void);
> > @@ -235,6 +242,39 @@ void print_cmd(int cmd, int handle)
> > }
> >
> > static
> > +void *lttng_ust_baddr_handle(void)
> > +{
> > + if (!ust_baddr_handle) {
> > + ust_baddr_handle = dlopen(
> > + "liblttng-ust-baddr.so.0", RTLD_NOW | RTLD_GLOBAL);
> > + if (ust_baddr_handle == NULL)
> > + ERR("%s", dlerror());
> > + }
> > + return ust_baddr_handle;
> > +}
> > +
> > +static
> > +int lttng_ust_baddr_statedump(struct lttng_session *session)
> > +{
> > + static
> > + int (*lttng_ust_baddr_init_fn)(struct lttng_session *);
> > +
> > + if (!lttng_ust_baddr_init_fn) {
> > + void *baddr_handle = lttng_ust_baddr_handle();
> > + if (baddr_handle) {
> > + lttng_ust_baddr_init_fn = dlsym(baddr_handle,
> > + "lttng_ust_baddr_statedump");
> > + if (lttng_ust_baddr_init_fn == NULL)
> > + ERR("%s", dlerror());
> > + }
> > + if (!lttng_ust_baddr_init_fn)
> > + return -1;
> > + }
> > +
> > + return lttng_ust_baddr_init_fn(session);
> > +}
> > +
> > +static
> > int setup_local_apps(void)
> > {
> > const char *home_dir;
> > @@ -1143,6 +1183,13 @@ restart:
> > ret = handle_message(sock_info, sock, &lum);
> > if (ret) {
> > ERR("Error handling message for %s socket", sock_info->name);
> > + } else {
> > + struct lttng_session *session =
> > + sock_info->session_enabled;
> > + if (session) {
> > + sock_info->session_enabled = NULL;
> > + lttng_ust_baddr_statedump(session);
> > + }
> > }
> > continue;
> > default:
> > @@ -1379,6 +1426,12 @@ void __attribute__((destructor))
> > lttng_ust_exit(void)
> > * cleanup the threads if there are stalled in a syscall.
> > */
> > lttng_ust_cleanup(1);
> > +
> > + if (ust_baddr_handle) {
> > + int ret = dlclose(ust_baddr_handle);
> > + if (ret)
> > + ERR("%s", dlerror());
> > + }
> > }
> >
> > /*
> > @@ -1456,3 +1509,10 @@ void ust_after_fork_child(sigset_t *restore_sigset)
> > ust_after_fork_common(restore_sigset);
> > lttng_ust_init();
> > }
> > +
> > +void lttng_ust_sockinfo_session_enabled(void *owner,
> > + struct lttng_session *session_enabled)
> > +{
> > + struct sock_info *sock_info = owner;
> > + sock_info->session_enabled = session_enabled;
> > +}
> > --
> > 1.8.4.2
> >
> >

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_69586_1784249759.1384696944194
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"border-left: 2px s=
olid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-weight=
: normal; font-style: normal; text-decoration: none; font-family: Helvetica=
,Arial,sans-serif; font-size: 12pt;"><b>From: </b>"Amit Margalit" &lt;AMITM=
@il.ibm.com&gt;<br><b>To: </b>"Mathieu Desnoyers" &lt;mathieu.desnoyers@eff=
icios.com&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.org, "Paul Woegerer" &lt;=
paul_woegerer@mentor.com&gt;<br><b>Sent: </b>Sunday, November 17, 2013 4:36=
:19 AM<br><b>Subject: </b>Re: [lttng-dev] [PATCH v3 2/2] Implement base-add=
ress-state tracing<br><div><br></div><span style=3D"font-family: sans-serif=
; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: =
small;" face=3D"sans-serif" size=3D"2">I guess I missed something in the di=
scussion - is this going to be active all the time, or can I disable it som=
ehow?</span><br><br><span style=3D"font-family: sans-serif; font-size: smal=
l;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"s=
ans-serif" size=3D"2">Maybe a command-line switch to turn this off?</span><=
br><br><span style=3D"font-family: sans-serif; font-size: small;" data-mce-=
style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" si=
ze=3D"2">For me this is overhead that I don't need and don't want.</span></=
blockquote><div><br></div><div>You just have to not enable those new events=
 if you don't care about them.<br></div><div><br></div><div>Thanks,<br></di=
v><div><br></div><div>Mathieu<br></div><div><br></div><blockquote style=3D"=
border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;f=
ont-weight:normal;font-style:normal;text-decoration:none;font-family:Helvet=
ica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"border-left: 2px so=
lid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-weight:=
 normal; font-style: normal; text-decoration: none; font-family: Helvetica,=
Arial,sans-serif; font-size: 12pt;"><br><span style=3D"font-family: sans-se=
rif; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-siz=
e: small;" face=3D"sans-serif" size=3D"2">Thanks,</span><br><br><span style=
=3D"color: #000080; font-family: sans-serif; font-size: small;" data-mce-st=
yle=3D"color: #000080; font-family: sans-serif; font-size: small;" color=3D=
"#000080" face=3D"sans-serif" size=3D"2">Amit Margalit</span><br><span styl=
e=3D"color: #808000; font-family: sans-serif; font-size: small;" data-mce-s=
tyle=3D"color: #808000; font-family: sans-serif; font-size: small;" color=
=3D"#808000" face=3D"sans-serif" size=3D"2">IBM XIV </span><span style=3D"f=
ont-family: sans-serif; font-size: small;" data-mce-style=3D"font-family: s=
ans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">- <i>Storage R=
einvented</i></span><br><span style=3D"font-family: sans-serif; font-size: =
small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=
=3D"sans-serif" size=3D"2">XIV-NAS Development Team</span><br><span style=
=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fami=
ly: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">Tel. 03</=
span><span style=3D"font-family: Arial; font-size: small;" data-mce-style=
=3D"font-family: Arial; font-size: small;" face=3D"Arial" size=3D"2">-689-7=
774</span><br><span style=3D"font-family: Arial; font-size: small;" data-mc=
e-style=3D"font-family: Arial; font-size: small;" face=3D"Arial" size=3D"2"=
>Fax. 03-689-7230</span><br><br><br><br><span style=3D"color: #5f5f5f; font=
-family: sans-serif; font-size: xx-small;" data-mce-style=3D"color: #5f5f5f=
; font-family: sans-serif; font-size: xx-small;" color=3D"#5f5f5f" face=3D"=
sans-serif" size=3D"1">From: &nbsp; &nbsp; &nbsp; &nbsp;</span><span style=
=3D"font-family: sans-serif; font-size: xx-small;" data-mce-style=3D"font-f=
amily: sans-serif; font-size: xx-small;" face=3D"sans-serif" size=3D"1">Mat=
hieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</span><br><span style=
=3D"color: #5f5f5f; font-family: sans-serif; font-size: xx-small;" data-mce=
-style=3D"color: #5f5f5f; font-family: sans-serif; font-size: xx-small;" co=
lor=3D"#5f5f5f" face=3D"sans-serif" size=3D"1">To: &nbsp; &nbsp; &nbsp; &nb=
sp;</span><span style=3D"font-family: sans-serif; font-size: xx-small;" dat=
a-mce-style=3D"font-family: sans-serif; font-size: xx-small;" face=3D"sans-=
serif" size=3D"1">Paul Woegerer &lt;paul_woegerer@mentor.com&gt;</span><br>=
<span style=3D"color: #5f5f5f; font-family: sans-serif; font-size: xx-small=
;" data-mce-style=3D"color: #5f5f5f; font-family: sans-serif; font-size: xx=
-small;" color=3D"#5f5f5f" face=3D"sans-serif" size=3D"1">Cc: &nbsp; &nbsp;=
 &nbsp; &nbsp;</span><span style=3D"font-family: sans-serif; font-size: xx-=
small;" data-mce-style=3D"font-family: sans-serif; font-size: xx-small;" fa=
ce=3D"sans-serif" size=3D"1">lttng-dev@lists.lttng.org</span><br><span styl=
e=3D"color: #5f5f5f; font-family: sans-serif; font-size: xx-small;" data-mc=
e-style=3D"color: #5f5f5f; font-family: sans-serif; font-size: xx-small;" c=
olor=3D"#5f5f5f" face=3D"sans-serif" size=3D"1">Date: &nbsp; &nbsp; &nbsp; =
&nbsp;</span><span style=3D"font-family: sans-serif; font-size: xx-small;" =
data-mce-style=3D"font-family: sans-serif; font-size: xx-small;" face=3D"sa=
ns-serif" size=3D"1">11/14/2013 09:30 PM</span><br><span style=3D"color: #5=
f5f5f; font-family: sans-serif; font-size: xx-small;" data-mce-style=3D"col=
or: #5f5f5f; font-family: sans-serif; font-size: xx-small;" color=3D"#5f5f5=
f" face=3D"sans-serif" size=3D"1">Subject: &nbsp; &nbsp; &nbsp; &nbsp;</spa=
n><span style=3D"font-family: sans-serif; font-size: xx-small;" data-mce-st=
yle=3D"font-family: sans-serif; font-size: xx-small;" face=3D"sans-serif" s=
ize=3D"1">Re: [lttng-dev] [PATCH v3 2/2] Implement base-address-state traci=
ng</span><br><hr noshade=3D"noshade"><br><br><br><tt><span style=3D"font-si=
ze: small;" data-mce-style=3D"font-size: small;" size=3D"2">----- Original =
Message -----<br> &gt; From: "Paul Woegerer" &lt;paul_woegerer@mentor.com&g=
t;<br> &gt; To: lttng-dev@lists.lttng.org, "mathieu desnoyers" &lt;mathieu.=
desnoyers@efficios.com&gt;<br> &gt; Sent: Thursday, November 14, 2013 1:39:=
49 PM<br> &gt; Subject: [PATCH v3 2/2] Implement base-address-state tracing=
<br> &gt; <br> &gt; Dump the base-address state (executable and shared obje=
cts) into session<br> &gt; on session-enable (per-session events).<br> <br>=
 Merged, thanks !<br> <br> Mathieu<br> <br> &gt; <br> &gt; Signed-off-by: P=
aul Woegerer &lt;paul_woegerer@mentor.com&gt;<br> &gt; ---<br> &gt; &nbsp;i=
nclude/lttng/ust-tracepoint-event.h &nbsp; &nbsp; | 14 +++++++<br> &gt; &nb=
sp;liblttng-ust-baddr/Makefile.am &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbs=
p;4 +-<br> &gt; &nbsp;liblttng-ust-baddr/lttng-ust-baddr.c &nbsp; &nbsp; | =
72<br> &gt; &nbsp;++++++++++++++++++++++++++++++++<br> &gt; &nbsp;liblttng-=
ust-baddr/ust_baddr_statedump.c | 21 ++++++++++<br> &gt; &nbsp;liblttng-ust=
-baddr/ust_baddr_statedump.h | 60 ++++++++++++++++++++++++++<br> &gt; &nbsp=
;liblttng-ust/lttng-events.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;| &nbsp;2 +<br> &gt; &nbsp;liblttng-ust/lttng-tracer-core.h &nbsp; &nbsp;=
 &nbsp; &nbsp; | &nbsp;3 ++<br> &gt; &nbsp;liblttng-ust/lttng-ust-comm.c &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 60 ++++++++++++++++++++++++++<br> =
&gt; &nbsp;8 files changed, 235 insertions(+), 1 deletion(-)<br> &gt; &nbsp=
;create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.c<br> &gt; &nbsp=
;create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.h<br> &gt; <br> =
&gt; diff --git a/include/lttng/ust-tracepoint-event.h<br> &gt; b/include/l=
ttng/ust-tracepoint-event.h<br> &gt; index bb3a05d..be58030 100644<br> &gt;=
 --- a/include/lttng/ust-tracepoint-event.h<br> &gt; +++ b/include/lttng/us=
t-tracepoint-event.h<br> &gt; @@ -480,6 +480,18 @@ size_t<br> &gt; __event_=
get_align__##_provider##___##_name(_TP_ARGS_PROTO(_args)) &nbsp; &nbsp; &nb=
sp;\<br> &gt; &nbsp;#define TP_FIELDS(...) __VA_ARGS__<br> &gt; &nbsp;<br> =
&gt; &nbsp;/*<br> &gt; + * For state dump, check that "session" argument (m=
andatory) matches the<br> &gt; + * session this event belongs to. Ensures t=
hat we write state dump data only<br> &gt; + * into the started session, no=
t into all sessions.<br> &gt; + */<br> &gt; +#undef _TP_SESSION_CHECK<br> &=
gt; +#ifdef TP_SESSION_CHECK<br> &gt; +#define _TP_SESSION_CHECK(session, c=
session) &nbsp; (session =3D=3D csession)<br> &gt; +#else /* TP_SESSION_CHE=
CK */<br> &gt; +#define _TP_SESSION_CHECK(session, csession) &nbsp; 1<br> &=
gt; +#endif /* TP_SESSION_CHECK */<br> &gt; +<br> &gt; +/*<br> &gt; &nbsp; =
* Using twice size for filter stack data to hold size and pointer for<br> &=
gt; &nbsp; * each field (worse case). For integers, max size required is 64=
-bit.<br> &gt; &nbsp; * Same for double-precision floats. Those fit within<=
br> &gt; @@ -506,6 +518,8 @@ void<br> &gt; __event_probe__##_provider##___#=
#_name(_TP_ARGS_DATA_PROTO(_args)) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; \<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; if (0) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\<br> &gt; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(void) __dynamic_len_idx; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* don't warn if unuse=
d */ &nbsp; &nbsp;\<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; if (!_TP_SESSION_CHECK(session, __chan-&gt;session)) &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\<br> &gt; + &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; \<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; if (caa_unlikely(!CMM_ACCESS_ONCE(__chan-&gt;sess=
ion-&gt;active))) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; \<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;return; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \<=
br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if =
(caa_unlikely(!CMM_ACCESS_ONCE(__chan-&gt;enabled))) &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\<br> &gt; diff --git a/liblttng-=
ust-baddr/Makefile.am b/liblttng-ust-baddr/Makefile.am<br> &gt; index afa94=
89..0d3cf28 100644<br> &gt; --- a/liblttng-ust-baddr/Makefile.am<br> &gt; +=
++ b/liblttng-ust-baddr/Makefile.am<br> &gt; @@ -5,7 +5,9 @@ lib_LTLIBRARIE=
S =3D liblttng-ust-baddr.la<br> &gt; &nbsp;liblttng_ust_baddr_la_SOURCES =
=3D \<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; lttng-ust-baddr.c \<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; ust_baddr.c \<br> &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; ust_baddr.h<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; ust_baddr.h \<br> &gt; + &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ust_baddr_statedump.c \<br> &gt; + &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ust_baddr_statedump.h<b=
r> &gt; &nbsp;liblttng_ust_baddr_la_LIBADD =3D \<br> &gt; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -L$(top_builddir)/liblttng-us=
t/.libs \<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; -llttng-ust<br> &gt; diff --git a/liblttng-ust-baddr/lttng-ust-baddr=
.c<br> &gt; b/liblttng-ust-baddr/lttng-ust-baddr.c<br> &gt; index f24a171..=
a856965 100644<br> &gt; --- a/liblttng-ust-baddr/lttng-ust-baddr.c<br> &gt;=
 +++ b/liblttng-ust-baddr/lttng-ust-baddr.c<br> &gt; @@ -34,6 +34,7 @@<br> =
&gt; &nbsp;<br> &gt; &nbsp;#define TRACEPOINT_DEFINE<br> &gt; &nbsp;#includ=
e "ust_baddr.h"<br> &gt; +#include "ust_baddr_statedump.h"<br> &gt; &nbsp;<=
br> &gt; &nbsp;int<br> &gt; &nbsp;lttng_ust_push_baddr(void *so_base, const=
 char *so_name)<br> &gt; @@ -62,3 +63,74 @@ lttng_ust_pop_baddr(void *so_ba=
se)<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 tracepoint(ust_baddr, pop, so_base);<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return 0;<br> &gt; &nbsp;}<br> &gt; +<br=
> &gt; +static int<br> &gt; +extract_soinfo_events(struct dl_phdr_info *inf=
o, size_t size, void *data)<br> &gt; +{<br> &gt; + &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; int j;<br> &gt; + &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; int num_loadable_segment =3D 0;<br> &gt; +<b=
r> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for (j =
=3D 0; j &lt; info-&gt;dlpi_phnum; j++) {<br> &gt; + &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp;char resolved_path[PATH_MAX];<br> &gt; + &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;struct stat sostat;<br> &gt; + &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp;void *base_addr_ptr;<br> &gt; +<br> &gt; + &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (info-&gt;dlpi_phdr[j].p_type !=
=3D PT_LOAD)<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; continue;<br> &gt; +<br> &=
gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Calculate virtual memor=
y address of the loadable segment */<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp;base_addr_ptr =3D (void *) info-&gt;dlpi_addr<br> &gt; + &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; + info-&gt;dlpi_phdr[j].p_vaddr;<br> &gt; +<br> &gt;=
 + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;num_loadable_segment +=3D 1;<=
br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if ((info-&gt;dlpi_na=
me =3D=3D NULL || info-&gt;dlpi_name[0] =3D=3D 0)<br> &gt; + &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&a=
mp;&amp; num_loadable_segment =3D=3D 1) {<br> &gt; + &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; /*<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* If the iterated element i=
s the executable itself we<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* have=
 to use Dl_info to determine its full path<br> &gt; + &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;*/<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Dl_info dl_info =3D { 0 };=
<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!dladdr(base_addr_ptr, &amp;dl_inf=
o))<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;return 0;<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if=
 (!realpath(dl_info.dli_fname, resolved_path))<br> &gt; + &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;retur=
n 0;<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} else {<br> &gt=
; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; /*<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*=
 For regular dl_phdr_info entries we have to check if<br> &gt; + &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp;* the path to the shared object really exists<br> &gt;=
 + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if=
 (!realpath(info-&gt;dlpi_name, resolved_path)) {<br> &gt; + &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*=
 Found vDSO, put the 'path' into brackets */<br> &gt; + &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;snprint=
f(resolved_path, PATH_MAX - 1, "[%s]",<br> &gt; + &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp;info-&gt;dlpi_name);<br> &gt; + &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; }<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br> =
&gt; +<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (stat(resol=
ved_path, &amp;sostat)) {<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sostat.st_siz=
e =3D 0;<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sostat.st_mtime =3D -1;<br> &g=
t; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br> &gt; +<br> &gt; + &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tracepoint(ust_baddr_statedump, soi=
nfo,<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp;(struct lttng_session *) data, base_addr_ptr,<b=
r> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;resolved_path, sostat.st_size, sostat.st_mtime);<br> =
&gt; +<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br> &gt; + =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * We are only interested in the=
 base address (lowest virtual<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; * address associated with the memory image), skip the rest<br> &g=
t; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br> &gt; + &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; }<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; return 0;<br> &gt; +}<br> &gt; +<br> &gt; +int<br> =
&gt; +lttng_ust_baddr_statedump(struct lttng_session *session)<br> &gt; +{<=
br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br> &=
gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* Itera=
te through the list of currently loaded shared objects and<br> &gt; + &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* generate events =
for loadable segments using extract_soinfo_events<br> &gt; + &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br> &gt; + &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dl_iterate_phdr(extract_soinfo_e=
vents, session);<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; return 0;<br> &gt; +}<br> &gt; diff --git a/liblttng-ust-baddr/ust=
_baddr_statedump.c<br> &gt; b/liblttng-ust-baddr/ust_baddr_statedump.c<br> =
&gt; new file mode 100644<br> &gt; index 0000000..75f74ca<br> &gt; --- /dev=
/null<br> &gt; +++ b/liblttng-ust-baddr/ust_baddr_statedump.c<br> &gt; @@ -=
0,0 +1,21 @@<br> &gt; +/*<br> &gt; + * Copyright (C) 2013 &nbsp;Paul Woeger=
er &lt;paul_woegerer@mentor.com&gt;<br> &gt; + *<br> &gt; + * This library =
is free software; you can redistribute it and/or<br> &gt; + * modify it und=
er the terms of the GNU Lesser General Public<br> &gt; + * License as publi=
shed by the Free Software Foundation; either<br> &gt; + * version 2.1 of th=
e License, or (at your option) any later version.<br> &gt; + *<br> &gt; + *=
 This library is distributed in the hope that it will be useful,<br> &gt; +=
 * but WITHOUT ANY WARRANTY; without even the implied warranty of<br> &gt; =
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. &nbsp;See the GNU<=
br> &gt; + * Lesser General Public License for more details.<br> &gt; + *<b=
r> &gt; + * You should have received a copy of the GNU Lesser General Publi=
c<br> &gt; + * License along with this library; if not, write to the Free S=
oftware<br> &gt; + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Bos=
ton, MA &nbsp;02110-1301<br> &gt; USA<br> &gt; + */<br> &gt; +<br> &gt; +#d=
efine TRACEPOINT_CREATE_PROBES<br> &gt; +#define TP_SESSION_CHECK<br> &gt; =
+#include "ust_baddr_statedump.h"<br> &gt; diff --git a/liblttng-ust-baddr/=
ust_baddr_statedump.h<br> &gt; b/liblttng-ust-baddr/ust_baddr_statedump.h<b=
r> &gt; new file mode 100644<br> &gt; index 0000000..77a9af4<br> &gt; --- /=
dev/null<br> &gt; +++ b/liblttng-ust-baddr/ust_baddr_statedump.h<br> &gt; @=
@ -0,0 +1,60 @@<br> &gt; +#undef TRACEPOINT_PROVIDER<br> &gt; +#define TRAC=
EPOINT_PROVIDER ust_baddr_statedump<br> &gt; +<br> &gt; +#if !defined(_TRAC=
EPOINT_UST_BADDR_STATEDUMP_H) ||<br> &gt; defined(TRACEPOINT_HEADER_MULTI_R=
EAD)<br> &gt; +#define _TRACEPOINT_UST_BADDR_STATEDUMP_H<br> &gt; +<br> &gt=
; +#ifdef __cplusplus<br> &gt; +extern "C" {<br> &gt; +#endif<br> &gt; +<br=
> &gt; +/*<br> &gt; + * Copyright (C) 2013 &nbsp;Paul Woegerer &lt;paul_woe=
gerer@mentor.com&gt;<br> &gt; + *<br> &gt; + * Permission is hereby granted=
, free of charge, to any person obtaining a<br> &gt; copy<br> &gt; + * of t=
his software and associated documentation files (the "Software"), to<br> &g=
t; deal<br> &gt; + * in the Software without restriction, including without=
 limitation the<br> &gt; rights<br> &gt; + * to use, copy, modify, merge, p=
ublish, distribute, sublicense, and/or sell<br> &gt; + * copies of the Soft=
ware, and to permit persons to whom the Software is<br> &gt; + * furnished =
to do so, subject to the following conditions:<br> &gt; + *<br> &gt; + * Th=
e above copyright notice and this permission notice shall be included<br> &=
gt; in<br> &gt; + * all copies or substantial portions of the Software.<br>=
 &gt; + *<br> &gt; + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY O=
F ANY KIND, EXPRESS<br> &gt; OR<br> &gt; + * IMPLIED, INCLUDING BUT NOT LIM=
ITED TO THE WARRANTIES OF MERCHANTABILITY,<br> &gt; + * FITNESS FOR A PARTI=
CULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL<br> &gt; THE<br> &gt; =
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER<=
br> &gt; + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE=
, ARISING<br> &gt; FROM,<br> &gt; + * OUT OF OR IN CONNECTION WITH THE SOFT=
WARE OR THE USE OR OTHER DEALINGS IN<br> &gt; THE<br> &gt; + * SOFTWARE.<br=
> &gt; + */<br> &gt; +<br> &gt; +#include &lt;stdint.h&gt;<br> &gt; +#inclu=
de &lt;unistd.h&gt;<br> &gt; +#include &lt;lttng/ust-events.h&gt;<br> &gt; =
+<br> &gt; +#define LTTNG_UST_BADDR_STATEDUMP_PROVIDER<br> &gt; +#include &=
lt;lttng/tracepoint.h&gt;<br> &gt; +<br> &gt; +TRACEPOINT_EVENT(ust_baddr_s=
tatedump, soinfo,<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; TP_ARGS(struct lttng_session *, session, void *, baddr, const cha=
r*,<br> &gt; sopath, int64_t, size, int64_t, mtime),<br> &gt; + &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TP_FIELDS(<br> &gt; + &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_integer_hex(void *, baddr, baddr)<br=
> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_string(sopath, sopa=
th)<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_integer(int64=
_t, size, size)<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_i=
nteger(int64_t, mtime, mtime)<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; )<br> &gt; +)<br> &gt; +<br> &gt; +#endif /* _TRACEPO=
INT_UST_BADDR_STATEDUMP_H */<br> &gt; +<br> &gt; +#undef TRACEPOINT_INCLUDE=
<br> &gt; +#define TRACEPOINT_INCLUDE "./ust_baddr_statedump.h"<br> &gt; +<=
br> &gt; +/* This part must be outside ifdef protection */<br> &gt; +#inclu=
de &lt;lttng/tracepoint-event.h&gt;<br> &gt; +<br> &gt; +#ifdef __cplusplus=
<br> &gt; +}<br> &gt; +#endif<br> &gt; diff --git a/liblttng-ust/lttng-even=
ts.c b/liblttng-ust/lttng-events.c<br> &gt; index 26601a6..21e3639 100644<b=
r> &gt; --- a/liblttng-ust/lttng-events.c<br> &gt; +++ b/liblttng-ust/lttng=
-events.c<br> &gt; @@ -293,6 +293,8 @@ int lttng_session_enable(struct lttn=
g_session *session)<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; /* Set atomically the state to "active" */<br> &gt; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; CMM_ACCESS_ONCE(se=
ssion-&gt;active) =3D 1;<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; CMM_ACCESS_ONCE(session-&gt;been_active) =3D 1;<br> &=
gt; +<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lt=
tng_ust_sockinfo_session_enabled(session-&gt;owner, session);<br> &gt; &nbs=
p;end:<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; return ret;<br> &gt; &nbsp;}<br> &gt; diff --git a/liblttng-ust/lttng-t=
racer-core.h<br> &gt; b/liblttng-ust/lttng-tracer-core.h<br> &gt; index f64=
3a7e..e7f549e 100644<br> &gt; --- a/liblttng-ust/lttng-tracer-core.h<br> &g=
t; +++ b/liblttng-ust/lttng-tracer-core.h<br> &gt; @@ -45,4 +45,7 @@ const =
char *lttng_ust_obj_get_name(int id);<br> &gt; &nbsp;<br> &gt; &nbsp;int lt=
tng_get_notify_socket(void *owner);<br> &gt; &nbsp;<br> &gt; +void lttng_us=
t_sockinfo_session_enabled(void *owner,<br> &gt; + &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp;struct lttng_session *session_enabled);<br> &gt; +<br> &=
gt; &nbsp;#endif /* _LTTNG_TRACER_CORE_H */<br> &gt; diff --git a/liblttng-=
ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c<br> &gt; index a6e4ba3=
..6ef3006 100644<br> &gt; --- a/liblttng-ust/lttng-ust-comm.c<br> &gt; +++ =
b/liblttng-ust/lttng-ust-comm.c<br> &gt; @@ -34,6 +34,7 @@<br> &gt; &nbsp;#=
include &lt;time.h&gt;<br> &gt; &nbsp;#include &lt;assert.h&gt;<br> &gt; &n=
bsp;#include &lt;signal.h&gt;<br> &gt; +#include &lt;dlfcn.h&gt;<br> &gt; &=
nbsp;#include &lt;urcu/uatomic.h&gt;<br> &gt; &nbsp;#include &lt;urcu/futex=
.h&gt;<br> &gt; &nbsp;#include &lt;urcu/compiler.h&gt;<br> &gt; @@ -106,6 +=
107,7 @@ struct sock_info {<br> &gt; &nbsp;<br> &gt; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; char wait_shm_path[PATH_MAX];<br> =
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; char *w=
ait_shm_mmap;<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; struct lttng_session *session_enabled;<br> &gt; &nbsp;};<br> &gt; &nb=
sp;<br> &gt; &nbsp;/* Socket from app (connect) to session daemon (listen) =
for communication */<br> &gt; @@ -122,6 +124,8 @@ struct sock_info global_a=
pps =3D {<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; .notify_socket =3D -1,<br> &gt; &nbsp;<br> &gt; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .wait_shm_path =3D "/" LTTNG_UST=
_WAIT_FILENAME,<br> &gt; +<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; .session_enabled =3D NULL,<br> &gt; &nbsp;};<br> &gt; &n=
bsp;<br> &gt; &nbsp;/* TODO: allow global_apps_sock_path override */<br> &g=
t; @@ -135,6 +139,8 @@ struct sock_info local_apps =3D {<br> &gt; &nbsp;<br=
> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .sock=
et =3D -1,<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; .notify_socket =3D -1,<br> &gt; +<br> &gt; + &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .session_enabled =3D NULL,<br> &gt; &nbsp=
;};<br> &gt; &nbsp;<br> &gt; &nbsp;static int wait_poll_fallback;<br> &gt; =
@@ -176,6 +182,7 @@ static const char *cmd_name_mapping[] =3D {<br> &gt; &n=
bsp;<br> &gt; &nbsp;static const char *str_timeout;<br> &gt; &nbsp;static i=
nt got_timeout_env;<br> &gt; +static void *ust_baddr_handle;<br> &gt; &nbsp=
;<br> &gt; &nbsp;extern void lttng_ring_buffer_client_overwrite_init(void);=
<br> &gt; &nbsp;extern void lttng_ring_buffer_client_overwrite_rt_init(void=
);<br> &gt; @@ -235,6 +242,39 @@ void print_cmd(int cmd, int handle)<br> &g=
t; &nbsp;}<br> &gt; &nbsp;<br> &gt; &nbsp;static<br> &gt; +void *lttng_ust_=
baddr_handle(void)<br> &gt; +{<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; if (!ust_baddr_handle) {<br> &gt; + &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;ust_baddr_handle =3D dlopen(<br> &gt; + &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; "liblttng-ust-baddr.so.0", RTLD_NOW | RTLD_GLOBAL);<br> &g=
t; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ust_baddr_handle =3D=3D=
 NULL)<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ERR("%s", dlerror());<br> &gt; +=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br> &gt; + &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return ust_baddr_handle;=
<br> &gt; +}<br> &gt; +<br> &gt; +static<br> &gt; +int lttng_ust_baddr_stat=
edump(struct lttng_session *session)<br> &gt; +{<br> &gt; + &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; static<br> &gt; + &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int (*lttng_ust_baddr_init_fn)(stru=
ct lttng_session *);<br> &gt; +<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; if (!lttng_ust_baddr_init_fn) {<br> &gt; + &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;void *baddr_handle =3D lttng_ust_baddr_h=
andle();<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (baddr_ha=
ndle) {<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng_ust_baddr_init_fn =3D dls=
ym(baddr_handle,<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"lttng_ust_baddr_statedump");<br> &=
gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; if (lttng_ust_baddr_init_fn =3D=3D NULL)<br>=
 &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;ERR("%s", dlerror());<br> &gt; + &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp;}<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;if (!lttng_ust_baddr_init_fn)<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return =
-1;<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br=
> &gt; +<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 return lttng_ust_baddr_init_fn(session);<br> &gt; +}<br> &gt; +<br> &gt; +=
static<br> &gt; &nbsp;int setup_local_apps(void)<br> &gt; &nbsp;{<br> &gt; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; const char *=
home_dir;<br> &gt; @@ -1143,6 +1183,13 @@ restart:<br> &gt; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; ret =3D handle_message(sock_info, sock, &amp;lum);<br> &gt=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ret) {<br> &gt; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ER=
R("Error handling message for %s socket", sock_info-&gt;name);<br> &gt; + &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; } else {<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct lttng_sessio=
n *session =3D<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; sock_info-&gt;session_enabled;<br> &gt; + &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;i=
f (session) {<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; sock_info-&gt;session_enabled =3D NULL;<br> &gt; + &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng_ust_b=
addr_statedump(session);<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br> &gt; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; }<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; continue;<br> &g=
t; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;default:<br> &gt; @@ -=
1379,6 +1426,12 @@ void __attribute__((destructor)) lttng_ust_exit(void)<br=
> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;* cleanup the threads if there are stalled in a syscall.<br> &gt; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br> &gt; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng_ust_clea=
nup(1);<br> &gt; +<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; if (ust_baddr_handle) {<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp;int ret =3D dlclose(ust_baddr_handle);<br> &gt; + &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ret)<br> &gt; + &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; ERR("%s", dlerror());<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; }<br> &gt; &nbsp;}<br> &gt; &nbsp;<br> &gt; &nbsp;/*<br> &g=
t; @@ -1456,3 +1509,10 @@ void ust_after_fork_child(sigset_t *restore_sigse=
t)<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
ust_after_fork_common(restore_sigset);<br> &gt; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng_ust_init();<br> &gt; &nbsp;}<br> =
&gt; +<br> &gt; +void lttng_ust_sockinfo_session_enabled(void *owner,<br> &=
gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct lttng_session *sess=
ion_enabled)<br> &gt; +{<br> &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; struct sock_info *sock_info =3D owner;<br> &gt; + &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sock_info-&gt;session_enabl=
ed =3D session_enabled;<br> &gt; +}<br> &gt; --<br> &gt; 1.8.4.2<br> &gt; <=
br> &gt; <br> <br> -- <br> Mathieu Desnoyers<br> EfficiOS Inc.<br> </span><=
/tt><a href=3D"http://www.efficios.com/" target=3D"_blank" data-mce-href=3D=
"http://www.efficios.com/"><tt><span style=3D"font-size: small;" data-mce-s=
tyle=3D"font-size: small;" size=3D"2">http://www.efficios.com</span></tt></=
a><tt><span style=3D"font-size: small;" data-mce-style=3D"font-size: small;=
" size=3D"2"><br> <br> _______________________________________________<br> =
lttng-dev mailing list<br> lttng-dev@lists.lttng.org<br> </span></tt><a hre=
f=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_=
blank" data-mce-href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/ltt=
ng-dev"><tt><span style=3D"font-size: small;" data-mce-style=3D"font-size: =
small;" size=3D"2">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-de=
v</span></tt></a><tt><span style=3D"font-size: small;" data-mce-style=3D"fo=
nt-size: small;" size=3D"2"><br> <br> </span></tt><br></blockquote><div><br=
><br></div><div><br></div><div>-- <br></div><div><span name=3D"x"></span>Ma=
thieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"=
></span><br></div></div></body></html>
------=_Part_69586_1784249759.1384696944194--


--===============1951312098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1951312098==--
