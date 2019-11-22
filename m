From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Using lttng-ust with xenomai
Date: Fri, 22 Nov 2019 15:15:56 -0500 (EST)
Message-ID: <547908110.1420.1574453756850.JavaMail.zimbra__9128.71893249161$1574453783$gmane$org@efficios.com>
References: <CADYdroN-i9yrpd-wjPSW36GUptRV+kOCJT=Yv6+Z5sCVBmo_SQ@mail.gmail.com>
 <2012667816.853.1574437363737.JavaMail.zimbra@efficios.com>
 <4aab99be-5451-4582-f75d-7637614b1d37@siemens.com>
 <CADYdroOh+T8pOcNBW74KSMfCh--ujD8L3_G96LWR1migpsUq0g@mail.gmail.com>
 <2088324778.1063.1574449205629.JavaMail.zimbra@efficios.com>
 <CADYdroM7acqfMym1sUbwaa773SLSzHPSni9uRxiLZbbHtteLug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47KSNt25Kfz1SKr
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 15:15:58 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 9B9CE4130C3
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 15:15:57 -0500 (EST)
In-Reply-To: <CADYdroM7acqfMym1sUbwaa773SLSzHPSni9uRxiLZbbHtteLug@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Norbert Lange <nolange79@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>, Xenomai <xenomai@xenomai.org>
List-Id: lttng-dev@lists.lttng.org

----- On Nov 22, 2019, at 2:57 PM, Norbert Lange nolange79@gmail.com wrote:

> Am Fr., 22. Nov. 2019 um 20:00 Uhr schrieb Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com>:
>>
>> ----- On Nov 22, 2019, at 12:44 PM, Norbert Lange nolange79@gmail.com wrote:
>>
>> > Am Fr., 22. Nov. 2019 um 16:52 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>> >>
>> >> On 22.11.19 16:42, Mathieu Desnoyers wrote:
>>
>> [...]
>>
>> >
>> >
>> >> >
>> >> > That's indeed a good point. I suspect membarrier may not send any IPI
>> >> > to Xenomai threads (that would have to be confirmed). I suspect the
>> >> > latency introduced by this IPI would be unwanted.
>> >>
>> >> Is an "IPI" a POSIX signal here? Or are real IPI that delivers an
>> >> interrupt to Linux on another CPU? The latter would still be possible,
>> >> but it would be delayed until all Xenomai threads on that core eventual
>> >> took a break (which should happen a couple of times per second under
>> >> normal conditions - 100% RT load is an illegal application state).
>> >
>> > Not POSIX, some inter-thread interrupts. point is the syscall waits
>> > for the set of
>> > registered *running* Linux threads.
>>
>> Just a small clarification: the PRIVATE membarrier command does not *wait*
>> for other threads, but it rather ensures that all other running threads
>> have had IPIs that issue memory barriers before it returns.
> 
> Ok, normal linux IRQs have to wait till Xenomai gives the cores back,
> hence the waiting.

In the case of membarrier, IPIs are only sent to CPUs which runqueues
show that the currently running thread belongs to the same process
(for the PRIVATE command). So in this case we would not be sending
any IPI to the cores running Xenomai threads.

> 
>>
>> >> >
>> >> > Another thing to make sure is to have a glibc and Linux kernel which perform
>> >> > clock_gettime() as vDSO for the monotonic clock, because you don't want a
>> >> > system call there. If that does not work for you, you can alternatively
>> >> > implement your own lttng-ust and lttng-modules clock plugin .so/.ko to override
>> >> > the clock used by lttng, and for instance use TSC directly. See for instance
>> >> > the lttng-ust(3) LTTNG_UST_CLOCK_PLUGIN environment variable.
>> >>
>> >> clock_gettime & Co for a Xenomai application is syscall-free as well.
>> >
>> > Yes, and that gave me a deadlock already, if a library us not compiled
>> > for Xenomai,
>> > it will either use the syscall (and you detect that immediatly) or it
>> > will work most of the time,
>> > and lock up once in a while if a Linux thread took the "writer lock"
>> > of the VDSO structures
>> > and your high priority xenomai thread is busy waiting infinitely.
>> >
>> > Only sane approach would be to use either the xenomai function directly,
>> > or recreate the function (rdtsc + interpolation on x86).
>> > Either compiling/patching lttng for Cobalt (which I really would not
>> > want to do) or using a
>> > clock plugin.
>> > If the later is supposed to be minimal, then that would mean I would
>> > have to get the
>> > interpolation factors cobalt uses (without bringing in libcobalt).
>> >
>> > Btw. the Xenomai and Linux monotonic clocks arent synchronised at all
>> > AFAIK, so timestamps will
>> > be different to the rest of Linux.
>> > On my last plattform I did some tracing using internal stamp and
>> > regulary wrote a
>> > block with internal and external timestamps so those could be
>> > converted "offline".
>> > Anything similar with lttng or tools handling the traces?
>>
>> Can a Xenomai thread issue clock_gettime(CLOCK_MONOTONIC) ?
> 
> Yes it can, if the calls goes through the VDSO, then it mostly works.
> And once in a while deadlocks the system if a Xenomai thread waits for a
> spinlock that the Linux kernel owns and doesnt give back as said thread will
> not let the Linux Kernel run (as described above).

Ah, yes, read seqlock can be tricky in that kind of scenario indeed.

Then what we'd need is the nmi-safe monotonic clock that went into the
Linux kernel a while ago. It's called "monotonic fast", but really what
it does is to remove the need to use a read-seqlock. AFAIK it's not
exposed through the vDSO at the moment though.

Thanks,

Mathieu

> 
>>
>> AFAIK we don't have tooling to do what you describe out of the box,
>> but it could probably be implemented as a babeltrace 2 filter plugin.
> 
> There are alot ways to do that, I hoped for some standardized way.
> regards, Norbert

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
