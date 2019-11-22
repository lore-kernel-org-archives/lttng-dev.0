From: Norbert Lange via Xenomai <xenomai@xenomai.org>
Subject: Re: [lttng-dev] Using lttng-ust with xenomai
Date: Fri, 22 Nov 2019 22:27:18 +0100
Message-ID: <CADYdroOCT_mT_KJ3vm+ycynVB6zyJaNn5yp=DN2MXwT1zfHkeg@mail.gmail.com>
References: <CADYdroN-i9yrpd-wjPSW36GUptRV+kOCJT=Yv6+Z5sCVBmo_SQ@mail.gmail.com>
 <2012667816.853.1574437363737.JavaMail.zimbra@efficios.com>
 <4aab99be-5451-4582-f75d-7637614b1d37@siemens.com>
 <CADYdroOh+T8pOcNBW74KSMfCh--ujD8L3_G96LWR1migpsUq0g@mail.gmail.com>
 <2088324778.1063.1574449205629.JavaMail.zimbra@efficios.com>
 <CADYdroM7acqfMym1sUbwaa773SLSzHPSni9uRxiLZbbHtteLug@mail.gmail.com>
 <547908110.1420.1574453756850.JavaMail.zimbra@efficios.com>
Reply-To: Norbert Lange <nolange79@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <xenomai-bounces@xenomai.org>
In-Reply-To: <547908110.1420.1574453756850.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Errors-To: xenomai-bounces@xenomai.org
Sender: "Xenomai" <xenomai-bounces@xenomai.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>, Xenomai <xenomai@xenomai.org>
List-Id: lttng-dev@lists.lttng.org

> >> >> > Another thing to make sure is to have a glibc and Linux kernel which perform
> >> >> > clock_gettime() as vDSO for the monotonic clock, because you don't want a
> >> >> > system call there. If that does not work for you, you can alternatively
> >> >> > implement your own lttng-ust and lttng-modules clock plugin .so/.ko to override
> >> >> > the clock used by lttng, and for instance use TSC directly. See for instance
> >> >> > the lttng-ust(3) LTTNG_UST_CLOCK_PLUGIN environment variable.
> >> >>
> >> >> clock_gettime & Co for a Xenomai application is syscall-free as well.
> >> >
> >> > Yes, and that gave me a deadlock already, if a library us not compiled
> >> > for Xenomai,
> >> > it will either use the syscall (and you detect that immediatly) or it
> >> > will work most of the time,
> >> > and lock up once in a while if a Linux thread took the "writer lock"
> >> > of the VDSO structures
> >> > and your high priority xenomai thread is busy waiting infinitely.
> >> >
> >> > Only sane approach would be to use either the xenomai function directly,
> >> > or recreate the function (rdtsc + interpolation on x86).
> >> > Either compiling/patching lttng for Cobalt (which I really would not
> >> > want to do) or using a
> >> > clock plugin.
> >> > If the later is supposed to be minimal, then that would mean I would
> >> > have to get the
> >> > interpolation factors cobalt uses (without bringing in libcobalt).
> >> >
> >> > Btw. the Xenomai and Linux monotonic clocks arent synchronised at all
> >> > AFAIK, so timestamps will
> >> > be different to the rest of Linux.
> >> > On my last plattform I did some tracing using internal stamp and
> >> > regulary wrote a
> >> > block with internal and external timestamps so those could be
> >> > converted "offline".
> >> > Anything similar with lttng or tools handling the traces?
> >>
> >> Can a Xenomai thread issue clock_gettime(CLOCK_MONOTONIC) ?
> >
> > Yes it can, if the calls goes through the VDSO, then it mostly works.
> > And once in a while deadlocks the system if a Xenomai thread waits for a
> > spinlock that the Linux kernel owns and doesnt give back as said thread will
> > not let the Linux Kernel run (as described above).
>
> Ah, yes, read seqlock can be tricky in that kind of scenario indeed.
>
> Then what we'd need is the nmi-safe monotonic clock that went into the
> Linux kernel a while ago. It's called "monotonic fast", but really what
> it does is to remove the need to use a read-seqlock. AFAIK it's not
> exposed through the vDSO at the moment though.

An easy to use, consistent clock between Linux and Xenomai? Should be
the ultimate goal.
But I think its way less intrusive to just make the existing vDSO read/writes
safe by using the same scheme of atomic modification-count +
alternating buffers.

The vDSO is weird anyway, CLOCK_MONOTONIC_RAW was missing for a long
time (or still is?).

Norbert
