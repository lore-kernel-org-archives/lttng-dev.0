From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng
Date: Fri, 3 May 2013 10:42:22 -0400
Message-ID: <20130503144221.GA32267__44398.2215867893$1367592182$gmane$org@Krystal>
References: <829CD00A1996CE4982B5200EDCE9428BFC398E@HSPMS-EXCHG01.hspg.de>
	<508018F1.4000602@efficios.com> <20121018162317.GA17795@Krystal>
	<829CD00A1996CE4982B5200EDCE9428BFC39AC@HSPMS-EXCHG01.hspg.de>
	<20121019121144.GA30479@Krystal>
	<829CD00A1996CE4982B5200EDCE9428BFC39C2@HSPMS-EXCHG01.hspg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UYHBq-0006qQ-1z
	for lttng-dev@lists.lttng.org; Fri, 03 May 2013 10:42:26 -0400
Content-Disposition: inline
In-Reply-To: <829CD00A1996CE4982B5200EDCE9428BFC39C2@HSPMS-EXCHG01.hspg.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Kubitz =?iso-8859-1?Q?J=F6rg?= <joerg.kubitz@hspg.de>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Kubitz,

Sorry for the late reply, CCing lttng-dev, since this explanation about
robustness against crash can be useful to others,

* Kubitz J=F6rg (joerg.kubitz@hspg.de) wrote:
> You use per-cpu-datastructures only to prevent cache-line-bouncing and
> not for exclusive access?

For kernel tracing, we can disable preemption (and thus migration)
around accesses to per-cpu data structures. Therefore, it prevents both
cache line bouncing and ensures that only a single CPU accesses the
per-cpu data (although an IRQ/softirq could access the same per-cpu data
concurrently).

For user-space tracing, given that we cannot cheaply disable preemption,
we only use per-cpu data to prevent cache-line bouncing.

> Then you would need to atomically write the
> whole message.

This is correct. In both cases. We need to protect against interrupts in
the kernel, and against signals and other threads in user-space.

> That cannot be done if the message is bigger than the
> bus.

It's the space reservation that needs to be performed atomically, not
writing the message. Please see:

https://lttng.org/publications
M. Desnoyers, Low-Impact Operating System Tracing Ph.D. dissertation,
=C9cole Polytechnique de Montr=E9al, 2009.

See the chapter describing the ring buffer.


> Or if you only reserve space atomically and the thread dies
> before it uses the reserved space the reader that waits for the insert
> is in deadlock.

This issue is not so relevant for kernel tracing, because we disable
preemption around use of the buffer, so only a kernel crash would cause
a thread to die between reserve and commit. But at that point, we have
bigger problems in the system than tracing.

For user-space tracing, this question is relevant, because we have to
deal with the fact that a user-space application can be killed at any
point.

There are now two tracing modes implemented in lttng-ust (user-space
tracer), each with their own advantages (+)/disadvantages(-):

1) per-pid buffer tracing,
  - each process in the system has its own per-cpu buffers,
    increased memory consumption, increased overhead for buffer
    allocation in workloads consisting of short-lived processes,
  + when a process dies, its associated wakeup pipe write-side is
    closed by the kernel, so the consumer knows it needs to read the
    last buffer. It can read it up to the last contiguous point in the
    last subbuffer where data was written (commit seq counter).

2) per-uid (shared) buffer tracing, (buffers shared across applications
   with same user ID)
  + less memory overhead, less runtime overhead for short-lived
    processes,
  - if a process dies between reserve and commit, it creates a whole in
    the subbuffer. This whole will be detected only when the producer
    will fill up the buffer and find the unbalanced reserved/commit
    counter the next time it reaches this sub-buffer. Until the buffer
    the unbalanced reserve/commit count is observed by a producer,
    the consumer is unable to read the buffer futher than the packet
    containing the "whole". When the producer rebalances this packet's
    reserve/commit count, it will be counted as a "discarded" packet,
    and we lose all data within the packet that contains the whole.

> So lttng is not robust?

It's actually a question of trade-offs: robustness (1) vs speed (2). We
provide configurations for both.

Thanks,

Mathieu

> =

> Thanks for your explanaition.
> =

> J=F6rg Kubitz

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
