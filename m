From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Using lttng-ust with xenomai
Date: Fri, 22 Nov 2019 12:01:18 -0500 (EST)
Message-ID: <480743920.929.1574442078799.JavaMail.zimbra__19207.8374837124$1574442102$gmane$org@efficios.com>
References: <CADYdroN-i9yrpd-wjPSW36GUptRV+kOCJT=Yv6+Z5sCVBmo_SQ@mail.gmail.com>
 <2012667816.853.1574437363737.JavaMail.zimbra@efficios.com>
 <4aab99be-5451-4582-f75d-7637614b1d37@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47KN4K1x1yz1RtH
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 12:01:21 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id A4F023A631F
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 12:01:19 -0500 (EST)
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

----- On Nov 22, 2019, at 10:52 AM, Jan Kiszka jan.kiszka@siemens.com wrote:

> On 22.11.19 16:42, Mathieu Desnoyers wrote:
>> ----- On Nov 22, 2019, at 4:14 AM, Norbert Lange nolange79@gmail.com wrote:
>> 
>>> Hello,
>>>
>>> I already started a thread over at xenomai.org [1], but I guess its
>>> more efficient to ask here aswell.
>>> The basic concept is that xenomai thread run *below* Linux (threads
>>> and irg handlers), which means that xenomai threads must not use any
>> 
>> I guess you mean "irq handlers" here.
>> 
>>> linux services like the futex syscall or socket communication.
>>>
>>> ## tracepoints
>>>
>>> expecting that tracepoints are the only thing that should be used from
>>> the xenomai threads, is there anything using linux services.
>>> the "bulletproof" urcu apparently does not need anything for the
>>> reader lock (aslong as the thread is already registered),
>> 
>> Indeed the first time the urcu-bp read-lock is encountered by a thread,
>> the thread registration is performed, which requires locks, memory allocation,
>> and so on. After that, the thread can use urcu-bp read-side lock without
>> requiring any system call.
> 
> So, we will probably want to perform such a registration unconditionally
> (in case lttng usage is enabled) for our RT threads during their setup.

Yes. I'm currently doing a slight update to liburcu master branch to
allow urcu_bp_register_thread() calls to invoke urcu_bp_register() if
the thread is not registered yet. This seems more expected than implementing
urcu_bp_register_thread() as a no-op.

If you care about older liburcu versions, you will want to stick to use
rcu read lock/unlock pairs or rcu_read_ongoing to initialize urcu-bp, but
with future liburcu versions, urcu_bp_register_thread() will be another
option. See:

commit 5b46e39d0e4d2592853c7bfc11add02b1101c04b
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Nov 22 11:02:36 2019 -0500

    urcu-bp: perform thread registration on urcu_bp_register_thread

> 
>> 
>>> but I dont know how the write-buffers are prepared.
>> 
>> LTTng-UST prepares the ring buffers from lttng-ust's "listener" thread,
>> which is injected into the process by a lttng-ust constructor.
>> 
>> What you will care about is how the tracepoint call-site (within a Xenomai
>> thread) interacts with the ring buffers.
>> 
>> The "default" setup for lttng-ust ring buffers is not suitable for Xenomai
>> threads. The lttng-ust ring buffer is split into sub-buffers, each sub-buffer
>> corresponding to a CTF trace "packet". When a sub-buffer is filled, lttng-ust
>> invokes "write(2)" to a pipe to let the consumer daemon know there is data
>> available in that ring buffer. You will want to get rid of that write(2) system
>> call from a Xenomai thread.
>> 
>> The proper configuration is to use lttng-enable-channel(1) "--read-timer"
>> option (see https://lttng.org/docs/v2.11/#doc-channel-read-timer). This will
>> ensure that the consumer daemon uses a polling approach to check periodically
>> whether data needs to be consumed within each buffer, thus removing the
>> use of the write(2) system call on the application-side.
>> 
>>>
>>> You can call linux sycalls from xenomai threads (it will switch to the
>>> linux shadow thread for that and lose realtime characteristics), so a
>>> one time setup/shutdown like registering the threads is not an issue.
>> 
>> OK, good, so you can actually do the initial setup when launching the thread.
>> You need to remember to invoke use a liburcu-bp read-side lock/unlock pair,
>> or call urcu_bp_read_ongoing() at thread startup within that initialization
>> phase to ensure urcu-bp registration has been performed.
>> 
>>>
>>> ## membarrier syscall
>>>
>>> I haven't got an explanation yet, but I believe this syscall does
>>> nothing to xenomai threads (each has a shadow linux thread, that is
>>> *idle* when the xenomai thread is active).
>> 
>> That's indeed a good point. I suspect membarrier may not send any IPI
>> to Xenomai threads (that would have to be confirmed). I suspect the
>> latency introduced by this IPI would be unwanted.
> 
> Is an "IPI" a POSIX signal here? Or are real IPI that delivers an
> interrupt to Linux on another CPU? The latter would still be possible,
> but it would be delayed until all Xenomai threads on that core eventual
> took a break (which should happen a couple of times per second under
> normal conditions - 100% RT load is an illegal application state).

I'm talking about a real in-kernel IPI (as in inter-processor interrupt).
However, the way sys_membarrier detects which CPUs should receive that IPI
is by iterating on all cpu runqueues, and figure out which CPU is currently
running a thread which uses the same mm as the sys_membarrier caller
(for the PRIVATE membarrier commands).

So I suspect that the Xenomai thread is really not within the Linux scheduler
runqueue when it runs.

> 
>> 
>>> liburcu has configure options allow forcing the usage of this syscall
>>> but not disabling it, which likely is necessary for Xenomai.
>> 
>> I suspect what you'd need there is a way to allow a process to tell
>> liburcu-bp (or liburcu) to always use the fall-back mechanism which does
>> not rely on sys_membarrier. This could be allowed before the first use of
>> the library. I think extending the liburcu APIs to allow this should be
>> straightforward enough. This approach would be more flexible than requiring
>> liburcu to be specialized at configure time. This new API would return an error
>> if invoked with a liburcu library compiled with
>> --disable-sys-membarrier-fallback.
>> 
>> If you have control over your entire system's kernel, you may want to try
>> just configuring the kernel within CONFIG_MEMBARRIER=n in the meantime.
>> 
>> Another thing to make sure is to have a glibc and Linux kernel which perform
>> clock_gettime() as vDSO for the monotonic clock, because you don't want a
>> system call there. If that does not work for you, you can alternatively
>> implement your own lttng-ust and lttng-modules clock plugin .so/.ko to override
>> the clock used by lttng, and for instance use TSC directly. See for instance
>> the lttng-ust(3) LTTNG_UST_CLOCK_PLUGIN environment variable.
> 
> clock_gettime & Co for a Xenomai application is syscall-free as well.

Very good then!

Thanks,

Mathieu

> 
> Thanks,
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
