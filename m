From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: some questions on lttng
Date: Mon, 23 Jul 2012 10:13:31 -0400
Message-ID: <20120723141331.GA1932__1465.85516999966$1343052869$gmane$org@Krystal>
References: <4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0741@MX28A.corp.emc.com>
	<4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0805@MX28A.corp.emc.com>
	<20120720172618.GA19112@Krystal>
	<4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF08D3@MX28A.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1StJO9-0004wZ-29
	for lttng-dev@lists.lttng.org; Mon, 23 Jul 2012 10:13:33 -0400
Content-Disposition: inline
In-Reply-To: <4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF08D3@MX28A.corp.emc.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Bingfeng.Zhao@emc.com
Cc: tglx@linutronix.de, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Bingfeng.Zhao@emc.com (Bingfeng.Zhao@emc.com) wrote:
> 
> 
> > -----Original Message-----
> > From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> > Sent: Saturday, July 21, 2012 1:26 AM
> > To: Zhao, Bingfeng; tglx@linutronix.de
> > Cc: lttng-dev@lists.lttng.org
> > Subject: Re: [lttng-dev] some questions on lttng
> > 
> > * Bingfeng.Zhao@emc.com (Bingfeng.Zhao@emc.com) wrote:
> > > Anyone can answer our questions? Mathieu?
> > 
> > sorry for the slow reply, I've been swamped in filtering implementation lately,
> > 
> > >
> > > From: Bingfeng.Zhao@emc.com [mailto:Bingfeng.Zhao@emc.com]
> > > Sent: Wednesday, July 18, 2012 5:54 PM
> > > To: lttng-dev@lists.lttng.org
> > > Subject: [lttng-dev] some questions on lttng
> > >
> > > Hello the dev list,
> > > We encounter some basic questions when try to adapt the LTTNG in our poject.
> > >
> > > 1.   When the trace is enabled and all are well configurated, we get
> > > trace messages collected under the session folder. The question is
> > > whether it is possible that some traces will lost when the trace
> > > messages are huge. How will LTTNG do if the consumer deamon cannot
> > > fast enough to copy the trace message from trace buffer?
> > 
> > There are currently two ways to configure the channels: discard and overwrite
> > mode.
> > 
> > In discard mode, upon buffer full condition, events are discarded, and we keep
> > track of the number of events discarded in the packet headers, so the trace viewer
> > can print warnings about discarded events within a specific time-frame.
> > 
> > In overwrite mode, upon buffer full condition, the oldest subbuffer
> > (packet) is overwritten. We will soon add a sequence counter to the packet header,
> > so the trace viewer can show when a packet is missing in the stream (either due to
> > being overwritten by the tracer or due to UDP packet loss in network streaming).
> > 
> > If the message (event) is too large to fit within a packet, it is discarded,
> > incrementing the event discarded counter accordingly (so the viewer can show this
> > information from the packet header).
> > 
> > It would be interesting to implement a "blocking" mode that makes the application
> > block if buffer is full. This makes the tracer much more intrusive, and if something
> > goes wrong in the session daemon or consumer daemon, the app hangs, but it
> > might be interesting for logging purposes, if you care about _never_ losing an
> > event. I would recommend to use this kind of feature in debugging setups, not in
> > production, at the beginning, since it would make the sessiond/consumerd critical
> > (if they die, the application hangs. I don't want to see this happen in production).
> > 
> Thanks for the explanation, I got you point. However I'm at a
> different scenario.  Normally the trace is off by default, that is
> there is no session created and started.  The trace call definitely
> should not block anything. Ideally it should not trigger at all and I
> believe that is what lttng does now.

Indeed.

> 
> If I find something wrong, I would like enable the trace at once and
> try to figure out what happen.

Yes, but it would be a shame if the tracer, when enabled to diagnose
the issue you are encountering, modify the system behavior too much
(e.g. by blocking the application), and thus makes the problem disappear
under tracing, or worse, triggers other problems.

> At this time, (possible) lost event
> will make the trouble shooting much difficult (example for those rare
> race condition issues) as you cannot reason about what you collected
> if there are some messages lost. So all the meaning of static trace
> may lost and such scenario is not rare in production.

The LTTng kernel and UST tracers provide information about events
discarded in the packet headers which help the user understand where the
events have been dropped, and what to do about it (increase their buffer
size for the next time they trace this workload). That should be
sufficient to reproduce issues with a fixed, preallocated amount of
resources, without changing the behavior of the traced system too much
(without blocking). I think minimizing the impact of a running tracer
(no blocking, no system slowdown, no possible application hang due to
tracer bug) outweight the downside of having to gather another run
of trace for the rare cases where events were discarded.

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
