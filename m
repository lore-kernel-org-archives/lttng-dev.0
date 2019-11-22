From: Norbert Lange <nolange79@gmail.com>
Subject: Re: Using lttng-ust with xenomai
Date: Fri, 22 Nov 2019 18:44:58 +0100
Message-ID: <CADYdroOh+T8pOcNBW74KSMfCh--ujD8L3_G96LWR1migpsUq0g__22261.3542153098$1574444727$gmane$org@mail.gmail.com>
References: <CADYdroN-i9yrpd-wjPSW36GUptRV+kOCJT=Yv6+Z5sCVBmo_SQ@mail.gmail.com>
 <2012667816.853.1574437363737.JavaMail.zimbra@efficios.com>
 <4aab99be-5451-4582-f75d-7637614b1d37@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 by lists.lttng.org (Postfix) with ESMTPS id 47KP2t12v0z1Ryp
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 12:45:10 -0500 (EST)
Received: by mail-io1-xd43.google.com with SMTP id 1so8988019iou.4
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 09:45:09 -0800 (PST)
In-Reply-To: <4aab99be-5451-4582-f75d-7637614b1d37@siemens.com>
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

Am Fr., 22. Nov. 2019 um 16:52 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>
> On 22.11.19 16:42, Mathieu Desnoyers wrote:
> > ----- On Nov 22, 2019, at 4:14 AM, Norbert Lange nolange79@gmail.com wrote:
> >
> >> Hello,
> >>
> >> I already started a thread over at xenomai.org [1], but I guess its
> >> more efficient to ask here aswell.
> >> The basic concept is that xenomai thread run *below* Linux (threads
> >> and irg handlers), which means that xenomai threads must not use any
> >
> > I guess you mean "irq handlers" here.
> >
> >> linux services like the futex syscall or socket communication.
> >>
> >> ## tracepoints
> >>
> >> expecting that tracepoints are the only thing that should be used from
> >> the xenomai threads, is there anything using linux services.
> >> the "bulletproof" urcu apparently does not need anything for the
> >> reader lock (aslong as the thread is already registered),
> >
> > Indeed the first time the urcu-bp read-lock is encountered by a thread,
> > the thread registration is performed, which requires locks, memory allocation,
> > and so on. After that, the thread can use urcu-bp read-side lock without
> > requiring any system call.
>
> So, we will probably want to perform such a registration unconditionally
> (in case lttng usage is enabled) for our RT threads during their setup.

Who is we? Do you plan to add automatic support at xenomai mainline?

But yes, some setup is likely needed if one wants to use lttng


> >
> > That's indeed a good point. I suspect membarrier may not send any IPI
> > to Xenomai threads (that would have to be confirmed). I suspect the
> > latency introduced by this IPI would be unwanted.
>
> Is an "IPI" a POSIX signal here? Or are real IPI that delivers an
> interrupt to Linux on another CPU? The latter would still be possible,
> but it would be delayed until all Xenomai threads on that core eventual
> took a break (which should happen a couple of times per second under
> normal conditions - 100% RT load is an illegal application state).

Not POSIX, some inter-thread interrupts. point is the syscall waits
for the set of
registered *running* Linux threads. I doubt Xenomai threads can be reached that
way, the shadow Linux thread will be idle and it won't block.
I dont think its worth extending this syscall (seems rather dangerous actually,
given that I had some deadlocks with other "lazy schemes", see below)

>
> >
> >> liburcu has configure options allow forcing the usage of this syscall
> >> but not disabling it, which likely is necessary for Xenomai.
> >
> > I suspect what you'd need there is a way to allow a process to tell
> > liburcu-bp (or liburcu) to always use the fall-back mechanism which does
> > not rely on sys_membarrier. This could be allowed before the first use of
> > the library. I think extending the liburcu APIs to allow this should be
> > straightforward enough. This approach would be more flexible than requiring
> > liburcu to be specialized at configure time. This new API would return an error
> > if invoked with a liburcu library compiled with --disable-sys-membarrier-fallback.
> >
> > If you have control over your entire system's kernel, you may want to try
> > just configuring the kernel within CONFIG_MEMBARRIER=n in the meantime.
> >
> > Another thing to make sure is to have a glibc and Linux kernel which perform
> > clock_gettime() as vDSO for the monotonic clock, because you don't want a
> > system call there. If that does not work for you, you can alternatively
> > implement your own lttng-ust and lttng-modules clock plugin .so/.ko to override
> > the clock used by lttng, and for instance use TSC directly. See for instance
> > the lttng-ust(3) LTTNG_UST_CLOCK_PLUGIN environment variable.
>
> clock_gettime & Co for a Xenomai application is syscall-free as well.

Yes, and that gave me a deadlock already, if a library us not compiled
for Xenomai,
it will either use the syscall (and you detect that immediatly) or it
will work most of the time,
and lock up once in a while if a Linux thread took the "writer lock"
of the VDSO structures
and your high priority xenomai thread is busy waiting infinitely.

Only sane approach would be to use either the xenomai function directly,
or recreate the function (rdtsc + interpolation on x86).
Either compiling/patching lttng for Cobalt (which I really would not
want to do) or using a
clock plugin.
If the later is supposed to be minimal, then that would mean I would
have to get the
interpolation factors cobalt uses (without bringing in libcobalt).

Btw. the Xenomai and Linux monotonic clocks arent synchronised at all
AFAIK, so timestamps will
be different to the rest of Linux.
On my last plattform I did some tracing using internal stamp and
regulary wrote a
block with internal and external timestamps so those could be
converted "offline".
Anything similar with lttng or tools handling the traces?

regards, Norbert
