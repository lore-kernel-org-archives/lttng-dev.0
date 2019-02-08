From: Trent Piepho <tpiepho@gmail.com>
Subject: Manually supplying tracepoint timestamps
Date: Fri, 8 Feb 2019 11:58:18 -0800
Message-ID: <CA+7tXiiYrHVr5E=JOQaNHTSAW3awLNCtSPTei-Zz1gp7+QaoLg__11570.5403544538$1549655927$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by lists.lttng.org (Postfix) with ESMTPS id 43x5bC0rpyzgQR
 for <lttng-dev@lists.lttng.org>; Fri,  8 Feb 2019 14:58:30 -0500 (EST)
Received: by mail-qt1-x82f.google.com with SMTP id e5so5310340qtr.12
 for <lttng-dev@lists.lttng.org>; Fri, 08 Feb 2019 11:58:30 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

I've got a device that has an additional hardware, beyond the main
Linux CPU, that generates traceable events, asynchronously with
anything happening in Linux.  It would nice if these trace points
could show up in an lttng trace along with normal lttng-ust and kernel
tracepoints.

Getting the FPGA, which creates these events, to stream them over PCI
express into a DMA buffer that is then parsed in Linux userspace to
turn the trace data stream into lttng-ust events, while complex, is
relatively straightforward.

But these events will be time stamped with the time they are receive
and converted to trace points.  They should be time stamped with the
time they were originally generated in the FPGA.  Of course we thought
of that, and the trace data has timestamps in it.  Converting these
timestamps into one that sync with CLOCK_MONOTONIC is actually a very
complex problem, since the FPGA and CPU are in entirely separate clock
domains, so the offset between them is not constant, nor is the rate
of drift of that offset constant!  But let's not worry about that and
assume we can get appropriate timestamps.

This gets to the issue with lttng-ust.  I don't see any way to specify
a timestamp when creating a trace event.  lttng will always call a
clock function internally to create a timestamp at the time the event
is added to the ring buffer.

The best I could come up with, would be to make a custom clock that
returns fake timestamps preloaded into it before the event is
generated.  Something like:

uint64_t fake_timestamp;
uint64_t fake_clock_read64(void)
{  return fake_timestamp; }

/* setup an override clock that uses fake_clock_read64 goes here */
/* generate a tracepoint with a manual timestamp */
fake_timestamp = 12345;
tracepoint(sample_tracepoint, message,  "Hello World\n");

This seems like somewhat of a kludge.  And I'm also concerned that
lttng be unhappy with how this clock behaves.  I.e., will getting the
same value if multiple calls are done trigger the timestamp wraparound
logic?  Am I assured that lttng-ust will read the clock before the
tracepoint(), etc. call returns?
