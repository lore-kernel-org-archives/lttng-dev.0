From: Norbert Lange <nolange79@gmail.com>
Subject: Re: Using lttng-ust with xenomai
Date: Fri, 22 Nov 2019 22:38:12 +0100
Message-ID: <CADYdroOEBSeZ3Hjs0mTLx2n8+G-zREXG+Np95mJhnjWXUFbEAg__21425.8339184866$1574458719$gmane$org@mail.gmail.com>
References: <CADYdroN-i9yrpd-wjPSW36GUptRV+kOCJT=Yv6+Z5sCVBmo_SQ@mail.gmail.com>
 <2012667816.853.1574437363737.JavaMail.zimbra@efficios.com>
 <4aab99be-5451-4582-f75d-7637614b1d37@siemens.com>
 <CADYdroOh+T8pOcNBW74KSMfCh--ujD8L3_G96LWR1migpsUq0g@mail.gmail.com>
 <63a51fa5-db96-9cf9-0eb3-51954ebf98f4@siemens.com>
 <CADYdroP+H3DiqCaH9o1jHxAurh_2YG_p7MK4H2kFqSoTCV0w6A@mail.gmail.com>
 <a2036ba8-c22a-e549-b68d-35524ee7f9a9@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 by lists.lttng.org (Postfix) with ESMTPS id 47KVD00F01z1SSq
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 16:38:23 -0500 (EST)
Received: by mail-il1-x143.google.com with SMTP id v17so4479948ilg.7
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 13:38:23 -0800 (PST)
In-Reply-To: <a2036ba8-c22a-e549-b68d-35524ee7f9a9@siemens.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>, Xenomai <xenomai@xenomai.org>
List-Id: lttng-dev@lists.lttng.org

> >>>>>> liburcu has configure options allow forcing the usage of this syscall
> >>>>>> but not disabling it, which likely is necessary for Xenomai.
> >>>>>
> >>>>> I suspect what you'd need there is a way to allow a process to tell
> >>>>> liburcu-bp (or liburcu) to always use the fall-back mechanism which does
> >>>>> not rely on sys_membarrier. This could be allowed before the first use of
> >>>>> the library. I think extending the liburcu APIs to allow this should be
> >>>>> straightforward enough. This approach would be more flexible than requiring
> >>>>> liburcu to be specialized at configure time. This new API would return an error
> >>>>> if invoked with a liburcu library compiled with --disable-sys-membarrier-fallback.
> >>>>>
> >>>>> If you have control over your entire system's kernel, you may want to try
> >>>>> just configuring the kernel within CONFIG_MEMBARRIER=n in the meantime.
> >>>>>
> >>>>> Another thing to make sure is to have a glibc and Linux kernel which perform
> >>>>> clock_gettime() as vDSO for the monotonic clock, because you don't want a
> >>>>> system call there. If that does not work for you, you can alternatively
> >>>>> implement your own lttng-ust and lttng-modules clock plugin .so/.ko to override
> >>>>> the clock used by lttng, and for instance use TSC directly. See for instance
> >>>>> the lttng-ust(3) LTTNG_UST_CLOCK_PLUGIN environment variable.
> >>>>
> >>>> clock_gettime & Co for a Xenomai application is syscall-free as well.
> >>>
> >>> Yes, and that gave me a deadlock already, if a library us not compiled
> >>> for Xenomai,
> >>> it will either use the syscall (and you detect that immediatly) or it
> >>> will work most of the time,
> >>> and lock up once in a while if a Linux thread took the "writer lock"
> >>> of the VDSO structures
> >>> and your high priority xenomai thread is busy waiting infinitely.
> >>>
> >>> Only sane approach would be to use either the xenomai function directly,
> >>> or recreate the function (rdtsc + interpolation on x86).
> >>
> >> rdtsc is not portable, thus a no-go.
> >
> > Its not portable, but you have equivalents on ARM, powerpc.
> > ie. "Do the same think as Xenomai"
>
> If you use existing code, I'm fine. Just not invent something "new" here.

The idea it to build the lttng plugin from the same code,
just using the things that are necessary for reading the monotonic clock

> >>> Either compiling/patching lttng for Cobalt (which I really would not
> >>> want to do) or using a
> >>> clock plugin.
> >>
> >> I suspect you will want to have at least a plugin that was built against
> >> Xenomai libs.
> >
> > That will then do alot other stuff like spwaning a printf thread.
> >
> >>
> >>> If the later is supposed to be minimal, then that would mean I would
> >>> have to get the
> >>> interpolation factors cobalt uses (without bringing in libcobalt).
> >>>
> >>> Btw. the Xenomai and Linux monotonic clocks arent synchronised at all
> >>> AFAIK, so timestamps will
> >>> be different to the rest of Linux.
> >>
> >> CLOCK_HOST_REALTIME is synchronized.
> >
> > Thats not monotonic?
>
> Yeah, it's REALTIME, in synch with CLOCK_REALTIME of Linux.
> CLOCK_MONOTONIC should have a static offset at worst. I think that could
> be resolved if it wasn't yet.

Linux CLOCK_MONOTONIC is skew corrected to increment at the same rate as
CLOCK_REALTIME.
You might have a chance with Linux CLOCK_MONOTONIC_RAW,
if you use the identical scaling method.

>
> >
> >>
> >>> On my last plattform I did some tracing using internal stamp and
> >>> regulary wrote a
> >>> block with internal and external timestamps so those could be
> >>> converted "offline".
> >>
> >> Sounds not like something we want to promote.
> >
> > This was a questing to lttng and its tool environment. I suppose we
> > werent the first
> > ones with multiple clocks in a system.
> > If anything needs to be done in Xenomai it might be a concurrent
> > readout of Linux/cobalt time(s),
> > the rest would be done offline, potentially on another system.
>
> Sure, doable, but I prefer not having to do that.

It might offer alot flexibility you don't get otherwise (without a ton of work).

Norbert
