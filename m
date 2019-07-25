From: Trent Piepho via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: HugePages shared memory support in LLTng
Date: Thu, 25 Jul 2019 17:59:22 +0000
Message-ID: <1564077561.2343.121.camel__20838.545686432$1564077583$gmane$org@impinj.com>
References: <CAO+PNdHdLFk=Q0L2BLGnz8xCvdgMw3aYpZuAZumBOWKraKTnAw@mail.gmail.com>
 <20190715143302.GA2017@joraj-alpa>
 <CAO+PNdHW7O98QSdWyA5U6e=gtLmdFt77wHOT=eHb-Py1W3A-oQ@mail.gmail.com>
 <CAO+PNdFotFk6uCF1dySZi9dV6PYpAazWoQpsnU+N58F2b-73FQ@mail.gmail.com>
 <20190722192308.GA803@joraj-alpa> <20190723150744.GC803@joraj-alpa>
 <CAO+PNdGhEgeTo35du4ysMcCOUQ0PKE4tuyGg593AE5feZZ4_JQ@mail.gmail.com>
 <20190723202723.GD803@joraj-alpa>
 <1962899258.11638.1564069223526.JavaMail.zimbra@efficios.com>
Reply-To: Trent Piepho <tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from us-smtp-delivery-168.mimecast.com
 (us-smtp-delivery-168.mimecast.com [63.128.21.168])
 by lists.lttng.org (Postfix) with ESMTPS id 45vg2k3XGZz1HQv
 for <lttng-dev@lists.lttng.org>; Thu, 25 Jul 2019 13:59:26 -0400 (EDT)
In-Reply-To: <1962899258.11638.1564069223526.JavaMail.zimbra@efficios.com>
Content-Language: en-US
Content-ID: <8E6FAE7143806C4E96A71866E205C2E0@namprd06.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, "guoyiteng@gmail.com" <guoyiteng@gmail.com>, "jonathan.rajotte-julien@efficios.com" <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, 2019-07-25 at 11:40 -0400, Mathieu Desnoyers wrote:
> There are a few reasons for using per-uid buffers over per-pid:
> 
> - Lower memory consumption for use-cases with many processes,
> - Faster process launch time: no need to allocate buffers for each process.
> Useful for use-cases with short-lived processes.
> - Keep a flight recorder "snapshot" available for all processes, including
> those which recently exited. Indeed, the per-pid buffers don't stay around
> for snapshot after a process exits or is killed.
> 
> There are however a few advantages for per-pid buffers:
> 
> - Isolation: if one PID generates corrupted trace data, it does not interfere
> with other PIDs buffers,
> - If one PID is killed between reserve and commit, it does not make that specific
> per-cpu ring buffer unusable for the rest of the tracing session lifetime.
> 
> Hoping this information helps making the right choice for your deployment!

We recently had this discussion for an embedded product that uses LTTng
to gather trace data during operation.  In our case, we want to have a flight recorder of the last X seconds of trace data, for the entire device.  X seconds times Y byte/sec data generation rate ends up being a very large portion (~30%) of the total memory available.  This has to be in RAM, using flash memory for this is not a good idea.

If we use per-PID buffers, then the buffer size needed for the largest
producer of trace data times the total number of processes is too
large: far larger than the device's memory size.  Some processes
produce trace data at a much higher rate than others.  A buffer for X
seconds of data on one processes ends up being a buffer for 10*X
seconds of data on another.  There's not enough RAM for 10*X second
buffers.

If we use per-UID buffers, then we must run everything as one UID. 
Which, on an embedded system, is not that bad, but negatively impacts
the security of the software.  Now all processes, which generate data
at different rates, can share one buffer.  Much more efficient that
having to reserve space the same space for the largest and smallest
producers.

But there ends up being another problem, the flight recorder data needs
to be saved to make use of.  To tmpfs in RAM, since the device's flash
is not suitable and used elsewhere anyway.  So one needs 2x the RAM,
one for the ring buffer and one for the trace data dump in tmpfs of the
ring buffer.

So what we did was not use flight recorder mode.  We configured lttng
to use a limited number of smaller trace files and trace file rotation.
 And used small ring buffers, which ended up not needing to be very
large to avoid overflow (I imagine saving the data to tmpfs is fast).

The trace files are in effect a per-session buffer, which is what we
want for greatest efficiency in space utilization.  And we can archive
those and download them when "something happens" without paying extra
cost for space.
