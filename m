From: Jim Dumont <jim.dumont@ericsson.com>
Subject: Re: lttng-dev Digest, Vol 67, Issue 48
Date: Fri, 17 Jan 2014 17:26:13 +0000
Message-ID: <63008C666A72BB4F892767155D012B30390BFB4D__48859.0919798755$1389979657$gmane$org@eusaamb105.ericsson.se>
References: <mailman.1320.1384681007.2186.lttng-dev@lists.lttng.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jim.dumont@ericsson.com>) id 1W4DBY-0007Nd-8V
	for lttng-dev@lists.lttng.org; Fri, 17 Jan 2014 12:26:33 -0500
In-Reply-To: <mailman.1320.1384681007.2186.lttng-dev@lists.lttng.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi there,

Was there a follow-up to the series of questions raised by Daniel below and referenced here:

http://lists.lttng.org/pipermail/lttng-dev/2013-November/021844.html

I didn't see one in the mailing list.

BR,

/Jim

-----Original Message-----
From: lttng-dev-request@lists.lttng.org [mailto:lttng-dev-request@lists.lttng.org] 
Sent: November-17-13 4:37 AM
To: lttng-dev@lists.lttng.org
Subject: lttng-dev Digest, Vol 67, Issue 48

Send lttng-dev mailing list submissions to
	lttng-dev@lists.lttng.org

To subscribe or unsubscribe via the World Wide Web, visit
	http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
or, via email, send a message with subject or body 'help' to
	lttng-dev-request@lists.lttng.org

You can reach the person managing the list at
	lttng-dev-owner@lists.lttng.org

When replying, please edit your Subject line so it is more specific than "Re: Contents of lttng-dev digest..."


Today's Topics:

   1. Re: [RELEASE] LTTng-Tools 2.4.0-rc1 - ?poque Opaque
      (Thibault, Daniel)
   2. [RELEASE] LTTng-UST 2.4.0-rc1 (Mathieu Desnoyers)
   3. [RELEASE] LTTng modules 2.4.0-rc1 (Mathieu Desnoyers)
   4. Re: ??? how does ust tracer map share lttng buffer (David Goulet)
   5. Re: [PATCH v3 2/2] Implement base-address-state tracing
      (Amit Margalit)


----------------------------------------------------------------------

Message: 1
Date: Fri, 15 Nov 2013 20:22:34 +0000
From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] [RELEASE] LTTng-Tools 2.4.0-rc1 - ?poque
	Opaque
Message-ID:
	<48CF5AC71E61DB46B70D0F388054EFFD267A2503@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	
Content-Type: text/plain; charset="iso-8859-1"

-----Message d'origine-----
Date: Fri, 15 Nov 2013 12:27:01 -0500
From: David Goulet <dgoulet@efficios.com>

> 1) Live support. It's now possible to stream traces (kernel and UST) 
> while they being extracted meaning a relayd can now receive traces 
> live and a viewer can attach to it to process the trace while running. 
> The "--live" has been added to lttng create command that sets up a 
> live tracing session.
>
> See doc/live-reading-howto.txt and doc/live-reading-protocol.txt for 
> more detail on that feature.

   Does this mean you can't do a "live" trace to local storage?

> 2) Java Util Logging support. With a special LTTngAgent located in 
> lttng-ust project (liblttng-ust-jul) to trace JUL events and gather 
> UST traces with them.
>
> The -j/--jul domain has been added to lttng command line so you can 
> list the possible JUL Logger object and enable/disable them. It is the 
> same as using the UST or Kernel domain.
>
> As of now, filters and loglevel are ignored with the JUL domain.

   Saying "It is the same as using the UST or Kernel domain" leaves a lot of questions unanswered, since the kernel and user-space behave *very* differently on a lot of points.

1) Does --jul require root privileges?
2) I suppose the various commands have --kernel pre-empting --userspace pre-empting --ul?
3) add-context: does --jul have the same possible context types as --userspace (i.e. ip, pthread_id, procname, vpid, vtid)?
4) enable-channel:
4.1) Are the --jul --subbuf-size, --num-subbuf and --read-timer defaults the same as with --userspace?
4.2) Presumably --output can only be mmap?
4.3) Are the --jul buffering schemes the same as with --userspace (i.e. --buffers-pid and --buffers-uid)?
4.4) If yes, won't they all degenerate to the virtual machine's user and process IDs?
5) enable-event:
5.1) Can you assign --jul events to multiple channels like you can in --userspace?
5.2) Is the --jul event type --tracepoint or something else entirely?
5.3) Can the trailing wild card (and exclusion option) be used in the event name when enabling/disabling --jul events?
6) list: Does bug #654 also apply to --jul?

Daniel U. Thibault
Protection des syst?mes et contremesures (PSC) | Systems Protection & Countermeasures (SPC) Cyber s?curit? pour les missions essentielles (CME) | Mission Critical Cyber Security (MCCS) R & D pour la d?fense Canada - Valcartier (RDDC Valcartier) | Defence R&D Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu?bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=918V%20QSDJ>
Gouvernement du Canada | Government of Canada <http://www.valcartier.drdc-rddc.gc.ca/>



------------------------------

Message: 2
Date: Fri, 15 Nov 2013 21:10:00 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] [RELEASE] LTTng-UST 2.4.0-rc1
Message-ID:
	<661952664.68956.1384549800533.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer, is port of the low-overhead tracing capabilities of the LTTng kernel tracer to user-space. The library "liblttng-ust" enables tracing of applications and libraries.

Main changes: Java Util Logging support, live streaming support, event "excluders" (courtesy of Mentor), base address tracing for symbol lookup (courtesy of Mentor).

Changelog:
2013-11-15 lttng-ust 2.4.0-rc1
        * doc/examples: error out when a subdir make fails
        * JUL: fix out of tree build
        * Java/jul: fix make dist
        * JUL: install documentation and jar file
        * Add missing copyrights to test scripts
        * Escape minus signs in lttng-ust-cyg-profile manpage
        * Fix spelling mistake in lttng-ust manpage
        * Fix tests/benchmark
        * Implement base-address-state tracing
        * Base-address tracing for dlopen and dlclose
        * Add a check against excluders
        * Add handler for LTTNG_UST_EXCLUSION in UST ABI
        * Store exclusions to enablers
        * Add excluders to enabler structure
        * Send exclusion data through ustcomm
        * Define exclusion structure for UST ABI
        * Define a new command LTTNG_UST_EXCLUSION
        * Fix: package of LTTngUst.h was renamed without renaming target in makefile
        * Fix: check for java .class in package subfolders
        * Fix: java library to use user define JDK at compile time
        * Add liblttng-ust-jul for JUL support
        * Fix: application SIGBUS when starting in parallel with sessiond
        * Fix: Minor corrections to the lttng-ust man page
        * Documentation cleanup: Overhaul of the lttng-gen-tp man page
        * Warning cleanup: add missing padding initializer
        * Fix: socket connect hang on heavy loads
        * Cleanup: fix typo
        * Fix: ust-comm recvmsg should handle partial receive
        * gcc warning fix: -Wextra
        * Add usage reference count for tracepoints
        * tracepoint.c: Move add_callsite/remove_callsite further down in file
        * Store the callsites into the library callsite list
        * Fix linking warning
        * Per-stream ioctl to get the current timestamp
        * LTTng ringbuffer ABI calls for index generation
        * Specialize lttng_ust_lib_ring_buffer_client_cb
        * Add tracing instrumentation for pthread mutex lock functions

Project website: http://lttng.org
Download link: http://lttng.org/download (please refer to the README file for installation instructions)

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com



------------------------------

Message: 3
Date: Fri, 15 Nov 2013 21:12:06 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] [RELEASE] LTTng modules 2.4.0-rc1
Message-ID:
	<1022030442.68961.1384549926154.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.x tracer toolset.

Major changes: live streaming support, index generation by consumerd support, 3.12 Linux kernel support.

Changelog:
2013-11-15 LTTng modules 2.4.0-rc1
        * Update ext4 instrumentation to Linux 3.12
        * Update RCU instrumentation to Linux 3.12
        * Update btrfs instrumentation to 3.12 kernel
        * Update vmscan instrumentation to Linux 3.12
        * update: kmem instrumentation 3.12 kernel support
        * lttng-statedump-impl: Use generic hard irqs for Linux >= 3.12
        * lttng-statedump-impl: Fix lttng_list_interrupts for empty implementation
        * Import fix from LTSI: 3.4+ RT kernels use CONFIG_PREEMPT_RT_FULL
        * Add new tracepoint in KVM
        * Blacklist kernels 3.10.13 and 3.11.2
        * LTTng trace-clock: shrink kernel blacklist
        * Metadata flush writes data from the cache
        * Per-stream ioctl to get the current timestamp
        * LTTng ringbuffer ABI calls for index generation
        * Prepare LTTng override of ring buffer fops
        * Blacklist Linux kernels 3.10+

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com



------------------------------

Message: 4
Date: Sat, 16 Nov 2013 08:42:15 -0500
From: David Goulet <dgoulet@efficios.com>
To: ??? <39017736@qq.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] ??? how does ust tracer map share lttng
	buffer
Message-ID: <20131116134215.GA7300@thessa>
Content-Type: text/plain; charset="utf-8"

On 16 Nov (07:18:45), ??? wrote:
> >Indeed, from a sessiond point of view, this will typically use the same FD number, but it's really associated with a different posix SHM each time.
> 
> 
>   Yes,what confused me the most is that sessiond sends the same FD number to UST every time,but UST receives the different FD number each time and can map it to the right per-cpu share buffer sucessfully.

Yes, in per UID buffers, for every application using UST we send the FD
corresponding to the already allocated buffer (being per UID).

Please note that sending a FD through a Unix socket dups it so basically
UST receives that, access the shared memory buffer and can then operate
correctly.

Cheers!
David

> 
> 
> Thanks
> MuXiu.Cao
> 
> 
> 
> 
> 
> From: "???" <39017736@qq.com>
> To: "mathieu.desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Friday, November 15, 2013 11:37:11 AM
> Subject: how does ust tracer map share lttng buffer
> 
> 
> Hi,Mathieu
> 
> 
>    After lttng sub-command enable-event is issued at first time, lttng-consumerd will be informed by lttng-sessiond to open and mmap share memory regions .Then lttng-sessiond get all shmfds from lttng-consumerd.But how does ust tracer map to these share memory regions?
> 
> 
>   AFAIK,lttng-sessiond will call  do_consumer_create_channel()  ,then send_channel_uid_to_ust(). What's confused me is in send_channel_uid_to_ust(),lttng-sessiond dup() one shmfd , then ust_consumer_send_stream_to_ust() to ust tracer, then close the shmfd and loop all shmfds. So all duped fds are the same fd-number (say A)and send to ust tracer through ust_consumer_send_stream_to_ust()->ustctl_send_stream_to_ust()->ustctl_send_stream()->ustcomm_send_fds_unix_sock()(unix socket is $HOME/.lttng/lttng-ust-sock-5).Why does it send the same fds to ust tracer?
>   At ust tracer side,it calls handle_message()->ustcomm_recv_stream_from_sessiond() and mmap every received fd to share memory region.However,every received fd is different from A.So I must miss something anywhere.How does ust tracer map share lttng buffer?
> 
> 
> In lttng-sessiond, we send file descriptors for each posix SHM associated to every per-cpu buffer to the application over unix socket. So it's more or less : receive FD from consumer, send FD over unix socket to UST, close FD (we loop on this). Indeed, from a sessiond point of view, this will typically use the same FD number, but it's really associated with a different posix SHM each time. David can probably answer your question in more detail.
> 
> 
> 
> Thanks,
> 
> 
> 
> Mathieu
> 
> 
> 
> 
> 
> 
> 
> PS:code is from lttng-2.3.0 .
> 
> 
> Thanks
> MuXiu.Cao
> 
> 
> 
> 
> 
> 
> 
> -- 
> 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 620 bytes
Desc: Digital signature
URL: <http://lists.lttng.org/pipermail/lttng-dev/attachments/20131116/afbf97a4/attachment-0001.pgp>

------------------------------

Message: 5
Date: Sun, 17 Nov 2013 11:36:19 +0200
From: Amit Margalit <AMITM@il.ibm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] [PATCH v3 2/2] Implement base-address-state
	tracing
Message-ID:
	<OF5EA7C09A.2F75FE97-ONC2257C26.00348FD3-C2257C26.0034C2F3@il.ibm.com>
Content-Type: text/plain; charset="us-ascii"

I guess I missed something in the discussion - is this going to be active 
all the time, or can I disable it somehow?

Maybe a command-line switch to turn this off?

For me this is overhead that I don't need and don't want.

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Paul Woegerer <paul_woegerer@mentor.com>
Cc:     lttng-dev@lists.lttng.org
Date:   11/14/2013 09:30 PM
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
> __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args))   \
>                                                                      \
>                if (0)                \
>                                (void) __dynamic_len_idx; /* don't warn 
if unused */    \
> +              if (!_TP_SESSION_CHECK(session, __chan->session))   \
> +                              return;       \
>                if 
(caa_unlikely(!CMM_ACCESS_ONCE(__chan->session->active)))     \
>                                return;       \
>                if (caa_unlikely(!CMM_ACCESS_ONCE(__chan->enabled)))    \
> diff --git a/liblttng-ust-baddr/Makefile.am 
b/liblttng-ust-baddr/Makefile.am
> index afa9489..0d3cf28 100644
> --- a/liblttng-ust-baddr/Makefile.am
> +++ b/liblttng-ust-baddr/Makefile.am
> @@ -5,7 +5,9 @@ lib_LTLIBRARIES = liblttng-ust-baddr.la
>  liblttng_ust_baddr_la_SOURCES = \
>                lttng-ust-baddr.c \
>                ust_baddr.c \
> -              ust_baddr.h
> +              ust_baddr.h \
> +              ust_baddr_statedump.c \
> +              ust_baddr_statedump.h
>  liblttng_ust_baddr_la_LIBADD = \
>                -L$(top_builddir)/liblttng-ust/.libs \
>                -llttng-ust
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
>                tracepoint(ust_baddr, pop, so_base);
>                return 0;
>  }
> +
> +static int
> +extract_soinfo_events(struct dl_phdr_info *info, size_t size, void 
*data)
> +{
> +              int j;
> +              int num_loadable_segment = 0;
> +
> +              for (j = 0; j < info->dlpi_phnum; j++) {
> +                              char resolved_path[PATH_MAX];
> +                              struct stat sostat;
> +                              void *base_addr_ptr;
> +
> +                              if (info->dlpi_phdr[j].p_type != PT_LOAD)
> +                                              continue;
> +
> +                              /* Calculate virtual memory address of 
the loadable segment */
> +                              base_addr_ptr = (void *) info->dlpi_addr
> +                                              + 
info->dlpi_phdr[j].p_vaddr;
> +
> +                              num_loadable_segment += 1;
> +                              if ((info->dlpi_name == NULL || 
info->dlpi_name[0] == 0)
> +                                                              && 
num_loadable_segment == 1) {
> +                                              /*
> +                                               * If the iterated 
element is the executable itself we
> +                                               * have to use Dl_info to 
determine its full path
> +                                               */
> +                                              Dl_info dl_info = { 0 };
> +                                              if 
(!dladdr(base_addr_ptr, &dl_info))
> +                                                              return 0;
> +                                              if 
(!realpath(dl_info.dli_fname, resolved_path))
> +                                                              return 0;
> +                              } else {
> +                                              /*
> +                                               * For regular 
dl_phdr_info entries we have to check if
> +                                               * the path to the shared 
object really exists
> +                                               */
> +                                              if 
(!realpath(info->dlpi_name, resolved_path)) {
> +                                                              /* Found 
vDSO, put the 'path' into brackets */
> + snprintf(resolved_path, PATH_MAX - 1, "[%s]",
> +              info->dlpi_name);
> +                                              }
> +                              }
> +
> +                              if (stat(resolved_path, &sostat)) {
> +                                              sostat.st_size = 0;
> +                                              sostat.st_mtime = -1;
> +                              }
> +
> +                              tracepoint(ust_baddr_statedump, soinfo,
> +                                                              (struct 
lttng_session *) data, base_addr_ptr,
> + resolved_path, sostat.st_size, sostat.st_mtime);
> +
> +                              /*
> +                               * We are only interested in the base 
address (lowest virtual
> +                               * address associated with the memory 
image), skip the rest
> +                               */
> +                              break;
> +              }
> +              return 0;
> +}
> +
> +int
> +lttng_ust_baddr_statedump(struct lttng_session *session)
> +{
> +              /*
> +               * Iterate through the list of currently loaded shared 
objects and
> +               * generate events for loadable segments using 
extract_soinfo_events
> +               */
> +              dl_iterate_phdr(extract_soinfo_events, session);
> +              return 0;
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
> +              TP_ARGS(struct lttng_session *, session, void *, baddr, 
const char*,
> sopath, int64_t, size, int64_t, mtime),
> +              TP_FIELDS(
> +                              ctf_integer_hex(void *, baddr, baddr)
> +                              ctf_string(sopath, sopath)
> +                              ctf_integer(int64_t, size, size)
> +                              ctf_integer(int64_t, mtime, mtime)
> +              )
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
>                /* Set atomically the state to "active" */
>                CMM_ACCESS_ONCE(session->active) = 1;
>                CMM_ACCESS_ONCE(session->been_active) = 1;
> +
> +              lttng_ust_sockinfo_session_enabled(session->owner, 
session);
>  end:
>                return ret;
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
> +                              struct lttng_session *session_enabled);
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
>                char wait_shm_path[PATH_MAX];
>                char *wait_shm_mmap;
> +              struct lttng_session *session_enabled;
>  };
> 
>  /* Socket from app (connect) to session daemon (listen) for 
communication */
> @@ -122,6 +124,8 @@ struct sock_info global_apps = {
>                .notify_socket = -1,
> 
>                .wait_shm_path = "/" LTTNG_UST_WAIT_FILENAME,
> +
> +              .session_enabled = NULL,
>  };
> 
>  /* TODO: allow global_apps_sock_path override */
> @@ -135,6 +139,8 @@ struct sock_info local_apps = {
> 
>                .socket = -1,
>                .notify_socket = -1,
> +
> +              .session_enabled = NULL,
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
> +              if (!ust_baddr_handle) {
> +                              ust_baddr_handle = dlopen(
> + "liblttng-ust-baddr.so.0", RTLD_NOW | RTLD_GLOBAL);
> +                              if (ust_baddr_handle == NULL)
> +                                              ERR("%s", dlerror());
> +              }
> +              return ust_baddr_handle;
> +}
> +
> +static
> +int lttng_ust_baddr_statedump(struct lttng_session *session)
> +{
> +              static
> +              int (*lttng_ust_baddr_init_fn)(struct lttng_session *);
> +
> +              if (!lttng_ust_baddr_init_fn) {
> +                              void *baddr_handle = 
lttng_ust_baddr_handle();
> +                              if (baddr_handle) {
> +                                              lttng_ust_baddr_init_fn = 
dlsym(baddr_handle,
> + "lttng_ust_baddr_statedump");
> +                                              if 
(lttng_ust_baddr_init_fn == NULL)
> +                                                              ERR("%s", 
dlerror());
> +                              }
> +                              if (!lttng_ust_baddr_init_fn)
> +                                              return -1;
> +              }
> +
> +              return lttng_ust_baddr_init_fn(session);
> +}
> +
> +static
>  int setup_local_apps(void)
>  {
>                const char *home_dir;
> @@ -1143,6 +1183,13 @@ restart:
>                                                ret = 
handle_message(sock_info, sock, &lum);
>                                                if (ret) {
> ERR("Error handling message for %s socket", sock_info->name);
> +                                              } else {
> +                                                              struct 
lttng_session *session =
> +  sock_info->session_enabled;
> +                                                              if 
(session) {
> +  sock_info->session_enabled = NULL;
> +  lttng_ust_baddr_statedump(session);
> +                                                              }
>                                                }
>                                                continue;
>                                default:
> @@ -1379,6 +1426,12 @@ void __attribute__((destructor)) 
lttng_ust_exit(void)
>                 * cleanup the threads if there are stalled in a syscall.
>                 */
>                lttng_ust_cleanup(1);
> +
> +              if (ust_baddr_handle) {
> +                              int ret = dlclose(ust_baddr_handle);
> +                              if (ret)
> +                                              ERR("%s", dlerror());
> +              }
>  }
> 
>  /*
> @@ -1456,3 +1509,10 @@ void ust_after_fork_child(sigset_t 
*restore_sigset)
>                ust_after_fork_common(restore_sigset);
>                lttng_ust_init();
>  }
> +
> +void lttng_ust_sockinfo_session_enabled(void *owner,
> +                              struct lttng_session *session_enabled)
> +{
> +              struct sock_info *sock_info = owner;
> +              sock_info->session_enabled = session_enabled;
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


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.lttng.org/pipermail/lttng-dev/attachments/20131117/1387c63e/attachment.html>

------------------------------

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


End of lttng-dev Digest, Vol 67, Issue 48
*****************************************
