From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: [PATCH lttng-ust 0/2] Shared object base address
 tracing
Date: Tue, 12 Nov 2013 14:59:05 -0500
Message-ID: <52828889.6030403__9409.72763714871$1384286412$gmane$org@voxpopuli.im>
References: <1384183688-19038-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1VgK7G-0006jw-S2
	for lttng-dev@lists.lttng.org; Tue, 12 Nov 2013 14:59:20 -0500
In-Reply-To: <1384183688-19038-1-git-send-email-paul_woegerer@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <paul_woegerer@mentor.com>, mathieu.desnoyers@efficios.com, Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Paul,

I tried your patches. It seems to work quite well! I had some
questions/comments:

- The events are called "ust_baddr:push" and "ust_baddr:pop". To be
consistent with the other wrapper libraries in UST, perhaps they should
be called "ust_dl:dlopen" and "ust_dl:dlclose" or similar?

- Why does the "statedump" event seem to give many more libs than the
"push" events? Could we be missing some dlopen's? For example, I traced
glxgears by preloading liblttng-ust-dl.so: http://pastebin.com/HKVa9a4T
(looks better in non-wrapped mode). If I trace before even starting the
application, why am I not getting all the dlopen'ed libararies?

- As Matthew suggested, we could also hijack dlsym(), and with its
parameters we could match a symbol name to an address. This becomes
immensely useful when coupled with the ust-cyg-profile instrumentation,
so we can get information about about function names directly in the
trace! (but ironically, only for the dlopened libraries, and not the
main binary). What do you think of this approach?

In any case, it's quite interesting!

Cheers,
Alexandre



On 13-11-11 10:28 AM, Paul Woegerer wrote:
> The following two patches implement https://bugs.lttng.org/issues/474
>
> The first patch provides tracing of dlopen/dlclose calls with the use of an
> LD_PRELOAD library (liblttng-ust-dl.so) using the following events:
>
>  ust_baddr:push(void *baddr, const char*sopath, int64_t size, int64_t mtime)
>  ust_baddr:pop(void *baddr)
>
> The second patch adds support for tracing the whole state of currently loaded
> shared objects at session-enable time. The corresponding events are only
> emitted into the session that got enabled. The following event is used: 
>
>  ust_baddr_statedump (same args as ust_baddr:push)
>
>
> Paul Woegerer (2):
>   Base-address tracing for dlopen and dlclose
>   Implement base-address-state tracing
>
>  Makefile.am                              |   2 +
>  configure.ac                             |   2 +
>  include/Makefile.am                      |   1 +
>  include/lttng/tracepoint.h               |  12 +--
>  include/lttng/ust-dl.h                   |  54 ++++++++++++
>  include/lttng/ust-tracepoint-event.h     |  14 +++
>  liblttng-ust-baddr/Makefile.am           |  20 +++++
>  liblttng-ust-baddr/lttng-ust-baddr.c     | 111 ++++++++++++++++++++++++
>  liblttng-ust-baddr/ust_baddr.c           |  20 +++++
>  liblttng-ust-baddr/ust_baddr.h           |  66 ++++++++++++++
>  liblttng-ust-baddr/ust_baddr_statedump.c |  21 +++++
>  liblttng-ust-baddr/ust_baddr_statedump.h |  60 +++++++++++++
>  liblttng-ust-dl/Makefile.am              |  17 ++++
>  liblttng-ust-dl/ustdl.c                  | 144 +++++++++++++++++++++++++++++++
>  liblttng-ust/lttng-events.c              |  10 +++
>  liblttng-ust/lttng-tracer-core.h         |   2 +
>  liblttng-ust/lttng-ust-comm.c            |  52 +++++++++++
>  17 files changed, 603 insertions(+), 5 deletions(-)
>  create mode 100644 include/lttng/ust-dl.h
>  create mode 100644 liblttng-ust-baddr/Makefile.am
>  create mode 100644 liblttng-ust-baddr/lttng-ust-baddr.c
>  create mode 100644 liblttng-ust-baddr/ust_baddr.c
>  create mode 100644 liblttng-ust-baddr/ust_baddr.h
>  create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.c
>  create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.h
>  create mode 100644 liblttng-ust-dl/Makefile.am
>  create mode 100644 liblttng-ust-dl/ustdl.c
>
