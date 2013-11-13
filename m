From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 0/2] Shared object base address
 tracing
Date: Wed, 13 Nov 2013 13:19:15 +0000 (UTC)
Message-ID: <1104913472.66201.1384348755089.JavaMail.zimbra__12878.5191140652$1384348819$gmane$org@efficios.com>
References: <1384183688-19038-1-git-send-email-paul_woegerer@mentor.com>
	<52828889.6030403@voxpopuli.im> <52834DB8.5030004@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VgaLn-0007ve-Hg
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 08:19:22 -0500
In-Reply-To: <52834DB8.5030004@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Paul Woegerer" <Paul_Woegerer@mentor.com>
> To: "Alexandre Montplaisir" <alexmonthy@voxpopuli.im>, "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, "Matthew
> Khouzam" <matthew.khouzam@ericsson.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Wednesday, November 13, 2013 5:00:24 AM
> Subject: Re: [lttng-dev] [PATCH lttng-ust 0/2] Shared object base address tracing
> 
> On 11/12/2013 08:59 PM, Alexandre Montplaisir wrote:
> > Hi Paul,
> >
> > I tried your patches. It seems to work quite well!
> 
> Glad to hear that :)
> 
> > - The events are called "ust_baddr:push" and "ust_baddr:pop". To be
> > consistent with the other wrapper libraries in UST, perhaps they should
> > be called "ust_dl:dlopen" and "ust_dl:dlclose" or similar?
> 
> I leave this up to Mathieu.
> I don't mind changing the names to whatever makes most sense for LTTng.

Since we're really talking about base addresses here, and that when we have multiple dlopen of the same library, I think it really makes sense to talk of "push/pop" of base address rather than to explicitly tie this to dlopen/dlclose.

> 
> > - Why does the "statedump" event seem to give many more libs than the
> > "push" events? Could we be missing some dlopen's? For example, I traced
> > glxgears by preloading liblttng-ust-dl.so: http://pastebin.com/HKVa9a4T
> 
> Since ust_baddr:push/pop is based on LD_PRELOAD'ing dlopen/dlclose it
> can only tell you what shared libraries were opened/closed during the
> time you are actually tracing the application. Whatever is
> dlopen'ed/dlclose'ed before the tracing infrastructure that is part of
> the userspace application (lttng-ust) is becoming fully functional
> therefore cannot be captured as ust_baddr:push/pop events.
> 
> For that reason we have the statedump mechanism (*) that complements
> shared object tracing by telling us what was happening (in respect to
> shared library loading) *before* we started (or before we were able) to
> trace calls to dlopen/dlclose. Only the two complementary approaches
> combined together give you the full picture of shared library loading.
> 
> (*) The statedump mechanism iterates the currently open shared objects
> with dl_iterate_phdr (see: http://linux.die.net/man/3/dl_iterate_phdr).
> 
> BTW, I get a slight different result when I trace glxgears (see attached
> glxgears_baddr.txt). I wonder what the reason is.
> 
> > - As Matthew suggested, we could also hijack dlsym(), and with its
> > parameters we could match a symbol name to an address. This becomes
> > immensely useful when coupled with the ust-cyg-profile instrumentation,
> > so we can get information about about function names directly in the
> > trace! (but ironically, only for the dlopened libraries, and not the
> > main binary). What do you think of this approach?
> 
> IMHO, hijacking dlsym() is not helping. The only thing you would know is
> that somewhere in your code for some reason the address for some symbol
> was requested via dlsym(). This will not help you to get symbol
> resolution for ust-cyg-profile instrumentation.

Agreed. AFAIK, instrumenting dlsym() is useless.

Thanks,

Mathieu

> 
> In fact, the solution I present already contains all the information
> needed to provide full symbol resolution for any address during the
> whole lifetime of the traced application. To prove that I have attached
> a dump of our trace viewer that shows all the symbols resolved for a
> small forking web server example (traced with ust-cyg-profile and custom
> tracepoints + ip context enabled) . See attached server_sample.csv and
> server_sample_resolved.csv.
> 
> > In any case, it's quite interesting!
> 
> Thanks!
> 
> --
> Paul
> 
> >
> > Cheers,
> > Alexandre
> >
> >
> >
> > On 13-11-11 10:28 AM, Paul Woegerer wrote:
> >> The following two patches implement https://bugs.lttng.org/issues/474
> >>
> >> The first patch provides tracing of dlopen/dlclose calls with the use of
> >> an
> >> LD_PRELOAD library (liblttng-ust-dl.so) using the following events:
> >>
> >>  ust_baddr:push(void *baddr, const char*sopath, int64_t size, int64_t
> >>  mtime)
> >>  ust_baddr:pop(void *baddr)
> >>
> >> The second patch adds support for tracing the whole state of currently
> >> loaded
> >> shared objects at session-enable time. The corresponding events are only
> >> emitted into the session that got enabled. The following event is used:
> >>
> >>  ust_baddr_statedump (same args as ust_baddr:push)
> >>
> >>
> >> Paul Woegerer (2):
> >>   Base-address tracing for dlopen and dlclose
> >>   Implement base-address-state tracing
> >>
> >>  Makefile.am                              |   2 +
> >>  configure.ac                             |   2 +
> >>  include/Makefile.am                      |   1 +
> >>  include/lttng/tracepoint.h               |  12 +--
> >>  include/lttng/ust-dl.h                   |  54 ++++++++++++
> >>  include/lttng/ust-tracepoint-event.h     |  14 +++
> >>  liblttng-ust-baddr/Makefile.am           |  20 +++++
> >>  liblttng-ust-baddr/lttng-ust-baddr.c     | 111 ++++++++++++++++++++++++
> >>  liblttng-ust-baddr/ust_baddr.c           |  20 +++++
> >>  liblttng-ust-baddr/ust_baddr.h           |  66 ++++++++++++++
> >>  liblttng-ust-baddr/ust_baddr_statedump.c |  21 +++++
> >>  liblttng-ust-baddr/ust_baddr_statedump.h |  60 +++++++++++++
> >>  liblttng-ust-dl/Makefile.am              |  17 ++++
> >>  liblttng-ust-dl/ustdl.c                  | 144
> >>  +++++++++++++++++++++++++++++++
> >>  liblttng-ust/lttng-events.c              |  10 +++
> >>  liblttng-ust/lttng-tracer-core.h         |   2 +
> >>  liblttng-ust/lttng-ust-comm.c            |  52 +++++++++++
> >>  17 files changed, 603 insertions(+), 5 deletions(-)
> >>  create mode 100644 include/lttng/ust-dl.h
> >>  create mode 100644 liblttng-ust-baddr/Makefile.am
> >>  create mode 100644 liblttng-ust-baddr/lttng-ust-baddr.c
> >>  create mode 100644 liblttng-ust-baddr/ust_baddr.c
> >>  create mode 100644 liblttng-ust-baddr/ust_baddr.h
> >>  create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.c
> >>  create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.h
> >>  create mode 100644 liblttng-ust-dl/Makefile.am
> >>  create mode 100644 liblttng-ust-dl/ustdl.c
> >>
> 
> 
> --
> Paul Woegerer, SW Development Engineer
> Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
> Mentor Graphics, Embedded Software Division
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
