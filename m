From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Using lttng-ust with xenomai
Date: Fri, 22 Nov 2019 14:00:05 -0500 (EST)
Message-ID: <2088324778.1063.1574449205629.JavaMail.zimbra__28890.3751106531$1574449231$gmane$org@efficios.com>
References: <CADYdroN-i9yrpd-wjPSW36GUptRV+kOCJT=Yv6+Z5sCVBmo_SQ@mail.gmail.com>
 <2012667816.853.1574437363737.JavaMail.zimbra@efficios.com>
 <4aab99be-5451-4582-f75d-7637614b1d37@siemens.com>
 <CADYdroOh+T8pOcNBW74KSMfCh--ujD8L3_G96LWR1migpsUq0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47KQjM1Cnyz1S95
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 14:00:06 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 58D12411C45
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 14:00:06 -0500 (EST)
In-Reply-To: <CADYdroOh+T8pOcNBW74KSMfCh--ujD8L3_G96LWR1migpsUq0g@mail.gmail.com>
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

----- On Nov 22, 2019, at 12:44 PM, Norbert Lange nolange79@gmail.com wrote:

> Am Fr., 22. Nov. 2019 um 16:52 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>>
>> On 22.11.19 16:42, Mathieu Desnoyers wrote:

[...]

> 
> 
>> >
>> > That's indeed a good point. I suspect membarrier may not send any IPI
>> > to Xenomai threads (that would have to be confirmed). I suspect the
>> > latency introduced by this IPI would be unwanted.
>>
>> Is an "IPI" a POSIX signal here? Or are real IPI that delivers an
>> interrupt to Linux on another CPU? The latter would still be possible,
>> but it would be delayed until all Xenomai threads on that core eventual
>> took a break (which should happen a couple of times per second under
>> normal conditions - 100% RT load is an illegal application state).
> 
> Not POSIX, some inter-thread interrupts. point is the syscall waits
> for the set of
> registered *running* Linux threads.

Just a small clarification: the PRIVATE membarrier command does not *wait*
for other threads, but it rather ensures that all other running threads
have had IPIs that issue memory barriers before it returns.

This is just a building block that can be used to speed up stuff like liburcu
and JIT memory reclaim.

[...]

>> >
>> > Another thing to make sure is to have a glibc and Linux kernel which perform
>> > clock_gettime() as vDSO for the monotonic clock, because you don't want a
>> > system call there. If that does not work for you, you can alternatively
>> > implement your own lttng-ust and lttng-modules clock plugin .so/.ko to override
>> > the clock used by lttng, and for instance use TSC directly. See for instance
>> > the lttng-ust(3) LTTNG_UST_CLOCK_PLUGIN environment variable.
>>
>> clock_gettime & Co for a Xenomai application is syscall-free as well.
> 
> Yes, and that gave me a deadlock already, if a library us not compiled
> for Xenomai,
> it will either use the syscall (and you detect that immediatly) or it
> will work most of the time,
> and lock up once in a while if a Linux thread took the "writer lock"
> of the VDSO structures
> and your high priority xenomai thread is busy waiting infinitely.
> 
> Only sane approach would be to use either the xenomai function directly,
> or recreate the function (rdtsc + interpolation on x86).
> Either compiling/patching lttng for Cobalt (which I really would not
> want to do) or using a
> clock plugin.
> If the later is supposed to be minimal, then that would mean I would
> have to get the
> interpolation factors cobalt uses (without bringing in libcobalt).
> 
> Btw. the Xenomai and Linux monotonic clocks arent synchronised at all
> AFAIK, so timestamps will
> be different to the rest of Linux.
> On my last plattform I did some tracing using internal stamp and
> regulary wrote a
> block with internal and external timestamps so those could be
> converted "offline".
> Anything similar with lttng or tools handling the traces?

Can a Xenomai thread issue clock_gettime(CLOCK_MONOTONIC) ?

AFAIK we don't have tooling to do what you describe out of the box,
but it could probably be implemented as a babeltrace 2 filter plugin.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
